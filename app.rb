require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models'

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "sqlite3:db/development.db")

enable :sessions

month = {"Janualy" => "1", "February" => "2", "March" => "3", "April" => "4", "May" => "5", "June" => "6", "July" => "7", "Augast" => "8", "September" => "9", "October" => "10", "November" => "11", "December" => "12"}

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

get '/' do
  @parent_task = Parent_Task.where(user: session[:user]).order(:update_rank).reverse
	erb :index
end

get '/search' do

	erb :search
end

post '/signin' do
	user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
          session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
	@user = User.create({
    email: params[:email],
    password: params[:password],
    password_confirmation: params[:password_password_confirmation]
    })

  if @user.persisted?
    session[:user] = @user.id
  end

  redirect '/'
end

get '/signout' do
	session[:user] = nil
	redirect '/'
end

post '/create_parent_task' do
	name = params[:name]
	exit_task = Parent_Task.where("name = ? AND user = ?", name, session[:user]).exists?
	if name.length < 1 then
		session[:querry_error] = "文字を入力してください"
	elsif name.length > 30 then
		session[:querry_error] = "30文字以内で入力してください"
	elsif exit_task then
		session[:querry_error] = "同名のタスクが存在します"
	else
		session[:querry_error] = nil
		session[:result] = "新しいTodoリストが作成されました。"
		Parent_Task.create({
			name: name,
			user: session[:user]
			})
	end
			redirect '/'
end

get '/edit/:id' do
	@task_id = params[:id]
	session[:result] = nil
	@p_task  = Parent_Task.find_by(id: params[:id])
	@task = Child_Task.where(pid: params[:id]).order(:deadline)
	erb :edit
end

post '/create_child_task/:id' do
	name = params[:name]
	exit_task = Child_Task.where(name: name, pid: params[:id]).exists?
	if name.length < 1 then
		session[:c_querry_error] = "文字を入力してください"
	elsif name.length > 30 then
		session[:c_querry_error] = "30文字以内で入力してください"
	elsif exit_task then
		session[:c_querry_error] = "同名のタスクが存在します"
	else
		session[:c_querry_error] = nil
		task_count = Parent_Task.find_by(id: params[:id]).total_task
		update_total_task = task_count + 1
		p_task = Parent_Task.find_by(id: params[:id])
    rank = Parent_Task.where(user: session[:user]).maximum(:update_rank)
		deadline = params[:deadline].split(" ")
    if params[:deadline] == "" then
       session[:c_querry_error] = "期限を入力してください"
    else
    session[:c_querry_error] = nil
    str_d =  deadline[2] <<  "-" << month[deadline[1][0, deadline[1].length - 1]] << "-" <<deadline[0]
		Child_Task.create({
		name: name,
		pid: params[:id],
		deadline: str_d,
		p_name: p_task.name
		})
    c_task = Child_Task.where(pid: params[:id]).where(check: 0).order(:deadline).first
    p_task.update({
			total_task: update_total_task,
      current_deadline: c_task.deadline,
      update_rank: rank + 1
		})
    end
	end
	redirect '/edit/' << params[:id]
end

post '/check/:id' do
	check_status = Child_Task.find_by(id: params[:id])
  c_pid = check_status.pid
	check_status.update({
		check: 1
		})

  c_task = Child_Task.where(pid: c_pid).where(check: 0).order(:deadline).first
  p_task = Parent_Task.find_by(id: c_pid)
	p_task.update({
		completed_task: p_task.completed_task + 1,
    current_deadline: c_task.deadline
	})
	redirect '/edit/' << check_status.pid
end
post '/not_check/:id' do
	check_status = Child_Task.find_by(id: params[:id])
  c_pid = check_status.pid
	check_status.update({
		check: 0
		})
    c_task = Child_Task.where(pid: c_pid).where(check: 0).order(:deadline).first
	p_task = Parent_Task.find_by(id: c_pid)
	p_task.update({
		completed_task: p_task.completed_task - 1,
    current_deadline: c_task.deadline
		})
	redirect '/edit/' << check_status.pid

end


post '/search' do
	query = params[:query]
	if query != "" then
	p_task = Parent_Task.name_like(query)
	c_task = Child_Task.name_like(query)
	res = {
		"p_task": p_task,
		"c_task": c_task
	}
	res.to_json
	end
end

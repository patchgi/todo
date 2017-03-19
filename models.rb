ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
class User < ActiveRecord::Base
	  has_secure_password
end
class Parent_Task < ActiveRecord::Base
	scope :name_like, -> name {
    where('name like ?', "%#{name}%") if name.present?
  }
end
class Child_Task < ActiveRecord::Base
	scope :name_like, -> name {
    where('name like ?', "%#{name}%") if name.present?
  }
end

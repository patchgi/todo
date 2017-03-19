window.addEventListener("DOMContentLoaded", function() {
  var $query = document.getElementById("query")
  var $search = document.getElementById("search")

  //リアルタイム検索機能
  $query.addEventListener("keyup", function() {
    var query = $query.value
    $.ajax({
      type: "POST",
      url: "/search",
      data: {
        "query": query
      }
    }).done(function(data) {
      var $child = document.getElementById("child")
      var $parent = document.getElementById("parent")
      var $c_result= document.getElementById("c_result")
      var $p_result= document.getElementById("p_result")
      var data = JSON.parse(data)
      var c_tasks = data["c_task"]
      var p_tasks = data["p_task"]
      var c_tasks_length = Object.keys(c_tasks).length
      var p_tasks_length = Object.keys(p_tasks).length
      var $child_list = ""
      var $parent_list = ""
      var $child_r = ""
      var $parent_r = ""
      if (c_tasks_length == 0){
        $child_r = "対象のTodoは見つかりません"
      }
      else{
        $child_r = "Todoが" +c_tasks_length+ "件見つかりました"
      }
      if (p_tasks_length == 0){
        $parent_r = "対象のTodoリストは見つかりません"
      }
      else{
        $parent_r = "Todoリストが" +p_tasks_length+ "件見つかりました"
      }
      for(i in c_tasks){
        data_dead = String(c_tasks[i].deadline).split("-")
        year_dead = data_dead[0]
        month_dead = ("00" + parseInt(data_dead[1])).slice(-2)
        day_dead = ("00" + parseInt(data_dead[2])).slice(-2)
        deadline = year_dead + "年" + month_dead + "月" + day_dead + "日"
        data_create = String(c_tasks[i].created_at).substr(0, 10).split("-")
        year_create = data_create[0]
        month_create = data_create[1]
        day_create = data_create[2]
        created_at = year_create + "年" + month_create + "月" + day_create + "日"
        $child_list += "<div class='row'><div class='col s12 m6'><div class='card grey lighten-3'><div class='card-content black-text'><span class='card-title'><a href='/edit/"+c_tasks[i].pid+"'>"+c_tasks[i].name+"</a></span><p class='s_deadline'>期限:"+deadline+"</p><p>リスト名:"+c_tasks[i].p_name+"<span class='s_created_at_c'>作成日:"+created_at
      +"</span></p></div></div></div></div>"


      }
      for(j in p_tasks){
          $parent_list += "<div class='row'><div class='col s12 m6'><div class='card grey lighten-3'><div class='card-content black-text'><span class='card-title'><a href='/edit/"+p_tasks[j].id+"'>"+p_tasks[j].name+"</a></span></div></div></div></div>"
      }

      $child.innerHTML = $child_list
      $parent.innerHTML = $parent_list
      $c_result.innerHTML = $child_r
      $p_result.innerHTML = $parent_r


    }).fail(function(data) {})
  })
  $search.addEventListener("click", function() {
    var query = document.getElementById("query").value
    $.ajax({
      type: "POST",
      url: "/search",
      data: {
        "query": query
      }
    }).done(function(data) {
      var $child = document.getElementById("child")
      var $parent = document.getElementById("parent")
      var $c_result= document.getElementById("c_result")
      var $p_result= document.getElementById("p_result")
      var data = JSON.parse(data)
      var c_tasks = data["c_task"]
      var p_tasks = data["p_task"]
      var c_tasks_length = Object.keys(c_tasks).length
      var p_tasks_length = Object.keys(p_tasks).length
      var $child_list = ""
      var $parent_list = ""
      var $child_r = ""
      var $parent_r = ""
      if (c_tasks_length == 0){
        $child_r = "対象のTodoは見つかりません"
      }
      else{
        $child_r = "Todoが" +c_tasks_length+ "件見つかりました"
      }
      if (p_tasks_length == 0){
        $parent_r = "対象のTodoリストは見つかりません"
      }
      else{
        $parent_r = "Todoリストが" +p_tasks_length+ "件見つかりました"
      }
      for(i in c_tasks){
        data_dead = String(c_tasks[i].deadline).split("-")
        year_dead = data_dead[0]
        month_dead = ("00" + parseInt(data_dead[1])).slice(-2)
        day_dead = ("00" + parseInt(data_dead[2])).slice(-2)
        deadline = year_dead + "年" + month_dead + "月" + day_dead + "日"
        data_create = String(c_tasks[i].created_at).substr(0, 10).split("-")
        year_create = data_create[0]
        month_create = data_create[1]
        day_create = data_create[2]
        created_at = year_create + "年" + month_create + "月" + day_create + "日"
        $child_list += "<div class='row'><div class='col s12 m6'><div class='card grey lighten-3'><div class='card-content black-text'><span class='card-title'><a href='/edit/"+c_tasks[i].pid+"'>"+c_tasks[i].name+"</a></span><p class='s_deadline'>期限:"+deadline+"</p><p>リスト名:"+c_tasks[i].p_name+"<span class='s_created_at_c'>作成日:"+created_at
  +"</span></p></div></div></div></div>"


      }
      for(j in p_tasks){
          $parent_list += "<div class='row'><div class='col s12 m6'><div class='card grey lighten-3'><div class='card-content black-text'><span class='card-title'><a href='/edit/"+p_tasks[j].id+"'>"+p_tasks[j].name+"</a></span></div></div></div></div>"
      }

      $child.innerHTML = $child_list
      $parent.innerHTML = $parent_list
      $c_result.innerHTML = $child_r
      $p_result.innerHTML = $parent_r


    }).fail(function(data) {})
  })
})

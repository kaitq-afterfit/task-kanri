$(function () {
  $("#todo-tasks-list").sortable({
    connectWith: ["#doing-tasks-list", "#done-tasks-list"],
    over: function (event, ui) {
      //triggered when sortable element hovers sortable list
      $("#todo").css("background-color", "rgba(0,0,0,.1)");
    },
    out: function (event, ui) {
      //event is triggered when a sortable item is moved away from a sortable list.
      $("#todo").css("background-color", "rgba(0,0,0,.0)");
    },
    receive: function (event, ui) {
      $("#todo").css("background-color", "rgba(0,0,0,.0)");
      task_id = $(ui.item).find(".t_id").val();
      task_destination_status = $(ui.item).parents(".tasks-list-body").attr("id");
      params = { t_id: task_id, t_des_status: task_destination_status };
      $.ajax({
        url: "/tasks/change_status",
        method: "PATCH",
        data: $.param({
          t_id: task_id,
          t_des_status: task_destination_status,
        }),
        beforeSend: function(xhr) {
          xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'))
        },
        success: function() {
          $("#task-" + task_id + "-status-content").text(task_destination_status);
        },
        error: function(xhr, status, err) {
          console.error(status, err.toString());
        }
      });
    },
    revert: 100,
    start: function (event, ui) {
      //event is triggered when sorting starts.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(4deg)");
    },
    stop: function (event, ui) {
      //event is triggered when sorting has stopped.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(0deg)");
    },
  });
});

$(function () {
  $("#doing-tasks-list").sortable({
    connectWith: ["#todo-tasks-list", "#done-tasks-list"],
    over: function (event, ui) {
      //triggered when sortable element hovers sortable list
      $("#doing").css("background-color", "rgba(0,0,0,.1)");
    },
    out: function (event, ui) {
      //event is triggered when a sortable item is moved away from a sortable list.
      $("#doing").css("background-color", "rgba(0,0,0,.0)");
    },
    receive: function (event, ui) {
      // event is triggered when an item from a connected sortable list has been dropped into another list
      $("#doing").css("background-color", "rgba(0,0,0,.0)");
      task_id = $(ui.item).find(".t_id").val();
      task_destination_status = $(ui.item).parents(".tasks-list-body").attr("id");
      params = { t_id: task_id, t_des_status: task_destination_status };
      $.ajax({
        url: "/tasks/change_status",
        method: "PATCH",
        data: $.param({
          t_id: task_id,
          t_des_status: task_destination_status,
        }),
        beforeSend: function(xhr) {
          xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'))
        },
        success: function() {
          $("#task-" + task_id + "-status-content").text(task_destination_status);
        },
        error: function(xhr, status, err) {
          console.error(status, err.toString());
        }
      });
    },
    revert: 100,
    start: function (event, ui) {
      //event is triggered when sorting starts.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(4deg)");
    },
    stop: function (event, ui) {
      //event is triggered when sorting has stopped.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(0deg)");
    },
  });
});

$(function () {
  $("#done-tasks-list").sortable({
    connectWith: ["#todo-tasks-list", "#doing-tasks-list"],
    over: function (event, ui) {
      //triggered when sortable element hovers sortable list
      $("#done").css("background-color", "rgba(0,0,0,.1)");
    },
    out: function (event, ui) {
      //event is triggered when a sortable item is moved away from a sortable list.
      $("#done").css("background-color", "rgba(0,0,0,.0)");
    },
    receive: function (event, ui) {
      // event is triggered when an item from a connected sortable list has been dropped into another list
      $("#done").css("background-color", "rgba(0,0,0,.0)");
      task_id = $(ui.item).find(".t_id").val();
      task_destination_status = $(ui.item).parents(".tasks-list-body").attr("id");
      params = { t_id: task_id, t_des_status: task_destination_status };
      $.ajax({
        url: "/tasks/change_status",
        method: "PATCH",
        data: $.param({
          t_id: task_id,
          t_des_status: task_destination_status,
        }),
        beforeSend: function(xhr) {
          xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'))
        },
        success: function(data) {
          $("#task-" + task_id + "-status-content").text(task_destination_status);
        },
        error: function(xhr, status, err) {
          console.error(status, err.toString());
        }
      });
    },
    revert: 100,
    start: function (event, ui) {
      //event is triggered when sorting starts.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(4deg)");
    },
    stop: function (event, ui) {
      //event is triggered when sorting has stopped.
      var elementId = ui.item[0].firstChild.id;
      $("#" + elementId).css("transform", "rotate(0deg)");
    },
  });
});

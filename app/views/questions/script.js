const todos = document.querySelectorAll(".draggable-question");
const all_status = document.querySelectorAll(".status");
let dragabbleTodo = null;
let selected_questions = JSON.parse(window.localStorage.getItem("questions"));

//adding functionality to selected questions
const selectedBox = document.querySelector(".selected");
const deleteIcons = selectedBox.querySelectorAll(".close");

if (selected_questions == null) {
  selected_questions = new Array();
} else {
  // populate selected questions from local storage
  selected_questions.forEach((question) => {
    var div = document.createElement("p");
    div.className = "list-group-item draggable-question draggable-text";
    div.draggable = "true";
    var p = document.createElement("td");
    p.className = "title";
    p.innerHTML = question;
    div.append(p);
    var deleteIcon = "<span class='close' style='display:none'>&times;</span>";
    div.insertAdjacentHTML("beforeend", deleteIcon);
    selectedBox.append(div);
  });
}

deleteIcons.forEach((btn) => {
  btn.style.display = "";
});

//removing delete from non-selected questions
const unselectedBox = document.querySelector(".unselected");
const unSelectedDeleteIcons = unselectedBox.querySelectorAll(".close");

unSelectedDeleteIcons.forEach((btn) => {
  btn.style.display = "none";
});

todos.forEach((todo) => {
  todo.addEventListener("dragstart", dragStart);
  todo.addEventListener("dragend", dragEnd);
});

function dragStart() {
  dragabbleTodo = this;
  console.log("dragstart");
}

function dragEnd() {
  dragabbleTodo = null;

  //const selectedBox = this.querySelector(".selected");
  const deleteIcons = this.querySelectorAll(".close");

  deleteIcons.forEach((btn) => {
    btn.style.display = "";
  });

  //updating local storage
  question_title = this.getElementsByClassName("title")[0].innerHTML;
  console.log(question_title);
  //alert(question_title);
  selected_questions.push(question_title);
  localStorage.setItem("questions", JSON.stringify(selected_questions));
  //var meta1 = JSON.parse(window.localStorage.getItem("questions"));
  //alert(meta1);
  console.log(selected_questions);
  console.log("dragEnd");
}

all_status.forEach((status) => {
  status.addEventListener("dragover", dragOver);
  status.addEventListener("dragenter", dragEnter);
  status.addEventListener("dragleave", dragLeave);
  status.addEventListener("drop", dragDrop);
});

//for the targets only, not the draggables.

function dragOver(e) {
  e.preventDefault();
  //console.log("dragOver");
}

function dragEnter() {
  console.log("dragenter");
}

function dragLeave() {
  console.log("dragleave");
}

function dragDrop() {
  this.appendChild(dragabbleTodo);
  console.log("dropped");
}

/* deleting */
const close_btns = document.querySelectorAll(".close");

close_btns.forEach((btn) => {
  btn.addEventListener("click", () => {
    btn.parentElement.style.display = "none";

    //delete from localstorage
    question_title =
      btn.parentElement.getElementsByClassName("title")[0].innerHTML;
    //alert(question_title);
    const index = selected_questions.indexOf(question_title);
    console.log(index);
    //remove from array, and local storage
    selected_questions.splice(index, 1);
    //delete selected_questions[index];
    localStorage.removeItem("questions");
    localStorage.setItem("questions", JSON.stringify(selected_questions));
    //var meta1 = JSON.parse(window.localStorage.getItem("questions"));
    alert(selected_questions);
    console.log(selected_questions);
    console.log("dragEnd");
  });
});

var questions_zone = file[id]["questions"];
console.log(questions_zone);
questions_zone.forEach((question) => {
  // Create the div element
  var newDiv = $("<div>")
    .addClass("list-group-item draggable-question draggable-text")
    .attr("draggable", "true")
    .css("display", "flex")
    .css("justify-content", "space-between");

  // Create the title cell and add it to the div
  var titleCell = $("<td>").addClass("title").text(question);
  newDiv.append(titleCell);

  // Create the elements div and add it to the div
  var elementsDiv = $("<div>").addClass("elements").css("display", "flex");

  newDiv.append(elementsDiv);

  // Create the label and add it to the elements div
  var label = $("<label>")
    .addClass("pts-txt")
    .attr("for", "form-control")
    .text("Pts")
    .css("display", "inline");
  elementsDiv.append(label);

  // Create the points input and add it to the elements div
  var pointsInput = $("<input>")
    .addClass("points form-control col-md-5 mb-1")
    .attr("type", "text")
    .attr("name", "assessment_credit")
    .attr("placeholder", "0")
    .attr("size", 2);
  $(elementsDiv).append(pointsInput);

  // Create the close button and add it to the elements div
  var closeButton = $("<span>").addClass("close deleteq").html("&times;");
  elementsDiv.append(closeButton);

  $(newZone).append(newDiv);
});

//container_id = $(container).parent().attr('id');
$(this).parent().parent().remove();
//question_title = $(this).parent().parent().find(".title").text();
//const index = file[container_id]["questions"].indexOf(question_title);
//console.log(index);
//file[container_id]["questions"].splice(index, 1);
// localStorage.removeItem("file");
// localStorage.setItem("file", JSON.stringify(file));

$(".deleteq").click(function () {
  container_id = $(this).parent().parent().parent().parent().attr("id");
  $(this).parent().parent().remove();
  question_title = $(this).parent().parent().find(".title").text();
  console.log(question_title);
  const index = file[container_id]["questions"].indexOf(question_title);
  console.log(index);
  file[container_id]["questions"].splice(index, 1);
  localStorage.removeItem("file");
  localStorage.setItem("file", JSON.stringify(file));
});

$(close).click(function () {
  $(close).parent().parent().remove();
  question_title = $(item).text();
  question_title = question_title.slice(0, question_title.length - 67);
  question_title = question_title.slice(9);
  console.log(question_title);
  const index = file[container_id]["questions"].indexOf(question_title);
  console.log(index);
  console.log(container_id);
  file[container_id]["questions"].splice(index);
  localStorage.removeItem("file");
  localStorage.setItem("file", JSON.stringify(file));
});

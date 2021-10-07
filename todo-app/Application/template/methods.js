


    var globalid = 0;

    function deleterecord() {
        id = this.id;
        var xhr = new XMLHttpRequest();
        delete_url = "http://34.131.185.60:5000/task/" + id;
        console.log(delete_url)
        xhr.open('DELETE', delete_url, true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
        console.log(xhr);
        xhr.onload = function () {
            if (xhr.status >= 200 && xhr.status < 400) {
                location.reload();


            }
            else {
                console.log("error");
            }
        }

        xhr.send();
    }
    function updatetask() {


        var newdata = {};
        newdata['id'] = globalid;
        newdata['name'] = document.getElementById("name").value;
        newdata['status'] = document.getElementById('status').value;
        newdata['expiryDate'] = document.getElementById('datetime').value + ":00Z";
        var xhr = new XMLHttpRequest();
        update_url = "http://34.131.185.60:5000/task/" + globalid;
        xhr.open('PUT', update_url, true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
        var jsondata = JSON.stringify(newdata);
        xhr.onload = function () {
            if (xhr.status >= 200 && xhr.status < 400) {


                location.reload();
            }
            else {
                console.log("error");
            }

        }
        xhr.send(jsondata);
    }

    function createtask() {


        var newdata = {};
        newdata['name'] = document.getElementById("name1").value;
        newdata['status'] = document.getElementById('status1').value;
        newdata['expiryDate'] = document.getElementById('datetime1').value + ":00Z";
        console.log(newdata);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', "http://34.131.185.60:5000/task", true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
        var jsondata = JSON.stringify(newdata);
        console.log(xhr)
        console.log(jsondata)
        xhr.onload = function () {
            if (xhr.status >= 200 && xhr.status < 400) {


                location.reload();
            }
            else {
                console.log("error");
            }
        }
        xhr.send(jsondata);
    }



    function createpoptask() {
        document.getElementById('update1').style.display = "block";

    }
    function cancelpopup() {
        document.getElementById('update1').style.display = "none";
    }


    function updaterecord() {

        document.getElementById('update').style.display = "block";
        globalid = this.id;
        document.getElementById("name").value = this.name;
        document.getElementById("status").value = this.status;
        document.getElementById("datetime").value = this.expiryDate.substring(0, 16);

    }


    function tableInsert(row) {
        var table = document.getElementById("mytable");
        var onerow = table.insertRow(0);
        let name = onerow.insertCell(0);
        let expdate = onerow.insertCell(1);
        let status = onerow.insertCell(2);
        let update = onerow.insertCell(3);
        let del = onerow.insertCell(4);
        name.innerHTML = row['name'];
        console.log(name);
        expdate.innerHTML = row['expiryDate'].substring(0, 10);
        status.innerHTML = row['status'];
        let anchortag_for_delete = document.createElement("input");
        anchortag_for_delete.type = "button";
        anchortag_for_delete.value = "DELETE";
        anchortag_for_delete.id = row['id'];
        anchortag_for_delete.onclick = deleterecord;
        anchortag_for_delete.className = "btn btn-danger";
        del.appendChild(anchortag_for_delete);
        let anchortag_for_update = document.createElement("input");
        anchortag_for_update.type = "button";
        anchortag_for_update.value = "EDIT";
        anchortag_for_update.id = row['id'];
        anchortag_for_update.name = row['name'];
        anchortag_for_update.status = row['status'];
        anchortag_for_update.expiryDate = row['expiryDate'];
        anchortag_for_update.onclick = updaterecord;
        anchortag_for_update.className = "btn btn-success";
        update.appendChild(anchortag_for_update);



    }

    let promise = new Promise(function (resolve, reject) {

        var xhr = new XMLHttpRequest();

        xhr.open('GET', " http://34.131.185.60:5000/task", true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');

        console.log(xhr);
        xhr.send();
        xhr.onload = function () {
            var data = JSON.parse(xhr.responseText)
            console.log(data)
            if (xhr.status >= 200 && xhr.status < 400) {

                resolve(data)
            }
            else {

                reject("Error occured")
            }
        }

    })

    promise.then(

        function (data) {

            if (data.length === 0) {
                document.getElementById("noelements").innerText = "No Tasks currently"
            }

            else {
                for (var key in data) {
                    console.log(data[key])
                    tableInsert(data[key])
                }

            }

        },
        function (error) {

            document.getElementById("noelements").innerText = "ERROR OCCURED"
        }

    );



    function canceltask() {

        document.getElementById('update').style.display = "none";
    }

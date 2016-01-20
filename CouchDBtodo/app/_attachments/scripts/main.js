
function buildOutput(){

    $('#output').empty();
    var html = '<table class="table table-hover">';
    $.ajax({
        type : 'GET',
        url : '../../_all_docs?include_docs=true',
        async : true,
        success : function(data){
            var arr = JSON.parse(data).rows;

            for(var i = 0; i < arr.length; i++){

                if (arr[i].id.indexOf('_design') == -1){
                    var doc = arr[i].doc;
                    html += '<tr><td>' + doc.ingavedatum + '</td><td>' + doc.einddatum
                            + '</td><td>' + doc.prioriteit + '</td>'
                            + '<td><button type="button" class="btn btn-danger" onClick="deleteDoc(\'' + doc._id + '\',\'' + doc._rev + '\')">X</button></td>'
                            + '<td><button type="button" class="btn btn-success" onClick="editDoc(\'' + doc._id + '\',\'' + doc._rev + '\',\'' + doc.lastName+ '\',\'' + doc.firstName + '\',\'' + doc.points + '\')">Edit</button></td>';
                }
            }
            html += '</table>';
            $('#output').html(html);
        },
        error : function(XMLHttpRequest, textStatus, errorThrown){
            console.log(errorThrown);
        }
    });
}

function deleteDoc(id, rev){
    $.ajax({
        type:     'DELETE',
        url:     '../../' + id + '?rev=' + rev,
        success: function(){
            fillTypeAhead();
            //buildOutput();
        },
        error:   function(XMLHttpRequest, textStatus, errorThrown) { console.log(errorThrown); }
    });
}

function editDoc(id, rev, ingavedatum, einddatum, prioriteit,beschrijving, status){
   
    $('#output').hide();
    $('#edit').show();
   
    var html = '';
   
    // Build edit form
    html += '<h3>Editeer record</h3><table class="table table-hover">';
    html += '<input type="hidden" id="_id" value="' + id + '"/>';
    html += '<input type="hidden" id="_rev" value="' + rev + '"/>';
    html += '<tr><td>ingavedatum:</td><td><input id="ingavedatum2" type="text" size="50" value="' + ingavedatum + '"/></td></tr>';
    html += '<tr><td>einddatum:</td><td><input id="einddatum2" type="text" size="50" value="' + einddatum + '"/></td></tr>';
    html += '<tr><td>prioriteit:</td><td><input id="prioriteit2" type="text" size="10" value="' + prioriteit + '"/></td></tr>';
    html += '<tr><td>beschrijving:</td><td><input id="beschrijving2" type="text" size="50" value="' + beschrijving + '"/></td></tr>';
    html += '<tr><td>status:</td><td><input id="status2" type="text" size="50" value="' + status + '"/></td></tr>';
    html += '<tr><td colspan="2" align="center"><button type="button" class="btn btn-primary" onClick="updateDoc()">Ok</button></td></tr>';
    html += '</table>';
   
    $('#edit').html(html);
}

function updateDoc(){
   
    var id = $("#_id").val();
    var rev = $("#_rev").val();
    var ingavedatum = $("#ingavedatum2").val();
    var einddatum = $("#eindatum2").val();
    var prioriteit = $("#prioriteit2").val();
    var beschrijving = $("#beschrijving2").val();
    var status = $("#status2").val();

    var doc = {};

    doc._id = id;
    doc._rev = rev;
    doc.ingavedatum = ingavedatum;
    doc.einddatum = einddatum;
    doc.prioriteit = prioriteit;
    doc.beschrijving = beschrijving
    doc.status = status;
    var json = JSON.stringify(doc);

    $.ajax({
        type : 'PUT',
        url : '../../' + id,
        data : json,
        contentType : 'application/json',
        async : true,
        success : function(data){
            $('#edit').hide();
            $('#output').show();
            buildOutput();
        },
        error : function(XMLHttpRequest, textStatus, errorThrown){
            console.log(errorThrown);
        }
    });
}

function fillTypeAhead(){
   
    buildOutput();
   
    $.ajax({
        type:    'GET',
        url:    '_view/by_id',
        async: true,
        success:function(data){
            var rows = JSON.parse(data).rows;
            var names = [];
            $.each(rows, function(key, value){
                names.push(value.key);
            });
           
            $('#students').typeahead({
                hint: true,
                highlight: true,
                minLength: 1
                },
                {
                name: 'names',
                displayKey: 'value',
                source: substringMatcher(names)
                });
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) { alert(XMLHttpRequest.responseText); }
    });
}

function searchDoc(){
   
    var name = $("#ids").val();
    var docName = name.replace(/\s+/g, '');
    console.log(docName);
   
    $.ajax({
        type:    'GET',
        url:    '../../' + docName,
        async: true,
        success:function(data){
            var doc = JSON.parse(data);
            editDoc(doc._id, doc._rev, doc.ingavedatum, doc.einddatum, doc.prioriteit, doc.beschrijving, doc.status);
            $("#students").val('');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) { alert(XMLHttpRequest.responseText); }
    });   
}

function substringMatcher(strs) {
    return function findMatches(q, cb) {
    var matches, substrRegex;
     
    // an array that will be populated with substring matches
    matches = [];
     
    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');
     
    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
    if (substrRegex.test(str)) {
    // the typeahead jQuery plugin expects suggestions to a
    // JavaScript object, refer to typeahead docs for more info
    matches.push({ value: str });
    }
    });
     
    cb(matches);
    };
}
   
$(document).ready(fillTypeAhead());
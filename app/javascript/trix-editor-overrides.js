// Blacklist all file attachments
window.addEventListener("trix-file-accept", function (event) {
  event.preventDefault();
  alert("File attachment not supported!");
});

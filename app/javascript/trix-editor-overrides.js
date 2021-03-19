window.addEventListener("trix-file-accept", function (event) {
  const maxFileSize = 3000 * 3000; // around 9MB
  if (event.file.size > maxFileSize) {
    event.preventDefault();
    alert("Only support attachment files upto size 9MB!");
  }
});

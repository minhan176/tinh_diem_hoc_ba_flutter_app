void main() {
  var pattern = RegExp(r'^(10(\.0+)?|0(\.\d+)?|1-9?)$');
  var inputs = ['0', '0.5', '10', '10.0', '10.1', '11', 'abc'];
  int i = 0;
  inputs.map((e) {
    i++;
  });
  print(i);
}

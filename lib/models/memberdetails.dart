class MemberDetails {
  final String? id;
  final String name;
  final String phonenumber;
  final String paydate;
  final String fee;

  MemberDetails( 
      {
      required this.id,
      required this.name,
      required this.phonenumber,
      required this.paydate,
      required this.fee});

  factory MemberDetails.fromjson(jsondata) {
    return MemberDetails(
        id: jsondata.id, 
        name: jsondata['first_name']+" "+jsondata['last_name'],
        phonenumber: jsondata['phonenumber'],
        paydate: jsondata['registerationdate'],
        fee: jsondata['fee']);
  }
}

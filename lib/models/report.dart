class Report {
  final String create_date;
  final String device_name;
  final String userId;
  final String phoneId;
  final String alias;
  final String installation_result;

  Report(this.create_date, this.device_name, this.userId, this.phoneId,
      this.alias, this.installation_result);

  Map<String, Object> toMap() {
    return {
      'create_date': create_date,
      'device_name': device_name,
      'userId': userId,
      'phoneId': phoneId,
      'alias': alias,
      'installation_result': installation_result
    };
  }
}

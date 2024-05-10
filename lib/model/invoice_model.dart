class InvoiceModel {
  final String fromPartyName;
  final String invoiceDate;
  final String? financeDate;
  final String dueDate;
  double? approvedAmount;
  double? financedAmount;
  int? tId;
  String? modelType;
  String? interimState;
  var invoiceNo;
  double? invoiceAmount;
  double? interestAmount;
  double? interestRate;
  bool? interestAmountStatus;


  InvoiceModel(
      {required this.fromPartyName, required this.invoiceDate, this.financeDate, required this.dueDate, this.approvedAmount, this.financedAmount,this.tId, this.modelType, this.interimState, this.invoiceNo, this.invoiceAmount,this.interestAmount,this.interestAmountStatus,this.interestRate,});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    final recordDatas = json['record_datas']['values'][0]['fields'];
    final workModel = json['work_model'];

    return InvoiceModel(
      fromPartyName: json['current_from_party_name'],
      interestAmountStatus:json['interest_amount_status'],
      invoiceDate: recordDatas['invoice_date'],
      financeDate: recordDatas['finance_date'] ,
      dueDate: recordDatas['due_date'],
      approvedAmount: recordDatas['amount'],
      financedAmount: recordDatas['finance_amount'],
      tId: workModel['t_id'],
      modelType: workModel['model_type'],
      interimState: json['interim_state'],
      invoiceNo: recordDatas['invoice_no'],
      invoiceAmount: recordDatas['invoice_amount'],
      interestAmount: recordDatas['interest_amount'],
      interestRate: recordDatas['interest_rate'],

    );
  }
}

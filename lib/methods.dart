

String countDownAgenda(DateTime tanggalBerangkatAgenda){

  final selisih = tanggalBerangkatAgenda.difference(DateTime.now());
  if (selisih.inDays > 1) { //is sebelum
    return selisih.inDays.toString();
  }else if(selisih.inDays == 1){
    return 'Besok';
  }else if(selisih.inDays == 0){
    if ((DateTime.now().hour < tanggalBerangkatAgenda.hour && selisih.inHours < 24)) {
      return 'Hari ini';
    }else if(tanggalBerangkatAgenda.isBefore(DateTime.now())){
      return 'Sekarang';
    }else{
      return 'Besok';
    }
    
  }else{
    return 'Terlalui';
  }
}
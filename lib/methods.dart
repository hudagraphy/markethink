String countDownAgenda(DateTime tanggalBerangkatAgenda){

  final selisih = tanggalBerangkatAgenda.difference(DateTime.now());
  if (selisih.inDays > 1) {
    return selisih.inDays.toString();
  }else if(selisih.inDays == 1){
    return 'Besok';
  }else if(selisih.inDays == 0){
    if(tanggalBerangkatAgenda.hour < DateTime.now().hour){
      return 'Besok';
    }else{
      if (DateTime.now().hour > tanggalBerangkatAgenda.hour && tanggalBerangkatAgenda.hour < tanggalBerangkatAgenda.add(Duration(hours: 6)).hour) {
        return 'Sekarang';
      }else{
        return 'Hari ini';
      }
    }
  }else{
    return 'Terlalui';
  }
}
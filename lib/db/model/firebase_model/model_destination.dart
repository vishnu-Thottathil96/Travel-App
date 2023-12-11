class ModelDestination {
  String? destinationId;

  String destinationName;

  String districtName;

  String categoryName;

  String location;

  String destinationDescription;

  List<String> destinationImage;

  ModelDestination({
    this.destinationId,
    required this.destinationName,
    required this.districtName,
    required this.categoryName,
    required this.location,
    required this.destinationDescription,
    required this.destinationImage,
  });
}

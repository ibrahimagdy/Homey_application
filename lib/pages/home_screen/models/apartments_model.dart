class ApartmentModel {
  final String mainImage;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? image6;
  final String? image7;
  final String? image8;
  final String price;
  final String address;

  const ApartmentModel({
    required this.mainImage,
    required this.price,
    required this.address,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
  });
}

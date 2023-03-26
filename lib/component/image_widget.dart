import 'package:lottery/main.dart';

export 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double thumbnailW;
  final double thumbnailH;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final bool placeholder;

  const ImageWidget(
    this.imageUrl, {
    Key? key,
    this.thumbnailW = 0,
    this.thumbnailH = 0,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.placeholder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return _buildPlaceholder();
    return CachedNetworkImage(
      imageUrl: Tool.getThumbnail(
        imageUrl,
        width: thumbnailW,
        height: thumbnailH,
      ),
      width: width,
      height: height,
      fit: fit,
      color: color,
      placeholder: (context, url) {
        return _buildPlaceholder();
      },
      errorWidget: (context, url, error) {
        return _buildPlaceholder();
      },
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 150),
    );
  }

  Widget _buildPlaceholder() {
    if (placeholder) {
      return Container(
        width: width,
        height: height,
        color: getPlaceholderColor,
      );
    }
    return const SizedBox();
  }
}

class ImagePrecache {
  static void precache(
    String imageUrl, {
    double thumbnailW = 0,
    double thumbnailH = 0,
  }) {
    precacheImage(
      CachedNetworkImageProvider(
        Tool.getThumbnail(
          imageUrl,
          width: thumbnailW,
          height: thumbnailH,
        ),
      ),
      Get.context!,
    );
  }
}

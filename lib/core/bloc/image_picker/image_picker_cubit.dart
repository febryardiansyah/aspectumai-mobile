import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aspectumai/core/resources/constants.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(ImagePicker imagePicker)
      : _imagePicker = imagePicker,
        super(const ImagePickerState());
  final ImagePicker _imagePicker;

  void pickImage() async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final data = await _imagePicker.pickMultiImage();

      if (data.isNotEmpty) {
        emit(state.copyWith(
          status: BlocStatus.loaded,
          imagePaths: data.map((e) => e.path).toList(),
        ));
      } else {
        emit(state.copyWith(
          status: BlocStatus.error,
          errorMessage: 'No images selected',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void removeImage(String path) {
    emit(state.copyWith(
      imagePaths: state.imagePaths.where((e) => e != path).toList(),
    ));
  }

  void clearImage() {
    emit(state.copyWith(
      status: BlocStatus.initial,
      errorMessage: '',
    ));
  }
}


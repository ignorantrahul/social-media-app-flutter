import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/follow_request/widgets/follow_request_widget.dart';

class FollowRequestView extends StatelessWidget {
  const FollowRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: NxRefreshIndicator(
          onRefresh: FollowRequestController.find.fetchFollowRequests,
          showProgress: false,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.followRequests,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight16,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: GetBuilder<FollowRequestController>(
        builder: (logic) {
          if (logic.isLoadingFollowRequest) {
            return const Center(child: NxCircularProgressIndicator());
          }

          if (logic.followRequestData == null ||
              logic.followRequestList.isEmpty) {
            return Padding(
              padding: Dimens.edgeInsets0_16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Dimens.boxHeight8,
                  Text(
                    StringValues.noFollowRequests,
                    style: AppStyles.style32Bold.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight16,
                  NxOutlinedButton(
                    width: Dimens.hundred,
                    height: Dimens.thirtySix,
                    label: StringValues.refresh,
                    onTap: () => logic.fetchFollowRequests(),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: Dimens.edgeInsets0_16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: logic.followRequestList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var request = logic.followRequestList.elementAt(index);
                    return FollowRequestWidget(
                      followRequest: request,
                      totalLength: logic.followRequestList.length,
                      index: index,
                    );
                  },
                ),
                if (logic.isMoreLoadingFollowRequest ||
                    logic.followRequestData!.hasNextPage!)
                  Dimens.boxHeight8,
                if (logic.isMoreLoadingFollowRequest)
                  const Center(child: CircularProgressIndicator()),
                if (!logic.isMoreLoadingFollowRequest &&
                    logic.followRequestData!.hasNextPage!)
                  Center(
                    child: NxTextButton(
                      label: 'Load more follow requests',
                      onTap: logic.loadMoreFollowRequests,
                      labelStyle: AppStyles.style14Bold.copyWith(
                        color: ColorValues.primaryLightColor,
                      ),
                      padding: Dimens.edgeInsets8_0,
                    ),
                  ),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }
}
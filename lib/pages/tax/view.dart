import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TaxPage extends GetView<TaxController> {
  const TaxPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("TaxPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaxController>(
      init: TaxController(),
      id: "tax",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("tax")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}

package com.example.hybrid_composition

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import android.app.Application
import com.yuno.payments.core.Yuno
import com.yuno.payments.core.YunoConfig
import com.yuno.payments.features.base.ui.screens.CardFormType

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>",
                                      NativeViewFactory())

            // Yuno.initialize(this, "API_KEY", config = YunoConfig(
            // cardFlow = CardFormType.MULTI_STEP,
            // saveCardEnabled = true,
            // keepLoader = true
        // ))
    }
}
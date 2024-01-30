package com.example.hybrid_composition

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, attributeSet: AttributeSet?) : LinearLayout(context, attributeSet), PlatformView {

    private val textView: TextView

    init {
        LayoutInflater.from(context).inflate(R.layout.native_view_layout, this, true)
        textView = findViewById(R.id.textView)
    }

    override fun getView(): View {
        return this
    }

    override fun dispose() {}
}

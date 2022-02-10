package com.example.module

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class ModuleActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_module)

        findViewById<Button>(R.id.btnBack).setOnClickListener {
            finish()
        }
    }
}
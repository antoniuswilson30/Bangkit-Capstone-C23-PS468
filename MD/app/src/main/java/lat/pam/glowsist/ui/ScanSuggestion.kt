package lat.pam.glowsist.ui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import lat.pam.glowsist.R

class ScanSuggestion : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        supportActionBar?.hide()
        setContentView(R.layout.activity_scan_suggestion)

        val arrayAdapter: ArrayAdapter<String>
        val suggestions = resources.getStringArray(R.array.selfie_suggestion)

        var mListView = findViewById<ListView>(R.id.lv_suggestion)
        arrayAdapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, suggestions)
        mListView.adapter = arrayAdapter
    }
}
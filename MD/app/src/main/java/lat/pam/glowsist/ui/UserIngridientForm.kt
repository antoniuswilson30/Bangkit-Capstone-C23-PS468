package lat.pam.glowsist.ui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import lat.pam.glowsist.R

class UserIngridientForm : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        supportActionBar?.hide()
        setContentView(R.layout.activity_user_ingridient_form)
    }
}
package com.anilkilinc.mactakipci;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;


public class SplashActivity extends Activity implements PushManager.PushListener {

    PushManager manager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        String gcmId = SharedPreferenceManager.spGetGcmId(this);    //get gcm id
        if(gcmId.isEmpty()) { //if it is null, get gcm id for the first time
            //check the push service availability
            manager = new PushManager(this, Common.GCM_APP_ID);

            //pushManager.checkPlayServices();
            manager.startRegistration();
        } else {
            startMainActivity();
        }
    }

    private void startMainActivity() {
        //go to main activity
        Intent i = new Intent(this, MainActivity.class);
        startActivity(i);
    }

    @Override
    public void onPushRegister(String registrationId) {
        //pass gcmId to server
        ServerUtilities.register(this, registrationId);
        startMainActivity();
    }

    @Override
    public void end() {
        //show warning
        //exit
    }

    @Override
    public void display(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT);
    }

    @Override
    public SharedPreferences getGcmPreferences() {
        return null;
    }
}

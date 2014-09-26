package com.anilkilinc.mactakipci;

import android.app.Application;

import com.android.volley.RequestQueue;
import com.android.volley.toolbox.Volley;


/**
 * Created by Anil on 19.09.2014.
 */
public class Mactakipci extends Application{

    private static Mactakipci singleton;
    private RequestQueue requestQuee;

    public Mactakipci() {
        super();
        singleton = this;
    }

    public Mactakipci getInstance() {
        return singleton;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        requestQuee = Volley.newRequestQueue(getApplicationContext());
    }

    public static void increase() {

    }

    public static void decrease() {

    }
}

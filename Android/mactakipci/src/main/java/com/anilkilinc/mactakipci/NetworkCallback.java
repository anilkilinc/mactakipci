package com.anilkilinc.mactakipci;

import org.json.JSONObject;

/**
 * Created by Anil on 18.09.2014.
 */
public interface NetworkCallback {

    public void onStart();
    public void onError();
    public void onResponse(JSONObject result);
}

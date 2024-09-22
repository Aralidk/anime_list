package com.example.anime_list;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example/anime";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("fetchAnimeList")) {
                        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
//                        Map<String, Object> arguments = new HashMap<>();
//                        arguments.put("pageNumber", 1);
//                        arguments.put("type", null);
//                        arguments.put("filter", null);
                        channel.invokeMethod("fetchAnimeList", null); // Pass null or a map of arguments
                        result.success("method called");
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }
}
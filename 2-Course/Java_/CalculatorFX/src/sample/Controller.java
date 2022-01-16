package sample;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.web.WebView;

public class Controller {
    @FXML
    WebView webView;
    @FXML
    Button btnLoad;

    @FXML
    public void loadBrowser(){
        webView.getEngine().load("http:/google.com");
    }
}

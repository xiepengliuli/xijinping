package cn.com.infcn.model;

/**
 * <pre>
 * 
 * //成功时
{
        "error" : 0,
        "url" : "http://www.example.com/path/to/file.ext"
}
//失败时
{
        "error" : 1,
        "message" : "错误信息"
}
 * </pre>
 * 
 * @author spbun
 *
 */
public class KindEditorResponse {

    private int error = 0;

    private String url = null;

    private String message = null;

    public static KindEditorResponse error(String message) {

        KindEditorResponse response = new KindEditorResponse();

        response.error = 1;
        response.message = message;
        return response;
    }

    public static KindEditorResponse success(String url) {

        KindEditorResponse response = new KindEditorResponse();

        response.error = 0;
        response.url = url;
        return response;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}

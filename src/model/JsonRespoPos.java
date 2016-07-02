package model;

public class JsonRespoPos {
    private String busname;
    private double latitude;
    private double longitude;


    public JsonRespoPos() {
    }

    public JsonRespoPos(String busname, double latitude, double longitude) {
        this.busname = busname;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public String getBusname() {
        return busname;
    }

    public void setBusname(String busname) {
        this.busname = busname;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}

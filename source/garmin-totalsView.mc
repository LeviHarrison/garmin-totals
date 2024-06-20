import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Time;

class garmin_totalsView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    /*function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }*/

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var distance = 0;
        var time = new Time.Duration(0);

        var today = new Time.Moment(Time.today().value());
        var userActivityIterator = UserProfile.getUserActivityHistory();
        var sample = userActivityIterator.next();

        while (sample != null) {
            if (sample.startTime.lessThan(today)) {
                break;
            }
            distance += sample.distance;
            time = time.add(sample.duration);
            sample = userActivityIterator.next();
        }

        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 4, Graphics.FONT_MEDIUM, "Totals for Today", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, "Distance: " + distance.toString() + " meters", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2+30, Graphics.FONT_SMALL, "Time: " + time.value().toString() + " seconds", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

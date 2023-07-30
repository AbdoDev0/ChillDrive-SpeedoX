let lastGear = null;

window.addEventListener("DOMContentLoaded", () => {
  window.addEventListener("message", async (e) => {
    if (e.data.action === "show") {
      $(".container").removeClass("hidden");

      const speed = e.data.speed * 3.6;
      const measurementType = "km/h";
      const rpm = e.data.rpm * 100;
      const gear = e.data.gear;

      $(".speed").text(speed.toFixed(0));
      $(".measurementType").text(measurementType);
      $(".rpm").css("width", `${rpm}%`);

      if (rpm >= 100) {
        $(".rpm").addClass("full");
      } else {
        $(".rpm").removeClass("full");
      }

      if (gear !== lastGear && !isNaN(gear)) {
        lastGear = gear;
        $(".gear").text(gear);
      }
    } else if (e.data.action === "hide") {
      $(".container").addClass("hidden");
    }
  });
});

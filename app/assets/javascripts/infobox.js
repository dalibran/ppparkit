var InfoBoxBuilder, handler;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
this.InfoBoxBuilder = (function() {
  __extends(InfoBoxBuilder, Gmaps.Google.Builders.Marker);
  function InfoBoxBuilder() {
    InfoBoxBuilder.__super__.constructor.apply(this, arguments);
  }
  InfoBoxBuilder.prototype.create_infowindow = function() {
    var boxText;
    if (!_.isString(this.args.infowindow)) {
      return null;
    }
    boxText = document.createElement("div");
    boxText.setAttribute('class', 'marker_container');
    boxText.innerHTML = this.args.infowindow;
    this.infowindow = new InfoBox(this.infobox(boxText));

    google.maps.event.addListener(this.infowindow, 'domready', function(){
      $('select').material_select();
      $(".infoBox").hide();
      $("#modal1").html($(".infoBox").html());
      $('.modal').modal();
      $('.modal').modal("open");
      // $("#map-info-window .modal-trigger").on("click", function() {
      //   $('.modal').modal("open");
      // })
    });
    return this.infowindow;
  };
  InfoBoxBuilder.prototype.infobox = function(boxText) {
    return {
      content: boxText,
      pixelOffset: new google.maps.Size(-140, 0),
      boxStyle: {
        width: "280px"
      }
    };
  };
  return InfoBoxBuilder;
})();
handler = Gmaps.build('Google', {
  builders: {
    Marker: InfoBoxBuilder
  }
});

/*
Copyright Real Purdy Software LLC 2020
 */

class Note
{
  int _id;
  String _title;
  String _content;

  Note( this._id, this._title, this._content);

  int getId() => _id;
  String getTitle() => _title;
  String getContent() => _content;

  void setId( int aId) => _id = aId;
  void setTitle( String aTitle ) => _title = aTitle;
  void setContent( String aContent) => _content = aContent;
}
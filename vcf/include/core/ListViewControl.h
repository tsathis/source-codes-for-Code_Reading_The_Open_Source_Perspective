/**
*Copyright (c) 2000-2001, Jim Crafton
*All rights reserved.
*Redistribution and use in source and binary forms, with or without
*modification, are permitted provided that the following conditions
*are met:
*	Redistributions of source code must retain the above copyright
*	notice, this list of conditions and the following disclaimer.
*
*	Redistributions in binary form must reproduce the above copyright
*	notice, this list of conditions and the following disclaimer in 
*	the documentation and/or other materials provided with the distribution.
*
*THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
*AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
*LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
*A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS
*OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
*EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
*PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
*PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
*LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
*NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
*SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*NB: This software will not save the world.
*/

/* Generated by Together */

#ifndef LISTVIEWCONTROL_H
#define LISTVIEWCONTROL_H


namespace VCF{

class ListModel;

class ListviewPeer;

class ListItem;

class ListModelHandler;

class ListModelEvent;

#define LISTVIEWCONTROL_CLASSID			"ED88C09D-26AB-11d4-B539-00C04F0196DA"

class APPKIT_API ListViewControl : public VCF::Control {

public:
	BEGIN_CLASSINFO(ListViewControl, "VCF::ListViewControl", "VCF::Control", LISTVIEWCONTROL_CLASSID )
	LABELED_ENUM_PROPERTY( IconStyleType, "iconStyle", ListViewControl::getIconStyle, ListViewControl::setIconStyle, 
						   IS_LARGE_ICON, IS_DETAILS, 4, IconStyleTypeNames);
	LABELED_ENUM_PROPERTY( IconAlignType, "iconAlignment", ListViewControl::getIconAlignment, ListViewControl::setIconAlignment, 
						   IA_NONE, IA_AUTO_ARRANGE, 4, IconAlignTypeNames);
	OBJECT_PROPERTY( ListModel, "listModel", ListViewControl::getListModel, ListViewControl::setListModel );
	
	EVENT("VCF::ItemEventHandler", "VCF::ItemEvent", "ItemSelectionChanged" );

	END_CLASSINFO(ListViewControl)

	EVENT_HANDLER_LIST(ItemSelectionChanged);
	ADD_EVENT(ItemSelectionChanged);
	REMOVE_EVENT(ItemSelectionChanged);	
	FIRE_EVENT(ItemSelectionChanged,ItemEvent);	

	ListViewControl();

	virtual ~ListViewControl();

    ListModel* getListModel();

    void setListModel(ListModel * model);

	virtual void paint( GraphicsContext * context ){};

	void addHeaderColumn( const String& columnName );

	void insertHeaderColumn( const unsigned long& index, const String& columnName );

	void deleteHeaderColumn( const unsigned long& index );

	IconStyleType getIconStyle();

	void setIconStyle( const IconStyleType& iconStyle );

	bool getAllowsMultiSelect();

	void setAllowsMultiSelect( const bool& allowsMultiSelect );

	IconAlignType getIconAlignment();

	void setIconAlignment( const IconAlignType& iconAlignType );

	bool getAllowLabelEditing();

	void setAllowLabelEditing( const bool& allowLabelEditing );

	void setItemFocused( ListItem* item );

	ListItem* getSelectedItem();

	//Events
	void onListModelContentsChanged( ListModelEvent* event );

    void onItemAdded( ListModelEvent* event );

    void onItemDeleted( ListModelEvent* event );
	
	void init();

	void onListModelEmptied( ModelEvent* event );
private:    
    ListviewPeer * m_listviewPeer;
	ListModel* m_listModel;	
	IconStyleType m_iconStyle;
};



};
#endif //LISTVIEWCONTROL_H
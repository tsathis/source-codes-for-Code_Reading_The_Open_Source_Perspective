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

/* Generated by Together*/

#ifndef LISTMODEL_H
#define LISTMODEL_H


namespace VCF{

class ListItem;

class ListModelListener;

/** @interface */

#define LISTMODEL_CLASSID		"ED88C0A8-26AB-11d4-B539-00C04F0196DA"

class APPKIT_API ListModel : public Model{
public:
	BEGIN_ABSTRACT_CLASSINFO(ListModel, "VCF::ListModel", "VCF::Model", LISTMODEL_CLASSID)
	OBJECT_COLLECTION_PROPERTY(ListItem*, "items", ListModel::getItems, ListModel::addItem, ListModel::insertItem, ListModel::deleteItem, ListModel::deleteItem )
	EVENT( "VCF::ListModelEventHandler", "VCF::ListModelEvent", "ContentsChanged" )
	EVENT( "VCF::ListModelEventHandler", "VCF::ListModelEvent", "ItemAdded" )
	EVENT( "VCF::ListModelEventHandler", "VCF::ListModelEvent", "ItemDeleted" )
	END_CLASSINFO(ListModel)

	ListModel(){

	};

	virtual ~ListModel(){};

    virtual void addContentsChangedHandler(EventHandler * handler) = 0;  

	virtual void removeContentsChangedHandler(EventHandler * handler) = 0;

	virtual void addItemAddedHandler(EventHandler * handler) = 0;  

	virtual void removeItemAddedHandler(EventHandler * handler) = 0;

	virtual void addItemDeletedHandler(EventHandler * handler) = 0;  

	virtual void removeItemDeletedHandler(EventHandler * handler) = 0;
    
	virtual void deleteItem(ListItem * item) = 0;
    
	virtual void deleteItem(const unsigned long & index) = 0;
    
	virtual void insertItem(const unsigned long & index, ListItem * item) = 0;

    virtual void addItem(ListItem * item) = 0;

	virtual ListItem* getItemFromIndex( const unsigned long& index ) = 0;

	virtual Enumerator<ListItem*>* getItems() = 0;

	/**
	*returns the number of the items in the model
	*/
	virtual unsigned long getCount() = 0;
};

}
#endif //LISTMODEL_H
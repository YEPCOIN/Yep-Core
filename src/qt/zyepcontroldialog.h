// Copyright (c) 2017-2019 The yep developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef zyepCONTROLDIALOG_H
#define zyepCONTROLDIALOG_H

#include <QDialog>
#include <QTreeWidgetItem>
#include "zyep/zerocoin.h"
#include "privacydialog.h"

class CZerocoinMint;
class WalletModel;

namespace Ui {
class zyepControlDialog;
}

class CzyepControlWidgetItem : public QTreeWidgetItem
{
public:
    explicit CzyepControlWidgetItem(QTreeWidget *parent, int type = Type) : QTreeWidgetItem(parent, type) {}
    explicit CzyepControlWidgetItem(int type = Type) : QTreeWidgetItem(type) {}
    explicit CzyepControlWidgetItem(QTreeWidgetItem *parent, int type = Type) : QTreeWidgetItem(parent, type) {}

    bool operator<(const QTreeWidgetItem &other) const;
};

class zyepControlDialog : public QDialog
{
    Q_OBJECT

public:
    explicit zyepControlDialog(QWidget *parent);
    ~zyepControlDialog();

    void setModel(WalletModel* model);

    static std::set<std::string> setSelectedMints;
    static std::set<CMintMeta> setMints;
    static std::vector<CMintMeta> GetSelectedMints();

private:
    Ui::zyepControlDialog *ui;
    WalletModel* model;
    PrivacyDialog* privacyDialog;

    void updateList();
    void updateLabels();

    enum {
        COLUMN_CHECKBOX,
        COLUMN_DENOMINATION,
        COLUMN_PUBCOIN,
        COLUMN_VERSION,
        COLUMN_PRECOMPUTE,
        COLUMN_CONFIRMATIONS,
        COLUMN_ISSPENDABLE
    };
    friend class CzyepControlWidgetItem;

private slots:
    void updateSelection(QTreeWidgetItem* item, int column);
    void ButtonAllClicked();
};

#endif // zyepCONTROLDIALOG_H

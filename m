Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41685409277
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768165; cv=none; b=nz22QFoA704vV/wfRyBTVAa8YNSKLfabn6hJQfgdikz45aY5Se6u45iEV0evF4ZPI9WRiuuMiRmW8d5qSokmeBeOG5OYgQlSrNEPDRsK/5+9QNa9XNSQZVVHpna18TOkXCN4N3/jiAABOMfOsDUwHbA8wq2oY0RLv+JfD8gkcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768165; c=relaxed/simple;
	bh=6pbCXHdNGgbiqgt8/vU98hqM0k52oGF36U5x2YRnzgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv/X7atzJblYAq9MssbpSAnb0brrQbMH8ECguOSLFHR5qOOSAggBnWjIBLMNQWUKrDrJBgDtuhz2vFAIGMGSJ/38PpTiZ6bvht40ePZ+KjYSAHjk6ENkfdNCNlJXvaWDDBBZJ7ipRQH1yyhopBOUXwCTjm+7mEe+kPCvwoYPVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsphLC+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsphLC+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EE31F00A3D;
	Wed, 26 Aug 2026 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787768151;
	bh=+OEoiH1FSz995l7bkWhG4u1EhCiYXcOBI/5PjnAWTl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsphLC+sH6Fo8am5iManDxFzA6a/tr1nKZAThJeOot215jIyoroxR5jsKHbz6TBm7
	 uICCOHFmRQry61J6MhTLXuNoNwzTojeZXevjEbhcrm+ylgl27EHfjBmPaN/OsXhpGW
	 gV+s1jvMYTE4WSydGa9qhhVuP0DmOqnzK6nVrSS7PDXZZDpSOsiyQSjD7dpdwQ87bW
	 +BM3VGqkNw3jo4BW7nZbcupyxvm5DqzesxbekvjH727Zc7dQVZ2ypZO7ALTOTZuPXj
	 OskBqpbdIAiW43RCHLKIODCFZh3ph+ptRqO1ezMdBm00cbAAhfNrkIKT3cyp3mq+0+
	 rX0jLXSxtd95w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Bluetooth: hci_sync: Fix accept list UAF during suspend
Date: Wed, 26 Aug 2026 14:15:48 -0400
Message-ID: <20260826181548.2868994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826181548.2868994-1-sashal@kernel.org>
References: <2026082512-chimp-sixties-ddb1@gregkh>
 <20260826181548.2868994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit f57b399c4fa1501b2d5451f52d861ece86bcf3db ]

hci_update_event_filter_sync() walks hdev->accept_list while sending a
synchronous HCI command for each remote-wakeup device.  The suspend path
holds hdev->req_lock, but accept-list updates are serialized by hdev->lock.
Consequently, remove_device() can free the current list entry during the
controller wait.

The following interleaving causes the use-after-free:

  hci_update_event_filter_sync()    remove_device()
  fetch accept-list entry
  hci_set_event_filter_sync()
    wait for controller response    hci_dev_lock()
                                    list_del()
                                    kfree()
                                    hci_dev_unlock()
  read the freed list.next

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_suspend_sync+0x835/0x910
  Read of size 8 at addr ffff88810bec8440 by task kworker/0:1/10
  Workqueue: events vhci_suspend_work
  Call Trace:
   hci_suspend_sync+0x835/0x910
   hci_suspend_dev+0x182/0x450
   process_one_work+0x661/0x1090
   worker_thread+0x45b/0xd10

  Allocated by task 86:
   hci_bdaddr_list_add_with_flags+0x1a8/0x400
   add_device+0x381/0x820
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 91:
   kfree+0x131/0x3c0
   remove_device+0x429/0xb70
   hci_sock_sendmsg+0x1033/0x1ea0

Snapshot the remote-wakeup addresses under hdev->lock.  Release the lock
before sending HCI commands.  Clear the controller event filter before
building the snapshot, and skip allocation and the second list traversal
when there are no matching entries.  This preserves the original filter
and scan-state updates without retaining an accept-list node across a
controller wait.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260730092331.2069741-1-nicoyip.dev@gmail.com/
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c16e1cea19076..be49e14d27239 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6011,6 +6011,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6027,23 +6029,49 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-			continue;
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			num_entries++;
 
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	if (!num_entries) {
+		hci_dev_unlock(hdev);
+		goto update_scan;
+	}
 
-		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
-						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
-						 HCI_CONN_SETUP_AUTO_ON);
+	accept_list = kmalloc_array(num_entries, sizeof(*accept_list),
+				    GFP_KERNEL);
+	if (!accept_list) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	i = 0;
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			bacpy(&accept_list[i++], &b->bdaddr);
+
+	hci_dev_unlock(hdev);
+
+	for (i = 0; i < num_entries; i++) {
+		bt_dev_dbg(hdev, "Adding event filters for %pMR",
+			   &accept_list[i]);
+
+		err = hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
+						HCI_CONN_SETUP_ALLOW_BDADDR,
+					 &accept_list[i],
+					 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
 			bt_dev_err(hdev, "Failed to set event filter for %pMR",
-				   &b->bdaddr);
+				   &accept_list[i]);
 		else
 			scan = SCAN_PAGE;
 	}
 
+	kfree(accept_list);
+
+update_scan:
 	if (scan && !scanning)
 		hci_write_scan_enable_sync(hdev, scan);
 	else if (!scan && scanning)
-- 
2.53.0


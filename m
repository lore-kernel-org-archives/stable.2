Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488072C0298
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663907; cv=none; b=DOdE4/glhrzrjJk8s23xNZispZFWnoYP95pwWXE5tLngqw27f1faOT+TZVTmhnhVah5Leo3O+ArOjuU8oEc9f/WM2VRWyCmmQJWPEY4Rpl+AxWJCb8C2s3U3LPXD8lKSUHd1rSe6WT7pz/Tp3hEWk4xa9c178oiWUbl2lNHIIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663907; c=relaxed/simple;
	bh=BRsD7vrFZ+d5WLGNIJiqeNn2FtV8R140e5qJ5jLgAHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S0TJx8UfsYZNJpFALuMt/SsNUjw7kXozy2M17fTIwJFtmY5P6whd0rgVuMcYRqe7wC7xUvdGzQ7EsBJB9U5lIkiqmaV1hXiUwc98/evI8zaBHgX8PzakzOybtsu1qfNJsqlQ0iU73lfqgjvdjr0ILdpRJ+5weJkbmYnJDyULvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWVfIW9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWVfIW9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C1A1F000E9;
	Tue, 25 Aug 2026 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663905;
	bh=M5n1F7Zk0hf3+Dse71R4/cr9i1fEV0m9gmW63OTugbQ=;
	h=Subject:To:Cc:From:Date;
	b=XWVfIW9pSF6fumrDDX+QkvQm76f4yQqigHlcYk5tHEUQR3sKywpERdJRiE1g2Rjsw
	 hck7uL3n0pRuAmmGcX+Yl1XqN6COUZJdfTbxOSuOjggHGfF4942QyFVEOGxNm+I7Qh
	 gjy9DWW4WS4BDyE30r8bFikL6mcQY13o/kOFEwU0=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend" failed to apply to 6.6-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:18:11 +0200
Message-ID: <2026082511-scouting-bunt-8bff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f57b399c4fa1501b2d5451f52d861ece86bcf3db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082511-scouting-bunt-8bff@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f57b399c4fa1501b2d5451f52d861ece86bcf3db Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 15:05:24 +0800
Subject: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend

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

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 307fd47f8459..a661634a63aa 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6351,6 +6351,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6367,23 +6369,49 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-			continue;
+	hci_dev_lock(hdev);
 
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			num_entries++;
 
-		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
-						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
-						 HCI_CONN_SETUP_AUTO_ON);
+	if (!num_entries) {
+		hci_dev_unlock(hdev);
+		goto update_scan;
+	}
+
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


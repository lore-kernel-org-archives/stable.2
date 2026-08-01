Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6E314D05
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567936; cv=none; b=q4x+PbhpXYKaRnRYzBhGP6d1mZv/1Oc9abKuCSkeVHMc/iPQw4wZhahUcfSgPwj0jRAGYPaYhAsHfwGbUXd8iYWA23aU5QGb6bMLglCq/m40ZUQQ9gKo4hTtFR3O/3CzBwbCH/9W0fJ0pB/YB8sNvS2Nx075kqU+Ux1QqT9QHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567936; c=relaxed/simple;
	bh=9DGEFJCb/LWhVEPNiaXBiDRAi0qf+6RoHLzMHeTTwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhsZ3EGVOSOebuTUWMPDJvwfXcpdiFEwoA3rfD5+W9aD3AjDoyWnPDJcP7AtIUyCxu5/DDcovYraB4lsLFR+X3eP681Q5giIQxiKJ2/SIuw69Hx3RnFLyL6zn+OE8rTUINLQqCBcl0LdmLQd1V/D0LUWgrwnUIo3dlPKg378ICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1M7KTiU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1M7KTiU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-380f3c1b087so237607a91.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567934; x=1786172734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzTWXeB+WeaO/vaut8/fORcsEVe1NWPMbRXBtC2FjPY=;
        b=p1M7KTiUbTqdB6Jx5eAa8qX9VZeC9p9+EZMp4ATFl+Vp0NITad77BcblqUxPquzvU6
         SsWyH+/+7x/W2m6ovoGLCawfSDXg6CGufvy4ZJzT4g5H81XnVdx+mGK0gyp+KblloWv3
         XUAztNjpNhwPQVFrgiFnOn/au28ZkVIayz9137LL3/qYHDxOwvAUpzGB+Im9BTq0ah+s
         Y/OsiJuTHooXXv0XMd2L5UXXBy64mLY0/+eRaiL+1j9c3SVKLDm9stMjd0GXv8izbLOl
         KOacVFgGLQT1npV0cQrN/9CJXmK1xIB9Xlq8S+uvi6yl08zoxMC0pODtPk5/aF6/K96f
         T0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567934; x=1786172734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzTWXeB+WeaO/vaut8/fORcsEVe1NWPMbRXBtC2FjPY=;
        b=CUX97odVU4jL/F82KPv8XlDwgijv7cauzKJJxHCIVLQSUmSZVZ7QGGf12qaXX7k5/S
         i4h66K+WmHuRaXI+SpqZwVC07OtG2IFpc2WvDb8X/1BGYOsky0P2veXRz/PVY8agysUX
         Bfk+Had4o58N58IKOs3hQTnlivDe6d4qQfNXb+ZDXB5or0mFFOa+qtwwtrLI3ia5dazs
         iQHAUuECPp5NZ++DDOPHNNnqhJuMZE2VRLsDHoA3PFDgWVDx9tTo0h+pdP4mFAO+Lsoa
         hPvMjdHCCOxsfJL4neNsn9dyc35peLi1cH0keuR6he5H0SA6IZ8EGqkz7OtSARiKqpop
         WGyg==
X-Forwarded-Encrypted: i=1; AHgh+RrH6EewSTb4d2GvNawFsUE8YydMiT9J4+1dj8ZtymxQNtDHu0AnDYoqJTDRXzzSVqsnmdkC5lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UMJ0uQfNcB0yaoYyNuF0y8sVEf/7INYHYq7RwyrJqKQGzlys
	OrzKKWBbNrk70OULPdfsuh29FsWMYyeEOFOpOx8ztbWo6tS0xrsEYcx7
X-Gm-Gg: AR+sD12N/+sRtfBvDue6azYPd1Mp9nEVLmyMf6otCQJ+/4qLgPtKLHKKYvndBJtevOy
	sjYcCUPavvz70xfflHrGDbKzvnPXajok2x9s5rDwkTFs9d7QynN+uMk02wvfNAkBj6q6twZb5M9
	71szo+pp7pyF4sEAD+Xni+JC5XOIj/Eu0tQrmUMZdIaSRdy3Z52eAWGB07KnEaATKTTCzKbwSZ0
	QJCVF0kMVV2uXqYalEHbX8BMUEUxbdjxagiKxDRKQXamAk0GepR4/UBs4jlZ/fmAG/3BFX3thl+
	67CmFlHCnWZfAxTK53CCUPmeQ1NG4hkcMa+oDD/2bYsoSbGbMm8utUlbvnla6t6o9VH/szBSIZl
	GUPWnwalpu4iRTbzJsgqKk9aR4Y6dSLBBxQcR366UlfuYYejMokGBmPf64OMkK97OKnJ/t2dkgX
	mP+u2oXT9aRCrPW0SEORCSklf/oowI+vfZkAOD3HjGbZMj9HhKLv2S+/vsQ5TaMwaDQuEeiEzGI
	+8uVGCWFGDntFzP7oTMKzklrLj7GarjYddrh/z0OgMN7SWNZTt9Mbw=
X-Received: by 2002:a17:902:f78b:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d05206277emr35924695ad.0.1785567934106;
        Sat, 01 Aug 2026 00:05:34 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm13860675eec.6.2026.08.01.00.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:05:33 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: Fix accept list UAF during suspend
Date: Sat,  1 Aug 2026 15:05:24 +0800
Message-ID: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v2:
- Clear the event filter before taking the accept-list snapshot.
- Skip allocation and the second list walk when there are no matching entries.

Link: https://lore.kernel.org/linux-bluetooth/20260730092331.2069741-1-nicoyip.dev@gmail.com/ [v1]

 net/bluetooth/hci_sync.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c8d14128c363..8ccc3b22ef5b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6313,6 +6313,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6329,23 +6331,49 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
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
+
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
 
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	for (i = 0; i < num_entries; i++) {
+		bt_dev_dbg(hdev, "Adding event filters for %pMR",
+			   &accept_list[i]);
 
-		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
-						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
-						 HCI_CONN_SETUP_AUTO_ON);
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
2.43.0


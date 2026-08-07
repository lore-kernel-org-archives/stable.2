Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF846C4A9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097746; cv=none; b=u1Fap7OK60+j+iYwbQwBXArBxMBbkb/6eTT2hGPkV3PCCb2LoChcKBTxhi4N+S2g/MI4lob0WIvNryF/iNvvzONtLQai7/erbpbl+VsOzfiwNObGAXnUOtGW/iJOpBcYjSxu2Lwdpf5VeyfMX7eRlSxFqgbnS1FaQwe5mWa9Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097746; c=relaxed/simple;
	bh=CgxX9rsHxSpVN1dVHfL/gmr494DCbOtJ94jxQ9wMm1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM1A9rWey9VWv9Wo7gMwtQPF3ZA1SnKvjVd9hgl/GZYMTrsI7zluSWNp3EIH995aiqO5GcwJRvDTgUS+gYVVQfo+8uMN0rRITW6uSFhcZNI42RvuNxfhGr2CF8umckRc3gxeW7aFEmE3IzKO5kq0paiTtY7so8jvDzS26vs9T2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=K1BiSvkj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="K1BiSvkj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2642994a91.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786097744; x=1786702544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q49YmBHBrxXBpHhacsgIe7Na2rO5D95moH0oU7i0wlo=;
        b=K1BiSvkjIbJTIJ4AOiJcZSinDQQUKUzfvJk/l4K2Dmz2Lbx6DGBXPQlBCyrRvMvX7v
         kLm1hnGrIZQ6YIPhPZsH45ZBPGOX8OoVk1Z011ikJFdtk7jUTNdb5SSFmyUA0QXHWgdg
         qrsa06fkgHhNiAsYv0+pfKiYEj/6/a7PU9BGaWaQQZym8UY342n9QKQHgLzHjX0Xv7gN
         B6rfmtE6cZ9d6Ynz5ArFb3ognmk5QEcb0mqOHWwY0KBLsycSJSv5ydojMWj6p2Ybn9gY
         Gg2IojWRwZ3dpJ5xlvtJRoVUDvLVgY9X1gS92QOXHj+8SzO09gR7+IgJLhs1SKLOnxHw
         3zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097744; x=1786702544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q49YmBHBrxXBpHhacsgIe7Na2rO5D95moH0oU7i0wlo=;
        b=Rz9eEGuGVtFne4Fz9XsPWNIZ0A+Jr+hCvEWexIMmrdIEtDjv1khrenSK51NzzFXQU0
         YzhyGQWQjVLslBmCqfvd873lo00JdXEM9SdEx6VDVrVTRGMBO/MfGvu6Lbj3g9GqNTE4
         Szm2dwCYqXc135ToaN0ylwKv7w3tRAPBpr/oVVKo9rqrms3Jq3y/NbpE9B1wqAsHZiC7
         CnS3acbrZkQk0mCjVb5ElYbkRs4OLGMSdKRgGev/wSfYBhPIQh2KwvaugO3yW1OgIMyG
         V1rxFBU9hgztml9IzkIVDKpP1bzXy6ctlXpxmuHfpKE1gonCFUiFxQJ3igEMspfgweYu
         BLMw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2hvO5ebSw/n6RD1B2i9DkbNhGHlaBnTcWT3oFSvS1go6oNKBkT9ZRd0Lg6z9v9hCJoNXEtPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKhtJ/r/B78cqtM3d4Iv1yh7rLs52V8zX3F1mSW75MkDaGHlO
	pjl5dITwhcSJLVX4rOhAJFgpsuTwjt02pK/nBTJyQP+CJwIUnlqhIN0wQJa/MnnuAfo=
X-Gm-Gg: AR+sD13KLmfdnwwOt//BBIME7c4YBbLC2ouIxzVBzH+H/KWrJ2ADcEj3NdnmQkHzjaV
	kuyXX98WzqkO8e8Ar6JnuZ57Hrm2ROI5ufbI0fS2Q1wzLgf9s2LNrvEeod93IabAr064rDbpioe
	XiQKXWYVso+GlB13wSnewafWJOX2B+zLstF45llgrrC1iWU/6P7JN7kitsL8iSwqdx/ufioZ1EF
	jPGLcpLBXHgc3AiNbSiISJ93KWKeL+vFOb5aSoksjvwMncS+qgvTfZKHMd56lE6qOi+BKdfHLjY
	8PTYnN2h395QRHjIAJoA/2v9x666kdxoL1bYnPKZhRW0b2q/tmI+ae3+n8Zyi//erWg9JbCLVsj
	NRRfv9JMCshOme6CP61qtZF+KhkKtJ2HlBC8sRsZBsjX74RacLAGC+vqioy91hpZY8t755xfQnT
	4lfzSXerdvllCvvZaQjbsJN1GUk+JPPIAP5dphHT4JdJteSepCC4qpPSW/QwAXhwIc17H2f1eZX
	PNDi7UfvazbAH26mHvTFlsw4LgsnUe5V0nBP5S2mAs=
X-Received: by 2002:a17:90b:3c8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3909d822517mr8901143a91.9.1786097743507;
        Fri, 07 Aug 2026 03:15:43 -0700 (PDT)
Received: from localhost.localdomain ([1.220.41.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dea04bsm4399162a91.8.2026.08.07.03.15.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:15:43 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
Date: Fri,  7 Aug 2026 19:15:28 +0900
Message-ID: <20260807101529.17348-3-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807101529.17348-1-baul.lee@xbow.com>
References: <20260807101529.17348-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hdev->mesh_pending carries the queued struct mgmt_mesh_tx of the mesh
mgmt interface.  It is extended and walked from syscall context under
hci_dev_lock(hdev), in mgmt_mesh_add() and mgmt_mesh_foreach(), and it
is unlinked and freed from the hci_cmd_sync worker under
hci_req_sync_lock(hdev), in send_cancel(), mesh_send_done_sync() and
mesh_next().  The two sides hold different mutexes, so the list has no
protection: MGMT_OP_MESH_READ_FEATURES on one socket can be mid-walk
while MGMT_OP_MESH_SEND_CANCEL on another frees the entry it is
standing on.

[   47.418949] BUG: KASAN: slab-use-after-free in send_count+0x4c/0x6c
[   47.419029] Read of size 1 at addr ffff000015943228 by task c2_race/191
[   47.419546]  send_count+0x4c/0x6c
[   47.419591]  mgmt_mesh_foreach+0x68/0x100
[   47.419637]  mesh_features+0x180/0x184
[   47.421345] Freed by task 59:
[   47.421555]  mgmt_mesh_remove+0x94/0x110
[   47.421589]  send_cancel+0xd8/0x1cc
[   47.421627]  hci_cmd_sync_work+0xac/0x128

Offset 40 of the freed 96-byte object is mesh_tx->handle, the byte
send_count() puts in the MESH_READ_FEATURES reply.  The walk also
follows the LIST_POISON1 left by the concurrent list_del(), which oopses
with hci_dev_lock held and never released, so every later mgmt command
on that controller blocks.

The same missing lock lets the worker free the object under mesh_send(),
which reads mesh_tx->handle into the command complete after queueing:

[   41.093914] BUG: KASAN: slab-use-after-free in mgmt_cmd_complete+0xd0/0x210
[   41.094353] Read of size 1 at addr ffff00000a0dea28 by task c1_poc/162
[   41.096944]  mgmt_mesh_remove+0x94/0x110
[   41.096975]  mesh_send_start_complete+0x128/0x160

That read already sits inside mesh_send()'s hci_dev_lock() section; it
is the worker side that is missing the lock.

Take hci_dev_lock(hdev) on the worker side, around the list work only
and not around hci_disable_advertising_sync(), and assert it in the
helpers that walk or extend the list.  hci_req_sync_lock -> hdev->lock
is the order this subsystem already uses: hci_cmd_sync_work() calls
entry->func under req_lock, and callbacks such as hci_update_eir_sync()
take hci_dev_lock() inside it.

mesh_next() and mesh_send_start_complete() are destroy callbacks, and
hci_cmd_sync_clear() runs a destroy callback under cmd_sync_work_lock,
which every mgmt caller of hci_cmd_sync_queue() takes with hdev->lock
already held.  Both therefore return before hci_dev_lock() when err is
-ECANCELED, as the other destroy callbacks in this file do.  Without
those returns lockdep reports a circular dependency, reached by closing
/dev/vhci while a mesh entry is queued behind a parked req_workqueue:

[   78.211873] ffff00001b0340b8 (&hdev->lock){+.+.}-{4:4}, at: mesh_send_start_complete+0x88/0xf4
               but task is already holding lock:
[   78.212596] ffff00001b0347c0 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0x60/0xd4
               -> #1 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}:
[   78.214268]        hci_update_passive_scan+0x6c/0x84
[   78.214455]        mgmt_set_powered_complete+0x1b0/0x1f8

The other leg of the cycle, mgmt_set_powered_complete() calling
hci_update_passive_scan() with hdev->lock held, is an existing in-tree
path.  The entry such a return leaves on hdev->mesh_pending stays there,
as entries already do across an unregister.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Fixes: 3bb88524b7d0 ("Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bluetooth/mgmt.c      | 30 ++++++++++++++++++++++++++++--
 net/bluetooth/mgmt_util.c |  8 ++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97408904f74b..853a80fd15af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1087,6 +1087,8 @@ static void mesh_send_complete(struct hci_dev *hdev,
 {
 	u8 handle = mesh_tx->handle;
 
+	lockdep_assert_held(&hdev->lock);
+
 	if (!silent)
 		mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle,
 			   sizeof(handle), NULL);
@@ -1101,11 +1103,16 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 	if (list_empty(&hdev->adv_instances))
 		hci_disable_advertising_sync(hdev);
+
+	hci_dev_lock(hdev);
+
 	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
 	if (mesh_tx)
 		mesh_send_complete(hdev, mesh_tx, false);
 
+	hci_dev_unlock(hdev);
+
 	return 0;
 }
 
@@ -1113,11 +1120,19 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data);
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
 static void mesh_next(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
+	struct mgmt_mesh_tx *mesh_tx;
 
-	if (!mesh_tx)
+	if (err == -ECANCELED)
 		return;
 
+	hci_dev_lock(hdev);
+
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+	if (!mesh_tx) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
 	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
 				 mesh_send_start_complete);
 
@@ -1125,6 +1140,8 @@ static void mesh_next(struct hci_dev *hdev, void *data, int err)
 		mesh_send_complete(hdev, mesh_tx, false);
 	else
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	hci_dev_unlock(hdev);
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -2310,12 +2327,17 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	unsigned long mesh_send_interval;
 	u8 mgmt_err = mgmt_status(err);
 
+	if (err == -ECANCELED)
+		return;
+
 	/* Report any errors here, but don't report completion */
 
 	if (mgmt_err) {
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
+		hci_dev_lock(hdev);
 		mesh_send_complete(hdev, mesh_tx, false);
+		hci_dev_unlock(hdev);
 		return;
 	}
 
@@ -2421,6 +2443,8 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_mesh_send_cancel *cancel = (void *)cmd->param;
 	struct mgmt_mesh_tx *mesh_tx;
 
+	hci_dev_lock(hdev);
+
 	if (!cancel->handle) {
 		do {
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
@@ -2435,6 +2459,8 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 			mesh_send_complete(hdev, mesh_tx, false);
 	}
 
+	hci_dev_unlock(hdev);
+
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
 
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 6ea107c0e054..a822091f2907 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -369,6 +369,8 @@ void mgmt_mesh_foreach(struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx, *tmp;
 
+	lockdep_assert_held(&hdev->lock);
+
 	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mesh_pending, list) {
 		if (!sk || mesh_tx->sk == sk)
 			cb(mesh_tx, data);
@@ -379,6 +381,8 @@ struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev, struct sock *sk)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	lockdep_assert_held(&hdev->lock);
+
 	if (list_empty(&hdev->mesh_pending))
 		return NULL;
 
@@ -394,6 +398,8 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	lockdep_assert_held(&hdev->lock);
+
 	if (list_empty(&hdev->mesh_pending))
 		return NULL;
 
@@ -410,6 +416,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	lockdep_assert_held(&hdev->lock);
+
 	mesh_tx = kzalloc_obj(*mesh_tx);
 	if (!mesh_tx)
 		return NULL;
-- 
2.50.1 (Apple Git-155)

Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74903AF674
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086578; cv=none; b=pVUGGpCANCDTbudNN/b5mC7ChVvAx/IeNWRWQoxvmxPAF14lFzrv9IY28czpgfcOjYwduW55l7+NsWio2uE7wJ8NJY/vC2906QOZx7/nK557twVSNStIi6159K1qHkM7kWQ1aXFPo4oumyUG/W4qPJXcS2PvnpnjnkFd4aTs5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086578; c=relaxed/simple;
	bh=VoeN281Q/Ynlf8Lr5X/qG2nEweiKHrjONDeipjZasVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVqXQkFwjdvYtBmJlEUDH5EsDWRV65RKSmCc6zSzdmgK8xL9aYaCaHmZR6ua5QPYaVJX6WcQjaynsEg5SrkpB7M+8MyCATSnSv/XWmiJIH25XQMxzpfA6/UusPNq9wka8jovjfgonrs2PiRsmdTlJkZZt6XDw+oNpb2rs+RnM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=NArUmkls; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="NArUmkls"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80bb41f7f3cso33884437b3.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786086576; x=1786691376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwYAmUiFKZyLt0eV4KfzGWIesmvuZyHS4RTZnrKIuJU=;
        b=NArUmklsviy9vOBU0vsXIi8CpwrNh4n6Z0lm39FgMHdsUv6pfohvm4TMLOQNzeJUeJ
         3f19KIOEIfqllkFko+cauYKHnp2izjZqE0u1QKOP0VCVbzG71xaKtlo+z6c7vDKmNa1J
         tScsEWl4Od7KXBAJQ9QsEwQwCzU3gQerMMPxfsBPZ6t6Qswa1ZyPuV4UnQE91Y++z5/5
         BAtXHVoV/PusEgZc0/kZm5xZAZV8Ts+zO9mAZFpjvZ0eKk7j1YxpPevqdPOGC8Sqdlbj
         jaleC7G4QSru5XBTbCIoQhM8XFn3sXeMZhtRf+lHTO0HK27aedTuackrUDcu5taACshH
         /bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086576; x=1786691376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwYAmUiFKZyLt0eV4KfzGWIesmvuZyHS4RTZnrKIuJU=;
        b=JySg1kfl/GATn+HdnmO61qpmxdzFJbjzlz7IsOqp5993LuQFyZj8Xf3A7lehxtMase
         e58axgYqhInIc2cePZw2qjEB5g9RwFu46+lHwxBERppMudXAyMNjG7oGew8S0cL2T34g
         3KX+1S/EjpdUWgrjkAwzLU/iB6PsrsuyHDPJsSbymJ0yFA0TDsoWQXsMWECNRAcA2KAp
         GE/PxPSs+634bjp22z3czZ4UugzhibLdw+EHyfZteU3FdyH+Yd9qi81phnYJnW7o8+PL
         REjVTCnZKraWL6gGcpxVezqW5LEV9kIf2hAmnh3ae9DefiKH0675LaczrTNQHPH1PZz4
         a8zw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkam7RIbUzDz+W749NnXz8RFAEICFGyrY2rinwaeBYmUPRFyV87+nkxGsLQ3Z50zY0EbOGaGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiUmynMtK/ZuQwKOjxAjqSx3XkCvCnjeFE1DLZ83lcY3bM9s0
	BqRQIAkl/yLHyjNS+U5E5bzei8Mc8bkITuf0YsGk0jWhTRIAm0p9fK89b0e63oDNUGY=
X-Gm-Gg: AR+sD11xivG1DH3NKfOMLprd/6vqq9UQgAjv8b5/s5UmAKl3cqrYyc0aj2lSXdzgdZ8
	WtXXaX1bnSv6z2dEpUTURJstLnIbwcOvFFpXu3yBKHp9/yvixaoOayzPWydJQePVMV0p93hfLbZ
	2vEFJblgIrus2V9U4g5R092DXFa4hLEu/yRpUQosPYttoXtm56hoAERSQt5OBRX/GL/MYi4rDtH
	ddckL0qww9zbqdolfHRHA03fE3oY/rPoVWVLZwOklvDchNRPJRHk1TT1JqXJh0eMtATExJ3Sdo6
	ZHJ9c/Yc4CYlolneDLHUVsXjycffNWxLF54an+axLv/t2uNC6JMyRNIiUZmisZutmL6uERED+3X
	2iAB5POrejVJ68DRtOa12g+sGYHcKkelRKu1Zf7TAIaPkxC54cim26g8nx4E1nl+DbmPBQPiSi2
	3/1hLI8hpCRo4GRQv83pdfctxvSHvKY0r3/NTSNQ8ICK4AEyrTSu0G9+hrJdIZo6UzOMtpLNRmy
	Aayy3YRhVUcMj2fSetuAJOcyU288Xaad5QDnVokChy5eVLpOnaptWA5DTgsY+Rc3hDDqx2ptkgK
	IomEGLXSX7gMuk+Z5aXv+6YxetCAQ7Vr4F0=
X-Received: by 2002:a05:690c:6892:b0:81d:d035:eb4b with SMTP id 00721157ae682-8225ba2bd22mr40559047b3.19.1786086575744;
        Fri, 07 Aug 2026 00:09:35 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0e64324sm5230367b3.19.2026.08.07.00.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 00:09:35 -0700 (PDT)
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
Subject: [PATCH 3/3] Bluetooth: MGMT: reference-count struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 16:09:16 +0900
Message-ID: <20260807070916.85771-4-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807070916.85771-1-baul.lee@xbow.com>
References: <20260807070916.85771-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_submit() stores the caller's pointer in a work entry and
takes no reference to what it names.  hci_cmd_sync_work() drains that
list from the head on an ordered workqueue, so an entry queued earlier
runs to completion before a later one is looked at.

mesh_send() links a struct mgmt_mesh_tx onto hdev->mesh_pending and
queues mesh_send_sync() with the raw pointer.  A MESH_SEND_CANCEL issued
before that send leaves its send_cancel() entry ahead in the queue, so
send_cancel() runs first: it picks the object out of hdev->mesh_pending
with mgmt_mesh_next(), which returns it without unlinking it, and frees
it through mesh_send_complete().  Nothing invalidates the pointer the
later entry still holds, so mesh_send_sync() and its destroy callback
mesh_send_start_complete() run on freed memory:

[   43.618774] BUG: KASAN: slab-use-after-free in mesh_send_sync+0xec/0x1b4
[   43.618851] Write of size 1 at addr ffff000009f2a6a9 by task kworker/u5:2/148
[   43.619464]  mesh_send_sync+0xec/0x1b4
[   43.619531]  hci_cmd_sync_work+0xac/0x128
[   43.620882] Freed by task 148:
[   43.621171]  mgmt_mesh_remove+0x94/0x110
[   43.621218]  send_cancel+0xd8/0x1cc
[   43.621270]  hci_cmd_sync_work+0xac/0x128

Offset 41 is mesh_tx->instance, the only byte mesh_send_sync() stores
through mesh_tx; it reads further fields of the same freed object, and
hci_set_adv_instance_data() copies 31 of those bytes into a live
struct adv_info.  The free and the use are consecutive iterations of one
hci_cmd_sync_work() loop on one kworker, so queue order alone decides
it.

Give struct mgmt_mesh_tx a reference count.  hdev->mesh_pending holds
one, and every pointer handed to hci_cmd_sync_queue() takes a second one
that the destroy callback drops, so a cancel that unlinks the object
while a work entry is still queued no longer releases it.
mgmt_mesh_remove() becomes an unlink plus a put and returns early when
the object is already unlinked, because it can now outlive its removal
from the list.  The list reference is still dropped under hci_dev_lock()
only, so mesh_send()'s use of mesh_tx->handle after queueing stays
covered by the lock it holds.

A cancel that arrives before the queued mesh_send_sync() now lets that
send run rather than freeing the object under it; suppressing the
transmission as well is a separate change.

hci_cmd_sync_dequeue() is the other in-tree option, but
mgmt_mesh_remove() is not given the hci_dev it needs and cannot tell
whether the work entry has already been taken off cmd_sync_work_list.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bluetooth/mgmt.c      | 25 +++++++++++++++++--------
 net/bluetooth/mgmt_util.c | 23 +++++++++++++++++++++--
 net/bluetooth/mgmt_util.h |  3 +++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 583e05ec4377..c562f8c95294 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1127,13 +1127,15 @@ static void mesh_next(struct hci_dev *hdev, void *data, int err)
 		return;
 	}
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mgmt_mesh_get(mesh_tx),
 				 mesh_send_start_complete);
 
-	if (err < 0)
+	if (err < 0) {
+		mgmt_mesh_put(mesh_tx);
 		mesh_send_complete(hdev, mesh_tx, false);
-	else
+	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+	}
 
 	hci_dev_unlock(hdev);
 }
@@ -2322,7 +2324,7 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	u8 mgmt_err = mgmt_status(err);
 
 	if (err == -ECANCELED)
-		return;
+		goto put;
 
 	/* Report any errors here, but don't report completion */
 
@@ -2332,12 +2334,15 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 		hci_dev_lock(hdev);
 		mesh_send_complete(hdev, mesh_tx, false);
 		hci_dev_unlock(hdev);
-		return;
+		goto put;
 	}
 
 	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
 	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
 			   mesh_send_interval);
+
+put:
+	mgmt_mesh_put(mesh_tx);
 }
 
 static int mesh_send_sync(struct hci_dev *hdev, void *data)
@@ -2538,11 +2543,15 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);
 	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);
 
-	if (!mesh_tx)
+	if (!mesh_tx) {
 		err = -ENOMEM;
-	else if (!sending)
-		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+	} else if (!sending) {
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync,
+					 mgmt_mesh_get(mesh_tx),
 					 mesh_send_start_complete);
+		if (err < 0)
+			mgmt_mesh_put(mesh_tx);
+	}
 
 	if (err < 0) {
 		bt_dev_err(hdev, "Send Mesh Failed %d", err);
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index a822091f2907..c7543964525a 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -422,6 +422,7 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	refcount_set(&mesh_tx->ref, 1);
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
@@ -438,9 +439,27 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	return mesh_tx;
 }
 
-void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx)
+struct mgmt_mesh_tx *mgmt_mesh_get(struct mgmt_mesh_tx *mesh_tx)
+{
+	refcount_inc(&mesh_tx->ref);
+
+	return mesh_tx;
+}
+
+void mgmt_mesh_put(struct mgmt_mesh_tx *mesh_tx)
 {
-	list_del(&mesh_tx->list);
+	if (!refcount_dec_and_test(&mesh_tx->ref))
+		return;
+
 	sock_put(mesh_tx->sk);
 	kfree(mesh_tx);
 }
+
+void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx)
+{
+	if (list_empty(&mesh_tx->list))
+		return;
+
+	list_del_init(&mesh_tx->list);
+	mgmt_mesh_put(mesh_tx);
+}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 20810cf06e81..b38970c1332c 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -19,6 +19,7 @@
 
 struct mgmt_mesh_tx {
 	struct list_head list;
+	refcount_t ref;
 	int index;
 	size_t param_len;
 	struct sock *sk;
@@ -72,4 +73,6 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle);
 struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev, struct sock *sk);
 struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len);
+struct mgmt_mesh_tx *mgmt_mesh_get(struct mgmt_mesh_tx *mesh_tx);
+void mgmt_mesh_put(struct mgmt_mesh_tx *mesh_tx);
 void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx);
-- 
2.50.1 (Apple Git-155)


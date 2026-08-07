Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BF3ACF0F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086575; cv=none; b=je10IpqfjayW0IVLZxp9SkMHe1V4TJkWGUmOfZkPnRFadn5Ha/S2rmamr+ahsYnZx8rfxsjjkbRrh7U7YfPQldIHc3ka0vEqhh8nx9nqtwIUDZlktxRc9iOLAm4cJogEjkNHLQVqOddznSipnIfvuNklVg7TU7lOvVsMzV2TXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086575; c=relaxed/simple;
	bh=V023K0hi+oTiFbDLsSZ09eMRO04DxQuoCoXXxa/kW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTT6ke/aBIa9JPELlmH7szctBWjHILJMCdsRTmsW049Bw8IU9kzSg4YcUHiH+dj8YN1Fe7yrhEgQQc597+TEjAzwUO4EIVSg2drzwSVmW1kQ5BGlW5zpi37Me35S2RxTupMGeAOFargU593kLYO3115KSGJ384vaOtl0f+TQBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=RXPIn0Un; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="RXPIn0Un"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81f64e8dfbcso46779267b3.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786086572; x=1786691372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37V6VQj6ErQve4E9JugrxkbUJ1j5iYQpNy21OTRUL8c=;
        b=RXPIn0UnQYlgeFRd047u3mvtsblpsPMAPuEVb8jKeoL2Y6x+vQu2ZIT7XI3lggHYlv
         gHRsGJfMBlsD5BDYXCZk/gu7EJackap+ivcbwWU3uXl0Ojq5FyjtDF0Jtncm3KD8vdmz
         CzkKhYG3RJbg87IRlSUiMG1oJPDS24u0X244pGnKWUd7MMXJZmp2qXWZneraYe4vdvdy
         PFnME4YzTKziHVXMip+N3a8AENxPgmIpK/0F9UQvmtkdHHRIX4y5ddjEIuTOteF25FE1
         lY6ktygKmHIAQq7bQ6PfYnYaEQeR+ENv+rr1ca/K9OaxZYE2EZ6+0WAg+IutU/m+U1Ac
         FrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086572; x=1786691372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=37V6VQj6ErQve4E9JugrxkbUJ1j5iYQpNy21OTRUL8c=;
        b=KKjPcgFhM1XhJWIolKkCJttxzCKcVyUT8bnd8YmAQPkMDzV0djzKZ4cXv39rhztnWS
         9pL1/8iQhVdffuqs5jhQap+ToTzMaQKxjNtVUheVuRioMotuk9xVGctlgTQZLDZbIAO4
         FUjiyhYDpeNgAvlJalgt3xd4nYD8Y00HzyyIP6GLEayRVLs31Nyk22WRPieXYKHpnDo7
         OTXBIeFEoAOCRpjGub+TooC3csqvoSo1aGFXHI7TZc9LQbRJAznEtioa6KKI+8Z0MO1q
         qA9fdVjPLSZZbf3a6Evn1HaqAcMWj3MvXup+ITe6MM3spnQLjNTvWbr5ZZkK/1IOzFrw
         imhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+Q+8z/a5zWtmvlsQ/cv7+ZvcQ9hjYqlD8xdPYlChTz3MO51jtELc1GM2qh57zuX4KAraSeoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQD1XBq268PeSYo5YhwEjNvoS2o7HoMneqcG9aY+gHK6D0ym+D
	Z3v2BIJpNw+SRI1tx2hjSGj3pzjG4Ch8yifNfOO9mBw+4H2Chu398y1GXPZQjSxqzO8=
X-Gm-Gg: AR+sD11jIDcKtzT5jOQdc4c1hfV1G3fiquBGHFR0k5juQy2ZD8xCYN2aQznbYFE5pGg
	d2T40MpuMM8B+RZuDkIySZYeDqVuy6yMQQLYhOY5CJx+j3QEZEdS6yJpumcjT/EoVJ+65gv0pg3
	1LCEJi2ybzVCVt8GwluQu0yvFg8Ul3iifyRC/I9EOl0U3WVsWCbNr4TOLiYSAgyRRe4tewjDopM
	ipWj8qB7Zdon/9GrigaxC35b08IacD1Egk0rnTspOOutGkKPAYCud2KMCcXP1tH8C5v/d2oGfAD
	dA3rXs7XCSt8hi4Y9N8rVAhW8NHm4MLI6cQzInrDi6gkw8i9bAqwmTyagZ6rziz4dDVnt/k+YJd
	ds5SZb9T/FJJCp2MXgnp64BCR9axn7mwKxkCiB6DePSg41IjCZlhwrziHEqir7m69GpVXus7xKg
	HjEQBqYq99sB78/fKRFD4dp7cVnf8kCLasfLx8IJ69DQ6wCMw6mNDqYs9hq5jJkoHeRTCDhqkCl
	+FukjNeC6BIP3wEoI0jilkXdxY49AN55hoV1U/Laxo14qh+l9rbXsPKPc79J22MOR967HfpBeel
	Onr5KtjiFCE9YhxTpMes6dRkEPCnLVbBquM=
X-Received: by 2002:a05:690c:4dc5:10b0:823:2ad3:d39a with SMTP id 00721157ae682-8232ad3da8cmr24377367b3.32.1786086571847;
        Fri, 07 Aug 2026 00:09:31 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0e64324sm5230367b3.19.2026.08.07.00.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 00:09:31 -0700 (PDT)
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
Subject: [PATCH 2/3] Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
Date: Fri,  7 Aug 2026 16:09:15 +0900
Message-ID: <20260807070916.85771-3-baul.lee@xbow.com>
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
index f13e73e3814f..583e05ec4377 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1081,6 +1081,8 @@ static void mesh_send_complete(struct hci_dev *hdev,
 {
 	u8 handle = mesh_tx->handle;
 
+	lockdep_assert_held(&hdev->lock);
+
 	if (!silent)
 		mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle,
 			   sizeof(handle), NULL);
@@ -1095,11 +1097,16 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
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
 
@@ -1107,11 +1114,19 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data);
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
 
@@ -1119,6 +1134,8 @@ static void mesh_next(struct hci_dev *hdev, void *data, int err)
 		mesh_send_complete(hdev, mesh_tx, false);
 	else
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	hci_dev_unlock(hdev);
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -2304,12 +2321,17 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
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
 
@@ -2415,6 +2437,8 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_mesh_send_cancel *cancel = (void *)cmd->param;
 	struct mgmt_mesh_tx *mesh_tx;
 
+	hci_dev_lock(hdev);
+
 	if (!cancel->handle) {
 		do {
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
@@ -2429,6 +2453,8 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 			mesh_send_complete(hdev, mesh_tx, false);
 	}
 
+	hci_dev_unlock(hdev);
+
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
 	mgmt_pending_free(cmd);
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


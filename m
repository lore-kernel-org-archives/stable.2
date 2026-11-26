Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795701642;
	b=K9My+gYI2798LSrqoQoaAytWrgjpAgU/mRhIKkHpNCJTloyZ8OQhGspwyZk0u8izDAvs
	 IrPIBM1obbhqsHsz2uOOPIe59R16pG5/woMNFObDPgFXV1A1jnAaBjRJby4bSjJQJQ8RO
	 yqpY8gLwH92bj4XOsbmSyFhzya4SUcXQ4aRdqVukYxubDel0+tJ0iewl89woSHs9zRA/o
	 MgP3cSiFnmkHXNX18AEszPNDFJgnLZ7aCzfAxsD/hWeXw94TUhplz4p2Q8NXyCMkrC/p/
	 lqdvObnG1bqfvEqyn8U5at6nWmKSSqW2b+MP+0sQtyY5sc/FxYz0BaEGrKg3VLOFVGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701642;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=S65x+I1GFn5ftefFzMVidQ5A5B4xCjVERLy7lksSAbo=;
	b=Egisc0mEWO3uvcXsZdfTkHmrPU1K503yFTxUMeVQcniqBQZTSw+KNci4EBZ1OdhWv5ak
	 QMg5ZGFvA4G8k8L21Zo7qliq7/zomA39NeeA006o8wkK+1JQu/bZl9sUoZGfT4epeu6z0
	 h9TD5j5j6+GFeg3kPUxHMMkkIlgpdgbRMXcronPOXcomxtdlfMj6yRMkPLOh1hVfTjr4+
	 mwbWxkl/K6mtQLZkEis/DXAGduwDB5f6AtmPX8Nf7OiFlHsM1YUagNSiAsbFb6LeTQePo
	 KfAzL5UZRA4N6Y8VlGNaUuVsx7FSMeuBJ0dEjSFBCpf3hF69W2pRcIOj94XZbo5fHCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOlNxFJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6F606A31C;
	Thu, 26 Nov 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOlNxFJF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795701641;
	b=gTlaxFNlweDdKM9trJqPWFZ4AEZWn4KaBVAUEnG6kgOZ7QDCLFqgM530v/uSedt3J5nj
	 QYE6oV5j/23J/RrYgeOX7cp/IExneArGTPsRoyg7X/tCyVPuwRqE5mYKVd+lUnfGnJgOi
	 801LH11YDTvtAxxC58YTQZ6P70DuYThp83OgN9ePR1PKumNUcX/iBJHIPvwYTFE1EzMrt
	 WJUzLdJR79T4aqg3JekUFVzj5bJPV7i5HkAz2z82WcGirD0dzcLJOj5no32qtULH0wjOG
	 UsXla0vC31hB7qfkT8IlqEMpJWcFlnAeUWDfwBekHjoMcEUeOJf8vJ8eP64K8z7ELWQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701641;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=S65x+I1GFn5ftefFzMVidQ5A5B4xCjVERLy7lksSAbo=;
	b=o6OIKbun0ojsB0TGbQ53vWYgg0HaZAITYs96LvMfZBX7rEqaR+293t9UnWtiHcy51RfI
	 Gnhw5NXfPhSS1rqDaZ5viqVjjSwWLVO8SFSodNPyw1aiSafp+7tbU4Ef7UYWZ3sao+Rvy
	 yO0FjgjIxKL4eRcUhMtr07uqYhd/1C9uizh55qPvmWD0euE1vKLMpDc0YaZVvvNryDUXe
	 TfqmNbCvjUR+THeHOayCo7TdCbxPqM5abdTpoGYArXvUgB9PsvrJgpAVTpbMrN03NON2G
	 OtqWuwdZhPmYP+CtCDL5iKRwS3mLN4S8G2IjeQ6hjYbbHi/q4Z6cfVlSoCHuQzn8L/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F363E1F000CA;
	Thu, 26 Nov 2026 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701641;
	bh=S65x+I1GFn5ftefFzMVidQ5A5B4xCjVERLy7lksSAbo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FOlNxFJFMxer6W9rIuFZ09Hr88L74Xf8VcjiYQ0i2TzVvv0/WMHee6SarYBOO+0QD
	 wYVnuK9C/uz5tWKQAR/zLVp5q79HlxSdgpXUxIez8Gmi7RfY62ueIkDUmUjd+47udg
	 4OCLMvDeqCgOZgNdfKFXtebEtDHEWt4h6qSa0Oqu7MMfjQHJQSSMapofIqnzJokQZC
	 ZqXDVphTuAUQuPT1T826LmoNbPyKTQnLcW+U/CPMgA2VARqPKb5ndNpvN/aJA3JYiR
	 1dYZvAUpoZ759IJU2ltufvf50//qCDPjIazCRTkIs8tNcuCwk4wMrIBt+rnPy9IqAq
	 3Yx+eHRPH1e9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87C2F4D556;
	Thu, 26 Nov 2026 14:00:40 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 13:58:37 +0000
Subject: [PATCH 5.15.y] Bluetooth: hci_sysfs: Fix NULL pointer dereference
 in device_del()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-so1b-bt-515-v1-1-e657824c0e45@certik.com>
X-B4-Tracking: v=1; b=H4sIAAw7CGsC/02NQQ7CMAwEv1L5jAsOSgV8peIQpy4NQgmKAwJV/
 TsNXDjuaHd2BpUcROHUzJDlGTSkuAbaNOAnFy+CYVgzmJ3piEyHmoiRC1qyyIf9kdmLk9HDurh
 nGcPra+vBtmTbN5x/XB98FV+qqjbZqSBnF/1UkUocSko3rHz7dwHL8gHwngL2owAAAA==
X-Change-ID: 20261126-so1b-bt-515-b839bbceaefc
To: stable@vger.kernel.org
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795701516; l=4954;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=YDEClDvnL/97beq6Fz8yjuMxJhlC9v3p+nU96NvxVoQ=;
 b=Q8XXJIUwbTeo/PTcLm4fMXcxNFn8IThehr4UX2Xp6LJB9tFjFVzBN9uWLlnZnODfuB8x+EmdS
 7V5HOoGK52tDj6tV6dbA7vzxqmIseokd27AgDaFXWg3N4rdkb3jzlyT
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Krystian Kaniewski <krystianmkaniewski@gmail.com>

commit 9b851b09b392da68bd715601f10a5adb2d8d19b8 upstream.

A NULL pointer dereference in klist_put() occurs when a child device (such
as a BNEP network device in bnep_session) is concurrently being
unregistered while hci_conn_del_sysfs() reparents child devices.

This is caused by a race condition between hci_conn_del_sysfs() and
concurrent child device unregistration (e.g. bnep_session calling
unregister_netdev()). During device unregistration, device_del() snapshots
a non-NULL parent pointer. Concurrently, hci_conn_del_sysfs() finds the
child device using device_find_any_child() and calls device_move() to
reparent it to NULL, which removes the node from its parent's klist and
clears knode_parent. Subsequently, device_del() calls
klist_del(&dev->p->knode_parent) using the stale parent snapshot, causing
klist_put() to dereference knode_klist(n)->put on an already removed node,
resulting in a NULL pointer dereference.

This race was introduced by commit 27aabf27fd01 ("Bluetooth: fix
use-after-free in device_for_each_child()"), which replaced
device_find_child(..., __match_tty) with device_find_any_child() in
hci_conn_del_sysfs(). That change was intended to avoid a use-after-free
where conn->dev outlived its parent hdev->dev when child devices held
references to conn->dev, because conn->dev only held a reference to
hdev->dev while registered in sysfs.

Fix the issue properly by taking an explicit reference to the parent device
with get_device(&hdev->dev) in hci_conn_init_sysfs() and dropping it with
put_device(parent) in bt_link_release() when the conn device is freed. This
ensures that hdev->dev remains valid for the entire lifecycle of conn->dev,
resolving the underlying use-after-free. With the parent reference held
properly, restore the __match_tty filter in hci_conn_del_sysfs() so that
device_move() is only invoked on persistent RFCOMM TTY devices as
originally intended, eliminating the race condition with unregistering
network devices.

Fixes: 27aabf27fd01 ("Bluetooth: fix use-after-free in device_for_each_child()")
Assisted-by: Gemini:gemini-3.7-flash syzbot
Reported-by: syzbot+6df45dd3d03e1a9aca96@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df45dd3d03e1a9aca96
Link: https://syzkaller.appspot.com/ai_job?id=f1c0e740-db21-40af-a9ff-84db0fd8b8bd
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ adapted to 5.15.y: device_find_child() match callback takes void * ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. The only change from upstream
is the __match_tty() signature: device_find_child() takes a void *
match argument on this branch.

Tested on v5.15.226:
- x86_64 allmodconfig W=1 build of net/bluetooth/hci_sysfs.o, base
  vs patched, no new warnings
- booted the patched kernel with CONFIG_BT=y under QEMU/KVM. I didn't
  reproduce the race.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 net/bluetooth/hci_sysfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index b1886e517a78..89cd9ea1ba43 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -11,7 +11,10 @@ static struct class *bt_class;
 static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
+	struct device *parent = dev->parent;
+
 	kfree(conn);
+	put_device(parent);
 }
 
 static const struct device_type bt_link = {
@@ -19,6 +22,16 @@ static const struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
+/*
+ * The rfcomm tty device will possibly retain even when conn
+ * is down, and sysfs doesn't support move zombie device,
+ * so we should move the device before conn device is destroyed.
+ */
+static int __match_tty(struct device *dev, void *data)
+{
+	return !strncmp(dev_name(dev), "rfcomm", 6);
+}
+
 void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -27,7 +40,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = bt_class;
-	conn->dev.parent = &hdev->dev;
+	conn->dev.parent = get_device(&hdev->dev);
 
 	device_initialize(&conn->dev);
 }
@@ -67,7 +80,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 	while (1) {
 		struct device *dev;
 
-		dev = device_find_any_child(&conn->dev);
+		dev = device_find_child(&conn->dev, NULL, __match_tty);
 		if (!dev)
 			break;
 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);

---
base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
change-id: 20261126-so1b-bt-515-b839bbceaefc

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>



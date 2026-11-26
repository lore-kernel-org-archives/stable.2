Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695835;
	b=Ij+p/wQCTf4nw+PRuexOvjZhDO2WtJRuNqvoUEhifoHvD2BWd+qnJLiWeBlooOOmyOaI
	 +1HkvhbgO72pJa7JHfHxcHUWRNIWfXZ8OiRSHEGDByUbGx+iK5KN0lOz3OJmRE6rd6mID
	 oz90mYBwA+BEf0s39hzmklot/072MCJoxcWp7ZtMaiAGngXRHcKHWOy2tFXsb7kQqKVaM
	 9yzbYBscWGRLZ8VFIf0mUvB5VtCBNRtlSbzrM1I4h/Ma4KXlxaNtjLp141sXgf808fICr
	 FcFymha7ov1smxwgLbI5sD/aJh7Kk4e/Jo8OADd9Dun8v6MtzhayBx+2DIboLWQNeAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695835;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=iJzrRVs9RQ4G2YFEK+V6KlkfumNBBKmZb7GN7c3YMF4=;
	b=NnXHom7e/v256jdYPZqSyk3n6uG43+es4ipKFX0l2fOXZ2iv2j2wjUXQZADxpSoi/ut9
	 ZrZZIkMIOctexojY+Y5ggPXzHLTRJEFWp5zQuGMgCI67FcMV6TMQNhXlPuaxTn42BhFJ6
	 IkT7AGrJPWgSwCv7yaLiTn3Ow5W1SZ6HPKv0Tv4DaDRb/aXfyfSEh77IG7n7xHVdTTheu
	 6xWpTGEJlK6sKllQfhHAbQW3GGusClIgWz9lA3Rep8Qwi+2GXkHt0TXvjKW0om5/uQ9hr
	 jRAk+n4SK/E7ZsHuzCsSwTxLktQxjIQPePASLPlxmQ4q3dizWEaaZpH/AQia1bqytKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHHPwdYZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943E606A31E;
	Thu, 26 Nov 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHHPwdYZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795695835;
	b=v14Kw95cHlm8vDDXpWGIgW4+ehUHYxckuTSZU6VSc6NPxPlGOpSX0nnFg2GO8Ho2sENJ
	 16UNX8hq0Q2xJz7Y7ZZF8iLTf89vTWhGZBe7F66n2BcHiTy4KlVtRM9K0qZ/7zApceHLb
	 TlSLkCkqmd7JfjBsy6y3fjK5HD45Y94DejcNvXYq5aT6t21nufiHH5kvqTsZsv9kaZemq
	 wYeNUjO/UQDUBq+uB6tD4fRYMjNnscbe2ysCFwANlSmQGjktrKKjVq94UXwH+wvMOxkcz
	 efNtsRXg6YigvZCQDmmOrqxS5GMXm9//8N3wf9hErrZmqwXbDIPrySRrym/jppH7X4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695835;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=iJzrRVs9RQ4G2YFEK+V6KlkfumNBBKmZb7GN7c3YMF4=;
	b=VbDuarfyQJUolAOSOXVENnE9nrEfyh8ohDAfz1hscJrYpacze8vqHccM48WHoPD6sGRL
	 XfvzW8fFgwzngiA5jD0+9smwdYCl4pgQjoITCanBtu+hRYVrj6YQrmjmfZgq5NEEyzUjJ
	 BinKFxpuDY2Z819xj01Th81ghk2y8gmsTVaoDDuwOC3lysdFK/fUtylySXbCSYceNjSIN
	 dA9K2mM+z85PFEfjIu3ngfvXzQmd/3KWyxmSHs2+pJ7GZghupWOuEfjHUHg4MZ2nQ/2bZ
	 Jd2NdlI21GUjbNAFJOz3gJ5k8LSKIOxMqPGtCYzSNIyLIfNz2fGzebUzIWTF5DCAyoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BA5C11F000C4;
	Thu, 26 Nov 2026 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695835;
	bh=iJzrRVs9RQ4G2YFEK+V6KlkfumNBBKmZb7GN7c3YMF4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VHHPwdYZiH6CCGRzyqpCKlJynJqUq9uTXkmnUIrJOZarWTMnXVx8+FsX907uz5h6i
	 NXWPD69jHYiObGKBYPIZmXG81qGLE3Wh4oZlJ0Qd+oMS2vbESBXHRPwX3jjXDcwpwp
	 hRchhHOfU4nePrby8oOsivDkkLKOOWYMljYDlvpu3/vUvHwhBQdfxyDGpTbO2t/qBv
	 gnSCX+5Lvry7dhgjjHKCcHREbszW7Q7jBYFqK6/k65eMRBttz69R52HlruhUH63uD/
	 LYfnel43T9Y34vdQxbJzpqKXg2nfpHu5VRHyTl49L0uPbv5mqTZDDgXDQn9sSVkbc1
	 aStDfjCTbJK/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 47BF14D406;
	Thu, 26 Nov 2026 12:23:53 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 12:21:49 +0000
Subject: [PATCH 6.1.y] Bluetooth: hci_sysfs: Fix NULL pointer dereference
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
Message-Id: <20261126-so1b-bt-61-v1-1-8d8aab8cdda7@certik.com>
X-B4-Tracking: v=1; b=H4sIAFwkCGsC/0WNQQ7CMAwEv1L5jAvuwVR8BXGIU0ODUILigEBV/
 04CB4472p1dwDQHNTh0C2R9Bgsp1kCbDvzs4kUxTDXDsBuYaGC0RIJSkAlpP7Inr8I8Qh3cs57
 D6ys7AvfUv+H0w/aQq/rSRK0ozhQlu+jnhkzjVFK6YePb/wGs6wfPlBC0oAAAAA==
X-Change-ID: 20261126-so1b-bt-61-1786c1ceb668
To: stable@vger.kernel.org
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795695708; l=4951;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=AOy+xS7hWv9W3/G8I56JVzz4ZYrY5cSCIxB/uF4Cbxg=;
 b=9cwHTY3N6WIzmbMAT9KH1Rt/TJNmQyTvNO8w4O0Q1LdYtzOr2jal5fci36k6FvRzVE/YR7pnb
 9wYXXYSz1VuCQLn/Ryvpx/+CzyC4mOIbkXUuf7eYPxJURIs1kwhAP4T
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
[ adapted to 6.1.y: device_find_child() match callback takes void * ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. The only change from upstream
is the __match_tty() signature: device_find_child() takes a void *
match argument on this branch.

Tested on v6.1.193:
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
base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
change-id: 20261126-so1b-bt-61-1786c1ceb668

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>



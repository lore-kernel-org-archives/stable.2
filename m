Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795701624;
	b=S3IRwI5YsMBZ9bo1YYuysW84b3Xqd4V03SUr8txQ4VLCAUZgBL93RrNARr967+5hYQU6
	 R4JTRQyLaiG4qt4/OSgIoOvfHN2oaqGgUZyZf0LLMkgSut3oHW6zG68Psxg0rLqssOQ/t
	 r6yemI5EFXYJlmVmLAn/9jm/kZjbckEO1iDSWZAiC0qlOff/gdTR3BIzcdQzsMmxEXDhm
	 EvGFdKxnkou9WezxQKJxXElaFU7U2clz6HjfzAEu9dYFulE5I54Hw5FYwoKnIRuWAqygG
	 +18SxDW4ie3kC+VOydijveCGhq5A3nDYA6+bpMtguziF5FZvDQeO+pjPXOEwq+bORtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701624;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zNF9X7rTDVeQIL1qXMTFZqIj160rbEREzKVYWf30DKU=;
	b=B6rFS9dh9exqi4tQS70w+PtVu9NtSBcScagjpv0Ly8JJ4tFIexQZTH8k6FYETHIfaYOY
	 UY79hj2VRI8y8puh0BehuvUGN99QxNVwLYYU2K3IbNXZuk15+JhZmQCC+dALmw8B6y1xq
	 7X/3hrl2HNKZWnukXnlj0TAJBLwVw2krIrLVIlNvf7mzPMZ4TwepOj+r1MvQbIygiyJB8
	 adlvl6UwBjFDAjdgVn0EfQGrft45cDROBQ+GJp5fj8C3oPZN4+Wr1E3ZKpq3s7Z/Xv80p
	 nHK3+DhdYld+71kh3PTd+bcuYYzVqsN4bcCMV/6IN65zaDe25xawG09eboKUZa0A0ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="InqO/hi2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F2606A323;
	Thu, 26 Nov 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InqO/hi2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795701623;
	b=I6sIrOrEP1k+ElWoY5ooPZEELJ/o/UV5JAgwcbIjYSlLY807F8dA7JGCNFTj3dg3LE4D
	 cT5rbhkG5BEkN0jdYaT9dPBzlED7mfLOM7VFV+YpIovw1PZ4/N+CUhH7KrSJ7GuB70BUF
	 YDEn7CrUjTiw3UNnX3tfLJf1S1/yslS/84OAdhu/28Op1TCWAvqxSf9tHh+EvzIt3YZyG
	 zp7jU+At0rcaZSrd3kmH14O/E6BHmhOm02MRLEmlcnpWzUSUQx9TBqODq6F0nE1AFN5wj
	 v+HZ6PF+0Gj1sZpYFruE2v/PUTN/2oApoTBeg40CZqPk40yFIFKfndxJDLiCG1qU8mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701623;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zNF9X7rTDVeQIL1qXMTFZqIj160rbEREzKVYWf30DKU=;
	b=CeYf5o2cuhAn0LPHDUMKYBYlVh2mSq/Ms+K8o/6kHlx2w4bC5wRqFgcrFlNbQtlOuNGZ
	 lTzofoOoueUAw4kkBx2iY9VNzsHqMkQckCFLYifTsXsFEGYPgCRQsZuw4i+UZG7AnyMsP
	 ZK9vYBFGle5g4Y4ZlFWykRZmMvBuBPPlpIXRmM9jtZ8gvAEtf3maGc2UeZcI35wca/iKL
	 jIPmCcz59sM2uaeYZXBm72znQMaoSHenmKxxRFy5XuDjcfhgAn4BeENeQelTkHL76mZFO
	 v/754JSZEj7HZYvBAY2d1Hs/fS1/Vs1YaIUpdMlgA3yjrXMcpW/TD0rEpP48YGogkdA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 21E6E1F000CA;
	Thu, 26 Nov 2026 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701623;
	bh=zNF9X7rTDVeQIL1qXMTFZqIj160rbEREzKVYWf30DKU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=InqO/hi2PY2H0BZmZU+EytewMAqGDh8riYT7DZ3R1t5wp4XydOkybWuROU93irB3G
	 NPrJ55gTsthtqPzPt4P9rDPfCTkddwLbjcEcG8N2ohYfUhzCAwB+v33P0ofpPIZ09n
	 d/hOFZ3aGzh/OTyIRbRjNTlM3pQhocyTk0WFUlzim9ACxZ7RhjrXC8YiPiH06xnrY5
	 dXlDOvC+4K7clTao9cnqXtZmVmYOimaMIhyess7kqt+iHsBS6fHKLz78KRAArczyuv
	 BihwKFO8Ch1ZgnjV3Nrheh8igfUnnYGLYLwIEIbgIpzd2qyqAzFnyZCqP6WRmjMEex
	 dNYxt4F6qxQjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA1484D562;
	Thu, 26 Nov 2026 14:00:21 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 13:27:45 +0000
Subject: [PATCH 5.10.y] Bluetooth: hci_sysfs: Fix NULL pointer dereference
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
Message-Id: <20261126-so1b-bt-510-v1-1-bff6435e792d@certik.com>
X-B4-Tracking: v=1; b=H4sIANEzCGsC/02NzQrCMBCEX6Xs2a3ZQAr1VcRDfrY2IolkW1FK3
 91ELx7nY+abDYRLZIFTt0HhZ5SYUw106MDPNl0ZY6gZtNIDkR5QMjl0CxpSOBmlwjiwpZGhLh6
 Fp/j62s5gelL9Gy4/Lqu7sV+aqjWdFUZXbPJzQ8IpLDnfsfHj3wXs+wdAO7bZowAAAA==
X-Change-ID: 20261126-so1b-bt-510-f500d96ea19e
To: stable@vger.kernel.org
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795699665; l=4954;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=2oX3LmQzgfr3BLUZlIpwA7c1t5yFys2nt+Hejx0BAwk=;
 b=Q/WMqm6+5wK4cct2DfIgsskUFNO6dHHehcU5WtF07Vc4fpJ73yhbvSNB2PbNtUYtfz0ynUHut
 ph9reLzilTfDMGr/E357CMprNkw0FblVHYFt3HRjbXRV18gAsn336hF
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
[ adapted to 5.10.y: device_find_child() match callback takes void * ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.6.y and newer already have this fix. The only change from upstream
is the __match_tty() signature: device_find_child() takes a void *
match argument on this branch.

Tested on v5.10.275:
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
index 1b4d81ffb4b5..3d5e76992552 100644
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
base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
change-id: 20261126-so1b-bt-510-f500d96ea19e

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>



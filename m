Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598730;
	b=NNqHIIXOfK/UeVMcw/m07Q3P0kF7L6sVjYXGge690e1eeWTilmh2my8c5ocifyHp8p+4
	 3fgUWOfnOmDfAyA0k17TbpHLHkvEof3U0SkKykBeJJzRoleSLgf9jlcx32wlmwi1lB7Lk
	 AMtEZfI3205z98UjEkjnRA5bAeDw9LB4pI6nYvvFfAon4D+xmSJRkhixhzy6fG/46cQu3
	 j44ilvdYf0mCfYfHJj9OSat31wfCInON6C2+u8RF+d0juNpaAieIhyKmh7zL4LbqFNZ3f
	 C6AqlEPNS8O75BilKG59nQ40rg0QUHbdOZjOnFjZzekSeN31Qnu23nU9zUXvDpPUGgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598730;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MWXG/5o8xXSscDae02nFwr3+AtZebAH8n35z7ReWjnY=;
	b=bfO+2sCXmuoMBtD74xZynUhIJNPn9Ng+aj4q0hutEYwUFxMiR+e/0W26MBECJdPDNM6W
	 RyIcphQgqwL3HKZMly+zLwzzgoBXqNCCBEwmPnxMFm4yTrF7FWUPwVZwWjhoUsqd4EjMG
	 A54R3vZdKC3hFoT68mvdxrmWwa2McgvLuE5ZXEU43MEVDOQUMdjLtNZUjKXFh8x3Wi6eb
	 N7PmiJL3uz+yIY0xop+EgVSGVqWTiAskI92iXGxket69BWZxZkaTID+jxIfk74A6J0kCC
	 Ocz1qT4tciX6SZ2YUUpia0OnCnjO36/te9JI7fYSTf7xoWCnOyRC/ixX4kgjRFJ0N/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U3N4tmAe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535B606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U3N4tmAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A44F1F000CA;
	Wed, 25 Nov 2026 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598730;
	bh=MWXG/5o8xXSscDae02nFwr3+AtZebAH8n35z7ReWjnY=;
	h=Subject:To:Cc:From:Date;
	b=U3N4tmAexx2SsnPfMTMNGuaU/AGI26X1cPbMVI+U95hHta0xYGPiOq7YquAisrKxD
	 5Nx+hE479R8lctL12ptkhIykmkbFlF6oQn3ihbIjYc9mUqdCKhn30v0a30A+GAVbf/
	 0+OJM2p8+ELEAwSbufETaByJ3VuQT25CZJTLqVJI=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync" failed to apply to 6.6-stable tree
To: 25031212351@stu.xidian.edu.cn,byu@xidian.edu.cn,luiz.von.dentz@intel.com,wencheng@xidian.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:17:43 +0100
Message-ID: <2026112543-dislodge-padded-0851@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 868c886f45f7c10dc888b94c6993352702a84d04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-dislodge-padded-0851@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 868c886f45f7c10dc888b94c6993352702a84d04 Mon Sep 17 00:00:00 2001
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Date: Thu, 5 Nov 2026 13:56:39 +0800
Subject: [PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync

The force_poll_sync debugfs file uses the driver's struct btusb_data as
its private data. The file is created under hdev->debugfs and is removed
only when the HCI device is released, while btusb_disconnect() frees
btusb_data unconditionally. The HCI device can outlive the driver data,
for example when an HCI socket still references it, so reading or
writing the already opened file then dereferences freed memory:

  BUG: KASAN: slab-use-after-free in force_poll_sync_read+0x129/0x140
  Read of size 1 at addr ffff88800cfb7038
  ...
  Freed by task ...:
   kfree
   btusb_disconnect

Remove the debugfs file before the private data is freed.
debugfs_remove() waits for callers that are already inside the file
operations, and any later access fails with -EIO instead of reaching the
driver, so the force_poll_sync file can no longer dereference btusb_data
after it is gone.

Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during polling interval")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e6039..95398e2ca098 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -1088,6 +1088,8 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+
+	struct dentry *force_poll_sync_dentry;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -4820,8 +4822,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
-	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
-			    &force_poll_sync_fops);
+	data->force_poll_sync_dentry =
+		debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,
+				    data, &force_poll_sync_fops);
 
 	return 0;
 
@@ -4862,6 +4865,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	debugfs_remove(data->force_poll_sync_dentry);
+	data->force_poll_sync_dentry = NULL;
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 


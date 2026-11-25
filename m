Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598736;
	b=B5Y2/Rl8QX+HhaIvIzqM6/WyqNH7madUsZW0l2p3AScRoFt4s611UsKn4GuozXNb3a3L
	 vWnoBxiq+rMzkBIkekPl4cpL9B9LCYBAPV6iRYG8QecfKl14mWbFC2rRkpt/Zw0C2kWiG
	 1+LLVIBPns0yanambTL1wq9oGOKVmTuKW4S2rkL9Kw98JahOd2XDmyygHWGbjV+SKRuH1
	 9olF8hCBDLJ4DN2iz9f+Q50u3EZFbVNutVsOR7QNTDDHUHgePM3Q/WmXHMiWvPlud1X1Y
	 JMSq5EErVMVTnveQN3J2viZk7bs1TdNMOitz4A/3Vw9Rgxu+uy2tAWZGQc/WWBaj0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598736;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=81FQbijypQvFT+oapwp6d3v6T8Jp6puxNSWHELXcOjA=;
	b=p/WKN9jionVnuzHO/xXtGsJpc6QvlI4g6GWHcSjdPQQlu6z7Ji1L/oBVxArNSvB/bgHS
	 QX4kKqUS2qw+IaL7YZEdfGUmbYRNhVuDaeDyN0c2kA+m9E7XBJS0O/BEBrYrnewHMHlhc
	 WwHDClxktXFuI2nDrxU8DVRQdJRsc6LAtdMkMXBG5ZgkKI3cfRWfAofYKA0Cqa5Iv0xie
	 EfU2xipIzYGU+CcDHxlcR21WRNnq6ae3UYdWlQrFJrFYpmuav9/TUVHn5Rb1BKGF7ef9H
	 s5ulH+qS3uc/A8iP52RR8hjKxU7EuBJ3BVgVIjbP8+u7K/5eAeY1oTERWCp1XQtbeew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Le30l6tt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB7606A33D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Le30l6tt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CB21F000D2;
	Wed, 25 Nov 2026 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598736;
	bh=81FQbijypQvFT+oapwp6d3v6T8Jp6puxNSWHELXcOjA=;
	h=Subject:To:Cc:From:Date;
	b=Le30l6ttqUvL7TawKzU2RSzxikNHz9eP3YUuSeyIQwD0HAYLySl86AUizNs+beuI0
	 nmwdOLgiDUpJjCuewZBj9DotE8t0L647M3uzQCW7SXvHCpI6cqTbF4gJiSoxbSXLWB
	 jTJoDCbiol8qunDa03gxJMmELc6TUIQfEwioOlxI=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync" failed to apply to 6.1-stable tree
To: 25031212351@stu.xidian.edu.cn,byu@xidian.edu.cn,luiz.von.dentz@intel.com,wencheng@xidian.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:17:44 +0100
Message-ID: <2026112543-cradling-twins-5253@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 868c886f45f7c10dc888b94c6993352702a84d04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-cradling-twins-5253@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 


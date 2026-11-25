Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598727;
	b=1ThEbg6NDMCzahsU7BkksuXva9SyXr0vq47jA5v01GZ5RajkyzSouye8CqlM8pDOYOzd
	 qjp0DVxclegh1NrowTrOgC8u5LNRm0wUG10K6umUfGc/D52NS/fc9QdAAYtAvlm762HvB
	 PkwnKCe7dOUdraM4UztKRGrYDIDnJIg4RL5KArojZH9Pbw54HLa4X0PfXE6kiIhHzNUge
	 URaNl+ZvlAmaqn0H/4LqDPEmmgFFr/gGtMViaitULriZJ8qiY411wgMWxUomuhQRrctei
	 ikT1gsgyWzLiQqZV4e8R3gWyU0S0AKLRztTngcooW1eplhpn2QoxAnSYcO5LKUKUJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598727;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ktcjucnqdTrMnCRIyRtkkWnit46bU99D/QGVW7mPPk0=;
	b=S5oIHuAKp5lZEwwWsUDUamaTm1X26NLB272KVP/bNwbh3CnssdXC8+hkLPZaG8M86ikF
	 maMRcmLyNoFbXTm2xNkDfoVO+AaQihp/kp1pAXQ/Rlpi4kukz7c84ZfirOhvvhv6Rz/hj
	 I7RTUkhNT7dFxjbKqBWbbYOpsXAM3VzGigjg4Y3xrmfpPbwtgJDIkL7PzkZ+/PMCP/N0j
	 0Bp5mm+hJblt66atQQ5yq13v30QBYJFtLLjkEKYgOf9JLvBOFzTPoLKjUFu0wSshjbV2J
	 Dx4WoQsLCdRCrqUFZnhJbaBHDLEeUA1p8gCvtg5u4sPgnzi5Wh/aPoWEOfyybARLqJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YRHWV4PK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91835606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YRHWV4PK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC1C1F000C4;
	Wed, 25 Nov 2026 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598726;
	bh=ktcjucnqdTrMnCRIyRtkkWnit46bU99D/QGVW7mPPk0=;
	h=Subject:To:Cc:From:Date;
	b=YRHWV4PKcD32kbSw0//Go4Y6hM3m3rLylCoGiM1C0fJ64hf9oom0S8xiDetOddBLh
	 +JohtCCaz2caNeBlOu/fN9mqNVohiIxwUdnYRmKamuAI8RIAEaQzf/YXssbaLJ0IhA
	 mc0N35dypr5baMvs2oj6FAfLlyvmwCOHcIvYHxuA=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync" failed to apply to 6.18-stable tree
To: 25031212351@stu.xidian.edu.cn,byu@xidian.edu.cn,luiz.von.dentz@intel.com,wencheng@xidian.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:17:42 +0100
Message-ID: <2026112542-sheet-unloaded-b161@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 868c886f45f7c10dc888b94c6993352702a84d04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112542-sheet-unloaded-b161@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 


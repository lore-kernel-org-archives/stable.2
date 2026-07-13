Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DF424662
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948785; cv=none; b=UuqQWPVS1R5tb8Nd0A4dtUOv2rkHohFFI3scv2NGVEEN7UDspzhEutPHJsV29Z0e4opxkyhom/dem2M6bv7+z3AFOb9fbGXrktORLX0SQxikXBmbPWg10z+F/Uh74I6dEb7KjVXM/lTxr3ISkGe3Z8oA6mfwzljmBmbJiG0MD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948785; c=relaxed/simple;
	bh=GIbASpyvX+Qwi9toOQqdqcIgHN5JmsInDiNhwvvKHtY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FM67DbP2XK7rPGjTYIFucNICugF7m3foWsO4XZ72EI8XwVAJdhWnSyT0SAm/jjyFqFEJnEL+umi/cZlFj8P6RFXsfkg6VyWL6lMf66gq2/WsEgQQTyy7TnbsMtIPGw0b63MJ1eTX8w7kiBxknCrzJe1UQH5oQ+YFSnQnjUmYc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xGT9cXa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xGT9cXa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501471F000E9;
	Mon, 13 Jul 2026 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948783;
	bh=GQ7sOl4uc/GAPdbzIVGswFLC049ytuVlF79jvCiRI0E=;
	h=Subject:To:Cc:From:Date;
	b=xGT9cXa8B2bkHgpgrq0qmUfHPfzjimKRM0T7r/srJFmy5ZKYXh86vmzCG58AWKJk1
	 eDUlgxEAVaNAyz364SlTPC1M/vs1JLlnRcKZsFbgAtztbnBV1Zyp5wpoJxKSweqmvx
	 kv9s+cmsoS1v0FZkid+73w91p98jGLUVH7xb9QZs=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: fix use-after-free on marvell probe failure" failed to apply to 5.10-stable tree
To: johan@kernel.org,luiz.von.dentz@intel.com,rajatja@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:09:09 +0200
Message-ID: <2026071309-contempt-purposely-3c5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c5b600a3c05b1a7a110d558df935a8fc8a471c79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071309-contempt-purposely-3c5c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5b600a3c05b1a7a110d558df935a8fc8a471c79 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 4 Jun 2026 08:37:37 +0200
Subject: [PATCH] Bluetooth: btusb: fix use-after-free on marvell probe failure

Make sure to stop any TX URBs submitted during Marvell OOB wakeup
configuration on later probe failures to avoid use-after-free in the
completion callback.

This issue was reported by Sashiko while reviewing a fix for a wakeup
source leak in the btusb probe errors paths.

Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
Fixes: a4ccc9e33d2f ("Bluetooth: btusb: Configure Marvell to use one of the pins for oob wakeup")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c181e1a3eb3e..669fb3ebde4c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4237,7 +4237,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
@@ -4401,7 +4401,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 		}
 	}
 
@@ -4409,7 +4409,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4445,6 +4445,8 @@ static int btusb_probe(struct usb_interface *intf,
 		usb_set_intfdata(data->isoc, NULL);
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 	}
+err_kill_tx_urbs:
+	usb_kill_anchored_urbs(&data->tx_anchor);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);


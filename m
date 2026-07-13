Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888284252A3
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948787; cv=none; b=iqTK56UNHgwgcWh59oipjHGxf3xvEseDr3Xc/3rPrZjQZ3UoxFSUgbqlwnFBU+6W0L62Ag/oYDvciwfFgVlKzGNHDH7YmhzsCViDcQH4Nm4nD++fBiwgAesExk+tl6toFsw8BtXCk/c+6l/tJ8Ck/XsyaRyasNOIRmHKtfSBBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948787; c=relaxed/simple;
	bh=BMvlu5B/0/j+YqBAY/jPokxed+JzXtP1Y2zYTb1yXBo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NaKAoy2d8K5Szsh/kJKj/ypuzwe0V+SxsI+c18i70AbWIoeSa2vxv99fldyj14pJ4mUln8NrBpv3CKIPkp0cf2oZiGvhDIa31SI9RNCkuSU3km/vZjSTQcIJAPSdVsMCEJQ00tdnwiEUgOKyzJaxkkNcPI0MIbcszlM5/V+afHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yjG+Hiul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yjG+Hiul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFBB1F000E9;
	Mon, 13 Jul 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948786;
	bh=d10WHfZAdMpVo4qE+icuLbhfqMLU3OJbWeiP6MzbMEM=;
	h=Subject:To:Cc:From:Date;
	b=yjG+HiulGSqvCx9Q+cLtW+uvFfyKfZjfke+Y1LwV2EwXOE7xq6/VGwufdv3OfJlZ7
	 W07Nekr5KBLhWaWrIorem56FJ2PObvBSlbDJJEir0tdYRu/tLCNnf6BSjjVySxhsBr
	 AcxzKx0Krd7RwuNBwQ3paaaHWErs2Cz+KZx83HEY=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: fix wakeup source leak on probe failure" failed to apply to 5.10-stable tree
To: johan@kernel.org,luiz.von.dentz@intel.com,rajatja@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:09:41 +0200
Message-ID: <2026071341-glamorous-shower-90f7@gregkh>
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
git cherry-pick -x 3d93e1bb0fb881fe3ef961d1120556658e9cac4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071341-glamorous-shower-90f7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d93e1bb0fb881fe3ef961d1120556658e9cac4d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 4 Jun 2026 08:37:38 +0200
Subject: [PATCH] Bluetooth: btusb: fix wakeup source leak on probe failure

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 669fb3ebde4c..966e017ac1df 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3013,6 +3013,11 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	return 0;
 }
+#else
+static inline int marvell_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
@@ -3855,6 +3860,11 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
+#else
+static inline int btusb_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static void btusb_check_needs_reset_resume(struct usb_interface *intf)
@@ -4191,7 +4201,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->wakeup  = btusb_wakeup;
 	hdev->hci_drv = &btusb_hci_drv;
 
-#ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
 		goto out_free_dev;
@@ -4200,9 +4209,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
-#endif
+
 	if (id->driver_info & BTUSB_CW6622)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_STORED_LINK_KEY);
 
@@ -4447,6 +4456,9 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 err_kill_tx_urbs:
 	usb_kill_anchored_urbs(&data->tx_anchor);
+err_disable_wakeup:
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);


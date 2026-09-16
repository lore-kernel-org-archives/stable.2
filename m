Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2814C33FE
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580489; cv=none; b=skG+EuGprm9PTkAvpGKq0bJjqJqlviNiQPKF4oKW16Zitz7tyXyArEiLIogEpyYcUd1lAui0EnK9ffl0O/ys3d5PXs0T8wlQ0JcsAGaUKDXMOfEc5YSj2ax25UnpnBXBV8rSCEw48YL6AFHZ5Or5K0KP6CLx0H1GGuJ9nRGqhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580489; c=relaxed/simple;
	bh=UOCqWEHz3SDh0saVxX3KLe/ww41svPy73QO0rKV2q8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qiZAG5ozcFzw8Oc6MnEzIqJJhhNw5Kw7LGQm/RrvusbD/QaNoQ7oepxHmftKWpFIUUwpdj9EUz188W2CVKyQZO9ChP08I5n9ezIBhQMYSeUFJrIRk1M8o0nTCSLaOkWBjo9TMbo65nH4ViDGD5IFSDzhQa2FInI57Gvg2V8oEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIkL7QHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIkL7QHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C181F0089A;
	Wed, 16 Sep 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789580471;
	bh=/ZFht2xnXsCnN6lRTJ8yCwfLlkarOJg3NcO2r1SYF30=;
	h=Subject:To:Cc:From:Date;
	b=hIkL7QHxQlHeB6SVojGteeglJlqHjuJPnrEON1mhFSpcpNw6JId6P5Tf4BcSJWR9y
	 a9jZAREobWkP0IDTpWxoeczvBVFNNFTw+9VpN9kA85gWMGygVKCBqElZUk7ctr9vaw
	 kU/qDcsFRGaqdzVzUHaTROHYZcPBlSAvK3jxOb+0=
Subject: FAILED: patch "[PATCH] Bluetooth: Properly disable remote wakeup for MT7922/MT7925" failed to apply to 6.18-stable tree
To: i@rong.moe,luiz.von.dentz@intel.com,rafael@rcpassos.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:36:00 +0100
Message-ID: <2026091600-energetic-defacing-c53a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x dcaf83ead130d3067862599089b0999b3da140a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091600-energetic-defacing-c53a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dcaf83ead130d3067862599089b0999b3da140a4 Mon Sep 17 00:00:00 2001
From: Rong Zhang <i@rong.moe>
Date: Wed, 2 Sep 2026 02:19:18 +0800
Subject: [PATCH] Bluetooth: Properly disable remote wakeup for MT7922/MT7925
 on Ryzen platform

It is reported that a remote wakeup could cause MT7922/MT7925's btusb
interface completely unresponsive. Resetting the xHCI root hub doesn't
help at all, and recovering from such a state needs a power cycle.

All reports seen to be relevant to Ryzen-based laptops. These NICs are
usually used as OEM components thanks to some sort of reference designs.
Their popularity on other platforms is unclear. While there is still a
chance that the quirk may exist on other platforms, be cautious and only
apply the quirk to direct children of Ryzen platforms's root hubs for
the time being. In most cases the root hub is on the SoC or PCH, which
needs the quirk. Unfortunately, this can't distinguish root hubs on PCIe
add-in cards. Such roughness should be acceptable, as PCIe USB
controller add-in cards are less commonly used nowadays. On the other
hand, applying the quirk doesn't hurt any functionalities either, as the
device can still be used as a wakeup source if desired. Theoretically,
we could retrieve the root hub's PCI vendor ID with some hierarchy
magic, but that's too intrusive...

Meanwhile, though device_set_wakeup_capable(false) is the correct fix
for other NICs with fake remote wakeup capabilities, doing so for
MT7922/MT7925 effectively prevents it from being used as wakeup
sources as per userspace requests. Hence, return -EBUSY on runtime
suspend to prevent the interface from being autosuspended while it's
still opened, which has the same effect as
device_set_wakeup_capable(false), since disabling remote wakeup simply
causes the USB core to gate runtime autosuspend as well due to
needs_remote_wakeup == 1. The interface can be safely autosuspended as
long as remote wakeup is disabled, i.e., after closing the HCI device.

Specifically, the interface may still take the advantage of remote
wakeup in order to wake up the system from sleep if userspace has
enabled it as a wakeup source.

Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925")
Tested-by: Rafael Passos <rafael@rcpassos.me>
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index c0ed51567ed4..9589caff925d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1374,16 +1374,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		break;
 	case 0x7922:
 	case 0x7925:
-		/*
-		 * A remote wakeup could cause the device completely unresponsive, and
-		 * recovering from such a state needs a power cycle.
-		 *
-		 * Since the remote wakeup capability is super broken, just disable it
-		 * to get rid of the troubles. The device can still be autosuspended
-		 * when the bluetooth interface is closed.
-		 */
-		device_set_wakeup_capable(&btmtk_data->udev->dev, false);
-		fallthrough;
 	case 0x7961:
 	case 0x7902:
 	case 0x6639:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d70a3e7a13f5..95f4640c60e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <linux/cpufeature.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -980,6 +981,7 @@ struct btqca_data {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_WAKEUP_BROKEN	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2969,10 +2971,25 @@ static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static inline bool platform_is_ryzen(void)
+{
+#ifdef CONFIG_X86
+	return boot_cpu_has(X86_FEATURE_ZEN);
+#else
+	return false;
+#endif
+}
+
+static inline bool is_direct_child_of_root_hub(struct usb_device *udev)
+{
+	return udev->parent == udev->bus->root_hub;
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	int err;
 
 	/* MediaTek WMT vendor cmd requiring below USB resources to
 	 * complete the handshake.
@@ -2989,7 +3006,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		btusb_mtk_claim_iso_intf(data);
 	}
 
-	return btmtk_usb_setup(hdev);
+	err = btmtk_usb_setup(hdev);
+	if (err)
+		return err;
+
+	switch (btmtk_data->dev_id) {
+	case 0x7922:
+	case 0x7925:
+		/*
+		 * All reports seen to be relevant to Ryzen-based laptops. These
+		 * NICs are usually used as OEM components thanks to some sort
+		 * of reference designs.
+		 *
+		 * Their popularity on other platforms is unclear. While there
+		 * is still a chance that the quirk may exist on other
+		 * platforms, be cautious and only apply the quirk to direct
+		 * children of Ryzen platforms's root hubs for the time being.
+		 *
+		 * In most cases the root hub is on the SoC or PCH, which needs
+		 * the quirk. Unfortunately, this can't distinguish root hubs on
+		 * PCIe add-in cards. Such roughness should be acceptable, as
+		 * PCIe USB controller add-in cards are less commonly used
+		 * nowadays. On the other hand, applying the quirk doesn't hurt
+		 * any functionalities either, as the device can still be used
+		 * as a wakeup source if desired.
+		 *
+		 * Theoretically, we could retrieve the root hub's PCI vendor ID
+		 * with some hierarchy magic, but that's too intrusive...
+		 */
+		if (platform_is_ryzen() && is_direct_child_of_root_hub(data->udev))
+			set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
+		break;
+	}
+
+	return 0;
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
@@ -4565,11 +4615,26 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't auto-suspend if there are connections or discovery in
-	 * progress; external suspend calls shall never fail.
+	/*
+	 * It is reported that remote wakeup events could sometimes cause some
+	 * adapters completely unresponsive. Resetting the xHCI root hub doesn't
+	 * help at all, and recovering from such a state needs a power cycle.
+	 * Since disabling remote wakeup simply causes the USB core to gate
+	 * runtime autosuspend as well due to needs_remote_wakeup == 1, let's do
+	 * this ourselves to make our life easier. The interface can be safely
+	 * autosuspended as long as remote wakeup is disabled, i.e., after
+	 * closing the HCI device.
+	 *
+	 * Don't auto-suspend if there are connections or discovery in progress.
+	 *
+	 * External suspend calls shall never fail. Specifically, a device with
+	 * broken remote wakeup may still take the advantage of remote wakeup in
+	 * order to wake up the system from sleep if userspace has enabled it as
+	 * a wakeup source.
 	 */
 	if (PMSG_IS_AUTO(message) &&
-	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
+	    ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->needs_remote_wakeup) ||
+	     hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
 		return -EBUSY;
 
 	if (data->suspend_count++)


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3750279F;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624014; cv=pass; b=MI/Lk1YTBcdC5BtlBJoUMrX2pjJowdLbRajDFwUo8oXMeYsHDl9+oId5Drx+mLkKVDRT7S7zaSUBhOygMnSK3zTaskRPoCf/OhHetjEuxLPz7vTdt33bPIVEaAdtLYvp9F7WNt4WbaLM5OoyC2VNnaab7slaSXedF6TezBCC/GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624014; c=relaxed/simple;
	bh=hyo59sFjITWmVYP1t7v15bvEdnO36rKaKyXDtIdXhCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/B/dTG6B5KeZoKyM0Pw4COU8I1UC7wfxrpE58NN/+9oPj77FUFYyxTcWhinn8BfuF3+Hj1f6peU/+bZyPFzhx50FnHBjqLQ9IcrPyO/aN92X+zndp1nLNY0tnX58LxZnGxC3xloPuXmZXzowrLlmQh1JOnpu6hLGi744yvav7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TG7cGKMo; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TG7cGKMo"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D81782022DD;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7GGkWLrl2Ks3dLcI4WXB0Wv7+AIBYSrZ55jXeq9u6g=;
	b=TG7cGKMonl70zbDE0QFD0ez7j0kDSWTNx/yPTlljCqmv64f/DVNXpPbkSoSem8X+KJ+G0Y
	O4lSAom8t4lo7BR433NDMLNi8K2wdkullHGugsswQXLEhtTfSUTDVADYPuZ70Zn33BHViD
	wDJM7dWurMxaJr4EUcwFZ5svBMml/MyY3k4IKlmA7y0tu5UpgS9PPjGnxMptbAQROa5dmK
	YTlCspXOhxZCt9hgj8RuDwfq8lhuhYtraFRu+HK00jk+N/ZiVy8b9zc75mpnuheNjvTdHk
	XMrO6ZFEfJXdkLmZl3p9k3dIbBYpiv5Ns+8VBtORTseCWNjQjNOM/arY5YTwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7GGkWLrl2Ks3dLcI4WXB0Wv7+AIBYSrZ55jXeq9u6g=;
	b=NVTrUDqxpoLNST66vsiRxp2U075e+31N8Z5mXYzL7m53kNSF1Pv3AdRXV7ODgI22TwALbp
	y0NfM9eTg90pb9nLbTYfjdFX7lWXudoOOBAz+zIT7g47JPj907o33/zNzeRSgR7NSZLY69
	1dW6C80gDZwUgLNxIggog8lhSpovl6+oPxUILmQE/qkEEal0Vr/G7BvhE3k3O9SactDIGS
	KHMg4WIb2PSlbaD3Cst+7FNMJZpH4RHhCBkZ0uYSEn+wIn29Kq/VTjwJSwzDde7FWI/6NJ
	rgqqF3+Yf5CheusQlE0lfyRVox/wTfqLeWYFAwckbriQosa03gIoNK5ELQKyWg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=ZRBDU1v95dRB6gK2+R+EOK5E3Ujp/fm+A+qonT4M79KaecSLonig2bx5lmcrhGc1qgV/rr
	AmRenokDNS2dMuLNxtq3ar86igsEZCips2SkOy1S3k6yIqp3jX0Jq9uPNsGkSg3TvLxl4r
	54AkIJXMP/vdjqzq2+TuEad8FnLqRylH9L3K1Aj68BtiF9uCtpfYl1uuzBrQpGhOBJMxf1
	LZ+030ZSf/q6A1oxmo0hhiCfyhI9GpEt8ytgWgnlE3pDn6pslE/Tb7AWUCL4vJJ47fZlw3
	XmV2b5DTxGzX/FzRlVpEVaFWMx5r+qpTFmudrYeg2tzyR1b/v8jW+nTuiAedyA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6g-2D;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5F19C5B155B;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH net 20/22] can: gs_usb: add workarounds for HScanT USB to CAN adapter
Date: Mon, 28 Sep 2026 20:45:27 +0200
Message-ID: <20260928193312.553632-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HScanT [1] is a RISC-V based USB to 4 channels CAN-FD adapter, which is
compatible with the gs_usb protocol.

The device is shipped with firmware version 0x00010007 and needs several
quirks to work properly.

The HScanT FW announces 5 channels, but the hardware has only 4. Workaround
the problem by changing the struct gs_device_config::icount to 3, which
corresponds to 4 channels.

The HScanT FW requires a USB High Speed Hub, bail out if device is
connected to slower USB Hub.

The HScanT FW always sends USB In URB with length 512 bytes and seems to
have broken Zero Packet Length handling. Add quirk
GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE to allocate URBs of 513 bytes to work
around these issues.

This driver supports up to 256 channels per USB Interface. The HScanT
device has 4 channels, but the FW requires each channels to be bound to a
USB interface using the GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT USB
request. Add quirk to GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL to bind the
CAN channel to the USB Interface 0 during gs_can_open()

Link: https://github.com/cherry-embedded/HSCanT-hardware
Link: https://patch.msgid.link/20260928-gs_usb-hscant-v2-1-a7c1c02460e9@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 125 +++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f604358c8259..f7a349902c42 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,6 +72,7 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
+	GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT = 17,
 };
 
 enum gs_can_mode {
@@ -188,6 +189,21 @@ struct gs_device_termination_state {
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
+/* HScanT firmware version 0x00010007:
+ * - FW requires the binding of CAN channels to USB Interfaces.
+ * - Route all CAN channels to USB Interface 0.
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL BIT(29)
+
+/* HScanT firmware version 0x00010007:
+ * - FW sends bulk In URBs with length of 512 bytes.
+ * - When using In URBs with 512 bytes it will send a second in URB with length 0
+ *   It seems the ZLP handling is broken.
+ * - Use In URBs of length GS_USB_QUIRK_HSCANT_IN_URB_SIZE as a workaround.
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE BIT(30)
+#define GS_USB_QUIRK_HSCANT_IN_URB_SIZE (513)
+
 /* CANtact Pro original firmware:
  * BREQ DATA_BITTIMING overlaps with GET_USER_ID
  */
@@ -812,6 +828,18 @@ static int gs_usb_set_data_bittiming(struct gs_can *dev)
 				    GFP_KERNEL);
 }
 
+static int gs_usb_hscant_bind_channel_to_interface(const struct gs_can *dev)
+{
+	const u16 interface_number = 0;
+
+	/* Bind dev->channel to interface_number */
+	return usb_control_msg_send(dev->udev, 0, GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				    dev->channel, interface_number,
+				    NULL, 0, 1000,
+				    GFP_KERNEL);
+}
+
 static void gs_usb_xmit_callback(struct urb *urb)
 {
 	struct gs_tx_context *txc = urb->context;
@@ -1069,6 +1097,16 @@ static int gs_can_open(struct net_device *netdev)
 		}
 	}
 
+	if (dev->feature & GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL) {
+		rc = gs_usb_hscant_bind_channel_to_interface(dev);
+		if (rc) {
+			netdev_err(netdev,
+				   "failed to bind Channel to Interface: %pe\n",
+				   ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1314,6 +1352,49 @@ static const u16 gs_usb_termination_const[] = {
 	GS_USB_TERMINATION_ENABLED
 };
 
+static bool gs_usb_is_hscant(const struct usb_device *udev,
+			     const struct gs_device_config *dconf,
+			     const u32 sw_version)
+{
+	if (udev->descriptor.idVendor != cpu_to_le16(USB_GS_USB_1_VENDOR_ID) ||
+	    udev->descriptor.idProduct != cpu_to_le16(USB_GS_USB_1_PRODUCT_ID))
+		return false;
+
+	if (strcmp(udev->manufacturer, "HScanT") ||
+	    strcmp(udev->product, "HScanT USB to CAN adapter"))
+		return false;
+
+	if (dconf->sw_version != cpu_to_le32(sw_version))
+		return false;
+
+	return true;
+}
+
+static void
+gs_usb_make_candev_get_feature(struct gs_can *dev, const struct gs_device_config *dconf,
+			       const struct gs_device_bt_const *bt_const)
+{
+	const struct usb_device *udev = dev->udev;
+	const u32 feature = le32_to_cpu(bt_const->feature);
+
+	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+
+	if (!udev->manufacturer || !udev->product)
+		return;
+
+	/* HScanT firmware version 0x00010007:
+	 * - FW doesn't advertise GS_CAN_FEATURE_BT_CONST_EXT,
+	 *   but implements GS_USB_BREQ_BT_CONST_EXT, fixup.
+	 * - FW requires binding of CAN channel to USB Interface, add quirk.
+	 * - FW requires bulk In URBs with >= 512 bytes, add quirk.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007)) {
+		dev->feature |= GS_CAN_FEATURE_BT_CONST_EXT |
+			GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL |
+			GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE;
+	}
+}
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1385,8 +1466,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const.feature);
-	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+	gs_usb_make_candev_get_feature(dev, dconf, &bt_const);
+	feature = dev->feature;
+
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1514,6 +1596,34 @@ static void gs_destroy_candev(struct gs_can *dev)
 	free_candev(dev->netdev);
 }
 
+static int gs_usb_probe_quirks(const struct usb_interface *intf, struct gs_device_config *dconf)
+{
+	const struct usb_device *udev = interface_to_usbdev(intf);
+
+	if (!udev->manufacturer || !udev->product)
+		return 0;
+
+	/* HScanT firmware version 0x00010007:
+	 * - FW has an icount of 4, which corresponds to 5 CAN interfaces.
+	 *   The hardware has only 4 interfaces, fixup.
+	 * - FW provides broken Endpoint Descriptors on USB Full Speed Hubs:
+	 *   config 1 interface 0 altsetting 0 endpoint 0x4 has invalid maxpacket 512, setting to 64
+	 *   Probably related to GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE,
+	 *   FW only works on USB High Speed Hubs, detect and bail out.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007)) {
+		if (dconf->icount == 4)
+			dconf->icount = 3;
+
+		if (udev->speed < USB_SPEED_HIGH) {
+			dev_err(&intf->dev, "Device only works with USB High Speed Hubs\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -1560,6 +1670,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	rc = gs_usb_probe_quirks(intf, &dconf);
+	if (rc)
+		return rc;
+
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
@@ -1604,10 +1718,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		parent->canch[i]->parent = parent;
 
-		/* set RX packet size based on FD and if hardware
+		/* set RX packet size based on quirks, FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE) {
+			hf_size_rx = GS_USB_QUIRK_HSCANT_IN_URB_SIZE;
+			BUILD_BUG_ON(struct_size(hf, canfd, 1) > GS_USB_QUIRK_HSCANT_IN_URB_SIZE);
+		} else if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
 			else
-- 
2.53.0


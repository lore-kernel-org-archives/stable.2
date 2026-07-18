Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49534DCE3
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411438; cv=none; b=LyLSAcXCkJM+sQjXcqtdU1A86XqJK6vBr0hAGHV9iPuaN296YpzYqlk6s9ecOyQiL3TBYcPyCXL4VDamUyck1XaKvDzHXOSne7wVybW2GsB+Ki38Mxa0ZEaFsyMaJVfXksdg2cAIKXlCG5V1MFud6UTGoVLcAn6M3BCKh8ivYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411438; c=relaxed/simple;
	bh=aBUtaO5dbcDNj9UR+q1n6uRelpv3Wln8GtSW6anJvX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCMs6bb/QQqTIkx83lOnSErK0/Ye9lK0Qfg0r15zJDuc4cL3Fssout5zaVEnxmIONbhoSNhUhJ2ps6FnygGDqRlijVOr/AHe5sWT49m5UKRw4p4e/jwnS/u715uv6Z3Er0Sv8WwMF6qZanfcHRftIn/M1o3UE2bKVIrUN73XoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW6HUAWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW6HUAWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3D61F00A3A;
	Sat, 18 Jul 2026 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411436;
	bh=kRTHRZ2uwGobkKiwt8xQYdgy0p9GqpVS9mC4GChxZ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nW6HUAWqsP5m9dnCXb3qZkXjFh1aRGUOHpyQXLUUsyCKfFfl4TQE0skkPvLUtoO8b
	 NnGRwoMBpWEencj36B06wLUSJTaSzMB/rh1zJjuRTgXfXbWgV8erBi/4evf6fo30JJ
	 Vmu4covjR1gr44GlQcnayllbnkKTRD6o4QNJusgt6k3n1x43u5/T1vVcyuNwmGC9QC
	 6C7uwTFjXyomuZoINDCziWXXgKD86bqs+TiLxz1SaO48Fh98dyBSxm4d8IriwZugHF
	 ynT4n2UEap3xh9tSj20HTTRgkqkDbDAnVuRECQj7TUF/colwdqbxhK9GUlvR54UBs7
	 lXqgiojVtSvPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/3] usb: atm: ueagle-atm: remove function entry/exit debug messages
Date: Sat, 18 Jul 2026 17:50:32 -0400
Message-ID: <20260718215033.3447737-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718215033.3447737-1-sashal@kernel.org>
References: <2026071426-neurosis-lumpish-e192@gregkh>
 <20260718215033.3447737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauricio Faria de Oliveira <mfo@igalia.com>

[ Upstream commit 1414b2242c2e9d670c4d8b83480f13db57627ba9 ]

Remove the driver-internal function entry/exit debug messages
in favor of existing kernel-level function tracing mechanisms.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/all/2026051657-scruffy-embark-45ea@gregkh/
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260520-ueagle-atm-cleanup-v1-2-010c8bc7b214@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/atm/ueagle-atm.c | 56 ++++--------------------------------
 1 file changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 71559a934133a8..ed2611aacb252f 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -51,12 +51,6 @@
 				"[ueagle-atm vdbg]  " format, ##args); \
 	} while (0)
 
-#define uea_enters(usb_dev) \
-	uea_vdbg(usb_dev, "entering %s\n" , __func__)
-
-#define uea_leaves(usb_dev) \
-	uea_vdbg(usb_dev, "leaving  %s\n" , __func__)
-
 #define uea_err(usb_dev, format, args...) \
 	dev_err(&(usb_dev)->dev , "[UEAGLE-ATM] " format , ##args)
 
@@ -606,7 +600,6 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 	u32 crc = 0;
 	int ret, size;
 
-	uea_enters(usb);
 	if (!fw_entry) {
 		uea_err(usb, "firmware is not available\n");
 		goto err;
@@ -670,7 +663,6 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 	uea_err(usb, "firmware is corrupted\n");
 err:
 	release_firmware(fw_entry);
-	uea_leaves(usb);
 }
 
 /*
@@ -681,7 +673,6 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
 	int ret;
 	char *fw_name = EAGLE_FIRMWARE;
 
-	uea_enters(usb);
 	uea_info(usb, "pre-firmware device, uploading firmware\n");
 
 	switch (ver) {
@@ -710,7 +701,6 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
 	else
 		uea_info(usb, "loading firmware %s\n", fw_name);
 
-	uea_leaves(usb);
 	return ret;
 }
 
@@ -1137,7 +1127,6 @@ static int uea_cmv_e1(struct uea_softc *sc,
 	struct cmv_e1 cmv;
 	int ret;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	uea_vdbg(INS_TO_USBDEV(sc), "Function : %d-%d, Address : %c%c%c%c, "
 			"offset : 0x%04x, data : 0x%08x\n",
 			E1_FUNCTION_TYPE(function),
@@ -1164,9 +1153,8 @@ static int uea_cmv_e1(struct uea_softc *sc,
 							sizeof(cmv), &cmv);
 	if (ret < 0)
 		return ret;
-	ret = wait_cmv_ack(sc);
-	uea_leaves(INS_TO_USBDEV(sc));
-	return ret;
+
+	return wait_cmv_ack(sc);
 }
 
 static int uea_cmv_e4(struct uea_softc *sc,
@@ -1175,7 +1163,6 @@ static int uea_cmv_e4(struct uea_softc *sc,
 	struct cmv_e4 cmv;
 	int ret;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	memset(&cmv, 0, sizeof(cmv));
 
 	uea_vdbg(INS_TO_USBDEV(sc), "Function : %d-%d, Group : 0x%04x, "
@@ -1199,9 +1186,8 @@ static int uea_cmv_e4(struct uea_softc *sc,
 							sizeof(cmv), &cmv);
 	if (ret < 0)
 		return ret;
-	ret = wait_cmv_ack(sc);
-	uea_leaves(INS_TO_USBDEV(sc));
-	return ret;
+
+	return wait_cmv_ack(sc);
 }
 
 static inline int uea_read_cmv_e1(struct uea_softc *sc,
@@ -1295,7 +1281,6 @@ static int uea_stat_e1(struct uea_softc *sc)
 	u32 data;
 	int ret;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	data = sc->stats.phy.state;
 
 	ret = uea_read_cmv_e1(sc, E1_SA_STAT, 0, &sc->stats.phy.state);
@@ -1438,7 +1423,6 @@ static int uea_stat_e4(struct uea_softc *sc)
 	u32 tmp_arr[2];
 	int ret;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	data = sc->stats.phy.state;
 
 	/* XXX only need to be done before operationnal... */
@@ -1805,7 +1789,6 @@ static int uea_start_reset(struct uea_softc *sc)
 	u16 zero = 0;	/* ;-) */
 	int ret;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	uea_info(INS_TO_USBDEV(sc), "(re)booting started\n");
 
 	/* mask interrupt */
@@ -1873,7 +1856,6 @@ static int uea_start_reset(struct uea_softc *sc)
 		return ret;
 
 	sc->reset = 0;
-	uea_leaves(INS_TO_USBDEV(sc));
 	return ret;
 }
 
@@ -1889,7 +1871,6 @@ static int uea_kthread(void *data)
 	int ret = -EAGAIN;
 
 	set_freezable();
-	uea_enters(INS_TO_USBDEV(sc));
 	while (!kthread_should_stop()) {
 		if (ret < 0 || sc->reset)
 			ret = uea_start_reset(sc);
@@ -1898,7 +1879,7 @@ static int uea_kthread(void *data)
 		if (ret != -EAGAIN)
 			uea_wait(sc, 0, msecs_to_jiffies(1000));
 	}
-	uea_leaves(INS_TO_USBDEV(sc));
+
 	return ret;
 }
 
@@ -1911,8 +1892,6 @@ static int load_XILINX_firmware(struct uea_softc *sc)
 	u8 value;
 	char *fw_name = FPGA930_FIRMWARE;
 
-	uea_enters(INS_TO_USBDEV(sc));
-
 	ret = request_firmware(&fw_entry, fw_name, &sc->usb_dev->dev);
 	if (ret) {
 		uea_err(INS_TO_USBDEV(sc), "firmware %s is not available\n",
@@ -1956,7 +1935,6 @@ static int load_XILINX_firmware(struct uea_softc *sc)
 err1:
 	release_firmware(fw_entry);
 err0:
-	uea_leaves(INS_TO_USBDEV(sc));
 	return ret;
 }
 
@@ -1966,7 +1944,6 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 	struct cmv_dsc_e1 *dsc = &sc->cmv_dsc.e1;
 	struct cmv_e1 *cmv = &intr->u.e1.s2.cmv;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	if (le16_to_cpu(cmv->wPreamble) != E1_PREAMBLE)
 		goto bad1;
 
@@ -1990,7 +1967,6 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 	if (cmv->bFunction == E1_MAKEFUNCTION(E1_ADSLDIRECTIVE,
 							E1_MODEMREADY)) {
 		wake_up_cmv_ack(sc);
-		uea_leaves(INS_TO_USBDEV(sc));
 		return;
 	}
 
@@ -2004,7 +1980,6 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 	sc->data = sc->data << 16 | sc->data >> 16;
 
 	wake_up_cmv_ack(sc);
-	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 
 bad2:
@@ -2012,14 +1987,12 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 			"Function : %d, Subfunction : %d\n",
 			E1_FUNCTION_TYPE(cmv->bFunction),
 			E1_FUNCTION_SUBTYPE(cmv->bFunction));
-	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 
 bad1:
 	uea_err(INS_TO_USBDEV(sc), "invalid cmv received, "
 			"wPreamble %d, bDirection %d\n",
 			le16_to_cpu(cmv->wPreamble), cmv->bDirection);
-	uea_leaves(INS_TO_USBDEV(sc));
 }
 
 /* The modem send us an ack. First with check if it right */
@@ -2028,7 +2001,6 @@ static void uea_dispatch_cmv_e4(struct uea_softc *sc, struct intr_pkt *intr)
 	struct cmv_dsc_e4 *dsc = &sc->cmv_dsc.e4;
 	struct cmv_e4 *cmv = &intr->u.e4.s2.cmv;
 
-	uea_enters(INS_TO_USBDEV(sc));
 	uea_dbg(INS_TO_USBDEV(sc), "cmv %x %x %x %x %x %x\n",
 		be16_to_cpu(cmv->wGroup), be16_to_cpu(cmv->wFunction),
 		be16_to_cpu(cmv->wOffset), be16_to_cpu(cmv->wAddress),
@@ -2040,7 +2012,6 @@ static void uea_dispatch_cmv_e4(struct uea_softc *sc, struct intr_pkt *intr)
 	if (be16_to_cpu(cmv->wFunction) == E4_MAKEFUNCTION(E4_ADSLDIRECTIVE,
 						E4_MODEMREADY, 1)) {
 		wake_up_cmv_ack(sc);
-		uea_leaves(INS_TO_USBDEV(sc));
 		return;
 	}
 
@@ -2053,7 +2024,6 @@ static void uea_dispatch_cmv_e4(struct uea_softc *sc, struct intr_pkt *intr)
 	sc->data = be32_to_cpu(cmv->dwData[0]);
 	sc->data1 = be32_to_cpu(cmv->dwData[1]);
 	wake_up_cmv_ack(sc);
-	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 
 bad2:
@@ -2061,7 +2031,6 @@ static void uea_dispatch_cmv_e4(struct uea_softc *sc, struct intr_pkt *intr)
 			"Function : %d, Subfunction : %d\n",
 			E4_FUNCTION_TYPE(cmv->wFunction),
 			E4_FUNCTION_SUBTYPE(cmv->wFunction));
-	uea_leaves(INS_TO_USBDEV(sc));
 	return;
 }
 
@@ -2089,8 +2058,6 @@ static void uea_intr(struct urb *urb)
 	struct intr_pkt *intr = urb->transfer_buffer;
 	int status = urb->status;
 
-	uea_enters(INS_TO_USBDEV(sc));
-
 	if (unlikely(status < 0)) {
 		uea_err(INS_TO_USBDEV(sc), "uea_intr() failed with %d\n",
 		       status);
@@ -2130,8 +2097,6 @@ static int uea_boot(struct uea_softc *sc, struct usb_interface *intf)
 	int ret = -ENOMEM;
 	int size;
 
-	uea_enters(INS_TO_USBDEV(sc));
-
 	if (UEA_CHIP_VERSION(sc) == EAGLE_IV) {
 		size = E4_INTR_PKT_SIZE;
 		sc->dispatch_cmv = uea_dispatch_cmv_e4;
@@ -2188,7 +2153,6 @@ static int uea_boot(struct uea_softc *sc, struct usb_interface *intf)
 		goto err2;
 	}
 
-	uea_leaves(INS_TO_USBDEV(sc));
 	return 0;
 
 err2:
@@ -2198,7 +2162,6 @@ static int uea_boot(struct uea_softc *sc, struct usb_interface *intf)
 	sc->urb_int = NULL;
 	kfree(intr);
 err0:
-	uea_leaves(INS_TO_USBDEV(sc));
 	return ret;
 }
 
@@ -2208,7 +2171,7 @@ static int uea_boot(struct uea_softc *sc, struct usb_interface *intf)
 static void uea_stop(struct uea_softc *sc)
 {
 	int ret;
-	uea_enters(INS_TO_USBDEV(sc));
+
 	ret = kthread_stop(sc->kthread);
 	uea_dbg(INS_TO_USBDEV(sc), "kthread finish with status %d\n", ret);
 
@@ -2222,7 +2185,6 @@ static void uea_stop(struct uea_softc *sc)
 	flush_work(&sc->task);
 
 	release_firmware(sc->dsp_firm);
-	uea_leaves(INS_TO_USBDEV(sc));
 }
 
 /* syfs interface */
@@ -2495,8 +2457,6 @@ static int uea_bind(struct usbatm_data *usbatm, struct usb_interface *intf,
 	int ret, ifnum = intf->altsetting->desc.bInterfaceNumber;
 	unsigned int alt;
 
-	uea_enters(usb);
-
 	/* interface 0 is for firmware/monitoring */
 	if (ifnum != UEA_INTR_IFACE_NO)
 		return -ENODEV;
@@ -2589,7 +2549,6 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_device *usb = interface_to_usbdev(intf);
 	int ret;
 
-	uea_enters(usb);
 	uea_dbg(usb, "ADSL device found with vid (%#X) pid (%#X) Rev (%#X): %s\n",
 		le16_to_cpu(usb->descriptor.idVendor),
 		le16_to_cpu(usb->descriptor.idProduct),
@@ -2620,7 +2579,6 @@ static void uea_disconnect(struct usb_interface *intf)
 {
 	struct usb_device *usb = interface_to_usbdev(intf);
 	int ifnum = intf->altsetting->desc.bInterfaceNumber;
-	uea_enters(usb);
 
 	/* ADI930 has 2 interfaces and eagle 3 interfaces.
 	 * Pre-firmware device has one interface
@@ -2631,8 +2589,6 @@ static void uea_disconnect(struct usb_interface *intf)
 		mutex_unlock(&uea_mutex);
 		uea_info(usb, "ADSL device removed\n");
 	}
-
-	uea_leaves(usb);
 }
 
 /*
-- 
2.53.0


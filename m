Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14234387590
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065794; cv=none; b=AsINQNBpJC5wjQuHpsN29t3ChtZ1QMJkg82GCtRx/pNXK+kKz5nB+IqnQlaSXyG/mXWAbvDFmioZL6n09Y2X0CAw+EeBUKquDKDbFHn8MCHZ1JcHgfSx+ChW+LyW6GgJBVX4HObzSqgl+72objRQnVji6ki7ny42lb7ANYY6bNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065794; c=relaxed/simple;
	bh=PdnK50oA4aFSHZ0sz/xkxC2UJ+Kx0nvxAsO7+oQ5kI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J84zPymnj2yg0TZN/yQeStXwEXi0CDi1kwEzQ8s16PIlh8CVGuDmXiXDBH1XYLEKZbEwx9ownX12CVG5zvajBoEMaUItH6vbOWE0/7ifpKa6x/cnpLf5ndmF+K0AW8sB4rqDciePFW1wkYbjOgS2TU2mRe5TX5FAqgM/mITLUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft2hkL8z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft2hkL8z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1282128b3a.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785065792; x=1785670592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpZ8cl8NdFknWl7FIQEBjS+A4S/OlaNCwNqgkfiNXr8=;
        b=Ft2hkL8z8GT3HlDdQ3SRaP4Avnsh2Rv2zq4WDkHp+gPiA0eAJok88XXlUoWaKLZwHw
         GAzyMOga0P0QdoBhYI6SC71Y8ltyD1RZv85J/SNUWsmrClPKTb0buTCn3GhT0MOdG1vC
         DYqkAUoS4SCJ0HHLYEqh7nwqpu+SrjJajB3Dah+eo1YVMWuyod7TU7PFFb+iyLwLFFmw
         W7Nlw1Z8PLgoch3OADElILy8Zc45SjQue0bJE3MO4pfo8+8/wzeX/fCAyV+12gYpa/MY
         RR19RBdeIxiYCCAn+7Hdh7l5ZVGy+DOW91WCqMNxrzIFg/7fcpw02WUQv5inpNtD6dzL
         z1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065792; x=1785670592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpZ8cl8NdFknWl7FIQEBjS+A4S/OlaNCwNqgkfiNXr8=;
        b=PYOc6o2rEeWhhPhYMfjnnA3Kx1PJj01BE6jUzyi5JxzMSneF18Gm9OIQxrQO7Jfxdl
         oUX9PL77Y73AiMoNHqdmah03oMed0UIcI+tcbAo6iY+yqFm9FZ2Z9EgbAerW7QJEcSDR
         pPr6ItkewMhK66GywPE3NRq/ENrE/HbEkqUl3htLA9greYPmQ60vF7WU0OVZDyaA3GIL
         +PBQUCOD8Hz2FzU5eMu+Iy6lYWtS/ZfteViI/tw/nbwVEfP8Q5SpedyWCosvUy9GqKNd
         51v0sSg0d42wQvAFYTrnHQIA8g9rJ3gD7Q9SntHD5oAhLhiDAXcqguNm1Ogi/XSbf410
         8DFA==
X-Forwarded-Encrypted: i=1; AHgh+RoACnP/0ljxGnvmMnQfNvUCnGPNWN9Hz5DKanVGGKLT4TSkBVYG+4CLbKZ9lAC5G6PBuVZ02h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4GSLjcerfFt93gpfBC9U0yrgXihaaopoNZYLkgPowfz/cmUC
	nPVjqytthCpSClzF2Yws1pEkMMadM6Dw0Q1dX2HgG1/lV3wVy+P9nx85
X-Gm-Gg: AR+sD11re+7fMn+bVxH7vcKVBMRjHsw3KzjAeRtENZ1+JldHFIpmtf0dv0SMV/eh0tb
	JpvrtlznKkIwDI+qAAWGM9BVVAe0NZucx4Y9lCOT0frG5+DKS3rC5e4Nesk5uilA5XS/t4OQU38
	SAZrAls0kyE2/JVoumYoh0v/aj1a2GVfL6ymDfySix16GM2ArN5388x+COAyMJXZQYNgslYCaFL
	MIORm2zEHPmnXQNV+vaE7uT7UdcqNXLVidcFMgjykVgX2OKHTPXCpVLV0gec3oTGKAryvUvYJuN
	YiIYWeoZb6gjsmXrsH0PAjCDeSPYIWvoQMb4NBv5aj514NK3dXJZmCcP4S4E491mfxYIIv0Tnv3
	b/xAQF0+Ar++OFo5D8jjlzUV/PeIEQ+iXvWb7fNXC6UOuNgvNiW8E+hqCq2nQEnhCh2B0PNl51C
	0t+IJEULH/CHNomh6qgdDhWAdf7jiQB1MF62dxUo+9l0IZINGwxszfTVqDYFmyTMuMJVcGaSo5O
	w==
X-Received: by 2002:a05:6a00:1826:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-84e59474684mr3819057b3a.29.1785065792127;
        Sun, 26 Jul 2026 04:36:32 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm1785051b3a.4.2026.07.26.04.36.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 04:36:30 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] usb: misc: usbio: bound the debug hex dumps by the received length
Date: Sun, 26 Jul 2026 20:35:09 +0900
Message-ID: <20260726113511.57596-4-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726113511.57596-1-skyexpoc@gmail.com>
References: <20260726113511.57596-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_ctrl_msg() and usbio_bulk_msg() hex dump the reply with "%*phN",
using a length the device supplied and that has not been validated yet:

	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
	dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
		(int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);

cpkt->len is a u8 read back out of usbio->ctrlbuf after the IN transfer,
and bpkt_len in usbio_bulk_msg() is le16_to_cpu(bpkt->len) read out of
usbio->rxbuf.  Both are handed to "%*phN" as the field width.
hex_string() in lib/vsprintf.c caps that at 64, and dereferences every
byte up to that cap regardless of how much room the output buffer has:

	if (spec.field_width > 0)
		len = min(spec.field_width, 64);

	for (i = 0; i < len; ++i) {
		if (buf < end)
			*buf = hex_asc_hi(addr[i]);

So the dump reads up to byte 67 of ctrlbuf and byte 68 of rxbuf.  Both
buffers are sized from the endpoint packet sizes, so this is out of
bounds whenever ep0 wMaxPacketSize is below 68 and whenever the bulk in
endpoint is below 69.  That covers every low, full and high speed ep0
(8, 16, 32 or 64) and the bulk sizes the supported bridges actually use
(64, or 63 for the Synaptics Sabre via USBIO_QUIRK_BULK_MAXP_63).

A device answering one of the five usbio_ctrl_msg() calls in
usbio_probe() with cpkt->len = 255 therefore leaks up to 60 bytes of
adjacent slab memory into the kernel log during enumeration, before any
user space is involved.  On the bulk path a reply claiming
bpkt->len = 0xffff reads 5 bytes past a 64 byte rxbuf.

Unlike the endpoint size issues this needs no malformed descriptor at
all; it only needs the dev_dbg() calls to be enabled.  When they are, it
is a slab-out-of-bounds read under KASAN and the bytes reach dmesg.

Bound both dumps by the number of bytes actually received.  That is in
bounds by construction and also stops the dump printing stale bytes left
over from an earlier transfer.  The matching dumps on the two OUT paths
are left alone: they use lengths the driver itself just wrote, which the
size checks above them already bound.

Found by code review.  The out-of-bounds read was reproduced under
AddressSanitizer with a userspace model of the two dev_dbg() call sites
and of hex_string()'s field-width handling; it has not been exercised on
hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 asan
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -14,6 +14,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -141,7 +142,7 @@
 	struct usbio_ctrl_packet *cpkt;
 	unsigned int pipe;
 	u16 cpkt_len;
-	int ret;
+	int dbg_len, ret;
 
 	lockdep_assert_held(&usbio->ctrl_mutex);
 
@@ -181,8 +182,15 @@
 	cpkt_len = sizeof(*cpkt) + ibuf_len;
 	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
 			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
+	/*
+	 * cpkt->len has just been written by the device and is not validated
+	 * until below, while %*phN dereferences up to 64 bytes of whatever
+	 * field width it is handed.  Bound the dump by what was received.
+	 */
+	dbg_len = (ret > (int)sizeof(*cpkt)) ?
+		  min_t(int, cpkt->len, ret - (int)sizeof(*cpkt)) : 0;
 	dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
-		(int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);
+		(int)sizeof(*cpkt), cpkt, dbg_len, cpkt->data);
 
 	if (ret < sizeof(*cpkt)) {
 		dev_err(usbio->dev, "USB control in failed: %d\n", ret);
@@ -258,7 +266,7 @@
 	struct usbio_client *client = adev_to_client(adev);
 	struct usbio_device *usbio = client->bridge;
 	struct usbio_bulk_packet *bpkt;
-	int ret, act = 0;
+	int ret, act = 0, dbg_len;
 	u16 bpkt_len;
 
 	lockdep_assert_held(&client->mutex);
@@ -314,8 +322,14 @@
 	act = usbio->rxdat_len;
 	bpkt = usbio->rxbuf;
 	bpkt_len = le16_to_cpu(bpkt->len);
+	/*
+	 * Same as in usbio_ctrl_msg(): bpkt_len is device supplied and is only
+	 * validated below, so bound the dump by what was received.
+	 */
+	dbg_len = (act > (int)sizeof(*bpkt)) ?
+		  min_t(int, bpkt_len, act - (int)sizeof(*bpkt)) : 0;
 	dev_dbg(usbio->dev, "bulk in %d hdr %*phN data %*phN\n", act,
-		(int)sizeof(*bpkt), bpkt, bpkt_len, bpkt->data);
+		(int)sizeof(*bpkt), bpkt, dbg_len, bpkt->data);
 
 	/*
 	 * Unsupported bulk commands get only an usbio_packet_header with
-- 
2.51.0


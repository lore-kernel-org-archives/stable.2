Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6C3A544F
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791193; cv=none; b=c77IwyiOWQ4agQ2pnB+cYGt2hRZSQR2C9/j2YX7A/HQvRmlrf4emUrtnUWFLs5l5WW6haasyBiSSfGSYfVs8hc+9dV+5KaTAxqN6xqNtduTFZKtm295l1uM75M16xJ0f7iDLa/mV345wbOuP/EAnvy048wvd8TNBJO9woZKBPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791193; c=relaxed/simple;
	bh=6M6BqSu+AARyDk9/i3i6nT6PArwCznAtKG+pD5PVZUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jguqj+dADjb9QqEWsN4ajQjN9LT+2VHJzJZuEs/s3VEHgUyRoOjTGLx+dWKyW4rbHydavJ5ln6YqZjfMMAs4frnMFxLzoF478nwlB4ySzkCtHlkegeORTkHezLPK8v1jcRO17j9ZSXHe9BSSj45ZTCXry41SOC7767hkC8h59Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6Dr4i0W; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Dr4i0W"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48436251906so4139900f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788791190; x=1789395990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4f0/64qaNZYvJEcWhejwJa+PLE1/Em7ct5SbUix/fW8=;
        b=q6Dr4i0WkAjuFmycVhSSQRnVTczqfUrTQaeORur6Hd2bVgq9VoAdE6Wwx+qQABHvcH
         yacqumiHa9NTfk2p6UIHl9ZhgciVNMQLYg6fwIkh1iAcLsdn4nEP2JV0f4rzLfEZxNAf
         OM1sN0qTqoopKC7E7ab2G3lsoYl2oqr/v/l2GB0mfB5wOk/p/2YZlg9yKs+ZqrZJ0ogS
         XmFEUg/33CGHFA5vSfZ4BQ7Er5wDZNJt12yYr/Hzd0bw5a3lcMZdIKiNZBLTkxaZSuoN
         bbu1rjcC39MFGDDAIhtcPhoj4/iokqFcrXyLzhhKm97rTq99Hd8H9nW+bLRa77OyLgaY
         OcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791190; x=1789395990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4f0/64qaNZYvJEcWhejwJa+PLE1/Em7ct5SbUix/fW8=;
        b=ISXJ1Q2xwrJsitBwWLIW6dV8Vqfkq1SW/1b9CbzLc0QoUjODKsnX1KQr7eUSs98Qm/
         2gf/hMJKyYt7NUU2zuxG+r6z6WLOsxlEQEKUQJ91YvOvyrlz4DM79+13cz/GnWalt3Be
         LWdTt+7SXDkFRGyXVd6uuqgHNQ2cL5vCy19M4ZligzhiYOMNzGb/fP2TuS/KF9T+I6MJ
         i+AuUclkZOtqFhd0MCI5ifmQPuOeWwmXmAeGMasAYT3kwWqnqHsOP0RjB861wGtBoDYL
         B+qJZhwTECOoJx3Qz3iDtCFA1A5OiTtHYRqIgZLM8gMW/nNqybdLnU0/y3Mk/a8iAzoj
         rIfg==
X-Forwarded-Encrypted: i=1; AKwUvBy9TpZZCCSkeWXIvgrjw77WRkTzIG0wOS/gp0tGQinfk1n2+kS86opZ8M2+0xIDD/R/f/Kzx7o=@vger.kernel.org
X-Gm-Message-State: AFuF++k+uHfH2+4jNJSiL9JmSjfrt7vGHnSilBzDrCC7zJ6nz/GvYMXA
	fCpUcU8MNga10wYHrJUJAY6tCL7fSOSeKQlBAqa7YxtGEE3CliLaqxoP
X-Gm-Gg: AYBFou3JHQlzIwbqY/Wq6oFipXZfjAK7pj3bfl0/qKsCxaYuNJJu3sH7zYR39+vvRFD
	xx/xxCzBRIWHglnaxYk5dY3cjPFrqZSxRmEA5Ztp6MEqnJq0zj43ExlMSxOQTA2M6wW+XJKPxGF
	5Vqs6li3cntFjmvNFLV7y+K+VyfsWoLZdz//fHMP6gmMjPhvf8TkFXj5HWcKQPn/lyIsU8cCQdW
	F20rGPZDGoxzcExerJkBSLH6QL7nO2dq7QpqaoDBLM1Me/SgKuklk02Id6Hw5799RSN7kvyowxA
	OLFu4npu7AtvkB/38Ew04hJ2bsrr2SY6U3dnl9NhyD+km8eX2BvaKXcL22fhoyKBS+O2LHCW/XY
	SOSZJIDH76gS7yDsZRbU5TPYzKIjGNTvaURl84EPBobtGU9viu4fVsBNY4a44GUT866yx4o0QTr
	aAK8Yp4eC1eNNd1ukJvRmiwb6OOuPebrjumrK5qAHRYn/QwBoHps+fBSmGP4Qp+EV+BIoG4c26f
	kC/QyPI1w1bCPqdO9gvANkljrXW3Xh+Ez91BNlvFFwdKGIfz9H74RfoHsV3YXc2sRWs4BAbOZ8u
	uXil/IY8weXvg56a+T7dt6WVRw==
X-Received: by 2002:a05:600c:3b01:b0:49b:4d64:bbc4 with SMTP id 5b1f17b1804b1-49cf81f1592mr393945895e9.8.1788791190141;
        Mon, 07 Sep 2026 07:26:30 -0700 (PDT)
Received: from MYL150-3871.localdomain (80.151.89.79.rev.sfr.net. [79.89.151.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm414605655e9.6.2026.09.07.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:26:29 -0700 (PDT)
From: Nicolas Thibert <nithibert@gmail.com>
X-Google-Original-From: Nicolas Thibert <n.thibert@ext.mylight150.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Thibert <nithibert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: fix NXP IW610 composite device handling
Date: Mon,  7 Sep 2026 16:26:04 +0200
Message-Id: <20260907142604.1080571-1-n.thibert@ext.mylight150.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Thibert <nithibert@gmail.com>

The NXP IW610 module exposes itself as a composite USB device
(0471:0215) with three interfaces: two real Bluetooth HCI interfaces
(class 0xe0) and one vendor-specific WiFi interface (class 0xff) used
by mwifiex-nxp.

The composite device's whole USB descriptor reports class 0xe0/01/01
(Bluetooth), so btusb_table's generic USB_DEVICE_INFO(0xe0, 0x01, 0x01)
entry matches every interface, not just the two real HCI ones -- btusb
ends up binding the WiFi interface too, and mwifiex-nxp never gets it.

Fix:
1. In btusb_table (the table the USB core actually matches against),
   explicitly ignore the WiFi interface via BTUSB_IGNORE, ahead of the
   generic entry.
2. In quirks_table, scope the existing BTUSB_MARVELL entry to the BT
   interface class instead of matching the whole device by VID/PID
   (harmless either way since quirks_table isn't consulted for initial
   binding, but keep it correct).

Not upstream anywhere: checked NXP's own i.MX kernel fork
(nxp-imx/linux-imx), no IW610 references in btusb.c on any branch --
their reference designs wire this chip differently (WiFi over SDIO
per their release notes), so they never hit this.

Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM (Claude Sonnet 5, Anthropic)
---
 drivers/bluetooth/btusb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -71,6 +71,15 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
+	/*
+	 * NXP IW610 (0471:0215): the composite device reports Bluetooth
+	 * class at the whole-device level, so the generic entry below
+	 * would also match this WiFi vendor interface. Ignore it here
+	 * first so mwifiex-nxp can bind it instead.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xff, 0xff, 0xff),
+	  .driver_info = BTUSB_IGNORE },
+
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
@@ -477,6 +486,14 @@ static const struct usb_device_id quirks
 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
+	/*
+	 * NXP IW610 BT interfaces (Marvell-lineage silicon, same quirk as
+	 * the 0x1286 entries above). Scoped to the BT interface class,
+	 * not just VID/PID -- see the btusb_table entry above.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_MARVELL },
+
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
--
2.34.1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792811983;
	b=DFgFAaT/4D3MeJW6FSoC8Xb0+W4l4BGNSlMPtf6yHttiaYDxokYvyJuXhqcYtaOpJKHB
	 o3/oK/wbjY/z9txMWcMyxYotmnIzYyBLvupYeG+dOpHOe5JLlzmVKVN3bG+X5K/e9l90W
	 5y7V0x5Ow1dJuQrtltDoB4d4z8EekdtCJVDmrmeMB7yAxVXqOVx40t5/9BreqHzV2GQ9s
	 YFENhYAuyEE1BA23kjIiSWrepvNL9TspQqNxr+5j1Um2xINW73NCDCDOgd1gVx3vLnfdQ
	 lvTLq0REwz2+1mGS16LjbqTJq35BmD0n21h1nu8iQKIhe6ZKctrvoDDm6WtnKslyaCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
	b=xCz0TW758Xcv+C6usGTphGhclT9iHfgU14isEL1BMCj8RR3/cTMWkOIYe/I9Az9cT0hc
	 RL5kvgSxKaVd5g12HyPYp2BiP13mC/HyPO/UypbPhPkcHpPrDeZP8gAWQXXSseW/rB2Xj
	 +/8P5WR2tUCodr6gYOPK0jDgOBtOLnZUAAifwLXaVpS2glBp0AnU6w8eatfYPtTNstzOJ
	 XSLQk7lGUDTdl7023q0Ohoz+xSM4kt2MM5k3Jr/+UOgUKOtfT6ANQw+iSTT/WU+Qg6E7v
	 zM62qi5mzGp7P7hfLSjEwTGFsBLZHGmar24sRcwDOTcyhwRMHDsTNCVk/EUG8GgdsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BmHQsPTV;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E14606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BmHQsPTV
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c414e5d282eso169177966b.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792811981; x=1793416781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=BmHQsPTV4C6Yd9jver/vb4zK3/wFklnOfZE7Kac3HNvSx2VFzOz5s57kgdPQV17r7p
         jdtfy9UkuLGJ1+vU8fvJLKHBnJIL4PagxGq2B5ZjDYJdBFXU/QyfE2NFtrtPeUMn8luN
         kQPljQG1MgpD9fKGXZ79Zh3vDKgv0T1ro62Mzxg2enkuyoHoI4fZLSgj5OSnyfy9SoHr
         k3oRDQT6K3hwoccXJbMNfvOlD9pazLvbRde9qDxJ4V27FShdNW6MFYDdBNlgvTZhUAum
         rO8hw7dMEAWiw7KpedpAtErWaM38NUfU472lkWNmKiydQvKLweOR2I4NtnhPVqphi6QN
         LScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792811981; x=1793416781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=mFOUIVvs6au2bO1VAXPpmAXxsNV3DGJxvu9ykonDODcFtj+2JDBvfDvBQPKZzcG6W6
         P+38eD5NdfM9/oqo605SWjjNER86OidhqKLSQUQ3dmrpisjXy3UxN2Ws5P0YXsiSrSHE
         S8vLD9KlTwSCoFLqmjCxW7+iPjZ/rRd1Xyr3mXcaZYEdUOmEYWMMMWcb1y69xQDDsPn9
         chdZGJN3ohjNRGhLFH8IWk/htneKX53V9HOAdOYK9nLh+2yU+rtFVh6p2sltxxPPoSFy
         Aosxtdj092UPjuj6a8O7Hp3H94DsC7oTo8oMHD/lmglKPFfLgomBBfvhZm80Xy0kQgca
         lPEg==
X-Gm-Message-State: AFq9FYIROrN4dJ9BAW4zZ3T91X3eJpf+NpnHgjgmz7YRWHDiVZnkKST/
	GsyU0LGSWfwxvjUYhgaIWnXuXRXsfQnF5Oo+6wz09TxyijAKBzqLSTXYxxTuJA==
X-Gm-Gg: AYBFou0FW9tA5vJPkMAVTJ2BDAvIDMCC9LCDuP2BRH5lQDSagidls0AyycbTWNttvyG
	+B2nbbANiQkskPPhvH9w8mptN49pEtRstDSVa5Jk4lSUBBL8d63U+sZGQpyUOIcWVmhJD1K1yAO
	B6Xr3iTvgbkNAZKLZ2DNTsFkQkXEewew1eM1LFG3mHZvxjmPD5k9T1tQeeaDT+GI4z7KGDu52VQ
	gMmg+yf6FWi1o3D5ioscp1wgTponTQGzSRlGGy4f70GWWDUtArvjQ/J5cXiymoHOb+hVoHB9wyp
	/qR8W8IMsh33XXFP9XYTj/xLebP1D+OqoRKKLLZWTxFIzXzWyUS8lyrO3lYYfzz0Tkf0X59FpQz
	YkndQ1Uw8mij6c76zXdWnp9KLs/B16ov5l5CNBdlkQfIb7bSha887rP9m5tDgKyFrZhu1ToSphD
	8TibfzJaMKlD1HmRg1mx/qnf+Z6hI4X4YuY/UfsYX4Wu6xvZkBS5BnVXoITCSdiUIvd4x5W+Yhc
	Z6AAY8QPC53dos5YJyhtKhhn8JNRKxPhnA6JkwUC0BtxItp24NVGoZsT1bCxgGu4HR48llE/Q==
X-Received: by 2002:a17:907:d649:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c46bdac189bmr89945666b.2.1792811981262;
        Fri, 23 Oct 2026 20:19:41 -0700 (PDT)
Received: from localhost.localdomain ([170.62.100.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5206dasm38157266b.33.2026.10.23.20.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:19:40 -0700 (PDT)
From: Hedi Ben Hamida <hedihamida096@gmail.com>
To: hedihamida096@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: add pci restore for hibernate
Date: Sat, 24 Oct 2026 04:19:27 +0100
Message-ID: <20261024031927.50974-1-hedihamida096@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hibernation powers the device off and on. On resume the generic restore
path runs the normal resume sequence and can time out waiting for the
hif-suspend MCU handshake:

  mt7921e 0000:03:00.0: Message 00020007 (seq 12) timeout
  mt7921e 0000:03:00.0: PM: dpm_run_callback(): pci_pm_restore returns -110

Add a dedicated .restore callback, mirroring mt7925, which skips the
handshake, resets the device and returns it to its pre-hibernate state.

Tested on MEDIATEK MT7922 (14c3:7922) on kernel 6.12.113.

Cc: stable@vger.kernel.org
Signed-off-by: Hedi Ben Hamida <hedihamida096@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f87c44f2a..00532b29f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -549,7 +549,7 @@ static int mt7921_pci_suspend(struct device *device)
 	return err;
 }
 
-static int mt7921_pci_resume(struct device *device)
+static int _mt7921_pci_resume(struct device *device, bool restore)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
@@ -589,6 +589,9 @@ static int mt7921_pci_resume(struct device *device)
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
+	if (restore)
+		goto failed;
+
 	/* restore previous ds setting */
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
@@ -602,7 +605,7 @@ static int mt7921_pci_resume(struct device *device)
 failed:
 	pm->suspended = false;
 
-	if (err < 0)
+	if (err < 0 || restore)
 		mt792x_reset(&dev->mt76);
 
 	return err;
@@ -715,7 +718,24 @@ static void mt7921_pci_shutdown(struct pci_dev *pdev)
 	mt7921_pci_remove(pdev);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
+static int mt7921_pci_resume(struct device *device)
+{
+	return _mt7921_pci_resume(device, false);
+}
+
+static int mt7921_pci_restore(struct device *device)
+{
+	return _mt7921_pci_resume(device, true);
+}
+
+static const struct dev_pm_ops mt7921_pm_ops = {
+	.suspend = pm_sleep_ptr(mt7921_pci_suspend),
+	.resume = pm_sleep_ptr(mt7921_pci_resume),
+	.freeze = pm_sleep_ptr(mt7921_pci_suspend),
+	.thaw = pm_sleep_ptr(mt7921_pci_resume),
+	.poweroff = pm_sleep_ptr(mt7921_pci_suspend),
+	.restore = pm_sleep_ptr(mt7921_pci_restore),
+};
 
 static struct pci_driver mt7921_pci_driver = {
 	.name		= KBUILD_MODNAME,
-- 
2.47.3


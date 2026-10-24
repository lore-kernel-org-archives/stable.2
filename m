Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847924;
	b=m6hobiOqsoEG5fyJOA0558u1t1DyrcTZV62LkirwEMlNHrJ2f2s8O12yb1sQg7YlDqja
	 Rk6XAozYsCJ27uqU//V5Dk+fmCFrD5HeuJ+CNmmujgX4wqZ3539LnoNFZjdatEI3PAfXZ
	 QspubI7uVs9X7eVhz3eWVEJ7fsuMA4501wnOJmvyT+IhmveJoESsID9c3COvjq9gTY3cf
	 +ccS0n9Poc4EVhSddPMKwlpvrbJns2fiKdruWnnsuLyuqqM7l8/HkIgfcfc0Mc1JUNtEo
	 n92H+/x265ym+0C5nsGEU1PMb4+0tLcPwjJCVlkSEFRtKAINWMRTllosMUvn8tCxe7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
	b=LOOYXdWbzuQwhx7fzI/QN578APea+TX8k+RzbxxL25s/q9g4TBZsyneytbMzkq3YGf2i
	 O0ZAIJ2LyWbH7HnjOljY/PE8C3E8D0cGJIxiWSxVhcln2uRnqr/iqDIyRXqNIAMHYn4F+
	 X3AHo1O0SVswW6YSk5GdIVq5R5qD4dy2KRSjOLL5drYXIgYlA0ziYKPkzceWqM1VshbGz
	 YjTluQVN9/1kB/Azr1SlH8JLnYu9rbCSISgHU05rfqX3bC5XTC9Cbls4tW9QjaCx3Ixop
	 Ri9AKWu8EPLvyRxs34X5AcT4C+DwtBNXDlPfvFTv/36gMF5Hkq9LNdd05HYqIb91Wxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dWXcPICu;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CB606A321
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dWXcPICu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e8c710847so210180866b.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792847922; x=1793452722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=dWXcPICuI5RutYG0stT0mWxr/6mtb1L0h7kPXEXl4+n4pgy2yiaNbrrMGe8wE+JNhQ
         igwWIYtv/4WeH0U0yWJG255me4H0JKq5osY52AL4peP+BfmdA32hfUKqofO3xPOVHSp4
         dVNBPZWpLiQT1QThVyMobFfwS41wlRLV0PDmynwIYBSsAYmL65UyU6hgm5STvbzPrDzz
         hlDQwJKFXvvyrLNxZtM8xFRaYyAMJP0oM2EgZGcUAW+Vh2Q3uWzKVgRlLP69zy4Q1mJL
         VA1pWFGHGJXN1L+JnRqj89aHysCGoxDIm99ZFt/UnagQJYtNr4J2EMEjcRIPVFlEC21n
         tIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847922; x=1793452722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=WlahYmkOqClbcehC66pl27mhd3SDpJf8nuLAc7n7pZOH+vMjKb73wVYJB/oAMayCPe
         xwGb8s9OkIlxqtLNreFdTxDa4eyBdlQGd7NymWNqD/HRJ6goMfKskYTSfVEzBER/mmtG
         ZV6e2Xxvf/GvvsfcU6wJC4gPJ0MAzEDIXkyoHxotBYgt0i90tKtfWLad6LaIj4h3Iv7N
         eScw/KXaH8PIuxcMgeCyWq5IbDy1Ih0Y8y43BIul64m99tAIbok2uLZMJHXGWZI1EBR/
         6/nUBXjdOUlJYHYhGZM6xuvFG68W54pm24ffr1cLvahrsA81wrDLggIC3npFi38kHVOJ
         YOHw==
X-Forwarded-Encrypted: i=1; AKwUvByOlllE56Qnm2Ea2PR3mS6JiDlrOMmpPq+PEW0BvP0+x9nGbJ3D5ZgGYHwkglXqp/LQLAbuweo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDoFv1h2yJNUxUjrq/OFLsKhZGddWULqiWox6LiDut5v4GyHDP
	oxSe6Xz93FDE/hTIE1MaxYXQlcaRm6usw7C3xXvrsfc7tcUcSLrjrSOp
X-Gm-Gg: AYBFou3P5FGbXqyulvXmpIKIii1smUq0BRuRxa9eylPu1/bEXM8RNl0ftZz7bQZNxwm
	SHj2IuOgWAsjsotq731dlU1Hl/hvN/n0BLk6ZNEZK9mulVIWV2nWfZDrSGTVglMOzkmLZnn+LTw
	KgRW/K4YSmLjOwIDddFFU+ixOGA9Ed39EaAEnRhrVR2/JcoMzsV66pvwE2GN9eTNL5uDe3E3CIR
	WByOij5MHF/BHh6tKsyOxmnxYWH5NwcgPSk83GaPcArwTkN5bkmmqr+XbbbZQmnVzt+OCklciZR
	7OLumsXickWNyk754a5e26IJam+oxlpiBPrt3bdmzY7vzjGIHpmBrPRzQ5lpXSaedhtIl+HlJLR
	rBs1pEuUH3guW4gGuakqOufIPMMR94n5Y5HGYY361vAbRyka1whohJmF/OZ6tTQsDZpBGgLE16c
	youkdP/CWVACEiJ17CNNkY0rcJ2rvzaic6BVtO0thkjJDGBl3Wp0v9KKYLbSvppBWbCu0sDj3o7
	LgP+6mZcbWyfiXKC/ApJAm1CHCpIqhuH+yVq3axENhGagesfXOBCVcBtpSmNFFjrv9WRiTrPfpv
	jJW2Itbr+fVZxUPHng==
X-Received: by 2002:a17:907:d649:b0:c33:392f:7ca1 with SMTP id a640c23a62f3a-c46bddce42cmr186626466b.17.1792847921987;
        Sat, 24 Oct 2026 06:18:41 -0700 (PDT)
Received: from localhost.localdomain ([185.65.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd6276d8sm87306666b.41.2026.10.24.06.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 06:18:41 -0700 (PDT)
From: Hedi Ben Hamida <hedihamida096@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Hedi Ben Hamida <hedihamida096@gmail.com>
Subject: [PATCH v2 1/2] wifi: mt76: mt7921: add pci restore for hibernate
Date: Sat, 24 Oct 2026 09:16:52 -0400
Message-ID: <20261024131715.64435-2-hedihamida096@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024131715.64435-1-hedihamida096@gmail.com>
References: <20261024131715.64435-1-hedihamida096@gmail.com>
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


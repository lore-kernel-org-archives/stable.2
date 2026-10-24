Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812190;
	b=l0ANSNLC/vLBPBjQ6uOKVbFUtvkhyU3LHRYgtkxe0UloGkTvH/ivbyeeU94nQ07wB6GE
	 pB3xnjwQToPhe2eDiemBw65568BkVGTOtZd1okhYJS+vjtbtTGxSb3IBDFPFUdI7Ne/oW
	 AsU5alYTyFBUvSC6ss+WuEoqDOvuPIBbja+6W1bT4kNEEcwp+KdE1+OUGnfItuTTkjhSM
	 ZshLrMM0hZfZsysaeWv0dCeVn1dzY8blN7xHBfx4ZywlDXtBFFnB3O98230lOW9e4GP7Y
	 Wmdz1zSqXT+7dCiOpZtox0/WP0U292rwHLPyLmwVTNSnhc6Y8oClwLrIqPpfaAsiroA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
	b=YUjVsAzlAucn9rxJAZtqWz7JnhAKJYk3bM2s7XK1rEZlrX5+NCJCYNUAlfIGvNPMXsVx
	 ds2IepMy150eVoqVP6qcvGifrjkA73LMbSzuS158lPK/OcWx19nM1P66cIPZJRBRP1Z+F
	 cvkRHJhbAQkm36E42kFb7J07XkF+pgr5r+teuHaNt7KzpzpD1obRE6QLYNt1gjjHE7xyh
	 5s36705Vf340T31xvAFja2Iz3VsjyUwAGP0zN+bBpazDK6mPidRwpET9Ow5tnXpPJgjjT
	 xCoURWw9ONN6ihh5av4Cs/R9DEYzKdH+3Mr+mzK3UzdgJ/DuB7l01P45Z3OgfFzDBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSYGpV6X;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B44606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B44606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSYGpV6X
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so2425139a12.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812189; x=1793416989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=pSYGpV6XhiNrN/MgRiKZavz5Juj7gKfHDnodVvw/X+/QYB6qrlsCrkg2Si4A0+jwnF
         xfWw3rcxzPKIb2f2tjbwTRkx2xibfU4ND9wl8RmFPhhf9+NX40jGCqtl0R5hv90+Xa6S
         HU7tUlORqj7WQaN96Do9CmUWRamZQIVX9D0FfuC+y9COyoingI06M48oGcFrhvMtJrKJ
         oxcYn81kKK1/BcrAEUvDtVjuNTQwCA0FEC2W59VuNX2dWkdaEygnWRqWs8l00U/zxEfL
         C1mmtkNILTBi3CXCMjsU0KsMVGQ0Kpf4k6a7V9of4MeWTq5H+qY9pSpKl6l5gpz3oren
         RBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812189; x=1793416989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM8GNQ21z2tofnQ9HAGS228+B6GKkzHToThuxWl3/VM=;
        b=acWmMGanisdEMilv7SZ+5hnjLUTwPOmzQm8OFoDwBAFddJRdvi/YCWHLFmkoViPoty
         iCRtG+gH1NTmEMCfDa+ORTAAarUElX0JgWfLOg8itMJt/NW3aPA+XlpyRJWvaAPclxuZ
         JikpZkyNlm4PsWKN5n5r95eAkweHB8ZX/jVTzKpeHuvbE9EK2oxOY+eDzbeF19+NHI7H
         7TISgjIbjiz4LK+9yml3w7AwFjvs0U9l8dbX9Kw50M38PaHKCwq75Onxv3+4kVq2rixH
         FcRUf8IrrUdsKwdBLTaUxw19dXuYCoyncfNwpCzPwU45mSwWnLlrxbCQye7lA7FaGqAu
         ZzzA==
X-Forwarded-Encrypted: i=1; AKwUvByaBzDo6aO58H+EQPwohOYGwv76ImAXxb9AHgrNzZXo0n+YdktQEa66PteVQ393Yjze2lPFS0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKesTzYkFbrcOCGUXgTMYcg24phIX4nE3wJgofP6DRVDU65+K0a
	3obuy/HkHYI/0idkQ1Z37W8/jsRBwbTnIpjNyVWmfkR9us+dfJcybRUU
X-Gm-Gg: AYBFou0dsvci8n6srLYDorzKaa2c359CsTgyZx/SQjTBCQRQJ6zwb8taZAD8/Xebzp+
	uDwxFlvPPAFAKm47JdLmvwL1oDpavq4L37YtAi/vGSkQfJN8P1kqFaobty/CNoxeFqfogsQVPBK
	sLNDLB9NkWmrxD0uJ04awSI6BIjtUNQiKWYIgBOvCQs1Y5HsMno+uJfVeFjUt+jeqYTWEbJPOFe
	Vjgp38dB5aWgTRxg5ai7yooq5vUrtzwsFFjymZnIOl/VzABls37RuF2Bir6TQht9UPeWSIjauTE
	w9/UaKu1b+/ydg8dvgLZ2LuyKCpGwHq1X/FolwXNBwh4DyKqdQatJwHmbhFdvVwEmGGwCVAauaD
	h8ZDlTmTnyuG5z2lxdwyWVi1t8RCKkXktFYQGc8iYqhRx8Gj42bMS6xUD8WD/ievem3gDmn9GgC
	2XavrtngFYy4wi50O5S0gk3w4QyccPIcbNw7crxCMT4GGvmXqY4V6oqRNg56leGCMazvMhlxthi
	gsQABO7an4rxf3LM83ZbTMvfbsAgqWq7LKkE6TFMeucC5aT36ExlRmMDPdo380MRWKou7Zv
X-Received: by 2002:a17:906:f59c:b0:c46:7ec3:fde7 with SMTP id a640c23a62f3a-c46bde62669mr89622066b.31.1792812188826;
        Fri, 23 Oct 2026 20:23:08 -0700 (PDT)
Received: from localhost.localdomain ([170.62.100.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7a7c2esm38164666b.80.2026.10.23.20.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:23:07 -0700 (PDT)
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
Subject: [PATCH] wifi: mt76: mt7921: add pci restore for hibernate
Date: Sat, 24 Oct 2026 04:22:37 +0100
Message-ID: <20261024032246.53918-1-hedihamida096@gmail.com>
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


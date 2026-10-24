Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847930;
	b=n8Kl0Sj4FIpfA31VBBm4CUeBQcqIdhloe2Se1fZsXQJEDK1H2SWr7n+zDLJGcDaK0YNk
	 04+MdPg8b8gyJseQ5/VsrP6jOFt4T+/EER0YD9XCui5P8OSQqAfkPmAtBG8c5EdTH3U+0
	 ryQSqs/OGKtGHbpatSARQs82VWGXZB6OP47XfqreOE2TNpXYqveMilaT6xDhoSkY6TtcO
	 b/cbCAW1rmQZlyysavfUB5JEPfSBDr4lc2VVd4+pazhlQCotnro2VZfF5EZ0iaKvhvGmN
	 y8Piicl520O6Ex2l9cDaBjrmhAQHOHHR5ITE6joZ/gYPbwGLjaeO8yPrkovkyBaqDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b680pKzQa13v0eIR/DWLULm8zwErDKH5uvrOsGuOoiQ=;
	b=K992XGTH7J9qoeqJB8Ll/HWflfBzVydEsPUnrEjnzNsrFZw0cVIIoJd9RxJ5CUaPuakT
	 4euH0cSCWsi6R6K1prE6n/239RruM57Tn/QwDFyhKd0N1wG1TbFTRH0w3TRySfyT1waQ6
	 KpXkXyGCktcUR73AnkCKW25cwPZb5h0HT5O3kE5hppBHr2I1g9HF1YlWhZWN6tyst9Hbi
	 2ACumwMBD/GlWHwDVxAvnLdH1Wdg3tdBxD1OfDMkch08mqb7k3obh3SwXCoXHSPj+WMsJ
	 9ySpn77SbS35cqsmS7bbQ7I9TPZicr2FxUgqm0EqZ5iBPRGzNeBy0GYN4MZwEpXrdJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Jaxb/P3P";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C89606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jaxb/P3P
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e8c710847so210188866b.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792847929; x=1793452729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b680pKzQa13v0eIR/DWLULm8zwErDKH5uvrOsGuOoiQ=;
        b=Jaxb/P3PXjFT38cXGvFVo4MLASdIUYSGXWXC7juOTbCdguJZsMVrOfc5L+iqWqi/ri
         w5TgqYu+JlJDs668cuw5s+EZbVxKM/ftWrn/jD+8U3VXQhNKCrGrc/geDSTeTECA/Wrw
         +mVGHgvWiYiFYjebTzctnfnBdnYVi8+z/O2pel/f3TR3bwmtiVzaz0q4xLdTR0Dty/OX
         Y+vkU+3jukMWt6c5m9Yum1c6axwju/nZOb5/qiUORnFzCm+0543zu/mb6riXYPxKdXDA
         dmw1bmTFMC9uGYpHsOHAL9zMbC4kSqxqCogFz7iyAeB3LeDiejZZmCHPSjEUWwY5WBEz
         NcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847929; x=1793452729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b680pKzQa13v0eIR/DWLULm8zwErDKH5uvrOsGuOoiQ=;
        b=dw0fCk913Jle06NEFWmpGaTWcJ5vPLczmO3rnxWlIEF/SnXf2K3DezFqPu5ThXlt4G
         /IhaMbpMK36tamvK6BugzeCx80c4drJ4e+nBgDuAqqtb6eNVdHouL4hsnK0y1YTzYHtm
         5ge22XOnF0p7A1vEdPA8cVqiiHIGXHEP4wGAl7zy+KjQTpchlgucyF0I5snd2k4sd8Qm
         Ri/vhx2gIrv0mgwrlJugmWQuBG/WnDxzkn+WbdJ7IPHURGZ5Z19AKDQBI0kAthht2cym
         AxDbzAMxBrH33LI7tLDDi4fJDe6QKum0z5Zetn7+qt3XrQk19NnNamd5Z8qSu9DXOr6B
         hBYw==
X-Forwarded-Encrypted: i=1; AKwUvBxj/0358Y1AMm8IW3cDILownTCtVX+mw0VPH0VfSL+Sudx27ZXLKCOtn0U20Kf8xD9r1Nji1m4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJofMN8QgNy1BEDk8NrtveA//aRx2NC63rwQSWweEarWme2eXrw
	VjYKuUcNEpoupL1+8a52DEkXbl5U4tqPgE90ukEBQ1IBYrVTXXp4e+Fh
X-Gm-Gg: AYBFou2guG+bcX8EGdYxTrOi6UEWduIKuBu15IKL47wD3GK7v8gj131HZI3rNbyW7J9
	bvtmkTbIu4alV5a7w95615LO1akBcGK/THMEdPbgVDtMUNKSl/uPEyof0iCJbfrRTp8ncxFqd+a
	cYVreTwyrc5v1sSqCTnnurj4YlGl631kxLQmOO5L+u3KH6FmbnI3x/OU2SwfTO+ntG09AKlZra6
	EPSzllDgy8gF4TPPigcbsrS7De0IKdo/ZH+LH5UdiON2FpnFu6V6PyKFdUkN+58x3Jq8/KCvbiV
	KejJQP8jNlMbQTPGxYn0XrqccdFMUnPulqbtyvoL2gyYyfoBr8iXee4yhyiG+5OoilAY0mZImtt
	6+HXU6vdMoTSK+1J2xSwduJ9UlSLK4QVvTNMzkk8YShezQw78x1dWUDcqBcRO7LqZWWmSakCzKI
	fkoYkdZsS2Sd8sZ4NExYb1CR+DRwmfGu2RXkkvx/qBBqZPfN4jkVMJerEKH4p+6Jak94HmJLTuy
	FRs3HZmHUKJA1kfMfXfvZZCaGraY4tQCZbIWbfBh2s2613/xzyJzBzge8O/7nBT7tNWsndh
X-Received: by 2002:a17:907:2d91:b0:c41:c106:9772 with SMTP id a640c23a62f3a-c46bdac60eamr203215066b.1.1792847928479;
        Sat, 24 Oct 2026 06:18:48 -0700 (PDT)
Received: from localhost.localdomain ([185.65.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd6276d8sm87306666b.41.2026.10.24.06.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 06:18:47 -0700 (PDT)
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
Subject: [PATCH v2 2/2] wifi: mt76: mt7921: reset on HIF resume timeout
Date: Sat, 24 Oct 2026 09:16:53 -0400
Message-ID: <20261024131715.64435-3-hedihamida096@gmail.com>
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

On some MT7922 firmware the HIF_CTRL resume command does not return a
response after D3, so mt7921_pci_resume() returns -ETIMEDOUT and the
PM core reports the resume as failed:

  mt7921e 0000:03:00.0: Message 00020007 (seq 6) timeout
  mt7921e 0000:03:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110

The driver already resets the device on this error, and the reset
restores it. Treat the timeout as recovered after queueing the reset
and return success, so the PM core does not mark the resume as failed.

Tested on MEDIATEK MT7922 (14c3:7922) on kernel 6.12.113: suspend/resume
no longer returns -110 and Wi-Fi recovers; hibernate/resume still works.

Cc: stable@vger.kernel.org
Signed-off-by: Hedi Ben Hamida <hedihamida096@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 00532b29f..dce88fcc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -597,6 +597,14 @@ static int _mt7921_pci_resume(struct device *device, bool restore)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
+	if (err == -ETIMEDOUT) {
+		/* Firmware may not reply after D3; the reset recovers it. */
+		dev_warn(dev->mt76.dev,
+			 "HIF resume timed out, resetting\n");
+		pm->suspended = false;
+		mt792x_reset(&dev->mt76);
+		return 0;
+	}
 	if (err < 0)
 		goto failed;
 
-- 
2.47.3


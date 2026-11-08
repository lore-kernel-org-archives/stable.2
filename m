Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794180474;
	b=qpI6id4FRQUXlMw2HDVlTEGG2OKHV7ap4wMdzzd3EqY0Vid6Qd+07kJfx9Lf3d7runPU
	 jTVAAaTMofr6RDBOjyynUXbTXn5z81cuQsrEP7g8viYM7kFdRA1Ba/QLEsDPzYu3TqYU2
	 gO1JoCAKN6FhU6P/CAyMJI4PqYodDIsCN0uYBl67rKlelCLK/zefFM3WvH9gUJT4n13Lk
	 3IkZNu1xEwwCK77frL6W9S0+rSIfb0xD35MHO99conVoRN9o++rreSI4Paa3w0+rTBGjt
	 tBrQaLSqfBcEuTtPj304lAzpDOFzyKCkdO6eyWGle1HZzSi/tK26qqFrAYYh35fuLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794180474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=29ND1xXn3ELD+DnjwkyWpaNhwBfnd9yLmIeaLt62EPg=;
	b=KdmM64EElTGpWDmawWkBCi+pj7A7XS1uXqdcJZ9L98yC//lJhmuyD35jXFSbkRBpUYYJ
	 NDHrwKhlzf9OEjsz6hfcBtYZDsC1cBJ3e2nwvjQDPCrbzNP0Nr5wrZc3ZjPObcO8reWEc
	 4d15ItkvrQr30E6WL28rvKEu7QHWmD9sDlnhBNSpG2f1HIzx+FJT3DsUrt6Qr9430fe7k
	 XppwrVs9biJuDe7q417VKQ4t0Lu1xbWAjH8MNvzBtxIBWwwjZ79WFkqseFrQTTeyKMxHU
	 ZRhlfPfUzDcse3yPiJ7b2uTqx2u3ZN8nXicAsegLM07R50gcvlI2yMVJb5Y3UHsjIZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r45ucx9p;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AD606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409AD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r45ucx9p
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-854e904005cso269477a34.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794180472; x=1794785272; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=29ND1xXn3ELD+DnjwkyWpaNhwBfnd9yLmIeaLt62EPg=;
        b=r45ucx9pYtzt4RdM48hMF02Iu805XHp+5VZdkW1DupekRYc8DJ3/b2zyGZ/hrhFfvp
         4iF7ePbJ4BexBp5vC10YhlagUEdSci3OQ3Fts1qomOeZn11GLW4zD78wfzPdE/BRGCmb
         mBMkutoQ0c9d/+RMVU0mfc0yECsFjzgfT129n4bKNQZenyot0wyjO85YsVdYMAvgO+CY
         WT55HNO+Dge5AAHcsi5lNR8FyeNy67VwF43FqZB4GeJ5QCJdFAfZb7rBj7IQ3p6Wo1HG
         Orhyp5qxfjumgO9KZWJt1xf9h+FEzteUT9TjON97Nv5IYIw0Bb3FOn4xSjnhMfRyl+DC
         xbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794180472; x=1794785272;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=29ND1xXn3ELD+DnjwkyWpaNhwBfnd9yLmIeaLt62EPg=;
        b=h6uEXETzglAhbPI4Iv6nfxAVRd3xy7xKBSMAZvl8RN9x3u9Jk+2pgIZ4Lql6ZsLmdS
         jk0p5q9DGGc1L7lXAq2R77ZrnhWw6KN4a34NuMAHUXCMvNUQKdJeAqP5JvgiHNL/mALt
         eYO/S2ZpBTmvENnHk6roHYskhmjtnuak4jXlG/T7DYFJHm5x8uCiASfU4VPWVjXOSTPM
         HXTboLGCEeMQg49YTju3CrdQQnX+bw0r3hmDHaSLrGX4T769YmbA85jsrMt8Ven1ya1L
         nf0ycKkMYwp3CSf2apGDELBiHyout9xHGbQSnSSGvAGfQi8/X7TqlpMgZEzZXRHr3hNf
         3N3g==
X-Forwarded-Encrypted: i=1; AL+hErF5IsNHvL4+S7fmS8ZTkPZKYm17Pc7flua1q7Ie4x+8+XDMqfo0dPXKFYnEIN8MqYBfbtF4418=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Rq0Mq9ar2T2vIp1QqnxWfVM+gFH/LipMlXtWlbArcGKLADRqG
	ls/3aoDewjoExmdyHCLkPH7mWzgmZF/ntRRO7O7BOI5+wSIHbAHKXSTl
X-Gm-Gg: AYBFou1OUFWeV0UrgbmqrbdCEmLBDYbRY6w0c7O3yPhtQpz47DlTWz90dYBQgNjwu9A
	KNpVlKCHVIvTYzMY8VOdI2BVBNZNMwhVxoNOampifxzfBVRy2NJAhT3k6NCXlqVi6LFFhodGTQa
	EnSfT4qmbFqsLhQi6Az19Gjmu/xxody3QzNbs4VXcEnKqKumUUo1jSWaD+oOZePzobNUlUlMuIh
	woiwi2W/D9DqtaiPBryVN7M4u1HWH25L8kworTHF9XhAu0pYoK0F98LO3t0C4lxp4ZWcAdCWd/j
	qT7gHuaRD7TaXzjdFHajqzd57THbd8NuYu5wt7pDrrNvi5rQXen3Y2sWqOf1TIKI7Wzp4xOFbOf
	L7QuT6VRfgk1k0Csnk6aeH/3s5rw88AgzHzyS7xI376nEsV/HOd9d0MqLP3qeNSvJSRkcbhxP87
	J1XqEITCFQ9JfUCOB/G0K+hmjC8apGvrwoj4DN5aWDD8SGBOm5tJnWUlH4K2H+jkQotuaFcBe27
	97PeLZ27ZmCHSF6nkSPuwgh/CwEHazRfj6ksDpf7010pbxAxN/qLWpMmrM/7elFIRR8KeWM9GJR
	exnthbLIf89BGAqRu206AbidQJirEq0o6DgG11K1+XnjRiSEqYiNGgd6pnYSjtsBCiNhCVEXgra
	VJaHsLN85DAcj1IQ0xcee6Pl88maRQraXDiS/GJw/4RsKmj38moq1XWpdwB1aVMd4WH6PA/gZHB
	xruJzmoDkGmfeit0PPqj77I9BQyOeV9lGkSvUaILdfb6K/Uj5OmjI=
X-Received: by 2002:a05:6808:1691:b0:4a4:64b0:bf5e with SMTP id 5614622812f47-568143032a5mr1010143b6e.2.1794180472163;
        Sun, 08 Nov 2026 15:27:52 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e56700sm2936856b6e.17.2026.11.08.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:27:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 16:27:48 -0700
Subject: [PATCH v2] mtd: rawnand: r852: preserve card changes during
 detection work
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-r852-card-detect-lock-v1-v2-1-e3251bc3680a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42O3Q6CMAyFX8Xs2iobDNQr38NwsZ8CUzfMNgmG8
 O5u+AImTZNz2n49CwnoDQZy2S3E42SCGV0SbL8jahCuRzA6acIKVlNanCC8pTUR/IkzUMJr0Bh
 RRXiO6gEThYaWsuNKn1ktSaK8PHZm3j7c2p9OiHs6ydi8IUVAkF44NWTLRn10wqWGc8zzwYQ4+
 s8WcaKZ83+aVBQ4pxU2vCpZcb72VpjnQY2WtOu6fgEUKZLuAAEAAA==
X-Change-ID: 20261108-submit-r852-card-detect-lock-v1-713bf5cd926b
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

r852_update_card_detect() reads and writes the card interrupt enable
register without holding irqlock. A card interrupt can mask detection
interrupts and mark the card unstable between those accesses, only for
the worker to overwrite the mask with its saved value.

The worker also calls this helper before and after registering or
unregistering a card. An interrupt between these calls starts a new
debounce interval, but the second call clears card_unstable and enables
interrupts again before that interval has elapsed. The interrupt can
also change card_detected between the worker's registration checks.

Hold irqlock across the interrupt mask update and leave the mask alone
while the card is unstable. Move the transition to stable state into
the locked card sample, and return that sample for both of the worker's
registration decisions.

Keep registration failure from overwriting a newer interrupt's card
state, so the next delayed work invocation can process that change.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204068@kernel.org/
Closes: https://lore.kernel.org/r/sashiko-outbox-204135@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Keep new debounce events pending until the next card-state sample.
- Use one presence sample for the worker's registration decisions.
- Protect the registration-failure update from newer IRQ events.
- Link to v1: https://patch.msgid.link/20261108-submit-r852-card-detect-lock-v1-v1-1-5514e7543209@gmail.com

To: Maxim Levitsky <maximlevitsky@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/nand/raw/r852.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..4c094648673b 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -557,15 +557,20 @@ static void r852_engine_disable(struct r852_device *dev)
  * Test if card is present
  */
 
-static void r852_card_update_present(struct r852_device *dev)
+static bool r852_card_update_present(struct r852_device *dev)
 {
 	unsigned long flags;
 	uint8_t reg;
+	bool present;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
 	reg = r852_read_reg(dev, R852_CARD_STA);
-	dev->card_detected = !!(reg & R852_CARD_STA_PRESENT);
+	present = !!(reg & R852_CARD_STA_PRESENT);
+	dev->card_detected = present;
+	dev->card_unstable = 0;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
+
+	return present;
 }
 
 /*
@@ -574,8 +579,14 @@ static void r852_card_update_present(struct r852_device *dev)
  */
 static void r852_update_card_detect(struct r852_device *dev)
 {
-	int card_detect_reg = r852_read_reg(dev, R852_CARD_IRQ_ENABLE);
-	dev->card_unstable = 0;
+	unsigned long flags;
+	int card_detect_reg;
+
+	spin_lock_irqsave(&dev->irqlock, flags);
+	if (dev->card_unstable)
+		goto out;
+
+	card_detect_reg = r852_read_reg(dev, R852_CARD_IRQ_ENABLE);
 
 	card_detect_reg &= ~(R852_CARD_IRQ_REMOVE | R852_CARD_IRQ_INSERT);
 	card_detect_reg |= R852_CARD_IRQ_GENABLE;
@@ -584,6 +595,8 @@ static void r852_update_card_detect(struct r852_device *dev)
 		R852_CARD_IRQ_REMOVE : R852_CARD_IRQ_INSERT;
 
 	r852_write_reg(dev, R852_CARD_IRQ_ENABLE, card_detect_reg);
+out:
+	spin_unlock_irqrestore(&dev->irqlock, flags);
 }
 
 static ssize_t media_type_show(struct device *sys_dev,
@@ -632,6 +645,7 @@ static void r852_update_media_status(struct r852_device *dev)
 static int r852_register_nand_device(struct r852_device *dev)
 {
 	struct mtd_info *mtd = nand_to_mtd(dev->chip);
+	unsigned long flags;
 
 	WARN_ON(dev->card_registered);
 
@@ -657,7 +671,10 @@ static int r852_register_nand_device(struct r852_device *dev)
 	nand_cleanup(dev->chip);
 error1:
 	/* Force card redetect */
-	dev->card_detected = 0;
+	spin_lock_irqsave(&dev->irqlock, flags);
+	if (!dev->card_unstable)
+		dev->card_detected = 0;
+	spin_unlock_irqrestore(&dev->irqlock, flags);
 	return -1;
 }
 
@@ -684,20 +701,20 @@ static void r852_card_detect_work(struct work_struct *work)
 {
 	struct r852_device *dev =
 		container_of(work, struct r852_device, card_detect_work.work);
+	bool present;
 
-	r852_card_update_present(dev);
+	present = r852_card_update_present(dev);
 	r852_update_card_detect(dev);
-	dev->card_unstable = 0;
 
 	/* False alarm */
-	if (dev->card_detected == dev->card_registered)
+	if (present == dev->card_registered)
 		goto exit;
 
 	/* Read media properties */
 	r852_update_media_status(dev);
 
 	/* Register the card */
-	if (dev->card_detected)
+	if (present)
 		r852_register_nand_device(dev);
 	else
 		r852_unregister_nand_device(dev);

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-card-detect-lock-v1-713bf5cd926b

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


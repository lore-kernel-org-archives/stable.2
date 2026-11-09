Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183749;
	b=kRM5h9virCTNrIKAnUUsKpYSLpYe/hz5FN9ZPHecB9TGuxgIE3nvbDXKtjsBVcWQhXjm
	 Se1o3OwxzlGglnmbpZ46Jq4l/wN95JRdg1vpvpqrRAzjAhEiq5w5/Q/VceugVxAuwO7em
	 l8u2tVsle2bCIWxDSRH2ZkvpI3QdiZB+xMzmhDp5sq2oUAlQ22ibkTnU8K1CLJqAIr3Qa
	 iz/nqIuRif0ikqcKrOvfq9rllOYlt4JsJjWkmI0KaM9EpSfgrnZXd2PZsJoj1o3Jzb1AC
	 zbE202P487iGGLqmabA5gE5il1xtLJ6EJKSf2XhrkpKDl5i91LcuO3APatb24P7Ysdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=r0Wktv3qg84AghHEx+Ox2jLbCSIyBPFOaRI1XPUgVtY=;
	b=VXNQ4M3Pf2mDaW5av9HEaRIufxF7VrM0lkDjxBRiG+CkK2Kq9KW+g16LKqQmBS8FEY2F
	 M0SZNTLFciM2/lLpFzXVOvw3d9Zx7vtrSba0yO1QQ/C5aqzOw6yrqlXHW3kbjoVwV0jbt
	 HQ40pBA8lCSdN0sWlKD1t/cI7+qhu2B+ZAsBcZo6zmO3GAbOLJnXVfmkNoVftEAo++AVA
	 jSsM8PB9LGZ/bbhR0pTIpx0D6t04oPRbgbHWdZpczUYtW9nfpCkq/c17sv3iKl0XZWKzS
	 +a71jnNLhoZkOVNF1SjfJGtBKWlFClPLfs2aHYzxQKXRJI4YL4aUWo97JCuYRDdZh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVe79pf7;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200C606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2200C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVe79pf7
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-490d838b425so192156fac.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183748; x=1794788548; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r0Wktv3qg84AghHEx+Ox2jLbCSIyBPFOaRI1XPUgVtY=;
        b=hVe79pf7qZunrOPvh93Q+cZ3FrNrGPfQ8E6XG6FVcZbq+kXWRWo9Jz4+TKfUFNtuvX
         eqYANthGPNk+0PYTuxLlb5plLWd4eJR7UQSgo46ZZvuhT23ql8xVBtwd7jOywsonQ5wQ
         gDzKveQPb61+ehoEmLl12tiZSUg7MvxhOFTVY5WJ0LaiwqKehgymQmADtE/eZ/Q/qb3W
         K0CNkU8AkudDAKz/O5GQ0bMXUqvgMCHi0U/IC1BNoxsKygzDPTKwZ1WTmDp+e4o0Zz3y
         mRNB7LOa/Z/AsHia+rCb+0adeJJyuQ3hSd33zq1zNNqLXux/91AJJ11oxRZyiJU2KsFN
         K1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183748; x=1794788548;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r0Wktv3qg84AghHEx+Ox2jLbCSIyBPFOaRI1XPUgVtY=;
        b=wE1qUcLZ7sAEGX+k6qUvfqLyaUJknvDGaYSakeFZWpQIJxVfFiOWmrupgzoueuaWxI
         JQbbQ4oBLiBVwyohtfvp0oZe3ua0WezFJZ2+DtjQb2otQWfUOvW/GVpTOb/Q+1FKeRBu
         L4nKDFLRdjkUuvy77iEmpKbKncNz0gwr9lGz8y9sF5O4sFh8FYtnC1cBGrzDNAeMbdXA
         pf8GK9QhzIzcbT0smpew4fubS+EIn4J2uX26I1UpMT2rHb8K5VvJpl2L4z09gKMT8coV
         62Kp5nkhT6xXzAE8cUfbSQYzIyuQy1p3vtHuglS/97ssLNhP6/t2QD0oSDLlYNfL2v8f
         8ubQ==
X-Forwarded-Encrypted: i=1; AL+hErFU15WpcPD0pOXWDrUJ9ELm/ObwPq6vEDK4sazPx14XvIv3WLsJqVl+A6WdKKdstWk/vvzAUx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U8Z36wOE5djB3fIdYYVDZcuhyO2xQ+tpfHyqEfESRUijfxKqo
	JmsRwER+nCNVWSy/cZlJHeUMlfAmOLI04TCbIkl13HQvZDmvvN3TORWVooZQHw==
X-Gm-Gg: AYBFou3kKja5Tp1wyDY+kB7m2T78nFcBDVqieClgdX0b7XKI4jeE/eTIZEYpbCOQ0PE
	EKUCocRaG7Soioq7v2bN/TeAYHRljErofTEpMWueJXR1VGPEtDD2phtP+gfdYnrFySxbX3T30j3
	UGQ2Li8hrNfHIkVDpd9T4XcBaPf1lDDuRCtD4+1AQ7QtiJv2EoqCkS1Q4CyYwpQt1HU8BTN+f6x
	7bG+OWTxYzwYKWv7cT1hxVXPm8bX3+cdalH8nqDqEQDx4nIA99pDQblwkla6XWV5wARzrsCE44I
	5KHK6JmIl9121kESrrpUW0FJuOYpySscR5Mujx8xj9wM5alEjIpocPZjkGGtPivFn4WlsTIreGc
	T+RabSY+nb+O+zCbIy54/YgBjspFspswzH64xY8Xt+tIDNFIxygmrhW9Jh7G9CVDcvpgg6QwNuz
	eetAPsyB2+uwADBJeyoZe5z6aDQrWEbd9R379QcF4lc269Sb736eN5kzvGDAgRrQV4WtAAzACMR
	vMcPSM6gQHIkCQo8w8EtDRqwi0PT1TqXVXqIOL5CaQR5Fbf53ZS3f05q1xDQxLofeEu0pA8DMSH
	E4r8yy3kxyHSeqfsCWKiKFV5va3f1sL2vEPju+yTyMl03X+UvSCYPVMHrEGxc1VMfhjV4ER+mvg
	VYQlhc+xTBFf4ggx8sGk6mvmjeyzu2v6DJT0odeFn72KCjwj5ZISCDi9Q4+GLRJjBPBsw6fMB7Z
	/18pUMNDwUF9TF5xNQ3iu7bOjAEPcRH5MOHDkfqKARskmn+mA/oti++w==
X-Received: by 2002:a05:6808:5088:b0:53b:6f4e:5176 with SMTP id 5614622812f47-568147aab31mr1788815b6e.66.1794183748050;
        Sun, 08 Nov 2026 16:22:28 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm3091574b6e.16.2026.11.08.16.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:22:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 17:22:18 -0700
Subject: [PATCH v3] mtd: rawnand: r852: preserve card changes during
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
Message-Id: <20261108-submit-r852-card-detect-lock-v1-v3-1-ea9e5411314d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw7CMAxEr1JljaFJSFtYcQ/EIh/TBtoUJaECo
 d6dpGxYgmRZmrH9PC8S0FsMZF+8iMfJBju6JPiqILqTrkWwJmnCSlZRWjYQ7mqwEXwjGGjpDRi
 MqCP0o77CRKGmXJ2FNjtWKZIoN49n+1g+HE8fnRCXdJKxeUPJgKC8dLrL1hDNxkmXGj5innc2x
 NE/l4gTzZzf06SiIATdYi22nJW7QztI26/1OJCcZmJ/8ljiIWeCKs2rppTfvHme34OJmnRQAQA
 A
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
also change card_detected between the worker's registration checks and
its media-property update.

Hold irqlock across the interrupt mask update and leave the mask alone
while the card is unstable. Move the transition to stable state into
the locked card sample, and return that sample for both of the worker's
registration decisions. Sample the write-protect and media-type fields
there as well when a present card is not yet registered, so a later IRQ
cannot make registration use properties left over from a previous card.
Keep the properties of an already registered card unchanged.

Keep registration failure from overwriting a newer interrupt's card
state, so the next delayed work invocation can process that change.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204068@kernel.org/
Closes: https://lore.kernel.org/r/sashiko-outbox-204135@kernel.org/
Link: https://lore.kernel.org/r/sashiko-outbox-204169@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Sample media properties with card presence under irqlock.
- Keep registered-card properties unchanged and log the sampled decision.
- Link to v2: https://patch.msgid.link/20261108-submit-r852-card-detect-lock-v1-v2-1-e3251bc3680a@gmail.com

Changes in v2:
- Keep new debounce events pending until the next card-state sample.
- Use one presence sample for the worker's registration decisions.
- Protect the registration-failure update from newer IRQ events.
- Link to v1: https://patch.msgid.link/20261108-submit-r852-card-detect-lock-v1-v1-1-5514e7543209@gmail.com
---
 drivers/mtd/nand/raw/r852.c | 78 ++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..dbee043e6d8d 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -554,18 +554,28 @@ static void r852_engine_disable(struct r852_device *dev)
 }
 
 /*
- * Test if card is present
+ * Sample card presence and the properties needed for registration
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
+	if (present && !dev->card_registered) {
+		dev->readonly = reg & R852_CARD_STA_RO;
+		reg = r852_read_reg(dev, R852_DMA_CAP);
+		dev->sm = (reg & (R852_DMA1 | R852_DMA2)) && (reg & R852_SMBIT);
+	}
 	spin_unlock_irqrestore(&dev->irqlock, flags);
+
+	return present;
 }
 
 /*
@@ -574,8 +584,14 @@ static void r852_card_update_present(struct r852_device *dev)
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
@@ -584,6 +600,8 @@ static void r852_update_card_detect(struct r852_device *dev)
 		R852_CARD_IRQ_REMOVE : R852_CARD_IRQ_INSERT;
 
 	r852_write_reg(dev, R852_CARD_IRQ_ENABLE, card_detect_reg);
+out:
+	spin_unlock_irqrestore(&dev->irqlock, flags);
 }
 
 static ssize_t media_type_show(struct device *sys_dev,
@@ -599,32 +617,6 @@ static ssize_t media_type_show(struct device *sys_dev,
 static DEVICE_ATTR_RO(media_type);
 
 
-/* Detect properties of card in slot */
-static void r852_update_media_status(struct r852_device *dev)
-{
-	uint8_t reg;
-	unsigned long flags;
-	int readonly;
-
-	spin_lock_irqsave(&dev->irqlock, flags);
-	if (!dev->card_detected) {
-		message("card removed");
-		spin_unlock_irqrestore(&dev->irqlock, flags);
-		return ;
-	}
-
-	readonly  = r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_RO;
-	reg = r852_read_reg(dev, R852_DMA_CAP);
-	dev->sm = (reg & (R852_DMA1 | R852_DMA2)) && (reg & R852_SMBIT);
-
-	message("detected %s %s card in slot",
-		dev->sm ? "SmartMedia" : "xD",
-		readonly ? "readonly" : "writeable");
-
-	dev->readonly = readonly;
-	spin_unlock_irqrestore(&dev->irqlock, flags);
-}
-
 /*
  * Register the nand device
  * Called when the card is detected
@@ -632,6 +624,7 @@ static void r852_update_media_status(struct r852_device *dev)
 static int r852_register_nand_device(struct r852_device *dev)
 {
 	struct mtd_info *mtd = nand_to_mtd(dev->chip);
+	unsigned long flags;
 
 	WARN_ON(dev->card_registered);
 
@@ -657,7 +650,10 @@ static int r852_register_nand_device(struct r852_device *dev)
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
 
@@ -684,23 +680,25 @@ static void r852_card_detect_work(struct work_struct *work)
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
 
-	/* Read media properties */
-	r852_update_media_status(dev);
-
 	/* Register the card */
-	if (dev->card_detected)
+	if (present) {
+		message("detected %s %s card in slot",
+			dev->sm ? "SmartMedia" : "xD",
+			dev->readonly ? "readonly" : "writeable");
 		r852_register_nand_device(dev);
-	else
+	} else {
+		message("card removed");
 		r852_unregister_nand_device(dev);
+	}
 exit:
 	r852_update_card_detect(dev);
 }

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-card-detect-lock-v1-713bf5cd926b

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


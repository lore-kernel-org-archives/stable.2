Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177487;
	b=bWq96fzvmapn5YwvUMdRN3RTvzDKNEMB6S/jZb03o7VzwI/z/ZEbjN31cuulAFktPXEr
	 4WubMtDvd71QkQ27ASPmpuTD+r75MYN7yMShnMumXT6BGXoEZ9zkmBckgJY2LnpMMJtxI
	 UyHP+0Spi4XuOyXoPyrFMkkfKC9VbUiqmsMMSV8+/hp0cB1Wk4t2XpajerPxSF7EVMtG9
	 ixVh8URXwO1XO75lJeNJVnsVHk+phnH+xz1mpiIwx6NhhI1xE+bOZPyomRNspIiy9cBbn
	 iRnqmWTfyHvkaLk7fS8lgxMyGTRfS4BL09HFECPZCYKMH649In8M43/KInNXcYhn91g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=4DfEflGZqUk73zomQ6OOIpIEFcB7FUkB70foIaWoQCs=;
	b=yNLGLUiRxifkQAdACx/N/nzWnXvDla+sLJbR6yBtNtKCCfN8y+0H4FVvqr6Bd1+xygye
	 eLbY54nXWUSM8UMpSfNjfW1b4YySJ+wS6tGUsV+LWpDCUQMFm2Jr5WELLjKnyFQtwq/Ae
	 6LuMN0tNhjPWrvQ9mSaaGpLJRWI13lQ0mJFr6b7C0Ki606LXNK9AfZkD3smxpRMAcCew6
	 5kqQGNnANyRTfs0VgQs6cIRwASy0HXmrK33OTibd/PN+ouFAPaNArPlP6qJf9jR7zUpig
	 +iKO/Jh84/WayskgYnVVjdnW4Y6MedMPrhWDR5ZT3Ed1G37TgDdGaqJPPtQqXdFVn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyJrSkLc;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE77606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyJrSkLc
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dde81a6820so177998eaf.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177486; x=1794782286; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4DfEflGZqUk73zomQ6OOIpIEFcB7FUkB70foIaWoQCs=;
        b=oyJrSkLc47jyc1Mq2FpZWQdM9KTFSXm7SyOgIJwgCzEXV8D2U+FcVffuJYFoZ9Ar/k
         ig113A0xnSLVd5P/BvRpvbtdZD0uolDJyRjyN3qZn+8nO+x7b2+SgwiQce+HxFGgH52Z
         EH9EcZPk/J9/qC+X+7Kqe0QIVDnTGHzLs5o0c7UIoekbaz6gv69PVp5XidvJrUX9tCs9
         X+Kybq/8J+JBfcOuFVeJBgp/Hqb+7VnmnxPEdn+t3iHwF23S1Q8AZXAl4CP5SLX8FP+t
         T8jYvmsefjEDqqCNXSKCsoLxCcic1KhKUUYH1m+uNNZi6SaGeMEYGxIVlQmSiZwTkGGe
         eQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177486; x=1794782286;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4DfEflGZqUk73zomQ6OOIpIEFcB7FUkB70foIaWoQCs=;
        b=Z4g4AqFwKknaJSmnXGhO3oJgRct8UBXaae+HRJy5cgZwLS2Y5ZeSNcMRUVvrl9Bf57
         9IWyW/21frcRJpV7odL0fgpSVaX5IdQ57RtJcBLzr5lCVkBqF+piiTM10rQKtL8lIJq8
         /109LHvtbGIpxPcgU/QJPX0x1SAKh3Gw3c8cZ/uJSbnjfT9ahfLJdQNB9OVtYJu7WUqV
         wda02Jekfp4Ur0jCnIE+Fi+2I/43HGTjdWwvPOr4EE6eD2V/fOCHDwNDxOfA3R7Vogow
         BUqmV6YyM2GBM3DXSpKv5m2HCRMMhrEJsCrppPOd3tVuVOlZAV4tgR6omUHMJPyzXUTa
         3+sg==
X-Forwarded-Encrypted: i=1; AL+hErHCR5gnZpf+ertuXumYPkI+ghUrJhr8WenSLBnVam9a6n8dHlGK2VWqaYuJk25zt9rUQkHvzbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KWs67bvdGvSzAxjnEHeXTSV0E/RVDM1PDcuISK/RQ88hP1+EZ
	WLdTv8YB/bhvRoFByU8UKkvkpm8+MnezIklTB64/+6FuP/9TSsGinDQR0S+dBQ==
X-Gm-Gg: AYBFou0fkkIqC36so9RN50emAv5uQ8AHGVGklh7hLFWyIJSxtm4lbem8Ksod1+5hhlD
	9EZd7hsf/zckAcmL5bDPD8JOuFaDVIeRgsSqBbUmdDNhM3ZwVA3DoGSYO6qE8v0bkFsbwv8s7oy
	B6wHT7s2bLaDn7BU3gQBOPfj4eIBngDZULb9MkRTl5ESIbArQN5nePiz/LqPb8ttMaHgDdkX0o+
	WGqGLtdGOzmbRWnSB1ZJ+PK+29yLdSzWDgYw0bCizG/ypf5i20vKP6NQgDUmqzccw6O65jGUgzU
	6BJqXg9zwegEfe8JX+hpXTOOYzdOandoonoiahuPQkqy+SrJBP5hRQtOF5PZ3815ZknJSYOlTjz
	F/GKKcW2V1rOuy8oyCvL9EXH09BktCrNKXkpsjeWiCp3bbyh7eMxTOAaZx7XzhsREUeEvmbAZ+M
	ljgsx71Jt8hFSH4ca/DpcW6SteTgrekklq/dsn56tKR7BOI8tZJz9DndINWqA76grWP63tn13cG
	Ih8dMBtKAmkhRFdA2omDYjQlq8Day3k2WLMDDV3Y2us+uErpmHVgthQMPicHLnvZT9I5ipXf5u7
	5GSknvnRhmm3k8bhUP2/W40/bwdrKeTymgkzgmXzZ8s56i2t1Ibz3ESD+F36jqQabzweWwexIE0
	lrL71RyeeyggrOjzs3oRhTWfZLHlDQmi9pxYYQUQ+Baku+d/KeJAH+bMRw4+OSZOlWqDSG7RJKl
	Jgg5v4Q5lSnMenn6LvsGhzR/m7U7mY1axUg2bPh4CnOC41b//L9wQ=
X-Received: by 2002:a05:6820:858a:20b0:70b:986c:b0bb with SMTP id 006d021491bc7-7170f285402mr919745eaf.39.1794177486181;
        Sun, 08 Nov 2026 14:38:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8cd359sm2111451eaf.8.2026.11.08.14.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:38:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:38:03 -0700
Subject: [PATCH] mtd: rawnand: r852: lock card-detection interrupt updates
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
Message-Id: <20261108-submit-r852-card-detect-lock-v1-v1-1-5514e7543209@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN3Q6CMAyFX4X02kY2A6KvYrzYT5GqDLJNQkJ4d
 zu9afKdnPN1g0SRKcG12iDSwomnIKAOFbjBhAche2HQtW6VqjtMHztyxtg1Gp2JHj1lchnfk3v
 hovCsTrZvnL/o1oJY5kg9r78Pt/ufRfGUSdGWhjWJ0EYT3FCiMftjMEEOrRn2/Qs+xJfbowAAA
 A==
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

Hold irqlock across the register update and the transition to stable card
state. Remove the redundant unlocked card_unstable assignment in the
worker, which could otherwise clear an instability indication recorded
by an interrupt after the helper returns.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204068@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..3ff4294a80dc 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -574,7 +574,11 @@ static void r852_card_update_present(struct r852_device *dev)
  */
 static void r852_update_card_detect(struct r852_device *dev)
 {
-	int card_detect_reg = r852_read_reg(dev, R852_CARD_IRQ_ENABLE);
+	unsigned long flags;
+	int card_detect_reg;
+
+	spin_lock_irqsave(&dev->irqlock, flags);
+	card_detect_reg = r852_read_reg(dev, R852_CARD_IRQ_ENABLE);
 	dev->card_unstable = 0;
 
 	card_detect_reg &= ~(R852_CARD_IRQ_REMOVE | R852_CARD_IRQ_INSERT);
@@ -584,6 +588,7 @@ static void r852_update_card_detect(struct r852_device *dev)
 		R852_CARD_IRQ_REMOVE : R852_CARD_IRQ_INSERT;
 
 	r852_write_reg(dev, R852_CARD_IRQ_ENABLE, card_detect_reg);
+	spin_unlock_irqrestore(&dev->irqlock, flags);
 }
 
 static ssize_t media_type_show(struct device *sys_dev,
@@ -687,7 +692,6 @@ static void r852_card_detect_work(struct work_struct *work)
 
 	r852_card_update_present(dev);
 	r852_update_card_detect(dev);
-	dev->card_unstable = 0;
 
 	/* False alarm */
 	if (dev->card_detected == dev->card_registered)

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-card-detect-lock-v1-713bf5cd926b

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


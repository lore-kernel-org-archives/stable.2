Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179630;
	b=f85MSEjrynvr1Gym4h/kwk6WOOMcthuyDtHZUDAaEO7YXaXUcRZ6/5kH+642JX8x5teK
	 4fZ7pcp9pPm4zk+Il3FIDUGKFc5i1L+ToHgZuBlyRW41M99hLZFNhUkEcTDiFlnCUeW61
	 HGJmpem+PtmXYbMbYnpi8CnIAGRcIkmv+gOaf+4OiJBKuZa65nzizjpE4W9qSxAegPKWk
	 Ip9KeMRcLDuKBy8bLxinElg75enRpcFxD5b/SlE7tj/8HDBkbewp4tFw+Jm4xsOo14xgL
	 CyRDTEbKYIhiPbyqBWcOAQV1EQeH9OSCm3nLR67CEgFeHJKDHjGqw0U9NL7uFjHkdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=zMgYc/LH+39KF5WFc6nQc4tMwI5XGyz5B8atapOp6WM=;
	b=r1V2iJMq5UPUB/mrilVyBn/G5gwtYOXmVOqPiQSxA2ebK5EIxc/LnNlUg3/zQmwOaWWP
	 Lvyq4zjsrCcf/9kMlqrw8nMCh728HCGSb3RZRqbl6+UdMekTp7p8sHSXP5iOTxOkOOUBB
	 GRGyJruQ57gdRhmcmgRpWsRV5algs9hZWdd/MF68RITd5Cx/z0G0QmplbonZXWTx018WQ
	 z1a2YHkh7ev+2yDbCg7bnzmohkwi+rehV/xSgOLQiPjgUpV0TU/ZDNXCQRrEnRpdim/Yq
	 3lJAUKx3hZb1791+wl3Nfm4IOzy8hJKvWy1727QIqQH1SSYWu8FZprrPrT1N++S4AeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YnTJ+NG;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042D606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F042D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YnTJ+NG
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4ada9579947so186452fac.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794179629; x=1794784429; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zMgYc/LH+39KF5WFc6nQc4tMwI5XGyz5B8atapOp6WM=;
        b=0YnTJ+NGoYYfwqwHCU/2Fo53n/qkTo+8HCto1hz2LUHsWf5p24who7ozVUXgOIF7V6
         yj6LM0854P/R92H5MCv7OupWp5O1cY1xBVoUOwc4znGbZP9Fg4h1pi+k5uI87TOSC1Sw
         2aSeZezpsz3+wZFIZopxZsVkWX6pR8a8SgYHcoduBEJTK4ofZkgx5AvtCtQY/UYkReWX
         ZQEs76G/1jAbfZHS/YiLC/Qq8XqntfsYmmJVzheadPsK9n4b9qxrlMWqFgnHqrzoecGc
         rJuittxi2QlZzG+PadHm2nuxB9TpAecNYXthLcGwwRIIOiU9i8Ue3DaXTT5euHE99xv1
         tkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794179629; x=1794784429;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zMgYc/LH+39KF5WFc6nQc4tMwI5XGyz5B8atapOp6WM=;
        b=hMgI87nLaY9PSfyD6vEbWlLhYrjpNnIesAs5vXcQb9SrDecRMJRULQWWEtEqcxjpzZ
         NQEMz1VygEJT/wU9cmtRvrZOp+2bsU+lGA7E6XoL8h23sdqUBmYCNTnX9C9qROsN3VY/
         oypLwsrn8Oqf8cWiotFhR61xU/Iv0QboLACde5JwAxzAbqoc6iDV86qKNMK1QWDvFPEl
         KMYegopzyJDCuifh/KOEA/YCYnY6f5vTeZ7U8sSpQFXZT6qSxmj8kYnk784U2V7FGsLQ
         KZdYQHC4Fmbqc7dKsAhmuyklufu/NW1qmqs103pJE6oD71CJnsL2Od1UtVsyLUxByrlK
         mfeg==
X-Forwarded-Encrypted: i=1; AL+hErFdRg7qpJHmB0XfAVidv+1eVsMGY7cntnMAHk8p8+h6607c9ONwhe5gWutdqSBflE6XHPggGWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z80dqUJi7xWGu52Z1ypu5DZFPoLTjDa/u/xc1nbIukBLYubxCqH
	XszCLRmV6OZRBniVr4JmYoSYWnIyIFpxZty78kTNCjMMq0yRFD1d+hjb
X-Gm-Gg: AYBFou2J9GRVXBgLjejhOcawif9+EJ5IsbDaYjrn0uWgw5XYTYrhGTfB3NbyaPwywJV
	oyRJ0ESv4cORnzMixuCIn0Np4hhVFk5uJWgztCLnFpQiYjqsPyO+54nlVbnbFRXaNHN2h93IATX
	y77l7b/hm5DWPtlql8w1lw+6BDeYfAopHG8neT5ND0VlSA/GmV7Bh9p6K3z1CY6EWWK+CwNerAK
	1rsqaj6713Len1c8XBXlrwFYMvgGroEDNOeqQeLCPHj9ivtEMHHzeK6tuoiozOmKwpjt+NTTre7
	GD+ZZmrz26k5gQseLDbZ/eFU1v8/eYX6x1MfPTocPGx63OkAG63zP2eS4xWiof2lOUaKJmAe+8/
	OeEzBdp5wvU/ye7JE7lFqdax7ugeQXqeIn+KsFJA3awvAPko3kSCVzjLktIAciTGbvaHp6miK/p
	YfLosOyqNNRktbSpK0MFMrVxqsyU9hoGhK6AqZBR0GgAFev8PyqcNtT9Y7vI1m8QJCkeAkGyYM3
	spszTor+fJNbRJYm/KWpVdFv06B2rCwET2MahCpeUoDTn/LrZcp0x8AGvrOlMtX52QxnxuD4M0L
	Vg6IQoKYMmvohxjJVbMNUqBR7T2W2UZBl4NuTy5cQBmtIi/sIpHrCkT/g0zxev96OdX9T46zVo3
	y8LD07ajSLYfQd0vDF8i+JwMEX3qjB2Ui26YNb0687vOUFjkDN0+hiJVDj9/+Jv8NvSADR2W5Ty
	ixhFv1pRn+EGwKXBQBYpmtbRbsxutOnLe6APUk9eY6WyNrpgsCFHhdfE/SoK9Oa019TraggdMT
X-Received: by 2002:a05:6870:c26d:b0:4a6:f6e2:690 with SMTP id 586e51a60fabf-4adec9a3f30mr1367311fac.22.1794179628828;
        Sun, 08 Nov 2026 15:13:48 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade647f24esm3362985fac.1.2026.11.08.15.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:13:48 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 16:13:40 -0700
Subject: [PATCH] mtd: rawnand: r852: serialize DMA timeout cleanup with
 interrupts
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
Message-Id: <20261108-submit-r852-dma-timeout-race-v1-v1-1-6b24c6368de6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQqDMBBEf0X23KUmoNj+Sulhk2zrFhJLEkUQ/
 921vQy8YXizQeEsXODebJB5kSJTUjCXBvxI6c0oQRlsa3tj2gHL7KJUzENnMUTCKpGnWQvyjIv
 Bm7NdH3QePINavplfsv4eHs8/q+LDvp7ac+GoMLpMyY9nFWu4JkoavFbY9wPzHP/uowAAAA==
X-Change-ID: 20261108-submit-r852-dma-timeout-race-v1-9b256d202dce
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

r852_do_dma() calls r852_dma_done() without irqlock when its completion
wait times out. A completion interrupt can finish the same transfer and
unmap its buffer before, or concurrently with, the timeout cleanup. The
second cleanup then unmaps the buffer again and overwrites the result.

Take irqlock after the wait and abort only if the DMA stage is still
active. If the interrupt completed first, retain its result and copy
successful bounced reads back to the caller even when the wait expired.

Publish the active transfer state under the same lock after preparing
its buffer, and clear pending DMA status before starting it. Ignore
interrupts for an idle transfer, including error interrupts, so they
cannot release an already completed mapping or signal a new completion.

Use the active stage to determine mapping ownership and clear the saved
address after teardown. A streaming mapping at DMA address zero must
also be unmapped; only the persistent coherent bounce buffer is exempt.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204135@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..12877dd14683 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/delay.h>
@@ -124,11 +125,11 @@ static void r852_dma_enable(struct r852_device *dev)
 }
 
 /*
- * Disable dma, called from the interrupt handler, which specifies
- * success of the operation via 'error' argument
+ * Disable DMA under irqlock and record the result of the active transfer.
  */
 static void r852_dma_done(struct r852_device *dev, int error)
 {
+	lockdep_assert_held(&dev->irqlock);
 	WARN_ON(dev->dma_stage == 0);
 
 	r852_write_reg_dword(dev, R852_DMA_IRQ_STA,
@@ -145,10 +146,11 @@ static void r852_dma_done(struct r852_device *dev, int error)
 	dev->dma_error = error;
 	dev->dma_stage = 0;
 
-	if (dev->phys_dma_addr && dev->phys_dma_addr != dev->phys_bounce_buffer)
+	if (dev->phys_dma_addr != dev->phys_bounce_buffer)
 		dma_unmap_single(&dev->pci_dev->dev, dev->phys_dma_addr,
 			R852_DMA_LEN,
 			dev->dma_dir ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	dev->phys_dma_addr = 0;
 }
 
 /*
@@ -175,19 +177,8 @@ static void r852_do_dma(struct r852_device *dev, uint8_t *buf, int do_read)
 	unsigned long flags;
 	int error;
 
-	dev->dma_error = 0;
-
-	/* Set dma direction */
-	dev->dma_dir = do_read;
-	dev->dma_stage = 1;
-	reinit_completion(&dev->dma_done);
-
 	dbg_verbose("doing dma %s ", do_read ? "read" : "write");
 
-	/* Set initial dma state: for reading first fill on board buffer,
-	  from device, for writes first fill the buffer  from memory*/
-	dev->dma_state = do_read ? DMA_INTERNAL : DMA_MEMORY;
-
 	/* if incoming buffer is not page aligned, we should do bounce */
 	if ((unsigned long)buf & (R852_DMA_LEN-1))
 		bounce = 1;
@@ -209,16 +200,26 @@ static void r852_do_dma(struct r852_device *dev, uint8_t *buf, int do_read)
 
 	/* Enable DMA */
 	spin_lock_irqsave(&dev->irqlock, flags);
+	r852_write_reg_dword(dev, R852_DMA_IRQ_STA, R852_DMA_IRQ_MASK);
+	dev->dma_error = 0;
+	dev->dma_dir = do_read;
+	dev->dma_stage = 1;
+	dev->dma_state = do_read ? DMA_INTERNAL : DMA_MEMORY;
+	reinit_completion(&dev->dma_done);
 	r852_dma_enable(dev);
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
 	/* Wait till complete */
 	error = r852_dma_wait(dev);
 
-	if (error) {
+	spin_lock_irqsave(&dev->irqlock, flags);
+	if (error && dev->dma_stage)
 		r852_dma_done(dev, error);
+	error = dev->dma_error;
+	spin_unlock_irqrestore(&dev->irqlock, flags);
+
+	if (error)
 		return;
-	}
 
 	if (do_read && bounce)
 		memcpy((void *)buf, dev->bounce_buffer, R852_DMA_LEN);
@@ -766,6 +767,10 @@ static irqreturn_t r852_irq(int irq, void *data)
 
 		ret = IRQ_HANDLED;
 
+		/* Ignore late interrupts after a timeout. */
+		if (dev->dma_stage == 0)
+			goto out;
+
 		if (dma_status & R852_DMA_IRQ_ERROR) {
 			dbg("received dma error IRQ");
 			r852_dma_done(dev, -EIO);
@@ -773,12 +778,6 @@ static irqreturn_t r852_irq(int irq, void *data)
 			goto out;
 		}
 
-		/* received DMA interrupt out of nowhere? */
-		WARN_ON_ONCE(dev->dma_stage == 0);
-
-		if (dev->dma_stage == 0)
-			goto out;
-
 		/* done device access */
 		if (dev->dma_state == DMA_INTERNAL &&
 				(dma_status & R852_DMA_IRQ_INTERNAL)) {

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-dma-timeout-race-v1-9b256d202dce

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


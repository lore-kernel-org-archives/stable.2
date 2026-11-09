Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187770;
	b=HvcuHeMAfhJcZQWDh7Gz9AR6krb6s6a8aFn2TGpXSV3dQUK0cP8ReohJfV5gReaCcb3s
	 6lxmzlkf7fSvFaMYQBHxKTtniq2drNxa21hdRndMYM83nl143E6V5/N4ETdBOvvF+PuFB
	 UM8eIyHZcDt2LgNk97LYXvy7YHrZ9PqfKcnAvH2RQWNH/ZyGpKmVClRvYH0/qAm6HW2HT
	 dsTTKtnCFuDdndKuGpVFhmw9W22FMOTIdAPM+nfpSlC3NcCSdF10SyGik52QtuYKpxPXZ
	 7gRxDVJ5sLgYcqRgOu8PKXi0icaqC4mLE0bKdtsgCgLPwgf/tYzXxTweOvNRP4DwA2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tHxPvkIQbIOFnf0PNycsyarZgqZPtDrXH02YRkVpewI=;
	b=pC/HLSaGzrzESJtrHHKuntk3mGcSyPfAnb7Xx3CPoCNSnE4eotZDZS6rXy0A6WkjRUzj
	 vnI6C1+nnEorDw/BUBvOC8W2YNpoxLGvwFXL00aYH+9Qj1aPhL3Skv/qS0yz6PXJPQJgc
	 B9v1Nw3pdeK1DctM8uCts/Q2RzuBLSnk+gjOgvtZrsaXdeGAcNq83jC8UQt5yViCRl8Ai
	 UUjoP3j8kuX7kDOoIcb7w2P+z+vfNEEfbwB0QEP3OVkuxSGDFy7VP2aBHM4wrTgOZdooo
	 LhtBYX52CK3SnOT0xKvqkN0YMCttdx2Jb5Y2FDmZIxYQdUKZlt9G/zI2B60XiftNe6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5lteWku;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CD606A787
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222CD606A787
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5lteWku
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f699fe49b3so288965b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 17:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187769; x=1794792569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHxPvkIQbIOFnf0PNycsyarZgqZPtDrXH02YRkVpewI=;
        b=g5lteWkumMsr/8XsXavjTdQzmzgC5aS1al4O8shgS7/SYpYcLeGONud4P5rJGDkpfr
         KdiBiLgo/fmyLZC5XkGfvG97iRgJTnLeyJ+F8vzO9A0yQOcWQby81jFjQPE7ROv9xIQe
         scPpmdhIDTqyt3wB3TJFcyQ5QWA+GTK8yrPIP0xSfoGq6F51v4GmxRKxeRZjdohCAb8o
         ycDs/GlmiteaIr+YegKNB/dnMrXtyIKmQcoQDEkmOIgLCvF6sGyEY6lIO6uBg2Ce0rSU
         f/JfdZOhkgGG+FQG9eiFz4v+qfz9kRhnRy/d2D5W5+m1u6HOgq8ZsvVQgwIplFRXYT7D
         wgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187769; x=1794792569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHxPvkIQbIOFnf0PNycsyarZgqZPtDrXH02YRkVpewI=;
        b=dLJwlG6UsM+hJmHerXZZ4W4VL950ArGQ1C5omNKNeZ6VAb8G5qNBmUCkVWolAm3pgk
         72wdl1E8V/nXd1axwkMSSVcFYinUVQGlbUbOuqNlUPAd7rFdK7qVE4V8yQxbNz2tFcsV
         aqRYM25wIz+9L2vfcubMqCcQrZaz6Bhwk+a9tuHU0Ht9QfG9BrWP4kik0SCU6DJDQEFF
         iajgYKfQFEvGBknFvbYoYzRsAfKtaa5FQzEA81jNcQAEflDGd6y3s9HFVM1VGyokzAay
         yGDpKuEOWOl3c9AhpGLPyZiQJoM0t3O4XudHL3iYEsmaX6miwMFeiwjX1utnghLH/NfW
         t21A==
X-Forwarded-Encrypted: i=1; AL+hErGnYtqMaXIsho1DspNkn0aPQ6NDrPffnvWvIyJZ6AITpQCeXKbZdkIlULfewc/HQGn1IJtrIz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0B1AdwYRT0l749V/n86fuYw9MD5tIoToRXKa3eC14neQTY5wj
	Fb4msFT06XMXgo7pg/gvJlrsPpP34T53tCx56GvRcCONCdaDASC/GOHY
X-Gm-Gg: AYBFou3kvdxwcOr7pkFHbfbP4QyDn2IfCl8h7xF8WX54xYRG74ebQ0u2/YNJC5NfpjI
	dtEhySpNvRD//W2bNRkGsTsMWSd7+ShD2NAz/xiWajviHiS4uia0cJynMojW9CXDltZ/DKonl7V
	7S47EQkzL9CvvtOQilv3rhELlOZwJ/lzYCeKxgN7MX3lfOjwuIHTzVLiHpp5UQtvSsRwgPWc4A8
	FQzMHBKtXNEvubGmcG4ghr2K4ggm+nDLjG8F/z9R5UceHgqmQCt0WCIMc1I8OIdnbiusCVA1jO2
	VyhtEdVe/mpH92mjBxRq17Nlt2tXOPfYld7lbB0iKaMIJaQaMySg6V2rWJdR8PjVxTEFcqEBKDn
	o1H5PJhY/bmHsCIb2Y5U+b7KeuMjL3b0PL3O067WsKVp4sDeVf/5rziRL4bGRed71aqCZ1uT20w
	LA3BsVf18LClAqVbe14Qh89j89gUjm/3J1SqDUzPPFeAdM2RPR74cF0CIfs+HY28AZww484aEwm
	5dTAsbNlI31k1jK7gCyBBIthWiWiFGHzBFedj/v5kah+LPJYLqOO3JH1274lVXmda4/nne5/wQk
	2Bz+PD5T8ZCEGzCDthdFDcYK7YKmJgp9qmOjXzuVxpA9m7rrG+HAUeRG2KQtYFxhwcoHYH9+5Uc
	ZJfH2afPC6zHXZmDjLRVSZjSFpmnOnwopu2cRTKvXo04xoQR8E5y6Pbs+LMs3AzW4EzPZXNbOpI
	VijknADQJ2+nHiO/sdjmt1MlpxYVkSp8p+Fu44cpPwbor4iJZ641CaDGjcVmqm1ujOxPw9pC7Tf
	g==
X-Received: by 2002:a05:6808:538a:b0:4bc:cf33:7024 with SMTP id 5614622812f47-568143c75b4mr1962246b6e.42.1794187769024;
        Sun, 08 Nov 2026 17:29:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm4225818fac.10.2026.11.08.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:29:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 18:29:21 -0700
Subject: [PATCH 2/4] mtd: rawnand: sm_common: avoid recursive locking when
 marking bad blocks
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
Message-Id: <20261108-submit-r852-smartmedia-attach-v1-v1-2-56d08c0571a2@gmail.com>
References: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
In-Reply-To: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

nand_block_markbad_lowlevel() holds the NAND chip and controller locks
when it invokes the legacy block_markbad callback. sm_block_markbad()
calls mtd_write_oob(), which re-enters nand_write_oob() and waits for the
same locks, deadlocking the bad-block marking operation.

Write the marker through the chip's OOB callback under the existing locks.
Keep the reset, target selection, write-protection check and page-cache
invalidation performed by the OOB write path, including the broken-xD
write-protection exception. Preserve the 0x0f marker and fill the rest of
the OOB with 0xff.

Use the OOB callback's return value directly. This also avoids comparing
an 8-byte OOB write on 256-byte-page cards against the 16-byte sector OOB
size and incorrectly reporting a successful write as an error.

Fixes: 5a0edb251ae9 ("mtd: nand: refactor chip->block_markbad interface")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sm_common.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index a3a3a05cc5a4..a6387111d271 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -100,30 +100,38 @@ static const struct mtd_ooblayout_ops oob_sm_small_ops = {
 static int sm_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct mtd_oob_ops ops = { };
-	struct sm_oob oob;
+	int chipnr = ofs >> chip->chip_shift;
+	int page = ofs >> chip->page_shift;
+	u8 status;
 	int ret;
 
-	memset(&oob, -1, SM_OOB_SIZE);
-	oob.block_status = 0x0F;
+	ret = nand_reset(chip, chipnr);
+	if (ret)
+		return ret;
 
-	/* As long as this function is called on erase block boundaries
-		it will work correctly for 256 byte nand */
-	ops.mode = MTD_OPS_PLACE_OOB;
-	ops.ooboffs = 0;
-	ops.ooblen = mtd->oobsize;
-	ops.oobbuf = (void *)&oob;
-	ops.datbuf = NULL;
+	nand_select_target(chip, chipnr);
+	if (!(chip->options & NAND_BROKEN_XD) &&
+	    !chip->controller->controller_wp) {
+		ret = nand_status_op(chip, &status);
+		if (ret)
+			goto out;
+		if (!(status & NAND_STATUS_WP)) {
+			ret = -EROFS;
+			goto out;
+		}
+	}
 
+	if (page == chip->pagecache.page)
+		chip->pagecache.page = -1;
 
-	ret = mtd_write_oob(mtd, ofs, &ops);
-	if (ret < 0 || ops.oobretlen != SM_OOB_SIZE) {
-		pr_notice("sm_common: can't mark sector at %i as bad\n",
-			  (int)ofs);
-		return -EIO;
-	}
+	memset(chip->oob_poi, 0xff, mtd->oobsize);
+	chip->oob_poi[chip->badblockpos] = 0x0f;
 
-	return 0;
+	/* The NAND core already holds the chip and controller locks. */
+	ret = chip->ecc.write_oob(chip, page & chip->pagemask);
+out:
+	nand_deselect_target(chip);
+	return ret;
 }
 
 static struct nand_flash_dev nand_smartmedia_flash_ids[] = {

-- 
2.53.0


Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FEA46A5E1
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248353; cv=none; b=q/8elvnTr0OFFQD+4pDB29v2CEcu9Vd5wTgOGVxK+gHSRI2QrBXb2IZhktmGWr1izGt2IH5mOFQc6MkX04wg8Be3je5QPSNQxOcktFNSGvc6LFDFyyM5X5thUDaJS0MeqndCL/Q/Fd29HeAz0DRXLuToipVDkFuJrwp77/dHXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248353; c=relaxed/simple;
	bh=a7PHJfV4gzPGGi3SCSdAAcB12zNvMgt2S88ZttemUkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSB2ahVK8NI7D0YP6h0KDpIVJxULCxxjnBJyGJr+vpYl/OZmCNdPNlzK1LUHTH8Fe3l9ZK7FSCjafV8yTKnwpVJpDz/ocLFp54mlAvwDM4tUJDgVXY8dzLBzoFpn9FRBSSIziCjyVXMCnvjIYlLkPuTaWSmu7cuJ3eFPpj3Do4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKDRY70U; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKDRY70U"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2796542f8f.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788248350; x=1788853150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxuNHMnlajHVgcX65Arb3FqrfAoHreh7iYiEvJueLq4=;
        b=GKDRY70U/ZcRIWg/b4YmkePdkoIeXhVept6FkMFKzY5nlxvR4K/FQLWNE7gIUar7rk
         CNJweCp4pAC2b5w5xl/te1nx7vyxCjTO6dfPfLkoNhHWWrtadaMbhKoz0tH8TL5v87U+
         SZ7L6Esj4oL1g5f5oVf/OvLiQ68BYutZp1pMTEgnbNG39LWyvz5V4i+F56OcUitYpsZJ
         lWbB1TuQzXAes/a3tP+14fTaE4yFMIo5O1WAF3/9iMTTMU1vDCXOxAmmYNs5m0/i+vT7
         /MmM24wSvVKcMMVQTSCjr9J72hZlXiY6ZEiwLUMRZMRreQR6w2h+iWuPbXaahdhTfZnb
         4Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248350; x=1788853150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxuNHMnlajHVgcX65Arb3FqrfAoHreh7iYiEvJueLq4=;
        b=UtwqQJVwvWc1OYCPMCibznhW4I9WPFlvwYxJddvBS+MK3hgX7PwINZ6tVMIt0YReuS
         P3tOfKXbMwkMJmg+gbiThtBdWUgQS5g7Tu6ZPSE4f9NRvx/RrE9h0Dfa3Zs0TdYMyRA3
         CSgqqQEuvBJ9BwbiYFdkegr4iYQBYh6xNFi6UeD7FsqDzVe4kQKfG19e3b7iWFhnKNPy
         wrbLm/AT7Ox9sbltun932KbCpOZ0NHNrofU9Z/wSqrqOCmPD05m6v2hMXutXIXiqdpjz
         aaL2cSiFxlKbvOHR3l3lShGoWbqkYVE3y5yqDij0D7ywd5zDafuRT3Pku4W563qcLOZa
         oinw==
X-Forwarded-Encrypted: i=1; AKwUvBw8Z84nStjGB3nuJPaa9kFKPDPs4r3B7e8zlJI1FMSDdsxd6LcFPs0hXRVkPKSFbwHsLCXaMno=@vger.kernel.org
X-Gm-Message-State: AFuF++keTayuuTcc7eIO+iyoDpI7AF77luwucqfFhJqVZx7Xggj7LMPK
	BcMlt2vWrKOJunawWVduhcwEG4ULFR4dUdnCL8LAI1MJXndYHPHPW1Ab
X-Gm-Gg: AYBFou10FcD+l3n7Fn64XnG+5JrgZZX5NklA7W+xSCy0DWHJwRccc9WKqLN3G3by3GN
	f42PWdaLCP5DSiaqqc1tROfOftcQCCR/OoimrOLc0+9wLwyPLXW0wnougn/cIr7hDrV3REJreYd
	6wkDB4be00+YLuCh2SI3nMxARBa93eL4L7I7qgt6yTxi0pV6q76BMbjgzJx3cNFLN2e16J8z0Fv
	cz0KdV4xlB0Nx3PaWciRj92Gt0y1GXio7RS0z3fGfgdvhRJQFJFYKAlHCue4sRE081mZoUVj4Om
	Y4CxvqM0TBrtDGi7qyuATgLsVi7iLBQA5/BIoEBCKXLC0N6sib7BY0f7Ta+5C4UAslxTlC9tB3K
	aL0N7RmbLbqb4SSpksJz+soLKRmHfWTnLXp1Tt4MTro0EGMHGwDBZJiZcl+7GaXfAJNbIlhphGe
	M5nU/j55NJVew/DJHZxecqAROCunzTjrJD19MYRM+xzn9jEn6ZSPXiVPB0H0XO5WbcOw==
X-Received: by 2002:a05:6000:27c6:b0:482:f270:65c5 with SMTP id ffacd0b85a97d-48440fe3214mr8435228f8f.9.1788248349726;
        Tue, 01 Sep 2026 00:39:09 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3c460sm3014790f8f.13.2026.09.01.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:39:09 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stefan Agner <stefan@agner.ch>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Edward Karpicz <webmaster@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB
Date: Tue,  1 Sep 2026 09:39:06 +0200
Message-ID: <20260901073907.2443698-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901073907.2443698-1-mehmet.fide@gmail.com>
References: <20260901073907.2443698-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The controller transfers 64 spare bytes per page and the driver only
implements the matching 64-byte ECC layout, so attach_chip() shrinks
mtd->oobsize when the chip provides more. That clamp does not survive:
nand_scan_tail() runs nanddev_init() after ->attach_chip(), and it
restores mtd->oobsize from the memory organization, which still holds
the value detected from the chip. The driver then transfers writesize
plus the chip's full OOB size, the hardware ECC parity ends up at a
different offset than the layout the controller was set up for, and
every ECC-protected read fails with -EBADMSG.

Measured on a Colibri VF61 (MX30LF4G28AC, 2048-byte pages, 112 bytes of
OOB): with the clamp lost, UBI cannot read the erase counter headers of
the pages U-Boot has just written, and the on-flash bad block table
written by an older kernel reads back with ECC errors, so the board
does not boot. Kernels before commit a7ab085d7c16 ("mtd: rawnand:
Initialize the nand_device object") are not affected because nothing
overwrote the clamp there, which is why the same chip works with a v4.4
kernel and with U-Boot, whose copy of this driver has no memory
organization to restore the value from. Edward Karpicz reported that
the clamp no longer takes effect on this chip; see the link below.

Instead of modifying the memory organization, keep the detected OOB
size and give the driver its own mtd_ooblayout_ops: the same layout the
NAND core uses for large pages, but computed on the first 64 OOB bytes
instead of the whole OOB, so the ECC bytes stay where U-Boot and the
old kernels put them. The data paths transfer writesize plus those 64
bytes, as the controller always has.

Since mtd->oobsize now reports the chip's real spare size, fill the
tail of oob_poi with 0xff after the 64 transferred bytes on ECC page
reads: the core may copy the full mtd->oobsize from it, which would
otherwise expose whatever the buffer held before. 0xff also matches
what a raw read returns from flash, since the write path only ever
programs the first 64 spare bytes.

Reported-by: Edward Karpicz <webmaster@toradex.com>
Link: https://community.toradex.com/t/colibri-vf50-vf61-on-the-current-bsp-mainline-u-boot-v2026-07-and-linux-6-18-lts/30735
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
v3:
 - add Suggested-by (Miquel)
 - drop the comment above vf610_nfc_spare_size() and its explicit
   inline (Miquel); the 64 is the established on-flash format, not a
   controller limit
 - explain at the ooblayout why the driver has its own, in the terms
   Miquel suggested
 - fill the tail of oob_poi with 0xff on ECC page reads so the bytes
   beyond the 64 transferred cannot expose stale buffer content
   (Sashiko report)
v2:
 - keep the detected OOB size and add driver ooblayout_ops computed on
   the first 64 OOB bytes instead of clamping the memory organization
   (Miquel)

 drivers/mtd/nand/raw/vf610_nfc.c | 72 ++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 9940681810cf..1c3e7b167e53 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -505,6 +505,11 @@ static int vf610_nfc_exec_op(struct nand_chip *chip,
 				      check_only);
 }
 
+static unsigned int vf610_nfc_spare_size(struct mtd_info *mtd)
+{
+	return min_t(unsigned int, mtd->oobsize, 64);
+}
+
 static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 					 uint8_t *oob, int page)
 {
@@ -522,7 +527,7 @@ static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 		return ecc_count;
 
 	nfc->data_access = true;
-	nand_read_oob_op(&nfc->chip, page, 0, oob, mtd->oobsize);
+	nand_read_oob_op(&nfc->chip, page, 0, oob, vf610_nfc_spare_size(mtd));
 	nfc->data_access = false;
 
 	/*
@@ -530,7 +535,7 @@ static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 	 * at least less then half of the ECC strength.
 	 */
 	return nand_check_erased_ecc_chunk(dat, nfc->chip.ecc.size, oob,
-					   mtd->oobsize, NULL, 0,
+					   vf610_nfc_spare_size(mtd), NULL, 0,
 					   flips_threshold);
 }
 
@@ -551,7 +556,7 @@ static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
 {
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	int trfr_sz = mtd->writesize + mtd->oobsize;
+	int trfr_sz = mtd->writesize + vf610_nfc_spare_size(mtd);
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	int stat;
 
@@ -577,11 +582,16 @@ static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
 	 */
 	vf610_nfc_rd_from_sram(buf, nfc->regs + NFC_MAIN_AREA(0),
 			       mtd->writesize, false);
-	if (oob_required)
+	if (oob_required) {
+		unsigned int spare = vf610_nfc_spare_size(mtd);
+
 		vf610_nfc_rd_from_sram(chip->oob_poi,
 				       nfc->regs + NFC_MAIN_AREA(0) +
 						   mtd->writesize,
-				       mtd->oobsize, false);
+				       spare, false);
+		/* Not transferred, and never written: reads back erased */
+		memset(chip->oob_poi + spare, 0xff, mtd->oobsize - spare);
+	}
 
 	stat = vf610_nfc_correct_data(chip, buf, chip->oob_poi, page);
 
@@ -599,7 +609,7 @@ static int vf610_nfc_write_page(struct nand_chip *chip, const uint8_t *buf,
 {
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	int trfr_sz = mtd->writesize + mtd->oobsize;
+	int trfr_sz = mtd->writesize + vf610_nfc_spare_size(mtd);
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	u8 status;
 	int ret;
@@ -740,6 +750,49 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
 	}
 }
 
+/*
+ * With 64 byte OOB chips the core's large page layout matches what
+ * U-Boot uses, and on chips with more, U-Boot and older kernels clamped
+ * mtd->oobsize to 64. Modifying the OOB size is no longer possible, the
+ * actual chip geometry must be respected, so to avoid breaking those
+ * existing setups use our own layout: the core's large page one,
+ * computed over the first 64 spare bytes only.
+ */
+static int vf610_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	unsigned int total_ecc_bytes = nand->ecc.ctx.total;
+
+	if (section || !total_ecc_bytes)
+		return -ERANGE;
+
+	oobregion->length = total_ecc_bytes;
+	oobregion->offset = vf610_nfc_spare_size(mtd) - oobregion->length;
+
+	return 0;
+}
+
+static int vf610_nfc_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	unsigned int total_ecc_bytes = nand->ecc.ctx.total;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = vf610_nfc_spare_size(mtd) - total_ecc_bytes - 2;
+	oobregion->offset = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops vf610_nfc_ooblayout_ops = {
+	.ecc = vf610_nfc_ooblayout_ecc,
+	.free = vf610_nfc_ooblayout_free,
+};
+
 static int vf610_nfc_attach_chip(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -770,12 +823,7 @@ static int vf610_nfc_attach_chip(struct nand_chip *chip)
 		return -ENXIO;
 	}
 
-	/* Only 64 byte ECC layouts known */
-	if (mtd->oobsize > 64)
-		mtd->oobsize = 64;
-
-	/* Use default large page ECC layout defined in NAND core */
-	mtd_set_ooblayout(mtd, nand_get_large_page_ooblayout());
+	mtd_set_ooblayout(mtd, &vf610_nfc_ooblayout_ops);
 	if (chip->ecc.strength == 32) {
 		nfc->ecc_mode = ECC_60_BYTE;
 		chip->ecc.bytes = 60;
-- 
2.54.0


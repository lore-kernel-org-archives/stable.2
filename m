Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5F4DC531;
	Thu, 23 Jul 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814081; cv=none; b=kdrKUhysw95ddFteBbYQw2sDwrY62GMehzioB6Qa9f/rni7bmBescmtbWMmqNoxP6J9QlDBFh/btQ0ciIPN+UZwaixxRsdZv1t+sCG4NbNV7vvBTWVPI0n9ivhb3trGtpENg/voy0yg+QlD6oIjhOO5NsDsdlfZy7foDzoWMuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814081; c=relaxed/simple;
	bh=+ZpNRgtNyM8AlOTByDEba4TlFxSsdjZtHp5TUaFZTw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbM5qVaJL4xbLD29lP/L6ooyCTuv2H2YC1FXo6teqPwHSFIjGH/3WLVZ9Upzg9OfcdqcXaf30Vh1d/3kUk+ySmhHcgH9Ofx2CzvbuZdcCVZ/bTO5nL/iF0AwJvFhXJ2egf4OztdbPMsrebB2f5bJv0Zw/ne1VFHYbWJzHFSU9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m9E44m3K; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m9E44m3K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CA6E1A11AE;
	Thu, 23 Jul 2026 13:41:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E5C9A602B8;
	Thu, 23 Jul 2026 13:41:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EDB811C10E94;
	Thu, 23 Jul 2026 15:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784814071; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1eHXfQkOUwlUyzpIRf3Q6Ks/P8/PZJUj2954tWi5/2I=;
	b=m9E44m3K1WKZJotwZr0wBKIqS/t+w7V9CNZtQaXteLc3HjC+DyrH5LAkOsVcCMjiAwFXEr
	NN814MD0qXDkXQ6rnT2RUWPf3sEIzOuOz/DjjNEqnkHfNc/+ZdOpoNMnfrc7VvOWWvctEq
	QDJS9H2ThOII8fDCVvnfUIHTrANHawm7sD9AUzsDpn4J+7r8O/cyvmY+/lDyxQu4Xpky5l
	3ElRhCQfRo9kcD7Dt6eLPb0oorOUMNTz3mNF5oqAkQuSVbToguOnvLKVgxTgcUMWRK0qeT
	2c8lxgz64yvxixVEHD6ZaG3FXmZ2pVQOxvQsH19whTS8biPtX5vglBirz2aU/Q==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 23 Jul 2026 15:41:04 +0200
Subject: [PATCH 4/4] rawnand: pl35x: Implement mixed ECC computing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-mix-ecc-v1-4-7361c3baeb07@bootlin.com>
References: <20260723-mix-ecc-v1-0-7361c3baeb07@bootlin.com>
In-Reply-To: <20260723-mix-ecc-v1-0-7361c3baeb07@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The PL353's HW-ECC engine is broken and fails to report some errors
on reading (cf errata 721059 in [1]) so hardware reads can't be trusted.

Implement a mixed approach to do ECC writes by hardware and ECC reads by
software. It allows to benefit from the HW acceleration on writes and to
fix the read issue.
Use the hamming helpers provided by the core with the PL35x flag on to
do the soft computation.
Remove the no longer used read_hwecc().

[1] https://developer.arm.com/documentation/rlnc000227/a

Cc: stable@vger.kernel.org
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 172 ++-------------------------
 1 file changed, 10 insertions(+), 162 deletions(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index d61eba938311..78ddc5e8f311 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -392,50 +392,6 @@ static void pl35x_nand_write_data_op(struct nand_chip *chip, const u8 *out,
 		pl35x_smc_force_byte_access(chip, false);
 }
 
-static int pl35x_nand_correct_data(struct pl35x_nandc *nfc, unsigned char *buf,
-				   unsigned char *read_ecc,
-				   unsigned char *calc_ecc)
-{
-	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
-	unsigned short calc_ecc_lower, calc_ecc_upper;
-	unsigned short byte_addr, bit_addr;
-
-	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) &
-			 PL35X_NAND_ECC_BITS_MASK;
-	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
-			 PL35X_NAND_ECC_BITS_MASK;
-
-	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) &
-			 PL35X_NAND_ECC_BITS_MASK;
-	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
-			 PL35X_NAND_ECC_BITS_MASK;
-
-	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
-	ecc_even = read_ecc_upper ^ calc_ecc_upper;
-
-	/* No error */
-	if (likely(!ecc_odd && !ecc_even))
-		return 0;
-
-	/* One error in the main data; to be corrected */
-	if (ecc_odd == (~ecc_even & PL35X_NAND_ECC_BITS_MASK)) {
-		/* Bits [11:3] of error code give the byte offset */
-		byte_addr = (ecc_odd >> 3) & PL35X_NAND_ECC_BYTE_OFF_MASK;
-		/* Bits [2:0] of error code give the bit offset */
-		bit_addr = ecc_odd & PL35X_NAND_ECC_BIT_OFF_MASK;
-		/* Toggle the faulty bit */
-		buf[byte_addr] ^= (BIT(bit_addr));
-
-		return 1;
-	}
-
-	/* One error in the ECC data; no action needed */
-	if (hweight32(ecc_odd | ecc_even) == 1)
-		return 1;
-
-	return -EBADMSG;
-}
-
 static void pl35x_nand_ecc_reg_to_array(struct nand_chip *chip, u32 ecc_reg,
 					u8 *ecc_array)
 {
@@ -464,42 +420,6 @@ static int pl35x_nand_read_eccbytes(struct pl35x_nandc *nfc,
 	return 0;
 }
 
-static int pl35x_nand_recover_data_hwecc(struct pl35x_nandc *nfc,
-					 struct nand_chip *chip, u8 *data,
-					 u8 *read_ecc)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	unsigned int max_bitflips = 0, chunk;
-	u8 calc_ecc[3];
-	u32 ecc_value;
-	int stats;
-
-	for (chunk = 0; chunk < chip->ecc.steps;
-	     chunk++, data += chip->ecc.size, read_ecc += chip->ecc.bytes) {
-		/* Read ECC value for each chunk */
-		ecc_value = readl(nfc->conf_regs + PL35X_SMC_ECC_VALUE(chunk));
-
-		if (!PL35X_SMC_ECC_VALUE_IS_VALID(ecc_value))
-			return -EINVAL;
-
-		if (PL35X_SMC_ECC_VALUE_HAS_FAILED(ecc_value)) {
-			mtd->ecc_stats.failed++;
-			continue;
-		}
-
-		pl35x_nand_ecc_reg_to_array(chip, ecc_value, calc_ecc);
-		stats = pl35x_nand_correct_data(nfc, data, read_ecc, calc_ecc);
-		if (stats < 0) {
-			mtd->ecc_stats.failed++;
-		} else {
-			mtd->ecc_stats.corrected += stats;
-			max_bitflips = max_t(unsigned int, max_bitflips, stats);
-		}
-	}
-
-	return max_bitflips;
-}
-
 static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
 				       const u8 *buf, int oob_required,
 				       int page)
@@ -579,87 +499,6 @@ static int pl35x_nand_write_page_hwecc(struct nand_chip *chip,
 	return ret;
 }
 
-/*
- * This functions reads data and checks the data integrity by comparing hardware
- * generated ECC values and read ECC values from spare area.
- *
- * There is a limitation with SMC controller: ECC_LAST must be set on the
- * last data access to tell the ECC engine not to expect any further data.
- * In practice, this implies to shrink the last data transfert by eg. 4 bytes,
- * and doing a last 4-byte transfer with the additional bit set. The last block
- * should be aligned with the end of an ECC block. Because of this limitation,
- * it is not possible to use the core routines.
- */
-static int pl35x_nand_read_page_hwecc(struct nand_chip *chip,
-				      u8 *buf, int oob_required, int page)
-{
-	const struct nand_sdr_timings *sdr =
-		nand_get_sdr_timings(nand_get_interface_config(chip));
-	struct pl35x_nandc *nfc = to_pl35x_nandc(chip->controller);
-	struct pl35x_nand *plnand = to_pl35x_nand(chip);
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	unsigned int first_row = (mtd->writesize <= 512) ? 1 : 2;
-	unsigned int nrows = plnand->addr_cycles;
-	unsigned int addr1 = 0, addr2 = 0, row;
-	u32 cmd_addr;
-	int i, ret;
-
-	ret = pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_APB);
-	if (ret)
-		return ret;
-
-	cmd_addr = PL35X_SMC_CMD_PHASE |
-		   PL35X_SMC_CMD_PHASE_NADDRS(plnand->addr_cycles) |
-		   PL35X_SMC_CMD_PHASE_CMD0(NAND_CMD_READ0) |
-		   PL35X_SMC_CMD_PHASE_CMD1(NAND_CMD_READSTART) |
-		   PL35X_SMC_CMD_PHASE_CMD1_VALID;
-
-	for (i = 0, row = first_row; row < nrows; i++, row++) {
-		u8 addr = page >> ((i * 8) & 0xFF);
-
-		if (row < 4)
-			addr1 |= PL35X_SMC_CMD_PHASE_ADDR(row, addr);
-		else
-			addr2 |= PL35X_SMC_CMD_PHASE_ADDR(row - 4, addr);
-	}
-
-	/* Send the command and address cycles */
-	writel(addr1, nfc->io_regs + cmd_addr);
-	if (plnand->addr_cycles > 4)
-		writel(addr2, nfc->io_regs + cmd_addr);
-
-	/* Wait the data to be available in the NAND cache */
-	ndelay(PSEC_TO_NSEC(sdr->tRR_min));
-	ret = pl35x_smc_wait_for_irq(nfc);
-	if (ret)
-		goto disable_ecc_engine;
-
-	/* Retrieve the raw data with the engine enabled */
-	pl35x_nand_read_data_op(chip, buf, mtd->writesize, false,
-				0, PL35X_SMC_DATA_PHASE_ECC_LAST);
-	ret = pl35x_smc_wait_for_ecc_done(nfc);
-	if (ret)
-		goto disable_ecc_engine;
-
-	/* Retrieve the stored ECC bytes */
-	pl35x_nand_read_data_op(chip, chip->oob_poi, mtd->oobsize, false,
-				0, PL35X_SMC_DATA_PHASE_CLEAR_CS);
-	ret = mtd_ooblayout_get_eccbytes(mtd, nfc->ecc_buf, chip->oob_poi, 0,
-					 chip->ecc.total);
-	if (ret)
-		goto disable_ecc_engine;
-
-	pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_BYPASS);
-
-	/* Correct the data and report failures */
-	return pl35x_nand_recover_data_hwecc(nfc, chip, buf, nfc->ecc_buf);
-
-disable_ecc_engine:
-	pl35x_smc_set_ecc_mode(nfc, chip, PL35X_SMC_ECC_CFG_MODE_BYPASS);
-
-	return ret;
-}
-
 static int pl35x_nand_exec_op(struct nand_chip *chip,
 			      const struct nand_subop *subop)
 {
@@ -916,7 +755,7 @@ static int pl35x_nand_init_hw_ecc_controller(struct pl35x_nandc *nfc,
 	chip->ecc.bytes = 3;
 	chip->ecc.size = SZ_512;
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
-	chip->ecc.read_page = pl35x_nand_read_page_hwecc;
+	chip->ecc.read_page = nand_read_page_swecc;
 	chip->ecc.write_page = pl35x_nand_write_page_hwecc;
 	pl35x_smc_set_ecc_pg_size(nfc, chip, mtd->writesize);
 
@@ -939,6 +778,15 @@ static int pl35x_nand_init_hw_ecc_controller(struct pl35x_nandc *nfc,
 		return -EOPNOTSUPP;
 	}
 
+	chip->ecc.options |= NAND_ECC_SOFT_HAMMING_PL35X_ORDER;
+	ret = rawnand_sw_hamming_init(chip);
+	if (ret) {
+		WARN(1, "Hamming ECC initialization failed!\n");
+		return ret;
+	}
+	chip->ecc.calculate = rawnand_sw_hamming_calculate;
+	chip->ecc.correct = rawnand_sw_hamming_correct;
+
 	return ret;
 }
 

-- 
2.55.0


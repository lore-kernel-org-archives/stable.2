Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD47798E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117155; cv=none; b=kRCcipSjUYSleIIh77dpuHzG0qcgLCcIuLZ6LwnZQgHgumR7MzDLvAV/vmF4vt0zcHZl86j8LaKFSlr36ZBbXfZIB0LPHZ2rx6kOD+tJKxtdhIP40HHlY3yVyICiwVC0mn/2RJTq5vWnL8RiESFBFDXg2CXdUHhZftZGh7wdDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117155; c=relaxed/simple;
	bh=fjJbOQKzguDWbLI313C9AMkwyvYLGGwqNj2+pQIqOD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3jgTkBRmZtcsJvhEBk2FmwZarD7nadqsACOa1LdZX8pMs9rfAAnGbHgDw6RaZWymU2+6jDDyQVgL/1tDPJwcGg6oYDFWOtMKY2Y1u7X5Q2Wqjfm8T9Je1WGVrSFmGCPjYP0s9lyr7o3nGHvZgreL69Fn98qqTI2KmV8EP+3nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb5OKfDk; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb5OKfDk"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-49ff971e903so1482168b6e.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117152; x=1786721952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCFnyxQ3kE94m7oA5V9nQHQf/U50pnd0oZWwoKAuPBw=;
        b=Sb5OKfDkW3m0qcUwnNv+0cBtI61QDVXRASXtikejyavAmCgjqe4UgOTD+bVGarnbFB
         c61zw7aPHZgbuOvGdHqXvEnV9a17cGBDXFNCmZ/pkpnpPGe+dqKVizt3NCf+h39OgmOi
         GoKha6WH7v5CNCY3YsTYGBFxSM6DhxD4z8taLumwN0ONsTEz0VmRdcNKI0KWDlRhd5mz
         ECpOq4v3zLKMmKMX4kICrkHcFe7Dt8mXMwGVEElaG0NzJVfGGkxXL1RmHU73ppsMZege
         +u/UnKhgPXnDdRH5aINgrVzl5/BFMSmxrUNW+TsO25lHSpQCGcz6DbNhZoTlMzIE3ReM
         nCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117152; x=1786721952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCFnyxQ3kE94m7oA5V9nQHQf/U50pnd0oZWwoKAuPBw=;
        b=JSLhi60zN0u6dXT4pNrx/t4rSxtZhW/DoRUAzEJ2vT6XQhPa1PmHRZgwn7+9tqoxE4
         W3HV+OhCv8gBrevExy8i4SndDqIi3bmRCgN2iEVmlenIXbxk5LlnJmMuP1ixKbEV6EMy
         4cTnKgdCLIn79ZiOYj865bS0OJIIlObV0ytYumCCXjkGdqRq9Q+bklwFup4/R994Vyif
         MpH23ypiFBsSj2PUMAB4ZjYAPNer1Jei8+lpq7U3xCVumogdz/f80tBC0AXidZAhjF4s
         tjK6liYWSXSAuxPVVAcyIAgbLZCvf3Xhcyj22UbozYBuADWHXjnXxra0yWiz0XF/hjjg
         TSBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTCHD9ZcWxSa/ypFCm5qmd8gRCo6Qd2LQmu+kNbhQ7ayKHWUm2k1yWgejnsJcso4SFc9FVIZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NvqSaLnTcLnL6JTcAAy2IA8AWffN47Q3w2AXjiNNAj4n56S9
	IatdvbyGCQH/gKOBovLA1IypihURo8VC+Ah2cGrEl92LcFWP4Txzqryl
X-Gm-Gg: AR+sD11dcZdSmUnZbm+Lfwq5OUsoI6+QgVJmv1gGZoEF6/9j+ZKnQO9DCyJ5ZluM8rI
	IQLcgAMvmqVO8mSOC1xm/pM1FNIQlXr/wVcHPzO0Aj0OkNd9UN/nGKRC0ANYsxzPA+9crBmAVQ9
	+wGChBvkYrS3CdwohKg520QZfTITswCLAFUDZdYZfhVc1MJ7CN9d+upmw8Ae1nWSAwfKbc6Eol+
	/ABCWIaUKiJ9cff2vr9YRvpfm9z7wDYe3ZICtj10N6lrSluE1oQibGzw9gb3JZfjdvleUbaXmPB
	ANYnN3jyUBiuvvX5M4hEkgg/hKjgxT414kQYMrnDbX9sG8nujE59V1fgQnnTJ0CYYiVVEvweO4G
	DK1eg4Dii+yZkgu6ZTJu6LtL0WBOO6NACPFod18/ZohlWJs6KSxvxERsATordOlXgPoaXtrtG3K
	JyJsMcQL/MwJ0w5BIE8LCbYMY1FnuIHgZD5V+vJq0e+8JeTjHWbepP/2SxyRv/BC3UL53ut7EdP
	H0FjP6W9Dd2sgxTZymbxLZamtC4nCEEME4Rr67ECoG2woKY4MYiGCsVw5dJ+YV7vuvOWbdwqoKi
	luwynqOrUxvN5t2vjf8G82v/9nOo7wAqf9lYNmmDFrdWE00jcT1KzLWUonlpuFTnbRiLYmfxIfs
	whVTdoywQoLA9YOxM
X-Received: by 2002:a05:6808:ec9:b0:4a4:cedc:6859 with SMTP id 5614622812f47-4afc4df6419mr8781396b6e.4.1786117151816;
        Fri, 07 Aug 2026 08:39:11 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae706cd5sm7353485b6e.11.2026.08.07.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:39:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 07 Aug 2026 09:39:01 -0600
Subject: [PATCH v3 3/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-submit-sunxi-nand-h6-h616-timings-v3-3-91287b543f41@gmail.com>
References: <20260807-submit-sunxi-nand-h6-h616-timings-v3-0-91287b543f41@gmail.com>
In-Reply-To: <20260807-submit-sunxi-nand-h6-h616-timings-v3-0-91287b543f41@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The NAND timing calculation assumes that command and address setup and
hold intervals T1-T4, T7 and T11 each take one controller clock. It also
uses the original A10 delay encodings for tWB, tADL, tWHR and tRHW.

The H6/H616 NDFC defines the setup and hold intervals as two internal
clock cycles and uses different delay encodings. Add the H616 timing
characteristics and select them through the controller capability data so
the clock solver and timing fields match the hardware.

Fixes: 88fd4e4deae8 ("mtd: rawnand: sunxi: Add support for H616 nand controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 49 ++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index df52501c1285..ca74c9c333e7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -241,6 +241,8 @@ struct sunxi_nand_hw_ecc {
 
 /* Delay arrays contain internal NDFC clock cycles for field values 0 to 3. */
 struct sunxi_nfc_timings {
+	/* Internal clock cycles used by T1-T4, T7 and T11. */
+	u8 setup_cycles;
 	s32 tWB[SUNXI_NFC_TIMING_STEPS];
 	s32 tADL[SUNXI_NFC_TIMING_STEPS];
 	s32 tWHR[SUNXI_NFC_TIMING_STEPS];
@@ -1680,12 +1682,21 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 }
 
 static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {
+	.setup_cycles = 1,
 	.tWB = { 6, 12, 16, 20 },
 	.tADL = { 7, 15, 23, 31 },
 	.tWHR = { 7, 15, 23, 31 },
 	.tRHW = { 4, 8, 12, 20 },
 };
 
+static const struct sunxi_nfc_timings sun50i_h616_nfc_timings = {
+	.setup_cycles = 2,
+	.tWB = { 28, 44, 60, 76 },
+	.tADL = { 0, 12, 28, 44 },
+	.tWHR = { 0, 12, 28, 44 },
+	.tRHW = { 8, 24, 40, 56 },
+};
+
 static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
 		u32 clk_period)
 {
@@ -1720,20 +1731,28 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		return -ENOTSUPP;
 
 	/* T1 <=> tCLS */
-	if (timings->tCLS_min > min_clk_period)
-		min_clk_period = timings->tCLS_min;
+	if (timings->tCLS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCLS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T2 <=> tCLH */
-	if (timings->tCLH_min > min_clk_period)
-		min_clk_period = timings->tCLH_min;
+	if (timings->tCLH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCLH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T3 <=> tCS */
-	if (timings->tCS_min > min_clk_period)
-		min_clk_period = timings->tCS_min;
+	if (timings->tCS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T4 <=> tCH */
-	if (timings->tCH_min > min_clk_period)
-		min_clk_period = timings->tCH_min;
+	if (timings->tCH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T5 <=> tWP */
 	if (timings->tWP_min > min_clk_period)
@@ -1744,8 +1763,10 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		min_clk_period = timings->tWH_min;
 
 	/* T7 <=> tALS */
-	if (timings->tALS_min > min_clk_period)
-		min_clk_period = timings->tALS_min;
+	if (timings->tALS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tALS_min,
+					      nfc_timings->setup_cycles);
 
 	/* T8 <=> tDS */
 	if (timings->tDS_min > min_clk_period)
@@ -1760,8 +1781,10 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		min_clk_period = DIV_ROUND_UP(timings->tRR_min, 3);
 
 	/* T11 <=> tALH */
-	if (timings->tALH_min > min_clk_period)
-		min_clk_period = timings->tALH_min;
+	if (timings->tALH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tALH_min,
+					      nfc_timings->setup_cycles);
 
 	/* T12 <=> tRP */
 	if (timings->tRP_min > min_clk_period)
@@ -2670,7 +2693,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
 	.max_ecc_steps = 32,
 	.sram_size = 8192,
-	.timings = &sun4i_a10_nfc_timings,
+	.timings = &sun50i_h616_nfc_timings,
 };
 
 static const struct of_device_id sunxi_nfc_ids[] = {

-- 
2.53.0


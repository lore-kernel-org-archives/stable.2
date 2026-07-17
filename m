Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A83FDBEF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309675; cv=none; b=m/+PxP9uV1BGHhOR3/P1WmL2pDxtPw8oJyZOibdI2aJzyp+6+ZWTfVe9i1O7MHQ+MMD1/NkUTHu5nDZbteKmuKJmaO/cVkIVhSklSq4KDRPANAceDG1U5IIxU7PiL0AbhKLjHYq7DDRHvvsftP4RRgPCxLsx8Y9tNkLXjDDlup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309675; c=relaxed/simple;
	bh=cKHutGHLndJN3BZmJco0fGWbxTiby9/tAM3iiXN6y5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rujft+pezfXf6dQQWiGUp8JuIs36MRlWeBowV8NwyKdbS++q6/6tiCy/0eFS3R3Bn4eoDNHKyXP1Ss+1MovJ7GdCEOf0AU5qAdHCy+sNXxOX7Iypa7mb11XzB2d8KUJJ+uZGNJfZyvRKKUUQxdjJTm0B/VQzr/ZpI+cHeQaFw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8xWwyDV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8xWwyDV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f829d75aso3055428a34.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309671; x=1784914471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBTwbiP2C8OFdHLB83ZBc1RdHRd7b7uHmQhCjRYWMAk=;
        b=S8xWwyDVeNH23aiNVLKclRS+3cjZSmuPAVL82ELDh6+7E4F2SlON+Kywpv00eYeNjg
         NH2RwNb8eHx9A/YUr6F+Bi0wKspdxI9DXwNv7D7+AZCsiKUt2qdOpdGZeWSouaAQ3xV0
         7gmAC3uGyluh/FU91CAKkPO4RpXFECwovrP9fDXHXg03kqEe0LJenUYEbJa4Nu3cVS7L
         oBQhRftIm0qfoRT6m21BJ6SC2g+3Vj3HzAYhw44XCLIeQ+Q2clBSiyXdPFqyqweUtc91
         pt28uOItCMHjeRtMH4CVVQnncdtakEiY01sVqhn80c0Q7JjIPzVmmegp+ne+unNPe9HE
         333g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309671; x=1784914471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBTwbiP2C8OFdHLB83ZBc1RdHRd7b7uHmQhCjRYWMAk=;
        b=n7qaH1szoygOPA2L+Ej5cQKN/13Lvm22jZlbs2MjqK42AsBugUjAyBx+ImyPhhp9qF
         BuYb9j+RQEaIicr23USMhl4DNfk2Z7s29kySs1jmOm6ec/OVdb9Fpqm/5q03xEPg+3UU
         nBemgeMOftJCi6RahSP5507xIa6HSISIVxrbplFlKDNr4RGKMKSnDQ62z8++Qo7LbDZm
         9WkJta4BEDScwraxUn/QvAnB6qQtydJ2uAsIlqBzTmcepRfd+KWgup1DdEAZgTVlCI5h
         g6PgK4uKJrYIJcSHWVbnXXynGu0YmB5VlDihEYGjbCqu7L3MLTTUaEJSo7W2+6J5hGwp
         ChWA==
X-Forwarded-Encrypted: i=1; AHgh+RqW0Q7c9Tew5LFdqC5lCG7cotk9ChGfFSB3bYYacKz7thCIFkL+tQtA6QhM/pv/fDcO35HQgiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1cwy96zZ/427i+zyPmdECXrUkom0fE/c8BcC7xg4APv4NcqU
	MHv19cBxKBaCov5zLYjfNULzkQ4N89m9s+53JAyoH5eRqfnciHpT9/Lu
X-Gm-Gg: AfdE7clLhtB8eDbFjujKxn8CowYKuiMukPUTW3/mpRHux81+M/U7YdRDH8HwUeiu7hi
	sPNUqtNnkE5HdgUQYizKXX2AoYKcdk8LMUsnrP4lbLO4oY/GIObXDbLIbbwHNfpVNkWApcFlU3U
	Mzj9U1ZpMaSu2WH0zMMv1fmLm8QPeA3FxcNJj9uSCeibASh59Nk8t9L1A944OSfVTwvAm5oPyIO
	HdKG6zPkYakZ1sCiXhf5LrrVYuzLOF9VF3yEzIYxSycbD3+7jNZNrKvTcHNgcM2Z2edETg9QbZ7
	S9F97UKBnwVWO8rDtK8KJFv2CZrUHOKImPzF2w9YHlXeZsjcmFvqMU0gXMe/BZdvl1WOMk3eQbY
	R5haZtl1qUTuQBI8LxYS1Gj8pMQS8YhSfn2svGBCo4gQTQStNJgBdUUPH9fTp8dGCRvlBoTtpgJ
	3tEJ3b8v+u2uAEfqxhIS+k2rEhyCQEIlzVYRm2hITRPBKdSufMdRn28zVqpOGoL85FdTopOhsQ5
	PNnXhZY2dujWWfsZyAJJPIXv47TmgoE3r8dAyzF5fbF4UdoMjhJDQ==
X-Received: by 2002:a05:6830:2a0e:b0:7e7:571:114e with SMTP id 46e09a7af769-7eda08eb88cmr1835909a34.20.1784309671288;
        Fri, 17 Jul 2026 10:34:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad965130sm1677212a34.11.2026.07.17.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:34:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 17 Jul 2026 11:33:59 -0600
Subject: [PATCH v2 3/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-submit-sunxi-nand-h6-h616-timings-v2-3-225515107640@gmail.com>
References: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
In-Reply-To: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
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
index 791f495f6e82..3d91533a9f13 100644
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
+					nfc_timings->setup_cycles);
 
 	/* T2 <=> tCLH */
-	if (timings->tCLH_min > min_clk_period)
-		min_clk_period = timings->tCLH_min;
+	if (timings->tCLH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCLH_min,
+					nfc_timings->setup_cycles);
 
 	/* T3 <=> tCS */
-	if (timings->tCS_min > min_clk_period)
-		min_clk_period = timings->tCS_min;
+	if (timings->tCS_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCS_min,
+					nfc_timings->setup_cycles);
 
 	/* T4 <=> tCH */
-	if (timings->tCH_min > min_clk_period)
-		min_clk_period = timings->tCH_min;
+	if (timings->tCH_min >
+	    min_clk_period * nfc_timings->setup_cycles)
+		min_clk_period = DIV_ROUND_UP(timings->tCH_min,
+					nfc_timings->setup_cycles);
 
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
+					nfc_timings->setup_cycles);
 
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
+					nfc_timings->setup_cycles);
 
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


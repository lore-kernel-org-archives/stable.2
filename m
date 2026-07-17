Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDA42903D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309671; cv=none; b=R4dQx0XtSf3s6iNWNGdj2UahLKZ4AZEJlw/kVqjsLF6QVRRo498Nq0BKpBm1Vo12RI7HDmQy4NuSREC7HQQu4trayROFaWGNtmGR6uzvK/iPYVewun7rxtO8/+sbJBI7si5j68WLVc2CVd/9WFExYck5L5yJLhCPz4gGyFBTqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309671; c=relaxed/simple;
	bh=f+Q3D9sl+haJbd8q6IQSARPqlTZdxv8bfThP1g3/NoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pILYEW2rUdPLv1sKQCpVM7lbgCUojy7cKctOeu8LG+FYbUY2/Z4A8QS1ZKFwrZO6z+2UPrphPbD/DOxeX9irunuXHa8XDHszuthePbUAlMoCjffC7QQYDjgohgLILby5w51Zo5q2pwyzvsDMODlJ5ufik4v3q4NyFU6E6c/NKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMhxuQmT; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMhxuQmT"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb3865ea6fso5447271a34.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309668; x=1784914468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlsKLWHzuG2ZqAxSmlNnrAEdRDdQeGiW44cbYcWz6fU=;
        b=lMhxuQmTG8gKTuQdNMH/kPL3bjOEKhbS5+xL1GWHEXmMSDR8/4pusK4Sz4FQLByTBk
         hzIfJGzgXhu5926RGc7iTI7sjWfhLdMpoEndqvRKJn/GwySCwg48fbpod1MludirdHZ2
         /ST/mql8GC0BUk8up4PbIfiFb0HJwtXrMOdoi0x2pbRRP6bVcDy5jWgWYV4amzYZ3WUs
         ixsVquJSI/ou1Sqa8QKM02xHzEUHo4qyHK0phb2LH4vqFE/SK04yUb4gR2aGt1pT9bBF
         AwpDPLj3GstoG1lNGsL+GChZM8OkpOY83qxjPYaiNnKkO9jD0Xi1FdeTto7JGpUKRUir
         VaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309668; x=1784914468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlsKLWHzuG2ZqAxSmlNnrAEdRDdQeGiW44cbYcWz6fU=;
        b=nyj1boKsKWvOX8KvLEPcefuQMgAI8FUjfUHEbqE0F9hqEYGAZkUCjJ28ZRxgNCS44t
         KOUlTRXl/lOfbUQ1VqXl44wX/dybH+xcbR0A31X3EmgSMIEGTyFdrR1F4iyow1VqDVE1
         1WBCjUCIrSc2MW7O16pCp3QbeKR3Uo1Vdd6qSqI4Ub5Te2tw834+xLBLmTaJr7hpTPYn
         Rgs6Wd135bGR1oBG4tW5vmB0l+wJjYKpEwlOe3zQI+h3RYdtJLGErGFNOJBjF0p08CIA
         B2bwLFoHW3S509O1mJng32tkJRea823LmFPVukfd1QGq7u1JY6Wlm2NvVI4P7/xBmpd6
         txwg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3HF1NiWmvduER9FjAeISMGmI6u0SpCbaAmKPzuU200fPimu9RFg0HHCbYKNJJ8pb43VRPWRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNf2DThdqVvh1wGvgHgw/y3eqt7Z7HELm09uxXzuC+FDMC+pp
	jSYJGogPATORLFp7ll/tlEtoQj7JSGcisqVg5cRxFhBfv/lzK00XcIJz
X-Gm-Gg: AfdE7cmXISlDaOsqUoz5yd8HpWi1oKbQZokdFyozXhQIDKpCeG4T8fB0vgL+go64q9d
	rSgz+H/hHrOEGbhiw6OvBUlN6qfO/XCju3/XcynGEhryG3Y6St5BG6ObEWExhDLlE0xjUqWGSDm
	4bfn5qkbE8TWDpeMG6Rijrzq84sd5S8aVT+LrDcYi18zE7tM+pjxNx7YDjUZqw5KgHVDrd7wpjQ
	NtZ2HBDM7CpwNP8IpbImXq/MW/ryCmrPJ1U3atrCjmAtB9M3u/lakqcu5EejCYfkDX51KtQucuC
	SCLql9tZkKBgreOz6oytvQ5Z3P/K4KJbxfjm6ZhsieWvKjZobFXVSavl3+QqcBPFG7xIELB5luC
	jiV9KhFhM+LlfBh2zND0CmvcAYQJ8/lPGqoAHEmO+Hlc566TVfc6kfIVLxGMyW5muNIlFzVbpiS
	6Gy8mJ8xdf5Kgq2YG/VZbJPfZqeSDOPi/Fym9TiSSg9ubPcfWfT5pC4ulW2X529VFU43pCPdqvd
	81C1p5prWCwDYYo0GTDh8Q5t+uXkHFMrvBwfrtOrZzuo5FHYw0Ebg==
X-Received: by 2002:a05:6830:6afa:b0:7e6:f4a3:1df5 with SMTP id 46e09a7af769-7eda08ae511mr1817637a34.1.1784309667752;
        Fri, 17 Jul 2026 10:34:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad965130sm1677212a34.11.2026.07.17.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:34:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 17 Jul 2026 11:33:57 -0600
Subject: [PATCH v2 1/3] mtd: rawnand: sunxi: group controller delay tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-submit-sunxi-nand-h6-h616-timings-v2-1-225515107640@gmail.com>
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

The tWB and tRHW timing field encodings are controller properties, but
they currently live in standalone lookup tables.

Group them in a timing descriptor selected through the controller
capability data. Point every existing controller at the legacy values so
this is a pure preparation change.

Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 02647565c8ba..d12cbb3c813c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -237,6 +237,14 @@ struct sunxi_nand_hw_ecc {
 	u32 ecc_ctl;
 };
 
+#define SUNXI_NFC_TIMING_STEPS	4
+
+/* Delay arrays contain internal NDFC clock cycles for field values 0 to 3. */
+struct sunxi_nfc_timings {
+	s32 tWB[SUNXI_NFC_TIMING_STEPS];
+	s32 tRHW[SUNXI_NFC_TIMING_STEPS];
+};
+
 /**
  * struct sunxi_nand_chip - stores NAND chip device related information
  *
@@ -301,6 +309,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  *			bytes to write
  * @nuser_data_tab:	Size of @user_data_len_tab
  * @sram_size:		Size of the NAND controller SRAM
+ * @timings:		Controller timing characteristics
  */
 struct sunxi_nfc_caps {
 	bool has_mdma;
@@ -327,6 +336,7 @@ struct sunxi_nfc_caps {
 	unsigned int nuser_data_tab;
 	unsigned int max_ecc_steps;
 	int sram_size;
+	const struct sunxi_nfc_timings *timings;
 };
 
 /**
@@ -1667,8 +1677,10 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 	return nand_prog_page_end_op(nand);
 }
 
-static const s32 tWB_lut[] = {6, 12, 16, 20};
-static const s32 tRHW_lut[] = {4, 8, 12, 20};
+static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {
+	.tWB = { 6, 12, 16, 20 },
+	.tRHW = { 4, 8, 12, 20 },
+};
 
 static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
 		u32 clk_period)
@@ -1693,6 +1705,7 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
+	const struct sunxi_nfc_timings *nfc_timings = nfc->caps->timings;
 	const struct nand_sdr_timings *timings;
 	u32 min_clk_period = 0;
 	s32 tWB, tADL, tWHR, tRHW, tCAD;
@@ -1763,8 +1776,10 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
 
 	/* T16 - T19 + tCAD */
-	if (timings->tWB_max > (min_clk_period * 20))
-		min_clk_period = DIV_ROUND_UP(timings->tWB_max, 20);
+	if (timings->tWB_max >
+	    (min_clk_period * nfc_timings->tWB[SUNXI_NFC_TIMING_STEPS - 1]))
+		min_clk_period = DIV_ROUND_UP(timings->tWB_max,
+				nfc_timings->tWB[SUNXI_NFC_TIMING_STEPS - 1]);
 
 	if (timings->tADL_min > (min_clk_period * 32))
 		min_clk_period = DIV_ROUND_UP(timings->tADL_min, 32);
@@ -1772,8 +1787,10 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 	if (timings->tWHR_min > (min_clk_period * 32))
 		min_clk_period = DIV_ROUND_UP(timings->tWHR_min, 32);
 
-	if (timings->tRHW_min > (min_clk_period * 20))
-		min_clk_period = DIV_ROUND_UP(timings->tRHW_min, 20);
+	if (timings->tRHW_min >
+	    (min_clk_period * nfc_timings->tRHW[SUNXI_NFC_TIMING_STEPS - 1]))
+		min_clk_period = DIV_ROUND_UP(timings->tRHW_min,
+				nfc_timings->tRHW[SUNXI_NFC_TIMING_STEPS - 1]);
 
 	/*
 	 * In non-EDO, tREA should be less than tRP to guarantee that the
@@ -1789,7 +1806,7 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 	if (timings->tREA_max > min_clk_period && !timings->tRLOH_min)
 		min_clk_period = timings->tREA_max;
 
-	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
+	tWB  = sunxi_nand_lookup_timing(nfc_timings->tWB, timings->tWB_max,
 					min_clk_period);
 	if (tWB < 0) {
 		dev_err(nfc->dev, "unsupported tWB\n");
@@ -1808,7 +1825,7 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		return -EINVAL;
 	}
 
-	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
+	tRHW = sunxi_nand_lookup_timing(nfc_timings->tRHW, timings->tRHW_min,
 					min_clk_period);
 	if (tRHW < 0) {
 		dev_err(nfc->dev, "unsupported tRHW\n");
@@ -2595,6 +2612,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
 	.max_ecc_steps = 16,
 	.sram_size = 1024,
+	.timings = &sun4i_a10_nfc_timings,
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
@@ -2617,6 +2635,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
 	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
 	.max_ecc_steps = 16,
 	.sram_size = 1024,
+	.timings = &sun4i_a10_nfc_timings,
 };
 
 static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
@@ -2641,6 +2660,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
 	.max_ecc_steps = 32,
 	.sram_size = 8192,
+	.timings = &sun4i_a10_nfc_timings,
 };
 
 static const struct of_device_id sunxi_nfc_ids[] = {

-- 
2.53.0


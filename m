Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FE4772A2
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117153; cv=none; b=TDvGPYzSR/ECA9HafAOvvxZvD3f0dG9QhqQ4k9+QnSKcGpy9VavA3V/kBApiphcHm+fv1S1qpgtwUYF1edAlMsgYsiazdM1EMO8RuFQO08G3Gl77eE77SPPAJM2/uFt7a5QzmpMAfyXcf7jTgjp4SXoHxp4S2F5NksYRHJgpIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117153; c=relaxed/simple;
	bh=2FMplYOhzsgtvnRdbTNiLAZSTZm3+8XCX5VqoyndQro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjNDX3icJ/zRioslORoyF9QbOaBYZ4VFmKdGFLFX3luUoF1LmaM3b+vf2TRFLFcd+jXpnO2LFKvrBc7//MIzycUhrFReNhKuu/Z1SUFVabNS6Cc+ik6AwmvWNqjlYvM6wuudB0CFpBiuNNXKVcL0Te7xyOdTmk3rrF/NVkh1Wew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYsAo0WF; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYsAo0WF"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a4836dc117so697513b6e.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117150; x=1786721950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BH5d83nxZVwUU/yrlx0wCDcJDqfJzuP8B2aoypwvUDg=;
        b=TYsAo0WF4rgNIM3xkrifkoocrIvOTnY3gOZjLWzeQR+FAxXShKksb0DEu2BJAMmBh1
         3EkN6CK+bA9m/HSOGeo+oISjfistHhjNYH0gYwVSEPOF+Y3tE2ZsH8V5JumJKHhC0zAs
         dEzNSZgSTDKrVu2f2rwcZQB7e78vc0Eyo23USyAmSULRz553ej9cv1n+SJsfkgVWa0Zu
         8Jq7ujLI/+2pwqfyyZnexKE/G/VqlAIGGNiEoD8Ej+lFCXwUvTnpvAEV3/crtLq3S2+Z
         ljA+gM9PnZ4FS7tahuBtrOeE4M15VzpgOS1uv9Xcucvzg9yIUlTrA7J/M/dM/79vaEVN
         nZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117150; x=1786721950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH5d83nxZVwUU/yrlx0wCDcJDqfJzuP8B2aoypwvUDg=;
        b=rT+NDQACG0KIArgdGwAT+6L6xC1FN0CtSRwFQWEbqbHqU0Oio36pMyzawC/3K/S2mg
         stjwyo7/697VQOxQAf/BqLg3yJ6rZ8OXn5OESKyL7KuX9DKsvk4JbSreI/0bgsq4w/wh
         cr9XyRC7t21gRbnGTArLV+dLda/WvBiEbUa3PScO08z3bpGYX/gaK/bKlc0Ukd/oLaAU
         zBnYAOLlPclS9Uy2F3D+20hznCTCpvyeit3bKtE2t8RqC9zzBhcGbWby6a9QnQPgEwr6
         BnbgqhgaZGA00h/aJ+BGRTraULx/xRXprZDNpnF8NgByTavEXq0fxE5NpErhb3ugNGnT
         GOgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrwk7FDymgcpfxxRBVrxJr1F4trpQE717GZl+tQyLMZ2jKNQ4dUXaLWHJay2AVJcXotGzG7XM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3dvL2ek2dSEzYQQ+ZdBm89plnmpS0kTiQrud+ClRwlCfXEwM
	DakBk9i7hZVzzc9hJrCW247LlB0SBV171d76H5pMgjD2BWDWVqh+tRPNrS0ryaX+
X-Gm-Gg: AR+sD12r4fA7A6OkhcQ8GEPGgmnqPKKSpNWynqku5nM2uAbdU++ZL/AfrYdG9BQdMms
	MHhfckVxIHGIsVyYD3PYSy0kqs+kLa73yR0FE2LKxJLojsYsDo/X/ocmWiNW2Nq5C6XpXGzCTkM
	YuIZFhpyYhx/ijNFZSq0RFHgnjI/hzqv51Jua2CJBDisZVbRnnRXSwM1Jq8cp+SPIRtTNv0yNhk
	ufHjdWroxWFCEDW69P9ZQ2i7QlgCE0vlAmX9dkEc0+byYCbHAb9jtb7cAnwKDsG/3oqMkv2jbSn
	m9nksOQWib3Jy32e/3tLSjdH2Y9dObaGvK5ZapIo1bvsjn/wcEhM+R1tuQVq/WmWfOVPGEA04OO
	OQHPdo++DKkZOPTYusJDXLLSWTYUbQ5BCQXy5+ssJJAIEvJpCZzYIytw64wkrBNMGE+2QUTxieQ
	F0ptqsRoFPtKPKHrZu+SwHo22PKOrf62dqrXaY2+iaPf/INEzlTOqTeau7wE7zb63h0gnyEoqMt
	NJ2qvkwpCy2jLE1sM8xs3e0v0yRbUChtFSLFKG96x46u0O/NQHDUbeMW6AktPqo3TqQW+affy1l
	wwNkW61g1SfzxNYawdT64v6pdl5JBPqwYHtLfuR5ZxB5VggS7XU1E854GTHD/XHut1yRFzBXcOQ
	AWVqEo6tosTcFhDnM
X-Received: by 2002:a05:6808:ec3:b0:4a4:a693:9d87 with SMTP id 5614622812f47-4afadf0e523mr11310972b6e.5.1786117150060;
        Fri, 07 Aug 2026 08:39:10 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae706cd5sm7353485b6e.11.2026.08.07.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:39:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 07 Aug 2026 09:38:59 -0600
Subject: [PATCH v3 1/3] mtd: rawnand: sunxi: group controller delay tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-submit-sunxi-nand-h6-h616-timings-v3-1-91287b543f41@gmail.com>
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

The tWB and tRHW timing field encodings are controller properties, but
they currently live in standalone lookup tables.

Group them in a timing descriptor selected through the controller
capability data. Point every existing controller at the legacy values so
this is a pure preparation change.

Fixes: 88fd4e4deae8 ("mtd: rawnand: sunxi: Add support for H616 nand controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 02647565c8ba..9885248c9b85 100644
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
+					      nfc_timings->tWB[SUNXI_NFC_TIMING_STEPS - 1]);
 
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
+					      nfc_timings->tRHW[SUNXI_NFC_TIMING_STEPS - 1]);
 
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


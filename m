Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6C3EBF04
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309672; cv=none; b=mGYk4teYcgSriaJwc58l0Dxmlz4NppKJDux8//b+Hm+a16R6xMVdVeM/6AOmxMJ4HP9eE44rwirKb2kX+ngXZLBxA/gLWJGbuKRItkfhKjKHhOQ8vo/Gh92jJ+2QG6mVZcgJrvqO5Hx+sfhkjiQS71Im3AWI36cU8bvBfJoF2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309672; c=relaxed/simple;
	bh=44TY2dOMwcJODONgQHSuiNADRv/0XYu2Y2Iil3nCRsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEz+UrOR9aQHkkLgxo5JSFmGDxXpZyLpBl8Y4PYlFqHUd0qTfFIbgzBOleYmMJPh1HUBNE0yjWans2VOu61PDIAkZlJY/3/7N0tv6padZ9GxEZR14GQ4CcphZyxeYBag568zK52m446eIa5dAl/DgcJeoy2rIGf91fQq0LwmFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0Qw0Vnk; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Qw0Vnk"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6b5737bb2so6635670a34.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309669; x=1784914469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fU/T4ePwxMvnfrbedCWGcOi9RX0frxKmTN5hi5W5USU=;
        b=N0Qw0VnkV9VIMaiwczEv7+YWI6QBlLBR61EduCNp+noYzWoJlh2mVHhy4HdbESacYM
         IEp2jvA0dyS5WG+0frTfsrBe4IHaYHiLazGnqApr4ixVaIoQ5cvQyp+MCQ6YjUJCedj4
         1bKQXPV2a17vqmqSDqBYVM2CDjrpNTaQY2m03I9goN54DrtdJV5lfxRCbnEKRFfvSumq
         xt2DbtMvt5kzmM65joTssGqQEZsSoPpS8FGWpTWAG1oJbZHSh5tW0TgbgldSKYkmeYZo
         7Q07hre21n1pmsJbjg5urZphLmlN6hTkMljIEnWOLNhNEMtuaXVUiWLK71p0HFni2NBL
         0eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309669; x=1784914469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fU/T4ePwxMvnfrbedCWGcOi9RX0frxKmTN5hi5W5USU=;
        b=X5g2aaMIyr7s0hWEnqyX2ZcQvNXltroMcQ3s/vej2q1V7KxQRfM4GXEaMjVmiCHGxD
         +y8R1vfLIDHe4PHlq97Yu9F7mbWpiSsLIvoOpL0FWMGE/CFcO2sEi2LCLgqnftyYl22Q
         Tft7flb5lw/GEN4poZ85wOVgt29Q/IQPpcqQ4Sj1TDI5sMcSYLY6uH5gu8p+ldoeN9Vb
         sbHwx1giRFbvyQ9sKvYG1fRkG5mPqPmQKniPOM4o6Z1xBXEZaYjDYyrseDiA3XxjHrP2
         xsM3W/Y6Nn1F1E4X4zeeObFUhcvaefx+w0sNI6R+9T+eBc6f96ibaGU2KOY+BKtNGv+n
         Whqw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0R3ZMTDgzVOM2v4FMgXCOeceAD00XUKm4NxhiKor6Eo6OMs8D9xTpV0slC8pB1VV2NIIqRD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VjMt8G1tP+F7KFyn8h3K4J56yv+O0TkXWQ7hnb1ebiaFQSpb
	kA/wAGEhx3RzKkyl6yOG27iglzJH/0EI5Ce0Fah9SZ9jZhc6jO2M7j1t
X-Gm-Gg: AfdE7ck3N8P5Qap/BawVV1s7gp/ikya7nE3YSswTRfdF6/BEnShjua4abOp/3uikMy2
	65WfU47SrilZOqKpbmhS7b3DJgkHVi8qIjnYy+CyoE7PvLdAoCIkGTV+OkrFYr3QmQDDnmS9CuL
	bwgsnEL7bcAakCaI1z0fJwuspGk/uEO4KTmcfJIY3CVadjXzAej8whIOR+bgz1c+6znu3gbq4Y7
	HxFDCdz7rDN6U73Rm78wVmXTZGMQsakavaIrA4I1/P48M9dS7pQGi2ERlKEVhUwYHKpm4k7s0Vv
	0Lo8cdYtccDBQTp27uiBkS0KrbSz3GUsA1qhGQYRH1FovYv9rpaGoMu2ghOlncoMubkbMplFl6+
	SpC2/QRSpbcMqFbAiNXLBaTNkYvUNflgfdeL3VIufGfKdy7wz+7Cd9zkn/LX3naBL9UcFcpH7ty
	rqGJ6W46Wee8cx1VImqx+ffMbbsRB5PiV54Twbehx520PXeiNreALwugb69SaO3uPYbEIfg2OjI
	FoFyQ1q6jBv6HIa96K6EMPlpk0aMP29eNnIePZXLrFn05fjNK2BqA==
X-Received: by 2002:a05:6830:4888:b0:7e9:cdf6:230d with SMTP id 46e09a7af769-7eda154706fmr1996146a34.24.1784309669083;
        Fri, 17 Jul 2026 10:34:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad965130sm1677212a34.11.2026.07.17.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:34:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 17 Jul 2026 11:33:58 -0600
Subject: [PATCH v2 2/3] mtd: rawnand: sunxi: describe tADL and tWHR delays
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-submit-sunxi-nand-h6-h616-timings-v2-2-225515107640@gmail.com>
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

The tADL and tWHR timing fields use four encoded delays, but the driver
currently derives their values with a shift. This hides the actual
controller timing characteristics and lets the clock solver select a
32-cycle delay that the fields cannot encode.

Describe the legacy 7, 15, 23 and 31 cycle thresholds explicitly and use
the tables for both clock selection and field lookup. This prepares the
driver for controllers with different encodings.

Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d12cbb3c813c..791f495f6e82 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -242,6 +242,8 @@ struct sunxi_nand_hw_ecc {
 /* Delay arrays contain internal NDFC clock cycles for field values 0 to 3. */
 struct sunxi_nfc_timings {
 	s32 tWB[SUNXI_NFC_TIMING_STEPS];
+	s32 tADL[SUNXI_NFC_TIMING_STEPS];
+	s32 tWHR[SUNXI_NFC_TIMING_STEPS];
 	s32 tRHW[SUNXI_NFC_TIMING_STEPS];
 };
 
@@ -1679,6 +1681,8 @@ static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *nand, int page)
 
 static const struct sunxi_nfc_timings sun4i_a10_nfc_timings = {
 	.tWB = { 6, 12, 16, 20 },
+	.tADL = { 7, 15, 23, 31 },
+	.tWHR = { 7, 15, 23, 31 },
 	.tRHW = { 4, 8, 12, 20 },
 };
 
@@ -1781,11 +1785,15 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		min_clk_period = DIV_ROUND_UP(timings->tWB_max,
 				nfc_timings->tWB[SUNXI_NFC_TIMING_STEPS - 1]);
 
-	if (timings->tADL_min > (min_clk_period * 32))
-		min_clk_period = DIV_ROUND_UP(timings->tADL_min, 32);
+	if (timings->tADL_min >
+	    (min_clk_period * nfc_timings->tADL[SUNXI_NFC_TIMING_STEPS - 1]))
+		min_clk_period = DIV_ROUND_UP(timings->tADL_min,
+				nfc_timings->tADL[SUNXI_NFC_TIMING_STEPS - 1]);
 
-	if (timings->tWHR_min > (min_clk_period * 32))
-		min_clk_period = DIV_ROUND_UP(timings->tWHR_min, 32);
+	if (timings->tWHR_min >
+	    (min_clk_period * nfc_timings->tWHR[SUNXI_NFC_TIMING_STEPS - 1]))
+		min_clk_period = DIV_ROUND_UP(timings->tWHR_min,
+				nfc_timings->tWHR[SUNXI_NFC_TIMING_STEPS - 1]);
 
 	if (timings->tRHW_min >
 	    (min_clk_period * nfc_timings->tRHW[SUNXI_NFC_TIMING_STEPS - 1]))
@@ -1813,16 +1821,18 @@ static int sunxi_nfc_setup_interface(struct nand_chip *nand, int csline,
 		return tWB;
 	}
 
-	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
-	if (tADL > 3) {
+	tADL = sunxi_nand_lookup_timing(nfc_timings->tADL,
+					timings->tADL_min, min_clk_period);
+	if (tADL < 0) {
 		dev_err(nfc->dev, "unsupported tADL\n");
-		return -EINVAL;
+		return tADL;
 	}
 
-	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
-	if (tWHR > 3) {
+	tWHR = sunxi_nand_lookup_timing(nfc_timings->tWHR,
+					timings->tWHR_min, min_clk_period);
+	if (tWHR < 0) {
 		dev_err(nfc->dev, "unsupported tWHR\n");
-		return -EINVAL;
+		return tWHR;
 	}
 
 	tRHW = sunxi_nand_lookup_timing(nfc_timings->tRHW, timings->tRHW_min,

-- 
2.53.0


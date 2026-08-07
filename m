Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44330473C6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117154; cv=none; b=IKHkwDPYVBGQqGdpDYJNDJ9d0fjgN90U/hDjnw6Sa0O+xpu9lxdfu2KgES1hzspGo9LrvskCNbqGj+o/oPiemB5+3C4QvSbensZdxziJDqMipfwmQLJD0HwEo+yfFSsnsaE+Bis56Oj1xXLCn5jseHwE8A14dPEOsr54FMmLEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117154; c=relaxed/simple;
	bh=GOAlpolOzUCQKB0D6s76EOdiJ4JtM3txEaAtWy2BZY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EfEgHHA+iaW2MSvDLRfCKxBwlrZ8gGGDxD05orpuex7r5uINx17dMjx4ASzdNkzQ34oPwZ8yTe/D72JFWBOnu3B1Y7FVDdwoJEGXhP7WqRmHTDgFQQewKiOi59N8mHPD2WuvoFAN21tpxSNoMnx70fZJT2ROURCcOmcZLAl+pZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkurR7EB; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkurR7EB"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-495b98b4f6aso1291106b6e.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117151; x=1786721951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LVBJaFomYnqSqtZwNfhU1nsKV+qCjSwKc3i+p0HPzM=;
        b=WkurR7EBHerkugX/Tds4wqBmECXuSrgbYXTtgRdBskDPTSMB08ny8BGztUEvYNA49Q
         0xea8mImZWBDJh8Ogz1MPum+V4Y6tEhRkoACbLUYLTruQruSgntQ0BkXJqV86AXsIw3X
         6DwLQ8xe9fD7QDcoGL6zYr8gbSOHEYSJaHtGEyVkhcyS+0HVQGBZVdP1YRyuQS6a1oZ2
         BbJEiK2REXcEfCm8GjDttUgRsoAwbFwKlq2FOitWteI4ZiAm5Wml5aC8RwmCNXbrSek0
         KDvWtKqd7wFECskdxdJEbHgSw86+GIkDKHCWEHRyLWx6TfCOWO42o+CK8KWaOOC9mW7u
         Iu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117151; x=1786721951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4LVBJaFomYnqSqtZwNfhU1nsKV+qCjSwKc3i+p0HPzM=;
        b=MlFOdIqE8cIXNsFrecNMwpf92aOOi98NDqXAUZ7yNS2bfelO4ecuxmf2DMG6J6+jB8
         mzMS7twxCBjHzDQ3OdHC0GCDs+7hRIOyPMErEyOUYn0DBVzoxEPsD0T6fRdfi3HYGzCM
         kccODbGBdN6sUbe3Kh+B+nh92Gou6flvpsFtuxvu+2LuKslEuxF2B/NJLwpXANrE2w1L
         BRkEzAc/GmvuWIknrKhVmeEwkUr39s+Y5hy8vdHIOGQGY1ccOMnYo/9kVTRiAm1h68F9
         iq/A0FZ1OFsJ+yuqDr4S4g9yZg87bOlKUn8UUL1ACvy85ceDIAZlyJTj7TwSoAgrhNYR
         T15Q==
X-Forwarded-Encrypted: i=1; AHgh+RrpzUsK3olLpxGqrft44AcC7oyQohh3/RTVATQljSZqVwLI9zYNPZ6KZ2OL/UZC7YImlzrcV+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS++kE9iC9NTxjlAVZ1MV/AN+rMxVwqhmO0A8yDaAJkn2bFUzc
	8DLMmY0oEcy4XowznpAqqVBDxgUD0lBt9oiBDfNH1JtM90RpWhSOi/0V
X-Gm-Gg: AR+sD10PWIMVnWosQxu+2ZpSMnXI9aEqUe5AoHP/gr6+DPtzNISWSXqw5lvT/Vkp0bq
	ELSkDezOBKMHfNUcKQFW16pmyeRPTqafRZ1rnU1Xg7rfuhW1VN2a7dfjJmOkyhZm18Cur07JRTq
	LItACvKVO5XUOCOoRf5PiVJnRZMJThcdXKbRNNX50GefW5OCdZLQJ7ueFqgJQQXXxyrz16LpbJ8
	tWpn5SHK5Y05cvOEixuvm0RXapUe6EhoSUomMQ/0dPqwOZnesh+GfOSxaU2ZAJlCrQ5XaxSGU4z
	iPXh3sM4zHZA4q04CMeAMKscphXtYQqr/R5M33LZNYWXEB4i7yZu+MOEC1MkAB+dYic6uBDezo9
	gFduVVmPlzIqZEjQj27xWdFSEUxn4vLzhQzxyj3ykHlVLbiQVUOLF37gii2z5GdTEs6/BKMYZne
	aK3JiSkGSjrLCv1EhEADXuSLM0lCvvCUsKKV0h+RSbIHD2HkrgrELPLK0xMoLB9bZhe5LVK6uE/
	o50BQvreEhamPGDvi6RQxhI79QiAIh+iNKeJZUYo7Vj/5URN5KdWgEFehLQ7ftGnnHz/dIY57kP
	0iF1VVhLKfvuNsAT/EQpBzvM01nWEpLhTlnEIdrIiQNVT/1qb+cl1v82S5efIhZzsdPyLXfyLs3
	hVNzNe9pbDOz4kGpW
X-Received: by 2002:a05:6808:c1ba:b0:48a:ddd4:d36f with SMTP id 5614622812f47-4afadf16e3fmr12514228b6e.8.1786117150933;
        Fri, 07 Aug 2026 08:39:10 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae706cd5sm7353485b6e.11.2026.08.07.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:39:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 07 Aug 2026 09:39:00 -0600
Subject: [PATCH v3 2/3] mtd: rawnand: sunxi: describe tADL and tWHR delays
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-submit-sunxi-nand-h6-h616-timings-v3-2-91287b543f41@gmail.com>
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

The tADL and tWHR timing fields use four encoded delays, but the driver
currently derives their values with a shift. This hides the actual
controller timing characteristics and lets the clock solver select a
32-cycle delay that the fields cannot encode.

Describe the legacy 7, 15, 23 and 31 cycle thresholds explicitly and use
the tables for both clock selection and field lookup. This prepares the
driver for controllers with different encodings.

Fixes: 88fd4e4deae8 ("mtd: rawnand: sunxi: Add support for H616 nand controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9885248c9b85..df52501c1285 100644
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
+					      nfc_timings->tADL[SUNXI_NFC_TIMING_STEPS - 1]);
 
-	if (timings->tWHR_min > (min_clk_period * 32))
-		min_clk_period = DIV_ROUND_UP(timings->tWHR_min, 32);
+	if (timings->tWHR_min >
+	    (min_clk_period * nfc_timings->tWHR[SUNXI_NFC_TIMING_STEPS - 1]))
+		min_clk_period = DIV_ROUND_UP(timings->tWHR_min,
+					      nfc_timings->tWHR[SUNXI_NFC_TIMING_STEPS - 1]);
 
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


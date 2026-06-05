Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54C388382
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690752; cv=none; b=A0+zyUlz9ZcvPmpMULqgkMZg2+4P5YPl3vpCLhs+GADz8BcVY9e8YRW/GgZDkixaAciJUsLI/jfj8Iue3bz4w5UJwPt9MW23n6KMgRX4vDeWgXsQrRkZHrTUVSi+FIRs1hq3SVPlU1IoRXdgPneY4eNJ4XjtdZflOKe7AtZNbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690752; c=relaxed/simple;
	bh=3+EoLxOX4bdQUndqS5N43k5aUc6u3qE6NwCEB7j7zJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQMoA6dCQNwy26k5zZe/krYSENgJQbEwU9OthO/iD/1wSq8yqLAg7ZPUtiq+rOepH1RqY0DW3Jt2OuzE1tv6TuS4SF3CD576uE7Gd2NugR7aVc/+BA1H6Bp9jjvKs+rcb5LAJ8ML7cT7krozXG6QjBV1kU1/YNM4PBPJvNxLXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D24oiVVR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D24oiVVR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso19064015e9.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780690749; x=1781295549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEynX1/cef0pndZEPm8gcDuGDO9NpbMBOZFQHs0cVw4=;
        b=D24oiVVRxDGLz2uS5ycdAbGhK/v8jpNwPQ3bq2wCWgd2JLyFHQzWyorXu+n0CkuM2v
         0tWgRp6F8z2wKTZMnjCVfu5aASmhteYDUGFUlEpQ0FMkqWzoEbId11jGJjEEvaJfqtG2
         jZ7N0ya5DPu3X1ra83N+w3xtzKJjfK6mAqGMFi3ZfbwvnHzhuj7QJ7cLcJSRMJmLjT2Y
         B4XnKLdZa/5xCws7ZBQ8b6FfTf/AhCpvq74glN4xyilLkk29K24IGnbrH18O+HmRweYy
         XqCQnTtf0T/srB6cA0NqiY4I5igCIk5SRnssghEqvSoxwFOABqTgfUm9IPk2Kod2tw6L
         Mk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690749; x=1781295549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEynX1/cef0pndZEPm8gcDuGDO9NpbMBOZFQHs0cVw4=;
        b=hjen3MUcIHY3j91h9Tt6v4ganYDtPOFhUTXPvUnuevOl60v9WXFJC0ywbW18VGUD8J
         DrhqB9rRrtmgZNn2BzH7kcAtYOmPJ8qgwhLxGsM/yY6mZEaBhHMiUy75K7FGi6zRwsb3
         j64FWXids9sGpVCZsFYcr2zGgWSDpKS+e+8PnFhhBAP3Pqq/YAWGxXnr402laJz81W94
         Ak8cs8RxRQa9s3CiCFR+JALbCTwDR5dU4fCOgBerrYVIc2tEODTLJqjadMugzFrN6D4T
         uY6BH3Lc6gQhexJbvlzPiImpwEY8KYePKIVV8U9aYl3ixO3VrXjMZ9HFrD9vhNwTTuqy
         NqEQ==
X-Forwarded-Encrypted: i=1; AFNElJ80xAsSm7Hrz5qk+wCNOWKTLE02gQbaJewrovIc+5MqYZqHh4OI8p7MRx03XknR+5rgJY41osE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWbhk8gdOkggLRhH34GfGEF5eQgAk47Z3JzpfiGhuK75BcLpy
	tb2H3+w1xl6wlVTqbHYGjwM2DwdCFx/jC9YK6FxFVcLhc+NASxYiuQ7gq8S0Ozy6BNs=
X-Gm-Gg: Acq92OH792i2hnTeP5D13j8tshWGK+5H+Rs+e+nd4GlWp6gwUBj7K9rRYgB4cebbcga
	s5wQCbjlDS0fyTnGy9JAhKVkVRfZWYKtgBtE4qzyUOu2nyRXZy7UMTIfuvjVolzglqyvsmY50O3
	9UQY2DJrhavCQyBOmCBs3KWx38ooh5GE2lEUeA4a2WkpW4JYAxrMFr9AWNledgjiouRIKCN1mgk
	u2bml1W3772MnWRADl9UQ9j9dswDcEudYFQCxSVVcFXc9PVjZhdppNfrgI3RaRuhXzutmj6rdIZ
	WwTSCq3MRQ4/y6MMIGc1bliCABsn6C4G3G7Fx8AriTSQD3S69G32BF57WnR0CHpcXURTv7c9Q13
	PoAuvU0HLZt9kymL2u7kwrNoTkYX/hvhcRkSS6aejBfBla26Byux3dH4gA6dU84xpfjQ7yz2VuZ
	bCp98DCS/4qW4HpNXQeFQHe1BVV5YbetvzMkCEt7Js12DrLWdCJb9tYvKBPVVtzbs8sN7bDU+Zn
	tyL/BkA3hBr4DOVdMXYDB87F28=
X-Received: by 2002:a05:600c:4506:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490c25c0bd7mr90063925e9.10.1780690749367;
        Fri, 05 Jun 2026 13:19:09 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm190533895e9.14.2026.06.05.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:19:09 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 05 Jun 2026 21:18:51 +0100
Subject: [PATCH 2/3] soc: samsung: exynos-pmu: fix use-after-free of
 interrupt generator node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-2-0cd05c81a82d@linaro.org>
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
In-Reply-To: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3

The setup_cpuhp_and_cpuidle() parses the device tree node for the
interrupt generation block via of_parse_phandle() and decrements its
reference count using of_node_put() immediately after fetching the resource
address. However, later the intr_gen_node pointer is passed into
of_syscon_register_regmap().

Fix this by moving the of_node_put() invocation to after the
of_syscon_register_regmap() call, and adding it to correct error paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 6e635872247a..9636287f6794 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -428,23 +428,30 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
 	 * syscon provided regmap.
 	 */
 	ret = of_address_to_resource(intr_gen_node, 0, &intrgen_res);
-	of_node_put(intr_gen_node);
+	if (ret) {
+		of_node_put(intr_gen_node);
+		return ret;
+	}
 
 	virt_addr = devm_ioremap(dev, intrgen_res.start,
 				 resource_size(&intrgen_res));
-	if (!virt_addr)
+	if (!virt_addr) {
+		of_node_put(intr_gen_node);
 		return -ENOMEM;
+	}
 
 	pmu_context->pmuintrgen = devm_regmap_init_mmio(dev, virt_addr,
 							&regmap_pmu_intr);
 	if (IS_ERR(pmu_context->pmuintrgen)) {
 		dev_err(dev, "failed to initialize pmu-intr-gen regmap\n");
+		of_node_put(intr_gen_node);
 		return PTR_ERR(pmu_context->pmuintrgen);
 	}
 
 	/* register custom mmio regmap with syscon */
 	ret = of_syscon_register_regmap(intr_gen_node,
 					pmu_context->pmuintrgen);
+	of_node_put(intr_gen_node);
 	if (ret)
 		return ret;
 

-- 
2.51.0


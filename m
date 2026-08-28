Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136B3BCD0D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895417; cv=none; b=hJxhsNa2+k0hHTYpBxivYAmy9KlA1Lnv0SKeRV4ywM6oHSbObIa/pPVjNcaI5ajwIVBTmdcfn89axVTwsyFncPk5h9xZN/h28scJ/ksuNFLOMP06s+RxRKEnRsiGAX2pMhB9w4BwFkhCNkZztC8dnGHAy3xN2ig37aEG7IbfxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895417; c=relaxed/simple;
	bh=h9WfLuWGKcerM2wWkrGVT+9/+JdZZk4v06cpnrS/zhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjdDvBSS1kfEiAPqyN7quC8IOwC9pok3Oy/Yucp1nuCW0aUPsi2H7qEyUzxz7MDqT2z1ncxfy2VLYl8MgMi0liIVQrWvlmiSBe0JL4MtV0RKzLnVcA3vzVo42Ami3G4MZnPvYYqaD77kYNTaRkQBegRn2Xd0SEYGVqdwx9fDctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCFHy8du; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCFHy8du"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fe89fb333so323628f8f.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787895413; x=1788500213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKnm9/fmrIQX/p3UdIJ0P7OVm8nkpUuAfCjDFGGmEKs=;
        b=eCFHy8duQqW9Nw6tj5JCp/3ibe6/kaiGlyks4jnM1AscOQS3dAHKGC3wsoJerLmUza
         Z4xzG5GuO//IB5ttdKsG4oI/PyWPZUr5EQPP7CvR6tQ+2pfuk3DIpT4P+/ixI73icmic
         5NiH4Vezt9iIG92QAd6rGJFLFumVvEwlm3mUPHNf5k3yTdldcyWqShdnlsLZMcNUkbjC
         +mA5ZxtNQ2xncn12YPgaDyiIqxgPGRGVqarIRppEe76JqnAtLHJQe4wLA+nLgA99xete
         2zLF+ekBKMzM7s832JWB3AguSWCN1X7/osZhwnoBBxxe05GYgXLh3Xl56YfMlZFNEVyu
         QC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895413; x=1788500213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKnm9/fmrIQX/p3UdIJ0P7OVm8nkpUuAfCjDFGGmEKs=;
        b=NGnuPwH8alPLtKovo6bSmXp3qZatH+Yn1V/MQVGWG5kZad6jg264preaQe9FpxGxLr
         mq2pfyvgD3AuuKjFav5L02MAk0gTaRHT21SMS1hHtnjrF+OAzNcnp3OtND3GU+y1K3k2
         rsMZjEl8M48Z+7dsXtQHOLVp5hP20L65Es1B9crlEY9ASD1HFJ6N3F6IeBRNBDWR9Dmp
         S6nqh8wINlmZHNL5zC9hr54vy3DI3qG4Wd4uUGFxHBjOWFfCciLK5ANX1XIb5XKcSsn7
         5IkZQwoggDyRI561vkqos/8UnVjBLtCoq20ysTsUer58myYiY+2YIwrcBdo5+bEKgapY
         Yl/w==
X-Forwarded-Encrypted: i=1; AHgh+RoC/Fd7UipzyEvEhIFRQ29ggwc5dxV+b63GmFNJBmr2VRXx5gQ1bs5OyTFvO2mdR8dIoPbw4OU=@vger.kernel.org
X-Gm-Message-State: AFuF++nFo8X5euY98yO4Oe9SKKWrwRWkOPT+85lQR8TmIMTrH3X4KYvV
	kw7kKak7HSXY7SvXvz2LWW3QAII1r7VLeeE17dRnHCQVrLL5oNvx4X0JokIAGD4IYXU=
X-Gm-Gg: AR+sD12JNDf1hDoxiRazTE9FcA4iB1B/1R+ojIpgvRfyJMKAQw2SNhcrlQACXVPrQoc
	UjDRT5nozFC4S2HklY2oUzgqFd3tdb2E5r9WBIAg7sSWHUFjmooLB4AVuN0d6cKCFE+gIb1lnNt
	VVMpn1ZFWbKMSKZ+fpkPGH7K38ueuYJU5zji0o1n4dlDrsLB6XLELzYxo/+RFXH/8K1dh8EUnHW
	KzJLtbtu4TqQBfZtxlG5KJlgZH6OBymlUp3S36ZgCOUFeqN2x2nwEG2ZooegO8den86Eypq3dCG
	ah0plPGSoMlgv4iCDXeFwr5vKCPofzy5ZTR/RcTx5B9JLWAkvHtaobJRr07sf8q82ZPfiQ64Vgv
	p9kdEsr925r6JzdUFafg5UXiUw0zkqtjAI8PhgIXyAcr1dqW1Ny75GgxqkjuEz6g7WbCw/KlVjM
	/XlCudqsroO5CnrJPVMl5Ji1AozQcqZ/9AS896lLzhgaLaeCNteJ9w/DuFRLDWcSEn4K/C6q+Fh
	5td7Q76XOJhGEfYmdeYkSxjzV2+EuhC2xAoyluXVfeGbQhlD67v
X-Received: by 2002:a05:6000:40cb:b0:482:f0dc:e647 with SMTP id ffacd0b85a97d-482f79f3328mr4351967f8f.21.1787895412837;
        Thu, 27 Aug 2026 22:36:52 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac4d0asm1410402f8f.10.2026.08.27.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:36:52 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 28 Aug 2026 06:36:46 +0100
Subject: [PATCH v2 1/2] soc: samsung: exynos-pmu: fix use-after-free of
 interrupt generator node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-1-06bce6107bd6@linaro.org>
References: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
In-Reply-To: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org>
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

Fix this by declaring intr_gen_node with __free() and removing
of_node_put().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index f5fcdde9750e..efccdd63e40e 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -409,13 +409,12 @@ static struct notifier_block exynos_cpupm_reboot_nb = {
 
 static int setup_cpuhp_and_cpuidle(struct device *dev)
 {
-	struct device_node *intr_gen_node;
+	struct device_node *intr_gen_node __free(device_node) =
+		of_parse_phandle(dev->of_node, "google,pmu-intr-gen-syscon", 0);
 	struct resource intrgen_res;
 	void __iomem *virt_addr;
 	int ret, cpu;
 
-	intr_gen_node = of_parse_phandle(dev->of_node,
-					 "google,pmu-intr-gen-syscon", 0);
 	if (!intr_gen_node) {
 		/*
 		 * To maintain support for older DTs that didn't specify syscon
@@ -431,8 +430,6 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
 	 * syscon provided regmap.
 	 */
 	ret = of_address_to_resource(intr_gen_node, 0, &intrgen_res);
-	of_node_put(intr_gen_node);
-
 	virt_addr = devm_ioremap(dev, intrgen_res.start,
 				 resource_size(&intrgen_res));
 	if (!virt_addr)

-- 
2.51.0


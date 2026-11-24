Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545474;
	b=EVr4Ew/VC5HpxYlziDO8CbjvCAvlbCRj5PS0YNySZfjr2mPFkv5CEv2jYEUoS/zfbZUF
	 egjzgM0GFAtyRdCWf7XSTbRx0/11Iu3MB0c+hAGm6AHxv25GoRrS3snWttaMKHPQyeqxF
	 ofBQ2oJSK6PuOQgYYAMWt79PO0ZNanDKPBlnLtyM9ZNflSvGP4w7CLTsGsVTWu2xjgjfH
	 CfoT92KW4xJSPjCDWwShD8RGXRMLT0b7cnLl0offPu+U01MN/qYgLk/BX8s/yS3RDt6D1
	 fdsnUuUNEUXbXsJTTmEUGC+HIVmCWiq+4nEXajn5qy3xUJhsXHPRO+X0kr4cHnTfRXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kdSX7Cc7U4dcagG0XSqjhxyzglI210L8O7SrXEG8/h8=;
	b=OSGcIa4/aS8trAe2gM5nMOc/PXE6Bncjy/N+pYNdrvN9zWc1U2dxSmElWPiN5doG7G91
	 R8foLOAdMeo+ZdvgRHkBVvBYV0PNJxoDch4PITNKaB5pckrJzFgDbALIQH1GtauP2tzjZ
	 BzEF2FwWTZ/FpCC+zaRiI1zQ355WY1DUvnDCuEhsxWc8ZbZdVAvq/v/aKU0/dkD5x8Z8i
	 zEHKXT3Cn/4MzPwIKEEa1vIFqqCP4q15tCQnyhDxt6Js1PzjpUWt225aZUTwss4llkSJT
	 1zp7gUEkjYWEv9f2csaI4WBbap0qmAnd1NwHG2MyhuYUOBnAj5qrQLoxLmEM1ZPmVkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MTL/x/9B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4675606A326;
	Tue, 24 Nov 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTL/x/9B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827AF1F000C6;
	Tue, 24 Nov 2026 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545473;
	bh=kdSX7Cc7U4dcagG0XSqjhxyzglI210L8O7SrXEG8/h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTL/x/9BSEZcZP0y7PFGJaNndr0D1uIBMiBZY8WngqccxSHwH2fsYzZOekr5NPh2n
	 50XNCPeumqN8+u0ykQeOwtgzq4B+AZAUe7oYTKTKb897nRwApEZOKwhnnyIzcdvROD
	 u3PaQ+jmE+gcpmyUOmFN35cXgehXpJUQSg8LDimIWph5Pd63gVzdR8Jlp1Z295iU84
	 CEKa4v+9j3aRs1sJ6ERUL8/KnncN6fREDHXyLbt8RcvpBbv4JUaVLurtRMYx5hLD3R
	 ns2wm81IL/68DtQ9DFDUYtX685/e6n9A+YRYQSWTuOWCO4/ztmH1y2yqWheGqG/tej
	 tKIf+N0hITz0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] mmc: sunxi: Use devm_mmc_alloc_host() helper
Date: Tue, 24 Nov 2026 13:37:48 -0500
Message-ID: <20261124183704.2394957-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124183704.2394957-1-sashal@kernel.org>
References: <2026112400-clumsy-mobile-79f3@gregkh>
 <20261124183704.2394957-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Binbin Zhou <zhoubinbin@loongson.cn>

[ Upstream commit 5a8af27596118f3e6a121059ac7ac8c299bee164 ]

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Link: https://lore.kernel.org/r/ee7726b1ea37084258a5d8cec67cad12473152c2.1748933789.git.zhoubinbin@loongson.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: e35e360bd668 ("mmc: sunxi: fix clock and runtime PM leaks on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 67e05d7000991..9f8d20be1926b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1336,11 +1336,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct sunxi_mmc_host), &pdev->dev);
-	if (!mmc) {
-		dev_err(&pdev->dev, "mmc alloc host failed\n");
-		return -ENOMEM;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
+	if (!mmc)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "mmc alloc host failed\n");
 	platform_set_drvdata(pdev, mmc);
 
 	host = mmc_priv(mmc);
@@ -1350,15 +1349,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = sunxi_mmc_resource_request(host, pdev);
 	if (ret)
-		goto error_free_host;
+		return ret;
 
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu) {
-		dev_err(&pdev->dev, "Failed to allocate DMA descriptor mem\n");
-		ret = -ENOMEM;
-		goto error_free_host;
-	}
+	if (!host->sg_cpu)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate DMA descriptor mem\n");
 
 	if (host->cfg->ccu_has_timings_switch) {
 		/*
@@ -1448,8 +1445,6 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-error_free_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1465,7 +1460,6 @@ static void sunxi_mmc_remove(struct platform_device *pdev)
 		sunxi_mmc_disable(host);
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0


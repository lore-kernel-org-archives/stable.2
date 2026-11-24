Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540648;
	b=KXKkQ6Te8jzyLV4xRr+XffaZ8/wbJjWrCwcqW0KL13KU8s/ATBb2Ol3D6cw5q0McVJIC
	 RNAAWiRPE9FZo0iJzs0TpuwZTfyz8LkYmJXXvArnZD9hQHTIwFgp/r/ZwEr0uwbfNwyoD
	 ev6UzT++neLZRKVCYT88lhSodlJRuIUTDYyxw7QJnc+Lqvk0T5bWU/FPKwu6KR3L+KrTI
	 EL2u0Mu9PvV2G9pgHzCycCxzoqZsToR6b6PPz4l0DCYWJhBaSxqZcZrmsnV4ADTUvYLAZ
	 4uT2paFVS0Tr2A//O4RbMnxetGcFUZTm/hyGXjX7xsG4xQD8w6SbiUnwByAwapqajZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540648;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0UUY+MjptFzuugSfQZ14pmIXRSmdlnMNFxjO8+xiH+c=;
	b=DVPF8sb1TkX/8qMRV3bfnHWYQNB34ySrdCGZ6A5/90bgNMTBYvKhBgLuoPBIm8a7fGxo
	 yFGixvF+v7CnBIgw89AG53yi7XuswKqB2R4Rzt5rrzHKeDy1REfLyAhyj9MxBpn4o4/Yg
	 cr8yDtSocnlsnq1ZXI3mXV+IfNCBWhVJAfX6Gsg5PInitw5H3KaB0CnW97TtN8wHE8eMA
	 t84soM/oiwkZKiET4toSrSJM7eEhi5aL/7wJrtp5tUMuPbsWxSmqxxbdsEtlPWPXRPVif
	 URdNz+gfwL6SSMBaRH0O1p6buDeEuHhkB30wrdaPIihHs0F/63zawmbTXCEL6jUT6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEi61kOa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C998606A323;
	Tue, 24 Nov 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEi61kOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1711F000EE;
	Tue, 24 Nov 2026 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540647;
	bh=0UUY+MjptFzuugSfQZ14pmIXRSmdlnMNFxjO8+xiH+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEi61kOacz2kPuwCsgTqwiiPuOm4Hq6Zi65nylL04w1g0QLiDxaYhZdUVkLdnnTQw
	 sTsW8pKSipasfEDPP1NHzwDoh13AM4v7dqYdjZq6R1QE+FClaWw7YUa0SoWRJMUEFo
	 YSu4FtFc2EIC3+f66uneIFGNbXStjOHkPLfbRyaRbimVm/9Garo12zYnFJ+zhj1e8Q
	 UVEb4WhMjp0Gfot+e37TaZxP/Muuq++hjK6sQKvH/IjR3ZsdsmBcXanLy/ltzc15Ej
	 GiaLOwMQdhRUC9Sve35FtIo6xTu0nNVsaXKmw+YH8GLxY+x5uYYbdRkJCG1wc+TF7D
	 rweIRt7EZBmVw==
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
Subject: [PATCH 6.12.y 1/2] mmc: sunxi: Use devm_mmc_alloc_host() helper
Date: Tue, 24 Nov 2026 12:17:24 -0500
Message-ID: <20261124171714.1789579-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112458-bloating-overwrite-732a@gregkh>
References: <2026112458-bloating-overwrite-732a@gregkh>
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
index e0ab5fd635e6c..cc7c8594a6cac 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1369,11 +1369,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
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
@@ -1383,15 +1382,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
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
@@ -1481,8 +1478,6 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-error_free_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1498,7 +1493,6 @@ static void sunxi_mmc_remove(struct platform_device *pdev)
 		sunxi_mmc_disable(host);
 	}
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-	mmc_free_host(mmc);
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0


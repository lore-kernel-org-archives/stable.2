Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434081;
	b=dNRnfHhlo0jjwJg9/ToIDraOKM0o7Upnz4Iydngn/i50GLmtQR68/lpm7UGkBuTFXWe+
	 1s7CNYBcnasMS8vWvTewCXVAhxYxfFDcwkyDy04kzeVL/zLkqp5+1WhHK+3KU8/vOLk76
	 WnKC1JdKxwIFEvCrCz75etfNPO7zSoI2546yTpLg+obS3Oorr1mBuwA44bagNyBEd597L
	 dLbhWXqIG8j5vggz+4S97U4OsPAd2gt2X39w/T0Sbe8W9b/brrN5nz3BvZ67PM7pCLIPc
	 xS9wr/siWXy2lJVYym9kOM0qlSsajs1iYzoKrPRPCP3l17oqYIynd5kvDpWgCKcCJ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q645S7MuLxtm0KXEpUvH/1fxmD22ftRK+Tq/SnA/0bc=;
	b=ImybDSiqFwkNsZKn4W/QuXrA2dgjhQx5Pa/NNcqTmjWw/mH+L0Yur9elteGV3p2wRQg0
	 EqQAzGPha+MNMNM0OJjFymMCxLueZOPaMMSRcdM4Y4aIdFpUhd5uRAmA7yK3gbr6B7sZk
	 GDtCwYMyw49KdqIZoIP485aUriS2raOLEpLQakJYVYFjc7ZbqtDncrL3QQBVXEC//cX6N
	 hCKG0jFynieYwOm6M78Rd+dhHDzkx/T2aD++ku4EerdIU2txYpf+aEVk735uQGob3RDvq
	 Au7jrjo7UvQ7trDpCxgcjf2ox3+pwne6P6IshAgRpxUBI+43D67u5dBiTnsMC24oKLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjkI+d2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D49606A334;
	Wed, 11 Nov 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjkI+d2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A211F00A05;
	Wed, 11 Nov 2026 21:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434081;
	bh=q645S7MuLxtm0KXEpUvH/1fxmD22ftRK+Tq/SnA/0bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctjkI+d2kHy1vY4LJPUexzsoO3/W30OnbdRDxZBFGqtlp61gsF+RCZB7YrNWZkV87
	 XP1+wZ25F7cbVo/6jna/9pRD2hNmuNjKyexW4AQgK1j7d1/ian2Dh+mevzQNMuAVn4
	 r4m94tcm/RVlz0ONFRr63MA+6mrLoq1+gIqntiVWeqEU2UKiiqDDhQVBc4sltlKDH8
	 Nzl2J/L6wAe4TzhdmXGAPYD6rDy99T8rlCiUsj6OEIiRfyWTj3OINzxGykeZDXfWb+
	 XkDrgao/Ch1hj7cG/LFtJBVinQuiY+hdQGssoERkl/T4gReeQ4nzBg0HzoXLigRmKa
	 ZsZt589PlMMBQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] dmaengine: amlogic: Destroy free_wq after devres DMA device unregistration
Date: Wed, 11 Nov 2026 21:52:43 +0000
Message-ID: <20261111215349.1983909-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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

aml_dma_probe() registers the DMA device with
dmaenginem_async_device_register(), so dma_async_device_unregister() is
deferred until devres release after aml_dma_remove() returns.  However,
aml_dma_remove() destroys aml_dma->free_wq directly, causing
aml_dma_free_desc() to queue work onto a destroyed workqueue when
channels and descriptors are released during devres teardown, and early
error returns in aml_dma_probe() also leak aml_dma->free_wq.

Allocate aml_dma->free_wq with devm_alloc_ordered_workqueue() so it is
destroyed on probe failure and after dmaenginem_async_device_register()
unwinds on removal.

Fixes: b84b5197e344 ("dmaengine: amlogic: Add general DMA driver for A9")
Closes: https://sashiko.dev/#/bug/linux-c216084a-f89a-48d5-bdea-584522d1bdda
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/amlogic-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
index 684121d13fca..791bd82743d3 100644
--- a/drivers/dma/amlogic-dma.c
+++ b/drivers/dma/amlogic-dma.c
@@ -620,7 +620,7 @@ static int aml_dma_probe(struct platform_device *pdev)
 	if (!aml_dma)
 		return -ENOMEM;
 
-	aml_dma->free_wq = alloc_ordered_workqueue("aml_dma_free", 0);
+	aml_dma->free_wq = devm_alloc_ordered_workqueue(&pdev->dev, "aml_dma_free", 0);
 	if (!aml_dma->free_wq)
 		return -ENOMEM;
 
@@ -712,7 +712,6 @@ static void aml_dma_remove(struct platform_device *pdev)
 		if (aml_chan)
 			tasklet_kill(&aml_chan->vchan.task);
 	}
-	destroy_workqueue(aml_dma->free_wq);
 }
 
 static const struct of_device_id aml_dma_ids[] = {
-- 
2.56.0.567.gdb80ae8cd5-goog


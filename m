Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196122;
	b=Up4wz0qTaqbsLWDIz6LmtO02SIoIrdCVtzUrLmLvixpb3B5zIiOiKO0UZS9wedZ4okbc
	 BXFOhVfc68egJGZ0Byvi+8njPG1sLo5ptXL6aZ46P688ZggmtCJXsgBWjCWwaCT+1OQe5
	 4kTKjZNPpNLQrC9lxlPHyyauKmRWXhl86LsAnwcCPNJzoqDmsyHwlm3GXf0KoOFrkG7l4
	 BvsfOEaCUwhsAWSsUSQ6XG3FWuQb0E23ofXQtV6G5FISZMiHf5GqfGQbdtNqcXAEaKl+O
	 LwjYrQPGNgRdK+eoAc87PkGE/noJ5IupXACSzNXdFCaIAauqEm4FCe9LbexZJ8pxphQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196122;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=1xpwcbGxuPT3tXpkx6Mf8RyX6Dzo36GFZ6Dp9E4sqss=;
	b=5jYfIg7EAWpk2dbMzIWtxPQmNtk53T6dxbKEq48NRfiPKtga3UVvVSns7NT520PE9Qh1
	 ODts2hHeZEzNemzG7SON1BcM4KCAu7x0SHlOofgHPqL7aGPlawURQy4t5WMnxhmsYs2fT
	 T1/iYj+kt6KmKfeDMuXUAMAfC3pN8xyX/aVK2xZExzBmgspw+pLw3n6t7xVyfWSYjzvRr
	 B677sZTuC3blEbKfJ7Htqe2IeWk/u87GXnuOeZ8ltONOO7mTDioR/5imGC3d44cavv1go
	 P4g/rBHKuZ2FeDBDLqX7B77UnEmKJUBRbMLgfHR6BryxmrlfAcPVdETbcKGhjiJol4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=di7sQHpA;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E260A2601;
	Fri, 20 Nov 2026 17:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A08E260A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=di7sQHpA
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5573c0ab8;
	Sat, 21 Nov 2026 01:35:09 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: Fix potential memory leak on channel zero failure
Date: Sat, 21 Nov 2026 01:35:05 +0800
Message-ID: <20261120173507.3923720-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1fa06c2dc03a1kunm78995cb0238b67
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEJDVkNNGR9MTUNLGhlOSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=di7sQHpAD8ER8mZMsdEsxG3xOKw3SToAXE/uzh+u0doycz1U3OG8GiwwJwRtNTGQseu8jgdZ6olOP2coJtXNZkfCoDmKRW2YYPs8seXd27n/X/+DGFagHzti4HydpHEnFlpL7BrqJfgiHKxpnqWvmm8DCutL0pNSEw57HBHjOIg=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=1xpwcbGxuPT3tXpkx6Mf8RyX6Dzo36GFZ6Dp9E4sqss=;
	h=date:mime-version:subject:message-id:from;

If allocating the channel zero descriptor fails, sdma_init() disables
the clocks without releasing the already allocated channel control and
context storage. Free that storage with the matching allocator before
returning the error.

This issue was found by our static analysis tool under development.

Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/dma/imx-sdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 36368835a845..9c0087b3b805 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2161,7 +2161,7 @@ static int sdma_init(struct sdma_engine *sdma)
 
 	ret = sdma_request_channel0(sdma);
 	if (ret)
-		goto err_dma_alloc;
+		goto free_channel_control;
 
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
@@ -2184,6 +2184,13 @@ static int sdma_init(struct sdma_engine *sdma)
 
 	return 0;
 
+free_channel_control:
+	if (sdma->iram_pool)
+		gen_pool_free(sdma->iram_pool,
+			      (unsigned long)sdma->channel_control, ccbsize);
+	else
+		dma_free_coherent(sdma->dev, ccbsize, sdma->channel_control,
+				  ccb_phys);
 err_dma_alloc:
 	clk_disable(sdma->clk_ahb);
 disable_clk_ipg:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


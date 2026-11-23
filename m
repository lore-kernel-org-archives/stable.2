Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461512;
	b=Z72qHdLkNo3Cjsckm25YnReqBBqoizTz/oFBqWY+LURfsAkI+v8qjEEsbVe+ixhkbCCz
	 9vhADY/UIortfj5E/ScHpwOqOJVBZF2+pbL1DBFjPdU7lduKcYedFQoL0I3czVYQXB6zt
	 LaNgUwcsCNI2rdYZn/766DcG7P3TFHiEpjc9dd+E7UFxfBOa7CqHHqhiAj+bH9ffnKj8s
	 BbBOABcacmxfHhjo/AhPO6MdyUauvaCvz6WKQLY+V/HGpM67LXyBAPyKXQ/vyy8Z+Weet
	 HfK67MmtyLnRyUtb90K7oGMH8RwQFzQUCxMlw+NQ+ml46ZNhn5z1LrcTNNwwpxcf0tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461512;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EcirrK/cjGtGC7mOsE+CtZxi36fUE03jXBnvwV8QOLA=;
	b=NhN5bXZxnNk0YdEIVmOxtuzl/3Eqt74JYN8PWQawLvuWqNiTXMVWSYaPdwsPVETM5mPG
	 CIlHIVNySelATWLf0xWmg7yBcKRc47Mdf9CQejXBu+OHo6Mmy/R52rRzOP66Jb4Fr4NLB
	 3JVmPPSAqQ8BF1ioJN2V39DSX/uQDd8TT+M6YURqnAB2LLG7gMdj+i+sgy6EQz+kvJwwb
	 AsafibxiZUMnF5ZKl/OdSFaNO+83hSjdhWK6g76Y0s7aqCjpVzryvhVmZWotc13Fuvcmh
	 EsVrB97vjsXtJB5JNuwSNwowwXOMlOnPJNfK5S+ntweNBVQm26jR6sQJp0D13UHguXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdSWY4y0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13666606A32D;
	Mon, 23 Nov 2026 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdSWY4y0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F31F000C4;
	Mon, 23 Nov 2026 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461511;
	bh=EcirrK/cjGtGC7mOsE+CtZxi36fUE03jXBnvwV8QOLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PdSWY4y0KQKlA4pK3EeLWNzsN93vTa8mgnFv8vzNFdDh2FaK3ab8oSFzaRHZIwNSG
	 Gn6ZbAKNiKtHybiEXFeiN3luCgGLnfA47BSXbALOWfZaY7jX28ZhOP+AHj0NtZDF5C
	 CxmdTX3dxVJtyv8DsnefNwlx8yJ3U/xNOyM9Xb7wh089A2ln9kDem4OHlkKaYcRxnZ
	 MARD0TCKzH9gy4wGYzzTsXsxZ1BOVMhRnOorOaalkCKrrsZ9viXAT2oIdBSCB9PBpp
	 muoQUAr83YAIaRaPiuyEMXcLmXrpvt4nRuGTUsLbJp3xmYfUtlVaEwScFB+uvLT0xv
	 c2NV7fPqrU8Ww==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/13] mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
Date: Mon, 23 Nov 2026 19:15:54 +0000
Message-ID: <20261123191703.179283-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
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

Commit afadb04f1d6e ("mmc: jz4740: Apply DMA engine limits to maximum
segment size") added max_seg_size clamping at the end of
jz4740_mmc_acquire_dma_channels(), below the early return for the
unified "tx-rx" DMA channel added earlier by commit a474e52c3109 ("mmc:
jz4740: Support using a bi-directional DMA channel").  When "tx-rx" is
used, host->mmc->max_seg_size is never clamped to dma_get_max_seg_size()
and the MMC core can submit scatterlist segments exceeding the DMA
controller hardware limit.

Jump to the max_seg_size clamping block when acquiring the "tx-rx"
channel instead of returning early.

Fixes: afadb04f1d6e ("mmc: jz4740: Apply DMA engine limits to maximum segment size")
Closes: https://sashiko.dev/#/bug/linux-1f76aaa3-099b-4ac6-b793-e11a71bb003a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index e398a575f2dc..71aa7930a030 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -231,7 +231,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 
 	host->dma_tx = dma_request_chan(dev, "tx-rx");
 	if (!IS_ERR(host->dma_tx))
-		return 0;
+		goto out;
 
 	if (PTR_ERR(host->dma_tx) != -ENODEV) {
 		dev_err(dev, "Failed to get dma tx-rx channel\n");
@@ -251,6 +251,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 		return PTR_ERR(host->dma_rx);
 	}
 
+out:
 	/*
 	 * Limit the maximum segment size in any SG entry according to
 	 * the parameters of the DMA engine device.
-- 
2.56.1.750.gf70dc682cf-goog


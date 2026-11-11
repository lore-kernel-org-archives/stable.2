Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434087;
	b=3RmsJZyQSK2bULogu350soF2/AjiLEEve34h1/J1cEczQDrd7YiQXkwhg9MdjmOb058W
	 e5BOU0S68HPllEKFCCk8SGdx17qr8rq6aEmUUjj1d25sr1k9Vm/YC2Rw+sXQLTBpCllDg
	 9AsUQzHX0BKFjVlXPJKAQPwrcTYGzpufWmqS8ofMAJQhd8QqtRxj89ro1Pg1eYafJqnF8
	 LPbU/ZCPQAsF65fsrU+FYhRO1Wpi31uDNQ+Gm+bSoNdChIyBkCPBKclIYRdD2o+udYYZd
	 Q3vpFcGmr/LatXL9jtS4Y3h4s+5Z62asHzOlSBdL4r9WE5fl8RuV5A+gPKvIBy1y2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gejLLrTfBndrVFvNROg/ZPGbu4H2KGtgDv4CLTI4h3g=;
	b=jRRC0FD3BrOyvmL5lzqZ4CDsNr8mfvJ38+D2v13CkRT6BnGxBBVYGaBP2VnTMgKtsf3w
	 a2q9/Dqmfq215fR4oV6UnjcpGHsE9CjQ+yFckJSCgvaFml6mWZLv1A8WVtLNxWFu9k8tE
	 ppHDe2gLYBE7g29T9kIHL1exFbjt8nNIFXnIhL4CIVqLjf8LhbWDEK1YPVH2IM3tAB/WX
	 0wo+0s94ayVOdfRYCuDruKU2LS2ZNRraPn4w4W1VqT/DwUDtHQdvWfvaaVZv6JHAPrfZx
	 Mh3Y2KJ5fksOqKLKee79CKpY2x7WZShAGqK/OmNOO4tStMA2yS4hMp+UzEY7fujGpgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3gauwGp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0C606A8A9;
	Wed, 11 Nov 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3gauwGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF7D1F00A0A;
	Wed, 11 Nov 2026 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434087;
	bh=gejLLrTfBndrVFvNROg/ZPGbu4H2KGtgDv4CLTI4h3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3gauwGpCDHN/FCaNr+1QgBxM5co3WslhN1ig6ATw2uvz56EtHPVHeTnnAxLkR9kW
	 eI4i353HHzxlS46hmpfg9ODEUI2K1k4G/nq2MP5JSvJ/fRX3Vrmci1lmQ36cNNCgUD
	 xcEhdS3uF49bKykYM0SEuL/sSoyoq+7yjhPGVX3DTDksqxVEFu6HTyFUYrMJJ3i+Gl
	 OLAkgAIrqJ1yVrHCMfV612gjgVgd5fKJxjJBPDtzvZAAdbN8XZZJNvdZdpkz53gFSQ
	 ay//jJDA8K9bpV9tOD52UkzFmy7P5zclqiUGBnF6l87aER6iYpMSSrbs2FoXFuyCZI
	 AE0t9buUmU2Dg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] dmaengine: arm-dma350: Query dma_cookie_status() under vc.lock in d350_tx_status()
Date: Wed, 11 Nov 2026 21:52:44 +0000
Message-ID: <20261111215349.1983909-7-lee@kernel.org>
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

Calling dma_cookie_status() before acquiring dch->vc.lock in
d350_tx_status() races with d350_irq() completing the active descriptor
and starting the next queued transfer, causing d350_tx_status() to
observe a stale DMA_IN_PROGRESS status and falsely return DMA_ERROR.

Move the dma_cookie_status() call inside the dch->vc.lock critical
section.

Fixes: 5d099706449d ("dmaengine: Add Arm DMA-350 driver")
Closes: https://sashiko.dev/#/bug/linux-524816d7-ed1c-4f2b-b4c3-65a7e8bb45a3
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/arm-dma350.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 52f5242ea332..8c1725588f1d 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -381,9 +381,8 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
 	unsigned long flags;
 	u32 residue = 0;
 
+	spin_lock_irqsave(&dch->vc.lock, flags);
 	status = dma_cookie_status(chan, cookie, state);
-
-	spin_lock_irqsave(&dch->vc.lock, flags);
 	if (cookie == dch->cookie) {
 		status = dch->status;
 		if (status == DMA_IN_PROGRESS || status == DMA_PAUSED)
-- 
2.56.0.567.gdb80ae8cd5-goog


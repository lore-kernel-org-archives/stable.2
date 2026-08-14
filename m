Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BA470111
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714188; cv=none; b=aTtnEXwfv6yJbm7VNFyNV/5bnwjpp6plQQMD4/bucXA0ie//4T0R8+cQj4wmhyXYiXW05b9LTfE3475ha0RZ0ncSSqP0x59TujT6Lpm58Mrud7MBfDr6Ncd5O7GUTbx3yTdB4kg4C+r7Ryf3GpnN8Jj7yes5I4KWVcik0mYiUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714188; c=relaxed/simple;
	bh=Z0VrxfrQOACZu83EOUXJrOYZAwJOj58+oO60WgCClXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKUXGUtl+yqReQQuNa2sI2FdmuUa2lgLCocqT3DU/Q3CuId7uhP34eM9sv3ilOra41XR4XBIm5v2woIKVyC01u+WRmthw9wlVJA2aEr0tLyjfIxgAEai568ssikdHOqk/Vehvdm0ReO9AFECmeG7LYGI4CCvhrDLjZqbPKtL6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io; spf=pass smtp.mailfrom=soundtrack.io; dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b=mkkNGFOR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b="mkkNGFOR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a18ef236ecso192413a12.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soundtrack.io; s=google; t=1786714185; x=1787318985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ctx57rLzTDeEjtgOib9aUyoQxqr6yVBe4ltDl2pGqk0=;
        b=mkkNGFOREuXai3iI7Q06uuOc15j2r4vG61uOPFAIYtI8yZB2T47KxbOcw4FDz6pTAF
         TaOdLVTF4M3XBR/FxDvITpIrIvbxrSjddeJTjUi0SmGKBxzeFmkJWiGyQC2QCD+DcqHK
         plsneJVBV5sS2+i/0lQc4HpVp0+qxwDDVFNb34/0mcCIhR7xfFroabVmxsdC+qHPRZpR
         N0+6UxoS3E1XgXZbo2NqUrcirUo7X9kcUB8SSkYiB4INVDDqvpnHJYXekpiHfcZ/iYqK
         zPcfBP3otkr1deRzp7sUuaIVly6D0J3xSuRU3MjYc5yAL4c6p2otrJ7jhtZ6kbV/2jOL
         Bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714185; x=1787318985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ctx57rLzTDeEjtgOib9aUyoQxqr6yVBe4ltDl2pGqk0=;
        b=ULejlWdjKQjnt01wq+VtDMbbPKt6J7dZmnf6KLJI1C/4u4ZhHy8ceJ+MLigbvgF2DG
         I+KryExWGjV0Y3D9QEa7YmjHtUUFQlHtcIZdOmDqCjixaZDQsTlZwYdqYV2guDVl1ddK
         IjhoJykqCDWTjTkGE4AGPlx+au1VeoPtZXuXYPYPBr25C2vZbCHxM7GLmDqwWCMhttJk
         gyx4ewFelZZ7NMfxD6IVCpOuGAUBvEvSUWtVII3OZVK5xKfTUTWcenKBQBJ39Cwq8huf
         cPUBdIHefXv/z1PkgVzbrnFh5UTLy1CDXobxlgYNTBYRhJ0xOBLmK7Yx0PWNM/mIH5eL
         9OWw==
X-Forwarded-Encrypted: i=1; AHgh+Rrn7HvjL2GITp+69UIbi4tLQNBi6w+r8YCFlwopjtqNmyGMsgG7A/ixxMh0xOUenLwJlUno3Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzI94gDMIMILhL/0GyOoP4pP97OsuRmQwPpp5XcW429cZ+r+j
	vz54bB6ccx+BOPXkNiRtgMmXLlxwlCDaa6TBurMcFoWBcD7gSYJdzPZqhaf2OlK8Dt0=
X-Gm-Gg: AR+sD13v1d88bDje4nVHpZ+lhQ6b2K8Y5hnl9hEJroybvkeYIqb2xjf31dzZSQI0ppP
	On2soNnHmWxyS0onhDF5SsBYsT25tEvd7IKDhnUn5xqRY7w2OrXTEKcB/6B9sNzX4QUCdogOYQb
	/M3oi1mJo7Ux7AYVGnzc8JZJOihaArWmV2bKt/vxx+P3R0a9uCYewvqtcIDRe9mV2xUUuSE7TKK
	9jzRitdvBwkOSha3higq9rG3SqDpozPK+wPzNHZGyVGRm9QXu4Hv6KmJ1athF6tOVXA9wSqrCE5
	bcEG4qMuGUdIzXPgu5UX8ELk9LbAZYeF2oChT2+KHIVbwRgnVoReQRT0PZ6DU1JqXvoWH+6til+
	GIJDjNl8KPq9WVCZx6HQ3fJEDYrsV5PDLd3IbKT9E3hFRkGYBCWSRE6wPO76RX4Wtw09bWqEWoR
	CI27cklR/Zrqzt3H1YvZLs4ErTddlomhWFoFJ6wOkO171PVHlyNN6JjGacSFyeLtLTh8e44SI5t
	n3kkXdJkvmv9SwKPneTxbIAcfmLdGwgOUkKEugv9cAgO7SS3hp8I+7r2Y9fy1yCwSg8
X-Received: by 2002:a05:6402:3881:b0:6a1:faeb:c519 with SMTP id 4fb4d7f45d1cf-6a38a97752amr1392217a12.3.1786714184680;
        Fri, 14 Aug 2026 06:29:44 -0700 (PDT)
Received: from Christians-MBP (31-209-40-223.cust.bredband2.com. [31.209.40.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9d5eb2sm841941a12.5.2026.08.14.06.29.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 06:29:44 -0700 (PDT)
From: Christian Lugnberg <christian.lugnberg@soundtrack.io>
To: vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Lugnberg <christian.lugnberg@soundtrack.io>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: sun6i: fix null pointer dereference in sun6i_dma_tx_status
Date: Fri, 14 Aug 2026 15:28:30 +0200
Message-ID: <20260814132906.70322-3-christian.lugnberg@soundtrack.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814132906.70322-1-christian.lugnberg@soundtrack.io>
References: <20260814132906.70322-1-christian.lugnberg@soundtrack.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun6i_dma_tx_status() calls vchan_find_desc() to look up the virtual
descriptor for a given cookie, then unconditionally dereferences the
result via to_sun6i_desc() before checking whether the pointer is NULL:

    vd = vchan_find_desc(&vchan->vc, cookie);
    txd = to_sun6i_desc(&vd->tx);   /* vd may be NULL here */

    if (vd) {
        for (lli = txd->v_lli; ...)

vchan_find_desc() returns NULL when the descriptor has already been
completed or is in-flight on a physical channel and no longer present
in the virtual channel's descriptor list. Dereferencing NULL via
to_sun6i_desc() in that case is undefined behaviour and will oops on
any architecture that faults on NULL pointer access.

Move the to_sun6i_desc() call inside the if (vd) block so it is only
reached when vd is known to be non-NULL:

    vd = vchan_find_desc(&vchan->vc, cookie);
    if (vd) {
        struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
        for (lli = txd->v_lli; ...)

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
---
 drivers/dma/sun6i-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 04fe1f5042e9..7704b016aed8 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -981,7 +981,6 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	struct sun6i_pchan *pchan = vchan->phy;
 	struct sun6i_dma_lli *lli;
 	struct virt_dma_desc *vd;
-	struct sun6i_desc *txd;
 	enum dma_status ret;
 	unsigned long flags;
 	size_t bytes = 0;
@@ -993,9 +992,9 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
 	vd = vchan_find_desc(&vchan->vc, cookie);
-	txd = to_sun6i_desc(&vd->tx);
 
 	if (vd) {
+		struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
 		for (lli = txd->v_lli; lli != NULL; lli = lli->v_lli_next)
 			bytes += lli->len;
 	} else if (!pchan || !pchan->desc) {
-- 
2.54.0 (Apple Git-156)


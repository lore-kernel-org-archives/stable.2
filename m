Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960479;
	b=HY5v5Er1SZWy9qG/5z6QA5k++Oeg24e3UY2/Bh7fD2dz9KwviRijFCQJgVWKCGU0XqnK
	 SFI/1dzAa/ohLqUvbwSw1uykuU+P/5MxRTuiYhO+A9kZX1x749Tw+dfJgeWXWuUA/fFwT
	 0OLhLQXgSacWCk3SogxWeqDZGBEAT0wpDo+sVJCnPjGZDuD3E5mWetVxrKeHFekqqio6f
	 r7SCOUUcn6n5P3xuDN4YkG4CNP8kcCbGLqMNCDcELcmhlIYd8aVZk+TBOasNF04VjkXJm
	 m7qcDxyp4lKf2QAGKwFVwv+2X25bdHoz0sz4QXFFI5orCFSjEytZBuBp92WI0ZJ9Exg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
	b=Z6ivENoJEIqNAK3SqAsiDv+Z+tNqvdbgcazd6tJSBcUWB129zc+vRgIPENCup7uQDrRN
	 B+qlf5rAhHZxXvniWxo6dOAS80Cq31mrkk3UuW7Go05xMVBORSLPKwnNFa/ywVZ9n6ZYh
	 mARmS5AtdbYeIFruCkHhAnpo1F3p2trriJ3u8tl/I1KON/8OhJXEHmzORd/1J6cannEmM
	 lVsBb4g51wSLylMo/k19sYsgVdrPk40QHphWCzqWPY8gIVt91pJt3P2E2zb9xZ9mOSqOu
	 GCVJnaSDxGjI5uqebJZZFVUuEMnkKU3YdHgwQ+UgFzmIUAUHILZ6sBoCEVqLsw9gAyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLUb2Ltf;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F703606A88A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F703606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLUb2Ltf
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a76f63b243so1173192fac.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960477; x=1795565277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=jLUb2LtfTCdiUt+qLSzNRLh3e6vtIXez0t0u5ZErLAm4Piwa4rdkjyp1u/qEfiJ0Ld
         n2aeZ+e5g7TSqDzvBPP+wWpyAX+nWKEKudMkqJMWAuYCJpRAnsk0dGNVHRFMHKbVJF39
         POfWEurkqyiwTLqiJtr2pyWolsPfe54o/pU3vDVvzewFPonzMSqPSMpERUFafhInljHX
         GYUK6c+mlIG/tsVFGMzVhqXzas2AW4S9Af5upcFXpj6bWSjNss1giv/k6TwmtWP7LcS/
         QHxpPue0n0gZyGOg9LA8WZR3N/sqGsfBEyk0AFVeoMqY+1vyDvy711CsO4IgkNgANccU
         N/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960477; x=1795565277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=0Th2FSyCFDVZmy7FqFkTdL26WeSqagd4udcGT4Ov70wxaYrDKDFox/vG0rFns7Crrk
         KlxcoAsDMSiUPux1pNIjUTRp5UWCfpAaLTilrk/PKkhC7M2xRo8usZjEb7U2ZX0FME8y
         Eut0dxDPT21ITxy4ztahWE74hC9EtHzaZQ2K0o9ACByp0ChhRp6ebio1R19teoQhf2jC
         Sk13uA6/0CTGmDvYPI6Q+oUX6D53PzJ56dn2jEzsTPNYJfmh71nvnOQOjZzXEQiwesGM
         eea3BTSgR2ZSr1mbSrCHQGr5Kjo4Kd8pg9ziOVhXWuf04MXLLkNomyKv0ANwqPMct7U2
         xEAw==
X-Forwarded-Encrypted: i=1; AL+hErFUQHpb5ZC6vKmTTIROcZcp+SDVLqVQyQUyJmE/+TFwUzgOJttdWST1uKa+tB/btPSyzQCB+pE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BYJFtUSUm+rYGAVrC0OL78TmbB72jj7yXU9loRn8Z82H4BRgm
	NB5wJ24aMLY+Xp/tO9h4rfoGb2iatB/naZRJ64a0exjrcGBAGlgfY6N1
X-Gm-Gg: AYBFou1tOwEBTLQrPoHf6x1IKmdLPMiVoCpxnQClf8uwfIY5LKRqkOKmyXZjtLkUDJf
	9a3vDyBgaLg/00xlq6s/fDe0JqyX3lUUxQJOhFhdva7agfIywzwTuqNfd9nrVSz1K9w13MSosph
	CsbEiPIvl/iBGrklfBfvreCMaC/RhvQtXWwLo4TEIb4nlX5SlkgEjcBTjtxN9u12WGPVGNCLVAV
	Nbc85vpouSccniapK+XTIkzL6ixTyc+kz7b44E7E3eB9lKAHAzCfW+9ZEO1q+4FBpE1KXdUmjVH
	t8P5nZjOyBJ1ZYRASiv16akkkI2o4uxoClSH8ICeVpY7XlJOYrgk8VhZGob+sF+hMHeE+YProMT
	1qupIRrAbKvcpz8TtLuF5HDoAYojHmfq2r9okYwUw7UewTXRGGjW9mZa8MBve6cxrIL9hsuNYbu
	1bIU5eHUNK712fVda9buwR7OdcFuQlwAyDmOMzjojzjguKWQOMYBc3GhbKg/GD3j3vdlt2+EaVn
	GRQ3KBgCuWzFcrNnB5JVJC2lrZc5Pz7edVcNDul37wQafmSwiZBXHMOGaN+kO1Z1oBnZjofXaU2
	MireoP0DDuUHrrV65EKaWjSKR9eKX0IVTAYWmqDbXB9qIiZQfOVeRtLzqaKPhX5tgTemLPsrXe0
	yVKiW7sTucInM+etaMvkvY727Ul6U9JNy+jFhkJgAJWRqSTvItUoYYuAXicp26zp6IXE7P4X7cX
	CvfPESqqQduHLadTs0OleGyw1CBazp7U0opXIzZDw2djJE0//nfR4=
X-Received: by 2002:a05:6808:4f68:b0:4fb:c2dd:c7a5 with SMTP id 5614622812f47-57740a52bfcmr1093436b6e.31.1794960477683;
        Tue, 17 Nov 2026 16:07:57 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:07:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 17:07:42 -0700
Subject: [PATCH v7 3/8] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-3-d5f2309afd72@gmail.com>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

dma_chan_terminate_all() warns when the channel enable bit does not clear,
but then frees the descriptors and returns success. Its synchronize
callback only drains virtual-channel callbacks, so terminate_sync() can
also report success while hardware still accesses the transfer.

Return the polling error before detaching descriptors or changing the
peripheral routing. This keeps the transfer resources available while
the channel remains enabled and lets the caller retry termination without
treating the timeout as a successful stop.

Hold the channel lock across disabling, polling and descriptor detachment
so an interrupt handler cannot restart the channel between the stop check
and cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 405ab9a78955..040c12d07db2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1185,22 +1185,25 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
 					enabled, !enabled,
 					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
-	if (ret)
+	if (ret) {
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	if (chan->direction != DMA_MEM_TO_MEM)
 		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);

-- 
2.53.0


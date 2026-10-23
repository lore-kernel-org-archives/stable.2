Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780965;
	b=aqbDEWMKSVDKPP0x0OBH1/giidmagkuH1+vdLAjszq2OMFLY8yNKCeJ7SQRGC/SX2fgB
	 TUcI2bAcKQ3GiB+UiKaw0tnZnR8fR2B0xyfwJ/s7hWwbHlVQstLwdCGEZ45LuQtaMnkHy
	 s4Br//tk2BbH5BRauOp2YcNOwyclRZhgfK+fB09plsY9dCE9E6LN2dMO6xixmxNZZ+6LG
	 1xMw6SFkEOigReNBOkqKQpH9pnyMgI4c2br0LadOGyIPj9S40McB8fWHsmw65MbhtHz1W
	 szQ6gkH/74oM9FOMlm80KIrfbC66RTj4h4IqVDn+ho+4oxU4CzTnRa/hI5E3l7Sjvww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
	b=mpMdcDfLO99wMwa4aeLPySoh4Q1gLpbg2mC0wura3Tn+ubN4a+7MMQA9TOb4H2WcNLDI
	 j8cpFr/DkV6RFoZ8VYvlNoGrkTVRYJPe9escls7pN0koD96auV6pv6RYeQF7rGk3U3G2+
	 szlTPHFuhbQlRoi/uTlc2rYAnFz2PgkgDEHVip0HsbXxTbu1pA+iP5egcGoUjYmkNBmpQ
	 RZe9t2tNuXdU6y3nf+Ek8vCyfmFxo47sfzkxYwnvvWl8eh6FcY1HZGWal3GazeseOOXas
	 Ww2xiCOTlps8U67F3Eu0ZWe5jJxbKjOIqoa6S0v1lNVL7ImGoG1ZRTCl23WWpKQoQKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=boAmUDgX;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBE606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEBE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=boAmUDgX
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-847ac7ccd85so736861a34.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780964; x=1793385764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=boAmUDgXp1hX3kYPRavRSDi/Dfdi4D7sJxbXiSJRV98P+/YkSgSgqCBpcS0U6Padpi
         SvIh4brqcif1qCnWZBtg07XkoDdwxPzxbBkUVU3kuG25SjJHJuJS9U5zRa4YfgMxvy3p
         NGdxuGXPhT679NodQEH7OlBovG7Zf/eaFaEYT161Tc/DVC3/VfRYH+a+kom9PTnL8jhR
         ik0k9sDWd7F8uten/xEGvLIpnM/JBq3TUVcMOc5T4WxRHwemMnVMAPOiHRgyAOxPlwZW
         JX6zrseRPIxDusVPtZsNREFYpz9+1jCtm56ROoYIJ5AkCh05eHH7R8ht6Rj2ED6tN28A
         RKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780964; x=1793385764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=Z212rLLAZ4tF8+lSPxS6YXPgbvsa2+8EoGHBdP0HsO0nx7uL/lnMjS4CXPQZnmqo+0
         bAUhE6KqYIvrpIppFFftEr47s55mfhXslEmE5EMI3fcce+pB20NDdUJqy9zcgbsJrazJ
         V1917YGIIjqsjNxtuhLq49MYCknLMZsWIKsXcjr9JaLuyP/58Lk9S7Jxnc8elQvZK8bY
         ST7cghttbF4MctZHaJ1AhqcqrSGWWgmn3xdxhFn7RBAbJ4jDDsFh/LWfSHNH9Er6F6Pd
         qRM2saGkexHOY3tnLVKXTUjoCNBBtvPOhFaLfjiIyitjPpPkZnXWRl/X28Q8qZm9FQ2i
         zEaA==
X-Forwarded-Encrypted: i=1; AKwUvBwo65GVdqNGSzSr8n9swwYR4aVgYtBKVkku26NJxyVjr3JJ8VKPbDYLY5uJuZwDDeYzUM18IPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFbo6O8Mw392kqRL3ojSLMN5VJ2iTE9LZnt/g6Y9EzOWAl0Qnm
	qn9vXqKl57Bqs//ZD+hH6KRLJUBIlLFLDuubsnMkKHrJt9p9TgFZGwnL
X-Gm-Gg: AYBFou3/p8mL72iQjpL8hdvdVJt4ZzD43NhdT7dL1k42gLHvcdv3ZyAqOziU61FaWn6
	R0j1TXrKHWHJym83BH4ambp6OjpVV5HzwMGd0ajyeS8/E5ARmxrVvo1nFqI8GC3eMFftcUREuoi
	BERK7veLhEABupHv3n4AgNZwBiwIk2iGMTyQej+byEYBX3Bx+MCxUaI/naWQEt0Du+tnGmU3PHU
	wYC5foL1+XWQaP2CpRnSVOz8tRIP4X5mV/JBEqcrdp039xijYgXu11exkVm3vup7qg6tXHzhVGc
	YbV0fCjRz/E7hC0YRMotJ9zm3pTysJQNef73E0dV9PmeSmLEWIOETJBGlNznzg5v58OFE6KFEeC
	mESCqpZ0nJfNUASNaUPsjF0DYKoMpkvSjSV3GJV0XMSKTLYDWDcnHZ5OqZyi+AReYSTGT5X7o2h
	SoxQjd4zdvbe9LrPOjca8q4iYpbqJxmOLAjSkiziVx1oDjYVifdlKuUW2KIe0u5QnQZVbQy15J5
	THWfp/PaJg5PenVv+rkUraqAjdjlQJQCjM8N7COSF79bk3fLlXDfvg6a0Nm+o+q5Okoyv56EhPc
	Zj2TV6vJiXfa7UIP8odKFHOv4XHCAd5mDVfBAGKzhQQsTpHisfEApJtABfJrNQFdP3/ZnLboTXl
	L/4ENGMVDnSXY1MGSGRvQZozCkuqRZVzH/eSdTBohfRPcbiVj7pTGi7X783+tN060y0HmUaQQqR
	OfBw==
X-Received: by 2002:a05:6808:30a3:b0:4cb:818f:d56e with SMTP id 5614622812f47-55c0020ff8amr68675b6e.22.1792780963715;
        Fri, 23 Oct 2026 11:42:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55bfe199544sm336682b6e.13.2026.10.23.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:42:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 12:42:35 -0600
Subject: [PATCH v2 1/6] dmaengine: sun6i: fix physical channel index in
 interrupt handler
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
Message-Id: <20261023-submit-sun6i-dma-lifetime-next-v1-v2-1-c9e07cc44bf8@gmail.com>
References: <20261023-submit-sun6i-dma-lifetime-next-v1-v2-0-c9e07cc44bf8@gmail.com>
In-Reply-To: <20261023-submit-sun6i-dma-lifetime-next-v1-v2-0-c9e07cc44bf8@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Hongling Zeng <zenghongling@kylinos.cn>

The interrupt handler iterates over register banks in the outer loop,
but the physical channel lookup uses only the inner loop index. It
therefore handles every bank as if it belonged to the first channels.

For controllers with eight channels per bank, interrupts from channels
8 and above are routed to channels 0-7. On A733, each bank covers one
channel, so every interrupt is routed to channel 0. This can falsely
complete descriptors for unrelated channels and corrupt their data.

Use the absolute channel index, calculated from the bank number and the
controller's configured number of channels per bank.

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[james: use the configured bank size and describe the A733 case]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 8752969366ff..9d94a37fcf10 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -603,7 +603,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 		sun6i_write_irq_stat(sdev, i, status);
 
 		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
-			pchan = sdev->pchans + j;
+			pchan = sdev->pchans + i * sdev->cfg->num_channels_per_reg + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
 				if (vchan->cyclic) {

-- 
2.53.0


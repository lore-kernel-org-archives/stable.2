Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471786;
	b=v/CQ14q7AsBLRaNmKjfazbSZ6S47IG2IVr5azpkjJfx5YFi0VlzuZYBFEg8FvoTOTbZd
	 HgJikUUihWPk3Z1PaQjB8Op5FGMz768zwq/OW3X1DJKG7RfBSm0pMVxVPqJ25rLKBUgP0
	 BORB7cFX0X8VkJm8v2qT20TD2Bc/nfVR8jWfixeQTJEBpIzjM11GgcBpSvqsYsC3G9Toy
	 xXXNhh/zhHetIeVkBxTRCn9v1euWAZH+rZ9FUqEh4zpZvAf8iA08AN9Le0vvjNj85mUAy
	 bRsWkkGBc54GpdrwWY8iWO++AF8mnZL/n1RXlXOD3w01WdDIGLilflO8VwVCG9lripw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
	b=Tr0bnA3DswuaZ9l6pVQccsE79F7+y5rhAfCnlFl+3dL2lYdg8HN85D2klotji38rgA+P
	 jQpX5ZOyG/DwqAQVckFiaZFn74CsejzCxRPIefW+x2mvOCzC70hjzvI49RtXQ0wGUl1bG
	 elJP1vci6qXcBhRyHhZVmRS5VZbfbUStmQNQRSABmDLWpPBht+90EsLmj8/nyZSkI6ZK3
	 pGYjuYHz01O1eZP9WPf/49lPqFTdyPsSPAMS3eshRSfA6BQTQaWIx04y302ioRD89ucik
	 BT8SjJkR2Tx7tvTHD4RaZZKo2dngdtcetSrYA7IvwzPZnKG+MCHmf3uBv4PACZ72DAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nebyfDoB;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD3606A89C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FD3606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nebyfDoB
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53dbe9b8d6eso523704b6e.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471785; x=1795076585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=nebyfDoB1rNHZ+Kch5TPoQSZP2hovXmtIfL0xayLYT1vS0/h66ZJWayqk7Xuzqpyfk
         nt/DFcQIp+EORJzLARh413fLVZFXMiLs/5h/M6h2DUh22cdVSswUuCs1I97M4ZhQBHrA
         NiRSCH6D2i3XgwxRyJhIyl8A+RMoecUVP3sDLzGwHceMYONiFm6z789t3Z/y37oZ/GRQ
         7q5A6CjAEHsZ33yKA1Kjr3kBmpvgFcCmyUEYZ6c1zXJZ3Am2UjVWuDiz4FERC1WOdPxD
         vummTuDZAu+Jr43hHftitntzuLeFhREiPL2qiLTOmCR4RL8ZV2vt7TU+QEYyB65Sa9/+
         c08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471785; x=1795076585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOVjVYWiGu1+2CTZWPQd/l37VMMlzCbF4uz2qUZJc8U=;
        b=EDShJr2jkoGN+iBrKMfAIEqiBIPcu5vHogxff23uiTYhq4yS3b9KMI+AMI9Fd/bfCb
         LnzfBHHIRe5wYEhoW/Rk9e9AQle0lomDV0F0ZMfRnKWklodTLRDEAKuK/e046Nt0Fs0S
         yOalpzlidBReQWZb8mqtKwrU3lJjbL9CoeVcFXBX4ssit78Ii2NUELX6Jmh8RQ0z/WVM
         bfMVh+2LF41WcZnk6naCXSlf/1I/zSj8fykWB7O0+qnZYBixsaV889OpjcQFLqey5ESa
         ajafzm6kM4RwVD10KV2m2aUcFZLGbgWYxCOwDunXDprAsrpMEhB4sJzmkr90sF42zeTU
         5g0A==
X-Forwarded-Encrypted: i=1; AL+hErHSSlupBvHWPLtUfVu0jWPZbr4wBl+axofTi/VIcrPCPPztrXGdKjg/SH68Ru0j7WfhtN8tqKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z91hf/Y8OVRg7d6xZniOj/bZUgqZnmy+kMC581SWZ2Y2TcoH0i4
	d4N1OvENK3LP1xrE0Bgiw2wd0x68DL03JGv5bQt09cxrh9f0B4/CwlKU
X-Gm-Gg: AYBFou0NwPKyu+7o3hbdfjEUqE35ugvXZUK/TIajgHl/dW7giqrs0spMxfTVnxQkyCc
	pHDU3Eoiu2cnTSVnbSy43gm4/gi62S0Li672gFnAwv3+aTaAhCJz1a/STkhy21zetv8UAfF/AuL
	2IDYnfVg4eoCfYpc7vYCBNMybwVq2KP19zl7b0hVQJqG5JHS7z9MPctjZSd5764f6onWfPVxX3+
	BmRIMskLDCUL9PvAh3fA2dpLAtTspy5IQDkXSdSQZv3zFeOhgYslvMSW1SZvv/1C032FOXDkTSl
	c7nzJjZyTajx7wpKMHaRktZj0/DNa1PW9n4qF31hV8qKl0Q/AgZbQ8RdQHyQtaDHv3h0WS953Gs
	VwH4tKQVrhvxOQYxwvvqhYXTOva9hzwjUnO8xBELFKwnRDXuzlW+MBxQoEh2R+9C0GrJeds/SOu
	1TRdpH+Hfm6Ab+glZOdRXfjTgDT5ynUuAHszFRl9XgcMoRcw1fY05LQx5oEyrqCshe6oyP3TVVE
	VwVWRDr6+h1EwHql1RQM+xdpg2B1EM3pNiu7aRWHfU6xkHgm+OyFMcWassif7wAb2nVX2FR4C42
	1Evt2BtxMKbayTjhdR2GzzoFT/j8mKjD0t5bnE8rCqv5oVdfpS/hHGVyVqtHTfSG1fe/rj9eXn4
	Ju5lPsDUad0Nq0yDOhn+DLheC8cjEMPN6MZpafvs0LceYk1QEobL19+WODaEZmVr6WKgwO3pGd7
	D7Q2UmCB4p3A2roUFxDkikNXXVMCS4W3tbKj6cqFSWzi5KrSAvBQM=
X-Received: by 2002:a05:6808:150b:b0:4b8:4703:db97 with SMTP id 5614622812f47-56cd86f35e7mr1457409b6e.32.1794471784939;
        Thu, 12 Nov 2026 00:23:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Nov 2026 01:22:51 -0700
Subject: [PATCH v4 2/5] dmaengine: dw-axi-dmac: poll the correct enable bit
 during termination
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
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-2-3ebc24b243db@gmail.com>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

For channels 16 through 31, the channel enable bits occupy bits 32 through
47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
the low word and tests BIT(chan->id), so it can conclude that an upper-bank
channel has stopped while its actual enable bit remains set. Descriptors
can then be freed while hardware still owns them.

Poll axi_chan_is_hw_enable(), which already handles both register banks
and the smaller channel layouts, instead of constructing another mask.

Fixes: 495e18b16e3d ("dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6dae63024721..405ab9a78955 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -28,6 +28,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "dw-axi-dmac.h"
@@ -1179,17 +1180,17 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
 	unsigned long flags;
-	u32 val;
+	bool enabled;
 	int ret;
 	LIST_HEAD(head);
 
 	axi_chan_disable(chan);
 
-	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
-					!(val & chan_active), 1000, 50000);
-	if (ret == -ETIMEDOUT)
+	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
+					enabled, !enabled,
+					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
+	if (ret)
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 

-- 
2.53.0


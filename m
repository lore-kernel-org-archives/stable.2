Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202048;
	b=a6CkTpgGAx+9fjTBUvU/fe+v4N+iu5SgjN/vUiVG37x5UL7Ql4EmXtkmhs2ks2YERn/D
	 t0uVCIymm9ITag0tvdPpDKI86C+7mG6HIOuQHDfYt/lKHE6ru8fct45IxmmfpOAzmvgdv
	 tmTEucRyeECGOp9+DLZHSWLgYYM7jKTacLJBEbHfHqRLlv+FpAlvK75a2gkG2o0S0upjP
	 xt7bh8nfxNZ06T0/QsxUdJvLp6+A8HAMdmlBR/YBFuo+9R0XFj9qOC+Nyg0SnR5Vb/88W
	 PUH3I1LxFHhRRT0GXHzyg131ykPKaNiH/ebsPrP8Lzk0uBNxEuNdRqrctT9h5FqJAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9b6+vzAhRKtQhjqw9swKPNAviMKOXHv6Fk81En8ghXE=;
	b=vxmX2JQMrj5kyIclfI3um6q1NNGNwNLL5Es02f1hI/ZdH31QW5XGwDpwivNYE2MjHwFr
	 hbGcM42vM25ig2/vgGo14xhRCb4MDYfdjAhO4cFlGvVDJcu+e32hasSns5h6ylIPdd6Zm
	 9UbsxaOK01qkJXkArk0ZGPHA3bCir3H/QnYibjrkEn34QoZSRMJeiDTG9z5up+lUWeu7o
	 TD7ENI42kImBnaf7aaeo43L4c0YCz0NT0JfieEXeKqMxj5/4VCy+8hGCbNHC/9un1fvdS
	 fYl3TjPYA7rpgPFqEZCtZbPewAc1CTbN31lrKpj3VDKxRyWgT10CWvMbe0h6qG7xGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQt3Sk82;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11060A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB11060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dQt3Sk82
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-70b875f6f13so982257eaf.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202042; x=1795806842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9b6+vzAhRKtQhjqw9swKPNAviMKOXHv6Fk81En8ghXE=;
        b=dQt3Sk82CrlVQI1D6TBRa7FG1VF7RHeczAxMoicoTfJCU5zL7183TFGDg3HOn9/kqb
         p9/Ro7a5AQAnTU+MvxP0n2PKBdhzSUxHjH0UYSFJjppsaziT/xoFCIUhjFrmk5I8qp9l
         egjvoVQi47XU/cTbu0ULF2sYaLd3ZHyykxwnNTaqU7ViWYsPBnSqIvp5jpIYCZF8Fa2j
         ZkzLkGrXBcO7GN/YEZ1TWHW2lBS8YFoyMtnhC5EEjLsq5gWk5c3gJXBLtmqzW0ZHio3Z
         C98QcPm1njJxh6bhs5Zlwm0TEO+U2tdHRehZkfO01IwgPnlSyEqox+LZtnJhASFpCoWA
         WEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202042; x=1795806842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b6+vzAhRKtQhjqw9swKPNAviMKOXHv6Fk81En8ghXE=;
        b=uR6beMdg+Xi/N26pRWBasFQuVR3CT0gcaZjnCUG817nH901vzaYesAnWl2eXBrpWfa
         u+aklbSYmCv74Wtfr59uKGovyL0rtkqNwbh4BsfqwZbrvAe9bp8pR8IpbXLkl9Hc/oWB
         CivNvXVeMwQoT4DKqGqRFqycb7qrlU0REYJ8K4302a4/7cIOWRNo+UTNvGlJfSMpj92r
         yFWcCl0q9BvpnXgZZ7W7LWui4f+R2830H5iynRJK2uCcvPoXrnVez5pLH/XwaJOWAw9x
         DE8w87+PEGZnDNXx30mDffXPOwnVO5pELxP5vOTQ+wa4phKsQHxe30wklTGfJAnm2bsb
         DvgQ==
X-Forwarded-Encrypted: i=1; AL+hErEwMfpd5JbYRidDeFfDP67NrFyGEHifIgVPAYtim+vHGm2GxhuxwgCf04LuTof6CuRZjCgwyfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U19Rfydjoq2N9I8hzZLyfhz0k1EBzs2y841l9zkR0EdCafLda
	6jI81fBvsE5AnWuPNyH8iYuKxMdrmXGOkZ5Rp7/ZP0CEBbd7bxJjGnA4
X-Gm-Gg: AYBFou1TF34KVEoQZwV3vwGY5xBghp7uUI+X3QNl32R5fYr9YUKm87489clKLoTWo69
	jRwsV28rEymdQL92iYIup05w+wVqaCkpzdVVYS6/h6xKgWNHgLjyBYQI9zCj9JfJxCe6wi9NSaC
	bdoQDcga3Tj9wcmFtVAVaZstPSeh8TR9CBZOD5D65BKITmaOPZFd1BYp1GFV3ffL1r3TgF+JUuw
	K/xHLC3TOR4GIIkOMpweVAN33YmmujUhDN+JWHyulLsdjCvb2GcfKXEhMeVo0XkbtfA6JdbH/vN
	lbWTrkeKQ7Ucp40t0Az6US3zYqVIewCd4B+1xN9U2SguYVYdNBzH0oWF0V96eIvkGqqeAa+LsNz
	zss5rnV1F66M+/ySzRAz98m7TvWa6xuhBM3oM7PYk/Qpc9UWjEGhOo99PblV4UzOunxBXesHm2+
	yoZ15yFH+g6EpMfoH7Yj0F9DTtJlHlPGe7iSGKg2uT3sLuLwLq/UG05y5ZPA90xKJ0CW1yr/Lvt
	dGGpV/jCaRmAy1/vif8bOzpBVK/LFkVR2gsaXWkAd5bJIXYkMjHxZD2RcRX4y7tddvb2MWm2aD8
	eYuUv2DOToXzaqJoX9C2HQAxe/j7H2BfHpdv12tZPXcTLw7nBfRqF1n0z0vx1TR+uqK5N8Iqo2R
	l/EBlJE2wPNPwtR7kCfHD9gaoFArHt1L8chL9nX1aTyWxTi1vz7jDrglkA45Yq8J75j8Q+PxZvJ
	NpsisCcDSEyOAKnn0j/0toZ0RTpXy8map3iZ/8miZ832vqc8T7bYiy
X-Received: by 2002:a05:6820:f021:b0:6d8:bba5:658a with SMTP id 006d021491bc7-71b39566733mr3401867eaf.43.1795202041829;
        Fri, 20 Nov 2026 11:14:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:52 -0700
Subject: [PATCH v9 2/9] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-2-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

For channels 16 through 31, the channel enable bits occupy bits 32 through
47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
the low word and tests BIT(chan->id), so it can conclude that an upper-bank
channel has stopped while its actual enable bit remains set. Descriptors
can then be freed while hardware still owns them.

Poll axi_chan_is_hw_enable(), which already handles both register banks
and the smaller channel layouts, instead of constructing another mask.

Fixes: 495e18b16e3d ("dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6dae63024721..f17a71183050 100644
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
+	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
+				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
+				       false, chan);
+	if (ret)
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 

-- 
2.53.0


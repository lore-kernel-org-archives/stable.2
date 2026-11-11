Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366919;
	b=T25QFfH2K80hi6bDiKK+yI+GmYCx8wju53YOoIJK/zrZlLK3u1Ce0wNpHdsADG5tzUJj
	 sQJo0zJI8jV8qRZd7ktHvwh0zjx1s7OtJoTfnXH6ItWZ6nX/gj/JZMT9MPW2RIC9lFemI
	 XROawy66xoYFon5i3XQRWOeUKxsnNwyV4Rtkfs+CVJ8rqmpEwd5g1Ew3h6QgjInlanciq
	 dcNsYmQasnzzMupZ9tecahVhXycTJXy/ARSJRPT1ERDu3dFNpXQBwtS0ggTeGh2fWTpii
	 K7n4ouhE9SgL2+Pfew1ky7yyY8/0rWgcuqJ4S7ktpYLqPZh50xHwMiI1uq3y2yLQuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xNfeFAhewK30cMhIlYuw1thd6KiIfjfyu0K7WwqCHvM=;
	b=tpgb+mYGRZ/hJjU7mF1mKSAcFiMqNSy4IdIK+y2HXueWOZJ7Ndj0dKTsi6jp8Y8uU/Pf
	 HYfdsPkeuRdSfcU0uBbvWrTuWWVnZD32rIAyM8TMq7NtJwV2/6jbCjUu8AYYXxCoiJ9Wl
	 EfPiDLMXvy9G9iz2XScW2qice5Xu/KKkCSS4npNrAiKIlnRuQ2ey2CHPDSzK5oLlXYgDS
	 vfngO3FUdUhuBGRnDBfq+UO6OdpRFEik0C4jxgMLBtXeTF6k9nWcaxQQonKxOOpdEBMc/
	 2AQ6NYI+yIjV3doGPBGu3wRlRcuZa6CiRX5OA/j3A2g02Id2ymLehee7mWIXBdx3rbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAXbaY1f;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD78C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD78C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAXbaY1f
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-53a448f86e0so1502776b6e.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366918; x=1794971718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNfeFAhewK30cMhIlYuw1thd6KiIfjfyu0K7WwqCHvM=;
        b=bAXbaY1fqjx39f3SUdMC2J3pHKYtYCin5S0DQBWyHTM491GWOKpa7aES29NJP9yUva
         tf2RSMf7dGOOraZFeDU5dfQYM+QMTwVy0cMCcEHtu0lzwEL1bK+ojIbZD3h7I2Echid9
         7zt7gx8EDSbmc3MF1I00A3jlVd+f47Kf6yCAjGzrdiPlXlNnD9fOmfBgLT2o8nGIClwH
         60IfHN82xaTGQFw0YYkBulu1uMz5z2VgIhWMtj9g9iljXWs14BIjPsx1YUynmzxm8geq
         G3okIjI6eQqio+aXcsoe7DR5r/Ql0tVhf86rDEf/bZG19lNkFaNmTo5tC+ZLbFqTFxKi
         gPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366918; x=1794971718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNfeFAhewK30cMhIlYuw1thd6KiIfjfyu0K7WwqCHvM=;
        b=fQZXW+XEjy7gUnDHDJhjNJ70JAlWPHCVTA1IreChia9SNdKkCDf2JGa4QhNgoeEdAV
         kzIGbwsga6nneXM8wrRzmliZI7PbPYmZbWRk76yi/y4Y1swT5CwJ+bNynomOOuRhkjSd
         5u/Szx2wFwsEKVE0Da8BwdG4NDx5ljb630PIV52tnbgS8suZ6tdrLs0Jogp3YsInbS4p
         Tijm83nui0u3Ctoneed76QRUbZsjrFjd0WSIjbXUwX8QfxSLBawH0t6xKqZtsf/kV0se
         C91sACBTk3J8OlzJogg5TmDNo2AyHA2iKPJMykPg4a/WVWjNO3z0kUmlgjMKTIsGwLPT
         q+qA==
X-Forwarded-Encrypted: i=1; AL+hErHBOnWAEAGL32ovnefIzJhrnLMARCwRXs3Kq9cUKaPz/nkg1zWS+UnYpYaTr0wyAMwwp0f7Oi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G5LVj7nM1AzX8G6+65tnsnRWvd9+87b7CFZgHmVER2CQy9Dyx
	4FF5AaaLCVVhaldIA2hAnJeHMF40fesnqVtHp3IvJGPLeGaz4+fNn0Qe
X-Gm-Gg: AYBFou1EEeNh6+AlFtW2+B5cXLjRL6P6Y97rYH0uR1Ba29gFOiJXDA4Omf6ctHPh1YB
	Sm2AKnw9wn/KyNMsUTn8slTKqOV64RIy1Aj72U0BadcV+Qu4tLyWK+rilPN2uuQrVgq3VPejtnu
	7En3giEcpZ90hs9lbsxg/KgF3lYQMWxAH1cfRn4c2qEms6z0++AaBUtquB4uWuBdD+OpUrXLpDv
	keKKz1HGnbSAV+KJAJz7rdZc4Qg8gYwd5aJo5hlgcqEXkERoK1oKXn9WalSYe7aA3ry9CU5LdFL
	0EMnh41L0eDA+aAzDF0VX9hFHO+seZ4fAQB+9m9ySbU/pv+GW64J0hisLAKTknFWVgiOjMI4R27
	/HDUBeK2uxzUS4QDv4U7UWembeuhTX3gwav9MbTm1IAX8zHEKB6Xus04dnY9eFYzRZV7TYyMVLj
	fb1DDfKyH3BaUS+MVyG3ReAdReO/2nLf6CkDHjk9gjyPILmN0EpayqalNGtC0Y3dWS00nTz/Qcj
	hRLd0SwV/exAsf6C8oVUfBhFC9zEBKugnCKnseDQmZ1SrH7UgkT14deNCQg125gameQVkVz5OTc
	FYXFc0QhXw/rLS1/ha8TLSWelv1hYYxie4n16OG2KoFNC1QRe0wobcBeNKRztoYQfTcdTVR7uiP
	UhgjLrfJt2lTbhL47Hoe4yWboGqfETc1HEK5quovmY6jDb/d1xxH/3TdJ99PQwstpZat/aiTRDo
	Uh+5MCcgCxdZuvr1I9yAeG5Xznr8sk2QDWTaB+m5/tQarM0VEBMkM=
X-Received: by 2002:a05:6808:1a10:b0:4b9:e88f:89dd with SMTP id 5614622812f47-56b970ec98fmr844578b6e.43.1794366917929;
        Tue, 10 Nov 2026 19:15:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm3999345b6e.3.2026.11.10.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:15:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 10 Nov 2026 20:15:12 -0700
Subject: [PATCH v3 1/4] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-1-35fdfba8b61d@gmail.com>
References: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
In-Reply-To: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
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
index 7520c78f55cc..2c2435c36ab7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -28,6 +28,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "dw-axi-dmac.h"
@@ -1181,17 +1182,17 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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


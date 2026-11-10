Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279972;
	b=4RZ7f5V0fqGEFrprRusg1P0sVG5unsnldZ90IMeAoAiS4RGPJy9wWlAV+S/UyEgSVOvN
	 VReIbU8ODlns8SiWelhFCubC73hgewFPa0CnHpjqNMs/OSnTDF5oTj397nL0OEjr9HLas
	 6tU0/GYEoqRgMBhJptJXSyLLyoYON2OEe1anISHR85UWV+d+ehHDD7LCy/6HMspSy2d/5
	 U3rYqDhdeirINlUReBCJvo6EZbmyTsGn93ZkFQkGN/ER7RMqhsPyyiXoKKhN14VP2AZQy
	 K90r7nIi/i4gZMEO9nhcfzy/p+ZRrOETZZh590dYue7ih+kagVSANmTo0Zel0fxgQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Ug8MJwHaWSiOw+BHVNavljfyb011DwYiwgVO7CXvMeM=;
	b=2oQLX07b0t4xqZflnhFyDfKGTO8FQVb2DRm0MHKzw66nvJYISys2G4wkNTgKrIxMcXCD
	 6AFoQdjl9TzQ0DSatTKA09TiZ4yw1TpZcpm+xXDakKsfjXbRLX0KztOfkgbHpw6+gK8F7
	 JOIOjsimINuyANi8lM66ia/+00EGf46zYn8Bryx0erMVGetirOmvATFx4PR80ufUTIXLw
	 6pZZ3EFVJWNWpfEW5E/6jGtJkHNtv33AFaFm39THwIsjA/67cu7JbIf5eEukQkcmCKp8D
	 jtXznQ94wbNART2E+wplUah85WBgwzF1aR6BGhsDvSEK+aMLrAEaxnUWEMsu4bn1FLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZyMi+v0;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D8606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZyMi+v0
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4932b13c4ccso855482fac.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279970; x=1794884770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ug8MJwHaWSiOw+BHVNavljfyb011DwYiwgVO7CXvMeM=;
        b=rZyMi+v0oKscy2pU4t8gYjWoNwxZilFVMTHC8+tcJcyZostJ591xlb+hLBeDrb/THp
         iYDmv+BfCrhxV0+XlJb6dBGMocU6QxVeETOJTDH70UInX1IQ7q5R69IKrYJJ2LmGXl9W
         6qyWQJcIN7QDkfSkj8OcKzRV5WR7qvMqvyyUUce1rd5q2KfBePo256DE2O5tS2wrB5YR
         Y2vzT6K90SQdl+ejItDiZR9InYP7ZpUZ01irosYt6PIIwjnFUs2vTEUIx2nMul9BlrIx
         0SqpkS7++Xapujd4kghet1dc5y/K4G1sxwXwD8hJY5cR7LiOwsa9tKwkr6VfyMjsS+gP
         PJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279970; x=1794884770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug8MJwHaWSiOw+BHVNavljfyb011DwYiwgVO7CXvMeM=;
        b=XptQAjTZalMqU/ssMao/WOHQMDmgJHAY82VgUPYyiXAduaKnzcHwfWKB3qiEkCx9mh
         lAt7WP4CqAUJRlbX1KP9OHpH7WX1ymDAgJvqgy4RX4BvsX6ygl14TcOQidfJCwWDDEia
         S0trIWrCXdbmSOGnJZBca5T9bhPp4g7iLeOIPf23r1dZX/rzplhAMtg3M75VpklN5XdO
         1RLd/lPcVJbAJzfz2NVElWq/5eHSoRri2GMAyXvuzd7RW19JTawNhBSAzHTTdmpzCUoT
         1AgyQVIgyHJq3633Y2eiWmOQH3FDM7fy8tycufbs4kwEaxrTlrUEeauw00Jls4a3c6dD
         GxVQ==
X-Forwarded-Encrypted: i=1; AL+hErE8rdi9IuR4WSOv2mOOSmvL2sNE8egsNuEVGl3eY//U+Mhl7e4O2jiIlNuL538aVP/EGqZM4Yw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vWrot07txtbJaIrYk75nuKA//6QgHy919RpAuLOI3b92l8zK3
	4Mc4Np4sUt/6P9i34cTBIUHfRKwxM6DuLbSXakQtMmzFtYgbp6neLUjB
X-Gm-Gg: AYBFou1JToWOrhvh+VBNgHiqcODY/bcAOHuiubnX9vUmZLm98JnJrAp8rO0OlA37C0v
	xnPHWdO9S1hFpsy3Tqex++iDy65GTE9T8Eckbctl37QAWPbboFWXZQ/Xg8ue52nnf14bJZxXHi8
	9NDwQd9uY1FuKhLCsxB+SUO3hwwsyZFDk/s8jPj6l/6+ay1e8hEzjE7X/Mi1ZcbGPGysdkwjGsC
	3P+NLVLo/C3xbsoasVmoZTB6JgENuchjojLmoiSIlL69byL5LmFAJ5AvB3izGbCP3qj+CzSF8M/
	KoM3SPpLkFRfD7Me62Ffi1FHeQ8xwnDfK9UYGGShPfEF0T4BBRhgBrs0xK4mhLqk/bTt1qCoGr0
	PileS1kN7vRURAVkkeLsrUyfKx4wk7EbgdcapFEwkrZgId4PzMv064KMLj5Emr1BvFAn6QqX7wo
	9y+CudwfssO67Icpx68sqMC9iQR20HioCPvbqRu9AgnLLTHZbyP4QbpXjOmcgrsAJs6On2+MNuU
	vjPlgY99cq5yyBL7BJgG4TzaBbIzizxEuFJLqn5S25hpC2TITU0Ct0tesENFYkt3VmROg2Ps6NY
	7gBhHcYMfNeef1eq2B5Kd4SV3D61GoM6Te13Dsg7FVyriBib2fF7X0MIWrMNj4j0mdALPBc+Z6b
	WFGWJfEiPdQCHUU/rCCV2xUteHB59t6/GjtxXF3MHpXYqRiktlS3YXY3wKeKPOIHnREf7ipgnJq
	SfQxCFFHcm/xHz80Kbcn7wuBT1XhUJPHpco4/cWUv7tgav5AcXZLnFDw==
X-Received: by 2002:a05:6870:5ba8:b0:47b:7709:5568 with SMTP id 586e51a60fabf-4ae225909a7mr825584fac.10.1794279970242;
        Mon, 09 Nov 2026 19:06:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fcdc93sm683389fac.10.2026.11.09.19.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:06:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:06:00 -0700
Subject: [PATCH v2 1/3] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-1-64adc48df793@gmail.com>
References: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
In-Reply-To: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..457ab9c47ceb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -28,6 +28,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "dw-axi-dmac.h"
@@ -1181,16 +1182,15 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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
+	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan, enabled, !enabled,
+				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
 	if (ret == -ETIMEDOUT)
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));

-- 
2.53.0


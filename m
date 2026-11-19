Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104110;
	b=4N0PizxYffV1hMzC3wEUgquE1cnd9kL8R0SwbGIE0S2ICfeHM0d5SHA91t5xKJvyTSaD
	 RvznTiXmhVLgxxrpQEcqXcdgtIZFAw/UIUlOQUW6CMrt7oG/wkn/27/4kT/QnJYACUjYn
	 gqZYX8fQK6V1MygsMiSgajVduh6jXlBH9cXn3qwpRKmvD2uLBz62o/M9brUCUEZgw498A
	 vUCg48DF8tDU1bNl1aCS/TaFmKihbC7JMFEPeREZ1CU6LsgZMOem3jUCafVHjsKcgz7Wd
	 wKDxP3JWBqDBhZ4ijAY9JLr2slpMOm7oiPd9b0NU6xtvwHrz711fsTSyDBVM8mp3LhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=el2MHIKJ5Z4WB+AKjBMobDh9kIZo/3FoYu2Srbuo7UQ=;
	b=elI96oJalJcxtuv86rDnlMZfAiEbIGowbb1JwSF/c+DeQ+ihanuJ9xNwkXdci1DwuQMM
	 WwZUp1Vfu7zMHtsYzS7DVFUtSDveDxf78s1qAGcjSNJ+Tczzv9Cqq1gKgXPVRyMa1ckSo
	 Wfj+S9qcJ7x5naKClzRcvigUrbftMff57RQycdbs5Ez7HbjLKPdjeD9zzOqtOELGsl3TO
	 ZLeT/dxvPy5g3Tmhv+1d/Jhl8Ku+es4l3eDu916+w43uFQsu9weEvEsg3WNhtXWHGZvA/
	 4wzzzODaP3T5hv24K8XXvTR2IBPXKAdBuBFSVzzRWbSvXLo6UIOUZzXVtPm5jZ3K68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvGCDrfp;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1F60A2600
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A1F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvGCDrfp
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b32daac9d7so7717577b3.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104109; x=1795708909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=el2MHIKJ5Z4WB+AKjBMobDh9kIZo/3FoYu2Srbuo7UQ=;
        b=FvGCDrfpoahEBpeqj8NmzdOQMhdaFuJ7quceODcNx0YXny7h8zwkwWyL0C4P7do4IL
         zCmpn3ql2iUq0GnCLEFJEz3iV4MUKxB6kTrHvQR7/VZwbq5ccT5vzpkFtzdB4Mnx5rWk
         CQzSd60XEAlCzXaXqhkp2QQoMSQRenDAporkC4rfdWocus/XgrsyanBan7ySVbrqczXU
         mOqrDZmiXAfwNQMgf/CUocIQnUPceo6I6berQEOcTjHDOt/5PvAQRRMpzvgfqotU9j/E
         ZnLZF51skStNaghZ6/DNqf2ihw7s4a75nPS7b+kR/bk9jttSMvZesaabiIn9ZiOFdg4e
         rj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104109; x=1795708909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el2MHIKJ5Z4WB+AKjBMobDh9kIZo/3FoYu2Srbuo7UQ=;
        b=SA5C4A1/aPA+jvQh+PLBmEggtAyk3xEheqRbN5K8umZ873M/5uZGE8ySHaBxDpNwAa
         PJVEEIaMcFuflEymehogjleJuvP84QNhFkgd7jGJ0Xlm3A6FV1jf9yrPkHXFgNhUUsQC
         Y6eRKqN+GcvAC3fJ9lF2r3dNrvlizRIO1FxZzMMzV5HGYL2m5Z5fighzUBplcAk4P/at
         maXYS7slY6bymooQ5ZpRqN7PAzfl+pMDqOSoBMQWys6AB95bCgArTX+hIOjCtbkQwpK4
         bpBVEkK3LqvQKndZYxpMIMgoicjvTwxl8wLUiGlBdawGYm5pxUUojSzftcM4lTorpBvD
         hC7w==
X-Forwarded-Encrypted: i=1; AL+hErGDNJ9z1RuosNp2m18apoKBa1eMe+XvDrplIATuXfN3NBpBdAtZEh7aYC3E9ccxXCGwoPKUhyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cR/Dh/rqASvGFbkceD4Ppt4HEYEQpiVz/mfkQiuf8W26mYKgM
	EM1VppazfNq87C+snpIzyUfLcYy+MHfdSPlnxp00zo7icboz1UTDYHdH
X-Gm-Gg: AZFdTZc3g88+a+E5+c87AZr9TB9jWW9/HjNW1/3vrTGFKb3+u2DswO9JbnVCJs4U+WC
	qCdtkFcDC0Dz2vFLo284GlppcJYLWjpU5VTYsm72n3ONT5ceP/J+rerPojeVcYmE+jAIB+l9nB3
	2Fzs/HRoPTRpRmD7gqKwkYV6R7jbVk4AVybtPCvPGUZshp2LwTX7kMT0Jn+qq3NQRweTQ+0va1W
	gQQJ56BPOFgB3DuE43aRu/pN/QRRUf8ijBSku0ofCS87y+LmM1Wi7epgY60pCxiZ+Izbbx5O8dM
	R6tvoKZN+woOp15JII/3/q07fzgnrIJ7T6tJMv/qJq6LkhhQKP/R1qbglVZKUtvyT1IVGh28uLu
	ULwJL8QdLB9sCJqkDqf4BbQi3hIUp/GXU2tTTnKONhWL+4mnuaS0jTrt51mfLEgsV7u/tpv60w5
	012mGnxWCOoGid47Br71DhCQeCJgPbBM/niSjRFqIn6/bcmdeV7qUE58SL3/jYYwiTXTfrpwdBM
	NImLizunfO5hB89ocjQgbnSoPuAXb2U6MHf9ppWUNsYbK18ER35LEx0FWhf6dxlYD8IKfQiAk94
	M/p3P9y325EQoGjbv1FqMvA72Q1VmngB/ovMaw/DOXdOSqLA23N50oCNvwKAdo1LjyOO3b1XCiV
	D7+ziXkPx95EWCQ/m9pSqLbZ5RunwU3Vw6ZdVjowOWs8sjv2esmECEQ1fse1XXc45kDfywm7795
	IMu59SG8dtwANRxt8mYVP7MEQ9YUyCecWjfBzQTyL3UAW56mMRU5g=
X-Received: by 2002:a05:690c:6983:b0:8b1:533a:e19 with SMTP id 00721157ae682-8b518f8df4emr5599467b3.35.1795104108956;
        Thu, 19 Nov 2026 08:01:48 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:48 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:00:57 -0700
Subject: [PATCH v8 2/9] dmaengine: dw-axi-dmac: poll the correct enable bit
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-2-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
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


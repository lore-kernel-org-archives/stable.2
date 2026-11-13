Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562604;
	b=AlRx5qbq1i9lI2JnWf1toSPDoPptxLBCzaa9XbvtasMjzJt3SG3JRl52BMhtH4yf2GXs
	 ZZz5/NrAi51B94/ONN8mrv9AfN2Ursi+bPAygMQT23+2R1ol+GQwGvYAvegW4ohu4oxD4
	 jY47XIvxW6i3IiwypG6pMohjyM7hHqba6sBDUP3U5FkESbbHrouv94ItJdyIJmtvhPc6a
	 3JeAmY/hunVFc/nlVDwFOyc1Zgq1kQM6Q7iU3OhN7GD0QzreG1f3Whsws+wTNcJMdiaFA
	 RHeSjfu9OatJSZ/uGqiNht6MVzc9LcnoiOLbpu+4NiM8h+Lz5YMSwNQ9+fYbf/sRqmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
	b=HzlulhyjEdpS5BLpMO3ObRsp+dishAr0EiNFdc1ZeuKAHNNOCxdP12tCOj+pFYjqiAEf
	 yuNY8EsUI796r9qTyaG9jWIo53r3yzfcYneRxslPgDnbEXOsvYW33ieYqGf78ERlrbTQv
	 T4Gx+PUjOZljQqJ/OnfmdhPZAav6O7d6wC4IIj4vwjyxs4YtN0/7gmkEtVO/Rj4q1u9L6
	 c6CyxQyT7TbM3I9TwoJ4miK9K0Dsaxc1m6aunqDLVWx58AeIBhMPUjnDz8eyBdPyo+933
	 /Rvpcf3lxzp58rFHMkznxJDh+ekNtc0IqKHxP8Cr0D7S4/XnFBDoypDCORytP3n08XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFsdNnnA;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA560A2600
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDA560A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFsdNnnA
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8253bc5a613so894594a34.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562602; x=1795167402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=BFsdNnnAw50iv/2tI17cER+y/Qt1fRUQBLRsCpXwAdoxuI0H5AiXutsT3RUW8Izuiu
         vkb6AQj84uUK7iYWj0QhFelllh0w3wTUnrm4QEaBe3lXU3nlpag3vjaZhAEuaoiy2XAh
         uZf8d+owfYDmZv30Yg8O3nuL/HjaGEPMwj7brszhTxyUTqAx/+zph90Kb98Dp+v7PMV2
         fAHoSESvSG7YhOFcrCcLbm7UBK04M5xe+WjjTlTVcB+d4D0h99altWAUAwkf1bPDcXQA
         1WBvxhWITRjpZm/GBNfBTbq415akf80peMST7mumMxcgDytMUs+fab4uwgut18iBmakD
         YeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562602; x=1795167402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=gxMKLJFxAi9/yZIbbU4Yj2wW8/nYtwHa94bd8r3tpkFCSCyahI2ZaNSVmexRLKIdJy
         kJAnc+oP6zcBHx+nAGtb3lAogiy3KNAtFf5j1bo+6jVoh07zi6H65lHoVl8Br/X5z/j7
         AKYmocGd0mSV7+U0VJMs86kWq2GZshPqQHT2xEum8v+CZFtccHZOkoV+PLBdUh8+0uCw
         Z4mkJQfnFVw+1uDHCl+ndi9VexRcnJxEfIVeAxh6OPJecvxaVkuCdFQjY8sXKTRijL3R
         rSONFF35Hp0krAQf5E7Bdc3Lc9L7VR7vborojK6AxxBaDkn3fK2pHEUYOqNGpDAm0vme
         eW5A==
X-Forwarded-Encrypted: i=1; AL+hErHEpWn9EehSiXu0LGVuq/zSyufWF2usd7z2JcGVmAmORvyuIkv/hP0kTgEslrUgh/sKBj1Fv9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CzhlG7E4vJc+aWCSxuKR4P/t/0v+LJTzmDrZ5qDS7o2qfe+vu
	wjX1t33JywqpspqD+K9SvhqZiSHU0IVElgucBNHfuPfK4E1o2l+DimnM
X-Gm-Gg: AYBFou17hmA6BSXxLkU+XesmIXqk9uvbuWty8fnTruQyrdrGJlu6xbE4op+5noVbDZw
	BueXMn1+nYPuRbf96EjWXNiiFbDSvAuRrDtyGHs6mRSwBfttHtjkF8G9pW15+IcnVU0bF+zQNHG
	5PJT6Onxi4NzhOD+RXP0dhAutBA+yhnnU6w+ZnsoYzp1ixwsdglf1/6w9LQre5+irMypZfpmBXQ
	uUro5PzlzrmKVIbDk9d8sVZuULoPTgH1mDk3cRarvRhkAIJlGqYLdDtI4lOp7YwQk9Ugyj6SbQL
	4QdA1h05uePhzUMXEqrCxObOiQnUbx32Pq9IfRIClVU+/FGICVBCZ6rNGWx408FIQf4foXcPAOl
	weJ95+/wvvockV83TSEctaNImDRYULc0jZMfFHWGL/zfvMAcGByIVH77eK3GtMOjBNAulDM8QcG
	svfoGTTyHAyYQMNwPPwZJweURhkZgS2NC6gOIj1/z+WIMLuSct6OHOOjQ8E0Lno/x+jOY7VAoEz
	M36cd6DjvhHYH/WrO4g2SdfJTafmgCOUB1IJR3e98kvjJrb8X+E0MWbUzFZ2l8aXaMsOMij8K5p
	fGqgDUSIJeg/rVHxjtbGNfUutmPlB6Szaz4QM6847pMWZ+l0Dv/CWS96qsmPr5knbldslalKOYf
	juQtTZvkCdWa7GHLX4wHUVrlwl2//QEBV3C5tC7jqvKxOweaPoWFei0MS50m5OK+289giqcYJIY
	vQERZ4FkdKSL9NpmeZZ+iQxKDbn4dzSg496eJYmTwTtU0Qym+OjKSGn1ZkLc0PCozB4Zzfl/WyR
	g==
X-Received: by 2002:a05:6808:f13:b0:503:8f9d:f11b with SMTP id 5614622812f47-56e640cffffmr1509542b6e.43.1794562602641;
        Fri, 13 Nov 2026 01:36:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm1627607b6e.3.2026.11.13.01.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:36:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:36:36 -0700
Subject: [PATCH v5 3/5] dmaengine: dw-axi-dmac: retain descriptors when
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
Message-Id: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-3-8523a27b5788@gmail.com>
References: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
In-Reply-To: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

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


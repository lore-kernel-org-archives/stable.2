Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104116;
	b=n3DolOJdA7tJG9pbcHV71Ebjx6zkinBZ1ztUuc5w4VJ4RMxFL7c0EzQidiQOu0N7kM7D
	 kT3j5rSRVZDn1FGHJ15oZYJHPTzxF30fCd4MBEt4vW9EmGxgHbWghxTvknnqWJD0soCe9
	 Io9eB0yVE30uFH5yXszYG760mYaBrtxJSWWA7jzdxONxlJpEDn9TM7FZKp5ImOn8EocwI
	 WsGOGCAtiF33LpxvNyZ0omfGCmgTPOaAae3KNcDpReIRNB7/XUndv2AHcaDh8WwasnFwm
	 NwPpQa5LFTyPuPA8GOBoNgTFnT7OmQo/p6kL6ugVM/hvu1WGTRyibUfYaxqy/fc/EBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mYHbWr2Lm9koLQ90cthmFtpM1NIs5yfnk09mZGH6U0A=;
	b=OIx8eUxmumeGyr7zzJuzCfJuUx7esShFjaAFptkk0yfJQz4ZrIX/XiXcUXt6EQsBbIb9
	 Q1VZN+a9+elwLDjAkg+VAmYN47oZ7WkQvifeBZRF2ogy5ydNmk/+WgoZpix/h5tiIsz2H
	 D9+f24zvhZQLoGSUVfw0PkAY8MipbUoLi7q0PMAo9BO5aMN5xdmdSdYayzeCOvE98AW9g
	 bAzonxx51S2TZgWzCyO5f5HYpeCyd0Nf884htRnz8NBOoHzxUR6wiJrnmG+yjrYYV8TrC
	 mQk377USAbC4f5GrHD1sHB3hpqCvAG+R0rCVw1XK+8/ljqtGHDoOop1sNamhpc4uo5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzEEcQnO;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323460A380B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A323460A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzEEcQnO
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4c685c751so20799517b3.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104115; x=1795708915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYHbWr2Lm9koLQ90cthmFtpM1NIs5yfnk09mZGH6U0A=;
        b=HzEEcQnOI31sexECRROkUGPEd4VFZeHrnhrS1/ASuq+7bKJ9WQfd9w/kiUwOlycBsg
         wJdkJYzZ3tHSASmimq882ku6AewZUZFAqAYCBYPuY50exnlqlDsXv7BWngotcbdNeY//
         XiD5uFBC2q4FbfuhSW7fLBCfl8wnIJI6BqZGeHJDpidp6J9KSlhBcs9i9/35Qk+tMQWQ
         kLI+tJhyuA2jdifpcJLJYFzFPY6GuJumc4wvNy9IInlS/0ERr5Kc3fi5xBxua01/ogvr
         ZGPi3nj17R//hagWaXpS390EdUytkSh17ylN/cSm+ARmwR42YUNcLH63mRoX/RGu6DHW
         EGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104115; x=1795708915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYHbWr2Lm9koLQ90cthmFtpM1NIs5yfnk09mZGH6U0A=;
        b=HLLgawxLruIK4uOY9mvdCXQ+FUqLJWslwLYd+ApR0vOtGxf5WDnOGxuCLVKFvN8a3s
         M/Erx/PWJ53G1MM2ELPzPAM5PTHZLxkWVDuLHbKLEmec1mJp5M2avj62wopXLaJOq7dg
         NJrqXjeGJ99lha7qUSkd0Y05/8la6L1seKIxiOMnUaOzmeJPSgXeZJ2AMqigeByXjhrn
         ueNcEcfyPVWXxjohHybbSdl0rA9jpYL8VJGzMghAEd0EPSQMch44z/5bTeEPbWU1zzA+
         FMyEj3xMcMinRLrQC3mvQwsDdPwmejXaTZ0CAE9ILokpsKCqm0AQRZxv6WWaG4cea30k
         pUig==
X-Forwarded-Encrypted: i=1; AL+hErExmREx6adHnH0cFoF/3tcJgco9b3u4OwjbX9nDcxF8le7pChGEjJLPQTg0gO1Gn0imosNKTI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Qp3eWCwOtoeh3vDrxMCnhQIrV1H0k80FdyEvYeY82kmo6aodm
	D4dBN+SCkDalFr6ynsM5bQtSbwS4L2JeGfNeoVAOxPvf91Kwib2SyUFS
X-Gm-Gg: AZFdTZeGe6BC+97xSOxT1pUqNJiR0njPw8FuIm9Spm7v+rwm1j1HQT/+RH9VQ56ATsp
	iX/euCDUWkMXHYzW6zTrZk0LFTEpmW8B26pO2r8GN/FGipoOO2M6On64E53+45UOnYDxvfIrBN/
	tpcQyOn6nGEEHj8QyXn0aHwI2RVl+w+G5ej8E7qu63YLJOb5WDZL/Wi5O5wHqqHw/ROq8eyy3nD
	qJTyBveld6oUA+JSpm5aSISKP7gaQNJcDOrTJ1DCWA86KfuwCOGtg7NRewUKHnfsMGOYKYhhzUI
	Jx6/1ToDS3NruhwLYPtup61dUIl8+QhTdTynsmnMbSg1/WFKV4D5mF7WfS5r4eGrVITAnwb8hL7
	smXokAGY5drVD0xb/8cOHF58oepbV5TsY8dMMg0LqLnulCTfCp6E7aPXEbrneEtkZLpO385ayAZ
	Jx3TbVwyr7MGjLc+JI3BZ+jPLU5Uv/kQK4+bvjTfHBQ3LjNmQPqB7uWGiU8vrPXOp0q2AR45rhA
	T2H/ksdzEQ2PL6ArH8UNnnmRXa5dMKZGFqA1YqD6UZb/bYv6JtLPkiI8BM5m/Qq1bFI9yJ6I8YV
	hwB8p3jBsckn69W+CO3G4cPx7XPI4m+/fL50qioXNmhanh+UYPCxpO2VF8e7eL+WB1PI2nwK7TS
	XNd5WDo6ezl0VWXPY8+jWdf3ZfjmxOhuxbOGmbnrq6Fe/xDo43q1d6S7sLpMCCQeuCHrkVOiDw6
	f31C3uY4rPE/8Mg8Ej2ncpiNVgX+m259G7v+ir0T5xNusfHZSN9/znBtXiji3UxGQL8I3uopRE
X-Received: by 2002:a05:690c:650b:b0:8b3:2d65:2c83 with SMTP id 00721157ae682-8b520435671mr866647b3.17.1795104114474;
        Thu, 19 Nov 2026 08:01:54 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:01:01 -0700
Subject: [PATCH v8 6/9] dmaengine: dw-axi-dmac: retain descriptors until
 callbacks drain
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-6-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Wang YuWei <1973615295@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Termination frees every descriptor while a pending period callback can
still refer to one through vc->cyclic. An executing callback has already
cleared that pointer, but still receives a pointer to the descriptor's
tx_result and can use it after termination frees the descriptor.

An error interrupt can also move the cyclic descriptor to desc_completed
before termination. Looking only at the head of desc_issued therefore
does not cover every pending cyclic callback.

Use vchan_terminate_all() after stopping the channel to clear the pending
alias and move the collected descriptors to desc_terminated. The existing
synchronize callback drains the tasklet before reclaiming that list.
Descriptors already detached onto the tasklet's private completed list
remain owned by the tasklet. Repeated termination preserves the retired
list, including when called from a completion callback.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Reported-by: Wang YuWei <1973615295@qq.com>
Link: https://lore.kernel.org/r/tencent_C00D995A9F70206DFD1330DCB1222EEBCB07@qq.com/
Reported-by: Mitch Barnett <mitch@accuratesound.ca>
Cc: Wang YuWei <1973615295@qq.com>
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 99b648d4ca76..2547f9596ae6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1202,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	int ret;
-	LIST_HEAD(head);
 
 	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
 		bool enabled;
@@ -1219,7 +1218,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		if (chan->direction == DMA_MEM_TO_DEV)
 			dw_axi_dma_set_byte_halfword(chan, false);
 
-		vchan_get_all_descriptors(&chan->vc, &head);
+		vchan_terminate_all(&chan->vc);
 
 		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 		chan->desc = NULL;
@@ -1234,8 +1233,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		return ret;
 	}
 
-	vchan_dma_desc_free_list(&chan->vc, &head);
-
 	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;

-- 
2.53.0


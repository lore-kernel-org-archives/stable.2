Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960482;
	b=izturOEYuI+j/XDIS7eDkqBjsFirBGkMoJMnlJQMKPlVFXxClY8RD6VSHE3qYrd9Xj5s
	 25yE8WBdeFW5Mkr7PPk9UhAOdmef0H7yEYBQFOaZFCKzVmNG0abMNoVGeAbBa5X5QgPE6
	 XAvADPOG4RsQpBhJ7H5fcsAhjBlXNsGuIZjCe6ESExQ5hBhzvPhc/gOo0OA3A7siAP7yc
	 kmKiBBaHmIg9EXgxOg98eVv0cqeA5C5FXW+uS8pVkxLfOWm4qA5FftXrzF9xrwjDl5DlZ
	 6UsLXJA2fXhtci16+iMcm6tnPwPGuyWc5D6WVyQV7skE537BFmVzIarQcHSVS1gmhrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
	b=KSnzQSXZOlnwh+XyZbPZ+Ed4U08eg0H9NfixSvT5/SO0QkmGkaX7nKBkz2I0uViMMH8q
	 HIFvqOGwI6hYjc2VaYRZMfcXo64Bvm6vKgSaooU+X2GFpavhlPoZjUkLI7dZI2CUg8BKt
	 GfxgUPor7xxkJgXwt0JutiJVQOfrJ1ZhB+xrX9YtivY3sCuImb/phdsAWGF1bDHZMyCBY
	 OdEK2YFpYny+qYdiInRPA/0Ewl8SIXcRV6kX8QKRH2b+wK/lU0DIlTJKj55HN/X0I22Vn
	 HrHPcM+XSZDZqe0ffKN5Zy5RNzo4od/YpE0YYXKxZKvcues/XBwtFNoqdlyWLM3C4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kixrYyYk;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D6606A8A1
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61D6606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kixrYyYk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f14642adb4so146862b6e.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960481; x=1795565281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
        b=kixrYyYkKrlOhQUpV7Bbau/38e0d9V4iKAMOql8QUSA3egSSN0joWIRF83HrY1O4kg
         wj6ICoLrnHb/G6xt7SNMZPqazbcfErGjFUL/tRuopwFGT4UKBBtZ+szlkdWU4DiZyj/e
         F2HeY9fEvrrvvgukTWZnoAnliGwWSPMfMQ1tdZM8zGXiPMAPxpxrSDGV2iTF+hiTXtIe
         y298fgM9+rPC9lFhlWEfyQi/4ikh4y0YJpbivMTIkf4SE2d3UHFnFzTPRl8bR5oN0ZsO
         9NLtwNS1vPpDaHM7qMwLaES6RhMunNluxNSkMaTWDXGusG6ZpLPMVdog6U1HinXqdxZg
         8MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960481; x=1795565281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
        b=oO48+fmV1vyMxGj3H5Po4xNZSJTvkkNA3w6Bl+iR/82xiaua/U6iUeot0FCSHiqDl3
         jEsTZzOsswciLgjrH/fMBerua+yaiOsvMRFLmfzIh3mvDVpwnE7cZzg+IRbbgyHvubE3
         2mDNbX4eOvmd1v1QzueO4+jGEJ4AMEPE+QI4M2c3C/xG+g1+cZAp+SHtCKg4VEeW6CqS
         I0OXPDtcENcTRDAkroRVr4M6amHli0qSDzxLEq0mkiwWIDHCB+rAqdUqWZIa25fsVs5o
         GY2shx34cPd2s9o8gCQpPp4pRmynag2whDfTuyngU25K0CR4kRciIJw2ImuMtGv3O0ZT
         VwiA==
X-Forwarded-Encrypted: i=1; AL+hErEFPGAY7g/fIAcUNNi5XdY3c1OsucfEFV/BW/dlU+ZdC2kvA6Z9+4b8rU7wMdEMNKH76KGZJLY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LGRAjYy+mJ5GBZN3UCrIHG7bargTd7YQgKV8f4xwIwJ0/twFT
	vtBg4snWhFcNo9dGxtf/oievRAn97aXKP5wovzXn6rMIgR/Mw1QwMmy7
X-Gm-Gg: AYBFou10lciDs0MxwMoEB0wOzE0HIXEfR2IESRstW1IygC73bjuJdxxf9YSshTIr9T1
	3aaJrLk6FsWoIND4alzWpynRi7g3VE61bt9mq01+Fp/4sb+YDGRyzFvyfGG8VQFG1g/ZknrYY57
	sjvyrj2RhTI5HF32kzGrZPRVyO1BOLEq2enDB5OZDUquGJG7oh8CtHXN3T9aEuo0zv1qi9Qa8IP
	/fTXy6JSqgqKoqXW/3QY/sUs6ofcPC6PVKg81tRmowLaze8tcnHiQLEBaBtzdXCujfEmaMg+4g6
	COUHeBSBB1QMEjhg/VUMGriaxKyCXFT8JI3208Bl5UYpY5eLW3mb9YWUukxuQTVqc5BwRjAH5TA
	4RgsMr5I+QyZ3Zj3Ih6JCRgE5hwodZrnrOtGWC0O2cpaFOGMmlx/5iIN1B67OFKTE6mtPa0sIJJ
	0MUGEkU5eC+nAixBMoQ/wg8FSY3w7EnQNWnsv4JoUYN5IN/McKcJSUfyqfrUFOR0BTyrLpqeTju
	F5J6y7fohc892uWi1CMj9wwDAmZ25h9pK+xiiPcuFPHOUEkvMMDbWD6tWH/B/P/eqHE4MnQUfp2
	mfhXICyaup1aX6JLcYtN4AYJRfsGfBdbaSM7xrtbrTGMfFzVOEisPZ0Eh7knmspJvDa1WyOvMeH
	oARv4IQQTIrV0kX7jBYP5mRcnzs84MA3BxGTfO/oPR/Hgx5jpMWgwNn6LHdsMpZ56sl0wfsxhnw
	Zh8qIHnc+eAQnas7BddiC3A4peZw0R2G6wNkhkN+S7hu3kvkjRdzg=
X-Received: by 2002:a05:6808:309c:b0:574:524d:f252 with SMTP id 5614622812f47-5774143060amr1944911b6e.24.1794960480831;
        Tue, 17 Nov 2026 16:08:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:08:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 17:07:45 -0700
Subject: [PATCH v7 6/8] dmaengine: dw-axi-dmac: retain descriptors until
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
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-6-d5f2309afd72@gmail.com>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
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
index cd9a5b45d295..97098367535f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1203,7 +1203,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	unsigned long flags;
 	bool enabled;
 	int ret;
-	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
@@ -1224,7 +1223,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	vchan_get_all_descriptors(&chan->vc, &head);
+	vchan_terminate_all(&chan->vc);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 	chan->desc = NULL;
@@ -1233,8 +1232,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	chan->cyclic_restart = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	vchan_dma_desc_free_list(&chan->vc, &head);
-
 	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;

-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744786;
	b=G6Hb3RS2LLrectDWICUe98nFh91fVVxYrzNQSl2xv10lohYjXkxboclQN6ME1bD4XYHb
	 LaidGPUknTQV5Yzp1hPqm9DqK85lc/GsimlXPJYXyc0+gDd9lcGL8sXuVtJOwTqj0D1+8
	 70WxnGwMspkMSzfuoTKVvllqNFY2xJIpbqZ7teD1pJx+Gg+599vmpqn1W4b0GVjyTwHuU
	 AYJ3gSV7ez2eTpMkw8WYgRhjPyTlac4uSZcSkwGkVNH8gZ3Bt+oBhKU3WJzYuez7okXEt
	 OGCiqA5HITvEH29lejZOV9Y7jHE4ZRqGYJBlgXFEkl1LbAjIg0m58AGqQG4rjs3JbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
	b=fy9/g4zsG0fu4O5NN0uCSvP7xRCxXRaryRBjF9o7Bnf7Ug1yn7VUQuvUXgyMMbVWtnDy
	 ZaTH0Kxuq60nCulphhDe7sxJ4szJOjRhy9Fivui/Qk5yQCuylXeIoUJtn5c3CL528+7Ht
	 +aveaeJj/y2ThWaz3Y4WT/IuAq7kI2NfMjQGZ8dWFlblzDJi3rPDg/cqmFjpk2FfNMf3P
	 a2BB7POAfy6m+rtZoyAKMEQ9znZDIlO8V/ZQ/JQdNGgN3boEOemAeD9NmJrY94oa/8WY/
	 V75Qx2WYTqa5W+hX1zO+q2718NUGB0SZTtqsFylMehN6NPjT/lVsUQ2XA/aEEx+EZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhPrm8II;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF99606EEA0
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF99606EEA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhPrm8II
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8479f46ecd8so24935a34.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744785; x=1794349585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=GhPrm8IIBrtjPnVeqbElAzArzQ1IWq+ouDe7FcEjHnZV2NsRy4MCfOjR5Vz29F+p1C
         iL5Ul3vDwGGwLDRQ6+I7dZD6LaZRCt/2Vynaohts9U+h0pKPumMuQwZsjf8am6/LepD6
         iwPduU1z5CSM41kp33QpRUqd8hijDNbvoa3EudiVfF0ZTYvRkT+PM5qPNSA7ubHT68Yc
         5m97VSgKccvzKqzNZaP1RocVUnbbyPN1tCayy3BV4BukpBra6IFZsUN8Hjv4ijG+MKZ5
         2ZKlbGHmVq8QKoqJQFr4cNTTU3VKq0+LC0PXqxpYAkpWRVgY5voNHGomx2nkiOE6xDvv
         A9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744785; x=1794349585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xV7K67o452vhJBNNJkVqcceAfykbkpk6Y6a+s1Bbb0=;
        b=qnv1MpORZuCHON6XQvn9HDoMkuAipgkXj1Zep+zZKVhmCr6sHgthDfLX7+3zQt+2Zd
         mmMoHIuE6B3vlZJxt27ngpR0Bh2QvJCUvqmiDb4ErS1VJGsmAozUjoRWgUe1Ls499sX7
         poBfqpAEC+5O8BQNZ2k9FyYHUuqAIYrmIaT0ar0m2jAF1Gg47QKUvNgrGiyoLsQPGHZn
         63DQFIg44gnHgXeixh5OLrVr/uuzU2VfnnVxMC/rpYqK+BN+EToN5csVaO724aPC85bD
         SbGwRBpjFhSRNg5ARuwjMw+ojKNnASAJyKCq/lJT2DtxbQucTqfq7XxW/WB9wsDY50Nj
         1AdQ==
X-Forwarded-Encrypted: i=1; AKwUvByEAeeQloWEOKReP9nlf+2YBgzjWuUN9TtsCldZIGoD4uepr5jDtjekuN9AoofT857GKZ2i75o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CR6GyzpMc41xsO7+G3f6qyU8Cxazbl9aualN55KPekkxeeRb+
	vKsVNa8NCW0LdZI34MMp/9KjfbkAl/gaIDw1PKFF3/NYzPYfnCYAIwEp
X-Gm-Gg: AYBFou0GFzNvY/ODki7rOlFPBf/iwdkLVz1fcSndclB4lz1GOVvXM3WgQP+X18pfXRY
	OqeEo1oIbAQPGaWFPQ/8xd2IeWwuVo7vAQTVe6Dsn2BWTrr4JwFzvHHpwHsoptUPpxeXhbWsqFp
	D5wJ7HTR0zuCFMmRCQF9KZWw4mLgvnPFP9jImVSq7od4pkDCmNrfPUgl032l3ob+EYL5CgJErH8
	a6gGBW8Z0diKbYS2vamM+cN2SNr41fbyOlK8CHNIji68Ecbv9WAN4aAEQIum6k6Gcsj5zjERV6p
	Alzd2E7JWCmfgDhSGF2ZcrH55cZagYVQMoH6Fmxp40swz19K+FuTb9eWLzKx6b21LLXis6tYPyT
	IRuenFkZzuXRYn6Ae3GOIsdoqSxKjrKmcVTWUg6nm+i9a86+hyLdBx13zfvoaa5JUylFrOV6JKT
	4IKI4fIyzTZCTuNOYuHxvx8mh1E6qEJ2NJwcj21UkkW7B5YtjuExvbhcolCZfoJhi/TlDgP34BY
	Np5eyDguwlsm+GIp02lgVQT2Xsjipw3AwQdkVap+WqC5Wqzou/DJoNm+lUQjnivRwSnNZhxXfJH
	UrXSSxjwA6IqgIeGYWp1UGWQJjWnaRCQXRmogcqdwtZ6G4Z+W0hco/5vWvdTlO8orUDf7H8L/GL
	eQZX9HGppSHKSnVyoCSqVuuU4fP566gTw6lrcVludEtTqkjerNIS4Q8CE2TYACK9AjxGHWupHHP
	iILFnmIC/k/f/5mRCaI4B+V5GLc3+mioVAXmnZn8ZMd2RjE2ZGoRU=
X-Received: by 2002:a05:6808:c122:b0:55e:fa63:7001 with SMTP id 5614622812f47-5640ddca9edmr10561090b6e.36.1793744785023;
        Tue, 03 Nov 2026 14:26:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:10 -0700
Subject: [PATCH v6 08/10] dmaengine: dw: drain the tasklet before releasing
 channel resources
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-8-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The controller tasklet invokes callbacks after dropping the channel lock.
Releasing a channel can therefore clear its configuration and disable the
controller while that tasklet run is still using them.

Disable the tasklet before clearing channel resources and re-enable it
after updating the controller's in-use mask. This waits for an executing
run while preserving pending schedules for the other channels. Have a
pending run return before accessing registers when the last channel has
already been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index c602ea01cb83..56a422ba14c1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -419,6 +419,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1062,6 +1066,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1087,6 +1093,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0


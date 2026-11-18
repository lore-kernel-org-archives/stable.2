Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960480;
	b=GmWVXCddSnqZjbXPPWwcOVHtEAaIhprcG/uppEK9QyvCaLbehqPscUpBf/5we6iE6ooe
	 V1PLGCZkicWu/1UvP/vX+kgYC50ams62U1nTsU7thq7nJG/2boEqqp+5sxXZs/tbFtF3D
	 pdu8tlvFYA+Uh2+zSxRdfpFK8Etlr+TaInwmgTrOGNyqK8OAE0+NX0Y22mUJqidCN00EG
	 jM61M3r50SfisQgPQSdVFPRO64Icz1igdroiwYTGFuDvUwM12N7BrBC0OP2OttRn2bPzX
	 4QOHqUXJB20mbD0TYuMYS7h85sEbatASeacQNZH29d/weUjZ2JIyGLZgtUAN2T5Dyag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
	b=nhlTtcIHdPWbdpO55hAELDVxcZ/NzrawQgFxywBDIhfa67ECM/n6uZOtPK1hn1g7NCiw
	 dQmEl69PKOjO+ihDWMQiIfOmACTQUGjQhIvbi+P5SPPYBqPgBbJ5vwII7Vuvz+Qgu1uso
	 9vB2c5d7D4wb3gJ0ohZJ9WGTYmLGBy8eTMXPAFwdwK19XY5H2bTM+EtVqs76IDN+m3f6J
	 LWV9kXfmBm5wudH8sQZm23K2pnaek0oLLnDEZwDeF8kK7Ffx2GdgzY00eCthtrWp4Koy3
	 zKKIC+8vHunEa6PyuUcNLE7qaEpqfKeqx50Eysv8+cPtC/aFN2PQxQ4zKZLomQFEEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="prnQ/qiP";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB017606A88A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB017606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prnQ/qiP
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862b98b2e47so131334a34.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794960479; x=1795565279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=prnQ/qiPlE65zIvnXobRHhIMQyIlwwD8KCllVt7YPKlF7LGSkrGug6bsC34rlwftEn
         dJWarqi4gs/GKi3Vo00u43bWTWb1mSpH4/KiIREx6RHq5VzsdLrURUO9TamkdSzjvN0g
         pfdvzNo2b1/4XNiX4JrhkAQk7EKK/oKnIwLGSxsqORXHKyTL2lZWx0j8uGSqA3T3vFj8
         0qIm+HxSTFAoY3LVGh0yeBecMlDRfo3q5oF65fyf5DgOeQ7wr5DVThrK2ZaHqaTQJFif
         IgVxcJk24eD+QEVuHOrwsq9oGlUd/6f1x+fRluxui3rIm4WHthzjMtFLBnU33D/kp2be
         F59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960479; x=1795565279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=0/Y8jDs7MEYkPVyriGcY3Bq0KPSuQtSNwxWb0d7zcUqoacGWjjZaTpTwn7Es1EOY0Z
         zLU7htKGyy7XVfyQwXQOdk1CMU/Jl85gKJ2RlAl2HbFSnq2r/lfb1Wur8hDTSKExYQo2
         Wfv1hCGldt+orntZJ43u1aLSqCiFoc5DlEbWVtSJsP+Te6qLNKvkzVb0+Rg0rx8MvrBD
         mWZ1UIdj0/VZ6vWRB6TOTC5Y8CL2g9EBsf7Z6Y60KZVwVFwGiQqVm7qhV2+B0XnIbcLI
         iqIa1v68+71pAtU8R1HaobGAIcr5Ifw+lomkZEQJuDvdIlJheXeTkoydFwLa+RG+nBP0
         50yw==
X-Forwarded-Encrypted: i=1; AL+hErEGG2sZVTSjq2fmcQAk/Eg3SnjpfDp9i/eSnuiP7SDAtBD6P7CNbvIP59MpXc25uEidLM7Vkqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fAgyXvVwtd1rsjtXX/isHQsgm7saPed/b/NonueSFWu7JpJDm
	1QMG+Vd5KmYtujkk95VQ+g8Ys7mMHEIlSiXfq6zg9FR14ZMMFyCLscFM
X-Gm-Gg: AYBFou1H39oX51ZQVlVg5WfLvOaQ2tyYphbygi0So1bA4vPxlskwfhMTm6n9vkZmPmK
	2LsSqYqkPHfjvY4hZVXCLAfWIJOmETbnvsg22DSM4tHKoT1h2nOdQ6D7IbY6ryde9ZbnuAyu6N4
	hDK+RcSXRlOiL1cRmeTTUdC1/9jWUtEyEvRsrIeOSN2DjAYyXk5e+41/ojCWKsMViJO20rpoC/V
	dcAE7RJauJBjVY/XZ0sax2jocctDU1hThya/PTQDIP0oC4M4fL/mScBI1PBpqTRFixOTzW2tiK2
	inDpJF8bIj2sP45I0JxI2f3U7DAOeV15yjOObRyOL7KQq9IXPAUq1EPdI3I1qnd9AD7ovAlgoAr
	CiJuHoZ8AGGAEX0OJbhUdvHQwX2g2Kqsv1uCPXXh6PvjxMvM0B4jID0Kx6sqzRs6Hs5J70I4+GZ
	l3zAO7fb3oiQ6TdBaUtgZmWMobNYMYO/GsWz7AGtEGN//mzZQIS2/YJ1vKuAOQlp2wA/3XWKu42
	GdJHwACeYGPDcPziky+qHgansFmgu0eFs0mj1lW6GsYK7FU4qgmm+jad44kkwLkXMn4B26lxHRs
	yIBbrhE0pO0bbKS3jl/we89TGMrY+9o77hQdxiT/xwYSdQPYTmDWvFZijsKUOyV1eNV4HKPhRs2
	Ounp2D68+jFiquxmdWvS/A1UGaMGyW9l5hUGgGWe5A8XYl2eaejfUuk2qZdXBtI8gsHE1ZM9iWk
	BuEElevcXufg6RNQl0mbxL/51H9kZPOSd9pYsoZYYuR+3ThQm1wbk=
X-Received: by 2002:a05:6808:14c7:b0:4fc:248a:de3b with SMTP id 5614622812f47-57740b4736cmr1444474b6e.23.1794960478756;
        Tue, 17 Nov 2026 16:07:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777b393d40sm434954b6e.17.2026.11.17.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:07:58 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 17:07:43 -0700
Subject: [PATCH v7 4/8] dmaengine: dw-axi-dmac: use atomic polling for
 suspend acknowledgment
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
Message-Id: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-4-d5f2309afd72@gmail.com>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The pause loop delays after its final status read, so an acknowledgment
that arrives during that delay is cleared without being observed and
the caller receives -EAGAIN.

Use readx_poll_timeout_atomic() to check the status after the final delay.
Keep the two-microsecond polling interval, 40-microsecond timeout and
-EAGAIN return value when suspension is not acknowledged.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 040c12d07db2..1a53fbc951a9 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1219,7 +1219,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
-	unsigned int timeout = 20; /* timeout iterations */
+	u32 status;
+	int ret;
 	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -1250,12 +1251,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		}
 	}
 
-	do  {
-		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
-			break;
-
-		udelay(2);
-	} while (--timeout);
+	ret = readx_poll_timeout_atomic(axi_chan_irq_read, chan,
+					status, status & DWAXIDMAC_IRQ_SUSPENDED,
+					2, 40);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 
@@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return timeout ? 0 : -EAGAIN;
+	return ret ? -EAGAIN : 0;
 }
 
 /* Called in chan locked context */

-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744781;
	b=jTnDwMa3IkpT0awqb1/wWu9omh1BsYrO7hWd8wNpNbAAo0RSe+niWfS/eAnqS+AahGAc
	 vj/hwZmmKgmXBEfdYgjWp0zO9maPNfU6XXG96UD8YysVIXmo2Yn1MiK33vJGFo2Xo4B2G
	 D8sxPal+sauE3Itx4x2vKSSbZ8Ns5/9FZkfrGCa+W3ARaWpW/8Y6dFl63moCmCXsOQKOR
	 KCpusPiAW/3Jz1JMrfSIFSH2MmPVcgEmsK7jz6X7wqHnHWMJwFGOi34h/kubg/236GY6n
	 AXed8UJ+wnVCck8B713gIKuWKHYMZ645SzUYYJ8W0/xYuHu14eC9i8oAxt0T/OPLc4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
	b=LwCvp1+b8zXZtF/4xZ7fOJdh+c5L89ewGYl9w1tr33NZXU6B8hGmngP8skAbnfI6l4O7
	 HGLvfGr3K2/waBJZHp8WUJex6xguoNQ04JD3hocjV2wObTN/u5BZBTvFn0GdnNmx5Wb6S
	 9x5ZXaUJLdqZfLkoNS91XFOn5misqGjJocCGFD55oZcM91BlIVYlbodl7zEwFnjcGYkBR
	 sjCEhcKifQQODr3bVIFIcopswhKwTBWkIL0JxjaBuzbnLYKCEyObBm4QvNkxAZqxK2ccT
	 8lpjrVs1Dh19oU6YVVa5+aj6SwROTnmprK1YUdKp5qzBWIwcSKtfXwdeiY8/dwuG7NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye5kw4kj;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B99606D817
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B99606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye5kw4kj
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f488ba6e90so38723b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744780; x=1794349580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=ye5kw4kjGGe7+/gf0E6QUPsAkFR79TW0mqaYRgXOAZFGmalCnrKeb3pR+XCwVu+Nw4
         S32jdRZj5zVrsnrHFqb840JRPJLku78XABiOX0OHJ2DXAKoIu0AOXMjIeCxa5aMAskds
         tdbpTWp/v8WYA2WwWEDI88oGDzR0QFsPSYWfcBcYYoYivSwCs+n4vzLSVzyVSMtuyirD
         t+wrPv+Rr1M6UdYU8L/dj+8EkZkofMtDwAK64Y220j+916bc668QzPM71a0nV922c1qv
         sN7FrYFFviy19miUif0fByCCzIy4mZR5Y1f4h7SUWEnntqxJsGmEB8iXSLi9ndOV/Mpj
         6KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744780; x=1794349580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=FNajcm9CzBqUP2TfUmRE7QwTheTiORjPhjbR0dqnHJCvjBiACt+PzHiT2zlO2lNM2e
         7uF3HUKS++Q6PGpdtTxyEw7bCTESwpRF+d/Q4sjieGPaMQtEGhhkFVcZNUgO4fNB1plY
         ZLxmSJJjI5H4hWtN8mWWiI40v5xxGSU9oid7612wsG5leNgdJqZ95xItkjHFNWCEwrdw
         Q6lgbAOQ74gZy+h6JMvVvyAOQPJ4120XxdiG50R5cLHPCCPHekX+RK754cilUaKSi/x/
         VMzLNWkQcgNqz0JBhw/sPa3bFJsmL22wvmc8BLwAIeRzz1R6lX+EAJt+U944z+h0zkVj
         zjKw==
X-Forwarded-Encrypted: i=1; AKwUvBwTK5+vsMjWg6wLVt8a6xlK6NZyAVwuYMThU7OWR6qdEoGcyKgYZdEyp5TkwpBY4IJEkv+glsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Zy7BCq2WVXgWpD7rgKickWbMsUQb6psdXY+bl14ang4wrHR/K
	H/PgtF739JDthTA1xBrGSdeDdYVyieLd1OFKcAa57QBP9aN4/01zvlZ/
X-Gm-Gg: AYBFou1ik9ANAvrHkCc5ukzxlXGIcr2EKftwBwuwmlkea2RJ+UOg2TffhEkmOzNPGDj
	HlryvRY2C/uvfzilyMQeKbF8kxgsbB+4FSCTXmJ45MnK4OFZl07ham4WCphv9uULbeO1XBHHuAe
	QlfM7Qd255imYLTDPzPH3+TIKdlgjEoQ6XsXuueryr3DZ3KL++g6krEt+looY2iB0IbDZyc0m1x
	IcoznEvzF8RUfcjNC49iaq0mwajdhxMa42bgzGQLkbPtxVxoYKiaD4eprfcszvrBfv4u3j32+jQ
	SuCwmFV0DyRfGe7kXRT/6oT81yeMc7IxxIG98xAQMFFsbVSEjLppe61opvbscf+0HZDx/NQrZ5+
	vx4I29YDL2JCM/0WsbxkjqOEN/awjksNuUetDi8k7jWiWMgMM5WQmu1MJGJYG3gpyxVzkd4QzFP
	HPmZD5lkR2CqE9/FQXnMxLPwdBBni412H80DLGs5aVAZgryc1VqdynqyBQvl7/fxK7OM9Mu0OKF
	Mu7VyPAWWH6vXo/QNfpCiVDYPriz7P+T+hMlYoTxXlD/cH+abyPnVWy+WqUC53ybmSUgKLCDVov
	r80tJsSIqyUx8So6Xlflov+SZbAFZsLWm1t0PzeGoW/TvYmuZnqij9UwsqO9TRDwRWcHsQIJkJ8
	QWAUUoACb73yVFCCgvukOMI3/FsDsZEfD0kFHR8ACwDjBIACQA8KtsUpC2r2isU/XHbZ2QdkICB
	WZTghPIGYiAgjaGdJAZxtSAqQBNrqDJQduuKhro3RwTrBvtu2N82k=
X-Received: by 2002:a05:6808:1828:b0:4f1:6ab6:8fc0 with SMTP id 5614622812f47-5640dc2923dmr11066087b6e.15.1793744779632;
        Tue, 03 Nov 2026 14:26:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:05 -0700
Subject: [PATCH v6 03/10] dmaengine: dw: complete cookies before releasing
 the channel lock
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-3-2ee0c348224d@gmail.com>
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

Completion detaches a descriptor from the active list under the channel
lock, but updates its cookie later when freeing it. Termination can take
the lock in between and complete newer descriptors. Completing the older
cookie afterwards moves completed_cookie backwards and makes an already
terminated transfer appear outstanding again.

Complete cookies while detaching descriptors in the completion, error
recovery and termination paths. Keep the active-before-queued ordering
when terminating so completed_cookie advances in submission order.
Descriptor freeing and client notification no longer update cookies.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..2d69fab06601 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -231,18 +231,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
+dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		    bool callback_required)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
 	struct dw_desc			*child;
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -329,12 +328,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		/* Detach the completed transfer before starting queued work. */
 		list_splice_init(&dwc->active_list, &list);
+		list_for_each_entry(desc, &list, desc_node)
+			dma_cookie_complete(&desc->txd);
 		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
 		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
 			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
+			dwc_descriptor_free(dwc, desc, true);
 		}
 		return;
 	}
@@ -436,10 +437,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
+	/* Pretend the descriptor completed successfully */
+	dma_cookie_complete(&bad_desc->txd);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
+	dwc_descriptor_free(dwc, bad_desc, true);
 	return;
 
 unlock:
@@ -940,12 +942,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
+	list_for_each_entry(desc, &list, desc_node)
+		dma_cookie_complete(&desc->txd);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
 
 	return 0;
 }

-- 
2.53.0


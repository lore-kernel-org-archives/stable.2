Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312997;
	b=IItADX+kX07JaUToRrgdw2s6Hu6/1NX5imbXbO6N9tvi6A4+lg+2EIZsio8vFUDjKk+W
	 IVDCWisyOcgLxgz/AZ4q7F+TAPm9KOMJf4HoaovGM542EpGapLGFwYfnPEfTBK3kG4+/1
	 5ujHpJ9zLKVAwHlD55fclAzNBmedf9Trypc0qYYZcPVxFXxagq9VyMws7+GRrKp93Nvb1
	 rsGiT+CuAL0QPDoJYNSGXi9PC9VjngUai5vYLB2Csjline3xQ/Q/fMcipo+8k8TDH3x3z
	 r3Yy3ksMajeAJguW1dnC9CFAH2UOEzGWSKT0x3Swwmce7csodxlvvjvZXssVq37wK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
	b=hQDuUV6ieUjfFrIoVqETk0+ltyF1MFtoLjn9u5xQtWOk22vtYSv7S7bf44xl40cUtNqO
	 MevzfPfDdCVrgqhj9JcILWLZ2oCPrnj2UOZTu8JV4Bt8CBI0/Fmo6z8piD++jJp7pbxC0
	 AgJiX4/6sOEoVKSH6tL9jxy98mBiaXNQOMKNuYwglvvkm56i1jrud6srftJIzq3CqwAd2
	 SJB3HpDFpmok/0iXqakB1N6+eWi3UEOdBEIYFXFdd9fXomm4VZYxLM5+6EvYVhwUtgGL6
	 +6xyk6x/TSCuNY7aJPh2JIduMxAxb/h+V8HLbNPVkrItizFafc+hBU8ISvIrrzqbdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxM1ucKg;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FB60A2630
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 342FB60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxM1ucKg
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843b6f8e2c7so212098a34.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312991; x=1793917791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
        b=OxM1ucKgDXPG7sbLLGQmeUDyCJPtiza8J60dj2KfoAsXC3e3up735bPPc1uDnxeyVD
         vnK0PXPZ23856N0bPn0moU8dFPy7NvnEWibSy5TDuHuKxK1dPvDU8yHZcrnEj8E6gr9w
         t4NfyO9fsJO87rUfwicAk6gwAKS6fwpFXQW3qMrOMge+RR66yqlU5A7nalACnHKK9+fp
         0gY0n5gu5jFtkVMNbGVH28o/p13o7LjspXvqKnaM9SQEXZvDmwLZs7RpjAIw5T+5Sx/0
         PY9ypdK3uPJMkon9AMnoC4/YZGeKIQqK213YEyHJtmQ1yFHZ7iuSeobHbDddpU21jJgv
         rF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312991; x=1793917791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
        b=KCjJHOXn/bu40J+SSverD9ihVRdd3zeWbW+v/l39TUzicElF2+itUqgYbC4p3wXg//
         smkpxblrKkHbf4edu3OXG3qx8x2cPT7rRuBekPlJHaFHE12k/Cy23gmfWJ3GzGkyJ//0
         cFnmq1PQV6BB31QOayGKU5ROxYWx1rawupg6rYPsy3Rmktj54+6/m+8SZzW/KiyGc49x
         p7Y+tO6MNwGy9//sBtAIB6Nq7+0G952aQszV/Qx1wn/fYc4xRS4Up7dyVY+1g2882Ebs
         9BSplEhU+DALKAC8ZI0AdBsOfjjgBiLwy5tMA2YSgbdEyNOUfuxDwIFA97DlmFF0tmqY
         sYdw==
X-Forwarded-Encrypted: i=1; AKwUvBzZM+mVsiBhRvXoyvPpeCTsM2rO+tgnwpxMgPLXF0UUkc64c28kQVJjqaKGJ2jl36gMVYsik6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoIaYPtPXi97DRNICihrGq9cL4P4K2+/CmOP51j9ur4BdcrLjZ
	m1jrjwFpLS1EAlreUU5NW7yDql2fBIaEX5tCdbRrRNsX2fFRXQIXZ4w1
X-Gm-Gg: AYBFou0yCcP/qBrwosYXg/ojKx/l+ujGfXFPW10NBnk7TzmfLB0xa76L1IWOs0POHNe
	717bhN+pXmnQlvJcdPsAlyYvG2A68H01FGLBmsFqvBX5UC2KW6FEAR2FVy0xncZeB5q/dqnXBEG
	SKaR9ey5IMUoDhs4xHMqayRdfMcbA3Dmf0ful8D3JIxJR0/26r5Jz9viI4GM9qAyEQQGD0nfPRw
	KEUNySlPnqApiFFOpZIY1RMvgbeo07RtVlOnJbDHfrqst7D+BPYf99Hs7ubeUrgAG99if+5BDJF
	MLH0Znsjc1SI1XFP9KJ1hfvEu5e7Q3kR54gcZa4kEH9UjUysFU6EoJNsauR6JCecEu2VlC4cwVg
	vV6BAzp/gsBDERqM5Pqhm7mT8PHlvbtBKjsTTgC+YJOOW1OYVIU1prHXUtTMEi38RfLGSBg/veX
	+9/3m9h7yIb1h60lD4V1I1tPphHoza3fxYAcDFPninfMa2G9ct3LafvhscNRH0TdCtpUgNpVj3/
	HLOm6rFu/EyKR3xfsVk/y16uZP26+uE1JiX/6saQsHYPWaPMF47NJFCNWz3cRJugv8e/NmXCqi1
	cCbJrmgxdR+WfAKBzpFFAx2duzY8GNCWmlgOxIXSYXQWSmztQrjmdS0i9+Lx+/gdaEqrpbTEt1O
	KPMBOo2lW1ht1ssfa9Hvkr+tQ88d1DNjJMc314oIz7aHETvPTH+rvPpcSgiypbpc/fSoo4dKiGv
	OpCvEFE2wVFDPHuGYCqZxLz5dK3VT4xHy7CuFJktEY7D3DZLaV7KOICf1IH0E8ALu7Sgy615nZw
	Q==
X-Received: by 2002:a05:6808:3189:b0:55b:f88d:6ed4 with SMTP id 5614622812f47-5640dc19ccbmr440937b6e.22.1793312991208;
        Thu, 29 Oct 2026 15:29:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:37 -0600
Subject: [PATCH v4 3/7] dmaengine: dw: complete cookies before releasing
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 51c5460b4670..1f7afcd01565 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -236,18 +236,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
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
 
-	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(chan2dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -334,12 +333,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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
@@ -441,10 +442,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -945,12 +947,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
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


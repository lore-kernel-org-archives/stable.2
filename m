Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202963;
	b=FkO1N/a9oz2m9jAXwWokPJeFPcLYSou1lkXgd9F6A2C3QaIbwfmXV2WBEvXsfsnhA8k7
	 9TTKzV/t/FT9qumr8lcJLs1dtHCxRwMgLnZa5hdot2fp85dtJ/YTjidhp4ZUUf5HSTnh0
	 XGxWJ6V/tigkjJmd4ZLpnTs2bcOEG2Rd2q3uFTEyJI4Y2ABanRhulxsi6EotsbDhzfDYk
	 McW8c3OnIcyTmpmXXPLsFXz6uMISfZMd6/PelOTDNb4c89SHG5KAlSw8KvnxmyClnDrt7
	 qm3dVufm8Bp+SLtK86hAb5fgVXpz2ckv9y2DkO+4uE+F/7n0bJKIM+8JjPCFw4lb7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=dbXNTPgZVgADfmif2+1b8bwvAtQC0yelGLdwIrzEihmPDBPomdS/CnhKJwOrRW/5MuHZ
	 fShT4v11m69FxZLQEfIMy/TNtTGbrdLZTl0smJ7bZfPuE74oSMl0XsMVql1+sQpmjxjkN
	 YeXsfKv/pb5HHSIaR670JZ66hyyO5adnE5XxtkAazVEE3PIu7djnpmPxhWOSrRzYZ+HtZ
	 hdSRm3uqYq0IkyRO5rlKTLOPOaixxN8q7Uk32lvloLOQz8qIosyzKekVsGPNu0gXR6lZa
	 0rkzth18LyZGG5H6TcFwCS+jyElPk/T8VRv2gvKEKpq3xNKHRVi1UePxzPIIyiIXqYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEOB0blT;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213C606A6F8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0213C606A6F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEOB0blT
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8479f46ecd8so534042a34.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202960; x=1795807760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=GEOB0blTq1pdOAK1AAs4SvedVsy9ZgE9IV6E9LjdV6BFVFLwS256U0naIqpqYOFlEP
         i2k1T+PSD/ANlTcK6J8nw2UgAXL5pdrvabNAvOltMG6QQXMcudk0c08rY3nnfWiVKt/7
         12rFq/m1fcZMf6G9Y4lq4gBWQYgOMXGJAQaPaVZ7qfooKNaXVgS8f9SpmbVION3h0+MX
         qLG+G3MiX/mpSBs9TFKssUrhJGTWy/VMGidxkUyha0B7wm7VBR6adtVJT6cpT0q9/Wo+
         2xxoBaebcN68gy1ia2rZCqTqMHICDWNiZxCEYnJhOOZw9nKJoSxqBActdTpxH9Z9YdcL
         qTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202960; x=1795807760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=N5Px0BzAoepS1AB4XxorB3hJS1FRmNWiGCQjtH8OGmPPBBuSnKdYKMTfJ98N/wywBr
         ymabzoeSbmZRQpW75MxIoFAe/hEaqypPLubi4vXzszw0GqQQ///9+rKI7zMwJm2aI1Av
         FfjYM/ZAZf3Kp639X92lKgrIAgejJElYoxcatmaydiflbQ3dJ8kfc9EbpxhT8p1qT3Hy
         WFOI0B26l35Q6PVuo0x3GRS8mp0pMoWGCl/J47M7R8J75rv9GeGQYi+AuBnNCviRkK5Z
         Roy5n+h2GLmeHIiNWaRRI2Lq+HNT02BBpAa2Bz9RMOk73VYA5BluSazufv21Ab9MK3DV
         MCjg==
X-Forwarded-Encrypted: i=1; AL+hErHlPZKRvJrU3d5zmi+4WDKxDh19WcqjlJ94oNKDhRsgiuanf/sS/JZU5ruaA3UVuma6i6SmFvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z87+MJ5eZBida2v66bXLlFaaPZWw1zhEyYHAZX7tncX7W1io9cy
	whKwY6DcQafmpgLVpLos7h/K9yOIalJCY/HQWiwyt982S2GmMvzXIvXi
X-Gm-Gg: AYBFou2LJm3/ng9UNo7S3F2f9Hy/tCuTamSO6Qoa5QjjiX24OZ+jdMGOrJStphgMZHZ
	7qhwsf7OGB0NFJQ5Bq9Y0exzYMp/xkw3Lyg9rhSEe5FgkZBxcEZ3yg66bW+34+5yw7gy1FjXkyP
	Nl0gV4UmaFZdaWQzlf8tnFez1AQnDHw8t2zZYFuyus5Xv/y6M8mMPv73qA958QZcNxdRNINy/Tk
	33NZfd5kH4An35/2WXSmkc3GlKZ0zyAJAZ1pbz6tZGE8kxcqyT7E70VpaIoJrDusWOMHji7Plau
	JnOfvvb73n4QX6gt96258+wbLiiNo66cN2sY1bSX6CzGBsajgHAjd+w3VTSpEsrfc9bsQlo0gZW
	QUEiA8i3eIOydUwEwOBD1AjWItwJWG0ugWHwX2KIJsfrBdPqNT4uJNRp6EONIqg5qOXkbo08qgc
	QhO6XuO9uZQVCQF/YN30FVMsfUkYLKaxhP9xRKPAyo2wf/SIdOYGs1VrVhGAd46qiZa3Uki3qq3
	R0nza5MnVpCj0C6lktz6Gxte5gCPiluvWHSiLuNKVMahgfE52kKbAujwyx1uSQaMBdxo8wJiOsr
	Ou6txlt/x4UqiMQeAUyf9+CO3OR0nrXMUVIVuXmpIvaRDg4ZdaQkT5TNNKVQSrRPmbMKAoM4ly6
	/vmFlijWiuh8/zcPwi48ez7vTROYs1lcbtP2YhrplGicD6MycKlxcHzYP1sfvLPxGCSy5VIe7RU
	8JrUjk2yotkBgEOFbMSMMiwPfwYaw5UYwRees+q4CvhoMyCUWmpsqXIS7+He0vw3w1p84MR2lyp
	g==
X-Received: by 2002:a05:6808:301e:b0:4ec:d580:2440 with SMTP id 5614622812f47-57a0bb73636mr4665554b6e.54.1795202959832;
        Fri, 20 Nov 2026 11:29:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:08 -0700
Subject: [PATCH v11 2/7] dmaengine: dw: serialize error recovery with
 channel termination
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-2-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
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
X-Mailer: b4 0.17-dev

The tasklet samples RAW.ERROR before taking the channel lock. A
concurrent termination can empty the active list before dwc_handle_error()
uses that cached error to select a descriptor. The list head is then
interpreted as a descriptor. Even with an active descriptor, moving
queue.next unconditionally can put an empty queue's head on the active
list and pass it to dwc_dostart().

Recheck the error status under the channel lock and stop the channel
before selecting its failed descriptor. Only one transaction is issued
at a time, so take that descriptor directly instead of scanning for
completions first. The scan can otherwise complete it and start queued
work before the error handler has identified the failed transaction.

Detach the failed descriptor under the same lock and use the queued-start
helper, which leaves an empty queue alone. Clear the software-LLP flag
before restarting so a failed multiblock transfer does not prevent the
next transaction from starting. Keep the completion callback outside the
lock, with the detached descriptor owned by the tasklet.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to dwc->active_list in dwc_complete_all")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2a9db9e39f5f..f7ca9da5af90 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -403,10 +403,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	unsigned long flags;
 
-	dwc_scan_descriptors(dw, dwc);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Termination may have cleared the error since the tasklet sampled it. */
+	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
+		goto unlock;
+
+	dwc_chan_disable(dw, dwc);
+	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
+
 	/*
 	 * The descriptor currently at the head of the active list is
 	 * borked. Since we don't have any way to report errors, we'll
@@ -414,12 +421,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 */
 	bad_desc = dwc_first_active(dwc);
 	list_del_init(&bad_desc->desc_node);
-	list_move(dwc->queue.next, dwc->active_list.prev);
-
-	/* Clear the error flag and try to restart the controller */
-	dma_writel(dw, CLEAR.ERROR, dwc->mask);
-	if (!list_empty(&dwc->active_list))
-		dwc_dostart(dwc, dwc_first_active(dwc));
+	dwc_dostart_first_queued(dwc);
 
 	/*
 	 * WARN may seem harsh, but since this only happens
@@ -438,6 +440,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	/* Pretend the descriptor completed successfully */
 	dwc_descriptor_complete(dwc, bad_desc, true);
+	return;
+
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)

-- 
2.53.0


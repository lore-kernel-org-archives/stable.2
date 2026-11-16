Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826388;
	b=RAGGr78/1Mkf9PTDlwEcqApqUZKYmTBy6l7dMLv4e/htIo/2naxdCeoKBY173sIiTEKG
	 +v9cza/+ub6c9909xPtuVWYCeZ2EpzTJd92MzUID5IL9CSrrmqp7WS2MPKDFWRNxLVFvu
	 ugXF+Rztyj7n2n1hAooY1LS9f1Sv3jRjRXqBEE6WB3zYF8sS52qnQJWM4zuK8gV0Pqp1w
	 P+vH2RgSr4krKeQ01I1Hz11tGZcWzHB1HbqKfV6iYK/vUqm3tgTu++j3DWkd0nNTu2OMO
	 miOLQhsBhdCkdkCXv0ciBxdLnGDyvOycD+WYT5PMNI5iDijYIknK+79QXMtylSldrsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=oYpvDqU7SvxJONmYKgciKSwGKO+CA9jPeTtKjDBpH3RgD5gtbN4Ly0rPwzAub5Ecqbqw
	 s9Ey1/LoyDGfuCGLCkduYj3ql0073aRji8a86vykNDrlMGqy5tDD9S8rGmRGe43K2A4PG
	 YPVxOdjRSzDrX8NW/g+hdIAJNQG8ywK8gX+7QHqHJicG1ql0u1fqFBjHyEZwx7Xgl6Zo1
	 isdHVYainbAvB7HWybPyeo3KQDi7joHIXNzdrzjeCOHZtgu0/ZspMq7wGq+5KETaFFN/A
	 AjJ+D4kwIH3WWEm4k8p7xTRuhH/wUlMJdiV+URZKVlfH4LVAlVO2oMPoCQQukic9DeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StV2Mi3B;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD412606A895
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD412606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StV2Mi3B
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8629ef48703so1263230a34.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826387; x=1795431187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=StV2Mi3BI97CD0DPv/Jo8/0Zf3Qt9SNZixrrMcNNMtQHTv85C6dS710kuy6nW58Dpb
         PMD01OWRfDniSo+2G2knh6ZhxItF1KIDIRicLw0g91YdKTo6a9J514ZyDlaIX1SIiXor
         d44nZEjivsOeqmy0tmru7fJReZwx75gFdhFp13FaWDTsxuhtR2QupOkwG53SsRjSrqXL
         B3jLTeh9YqOQvcqVY40LYlJ0wiBodCbxoSSn6YEg3Otn1/EoswRXHP7D2GV7IIiSt9Oq
         Pjw8XGLOPTTdprU9xGSDixXfIDoiNngpHV/2e2IpesNd7CtTRAJG0wh4If6cNjFksgaD
         D4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826387; x=1795431187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=Fz7kIbCJT/dOoLjvR3jJ0UXc+OrObFP2k9+4U8qfNG2KwJZDq5OEEm4MI/0gc+AQBs
         VXxTu2oTpZhOqSMVefDu+ywVlGjtUec6idiiDZduwbstpHiiw3kdF0hLYLCqwaVp5OZW
         SzLRTeNiPpRfdzqmTWYS0WocMvbKvS5NHU5O04dDZLclUvrj3SR3MUKMx9c1zDZqNDbi
         3mN7DfIKQrh1tQnmSO7IsyyTPZy32V3jfR/AXhEz3gYboNRv+SBeA7WzV4xRD5FEgsbf
         ZGRlKeIY51T2iBo4BbaVcC9B4u8/w1hEdQcnTVfm94LEM0KlEErPSzxzQFiclBQkd8mk
         IErA==
X-Forwarded-Encrypted: i=1; AL+hErFHeoFbP4LNQG3DOlF9U719ICjx6dJb2UkkuCAn5ZmBXbsiZQZZwSwbjH0+oI6gIP0nWKJYxvI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8tVif9deaBFeJ+VgauWFfPsSpQV9ht1E75jt6s+SYaJKeYQ45
	oPDTW32tAJyjbg/XZV9xDihAGBgBHAOvwu2m++1mXGpnnXmlj9StXvBnQBQm4wzN
X-Gm-Gg: AYBFou1eNN7PfNE4YntGCNXEcUU07VrUF8QWyA+ikQVyGY12Z352uq7CjQyVtOpPruZ
	vONzAdgA2kCSDpONOmDtT4GS2X6f7E2CNIwoFbB/dCHoDVCz7DI75l/ATrxmMzN2NQ5S+2k2yRP
	ekU4olHORdcFeVKK+kRD09COZY6RSgxWyg5FnvrEpJOZW5PVXt6FDCgcms+x7zMJGohvMBFcy/y
	5B8Vp3yB/GROwoqiPD/em/WIslr03tcQx5JFgKl28FqQp62+kNiQwD+R4SOfVW9Hsf6j0elkUHG
	8+NZ3cA67tb09FPLIH6kGTRY1BrovcJLkDj0hQwN7YfjDqdYmAHRwGgPWN8OJfROdJnVtfqqVSV
	mfXCg1Ky8tUduTOfw/iJH08JqVbN8Xwsl2j6Em2ktgFcCKndWM1EGOXU8wA/JQyuNR2FKs7ke3z
	ANK1oDfry5xlR3FFqRGL8d89K8vztJCTU+Dha2U562B9TZbHcMOp2ZpS81Ws060FTBRU2I3wzRF
	YdPDaXFtE9j121FS2d33gFNYgWA/C8jr86751TyOefGbhcrrtL25qFXge3Vbqkd/C699+ywQTza
	iRCuUx9BnuJtmGH8iwk/lbSp1wPdbIGvKsp9A4cFG5YMzQZYm3+v1N4zYWh9ueNwilLPGKWO9B3
	Vd36AppYVnyyBbF60vSyAuDWjwkvCRqCR1u7LmOC0hO1NXkk75TyNeKu98lC2bQKzWW2VQhRga7
	dYP67N/iKM/B12c1kywJI85xyUrM4XJi9FqSO7WkRhiAdbPAzuGvRXa+28in5Q2vcGlvuoLMLo
X-Received: by 2002:a05:6830:4492:b0:81e:b506:592d with SMTP id 46e09a7af769-862898ade72mr8685264a34.27.1794826386804;
        Mon, 16 Nov 2026 02:53:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:30 -0700
Subject: [PATCH v8 2/6] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-2-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
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


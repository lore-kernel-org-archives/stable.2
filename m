Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955743;
	b=1RLVz8d1ywZ5J1u+5rkXmEKXcAl2CQuYNO2pK53/InKkBZR5VQs9JE9BqN9lxrziRQ8n
	 oFCxW9Q/xF2naT9p9z+T044DL+7EuiXRgCGkDnpQx058MqJsKB7aS5imv8uBF8lxnXgfT
	 0S615kkdO05dQ/hRw8uSW3iaWHBTM7FDUJN8fCnXsFwIOFzHZXhB5MpB7O9bdGEQ5m56L
	 Zscf83Pxicd3i/Ba6HzhkCV9PoWpMBtvjBy7OkhXu2ldjjQ/B0PRmWWX7XBUvbINpvT2/
	 4Y7WNebpmK1pFipM/eeiBVguxAXcUrWJZPcmTmKyuoEBf4tb3L1P9fdtwZGV1DGX4jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=F57rN6lIeDJIEUzBTMLGyQN6ogdD6Jlbb5M+4GQW0OlkrMDFtikLFrDo7Hjxy/BUhOOw
	 xKeFogp9wD0lZMgWNKE9J4D5A7XkLW94MZKoAoH+wgL+qOhLLNjcjPgn0SziO9cFHAb7e
	 HK3BTBTOD9A8e8WFQo4F6wvkcE5USWq94mTClBoTyqrIf+3X/Q8MRMqQDqOUzVKaZF/Np
	 QTMB/owccbdCkC6tljaCcOcPKljwzoH+ENhGe2GSB33LnUoWWz4q3stK+qBKBDj3HSWQP
	 aa74xak32omlxkLtEge2iS/EeeLY8fTHTzsC2RlYMopIsOF1OP2C6X3dlaJMvlaK5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqs5FAtb;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CC606A8A1
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4CC606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqs5FAtb
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862a19300b7so118917a34.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955742; x=1795560542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=hqs5FAtb/l2lFZVbNANYpUobM0kxuJ4ncJAfURemCBqRlXF469IVUDfOOPy+rQ297p
         XlnXZ5DDxt/8PERRhtvJLa+Zue5BebERINoyUEkReDe5nfkwNyp49NtXluCSdh7/I5To
         h8FFH/rPNuhPVlJwJyI3wHenK6msmV4Xc3ONfyB4AI6jOA4EG4RTnQi5r4XXjW+6UrMz
         tfZ7/s2nYG8y9qzMb0Kyg5KphJGMPKq4knV+ghbi6geUXfsaoFrPz8hFeiSSYfJjX6cY
         5SnCO3SyIG44N99/GjMx5qu4oq/PCq2qpCaDFGla0K9tInS+N8DCf70jgIPuRgkf1HzW
         wggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955742; x=1795560542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=eb7a/iqvzIT5Om2LosaG/gmX9Q8qfeppDvHDZU6FTnZQ9h9C18Q9NAse7D2icWKhCV
         AJHG1EI4f7tX+YgW80M2eissTye0OcYzRw1CGObL97hREoUVfhEGs4La4Zk3E4Z9NOsx
         O3XmHZxZbPGdogiQK/1xNqVoIq8J4miwfaXvzEyfZCt3E7x3vr5rl0yJGJ5Q28bEG7hw
         yR/ALHwWGckW+xbPgmMp1ph019szq++FJetjhhZKb3seQITrbl+m3ztvhuTUfKWQrGBX
         eI1YKDxlo9TccorDzITe9DRlltUpmQrNGAYlYdXcJD9oGhegXOaqbeiwPG77u703ByuM
         LMBg==
X-Forwarded-Encrypted: i=1; AL+hErGN4g9DKWPDUcVva4WVkO6mMv0yRaj1NrQpn4WoSZf7kZzV42M8f7pWStuNM/HdWqAQ2gRQyk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vTepGChP5t4t6uPlMFBxzpJTW3XkvLa7l6JrQ7aYNzMFvwaZ4
	0ahg/3TB4F9zp5XTWWvDU3iPAW34qvux5V/jYDBdTM81AeBdzymuKZhY
X-Gm-Gg: AYBFou2rGwAny1HzKkwEUeasaW1T2/kt+PZSarSs7kw3zgkaQIdbxXh4CCCTA1TWx/z
	Yaguks3x3crI/57DVkL6NTT3khpQYEhZ7eDgozJ3rczBTC5l+I5YfdUw/Wmn98GyAAyl2NugXlA
	dWCIz4njfQR3/49NUSgBsX8iFbdWcRV22rt4uZIvAGIkrEPl5JydYR0CT3mhE2C6MU/JCDD2WpC
	vQP4RoUQdBL8q5IwbWcPD9mzIN2MCSCTiqxI+t14zDgyk5+cIbrM2uXYFH3tUZGCqg6XfbZu5jS
	CVDCrsp1RK0qj8QOhg7UMHFr749lisBZKgpTeWwMVaWFPyVXC4Q9HNDc2hkmq6nLjF0wz0WIHoX
	FSHHD/JiLBbgk36MV4hNxQORnH+07pt+3ZXdMBfhHlnhtNEO2OSABBNv9JVX0mJRwvF+1LnqWD+
	Z0mkfZwWUnS6CQphOWRYn0VsWssLc0WwKRvbFYbCb/7A9QFyunOTu24QzCHvvglTxl1FxLb3EeQ
	cnjpTIJ4KJn1JNkzFsvuCTnLOI2QFOhhS0tzITmKQfrm8jcmJlswVknXlTM6KBBglQEMK3kNkUB
	XB3Lsfb+eaN0zE33De7owM+1lyQbSdCPipvhGLxPnFs6ekTZqDinSWmWCMxY+xhBgPYPQ11kYED
	fh06TbW6UX921WxkS6Mlr/dokCp63f5ENuZUrDbYBDyquBEz11t8D8uttUVoD1r8kV78Mje8UKP
	HVlcFmR8rYXG+PVAjciMAkcH7obwGU7/ztbsaQgpynFsgKe1XQ9P4tlhLm7tHbTXimH1xWBDU7V
	Q==
X-Received: by 2002:a05:6808:3086:b0:4c3:d087:4446 with SMTP id 5614622812f47-5773d02801fmr1580025b6e.42.1794955742318;
        Tue, 17 Nov 2026 14:49:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:37 -0700
Subject: [PATCH v9 2/6] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-2-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
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


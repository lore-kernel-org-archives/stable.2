Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226249;
	b=zf1z7eHGPpZgjwhyoUKAuD4Xu4k8a9l8CT3Tuq6LYjJm1oaZrZizkFfgnpoNLJ3Cm1/U
	 mPhrKnRKl8UZSj0UgfL+xS4lnVzBdtJKg15y0fdntAjq13ReAb24myWiWfCLAMSeKNw1v
	 C84NwM59XiZFUSHeIQLvdyTL06MZeMNiyHM88KcVjyvr35NfkGewnoD8MjMS5arlUnmC9
	 94QbieMtlmBW30ujRVH/3Xzysnu0UCKazjHcdD225YnvwMZgBGPyHvl9x06zWFutSr8fy
	 pcPnIp68SGBZH56pHBLQ1LELl7d2gX53VFAH8bw0ZkejujM2o0mLhI6qyHLQzyzMeLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226249;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zueww4+1NwCyF5cy2SwCRp8wZjZi0tJ4fAEc3gDf94o=;
	b=w13Ybdjshn/rLhVBj9PAjHXktYH6VWLVjCj7GYgYbKAA+xNYKRdZNZ/s3fHzYsWdfr3i
	 Gm06okN/Eqh04M2CJF/toabqkw7FTr32lakuZTr4l++ksSntd9yt3hPGtwHrnDGJPyHpW
	 0LqjfG3n13rlG6EEH3KvGh/nvzJf4BkreKTP1vyn4nrE1blBxXR4TpH4rgCCOw6qJY2Da
	 Nu5b2mMUs7M+lWNtxaKsYp0PtWKWkvefmp6lDmxvjnuwZrzWgC4hJWLUjhj65JHbY5rL/
	 7MJK/jHWnZxnbvA6i2yaklv0uugh5hI4blzn2f6hIqDRwgWchBX9Ot0sh+o1KYAHqug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=eX0EEoO9;
	arc=none smtp.remote-ip=115.124.28.197
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5D606A31C;
	Mon,  9 Nov 2026 12:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=eX0EEoO9
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794226237; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zueww4+1NwCyF5cy2SwCRp8wZjZi0tJ4fAEc3gDf94o=;
	b=eX0EEoO91t/GJMC+Z1PGzRv9jJ6ohf6MPP3JUAEsZErLLpFyd8f8UEdLvsAeJZkh4UUGcqGdre43nV7R97bPH6oA+RYz09rm9rtIoOms22JOwuyt9L88dXqyz6F4IiTTDDeeV5A2jN/Mgv98qyAYzDQHfrumP1OzBljnHfVh28g=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04439086|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.02383-0.000494716-0.975675;FP=9592083956290293074|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.k-86pZ7_1794226235;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k-86pZ7_1794226235 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:10:36 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Johan Hovold <johan@kernel.org>,
	Roland Stigge <stigge@antcom.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH] usb: gadget: lpc32xx_udc: handle interrupts with an empty queue
Date: Mon,  9 Nov 2026 20:10:35 +0800
Message-ID: <20261109121035.34561-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A request can be dequeued after a DMA transfer has completed and filled
both endpoint buffers, while the delayed endpoint or DMA interrupt is
still pending.  lpc32xx_ep_dequeue() removes the request from ep->queue
and gives it back via done() without clearing the pending endpoint or
DMA interrupt status.

When the interrupt handler then runs with an empty queue,
list_entry(ep->queue.next, ...) derives an invalid request pointer from
the list head; list_entry() does not return NULL.  Passing that pointer
to done() in udc_handle_eps(), or dereferencing req->dd_desc_ptr in
udc_handle_dma_ep(), results in invalid memory accesses and can crash
the kernel.

Check whether the request queue is empty before touching the request in
both handlers.  In udc_handle_eps(), do this before sending the deferred
ZLP and disable the endpoint interrupt when there is nothing to
complete.  In udc_handle_dma_ep(), still disable the DMA channel and
clear the pending EOT/NDDRT (and SYSERR) interrupt status so the
interrupt does not keep firing, without dereferencing the missing
request.

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 044c31869cfb..67b0d6f73e43 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1945,6 +1945,13 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	/* Get endpoint status */
 	epstatus = udc_clearep_getsts(udc, ep->hwep_num);
 
+	/* If there isn't a request waiting, something went wrong */
+	if (list_empty(&ep->queue)) {
+		ep->req_pending = 0;
+		uda_disable_hwepint(udc, ep->hwep_num);
+		return;
+	}
+
 	/*
 	 * This should never happen, but protect against writing to the
 	 * buffer when full.
@@ -1958,7 +1965,6 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	} else
 		return;
 
-	/* If there isn't a request waiting, something went wrong */
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
 
 	done(ep, req, 0);
@@ -1985,6 +1991,23 @@ static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	ep->totalints++;
 #endif
 
+	if (list_empty(&ep->queue)) {
+		u32 mask = 1U << ep->hwep_num;
+
+		ep->req_pending = 0;
+		ep_err(ep, "DMA interrupt on no req!\n");
+
+		/* Disable DMA and clear pending interrupts */
+		udc_ep_dma_disable(udc, ep->hwep_num);
+		writel(mask, USBD_EOTINTCLR(udc->udp_baseaddr));
+		writel(mask, USBD_NDDRTINTCLR(udc->udp_baseaddr));
+
+		if (readl(USBD_SYSERRTINTST(udc->udp_baseaddr)) & mask)
+			writel(mask, USBD_SYSERRTINTCLR(udc->udp_baseaddr));
+
+		return;
+	}
+
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
 	dd = req->dd_desc_ptr;
 
-- 
2.50.1


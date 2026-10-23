Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742925;
	b=DGcMRZor2AjDngFslcpMrBX2IxY8btk7VXsqV474Nze0ZwfNzeuMaanTRxs7z6tlqOrw
	 uL6Mk/JwUmt5bGxf7lW3ILSbhVMKsDb6z2UID/93ZaiMQCtazmzPPDlqvm43xgwUYUXok
	 R9EtMjior2JOb80UIdh2FEHyIiujmtScKOyYVTL6QIkmDb54Wv9kcboe4701oFvfV0gO+
	 Xd95NlBAXTiLQ9NZum5MLCPszKP0fYnU+aewbnXSpfpMsgMlNF1fdjcsAhgSbox5JzaOJ
	 BLe2VJ3E0OdRRdLkirwV++FkCBkzFdxnwpyphm/ooVpjtsDTTzgreXKdLeGJeBwaiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742925;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rVZNee5ccbbjQfdFTaY1JCBS9kwHn7iOm1l3d7fRUvE=;
	b=WqZo5OfZuNxTU48xhZKT5HIcz2XVnT+6AJK5GQwYnF1A3bVVl288lCeuZZ3nrzu5hhzV
	 CT3s3tL+PL1VEJ6UFlPwduNKgwnAlJoYr/73tIy7zgEqzVu9658vrEG1yegyj1pMV7XRX
	 5UZ5BkQROsgEh4w/KbJFDiiipYb1XAIRA5H+4JLXJclc3pacygZ4zfX26PXaixAngVoMn
	 Aua9bFzTjXQ7DXoubgOZktL6Jde3/jpSj7GrbenynZKesoM9MYK2f78H285TdJWv+tAke
	 o2Vib7uhhKnP+qojmNF/gmGhfzBFE8u4kS/7dSSYr5SSeezb5yrFr15qEVxcUwrP6gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DalsohjP;
	arc=none smtp.remote-ip=115.124.28.146
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C0606A31A;
	Fri, 23 Oct 2026 08:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DalsohjP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792742919; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rVZNee5ccbbjQfdFTaY1JCBS9kwHn7iOm1l3d7fRUvE=;
	b=DalsohjPBnTI0WLIGqAqXHMtOF6k/7V1ugu8xZep5Nq0YgXLuChuY03zwCiD4cDqL3GlmSpFPn+0Rhktp3MIh6RcNUq0zXKwEnLZgwJukw61TxigfbtemQi61BHZJdkqPMxFqoataxsaXzbiX3qwShZSTsz2A1YHUcqt/2fLI18=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07443242|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0967652-0.000290848-0.902944;FP=10193050280277459346|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jo-72oM_1792742917;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jo-72oM_1792742917 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:08:38 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: cernekee@gmail.com,
	sebastian@breakpoint.cc,
	balbi@ti.com,
	liuwb@xiaopeng.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: bcm63xx_udc: fix dequeue of unqueued request
Date: Fri, 23 Oct 2026 16:08:29 +0800
Message-ID: <20261023080837.1680100-1-liuc63@xiaopeng.com>
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

From: Liu Chao <liuc63@xiaopeng.com>

bcm63xx_udc_dequeue() only checks whether bep->queue is empty; it never
verifies that the passed request is actually linked on that queue.  If
the request was already completed by the data ISR (which list_del's it)
or belongs to another endpoint, list_del() corrupts an unrelated list
node.  Worse, the out: path unconditionally sets req->status and calls
req->complete() even when rc == -EINVAL, so a request that was never
queued (or was already completed and possibly freed by the gadget
driver) gets completed a second time, leading to a double completion
and use-after-free.

Walk bep->queue to confirm the request is queued before touching it,
and only invoke the completion callback when the request was actually
removed from the queue.  The -EINVAL path now returns without
completing.

Fixes: 613065e53cb1 ("usb: gadget: bcm63xx UDC driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/bcm63xx_udc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 502612a56..a27dc7df7 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -1209,15 +1209,20 @@ static int bcm63xx_udc_dequeue(struct usb_ep *ep, struct usb_request *req)
 	int rc = 0;
 
 	spin_lock_irqsave(&udc->lock, flags);
-	if (list_empty(&bep->queue)) {
+
+	/* Make sure the request is actually queued on this endpoint */
+	list_for_each_entry(cur, &bep->queue, queue) {
+		if (cur == breq)
+			break;
+	}
+	if (&cur->queue == &bep->queue) {
 		rc = -EINVAL;
 		goto out;
 	}
 
-	cur = list_first_entry(&bep->queue, struct bcm63xx_req, queue);
 	usb_gadget_unmap_request(&udc->gadget, &breq->req, bep->iudma->is_tx);
 
-	if (breq == cur) {
+	if (breq == list_first_entry(&bep->queue, struct bcm63xx_req, queue)) {
 		iudma_reset_channel(udc, bep->iudma);
 		list_del(&breq->queue);
 
@@ -1235,8 +1240,11 @@ static int bcm63xx_udc_dequeue(struct usb_ep *ep, struct usb_request *req)
 out:
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	req->status = -ESHUTDOWN;
-	req->complete(ep, req);
+	/* Only complete the request if it was actually removed */
+	if (rc == 0) {
+		req->status = -ESHUTDOWN;
+		req->complete(ep, req);
+	}
 
 	return rc;
 }
--
2.50.1


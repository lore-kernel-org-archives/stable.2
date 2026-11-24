Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.14.14.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532646;
	b=GVOUxuPxzrVFR6b9s1pIaKXrnCoklC4GWkrOIOy2sVZn/1dRpqYXIkxZrx+bU3WQxFGJ
	 VA0RXAOY3tFzfoWfymSznwD/ETtN7LbKxdi8y+AJRQe3nhkV3e+iqRXFcB2lJHZk0Opaz
	 6/01YgZdbrkD6rvn0SeRFuoW4QyxHzVvKx5TL6/rrPaFCbkCl5/D0CnceQZ5odbCzQNqm
	 U+pzvt0aVdyzHb2dmB2+vIaYwu/bStUHsWlfGbdLzdSxa0cuAI3gAHoJF5YPLLRZCWE1j
	 bkUYXf1GU4ep6Ddbk3FXagFVxUTk2lJhizDr1oa0yLVTWp4CrjKd5zhiEGJiiYBPBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532646;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=IB6PTHbSxLOaITrzniqxTCapMOLaWfm7W6dch6SI4eg=;
	b=vlQq2zYnppr7gV+LQQawga2GVcBnloYhjLOvo+3i7xXiFpYJj7U0LJ1LgyHxZJSSpCCj
	 /fhU/T61oWAZFuPbs8dwl9XicGXSwIBY4HV5ImhniZwWsqNhoFPE0MnjGVVkJDJoNjsyZ
	 8NCgTx0ht1hAFg9Fvk9wXOf/Jg89+icdED3vqOb8IrT6guppCEoF+81NYegn2r8dCcJLR
	 s/I9rQT48sLhZ4RKGFtSJnKS9KEaztFX8m80FHC8+wdVlj/LPPz1WZuMnNCXcgNZfMDV+
	 Wv+zb/7Q8gGZU+9xEc7SUGHk+twz37wJI4vUFZPiFDbDeF1vh70HBZk3tGj0L2PHUtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taladin.ro;
	spf=pass smtp.mailfrom=taladin.ro;
	dkim=pass header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=qhTCj6ox;
	arc=none smtp.remote-ip=31.14.14.46
Received: from taladin.ro (unknown [31.14.14.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917E606A321;
	Tue, 24 Nov 2026 15:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9917E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=qhTCj6ox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IB6PTHbSxLOaITrzniqxTCapMOLaWfm7W6dch6SI4eg=; b=qhTCj6oxNr/eARgjkZfpWVrB5b
	d/yH94EBkM6pr/+qIe/lFRmJ0OKJ5bkz+4IHWhHiAZMw4q2pJv42FsCFusk1ks7Y5j03IB3CfWVVp
	rZzDnWn5kJs4kTh/aW+BvVUwpvRITrvJ5fb7MuUOcc2SCPph3lhzK0p5nyi8IpreGvn01RdrdX8+D
	Do+NY4Q4gW6jwXI8ItXClx2M+xcNZCIgUYOfv/WDUvvOGs8xDuZ87CQf7S0Y4+2NcY6W3GMGu1DUm
	umt9nNdtvjJgZhGUCoXcFQK0qST74rdfKcClol+b3BZKE7ZwXoJwhYuNDDAU7xg5p5BkWgluLusQV
	8rwwnJ6Q==;
Received: from [86.125.199.146] (port=58840 helo=mercury..)
	by cloud607.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <aardelean@taladin.ro>)
	id 1xVs3m-0000000BsAO-1mMc;
	Tue, 24 Nov 2026 17:03:57 +0200
From: Alexandru Ardelean <aardelean@taladin.ro>
To: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	hubert.wisniewski.25632@gmail.com,
	gregkh@linuxfoundation.org,
	b-liu@ti.com,
	Alexandru Ardelean <aardelean@taladin.ro>
Subject: [PATCH v2 1/2] Revert "usb: musb: Fix hardware lockup on first Rx endpoint request"
Date: Tue, 24 Nov 2026 17:03:43 +0200
Message-ID: <20261124150344.69264-2-aardelean@taladin.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124150344.69264-1-aardelean@taladin.ro>
References: <20261124150344.69264-1-aardelean@taladin.ro>
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud607.c-f.ro
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - taladin.ro
X-Get-Message-Sender-Via: cloud607.c-f.ro: authenticated_id: aardelean@taladin.ro
X-Authenticated-Sender: cloud607.c-f.ro: aardelean@taladin.ro
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This reverts commit 3fc137386c4620305bbc2a216868c53f9245670a.

That commit made musb_ep_restart() flush the Rx FIFO instead of calling
rxstate(), so a packet received before the first OUT request is queued
gets dropped. The commit considered such a loss harmless, but the mass
storage gadget has no retransmission: the host loses the first command
(CBW), times out and resets the device, so the drive never gets mounted.

The regression was seen on 6.12.57; 6.1.119 (before the stable backport
of that commit) works fine.

This brings back the Rx endpoint lockup that the reverted commit fixed;
the next patch addresses it in a different way.

Fixes: 3fc137386c46 ("usb: musb: Fix hardware lockup on first Rx endpoint request")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Ardelean <aardelean@taladin.ro>
---
 drivers/usb/musb/musb_gadget.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 016d3f3fc1e05..dd67ab97df9d8 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1162,19 +1162,12 @@ void musb_free_request(struct usb_ep *ep, struct usb_request *req)
  */
 void musb_ep_restart(struct musb *musb, struct musb_request *req)
 {
-	u16 csr;
-	void __iomem *epio = req->ep->hw_ep->regs;
-
 	trace_musb_req_start(req);
 	musb_ep_select(musb->mregs, req->epnum);
-	if (req->tx) {
+	if (req->tx)
 		txstate(musb, req);
-	} else {
-		csr = musb_readw(epio, MUSB_RXCSR);
-		csr |= MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_P_WZC_BITS;
-		musb_writew(epio, MUSB_RXCSR, csr);
-		musb_writew(epio, MUSB_RXCSR, csr);
-	}
+	else
+		rxstate(musb, req);
 }
 
 static int musb_ep_restart_resume_work(struct musb *musb, void *data)
-- 
2.43.0


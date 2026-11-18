Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.14.14.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002899;
	b=uRKmfvtT7+lWwHLnOFosv9CEnpZNXpzsjOgNeQgQKt3+MqhbDTqRcCyGY9ZXIs98kQdp
	 FVLnMlnY8ZMoolt3pzMhYu47fafHTrREgQ0SCllGFHBxROhDg2ufgeg1iKwUSj+ip+rEb
	 /sV87aIyBMQWpBfB2fqaROSNbG4y2/J3ppeShnPA+7M5C1OjwlQyK4muu14kxU6lIcq84
	 jPFsiAmjXSda4AaQxdB/HCPrvFiZJeoSSBnHBnjO7x6XGhG2znNDV7HX1RW6XjFaSrlPx
	 DN6xUjmctjRyOyZm8oZzQz/O2VJBQbZ2zaaOgmaTJjKdUE5nWBf4MrDlOH/+k38NEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002899;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=6GOr3KNRT2rok7vKqjER1ypwe9KHJCE1nI3K5wbj11o=;
	b=49KcK7NHBI95d+bqS7GuJZ+G2/mIjDPbaqP5KQ/pUihZ//BYyTGkbSw0Etva0ryKci9n
	 Bu+vqp/hwMdaGKs/iT08n0ReZIYfVWxUWC+vDatM+SKn4p9zwv2kWBFl+4sLEBAp70/JZ
	 CLUUt7jjkaXzEIw6cy8KJqHI1JCyLpgcJqdS8DL+aeTtAbMJlBMg/DcSbREuaykW8CeiC
	 rKkcBV1snJ6T/66pmWjWkCw67A1+I1A0P441RaMhNV6XcfOPJxdDkT/8dQFi4u44/PuzO
	 YxyI1C7c/Ee+Th0JoBuTlw+RqrJq/YS+Tg2f/peVZODbx8ZfumSTIa4sb1twMHs3kOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taladin.ro;
	spf=pass smtp.mailfrom=taladin.ro;
	dkim=pass header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=kbx3dt5s;
	arc=none smtp.remote-ip=31.14.14.46
Received: from taladin.ro (unknown [31.14.14.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26910606A331;
	Wed, 18 Nov 2026 11:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26910606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=kbx3dt5s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6GOr3KNRT2rok7vKqjER1ypwe9KHJCE1nI3K5wbj11o=; b=kbx3dt5sk9ccl88mWwKyxjao7+
	1MI69QDNwIv7IB5s7RnhjTURgGaVn5tap+rq8M8bDxz8Txkx6QJA5N0kxixCMvSX4oJNoDAEY9tO5
	PerctfQ19/0O3NSqe1QQ1z0jEBZO/wn10HJYi6BrMoyWocUECns/REeULjYY0yf3wCpu6ZPLLDFmh
	VJdYTCsU2KjAQJVmrG0uKk0dEYXQ0X0JeySQIO2lGWPLPxDDIYihBBgArRyqVgQdaxmjJq8uun/3r
	CKlDInS6TNlwkuMlgWammSc+opES1JXQr0//nmjREPQjy3LRfr+14DWrtYSjKztI/R/OGl94FoXhE
	pDL3aNfg==;
Received: from [82.79.151.56] (port=44350 helo=mercury..)
	by cloud607.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <aardelean@taladin.ro>)
	id 1xTeFU-00000000FDM-3tJn;
	Wed, 18 Nov 2026 13:54:49 +0200
From: Alexandru Ardelean <aardelean@taladin.ro>
To: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	hubert.wisniewski.25632@gmail.com,
	gregkh@linuxfoundation.org,
	b-liu@ti.com,
	Alexandru Ardelean <aardelean@taladin.ro>
Subject: [PATCH] usb: musb: gadget: mask the MUSB IRQ while complete() runs
Date: Wed, 18 Nov 2026 13:54:35 +0200
Message-ID: <20261118115435.49748-1-aardelean@taladin.ro>
X-Mailer: git-send-email 2.43.0
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

This patch is 2-part (in one).
It reverts commit 3fc137386c46 ("usb: musb: Fix hardware lockup on first
Rx endpoint request") and implements the second possible fix suggested
in that commit.

Reverting that commit alone would bring back CVE-2024-56687 which it
addresses.

However, the fix causes a regression in cases where the USB gadget device
exposes itself as USB mass storage device. With that commit,
musb_ep_restart() flushes the RX FIFO instead of reading it. As a
consequence, a packet that came before the OUT request is lost.
With the mass storage gadget the host loses commands (CBW), times out
and resets the device; so, the PC never mounts the drive.

We've found the issue in kernel 6.12.57.
And we've identified the problem by reverting the driver to the 6.1.119
version (where this problem did not exist).

The same commit also offers an alternative fix which works fine for
the USB mass storage case.
i.e.
  2. Disable MUSB interrupts in musb_g_giveback() before calling the
     callback and re-enable them afterwars (by calling
     musb_{dis,en}able_interrupts(), for example). This would ensure
     that MUSB interrupts are not handled during the callback, even if
     IRQs are enabled. In fact, it would allow IRQs to be enabled when
     releasing the lock. However, this feels like an inelegant hack.

This change also implements that fix.

Fixes: 3fc137386c46 ("usb: musb: Fix hardware lockup on first Rx endpoint request")
Signed-off-by: Alexandru Ardelean <aardelean@taladin.ro>
---
 drivers/usb/musb/musb_gadget.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 016d3f3fc1e05..5cb7eb9c56de0 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -145,7 +145,10 @@ __acquires(ep->musb->lock)
 		unmap_dma_buffer(req, musb);
 
 	trace_musb_req_gb(req);
+	/* no MUSB interrupt during complete(), even if it enables IRQs */
+	disable_irq_nosync(musb->nIrq);
 	usb_gadget_giveback_request(&req->ep->end_point, &req->request);
+	enable_irq(musb->nIrq);
 	spin_lock(&musb->lock);
 	ep->busy = busy;
 }
@@ -1162,19 +1165,12 @@ void musb_free_request(struct usb_ep *ep, struct usb_request *req)
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


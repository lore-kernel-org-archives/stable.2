Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.14.14.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532646;
	b=Yda9KjxP5MCwELozYpb/XJ5G6WXkC81PHohRSu05y04ZdKOtfpozjbuLeKZEop3+dSji
	 qM5ctgas1Y6FnZ96OwYNkas+/8MJAilrUMFjx7p9784sUU7TtMmww5NkSZx70UIYHnTJZ
	 RIhUJU9PWfocPHniJ+MKbzqSdwELhN4Gk5lHatF9gvs/vRp0Jg8C9d55LtOWKeYG/lcZX
	 zELYT9hzZe+MZNA20TZ/+i8MF1W7H/OYau8x2b0P6g+Oyr1wrtWXn0l7ZMRHqBKKjktFe
	 P6v5eEadUUG7h0VSUP9KWXHoYFX6KLPFVvQFiJVQnUUe1TO+i8+acRdZxJlWam+LEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532646;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=VbXngAw2/EYljEhG1DnBSXO7gAncUA/GeZZJw54pmOc=;
	b=u0eIbikw28Wiyydch41oG6GktlLw4QsyCtQsFfk9zOx02otZAUf99GBBnHJJ70WPHZZe
	 5MqfAqdRWSKcwpjC64zLdI3ZSYCcxyhruQfPKwP2BmIeogrGWY5T5zxhX/GRAKnKxQVh0
	 gqtB3iGHoEXT3w1UtHpVwFaYozbSO7VwKhFjJh1xfuBH+EEhFFEX5LRpYxn5rCVlICRoz
	 y/MViqfM/YKV7XNGwihcJHyZLdTFmMLt56NO534gWiltlNqRFrgIhpwTnoLWSgUsCLDIk
	 py+VgIwti6abVqHmQj3WGL9PxnuPIk9gMPgYZCTKt+qFADsuYY45b4eUKAg7sRdhvEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taladin.ro;
	spf=pass smtp.mailfrom=taladin.ro;
	dkim=pass header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=A6+sVP4Y;
	arc=none smtp.remote-ip=31.14.14.46
Received: from taladin.ro (unknown [31.14.14.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA0606A326;
	Tue, 24 Nov 2026 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50BA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=A6+sVP4Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VbXngAw2/EYljEhG1DnBSXO7gAncUA/GeZZJw54pmOc=; b=A6+sVP4YG3ceQ0kqskAOont4ro
	sJcGURpD9/AMd3YPkZZICvlmwU6OVBj5slHhuleYKzCNZiEx7Ke3BC6UIMycAoJzRapaA7Hl2P1eV
	osXK28UtkdB29F/2cyPjAGiL87fXB1IJmSOFsQ0ktH1BBnp2qNQhnMerbHHCq3UM9e3J6GhTNeE29
	XfLy9n5H3lirNytkb/qkB/BvtPmtT6nY91Je9V6dPnMBXiZwi3llHkh7h8Tz2YZIqGLcR95TMrP/Y
	17HQJSOD2Z9t6LG3frdrjT7J4WwXZFbxNIxrLabm8QsvctunKDH4lJUo4HNEOwwmcYNLMl73lhLKO
	2rWjVwLg==;
Received: from [86.125.199.146] (port=58840 helo=mercury..)
	by cloud607.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <aardelean@taladin.ro>)
	id 1xVs3n-0000000BsAO-2PmH;
	Tue, 24 Nov 2026 17:03:58 +0200
From: Alexandru Ardelean <aardelean@taladin.ro>
To: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	hubert.wisniewski.25632@gmail.com,
	gregkh@linuxfoundation.org,
	b-liu@ti.com,
	Alexandru Ardelean <aardelean@taladin.ro>
Subject: [PATCH v2 2/2] usb: musb: gadget: mask the MUSB IRQ while complete() runs
Date: Tue, 24 Nov 2026 17:03:44 +0200
Message-ID: <20261124150344.69264-3-aardelean@taladin.ro>
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

A request's complete() callback can enable IRQs (e.g. u_ether's
rx_complete() calls netif_rx(), which re-enables IRQs when re-enabling
BHs). If that happens while the endpoint's request queue is empty, the
MUSB interrupt is handled with no request to take the packet, the
interrupt flag is cleared but RXPKTRDY stays set, and the Rx endpoint
locks up.

Commit 3fc137386c46 ("usb: musb: Fix hardware lockup on first Rx
endpoint request") listed several ways to fix this. Its second option
was to keep MUSB interrupts from being handled while the callback runs.
Implement that by masking the controller IRQ line around
usb_gadget_giveback_request(), instead of flushing the Rx FIFO (which
loses packets and was reverted).

disable_irq_nosync() is used because musb_g_giveback() is usually
called from the MUSB interrupt handler itself.

Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Ardelean <aardelean@taladin.ro>
---
 drivers/usb/musb/musb_gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index dd67ab97df9d8..5cb7eb9c56de0 100644
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
-- 
2.43.0


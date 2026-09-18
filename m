Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AB523783;
	Fri, 18 Sep 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763547; cv=none; b=Jjw6C00R+/Sm0vB/I0eYc9tlN+df7lw8iPyJO84NYvZIJeg/YRNmvzUcXuEw6KNJRLIL6lX0wzcD9ED7DSVcgmu0Vj6/s8+OWbdxiAfq+mJ3TqD3n5NBW8erZkXYPsDU29Xg7BiQu+FwqahkM14QVUzdq8DpzH22jZh38Xnbn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763547; c=relaxed/simple;
	bh=awCtQKR8zVzOsWS0w8h31o5Rv/jqZJtos1/c2hzAfLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDDpm738qXrtfCV8e0hWOpRdNVR2HgTtPfs7wp9UfoaEJz+FvcOS8WUCDu8MsF3PaKphurzKysF58Y6W6ga871oMT0poE7B1O0qLxH25yd2At64MCQ9gqAaEX0bogYemwHH/sAb/p8OjzUCrLMiL7SEPstMi2UTr4pUCP93cN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vJb1Ch8y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vJb1Ch8y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3FBABC5847A;
	Fri, 18 Sep 2026 20:33:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43B3F60649;
	Fri, 18 Sep 2026 20:32:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97BCE1032907C;
	Fri, 18 Sep 2026 22:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789763538; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iUeXAsB+eMon3IGQKZXDkNH5ztxmcZZI6qhivhfoRbY=;
	b=vJb1Ch8yo8UAJzD5Re1Y0ODtI9XUQ2BMaUEeS5Dki+NHglcVkW3iW9lb1y15qdO92LfsOZ
	qAj7skragOfolPss0xBM4SSlm+intz5rZ/cuEfickX+bIQhHx6A71Ck5fHlGFTTYC6LQTB
	dydcFlcJofhfupwvywcnfnnKkBnEUGNsFFfUu2KLBRFw4z3P3M4ai1YUm1ODuXbycM7Qml
	7ZggXQWBywJnGk4oTLb2hqh0xniEBhZI82M3SmqFB2ixBtXCR2zgC1VWHOvm9m25+MsDB+
	Sffv98abychmOpsbHWwqK2ZLj1BzPAIIQ0d2lKajVbpPLcmCBKiDg6yyGnCzFw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 22:32:02 +0200
Subject: [PATCH 1/3] net: macb: never give hardware a NULL RX buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-macb-close-v1-1-221d916b7961@bootlin.com>
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
In-Reply-To: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The refill logic is simple: iterate over all pending rx slots, allocate
SKB (& DMA map) if needed and hand it off the to hardware by clearing
the RX_USED flag.

If the refill operation fails mid-way, it early returns leaving the
following slots untouched. In the normal case that is fine, because all
slots have been properly initialised (and might have been already used
by HW meaning they won't be reused). When slots have not been
initialised however, we are in trouble.

After dma_alloc_coherent() of the rx ring buffer, all slots have NULL
pointers and RX_USED cleared meaning HW will try using them. Ensure
this does not happen by setting the RX_USED flag on all slots before
calling refill at buffer alloc, in gem_init_rx_ring(). That way even if
refill fails on an alloc/dma_map, the HW won't try using NULL pointers
as buffers.

Theoretical bugfix, never encountered in practice. To reproduce,
introduce memory pressure (less than 512 SKBs of free memory) and open
the interface.

Note that this codepath also hits at resume, on HRESP errors and on
set_ringparam (while interface is running).

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..751fa9e68099 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2785,9 +2785,14 @@ static int macb_alloc(struct macb *bp)
 
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
+	unsigned int i;
+
 	queue->rx_tail = 0;
 	queue->rx_prepared_head = 0;
 
+	for (i = 0; i < queue->bp->rx_ring_size; i++)
+		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
+
 	gem_rx_refill(queue);
 }
 

-- 
2.55.0


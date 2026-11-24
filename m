Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.101.131.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511896;
	b=j388Agkz96KoZO4BEg7xU11zXLKUNBvpWII2hfaHyKVGMCu7FExnMoYOh2B50r/35xxz
	 QnkWpbPHIn2Zx1TICnZ8xSvClcgGbdRnnx7CLAxFop0p4S/YuxqX40IAS7YFoS8s+2b9B
	 kciXbRHsRhpbimiukD8+F+WYjjUy3Ms5o1H1BooB7qFp/WnyobeQVWN68D8zw26SHkgFn
	 T5inkcFx/f30kRDZINYkfW5dYc45yKfTDbklhiKWVwH7v1cSWLsCX5CZl+cHPK1vgLTYE
	 DNow1L9KzJo5g4wD4A/ZPUknlTRBCjRFIWCywhR+0eOKhIs72/XHcWx7V0sl6W6jdyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511896;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VIVHFdR/MmlluOtjRkycwLxPeI+HMWe1SECTlY1/a68=;
	b=QgQ1WQryGr3kNle/biYh4fbG80T/WeBKYUDgn8inr+4Zntj/EISNNruS2MJjdBFydvAp
	 22UyWtwci/dYCExkt8snWbnaWE4s0+MaQ2Z8MBg88CDou/EV0BBuelOadTf1OoiIr1Fol
	 z8+oL+eG8MGLKkF/vFwkMEg/wT8KLKrV/1yFW+nx5FMsyATOtUQxnLrNt6yhip31KPAzB
	 AL7NT31JPnJaPwMLwa4SG1Bkn4BQ8EMQCICnKaY9K7xr0wd7SGXRirEUwUV82AXdlE8QD
	 Da8Ssw3n0bDFKiexGhBfrjcbwRfTm5oDNvqvi1fm6dtAjPOoop7TZbg+NfoNQwICzlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	arc=none smtp.remote-ip=160.101.131.9
Received: from na1pdmzitismtp02.tibco.com (unknown [160.101.131.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0196606A688;
	Tue, 24 Nov 2026 09:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0196606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from mewpvdipd1070.citrite.net (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id 5CC6184D50E7;
	Tue, 24 Nov 2026 04:16:31 -0500 (EST)
From: Mark Syms <mark.syms@citrix.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	bpf@vger.kernel.org,
	Mark Syms <mark.syms@citrix.com>,
	stable@vger.kernel.org
Subject: [PATCH net] xen-netfront: unregister the XDP rxq before destroying its page_pool
Date: Tue, 24 Nov 2026 09:18:06 +0000
Message-ID: <20261124091806.2736453-1-mark.syms@citrix.com>
X-Mailer: git-send-email 2.56.0
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

Each receive queue registers its page_pool as the XDP memory model,
which takes a second reference on the pool. On disconnect,
xennet_disconnect_backend() calls page_pool_destroy() but never
unregisters the rxq, so the pool's user count never reaches zero and
the pool is never released, together with the receive buffers that
xennet_release_rx_bufs() has just recycled into it. Every
suspend/resume or backend reconnect therefore leaks one pool per
receive queue. The pool never begins shutdown, so the page_pool stall
warning does not fire and the leak is silent.

Unregister the rxq before destroying the pool, and clear the pointer
so that a second disconnect without a reconnect is harmless.

The leak was observed in CI testing: in XenServer suspend/resume
stress runs, HVM guests lost available memory on every cycle until
they stalled. Over 100 suspend/resume cycles the loss scaled with the
number of VIFs, on Debian 12 (6.1.0-50) and Ubuntu 26.04 (7.0.0-30)
guests alike; the missing unregister was then found by code
inspection. Reproducing it needs no kernel modification: suspend and
resume a guest repeatedly and compare MemAvailable.

Tested on Debian 12 HVM guests on XenServer 9 (Xen 4.21, AMD EPYC),
running two builds of the same 6.1.192 source with and without this
patch. Over 100 suspend/resume cycles the unpatched kernel lost
1107 KiB per cycle with one VIF and 2279 KiB with two; the patched
kernel lost 51 and 42 KiB. On current mainline the patch builds
without warnings at W=1 but was not boot-tested, and kernel selftests
were not run.

An AI coding assistant (Claude Code) was used to locate the cause,
write the fix and draft this changelog.

Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Syms <mark.syms@citrix.com>
---
 drivers/net/xen-netfront.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fdcb91042..b82b3bdb2 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1860,7 +1860,10 @@ static void xennet_disconnect_backend(struct netfront_info *info)
 		queue->tx.sring = NULL;
 		queue->rx.sring = NULL;
 
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
+		queue->page_pool = NULL;
 	}
 }
 
-- 
2.56.0


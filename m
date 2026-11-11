Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362607;
	b=3Zx2H2x8W0Mw49NWZeTewK5ZlMBKT1MfC46zOGQrBFMqTKpEJwDTF/DZN9A2iiIQ7BDP
	 1dr2Csy0++qiM8JUfITEgZbp11PQ/NuLcvK2+WE4+fsfxWsKlmhi/q0ivhm10DvWiF0ho
	 bT8PmH4lTWbiiWmhpTrdo98loKxEnW+2eOOLIyuo3MnRW0LZwX9xgaQsgb08sXa+Eb3X/
	 sQiIh1dA30V9uVF3kcPxaWyXGljv4kVjCP0jeL9w/k5EG9No471uDkyWqDszYRz0aNmSe
	 cnhnSXpEcqBLY6D0Fnj2OdWKwYPpw42KAagQDEuC/4q9QeemBU1+Z6AUIjV1LCyKq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KiCMBogBEqCEOmhYY7tq9i0SwAUDRZcEikWGab24N/k=;
	b=1N7d9PRmng/JjjSqqXRs6fHhhhqK4fA9UlMgTDvPsyvHRndQOnSP2Q+6gHEZCyMyruOe
	 7/+2GEeJ69pQudXhxhsr9LYp2uYk3iWxqRj5GnO+3VYnvohbW7+gdBgY2w+9G/wDwWDBC
	 9ggIQV2N8evoc0Li6ege14QkGVEH4pDdAs4IOeserA4zgCsXh7w35LT0xSPuFN5M4tjZQ
	 NgnwZhce+hyzXZwRXYDXtlAcngwMEpI71W3tvtWLdSNwNw+I/hkAX6wNW3rtJACaCjVUJ
	 jz7b1JoCdzvb+87Fes7OVKXwS/D6hirQLzZ8dcGnhg+JxXl4KEJiJDDZaF25JoLUe5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7l4o+nA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18759606A336
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7l4o+nA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE441F00A08;
	Wed, 11 Nov 2026 02:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362607;
	bh=KiCMBogBEqCEOmhYY7tq9i0SwAUDRZcEikWGab24N/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7l4o+nAO03CuAt9ngZtEda2n+ws/VQ3sCQcuZBIan3wWt/JhkBE34/MwMliQ+vHc
	 2O2JasysLUipVxLOJwMULnkpjK1vPbR8eFPHO7DXQR2ABwdv0i08eN9Kw2QpY++XJf
	 yAu9GwBmwQL8dM+ZtVFTW+puOmD9WfVo+AcuJ/yRitmI5GHtdL0xGfgGvPyI2HOdrO
	 HFJv0aiyOadzHoIDGQlF+sw42VAHaZM5WIYgsakz8C0uhSCVKjDmVNbIIwKHgdrpzA
	 9yGnyPwHNrYa13EHim9lwH+mv5a3I34a1jxoGNTGfOuPC9Vqrvz95AWAtnZAdyXYBu
	 KOYub0ZEe77og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	co+fd80bc5967eb22c3@bugs.sh,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: xhci: Fix bounce buffer overflow
Date: Tue, 10 Nov 2026 21:03:25 -0500
Message-ID: <20261111020301.541763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060404-failed-5.15-68c5cb7574c5@kernel.org>
References: <20261107060404-failed-5.15-68c5cb7574c5@kernel.org>
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

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 68c5cb7574c567e83ba95258cb146db95e069a87 ]

High-speed devices with out of spec 1024 byte bulk endpoints exist and
are allowed by USB core, but xhci-hcd always sets packet size to 512.
The exact nature of these devices isn't documented, commit fb5ee84ea72c
("USB: Accept bulk endpoints with 1024-byte maxpacket") only states
that they "don't work with xHCI host controllers", whatever it means.

But somebody (or a malicious device) can try, and then the driver will
allocate a 512 byte bounce buffer for this endpoint and may write up to
1024 bytes into it if particular scatter-gather URBs are used, because
xhci_align_td() obtains packet size from the descriptor. Fix this.

As a side effect, TRBs will be aligned to the packet size chosen by the
driver on all endpoints of all speeds. Alignment serves the xHC, not
device, so this is fine. Only out of spec devices are affected anyway.

Reported-by: co+fd80bc5967eb22c3@bugs.sh
Link: https://lore.kernel.org/linux-usb/D4tcSGerkYkIV1DmaUo1t8TaR5qQElDLkidn@bugs.sh/
Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case with a bounce buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261009151624.618967-11-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adapted removal of xhci_usb_endpoint_maxp() to the existing usb_endpoint_maxp() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 978ff4d112fb8..b8da9386b5af6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3689,15 +3689,13 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 
 
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
-			 u32 *trb_buff_len, struct xhci_segment *seg)
+			 u32 *trb_buff_len, struct xhci_segment *seg, u32 max_pkt)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
-	unsigned int max_pkt;
 	u32 new_buff_len;
 	size_t len;
 
-	max_pkt = usb_endpoint_maxp(&urb->ep->desc);
 	unalign = (enqd_len + *trb_buff_len) % max_pkt;
 
 	/* we got lucky, last normal TRB data on segment is packet aligned */
@@ -3842,9 +3840,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		if (enqd_len + trb_buff_len < full_len) {
 			field |= TRB_CHAIN;
 			if (trb_is_link(ring->enqueue + 1)) {
-				if (xhci_align_td(xhci, urb, enqd_len,
-						  &trb_buff_len,
-						  ring->enq_seg)) {
+				if (xhci_align_td(xhci, urb, enqd_len, &trb_buff_len,
+						ring->enq_seg, ring->bounce_buf_len)) {
 					send_addr = ring->enq_seg->bounce_dma;
 					/* TD bounced at least, and last on this seg */
 					td->bounce_seg = ring->enq_seg;
-- 
2.53.0


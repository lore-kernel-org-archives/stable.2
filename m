Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5A48988D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047778; cv=none; b=VaUIPYa6Dx75x3NQPyO9DpT8XAsJ65FB7hd29s+HzPw7mDXGlsy/Cz2GIdV3b8W+IlgGGtFpMQpNDwmxtlcZu2kLrUej+v9IcuTLbBK/6T8hEs6GXFoKEC/vGIcEkpWOeGLFlzoQ4Lvcd2sV0JkCXOmhYQY1+npmw6ufkQnpEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047778; c=relaxed/simple;
	bh=xGev42LLcNmo6AouL8irLidl8koIObKSzj3uw9TR+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMsGvXGSyfeR7FolN4BxMot4A5RRKF00nMNnJ5f+FCY84MPQ4z4mEAiSY7tguJH3qBiEeG0RbxLuVEm4YNvveuEBs4l+UXvlv7BxWF5onFrIXR/fDOl412CK7lojddMGT0Zjb1yWXtPZf1fVI9GIp5byvoRZkmooUBBGJzeMQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9KKfRpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9KKfRpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FA11F00893;
	Thu, 10 Sep 2026 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047776;
	bh=bmenWyqm7kLTxCt4BFvFmPsTH8dKE4Smzl1LZXF/Jmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9KKfRpDlX1bo80C4gZdy0LORBz++tq4g+w2JCfj0N5lfp96CbCqsshF78nka0Ia9
	 ltZMj2df3mt4UbKgDC6kcVpVprkFgpmBOpLA9d24vtr2mYZMWpCTsZJa6MClxVZzuf
	 oTFah18rCADP4TyjV0DiloyUY24ir1PmD56U476aRjnRxsULYZxgzdNQDVBzlEmkF2
	 89AeVzc4z9RGhc6mlx1WVEbHxTbdLFcxDidWP75tXjciusovUMG9tZz6qK2vPXD57Z
	 qmaM0oYDkPdWNPmSePh4t6qQD0PRqcwD0Er1ivUuaVlcU6x+h2/vT9yrGzetZfBeNw
	 oK26hu9i62J/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] usb: xhci: Remove unused parameters of next_trb()
Date: Thu, 10 Sep 2026 09:42:51 -0400
Message-ID: <20260910134254.352939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090813-valuables-reuse-daab@gregkh>
References: <2026090813-valuables-reuse-daab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 6b2eb0621ffb3ee9f3e497b483e8088436bdb07e ]

The function has two parameters which it doesn't use and hasn't ever
used. One caller even puts NULL there, knowing it will work anyway.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a337e1fda33db..38e118047ff4c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -136,10 +136,8 @@ static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
  * TRB is in a new segment.  This does not skip over link TRBs, and it does not
  * effect the ring dequeue or enqueue pointers.
  */
-static void next_trb(struct xhci_hcd *xhci,
-		struct xhci_ring *ring,
-		struct xhci_segment **seg,
-		union xhci_trb **trb)
+static void next_trb(struct xhci_segment **seg,
+			union xhci_trb **trb)
 {
 	if (trb_is_link(*trb)) {
 		*seg = (*seg)->next;
@@ -359,9 +357,9 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * avoiding corrupting the command ring pointer in case the command ring
 	 * is stopped by the time the upper dword is written.
 	 */
-	next_trb(xhci, NULL, &new_seg, &new_deq);
+	next_trb(&new_seg, &new_deq);
 	if (trb_is_link(new_deq))
-		next_trb(xhci, NULL, &new_seg, &new_deq);
+		next_trb(&new_seg, &new_deq);
 
 	crcr = xhci_trb_virt_to_dma(new_seg, new_deq);
 	xhci_write_64(xhci, crcr | CMD_RING_ABORT, &xhci->op_regs->cmd_ring);
@@ -654,7 +652,7 @@ void xhci_find_new_dequeue_state(struct xhci_hcd *xhci,
 		    link_trb_toggles_cycle(new_deq))
 			state->new_cycle_state ^= 0x1;
 
-		next_trb(xhci, ep_ring, &new_seg, &new_deq);
+		next_trb(&new_seg, &new_deq);
 
 		/* Search wrapped around, bail out */
 		if (new_deq == ep->ring->dequeue) {
@@ -703,7 +701,7 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		if (trb == td->last_trb)
 			break;
 
-		next_trb(xhci, ep_ring, &seg, &trb);
+		next_trb(&seg, &trb);
 	}
 }
 
@@ -2121,7 +2119,7 @@ static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	union xhci_trb *trb = ring->dequeue;
 	struct xhci_segment *seg = ring->deq_seg;
 
-	for (sum = 0; trb != stop_trb; next_trb(xhci, ring, &seg, &trb)) {
+	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
 		if (!trb_is_noop(trb) && !trb_is_link(trb))
 			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
 	}
-- 
2.53.0


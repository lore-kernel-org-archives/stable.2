Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5F3DD875
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038515; cv=none; b=W1x97lQqkAs8FCV5qdQFIQNDtkO2hARXa/rmEBCgqfQmdvoECCjk7bAvtHeBffbKzA81PeDOWiyd3NuWuTO7DhiiNbtboiGTjbObCZxsVaE7icRZt0JTrEBDFDHcZ3XK29n2/qIy2KzVkKgLSqv/8WbLmennPn/8FcF4E8eVYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038515; c=relaxed/simple;
	bh=QU+ffykY60X7ScUqvbgHLNRK2aEWzCnMLAreGIHAChI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRjKCCvwH9CkuqJgcrKvmXXXPJn+Hs5rL/HQVN5PLrIpWf8cIWRTziXN2wl+z5/Gmox0/24f7ed44htsFhOsHHxhL1CjBGXOHXifUOq10xlRI8ZdkeaMBsml+FNhykzHwT+bBt9r9oYMjhpYWqQ9A8b8BZfsTVUqFxHPIziaD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YigW1Qon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YigW1Qon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F041F00893;
	Thu, 10 Sep 2026 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038513;
	bh=cjJfFaeSlBJWmescM8zvwxHScxS6TYCESGaP8kw9DVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YigW1QonOJOcLV8zJyTUAK4ONyX4pUUxP0uz7B81y8AwCLrUJyGld+b4eVbQe8fMU
	 ME2lp8gCZNNJoB0IvASFpwdu8VR0BzTUudoYKiPLYegtiGhRKe5vXGYu5cgTEKJKeB
	 iypfWkxfbFZPo/6XxcXMnTLW4l5eZDntWSDkBYJh6YqctqOPGwTlma62KF/jptJ5o9
	 2kwlErO38wDQu4KHUVLTEfhUjXjwCd3n1OuivVx0VM9GtVO/dHPJvQvyZSbezgCwSq
	 VPSWIKC9E/4L7/DxZYQeOKRUlky5mWESLPUvYM1oSswWN6t4mDUyHPI2eIxfFfqd2R
	 jW+d4pf4cG1/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] usb: xhci: Fix sum_trb_lengths()
Date: Thu, 10 Sep 2026 07:08:28 -0400
Message-ID: <20260910110830.4144529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110830.4144529-1-sashal@kernel.org>
References: <2026090811-curler-hatchet-10b9@gregkh>
 <20260910110830.4144529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit ae71f9b88e5a15fed17a432e21c30ee9463ed1a4 ]

This function is supposed to sum the lengths of all transfer TRBs in
a TD up to a point, but it starts summing at the current dequeue since
it only ever gets called on the first pending TD.

This won't work when there are cancelled TDs at the beginning of the
ring. The function tries to exclude No-Ops from the count, but not all
cancelled TDs are No-Op'ed - not those the HW stopped on.

The absolutely obvious fix is to start counting at the TD's first TRB.
And remove the now-useless 'ring' parameter, and 'xhci' too.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 486c8afd81706..85d68e74e86a8 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2354,13 +2354,12 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	return xhci_td_cleanup(xhci, td, ep_ring, td->status);
 }
 
-/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_trb */
-static int sum_trb_lengths(struct xhci_hcd *xhci, struct xhci_ring *ring,
-			   union xhci_trb *stop_trb)
+/* sum trb lengths from the first trb up to stop_trb, _excluding_ stop_trb */
+static u32 sum_trb_lengths(struct xhci_td *td, union xhci_trb *stop_trb)
 {
 	u32 sum;
-	union xhci_trb *trb = ring->dequeue;
-	struct xhci_segment *seg = ring->deq_seg;
+	union xhci_trb *trb = td->first_trb;
+	struct xhci_segment *seg = td->start_seg;
 
 	for (sum = 0; trb != stop_trb; next_trb(&seg, &trb)) {
 		if (!trb_is_noop(trb) && !trb_is_link(trb))
@@ -2550,7 +2549,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 
 	if (sum_trbs_for_length)
-		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
+		frame->actual_length = sum_trb_lengths(td, ep_trb) +
 			ep_trb_len - remaining;
 	else
 		frame->actual_length = requested;
@@ -2633,7 +2632,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		td->urb->actual_length = sum_trb_lengths(td, ep_trb);
 		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
@@ -2654,7 +2653,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		td->urb->actual_length = requested - remaining;
 	else
 		td->urb->actual_length =
-			sum_trb_lengths(xhci, ep_ring, ep_trb) +
+			sum_trb_lengths(td, ep_trb) +
 			ep_trb_len - remaining;
 finish_td:
 	if (remaining > requested) {
-- 
2.53.0


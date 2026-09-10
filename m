Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2048A2CC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044773; cv=none; b=Y8nA34gtjd38KSsVQ5tvO+2kNZN59KSxqgu9a97eLSAoo/pbx7GQu5TxIx/Ie2OBG4wpITXyOtNvf+wSxO5Sxd9rL9/xqC4QoakXZa+L7A16MNQ8Na5siX/F/Od/4I5hYYua1ATSa2IRgAHTUKG8sdEOe1T2bV9eEM5eWD7EQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044773; c=relaxed/simple;
	bh=mFf/BV9IkrOrX2o8Htbc1TDiemb/ZY8DvOCYbIXhsP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ4+l7TVZUFYvMhqNmcOErNlw8pKVOYEKWsQV4AjsZOz30GDB4qnjAZfLBPZIcoB/FukMOPzwspou+ssWFq4fCawWVOCwHox1jorlypOw8wIxBAlq4lz7DA7aKSl51yJrkI7eUVBf7XXq4zGu36NNubg/2Xa3SPzm/wymvit+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTyrB32q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTyrB32q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AEB1F000FF;
	Thu, 10 Sep 2026 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044769;
	bh=71caD3mN/xbgPmv8wiRTn2fsG1NHyVZnZJ7WaZS2/LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTyrB32qB5Uscc5qGk/aIQk6NG1bvLZUUKnyeg+Zv2soZshcHPG7Eb7HLmTrvaYoL
	 AjNjoKN0LekLjREvwcNavbbyCt5B8jsI6OBTVLaBvgSr0QwT0Q/9l2fbBLDcDy47a1
	 EoKO0M9K7CmteLh4Nzbv2PiR2jwhwWwcU8diaM4o26RqJ86kwulbwUhkYUTtWwigau
	 uBwQ/EzNJ28+QKujFv7QFVNvSGmJHMdmWt4OPWsBRoA1VM/DSYAkYjzL2iKT1rXjrS
	 uQs/8/D5IsscKxQkBkk7lpiJSo3IG3XTWGVwJE2jYg5MIV63mHmzaL59o3qQKEPKGA
	 LOU86euqHBFSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] usb: xhci: Fix sum_trb_lengths()
Date: Thu, 10 Sep 2026 08:52:44 -0400
Message-ID: <20260910125246.183042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125246.183042-1-sashal@kernel.org>
References: <2026090812-landowner-denial-17f8@gregkh>
 <20260910125246.183042-1-sashal@kernel.org>
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
index 93b6cb0e3bf0d..9ff8ab37c2eec 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2320,13 +2320,12 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2517,7 +2516,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 
 	if (sum_trbs_for_length)
-		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
+		frame->actual_length = sum_trb_lengths(td, ep_trb) +
 			ep_trb_len - remaining;
 	else
 		frame->actual_length = requested;
@@ -2601,7 +2600,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		td->urb->actual_length = sum_trb_lengths(td, ep_trb);
 		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
@@ -2623,7 +2622,7 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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


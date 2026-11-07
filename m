Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049447;
	b=q9FlIRjZVSqsMJghKQJPH1c48ECpabcmiP3ICWCnqQz8auY8rqGmSXM0/jclt0gkqhV6
	 0cTGi3rc0PvUAWkAnyWdNwpsNxp5b9Hv0IhzikqoPZDjk/LX5GbGJm2/c5b+LmSr1c1e6
	 0jWFvnAaFqroM29gaOq+Fgu3/RW5Q9Su2XG+fCtdrN7X4AsM+OHN3njQdL8/r1g2EQIKK
	 Hn9uDbancDL2GuBNTK0qr682eoHaJ8DRXrjq8JR0E+D6NAJmPJV4YSatVxRie6jf5cUUb
	 ku4ZpGpUs5cYpKbCIdqRhz+ndUFJOW8rzt1ZRY5fLl4GRBrE0TbKjZ66mrxNlLe3DDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZadWm469bRfsoiQi8A0YTRi9vcSWcTamgCPdZ3VIX4c=;
	b=BFyBKPiTAQbEkjOjytjHkCbb6QCoHMmqcqLAV+ruVSDY5zUg9Wous3fyeVb4QQolEw85
	 jEbggM0QqQ/xjB5IpPpRntSCJ2cyuKPC0eV0LnhvboEG6N3sRkTAYyWvBR4pikkAl+4r7
	 DWjFwwUzNIbuqwZLUAzGYi3AM+JlR4cOqSG1FuyO1eCIrLuvruU+pYsNUCFFiRsE2x6Ih
	 OVF7YQZV5J3nvJRbFH1ht8AeGJ/ym3wFSS5UlkuXraAISC+hvkqcHIwvENZIfcScFP+En
	 A5zim0AYBNy/Oz1CbT+SKtzulJ52Rv7WFKH2wHoii9wnU1+jOOg68RK+tMtTNRxGz3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmaEaVVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A08606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmaEaVVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF9B1F0089F;
	Sat,  7 Nov 2026 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049446;
	bh=ZadWm469bRfsoiQi8A0YTRi9vcSWcTamgCPdZ3VIX4c=;
	h=From:To:Cc:Subject:Date;
	b=MmaEaVVXxUagsrrBWOgA8b9mrKPbceDYNzdozKJRtWh+A20+79F53LI70zAewL+FP
	 qk435YGtU1ORJ+YzboLEICdBznEAEgn3izlYMVgF0PFq1zEVCBJZu/zPx1lcBKNZDF
	 AUrC/YDPxkvtRwOiPVeK9W+IALfhZ6y1CPmHi8sXAasIXDJH8zLI78po0NGcxuSN0t
	 llU2HQFl12EeYVc0DoRmkovqHt7r/MyZYCsddXg1cbVEnor64uTLltov0fNvYLwndj
	 MHJ1tLR2lBoH/UcypYr+FNYok+ACwrM5igXTT02iLrrtE1RdZygsNCcVDZPuI+WomT
	 YW4mVT7vHz91w==
From: Sasha Levin <sashal@kernel.org>
To: michal.pecio@gmail.com,
	co+fd80bc5967eb22c3@bugs.sh,
	mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: xhci: Fix bounce buffer overflow" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:04 -0500
Message-ID: <20261107060404-failed-5.15-68c5cb7574c5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68c5cb7574c567e83ba95258cb146db95e069a87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060404-failed-5.15-68c5cb7574c5@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68c5cb7574c567e83ba95258cb146db95e069a87 Mon Sep 17 00:00:00 2001
From: Michal Pecio <michal.pecio@gmail.com>
Date: Fri, 9 Oct 2026 18:16:23 +0300
Subject: [PATCH] usb: xhci: Fix bounce buffer overflow

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
---
 drivers/usb/host/xhci-ring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 243b1fd2b2f68..c23434001e9cb 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3546,15 +3546,13 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 
 
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
-			 u32 *trb_buff_len, struct xhci_segment *seg)
+			 u32 *trb_buff_len, struct xhci_segment *seg, u32 max_pkt)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
-	unsigned int max_pkt;
 	u32 new_buff_len;
 	size_t len;
 
-	max_pkt = xhci_usb_endpoint_maxp(urb->dev, urb->ep);
 	unalign = (enqd_len + *trb_buff_len) % max_pkt;
 
 	/* we got lucky, last normal TRB data on segment is packet aligned */
@@ -3699,9 +3697,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
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





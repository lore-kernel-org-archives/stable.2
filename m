Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366273;
	b=QLqus60+6jClH6WuBCEdm+utoT7bzMhJgUUT0cqfri1F3ZngCfP5Vozyti5AbrBJMaz/
	 v8bg6tkfPod5fEVdouAjH+TA85aoB8RXzdtRcxUFT0XDj8SKwZGKd8AwvsdXiArBML8p/
	 kSmmIXegI8b5U5ocIjpVmQyYyM1fYuwAWXydmm2rYmMEgMMgmCt+sLxYZj4LS0Q4fUXC6
	 uZPkpPCLA756a7CslYxRcU0NwuZ3jCQvfIvrY52omFZvri1g7FsfKacexp5ObKcbhi4hv
	 VojmfSYxvJZSm+kMKsdL8PSHGHr9/JGTf18RDA9jEnmiTZz7pU8V1Zos6ll1jrQPkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FLc8OS3yOcSQvrrfZGbTTGfzjWbdUmKSvpiH7/lFaKE=;
	b=OBDrS3AB/D1LDyEVsCdb6DYb9gyQGszoPFEcnwNFBrwLGU/xCZRvc8kRbQ3BJbUfK49n
	 vlIb6k1ZOSah5ZnE2GRkShqM3DrYmmr7WTnsxoyv6uH0AxT/pvZKQDIfbOpgH2K4g3reK
	 PfixpNRQaQ3LEVmFDxnWWnEBsKM29yPqFJOWbCTLHygMWonYCC1hSZJzl75qSpAsc1ZbE
	 LyKt1wIjQSQx0d2LgO7Kd++ytnqmAzZJVbh+TQkd1ALntecx9TCBq5Y93JGeX2hZKbpzg
	 h85Z6e/S2Dr0dpPFe7VkaTcPAg8FDOI7/z2ZWnPwycLz0oT2so011DaxohbRsUwelaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La1k14ZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7655606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La1k14ZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E81F00A06;
	Wed, 11 Nov 2026 03:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366273;
	bh=FLc8OS3yOcSQvrrfZGbTTGfzjWbdUmKSvpiH7/lFaKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La1k14ZKWouA8Py4ovwDFrA92cciG2kqpROze1O7eltdI0wIJLSoZYjwAWH6c1Thf
	 wUVM4i5J+sNfKMjHXXos0XkFPUotuaahWVh0uFQ9rOIzuZB/soruJrYq5QXrKn8LPm
	 9ggRjmTn0rrA6RiVOuHqsDPUuJQcNKXXDPctNSlrleOaU90ON8hA40OaEUu6aGXe4d
	 w6hXKHqqrZHw7OF3I1uH+PalM4fhOTx0RinympZ3DvjYHDsnK0molFvZJYW8o5lGeZ
	 Xe3e1DDOmTWTzfF3IDO/09CITJ9tszfxapduS/yGjfDjKmlD1vtFsWG3H7/LsfxqW4
	 FTn0AiwN9oaqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	co+fd80bc5967eb22c3@bugs.sh,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: xhci: Fix bounce buffer overflow
Date: Tue, 10 Nov 2026 22:04:31 -0500
Message-ID: <20261111030416.561131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062048-failed-5.10-68c5cb7574c5@kernel.org>
References: <20261107062048-failed-5.10-68c5cb7574c5@kernel.org>
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
[ sashal: adjusted context for usb_endpoint_maxp() in place of xhci_usb_endpoint_maxp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 0e0045a81f92e..51b614c0c9357 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3389,15 +3389,13 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 
 
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
@@ -3542,9 +3540,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
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


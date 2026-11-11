Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362335;
	b=GGaww0N40iNR8mq2WJNB1b84Dswduks9sFNSMM0wj4bVejOgZNHyrRKYLkor6zBWN7Vy
	 m/RZYxFy0gbxPfLDLFP7pTTjVdbY+KGL8G3C0fEwE4Ck9ug4vFllOKnMgPoWclcvQubF3
	 ATBqmvFzpPz28aLgXnteD1YWzIJ3TPazbE1t7K5bYLR+YINI9kSFRzTpDr/y2FpS4wc7t
	 HlMVvdT0YU4pGjTVtATVSihINfTRh6UQVLUh86kS1/F0ECjQdiY4NfAM5KdomnzUbEQ0S
	 x+kzOJsRsi98xQ9ldzgHHlg2p58oo2pAUiCruXY5t1TfR75VQ/v9/I5EGZxy1+Q4rCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q2Qp4I9mugg7zt14rymyK+BCJqCm9CtBY7Z2+UJKMIk=;
	b=omr1jSH1+G1mkG9/ea6p1atMqq2LDD0Kr58bjPxEJsM/3zR3dKGRPtZec10GDu4tEyap
	 Hum6IsDRNvP7OsdVvLJg8hxOJRYz4QjVvXM3pYRRwLriwG/uHjnlPX0kOIcG9VuxbRvdH
	 8RynCtu3n31TNU/yW/QGY0m45b8GYD4NaQ433OznubquQnPEnnJFel2Nk6iESK7XnpFDh
	 VdV8vi2sJvBy8iRQ2Omrzj1RoxWhd7KscFpKt0qGVTr8IqTe/mKGkLkKZ5hyZm+QZHaFd
	 OU7GO6pEcGP3mrLneLtKNJ5PjHk3VbkJyr1mpv2MRPGrYJT/xR4tTZ1o8HQaKC1FCag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARwlELG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARwlELG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA6D1F00A03;
	Wed, 11 Nov 2026 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362335;
	bh=q2Qp4I9mugg7zt14rymyK+BCJqCm9CtBY7Z2+UJKMIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARwlELG4z7L29BeX8Rz0CFM3d02mTmFLMSLUU25UC8PWjt6hR5IdnFAndu3t8oFrM
	 YZsdtql1s6MnHEp7GRKGSP31Z0hb82pVZYc1r8CmQbEa6IB2i0T0Vjp7mjikQN4OqQ
	 XrHHQ6IAZsBPY9wr5spru96AZH26vyQ4E25hmwMtlPSazBUKCP6SY1dp34b+HNQUTy
	 b7vP9XqX8wuB1pcK6aCWU02L/PhVtSsbr9NhfKMGP10kt+MFOU77IoUG21d6DcE7Z3
	 IPESNZpNYvT9/JMuIoOAXWN0cmSvH9bFsIoiSdYXQwE30b1Ws9pUecVO/QNsUQHz4z
	 ktuiOoQ51Or5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	co+fd80bc5967eb22c3@bugs.sh,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: xhci: Fix bounce buffer overflow
Date: Tue, 10 Nov 2026 20:58:53 -0500
Message-ID: <20261111015415.463257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054639-failed-6.1-68c5cb7574c5@kernel.org>
References: <20261107054639-failed-6.1-68c5cb7574c5@kernel.org>
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
[ sashal: adjusted the max_pkt replacement for the existing usb_endpoint_maxp() call instead of xhci_usb_endpoint_maxp() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 3f34aa004bc98..9c1b97846266e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3619,15 +3619,13 @@ static u32 xhci_td_remainder(struct xhci_hcd *xhci, int transferred,
 
 
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
@@ -3772,9 +3770,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
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


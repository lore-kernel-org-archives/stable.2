Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047613;
	b=pU5y07lHtw2ZEkHv/gsoxkLkYhdR3YPsi7ryVSY1LMgwSQmYcFXQs/+JwhRAkkgVLl6E
	 dldqsQnjUMfYqXWx6WZPVkJxTa/mEJW0Mk1+TM+jQ83F18nLloi1j8kIdutnW9EKLylZO
	 72VJoAAd3JyVYh6+jcl7z7NrrGoD60UJxV/IXuVjhlm2Ajlj2h5XGIJBVv495A7oKeOlw
	 NGKdnrM1gXCkDuvZVGhYQA59QOtAd06ZobVwsVwE1MWi7YXWJDsOP14kEsG/bfEyzinsB
	 4e1NOgdMTKoR+xW7hJAV053YZEJDUy04hFJW/OopIcObbWOSHU1dM0wa6kL0SJ6lAjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=js7ajQAyOnx5ogmVfswlWkKJqrTxZhfp/aLPsyt4N3Q=;
	b=xJXu7cYFTa/llQ66MHZ+UwXAQeJ81j6kvq6WQ3xMJytk6xEoXLHRfyozOdIT1ogzPyOb
	 PnTZ1BL8H0O0K8xDydQyDm+8GgzuW2GDWCDbGa7dhhmtNMbpKR22ilg0nITtCslp/alCJ
	 JeUr2yo4CtHpM0oSeXq/6boLiQIdOs99ZiMSMkB9VD+jJWNRoH3JDg5rpHNteDrSm62tP
	 IAOSAN6vwj9vFcE9bQp/3BhkYiV0XF2XQm9Z2kPwrDIx7VAFTNlbLpmSbLTGEpNe8dYuL
	 VkVMjrHju3UF14miVDkp9CNr3keykaH+9+4iE+9PHG+1RXh7Ay318wItGL/Lgukmkyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI0nWU+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF42606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI0nWU+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293321F0089F;
	Sat,  7 Nov 2026 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047612;
	bh=js7ajQAyOnx5ogmVfswlWkKJqrTxZhfp/aLPsyt4N3Q=;
	h=From:To:Cc:Subject:Date;
	b=RI0nWU+csEjR4lhn2yDVA5jnoIvWYE2h90shd1VWtESGCLqRxkADbrlq75Ay8VCEf
	 AmGjFPG816HRP+qF9gWyN9IOt9RJRoBXhrtrzzv7u+NnAXBkq4NrPzAqWolECOmcsA
	 EMHSSjerkrIZUpzOiyUokJkflkO1ZdqS5/lfVFz2H1cGp8TT6/7OssJBIfu+jbImhy
	 5WTmWue6ps8hsTMpyzdmxGvxsiGr6n5Mhv2OAyUkiwBmyDC/+0n8vOZemM6/x4b1yH
	 tYhWMjBM0lShaFZLuhSVeGIjebvMiZVdYgHMcdLJQSv/hSeyDLg5kmQ0IR1Zsuumxi
	 cU5cp0QzHqlxQ==
From: Sasha Levin <sashal@kernel.org>
To: michal.pecio@gmail.com,
	co+fd80bc5967eb22c3@bugs.sh,
	mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: xhci: Fix bounce buffer overflow" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:31 -0500
Message-ID: <20261107053331-failed-6.6-68c5cb7574c5@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 68c5cb7574c567e83ba95258cb146db95e069a87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053331-failed-6.6-68c5cb7574c5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





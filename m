Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048402;
	b=s96J2Evpq9y+BpONKNIp0CC4UvkGXK+e+BHirFWxQ37vLDINid13pM2Fm1nLH0kd78cP
	 AZoW+/ke/Ql8k/1U8xSXY6ASMGx8fXessCLI7HRRbqDDpUhG2+x90R4L4tkDf0YdFPMjE
	 fAXFIpAKUjbjf21bZfPoZedXhkY7BWwROq/EobI2MIitLPJa3kqpu/wMW5rQC3hWOnZBp
	 X5vBjPC9WJhaTSFlVaU15rOKcvYKtgKdLnTZ0vyY7K2ayWWUosWv4ivbBwkI2PH3wZda+
	 xW4tRK8Ix3BKrTJDbX0VnVhZtc7wkanWzvQFxExIaarrKh99s0Q9UoNw+hI0ZvExe9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IuiEChYzu9J15GDWpHxdTMH4EPp5DfU09YKNiVT6HD0=;
	b=iL0gmkaafCcWFE/Amkt9YIWMpRL0SeIxIS8XojqdTToJyBegyEPoTeYwAxpLqfUWgU+c
	 bXy4R2FUKcQvguuLAVfwKlhNRepubnxWFd8HGs18ZyB15fRygPIgbaKAqTAk63ar/zcRb
	 PbDhFPvKgainbgNS9Py2yysrt09AVQ2VX6HNObQS0l2gpoX/S+k8QODYZ1Uy793W9rZOx
	 khCOty3wvTmhIZlAz3dY3rgecMcYCDl2wErZuWAoLBiHb692FMggvoVyZ5IS2lhQQ3wgr
	 Yj5XUhRL6qSq3Aqg9+5rZaqRL9AHX9on8BvTHlRxZzqUtCOpzQkXHQw6AJK4t2xJdMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBefeQkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA86606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBefeQkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC401F008A1;
	Sat,  7 Nov 2026 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048401;
	bh=IuiEChYzu9J15GDWpHxdTMH4EPp5DfU09YKNiVT6HD0=;
	h=From:To:Cc:Subject:Date;
	b=RBefeQkUxHn7os/ODUXCY+UY3zL5is1iZhY+w+CrNdVVaKSo2w8Iws9ujwxphhadc
	 Ww0yfWuetrnN6U00x/vFBmFLCLxraIK6rhZ4g29+FD1pu6YciHJV0fDixCbuNMYYh3
	 WuHKwUF2hpMKESQhCSAxpa7J1+yNDSo7U8fSFm+NsW6UADW9krb9em5kjcos1dlKik
	 SQ8SK2VQ4xuEUsPmsnz4zs9KBQJLs/9dzAbwaXxsNifynO08Nh5SUMwJfOB/pQXIY0
	 MvVksIkOxr6boeiYn+gFl0pzLIXkdNuGdE9W1Qup3fVIv3VSD2x8ObHmQhDsMDHhrV
	 cGV5pVEPVGcng==
From: Sasha Levin <sashal@kernel.org>
To: michal.pecio@gmail.com,
	co+fd80bc5967eb22c3@bugs.sh,
	mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: xhci: Fix bounce buffer overflow" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:39 -0500
Message-ID: <20261107054639-failed-6.1-68c5cb7574c5@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 68c5cb7574c567e83ba95258cb146db95e069a87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054639-failed-6.1-68c5cb7574c5@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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





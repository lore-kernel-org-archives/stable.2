Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273967;
	b=zUHltcBCkubNdeA/ACEEeONgq8pR+agTsv188YbvJ1jyjzwovZtcBcgFszXUvPFb8KFI
	 cwi6vsKc5QijZx3cI5G8kFchXBw59XdTZLK+oD1b6v7NzgKGjD+eSRKWkBcsIO/8DLNpn
	 6S1stjS4yeurMyCsrm/s6a4pmNeAf4nTp/546DnDeEL77KkW35sTcCp38Ev/u3GPHC3pR
	 0BeTlZMQ/ddyGIGUeTRwAB+SanH3jW2Mv/kDYgr1vncNc9wep1juKNTA/7JSzcxV7BewT
	 DGtq5jx5+0vDirYP5yxpTt3W84a0vl19QgeckViY5x3vf32dNel0e0iCX0Cg7RoB4wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273967;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g//AmIYkDNj7cTYqYfqTf2ATtSgQQWGoqzn1IkSPZnQ=;
	b=PSXzWgE3/vJwQxc1iZnMz/mKOswN+F0hTZZPpA3tvCcPEkRaFUn4qECIkF1MGyrSt6dK
	 gNBjLbrbw7ZVtcnV1FUENctVM2kVNGUuH00Yk0oSs/W+AtJop/57XB2aJ1nbyZaqjQ2Kz
	 b/LdpA2j3gntvdyDgJIWBR7LBXDoDYtkbQ1HcadBCiltOw6qVNn/1U36QAsOZUNORvGgo
	 2E5ftQOR7YqdGdn2kxzVfN0eRNuQvJtUX3gTHfw0fIgm+H+v/JeF+OYMu9PV5G/w8Bw+y
	 197tPH6JIjwn3KYMQAdNb6eD+31aum3GNz2s4soE4S3UqM9RNn4CPYkihUlc93S/KNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=UA2Ow9fS;
	arc=none smtp.remote-ip=115.124.28.173
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70727606A320;
	Sat, 21 Nov 2026 15:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70727606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=UA2Ow9fS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795273955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g//AmIYkDNj7cTYqYfqTf2ATtSgQQWGoqzn1IkSPZnQ=;
	b=UA2Ow9fSKU4jBjUkUJf+Ovzw+UawX8PCH14FjDA/lE+ZasajpqljYMF6hiHh5rEATTUeJu/OmUhopzjHfjQ5ambo+CvH9Yjrjy94Ug0YiSZC6HBzssQ5zZnEp2+MPlgxtfroMkR4P4kCLohqmuNQ0Ocx7o7xRj7fDRty6X7SHek=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0443626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0257633-0.000732468-0.973504;FP=304553285648911859|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.k7FWlbt_1795273953;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7FWlbt_1795273953 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 23:12:34 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Johan Hovold <johan@kernel.org>,
	Roland Stigge <stigge@antcom.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2] usb: gadget: lpc32xx_udc: handle interrupts with an empty queue
Date: Sat, 21 Nov 2026 23:12:33 +0800
Message-ID: <20261121151233.82306-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

A request may be dequeued after its DMA transfer has completed but
before the corresponding DMA interrupt is handled.  For an IN request
whose ZLP is deferred because both endpoint buffers are full, the
endpoint interrupt remains enabled to resume ZLP transmission and may
fire after the request is dequeued.

lpc32xx_ep_dequeue() removes the request from ep->queue and gives it
back via done() without disabling the endpoint interrupt or clearing
pending DMA interrupt status.

When the interrupt handler then runs with an empty queue,
list_entry(ep->queue.next, ...) derives an invalid request pointer from
the list head; list_entry() does not return NULL.  Passing that pointer
to done() in udc_handle_eps(), or dereferencing req->dd_desc_ptr in
udc_handle_dma_ep(), results in invalid memory accesses.  In the
x86_64 test configuration, the bogus request's complete callback
resolves to NULL, so the giveback path oopses on a NULL function
pointer call.

Check whether the request queue is empty before touching the request in
both handlers.  In udc_handle_eps(), do this before sending the deferred
ZLP and disable the endpoint interrupt when there is nothing to
complete.  In udc_handle_dma_ep(), still disable the DMA channel and
clear the pending EOT/NDDRT (and SYSERR) interrupt status so the
interrupt does not keep firing, without dereferencing the missing
request.  Both interrupt handlers hold udc->lock while checking
ep->queue and obtaining the request and its DMA descriptor.  This
serializes these accesses against queue updates in
lpc32xx_ep_dequeue().

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
Changes in v2:
- Drop the ep_err() print in the DMA empty-queue path and reword the
  empty-queue comments: this is an expected race with request dequeue,
  not an error worth logging (Greg KH).
- Describe how the issue was found and tested below (Greg KH).

v1: https://lore.kernel.org/r/20261109121035.34561-1-fangxy@xiaopeng.com

The issue was found during a security review assisted by the Hawkeye
agent (LLM-based code analysis) and confirmed by code inspection.  No
LPC32xx hardware is available; the driver builds on x86_64 with
CONFIG_COMPILE_TEST=y.  Reproduced in a KASAN-enabled QEMU/KVM guest
with a synthetic trigger that calls each handler with an empty queue.
The synthetic trigger invokes both handlers with udc->lock held,
matching the locking state of their normal IRQ callers.  The same
trigger also covers non-empty DMA completion, deferred ZLP and the
dequeue-then-interrupt sequence: the fixed driver completes the normal
paths and returns cleanly from the sequence.

The unpatched udc_handle_eps() path crashes in
usb_gadget_giveback_request():

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x0
   done+0x1b8/0x390 [lpc32xx_udc]
   udc_handle_eps+0x236/0x750 [lpc32xx_udc]

The udc_handle_dma_ep() path was exercised separately: it dereferences
the bogus request's dd_desc_ptr, logs "DMA descriptor did not retire"
and "DD not serviced", and reaches the same NULL completion-pointer
call in done() (RIP: 0010:0x0; the handler is inlined into the trigger,
so its frame appears as lpc32xx_udc_init+0x40a).  Both patched handlers
return early without accessing the missing request.

In the x86_64 guest, KASAN does not flag the accesses themselves
because the bogus request pointer and the fields accessed through it
remain within the enclosing UDC allocation.  Although these accesses
use an invalid object pointer, they do not cross a slab allocation
boundary.  The crash occurs later when
usb_gadget_giveback_request() invokes the NULL completion pointer.

 drivers/usb/gadget/udc/lpc32xx_udc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 044c31869cfb..477f897043b8 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1945,6 +1945,13 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	/* Get endpoint status */
 	epstatus = udc_clearep_getsts(udc, ep->hwep_num);
 
+	/* The request may have been dequeued; nothing is left to complete. */
+	if (list_empty(&ep->queue)) {
+		ep->req_pending = 0;
+		uda_disable_hwepint(udc, ep->hwep_num);
+		return;
+	}
+
 	/*
 	 * This should never happen, but protect against writing to the
 	 * buffer when full.
@@ -1958,7 +1965,6 @@ static void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	} else
 		return;
 
-	/* If there isn't a request waiting, something went wrong */
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
 
 	done(ep, req, 0);
@@ -1985,6 +1991,23 @@ static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 	ep->totalints++;
 #endif
 
+	/* The request may have been dequeued; still clear the pending interrupts. */
+	if (list_empty(&ep->queue)) {
+		u32 mask = 1U << ep->hwep_num;
+
+		ep->req_pending = 0;
+
+		/* Disable DMA and clear pending interrupts */
+		udc_ep_dma_disable(udc, ep->hwep_num);
+		writel(mask, USBD_EOTINTCLR(udc->udp_baseaddr));
+		writel(mask, USBD_NDDRTINTCLR(udc->udp_baseaddr));
+
+		if (readl(USBD_SYSERRTINTST(udc->udp_baseaddr)) & mask)
+			writel(mask, USBD_SYSERRTINTCLR(udc->udp_baseaddr));
+
+		return;
+	}
+
 	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
 	dd = req->dd_desc_ptr;
 
-- 
2.50.1


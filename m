Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710118;
	b=zFBKj0PAzIT54aNQnthYNHg8zO04QvzQybEo3Q7bT0Qr8vIXXKMB6HfO/k0DnLyPtjvd
	 GMGN/wBSMfO+6A5mQ4qpdY3k6FYHbhALe79RFrX12psJGsZ9kb2doV3niJqTYL5OjvHWh
	 nRURY6sQDJqF/YfX1VhKtV1mcQ0XWsK/Co/h5d49SDwzZ6fJYfNfrCTEu2PgnsyMbM/M4
	 ZcBQfONRHShDWBnw3vg718K9fPlqAWGlxcEWYv1BkVUQVHkAedCsaOJvPoCGMAjKIhEpA
	 702TfvM/4CzX/CAQulyInVDcm16G5VzcJURflTsr3xQyNSnt/owij4bZ+WdWHwCg1zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hvW+hXmV+4c/SegDBJEmL+eo5nPCDsfSBXxJbSNF8os=;
	b=VN5TjAe9IxXcJwSTbxNCy9ZVdc9/7+1bq22VX6FkuGgG88lY3pV3nUEf5Abycu3onVOB
	 VMKJcv5mjmAAV2MrTPhxOZ8KvomYBqelc+ER+pPsVmtVp9Sma1ofCraTFafCHQ2UdOVKo
	 TstL4ttqwrMaY+eID9LXmgaS2gOWOl8QFOAcH50ZN+8skYhDUq0bP+xNeWmUW6getB7Wu
	 mlDJ3QNVQJsl8YSUlQC+2TSCrzHWNMH2FMk+cxtPn9gfOIv/HnDchgmwEMZ/GLTrCAQ8+
	 seom5fTskvMO6aNsLbqnkZyZjwjCNVkP60sRUMpetYhbvd2cU0K+Rg43TluAZ/t3fAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEb9NyuF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEb9NyuF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C7A1F000C4;
	Thu, 26 Nov 2026 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710118;
	bh=hvW+hXmV+4c/SegDBJEmL+eo5nPCDsfSBXxJbSNF8os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEb9NyuF7s0uj3s/8p8WfBa7jlO62F9vn9jUEX5+5Ihfy7scvWDq5MMha4kglC/u+
	 cNr070FN/Cv1Ss+lCXCBoDZOJwSwutTV0WhQFV//SzJXPzTvsR0CuLBP5a/U0utv6l
	 lkQVJG0PZa7kMg01BwBz2UMeiLW7wl0OUwBMiPLmYKH6rt0e1dM3+0Qt6T2AgFiIqW
	 gz6R0s8VcnfSvwtJN2u/wuzS/XRY6Je8n4Ss1dWIRTWBoPY1DbFyzwFELDuohCZ3Tg
	 S453tw05FC/0H2hRRvG3zCTstVzAVE0I3TdWLORP805A+ei7NDgbfkDQGCc5cDXiB0
	 9517gPZlFaDfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zain Aboobacker <zainaboobacker33@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] usb: xhci: fix typos in comments
Date: Thu, 26 Nov 2026 11:21:55 -0500
Message-ID: <20261126162118.2536749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-handcraft-impolite-2d69@gregkh>
References: <2026112543-handcraft-impolite-2d69@gregkh>
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

From: Zain Aboobacker <zainaboobacker33@gmail.com>

[ Upstream commit d7458590f585aea58f24047195f163adc6ecb045 ]

Fix various spelling mistakes in comments found by codespell.

Assisted-by: Claude:claude-opus-5-5 codespell
Signed-off-by: Zain Aboobacker <zainaboobacker33@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261009151624.618967-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6895dbdc19d9 ("xhci: give back TDs and clean up ep0 after disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 14 +++++++-------
 drivers/usb/host/xhci.c      | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fffd901b59e7f..aedb2af01e2f7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -243,7 +243,7 @@ static void inc_enq_past_link(struct xhci_hcd *xhci, struct xhci_ring *ring, u32
 		 * fixed in the 0.96 specification errata, but we have to assume that all 0.95
 		 * xHCI hardware can't handle the chain bit being cleared on a link TRB.
 		 *
-		 * On 0.95 and some 0.96 HCs the chain bit is set once at segment initalization
+		 * On 0.95 and some 0.96 HCs the chain bit is set once at segment initialization
 		 * and never changed here. On all others, modify it as requested by the caller.
 		 */
 		if (!xhci_link_chain_quirk(xhci, ring->type)) {
@@ -661,7 +661,7 @@ struct xhci_ring *xhci_triad_to_transfer_ring(struct xhci_hcd *xhci,
  * Get the hw dequeue pointer xHC stopped on, either directly from the
  * endpoint context, or if streams are in use from the stream context.
  * The returned hw_dequeue contains the lowest four bits with cycle state
- * and possbile stream context type.
+ * and possible stream context type.
  */
 static u64 xhci_get_hw_deq(struct xhci_hcd *xhci, struct xhci_virt_device *vdev,
 			   unsigned int ep_index, unsigned int stream_id)
@@ -989,7 +989,7 @@ static int xhci_handle_halted_endpoint(struct xhci_hcd *xhci,
 	int err;
 
 	/*
-	 * Avoid resetting endpoint if link is inactive or device disonnected.
+	 * Avoid resetting endpoint if link is inactive or device disconnected.
 	 * Can cause host hang.
 	 * Device will be reset to recover an inactive link, so don't do anything
 	 */
@@ -1384,7 +1384,7 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
  * held for the URBs to finish during device disconnect, blocking host remove.
  *
  * Call with xhci->lock held.
- * lock is relased and re-acquired while giving back urb.
+ * lock is released and re-acquired while giving back urb.
  */
 void xhci_hc_died(struct xhci_hcd *xhci)
 {
@@ -1969,7 +1969,7 @@ static void handle_device_notification(struct xhci_hcd *xhci,
 }
 
 /*
- * Quirk hanlder for errata seen on Cavium ThunderX2 processor XHCI
+ * Quirk handler for errata seen on Cavium ThunderX2 processor XHCI
  * Controller.
  * As per ThunderX2errata-129 USB 2 device may come up as USB 1
  * If a connection to a USB 1 device is followed by another connection
@@ -3087,7 +3087,7 @@ static void xhci_clear_interrupt_pending(struct xhci_interrupter *ir)
 
 /*
  * Handle all OS-owned events on an interrupter event ring. It may drop
- * and reaquire xhci->lock between event processing.
+ * and reacquire xhci->lock between event processing.
  */
 static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 			      bool skip_events)
@@ -3798,7 +3798,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		/*
 		 * If next available TRB is the Link TRB in the ring segment then
 		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
-		 * TRB to be breaked by the Link TRB.
+		 * TRB to be broken by the Link TRB.
 		 */
 		if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + 1)) {
 			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index ec9ae4e15b5b8..d6dc696b385ac 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -406,7 +406,7 @@ static void compliance_mode_recovery(struct timer_list *t)
  * The quirk creates a timer that polls every 2 seconds the link state of
  * each host controller's port and recovers it by issuing a Warm reset
  * if Compliance mode is detected, otherwise the port will become "dead" (no
- * device connections or disconnections will be detected anymore). Becasue no
+ * device connections or disconnections will be detected anymore). Because no
  * status event is generated when entering compliance mode (per xhci spec),
  * this quirk is needed on systems that have the failing hardware installed.
  */
@@ -796,7 +796,7 @@ static void xhci_save_registers(struct xhci_hcd *xhci)
 	xhci->s3.config_reg = readl(&xhci->op_regs->config_reg);
 
 	/* save both primary and all secondary interrupters */
-	/* fixme, shold we lock  to prevent race with remove secondary interrupter? */
+	/* fixme, should we lock  to prevent race with remove secondary interrupter? */
 	for (i = 0; i < xhci->max_interrupters; i++) {
 		ir = xhci->interrupters[i];
 		if (!ir)
@@ -2047,7 +2047,7 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 
 	/*
 	 * Configuration and alternate setting changes must be done in
-	 * process context, not interrupt context (or so documenation
+	 * process context, not interrupt context (or so documentation
 	 * for usb_set_interface() and usb_set_configuration() claim).
 	 */
 	if (xhci_endpoint_init(xhci, virt_dev, udev, ep, GFP_NOIO) < 0) {
@@ -3303,7 +3303,7 @@ static void xhci_endpoint_disable(struct usb_hcd *hcd,
  * state. For software that wishes to reset the data toggle or sequence number
  * of an endpoint that isn't in the halted state this function will issue a
  * configure endpoint command with the Drop and Add bits set for the target
- * endpoint. Refer to the additional note in xhci spcification section 4.6.8.
+ * endpoint. Refer to the additional note in xhci specification section 4.6.8.
  *
  * vdev may be lost due to xHC restore error and re-initialization during S3/S4
  * resume. A new vdev will be allocated later by xhci_discover_or_reset_device()
@@ -4297,7 +4297,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		pm_runtime_get_noresume(hcd->self.controller);
 
 	/* Is this a LS or FS device under a HS hub? */
-	/* Hub or peripherial? */
+	/* Hub or peripheral? */
 	return 1;
 
 disable_slot:
@@ -4516,7 +4516,7 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 
 /*
  * Transfer the port index into real index in the HW port status
- * registers. Caculate offset between the port's PORTSC register
+ * registers. Calculate offset between the port's PORTSC register
  * and port status base. Divide the number of per port register
  * to get the real index. The raw port number bases 1.
  */
@@ -5398,7 +5398,7 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 	/*
 	 * Early xHCI 1.1 spec did not mention USB 3.1 capable hosts
 	 * should return 0x31 for sbrn, or that the minor revision
-	 * is a two digit BCD containig minor and sub-minor numbers.
+	 * is a two digit BCD containing minor and sub-minor numbers.
 	 * This was later clarified in xHCI 1.2.
 	 *
 	 * Some USB 3.1 capable hosts therefore have sbrn 0x30, and
-- 
2.53.0


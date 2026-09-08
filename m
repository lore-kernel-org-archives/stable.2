Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D81374A1B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870115; cv=none; b=S9QR1+vreJW0qbw+JdpUqxAsq81gyIRrkJzanf8y9TtD+99s/8bW1SRLOYabIrf1ZV8bI5MNR4OXGgLsk80sDKZbkN+RUA+tEujph+4ZU/wxrrVIpTPaO92XHH6szFu6NZ3trOs4RofiwFk35ACB3FbdPe7X9PbJCFQzyomeG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870115; c=relaxed/simple;
	bh=pnd44kwShD/KnEAqGPkkIZ4+EBbgy5IA4GltGVb9cYc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CQ6PttHbainCKAVbFaVW6m6Wy4LIM/czua3jJuvG0n2KUJakERr83TOeBEasq4ud09wnWfH8PC1RQSht8hI7vuzoB0oOPxGp48M+sWdIgJnajApsTOlAlcUD18mRBP3ZaZfj+Mx1byQ59D5rz2FmliOolFIEceXPXPEr5sTfV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O5gb5P14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O5gb5P14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287411F00A3A;
	Tue,  8 Sep 2026 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870110;
	bh=vLWq06S2p5jkczZm14BIW1v+qOHw/k/PZpyxGdqxOkM=;
	h=Subject:To:Cc:From:Date;
	b=O5gb5P14IaSbdVMopYusvuHgZatTQOkxvUCD9sZ7s7gTWga7j1isJutJgZjIjHtLA
	 PUHHtw9XFUMUBDdAj52MltNAn+M0xymWuDgL5ju3TnUlqV5wUxJMJhCYEI7N3YH2br
	 GNmwrMdGyviaM4uEjIuY5E5xJwZrHYGQXv6jx1lE=
Subject: FAILED: patch "[PATCH] usb: cdnsp: fix wakeup from S3 after controller context loss" failed to apply to 6.18-stable tree
To: pawell@cadence.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:21:42 +0200
Message-ID: <2026090842-ploy-extras-6ca8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x eae6460f617382044c5afe5ef202f4d8b2c099b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090842-ploy-extras-6ca8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eae6460f617382044c5afe5ef202f4d8b2c099b5 Mon Sep 17 00:00:00 2001
From: Pawel Laszczak <pawell@cadence.com>
Date: Thu, 20 Aug 2026 12:45:31 +0200
Subject: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context loss

CDNSP controller may lose its runtime register programming across S3
suspend/resume, depending on SoC power domain configuration. After
resume the operational and interrupter registers may contain reset
values, which prevents the gadget side from recovering correctly and
breaks wakeup from S3.

Fix this by detecting whether the controller lost its register context
after resume and handling both cases:
- If context was lost (CFG_3XPORT_U1_PIPE_CLK_GATE_EN set or power
  lost): reset the controller and reprogram the state required for
  normal operation, including the command ring, DCBAA pointer, doorbell
  base, event ring, ERST base/size and event ring dequeue pointer.
- If context was retained: restart the controller directly without
  reprogramming registers. Issue a wakeup if the link was in U3 before
  suspend.

Move the basic controller register programming out of the one-time memory
initialization path and make it reusable from the resume path. Also
separate ring allocation from ring initialization so that rings can be
reinitialized without reallocating DMA memory.

Always perform the full suspend sequence regardless of the current link
state. Previously, if the device was already in U3, the suspend callback
returned early without stopping the controller, which could lead to
commands being issued on a disabled slot during resume.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260820-suspend_resume_fix-v3-1-5a713098b977@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 7a516e509198..e84405352caa 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1338,7 +1338,6 @@ static int cdnsp_run(struct cdnsp_device *pdev,
 
 	cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-
 	ret = cdnsp_start(pdev);
 	if (ret) {
 		ret = -ENODEV;
@@ -1837,6 +1836,82 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
 		 readl(&pdev->rev_cap->tx_buff_size));
 }
 
+static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
+{
+	dma_addr_t deq;
+	u64 temp;
+
+	deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
+				    pdev->event_ring->dequeue);
+
+	/* Update controller event ring dequeue pointer */
+	temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
+	temp &= ERST_PTR_MASK;
+
+	/*
+	 * Don't clear the EHB bit (which is RW1C) because
+	 * there might be more events to service.
+	 */
+	temp &= ~ERST_EHB;
+
+	cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
+		       &pdev->ir_set->erst_dequeue);
+}
+
+static void cdnsp_add_interrupter(struct cdnsp_device *pdev)
+{
+	u64 erst_base;
+	u32 erst_size;
+
+	/* Set ERST count with the number of entries in the segment table. */
+	erst_size = readl(&pdev->ir_set->erst_size);
+	erst_size &= ERST_SIZE_MASK;
+	erst_size |= ERST_NUM_SEGS;
+	writel(erst_size, &pdev->ir_set->erst_size);
+
+	/* Set the segment table base address. */
+	erst_base = cdnsp_read_64(&pdev->ir_set->erst_base);
+	erst_base &= ERST_PTR_MASK;
+	erst_base |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
+	cdnsp_write_64(erst_base, &pdev->ir_set->erst_base);
+
+	/* Set the event ring dequeue address. */
+	cdnsp_set_event_deq(pdev);
+}
+
+/* Set up basic CDNSP registers */
+static void cdnsp_init(struct cdnsp_device *pdev)
+{
+	unsigned int val;
+	u64 val_64;
+
+	val = readl(&pdev->op_regs->config_reg);
+	val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
+	writel(val, &pdev->op_regs->config_reg);
+
+	/* Initialize the Command ring */
+	cdnsp_ring_init(pdev, pdev->cmd_ring);
+
+	/* Set the address in the Command Ring Control register */
+	val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
+	val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
+		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
+		 pdev->cmd_ring->cycle_state;
+	cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
+
+	/* Set Device Context Base Address Array pointer */
+	cdnsp_write_64(pdev->dcbaa->dma, &pdev->op_regs->dcbaa_ptr);
+
+	/* Set Doorbell array pointer */
+	val = readl(&pdev->cap_regs->db_off);
+	val &= DBOFF_MASK;
+	pdev->dba = (void __iomem *)pdev->cap_regs + val;
+
+	/* Initialize the Primary interrupter */
+	cdnsp_ring_init(pdev, pdev->event_ring);
+	cdnsp_add_interrupter(pdev);
+}
+
 static int cdnsp_gen_setup(struct cdnsp_device *pdev)
 {
 	int ret;
@@ -1902,6 +1977,8 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev)
 	if (ret)
 		return ret;
 
+	cdnsp_init(pdev);
+
 	/*
 	 * Software workaround for U1: after transition
 	 * to U1 the controller starts gating clock, and in some cases,
@@ -2031,9 +2108,6 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	unsigned long flags;
 
-	if (pdev->link_state == XDEV_U3)
-		return 0;
-
 	spin_lock_irqsave(&pdev->lock, flags);
 	cdnsp_disconnect_gadget(pdev);
 	cdnsp_stop(pdev);
@@ -2047,12 +2121,38 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	enum usb_device_speed max_speed;
 	unsigned long flags;
+	bool context_lost;
+	u32 val;
 	int ret;
 
 	if (!pdev->gadget_driver)
 		return 0;
 
 	spin_lock_irqsave(&pdev->lock, flags);
+	val = readl(&pdev->port3x_regs->mode_2);
+	context_lost = !!(val & CFG_3XPORT_U1_PIPE_CLK_GATE_EN) || lost_power;
+
+	if (context_lost) {
+		cdnsp_halt(pdev);
+		cdnsp_set_apb_timeout_value(pdev);
+
+		/* Reset the internal controller memory state and registers. */
+		ret = cdnsp_reset(pdev);
+		if (ret)
+			goto unlock;
+
+		val = readl(&pdev->port3x_regs->mode_2);
+		val &= ~CFG_3XPORT_U1_PIPE_CLK_GATE_EN;
+		writel(val, &pdev->port3x_regs->mode_2);
+
+		cdnsp_clear_cmd_ring(pdev);
+
+		memset(pdev->event_ring->first_seg->trbs, 0,
+		       sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT));
+
+		cdnsp_init(pdev);
+	}
+
 	max_speed = pdev->gadget_driver->max_speed;
 
 	/* Limit speed if necessary. */
@@ -2060,9 +2160,10 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 
 	ret = cdnsp_run(pdev, max_speed);
 
-	if (pdev->link_state == XDEV_U3)
+	if (!context_lost && pdev->link_state == XDEV_U3)
 		__cdnsp_gadget_wakeup(pdev);
 
+unlock:
 	spin_unlock_irqrestore(&pdev->lock, flags);
 
 	return ret;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index c44bca348a41..c3ae5040f9cc 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -1510,6 +1510,7 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
 int cdnsp_ring_expansion(struct cdnsp_device *pdev,
 			 struct cdnsp_ring *ring,
 			 unsigned int num_trbs, gfp_t flags);
+void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring *ring);
 struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep, u64 address);
 int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 			    struct cdnsp_ep *pep,
diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index 83f3384b735d..419309c8439e 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -394,13 +394,6 @@ static struct cdnsp_ring *cdnsp_ring_alloc(struct cdnsp_device *pdev,
 	if (ret)
 		goto fail;
 
-	/* Only event ring does not use link TRB. */
-	if (type != TYPE_EVENT)
-		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
-			cpu_to_le32(LINK_TOGGLE);
-
-	cdnsp_initialize_ring_info(ring);
-	trace_cdnsp_ring_alloc(ring);
 	return ring;
 fail:
 	kfree(ring);
@@ -603,6 +596,7 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 		if (!cur_ring)
 			goto cleanup_rings;
 
+		cdnsp_ring_init(pdev, cur_ring);
 		cur_ring->stream_id = cur_stream;
 		cur_ring->trb_address_map = &stream_info->trb_address_map;
 
@@ -698,6 +692,8 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev)
 	if (!pdev->eps[0].ring)
 		goto fail;
 
+	cdnsp_ring_init(pdev, pdev->eps[0].ring);
+
 	/* Point to output device context in dcbaa. */
 	pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
 	pdev->cmd.in_ctx = &pdev->in_ctx;
@@ -991,6 +987,8 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
 	if (!pep->ring)
 		return -ENOMEM;
 
+	cdnsp_ring_init(pdev, pep->ring);
+
 	pep->skip = false;
 
 	/* Fill the endpoint context */
@@ -1096,28 +1094,6 @@ void cdnsp_mem_cleanup(struct cdnsp_device *pdev)
 	pdev->active_port = NULL;
 }
 
-static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
-{
-	dma_addr_t deq;
-	u64 temp;
-
-	deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
-				    pdev->event_ring->dequeue);
-
-	/* Update controller event ring dequeue pointer */
-	temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
-	temp &= ERST_PTR_MASK;
-
-	/*
-	 * Don't clear the EHB bit (which is RW1C) because
-	 * there might be more events to service.
-	 */
-	temp &= ~ERST_EHB;
-
-	cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
-		       &pdev->ir_set->erst_dequeue);
-}
-
 static void cdnsp_add_in_port(struct cdnsp_device *pdev,
 			      struct cdnsp_port *port,
 			      __le32 __iomem *addr)
@@ -1226,6 +1202,36 @@ static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev)
 	return 0;
 }
 
+static void cdnsp_initialize_ring_segments(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
+{
+	struct cdnsp_segment *seg;
+
+	/* Only event ring does not use link TRB. */
+	if (ring->type == TYPE_EVENT)
+		return;
+
+	seg = ring->first_seg;
+
+	while (seg) {
+		struct cdnsp_segment *next = seg->next;
+
+		cdnsp_link_segments(pdev, seg, next, ring->type);
+		if (next == ring->first_seg)
+			break;
+
+		seg = next;
+	}
+
+	ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |= cpu_to_le32(LINK_TOGGLE);
+}
+
+void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
+{
+	cdnsp_initialize_ring_segments(pdev, ring);
+	cdnsp_initialize_ring_info(ring);
+	trace_cdnsp_ring_alloc(ring);
+}
+
 /*
  * Initialize memory for CDNSP (one-time init).
  *
@@ -1237,10 +1243,8 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 {
 	struct device *dev = pdev->dev;
 	int ret = -ENOMEM;
-	unsigned int val;
 	dma_addr_t dma;
 	u32 page_size;
-	u64 val_64;
 
 	/*
 	 * Use 4K pages, since that's common and the minimum the
@@ -1248,10 +1252,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 	 */
 	page_size = 1 << 12;
 
-	val = readl(&pdev->op_regs->config_reg);
-	val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
-	writel(val, &pdev->op_regs->config_reg);
-
 	/*
 	 * Doorbell array must be physically contiguous
 	 * and 64-byte (cache line) aligned.
@@ -1263,8 +1263,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 
 	pdev->dcbaa->dma = dma;
 
-	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
-
 	/*
 	 * Initialize the ring segment pool.  The ring must be a contiguous
 	 * structure comprised of TRBs. The TRBs must be 16 byte aligned,
@@ -1290,17 +1288,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 	if (!pdev->cmd_ring)
 		goto destroy_device_pool;
 
-	/* Set the address in the Command Ring Control register */
-	val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
-	val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
-		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
-		 pdev->cmd_ring->cycle_state;
-	cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
-
-	val = readl(&pdev->cap_regs->db_off);
-	val &= DBOFF_MASK;
-	pdev->dba = (void __iomem *)pdev->cap_regs + val;
-
 	/* Set ir_set to interrupt register set 0 */
 	pdev->ir_set = &pdev->run_regs->ir_set[0];
 
@@ -1317,21 +1304,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 	if (ret)
 		goto free_event_ring;
 
-	/* Set ERST count with the number of entries in the segment table. */
-	val = readl(&pdev->ir_set->erst_size);
-	val &= ERST_SIZE_MASK;
-	val |= ERST_NUM_SEGS;
-	writel(val, &pdev->ir_set->erst_size);
-
-	/* Set the segment table base address. */
-	val_64 = cdnsp_read_64(&pdev->ir_set->erst_base);
-	val_64 &= ERST_PTR_MASK;
-	val_64 |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
-	cdnsp_write_64(val_64, &pdev->ir_set->erst_base);
-
-	/* Set the event ring dequeue address. */
-	cdnsp_set_event_deq(pdev);
-
 	ret = cdnsp_setup_port_arrays(pdev);
 	if (ret)
 		goto free_erst;


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2B38D014;
	Thu, 20 Aug 2026 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221584; cv=none; b=eiHVI0tK0t7XA1aoIPUIPCc7gqX1AZ8ZPFhlXcZXrEBpS2E/M+YSwSA5R57meLSL470O7DF2ihgdo8f7mNm9hXZwt3WgXot+944/oTINJA84n1nxhcUNhuzuIC8p+9UXxRXTh9dmIXLNAzIbhWSZp9Z1M4u5EfwR3HMOpugjEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221584; c=relaxed/simple;
	bh=Z3UD4cMLGxCHHERUqy4i/FsndVnARFAUMQk2BYjQehU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NO70d6KcCaBNPZs0VV3DmWHmceXLoGjezIj8Y4UXNGpMFzG3DX61a77VO4oHntqV9A67Vo05VQInv8UpPam4i6xiwbgdiF0jv/goHfkvYXV0fLMZ3zXEwkOqKoEXL6xbbW2eSaLzj1c5HZ0EnnJpDwnggTWgqu+tGUxJwtCyh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzVomX4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzVomX4U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DE40C2BCB3;
	Thu, 20 Aug 2026 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787221584;
	bh=Z3UD4cMLGxCHHERUqy4i/FsndVnARFAUMQk2BYjQehU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qzVomX4UgkMA1mdh0f2dj8eoq4raWDkuh7i+ohBfjyY41veKKcqXxhCvMlPwSCCPV
	 dS93B7cnBLysF5h44LBFuIlAIUAsmym6VNHLVP99wCS02xWF4exodOuvfOm33tbar4
	 b0w4xSyDN6ODEMyQMnIxRdN7Y4xOd0jIB6gRjFydr8fTiBa3ShJPyn/k7Okxe2gRlN
	 uav/eoIrJggaVHIHOH6mmqWYAKhRfhxyVZh+WbA/YkFlbIIW7kKjIF34NSR4kCxHEe
	 kLC+0uJ6oaKi0pxIW7sRG0f6emPlJT6nGustY6nqAz40htl6BsycK38MxTdkgYOhht
	 WF2oBZDaNtCkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B95C5DF87;
	Thu, 20 Aug 2026 10:26:24 +0000 (UTC)
From: Pawel Laszczak via B4 Relay <devnull+pawell.cadence.com@kernel.org>
Date: Thu, 20 Aug 2026 12:45:31 +0200
Subject: [PATCH v3] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-suspend_resume_fix-v3-1-5a713098b977@cadence.com>
X-B4-Tracking: v=1; b=H4sIAMrahmoC/32N0QqCMBSGXyV23WKbmtpV7xEhczvLBU7Z0VGI7
 95mFxFEl9/hP9+3EARvAclptxAPwaIdXIRsvyOqk+4G1OrIRDBxZKXIKM44gtONB5x7aIx90Nb
 oIhOlLoSUJD6OHuJ5k16ub8a5vYOakiktOovT4J9bNfC0+xsInHKquJAMKpDGqLOSGpyCgxp6k
 hJBfCQVr35KRJTkZcFYzes80+Zbsq7rC4CPFuENAQAA
X-Change-ID: 20260723-suspend_resume_fix-bfd5327d52aa
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Peter Chen <peter.chen@kernel.org>, gary.yang@cixtech.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787222749; l=13692;
 i=pawell@cadence.com; h=from:subject:message-id;
 bh=2TNaPdhGZITfHVIm9Q6cmOFISCzQeaMUAmB/4I1gQp0=;
 b=WAurovXFDpk83GqqaJOwT/4ZbOB1/QDDQHGPbW7wfMNcdt0H+9ZHCciaHYHTPg4t0JLb4f1f0
 gW2mKbG7b6QBfs9kgaEEE0w7i6UTHEbokxfvevdA8IIM7mUDD0T1Y5T
X-Developer-Key: i=pawell@cadence.com; a=ed25519;
 pk=EUPBvLO9CDg7j6defeDl2iqi+z5Ivqu4Z46aiqe7dYc=
X-Endpoint-Received: by B4 Relay for pawell@cadence.com/default with
 auth_id=707
X-Original-From: Pawel Laszczak <pawell@cadence.com>
Reply-To: pawell@cadence.com

From: Pawel Laszczak <pawell@cadence.com>

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
Cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changes in v3:
- Remove CSS/CRS sequences: not applicable to the device controller.
- Remove cdnsp_save_registers(), cdnsp_restore_registers() and
  struct cdnsp_s3_save, now unused.
- Remove STS_CNR polling from the power-retained resume path: it was
  not present before this fix and is not required.
- Move __cdnsp_gadget_wakeup() call to the power-retained path only,
  where the link state is meaningful.

Changes in v2:
- Clarify commit message to reflect SoC-dependent context loss behavior
- Removed in_lpm from cdnsp_irq_handler - the code is unnecessary
- Fix suspend: always perform full suspend sequence regardless of link state
---
 drivers/usb/cdns3/cdnsp-gadget.c | 111 +++++++++++++++++++++++++++++++++++++--
 drivers/usb/cdns3/cdnsp-gadget.h |   1 +
 drivers/usb/cdns3/cdnsp-mem.c    |  98 ++++++++++++----------------------
 3 files changed, 142 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index a5275c2fb43b..63f605de068b 100644
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
index 5d8cdc91927d..0be917f52bbb 100644
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
 
@@ -696,6 +690,8 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev)
 	if (!pdev->eps[0].ring)
 		goto fail;
 
+	cdnsp_ring_init(pdev, pdev->eps[0].ring);
+
 	/* Point to output device context in dcbaa. */
 	pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
 	pdev->cmd.in_ctx = &pdev->in_ctx;
@@ -989,6 +985,8 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
 	if (!pep->ring)
 		return -ENOMEM;
 
+	cdnsp_ring_init(pdev, pep->ring);
+
 	pep->skip = false;
 
 	/* Fill the endpoint context */
@@ -1094,28 +1092,6 @@ void cdnsp_mem_cleanup(struct cdnsp_device *pdev)
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
@@ -1224,6 +1200,36 @@ static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev)
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
@@ -1235,10 +1241,8 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 {
 	struct device *dev = pdev->dev;
 	int ret = -ENOMEM;
-	unsigned int val;
 	dma_addr_t dma;
 	u32 page_size;
-	u64 val_64;
 
 	/*
 	 * Use 4K pages, since that's common and the minimum the
@@ -1246,10 +1250,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 	 */
 	page_size = 1 << 12;
 
-	val = readl(&pdev->op_regs->config_reg);
-	val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
-	writel(val, &pdev->op_regs->config_reg);
-
 	/*
 	 * Doorbell array must be physically contiguous
 	 * and 64-byte (cache line) aligned.
@@ -1261,8 +1261,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
 
 	pdev->dcbaa->dma = dma;
 
-	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
-
 	/*
 	 * Initialize the ring segment pool.  The ring must be a contiguous
 	 * structure comprised of TRBs. The TRBs must be 16 byte aligned,
@@ -1288,17 +1286,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
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
 
@@ -1315,21 +1302,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
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

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260723-suspend_resume_fix-bfd5327d52aa

Best regards,
--  
Pawel Laszczak <pawell@cadence.com>



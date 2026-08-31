Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A539A4B3
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210649; cv=none; b=MG3TiWNlVlIMzev82nS417KYFpJunkZOXEr8G7b4+QCdH5Y9kU+VykHOmmnjU1fYhNduh+jewRmSEho2W5LOiwmsdViN057KXpvG6TWRUSl7kM3c9+4wMS3f+KS7N0rnCe42xLewhcxJJJa0AgYSDCpIIrCeNG+VejjSCn68tZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210649; c=relaxed/simple;
	bh=HkpqmuwN5W5jKWk2yFXvFoJjzvSvYvxOBUey3N7T2b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW7O5fgx9GMXn11YsHU98ginb1FG1EUys4x+vHSL+1nPlCpJ8PlVM5uyPVqjq05OiScwXcxzsGJzNybNd/4JjjqG/wj5YJvdwOk7sqjXEAmziAeFj1jBoB9V8ONfDiYGH4zi0UQzGUqCEN/BLH5czzsL0o+RxIGEoqPbtYt30Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm0x/daO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm0x/daO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E701F00ADB;
	Mon, 31 Aug 2026 21:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210645;
	bh=aMVPwUpMm4+rrHSL/Ju1oI8rWfKKCuNhNonN9p857EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dm0x/daOQLKxrFRiTB0TdTOr3KH8ySDNVLzqFjipGP1VCbS0+4/8lr3WyhbVIFo1i
	 t33sSLTdKcFYuBJ8jaWxWAFWgOApZ+XPGPptiuHI1e3mINkjRN1c0iHIFWrO5aGKHo
	 seySPivDi2QX4dIv2h1egjY2rAxX02VpLcMkr4iXj8FZMULoVeQEN1NNFTQEH1ov5N
	 f3EZlnd9wai3SNo3ViIy12X0Mr4yZAiCgHqIN11e2WFHaCozBwGOzeFPba+OAbgK3P
	 B7XFiv9Dqkr5B6WPJsi0sb23L2tDxqyuIIuez4DncYkWCC9T6iyrF32Q0JmnkZRvMS
	 cg6gyXvmxoJJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] usb: xhci: simplify handling of Structural Parameters 1 values
Date: Mon, 31 Aug 2026 17:10:13 -0400
Message-ID: <20260831211039.1799106-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211039.1799106-1-sashal@kernel.org>
References: <2026083121-usher-contest-f49c@gregkh>
 <20260831211039.1799106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit df08973556851b29bd78e79db696d992ed1b43f0 ]

The 32-bit read-only HCSPARAMS1 register contains the following fields:
 Bits  7:0   - Number of Device Slots (MaxSlots)
 Bits 18:8   - Number of Interrupters (MaxIntrs)
 Bits 23:19  - Reserved
 Bits 31:24  - Number of Ports (MaxPorts)

Since the register value is constant for the lifetime of the controller,
it is cached in 'xhci->hcs_params1'. However, platform drivers may
override the number of interrupters through a separate variable,
'xhci->max_interrupters', leaving only the maximum slots and ports values
still derived from the cached register.

To simplify the code and improve readability, replace 'xhci->hcs_params1'
with two dedicated 'u8' fields: 'xhci->max_slots' and 'xhci->max_ports'.
These values are initialized once and used directly instead of calling
'HCS_MAX_SLOTS()' and 'HCS_MAX_PORTS()' macros.

This change reduces code clutter without increasing memory usage.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-16-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Adjusted for this stable tree, which lacks several upstream prerequisites:

  - drivers/usb/host/xhci-debugfs.c: dropped the hunk touching
    xhci_port_bw_show() and the surrounding SS/HS/FS bandwidth debugfs
    files, since this tree does not yet have the "port bandwidth"
    debugfs feature (xhci_get_port_bandwidth() et al.) those hunks
    apply against.

  - drivers/usb/host/xhci.c: dropped the hunk adding
    xhci_hcd_page_size(), xhci_enable_max_dev_slots(),
    xhci_set_cmd_ring_deq(), xhci_set_doorbell_ptr() and
    xhci_set_dev_notifications() helpers, since this tree does not have
    the xhci_init()/xhci_gen_setup() refactor that split those out of
    xhci_mem_init()/xhci_run() - xhci_set_cmd_ring_deq() already exists
    here in its pre-refactor form, so adding the duplicate would fail
    to build. The max-slot programming that xhci_enable_max_dev_slots()
    would have simplified still exists here in its pre-refactor,
    inlined form in xhci_mem_init() (drivers/usb/host/xhci-mem.c); that
    site was updated the same way upstream updates the helper: it now
    uses the cached 'xhci->max_slots' instead of re-deriving it via
    HCS_MAX_SLOTS(readl(&xhci->cap_regs->hcs_params1)).

  - drivers/usb/host/xhci.h: this tree already independently carries
    'u8 max_slots' and 'u8 max_ports' fields (used only by other,
    already-applied backports) plus 'u8 isoc_threshold', so the field
    additions from this commit are not needed; kept this tree's
    existing field list unchanged.

  - Removing 'xhci->hcs_params1' also required converting two more
    leftover open-coded users this backport's original hunks don't
    cover: xhci-mem.c's real_port bounds checks in the TT-info cleanup
    paths, and xhci-pci.c's xhci_setup_msix(), which computed the
    MSI-X vector count from HCS_MAX_INTRS(xhci->hcs_params1) directly.
    The former now use xhci->max_ports; the latter now uses
    xhci->max_interrupters, which xhci_gen_setup() has already
    initialized to HCS_MAX_INTRS(hcs_params1) (or a driver override)
    by the time xhci_setup_msix() runs. ]

Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-debugfs.c | 10 +++------
 drivers/usb/host/xhci-hub.c     |  2 +-
 drivers/usb/host/xhci-mem.c     | 37 ++++++++++++++-------------------
 drivers/usb/host/xhci-pci.c     |  4 ++--
 drivers/usb/host/xhci-ring.c    |  6 ++----
 drivers/usb/host/xhci.c         | 15 ++++++-------
 drivers/usb/host/xhci.h         |  1 -
 7 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 4c9b1925436f0..305a9b883e0ff 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -632,20 +632,16 @@ void xhci_debugfs_remove_slot(struct xhci_hcd *xhci, int slot_id)
 static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
 				      struct dentry *parent)
 {
-	unsigned int		num_ports;
 	char			port_name[8];
 	struct xhci_port	*port;
 	struct dentry		*dir;
 
-	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
-
 	parent = debugfs_create_dir("ports", parent);
 
-	while (num_ports--) {
-		scnprintf(port_name, sizeof(port_name), "port%02d",
-			  num_ports + 1);
+	for (int i = 0; i < xhci->max_ports; i++) {
+		scnprintf(port_name, sizeof(port_name), "port%02d", i + 1);
 		dir = debugfs_create_dir(port_name, parent);
-		port = &xhci->hw_ports[num_ports];
+		port = &xhci->hw_ports[i];
 		debugfs_create_file("portsc", 0644, dir, port, &port_fops);
 	}
 }
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 6825249cda9c5..e096474af8086 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -731,7 +731,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 	/* Disable all Device Slots */
 	xhci_dbg(xhci, "Disable all slots\n");
 	spin_unlock_irqrestore(&xhci->lock, *flags);
-	for (i = 1; i <= HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
+	for (i = 1; i <= xhci->max_slots; i++) {
 		if (!xhci->devs[i])
 			continue;
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index daa101220a743..9763440f809de 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -780,7 +780,7 @@ static void xhci_free_tt_info(struct xhci_hcd *xhci,
 	 * it may not have the real_port set correctly.
 	 */
 	if (virt_dev->real_port == 0 ||
-			virt_dev->real_port > HCS_MAX_PORTS(xhci->hcs_params1)) {
+			virt_dev->real_port > xhci->max_ports) {
 		xhci_dbg(xhci, "Bad real port.\n");
 		return;
 	}
@@ -918,7 +918,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 		return;
 
 	if (vdev->real_port == 0 ||
-			vdev->real_port > HCS_MAX_PORTS(xhci->hcs_params1)) {
+			vdev->real_port > xhci->max_ports) {
 		xhci_dbg(xhci, "Bad vdev->real_port.\n");
 		goto out;
 	}
@@ -928,7 +928,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 		/* is this a hub device that added a tt_info to the tts list */
 		if (tt_info->slot_id == slot_id) {
 			/* are any devices using this tt_info? */
-			for (i = 1; i < HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
+			for (i = 1; i < xhci->max_slots; i++) {
 				vdev = xhci->devs[i];
 				if (vdev && (vdev->tt_info == tt_info))
 					xhci_free_virt_devices_depth_first(
@@ -1878,7 +1878,7 @@ EXPORT_SYMBOL_GPL(xhci_remove_secondary_interrupter);
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
-	int i, j, num_ports;
+	int i, j;
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
 
@@ -1897,8 +1897,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed command ring");
 	xhci_cleanup_command_queue(xhci);
 
-	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
-	for (i = 0; i < num_ports && xhci->rh_bw; i++) {
+	for (i = 0; i < xhci->max_ports && xhci->rh_bw; i++) {
 		struct xhci_interval_bw_table *bwt = &xhci->rh_bw[i].bw_table;
 		for (j = 0; j < XHCI_MAX_INTERVAL; j++) {
 			struct list_head *ep = &bwt->interval_bw[j].endpoints;
@@ -1907,7 +1906,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 		}
 	}
 
-	for (i = HCS_MAX_SLOTS(xhci->hcs_params1); i > 0; i--)
+	for (i = xhci->max_slots; i > 0; i--)
 		xhci_free_virt_devices_depth_first(xhci, i);
 
 	dma_pool_destroy(xhci->segment_pool);
@@ -1938,7 +1937,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	if (!xhci->rh_bw)
 		goto no_bw;
 
-	for (i = 0; i < num_ports; i++) {
+	for (i = 0; i < xhci->max_ports; i++) {
 		struct xhci_tt_bw_info *tt, *n;
 		list_for_each_entry_safe(tt, n, &xhci->rh_bw[i].tts, tt_list) {
 			list_del(&tt->tt_list);
@@ -2146,7 +2145,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
 	if (!rhub->ports)
 		return;
 
-	for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
+	for (i = 0; i < xhci->max_ports; i++) {
 		if (xhci->hw_ports[i].rhub != rhub ||
 		    xhci->hw_ports[i].hcd_portnum == DUPLICATE_ENTRY)
 			continue;
@@ -2169,19 +2168,17 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 {
 	void __iomem *base;
 	u32 offset;
-	unsigned int num_ports;
 	int i, j;
 	int cap_count = 0;
 	u32 cap_start;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
-	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
-	xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
-				flags, dev_to_node(dev));
+	xhci->hw_ports = kcalloc_node(xhci->max_ports, sizeof(*xhci->hw_ports),
+				      flags, dev_to_node(dev));
 	if (!xhci->hw_ports)
 		return -ENOMEM;
 
-	for (i = 0; i < num_ports; i++) {
+	for (i = 0; i < xhci->max_ports; i++) {
 		xhci->hw_ports[i].port_reg = &xhci->op_regs->port_regs[i];
 		xhci->hw_ports[i].hw_portnum = i;
 
@@ -2189,11 +2186,10 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		init_completion(&xhci->hw_ports[i].u3exit_done);
 	}
 
-	xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
-				   dev_to_node(dev));
+	xhci->rh_bw = kcalloc_node(xhci->max_ports, sizeof(*xhci->rh_bw), flags, dev_to_node(dev));
 	if (!xhci->rh_bw)
 		return -ENOMEM;
-	for (i = 0; i < num_ports; i++) {
+	for (i = 0; i < xhci->max_ports; i++) {
 		struct xhci_interval_bw_table *bw_table;
 
 		INIT_LIST_HEAD(&xhci->rh_bw[i].tts);
@@ -2230,9 +2226,8 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 	offset = cap_start;
 
 	while (offset) {
-		xhci_add_in_port(xhci, num_ports, base + offset, cap_count);
-		if (xhci->usb2_rhub.num_ports + xhci->usb3_rhub.num_ports ==
-		    num_ports)
+		xhci_add_in_port(xhci, xhci->max_ports, base + offset, cap_count);
+		if (xhci->usb2_rhub.num_ports + xhci->usb3_rhub.num_ports == xhci->max_ports)
 			break;
 		offset = xhci_find_next_ext_cap(base, offset,
 						XHCI_EXT_CAPS_PROTOCOL);
@@ -2433,7 +2428,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * Program the Number of Device Slots Enabled field in the CONFIG
 	 * register with the max value of slots the HC can handle.
 	 */
-	val = HCS_MAX_SLOTS(readl(&xhci->cap_regs->hcs_params1));
+	val = xhci->max_slots;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"// xHC can handle at most %d device slots.", val);
 	val2 = readl(&xhci->op_regs->config_reg);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2fb83ebab612e..89bc460615f45 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -188,7 +188,7 @@ static int xhci_setup_msix(struct xhci_hcd *xhci)
 	 *   Add additional 1 vector to ensure always available interrupt.
 	 */
 	xhci->msix_count = min(num_online_cpus() + 1,
-				HCS_MAX_INTRS(xhci->hcs_params1));
+				xhci->max_interrupters);
 
 	ret = pci_alloc_irq_vectors(pdev, xhci->msix_count, xhci->msix_count,
 			PCI_IRQ_MSIX);
@@ -940,7 +940,7 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
 	if (!(xhci->quirks & XHCI_RESET_TO_DEFAULT))
 		return 0;
 
-	for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
+	for (i = 0; i < xhci->max_ports; i++) {
 		port = &xhci->hw_ports[i];
 		portsc = xhci_portsc_readl(port);
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index be22b99be6880..38d370f7ebb52 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1347,7 +1347,7 @@ void xhci_hc_died(struct xhci_hcd *xhci)
 	xhci_cleanup_command_queue(xhci);
 
 	/* return any pending urbs, remove may be waiting for them */
-	for (i = 0; i <= HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
+	for (i = 0; i <= xhci->max_slots; i++) {
 		if (!xhci->devs[i])
 			continue;
 		for (j = 0; j < 31; j++)
@@ -1979,7 +1979,6 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	struct usb_hcd *hcd;
 	u32 port_id;
 	u32 portsc, cmd_reg;
-	int max_ports;
 	int slot_id;
 	unsigned int hcd_portnum;
 	struct xhci_bus_state *bus_state;
@@ -1992,9 +1991,8 @@ static void handle_port_status(struct xhci_hcd *xhci,
 			  "WARN: xHC returned failed port status event\n");
 
 	port_id = GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
-	max_ports = HCS_MAX_PORTS(xhci->hcs_params1);
 
-	if ((port_id <= 0) || (port_id > max_ports)) {
+	if ((port_id <= 0) || (port_id > xhci->max_ports)) {
 		xhci_warn(xhci, "Port change event with invalid port ID %d\n",
 			  port_id);
 		inc_deq(xhci, ir->event_ring);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8d35b01ba0252..7d192bc9b6403 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -289,8 +289,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 	if (upper_32_bits(val))
 		xhci_write_64(xhci, 0, &xhci->op_regs->cmd_ring);
 
-	intrs = min_t(u32, HCS_MAX_INTRS(xhci->hcs_params1),
-		      ARRAY_SIZE(xhci->run_regs->ir_set));
+	intrs = min_t(u32, xhci->max_interrupters, ARRAY_SIZE(xhci->run_regs->ir_set));
 
 	for (i = 0; i < intrs; i++) {
 		struct xhci_intr_reg __iomem *ir;
@@ -4053,7 +4052,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_err(xhci, "Error while assigning device slot ID: %s\n",
 			 xhci_trb_comp_code_string(command->status));
 		xhci_err(xhci, "Max number of devices this xHCI host supports is %u.\n",
-			 HCS_MAX_SLOTS(xhci->hcs_params1));
+			 xhci->max_slots);
 		xhci_free_command(xhci, command);
 		return 0;
 	}
@@ -5245,6 +5244,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	 */
 	struct device		*dev = hcd->self.sysdev;
 	int			retval;
+	u32			hcs_params1;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5270,7 +5270,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	xhci->run_regs = hcd->regs +
 		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
 	/* Cache read-only capability registers */
-	xhci->hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
+	hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
 	xhci->hci_version = HC_VERSION(readl(&xhci->cap_regs->hc_capbase));
@@ -5279,10 +5279,11 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
 	xhci->dma_mask_bits = 64;
+	xhci->max_slots = HCS_MAX_SLOTS(hcs_params1);
+	xhci->max_ports = HCS_MAX_PORTS(hcs_params1);
 	/* xhci-plat or xhci-pci might have set max_interrupters already */
-	if ((!xhci->max_interrupters) ||
-	    xhci->max_interrupters > HCS_MAX_INTRS(xhci->hcs_params1))
-		xhci->max_interrupters = HCS_MAX_INTRS(xhci->hcs_params1);
+	if ((!xhci->max_interrupters) || xhci->max_interrupters > HCS_MAX_INTRS(hcs_params1))
+		xhci->max_interrupters = HCS_MAX_INTRS(hcs_params1);
 
 	xhci->quirks |= quirks;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 058880f0b71ee..92cdd28ce3817 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1508,7 +1508,6 @@ struct xhci_hcd {
 	struct xhci_doorbell_array __iomem *dba;
 
 	/* Cached register copies of read-only HC data */
-	__u32		hcs_params1;
 	__u32		hcs_params2;
 	__u32		hcs_params3;
 	__u32		hcc_params;
-- 
2.53.0


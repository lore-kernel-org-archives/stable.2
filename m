Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320230;
	b=HusvV+QZ78TqhNfTJwJ7calptCcZ8Qr9VCms7nmf8qkZb8axfrORdcQeM7oJaqSoulUH
	 gcGjI7b+4putQbdTHoj++mLsd6FGdsfCP5gu9inK0SOgc40czhxTTCI8C318eUT57fjOv
	 Tfq6Vyp3AyMK+XtlJJyIvPLH6mK0KDf5T3MW4QQPzVTqAVyAv401+DajOg4cuOG6A4xHt
	 CLrrJRtRUWIRm9THS9zNl8KWkkiVW988RVGyEpiLrumEMLrqQc7vCEJgr7JvbdDJhggkk
	 K9zLHbOLjh9Xx2WcM2jpB6kaD7LTmI6GSCCjWWdPNIuIOGMBop2GYsLxBeGz3tD3FOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0bKLdWcu7uPrJG2RCs5GWN2u4ArI1r0zqg4lOHr8CAY=;
	b=bQHBLoxbtLPVQam5kz3qjEDXGdBQguHdR/ItTDEYlTvJJ2kj5CQFuA2E9egHQhoZRQqP
	 EaTCWBxPouyXl883SQh+9VTgctepjW6JmNR1RN9who4H6ogg5j7wqPFJvta2bu9O1hQYi
	 JYD4Al3KCSc3IH0tZjq5hsN6fcAwGANEH8inlH5y6UQkp+ZpvTGi3GqXw0jvCuO7Ty3P3
	 fUOUXtEa3gfbZ5zIZ9nI6XjQppy4mpnUW08dEi+P8lOQ+pPCdLNwKxt9WXcaq/mzNzO02
	 XNIr2RWdqC0KxoxWtDFDn/BhkPAsTXYsGgrCY/Rz7UTDoT/ysTg9sXrse+CoIpQt30Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZsfDkdd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EE606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZsfDkdd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241A11F008A3;
	Tue, 10 Nov 2026 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320230;
	bh=0bKLdWcu7uPrJG2RCs5GWN2u4ArI1r0zqg4lOHr8CAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZsfDkddLxcYgfNWL6qLDkMNgDhYpsZ5/Sgir9KGSNps0IdH7yEEA+CpEp9ZTD9nJ
	 fTVaZ/z2PLgG6Xa5AHWfv/jkc4hKHIoCleMMqtitNWxLmoFkQ6pPL0gLqe10geVcQA
	 KrOTlVSc0DoUiE+usk7yhngDCsZVyYE0uMbbEVNvgDk1ttyEcN3m5FNYLMdDXxONzO
	 Pt6g1Gz6HOLwb9t0uIAo5+PxI9orRgyBLqwT+uFkomGmCPC2n0BvFb3s9q+oIkkC/k
	 qvAEN3edr/jmL9DW3nPaQfX2/YQUhei/FOba8K80pV8L6z+8fQy8WApVGZFkNpDUw0
	 R587Isvf+KFBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rickey Bartlett <subtexel@gmail.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Varsh Satti <varsh@varram.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] PCI: vmd: Flush DMA writes before handling MSI on Meteor Lake
Date: Tue, 10 Nov 2026 09:17:05 -0500
Message-ID: <20261110141653.1791478-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141653.1791478-1-sashal@kernel.org>
References: <20261107051011-failed-6.18-2c88c2dc1852@kernel.org>
 <20261110141653.1791478-1-sashal@kernel.org>
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

From: Rickey Bartlett <subtexel@gmail.com>

[ Upstream commit 7307899e381cb0c16245793a4adde7491d73a2b3 ]

Per the Intel Core Ultra Processor Specification Update
(ID 792254 of 9/1/2026), the Meteor Lake VMD (8086:7d0b) is affected by an
MSI erratum:

  MTL016: MSI from VMD-Owned Device May Pass Memory Write

  Problem      When the storage subsystem is configured to operate in RAID
               0 or 1 mode, a Message Signaled Interrupt (MSI) from an
               Intel® Volume Management Device (Intel® VMD) owned device
               may interrupt a core before a previous write from the device
               is completed.

  Workaround   None identified. The VMD MSI interrupt-handler should
               initially perform a dummy register read to the MSI initiator
               device prior to any writes to ensure proper PCIe ordering.

The VMD can signal its MSI before the posted writes carrying a child
device's DMA data have landed in memory. vmd_irq() then demuxes to the
child handler while the child's completion queue is not yet coherent, so
the handler observes no completion and returns without consuming it. The
I/O is only recovered when the block layer timeout expires and polls the
queue:

  nvme nvme0: I/O tag 253 (50fd) QID 1 timeout, completion polled

The practical effect is therefore not a lost I/O but a 30 second stall
of the entire storage stack, repeated under any sustained read load.

This was originally diagnosed and fixed by Kai-Heng Feng in September
2024 [1]. That patch used udelay(4); Keith Busch objected that the delay
is merely a side effect of the read, and that flushing the pending
device-to-host writes is what the erratum actually requires. Kai-Heng
agreed to respin with a dummy register read. The thread then stalled on
an open question from Manivannan Sadhasivam [2]: whether the read must
target the child device (the "MSI initiator" named by the erratum)
rather than the VMD, and whether the workaround belongs in the NVMe
driver instead. No revision followed, and the erratum has remained
unmitigated in mainline since.

This implements the flush read Keith asked for, and answers the open
question empirically: the read MUST complete at the initiating child
device. A read of the VMD's own config BAR was tried first and does not
help - it terminates at the VMD and never traverses the downstream
link, so it does not order against the child's posted writes (measured:
timeout rate unchanged). Reading the initiator's config space does
order correctly: per PCIe ordering rules the read completion cannot
pass the device's earlier posted writes, so returning from the read
guarantees the completion queue entry is visible.

The initiator's config address is captured per-IRQ at MSI allocation
time from the requesting device, so the hot path adds one config read
only on affected parts, and only for vectors owned by a child device.
The read is serialized with cfg_lock like all other VMD config access.
No NVMe driver change is needed.

Measured on a Dell Pro Max 14 MC14250 (Meteor Lake, VMD 8086:7d0b,
KIOXIA BG6 512GB, 7.0.0-30-generic). The drive is healthy (46C, 0 media
errors, 2% used) and ASPM is disabled on the link with all L1 substates
off, so neither ASPM nor APST is involved.

Dropping caches and reading 3000 shared libraries, measuring
/proc/pressure/io "full" (every task on the system blocked on I/O),
with nvme_core.io_timeout=5:

  unpatched:      round 1  wall 37.4s   full I/O stall 32.6s   timeouts 0
                  round 2  wall 30.6s   full I/O stall 28.7s   timeouts 1
                  round 3  wall 30.3s   full I/O stall 27.4s   timeouts 1

  VMD-BAR read:   round 1  wall 44.8s   full I/O stall 38.6s   timeouts 8
  (insufficient)  round 2  wall 234.8s  full I/O stall 207.9s  timeouts 37
                  round 3  wall 3.6s    full I/O stall 0.8s    timeouts 0

  this patch:     round 1  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 2  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 3  wall 3.6s    full I/O stall 1.4s    timeouts 0

Before any workaround, 208 seconds of total-system I/O stall
accumulated in the first 13 minutes of uptime, roughly 27% of wall
clock. Userspace experiences this as GUI applications taking 30-60+
seconds to start while throughput between stalls looks entirely normal
(1.9 GB/s QD1) - which is what makes the fault easy to misattribute to
ASPM or to the drive.

[1] https://lore.kernel.org/20240903025544.286223-1-kai.heng.feng@canonical.com/
[2] https://lore.kernel.org/20240913111142.4cgrmirofhhgrbqm@thinkpad/

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Suggested-by: Keith Busch <kbusch@kernel.org>
Assisted-by: LLM
Signed-off-by: Rickey Bartlett <subtexel@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
[bhelgaas: include erratum source and text, update URLs, cc: stable]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Varsh Satti <varsh@varram.me>
Acked-by: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260825043220.9047-1-subtexel@gmail.com

KIOXIA BG6 512GB). The drive is healthy (46C, 0 media errors, 2% used) and ASPM is disabled on the link with all L1 substates
off, so neither ASPM nor APST is involved.

Dropping caches and reading 3000 shared libraries, measuring
full I/O pressure stalls (every task on the system blocked on I/O),
with nvme_core.io_timeout=5:

  unpatched:      round 1  wall 37.4s   full I/O stall 32.6s   timeouts 0
                  round 2  wall 30.6s   full I/O stall 28.7s   timeouts 1
                  round 3  wall 30.3s   full I/O stall 27.4s   timeouts 1

  VMD-BAR read:   round 1  wall 44.8s   full I/O stall 38.6s   timeouts 8
  (insufficient)  round 2  wall 234.8s  full I/O stall 207.9s  timeouts 37
                  round 3  wall 3.6s    full I/O stall 0.8s    timeouts 0

  this patch:     round 1  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 2  wall 3.6s    full I/O stall 1.3s    timeouts 0
                  round 3  wall 3.6s    full I/O stall 1.4s    timeouts 0

Before any workaround, 208 seconds of total-system I/O stall
accumulated in the first 13 minutes of uptime, roughly 27% of wall
clock. Userspace experiences this as GUI applications taking 30-60+
seconds to start while throughput between stalls looks entirely normal
(1.9 GB/s QD1) - which is what makes the fault easy to misattribute to
ASPM or to the drive.

[1] https://lore.kernel.org/20240903025544.286223-1-kai.heng.feng@canonical.com/
[2] https://lore.kernel.org/20240913111142.4cgrmirofhhgrbqm@thinkpad/

Retain the BIOS-information feature declaration as context for the
follow-up interrupt-ordering fix, without importing BIOS-enumerated
device support. Store the probe-time feature mask in the VMD device
so MSI allocation can test the interrupt quirk.

The common emulated-domain allocator is unavailable. Keep the existing
VMD domain scan inline in vmd_enable_domain(), before MSI-domain
creation, and omit the allocator release calls. This preserves the
previous domain-selection behavior without adding helper functions.

Stable-dep-of: 2c88c2dc1852 ("PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 97 +++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 88bb5536744d7..9ab52b2e59fc3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -77,6 +77,31 @@ enum vmd_features {
 	 * proper power management of the SoC.
 	 */
 	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
+
+	/*
+	 * Newer VMD with device ID 0x28C1 has unique settings compared to its
+	 * predecessor where BIOS enumerates the entire VMD device tree and
+	 * stores respective configurations including bus start range and
+	 * shadow registers in VMD MMIO space in VMD BAR4/BAR5, otherwise
+	 * referred to as MEMBAR2 or MSI-X BAR.
+	 */
+	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
+
+	/*
+	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
+	 * the VMD may signal its MSI before the posted writes that carry the
+	 * child device's DMA data have landed in memory.  The demuxed handler
+	 * then runs against a not-yet-coherent completion queue and misses the
+	 * completion entirely, so the I/O is only recovered when the block
+	 * layer timeout fires and polls the queue ("timeout, completion
+	 * polled").  Intel's documented workaround is to issue a dummy read
+	 * to the MSI initiator (the child device) before handling the
+	 * interrupt: the read completion cannot pass the device's earlier
+	 * posted writes, so it pulls them into memory per PCIe ordering
+	 * rules.  A read that terminates at the VMD itself does not order
+	 * against the child's writes and is not sufficient (measured).
+	 */
+	VMD_FEAT_INTERRUPT_QUIRK	= (1 << 7),
 };
 
 #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
@@ -99,6 +124,9 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @irq:	back pointer to parent.
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
+ * @flush_addr:	config space address of the initiating device, read before
+ *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
  * a VMD IRQ using this structure.
@@ -108,8 +136,14 @@ struct vmd_irq {
 	struct vmd_irq_list	*irq;
 	bool			enabled;
 	unsigned int		virq;
+	void __iomem		*flush_addr;
 };
 
+struct vmd_dev;
+
+static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+				  unsigned int devfn, int reg, int len);
+
 /**
  * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
@@ -117,12 +151,15 @@ struct vmd_irq {
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
  * @virq:	The underlying VMD Linux interrupt number
+ * @vmd:	back pointer to the owning VMD device; serializes the MTL016
+ *		flush read against other config space access.
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
 	unsigned int		virq;
+	struct vmd_dev		*vmd;
 };
 
 struct vmd_dev {
@@ -142,6 +179,7 @@ struct vmd_dev {
 	u8			first_vec;
 	char			*name;
 	int			instance;
+	unsigned long		features;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -279,6 +317,13 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
 		INIT_LIST_HEAD(&vmdirq->node);
 		vmdirq->irq = vmd_next_irq(vmd, desc);
 		vmdirq->virq = virq + i;
+		if (vmd->features & VMD_FEAT_INTERRUPT_QUIRK) {
+			struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
+
+			vmdirq->flush_addr = vmd_cfg_addr(vmd, pdev->bus,
+							  pdev->devfn,
+							  PCI_VENDOR_ID, 2);
+		}
 
 		irq_domain_set_info(domain, virq + i, vmdirq->irq->virq,
 				    &vmd_msi_controller, vmdirq,
@@ -671,8 +716,20 @@ static irqreturn_t vmd_irq(int irq, void *data)
 	int idx;
 
 	idx = srcu_read_lock(&irqs->srcu);
-	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
+		/*
+		 * MTL016: the MSI may have outrun the initiating device's
+		 * posted writes (e.g. its NVMe completion entry).  A read
+		 * that completes at the initiator flushes them, so the
+		 * demuxed handler observes a coherent completion queue.
+		 * The value is discarded; only the ordering matters.
+		 */
+		if (vmdirq->flush_addr) {
+			guard(raw_spinlock)(&irqs->vmd->cfg_lock);
+			readw(vmdirq->flush_addr);
+		}
 		generic_handle_irq(vmdirq->virq);
+	}
 	srcu_read_unlock(&irqs->srcu, idx);
 
 	return IRQ_HANDLED;
@@ -703,6 +760,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		vmd->irqs[i].vmd = vmd;
 		vmd->irqs[i].virq = pci_irq_vector(dev, i);
 		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
@@ -784,7 +842,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	struct pci_bus *bus = NULL;
 	struct pci_dev *dev;
+	int domain = 0xffff;
 	int ret;
 
 	/*
@@ -865,6 +925,22 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
+	sd->vmd_dev = vmd->dev;
+
+	/*
+	 * VMD domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6, _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		domain = max_t(int, domain, pci_domain_nr(bus));
+	sd->domain = domain + 1;
+	if (sd->domain < 0)
+		return sd->domain;
+
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
@@ -890,24 +966,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
-	sd->vmd_dev = vmd->dev;
-
-	/*
-	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
-	 * domains.  Per ACPI r6.0, sec 6.5.6, _SEG returns an integer, of
-	 * which the lower 16 bits are the PCI Segment Group (domain) number.
-	 * Other bits are currently reserved.
-	 */
-	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
-	if (sd->domain < 0)
-		return sd->domain;
-
-	sd->node = pcibus_to_node(vmd->dev->bus);
-
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
-		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -1001,6 +1062,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	vmd->dev = dev;
 	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
+	vmd->features = features;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1066,7 +1128,6 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_free(&vmd_instance_ida, vmd->instance);
-	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
@@ -1124,7 +1185,7 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_VDEVICE(INTEL, 0xa77f),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-- 
2.53.0


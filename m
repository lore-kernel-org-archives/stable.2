Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048411;
	b=KSTxM5LYMGZTikFQa8gaU0bhIvNjbGviRONX8m+7FMxJouXcv0q+yOuLteKYEQqa6hBZ
	 Ojg5GUoXMjEoZ2fFY7sXtVaAdtQZ36aZsKQxUlp8TWS+wtxHdmjo6IoIwSwMw6iV7d/KC
	 dLUO4UprgLm/jgkITxpgW3eVdXha9PRw+Rjch7/cHMiVnE3j9tBZMfaXz1X6n3af6hqHZ
	 iwOSDlbyZMnQWtEmtayChguBj8dy/Ahm6yrRlqJ0KI3YiwLtdV9zbhWECvi7/dDZDEra1
	 swGr9EfP1c/l66aFHrePF/9Bj/qISQtpzT9vEglKVFkZpSXuYbn9AENajuPA49f2WXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7HWVPr37GePawQWTM2raUY9MUBr2aA5//UGcfCOxcXU=;
	b=3PBexkp1RfstGlIPZsoR1GCi1e5Bdsxz0X71lkSMR3I3Hd8d8zZMFDHn4Yxz7EkAHcKm
	 Pqoj6uNKLQwS2oCPm4MWX3fNHHyQoLUS54y7EQtRfyrucHswNwCUnEtWObBOOZWiuRA/f
	 eLwvX8GJtJAmyJWl5bMEvrCw93KwcPxRbbCM+qq0YelDY1mX46EWEAWaCWXNLOI7AKYFq
	 FG8oKgm2WKFKO89DFMXI+wRoT2n6irOzT+jwuyzJ2VbAiwKTURAWmijk+tcTjhY+lnGnH
	 ch3zdUybUtAbsLlhumV0EneKdXQYph7T1ld8sN2dEcU+sXoHwr/0PeEJU3ogll96+6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QHPP7ao/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHPP7ao/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D201F0089F;
	Sat,  7 Nov 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048411;
	bh=7HWVPr37GePawQWTM2raUY9MUBr2aA5//UGcfCOxcXU=;
	h=From:To:Cc:Subject:Date;
	b=QHPP7ao/eKPzewIS6/ghnnB3F5OK334731VwSm7lVpNJ96PXP2ZW0hOuZH3k/02vG
	 ysHb261s6odkNc9lFQWbGQBPds1hYEXy1NJMdUJCJDwDQPuqKfpEPccDLBVZ1i0lYi
	 Jk/iZeW/sjsZSoUOy37KLzXto8i/ijxLb7/TYGDHaNXhjzy+E4cK5JYOTfmY2tB9TD
	 nQDR+4Sp44fA22alnfqpDf3k7iGlvQyliQw7/+HUKc6dygil9eT2KBlqoiVBRXRFoG
	 T3ErvQgnBhH3ZwDeFeoO1NgkGQcTkkErwfOJzWKixRahcibKSfyDCJ+iEgiBnlLagc
	 /VOFgCeDZ4jHQ==
From: Sasha Levin <sashal@kernel.org>
To: subtexel@gmail.com,
	kai.heng.feng@canonical.com,
	kbusch@kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	varsh@varram.me
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: vmd: Flush DMA writes before handling MSI on Meteor Lake" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:48 -0500
Message-ID: <20261107054648-failed-6.1-7307899e381c@kernel.org>
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
git cherry-pick -x 7307899e381cb0c16245793a4adde7491d73a2b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054648-failed-6.1-7307899e381c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7307899e381cb0c16245793a4adde7491d73a2b3 Mon Sep 17 00:00:00 2001
From: Rickey Bartlett <subtexel@gmail.com>
Date: Mon, 24 Aug 2026 21:32:20 -0700
Subject: [PATCH] PCI: vmd: Flush DMA writes before handling MSI on Meteor Lake
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/pci/controller/vmd.c | 52 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 241023ecf6774..e45ef8cb16e47 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -92,6 +92,22 @@ enum vmd_features {
 	 * referred to as MEMBAR2 or MSI-X BAR.
 	 */
 	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
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
@@ -114,6 +130,9 @@ static DEFINE_RAW_SPINLOCK(list_lock);
  * @irq:	back pointer to parent.
  * @enabled:	true if driver enabled IRQ
  * @virq:	the virtual IRQ value provided to the requesting driver.
+ * @flush_addr:	config space address of the initiating device, read before
+ *		demuxing to flush its posted writes (MTL016); NULL if the
+ *		VMD is not affected.
  *
  * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
  * a VMD IRQ using this structure.
@@ -123,8 +142,14 @@ struct vmd_irq {
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
@@ -132,12 +157,15 @@ struct vmd_irq {
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
@@ -295,6 +323,13 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -756,8 +791,20 @@ static irqreturn_t vmd_irq(int irq, void *data)
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
@@ -788,6 +835,7 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		vmd->irqs[i].vmd = vmd;
 		vmd->irqs[i].virq = pci_irq_vector(dev, i);
 		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
@@ -1250,7 +1298,7 @@ static const struct pci_device_id vmd_ids[] = {
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





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571994;
	b=xqjYWlAfv/R6a1IADSzL9jwSnSQJk7QwwxppCFkWJsIjy1nV0XTza+mbkg2shYM6iFbj
	 LvdXzFdOpgV6EGVsXelhrTYX7QAZ1W0+QfaWEJHa/O9OEJZexY3T1ilShsI7//GK1wjN+
	 r+yaquVS09kUCJ3Tl9BAKUmpZEnikNNRwlj3b4LGkQysVa/j3pvuLilymRJO20dUgeKYA
	 bKPkVM8k3aoj0o9zggkgQA06bDFqeDmqlfPAj8ogB1ugqiZj3vzaLbO460cAHYz1R6Wyf
	 /fuMsPYJHTvUSjU8XuFbTmW5hBrI15qdfb2w+GLhgKLr/m1sjLdHI5Wq637GjUQB3UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oQilqtCsPwCrvN3qsHfQbXK8Hzi9hujLAVAF1a/Gc2s=;
	b=m6ZAosLgraq1fPp54ktYkBA8bthZ2XfixnXsmF/uEgbufcgaucjjb4EGMzcFh8b+xsa7
	 WGRAs2U4i5Zm8TW1ZhCFGgCAHwZQH0p8dNy+oWP0g9d2TICgJ2wHyH6rrwNFXTwHxPDei
	 /J/3MJalQ4vOpWQ2DR5569Y9+WTou2pGf71Bn9JMmHYjqPSDNPfK90yQkNFe086Hwfdp5
	 nv9DcjrhYPY7bdZO44lyPyWrVbMEIn5XWaDjX2oEpO4nCAtgYiH+NnOlGvdea1Tg/F82n
	 B//AH1yRkH8K+uG+Mif2Jp0OvoxseuepYFGfxLDNQsrPYmKk0XuliQQ9Sj7L7it+ATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nphivhUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADA606A319;
	Wed, 21 Oct 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nphivhUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407121F000CA;
	Wed, 21 Oct 2026 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792571992;
	bh=oQilqtCsPwCrvN3qsHfQbXK8Hzi9hujLAVAF1a/Gc2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nphivhUpT1lZYCDsOoY3Ov1xMpXDw5j5qHzLTD3lcZEeQlWdE4BkTJFqD47sPehZp
	 uhZ2vihWydnZzyx3H1fKMItwdWw5ZQEpZZpYvgnJrtEyThdY+XrBIbN2M7nQwAWVa7
	 HwJ3sUtgtYc0BQqGtSVNXChQ97Uhmgg9iHsIrxfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.58
Date: Wed, 21 Oct 2026 10:38:22 +0200
Message-ID: <2026102122-tastiness-devoutly-b6ae@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026102122-borax-tamale-6dd2@gregkh>
References: <2026102122-borax-tamale-6dd2@gregkh>
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

diff --git a/Makefile b/Makefile
index 5b57b2f093ea..4b6869e045e6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 57
+SUBLEVEL = 58
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index db13c9ddf9e3..1e8f1ac5a755 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -42,19 +42,20 @@ static inline bool is_kernel_exittext(uintptr_t addr)
 static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 {
 	uintptr_t uintaddr = (uintptr_t) addr;
-	struct page *page;
+	phys_addr_t phys;
 
-	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
-		page = phys_to_page(__pa_symbol(addr));
-	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		page = vmalloc_to_page(addr);
-	else
-		return addr;
+	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr)) {
+		phys = __pa_symbol(addr);
+	} else if (IS_ENABLED(CONFIG_EXECMEM)) {
+		struct page *page = vmalloc_to_page(addr);
 
-	BUG_ON(!page);
+		BUG_ON(!page);
+		phys = page_to_phys(page) + offset_in_page(addr);
+	} else {
+		return addr;
+	}
 
-	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
-					 offset_in_page(addr));
+	return (void *)set_fixmap_offset(fixmap, phys);
 }
 
 static void patch_unmap(int fixmap)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 6eddad77ab7c..87a5e085ef4e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -362,7 +362,7 @@ static inline bool is_noncanonical_invlpg_address(u64 la, struct kvm_vcpu *vcpu)
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
-	u64 gen = kvm_memslots(vcpu->kvm)->generation;
+	u64 gen = kvm_vcpu_memslots(vcpu)->generation;
 
 	if (unlikely(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS))
 		return;
@@ -379,7 +379,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.mmio_gen == kvm_memslots(vcpu->kvm)->generation;
+	return vcpu->arch.mmio_gen == kvm_vcpu_memslots(vcpu)->generation;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8473eaac1e7f..31f194142bd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1342,6 +1342,14 @@ static void smu_feature_cap_init(struct smu_context *smu)
 	bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
 }
 
+static int smu_set_power_dep(struct smu_context *smu, bool enable)
+{
+	if (!smu->ppt_funcs->set_power_dep)
+		return 0;
+
+	return smu->ppt_funcs->set_power_dep(smu, enable);
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1405,6 +1413,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!smu->ppt_funcs->get_fan_control_mode)
 		smu->adev->pm.no_fan = true;
 
+	smu_set_power_dep(smu, true);
+
 	return 0;
 }
 
@@ -1427,6 +1437,8 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	smu_fini_microcode(smu);
 
+	smu_set_power_dep(smu, false);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 582c186d8b62..e00beb901d90 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -599,6 +599,9 @@ struct smu_context {
 	bool pm_enabled;
 	bool is_apu;
 
+	/* Power dependency link from an integrated xHCI controller to the GPU */
+	struct device_link		*usb_power_link;
+
 	uint32_t smc_driver_if_version;
 	uint32_t smc_fw_if_version;
 	uint32_t smc_fw_version;
@@ -1521,6 +1524,13 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
 				   void *table);
+	/**
+	 * @set_power_dep: Create or destroy a power dependency link
+	 * from an integrated xHCI controller to the GPU so that the GPU is
+	 * resumed before the USB controller during PM resume. @enable is true
+	 * to create the link and false to tear it down.
+	 */
+	int (*set_power_dep)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 44cce9b636ca..3a2b16a9998c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1665,6 +1665,50 @@ static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
 	return ret;
 }
 
+/*
+ * Link any xHCI controller sharing the GPU's PCIe root port as a consumer
+ * of the GPU so the GPU resumes first, avoiding an xHCI resume race.
+ */
+static int smu_v14_0_0_set_power_dep(struct smu_context *smu, bool enable)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct pci_dev *gpu_pdev = adev->pdev;
+	struct pci_dev *root_port, *usb_pdev = NULL;
+	struct device_link *link;
+
+	if (!enable) {
+		if (smu->usb_power_link) {
+			device_link_del(smu->usb_power_link);
+			smu->usb_power_link = NULL;
+		}
+		return 0;
+	}
+
+	root_port = pcie_find_root_port(gpu_pdev);
+	while ((usb_pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, usb_pdev))) {
+		struct pci_dev *usb_root;
+
+		usb_root = pcie_find_root_port(usb_pdev);
+		if (usb_root != root_port)
+			continue;
+
+		/* Create device link: USB (consumer) depends on GPU (supplier) */
+		link = device_link_add(&usb_pdev->dev, &gpu_pdev->dev,
+				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+		if (link) {
+			smu->usb_power_link = link;
+			drm_info(adev_to_drm(adev), "USB controller %s D0 power state depends on %s\n",
+				 pci_name(usb_pdev), pci_name(gpu_pdev));
+			/* Only create one link for the first USB controller found */
+			break;
+		}
+	}
+
+	pci_dev_put(usb_pdev);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1699,6 +1743,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
 	.set_mall_enable = smu_v14_0_common_set_mall_enable,
+	.set_power_dep = smu_v14_0_0_set_power_dep,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 25c7eb725ce2..43311886dbf8 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -330,10 +330,13 @@ static void xe_i2c_remove(void *data)
 	struct xe_i2c *i2c = data;
 	unsigned int i;
 
+	/* Stop the notifier from arming the client work before teardown. */
+	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
+
 	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++)
 		i2c_unregister_device(i2c->client[i]);
 
-	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
 	xe_i2c_remove_irq(i2c);
 }
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index f35b30235018..f76da01a1d1f 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -573,8 +573,8 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&dev->cep_list);
 
 	spin_lock_init(&dev->lock);
-	xa_init_flags(&dev->qp_xa, XA_FLAGS_ALLOC1);
-	xa_init_flags(&dev->cq_xa, XA_FLAGS_ALLOC1);
+	xa_init_flags(&dev->qp_xa, XA_FLAGS_ALLOC1 | XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&dev->cq_xa, XA_FLAGS_ALLOC1 | XA_FLAGS_LOCK_IRQ);
 	dev->next_alloc_cqn = 1;
 	dev->next_alloc_qpn = 1;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index fdd67756f3bc..6feac67d8472 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1019,15 +1019,15 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	init_completion(&qp->safe_free);
 
 	if (qp->ibqp.qp_type == IB_QPT_GSI) {
-		old_entry = xa_store(&dev->qp_xa, 1, qp, GFP_KERNEL);
+		old_entry = xa_store_irq(&dev->qp_xa, 1, qp, GFP_KERNEL);
 		if (xa_is_err(old_entry))
 			ret = xa_err(old_entry);
 		else
 			qp->ibqp.qp_num = 1;
 	} else {
-		ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
-				      XA_LIMIT(1, dev->attrs.max_qp - 1),
-				      &dev->next_alloc_qpn, GFP_KERNEL);
+		ret = xa_alloc_cyclic_irq(&dev->qp_xa, &qp->ibqp.qp_num, qp,
+					  XA_LIMIT(1, dev->attrs.max_qp - 1),
+					  &dev->next_alloc_qpn, GFP_KERNEL);
 	}
 
 	if (ret < 0) {
@@ -1090,7 +1090,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	else
 		free_kernel_qp(qp);
 err_out_xa:
-	xa_erase(&dev->qp_xa, QP_ID(qp));
+	xa_erase_irq(&dev->qp_xa, QP_ID(qp));
 err_out:
 	return ret;
 }
@@ -1994,9 +1994,9 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	refcount_set(&cq->refcount, 1);
 	init_completion(&cq->free);
 
-	ret = xa_alloc_cyclic(&dev->cq_xa, &cq->cqn, cq,
-			      XA_LIMIT(1, dev->attrs.max_cq - 1),
-			      &dev->next_alloc_cqn, GFP_KERNEL);
+	ret = xa_alloc_cyclic_irq(&dev->cq_xa, &cq->cqn, cq,
+				  XA_LIMIT(1, dev->attrs.max_cq - 1),
+				  &dev->next_alloc_cqn, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -2044,7 +2044,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 err_out_xa:
-	xa_erase(&dev->cq_xa, cq->cqn);
+	xa_erase_irq(&dev->cq_xa, cq->cqn);
 
 	return ret;
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 415e763041bd..24d2e76c21a9 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -179,6 +179,7 @@ struct dm_integrity_c {
 	struct dm_bufio_client *bufio;
 	struct workqueue_struct *metadata_wq;
 	struct superblock *sb;
+	struct superblock *sb_copy;
 	unsigned int journal_pages;
 	unsigned int n_bitmap_blocks;
 
@@ -3856,6 +3857,35 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 	ic->journal_uptodate = true;
 }
 
+/*
+ * The superblock is re-read from the device on every resume, so that we pick
+ * up the flags and the recalculate position. The geometry described by the
+ * superblock must not change though - the in-memory structures (and the
+ * journal in particular) were sized according to the superblock that was
+ * validated in the constructor. Reject a superblock that was modified behind
+ * our back.
+ *
+ * Only the fields that the driver never rewrites may be tested here. In
+ * particular, "version" is recalculated by sb_set_version on every superblock
+ * write and it depends on SB_FLAG_RECALCULATING and SB_FLAG_DIRTY_BITMAP, and
+ * SB_FLAG_DISCARD_KEYED may be set by dm_integrity_resume itself.
+ */
+static bool superblock_changed(struct dm_integrity_c *ic)
+{
+	const __le32 immutable_flags = cpu_to_le32(SB_FLAG_HAVE_JOURNAL_MAC |
+						   SB_FLAG_FIXED_PADDING |
+						   SB_FLAG_FIXED_HMAC |
+						   SB_FLAG_INLINE);
+
+	return memcmp(ic->sb->magic, ic->sb_copy->magic, sizeof(ic->sb->magic)) != 0 ||
+	       ic->sb->log2_interleave_sectors != ic->sb_copy->log2_interleave_sectors ||
+	       ic->sb->integrity_tag_size != ic->sb_copy->integrity_tag_size ||
+	       ic->sb->journal_sections != ic->sb_copy->journal_sections ||
+	       ic->sb->log2_sectors_per_block != ic->sb_copy->log2_sectors_per_block ||
+	       ((ic->sb->flags ^ ic->sb_copy->flags) & immutable_flags) != 0 ||
+	       memcmp(ic->sb->salt, ic->sb_copy->salt, SALT_SIZE) != 0;
+}
+
 static void dm_integrity_resume(struct dm_target *ti)
 {
 	struct dm_integrity_c *ic = ti->private;
@@ -3873,6 +3903,22 @@ static void dm_integrity_resume(struct dm_target *ti)
 	r = sync_rw_sb(ic, REQ_OP_READ);
 	if (r)
 		dm_integrity_io_error(ic, "reading superblock", r);
+
+	if (unlikely(superblock_changed(ic))) {
+		/*
+		 * Restore the superblock that we validated in the constructor,
+		 * so that the rest of the driver doesn't operate on values
+		 * that don't match the in-memory structures.
+		 */
+		memcpy(ic->sb, ic->sb_copy, sizeof(struct superblock));
+		DMERR("The superblock was changed while the device was suspended");
+		dm_integrity_io_error(ic, "superblock check", -EINVAL);
+		goto skip_writes;
+	}
+
+	if (ic->mode == 'R')
+		goto skip_writes;
+
 	if ((ic->sb->flags & flags) != flags) {
 		ic->sb->flags |= flags;
 		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
@@ -3982,6 +4028,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 		}
 	}
 
+skip_writes:
 	ic->reboot_notifier.notifier_call = dm_integrity_reboot;
 	ic->reboot_notifier.next = NULL;
 	ic->reboot_notifier.priority = INT_MAX - 1;	/* be notified after md and before hardware drivers */
@@ -5406,6 +5453,13 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		ic->just_formatted = true;
 	}
 
+	ic->sb_copy = kmemdup(ic->sb, sizeof(struct superblock), GFP_KERNEL);
+	if (!ic->sb_copy) {
+		ti->error = "Cannot allocate superblock copy";
+		r = -ENOMEM;
+		goto bad;
+	}
+
 	if (!ic->meta_dev && ic->mode != 'I') {
 		r = dm_set_target_max_io_len(ti, 1U << ic->sb->log2_interleave_sectors);
 		if (r)
@@ -5504,6 +5558,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	kvfree(ic->journal_tree);
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
+	kfree(ic->sb_copy);
 
 	if (ic->internal_shash)
 		crypto_free_shash(ic->internal_shash);
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f8241ef5e..5fcbfa0ca855 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -259,7 +259,6 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct work_struct finish_config;
 	wait_queue_head_t down_waitqueue;
-	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
 	int num_vlan_filters;
@@ -588,8 +587,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-void iavf_add_ether_addrs(struct iavf_adapter *adapter);
+int iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
+void iavf_mac_add_reject(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
 void iavf_set_promiscuous(struct iavf_adapter *adapter);
@@ -606,6 +606,13 @@ void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				struct iavf_arq_event_info *event,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms);
 int iavf_config_rss(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d09add9a110e..0c99e3909952 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1029,6 +1029,60 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
 	return ret;
 }
 
+/**
+ * iavf_mac_change_done - Check if MAC change completed
+ * @adapter: board private structure
+ * @data: MAC address being checked (as const void *)
+ * @v_op: virtchnl opcode from processed message
+ *
+ * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
+ *
+ * Return: true if MAC change completed, false otherwise
+ */
+static bool iavf_mac_change_done(struct iavf_adapter *adapter,
+				 const void *data, enum virtchnl_ops v_op)
+{
+	const u8 *addr = data;
+
+	return iavf_is_mac_set_handled(adapter->netdev, addr);
+}
+
+/**
+ * iavf_set_mac_sync - Synchronously change MAC address
+ * @adapter: board private structure
+ * @addr: MAC address to set
+ *
+ * Send MAC change request to PF and poll admin queue for response.
+ * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
+ * Event buffer is allocated before sending to avoid state mismatch if
+ * allocation fails after message is sent to PF.
+ *
+ * Return: 0 on success, negative on failure
+ */
+static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
+{
+	struct iavf_arq_event_info event;
+	int ret;
+
+	netdev_assert_locked(adapter->netdev);
+
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	ret = iavf_add_ether_addrs(adapter);
+	if (ret)
+		goto out;
+
+	ret = iavf_poll_virtchnl_response(adapter, &event,
+					  iavf_mac_change_done, addr, 2500);
+
+out:
+	kfree(event.msg_buf);
+	return ret;
+}
+
 /**
  * iavf_set_mac - NDO callback to set port MAC address
  * @netdev: network interface device structure
@@ -1046,25 +1100,23 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 		return -EADDRNOTAVAIL;
 
 	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
-
 	if (ret)
 		return ret;
 
-	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
-					       iavf_is_mac_set_handled(netdev, addr->sa_data),
-					       msecs_to_jiffies(2500));
-
-	/* If ret < 0 then it means wait was interrupted.
-	 * If ret == 0 then it means we got a timeout.
-	 * else it means we got response for set MAC from PF,
-	 * check if netdev MAC was updated to requested MAC,
-	 * if yes then set MAC succeeded otherwise it failed return -EACCES
-	 */
-	if (ret < 0)
+	ret = iavf_set_mac_sync(adapter, addr->sa_data);
+	if (ret) {
+		/* Rollback only if send failed (message never reached PF).
+		 * Don't rollback on timeout (-EAGAIN) because the message was
+		 * sent and PF will eventually respond. When the response arrives,
+		 * iavf_virtchnl_completion() will handle rollback (on PF error)
+		 * or acceptance (on PF success) automatically.
+		 */
+		if (ret != -EAGAIN) {
+			iavf_mac_add_reject(adapter);
+			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
+		}
 		return ret;
-
-	if (!ret)
-		return -EAGAIN;
+	}
 
 	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		return -EACCES;
@@ -5388,9 +5440,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
-	/* Setup the wait queue for indicating virtchannel events */
-	init_waitqueue_head(&adapter->vc_waitqueue);
-
 	INIT_LIST_HEAD(&adapter->ptp.aq_cmds);
 	init_waitqueue_head(&adapter->ptp.phc_time_waitqueue);
 	mutex_init(&adapter->ptp.aq_cmd_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index f1a01b8e2235..6cf963b9c910 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/net/intel/libie/rx.h>
+#include <net/netdev_lock.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
@@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
  * @adapter: adapter structure
  *
  * Request that the PF add one or more addresses to our filters.
- **/
-void iavf_add_ether_addrs(struct iavf_adapter *adapter)
+ *
+ * Return: 0 on success, negative on failure
+ */
+int iavf_add_ether_addrs(struct iavf_adapter *adapter)
 {
 	struct virtchnl_ether_addr_list *veal;
 	struct iavf_mac_filter *f;
 	int i = 0, count = 0;
 	bool more = false;
 	size_t len;
+	int ret;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
 		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
 			adapter->current_op);
-		return;
+		return -EBUSY;
 	}
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -580,7 +584,7 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	if (!count) {
 		adapter->aq_required &= ~IAVF_FLAG_AQ_ADD_MAC_FILTER;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return 0;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
 
@@ -594,8 +598,9 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	veal = kzalloc(len, GFP_ATOMIC);
 	if (!veal) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
-		return;
+		return -ENOMEM;
 	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
@@ -615,8 +620,15 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
+	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
 	kfree(veal);
+	if (ret) {
+		dev_err(&adapter->pdev->dev,
+			"Unable to send ADD_ETH_ADDR message to PF, error %d\n", ret);
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+
+	return ret;
 }
 
 /**
@@ -712,8 +724,8 @@ static void iavf_mac_add_ok(struct iavf_adapter *adapter)
  * @adapter: adapter structure
  *
  * Remove filters from list based on PF response.
- **/
-static void iavf_mac_add_reject(struct iavf_adapter *adapter)
+ */
+void iavf_mac_add_reject(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_mac_filter *f, *ftmp;
@@ -2360,7 +2372,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			iavf_mac_add_reject(adapter);
 			/* restore administratively set MAC address */
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
-			wake_up(&adapter->vc_waitqueue);
 			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
@@ -2546,14 +2557,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
-		wake_up(&adapter->vc_waitqueue);
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
@@ -2948,3 +2956,72 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	} /* switch v_opcode */
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
+
+/**
+ * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
+ * @adapter: adapter structure
+ * @event: pre-allocated event buffer to use for polling
+ * @condition: callback to check if desired response received
+ * @cond_data: context data passed to condition callback
+ * @timeout_ms: maximum time to wait in milliseconds
+ *
+ * Polls the admin queue and processes all incoming virtchnl messages.
+ * After processing each valid message, calls the condition callback to check
+ * if the expected response has been received. The callback receives the opcode
+ * of the processed message to identify which response was received. Continues
+ * polling until the callback returns true or timeout expires.
+ *
+ * Caller must allocate event buffer before sending any messages to PF to avoid
+ * state mismatch if allocation fails after message is sent.
+ *
+ * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
+ * polling hardware.
+ *
+ * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
+ */
+int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
+				struct iavf_arq_event_info *event,
+				bool (*condition)(struct iavf_adapter *adapter,
+						  const void *data,
+						  enum virtchnl_ops v_op),
+				const void *cond_data,
+				unsigned int timeout_ms)
+{
+	struct iavf_hw *hw = &adapter->hw;
+	enum virtchnl_ops received_op;
+	unsigned long timeout;
+	int ret = -EAGAIN;
+	u16 pending = 0;
+	u32 v_retval;
+
+	netdev_assert_locked(adapter->netdev);
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		if (!pending)
+			usleep_range(50, 75);
+
+		if (iavf_clean_arq_element(hw, event, &pending) == IAVF_SUCCESS) {
+			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+			if (received_op != VIRTCHNL_OP_UNKNOWN) {
+				v_retval = le32_to_cpu(event->desc.cookie_low);
+
+				iavf_virtchnl_completion(adapter, received_op,
+							 (enum iavf_status)v_retval,
+							 event->msg_buf, event->msg_len);
+
+				if (condition(adapter, cond_data, received_op)) {
+					ret = 0;
+					break;
+				}
+			}
+
+			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
+
+			if (pending)
+				continue;
+		}
+	} while (time_before(jiffies, timeout));
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 7bb8382940b3..caf77991a54e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -91,7 +91,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 		goto out;
 
 	xdp_init_buff(xdp, PAGE_SIZE, &rxq->xdp_rxq);
-	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, true);
+	xdp_prepare_buff(xdp, buf_va, rxq->headroom, pkt_len, true);
 
 	act = bpf_prog_run_xdp(prog, xdp);
 
@@ -183,9 +183,9 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	if (!old_prog && !prog)
 		return 0;
 
-	if (prog && ndev->mtu > MANA_XDP_MTU_MAX) {
+	if (prog && ndev->mtu > MANA_XDP_MTU_MAX(ndev)) {
 		netdev_err(ndev, "XDP: mtu:%u too large, mtu_max:%lu\n",
-			   ndev->mtu, MANA_XDP_MTU_MAX);
+			   ndev->mtu, MANA_XDP_MTU_MAX(ndev));
 		NL_SET_ERR_MSG_MOD(extack, "XDP: mtu too large");
 
 		return -EOPNOTSUPP;
@@ -238,7 +238,7 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 	if (prog)
-		ndev->max_mtu = MANA_XDP_MTU_MAX;
+		ndev->max_mtu = MANA_XDP_MTU_MAX(ndev);
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 5cbe24a1596c..befeb20fb7d5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -749,7 +749,7 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 	return va;
 }
 
-/* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
+/* Get RX buffer's data size, alloc size, headroom and frag count based on MTU */
 static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 			       int mtu, u32 *datasize, u32 *alloc_size,
 			       u32 *headroom, u32 *frag_count)
@@ -759,16 +759,20 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
-		if (mana_xdp_get(apc)) {
-			*headroom = XDP_PACKET_HEADROOM;
+	*headroom = LL_RESERVED_SPACE(apc->ndev);
+	if (mana_xdp_get(apc))
+		*headroom = max_t(u32, *headroom, XDP_PACKET_HEADROOM);
+
+	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+
+	/* For xdp and large buffers make sure only one packet fits per page */
+	if (PAGE_SIZE / buf_size < 2 || mana_xdp_get(apc)) {
+		if (mana_xdp_get(apc))
 			*alloc_size = PAGE_SIZE;
-		} else {
-			*headroom = 0; /* no support for XDP */
+		else
 			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
 						     *headroom);
-		}
 
 		*frag_count = 1;
 
@@ -782,12 +786,6 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	}
 
 	/* Standard MTU case - optimize for multiple packets per page */
-	*headroom = 0;
-
-	/* Calculate base buffer size needed */
-	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
-	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
-
 	/* Calculate how many packets can fit in a page */
 	*frag_count = PAGE_SIZE / buf_size;
 	*alloc_size = buf_size;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..c63d99686d0b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -523,8 +523,9 @@ struct skbuf_dma_descriptor {
  * @stats_work: Work for reading the hardware statistics counters often enough
  *              to catch overflows.
  * @dma_err_task: Work structure to process Axi DMA errors
- * @stopping:   Set when @dma_err_task shouldn't do anything because we are
- *              about to stop the device.
+ * @stopping:   Set when we are about to stop the device: makes @dma_err_task
+ *              a no-op (legacy DMA path) and fences RX descriptor
+ *              resubmission in axienet_dma_rx_cb() (dmaengine path).
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
  * @eth_irq:	Ethernet core IRQ number
@@ -545,6 +546,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @rx_submit_lock: Protects RX ring resubmission vs teardown in dmaengine path.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -626,6 +628,7 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	spinlock_t rx_submit_lock;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index eefe54ce6685..50ddc7c53b63 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -881,6 +881,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->tx_stat_sync);
 	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
 	dev_consume_skb_any(skbuf_dma->skb);
+	skbuf_dma->skb = NULL;
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
 				 2);
@@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+	skbuf_dma->skb = NULL;
 
 	if (IS_ERR(app_metadata)) {
 		if (net_ratelimit())
@@ -1193,10 +1195,17 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_update_end(&lp->rx_stat_sync);
 
 rx_submit:
+	spin_lock(&lp->rx_submit_lock);
+	if (lp->stopping) {
+		spin_unlock(&lp->rx_submit_lock);
+		return;
+	}
+
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
 	dma_async_issue_pending(lp->rx_chan);
+	spin_unlock(&lp->rx_submit_lock);
 }
 
 /**
@@ -1541,6 +1550,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 	lp->tx_ring_head = 0;
 	lp->rx_ring_tail = 0;
 	lp->rx_ring_head = 0;
+	lp->stopping = false;
 	lp->tx_skb_ring = kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring),
 				  GFP_KERNEL);
 	if (!lp->tx_skb_ring) {
@@ -1754,20 +1764,42 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
 	} else {
+		struct skbuf_dma_descriptor *skbuf_dma;
+
+		spin_lock_bh(&lp->rx_submit_lock);
+		lp->stopping = true;
+		spin_unlock_bh(&lp->rx_submit_lock);
+
 		dmaengine_terminate_sync(lp->tx_chan);
-		dmaengine_synchronize(lp->tx_chan);
 		dmaengine_terminate_sync(lp->rx_chan);
-		dmaengine_synchronize(lp->rx_chan);
-
-		for (i = 0; i < TX_BD_NUM_MAX; i++)
-			kfree(lp->tx_skb_ring[i]);
-		kfree(lp->tx_skb_ring);
-		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
-			kfree(lp->rx_skb_ring[i]);
-		kfree(lp->rx_skb_ring);
 
 		dma_release_channel(lp->rx_chan);
 		dma_release_channel(lp->tx_chan);
+
+		/* Unmap and free any buffer the terminate did not reclaim, so it
+		 * is not leaked; a non-NULL skb marks such a slot.
+		 */
+		for (i = 0; i < TX_BD_NUM_MAX; i++) {
+			skbuf_dma = lp->tx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_sg(lp->dev, skbuf_dma->sgl,
+					     skbuf_dma->sg_len, DMA_TO_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->tx_skb_ring);
+
+		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
+			skbuf_dma = lp->rx_skb_ring[i];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
+						 lp->max_frm_size, DMA_FROM_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(skbuf_dma);
+		}
+		kfree(lp->rx_skb_ring);
 	}
 
 	netdev_reset_queue(ndev);
@@ -3060,6 +3092,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lp->rx_cr_lock);
 	spin_lock_init(&lp->tx_cr_lock);
+	spin_lock_init(&lp->rx_submit_lock);
 	INIT_WORK(&lp->rx_dim.work, axienet_rx_dim_work);
 	lp->rx_dim_enabled = true;
 	lp->rx_dim.profile_ix = 1;
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 610717fb83f5..805ad31edba2 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -206,16 +206,9 @@ static void ath9k_wmi_rsp_callback(struct wmi *wmi, struct sk_buff *skb)
 {
 	skb_pull(skb, sizeof(struct wmi_cmd_hdr));
 
-	if (wmi->cmd_rsp_buf && wmi->cmd_rsp_len) {
-		if (skb->len < wmi->cmd_rsp_len) {
-			wmi->cmd_rsp_status = -EMSGSIZE;
-			goto complete;
-		}
+	if (wmi->cmd_rsp_buf != NULL && wmi->cmd_rsp_len != 0)
 		memcpy(wmi->cmd_rsp_buf, skb->data, wmi->cmd_rsp_len);
-	}
-	wmi->cmd_rsp_status = 0;
 
-complete:
 	complete(&wmi->cmd_wait);
 }
 
@@ -307,7 +300,6 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	/* record the rsp buffer and length */
 	wmi->cmd_rsp_buf = rsp_buf;
 	wmi->cmd_rsp_len = rsp_len;
-	wmi->cmd_rsp_status = 0;
 
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
@@ -364,13 +356,9 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		return -ETIMEDOUT;
 	}
 
-	spin_lock_irqsave(&wmi->wmi_lock, flags);
-	ret = wmi->cmd_rsp_status;
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
-
 	mutex_unlock(&wmi->op_mutex);
 
-	return ret;
+	return 0;
 
 out:
 	ath_dbg(common, WMI, "WMI failure for: %s\n", wmi_cmd_to_name(cmd_id));
diff --git a/drivers/net/wireless/ath/ath9k/wmi.h b/drivers/net/wireless/ath/ath9k/wmi.h
index 0bb9d31f1a1c..5c3b710b8f31 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -157,7 +157,6 @@ struct wmi {
 	u16 tx_seq_id;
 	u8 *cmd_rsp_buf;
 	u32 cmd_rsp_len;
-	int cmd_rsp_status;
 	bool stopped;
 
 	struct list_head pending_tx_events;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 46e337307c3d..569b94b48926 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1226,6 +1226,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	len = enable ? sizeof(dev_req) : sizeof(basic_req);
 
 	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err && cmd == MCU_UNI_CMD(BSS_INFO_UPDATE))
+		err = mt76_connac_mcu_bss_deact_err(dev, err, enable);
+
 	if (err < 0)
 		return err;
 
@@ -1233,7 +1236,11 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	data = enable ? (void *)&basic_req : (void *)&dev_req;
 	len = enable ? sizeof(basic_req) : sizeof(dev_req);
 
-	return mt76_mcu_send_msg(dev, cmd, data, len, true);
+	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err && cmd == MCU_UNI_CMD(BSS_INFO_UPDATE))
+		err = mt76_connac_mcu_bss_deact_err(dev, err, enable);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5ed2fffbe107..a24979698a8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1894,6 +1894,29 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	}
 }
 
+#define MT76_CONNAC_MCU_STATUS_WLAN_FAILURE	0xc0000001
+
+static inline int
+mt76_connac_mcu_bss_deact_err(struct mt76_dev *mdev, int err, bool enable)
+{
+	if (err != (int)MT76_CONNAC_MCU_STATUS_WLAN_FAILURE)
+		return err;
+
+	/* Ignore wlan_failure state false alarm when deactivating an
+	 * inactive network. It does not harm the firmware state.
+	 */
+	if (!enable) {
+		dev_dbg(mdev->dev,
+			"ignore wlan_failure when bss is deactivated\n");
+		return 0;
+	}
+
+	dev_warn(mdev->dev,
+		 "wlan_failure when bss is activated\n");
+
+	return err;
+}
+
 struct sk_buff *
 __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				struct mt76_wcid *wcid, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8b1e1d2ed254..75f105d224ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2848,6 +2848,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_dev *dev = phy->dev;
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
+	int err;
 
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
@@ -2875,8 +2876,9 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_mbssid_tlv(skb, link_conf, enable);
 	}
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+	return mt76_connac_mcu_bss_deact_err(&dev->mt76, err, enable);
 }
 
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2c1dd6ffa27d..a77d7cde4524 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,9 +692,17 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
+/**
+ * dw_pcie_wait_for_link - Wait for the PCIe link to be up
+ * @pci: DWC instance
+ *
+ * Returns: 0 if link is up, -ENODEV if device is not found, -EIO if the device
+ * is found but not active and -ETIMEDOUT if the link fails to come up for other
+ * reasons.
+ */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val;
+	u32 offset, val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -706,6 +714,27 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	}
 
 	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
+		/*
+		 * If the link is in Detect.Quiet or Detect.Active state, it
+		 * indicates that no device is detected.
+		 */
+		ltssm = dw_pcie_get_ltssm(pci);
+		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
+		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
+			dev_info(pci->dev, "Device not found\n");
+			return -ENODEV;
+
+		/*
+		 * If the link is in POLL.{Active/Compliance} state, then the
+		 * device is found to be connected to the bus, but it is not
+		 * active i.e., the device firmware might not yet initialized.
+		 */
+		} else if (ltssm == DW_PCIE_LTSSM_POLL_ACTIVE ||
+			   ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
+			dev_info(pci->dev, "Device found, but not active\n");
+			return -EIO;
+		}
+
 		dev_info(pci->dev, "Phy link never came up\n");
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index fa07a6f54003..c2c018236517 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -112,7 +112,6 @@ typedef struct {
 	int                 minor;
 	char                name[8];
 	struct scsi_device  *device;
-	struct scsi_device  **dt;        /* ptrs to data transfer elements */
 	u_int               firsts[CH_TYPES];
 	u_int               counts[CH_TYPES];
 	u_int		    voltags;
@@ -363,16 +362,10 @@ ch_readconfig(scsi_changer *ch)
 			vendor_labels[i]);
 	}
 
-	/* look up the devices of the data transfer elements */
-	ch->dt = kcalloc(ch->counts[CHET_DT], sizeof(*ch->dt),
-			 GFP_KERNEL);
-
-	if (!ch->dt) {
-		kfree(buffer);
-		return -ENOMEM;
-	}
-
+	/* report the devices of the data transfer elements */
 	for (elem = 0; elem < ch->counts[CHET_DT]; elem++) {
+		struct scsi_device *sdev;
+
 		id  = -1;
 		lun = 0;
 		if (elem < CH_DT_MAX  &&  -1 != dt_id[elem]) {
@@ -388,10 +381,8 @@ ch_readconfig(scsi_changer *ch)
 			VPRINTK(KERN_INFO, "dt 0x%x: ",elem+ch->firsts[CHET_DT]);
 			if (data[6] & 0x80) {
 				VPRINTK(KERN_CONT, "not this SCSI bus\n");
-				ch->dt[elem] = NULL;
 			} else if (0 == (data[6] & 0x30)) {
 				VPRINTK(KERN_CONT, "ID/LUN unknown\n");
-				ch->dt[elem] = NULL;
 			} else {
 				id  = ch->device->id;
 				lun = 0;
@@ -401,18 +392,16 @@ ch_readconfig(scsi_changer *ch)
 		}
 		if (-1 != id) {
 			VPRINTK(KERN_CONT, "ID %i, LUN %i, ",id,lun);
-			ch->dt[elem] =
-				scsi_device_lookup(ch->device->host,
-						   ch->device->channel,
-						   id,lun);
-			if (!ch->dt[elem]) {
+			sdev = scsi_device_lookup(ch->device->host,
+						  ch->device->channel,
+						  id, lun);
+			if (!sdev) {
 				/* should not happen */
 				VPRINTK(KERN_CONT, "Huh? device not found!\n");
 			} else {
 				VPRINTK(KERN_CONT, "name: %8.8s %16.16s %4.4s\n",
-					ch->dt[elem]->vendor,
-					ch->dt[elem]->model,
-					ch->dt[elem]->rev);
+					sdev->vendor, sdev->model, sdev->rev);
+				scsi_device_put(sdev);
 			}
 		}
 	}
@@ -576,7 +565,6 @@ static void ch_destroy(struct kref *ref)
 	scsi_changer *ch = container_of(ref, scsi_changer, ref);
 
 	ch->device = NULL;
-	kfree(ch->dt);
 	kfree(ch);
 }
 
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 84aade141606..36692aa62bbd 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -475,13 +475,15 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	if (ms->irq0 && ms->irq1) {
 		rc = request_irq(ms->irq0, mpc52xx_spi_irq, 0,
 				  "mpc5200-spi-modf", ms);
-		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, 0,
-				  "mpc5200-spi-spif", ms);
-		if (rc) {
-			free_irq(ms->irq0, ms);
-			free_irq(ms->irq1, ms);
-			ms->irq0 = ms->irq1 = 0;
+		if (rc == 0) {
+			rc = request_irq(ms->irq1, mpc52xx_spi_irq, 0,
+					 "mpc5200-spi-spif", ms);
+			if (rc)
+				free_irq(ms->irq0, ms);
 		}
+
+		if (rc)
+			ms->irq0 = ms->irq1 = 0;
 	} else {
 		/* operate in polled mode */
 		ms->irq0 = ms->irq1 = 0;
@@ -501,8 +503,10 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
  err_register:
 	dev_err(&ms->host->dev, "initialization failed\n");
-	free_irq(ms->irq0, ms);
-	free_irq(ms->irq1, ms);
+	if (ms->irq0) {
+		free_irq(ms->irq0, ms);
+		free_irq(ms->irq1, ms);
+	}
 	cancel_work_sync(&ms->work);
  err_gpio:
 	while (i-- > 0)
@@ -525,8 +529,10 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 
 	spi_unregister_controller(host);
 
-	free_irq(ms->irq0, ms);
-	free_irq(ms->irq1, ms);
+	if (ms->irq0) {
+		free_irq(ms->irq0, ms);
+		free_irq(ms->irq1, ms);
+	}
 
 	cancel_work_sync(&ms->work);
 
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index c9bdd4140fd0..55a7647685b4 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -303,19 +303,34 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 	return div_u64(addr, ufshcd_get_ucd_size(hba));
 }
 
+static void ufshcd_mcq_compl_cqe(struct ufs_hba *hba, struct cq_entry *cqe)
+{
+	int tag = ufshcd_mcq_get_tag(hba, cqe);
+
+	ufshcd_compl_one_cqe(hba, tag, cqe);
+	/* After processing the CQE, mark it as an empty (invalid) entry. */
+	cqe->command_desc_base_addr = 0;
+}
+
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
-	int tag = ufshcd_mcq_get_tag(hba, cqe);
 
-	if (cqe->command_desc_base_addr) {
-		ufshcd_compl_one_cqe(hba, tag, cqe);
-		/* After processed the cqe, mark it empty (invalid) entry */
-		cqe->command_desc_base_addr = 0;
-	}
+	if (cqe->command_desc_base_addr)
+		ufshcd_mcq_compl_cqe(hba, cqe);
+	else
+		dev_err(hba->dev, "Abnormal CQ entry!\n");
 }
 
+/*
+ * This function is called from the UFS error handler with the UFS host
+ * controller disabled (HCE = 0). Reading host controller registers, e.g. the
+ * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
+ * Hence, iterate over all completion queue entries. This won't result in
+ * double completions because ufshcd_mcq_compl_cqe() clears a CQE after it
+ * has been processed.
+ */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 				    struct ufs_hw_queue *hwq)
 {
@@ -324,13 +339,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 
 	spin_lock_irqsave(&hwq->cq_lock, flags);
 	while (entries > 0) {
-		ufshcd_mcq_process_cqe(hba, hwq);
+		struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+
+		if (cqe->command_desc_base_addr)
+			ufshcd_mcq_compl_cqe(hba, cqe);
 		ufshcd_mcq_inc_cq_head_slot(hwq);
 		entries--;
 	}
-
-	ufshcd_mcq_update_cq_tail_slot(hwq);
-	hwq->cq_head_slot = hwq->cq_tail_slot;
 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9d32e658ad60..52df1df6333a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5743,7 +5743,17 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
 	unsigned long flags;
-	int tag;
+	int tag, i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		if (force_compl)
+			ufshcd_mcq_compl_all_cqes_lock(hba, &hba->uhq[i]);
+		else
+			ufshcd_mcq_poll_cqe_lock(hba, &hba->uhq[i]);
+	}
+
+	if (!force_compl)
+		return;
 
 	for (tag = 0; tag < hba->nutrs; tag++) {
 		lrbp = &hba->lrb[tag];
@@ -5756,22 +5766,17 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 		if (!hwq)
 			continue;
 
-		if (force_compl) {
-			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-			/*
-			 * For those cmds of which the cqes are not present
-			 * in the cq, complete them explicitly.
-			 */
-			spin_lock_irqsave(&hwq->cq_lock, flags);
-			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				set_host_byte(cmd, DID_REQUEUE);
-				ufshcd_release_scsi_cmd(hba, lrbp);
-				scsi_done(cmd);
-			}
-			spin_unlock_irqrestore(&hwq->cq_lock, flags);
-		} else {
-			ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		/*
+		 * For those cmds of which the cqes are not present
+		 * in the cq, complete them explicitly.
+		 */
+		spin_lock_irqsave(&hwq->cq_lock, flags);
+		if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+			set_host_byte(cmd, DID_REQUEUE);
+			ufshcd_release_scsi_cmd(hba, lrbp);
+			scsi_done(cmd);
 		}
+		spin_unlock_irqrestore(&hwq->cq_lock, flags);
 	}
 }
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ee59e6516187..4fe9c38dd2ca 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1279,8 +1279,10 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* create char device */
 	hidg->cdev = cdev_alloc();
-	if (!hidg->cdev)
+	if (!hidg->cdev) {
+		status = -ENOMEM;
 		goto fail_free_all;
+	}
 	hidg->cdev->ops = &f_hidg_fops;
 
 	status = cdev_device_add(hidg->cdev, &hidg->dev);
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 38f6dcdfd7fb..827b364c9f5d 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -71,10 +71,10 @@ static struct usb_driver iowarrior_driver;
 
 /* Structure to hold all of our device specific stuff */
 struct iowarrior {
+	struct kref kref;
 	struct mutex mutex;			/* locks this structure */
 	struct usb_device *udev;		/* save off the usb device pointer */
 	struct usb_interface *interface;	/* the interface for this device */
-	unsigned char minor;			/* the starting minor number for this device */
 	struct usb_endpoint_descriptor *int_out_endpoint;	/* endpoint for reading (needed for IOW56 only) */
 	struct usb_endpoint_descriptor *int_in_endpoint;	/* endpoint for reading */
 	struct urb *int_in_urb;		/* the urb for reading data */
@@ -244,9 +244,10 @@ static void iowarrior_write_callback(struct urb *urb)
 /*
  *	iowarrior_delete
  */
-static inline void iowarrior_delete(struct iowarrior *dev)
+static inline void iowarrior_delete(struct kref *kref)
 {
-	dev_dbg(&dev->interface->dev, "minor %d\n", dev->minor);
+	struct iowarrior *dev = container_of(kref, struct iowarrior, kref);
+
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
@@ -297,9 +298,6 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 		goto exit;
 	}
 
-	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
-		dev->minor, count);
-
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
 	    && (count != (dev->report_size + 1))) {
@@ -379,8 +377,6 @@ static ssize_t iowarrior_write(struct file *file,
 		retval = -ENODEV;
 		goto exit;
 	}
-	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
-		dev->minor, count);
 	/* if count is 0 we're already done */
 	if (count == 0) {
 		retval = 0;
@@ -523,9 +519,6 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 		goto error_out;
 	}
 
-	dev_dbg(&dev->interface->dev, "minor %d, cmd 0x%.4x, arg %ld\n",
-		dev->minor, cmd, arg);
-
 	retval = 0;
 	switch (cmd) {
 	case IOW_WRITE:
@@ -650,6 +643,9 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	}
 	/* increment our usage count for the driver */
 	++dev->opened;
+
+	kref_get(&dev->kref);
+
 	/* save our object in the file's private structure */
 	file->private_data = dev;
 	retval = 0;
@@ -665,39 +661,25 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 static int iowarrior_release(struct inode *inode, struct file *file)
 {
 	struct iowarrior *dev;
-	int retval = 0;
 
 	dev = file->private_data;
 	if (!dev)
 		return -ENODEV;
 
-	dev_dbg(&dev->interface->dev, "minor %d\n", dev->minor);
-
 	/* lock our device */
 	mutex_lock(&dev->mutex);
+	dev->opened = 0;	/* we're closing now */
 
-	if (dev->opened <= 0) {
-		retval = -ENODEV;	/* close called more than once */
-		mutex_unlock(&dev->mutex);
-	} else {
-		dev->opened = 0;	/* we're closing now */
-		retval = 0;
-		if (dev->present) {
-			/*
-			   The device is still connected so we only shutdown
-			   pending read-/write-ops.
-			 */
-			usb_kill_urb(dev->int_in_urb);
-			wake_up_interruptible(&dev->read_wait);
-			wake_up_interruptible(&dev->write_wait);
-			mutex_unlock(&dev->mutex);
-		} else {
-			/* The device was unplugged, cleanup resources */
-			mutex_unlock(&dev->mutex);
-			iowarrior_delete(dev);
-		}
+	if (dev->present) {
+		usb_kill_urb(dev->int_in_urb);
+		wake_up_interruptible(&dev->read_wait);
+		wake_up_interruptible(&dev->write_wait);
 	}
-	return retval;
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, iowarrior_delete);
+
+	return 0;
 }
 
 static __poll_t iowarrior_poll(struct file *file, poll_table * wait)
@@ -775,12 +757,14 @@ static int iowarrior_probe(struct usb_interface *interface,
 	struct usb_host_interface *iface_desc;
 	int retval = -ENOMEM;
 	int res;
+	int minor;
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct iowarrior), GFP_KERNEL);
 	if (!dev)
 		return retval;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 
 	atomic_set(&dev->intr_idx, 0);
@@ -890,16 +874,17 @@ static int iowarrior_probe(struct usb_interface *interface,
 		goto error;
 	}
 
-	dev->minor = interface->minor;
+	minor = interface->minor;
 
 	/* let the user know what node this device is now attached to */
 	dev_info(&interface->dev, "IOWarrior product=0x%x, serial=%s interface=%d "
 		 "now attached to iowarrior%d\n", dev->product_id, dev->chip_serial,
-		 iface_desc->desc.bInterfaceNumber, dev->minor - IOWARRIOR_MINOR_BASE);
+		 iface_desc->desc.bInterfaceNumber, minor - IOWARRIOR_MINOR_BASE);
 	return retval;
 
 error:
-	iowarrior_delete(dev);
+	kref_put(&dev->kref, iowarrior_delete);
+
 	return retval;
 }
 
@@ -923,19 +908,14 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	usb_kill_anchored_urbs(&dev->submitted);
 
 	if (dev->opened) {
-		/* There is a process that holds a filedescriptor to the device ,
-		   so we only shutdown read-/write-ops going on.
-		   Deleting the device is postponed until close() was called.
-		 */
 		usb_kill_urb(dev->int_in_urb);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
-		mutex_unlock(&dev->mutex);
-	} else {
-		/* no process is using the device, cleanup now */
-		mutex_unlock(&dev->mutex);
-		iowarrior_delete(dev);
 	}
+
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, iowarrior_delete);
 }
 
 /* usb specific object needed to register this driver with the usb subsystem */
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 92b091783966..415c22a9e636 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -128,6 +128,31 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	return fat__get_entry(dir, pos, bh, de);
 }
 
+/*
+ * Like fat_get_entry(), but honour the FAT end-of-directory marker:
+ * a dirent whose first name byte is NUL terminates iteration per the
+ * spec, which also guarantees that every following slot is zeroed.
+ * Skip straight to the end of the directory so the next call returns
+ * -1 from fat_bmap() without re-reading the trailing zero slots, and
+ * so callers that persist *pos across invocations (e.g. readdir's
+ * ctx->pos) keep reporting EOD.  Release *bh and set it to NULL to
+ * match fat_get_entry()'s contract that *bh is NULL on the -1 return.
+ */
+static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
+			     struct buffer_head **bh,
+			     struct msdos_dir_entry **de)
+{
+	int err = fat_get_entry(dir, pos, bh, de);
+
+	if (err == 0 && (*de)->name[0] == 0) {
+		brelse(*bh);
+		*bh = NULL;
+		*pos = dir->i_size;
+		return -1;
+	}
+	return err;
+}
+
 /*
  * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -325,7 +350,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -487,7 +512,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -599,7 +624,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -882,7 +907,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de) >= 0) {
+	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -1298,6 +1323,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos;
+	bool saw_eod;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1306,12 +1332,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	bh = prev = NULL;
 	pos = 0;
 	err = -ENOSPC;
+	saw_eod = false;
 	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
 		/* check the maximum size of directory */
 		if (pos >= FAT_MAX_DIR_SIZE)
 			goto error;
 
 		if (IS_FREE(de->name)) {
+			if (de->name[0] == 0)
+				saw_eod = true;
 			if (prev != bh) {
 				get_bh(bh);
 				bhs[nr_bhs] = prev = bh;
@@ -1321,6 +1350,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			if (free_slots == nr_slots)
 				goto found;
 		} else {
+			if (saw_eod) {
+				fat_fs_error_ratelimit(sb,
+					"allocated dir entry found after end-of-directory marker (i_pos %lld)",
+					MSDOS_I(dir)->i_pos);
+				err = -EIO;
+				goto error;
+			}
 			for (i = 0; i < nr_bhs; i++)
 				brelse(bhs[i]);
 			prev = NULL;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 898aaeea2059..864eebb1f076 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2084,6 +2084,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_dec_async_copy_err;
 		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
+		memcpy(&async_copy->cp_res.cb_stateid, &async_copy->cp_stateid.cs_stid,
+		       sizeof(async_copy->cp_res.cb_stateid));
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
 			async_copy->attr_update = true;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index ec6d27ba4083..995d6df9304f 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3135,11 +3135,8 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	cifs_put_tlink(tlink);
 
 set_size_out:
-	if (rc == 0) {
-		/* Pairs with smp_load_acquire() in is_size_safe_to_change(). */
-		smp_store_release(&cifsInode->time_last_write, jiffies);
+	if (rc == 0)
 		cifs_resize_file_locked(inode, size);
-	}
 
 	return rc;
 }
@@ -3202,6 +3199,17 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_SIZE) {
+		if (attrs->ia_size != i_size_read(inode)) {
+			/* Stamp before RPC. On failure the stamp remains: restoring a
+			 * stale snapshot could silently erase a concurrent
+			 * _cifsFileInfo_put() close stamp.  readdir is suppressed
+			 * until the stamp expires; stat() bypasses this via the
+			 * from_readdir=false path in is_size_safe_to_change() and
+			 * always returns an authoritative QUERY_INFO result.
+			 * Pairs with smp_load_acquire() in is_size_safe_to_change().
+			 */
+			smp_store_release(&cifsInode->time_last_write, jiffies);
+		}
 		rc = cifs_file_set_size(xid, direntry, full_path,
 					open_file, attrs->ia_size);
 		if (rc != 0)
@@ -3378,6 +3386,17 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
+		if (attrs->ia_size != i_size_read(inode)) {
+			/* Stamp before RPC. On failure the stamp remains: restoring a
+			 * stale snapshot could silently erase a concurrent
+			 * _cifsFileInfo_put() close stamp.  readdir is suppressed
+			 * until the stamp expires; stat() bypasses this via the
+			 * from_readdir=false path in is_size_safe_to_change() and
+			 * always returns an authoritative QUERY_INFO result.
+			 * Pairs with smp_load_acquire() in is_size_safe_to_change().
+			 */
+			smp_store_release(&cifsInode->time_last_write, jiffies);
+		}
 		rc = cifs_file_set_size(xid, direntry, full_path,
 					cfile, attrs->ia_size);
 		if (rc != 0)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e73edf006df7..27a6e47fe7a9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1609,7 +1609,7 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	in_len = le16_to_cpu(req->SecurityBufferLength);
 	out_blob = (char *)&rsp->hdr.ProtocolId +
 		le16_to_cpu(rsp->SecurityBufferOffset);
-	out_len = work->response_sz -
+	out_len = work->response_sz - work->next_smb2_rsp_hdr_off -
 		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 14dddee4f8fa..dd3923fdcb20 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1330,6 +1330,28 @@ xfs_attr3_leaf_create(
 	return 0;
 }
 
+/*
+ * Reinitialize an existing attr fork block as an empty leaf, and attach
+ * the buffer to tp.
+ */
+int
+xfs_attr3_leaf_init(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	xfs_dablk_t		blkno)
+{
+	struct xfs_buf		*bp = NULL;
+	struct xfs_da_args	args = {
+		.trans		= tp,
+		.dp		= dp,
+		.owner		= dp->i_ino,
+		.geo		= dp->i_mount->m_attr_geo,
+	};
+
+	ASSERT(tp != NULL);
+
+	return xfs_attr3_leaf_create(&args, blkno, &bp);
+}
 /*
  * Split the leaf node, rebalance, then add the new entry.
  *
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
index 589f810eedc0..deb62b544ac5 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -86,6 +86,9 @@ int	xfs_attr3_leaf_list_int(struct xfs_buf *bp,
 /*
  * Routines used for shrinking the Btree.
  */
+
+int	xfs_attr3_leaf_init(struct xfs_trans *tp, struct xfs_inode *dp,
+				xfs_dablk_t blkno);
 int	xfs_attr3_leaf_toosmall(struct xfs_da_state *state, int *retval);
 void	xfs_attr3_leaf_unbalance(struct xfs_da_state *state,
 				       struct xfs_da_state_blk *drop_blk,
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 90fbdef23def..ca5f99c0878f 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1506,21 +1506,20 @@ xfs_da3_fixhashpath(
 }
 
 /*
- * Remove an entry from an intermediate node.
+ * Internal implementation to remove an entry from an intermediate node.
  */
 STATIC void
-xfs_da3_node_remove(
-	struct xfs_da_state	*state,
-	struct xfs_da_state_blk	*drop_blk)
+__xfs_da3_node_remove(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	struct xfs_da_geometry  *geo,
+	struct xfs_da_state_blk *drop_blk)
 {
 	struct xfs_da_intnode	*node;
 	struct xfs_da3_icnode_hdr nodehdr;
 	struct xfs_da_node_entry *btree;
 	int			index;
 	int			tmp;
-	struct xfs_inode	*dp = state->args->dp;
-
-	trace_xfs_da_node_remove(state->args);
 
 	node = drop_blk->bp->b_addr;
 	xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr, node);
@@ -1536,17 +1535,17 @@ xfs_da3_node_remove(
 		tmp  = nodehdr.count - index - 1;
 		tmp *= (uint)sizeof(xfs_da_node_entry_t);
 		memmove(&btree[index], &btree[index + 1], tmp);
-		xfs_trans_log_buf(state->args->trans, drop_blk->bp,
+		xfs_trans_log_buf(tp, drop_blk->bp,
 		    XFS_DA_LOGRANGE(node, &btree[index], tmp));
 		index = nodehdr.count - 1;
 	}
 	memset(&btree[index], 0, sizeof(xfs_da_node_entry_t));
-	xfs_trans_log_buf(state->args->trans, drop_blk->bp,
+	xfs_trans_log_buf(tp, drop_blk->bp,
 	    XFS_DA_LOGRANGE(node, &btree[index], sizeof(btree[index])));
 	nodehdr.count -= 1;
 	xfs_da3_node_hdr_to_disk(dp->i_mount, node, &nodehdr);
-	xfs_trans_log_buf(state->args->trans, drop_blk->bp,
-	    XFS_DA_LOGRANGE(node, &node->hdr, state->args->geo->node_hdr_size));
+	xfs_trans_log_buf(tp, drop_blk->bp,
+	    XFS_DA_LOGRANGE(node, &node->hdr, geo->node_hdr_size));
 
 	/*
 	 * Copy the last hash value from the block to propagate upwards.
@@ -1554,6 +1553,38 @@ xfs_da3_node_remove(
 	drop_blk->hashval = be32_to_cpu(btree[index - 1].hashval);
 }
 
+/*
+ * Remove an entry from an intermediate node.
+ */
+STATIC void
+xfs_da3_node_remove(
+	struct xfs_da_state	*state,
+	struct xfs_da_state_blk	*drop_blk)
+{
+	trace_xfs_da_node_remove(state->args);
+
+	__xfs_da3_node_remove(state->args->trans, state->args->dp,
+			state->args->geo, drop_blk);
+}
+
+/*
+ * Remove an entry from an intermediate attr node at the specified index.
+ */
+void
+xfs_attr3_node_entry_remove(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*dp,
+	struct xfs_buf		*bp,
+	int			index)
+{
+	struct xfs_da_state_blk blk = {
+		.index		= index,
+		.bp		= bp,
+	};
+
+	__xfs_da3_node_remove(tp, dp, dp->i_mount->m_attr_geo, &blk);
+}
+
 /*
  * Unbalance the elements between two intermediate nodes,
  * move all Btree elements from one node into another.
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index cd2e213f5e74..a718b1ceb0aa 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -184,6 +184,8 @@ int	xfs_da3_split(xfs_da_state_t *state);
 int	xfs_da3_join(xfs_da_state_t *state);
 void	xfs_da3_fixhashpath(struct xfs_da_state *state,
 			    struct xfs_da_state_path *path_to_to_fix);
+void	xfs_attr3_node_entry_remove(struct xfs_trans *tp, struct xfs_inode *dp,
+			    struct xfs_buf *bp, int index);
 
 /*
  * Routines used for finding things in the Btree.
diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index 319004bf089f..2305ddad8a13 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -140,7 +140,7 @@ xfs_attr3_node_inactive(
 	xfs_daddr_t		parent_blkno, child_blkno;
 	struct xfs_buf		*child_bp;
 	struct xfs_da3_icnode_hdr ichdr;
-	int			error, i;
+	int			error;
 
 	/*
 	 * Since this code is recursive (gasp!) we must protect ourselves.
@@ -152,7 +152,7 @@ xfs_attr3_node_inactive(
 		return -EFSCORRUPTED;
 	}
 
-	xfs_da3_node_hdr_from_disk(dp->i_mount, &ichdr, bp->b_addr);
+	xfs_da3_node_hdr_from_disk(mp, &ichdr, bp->b_addr);
 	parent_blkno = xfs_buf_daddr(bp);
 	if (!ichdr.count) {
 		xfs_trans_brelse(*trans, bp);
@@ -167,7 +167,7 @@ xfs_attr3_node_inactive(
 	 * over the leaves removing all of them.  If this is higher up
 	 * in the tree, recurse downward.
 	 */
-	for (i = 0; i < ichdr.count; i++) {
+	while (ichdr.count > 0) {
 		/*
 		 * Read the subsidiary block to see what we have to work with.
 		 * Don't do this in a transaction.  This is a depth-first
@@ -218,29 +218,32 @@ xfs_attr3_node_inactive(
 		xfs_trans_binval(*trans, child_bp);
 		child_bp = NULL;
 
+		error = xfs_da3_node_read_mapped(*trans, dp,
+				parent_blkno, &bp, XFS_ATTR_FORK);
+		if (error)
+			return error;
+
 		/*
-		 * If we're not done, re-read the parent to get the next
-		 * child block number.
+		 * Remove entry from parent node, prevents being indexed to.
 		 */
-		if (i + 1 < ichdr.count) {
-			struct xfs_da3_icnode_hdr phdr;
+		xfs_attr3_node_entry_remove(*trans, dp, bp, 0);
+
+		xfs_da3_node_hdr_from_disk(mp, &ichdr, bp->b_addr);
+		bp = NULL;
 
-			error = xfs_da3_node_read_mapped(*trans, dp,
-					parent_blkno, &bp, XFS_ATTR_FORK);
+		if (ichdr.count > 0) {
+			/*
+			 * If we're not done, get the next child block number.
+			 */
+			child_fsb = be32_to_cpu(ichdr.btree[0].before);
+
+			/*
+			 * Atomically commit the whole invalidate stuff.
+			 */
+			error = xfs_trans_roll_inode(trans, dp);
 			if (error)
 				return error;
-			xfs_da3_node_hdr_from_disk(dp->i_mount, &phdr,
-						  bp->b_addr);
-			child_fsb = be32_to_cpu(phdr.btree[i + 1].before);
-			xfs_trans_brelse(*trans, bp);
-			bp = NULL;
 		}
-		/*
-		 * Atomically commit the whole invalidate stuff.
-		 */
-		error = xfs_trans_roll_inode(trans, dp);
-		if (error)
-			return  error;
 	}
 
 	return 0;
@@ -257,10 +260,8 @@ xfs_attr3_root_inactive(
 	struct xfs_trans	**trans,
 	struct xfs_inode	*dp)
 {
-	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_da_blkinfo	*info;
 	struct xfs_buf		*bp;
-	xfs_daddr_t		blkno;
 	int			error;
 
 	/*
@@ -272,7 +273,6 @@ xfs_attr3_root_inactive(
 	error = xfs_da3_node_read(*trans, dp, 0, &bp, XFS_ATTR_FORK);
 	if (error)
 		return error;
-	blkno = xfs_buf_daddr(bp);
 
 	/*
 	 * Invalidate the tree, even if the "tree" is only a single leaf block.
@@ -283,10 +283,26 @@ xfs_attr3_root_inactive(
 	case cpu_to_be16(XFS_DA_NODE_MAGIC):
 	case cpu_to_be16(XFS_DA3_NODE_MAGIC):
 		error = xfs_attr3_node_inactive(trans, dp, bp, 1);
+		/*
+		 * Empty root node block are not allowed, convert it to leaf.
+		 */
+		if (!error)
+			error = xfs_attr3_leaf_init(*trans, dp, 0);
+		if (!error)
+			error = xfs_trans_roll_inode(trans, dp);
 		break;
 	case cpu_to_be16(XFS_ATTR_LEAF_MAGIC):
 	case cpu_to_be16(XFS_ATTR3_LEAF_MAGIC):
 		error = xfs_attr3_leaf_inactive(trans, dp, bp);
+		/*
+		 * Reinit the leaf before truncating extents so that a crash
+		 * mid-truncation leaves an empty leaf rather than one with
+		 * entries that may reference freed remote value blocks.
+		 */
+		if (!error)
+			error = xfs_attr3_leaf_init(*trans, dp, 0);
+		if (!error)
+			error = xfs_trans_roll_inode(trans, dp);
 		break;
 	default:
 		xfs_dirattr_mark_sick(dp, XFS_ATTR_FORK);
@@ -295,21 +311,6 @@ xfs_attr3_root_inactive(
 		xfs_trans_brelse(*trans, bp);
 		break;
 	}
-	if (error)
-		return error;
-
-	/*
-	 * Invalidate the incore copy of the root block.
-	 */
-	error = xfs_trans_get_buf(*trans, mp->m_ddev_targp, blkno,
-			XFS_FSB_TO_BB(mp, mp->m_attr_geo->fsbcount), 0, &bp);
-	if (error)
-		return error;
-	xfs_trans_binval(*trans, bp);	/* remove from cache */
-	/*
-	 * Commit the invalidate and start the next transaction.
-	 */
-	error = xfs_trans_roll_inode(trans, dp);
 
 	return error;
 }
@@ -328,6 +329,7 @@ xfs_attr_inactive(
 {
 	struct xfs_trans	*trans;
 	struct xfs_mount	*mp;
+	struct xfs_buf          *bp;
 	int			lock_mode = XFS_ILOCK_SHARED;
 	int			error = 0;
 
@@ -363,10 +365,27 @@ xfs_attr_inactive(
 	 * removal below.
 	 */
 	if (dp->i_af.if_nextents > 0) {
+		/*
+		 * Invalidate and truncate all blocks but leave the root block.
+		 */
 		error = xfs_attr3_root_inactive(&trans, dp);
 		if (error)
 			goto out_cancel;
 
+		error = xfs_itruncate_extents(&trans, dp, XFS_ATTR_FORK,
+				XFS_FSB_TO_B(mp, mp->m_attr_geo->fsbcount));
+		if (error)
+			goto out_cancel;
+
+		/*
+		 * Invalidate and truncate the root block and ensure that the
+		 * operation is completed within a single transaction.
+		 */
+		error = xfs_da_get_buf(trans, dp, 0, &bp, XFS_ATTR_FORK);
+		if (error)
+			goto out_cancel;
+
+		xfs_trans_binval(trans, bp);
 		error = xfs_itruncate_extents(&trans, dp, XFS_ATTR_FORK, 0);
 		if (error)
 			goto out_cancel;
diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb4dd13984d3..656a314ad215 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -785,6 +785,7 @@ struct damon_ctx {
 	struct mutex call_controls_lock;
 
 	struct damos_walk_control *walk_control;
+	bool walk_control_obsolete;
 	struct mutex walk_control_lock;
 
 	/*
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..d613a7b4dd35 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MODULE_COMPRESSED, kernel-module-compressed) \
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 4ee7e4680a6e..718351acd023 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -561,20 +561,6 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
 	return !!psock->saved_data_ready;
 }
 
-/* for tcp only, sk is locked */
-static inline ssize_t sk_psock_msg_inq(struct sock *sk)
-{
-	struct sk_psock *psock;
-	ssize_t inq = 0;
-
-	psock = sk_psock_get(sk);
-	if (likely(psock)) {
-		inq = sk_psock_get_msg_len_nolock(psock);
-		sk_psock_put(sk, psock);
-	}
-	return inq;
-}
-
 /* for udp only, sk is not locked */
 static inline ssize_t sk_msg_first_len(struct sock *sk)
 {
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 7e40d3c5f5a9..e8e82869b281 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -210,6 +210,7 @@ struct rfcomm_dlc {
 #define RFCOMM_AUTH_REJECT  7
 #define RFCOMM_DEFER_SETUP  8
 #define RFCOMM_ENC_DROP     9
+#define RFCOMM_CLOSED       10
 
 /* Scheduling flags and events */
 #define RFCOMM_SCHED_WAKEUP 31
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a134b1235279..f03438a4b1db 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -325,7 +325,9 @@ struct mana_recv_buf_oob {
 #define MANA_RXBUF_PAD (SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) \
 			+ ETH_HLEN)
 
-#define MANA_XDP_MTU_MAX (PAGE_SIZE - MANA_RXBUF_PAD - XDP_PACKET_HEADROOM)
+#define MANA_XDP_MTU_MAX(ndev) \
+	(PAGE_SIZE - MANA_RXBUF_PAD - \
+	 max_t(u32, LL_RESERVED_SPACE(ndev), XDP_PACKET_HEADROOM))
 
 struct mana_rxq {
 	struct gdma_queue *gdma_rq;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 524669ee1998..ad5e203e0d5f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2832,8 +2832,9 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
-	io_free_region(ctx, &ctx->sq_region);
-	io_free_region(ctx, &ctx->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &ctx->sq_region);
+	io_free_region(NULL, &ctx->ring_region);
 	ctx->rings = NULL;
 	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	ctx->sq_sqes = NULL;
@@ -2915,7 +2916,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_eventfd_unregister(ctx);
 	io_free_alloc_caches(ctx);
 	io_destroy_buffers(ctx);
-	io_free_region(ctx, &ctx->param_region);
+	io_free_region(ctx->user, &ctx->param_region);
 	mutex_unlock(&ctx->uring_lock);
 	if (ctx->sq_creds)
 		put_cred(ctx->sq_creds);
@@ -3688,7 +3689,8 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	ret = io_create_region(NULL, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
@@ -3711,7 +3713,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &ctx->sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_rings_free(ctx);
 		return ret;
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index c260d5f34cf3..9b9f0d369847 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -444,7 +444,7 @@ static int io_remove_buffers_legacy(struct io_ring_ctx *ctx,
 static void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
 {
 	if (bl->flags & IOBL_BUF_RING)
-		io_free_region(ctx, &bl->region);
+		io_free_region(NULL, &bl->region);
 	else
 		io_remove_buffers_legacy(ctx, bl, -1U);
 
@@ -661,7 +661,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = reg.ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region_mmap_safe(ctx, &bl->region, &rd, mmap_offset);
+	ret = io_create_region_mmap_safe(ctx, NULL, &bl->region, &rd, mmap_offset);
 	if (ret)
 		goto fail;
 	br = io_region_get_ptr(&bl->region);
@@ -695,7 +695,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (!ret)
 		return 0;
 fail:
-	io_free_region(ctx, &bl->region);
+	io_free_region(NULL, &bl->region);
 	kfree(bl);
 	return ret;
 }
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index add03ca75cb9..3855452f48e2 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -88,7 +88,7 @@ enum {
 	IO_REGION_F_SINGLE_REF			= 4,
 };
 
-void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr)
+void io_free_region(struct user_struct *user, struct io_mapped_region *mr)
 {
 	if (mr->pages) {
 		long nr_refs = mr->nr_pages;
@@ -105,8 +105,8 @@ void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr)
 	}
 	if ((mr->flags & IO_REGION_F_VMAP) && mr->ptr)
 		vunmap(mr->ptr);
-	if (mr->nr_pages && ctx->user)
-		__io_unaccount_mem(ctx->user, mr->nr_pages);
+	if (mr->nr_pages && user)
+		__io_unaccount_mem(user, mr->nr_pages);
 
 	memset(mr, 0, sizeof(*mr));
 }
@@ -131,8 +131,7 @@ static int io_region_init_ptr(struct io_mapped_region *mr)
 	return 0;
 }
 
-static int io_region_pin_pages(struct io_ring_ctx *ctx,
-				struct io_mapped_region *mr,
+static int io_region_pin_pages(struct io_mapped_region *mr,
 				struct io_uring_region_desc *reg)
 {
 	unsigned long size = (size_t) mr->nr_pages << PAGE_SHIFT;
@@ -150,8 +149,7 @@ static int io_region_pin_pages(struct io_ring_ctx *ctx,
 	return 0;
 }
 
-static int io_region_allocate_pages(struct io_ring_ctx *ctx,
-				    struct io_mapped_region *mr,
+static int io_region_allocate_pages(struct io_mapped_region *mr,
 				    struct io_uring_region_desc *reg,
 				    unsigned long mmap_offset)
 {
@@ -185,7 +183,7 @@ static int io_region_allocate_pages(struct io_ring_ctx *ctx,
 	return 0;
 }
 
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset)
 {
@@ -211,17 +209,17 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		return -EOVERFLOW;
 
 	nr_pages = reg->size >> PAGE_SHIFT;
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
 		if (ret)
 			return ret;
 	}
 	mr->nr_pages = nr_pages;
 
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
-		ret = io_region_pin_pages(ctx, mr, reg);
+		ret = io_region_pin_pages(mr, reg);
 	else
-		ret = io_region_allocate_pages(ctx, mr, reg, mmap_offset);
+		ret = io_region_allocate_pages(mr, reg, mmap_offset);
 	if (ret)
 		goto out_free;
 
@@ -230,11 +228,12 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		goto out_free;
 	return 0;
 out_free:
-	io_free_region(ctx, mr);
+	io_free_region(user, mr);
 	return ret;
 }
 
-int io_create_region_mmap_safe(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region_mmap_safe(struct io_ring_ctx *ctx, struct user_struct *user,
+				struct io_mapped_region *mr,
 				struct io_uring_region_desc *reg,
 				unsigned long mmap_offset)
 {
@@ -242,7 +241,7 @@ int io_create_region_mmap_safe(struct io_ring_ctx *ctx, struct io_mapped_region
 	int ret;
 
 	memcpy(&tmp_mr, mr, sizeof(tmp_mr));
-	ret = io_create_region(ctx, &tmp_mr, reg, mmap_offset);
+	ret = io_create_region(user, &tmp_mr, reg, mmap_offset);
 	if (ret)
 		return ret;
 
diff --git a/io_uring/memmap.h b/io_uring/memmap.h
index 08419684e4bc..8128be8e5ebc 100644
--- a/io_uring/memmap.h
+++ b/io_uring/memmap.h
@@ -16,12 +16,12 @@ unsigned long io_uring_get_unmapped_area(struct file *file, unsigned long addr,
 					 unsigned long flags);
 int io_uring_mmap(struct file *file, struct vm_area_struct *vma);
 
-void io_free_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr);
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+void io_free_region(struct user_struct *user, struct io_mapped_region *mr);
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset);
 
-int io_create_region_mmap_safe(struct io_ring_ctx *ctx,
+int io_create_region_mmap_safe(struct io_ring_ctx *ctx, struct user_struct *user,
 				struct io_mapped_region *mr,
 				struct io_uring_region_desc *reg,
 				unsigned long mmap_offset);
diff --git a/io_uring/register.c b/io_uring/register.c
index 6c4ef485212d..741cd294773e 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -383,8 +383,9 @@ static void io_register_free_rings(struct io_ring_ctx *ctx,
 				   struct io_uring_params *p,
 				   struct io_ring_ctx_rings *r)
 {
-	io_free_region(ctx, &r->sq_region);
-	io_free_region(ctx, &r->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &r->sq_region);
+	io_free_region(NULL, &r->ring_region);
 }
 
 #define swap_old(ctx, o, n, field)		\
@@ -433,7 +434,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p.cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region_mmap_safe(ctx, &n.ring_region, &rd, IORING_OFF_CQ_RING);
+	ret = io_create_region_mmap_safe(ctx, NULL, &n.ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret) {
 		io_register_free_rings(ctx, &p, &n);
 		return ret;
@@ -473,7 +474,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p.sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region_mmap_safe(ctx, &n.sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region_mmap_safe(ctx, NULL, &n.sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_register_free_rings(ctx, &p, &n);
 		return ret;
@@ -633,13 +634,13 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	    !(ctx->flags & IORING_SETUP_R_DISABLED))
 		return -EINVAL;
 
-	ret = io_create_region_mmap_safe(ctx, &ctx->param_region, &rd,
-					 IORING_MAP_OFF_PARAM_REGION);
+	ret = io_create_region_mmap_safe(ctx, ctx->user, &ctx->param_region,
+					 &rd, IORING_MAP_OFF_PARAM_REGION);
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
 		guard(mutex)(&ctx->mmap_lock);
-		io_free_region(ctx, &ctx->param_region);
+		io_free_region(ctx->user, &ctx->param_region);
 		return -EFAULT;
 	}
 
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 56a6a0e52e51..b44d8ba53e59 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -371,7 +371,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
 
-	ret = io_create_region(ifq->ctx, &ifq->region, rd, mmap_offset);
+	ret = io_create_region(ifq->ctx->user, &ifq->region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
@@ -387,7 +387,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 
 static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 {
-	io_free_region(ifq->ctx, &ifq->region);
+	io_free_region(ifq->ctx->user, &ifq->region);
 	ifq->rq_ring = NULL;
 	ifq->rqes = NULL;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ac9fa7727b5f..9fe5d14f1ec5 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -365,7 +365,7 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 		struct khoser_mem_chunk *tmp = chunk;
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 769463d2b254..fc5b17befb0b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3692,24 +3692,35 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
 {
+	bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
 	struct load_info info = { };
 	void *buf = NULL;
 	int len;
+	int err;
 
-	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
+	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
+			       compressed ? READING_MODULE_COMPRESSED :
+					    READING_MODULE);
 	if (len < 0) {
 		mod_stat_inc(&failed_kreads);
 		return len;
 	}
 
-	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+	if (compressed) {
+		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
 			return err;
 		}
+		err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+						     READING_MODULE);
+		if (err) {
+			mod_stat_inc(&failed_kreads);
+			free_copy(&info, flags);
+			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 189a4e0658eb..55072a105cd6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1369,8 +1369,8 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() depends on tasks being
-	 * appended to the runnable_list.
+	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 }
@@ -2147,8 +2147,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (consume_global_dsq(sch, rq))
 		goto has_tasks;
 
+	/*
+	 * scx_rq_online() can't be used. Its cpu_active() test goes false
+	 * before CPU hotplug waits for an RCU grace period, and
+	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * the wait. The grace period can depend on those tasks running.
+	 */
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
-	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
+	    scx_rq_bypassing(rq) || !(rq->scx.flags & SCX_RQ_ONLINE))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -2677,7 +2683,24 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
+	struct task_struct *p, *n;
+
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
+
+	/* sched domain rebuilds call rq_offline with the CPU staying alive */
+	if (cpu_active(cpu_of(rq)))
+		return;
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+	}
 }
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4e58174d3d0b..0f29def72877 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3905,8 +3905,9 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * after which it is enqueued again.
  *
  * Typically this must be called while holding task_rq_lock, since most/all
- * properties are serialized under those locks. There is currently one
- * exception to this rule in sched/ext which only holds rq->lock.
+ * properties are serialized under those locks. There are currently two
+ * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
+ * and rq_offline_scx().
  */
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 016d38c127d6..4e6e3d7d0a5c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1568,6 +1568,10 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
  * passed at least one &damos->apply_interval_us, kdamond marks the request as
  * completed so that damos_walk() can wakeup and return.
  *
+ * Note that this function should be called only after damon_start() with the
+ * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
+ * wait.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
@@ -1575,19 +1579,16 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	init_completion(&control->completion);
 	control->canceled = false;
 	mutex_lock(&ctx->walk_control_lock);
+	if (ctx->walk_control_obsolete) {
+		mutex_unlock(&ctx->walk_control_lock);
+		return -ECANCELED;
+	}
 	if (ctx->walk_control) {
 		mutex_unlock(&ctx->walk_control_lock);
 		return -EBUSY;
 	}
 	ctx->walk_control = control;
 	mutex_unlock(&ctx->walk_control_lock);
-	if (!damon_is_running(ctx)) {
-		mutex_lock(&ctx->walk_control_lock);
-		if (ctx->walk_control == control)
-			ctx->walk_control = NULL;
-		mutex_unlock(&ctx->walk_control_lock);
-		return -EINVAL;
-	}
 	wait_for_completion(&control->completion);
 	if (control->canceled)
 		return -ECANCELED;
@@ -2725,6 +2726,9 @@ static int kdamond_fn(void *data)
 	mutex_lock(&ctx->call_controls_lock);
 	ctx->call_controls_obsolete = false;
 	mutex_unlock(&ctx->call_controls_lock);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control_obsolete = false;
+	mutex_unlock(&ctx->walk_control_lock);
 	complete(&ctx->kdamond_started);
 	kdamond_init_ctx(ctx);
 
@@ -2838,14 +2842,16 @@ static int kdamond_fn(void *data)
 	ctx->call_controls_obsolete = true;
 	mutex_unlock(&ctx->call_controls_lock);
 	kdamond_call(ctx, true);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control_obsolete = true;
+	mutex_unlock(&ctx->walk_control_lock);
+	damos_walk_cancel(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
 
-	damos_walk_cancel(ctx);
-
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
 	if (!nr_running_ctxs && running_exclusive_ctxs)
diff --git a/mm/mremap.c b/mm/mremap.c
index e60a63a36ea0..f0e63d3b3c14 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1025,8 +1025,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 }
 
 /*
- * Perform checks before attempting to write a VMA prior to it being
- * moved.
+ * Perform checks and preparation before attempting to write a VMA prior to it
+ * being moved.
  */
 static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
@@ -1035,18 +1035,17 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
 	vm_flags_t dummy = vma->vm_flags;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
-	/*
-	 * We'd prefer to avoid failure later on in do_munmap:
-	 * which may split one vma into three before unmapping.
-	 */
+	/* Avoid failure later on. */
 	if (current->mm->map_count >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
-		if (vma->vm_start != old_addr)
+		if (split_before)
 			err = vma->vm_ops->may_split(vma, old_addr);
-		if (!err && vma->vm_end != old_addr + old_len)
+		if (!err && split_after)
 			err = vma->vm_ops->may_split(vma, old_addr + old_len);
 		if (err)
 			return err;
@@ -1064,6 +1063,22 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+	    (vma->vm_flags & VM_LOCKED)) {
+		VMA_ITERATOR(vmi, vma->vm_mm, old_addr);
+
+		if (split_before)
+			err = split_vma(&vmi, vma, old_addr, 1);
+		if (!err && split_after)
+			err = split_vma(&vmi, vma, old_addr + old_len, 0);
+		vrm->vmi_needs_invalidate = true;
+		return err;
+	}
+
 	return 0;
 }
 
@@ -1191,7 +1206,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &pmc.need_rmap_locks);
+			   &pmc.need_rmap_locks, vrm->flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
@@ -1251,6 +1266,9 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	unsigned long old_start = vma->vm_start;
 	unsigned long old_end = vma->vm_end;
 
+	/* Self-merge is disallowed. */
+	VM_WARN_ON_ONCE(new_vma == vma);
+
 	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
 	vm_flags_clear(vma, VM_LOCKED_MASK);
 
@@ -1258,7 +1276,7 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	if (new_vma != vma && start == old_start && end == old_end) {
+	if (start == old_start && end == old_end) {
 		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
 
 		unlink_anon_vmas(vma);
diff --git a/mm/vma.c b/mm/vma.c
index d1158fdcde28..d1627a8ef32b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -584,8 +584,8 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
@@ -1852,7 +1852,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -1885,6 +1885,21 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
+
+	/*
+	 * If the original VMA is kept (MREMAP_DONTUNMAP), the source and
+	 * destination VMA must be treated distinctly.
+	 *
+	 * A merge violates this, so in this case disallow a self-merge.
+	 */
+	if (!faulted_in_anon_vma && keep_source) {
+		if (vmg.prev == vma)
+			vmg.prev = NULL;
+		if (vmg.next == vma)
+			vmg.next = NULL;
+		faulted_in_anon_vma = true;
+	}
+
 	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
diff --git a/mm/vma.h b/mm/vma.h
index 4c7ea8b893ab..ab6e5ff4633f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -389,7 +389,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
 
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
 
@@ -409,6 +409,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
+#ifdef CONFIG_MMU
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below);
+#endif
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d45ea1807f8b..59fb93be9c20 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -65,10 +65,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err);
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err);
+static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
@@ -368,28 +367,17 @@ static int rfcomm_check_channel(u8 channel)
 	return channel < 1 || channel > 30;
 }
 
-static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
+static int __rfcomm_dlc_open(struct rfcomm_dlc *d, struct rfcomm_session *s,
+			     u8 channel)
 {
-	struct rfcomm_session *s;
-	int err = 0;
 	u8 dlci;
 
-	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
-	       d, d->state, src, dst, channel);
-
-	if (rfcomm_check_channel(channel))
-		return -EINVAL;
+	BT_DBG("dlc %p state %ld session %p channel %d",
+	       d, d->state, s, channel);
 
 	if (d->state != BT_OPEN && d->state != BT_CLOSED)
 		return 0;
 
-	s = rfcomm_session_get(src, dst);
-	if (!s) {
-		s = rfcomm_session_create(src, dst, d->sec_level, &err);
-		if (!s)
-			return err;
-	}
-
 	dlci = __dlci(__session_dir(s), channel);
 
 	/* Check if DLCI already exists */
@@ -424,14 +412,84 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
 int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
 {
-	int r;
+	struct rfcomm_session *s;
+	struct socket *sock;
+	int err;
+
+	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
+	       d, d->state, src, dst, channel);
+
+	if (rfcomm_check_channel(channel))
+		return -EINVAL;
 
 	rfcomm_lock();
 
-	r = __rfcomm_dlc_open(d, src, dst, channel);
+	clear_bit(RFCOMM_CLOSED, &d->flags);
 
+	/* Do not page the remote device for a DLC that cannot be opened
+	 * anyway.  __rfcomm_dlc_open() looks at the state again once the
+	 * lock has been re-acquired below.
+	 */
+	if (d->state != BT_OPEN && d->state != BT_CLOSED) {
+		rfcomm_unlock();
+		return 0;
+	}
+
+	s = rfcomm_session_get(src, dst);
+	if (s) {
+		err = __rfcomm_dlc_open(d, s, channel);
+		rfcomm_unlock();
+		return err;
+	}
 	rfcomm_unlock();
-	return r;
+
+	/* There is no session for this pair yet.  kernel_connect() ends up in
+	 * l2cap_chan_connect(), which takes hdev->lock, and the HCI event
+	 * path takes rfcomm_mutex while holding hdev->lock, so the socket has
+	 * to be connected with rfcomm_mutex released.
+	 */
+	sock = rfcomm_session_connect(src, dst, d->sec_level, &err);
+	if (!sock)
+		return err;
+
+	rfcomm_lock();
+
+	/* The DLC may have been closed while the socket was connecting.  It
+	 * was not on a session, so rfcomm_dlc_close() could only mark it;
+	 * attaching it now would leave it with no owner.
+	 */
+	if (test_bit(RFCOMM_CLOSED, &d->flags)) {
+		rfcomm_unlock();
+		sock_release(sock);
+		return -ECONNRESET;
+	}
+
+	/* Another opener may have added a session for the same pair in the
+	 * meantime; that one is used and this socket is dropped.
+	 */
+	s = rfcomm_session_get(src, dst);
+	if (!s) {
+		s = rfcomm_session_add(sock, BT_BOUND);
+		if (s) {
+			s->initiator = 1;
+			sock = NULL;
+		}
+	}
+
+	err = s ? __rfcomm_dlc_open(d, s, channel) : -ENOMEM;
+
+	rfcomm_unlock();
+
+	if (sock)
+		sock_release(sock);
+
+	/* Over an existing ACL link the connection can complete before the
+	 * session reaches the list, and that wakeup is then lost, so let
+	 * krfcommd look at the socket state now.
+	 */
+	rfcomm_schedule();
+
+	return err;
 }
 
 static void __rfcomm_dlc_disconn(struct rfcomm_dlc *d)
@@ -511,8 +569,14 @@ int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	rfcomm_lock();
 
 	s = d->session;
-	if (!s)
+	if (!s) {
+		/* Not on a session yet: rfcomm_dlc_open() may be connecting a
+		 * socket for it with rfcomm_mutex released.  Leave a mark so
+		 * that it does not attach the DLC once it holds the lock again.
+		 */
+		set_bit(RFCOMM_CLOSED, &d->flags);
 		goto no_session;
+	}
 
 	/* after waiting on the mutex check the session still exists
 	 * then check the dlc still exists
@@ -760,12 +824,12 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 	return rfcomm_session_del(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err)
+/* Creates the L2CAP socket a new session will run on and starts connecting
+ * it.  Must be called with rfcomm_mutex released.
+ */
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err)
 {
-	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
 	struct socket *sock;
 	struct sock *sk;
@@ -795,24 +859,16 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
 
-	s = rfcomm_session_add(sock, BT_BOUND);
-	if (!s) {
-		*err = -ENOMEM;
-		goto failed;
-	}
-
-	s->initiator = 1;
-
 	bacpy(&addr.l2_bdaddr, dst);
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
-	if (*err == 0 || *err == -EINPROGRESS)
-		return s;
+	if (*err && *err != -EINPROGRESS)
+		goto failed;
 
-	return rfcomm_session_del(s);
+	return sock;
 
 failed:
 	sock_release(sock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ca51756d8aa4..6027cd33a9fd 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 {
+	struct sk_psock *psock;
 	bool slow;
 
 	if (cmd != SIOCINQ)
@@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 		return -EINVAL;
 
 	slow = lock_sock_fast(sk);
-	*karg = sk_psock_msg_inq(sk);
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock)) {
+		unlock_sock_fast(sk, slow);
+		return tcp_ioctl(sk, cmd, karg);
+	}
+	*karg = sk_psock_get_msg_len_nolock(psock);
+	/* Without a verdict program, ingress data is never diverted to
+	 * ingress_msg: it stays in sk_receive_queue and is read through
+	 * the fallback to tcp_recvmsg(), so account for it like
+	 * tcp_ioctl() does.
+	 */
+	if (!READ_ONCE(psock->progs.stream_verdict) &&
+	    !READ_ONCE(psock->progs.skb_verdict))
+		*karg += tcp_inq(sk);
+	sk_psock_put(sk, psock);
 	unlock_sock_fast(sk, slow);
 
 	return 0;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ebd0198458cd..e3aedef13cee 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -922,7 +922,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1058,12 +1057,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, flags, proto, 0,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst) {
-		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst6_mtu(dst) > mtu)
-			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
-	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 97893498e611..48b82fe3bee1 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -390,11 +390,25 @@ void rose_destroy_socket(struct sock *sk)
 	rose_clear_queues(sk);		/* Flush the queues */
 
 	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		if (skb->sk != sk) {	/* A pending connection */
-			/* Queue the unaccepted socket for death */
-			sock_set_flag(skb->sk, SOCK_DEAD);
-			rose_start_heartbeat(skb->sk);
-			rose_sk(skb->sk)->state = ROSE_STATE_0;
+		struct sock *child = skb->sk;
+
+		if (child != sk) {	/* A pending connection */
+			/* Queue the unaccepted socket for death, unless
+			 * rose_heartbeat_expiry() has already reaped it or is
+			 * about to (SOCK_DESTROY).
+			 */
+			local_bh_disable();
+			bh_lock_sock_nested(child);
+			if (!sock_flag(child, SOCK_DESTROY)) {
+				sock_set_flag(child, SOCK_DEAD);
+				rose_start_heartbeat(child);
+				rose_sk(child)->state = ROSE_STATE_0;
+			}
+			bh_unlock_sock(child);
+			local_bh_enable();
+
+			skb->sk = NULL;
+			sock_put(child);	/* the queue's reference */
 		}
 
 		kfree_skb(skb);
@@ -980,6 +994,7 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
 	 *	The write queue this time is holding sockets ready to use
 	 *	hooked into the SABM we saved
 	 */
+again:
 	for (;;) {
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
@@ -1005,12 +1020,27 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
 		goto out_release;
 
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (sock_flag(newsk, SOCK_DESTROY)) {
+		/* The call went away and rose_heartbeat_expiry() reaped (or
+		 * is about to reap) the socket before it was accepted: drop
+		 * it and wait for the next one.
+		 */
+		release_sock(newsk);
+		skb->sk = NULL;
+		kfree_skb(skb);
+		sk_acceptq_removed(sk);
+		sock_put(newsk);	/* the queue's reference */
+		goto again;
+	}
 	sock_graft(newsk, newsock);
+	release_sock(newsk);
 
 	/* Now attach up the new socket */
 	skb->sk = NULL;
 	kfree_skb(skb);
 	sk_acceptq_removed(sk);
+	sock_put(newsk);		/* the queue's reference */
 
 out_release:
 	release_sock(sk);
@@ -1124,6 +1154,10 @@ int rose_rx_call_request(struct sk_buff *skb, struct net_device *dev, struct ros
 
 	rose_insert_socket(make);
 
+	/* The listener's queue holds a reference on the pending socket
+	 * until rose_accept() or rose_destroy_socket() takes it off.
+	 */
+	sock_hold(make);
 	skb_queue_head(&sk->sk_receive_queue, skb);
 
 	rose_start_heartbeat(make);
diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index d967cbc1db3d..4130ddf84850 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -188,6 +188,11 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 				rose_neigh_put(rose->neighbour);
 				rose->neighbour = NULL;
 			}
+			/* Tell rose_accept() and the listener's teardown, which
+			 * may still hold this socket on their queue, that it is
+			 * gone.
+			 */
+			sock_set_flag(sk, SOCK_DESTROY);
 			bh_unlock_sock(sk);
 			rose_destroy_socket(sk);
 			sock_put(sk);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..89ebe98ffc5e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -441,7 +441,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     bool bprm_is_check);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -466,7 +467,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   bool bprm_is_check)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a87ef7c05f11..a3bdb7a0ab12 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -480,17 +480,6 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
-static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
-{
-	struct linux_binprm *bprm;
-
-	if (func == BPRM_CHECK) {
-		bprm = container_of(&file, struct linux_binprm, file);
-		return bprm->is_check;
-	}
-	return false;
-}
-
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -502,7 +491,8 @@ static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     bool bprm_is_check)
 {
 	static const char op[] = "appraise_data";
 	int audit_msgno = AUDIT_INTEGRITY_DATA;
@@ -524,7 +514,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * of the script interpreter(userspace). Differentiate kernel and
 	 * userspace enforced integrity audit messages.
 	 */
-	if (is_bprm_creds_for_exec(func, file))
+	if (bprm_is_check)
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
 	/* If reading the xattr failed and there's no modsig, error out. */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e51b53b7789b..d2a31b655822 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,9 @@ static void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
-			       int mask, enum ima_hooks func)
+			       int mask, enum ima_hooks func,
+			       enum kernel_read_file_id read_id,
+			       bool bprm_is_check)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -406,6 +408,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
+	/* Defer measuring/appraising kernel modules to READING_MODULE */
+	if (read_id == READING_MODULE_COMPRESSED) {
+		must_appraise = 0;
+		goto out_locked;
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
@@ -419,7 +427,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      bprm_is_check);
 			inode_unlock(inode);
 		}
 		if (!rc)
@@ -486,14 +495,15 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0,
+					  false);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, 0, false);
 
 	return 0;
 }
@@ -577,7 +587,8 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0,
+				   bprm->is_check);
 }
 
 /**
@@ -607,7 +618,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK);
+				   0, MAY_EXEC, CREDS_CHECK, 0, false);
 }
 
 /**
@@ -655,7 +666,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, 0, false);
 }
 
 /*
@@ -911,12 +922,13 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func);
+				   MAY_READ, func, 0, false);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
+	[READING_MODULE_COMPRESSED] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
 	[READING_POLICY] = POLICY_CHECK
@@ -954,7 +966,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, read_id, false);
 }
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index db6d55af5a80..d63af617d458 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -241,7 +241,8 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+		  IMA_CHECK_BLACKLIST},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d3092933abe2..7cbb1df0a76b 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -119,6 +119,7 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 		op = IPE_OP_FIRMWARE;
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		op = IPE_OP_KERNEL_MODULE;
 		break;
 	case READING_KEXEC_INITRAMFS:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 86c82a6df54c..03ecfc6de2c3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4514,7 +4514,7 @@ static int selinux_kernel_read_file(struct file *file,
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
 			 "New kernel_read_file_id introduced; update SELinux!");
 
 	switch (id) {
@@ -4522,6 +4522,7 @@ static int selinux_kernel_read_file(struct file *file,
 		rc = selinux_kernel_load_from_file(file, SYSTEM__FIRMWARE_LOAD);
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		rc = selinux_kernel_load_from_file(file, SYSTEM__MODULE_LOAD);
 		break;
 	case READING_KEXEC_IMAGE:
@@ -4550,7 +4551,7 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
 			 "New kernel_load_data_id introduced; update SELinux!");
 
 	switch (id) {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e82151920597..9ad11246ad1f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -74,7 +74,6 @@ struct selinux_fs_info {
 	int *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
-	bool policy_opened;
 	struct dentry *policycap_dir;
 	unsigned long last_ino;
 	struct super_block *sb;
@@ -340,44 +339,31 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
-	BUG_ON(filp->private_data);
-
-	mutex_lock(&selinux_state.policy_mutex);
-
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
-		goto err;
-
-	rc = -EBUSY;
-	if (fsi->policy_opened)
-		goto err;
+		return rc;
 
-	rc = -ENOMEM;
 	plm = kzalloc(sizeof(*plm), GFP_KERNEL);
 	if (!plm)
-		goto err;
+		return -ENOMEM;
 
+	mutex_lock(&selinux_state.policy_mutex);
 	rc = security_read_policy(&plm->data, &plm->len);
 	if (rc)
 		goto err;
-
 	if ((size_t)i_size_read(inode) != plm->len) {
 		inode_lock(inode);
 		i_size_write(inode, plm->len);
 		inode_unlock(inode);
 	}
-
-	fsi->policy_opened = 1;
+	mutex_unlock(&selinux_state.policy_mutex);
 
 	filp->private_data = plm;
 
-	mutex_unlock(&selinux_state.policy_mutex);
-
 	return 0;
 err:
 	mutex_unlock(&selinux_state.policy_mutex);
@@ -390,13 +376,8 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 static int sel_release_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
-	BUG_ON(!plm);
-
-	fsi->policy_opened = 0;
-
 	vfree(plm->data);
 	kfree(plm);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index fd37ce3b2628..db580c5d2151 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1558,7 +1558,7 @@ static bool test_copy_vma(void)
 	/* Move backwards and do not merge. */
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks, false);
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
 	ASSERT_EQ(vma_new->vm_end, 0x2000);
@@ -1571,7 +1571,7 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks, false);
 	vma_assert_attached(vma_new);
 
 	ASSERT_EQ(vma_new, vma_next);

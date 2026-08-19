Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971C47606E;
	Wed, 19 Aug 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158337; cv=none; b=SG9mR3G9601A49HJ7/mGc3VZLq6K6ikOykGJ7rgYNYniqHPU/cFk/1q1Qls3LDEudAtHoFvjeLnSiW78B9GcKc5hzZQT7WSxymcpBQOP81YdnmEkY833RVBF2y77VT1u0PjhPFGzniUFWAO8sGHbWy6bHU1dc+otxaDi5AsC8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158337; c=relaxed/simple;
	bh=IVrP6z8dC7SL2WV8dW3ELhq8p8HY5KY1Iu3NEvS38SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkR68rrV7W/SEU0DbsjKkoAig6PfooPsx1DOHOQDCrzC3jCJSHE2xtPRCTs0Y0EXHxqlLDbJyFl9TpQ2+dsaDQaOJiwCf0aA5PgLK4+sNJT+bmO9WxUNNUSgzdAXuodch1jKCZ22vkRJo8NcPlwHHmtFG3E7RixPmClUXzl0uNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qaduVujm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qaduVujm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D9E1F000E9;
	Wed, 19 Aug 2026 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787158319;
	bh=pwpdGM0o1gaMz3uVsR0TeK6sePygDyctPU5VO/6UUn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qaduVujmnw2+DQYKBK2iRYN7P2GemcJw5j/enK0kr6tk1fm8THo4DOxZ69T0Q/pPB
	 68IR+rEUOZiEhv1qb1DEyIz729e+Sdfv7sJK4Voai3povJTxKibOHNUabrCGbakMwZ
	 RLm9RYF46+tnyXlNTz9khq+gI76MtexQiTghUoMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.265
Date: Wed, 19 Aug 2026 18:51:42 +0200
Message-ID: <2026081942-afternoon-rocker-1729@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026081942-overlay-viewable-d5f2@gregkh>
References: <2026081942-overlay-viewable-d5f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9abb9b26d8e5..1773020dec8d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 264
+SUBLEVEL = 265
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
index 21633c70fe7f..fe63edc9886d 100644
--- a/arch/arm/mach-npcm/platsmp.c
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -35,6 +35,7 @@ static int npcm7xx_smp_boot_secondary(unsigned int cpu,
 		goto out;
 	}
 	gcr_base = of_iomap(gcr_np, 0);
+	of_node_put(gcr_np);
 	if (!gcr_base) {
 		pr_err("could not iomap gcr");
 		ret = -ENOMEM;
@@ -63,6 +64,7 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	scu_base = of_iomap(scu_np, 0);
+	of_node_put(scu_np);
 	if (!scu_base) {
 		pr_err("could not iomap scu");
 		return;
diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 6c590ef27648..5feffc8708ad 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -70,11 +70,16 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+	if (len < cpumask_size())
+		cpumask_clear(new_mask);
+	else if (len > cpumask_size())
+		len = cpumask_size();
+	if (copy_from_user(new_mask, user_mask_ptr, len)) {
+		retval = -EFAULT;
+		goto out_free_new_mask;
+	}
 
 	get_online_cpus();
 	rcu_read_lock();
@@ -83,7 +88,8 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!p) {
 		rcu_read_unlock();
 		put_online_cpus();
-		return -ESRCH;
+		retval = -ESRCH;
+		goto out_free_new_mask;
 	}
 
 	/* Prevent p going away */
@@ -94,13 +100,9 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
 	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
-		goto out_free_new_mask;
+		goto out_free_cpus_allowed;
 	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
@@ -141,13 +143,13 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	}
 out_unlock:
 	free_cpumask_var(effective_mask);
-out_free_new_mask:
-	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
 out_put_task:
 	put_task_struct(p);
 	put_online_cpus();
+out_free_new_mask:
+	free_cpumask_var(new_mask);
 	return retval;
 }
 
diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
index c80691d83880..27591df41e9e 100644
--- a/arch/powerpc/boot/simpleboot.c
+++ b/arch/powerpc/boot/simpleboot.c
@@ -68,7 +68,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	/* finally, setup the timebase */
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 					     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))
diff --git a/arch/powerpc/boot/treeboot-akebono.c b/arch/powerpc/boot/treeboot-akebono.c
index e3cc2599869c..1b529037480f 100644
--- a/arch/powerpc/boot/treeboot-akebono.c
+++ b/arch/powerpc/boot/treeboot-akebono.c
@@ -146,7 +146,7 @@ void platform_init(char *userdata)
 
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 					     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))
diff --git a/arch/powerpc/boot/treeboot-currituck.c b/arch/powerpc/boot/treeboot-currituck.c
index d53e8a592f81..5b5363b74f9f 100644
--- a/arch/powerpc/boot/treeboot-currituck.c
+++ b/arch/powerpc/boot/treeboot-currituck.c
@@ -102,7 +102,7 @@ void platform_init(void)
 
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 	                                     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))
diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index a81eac35d900..fd17c96e2de8 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -614,6 +614,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 
 fail_map:
 	for (iopage--; 0 <= iopage; iopage--) {
+		offset = (1 << r->page_size) * iopage;
 		lv1_put_iopte(0,
 			      c->bus_addr + offset,
 			      c->lpar_addr + offset,
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index a37007e42265..58180bfce962 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1008,6 +1008,9 @@ static int vector_mmsg_rx(struct vector_private *vp)
 				 */
 					dev_kfree_skb_irq(skb);
 					vp->estats.rx_encaps_errors++;
+					(*skbuff_vector) = NULL;
+					mmsg_vector++;
+					skbuff_vector++;
 					continue;
 				}
 				if (header_check > 0) {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13bf3198d0ce..13cad4becfba 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5814,7 +5814,9 @@ static struct shrinker mmu_shrinker = {
 static void mmu_destroy_caches(void)
 {
 	kmem_cache_destroy(pte_list_desc_cache);
+	pte_list_desc_cache = NULL;
 	kmem_cache_destroy(mmu_page_header_cache);
+	mmu_page_header_cache = NULL;
 }
 
 static void kvm_set_mmio_spte_mask(void)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c165ddbb672f..801938b25582 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -279,6 +279,7 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 static void free_nested(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs *shadow_vmcs;
 
 	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
@@ -295,9 +296,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.current_vmptr = -1ull;
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
-		vmcs_clear(vmx->vmcs01.shadow_vmcs);
-		free_vmcs(vmx->vmcs01.shadow_vmcs);
+
+		/*
+		 * Keep the pointer visible until after VMCLEAR, so migration
+		 * can clear an active shadow VMCS on the old CPU.
+		 */
+		shadow_vmcs = vmx->vmcs01.shadow_vmcs;
+		vmcs_clear(shadow_vmcs);
 		vmx->vmcs01.shadow_vmcs = NULL;
+		free_vmcs(shadow_vmcs);
 	}
 	kfree(vmx->nested.cached_vmcs12);
 	vmx->nested.cached_vmcs12 = NULL;
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 692b0c31c9c8..b80902686c1e 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -13,14 +13,26 @@
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
 asmlinkage void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
 void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
 
+/*
+ * The VMREAD error trampoline _always_ uses the stack to pass parameters, even
+ * for 64-bit targets.  Preserving all registers allows the VMREAD inline asm
+ * blob to avoid clobbering GPRs, which in turn allows the compiler to better
+ * optimize sequences of VMREADs.
+ *
+ * Declare the trampoline as an opaque label as it's not safe to call from C
+ * code; there is no way to tell the compiler to pass params on the stack for
+ * 64-bit targets.
+ *
+ * void vmread_error_trampoline(unsigned long field, bool fault);
+ */
+extern unsigned long vmread_error_trampoline;
+
 static __always_inline void vmcs_check16(unsigned long field)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,
diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index a4ebbb889274..1cde1e7c9ae4 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -535,7 +535,7 @@ static int pkcs1pad_verify(struct akcipher_request *req)
 	int err;
 
 	if (WARN_ON(req->dst) ||
-	    WARN_ON(!req->dst_len) ||
+	    !req->dst_len ||
 	    !ctx->key_size || req->src_len != ctx->key_size)
 		return -EINVAL;
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index ac7ddd87f188..78275b2479df 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -265,6 +265,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 static int sl82c105_bridge_revision(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
+	u8 revision;
 
 	/*
 	 * The bridge should be part of the same device, but function 0.
@@ -286,8 +287,9 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
 	/*
 	 * We need to find function 0's revision, not function 1
 	 */
+	revision = bridge->revision;
 	pci_dev_put(bridge);
-	return bridge->revision;
+	return revision;
 }
 
 static void sl82c105_fixup(struct pci_dev *pdev)
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 464260f66870..26c3b287ac1f 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -443,8 +443,7 @@ static void clear_serror(struct ata_port *ap)
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
 {
-	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
-			sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr, bit);
 }
 
 static u32 qcmd_tag_to_mask(u8 tag)
@@ -512,7 +511,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	u8 status, tag;
-	int handled, num_processed, port = 0;
+	int handled, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
 	hsdev->sactive_issued = 0;
@@ -651,16 +650,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	status = ap->ops->sff_check_status(ap);
 	dev_dbg(ap->dev, "%s ATA status register=0x%x\n", __func__, status);
 
-	tag = 0;
-	num_processed = 0;
 	while (tag_mask) {
-		num_processed++;
-		while (!(tag_mask & 0x00000001)) {
-			tag++;
-			tag_mask <<= 1;
-		}
-
-		tag_mask &= (~0x00000001);
+		tag = __ffs(tag_mask);
+		tag_mask &= ~(1U << tag);
 		qc = ata_qc_from_tag(ap, tag);
 
 		/* To be picked up by completion functions */
@@ -1246,9 +1238,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = &ofdev->dev;
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
-
 	/* Get SATA interrupt number */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq == NO_IRQ) {
@@ -1281,6 +1270,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (err)
 		dev_err(&ofdev->dev, "failed to activate host");
 
+	/* Enable SATA Interrupts */
+	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 70b4f01ce4b9..e45235925387 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2020,9 +2020,14 @@ static int rbd_object_map_update_finish(struct rbd_obj_request *obj_req,
 	bool has_current_state;
 	void *p;
 
-	if (osd_req->r_result)
+	if (osd_req->r_result < 0)
 		return osd_req->r_result;
 
+	/*
+	 * Writes aren't allowed to return a data payload.
+	 */
+	WARN_ON_ONCE(osd_req->r_result > 0);
+
 	/*
 	 * Nothing to do for a snapshot object map.
 	 */
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 9a04e1083fca..1f34becea848 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3218,6 +3218,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 
 	/* set volume */
 	cgc->buffer = buffer + offset - 8;
+	cgc->buflen -= offset - 8;
 	memset(cgc->buffer, 0, 8);
 	return cdrom_mode_select(cdi, cgc);
 }
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 40d02df8acf7..822c072ffa20 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -317,7 +317,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	char clk_name[7];
 	struct regmap *regmap;
 	struct clk *clk[3];
-	int channel;
+	u32 channel;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -352,7 +352,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 
 		priv->channel[i] = channel;
 
-		snprintf(clk_name, sizeof(clk_name), "t%d_clk", channel);
+		snprintf(clk_name, sizeof(clk_name), "t%u_clk", channel);
 
 		clk[i] = of_clk_get_by_name(np->parent, clk_name);
 		if (IS_ERR(clk[i])) {
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 22d4c639d71d..40bb3845d52d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1083,6 +1083,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 err_out_exit_acpi:
 	powernow_k8_cpu_exit_acpi(data);
+	kfree(data->powernow_table);
 
 err_out:
 	kfree(data);
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index f5f9c86c50bc..d846309921a7 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -895,16 +895,13 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
-	if (vchan->cyclic) {
-		vchan->cyclic = false;
-		if (pchan && pchan->desc) {
-			struct virt_dma_desc *vd = &pchan->desc->vd;
-			struct virt_dma_chan *vc = &vchan->vc;
+	if (pchan && pchan->desc && pchan->desc != pchan->done) {
+		struct virt_dma_desc *vd = &pchan->desc->vd;
 
-			list_add_tail(&vd->node, &vc->desc_completed);
-		}
+		vchan_terminate_vdesc(vd);
 	}
 
+	vchan->cyclic = false;
 	vchan_get_all_descriptors(&vchan->vc, &head);
 
 	if (pchan) {
diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 715e491dfbc3..8678ded9360a 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -306,31 +306,34 @@ static struct fwnet_fragment_info *fwnet_frag_new(
 		if (fi->offset + fi->len == offset) {
 			/* The new fragment can be tacked on to the end */
 			/* Did the new fragment plug a hole? */
-			fi2 = list_entry(fi->fi_link.next,
-					 struct fwnet_fragment_info, fi_link);
-			if (fi->offset + fi->len == fi2->offset) {
-				/* glue fragments together */
-				fi->len += len + fi2->len;
-				list_del(&fi2->fi_link);
-				kfree(fi2);
-			} else {
-				fi->len += len;
+			if (!list_is_last(&fi->fi_link, &pd->fi_list)) {
+				fi2 = list_next_entry(fi, fi_link);
+				if (offset + len == fi2->offset) {
+					/* glue fragments together */
+					fi->len += len + fi2->len;
+					list_del(&fi2->fi_link);
+					kfree(fi2);
+
+					return fi;
+				}
 			}
+			fi->len += len;
 
 			return fi;
 		}
 		if (offset + len == fi->offset) {
 			/* The new fragment can be tacked on to the beginning */
 			/* Did the new fragment plug a hole? */
-			fi2 = list_entry(fi->fi_link.prev,
-					 struct fwnet_fragment_info, fi_link);
-			if (fi2->offset + fi2->len == fi->offset) {
-				/* glue fragments together */
-				fi2->len += fi->len + len;
-				list_del(&fi->fi_link);
-				kfree(fi);
-
-				return fi2;
+			if (!list_is_first(&fi->fi_link, &pd->fi_list)) {
+				fi2 = list_prev_entry(fi, fi_link);
+				if (fi2->offset + fi2->len == offset) {
+					/* glue fragments together */
+					fi2->len += fi->len + len;
+					list_del(&fi->fi_link);
+					kfree(fi);
+
+					return fi2;
+				}
 			}
 			fi->offset = offset;
 			fi->len += len;
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 66196b293b6c..99887349de23 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -594,9 +594,9 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 		return -EINVAL;
 	}
 	if (kfifo_avail(&r_evt->proto->equeue.kfifo) < sizeof(eh) + len) {
-		dev_warn(handle->dev,
-			 "queue full, dropping proto_id:%d  evt_id:%d  ts:%lld\n",
-			 proto_id, evt_id, ktime_to_ns(ts));
+		dev_warn_ratelimited(handle->dev,
+				     "queue full, dropping proto_id:%d  evt_id:%d  ts:%lld\n",
+				     proto_id, evt_id, ktime_to_ns(ts));
 		return -ENOMEM;
 	}
 
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 6b6a819fcddf..ae6d942ab2d7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -911,13 +911,15 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc(sizeof(*pmem), GFP_KERNEL);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -950,10 +952,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 				       (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
+			kfree(pmem);
 			return;
 		}
-
-	list_del(&svc_data_mem);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index a552df298a97..af4b3b7f3033 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -92,7 +92,7 @@ struct pch_gpio {
 	struct pch_gpio_reg_data pch_gpio_reg;
 	int irq_base;
 	enum pch_type_t ioh;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
@@ -101,7 +101,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct pch_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -109,7 +109,7 @@ static void pch_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int pch_gpio_get(struct gpio_chip *gpio, unsigned int nr)
@@ -127,7 +127,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	reg_val = ioread32(&chip->reg->po);
 	if (val)
@@ -141,7 +141,7 @@ static int pch_gpio_direction_output(struct gpio_chip *gpio, unsigned int nr,
 	pm |= BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -152,12 +152,12 @@ static int pch_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->pm);
 	pm &= BIT(gpio_pins[chip->ioh]) - 1;
 	pm &= ~BIT(nr);
 	iowrite32(pm, &chip->reg->pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -259,7 +259,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 		return 0;
 	}
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	/* Set interrupt mode */
 	im = ioread32(im_reg) & ~(PCH_IM_MASK << (im_pos * 4));
@@ -271,7 +271,7 @@ static int pch_irq_type(struct irq_data *d, unsigned int type)
 	else if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 	return 0;
 }
 
@@ -378,7 +378,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
 
 	chip->reg = chip->base;
 	pci_set_drvdata(pdev, chip);
-	spin_lock_init(&chip->spinlock);
+	raw_spin_lock_init(&chip->spinlock);
 	pch_gpio_setup(chip);
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &chip->gpio, chip);
@@ -415,9 +415,9 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pch_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -427,11 +427,11 @@ static int __maybe_unused pch_gpio_resume(struct device *dev)
 	struct pch_gpio *chip = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->reset);
 	iowrite32(0x00, &chip->reg->reset);
 	pch_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index eb68b0f1da82..173ac5677d46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -466,7 +466,9 @@ static int acp_hw_fini(void *handle)
 
 	mfd_remove_devices(adev->acp.parent);
 	kfree(adev->acp.acp_res);
+	pm_genpd_remove(&adev->acp.acp_genpd->gpd);
 	kfree(adev->acp.acp_genpd);
+	adev->acp.acp_genpd = NULL;
 	kfree(adev->acp.acp_cell);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 02a73b9e08d7..dee88a7e90ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -358,6 +358,45 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
 }
 
 #ifdef CONFIG_ACPI
+/**
+ * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
+ * @adev: AMDGPU device
+ * @vhdr: VFCT image header to check
+ *
+ * VFCT entries contain the PCI bus number as recorded during BIOS POST.
+ * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
+ * resource conflicts), the runtime bus number may differ from the POST
+ * value.  Match by device identity (vendor + device + function) and use
+ * the bus number as a preference: exact bus match is preferred, but when
+ * the bus numbers disagree we accept the entry if the device identity
+ * matches.
+ *
+ * Returns: 0 on match, -ENODEV on no match
+ */
+static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
+				  VFCT_IMAGE_HEADER *vhdr)
+{
+	/* Vendor and device IDs must always match */
+	if (vhdr->VendorID != adev->pdev->vendor ||
+	    vhdr->DeviceID != adev->pdev->device)
+		return -ENODEV;
+
+	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
+	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
+		return -ENODEV;
+
+	/* Exact bus number match - preferred */
+	if (vhdr->PCIBus == adev->pdev->bus->number)
+		return 0;
+
+	/* Bus mismatch but device identity matches (PCI renumbering case) */
+	dev_notice(adev->dev,
+		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
+		   vhdr->PCIBus, adev->pdev->bus->number,
+		   adev->pdev->vendor, adev->pdev->device);
+	return 0;
+}
+
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 {
 	struct acpi_table_header *hdr;
@@ -393,11 +432,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 
 		if (vhdr->ImageLength &&
-		    vhdr->PCIBus == adev->pdev->bus->number &&
-		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
-		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
-		    vhdr->VendorID == adev->pdev->vendor &&
-		    vhdr->DeviceID == adev->pdev->device) {
+		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
 			adev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6937f8134008..60233cd18fad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -275,10 +275,12 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_free;
 	}
 
-	r = amdgpu_bo_pin(*bo_ptr, domain);
-	if (r) {
-		dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
-		goto error_unreserve;
+	if (free) {
+		r = amdgpu_bo_pin(*bo_ptr, domain);
+		if (r) {
+			dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
+			goto error_unreserve;
+		}
 	}
 
 	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
@@ -301,7 +303,8 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	return 0;
 
 error_unpin:
-	amdgpu_bo_unpin(*bo_ptr);
+	if (free)
+		amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
 	amdgpu_bo_unreserve(*bo_ptr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0faa5ad26d61..228da106477d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1979,6 +1979,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	else
 		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
 
+	/* Cap GTT so that it does not exceed total physical RAM. */
+	if (adev->flags & AMD_IS_APU) {
+		u64 phys_ram = (u64)totalram_pages() << PAGE_SHIFT;
+
+		if (gtt_size > phys_ram) {
+			gtt_size = phys_ram;
+			dev_info(adev->dev,
+				 "Capping GTT to %uM to not exceed available system memory\n",
+				 (unsigned int)(gtt_size / (1024 * 1024)));
+		}
+	}
+
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 665ead139c30..25095536b8ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -567,6 +567,14 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned min_ctx_size = ~0;
 
+	/* Reject invalid dimensions to prevent division by zero */
+	if (width < 16 || height < 16) {
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Invalid UVD decoding dimensions (%dx%d)!\n",
+			      width, height);
+		return -EINVAL;
+	}
+
 	image_size = width * height;
 	image_size += image_size / 2;
 	image_size = ALIGN(image_size, 1024);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 567183a69660..9f286026226d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3437,7 +3437,7 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			   WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -7811,7 +7811,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -7846,7 +7846,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -7879,9 +7879,9 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -7917,9 +7917,6 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0459e7b71945..7e8dfe8aa203 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6292,9 +6292,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 					 u64 seq, unsigned int flags)
 {
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 86bba36938b8..5a66aca7972d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1028,7 +1028,7 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				 WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -5295,7 +5295,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -5330,7 +5330,7 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -5364,9 +5364,9 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index be23d637c3d7..47915d657a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -487,7 +487,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -498,7 +498,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ad36f337c8a8..b91dd3bd5f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -425,7 +425,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -436,7 +436,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 974a17a95324..4d3aa5fc6c66 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -110,11 +110,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 		hwmgr->od_enabled = false;
 		switch (hwmgr->chip_id) {
 		case CHIP_BONAIRE:
-			/* R9 M380 in iMac 2015: SMU hangs when enabling MCLK DPM
-			 * R7 260X cards with old MC ucode: MCLK DPM is unstable
-			 */
-			if (adev->pdev->subsystem_vendor == 0x106B ||
-			    adev->pdev->device == 0x6658) {
+			/* R9 M380 in iMac 2015: SMU hangs when enabling MCLK DPM */
+			if (adev->pdev->subsystem_vendor == 0x106B) {
 				dev_info(adev->dev, "disabling MCLK DPM on quirky ASIC");
 				adev->pm.pp_feature &= ~PP_MCLK_DPM_MASK;
 				hwmgr->feature_mask &= ~PP_MCLK_DPM_MASK;
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index da21d2a10cc9..9aa7040e295e 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -232,7 +232,7 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 		p = &prev->rb_right;
 	}
 
-	if (IS_ENABLED(CONFIG_DRM_I915_SELFTESTS) &&
+	if (IS_ENABLED(CONFIG_DRM_I915_SELFTEST) &&
 	    IS_ENABLED(CONFIG_DRM_I915_DEBUG_GEM)) {
 		struct intel_engine_cs *engine;
 		unsigned int isolation;
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index 6180a47c1b51..9ec66ef774cf 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -17,9 +17,9 @@ static int cmp_u64(const void *A, const void *B)
 {
 	const u64 *a = A, *b = B;
 
-	if (a < b)
+	if (*a < *b)
 		return -1;
-	else if (a > b)
+	else if (*a > *b)
 		return 1;
 	else
 		return 0;
@@ -29,9 +29,9 @@ static int cmp_u32(const void *A, const void *B)
 {
 	const u32 *a = A, *b = B;
 
-	if (a < b)
+	if (*a < *b)
 		return -1;
-	else if (a > b)
+	else if (*a > *b)
 		return 1;
 	else
 		return 0;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
index c962df9910dd..73c090e28bc9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
@@ -314,6 +314,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
 					  i, us, fw);
 			}
 		}
+		nvkm_done(acr->wpr);
 		return -EINVAL;
 	}
 	nvkm_done(acr->wpr);
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 654155b440e5..ccda12ba4e94 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -895,6 +895,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 {
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	struct radeon_fence *fence;
+	uint64_t cur_src_offset, cur_dst_offset;
 	uint32_t cur_pages;
 	uint32_t stride_bytes = RADEON_GPU_PAGE_SIZE;
 	uint32_t pitch;
@@ -923,6 +924,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 			cur_pages = 8191;
 		}
 		num_gpu_pages -= cur_pages;
+		cur_src_offset = src_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
+		cur_dst_offset = dst_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
 
 		/* pages are in Y direction - height
 		   page width in X direction - width */
@@ -939,13 +944,13 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 				  RADEON_DP_SRC_SOURCE_MEMORY |
 				  RADEON_GMC_CLR_CMP_CNTL_DIS |
 				  RADEON_GMC_WR_MSK_DIS);
-		radeon_ring_write(ring, (pitch << 22) | (src_offset >> 10));
-		radeon_ring_write(ring, (pitch << 22) | (dst_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_src_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset >> 10));
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
 		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
-		radeon_ring_write(ring, num_gpu_pages);
-		radeon_ring_write(ring, num_gpu_pages);
+		radeon_ring_write(ring, 0);
+		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, cur_pages | (stride_pixels << 16));
 	}
 	radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 33fb4d05c506..7b16c28ba25a 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -683,6 +683,8 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	val = div_u64(8 * (symbol + 1), bit_per_pix) - val;
 	val += 2;
 	ret = cdn_dp_reg_write(dp, DP_VC_TABLE(15), val);
+	if (ret)
+		goto err_config_video;
 
 	switch (video->color_depth) {
 	case 6:
diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index eec76af49f04..985572a012d3 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -379,6 +379,23 @@ validate_tile_binning_config(VALIDATE_ARGS)
 		return -EINVAL;
 	}
 
+	/* The tile state data array is 48 bytes per tile, and we put it at
+	 * the start of a BO containing both it and the tile alloc.
+	 */
+	tile_state_size = 48 * tile_count;
+
+	/* Since the tile alloc array will follow us, align. */
+	tile_state_size = roundup(tile_state_size, 4096);
+
+	/* Reject configurations whose tile state would leave no room for
+	 * the tile alloc pool that follows it in the slot.
+	 */
+	if (tile_state_size >= vc4->bin_alloc_size) {
+		DRM_DEBUG("Tile binning config of %dx%d too large\n",
+			  exec->bin_tiles_x, exec->bin_tiles_y);
+		return -EINVAL;
+	}
+
 	bin_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_slot < 0) {
 		if (bin_slot != -EINTR && bin_slot != -ERESTARTSYS) {
@@ -394,13 +411,13 @@ validate_tile_binning_config(VALIDATE_ARGS)
 	exec->bin_slots |= BIT(bin_slot);
 	bin_addr = vc4->bin_bo->base.paddr + bin_slot * vc4->bin_alloc_size;
 
-	/* The tile state data array is 48 bytes per tile, and we put it at
-	 * the start of a BO containing both it and the tile alloc.
-	 */
-	tile_state_size = 48 * tile_count;
+	exec->tile_alloc_offset = bin_addr + tile_state_size;
 
-	/* Since the tile alloc array will follow us, align. */
-	exec->tile_alloc_offset = bin_addr + roundup(tile_state_size, 4096);
+	/* The TSDA area must be zeroed out before use, otherwise the PTB might
+	 * consume a stale tile state.
+	 */
+	memset(vc4->bin_bo->base.vaddr + bin_slot * vc4->bin_alloc_size, 0,
+	       tile_state_size);
 
 	*(uint8_t *)(validated + 14) =
 		((flags & ~(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_MASK |
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 9bec26fda14c..24443f6fd659 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1529,6 +1529,12 @@ static int vmw_cmd_dma(struct vmw_private *dev_priv,
 	bool dirty;
 
 	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
+		VMW_DEBUG_USER("Illegal SVGA_3D_CMD_SURFACE_DMA size.\n");
+		return -EINVAL;
+	}
+
 	suffix = (SVGA3dCmdSurfaceDMASuffix *)((unsigned long) &cmd->body +
 					       header->size - sizeof(*suffix));
 
@@ -1590,11 +1596,17 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 	uint32_t maxnum;
 	int ret;
 
+	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Illegal DRAW_PRIMITIVES header size.\n");
+		return -EINVAL;
+	}
+
 	ret = vmw_cmd_cid_check(dev_priv, sw_context, header);
 	if (unlikely(ret != 0))
 		return ret;
 
-	cmd = container_of(header, typeof(*cmd), header);
 	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
 
 	if (unlikely(cmd->body.numVertexDecls > maxnum)) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index f1a51371de5b..0005016a9be7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -101,7 +101,7 @@ static int vmw_gb_surface_unbind(struct vmw_resource *res,
 static int vmw_gb_surface_destroy(struct vmw_resource *res);
 static int
 vmw_gb_surface_define_internal(struct drm_device *dev,
-			       struct drm_vmw_gb_surface_create_ext_req *req,
+			       const  struct drm_vmw_gb_surface_create_ext_req *req,
 			       struct drm_vmw_gb_surface_create_rep *rep,
 			       struct drm_file *file_priv);
 static int
@@ -1450,7 +1450,7 @@ int vmw_gb_surface_reference_ext_ioctl(struct drm_device *dev, void *data,
  */
 static int
 vmw_gb_surface_define_internal(struct drm_device *dev,
-			       struct drm_vmw_gb_surface_create_ext_req *req,
+			       const  struct drm_vmw_gb_surface_create_ext_req *req,
 			       struct drm_vmw_gb_surface_create_rep *rep,
 			       struct drm_file *file_priv)
 {
@@ -1469,9 +1469,21 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 				req->base.svga3d_flags);
 
 	/* array_size must be null for non-GL3 host. */
-	if (req->base.array_size > 0 && !has_sm4_context(dev_priv)) {
-		VMW_DEBUG_USER("SM4 surface not supported.\n");
-		return -EINVAL;
+	if (req->base.array_size > 0) {
+		if (has_sm5_context(dev_priv)) {
+			if (req->base.array_size > SVGA3D_SM5_MAX_SURFACE_ARRAYSIZE) {
+				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
+				return -EINVAL;
+			}
+		} else if (has_sm4_context(dev_priv)) {
+			if (req->base.array_size > SVGA3D_SM4_MAX_SURFACE_ARRAYSIZE) {
+				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
+				return -EINVAL;
+			}
+		} else {
+			VMW_DEBUG_USER("SM4+ surface not supported.\n");
+			return -EINVAL;
+		}
 	}
 
 	if (!has_sm4_1_context(dev_priv)) {
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index bd31315fdaf5..93d1280bce85 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1668,7 +1668,8 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 static int logi_dj_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
-	struct hid_report_enum *rep_enum;
+	struct hid_report_enum *input_report_enum;
+	struct hid_report_enum *output_report_enum;
 	struct hid_report *rep;
 	struct dj_receiver_dev *djrcv_dev;
 	struct usb_interface *intf;
@@ -1711,10 +1712,25 @@ static int logi_dj_probe(struct hid_device *hdev,
 		}
 	}
 
-	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
+	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
+	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
+
+	if (rep && rep->maxfield < 1) {
+		hid_err(hdev, "Expected size of DJ short report is %d, but got 0",
+			DJREPORT_SHORT_LENGTH - 1);
+		return -EINVAL;
+	}
+
+	if (rep && rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
+		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
+			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
+		return -EINVAL;
+	}
+
+	input_report_enum = &hdev->report_enum[HID_INPUT_REPORT];
 
 	/* no input reports, bail out */
-	if (list_empty(&rep_enum->report_list))
+	if (list_empty(&input_report_enum->report_list))
 		return -ENODEV;
 
 	/*
@@ -1722,7 +1738,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	 * Note: we should theoretically check for HID++ and DJ
 	 * collections, but this will do.
 	 */
-	list_for_each_entry(rep, &rep_enum->report_list, list) {
+	list_for_each_entry(rep, &input_report_enum->report_list, list) {
 		if (rep->application == 0xff000001)
 			has_hidpp = true;
 	}
@@ -1735,7 +1751,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 		return -ENODEV;
 
 	/* get the current application attached to the node */
-	rep = list_first_entry(&rep_enum->report_list, struct hid_report, list);
+	rep = list_first_entry(&input_report_enum->report_list, struct hid_report, list);
 	djrcv_dev = dj_get_receiver_dev(hdev, id->driver_data,
 					rep->application, has_hidpp);
 	if (!djrcv_dev) {
@@ -1743,7 +1759,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
-	if (!rep_enum->numbered)
+	if (!input_report_enum->numbered)
 		djrcv_dev->unnumbered_application = rep->application;
 
 	/* Starts the usb device and connects to upper interfaces hiddev and
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 606cb865195f..efb851d72699 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -239,6 +239,7 @@ config SENSORS_ADT7462
 config SENSORS_ADT7470
 	tristate "Analog Devices ADT7470"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7470 temperature monitoring chips.
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 71e357956ce4..cffd9a9a66a7 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/kthread.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
 #include <linux/sched.h>
@@ -36,7 +37,10 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_REG_PWM_MAX_BASE_ADDR		0x38
 #define ADT7470_REG_PWM_MAX_MAX_ADDR		0x3B
 #define ADT7470_REG_CFG				0x40
+#define		ADT7470_STRT_MASK		0x01
+#define		ADT7470_TEST_MASK		0x02
 #define		ADT7470_FSPD_MASK		0x04
+#define		ADT7470_T05_STB_MASK		0x80
 #define ADT7470_REG_ALARM1			0x41
 #define		ADT7470_R1T_ALARM		0x01
 #define		ADT7470_R2T_ALARM		0x02
@@ -66,8 +70,8 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define		ADT7470_PWM1_AUTO_MASK		0x80
 #define		ADT7470_PWM_AUTO_MASK		0xC0
 #define ADT7470_REG_PWM34_CFG			0x69
-#define		ADT7470_PWM3_AUTO_MASK		0x40
-#define		ADT7470_PWM4_AUTO_MASK		0x80
+#define		ADT7470_PWM4_AUTO_MASK		0x40
+#define		ADT7470_PWM3_AUTO_MASK		0x80
 #define	ADT7470_REG_PWM_MIN_BASE_ADDR		0x6A
 #define ADT7470_REG_PWM_MIN_MAX_ADDR		0x6D
 #define ADT7470_REG_PWM_TEMP_MIN_BASE_ADDR	0x6E
@@ -138,7 +142,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_FREQ_SHIFT	4
 
 struct adt7470_data {
-	struct i2c_client	*client;
+	struct regmap		*regmap;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -172,51 +176,77 @@ struct adt7470_data {
  * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
  * that the low byte must be read before the high byte.
  */
-static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
+static inline int adt7470_read_word_data(struct adt7470_data *data, unsigned int reg,
+					 unsigned int *val)
 {
-	u16 foo;
-	foo = i2c_smbus_read_byte_data(client, reg);
-	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
-	return foo;
+	u8 regval[2];
+	int err;
+
+	err = regmap_bulk_read(data->regmap, reg, &regval, 2);
+	if (err < 0)
+		return err;
+
+	*val = regval[0] | (regval[1] << 8);
+
+	return 0;
 }
 
-static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
-					  u16 value)
+static inline int adt7470_write_word_data(struct adt7470_data *data, unsigned int reg,
+					  unsigned int val)
 {
-	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
-	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
+	u8 regval[2];
+
+	regval[0] = val & 0xFF;
+	regval[1] = val >> 8;
+
+	return regmap_bulk_write(data->regmap, reg, &regval, 2);
 }
 
 /* Probe for temperature sensors.  Assumes lock is held */
-static int adt7470_read_temperatures(struct i2c_client *client,
-				     struct adt7470_data *data)
+static int adt7470_read_temperatures(struct adt7470_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 pwm[ADT7470_FAN_COUNT];
+	unsigned int pwm_cfg[2];
 	unsigned long res;
+	int err, err2;
 	int i;
-	u8 cfg, pwm[4], pwm_cfg[2];
 
 	/* save pwm[1-4] config register */
-	pwm_cfg[0] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0));
-	pwm_cfg[1] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2));
+	err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0]);
+	if (err < 0)
+		return err;
+	err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1]);
+	if (err < 0)
+		return err;
 
 	/* set manual pwm to whatever it is set to now */
-	for (i = 0; i < ADT7470_FAN_COUNT; i++)
-		pwm[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
+	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
+			       ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
 
 	/* put pwm in manual mode */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
-		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
-		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
+	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(0),
+				 ADT7470_PWM_AUTO_MASK, 0);
+	if (err < 0)
+		return err;
+	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(2),
+				 ADT7470_PWM_AUTO_MASK, 0);
+	if (err < 0)
+		goto out_restore;
 
 	/* write pwm control to whatever it was */
-	for (i = 0; i < ADT7470_FAN_COUNT; i++)
-		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
+	err = regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
+				ADT7470_PWM_COUNT);
+	if (err < 0)
+		goto out_restore;
 
 	/* start reading temperature sensors */
-	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	cfg |= 0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_T05_STB_MASK, ADT7470_T05_STB_MASK);
+	if (err < 0)
+		goto out_restore;
 
 	/* Delay is 200ms * number of temp sensors. */
 	res = msleep_interruptible((data->num_temp_sensors >= 0 ?
@@ -224,26 +254,48 @@ static int adt7470_read_temperatures(struct i2c_client *client,
 				    TEMP_COLLECTION_TIME));
 
 	/* done reading temperature sensors */
-	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	cfg &= ~0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_T05_STB_MASK, 0);
+	if (err < 0)
+		goto out_restore;
 
+out_restore:
 	/* restore pwm[1-4] config registers */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	err2 = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
+	if (err2 < 0) {
+		dev_warn_ratelimited(dev,
+				     "failed to restore PWM{1,2} config (%d)\n",
+				     err2);
+
+		if (!err)
+			err = err2;
+	}
 
-	if (res) {
-		pr_err("ha ha, interrupted\n");
-		return -EAGAIN;
+	err2 = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	if (err2 < 0) {
+		dev_warn_ratelimited(dev,
+				     "failed to restore PWM{3,4} config (%d)\n",
+				     err2);
+
+		if (!err)
+			err = err2;
 	}
 
+	if (err < 0)
+		return err;
+
+	if (res)
+		return -EAGAIN;
+
 	/* Only count fans if we have to */
 	if (data->num_temp_sensors >= 0)
 		return 0;
 
+	err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
+			       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
 	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
 		if (data->temp[i])
 			data->num_temp_sensors = i + 1;
 	}
@@ -258,7 +310,7 @@ static int adt7470_update_thread(void *p)
 
 	while (!kthread_should_stop()) {
 		mutex_lock(&data->lock);
-		adt7470_read_temperatures(client, data);
+		adt7470_read_temperatures(data);
 		mutex_unlock(&data->lock);
 
 		if (kthread_should_stop())
@@ -270,124 +322,169 @@ static int adt7470_update_thread(void *p)
 	return 0;
 }
 
-static struct adt7470_data *adt7470_update_device(struct device *dev)
+static int adt7470_update_sensors(struct adt7470_data *data)
 {
-	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	unsigned long local_jiffies = jiffies;
-	u8 cfg;
+	unsigned int val;
+	int err;
 	int i;
-	int need_sensors = 1;
-	int need_limits = 1;
-
-	/*
-	 * Figure out if we need to update the shadow registers.
-	 * Lockless means that we may occasionally report out of
-	 * date data.
-	 */
-	if (time_before(local_jiffies, data->sensors_last_updated +
-			SENSOR_REFRESH_INTERVAL) &&
-	    data->sensors_valid)
-		need_sensors = 0;
-
-	if (time_before(local_jiffies, data->limits_last_updated +
-			LIMIT_REFRESH_INTERVAL) &&
-	    data->limits_valid)
-		need_limits = 0;
-
-	if (!need_sensors && !need_limits)
-		return data;
-
-	mutex_lock(&data->lock);
-	if (!need_sensors)
-		goto no_sensor_update;
 
 	if (!data->temperatures_probed)
-		adt7470_read_temperatures(client, data);
+		err = adt7470_read_temperatures(data);
 	else
-		for (i = 0; i < ADT7470_TEMP_COUNT; i++)
-			data->temp[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
+		err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
+				       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
 
-	for (i = 0; i < ADT7470_FAN_COUNT; i++)
-		data->fan[i] = adt7470_read_word_data(client,
-						ADT7470_REG_FAN(i));
+	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
+		err = adt7470_read_word_data(data, ADT7470_REG_FAN(i), &val);
+		if (err < 0)
+			return err;
+		data->fan[i] =	val;
+	}
 
-	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
-		int reg;
-		int reg_mask;
+	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &data->pwm[0], ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
 
-		data->pwm[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM(i));
+	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
+		unsigned int mask;
 
 		if (i % 2)
-			reg_mask = ADT7470_PWM2_AUTO_MASK;
+			mask = ADT7470_PWM2_AUTO_MASK;
 		else
-			reg_mask = ADT7470_PWM1_AUTO_MASK;
+			mask = ADT7470_PWM1_AUTO_MASK;
 
-		reg = ADT7470_REG_PWM_CFG(i);
-		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
-			data->pwm_automatic[i] = 1;
-		else
-			data->pwm_automatic[i] = 0;
+		err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_automatic[i] = !!(val & mask);
 
-		reg = ADT7470_REG_PWM_AUTO_TEMP(i);
-		cfg = i2c_smbus_read_byte_data(client, reg);
+		err = regmap_read(data->regmap, ADT7470_REG_PWM_AUTO_TEMP(i), &val);
+		if (err < 0)
+			return err;
 		if (!(i % 2))
-			data->pwm_auto_temp[i] = cfg >> 4;
+			data->pwm_auto_temp[i] = val >> 4;
 		else
-			data->pwm_auto_temp[i] = cfg & 0xF;
+			data->pwm_auto_temp[i] = val & 0xF;
 	}
 
-	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
-	    ADT7470_FSPD_MASK)
-		data->force_pwm_max = 1;
-	else
-		data->force_pwm_max = 0;
+	err = regmap_read(data->regmap, ADT7470_REG_CFG, &val);
+	if (err < 0)
+		return err;
+	data->force_pwm_max = !!(val & ADT7470_FSPD_MASK);
+
+	err = regmap_read(data->regmap, ADT7470_REG_ALARM1, &val);
+	if (err < 0)
+		return err;
+	data->alarm = val;
+	if (data->alarm & ADT7470_OOL_ALARM) {
+		err = regmap_read(data->regmap, ADT7470_REG_ALARM2, &val);
+		if (err < 0)
+			return err;
+		data->alarm |= ALARM2(val);
+	}
 
-	data->alarm = i2c_smbus_read_byte_data(client, ADT7470_REG_ALARM1);
-	if (data->alarm & ADT7470_OOL_ALARM)
-		data->alarm |= ALARM2(i2c_smbus_read_byte_data(client,
-							ADT7470_REG_ALARM2));
-	data->alarms_mask = adt7470_read_word_data(client,
-						   ADT7470_REG_ALARM1_MASK);
+	err = adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK, &val);
+	if (err < 0)
+		return err;
+	data->alarms_mask = val;
 
-	data->sensors_last_updated = local_jiffies;
-	data->sensors_valid = 1;
+	return 0;
+}
 
-no_sensor_update:
-	if (!need_limits)
-		goto out;
+static int adt7470_update_limits(struct adt7470_data *data)
+{
+	unsigned int val;
+	int err;
+	int i;
 
 	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp_min[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MIN_REG(i));
-		data->temp_max[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MAX_REG(i));
+		err = regmap_read(data->regmap, ADT7470_TEMP_MIN_REG(i), &val);
+		if (err < 0)
+			return err;
+		data->temp_min[i] = (s8)val;
+		err = regmap_read(data->regmap, ADT7470_TEMP_MAX_REG(i), &val);
+		if (err < 0)
+			return err;
+		data->temp_max[i] = (s8)val;
 	}
 
 	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
-		data->fan_min[i] = adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MIN(i));
-		data->fan_max[i] = adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MAX(i));
+		err = adt7470_read_word_data(data, ADT7470_REG_FAN_MIN(i), &val);
+		if (err < 0)
+			return err;
+		data->fan_min[i] = val;
+		err = adt7470_read_word_data(data, ADT7470_REG_FAN_MAX(i), &val);
+		if (err < 0)
+			return err;
+		data->fan_max[i] = val;
 	}
 
 	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
-		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MAX(i));
-		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MIN(i));
-		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_TMIN(i));
+		err = regmap_read(data->regmap, ADT7470_REG_PWM_MAX(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_max[i] = val;
+		err = regmap_read(data->regmap, ADT7470_REG_PWM_MIN(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_min[i] = val;
+		err = regmap_read(data->regmap, ADT7470_REG_PWM_TMIN(i), &val);
+		if (err < 0)
+			return err;
+		data->pwm_tmin[i] = (s8)val;
 	}
 
-	data->limits_last_updated = local_jiffies;
-	data->limits_valid = 1;
+	return 0;
+}
+
+static struct adt7470_data *adt7470_update_device(struct device *dev)
+{
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	unsigned long local_jiffies = jiffies;
+	int need_sensors = 1;
+	int need_limits = 1;
+	int err;
+
+	/*
+	 * Figure out if we need to update the shadow registers.
+	 * Lockless means that we may occasionally report out of
+	 * date data.
+	 */
+	if (time_before(local_jiffies, data->sensors_last_updated +
+			SENSOR_REFRESH_INTERVAL) &&
+	    data->sensors_valid)
+		need_sensors = 0;
+
+	if (time_before(local_jiffies, data->limits_last_updated +
+			LIMIT_REFRESH_INTERVAL) &&
+	    data->limits_valid)
+		need_limits = 0;
+
+	if (!need_sensors && !need_limits)
+		return data;
+
+	mutex_lock(&data->lock);
+	if (need_sensors) {
+		err = adt7470_update_sensors(data);
+		if (err < 0)
+			goto out;
+		data->sensors_last_updated = local_jiffies;
+		data->sensors_valid = 1;
+	}
 
+	if (need_limits) {
+		err = adt7470_update_limits(data);
+		if (err < 0)
+			goto out;
+		data->limits_last_updated = local_jiffies;
+		data->limits_valid = 1;
+	}
 out:
 	mutex_unlock(&data->lock);
-	return data;
+
+	return err < 0 ? ERR_PTR(err) : data;
 }
 
 static ssize_t auto_update_interval_show(struct device *dev,
@@ -395,6 +492,10 @@ static ssize_t auto_update_interval_show(struct device *dev,
 					 char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->auto_update_interval);
 }
 
@@ -408,7 +509,7 @@ static ssize_t auto_update_interval_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 60000);
+	temp = clamp_val(temp, 500, 60000);
 
 	mutex_lock(&data->lock);
 	data->auto_update_interval = temp;
@@ -422,6 +523,10 @@ static ssize_t num_temp_sensors_show(struct device *dev,
 				     char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->num_temp_sensors);
 }
 
@@ -451,6 +556,10 @@ static ssize_t temp_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
 }
 
@@ -460,8 +569,8 @@ static ssize_t temp_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -471,11 +580,11 @@ static ssize_t temp_min_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
+	err = regmap_write(data->regmap, ADT7470_TEMP_MIN_REG(attr->index),
 				  temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t temp_max_show(struct device *dev,
@@ -483,6 +592,10 @@ static ssize_t temp_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
 }
 
@@ -492,8 +605,8 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -503,11 +616,10 @@ static ssize_t temp_max_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
-				  temp);
+	err = regmap_write(data->regmap, ADT7470_TEMP_MAX_REG(attr->index), temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
@@ -515,6 +627,10 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
 }
 
@@ -524,6 +640,9 @@ static ssize_t alarm_mask_show(struct device *dev,
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%x\n", data->alarms_mask);
 }
 
@@ -533,6 +652,7 @@ static ssize_t alarm_mask_store(struct device *dev,
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	long mask;
+	int err;
 
 	if (kstrtoul(buf, 0, &mask))
 		return -EINVAL;
@@ -542,10 +662,10 @@ static ssize_t alarm_mask_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->alarms_mask = mask;
-	adt7470_write_word_data(data->client, ADT7470_REG_ALARM1_MASK, mask);
+	err = adt7470_write_word_data(data, ADT7470_REG_ALARM1_MASK, mask);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t fan_max_show(struct device *dev,
@@ -554,6 +674,9 @@ static ssize_t fan_max_show(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan_max[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
@@ -567,8 +690,8 @@ static ssize_t fan_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
@@ -578,10 +701,10 @@ static ssize_t fan_max_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->fan_max[attr->index] = temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp);
+	err = adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(attr->index), temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t fan_min_show(struct device *dev,
@@ -590,6 +713,9 @@ static ssize_t fan_min_show(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan_min[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
@@ -603,8 +729,8 @@ static ssize_t fan_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp) || !temp)
 		return -EINVAL;
@@ -614,10 +740,10 @@ static ssize_t fan_min_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] = temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp);
+	err = adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(attr->index), temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
@@ -626,6 +752,9 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
@@ -637,6 +766,10 @@ static ssize_t force_pwm_max_show(struct device *dev,
 				  struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->force_pwm_max);
 }
 
@@ -645,24 +778,20 @@ static ssize_t force_pwm_max_store(struct device *dev,
 				   const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
-	u8 reg;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	data->force_pwm_max = temp;
-	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	if (temp)
-		reg |= ADT7470_FSPD_MASK;
-	else
-		reg &= ~ADT7470_FSPD_MASK;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_FSPD_MASK,
+				 temp ? ADT7470_FSPD_MASK : 0);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
@@ -670,6 +799,10 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm[attr->index]);
 }
 
@@ -678,8 +811,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -688,10 +821,10 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
+	err = regmap_write(data->regmap, ADT7470_REG_PWM(attr->index), temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 /* These are the valid PWM frequencies to the nearest Hz */
@@ -703,13 +836,20 @@ static ssize_t pwm1_freq_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
-	unsigned char cfg_reg_1;
-	unsigned char cfg_reg_2;
+	unsigned int cfg_reg_1, cfg_reg_2;
 	int index;
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
 	mutex_lock(&data->lock);
-	cfg_reg_1 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG);
-	cfg_reg_2 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG_2);
+	err = regmap_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1);
+	if (err < 0)
+		goto out;
+	err = regmap_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2);
+	if (err < 0)
+		goto out;
 	mutex_unlock(&data->lock);
 
 	index = (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
@@ -719,6 +859,10 @@ static ssize_t pwm1_freq_show(struct device *dev,
 		index = ARRAY_SIZE(adt7470_freq_map) - 1;
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
+
+out:
+	mutex_unlock(&data->lock);
+	return err;
 }
 
 static ssize_t pwm1_freq_store(struct device *dev,
@@ -726,11 +870,10 @@ static ssize_t pwm1_freq_store(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long freq;
 	int index;
 	int low_freq = ADT7470_CFG_LF;
-	unsigned char val;
+	int err;
 
 	if (kstrtol(buf, 10, &freq))
 		return -EINVAL;
@@ -746,16 +889,19 @@ static ssize_t pwm1_freq_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	/* Configuration Register 1 */
-	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG,
-				  (val & ~ADT7470_CFG_LF) | low_freq);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_CFG_LF, low_freq);
+	if (err < 0)
+		goto out;
+
 	/* Configuration Register 2 */
-	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG_2);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG_2,
-		(val & ~ADT7470_FREQ_MASK) | (index << ADT7470_FREQ_SHIFT));
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG_2,
+				 ADT7470_FREQ_MASK,
+				 index << ADT7470_FREQ_SHIFT);
+out:
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_max_show(struct device *dev,
@@ -763,6 +909,10 @@ static ssize_t pwm_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
 }
 
@@ -772,8 +922,8 @@ static ssize_t pwm_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -782,11 +932,11 @@ static ssize_t pwm_max_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
-				  temp);
+	err = regmap_write(data->regmap, ADT7470_REG_PWM_MAX(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_min_show(struct device *dev,
@@ -794,6 +944,10 @@ static ssize_t pwm_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
 }
 
@@ -803,8 +957,8 @@ static ssize_t pwm_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -813,11 +967,11 @@ static ssize_t pwm_min_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
-				  temp);
+	err = regmap_write(data->regmap, ADT7470_REG_PWM_MIN(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_tmax_show(struct device *dev,
@@ -825,6 +979,10 @@ static ssize_t pwm_tmax_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	/* the datasheet says that tmax = tmin + 20C */
 	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
 }
@@ -834,6 +992,10 @@ static ssize_t pwm_tmin_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
 }
 
@@ -843,8 +1005,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long temp;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -854,11 +1016,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] = temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
-				  temp);
+	err = regmap_write(data->regmap, ADT7470_REG_PWM_TMIN(attr->index),
+			   temp);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_auto_show(struct device *dev,
@@ -866,6 +1028,10 @@ static ssize_t pwm_auto_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
 }
 
@@ -875,11 +1041,9 @@ static ssize_t pwm_auto_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
 	int pwm_auto_reg_mask;
 	long temp;
-	u8 reg;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -895,15 +1059,12 @@ static ssize_t pwm_auto_store(struct device *dev,
 
 	mutex_lock(&data->lock);
 	data->pwm_automatic[attr->index] = temp;
-	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
-	if (temp)
-		reg |= pwm_auto_reg_mask;
-	else
-		reg &= ~pwm_auto_reg_mask;
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(attr->index),
+				 pwm_auto_reg_mask,
+				 temp ? pwm_auto_reg_mask : 0);
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t pwm_auto_temp_show(struct device *dev,
@@ -911,8 +1072,12 @@ static ssize_t pwm_auto_temp_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
-	u8 ctrl = data->pwm_auto_temp[attr->index];
+	u8 ctrl;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
+	ctrl = data->pwm_auto_temp[attr->index];
 	if (ctrl)
 		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
 	else
@@ -934,10 +1099,10 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
+	unsigned int mask, val;
 	long temp;
-	u8 reg;
+	int err;
 
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -946,22 +1111,26 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
 	if (temp < 0)
 		return temp;
 
+	if (temp > 0xF)
+		return -EINVAL;
+
 	mutex_lock(&data->lock);
-	data->pwm_automatic[attr->index] = temp;
-	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
 
 	if (!(attr->index % 2)) {
-		reg &= 0xF;
-		reg |= (temp << 4) & 0xF0;
+		mask = 0xF0;
+		val = (temp << 4) & 0xF0;
 	} else {
-		reg &= 0xF0;
-		reg |= temp & 0xF;
+		mask = 0x0F;
+		val = temp & 0x0F;
 	}
 
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err = regmap_update_bits(data->regmap, pwm_auto_reg, mask, val);
+	if (!err)
+		data->pwm_auto_temp[attr->index] = temp;
+
 	mutex_unlock(&data->lock);
 
-	return count;
+	return err < 0 ? err : count;
 }
 
 static ssize_t alarm_show(struct device *dev,
@@ -970,6 +1139,9 @@ static ssize_t alarm_show(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = adt7470_update_device(dev);
 
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (data->alarm & attr->index)
 		return sprintf(buf, "1\n");
 	else
@@ -1200,28 +1372,24 @@ static int adt7470_detect(struct i2c_client *client,
 	if (revision != ADT7470_REVISION)
 		return -ENODEV;
 
-	strlcpy(info->type, "adt7470", I2C_NAME_SIZE);
+	strscpy(info->type, "adt7470", I2C_NAME_SIZE);
 
 	return 0;
 }
 
-static void adt7470_init_client(struct i2c_client *client)
-{
-	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-
-	if (reg < 0) {
-		dev_err(&client->dev, "cannot read configuration register\n");
-	} else {
-		/* start monitoring (and do a self-test) */
-		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
-	}
-}
+static const struct regmap_config adt7470_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_read = true,
+	.use_single_write = true,
+};
 
 static int adt7470_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct adt7470_data *data;
 	struct device *hwmon_dev;
+	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
 	if (!data)
@@ -1229,15 +1397,21 @@ static int adt7470_probe(struct i2c_client *client)
 
 	data->num_temp_sensors = -1;
 	data->auto_update_interval = AUTO_UPDATE_INTERVAL;
+	data->regmap = devm_regmap_init_i2c(client, &adt7470_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
 
 	i2c_set_clientdata(client, data);
-	data->client = client;
 	mutex_init(&data->lock);
 
 	dev_info(&client->dev, "%s chip found\n", client->name);
 
 	/* Initialize the ADT7470 chip */
-	adt7470_init_client(client);
+	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
+				 ADT7470_STRT_MASK | ADT7470_TEST_MASK,
+				 ADT7470_STRT_MASK | ADT7470_TEST_MASK);
+	if (err < 0)
+		return err;
 
 	/* Register sysfs hooks */
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
@@ -1249,9 +1423,8 @@ static int adt7470_probe(struct i2c_client *client)
 
 	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
 					dev_name(hwmon_dev));
-	if (IS_ERR(data->auto_update)) {
+	if (IS_ERR(data->auto_update))
 		return PTR_ERR(data->auto_update);
-	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 074f812332e8..f117479096ef 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -557,6 +557,7 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 out_hw_close:
 	hid_hw_close(hdev);
+	hid_device_io_stop(hdev);
 out_hw_stop:
 	hid_hw_stop(hdev);
 	return ret;
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 71cfc1c5bd12..5428b5b4043d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -851,12 +851,12 @@ static const u16 NCT6106_REG_TOLERANCE_H[] = { 0x112, 0x122, 0x132 };
 
 static const u16 NCT6106_REG_TARGET[] = { 0x111, 0x121, 0x131 };
 
-static const u16 NCT6106_REG_WEIGHT_TEMP_SEL[] = { 0x168, 0x178, 0x188 };
-static const u16 NCT6106_REG_WEIGHT_TEMP_STEP[] = { 0x169, 0x179, 0x189 };
-static const u16 NCT6106_REG_WEIGHT_TEMP_STEP_TOL[] = { 0x16a, 0x17a, 0x18a };
-static const u16 NCT6106_REG_WEIGHT_DUTY_STEP[] = { 0x16b, 0x17b, 0x18b };
-static const u16 NCT6106_REG_WEIGHT_TEMP_BASE[] = { 0x16c, 0x17c, 0x18c };
-static const u16 NCT6106_REG_WEIGHT_DUTY_BASE[] = { 0x16d, 0x17d, 0x18d };
+static const u16 NCT6106_REG_WEIGHT_TEMP_SEL[] = { 0x168, 0x178, 0x188, 0, 0 };
+static const u16 NCT6106_REG_WEIGHT_TEMP_STEP[] = { 0x169, 0x179, 0x189, 0, 0 };
+static const u16 NCT6106_REG_WEIGHT_TEMP_STEP_TOL[] = { 0x16a, 0x17a, 0x18a, 0, 0 };
+static const u16 NCT6106_REG_WEIGHT_DUTY_STEP[] = { 0x16b, 0x17b, 0x18b, 0, 0 };
+static const u16 NCT6106_REG_WEIGHT_TEMP_BASE[] = { 0x16c, 0x17c, 0x18c, 0, 0 };
+static const u16 NCT6106_REG_WEIGHT_DUTY_BASE[] = { 0x16d, 0x17d, 0x18d, 0, 0 };
 
 static const u16 NCT6106_REG_AUTO_TEMP[] = { 0x160, 0x170, 0x180 };
 static const u16 NCT6106_REG_AUTO_PWM[] = { 0x164, 0x174, 0x184 };
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index e90ab980b836..ddd8399a7fee 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -408,7 +408,7 @@ int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
 	if (tmp != rv)
 		rv = _pmbus_write_byte_data(client, page, reg, tmp);
 
-	return rv;
+	return rv < 0 ? rv : 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_update_byte_data);
 
diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 786d24f7818a..740baf3cf73d 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -843,18 +843,8 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-static int intel_th_output_release(struct inode *inode, struct file *file)
-{
-	struct intel_th_device *thdev = file->private_data;
-
-	put_device(&thdev->dev);
-
-	return 0;
-}
-
 static const struct file_operations intel_th_output_fops = {
 	.open	= intel_th_output_open,
-	.release = intel_th_output_release,
 	.llseek	= noop_llseek,
 };
 
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 24f56a7c0fcf..cdd0b1f5150f 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1463,8 +1463,10 @@ static int intel_th_msc_release(struct inode *inode, struct file *file)
 {
 	struct msc_iter *iter = file->private_data;
 	struct msc *msc = iter->msc;
+	struct intel_th_device *thdev = msc->thdev;
 
 	msc_iter_remove(iter, msc);
+	put_device(&thdev->dev);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index 506433bc0ff2..5a4bf2aa6813 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -327,8 +327,10 @@ static int i2c_amd_probe(struct platform_device *pdev)
 
 	amd_mp2_pm_runtime_put(mp2_dev);
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&pdev->dev, "i2c add adapter failed = %d\n", ret);
+		amd_mp2_unregister_cb(&i2c_dev->common);
+	}
 
 	return ret;
 }
diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index e181db3fd2cc..993a47a98659 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -141,6 +141,7 @@ struct jz4780_i2c {
 	void __iomem		*iomem;
 	int			 irq;
 	struct clk		*clk;
+	unsigned long		 clk_rate_khz;
 	struct i2c_adapter	 adap;
 	const struct ingenic_i2c_config *cdata;
 
@@ -246,7 +247,7 @@ static int jz4780_i2c_set_target(struct jz4780_i2c *i2c, unsigned char address)
 
 static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
 {
-	int dev_clk_khz = clk_get_rate(i2c->clk) / 1000;
+	int dev_clk_khz = i2c->clk_rate_khz;
 	int cnt_high = 0;	/* HIGH period count of the SCL clock */
 	int cnt_low = 0;	/* LOW period count of the SCL clock */
 	int cnt_period = 0;	/* period count of the SCL clock */
@@ -801,6 +802,8 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	i2c->clk_rate_khz = clk_get_rate(i2c->clk) / 1000;
+
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &clk_freq);
 	if (ret) {
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index e38ae4ac454f..10d29167b585 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1783,6 +1783,24 @@ void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 			      &mad_send_wr->mad_agent_priv->done_list);
 }
 
+static bool is_kernel_rmpp_data_response(struct ib_mad_agent_private *agent,
+					 struct ib_mad_recv_wc *mad_recv_wc)
+{
+	const struct ib_mad_hdr *mad_hdr = &mad_recv_wc->recv_buf.mad->mad_hdr;
+	struct ib_rmpp_mad *rmpp_mad;
+
+	if (!ib_mad_kernel_rmpp_agent(&agent->agent) ||
+	    !ib_response_mad(mad_hdr) ||
+	    !ib_is_mad_class_rmpp(mad_hdr->mgmt_class))
+		return false;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
+
+	return (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		IB_MGMT_RMPP_FLAG_ACTIVE) &&
+	       rmpp_mad->rmpp_hdr.rmpp_type == IB_MGMT_RMPP_TYPE_DATA;
+}
+
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 				 struct ib_mad_recv_wc *mad_recv_wc)
 {
@@ -1801,6 +1819,18 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	}
 
 	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
+	if (is_kernel_rmpp_data_response(mad_agent_priv, mad_recv_wc)) {
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		mad_send_wr = ib_find_send_mad(mad_agent_priv, mad_recv_wc);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		if (!mad_send_wr) {
+			ib_free_recv_mad(mad_recv_wc);
+			deref_mad_agent(mad_agent_priv);
+			return;
+		}
+	}
+
 	if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
 		mad_recv_wc = ib_process_rmpp_recv_wc(mad_agent_priv,
 						      mad_recv_wc);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 570a1bc24fd5..f36ea9141c7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -896,7 +896,7 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 					mhop.bt_chunk_size;
 
 	for (i = 0; i < table->num_hem; ++i) {
-		obj = i * buf_chunk_size / table->obj_size;
+		obj = (u64)i * buf_chunk_size / table->obj_size;
 		if (table->hem[i])
 			hns_roce_table_mhop_put(hr_dev, table, obj, 0);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 035f226af133..edd9345da295 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -94,18 +94,31 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	goto done;
 
 found_it:
+	/*
+	 * Increment refcount and check whether it is being freed atm while
+	 * holding lock to prevent UAF
+	 */
+	if (!kref_get_unless_zero(&ip->ref)) {
+		spin_unlock_bh(&rxe->pending_lock);
+		ret = -ENXIO;
+		goto done;
+	}
+
 	list_del_init(&ip->pending_mmaps);
 	spin_unlock_bh(&rxe->pending_lock);
 
+	vma->vm_ops = &rxe_vm_ops;
+	vma->vm_private_data = ip;
+
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+		kref_put(&ip->ref, rxe_mmap_release);
 		pr_err("err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
-	vma->vm_ops = &rxe_vm_ops;
-	vma->vm_private_data = ip;
-	rxe_vma_open(vma);
 done:
 	return ret;
 }
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 95f90699d2b1..db014dae9500 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/input/mt.h>
 #include <linux/major.h>
+#include <linux/nospec.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include "input-compat.h"
@@ -67,8 +68,10 @@ static size_t evdev_get_mask_cnt(unsigned int type)
 		[EV_SND]	= SND_CNT,
 		[EV_FF]		= FF_CNT,
 	};
+	unsigned long mask = array_index_mask_nospec(type, EV_CNT);
 
-	return (type < EV_CNT) ? counts[type] : 0;
+	/* Returns 0 for out-of-bounds types, including speculatively */
+	return counts[type & mask] & mask;
 }
 
 /* requires the buffer lock to be held */
@@ -146,11 +149,11 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 	struct timespec64 ts = ktime_to_timespec64(ev_time[client->clk_type]);
 	struct input_event ev;
 
+	memset(&ev, 0, sizeof(ev));
 	ev.input_event_sec = ts.tv_sec;
 	ev.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
-	ev.value = 0;
 
 	client->buffer[client->head++] = ev;
 	client->head &= client->bufsize - 1;
@@ -218,20 +221,20 @@ static void __pass_event(struct evdev_client *client,
 	client->head &= client->bufsize - 1;
 
 	if (unlikely(client->head == client->tail)) {
+		struct input_event ev;
+
+		memset(&ev, 0, sizeof(ev));
+		ev.input_event_sec = event->input_event_sec;
+		ev.input_event_usec = event->input_event_usec;
+		ev.type = EV_SYN;
+		ev.code = SYN_DROPPED;
+
 		/*
 		 * This effectively "drops" all unconsumed events, leaving
 		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
 		 */
 		client->tail = (client->head - 2) & (client->bufsize - 1);
-
-		client->buffer[client->tail] = (struct input_event) {
-			.input_event_sec = event->input_event_sec,
-			.input_event_usec = event->input_event_usec,
-			.type = EV_SYN,
-			.code = SYN_DROPPED,
-			.value = 0,
-		};
-
+		client->buffer[client->tail] = ev;
 		client->packet_head = client->tail;
 	}
 
@@ -253,6 +256,8 @@ static void evdev_pass_values(struct evdev_client *client,
 	if (client->revoked)
 		return;
 
+	memset(&event, 0, sizeof(event));
+
 	ts = ktime_to_timespec64(ev_time[client->clk_type]);
 	event.input_event_sec = ts.tv_sec;
 	event.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 55d4fffda41b..0214c3bb2b09 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -448,6 +448,14 @@ static void ims_pcu_handle_response(struct ims_pcu *pcu)
 	}
 }
 
+static void ims_pcu_reset_packet(struct ims_pcu *pcu)
+{
+	pcu->have_stx = false;
+	pcu->have_dle = false;
+	pcu->read_pos = 0;
+	pcu->check_sum = 0;
+}
+
 static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 {
 	int i;
@@ -460,6 +468,14 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 			continue;
 
 		if (pcu->have_dle) {
+			if (pcu->read_pos >= IMS_PCU_BUF_SIZE) {
+				dev_warn(pcu->dev,
+					 "Packet too long (%d bytes), discarding\n",
+					 pcu->read_pos);
+				ims_pcu_reset_packet(pcu);
+				continue;
+			}
+
 			pcu->have_dle = false;
 			pcu->read_buf[pcu->read_pos++] = data;
 			pcu->check_sum += data;
@@ -472,10 +488,8 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 				dev_warn(pcu->dev,
 					 "Unexpected STX at byte %d, discarding old data\n",
 					 pcu->read_pos);
+			ims_pcu_reset_packet(pcu);
 			pcu->have_stx = true;
-			pcu->have_dle = false;
-			pcu->read_pos = 0;
-			pcu->check_sum = 0;
 			break;
 
 		case IMS_PCU_PROTOCOL_DLE:
@@ -495,12 +509,18 @@ static void ims_pcu_process_data(struct ims_pcu *pcu, struct urb *urb)
 				ims_pcu_handle_response(pcu);
 			}
 
-			pcu->have_stx = false;
-			pcu->have_dle = false;
-			pcu->read_pos = 0;
+			ims_pcu_reset_packet(pcu);
 			break;
 
 		default:
+			if (pcu->read_pos >= IMS_PCU_BUF_SIZE) {
+				dev_warn(pcu->dev,
+					 "Packet too long (%d bytes), discarding\n",
+					 pcu->read_pos);
+				ims_pcu_reset_packet(pcu);
+				continue;
+			}
+
 			pcu->read_buf[pcu->read_pos++] = data;
 			pcu->check_sum += data;
 			break;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1ba6adb5b912..1b7a0fae423c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3227,6 +3227,12 @@ static int __init parse_ivrs_acpihid(char *str)
 	return 1;
 
 found:
+	if (early_acpihid_map_size == EARLY_MAP_SIZE) {
+		pr_err("Early ACPI HID map overflow - ignoring ivrs_acpihid%s\n",
+		       str);
+		return 1;
+	}
+
 	p = acpiid;
 	hid = strsep(&p, ":");
 	uid = p;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 02e3183a4c67..f2f8f92738de 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -98,7 +98,7 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 
 void intel_svm_check(struct intel_iommu *iommu)
 {
-	if (!pasid_supported(iommu))
+	if (!pasid_supported(iommu) || !ecap_smpwc(iommu->ecap))
 		return;
 
 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
diff --git a/drivers/media/cec/platform/seco/seco-cec.c b/drivers/media/cec/platform/seco/seco-cec.c
index ae138cc253fd..cb69f931f85a 100644
--- a/drivers/media/cec/platform/seco/seco-cec.c
+++ b/drivers/media/cec/platform/seco/seco-cec.c
@@ -662,7 +662,7 @@ static int secocec_probe(struct platform_device *pdev)
 
 	ret = secocec_ir_probe(secocec);
 	if (ret)
-		goto err_notifier;
+		goto err_unregister_adapter;
 
 	platform_set_drvdata(pdev, secocec);
 
@@ -670,6 +670,10 @@ static int secocec_probe(struct platform_device *pdev)
 
 	return ret;
 
+err_unregister_adapter:
+	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
+	cec_unregister_adapter(secocec->cec_adap);
+	goto err;
 err_notifier:
 	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
 err_delete_adapter:
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 78ad2b278da4..1e513a3f2ece 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2706,8 +2706,8 @@ static int __vb2_cleanup_fileio(struct vb2_queue *q)
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  * @read:	access mode selector (1 means read, 0 means write)
  */
-static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblock, int read)
+static ssize_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_t count,
+				    loff_t *ppos, int nonblock, int read)
 {
 	struct vb2_fileio_data *fileio;
 	struct vb2_fileio_buf *buf;
@@ -2867,15 +2867,15 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 	return ret;
 }
 
-size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblocking)
+ssize_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
+		 loff_t *ppos, int nonblocking)
 {
 	return __vb2_perform_fileio(q, data, count, ppos, nonblocking, 1);
 }
 EXPORT_SYMBOL_GPL(vb2_read);
 
-size_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
-		loff_t *ppos, int nonblocking)
+ssize_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
+		  loff_t *ppos, int nonblocking)
 {
 	return __vb2_perform_fileio(q, (char __user *) data, count,
 							ppos, nonblocking, 0);
diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 1c3e572cad3f..a70de40ebc84 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -1115,10 +1115,10 @@ static int rtl2832_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	cancel_delayed_work_sync(&dev->i2c_gate_work);
-
 	i2c_mux_del_adapters(dev->muxc);
 
+	cancel_delayed_work_sync(&dev->i2c_gate_work);
+
 	regmap_exit(dev->regmap);
 
 	kfree(dev);
diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index ef6feb299d46..51175c2933d6 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -396,7 +396,8 @@ static int rtl2832_sdr_alloc_urbs(struct rtl2832_sdr_dev *dev)
 }
 
 /* Must be called with vb_queue_lock hold */
-static void rtl2832_sdr_cleanup_queued_bufs(struct rtl2832_sdr_dev *dev)
+static void rtl2832_sdr_cleanup_queued_bufs(struct rtl2832_sdr_dev *dev,
+					    enum vb2_buffer_state state)
 {
 	struct platform_device *pdev = dev->pdev;
 	unsigned long flags;
@@ -410,7 +411,7 @@ static void rtl2832_sdr_cleanup_queued_bufs(struct rtl2832_sdr_dev *dev)
 		buf = list_entry(dev->queued_bufs.next,
 				struct rtl2832_sdr_frame_buf, list);
 		list_del(&buf->list);
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
 }
@@ -851,11 +852,15 @@ static int rtl2832_sdr_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(&pdev->dev, "\n");
 
-	if (!dev->udev)
+	if (!dev->udev) {
+		rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 		return -ENODEV;
+	}
 
-	if (mutex_lock_interruptible(&dev->v4l2_lock))
+	if (mutex_lock_interruptible(&dev->v4l2_lock)) {
+		rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 		return -ERESTARTSYS;
+	}
 
 	if (d->props->power_ctrl)
 		d->props->power_ctrl(d, 1);
@@ -896,7 +901,11 @@ static int rtl2832_sdr_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
+	mutex_unlock(&dev->v4l2_lock);
+	return 0;
+
 err:
+	rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 	mutex_unlock(&dev->v4l2_lock);
 
 	return ret;
@@ -916,7 +925,7 @@ static void rtl2832_sdr_stop_streaming(struct vb2_queue *vq)
 	rtl2832_sdr_kill_urbs(dev);
 	rtl2832_sdr_free_urbs(dev);
 	rtl2832_sdr_free_stream_bufs(dev);
-	rtl2832_sdr_cleanup_queued_bufs(dev);
+	rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_ERROR);
 	rtl2832_sdr_unset_adc(dev);
 
 	/* sleep tuner */
diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index a23c025595a0..5984f2997c6a 100644
--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -990,8 +990,12 @@ static int cx23885_dev_setup(struct cx23885_dev *dev)
 	}
 
 	/* PCIe stuff */
-	dev->lmmio = ioremap(pci_resource_start(dev->pci, 0),
-			     pci_resource_len(dev->pci, 0));
+	dev->lmmio = pci_ioremap_bar(dev->pci, 0);
+	if (!dev->lmmio) {
+		dev_err(&dev->pci->dev, "CORE %s: can't ioremap MMIO memory\n",
+			dev->name);
+		goto err_release_region;
+	}
 
 	dev->bmmio = (u8 __iomem *)dev->lmmio;
 
@@ -1096,6 +1100,12 @@ static int cx23885_dev_setup(struct cx23885_dev *dev)
 	}
 
 	return 0;
+
+err_release_region:
+	release_mem_region(pci_resource_start(dev->pci, 0),
+			   pci_resource_len(dev->pci, 0));
+	cx23885_devcount--;
+	return -ENODEV;
 }
 
 static void cx23885_dev_unregister(struct cx23885_dev *dev)
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index d2e194a24e7e..f00ae8d3b5e3 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1195,6 +1195,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 
 	dm1105_hw_exit(dev);
 	free_irq(pdev->irq, dev);
+	destroy_workqueue(dev->wq);
 	pci_iounmap(pdev, dev->io_mem);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index df9e3293015a..a93bf3de13c7 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2126,8 +2126,10 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 	q->dev = &dev->pci->dev;
 	ret = vb2_queue_init(q);
 	if (ret)
-		return ret;
-	saa7134_pgtable_alloc(dev->pci, &dev->video_q.pt);
+		goto err_free_ctrl;
+	ret = saa7134_pgtable_alloc(dev->pci, &dev->video_q.pt);
+	if (ret)
+		goto err_free_ctrl;
 
 	q = &dev->vbi_vbq;
 	q->type = V4L2_BUF_TYPE_VBI_CAPTURE;
@@ -2144,11 +2146,24 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 	q->lock = &dev->lock;
 	q->dev = &dev->pci->dev;
 	ret = vb2_queue_init(q);
-	if (ret)
-		return ret;
-	saa7134_pgtable_alloc(dev->pci, &dev->vbi_q.pt);
+	if (ret) {
+		saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
+		goto err_free_ctrl;
+	}
+
+	ret = saa7134_pgtable_alloc(dev->pci, &dev->vbi_q.pt);
+	if (ret) {
+		saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
+		goto err_free_ctrl;
+	}
 
 	return 0;
+
+err_free_ctrl:
+	v4l2_ctrl_handler_free(&dev->ctrl_handler);
+	if (card_has_radio(dev))
+		v4l2_ctrl_handler_free(&dev->radio_ctrl_handler);
+	return ret;
 }
 
 void saa7134_video_fini(struct saa7134_dev *dev)
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
index 2c39cd7f2862..aaa26055f0e4 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
@@ -234,8 +234,10 @@ static int sun4i_csi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	int ret;
 
 	csi_fmt = sun4i_csi_find_format(&csi->fmt.pixelformat, NULL);
-	if (!csi_fmt)
-		return -EINVAL;
+	if (!csi_fmt) {
+		ret = -EINVAL;
+		goto err_clear_dma_queue;
+	}
 
 	dev_dbg(csi->dev, "Starting capture\n");
 
diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index 23997425bdb5..b76cbbdfdc0c 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -1504,6 +1504,7 @@ static int si476x_radio_probe(struct platform_device *pdev)
 	return 0;
 exit:
 	v4l2_ctrl_handler_free(radio->videodev.ctrl_handler);
+	v4l2_device_unregister(&radio->v4l2dev);
 	return rval;
 }
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index c0ad7bdbbbd1..5e0daac89fe1 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -562,8 +562,10 @@ static int __init vidtv_bridge_init(void)
 	int ret;
 
 	ret = platform_device_register(&vidtv_bridge_dev);
-	if (ret)
+	if (ret) {
+		platform_device_put(&vidtv_bridge_dev);
 		return ret;
+	}
 
 	ret = platform_driver_register(&vidtv_bridge_driver);
 	if (ret)
diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index 857529ce3638..8f4b4310ae33 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -350,6 +350,7 @@ static int __init vimc_init(void)
 	if (ret) {
 		dev_err(&vimc_pdev.dev,
 			"platform device registration failed (err=%d)\n", ret);
+		platform_device_put(&vimc_pdev);
 		return ret;
 	}
 
diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index 334130568dcb..3edd2f826afc 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -464,14 +464,20 @@ static int vivid_vid_cap_s_ctrl(struct v4l2_ctrl *ctrl)
 		vivid_update_format_cap(dev, true);
 		break;
 	case VIVID_CID_HAS_CROP_CAP:
+		if (vb2_is_busy(&dev->vb_vid_cap_q))
+			return -EBUSY;
 		dev->has_crop_cap = ctrl->val;
 		vivid_update_format_cap(dev, true);
 		break;
 	case VIVID_CID_HAS_COMPOSE_CAP:
+		if (vb2_is_busy(&dev->vb_vid_cap_q))
+			return -EBUSY;
 		dev->has_compose_cap = ctrl->val;
 		vivid_update_format_cap(dev, true);
 		break;
 	case VIVID_CID_HAS_SCALER_CAP:
+		if (vb2_is_busy(&dev->vb_vid_cap_q))
+			return -EBUSY;
 		dev->has_scaler_cap = ctrl->val;
 		vivid_update_format_cap(dev, true);
 		break;
@@ -947,14 +953,20 @@ static int vivid_vid_out_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case VIVID_CID_HAS_CROP_OUT:
+		if (vb2_is_busy(&dev->vb_vid_out_q))
+			return -EBUSY;
 		dev->has_crop_out = ctrl->val;
 		vivid_update_format_out(dev);
 		break;
 	case VIVID_CID_HAS_COMPOSE_OUT:
+		if (vb2_is_busy(&dev->vb_vid_out_q))
+			return -EBUSY;
 		dev->has_compose_out = ctrl->val;
 		vivid_update_format_out(dev);
 		break;
 	case VIVID_CID_HAS_SCALER_OUT:
+		if (vb2_is_busy(&dev->vb_vid_out_q))
+			return -EBUSY;
 		dev->has_scaler_out = ctrl->val;
 		vivid_update_format_out(dev);
 		break;
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 8886b58d1805..a6bcc7cc4bcf 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -385,6 +385,12 @@ void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls)
 	unsigned size;
 	u64 pixelclock;
 
+	/*
+	 * This resets the format, so must never be called while vb2_is_busy().
+	 */
+	if (WARN_ON(vb2_is_busy(&dev->vb_vid_cap_q)))
+		return;
+
 	switch (dev->input_type[dev->input]) {
 	case WEBCAM:
 	default:
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
index 9038be90ab35..87efbdc29c8a 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -222,6 +222,12 @@ void vivid_update_format_out(struct vivid_dev *dev)
 	unsigned size, p;
 	u64 pixelclock;
 
+	/*
+	 * This resets the format, so must never be called while vb2_is_busy().
+	 */
+	if (WARN_ON(vb2_is_busy(&dev->vb_vid_out_q)))
+		return;
+
 	switch (dev->output_type[dev->output]) {
 	case SVID:
 	default:
diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
index 751703db06f5..84f73ab4978b 100644
--- a/drivers/media/usb/airspy/airspy.c
+++ b/drivers/media/usb/airspy/airspy.c
@@ -518,11 +518,13 @@ static int airspy_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(s->dev, "\n");
 
-	if (!s->udev)
-		return -ENODEV;
-
 	mutex_lock(&s->v4l2_lock);
 
+	if (!s->udev) {
+		ret = -ENODEV;
+		goto err_clear_bit;
+	}
+
 	s->sequence = 0;
 
 	set_bit(POWER_ON, &s->flags);
diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/cx231xx/cx231xx-cards.c
index bda729b42d05..64c3cb8fc2bf 100644
--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1577,7 +1577,8 @@ static int cx231xx_init_v4l2(struct cx231xx *dev,
 		 dev->video_mode.end_point_addr,
 		 dev->video_mode.num_alt);
 
-	dev->video_mode.alt_max_pkt_size = devm_kmalloc_array(&udev->dev, 32, dev->video_mode.num_alt, GFP_KERNEL);
+	dev->video_mode.alt_max_pkt_size = devm_kmalloc_array(&interface->dev, 32,
+							      dev->video_mode.num_alt, GFP_KERNEL);
 	if (dev->video_mode.alt_max_pkt_size == NULL)
 		return -ENOMEM;
 
@@ -1618,7 +1619,8 @@ static int cx231xx_init_v4l2(struct cx231xx *dev,
 		 dev->vbi_mode.num_alt);
 
 	/* compute alternate max packet sizes for vbi */
-	dev->vbi_mode.alt_max_pkt_size = devm_kmalloc_array(&udev->dev, 32, dev->vbi_mode.num_alt, GFP_KERNEL);
+	dev->vbi_mode.alt_max_pkt_size = devm_kmalloc_array(&interface->dev, 32,
+							    dev->vbi_mode.num_alt, GFP_KERNEL);
 	if (dev->vbi_mode.alt_max_pkt_size == NULL)
 		return -ENOMEM;
 
@@ -1660,7 +1662,9 @@ static int cx231xx_init_v4l2(struct cx231xx *dev,
 		 "sliced CC EndPoint Addr 0x%x, Alternate settings: %i\n",
 		 dev->sliced_cc_mode.end_point_addr,
 		 dev->sliced_cc_mode.num_alt);
-	dev->sliced_cc_mode.alt_max_pkt_size = devm_kmalloc_array(&udev->dev, 32, dev->sliced_cc_mode.num_alt, GFP_KERNEL);
+	dev->sliced_cc_mode.alt_max_pkt_size = devm_kmalloc_array(&interface->dev, 32,
+								  dev->sliced_cc_mode.num_alt,
+								  GFP_KERNEL);
 	if (dev->sliced_cc_mode.alt_max_pkt_size == NULL)
 		return -ENOMEM;
 
@@ -1724,7 +1728,7 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
 	udev = usb_get_dev(interface_to_usbdev(interface));
 
 	/* allocate memory for our device state and initialize it */
-	dev = devm_kzalloc(&udev->dev, sizeof(*dev), GFP_KERNEL);
+	dev = devm_kzalloc(&interface->dev, sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
 		retval = -ENOMEM;
 		goto err_if;
@@ -1854,7 +1858,9 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
 			 dev->ts1_mode.end_point_addr,
 			 dev->ts1_mode.num_alt);
 
-		dev->ts1_mode.alt_max_pkt_size = devm_kmalloc_array(&udev->dev, 32, dev->ts1_mode.num_alt, GFP_KERNEL);
+		dev->ts1_mode.alt_max_pkt_size = devm_kmalloc_array(&interface->dev, 32,
+								    dev->ts1_mode.num_alt,
+								    GFP_KERNEL);
 		if (dev->ts1_mode.alt_max_pkt_size == NULL) {
 			retval = -ENOMEM;
 			goto err_video_alt;
diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 1c60dfb647e5..71195b841d40 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -541,7 +541,8 @@ static int msi2500_isoc_init(struct msi2500_dev *dev)
 }
 
 /* Must be called with vb_queue_lock hold */
-static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev)
+static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev,
+					enum vb2_buffer_state state)
 {
 	unsigned long flags;
 
@@ -554,7 +555,7 @@ static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev)
 		buf = list_entry(dev->queued_bufs.next,
 				 struct msi2500_frame_buf, list);
 		list_del(&buf->list);
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
 }
@@ -830,25 +831,40 @@ static int msi2500_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(dev->dev, "\n");
 
-	if (!dev->udev)
-		return -ENODEV;
+	if (!dev->udev) {
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
 
-	if (mutex_lock_interruptible(&dev->v4l2_lock))
-		return -ERESTARTSYS;
+	if (mutex_lock_interruptible(&dev->v4l2_lock)) {
+		ret = -ERESTARTSYS;
+		goto err_cleanup;
+	}
 
 	/* wake-up tuner */
 	v4l2_subdev_call(dev->v4l2_subdev, core, s_power, 1);
 
 	ret = msi2500_set_usb_adc(dev);
+	if (ret)
+		goto err_unlock_cleanup;
 
 	ret = msi2500_isoc_init(dev);
 	if (ret)
-		msi2500_cleanup_queued_bufs(dev);
+		goto err_unlock_cleanup;
 
 	ret = msi2500_ctrl_msg(dev, CMD_START_STREAMING, 0);
+	if (ret)
+		goto err_isoc_cleanup;
 
 	mutex_unlock(&dev->v4l2_lock);
+	return 0;
 
+err_isoc_cleanup:
+	msi2500_isoc_cleanup(dev);
+err_unlock_cleanup:
+	mutex_unlock(&dev->v4l2_lock);
+err_cleanup:
+	msi2500_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 	return ret;
 }
 
@@ -863,7 +879,7 @@ static void msi2500_stop_streaming(struct vb2_queue *vq)
 	if (dev->udev)
 		msi2500_isoc_cleanup(dev);
 
-	msi2500_cleanup_queued_bufs(dev);
+	msi2500_cleanup_queued_bufs(dev, VB2_BUF_STATE_ERROR);
 
 	/* according to tests, at least 700us delay is required  */
 	msleep(20);
diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 5e3339cc31c0..e5b636d8d5e5 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -711,11 +711,15 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct pwc_device *pdev = vb2_get_drv_priv(vq);
 	int r;
 
-	if (!pdev->udev)
+	if (!pdev->udev) {
+		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
 		return -ENODEV;
+	}
 
-	if (mutex_lock_interruptible(&pdev->v4l2_lock))
+	if (mutex_lock_interruptible(&pdev->v4l2_lock)) {
+		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
 		return -ERESTARTSYS;
+	}
 	/* Turn on camera and set LEDS on */
 	pwc_camera_power(pdev, 1);
 	pwc_set_leds(pdev, leds[0], leds[1]);
@@ -727,6 +731,11 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 		pwc_camera_power(pdev, 0);
 		/* And cleanup any queued bufs!! */
 		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
+		if (pdev->fill_buf) {
+			vb2_buffer_done(&pdev->fill_buf->vb.vb2_buf,
+					VB2_BUF_STATE_QUEUED);
+			pdev->fill_buf = NULL;
+		}
 	}
 	mutex_unlock(&pdev->v4l2_lock);
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1a8a89aa0c5c..909e158a017a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -21,6 +21,8 @@
 
 #include "uvcvideo.h"
 
+#define JPEG_MARKER_SOI                0xd8
+
 /* ------------------------------------------------------------------------
  * UVC Controls
  */
@@ -1075,6 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 				  struct uvc_buffer *meta_buf,
 				  const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/* Sanity checks:
@@ -1087,9 +1090,58 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
-	/* Increase the sequence number regardless of any buffer states, so
+	/*
+	 * Mark the buffer as done if we're at the beginning of a new frame.
+	 * End of frame detection is better implemented by checking the EOF
+	 * bit (FID bit toggling is delayed by one frame compared to the EOF
+	 * bit), but some devices don't set the bit at end of frame (and the
+	 * last payload can be lost anyway). We thus must check if the FID has
+	 * been toggled.
+	 *
+	 * stream->last_fid is initialized to -1, and buf->bytesused to 0,
+	 * so the first isochronous frame will never trigger an end of frame
+	 * detection.
+	 *
+	 * Empty buffers (bytesused == 0) don't trigger end of frame detection
+	 * as it doesn't make sense to return an empty buffer. This also
+	 * avoids detecting end of frame conditions at FID toggling if the
+	 * previous payload had the EOF bit set.
+	 */
+	if (fid != stream->last_fid && buf && buf->bytesused != 0) {
+		uvc_trace(UVC_TRACE_FRAME,
+			  "Frame complete (FID bit toggled)\n");
+		buf->state = UVC_BUF_STATE_READY;
+
+		return -EAGAIN;
+	}
+
+	/*
+	 * Some cameras, when running two parallel streams (one MJPEG alongside
+	 * another non-MJPEG stream), are known to lose the EOF packet for a frame.
+	 * We can detect the end of a frame by checking for a new SOI marker, as
+	 * the SOI always lies on the packet boundary between two frames for
+	 * these devices.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_MJPEG_NO_EOF &&
+	    (stream->cur_format->fcc == V4L2_PIX_FMT_MJPEG ||
+	     stream->cur_format->fcc == V4L2_PIX_FMT_JPEG) &&
+	    buf && buf->bytesused != 0) {
+		const u8 *packet = data + header_len;
+
+		if (len >= header_len + 2 &&
+		    packet[0] == 0xff && packet[1] == JPEG_MARKER_SOI) {
+			buf->state = UVC_BUF_STATE_READY;
+			buf->error = 1;
+			stream->last_fid ^= UVC_STREAM_FID;
+			return -EAGAIN;
+		}
+	}
+
+	/*
+	 * Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
 	 */
 	if (stream->last_fid != fid) {
@@ -1153,31 +1205,9 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			meta_buf->state = UVC_BUF_STATE_ACTIVE;
 	}
 
-	/* Mark the buffer as done if we're at the beginning of a new frame.
-	 * End of frame detection is better implemented by checking the EOF
-	 * bit (FID bit toggling is delayed by one frame compared to the EOF
-	 * bit), but some devices don't set the bit at end of frame (and the
-	 * last payload can be lost anyway). We thus must check if the FID has
-	 * been toggled.
-	 *
-	 * stream->last_fid is initialized to -1, so the first isochronous
-	 * frame will never trigger an end of frame detection.
-	 *
-	 * Empty buffers (bytesused == 0) don't trigger end of frame detection
-	 * as it doesn't make sense to return an empty buffer. This also
-	 * avoids detecting end of frame conditions at FID toggling if the
-	 * previous payload had the EOF bit set.
-	 */
-	if (fid != stream->last_fid && buf->bytesused != 0) {
-		uvc_trace(UVC_TRACE_FRAME, "Frame complete (FID bit "
-				"toggled).\n");
-		buf->state = UVC_BUF_STATE_READY;
-		return -EAGAIN;
-	}
-
 	stream->last_fid = fid;
 
-	return data[0];
+	return header_len;
 }
 
 /*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a83995276170..4a1ff08453d7 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -204,6 +204,10 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_NO_RESET_RESUME	0x00004000
+#define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e77c63467622..a42be2356672 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -342,6 +342,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 
@@ -1273,7 +1274,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 		dev_err(&cctx->rpdev->dev, "No session available\n");
 		mutex_destroy(&fl->mutex);
 		kfree(fl);
-
+		fastrpc_channel_ctx_put(cctx);
 		return -EBUSY;
 	}
 
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 58eefa43af14..bd4ac1209962 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -125,6 +125,7 @@ struct mtdswap_dev {
 
 	char *page_buf;
 	char *oob_buf;
+	struct dentry *debugfs_stats;
 };
 
 struct mtdswap_oobdata {
@@ -1264,7 +1265,8 @@ static int mtdswap_add_debugfs(struct mtdswap_dev *d)
 	if (IS_ERR_OR_NULL(root))
 		return -1;
 
-	debugfs_create_file("mtdswap_stats", S_IRUSR, root, d, &mtdswap_fops);
+	d->debugfs_stats = debugfs_create_file("mtdswap_stats", 0400, root,
+					       d, &mtdswap_fops);
 
 	return 0;
 }
@@ -1465,6 +1467,7 @@ static void mtdswap_remove_dev(struct mtd_blktrans_dev *dev)
 {
 	struct mtdswap_dev *d = MTDSWAP_MBD_TO_MTDSWAP(dev);
 
+	debugfs_remove(d->debugfs_stats);
 	del_mtd_blktrans_dev(dev);
 	mtdswap_cleanup(d);
 	kfree(d);
diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index c115e03ede88..c60e04cdf03a 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -116,8 +116,8 @@ static int mt7622_ecc_regs[] = {
 	[ECC_DECIRQ_STA] =      0x144,
 };
 
-static inline void mtk_ecc_wait_idle(struct mtk_ecc *ecc,
-				     enum mtk_ecc_operation op)
+static inline int mtk_ecc_wait_idle(struct mtk_ecc *ecc,
+				    enum mtk_ecc_operation op)
 {
 	struct device *dev = ecc->dev;
 	u32 val;
@@ -129,6 +129,8 @@ static inline void mtk_ecc_wait_idle(struct mtk_ecc *ecc,
 	if (ret)
 		dev_warn(dev, "%s NOT idle\n",
 			 op == ECC_ENCODE ? "encoder" : "decoder");
+
+	return ret;
 }
 
 static irqreturn_t mtk_ecc_irq(int irq, void *id)
@@ -302,7 +304,11 @@ int mtk_ecc_enable(struct mtk_ecc *ecc, struct mtk_ecc_config *config)
 		return ret;
 	}
 
-	mtk_ecc_wait_idle(ecc, op);
+	ret = mtk_ecc_wait_idle(ecc, op);
+	if (ret) {
+		mutex_unlock(&ecc->lock);
+		return ret;
+	}
 
 	ret = mtk_ecc_config(ecc, config);
 	if (ret) {
@@ -402,7 +408,9 @@ int mtk_ecc_encode(struct mtk_ecc *ecc, struct mtk_ecc_config *config,
 	if (ret)
 		goto timeout;
 
-	mtk_ecc_wait_idle(ecc, ECC_ENCODE);
+	ret = mtk_ecc_wait_idle(ecc, ECC_ENCODE);
+	if (ret)
+		goto timeout;
 
 	/* Program ECC bytes to OOB: per sector oob = FDM + ECC + SPARE */
 	len = (config->strength * ecc->caps->parity_bits + 7) >> 3;
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 81a5e7622ea7..dff22eddc885 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1528,8 +1528,8 @@ void bond_alb_monitor(struct work_struct *work)
 	struct bonding *bond = container_of(work, struct bonding,
 					    alb_work.work);
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct slave *slave, *curr;
 	struct list_head *iter;
-	struct slave *slave;
 
 	if (!bond_has_slaves(bond)) {
 		atomic_set(&bond_info->tx_rebalance_counter, 0);
@@ -1591,9 +1591,11 @@ void bond_alb_monitor(struct work_struct *work)
 			 * because a slave was disabled then
 			 * it can now leave promiscuous mode.
 			 */
-			dev_set_promiscuity(rtnl_dereference(bond->curr_active_slave)->dev,
-					    -1);
-			bond_info->primary_is_promisc = 0;
+			curr = rtnl_dereference(bond->curr_active_slave);
+			if (bond_info->primary_is_promisc && curr) {
+				dev_set_promiscuity(curr->dev, -1);
+				bond_info->primary_is_promisc = 0;
+			}
 
 			rtnl_unlock();
 			rcu_read_lock();
diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
index bad69a4abec1..fe45845b4a95 100644
--- a/drivers/net/can/softing/softing_fw.c
+++ b/drivers/net/can/softing/softing_fw.c
@@ -91,12 +91,12 @@ int softing_bootloader_command(struct softing *card, int16_t cmd,
 	return ret;
 }
 
-static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
-		uint16_t *plen, const uint8_t **pdat)
+static int fw_parse(const u8 **pmem, const u8 *limit, u16 *ptype,
+		    u32 *paddr, u16 *plen, const u8 **pdat)
 {
 	uint16_t checksum[2];
-	const uint8_t *mem;
-	const uint8_t *end;
+	const u8 *mem;
+	const u8 *record_end;
 
 	/*
 	 * firmware records are a binary, unaligned stream composed of:
@@ -114,14 +114,21 @@ static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
 	 * endianness & alignment.
 	 */
 	mem = *pmem;
+	/* A record needs an 8-byte prefix and a 2-byte checksum. */
+	if (mem > limit || limit - mem < 10)
+		return -EINVAL;
+
 	*ptype = le16_to_cpup((void *)&mem[0]);
 	*paddr = le32_to_cpup((void *)&mem[2]);
 	*plen = le16_to_cpup((void *)&mem[6]);
+	if (*plen > limit - mem - 10)
+		return -EINVAL;
+
 	*pdat = &mem[8];
 	/* verify checksum */
-	end = &mem[8 + *plen];
-	checksum[0] = le16_to_cpup((void *)end);
-	for (checksum[1] = 0; mem < end; ++mem)
+	record_end = &mem[8 + *plen];
+	checksum[0] = le16_to_cpup((void *)record_end);
+	for (checksum[1] = 0; mem < record_end; ++mem)
 		checksum[1] += *mem;
 	if (checksum[0] != checksum[1])
 		return -EINVAL;
@@ -139,6 +146,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	uint16_t type, len;
 	uint32_t addr;
 	uint8_t *buf = NULL, *new_buf;
+	s64 dpram_offset;
 	int buflen = 0;
 	int8_t type_end = 0;
 
@@ -153,7 +161,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	mem = fw->data;
 	end = &mem[fw->size];
 	/* look for header record */
-	ret = fw_parse(&mem, &type, &addr, &len, &dat);
+	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 	if (ret < 0)
 		goto failed;
 	if (type != 0xffff)
@@ -164,7 +172,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	}
 	/* ok, we had a header */
 	while (mem < end) {
-		ret = fw_parse(&mem, &type, &addr, &len, &dat);
+		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 		if (ret < 0)
 			goto failed;
 		if (type == 3) {
@@ -179,9 +187,13 @@ int softing_load_fw(const char *file, struct softing *card,
 			goto failed;
 		}
 
-		if ((addr + len + offset) > size)
+		dpram_offset = (s64)addr + offset;
+		if (dpram_offset < 0 || dpram_offset > size ||
+		    len > size - dpram_offset) {
+			ret = -EINVAL;
 			goto failed;
-		memcpy_toio(&dpram[addr + offset], dat, len);
+		}
+		memcpy_toio(&dpram[dpram_offset], dat, len);
 		/* be sure to flush caches from IO space */
 		mb();
 		if (len > buflen) {
@@ -195,7 +207,7 @@ int softing_load_fw(const char *file, struct softing *card,
 			buf = new_buf;
 		}
 		/* verify record data */
-		memcpy_fromio(buf, &dpram[addr + offset], len);
+		memcpy_fromio(buf, &dpram[dpram_offset], len);
 		if (memcmp(buf, dat, len)) {
 			/* is not ok */
 			dev_alert(&card->pdev->dev, "DPRAM readback failed\n");
@@ -237,7 +249,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
 	mem = fw->data;
 	end = &mem[fw->size];
 	/* look for header record */
-	ret = fw_parse(&mem, &type, &addr, &len, &dat);
+	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 	if (ret)
 		goto failed;
 	ret = -EINVAL;
@@ -253,7 +265,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
 	}
 	/* ok, we had a header */
 	while (mem < end) {
-		ret = fw_parse(&mem, &type, &addr, &len, &dat);
+		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 		if (ret)
 			goto failed;
 
@@ -279,6 +291,12 @@ int softing_load_app_fw(const char *file, struct softing *card)
 		/* work in 16bit (target) */
 		sum &= 0xffff;
 
+		if (card->pdat->app.offs > card->dpram_size ||
+		    len > card->dpram_size - card->pdat->app.offs) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
 		memcpy_toio(&card->dpram[card->pdat->app.offs], dat, len);
 		iowrite32(card->pdat->app.offs + card->pdat->app.addr,
 				&card->dpram[DPRAM_COMMAND + 2]);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 233bbfeaa771..113053617b66 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1582,6 +1582,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 	reinit_completion(&priv->get_busparams_comp);
 
 	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
 	if (err)
 		return err;
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index df0460e3633c..f47a1725fddd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -615,13 +615,22 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 				continue;
 			}
 
-			if (pos + tmp->len > actual_len) {
+			if (tmp->len < CMD_HEADER_LEN ||
+			    tmp->len > actual_len - pos) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
 			}
 
 			if (tmp->id == id) {
+				if (tmp->len > sizeof(*cmd)) {
+					dev_err_ratelimited(&dev->intf->dev,
+							    "Received command %u too large (%u)\n",
+							    tmp->id, tmp->len);
+					err = -EIO;
+					goto end;
+				}
+
 				memcpy(cmd, tmp, tmp->len);
 				goto end;
 			}
@@ -1576,7 +1585,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 			continue;
 		}
 
-		if (pos + cmd->len > len) {
+		if (cmd->len < CMD_HEADER_LEN || cmd->len > len - pos) {
 			dev_err_ratelimited(&dev->intf->dev, "Format error\n");
 			break;
 		}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 3a963f2a8c44..146259c88d2d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -444,7 +444,6 @@ static int peak_usb_start(struct peak_usb_device *dev)
 				netif_device_detach(dev->netdev);
 
 			usb_unanchor_urb(urb);
-			kfree(buf);
 			usb_free_urb(urb);
 			break;
 		}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 301a0f54fc99..709bf603784f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -502,6 +502,13 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 		cfd->len = get_can_dlc(pucan_msg_get_dlc(rm));
 	}
 
+	if (!(rx_msg_flags & PUCAN_MSG_RTR) &&
+	    le16_to_cpu(rx_msg->size) - offsetof(struct pucan_rx_msg, d) <
+	    cfd->len) {
+		kfree_skb(skb);
+		return -EBADMSG;
+	}
+
 	cfd->can_id = le32_to_cpu(rm->can_id);
 
 	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
@@ -651,6 +658,24 @@ static void pcan_usb_fd_decode_ts(struct pcan_usb_fd_if *usb_if,
 		peak_usb_set_ts_now(&usb_if->time_ref, le32_to_cpu(ts->ts_low));
 }
 
+static size_t pcan_usb_fd_rx_msg_min_size(u16 rx_msg_type)
+{
+	switch (rx_msg_type) {
+	case PUCAN_MSG_CAN_RX:
+		return offsetof(struct pucan_rx_msg, d);
+	case PCAN_UFD_MSG_CALIBRATION:
+		return sizeof(struct pcan_ufd_ts_msg);
+	case PUCAN_MSG_ERROR:
+		return sizeof(struct pucan_error_msg);
+	case PUCAN_MSG_STATUS:
+		return sizeof(struct pucan_status_msg);
+	case PCAN_UFD_MSG_OVERRUN:
+		return sizeof(struct pcan_ufd_ovr_msg);
+	default:
+		return sizeof(struct pucan_msg);
+	}
+}
+
 /* callback for bulk IN urb */
 static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 {
@@ -665,6 +690,12 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	msg_end = urb->transfer_buffer + urb->actual_length;
 	for (; msg_ptr < msg_end;) {
 		u16 rx_msg_type, rx_msg_size;
+		size_t rx_msg_min_size;
+
+		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
+			err = -EBADMSG;
+			break;
+		}
 
 		rx_msg = (struct pucan_msg *)msg_ptr;
 		if (!rx_msg->size) {
@@ -676,13 +707,20 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		rx_msg_type = le16_to_cpu(rx_msg->type);
 
 		/* check if the record goes out of current packet */
-		if (msg_ptr + rx_msg_size > msg_end) {
+		if (rx_msg_size > msg_end - msg_ptr) {
 			netdev_err(netdev,
 				   "got frag rec: should inc usb rx buf sze\n");
 			err = -EBADMSG;
 			break;
 		}
 
+		rx_msg_min_size = pcan_usb_fd_rx_msg_min_size(rx_msg_type);
+		if (rx_msg_size < rx_msg_min_size) {
+			netdev_err(netdev, "got short rec\n");
+			err = -EBADMSG;
+			break;
+		}
+
 		switch (rx_msg_type) {
 		case PUCAN_MSG_CAN_RX:
 			err = pcan_usb_fd_decode_canmsg(usb_if, rx_msg);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index c7564773fb2b..889dd6ffed88 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -521,12 +521,18 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	skb = alloc_can_skb(netdev, &can_frame);
 	if (!skb)
 		return -ENOMEM;
@@ -558,14 +564,20 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 {
 	const u16 raw_status = le16_to_cpu(er->status);
 	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
 	u8 err_mask = 0;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	/* nothing should be sent while in BUS_OFF state */
 	if (dev->can.state == CAN_STATE_BUS_OFF)
 		return 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index ebb8b3e5b9a8..01c37ffc9ceb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -364,9 +364,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
 
 	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
 
-	reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
-	reg |= XGBE_VEND2_MAC_AUTO_SW;
-	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
+	if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
+		if (enable)
+			reg |= XGBE_VEND2_MAC_AUTO_SW;
+		else
+			reg &= ~XGBE_VEND2_MAC_AUTO_SW;
+		XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
+	}
 }
 
 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 5a85999987b5..4063d4a6f47e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -565,15 +565,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
 
 void aq_ring_rx_deinit(struct aq_ring_s *self)
 {
-	if (!self)
+	unsigned int i;
+
+	if (!self || !self->buff_ring)
 		return;
 
-	for (; self->sw_head != self->sw_tail;
-		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
-		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+	/* Release every page still owned by the ring.
+	 *
+	 * Walking [sw_head, sw_tail) is not enough: refill is batched
+	 * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots),
+	 * so slots that were cleaned but not yet reposted accumulate in the
+	 * [sw_tail, sw_head) gap, and they keep their page for reuse. Walk
+	 * the whole ring and release whatever is left.
+	 */
+	for (i = 0; i < self->size; i++) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[i];
+
+		if (!buff->rxdata.page)
+			continue;
 
 		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
 	}
+
+	self->sw_head = self->sw_tail;
 }
 
 void aq_ring_free(struct aq_ring_s *self)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6dd410402529..f36b2bae3799 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3391,7 +3391,17 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
 		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
-			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+			RX_BD_TYPE_RX_AGG_BD;
+
+		/* Disable EOP if TPA is enabled to prevent overlapping zero
+		 * padding with the next segment's data.  On P7_PLUS, EOP will
+		 * automatically disable Relaxed Ordering (RO) to prevent
+		 * potential data corruption (and may degrade performance).  On
+		 * older chips, RO will not be automatically disabled and may
+		 * cause corruption.
+		 */
+		if (!(bp->flags & BNXT_FLAG_TPA))
+			type |= RX_BD_FLAGS_AGG_EOP;
 
 		bnxt_init_rxbd_pages(ring, type);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c2122d5cda62..1a7ff21f8cdb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -99,6 +99,7 @@ struct rx_bd {
 	 #define RX_BD_TYPE_48B_BD_SIZE				 (2 << 4)
 	 #define RX_BD_TYPE_64B_BD_SIZE				 (3 << 4)
 	#define RX_BD_FLAGS_SOP					(1 << 6)
+	#define RX_BD_FLAGS_AGG_EOP				(1 << 6)
 	#define RX_BD_FLAGS_EOP					(1 << 7)
 	#define RX_BD_FLAGS_BUFFERS				(3 << 8)
 	 #define RX_BD_FLAGS_1_BUFFER_PACKET			 (0 << 8)
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 09acd839a72c..829addb7f6da 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -594,7 +594,11 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
 		skb = build_skb(buf, priv->rx_buf_size);
 		if (unlikely(!skb)) {
 			net_dbg_ratelimited("build_skb failed\n");
-			goto refill;
+			/* Retain the slot; return budget so NAPI retries this
+			 * buffer. Refill would overwrite rx_buf[]/rx_phys[]
+			 * and leak them.
+			 */
+			return budget;
 		}
 
 		dma_unmap_single(priv->dev, priv->rx_phys[priv->rx_head],
@@ -622,14 +626,15 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
 			rx++;
 		}
 
-refill:
 		buf = netdev_alloc_frag(priv->rx_buf_size);
 		if (!buf)
 			goto done;
 		phys = dma_map_single(priv->dev, buf,
 				      RX_BUF_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(priv->dev, phys))
+		if (dma_mapping_error(priv->dev, phys)) {
+			skb_free_frag(buf);
 			goto done;
+		}
 		priv->rx_buf[priv->rx_head] = buf;
 		priv->rx_phys[priv->rx_head] = phys;
 		hip04_set_recv_desc(priv, phys);
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 43f3146caf07..18495d80e2e7 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1291,7 +1291,6 @@ static int hix5hd2_dev_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hix5hd2_priv *priv = netdev_priv(ndev);
 
-	netif_napi_del(&priv->napi);
 	unregister_netdev(ndev);
 	mdiobus_unregister(priv->bus);
 	mdiobus_free(priv->bus);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
index a4fbf44f944c..46b24f3c5e16 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
@@ -100,8 +100,6 @@ struct hinic_dev {
 	u16				num_rss;
 	u16				rss_limit;
 	struct hinic_rss_type		rss_type;
-	u8				*rss_hkey_user;
-	s32				*rss_indir_user;
 	struct hinic_intr_coal_info	*rx_intr_coalesce;
 	struct hinic_intr_coal_info	*tx_intr_coalesce;
 	struct hinic_sriov_info sriov_info;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index c340d9acba80..4a1693c70582 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -1061,17 +1061,6 @@ static int __set_rss_rxfh(struct net_device *netdev,
 	int err;
 
 	if (indir) {
-		if (!nic_dev->rss_indir_user) {
-			nic_dev->rss_indir_user =
-				kzalloc(sizeof(u32) * HINIC_RSS_INDIR_SIZE,
-					GFP_KERNEL);
-			if (!nic_dev->rss_indir_user)
-				return -ENOMEM;
-		}
-
-		memcpy(nic_dev->rss_indir_user, indir,
-		       sizeof(u32) * HINIC_RSS_INDIR_SIZE);
-
 		err = hinic_rss_set_indir_tbl(nic_dev,
 					      nic_dev->rss_tmpl_idx, indir);
 		if (err)
@@ -1079,16 +1068,6 @@ static int __set_rss_rxfh(struct net_device *netdev,
 	}
 
 	if (key) {
-		if (!nic_dev->rss_hkey_user) {
-			nic_dev->rss_hkey_user =
-				kzalloc(HINIC_RSS_KEY_SIZE * 2, GFP_KERNEL);
-
-			if (!nic_dev->rss_hkey_user)
-				return -ENOMEM;
-		}
-
-		memcpy(nic_dev->rss_hkey_user, key, HINIC_RSS_KEY_SIZE);
-
 		err = hinic_rss_set_template_tbl(nic_dev,
 						 nic_dev->rss_tmpl_idx, key);
 		if (err)
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7e7c619a98e..c1ad3e5620f0 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1228,11 +1228,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->flash_address)
 		iounmap(hw->flash_address);
+err_mdio_ioremap:
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-err_mdio_ioremap:
 	iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 037ec90ed56c..1ffa27af6ae6 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2215,8 +2215,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 50a36639e0ce..ca2b8ae98bd2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -840,8 +840,8 @@ static void otx2_handle_link_event(struct otx2_nic *pf)
 		netif_carrier_on(netdev);
 		netif_tx_start_all_queues(netdev);
 	} else {
-		netif_tx_stop_all_queues(netdev);
 		netif_carrier_off(netdev);
+		netif_tx_stop_all_queues(netdev);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index be5677623455..df4401e9d224 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -16,6 +16,9 @@
 #define PRESTERA_SUPP_FW_MAJ_VER	2
 #define PRESTERA_SUPP_FW_MIN_VER	0
 
+#define PRESTERA_PREV_FW_MAJ_VER	2
+#define PRESTERA_PREV_FW_MIN_VER	0
+
 #define PRESTERA_FW_PATH_FMT	"mrvl/prestera/mvsw_prestera_fw-v%u.%u.img"
 
 #define PRESTERA_FW_HDR_MAGIC		0x351D9D06
@@ -166,6 +169,8 @@ struct prestera_fw_evtq {
 };
 
 struct prestera_fw {
+	struct prestera_fw_rev rev_supp;
+	const struct firmware *bin;
 	struct workqueue_struct *wq;
 	struct prestera_device dev;
 	u8 __iomem *ldr_regs;
@@ -576,25 +581,27 @@ static void prestera_fw_rev_parse(const struct prestera_fw_header *hdr,
 static int prestera_fw_rev_check(struct prestera_fw *fw)
 {
 	struct prestera_fw_rev *rev = &fw->dev.fw_rev;
-	u16 maj_supp = PRESTERA_SUPP_FW_MAJ_VER;
-	u16 min_supp = PRESTERA_SUPP_FW_MIN_VER;
 
-	if (rev->maj == maj_supp && rev->min >= min_supp)
+	if (rev->maj == fw->rev_supp.maj && rev->min >= fw->rev_supp.min)
 		return 0;
 
 	dev_err(fw->dev.dev, "Driver supports FW version only '%u.%u.x'",
-		PRESTERA_SUPP_FW_MAJ_VER, PRESTERA_SUPP_FW_MIN_VER);
+		fw->rev_supp.maj, fw->rev_supp.min);
 
 	return -EINVAL;
 }
 
-static int prestera_fw_hdr_parse(struct prestera_fw *fw,
-				 const struct firmware *img)
+static int prestera_fw_hdr_parse(struct prestera_fw *fw)
 {
-	struct prestera_fw_header *hdr = (struct prestera_fw_header *)img->data;
 	struct prestera_fw_rev *rev = &fw->dev.fw_rev;
+	struct prestera_fw_header *hdr;
 	u32 magic;
 
+	if (fw->bin->size < sizeof(*hdr))
+		return -EINVAL;
+
+	hdr = (struct prestera_fw_header *)fw->bin->data;
+
 	magic = be32_to_cpu(hdr->magic_number);
 	if (magic != PRESTERA_FW_HDR_MAGIC) {
 		dev_err(fw->dev.dev, "FW img hdr magic is invalid");
@@ -609,11 +616,53 @@ static int prestera_fw_hdr_parse(struct prestera_fw *fw,
 	return prestera_fw_rev_check(fw);
 }
 
+static int prestera_fw_get(struct prestera_fw *fw)
+{
+	int ver_maj = PRESTERA_SUPP_FW_MAJ_VER;
+	int ver_min = PRESTERA_SUPP_FW_MIN_VER;
+	char fw_path[128];
+	int err;
+
+pick_fw_ver:
+	snprintf(fw_path, sizeof(fw_path), PRESTERA_FW_PATH_FMT,
+		 ver_maj, ver_min);
+
+	err = request_firmware_direct(&fw->bin, fw_path, fw->dev.dev);
+	if (err) {
+		if (ver_maj != PRESTERA_PREV_FW_MAJ_VER ||
+		    ver_min != PRESTERA_PREV_FW_MIN_VER) {
+			ver_maj = PRESTERA_PREV_FW_MAJ_VER;
+			ver_min = PRESTERA_PREV_FW_MIN_VER;
+
+			dev_warn(fw->dev.dev,
+				 "missing latest %s firmware, fall-back to previous %u.%u version\n",
+				 fw_path, ver_maj, ver_min);
+
+			goto pick_fw_ver;
+		} else {
+			dev_err(fw->dev.dev, "failed to request previous firmware: %s\n",
+				fw_path);
+			return err;
+		}
+	}
+
+	dev_info(fw->dev.dev, "Loading %s ...", fw_path);
+
+	fw->rev_supp.maj = ver_maj;
+	fw->rev_supp.min = ver_min;
+	fw->rev_supp.sub = 0;
+
+	return 0;
+}
+
+static void prestera_fw_put(struct prestera_fw *fw)
+{
+	release_firmware(fw->bin);
+}
+
 static int prestera_fw_load(struct prestera_fw *fw)
 {
 	size_t hlen = sizeof(struct prestera_fw_header);
-	const struct firmware *f;
-	char fw_path[128];
 	int err;
 
 	err = prestera_ldr_wait_reg32(fw, PRESTERA_LDR_READY_REG,
@@ -632,30 +681,24 @@ static int prestera_fw_load(struct prestera_fw *fw)
 
 	fw->ldr_wr_idx = 0;
 
-	snprintf(fw_path, sizeof(fw_path), PRESTERA_FW_PATH_FMT,
-		 PRESTERA_SUPP_FW_MAJ_VER, PRESTERA_SUPP_FW_MIN_VER);
-
-	err = request_firmware_direct(&f, fw_path, fw->dev.dev);
-	if (err) {
-		dev_err(fw->dev.dev, "failed to request firmware file\n");
+	err = prestera_fw_get(fw);
+	if (err)
 		return err;
-	}
 
-	err = prestera_fw_hdr_parse(fw, f);
+	err = prestera_fw_hdr_parse(fw);
 	if (err) {
 		dev_err(fw->dev.dev, "FW image header is invalid\n");
 		goto out_release;
 	}
 
-	prestera_ldr_write(fw, PRESTERA_LDR_IMG_SIZE_REG, f->size - hlen);
+	prestera_ldr_write(fw, PRESTERA_LDR_IMG_SIZE_REG, fw->bin->size - hlen);
 	prestera_ldr_write(fw, PRESTERA_LDR_CTL_REG, PRESTERA_LDR_CTL_DL_START);
 
-	dev_info(fw->dev.dev, "Loading %s ...", fw_path);
-
-	err = prestera_ldr_fw_send(fw, f->data + hlen, f->size - hlen);
+	err = prestera_ldr_fw_send(fw, fw->bin->data + hlen,
+				   fw->bin->size - hlen);
 
 out_release:
-	release_firmware(f);
+	prestera_fw_put(fw);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index f3985421e739..9817de5590b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -1036,13 +1036,11 @@ struct mlx5_fw_tracer *mlx5_fw_tracer_create(struct mlx5_core_dev *dev)
 
 	tracer = kvzalloc(sizeof(*tracer), GFP_KERNEL);
 	if (!tracer)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	tracer->work_queue = create_singlethread_workqueue("mlx5_fw_tracer");
-	if (!tracer->work_queue) {
-		err = -ENOMEM;
+	if (!tracer->work_queue)
 		goto free_tracer;
-	}
 
 	tracer->dev = dev;
 
@@ -1082,7 +1080,7 @@ struct mlx5_fw_tracer *mlx5_fw_tracer_create(struct mlx5_core_dev *dev)
 	destroy_workqueue(tracer->work_queue);
 free_tracer:
 	kvfree(tracer);
-	return ERR_PTR(err);
+	return NULL;
 }
 
 static int fw_tracer_event(struct notifier_block *nb, unsigned long action, void *data);
@@ -1093,7 +1091,7 @@ int mlx5_fw_tracer_init(struct mlx5_fw_tracer *tracer)
 	struct mlx5_core_dev *dev;
 	int err;
 
-	if (IS_ERR_OR_NULL(tracer))
+	if (!tracer)
 		return 0;
 
 	dev = tracer->dev;
@@ -1136,7 +1134,7 @@ int mlx5_fw_tracer_init(struct mlx5_fw_tracer *tracer)
 /* Stop tracer + Cleanup HW resources */
 void mlx5_fw_tracer_cleanup(struct mlx5_fw_tracer *tracer)
 {
-	if (IS_ERR_OR_NULL(tracer))
+	if (!tracer)
 		return;
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: Cleanup, is owner ? (%d)\n",
@@ -1155,7 +1153,7 @@ void mlx5_fw_tracer_cleanup(struct mlx5_fw_tracer *tracer)
 /* Free software resources (Buffers, etc ..) */
 void mlx5_fw_tracer_destroy(struct mlx5_fw_tracer *tracer)
 {
-	if (IS_ERR_OR_NULL(tracer))
+	if (!tracer)
 		return;
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: Destroy\n");
@@ -1204,8 +1202,8 @@ int mlx5_fw_tracer_reload(struct mlx5_fw_tracer *tracer)
 	struct mlx5_core_dev *dev;
 	int err;
 
-	if (IS_ERR_OR_NULL(tracer))
-		return -EINVAL;
+	if (!tracer)
+		return 0;
 
 	dev = tracer->dev;
 	mlx5_fw_tracer_cleanup(tracer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 5d0be9703a48..6ea50a9ef1be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -158,6 +158,13 @@ static int mlx5e_dcbnl_ieee_getets(struct net_device *netdev,
 	}
 	memcpy(ets->tc_tsa, priv->dcbx.tc_tsa, sizeof(ets->tc_tsa));
 
+	/* Report 0 for non ETS TSA */
+	for (i = 0; i < ets->ets_cap; i++) {
+		if (ets->tc_tx_bw[i] == MLX5E_MAX_BW_ALLOC &&
+		    priv->dcbx.tc_tsa[i] != IEEE_8021QAZ_TSA_ETS)
+			ets->tc_tx_bw[i] = 0;
+	}
+
 	return err;
 }
 
@@ -302,6 +309,14 @@ static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
 		}
 	}
 
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_CB_SHAPER) {
+			netdev_err(netdev,
+				   "Failed to validate ETS: CB Shaper is not supported\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* Validate Bandwidth Sum */
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
 		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
index 22f4c1c28006..e1d71e88fad4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
@@ -67,7 +67,7 @@ int esw_egress_acl_vlan_create(struct mlx5_eswitch *esw,
 	flow_act.action = flow_action;
 	vport->egress.allowed_vlan =
 		mlx5_add_flow_rules(vport->egress.acl, spec,
-				    &flow_act, fwd_dest, 0);
+				    &flow_act, fwd_dest, fwd_dest ? 1 : 0);
 	if (IS_ERR(vport->egress.allowed_vlan)) {
 		err = PTR_ERR(vport->egress.allowed_vlan);
 		esw_warn(esw->dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index a2d9904e1049..d2bf20035e20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -208,16 +208,11 @@ static void mlx5_fw_live_patch_event(struct work_struct *work)
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
 						      fw_live_patch_work);
 	struct mlx5_core_dev *dev = fw_reset->dev;
-	struct mlx5_fw_tracer *tracer;
 
 	mlx5_core_info(dev, "Live patch updated firmware version: %d.%d.%d\n", fw_rev_maj(dev),
 		       fw_rev_min(dev), fw_rev_sub(dev));
 
-	tracer = dev->tracer;
-	if (IS_ERR_OR_NULL(tracer))
-		return;
-
-	if (mlx5_fw_tracer_reload(tracer))
+	if (mlx5_fw_tracer_reload(dev->tracer))
 		mlx5_core_err(dev, "Failed to reload FW tracer\n");
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
index ce7492a6a98f..908d99f398b8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
@@ -96,6 +96,9 @@ static int nfp_cpp_resource_find(struct nfp_cpp *cpp, struct nfp_resource *res)
 		res->mutex =
 			nfp_cpp_mutex_alloc(cpp,
 					    NFP_RESOURCE_TBL_TARGET, addr, key);
+		if (!res->mutex)
+			return -ENOMEM;
+
 		res->cpp_id = NFP_CPP_ID(entry.region.cpp_target,
 					 entry.region.cpp_action,
 					 entry.region.cpp_token);
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index e14dd1051e58..f39b7fcfcd38 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6199,10 +6199,10 @@ static void nv_remove(struct pci_dev *pci_dev)
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct fe_priv *np = netdev_priv(dev);
 
-	free_percpu(np->txrx_stats);
-
 	unregister_netdev(dev);
 
+	free_percpu(np->txrx_stats);
+
 	nv_restore_mac_addr(pci_dev);
 
 	/* restore any phy related changes */
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 16c3f32e5ca7..a3103b2ed734 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -113,7 +113,7 @@ static void qede_remove(struct pci_dev *pdev);
 static void qede_shutdown(struct pci_dev *pdev);
 static void qede_link_update(void *dev, struct qed_link_output *link);
 static void qede_schedule_recovery_handler(void *dev);
-static void qede_recovery_handler(struct qede_dev *edev);
+static bool qede_recovery_handler(struct qede_dev *edev);
 static void qede_schedule_hw_err_handler(void *dev,
 					 enum qed_hw_err_type err_type);
 static void qede_get_eth_tlv_data(void *edev, void *data);
@@ -993,21 +993,6 @@ void __qede_unlock(struct qede_dev *edev)
 	mutex_unlock(&edev->qede_lock);
 }
 
-/* This version of the lock should be used when acquiring the RTNL lock is also
- * needed in addition to the internal qede lock.
- */
-static void qede_lock(struct qede_dev *edev)
-{
-	rtnl_lock();
-	__qede_lock(edev);
-}
-
-static void qede_unlock(struct qede_dev *edev)
-{
-	__qede_unlock(edev);
-	rtnl_unlock();
-}
-
 static void qede_periodic_task(struct work_struct *work)
 {
 	struct qede_dev *edev = container_of(work, struct qede_dev,
@@ -1044,6 +1029,8 @@ static void qede_sp_task(struct work_struct *work)
 	 */
 
 	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
+		bool reloaded;
+
 		cancel_delayed_work_sync(&edev->periodic_task);
 #ifdef CONFIG_QED_SRIOV
 		/* SRIOV must be disabled outside the lock to avoid a deadlock.
@@ -1052,9 +1039,17 @@ static void qede_sp_task(struct work_struct *work)
 		if (pci_num_vf(edev->pdev))
 			qede_sriov_configure(edev->pdev, 0);
 #endif
-		qede_lock(edev);
-		qede_recovery_handler(edev);
-		qede_unlock(edev);
+		rtnl_lock();
+		__qede_lock(edev);
+		reloaded = qede_recovery_handler(edev);
+		__qede_unlock(edev);
+
+		/* The udp_tunnel core synchronously calls back into
+		 * qede_udp_tunnel_sync(), which takes the qede lock.
+		 */
+		if (reloaded)
+			udp_tunnel_nic_reset_ntf(edev->ndev);
+		rtnl_unlock();
 	}
 
 	__qede_lock(edev);
@@ -2573,9 +2568,13 @@ static void qede_recovery_failed(struct qede_dev *edev)
 		edev->ops->common->set_power_state(edev->cdev, PCI_D3hot);
 }
 
-static void qede_recovery_handler(struct qede_dev *edev)
+/* Returns true if an open device was successfully reloaded and its
+ * udp_tunnel ports need to be re-synced by the caller.
+ */
+static bool qede_recovery_handler(struct qede_dev *edev)
 {
 	u32 curr_state = edev->state;
+	bool reloaded = false;
 	int rc;
 
 	DP_NOTICE(edev, "Starting a recovery process\n");
@@ -2605,17 +2604,18 @@ static void qede_recovery_handler(struct qede_dev *edev)
 			goto err;
 
 		qede_config_rx_mode(edev->ndev);
-		udp_tunnel_nic_reset_ntf(edev->ndev);
+		reloaded = true;
 	}
 
 	edev->state = curr_state;
 
 	DP_NOTICE(edev, "Recovery handling is done\n");
 
-	return;
+	return reloaded;
 
 err:
 	qede_recovery_failed(edev);
+	return false;
 }
 
 static void qede_atomic_hw_err_handler(struct qede_dev *edev)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 9c745d48f54b..c2333b8224c6 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -599,14 +599,13 @@ static int init_dma_desc_rings(struct net_device *netd)
 
 	return 0;
 
-txalloc_err:
-	while (queue_num--)
-		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
-	return ret;
-
 rxalloc_err:
 	while (queue_num--)
 		free_rx_ring(priv->device, priv->rxq[queue_num], rx_rsize);
+	queue_num = SXGBE_TX_QUEUES;
+txalloc_err:
+	while (queue_num--)
+		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
 	return ret;
 }
 
@@ -1078,7 +1077,9 @@ static int sxgbe_open(struct net_device *dev)
 	priv->dma_buf_sz = SXGBE_ALIGN(DMA_BUFFER_SIZE);
 	priv->tx_tc = TC_DEFAULT;
 	priv->rx_tc = TC_DEFAULT;
-	init_dma_desc_rings(dev);
+	ret = init_dma_desc_rings(dev);
+	if (ret)
+		goto init_phy_error;
 
 	/* DMA initialization and SW reset */
 	ret = sxgbe_init_dma_engine(priv);
@@ -1187,6 +1188,7 @@ static int sxgbe_open(struct net_device *dev)
 
 init_error:
 	free_dma_desc_resources(priv);
+init_phy_error:
 	if (dev->phydev)
 		phy_disconnect(dev->phydev);
 phy_error:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 3539c1542eb8..f5977539129c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -603,6 +603,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4dfe0dfb84e8..3063fbf9dae3 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1751,6 +1751,9 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct geneve_config cfg;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, geneve->net))
+		return -EPERM;
+
 	/* If the geneve device is configured for metadata (or externally
 	 * controlled, for example, OVS), then nothing can be changed.
 	 */
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index d19b5b1c1aca..d07dba76940a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -666,7 +666,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index cbdd01f31162..012c750d4987 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -842,8 +842,8 @@ struct phylink *phylink_create(struct phylink_config *config,
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
-		kfree(pl);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto free_pl;
 	}
 
 	pl->phy_state.interface = iface;
@@ -866,28 +866,29 @@ struct phylink *phylink_create(struct phylink_config *config,
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
 	ret = phylink_parse_mode(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto free_pl;
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 		ret = phylink_parse_fixedlink(pl, fwnode);
-		if (ret < 0) {
-			kfree(pl);
-			return ERR_PTR(ret);
-		}
+		if (ret < 0)
+			goto release_link_gpio;
 	}
 
 	pl->cur_link_an_mode = pl->cfg_link_an_mode;
 
 	ret = phylink_register_sfp(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto release_link_gpio;
 
 	return pl;
+
+release_link_gpio:
+	if (pl->link_gpio)
+		gpiod_put(pl->link_gpio);
+free_pl:
+	kfree(pl);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(phylink_create);
 
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 75114c630b1a..40458af1121b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -899,6 +899,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 	dev_hard_header(skb, dev, ETH_P_PPP_SES,
 			po->pppoe_pa.remote, NULL, total_len);
 
+	ph = pppoe_hdr(skb);
 	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
 
 	ph->length = htons(total_len);
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 369bd30fed35..558bc092c3b9 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -692,6 +692,8 @@ static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	if (!sl || sl->magic != SLIP_MAGIC || !netif_running(sl->dev))
 		return;
 
+	spin_lock_bh(&sl->lock);
+
 	/* Read the characters out of the buffer */
 	while (count--) {
 		if (fp && *fp++) {
@@ -707,6 +709,8 @@ static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 #endif
 			slip_unesc(sl, *cp++);
 	}
+
+	spin_unlock_bh(&sl->lock);
 }
 
 /************************************
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index f3c628a64b95..b670259d9393 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1313,7 +1313,11 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
 	} hdr;
-	BUG_ON(gdesc->rcd.tcp == 0);
+
+	/* v4/v6/tcp then describe the inner header, which we can't locate. */
+	if ((le32_to_cpu(gdesc->dword[0]) & (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)) ||
+	    gdesc->rcd.tcp == 0)
+		return 0;
 
 	maplen = skb_headlen(skb);
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
@@ -1327,15 +1331,21 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		if (hdr.eth->h_proto != htons(ETH_P_IP) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP))
+			return 0;
+
 		hdr.ptr += hlen;
-		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
+		if (hdr.ipv4->protocol != IPPROTO_TCP)
+			return 0;
+
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		if (hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6))
+			return 0;
+
 		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 053cc74bd904..8dad17023e36 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2239,7 +2239,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct iphdr *pip;
 
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
 			return false;
 		pip = ip_hdr(skb);
 		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
@@ -2265,7 +2265,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		 */
 		if (!ipv6_stub->nd_tbl)
 			return false;
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
 		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
@@ -2287,13 +2287,19 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	if (n) {
+		u8 haddr[ETH_ALEN];
 		bool diff;
 
-		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
+		neigh_ha_snapshot(haddr, n, dev);
+		diff = !ether_addr_equal_unaligned(eth_hdr(skb)->h_dest, haddr);
 		if (diff) {
+			if (skb_cow_head(skb, 0)) {
+				neigh_release(n);
+				return false;
+			}
 			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
 				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
+			memcpy(eth_hdr(skb)->h_dest, haddr, dev->addr_len);
 		}
 		neigh_release(n);
 		return diff;
@@ -2940,6 +2946,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
 		did_rsc = route_shortcircuit(dev, skb);
+		eth = eth_hdr(skb);
 		if (did_rsc)
 			f = vxlan_find_mac(vxlan, eth->h_dest, vni);
 	}
@@ -4255,6 +4262,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
+		return -EPERM;
+
 	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
@@ -4305,7 +4315,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
 	}
 
-	if (conf.age_interval != vxlan->cfg.age_interval)
+	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
 	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index a83133388de9..006862688e7d 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -521,7 +521,8 @@ static void wanxl_pci_remove_one(struct pci_dev *pdev)
 	if (card->irq)
 		free_irq(card->irq, card);
 
-	wanxl_reset(card);
+	if (card->plx)
+		wanxl_reset(card);
 
 	for (i = 0; i < RX_QUEUE_LENGTH; i++)
 		if (card->rx_skbs[i]) {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 720c94806e1a..54edf4a61c61 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4441,6 +4441,9 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
 	msdu_details = &msdu_link->msdu_link[0];
 
 	for (i = 0; i < HAL_RX_NUM_MSDU_DESC; i++) {
+		if (!i && FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
+				    msdu_details[i].buf_addr_info.info0) == 0)
+			break;
 		if (FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
 			      msdu_details[i].buf_addr_info.info0) == 0) {
 			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index b22ed499f7ba..5be0c62ec019 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1722,13 +1722,15 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
 
 	rxtid = &aggr_conn->rx_tid[tid];
 
-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
-		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
-			   __func__, win_sz, tid);
-
 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);
 
+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
+		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
+			   __func__, win_sz, tid);
+		return;
+	}
+
 	rxtid->seq_next = seq_no;
 	hold_q_size = TID_WINDOW_SZ(win_sz) * sizeof(struct skb_hold_q);
 	rxtid->hold_q = kzalloc(hold_q_size, GFP_KERNEL);
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 5bacddee8344..7aa4de770f66 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -484,6 +484,18 @@ static int ath6kl_wmi_tx_complete_event_rx(u8 *datap, int len)
 
 	evt = (struct wmi_tx_complete_event *) datap;
 
+	if (len < sizeof(*evt)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d\n",
+			   len);
+		return -EINVAL;
+	}
+
+	if (len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
+			   len, evt->num_msg);
+		return -EINVAL;
+	}
+
 	ath6kl_dbg(ATH6KL_DBG_WMI, "comp: %d %d %d\n",
 		   evt->num_msg, evt->msg_len, evt->msg_type);
 
@@ -862,6 +874,14 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
 
 	ev = (struct wmi_connect_event *) datap;
 
+	if (len < sizeof(*ev) + ev->beacon_ie_len +
+	    ev->assoc_req_len + ev->assoc_resp_len) {
+		ath6kl_dbg(ATH6KL_DBG_WMI,
+			   "connect event: IE lengths %u+%u+%u exceed buffer %d\n",
+			   ev->beacon_ie_len, ev->assoc_req_len,
+			   ev->assoc_resp_len, len);
+		return -EINVAL;
+	}
 	if (vif->nw_type == AP_NETWORK) {
 		/* AP mode start/STA connected event */
 		struct net_device *dev = vif->ndev;
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 6c73c0c0b82a..7650f14dca8d 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1227,15 +1227,10 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 	ret = request_firmware_nowait(THIS_MODULE, true, hif_dev->fw_name,
 				      &hif_dev->udev->dev, GFP_KERNEL,
 				      hif_dev, ath9k_hif_usb_firmware_cb);
-	if (ret) {
+	if (ret)
 		dev_err(&hif_dev->udev->dev,
 			"ath9k_htc: Async request for firmware %s failed\n",
 			hif_dev->fw_name);
-		return ret;
-	}
-
-	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
-		 hif_dev->fw_name);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 908c4c8b7f82..bda30b1f9404 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(u32, len - 4, ar->readlen));
 
 		ar->readbuf = NULL;
 	}
@@ -917,7 +918,9 @@ static void carl9170_rx_stream(struct ar9170 *ar, void *buf, unsigned int len)
 				}
 			}
 
-			skb_put_data(ar->rx_failover, tbuf, tlen);
+			skb_put_data(ar->rx_failover, tbuf,
+				     min_t(unsigned int, tlen,
+					   ar->rx_failover_missing));
 			ar->rx_failover_missing -= tlen;
 
 			if (ar->rx_failover_missing <= 0) {
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 43050dc7b98d..743c088dffb0 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -692,7 +692,7 @@ void carl9170_tx_process_status(struct ar9170 *ar,
 	unsigned int i;
 
 	for (i = 0;  i < cmd->hdr.ext; i++) {
-		if (WARN_ON(i > ((cmd->hdr.len / 2) + 1))) {
+		if (WARN_ON(i >= (cmd->hdr.len / 2))) {
 			print_hex_dump_bytes("UU:", DUMP_PREFIX_NONE,
 					     (void *) cmd, cmd->hdr.len + 4);
 			break;
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 706de33d0ed4..adfcd0fdb05f 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -1527,13 +1527,16 @@ static inline int at76_guess_freq(struct at76_priv *priv)
 
 	if (ieee80211_is_probe_resp(hdr->frame_control)) {
 		el_off = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
-		el = ((struct ieee80211_mgmt *)hdr)->u.probe_resp.variable;
 	} else if (ieee80211_is_beacon(hdr->frame_control)) {
 		el_off = offsetof(struct ieee80211_mgmt, u.beacon.variable);
-		el = ((struct ieee80211_mgmt *)hdr)->u.beacon.variable;
 	} else {
 		goto exit;
 	}
+
+	if (len < el_off)
+		goto exit;
+
+	el = priv->rx_skb->data + el_off;
 	len -= el_off;
 
 	el = cfg80211_find_ie(WLAN_EID_DS_PARAMS, el, len);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4434e9a7eba0..3f6d4299965b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1790,7 +1790,7 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 				 sme->crypto.cipher_group);
 			return -EINVAL;
 		}
-	} else if (val & (WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED)) {
+	} else if (val & (WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED | WPA2_AUTH_1X_SHA256)) {
 		switch (sme->crypto.akm_suites[0]) {
 		case WLAN_AKM_SUITE_8021X:
 			val = WPA2_AUTH_UNSPECIFIED;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 0f5431e4ac20..6152c83f721c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1246,16 +1246,20 @@ static int brcmf_pcie_init_ringbuffers(struct brcmf_pciedev_info *devinfo)
 static void
 brcmf_pcie_release_scratchbuffers(struct brcmf_pciedev_info *devinfo)
 {
-	if (devinfo->shared.scratch)
+	if (devinfo->shared.scratch) {
 		dma_free_coherent(&devinfo->pdev->dev,
 				  BRCMF_DMA_D2H_SCRATCH_BUF_LEN,
 				  devinfo->shared.scratch,
 				  devinfo->shared.scratch_dmahandle);
-	if (devinfo->shared.ringupd)
+		devinfo->shared.scratch = NULL;
+	}
+	if (devinfo->shared.ringupd) {
 		dma_free_coherent(&devinfo->pdev->dev,
 				  BRCMF_DMA_D2H_RINGUPD_BUF_LEN,
 				  devinfo->shared.ringupd,
 				  devinfo->shared.ringupd_dmahandle);
+		devinfo->shared.ringupd = NULL;
+	}
 }
 
 static int brcmf_pcie_init_scratchbuffers(struct brcmf_pciedev_info *devinfo)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6ac2132c3064..5338d93e5b22 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4438,6 +4438,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
 	skb_queue_head_init(&bus->glom);
+	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
 	bus->txbound = BRCMF_TXBOUND;
 	bus->rxbound = BRCMF_RXBOUND;
 	bus->txminmax = BRCMF_TXMINMAX;
@@ -4451,7 +4452,6 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
-	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 23fbddd0c1f8..a46ecfa07ba2 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6183,6 +6183,8 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_enable_device.\n");
+		free_libipw(dev, 0);
+		pci_iounmap(pci_dev, ioaddr);
 		return err;
 	}
 
@@ -6195,16 +6197,14 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_set_dma_mask.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	err = pci_request_regions(pci_dev, DRV_NAME);
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_request_regions.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	/* We disable the RETRY_TIMEOUT register (0x41) to keep
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 6333b1000f92..303badbd53d9 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -503,11 +503,19 @@ static void p54_rx_eeprom_readback(struct p54_common *priv,
 		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
 			return;
 
+		if (eeprom->v2.data + priv->eeprom_slice_size >
+		    skb_tail_pointer(skb))
+			return;
+
 		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
 	} else {
 		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
 			return;
 
+		if (eeprom->v1.data + priv->eeprom_slice_size >
+		    skb_tail_pointer(skb))
+			return;
+
 		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
 	}
 
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 865bbe029343..02c31f7fcfd1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -311,6 +311,12 @@ static struct net_device *hwsim_mon; /* global monitor netdev */
 	.hw_value = (_freq), \
 }
 
+#define CHAN6G(_freq) { \
+	.band = NL80211_BAND_6GHZ, \
+	.center_freq = (_freq), \
+	.hw_value = (_freq), \
+}
+
 static const struct ieee80211_channel hwsim_channels_2ghz[] = {
 	CHAN2G(2412), /* Channel 1 */
 	CHAN2G(2417), /* Channel 2 */
@@ -377,6 +383,68 @@ static const struct ieee80211_channel hwsim_channels_5ghz[] = {
 	CHAN5G(5925), /* Channel 185 */
 };
 
+static const struct ieee80211_channel hwsim_channels_6ghz[] = {
+	CHAN6G(5955), /* Channel 1 */
+	CHAN6G(5975), /* Channel 5 */
+	CHAN6G(5995), /* Channel 9 */
+	CHAN6G(6015), /* Channel 13 */
+	CHAN6G(6035), /* Channel 17 */
+	CHAN6G(6055), /* Channel 21 */
+	CHAN6G(6075), /* Channel 25 */
+	CHAN6G(6095), /* Channel 29 */
+	CHAN6G(6115), /* Channel 33 */
+	CHAN6G(6135), /* Channel 37 */
+	CHAN6G(6155), /* Channel 41 */
+	CHAN6G(6175), /* Channel 45 */
+	CHAN6G(6195), /* Channel 49 */
+	CHAN6G(6215), /* Channel 53 */
+	CHAN6G(6235), /* Channel 57 */
+	CHAN6G(6255), /* Channel 61 */
+	CHAN6G(6275), /* Channel 65 */
+	CHAN6G(6295), /* Channel 69 */
+	CHAN6G(6315), /* Channel 73 */
+	CHAN6G(6335), /* Channel 77 */
+	CHAN6G(6355), /* Channel 81 */
+	CHAN6G(6375), /* Channel 85 */
+	CHAN6G(6395), /* Channel 89 */
+	CHAN6G(6415), /* Channel 93 */
+	CHAN6G(6435), /* Channel 97 */
+	CHAN6G(6455), /* Channel 181 */
+	CHAN6G(6475), /* Channel 105 */
+	CHAN6G(6495), /* Channel 109 */
+	CHAN6G(6515), /* Channel 113 */
+	CHAN6G(6535), /* Channel 117 */
+	CHAN6G(6555), /* Channel 121 */
+	CHAN6G(6575), /* Channel 125 */
+	CHAN6G(6595), /* Channel 129 */
+	CHAN6G(6615), /* Channel 133 */
+	CHAN6G(6635), /* Channel 137 */
+	CHAN6G(6655), /* Channel 141 */
+	CHAN6G(6675), /* Channel 145 */
+	CHAN6G(6695), /* Channel 149 */
+	CHAN6G(6715), /* Channel 153 */
+	CHAN6G(6735), /* Channel 157 */
+	CHAN6G(6755), /* Channel 161 */
+	CHAN6G(6775), /* Channel 165 */
+	CHAN6G(6795), /* Channel 169 */
+	CHAN6G(6815), /* Channel 173 */
+	CHAN6G(6835), /* Channel 177 */
+	CHAN6G(6855), /* Channel 181 */
+	CHAN6G(6875), /* Channel 185 */
+	CHAN6G(6895), /* Channel 189 */
+	CHAN6G(6915), /* Channel 193 */
+	CHAN6G(6935), /* Channel 197 */
+	CHAN6G(6955), /* Channel 201 */
+	CHAN6G(6975), /* Channel 205 */
+	CHAN6G(6995), /* Channel 209 */
+	CHAN6G(7015), /* Channel 213 */
+	CHAN6G(7035), /* Channel 217 */
+	CHAN6G(7055), /* Channel 221 */
+	CHAN6G(7075), /* Channel 225 */
+	CHAN6G(7095), /* Channel 229 */
+	CHAN6G(7115), /* Channel 233 */
+};
+
 #define NUM_S1G_CHANS_US 51
 static struct ieee80211_channel hwsim_channels_s1g[NUM_S1G_CHANS_US];
 
@@ -548,6 +616,7 @@ struct mac80211_hwsim_data {
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
 	struct ieee80211_channel channels_2ghz[ARRAY_SIZE(hwsim_channels_2ghz)];
 	struct ieee80211_channel channels_5ghz[ARRAY_SIZE(hwsim_channels_5ghz)];
+	struct ieee80211_channel channels_6ghz[ARRAY_SIZE(hwsim_channels_6ghz)];
 	struct ieee80211_channel channels_s1g[ARRAY_SIZE(hwsim_channels_s1g)];
 	struct ieee80211_rate rates[ARRAY_SIZE(hwsim_rates)];
 	struct ieee80211_iface_combination if_combination;
@@ -579,7 +648,8 @@ struct mac80211_hwsim_data {
 		struct ieee80211_channel *channel;
 		unsigned long next_start, start, end;
 	} survey_data[ARRAY_SIZE(hwsim_channels_2ghz) +
-		      ARRAY_SIZE(hwsim_channels_5ghz)];
+		      ARRAY_SIZE(hwsim_channels_5ghz) +
+		      ARRAY_SIZE(hwsim_channels_6ghz)];
 
 	struct ieee80211_channel *channel;
 	u64 beacon_int	/* beacon interval in us */;
@@ -3187,6 +3257,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		sizeof(hwsim_channels_2ghz));
 	memcpy(data->channels_5ghz, hwsim_channels_5ghz,
 		sizeof(hwsim_channels_5ghz));
+	memcpy(data->channels_6ghz, hwsim_channels_6ghz,
+		sizeof(hwsim_channels_6ghz));
 	memcpy(data->channels_s1g, hwsim_channels_s1g,
 	       sizeof(hwsim_channels_s1g));
 	memcpy(data->rates, hwsim_rates, sizeof(hwsim_rates));
@@ -4263,6 +4335,7 @@ static void hwsim_virtio_rx_work(struct work_struct *work)
 
 	skb->data = skb->head;
 	skb_reset_tail_pointer(skb);
+	len = min(len, skb_end_offset(skb));
 	skb_put(skb, len);
 	hwsim_virtio_handle_cmd(skb);
 
diff --git a/drivers/net/wireless/marvell/libertas/firmware.c b/drivers/net/wireless/marvell/libertas/firmware.c
index f124110944b7..9bf7d4c207b9 100644
--- a/drivers/net/wireless/marvell/libertas/firmware.c
+++ b/drivers/net/wireless/marvell/libertas/firmware.c
@@ -78,6 +78,7 @@ static void helper_firmware_cb(const struct firmware *firmware, void *context)
 	} else {
 		/* No main firmware needed for this helper --> success! */
 		lbs_fw_loaded(priv, 0, firmware, NULL);
+		release_firmware(firmware);
 	}
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index c053a5419e19..561804026528 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -56,7 +56,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 			    ntohs(rx_hdr->eth803_hdr.h_proto) == ETH_P_TDLS) {
 				mwifiex_process_tdls_action_frame(priv,
 								  (u8 *)rx_hdr,
-								  skb->len);
+								  rx_skb->len);
 			}
 
 			if (priv->bss_role == MWIFIEX_BSS_ROLE_UAP)
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 6c60621b6ccc..d503db3789c5 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -215,7 +215,7 @@ mwifiex_tdls_add_ht_oper(struct mwifiex_private *priv, const u8 *mac,
 
 	/* follow AP's channel bandwidth */
 	if (ISSUPP_CHANWIDTH40(priv->adapter->hw_dot_11n_dev_cap) &&
-	    bss_desc->bcn_ht_cap &&
+	    bss_desc->bcn_ht_oper &&
 	    ISALLOWED_CHANWIDTH40(bss_desc->bcn_ht_oper->ht_param))
 		ht_oper->ht_param = bss_desc->bcn_ht_oper->ht_param;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 9121447e2701..eebfc0eaf905 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -135,11 +135,31 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 				len = ETH_ALEN;
 
 			if (len != -1) {
+				u16 evt_len = le16_to_cpu(event->len);
+
 				sinfo->assoc_req_ies = &event->data[len];
 				len = (u8 *)sinfo->assoc_req_ies -
 				      (u8 *)&event->frame_control;
-				sinfo->assoc_req_ies_len =
-					le16_to_cpu(event->len) - (u16)len;
+
+				/*
+				 * event->len is reported by the device firmware
+				 * and is not otherwise validated.  Reject a
+				 * length that underflows the header, or that
+				 * would place the association request IEs
+				 * outside the fixed-size event_body[] buffer the
+				 * event was copied into; otherwise the IE walk
+				 * in mwifiex_set_sta_ht_cap() reads past
+				 * event_body and out of the adapter slab object.
+				 */
+				if (evt_len < len ||
+				    (u8 *)&event->frame_control + evt_len >
+				    adapter->event_body + MAX_EVENT_SIZE) {
+					mwifiex_dbg(adapter, ERROR,
+						    "invalid STA assoc event length\n");
+					kfree(sinfo);
+					return -1;
+				}
+				sinfo->assoc_req_ies_len = evt_len - (u16)len;
 			}
 		}
 		cfg80211_new_sta(priv->netdev, event->sta_addr, sinfo,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4364f73b501d..0c9201e073b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1492,6 +1492,10 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
+		if (!mt76_is_mmio(mdev)) {
+			dev_kfree_skb(skb);
+			break;
+		}
 		mt7615_mac_tx_free(dev, skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 464072535541..16fb59f3b85c 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -582,6 +582,11 @@ static s32 wilc_parse_assoc_resp_info(u8 *buffer, u32 buffer_len,
 	u16 ies_len;
 	struct wilc_assoc_resp *res = (struct wilc_assoc_resp *)buffer;
 
+	if (buffer_len < sizeof(*res)) {
+		ret_conn_info->status = WLAN_STATUS_UNSPECIFIED_FAILURE;
+		return -EINVAL;
+	}
+
 	ret_conn_info->status = le16_to_cpu(res->status_code);
 	if (ret_conn_info->status == WLAN_STATUS_SUCCESS) {
 		ies = &buffer[sizeof(*res)];
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3d9a830950ef..27d001fd8821 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1227,8 +1227,10 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED)) {
+			cmd->req.cqe->status = NVME_SC_CMD_SEQ_ERROR;
 			nvmet_req_uninit(&cmd->req);
+		}
 		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index b8ccac6f3146..a3e24e816f78 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -52,7 +52,7 @@
 #define L0_TM_DIG_6			0x106c
 #define L0_TM_DIS_DESCRAMBLE_DECODER	0x0f
 #define L0_TX_DIG_61			0x00f4
-#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0f
+#define L0_TM_DISABLE_SCRAMBLE_ENCODER	(BIT(3) | GENMASK(1, 0))
 
 /* PLL Test Mode register parameters */
 #define L0_TM_PLL_DIG_37		0x2094
@@ -410,11 +410,30 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 	}
 }
 
-/* Bypass (de)scrambler and 8b/10b decoder and encoder. */
-static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
+/**
+ * xpsgtr_bypass_scrambler_8b10b - Configure scrambler/encoder behavior
+ * @gtr_phy: pointer to lane context
+ * @bypass: true to enable scrambler/encoder bypass (SATA/SGMII),
+ *          false to disable scrambler/encoder bypass (USB3)
+ *
+ * Uses RMW to preserve reserved and unrelated register fields.
+ */
+static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy,
+					  bool bypass)
 {
-	xpsgtr_write_phy(gtr_phy, L0_TM_DIG_6, L0_TM_DIS_DESCRAMBLE_DECODER);
-	xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61, L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	if (bypass) {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER,
+				   L0_TM_DIS_DESCRAMBLE_DECODER);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	} else {
+		xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+				   L0_TM_DIS_DESCRAMBLE_DECODER, 0);
+		xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+				   L0_TM_DISABLE_SCRAMBLE_ENCODER, 0);
+	}
 }
 
 /* DP-specific initialization. */
@@ -435,7 +454,7 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy *gtr_phy)
 {
 	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 
 	writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
 }
@@ -451,7 +470,7 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
 	xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
 
-	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
+	xpsgtr_bypass_scrambler_8b10b(gtr_phy, true);
 }
 
 /* Configure TX de-emphasis and margining for DP. */
@@ -604,6 +623,10 @@ static int xpsgtr_phy_init(struct phy *phy)
 	case ICM_PROTOCOL_SGMII:
 		xpsgtr_phy_init_sgmii(gtr_phy);
 		break;
+
+	case ICM_PROTOCOL_USB:
+		xpsgtr_bypass_scrambler_8b10b(gtr_phy, false);
+		break;
 	}
 
 out:
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 72c27181a427..ee01c9e2aad6 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -115,6 +115,7 @@ config PINCTRL_BM1880
 	depends on OF && (ARCH_BITMAIN || COMPILE_TEST)
 	default ARCH_BITMAIN
 	select PINMUX
+	select GENERIC_PINCONF
 	help
 	  Pinctrl driver for Bitmain BM1880 SoC.
 
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index d9279fc7be83..2898fdfdffd2 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -69,6 +69,10 @@ static int dt_remember_or_free_map(struct pinctrl *p, const char *statename,
 	int i;
 	struct pinctrl_dt_map *dt_map;
 
+	/* Initialize dev_name before any allocation can fail */
+	for (i = 0; i < num_maps; i++)
+		map[i].dev_name = NULL;
+
 	/* Initialize common mapping table entry fields */
 	for (i = 0; i < num_maps; i++) {
 		const char *devname;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 99b1b01e23e9..07845b6e09a2 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -333,7 +333,7 @@ static int dasd_ioctl_check_format(struct block_device *bdev, void __user *argp)
 static int dasd_release_space(struct dasd_device *device,
 			      struct format_data_t *rdata)
 {
-	if (!device->discipline->is_ese && !device->discipline->is_ese(device))
+	if (!device->discipline->is_ese || !device->discipline->is_ese(device))
 		return -ENOTSUPP;
 	if (!device->discipline->release_space)
 		return -ENOTSUPP;
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index d8046e589742..7875519491db 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -943,7 +943,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   const u8 *clr_key_value,
 			   int clr_key_bit_size,
 			   u8 *key_token,
-			   int *key_token_size)
+			   int *key_token_size,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1084,7 +1085,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, 0);
+	free_cprbmem(mem, PARMBSIZE, scrub);
 	return rc;
 }
 
@@ -1127,7 +1128,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1135,7 +1137,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize);
+			     clrkey, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1143,7 +1146,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1151,7 +1155,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize);
+			     NULL, keybitsize, token, &tokensize,
+			     true);
 	if (rc) {
 		DEBUG_ERR(
 			"%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
@@ -1169,7 +1174,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
-	kfree(token);
+	memzero_explicit(exorbuf, sizeof(exorbuf));
+	kfree_sensitive(token);
 	return rc;
 }
 EXPORT_SYMBOL(cca_clr2cipherkey);
@@ -1229,6 +1235,9 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	} __packed * prepparm;
 	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
 
+	if (keytoklen > PARMBSIZE - sizeof(struct aureqparm))
+		return -EINVAL;
+
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
 	if (rc)
@@ -1395,6 +1404,9 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	} __packed * prepparm;
 	int keylen = ((struct eccprivkeytoken *)key)->len;
 
+	if (keylen > PARMBSIZE - sizeof(struct aureqparm))
+		return -EINVAL;
+
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem, &preqcblk, &prepcblk);
 	if (rc)
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 36c2bd2016f2..d472d0ea7957 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -254,6 +254,7 @@ static int zfcp_allocate_low_mem_buffers(struct zfcp_adapter *adapter)
 static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
 {
 	mempool_destroy(adapter->pool.erp_req);
+	mempool_destroy(adapter->pool.gid_pn_req);
 	mempool_destroy(adapter->pool.scsi_req);
 	mempool_destroy(adapter->pool.scsi_abort);
 	mempool_destroy(adapter->pool.qtcb_pool);
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 7e82ddce5031..8cd20cc9809f 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -840,7 +840,7 @@ static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 		}
 
 		senselen = get_unaligned_be16(data);
-		if (datalen < senselen)
+		if (datalen < senselen + 2)
 			goto invalid_datalen;
 
 		memcpy(sc->sense_buffer, data + 2,
diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index 83f14b2c8804..0aa883ab6ff0 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -722,13 +722,6 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 		rc = __iscsi_complete_pdu(conn, hdr, NULL, 0);
 		spin_unlock(&conn->session->back_lock);
 		break;
-	case ISCSI_OP_SCSI_CMD_RSP:
-		if (tcp_conn->in.datalen) {
-			iscsi_tcp_data_recv_prep(tcp_conn);
-			return 0;
-		}
-		rc = iscsi_complete_pdu(conn, hdr, NULL, 0);
-		break;
 	case ISCSI_OP_R2T:
 		spin_lock(&conn->session->back_lock);
 		task = iscsi_itt_to_ctask(conn, hdr->itt);
@@ -745,6 +738,7 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 		} else
 			rc = ISCSI_ERR_PROTO;
 		break;
+	case ISCSI_OP_SCSI_CMD_RSP:
 	case ISCSI_OP_LOGIN_RSP:
 	case ISCSI_OP_TEXT_RSP:
 	case ISCSI_OP_REJECT:
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7cfc6db81763..c3cbaeb514fc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -3004,8 +3004,8 @@ static bool comp_write_worker(struct sdeb_store_info *sip, u64 lba, u32 num,
 	if (!res)
 		return res;
 	if (rest)
-		res = memcmp(fsp, arr + ((num - rest) * lb_size),
-			     rest * lb_size);
+		res = !memcmp(fsp, arr + ((num - rest) * lb_size),
+			      rest * lb_size);
 	if (!res)
 		return res;
 	if (compare_only)
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 580fdcbcd9b6..2bf8cc137d31 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -751,8 +751,12 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 	struct spi_transfer *xfer = dspi->cur_transfer;
 	bool odd = !!(dspi->len & 1);
 
-	/* No accel for frames not multiple of 8 bits at the moment */
-	if (xfer->bits_per_word % 8)
+	/*
+	 * No accel for DMA transfers or frames not multiples of 8 bits at the
+	 * moment.
+	 */
+	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE ||
+	    xfer->bits_per_word % 8)
 		goto no_accel;
 
 	if (!odd && dspi->len <= dspi->devtype_data->fifo_size * 2) {
@@ -761,10 +765,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 		dspi->oper_bits_per_word = 8;
 	} else {
 		/* Start off with maximum supported by hardware */
-		if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-			dspi->oper_bits_per_word = 32;
-		else
-			dspi->oper_bits_per_word = 16;
+		dspi->oper_bits_per_word = 32;
 
 		/*
 		 * And go down only if the buffer can't be sent with
diff --git a/drivers/staging/comedi/drivers/comedi_parport.c b/drivers/staging/comedi/drivers/comedi_parport.c
index 9361b2dcf949..1a7dd9c186ad 100644
--- a/drivers/staging/comedi/drivers/comedi_parport.c
+++ b/drivers/staging/comedi/drivers/comedi_parport.c
@@ -211,6 +211,13 @@ static irqreturn_t parport_interrupt(int irq, void *d)
 	struct comedi_subdevice *s = dev->read_subdev;
 	unsigned int ctrl;
 
+	/*
+	 * Check device is fully attached.  Device interrupts should have
+	 * been disabled, but do this in case of bad hardware.
+	 */
+	if (!dev->attached)
+		return IRQ_NONE;
+
 	ctrl = inb(dev->iobase + PARPORT_CTRL_REG);
 	if (!(ctrl & PARPORT_CTRL_IRQ_ENA))
 		return IRQ_NONE;
@@ -231,6 +238,9 @@ static int parport_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
+	outb(0, dev->iobase + PARPORT_DATA_REG);
+	outb(0, dev->iobase + PARPORT_CTRL_REG);
+
 	if (it->options[1]) {
 		ret = request_irq(it->options[1], parport_interrupt, 0,
 				  dev->board_name, dev);
@@ -286,9 +296,6 @@ static int parport_attach(struct comedi_device *dev,
 		s->cancel	= parport_intr_cancel;
 	}
 
-	outb(0, dev->iobase + PARPORT_DATA_REG);
-	outb(0, dev->iobase + PARPORT_CTRL_REG);
-
 	return 0;
 }
 
diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 7a818ca15b37..b01961fdf26a 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -897,7 +897,7 @@ static int vdec_open(struct file *file)
 
 	ret = vdec_init_ctrls(sess);
 	if (ret)
-		goto err_m2m_release;
+		goto err_m2m_ctx_release;
 
 	sess->pixfmt_cap = formats[0].pixfmts_cap[0];
 	sess->fmt_out = &formats[0];
@@ -922,6 +922,8 @@ static int vdec_open(struct file *file)
 
 	return 0;
 
+err_m2m_ctx_release:
+	v4l2_m2m_ctx_release(sess->m2m_ctx);
 err_m2m_release:
 	v4l2_m2m_release(sess->m2m_dev);
 err_free_sess:
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index d761ee3f33e5..f780987b2f68 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -332,6 +332,7 @@ static int cedrus_open(struct file *file)
 err_ctrls:
 	v4l2_ctrl_handler_free(&ctx->hdl);
 err_free:
+	v4l2_fh_exit(&ctx->fh);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
 
@@ -451,7 +452,7 @@ static int cedrus_probe(struct platform_device *pdev)
 	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
-		goto err_m2m;
+		goto err_media;
 	}
 
 	v4l2_info(&dev->v4l2_dev,
@@ -477,7 +478,8 @@ static int cedrus_probe(struct platform_device *pdev)
 	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
 err_video:
 	video_unregister_device(&dev->vfd);
-err_m2m:
+err_media:
+	media_device_cleanup(&dev->mdev);
 	v4l2_m2m_release(dev->m2m_dev);
 err_v4l2:
 	v4l2_device_unregister(&dev->v4l2_dev);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index d3e26bfe6c90..712c89d64650 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -190,6 +190,9 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 		u8 dpb_idx;
 
 		dpb_idx = ref_list[i].index;
+		if (dpb_idx >= V4L2_H264_NUM_DPB_ENTRIES)
+			continue;
+
 		dpb = &decode->dpb[dpb_idx];
 
 		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 560d8b368124..f4a19a112014 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -76,8 +76,8 @@ static int tegra_get_format_idx_by_code(struct tegra_vi *vi,
 static u32 tegra_get_format_fourcc_by_idx(struct tegra_vi *vi,
 					  unsigned int index)
 {
-	if (index >= vi->soc->nformats)
-		return -EINVAL;
+	if (WARN_ON_ONCE(index >= vi->soc->nformats))
+		return vi->soc->video_formats[0].fourcc;
 
 	return vi->soc->video_formats[index].fourcc;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index f27044a14182..3f2ee8b34e25 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -379,6 +379,9 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 		pbuf = rtw_get_ie(pbuf, _WPA_IE_ID_, &len, limit_new);
 
 		if (pbuf) {
+			if (len < 6)
+				goto check_next_ie;
+
 			/* check if oui matches... */
 			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type))) {
 				goto check_next_ie;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 45cb2265bd1b..1d2c6cce2c59 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2451,6 +2451,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 
 	/* Skip the ratio tap header */
 	skb_pull(skb, rtap_len);
+	if (skb->len < dot11_hdr_len)
+		goto fail;
 
 	dot11_hdr = (struct ieee80211_hdr *)skb->data;
 	frame_control = le16_to_cpu(dot11_hdr->frame_control);
@@ -2463,6 +2465,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 			qos_len = 2;
 		if ((frame_control & 0x0300) == 0x0300)
 			dot11_hdr_len += 6;
+		if (skb->len < dot11_hdr_len + qos_len + snap_len)
+			goto fail;
 
 		memcpy(dst_mac_addr, dot11_hdr->addr1, sizeof(dst_mac_addr));
 		memcpy(src_mac_addr, dot11_hdr->addr2, sizeof(src_mac_addr));
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 0c8471be3e32..2e19f630e81f 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -367,9 +367,16 @@ static int tb_drom_parse_entry_port(struct tb_switch *sw,
 			return -EIO;
 		}
 		port->link_nr = entry->link_nr;
-		if (entry->has_dual_link_port)
+		if (entry->has_dual_link_port) {
+			if (entry->dual_link_port_nr > sw->config.max_port_number) {
+				tb_sw_warn(sw,
+					"port entry has invalid dual link port number %u\n",
+					entry->dual_link_port_nr);
+				return -EIO;
+			}
 			port->dual_link_port =
 				&port->sw->ports[entry->dual_link_port_nr];
+		}
 	}
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 04d8c6dd619f..b0d4a5b489f9 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -195,11 +195,12 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (dma->rx_running) {
-		dmaengine_pause(dma->rxchan);
-		__dma_rx_complete(p);
-		dmaengine_terminate_async(dma->rxchan);
-	}
+	if (!dma || !dma->rxchan || !dma->rx_running)
+		return;
+
+	dmaengine_pause(dma->rxchan);
+	__dma_rx_complete(p);
+	dmaengine_terminate_async(dma->rxchan);
 }
 EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
@@ -308,6 +309,7 @@ void serial8250_release_dma(struct uart_8250_port *p)
 
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
+	dma->rx_running = 0;
 	dma_free_coherent(dma->rxchan->device->dev, dma->rx_size, dma->rx_buf,
 			  dma->rx_addr);
 	dma_release_channel(dma->rxchan);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1c60976b2f86..1f0b93126f69 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1367,7 +1367,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
 	int rc;
 
-	tty = vc->port.tty;
+	tty = tty_port_tty_get(&vc->port);
 
 	if (tty && (!tty->driver_data)) {
 		/* No driver data? Strange. Okay we fix it then. */
@@ -1430,9 +1430,12 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 		 * characters get aren't echoed locally. This makes key repeat
 		 * usable with slow applications and under heavy loads.
 		 */
+		tty_kref_put(tty);
 		return;
 	}
 
+	tty_kref_put(tty);
+
 	param.shift = shift_final = (shift_state | kbd->slockstate) ^ kbd->lockstate;
 	param.ledstate = kbd->ledflagstate;
 	key_map = key_maps[shift_final];
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index b62ab122fb4a..72f9da6ee094 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -408,6 +408,8 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 	/* this could be folded into KDSKBMODE, but for compatibility
 	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
 	case KDSKBMETA:
+		if (!perm)
+			return -EPERM;
 		return vt_do_kdskbmeta(console, arg);
 
 	case KDGKBMETA:
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 65a1bfc62ae6..6eea24dde2ac 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -700,6 +700,8 @@ static int cxacru_cm(struct cxacru_data *instance, enum cxacru_cm_request cm,
 	ret = offd;
 	usb_dbg(instance->usbatm, "cm %#x\n", cm);
 fail:
+	if (ret < 0)
+		usb_kill_urb(instance->rcv_urb);
 	mutex_unlock(&instance->cm_serialize);
 err:
 	return ret;
diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 661820041ca7..6a282400027d 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2591,6 +2591,7 @@ static struct usbatm_driver uea_usbatm_driver = {
 static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *usb = interface_to_usbdev(intf);
+	bool single_iface = usb->config->desc.bNumInterfaces == 1;
 	int ret;
 
 	uea_enters(usb);
@@ -2600,6 +2601,22 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		le16_to_cpu(usb->descriptor.bcdDevice),
 		chip_name[UEA_CHIP_VERSION(id)]);
 
+	/*
+	 * uea_probe() decides between the pre-firmware and post-firmware case
+	 * from the USB id and stores a different object as interface data in
+	 * each case: a struct completion for a pre-firmware device, a struct
+	 * usbatm_data for a post-firmware one. uea_disconnect() instead tells
+	 * the two apart by the number of interfaces (a pre-firmware device
+	 * exposes a single interface, ADI930 has 2 and eagle has 3). A crafted
+	 * device advertising a pre-firmware id together with a multi-interface
+	 * descriptor (or the other way around) makes the two disagree, so that
+	 * usbatm_usb_disconnect() treats the small completion object as a
+	 * struct usbatm_data and reads out of bounds. Reject such inconsistent
+	 * descriptors so both paths make the same decision.
+	 */
+	if (UEA_IS_PREFIRM(id) != single_iface)
+		return -ENODEV;
+
 	usb_reset_device(usb);
 
 	if (UEA_IS_PREFIRM(id)) {
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 2050cc6693b3..8cfaefe0a47b 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1238,6 +1238,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 		usb_role_switch_unregister(ci->role_switch);
 
 	if (ci->supports_runtime_pm) {
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		pm_runtime_get_sync(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 3e8ea1bbe429..f9b1cea7382f 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1258,6 +1258,7 @@ static void f_midi_free(struct usb_function *f)
 	opts = container_of(f->fi, struct f_midi_opts, func_inst);
 	mutex_lock(&opts->lock);
 	if (!--midi->free_ref) {
+		cancel_work_sync(&midi->work);
 		kfree(midi->id);
 		kfifo_free(&midi->in_req_fifo);
 		kfree(midi);
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index b15eda52829d..609034f51fab 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1183,7 +1183,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	unsigned char	*ntb_ptr = skb->data;
 	__le16		*tmp;
 	unsigned	index, index2;
-	int		ndp_index;
+	unsigned int	ndp_index;
 	unsigned	dg_len, dg_len2;
 	unsigned	ndp_len;
 	unsigned	block_len;
@@ -1197,6 +1197,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	int		to_process = skb->len;
 
 parse_ntb:
+	if (to_process < (int)opts->nth_size) {
+		INFO(port->func.config->cdev, "Packet too small for headers\n");
+		goto err;
+	}
 	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
@@ -1217,8 +1221,12 @@ static int ncm_unwrap_ntb(struct gether *port,
 	tmp++; /* skip wSequence */
 
 	block_len = get_ncm(&tmp, opts->block_length);
+	if (block_len == 0)
+		block_len = to_process;
+
 	/* (d)wBlockLength */
-	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
+	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max) ||
+			(block_len > to_process)) {
 		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
 		goto err;
 	}
@@ -1281,7 +1289,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 			index = index2;
 			/* wDatagramIndex[0] */
 			if ((index < opts->nth_size) ||
-					(index > block_len - opts->dpe_size)) {
+					(index > block_len)) {
 				INFO(port->func.config->cdev,
 				     "Bad index: %#X\n", index);
 				goto err;
@@ -1293,7 +1301,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			 * ethernet hdr + crc or larger than max frame size
 			 */
 			if ((dg_len < 14 + crc_len) ||
-					(dg_len > frame_max)) {
+					(dg_len > frame_max) ||
+					(dg_len > block_len - index)) {
 				INFO(port->func.config->cdev,
 				     "Bad dgram length: %#X\n", dg_len);
 				goto err;
@@ -1318,7 +1327,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 			dg_len2 = get_ncm(&tmp, opts->dgram_item_len);
 
 			/* wDatagramIndex[1] */
-			if (index2 > block_len - opts->dpe_size) {
+			if (index2 > block_len) {
 				INFO(port->func.config->cdev,
 				     "Bad index: %#X\n", index2);
 				goto err;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 473206c0362d..ed5507eb1b4f 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -426,7 +426,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 {
 	struct printer_dev		*dev = fd->private_data;
 	unsigned long			flags;
-	size_t				size;
+	size_t				size, not_copied, copied;
 	size_t				bytes_copied;
 	struct usb_request		*req;
 	/* This is a pointer to the current USB rx request. */
@@ -519,10 +519,12 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		else
 			size = len;
 
-		size -= copy_to_user(buf, current_rx_buf, size);
-		bytes_copied += size;
-		len -= size;
-		buf += size;
+		not_copied = copy_to_user(buf, current_rx_buf, size);
+		copied = size - not_copied;
+
+		bytes_copied += copied;
+		len -= copied;
+		buf += copied;
 
 		spin_lock_irqsave(&dev->lock, flags);
 
@@ -537,6 +539,17 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		if (dev->interface < 0)
 			goto out_disabled;
 
+		if (!copied) {
+			dev->current_rx_req = current_rx_req;
+			dev->current_rx_bytes = current_rx_bytes;
+			dev->current_rx_buf = current_rx_buf;
+			spin_unlock_irqrestore(&dev->lock, flags);
+			mutex_unlock(&dev->lock_printer_io);
+			return bytes_copied ? bytes_copied : -EFAULT;
+		}
+
+		size = copied;
+
 		/* If we not returning all the data left in this RX request
 		 * buffer then adjust the amount of data left in the buffer.
 		 * Othewise if we are done with this RX request buffer then
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 2a1efaf3708e..b25fc2610cf1 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -39,6 +39,8 @@ uvc_send_response(struct uvc_device *uvc, struct uvc_request_data *data)
 		return usb_ep_set_halt(cdev->gadget->ep0);
 
 	req->length = min_t(unsigned int, uvc->event_length, data->length);
+	if (req->length > sizeof(data->data))
+		req->length = sizeof(data->data);
 	req->zero = data->length < uvc->event_length;
 
 	memcpy(req->buf, data->data, req->length);
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index e0cc520e21b3..229e49c5a412 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -274,6 +274,7 @@ struct dummy {
 	unsigned			ints_enabled:1;
 	unsigned			udc_suspended:1;
 	unsigned			pullup:1;
+	unsigned			fifo_req_busy:1;
 
 	/*
 	 * HOST side support
@@ -325,6 +326,26 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
 
 /* DEVICE/GADGET SIDE UTILITY ROUTINES */
 
+/*
+ * Give back a gadget request with dum->lock dropped around the callback.
+ * If @req is the shared fifo_req, clear fifo_req_busy afterward: the flag
+ * was set in dummy_queue() when the shared request was taken and must stay
+ * set until its completion callback has returned; list_del_init() alone
+ * makes the request look idle while the callback is still running.
+ * Caller holds dum->lock and has already done list_del_init() + status.
+ */
+static void dummy_giveback(struct dummy *dum, struct usb_ep *_ep,
+			   struct dummy_request *req)
+{
+	bool fifo = req == &dum->fifo_req;
+
+	spin_unlock(&dum->lock);
+	usb_gadget_giveback_request(_ep, &req->req);
+	spin_lock(&dum->lock);
+	if (fifo)
+		dum->fifo_req_busy = 0;
+}
+
 /* called with spinlock held */
 static void nuke(struct dummy *dum, struct dummy_ep *ep)
 {
@@ -335,9 +356,7 @@ static void nuke(struct dummy *dum, struct dummy_ep *ep)
 		list_del_init(&req->queue);
 		req->req.status = -ESHUTDOWN;
 
-		spin_unlock(&dum->lock);
-		usb_gadget_giveback_request(&ep->ep, &req->req);
-		spin_lock(&dum->lock);
+		dummy_giveback(dum, &ep->ep, req);
 	}
 }
 
@@ -722,10 +741,11 @@ static int dummy_queue(struct usb_ep *_ep, struct usb_request *_req,
 
 	/* implement an emulated single-request FIFO */
 	if (ep->desc && (ep->desc->bEndpointAddress & USB_DIR_IN) &&
-			list_empty(&dum->fifo_req.queue) &&
+			!dum->fifo_req_busy &&
 			list_empty(&ep->queue) &&
 			_req->length <= FIFO_SIZE) {
 		req = &dum->fifo_req;
+		dum->fifo_req_busy = 1;
 		req->req = *_req;
 		req->req.buf = dum->fifo_buf;
 		memcpy(dum->fifo_buf, _req->buf, _req->length);
@@ -779,9 +799,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
-		spin_unlock(&dum->lock);
-		usb_gadget_giveback_request(_ep, _req);
-		spin_lock(&dum->lock);
+		dummy_giveback(dum, _ep, req);
 	}
 	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
@@ -1506,9 +1524,7 @@ static int transfer(struct dummy_hcd *dum_hcd, struct urb *urb,
 		if (req->req.status != -EINPROGRESS) {
 			list_del_init(&req->queue);
 
-			spin_unlock(&dum->lock);
-			usb_gadget_giveback_request(&ep->ep, &req->req);
-			spin_lock(&dum->lock);
+			dummy_giveback(dum, &ep->ep, req);
 
 			/* requests might have been unlinked... */
 			rescan = 1;
@@ -1891,9 +1907,7 @@ static void dummy_timer(struct timer_list *t)
 				dev_dbg(udc_dev(dum), "stale req = %p\n",
 						req);
 
-				spin_unlock(&dum->lock);
-				usb_gadget_giveback_request(&ep->ep, &req->req);
-				spin_lock(&dum->lock);
+				dummy_giveback(dum, &ep->ep, req);
 				ep->already_seen = 0;
 				goto restart;
 			}
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 3986e0639f05..fb10394a964f 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2480,7 +2480,6 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.name = driver_name;
 
 	/* Setup gadget.dev and register with kernel */
-	dev_set_name(&udc_controller->gadget.dev, "gadget");
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 6c726d2e1788..42ee90f2b853 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -3158,7 +3158,6 @@ int udc_probe(struct udc *dev)
 	/* device struct setup */
 	dev->gadget.ops = &udc_ops;
 
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
 
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2be84d5e9261..6e87f36afb49 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -302,6 +302,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_TRB_OVERFETCH;
 		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
+		xhci->dma_mask_bits = 36;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 03de77fbe3af..2cc27dba08e2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5323,6 +5323,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
+	xhci->dma_mask_bits = 64;
 	xhci->quirks |= quirks;
 
 	get_quirks(dev, xhci);
@@ -5358,12 +5359,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (xhci->quirks & XHCI_NO_64BIT_SUPPORT)
 		xhci->hcc_params &= ~BIT(0);
 
-	/* Set dma_mask and coherent_dma_mask to 64-bits,
-	 * if xHC supports 64-bit addressing */
+	/*
+	 * Set dma_mask and coherent_dma_mask to 64-bits if xHC supports
+	 * 64-bit addressing, unless a controller-specific quirk callback
+	 * limits the usable address width.
+	 */
 	if (HCC_64BIT_ADDR(xhci->hcc_params) &&
-			!dma_set_mask(dev, DMA_BIT_MASK(64))) {
-		xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
-		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+	    !dma_set_mask(dev, DMA_BIT_MASK(xhci->dma_mask_bits))) {
+		xhci_dbg(xhci, "Enabling %u-bit DMA addresses.\n",
+			 xhci->dma_mask_bits);
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(xhci->dma_mask_bits));
 	} else {
 		/*
 		 * This is to avoid error in cases where a 32-bit USB
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4d4ac8ec614b..8d1c6c59e9e9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1782,6 +1782,7 @@ struct xhci_hcd {
 	int		event_ring_max;
 	/* 4KB min, 128MB max */
 	int		page_size;
+	unsigned int	dma_mask_bits;
 	/* Valid values are 12 to 20, inclusive */
 	int		page_shift;
 	/* msi-x vectors */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 5d05fa597569..5f3bb9bf5ead 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1053,6 +1053,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
 	/* Abacus Electrics */
 	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
+	/* Endress+Hauser AG devices */
+	{ USB_DEVICE(FTDI_VID, FTDI_EH_FXA291_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 1bbd4d3f1950..0724b5375e85 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -306,6 +306,11 @@
 #define FTDI_ELV_UDF77_PID	0xFB5E	/* USB DCF Funkuhr (UDF 77) */
 #define FTDI_ELV_UIO88_PID	0xFB5F	/* USB-I/O Interface (UIO 88) */
 
+/*
+ * Endress+Hauser AG product ids (FTDI_VID)
+ */
+#define FTDI_EH_FXA291_PID	0xE510
+
 /*
  * EVER Eco Pro UPS (http://www.ever.com.pl/)
  */
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 74320352b5a5..c7c93b3540f8 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -722,7 +722,8 @@ static void edge_interrupt_callback(struct urb *urb)
 				if (edge_port && edge_port->open) {
 					spin_lock_irqsave(&edge_port->ep_lock,
 							  flags);
-					edge_port->txCredits += txCredits;
+					edge_port->txCredits = min(edge_port->txCredits + txCredits,
+								   edge_port->maxTxCredits);
 					spin_unlock_irqrestore(&edge_port->ep_lock,
 							       flags);
 					dev_dbg(dev, "%s - txcredits for port%d = %d\n",
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5e29d05e051e..b924504dbdb3 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2497,6 +2497,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff),			/* Rolling RW135R-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x3466, 0x3301, 0xff) },			/* TDTECH MT5710-CN */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index f5614709e08a..79f69f0e61d1 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -395,6 +395,13 @@ UNUSUAL_DEV(  0x04b3, 0x4001, 0x0110, 0x0110,
 		USB_SC_DEVICE, USB_PR_CB, NULL,
 		US_FL_MAX_SECTORS_MIN),
 
+/* Reported by Ai Chao <aichao@kylinos.cn> */
+UNUSUAL_DEV(  0x04b4, 0xb708, 0x0000, 0xffff,
+		"Longmai Technologies",
+		"USB Key",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_NO_ATA_1X),
+
 /*
  * Reported by Simon Levitt <simon@whattf.com>
  * This entry needs Sub and Proto fields
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 95db8232e997..4b667cfbdc49 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1577,6 +1577,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 		BUG();
 	}
 
+	/*
+	 * The metadata cache holds the IOTLB mapping that backed the previous
+	 * desc/avail/used addresses and vring size, both of which are being
+	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
+	 * region was validated, so the stale entries have to go.
+	 */
+	__vhost_vq_meta_reset(vq);
+
 	mutex_unlock(&vq->mutex);
 
 	return r;
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 7c2fc9f83a84..c36f92965e0d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -274,9 +274,14 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	if (!vc->vc_font.data)
 		return;
 
- 	c = scr_readw((u16 *) vc->vc_pos);
+	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+	c &= charmask;
+
+	/* Clamp to font size, same as bit_putcs_aligned() */
+	if (c >= vc->vc_font.charcount)
+		c = 0;
+	src = vc->vc_font.data + (c * (w * vc->vc_font.height));
 
 	if (ops->cursor_state.image.data != src ||
 	    ops->cursor_reset) {
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 01ca84be240f..fe4c8ace9a42 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -164,6 +164,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
 	}
 
 	spin_lock_irq(&pretimeout_lock);
+	if (default_gov == gov)
+		default_gov = NULL;
 	list_for_each_entry(p, &pretimeout_list, entry)
 		if (p->wdd->gov == gov)
 			p->wdd->gov = default_gov;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a3bf15dafab7..1ea46ffba049 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -231,6 +231,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
 		switch (phdr->p_type) {
 		case PT_INTERP:
+			/* elf ABI allows only one interpreter */
+			if (interpreter_name)
+				continue;
+
 			retval = -ENOMEM;
 			if (phdr->p_filesz > PATH_MAX)
 				goto error;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 740dac1012ae..d8d373149119 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -199,9 +199,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 			goto ret;
 	}
 
-	if (fmt->flags & MISC_FMT_OPEN_BINARY)
-		bprm->have_execfd = 1;
-
 	/* make argv[1] be the path to the binary */
 	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
@@ -231,6 +228,8 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto ret;
 
 	bprm->interpreter = interp_file;
+	if (fmt->flags & MISC_FMT_OPEN_BINARY)
+		bprm->have_execfd = 1;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->execfd_creds = 1;
 
@@ -348,6 +347,10 @@ static Node *create_entry(const char __user *buffer, size_t count)
 
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
+	/* A flag-char delimiter runs the flag scan off the buffer. */
+	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
+		goto einval;
+
 	/* Pad the buffer with the delim to simplify parsing below. */
 	memset(buf + count, del, 8);
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a779965d2990..57e41ed899fe 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -304,16 +304,11 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 		       int write)
 {
 	int num_pages;
-	int check_crcs = 0;
 
 	num_pages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
-	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FREE_INO_OBJECTID)
-		check_crcs = 1;
-
 	/* Make sure we can fit our crcs and generation into the first page */
-	if (write && check_crcs &&
-	    (num_pages * sizeof(u32) + sizeof(u64)) > PAGE_SIZE)
+	if (write && (num_pages * sizeof(u32) + sizeof(u64)) > PAGE_SIZE)
 		return -ENOSPC;
 
 	memset(io_ctl, 0, sizeof(struct btrfs_io_ctl));
@@ -324,7 +319,6 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 
 	io_ctl->num_pages = num_pages;
 	io_ctl->fs_info = btrfs_sb(inode->i_sb);
-	io_ctl->check_crcs = check_crcs;
 	io_ctl->inode = inode;
 
 	return 0;
@@ -419,13 +413,8 @@ static void io_ctl_set_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 	 * Skip the csum areas.  If we don't check crcs then we just have a
 	 * 64bit chunk at the front of the first page.
 	 */
-	if (io_ctl->check_crcs) {
-		io_ctl->cur += (sizeof(u32) * io_ctl->num_pages);
-		io_ctl->size -= sizeof(u64) + (sizeof(u32) * io_ctl->num_pages);
-	} else {
-		io_ctl->cur += sizeof(u64);
-		io_ctl->size -= sizeof(u64) * 2;
-	}
+	io_ctl->cur += (sizeof(u32) * io_ctl->num_pages);
+	io_ctl->size -= sizeof(u64) + (sizeof(u32) * io_ctl->num_pages);
 
 	put_unaligned_le64(generation, io_ctl->cur);
 	io_ctl->cur += sizeof(u64);
@@ -439,14 +428,8 @@ static int io_ctl_check_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 	 * Skip the crc area.  If we don't check crcs then we just have a 64bit
 	 * chunk at the front of the first page.
 	 */
-	if (io_ctl->check_crcs) {
-		io_ctl->cur += sizeof(u32) * io_ctl->num_pages;
-		io_ctl->size -= sizeof(u64) +
-			(sizeof(u32) * io_ctl->num_pages);
-	} else {
-		io_ctl->cur += sizeof(u64);
-		io_ctl->size -= sizeof(u64) * 2;
-	}
+	io_ctl->cur += sizeof(u32) * io_ctl->num_pages;
+	io_ctl->size -= sizeof(u64) + (sizeof(u32) * io_ctl->num_pages);
 
 	cache_gen = get_unaligned_le64(io_ctl->cur);
 	if (cache_gen != generation) {
@@ -466,11 +449,6 @@ static void io_ctl_set_crc(struct btrfs_io_ctl *io_ctl, int index)
 	u32 crc = ~(u32)0;
 	unsigned offset = 0;
 
-	if (!io_ctl->check_crcs) {
-		io_ctl_unmap_page(io_ctl);
-		return;
-	}
-
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;
 
@@ -488,10 +466,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
 	u32 crc = ~(u32)0;
 	unsigned offset = 0;
 
-	if (!io_ctl->check_crcs) {
-		io_ctl_map_page(io_ctl, 0);
-		return 0;
-	}
+	if (index >= io_ctl->num_pages)
+		return -EIO;
 
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..d8c2f3df5a06 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -76,7 +76,6 @@ struct btrfs_io_ctl {
 	int num_pages;
 	int entries;
 	int bitmaps;
-	unsigned check_crcs:1;
 };
 
 struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8e43d07ffa8b..91dc79bc8c66 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4125,6 +4125,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	snaptrace = h + 1;
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
+	ceph_decode_need(&snaptrace, end, snaptrace_len, bad);
 	p = snaptrace + snaptrace_len;
 
 	if (msg_version >= 2) {
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index a19e5e7c7d0f..67ff1669cab2 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1774,8 +1774,10 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
 
 	/* tcon and ses pointer are checked in smb_init */
-	if (tcon->ses->server == NULL)
+	if (!tcon->ses->server) {
+		cifs_small_buf_release(pSMB);
 		return -ECONNABORTED;
+	}
 
 	pSMB->AndXCommand = 0xFF;       /* none */
 	pSMB->Fid = netfid;
@@ -1887,8 +1889,10 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
 
 	/* tcon and ses pointer are checked in smb_init */
-	if (tcon->ses->server == NULL)
+	if (!tcon->ses->server) {
+		cifs_buf_release(pSMB);
 		return -ECONNABORTED;
+	}
 
 	pSMB->AndXCommand = 0xFF;	/* none */
 	pSMB->Fid = netfid;
@@ -2317,8 +2321,10 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMB->hdr.PidHigh = cpu_to_le16((__u16)(pid >> 16));
 
 	/* tcon and ses pointer are checked in smb_init */
-	if (tcon->ses->server == NULL)
+	if (!tcon->ses->server) {
+		cifs_small_buf_release(pSMB);
 		return -ECONNABORTED;
+	}
 
 	pSMB->AndXCommand = 0xFF;	/* none */
 	pSMB->Fid = netfid;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index bd4ea48e0576..51f8ea0c8906 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3553,6 +3553,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	struct file_allocated_range_buffer in_data, *out_data = NULL, *tmp_data;
 	u32 out_data_len;
 	char *buf = NULL;
+	u64 range_start, range_len, range_end;
 	loff_t l;
 	int rc;
 
@@ -3589,13 +3590,21 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 			goto out;
 		}
 
-		if (off < le64_to_cpu(tmp_data->file_offset)) {
+		range_start = le64_to_cpu(tmp_data->file_offset);
+		range_len = le64_to_cpu(tmp_data->length);
+		if (check_add_overflow(range_start, range_len, &range_end) ||
+		    range_end > S64_MAX) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		if (off < range_start) {
 			/*
 			 * We are at a hole. Write until the end of the region
 			 * or until the next allocated data,
 			 * whichever comes next.
 			 */
-			l = le64_to_cpu(tmp_data->file_offset) - off;
+			l = range_start - off;
 			if (len < l)
 				l = len;
 			rc = smb3_simple_fallocate_write_range(xid, tcon,
@@ -3612,11 +3621,13 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		 * until the end of the data or the end of the region
 		 * we are supposed to fallocate, whichever comes first.
 		 */
-		l = le64_to_cpu(tmp_data->length);
-		if (len < l)
-			l = len;
-		off += l;
-		len -= l;
+		if (off < range_end) {
+			l = range_end - off;
+			if (len < l)
+				l = len;
+			off += l;
+			len -= l;
+		}
 
 		tmp_data = &tmp_data[1];
 		out_data_len -= sizeof(struct file_allocated_range_buffer);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index b746d7df3758..72db3df9dfad 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -403,6 +403,19 @@ fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 
 /* keyring.c */
 
+/*
+ * fscrypt_master_key_user - a user's claim to a master key
+ */
+struct fscrypt_master_key_user {
+	struct list_head link;
+	kuid_t uid;
+	/*
+	 * This 'struct key' contains no secret.  It exists solely to charge the
+	 * appropriate user's key quota.
+	 */
+	struct key *quota_key;
+};
+
 /*
  * fscrypt_master_key_secret - secret key material of an in-use master key
  */
@@ -489,19 +502,18 @@ struct fscrypt_master_key {
 	struct fscrypt_key_specifier		mk_spec;
 
 	/*
-	 * Keyring which contains a key of type 'key_type_fscrypt_user' for each
-	 * user who has added this key.  Normally each key will be added by just
-	 * one user, but it's possible that multiple users share a key, and in
-	 * that case we need to keep track of those users so that one user can't
-	 * remove the key before the others want it removed too.
+	 * List of user claims to this key (struct fscrypt_master_key_user).
+	 * Normally each key will be added by just one user, but it's possible
+	 * that multiple users share a key, and in that case we need to keep
+	 * track of those users so that one user can't remove the key before the
+	 * others want it removed too.
 	 *
-	 * This is NULL for v1 policy keys; those can only be added by root.
+	 * Used only for v2 policy keys.  v1 policy keys can be added only by
+	 * root, so user tracking doesn't apply to them.
 	 *
-	 * Locking: protected by ->mk_sem.  (We don't just rely on the keyrings
-	 * subsystem semaphore ->mk_users->sem, as we need support for atomic
-	 * search+insert along with proper synchronization with ->mk_secret.)
+	 * Locking: protected by ->mk_sem.
 	 */
-	struct key		*mk_users;
+	struct list_head	mk_users;
 
 	/*
 	 * List of inodes that were unlocked using this key.  This allows the
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 02f8bf8bd54d..51cd45785f0c 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -64,18 +64,19 @@ static void fscrypt_free_master_key(struct rcu_head *head)
 	kfree_sensitive(mk);
 }
 
+static void clear_mk_users(struct fscrypt_master_key *mk);
+
 void fscrypt_put_master_key(struct fscrypt_master_key *mk)
 {
 	if (!refcount_dec_and_test(&mk->mk_struct_refs))
 		return;
 	/*
-	 * No structural references left, so free ->mk_users, and also free the
+	 * No structural references left, so clear ->mk_users, and also free the
 	 * fscrypt_master_key struct itself after an RCU grace period ensures
 	 * that concurrent keyring lookups can no longer find it.
 	 */
 	WARN_ON(refcount_read(&mk->mk_active_refs) != 0);
-	key_put(mk->mk_users);
-	mk->mk_users = NULL;
+	clear_mk_users(mk);
 	call_rcu(&mk->mk_rcu_head, fscrypt_free_master_key);
 }
 
@@ -141,8 +142,8 @@ static void fscrypt_user_key_describe(const struct key *key, struct seq_file *m)
 }
 
 /*
- * Type of key in ->mk_users.  Each key of this type represents a particular
- * user who has added a particular master key.
+ * Type of fscrypt_master_key_user::quota_key.  This contains no secret; it
+ * exists solely to charge a user's key quota.
  *
  * Note that the name of this key type really should be something like
  * ".fscrypt-user" instead of simply ".fscrypt".  But the shorter name is chosen
@@ -156,30 +157,9 @@ static struct key_type key_type_fscrypt_user = {
 	.describe		= fscrypt_user_key_describe,
 };
 
-#define FSCRYPT_MK_USERS_DESCRIPTION_SIZE	\
-	(CONST_STRLEN("fscrypt-") + 2 * FSCRYPT_KEY_IDENTIFIER_SIZE + \
-	 CONST_STRLEN("-users") + 1)
-
 #define FSCRYPT_MK_USER_DESCRIPTION_SIZE	\
 	(2 * FSCRYPT_KEY_IDENTIFIER_SIZE + CONST_STRLEN(".uid.") + 10 + 1)
 
-static void format_mk_users_keyring_description(
-			char description[FSCRYPT_MK_USERS_DESCRIPTION_SIZE],
-			const u8 mk_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE])
-{
-	sprintf(description, "fscrypt-%*phN-users",
-		FSCRYPT_KEY_IDENTIFIER_SIZE, mk_identifier);
-}
-
-static void format_mk_user_description(
-			char description[FSCRYPT_MK_USER_DESCRIPTION_SIZE],
-			const u8 mk_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE])
-{
-
-	sprintf(description, "%*phN.uid.%u", FSCRYPT_KEY_IDENTIFIER_SIZE,
-		mk_identifier, __kuid_val(current_fsuid()));
-}
-
 /* Create ->s_master_keys if needed.  Synchronized by fscrypt_add_key_mutex. */
 static int allocate_filesystem_keyring(struct super_block *sb)
 {
@@ -318,91 +298,94 @@ fscrypt_find_master_key(struct super_block *sb,
 	return mk;
 }
 
-static int allocate_master_key_users_keyring(struct fscrypt_master_key *mk)
+/* Find the current user's claim in ->mk_users.  ->mk_sem must be held. */
+static struct fscrypt_master_key_user *
+find_master_key_user(struct fscrypt_master_key *mk)
 {
-	char description[FSCRYPT_MK_USERS_DESCRIPTION_SIZE];
-	struct key *keyring;
-
-	format_mk_users_keyring_description(description,
-					    mk->mk_spec.u.identifier);
-	keyring = keyring_alloc(description, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				current_cred(), KEY_POS_SEARCH |
-				  KEY_USR_SEARCH | KEY_USR_READ | KEY_USR_VIEW,
-				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
-	if (IS_ERR(keyring))
-		return PTR_ERR(keyring);
-
-	mk->mk_users = keyring;
-	return 0;
-}
+	struct fscrypt_master_key_user *mk_user;
+	kuid_t uid = current_fsuid();
 
-/*
- * Find the current user's "key" in the master key's ->mk_users.
- * Returns ERR_PTR(-ENOKEY) if not found.
- */
-static struct key *find_master_key_user(struct fscrypt_master_key *mk)
-{
-	char description[FSCRYPT_MK_USER_DESCRIPTION_SIZE];
-	key_ref_t keyref;
-
-	format_mk_user_description(description, mk->mk_spec.u.identifier);
-
-	/*
-	 * We need to mark the keyring reference as "possessed" so that we
-	 * acquire permission to search it, via the KEY_POS_SEARCH permission.
-	 */
-	keyref = keyring_search(make_key_ref(mk->mk_users, true /*possessed*/),
-				&key_type_fscrypt_user, description, false);
-	if (IS_ERR(keyref)) {
-		if (PTR_ERR(keyref) == -EAGAIN || /* not found */
-		    PTR_ERR(keyref) == -EKEYREVOKED) /* recently invalidated */
-			keyref = ERR_PTR(-ENOKEY);
-		return ERR_CAST(keyref);
+	list_for_each_entry(mk_user, &mk->mk_users, link) {
+		if (uid_eq(mk_user->uid, uid))
+			return mk_user;
 	}
-	return key_ref_to_ptr(keyref);
+	return NULL;
 }
 
 /*
- * Give the current user a "key" in ->mk_users.  This charges the user's quota
+ * Give the current user a claim in ->mk_users.  This charges the user's quota
  * and marks the master key as added by the current user, so that it cannot be
  * removed by another user with the key.  Either ->mk_sem must be held for
  * write, or the master key must be still undergoing initialization.
  */
 static int add_master_key_user(struct fscrypt_master_key *mk)
 {
+	kuid_t uid = current_fsuid();
 	char description[FSCRYPT_MK_USER_DESCRIPTION_SIZE];
-	struct key *mk_user;
+	struct key *quota_key;
+	struct fscrypt_master_key_user *mk_user;
 	int err;
 
-	format_mk_user_description(description, mk->mk_spec.u.identifier);
-	mk_user = key_alloc(&key_type_fscrypt_user, description,
-			    current_fsuid(), current_gid(), current_cred(),
-			    KEY_POS_SEARCH | KEY_USR_VIEW, 0, NULL);
-	if (IS_ERR(mk_user))
-		return PTR_ERR(mk_user);
+	snprintf(description, sizeof(description), "%*phN.uid.%u",
+		 FSCRYPT_KEY_IDENTIFIER_SIZE, mk->mk_spec.u.identifier,
+		 __kuid_val(uid));
+	quota_key = key_alloc(&key_type_fscrypt_user, description, uid,
+			      current_gid(), current_cred(),
+			      KEY_POS_SEARCH | KEY_USR_VIEW, 0, NULL);
+	if (IS_ERR(quota_key))
+		return PTR_ERR(quota_key);
+
+	err = key_instantiate_and_link(quota_key, NULL, 0, NULL, NULL);
+	if (err) {
+		key_put(quota_key);
+		return err;
+	}
 
-	err = key_instantiate_and_link(mk_user, NULL, 0, mk->mk_users, NULL);
-	key_put(mk_user);
-	return err;
+	mk_user = kzalloc(sizeof(*mk_user), GFP_KERNEL);
+	if (!mk_user) {
+		key_put(quota_key);
+		return -ENOMEM;
+	}
+	mk_user->uid = uid;
+	mk_user->quota_key = quota_key;
+	list_add(&mk_user->link, &mk->mk_users);
+	return 0;
+}
+
+static void unlink_and_free_mk_user(struct fscrypt_master_key_user *mk_user)
+{
+	list_del(&mk_user->link);
+	key_put(mk_user->quota_key);
+	kfree(mk_user);
 }
 
 /*
- * Remove the current user's "key" from ->mk_users.
+ * Remove the current user's claim from ->mk_users.
  * ->mk_sem must be held for write.
  *
- * Returns 0 if removed, -ENOKEY if not found, or another -errno code.
+ * Returns 0 if removed or -ENOKEY if not found.
  */
 static int remove_master_key_user(struct fscrypt_master_key *mk)
 {
-	struct key *mk_user;
-	int err;
+	struct fscrypt_master_key_user *mk_user;
 
 	mk_user = find_master_key_user(mk);
-	if (IS_ERR(mk_user))
-		return PTR_ERR(mk_user);
-	err = key_unlink(mk->mk_users, mk_user);
-	key_put(mk_user);
-	return err;
+	if (!mk_user)
+		return -ENOKEY;
+	unlink_and_free_mk_user(mk_user);
+	return 0;
+}
+
+/*
+ * Clear ->mk_users.  Either ->mk_sem must be held for write, or 'mk' must have
+ * no structural references left.
+ */
+static void clear_mk_users(struct fscrypt_master_key *mk)
+{
+	struct fscrypt_master_key_user *mk_user, *tmp;
+
+	list_for_each_entry_safe(mk_user, tmp, &mk->mk_users, link)
+		unlink_and_free_mk_user(mk_user);
 }
 
 /*
@@ -426,13 +409,12 @@ static int add_new_master_key(struct super_block *sb,
 	refcount_set(&mk->mk_struct_refs, 1);
 	mk->mk_spec = *mk_spec;
 
+	INIT_LIST_HEAD(&mk->mk_users);
+
 	INIT_LIST_HEAD(&mk->mk_decrypted_inodes);
 	spin_lock_init(&mk->mk_decrypted_inodes_lock);
 
 	if (mk_spec->type == FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER) {
-		err = allocate_master_key_users_keyring(mk);
-		if (err)
-			goto out_put;
 		err = add_master_key_user(mk);
 		if (err)
 			goto out_put;
@@ -460,19 +442,13 @@ static int add_existing_master_key(struct fscrypt_master_key *mk,
 	int err;
 
 	/*
-	 * If the current user is already in ->mk_users, then there's nothing to
-	 * do.  Otherwise, we need to add the user to ->mk_users.  (Neither is
-	 * applicable for v1 policy keys, which have NULL ->mk_users.)
+	 * For v2 policy keys (FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER): If the current
+	 * user is already in ->mk_users, then there's nothing to do.
+	 * Otherwise, add the user to ->mk_users.
 	 */
-	if (mk->mk_users) {
-		struct key *mk_user = find_master_key_user(mk);
-
-		if (mk_user != ERR_PTR(-ENOKEY)) {
-			if (IS_ERR(mk_user))
-				return PTR_ERR(mk_user);
-			key_put(mk_user);
+	if (mk->mk_spec.type == FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER) {
+		if (find_master_key_user(mk) != NULL)
 			return 0;
-		}
 		err = add_master_key_user(mk);
 		if (err)
 			return err;
@@ -787,7 +763,6 @@ int fscrypt_verify_key_added(struct super_block *sb,
 {
 	struct fscrypt_key_specifier mk_spec;
 	struct fscrypt_master_key *mk;
-	struct key *mk_user;
 	int err;
 
 	mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER;
@@ -799,13 +774,10 @@ int fscrypt_verify_key_added(struct super_block *sb,
 		goto out;
 	}
 	down_read(&mk->mk_sem);
-	mk_user = find_master_key_user(mk);
-	if (IS_ERR(mk_user)) {
-		err = PTR_ERR(mk_user);
-	} else {
-		key_put(mk_user);
+	if (find_master_key_user(mk) != NULL)
 		err = 0;
-	}
+	else
+		err = -ENOKEY;
 	up_read(&mk->mk_sem);
 	fscrypt_put_master_key(mk);
 out:
@@ -998,16 +970,18 @@ static int do_remove_key(struct file *filp, void __user *_uarg, bool all_users)
 	down_write(&mk->mk_sem);
 
 	/* If relevant, remove current user's (or all users) claim to the key */
-	if (mk->mk_users && mk->mk_users->keys.nr_leaves_on_tree != 0) {
-		if (all_users)
-			err = keyring_clear(mk->mk_users);
-		else
+	if (!list_empty(&mk->mk_users)) {
+		if (all_users) {
+			clear_mk_users(mk);
+			err = 0;
+		} else {
 			err = remove_master_key_user(mk);
+		}
 		if (err) {
 			up_write(&mk->mk_sem);
 			goto out_put_key;
 		}
-		if (mk->mk_users->keys.nr_leaves_on_tree != 0) {
+		if (!list_empty(&mk->mk_users)) {
 			/*
 			 * Other users have still added the key too.  We removed
 			 * the current user's claim to the key, but we still
@@ -1095,6 +1069,8 @@ int fscrypt_ioctl_get_key_status(struct file *filp, void __user *uarg)
 	struct super_block *sb = file_inode(filp)->i_sb;
 	struct fscrypt_get_key_status_arg arg;
 	struct fscrypt_master_key *mk;
+	kuid_t uid;
+	const struct fscrypt_master_key_user *mk_user;
 	int err;
 
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
@@ -1127,19 +1103,13 @@ int fscrypt_ioctl_get_key_status(struct file *filp, void __user *uarg)
 	}
 
 	arg.status = FSCRYPT_KEY_STATUS_PRESENT;
-	if (mk->mk_users) {
-		struct key *mk_user;
 
-		arg.user_count = mk->mk_users->keys.nr_leaves_on_tree;
-		mk_user = find_master_key_user(mk);
-		if (!IS_ERR(mk_user)) {
+	uid = current_fsuid();
+	list_for_each_entry(mk_user, &mk->mk_users, link) {
+		arg.user_count++;
+		if (uid_eq(mk_user->uid, uid))
 			arg.status_flags |=
 				FSCRYPT_KEY_STATUS_FLAG_ADDED_BY_SELF;
-			key_put(mk_user);
-		} else if (mk_user != ERR_PTR(-ENOKEY)) {
-			err = PTR_ERR(mk_user);
-			goto out_release_key;
-		}
 	}
 	err = 0;
 out_release_key:
diff --git a/fs/exec.c b/fs/exec.c
index 2979b458b650..0ea96114fcf7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -876,7 +876,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 	stop = bprm->p >> PAGE_SHIFT;
 	sp = *sp_location;
 
-	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
+	for (index = MAX_ARG_PAGES; index-- > stop; ) {
 		unsigned int offset = index == stop ? bprm->p & ~PAGE_MASK : 0;
 		char *src = kmap(bprm->page[index]) + offset;
 		sp -= PAGE_SIZE - offset;
diff --git a/fs/namespace.c b/fs/namespace.c
index e9b8d516f191..fcb9ab461775 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3657,6 +3657,11 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		ret = PTR_ERR(newmount.mnt);
 		goto err_unlock;
 	}
+	if (newmount.mnt->mnt_sb->s_flags & SB_NOUSER) {
+		mntput(newmount.mnt);
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 170e9eaf536a..c455f6a8f61a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10135,6 +10135,11 @@ static void nfs41_free_stateid_done(struct rpc_task *task, void *calldata)
 
 static void nfs41_free_stateid_release(void *calldata)
 {
+	struct nfs_free_stateid_data *data = calldata;
+	struct nfs_client *clp = data->server->nfs_client;
+
+	nfs_sb_deactive(data->server->super);
+	nfs_put_client(clp);
 	kfree(calldata);
 }
 
@@ -10171,6 +10176,14 @@ static int nfs41_free_stateid(struct nfs_server *server,
 	};
 	struct nfs_free_stateid_data *data;
 	struct rpc_task *task;
+	struct nfs_client *clp = server->nfs_client;
+
+	if (!refcount_inc_not_zero(&clp->cl_count))
+		return -EIO;
+	if (!nfs_sb_active(server->super)) {
+		nfs_put_client(clp);
+		return -EIO;
+	}
 
 	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_STATEID,
 		&task_setup.rpc_client, &msg);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 2a3fc96ca622..203d3363e3d5 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -46,7 +46,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
 	struct task_struct *task;
 	struct path ns_path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
@@ -59,6 +59,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (error)
 		goto out_put_task;
 
+	error = -EACCES;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -90,6 +91,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (res)
 		goto out_put_task;
 
+	res = -EACCES;
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..d9d07a9ab313 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -13,9 +13,12 @@
  * supported by BAM DMA Engine.
  *
  * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
- * @data - for write command: content to be written into peripheral register.
- *	   for read command: dest addr to write peripheral register value.
- * @mask - register mask.
+ * @data - For write command: content to be written into peripheral register.
+ *	   For read command: lower 32 bits of destination address.
+ * @mask - For write command: register write mask.
+ *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
+ *	   For read command on BAM < v1.6.0: ignored by hardware.
+ *	   Setting to 0 ensures 32-bit addressing compatibility.
  * @reserved - for future usage.
  *
  */
@@ -42,6 +45,10 @@ enum bam_command_type {
  * @addr: target address
  * @cmd: BAM command
  * @data: actual data for write and dest addr for read in le32
+ *
+ * For BAM v1.6.0+, the mask field behavior depends on command type:
+ * - Write commands: mask = write mask (typically 0xffffffff)
+ * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
  */
 static inline void
 bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
@@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
 	bam_ce->cmd_and_addr =
 		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
 	bam_ce->data = data;
-	bam_ce->mask = cpu_to_le32(0xffffffff);
+	if (cmd == BAM_READ_COMMAND)
+		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
+	else
+		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
+	bam_ce->reserved = 0;
 }
 
 /*
@@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
  * @bam_ce: BAM command element
  * @addr: target address
  * @cmd: BAM command
- * @data: actual data for write and dest addr for read
+ * @data: actual data for write and destination address for read
  */
 static inline void
 bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dcf1b603cb51..b847c45c45c8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3208,11 +3208,6 @@ static inline bool dev_validate_header(const struct net_device *dev,
 	if (len < dev->min_header_len)
 		return false;
 
-	if (capable(CAP_SYS_RAWIO)) {
-		memset(ll_header + len, 0, dev->hard_header_len - len);
-		return true;
-	}
-
 	if (dev->header_ops && dev->header_ops->validate)
 		return dev->header_ops->validate(ll_header, len);
 
diff --git a/include/linux/netfilter/nf_conntrack_sip.h b/include/linux/netfilter/nf_conntrack_sip.h
index c620521c42bc..dfb9708f5340 100644
--- a/include/linux/netfilter/nf_conntrack_sip.h
+++ b/include/linux/netfilter/nf_conntrack_sip.h
@@ -115,7 +115,7 @@ struct nf_nat_sip_hooks {
 			    unsigned int *datalen);
 
 	void (*seq_adjust)(struct sk_buff *skb,
-			   unsigned int protoff, s16 off);
+			   unsigned int protoff, s32 off);
 
 	unsigned int (*expect)(struct sk_buff *skb,
 			       unsigned int protoff,
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index bbb3f26fbde9..f7f61a0a69dd 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1040,8 +1040,8 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
  * @ppos:	file handle position tracking pointer
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  */
-size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblock);
+ssize_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
+		 loff_t *ppos, int nonblock);
 /**
  * vb2_read() - implements write() syscall logic.
  * @q:		pointer to &struct vb2_queue with videobuf2 queue.
@@ -1050,8 +1050,8 @@ size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
  * @ppos:	file handle position tracking pointer
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  */
-size_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
-		loff_t *ppos, int nonblock);
+ssize_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
+		  loff_t *ppos, int nonblock);
 
 /**
  * typedef vb2_thread_fnc - callback function for use with vb2_thread.
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 71abf4cc6a32..cda93578a41b 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -368,8 +368,8 @@ static inline struct inet6_dev *in6_dev_get(const struct net_device *dev)
 
 	rcu_read_lock();
 	idev = rcu_dereference(dev->ip6_ptr);
-	if (idev)
-		refcount_inc(&idev->refcnt);
+	if (idev && !refcount_inc_not_zero(&idev->refcnt))
+		idev = NULL;
 	rcu_read_unlock();
 	return idev;
 }
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 43b4386018e2..85bab90a6921 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -317,6 +317,7 @@ void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 			   struct proto *prot, int proto, gfp_t prio, int kern);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d2db84b77bfb..af590a802eba 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -775,6 +775,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_DEL,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 99d26879b02a..ba8d3702853d 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -229,6 +229,9 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 			u8 bit_rate, u8 data_bits, u8 stop_bits,
 			u8 parity, u8 flow_ctrl_settings,
 			u8 xon_char, u8 xoff_char, u16 param_mask);
+int rfcomm_dlc_send_rpn(struct rfcomm_dlc *d, u8 bit_rate, u8 data_bits,
+			u8 stop_bits, u8 parity, u8 flow_ctrl_settings,
+			u8 xon_char, u8 xoff_char, u16 param_mask);
 
 /* ---- RFCOMM DLCs (channels) ---- */
 struct rfcomm_dlc *rfcomm_dlc_alloc(gfp_t prio);
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 0b8352a6310e..9f4224eb18a3 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -675,10 +675,11 @@ struct ip_vs_dest {
 
 	/* connection counters and thresholds */
 	atomic_t		activeconns;	/* active connections */
-	atomic_t		inactconns;	/* inactive connections */
+	atomic_t		totalconns;	/* total connections */
 	atomic_t		persistconns;	/* persistent connections */
 	__u32			u_threshold;	/* upper threshold */
 	__u32			l_threshold;	/* lower threshold */
+	__u32			l_threshold_val;/* used lower threshold */
 
 	/* for destination cache */
 	spinlock_t		dst_lock;	/* lock of dst_cache */
@@ -1457,6 +1458,8 @@ static inline void ip_vs_dest_put_and_free(struct ip_vs_dest *dest)
 		kfree(dest);
 }
 
+void ip_vs_dest_update_overload(struct ip_vs_dest *dest, int mode);
+
 /* IPVS sync daemon data and function prototypes
  * (from ip_vs_sync.c)
  */
@@ -1704,14 +1707,21 @@ void ip_vs_unregister_hooks(struct netns_ipvs *ipvs, unsigned int af);
 static inline int
 ip_vs_dest_conn_overhead(struct ip_vs_dest *dest)
 {
-	/* We think the overhead of processing active connections is 256
+	/* We think the overhead of processing active connections is 257
 	 * times higher than that of inactive connections in average. (This
-	 * 256 times might not be accurate, we will change it later) We
+	 * 257 times might not be accurate, we will change it later) We
 	 * use the following formula to estimate the overhead now:
-	 *		  dest->activeconns*256 + dest->inactconns
+	 *		  dest->activeconns*256 + dest->totalconns
 	 */
 	return (atomic_read(&dest->activeconns) << 8) +
-		atomic_read(&dest->inactconns);
+		atomic_read(&dest->totalconns);
+}
+
+static inline int
+ip_vs_dest_inactconns(const struct ip_vs_dest *dest)
+{
+	return max(atomic_read(&dest->totalconns) -
+		   atomic_read(&dest->activeconns), 0);
 }
 
 #endif	/* _NET_IP_VS_H */
diff --git a/include/net/raw.h b/include/net/raw.h
index c51a635671a7..6324965779ec 100644
--- a/include/net/raw.h
+++ b/include/net/raw.h
@@ -20,9 +20,8 @@
 extern struct proto raw_prot;
 
 extern struct raw_hashinfo raw_v4_hashinfo;
-struct sock *__raw_v4_lookup(struct net *net, struct sock *sk,
-			     unsigned short num, __be32 raddr,
-			     __be32 laddr, int dif, int sdif);
+bool raw_v4_match(struct net *net, struct sock *sk, unsigned short num,
+		  __be32 raddr, __be32 laddr, int dif, int sdif);
 
 int raw_abort(struct sock *sk, int err);
 void raw_icmp_error(struct sk_buff *, int, u32);
diff --git a/include/net/rawv6.h b/include/net/rawv6.h
index 53d86b6055e8..c48c1298699a 100644
--- a/include/net/rawv6.h
+++ b/include/net/rawv6.h
@@ -5,9 +5,9 @@
 #include <net/protocol.h>
 
 extern struct raw_hashinfo raw_v6_hashinfo;
-struct sock *__raw_v6_lookup(struct net *net, struct sock *sk,
-			     unsigned short num, const struct in6_addr *loc_addr,
-			     const struct in6_addr *rmt_addr, int dif, int sdif);
+bool raw_v6_match(struct net *net, struct sock *sk, unsigned short num,
+		  const struct in6_addr *loc_addr,
+		  const struct in6_addr *rmt_addr, int dif, int sdif);
 
 int raw_abort(struct sock *sk, int err);
 
diff --git a/include/net/route.h b/include/net/route.h
index c6557fdcde2c..584b6171e313 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -240,6 +240,8 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct netlink_callback *cb,
 		       u32 table_id, struct fib_info *fi,
 		       int *fa_index, int fa_start, unsigned int flags);
 
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig);
+
 static inline void ip_rt_put(struct rtable *rt)
 {
 	/* dst_release() accepts a NULL parameter.
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 8d058b50f138..85ed2b59ffe7 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -318,7 +318,8 @@ struct sctp_cookie {
 
 	__u8 auth_random[sizeof(struct sctp_paramhdr) +
 			 SCTP_AUTH_RANDOM_LENGTH];
-	__u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2];
+	__u8 auth_hmacs[sizeof(struct sctp_paramhdr) +
+			SCTP_AUTH_NUM_HMACS * sizeof(__u16)];
 	__u8 auth_chunks[sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNKS];
 
 	/* This is a shim for my peer's INIT packet, followed by
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 4c687686aa8f..e4a94f5c3a14 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -354,16 +354,22 @@ enum {
 
 /* flags used in BRIDGE_VLANDB_DUMP_FLAGS attribute to affect dumps */
 #define BRIDGE_VLANDB_DUMPF_STATS	(1 << 0) /* Include stats in the dump */
+#define BRIDGE_VLANDB_DUMPF_GLOBAL	(1 << 1) /* Dump global vlan options only */
 
 /* Bridge vlan RTM attributes
  * [BRIDGE_VLANDB_ENTRY] = {
  *     [BRIDGE_VLANDB_ENTRY_INFO]
  *     ...
  * }
+ * [BRIDGE_VLANDB_GLOBAL_OPTIONS] = {
+ *     [BRIDGE_VLANDB_GOPTS_ID]
+ *     ...
+ * }
  */
 enum {
 	BRIDGE_VLANDB_UNSPEC,
 	BRIDGE_VLANDB_ENTRY,
+	BRIDGE_VLANDB_GLOBAL_OPTIONS,
 	__BRIDGE_VLANDB_MAX,
 };
 #define BRIDGE_VLANDB_MAX (__BRIDGE_VLANDB_MAX - 1)
@@ -413,6 +419,14 @@ enum {
 };
 #define BRIDGE_VLANDB_STATS_MAX (__BRIDGE_VLANDB_STATS_MAX - 1)
 
+enum {
+	BRIDGE_VLANDB_GOPTS_UNSPEC,
+	BRIDGE_VLANDB_GOPTS_ID,
+	BRIDGE_VLANDB_GOPTS_RANGE,
+	__BRIDGE_VLANDB_GOPTS_MAX
+};
+#define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
+
 /* Bridge multicast database attributes
  * [MDBA_MDB] = {
  *     [MDBA_MDB_ENTRY] = {
diff --git a/kernel/audit.c b/kernel/audit.c
index 7452719c659f..eec8fc5006fd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2074,7 +2074,8 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 void audit_log_n_string(struct audit_buffer *ab, const char *string,
 			size_t slen)
 {
-	int avail, new_len;
+	int avail;
+	size_t new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2084,7 +2085,13 @@ void audit_log_n_string(struct audit_buffer *ab, const char *string,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = slen + 3;	/* enclosing quotes + null terminator */
+
+	/* enclosing quotes + null terminator */
+	if (check_add_overflow(slen, 3, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len > avail) {
 		avail = audit_expand(ab, new_len);
 		if (!avail)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index a5b43f25609e..f1346bf5943f 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1036,6 +1036,10 @@ int audit_del_rule(struct audit_entry *entry)
 		goto out;
 	}
 
+	list_del_rcu(&e->list);
+	list_del(&e->rule.list);
+	synchronize_rcu();
+
 	if (e->rule.watch)
 		audit_remove_watch_rule(&e->rule);
 
@@ -1053,8 +1057,6 @@ int audit_del_rule(struct audit_entry *entry)
 		audit_signals--;
 #endif
 
-	list_del_rcu(&e->list);
-	list_del(&e->rule.list);
 	call_rcu(&e->rcu, audit_free_rule_rcu);
 
 out:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 19e1f7fff07a..986659917178 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6301,11 +6301,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	}
 
-	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-	 * The id may be overwritten later if we create a new variable offset.
+	/* For 'scalar += pointer', dst_reg inherits the complete pointer
+	 * register state. Individual fields may be adjusted later by pointer
+	 * arithmetic. Callers guarantee that below does not overwrite off_reg.
 	 */
-	dst_reg->type = ptr_reg->type;
-	dst_reg->id = ptr_reg->id;
+	if (dst_reg != ptr_reg)
+		*dst_reg = *ptr_reg;
 
 	if (!check_reg_sane_offset(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset(env, ptr_reg, ptr_reg->type))
@@ -6373,7 +6374,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_SUB:
-		if (dst_reg == off_reg) {
+		if (dst_reg != ptr_reg) {
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
@@ -7232,8 +7233,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				err = mark_chain_precision(env, insn->dst_reg);
 				if (err)
 					return err;
-				return adjust_ptr_min_max_vals(env, insn,
-							       src_reg, dst_reg);
+				off_reg = *dst_reg;
+				return adjust_ptr_min_max_vals(env, insn, src_reg, &off_reg);
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
@@ -8556,6 +8557,22 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	mark_reg_unknown(env, regs, BPF_REG_0);
 	/* ld_abs load up to 32-bit skb data. */
 	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
+	/*
+	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
+	 * which must be explored by the verifier when in a subprog.
+	 */
+	if (env->cur_state->curframe) {
+		struct bpf_verifier_state *branch;
+
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (!branch)
+			return -EFAULT;
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		err = prepare_func_exit(env, &env->insn_idx);
+		if (err)
+			return err;
+		env->insn_idx--;
+	}
 	return 0;
 }
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 08c2b2e30f23..69c7be3706f1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2319,18 +2319,15 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 static ssize_t show_cpuhp_states(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	ssize_t cur, res = 0;
+	ssize_t res = 0;
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
 	for (i = CPUHP_OFFLINE; i <= CPUHP_ONLINE; i++) {
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
-		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
-			res += cur;
-		}
+		if (sp->name)
+			res += sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
 	}
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index df86c0e49418..d772b8ab2981 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -3428,8 +3428,11 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 		return -1;
 
 	/*
-	 * Special case for regular (non PI) futexes. The unlock path in
-	 * user space has two race scenarios:
+	 * Special case for regular (non PI) futexes. Ordinarily, we do
+	 * not perform any processing here unless the current thread was
+	 * the owner of the futex (by the TID check below).
+	 *
+	 * However, the unlock path has three race scenarios:
 	 *
 	 * 1. The unlock path releases the user space futex value and
 	 *    before it can execute the futex() syscall to wake up
@@ -3438,41 +3441,68 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * 2. A woken up waiter is killed before it can acquire the
 	 *    futex in user space.
 	 *
-	 * In the second case, the wake up notification could be generated
-	 * by the unlock path in user space after setting the futex value
-	 * to zero or by the kernel after setting the OWNER_DIED bit below.
+	 * 3. A woken up waiter is killed in user space after another
+	 *    thread has acquired the futex, but before it can set
+	 *    FUTEX_WAITERS.
+	 *
+	 * Note that, if userspace uses the FUTEX_ROBUST_UNLOCK flag, we
+	 * will not see case 1 here.
+	 *
+	 * In the second and third case, the wake up notification could
+	 * be generated from any of:
+	 *
+	 *    i.   An ordinary futex wakeup after unlock (with or
+	 *         without FUTEX_ROBUST_UNLOCK)
+	 *    ii.  A robust wakeup from another thread's death
+	 *    iii. A previous round through this special case
+	 *
+	 * As a result, the futex world will be in one of four states:
 	 *
-	 * In both cases the TID validation below prevents a wakeup of
-	 * potential waiters which can cause these waiters to block
-	 * forever.
+	 *    A. The futex word is 0 (unlocked)
+	 *    B. The futex word is owned by another thread
+	 *       (FUTEX_WAITERS is not set)
+	 *    C. The futex word is owned by another thread
+	 *       (FUTEX_WAITERS set)
+	 *    D. The futex's owner died and OWNER_DIED is set
+	 *       (the owner part of the word is 0)
 	 *
-	 * In both cases the following conditions are met:
+	 * The key issue is that the kernel usually (at least from
+	 * sources ii. and iii. or when so requested by userspace from
+	 * source i.) only ever wakes *one* waiter at a time. If this
+	 * waiter dies before acquiring the futex (or setting the
+	 * FUTEX_WAITERS bit), the kernel *must* still wake the next
+	 * waiter down the line to uphold the futex invariants and
+	 * avoid lost wakeups. Note we do not need to handle state C,
+	 * as it does not matter to us whether *we* successfully set
+	 * the bit or a third thread did so in the meantime.
 	 *
-	 *	1) task->robust_list->list_op_pending != NULL
-	 *	   @pending_op == true
-	 *	2) The owner part of user space futex value == 0
+	 * Therefore, in these cases we must issue an additional
+	 * futex_wake(). Note however that we *must not* set OWNER_DIED
+	 * here. Our thread is *not* the owner of the futex.
+	 *
+	 * Thus to summarize, the conditions for needing the additional
+	 * futex_wake() are:
+	 *
+	 *	1) @pending_op == true (the thread has not finished the
+	 *	   mutex operation)
+	 *	2) The futex word is in one of the states A, B or D
 	 *	3) Regular futex: @pi == false
 	 *
-	 * If these conditions are met, it is safe to attempt waking up a
-	 * potential waiter without touching the user space futex value and
-	 * trying to set the OWNER_DIED bit. If the futex value is zero,
-	 * the rest of the user space mutex state is consistent, so a woken
-	 * waiter will just take over the uncontended futex. Setting the
-	 * OWNER_DIED bit would create inconsistent state and malfunction
-	 * of the user space owner died handling. Otherwise, the OWNER_DIED
-	 * bit is already set, and the woken waiter is expected to deal with
-	 * this.
+	 * Note in particular that in all of the states A-D the owner
+	 * portion of the futex word differs from our thread's TID
+	 * (unless the actual owner has the same TID in another PID
+	 * namespace, but we cannot currently distinguish that
+	 * scenario), so this can be a special-case wakeup in the bail
+	 * path of the ordinary TID check.
 	 */
 	owner = uval & FUTEX_TID_MASK;
 
-	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+	if (owner != task_pid_vnr(curr)) {
+		if (pending_op && !pi && (!owner || !(uval & FUTEX_WAITERS)))
+			futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}
 
-	if (owner != task_pid_vnr(curr))
-		return 0;
-
 	/*
 	 * Ok, this dying thread is truly holding a futex
 	 * of interest. Set the OWNER_DIED bit atomically
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b85045161562..0db033438da6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2654,8 +2654,8 @@ static void trace_module_add_events(struct module *mod)
 	end = mod->trace_events + mod->num_trace_events;
 
 	for_each_event(call, start, end) {
-		__register_event(*call, mod);
-		__add_event_to_tracers(*call);
+		if (!__register_event(*call, mod))
+			__add_event_to_tracers(*call);
 	}
 }
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c79ec6cb73f4..a7a79df59dbe 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -836,6 +836,9 @@ static int regex_match_full(char *str, struct regex *r, int len)
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
 
+	if (len < r->len)
+		return 0;
+
 	return strncmp(str, r->pattern, len) == 0;
 }
 
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 84582bf1ed5f..e8ae2d92a678 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -31,6 +31,7 @@ static void mmio_reset_data(struct trace_array *tr)
 {
 	overrun_detected = false;
 	prev_overruns = 0;
+	atomic_set(&dropped_count, 0);
 
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
@@ -111,7 +112,6 @@ static void mmio_pipe_open(struct trace_iterator *iter)
 	iter->private = hiter;
 }
 
-/* XXX: This is not called when the pipe is closed! */
 static void mmio_close(struct trace_iterator *iter)
 {
 	struct header_iter *hiter = iter->private;
@@ -148,7 +148,7 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		goto print_out;
 	}
 
-	if (!hiter)
+	if (!hiter || !hiter->dev)
 		return 0;
 
 	mmio_print_pcidev(s, hiter->dev);
@@ -281,6 +281,7 @@ static struct tracer mmio_tracer __read_mostly =
 	.start		= mmio_trace_start,
 	.pipe_open	= mmio_pipe_open,
 	.close		= mmio_close,
+	.pipe_close	= mmio_close,
 	.read		= mmio_read,
 	.print_line	= mmio_print_line,
 	.noboot		= true,
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1b822fc561a4..d839736e6f72 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -165,7 +165,7 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
-	if (!trace_probe_log.argv)
+	if (!trace_probe_log.argv || !trace_probe_log.argc)
 		return;
 
 	/* Recalcurate the length and allocate buffer */
@@ -842,7 +842,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
 }
 
 /* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
+#define LEN_OR_ZERO (len > pos ? len - pos : 0)
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   bool is_return)
 {
@@ -1150,16 +1150,17 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 bool trace_probe_match_command_args(struct trace_probe *tp,
 				    int argc, const char **argv)
 {
-	char buf[MAX_ARGSTR_LEN + 1];
 	int i;
 
 	if (tp->nr_args < argc)
 		return false;
 
 	for (i = 0; i < argc; i++) {
-		snprintf(buf, sizeof(buf), "%s=%s",
-			 tp->args[i].name, tp->args[i].comm);
-		if (strcmp(buf, argv[i]))
+		int len = strlen(tp->args[i].name);
+
+		if (strncmp(argv[i], tp->args[i].name, len) ||
+		    argv[i][len] != '=' ||
+		    strcmp(argv[i] + len + 1, tp->args[i].comm))
 			return false;
 	}
 	return true;
diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index b537a83678e1..f70098683019 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -255,7 +255,8 @@ assoc_array_walk(const struct assoc_array *array,
 		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
 		dissimilarity = segments ^ sc_segments;
 
-		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
+		if (shortcut->skip_to_level < round_down(sc_level,
+				ASSOC_ARRAY_KEY_CHUNK_SIZE) + ASSOC_ARRAY_KEY_CHUNK_SIZE) {
 			/* Trim segments that are beyond the shortcut */
 			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
 			dissimilarity &= ~(ULONG_MAX << shift);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c949c1e3b87c..4def63ec1f65 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -730,6 +730,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
 		iter->slot = 0;
 		iter->skip = 0;
+		iter->p = NULL;
 		return -EAGAIN;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fdcf89e3b1d2..f620861d0099 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2445,7 +2445,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end, unsigned long flags, struct address_space *mapping)
 {
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
@@ -2515,6 +2515,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		split_swap_cluster(entry);
 	}
 
+	/*
+	 * Drop the mapping while the head page is still locked and thus pins
+	 * the inode. The loop below may free the after-split subpages --
+	 * including the head, when @page is a tail beyond EOF that the split
+	 * dropped from the page cache -- which could otherwise let the inode,
+	 * and @mapping, be freed before this unlock.
+	 */
+	if (mapping)
+		i_mmap_unlock_read(mapping);
+
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
@@ -2746,7 +2756,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end, flags, mapping);
+		/* __split_huge_page() dropped the i_mmap lock */
+		mapping = NULL;
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef556f6fe970..70fe6a11daba 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -482,7 +482,7 @@ static int allocate_file_region_entries(struct resv_map *resv,
 
 		spin_lock(&resv->lock);
 
-		list_splice(&allocated_regions, &resv->region_cache);
+		list_splice_init(&allocated_regions, &resv->region_cache);
 		resv->region_cache_count += to_allocate;
 	}
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cd8e13d41df4..6014e616584c 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -43,7 +43,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	queue_delayed_work(system_freezable_wq, &prdev->work,
+			   PAGE_REPORTING_DELAY);
 }
 
 /* notify prdev of free page reporting request */
@@ -306,7 +307,8 @@ static void page_reporting_process(struct work_struct *work)
 	 */
 	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state == PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		queue_delayed_work(system_freezable_wq, &prdev->work,
+				   PAGE_REPORTING_DELAY);
 }
 
 static DEFINE_MUTEX(page_reporting_mutex);
diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 35c9941077ee..3d44e3eb1363 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -70,7 +70,7 @@ static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
 	chunk->base_addr = page_address(pages);
 
 	spin_lock_irqsave(&pcpu_lock, flags);
-	pcpu_chunk_populated(chunk, 0, nr_pages);
+	pcpu_chunk_populated(chunk, 0, chunk->nr_pages);
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	pcpu_stats_chunk_alloc();
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 096f6fc5d30b..a71855268d33 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -804,20 +804,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_btle_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	bool last = false, remove = true;
+	bool last = false;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	if (chan->conn && chan->conn->hcon) {
-		if (!is_bt_6lowpan(chan->conn->hcon))
-			return;
-
-		/* If conn is set, then the netdev is also there and we should
-		 * not remove it.
-		 */
-		remove = false;
-	}
-
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -844,10 +834,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (remove) {
-			INIT_WORK(&entry->delete_netdev, delete_netdev);
-			schedule_work(&entry->delete_netdev);
-		}
+		INIT_WORK(&entry->delete_netdev, delete_netdev);
+		schedule_work(&entry->delete_netdev);
 	} else {
 		spin_unlock(&devices_lock);
 	}
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b983ec52a99a..16bea865e6d6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -184,6 +184,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	const struct cred *old_cred;
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 068c3c250517..225f5305cbcb 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -533,9 +533,10 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 	}
 
 	if (test_bit(HIDP_WAITING_FOR_RETURN, &session->flags) &&
-				param == session->waiting_report_type) {
+	    param == session->waiting_report_type) {
 		if (session->waiting_report_number < 0 ||
-		    session->waiting_report_number == skb->data[0]) {
+		    (skb->len &&
+		     session->waiting_report_number == skb->data[0])) {
 			/* hidp_get_raw_report() is waiting on this report. */
 			session->report_return = skb;
 			done_with_skb = 0;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6649532712f4..1c2114930f86 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -435,7 +435,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn) {
+	if (!conn || test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_put(chan);
 		return;
 	}
@@ -446,6 +446,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -458,10 +461,11 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -511,6 +515,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn)
+		l2cap_conn_put(chan->conn);
+
 	kfree(chan);
 }
 
@@ -593,7 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -648,31 +655,28 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
-	struct l2cap_conn *conn = chan->conn;
-
 	__clear_chan_timer(chan);
 
-	BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
+	BT_DBG("chan %p, err %d, state %s", chan, err,
 	       state_to_string(chan->state));
 
 	chan->ops->teardown(chan, err);
 
-	if (conn) {
-		struct amp_mgr *mgr = conn->hcon->amp_mgr;
+	if (chan->conn && !test_and_set_bit(FLAG_DEL, &chan->flags)) {
+		struct amp_mgr *mgr = chan->conn->hcon->amp_mgr;
+
 		/* Delete from channel list */
 		list_del(&chan->list);
 
 		l2cap_chan_put(chan);
 
-		chan->conn = NULL;
-
 		/* Reference was only held for non-fixed channels or
 		 * fixed channels that explicitly requested it using the
 		 * FLAG_HOLD_HCI_CONN flag.
 		 */
 		if (chan->chan_type != L2CAP_CHAN_FIXED ||
 		    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
-			hci_conn_drop(conn->hcon);
+			hci_conn_drop(chan->conn->hcon);
 
 		if (mgr && mgr->bredr_chan == chan)
 			mgr->bredr_chan = NULL;
@@ -2046,7 +2050,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (!chan->conn || test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2067,7 +2071,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (!chan->conn || test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2692,7 +2696,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	int err;
 	struct sk_buff_head seg_queue;
 
-	if (!chan->conn)
+	if (!chan->conn || test_bit(FLAG_DEL, &chan->flags))
 		return -ENOTCONN;
 
 	/* Connectionless channel */
@@ -3293,12 +3297,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	frames_to_ack = __seq_offset(chan, chan->buffer_seq,
 				     chan->last_acked_seq);
 
 	if (frames_to_ack)
 		l2cap_send_rr_or_rnr(chan, 0);
 
+unlock:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
@@ -5744,6 +5752,10 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		return -EBADSLT;
+
 	err = 0;
 
 	l2cap_chan_lock(chan);
@@ -5789,6 +5801,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	}
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 unlock:
 	mutex_unlock(&conn->chan_lock);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4f54c7df3a94..4543f536c127 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1027,6 +1027,23 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 	return rfcomm_send_frame(s, buf, ptr - buf);
 }
 
+int rfcomm_dlc_send_rpn(struct rfcomm_dlc *d, u8 bit_rate, u8 data_bits,
+			u8 stop_bits, u8 parity, u8 flow_ctrl_settings,
+			u8 xon_char, u8 xoff_char, u16 param_mask)
+{
+	int err = -ENOTCONN;
+
+	rfcomm_lock();
+	if (d->session)
+		err = rfcomm_send_rpn(d->session, 1, d->dlci, bit_rate,
+				      data_bits, stop_bits, parity,
+				      flow_ctrl_settings, xon_char, xoff_char,
+				      param_mask);
+	rfcomm_unlock();
+
+	return err;
+}
+
 static int rfcomm_send_rls(struct rfcomm_session *s, int cr, u8 dlci, u8 status)
 {
 	struct rfcomm_hdr *hdr;
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a58584949a95..6959ab16c2c6 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -866,7 +866,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 
 	BT_DBG("tty %p termios %p", tty, old);
 
-	if (!dev || !dev->dlc || !dev->dlc->session)
+	if (!dev || !dev->dlc)
 		return;
 
 	/* Handle turning off CRTSCTS */
@@ -987,9 +987,8 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	}
 
 	if (changes)
-		rfcomm_send_rpn(dev->dlc->session, 1, dev->dlc->dlci, baud,
-				data_bits, stop_bits, parity,
-				RFCOMM_RPN_FLOW_NONE, x_on, x_off, changes);
+		rfcomm_dlc_send_rpn(dev->dlc, baud, data_bits, stop_bits, parity,
+				    RFCOMM_RPN_FLOW_NONE, x_on, x_off, changes);
 }
 
 static void rfcomm_tty_throttle(struct tty_struct *tty)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 01a01d6f01c3..b49b2d6bb778 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -87,9 +97,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -192,11 +200,10 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-		sock_hold(sk);
 		bh_lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
@@ -305,7 +312,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -314,11 +321,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e5328a2777ec..ab04397dfe36 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2838,6 +2838,7 @@ br_multicast_leave_group(struct net_bridge *br,
 
 			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
 			br_multicast_del_pg(mp, p, pp);
+			break;
 		}
 		goto out;
 	}
diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 8914290c75d4..e4aab0775270 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -268,7 +268,8 @@ static void __vlan_tunnel_handle_range(const struct net_bridge_port *p,
 	if (!*v_start)
 		goto out_init;
 
-	if (v && curr_change && br_vlan_can_enter_range(v, *v_end)) {
+	if (v && curr_change &&
+	    br_vlan_can_enter_range(v, *v_end, br_get_pvid(vg))) {
 		*v_end = v;
 		return;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 19d77a8721fa..17327852c807 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1093,7 +1093,8 @@ void br_vlan_notify(const struct net_bridge *br,
 		    u16 vid, u16 vid_range,
 		    int cmd);
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end);
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid);
 
 static inline struct net_bridge_vlan_group *br_vlan_group(
 					const struct net_bridge *br)
@@ -1309,7 +1310,8 @@ static inline void br_vlan_notify(const struct net_bridge *br,
 }
 
 static inline bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-					   const struct net_bridge_vlan *range_end)
+					   const struct net_bridge_vlan *range_end,
+					   u16 pvid)
 {
 	return true;
 }
@@ -1327,6 +1329,14 @@ int br_vlan_process_options(const struct net_bridge *br,
 			    struct net_bridge_vlan *range_end,
 			    struct nlattr **tb,
 			    struct netlink_ext_ack *extack);
+int br_vlan_rtm_process_global_options(struct net_device *dev,
+				       const struct nlattr *attr,
+				       int cmd,
+				       struct netlink_ext_ack *extack);
+bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
+					 const struct net_bridge_vlan *r_end);
+bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
+			      const struct net_bridge_vlan *v_opts);
 
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1dc5db07650c..759bed457d9f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1764,9 +1764,11 @@ void br_vlan_notify(const struct net_bridge *br,
 
 /* check if v_curr can enter a range ending in range_end */
 bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
-			     const struct net_bridge_vlan *range_end)
+			     const struct net_bridge_vlan *range_end,
+			     u16 pvid)
 {
-	return v_curr->vid - range_end->vid == 1 &&
+	return v_curr->vid != pvid && range_end->vid != pvid &&
+	       v_curr->vid - range_end->vid == 1 &&
 	       range_end->flags == v_curr->flags &&
 	       br_vlan_opts_eq_range(v_curr, range_end);
 }
@@ -1777,6 +1779,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 			    u32 dump_flags)
 {
 	struct net_bridge_vlan *v, *range_start = NULL, *range_end = NULL;
+	bool dump_global = !!(dump_flags & BRIDGE_VLANDB_DUMPF_GLOBAL);
 	bool dump_stats = !!(dump_flags & BRIDGE_VLANDB_DUMPF_STATS);
 	struct net_bridge_vlan_group *vg;
 	int idx = 0, s_idx = cb->args[1];
@@ -1795,6 +1798,10 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 		vg = br_vlan_group_rcu(br);
 		p = NULL;
 	} else {
+		/* global options are dumped only for bridge devices */
+		if (dump_global)
+			return 0;
+
 		p = br_port_get_rcu(dev);
 		if (WARN_ON(!p))
 			return -EINVAL;
@@ -1817,7 +1824,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 
 	/* idx must stay at range's beginning until it is filled in */
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (!br_vlan_should_use(v))
+		if (!dump_global && !br_vlan_should_use(v))
 			continue;
 		if (idx < s_idx) {
 			idx++;
@@ -1830,8 +1837,21 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 			continue;
 		}
 
-		if (dump_stats || v->vid == pvid ||
-		    !br_vlan_can_enter_range(v, range_end)) {
+		if (dump_global) {
+			if (br_vlan_global_opts_can_enter_range(v, range_end))
+				goto update_end;
+			if (!br_vlan_global_opts_fill(skb, range_start->vid,
+						      range_end->vid,
+						      range_start)) {
+				err = -EMSGSIZE;
+				break;
+			}
+			/* advance number of filled vlans */
+			idx += range_end->vid - range_start->vid + 1;
+
+			range_start = v;
+		} else if (dump_stats ||
+			   !br_vlan_can_enter_range(v, range_end, pvid)) {
 			u16 vlan_flags = br_vlan_flags(range_start, pvid);
 
 			if (!br_vlan_fill_vids(skb, range_start->vid,
@@ -1845,6 +1865,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 
 			range_start = v;
 		}
+update_end:
 		range_end = v;
 	}
 
@@ -1853,11 +1874,18 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 	 * - last vlan (range_start == range_end, not in range)
 	 * - last vlan range (range_start != range_end, in range)
 	 */
-	if (!err && range_start &&
-	    !br_vlan_fill_vids(skb, range_start->vid, range_end->vid,
-			       range_start, br_vlan_flags(range_start, pvid),
-			       dump_stats))
-		err = -EMSGSIZE;
+	if (!err && range_start) {
+		if (dump_global &&
+		    !br_vlan_global_opts_fill(skb, range_start->vid,
+					      range_end->vid, range_start))
+			err = -EMSGSIZE;
+		else if (!dump_global &&
+			 !br_vlan_fill_vids(skb, range_start->vid,
+					    range_end->vid, range_start,
+					    br_vlan_flags(range_start, pvid),
+					    dump_stats))
+			err = -EMSGSIZE;
+	}
 
 	cb->args[1] = err ? idx : 0;
 
@@ -2062,12 +2090,22 @@ static int br_vlan_rtm_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	nlmsg_for_each_attr(attr, nlh, sizeof(*bvm), rem) {
-		if (nla_type(attr) != BRIDGE_VLANDB_ENTRY)
+		switch (nla_type(attr)) {
+		case BRIDGE_VLANDB_ENTRY:
+			err = br_vlan_rtm_process_one(dev, attr,
+						      nlh->nlmsg_type,
+						      extack);
+			break;
+		case BRIDGE_VLANDB_GLOBAL_OPTIONS:
+			err = br_vlan_rtm_process_global_options(dev, attr,
+								 nlh->nlmsg_type,
+								 extack);
+			break;
+		default:
 			continue;
+		}
 
 		vlans++;
-		err = br_vlan_rtm_process_one(dev, attr, nlh->nlmsg_type,
-					      extack);
 		if (err)
 			break;
 	}
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index b4add9ea8964..29fb37e7046a 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -234,8 +234,7 @@ int br_vlan_process_options(const struct net_bridge *br,
 				continue;
 			}
 
-			if (v->vid == pvid ||
-			    !br_vlan_can_enter_range(v, curr_end)) {
+			if (!br_vlan_can_enter_range(v, curr_end, pvid)) {
 				br_vlan_notify(br, p, curr_start->vid,
 					       curr_end->vid, RTM_NEWVLAN);
 				curr_start = v;
@@ -258,3 +257,119 @@ int br_vlan_process_options(const struct net_bridge *br,
 
 	return err;
 }
+
+bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
+					 const struct net_bridge_vlan *r_end)
+{
+	return v_curr->vid - r_end->vid == 1;
+}
+
+bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
+			      const struct net_bridge_vlan *v_opts)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, BRIDGE_VLANDB_GLOBAL_OPTIONS);
+	if (!nest)
+		return false;
+
+	if (nla_put_u16(skb, BRIDGE_VLANDB_GOPTS_ID, vid))
+		goto out_err;
+
+	if (vid_range && vid < vid_range &&
+	    nla_put_u16(skb, BRIDGE_VLANDB_GOPTS_RANGE, vid_range))
+		goto out_err;
+
+	nla_nest_end(skb, nest);
+
+	return true;
+
+out_err:
+	nla_nest_cancel(skb, nest);
+	return false;
+}
+
+static int br_vlan_process_global_one_opts(const struct net_bridge *br,
+					   struct net_bridge_vlan_group *vg,
+					   struct net_bridge_vlan *v,
+					   struct nlattr **tb,
+					   bool *changed,
+					   struct netlink_ext_ack *extack)
+{
+	*changed = false;
+	return 0;
+}
+
+static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
+	[BRIDGE_VLANDB_GOPTS_ID]	= { .type = NLA_U16 },
+	[BRIDGE_VLANDB_GOPTS_RANGE]	= { .type = NLA_U16 },
+};
+
+int br_vlan_rtm_process_global_options(struct net_device *dev,
+				       const struct nlattr *attr,
+				       int cmd,
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[BRIDGE_VLANDB_GOPTS_MAX + 1];
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	u16 vid, vid_range = 0;
+	struct net_bridge *br;
+	int err = 0;
+
+	if (cmd != RTM_NEWVLAN) {
+		NL_SET_ERR_MSG_MOD(extack, "Global vlan options support only set operation");
+		return -EINVAL;
+	}
+	if (!netif_is_bridge_master(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Global vlan options can only be set on bridge device");
+		return -EINVAL;
+	}
+	br = netdev_priv(dev);
+	vg = br_vlan_group(br);
+	if (WARN_ON(!vg))
+		return -ENODEV;
+
+	err = nla_parse_nested(tb, BRIDGE_VLANDB_GOPTS_MAX, attr,
+			       br_vlan_db_gpol, extack);
+	if (err)
+		return err;
+
+	if (!tb[BRIDGE_VLANDB_GOPTS_ID]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing vlan entry id");
+		return -EINVAL;
+	}
+	vid = nla_get_u16(tb[BRIDGE_VLANDB_GOPTS_ID]);
+	if (!br_vlan_valid_id(vid, extack))
+		return -EINVAL;
+
+	if (tb[BRIDGE_VLANDB_GOPTS_RANGE]) {
+		vid_range = nla_get_u16(tb[BRIDGE_VLANDB_GOPTS_RANGE]);
+		if (!br_vlan_valid_id(vid_range, extack))
+			return -EINVAL;
+		if (vid >= vid_range) {
+			NL_SET_ERR_MSG_MOD(extack, "End vlan id is less than or equal to start vlan id");
+			return -EINVAL;
+		}
+	} else {
+		vid_range = vid;
+	}
+
+	for (; vid <= vid_range; vid++) {
+		bool changed = false;
+
+		v = br_vlan_find(vg, vid);
+		if (!v) {
+			NL_SET_ERR_MSG_MOD(extack, "Vlan in range doesn't exist, can't process global options");
+			err = -ENOENT;
+			break;
+		}
+
+		err = br_vlan_process_global_one_opts(br, vg, v, tb, &changed,
+						      extack);
+		if (err)
+			break;
+	}
+
+	return err;
+}
diff --git a/net/bridge/netfilter/ebt_nflog.c b/net/bridge/netfilter/ebt_nflog.c
index 61bf8f4465ab..426f8adc912c 100644
--- a/net/bridge/netfilter/ebt_nflog.c
+++ b/net/bridge/netfilter/ebt_nflog.c
@@ -41,11 +41,25 @@ ebt_nflog_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int ebt_nflog_tg_check(const struct xt_tgchk_param *par)
 {
 	struct ebt_nflog_info *info = par->targinfo;
+	int ret;
 
 	if (info->flags & ~EBT_NFLOG_MASK)
 		return -EINVAL;
 	info->prefix[EBT_NFLOG_PREFIX_SIZE - 1] = '\0';
-	return 0;
+
+	ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	if (ret != 0 && !par->nft_compat) {
+		request_module("%s", "nfnetlink_log");
+
+		ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	}
+
+	return ret;
+}
+
+static void ebt_nflog_tg_destroy(const struct xt_tgdtor_param *par)
+{
+	nf_logger_put(par->family, NF_LOG_TYPE_ULOG);
 }
 
 static struct xt_target ebt_nflog_tg_reg __read_mostly = {
@@ -54,6 +68,7 @@ static struct xt_target ebt_nflog_tg_reg __read_mostly = {
 	.family     = NFPROTO_BRIDGE,
 	.target     = ebt_nflog_tg,
 	.checkentry = ebt_nflog_tg_check,
+	.destroy    = ebt_nflog_tg_destroy,
 	.targetsize = sizeof(struct ebt_nflog_info),
 	.me         = THIS_MODULE,
 };
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index abf0c9460ddf..b92069de927f 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -280,6 +280,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
+		nf_reset_ct(skb);
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
 		return NF_ACCEPT;
 	}
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 06ee3bfe87c9..f655764aae83 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -89,6 +90,8 @@ MODULE_ALIAS("can-proto-2");
 
 #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
 
+static struct workqueue_struct *bcm_wq;
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
@@ -102,14 +105,16 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
+	int if_detected; /* first received ifindex in ANYDEV rx_op mode */
 	int cfsiz;
 	u32 count;
 	u32 nframes;
@@ -121,7 +126,8 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
-	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
+	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
@@ -211,10 +217,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
-		unsigned long reduction;
+		long reduction, frames_filtered, frames_abs;
+
+		frames_filtered = atomic_long_read(&op->frames_filtered);
+		frames_abs = atomic_long_read(&op->frames_abs);
 
 		/* print only active entries & prevent division by zero */
-		if (!op->frames_abs)
+		if (!frames_abs)
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
@@ -236,9 +245,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   frames_filtered, frames_abs);
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 - (frames_filtered * 100) / frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
@@ -262,7 +271,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
@@ -272,25 +282,49 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_PROC_FS */
 
+static void bcm_update_rx_stats(struct bcm_op *op)
+{
+	/* prevent overflow of the reduction% calculation in bcm_proc_show() */
+	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
+}
+
+static void bcm_update_tx_stats(struct bcm_op *op)
+{
+	/* tx_op has no reduction% calculation - use the full range and
+	 * just keep the displayed counter non-negative on overflow
+	 */
+	if (atomic_long_inc_return(&op->frames_abs) == LONG_MAX)
+		atomic_long_set(&op->frames_abs, 0);
+}
+
 /*
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
-static void bcm_can_tx(struct bcm_op *op)
+static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf;
+	struct canfd_frame cframe;
+	bool cyclic = !cf;
+	unsigned int idx = 0;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
-	/* read currframe under lock protection */
-	spin_lock_bh(&op->bcm_tx_lock);
-	cf = op->frames + op->cfsiz * op->currframe;
-	spin_unlock_bh(&op->bcm_tx_lock);
+	if (cyclic) {
+		/* read currframe under lock protection */
+		spin_lock_bh(&op->bcm_tx_lock);
+		idx = op->currframe;
+		memcpy(&cframe, op->frames + op->cfsiz * idx, op->cfsiz);
+		cf = &cframe;
+		spin_unlock_bh(&op->bcm_tx_lock);
+	}
 
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
@@ -317,16 +351,22 @@ static void bcm_can_tx(struct bcm_op *op)
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_tx_stats(op);
 
-	op->currframe++;
+	/* only advance the cyclic sequence if nothing reset currframe while
+	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
+	 * frame's bookkeeping belongs to a sequence that no longer exists
+	 */
+	if (!cyclic || op->currframe == idx) {
+		op->currframe++;
 
-	/* reached last frame? */
-	if (op->currframe >= op->nframes)
-		op->currframe = 0;
+		/* reached last frame? */
+		if (op->currframe >= op->nframes)
+			op->currframe = 0;
 
-	if (op->count > 0)
-		op->count--;
+		if (op->count > 0)
+			op->count--;
+	}
 
 	spin_unlock_bh(&op->bcm_tx_lock);
 out:
@@ -401,12 +441,18 @@ static bool bcm_tx_set_expiry(struct bcm_op *op, struct hrtimer *hrt)
 {
 	ktime_t ival;
 
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (op->kt_ival1 && op->count)
 		ival = op->kt_ival1;
-	else if (op->kt_ival2)
+	else if (op->kt_ival2) {
 		ival = op->kt_ival2;
-	else
+	} else {
+		spin_unlock_bh(&op->bcm_tx_lock);
 		return false;
+	}
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 
 	hrtimer_set_expires(hrt, ktime_add(ktime_get(), ival));
 	return true;
@@ -423,26 +469,48 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
+	bool tx_ival1, tx_ival2;
 
-	if (op->kt_ival1 && (op->count > 0)) {
-		bcm_can_tx(op);
-		if (!op->count && (op->flags & TX_COUNTEVT)) {
+	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
+	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
+	 */
+	spin_lock_bh(&op->bcm_tx_lock);
+	tx_ival1 = op->kt_ival1 && (op->count > 0);
+	tx_ival2 = !!op->kt_ival2;
+	spin_unlock_bh(&op->bcm_tx_lock);
 
+	if (tx_ival1) {
+		u32 flags, count;
+		struct bcm_timeval ival1, ival2;
+
+		bcm_can_tx(op, NULL);
+
+		/* snapshot variables under lock to avoid torn reads racing
+		 * with concurrent bcm_tx_setup() updates
+		 */
+		spin_lock_bh(&op->bcm_tx_lock);
+		flags = op->flags;
+		count = op->count;
+		ival1 = op->ival1;
+		ival2 = op->ival2;
+		spin_unlock_bh(&op->bcm_tx_lock);
+
+		if (!count && (flags & TX_COUNTEVT)) {
 			/* create notification to user */
 			memset(&msg_head, 0, sizeof(msg_head));
 			msg_head.opcode  = TX_EXPIRED;
-			msg_head.flags   = op->flags;
-			msg_head.count   = op->count;
-			msg_head.ival1   = op->ival1;
-			msg_head.ival2   = op->ival2;
+			msg_head.flags   = flags;
+			msg_head.count   = count;
+			msg_head.ival1   = ival1;
+			msg_head.ival2   = ival2;
 			msg_head.can_id  = op->can_id;
 			msg_head.nframes = 0;
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
 
-	} else if (op->kt_ival2) {
-		bcm_can_tx(op);
+	} else if (tx_ival2) {
+		bcm_can_tx(op, NULL);
 	}
 
 	return bcm_tx_set_expiry(op, &op->timer) ?
@@ -456,12 +524,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
-	/* update statistics */
-	op->frames_filtered++;
-
-	/* prevent statistics overflow */
-	if (op->frames_filtered > ULONG_MAX/100)
-		op->frames_filtered = op->frames_abs = 0;
+	/* update statistics (frames_filtered <= frames_abs) */
+	if (atomic_long_read(&op->frames_abs))
+		atomic_long_inc(&op->frames_filtered);
 
 	/* this element is not throttled anymore */
 	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
@@ -581,6 +646,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	/* if user wants to be informed, when cyclic CAN-Messages come back */
 	if ((op->flags & RX_ANNOUNCE_RESUME) && op->last_frames) {
 		/* clear received CAN frames to indicate 'nothing received' */
@@ -597,6 +664,8 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
@@ -645,15 +714,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
 static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, thrtimer);
+	enum hrtimer_restart ret;
 
-	if (bcm_rx_thr_flush(op)) {
-		hrtimer_forward(hrtimer, ktime_get(), op->kt_ival2);
-		return HRTIMER_RESTART;
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
+	/* kt_ival2 may have been concurrently cleared by bcm_rx_setup()
+	 * before it cancels this timer - never forward with a zero
+	 * interval in that case.
+	 */
+	if (bcm_rx_thr_flush(op) && op->kt_ival2) {
+		hrtimer_forward_now(hrtimer, op->kt_ival2);
+		ret = HRTIMER_RESTART;
 	} else {
 		/* rearm throttle handling */
 		op->kt_lastmsg = 0;
-		return HRTIMER_NORESTART;
+		ret = HRTIMER_NORESTART;
 	}
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	return ret;
 }
 
 /*
@@ -663,7 +743,9 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
+	struct canfd_frame rtrframe;
 	unsigned int i;
+	bool rtr_frame;
 
 	if (op->can_id != rxframe->can_id)
 		return;
@@ -672,22 +754,66 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	if (skb->len != op->cfsiz)
 		return;
 
+	/* An ANYDEV op with an active RX timeout and/or throttle timer
+	 * tracks a single source interface: claim the first interface that
+	 * delivers a matching frame and reject frames from any other one,
+	 * before hrtimer_cancel() below can touch op->timer - this avoids
+	 * racing bcm_rx_timeout_handler() across concurrent interfaces.
+	 * RX_RTR_FRAME ops are excluded, as kt_ival1/kt_ival2 may briefly
+	 * hold a stale value from an earlier non-RTR configuration.
+	 */
+	if (!op->ifindex) {
+		spin_lock_bh(&op->bcm_rx_update_lock);
+
+		if (!(op->flags & RX_RTR_FRAME) &&
+		    (op->kt_ival1 || op->kt_ival2)) {
+			/* don't claim to vanishing interface */
+			if (!op->if_detected &&
+			    skb->dev->reg_state == NETREG_REGISTERED)
+				op->if_detected = skb->dev->ifindex;
+
+			if (op->if_detected != skb->dev->ifindex) {
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+				return;
+			}
+		}
+
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+	}
+
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-	/* update statistics */
-	op->frames_abs++;
+	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
+	rtr_frame = op->flags & RX_RTR_FRAME;
+	if (rtr_frame) {
+		bcm_update_rx_stats(op);
+		/* snapshot RTR content under lock */
+		memcpy(&rtrframe, op->frames, op->cfsiz);
+		spin_unlock_bh(&op->bcm_rx_update_lock);
 
-	if (op->flags & RX_RTR_FRAME) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
-		bcm_can_tx(op);
+		bcm_can_tx(op, &rtrframe);
 		return;
 	}
 
+	/* update statistics in the same critical section as bcm_rx_changed()
+	 * below: frames_filtered must never be checked/incremented against a
+	 * frames_abs snapshot from a concurrent bcm_rx_handler() call on
+	 * another CPU for the same (wildcard) op, or frames_filtered can end
+	 * up larger than frames_abs.
+	 */
+	bcm_update_rx_stats(op);
+
+	/* save rx timestamp and originator for recvfrom() under lock: an
+	 * ANYDEV op without an active timer can still run concurrently on
+	 * different CPUs, so content and meta data must be bundled here.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe);
@@ -721,6 +847,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 rx_starttimer:
 	bcm_rx_starttimer(op);
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
 }
 
 /*
@@ -740,9 +868,12 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	return NULL;
 }
 
-static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+static void bcm_free_op_work(struct work_struct *work)
 {
-	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+	struct bcm_op *op = container_of(work, struct bcm_op, work);
+
+	hrtimer_cancel(&op->timer);
+	hrtimer_cancel(&op->thrtimer);
 
 	if ((op->frames) && (op->frames != &op->sframe))
 		kfree(op->frames);
@@ -750,9 +881,23 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
+	/* the last possible access to op->timer/op->thrtimer has now
+	 * happened above via hrtimer_cancel() - op->sk is no longer
+	 * needed by any pending timer callback, so drop our reference
+	 */
+	sock_put(op->sk);
+
 	kfree(op);
 }
 
+static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+{
+	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+
+	INIT_WORK(&op->work, bcm_free_op_work);
+	queue_work(bcm_wq, &op->work);
+}
+
 static void bcm_remove_op(struct bcm_op *op)
 {
 	hrtimer_cancel(&op->timer);
@@ -769,6 +914,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		dev_put(dev);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
@@ -799,17 +945,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 				 * Only remove subscriptions that had not
 				 * been removed due to NETDEV_UNREGISTER
 				 * in bcm_notifier()
+				 *
+				 * op->rx_reg_dev is a tracked reference taken
+				 * when the subscription was registered, so it
+				 * stays valid here even if a concurrent
+				 * NETDEV_UNREGISTER already unlisted the dev.
 				 */
-				if (op->rx_reg_dev) {
-					struct net_device *dev;
-
-					dev = dev_get_by_index(sock_net(op->sk),
-							       op->ifindex);
-					if (dev) {
-						bcm_rx_unreg(dev, op);
-						dev_put(dev);
-					}
-				}
+				if (op->rx_reg_dev)
+					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
 						  op->can_id,
@@ -896,6 +1039,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames;
+
 		/* update existing BCM operation */
 
 		/*
@@ -906,11 +1051,23 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
-		/* update CAN frames content */
+		/* get new CAN frames content into a staging buffer before
+		 * locking: validate and normalize the frames there so that
+		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
+		 * partially updated or unvalidated frame in op->frames
+		 */
+		new_frames = kmalloc(msg_head->nframes * op->cfsiz, GFP_KERNEL);
+		if (!new_frames)
+			return -ENOMEM;
+
 		for (i = 0; i < msg_head->nframes; i++) {
 
-			cf = op->frames + op->cfsiz * i;
+			cf = new_frames + op->cfsiz * i;
 			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 
 			if (op->flags & CAN_FD_FRAME) {
 				if (cf->len > 64)
@@ -920,36 +1077,38 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					err = -EINVAL;
 			}
 
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
+			}
 
 			if (msg_head->flags & TX_CP_CAN_ID) {
 				/* copy can_id into frame */
 				cf->can_id = msg_head->can_id;
 			}
 		}
+
+		spin_lock_bh(&op->bcm_tx_lock);
+
+		/* update CAN frames content */
+		memcpy(op->frames, new_frames, msg_head->nframes * op->cfsiz);
+
 		op->flags = msg_head->flags;
 
-		/* only lock for unlikely count/nframes/currframe changes */
 		if (op->nframes != msg_head->nframes ||
-		    op->flags & TX_RESET_MULTI_IDX ||
-		    op->flags & SETTIMER) {
-
-			spin_lock_bh(&op->bcm_tx_lock);
+		    op->flags & TX_RESET_MULTI_IDX) {
+			/* potentially update changed nframes */
+			op->nframes = msg_head->nframes;
+			/* restart multiple frame transmission */
+			op->currframe = 0;
+		}
 
-			if (op->nframes != msg_head->nframes ||
-			    op->flags & TX_RESET_MULTI_IDX) {
-				/* potentially update changed nframes */
-				op->nframes = msg_head->nframes;
-				/* restart multiple frame transmission */
-				op->currframe = 0;
-			}
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
-			if (op->flags & SETTIMER)
-				op->count = msg_head->count;
+		spin_unlock_bh(&op->bcm_tx_lock);
 
-			spin_unlock_bh(&op->bcm_tx_lock);
-		}
+		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
@@ -1008,6 +1167,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
@@ -1025,10 +1185,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
+		spin_lock_bh(&op->bcm_tx_lock);
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+		spin_unlock_bh(&op->bcm_tx_lock);
 
 		/* disable an active timer due to zero values? */
 		if (!op->kt_ival1 && !op->kt_ival2)
@@ -1046,7 +1208,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		list_add_rcu(&op->list, &bo->tx_ops);
 
 	if (op->flags & TX_ANNOUNCE)
-		bcm_can_tx(op);
+		bcm_can_tx(op, NULL);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1060,6 +1222,39 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	return err;
 }
 
+static int bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				  struct bcm_op *op, void *new_frames)
+{
+	struct canfd_frame *frame0 = new_frames;
+
+	if (!(msg_head->flags & RX_RTR_FRAME))
+		return 0;
+
+	/* this frame is sent out as-is by bcm_can_tx() whenever a matching
+	 * remote request is received, so validate its length the same way
+	 * bcm_tx_setup() validates TX_SETUP frames before installing it
+	 */
+	if (msg_head->flags & CAN_FD_FRAME) {
+		if (frame0->len > 64)
+			return -EINVAL;
+	} else {
+		if (frame0->len > 8)
+			return -EINVAL;
+	}
+
+	/* funny feature in RX(!)_SETUP only for RTR-mode:
+	 * copy can_id into frame BUT without RTR-flag to
+	 * prevent a full-load-loopback-test ... ;-]
+	 * normalize this on the staged buffer, before it is
+	 * ever installed into op->frames.
+	 */
+	if ((msg_head->flags & TX_CP_CAN_ID) ||
+	    frame0->can_id == op->can_id)
+		frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
+
+	return 0;
+}
+
 /*
  * bcm_rx_setup - create or update a bcm rx op (for bcm_sendmsg)
  */
@@ -1069,6 +1264,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	int do_rx_register;
+	int new_op = 0;
 	int err = 0;
 
 	if ((msg_head->flags & RX_FILTER_ID) || (!(msg_head->nframes))) {
@@ -1094,6 +1290,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames = NULL;
+
 		/* update existing BCM operation */
 
 		/*
@@ -1105,21 +1303,62 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -E2BIG;
 
 		if (msg_head->nframes) {
-			/* update CAN frames content */
-			err = memcpy_from_msg(op->frames, msg,
+			/* get new CAN frames content before locking */
+			new_frames = kmalloc(msg_head->nframes * op->cfsiz,
+					     GFP_KERNEL);
+			if (!new_frames)
+				return -ENOMEM;
+
+			err = memcpy_from_msg(new_frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
+			}
 
-			/* clear last_frames to indicate 'nothing received' */
-			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
+			err = bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 		}
 
+		spin_lock_bh(&op->bcm_rx_update_lock);
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
 
-		/* Only an update -> do not call can_rx_register() */
-		do_rx_register = 0;
+		if (msg_head->nframes) {
+			/* update CAN frames content */
+			memcpy(op->frames, new_frames,
+			       msg_head->nframes * op->cfsiz);
+
+			/* clear last_frames to indicate 'nothing received' */
+			memset(op->last_frames, 0,
+			       msg_head->nframes * op->cfsiz);
+		}
+
+		if (msg_head->flags & SETTIMER) {
+			op->ival1 = msg_head->ival1;
+			op->ival2 = msg_head->ival2;
+			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			op->kt_lastmsg = 0;
+			op->if_detected = 0; /* reclaim ifindex in ANYDEV mode */
+		}
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+
+		/* free temporary frames / kfree(NULL) is safe */
+		kfree(new_frames);
+
+		/* Don't register a new CAN filter for the rx_op update unless
+		 * a concurrent NETDEV_UNREGISTER notifier already tore down
+		 * the previous registration. In this case the receiver needs
+		 * to be re-registered here so that this update doesn't
+		 * silently stop delivering frames for the given ifindex.
+		 * Ops with ifindex = 0 (all CAN interfaces) never carry a
+		 * tracked rx_reg_dev and stay registered as-is.
+		 */
+		do_rx_register = (ifindex && !op->rx_reg_dev) ? 1 : 0;
 
 	} else {
 		/* insert new BCM operation for the given can_id */
@@ -1128,6 +1367,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
+		spin_lock_init(&op->bcm_rx_update_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
@@ -1161,18 +1401,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes) {
 			err = memcpy_from_msg(op->frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0) {
-				if (op->frames != &op->sframe)
-					kfree(op->frames);
-				if (op->last_frames != &op->last_sframe)
-					kfree(op->last_frames);
-				kfree(op);
-				return err;
-			}
+			if (err < 0)
+				goto free_op;
+
+			err = bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			if (err < 0)
+				goto free_op;
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* ifindex for timeout events w/o previous frame reception */
@@ -1189,35 +1428,29 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* call can_rx_register() */
 		do_rx_register = 1;
+		new_op = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
 	/* check flags */
 
 	if (op->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = op->frames;
-
 		/* no timers in RTR-mode */
 		hrtimer_cancel(&op->thrtimer);
 		hrtimer_cancel(&op->timer);
-
-		/*
-		 * funny feature in RX(!)_SETUP only for RTR-mode:
-		 * copy can_id into frame BUT without RTR-flag to
-		 * prevent a full-load-loopback-test ... ;-]
-		 */
-		if ((op->flags & TX_CP_CAN_ID) ||
-		    (frame0->can_id == op->can_id))
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-
 	} else {
 		if (op->flags & SETTIMER) {
 
-			/* set timer value */
-			op->ival1 = msg_head->ival1;
-			op->ival2 = msg_head->ival2;
-			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
-			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			/* set timers (locked) for newly created op */
+			if (new_op) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				op->ival1 = msg_head->ival1;
+				op->ival2 = msg_head->ival2;
+				op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+				op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+				op->kt_lastmsg = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
@@ -1227,9 +1460,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			 * In any case cancel the throttle timer, flush
 			 * potentially blocked msgs and reset throttle handling
 			 */
-			op->kt_lastmsg = 0;
 			hrtimer_cancel(&op->thrtimer);
+
+			spin_lock_bh(&op->bcm_rx_update_lock);
 			bcm_rx_thr_flush(op);
+			spin_unlock_bh(&op->bcm_rx_update_lock);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)
@@ -1237,7 +1472,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				      HRTIMER_MODE_REL_SOFT);
 	}
 
-	/* now we can register for can_ids, if we added a new bcm_op */
+	/* now we can register for can_ids, if we added a new bcm_op
+	 * or need to re-register after a NETDEV_UNREGISTER tore down
+	 * the previous registration of an existing op
+	 */
 	if (do_rx_register) {
 		if (ifindex) {
 			struct net_device *dev;
@@ -1250,7 +1488,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
-				op->rx_reg_dev = dev;
+				/* keep a reference so that a later
+				 * unregister can safely reach the device even
+				 * if a concurrent NETDEV_UNREGISTER has
+				 * already unlisted it by ifindex
+				 */
+				if (!err) {
+					op->rx_reg_dev = dev;
+					dev_hold(dev);
+				}
 				dev_put(dev);
 			} else {
 				/* the requested device is gone - do not
@@ -1259,21 +1505,43 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				err = -ENODEV;
 			}
 
-		} else
+		} else {
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
+		}
+
 		if (err) {
-			/* this bcm rx op is broken -> remove it */
-			bcm_remove_op(op);
+			/* newly created bcm rx op is broken -> remove it */
+			if (new_op) {
+				bcm_remove_op(op);
+				return err;
+			}
+
+			/* an existing op just stays unregistered.
+			 * Cancel op->timer and (defensively) op->thrtimer.
+			 * Other settings can't be reached until the next
+			 * successful RX_SETUP.
+			 */
+			hrtimer_cancel(&op->timer);
+			hrtimer_cancel(&op->thrtimer);
 			return err;
 		}
 
-		/* add this bcm_op to the list of the rx_ops */
-		list_add_rcu(&op->list, &bo->rx_ops);
+		/* add a new bcm_op to the list of the rx_ops */
+		if (new_op)
+			list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
+
+free_op:
+	if (op->frames != &op->sframe)
+		kfree(op->frames);
+	if (op->last_frames != &op->last_sframe)
+		kfree(op->last_frames);
+	kfree(op);
+	return err;
 }
 
 /*
@@ -1478,11 +1746,30 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
-		/* remove device specific receive entries */
-		list_for_each_entry(op, &bo->rx_ops, list)
+		/* rx_ops: remove device specific receive entries */
+		list_for_each_entry(op, &bo->rx_ops, list) {
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
 
+			/* release an ANYDEV op's claim (see bcm_rx_handler())
+			 * on this now confirmed-gone interface.
+			 */
+			if (!op->ifindex) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				if (op->if_detected == dev->ifindex)
+					op->if_detected = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
+		}
+
+		/* tx_ops: stop device specific cyclic transmissions on the
+		 * vanishing ifindex. Cancelling the timer is enough to stop
+		 * cyclic bcm_can_tx() calls as there is no re-arming.
+		 */
+		list_for_each_entry(op, &bo->tx_ops, list)
+			if (op->ifindex == dev->ifindex)
+				hrtimer_cancel(&op->timer);
+
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
 #if IS_ENABLED(CONFIG_PROC_FS)
@@ -1615,16 +1902,14 @@ static int bcm_release(struct socket *sock)
 			 * Only remove subscriptions that had not
 			 * been removed due to NETDEV_UNREGISTER
 			 * in bcm_notifier()
+			 *
+			 * op->rx_reg_dev is a tracked reference taken
+			 * when the subscription was registered, so it
+			 * stays valid here even if a concurrent
+			 * NETDEV_UNREGISTER already unlisted the device.
 			 */
-			if (op->rx_reg_dev) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(net, op->ifindex);
-				if (dev) {
-					bcm_rx_unreg(dev, op);
-					dev_put(dev);
-				}
-			}
+			if (op->rx_reg_dev)
+				bcm_rx_unreg(op->rx_reg_dev, op);
 		} else
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
@@ -1830,11 +2115,16 @@ static int __init bcm_module_init(void)
 {
 	int err;
 
+	bcm_wq = alloc_workqueue("can-bcm-wq", WQ_UNBOUND, 0);
+	if (!bcm_wq)
+		return -ENOMEM;
+
 	pr_info("can: broadcast manager protocol\n");
 
 	err = can_proto_register(&bcm_can_proto);
 	if (err < 0) {
 		printk(KERN_ERR "can: registration of bcm protocol failed\n");
+		destroy_workqueue(bcm_wq);
 		return err;
 	}
 
@@ -1848,6 +2138,8 @@ static void __exit bcm_module_exit(void)
 	can_proto_unregister(&bcm_can_proto);
 	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+	rcu_barrier();
+	destroy_workqueue(bcm_wq);
 }
 
 module_init(bcm_module_init);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index c914b8a09155..f23862b465ca 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -137,11 +137,12 @@ struct isotp_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer, txfrtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer, echotimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
@@ -149,6 +150,7 @@ struct isotp_sock {
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	u32 cfecho; /* consecutive frame echo tag */
+	u32 tx_gen; /* generation, bumped per new tx transfer */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -355,6 +357,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 	hrtimer_cancel(&so->txtimer);
 
+	/* isotp_tx_timeout() may have given up on this job while
+	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
+	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
+	 * so a plain recheck is enough here.
+	 */
+	if (so->tx.state != ISOTP_WAIT_FC &&
+	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+		return 1;
+
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
@@ -400,7 +411,7 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
 		/* send CF frame and enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
 		break;
@@ -543,6 +554,14 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	hrtimer_cancel(&so->rxtimer);
 
+	/* isotp_rx_timer_handler() may have raced us for so->rx.state
+	 * while hrtimer_cancel() above waited for it to finish, already
+	 * reporting ETIMEDOUT and resetting the reception; don't process
+	 * this CF into a reassembly that has already been given up on.
+	 */
+	if (so->rx.state != ISOTP_WAIT_DATA)
+		return 1;
+
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
 		return 1;
@@ -832,20 +851,36 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
-	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+	if (skb->sk != sk)
 		return;
 
+	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
+	 * (no isotp_rcv() caller here), so take it ourselves
+	 */
+	spin_lock(&so->rx_lock);
+
+	/* so->cfecho may since belong to a new transfer; recheck under lock */
+	if (so->cfecho != *(u32 *)cf->data)
+		goto out_unlock;
+
 	/* cancel local echo timeout */
-	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* claiming a transfer also takes so->rx_lock, so a plain recheck
+	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
+	 * a new claim while we're still in here
+	 */
+	if (so->tx.state != ISOTP_SENDING)
+		goto out_unlock;
+
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		return;
+		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
@@ -853,53 +888,83 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 		so->tx.state = ISOTP_WAIT_FC;
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
-		return;
+		goto out_unlock;
 	}
 
 	/* no gap between data frames needed => use burst mode */
 	if (!so->tx_gap) {
 		/* enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
-		return;
+		goto out_unlock;
 	}
 
 	/* start timer to send next consecutive frame with correct delay */
 	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+
+out_unlock:
+	spin_unlock(&so->rx_lock);
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
+ * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
+ * a new transfer with an error from the one that just timed out.
+ */
+static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 gen = READ_ONCE(so->tx_gen);
+	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
-	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* only claim the timeout if the state is still unchanged */
+	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
-	/* report 'communication error on send' */
-	sk->sk_err = ECOMM;
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_error_report(sk);
+	if (READ_ONCE(so->tx_gen) == gen) {
+		/* report 'communication error on send' */
+		sk->sk_err = ECOMM;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk->sk_error_report(sk);
+	}
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 
+/* so->txtimer: fires when a Flow Control frame does not arrive in time */
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+
+	return isotp_tx_timeout(so);
+}
+
+/* so->echotimer: fires when a sent CF/SF's local echo does not arrive */
+static enum hrtimer_restart isotp_echo_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     echotimer);
+
+	return isotp_tx_timeout(so);
+}
+
 static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txfrtimer);
 
 	/* start echo timeout handling and cover below protocol error */
-	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+	hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
@@ -919,13 +984,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
+	struct hrtimer *tx_hrt = &so->echotimer;
+	u32 new_state = ISOTP_SENDING;
 	int off;
 	int err;
 
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+	/* claim the socket under so->rx_lock: this serializes the claim
+	 * with the RX path and with sendmsg()'s own error paths below, so
+	 * none of them can ever see a transfer mid-claim
+	 */
+	for (;;) {
+		spin_lock_bh(&so->rx_lock);
+		if (READ_ONCE(so->tx.state) == ISOTP_IDLE)
+			break;
+		spin_unlock_bh(&so->rx_lock);
+
 		/* we do not support multiple buffers - for now */
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
@@ -934,9 +1010,29 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait,
+					       so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
+	}
+
+	/* new transfer: bump so->tx_gen and drain the old one's timers,
+	 * still under the so->rx_lock we just claimed the socket with
+	 */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
+	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
+	hrtimer_cancel(&so->txfrtimer);
+	so->cfecho = 0;
+	spin_unlock_bh(&so->rx_lock);
+
+	/* so->bound is only checked once above - a wakeup may have
+	 * unbound/rebound the socket meanwhile, so re-validate it
+	 */
+	if (!so->bound) {
+		err = -EADDRNOTAVAIL;
+		goto err_out_drop;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
@@ -1031,18 +1127,33 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->cfecho = *(u32 *)cf->data;
 		} else {
 			/* standard flow control check */
-			so->tx.state = ISOTP_WAIT_FIRST_FC;
+			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
 			hrtimer_sec = ISOTP_FC_TIMEOUT;
+			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
 			so->cfecho = 0;
 		}
 	}
 
-	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+	spin_lock_bh(&so->rx_lock);
+	if (so->tx.state == ISOTP_SHUTDOWN) {
+		/* isotp_release() has since taken over and already drained
+		 * our timers - don't send into a socket that's going away
+		 */
+		spin_unlock_bh(&so->rx_lock);
+		kfree_skb(skb);
+		dev_put(dev);
+		wake_up_interruptible(&so->wait);
+		return -EADDRNOTAVAIL;
+	}
+	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
+	so->tx.state = new_state;
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock_bh(&so->rx_lock);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
@@ -1055,13 +1166,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
+		spin_lock_bh(&so->rx_lock);
 		/* no transmission -> no timeout monitoring */
-		hrtimer_cancel(&so->txtimer);
-
-		/* reset consecutive frame echo tag */
-		so->cfecho = 0;
-
-		goto err_out_drop;
+		hrtimer_cancel(tx_hrt);
+		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
@@ -1077,14 +1185,21 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	return size;
 
+err_out_drop:
+	/* claimed but nothing sent yet - no timer to cancel */
+	spin_lock_bh(&so->rx_lock);
+	goto err_out_drop_locked;
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* interrupted waiting on our own transfer - drain its timers */
+	spin_lock_bh(&so->rx_lock);
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
-err_out_drop:
-	/* drop this PDU and unlock a potential wait queue */
+	hrtimer_cancel(&so->echotimer);
+err_out_drop_locked:
+	/* release the claim; so->rx_lock still held from above */
+	so->cfecho = 0;
 	so->tx.state = ISOTP_IDLE;
+	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
@@ -1148,13 +1263,20 @@ static int isotp_release(struct socket *sock)
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
-	/* wait for complete transmission of current pdu */
-	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
-	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+	/* best-effort: wait for a running pdu to finish, but don't block on
+	 * it forever - give up after the first signal
+	 */
+	while (so->tx.state != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
 		;
 
-	/* force state machines to be idle also when a signal occurred */
+	/* claim the socket under so->rx_lock like sendmsg() does, so its
+	 * claim can't race the forced ISOTP_SHUTDOWN below; force it
+	 * unconditionally, even when a signal cut the wait above short
+	 */
+	spin_lock_bh(&so->rx_lock);
 	so->tx.state = ISOTP_SHUTDOWN;
+	spin_unlock_bh(&so->rx_lock);
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
@@ -1166,28 +1288,30 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
-	if (so->bound) {
-		if (so->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(net, so->ifindex);
-			if (dev) {
-				if (isotp_register_rxid(so))
-					can_rx_unregister(net, dev, so->rxid,
-							  SINGLE_MASK(so->rxid),
-							  isotp_rcv, sk);
-
-				can_rx_unregister(net, dev, so->txid,
-						  SINGLE_MASK(so->txid),
-						  isotp_rcv_echo, sk);
-				dev_put(dev);
-			}
-		}
+	/* remove current filters & unregister
+	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 */
+	if (so->bound && so->dev) {
+		if (isotp_register_rxid(so))
+			can_rx_unregister(net, so->dev, so->rxid,
+					  SINGLE_MASK(so->rxid),
+					  isotp_rcv, sk);
+
+		can_rx_unregister(net, so->dev, so->txid,
+				  SINGLE_MASK(so->txid),
+				  isotp_rcv_echo, sk);
+		dev_put(so->dev);
 	}
 
+	so->ifindex = 0;
+	so->bound = 0;
+	so->dev = NULL;
+
+	rtnl_unlock();
+
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
@@ -1198,11 +1322,9 @@ static int isotp_release(struct socket *sock)
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 	hrtimer_cancel(&so->rxtimer);
 
-	so->ifindex = 0;
-	so->bound = 0;
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1256,6 +1378,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (so->bound) {
@@ -1263,6 +1386,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out;
 	}
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
+	 * and RX watchdog timers bound how long this takes. Checked together
+	 * with so->bound in the same lock_sock() section above, so there is
+	 * no window in which a concurrent isotp_notify() could be missed.
+	 */
+	if (so->tx.state != ISOTP_IDLE || so->rx.state != ISOTP_IDLE) {
+		err = -EAGAIN;
+		goto out;
+	}
+
 	/* ensure different CAN IDs when the rx_id is to be registered */
 	if (isotp_register_rxid(so) && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
@@ -1275,14 +1409,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		goto out;
 	}
 	if (dev->type != ARPHRD_CAN) {
-		dev_put(dev);
 		err = -ENODEV;
-		goto out;
+		goto out_put_dev;
 	}
-	if (dev->mtu < so->ll.mtu) {
-		dev_put(dev);
+	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
-		goto out;
+		goto out_put_dev;
 	}
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
@@ -1300,16 +1432,25 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 			isotp_rcv_echo, sk, "isotpe", sk);
 
-	dev_put(dev);
-
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
 	so->bound = 1;
 
+	/* bind() ok -> hold a reference for so->dev so that isotp_release()
+	 * can safely reach the device later, even if a concurrent
+	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
+	 */
+	so->dev = dev;
+	dev_hold(so->dev);
+
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	dev_put(dev);
 out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -1512,7 +1653,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->ifindex != dev->ifindex)
+	if (so->dev != dev)
 		return;
 
 	switch (msg) {
@@ -1528,10 +1669,12 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
+			dev_put(so->dev);
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
+		so->dev = NULL;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
@@ -1576,6 +1719,7 @@ static int isotp_init(struct sock *sk)
 
 	so->ifindex = 0;
 	so->bound = 0;
+	so->dev = NULL;
 
 	so->opt.flags = CAN_ISOTP_DEFAULT_FLAGS;
 	so->opt.ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
@@ -1601,6 +1745,8 @@ static int isotp_init(struct sock *sk)
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
+	hrtimer_init(&so->echotimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	so->echotimer.function = isotp_echo_timer_handler;
 	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txfrtimer.function = isotp_txfr_timer_handler;
 
@@ -1681,13 +1827,18 @@ static __init int isotp_module_init(void)
 
 	pr_info("can: isotp protocol\n");
 
+	err = register_netdevice_notifier(&canisotp_notifier);
+	if (err)
+		return err;
+
 	err = can_proto_register(&isotp_can_proto);
-	if (err < 0)
+	if (err < 0) {
 		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
-	else
-		register_netdevice_notifier(&canisotp_notifier);
+		unregister_netdevice_notifier(&canisotp_notifier);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static __exit void isotp_module_exit(void)
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9f77a730be48..4116b5150526 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -346,6 +346,18 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	}
 }
 
+static bool j1939_address_is_local(struct j1939_priv *priv, u8 addr)
+{
+	bool local = false;
+
+	read_lock_bh(&priv->lock);
+	if (j1939_address_is_unicast(addr) && priv->ents[addr].nusers)
+		local = true;
+	read_unlock_bh(&priv->lock);
+
+	return local;
+}
+
 void j1939_session_skb_queue(struct j1939_session *session,
 			     struct sk_buff *skb)
 {
@@ -354,8 +366,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 
 	j1939_ac_fixup(priv, skb);
 
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
@@ -1535,7 +1546,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	}
 
 	/* alloc data area */
-	skb_put(skb, size);
+	skb_put_zero(skb, size);
 	/* skb is recounted in j1939_session_new() */
 	return session;
 }
@@ -1998,8 +2009,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		return ERR_PTR(ret);
 
 	/* fix DST flags, it may be used there soon */
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	/* src is always local, I'm sending ... */
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index b52732337ca6..1eb82b17d240 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -671,9 +671,16 @@ static int ceph_x_update_authorizer(
 
 	au = (struct ceph_x_authorizer *)auth->authorizer;
 	if (au->secret_id < th->secret_id) {
+		int ret;
+
 		dout("ceph_x_update_authorizer service %u secret %llu < %llu\n",
 		     au->service, au->secret_id, th->secret_id);
-		return ceph_x_build_authorizer(ac, th, au);
+		ret = ceph_x_build_authorizer(ac, th, au);
+		if (ret)
+			return ret;
+
+		auth->authorizer_buf = au->buf->vec.iov_base;
+		auth->authorizer_buf_len = au->buf->vec.iov_len;
 	}
 	return 0;
 }
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index c3bee8f34974..6fc91ed0de7f 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -727,13 +727,13 @@ void ceph_destroy_client(struct ceph_client *client)
 
 	atomic_set(&client->msgr.stopping, 1);
 
+	ceph_debugfs_client_cleanup(client);
+
 	/* unmount */
 	ceph_osdc_stop(&client->osdc);
 	ceph_monc_stop(&client->monc);
 	ceph_messenger_fini(&client->msgr);
 
-	ceph_debugfs_client_cleanup(client);
-
 	ceph_destroy_options(client->options);
 
 	kfree(client);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 82d3f1204ee4..e1f01aef263e 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -748,7 +748,7 @@ static void handle_get_version_reply(struct ceph_mon_client *monc,
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(msg->hdr.tid);
 	void *p = msg->front.iov_base;
-	void *end = p + msg->front_alloc_len;
+	void *const end = p + msg->front.iov_len;
 	u64 handle;
 
 	dout("%s msg %p tid %llu\n", __func__, msg, tid);
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 033e8cf57b0e..f7be6b68dfc8 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -504,6 +504,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		ceph_decode_need(p, end, 4*sizeof(u32), bad);
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
+		if (b->type == 0)
+			goto bad;
 		b->alg = ceph_decode_8(p);
 		if (b->alg != alg) {
 			b->alg = 0;
@@ -1822,6 +1824,8 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 	void *new_up_client;
 	void *new_state;
 	void *new_weight_end;
+	const u32 new_state_item_size =
+	    sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
 	u32 len;
 	int i;
 
@@ -1837,7 +1841,8 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 
 	new_state = *p;
 	ceph_decode_32_safe(p, end, len, e_inval);
-	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
+	if (check_mul_overflow(len, new_state_item_size, &len))
+		goto e_inval;
 	ceph_decode_need(p, end, len, e_inval);
 	*p += len;
 
@@ -3018,8 +3023,11 @@ static int get_immediate_parent(struct crush_map *c, int id,
 			if (b->items[j] != id)
 				continue;
 
-			*parent_type_id = b->type;
 			type_cn = lookup_crush_name(&c->type_names, b->type);
+			if (WARN_ON_ONCE(!type_cn))
+				continue;
+
+			*parent_type_id = b->type;
 			parent_loc->cl_type_name = type_cn->cn_name;
 			parent_loc->cl_name = cn->cn_name;
 			return b->id;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 8c41532b4fe8..c883366a85b8 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -245,8 +245,10 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 	 * if there is enough header space in skb.
 	 */
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
+	if (unlikely(err)) {
+		dst_release(dst);
 		goto err;
+	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
diff --git a/net/core/sock.c b/net/core/sock.c
index 963ea323362a..b51a154ec591 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -699,7 +699,6 @@ bool sk_mc_loop(struct sock *sk)
 		return inet6_sk(sk)->mc_loop;
 #endif
 	}
-	WARN_ON_ONCE(1);
 	return true;
 }
 EXPORT_SYMBOL(sk_mc_loop);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e1a8e00658ba..e0370462293c 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1943,42 +1943,30 @@ static int call_fib_nh_notifiers(struct fib_nh *nh,
 	return NOTIFY_DONE;
 }
 
-/* Update the PMTU of exceptions when:
- * - the new MTU of the first hop becomes smaller than the PMTU
- * - the old MTU was the same as the PMTU, and it limited discovery of
- *   larger MTUs on the path. With that limit raised, we can now
- *   discover larger MTUs
- * A special case is locked exceptions, for which the PMTU is smaller
- * than the minimal accepted PMTU:
- * - if the new MTU is greater than the PMTU, don't make any change
- * - otherwise, unlock and set PMTU
+/* Walk the exceptions of a nexthop after its first hop MTU changed. The
+ * chain is RCU protected here, while fnhe_update_pmtu() takes fnhe_lock
+ * for the update of each entry.
  */
 void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 {
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	rcu_read_lock();
+	bucket = rcu_dereference(nhc->nhc_exceptions);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
 
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		for (fnhe = rcu_dereference(bucket[i].chain);
 		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
-			if (fnhe->fnhe_mtu_locked) {
-				if (new <= fnhe->fnhe_pmtu) {
-					fnhe->fnhe_pmtu = new;
-					fnhe->fnhe_mtu_locked = false;
-				}
-			} else if (new < fnhe->fnhe_pmtu ||
-				   orig == fnhe->fnhe_pmtu) {
-				fnhe->fnhe_pmtu = new;
-			}
-		}
+		     fnhe = rcu_dereference(fnhe->fnhe_next))
+			fnhe_update_pmtu(fnhe, new, orig);
 	}
+out:
+	rcu_read_unlock();
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 5c75591bcce0..5c061dffc379 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1340,7 +1340,7 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 out_remove_new_fa:
 	fib_remove_alias(t, tp, l, new_fa);
 out_free_new_fa:
-	kmem_cache_free(fn_alias_kmem, new_fa);
+	alias_free_mem_rcu(new_fa);
 out:
 	fib_release_info(fi);
 err:
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 3c74fecce238..e919d2a5169e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -533,11 +533,23 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		if (IS_ERR(rt2))
 			err = PTR_ERR(rt2);
 	} else {
-		struct flowi4 fl4_2 = {};
+		struct flowi4 fl4_2 = fl4_dec;
 		unsigned long orefdst;
 
-		fl4_2.daddr = fl4_dec.saddr;
-		rt2 = ip_route_output_key(net, &fl4_2);
+		swap(fl4_2.daddr, fl4_2.saddr);
+		switch (fl4_2.flowi4_proto) {
+		case IPPROTO_TCP:
+		case IPPROTO_UDP:
+		case IPPROTO_SCTP:
+		case IPPROTO_DCCP:
+			swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
+			break;
+		}
+
+		fl4_2.flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
+		fl4_2.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+
+		rt2 = __ip_route_output_key(net, &fl4_2);
 		if (IS_ERR(rt2)) {
 			err = PTR_ERR(rt2);
 			goto relookup_failed;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 2d14d9aabc0b..0131d151fce0 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -117,24 +117,19 @@ void raw_unhash_sk(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(raw_unhash_sk);
 
-struct sock *__raw_v4_lookup(struct net *net, struct sock *sk,
-			     unsigned short num, __be32 raddr, __be32 laddr,
-			     int dif, int sdif)
+bool raw_v4_match(struct net *net, struct sock *sk, unsigned short num,
+		  __be32 raddr, __be32 laddr, int dif, int sdif)
 {
-	sk_for_each_from(sk) {
-		struct inet_sock *inet = inet_sk(sk);
-
-		if (net_eq(sock_net(sk), net) && inet->inet_num == num	&&
-		    !(inet->inet_daddr && inet->inet_daddr != raddr) 	&&
-		    !(inet->inet_rcv_saddr && inet->inet_rcv_saddr != laddr) &&
-		    raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
-			goto found; /* gotcha */
-	}
-	sk = NULL;
-found:
-	return sk;
+	struct inet_sock *inet = inet_sk(sk);
+
+	if (net_eq(sock_net(sk), net) && inet->inet_num == num	&&
+	    !(inet->inet_daddr && inet->inet_daddr != raddr) 	&&
+	    !(inet->inet_rcv_saddr && inet->inet_rcv_saddr != laddr) &&
+	    raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
+		return true;
+	return false;
 }
-EXPORT_SYMBOL_GPL(__raw_v4_lookup);
+EXPORT_SYMBOL_GPL(raw_v4_match);
 
 /*
  *	0 - deliver
@@ -168,23 +163,21 @@ static int icmp_filter(const struct sock *sk, const struct sk_buff *skb)
  */
 static int raw_v4_input(struct sk_buff *skb, const struct iphdr *iph, int hash)
 {
+	struct net *net = dev_net(skb->dev);
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
-	struct sock *sk;
 	struct hlist_head *head;
 	int delivered = 0;
-	struct net *net;
+	struct sock *sk;
 
-	read_lock(&raw_v4_hashinfo.lock);
 	head = &raw_v4_hashinfo.ht[hash];
 	if (hlist_empty(head))
-		goto out;
-
-	net = dev_net(skb->dev);
-	sk = __raw_v4_lookup(net, __sk_head(head), iph->protocol,
-			     iph->saddr, iph->daddr, dif, sdif);
-
-	while (sk) {
+		return 0;
+	read_lock(&raw_v4_hashinfo.lock);
+	sk_for_each(sk, head) {
+		if (!raw_v4_match(net, sk, iph->protocol,
+				  iph->saddr, iph->daddr, dif, sdif))
+			continue;
 		delivered = 1;
 		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
 		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
@@ -195,31 +188,16 @@ static int raw_v4_input(struct sk_buff *skb, const struct iphdr *iph, int hash)
 			if (clone)
 				raw_rcv(sk, clone);
 		}
-		sk = __raw_v4_lookup(net, sk_next(sk), iph->protocol,
-				     iph->saddr, iph->daddr,
-				     dif, sdif);
 	}
-out:
 	read_unlock(&raw_v4_hashinfo.lock);
 	return delivered;
 }
 
 int raw_local_deliver(struct sk_buff *skb, int protocol)
 {
-	int hash;
-	struct sock *raw_sk;
-
-	hash = protocol & (RAW_HTABLE_SIZE - 1);
-	raw_sk = sk_head(&raw_v4_hashinfo.ht[hash]);
-
-	/* If there maybe a raw socket we must check - if not we
-	 * don't care less
-	 */
-	if (raw_sk && !raw_v4_input(skb, ip_hdr(skb), hash))
-		raw_sk = NULL;
-
-	return raw_sk != NULL;
+	int hash = protocol & (RAW_HTABLE_SIZE - 1);
 
+	return raw_v4_input(skb, ip_hdr(skb), hash);
 }
 
 static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
@@ -286,29 +264,24 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 
 void raw_icmp_error(struct sk_buff *skb, int protocol, u32 info)
 {
-	int hash;
-	struct sock *raw_sk;
+	struct net *net = dev_net(skb->dev);
+	int dif = skb->dev->ifindex;
+	int sdif = inet_sdif(skb);
+	struct hlist_head *head;
 	const struct iphdr *iph;
-	struct net *net;
+	struct sock *sk;
+	int hash;
 
 	hash = protocol & (RAW_HTABLE_SIZE - 1);
+	head = &raw_v4_hashinfo.ht[hash];
 
 	read_lock(&raw_v4_hashinfo.lock);
-	raw_sk = sk_head(&raw_v4_hashinfo.ht[hash]);
-	if (raw_sk) {
-		int dif = skb->dev->ifindex;
-		int sdif = inet_sdif(skb);
-
+	sk_for_each(sk, head) {
 		iph = (const struct iphdr *)skb->data;
-		net = dev_net(skb->dev);
-
-		while ((raw_sk = __raw_v4_lookup(net, raw_sk, protocol,
-						iph->daddr, iph->saddr,
-						dif, sdif)) != NULL) {
-			raw_err(raw_sk, skb, info);
-			raw_sk = sk_next(raw_sk);
-			iph = (const struct iphdr *)skb->data;
-		}
+		if (!raw_v4_match(net, sk, iph->protocol,
+				  iph->daddr, iph->saddr, dif, sdif))
+			continue;
+		raw_err(sk, skb, info);
 	}
 	read_unlock(&raw_v4_hashinfo.lock);
 }
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index ccacbde30a2c..b6d92dc7b051 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -34,31 +34,30 @@ raw_get_hashinfo(const struct inet_diag_req_v2 *r)
  * use helper to figure it out.
  */
 
-static struct sock *raw_lookup(struct net *net, struct sock *from,
-			       const struct inet_diag_req_v2 *req)
+static bool raw_lookup(struct net *net, struct sock *sk,
+		       const struct inet_diag_req_v2 *req)
 {
 	struct inet_diag_req_raw *r = (void *)req;
-	struct sock *sk = NULL;
 
 	if (r->sdiag_family == AF_INET)
-		sk = __raw_v4_lookup(net, from, r->sdiag_raw_protocol,
-				     r->id.idiag_dst[0],
-				     r->id.idiag_src[0],
-				     r->id.idiag_if, 0);
+		return raw_v4_match(net, sk, r->sdiag_raw_protocol,
+				    r->id.idiag_dst[0],
+				    r->id.idiag_src[0],
+				    r->id.idiag_if, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	else
-		sk = __raw_v6_lookup(net, from, r->sdiag_raw_protocol,
-				     (const struct in6_addr *)r->id.idiag_src,
-				     (const struct in6_addr *)r->id.idiag_dst,
-				     r->id.idiag_if, 0);
+		return raw_v6_match(net, sk, r->sdiag_raw_protocol,
+				    (const struct in6_addr *)r->id.idiag_src,
+				    (const struct in6_addr *)r->id.idiag_dst,
+				    r->id.idiag_if, 0);
 #endif
-	return sk;
+	return false;
 }
 
 static struct sock *raw_sock_get(struct net *net, const struct inet_diag_req_v2 *r)
 {
 	struct raw_hashinfo *hashinfo = raw_get_hashinfo(r);
-	struct sock *sk = NULL, *s;
+	struct sock *sk;
 	int slot;
 
 	if (IS_ERR(hashinfo))
@@ -66,9 +65,8 @@ static struct sock *raw_sock_get(struct net *net, const struct inet_diag_req_v2
 
 	read_lock(&hashinfo->lock);
 	for (slot = 0; slot < RAW_HTABLE_SIZE; slot++) {
-		sk_for_each(s, &hashinfo->ht[slot]) {
-			sk = raw_lookup(net, s, r);
-			if (sk) {
+		sk_for_each(sk, &hashinfo->ht[slot]) {
+			if (raw_lookup(net, sk, r)) {
 				/*
 				 * Grab it and keep until we fill
 				 * diag meaage to be reported, so
@@ -81,10 +79,11 @@ static struct sock *raw_sock_get(struct net *net, const struct inet_diag_req_v2
 			}
 		}
 	}
+	sk = ERR_PTR(-ENOENT);
 out_unlock:
 	read_unlock(&hashinfo->lock);
 
-	return sk ? sk : ERR_PTR(-ENOENT);
+	return sk;
 }
 
 static int raw_diag_dump_one(struct netlink_callback *cb,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fe29a7d6bd1b..b7db0255af6e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -779,6 +779,35 @@ static void update_or_create_fnhe(struct fib_nh_common *nhc, __be32 daddr,
 	spin_unlock_bh(&fnhe_lock);
 }
 
+/* Update the PMTU of an exception when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ *
+ * fnhe_lock keeps fnhe_pmtu and fnhe_mtu_locked consistent against
+ * update_or_create_fnhe(), which sets both under the same lock.
+ */
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig)
+{
+	spin_lock_bh(&fnhe_lock);
+
+	if (fnhe->fnhe_mtu_locked) {
+		if (new <= fnhe->fnhe_pmtu) {
+			fnhe->fnhe_pmtu = new;
+			fnhe->fnhe_mtu_locked = false;
+		}
+	} else if (new < fnhe->fnhe_pmtu || orig == fnhe->fnhe_pmtu) {
+		fnhe->fnhe_pmtu = new;
+	}
+
+	spin_unlock_bh(&fnhe_lock);
+}
+
 static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flowi4 *fl4,
 			     bool kill_route)
 {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 76cd97488777..458b8a694b9d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -370,6 +370,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_REDIRECT:
 		sk_redir = psock->sk_redir;
+		sock_hold(sk_redir);
 		sk_msg_apply_bytes(psock, tosend);
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
@@ -389,6 +390,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
 		if (eval == __SK_REDIRECT)
 			sock_put(sk_redir);
+		sock_put(sk_redir);
 
 		lock_sock(sk);
 		sk_mem_uncharge(sk, sent);
@@ -504,7 +506,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
-			if (msg_tx && msg_tx != psock->cork)
+			if (msg_tx == &tmp)
 				sk_msg_free(sk, msg_tx);
 			goto out_err;
 		}
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 5d4413fe4195..4285d25d9982 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -20,17 +20,19 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	int tnl_hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);
 	bool remcsum, need_csum, offload_csum, gso_partial;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
-	struct udphdr *uh = udp_hdr(skb);
 	u16 mac_offset = skb->mac_header;
 	__be16 protocol = skb->protocol;
 	u16 mac_len = skb->mac_len;
 	int udp_offset, outer_hlen;
+	struct udphdr *uh;
 	__wsum partial;
 	bool need_ipsec;
 
 	if (unlikely(!pskb_may_pull(skb, tnl_hlen)))
 		goto out;
 
+	uh = udp_hdr(skb);
+
 	/* Adjust partial header checksum to negate old length.
 	 * We cannot rely on the value contained in uh->len as it is
 	 * possible that the actual value exceeds the boundaries of the
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 0d4e82744921..9659a5fe7c35 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -300,6 +300,7 @@ INDIRECT_CALLABLE_SCOPE bool fib6_rule_suppress(struct fib_rule *rule,
 
 suppress_route:
 	ip6_rt_put_flags(rt, flags);
+	res->rt6 = NULL;
 	return true;
 }
 
diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index b8d43ed4689d..ca54a227fc2f 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -84,6 +84,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct tcphdr *th = (struct tcphdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
 							diff, true, true);
@@ -95,6 +96,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 					(skb_network_header(skb) + nhoff);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
+				ip6h = ipv6_hdr(skb);
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
 								diff, true, true);
@@ -109,6 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct icmp6hdr *ih = (struct icmp6hdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
 							diff, true, true);
@@ -126,6 +129,15 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
 	switch (p->csum_mode) {
 	case ILA_CSUM_ADJUST_TRANSPORT:
 		ila_csum_adjust_transport(skb, p);
+		/*
+		 * ila_csum_adjust_transport() calls pskb_may_pull(), which can
+		 * reallocate the skb head and leave ip6h (and the iaddr derived
+		 * from it) dangling; reload both before the write below.  The
+		 * other csum modes do not pull, so their cached pointers stay
+		 * valid.
+		 */
+		ip6h = ipv6_hdr(skb);
+		iaddr = ila_a2i(&ip6h->daddr);
 		break;
 	case ILA_CSUM_NEUTRAL_MAP:
 		if (sir2ila) {
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 83f15e930b57..12568b7ab703 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -620,11 +620,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
-	unsigned int e = 0, s_e;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
 	struct hlist_head *head;
 	int res = 0;
+	u32 s_id;
 
 	if (cb->strict_check) {
 		int err;
@@ -682,25 +682,24 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
 	rcu_read_lock();
-	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv6.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb6_id != s_id)
+				continue;
+
+			s_id = 0;
+			cb->args[1] = tb->tb6_id;
 			res = fib6_dump_table(tb, skb, cb);
 			if (res != 0)
 				goto out_unlock;
-next:
-			e++;
 		}
 	}
 out_unlock:
 	rcu_read_unlock();
-	cb->args[1] = e;
 	cb->args[0] = h;
 out:
 	res = res < 0 ? res : skb->len;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index dda90c77f898..148a9bac4ed5 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -708,6 +708,9 @@ ip6ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		if (!skb2)
 			return 0;
 
+		/* Remove debris left by outer IPv6 stack. */
+		memset(IP6CB(skb2), 0, sizeof(*IP6CB(skb2)));
+
 		skb_dst_drop(skb2);
 		skb_pull(skb2, offset);
 		skb_reset_network_header(skb2);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 3308b9a4d523..6ec51b1a4e26 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -66,41 +66,27 @@ struct raw_hashinfo raw_v6_hashinfo = {
 };
 EXPORT_SYMBOL_GPL(raw_v6_hashinfo);
 
-struct sock *__raw_v6_lookup(struct net *net, struct sock *sk,
-		unsigned short num, const struct in6_addr *loc_addr,
-		const struct in6_addr *rmt_addr, int dif, int sdif)
+bool raw_v6_match(struct net *net, struct sock *sk, unsigned short num,
+		  const struct in6_addr *loc_addr,
+		  const struct in6_addr *rmt_addr, int dif, int sdif)
 {
-	bool is_multicast = ipv6_addr_is_multicast(loc_addr);
-
-	sk_for_each_from(sk)
-		if (inet_sk(sk)->inet_num == num) {
-
-			if (!net_eq(sock_net(sk), net))
-				continue;
-
-			if (!ipv6_addr_any(&sk->sk_v6_daddr) &&
-			    !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))
-				continue;
-
-			if (!raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
-						 dif, sdif))
-				continue;
-
-			if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr)) {
-				if (ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr))
-					goto found;
-				if (is_multicast &&
-				    inet6_mc_check(sk, loc_addr, rmt_addr))
-					goto found;
-				continue;
-			}
-			goto found;
-		}
-	sk = NULL;
-found:
-	return sk;
+	if (inet_sk(sk)->inet_num != num ||
+	    !net_eq(sock_net(sk), net) ||
+	    (!ipv6_addr_any(&sk->sk_v6_daddr) &&
+	     !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
+	    !raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
+				 dif, sdif))
+		return false;
+
+	if (ipv6_addr_any(&sk->sk_v6_rcv_saddr) ||
+	    ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr) ||
+	    (ipv6_addr_is_multicast(loc_addr) &&
+	     inet6_mc_check(sk, loc_addr, rmt_addr)))
+		return true;
+
+	return false;
 }
-EXPORT_SYMBOL_GPL(__raw_v6_lookup);
+EXPORT_SYMBOL_GPL(raw_v6_match);
 
 /*
  *	0 - deliver
@@ -156,31 +142,28 @@ EXPORT_SYMBOL(rawv6_mh_filter_unregister);
  */
 static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 {
+	struct net *net = dev_net(skb->dev);
 	const struct in6_addr *saddr;
 	const struct in6_addr *daddr;
+	struct hlist_head *head;
 	struct sock *sk;
 	bool delivered = false;
 	__u8 hash;
-	struct net *net;
 
 	saddr = &ipv6_hdr(skb)->saddr;
 	daddr = saddr + 1;
 
 	hash = nexthdr & (RAW_HTABLE_SIZE - 1);
-
+	head = &raw_v6_hashinfo.ht[hash];
+	if (hlist_empty(head))
+		return false;
 	read_lock(&raw_v6_hashinfo.lock);
-	sk = sk_head(&raw_v6_hashinfo.ht[hash]);
-
-	if (!sk)
-		goto out;
-
-	net = dev_net(skb->dev);
-	sk = __raw_v6_lookup(net, sk, nexthdr, daddr, saddr,
-			     inet6_iif(skb), inet6_sdif(skb));
-
-	while (sk) {
+	sk_for_each(sk, head) {
 		int filtered;
 
+		if (!raw_v6_match(net, sk, nexthdr, daddr, saddr,
+				  inet6_iif(skb), inet6_sdif(skb)))
+			continue;
 		delivered = true;
 		switch (nexthdr) {
 		case IPPROTO_ICMPV6:
@@ -219,23 +202,14 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 				rawv6_rcv(sk, clone);
 			}
 		}
-		sk = __raw_v6_lookup(net, sk_next(sk), nexthdr, daddr, saddr,
-				     inet6_iif(skb), inet6_sdif(skb));
 	}
-out:
 	read_unlock(&raw_v6_hashinfo.lock);
 	return delivered;
 }
 
 bool raw6_local_deliver(struct sk_buff *skb, int nexthdr)
 {
-	struct sock *raw_sk;
-
-	raw_sk = sk_head(&raw_v6_hashinfo.ht[nexthdr & (RAW_HTABLE_SIZE - 1)]);
-	if (raw_sk && !ipv6_raw_deliver(skb, nexthdr))
-		raw_sk = NULL;
-
-	return raw_sk != NULL;
+	return ipv6_raw_deliver(skb, nexthdr);
 }
 
 /* This cleans up af_inet6 a bit. -DaveM */
@@ -361,28 +335,22 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
 		u8 type, u8 code, int inner_offset, __be32 info)
 {
+	struct net *net = dev_net(skb->dev);
+	struct hlist_head *head;
 	struct sock *sk;
 	int hash;
-	const struct in6_addr *saddr, *daddr;
-	struct net *net;
 
 	hash = nexthdr & (RAW_HTABLE_SIZE - 1);
-
+	head = &raw_v6_hashinfo.ht[hash];
 	read_lock(&raw_v6_hashinfo.lock);
-	sk = sk_head(&raw_v6_hashinfo.ht[hash]);
-	if (sk) {
+	sk_for_each(sk, head) {
 		/* Note: ipv6_hdr(skb) != skb->data */
 		const struct ipv6hdr *ip6h = (const struct ipv6hdr *)skb->data;
-		saddr = &ip6h->saddr;
-		daddr = &ip6h->daddr;
-		net = dev_net(skb->dev);
-
-		while ((sk = __raw_v6_lookup(net, sk, nexthdr, saddr, daddr,
-					     inet6_iif(skb), inet6_iif(skb)))) {
-			rawv6_err(sk, skb, NULL, type, code,
-					inner_offset, info);
-			sk = sk_next(sk);
-		}
+
+		if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
+				  inet6_iif(skb), inet6_sdif(skb)))
+			continue;
+		rawv6_err(sk, skb, NULL, type, code, inner_offset, info);
 	}
 	read_unlock(&raw_v6_hashinfo.lock);
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b8bf919a940f..bda1d39f0b2e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -942,13 +942,13 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 	} else if (rinfo->prefix_len > 128) {
 		return -EINVAL;
 	} else if (rinfo->prefix_len > 64) {
-		if (rinfo->length < 2) {
+		/* RFC 4191: Length MUST be 3 when Prefix Length > 64 */
+		if (rinfo->length < 3)
 			return -EINVAL;
-		}
 	} else if (rinfo->prefix_len > 0) {
-		if (rinfo->length < 1) {
+		/* RFC 4191: Length MUST be 2 or 3 when Prefix Length > 0 */
+		if (rinfo->length < 2)
 			return -EINVAL;
-		}
 	}
 
 	pref = rinfo->route_pref;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 8c08f07ce465..36b0c784f779 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -358,6 +358,7 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	unsigned char user_data[16];
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
+	struct sock_msg_q *p, *n;
 
 	/* Whoever resets the path pointer, must sever and free it. */
 	if (xchg(&iucv->path, NULL)) {
@@ -369,6 +370,19 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 		} else
 			pr_iucv->path_sever(path, NULL);
 		iucv_path_free(path);
+
+		/*
+		 * Message notifications queued on message_q still reference
+		 * the now freed path; drop them, otherwise a later recvmsg()
+		 * would pass the freed iucv_path to message_receive() via
+		 * iucv_process_message_q().
+		 */
+		spin_lock_bh(&iucv->message_q.lock);
+		list_for_each_entry_safe(p, n, &iucv->message_q.list, list) {
+			list_del(&p->list);
+			kfree(p);
+		}
+		spin_unlock_bh(&iucv->message_q.lock);
 	}
 }
 
@@ -1868,7 +1882,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		afiucv_swap_src_dest(skb);
 		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
 		err = dev_queue_xmit(skb);
-		iucv_sock_kill(nsk);
+		if (nsk)
+			iucv_sock_kill(nsk);
 		bh_unlock_sock(sk);
 		goto out;
 	}
@@ -2083,6 +2098,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 			}
 		}
 	}
+	if (sk)
+		sock_hold(sk);
 	read_unlock(&iucv_sk_list.lock);
 	if (!iucv)
 		sk = NULL;
@@ -2132,6 +2149,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 		kfree_skb(skb);
 	}
 
+	if (sk)
+		sock_put(sk);
 	return err;
 }
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 644eabaf10e3..9abec4f929ca 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -492,6 +492,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 		WARN_ON(!list_empty(&sdata->u.ap.vlans));
 	} else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		/* remove all packets in parent bc_buf pointing to this dev */
+		__skb_queue_head_init(&freeq);
 		ps = &sdata->bss->ps;
 
 		spin_lock_irqsave(&ps->bc_buf.lock, flags);
@@ -499,10 +500,15 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 			if (skb->dev == sdata->dev) {
 				__skb_unlink(skb, &ps->bc_buf);
 				local->total_ps_buffered--;
-				ieee80211_free_txskb(&local->hw, skb);
+				__skb_queue_tail(&freeq, skb);
 			}
 		}
 		spin_unlock_irqrestore(&ps->bc_buf.lock, flags);
+
+		skb_queue_walk_safe(&freeq, skb, tmp) {
+			__skb_unlink(skb, &freeq);
+			ieee80211_free_txskb(&local->hw, skb);
+		}
 	}
 
 	if (going_down)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8f497fe234ed..8ec630a4d069 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1585,6 +1585,8 @@ static void sta_ps_start(struct sta_info *sta)
 		else
 			clear_bit(tid, &sta->txq_buffered_tids);
 	}
+
+	sta_info_recalc_tim(sta);
 }
 
 static void sta_ps_end(struct sta_info *sta)
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index af6a7e39b7b7..7c8593d7abad 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -888,6 +888,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	data = skb_mac_header(skb) + skb->mac_len;
 	datalen = skb_tail_pointer(skb) - data;
 
+	if (datalen < authlen) {
+		kfree_sensitive(req);
+		return -EBADMSG;
+	}
+
 	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
 
 	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index fa095bc8b0c1..5c80fb93bb7a 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2144,6 +2144,9 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 		int ifindex;
 
 		if (i == RTA_OIF) {
+			if (!tb[i])
+				continue;
+
 			ifindex = nla_get_u32(tb[i]);
 			filter->dev = __dev_get_by_index(net, ifindex);
 			if (!filter->dev)
@@ -2489,6 +2492,7 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	r->rtm_family	 = AF_MPLS;
 	r->rtm_dst_len	= 20;
 	r->rtm_src_len	= 0;
+	r->rtm_tos	= 0;
 	r->rtm_table	= RT_TABLE_MAIN;
 	r->rtm_type	= RTN_UNICAST;
 	r->rtm_scope	= RT_SCOPE_UNIVERSE;
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index db350b8f5d88..82b22368a540 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -461,6 +461,10 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	nca.req_flags = NCSI_REQ_FLAG_NETLINK_DRIVEN;
 	nca.info = info;
 	nca.payload = ntohs(hdr->length);
+	if (nca.payload > len - sizeof(*hdr)) {
+		ret = -EINVAL;
+		goto out_netlink;
+	}
 	nca.data = data + sizeof(*hdr);
 
 	ret = ncsi_xmit_cmd(&nca);
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 78f5de3cfc51..25550a694edc 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -986,7 +986,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 #endif
 	if (SET_WITH_COUNTER(set))
 		ip_set_init_counter(ext_counter(data, set), ext);
-	if (SET_WITH_COMMENT(set))
+	if (SET_WITH_COMMENT(set) && !ext->target)
 		ip_set_init_comment(set, ext_comment(data, set), ext);
 	if (SET_WITH_SKBINFO(set))
 		ip_set_init_skbinfo(ext_skbinfo(data, set), ext);
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 035e8391631a..f4506bc166ce 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -570,12 +570,6 @@ static inline void ip_vs_bind_xmit_v6(struct ip_vs_conn *cp)
 #endif
 
 
-static inline int ip_vs_dest_totalconns(struct ip_vs_dest *dest)
-{
-	return atomic_read(&dest->activeconns)
-		+ atomic_read(&dest->inactconns);
-}
-
 /*
  *	Bind a connection entry with a virtual service destination
  *	Called just after a new connection entry is created.
@@ -599,6 +593,9 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 	flags = cp->flags;
 	/* Bind with the destination and its corresponding transmitter */
 	if (flags & IP_VS_CONN_F_SYNC) {
+		/* Synced conns are hashed, so they can not get this flag */
+		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
+
 		/* if the connection is not template and is created
 		 * by sync, preserve the activity flag.
 		 */
@@ -624,23 +621,22 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 
 	/* Update the connection counters */
 	if (!(flags & IP_VS_CONN_F_TEMPLATE)) {
+		int tc;
+
 		/* It is a normal connection, so modify the counters
 		 * according to the flags, later the protocol can
 		 * update them on state change
 		 */
 		if (!(flags & IP_VS_CONN_F_INACTIVE))
 			atomic_inc(&dest->activeconns);
-		else
-			atomic_inc(&dest->inactconns);
+		tc = atomic_inc_return(&dest->totalconns);
+		if (tc == READ_ONCE(dest->u_threshold))
+			ip_vs_dest_update_overload(dest, 1);
 	} else {
 		/* It is a persistent connection/template, so increase
 		   the persistent connection counter */
 		atomic_inc(&dest->persistconns);
 	}
-
-	if (dest->u_threshold != 0 &&
-	    ip_vs_dest_totalconns(dest) >= dest->u_threshold)
-		dest->flags |= IP_VS_DEST_F_OVERLOAD;
 }
 
 
@@ -721,30 +717,20 @@ static inline void ip_vs_unbind_dest(struct ip_vs_conn *cp)
 
 	/* Update the connection counters */
 	if (!(cp->flags & IP_VS_CONN_F_TEMPLATE)) {
-		/* It is a normal connection, so decrease the inactconns
-		   or activeconns counter */
-		if (cp->flags & IP_VS_CONN_F_INACTIVE) {
-			atomic_dec(&dest->inactconns);
-		} else {
+		int tc;
+
+		/* It is a normal connection, so decrease the counters */
+		if (!(cp->flags & IP_VS_CONN_F_INACTIVE))
 			atomic_dec(&dest->activeconns);
-		}
+		tc = atomic_fetch_dec(&dest->totalconns);
+		if (tc == READ_ONCE(dest->l_threshold_val))
+			ip_vs_dest_update_overload(dest, -1);
 	} else {
 		/* It is a persistent connection/template, so decrease
 		   the persistent connection counter */
 		atomic_dec(&dest->persistconns);
 	}
 
-	if (dest->l_threshold != 0) {
-		if (ip_vs_dest_totalconns(dest) < dest->l_threshold)
-			dest->flags &= ~IP_VS_DEST_F_OVERLOAD;
-	} else if (dest->u_threshold != 0) {
-		if (ip_vs_dest_totalconns(dest) * 4 < dest->u_threshold * 3)
-			dest->flags &= ~IP_VS_DEST_F_OVERLOAD;
-	} else {
-		if (dest->flags & IP_VS_DEST_F_OVERLOAD)
-			dest->flags &= ~IP_VS_DEST_F_OVERLOAD;
-	}
-
 	ip_vs_dest_put(dest);
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 0abd47a4109f..ea9b5f434ec0 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1837,6 +1837,7 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 		if (pskb_pull(skb, offset2) == NULL)
 			goto ignore_tunnel;
 		skb_reset_network_header(skb);
+		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 		/* Ensure the IP header is present in headroom */
 		if (!pskb_may_pull(skb, hlen_orig))
 			goto ignore_tunnel;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 0805c9083eaa..025512d76db0 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -863,6 +863,40 @@ ip_vs_zero_stats(struct ip_vs_stats *stats)
 	spin_unlock_bh(&stats->lock);
 }
 
+/* Update overload flag based on number of dest conns and lower/upper
+ * connection thresholds:
+ * - conns reach u_threshold and exceed it: set the flag
+ * - conns go below l_threshold (or 75% of u_threshold): clear the flag
+ */
+static void __ip_vs_dest_update_overload(struct ip_vs_dest *dest, int mode)
+{
+	int conns;
+	u32 l, u;
+
+	lockdep_assert_held(&dest->dst_lock);
+	u = READ_ONCE(dest->u_threshold);
+	if (!u)
+		goto unset;
+	l = READ_ONCE(dest->l_threshold_val);
+	conns = atomic_read(&dest->totalconns);
+	if (conns >= (mode > 0 ? l : u)) {
+		dest->flags |= IP_VS_DEST_F_OVERLOAD;
+		return;
+	}
+	if (conns >= (mode < 0 ? u : l))
+		return;
+
+unset:
+	dest->flags &= ~IP_VS_DEST_F_OVERLOAD;
+}
+
+void ip_vs_dest_update_overload(struct ip_vs_dest *dest, int mode)
+{
+	spin_lock_bh(&dest->dst_lock);
+	__ip_vs_dest_update_overload(dest, mode);
+	spin_unlock_bh(&dest->dst_lock);
+}
+
 /*
  *	Update a destination in the given service
  */
@@ -929,10 +963,19 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 	/* set the dest status flags */
 	dest->flags |= IP_VS_DEST_F_AVAILABLE;
 
-	if (udest->u_threshold == 0 || udest->u_threshold > dest->u_threshold)
-		dest->flags &= ~IP_VS_DEST_F_OVERLOAD;
-	dest->u_threshold = udest->u_threshold;
-	dest->l_threshold = udest->l_threshold;
+	if (READ_ONCE(dest->u_threshold) != udest->u_threshold ||
+	    READ_ONCE(dest->l_threshold) != udest->l_threshold) {
+		spin_lock_bh(&dest->dst_lock);
+		WRITE_ONCE(dest->u_threshold, udest->u_threshold);
+		WRITE_ONCE(dest->l_threshold, udest->l_threshold);
+		/* Low threshold defaults to 75% of upper threshold */
+		WRITE_ONCE(dest->l_threshold_val,
+			   udest->l_threshold ? :
+			   (udest->u_threshold -
+			    (udest->u_threshold >> 2)));
+		__ip_vs_dest_update_overload(dest, 0);
+		spin_unlock_bh(&dest->dst_lock);
+	}
 
 	dest->af = udest->af;
 
@@ -1011,7 +1054,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest,
 	dest->port = udest->port;
 
 	atomic_set(&dest->activeconns, 0);
-	atomic_set(&dest->inactconns, 0);
+	atomic_set(&dest->totalconns, 0);
 	atomic_set(&dest->persistconns, 0);
 	refcount_set(&dest->refcnt, 1);
 
@@ -1055,6 +1098,9 @@ ip_vs_add_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 		return -ERANGE;
 	}
 
+	if (udest->u_threshold > INT_MAX)
+		return -EINVAL;
+
 	if (udest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		if (udest->tun_port == 0) {
 			pr_err("%s(): tunnel port is zero\n", __func__);
@@ -1126,6 +1172,9 @@ ip_vs_edit_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 		return -ERANGE;
 	}
 
+	if (udest->u_threshold > INT_MAX)
+		return -EINVAL;
+
 	if (udest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		if (udest->tun_port == 0) {
 			pr_err("%s(): tunnel port is zero\n", __func__);
@@ -2223,7 +2272,7 @@ static int ip_vs_info_seq_show(struct seq_file *seq, void *v)
 					   ip_vs_fwd_name(atomic_read(&dest->conn_flags)),
 					   atomic_read(&dest->weight),
 					   atomic_read(&dest->activeconns),
-					   atomic_read(&dest->inactconns));
+					   ip_vs_dest_inactconns(dest));
 			else
 #endif
 				seq_printf(seq,
@@ -2234,7 +2283,7 @@ static int ip_vs_info_seq_show(struct seq_file *seq, void *v)
 					   ip_vs_fwd_name(atomic_read(&dest->conn_flags)),
 					   atomic_read(&dest->weight),
 					   atomic_read(&dest->activeconns),
-					   atomic_read(&dest->inactconns));
+					   ip_vs_dest_inactconns(dest));
 
 		}
 	}
@@ -2712,10 +2761,10 @@ __ip_vs_get_dest_entries(struct netns_ipvs *ipvs, const struct ip_vs_get_dests *
 			entry.port = dest->port;
 			entry.conn_flags = atomic_read(&dest->conn_flags);
 			entry.weight = atomic_read(&dest->weight);
-			entry.u_threshold = dest->u_threshold;
-			entry.l_threshold = dest->l_threshold;
+			entry.u_threshold = READ_ONCE(dest->u_threshold);
+			entry.l_threshold = READ_ONCE(dest->l_threshold);
 			entry.activeconns = atomic_read(&dest->activeconns);
-			entry.inactconns = atomic_read(&dest->inactconns);
+			entry.inactconns = ip_vs_dest_inactconns(dest);
 			entry.persistconns = atomic_read(&dest->persistconns);
 			ip_vs_copy_stats(&kstats, &dest->stats);
 			ip_vs_export_stats_user(&entry.stats, &kstats);
@@ -3314,12 +3363,14 @@ static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest)
 			 dest->tun_port) ||
 	    nla_put_u16(skb, IPVS_DEST_ATTR_TUN_FLAGS,
 			dest->tun_flags) ||
-	    nla_put_u32(skb, IPVS_DEST_ATTR_U_THRESH, dest->u_threshold) ||
-	    nla_put_u32(skb, IPVS_DEST_ATTR_L_THRESH, dest->l_threshold) ||
+	    nla_put_u32(skb, IPVS_DEST_ATTR_U_THRESH,
+			READ_ONCE(dest->u_threshold)) ||
+	    nla_put_u32(skb, IPVS_DEST_ATTR_L_THRESH,
+			READ_ONCE(dest->l_threshold)) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_ACTIVE_CONNS,
 			atomic_read(&dest->activeconns)) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_INACT_CONNS,
-			atomic_read(&dest->inactconns)) ||
+			ip_vs_dest_inactconns(dest)) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_PERSIST_CONNS,
 			atomic_read(&dest->persistconns)) ||
 	    nla_put_u16(skb, IPVS_DEST_ATTR_ADDR_FAMILY, dest->af))
diff --git a/net/netfilter/ipvs/ip_vs_lc.c b/net/netfilter/ipvs/ip_vs_lc.c
index 9d34d81fc6f1..534db3c4a016 100644
--- a/net/netfilter/ipvs/ip_vs_lc.c
+++ b/net/netfilter/ipvs/ip_vs_lc.c
@@ -31,7 +31,7 @@ ip_vs_lc_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 
 	/*
 	 * Simply select the server with the least number of
-	 *        (activeconns<<5) + inactconns
+	 *        (activeconns*256) + totalconns
 	 * Except whose weight is equal to zero.
 	 * If the weight is equal to zero, it means that the server is
 	 * quiesced, the existing connections to the server still get
@@ -57,7 +57,7 @@ ip_vs_lc_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 			      IP_VS_DBG_ADDR(least->af, &least->addr),
 			      ntohs(least->port),
 			      atomic_read(&least->activeconns),
-			      atomic_read(&least->inactconns));
+			      ip_vs_dest_inactconns(least));
 
 	return least;
 }
diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index c67317be17df..91ce6ef6569e 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -443,12 +443,10 @@ set_sctp_state(struct ip_vs_proto_data *pd, struct ip_vs_conn *cp,
 			if (!(cp->flags & IP_VS_CONN_F_INACTIVE) &&
 				(next_state != IP_VS_SCTP_S_ESTABLISHED)) {
 				atomic_dec(&dest->activeconns);
-				atomic_inc(&dest->inactconns);
 				cp->flags |= IP_VS_CONN_F_INACTIVE;
 			} else if ((cp->flags & IP_VS_CONN_F_INACTIVE) &&
 				   (next_state == IP_VS_SCTP_S_ESTABLISHED)) {
 				atomic_inc(&dest->activeconns);
-				atomic_dec(&dest->inactconns);
 				cp->flags &= ~IP_VS_CONN_F_INACTIVE;
 			}
 		}
diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index b382810156b2..662de09b27b8 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -555,12 +555,10 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct ip_vs_conn *cp,
 			if (!(cp->flags & IP_VS_CONN_F_INACTIVE) &&
 			    !tcp_state_active(new_state)) {
 				atomic_dec(&dest->activeconns);
-				atomic_inc(&dest->inactconns);
 				cp->flags |= IP_VS_CONN_F_INACTIVE;
 			} else if ((cp->flags & IP_VS_CONN_F_INACTIVE) &&
 				   tcp_state_active(new_state)) {
 				atomic_inc(&dest->activeconns);
-				atomic_dec(&dest->inactconns);
 				cp->flags &= ~IP_VS_CONN_F_INACTIVE;
 			}
 		}
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index bfb1d04b0151..04ae99aacb85 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -879,13 +879,10 @@ static void ip_vs_proc_conn(struct netns_ipvs *ipvs, struct ip_vs_conn_param *pa
 		spin_lock_bh(&cp->lock);
 		if ((cp->flags ^ flags) & IP_VS_CONN_F_INACTIVE &&
 		    !(flags & IP_VS_CONN_F_TEMPLATE) && dest) {
-			if (flags & IP_VS_CONN_F_INACTIVE) {
+			if (flags & IP_VS_CONN_F_INACTIVE)
 				atomic_dec(&dest->activeconns);
-				atomic_inc(&dest->inactconns);
-			} else {
+			else
 				atomic_inc(&dest->activeconns);
-				atomic_dec(&dest->inactconns);
-			}
 		}
 		flags &= IP_VS_CONN_F_BACKUP_UPD_MASK;
 		flags |= cp->flags & ~IP_VS_CONN_F_BACKUP_UPD_MASK;
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 4326d5ea0400..0f6147ea9e67 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1622,7 +1622,7 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 	unsigned int matchoff, matchlen;
 	unsigned int msglen, origlen;
 	const char *dptr, *end;
-	s16 diff, tdiff = 0;
+	s32 diff, tdiff = 0;
 	int ret = NF_ACCEPT;
 	unsigned long clen;
 	bool term;
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index 76a8bbb44951..7687d3d15df2 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -313,7 +313,7 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 }
 
 static void nf_nat_sip_seq_adjust(struct sk_buff *skb, unsigned int protoff,
-				  s16 off)
+				  s32 off)
 {
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index ae0c4cd2dd1c..df296551ba6f 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -159,9 +159,7 @@ static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
 static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 				     u32 priv_len, u32 field_len)
 {
-	unsigned int remainder, delta, k;
 	struct nft_data mask = {};
-	__be32 remainder_mask;
 
 	if (priv_len == field_len) {
 		memset(&reg->mask, 0xff, priv_len);
@@ -170,15 +168,7 @@ static bool nft_payload_offload_mask(struct nft_offload_reg *reg,
 		return false;
 	}
 
-	memset(&mask, 0xff, field_len);
-	remainder = priv_len % sizeof(u32);
-	if (remainder) {
-		k = priv_len / sizeof(u32);
-		delta = field_len - priv_len;
-		remainder_mask = htonl(~((1 << (delta * BITS_PER_BYTE)) - 1));
-		mask.data[k] = (__force u32)remainder_mask;
-	}
-
+	memset(&mask, 0xff, priv_len);
 	memcpy(&reg->mask, &mask, field_len);
 
 	return true;
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 9c5cfd74a0ee..26918fa575af 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -118,6 +118,7 @@ struct xt_hashlimit_htable {
 	refcount_t use;
 	u_int8_t family;
 	bool rnd_initialized;
+	bool ratematch;
 
 	struct hashlimit_cfg3 cfg;	/* config */
 
@@ -325,6 +326,7 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 		vfree(hinfo);
 		return -ENOMEM;
 	}
+	hinfo->ratematch = !!(cfg->mode & XT_HASHLIMIT_RATE_MATCH);
 	spin_lock_init(&hinfo->lock);
 
 	switch (revision) {
@@ -868,7 +870,10 @@ static int hashlimit_mt_check_common(const struct xt_mtchk_param *par,
 	}
 
 	/* Check for overflow. */
-	if (revision >= 3 && cfg->mode & XT_HASHLIMIT_RATE_MATCH) {
+	if (cfg->mode & XT_HASHLIMIT_RATE_MATCH) {
+		if (revision < 3)
+			return -EINVAL;
+
 		if (cfg->avg == 0 || cfg->avg > U32_MAX) {
 			pr_info_ratelimited("invalid rate\n");
 			return -ERANGE;
@@ -901,6 +906,15 @@ static int hashlimit_mt_check_common(const struct xt_mtchk_param *par,
 			mutex_unlock(&hashlimit_mutex);
 			return ret;
 		}
+	} else {
+		if ((cfg->mode & XT_HASHLIMIT_RATE_MATCH &&
+		     !(*hinfo)->ratematch) ||
+		    (!(cfg->mode & XT_HASHLIMIT_RATE_MATCH) &&
+		      (*hinfo)->ratematch)) {
+			mutex_unlock(&hashlimit_mutex);
+			htable_put(*hinfo);
+			return -EINVAL;
+		}
 	}
 	mutex_unlock(&hashlimit_mutex);
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 3b3cc6ea274f..99fff9d6596c 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -855,12 +855,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-		if (unlikely(cutlen > 0)) {
-			if (skb->len - cutlen > ovs_mac_header_len(key))
-				pskb_trim(skb, skb->len - cutlen);
-			else
-				pskb_trim(skb, ovs_mac_header_len(key));
-		}
+		if (unlikely(cutlen < skb->len))
+			pskb_trim(skb, max(cutlen, ovs_mac_header_len(key)));
 
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
@@ -1104,6 +1100,10 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
+/* When 'last' is true, recirc() should always consume the 'skb'.
+ * Otherwise, recirc() should keep 'skb' intact regardless what
+ * actions are executed on recirculation.
+ */
 static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 			  struct sw_flow_key *key,
 			  const struct nlattr *a, bool last)
@@ -1114,8 +1114,11 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 		int err;
 
 		err = ovs_flow_key_update(skb, key);
-		if (err)
+		if (err) {
+			if (last)
+				kfree_skb(skb);
 			return err;
+		}
 	}
 	BUG_ON(!is_flow_key_valid(key));
 
@@ -1232,22 +1235,21 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			clone = skb_clone(skb, GFP_ATOMIC);
 			if (clone)
 				do_output(dp, clone, port, key);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_TRUNC: {
 			struct ovs_action_trunc *trunc = nla_data(a);
 
-			if (skb->len > trunc->max_len)
-				OVS_CB(skb)->cutlen = skb->len - trunc->max_len;
+			OVS_CB(skb)->cutlen = trunc->max_len;
 			break;
 		}
 
 		case OVS_ACTION_ATTR_USERSPACE:
 			output_userspace(dp, skb, key, a, attr,
 						     len, OVS_CB(skb)->cutlen);
-			OVS_CB(skb)->cutlen = 0;
+			OVS_CB(skb)->cutlen = U32_MAX;
 			break;
 
 		case OVS_ACTION_ATTR_HASH:
@@ -1321,7 +1323,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			if (!is_flow_key_valid(key)) {
 				err = ovs_flow_key_update(skb, key);
 				if (err)
-					return err;
+					break;
 			}
 
 			err = ovs_ct_execute(ovs_dp_get_net(dp), skb, key,
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 5fb74fbcb2f3..b5ab925d63a4 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -240,7 +240,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 		upcall.cmd = OVS_PACKET_CMD_MISS;
 		upcall.portid = ovs_vport_find_upcall_portid(p, skb);
 		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+		error = ovs_dp_upcall(dp, skb, key, &upcall, U32_MAX);
 		switch (error) {
 		case 0:
 		case -EAGAIN:
@@ -400,7 +400,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	struct sk_buff *nskb = NULL;
 	struct sk_buff *user_skb = NULL; /* to be queued to userspace */
 	struct nlattr *nla;
-	size_t len;
+	size_t msg_size;
+	size_t skb_len;
 	unsigned int hlen;
 	int err, dp_ifindex;
 	u64 hash;
@@ -421,7 +422,8 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		skb = nskb;
 	}
 
-	if (nla_attr_size(skb->len) > USHRT_MAX) {
+	skb_len = min(skb->len, cutlen);
+	if (nla_attr_size(skb_len) > USHRT_MAX) {
 		err = -EFBIG;
 		goto out;
 	}
@@ -436,13 +438,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	 * padding logic. Only perform zerocopy if padding is not required.
 	 */
 	if (dp->user_features & OVS_DP_F_UNALIGNED)
-		hlen = skb_zerocopy_headlen(skb);
+		hlen = min(skb_zerocopy_headlen(skb), cutlen);
 	else
-		hlen = skb->len;
+		hlen = skb_len;
 
-	len = upcall_msg_size(upcall_info, hlen - cutlen,
-			      OVS_CB(skb)->acts_origlen);
-	user_skb = genlmsg_new(len, GFP_ATOMIC);
+	msg_size = upcall_msg_size(upcall_info, hlen,
+				   OVS_CB(skb)->acts_origlen);
+	user_skb = genlmsg_new(msg_size, GFP_ATOMIC);
 	if (!user_skb) {
 		err = -ENOMEM;
 		goto out;
@@ -503,7 +505,7 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	}
 
 	/* Add OVS_PACKET_ATTR_LEN when packet is truncated */
-	if (cutlen > 0 &&
+	if (skb_len < skb->len &&
 	    nla_put_u32(user_skb, OVS_PACKET_ATTR_LEN, skb->len)) {
 		err = -ENOBUFS;
 		goto out;
@@ -528,9 +530,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 		err = -ENOBUFS;
 		goto out;
 	}
-	nla->nla_len = nla_attr_size(skb->len - cutlen);
+	nla->nla_len = nla_attr_size(skb_len);
 
-	err = skb_zerocopy(user_skb, skb, skb->len - cutlen, hlen);
+	err = skb_zerocopy(user_skb, skb, skb_len, hlen);
 	if (err)
 		goto out;
 
@@ -587,6 +589,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 		packet->ignore_df = 1;
 	}
 	OVS_CB(packet)->mru = mru;
+	OVS_CB(packet)->cutlen = U32_MAX;
 
 	if (a[OVS_PACKET_ATTR_HASH]) {
 		hash = nla_get_u64(a[OVS_PACKET_ATTR_HASH]);
@@ -1042,9 +1045,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 			error = -EEXIST;
 			goto err_unlock_ovs;
 		}
-		/* The flow identifier has to be the same for flow updates.
-		 * Look for any overlapping flow.
-		 */
+
+		/* Look for any overlapping flow. */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
 				flow = ovs_flow_tbl_lookup_exact(&dp->table,
@@ -1056,6 +1058,30 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				goto err_unlock_ovs;
 			}
 		}
+
+		if (unlikely(reply)) {
+			size_t cur, req;
+
+			cur = ovs_flow_cmd_msg_size(acts, &new_flow->id,
+						    ufid_flags);
+			req = ovs_flow_cmd_msg_size(acts, &flow->id,
+						    ufid_flags);
+			if (cur < req) {
+				struct sk_buff *resized;
+
+				resized = ovs_flow_cmd_alloc_info(acts,
+								  &flow->id,
+								  info, false,
+								  ufid_flags);
+				if (IS_ERR(resized)) {
+					error = PTR_ERR(resized);
+					goto err_unlock_ovs;
+				}
+				kfree_skb(reply);
+				reply = resized;
+			}
+		}
+
 		/* Update actions. */
 		old_acts = ovsl_dereference(flow->sf_acts);
 		rcu_assign_pointer(flow->sf_acts, acts);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 38f7d3e66ca6..62e7ad32f837 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -96,7 +96,7 @@ struct datapath {
  * @mru: The maximum received fragement size; 0 if the packet is not
  * fragmented.
  * @acts_origlen: The netlink size of the flow actions applied to this skb.
- * @cutlen: The number of bytes from the packet end to be removed.
+ * @cutlen: The number of bytes in the packet to preserve on output.
  */
 struct ovs_skb_cb {
 	struct vport		*input_vport;
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 94531289ed26..3f8a0d05161c 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -293,10 +293,14 @@ static bool icmp6hdr_ok(struct sk_buff *skb)
 }
 
 /**
- * Parse vlan tag from vlan header.
- * Returns ERROR on memory error.
- * Returns 0 if it encounters a non-vlan or incomplete packet.
- * Returns 1 after successfully parsing vlan tag.
+ * parse_vlan_tag - Parse vlan tag from vlan header.
+ * @skb: skb containing frame to parse
+ * @key_vh: pointer to parsed vlan tag
+ * @untag_vlan: should the vlan header be removed from the frame
+ *
+ * Return: ERROR on memory error.
+ * %0 if it encounters a non-vlan or incomplete packet.
+ * %1 after successfully parsing vlan tag.
  */
 static int parse_vlan_tag(struct sk_buff *skb, struct vlan_head *key_vh,
 			  bool untag_vlan)
@@ -529,6 +533,7 @@ static int parse_nsh(struct sk_buff *skb, struct sw_flow_key *key)
  *       L3 header
  * @key: output flow key
  *
+ * Return: %0 if successful, otherwise a negative errno value.
  */
 static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
 {
@@ -743,10 +748,6 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  * Ethernet header
  * @key: output flow key
  *
- * The caller must ensure that skb->len >= ETH_HLEN.
- *
- * Returns 0 if successful, otherwise a negative errno value.
- *
  * Initializes @skb header fields as follows:
  *
  *    - skb->mac_header: the L2 header.
@@ -761,11 +762,11 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
  *
  *    - skb->protocol: the type of the data starting at skb->network_header.
  *      Equals to key->eth.type.
+ *
+ * Return: %0 if successful, otherwise a negative errno value.
  */
 static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 {
-	struct ethhdr *eth;
-
 	/* Flags are always used as part of stats */
 	key->tp.flags = 0;
 
@@ -780,6 +781,13 @@ static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
 		skb_reset_network_header(skb);
 		key->eth.type = skb->protocol;
 	} else {
+		struct ethhdr *eth;
+		int err;
+
+		err = check_header(skb, ETH_HLEN);
+		if (unlikely(err))
+			return err;
+
 		eth = eth_hdr(skb);
 		ether_addr_copy(key->eth.src, eth->h_source);
 		ether_addr_copy(key->eth.dst, eth->h_dest);
diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index 0cf3dda5319f..b82bdbe57b6c 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -136,18 +136,10 @@ static void dp_meter_instance_remove(struct dp_meter_instance *ti,
 
 static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
 {
-	struct dp_meter_instance *ti = rcu_dereference_ovsl(tbl->ti);
-	u32 hash = meter_hash(ti, meter->id);
+	struct dp_meter_instance *ti;
+	u32 hash;
 	int err;
 
-	/* In generally, slots selected should be empty, because
-	 * OvS uses id-pool to fetch a available id.
-	 */
-	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash])))
-		return -EBUSY;
-
-	dp_meter_instance_insert(ti, meter);
-
 	/* That function is thread-safe. */
 	tbl->count++;
 	if (tbl->count >= tbl->max_meters_allowed) {
@@ -155,16 +147,29 @@ static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
 		goto attach_err;
 	}
 
-	if (tbl->count >= ti->n_meters &&
-	    dp_meter_instance_realloc(tbl, ti->n_meters * 2)) {
-		err = -ENOMEM;
+	ti = rcu_dereference_ovsl(tbl->ti);
+	if (tbl->count >= ti->n_meters) {
+		err = dp_meter_instance_realloc(tbl, ti->n_meters * 2);
+		if (err)
+			goto attach_err;
+
+		ti = rcu_dereference_ovsl(tbl->ti);
+	}
+
+	hash = meter_hash(ti, meter->id);
+
+	/* In general, selected slots should be empty, because
+	 * OvS uses id-pool to fetch available ids.
+	 */
+	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash]))) {
+		err = -EBUSY;
 		goto attach_err;
 	}
 
+	dp_meter_instance_insert(ti, meter);
 	return 0;
 
 attach_err:
-	dp_meter_instance_remove(ti, meter);
 	tbl->count--;
 	return err;
 }
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index da733b92ae8a..2c876424864d 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -111,10 +111,12 @@ struct vport *ovs_vport_locate(const struct net *net, const char *name)
  *
  * @priv_size: Size of private data area to allocate.
  * @ops: vport device ops
+ * @parms: information about new vport.
  *
  * Allocate and initialize a new vport defined by @ops.  The vport will contain
  * a private data area of size @priv_size that can be accessed using
- * vport_priv().  vports that are no longer needed should be released with
+ * vport_priv().  Some parameters of the vport will be initialized from @parms.
+ * @vports that are no longer needed should be released with
  * vport_free().
  */
 struct vport *ovs_vport_alloc(int priv_size, const struct vport_ops *ops,
@@ -436,7 +438,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
-	OVS_CB(skb)->cutlen = 0;
+	OVS_CB(skb)->cutlen = U32_MAX;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 793720e50679..f73e2c3b813d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1938,11 +1938,12 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
 
+	/* On TX skb->data is the L2 header; anchor it for all socket types. */
+	skb_reset_mac_header(skb);
+
 	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
-	    sock->type == SOCK_RAW) {
-		skb_reset_mac_header(skb);
+	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
-	}
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
@@ -4551,7 +4552,11 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	spin_lock(&po->bind_lock);
 	WRITE_ONCE(po->num, num);
-	if (was_running)
+	/*
+	 * NETDEV_UNREGISTER may have invalidated the binding while bind_lock
+	 * was dropped above.  Do not re-add a fanout hook to a dead device.
+	 */
+	if (was_running && READ_ONCE(po->ifindex) != -1)
 		register_prot_hook(sk);
 
 	spin_unlock(&po->bind_lock);
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 612caf1fe37a..cac9631bd84a 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -55,6 +55,8 @@ static unsigned char *pep_get_sb(struct sk_buff *skb, u8 *ptype, u8 *plen,
 	ph = skb_header_pointer(skb, 0, 2, &h);
 	if (ph == NULL || ph->sb_len < 2 || !pskb_may_pull(skb, ph->sb_len))
 		return NULL;
+	/* pskb_may_pull() may have reallocated the head; refetch ph. */
+	ph = skb_header_pointer(skb, 0, 2, &h);
 	ph->sb_len -= 2;
 	*ptype = ph->sb_type;
 	*plen = ph->sb_len;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 0018a9b32241..31371f3c1a57 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1257,6 +1257,14 @@ static int qrtr_create(struct net *net, struct socket *sock,
 	if (sock->type != SOCK_DGRAM)
 		return -EPROTOTYPE;
 
+	/* QRTR keeps its port and node state in module-global variables that
+	 * are not partitioned per network namespace, and the in-kernel name
+	 * service only operates in init_net. Confine the family to init_net so
+	 * a socket in another namespace cannot reach the global control plane.
+	 */
+	if (!net_eq(net, &init_net))
+		return -EAFNOSUPPORT;
+
 	sk = sk_alloc(net, AF_QIPCRTR, GFP_KERNEL, &qrtr_proto, kern);
 	if (!sk)
 		return -ENOMEM;
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 36a7a9ad6b50..4246d21da5d1 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -68,22 +68,18 @@ struct qrtr_server {
 struct qrtr_node {
 	unsigned int id;
 	struct xarray servers;
+	u32 server_count;
 };
 
-/* Max lookup limit is chosen based on the current platform requirements. If the
- * requirement changes in the future, this value can be increased.
- */
-#define QRTR_NS_MAX_LOOKUPS 64
-
 /* Max nodes, server, lookup limits are chosen based on the current platform
  * requirements. If the requirement changes in the future, these values can be
  * increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 #define QRTR_NS_MAX_SERVERS 256
-#define QRTR_NS_MAX_LOOKUPS 64
+#define QRTR_NS_MAX_LOOKUPS 128
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
@@ -249,6 +245,17 @@ static struct qrtr_server *server_add(unsigned int service,
 	if (!service || !port)
 		return NULL;
 
+	node = node_get(node_id);
+	if (!node)
+		return NULL;
+
+	/* Make sure the new servers per port are capped at the maximum value */
+	old = xa_load(&node->servers, port);
+	if (!old && node->server_count >= QRTR_NS_MAX_SERVERS) {
+		pr_err_ratelimited("QRTR client node %u exceeds max server limit!\n", node_id);
+		return NULL;
+	}
+
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
 	if (!srv)
 		return NULL;
@@ -258,10 +265,6 @@ static struct qrtr_server *server_add(unsigned int service,
 	srv->node = node_id;
 	srv->port = port;
 
-	node = node_get(node_id);
-	if (!node)
-		goto err;
-
 	/* Delete the old server on the same port */
 	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
@@ -272,6 +275,8 @@ static struct qrtr_server *server_add(unsigned int service,
 		} else {
 			kfree(old);
 		}
+	} else {
+		node->server_count++;
 	}
 
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
@@ -312,6 +317,7 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	}
 
 	kfree(srv);
+	node->server_count--;
 
 	return 0;
 }
@@ -406,6 +412,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }
@@ -716,7 +723,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 
diff --git a/net/rds/ib.c b/net/rds/ib.c
index ec45664f3876..810a9b76101f 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -431,6 +431,10 @@ static int rds_ib_laddr_check_cm(struct net *net, const struct in6_addr *addr,
 		sa = (struct sockaddr *)&sin;
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
+		if (!ipv6_mod_enabled()) {
+			ret = -EADDRNOTAVAIL;
+			goto out;
+		}
 		memset(&sin6, 0, sizeof(sin6));
 		sin6.sin6_family = AF_INET6;
 		sin6.sin6_addr = *addr;
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index f643d1f59c3b..f23233e0a53c 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -844,6 +844,10 @@ int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
 	dp = event->param.conn.private_data;
 	if (isv6) {
 #if IS_ENABLED(CONFIG_IPV6)
+		if (!ipv6_mod_enabled()) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 		dp_cmn = &dp->ricp_v6.dp_cmn;
 		saddr6 = &dp->ricp_v6.dp_saddr;
 		daddr6 = &dp->ricp_v6.dp_daddr;
diff --git a/net/rds/recv.c b/net/rds/recv.c
index f570d64367a4..24a82e335d5a 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -365,6 +365,21 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		goto out;
 	}
 
+	/*
+	 * rds_find_bound() uses a global (netns-agnostic) hash table.
+	 * An RDS connection created in netns A can match a socket bound
+	 * in the init netns, delivering inc cross-netns with inc->i_conn
+	 * pointing into netns A.  When cleanup_net() then frees that conn,
+	 * any subsequent dereference of inc->i_conn is a use-after-free.
+	 * Drop the inc if the receiving socket lives in a different netns.
+	 */
+	if (!net_eq(sock_net(rds_rs_to_sk(rs)), rds_conn_net(conn))) {
+		rds_stats_inc(s_recv_drop_no_sock);
+		rds_sock_put(rs);
+		rs = NULL;
+		goto out;
+	}
+
 	/* Process extension headers */
 	rds_recv_incoming_exthdrs(inc, rs);
 
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index b560d06e6d96..f66cbf0b9895 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -330,21 +330,25 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 	/* If the scope_id is specified, check only those addresses
 	 * hosted on the specified interface.
 	 */
+	rcu_read_lock();
 	if (scope_id != 0) {
-		rcu_read_lock();
 		dev = dev_get_by_index_rcu(net, scope_id);
 		/* scope_id is not valid... */
 		if (!dev) {
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
-		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
-	ret = ipv6_chk_addr(net, addr, dev, 0);
-	if (ret)
-		return 0;
+	if (ipv6_mod_enabled()) {
+		ret = ipv6_chk_addr(net, addr, dev, 0);
+		if (ret) {
+			rcu_read_unlock();
+			return 0;
+		}
+	}
 #endif
+	rcu_read_unlock();
 	return -EADDRNOTAVAIL;
 }
 
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 0d90349636f0..5a28adcd370a 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -343,14 +343,20 @@ static const struct nla_policy tunnel_key_policy[TCA_TUNNEL_KEY_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_TTL]      = { .type = NLA_U8 },
 };
 
-static void tunnel_key_release_params(struct tcf_tunnel_key_params *p)
+static void tunnel_key_release_params_rcu(struct rcu_head *head)
 {
-	if (!p)
-		return;
+	struct tcf_tunnel_key_params *p = container_of(head, typeof(*p), rcu);
+
 	if (p->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
 		dst_release(&p->tcft_enc_metadata->dst);
+	kfree(p);
+}
 
-	kfree_rcu(p, rcu);
+static void tunnel_key_release_params(struct tcf_tunnel_key_params *p)
+{
+	if (!p)
+		return;
+	call_rcu(&p->rcu, tunnel_key_release_params_rcu);
 }
 
 static int tunnel_key_init(struct net *net, struct nlattr *nla,
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 1ad4b3e60eb3..695c91961e33 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -51,6 +51,7 @@ struct route4_filter {
 	struct tcf_result	res;
 	struct tcf_exts		exts;
 	u32			handle;
+	bool			dying;
 	struct route4_bucket	*bkt;
 	struct tcf_proto	*tp;
 	struct rcu_work		rwork;
@@ -65,9 +66,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
 
 static DEFINE_SPINLOCK(fastmap_lock);
 static void
-route4_reset_fastmap(struct route4_head *head)
+route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
 {
 	spin_lock_bh(&fastmap_lock);
+	if (f)
+		f->dying = true;
 	memset(head->fastmap, 0, sizeof(head->fastmap));
 	spin_unlock_bh(&fastmap_lock);
 }
@@ -80,9 +83,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, int iif,
 
 	/* fastmap updates must look atomic to aling id, iff, filter */
 	spin_lock_bh(&fastmap_lock);
-	head->fastmap[h].id = id;
-	head->fastmap[h].iif = iif;
-	head->fastmap[h].filter = f;
+	if (f == ROUTE4_FAILURE || !f->dying) {
+		head->fastmap[h].id = id;
+		head->fastmap[h].iif = iif;
+		head->fastmap[h].filter = f;
+	}
 	spin_unlock_bh(&fastmap_lock);
 }
 
@@ -295,6 +300,13 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 					next = rtnl_dereference(f->next);
 					RCU_INIT_POINTER(b->ht[h2], next);
 					tcf_unbind_filter(tp, &f->res);
+					/* Mark the filter dying under fastmap_lock so
+					 * any in-flight reader that still holds it
+					 * will skip the republish in route4_set_fastmap().
+					 */
+					spin_lock_bh(&fastmap_lock);
+					f->dying = true;
+					spin_unlock_bh(&fastmap_lock);
 					if (tcf_exts_get_net(&f->exts))
 						route4_queue_work(f);
 					else
@@ -305,6 +317,11 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 			kfree_rcu(b, rcu);
 		}
 	}
+
+	/* All filters are unlinked and marked dying, so no in-flight
+	 * reader can republish a stale entry after this reset.
+	 */
+	route4_reset_fastmap(head, NULL);
 	kfree_rcu(head, rcu);
 }
 
@@ -332,11 +349,11 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			/* unlink it */
 			RCU_INIT_POINTER(*fp, rtnl_dereference(f->next));
 
-			/* Remove any fastmap lookups that might ref filter
-			 * notice we unlink'd the filter so we can't get it
-			 * back in the fastmap.
+			/* Clear any fastmap entries that may ref this filter and
+			 * mark it dying so in-flight readers can't republish it
+			 * after the reset.
 			 */
-			route4_reset_fastmap(head);
+			route4_reset_fastmap(head, f);
 
 			/* Delete it */
 			tcf_unbind_filter(tp, &f->res);
@@ -551,7 +568,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		}
 	}
 
-	route4_reset_fastmap(head);
+	route4_reset_fastmap(head, fold);
 	*arg = f;
 	if (fold) {
 		tcf_unbind_filter(tp, &fold->res);
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 45b175e53aac..8e3010a18382 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1281,7 +1281,6 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 
 			seglen = ntohs(ipv6h_check->payload_len);
 		} else {
-			WARN_ON(1);  /* shouldn't happen */
 			continue;
 		}
 
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index c333a63c3465..8fc11f06ab23 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -542,6 +542,9 @@ void sctp_assoc_rm_peer(struct sctp_association *asoc,
 	    asoc->addip_last_asconf->transport == peer)
 		asoc->addip_last_asconf->transport = NULL;
 
+	if (asoc->new_transport == peer)
+		asoc->new_transport = NULL;
+
 	/* If we have something on the transmitted list, we have to
 	 * save it off.  The best place is the active path.
 	 */
@@ -572,6 +575,10 @@ void sctp_assoc_rm_peer(struct sctp_association *asoc,
 		if (ch->transport == peer)
 			ch->transport = NULL;
 
+	list_for_each_entry(ch, &asoc->outqueue.control_chunk_list, list)
+		if (ch->transport == peer)
+			ch->transport = NULL;
+
 	asoc->peer.transport_count--;
 
 	sctp_ulpevent_notify_peer_addr_change(peer, SCTP_ADDR_REMOVED, 0);
@@ -613,6 +620,9 @@ struct sctp_transport *sctp_assoc_add_peer(struct sctp_association *asoc,
 		return peer;
 	}
 
+	if (asoc->peer.transport_count == U16_MAX)
+		return NULL;
+
 	peer = sctp_transport_new(asoc->base.net, addr, gfp);
 	if (!peer)
 		return NULL;
@@ -1715,6 +1725,8 @@ void sctp_asconf_queue_teardown(struct sctp_association *asoc)
 	sctp_assoc_free_asconf_queue(asoc);
 
 	/* Free any cached ASCONF chunk. */
-	if (asoc->addip_last_asconf)
+	if (asoc->addip_last_asconf) {
 		sctp_chunk_free(asoc->addip_last_asconf);
+		asoc->addip_last_asconf = NULL;
+	}
 }
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index 34964145514e..a983f96bb0c3 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -766,7 +766,7 @@ int sctp_auth_ep_add_chunkid(struct sctp_endpoint *ep, __u8 chunk_id)
 	/* Check if we can add this chunk to the array */
 	param_len = ntohs(p->param_hdr.length);
 	nchunks = param_len - sizeof(struct sctp_paramhdr);
-	if (nchunks == SCTP_NUM_CHUNK_TYPES)
+	if (nchunks == SCTP_AUTH_MAX_CHUNKS)
 		return -EINVAL;
 
 	p->chunks[nchunks] = chunk_id;
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 3c7761199f20..731d12e8038c 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -556,6 +556,49 @@ void sctp_err_finish(struct sock *sk, struct sctp_transport *t)
 	sctp_transport_put(t);
 }
 
+static void sctp_v4_err_handle(struct sctp_transport *t, struct sk_buff *skb,
+			       __u8 type, __u8 code, __u32 info)
+{
+	struct sctp_association *asoc = t->asoc;
+	struct sock *sk = asoc->base.sk;
+	int err = 0;
+
+	switch (type) {
+	case ICMP_PARAMETERPROB:
+		err = EPROTO;
+		break;
+	case ICMP_DEST_UNREACH:
+		if (code > NR_ICMP_UNREACH)
+			return;
+		if (code == ICMP_FRAG_NEEDED) {
+			sctp_icmp_frag_needed(sk, asoc, t, SCTP_TRUNC4(info));
+			return;
+		}
+		if (code == ICMP_PROT_UNREACH) {
+			sctp_icmp_proto_unreachable(sk, asoc, t);
+			return;
+		}
+		err = icmp_err_convert[code].errno;
+		break;
+	case ICMP_TIME_EXCEEDED:
+		if (code == ICMP_EXC_FRAGTIME)
+			return;
+
+		err = EHOSTUNREACH;
+		break;
+	case ICMP_REDIRECT:
+		sctp_icmp_redirect(sk, t, skb);
+	default:
+		return;
+	}
+	if (!sock_owned_by_user(sk) && inet_sk(sk)->recverr) {
+		sk->sk_err = err;
+		sk->sk_error_report(sk);
+	} else {  /* Only an error on timeout */
+		sk->sk_err_soft = err;
+	}
+}
+
 /*
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
@@ -574,22 +617,19 @@ void sctp_err_finish(struct sock *sk, struct sctp_transport *t)
 int sctp_v4_err(struct sk_buff *skb, __u32 info)
 {
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	const int ihlen = iph->ihl * 4;
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	struct sock *sk;
-	struct sctp_association *asoc = NULL;
+	struct net *net = dev_net(skb->dev);
 	struct sctp_transport *transport;
-	struct inet_sock *inet;
+	struct sctp_association *asoc;
 	__u16 saveip, savesctp;
-	int err;
-	struct net *net = dev_net(skb->dev);
+	struct sock *sk;
 
 	/* Fix up skb to look at the embedded net header. */
 	saveip = skb->network_header;
 	savesctp = skb->transport_header;
 	skb_reset_network_header(skb);
-	skb_set_transport_header(skb, ihlen);
+	skb_set_transport_header(skb, iph->ihl * 4);
 	sk = sctp_err_lookup(net, AF_INET, skb, sctp_hdr(skb), &asoc, &transport);
 	/* Put back, the original values. */
 	skb->network_header = saveip;
@@ -598,58 +638,10 @@ int sctp_v4_err(struct sk_buff *skb, __u32 info)
 		__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
 		return -ENOENT;
 	}
-	/* Warning:  The sock lock is held.  Remember to call
-	 * sctp_err_finish!
-	 */
-
-	switch (type) {
-	case ICMP_PARAMETERPROB:
-		err = EPROTO;
-		break;
-	case ICMP_DEST_UNREACH:
-		if (code > NR_ICMP_UNREACH)
-			goto out_unlock;
-
-		/* PMTU discovery (RFC1191) */
-		if (ICMP_FRAG_NEEDED == code) {
-			sctp_icmp_frag_needed(sk, asoc, transport,
-					      SCTP_TRUNC4(info));
-			goto out_unlock;
-		} else {
-			if (ICMP_PROT_UNREACH == code) {
-				sctp_icmp_proto_unreachable(sk, asoc,
-							    transport);
-				goto out_unlock;
-			}
-		}
-		err = icmp_err_convert[code].errno;
-		break;
-	case ICMP_TIME_EXCEEDED:
-		/* Ignore any time exceeded errors due to fragment reassembly
-		 * timeouts.
-		 */
-		if (ICMP_EXC_FRAGTIME == code)
-			goto out_unlock;
-
-		err = EHOSTUNREACH;
-		break;
-	case ICMP_REDIRECT:
-		sctp_icmp_redirect(sk, transport, skb);
-		/* Fall through to out_unlock. */
-	default:
-		goto out_unlock;
-	}
-
-	inet = inet_sk(sk);
-	if (!sock_owned_by_user(sk) && inet->recverr) {
-		sk->sk_err = err;
-		sk->sk_error_report(sk);
-	} else {  /* Only an error on timeout */
-		sk->sk_err_soft = err;
-	}
 
-out_unlock:
+	sctp_v4_err_handle(transport, skb, type, code, info);
 	sctp_err_finish(sk, transport);
+
 	return 0;
 }
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index a9cfe4d62df8..48bd3b52d56d 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -121,54 +121,28 @@ static struct notifier_block sctp_inet6addr_notifier = {
 	.notifier_call = sctp_inet6addr_event,
 };
 
-/* ICMP error handler. */
-static int sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-			u8 type, u8 code, int offset, __be32 info)
+static void sctp_v6_err_handle(struct sctp_transport *t, struct sk_buff *skb,
+			       __u8 type, __u8 code, __u32 info)
 {
-	struct inet6_dev *idev;
-	struct sock *sk;
-	struct sctp_association *asoc;
-	struct sctp_transport *transport;
+	struct sctp_association *asoc = t->asoc;
+	struct sock *sk = asoc->base.sk;
 	struct ipv6_pinfo *np;
-	__u16 saveip, savesctp;
-	int err, ret = 0;
-	struct net *net = dev_net(skb->dev);
-
-	idev = in6_dev_get(skb->dev);
-
-	/* Fix up skb to look at the embedded net header. */
-	saveip	 = skb->network_header;
-	savesctp = skb->transport_header;
-	skb_reset_network_header(skb);
-	skb_set_transport_header(skb, offset);
-	sk = sctp_err_lookup(net, AF_INET6, skb, sctp_hdr(skb), &asoc, &transport);
-	/* Put back, the original pointers. */
-	skb->network_header   = saveip;
-	skb->transport_header = savesctp;
-	if (!sk) {
-		__ICMP6_INC_STATS(net, idev, ICMP6_MIB_INERRORS);
-		ret = -ENOENT;
-		goto out;
-	}
-
-	/* Warning:  The sock lock is held.  Remember to call
-	 * sctp_err_finish!
-	 */
+	int err = 0;
 
 	switch (type) {
 	case ICMPV6_PKT_TOOBIG:
 		if (ip6_sk_accept_pmtu(sk))
-			sctp_icmp_frag_needed(sk, asoc, transport, ntohl(info));
-		goto out_unlock;
+			sctp_icmp_frag_needed(sk, asoc, t, info);
+		return;
 	case ICMPV6_PARAMPROB:
 		if (ICMPV6_UNK_NEXTHDR == code) {
-			sctp_icmp_proto_unreachable(sk, asoc, transport);
-			goto out_unlock;
+			sctp_icmp_proto_unreachable(sk, asoc, t);
+			return;
 		}
 		break;
 	case NDISC_REDIRECT:
-		sctp_icmp_redirect(sk, transport, skb);
-		goto out_unlock;
+		sctp_icmp_redirect(sk, t, skb);
+		return;
 	default:
 		break;
 	}
@@ -178,17 +152,39 @@ static int sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (!sock_owned_by_user(sk) && np->recverr) {
 		sk->sk_err = err;
 		sk->sk_error_report(sk);
-	} else {  /* Only an error on timeout */
+	} else {
 		sk->sk_err_soft = err;
 	}
+}
 
-out_unlock:
+/* ICMP error handler. */
+static int sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+		       u8 type, u8 code, int offset, __be32 info)
+{
+	struct net *net = dev_net(skb->dev);
+	struct sctp_transport *transport;
+	struct sctp_association *asoc;
+	__u16 saveip, savesctp;
+	struct sock *sk;
+
+	/* Fix up skb to look at the embedded net header. */
+	saveip	 = skb->network_header;
+	savesctp = skb->transport_header;
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, offset);
+	sk = sctp_err_lookup(net, AF_INET6, skb, sctp_hdr(skb), &asoc, &transport);
+	/* Put back, the original pointers. */
+	skb->network_header   = saveip;
+	skb->transport_header = savesctp;
+	if (!sk) {
+		__ICMP6_INC_STATS(net, __in6_dev_get(skb->dev), ICMP6_MIB_INERRORS);
+		return -ENOENT;
+	}
+
+	sctp_v6_err_handle(transport, skb, type, code, ntohl(info));
 	sctp_err_finish(sk, transport);
-out:
-	if (likely(idev != NULL))
-		in6_dev_put(idev);
 
-	return ret;
+	return 0;
 }
 
 static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *transport)
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index 83a89dcf75ed..4736781078f9 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -647,6 +647,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q, struct sctp_packet *pkt,
 		if (chunk->tsn_gap_acked) {
 			list_move_tail(&chunk->transmitted_list,
 				       &transport->transmitted);
+			chunk->transport = transport;
 			continue;
 		}
 
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index e9d89409cb5e..06309c1869da 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1776,9 +1776,9 @@ struct sctp_association *sctp_unpack_cookie(
 		goto fail;
 	}
 
-	/* Check to see if the cookie is stale.  If there is already
-	 * an association, there is no need to check cookie's expiration
-	 * for init collision case of lost COOKIE ACK.
+	/* Check to see if the cookie is stale.  RFC 9260 Section 5.2.4
+	 * exempts an expired cookie only when both Verification Tags match
+	 * the current association.
 	 * If skb has been timestamped, then use the stamp, otherwise
 	 * use current time.  This introduces a small possibility that
 	 * a cookie may be considered expired, but this would only slow
@@ -1789,7 +1789,10 @@ struct sctp_association *sctp_unpack_cookie(
 	else
 		kt = ktime_get_real();
 
-	if (!asoc && ktime_before(bear_cookie->expiration, kt)) {
+	if ((!asoc ||
+	     asoc->c.my_vtag != bear_cookie->my_vtag ||
+	     asoc->c.peer_vtag != bear_cookie->peer_vtag) &&
+	    ktime_before(bear_cookie->expiration, kt)) {
 		suseconds_t usecs = ktime_to_us(ktime_sub(kt, bear_cookie->expiration));
 		__be32 n = htonl(usecs);
 
@@ -2142,7 +2145,13 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
 	case SCTP_PARAM_HEARTBEAT_INFO:
 	case SCTP_PARAM_UNRECOGNIZED_PARAMETERS:
 	case SCTP_PARAM_ECN_CAPABLE:
+		break;
 	case SCTP_PARAM_ADAPTATION_LAYER_IND:
+		if (ntohs(param.p->length) != sizeof(*param.aind)) {
+			sctp_process_inv_paramlength(asoc, param.p,
+						     chunk, err_chunk);
+			retval = SCTP_IERROR_ABORT;
+		}
 		break;
 
 	case SCTP_PARAM_SUPPORTED_EXT:
@@ -3133,6 +3142,12 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		if (!peer)
 			return SCTP_ERROR_DNS_FAILED;
 
+		/* Don't free asconf->transport; a later wildcard DEL-IP
+		 * parameter reuses it.
+		 */
+		if (peer == asconf->transport)
+			return SCTP_ERROR_REQ_REFUSED;
+
 		sctp_assoc_rm_peer(asoc, peer);
 		break;
 	case SCTP_PARAM_SET_PRIMARY:
@@ -3301,12 +3316,11 @@ struct sctp_chunk *sctp_process_asconf(struct sctp_association *asoc,
 			goto done;
 	}
 done:
-	asoc->peer.addip_serial++;
-
 	/* If we are sending a new ASCONF_ACK hold a reference to it in assoc
 	 * after freeing the reference to old asconf ack if any.
 	 */
 	if (asconf_ack) {
+		asoc->peer.addip_serial++;
 		sctp_chunk_hold(asconf_ack);
 		list_add_tail(&asconf_ack->transmitted_list,
 			      &asoc->asconf_ack_list);
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 17b9deb0cc75..ea5c941821ec 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -632,7 +632,7 @@ static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
 	struct sctp_chunk auth;
 
 	if (!chunk->auth_chunk)
-		return true;
+		return !sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc);
 
 	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
 	 * is supposed to be authenticated and we have to do delayed
@@ -5999,8 +5999,12 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
 					struct sctp_cmd_seq *commands)
 {
 	struct sctp_chunk *chunk = asoc->addip_last_asconf;
-	struct sctp_transport *transport = chunk->transport;
+	struct sctp_transport *transport;
+
+	if (!chunk)
+		return SCTP_DISPOSITION_CONSUME;
 
+	transport = chunk->transport;
 	SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);
 
 	/* ADDIP 4.1 B1) Increment the error counters and perform path failure
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index d38e5431f359..34754ba23198 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
 					goto out;
 
 			param_len += str_nums * sizeof(__u16) +
-				     sizeof(struct sctp_strreset_inreq);
+				     (out ? sizeof(struct sctp_strreset_inreq)
+					  : sizeof(struct sctp_strreset_outreq));
 		}
 
 		if (param_len > SCTP_MAX_CHUNK_LEN -
@@ -639,6 +640,9 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 
 	nums = (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16);
 	str_p = inreq->list_of_streams;
+	if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
+	    SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
+		goto out;
 	for (i = 0; i < nums; i++) {
 		if (ntohs(str_p[i]) >= stream->outcnt) {
 			result = SCTP_STRRESET_ERR_WRONG_SSN;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 0e9d22e9c760..995c48388885 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -919,10 +919,10 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 	read_lock_bh(&lgr->conns_lock);
 	node = rb_first(&lgr->conns_all);
 	while (node) {
-		read_unlock_bh(&lgr->conns_lock);
 		conn = rb_entry(node, struct smc_connection, alert_node);
 		smc = container_of(conn, struct smc_sock, conn);
 		sock_hold(&smc->sk); /* sock_put below */
+		read_unlock_bh(&lgr->conns_lock);
 		lock_sock(&smc->sk);
 		smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index d5ee961ca72d..572d02bfd3ed 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1582,7 +1582,8 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		return;
 	case SMC_LLC_CONFIRM_LINK:
 	case SMC_LLC_ADD_LINK_CONT:
-		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
+		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE &&
+		    !lgr->llc_flow_lcl.qentry) {
 			/* a flow is waiting for this message */
 			smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
 			wake_up(&lgr->llc_msg_waiter);
diff --git a/net/tipc/core.c b/net/tipc/core.c
index 7724499f516e..4f01691aea3a 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -220,6 +220,11 @@ static void __exit tipc_exit(void)
 	unregister_pernet_device(&tipc_net_ops);
 	tipc_unregister_sysctl();
 
+	/* TODO: Wait for all timers that called call_rcu() to finish before
+	 * calling rcu_barrier().
+	 */
+	rcu_barrier();
+
 	pr_info("Deactivated\n");
 }
 
diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 2730310249e3..28665de32245 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -58,6 +58,7 @@
  * @skb: request message to be (repeatedly) sent
  * @timer: timer governing period between requests
  * @timer_intv: current interval between requests (in ms)
+ * @rcu: RCU head for deferred freeing
  */
 struct tipc_discoverer {
 	u32 bearer_id;
@@ -69,6 +70,7 @@ struct tipc_discoverer {
 	struct sk_buff *skb;
 	struct timer_list timer;
 	unsigned long timer_intv;
+	struct rcu_head rcu;
 };
 
 /**
@@ -381,6 +383,15 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d = container_of(rp, struct tipc_discoverer,
+						 rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link duest structure
@@ -388,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
 	del_timer_sync(&d->timer);
-	kfree_skb(d->skb);
-	kfree(d);
+	call_rcu(&d->rcu, tipc_disc_free_rcu);
 }
 
 /**
diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 35e167de0fcf..bebeca619cb3 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -113,12 +113,16 @@ const struct nla_policy tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] = {
 };
 
 /* Properties valid for media, bearer and link */
+static struct netlink_range_validation tipc_nl_mtu_range = {
+	.max = U16_MAX,
+};
+
 const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 	[TIPC_NLA_PROP_UNSPEC]		= { .type = NLA_UNSPEC },
 	[TIPC_NLA_PROP_PRIO]		= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_TOL]		= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_WIN]		= { .type = NLA_U32 },
-	[TIPC_NLA_PROP_MTU]		= { .type = NLA_U32 },
+	[TIPC_NLA_PROP_MTU]		= NLA_POLICY_FULL_RANGE(NLA_U32, &tipc_nl_mtu_range),
 	[TIPC_NLA_PROP_BROADCAST]	= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_BROADCAST_RATIO]	= { .type = NLA_U32 }
 };
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 6f0c09b6a153..e94c9ca2924f 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -223,6 +223,10 @@ static int __tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
 		int rem;
 
 		len = (*cmd->dumpit)(buf, &cb);
+		if (len < 0) {
+			err = len;
+			goto err_out;
+		}
 
 		nlmsg_for_each_msg(nlmsg, nlmsg_hdr(buf), len, rem) {
 			err = nlmsg_parse_deprecated(nlmsg, GENL_HDRLEN,
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e52b2995817..e294fa3aa4c2 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1036,18 +1036,23 @@ static void __tipc_node_link_down(struct tipc_node *n, int *bearer_id,
 
 static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 {
-	struct tipc_link_entry *le = &n->links[bearer_id];
 	struct tipc_media_addr *maddr = NULL;
-	struct tipc_link *l = le->link;
 	int old_bearer_id = bearer_id;
+	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-
-	if (!l)
-		return;
+	struct tipc_link *l;
 
 	__skb_queue_head_init(&xmitq);
 
+	/* Synchronize the link lookup with bearer teardown. */
 	tipc_node_write_lock(n);
+	le = &n->links[bearer_id];
+	l = le->link;
+	if (!l) {
+		tipc_node_write_unlock_fast(n);
+		return;
+	}
+
 	if (!tipc_link_is_establishing(l)) {
 		__tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
 	} else {
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 321f3317e327..f41e9b51f468 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -490,6 +490,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
@@ -773,7 +774,7 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	__poll_t revents = 0;
 
 	sock_poll_wait(file, sock, wait);
-	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
+	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_NONE, " ");
 
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1732e3549a57..c2344a46dddd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -257,18 +257,21 @@ static int tls_do_decryption(struct sock *sk,
 					  tls_decrypt_done, skb);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
-	if (ret == -EINPROGRESS) {
-		if (async)
-			return ret;
-
-		ret = crypto_wait_req(ret, &ctx->async_wait);
-	}
+	if (ret == -EINPROGRESS)
+		return ret;
 
 	if (async)
 		atomic_dec(&ctx->decrypt_pending);
@@ -427,7 +430,7 @@ int tls_tx_records(struct sock *sk, int flags)
 	}
 
 tx_err:
-	if (rc < 0 && rc != -EAGAIN)
+	if (rc < 0 && rc != -EAGAIN && rc != -EINTR && rc != -ERESTARTSYS)
 		tls_err_abort(sk, rc);
 
 	return rc;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index e131121533ad..b1355c0e3b1f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -501,7 +501,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
-		goto out;
+		goto out_nofill;
 
 	do {
 		virtqueue_disable_cb(vq);
@@ -540,6 +540,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 out:
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
+out_nofill:
 	mutex_unlock(&vsock->rx_lock);
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33e2c29fbd3f..3b2a70b467de 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -280,7 +280,9 @@ nl80211_ftm_responder_policy[NL80211_FTM_RESP_ATTR_MAX + 1] = {
 static const struct nla_policy
 nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_ASAP] = { .type = NLA_FLAG },
-	[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE] =
+		NLA_POLICY_RANGE(NLA_U32, NL80211_PREAMBLE_LEGACY,
+				 NL80211_PREAMBLE_HE),
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP] =
 		NLA_POLICY_MAX(NLA_U8, 15),
 	[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD] = { .type = NLA_U16 },
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 7503c7dd71ab..19a1b256fc0e 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -116,6 +116,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI],
 				    "FTM: LCI request not supported");
+		return -EOPNOTSUPP;
 	}
 
 	out->ftm.request_civicloc =
@@ -124,6 +125,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC],
 			    "FTM: civic location request not supported");
+		return -EOPNOTSUPP;
 	}
 
 	out->ftm.trigger_based =
@@ -168,6 +170,7 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 {
 	struct nlattr *tb[NL80211_PMSR_PEER_ATTR_MAX + 1];
 	struct nlattr *req[NL80211_PMSR_REQ_ATTR_MAX + 1];
+	bool have_measurement_type = false;
 	struct nlattr *treq;
 	int err, rem;
 
@@ -220,6 +223,14 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	}
 
 	nla_for_each_nested(treq, req[NL80211_PMSR_REQ_ATTR_DATA], rem) {
+		if (have_measurement_type) {
+			NL_SET_ERR_MSG_ATTR(info->extack, treq,
+					    "multiple measurement types in request data");
+			return -EINVAL;
+		}
+
+		have_measurement_type = true;
+
 		switch (nla_type(treq)) {
 		case NL80211_PMSR_TYPE_FTM:
 			err = pmsr_parse_ftm(rdev, treq, out, info);
@@ -229,10 +240,16 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 					    "unsupported measurement type");
 			err = -EINVAL;
 		}
+		if (err)
+			return err;
 	}
 
-	if (err)
-		return err;
+	if (!have_measurement_type) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    req[NL80211_PMSR_REQ_ATTR_DATA],
+				    "missing measurement type in request data");
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2b64bf73cbcf..7d0ddc467232 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -240,7 +240,7 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 		return true;
 
 	if (elem->id == WLAN_EID_EXTENSION) {
-		if (!ext_id_len)
+		if (!ext_id_len || !elem->datalen)
 			return true;
 		loop_len = ext_id_len;
 		list = &non_inherit_elem->data[3 + id_len];
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index a7ecf2956cdd..3dbbf52e2f9b 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1779,15 +1779,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 {
 	struct sock *s;
 
+again:
 	write_lock_bh(&x25_list_lock);
 
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
-			x25_disconnect(s, ENETUNREACH, 0, 0);
+			if (x25_sk(s)->neighbour == nb)
+				x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
-			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto again;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 37c4128e313c..26bc08213955 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1292,8 +1292,8 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 			}
 		}
 
-		if (policy->selector.prefixlen_d < dbits ||
-		    policy->selector.prefixlen_s < sbits)
+		if (policy->selector.prefixlen_d >= dbits &&
+		    policy->selector.prefixlen_s >= sbits)
 			continue;
 
 		bin = xfrm_policy_inexact_alloc_bin(policy, dir);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 7122a359a268..615a20b9eb52 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -242,8 +242,13 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 			break;
 		}
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+		/*
+		 * Use addition, not subtraction: sizeof() forces unsigned
+		 * math and a short xattr_len would wrap around, bypassing
+		 * this bounds check.
+		 */
+		if (xattr_len >= (int)sizeof(xattr_value->type) + hash_start +
+				(int)iint->ima_hash->length)
 			/*
 			 * xattr length may be longer. md5 hash in previous
 			 * version occupied 20 bytes in xattr, instead of 16
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 3f609316a096..8b938e61ecd8 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -271,6 +271,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	unsigned long chunk = 0;
 	const u8 *d;
 	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	unsigned int offset;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -284,17 +285,18 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return (unsigned long)index_key->domain_tag;
 	default:
 		level -= 4;
-		if (desc_len <= sizeof(index_key->desc))
+		offset = sizeof(index_key->desc) + level * sizeof(long);
+		if (desc_len <= offset)
 			return 0;
 
-		d = index_key->description + sizeof(index_key->desc);
-		d += level * sizeof(long);
-		desc_len -= sizeof(index_key->desc);
+		d = index_key->description + offset;
+		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
+		d += desc_len;
 		do {
 			chunk <<= 8;
-			chunk |= *d++;
+			chunk |= *--d;
 		} while (--desc_len > 0);
 		return chunk;
 	}
@@ -375,7 +377,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	return -1;
 
 differ_plus_i:
-	level += i;
+	level += i - (int)sizeof(a->desc);
 differ:
 	i = level * 8 + __ffs(seg_a ^ seg_b);
 	return i;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 51e5dd9ee793..5d80aaf9e542 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2335,6 +2335,7 @@ static void relink_to_local(struct snd_pcm_substream *substream)
 
 static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_substream *s;
 	struct snd_pcm_group *group;
 	bool nonatomic = substream->pcm->nonatomic;
 	bool do_free = false;
@@ -2350,6 +2351,12 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	group = substream->group;
 	snd_pcm_group_lock_irq(group, nonatomic);
 
+	/* release drain waiters before changing membership, else snd_pcm_drain()
+	 * leaves its on-stack wait entry queued on a member's sleep list
+	 */
+	snd_pcm_group_for_each_entry(s, substream)
+		wake_up(&s->runtime->sleep);
+
 	relink_to_local(substream);
 	refcount_dec(&group->refs);
 
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index b92ea074ff2a..459016d6134c 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -412,11 +412,8 @@ static void lx_trigger_start(struct lx6464es *chip, struct lx_stream *lx_stream)
 
 	int err;
 
-	const u32 channels = substream->runtime->channels;
-	const u32 bytes_per_frame = channels * 3;
-	const u32 period_size = substream->runtime->period_size;
 	const u32 periods = substream->runtime->periods;
-	const u32 period_bytes = period_size * bytes_per_frame;
+	const u32 period_bytes = snd_pcm_lib_period_bytes(substream);
 
 	dma_addr_t buf = substream->dma_buffer.addr;
 	int i;
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 7b387886c0ef..1a7d26c5ea71 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -1019,10 +1019,7 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 	const unsigned int is_capture = lx_stream->is_capture;
 	int err;
 
-	const u32 channels = substream->runtime->channels;
-	const u32 bytes_per_frame = channels * 3;
-	const u32 period_size = substream->runtime->period_size;
-	const u32 period_bytes = period_size * bytes_per_frame;
+	const u32 period_bytes = snd_pcm_lib_period_bytes(substream);
 	const u32 pos = lx_stream->frame_pos;
 	const u32 next_pos = ((pos+1) == substream->runtime->periods) ?
 		0 : pos + 1;
diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index 4d286844e3c8..7c42fcdee27b 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -13,11 +13,21 @@
 static const struct snd_soc_dapm_widget bt_sco_widgets[] = {
 	SND_SOC_DAPM_INPUT("RX"),
 	SND_SOC_DAPM_OUTPUT("TX"),
+	SND_SOC_DAPM_AIF_IN("BT_SCO_RX", "Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("BT_SCO_TX", "Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("BT_SCO_RX_WB", "WB Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("BT_SCO_TX_WB", "WB Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route bt_sco_routes[] = {
-	{ "Capture", NULL, "RX" },
-	{ "TX", NULL, "Playback" },
+	{ "BT_SCO_TX", NULL, "RX" },
+	{ "TX", NULL, "BT_SCO_RX" },
+	{ "BT_SCO_TX_WB", NULL, "RX" },
+	{ "TX", NULL, "BT_SCO_RX_WB" },
 };
 
 static struct snd_soc_dai_driver bt_sco_dai[] = {
@@ -41,14 +51,14 @@ static struct snd_soc_dai_driver bt_sco_dai[] = {
 	{
 		.name = "bt-sco-pcm-wb",
 		.playback = {
-			.stream_name = "Playback",
+			.stream_name = "WB Playback",
 			.channels_min = 1,
 			.channels_max = 1,
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
 		.capture = {
-			 .stream_name = "Capture",
+			 .stream_name = "WB Capture",
 			.channels_min = 1,
 			.channels_max = 1,
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c7df685be4ea..531cd172cb5c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2393,8 +2393,9 @@ static int max98090_probe(struct snd_soc_component *component)
 	dev_dbg(component->dev, "max98090_probe\n");
 
 	max98090->mclk = devm_clk_get(component->dev, "mclk");
-	if (PTR_ERR(max98090->mclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (IS_ERR(max98090->mclk))
+		if (PTR_ERR(max98090->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
 	max98090->component = component;
 
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 9bdc6392382a..c0daa18e7d8f 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1990,8 +1990,9 @@ static int max98095_probe(struct snd_soc_component *component)
 	int ret = 0;
 
 	max98095->mclk = devm_clk_get(component->dev, "mclk");
-	if (PTR_ERR(max98095->mclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (IS_ERR(max98095->mclk))
+		if (PTR_ERR(max98095->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
 	/* reset the codec, the DSP core, and disable all interrupts */
 	max98095_reset(component);
diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index f1ff204e3ad0..4f02af2efcb4 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -33,15 +33,16 @@
 static const unsigned int float_vol_db_lookup[] = {
 0x00000d43, 0x000010b2, 0x00001505, 0x00001a67, 0x00002151,
 0x000029f1, 0x000034cd, 0x00004279, 0x000053af, 0x0000695b,
-0x0000695b, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
+0x000084a3, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
 0x0001a36e, 0x00021008, 0x000298c0, 0x000344df, 0x00041d8f,
 0x00052e5a, 0x000685c8, 0x00083621, 0x000a566d, 0x000d03a7,
 0x0010624d, 0x0014a050, 0x0019f786, 0x0020b0bc, 0x0029279d,
 0x0033cf8d, 0x004139d3, 0x00521d50, 0x00676044, 0x0082248a,
 0x00a3d70a, 0x00ce4328, 0x0103ab3d, 0x0146e75d, 0x019b8c27,
 0x02061b89, 0x028c423f, 0x03352529, 0x0409c2b0, 0x05156d68,
-0x080e9f96, 0x0a24b062, 0x0cc509ab, 0x10137987, 0x143d1362,
-0x197a967f, 0x2013739e, 0x28619ae9, 0x32d64617, 0x40000000
+0x06666666, 0x080e9f96, 0x0a24b062, 0x0cc509ab, 0x10137987,
+0x143d1362, 0x197a967f, 0x2013739e, 0x28619ae9, 0x32d64617,
+0x40000000
 };
 
 struct tas2562_data {
@@ -508,20 +509,27 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 	u32 reg_val;
 
 	reg_val = float_vol_db_lookup[ucontrol->value.integer.value[0]/2];
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
-				      (reg_val & 0xff));
-	if (ret)
-		return ret;
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3,
-				      ((reg_val >> 8) & 0xff));
+	/*
+	 * The device applies the 32-bit coefficient to the playback path on
+	 * the write to DVC_CFG4 (the LSB, book 0 page 2 reg 0x0F), so the
+	 * bytes must be written MSB first and DVC_CFG4 last. Writing CFG4
+	 * first latches a mix of the previous coefficient's upper bytes and
+	 * the new LSB instead of the requested value.
+	 */
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1,
+				      ((reg_val >> 24) & 0xff));
 	if (ret)
 		return ret;
 	ret = snd_soc_component_write(component, TAS2562_DVC_CFG2,
 				      ((reg_val >> 16) & 0xff));
 	if (ret)
 		return ret;
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1,
-				      ((reg_val >> 24) & 0xff));
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3,
+				      ((reg_val >> 8) & 0xff));
+	if (ret)
+		return ret;
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
+				      (reg_val & 0xff));
 	if (ret)
 		return ret;
 
@@ -720,11 +728,12 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	if (tas2562->sdz_gpio == NULL) {
 		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
 							      GPIOD_OUT_HIGH);
-		if (IS_ERR(tas2562->sdz_gpio))
+		if (IS_ERR(tas2562->sdz_gpio)) {
 			if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
 
-		tas2562->sdz_gpio = NULL;
+			tas2562->sdz_gpio = NULL;
+		}
 	}
 
 	if (tas2562->model_id == TAS2110)
diff --git a/sound/soc/meson/aiu-fifo-spdif.c b/sound/soc/meson/aiu-fifo-spdif.c
index 44eb6faacf44..124d2d9ce716 100644
--- a/sound/soc/meson/aiu-fifo-spdif.c
+++ b/sound/soc/meson/aiu-fifo-spdif.c
@@ -24,6 +24,7 @@
 #define AIU_MEM_IEC958_CONTROL_MODE_16BIT	BIT(7)
 #define AIU_MEM_IEC958_CONTROL_MODE_LINEAR	BIT(8)
 #define AIU_MEM_IEC958_BUF_CNTL_INIT		BIT(0)
+#define AIU_RST_SOFT_958_FAST			BIT(2)
 
 #define AIU_FIFO_SPDIF_BLOCK			8
 
@@ -68,11 +69,15 @@ static int fifo_spdif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		snd_soc_component_write(component, AIU_RST_SOFT,
+					AIU_RST_SOFT_958_FAST);
 		fifo_spdif_dcu_enable(component, true);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_STOP:
+		snd_soc_component_write(component, AIU_RST_SOFT,
+					AIU_RST_SOFT_958_FAST);
 		fifo_spdif_dcu_enable(component, false);
 		break;
 	default:
diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 31b8989a021b..5a0d522961b4 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -159,6 +159,10 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 	return 0;
 
 destroy_chip:
+	chip->shutdown = true;
+	if (card)
+		snd_card_disconnect(card);
+	usb6fire_chip_abort(chip);
 	snd_card_free(card);
 	return ret;
 }
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8e2b90cb5b95..e9bbc355cfb4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -301,13 +301,15 @@ static inline void prepare_inbound_urb(struct snd_usb_endpoint *ep,
 	case SND_USB_ENDPOINT_TYPE_DATA:
 		offs = 0;
 		for (i = 0; i < urb_ctx->packets; i++) {
+			if (offs + ep->curpacksize > urb_ctx->buffer_size)
+				break;
 			urb->iso_frame_desc[i].offset = offs;
 			urb->iso_frame_desc[i].length = ep->curpacksize;
 			offs += ep->curpacksize;
 		}
 
 		urb->transfer_buffer_length = offs;
-		urb->number_of_packets = urb_ctx->packets;
+		urb->number_of_packets = i;
 		break;
 
 	case SND_USB_ENDPOINT_TYPE_SYNC:
@@ -871,10 +873,12 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 				<< (16 - ep->datainterval);
 	}
 
-	if (ep->fill_max)
+	if (ep->fill_max) {
 		ep->curpacksize = ep->maxpacksize;
-	else
+		maxsize = ep->curpacksize;
+	} else {
 		ep->curpacksize = maxsize;
+	}
 
 	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL) {
 		packs_per_ms = 8 >> ep->datainterval;
@@ -959,10 +963,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 		u->index = i;
 		u->ep = ep;
 		u->packets = urb_packs;
-		u->buffer_size = maxsize * u->packets;
 
 		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
 			u->packets++; /* for transfer delimiter */
+		u->buffer_size = maxsize * u->packets;
 		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
 		if (!u->urb)
 			goto out_of_memory;
@@ -1099,9 +1103,6 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 		return -EINVAL;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
@@ -1350,11 +1351,13 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 
 		out_packet->packets = in_ctx->packets;
 		for (i = 0; i < in_ctx->packets; i++) {
-			if (urb->iso_frame_desc[i].status == 0)
-				out_packet->packet_size[i] =
+			if (urb->iso_frame_desc[i].status == 0) {
+				unsigned int frames =
 					urb->iso_frame_desc[i].actual_length / sender->stride;
-			else
+				out_packet->packet_size[i] = min(frames, ep->maxframesize);
+			} else {
 				out_packet->packet_size[i] = 0;
+			}
 		}
 
 		ep->next_packet_write_pos++;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 26b3ae2ad24b..6b491bfe852b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -816,6 +816,8 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
 
 	msg = urb->transfer_buffer + urb->transfer_buffer_length;
 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
+	if (buf_end <= 0)
+		return;
 
 	/* only try adding more data when there's space for at least 1 SysEx */
 	while (urb->transfer_buffer_length < buf_end) {
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f4494d054917..802ed1dbd23b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -953,6 +953,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->data_endpoint->curframesize =
 		bytes_to_frames(runtime, subs->data_endpoint->curpacksize);
 
+	subs->data_endpoint->packsize[0] = min(
+		subs->data_endpoint->packsize[0],
+		subs->data_endpoint->maxframesize);
+	subs->data_endpoint->packsize[1] = min(
+		subs->data_endpoint->packsize[1],
+		subs->data_endpoint->maxframesize);
+
 	/* reset the pointer */
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 0229e9ebb995..a0cc8940e8f8 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 {
 	FILE *f;
 	char buf;
-	char *line;
+	char *line = NULL;
 	int status;
 	int ret = -1;
 	size_t len = 0;

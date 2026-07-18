Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A133D79F1;
	Sat, 18 Jul 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386927; cv=none; b=UZkmN1y/vgCQEVU+ldzko0okS/HdgS4kOuZ1Pw9Snz0lIbxUhQXdlkpHDlpyzQ7TEOMjWgD04KOXbn0bdxp4TCs2oTt+xgg4vckfXAViFhw9Iq/tImNi9JBEb8UgoPmMJhkApEg3N084YwRLUbL0WZZKrOU5QNInIUpGUwcbwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386927; c=relaxed/simple;
	bh=uH6eMe+/SF2y5r08T64SOxChR/sjil63hWoIQfnJ6Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0qKMA4sjY65/+mV6E+KhYD4uNFtUbTz0rTZNricZHrJbmk37ftRaGWYQIHZUaHtM5usd61ZyR3XqJVaE0qw998U956tC8hojJ6O/EJELAre1+x1RtAXaFjiZi8RrqNi7OdCFNThfTnWQHaOIaLu8/iJiMOAzBeTzEPEnVXlRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpwp3T84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpwp3T84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE7C1F00A3D;
	Sat, 18 Jul 2026 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784386894;
	bh=c5rqGKcT3jdDFrs0GDcpe7uFd2UiQYyWO6f0tkahqZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vpwp3T84Jopy1sTRkaakfpGrccI+aPhJcGnG/AnHnp7NdavEjKZ+6WBHKBScRRYG9
	 LJaGZO37Qp67y3mstB0FaUQebw8Q2SwD1CNtmRISUjipP987DJAzLQF+efnTCtVJ5z
	 siFg75hjUNgZONoMuicNUlSeVnLFr5u/AqiqfvCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.1.4
Date: Sat, 18 Jul 2026 17:01:17 +0200
Message-ID: <2026071816-calamari-juror-747f@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026071816-cussed-fantasy-7a62@gregkh>
References: <2026071816-cussed-fantasy-7a62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
index 021759198fe7..d220e266b8de 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -327,33 +327,10 @@ CRYPTO_USER_API_RNG_CAVP option:
 Zero-Copy Interface
 -------------------
 
-In addition to the send/write/read/recv system call family, the AF_ALG
-interface can be accessed with the zero-copy interface of
-splice/vmsplice. As the name indicates, the kernel tries to avoid a copy
-operation into kernel space.
-
-The zero-copy operation requires data to be aligned at the page
-boundary. Non-aligned data can be used as well, but may require more
-operations of the kernel which would defeat the speed gains obtained
-from the zero-copy interface.
-
-The system-inherent limit for the size of one zero-copy operation is 16
-pages. If more data is to be sent to AF_ALG, user space must slice the
-input into segments with a maximum size of 16 pages.
-
-Zero-copy can be used with the following code example (a complete
-working example is provided with libkcapi):
-
-::
-
-    int pipes[2];
-
-    pipe(pipes);
-    /* input data in iov */
-    vmsplice(pipes[1], iov, iovlen, SPLICE_F_GIFT);
-    /* opfd is the file descriptor returned from accept() system call */
-    splice(pipes[0], NULL, opfd, NULL, ret, 0);
-    read(opfd, out, outlen);
+AF_ALG used to have zero-copy support, but it was removed due to it being a
+frequent source of vulnerabilities.  For backwards compatibility the splice()
+and sendfile() system calls are still supported, but the kernel will make an
+internal copy of the data before passing it to the crypto code.
 
 
 Setsockopt Interface
diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index f75f08763941..4b30cd63c5a5 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2383,6 +2383,12 @@ quirk_flags
           ``V(x) = k * x``; ``dB(x) = 20 * log10(x)``. Overrides bit 24
         * bit 28: ``mixer_capture_linear_vol``
           Similar to bit 27 but for capture streams. Overrides bit 25
+        * bit 29: ``ifb_silence_on_empty``
+          In implicit feedback mode, when an entire capture URB returns with
+          all iso_frame_desc[i].status != 0 (bytes==0), do not silently return
+          from snd_usb_handle_sync_urb. Instead fall through and enqueue a
+          packet_info containing only size-0 packets, so the OUT ring keeps
+          moving (emits silence). Needed by Behringer Flow 8 (1397:050c).
 
 This module supports multiple devices, autoprobe and hotplugging.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f26c..f74da642290a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15087,7 +15087,6 @@ M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/char/tpm/tpm_loongson.c
-F:	drivers/crypto/loongson/
 F:	drivers/mfd/loongson-se.c
 F:	include/linux/mfd/loongson-se.h
 
diff --git a/Makefile b/Makefile
index 9e405218162b..b3496dd21312 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 3
+SUBLEVEL = 4
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -959,6 +959,9 @@ KBUILD_CFLAGS += $(stackp-flags-y)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 KBUILD_RUSTFLAGS += -Cforce-frame-pointers=y
+# Work around rustc bug on compilers without
+# https://github.com/rust-lang/rust/pull/156980.
+KBUILD_RUSTFLAGS += $(if $(call rustc-min-version,109800),,-Zllvm_module_flag=frame-pointer:u32:2:max)
 else
 # Some targets (ARM with Thumb2, for example), can't be built with frame
 # pointers.  For those, we don't have FUNCTION_TRACER automatically
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 8d06b62e7188..e9b2b0c40ec6 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -157,5 +157,6 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 extern unsigned long kvm_nvhe_sym(hyp_nr_cpus);
+extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6325db1a2179..fb441702495f 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -103,13 +103,13 @@ SYM_FUNC_END(sme_set_vq)
  * Save the ZA and ZT state
  *
  * x0 - pointer to buffer for state
- * x1 - number of ZT registers to save
+ * w1 - number of ZT registers to save
  */
 SYM_FUNC_START(sme_save_state)
 	_sme_rdsvl	2, 1		// x2 = VL/8
 	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
 
-	cbz	x1, 1f
+	cbz	w1, 1f
 	_str_zt 0
 1:
 	ret
@@ -119,13 +119,13 @@ SYM_FUNC_END(sme_save_state)
  * Load the ZA and ZT state
  *
  * x0 - pointer to buffer for state
- * x1 - number of ZT registers to save
+ * w1 - number of ZT registers to save
  */
 SYM_FUNC_START(sme_load_state)
 	_sme_rdsvl	2, 1		// x2 = VL/8
 	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
 
-	cbz	x1, 1f
+	cbz	w1, 1f
 	_ldr_zt 0
 1:
 	ret
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9453321ef8c6..9ffd5d4079e6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2426,6 +2426,8 @@ static int __init init_subsystems(void)
 	switch (err) {
 	case 0:
 		vgic_present = true;
+		if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+			kvm_nvhe_sym(hyp_gicv3_nr_lr) = kvm_vgic_global_state.nr_lr;
 		break;
 	case -ENODEV:
 	case -ENXIO:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 06db299c37a8..a0da08caa6c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -24,6 +24,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+/* Number of implemented GICv3 LRs. Used by flush_hyp_vcpu(). */
+unsigned int hyp_gicv3_nr_lr;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
@@ -128,6 +131,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	/* __hyp_running_vcpu must be NULL in a guest context. */
+	hyp_vcpu->vcpu.arch.ctxt.__hyp_running_vcpu = NULL;
+
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
 	hyp_vcpu->vcpu.arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2) &
@@ -139,6 +145,12 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3 = host_vcpu->arch.vgic_cpu.vgic_v3;
 
+	/* Bound used_lrs by the number of implemented list registers. */
+	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs =
+		min_t(unsigned int,
+		      hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs,
+		      hyp_gicv3_nr_lr);
+
 	hyp_vcpu->vcpu.arch.pid = host_vcpu->arch.pid;
 }
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 6f7bc9a9992e..682e1c8437fb 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -904,9 +904,21 @@ static void invalidate_vncr(struct vncr_tlb *vt)
 		clear_fixmap(vncr_fixmap(vt->cpu));
 }
 
+/*
+ * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions, and
+ * either can race against a vcpu not being onlined yet (no pseudo-TLB
+ * allocated). Similarly, the TLB might be invalid.  Skip those, as they
+ * obviously don't participate in the invalidation at this stage.
+ */
+#define kvm_for_each_vncr_tlb(idx, vcpup, tlbp, kvm)	\
+	kvm_for_each_vcpu(idx, vcpup, kvm)		\
+		if (((tlbp) = vcpup->arch.vncr_tlb) &&	\
+		    (tlbp)->valid)
+
 static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
 {
 	struct kvm_vcpu *vcpu;
+	struct vncr_tlb *vt;
 	unsigned long i;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -914,24 +926,9 @@ static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
 	if (!kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
 		return;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
+	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
 		u64 ipa_start, ipa_end, ipa_size;
 
-		/*
-		 * Careful here: We end-up here from an MMU notifier,
-		 * and this can race against a vcpu not being onlined
-		 * yet, without the pseudo-TLB being allocated.
-		 *
-		 * Skip those, as they obviously don't participate in
-		 * the invalidation at this stage.
-		 */
-		if (!vt)
-			continue;
-
-		if (!vt->valid)
-			continue;
-
 		ipa_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
 							    vt->wr.level));
 		ipa_start = vt->wr.pa & ~(ipa_size - 1);
@@ -961,17 +958,14 @@ static void invalidate_vncr_va(struct kvm *kvm,
 			       struct s1e2_tlbi_scope *scope)
 {
 	struct kvm_vcpu *vcpu;
+	struct vncr_tlb *vt;
 	unsigned long i;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
+	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
 		u64 va_start, va_end, va_size;
 
-		if (!vt->valid)
-			continue;
-
 		va_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
 							   vt->wr.level));
 		va_start = vt->gva & ~(va_size - 1);
@@ -1333,8 +1327,10 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
-		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq))
+		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
+			kvm_release_faultin_page(vcpu->kvm, page, true, false);
 			return -EAGAIN;
+		}
 
 		vt->gva = va;
 		vt->hpa = pfn << PAGE_SHIFT;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0816c40fc7af..9491c987e50c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2094,7 +2094,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	image_size = extable_offset + extable_size;
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
 					      sizeof(u64), &header, &image_ptr,
-					      jit_fill_hole);
+					      jit_fill_hole, was_classic);
 	if (!ro_header)
 		goto out_off;
 
@@ -2782,7 +2782,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, jit_fill_hole);
+	return bpf_prog_pack_alloc(size, jit_fill_hole, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index d5ef396dffe3..82897236863f 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -1091,7 +1091,6 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
-CONFIG_CRYPTO_DEV_LOONGSON_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index cba4cdff5acd..a94e88bd7ec5 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -1124,7 +1124,6 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
-CONFIG_CRYPTO_DEV_LOONGSON_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_DMA_NUMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index eda9d4d0a493..c05168aedcaa 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -38,6 +38,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 extern struct list_head acpi_wakeup_device_list;
 extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
+extern void acpi_add_early_pio(void);
+extern void acpi_remove_early_pio(void);
 extern int __init parse_acpi_topology(void);
 
 #endif /* !CONFIG_ACPI */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 058f0dbe8e8f..8f650c9ffecd 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/serial_core.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/loongson.h>
@@ -59,6 +60,33 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		return ioremap_cache(phys, size);
 }
 
+#define PIO_BASE (unsigned long)PCI_IOBASE
+#define PIO_SIZE ALIGN(ISA_IOSIZE, PAGE_SIZE)
+
+static bool acpi_pio;
+
+/* Add PIO for early access */
+void acpi_add_early_pio(void)
+{
+	if (!acpi_disabled) {
+		acpi_pio = true;
+		vmap_page_range(PIO_BASE, PIO_BASE + PIO_SIZE,
+				LOONGSON_LIO_BASE, pgprot_device(PAGE_KERNEL));
+	}
+}
+
+/* Remove PIO for PCI register */
+void acpi_remove_early_pio(void)
+{
+	if (!acpi_pio)
+		return;
+
+	if (!acpi_disabled) {
+		acpi_pio = false;
+		vunmap_range(PIO_BASE, PIO_BASE + PIO_SIZE);
+	}
+}
+
 #ifdef CONFIG_SMP
 static int set_processor_mask(u32 id, u32 pass)
 {
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 839b23edee87..bfc6f274e6e2 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -502,6 +502,8 @@ static __init int arch_reserve_pio_range(void)
 {
 	struct device_node *np;
 
+	acpi_add_early_pio();
+
 	for_each_node_by_name(np, "isa") {
 		struct of_range range;
 		struct of_range_parser parser;
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 2ab7fafa86d5..2b14485d14a7 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -645,10 +645,14 @@ static int kvm_eiointc_create(struct kvm_device *dev, u32 type)
 
 	device = &s->device_vext;
 	kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
+	mutex_lock(&kvm->slots_lock);
 	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
 			EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
+	mutex_unlock(&kvm->slots_lock);
 	if (ret < 0) {
+		mutex_lock(&kvm->slots_lock);
 		kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device);
+		mutex_unlock(&kvm->slots_lock);
 		kfree(s);
 		return ret;
 	}
@@ -667,8 +671,10 @@ static void kvm_eiointc_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	eiointc = kvm->arch.eiointc;
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(eiointc);
 	kfree(dev);
 }
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 1f6ebbd0af5c..4fa0897d7bdb 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -447,7 +447,9 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
 
 	kvm = dev->kvm;
 	ipi = kvm->arch.ipi;
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(ipi);
 	kfree(dev);
 }
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index aa0ed59ae8cf..175a630aceb4 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -481,7 +481,9 @@ static void kvm_pch_pic_destroy(struct kvm_device *dev)
 	kvm = dev->kvm;
 	s = kvm->arch.pch_pic;
 	/* unregister pch pic device and free it's memory */
+	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
+	mutex_unlock(&kvm->slots_lock);
 	kfree(s);
 	kfree(dev);
 }
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..e14a8aa47fc8 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1762,7 +1762,7 @@ static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, jit_fill_hole);
+	return bpf_prog_pack_alloc(size, jit_fill_hole, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
@@ -2228,7 +2228,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	image_size = prog_size + extable_size;
 	/* Now we know the size of the structure to make */
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr, sizeof(u32),
-					      &header, &image_ptr, jit_fill_hole);
+					      &header, &image_ptr, jit_fill_hole,
+					      bpf_prog_was_classic(prog));
 	if (!ro_header)
 		goto out_offset;
 
diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index b02698a338ee..ccbcea61fcd9 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -65,6 +65,8 @@ static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 	struct resource_entry *entry, *tmp;
 	struct acpi_device *device = ci->bridge;
 
+	acpi_remove_early_pio();
+
 	status = acpi_pci_probe_root_resources(ci);
 	if (status > 0) {
 		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 53ab97ad6074..73ff8a64bb7f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -295,7 +295,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
 
 	fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
-					      bpf_jit_fill_ill_insns);
+					 bpf_jit_fill_ill_insns, bpf_prog_was_classic(fp));
 	if (!fhdr)
 		goto out_err;
 
@@ -583,7 +583,7 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
+	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 9fddf3f0b3b9..3af770549742 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
@@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
 			vendor-id = <0x1f1c>;
 			device-id = <0x2042>;
 			cdns,no-bar-match-nbits = <48>;
+			dma-coherent;
 			msi-parent = <&msi>;
 			status = "disabled";
 		};
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a1a7c6520a09..5d5756bda82e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -93,6 +93,16 @@
  */
 #define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
 
+/* Needed to limit get_free_mem_region() */
+#if defined(CONFIG_FLATMEM)
+#define DIRECT_MAP_PHYSMEM_END (phys_ram_base + KERN_VIRT_SIZE - 1)
+#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define DIRECT_MAP_PHYSMEM_END \
+	((vmemmap_start_pfn + VMEMMAP_SIZE / sizeof(struct page)) * PAGE_SIZE - 1)
+#elif defined(CONFIG_SPARSEMEM)
+/* DIRECT_MAP_PHYSMEM_END is not limited by VA space assignment in this case */
+#endif
+
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
 #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 6c14ed7a5613..e189c477c0e2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -75,8 +75,11 @@
 	/* Atomically reset the current cpu bit in new_vmalloc */
 	amoxor.d	a0, a1, (a0)
 
-	/* Only emit a sfence.vma if the uarch caches invalid entries */
-	ALTERNATIVE("sfence.vma", "nop", 0, RISCV_ISA_EXT_SVVPTC, 1)
+	/*
+	 * A sfence.vma is required here. Even if we had Svvptc, there's no
+	 * guarantee that after returning we wouldn't just fault again.
+	 */
+	sfence.vma
 
 	REG_L	a0, TASK_TI_A0(tp)
 	REG_L	a1, TASK_TI_A1(tp)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 2f1109dbf105..404a98a0fc90 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1321,7 +1321,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	return bpf_prog_pack_alloc(size, bpf_fill_ill_insns, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 4365d07aaf54..ce3bd3762e08 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -109,7 +109,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				bpf_jit_binary_pack_alloc(prog_size + extable_size,
 							  &jit_data->ro_image, sizeof(u32),
 							  &jit_data->header, &jit_data->image,
-							  bpf_fill_ill_insns);
+							  bpf_fill_ill_insns,
+							  bpf_prog_was_classic(prog));
 			if (!jit_data->ro_header)
 				goto out_offset;
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9921a3772bf7..c7a65e129dbc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -163,7 +163,6 @@ config S390
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
-	select DCACHE_WORD_ACCESS if !KMSAN
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
 	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index d23ea0c94e4e..99748c20e767 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -12,7 +12,6 @@
 #define EX_TYPE_UA_FAULT	3
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
-#define EX_TYPE_ZEROPAD		7
 #define EX_TYPE_FPC		8
 #define EX_TYPE_UA_MVCOS_TO	9
 #define EX_TYPE_UA_MVCOS_FROM	10
@@ -80,9 +79,6 @@
 #define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
 
-#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
-	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
-
 #define EX_TABLE_FPC(_fault, _target)					\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
 
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee7699..e9287036392d 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitops.h>
 #include <linux/wordpart.h>
-#include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
 struct word_at_a_time {
@@ -41,25 +40,4 @@ static inline unsigned long zero_bytemask(unsigned long data)
 	return ~1UL << data;
 }
 
-/*
- * Load an unaligned word from kernel space.
- *
- * In the (very unlikely) case of the word being a page-crosser
- * and the next page not being mapped, take the exception and
- * return zeroes in the non-existing part.
- */
-static inline unsigned long load_unaligned_zeropad(const void *addr)
-{
-	unsigned long data;
-
-	asm_inline volatile(
-		"0:	lg	%[data],0(%[addr])\n"
-		"1:	nopr	%%r7\n"
-		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
-		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
-		: [data] "=d" (data)
-		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
-	return data;
-}
-
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 7498e858c401..063b4346742d 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -50,22 +50,6 @@ static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
 	return true;
 }
 
-static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt_regs *regs)
-{
-	unsigned int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
-	unsigned int reg_data = FIELD_GET(EX_DATA_REG_ERR, ex->data);
-	unsigned long data, addr, offset;
-
-	addr = regs->gprs[reg_addr];
-	offset = addr & (sizeof(unsigned long) - 1);
-	addr &= ~(sizeof(unsigned long) - 1);
-	data = *(unsigned long *)addr;
-	data <<= BITS_PER_BYTE * offset;
-	regs->gprs[reg_data] = data;
-	regs->psw.addr = extable_fixup(ex);
-	return true;
-}
-
 static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
 {
 	fpu_sfpc(0);
@@ -134,8 +118,6 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, false, regs);
 	case EX_TYPE_UA_LOAD_REGPAIR:
 		return ex_handler_ua_load_reg(ex, true, regs);
-	case EX_TYPE_ZEROPAD:
-		return ex_handler_zeropad(ex, regs);
 	case EX_TYPE_FPC:
 		return ex_handler_fpc(ex, regs);
 	case EX_TYPE_UA_MVCOS_TO:
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3dbc6bacbd9d..edddd4f9ab5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4f4b5e8a1574..b68892e6d58c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -388,6 +388,10 @@ extern void srso_alias_return_thunk(void);
 extern void entry_untrain_ret(void);
 extern void write_ibpb(void);
 
+#ifdef CONFIG_BPF_JIT
+extern void bpf_arch_ibpb(void);
+#endif
+
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..d9af230c0512 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/kvm_types.h>
 
 #include <asm/spec-ctrl.h>
@@ -1651,8 +1652,21 @@ static inline const char *spectre_v2_module_string(void)
 {
 	return spectre_v2_bad_module ? " - vulnerable module loaded" : "";
 }
+
+/*
+ * The "retpoline sequence" is the "call;mov;ret" sequence that
+ * replaces normal indirect branch instructions. Differentiate
+ * *the* retpoline sequence from the LFENCE-prefixed indirect
+ * branches that simply use the retpoline infrastructure.
+ */
+static inline bool retpoline_seq_enabled(void)
+{
+	return boot_cpu_has(X86_FEATURE_RETPOLINE) && !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE);
+}
+
 #else
 static inline const char *spectre_v2_module_string(void) { return ""; }
+static inline bool retpoline_seq_enabled(void) { return false; }
 #endif
 
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
@@ -2095,8 +2109,7 @@ static void __init bhi_apply_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2238,6 +2251,27 @@ static void __init spectre_v2_update_mitigation(void)
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 
+#ifdef CONFIG_BPF_JIT
+static void __bpf_arch_ibpb(void *unused)
+{
+	write_ibpb();
+}
+
+void bpf_arch_ibpb(void)
+{
+	on_each_cpu(__bpf_arch_ibpb, NULL, 1);
+}
+
+static bool __init cpu_wants_ibpb_bpf(void)
+{
+	/* A genuine retpoline already neutralizes ring0 indirect predictions */
+	if (retpoline_seq_enabled())
+		return false;
+
+	return boot_cpu_has(X86_FEATURE_IBPB);
+}
+#endif
+
 static void __init spectre_v2_apply_mitigation(void)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
@@ -2314,6 +2348,14 @@ static void __init spectre_v2_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
+
+#ifdef CONFIG_BPF_JIT
+	if (cpu_wants_ibpb_bpf()) {
+		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
+		static_branch_enable(&bpf_pred_flush_enabled);
+		pr_info("Enabling IBPB for BPF\n");
+	}
+#endif
 }
 
 static void update_stibp_msr(void * __unused)
@@ -3490,9 +3532,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
-		 rrsba_disabled)
+	else if (retpoline_seq_enabled() && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 59215fef3924..50ee1f640c68 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -258,6 +258,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
 
+	if (cpumask_empty(&hdr->cpu_mask)) {
+		pr_warn_once("Domain %d has no CPUs\n", hdr->id);
+		return -EINVAL;
+	}
+
 	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	hw_dom = resctrl_to_arch_mon_dom(d);
 	cpu = cpumask_any(&hdr->cpu_mask);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..92a1e69c5962 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -980,6 +980,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) != -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		kvm_lapic_update_cr8_intercept(apic->vcpu);
 }
 
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
@@ -1730,7 +1732,7 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
 #define APIC_REGS_MASK(first, count) \
 	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
+static u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 {
 	/* Leave bits '0' for reserved and write-only registers. */
 	u64 valid_reg_mask =
@@ -1766,7 +1768,24 @@ u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 
 	return valid_reg_mask;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_readable_reg_mask);
+
+u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu)
+{
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)))
+		return 0;
+
+	/*
+	 * TMMCT, a.k.a. the current APIC timer count, reads aren't accelerated
+	 * by hardware (Intel or AMD) as the timer is emulated in software (by
+	 * KVM), i.e. reads from the virtual APIC page would return garbage.
+	 * Intercept RDMSR, as handling the fault-like APIC-access VM-Exit is
+	 * more expensive than handling a RDMSR VM-Exit (the APIC-access exit
+	 * requires slow emulation of the code stream).
+	 */
+	return kvm_lapic_readable_reg_mask(vcpu->arch.apic) &
+	       ~APIC_REG_MASK(APIC_TMCCT);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x2apic_disable_read_intercept_reg_mask);
 
 static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 			      void *data)
@@ -2744,6 +2763,32 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
 	return (tpr & 0xf0) >> 4;
 }
 
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu)
+{
+	int max_irr, tpr;
+
+	if (!kvm_x86_ops.update_cr8_intercept)
+		return;
+
+	if (!lapic_in_kernel(vcpu))
+		return;
+
+	if (vcpu->arch.apic->apicv_active)
+		return;
+
+	if (!vcpu->arch.apic->vapic_addr)
+		max_irr = kvm_lapic_find_highest_irr(vcpu);
+	else
+		max_irr = -1;
+
+	if (max_irr != -1)
+		max_irr >>= 4;
+
+	tpr = kvm_lapic_get_cr8(vcpu);
+
+	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
+}
+
 static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 {
 	u64 old_value = vcpu->arch.apic_base;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 274885af4ebc..71970213dc1f 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -100,6 +100,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8);
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
 void kvm_apic_after_set_mcg_cap(struct kvm_vcpu *vcpu);
@@ -156,7 +157,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
+u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
 {
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cdd5a6dc646f..0726f88e679a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -122,38 +122,8 @@ static u32 x2avic_max_physical_id;
 static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 					     bool intercept)
 {
-	static const u32 x2avic_passthrough_msrs[] = {
-		X2APIC_MSR(APIC_ID),
-		X2APIC_MSR(APIC_LVR),
-		X2APIC_MSR(APIC_TASKPRI),
-		X2APIC_MSR(APIC_ARBPRI),
-		X2APIC_MSR(APIC_PROCPRI),
-		X2APIC_MSR(APIC_EOI),
-		X2APIC_MSR(APIC_RRR),
-		X2APIC_MSR(APIC_LDR),
-		X2APIC_MSR(APIC_DFR),
-		X2APIC_MSR(APIC_SPIV),
-		X2APIC_MSR(APIC_ISR),
-		X2APIC_MSR(APIC_TMR),
-		X2APIC_MSR(APIC_IRR),
-		X2APIC_MSR(APIC_ESR),
-		X2APIC_MSR(APIC_ICR),
-		X2APIC_MSR(APIC_ICR2),
-
-		/*
-		 * Note!  Always intercept LVTT, as TSC-deadline timer mode
-		 * isn't virtualized by hardware, and the CPU will generate a
-		 * #GP instead of a #VMEXIT.
-		 */
-		X2APIC_MSR(APIC_LVTTHMR),
-		X2APIC_MSR(APIC_LVTPC),
-		X2APIC_MSR(APIC_LVT0),
-		X2APIC_MSR(APIC_LVT1),
-		X2APIC_MSR(APIC_LVTERR),
-		X2APIC_MSR(APIC_TMICT),
-		X2APIC_MSR(APIC_TMCCT),
-		X2APIC_MSR(APIC_TDCR),
-	};
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u64 rd_regs;
 	int i;
 
 	if (intercept == svm->x2avic_msrs_intercepted)
@@ -162,9 +132,16 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!x2avic_enabled)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
-		svm_set_intercept_for_msr(&svm->vcpu, x2avic_passthrough_msrs[i],
-					  MSR_TYPE_RW, intercept);
+	rd_regs = kvm_x2apic_disable_read_intercept_reg_mask(vcpu);
+
+	for_each_set_bit(i, (unsigned long *)&rd_regs, BITS_PER_TYPE(rd_regs))
+		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
+					  MSR_TYPE_R, intercept);
+
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_ICR), MSR_TYPE_W, intercept);
 
 	svm->x2avic_msrs_intercepted = intercept;
 }
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 29c3d557b78b..d90f5a41e340 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2470,6 +2470,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	sev_populate_args.type = params.type;
 
 	count = kvm_gmem_populate(kvm, params.gfn_start, src, npages,
+				  params.type == KVM_SEV_SNP_PAGE_TYPE_CPUID,
 				  sev_gmem_post_populate, &sev_populate_args);
 	if (count < 0) {
 		argp->error = sev_populate_args.fw_error;
@@ -4521,9 +4522,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	sev_es_sync_from_ghcb(svm);
 
 	/* SEV-SNP guest requires that the GHCB GPA must be registered */
-	if (is_sev_snp_guest(vcpu) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
-		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
-		return -EINVAL;
+	if (is_sev_snp_guest(vcpu) &&
+	    !ghcb_gpa_is_registered(svm, control->ghcb_gpa)) {
+		vcpu_unimpl(vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n",
+			    control->ghcb_gpa);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_NOT_REGISTERED);
+		return 1;
 	}
 
 	ret = sev_es_validate_vmgexit(svm);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..2544c551e702 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3663,6 +3663,9 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 			vcpu->arch.cr3 = svm->vmcb->save.cr3;
 	}
 
+	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
+		return 0;
+
 	if (is_guest_mode(vcpu)) {
 		int vmexit;
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..22138c487216 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -308,13 +308,15 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	 */
 	local_irq_disable();
 	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
+		int err = 0;
+
 		if (read)
 			rdmsrq(index, msr_info->data);
 		else
-			wrmsrq(index, msr_info->data);
+			err = wrmsrq_safe(index, msr_info->data);
 		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 		local_irq_enable();
-		return true;
+		return !err;
 	}
 	clear_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 	local_irq_enable();
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..ec29a2db1adc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2387,20 +2387,20 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL);
+	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!tdr_page)
 		goto free_hkid;
 
 	kvm_tdx->td.tdcs_nr_pages = tdx_sysinfo->td_ctrl.tdcs_base_size / PAGE_SIZE;
 	/* TDVPS = TDVPR(4K page) + TDCX(multiple 4K pages), -1 for TDVPR. */
 	kvm_tdx->td.tdcx_nr_pages = tdx_sysinfo->td_ctrl.tdvps_base_size / PAGE_SIZE - 1;
-	tdcs_pages = kzalloc_objs(*kvm_tdx->td.tdcs_pages,
-				  kvm_tdx->td.tdcs_nr_pages);
+	tdcs_pages = kzalloc_objs(*kvm_tdx->td.tdcs_pages, kvm_tdx->td.tdcs_nr_pages,
+				  GFP_KERNEL_ACCOUNT);
 	if (!tdcs_pages)
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL);
+		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2875,7 +2875,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2888,14 +2888,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	tdx->vp.tdvpr_pa = page_to_phys(tdx->vp.tdvpr_page);
 
 	tdx->vp.tdcx_pages = kcalloc(kvm_tdx->td.tdcx_nr_pages, sizeof(*tdx->vp.tdcx_pages),
-			       	     GFP_KERNEL);
+				     GFP_KERNEL_ACCOUNT);
 	if (!tdx->vp.tdcx_pages) {
 		ret = -ENOMEM;
 		goto free_tdvpr;
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL);
+		page = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
@@ -3185,7 +3185,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 		};
 		gmem_ret = kvm_gmem_populate(kvm, gpa_to_gfn(region.gpa),
 					     u64_to_user_ptr(region.source_addr),
-					     1, tdx_gmem_post_populate, &arg);
+					     1, false, tdx_gmem_post_populate, &arg);
 		if (gmem_ret < 0) {
 			ret = gmem_ret;
 			break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428..f389ac9fcb33 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1908,6 +1908,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	/*
+	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
+	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
+	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
+	 * asserts that a single-step #DB _must_ be pending in this scenario,
+	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
+	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
+	 * instruction delay when activating single-step breakpoints must have
+	 * already expired.  However, the CPU isn't smart enough to peek at
+	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
+	 * is indeed a #DB pending/imminent.
+	 */
+	if (ex->vector == DB_VECTOR &&
+	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
+	    vmx_get_interrupt_shadow(vcpu))
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
+
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (ex->has_error_code) {
@@ -4141,7 +4159,7 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 	 * mode, only the current timer count needs on-demand emulation by KVM.
 	 */
 	if (mode & MSR_BITMAP_MODE_X2APIC_APICV)
-		msr_bitmap[read_idx] = ~kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+		msr_bitmap[read_idx] = ~kvm_x2apic_disable_read_intercept_reg_mask(vcpu);
 	else
 		msr_bitmap[read_idx] = ~0ull;
 	msr_bitmap[write_idx] = ~0ull;
@@ -4154,7 +4172,6 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 				  !(mode & MSR_BITMAP_MODE_X2APIC));
 
 	if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
-		vmx_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_RW);
 		vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
 		vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
 		if (enable_ipiv)
@@ -5477,26 +5494,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * avoid single-step #DB and MTF updates, as ICEBP is
 			 * higher priority.  Note, skipping ICEBP still clears
 			 * STI and MOVSS blocking.
-			 *
-			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
-			 * if single-step is enabled in RFLAGS and STI or MOVSS
-			 * blocking is active, as the CPU doesn't set the bit
-			 * on VM-Exit due to #DB interception.  VM-Entry has a
-			 * consistency check that a single-step #DB is pending
-			 * in this scenario as the previous instruction cannot
-			 * have toggled RFLAGS.TF 0=>1 (because STI and POP/MOV
-			 * don't modify RFLAGS), therefore the one instruction
-			 * delay when activating single-step breakpoints must
-			 * have already expired.  Note, the CPU sets/clears BS
-			 * as appropriate for all other VM-Exits types.
 			 */
 			if (is_icebp(intr_info))
 				WARN_ON(!skip_emulated_instruction(vcpu));
-			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
-				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
-				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;
@@ -6697,6 +6697,9 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (enable_pml && !is_guest_mode(vcpu))
 		vmx_flush_pml_buffer(vcpu);
 
+	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
+		return 0;
+
 	/*
 	 * KVM should never reach this point with a pending nested VM-Enter.
 	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
@@ -6855,11 +6858,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
-	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
 
 	if (is_guest_mode(vcpu) &&
-		nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
+	    nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
 		return;
 
 	guard(vmx_vmcs01)(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..88f0e3fd8919 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -128,7 +128,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -5340,7 +5339,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -10595,33 +10593,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 		kvm_run->flags |= KVM_RUN_X86_GUEST_MODE;
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu)
-{
-	int max_irr, tpr;
-
-	if (!kvm_x86_ops.update_cr8_intercept)
-		return;
-
-	if (!lapic_in_kernel(vcpu))
-		return;
-
-	if (vcpu->arch.apic->apicv_active)
-		return;
-
-	if (!vcpu->arch.apic->vapic_addr)
-		max_irr = kvm_lapic_find_highest_irr(vcpu);
-	else
-		max_irr = -1;
-
-	if (max_irr != -1)
-		max_irr >>= 4;
-
-	tpr = kvm_lapic_get_cr8(vcpu);
-
-	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
-}
-
-
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
@@ -11362,7 +11333,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_call(enable_irq_window)(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+			kvm_lapic_update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
 	}
@@ -11607,9 +11578,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.apic_attention)
 		kvm_lapic_sync_from_vapic(vcpu);
 
-	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
-		return 0;
-
 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
 	return r;
 
@@ -12481,8 +12449,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
 
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
 
@@ -12511,7 +12477,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df2261fa4f98..7e20b22d658b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1014,7 +1014,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 		enum bootmem_type type = bootmem_type(page);
 
-		if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
+		if (type == MIX_SECTION_INFO) {
 			while (nr_pages--)
 				put_page_bootmem(page++);
 		} else {
@@ -1028,13 +1028,24 @@ static void __meminit free_pagetable(struct page *page, int order)
 	}
 }
 
-static void __meminit free_hugepage_table(struct page *page,
+static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 		struct vmem_altmap *altmap)
 {
-	if (altmap)
-		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
-	else
-		free_pagetable(page, get_order(PMD_SIZE));
+	unsigned long nr_pages = 1u << order;
+
+	if (altmap) {
+		vmem_altmap_free(altmap, nr_pages);
+	} else if (PageReserved(page)) {
+		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
+		    bootmem_type(page) == SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			free_reserved_pages(page, nr_pages);
+		}
+	} else {
+		__free_pages(page, order);
+	}
 }
 
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
@@ -1118,7 +1129,8 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 			return;
 
 		if (!direct)
-			free_pagetable(pte_page(*pte), 0);
+			/* We never populate base pages from the altmap. */
+			free_vmemmap_pages(pte_page(*pte), 0, NULL);
 
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
@@ -1153,19 +1165,19 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
 				if (!direct)
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
+					free_vmemmap_pages(pmd_page(*pmd),
+							   PMD_ORDER, altmap);
 
 				spin_lock(&init_mm.page_table_lock);
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
 			} else if (vmemmap_pmd_is_unused(addr, next)) {
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
-					spin_lock(&init_mm.page_table_lock);
-					pmd_clear(pmd);
-					spin_unlock(&init_mm.page_table_lock);
+				free_vmemmap_pages(pmd_page(*pmd), PMD_ORDER,
+						   altmap);
+				spin_lock(&init_mm.page_table_lock);
+				pmd_clear(pmd);
+				spin_unlock(&init_mm.page_table_lock);
 			}
 			continue;
 		}
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..ef8b112fd7b6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3520,7 +3520,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
-	return bpf_prog_pack_alloc(size, jit_fill_hole);
+	return bpf_prog_pack_alloc(size, jit_fill_hole, false);
 }
 
 void arch_free_bpf_trampoline(void *image, unsigned int size)
@@ -3831,7 +3831,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			/* allocate module memory for x86 insns and extable */
 			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
 							   &image, align, &rw_header, &rw_image,
-							   jit_fill_hole);
+							   jit_fill_hole,
+							   bpf_prog_was_classic(prog));
 			if (!header)
 				goto out_addrs;
 			prog->aux->extable = (void *) image + roundup(proglen, align);
diff --git a/block/bdev.c b/block/bdev.c
index 107ac9eaac7f..85ce57bd2ae4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1245,7 +1245,13 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
 	else {
 		mutex_unlock(&bdev->bd_holder_lock);
-		sync_blockdev(bdev);
+		/*
+		 * On surprise removal the device is already gone; syncing is
+		 * futile and can hang forever waiting on I/O that will never
+		 * complete.  Match fs_bdev_mark_dead(), which also skips it.
+		 */
+		if (!surprise)
+			sync_blockdev(bdev);
 	}
 
 	invalidate_bdev(bdev);
diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 29b8f4cebb63..f3c4174e003e 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -226,6 +226,15 @@ int aix_partition(struct parsed_partitions *state)
 		int next_lp_ix = 1;
 		int lp_ix;
 
+		/*
+		 * pvd was read into a fixed-size struct pvd whose ppe[] array
+		 * holds ARRAY_SIZE(pvd->ppe) entries.  pp_count is an
+		 * unvalidated on-disk __be16, so clamp the scan to the array
+		 * size to avoid walking past the allocation.
+		 */
+		if (numpps > ARRAY_SIZE(pvd->ppe))
+			numpps = ARRAY_SIZE(pvd->ppe);
+
 		for (i = 0; i < numpps; i += 1) {
 			struct ppe *p = pvd->ppe + i;
 			unsigned int lv_ix;
diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b60661098..53664ea06b65 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -74,8 +74,10 @@ int of_partition(struct parsed_partitions *state)
 	struct device_node *partitions_np = of_node_get(ddev->of_node);
 
 	if (!partitions_np ||
-	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+	    !of_device_is_compatible(partitions_np, "fixed-partitions")) {
+		of_node_put(partitions_np);
 		return 0;
+	}
 
 	slot = 1;
 	/* Validate parition offset and size */
@@ -104,5 +106,6 @@ int of_partition(struct parsed_partitions *state)
 
 	seq_buf_puts(&state->pp_buf, "\n");
 
+	of_node_put(partitions_np);
 	return 1;
 }
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 5a00c18eb145..fce0b87c2b65 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -973,7 +973,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		ssize_t plen;
 
 		/* use the existing memory in an allocated page */
-		if (ctx->merge && !(msg->msg_flags & MSG_SPLICE_PAGES)) {
+		if (ctx->merge) {
 			sgl = list_entry(ctx->tsgl_list.prev,
 					 struct af_alg_tsgl, list);
 			sg = sgl->sg + sgl->cur - 1;
@@ -1017,60 +1017,37 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		if (sgl->cur)
 			sg_unmark_end(sg + sgl->cur - 1);
 
-		if (msg->msg_flags & MSG_SPLICE_PAGES) {
-			struct sg_table sgtable = {
-				.sgl		= sg,
-				.nents		= sgl->cur,
-				.orig_nents	= sgl->cur,
-			};
-
-			plen = extract_iter_to_sg(&msg->msg_iter, len, &sgtable,
-						  MAX_SGL_ENTS - sgl->cur, 0);
-			if (plen < 0) {
-				err = plen;
+		do {
+			struct page *pg;
+			unsigned int i = sgl->cur;
+
+			plen = min_t(size_t, len, PAGE_SIZE);
+
+			pg = alloc_page(GFP_KERNEL);
+			if (!pg) {
+				err = -ENOMEM;
 				goto unlock;
 			}
 
-			for (; sgl->cur < sgtable.nents; sgl->cur++)
-				get_page(sg_page(&sg[sgl->cur]));
+			sg_assign_page(sg + i, pg);
+
+			err = memcpy_from_msg(page_address(sg_page(sg + i)),
+					      msg, plen);
+			if (err) {
+				__free_page(sg_page(sg + i));
+				sg_assign_page(sg + i, NULL);
+				goto unlock;
+			}
+
+			sg[i].length = plen;
 			len -= plen;
 			ctx->used += plen;
 			copied += plen;
 			size -= plen;
-		} else {
-			do {
-				struct page *pg;
-				unsigned int i = sgl->cur;
-
-				plen = min_t(size_t, len, PAGE_SIZE);
-
-				pg = alloc_page(GFP_KERNEL);
-				if (!pg) {
-					err = -ENOMEM;
-					goto unlock;
-				}
-
-				sg_assign_page(sg + i, pg);
-
-				err = memcpy_from_msg(
-					page_address(sg_page(sg + i)),
-					msg, plen);
-				if (err) {
-					__free_page(sg_page(sg + i));
-					sg_assign_page(sg + i, NULL);
-					goto unlock;
-				}
-
-				sg[i].length = plen;
-				len -= plen;
-				ctx->used += plen;
-				copied += plen;
-				size -= plen;
-				sgl->cur++;
-			} while (len && sgl->cur < MAX_SGL_ENTS);
-
-			ctx->merge = plen & (PAGE_SIZE - 1);
-		}
+			sgl->cur++;
+		} while (len && sgl->cur < MAX_SGL_ENTS);
+
+		ctx->merge = plen & (PAGE_SIZE - 1);
 
 		if (!size)
 			sg_mark_end(sg + sgl->cur - 1);
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index cb651ab58d62..c6c2ce21895d 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -9,10 +9,10 @@
  * The following concept of the memory management is used:
  *
  * The kernel maintains two SGLs, the TX SGL and the RX SGL. The TX SGL is
- * filled by user space with the data submitted via sendmsg (maybe with
- * MSG_SPLICE_PAGES).  Filling up the TX SGL does not cause a crypto operation
- * -- the data will only be tracked by the kernel. Upon receipt of one recvmsg
- * call, the caller must provide a buffer which is tracked with the RX SGL.
+ * filled by user space with the data submitted via sendmsg.  Filling up the TX
+ * SGL does not cause a crypto operation -- the data will only be tracked by the
+ * kernel. Upon receipt of one recvmsg call, the caller must provide a buffer
+ * which is tracked with the RX SGL.
  *
  * During the processing of the recvmsg operation, the cipher request is
  * allocated and prepared. As part of the recvmsg operation, the processed
diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index a41741326998..0d516c77cc26 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -20,7 +20,7 @@ int x509_load_certificate_list(const u8 cert_list[],
 		 */
 		if (end - p < 4)
 			goto dodgy_cert;
-		if (p[0] != 0x30 &&
+		if (p[0] != 0x30 ||
 		    p[1] != 0x82)
 			goto dodgy_cert;
 		plen = (p[2] << 8) | p[3];
diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
index b4b5a7198d84..27df9e1eb058 100644
--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -375,6 +375,7 @@ static int chachapoly_create(struct crypto_template *tmpl, struct rtattr **tb,
 	struct aead_instance *inst;
 	struct chachapoly_instance_ctx *ctx;
 	struct skcipher_alg_common *chacha;
+	const char *poly_name;
 	int err;
 
 	if (ivsize > CHACHAPOLY_IV_SIZE)
@@ -396,9 +397,15 @@ static int chachapoly_create(struct crypto_template *tmpl, struct rtattr **tb,
 		goto err_free_inst;
 	chacha = crypto_spawn_skcipher_alg_common(&ctx->chacha);
 
+	poly_name = crypto_attr_alg_name(tb[2]);
+	if (IS_ERR(poly_name)) {
+		err = PTR_ERR(poly_name);
+		goto err_free_inst;
+	}
+
 	err = -EINVAL;
-	if (strcmp(crypto_attr_alg_name(tb[2]), "poly1305") &&
-	    strcmp(crypto_attr_alg_name(tb[2]), "poly1305-generic"))
+	if (strcmp(poly_name, "poly1305") &&
+	    strcmp(poly_name, "poly1305-generic"))
 		goto err_free_inst;
 	/* Need 16-byte IV size, including Initial Block Counter value */
 	if (chacha->ivsize != CHACHA_IV_SIZE)
diff --git a/crypto/df_sp80090a.c b/crypto/df_sp80090a.c
index b8134be6f7ad..f4bb7be016e8 100644
--- a/crypto/df_sp80090a.c
+++ b/crypto/df_sp80090a.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
 #include <crypto/aes.h>
 #include <crypto/df_sp80090a.h>
 #include <crypto/internal/drbg.h>
@@ -141,10 +142,10 @@ int crypto_drbg_ctr_df(struct aes_enckey *aeskey,
 	/* 10.4.2 step 2 -- calculate the entire length of all input data */
 	list_for_each_entry(seed, seedlist, list)
 		inputlen += seed->len;
-	drbg_cpu_to_be32(inputlen, &L_N[0]);
+	put_unaligned_be32(inputlen, &L_N[0]);
 
 	/* 10.4.2 step 3 */
-	drbg_cpu_to_be32(bytes_to_return, &L_N[4]);
+	put_unaligned_be32(bytes_to_return, &L_N[4]);
 
 	/* 10.4.2 step 5: length is L_N, input_string, one byte, padding */
 	padlen = (inputlen + sizeof(L_N) + 1) % (blocklen_bytes);
@@ -175,7 +176,7 @@ int crypto_drbg_ctr_df(struct aes_enckey *aeskey,
 		 * holds zeros after allocation -- even the increment of i
 		 * is irrelevant as the increment remains within length of i
 		 */
-		drbg_cpu_to_be32(i, iv);
+		put_unaligned_be32(i, iv);
 		/* 10.4.2 step 9.2 -- BCC and concatenation with temp */
 		drbg_ctr_bcc(aeskey, temp + templen, K, &bcc_list,
 			     blocklen_bytes, keylen);
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 9204e6edb426..e3065fb9541b 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -103,6 +103,7 @@
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/string_choices.h>
+#include <linux/unaligned.h>
 
 /***************************************************************
  * Backend cipher definitions available to DRBG
@@ -377,7 +378,7 @@ static int drbg_ctr_generate(struct drbg_state *drbg,
 	if (addtl && !list_empty(addtl)) {
 		ret = drbg_ctr_update(drbg, addtl, 2);
 		if (ret)
-			return 0;
+			return ret;
 	}
 
 	/* 10.2.1.5.2 step 4.1 */
@@ -601,7 +602,7 @@ static int drbg_hash_df(struct drbg_state *drbg,
 
 	/* 10.4.1 step 3 */
 	input[0] = 1;
-	drbg_cpu_to_be32((outlen * 8), &input[1]);
+	put_unaligned_be32(outlen * 8, &input[1]);
 
 	/* 10.4.1 step 4.1 -- concatenation of data for input into hash */
 	drbg_string_fill(&data, input, 5);
@@ -1736,7 +1737,6 @@ static int drbg_kcapi_seed(struct crypto_rng *tfm,
  */
 static inline int __init drbg_healthcheck_sanity(void)
 {
-	int len = 0;
 #define OUTBUFLEN 16
 	unsigned char buf[OUTBUFLEN];
 	struct drbg_state *drbg = NULL;
@@ -1781,11 +1781,11 @@ static inline int __init drbg_healthcheck_sanity(void)
 	max_request_bytes = drbg_max_request_bytes(drbg);
 	drbg_string_fill(&addtl, buf, max_addtllen + 1);
 	/* overflow addtllen with additional info string */
-	len = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
-	BUG_ON(0 < len);
+	ret = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
+	BUG_ON(ret == 0);
 	/* overflow max_bits */
-	len = drbg_generate(drbg, buf, (max_request_bytes + 1), NULL);
-	BUG_ON(0 < len);
+	ret = drbg_generate(drbg, buf, max_request_bytes + 1, NULL);
+	BUG_ON(ret == 0);
 
 	/* overflow max addtllen with personalization string */
 	ret = drbg_seed(drbg, &addtl, false);
@@ -1832,7 +1832,7 @@ static inline void __init drbg_fill_array(struct rng_alg *alg,
 	 * it is selected.
 	 */
 	if (fips_enabled)
-		alg->base.cra_priority += 200;
+		alg->base.cra_priority += 2000;
 
 	alg->base.cra_ctxsize 	= sizeof(struct drbg_state);
 	alg->base.cra_module	= THIS_MODULE;
diff --git a/crypto/ecc.c b/crypto/ecc.c
index 43b0def3a225..6eb4d97a5f0d 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -393,14 +393,26 @@ static uint128_t mul_64_64(u64 left, u64 right)
 	return result;
 }
 
-static uint128_t add_128_128(uint128_t a, uint128_t b)
+/* Calculate addition with overflow checking. Returns true on wrap-around,
+ * false otherwise.
+ */
+static bool check_add_128_128_overflow(uint128_t *result, uint128_t a,
+				       uint128_t b)
 {
-	uint128_t result;
+	bool carry;
 
-	result.m_low = a.m_low + b.m_low;
-	result.m_high = a.m_high + b.m_high + (result.m_low < a.m_low);
+	result->m_low = a.m_low + b.m_low;
+	carry = (result->m_low < a.m_low);
 
-	return result;
+	result->m_high = a.m_high + b.m_high + carry;
+
+	/* Using constant-time bitwise arithmetic to prevent timing
+	 * side-channels.
+	 */
+	carry = (result->m_high < a.m_high) |
+		((result->m_high == a.m_high) & carry);
+
+	return carry;
 }
 
 static void vli_mult(u64 *result, const u64 *left, const u64 *right,
@@ -425,9 +437,7 @@ static void vli_mult(u64 *result, const u64 *left, const u64 *right,
 			uint128_t product;
 
 			product = mul_64_64(left[i], right[k - i]);
-
-			r01 = add_128_128(r01, product);
-			r2 += (r01.m_high < product.m_high);
+			r2 += check_add_128_128_overflow(&r01, r01, product);
 		}
 
 		result[k] = r01.m_low;
@@ -450,7 +460,7 @@ static void vli_umult(u64 *result, const u64 *left, u32 right,
 		uint128_t product;
 
 		product = mul_64_64(left[k], right);
-		r01 = add_128_128(r01, product);
+		check_add_128_128_overflow(&r01, r01, product);
 		/* no carry */
 		result[k] = r01.m_low;
 		r01.m_low = r01.m_high;
@@ -487,8 +497,7 @@ static void vli_square(u64 *result, const u64 *left, unsigned int ndigits)
 				product.m_low <<= 1;
 			}
 
-			r01 = add_128_128(r01, product);
-			r2 += (r01.m_high < product.m_high);
+			r2 += check_add_128_128_overflow(&r01, r01, product);
 		}
 
 		result[k] = r01.m_low;
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index c7ea40f900a7..03395b89cc61 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -207,7 +207,7 @@ struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
 	struct crypto_aead *ci = NULL;
 	int ret = -ENOMEM;
 
-	ci = crypto_alloc_aead(krb5->encrypt_name, 0, 0);
+	ci = crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(ci)) {
 		ret = PTR_ERR(ci);
 		if (ret == -ENOENT)
diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index ed0feaba2383..9f372442981e 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -122,6 +122,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 		return -EINPROGRESS;
 	if (err == -EBUSY) {
 		/* try non-parallel mode */
+		aead_request_set_callback(creq, flags, req->base.complete,
+					  req->base.data);
 		return crypto_aead_encrypt(creq);
 	}
 
@@ -173,6 +175,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 		return -EINPROGRESS;
 	if (err == -EBUSY) {
 		/* try non-parallel mode */
+		aead_request_set_callback(creq, flags, req->base.complete,
+					  req->base.data);
 		return crypto_aead_decrypt(creq);
 	}
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f370be8715ae..34edec0f2bde 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -185,8 +185,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
-/* Check for valid access_width, otherwise, fallback to using bit_width */
-#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+/*
+ * PCC reuses the access_width field as the subspace id, so only decode access
+ * size for non-PCC registers. Otherwise, use the bit_width.
+ */
+#define GET_BIT_WIDTH(reg) (((reg)->access_width &&				\
+			     (reg)->space_id != ACPI_ADR_SPACE_PLATFORM_COMM) ? \
+			    (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
 #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
@@ -1045,7 +1050,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -1118,7 +1122,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 9304ac996d41..7f554ce6345f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3069,6 +3069,8 @@ static void acpi_nfit_unregister(void *data)
 	struct acpi_nfit_desc *acpi_desc = data;
 
 	nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+	/* The nvdimm_bus object may have been freed, so clear the pointer. */
+	acpi_desc->nvdimm_bus = NULL;
 }
 
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
@@ -3309,7 +3311,10 @@ static void acpi_nfit_remove_notify_handler(void *data)
 void acpi_nfit_shutdown(void *data)
 {
 	struct acpi_nfit_desc *acpi_desc = data;
-	struct device *bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
+	struct device *bus_dev;
+
+	if (!acpi_desc || !acpi_desc->nvdimm_bus)
+		return;
 
 	/*
 	 * Destruct under acpi_desc_lock so that nfit_handle_mce does not
@@ -3324,6 +3329,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc->init_mutex);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 
+	bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
@@ -3406,9 +3412,14 @@ static int acpi_nfit_probe(struct platform_device *pdev)
 				sz - sizeof(struct acpi_table_nfit));
 
 	if (rc)
-		return rc;
+		acpi_nfit_shutdown(acpi_desc);
+
+	return rc;
+}
 
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+static void acpi_nfit_remove(struct platform_device *pdev)
+{
+	acpi_nfit_shutdown(platform_get_drvdata(pdev));
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3460,6 +3471,9 @@ static void acpi_nfit_uc_error_notify(struct device *dev, acpi_handle handle)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
 
+	if (!acpi_desc)
+		return;
+
 	if (acpi_desc->scrub_mode == HW_ERROR_SCRUB_ON)
 		acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
 	else
@@ -3489,6 +3503,7 @@ MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
 static struct platform_driver acpi_nfit_driver = {
 	.probe = acpi_nfit_probe,
+	.remove = acpi_nfit_remove,
 	.driver = {
 		.name = "acpi-nfit",
 		.acpi_match_table = acpi_nfit_ids,
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9e6194224593..b85920c39694 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1658,7 +1658,20 @@ static void binder_txn_latency_free(struct binder_transaction *t)
 
 static void binder_free_transaction(struct binder_transaction *t)
 {
-	struct binder_proc *target_proc = t->to_proc;
+	struct binder_thread *target_thread;
+	struct binder_proc *target_proc;
+
+	spin_lock(&t->lock);
+	target_proc = t->to_proc;
+	target_thread = t->to_thread;
+	/*
+	 * Pin target_thread to keep target_proc alive. Undelivered
+	 * transactions with !target_thread are safe, as target_proc
+	 * can only be the current context there.
+	 */
+	if (target_thread)
+		atomic_inc(&target_thread->tmp_ref);
+	spin_unlock(&t->lock);
 
 	if (target_proc) {
 		binder_inner_proc_lock(target_proc);
@@ -1672,6 +1685,10 @@ static void binder_free_transaction(struct binder_transaction *t)
 			t->buffer->transaction = NULL;
 		binder_inner_proc_unlock(target_proc);
 	}
+
+	if (target_thread)
+		binder_thread_dec_tmpref(target_thread);
+
 	if (trace_binder_txn_latency_free_enabled())
 		binder_txn_latency_free(t);
 	/*
diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index b7b05e72970a..ea5846e4da16 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -259,7 +259,7 @@ fn drop(&mut self) {
 
             if let Some(offsets) = info.offsets.clone() {
                 let view = AllocationView::new(self, offsets.start);
-                for i in offsets.step_by(size_of::<usize>()) {
+                for i in offsets.step_by(size_of::<u64>()) {
                     if view.cleanup_object(i).is_err() {
                         pr_warn!("Error cleaning up object at offset {}\n", i)
                     }
@@ -420,7 +420,8 @@ pub(crate) fn transfer_binder_object(
     }
 
     fn cleanup_object(&self, index_offset: usize) -> Result {
-        let offset = self.alloc.read(index_offset)?;
+        let offset = self.alloc.read::<u64>(index_offset)?;
+        let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
         let header = self.read::<BinderObjectHeader>(offset)?;
         match header.type_ {
             BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 45d85d4c2815..1296072c35d9 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -73,20 +73,17 @@ impl fmt::Debug for BinderError {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
-                Some(source) => f
-                    .debug_struct("BR_FAILED_REPLY")
-                    .field("source", source)
-                    .finish(),
+                Some(source) => source.fmt(f),
                 None => f.pad("BR_FAILED_REPLY"),
             },
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
             BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
             BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
-            _ => f
-                .debug_struct("BinderError")
-                .field("reply", &self.reply)
-                .finish(),
+            _ => match self.source.as_ref() {
+                Some(source) => source.fmt(f),
+                None => self.reply.fmt(f),
+            },
         }
     }
 }
diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 53b60035639a..f4df14568b25 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -154,10 +154,17 @@ fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
 }
 
 impl FreezeListener {
-    pub(crate) fn on_process_exit(&self, proc: &Arc<Process>) {
+    /// Called when this freeze listener is cleared abnormally.
+    ///
+    /// This occurs either because the process exited or because the process dropped its last
+    /// refcount on the node ref without explicitly removing the freeze listener first.
+    ///
+    /// The returned `KVVec` is just a value that should be dropped outside of the lock.
+    pub(crate) fn on_process_cleanup(&self, proc: &Process) -> KVVec<Arc<Process>> {
         if !self.is_clearing {
-            self.node.remove_freeze_listener(proc);
+            return self.node.remove_freeze_listener(proc);
         }
+        KVVec::new()
     }
 }
 
diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index 69f757ff7461..c10148e9069f 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -682,12 +682,13 @@ pub(crate) fn add_freeze_listener(
         }
     }
 
-    pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) {
-        let _unused_capacity;
+    pub(crate) fn remove_freeze_listener(&self, p: &Process) -> KVVec<Arc<Process>> {
         let mut guard = self.owner.inner.lock();
         let inner = self.inner.access_mut(&mut guard);
         let len = inner.freeze_list.len();
-        inner.freeze_list.retain(|proc| !Arc::ptr_eq(proc, p));
+        inner
+            .freeze_list
+            .retain(|proc| !core::ptr::eq::<Process>(&**proc, p));
         if len == inner.freeze_list.len() {
             pr_warn!(
                 "Could not remove freeze listener for {}\n",
@@ -695,8 +696,9 @@ pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) {
             );
         }
         if inner.freeze_list.is_empty() {
-            _unused_capacity = mem::take(&mut inner.freeze_list);
+            return mem::take(&mut inner.freeze_list);
         }
+        KVVec::new()
     }
 
     pub(crate) fn freeze_list<'a>(&'a self, guard: &'a ProcessInner) -> &'a [Arc<Process>] {
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 96b8440ceac6..cdd1a9079726 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -900,7 +900,11 @@ pub(crate) fn insert_or_update_handle(
     pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
         // When handle is zero, try to get the context manager.
         if handle == 0 {
-            Ok(self.ctx.get_manager_node(true)?)
+            let node_ref = self.ctx.get_manager_node(true)?;
+            if core::ptr::eq(self, &*node_ref.node.owner) {
+                return Err(EINVAL.into());
+            }
+            Ok(node_ref)
         } else {
             Ok(self.get_node_from_handle(handle, true)?)
         }
@@ -942,6 +946,8 @@ pub(crate) fn update_ref(
 
         // To preserve original binder behaviour, we only fail requests where the manager tries to
         // increment references on itself.
+        let _to_free_freeze_listener;
+        let _to_free_freeze_listener_cleanup;
         let mut refs = self.node_refs.lock();
         if let Some(info) = refs.by_handle.get_mut(&handle) {
             if info.node_ref().update(inc, strong) {
@@ -957,6 +963,14 @@ pub(crate) fn update_ref(
                 unsafe { info.node_ref2().node.remove_node_info(info) };
 
                 let id = info.node_ref().node.global_id();
+
+                if let Some(freeze) = *info.freeze() {
+                    if let Some(fl) = refs.freeze_listeners.remove(&freeze) {
+                        _to_free_freeze_listener_cleanup = fl.on_process_cleanup(&self);
+                        _to_free_freeze_listener = fl;
+                    }
+                }
+
                 refs.by_handle.remove(&handle);
                 refs.by_node.remove(&id);
                 refs.handle_is_present.release_id(handle as usize);
@@ -1380,7 +1394,7 @@ fn deferred_release(self: Arc<Self>) {
         // Clean up freeze listeners.
         let freeze_listeners = take(&mut self.node_refs.lock().freeze_listeners);
         for listener in freeze_listeners.values() {
-            listener.on_process_exit(&self);
+            listener.on_process_cleanup(&self);
         }
         drop(freeze_listeners);
 
diff --git a/drivers/android/binder/rust_binder_events.c b/drivers/android/binder/rust_binder_events.c
index 488b1470060c..5792aa59cc82 100644
--- a/drivers/android/binder/rust_binder_events.c
+++ b/drivers/android/binder/rust_binder_events.c
@@ -28,6 +28,9 @@ const char * const binder_command_strings[] = {
 	"BC_DEAD_BINDER_DONE",
 	"BC_TRANSACTION_SG",
 	"BC_REPLY_SG",
+	"BC_REQUEST_FREEZE_NOTIFICATION",
+	"BC_CLEAR_FREEZE_NOTIFICATION",
+	"BC_FREEZE_NOTIFICATION_DONE",
 };
 
 const char * const binder_return_strings[] = {
@@ -51,7 +54,9 @@ const char * const binder_return_strings[] = {
 	"BR_FAILED_REPLY",
 	"BR_FROZEN_REPLY",
 	"BR_ONEWAY_SPAM_SUSPECT",
-	"BR_TRANSACTION_PENDING_FROZEN"
+	"BR_TRANSACTION_PENDING_FROZEN",
+	"BR_FROZEN_BINDER",
+	"BR_CLEAR_FREEZE_NOTIFICATION_DONE",
 };
 
 #define CREATE_TRACE_POINTS
diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index ab75e9561cbf..ec81dc7747db 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -8,8 +8,8 @@
 use kernel::sync::atomic::{ordering::Relaxed, Atomic};
 use kernel::{ioctl::_IOC_NR, seq_file::SeqFile, seq_print};
 
-const BC_COUNT: usize = _IOC_NR(BC_REPLY_SG) as usize + 1;
-const BR_COUNT: usize = _IOC_NR(BR_TRANSACTION_PENDING_FROZEN) as usize + 1;
+const BC_COUNT: usize = _IOC_NR(BC_FREEZE_NOTIFICATION_DONE) as usize + 1;
+const BR_COUNT: usize = _IOC_NR(BR_CLEAR_FREEZE_NOTIFICATION_DONE) as usize + 1;
 
 pub(crate) static GLOBAL_STATS: BinderStats = BinderStats::new();
 
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..3b8520813941 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -495,9 +495,16 @@ pub(crate) fn debug_print(self: &Arc<Self>, m: &SeqFile, print_all: bool) -> Res
         Ok(())
     }
 
+    pub(crate) fn clear_extended_error(&self, debug_id: usize) {
+        self.inner.lock().extended_error = ExtendedError::new(debug_id as u32, BR_OK, 0);
+    }
+
     pub(crate) fn get_extended_error(&self, data: UserSlice) -> Result {
         let mut writer = data.writer();
-        let ee = self.inner.lock().extended_error;
+        let mut inner = self.inner.lock();
+        let ee = inner.extended_error;
+        inner.extended_error = ExtendedError::new(0, BR_OK, 0);
+        drop(inner);
         writer.write(&ee)?;
         Ok(())
     }
@@ -1109,7 +1116,10 @@ fn unwind_transaction_stack(self: &Arc<Self>) {
             inner.pop_transaction_to_reply(thread.as_ref())
         } {
             let reply = Err(BR_DEAD_REPLY);
-            if !transaction.from.deliver_single_reply(reply, &transaction) {
+            if !transaction
+                .from
+                .deliver_single_reply(reply, &transaction, None)
+            {
                 break;
             }
 
@@ -1121,8 +1131,9 @@ pub(crate) fn deliver_reply(
         &self,
         reply: Result<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
+        extended_error: Option<ExtendedError>,
     ) {
-        if self.deliver_single_reply(reply, transaction) {
+        if self.deliver_single_reply(reply, transaction, extended_error) {
             transaction.from.unwind_transaction_stack();
         }
     }
@@ -1136,6 +1147,7 @@ fn deliver_single_reply(
         &self,
         reply: Result<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
+        extended_error: Option<ExtendedError>,
     ) -> bool {
         if let Ok(transaction) = &reply {
             crate::trace::trace_transaction(true, transaction, Some(&self.task));
@@ -1152,6 +1164,12 @@ fn deliver_single_reply(
                 return true;
             }
 
+            if let Some(ee) = extended_error {
+                if inner.extended_error.command == BR_OK {
+                    inner.extended_error = ee;
+                }
+            }
+
             match reply {
                 Ok(work) => {
                     inner.push_work(work);
@@ -1222,6 +1240,9 @@ fn read_transaction_info(
         info.buffers_size = td.buffers_size as usize;
         // SAFETY: Above `read` call initializes all bytes, so this union read is ok.
         info.target_handle = unsafe { td.transaction_data.target.handle };
+
+        info.debug_id = super::next_debug_id();
+
         Ok(())
     }
 
@@ -1230,6 +1251,8 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
         let mut info = TransactionInfo::zeroed();
         self.read_transaction_info(cmd, reader, &mut info)?;
 
+        self.clear_extended_error(info.debug_id);
+
         let ret = if info.is_reply {
             self.reply_inner(&mut info)
         } else if info.is_oneway() {
@@ -1239,23 +1262,21 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
         };
 
         if let Err(err) = ret {
-            if err.reply != BR_TRANSACTION_COMPLETE {
-                info.reply = err.reply;
-            }
-
             self.push_return_work(err.reply);
-            if let Some(source) = &err.source {
-                info.errno = source.to_errno();
+            if err.reply != BR_TRANSACTION_COMPLETE {
                 info.reply = err.reply;
+                if let Some(source) = &err.source {
+                    info.errno = source.to_errno();
 
-                {
-                    let mut ee = self.inner.lock().extended_error;
-                    ee.command = err.reply;
-                    ee.param = source.to_errno();
+                    {
+                        let mut inner = self.inner.lock();
+                        inner.extended_error =
+                            ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
+                    }
                 }
 
                 pr_warn!(
-                    "{}:{} transaction to {} failed: {source:?}",
+                    "{}:{} transaction to {} failed: {err:?}",
                     info.from_pid,
                     info.from_tid,
                     info.to_pid
@@ -1320,18 +1341,24 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
             self.inner.lock().push_work(completion);
-            orig.from.deliver_reply(Ok(reply), &orig);
+            orig.from.deliver_reply(Ok(reply), &orig, None);
             Ok(())
         })()
         .map_err(|mut err| {
             // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
             // the sender know that the transaction has completed (with an error in this case).
+
             pr_warn!(
-                "Failure {:?} during reply - delivering BR_FAILED_REPLY to sender.",
-                err
+                "{}:{} reply to {} failed: {err:?}",
+                info.from_pid,
+                info.from_tid,
+                info.to_pid
             );
-            let reply = Err(BR_FAILED_REPLY);
-            orig.from.deliver_reply(reply, &orig);
+
+            let param = err.source.as_ref().map_or(0, |e| e.to_errno());
+            let ee = ExtendedError::new(info.debug_id as u32, err.reply, param);
+            orig.from
+                .deliver_reply(Err(BR_FAILED_REPLY), &orig, Some(ee));
             err.reply = BR_TRANSACTION_COMPLETE;
             err
         });
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 1d9b66920a21..0e5d07b7e6f0 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -42,6 +42,7 @@ pub(crate) struct TransactionInfo {
     pub(crate) reply: u32,
     pub(crate) oneway_spam_suspect: bool,
     pub(crate) is_reply: bool,
+    pub(crate) debug_id: usize,
 }
 
 impl TransactionInfo {
@@ -93,7 +94,6 @@ pub(crate) fn new(
         from: &Arc<Thread>,
         info: &mut TransactionInfo,
     ) -> BinderResult<DLArc<Self>> {
-        let debug_id = super::next_debug_id();
         let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
         let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
         let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
@@ -101,7 +101,7 @@ pub(crate) fn new(
         let mut alloc = match from.copy_transaction_data(
             to.clone(),
             info,
-            debug_id,
+            info.debug_id,
             allow_fds,
             txn_security_ctx_off.as_mut(),
         ) {
@@ -128,7 +128,7 @@ pub(crate) fn new(
         let data_address = alloc.ptr;
 
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: Some(target_node),
             from_parent,
             sender_euid: Kuid::current_euid(),
@@ -152,9 +152,8 @@ pub(crate) fn new_reply(
         info: &mut TransactionInfo,
         allow_fds: bool,
     ) -> BinderResult<DLArc<Self>> {
-        let debug_id = super::next_debug_id();
         let mut alloc =
-            match from.copy_transaction_data(to.clone(), info, debug_id, allow_fds, None) {
+            match from.copy_transaction_data(to.clone(), info, info.debug_id, allow_fds, None) {
                 Ok(alloc) => alloc,
                 Err(err) => {
                     pr_warn!("Failure in copy_transaction_data: {:?}", err);
@@ -165,7 +164,7 @@ pub(crate) fn new_reply(
             alloc.set_info_clear_on_drop();
         }
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: None,
             from_parent: None,
             sender_euid: Kuid::current_euid(),
@@ -394,7 +393,7 @@ fn do_work(
         let send_failed_reply = ScopeGuard::new(|| {
             if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
                 let reply = Err(BR_FAILED_REPLY);
-                self.from.deliver_reply(reply, &self);
+                self.from.deliver_reply(reply, &self, None);
             }
             self.drop_outstanding_txn();
         });
@@ -478,7 +477,7 @@ fn cancel(self: DArc<Self>) {
         // If this is not a reply or oneway transaction, then send a dead reply.
         if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
             let reply = Err(BR_DEAD_REPLY);
-            self.from.deliver_reply(reply, &self);
+            self.from.deliver_reply(reply, &self, None);
         }
 
         self.drop_outstanding_txn();
diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index f59a7856934c..efc33294212f 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -343,7 +343,6 @@ firmware_upload_register(struct module *module, struct device *parent,
 		goto free_fw_upload_priv;
 	}
 	fw_upload->priv = fw_sysfs;
-	fw_sysfs->fw_upload_priv = fw_upload_priv;
 	fw_dev = &fw_sysfs->dev;
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv,  NULL, 0, 0,
@@ -351,10 +350,12 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret != 0) {
 		if (ret > 0)
 			ret = -EINVAL;
-		goto free_fw_sysfs;
+		put_device(fw_dev);
+		goto free_fw_upload_priv;
 	}
 	fw_priv->is_paged_buf = true;
 	fw_sysfs->fw_priv = fw_priv;
+	fw_sysfs->fw_upload_priv = fw_upload_priv;
 
 	ret = device_add(fw_dev);
 	if (ret) {
@@ -365,9 +366,6 @@ firmware_upload_register(struct module *module, struct device *parent,
 
 	return fw_upload;
 
-free_fw_sysfs:
-	kfree(fw_sysfs);
-
 free_fw_upload_priv:
 	kfree(fw_upload_priv);
 
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..c6f80c419e90 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
 				bdev->hdev->stat.err_rx++;
 		}
-	} while (int_status || time_is_before_jiffies(txrx_timeout));
+	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
 	if (bdev->func->irq_handler)
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..6a1cffe08d5f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1267,6 +1267,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+	if (nxpdev->fw_dnld_v3_offset >= nxpdev->fw->size ||
+	    len > nxpdev->fw->size - nxpdev->fw_dnld_v3_offset) {
+		bt_dev_err(hdev, "FW download out of bounds, ignoring request");
+		len = 0;
+		goto free_skb;
+	}
 	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 				nxpdev->fw_dnld_v3_offset, len);
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 830fefb342c6..cc6392f8d98c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -531,6 +531,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c4e, 0x0128), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
@@ -2994,6 +2996,11 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	return 0;
 }
+#else
+static inline int marvell_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
@@ -3836,6 +3843,11 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
+#else
+static inline int btusb_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static void btusb_check_needs_reset_resume(struct usb_interface *intf)
@@ -4172,7 +4184,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->wakeup  = btusb_wakeup;
 	hdev->hci_drv = &btusb_hci_drv;
 
-#ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
 		goto out_free_dev;
@@ -4181,9 +4192,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
-#endif
+
 	if (id->driver_info & BTUSB_CW6622)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_STORED_LINK_KEY);
 
@@ -4218,7 +4229,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
@@ -4381,7 +4392,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 		}
 	}
 
@@ -4389,7 +4400,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4407,7 +4418,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto err_release_siblings;
 
 	usb_set_intfdata(intf, data);
 
@@ -4416,6 +4427,20 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 
+err_release_siblings:
+	if (data->diag) {
+		usb_set_intfdata(data->diag, NULL);
+		usb_driver_release_interface(&btusb_driver, data->diag);
+	}
+	if (data->isoc) {
+		usb_set_intfdata(data->isoc, NULL);
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+	}
+err_kill_tx_urbs:
+	usb_kill_anchored_urbs(&data->tx_anchor);
+err_disable_wakeup:
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47f4902b40b4..2ad42c3bbaac 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -239,6 +239,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
+	disable_work_sync(&hu->write_work);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -254,6 +256,14 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	percpu_up_read(&hu->proto_lock);
 
+	/* Resume TX. Also reschedule in case work was queued concurrently;
+	 * this may schedule write_work although there's nothing to do.
+	 */
+	enable_work(&hu->write_work);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
+
 	return 0;
 }
 
@@ -271,12 +281,8 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-
 	BT_DBG("hdev %p", hdev);
 
-	cancel_work_sync(&hu->write_work);
-
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
diff --git a/drivers/char/hw_random/jh7110-trng.c b/drivers/char/hw_random/jh7110-trng.c
index 9776f4daa044..4712c3c530e4 100644
--- a/drivers/char/hw_random/jh7110-trng.c
+++ b/drivers/char/hw_random/jh7110-trng.c
@@ -256,19 +256,22 @@ static int starfive_trng_read(struct hwrng *rng, void *buf, size_t max, bool wai
 
 	if (wait) {
 		ret = starfive_trng_wait_idle(trng);
-		if (ret)
-			return -ETIMEDOUT;
+		if (ret) {
+			ret = -ETIMEDOUT;
+			goto out_put;
+		}
 	}
 
 	ret = starfive_trng_cmd(trng, STARFIVE_CTRL_GENE_RANDNUM, wait);
 	if (ret)
-		return ret;
+		goto out_put;
 
 	memcpy_fromio(buf, trng->base + STARFIVE_RAND0, max);
+	ret = max;
 
+out_put:
 	pm_runtime_put_sync_autosuspend(trng->dev);
-
-	return max;
+	return ret;
 }
 
 static int starfive_trng_probe(struct platform_device *pdev)
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048..5e83ffa105e4 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -7,6 +7,7 @@
 #include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
+#include <linux/nospec.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
@@ -69,8 +70,26 @@ static void request_entropy(struct virtrng_info *vi)
 static unsigned int copy_data(struct virtrng_info *vi, void *buf,
 			      unsigned int size)
 {
-	size = min_t(unsigned int, size, vi->data_avail);
-	memcpy(buf, vi->data + vi->data_idx, size);
+	unsigned int idx, avail;
+
+	/*
+	 * vi->data_avail was set from the device-reported used.len and
+	 * vi->data_idx was advanced by previous copy_data() calls.  A
+	 * malicious or buggy virtio-rng backend can drive either past
+	 * sizeof(vi->data).  Clamp at point of use and harden the index
+	 * with array_index_nospec() so the memcpy() below cannot be
+	 * steered into adjacent slab memory, including under
+	 * speculation.
+	 */
+	avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
+	if (vi->data_idx >= avail) {
+		vi->data_avail = 0;
+		request_entropy(vi);
+		return 0;
+	}
+	size = min_t(unsigned int, size, avail - vi->data_idx);
+	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
+	memcpy(buf, vi->data + idx, size);
 	vi->data_idx += size;
 	vi->data_avail -= size;
 	if (vi->data_avail == 0)
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 355558893e5f..bfe16d2d5104 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -149,7 +149,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 	u32 value;
 
 	/* unmask hardware IRQ, this may have been lost across powergate */
-	value = TKEIE_WDT_MASK(wdt->index, 1);
+	value = readl(tegra->regs + TKEIE(wdt->tmr->hwirq));
+	value |= TKEIE_WDT_MASK(wdt->index, 1);
 	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
 
 	/* clear interrupt */
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1..d41067cd1f1b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1972,6 +1972,7 @@ void cpufreq_suspend(void)
 	if (!cpufreq_driver)
 		return;
 
+	cpus_read_lock();
 	if (!has_target() && !cpufreq_driver->suspend)
 		goto suspend;
 
@@ -1991,6 +1992,7 @@ void cpufreq_suspend(void)
 
 suspend:
 	cpufreq_suspended = true;
+	cpus_read_unlock();
 }
 
 /**
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..0fbbdbd5765c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	 * from getting to lower performance levels, so force the minimum
 	 * performance on CPU offline to prevent that from happening.
 	 */
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_offline(cpu);
-	else
+	} else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_freq;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c..a355ec4f3dd4 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 	}
 
 	kfree(output.pointer);
+	output.pointer = NULL;
+	output.length = ACPI_ALLOCATE_BUFFER;
 	capabilities[0] = 0x0;
 	capabilities[1] = 0x1;
 
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8f..ef19faedbfec 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
-	kfree(data);
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index d23b58b81ca3..0712e9bf6e54 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -301,7 +301,6 @@ config CRYPTO_DEV_PPC4XX
 	select CRYPTO_CCM
 	select CRYPTO_CTR
 	select CRYPTO_GCM
-	select CRYPTO_RNG
 	select CRYPTO_SKCIPHER
 	help
 	  This option allows you to have support for AMCC crypto acceleration.
@@ -846,7 +845,6 @@ config CRYPTO_DEV_CCREE
 	  If unsure say Y.
 
 source "drivers/crypto/hisilicon/Kconfig"
-source "drivers/crypto/loongson/Kconfig"
 
 source "drivers/crypto/amlogic/Kconfig"
 
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 283bbc650b5b..ad773158ae56 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -43,7 +43,6 @@ obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
 obj-y += hisilicon/
-obj-y += loongson/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index b7b6c97d2147..68c5ff7a85b4 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -31,11 +31,9 @@
 #include <crypto/ctr.h>
 #include <crypto/gcm.h>
 #include <crypto/sha1.h>
-#include <crypto/rng.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/skcipher.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include "crypto4xx_reg_def.h"
 #include "crypto4xx_core.h"
@@ -985,10 +983,6 @@ static int crypto4xx_register_alg(struct crypto4xx_device *sec_dev,
 			rc = crypto_register_aead(&alg->alg.u.aead);
 			break;
 
-		case CRYPTO_ALG_TYPE_RNG:
-			rc = crypto_register_rng(&alg->alg.u.rng);
-			break;
-
 		default:
 			rc = crypto_register_skcipher(&alg->alg.u.cipher);
 			break;
@@ -1014,10 +1008,6 @@ static void crypto4xx_unregister_alg(struct crypto4xx_device *sec_dev)
 			crypto_unregister_aead(&alg->alg.u.aead);
 			break;
 
-		case CRYPTO_ALG_TYPE_RNG:
-			crypto_unregister_rng(&alg->alg.u.rng);
-			break;
-
 		default:
 			crypto_unregister_skcipher(&alg->alg.u.cipher);
 		}
@@ -1076,69 +1066,6 @@ static irqreturn_t crypto4xx_ce_interrupt_handler_revb(int irq, void *data)
 		PPC4XX_TMO_ERR_INT);
 }
 
-static int ppc4xx_prng_data_read(struct crypto4xx_device *dev,
-				 u8 *data, unsigned int max)
-{
-	unsigned int i, curr = 0;
-	u32 val[2];
-
-	do {
-		/* trigger PRN generation */
-		writel(PPC4XX_PRNG_CTRL_AUTO_EN,
-		       dev->ce_base + CRYPTO4XX_PRNG_CTRL);
-
-		for (i = 0; i < 1024; i++) {
-			/* usually 19 iterations are enough */
-			if ((readl(dev->ce_base + CRYPTO4XX_PRNG_STAT) &
-			     CRYPTO4XX_PRNG_STAT_BUSY))
-				continue;
-
-			val[0] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_0);
-			val[1] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_1);
-			break;
-		}
-		if (i == 1024)
-			return -ETIMEDOUT;
-
-		if ((max - curr) >= 8) {
-			memcpy(data, &val, 8);
-			data += 8;
-			curr += 8;
-		} else {
-			/* copy only remaining bytes */
-			memcpy(data, &val, max - curr);
-			break;
-		}
-	} while (curr < max);
-
-	return curr;
-}
-
-static int crypto4xx_prng_generate(struct crypto_rng *tfm,
-				   const u8 *src, unsigned int slen,
-				   u8 *dstn, unsigned int dlen)
-{
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-	struct crypto4xx_alg *amcc_alg;
-	struct crypto4xx_device *dev;
-	int ret;
-
-	amcc_alg = container_of(alg, struct crypto4xx_alg, alg.u.rng);
-	dev = amcc_alg->dev;
-
-	mutex_lock(&dev->core_dev->rng_lock);
-	ret = ppc4xx_prng_data_read(dev, dstn, dlen);
-	mutex_unlock(&dev->core_dev->rng_lock);
-	return ret;
-}
-
-
-static int crypto4xx_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-			unsigned int slen)
-{
-	return 0;
-}
-
 /*
  * Supported Crypto Algorithms
  */
@@ -1268,18 +1195,6 @@ static struct crypto4xx_alg_common crypto4xx_alg[] = {
 			.cra_module	= THIS_MODULE,
 		},
 	} },
-	{ .type = CRYPTO_ALG_TYPE_RNG, .u.rng = {
-		.base = {
-			.cra_name		= "stdrng",
-			.cra_driver_name        = "crypto4xx_rng",
-			.cra_priority		= 300,
-			.cra_ctxsize		= 0,
-			.cra_module		= THIS_MODULE,
-		},
-		.generate               = crypto4xx_prng_generate,
-		.seed                   = crypto4xx_prng_seed,
-		.seedsize               = 0,
-	} },
 };
 
 /*
@@ -1353,9 +1268,6 @@ static int crypto4xx_probe(struct platform_device *ofdev)
 	core_dev->dev->core_dev = core_dev;
 	core_dev->dev->is_revb = is_revb;
 	core_dev->device = dev;
-	rc = devm_mutex_init(&ofdev->dev, &core_dev->rng_lock);
-	if (rc)
-		return rc;
 	spin_lock_init(&core_dev->lock);
 	INIT_LIST_HEAD(&core_dev->dev->alg_list);
 	ratelimit_default_init(&core_dev->dev->aead_ratelimit);
diff --git a/drivers/crypto/amcc/crypto4xx_core.h b/drivers/crypto/amcc/crypto4xx_core.h
index ee36630c670f..3a028aec3f0c 100644
--- a/drivers/crypto/amcc/crypto4xx_core.h
+++ b/drivers/crypto/amcc/crypto4xx_core.h
@@ -14,10 +14,8 @@
 #define __CRYPTO4XX_CORE_H__
 
 #include <linux/ratelimit.h>
-#include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include "crypto4xx_reg_def.h"
 #include "crypto4xx_sa.h"
@@ -111,7 +109,6 @@ struct crypto4xx_core_device {
 	u32 irq;
 	struct tasklet_struct tasklet;
 	spinlock_t lock;
-	struct mutex rng_lock;
 };
 
 struct crypto4xx_ctx {
@@ -135,7 +132,6 @@ struct crypto4xx_alg_common {
 	union {
 		struct skcipher_alg cipher;
 		struct aead_alg aead;
-		struct rng_alg rng;
 	} u;
 };
 
diff --git a/drivers/crypto/amcc/crypto4xx_reg_def.h b/drivers/crypto/amcc/crypto4xx_reg_def.h
index 1038061224da..73d626308a84 100644
--- a/drivers/crypto/amcc/crypto4xx_reg_def.h
+++ b/drivers/crypto/amcc/crypto4xx_reg_def.h
@@ -90,20 +90,9 @@
 #define CRYPTO4XX_BYTE_ORDER_CFG 		0x000600d8
 #define CRYPTO4XX_ENDIAN_CFG			0x000600d8
 
-#define CRYPTO4XX_PRNG_STAT			0x00070000
-#define CRYPTO4XX_PRNG_STAT_BUSY		0x1
 #define CRYPTO4XX_PRNG_CTRL			0x00070004
 #define CRYPTO4XX_PRNG_SEED_L			0x00070008
 #define CRYPTO4XX_PRNG_SEED_H			0x0007000c
-
-#define CRYPTO4XX_PRNG_RES_0			0x00070020
-#define CRYPTO4XX_PRNG_RES_1			0x00070024
-#define CRYPTO4XX_PRNG_RES_2			0x00070028
-#define CRYPTO4XX_PRNG_RES_3			0x0007002C
-
-#define CRYPTO4XX_PRNG_LFSR_L			0x00070030
-#define CRYPTO4XX_PRNG_LFSR_H			0x00070034
-
 /*
  * Initialize CRYPTO ENGINE registers, and memory bases.
  */
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 1c18a5b8470e..6cb33949915f 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -291,8 +291,8 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	return 0;
 error_alg:
 	meson_unregister_algs(mc);
-error_flow:
 	meson_free_chanlist(mc, MAXFLOW - 1);
+error_flow:
 	clk_disable_unprepare(mc->busclk);
 	return err;
 }
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index dbb39ed0cea1..987eadae2007 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -19,6 +19,12 @@
 #include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
+/*
+ * According to review by Bill Cox [1], the ATSHA204 has very low entropy.
+ * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+ */
+static const unsigned short atsha204_quality = 1;
+
 static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
 				   void *areq, int status)
 {
@@ -158,6 +164,7 @@ static const struct attribute_group atmel_sha204a_groups = {
 static int atmel_sha204a_probe(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
+	const unsigned short *quality;
 	int ret;
 
 	ret = atmel_i2c_probe(client);
@@ -171,19 +178,19 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
 
-	/*
-	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
-	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
-	 */
-	i2c_priv->hwrng.quality = 1;
+	quality = i2c_get_match_data(client);
+	if (quality)
+		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
-	if (ret)
-		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
+	if (ret) {
+		dev_err(&client->dev, "failed to register RNG (%d)\n", ret);
+		return ret;
+	}
 
 	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
 	if (ret) {
-		dev_err(&client->dev, "failed to register sysfs entry\n");
+		dev_err(&client->dev, "failed to create sysfs group (%d)\n", ret);
 		return ret;
 	}
 
@@ -203,14 +210,14 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
-	{ .compatible = "atmel,atsha204", },
+	{ .compatible = "atmel,atsha204", .data = &atsha204_quality },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204" },
+	{ "atsha204", (kernel_ulong_t)&atsha204_quality },
 	{ "atsha204a" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 32a6e6e15ee2..ddbd60cf3b3c 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -603,7 +603,7 @@ static int aead_setkey(struct crypto_aead *aead,
 	dev_dbg(jrdev, "keylen %d enckeylen %d authkeylen %d\n",
 	       keys.authkeylen + keys.enckeylen, keys.enckeylen,
 	       keys.authkeylen);
-	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	/*
@@ -639,7 +639,7 @@ static int aead_setkey(struct crypto_aead *aead,
 	dma_sync_single_for_device(jrdev, ctx->key_dma, ctx->adata.keylen_pad +
 				   keys.enckeylen, ctx->dir);
 
-	print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
+	print_hex_dump_devel("ctx.key@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
 			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
@@ -680,7 +680,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 	if (err)
 		return err;
 
-	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -701,7 +701,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	if (err)
 		return err;
 
-	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -727,7 +727,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	if (err)
 		return err;
 
-	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -754,7 +754,7 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	u32 *desc;
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
-	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	/* Here keylen is actual key length */
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 65f6adb6c673..aa779caacfe5 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -212,7 +212,7 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	dev_dbg(jrdev, "keylen %d enckeylen %d authkeylen %d\n",
 		keys.authkeylen + keys.enckeylen, keys.enckeylen,
 		keys.authkeylen);
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	/*
@@ -248,7 +248,7 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 				   ctx->adata.keylen_pad + keys.enckeylen,
 				   ctx->dir);
 
-	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
 			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
@@ -371,7 +371,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -475,7 +475,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -581,7 +581,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -631,7 +631,7 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	const bool is_rfc3686 = alg->caam.rfc3686;
 	int ret = 0;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	ctx->cdata.keylen = keylen;
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index bf10c3dda745..6b47bcc16a50 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -301,7 +301,7 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	dev_dbg(dev, "keylen %d enckeylen %d authkeylen %d\n",
 		keys.authkeylen + keys.enckeylen, keys.enckeylen,
 		keys.authkeylen);
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	ctx->adata.keylen = keys.authkeylen;
@@ -315,7 +315,7 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	memcpy(ctx->key + ctx->adata.keylen_pad, keys.enckey, keys.enckeylen);
 	dma_sync_single_for_device(dev, ctx->key_dma, ctx->adata.keylen_pad +
 				   keys.enckeylen, ctx->dir);
-	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
 			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
@@ -732,7 +732,7 @@ static int gcm_setkey(struct crypto_aead *aead,
 	ret = aes_check_keylen(keylen);
 	if (ret)
 		return ret;
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -828,7 +828,7 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -927,7 +927,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
@@ -955,7 +955,7 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	u32 *desc;
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
-	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	ctx->cdata.keylen = keylen;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index ddb2a35aec2d..3cd71810380f 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -505,7 +505,7 @@ static int axcbc_setkey(struct crypto_ahash *ahash, const u8 *key,
 				   DMA_TO_DEVICE);
 	ctx->adata.keylen = keylen;
 
-	print_hex_dump_debug("axcbc ctx.key@" __stringify(__LINE__)" : ",
+	print_hex_dump_devel("axcbc ctx.key@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key, keylen, 1);
 
 	return axcbc_set_sh_desc(ahash);
@@ -525,7 +525,7 @@ static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 	ctx->adata.key_virt = key;
 	ctx->adata.keylen = keylen;
 
-	print_hex_dump_debug("acmac ctx.key@" __stringify(__LINE__)" : ",
+	print_hex_dump_devel("acmac ctx.key@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	return acmac_set_sh_desc(ahash);
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index 88cc4fe2a585..de2fcc387477 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -58,7 +58,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 
 	dev_dbg(jrdev, "split keylen %d split keylen padded %d\n",
 		adata->keylen, adata->keylen_pad);
-	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen, 1);
 
 	if (local_max > max_keylen)
@@ -113,7 +113,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 		wait_for_completion(&result.completion);
 		ret = result.err;
 
-		print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
+		print_hex_dump_devel("ctx.key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key_out,
 				     adata->keylen_pad, 1);
 	}
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d1e9e0ac63b6..7c4dd57fabb9 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1716,29 +1716,11 @@ static int sev_get_platform_state(int *state, int *error)
 
 static int sev_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_required)
 {
-	struct sev_platform_init_args init_args = {0};
 	int rc;
 
-	rc = _sev_platform_init_locked(&init_args);
-	if (rc) {
-		argp->error = SEV_RET_INVALID_PLATFORM_STATE;
-		return rc;
-	}
-
-	*shutdown_required = true;
-
-	return 0;
-}
-
-static int snp_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_required)
-{
-	int error, rc;
-
-	rc = __sev_snp_init_locked(&error, 0);
-	if (rc) {
-		argp->error = SEV_RET_INVALID_PLATFORM_STATE;
+	rc = __sev_platform_init_locked(&argp->error);
+	if (rc)
 		return rc;
-	}
 
 	*shutdown_required = true;
 
@@ -2440,24 +2422,13 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 
 static int sev_ioctl_do_snp_commit(struct sev_issue_cmd *argp)
 {
-	struct sev_device *sev = psp_master->sev_data;
 	struct sev_data_snp_commit buf;
-	bool shutdown_required = false;
-	int ret, error;
-
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			return ret;
-	}
+	int ret;
 
 	buf.len = sizeof(buf);
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error);
 
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
 	return ret;
 }
 
@@ -2465,8 +2436,6 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_snp_config config;
-	bool shutdown_required = false;
-	int ret, error;
 
 	if (!argp->data)
 		return -EINVAL;
@@ -2474,30 +2443,21 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 	if (!writable)
 		return -EPERM;
 
+	if (!sev->snp_initialized)
+		return -ENODEV;
+
 	if (copy_from_user(&config, (void __user *)argp->data, sizeof(config)))
 		return -EFAULT;
 
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			return ret;
-	}
-
-	ret = __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
-
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
-	return ret;
+	return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
 }
 
 static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_snp_vlek_load input;
-	bool shutdown_required = false;
-	int ret, error;
 	void *blob;
+	int ret;
 
 	if (!argp->data)
 		return -EINVAL;
@@ -2505,6 +2465,9 @@ static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
 	if (!writable)
 		return -EPERM;
 
+	if (!sev->snp_initialized)
+		return -ENODEV;
+
 	if (copy_from_user(&input, u64_to_user_ptr(argp->data), sizeof(input)))
 		return -EFAULT;
 
@@ -2518,18 +2481,7 @@ static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
 
 	input.vlek_wrapped_address = __psp_pa(blob);
 
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			goto cleanup;
-	}
-
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_VLEK_LOAD, &input, &argp->error);
-
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
-cleanup:
 	kfree(blob);
 
 	return ret;
diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 1e6d772f4bb6..8aa23c939775 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -80,6 +80,5 @@ config CRYPTO_DEV_HISI_TRNG
 	tristate "Support for HISI TRNG Driver"
 	depends on ARM64 && ACPI
 	select HW_RANDOM
-	select CRYPTO_RNG
 	help
 	  Support for HiSilicon TRNG Driver.
diff --git a/drivers/crypto/hisilicon/trng/trng.c b/drivers/crypto/hisilicon/trng/trng.c
index 5ca0b90859a8..6584ed051e09 100644
--- a/drivers/crypto/hisilicon/trng/trng.c
+++ b/drivers/crypto/hisilicon/trng/trng.c
@@ -1,234 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
 
-#include <crypto/internal/rng.h>
 #include <linux/acpi.h>
-#include <linux/crypto.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/random.h>
 
 #define HISI_TRNG_REG		0x00F0
 #define HISI_TRNG_BYTES		4
 #define HISI_TRNG_QUALITY	512
-#define HISI_TRNG_VERSION	0x01B8
-#define HISI_TRNG_VER_V1	GENMASK(31, 0)
 #define SLEEP_US		10
 #define TIMEOUT_US		10000
-#define SW_DRBG_NUM_SHIFT	2
-#define SW_DRBG_KEY_BASE	0x082C
-#define SW_DRBG_SEED(n)         (SW_DRBG_KEY_BASE - ((n) << SW_DRBG_NUM_SHIFT))
-#define SW_DRBG_SEED_REGS_NUM	12
-#define SW_DRBG_SEED_SIZE	48
-#define SW_DRBG_BLOCKS		0x0830
-#define SW_DRBG_INIT		0x0834
-#define SW_DRBG_GEN		0x083c
-#define SW_DRBG_STATUS		0x0840
-#define SW_DRBG_BLOCKS_NUM	4095
-#define SW_DRBG_DATA_BASE	0x0850
-#define SW_DRBG_DATA_NUM	4
-#define SW_DRBG_DATA(n)		(SW_DRBG_DATA_BASE - ((n) << SW_DRBG_NUM_SHIFT))
-#define SW_DRBG_BYTES		16
-#define SW_DRBG_ENABLE_SHIFT	12
-#define SEED_SHIFT_24		24
-#define SEED_SHIFT_16		16
-#define SEED_SHIFT_8		8
-#define SW_MAX_RANDOM_BYTES	65520
-
-struct hisi_trng_list {
-	struct mutex lock;
-	struct list_head list;
-	bool is_init;
-};
 
 struct hisi_trng {
 	void __iomem *base;
-	struct hisi_trng_list *trng_list;
-	struct list_head list;
 	struct hwrng rng;
-	u32 ver;
-	u32 ctx_num;
-	/* The bytes of the random number generated since the last seeding. */
-	u32 random_bytes;
-	struct mutex lock;
-};
-
-struct hisi_trng_ctx {
-	struct hisi_trng *trng;
 };
 
-static atomic_t trng_active_devs;
-static struct hisi_trng_list trng_devices;
-static int hisi_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait);
-
-static int hisi_trng_set_seed(struct hisi_trng *trng, const u8 *seed)
-{
-	u32 val, seed_reg, i;
-	int ret;
-
-	writel(0x0, trng->base + SW_DRBG_BLOCKS);
-
-	for (i = 0; i < SW_DRBG_SEED_SIZE;
-	     i += SW_DRBG_SEED_SIZE / SW_DRBG_SEED_REGS_NUM) {
-		val = seed[i] << SEED_SHIFT_24;
-		val |= seed[i + 1UL] << SEED_SHIFT_16;
-		val |= seed[i + 2UL] << SEED_SHIFT_8;
-		val |= seed[i + 3UL];
-
-		seed_reg = (i >> SW_DRBG_NUM_SHIFT) % SW_DRBG_SEED_REGS_NUM;
-		writel(val, trng->base + SW_DRBG_SEED(seed_reg));
-	}
-
-	writel(SW_DRBG_BLOCKS_NUM | (0x1 << SW_DRBG_ENABLE_SHIFT),
-	       trng->base + SW_DRBG_BLOCKS);
-	writel(0x1, trng->base + SW_DRBG_INIT);
-	ret = readl_relaxed_poll_timeout(trng->base + SW_DRBG_STATUS,
-					 val, val & BIT(0), SLEEP_US, TIMEOUT_US);
-	if (ret) {
-		pr_err("failed to init trng(%d)\n", ret);
-		return -EIO;
-	}
-
-	trng->random_bytes = 0;
-
-	return 0;
-}
-
-static int hisi_trng_seed(struct crypto_rng *tfm, const u8 *seed,
-			  unsigned int slen)
-{
-	struct hisi_trng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct hisi_trng *trng = ctx->trng;
-	int ret;
-
-	if (slen < SW_DRBG_SEED_SIZE) {
-		pr_err("slen(%u) is not matched with trng(%d)\n", slen,
-			SW_DRBG_SEED_SIZE);
-		return -EINVAL;
-	}
-
-	mutex_lock(&trng->lock);
-	ret = hisi_trng_set_seed(trng, seed);
-	mutex_unlock(&trng->lock);
-
-	return ret;
-}
-
-static int hisi_trng_reseed(struct hisi_trng *trng)
-{
-	u8 seed[SW_DRBG_SEED_SIZE];
-	int size;
-
-	if (!trng->random_bytes)
-		return 0;
-
-	size = hisi_trng_read(&trng->rng, seed, SW_DRBG_SEED_SIZE, false);
-	if (size != SW_DRBG_SEED_SIZE)
-		return -EIO;
-
-	return hisi_trng_set_seed(trng, seed);
-}
-
-static int hisi_trng_get_bytes(struct hisi_trng *trng, u8 *dstn, unsigned int dlen)
-{
-	u32 data[SW_DRBG_DATA_NUM];
-	u32 currsize = 0;
-	u32 val = 0;
-	int ret;
-	u32 i;
-
-	ret = hisi_trng_reseed(trng);
-	if (ret)
-		return ret;
-
-	do {
-		ret = readl_relaxed_poll_timeout(trng->base + SW_DRBG_STATUS,
-						 val, val & BIT(1), SLEEP_US, TIMEOUT_US);
-		if (ret) {
-			pr_err("failed to generate random number(%d)!\n", ret);
-			break;
-		}
-
-		for (i = 0; i < SW_DRBG_DATA_NUM; i++)
-			data[i] = readl(trng->base + SW_DRBG_DATA(i));
-
-		if (dlen - currsize >= SW_DRBG_BYTES) {
-			memcpy(dstn + currsize, data, SW_DRBG_BYTES);
-			currsize += SW_DRBG_BYTES;
-		} else {
-			memcpy(dstn + currsize, data, dlen - currsize);
-			currsize = dlen;
-		}
-
-		trng->random_bytes += SW_DRBG_BYTES;
-		writel(0x1, trng->base + SW_DRBG_GEN);
-	} while (currsize < dlen);
-
-	return ret;
-}
-
-static int hisi_trng_generate(struct crypto_rng *tfm, const u8 *src,
-			      unsigned int slen, u8 *dstn, unsigned int dlen)
-{
-	struct hisi_trng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct hisi_trng *trng = ctx->trng;
-	unsigned int currsize = 0;
-	unsigned int block_size;
-	int ret;
-
-	if (!dstn || !dlen) {
-		pr_err("output is error, dlen %u!\n", dlen);
-		return -EINVAL;
-	}
-
-	do {
-		block_size = min_t(unsigned int, dlen - currsize, SW_MAX_RANDOM_BYTES);
-		mutex_lock(&trng->lock);
-		ret = hisi_trng_get_bytes(trng, dstn + currsize, block_size);
-		mutex_unlock(&trng->lock);
-		if (ret)
-			return ret;
-		currsize += block_size;
-	} while (currsize < dlen);
-
-	return 0;
-}
-
-static int hisi_trng_init(struct crypto_tfm *tfm)
-{
-	struct hisi_trng_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct hisi_trng *trng;
-	u32 ctx_num = ~0;
-
-	mutex_lock(&trng_devices.lock);
-	list_for_each_entry(trng, &trng_devices.list, list) {
-		if (trng->ctx_num < ctx_num) {
-			ctx_num = trng->ctx_num;
-			ctx->trng = trng;
-		}
-	}
-	ctx->trng->ctx_num++;
-	mutex_unlock(&trng_devices.lock);
-
-	return 0;
-}
-
-static void hisi_trng_exit(struct crypto_tfm *tfm)
-{
-	struct hisi_trng_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	mutex_lock(&trng_devices.lock);
-	ctx->trng->ctx_num--;
-	mutex_unlock(&trng_devices.lock);
-}
-
 static int hisi_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 {
 	struct hisi_trng *trng;
@@ -260,42 +53,6 @@ static int hisi_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 	return currsize;
 }
 
-static struct rng_alg hisi_trng_alg = {
-	.generate = hisi_trng_generate,
-	.seed =	hisi_trng_seed,
-	.seedsize = SW_DRBG_SEED_SIZE,
-	.base = {
-		.cra_name = "stdrng",
-		.cra_driver_name = "hisi_stdrng",
-		.cra_priority = 300,
-		.cra_ctxsize = sizeof(struct hisi_trng_ctx),
-		.cra_module = THIS_MODULE,
-		.cra_init = hisi_trng_init,
-		.cra_exit = hisi_trng_exit,
-	},
-};
-
-static void hisi_trng_add_to_list(struct hisi_trng *trng)
-{
-	mutex_lock(&trng_devices.lock);
-	list_add_tail(&trng->list, &trng_devices.list);
-	mutex_unlock(&trng_devices.lock);
-}
-
-static int hisi_trng_del_from_list(struct hisi_trng *trng)
-{
-	int ret = -EBUSY;
-
-	mutex_lock(&trng_devices.lock);
-	if (!trng->ctx_num) {
-		list_del(&trng->list);
-		ret = 0;
-	}
-	mutex_unlock(&trng_devices.lock);
-
-	return ret;
-}
-
 static int hisi_trng_probe(struct platform_device *pdev)
 {
 	struct hisi_trng *trng;
@@ -305,68 +62,20 @@ static int hisi_trng_probe(struct platform_device *pdev)
 	if (!trng)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, trng);
-
 	trng->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(trng->base))
 		return PTR_ERR(trng->base);
 
-	trng->ctx_num = 0;
-	trng->random_bytes = SW_MAX_RANDOM_BYTES;
-	mutex_init(&trng->lock);
-	trng->ver = readl(trng->base + HISI_TRNG_VERSION);
-	if (!trng_devices.is_init) {
-		INIT_LIST_HEAD(&trng_devices.list);
-		mutex_init(&trng_devices.lock);
-		trng_devices.is_init = true;
-	}
-
-	hisi_trng_add_to_list(trng);
-	if (trng->ver != HISI_TRNG_VER_V1 &&
-	    atomic_inc_return(&trng_active_devs) == 1) {
-		ret = crypto_register_rng(&hisi_trng_alg);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to register crypto(%d)\n", ret);
-			atomic_dec_return(&trng_active_devs);
-			goto err_remove_from_list;
-		}
-	}
-
 	trng->rng.name = pdev->name;
 	trng->rng.read = hisi_trng_read;
 	trng->rng.quality = HISI_TRNG_QUALITY;
+
 	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "failed to register hwrng: %d!\n", ret);
-		goto err_crypto_unregister;
-	}
-
-	return ret;
-
-err_crypto_unregister:
-	if (trng->ver != HISI_TRNG_VER_V1 &&
-	    atomic_dec_return(&trng_active_devs) == 0)
-		crypto_unregister_rng(&hisi_trng_alg);
-
-err_remove_from_list:
-	hisi_trng_del_from_list(trng);
 	return ret;
 }
 
-static void hisi_trng_remove(struct platform_device *pdev)
-{
-	struct hisi_trng *trng = platform_get_drvdata(pdev);
-
-	/* Wait until the task is finished */
-	while (hisi_trng_del_from_list(trng))
-		;
-
-	if (trng->ver != HISI_TRNG_VER_V1 &&
-	    atomic_dec_return(&trng_active_devs) == 0)
-		crypto_unregister_rng(&hisi_trng_alg);
-}
-
 static const struct acpi_device_id hisi_trng_acpi_match[] = {
 	{ "HISI02B3", 0 },
 	{ }
@@ -375,7 +84,6 @@ MODULE_DEVICE_TABLE(acpi, hisi_trng_acpi_match);
 
 static struct platform_driver hisi_trng_driver = {
 	.probe		= hisi_trng_probe,
-	.remove         = hisi_trng_remove,
 	.driver		= {
 		.name	= "hisi-trng-v2",
 		.acpi_match_table = ACPI_PTR(hisi_trng_acpi_match),
diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index cfa00daeb4fb..3acbbb586dc0 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -146,8 +146,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	pci_set_master(pdev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state.\n");
 		ret = -ENOMEM;
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index c9be5dcddb27..f33182c101e2 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -148,8 +148,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	pci_set_master(pdev);
-
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state.\n");
 		ret = -ENOMEM;
diff --git a/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
index c52462a48c34..ab62b91ecb51 100644
--- a/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
@@ -189,8 +189,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	pci_set_master(pdev);
-
 	/*
 	 * The PCI config space is saved at this point and will be restored
 	 * after a Function Level Reset (FLR) as the FLR does not completely
diff --git a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
index bceb5dd8b148..c745397e63a5 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c
@@ -167,7 +167,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
diff --git a/drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c
index c622793e94a8..b31c58fdfb58 100644
--- a/drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c
@@ -163,7 +163,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
 	init_completion(&accel_dev->vf.msg_received);
 
diff --git a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
index 23ccb72b6ea2..941400c64d4b 100644
--- a/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c62x/adf_drv.c
@@ -167,7 +167,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
diff --git a/drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c
index 4840d44bbd5b..631eb2b41150 100644
--- a/drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c
@@ -163,7 +163,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
 	init_completion(&accel_dev->vf.msg_received);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index cbd1d1eda5a3..58cf98fadb6c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -475,6 +475,8 @@ struct adf_accel_dev {
 		struct {
 			/* protects VF2PF interrupts access */
 			spinlock_t vf2pf_ints_lock;
+			/* prevents VF2PF handling from racing with VF state teardown */
+			bool vf2pf_disabled;
 			/* vf_info is non-zero when SR-IOV is init'ed */
 			struct adf_accel_vf_info *vf_info;
 		} pf;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index ed01fb9ad74e..3fc7d13e882c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -17,6 +17,58 @@ struct adf_fatal_error_data {
 static struct workqueue_struct *device_reset_wq;
 static struct workqueue_struct *device_sriov_wq;
 
+static pci_ers_result_t reset_prepare(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	if (!accel_dev) {
+		dev_err(&pdev->dev, "Can't find acceleration device\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	if (!adf_dev_started(accel_dev))
+		return PCI_ERS_RESULT_CAN_RECOVER;
+
+	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
+	if (accel_dev->hw_device->exit_arb) {
+		dev_dbg(&pdev->dev, "Disabling arbitration\n");
+		accel_dev->hw_device->exit_arb(accel_dev);
+	}
+	adf_dev_restarting_notify(accel_dev);
+	adf_dev_down(accel_dev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t reset_done(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+	int res;
+
+	if (!accel_dev) {
+		dev_err(&pdev->dev, "Can't find acceleration device\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	if (!adf_devmgr_in_reset(accel_dev))
+		goto reset_complete;
+
+	pci_restore_state(pdev);
+	res = adf_dev_up(accel_dev, false);
+	if (res && res != -EALREADY)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	adf_reenable_sriov(accel_dev);
+	adf_pf2vf_notify_restarted(accel_dev);
+	adf_dev_restarted_notify(accel_dev);
+	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
+
+reset_complete:
+	dev_info(&pdev->dev, "Device reset completed successfully\n");
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static pci_ers_result_t adf_error_detected(struct pci_dev *pdev,
 					   pci_channel_state_t state)
 {
@@ -33,18 +85,10 @@ static pci_ers_result_t adf_error_detected(struct pci_dev *pdev,
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
-	if (accel_dev->hw_device->exit_arb) {
-		dev_dbg(&pdev->dev, "Disabling arbitration\n");
-		accel_dev->hw_device->exit_arb(accel_dev);
-	}
 	adf_error_notifier(accel_dev);
 	adf_pf2vf_notify_fatal_error(accel_dev);
-	adf_dev_restarting_notify(accel_dev);
-	pci_clear_master(pdev);
-	adf_dev_down(accel_dev);
 
-	return PCI_ERS_RESULT_NEED_RESET;
+	return reset_prepare(pdev);
 }
 
 /* reset dev data */
@@ -106,6 +150,13 @@ void adf_dev_restore(struct adf_accel_dev *accel_dev)
 	}
 }
 
+void adf_set_bme(struct adf_accel_dev *accel_dev)
+{
+	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
+
+	pci_set_master(pdev);
+}
+
 static void adf_device_sriov_worker(struct work_struct *work)
 {
 	struct adf_sriov_dev_data *sriov_data =
@@ -156,13 +207,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 	struct adf_reset_dev_data *reset_data;
 
 	if (!adf_dev_started(accel_dev) ||
-	    test_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
+	    test_and_set_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
 		return 0;
 
-	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 	reset_data = kzalloc_obj(*reset_data);
-	if (!reset_data)
+	if (!reset_data) {
+		clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 		return -ENOMEM;
+	}
 	reset_data->accel_dev = accel_dev;
 	init_completion(&reset_data->compl);
 	reset_data->mode = mode;
@@ -190,26 +242,7 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 
 static pci_ers_result_t adf_slot_reset(struct pci_dev *pdev)
 {
-	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
-	int res = 0;
-
-	if (!accel_dev) {
-		pr_err("QAT: Can't find acceleration device\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	if (!pdev->is_busmaster)
-		pci_set_master(pdev);
-	pci_restore_state(pdev);
-	res = adf_dev_up(accel_dev, false);
-	if (res && res != -EALREADY)
-		return PCI_ERS_RESULT_DISCONNECT;
-
-	adf_reenable_sriov(accel_dev);
-	adf_pf2vf_notify_restarted(accel_dev);
-	adf_dev_restarted_notify(accel_dev);
-	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
-	return PCI_ERS_RESULT_RECOVERED;
+	return reset_done(pdev);
 }
 
 static void adf_resume(struct pci_dev *pdev)
@@ -218,10 +251,22 @@ static void adf_resume(struct pci_dev *pdev)
 	dev_info(&pdev->dev, "Device is up and running\n");
 }
 
+static void adf_reset_prepare(struct pci_dev *pdev)
+{
+	reset_prepare(pdev);
+}
+
+static void adf_reset_done(struct pci_dev *pdev)
+{
+	reset_done(pdev);
+}
+
 const struct pci_error_handlers adf_err_handler = {
 	.error_detected = adf_error_detected,
 	.slot_reset = adf_slot_reset,
 	.resume = adf_resume,
+	.reset_prepare = adf_reset_prepare,
+	.reset_done = adf_reset_done,
 };
 EXPORT_SYMBOL_GPL(adf_err_handler);
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 8ff35dd840f3..db26e0b31170 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -84,6 +84,7 @@ extern const struct pci_error_handlers adf_err_handler;
 void adf_reset_sbr(struct adf_accel_dev *accel_dev);
 void adf_reset_flr(struct adf_accel_dev *accel_dev);
 void adf_dev_restore(struct adf_accel_dev *accel_dev);
+void adf_set_bme(struct adf_accel_dev *accel_dev);
 int adf_init_aer(void);
 void adf_exit_aer(void);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
@@ -118,6 +119,7 @@ void qat_comp_alg_callback(void *resp);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
@@ -191,6 +193,7 @@ int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
 void adf_reenable_sriov(struct adf_accel_dev *accel_dev);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask);
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 num_vfs);
 void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index f8088388cf12..1c7f9e49914d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -74,6 +74,8 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 		return -EFAULT;
 	}
 
+	adf_set_bme(accel_dev);
+
 	if (!test_bit(ADF_STATUS_CONFIGURED, &accel_dev->status) &&
 	    !accel_dev->is_vf) {
 		dev_err(&GET_DEV(accel_dev), "Device not configured\n");
@@ -153,15 +155,18 @@ static int adf_dev_init(struct adf_accel_dev *accel_dev)
 	 * This is to facilitate any ordering dependencies between services
 	 * prior to starting any of the accelerators.
 	 */
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_INIT)) {
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to initialise service %s\n",
 				service->name);
+			mutex_unlock(&service_lock);
 			return -EFAULT;
 		}
 		set_bit(accel_dev->accel_id, service->init_status);
 	}
+	mutex_unlock(&service_lock);
 
 	return 0;
 }
@@ -231,15 +236,18 @@ static int adf_dev_start(struct adf_accel_dev *accel_dev)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to start service %s\n",
 				service->name);
+			mutex_unlock(&service_lock);
 			return -EFAULT;
 		}
 		set_bit(accel_dev->accel_id, service->start_status);
 	}
+	mutex_unlock(&service_lock);
 
 	clear_bit(ADF_STATUS_STARTING, &accel_dev->status);
 	set_bit(ADF_STATUS_STARTED, &accel_dev->status);
@@ -313,6 +321,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 		qat_comp_algs_unregister(hw_data->accel_capabilities_ext_mask);
 	clear_bit(ADF_STATUS_COMP_ALGS_REGISTERED, &accel_dev->status);
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (!test_bit(accel_dev->accel_id, service->start_status))
 			continue;
@@ -324,6 +333,7 @@ static void adf_dev_stop(struct adf_accel_dev *accel_dev)
 			clear_bit(accel_dev->accel_id, service->start_status);
 		}
 	}
+	mutex_unlock(&service_lock);
 
 	if (hw_data->stop_timer)
 		hw_data->stop_timer(accel_dev);
@@ -373,6 +383,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 				  &accel_dev->status);
 	}
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (!test_bit(accel_dev->accel_id, service->init_status))
 			continue;
@@ -383,6 +394,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 		else
 			clear_bit(accel_dev->accel_id, service->init_status);
 	}
+	mutex_unlock(&service_lock);
 
 	adf_rl_exit(accel_dev);
 
@@ -417,12 +429,14 @@ int adf_dev_restarting_notify(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_RESTARTING))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to restart service %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 	return 0;
 }
 
@@ -430,12 +444,14 @@ int adf_dev_restarted_notify(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_RESTARTED))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to restart service %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 	return 0;
 }
 
@@ -443,12 +459,14 @@ void adf_error_notifier(struct adf_accel_dev *accel_dev)
 {
 	struct service_hndl *service;
 
+	mutex_lock(&service_lock);
 	list_for_each_entry(service, &service_table, list) {
 		if (service->event_hld(accel_dev, ADF_EVENT_FATAL_ERROR))
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to send error event to %s.\n",
 				service->name);
 	}
+	mutex_unlock(&service_lock);
 }
 
 int adf_dev_down(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
index 4639d7fd93e6..159e91a50106 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
@@ -62,6 +62,23 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	if (!READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		GET_PFVF_OPS(accel_dev)->enable_vf2pf_interrupts(pmisc_addr, vf_mask);
+	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
+}
+
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 num_vfs)
+{
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	unsigned long flags;
+	u32 vf_mask;
+
+	vf_mask = BIT_ULL(num_vfs) - 1;
+	if (!vf_mask)
+		return;
+
+	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, false);
 	GET_PFVF_OPS(accel_dev)->enable_vf2pf_interrupts(pmisc_addr, vf_mask);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
@@ -72,6 +89,7 @@ void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, true);
 	GET_PFVF_OPS(accel_dev)->disable_all_vf2pf_interrupts(pmisc_addr);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
@@ -174,6 +192,27 @@ static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
 	return IRQ_NONE;
 }
 
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev)
+{
+	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u32 num_entries = pci_dev_info->msix_entries.num_entries;
+	struct adf_irq *irqs = pci_dev_info->msix_entries.irqs;
+	u32 irq_idx;
+	int irq;
+
+	if (!test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status) || !irqs)
+		return;
+
+	irq_idx = num_entries > 1 ? hw_data->num_banks : 0;
+	if (irq_idx >= num_entries || !irqs[irq_idx].enabled)
+		return;
+
+	irq = pci_irq_vector(pci_dev_info->pci_dev, hw_data->num_banks);
+	if (irq > 0)
+		synchronize_irq(irq);
+}
+
 static void adf_free_irqs(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
index 8bf0fe1fcb4d..f2011300a929 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
@@ -26,6 +26,9 @@ static void adf_iov_send_resp(struct work_struct *work)
 	u32 vf_nr = vf_info->vf_nr;
 	bool ret;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		goto out;
+
 	mutex_lock(&vf_info->pfvf_mig_lock);
 	ret = adf_recv_and_handle_vf2pf_msg(accel_dev, vf_nr);
 	if (ret)
@@ -33,13 +36,18 @@ static void adf_iov_send_resp(struct work_struct *work)
 		adf_enable_vf2pf_interrupts(accel_dev, 1 << vf_nr);
 	mutex_unlock(&vf_info->pfvf_mig_lock);
 
+out:
 	kfree(pf2vf_resp);
 }
 
 void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
 {
+	struct adf_accel_dev *accel_dev = vf_info->accel_dev;
 	struct adf_pf2vf_resp *pf2vf_resp;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		return;
+
 	pf2vf_resp = kzalloc_obj(*pf2vf_resp, GFP_ATOMIC);
 	if (!pf2vf_resp)
 		return;
@@ -49,6 +57,12 @@ void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
 	queue_work(pf2vf_resp_wq, &pf2vf_resp->pf2vf_resp_work);
 }
 
+static void adf_flush_pf2vf_resp_wq(void)
+{
+	if (pf2vf_resp_wq)
+		flush_workqueue(pf2vf_resp_wq);
+}
+
 static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
@@ -75,7 +89,11 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 		hw_data->configure_iov_threads(accel_dev, true);
 
 	/* Enable VF to PF interrupts for all VFs */
-	adf_enable_vf2pf_interrupts(accel_dev, BIT_ULL(totalvfs) - 1);
+	adf_enable_all_vf2pf_interrupts(accel_dev, totalvfs);
+
+	/* Do not enable SR-IOV if already enabled */
+	if (pci_num_vf(pdev))
+		return 0;
 
 	/*
 	 * Due to the hardware design, when SR-IOV and the ring arbiter
@@ -246,10 +264,18 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 
 	adf_pf2vf_notify_restarting(accel_dev);
 	adf_pf2vf_wait_for_restarting_complete(accel_dev);
-	pci_disable_sriov(accel_to_pci_dev(accel_dev));
+	/*
+	 * When the device is restarting, preserve VF PCI devices across
+	 * the reset by skipping pci_disable_sriov(). VFs are notified to
+	 * quiesce regardless so the PF can safely shut down.
+	 */
+	if (!test_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
+		pci_disable_sriov(accel_to_pci_dev(accel_dev));
 
-	/* Disable VF to PF interrupts */
+	/* Block VF2PF work and disable VF to PF interrupts */
 	adf_disable_all_vf2pf_interrupts(accel_dev);
+	adf_isr_sync_ae_cluster(accel_dev);
+	adf_flush_pf2vf_resp_wq();
 
 	/* Clear Valid bits in AE Thread to PCIe Function Mapping */
 	if (hw_data->configure_iov_threads)
diff --git a/drivers/crypto/intel/qat/qat_common/qat_asym_algs.c b/drivers/crypto/intel/qat/qat_common/qat_asym_algs.c
index e09b9edfce42..75c15c8e41db 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_asym_algs.c
@@ -1085,7 +1085,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->p;
 	len = rsa_key->p_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto err;
 	ctx->p = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_p, GFP_KERNEL);
 	if (!ctx->p)
@@ -1096,7 +1096,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->q;
 	len = rsa_key->q_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_p;
 	ctx->q = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_q, GFP_KERNEL);
 	if (!ctx->q)
@@ -1107,7 +1107,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->dp;
 	len = rsa_key->dp_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_q;
 	ctx->dp = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_dp,
 				     GFP_KERNEL);
@@ -1119,7 +1119,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->dq;
 	len = rsa_key->dq_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_dp;
 	ctx->dq = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_dq,
 				     GFP_KERNEL);
@@ -1131,7 +1131,7 @@ static void qat_rsa_setkey_crt(struct qat_rsa_ctx *ctx, struct rsa_key *rsa_key)
 	ptr = rsa_key->qinv;
 	len = rsa_key->qinv_sz;
 	qat_rsa_drop_leading_zeros(&ptr, &len);
-	if (!len)
+	if (!len || len > half_key_sz)
 		goto free_dq;
 	ctx->qinv = dma_alloc_coherent(dev, half_key_sz, &ctx->dma_qinv,
 				       GFP_KERNEL);
diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
index b59e0cc49e52..99a6bf9e2b00 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
@@ -167,7 +167,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
diff --git a/drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c
index 7cd528ee31e7..e3eab03ad65b 100644
--- a/drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c
@@ -163,7 +163,6 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			goto out_err_free_reg;
 		}
 	}
-	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
 	init_completion(&accel_dev->vf.msg_received);
 
diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
deleted file mode 100644
index 15475da8fc11..000000000000
--- a/drivers/crypto/loongson/Kconfig
+++ /dev/null
@@ -1,5 +0,0 @@
-config CRYPTO_DEV_LOONGSON_RNG
-	tristate "Support for Loongson RNG Driver"
-	depends on MFD_LOONGSON_SE
-	help
-	  Support for Loongson RNG Driver.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
deleted file mode 100644
index 1ce5ec32b553..000000000000
--- a/drivers/crypto/loongson/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)  += loongson-rng.o
diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
deleted file mode 100644
index 3a4940260f9e..000000000000
--- a/drivers/crypto/loongson/loongson-rng.c
+++ /dev/null
@@ -1,209 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2019 HiSilicon Limited. */
-/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
-
-#include <linux/crypto.h>
-#include <linux/err.h>
-#include <linux/hw_random.h>
-#include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/mfd/loongson-se.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/platform_device.h>
-#include <linux/random.h>
-#include <crypto/internal/rng.h>
-
-#define SE_SEED_SIZE 32
-
-struct loongson_rng_list {
-	struct mutex lock;
-	struct list_head list;
-	int registered;
-};
-
-struct loongson_rng {
-	u32 used;
-	struct loongson_se_engine *engine;
-	struct list_head list;
-	struct mutex lock;
-};
-
-struct loongson_rng_ctx {
-	struct loongson_rng *rng;
-};
-
-struct loongson_rng_cmd {
-	u32 cmd_id;
-	union {
-		u32 len;
-		u32 ret;
-	} u;
-	u32 seed_off;
-	u32 out_off;
-	u32 pad[4];
-};
-
-static struct loongson_rng_list rng_devices = {
-	.lock = __MUTEX_INITIALIZER(rng_devices.lock),
-	.list = LIST_HEAD_INIT(rng_devices.list),
-};
-
-static int loongson_rng_generate(struct crypto_rng *tfm, const u8 *src,
-			  unsigned int slen, u8 *dstn, unsigned int dlen)
-{
-	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct loongson_rng *rng = ctx->rng;
-	struct loongson_rng_cmd *cmd = rng->engine->command;
-	int err, len;
-
-	mutex_lock(&rng->lock);
-	cmd->seed_off = 0;
-	do {
-		len = min(dlen, rng->engine->buffer_size);
-		cmd = rng->engine->command;
-		cmd->u.len = len;
-		err = loongson_se_send_engine_cmd(rng->engine);
-		if (err)
-			break;
-
-		cmd = rng->engine->command_ret;
-		if (cmd->u.ret) {
-			err = -EIO;
-			break;
-		}
-
-		memcpy(dstn, rng->engine->data_buffer, len);
-		dlen -= len;
-		dstn += len;
-	} while (dlen > 0);
-	mutex_unlock(&rng->lock);
-
-	return err;
-}
-
-static int loongson_rng_init(struct crypto_tfm *tfm)
-{
-	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct loongson_rng *rng;
-	u32 min_used = U32_MAX;
-
-	mutex_lock(&rng_devices.lock);
-	list_for_each_entry(rng, &rng_devices.list, list) {
-		if (rng->used < min_used) {
-			ctx->rng = rng;
-			min_used = rng->used;
-		}
-	}
-	ctx->rng->used++;
-	mutex_unlock(&rng_devices.lock);
-
-	return 0;
-}
-
-static void loongson_rng_exit(struct crypto_tfm *tfm)
-{
-	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	mutex_lock(&rng_devices.lock);
-	ctx->rng->used--;
-	mutex_unlock(&rng_devices.lock);
-}
-
-static int loongson_rng_seed(struct crypto_rng *tfm, const u8 *seed,
-			     unsigned int slen)
-{
-	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct loongson_rng *rng = ctx->rng;
-	struct loongson_rng_cmd *cmd;
-	int err;
-
-	if (slen < SE_SEED_SIZE)
-		return -EINVAL;
-
-	slen = min(slen, rng->engine->buffer_size);
-
-	mutex_lock(&rng->lock);
-	cmd = rng->engine->command;
-	cmd->u.len = slen;
-	cmd->seed_off = rng->engine->buffer_off;
-	memcpy(rng->engine->data_buffer, seed, slen);
-	err = loongson_se_send_engine_cmd(rng->engine);
-	if (err)
-		goto out;
-
-	cmd = rng->engine->command_ret;
-	if (cmd->u.ret)
-		err = -EIO;
-out:
-	mutex_unlock(&rng->lock);
-
-	return err;
-}
-
-static struct rng_alg loongson_rng_alg = {
-	.generate = loongson_rng_generate,
-	.seed =	loongson_rng_seed,
-	.seedsize = SE_SEED_SIZE,
-	.base = {
-		.cra_name = "stdrng",
-		.cra_driver_name = "loongson_stdrng",
-		.cra_priority = 300,
-		.cra_ctxsize = sizeof(struct loongson_rng_ctx),
-		.cra_module = THIS_MODULE,
-		.cra_init = loongson_rng_init,
-		.cra_exit = loongson_rng_exit,
-	},
-};
-
-static int loongson_rng_probe(struct platform_device *pdev)
-{
-	struct loongson_rng_cmd *cmd;
-	struct loongson_rng *rng;
-	int ret = 0;
-
-	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
-	if (!rng)
-		return -ENOMEM;
-
-	rng->engine = loongson_se_init_engine(pdev->dev.parent, SE_ENGINE_RNG);
-	if (!rng->engine)
-		return -ENODEV;
-	cmd = rng->engine->command;
-	cmd->cmd_id = SE_CMD_RNG;
-	cmd->out_off = rng->engine->buffer_off;
-	mutex_init(&rng->lock);
-
-	mutex_lock(&rng_devices.lock);
-
-	if (!rng_devices.registered) {
-		ret = crypto_register_rng(&loongson_rng_alg);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
-			goto out;
-		}
-		rng_devices.registered = 1;
-	}
-
-	list_add_tail(&rng->list, &rng_devices.list);
-out:
-	mutex_unlock(&rng_devices.lock);
-
-	return ret;
-}
-
-static struct platform_driver loongson_rng_driver = {
-	.probe		= loongson_rng_probe,
-	.driver		= {
-		.name	= "loongson-rng",
-	},
-};
-module_platform_driver(loongson_rng_driver);
-
-MODULE_ALIAS("platform:loongson-rng");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
-MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
-MODULE_DESCRIPTION("Loongson Random Number Generator driver");
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index bc61d0fe3514..4b53b13f96d9 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -12,7 +12,6 @@
  * All rights reserved.
  */
 
-#include <linux/workqueue.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -255,6 +254,46 @@ static int init_device(struct device *dev)
 	return 0;
 }
 
+static void dma_map_request(struct device *dev, struct talitos_request *request,
+			    struct talitos_desc *desc, bool is_sec1)
+{
+	struct talitos_edesc *edesc =
+		container_of(desc, struct talitos_edesc, desc);
+	dma_addr_t dma_desc, prev_dma_desc;
+	struct talitos_edesc *prev_edesc = NULL;
+
+	if (is_sec1) {
+		while (edesc) {
+			edesc->desc.hdr1 = edesc->desc.hdr;
+
+			dma_desc = dma_map_single(dev, &edesc->desc.hdr1,
+						  TALITOS_DESC_SIZE,
+						  DMA_BIDIRECTIONAL);
+
+			if (!prev_edesc) {
+				request->dma_desc = dma_desc;
+				goto next;
+			}
+
+			/* Chain in any previous descriptors. */
+
+			prev_edesc->desc.next_desc = cpu_to_be32(dma_desc);
+
+			dma_sync_single_for_device(dev, prev_dma_desc,
+						   TALITOS_DESC_SIZE,
+						   DMA_TO_DEVICE);
+
+next:
+			prev_edesc = edesc;
+			prev_dma_desc = dma_desc;
+			edesc = edesc->next_desc;
+		}
+	} else {
+		request->dma_desc = dma_map_single(dev, desc, TALITOS_DESC_SIZE,
+						   DMA_BIDIRECTIONAL);
+	}
+}
+
 /**
  * talitos_submit - submits a descriptor to the device for processing
  * @dev:	the SEC device to be used
@@ -291,16 +330,7 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 	request = &priv->chan[ch].fifo[head];
 
 	/* map descriptor and save caller data */
-	if (is_sec1) {
-		desc->hdr1 = desc->hdr;
-		request->dma_desc = dma_map_single(dev, &desc->hdr1,
-						   TALITOS_DESC_SIZE,
-						   DMA_BIDIRECTIONAL);
-	} else {
-		request->dma_desc = dma_map_single(dev, desc,
-						   TALITOS_DESC_SIZE,
-						   DMA_BIDIRECTIONAL);
-	}
+	dma_map_request(dev, request, desc, is_sec1);
 	request->callback = callback;
 	request->context = context;
 
@@ -322,19 +352,51 @@ static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 	return -EINPROGRESS;
 }
 
-static __be32 get_request_hdr(struct talitos_request *request, bool is_sec1)
+static __be32 get_request_hdr(struct device *dev,
+			      struct talitos_request *request, bool is_sec1)
 {
 	struct talitos_edesc *edesc;
+	dma_addr_t dma_desc;
 
-	if (!is_sec1)
-		return request->desc->hdr;
+	if (!is_sec1) {
+		dma_sync_single_for_cpu(dev, request->dma_desc,
+					TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
 
-	if (!request->desc->next_desc)
-		return request->desc->hdr1;
+		return request->desc->hdr;
+	}
 
 	edesc = container_of(request->desc, struct talitos_edesc, desc);
+	dma_desc = request->dma_desc;
+	while (edesc->next_desc) {
+		dma_desc = be32_to_cpu(edesc->desc.next_desc);
+		edesc = edesc->next_desc;
+	}
+
+	dma_sync_single_for_cpu(dev, dma_desc, TALITOS_DESC_SIZE,
+				DMA_BIDIRECTIONAL);
+
+	return edesc->desc.hdr1;
+}
 
-	return ((struct talitos_desc *)(edesc->buf + edesc->dma_len))->hdr1;
+static void dma_unmap_request(struct device *dev,
+			      struct talitos_request *request, bool is_sec1)
+{
+	struct talitos_edesc *edesc;
+
+	if (is_sec1) {
+		dma_unmap_single(dev, request->dma_desc, TALITOS_DESC_SIZE,
+				 DMA_BIDIRECTIONAL);
+		edesc = container_of(request->desc, struct talitos_edesc, desc);
+		while (edesc->next_desc) {
+			dma_unmap_single(dev,
+					 be32_to_cpu(edesc->desc.next_desc),
+					 TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+			edesc = edesc->next_desc;
+		}
+	} else {
+		dma_unmap_single(dev, request->dma_desc, TALITOS_DESC_SIZE,
+				 DMA_BIDIRECTIONAL);
+	}
 }
 
 /*
@@ -358,7 +420,7 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 
 		/* descriptors with their done bits set don't get the error */
 		rmb();
-		hdr = get_request_hdr(request, is_sec1);
+		hdr = get_request_hdr(dev, request, is_sec1);
 
 		if ((hdr & DESC_HDR_DONE) == DESC_HDR_DONE)
 			status = 0;
@@ -368,9 +430,7 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
 			else
 				status = error;
 
-		dma_unmap_single(dev, request->dma_desc,
-				 TALITOS_DESC_SIZE,
-				 DMA_BIDIRECTIONAL);
+		dma_unmap_request(dev, request, is_sec1);
 
 		/* copy entries so we can call callback outside lock */
 		saved_req.desc = request->desc;
@@ -459,14 +519,35 @@ DEF_TALITOS2_DONE(ch0, TALITOS2_ISR_CH_0_DONE)
 DEF_TALITOS2_DONE(ch0_2, TALITOS2_ISR_CH_0_2_DONE)
 DEF_TALITOS2_DONE(ch1_3, TALITOS2_ISR_CH_1_3_DONE)
 
+static __be32 search_desc_hdr_in_request(struct talitos_request *request,
+					 dma_addr_t cur_desc, bool is_sec1)
+{
+	struct talitos_edesc *edesc;
+
+	if (request->dma_desc == cur_desc) {
+		return request->desc->hdr;
+	} else if (is_sec1) {
+		edesc = container_of(request->desc, struct talitos_edesc, desc);
+		while (edesc->next_desc) {
+			if (edesc->desc.next_desc == cpu_to_be32(cur_desc))
+				return edesc->next_desc->desc.hdr1;
+			edesc = edesc->next_desc;
+		}
+	}
+	return 0;
+}
+
 /*
  * locate current (offending) descriptor
  */
 static __be32 current_desc_hdr(struct device *dev, int ch)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
+	bool is_sec1 = has_ftr_sec1(priv);
+	struct talitos_request *request;
 	int tail, iter;
 	dma_addr_t cur_desc;
+	__be32 hdr = 0;
 
 	cur_desc = ((u64)in_be32(priv->chan[ch].reg + TALITOS_CDPR)) << 32;
 	cur_desc |= in_be32(priv->chan[ch].reg + TALITOS_CDPR_LO);
@@ -477,27 +558,21 @@ static __be32 current_desc_hdr(struct device *dev, int ch)
 	}
 
 	tail = priv->chan[ch].tail;
-
 	iter = tail;
-	while (priv->chan[ch].fifo[iter].dma_desc != cur_desc &&
-	       priv->chan[ch].fifo[iter].desc->next_desc != cpu_to_be32(cur_desc)) {
-		iter = (iter + 1) & (priv->fifo_len - 1);
-		if (iter == tail) {
-			dev_err(dev, "couldn't locate current descriptor\n");
-			return 0;
-		}
-	}
+	do {
+		request = &priv->chan[ch].fifo[iter];
 
-	if (priv->chan[ch].fifo[iter].desc->next_desc == cpu_to_be32(cur_desc)) {
-		struct talitos_edesc *edesc;
+		hdr = search_desc_hdr_in_request(request, cur_desc, is_sec1);
+		if (hdr)
+			break;
 
-		edesc = container_of(priv->chan[ch].fifo[iter].desc,
-				     struct talitos_edesc, desc);
-		return ((struct talitos_desc *)
-			(edesc->buf + edesc->dma_len))->hdr;
-	}
+		iter = (iter + 1) & (priv->fifo_len - 1);
+	} while (iter != tail);
 
-	return priv->chan[ch].fifo[iter].desc->hdr;
+	if (!hdr)
+		dev_err(dev, "couldn't locate current descriptor\n");
+
+	return hdr;
 }
 
 /*
@@ -869,28 +944,20 @@ struct talitos_ahash_req_ctx {
 	u8 buf[2][HASH_MAX_BLOCK_SIZE];
 	int buf_idx;
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first_request;
 	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 	struct scatterlist bufsl[2];
 	struct scatterlist *psrc;
-
-	struct scatterlist request_bufsl[2];
-	struct ahash_request *areq;
-	struct scatterlist *request_sl;
-	unsigned int remaining_ahash_request_bytes;
-	unsigned int current_ahash_request_bytes;
-	struct work_struct sec1_ahash_process_remaining;
 };
 
 struct talitos_export_state {
 	u32 hw_context[TALITOS_MDEU_MAX_CONTEXT_SIZE / sizeof(u32)];
 	u8 buf[HASH_MAX_BLOCK_SIZE];
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first_request;
+	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 };
@@ -1396,10 +1463,6 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 		dma_len = 0;
 	}
 	alloc_len += icv_stashing ? authsize : 0;
-
-	/* if its a ahash, add space for a second desc next to the first one */
-	if (is_sec1 && !dst)
-		alloc_len += sizeof(struct talitos_desc);
 	alloc_len += ivsize;
 
 	edesc = kmalloc(ALIGN(alloc_len, dma_get_cache_alignment()), flags);
@@ -1415,6 +1478,7 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 	edesc->dst_nents = dst_nents;
 	edesc->iv_dma = iv_dma;
 	edesc->dma_len = dma_len;
+	edesc->next_desc = NULL;
 	if (dma_len)
 		edesc->dma_link_tbl = dma_map_single(dev, &edesc->link_tbl[0],
 						     edesc->dma_len,
@@ -1715,39 +1779,37 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 	struct talitos_desc *desc = &edesc->desc;
-	struct talitos_desc *desc2 = (struct talitos_desc *)
-				     (edesc->buf + edesc->dma_len);
 
 	unmap_single_talitos_ptr(dev, &desc->ptr[5], DMA_FROM_DEVICE);
-	if (desc->next_desc &&
-	    desc->ptr[5].ptr != desc2->ptr[5].ptr)
-		unmap_single_talitos_ptr(dev, &desc2->ptr[5], DMA_FROM_DEVICE);
-	if (req_ctx->last_desc)
+
+	if (edesc->last && req_ctx->last_request)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
 
-	if (req_ctx->psrc)
-		talitos_sg_unmap(dev, edesc, req_ctx->psrc, NULL, 0, 0);
+	if (edesc->src)
+		talitos_sg_unmap(dev, edesc, edesc->src, NULL, 0, 0);
 
 	/* When using hashctx-in, must unmap it. */
 	if (from_talitos_ptr_len(&desc->ptr[1], is_sec1))
 		unmap_single_talitos_ptr(dev, &desc->ptr[1],
 					 DMA_TO_DEVICE);
-	else if (desc->next_desc)
-		unmap_single_talitos_ptr(dev, &desc2->ptr[1],
-					 DMA_TO_DEVICE);
-
-	if (is_sec1 && req_ctx->nbuf)
-		unmap_single_talitos_ptr(dev, &desc->ptr[3],
-					 DMA_TO_DEVICE);
 
 	if (edesc->dma_len)
 		dma_unmap_single(dev, edesc->dma_link_tbl, edesc->dma_len,
 				 DMA_BIDIRECTIONAL);
+}
+
+static void free_edesc_list_from(struct ahash_request *areq, struct talitos_edesc *edesc)
+{
+	struct talitos_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
+	struct talitos_edesc *next;
 
-	if (desc->next_desc)
-		dma_unmap_single(dev, be32_to_cpu(desc->next_desc),
-				 TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+	while (edesc) {
+		next = edesc->next_desc;
+		common_nonsnoop_hash_unmap(ctx->dev, edesc, areq);
+		kfree(edesc);
+		edesc = next;
+	}
 }
 
 static void ahash_done(struct device *dev,
@@ -1758,30 +1820,46 @@ static void ahash_done(struct device *dev,
 	struct talitos_edesc *edesc =
 		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	bool is_sec1 = has_ftr_sec1(dev_get_drvdata(dev));
+	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct talitos_edesc *next;
 
-	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
-		/* Position any partial block for next update/final/finup */
-		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
-		req_ctx->nbuf = req_ctx->to_hash_later;
-	}
-	common_nonsnoop_hash_unmap(dev, edesc, areq);
-
-	kfree(edesc);
+	if (is_sec1) {
+		if (!req_ctx->last_request && req_ctx->to_hash_later) {
+			/* Position any partial block for next update/final/finup */
+			req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
+			req_ctx->nbuf = req_ctx->to_hash_later;
+		}
 
-	if (err) {
+		free_edesc_list_from(areq, edesc);
 		ahash_request_complete(areq, err);
-		return;
-	}
+	} else {
+		next = edesc->next_desc;
 
-	req_ctx->remaining_ahash_request_bytes -=
-		req_ctx->current_ahash_request_bytes;
+		common_nonsnoop_hash_unmap(dev, edesc, areq);
+		kfree(edesc);
 
-	if (!req_ctx->remaining_ahash_request_bytes) {
-		ahash_request_complete(areq, 0);
-		return;
-	}
+		if (err)
+			goto out;
 
-	schedule_work(&req_ctx->sec1_ahash_process_remaining);
+		if (next) {
+			err = talitos_submit(dev, ctx->ch, &next->desc,
+					     ahash_done, areq);
+			if (err != -EINPROGRESS)
+				goto out;
+			return;
+		}
+out:
+		if (!req_ctx->last_request && req_ctx->to_hash_later) {
+			/* Position any partial block for next update/final/finup */
+			req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
+			req_ctx->nbuf = req_ctx->to_hash_later;
+		}
+		if (err && next)
+			free_edesc_list_from(areq, next);
+		ahash_request_complete(areq, err);
+	}
 }
 
 /*
@@ -1805,18 +1883,15 @@ static void talitos_handle_buggy_hash(struct talitos_ctx *ctx,
 			       (char *)padded_hash, DMA_TO_DEVICE);
 }
 
-static int common_nonsnoop_hash(struct talitos_edesc *edesc,
-				struct ahash_request *areq, unsigned int length,
-				void (*callback) (struct device *dev,
-						  struct talitos_desc *desc,
-						  void *context, int error))
+static void common_nonsnoop_hash(struct talitos_edesc *edesc,
+				 struct ahash_request *areq,
+				 unsigned int length)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 	struct device *dev = ctx->dev;
 	struct talitos_desc *desc = &edesc->desc;
-	int ret;
 	bool sync_needed = false;
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -1825,7 +1900,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!req_ctx->first_desc || req_ctx->swinit) {
+	if (!edesc->first || !req_ctx->first_request || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1833,40 +1908,31 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	}
 	/* Indicate next op is not the first. */
-	req_ctx->first_desc = 0;
+	req_ctx->first_request = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
 		to_talitos_ptr(&desc->ptr[2], ctx->dma_key, ctx->keylen,
 			       is_sec1);
 
-	if (is_sec1 && req_ctx->nbuf)
-		length -= req_ctx->nbuf;
-
 	sg_count = edesc->src_nents ?: 1;
 	if (is_sec1 && sg_count > 1)
-		sg_copy_to_buffer(req_ctx->psrc, sg_count, edesc->buf, length);
+		sg_copy_to_buffer(edesc->src, sg_count, edesc->buf, length);
 	else if (length)
-		sg_count = dma_map_sg(dev, req_ctx->psrc, sg_count,
-				      DMA_TO_DEVICE);
+		sg_count = dma_map_sg(dev, edesc->src, sg_count, DMA_TO_DEVICE);
+
 	/*
 	 * data in
 	 */
-	if (is_sec1 && req_ctx->nbuf) {
-		map_single_talitos_ptr(dev, &desc->ptr[3], req_ctx->nbuf,
-				       req_ctx->buf[req_ctx->buf_idx],
-				       DMA_TO_DEVICE);
-	} else {
-		sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
-					  &desc->ptr[3], sg_count, 0, 0);
-		if (sg_count > 1)
-			sync_needed = true;
-	}
+	sg_count = talitos_sg_map(dev, edesc->src, length, edesc, &desc->ptr[3],
+				  sg_count, 0, 0);
+	if (sg_count > 1)
+		sync_needed = true;
 
 	/* fifth DWORD empty */
 
 	/* hash/HMAC out -or- hash context out */
-	if (req_ctx->last_desc)
+	if (edesc->last && req_ctx->last_request)
 		map_single_talitos_ptr(dev, &desc->ptr[5],
 				       crypto_ahash_digestsize(tfm),
 				       req_ctx->hw_context, DMA_FROM_DEVICE);
@@ -1881,73 +1947,94 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) == 0)
 		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
 
-	if (is_sec1 && req_ctx->nbuf && length) {
-		struct talitos_desc *desc2 = (struct talitos_desc *)
-					     (edesc->buf + edesc->dma_len);
-		dma_addr_t next_desc;
-
-		memset(desc2, 0, sizeof(*desc2));
-		desc2->hdr = desc->hdr;
-		desc2->hdr &= ~DESC_HDR_MODE0_MDEU_INIT;
-		desc2->hdr1 = desc2->hdr;
-		desc->hdr &= ~DESC_HDR_MODE0_MDEU_PAD;
-		desc->hdr |= DESC_HDR_MODE0_MDEU_CONT;
-		desc->hdr &= ~DESC_HDR_DONE_NOTIFY;
-
-		if (desc->ptr[1].ptr)
-			copy_talitos_ptr(&desc2->ptr[1], &desc->ptr[1],
-					 is_sec1);
-		else
-			map_single_talitos_ptr_nosync(dev, &desc2->ptr[1],
-						      req_ctx->hw_context_size,
-						      req_ctx->hw_context,
-						      DMA_TO_DEVICE);
-		copy_talitos_ptr(&desc2->ptr[2], &desc->ptr[2], is_sec1);
-		sg_count = talitos_sg_map(dev, req_ctx->psrc, length, edesc,
-					  &desc2->ptr[3], sg_count, 0, 0);
-		if (sg_count > 1)
-			sync_needed = true;
-		copy_talitos_ptr(&desc2->ptr[5], &desc->ptr[5], is_sec1);
-		if (req_ctx->last_desc)
-			map_single_talitos_ptr_nosync(dev, &desc->ptr[5],
-						      req_ctx->hw_context_size,
-						      req_ctx->hw_context,
-						      DMA_FROM_DEVICE);
-
-		next_desc = dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,
-					   DMA_BIDIRECTIONAL);
-		desc->next_desc = cpu_to_be32(next_desc);
-	}
-
 	if (sync_needed)
 		dma_sync_single_for_device(dev, edesc->dma_link_tbl,
 					   edesc->dma_len, DMA_BIDIRECTIONAL);
-
-	ret = talitos_submit(dev, ctx->ch, desc, callback, areq);
-	if (ret != -EINPROGRESS) {
-		common_nonsnoop_hash_unmap(dev, edesc, areq);
-		kfree(edesc);
-	}
-	return ret;
 }
 
 static struct talitos_edesc *ahash_edesc_alloc(struct ahash_request *areq,
+					       struct scatterlist *src,
 					       unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	return talitos_edesc_alloc(ctx->dev, src, NULL, NULL, 0,
+				   nbytes, 0, 0, 0, areq->base.flags, false);
+}
+
+static struct talitos_edesc *
+ahash_process_req_prepare(struct ahash_request *areq, unsigned int nbytes,
+			  unsigned int blocksize, bool is_sec1)
+{
+	struct talitos_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	struct talitos_private *priv = dev_get_drvdata(ctx->dev);
-	bool is_sec1 = has_ftr_sec1(priv);
+	struct talitos_edesc *first = NULL, *prev_edesc = NULL, *edesc;
+	size_t desc_max = is_sec1 ? TALITOS1_MAX_DATA_LEN :
+				    TALITOS2_MAX_DATA_LEN;
+	struct scatterlist tmp[2];
+	size_t to_hash_this_desc;
+	struct scatterlist *src;
+	size_t offset = 0;
+
+	do {
+		src = scatterwalk_ffwd(tmp, req_ctx->psrc, offset);
+
+		to_hash_this_desc =
+			min(nbytes, ALIGN_DOWN(desc_max, blocksize));
+
+		/* Allocate extended descriptor */
+		edesc = ahash_edesc_alloc(areq, src, to_hash_this_desc);
+		if (IS_ERR(edesc)) {
+			if (first)
+				free_edesc_list_from(areq, first);
+			return edesc;
+		}
 
-	if (is_sec1)
-		nbytes -= req_ctx->nbuf;
+		edesc->src =
+			scatterwalk_ffwd(edesc->bufsl, req_ctx->psrc, offset);
+		edesc->desc.hdr = ctx->desc_hdr_template;
+		edesc->first = offset == 0;
+		edesc->last = nbytes - to_hash_this_desc == 0;
 
-	return talitos_edesc_alloc(ctx->dev, req_ctx->psrc, NULL, NULL, 0,
-				   nbytes, 0, 0, 0, areq->base.flags, false);
+		/* On last one, request SEC to pad; otherwise continue */
+		if (req_ctx->last_request && edesc->last)
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
+		else
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
+
+		/* request SEC to INIT hash. */
+		if (req_ctx->first_request && edesc->first && !req_ctx->swinit)
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
+
+		/*
+		 * When the tfm context has a keylen, it's an HMAC.
+		 * A first or last (ie. not middle) descriptor must request HMAC.
+		 */
+		if (ctx->keylen && ((req_ctx->first_request && edesc->first) ||
+				    (req_ctx->last_request && edesc->last)))
+			edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
+
+		/* clear the DN bit  */
+		if (is_sec1 && !edesc->last)
+			edesc->desc.hdr &= ~DESC_HDR_DONE_NOTIFY;
+
+		common_nonsnoop_hash(edesc, areq, to_hash_this_desc);
+
+		offset += to_hash_this_desc;
+		nbytes -= to_hash_this_desc;
+
+		if (!prev_edesc)
+			first = edesc;
+		else
+			prev_edesc->next_desc = edesc;
+		prev_edesc = edesc;
+	} while (nbytes);
+
+	return first;
 }
 
-static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes)
+static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
@@ -1955,23 +2042,23 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	struct talitos_edesc *edesc;
 	unsigned int blocksize =
 			crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	bool is_sec1 = has_ftr_sec1(dev_get_drvdata(ctx->dev));
 	unsigned int nbytes_to_hash;
 	unsigned int to_hash_later;
 	unsigned int nsg;
 	int nents;
 	struct device *dev = ctx->dev;
-	struct talitos_private *priv = dev_get_drvdata(dev);
-	bool is_sec1 = has_ftr_sec1(priv);
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
+	int ret;
 
-	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
+	if (!req_ctx->last_request && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
-		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
+		nents = sg_nents_for_len(areq->src, nbytes);
 		if (nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
 			return nents;
 		}
-		sg_copy_to_buffer(req_ctx->request_sl, nents,
+		sg_copy_to_buffer(areq->src, nents,
 				  ctx_buf + req_ctx->nbuf, nbytes);
 		req_ctx->nbuf += nbytes;
 		return 0;
@@ -1981,7 +2068,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	nbytes_to_hash = nbytes + req_ctx->nbuf;
 	to_hash_later = nbytes_to_hash & (blocksize - 1);
 
-	if (req_ctx->last_desc)
+	if (req_ctx->last_request)
 		to_hash_later = 0;
 	else if (to_hash_later)
 		/* There is a partial block. Hash the full block(s) now */
@@ -1993,123 +2080,39 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	}
 
 	/* Chain in any previously buffered data */
-	if (!is_sec1 && req_ctx->nbuf) {
+	if (req_ctx->nbuf) {
 		nsg = (req_ctx->nbuf < nbytes_to_hash) ? 2 : 1;
 		sg_init_table(req_ctx->bufsl, nsg);
 		sg_set_buf(req_ctx->bufsl, ctx_buf, req_ctx->nbuf);
 		if (nsg > 1)
-			sg_chain(req_ctx->bufsl, 2, req_ctx->request_sl);
+			sg_chain(req_ctx->bufsl, 2, areq->src);
 		req_ctx->psrc = req_ctx->bufsl;
-	} else if (is_sec1 && req_ctx->nbuf && req_ctx->nbuf < blocksize) {
-		int offset;
-
-		if (nbytes_to_hash > blocksize)
-			offset = blocksize - req_ctx->nbuf;
-		else
-			offset = nbytes_to_hash - req_ctx->nbuf;
-		nents = sg_nents_for_len(req_ctx->request_sl, offset);
-		if (nents < 0) {
-			dev_err(dev, "Invalid number of src SG.\n");
-			return nents;
-		}
-		sg_copy_to_buffer(req_ctx->request_sl, nents,
-				  ctx_buf + req_ctx->nbuf, offset);
-		req_ctx->nbuf += offset;
-		req_ctx->psrc = scatterwalk_ffwd(req_ctx->bufsl, req_ctx->request_sl,
-						 offset);
 	} else
-		req_ctx->psrc = req_ctx->request_sl;
+		req_ctx->psrc = areq->src;
 
 	if (to_hash_later) {
-		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
+		nents = sg_nents_for_len(areq->src, nbytes);
 		if (nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
 			return nents;
 		}
-		sg_pcopy_to_buffer(req_ctx->request_sl, nents,
+		sg_pcopy_to_buffer(areq->src, nents,
 				   req_ctx->buf[(req_ctx->buf_idx + 1) & 1],
 				      to_hash_later,
 				      nbytes - to_hash_later);
 	}
 	req_ctx->to_hash_later = to_hash_later;
 
-	/* Allocate extended descriptor */
-	edesc = ahash_edesc_alloc(req_ctx->areq, nbytes_to_hash);
+	edesc = ahash_process_req_prepare(areq, nbytes_to_hash, blocksize,
+					  is_sec1);
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
-	edesc->desc.hdr = ctx->desc_hdr_template;
-
-	/* On last one, request SEC to pad; otherwise continue */
-	if (req_ctx->last_desc)
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
-	else
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
-
-	/* request SEC to INIT hash. */
-	if (req_ctx->first_desc && !req_ctx->swinit)
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
-
-	/* When the tfm context has a keylen, it's an HMAC.
-	 * A first or last (ie. not middle) descriptor must request HMAC.
-	 */
-	if (ctx->keylen && (req_ctx->first_desc || req_ctx->last_desc))
-		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
-
-	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
-}
-
-static void sec1_ahash_process_remaining(struct work_struct *work)
-{
-	struct talitos_ahash_req_ctx *req_ctx =
-		container_of(work, struct talitos_ahash_req_ctx,
-			     sec1_ahash_process_remaining);
-	int err = 0;
-
-	req_ctx->request_sl = scatterwalk_ffwd(req_ctx->request_bufsl,
-					       req_ctx->request_sl, TALITOS1_MAX_DATA_LEN);
+	ret = talitos_submit(dev, ctx->ch, &edesc->desc, ahash_done, areq);
+	if (ret != -EINPROGRESS)
+		free_edesc_list_from(areq, edesc);
 
-	if (req_ctx->remaining_ahash_request_bytes > TALITOS1_MAX_DATA_LEN)
-		req_ctx->current_ahash_request_bytes = TALITOS1_MAX_DATA_LEN;
-	else {
-		req_ctx->current_ahash_request_bytes =
-			req_ctx->remaining_ahash_request_bytes;
-
-		if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
-	}
-
-	err = ahash_process_req_one(req_ctx->areq,
-				    req_ctx->current_ahash_request_bytes);
-
-	if (err != -EINPROGRESS)
-		ahash_request_complete(req_ctx->areq, err);
-}
-
-static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct talitos_ctx *ctx = crypto_ahash_ctx(tfm);
-	struct device *dev = ctx->dev;
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	struct talitos_private *priv = dev_get_drvdata(dev);
-	bool is_sec1 = has_ftr_sec1(priv);
-
-	req_ctx->areq = areq;
-	req_ctx->request_sl = areq->src;
-	req_ctx->remaining_ahash_request_bytes = nbytes;
-
-	if (is_sec1) {
-		if (nbytes > TALITOS1_MAX_DATA_LEN)
-			nbytes = TALITOS1_MAX_DATA_LEN;
-		else if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
-	}
-
-	req_ctx->current_ahash_request_bytes = nbytes;
-
-	return ahash_process_req_one(req_ctx->areq,
-				     req_ctx->current_ahash_request_bytes);
+	return ret;
 }
 
 static int ahash_init(struct ahash_request *areq)
@@ -2124,15 +2127,13 @@ static int ahash_init(struct ahash_request *areq)
 	/* Initialize the context */
 	req_ctx->buf_idx = 0;
 	req_ctx->nbuf = 0;
-	req_ctx->first_desc = 1; /* first_desc indicates h/w must init its context */
+	req_ctx->first_request = 1;
 	req_ctx->swinit = 0; /* assume h/w init of context */
 	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
 			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
 			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
 	req_ctx->hw_context_size = size;
 	req_ctx->last_request = 0;
-	req_ctx->last_desc = 0;
-	INIT_WORK(&req_ctx->sec1_ahash_process_remaining, sec1_ahash_process_remaining);
 
 	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
 			     DMA_TO_DEVICE);
@@ -2224,8 +2225,8 @@ static int ahash_export(struct ahash_request *areq, void *out)
 	       req_ctx->hw_context_size);
 	memcpy(export->buf, req_ctx->buf[req_ctx->buf_idx], req_ctx->nbuf);
 	export->swinit = req_ctx->swinit;
-	export->first_desc = req_ctx->first_desc;
-	export->last_desc = req_ctx->last_desc;
+	export->first_request = req_ctx->first_request;
+	export->last_request = req_ctx->last_request;
 	export->to_hash_later = req_ctx->to_hash_later;
 	export->nbuf = req_ctx->nbuf;
 
@@ -2250,8 +2251,8 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	memcpy(req_ctx->hw_context, export->hw_context, size);
 	memcpy(req_ctx->buf[0], export->buf, export->nbuf);
 	req_ctx->swinit = export->swinit;
-	req_ctx->first_desc = export->first_desc;
-	req_ctx->last_desc = export->last_desc;
+	req_ctx->first_request = export->first_request;
+	req_ctx->last_request = export->last_request;
 	req_ctx->to_hash_later = export->to_hash_later;
 	req_ctx->nbuf = export->nbuf;
 
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 1a93ee355929..11f0eb6a41db 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -44,11 +44,17 @@ struct talitos_desc {
 
 /*
  * talitos_edesc - s/w-extended descriptor
+ * @bufsl: scatterlist buffer
+ * @src: pointer to input scatterlist
+ * @first: first descriptor of a chain
+ * @last: last descriptor of a chain
+ *
  * @src_nents: number of segments in input scatterlist
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @dma_len: length of dma mapped link_tbl space
  * @dma_link_tbl: bus physical address of link_tbl/buf
+ * @next_desc: next descriptor
  * @desc: h/w descriptor
  * @link_tbl: input and output h/w link tables (if {src,dst}_nents > 1) (SEC2)
  * @buf: input and output buffeur (if {src,dst}_nents > 1) (SEC1)
@@ -58,11 +64,17 @@ struct talitos_desc {
  * of link_tbl data
  */
 struct talitos_edesc {
+	struct scatterlist bufsl[2];
+	struct scatterlist *src;
+	int first;
+	int last;
+
 	int src_nents;
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int dma_len;
 	dma_addr_t dma_link_tbl;
+	struct talitos_edesc *next_desc;
 	struct talitos_desc desc;
 	union {
 		DECLARE_FLEX_ARRAY(struct talitos_ptr, link_tbl);
diff --git a/drivers/crypto/tegra/tegra-se-main.c b/drivers/crypto/tegra/tegra-se-main.c
index eb71113ed146..e8d8c3a23d7a 100644
--- a/drivers/crypto/tegra/tegra-se-main.c
+++ b/drivers/crypto/tegra/tegra-se-main.c
@@ -180,7 +180,7 @@ int tegra_se_host1x_submit(struct tegra_se *se, struct tegra_se_cmdbuf *cmdbuf,
 				 MAX_SCHEDULE_TIMEOUT, NULL);
 	if (ret) {
 		dev_err(se->dev, "host1x job timed out\n");
-		return ret;
+		goto job_put;
 	}
 
 	host1x_job_put(job);
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 94b8ecb892bb..2f94be1df525 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -40,6 +40,7 @@ struct udmabuf {
 	struct folio **pinned_folios;
 
 	struct sg_table *sg;
+	enum dma_data_direction sg_dir;
 	struct miscdevice *device;
 	pgoff_t *offsets;
 };
@@ -162,7 +163,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 		sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
 			     ubuf->offsets[i]);
 
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
 		goto err_map;
 	return sg;
@@ -177,7 +178,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
@@ -235,7 +236,7 @@ static void release_udmabuf(struct dma_buf *buf)
 	struct device *dev = ubuf->device->this_device;
 
 	if (ubuf->sg)
-		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
+		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
 
 	deinit_udmabuf(ubuf);
 	kfree(ubuf);
@@ -253,6 +254,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 		if (IS_ERR(ubuf->sg)) {
 			ret = PTR_ERR(ubuf->sg);
 			ubuf->sg = NULL;
+		} else {
+			ubuf->sg_dir = direction;
 		}
 	} else {
 		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 63df35444214..de6c52dbd9d2 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -79,6 +79,7 @@ static struct res_config *res_cfg;
 static int retry_rd_err_log;
 static int decoding_via_mca;
 static bool mem_cfg_2lm;
+static bool no_adxl;
 
 static struct reg_rrl icx_reg_rrl_ddr = {
 	.set_num = 2,
@@ -1222,8 +1223,14 @@ static int __init i10nm_init(void)
 	}
 
 	rc = skx_adxl_get();
-	if (rc)
-		goto fail;
+	if (rc) {
+		/* Decoding errors via MCA banks for 2LM isn't supported yet */
+		if (rc != -ENODEV || mem_cfg_2lm)
+			goto fail;
+		i10nm_printk(KERN_INFO, "ADXL not found, falling back to MCA-based decoding.\n");
+		no_adxl = true;
+		decoding_via_mca = true;
+	}
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
@@ -1257,7 +1264,8 @@ static void __exit i10nm_exit(void)
 
 	skx_teardown_debug();
 	mce_unregister_decode_chain(&i10nm_mce_dec);
-	skx_adxl_put();
+	if (!no_adxl)
+		skx_adxl_put();
 	skx_remove();
 }
 
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338dbe..097a97eeea66 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 50fafeda8d7e..3b7ebcf12fe7 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -95,7 +95,7 @@ struct sprd_eic {
 	struct notifier_block irq_nb;
 	void __iomem *base[SPRD_EIC_MAX_BANK];
 	enum sprd_eic_type type;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	int irq;
 };
 
@@ -149,7 +149,7 @@ static void sprd_eic_update(struct gpio_chip *chip, unsigned int offset,
 	unsigned long flags;
 	u32 tmp;
 
-	spin_lock_irqsave(&sprd_eic->lock, flags);
+	raw_spin_lock_irqsave(&sprd_eic->lock, flags);
 	tmp = readl_relaxed(base + reg);
 
 	if (val)
@@ -158,7 +158,7 @@ static void sprd_eic_update(struct gpio_chip *chip, unsigned int offset,
 		tmp &= ~BIT(SPRD_EIC_BIT(offset));
 
 	writel_relaxed(tmp, base + reg);
-	spin_unlock_irqrestore(&sprd_eic->lock, flags);
+	raw_spin_unlock_irqrestore(&sprd_eic->lock, flags);
 }
 
 static int sprd_eic_read(struct gpio_chip *chip, unsigned int offset, u16 reg)
@@ -628,7 +628,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	if (!sprd_eic)
 		return -ENOMEM;
 
-	spin_lock_init(&sprd_eic->lock);
+	raw_spin_lock_init(&sprd_eic->lock);
 	sprd_eic->type = pdata->type;
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 966d16a6d515..5e361742a11a 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -39,7 +39,7 @@
 struct sch_gpio {
 	struct gpio_chip chip;
 	void __iomem *regs;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned short resume_base;
 
 	/* GPE handling */
@@ -104,9 +104,9 @@ static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned int gpio_num)
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 1);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 	return 0;
 }
 
@@ -122,9 +122,9 @@ static int sch_gpio_set(struct gpio_chip *gc, unsigned int gpio_num, int val)
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GLV, val);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	return 0;
 }
@@ -135,9 +135,9 @@ static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 0);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	/*
 	 * according to the datasheet, writing to the level register has no
@@ -196,14 +196,14 @@ static int sch_irq_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 
 	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
 	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
 
 	irq_set_handler_locked(d, handle_edge_irq);
 
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	return 0;
 }
@@ -215,9 +215,9 @@ static void sch_irq_ack(struct irq_data *d)
 	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GTS, 1);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static void sch_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t gpio_num, int val)
@@ -225,9 +225,9 @@ static void sch_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t gpio_num,
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GGPE, val);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static void sch_irq_mask(struct irq_data *d)
@@ -268,12 +268,12 @@ static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 	int offset;
 	u32 ret;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	raw_spin_lock_irqsave(&sch->lock, flags);
 
 	core_status = ioread32(sch->regs + CORE_BANK_OFFSET + GTS);
 	resume_status = ioread32(sch->regs + RESUME_BANK_OFFSET + GTS);
 
-	spin_unlock_irqrestore(&sch->lock, flags);
+	raw_spin_unlock_irqrestore(&sch->lock, flags);
 
 	pending = (resume_status << sch->resume_base) | core_status;
 	for_each_set_bit(offset, &pending, sch->chip.ngpio)
@@ -343,7 +343,7 @@ static int sch_gpio_probe(struct platform_device *pdev)
 
 	sch->regs = regs;
 
-	spin_lock_init(&sch->lock);
+	raw_spin_lock_init(&sch->lock);
 	sch->chip = sch_gpio_chip;
 	sch->chip.label = dev_name(dev);
 	sch->chip.parent = dev;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 958fd78080bd..c2d854c7af99 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -230,29 +230,26 @@ nvkm_vmm_unref_sptes(struct nvkm_vmm_iter *it, struct nvkm_vmm_pt *pgt,
 		 * covered by a number of LPTEs, the LPTEs once again take
 		 * control over their address range.
 		 *
-		 * Determine how many LPTEs need to transition state.
+		 * Transition each LPTE individually as each may have a
+		 * different target state (sparse, invalid, or valid).
 		 */
-		pgt->pte[ptei].s.spte_valid = false;
-		for (ptes = 1, ptei++; ptei < lpti; ptes++, ptei++) {
+		for (ptei++; ptei < lpti; ptei++) {
 			if (pgt->pte[ptei].s.sptes)
 				break;
-			pgt->pte[ptei].s.spte_valid = false;
 		}
 
-		if (pgt->pte[pteb].s.sparse) {
-			TRA(it, "LPTE %05x: U -> S %d PTEs", pteb, ptes);
-			pair->func->sparse(vmm, pgt->pt[0], pteb, ptes);
-		} else if (!pgt->pte[pteb].s.lpte_valid) {
-			if (pair->func->invalid) {
-				/* If the MMU supports it, restore the LPTE to the
-				 * INVALID state to tell the MMU there is no point
-				 * trying to fetch the corresponding SPTEs.
-				 */
-				TRA(it, "LPTE %05x: U -> I %d PTEs", pteb, ptes);
-				pair->func->invalid(vmm, pgt->pt[0], pteb, ptes);
+		while (pteb < ptei) {
+			pgt->pte[pteb].s.spte_valid = false;
+			if (pgt->pte[pteb].s.sparse) {
+				TRA(it, "LPTE %05x: U -> S", pteb);
+				pair->func->sparse(vmm, pgt->pt[0], pteb, 1);
+			} else if (!pgt->pte[pteb].s.lpte_valid) {
+				if (pair->func->invalid) {
+					TRA(it, "LPTE %05x: U -> I", pteb);
+					pair->func->invalid(vmm, pgt->pt[0], pteb, 1);
+				}
 			}
-		} else {
-			TRA(it, "LPTE %05x: V %d PTEs", pteb, ptes);
+			pteb++;
 		}
 	}
 }
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 5e8ced7bc05a..adaa44a858ed 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -109,9 +109,10 @@ struct appleir {
 	struct hid_device *hid;
 	unsigned short keymap[ARRAY_SIZE(appleir_key_table)];
 	struct timer_list key_up_timer;	/* timer for key up */
-	spinlock_t lock;		/* protects .current_key */
+	spinlock_t lock;		/* protects .current_key, .removing */
 	int current_key;		/* the currently pressed key */
 	int prev_key_idx;		/* key index in a 2 packets message */
+	bool removing;			/* set during teardown; gates input_dev access */
 };
 
 static int get_key(int data)
@@ -172,7 +173,7 @@ static void key_up_tick(struct timer_list *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&appleir->lock, flags);
-	if (appleir->current_key) {
+	if (!appleir->removing && appleir->current_key) {
 		key_up(hid, appleir, appleir->current_key);
 		appleir->current_key = 0;
 	}
@@ -195,6 +196,10 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 		int index;
 
 		spin_lock_irqsave(&appleir->lock, flags);
+		if (appleir->removing) {
+			spin_unlock_irqrestore(&appleir->lock, flags);
+			goto out;
+		}
 		/*
 		 * If we already have a key down, take it up before marking
 		 * this one down
@@ -229,17 +234,25 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	appleir->prev_key_idx = 0;
 
 	if (!memcmp(data, keyrepeat, sizeof(keyrepeat))) {
-		key_down(hid, appleir, appleir->current_key);
-		/*
-		 * Remote doesn't do key up, either pull them up, in the test
-		 * above, or here set a timer which pulls them up after 1/8 s
-		 */
-		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing) {
+			key_down(hid, appleir, appleir->current_key);
+			/*
+			 * Remote doesn't do key up, either pull them up, in
+			 * the test above, or here set a timer which pulls them
+			 * up after 1/8 s
+			 */
+			mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		}
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		goto out;
 	}
 
 	if (!memcmp(data, flatbattery, sizeof(flatbattery))) {
-		battery_flat(appleir);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing)
+			battery_flat(appleir);
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		/* Fall through */
 	}
 
@@ -318,8 +331,20 @@ static int appleir_probe(struct hid_device *hid, const struct hid_device_id *id)
 static void appleir_remove(struct hid_device *hid)
 {
 	struct appleir *appleir = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	/*
+	 * Mark the driver as tearing down so that any concurrent raw_event
+	 * (e.g. from a USB URB completion that hid_hw_stop() has not yet
+	 * killed) and the key_up_timer softirq stop touching input_dev
+	 * before hid_hw_stop() frees it via hidinput_disconnect().
+	 */
+	spin_lock_irqsave(&appleir->lock, flags);
+	appleir->removing = true;
+	spin_unlock_irqrestore(&appleir->lock, flags);
+
+	timer_shutdown_sync(&appleir->key_up_timer);
 	hid_hw_stop(hid);
-	timer_delete_sync(&appleir->key_up_timer);
 }
 
 static const struct hid_device_id appleir_devices[] = {
diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 80c0288a3a38..288cb827e9d6 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_device *hid,
 	memcpy(tmp_buf + tx_len, args, args_len);
 	tx_len += args_len;
 
+	if (tx_len + len > sizeof(tmp_buf))
+		return -EINVAL;
+
 	memcpy(tmp_buf + tx_len, buf, len);
 	tx_len += len;
 
diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index e0c9d5ec9451..318b1152ff8b 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2405,6 +2405,15 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 
 static void hid_go_cfg_remove(struct hid_device *hdev)
 {
+	/*
+	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
+	 * and dereferences drvdata.hdev.  Drain it here before tearing
+	 * down so the workqueue cannot run after hid_destroy_device()'s
+	 * put_device() has released the underlying hdev and dereference
+	 * a stale drvdata.hdev pointer.
+	 */
+	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
+
 	guard(mutex)(&drvdata.cfg_mutex);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
index 11e21f988723..b52e93a91ae5 100644
--- a/drivers/hid/hid-letsketch.c
+++ b/drivers/hid/hid-letsketch.c
@@ -296,13 +296,42 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
 
 	ret = letsketch_setup_input_tablet(data);
 	if (ret)
-		return ret;
+		goto err_shutdown_timer;
 
 	ret = letsketch_setup_input_tablet_pad(data);
 	if (ret)
-		return ret;
+		goto err_shutdown_timer;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		goto err_shutdown_timer;
 
-	return hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	return 0;
+
+err_shutdown_timer:
+	/*
+	 * Drain any pending callback and permanently disable the timer
+	 * before devm releases data: if hid_hw_start() enabled I/O on an
+	 * always-poll-quirk device and then failed, raw_event may have
+	 * armed the timer already.
+	 */
+	timer_shutdown_sync(&data->inrange_timer);
+	return ret;
+}
+
+static void letsketch_remove(struct hid_device *hdev)
+{
+	struct letsketch_data *data = hid_get_drvdata(hdev);
+
+	/*
+	 * hid_hw_stop() synchronously kills the URBs that deliver
+	 * raw_event(), so once it returns no path can re-arm
+	 * inrange_timer.  timer_shutdown_sync() then drains any
+	 * in-flight callback and permanently disables further
+	 * mod_timer() calls before devm releases data.
+	 */
+	hid_hw_stop(hdev);
+	timer_shutdown_sync(&data->inrange_timer);
 }
 
 static const struct hid_device_id letsketch_devices[] = {
@@ -315,6 +344,7 @@ static struct hid_driver letsketch_driver = {
 	.name = "letsketch",
 	.id_table = letsketch_devices,
 	.probe = letsketch_probe,
+	.remove = letsketch_remove,
 	.raw_event = letsketch_raw_event,
 };
 module_hid_driver(letsketch_driver);
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 1a88bc44ada4..02ef3e2094b4 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -1374,11 +1374,27 @@ static const struct hid_device_id lg_g15_devices[] = {
 };
 MODULE_DEVICE_TABLE(hid, lg_g15_devices);
 
+static void lg_g15_remove(struct hid_device *hdev)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+
+	/*
+	 * g15->work is only initialized for the models that schedule it
+	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
+	 * cancel it when it was set up.
+	 */
+	if (g15 && g15->work.func)
+		cancel_work_sync(&g15->work);
+
+	hid_hw_stop(hdev);
+}
+
 static struct hid_driver lg_g15_driver = {
 	.name			= "lg-g15",
 	.id_table		= lg_g15_devices,
 	.raw_event		= lg_g15_raw_event,
 	.probe			= lg_g15_probe,
+	.remove			= lg_g15_remove,
 };
 module_hid_driver(lg_g15_driver);
 
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 381e4dc5aba7..9c574ab8b60b 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1907,8 +1907,13 @@ static int logi_dj_probe(struct hid_device *hdev,
 	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
 	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
 
-	if (rep && (rep->maxfield < 1 ||
-		    rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1)) {
+	if (rep && rep->maxfield < 1) {
+		hid_err(hdev, "Expected size of DJ short report is %d, but got 0",
+			DJREPORT_SHORT_LENGTH - 1);
+		return -EINVAL;
+	}
+
+	if (rep && rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
 		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
 			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
 		return -EINVAL;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index eeab0b6e32cc..b085bed874bf 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -31,6 +31,7 @@
  * [1] https://gitlab.freedesktop.org/libevdev/hid-tools
  */
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/hid.h>
@@ -97,8 +98,7 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
-#define MT_IO_FLAGS_RUNNING		32
+#define MT_IO_FLAGS_RUNNING		0
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -174,10 +174,9 @@ struct mt_device {
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
-					 * first 8 bits are reserved for keeping the slot
-					 * states, this is fine because we only support up
-					 * to 250 slots (MT_MAX_MAXCONTACT)
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING) */
+	unsigned long *active_slots;	/* bitmap of slots with an active
+					 * contact, sized for maxcontacts
 					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
@@ -1033,7 +1032,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1244,9 +1243,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(slotnum, &td->mt_io_flags);
+		set_bit(slotnum, td->active_slots);
 	} else {
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 	}
 
 	return 0;
@@ -1381,7 +1380,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+		if (!bitmap_empty(td->active_slots, td->maxcontacts))
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1440,6 +1439,15 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_pressurepad)
 		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 
+	if (!td->active_slots) {
+		td->active_slots = devm_kcalloc(&td->hdev->dev,
+						BITS_TO_LONGS(td->maxcontacts),
+						sizeof(long),
+						GFP_KERNEL);
+		if (!td->active_slots)
+			return -ENOMEM;
+	}
+
 	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
 					       BITS_TO_LONGS(td->maxcontacts),
 					       sizeof(long),
@@ -1917,7 +1925,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
-				clear_bit(i, &td->mt_io_flags);
+				clear_bit(i, td->active_slots);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1940,7 +1948,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+	if (!bitmap_empty(td->active_slots, td->maxcontacts))
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 90666ff629de..34f710c465b8 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -286,6 +286,54 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 }
 EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer)
+{
+	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
+	struct hid_report *report;
+	unsigned long flags;
+	long cycles;
+	int ret;
+
+	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
+	if (!report)
+		return -EINVAL;
+
+	mutex_lock(hsdev->mutex_ptr);
+	if (flag == SENSOR_HUB_SYNC) {
+		memset(&hsdev->pending, 0, sizeof(hsdev->pending));
+		init_completion(&hsdev->pending.ready);
+		hsdev->pending.usage_id = usage_id;
+		hsdev->pending.attr_usage_id = attr_usage_id;
+		hsdev->pending.max_raw_size = buffer_size;
+		hsdev->pending.raw_data = buffer;
+
+		spin_lock_irqsave(&data->lock, flags);
+		hsdev->pending.status = true;
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
+	mutex_lock(&data->mutex);
+	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
+	mutex_unlock(&data->mutex);
+	ret = 0;
+	if (flag == SENSOR_HUB_SYNC) {
+		cycles = wait_for_completion_interruptible_timeout(&hsdev->pending.ready,
+								   HZ * 5);
+		if (cycles == 0)
+			ret = -ETIMEDOUT;
+		else if (cycles < 0)
+			ret = cycles;
+
+		hsdev->pending.status = false;
+	}
+	mutex_unlock(hsdev->mutex_ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensor_hub_input_attr_read_values);
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
@@ -478,6 +526,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
 	struct hid_sensor_hub_device *hsdev = NULL;
+	u32 copy_size;
+	u32 avail;
 
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
@@ -518,12 +568,27 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					      hsdev->pending.attr_usage_id ==
 					      report->field[i]->logical)) {
 			hid_dbg(hdev, "data was pending ...\n");
-			hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
-			if (hsdev->pending.raw_data)
-				hsdev->pending.raw_size = sz;
-			else
-				hsdev->pending.raw_size = 0;
-			complete(&hsdev->pending.ready);
+			if (hsdev->pending.max_raw_size) {
+				if (hsdev->pending.index < hsdev->pending.max_raw_size) {
+					avail = hsdev->pending.max_raw_size - hsdev->pending.index;
+					copy_size = clamp(sz, 0U, avail);
+
+					memcpy(hsdev->pending.raw_data + hsdev->pending.index,
+					       ptr, copy_size);
+					hsdev->pending.index += copy_size;
+					if (hsdev->pending.index >= hsdev->pending.max_raw_size) {
+						hsdev->pending.raw_size = hsdev->pending.index;
+						complete(&hsdev->pending.ready);
+					}
+				}
+			} else {
+				hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
+				if (hsdev->pending.raw_data)
+					hsdev->pending.raw_size = sz;
+				else
+					hsdev->pending.raw_size = 0;
+				complete(&hsdev->pending.ready);
+			}
 		}
 		if (callback->capture_sample) {
 			if (report->field[i]->logical)
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 524b53a3c87b..37b60c3aaf66 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index c45f182d0448..5f4395f7c645 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -522,7 +522,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	pidff->set_effect[PID_EFFECT_BLOCK_INDEX].value[0] =
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
-		pidff->create_new_effect_type->value[0];
+		pidff_get_effect_type_id(pidff, effect);
 
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
 			   effect->replay.length);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2220168bf116..24b8b33a07f6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -54,7 +54,7 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 {
 	bool warned = false;
 
-	while (kfifo_avail(fifo) < size) {
+	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
 		if (!warned)
 			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
 		warned = true;
@@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 		kfifo_skip(fifo);
 	}
 
-	kfifo_in(fifo, raw_data, size);
+	if (!kfifo_in(fifo, raw_data, size))
+		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
+				     __func__, size);
 }
 
 static void wacom_wac_queue_flush(struct hid_device *hdev,
@@ -74,7 +76,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_KERNEL);
+		buf = kzalloc(size, GFP_ATOMIC);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
@@ -2462,16 +2464,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_register_inputs(wacom);
 	if (error)
-		goto fail;
+		goto fail_hw_stop;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
 		error = wacom_initialize_leds(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 
 		error = wacom_initialize_remotes(wacom);
 		if (error)
-			goto fail;
+			goto fail_hw_stop;
 	}
 
 	if (!wireless) {
@@ -2485,14 +2487,14 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		cancel_delayed_work_sync(&wacom->init_work);
 		_wacom_query_tablet_data(wacom);
 		error = -ENODEV;
-		goto fail_quirks;
+		goto fail_hw_stop;
 	}
 
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
 		if (error) {
 			hid_err(hdev, "hw open failed\n");
-			goto fail_quirks;
+			goto fail_hw_stop;
 		}
 	}
 
@@ -2501,7 +2503,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	return 0;
 
-fail_quirks:
+fail_hw_stop:
 	hid_hw_stop(hdev);
 fail:
 	wacom_release_resources(wacom);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index b952a1d47f12..a827f76b8144 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -83,7 +83,7 @@ struct etb_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	raw_spinlock_t		spinlock;
-	local_t			reading;
+	atomic_t		reading;
 	pid_t			pid;
 	u8			*buf;
 	u32			buffer_depth;
@@ -601,7 +601,7 @@ static int etb_open(struct inode *inode, struct file *file)
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
 
-	if (local_cmpxchg(&drvdata->reading, 0, 1))
+	if (atomic_cmpxchg(&drvdata->reading, 0, 1))
 		return -EBUSY;
 
 	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
@@ -639,7 +639,7 @@ static int etb_release(struct inode *inode, struct file *file)
 {
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
-	local_set(&drvdata->reading, 0);
+	atomic_set(&drvdata->reading, 0);
 
 	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
 	return 0;
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 5776f63468fa..20a950b9dd4f 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -337,6 +337,7 @@ static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
 	unsigned long to_copy;
 	long pg_idx, pg_offset;
 
+	head %= (unsigned long)buf->nr_pages << PAGE_SHIFT;
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66c23535656b..0617f416cb0b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -818,12 +818,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..b29c99ed3883 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -931,13 +931,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	if (hwpec)
 		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
-out:
 	/*
 	 * Unlock the SMBus device for use by BIOS/ACPI,
 	 * and clear status flags if not done already.
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out:
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index cd4da50c4dd9..e6c24a9d934d 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1646,7 +1646,18 @@ static int __maybe_unused lpi2c_runtime_resume(struct device *dev)
 
 static int __maybe_unused lpi2c_suspend_noirq(struct device *dev)
 {
-	return pm_runtime_force_suspend(dev);
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&lpi2c_imx->adapter);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
@@ -1666,6 +1677,8 @@ static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
 	if (lpi2c_imx->target)
 		lpi2c_imx_target_init(lpi2c_imx);
 
+	i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 28c5c5c1fb7a..a21fa45bd64c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -844,7 +844,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 					      "fsl,timeout", &mpc_ops.timeout);
 
 	if (!result) {
-		mpc_ops.timeout *= HZ / 1000000;
+		mpc_ops.timeout = mpc_ops.timeout * HZ / 1000000;
 		if (mpc_ops.timeout < 5)
 			mpc_ops.timeout = 5;
 	} else {
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 067af255bd22..0ddd8a1d0e4d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -464,8 +464,13 @@ static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
 {
 	struct stm32f7_i2c_spec *specs;
 	u32 p_prev = STM32F7_PRESC_MAX;
-	u32 i2cclk = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
-				       setup->clock_src);
+	/*
+	 * Truncate instead of rounding to closest: if the clock period is
+	 * overestimated, the computed SCL timings will come out shorter on
+	 * the wire, which can push the bus above the target rate and below
+	 * the spec's tLOW/tHIGH minimums.
+	 */
+	u32 i2cclk = NSEC_PER_SEC / setup->clock_src;
 	u32 i2cbus = DIV_ROUND_CLOSEST(NSEC_PER_SEC,
 				       setup->speed_freq);
 	u32 clk_error_prev = i2cbus;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4039d1175c4c..8bea9fc6888f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -63,6 +63,7 @@
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
+static void i2c_deregister_clients(struct i2c_adapter *adap);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 static DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);
@@ -1555,11 +1556,18 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_remove_irq_domain;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1573,23 +1581,18 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	idr_replace(&i2c_adapter_idr, adap, adap->nr);
 	mutex_unlock(&core_lock);
 
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto out_list;
+		goto err_replace_id;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */
@@ -1608,10 +1611,19 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	return 0;
 
 out_reg:
+	i2c_deregister_clients(adap);
+	device_del(&adap->dev);
+err_replace_id:
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, NULL, adap->nr);
+	mutex_unlock(&core_lock);
 	debugfs_remove_recursive(adap->debugfs);
+err_put_adap:
 	init_completion(&adap->dev_released);
-	device_unregister(&adap->dev);
+	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
@@ -1747,29 +1759,10 @@ static int __process_removed_adapter(struct device_driver *d, void *data)
 	return 0;
 }
 
-/**
- * i2c_del_adapter - unregister I2C adapter
- * @adap: the adapter being unregistered
- * Context: can sleep
- *
- * This unregisters an I2C adapter which was previously registered
- * by @i2c_add_adapter or @i2c_add_numbered_adapter.
- */
-void i2c_del_adapter(struct i2c_adapter *adap)
+static void i2c_deregister_clients(struct i2c_adapter *adap)
 {
-	struct i2c_adapter *found;
 	struct i2c_client *client, *next;
 
-	/* First make sure that this adapter was ever added */
-	mutex_lock(&core_lock);
-	found = idr_find(&i2c_adapter_idr, adap->nr);
-	mutex_unlock(&core_lock);
-	if (found != adap) {
-		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
-		return;
-	}
-
-	i2c_acpi_remove_space_handler(adap);
 	/* Tell drivers about this removal */
 	mutex_lock(&core_lock);
 	bus_for_each_drv(&i2c_bus_type, NULL, adap,
@@ -1795,6 +1788,34 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	 * them up properly, so we give them a chance to do that first. */
 	device_for_each_child(&adap->dev, NULL, __unregister_client);
 	device_for_each_child(&adap->dev, NULL, __unregister_dummy);
+}
+
+/**
+ * i2c_del_adapter - unregister I2C adapter
+ * @adap: the adapter being unregistered
+ * Context: can sleep
+ *
+ * This unregisters an I2C adapter which was previously registered
+ * by @i2c_add_adapter or @i2c_add_numbered_adapter.
+ */
+void i2c_del_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_adapter *found;
+
+	/* First make sure that this adapter was ever added */
+	mutex_lock(&core_lock);
+	found = idr_find(&i2c_adapter_idr, adap->nr);
+	if (found == adap)
+		idr_replace(&i2c_adapter_idr, NULL, adap->nr);
+	mutex_unlock(&core_lock);
+	if (found != adap) {
+		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
+		return;
+	}
+
+	i2c_acpi_remove_space_handler(adap);
+
+	i2c_deregister_clients(adap);
 
 	/* device name is gone after device_unregister */
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2398eb7e12cd..dc8a6285cf3d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -991,6 +991,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	if (samples && count > samples)
 		count = samples;
 
+	count = min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);
+
 	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..7ac885d94d7f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -147,8 +147,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
 		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
+			ret = -EINVAL;
+		else
+			ret = kxsd9_write_scale(indio_dev, val2);
 	}
 
 	pm_runtime_put_autosuspend(st->dev);
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..3a3dcba3db3b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -78,6 +78,7 @@ config AD4030
 config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
+	depends on GPIOLIB
 	select REGMAP_I3C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
@@ -311,6 +312,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
@@ -414,6 +416,7 @@ config AD7766
 config AD7768_1
 	tristate "Analog Devices AD7768-1 ADC driver"
 	depends on SPI
+	select GPIOLIB
 	select REGULATOR
 	select REGMAP_SPI
 	select RATIONAL
@@ -434,6 +437,7 @@ config AD7779
 	depends on SPI
 	select CRC8
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD777X family
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..1b410291da53 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -262,11 +262,25 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 
 	/*
 	 * Read R̅D̅Y̅ pin (if possible) or status register to check if there is an
-	 * old event.
+	 * old event. For devices with neither an RDY GPIO nor registers,
+	 * ad_sd_read_reg() transmits no address byte and clocks raw MISO bytes,
+	 * which is indistinguishable from reading conversion data and would
+	 * partially consume a pending result. Skip the check for such devices.
+	 *
+	 * This is safe for all current registerless devices: ad7191 and ad7780
+	 * (with powerdown GPIO) are reset between conversions by CS deassertion,
+	 * so there is no stale result to drain; ad7780 (without powerdown GPIO)
+	 * and max11205 are continuously-converting and cycle ~DRDY at the output
+	 * data rate regardless of whether the previous result was read, so the
+	 * next falling edge fires naturally.
+	 *
+	 * A future registerless device that holds ~DRDY asserted until data is
+	 * read would be broken by this early return and would need either
+	 * num_resetclks set or a rdy-gpio.
 	 */
 	if (sigma_delta->rdy_gpiod) {
 		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
-	} else {
+	} else if (sigma_delta->info->has_registers) {
 		unsigned int status_reg;
 
 		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
@@ -274,11 +288,24 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 			return ret;
 
 		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
+	} else {
+		return 0;
 	}
 
 	if (!pending_event)
 		return 0;
 
+	/*
+	 * With num_resetclks = 0, data_read_len is 0 and the drain sequence
+	 * below would compute memset(data + 2, 0xff, 0 - 1), underflowing to
+	 * SIZE_MAX and corrupting the heap. There is no safe way to drain the
+	 * stale result without knowing the data register size; it will be
+	 * consumed by the first ad_sd_read_reg() call in
+	 * ad_sigma_delta_single_conversion().
+	 */
+	if (!data_read_len)
+		return 0;
+
 	/*
 	 * In general the size of the data register is unknown. It varies from
 	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
@@ -441,11 +468,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 out:
 	ad_sd_disable_irq(sigma_delta);
 
-	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
-	ad_sigma_delta_disable_one(sigma_delta, chan->address);
-
 out_unlock:
 	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 out_release:
@@ -578,6 +604,9 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
+	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	spi_unoptimize_message(&sigma_delta->sample_msg);
 
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 43a7bc8158b5..db3a602327ff 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -179,6 +179,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	init_completion(&st->completion);
+
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
 	if (retval < 0) {
@@ -197,8 +199,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iodev);
 
-	init_completion(&st->completion);
-
 	iodev->name = LPC32XXAD_NAME;
 	iodev->info = &lpc32xx_adc_iio_info;
 	iodev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 8f4ed3db94f0..753f6a0a6e7b 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,13 +198,13 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
-static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, u64 cycles)
 {
 	u64 rate;
 
 	rate = clk_get_rate(info->clk);
 	if (rate)
-		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+		ndelay(div64_u64(NSEC_PER_SEC * cycles, rate));
 }
 
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 91995489bb1c..d47278f1c4fc 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -280,6 +280,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->dev = dev;
 
+	init_completion(&st->completion);
 	mutex_init(&st->lock);
 
 	/*
@@ -326,8 +327,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	init_completion(&st->completion);
-
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 2320be0efb50..82040f9395b0 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -459,7 +459,11 @@ static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	if (ret)
+		pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 8ea1269f74db..57eed8554bd9 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -321,7 +321,8 @@ static int ads124s_probe(struct spi_device *spi)
 	ads124s_priv->reset_gpio = devm_gpiod_get_optional(&spi->dev,
 						   "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ads124s_priv->reset_gpio))
-		dev_info(&spi->dev, "Reset GPIO not defined\n");
+		return dev_err_probe(&spi->dev, PTR_ERR(ads124s_priv->reset_gpio),
+				     "Failed to get reset GPIO\n");
 
 	ads124s_priv->chip_info = &ads124s_chip_info_tbl[spi_id->driver_data];
 
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 700528c9a0a4..10e912bbf0c5 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
 {
 	struct hw_consumer_buffer *hw_buf =
 		iio_buffer_to_hw_consumer_buffer(buffer);
+
+	bitmap_free(buffer->scan_mask);
 	kfree(hw_buf);
 }
 
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 11d6bc1b63e6..d02f2de42327 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
+
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -43,6 +45,11 @@
 #define SCD30_TEMP_OFFSET_MAX 655360
 #define SCD30_EXTRA_TIMEOUT_PER_S 250
 
+/* Floating point arithmetic macros */
+#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
+#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
+#define SCD30_FLOAT_SIGN_MSK BIT(31)
+
 enum {
 	SCD30_CONC,
 	SCD30_TEMP,
@@ -89,10 +96,14 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
+	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
+
+	if (float32 & SCD30_FLOAT_SIGN_MSK)
+		sign = -1;
+	else
+		sign = 1;
 
 	/* special case 0 */
 	if (!exp && !mantissa)
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dbc5e16fbde4..76f91696f66a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -498,6 +498,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int byte_for_channel;
+	u32 tmp;
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
@@ -508,12 +509,22 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	if (err < 0)
 		return err;
 
-	if (byte_for_channel == 1)
-		*data = (s8)*outdata;
-	else if (byte_for_channel == 2)
-		*data = (s16)get_unaligned_le16(outdata);
-	else if (byte_for_channel == 3)
-		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
+	if (byte_for_channel == 1) {
+		tmp = *outdata;
+	} else if (byte_for_channel == 2) {
+		if (ch->scan_type.endianness == IIO_BE)
+			tmp = get_unaligned_be16(outdata);
+		else
+			tmp = get_unaligned_le16(outdata);
+	} else if (byte_for_channel == 3) {
+		if (ch->scan_type.endianness == IIO_BE)
+			tmp = get_unaligned_be24(outdata);
+		else
+			tmp = get_unaligned_le24(outdata);
+	} else {
+		return -EINVAL;
+	}
+	*data = sign_extend32(tmp, BYTES_TO_BITS(byte_for_channel) - 1);
 
 	return 0;
 }
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index a9578afa7015..6bc64f53bce9 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3275..d611341a0e2a 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -201,6 +201,9 @@ static int bmg160_get_filter(struct bmg160_data *data, int *val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	*val = bmg160_samp_freq_table[i].filter;
 
 	return ret ? ret : IIO_VAL_INT;
@@ -218,6 +221,9 @@ static int bmg160_set_filter(struct bmg160_data *data, int val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
 			   bmg160_samp_freq_table[i].bw_bits);
 	if (ret < 0) {
@@ -258,8 +264,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	if (ret < 0)
 		return ret;
 
-	/* Wait upto 500 ms to be ready after changing mode */
-	usleep_range(500, 1000);
+	/*
+	 * Wait for the chip to be ready after switching to normal mode.
+	 * The BMG160 datasheet (BST-BMG160-DS000-07 Rev. 1.0, May 2013)
+	 * specifies a start-up / wake-up time (tsu, twusm) of 30 ms; use
+	 * BMG160_MAX_STARTUP_TIME_MS (80 ms) as a safety margin, matching
+	 * what bmg160_runtime_resume() already does.
+	 */
+	msleep(BMG160_MAX_STARTUP_TIME_MS);
 
 	/* Set Bandwidth */
 	ret = bmg160_set_bw(data, BMG160_DEF_BW);
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index d76e13cbac68..3e6a7af6ab01 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -94,7 +94,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	else
 		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 				       &iio_trigger_generic_data_rdy_poll,
-				       adis->irq_flag,
+				       adis->irq_flag | IRQF_NO_THREAD,
 				       indio_dev->name,
 				       adis->trig);
 	if (ret)
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 4abb83b75e2e..86f6ecfd64aa 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -788,7 +788,8 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 
 	ret = devm_request_irq(&indio_dev->dev, irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       irq_type, "bmi160", data->trig);
+			       irq_type | IRQF_NO_THREAD,
+			       "bmi160", data->trig);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 532d5fdffaf8..7df920ef3cf0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1170,10 +1170,10 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
 
 	/*
-	 * clock period is 32kHz (31250ns)
+	 * clock period is 8kHz (125000ns)
 	 * jitter is +/- 2% (20 per mille)
 	 */
-	ts_chip.clock_period = 31250;
+	ts_chip.clock_period = 125000;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 68a395758031..5c3840acf085 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -248,6 +248,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 
 	/* compute watermark value in bytes */
 	wm_size = watermark * packet_size;
+	st->fifo.watermark.value = watermark;
 
 	/* changing FIFO watermark requires to turn off watermark interrupt */
 	ret = regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
@@ -454,11 +455,10 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	st->fifo.nb.accel = 0;
 	st->fifo.nb.total = 0;
 
-	/* compute maximum FIFO read size */
+	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
 	if (max == 0)
-		max_count = sizeof(st->fifo.data);
-	else
-		max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
+		max = st->fifo.watermark.value;
+	max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
 
 	/* read FIFO count value */
 	raw_fifo_count = (__be16 *)st->buffer;
@@ -574,6 +574,7 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 
 	st->fifo.watermark.eff_gyro = 1;
 	st->fifo.watermark.eff_accel = 1;
+	st->fifo.watermark.value = 1;
 
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index ffca4da1e249..88b8b9f780af 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -34,6 +34,7 @@ struct inv_icm42600_fifo {
 		unsigned int accel;
 		unsigned int eff_gyro;
 		unsigned int eff_accel;
+		unsigned int value;
 	} watermark;
 	size_t count;
 	struct {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 11339ddf1da3..a18dcac93929 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -755,10 +755,10 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	}
 
 	/*
-	 * clock period is 32kHz (31250ns)
+	 * clock period is 8kHz (125000ns)
 	 * jitter is +/- 2% (20 per mille)
 	 */
-	ts_chip.clock_period = 31250;
+	ts_chip.clock_period = 125000;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
 	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 450cb5b47346..8261d9cf0d94 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1660,6 +1660,26 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 		return -ENODEV;
 	}
 
+	hw->settings = &st_lsm6dsx_sensor_settings[i];
+
+	if (hw->settings->shub_settings.page_mux.addr) {
+		/*
+		 * If the IMU has the shub page selected on init, for example
+		 * after a CPU watchdog reset while the page is selected, the
+		 * regular register space is shadowed. While the regular
+		 * register space is shadowed, the registers needed for
+		 * initializing the IMU are not available.
+		 *
+		 * Unconditionally clear the shub page selection to ensure
+		 * normal register access.
+		 */
+		err = st_lsm6dsx_set_page(hw, false);
+		if (err < 0) {
+			dev_err(hw->dev, "failed to clear shub page\n");
+			return err;
+		}
+	}
+
 	err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read whoami register\n");
@@ -1672,7 +1692,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 	}
 
 	*name = st_lsm6dsx_sensor_settings[i].id[j].name;
-	hw->settings = &st_lsm6dsx_sensor_settings[i];
 
 	return 0;
 }
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 10e689f49441..cd697fbeae47 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -156,7 +156,7 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..15b56f8972fc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -418,7 +418,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a0d6fcf2a9c9..e6730f52262a 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -207,6 +207,8 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 		goto unlock;
 	}
 
+	kfifo_reset_out(&ev_int->det_events);
+
 	iio_device_get(indio_dev);
 
 	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
@@ -214,10 +216,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	if (fd < 0) {
 		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 		iio_device_put(indio_dev);
-	} else {
-		kfifo_reset_out(&ev_int->det_events);
 	}
-
 unlock:
 	mutex_unlock(&iio_dev_opaque->mlock);
 	return fd;
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..a28f308bc14e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -45,6 +45,7 @@ config ADUX1020
 
 config AL3000A
 	tristate "AL3000a ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3000a
@@ -55,6 +56,7 @@ config AL3000A
 
 config AL3010
 	tristate "AL3010 ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3010
@@ -65,6 +67,7 @@ config AL3010
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3320A
diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 0932fa2b49fa..0e72906c637f 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -42,7 +42,7 @@ enum al3xxxx_range {
 };
 
 static const int al3010_scales[][2] = {
-	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
+	{ 1, 187200 }, { 0, 296800 }, { 0, 74200 }, { 0, 18600 },
 };
 
 static const struct regmap_config al3010_regmap_config = {
@@ -111,7 +111,8 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -120,11 +121,12 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3010_REG_DATA_LOW
 		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3010_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 63f5a85912fc..b9076f434417 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -135,7 +135,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -144,11 +145,12 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3320A_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index a0d8a58f2704..886accf5e859 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -258,7 +258,7 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			ret = gp2ap002_get_lux(gp2ap002);
 			if (ret < 0)
-				return ret;
+				goto out;
 			*val = ret;
 			ret = IIO_VAL_INT;
 			goto out;
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 53bc455b7bad..0d35d23da091 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -366,8 +366,10 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		ret = wait_event_timeout(opt->result_ready_queue,
 				opt->result_ready,
 				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
-		if (ret == 0)
-			return -ETIMEDOUT;
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
 	} else {
 		/* Sleep for result ready time */
 		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867ea43..c5ccd833dde6 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
 						NULL, tsl2591_event_handler,
 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						"tsl2591_irq", indio_dev);
-		if (ret) {
-			dev_err_probe(&client->dev, ret, "IRQ request error\n");
-			return -EINVAL;
-		}
+		if (ret)
+			return ret;
 		indio_dev->info = &tsl2591_info;
 	} else {
 		indio_dev->info = &tsl2591_info_no_irq;
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..da8c32cabfd6 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -875,9 +875,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	else
 		evtdir = IIO_EV_DIR_FALLING;
 
-	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
-					0, IIO_EV_TYPE_THRESH, evtdir),
-					iio_get_time_ns(indio_dev));
+	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+						       0,
+						       IIO_EV_TYPE_THRESH,
+						       evtdir),
+		       iio_get_time_ns(indio_dev));
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa573..b3468756bdf1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -784,6 +784,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
+	pm_runtime_put_autosuspend(&data->client->dev);
 	dev_err(&client->dev, "Error in reading axis\n");
 	return ret;
 }
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9b489766e457..0ebe0b682caa 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1910,7 +1910,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 		u32 comp_press;
 		s32 comp_temp;
 		aligned_s64 timestamp;
-	} buffer;
+	} buffer = { };
 	int ret;
 
 	guard(mutex)(&data->lock);
diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..16e112b796ba 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47fa8..6c6e6dab045f 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					VL_REG_RESULT_RANGE_STATUS,
 					sizeof(buffer), buffer);
-	if (ret < 0)
-		return ret;
-	else if (ret != 12)
-		return -EREMOTEIO;
+	if (ret != 12)
+		goto done;
 
 	scan.chan = get_unaligned_be16(&buffer[10]);
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 	vl53l0x_clear_irq(data);
 
diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 774728c804c0..1be19fe8aa3f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1334,7 +1334,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			return ret;
+			goto error_ret;
 
 		st->sample.fault = reg_val;
 	}
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7..0850bf691820 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
-obj-$(CONFIG_MLX90632) += mlx90635.o
+obj-$(CONFIG_MLX90635) += mlx90635.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o
diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..2bc5cd46a72f 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -741,7 +741,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
@@ -1177,12 +1177,11 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
 	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
 		sensor->chan, start_conversion);
+	reinit_completion(&st->completion);
 	/* start conversion */
 	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
 	if (ret)
 		return ret;
-
-	reinit_completion(&st->completion);
 	/*
 	 * wait for conversion to complete.
 	 * 300 ms should be more than enough to complete the conversion.
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d8d8c8936d17..bf62143fa719 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -350,7 +350,7 @@ static int tmp006_probe(struct i2c_client *client)
 
 		data->drdy_trig->ops = &tmp006_trigger_ops;
 		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
-		ret = iio_trigger_register(data->drdy_trig);
+		ret = devm_iio_trigger_register(&client->dev, data->drdy_trig);
 		if (ret)
 			return ret;
 
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 27992c38ad90..d9306c0414b5 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -438,7 +438,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
 static bool is_dst_local(const struct dst_entry *dst)
 {
 	if (dst->ops->family == AF_INET)
-		return !!(dst_rtable(dst)->rt_type & RTN_LOCAL);
+		return dst_rtable(dst)->rt_type == RTN_LOCAL;
 	else if (dst->ops->family == AF_INET6)
 		return !!(dst_rt6_info(dst)->rt6i_flags & RTF_LOCAL);
 	else
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 34d03584160c..b566d163c5aa 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -844,6 +844,15 @@ int siw_proc_rresp(struct siw_qp *qp)
 	}
 	mem_p = *mem;
 
+	if (unlikely(wqe->processed + srx->fpdu_part_rem > wqe->bytes)) {
+		siw_dbg_qp(qp, "rresp len: %d + %d > %d\n",
+			   wqe->processed, srx->fpdu_part_rem, wqe->bytes);
+		wqe->wc_status = SIW_WC_LOC_LEN_ERR;
+		siw_init_terminate(qp, TERM_ERROR_LAYER_DDP,
+				   DDP_ETYPE_TAGGED_BUF,
+				   DDP_ECODE_T_BASE_BOUNDS, 0);
+		return -EINVAL;
+	}
 	bytes = min(srx->fpdu_part_rem, srx->skb_new);
 	rv = siw_rx_data(mem_p, srx, &frx->pbl_idx,
 			 sge->laddr + wqe->processed, bytes);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..f81e122a3ccb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (plist->length == 0) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (plist->length == 0 || plist->length > max_chunk_size) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index fd1cd731d781..effa76bfd8f9 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -186,14 +186,18 @@ void iforce_process_packet(struct iforce *iforce,
 
 		/* Check if an effect was just started or stopped */
 		i = data[1] & 0x7f;
-		if (data[1] & 0x80) {
-			if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-				/* Report play event */
-				input_report_ff_status(dev, i, FF_STATUS_PLAYING);
+		if (i < IFORCE_EFFECTS_MAX) {
+			if (data[1] & 0x80) {
+				if (!test_and_set_bit(FF_CORE_IS_PLAYED,
+						      iforce->core_effects[i].flags)) {
+					/* Report play event */
+					input_report_ff_status(dev, i, FF_STATUS_PLAYING);
+				}
+			} else if (test_and_clear_bit(FF_CORE_IS_PLAYED,
+						      iforce->core_effects[i].flags)) {
+				/* Report stop event */
+				input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 			}
-		} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-			/* Report stop event */
-			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
 
 		for (j = 3; j < len; j += 2)
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 7f36f73844a9..6293b6e8148b 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -112,6 +112,8 @@ static int probe_maple_controller(struct device *dev)
 	pad->dev = idev;
 	pad->mdev = mdev;
 
+	maple_set_drvdata(mdev, pad);
+
 	idev->open = dc_pad_open;
 	idev->close = dc_pad_close;
 
@@ -146,7 +148,6 @@ static int probe_maple_controller(struct device *dev)
 		goto fail;
 
 	mdev->driver = mdrv;
-	maple_set_drvdata(mdev, pad);
 
 	return 0;
 
diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 80a5181313e1..3d5538dd4f23 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -166,6 +166,8 @@ static int probe_maple_kbd(struct device *dev)
 	kbd->dev = idev;
 	memcpy(kbd->keycode, dc_kbd_keycode, sizeof(kbd->keycode));
 
+	maple_set_drvdata(mdev, kbd);
+
 	idev->name = mdev->product_name;
 	idev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 	idev->keycode = kbd->keycode;
@@ -190,8 +192,6 @@ static int probe_maple_kbd(struct device *dev)
 
 	mdev->driver = mdrv;
 
-	maple_set_drvdata(mdev, kbd);
-
 	return error;
 
 fail_register:
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5cba02a156ce..edb0a28d25aa 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -428,8 +428,17 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		if (error)
 			return error;
 	}
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+
+	if (!x_traces || !y_traces) {
+		dev_warn(&client->dev,
+			 "invalid trace numbers: x=%u, y=%u\n",
+			 x_traces, y_traces);
+		data->width_x = 1;
+		data->width_y = 1;
+	} else {
+		data->width_x = data->max_x / x_traces;
+		data->width_y = data->max_y / y_traces;
+	}
 
 	if (device_property_read_u32(&client->dev,
 				     "touchscreen-x-mm", &x_mm) ||
@@ -443,8 +452,16 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		data->x_res = elan_convert_resolution(hw_x_res, data->pattern);
 		data->y_res = elan_convert_resolution(hw_y_res, data->pattern);
 	} else {
-		data->x_res = (data->max_x + 1) / x_mm;
-		data->y_res = (data->max_y + 1) / y_mm;
+		if (unlikely(x_mm == 0 || y_mm == 0)) {
+			dev_warn(&client->dev,
+				 "invalid physical dimensions: x_mm=%u, y_mm=%u\n",
+				 x_mm, y_mm);
+			data->x_res = 1;
+			data->y_res = 1;
+		} else {
+			data->x_res = (data->max_x + 1) / x_mm;
+			data->y_res = (data->max_y + 1) / y_mm;
+		}
 	}
 
 	if (device_property_read_bool(&client->dev, "elan,clickpad"))
@@ -956,6 +973,7 @@ static void elan_report_contact(struct elan_tp_data *data, int contact_num,
 
 		if (data->report_features & ETP_FEATURE_REPORT_MK) {
 			unsigned int mk_x, mk_y, area_x, area_y;
+			int adj_width_x, adj_width_y;
 			u8 mk_data = high_precision ?
 				packet[ETP_MK_DATA_OFFSET + contact_num] :
 				finger_data[3];
@@ -967,8 +985,14 @@ static void elan_report_contact(struct elan_tp_data *data, int contact_num,
 			 * To avoid treating large finger as palm, let's reduce
 			 * the width x and y per trace.
 			 */
-			area_x = mk_x * (data->width_x - ETP_FWIDTH_REDUCE);
-			area_y = mk_y * (data->width_y - ETP_FWIDTH_REDUCE);
+
+			adj_width_x = data->width_x > ETP_FWIDTH_REDUCE ?
+					data->width_x - ETP_FWIDTH_REDUCE : 0;
+			adj_width_y = data->width_y > ETP_FWIDTH_REDUCE ?
+					data->width_y - ETP_FWIDTH_REDUCE : 0;
+
+			area_x = mk_x * adj_width_x;
+			area_y = mk_y * adj_width_y;
 
 			input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
 			input_report_abs(input, ABS_MT_TOUCH_MAJOR,
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index c99f7e234219..0c8f7d1b02aa 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -48,7 +48,7 @@ static void dc_mouse_callback(struct mapleq *mq)
 
 static int dc_mouse_open(struct input_dev *dev)
 {
-	struct dc_mouse *mse = maple_get_drvdata(to_maple_dev(&dev->dev));
+	struct dc_mouse *mse = input_get_drvdata(dev);
 
 	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ/50,
 		MAPLE_FUNC_MOUSE);
@@ -58,7 +58,7 @@ static int dc_mouse_open(struct input_dev *dev)
 
 static void dc_mouse_close(struct input_dev *dev)
 {
-	struct dc_mouse *mse = maple_get_drvdata(to_maple_dev(&dev->dev));
+	struct dc_mouse *mse = input_get_drvdata(dev);
 
 	maple_getcond_callback(mse->mdev, dc_mouse_callback, 0,
 		MAPLE_FUNC_MOUSE);
@@ -88,6 +88,9 @@ static int probe_maple_mouse(struct device *dev)
 	mse->dev = input_dev;
 	mse->mdev = mdev;
 
+	maple_set_drvdata(mdev, mse);
+
+	input_set_drvdata(input_dev, mse);
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
 		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);
@@ -102,12 +105,12 @@ static int probe_maple_mouse(struct device *dev)
 		goto fail_register;
 
 	mdev->driver = mdrv;
-	maple_set_drvdata(mdev, mse);
 
 	return error;
 
 fail_register:
 	input_free_device(input_dev);
+	maple_set_drvdata(mdev, NULL);
 fail_nomem:
 	kfree(mse);
 fail:
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 687cb987bc13..ade57e2a7201 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -455,11 +455,13 @@ static int __init rmi_bus_init(void)
 	if (error) {
 		pr_err("%s: error registering the RMI physical driver: %d\n",
 			__func__, error);
-		goto err_unregister_bus;
+		goto err_unregister_function_handlers;
 	}
 
 	return 0;
 
+err_unregister_function_handlers:
+	rmi_unregister_function_handlers();
 err_unregister_bus:
 	bus_unregister(&rmi_bus_type);
 	return error;
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 35045f161dc2..b2155c8e20e7 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -233,7 +233,7 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
 	int button_count = min_t(u8, f30->gpioled_count, TRACKSTICK_RANGE_END);
 
 	f30->gpioled_key_map = devm_kcalloc(&fn->dev,
-					    button_count,
+					    f30->gpioled_count,
 					    sizeof(f30->gpioled_key_map[0]),
 					    GFP_KERNEL);
 	if (!f30->gpioled_key_map) {
diff --git a/drivers/input/rmi4/rmi_f3a.c b/drivers/input/rmi4/rmi_f3a.c
index 0e8baed84dbb..a0777644eef0 100644
--- a/drivers/input/rmi4/rmi_f3a.c
+++ b/drivers/input/rmi4/rmi_f3a.c
@@ -132,7 +132,7 @@ static int rmi_f3a_map_gpios(struct rmi_function *fn, struct f3a_data *f3a,
 	int button_count = min_t(u8, f3a->gpio_count, TRACKSTICK_RANGE_END);
 
 	f3a->gpio_key_map = devm_kcalloc(&fn->dev,
-						button_count,
+						f3a->gpio_count,
 						sizeof(f3a->gpio_key_map[0]),
 						GFP_KERNEL);
 	if (!f3a->gpio_key_map) {
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 22b2f57fd91f..bf9b993f5733 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -219,6 +219,7 @@ static void gscps2_read_data(struct gscps2port *ps2port)
 		ps2port->buffer[ps2port->append].str = status;
 		ps2port->buffer[ps2port->append].data =
 				gscps2_readb_input(ps2port->addr);
+		ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;
 	} while (true);
 }
 
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35..1ae1ae42582a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -325,7 +325,6 @@ struct ser_req {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[8];
 	/*
@@ -333,6 +332,7 @@ struct ser_req {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	__be16 sample ____cacheline_aligned;
+	u16			scratch;
 };
 
 struct ads7845_ser_req {
@@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
+	req->xfer[6].rx_buf = &req->scratch;
 	req->xfer[6].len = 1;
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f8798d11ec03..17fcfe45988c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1057,7 +1057,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	}
 
 	ts->int_trigger_type = ts->config[TRIGGER_LOC] & 0x03;
-	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
+	ts->max_touch_num = min(ts->config[MAX_CONTACTS_LOC] & 0x0f,
+				GOODIX_MAX_CONTACTS);
 
 	x_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC]);
 	y_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC + 2]);
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index af462086a65c..41859bfa2844 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -165,7 +165,7 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 	unsigned int x;
 	unsigned int y;
 
-	if (touch->id > MMS114_MAX_TOUCH) {
+	if (touch->id == 0 || touch->id > MMS114_MAX_TOUCH) {
 		dev_err(&client->dev, "Wrong touch id (%d)\n", touch->id);
 		return;
 	}
@@ -217,7 +217,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct mms114_data *data = dev_id;
 	struct i2c_client *client = data->client;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
+	struct mms114_touch *t;
 	int packet_size;
+	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -226,11 +228,19 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		touch_size = packet_size / MMS136_EVENT_SIZE;
+		event_size = MMS136_EVENT_SIZE;
 	else
-		touch_size = packet_size / MMS114_EVENT_SIZE;
+		event_size = MMS114_EVENT_SIZE;
+
+	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
 			(u8 *)touch);
@@ -238,18 +248,20 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 		goto out;
 
 	for (index = 0; index < touch_size; index++) {
-		switch (touch[index].type) {
+		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+
+		switch (t->type) {
 		case MMS114_TYPE_TOUCHSCREEN:
-			mms114_process_mt(data, touch + index);
+			mms114_process_mt(data, t);
 			break;
 
 		case MMS114_TYPE_TOUCHKEY:
-			mms114_process_touchkey(data, touch + index);
+			mms114_process_touchkey(data, t);
 			break;
 
 		default:
 			dev_err(&client->dev, "Wrong touch type (%d)\n",
-				touch[index].type);
+				t->type);
 			break;
 		}
 	}
diff --git a/drivers/input/touchscreen/touchwin.c b/drivers/input/touchscreen/touchwin.c
index 099fd88e65d8..3ed33378dfcd 100644
--- a/drivers/input/touchscreen/touchwin.c
+++ b/drivers/input/touchscreen/touchwin.c
@@ -63,12 +63,15 @@ static irqreturn_t tw_interrupt(struct serio *serio,
 	if (data) {		/* touch */
 		tw->touched = 1;
 		tw->data[tw->idx++] = data;
-		/* verify length and that the two Y's are the same */
-		if (tw->idx == TW_LENGTH && tw->data[1] == tw->data[2]) {
-			input_report_abs(dev, ABS_X, tw->data[0]);
-			input_report_abs(dev, ABS_Y, tw->data[1]);
-			input_report_key(dev, BTN_TOUCH, 1);
-			input_sync(dev);
+		/* a full packet ends the accumulation, valid or not */
+		if (tw->idx == TW_LENGTH) {
+			/* report only if the two Y's are the same */
+			if (tw->data[1] == tw->data[2]) {
+				input_report_abs(dev, ABS_X, tw->data[0]);
+				input_report_abs(dev, ABS_Y, tw->data[1]);
+				input_report_key(dev, BTN_TOUCH, 1);
+				input_sync(dev);
+			}
 			tw->idx = 0;
 		}
 	} else if (tw->touched) {	/* untouch */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..15ffc4742183 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1774,7 +1774,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..775f1c4ae346 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1254,18 +1254,29 @@ void intel_iommu_disable_iopf(struct device *dev);
 static inline int iopf_for_domain_set(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return 0;
 
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return 0;
+
 	return intel_iommu_enable_iopf(dev);
 }
 
 static inline void iopf_for_domain_remove(struct iommu_domain *domain,
 					  struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return;
 
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return;
+
 	intel_iommu_disable_iopf(dev);
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57cd1db7207a..fea10acd4f02 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,12 +164,9 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
-	if (info->pri_supported) {
-		ret = iopf_for_domain_replace(domain, old, dev);
-		if (ret)
-			goto out_remove_dev_pasid;
-	}
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -184,8 +181,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	if (info->pri_supported)
-		iopf_for_domain_replace(old, domain, dev);
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 61e6b02601d1..3b8067976eac 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
+	if (!vevent) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
+		rc = -ENOMEM;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_ATOMIC);
-	if (!vevent) {
-		rc = -ENOMEM;
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 710eef0b6004..5129e3bf5461 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -139,9 +139,14 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 	mutex_lock(&fault->mutex);
 	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		size_t group_done = done;
+
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
+			/* Read count doesn't fit the first fault group */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 
@@ -157,14 +162,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			iommufd_compose_fault_message(&iopf->fault,
 						      &data, idev,
 						      group->cookie);
-			if (copy_to_user(buf + done, &data, fault_size)) {
+			if (copy_to_user(buf + group_done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
-			done += fault_size;
+			group_done += fault_size;
 		}
+		if (rc)
+			break;
+		done = group_done;
 	}
 	mutex_unlock(&fault->mutex);
 
@@ -264,8 +272,10 @@ iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
 		/* Make a copy of the lost_events_header for copy_to_user */
 		if (next == &veventq->lost_events_header) {
 			vevent = kzalloc_obj(*vevent, GFP_ATOMIC);
-			if (!vevent)
+			if (!vevent) {
+				vevent = ERR_PTR(-ENOMEM);
 				goto out_unlock;
+			}
 		}
 		list_del(&next->node);
 		if (vevent)
@@ -310,8 +320,17 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
 	if (*ppos)
 		return -ESPIPE;
+	/* Minimum read count is a vEVENT header */
+	if (count < sizeof(*hdr))
+		return -EINVAL;
 
 	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		if (IS_ERR(cur)) {
+			if (done == 0)
+				rc = PTR_ERR(cur);
+			break;
+		}
+
 		/* Validate the remaining bytes against the header size */
 		if (done >= count || sizeof(*hdr) > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
@@ -321,8 +340,11 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
 		/* If being a normal vEVENT, validate against the full size */
 		if (!vevent_for_lost_events_header(cur) &&
-		    sizeof(hdr) + cur->data_len > count - done) {
+		    sizeof(*hdr) + cur->data_len > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
+			/* Read count doesn't fit a single normal vEVENT */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 
@@ -336,6 +358,7 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		if (cur->data_len &&
 		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
 			iommufd_veventq_deliver_restore(veventq, cur);
+			done -= sizeof(*hdr);
 			rc = -EFAULT;
 			break;
 		}
@@ -473,6 +496,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 static const struct file_operations iommufd_veventq_fops =
 	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
 
+/* An arbitrary upper bound for veventq_depth that fits all existing HWs */
+#define VEVENTQ_MAX_DEPTH (1U << 19)
+
 int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
@@ -484,7 +510,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags || cmd->__reserved ||
 	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
-	if (!cmd->veventq_depth)
+	if (!cmd->veventq_depth || cmd->veventq_depth > VEVENTQ_MAX_DEPTH)
 		return -EINVAL;
 
 	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c9..623cc608ca0c 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -489,6 +489,9 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+/* An arbitrary entry_num cap, far above any realistic invalidation batch */
+#define IOMMU_HWPT_INVALIDATE_ENTRY_NUM_MAX (1U << 19)
+
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
@@ -507,7 +510,13 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 
-	if (cmd->entry_num && (!cmd->data_uptr || !cmd->entry_len)) {
+	/*
+	 * Bound entry_num and entry_len so a single call cannot pin the CPU;
+	 * entry_len also caps the copy_struct_from_user() trailing-zero scan.
+	 */
+	if (cmd->entry_num &&
+	    (!cmd->data_uptr || !cmd->entry_len || cmd->entry_len > PAGE_SIZE ||
+	     cmd->entry_num > IOMMU_HWPT_INVALIDATE_ENTRY_NUM_MAX)) {
 		rc = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..43fbc5bed8de 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -602,7 +602,7 @@ struct iommufd_vevent {
 	struct iommufd_vevent_header header;
 	struct list_head node; /* for iommufd_eventq::deliver */
 	ssize_t data_len;
-	u64 event_data[] __counted_by(data_len);
+	u8 event_data[] __counted_by(data_len);
 };
 
 #define vevent_for_lost_events_header(vevent) \
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index a529174c94cf..c23c03f0cb6e 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1816,8 +1816,11 @@ static int target_message(struct file *filp, struct dm_ioctl *param, size_t para
 		goto out_argv;
 
 	table = dm_get_live_table(md, &srcu_idx);
-	if (!table)
+	if (!table) {
+		DMERR("The device has no table.");
+		r = -EINVAL;
 		goto out_table;
+	}
 
 	if (dm_deleting_md(md)) {
 		r = -ENXIO;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 8c684756d5fc..d147ec483081 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1202,7 +1202,8 @@ static int mtk_jpeg_release(struct file *file)
 	struct mtk_jpeg_dev *jpeg = video_drvdata(file);
 	struct mtk_jpeg_ctx *ctx = mtk_jpeg_file_to_ctx(file);
 
-	cancel_work_sync(&ctx->jpeg_work);
+	if (jpeg->variant->jpeg_worker)
+		cancel_work_sync(&ctx->jpeg_work);
 	mutex_lock(&jpeg->lock);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 4bf8570e1b9e..2d639b789910 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -556,8 +556,8 @@ static void mxc_isi_remove(struct platform_device *pdev)
 		mxc_isi_pipe_cleanup(pipe);
 	}
 
-	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
+	mxc_isi_crossbar_cleanup(&isi->crossbar);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 39430dd44e30..56fb7cceafc6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -195,7 +195,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (!ec)
 		return retval;
 
-	dev_set_drvdata(dev, ec);
 	ec->ec_dev = dev_get_drvdata(dev->parent);
 	ec->dev = dev;
 	ec->cmd_offset = ec_platform->cmd_offset;
@@ -237,6 +236,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (retval)
 		goto failed;
 
+	dev_set_drvdata(dev, ec);
+
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_get_sensor_count(ec) > 0) {
 		retval = mfd_add_hotplug_devices(ec->dev,
diff --git a/drivers/net/usb/kalmia.c b/drivers/net/usb/kalmia.c
index ee9c48f7f68f..0dd0a30c3db4 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -276,6 +276,14 @@ kalmia_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				"Received header: %6phC. Package length: %i\n",
 				header_start, skb->len - KALMIA_HEADER_LENGTH);
 
+		/* both framing headers must be present before we subtract
+		 * them, otherwise usb_packet_length underflows and the
+		 * device-supplied ether_packet_length drives an out of bounds
+		 * access below
+		 */
+		if (skb->len < 2 * KALMIA_HEADER_LENGTH)
+			return 0;
+
 		/* subtract start header and end header */
 		usb_packet_length = skb->len - (2 * KALMIA_HEADER_LENGTH);
 		ether_packet_length = get_unaligned_le16(&header_start[2]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..a326f4c95c7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1508,6 +1508,9 @@ static void mt7921_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	u16 beacon_interval = vif->bss_conf.beacon_int;
 
+	if (!dev->new_ctx)
+		return;
+
 	if (cfg80211_chandef_identical(&chsw->chandef,
 				       &dev->new_ctx->def) &&
 				       chsw->count) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 79cc30a3b29e..9dc5ee51eb9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2403,6 +2403,9 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	if (ieee80211_vif_is_mld(vif))
 		return;
 
+	if (!dev->new_ctx)
+		return;
+
 	beacon_interval = vif->bss_conf.beacon_int;
 
 	if (cfg80211_chandef_identical(&chsw->chandef,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 70feab97dccb..486c1774fb97 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3363,7 +3363,8 @@ static bool rtw89_core_skb_pn_valid(struct rtw89_dev *rtwdev,
 		last_pn = tid_stats->last_pn;
 
 		if (pn > last_pn) {
-			if (ieee80211_sn_less(mpdu_sn, tid_stats->last_sn)) {
+			if (last_pn != -1LL &&
+			    ieee80211_sn_less(mpdu_sn, tid_stats->last_sn)) {
 				dev_kfree_skb_any(skb);
 
 				return false;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 501c3af1da01..0672d13d13a6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -964,7 +964,8 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtw89_err(rtwdev, "failed to add key to sec cam\n");
 			return ret;
 		}
-		rtw89_core_tid_rx_stats_reset(rtwdev);
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+			rtw89_core_tid_rx_stats_reset(rtwdev);
 		break;
 	case DISABLE_KEY:
 		flush_work(&rtwdev->txq_work);
diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 9935da48a52e..15d99d08f84f 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -92,6 +92,7 @@ struct ntb_epf_dev {
 
 	int db_val;
 	u64 db_valid_mask;
+	int irq_base;
 };
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
@@ -318,7 +319,7 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	struct ntb_epf_dev *ndev = dev;
 	int irq_no;
 
-	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
+	irq_no = irq - ndev->irq_base;
 	ndev->db_val = irq_no + 1;
 
 	if (irq_no == 0)
@@ -350,12 +351,13 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	ndev->irq_base = pci_irq_vector(pdev, 0);
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
-			goto err_request_irq;
+			goto err_free_irq;
 		}
 	}
 
@@ -365,16 +367,14 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
-		goto err_configure_db;
+		goto err_free_irq;
 	}
 
 	return 0;
 
-err_configure_db:
-	for (i = 0; i < ndev->db_count + 1; i++)
+err_free_irq:
+	while (i--)
 		free_irq(pci_irq_vector(pdev, i), ndev);
-
-err_request_irq:
 	pci_free_irq_vectors(pdev);
 
 	return ret;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..9d3ac937f594 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -511,6 +511,12 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
+		/*
+		 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
+		 * enters submit_bio_noacct() for the per-path device. The EOD
+		 * check already passed on the multipath head.
+		 */
+		bio_set_flag(bio, BIO_REMAPPED);
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e9b35549e254..114869d16a1f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -166,6 +166,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u64 offset = nvmet_get_log_page_offset(req->cmd);
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
 	size_t alloc_len;
+	size_t copy_len;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
 	u32 numrec = 0;
@@ -242,7 +243,27 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	up_read(&nvmet_config_sem);
 
-	status = nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
+	/*
+	 * Validate the host-supplied log page offset before copying out.
+	 * Without this check, the host controls a 64-bit byte offset into
+	 * a small kzalloc'd buffer: a value past the log page lets the
+	 * subsequent memcpy read adjacent kernel heap, and a value aimed
+	 * at unmapped kernel memory faults the in-kernel copy and crashes
+	 * the target host. The Discovery controller is unauthenticated,
+	 * so the bug is reachable from any reachable fabric peer.
+	 */
+	if (offset > alloc_len) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out_free_buffer;
+	}
+
+	copy_len = min_t(size_t, data_len, alloc_len - offset);
+	status = nvmet_copy_to_sgl(req, 0, buffer + offset, copy_len);
+	if (!status && copy_len < data_len)
+		status = nvmet_zero_sgl(req, copy_len, data_len - copy_len);
+out_free_buffer:
 	kfree(buffer);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e..0a85acf1e5c7 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -132,13 +132,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data = d;
-	u16 dhvlen = le16_to_cpu(data->dhvlen);
+	u16 dhvlen;
 	u8 *response;
 
+	if (tl < sizeof(*data))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	dhvlen = le16_to_cpu(data->dhvlen);
+
+	/* Validate that hl and dhvlen fit within the transfer length */
+	if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %u\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 data->hl, data->cvalid, dhvlen);
@@ -338,7 +347,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		dhchap_status = nvmet_auth_reply(req, d);
+		dhchap_status = nvmet_auth_reply(req, d, tl);
 		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e6e2c3f9afdf..ac26f4f774c4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1598,8 +1598,10 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 				pending++;
 		}
 		mutex_unlock(&nvmet_rdma_queue_mutex);
-		if (pending > NVMET_RDMA_BACKLOG)
-			return NVME_SC_CONNECT_CTRL_BUSY;
+		if (pending > NVMET_RDMA_BACKLOG) {
+			ret = NVME_SC_CONNECT_CTRL_BUSY;
+			goto put_device;
+		}
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f96adfd5b219..c02e20632fa6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -673,7 +673,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	 */
 	if (unlikely(opp_table->regulator_count == -1)) {
 		opp_table->regulator_count = 0;
-		return 0;
+		goto free_microwatt;
 	}
 
 	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
@@ -696,6 +696,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			opp->supplies[i].u_watt = microwatt[i];
 	}
 
+free_microwatt:
 	kfree(microwatt);
 free_microamp:
 	kfree(microamp);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e35044cc5218..38b2d8262e51 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -137,6 +137,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
+	int (*select_ref_clk_src)(struct imx_pcie *pcie);
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
@@ -247,10 +248,26 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
-static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
+static int imx95_pcie_select_ref_clk_src(struct imx_pcie *imx_pcie)
 {
 	bool ext = imx_pcie->enable_ext_refclk;
 
+	/*
+	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
+	 * used to select reference clock connected to a pair of pads.
+	 *
+	 * Any change in this input must be followed by phy_reset assertion.
+	 */
+
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
+
+	return 0;
+}
+
+static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
+{
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -269,13 +286,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
-			   IMX95_PCIE_REF_CLKEN,
-			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
-
 	return 0;
 }
 
@@ -665,14 +675,6 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-	return 0;
-}
-
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	if (enable) {
@@ -732,7 +734,29 @@ static void imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 
 static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	imx95_pcie_clkreq_override(imx_pcie, enable);
+	/*
+	 * The ref_clk_en signal must remain de-asserted until the
+	 * reference clock is running at appropriate frequency, at which
+	 * point this bit can be asserted. For lower power states where
+	 * the reference clock to the PHY is disabled, it may also be
+	 * de-asserted.
+	 * +------------------- -+--------+----------------+
+	 * | External clock mode | Enable | PCIE_REF_CLKEN |
+	 * +---------------------+--------+----------------+
+	 * | TRUE                | X      | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | TRUE   | 1b'1           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | FALSE  | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   ext || !enable ? 0 : IMX95_PCIE_REF_CLKEN);
+
 	return 0;
 }
 
@@ -786,6 +810,9 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	if (assert)
 		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
 	/* Force PCIe PHY reset */
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
@@ -1256,6 +1283,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	if (imx_pcie->drvdata->select_ref_clk_src)
+		imx_pcie->drvdata->select_ref_clk_src(imx_pcie);
+
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
 
@@ -1877,7 +1907,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
-		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
 	},
@@ -1967,6 +1996,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
@@ -2022,6 +2052,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.select_ref_clk_src = imx95_pcie_select_ref_clk_src,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..7d8eaef436ef 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1674,6 +1674,12 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 	pci->dbi_base = cfg->win;
 	pp->num_vectors = MSI_DEF_NUM_VECTORS;
 
+	/*
+	 * dw_pcie_msi_host_init() is called directly here, bypassing
+	 * dw_pcie_host_init() where pp->lock is normally initialized.
+	 */
+	raw_spin_lock_init(&pp->lock);
+
 	ret = dw_pcie_msi_host_init(pp);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..99952fb7189b 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -68,6 +68,10 @@ int pci_host_common_init(struct platform_device *pdev,
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign bus numbers if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->enable_device = ops->enable_device;
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..9609e6f50b98 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
 
+/*
+ * Older steppings of the Loongson-3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 0x3c19,
+ * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
+ * from 2.5 GT/s up to 16 GT/s.
+ */
+static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
+{
+	u8 old_supported_speeds = pdev->supported_speeds;
+
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+		fallthrough;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+		fallthrough;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+		fallthrough;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+		break;
+	default:
+		pci_warn(pdev, "unexpected max bus speed");
+
+		return;
+	}
+
+	if (pdev->supported_speeds != old_supported_speeds)
+		pci_info(pdev, "fixed up supported link speeds: 0x%x => 0x%x",
+			 old_supported_speeds, pdev->supported_speeds);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..76f3823d9613 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -864,11 +864,25 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static void altera_pcie_disable_irq(struct altera_pcie *pcie)
+{
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* Disable all P2A interrupts */
+		cra_writel(pcie, 0, P2A_INT_ENABLE);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		/* Disable port-level interrupts (CFG_AER, etc.) */
+		writel(0, pcie->hip_base +
+			  pcie->pcie_data->port_conf_offset +
+			  pcie->pcie_data->port_irq_enable_offset);
+	}
+}
+
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
+	altera_pcie_disable_irq(pcie);
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
-	irq_dispose_mapping(pcie->irq);
 }
 
 static int altera_pcie_parse_dt(struct altera_pcie *pcie)
@@ -891,7 +905,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1020,6 +1033,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so set it only after the
+	 * INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1037,7 +1058,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..907ae4285ecb 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -529,23 +529,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+static void mtk_pcie_irq_teardown_port(struct mtk_pcie_port *port)
 {
-	struct mtk_pcie_port *port, *tmp;
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	if (port->irq_domain)
+		irq_domain_remove(port->irq_domain);
 
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		if (port->inner_domain)
+			irq_domain_remove(port->inner_domain);
+	}
 
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
+	irq_dispose_mapping(port->irq);
+}
 
-		irq_dispose_mapping(port->irq);
-	}
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_irq_teardown_port(port);
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -865,7 +869,7 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
 	return mtk_pcie_startup_port_v2(port);
 }
 
-static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
@@ -874,7 +878,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
 		dev_err(dev, "failed to enable sys_ck%d clock\n", port->slot);
-		goto err_sys_clk;
+		return err;
 	}
 
 	err = clk_prepare_enable(port->ahb_ck);
@@ -922,11 +926,15 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!pcie->soc->startup(port))
-		return;
+	err = pcie->soc->startup(port);
+	if (err) {
+		dev_info(dev, "Port%d link down\n", port->slot);
+		goto err_soc_startup;
+	}
 
-	dev_info(dev, "Port%d link down\n", port->slot);
+	return 0;
 
+err_soc_startup:
 	phy_power_off(port->phy);
 err_phy_on:
 	phy_exit(port->phy);
@@ -942,8 +950,8 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	clk_disable_unprepare(port->ahb_ck);
 err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
-err_sys_clk:
-	mtk_pcie_port_free(port);
+
+	return err;
 }
 
 static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
@@ -1109,8 +1117,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		return err;
 
 	/* enable each port, and then check link status */
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err) {
+			mtk_pcie_irq_teardown_port(port);
+			mtk_pcie_port_free(port);
+		}
+	}
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
@@ -1209,14 +1222,18 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int err;
 
 	if (list_empty(&pcie->ports))
 		return 0;
 
 	clk_prepare_enable(pcie->free_ck);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err)
+			mtk_pcie_port_free(port);
+	}
 
 	/* In case of EP was removed while system suspend. */
 	if (list_empty(&pcie->ports))
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..08df9bace13d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -938,12 +938,18 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
 		return;
 
 	pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_VF_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
 		int bar_idx, size;
 
 		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
 		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
 		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..dd0025d3914e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -80,11 +80,10 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
  * request a retrain and check the result.
  *
- * If this turns out successful and we know by the Vendor:Device ID it is
- * safe to do so, then lift the restriction, letting the devices negotiate
- * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
- * firmware may have already arranged and lift it with ports that already
- * report their data link being up.
+ * If this turns out successful, or where a 2.5GT/s speed restriction has
+ * been previously arranged by the firmware and the port reports its link
+ * already being up, lift the restriction, in a hope it is safe to do so,
+ * letting the devices negotiate a higher speed.
  *
  * Otherwise revert the speed to the original setting and request a retrain
  * again to remove any residual state, ignoring the result as it's supposed
@@ -95,51 +94,37 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	static const struct pci_device_id ids[] = {
-		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
-		{}
-	};
-	u16 lnksta, lnkctl2;
+	u16 lnksta, lnkctl2, oldlnkctl2;
 	int ret = -ENOTTY;
+	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
-					      true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-
-	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
-		u32 lnkcap;
-
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
+	return ret;
+err:
+	pci_info(dev, "retraining failed\n");
+	pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);
 	return ret;
 }
 
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 39f8cf3b70d5..11965947c4cb 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -231,6 +231,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -238,6 +241,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..6e5cc4086a9e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -197,13 +197,14 @@
 enum cmn_model {
 	CMN600 = 1,
 	CMN650 = 2,
-	CMN700 = 4,
-	CI700 = 8,
+	CI700 = 4,
+	CMN700 = 8,
 	CMNS3 = 16,
 	/* ...and then we can use bitmap tricks for commonality */
 	CMN_ANY = -1,
 	NOT_CMN600 = -2,
-	CMN_650ON = CMN650 | CMN700 | CMNS3,
+	CMN_700ON = ~(CMN700 - 1),
+	CMN_650ON = CMN_700ON | CMN650,
 };
 
 /* Actual part numbers and revision IDs defined by the hardware */
@@ -919,14 +920,14 @@ static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_DVM(NOT_CMN600, txsnp_stall,		0x0a),
 	CMN_EVENT_DVM(NOT_CMN600, trkfull,		0x0b),
 	CMN_EVENT_DVM_OCC(NOT_CMN600, trk_occupancy,	0x0c),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_cxha,	0x0d),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_pdn,	0x0e),
-	CMN_EVENT_DVM(CMN700, trk_alloc,		0x0f),
-	CMN_EVENT_DVM(CMN700, trk_cxha_alloc,		0x10),
-	CMN_EVENT_DVM(CMN700, trk_pdn_alloc,		0x11),
-	CMN_EVENT_DVM(CMN700, txsnp_stall_limit,	0x12),
-	CMN_EVENT_DVM(CMN700, rxsnp_stall_starv,	0x13),
-	CMN_EVENT_DVM(CMN700, txsnp_sync_stall_op,	0x14),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_cxha, 0x0d),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_pdn,	0x0e),
+	CMN_EVENT_DVM(CMN_700ON, trk_alloc,		0x0f),
+	CMN_EVENT_DVM(CMN_700ON, trk_cxha_alloc,	0x10),
+	CMN_EVENT_DVM(CMN_700ON, trk_pdn_alloc,		0x11),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_stall_limit,	0x12),
+	CMN_EVENT_DVM(CMN_700ON, rxsnp_stall_starv,	0x13),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_sync_stall_op,	0x14),
 
 	CMN_EVENT_HNF(CMN_ANY, cache_miss,		0x01),
 	CMN_EVENT_HNF(CMN_ANY, slc_sf_cache_access,	0x02),
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 085093506dda..6b4bac5f7051 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
 #include <linux/suspend.h>
@@ -230,6 +232,7 @@ static const struct dmi_system_id dmi_auto_add_switch[] = {
 };
 
 struct intel_hid_priv {
+	struct mutex mutex; /* Avoid notify_handler() racing with itself */
 	struct input_dev *input_dev;
 	struct input_dev *array;
 	struct input_dev *switches;
@@ -565,6 +568,8 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct key_entry *ke;
 	int err;
 
+	guard(mutex)(&priv->mutex);
+
 	/*
 	 * Some convertible have unreliable VGBS return which could cause incorrect
 	 * SW_TABLET_MODE report, in these cases we enable support when receiving
@@ -720,6 +725,10 @@ static int intel_hid_probe(struct platform_device *device)
 		return -ENOMEM;
 	dev_set_drvdata(&device->dev, priv);
 
+	err = devm_mutex_init(&device->dev, &priv->mutex);
+	if (err)
+		return err;
+
 	/* See dual_accel_detect.h for more info on the dual_accel check. */
 	if (enable_sw_tablet_mode == TABLET_SW_AUTO) {
 		if (dmi_check_system(dmi_vgbs_allow_list))
diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 6d609c42e479..c005e65ba0ec 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -345,8 +345,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 	of_node_put(np);
 	/*
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e201309f8aae..e14753144e19 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -647,7 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_sync(controller->dma_rx);
 		return -EINVAL;
 	}
 
@@ -668,8 +668,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 							transfer_timeout);
 		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -ETIMEDOUT;
 		}
@@ -678,8 +678,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 							transfer_timeout);
 		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -ETIMEDOUT;
 		}
@@ -688,8 +688,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA TX interrupted\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -EINTR;
 		}
@@ -698,8 +698,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 			fsl_lpspi->target_aborted) {
 			dev_dbg(fsl_lpspi->dev,
 				"I/O Error in DMA RX interrupted\n");
-			dmaengine_terminate_all(controller->dma_tx);
-			dmaengine_terminate_all(controller->dma_rx);
+			dmaengine_terminate_sync(controller->dma_tx);
+			dmaengine_terminate_sync(controller->dma_rx);
 			fsl_lpspi_reset(fsl_lpspi);
 			return -EINTR;
 		}
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 6cda5925fa45..584751516b69 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5020,7 +5020,6 @@ static int load_primary_binaries(
 	struct ia_css_capture_settings *mycs;
 	unsigned int i;
 	bool need_extra_yuv_scaler = false;
-	struct ia_css_binary_descr prim_descr[MAX_NUM_PRIMARY_STAGES];
 
 	IA_CSS_ENTER_PRIVATE("");
 	assert(pipe);
@@ -5189,15 +5188,16 @@ static int load_primary_binaries(
 
 	/* Primary */
 	for (i = 0; i < mycs->num_primary_stage; i++) {
+		struct ia_css_binary_descr prim_descr;
 		struct ia_css_frame_info *local_vf_info = NULL;
 
 		if (pipe->enable_viewfinder[IA_CSS_PIPE_OUTPUT_STAGE_0] &&
 		    (i == mycs->num_primary_stage - 1))
 			local_vf_info = &vf_info;
-		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr[i],
+		ia_css_pipe_get_primary_binarydesc(pipe, &prim_descr,
 						   &prim_in_info, &prim_out_info,
 						   local_vf_info, i);
-		err = ia_css_binary_find(&prim_descr[i], &mycs->primary_binary[i]);
+		err = ia_css_binary_find(&prim_descr, &mycs->primary_binary[i]);
 		if (err) {
 			IA_CSS_LEAVE_ERR_PRIVATE(err);
 			return err;
diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index 2c48d57a3180..92cce31e35c5 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -1770,6 +1770,8 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
 		acc->stripe.bds_out_stripes[0].width =
 			ALIGN(css_pipe->rect[IPU3_CSS_RECT_BDS].width, f);
 	} else {
+		u32 offset;
+
 		/* Image processing is divided into two stripes */
 		acc->stripe.bds_out_stripes[0].width =
 			acc->stripe.bds_out_stripes[1].width =
@@ -1788,8 +1790,10 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
 			acc->stripe.bds_out_stripes[1].width += f;
 		}
 		/* Overlap between stripes is IPU3_UAPI_ISP_VEC_ELEMS * 4 */
-		acc->stripe.bds_out_stripes[1].offset =
-			acc->stripe.bds_out_stripes[0].width - 2 * f;
+		offset = acc->stripe.bds_out_stripes[0].width - 2 * f;
+		if (offset > 65535)
+			return -EINVAL;
+		acc->stripe.bds_out_stripes[1].offset = offset;
 	}
 
 	acc->stripe.effective_stripes[0].height =
diff --git a/drivers/staging/media/ipu7/ipu7.c b/drivers/staging/media/ipu7/ipu7.c
index c771e763f8c5..310e3f24e571 100644
--- a/drivers/staging/media/ipu7/ipu7.c
+++ b/drivers/staging/media/ipu7/ipu7.c
@@ -2169,21 +2169,18 @@ ipu7_isys_init(struct pci_dev *pdev, struct device *parent,
 	isys_adev->mmu = ipu7_mmu_init(dev, base, ISYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(isys_adev->mmu)) {
-		dev_err_probe(dev, PTR_ERR(isys_adev->mmu),
-			      "ipu7_mmu_init(isys_adev->mmu) failed\n");
+		ret = dev_err_probe(dev, PTR_ERR(isys_adev->mmu),
+				    "ipu7_mmu_init(isys_adev->mmu) failed\n");
 		put_device(&isys_adev->auxdev.dev);
-		kfree(pdata);
-		return ERR_CAST(isys_adev->mmu);
+		return ERR_PTR(ret);
 	}
 
 	isys_adev->mmu->dev = &isys_adev->auxdev.dev;
 	isys_adev->subsys = IPU_IS;
 
 	ret = ipu7_bus_add_device(isys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return isys_adev;
 }
@@ -2216,21 +2213,18 @@ ipu7_psys_init(struct pci_dev *pdev, struct device *parent,
 	psys_adev->mmu = ipu7_mmu_init(&pdev->dev, base, PSYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(psys_adev->mmu)) {
-		dev_err_probe(&pdev->dev, PTR_ERR(psys_adev->mmu),
-			      "ipu7_mmu_init(psys_adev->mmu) failed\n");
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(psys_adev->mmu),
+				    "ipu7_mmu_init(psys_adev->mmu) failed\n");
 		put_device(&psys_adev->auxdev.dev);
-		kfree(pdata);
-		return ERR_CAST(psys_adev->mmu);
+		return ERR_PTR(ret);
 	}
 
 	psys_adev->mmu->dev = &psys_adev->auxdev.dev;
 	psys_adev->subsys = IPU_PS;
 
 	ret = ipu7_bus_add_device(psys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return psys_adev;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731dd47..3c1f0068cd92 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -583,9 +583,14 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
+		    in_ie[cnt + 1] >= 8 &&
 		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
 		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
 			if (wapi_ie)
@@ -616,9 +621,14 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
+		    in_ie[cnt + 1] >= 4 &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
@@ -699,6 +709,9 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 	if (len_attr)
 		*len_attr = 0;
 
+	if (wps_ielen < 6)
+		return attr_ptr;
+
 	if ((wps_ie[0] != WLAN_EID_VENDOR_SPECIFIC) ||
 		(memcmp(wps_ie + 2, wps_oui, 4))) {
 		return attr_ptr;
@@ -709,6 +722,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 
 	while (attr_ptr - wps_ie < wps_ielen) {
 		/*  4 = 2(Attribute ID) + 2(Length) */
+		if (attr_ptr + 4 > wps_ie + wps_ielen)
+			break;
 		u16 attr_id = get_unaligned_be16(attr_ptr);
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..e78450402d19 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -687,6 +687,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
+	if (len < WLAN_HDR_A3_LEN)
+		return _FAIL;
+
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -698,6 +701,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		prxattrib->hdrlen = WLAN_HDR_A3_LEN;
 		prxattrib->encrypt = _WEP40_;
 
+		if (len < WLAN_HDR_A3_LEN + 8)
+			return _FAIL;
+
 		iv = pframe+prxattrib->hdrlen;
 		prxattrib->key_index = ((iv[3]>>6)&0x3);
 
@@ -802,7 +808,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if (!p || ie_len <= 0) {
+			if (!p || ie_len != 128) {
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -1400,7 +1406,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -2925,7 +2935,11 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -5318,7 +5332,11 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		if (i + sizeof(*pIE) > pnetwork->ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pnetwork->ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..94bbe7ac13ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -936,7 +936,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	for (i = 0; i < umin(pIE->length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
@@ -1289,7 +1290,11 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -1314,7 +1319,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 
@@ -1330,15 +1335,23 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
+			if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+				break;
+			if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+				break;
+
 			switch (pIE->element_id) {
 			case WLAN_EID_VENDOR_SPECIFIC:
-				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
+				if (pIE->length >= 16 &&
+				    !memcmp(pIE->data, RTW_WPA_OUI, 4) &&
+				    !memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4))
 					return true;
 
 				break;
 
 			case WLAN_EID_RSN:
-				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
+				if (pIE->length >= 12 &&
+				    !memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
 				break;
 
@@ -1346,7 +1359,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 				break;
 			}
 
-			i += (pIE->length + 2);
+			i += sizeof(*pIE) + pIE->length;
 		}
 
 		return false;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index fd3bae31b0ed..e7ba5ccfa03c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1445,6 +1445,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1454,6 +1458,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
+		if (wpa2_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index dc0b77f38b1a..9bdb67a8a408 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -24,9 +24,11 @@ void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
 int _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, unsigned int rlen)
 {
 	int ret;
+	unsigned int remain = rtw_remainder_len(pfile);
 
-	if (rtw_remainder_len(pfile) < rlen)
-		return -EINVAL;
+	/* clamp to bytes remaining; the coalesce loop relies on short reads */
+	if (rlen > remain)
+		rlen = remain;
 
 	if (rmem) {
 		ret = skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, rlen);
diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 8abaa3165fbb..434cf760ade6 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1239,6 +1239,7 @@ static void __exit fake_exit(void)
 {
 	struct list_head *pos = NULL;
 	struct list_head *tmplist;
+	struct vme_lm_resource *lm;
 	struct vme_master_resource *master_image;
 	struct vme_slave_resource *slave_image;
 	int i;
@@ -1268,6 +1269,13 @@ static void __exit fake_exit(void)
 	vme_unregister_bridge(fake_bridge);
 
 	fake_crcsr_exit(fake_bridge);
+	/* resources are stored in link list */
+	list_for_each_safe(pos, tmplist, &fake_bridge->lm_resources) {
+		lm = list_entry(pos, struct vme_lm_resource, list);
+		list_del(pos);
+		kfree(lm);
+	}
+
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &fake_bridge->slave_resources) {
 		slave_image = list_entry(pos, struct vme_slave_resource, list);
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 4cf3486646ce..c695ad9b4ca2 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2534,6 +2534,7 @@ static void tsi148_remove(struct pci_dev *pdev)
 {
 	struct list_head *pos = NULL;
 	struct list_head *tmplist;
+	struct vme_lm_resource *lm;
 	struct vme_master_resource *master_image;
 	struct vme_slave_resource *slave_image;
 	struct vme_dma_resource *dma_ctrlr;
@@ -2590,6 +2591,13 @@ static void tsi148_remove(struct pci_dev *pdev)
 
 	tsi148_crcsr_exit(tsi148_bridge, pdev);
 
+	/* resources are stored in link list */
+	list_for_each_safe(pos, tmplist, &tsi148_bridge->lm_resources) {
+		lm = list_entry(pos, struct vme_lm_resource, list);
+		list_del(pos);
+		kfree(lm);
+	}
+
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &tsi148_bridge->dma_resources) {
 		dma_ctrlr = list_entry(pos, struct vme_dma_resource, list);
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6b0a..a472a38ef613 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -156,6 +156,17 @@ static ssize_t buffer_to_user(unsigned int minor, char __user *buf,
 {
 	void *image_ptr;
 
+	/*
+	 * The slave window (image_size) can exceed the fixed kern_buf
+	 * (size_buf == PCI_BUF_SIZE), so bound the copy to kern_buf.
+	 * *ppos is >= 0 here (checked by the caller), so the
+	 * subtraction below cannot wrap.
+	 */
+	if (*ppos >= image[minor].size_buf)
+		return 0;
+	if (count > image[minor].size_buf - *ppos)
+		count = image[minor].size_buf - *ppos;
+
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_to_user(buf, image_ptr, (unsigned long)count))
 		return -EFAULT;
@@ -168,6 +179,17 @@ static ssize_t buffer_from_user(unsigned int minor, const char __user *buf,
 {
 	void *image_ptr;
 
+	/*
+	 * The slave window (image_size) can exceed the fixed kern_buf
+	 * (size_buf == PCI_BUF_SIZE), so bound the copy to kern_buf.
+	 * *ppos is >= 0 here (checked by the caller), so the
+	 * subtraction below cannot wrap.
+	 */
+	if (*ppos >= image[minor].size_buf)
+		return 0;
+	if (count > image[minor].size_buf - *ppos)
+		count = image[minor].size_buf - *ppos;
+
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_from_user(image_ptr, buf, (unsigned long)count))
 		return -EFAULT;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec03863606e..f88809ff370b 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
+#include <linux/util_macros.h>
 
 #include <linux/dma/hsu.h>
 
@@ -368,8 +369,16 @@ static const struct mid8250_board dnv_board = {
 	.freq = 133333333,
 	.base_baud = 115200,
 	.bar = 1,
-	.setup = dnv_setup,
-	.exit = dnv_exit,
+	/*
+	 * Errata:
+	 * HSUART May Stop Functioning when DMA is Active.
+	 *
+	 * - Denverton document #572409, rev 3.4, DNV60
+	 * - Ice Lake Xeon D document #714070, ICXD65
+	 * - Snowridge document #731931, SNR44
+	 */
+	.setup = PTR_IF(false, dnv_setup),
+	.exit = PTR_IF(false, dnv_exit),
 };
 
 static const struct pci_device_id pci_ids[] = {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfdea0842149..763a3f1b7be0 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -765,16 +765,22 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
 /*
  * Compute xterm-style modifier parameter for CSI sequences.
  * Returns 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)
+ *
+ * Only the canonical modifier weights are counted. The left/right variants
+ * (KG_SHIFTL, KG_SHIFTR, KG_CTRLL, KG_CTRLR) and KG_ALTGR are commonly
+ * repurposed as keymap layout-group or level selectors rather than as plain
+ * modifiers (for instance XKB-derived keymaps select the layout group with
+ * KG_SHIFTL/KG_SHIFTR), so counting them would encode a spurious modifier.
  */
 static int csi_modifier_param(void)
 {
 	int mod = 1;
 
-	if (shift_state & (BIT(KG_SHIFT) | BIT(KG_SHIFTL) | BIT(KG_SHIFTR)))
+	if (shift_state & BIT(KG_SHIFT))
 		mod += 1;
-	if (shift_state & (BIT(KG_ALT) | BIT(KG_ALTGR)))
+	if (shift_state & BIT(KG_ALT))
 		mod += 2;
-	if (shift_state & (BIT(KG_CTRL) | BIT(KG_CTRLL) | BIT(KG_CTRLR)))
+	if (shift_state & BIT(KG_CTRL))
 		mod += 4;
 	return mod;
 }
diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index a2a1b21f2ef8..880097f1007d 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -631,6 +631,8 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 		}
 	}
 
+	cdnsp_free_stream_ctx(pdev, pep);
+
 cleanup_stream_rings:
 	kfree(pep->stream_info.stream_rings);
 
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index ddf0b5963859..3cb372721282 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1810,6 +1810,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x1901, 0x0006), /* GE Healthcare Patient Monitor UI Controller */
 	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
 	},
+	{ USB_DEVICE(0x1965, 0x0017), /* Uniden BC125AT */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 9b69148128e5..7e43429e996e 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -281,28 +281,24 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
 	ulpi->dev.type = &ulpi_dev_type;
+
+	device_initialize(&ulpi->dev);
+
 	dev_set_name(&ulpi->dev, "%s.ulpi", dev_name(dev));
 
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
 	ret = ulpi_of_register(ulpi);
-	if (ret) {
-		kfree(ulpi);
+	if (ret)
 		return ret;
-	}
 
 	ret = ulpi_read_id(ulpi);
-	if (ret) {
-		of_node_put(ulpi->dev.of_node);
-		kfree(ulpi);
+	if (ret)
 		return ret;
-	}
 
-	ret = device_register(&ulpi->dev);
-	if (ret) {
-		put_device(&ulpi->dev);
+	ret = device_add(&ulpi->dev);
+	if (ret)
 		return ret;
-	}
 
 	root = debugfs_create_dir(dev_name(&ulpi->dev), ulpi_root);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
@@ -334,9 +330,10 @@ struct ulpi *ulpi_register_interface(struct device *dev,
 	ulpi->ops = ops;
 
 	ret = ulpi_register(dev, ulpi);
-	if (ret)
+	if (ret) {
+		put_device(&ulpi->dev);
 		return ERR_PTR(ret);
-
+	}
 
 	return ulpi;
 }
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87810eff974e..87ee2d938bc0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -296,6 +296,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* CarrolTouch 4500U */
 	{ USB_DEVICE(0x04e7, 0x0030), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Samsung T5 EVO Portable SSD */
+	{ USB_DEVICE(0x04e8, 0x6200), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Samsung Android phone modem - ID conflict with SPH-I500 */
 	{ USB_DEVICE(0x04e8, 0x6601), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
@@ -576,6 +579,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* VLI disk */
 	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* VIA Labs, Inc. USB2.0 Hub */
+	{ USB_DEVICE(0x2109, 0x2817), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 65213896de99..6f3c00b08937 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -793,9 +793,9 @@ static void dwc3_ulpi_setup(struct dwc3 *dwc)
 
 	if (dwc->enable_usb2_transceiver_delay) {
 		for (index = 0; index < dwc->num_usb2_ports; index++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
+			reg = dwc3_readl(dwc, DWC3_GUSB2PHYCFG(index));
 			reg |= DWC3_GUSB2PHYCFG_XCVRDLY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+			dwc3_writel(dwc, DWC3_GUSB2PHYCFG(index), reg);
 		}
 	}
 }
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 55e144ba8cfc..4d611c08e8a4 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -907,35 +907,39 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		return ret;
+		goto err_rearm;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	/* Set PHY Power */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_power_on(priv->phys[i]);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	if (priv->vbus && priv->otg_phy_mode == PHY_MODE_USB_HOST) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	if (priv->drvdata->usb_post_init) {
 		ret = priv->drvdata->usb_post_init(priv);
 		if (ret)
-			return ret;
+			goto err_rearm;
 	}
 
 	return 0;
+
+err_rearm:
+	reset_control_rearm(priv->reset);
+	return ret;
 }
 
 static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3d4ca68e584c..1082e9c9afaa 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3934,15 +3934,48 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 }
 
+static bool dwc3_prepare_disconnect_gadget(struct dwc3 *dwc,
+					   struct usb_gadget_driver **driver,
+					   struct usb_gadget **gadget)
+{
+	if (!dwc->async_callbacks || !dwc->gadget_driver ||
+	    !dwc->gadget_driver->disconnect)
+		return false;
+
+	*driver = dwc->gadget_driver;
+	*gadget = dwc->gadget;
+
+	return true;
+}
+
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
+	struct usb_gadget_driver *driver;
+	struct usb_gadget *gadget;
+
+	if (dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(dwc->gadget);
+		driver->disconnect(gadget);
 		spin_lock(&dwc->lock);
 	}
 }
 
+static void dwc3_disconnect_gadget_sleepable(struct dwc3 *dwc)
+{
+	struct usb_gadget_driver *driver;
+	struct usb_gadget *gadget;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	driver->disconnect(gadget);
+}
+
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
@@ -4838,7 +4871,6 @@ EXPORT_SYMBOL_GPL(dwc3_gadget_exit);
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	unsigned long flags;
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
@@ -4852,10 +4884,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 		return -EAGAIN;
 	}
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dwc3_disconnect_gadget_sleepable(dwc);
 
 	return 0;
 }
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 1a48329a4e08..956be5b56510 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4267,8 +4267,6 @@ static int iso_stream_schedule(struct fotg210_hcd *fotg210, struct urb *urb,
 	return 0;
 
 fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -4562,6 +4560,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
 	else
 		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
 done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&fotg210->lock, flags);
 done:
 	return status;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index dc3664374596..df39e3487c1f 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1863,9 +1863,10 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				if (cdev->config)
 					config = cdev->config;
 				else
-					config = list_first_entry(
+					config = list_first_entry_or_null(
 							&cdev->configs,
-						struct usb_configuration, list);
+							struct usb_configuration,
+							list);
 				if (!config)
 					goto done;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 75912ce6ab55..44218be1e676 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -288,6 +288,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
+static void ffs_reset_work(struct work_struct *work);
 
 /* Misc helper functions ****************************************************/
 
@@ -1374,7 +1375,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&epfile->dmabufs_mutex);
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -1704,6 +1704,7 @@ static int ffs_dmabuf_transfer(struct file *file,
 	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base, resv_dir);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	/* Now that the dma_fence is in place, queue the transfer. */
@@ -2221,6 +2222,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	init_waitqueue_head(&ffs->ev.waitq);
 	init_waitqueue_head(&ffs->wait);
 	init_completion(&ffs->ep0req_completion);
+	INIT_WORK(&ffs->reset_work, ffs_reset_work);
 
 	/* XXX REVISIT need to update it in some places, or do we? */
 	ffs->ev.can_stall = 1;
@@ -2364,6 +2366,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
+		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
 		err = ffs_sb_create_file(ffs->sb, epfile->name,
 					 epfile, &ffs_epfile_operations);
 		if (err) {
@@ -2389,6 +2392,7 @@ static void ffs_epfiles_destroy(struct super_block *sb,
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		simple_remove_by_name(root, epfile->name, clear_one);
 	}
 
@@ -2453,7 +2457,6 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		ret = usb_ep_enable(ep->ep);
 		if (!ret) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;
@@ -3775,7 +3778,6 @@ static int ffs_func_set_alt(struct usb_function *f,
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
 		spin_unlock_irqrestore(&ffs->eps_lock, flags);
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
@@ -3806,7 +3808,6 @@ static void ffs_func_disable(struct usb_function *f)
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
 		spin_unlock_irqrestore(&ffs->eps_lock, flags);
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return;
 	}
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..837f753d0cae 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,12 +363,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	kref_get(&dev->kref);
-
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 3da54a7d7aba..a2fd239b7ad3 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -591,6 +591,7 @@ static int rndis_init_response(struct rndis_params *params,
 static int rndis_query_response(struct rndis_params *params,
 				rndis_query_msg_type *buf)
 {
+	u32 BufLength, BufOffset;
 	rndis_query_cmplt_type *resp;
 	rndis_resp_t *r;
 
@@ -598,6 +599,13 @@ static int rndis_query_response(struct rndis_params *params,
 	if (!params->dev)
 		return -ENOTSUPP;
 
+	BufLength = le32_to_cpu(buf->InformationBufferLength);
+	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
+	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
+	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
+	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
+		return -EINVAL;
+
 	/*
 	 * we need more memory:
 	 * gen_ndis_query_resp expects enough space for
@@ -614,10 +622,8 @@ static int rndis_query_response(struct rndis_params *params,
 	resp->RequestID = buf->RequestID; /* Still LE in msg buffer */
 
 	if (gen_ndis_query_resp(params, le32_to_cpu(buf->OID),
-			le32_to_cpu(buf->InformationBufferOffset)
-					+ 8 + (u8 *)buf,
-			le32_to_cpu(buf->InformationBufferLength),
-			r)) {
+				BufOffset + 8 + (u8 *)buf,
+				BufLength, r)) {
 		/* OID not supported */
 		resp->Status = cpu_to_le32(RNDIS_STATUS_NOT_SUPPORTED);
 		resp->MessageLength = cpu_to_le32(sizeof *resp);
@@ -1074,6 +1080,12 @@ int rndis_rm_hdr(struct gether *port,
 	/* tmp points to a struct rndis_packet_msg_type */
 	__le32 *tmp = (void *)skb->data;
 
+	/* Need at least MessageType, MessageLength, DataOffset, DataLength */
+	if (skb->len < 16) {
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
 	/* MessageType, MessageLength */
 	if (cpu_to_le32(RNDIS_MSG_PACKET)
 			!= get_unaligned(tmp++)) {
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e8861eaad907..068423fc581a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -31,8 +31,9 @@ static const struct bus_type gadget_bus_type;
 /**
  * struct usb_udc - describes one usb device controller
  * @driver: the gadget driver pointer. For use by the class code
- * @dev: the child device to the actual controller
  * @gadget: the gadget. For use by the class code
+ * @gadget_release: the gadget's release routine
+ * @dev: the child device to the actual controller
  * @list: for use by the udc class driver
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
@@ -53,6 +54,7 @@ static const struct bus_type gadget_bus_type;
 struct usb_udc {
 	struct usb_gadget_driver	*driver;
 	struct usb_gadget		*gadget;
+	void				(*gadget_release)(struct device *dev);
 	struct device			dev;
 	struct list_head		list;
 	bool				vbus;
@@ -1357,6 +1359,17 @@ static void usb_udc_nop_release(struct device *dev)
 	dev_vdbg(dev, "%s\n", __func__);
 }
 
+static void usb_gadget_release(struct device *dev)
+{
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	/* Cache the gadget's release routine to prevent UAF */
+	void (*release)(struct device *dev) = udc->gadget_release;
+
+	put_device(&udc->dev);
+	release(dev);
+}
+
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1413,6 +1426,14 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
+	/*
+	 * Align decoupled lifecycles: take a UDC reference to ensure it
+	 * remains allocated until the gadget is released, requiring an
+	 * override of the gadget's release routine to drop it.
+	 */
+	udc->gadget_release = gadget->dev.release;
+	gadget->dev.release = usb_gadget_release;
+	get_device(&udc->dev);
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
@@ -1457,6 +1478,12 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
+	/*
+	 * Revert the override and drop the UDC reference to prevent
+	 * leaking the UDC if the gadget was statically allocated.
+	 */
+	gadget->dev.release = udc->gadget_release;
+	put_device(&udc->dev);
 
  err_put_udc:
 	put_device(&udc->dev);
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index a241337c9af8..57d07d1c2dfa 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1623,6 +1623,7 @@ iso_stream_schedule(
 			status = 1;	/* and give it back immediately */
 			iso_sched_free(stream, sched);
 			sched = NULL;
+			urb->hcpriv = NULL;
 		}
 	}
 	urb->error_count = skip / period;
@@ -1653,8 +1654,6 @@ iso_stream_schedule(
 	return status;
 
  fail:
-	iso_sched_free(stream, sched);
-	urb->hcpriv = NULL;
 	return status;
 }
 
@@ -1966,6 +1965,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
@@ -2343,6 +2346,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
 		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
 	}
  done_not_linked:
+	if (status < 0) {
+		iso_sched_free(stream, urb->hcpriv);
+		urb->hcpriv = NULL;
+	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
  done:
 	return status;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 4ae47edd4b8b..b044977f6f56 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1591,6 +1591,7 @@ sl811h_remove(struct platform_device *dev)
 
 	remove_debug_file(sl811);
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 
 	/* some platforms may use IORESOURCE_IO */
 	res = platform_get_resource(dev, IORESOURCE_MEM, 1);
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 23153e136d4b..a5deeee4d5dc 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -58,6 +58,8 @@ xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring)
 	if (sg_alloc_table_from_pages(sgt, pages, n_pages, 0, sz, GFP_KERNEL))
 		goto err;
 
+	kvfree(pages);
+
 	/*
 	 * Save first segment dma address to sg dma_address field for the sideband
 	 * client to have access to the IOVA of the ring.
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a54f5b57f205..15346fdd66bc 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3788,6 +3788,7 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_virt_device *vdev;
 	struct xhci_command *command;
 	struct xhci_input_control_ctx *ctrl_ctx;
+	struct xhci_stream_info *stream_info[EP_CTX_PER_DEV];
 	unsigned int ep_index;
 	unsigned long flags;
 	u32 changed_ep_bitmask;
@@ -3848,10 +3849,15 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * dma_free_coherent() called by xhci_free_stream_info() may sleep,
+	 * so save stream_info pointers and clear references under lock,
+	 * then free the memory outside lock.
+	 */
 	spin_lock_irqsave(&xhci->lock, flags);
 	for (i = 0; i < num_eps; i++) {
 		ep_index = xhci_get_endpoint_index(&eps[i]->desc);
-		xhci_free_stream_info(xhci, vdev->eps[ep_index].stream_info);
+		stream_info[i] = vdev->eps[ep_index].stream_info;
 		vdev->eps[ep_index].stream_info = NULL;
 		/* FIXME Unset maxPstreams in endpoint context and
 		 * update deq ptr to point to normal string ring.
@@ -3861,6 +3867,9 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
+	for (i = 0; i < num_eps; i++)
+		xhci_free_stream_info(xhci, stream_info[i]);
+
 	return 0;
 }
 
diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index d8016540953f..9c06f7775301 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -320,7 +320,6 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 	mutex_unlock(&dev->lock);
 destruction:
 	mutex_unlock(&chaoskey_list_lock);
-	usb_dbg(interface, "release success");
 	return rv;
 }
 
diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
index 0f6b3464c2d6..3e37adf2bb57 100644
--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -63,6 +63,7 @@ MODULE_DEVICE_TABLE(usb, idmouse_table);
 
 /* structure to hold all of our device specific stuff */
 struct usb_idmouse {
+	struct kref kref;
 
 	struct usb_device *udev; /* save off the usb device pointer */
 	struct usb_interface *interface; /* the interface for this device */
@@ -209,8 +210,10 @@ static int idmouse_resume(struct usb_interface *intf)
 	return 0;
 }
 
-static inline void idmouse_delete(struct usb_idmouse *dev)
+static inline void idmouse_delete(struct kref *kref)
 {
+	struct usb_idmouse *dev = container_of(kref, struct usb_idmouse, kref);
+
 	kfree(dev->bulk_in_buffer);
 	kfree(dev);
 }
@@ -254,6 +257,8 @@ static int idmouse_open(struct inode *inode, struct file *file)
 		/* increment our usage count for the driver */
 		++dev->open;
 
+		kref_get(&dev->kref);
+
 		/* save our object in the file's private structure */
 		file->private_data = dev;
 
@@ -277,16 +282,11 @@ static int idmouse_release(struct inode *inode, struct file *file)
 
 	/* lock our device */
 	mutex_lock(&dev->lock);
-
 	--dev->open;
+	mutex_unlock(&dev->lock);
+
+	kref_put(&dev->kref, idmouse_delete);
 
-	if (!dev->present) {
-		/* the device was unplugged before the file was released */
-		mutex_unlock(&dev->lock);
-		idmouse_delete(dev);
-	} else {
-		mutex_unlock(&dev->lock);
-	}
 	return 0;
 }
 
@@ -334,6 +334,7 @@ static int idmouse_probe(struct usb_interface *interface,
 	if (dev == NULL)
 		return -ENOMEM;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->lock);
 	dev->udev = udev;
 	dev->interface = interface;
@@ -342,8 +343,7 @@ static int idmouse_probe(struct usb_interface *interface,
 	result = usb_find_bulk_in_endpoint(iface_desc, &endpoint);
 	if (result) {
 		dev_err(&interface->dev, "Unable to find bulk-in endpoint.\n");
-		idmouse_delete(dev);
-		return result;
+		goto err_put_kref;
 	}
 
 	dev->orig_bi_size = usb_endpoint_maxp(endpoint);
@@ -351,8 +351,8 @@ static int idmouse_probe(struct usb_interface *interface,
 	dev->bulk_in_endpointAddr = endpoint->bEndpointAddress;
 	dev->bulk_in_buffer = kmalloc(IMGSIZE + dev->bulk_in_size, GFP_KERNEL);
 	if (!dev->bulk_in_buffer) {
-		idmouse_delete(dev);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_put_kref;
 	}
 
 	/* allow device read, write and ioctl */
@@ -364,14 +364,18 @@ static int idmouse_probe(struct usb_interface *interface,
 	if (result) {
 		/* something prevented us from registering this device */
 		dev_err(&interface->dev, "Unable to allocate minor number.\n");
-		idmouse_delete(dev);
-		return result;
+		goto err_put_kref;
 	}
 
 	/* be noisy */
 	dev_info(&interface->dev,"%s now attached\n",DRIVER_DESC);
 
 	return 0;
+
+err_put_kref:
+	kref_put(&dev->kref, idmouse_delete);
+
+	return result;
 }
 
 static void idmouse_disconnect(struct usb_interface *interface)
@@ -387,14 +391,9 @@ static void idmouse_disconnect(struct usb_interface *interface)
 	/* prevent device read, write and ioctl */
 	dev->present = 0;
 
-	/* if the device is opened, idmouse_release will clean this up */
-	if (!dev->open) {
-		mutex_unlock(&dev->lock);
-		idmouse_delete(dev);
-	} else {
-		/* unlock */
-		mutex_unlock(&dev->lock);
-	}
+	mutex_unlock(&dev->lock);
+
+	kref_put(&dev->kref, idmouse_delete);
 
 	dev_info(&interface->dev, "disconnected\n");
 }
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 22504c0a2841..de2b236ef903 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -72,6 +72,7 @@ static struct usb_driver iowarrior_driver;
 
 /* Structure to hold all of our device specific stuff */
 struct iowarrior {
+	struct kref kref;
 	struct mutex mutex;			/* locks this structure */
 	struct usb_device *udev;		/* save off the usb device pointer */
 	struct usb_interface *interface;	/* the interface for this device */
@@ -240,8 +241,10 @@ static void iowarrior_write_callback(struct urb *urb)
 /*
  *	iowarrior_delete
  */
-static inline void iowarrior_delete(struct iowarrior *dev)
+static inline void iowarrior_delete(struct kref *kref)
 {
+	struct iowarrior *dev = container_of(kref, struct iowarrior, kref);
+
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
@@ -637,6 +640,9 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	}
 	/* increment our usage count for the driver */
 	++dev->opened;
+
+	kref_get(&dev->kref);
+
 	/* save our object in the file's private structure */
 	file->private_data = dev;
 	retval = 0;
@@ -652,7 +658,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 static int iowarrior_release(struct inode *inode, struct file *file)
 {
 	struct iowarrior *dev;
-	int retval = 0;
 
 	dev = file->private_data;
 	if (!dev)
@@ -660,29 +665,18 @@ static int iowarrior_release(struct inode *inode, struct file *file)
 
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
@@ -767,6 +761,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 	if (!dev)
 		return retval;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 
 	atomic_set(&dev->intr_idx, 0);
@@ -885,7 +880,8 @@ static int iowarrior_probe(struct usb_interface *interface,
 	return retval;
 
 error:
-	iowarrior_delete(dev);
+	kref_put(&dev->kref, iowarrior_delete);
+
 	return retval;
 }
 
@@ -905,21 +901,18 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	/* prevent device read, write and ioctl */
 	dev->present = 0;
 
+	/* write urbs are not stopped on close() so kill unconditionally */
+	usb_kill_anchored_urbs(&dev->submitted);
+
 	if (dev->opened) {
-		/* There is a process that holds a filedescriptor to the device ,
-		   so we only shutdown read-/write-ops going on.
-		   Deleting the device is postponed until close() was called.
-		 */
 		usb_kill_urb(dev->int_in_urb);
-		usb_kill_anchored_urbs(&dev->submitted);
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
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index c74f142f6637..71132a15e771 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -150,6 +150,7 @@ MODULE_PARM_DESC(min_interrupt_out_interval, "Minimum interrupt out interval in
 
 /* Structure to hold all of our device specific stuff */
 struct ld_usb {
+	struct kref		kref;
 	struct mutex		mutex;		/* locks this structure */
 	struct usb_interface	*intf;		/* save off the usb interface pointer */
 	unsigned long		disconnected:1;
@@ -201,8 +202,10 @@ static void ld_usb_abort_transfers(struct ld_usb *dev)
 /*
  *	ld_usb_delete
  */
-static void ld_usb_delete(struct ld_usb *dev)
+static void ld_usb_delete(struct kref *kref)
 {
+	struct ld_usb *dev = container_of(kref, struct ld_usb, kref);
+
 	/* free data structures */
 	usb_free_urb(dev->interrupt_in_urb);
 	usb_free_urb(dev->interrupt_out_urb);
@@ -355,6 +358,8 @@ static int ld_usb_open(struct inode *inode, struct file *file)
 		goto unlock_exit;
 	}
 
+	kref_get(&dev->kref);
+
 	/* save device in the file's private structure */
 	file->private_data = dev;
 
@@ -381,17 +386,8 @@ static int ld_usb_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&dev->mutex);
 
-	if (dev->open_count != 1) {
-		retval = -ENODEV;
+	if (dev->disconnected)
 		goto unlock_exit;
-	}
-	if (dev->disconnected) {
-		/* the device was unplugged before the file was released */
-		mutex_unlock(&dev->mutex);
-		/* unlock here as ld_usb_delete frees dev */
-		ld_usb_delete(dev);
-		goto exit;
-	}
 
 	/* wait until write transfer is finished */
 	if (dev->interrupt_out_busy)
@@ -401,7 +397,7 @@ static int ld_usb_release(struct inode *inode, struct file *file)
 
 unlock_exit:
 	mutex_unlock(&dev->mutex);
-
+	kref_put(&dev->kref, ld_usb_delete);
 exit:
 	return retval;
 }
@@ -659,6 +655,8 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	dev = kzalloc_obj(*dev);
 	if (!dev)
 		goto exit;
+
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 	spin_lock_init(&dev->rbsl);
 	dev->intf = intf;
@@ -740,7 +738,7 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	return retval;
 
 error:
-	ld_usb_delete(dev);
+	kref_put(&dev->kref, ld_usb_delete);
 
 	return retval;
 }
@@ -768,18 +766,18 @@ static void ld_usb_disconnect(struct usb_interface *intf)
 
 	mutex_lock(&dev->mutex);
 
-	/* if the device is not opened, then we clean up right now */
-	if (!dev->open_count) {
-		mutex_unlock(&dev->mutex);
-		ld_usb_delete(dev);
-	} else {
-		dev->disconnected = 1;
+	dev->disconnected = 1;
+
+	if (dev->open_count) {
 		/* wake up pollers */
 		wake_up_interruptible_all(&dev->read_wait);
 		wake_up_interruptible_all(&dev->write_wait);
-		mutex_unlock(&dev->mutex);
 	}
 
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, ld_usb_delete);
+
 	dev_info(&intf->dev, "LD USB Device #%d now disconnected\n",
 		 (minor - USB_LD_MINOR_BASE));
 }
diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 052ffc2e71ee..18dd4115befb 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -185,6 +185,7 @@ MODULE_DEVICE_TABLE(usb, tower_table);
 
 /* Structure to hold all of our device specific stuff */
 struct lego_usb_tower {
+	struct kref		kref;
 	struct mutex		lock;		/* locks this structure */
 	struct usb_device	*udev;		/* save off the usb device pointer */
 	unsigned char		minor;		/* the starting minor number for this device */
@@ -220,7 +221,6 @@ struct lego_usb_tower {
 /* local function prototypes */
 static ssize_t tower_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos);
 static ssize_t tower_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos);
-static inline void tower_delete(struct lego_usb_tower *dev);
 static int tower_open(struct inode *inode, struct file *file);
 static int tower_release(struct inode *inode, struct file *file);
 static __poll_t tower_poll(struct file *file, poll_table *wait);
@@ -286,8 +286,10 @@ static inline void lego_usb_tower_debug_data(struct device *dev,
 /*
  *	tower_delete
  */
-static inline void tower_delete(struct lego_usb_tower *dev)
+static inline void tower_delete(struct kref *kref)
 {
+	struct lego_usb_tower *dev = container_of(kref, struct lego_usb_tower, kref);
+
 	/* free data structures */
 	usb_free_urb(dev->interrupt_in_urb);
 	usb_free_urb(dev->interrupt_out_urb);
@@ -381,6 +383,8 @@ static int tower_open(struct inode *inode, struct file *file)
 
 	dev->open_count = 1;
 
+	kref_get(&dev->kref);
+
 unlock_exit:
 	mutex_unlock(&dev->lock);
 
@@ -404,14 +408,8 @@ static int tower_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&dev->lock);
 
-	if (dev->disconnected) {
-		/* the device was unplugged before the file was released */
-
-		/* unlock here as tower_delete frees dev */
-		mutex_unlock(&dev->lock);
-		tower_delete(dev);
-		goto exit;
-	}
+	if (dev->disconnected)
+		goto out_unlock;
 
 	/* wait until write transfer is finished */
 	if (dev->interrupt_out_busy) {
@@ -425,7 +423,9 @@ static int tower_release(struct inode *inode, struct file *file)
 
 	dev->open_count = 0;
 
+out_unlock:
 	mutex_unlock(&dev->lock);
+	kref_put(&dev->kref, tower_delete);
 exit:
 	return retval;
 }
@@ -752,6 +752,7 @@ static int tower_probe(struct usb_interface *interface, const struct usb_device_
 	if (!dev)
 		goto exit;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->lock);
 	dev->udev = usb_get_dev(udev);
 	spin_lock_init(&dev->read_buffer_lock);
@@ -828,7 +829,7 @@ static int tower_probe(struct usb_interface *interface, const struct usb_device_
 	return retval;
 
 error:
-	tower_delete(dev);
+	kref_put(&dev->kref, tower_delete);
 	return retval;
 }
 
@@ -856,18 +857,18 @@ static void tower_disconnect(struct usb_interface *interface)
 
 	mutex_lock(&dev->lock);
 
-	/* if the device is not opened, then we clean up right now */
-	if (!dev->open_count) {
-		mutex_unlock(&dev->lock);
-		tower_delete(dev);
-	} else {
-		dev->disconnected = 1;
+	dev->disconnected = 1;
+
+	if (dev->open_count) {
 		/* wake up pollers */
 		wake_up_interruptible_all(&dev->read_wait);
 		wake_up_interruptible_all(&dev->write_wait);
-		mutex_unlock(&dev->lock);
 	}
 
+	mutex_unlock(&dev->lock);
+
+	kref_put(&dev->kref, tower_delete);
+
 	dev_info(&interface->dev, "LEGO USB Tower #%d now disconnected\n",
 		 (minor - LEGO_USB_TOWER_MINOR_BASE));
 }
diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
index 02d1e0760f0c..3c2474dca810 100644
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -344,6 +344,10 @@ int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
 	if (ibuf_len < bpkt_len)
 		return -ENOSPC;
 
+	/* The device must not claim more payload than it actually sent. */
+	if (bpkt_len > act - sizeof(*bpkt))
+		return -EPROTO;
+
 	memcpy(ibuf, bpkt->data, bpkt_len);
 
 	return bpkt_len;
@@ -518,7 +522,7 @@ static int usbio_resume(struct usb_interface *intf)
 static void usbio_disconnect(struct usb_interface *intf)
 {
 	struct usbio_device *usbio = usb_get_intfdata(intf);
-	struct usbio_client *client;
+	struct usbio_client *client, *next;
 
 	/* Wakeup any clients waiting for a reply */
 	usbio->rxdat_len = 0;
@@ -535,7 +539,7 @@ static void usbio_disconnect(struct usb_interface *intf)
 	usb_kill_urb(usbio->urb);
 	usb_free_urb(usbio->urb);
 
-	list_for_each_entry_reverse(client, &usbio->cli_list, link) {
+	list_for_each_entry_safe_reverse(client, next, &usbio->cli_list, link) {
 		auxiliary_device_delete(&client->auxdev);
 		auxiliary_device_uninit(&client->auxdev);
 	}
diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index b7d3c44b970e..1ce48f5832d7 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -732,8 +732,11 @@ static int uss720_probe(struct usb_interface *intf,
 	 * here. */
 	ret = get_1284_register(pp, 0, &reg, GFP_KERNEL);
 	dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
-	if (ret < 0)
+	if (ret < 0) {
+		priv->pp = NULL;
+		parport_del_port(pp);
 		goto probe_abort;
+	}
 
 	ret = usb_find_last_int_in_endpoint(interface, &epd);
 	if (!ret) {
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da29f467943f..f224f2ee379a 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -305,6 +305,7 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
 
 	if (mtu3_prepare_transfer(mep)) {
 		ret = -EAGAIN;
+		usb_gadget_unmap_request(&mtu->g, req, mep->is_in);
 		goto error;
 	}
 
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index c481208255eb..c96e5b76f313 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -394,12 +394,14 @@ static int digi_write_oob_command(struct usb_serial_port *port,
 			len &= ~3;
 		memcpy(oob_port->write_urb->transfer_buffer, buf, len);
 		oob_port->write_urb->transfer_buffer_length = len;
+
 		ret = usb_submit_urb(oob_port->write_urb, GFP_ATOMIC);
-		if (ret == 0) {
-			oob_priv->dp_write_urb_in_use = 1;
-			count -= len;
-			buf += len;
-		}
+		if (ret)
+			break;
+
+		oob_priv->dp_write_urb_in_use = 1;
+		count -= len;
+		buf += len;
 	}
 	spin_unlock_irqrestore(&oob_priv->dp_port_lock, flags);
 	if (ret)
@@ -429,20 +431,22 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 	int len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
+	unsigned long expire;
 	unsigned long flags;
 
 	dev_dbg(&port->dev, "digi_write_inb_command: TOP: port=%d, count=%d\n",
 		priv->dp_port_num, count);
 
 	if (timeout)
-		timeout += jiffies;
-	else
-		timeout = ULONG_MAX;
+		expire = jiffies + timeout;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
 	while (count > 0 && ret == 0) {
-		while (priv->dp_write_urb_in_use &&
-		       time_before(jiffies, timeout)) {
+		while (priv->dp_write_urb_in_use) {
+			if (timeout && time_after(jiffies, expire)) {
+				ret = -ETIMEDOUT;
+				break;
+			}
 			cond_wait_interruptible_timeout_irqrestore(
 				&priv->write_wait, DIGI_RETRY_TIMEOUT,
 				&priv->dp_port_lock, flags);
@@ -451,6 +455,9 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 			spin_lock_irqsave(&priv->dp_port_lock, flags);
 		}
 
+		if (ret)
+			break;
+
 		/* len must be a multiple of 4 and small enough to */
 		/* guarantee the write will send buffered data first, */
 		/* so commands are in order with data and not split */
@@ -1071,6 +1078,7 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char buf[32];
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	struct ktermios not_termios;
+	int throttled;
 
 	/* be sure the device is started up */
 	if (digi_startup_device(port->serial) != 0)
@@ -1098,6 +1106,21 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 		not_termios.c_iflag = ~tty->termios.c_iflag;
 		digi_set_termios(tty, port, &not_termios);
 	}
+
+	spin_lock_irq(&priv->dp_port_lock);
+	throttled = priv->dp_throttle_restart;
+	priv->dp_throttled = 0;
+	priv->dp_throttle_restart = 0;
+	spin_unlock_irq(&priv->dp_port_lock);
+
+	if (throttled) {
+		ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
+		if (ret) {
+			dev_err(&port->dev, "failed to submit read urb: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 5036600dd334..377f5695cfc6 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -518,7 +518,7 @@ static int keyspan_pda_write_start(struct usb_serial_port *port)
 	if (count == room)
 		schedule_work(&priv->unthrottle_work);
 
-	return count;
+	return 0;
 }
 
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index a34e79cfd5b6..7a0f37feb9f2 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1326,6 +1326,22 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_CC864_SINGLE) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_DE910_DUAL) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_UE910_V2) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0990, 0xff, 0xff, 0x30),	/* Telit FE990D50 (RNDIS) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0990, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0990, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0991, 0xff, 0xff, 0x30),	/* Telit FE990D50 (rmnet) */
+	  .driver_info = NCTRL(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0991, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0991, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0992, 0xff, 0xff, 0x30),	/* Telit FE990D50 (MBIM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0992, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0992, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0993, 0xff, 0xff, 0x30),	/* Telit FE990D50 (ECM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0993, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0993, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1031, 0xff),	/* Telit LE910C1-EUX */
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 8770de01a384..ed49a3bc859c 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2305,7 +2305,8 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status & SD_Ready) || (info->MS_Status & MS_Ready)))
+	if (unlikely(!(info->SD_Status & SD_Ready) &&
+		     !(info->MS_Status & MS_Ready)))
 		result = ene_init(us);
 	if (result == USB_STOR_XFER_GOOD) {
 		result = USB_STOR_TRANSPORT_ERROR;
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index fa83fe0defe2..064c7fc8e368 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -570,7 +570,7 @@ void usb_stor_adjust_quirks(struct usb_device *udev, u64 *fflags)
 			US_FL_INITIAL_READ10 | US_FL_WRITE_CACHE |
 			US_FL_NO_ATA_1X | US_FL_NO_REPORT_OPCODES |
 			US_FL_MAX_SECTORS_240 | US_FL_NO_REPORT_LUNS |
-			US_FL_ALWAYS_SYNC);
+			US_FL_ALWAYS_SYNC | US_FL_NO_SAME);
 
 	p = quirks;
 	while (*p) {
diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 2e8ae1d2faf9..db917b05dcde 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1537,7 +1537,9 @@ static int anx7411_i2c_probe(struct i2c_client *client)
 	if (anx7411_typec_check_connection(plat))
 		dev_err(dev, "check status\n");
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		goto free_wq;
 
 	return 0;
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 0977581ad1b6..0595e8cb83aa 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1619,6 +1619,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 		return -EINVAL;
 
 	ret = port->ops->pd_set(port, pd);
+	put_device(&pd->dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index db5e4a4c0a99..9b908c46bd7d 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -275,9 +275,7 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 static void *typec_mux_match(const struct fwnode_handle *fwnode,
 			     const char *id, void *data)
 {
-	struct typec_mux_dev **mux_devs = data;
 	struct device *dev;
-	int i;
 
 	/*
 	 * Device graph (OF graph) does not give any means to identify the
@@ -293,14 +291,6 @@ static void *typec_mux_match(const struct fwnode_handle *fwnode,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
-	/* Skip duplicates */
-	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
-		if (to_typec_mux_dev(dev) == mux_devs[i]) {
-			put_device(dev);
-			return NULL;
-		}
-
-
 	return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
@@ -326,8 +316,7 @@ struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
 		return ERR_PTR(-ENOMEM);
 
 	count = fwnode_connection_find_matches(fwnode, "mode-switch",
-					       (void **)mux_devs,
-					       typec_mux_match,
+					       NULL, typec_mux_match,
 					       (void **)mux_devs,
 					       ARRAY_SIZE(mux_devs));
 	if (count <= 0) {
diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 1256252eceed..c9bf4b4c2ba1 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -118,12 +118,12 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 				CONN_STATUS_1_DP_HPD_LEVEL;
 
 			switch (state->mode)  {
+			case TYPEC_DP_STATE_D:
+				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
+				fallthrough;
 			case TYPEC_DP_STATE_C:
 				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
 					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
-				fallthrough;
-			case TYPEC_DP_STATE_D:
-				cfg1 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 				break;
 			default: /* MODE_E */
 				break;
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 4b3e4e22a82e..0af95c2d33fc 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -295,6 +295,8 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 	return 0;
 }
 
+static void rt1711h_unregister_tcpci_port(void *tcpci);
+
 static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
@@ -340,6 +342,10 @@ static int rt1711h_probe(struct i2c_client *client)
 	if (IS_ERR_OR_NULL(chip->tcpci))
 		return PTR_ERR(chip->tcpci);
 
+	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
+	if (ret)
+		return ret;
+
 	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
 					rt1711h_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
@@ -357,11 +363,9 @@ static int rt1711h_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void rt1711h_remove(struct i2c_client *client)
+static void rt1711h_unregister_tcpci_port(void *tcpci)
 {
-	struct rt1711h_chip *chip = i2c_get_clientdata(client);
-
-	tcpci_unregister_port(chip->tcpci);
+	tcpci_unregister_port(tcpci);
 }
 
 static const struct rt1711h_chip_info rt1711h = {
@@ -394,7 +398,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
 		.of_match_table = rt1711h_of_match,
 	},
 	.probe = rt1711h_probe,
-	.remove = rt1711h_remove,
 	.id_table = rt1711h_id,
 };
 module_i2c_driver(rt1711h_i2c_driver);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7ef746a90a17..89eec20a2064 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2000,6 +2000,11 @@ static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt,
 		return;
 	}
 
+	if (pmdata->svid_index < 0 || pmdata->svid_index >= pmdata->nsvids) {
+		tcpm_log(port, "Invalid SVID index %d", pmdata->svid_index);
+		return;
+	}
+
 	for (i = 1; i < cnt; i++) {
 		if (pmdata->altmodes >= ALTMODE_DISCOVERY_MAX) {
 			/* Already logged in svdm_consume_svids() */
@@ -3088,7 +3093,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
@@ -3136,7 +3141,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
 	if (svdm_version < 0)
 		return svdm_version;
 
-	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
+	header = VDO(altmode->svid, 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
 	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 67a0991a7b76..7067f2561b84 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -166,12 +166,12 @@ static int ucsi_displayport_status_update(struct ucsi_dp *dp)
 	 * that Multi-function is preferred.
 	 */
 	if (DP_CAP_CAPABILITY(cap) & DP_CAP_UFP_D) {
-		dp->data.status |= DP_STATUS_CON_UFP_D;
+		dp->data.status |= DP_STATUS_CON_DFP_D;
 
 		if (DP_CAP_UFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
 			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
 	} else {
-		dp->data.status |= DP_STATUS_CON_DFP_D;
+		dp->data.status |= DP_STATUS_CON_UFP_D;
 
 		if (DP_CAP_DFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
 			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
@@ -185,13 +185,12 @@ static int ucsi_displayport_status_update(struct ucsi_dp *dp)
 
 static int ucsi_displayport_configure(struct ucsi_dp *dp)
 {
-	u32 pins = DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
 	u64 command;
 
 	if (!dp->override)
 		return 0;
 
-	command = UCSI_CMD_SET_NEW_CAM(dp->con->num, 1, dp->offset, pins);
+	command = UCSI_CMD_SET_NEW_CAM(dp->con->num, 1, dp->offset, dp->data.conf);
 
 	return ucsi_send_command(dp->con->ucsi, command, NULL, 0);
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61cb24ed820f..66b879957165 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1978,6 +1978,26 @@ static void ucsi_resume_work(struct work_struct *work)
 	}
 }
 
+int ucsi_suspend(struct ucsi *ucsi)
+{
+	int i;
+
+	/*
+	 * Cancel pending work so it cannot access the firmware after the ACPI
+	 * EC is stopped for suspend; state is re-read on resume.
+	 */
+	cancel_delayed_work_sync(&ucsi->work);
+
+	if (!ucsi->connector)
+		return 0;
+
+	for (i = 0; i < ucsi->cap.num_connectors; i++)
+		cancel_work_sync(&ucsi->connector[i].work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ucsi_suspend);
+
 int ucsi_resume(struct ucsi *ucsi)
 {
 	if (ucsi->connector)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cff9ddc2ae21..dd64ddc42118 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -566,6 +566,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 		      void *retval, size_t size);
 
 void ucsi_altmode_update_active(struct ucsi_connector *con);
+int ucsi_suspend(struct ucsi *ucsi);
 int ucsi_resume(struct ucsi *ucsi);
 
 void ucsi_notify_common(struct ucsi *ucsi, u32 cci);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6b92f296e985..94b52ccf6f42 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -245,6 +245,13 @@ static void ucsi_acpi_remove(struct platform_device *pdev)
 				   ucsi_acpi_notify);
 }
 
+static int ucsi_acpi_suspend(struct device *dev)
+{
+	struct ucsi_acpi *ua = dev_get_drvdata(dev);
+
+	return ucsi_suspend(ua->ucsi);
+}
+
 static int ucsi_acpi_resume(struct device *dev)
 {
 	struct ucsi_acpi *ua = dev_get_drvdata(dev);
@@ -252,7 +259,8 @@ static int ucsi_acpi_resume(struct device *dev)
 	return ucsi_resume(ua->ucsi);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_acpi_pm_ops, NULL, ucsi_acpi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_acpi_pm_ops, ucsi_acpi_suspend,
+				ucsi_acpi_resume);
 
 static const struct acpi_device_id ucsi_acpi_match[] = {
 	{ "PNP0CA0", 0 },
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 4463c1ae96bd..51498329a4d5 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1519,8 +1519,8 @@ static void ucsi_ccg_remove(struct i2c_client *client)
 	cancel_work_sync(&uc->work);
 	pm_runtime_disable(uc->dev);
 	ucsi_unregister(uc->ucsi);
-	ucsi_destroy(uc->ucsi);
 	free_irq(uc->irq, uc);
+	ucsi_destroy(uc->ucsi);
 }
 
 static const struct of_device_id ucsi_ccg_of_match_table[] = {
diff --git a/drivers/usb/usbip/vudc.h b/drivers/usb/usbip/vudc.h
index faf61c9c6a98..5ef0e7d9b23a 100644
--- a/drivers/usb/usbip/vudc.h
+++ b/drivers/usb/usbip/vudc.h
@@ -38,7 +38,6 @@ struct vep {
 
 struct vrequest {
 	struct usb_request req;
-	struct vudc *udc;
 	struct list_head req_entry; /* Request queue */
 };
 
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index c5f079c5a1ea..5ef88117965d 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -333,7 +333,6 @@ static int vep_queue(struct usb_ep *_ep, struct usb_request *_req,
 static int vep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct vep *ep;
-	struct vrequest *req;
 	struct vudc *udc;
 	struct vrequest *lst;
 	unsigned long flags;
@@ -343,8 +342,7 @@ static int vep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		return ret;
 
 	ep = to_vep(_ep);
-	req = to_vrequest(_req);
-	udc = req->udc;
+	udc = ep_to_vudc(ep);
 
 	if (!udc->driver)
 		return -ESHUTDOWN;
diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
index 8b0ca7a09064..8a2f1b0cce3f 100644
--- a/drivers/vfio/debugfs.c
+++ b/drivers/vfio/debugfs.c
@@ -97,6 +97,7 @@ void vfio_device_debugfs_init(struct vfio_device *vdev)
 void vfio_device_debugfs_exit(struct vfio_device *vdev)
 {
 	debugfs_remove_recursive(vdev->debug_root);
+	vdev->debug_root = NULL;
 }
 
 void vfio_debugfs_create_root(void)
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..c86d8b243a52 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,26 +158,29 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
 	struct vfio_pci_core_device core_device;
 	int vf_id;
 	u16 vhca_id;
+	/* Flags only modified on setup/release - bitfield ok */
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
-	u8 mdev_detach:1;
-	u8 log_active:1;
 	u8 chunk_mode:1;
 	u8 mig_state_cap:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..beb1674c6945 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -271,8 +271,11 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	int ret;
 
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (pci_num_vf(pdev) && state > PCI_D0)
-		return -EBUSY;
+	if (state > PCI_D0) {
+		lockdep_assert_held_write(&vdev->memory_lock);
+		if (vdev->sriov_active)
+			return -EBUSY;
+	}
 
 	if (vdev->needs_pm_restore) {
 		if (pdev->current_state < PCI_D3hot && state >= PCI_D3hot) {
@@ -535,7 +538,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
-	if (!disable_idle_d3) {
+	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
 			return ret;
@@ -614,7 +617,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 	return ret;
 }
@@ -750,7 +753,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
 
 	/* Put the pm-runtime usage counter acquired during enable */
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
@@ -2142,6 +2145,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	vdev->disable_idle_d3 = disable_idle_d3;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2237,7 +2242,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 
 	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
 
 	ret = vfio_register_group_dev(&vdev->vdev);
@@ -2246,10 +2251,11 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	return 0;
 
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 	return ret;
@@ -2265,7 +2271,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
 
 	pm_runtime_forbid(&vdev->pdev->dev);
@@ -2327,8 +2333,9 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 
 		down_write(&vdev->memory_lock);
 		vfio_pci_set_power_state(vdev, PCI_D0);
-		ret = pci_enable_sriov(pdev, nr_virtfn);
+		vdev->sriov_active = true;
 		up_write(&vdev->memory_lock);
+		ret = pci_enable_sriov(pdev, nr_virtfn);
 		if (ret) {
 			pm_runtime_put(&pdev->dev);
 			goto out_del;
@@ -2342,6 +2349,13 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	}
 
 out_del:
+	/*
+	 * Avoid taking the memory_lock intentionally. A race with a power
+	 * state transition would at most result in an -EBUSY, leaving the
+	 * device in PCI_D0.
+	 */
+	vdev->sriov_active = false;
+
 	mutex_lock(&vfio_pci_sriov_pfs_mutex);
 	list_del_init(&vdev->sriov_pfs_item);
 out_unlock:
@@ -2589,7 +2603,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	 * state. Increment the usage count for all the devices in the dev_set
 	 * before reset and decrement the same after reset.
 	 */
-	if (!disable_idle_d3 && vfio_pci_dev_set_pm_runtime_get(dev_set))
+	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
 		return;
 
 	if (!pci_reset_bus(pdev))
@@ -2599,8 +2613,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 		if (reset_done)
 			cur->needs_reset = false;
 
-		if (!disable_idle_d3)
-			pm_runtime_put(&cur->pdev->dev);
+		pm_runtime_put(&cur->pdev->dev);
 	}
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..ed538aebb0b8 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -406,6 +406,13 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	 */
 	vfio_device_group_unregister(device);
 
+	/*
+	 * Remove debugfs before device_del(), which releases devres.  Some
+	 * debugfs entries are created with debugfs_create_devm_seqfile() and
+	 * therefore rely on devres-managed inode private data.
+	 */
+	vfio_device_debugfs_exit(device);
+
 	/*
 	 * Balances vfio_device_add() in register path, also prevents
 	 * new device opened by userspace in the cdev path.
@@ -435,7 +442,6 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 		}
 	}
 
-	vfio_device_debugfs_exit(device);
 	/* Balances vfio_device_set_group in register path */
 	vfio_device_remove_group(device);
 }
@@ -858,7 +864,8 @@ int vfio_mig_get_next_state(struct vfio_device *device,
 	 * logical state, as per the above comment.
 	 */
 	*next_fsm = vfio_from_fsm_table[cur_fsm][new_fsm];
-	while ((state_flags_table[*next_fsm] & device->migration_flags) !=
+	while (*next_fsm != VFIO_DEVICE_STATE_ERROR &&
+	       (state_flags_table[*next_fsm] & device->migration_flags) !=
 			state_flags_table[*next_fsm])
 		*next_fsm = vfio_from_fsm_table[*next_fsm][new_fsm];
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..510b7c4efdff 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -662,9 +662,7 @@ static void virtio_mmio_remove(struct platform_device *pdev)
 
 #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
 
-static struct device vm_cmdline_parent = {
-	.init_name = "virtio-mmio-cmdline",
-};
+static struct device *vm_cmdline_parent;
 
 static int vm_cmdline_parent_registered;
 static int vm_cmdline_id;
@@ -672,7 +670,6 @@ static int vm_cmdline_id;
 static int vm_cmdline_set(const char *device,
 		const struct kernel_param *kp)
 {
-	int err;
 	struct resource resources[2] = {};
 	char *str;
 	long long base, size;
@@ -704,11 +701,10 @@ static int vm_cmdline_set(const char *device,
 	resources[1].start = resources[1].end = irq;
 
 	if (!vm_cmdline_parent_registered) {
-		err = device_register(&vm_cmdline_parent);
-		if (err) {
-			put_device(&vm_cmdline_parent);
+		vm_cmdline_parent = __root_device_register("virtio-mmio-cmdline", NULL);
+		if (IS_ERR(vm_cmdline_parent)) {
 			pr_err("Failed to register parent device!\n");
-			return err;
+			return PTR_ERR(vm_cmdline_parent);
 		}
 		vm_cmdline_parent_registered = 1;
 	}
@@ -719,7 +715,7 @@ static int vm_cmdline_set(const char *device,
 		       (unsigned long long)resources[0].end,
 		       (int)resources[1].start);
 
-	pdev = platform_device_register_resndata(&vm_cmdline_parent,
+	pdev = platform_device_register_resndata(vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
 			resources, ARRAY_SIZE(resources), NULL, 0);
 
@@ -743,8 +739,12 @@ static int vm_cmdline_get_device(struct device *dev, void *data)
 static int vm_cmdline_get(char *buffer, const struct kernel_param *kp)
 {
 	buffer[0] = '\0';
-	device_for_each_child(&vm_cmdline_parent, buffer,
-			vm_cmdline_get_device);
+
+	if (vm_cmdline_parent_registered) {
+		device_for_each_child(vm_cmdline_parent, buffer,
+				vm_cmdline_get_device);
+	}
+
 	return strlen(buffer) + 1;
 }
 
@@ -766,9 +766,9 @@ static int vm_unregister_cmdline_device(struct device *dev,
 static void vm_unregister_cmdline_devices(void)
 {
 	if (vm_cmdline_parent_registered) {
-		device_for_each_child(&vm_cmdline_parent, NULL,
+		device_for_each_child(vm_cmdline_parent, NULL,
 				vm_unregister_cmdline_device);
-		device_unregister(&vm_cmdline_parent);
+		root_device_unregister(vm_cmdline_parent);
 		vm_cmdline_parent_registered = 0;
 	}
 }
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index da97b6a988de..164f480b18a6 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -423,10 +423,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
 					     vqi->name, vqi->ctx, false,
 					     &allocated_vectors, vector_policy,
-					     &vp_dev->vqs[i]);
+					     &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -485,9 +486,10 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
 				     vqi->name, vqi->ctx,
-				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
+				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
index 66a158f67a71..6b9b0f9b05ce 100644
--- a/drivers/watchdog/apple_wdt.c
+++ b/drivers/watchdog/apple_wdt.c
@@ -218,6 +218,7 @@ static int apple_wdt_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
 
 static const struct of_device_id apple_wdt_of_match[] = {
+	{ .compatible = "apple,t8103-wdt" },
 	{ .compatible = "apple,wdt" },
 	{},
 };
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 55c272fe5d92..5d8fda94fe22 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -569,6 +569,8 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
+int btrfs_reset_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
+				unsigned int extra_bits, struct extent_state **cached_state);
 
 struct btrfs_new_inode_args {
 	/* Input */
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 57167d56dc72..412309825d6f 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -15,10 +15,12 @@
 
 struct btrfs_dio_data {
 	ssize_t submitted;
+	loff_t old_isize;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
 	bool data_space_reserved;
 	bool nocow_done;
+	bool updated_isize;
 };
 
 struct btrfs_dio_private {
@@ -228,6 +230,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	bool space_reserved = false;
 	u64 len = *lenp;
 	u64 prev_len;
+	loff_t old_isize;
 	int ret = 0;
 
 	/*
@@ -341,8 +344,14 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
-	if (start + len > i_size_read(inode))
+	old_isize = i_size_read(inode);
+	if (start + len > old_isize) {
+		if (!dio_data->updated_isize) {
+			dio_data->old_isize = old_isize;
+			dio_data->updated_isize = true;
+		}
 		i_size_write(inode, start + len);
+	}
 out:
 	if (ret && space_reserved) {
 		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
@@ -624,12 +633,55 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
+		if (write) {
+			/*
+			 * Got a short write and have updated the isize, need to
+			 * revert the isize change.
+			 *
+			 * Normally we need to update isize with extent lock hold,
+			 * but we're safe due to the following factors:
+			 *
+			 * - Only a single writer can be enlarging isize
+			 *   Enlarging isize will take the exclusive inode lock.
+			 *
+			 * - Buffered readers need to wait for the OE we're holding
+			 *   Buffered readers will lock extent and wait for OE
+			 *   of the folio range, and since page cache is invalidated
+			 *   the OE wait can not be skipped.
+			 *
+			 * So here we are safe to revert the isize before
+			 * finishing the OE, and no reader of the remaining range
+			 * can see the enlarged size.
+			 *
+			 * TODO: Extend the DIO_LOCKED lifespan for direct writes,
+			 * and only enlarge isize after a successful write.
+			 */
+			if (dio_data->updated_isize) {
+				u64 new_isize;
+
+				if (submitted == 0)
+					new_isize = dio_data->old_isize;
+				else
+					new_isize = max(dio_data->old_isize, pos);
+				i_size_write(inode, new_isize);
+				dio_data->updated_isize = false;
+			}
+			/*
+			 * We have a short write, if there is any range
+			 * that is submitted properly, that part will have
+			 * its own OE split from the original one.
+			 *
+			 * So for the OE at dio_data->ordered, it's the part
+			 * that is not submitted, and should be marked
+			 * as fully truncated.
+			 */
+			btrfs_mark_ordered_extent_truncated(dio_data->ordered, 0);
 			btrfs_finish_ordered_extent(dio_data->ordered,
-						    pos, length, false);
-		else
+						    pos, length, true);
+		} else {
 			btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
 						pos + length - 1, NULL);
+		}
 		ret = -ENOTBLK;
 	}
 	if (write) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 391fad41c3b6..a8c77f31ff78 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6613,12 +6613,16 @@ static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
 
 	*trimmed = 0;
 
-	/* Discard not supported = nothing to do. */
-	if (!bdev_max_discard_sectors(device->bdev))
+	/*
+	 * The caller only filters out MISSING devices, but a device that was
+	 * missing at mount and later rescanned has MISSING cleared while bdev
+	 * is still NULL and WRITEABLE is still unset. Skip those here.
+	 */
+	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) || !device->bdev)
 		return 0;
 
-	/* Not writable = nothing to do. */
-	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+	/* Discard not supported = nothing to do. */
+	if (!bdev_max_discard_sectors(device->bdev))
 		return 0;
 
 	/* No free space = nothing to do. */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8c171ed07008..8636ebe1fcab 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -93,16 +93,8 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
-	/*
-	 * The pages may have already been dirty, clear out old accounting so
-	 * we can set things up properly
-	 */
-	btrfs_clear_extent_bit(&inode->io_tree, start_pos, end_of_last_block,
-			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			       cached);
-
-	ret = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
-					extra_bits, cached);
+	ret = btrfs_reset_extent_delalloc(inode, start_pos, end_of_last_block,
+					  extra_bits, cached);
 	if (ret)
 		return ret;
 
@@ -1966,18 +1958,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 
-	/*
-	 * page_mkwrite gets called when the page is firstly dirtied after it's
-	 * faulted in, but write(2) could also dirty a page and set delalloc
-	 * bits, thus in this case for space account reason, we still need to
-	 * clear any delalloc bits within this page range since we have to
-	 * reserve data&meta space before lock_page() (see above comments).
-	 */
-	btrfs_clear_extent_bit(io_tree, page_start, end,
-			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
-			       EXTENT_DEFRAG, &cached_state);
-
-	ret = btrfs_set_extent_delalloc(inode, page_start, end, 0, &cached_state);
+	ret = btrfs_reset_extent_delalloc(inode, page_start, end, 0, &cached_state);
 	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ca1cbdf25bc..f1f7ac868473 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2810,7 +2810,13 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state)
 {
-	WARN_ON(PAGE_ALIGNED(end));
+	const u32 blocksize = inode->root->fs_info->sectorsize;
+
+	/* Basic alignment check. */
+	ASSERT(IS_ALIGNED(start, blocksize), "start=%llu blocksize=%u",
+	       start, blocksize);
+	ASSERT(IS_ALIGNED(end + 1, blocksize), "inclusive end=%llu blocksize=%u",
+	       end, blocksize);
 
 	if (start >= i_size_read(&inode->vfs_inode) &&
 	    !(inode->flags & BTRFS_INODE_PREALLOC)) {
@@ -3035,6 +3041,52 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	return -EAGAIN;
 }
 
+/*
+ * Clear the old accounting flags and set EXTENT_DELALLOC for the range.
+ *
+ * Return <0 for error, in that case no range has EXTENT_DELALLOC bit cleared or set.
+ */
+int btrfs_reset_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
+				unsigned int extra_bits, struct extent_state **cached_state)
+{
+	const u32 blocksize = inode->root->fs_info->sectorsize;
+
+	/* The @extra_bits can only be EXTENT_NORESERVE for now. */
+	ASSERT(!(extra_bits & ~EXTENT_NORESERVE), "extra_bits=0x%x", extra_bits);
+
+	/* Basic alignment check. */
+	ASSERT(IS_ALIGNED(start, blocksize), "start=%llu blocksize=%u",
+	       start, blocksize);
+	ASSERT(IS_ALIGNED(end + 1, blocksize), "inclusive end=%llu blocksize=%u",
+	       end, blocksize);
+
+	/*
+	 * Check and set DELALLOC_NEW flag, this needs to search tree thus can
+	 * fail early.  Thus we want to do this before clearing EXTENT_DELALLOC.
+	 */
+	if (start >= i_size_read(&inode->vfs_inode) &&
+	    !(inode->flags & BTRFS_INODE_PREALLOC)) {
+		/*
+		 * There can't be any extents following EOF in this case so just
+		 * set the delalloc new bit for the range directly.
+		 */
+		extra_bits |= EXTENT_DELALLOC_NEW;
+	} else {
+		int ret;
+
+		ret = btrfs_find_new_delalloc_bytes(inode, start, end + 1 - start,
+						    NULL);
+		if (unlikely(ret))
+			return ret;
+	}
+	/* Clear the old accounting as the range may already be dirty. */
+	btrfs_clear_extent_bit(&inode->io_tree, start, end,
+			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			       EXTENT_DEFRAG, cached_state);
+	return btrfs_set_extent_bit(&inode->io_tree, start, end,
+				    EXTENT_DELALLOC | extra_bits, cached_state);
+}
+
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *inode, u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
@@ -5181,12 +5233,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 		goto again;
 	}
 
-	btrfs_clear_extent_bit(&inode->io_tree, block_start, block_end,
-			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			       &cached_state);
-
-	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
-					&cached_state);
+	ret = btrfs_reset_extent_delalloc(inode, block_start, block_end, 0, &cached_state);
 	if (ret) {
 		btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 		goto out_unlock;
@@ -7776,11 +7823,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					       EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					       EXTENT_DEFRAG, &cached_state);
 
-		spin_lock(&inode->ordered_tree_lock);
-		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-		ordered->truncated_len = min(ordered->truncated_len,
-					     cur - ordered->file_offset);
-		spin_unlock(&inode->ordered_tree_lock);
+		btrfs_mark_ordered_extent_truncated(ordered, cur - ordered->file_offset);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e5a24b3ff95e..896de1c3c147 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -357,6 +357,18 @@ void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
 		mapping_set_error(ordered->inode->vfs_inode.i_mapping, -EIO);
 }
 
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len)
+{
+	struct btrfs_inode *inode = ordered->inode;
+
+	ASSERT(truncate_len <= ordered->num_bytes);
+	spin_lock(&inode->ordered_tree_lock);
+	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+	ordered->truncated_len = min(ordered->truncated_len, truncate_len);
+	spin_unlock(&inode->ordered_tree_lock);
+}
+
 static void finish_ordered_fn(struct btrfs_work *work)
 {
 	struct btrfs_ordered_extent *ordered_extent;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 03e12380a2fd..8d5d5ba1e02f 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -226,6 +226,8 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			struct btrfs_ordered_extent *ordered, u64 len);
 void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered);
+void btrfs_mark_ordered_extent_truncated(struct btrfs_ordered_extent *ordered,
+					 u64 truncate_len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 49865a463780..76a7b56f6cde 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -94,9 +94,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (ret < 0)
 		goto out_unlock;
 
-	btrfs_clear_extent_bit(&inode->io_tree, file_offset, range_end,
-			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, NULL);
-	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
+	ret = btrfs_reset_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
 
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 561fd2349218..500094c60c13 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -470,32 +470,70 @@ static void exfat_free_benign_secondary_clusters(struct inode *inode,
 	exfat_free_cluster(inode, &dir);
 }
 
+/*
+ * exfat_init_ext_entry - initialize extension entries in a directory entry set
+ * @es:          target entry set
+ * @num_entries: number of entries excluding benign secondary entries
+ * @p_uniname:   filename to store
+ * @old_es:      optional source entry set with benign secondary entries, or NULL
+ * @num_extra:   number of benign secondary entries to copy from @old_es
+ *
+ * Set up the file, stream extension, and filename entries in @es, optionally
+ * preserving @num_extra benign secondary entries from @old_es.  @es and @old_es
+ * may refer to the same entry set; excess entries are marked as deleted.
+ */
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname)
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra)
 {
-	int i;
+	int i, src_start = 0, old_num;
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
 
-	es->num_entries = num_entries;
+	if (WARN_ON(num_extra < 0 || (num_extra && (!old_es ||
+		    old_es->num_entries < ES_IDX_FIRST_FILENAME + num_extra))))
+		num_extra = 0;
+
+	/*
+	 * Save old entry count and source position before modifying
+	 * es->num_entries, since old_es and es may point to the same
+	 * entry set.
+	 */
+	old_num = es->num_entries;
+	if (old_es && num_extra > 0)
+		src_start = old_es->num_entries - num_extra;
+
+	es->num_entries = num_entries + num_extra;
 	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
-	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
+	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1 + num_extra);
 
 	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
 
+	if (old_es && num_extra > 0) {
+		for (i = 0; i < num_extra; i++)
+			*exfat_get_dentry_cached(es, num_entries + i) =
+				*exfat_get_dentry_cached(old_es, src_start + i);
+	}
+
 	for (i = ES_IDX_FIRST_FILENAME; i < num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 		exfat_init_name_entry(ep, uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
+	/* Mark excess old entries as deleted (in-place shrink) */
+	for (i = num_entries + num_extra; i < old_num; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		exfat_set_entry_type(ep, TYPE_DELETED);
+	}
+
 	exfat_update_dir_chksum(es);
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order)
+		int order, bool free_benign)
 {
 	int i;
 	struct exfat_dentry *ep;
@@ -503,7 +541,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 	for (i = order; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
+		if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
@@ -1029,6 +1067,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
+				unsigned int offset;
 
 				if (step != DIRENT_STEP_NAME ||
 				    name_len >= MAX_NAME_LENGTH) {
@@ -1037,13 +1076,15 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					continue;
 				}
 
-				if (++order == 2)
-					uniname = p_uniname->name;
-				else
-					uniname += EXFAT_FILE_NAME_LEN;
-
+				offset = (++order - 2) * EXFAT_FILE_NAME_LEN;
 				len = exfat_extract_uni_name(ep, entry_uniname);
 				brelse(bh);
+				if (offset > MAX_NAME_LENGTH ||
+				    len > MAX_NAME_LENGTH - offset) {
+					step = DIRENT_STEP_FILE;
+					continue;
+				}
+				uniname = p_uniname->name + offset;
 				name_len += len;
 
 				unichar = *(uniname+len);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 89ef5368277f..e22b4ca3ec7f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -524,9 +524,10 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 		unsigned int type, unsigned int start_clu,
 		unsigned long long size, struct timespec64 *ts);
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname);
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order);
+		int order, bool free_benign);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2c5636634b4a..76b2e2db80fb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -503,7 +503,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	 * the first cluster is not determined yet. (0)
 	 */
 	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
-	exfat_init_ext_entry(&es, num_entries, &uniname);
+	exfat_init_ext_entry(&es, num_entries, &uniname, NULL, 0);
 
 	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (ret)
@@ -814,7 +814,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_set_volume_dirty(sb);
 
 	/* update the directory entry */
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (err)
@@ -969,7 +969,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
 	if (err)
@@ -996,6 +996,23 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
+/*
+ * Count benign secondary entries beyond the filename entries.
+ * Returns the count, or -EIO if the entry set is inconsistent.
+ */
+static int exfat_count_extra_entries(struct exfat_entry_set_cache *es)
+{
+	struct exfat_dentry *stream;
+	unsigned int name_entries;
+	int extra;
+
+	stream = exfat_get_dentry_cached(es, ES_IDX_STREAM);
+	name_entries = EXFAT_FILENAME_ENTRY_NUM(stream->dentry.stream.name_len);
+	extra = es->num_entries - (ES_IDX_FIRST_FILENAME + name_entries);
+
+	return extra >= 0 ? extra : -EIO;
+}
+
 static int exfat_rename_file(struct inode *parent_inode,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
@@ -1004,6 +1021,7 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_extra_entries, num_total_entries;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1013,19 +1031,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		return num_new_entries;
 
 	ret = exfat_get_dentry_set_by_ei(&old_es, sb, ei);
-	if (ret) {
-		ret = -EIO;
-		return ret;
-	}
+	if (ret)
+		return -EIO;
 
 	epold = exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
 
-	if (old_es.num_entries < num_new_entries) {
+	ret = exfat_count_extra_entries(&old_es);
+	if (ret < 0)
+		goto put_old_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+
+	if (old_es.num_entries < num_total_entries) {
 		int newentry;
 		struct exfat_chain dir;
 
 		newentry = exfat_find_empty_entry(parent_inode, &dir,
-				num_new_entries, &new_es);
+				num_total_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1042,13 +1064,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 		*epnew = *epold;
 
-		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 
 		ret = exfat_put_dentry_set(&new_es, sync);
-		if (ret)
+		if (ret) {
+			/* Best-effort delete to avoid duplicate entries */
+			if (!exfat_get_dentry_set(&new_es, sb,
+						  &dir, newentry,
+						  ES_ALL_ENTRIES)) {
+				exfat_remove_entries(parent_inode, &new_es,
+						    ES_IDX_FILE, false);
+				exfat_put_dentry_set(&new_es, false);
+			}
 			goto put_old_es;
+		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
+		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE, false);
 		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
@@ -1057,8 +1089,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
-		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
@@ -1074,6 +1106,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1083,8 +1116,14 @@ static int exfat_move_file(struct inode *parent_inode,
 	if (ret)
 		return -EIO;
 
+	ret = exfat_count_extra_entries(&mov_es);
+	if (ret < 0)
+		goto put_mov_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+
 	newentry = exfat_find_empty_entry(parent_inode, &newdir,
-			num_new_entries, &new_es);
+			num_total_entries, &new_es);
 	if (newentry < 0) {
 		ret = newentry; /* -EIO or -ENOSPC */
 		goto put_mov_es;
@@ -1102,21 +1141,31 @@ static int exfat_move_file(struct inode *parent_inode,
 	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 	*epnew = *epmov;
 
-	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+			     &mov_es, num_extra_entries);
+
+	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE, false);
 
 	ei->dir = newdir;
 	ei->entry = newentry;
 
 	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(parent_inode));
-	if (ret)
+	if (ret) {
+		/* Best-effort delete to avoid duplicate entries */
+		if (!exfat_get_dentry_set(&new_es, parent_inode->i_sb,
+					  &newdir, newentry,
+					  ES_ALL_ENTRIES)) {
+			exfat_remove_entries(parent_inode, &new_es,
+					    ES_IDX_FILE, false);
+			exfat_put_dentry_set(&new_es, false);
+		}
 		goto put_mov_es;
+	}
 
 	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(parent_inode));
 
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-
 	return ret;
 }
 
@@ -1190,7 +1239,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 		}
 
-		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE, true);
 
 		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
 		if (ret)
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..6766de9f9d75 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -660,12 +660,19 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	atomic_inc(&isw_nr_in_flight);
 
-	/* find and pin the new wb */
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount():
+	 * holding rcu_read_lock across inode_prepare_wbs_switch()
+	 * (covering the SB_ACTIVE check and the inode grab) and
+	 * wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will
+	 * wait for the switch.
+	 */
 	rcu_read_lock();
+	/* find and pin the new wb */
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
 	if (memcg_css && !css_tryget(memcg_css))
 		memcg_css = NULL;
-	rcu_read_unlock();
 	if (!memcg_css)
 		goto out_free;
 
@@ -681,9 +688,11 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 	return;
 
 out_free:
+	rcu_read_unlock();
 	atomic_dec(&isw_nr_in_flight);
 	if (new_wb)
 		wb_put(new_wb);
@@ -741,6 +750,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
+	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
+	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will wait
+	 * for the switch.
+	 */
+	rcu_read_lock();
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -758,6 +775,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
+		rcu_read_unlock();
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);
 		kfree(isw);
@@ -766,6 +784,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	trace_inode_switch_wbs_queue(wb, new_wb, nr);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 
 	return restart;
 }
@@ -1221,6 +1240,14 @@ void cgroup_writeback_umount(struct super_block *sb)
 	smp_mb();
 
 	if (atomic_read(&isw_nr_in_flight)) {
+		/*
+		 * Paired with rcu_read_lock() in inode_switch_wbs() and
+		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
+		 * in-flight switcher that already passed the SB_ACTIVE check
+		 * to finish queueing its work, so flush_workqueue() below
+		 * will then drain it.
+		 */
+		synchronize_rcu();
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
 		 * ensure that all in-flight wb switches are in the workqueue.
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 174333633471..3d38828af41f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -391,7 +391,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	rc = -ENOMEM;
 	cdev = cdev_alloc();
 	if (!cdev)
-		goto err_unlock;
+		goto err_dev;
 
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &cuse_frontend_fops;
@@ -417,6 +417,8 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 
 err_cdev:
 	cdev_del(cdev);
+err_dev:
+	device_del(dev);
 err_unlock:
 	mutex_unlock(&cuse_lock);
 	put_device(dev);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 71f9fcefc0eb..5aea3f4d3030 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -148,6 +148,7 @@ static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
 
 static void fuse_request_free(struct fuse_req *req)
 {
+	WARN_ON(!list_empty(&req->intr_entry));
 	kmem_cache_free(fuse_req_cachep, req);
 }
 
@@ -447,6 +448,29 @@ static void flush_bg_queue(struct fuse_conn *fc)
 	}
 }
 
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req)
+{
+	lockdep_assert_held(&fc->bg_lock);
+
+	clear_bit(FR_BACKGROUND, &req->flags);
+	if (fc->num_background == fc->max_background) {
+		fc->blocked = 0;
+		wake_up(&fc->blocked_waitq);
+	} else if (!fc->blocked) {
+		/*
+		 * Wake up next waiter, if any.  It's okay to use
+		 * waitqueue_active(), as we've already synced up
+		 * fc->blocked with waiters with the wake_up() call
+		 * above.
+		 */
+		if (waitqueue_active(&fc->blocked_waitq))
+			wake_up(&fc->blocked_waitq);
+	}
+
+	fc->num_background--;
+	fc->active_background--;
+}
+
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was aborted (and not yet sent) or some error
@@ -479,23 +503,7 @@ void fuse_request_end(struct fuse_req *req)
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
-		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background) {
-			fc->blocked = 0;
-			wake_up(&fc->blocked_waitq);
-		} else if (!fc->blocked) {
-			/*
-			 * Wake up next waiter, if any.  It's okay to use
-			 * waitqueue_active(), as we've already synced up
-			 * fc->blocked with waiters with the wake_up() call
-			 * above.
-			 */
-			if (waitqueue_active(&fc->blocked_waitq))
-				wake_up(&fc->blocked_waitq);
-		}
-
-		fc->num_background--;
-		fc->active_background--;
+		fuse_request_bg_finish(fc, req);
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
 	} else {
@@ -1106,7 +1114,7 @@ static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
 	cs->nr_segs++;
 	cs->len = 0;
 
-	return 0;
+	return lock_request(cs->req);
 }
 
 /*
@@ -1553,9 +1561,15 @@ struct fuse_dev *fuse_get_dev(struct file *file)
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 	int err;
 
-	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud) != NULL);
-	if (err)
-		return ERR_PTR(err);
+	if (unlikely(!fuse_dev_fc_get(fud))) {
+		/* only block waiting for mount if sync init was requested */
+		if (!fud->sync_init)
+			return ERR_PTR(-EPERM);
+
+		err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud) != NULL);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	return fud;
 }
@@ -2028,6 +2042,14 @@ static void fuse_resend(struct fuse_conn *fc)
 		fuse_dev_end_requests(&to_queue);
 		return;
 	}
+	/*
+	 * Remove interrupt entries for resent requests to prevent stale
+	 * intr_entry on fiq->interrupts after the request is re-queued.
+	 */
+	list_for_each_entry(req, &to_queue, list) {
+		if (test_bit(FR_INTERRUPTED, &req->flags))
+			list_del_init(&req->intr_entry);
+	}
 	/* iq and pq requests are both oldest to newest */
 	list_splice(&to_queue, &fiq->pending);
 	fuse_dev_wake_and_unlock(fiq);
@@ -2072,7 +2094,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
 	if (err)
 		return err;
 
-	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
+	if (size - sizeof(outarg) != array_size(outarg.count, sizeof(u64)))
 		return -EINVAL;
 
 	for (; outarg.count; outarg.count -= num) {
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..4fde6336cf5c 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
+		fuse_request_bg_finish(fc, req);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
@@ -130,10 +131,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 		if (!queue)
 			continue;
 
-		queue->stopped = true;
-
 		WARN_ON_ONCE(ring->fc->max_background != UINT_MAX);
 		spin_lock(&queue->lock);
+		queue->stopped = true;
 		spin_lock(&fc->bg_lock);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
@@ -466,6 +466,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 				      FUSE_URING_TEARDOWN_INTERVAL);
 	} else {
 		wake_up_all(&ring->stop_waitq);
+		fuse_conn_put(ring->fc);
 	}
 }
 
@@ -477,6 +478,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 	fuse_uring_teardown_all_queues(ring);
 
 	if (atomic_read(&ring->queue_refs) > 0) {
+		fuse_conn_get(ring->fc);
 		ring->teardown_time = jiffies;
 		INIT_DELAYED_WORK(&ring->async_teardown_work,
 				  fuse_uring_async_stop_queues);
@@ -507,8 +509,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	queue = ent->queue;
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
-		ent->state = FRRS_USERSPACE;
-		list_move_tail(&ent->list, &queue->ent_in_userspace);
+		list_del_init(&ent->list);
 		need_cmd_done = true;
 		ent->cmd = NULL;
 	}
@@ -517,6 +518,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	if (need_cmd_done) {
 		/* no queue lock to avoid lock order issues */
 		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
+		kfree(ent);
+		if (atomic_dec_and_test(&queue->ring->queue_refs))
+			wake_up_all(&queue->ring->stop_waitq);
 	}
 }
 
@@ -702,14 +706,37 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	int err;
 
 	err = fuse_uring_copy_to_ring(ent, req);
-	if (!err)
+	if (!err) {
 		set_bit(FR_SENT, &req->flags);
-	else
+	} else {
+		/*
+		 * Copying the request failed. Remove the entry from the
+		 * ent_w_req_queue list and terminate the request
+		 */
+		spin_lock(&ent->queue->lock);
+		list_del_init(&ent->list);
+		ent->state = FRRS_INVALID;
+		spin_unlock(&ent->queue->lock);
+
 		fuse_uring_req_end(ent, req, err);
+	}
 
 	return err;
 }
 
+/* Used to find the request on SQE commit */
+static void fuse_uring_add_to_pq(struct fuse_ring_ent *ent)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_pqueue *fpq = &queue->fpq;
+	unsigned int hash;
+	struct fuse_req *req = ent->fuse_req;
+
+	req->ring_entry = ent;
+	hash = fuse_req_hash(req->in.h.unique);
+	list_move_tail(&req->list, &fpq->processing[hash]);
+}
+
 /*
  * Write data to the ring buffer and send the request to userspace,
  * userspace will read it
@@ -732,6 +759,7 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 	ent->cmd = NULL;
 	ent->state = FRRS_USERSPACE;
 	list_move_tail(&ent->list, &queue->ent_in_userspace);
+	fuse_uring_add_to_pq(ent);
 	spin_unlock(&queue->lock);
 
 	io_uring_cmd_done(cmd, 0, issue_flags);
@@ -749,19 +777,6 @@ static void fuse_uring_ent_avail(struct fuse_ring_ent *ent,
 	ent->state = FRRS_AVAILABLE;
 }
 
-/* Used to find the request on SQE commit */
-static void fuse_uring_add_to_pq(struct fuse_ring_ent *ent,
-				 struct fuse_req *req)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_pqueue *fpq = &queue->fpq;
-	unsigned int hash;
-
-	req->ring_entry = ent;
-	hash = fuse_req_hash(req->in.h.unique);
-	list_move_tail(&req->list, &fpq->processing[hash]);
-}
-
 /*
  * Assign a fuse queue entry to the given entry
  */
@@ -779,10 +794,13 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	}
 
 	clear_bit(FR_PENDING, &req->flags);
+
+	/* Until fuse_uring_add_to_pq() the req is not attached to any list */
+	list_del_init(&req->list);
+
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
 	list_move_tail(&ent->list, &queue->ent_w_req_queue);
-	fuse_uring_add_to_pq(ent, req);
 }
 
 /* Fetch the next fuse request if available */
@@ -813,14 +831,11 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 {
 	struct fuse_ring *ring = ent->queue->ring;
 	struct fuse_conn *fc = ring->fc;
-	ssize_t err = 0;
+	ssize_t err = -EFAULT;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
-	if (err) {
-		req->out.h.error = -EFAULT;
+	if (copy_from_user(&req->out.h, &ent->headers->in_out,
+			   sizeof(req->out.h)))
 		goto out;
-	}
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req, fc);
 	if (err) {
@@ -898,10 +913,15 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 		return err;
 	fpq = &queue->fpq;
 
-	if (!READ_ONCE(fc->connected) || READ_ONCE(queue->stopped))
+	if (!READ_ONCE(fc->connected))
 		return err;
 
 	spin_lock(&queue->lock);
+	if (unlikely(queue->stopped)) {
+		spin_unlock(&queue->lock);
+		return err;
+	}
+
 	/* Find a request based on the unique ID of the fuse request
 	 * This should get revised, as it needs a hash calculation and list
 	 * search. And full struct fuse_pqueue is needed (memory overhead).
@@ -991,12 +1011,12 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	fuse_uring_ent_avail(ent, queue);
 	spin_unlock(&queue->lock);
 
-	if (!ring->ready) {
+	if (!READ_ONCE(ring->ready)) {
 		bool ready = is_ring_ready(ring, queue->qid);
 
 		if (ready) {
 			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
-			WRITE_ONCE(ring->ready, true);
+			smp_store_release(&ring->ready, true);
 			wake_up_all(&fc->blocked_waitq);
 		}
 	}
@@ -1201,6 +1221,7 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 	ent->state = FRRS_USERSPACE;
 	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	ent->cmd = NULL;
+	fuse_uring_add_to_pq(ent);
 	spin_unlock(&queue->lock);
 
 	io_uring_cmd_done(cmd, ret, issue_flags);
@@ -1225,11 +1246,21 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
+		fuse_uring_send(ent, cmd, err, issue_flags);
 	} else {
 		err = -ECANCELED;
-	}
 
-	fuse_uring_send(ent, cmd, err, issue_flags);
+		spin_lock(&queue->lock);
+		list_del_init(&ent->list);
+		spin_unlock(&queue->lock);
+
+		io_uring_cmd_done(cmd, err, issue_flags);
+
+		fuse_uring_req_end(ent, ent->fuse_req, err);
+		kfree(ent);
+		if (atomic_dec_and_test(&queue->ring->queue_refs))
+			wake_up_all(&queue->ring->stop_waitq);
+	}
 }
 
 static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..054ad4fdd749 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -152,10 +152,10 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
 	if (ring == NULL)
 		return;
 
-	if (atomic_read(&ring->queue_refs) > 0) {
-		fuse_uring_abort_end_requests(ring);
+	fuse_uring_abort_end_requests(ring);
+
+	if (atomic_read(&ring->queue_refs) > 0)
 		fuse_uring_stop_queues(ring);
-	}
 }
 
 static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
@@ -169,7 +169,9 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 
 static inline bool fuse_uring_ready(struct fuse_conn *fc)
 {
-	return fc->ring && fc->ring->ready;
+	struct fuse_ring *ring = READ_ONCE(fc->ring);
+
+	return ring && smp_load_acquire(&ring->ready);
 }
 
 #else /* CONFIG_FUSE_IO_URING */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72f..97751bacb79c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1587,40 +1587,34 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 {
 	int err = -ENOTDIR;
 	struct inode *parent;
-	struct dentry *dir = NULL;
-	struct dentry *entry = NULL;
+	struct dentry *dir;
+	struct dentry *entry;
 
 	parent = fuse_ilookup(fc, parent_nodeid, NULL);
 	if (!parent)
 		return -ENOENT;
 
+	inode_lock_nested(parent, I_MUTEX_PARENT);
 	if (!S_ISDIR(parent->i_mode))
-		goto put_parent;
+		goto unlock;
 
 	err = -ENOENT;
 	dir = d_find_alias(parent);
 	if (!dir)
-		goto put_parent;
-	while (!entry) {
-		struct dentry *child = try_lookup_noperm(name, dir);
-		if (!child || IS_ERR(child))
-			goto put_parent;
-		entry = start_removing_dentry(dir, child);
-		dput(child);
-		if (IS_ERR(entry))
-			goto put_parent;
-		if (!d_same_name(entry, dir, name)) {
-			end_removing(entry);
-			entry = NULL;
-		}
-	}
+		goto unlock;
+
+	name->hash = full_name_hash(dir, name->name, name->len);
+	entry = d_lookup(dir, name);
+	dput(dir);
+	if (!entry)
+		goto unlock;
 
 	fuse_dir_changed(parent);
 	if (!(flags & FUSE_EXPIRE_ONLY))
 		d_invalidate(entry);
 	fuse_invalidate_entry_cache(entry);
 
-	if (child_nodeid != 0) {
+	if (child_nodeid != 0 && d_really_is_positive(entry)) {
 		inode_lock(d_inode(entry));
 		if (get_node_id(d_inode(entry)) != child_nodeid) {
 			err = -ENOENT;
@@ -1648,10 +1642,10 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 	} else {
 		err = 0;
 	}
+	dput(entry);
 
-	end_removing(entry);
- put_parent:
-	dput(dir);
+ unlock:
+	inode_unlock(parent);
 	iput(parent);
 	return err;
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 910f883cd090..1853940fe80a 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -77,6 +77,7 @@ unsigned int fuse_req_hash(u64 unique);
 struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
 void fuse_dev_end_requests(struct list_head *head);
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req);
 
 void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
new file mode 100644
index 000000000000..7cd63502e124
--- /dev/null
+++ b/fs/fuse/notify.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "dev.h"
+#include "fuse_i.h"
+#include <linux/pagemap.h>
+
+static int fuse_notify_poll(struct fuse_conn *fc, unsigned int size,
+			    struct fuse_copy_state *cs)
+{
+	struct fuse_notify_poll_wakeup_out outarg;
+	int err;
+
+	if (size != sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	fuse_copy_finish(cs);
+	return fuse_notify_poll_wakeup(fc, &outarg);
+}
+
+static int fuse_notify_inval_inode(struct fuse_conn *fc, unsigned int size,
+				   struct fuse_copy_state *cs)
+{
+	struct fuse_notify_inval_inode_out outarg;
+	int err;
+
+	if (size != sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+	fuse_copy_finish(cs);
+
+	down_read(&fc->killsb);
+	err = fuse_reverse_inval_inode(fc, outarg.ino,
+				       outarg.off, outarg.len);
+	up_read(&fc->killsb);
+	return err;
+}
+
+static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
+				   struct fuse_copy_state *cs)
+{
+	struct fuse_notify_inval_entry_out outarg;
+	int err;
+	char *buf;
+	struct qstr name;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (outarg.namelen > fc->name_max)
+		return -ENAMETOOLONG;
+
+	err = -EINVAL;
+	if (size != sizeof(outarg) + outarg.namelen + 1)
+		return -EINVAL;
+
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	name.name = buf;
+	name.len = outarg.namelen;
+	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
+	if (err)
+		goto err;
+	fuse_copy_finish(cs);
+	buf[outarg.namelen] = 0;
+
+	down_read(&fc->killsb);
+	err = fuse_reverse_inval_entry(fc, outarg.parent, 0, &name, outarg.flags);
+	up_read(&fc->killsb);
+err:
+	kfree(buf);
+	return err;
+}
+
+static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
+			      struct fuse_copy_state *cs)
+{
+	struct fuse_notify_delete_out outarg;
+	int err;
+	char *buf;
+	struct qstr name;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (outarg.namelen > fc->name_max)
+		return -ENAMETOOLONG;
+
+	if (size != sizeof(outarg) + outarg.namelen + 1)
+		return -EINVAL;
+
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	name.name = buf;
+	name.len = outarg.namelen;
+	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
+	if (err)
+		goto err;
+	fuse_copy_finish(cs);
+	buf[outarg.namelen] = 0;
+
+	down_read(&fc->killsb);
+	err = fuse_reverse_inval_entry(fc, outarg.parent, outarg.child, &name, 0);
+	up_read(&fc->killsb);
+err:
+	kfree(buf);
+	return err;
+}
+
+static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
+			     struct fuse_copy_state *cs)
+{
+	struct fuse_notify_store_out outarg;
+	struct inode *inode;
+	struct address_space *mapping;
+	u64 nodeid;
+	int err;
+	unsigned int num;
+	loff_t file_size;
+	loff_t pos;
+	loff_t end;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (size - sizeof(outarg) != outarg.size)
+		return -EINVAL;
+
+	if (outarg.offset >= MAX_LFS_FILESIZE)
+		return -EINVAL;
+
+	nodeid = outarg.nodeid;
+	pos = outarg.offset;
+	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
+
+	down_read(&fc->killsb);
+
+	err = -ENOENT;
+	inode = fuse_ilookup(fc, nodeid,  NULL);
+	if (!inode)
+		goto out_up_killsb;
+
+	mapping = inode->i_mapping;
+	file_size = i_size_read(inode);
+	end = pos + num;
+	if (end > file_size) {
+		file_size = end;
+		fuse_write_update_attr(inode, file_size, num);
+	}
+
+	while (num) {
+		struct folio *folio;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		pgoff_t index = pos >> PAGE_SHIFT;
+
+		folio = filemap_grab_folio(mapping, index);
+		err = PTR_ERR(folio);
+		if (IS_ERR(folio))
+			goto out_iput;
+
+		folio_offset = offset_in_folio(folio, pos);
+		nr_bytes = min(num, folio_size(folio) - folio_offset);
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
+		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
+			folio_mark_uptodate(folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
+
+		if (err)
+			goto out_iput;
+
+		pos += nr_bytes;
+		num -= nr_bytes;
+	}
+
+	err = 0;
+
+out_iput:
+	iput(inode);
+out_up_killsb:
+	up_read(&fc->killsb);
+	return err;
+}
+
+struct fuse_retrieve_args {
+	struct fuse_args_pages ap;
+	struct fuse_notify_retrieve_in inarg;
+};
+
+static void fuse_retrieve_end(struct fuse_args *args, int error)
+{
+	struct fuse_retrieve_args *ra =
+		container_of(args, typeof(*ra), ap.args);
+
+	release_pages(ra->ap.folios, ra->ap.num_folios);
+	kfree(ra);
+}
+
+static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
+			 struct fuse_notify_retrieve_out *outarg)
+{
+	int err;
+	struct address_space *mapping = inode->i_mapping;
+	loff_t file_size;
+	unsigned int num;
+	unsigned int offset;
+	size_t total_len = 0;
+	unsigned int num_pages;
+	struct fuse_conn *fc = fm->fc;
+	struct fuse_retrieve_args *ra;
+	size_t args_size = sizeof(*ra);
+	struct fuse_args_pages *ap;
+	struct fuse_args *args;
+	loff_t pos = outarg->offset;
+
+	offset = offset_in_page(pos);
+	file_size = i_size_read(inode);
+
+	num = min(outarg->size, fc->max_write);
+	if (pos > file_size)
+		num = 0;
+	else if (num > file_size - pos)
+		num = file_size - pos;
+
+	num_pages = DIV_ROUND_UP(num + offset, PAGE_SIZE);
+	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
+
+	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
+
+	ra = kzalloc(args_size, GFP_KERNEL);
+	if (!ra)
+		return -ENOMEM;
+
+	ap = &ra->ap;
+	ap->folios = (void *) (ra + 1);
+	ap->descs = (void *) (ap->folios + num_pages);
+
+	args = &ap->args;
+	args->nodeid = outarg->nodeid;
+	args->opcode = FUSE_NOTIFY_REPLY;
+	args->in_numargs = 3;
+	args->in_pages = true;
+	args->end = fuse_retrieve_end;
+
+	while (num && ap->num_folios < num_pages) {
+		struct folio *folio;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		pgoff_t index = pos >> PAGE_SHIFT;
+
+		folio = filemap_get_folio(mapping, index);
+		if (IS_ERR(folio))
+			break;
+
+		folio_offset = offset_in_folio(folio, pos);
+		nr_bytes = min(folio_size(folio) - folio_offset, num);
+
+		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
+		ap->descs[ap->num_folios].length = nr_bytes;
+		ap->num_folios++;
+
+		pos += nr_bytes;
+		num -= nr_bytes;
+		total_len += nr_bytes;
+	}
+	ra->inarg.offset = outarg->offset;
+	ra->inarg.size = total_len;
+	fuse_set_zero_arg0(args);
+	args->in_args[1].size = sizeof(ra->inarg);
+	args->in_args[1].value = &ra->inarg;
+	args->in_args[2].size = total_len;
+
+	err = fuse_simple_notify_reply(fm, args, outarg->notify_unique);
+	if (err)
+		fuse_retrieve_end(args, err);
+
+	return err;
+}
+
+static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
+				struct fuse_copy_state *cs)
+{
+	struct fuse_notify_retrieve_out outarg;
+	struct fuse_mount *fm;
+	struct inode *inode;
+	u64 nodeid;
+	int err;
+
+	if (size != sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	fuse_copy_finish(cs);
+
+	if (outarg.offset >= MAX_LFS_FILESIZE)
+		return -EINVAL;
+
+	down_read(&fc->killsb);
+	err = -ENOENT;
+	nodeid = outarg.nodeid;
+
+	inode = fuse_ilookup(fc, nodeid, &fm);
+	if (inode) {
+		err = fuse_retrieve(fm, inode, &outarg);
+		iput(inode);
+	}
+	up_read(&fc->killsb);
+
+	return err;
+}
+
+static int fuse_notify_resend(struct fuse_conn *fc)
+{
+	fuse_chan_resend(fc->chan);
+	return 0;
+}
+
+/*
+ * Increments the fuse connection epoch.  This will result of dentries from
+ * previous epochs to be invalidated.  Additionally, if inval_wq is set, a work
+ * queue is scheduled to trigger the invalidation.
+ */
+static int fuse_notify_inc_epoch(struct fuse_conn *fc)
+{
+	atomic_inc(&fc->epoch);
+	if (inval_wq)
+		schedule_work(&fc->epoch_work);
+
+	return 0;
+}
+
+static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
+			     struct fuse_copy_state *cs)
+{
+	struct fuse_notify_prune_out outarg;
+	const unsigned int batch = 512;
+	u64 *nodeids __free(kfree) = kmalloc(sizeof(u64) * batch, GFP_KERNEL);
+	unsigned int num, i;
+	int err;
+
+	if (!nodeids)
+		return -ENOMEM;
+
+	if (size < sizeof(outarg))
+		return -EINVAL;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		return err;
+
+	if (size - sizeof(outarg) != array_size(outarg.count, sizeof(u64)))
+		return -EINVAL;
+
+	for (; outarg.count; outarg.count -= num) {
+		num = min(batch, outarg.count);
+		err = fuse_copy_one(cs, nodeids, num * sizeof(u64));
+		if (err)
+			return err;
+
+		scoped_guard(rwsem_read, &fc->killsb) {
+			for (i = 0; i < num; i++)
+				fuse_try_prune_one_inode(fc, nodeids[i]);
+		}
+	}
+	return 0;
+}
+
+int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
+		unsigned int size, struct fuse_copy_state *cs)
+{
+	switch (code) {
+	case FUSE_NOTIFY_POLL:
+		return fuse_notify_poll(fc, size, cs);
+
+	case FUSE_NOTIFY_INVAL_INODE:
+		return fuse_notify_inval_inode(fc, size, cs);
+
+	case FUSE_NOTIFY_INVAL_ENTRY:
+		return fuse_notify_inval_entry(fc, size, cs);
+
+	case FUSE_NOTIFY_STORE:
+		return fuse_notify_store(fc, size, cs);
+
+	case FUSE_NOTIFY_RETRIEVE:
+		return fuse_notify_retrieve(fc, size, cs);
+
+	case FUSE_NOTIFY_DELETE:
+		return fuse_notify_delete(fc, size, cs);
+
+	case FUSE_NOTIFY_RESEND:
+		return fuse_notify_resend(fc);
+
+	case FUSE_NOTIFY_INC_EPOCH:
+		return fuse_notify_inc_epoch(fc);
+
+	case FUSE_NOTIFY_PRUNE:
+		return fuse_notify_prune(fc, size, cs);
+
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..c38139225a2e 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/vmalloc.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -335,6 +336,43 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 	return 0;
 }
 
+static struct page **fuse_readdir_alloc_buf(struct fuse_args_pages *ap, size_t *bufsize)
+{
+	unsigned int i, nr_alloc, nr_pages = DIV_ROUND_UP(*bufsize, PAGE_SIZE);
+	struct page **pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+
+	if (!pages)
+		return NULL;
+
+	nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+	if (!nr_alloc)
+		goto free_array;
+
+	if (nr_alloc < nr_pages) {
+		nr_pages = nr_alloc;
+		*bufsize = (size_t) nr_pages << PAGE_SHIFT;
+	}
+
+	ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
+	if (!ap->folios)
+		goto release_pages;
+
+	for (i = 0; i < nr_pages; i++) {
+		ap->folios[i] = page_folio(pages[i]);
+		ap->descs[i].length = min_t(size_t, *bufsize - (size_t)i * PAGE_SIZE, PAGE_SIZE);
+	}
+	ap->num_folios = nr_pages;
+	ap->args.out_pages = true;
+
+	return pages;
+
+release_pages:
+	release_pages(pages, nr_pages);
+free_array:
+	kfree(pages);
+	return NULL;
+}
+
 static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 {
 	int plus;
@@ -343,18 +381,16 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_io_args ia = {};
-	struct fuse_args *args = &ia.ap.args;
+	struct fuse_args_pages *ap = &ia.ap;
 	void *buf;
 	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	struct page **pages = fuse_readdir_alloc_buf(ap, &bufsize);
 
-	buf = kvmalloc(bufsize, GFP_KERNEL);
-	if (!buf)
+	if (!pages)
 		return -ENOMEM;
 
-	args->out_args[0].value = buf;
-
 	plus = fuse_use_readdirplus(inode, ctx);
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
@@ -364,24 +400,37 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 		fuse_read_args_fill(&ia, file, ctx->pos, bufsize, FUSE_READDIR);
 	}
 	locked = fuse_lock_inode(inode);
-	res = fuse_simple_request(fm, args);
+	res = fuse_simple_request(fm, &ap->args);
 	fuse_unlock_inode(inode, locked);
-	if (res >= 0) {
-		if (!res) {
-			struct fuse_file *ff = file->private_data;
-
-			if (ff->open_flags & FOPEN_CACHE_DIR)
-				fuse_readdir_cache_end(file, ctx->pos);
-		} else if (plus) {
-			res = parse_dirplusfile(buf, res, file, ctx, attr_version,
-						evict_ctr);
-		} else {
+	if (res < 0)
+		goto out;
+
+	if (!res) {
+		struct fuse_file *ff = file->private_data;
+
+		if (ff->open_flags & FOPEN_CACHE_DIR)
+			fuse_readdir_cache_end(file, ctx->pos);
+		goto out;
+	}
+
+	buf = vm_map_ram(pages, ap->num_folios, -1);
+	if (!buf) {
+		res = -ENOMEM;
+	} else {
+		if (plus)
+			res = parse_dirplusfile(buf, res, file, ctx, attr_version, evict_ctr);
+		else
 			res = parse_dirfile(buf, res, file, ctx);
-		}
+
+		vm_unmap_ram(buf, ap->num_folios);
 	}
+out:
+	kfree(ap->folios);
+	release_pages(pages, ap->num_folios);
+	kfree(pages);
 
-	kvfree(buf);
 	fuse_invalidate_atime(inode);
+
 	return res;
 }
 
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46..25cef62fbba6 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
@@ -64,6 +64,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	u32 bytes_read;
 	u32 bytes_to_read;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff..14d1af2c7ba9 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 	struct page **pagep;
 	u32 l;
 
+	memset(buf, 0, len);
+
 	if (!is_bnode_offset_valid(node, off))
 		return;
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c..0e4268de9e60 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 1232fab59a4e..2628f31bd3a5 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -466,6 +466,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				inode->i_size = symlink_len;
 				while (slen > 1) {
 					rootflag = 0;
+					/* keep the component within the SL record */
+					if (slp->len + 2 > slen)
+						goto eio;
 					switch (slp->flags & ~1) {
 					case 0:
 						inode->i_size +=
@@ -621,6 +624,14 @@ static char *get_symlink_chunk(char *rpnt, struct rock_ridge *rr, char *plimit)
 	slp = &rr->u.SL.link;
 	while (slen > 1) {
 		rootflag = 0;
+		/*
+		 * A component is slp->len + 2 bytes (a two-byte header plus
+		 * len bytes of text).  If it does not fit in the bytes left in
+		 * the SL record the record is malformed: fail like the plimit
+		 * checks below so readlink() returns -EIO, not a truncated path.
+		 */
+		if (slp->len + 2 > slen)
+			return NULL;
 		switch (slp->flags & ~1) {
 		case 0:
 			if (slp->len > plimit - rpnt)
diff --git a/fs/libfs.c b/fs/libfs.c
index 1bbea5e7bae3..e8226b9e1bc8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -736,6 +736,7 @@ struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
 		fc->fs_private = ctx;
 		fc->ops = &pseudo_fs_context_ops;
 		fc->sb_flags |= SB_NOUSER;
+		fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
 		fc->global = true;
 	}
 	return ctx;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..cb7ddaefdfb2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3344,6 +3344,8 @@ static int nfs_open_permission_mask(int openflags)
 			mask |= MAY_READ;
 		if ((openflags & O_ACCMODE) != O_RDONLY)
 			mask |= MAY_WRITE;
+		if (openflags & O_TRUNC)
+			mask |= MAY_WRITE;
 	}
 
 	return mask;
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 1491a4d4b1e1..9332f5ac6083 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2512,12 +2512,33 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 	struct nilfs_transaction_info ti;
 	int err;
+	size_t i, nfreesegs = argv[4].v_nmembs;
+	__u64 *segnumv = kbufs[4];
 
 	if (unlikely(!sci))
 		return -EROFS;
 
 	nilfs_transaction_lock(sb, &ti, 1);
 
+	/*
+	 * Validate segment numbers under ns_segctor_sem (held for write
+	 * by nilfs_transaction_lock above) so the check is serialized
+	 * against nilfs_ioctl_resize(), which can modify ns_nsegments.
+	 * Rejecting bad input here, before any segment-cleaning work
+	 * begins, avoids the per-element diagnostic path inside
+	 * nilfs_sufile_updatev() that would otherwise run under this
+	 * same lock and stall concurrent readers.
+	 */
+	for (i = 0; i < nfreesegs; i++) {
+		if (segnumv[i] >= nilfs->ns_nsegments) {
+			nilfs_err(sb,
+				 "Segment number %llu to be freed is out of range",
+				 (unsigned long long)segnumv[i]);
+			err = -EINVAL;
+			goto bail_unlock;
+		}
+	}
+
 	err = nilfs_mdt_save_to_shadow_map(nilfs->ns_dat);
 	if (unlikely(err))
 		goto out_unlock;
@@ -2558,6 +2579,7 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 	sci->sc_freesegs = NULL;
 	sci->sc_nfreesegs = 0;
 	nilfs_mdt_clear_shadow_map(nilfs->ns_dat);
+ bail_unlock:
 	nilfs_transaction_unlock(sb);
 	return err;
 }
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 146e011c1a41..4200a8138efa 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -141,6 +141,10 @@ static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 	ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
 			ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
 			(u8 *)ib, icx->sync_write);
+
+	/* Perform data restoration before returning */
+	post_write_mst_fixup((struct ntfs_record *)ib);
+
 	if (ret != icx->block_size) {
 		ntfs_debug("Failed to write index block %lld, inode %llu",
 				vcn, (unsigned long long)icx->idx_ni->mft_no);
@@ -178,7 +182,6 @@ int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx)
 		icx->ib = NULL;
 		icx->ib_dirty = false;
 	} else {
-		post_write_mst_fixup((struct ntfs_record *)icx->ib);
 		icx->sync_write = false;
 	}
 
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401..ca78cfe2b37f 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4547,11 +4547,21 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
-		for (i = 0; i < t16; i++) {
-			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
-					    le64_to_cpu(dp->vcn));
-			dp->page_lcns[j + i] = lrh->page_lcns[i];
-		}
+                t32 = le32_to_cpu(dp->lcns_follow);
+                if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
+                        err = -EINVAL;
+                        goto out;
+                }
+
+                for (i = 0; i < t16; i++) {
+                        size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
+                                            le64_to_cpu(dp->vcn));
+                        if (j >= t32 || i >= t32 - j) {
+                                err = -EINVAL;
+                                goto out;
+                        }
+                        dp->page_lcns[j + i] = lrh->page_lcns[i];
+                }
 
 		goto next_log_record_analyze;
 
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 90fb0c6b5f99..479ea8cb4ef4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -482,6 +482,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
+	int ret;
+
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		return ret;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -657,6 +662,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
+	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..5042f14d24f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -218,33 +218,24 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	return result;
 }
 
-static int proc_cwd_link(struct dentry *dentry, struct path *path)
+static int proc_cwd_link(struct dentry *dentry, struct path *path,
+			 struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
 	int result = -ENOENT;
 
-	if (task) {
-		task_lock(task);
-		if (task->fs) {
-			get_fs_pwd(task->fs, path);
-			result = 0;
-		}
-		task_unlock(task);
-		put_task_struct(task);
+	task_lock(task);
+	if (task->fs) {
+		get_fs_pwd(task->fs, path);
+		result = 0;
 	}
+	task_unlock(task);
 	return result;
 }
 
-static int proc_root_link(struct dentry *dentry, struct path *path)
+static int proc_root_link(struct dentry *dentry, struct path *path,
+			  struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
-	int result = -ENOENT;
-
-	if (task) {
-		result = get_task_root(task, path);
-		put_task_struct(task);
-	}
-	return result;
+	return get_task_root(task, path);
 }
 
 /*
@@ -423,18 +414,24 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 {
 	unsigned long wchan;
 	char symname[KSYM_NAME_LEN];
+	int err;
 
+	err = down_read_killable(&task->signal->exec_update_lock);
+	if (err)
+		return err;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto print0;
 
 	wchan = get_wchan(task);
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
+		up_read(&task->signal->exec_update_lock);
 		return 0;
 	}
 
 print0:
 	seq_putc(m, '0');
+	up_read(&task->signal->exec_update_lock);
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
@@ -704,23 +701,6 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 /*                       Here the fs part begins                        */
 /************************************************************************/
 
-/* permission checks */
-static bool proc_fd_access_allowed(struct inode *inode)
-{
-	struct task_struct *task;
-	bool allowed = false;
-	/* Allow access to a task's file descriptors if it is us or we
-	 * may use ptrace attach to the process and find out that
-	 * information.
-	 */
-	task = get_proc_task(inode);
-	if (task) {
-		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
-		put_task_struct(task);
-	}
-	return allowed;
-}
-
 int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
@@ -1777,16 +1757,12 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
+			 struct task_struct *task)
 {
-	struct task_struct *task;
 	struct file *exe_file;
 
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		return -ENOENT;
 	exe_file = get_task_exe_file(task);
-	put_task_struct(task);
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
@@ -1796,26 +1772,42 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 		return -ENOENT;
 }
 
+static int call_proc_get_link(struct dentry *dentry, struct inode *inode, struct path *path_out)
+{
+	struct task_struct *task;
+	int ret;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return -ENOENT;
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		goto out_put_task;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		ret = -EACCES;
+		goto out;
+	}
+	ret = PROC_I(inode)->op.proc_get_link(dentry, path_out, task);
+
+out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
+	put_task_struct(task);
+	return ret;
+}
+
 static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct inode *inode,
 				     struct delayed_call *done)
 {
 	struct path path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
-
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = nd_jump_link(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error)
+		error = nd_jump_link(&path);
 	return ERR_PTR(error);
 }
 
@@ -1849,17 +1841,11 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 	struct inode *inode = d_inode(dentry);
 	struct path path;
 
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = do_proc_readlink(&path, buffer, buflen);
-	path_put(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error) {
+		error = do_proc_readlink(&path, buffer, buflen);
+		path_put(&path);
+	}
 	return error;
 }
 
@@ -2250,21 +2236,16 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path)
+static int map_files_get_link(struct dentry *dentry, struct path *path,
+			      struct task_struct *task)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
-	struct task_struct *task;
 	struct mm_struct *mm;
 	int rc;
 
 	rc = -ENOENT;
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		goto out;
-
 	mm = get_task_mm(task);
-	put_task_struct(task);
 	if (!mm)
 		goto out;
 
@@ -2360,17 +2341,15 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!task)
 		goto out;
 
-	result = ERR_PTR(-EACCES);
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out_put_task;
-
 	result = ERR_PTR(-ENOENT);
 	if (dname_to_vma_addr(dentry, &vm_start, &vm_end))
 		goto out_put_task;
 
-	mm = get_task_mm(task);
-	if (!mm)
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		result = ERR_CAST(mm);
 		goto out_put_task;
+	}
 
 	result = ERR_PTR(-EINTR);
 	if (mmap_read_lock_killable(mm))
@@ -2420,23 +2399,22 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!task)
 		goto out;
 
-	ret = -EACCES;
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out_put_task;
-
 	ret = 0;
 	if (!dir_emit_dots(file, ctx))
 		goto out_put_task;
 
-	mm = get_task_mm(task);
-	if (!mm)
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
+		/* if the task has no mm, the directory should just be empty */
+		if (ret == -ESRCH)
+			ret = 0;
 		goto out_put_task;
+	}
 
 	ret = mmap_read_lock_killable(mm);
-	if (ret) {
-		mmput(mm);
-		goto out_put_task;
-	}
+	if (ret)
+		goto out_put_mm;
 
 	nr_files = 0;
 
@@ -2462,8 +2440,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		if (!p) {
 			ret = -ENOMEM;
 			mmap_read_unlock(mm);
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
 		}
 
 		p->start = vma->vm_start;
@@ -2471,7 +2448,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->mode = vma->vm_file->f_mode;
 	}
 	mmap_read_unlock(mm);
-	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2488,6 +2464,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(task);
 out:
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 05c7513e77c7..0f9a1556f2a3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -171,24 +171,19 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+			struct task_struct *task)
 {
-	struct task_struct *task;
 	int ret = -ENOENT;
-
-	task = get_proc_task(d_inode(dentry));
-	if (task) {
-		unsigned int fd = proc_fd(d_inode(dentry));
-		struct file *fd_file;
-
-		fd_file = fget_task(task, fd);
-		if (fd_file) {
-			*path = fd_file->f_path;
-			path_get(&fd_file->f_path);
-			ret = 0;
-			fput(fd_file);
-		}
-		put_task_struct(task);
+	unsigned int fd = proc_fd(d_inode(dentry));
+	struct file *fd_file;
+
+	fd_file = fget_task(task, fd);
+	if (fd_file) {
+		*path = fd_file->f_path;
+		path_get(&fd_file->f_path);
+		ret = 0;
+		fput(fd_file);
 	}
 
 	return ret;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 64dc44832808..d31984c3c797 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -107,7 +107,7 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
 union proc_op {
-	int (*proc_get_link)(struct dentry *, struct path *);
+	int (*proc_get_link)(struct dentry *, struct path *, struct task_struct *);
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 39f4169f669f..2f46f1396744 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -55,6 +55,10 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (!task)
 		return ERR_PTR(-EACCES);
 
+	error = down_read_killable(&task->signal->exec_update_lock);
+	if (error)
+		goto out_put_task;
+
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -64,6 +68,8 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 
 	error = nd_jump_link(&ns_path);
 out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return ERR_PTR(error);
 }
@@ -80,11 +86,17 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (!task)
 		return res;
 
+	res = down_read_killable(&task->signal->exec_update_lock);
+	if (res)
+		goto out_put_task;
+
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
 			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return res;
 }
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9fd901c78dc6..3d869fc35e83 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -135,10 +135,10 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
+	bool rmid_dirty = true;
 	u32 idx, cur_idx = 1;
 	void *arch_mon_ctx;
 	void *arch_priv;
-	bool rmid_dirty;
 	u64 val = 0;
 
 	arch_priv = mon_event_all[QOS_L3_OCCUP_EVENT_ID].arch_priv;
@@ -161,22 +161,27 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, arch_priv, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty = true;
-		} else {
-			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
-
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
+		if (!force_free) {
+			if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid,
+						   entry->rmid, QOS_L3_OCCUP_EVENT_ID,
+						   arch_priv, &val, arch_mon_ctx)) {
+				rmid_dirty = true;
+			} else {
+				rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+
+				/*
+				 * x86's CLOSID and RMID are independent numbers,
+				 * so the entry's CLOSID is an empty CLOSID
+				 * (X86_RESCTRL_EMPTY_CLOSID). On Arm the RMID
+				 * (PMG) extends the CLOSID (PARTID) space with
+				 * bits that aren't used to select the configuration.
+				 * It is thus necessary to track both CLOSID and
+				 * RMID because there may be dependencies between
+				 * them on some architectures.
+				 */
+				trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid,
+							      d->hdr.id, val);
+			}
 		}
 
 		if (force_free || !rmid_dirty) {
diff --git a/fs/smb/client/cifs_swn.c b/fs/smb/client/cifs_swn.c
index 9753a432d099..9951817d0d7f 100644
--- a/fs/smb/client/cifs_swn.c
+++ b/fs/smb/client/cifs_swn.c
@@ -28,10 +28,54 @@ struct cifs_swn_reg {
 	bool net_name_notify;
 	bool share_name_notify;
 	bool ip_notify;
+};
 
-	struct cifs_tcon *tcon;
+struct cifs_swn_reg_info {
+	int id;
+	unsigned int ref_count;
+	const char *net_name;
+	const char *share_name;
+	bool net_name_notify;
+	bool share_name_notify;
+	bool ip_notify;
 };
 
+static void cifs_swn_snapshot_reg(struct cifs_swn_reg *swnreg,
+				  struct cifs_swn_reg_info *info)
+{
+	info->id = swnreg->id;
+	info->ref_count = kref_read(&swnreg->ref_count);
+	info->net_name = swnreg->net_name;
+	info->share_name = swnreg->share_name;
+	info->net_name_notify = swnreg->net_name_notify;
+	info->share_name_notify = swnreg->share_name_notify;
+	info->ip_notify = swnreg->ip_notify;
+}
+
+static int cifs_swn_dup_reg(struct cifs_swn_reg *swnreg,
+			    struct cifs_swn_reg_info *info)
+{
+	cifs_swn_snapshot_reg(swnreg, info);
+
+	info->net_name = kstrdup(swnreg->net_name, GFP_KERNEL);
+	if (!info->net_name)
+		return -ENOMEM;
+
+	info->share_name = kstrdup(swnreg->share_name, GFP_KERNEL);
+	if (!info->share_name) {
+		kfree(info->net_name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void cifs_swn_free_reg_info(struct cifs_swn_reg_info *info)
+{
+	kfree(info->net_name);
+	kfree(info->share_name);
+}
+
 static int cifs_swn_auth_info_krb(struct cifs_tcon *tcon, struct sk_buff *skb)
 {
 	int ret;
@@ -73,7 +117,8 @@ static int cifs_swn_auth_info_ntlm(struct cifs_tcon *tcon, struct sk_buff *skb)
  * The authentication information to connect to the witness service is bundled
  * into the message.
  */
-static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
+static int cifs_swn_send_register_message(struct cifs_swn_reg_info *swnreg,
+					  struct cifs_tcon *tcon)
 {
 	struct sk_buff *skb;
 	struct genlmsghdr *hdr;
@@ -109,10 +154,10 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 	 * told to switch to it (client move message). In these cases we unregister from the
 	 * server address and register to the new address when we receive the notification.
 	 */
-	if (swnreg->tcon->ses->server->use_swn_dstaddr)
-		addr = &swnreg->tcon->ses->server->swn_dstaddr;
+	if (tcon->ses->server->use_swn_dstaddr)
+		addr = &tcon->ses->server->swn_dstaddr;
 	else
-		addr = &swnreg->tcon->ses->server->dstaddr;
+		addr = &tcon->ses->server->dstaddr;
 
 	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage), addr);
 	if (ret < 0)
@@ -136,10 +181,10 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 			goto nlmsg_fail;
 	}
 
-	authtype = cifs_select_sectype(swnreg->tcon->ses->server, swnreg->tcon->ses->sectype);
+	authtype = cifs_select_sectype(tcon->ses->server, tcon->ses->sectype);
 	switch (authtype) {
 	case Kerberos:
-		ret = cifs_swn_auth_info_krb(swnreg->tcon, skb);
+		ret = cifs_swn_auth_info_krb(tcon, skb);
 		if (ret < 0) {
 			cifs_dbg(VFS, "%s: Failed to get kerberos auth info: %d\n", __func__, ret);
 			goto nlmsg_fail;
@@ -147,7 +192,7 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 		break;
 	case NTLMv2:
 	case RawNTLMSSP:
-		ret = cifs_swn_auth_info_ntlm(swnreg->tcon, skb);
+		ret = cifs_swn_auth_info_ntlm(tcon, skb);
 		if (ret < 0) {
 			cifs_dbg(VFS, "%s: Failed to get NTLM auth info: %d\n", __func__, ret);
 			goto nlmsg_fail;
@@ -176,7 +221,8 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 /*
  * Sends an uregister message to the userspace daemon based on the registration
  */
-static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
+static int cifs_swn_send_unregister_message(struct cifs_swn_reg_info *swnreg,
+					    struct cifs_tcon *tcon)
 {
 	struct sk_buff *skb;
 	struct genlmsghdr *hdr;
@@ -205,7 +251,7 @@ static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
 		goto nlmsg_fail;
 
 	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage),
-			&swnreg->tcon->ses->server->dstaddr);
+			&tcon->ses->server->dstaddr);
 	if (ret < 0)
 		goto nlmsg_fail;
 
@@ -241,6 +287,88 @@ static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
 	return ret;
 }
 
+/*
+ * Allocation-free mirror of extract_hostname() + extract_sharename() from
+ * fs/smb/client/unc.c.  Those helpers kmalloc(GFP_KERNEL); this runs under
+ * cifs_tcp_ses_lock and tcon->tc_lock, both spinlocks, so we mirror their
+ * parsing in place against the caller's stable net_name/share_name strings.
+ * Keep in sync with unc.c.
+ */
+static bool cifs_swn_tcon_matches(struct cifs_tcon *tcon,
+				  const char *net_name,
+				  const char *share_name)
+{
+	const char *unc = tcon->tree_name;
+	const char *host, *share, *delim;
+	size_t host_len, share_len;
+
+	if (!tcon->use_witness)
+		return false;
+
+	/* extract_hostname: require strlen(unc) >= 3 */
+	if (strnlen(unc, 3) < 3)
+		return false;
+	/* extract_hostname: skip all leading '\' characters */
+	for (host = unc; *host == '\\'; host++)
+		;
+	if (!*host)
+		return false;
+	delim = strchr(host, '\\');
+	if (!delim)
+		return false;
+	host_len = delim - host;
+	if (strlen(net_name) != host_len ||
+	    strncasecmp(host, net_name, host_len))
+		return false;
+
+	/* extract_sharename: start at unc + 2, then first '\' onward */
+	share = unc + 2;
+	delim = strchr(share, '\\');
+	if (!delim)
+		return false;
+	share = delim + 1;
+	share_len = strlen(share);
+
+	return strlen(share_name) == share_len &&
+	       !strncasecmp(share, share_name, share_len);
+}
+
+/*
+ * One SWN registration id represents one net/share name pair.  Multiple
+ * mounted tcons can therefore share the id.  Pick a live representative at
+ * use time instead of caching the first tcon pointer in the registration.
+ */
+static struct cifs_tcon *cifs_swn_get_tcon(struct cifs_swn_reg_info *swnreg)
+{
+	struct TCP_Server_Info *server;
+	struct cifs_ses *ses;
+	struct cifs_tcon *tcon;
+
+	spin_lock(&cifs_tcp_ses_lock);
+	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
+		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
+				spin_lock(&tcon->tc_lock);
+				if (tcon->status == TID_EXITING ||
+				    !cifs_swn_tcon_matches(tcon, swnreg->net_name,
+							   swnreg->share_name)) {
+					spin_unlock(&tcon->tc_lock);
+					continue;
+				}
+				++tcon->tc_count;
+				trace_smb3_tcon_ref(tcon->debug_id,
+						    tcon->tc_count,
+						    netfs_trace_tcon_ref_get_swn_notify);
+				spin_unlock(&tcon->tc_lock);
+				spin_unlock(&cifs_tcp_ses_lock);
+				return tcon;
+			}
+		}
+	}
+	spin_unlock(&cifs_tcp_ses_lock);
+	return NULL;
+}
+
 /*
  * Try to find a matching registration for the tcon's server name and share name.
  * Calls to this function must be protected by cifs_swnreg_idr_mutex.
@@ -347,8 +475,6 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 	reg->net_name_notify = true;
 	reg->share_name_notify = true;
 	reg->ip_notify = (tcon->capabilities & SMB2_SHARE_CAP_SCALEOUT);
-
-	reg->tcon = tcon;
 unlock:
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 
@@ -368,11 +494,6 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 static void cifs_swn_reg_release(struct kref *ref)
 {
 	struct cifs_swn_reg *swnreg = container_of(ref, struct cifs_swn_reg, ref_count);
-	int ret;
-
-	ret = cifs_swn_send_unregister_message(swnreg);
-	if (ret < 0)
-		cifs_dbg(VFS, "%s: Failed to send unregister message: %d\n", __func__, ret);
 
 	idr_remove(&cifs_swnreg_idr, swnreg->id);
 	kfree(swnreg->net_name);
@@ -380,23 +501,33 @@ static void cifs_swn_reg_release(struct kref *ref)
 	kfree(swnreg);
 }
 
-static void cifs_put_swn_reg(struct cifs_swn_reg *swnreg)
+static void cifs_put_swn_reg_locked(struct cifs_swn_reg *swnreg,
+				    struct cifs_tcon *tcon)
 {
-	mutex_lock(&cifs_swnreg_idr_mutex);
+	if (kref_read(&swnreg->ref_count) == 1) {
+		struct cifs_swn_reg_info swnreg_info;
+		int ret;
+
+		cifs_swn_snapshot_reg(swnreg, &swnreg_info);
+		ret = cifs_swn_send_unregister_message(&swnreg_info, tcon);
+		if (ret < 0)
+			cifs_dbg(VFS, "%s: Failed to send unregister message: %d\n",
+				 __func__, ret);
+	}
+
 	kref_put(&swnreg->ref_count, cifs_swn_reg_release);
-	mutex_unlock(&cifs_swnreg_idr_mutex);
 }
 
-static int cifs_swn_resource_state_changed(struct cifs_swn_reg *swnreg, const char *name, int state)
+static int cifs_swn_resource_state_changed(struct cifs_tcon *tcon, const char *name, int state)
 {
 	switch (state) {
 	case CIFS_SWN_RESOURCE_STATE_UNAVAILABLE:
 		cifs_dbg(FYI, "%s: resource name '%s' become unavailable\n", __func__, name);
-		cifs_signal_cifsd_for_reconnect(swnreg->tcon->ses->server, true);
+		cifs_signal_cifsd_for_reconnect(tcon->ses->server, true);
 		break;
 	case CIFS_SWN_RESOURCE_STATE_AVAILABLE:
 		cifs_dbg(FYI, "%s: resource name '%s' become available\n", __func__, name);
-		cifs_signal_cifsd_for_reconnect(swnreg->tcon->ses->server, true);
+		cifs_signal_cifsd_for_reconnect(tcon->ses->server, true);
 		break;
 	case CIFS_SWN_RESOURCE_STATE_UNKNOWN:
 		cifs_dbg(FYI, "%s: resource name '%s' changed to unknown state\n", __func__, name);
@@ -502,7 +633,7 @@ static int cifs_swn_reconnect(struct cifs_tcon *tcon, struct sockaddr_storage *a
 	return ret;
 }
 
-static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_storage *addr)
+static int cifs_swn_client_move(struct cifs_tcon *tcon, struct sockaddr_storage *addr)
 {
 	struct sockaddr_in *ipv4 = (struct sockaddr_in *)addr;
 	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)addr;
@@ -512,14 +643,17 @@ static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_sto
 	else if (addr->ss_family == AF_INET6)
 		cifs_dbg(FYI, "%s: move to %pI6\n", __func__, &ipv6->sin6_addr);
 
-	return cifs_swn_reconnect(swnreg->tcon, addr);
+	return cifs_swn_reconnect(tcon, addr);
 }
 
 int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cifs_swn_reg *swnreg;
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
 	char name[256];
 	int type;
+	int ret = 0;
 
 	if (info->attrs[CIFS_GENL_ATTR_SWN_REGISTRATION_ID]) {
 		int swnreg_id;
@@ -527,21 +661,34 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 		swnreg_id = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_REGISTRATION_ID]);
 		mutex_lock(&cifs_swnreg_idr_mutex);
 		swnreg = idr_find(&cifs_swnreg_idr, swnreg_id);
-		mutex_unlock(&cifs_swnreg_idr_mutex);
 		if (swnreg == NULL) {
+			mutex_unlock(&cifs_swnreg_idr_mutex);
 			cifs_dbg(FYI, "%s: registration id %d not found\n", __func__, swnreg_id);
 			return -EINVAL;
 		}
+		ret = cifs_swn_dup_reg(swnreg, &swnreg_info);
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+		if (ret)
+			return ret;
 	} else {
 		cifs_dbg(FYI, "%s: missing registration id attribute\n", __func__);
 		return -EINVAL;
 	}
 
+	tcon = cifs_swn_get_tcon(&swnreg_info);
+	if (!tcon) {
+		cifs_dbg(FYI, "%s: registration id %d has no live tcon\n",
+			 __func__, swnreg_info.id);
+		ret = -ENODEV;
+		goto free_info;
+	}
+
 	if (info->attrs[CIFS_GENL_ATTR_SWN_NOTIFICATION_TYPE]) {
 		type = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_NOTIFICATION_TYPE]);
 	} else {
 		cifs_dbg(FYI, "%s: missing notification type attribute\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	switch (type) {
@@ -553,15 +700,18 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 					sizeof(name));
 		} else {
 			cifs_dbg(FYI, "%s: missing resource name attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (info->attrs[CIFS_GENL_ATTR_SWN_RESOURCE_STATE]) {
 			state = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_RESOURCE_STATE]);
 		} else {
 			cifs_dbg(FYI, "%s: missing resource state attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
-		return cifs_swn_resource_state_changed(swnreg, name, state);
+		ret = cifs_swn_resource_state_changed(tcon, name, state);
+		break;
 	}
 	case CIFS_SWN_NOTIFICATION_CLIENT_MOVE: {
 		struct sockaddr_storage addr;
@@ -570,28 +720,36 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 			nla_memcpy(&addr, info->attrs[CIFS_GENL_ATTR_SWN_IP], sizeof(addr));
 		} else {
 			cifs_dbg(FYI, "%s: missing IP address attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
-		return cifs_swn_client_move(swnreg, &addr);
+		ret = cifs_swn_client_move(tcon, &addr);
+		break;
 	}
 	default:
 		cifs_dbg(FYI, "%s: unknown notification type %d\n", __func__, type);
 		break;
 	}
 
-	return 0;
+out:
+	cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+free_info:
+	cifs_swn_free_reg_info(&swnreg_info);
+	return ret;
 }
 
 int cifs_swn_register(struct cifs_tcon *tcon)
 {
 	struct cifs_swn_reg *swnreg;
+	struct cifs_swn_reg_info swnreg_info;
 	int ret;
 
 	swnreg = cifs_get_swn_reg(tcon);
 	if (IS_ERR(swnreg))
 		return PTR_ERR(swnreg);
 
-	ret = cifs_swn_send_register_message(swnreg);
+	cifs_swn_snapshot_reg(swnreg, &swnreg_info);
+	ret = cifs_swn_send_register_message(&swnreg_info, tcon);
 	if (ret < 0) {
 		cifs_dbg(VFS, "%s: Failed to send swn register message: %d\n", __func__, ret);
 		/* Do not put the swnreg or return error, the echo task will retry */
@@ -612,35 +770,68 @@ int cifs_swn_unregister(struct cifs_tcon *tcon)
 		return PTR_ERR(swnreg);
 	}
 
+	cifs_put_swn_reg_locked(swnreg, tcon);
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 
-	cifs_put_swn_reg(swnreg);
-
 	return 0;
 }
 
-void cifs_swn_dump(struct seq_file *m)
+/*
+ * Snapshot one registration under cifs_swnreg_idr_mutex and return.  Callers
+ * intentionally do the per-registration network/genlmsg work without the
+ * mutex held, both to keep the critical section short and to avoid nesting
+ * cifs_swnreg_idr_mutex inside the higher tc_lock when a live tcon is then
+ * pinned for the send.
+ */
+static int cifs_swn_get_next_reg_info(int *id, struct cifs_swn_reg_info *info)
 {
 	struct cifs_swn_reg *swnreg;
+	int ret = 0;
+
+	mutex_lock(&cifs_swnreg_idr_mutex);
+	swnreg = idr_get_next(&cifs_swnreg_idr, id);
+	if (swnreg) {
+		ret = cifs_swn_dup_reg(swnreg, info);
+		if (!ret) {
+			*id = swnreg->id + 1;
+			ret = 1;
+		}
+	}
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+
+	return ret;
+}
+
+void cifs_swn_dump(struct seq_file *m)
+{
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
 	struct sockaddr_in *sa;
 	struct sockaddr_in6 *sa6;
-	int id;
+	int id = 0;
+	int ret;
 
 	seq_puts(m, "Witness registrations:");
 
-	mutex_lock(&cifs_swnreg_idr_mutex);
-	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
+	while ((ret = cifs_swn_get_next_reg_info(&id, &swnreg_info)) > 0) {
 		seq_printf(m, "\nId: %u Refs: %u Network name: '%s'%s Share name: '%s'%s Ip address: ",
-				id, kref_read(&swnreg->ref_count),
-				swnreg->net_name, swnreg->net_name_notify ? "(y)" : "(n)",
-				swnreg->share_name, swnreg->share_name_notify ? "(y)" : "(n)");
-		switch (swnreg->tcon->ses->server->dstaddr.ss_family) {
+			   swnreg_info.id, swnreg_info.ref_count,
+			   swnreg_info.net_name, swnreg_info.net_name_notify ? "(y)" : "(n)",
+			   swnreg_info.share_name, swnreg_info.share_name_notify ? "(y)" : "(n)");
+
+		tcon = cifs_swn_get_tcon(&swnreg_info);
+		if (!tcon) {
+			seq_puts(m, "(no live tcon)");
+			goto next;
+		}
+
+		switch (tcon->ses->server->dstaddr.ss_family) {
 		case AF_INET:
-			sa = (struct sockaddr_in *) &swnreg->tcon->ses->server->dstaddr;
+			sa = (struct sockaddr_in *)&tcon->ses->server->dstaddr;
 			seq_printf(m, "%pI4", &sa->sin_addr.s_addr);
 			break;
 		case AF_INET6:
-			sa6 = (struct sockaddr_in6 *) &swnreg->tcon->ses->server->dstaddr;
+			sa6 = (struct sockaddr_in6 *)&tcon->ses->server->dstaddr;
 			seq_printf(m, "%pI6", &sa6->sin6_addr.s6_addr);
 			if (sa6->sin6_scope_id)
 				seq_printf(m, "%%%u", sa6->sin6_scope_id);
@@ -648,23 +839,38 @@ void cifs_swn_dump(struct seq_file *m)
 		default:
 			seq_puts(m, "(unknown)");
 		}
-		seq_printf(m, "%s", swnreg->ip_notify ? "(y)" : "(n)");
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+next:
+		seq_printf(m, "%s", swnreg_info.ip_notify ? "(y)" : "(n)");
+		cifs_swn_free_reg_info(&swnreg_info);
 	}
-	mutex_unlock(&cifs_swnreg_idr_mutex);
+	if (ret < 0)
+		seq_printf(m, "\nFailed to snapshot witness registration: %d", ret);
 	seq_puts(m, "\n");
 }
 
 void cifs_swn_check(void)
 {
-	struct cifs_swn_reg *swnreg;
-	int id;
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
+	int id = 0;
 	int ret;
 
-	mutex_lock(&cifs_swnreg_idr_mutex);
-	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
-		ret = cifs_swn_send_register_message(swnreg);
+	while ((ret = cifs_swn_get_next_reg_info(&id, &swnreg_info)) > 0) {
+		tcon = cifs_swn_get_tcon(&swnreg_info);
+		if (!tcon) {
+			cifs_dbg(FYI, "%s: registration id %d has no live tcon\n",
+				 __func__, swnreg_info.id);
+			goto free_info;
+		}
+
+		ret = cifs_swn_send_register_message(&swnreg_info, tcon);
 		if (ret < 0)
 			cifs_dbg(FYI, "%s: Failed to send register message: %d\n", __func__, ret);
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+free_info:
+		cifs_swn_free_reg_info(&swnreg_info);
 	}
-	mutex_unlock(&cifs_swnreg_idr_mutex);
+	if (ret < 0)
+		cifs_dbg(FYI, "%s: Failed to snapshot registration: %d\n", __func__, ret);
 }
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 786dbbc43c5b..59a2d702fce1 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -889,7 +889,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else {
 				if (compare_sids(&(ppace[i]->sid), pownersid) == 0) {
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b60344125f27..e536e424b9b7 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -301,7 +301,7 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
 	/* we do not want atime to be less than mtime, it broke some apps */
 	atime = inode_set_atime_to_ts(inode, current_time(inode));
 	mtime = inode_get_mtime(inode);
-	if (timespec64_compare(&atime, &mtime))
+	if (timespec64_compare(&atime, &mtime) < 0)
 		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 }
 
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 9472c0a6c187..3b5bac93812d 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3348,7 +3348,8 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (attrs->ia_valid & ATTR_GID)
 		gid = attrs->ia_gid;
 
-	if (sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) {
+	if ((sbflags & (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
+	    cifs_sb_master_tcon(cifs_sb)->posix_extensions) {
 		if (uid_valid(uid) || gid_valid(gid)) {
 			mode = NO_CHANGE_64;
 			rc = id_mode_to_cifs_acl(inode, full_path, &mode,
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 2a7355ce1a07..9068175e57cd 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -19,6 +19,9 @@
 #include "nterr.h"
 #include "cached_dir.h"
 
+static unsigned int __smb2_calc_size(void *buf, bool *have_data,
+				     bool *data_area_overlap);
+
 static int
 check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 {
@@ -145,6 +148,8 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 	int command;
 	__u32 calc_len; /* calculated length */
 	__u64 mid;
+	bool have_data;
+	bool data_area_overlap;
 
 	/* If server is a channel, select the primary channel */
 	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
@@ -228,7 +233,13 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		}
 	}
 
-	calc_len = smb2_calc_size(buf);
+	have_data = false;
+	data_area_overlap = false;
+	calc_len = __smb2_calc_size(buf, &have_data, &data_area_overlap);
+
+	/* Reject responses whose data area overlaps the fixed area. */
+	if (data_area_overlap)
+		return 1;
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -247,8 +258,13 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		/* Windows 7 server returns 24 bytes more */
 		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
 			return 0;
-		/* server can return one byte more due to implied bcc[0] */
-		if (calc_len == len + 1)
+		/*
+		 * Server can return one byte more due to implied bcc[0].
+		 * Allow it only when there is no data area; if data_length > 0
+		 * the +1 gap indicates an overreported data length rather than
+		 * the bcc[0] omission.
+		 */
+		if (calc_len == len + 1 && !have_data)
 			return 0;
 
 		/*
@@ -407,19 +423,28 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 }
 
 /*
- * Calculate the size of the SMB message based on the fixed header
- * portion, the number of word parameters and the data portion of the message.
+ * Calculate the size of the SMB message based on the fixed header, fixed
+ * parameter area, and variable data area.
+ *
+ * If have_data is not NULL, it is set when a non-empty data area is found.
+ * If data_area_overlap is not NULL, it is set when the data area overlaps
+ * the fixed area.
  */
-unsigned int
-smb2_calc_size(void *buf)
+static unsigned int
+__smb2_calc_size(void *buf, bool *have_data, bool *data_area_overlap)
 {
 	struct smb2_pdu *pdu = buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
 	int offset; /* the offset from the beginning of SMB to data area */
-	int data_length; /* the length of the variable length data area */
+	int data_length = 0; /* the length of the variable length data area */
 	/* Structure Size has already been checked to make sure it is 64 */
 	int len = le16_to_cpu(shdr->StructureSize);
 
+	if (have_data)
+		*have_data = false;
+	if (data_area_overlap)
+		*data_area_overlap = false;
+
 	/*
 	 * StructureSize2, ie length of fixed parameter area has already
 	 * been checked to make sure it is the correct length.
@@ -442,16 +467,27 @@ smb2_calc_size(void *buf)
 		if (offset + 1 < len) {
 			cifs_dbg(VFS, "data area offset %d overlaps SMB2 header %d\n",
 				 offset + 1, len);
+			if (data_area_overlap)
+				*data_area_overlap = true;
 			data_length = 0;
+			goto calc_size_exit;
 		} else {
 			len = offset + data_length;
 		}
 	}
 calc_size_exit:
 	cifs_dbg(FYI, "SMB2 len %d\n", len);
+	if (have_data)
+		*have_data = (data_length > 0);
 	return len;
 }
 
+unsigned int
+smb2_calc_size(void *buf)
+{
+	return __smb2_calc_size(buf, NULL, NULL);
+}
+
 /* Note: caller must free return buffer */
 __le16 *
 cifs_convert_path_to_utf16(const char *from, struct cifs_sb_info *cifs_sb)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index d4875f9532b4..ce34b3fbfca3 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4359,11 +4359,13 @@ static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst
 	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
 	unsigned int iv_size = crypto_aead_ivsize(tfm);
 	unsigned int len;
+	int ret;
 	u8 *p;
 
-	*num_sgs = cifs_get_num_sgs(rqst, num_rqst, sig);
-	if (IS_ERR_VALUE((long)(int)*num_sgs))
-		return ERR_PTR(*num_sgs);
+	ret = cifs_get_num_sgs(rqst, num_rqst, sig);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	*num_sgs = ret;
 
 	len = iv_size;
 	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
@@ -5109,6 +5111,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+
+	if (*num_mids >= MAX_COMPOUND) {
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
+		return -1;
+	}
+
 	if (next_cmd) {
 		if (WARN_ON_ONCE(next_cmd > pdu_length))
 			return -1;
@@ -5132,10 +5140,6 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
 
-	if (*num_mids >= MAX_COMPOUND) {
-		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-		return -1;
-	}
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index fbeb2156ddb6..69b618e2f67a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2371,9 +2371,9 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 
 	memset(posix, 0, sizeof(*posix));
 
-	posix->nlink = le32_to_cpu(*(__le32 *)(beg + 0));
-	posix->reparse_tag = le32_to_cpu(*(__le32 *)(beg + 4));
-	posix->mode = le32_to_cpu(*(__le32 *)(beg + 8));
+	posix->nlink = get_unaligned_le32(beg);
+	posix->reparse_tag = get_unaligned_le32(beg + 4);
+	posix->mode = get_unaligned_le32(beg + 8);
 
 	sid = beg + 12;
 	sid_len = posix_info_sid_size(sid, end);
@@ -3280,6 +3280,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 	oparms->replay = !!(retries);
@@ -3505,6 +3507,8 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
@@ -3699,6 +3703,8 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	query_attrs = false;
 	server = cifs_pick_channel(ses);
@@ -3911,6 +3917,8 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	allocated = false;
 	server = cifs_pick_channel(ses);
@@ -4083,6 +4091,8 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
@@ -4425,6 +4435,8 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
@@ -5368,7 +5380,7 @@ int posix_info_sid_size(const void *beg, const void *end)
 	size_t subauth;
 	int total;
 
-	if (beg + 1 > end)
+	if (beg + 2 > end)
 		return -1;
 
 	subauth = *(u8 *)(beg+1);
@@ -5683,6 +5695,8 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	server = cifs_pick_channel(ses);
 
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index b99ec5a417fa..5b21ad3c15fb 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -181,6 +181,7 @@
 	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
 	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
 	EM(netfs_trace_tcon_ref_get_reconnect_server,	"GET Reconn") \
+	EM(netfs_trace_tcon_ref_get_swn_notify,		"GET SwnNot") \
 	EM(netfs_trace_tcon_ref_new,			"NEW       ") \
 	EM(netfs_trace_tcon_ref_new_ipc,		"NEW Ipc   ") \
 	EM(netfs_trace_tcon_ref_new_reconnect_server,	"NEW Reconn") \
@@ -192,6 +193,7 @@
 	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
 	EM(netfs_trace_tcon_ref_put_dfs_refer,		"PUT DfsRfr") \
 	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \
+	EM(netfs_trace_tcon_ref_put_swn_notify,		"PUT SwnNot") \
 	EM(netfs_trace_tcon_ref_put_tlink,		"PUT Tlink ") \
 	EM(netfs_trace_tcon_ref_see_cancelled_close,	"SEE Cn-Cls") \
 	EM(netfs_trace_tcon_ref_see_fscache_collision,	"SEE FV-CO!") \
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index e99409fa721c..86f521e849d5 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -142,6 +142,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
+	char sess_key[SMB2_NTLMV2_SESSKEY_SIZE];
 	struct hmac_md5_ctx ctx;
 	int rc;
 
@@ -164,12 +165,21 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	/* Generate the session key */
 	hmac_md5_usingrawkey(ntlmv2_hash, CIFS_HMAC_MD5_HASH_SIZE,
 			     ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE,
-			     sess->sess_key);
+			     sess_key);
 
 	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
-			  CIFS_HMAC_MD5_HASH_SIZE))
-		return -EINVAL;
-	return 0;
+			  CIFS_HMAC_MD5_HASH_SIZE)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	memcpy(sess->sess_key, sess_key, sizeof(sess_key));
+	rc = 0;
+out:
+	memzero_explicit(ntlmv2_hash, sizeof(ntlmv2_hash));
+	memzero_explicit(ntlmv2_rsp, sizeof(ntlmv2_rsp));
+	memzero_explicit(sess_key, sizeof(sess_key));
+	return rc;
 }
 
 /**
@@ -226,6 +236,8 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
+	if (ret)
+		return ret;
 
 	/* The recovered secondary session key */
 	if (conn->ntlmssp.client_flags & NTLMSSP_NEGOTIATE_KEY_XCH) {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 95d0ea045cfb..a1b163763dad 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4470,6 +4470,8 @@ int smb2_query_dir(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
 	}
 
+	mutex_lock(&dir_fp->readdir_lock);
+
 	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
 		ksmbd_debug(SMB, "Restart directory scan\n");
 		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
@@ -4574,6 +4576,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 			goto err_out;
 	}
 
+	mutex_unlock(&dir_fp->readdir_lock);
 	kfree(srch_ptr);
 	ksmbd_fd_put(work, dir_fp);
 	ksmbd_revert_fsids(work);
@@ -4581,6 +4584,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 
 err_out:
 	pr_err("error while processing smb2 query dir rc = %d\n", rc);
+	mutex_unlock(&dir_fp->readdir_lock);
 	kfree(srch_ptr);
 
 err_out2:
@@ -5333,6 +5337,12 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
 	int ret;
 
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		pr_err("no right to read the attributes : 0x%x\n",
+		       fp->daccess);
+		return -EACCES;
+	}
+
 	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
 			  AT_STATX_SYNC_AS_STAT);
 	if (ret)
@@ -6554,11 +6564,18 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 	case FILE_LINK_INFORMATION:
 	{
+		struct smb2_file_link_info *file_info;
+
 		if (buf_len < sizeof(struct smb2_file_link_info))
 			return -EMSGSIZE;
 
-		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)buffer,
+		file_info = (struct smb2_file_link_info *)buffer;
+		if (file_info->ReplaceIfExists && !(fp->daccess & FILE_DELETE_LE)) {
+			pr_err("no right to delete : 0x%x\n", fp->daccess);
+			return -EACCES;
+		}
+
+		return smb2_create_link(work, work->tcon->share_conf, file_info,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6611,6 +6628,9 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 
 	fp->saccess |= FILE_SHARE_DELETE_LE;
 
+	if (!(fp->daccess & (FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE)))
+		return -EACCES;
+
 	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
 			buf_len, false, true);
 }
@@ -6623,6 +6643,7 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
  */
 int smb2_set_info(struct ksmbd_work *work)
 {
+	const struct cred *saved_cred;
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
@@ -6664,6 +6685,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		goto err_out;
 	}
 
+	saved_cred = override_creds(fp->filp->f_cred);
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
@@ -6671,19 +6693,15 @@ int smb2_set_info(struct ksmbd_work *work)
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
-		if (ksmbd_override_fsids(work)) {
-			rc = -ENOMEM;
-			goto err_out;
-		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
 				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
-		ksmbd_revert_fsids(work);
 		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
+	revert_creds(saved_cred);
 
 	if (rc < 0)
 		goto err_out;
@@ -7328,14 +7346,14 @@ int smb2_cancel(struct ksmbd_work *work)
 				continue;
 
 			/*
-			 * A cancelled deferred byte-range lock frees its
-			 * file_lock and takes the smb2_lock() early-exit that
-			 * skips release_async_work(), so the work stays on
-			 * conn->async_requests with a live cancel_fn pointing
-			 * at the freed file_lock.  Re-firing it on a second
-			 * SMB2_CANCEL is a use-after-free.
+			 * Only an ACTIVE deferred work may have its cancel_fn
+			 * fired.  A CANCELLED or CLOSED work already took the
+			 * smb2_lock() non-ACTIVE early-exit that frees the
+			 * file_lock and skips release_async_work(), so it is
+			 * still on conn->async_requests with a live cancel_fn
+			 * pointing at the freed file_lock.
 			 */
-			if (iter->state == KSMBD_WORK_CANCELLED)
+			if (iter->state != KSMBD_WORK_ACTIVE)
 				break;
 
 			ksmbd_debug(SMB,
@@ -7628,9 +7646,11 @@ int smb2_lock(struct ksmbd_work *work)
 						nolock = 0;
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
+						cmp_lock->conn = NULL;
 						spin_unlock(&conn->llist_lock);
 						up_read(&conn_list_lock);
 
+						ksmbd_conn_put(conn);
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
 						goto out_check_cl;
@@ -7742,31 +7762,30 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
 
-				if (work->state != KSMBD_WORK_ACTIVE) {
-					list_del(&smb_lock->llist);
-					locks_free_lock(flock);
+				list_del(&smb_lock->llist);
+				release_async_work(work);
 
-					if (work->state == KSMBD_WORK_CANCELLED) {
-						rsp->hdr.Status =
-							STATUS_CANCELLED;
-						kfree(smb_lock);
-						smb2_send_interim_resp(work,
-								       STATUS_CANCELLED);
-						work->send_no_response = 1;
-						goto out;
-					}
+				if (work->state == KSMBD_WORK_ACTIVE)
+					goto retry;
 
-					rsp->hdr.Status =
-						STATUS_RANGE_NOT_LOCKED;
+				locks_free_lock(flock);
+
+				if (work->state == KSMBD_WORK_CANCELLED) {
+					rsp->hdr.Status = STATUS_CANCELLED;
 					kfree(smb_lock);
-					goto out2;
+					smb2_send_interim_resp(work,
+							STATUS_CANCELLED);
+					work->send_no_response = 1;
+					goto out;
 				}
 
-				list_del(&smb_lock->llist);
-				release_async_work(work);
-				goto retry;
+				rsp->hdr.Status =
+					STATUS_RANGE_NOT_LOCKED;
+				kfree(smb_lock);
+				goto out2;
 			} else if (!rc) {
 				list_add(&smb_lock->llist, &rollback_list);
+				smb_lock->conn = ksmbd_conn_get(work->conn);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
@@ -7821,11 +7840,14 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 
 		list_del(&smb_lock->llist);
-		spin_lock(&work->conn->llist_lock);
+		conn = smb_lock->conn;
+		spin_lock(&conn->llist_lock);
 		if (!list_empty(&smb_lock->flist))
 			list_del(&smb_lock->flist);
 		list_del(&smb_lock->clist);
-		spin_unlock(&work->conn->llist_lock);
+		smb_lock->conn = NULL;
+		spin_unlock(&conn->llist_lock);
+		ksmbd_conn_put(conn);
 
 		locks_free_lock(smb_lock->fl);
 		if (rlock)
@@ -8487,6 +8509,12 @@ int smb2_ioctl(struct ksmbd_work *work)
 				goto out;
 			}
 
+			if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
+				ksmbd_fd_put(work, fp);
+				ret = -EACCES;
+				goto out;
+			}
+
 			ret = ksmbd_vfs_zero_data(work, fp, off, len);
 			ksmbd_fd_put(work, fp);
 			if (ret < 0)
@@ -8562,6 +8590,21 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto dup_ext_out;
 		}
 
+		if (!test_tree_conn_flag(work->tcon,
+					 KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ret = -EACCES;
+			goto dup_ext_out;
+		}
+
+		if (!(fp_out->daccess & FILE_WRITE_DATA_LE)) {
+			ret = -EACCES;
+			goto dup_ext_out;
+		}
+		if (!(fp_in->daccess & FILE_READ_DATA_LE)) {
+			ret = -EACCES;
+			goto dup_ext_out;
+		}
+
 		src_off = le64_to_cpu(dup_ext->SourceFileOffset);
 		dst_off = le64_to_cpu(dup_ext->TargetFileOffset);
 		length = le64_to_cpu(dup_ext->ByteCount);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d08973b288e5..d17b4f0ee30a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -254,17 +254,20 @@ static ssize_t ksmbd_vfs_getcasexattr(struct mnt_idmap *idmap,
 static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				 size_t count)
 {
+	const struct cred *saved_cred;
 	ssize_t v_len;
 	char *stream_buf = NULL;
 
 	ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
 		    *pos, count);
 
+	saved_cred = override_creds(fp->filp->f_cred);
 	v_len = ksmbd_vfs_getcasexattr(file_mnt_idmap(fp->filp),
 				       fp->filp->f_path.dentry,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
+	revert_creds(saved_cred);
 	if ((int)v_len <= 0)
 		return (int)v_len;
 
@@ -388,6 +391,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				  size_t count)
 {
+	const struct cred *saved_cred;
 	char *stream_buf = NULL, *wbuf;
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
 	size_t size;
@@ -408,6 +412,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		count = XATTR_SIZE_MAX - *pos;
 	}
 
+	saved_cred = override_creds(fp->filp->f_cred);
 	v_len = ksmbd_vfs_getcasexattr(idmap,
 				       fp->filp->f_path.dentry,
 				       fp->stream.name,
@@ -416,14 +421,14 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	if (v_len < 0) {
 		pr_err("not found stream in xattr : %zd\n", v_len);
 		err = v_len;
-		goto out;
+		goto out_revert;
 	}
 
 	if (v_len < size) {
 		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
 		if (!wbuf) {
 			err = -ENOMEM;
-			goto out;
+			goto out_revert;
 		}
 
 		if (v_len > 0)
@@ -441,6 +446,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				 size,
 				 0,
 				 true);
+out_revert:
+	revert_creds(saved_cred);
 	if (err < 0)
 		goto out;
 	else
@@ -1009,13 +1016,15 @@ int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 
 int ksmbd_vfs_unlink(struct file *filp)
 {
+	const struct cred *saved_cred;
 	int err = 0;
 	struct dentry *dir, *dentry = filp->f_path.dentry;
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
+	saved_cred = override_creds(filp->f_cred);
 	err = mnt_want_write(filp->f_path.mnt);
 	if (err)
-		return err;
+		goto out_revert;
 
 	dir = dget_parent(dentry);
 	dentry = start_removing_dentry(dir, dentry);
@@ -1034,7 +1043,8 @@ int ksmbd_vfs_unlink(struct file *filp)
 out:
 	dput(dir);
 	mnt_drop_write(filp->f_path.mnt);
-
+out_revert:
+	revert_creds(saved_cred);
 	return err;
 }
 
@@ -1149,7 +1159,7 @@ int __ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
 
 retry:
 	err = ksmbd_vfs_path_lookup(share_conf, filepath, flags, path, for_remove);
-	if (!err || !caseless)
+	if (!err || err != -ENOENT || !caseless)
 		return err;
 
 	path_len = strlen(filepath);
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index ba3355a6057a..39c56942ae44 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -385,10 +385,14 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 		up_write(&ci->m_lock);
 
 		if (remove_stream_xattr) {
+			const struct cred *saved_cred;
+
+			saved_cred = override_creds(filp->f_cred);
 			err = ksmbd_vfs_remove_xattr(file_mnt_idmap(filp),
 						     &filp->f_path,
 						     fp->stream.name,
 						     true);
+			revert_creds(saved_cred);
 			if (err)
 				pr_err("remove xattr failed : %s\n",
 				       fp->stream.name);
@@ -480,10 +484,14 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		if (!list_empty(&smb_lock->clist) && fp->conn) {
-			spin_lock(&fp->conn->llist_lock);
-			list_del(&smb_lock->clist);
-			spin_unlock(&fp->conn->llist_lock);
+		struct ksmbd_conn *conn = smb_lock->conn;
+
+		if (conn) {
+			spin_lock(&conn->llist_lock);
+			list_del_init(&smb_lock->clist);
+			smb_lock->conn = NULL;
+			spin_unlock(&conn->llist_lock);
+			ksmbd_conn_put(conn);
 		}
 
 		list_del(&smb_lock->flist);
@@ -790,6 +798,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	INIT_LIST_HEAD(&fp->node);
 	INIT_LIST_HEAD(&fp->lock_list);
 	spin_lock_init(&fp->f_lock);
+	mutex_init(&fp->readdir_lock);
 	atomic_set(&fp->refcount, 1);
 
 	fp->filp		= filp;
@@ -1298,9 +1307,15 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	up_write(&ci->m_lock);
 
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&conn->llist_lock);
+		struct ksmbd_conn *lock_conn = smb_lock->conn;
+
+		if (!lock_conn)
+			continue;
+		spin_lock(&lock_conn->llist_lock);
 		list_del_init(&smb_lock->clist);
-		spin_unlock(&conn->llist_lock);
+		smb_lock->conn = NULL;
+		spin_unlock(&lock_conn->llist_lock);
+		ksmbd_conn_put(lock_conn);
 	}
 
 	fp->conn = NULL;
@@ -1430,6 +1445,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 
 	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		smb_lock->conn = ksmbd_conn_get(conn);
 		spin_lock(&conn->llist_lock);
 		list_add_tail(&smb_lock->clist, &conn->lock_list);
 		spin_unlock(&conn->llist_lock);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index e6871266a94b..a3a9fda6de91 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -8,6 +8,7 @@
 
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
@@ -31,6 +32,7 @@ struct ksmbd_session;
 
 struct ksmbd_lock {
 	struct file_lock *fl;
+	struct ksmbd_conn *conn;
 	struct list_head clist;
 	struct list_head flist;
 	struct list_head llist;
@@ -113,6 +115,7 @@ struct ksmbd_file {
 
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
+	struct mutex			readdir_lock;
 	int				dot_dotdot[2];
 	unsigned int			f_state;
 	bool				reserve_lease_break;
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 807c493ed0cd..cc6dc6e1d84d 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -82,8 +82,9 @@ static int load_block_bitmap(struct super_block *sb,
 	int nr_groups = bitmap->s_nr_groups;
 
 	if (block_group >= nr_groups) {
-		udf_debug("block_group (%u) > nr_groups (%d)\n",
+		udf_debug("block_group (%u) >= nr_groups (%d)\n",
 			  block_group, nr_groups);
+		return -EFSCORRUPTED;
 	}
 
 	if (bitmap->s_block_bitmap[block_group]) {
@@ -662,7 +663,7 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 
 	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
 	    check_add_overflow(blk, count, &blk) ||
-	    bloc->logicalBlockNum + count > map->s_partition_len) {
+	    blk > map->s_partition_len) {
 		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
 			  "len %u, partition len %u\n",
 			  partition, bloc->logicalBlockNum, offset, count,
diff --git a/fs/udf/super.c b/fs/udf/super.c
index cad2e15d633b..1b5282790de6 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1263,6 +1263,14 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 
 		map->s_type_specific.s_virtual.s_start_offset =
 			le16_to_cpu(vat20->lengthHeader);
+		if (map->s_type_specific.s_virtual.s_start_offset
+		    > sbi->s_vat_inode->i_size) {
+			udf_err(sb, "Corrupted VAT header length %u (VAT inode size %lld)\n",
+				map->s_type_specific.s_virtual.s_start_offset,
+				sbi->s_vat_inode->i_size);
+			brelse(bh);
+			return -EFSCORRUPTED;
+		}
 		map->s_type_specific.s_virtual.s_num_entries =
 			(sbi->s_vat_inode->i_size -
 				map->s_type_specific.s_virtual.
@@ -1418,7 +1426,8 @@ static int udf_load_sparable_map(struct super_block *sb,
 		if (ident != 0 ||
 		    strncmp(st->sparingIdent.ident, UDF_ID_SPARING,
 			    strlen(UDF_ID_SPARING)) ||
-		    sizeof(*st) + le16_to_cpu(st->reallocationTableLen) >
+		    struct_size(st, mapEntry,
+				le16_to_cpu(st->reallocationTableLen)) >
 							sb->s_blocksize) {
 			brelse(bh);
 			continue;
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 390e4b7d9cb9..dba1172436b7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -253,6 +253,15 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(pte))
 		return true;
+	/*
+	 * Concurrent migration may have replaced the present PTE with a
+	 * non-marker swap entry between fault delivery and this lockless
+	 * re-check. huge_pte_write() on a swap entry decodes random offset
+	 * bits, so gate it on pte_present(). The migration completion path
+	 * will re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(pte))
+		return false;
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
@@ -339,6 +348,17 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(ptent))
 		goto out;
+	/*
+	 * Concurrent swap-out / migration may have replaced the present PTE
+	 * with a non-marker swap entry between fault delivery and this
+	 * lockless re-check. pte_write() on a swap entry decodes random
+	 * offset bits, so gate it on pte_present(). The page-in path will
+	 * re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(ptent)) {
+		ret = false;
+		goto out;
+	}
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index dcd2f93b6a6c..0c5f0548021f 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -866,7 +866,7 @@ xfs_ag_shrink_space(
 void
 xfs_growfs_compute_deltas(
 	struct xfs_mount	*mp,
-	xfs_rfsblock_t		nb,
+	xfs_rfsblock_t		*nb,
 	int64_t			*deltap,
 	xfs_agnumber_t		*nagcountp)
 {
@@ -874,19 +874,19 @@ xfs_growfs_compute_deltas(
 	int64_t		delta;
 	xfs_agnumber_t	nagcount;
 
-	nb_div = nb;
+	nb_div = *nb;
 	nb_mod = do_div(nb_div, mp->m_sb.sb_agblocks);
 	if (nb_mod && nb_mod >= XFS_MIN_AG_BLOCKS)
 		nb_div++;
 	else if (nb_mod)
-		nb = nb_div * mp->m_sb.sb_agblocks;
+		*nb = nb_div * mp->m_sb.sb_agblocks;
 
 	if (nb_div > XFS_MAX_AGNUMBER + 1) {
 		nb_div = XFS_MAX_AGNUMBER + 1;
-		nb = nb_div * mp->m_sb.sb_agblocks;
+		*nb = nb_div * mp->m_sb.sb_agblocks;
 	}
 	nagcount = nb_div;
-	delta = nb - mp->m_sb.sb_dblocks;
+	delta = *nb - mp->m_sb.sb_dblocks;
 	*deltap = delta;
 	*nagcountp = nagcount;
 }
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 16a9b43a3c27..8aa4266c5571 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -330,7 +330,7 @@ int xfs_ag_init_headers(struct xfs_mount *mp, struct aghdr_init_data *id);
 int xfs_ag_shrink_space(struct xfs_perag *pag, struct xfs_trans **tpp,
 			xfs_extlen_t delta);
 void
-xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t nb,
+xfs_growfs_compute_deltas(struct xfs_mount *mp, xfs_rfsblock_t *nb,
 			int64_t *deltap, xfs_agnumber_t *nagcountp);
 int xfs_ag_extend_space(struct xfs_perag *pag, struct xfs_trans *tp,
 			xfs_extlen_t len);
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.h b/fs/xfs/libxfs/xfs_bmap_btree.h
index b238d559ab03..e0c870beaf67 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.h
+++ b/fs/xfs/libxfs/xfs_bmap_btree.h
@@ -89,7 +89,7 @@ xfs_bmbt_key_addr(
 {
 	return (struct xfs_bmbt_key *)
 		((char *)block + xfs_bmbt_block_len(mp) +
-		 (index - 1) * sizeof(struct xfs_bmbt_key *));
+		 (index - 1) * sizeof(struct xfs_bmbt_key));
 }
 
 static inline xfs_bmbt_ptr_t *
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index c6909716b041..89501e8bd2f8 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -878,7 +878,7 @@ xfs_defer_add_barrier(
 	if (dfp)
 		return;
 
-	xfs_defer_alloc(&tp->t_dfops, &xfs_barrier_defer_type);
+	dfp = xfs_defer_alloc(&tp->t_dfops, &xfs_barrier_defer_type);
 
 	trace_xfs_defer_add_item(tp->t_mountp, dfp, NULL);
 }
diff --git a/fs/xfs/libxfs/xfs_dquot_buf.c b/fs/xfs/libxfs/xfs_dquot_buf.c
index ce767b40482f..bbada0d3cc08 100644
--- a/fs/xfs/libxfs/xfs_dquot_buf.c
+++ b/fs/xfs/libxfs/xfs_dquot_buf.c
@@ -436,17 +436,27 @@ xfs_dqinode_metadir_create(
 
 	error = xfs_metadir_create(&upd, S_IFREG);
 	if (error)
-		return error;
+		goto out_cancel;
 
 	xfs_trans_log_inode(upd.tp, upd.ip, XFS_ILOG_CORE);
 
 	error = xfs_metadir_commit(&upd);
 	if (error)
-		return error;
+		goto out_irele;
 
 	xfs_finish_inode_setup(upd.ip);
 	*ipp = upd.ip;
 	return 0;
+
+out_cancel:
+	xfs_metadir_cancel(&upd, error);
+out_irele:
+	/* Have to finish setting up the inode to ensure it's deleted. */
+	if (upd.ip) {
+		xfs_finish_inode_setup(upd.ip);
+		xfs_irele(upd.ip);
+	}
+	return error;
 }
 
 #ifndef __KERNEL__
diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 5d28f4eac527..541e33f33167 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -711,7 +711,7 @@ xfs_exchmaps_estimate_overhead(
 		return -ENOSPC;
 
 	/* Can't actually reserve more than UINT_MAX blocks. */
-	if (req->resblks > UINT_MAX)
+	if (resblks > UINT_MAX)
 		return -ENOSPC;
 
 	req->resblks = resblks;
diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index 143114718d75..19f014e2ece6 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -383,6 +383,14 @@ xchk_dirpath_step_up(
 		goto out_scanlock;
 	}
 
+	/* The handle encoded in the parent pointer must match. */
+	if (VFS_I(dp)->i_generation != be32_to_cpu(dl->pptr_rec.p_gen)) {
+		trace_xchk_dirpath_badgen(dl->sc, dp, path->path_nr,
+				path->nr_steps, &dl->xname, &dl->pptr_rec);
+		error = -EFSCORRUPTED;
+		goto out_scanlock;
+	}
+
 	/* We've reached the root directory; the path is ok. */
 	if (parent_ino == dl->root_ino) {
 		xchk_dirpath_set_outcome(dl, path, XCHK_DIRPATH_OK);
@@ -411,14 +419,6 @@ xchk_dirpath_step_up(
 		goto out_scanlock;
 	}
 
-	/* The handle encoded in the parent pointer must match. */
-	if (VFS_I(dp)->i_generation != be32_to_cpu(dl->pptr_rec.p_gen)) {
-		trace_xchk_dirpath_badgen(dl->sc, dp, path->path_nr,
-				path->nr_steps, &dl->xname, &dl->pptr_rec);
-		error = -EFSCORRUPTED;
-		goto out_scanlock;
-	}
-
 	/* Parent pointer must point up to a directory. */
 	if (!S_ISDIR(VFS_I(dp)->i_mode)) {
 		trace_xchk_dirpath_nondir_parent(dl->sc, dp, path->path_nr,
diff --git a/fs/xfs/scrub/dqiterate.c b/fs/xfs/scrub/dqiterate.c
index 10950e4bd4c3..079dc4e691a0 100644
--- a/fs/xfs/scrub/dqiterate.c
+++ b/fs/xfs/scrub/dqiterate.c
@@ -205,7 +205,7 @@ xchk_dquot_iter(
 	if (error)
 		return error;
 
-	cursor->id = dq->q_id + 1;
+	cursor->id = (uint64_t)dq->q_id + 1;
 	*dqpp = dq;
 	return 1;
 }
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 9738b9ce3f2d..2ac66163263b 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -921,7 +921,7 @@ xrep_dinode_bad_bmbt_fork(
 
 	if (nrecs == 0 || xfs_bmdr_space_calc(nrecs) > dfork_size)
 		return true;
-	if (level == 0 || level >= XFS_BM_MAXLEVELS(sc->mp, whichfork))
+	if (level == 0 || level > XFS_BM_MAXLEVELS(sc->mp, whichfork))
 		return true;
 
 	dmxr = xfs_bmdr_maxrecs(dfork_size, 0);
@@ -1753,7 +1753,7 @@ xrep_clamp_timestamp(
 	struct xfs_inode	*ip,
 	struct timespec64	*ts)
 {
-	ts->tv_nsec = clamp_t(long, ts->tv_nsec, 0, NSEC_PER_SEC);
+	ts->tv_nsec = clamp_t(long, ts->tv_nsec, 0, NSEC_PER_SEC - 1);
 	*ts = timestamp_truncate(*ts, VFS_I(ip));
 }
 
diff --git a/fs/xfs/scrub/rgsuper.c b/fs/xfs/scrub/rgsuper.c
index 482f899a518a..2bd2c0351b35 100644
--- a/fs/xfs/scrub/rgsuper.c
+++ b/fs/xfs/scrub/rgsuper.c
@@ -23,6 +23,8 @@ int
 xchk_setup_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
+	if (xchk_need_intent_drain(sc))
+		xchk_fsgates_enable(sc, XCHK_FSGATES_DRAIN);
 	return xchk_trans_alloc(sc, 0);
 }
 
@@ -43,6 +45,7 @@ xchk_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
 	xfs_rgnumber_t		rgno = sc->sm->sm_agno;
+	unsigned int		flags;
 	int			error;
 
 	/*
@@ -63,7 +66,12 @@ xchk_rgsuperblock(
 	if (!xchk_xref_process_error(sc, 0, 0, &error))
 		return error;
 
-	error = xchk_rtgroup_lock(sc, &sc->sr, XFS_RTGLOCK_BITMAP_SHARED);
+	if (xfs_has_rtrmapbt(sc->mp))
+		flags = XFS_RTGLOCK_BITMAP | XFS_RTGLOCK_RMAP;
+	else
+		flags = XFS_RTGLOCK_BITMAP_SHARED;
+
+	error = xchk_rtgroup_lock(sc, &sc->sr, flags);
 	if (error)
 		return error;
 
@@ -80,9 +88,13 @@ int
 xrep_rgsuperblock(
 	struct xfs_scrub	*sc)
 {
+	struct xfs_buf		*sb_bp;
+
 	ASSERT(rtg_rgno(sc->sr.rtg) == 0);
 
+	sb_bp = xfs_trans_getsb(sc->tp);
 	xfs_log_sb(sc->tp);
+	xfs_log_rtsb(sc->tp, sb_bp);
 	return 0;
 }
 #endif /* CONFIG_XFS_ONLINE_REPAIR */
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index b3a4972d423e..88b438d8fd89 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -258,7 +258,7 @@ xchk_rtbitmap(
 	 * the last free extent we saw and the last possible extent in the rt
 	 * group.
 	 */
-	last_rgbno = rtg->rtg_extents * mp->m_sb.sb_rextsize - 1;
+	last_rgbno = rtg->rtg_extents * mp->m_sb.sb_rextsize;
 	if (rtb->next_free_rgbno < last_rgbno)
 		xchk_xref_has_rt_owner(sc, rtb->next_free_rgbno,
 				last_rgbno - rtb->next_free_rgbno);
diff --git a/fs/xfs/scrub/rtrefcount.c b/fs/xfs/scrub/rtrefcount.c
index 4951cc271788..5f1d5ce7c268 100644
--- a/fs/xfs/scrub/rtrefcount.c
+++ b/fs/xfs/scrub/rtrefcount.c
@@ -607,7 +607,7 @@ xchk_xref_is_rt_cow_staging(
 
 	/* CoW lookup returned a shared extent record? */
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
-		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
+		xchk_btree_xref_set_corrupt(sc, sc->sr.refc_cur, 0);
 
 	/* Must be at least as long as what was passed in */
 	if (rc.rc_blockcount < len)
diff --git a/fs/xfs/scrub/rtrmap.c b/fs/xfs/scrub/rtrmap.c
index 8b1a8389d32f..8c9247923a62 100644
--- a/fs/xfs/scrub/rtrmap.c
+++ b/fs/xfs/scrub/rtrmap.c
@@ -87,6 +87,9 @@ xchk_rtrmapbt_is_shareable(
 		return false;
 	if (irec->rm_flags & XFS_RMAP_UNWRITTEN)
 		return false;
+	if (irec->rm_owner == XFS_RMAP_OWN_COW ||
+	    irec->rm_owner == XFS_RMAP_OWN_FS)
+		return false;
 	return true;
 }
 
@@ -146,6 +149,9 @@ xchk_rtrmap_mergeable(
 		return false;
 	if (r1->rm_flags != r2->rm_flags)
 		return false;
+	if (r1->rm_owner == XFS_RMAP_OWN_COW ||
+	    r1->rm_owner == XFS_RMAP_OWN_FS)
+		return true;
 	return r1->rm_offset + r1->rm_blockcount == r2->rm_offset;
 }
 
@@ -209,7 +215,7 @@ xchk_rtrmapbt_xref(
 			xfs_rgbno_to_rtb(sc->sr.rtg, irec->rm_startblock),
 			irec->rm_blockcount);
 	if (irec->rm_owner == XFS_RMAP_OWN_COW)
-		xchk_xref_is_cow_staging(sc, irec->rm_startblock,
+		xchk_xref_is_rt_cow_staging(sc, irec->rm_startblock,
 				irec->rm_blockcount);
 	else
 		xchk_rtrmapbt_xref_rtrefc(sc, irec);
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index a3f1abc91390..6d7d3523b71f 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -11,7 +11,7 @@ struct xfs_scrub;
 struct xchk_relax {
 	unsigned long	next_resched;
 	unsigned int	resched_nr;
-	bool		interruptible;
+	bool		killable;
 };
 
 /* Yield to the scheduler at most 10x per second. */
@@ -21,7 +21,7 @@ struct xchk_relax {
 	(struct xchk_relax){ \
 		.next_resched	= XCHK_RELAX_NEXT, \
 		.resched_nr	= 0, \
-		.interruptible	= true, \
+		.killable	= true, \
 	}
 
 /*
@@ -45,7 +45,7 @@ static inline int xchk_maybe_relax(struct xchk_relax *widget)
 		widget->next_resched = XCHK_RELAX_NEXT;
 	}
 
-	if (widget->interruptible && fatal_signal_pending(current))
+	if (widget->killable && fatal_signal_pending(current))
 		return -EINTR;
 
 	return 0;
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index c7c4a71b6fa7..2ce24bfe4c0f 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -487,8 +487,7 @@ xfarray_sortinfo_alloc(
 	xfarray_sortinfo_lo(si)[0] = 0;
 	xfarray_sortinfo_hi(si)[0] = array->nr - 1;
 	si->relax = INIT_XCHK_RELAX;
-	if (flags & XFARRAY_SORT_KILLABLE)
-		si->relax.interruptible = false;
+	si->relax.killable = !!(flags & XFARRAY_SORT_KILLABLE);
 
 	trace_xfarray_sort(si, nr_bytes);
 	*infop = si;
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 69e9bc588c8b..c311f61d9554 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1216,6 +1216,14 @@ xfs_qm_dqflush_check(
 	    type != XFS_DQTYPE_PROJ)
 		return __this_address;
 
+	/* bigtime flag should never be set on root dquots */
+	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
+		if (!xfs_has_bigtime(dqp->q_mount))
+			return __this_address;
+		if (dqp->q_id == 0)
+			return __this_address;
+	}
+
 	if (dqp->q_id == 0)
 		return NULL;
 
@@ -1231,14 +1239,6 @@ xfs_qm_dqflush_check(
 	    !dqp->q_rtb.timer)
 		return __this_address;
 
-	/* bigtime flag should never be set on root dquots */
-	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
-		if (!xfs_has_bigtime(dqp->q_mount))
-			return __this_address;
-		if (dqp->q_id == 0)
-			return __this_address;
-	}
-
 	return NULL;
 }
 
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 8d64d904d73c..436857356a0a 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -124,7 +124,7 @@ xfs_growfs_data_private(
 			mp->m_sb.sb_rextsize);
 	if (error)
 		return error;
-	xfs_growfs_compute_deltas(mp, nb, &delta, &nagcount);
+	xfs_growfs_compute_deltas(mp, &nb, &delta, &nagcount);
 
 	/*
 	 * Reject filesystems with a single AG because they are not
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f20a02f49ed9..1403d568a442 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -113,6 +113,7 @@ xfs_bmbt_to_iomap(
 		return xfs_alert_fsblock_zero(ip, imap);
 	}
 
+	iomap->flags = iomap_flags;
 	if (imap->br_startblock == HOLESTARTBLOCK) {
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
@@ -143,7 +144,6 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	iomap->flags = iomap_flags;
 	if (mapping_flags & IOMAP_DAX) {
 		iomap->dax_dev = target->bt_daxdev;
 	} else {
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 09e6678ca487..7f60d33f5d49 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1028,7 +1028,7 @@ xlog_verify_head(
 {
 	struct xlog_rec_header	*tmp_rhead;
 	char			*tmp_buffer;
-	xfs_daddr_t		first_bad;
+	xfs_daddr_t		first_bad = XFS_BUF_DADDR_NULL;
 	xfs_daddr_t		tmp_rhead_blk;
 	int			found;
 	int			error;
@@ -1057,7 +1057,8 @@ xlog_verify_head(
 	 */
 	error = xlog_do_recovery_pass(log, *head_blk, tmp_rhead_blk,
 				      XLOG_RECOVER_CRCPASS, &first_bad);
-	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) && first_bad) {
+	if ((error == -EFSBADCRC || error == -EFSCORRUPTED) &&
+	    first_bad != XFS_BUF_DADDR_NULL) {
 		/*
 		 * We've hit a potential torn write. Reset the error and warn
 		 * about it.
@@ -1906,6 +1907,15 @@ xlog_recover_reorder_trans(
 	list_for_each_entry_safe(item, n, &sort_list, ri_list) {
 		enum xlog_recover_reorder	fate = XLOG_REORDER_ITEM_LIST;
 
+		/* a committed item with no regions has a NULL ri_buf[0] */
+		if (!item->ri_cnt || !item->ri_buf) {
+			xfs_warn(log->l_mp,
+				"%s: committed log item has no regions",
+				__func__);
+			error = -EFSCORRUPTED;
+			break;
+		}
+
 		item->ri_ops = xlog_find_item_ops(item);
 		if (!item->ri_ops) {
 			xfs_warn(log->l_mp,
@@ -3575,4 +3585,3 @@ xlog_recover_cancel(
 	if (xlog_recovery_needed(log))
 		xlog_recover_cancel_intents(log);
 }
-
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 7bd15d9e7fba..02d23226611e 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -166,10 +166,9 @@ xfs_qm_dqpurge(
 		 * does it on success.
 		 */
 		error = xfs_qm_dqflush(dqp, bp);
-		if (!error) {
+		if (!error)
 			error = xfs_bwrite(bp);
-			xfs_buf_relse(bp);
-		}
+		xfs_buf_relse(bp);
 		xfs_dqflock(dqp);
 	}
 	xfs_dquot_detach_buf(dqp);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 251dec48f0e3..e7db02579f28 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -440,6 +440,7 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	xfs_filblks_t		resaligned;
+	unsigned int		seq_before = READ_ONCE(ip->i_df.if_seq);
 	unsigned int		dblocks = 0, rblocks = 0;
 	int			nimaps;
 	int			error;
@@ -465,6 +466,22 @@ xfs_reflink_fill_cow_hole(
 
 	*lockmode = XFS_ILOCK_EXCL;
 
+	/*
+	 * The data fork mapping may have changed while we dropped the ILOCK
+	 * (a racing O_DIRECT writer under IOLOCK_SHARED can complete a full
+	 * CoW cycle including xfs_reflink_end_cow(), which remaps this offset
+	 * and drops the refcount of the old shared block).  Re-read it so the
+	 * shared-status recheck below and the caller's in-place iomap both
+	 * operate on the current mapping rather than a stale physical block.
+	 */
+	if (seq_before != READ_ONCE(ip->i_df.if_seq)) {
+		nimaps = 1;
+		error = xfs_bmapi_read(ip, imap->br_startoff,
+				imap->br_blockcount, imap, &nimaps, 0);
+		if (error)
+			goto out_trans_cancel;
+	}
+
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		goto out_trans_cancel;
@@ -511,6 +528,8 @@ xfs_reflink_fill_delalloc(
 	bool			found;
 
 	do {
+		unsigned int	seq_before = READ_ONCE(ip->i_df.if_seq);
+
 		xfs_iunlock(ip, *lockmode);
 		*lockmode = 0;
 
@@ -521,6 +540,23 @@ xfs_reflink_fill_delalloc(
 
 		*lockmode = XFS_ILOCK_EXCL;
 
+		/*
+		 * The data fork mapping may have changed while we dropped the
+		 * ILOCK (a racing O_DIRECT writer under IOLOCK_SHARED can
+		 * complete a full CoW cycle including xfs_reflink_end_cow(),
+		 * which remaps this offset and drops the refcount of the old
+		 * shared block).  Re-read it so the shared-status recheck
+		 * below and the caller's in-place iomap both operate on the
+		 * current mapping rather than a stale physical block.
+		 */
+		if (seq_before != READ_ONCE(ip->i_df.if_seq)) {
+			nimaps = 1;
+			error = xfs_bmapi_read(ip, imap->br_startoff,
+					imap->br_blockcount, imap, &nimaps, 0);
+			if (error)
+				goto out_trans_cancel;
+		}
+
 		error = xfs_find_trim_cow_extent(ip, imap, cmap, shared,
 				&found);
 		if (error || !*shared)
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 153f3c378f9f..419140dd1d51 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -890,8 +890,7 @@ xfs_growfs_rt_sb_fields(
 
 static int
 xfs_growfs_rt_zoned(
-	struct xfs_rtgroup	*rtg,
-	xfs_rfsblock_t		nrblocks)
+	struct xfs_rtgroup	*rtg)
 {
 	struct xfs_mount	*mp = rtg_mount(rtg);
 	struct xfs_mount	*nmp;
@@ -903,7 +902,8 @@ xfs_growfs_rt_zoned(
 	 * Calculate new sb and mount fields for this round.  Also ensure the
 	 * rtg_extents value is uptodate as the rtbitmap code relies on it.
 	 */
-	nmp = xfs_growfs_rt_alloc_fake_mount(mp, nrblocks,
+	nmp = xfs_growfs_rt_alloc_fake_mount(mp,
+			xfs_rtgs_to_rfsbs(mp, rtg_rgno(rtg) + 1),
 			mp->m_sb.sb_rextsize);
 	if (!nmp)
 		return -ENOMEM;
@@ -1218,7 +1218,7 @@ xfs_growfs_rtg(
 	}
 
 	if (xfs_has_zoned(mp)) {
-		error = xfs_growfs_rt_zoned(rtg, nrblocks);
+		error = xfs_growfs_rt_zoned(rtg);
 		goto out_rele;
 	}
 
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 151d267a496b..4d46643f46cb 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -243,12 +243,20 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 	({                                        \
 		int __ret;                        \
 		local_irq_save(flags);            \
-		__ret = raw_res_spin_lock(lock);  \
-		if (__ret)                        \
+		preempt_disable();                \
+		__ret = res_spin_lock(lock);      \
+		if (__ret) {                      \
 			local_irq_restore(flags); \
+			preempt_enable();         \
+		}                                 \
 		__ret;                            \
 	})
 
-#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
+#define raw_res_spin_unlock_irqrestore(lock, flags) \
+	({                                          \
+		res_spin_unlock(lock);              \
+		local_irq_restore(flags);           \
+		preempt_enable();                   \
+	})
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index 2d42518cbdce..c11eaf757ed0 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -148,19 +148,15 @@ static inline size_t drbg_max_request_bytes(struct drbg_state *drbg)
 	return (1 << 16);
 }
 
+/*
+ * SP800-90A allows implementations to support additional info / personalization
+ * strings of up to 2**35 bits.  Implementations can have a smaller maximum.  We
+ * use 2**35 - 16 bits == U32_MAX - 1 bytes so that the max + 1 always fits in a
+ * size_t, allowing drbg_healthcheck_sanity() to verify its enforcement.
+ */
 static inline size_t drbg_max_addtl(struct drbg_state *drbg)
 {
-	/* SP800-90A requires 2**35 bytes additional info str / pers str */
-#if (__BITS_PER_LONG == 32)
-	/*
-	 * SP800-90A allows smaller maximum numbers to be returned -- we
-	 * return SIZE_MAX - 1 to allow the verification of the enforcement
-	 * of this value in drbg_healthcheck_sanity.
-	 */
-	return (SIZE_MAX - 1);
-#else
-	return (1UL<<35);
-#endif
+	return U32_MAX - 1;
 }
 
 static inline size_t drbg_max_requests(struct drbg_state *drbg)
diff --git a/include/crypto/internal/drbg.h b/include/crypto/internal/drbg.h
index 371e52dcee6c..b4e5ef0be602 100644
--- a/include/crypto/internal/drbg.h
+++ b/include/crypto/internal/drbg.h
@@ -9,24 +9,6 @@
 #ifndef _INTERNAL_DRBG_H
 #define _INTERNAL_DRBG_H
 
-/*
- * Convert an integer into a byte representation of this integer.
- * The byte representation is big-endian
- *
- * @val value to be converted
- * @buf buffer holding the converted integer -- caller must ensure that
- *      buffer size is at least 32 bit
- */
-static inline void drbg_cpu_to_be32(__u32 val, unsigned char *buf)
-{
-	struct s {
-		__be32 conv;
-	};
-	struct s *conversion = (struct s *)buf;
-
-	conversion->conv = cpu_to_be32(val);
-}
-
 /*
  * Concatenation Helper and string operation helper
  *
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..e4593b4a1238 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -55,6 +57,8 @@ bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6..18c19d41c58f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -979,9 +979,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
-	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	unsigned long sample_interval;
+	unsigned long max_nr_accesses;
+
+	sample_interval = attrs->sample_interval ? : 1;
+	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
+	return max_nr_accesses ? : 1;
 }
 
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 88a241aac36a..ea654453e43a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -21,6 +21,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1291,6 +1292,15 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
+/*
+ * Flush the indirect branch predictors before reusing JIT memory, so that
+ * indirect jumps into a newly written program don't reuse predictions left
+ * behind by an old program that occupied the same space.
+ */
+void bpf_arch_pred_flush(void);
+DECLARE_STATIC_CALL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+DECLARE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
 
 struct bpf_binary_header *
@@ -1305,7 +1315,7 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic);
 void bpf_prog_pack_free(void *ptr, u32 size);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
@@ -1319,7 +1329,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_hdr,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic);
 int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 				 struct bpf_binary_header *rw_header);
 void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..f93b216149cc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2438,6 +2438,11 @@ static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 	return mnt_idmap(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(const struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_idmap(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
diff --git a/include/linux/glob.h b/include/linux/glob.h
index 861327b33e41..91595e750936 100644
--- a/include/linux/glob.h
+++ b/include/linux/glob.h
@@ -6,5 +6,6 @@
 #include <linux/compiler.h>	/* For __pure */
 
 bool __pure glob_match(char const *pat, char const *str);
+bool __pure glob_match_len(char const *pat, char const *str, size_t len);
 
 #endif	/* _LINUX_GLOB_H */
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index e71056553108..ab5cc8db3fbb 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -43,6 +43,8 @@ struct hid_sensor_hub_attribute_info {
  * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
  * @raw_size:		Response size for a read request.
  * @raw_data:		Place holder for received response.
+ * @index:		Current write index into raw_data for multi-byte reads.
+ * @max_raw_size:	Total buffer size for multi-byte reads; 0 for single-value reads.
  */
 struct sensor_hub_pending {
 	bool status;
@@ -51,6 +53,8 @@ struct sensor_hub_pending {
 	u32 attr_usage_id;
 	int raw_size;
 	u8  *raw_data;
+	u32 index;
+	u32 max_raw_size;
 };
 
 /**
@@ -183,6 +187,27 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					bool is_signed
 );
 
+/**
+ * sensor_hub_input_attr_read_values() - Synchronous multi-byte read request
+ * @hsdev:		Hub device instance.
+ * @usage_id:		Attribute usage id of parent physical device as per spec
+ * @attr_usage_id:	Attribute usage id as per spec
+ * @report_id:		Report id to look for
+ * @flag:		Synchronous or asynchronous read
+ * @buffer_size:	Size of the buffer in bytes
+ * @buffer:		Buffer to store the read data
+ *
+ * Issues a synchronous or asynchronous read request for an input attribute,
+ * accumulating data into the provided buffer until it is full.
+ * Return: 0 on success, -ETIMEDOUT if the device did not respond, or a
+ * negative error code.
+ */
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer);
+
 /**
 * sensor_hub_set_feature() - Feature set request
 * @hsdev:	Hub device instance.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0135c1c6ff06..5366f31e95b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2601,7 +2601,8 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				    struct page *page, void *opaque);
 
-long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
+long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
+		       long npages, bool may_writeback_src,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 61e876e255e8..f23d4b218da0 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -120,14 +120,18 @@ struct page_ext_iter {
  * page_ext_iter_begin() - Prepare for iterating through page extensions.
  * @iter: page extension iterator.
  * @pfn: PFN of the page we're interested in.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no page_ext exists for this page.
  */
 static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
-						unsigned long pfn)
+		unsigned long pfn, unsigned long count)
 {
+	if (!count)
+		return NULL;
+
 	iter->index = 0;
 	iter->start_pfn = pfn;
 	iter->page_ext = page_ext_lookup(pfn);
@@ -138,19 +142,22 @@ static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
 /**
  * page_ext_iter_next() - Get next page extension
  * @iter: page extension iterator.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no next page_ext exists.
  */
-static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
+static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter,
+		unsigned long count)
 {
 	unsigned long pfn;
 
 	if (WARN_ON_ONCE(!iter->page_ext))
 		return NULL;
 
-	iter->index++;
+	if (++iter->index >= count)
+		return NULL;
 	pfn = iter->start_pfn + iter->index;
 
 	if (page_ext_iter_next_fast_possible(pfn))
@@ -183,9 +190,9 @@ static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *ite
  * IMPORTANT: must be called with RCU read lock taken.
  */
 #define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
-	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page));\
-		__page_ext && __iter.index < __pgcount;          \
-		__page_ext = page_ext_iter_next(&__iter))
+	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page), __pgcount); \
+		__page_ext; \
+		__page_ext = page_ext_iter_next(&__iter, __pgcount))
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2b5ab488e96b..1a69255bb87f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1000,7 +1000,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
 /**
  * kmalloc_obj - Allocate a single instance of the given type
  * @VAR_OR_TYPE: Variable or type to allocate.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL
  * on failure.
@@ -1012,7 +1012,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * kmalloc_objs - Allocate an array of the given type
  * @VAR_OR_TYPE: Variable or type to allocate an array of.
  * @COUNT: How many elements in the array.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to array of @VAR_OR_TYPE on success,
  * or NULL on failure.
@@ -1025,7 +1025,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
  * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
  * @FAM: The name of the flexible array member of the structure.
  * @COUNT: How many flexible array member elements are desired.
- * @GFP: GFP flags for the allocation.
+ * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
  *
  * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
  * failure. If @FAM has been annotated with __counted_by(), the allocation
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad57..290ec5043aa9 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -328,6 +328,7 @@ extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length);
 
 /* svc_rdma_transport.c */
+extern void svc_rdma_xprt_deferred_close(struct svcxprt_rdma *rdma);
 extern struct svc_xprt_class svc_rdma_class;
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 extern struct svc_xprt_class svc_rdma_bc_class;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 89165b769e5c..6e21302db2f0 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,9 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -115,18 +118,20 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	/* Flags only modified on setup/release - bitfield ok */
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			virq_disabled:1;
 	bool			reset_works:1;
 	bool			extended_caps:1;
-	bool			bardirty:1;
 	bool			has_vga:1;
-	bool			needs_reset:1;
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
-	bool			pm_intx_masked:1;
-	bool			pm_runtime_engaged:1;
+	bool			disable_idle_d3:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			needs_reset;
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
+	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..aa554c34f9ec 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -988,6 +988,7 @@ enum {
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
+	HCI_CONN_CREATE,
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..6578da0048fb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -748,6 +748,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_DEL,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 7b23b245a5a8..dc5c9b48e65a 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -357,6 +357,8 @@ static inline int nf_flow_register_bpf(void)
 
 void nf_flow_offload_add(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow);
+void nf_flow_offload_refresh(struct nf_flowtable *flowtable,
+			     struct flow_offload *flow);
 void nf_flow_offload_del(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow);
 void nf_flow_offload_stats(struct nf_flowtable *flowtable,
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 1e9e27d6e06b..df655ce6987d 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -130,6 +130,7 @@ struct tcp_ao_info {
 	u32			snd_sne;
 	u32			rcv_sne;
 	refcount_t		refcnt;		/* Protects twsk destruction */
+	struct rcu_head		rcu;
 };
 
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 24581080e26a..1a1fe7a904c3 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -259,6 +259,7 @@ struct hda_codec {
 	unsigned int forced_resume:1; /* forced resume for jack */
 	unsigned int no_stream_clean_at_suspend:1; /* do not clean streams at suspend */
 	unsigned int ctl_dev_id:1; /* old control element id build behaviour */
+	unsigned int eld_jack_detect:1;	/* Machine jack-detection by ELD */
 
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..826a7d768ca3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2198,6 +2198,7 @@ config RUST
 	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
+	depends on !KASAN || CC_IS_CLANG
 	depends on !KASAN_SW_TAGS
 	help
 	  Enables Rust support in the kernel.
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 8cc7b47d3089..2e14880eef92 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -602,7 +602,6 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 	struct io_wq *wq = worker->wq;
 
 	do {
-		bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
 		struct io_wq_work *work;
 
 		/*
@@ -638,6 +637,7 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 
 		/* handle a whole dependent link */
 		do {
+			bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
 			struct io_wq_work *next_hashed, *linked;
 			unsigned int work_flags = atomic_read(&work->flags);
 			unsigned int hash = __io_wq_is_hashed(work_flags)
diff --git a/io_uring/nop.c b/io_uring/nop.c
index f5c9969e7f64..2f9aa4883261 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -41,6 +41,8 @@ int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		nop->fd = READ_ONCE(sqe->fd);
 	else
 		nop->fd = -1;
+	if (nop->flags & IORING_NOP_FIXED_FILE)
+		req->flags |= REQ_F_FIXED_FILE;
 	if (nop->flags & IORING_NOP_FIXED_BUFFER)
 		req->buf_index = READ_ONCE(sqe->buf_index);
 	if (nop->flags & IORING_NOP_CQE32) {
@@ -60,12 +62,10 @@ int io_nop(struct io_kiocb *req, unsigned int issue_flags)
 	int ret = nop->result;
 
 	if (nop->flags & IORING_NOP_FILE) {
-		if (nop->flags & IORING_NOP_FIXED_FILE) {
+		if (req->flags & REQ_F_FIXED_FILE)
 			req->file = io_file_get_fixed(req, nop->fd, issue_flags);
-			req->flags |= REQ_F_FIXED_FILE;
-		} else {
+		else
 			req->file = io_file_get_normal(req, nop->fd);
-		}
 		if (!req->file) {
 			ret = -EBADF;
 			goto done;
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0c4834645279..63b6519e498c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -601,15 +601,15 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
+	int final_res = io_fixup_rw_res(req, res);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
-	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req))
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-		else
-			req->cqe.res = res;
-	}
+
+	if (res == -EAGAIN && io_rw_should_reissue(req))
+		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+	else if (unlikely(final_res != req->cqe.res))
+		req->cqe.res = final_res;
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);
diff --git a/kernel/audit.c b/kernel/audit.c
index 34dc7cb246ff..41a2de70fa43 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,6 +62,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <linux/sctp.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -950,7 +951,7 @@ static int kauditd_thread(void *dummy)
 		 *       do the multicast send and rotate records from the
 		 *       main queue to the retry/hold queues */
 		wait_event_freezable(kauditd_wait,
-				     (skb_queue_len(&audit_queue) ? 1 : 0));
+				(skb_queue_len_lockless(&audit_queue) ? 1 : 0));
 	}
 
 	return 0;
@@ -1283,7 +1284,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		s.rate_limit		   = audit_rate_limit;
 		s.backlog_limit		   = audit_backlog_limit;
 		s.lost			   = atomic_read(&audit_lost);
-		s.backlog		   = skb_queue_len(&audit_queue);
+		s.backlog		   = skb_queue_len_lockless(&audit_queue);
 		s.feature_bitmap	   = AUDIT_FEATURE_BITMAP_ALL;
 		s.backlog_wait_time	   = audit_backlog_wait_time;
 		s.backlog_wait_time_actual = atomic_read(&audit_backlog_wait_time_actual);
@@ -1627,7 +1628,7 @@ static void audit_receive(struct sk_buff *skb)
 
 	/* can't block with the ctrl lock, so penalize the sender now */
 	if (audit_backlog_limit &&
-	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+	    (skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {
 		DECLARE_WAITQUEUE(wait, current);
 
 		/* wake kauditd to try and flush the queue */
@@ -1933,7 +1934,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		long stime = audit_backlog_wait_time;
 
 		while (audit_backlog_limit &&
-		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+			(skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);
 
@@ -1953,7 +1954,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 			} else {
 				if (audit_rate_check() && printk_ratelimit())
 					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
-						skb_queue_len(&audit_queue),
+						skb_queue_len_lockless(&audit_queue),
 						audit_backlog_limit);
 				audit_log_lost("backlog limit exceeded");
 				return NULL;
@@ -2080,7 +2081,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2090,7 +2092,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+
+	if (check_shl_overflow(len, 1, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 711454f9f724..ae0e75403f76 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -84,10 +84,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	if (d_really_is_negative(dentry)) {
-		audit_mark = ERR_PTR(-ENOENT);
-		goto out;
-	}
 
 	audit_mark = kzalloc_obj(*audit_mark);
 	if (unlikely(!audit_mark)) {
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 0da8d923e39d..f9e81060c1f4 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -178,6 +178,15 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
 	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..510aa32847da 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
-	u32 i, j;
+	u32 i, j, total_cnt, total_repeats;
 	u32 cur;
 
 	/* Ensure not repeating fields that should not be repeated. */
@@ -3686,10 +3686,9 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 		}
 	}
 
-	/* The type of struct size or variable size is u32,
-	 * so the multiplication will not overflow.
-	 */
-	if (field_cnt * (repeat_cnt + 1) > info_cnt)
+	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
+	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
+	    total_cnt > (u32)info_cnt)
 		return -E2BIG;
 
 	cur = field_cnt;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index faadcfb9b5e5..f4eefdacd453 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	kfree(ctx.cur_val);
 
-	if (ret == 1 && ctx.new_updated) {
+	if (!ret && ctx.new_updated) {
 		kvfree(*buf);
 		*buf = ctx.new_val;
 		*pcount = ctx.new_len;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6aa2a8b24030..de61e1894452 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -20,6 +20,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
+#include <linux/static_call.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
@@ -875,6 +876,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -883,6 +885,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+DEFINE_STATIC_CALL_NULL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+
+/*
+ * Enabled once bpf_arch_pred_flush points at a real flush routine. Lets the
+ * pack allocator test "is a predictor flush wired up at all" with a cheap
+ * static branch instead of repeatedly querying the static call target.
+ */
+DEFINE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
 static DEFINE_MUTEX(pack_mutex);
@@ -918,6 +929,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -932,15 +945,23 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	return NULL;
 }
 
-void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
+		/*
+		 * Allocations larger than a pack get their own pages, and
+		 * predictors are not flushed for such allocation. This is only
+		 * safe because cBPF programs (the unprivileged attack surface)
+		 * are bounded well below a pack size.
+		 */
+		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
+			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
@@ -960,8 +981,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	list_for_each_entry(pack, &pack_list, list) {
 		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 						 nbits, 0);
-		if (pos < BPF_PROG_CHUNK_COUNT)
+		if (pos >= BPF_PROG_CHUNK_COUNT)
+			continue;
+		/* Flush not enabled, use any pack */
+		if (!static_branch_unlikely(&bpf_pred_flush_enabled))
 			goto found_free_area;
+		/*
+		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
+		 * clean pack for cBPF. eBPF never flushes, so steer it to a
+		 * dirty pack and keep clean packs free for cBPF.
+		 */
+		if (was_classic ^ pack->arch_flush_needed)
+			goto found_free_area;
+		if (!fallback_pack) {
+			fallback_pack = pack;
+			fallback_pos = pos;
+		}
+	}
+
+	/* No preferred pack found */
+	if (fallback_pack) {
+		pack = fallback_pack;
+		pos = fallback_pos;
+		goto found_free_area;
 	}
 
 	pack = alloc_new_pack(bpf_fill_ill_insns);
@@ -971,6 +1013,16 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	/* Flush only for cBPF as it may contain a crafted gadget */
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) &&
+	    pack->arch_flush_needed &&
+	    was_classic) {
+		struct bpf_prog_pack *p;
+
+		static_call_cond(bpf_arch_pred_flush)();
+		list_for_each_entry(p, &pack_list, list)
+			p->arch_flush_needed = false;
+	}
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -1008,6 +1060,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
 
 	bitmap_clear(pack->bitmap, pos, nbits);
+
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);
@@ -1130,7 +1185,8 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 			  unsigned int alignment,
 			  struct bpf_binary_header **rw_header,
 			  u8 **rw_image,
-			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns,
+			  bool was_classic)
 {
 	struct bpf_binary_header *ro_header;
 	u32 size, hole, start;
@@ -1143,7 +1199,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+	ro_header = bpf_prog_pack_alloc(size, bpf_fill_ill_insns, was_classic);
 	if (!ro_header) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..5b9eac5342a9 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
 {
 	struct xdp_frame *nxdpf;
 
+	/* Frags live outside the linear frame and cannot be cloned safely. */
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
 	nxdpf = xdpf_clone(xdpf);
 	if (!nxdpf)
 		return -ENOMEM;
@@ -726,6 +730,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 	struct sk_buff *nskb;
 	int err;
 
+	if (unlikely(skb_is_nonlinear(skb)))
+		return -EOPNOTSUPP;
+
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb)
 		return -ENOMEM;
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index b77db7413f8c..ea2d60dc1fee 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -145,7 +145,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 
 	mutex_lock(&d->mutex);
 	if (!d->image) {
-		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero);
+		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
 		if (!d->image)
 			goto out;
 		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0f57608b385d..4d6f25db9ba1 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
@@ -359,7 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference(*slot))) {
+	while ((node = rcu_dereference_protected(*slot, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -482,7 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference(*trim))) {
+	while ((node = rcu_dereference_protected(*trim, 1))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..ff9b1f68ceca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool can_elide_value_nullness(enum bpf_map_type type);
+static bool can_elide_value_nullness(const struct bpf_map *map);
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -10221,13 +10221,16 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
-/* Returns whether or not the given map type can potentially elide
+/* Returns whether or not the given map can potentially elide
  * lookup return value nullness check. This is possible if the key
  * is statically known.
  */
-static bool can_elide_value_nullness(enum bpf_map_type type)
+static bool can_elide_value_nullness(const struct bpf_map *map)
 {
-	switch (type) {
+	if (map->map_flags & BPF_F_INNER_MAP)
+		return false;
+
+	switch (map->map_type) {
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 		return true;
@@ -10589,7 +10592,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..240684f4b18c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4728,7 +4728,7 @@ static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
 				  struct task_struct *task,
-				  bool revoke);
+				  unsigned long detach_flags);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4755,7 +4755,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx, ctx->task, false);
+		perf_event_exit_event(event, ctx, ctx->task, DETACH_GROUP);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -7150,6 +7150,8 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 	int err = 0;
 	unsigned long pagenum;
 
+	guard(mutex)(&rb->aux_mutex);
+
 	/*
 	 * We map this as a VM_PFNMAP VMA.
 	 *
@@ -12900,7 +12902,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, ctx->task, true);
+	perf_event_exit_event(event, ctx, ctx->task, DETACH_REVOKE);
 
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -14488,12 +14490,13 @@ static void
 perf_event_exit_event(struct perf_event *event,
 		      struct perf_event_context *ctx,
 		      struct task_struct *task,
-		      bool revoke)
+		      unsigned long detach_flags)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = DETACH_EXIT;
 	unsigned int attach_state;
 
+	detach_flags |= DETACH_EXIT;
+
 	if (parent_event) {
 		/*
 		 * Do not destroy the 'original' grouping; because of the
@@ -14516,8 +14519,8 @@ perf_event_exit_event(struct perf_event *event,
 			sync_child_event(event, task);
 	}
 
-	if (revoke)
-		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
+	if (detach_flags & DETACH_REVOKE)
+		detach_flags |= DETACH_GROUP;
 
 	perf_remove_from_context(event, detach_flags);
 	/*
@@ -14605,7 +14608,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
+		perf_event_exit_event(child_event, ctx, exit ? task : NULL, 0);
 
 	mutex_unlock(&ctx->mutex);
 
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 1d99a84dc9ad..b597cb3d17fc 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -643,12 +643,6 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 				continue;
 			}
 
-			/* Self-deadlock: non-top waiter already owns the PI futex. */
-			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
-				ret = -EDEADLK;
-				break;
-			}
-
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 7a42385dabe2..ec7aebc15a80 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -382,9 +382,13 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 int luo_session_create(const char *name, struct file **filep)
 {
+	size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
 	struct luo_session *session;
 	int err;
 
+	if (len == 0 || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
+		return -EINVAL;
+
 	session = luo_session_alloc(name);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 36f52a232a12..cce098671be9 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -307,6 +307,8 @@ int module_decompress(struct load_info *info, const void *buf, size_t size)
 	 */
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
 
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 84c4fe3abd74..8f0dee8fc475 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -110,8 +110,16 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
  * rq lock and possibly create a large contention, sending an
  * IPI to that CPU and let that CPU push the RT task to where
  * it should go may be a better scenario.
+ *
+ * This is best for PREEMPT_RT, but for non-RT it can cause issues
+ * when preemption is disabled for long periods of time. Have
+ * it only default enabled for PREEMPT_RT.
  */
+# ifdef CONFIG_PREEMPT_RT
 SCHED_FEAT(RT_PUSH_IPI, true)
+# else
+SCHED_FEAT(RT_PUSH_IPI, false)
+# endif
 #endif
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 1c954f330dfe..d51428867a33 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -60,15 +60,14 @@ EXPORT_SYMBOL(get_jiffies_64);
 
 EXPORT_SYMBOL(jiffies);
 
-static int __init init_jiffies_clocksource(void)
-{
-	return __clocksource_register(&clocksource_jiffies);
-}
-
-core_initcall(init_jiffies_clocksource);
+static bool cs_jiffies_registered __initdata;
 
 struct clocksource * __init __weak clocksource_default_clock(void)
 {
+	if (!cs_jiffies_registered) {
+		__clocksource_register(&clocksource_jiffies);
+		cs_jiffies_registered = true;
+	}
 	return &clocksource_jiffies;
 }
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0de2bb7cbec0..6f3ddb2b1f46 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1504,6 +1504,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		spin_lock_irq(&timer.it_lock);
 		error = posix_cpu_timer_set(&timer, flags, &it, NULL);
 		if (error) {
+			posix_cpu_timer_del(&timer);
 			spin_unlock_irq(&timer.it_lock);
 			return error;
 		}
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c493a4010305..eea51450e418 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1980,13 +1980,14 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
+	clock = clocksource_default_clock();
+	if (clock->enable)
+		clock->enable(clock);
+
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
 	ntp_init();
 
-	clock = clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
 	tk_setup_internals(tks, clock);
 
 	tk_set_xtime(tks, &wall_time);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..6385cd662d8d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1056,11 +1056,9 @@ static int regex_match_end(char *str, struct regex *r, int len)
 	return 0;
 }
 
-static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
+static int regex_match_glob(char *str, struct regex *r, int len)
 {
-	if (glob_match(r->pattern, str))
-		return 1;
-	return 0;
+	return glob_match_len(r->pattern, str, len) ? 1 : 0;
 }
 
 /**
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f283391a4dc8..cd37f2013758 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -458,12 +458,12 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	ftrace_func_t func;
 	u32 new_flags;
 
-	/* Do nothing if already set. */
-	if (!!set == !!(tr->current_trace_flags->val & bit))
+	/* We can change this flag only when current tracer is function. */
+	if (tr->current_trace != &function_trace)
 		return 0;
 
-	/* We can change this flag only when not running. */
-	if (tr->current_trace != &function_trace)
+	/* Do nothing if already set. */
+	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
 	new_flags = (tr->current_trace_flags->val & ~bit) | (set ? bit : 0);
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6fb00e08a4e2..877f7675ba26 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -894,6 +894,14 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects.
+	 */
+	if (!debug_objects_enabled)
+		return 0;
+
 	debug_print_object(&o, "activate");
 
 	switch (o.state) {
@@ -1071,6 +1079,15 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 		return;
 	}
 
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects. Don't run the fixup
+	 * as it might turn a valid object useless. See for example
+	 * hrtimer_fixup_assert_init().
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	/* Object is neither tracked nor static. It's not initialized. */
 	debug_print_object(&o, "assert_init");
 	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
diff --git a/lib/glob.c b/lib/glob.c
index 7aca76c25bcb..c80d9dd736b4 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -11,6 +11,9 @@
 MODULE_DESCRIPTION("glob(7) matching");
 MODULE_LICENSE("Dual MIT/GPL");
 
+static bool __pure glob_match_str(char const *pat, char const *str,
+				  char const *str_end);
+
 /**
  * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
  * @pat: Shell-style pattern to match, e.g. "*.[ch]".
@@ -40,6 +43,29 @@ MODULE_LICENSE("Dual MIT/GPL");
  * An opening bracket without a matching close is matched literally.
  */
 bool __pure glob_match(char const *pat, char const *str)
+{
+	return glob_match_str(pat, str, NULL);
+}
+EXPORT_SYMBOL(glob_match);
+
+/**
+ * glob_match_len - glob match against a length-bounded string
+ * @pat: Shell-style pattern to match.
+ * @str: String to match.  Need not be NUL-terminated.
+ * @len: Number of bytes of @str that may be read.
+ *
+ * Like glob_match(), but @str is only read up to @len bytes, so it can be
+ * used on buffers that are not NUL-terminated (e.g. trace event fields).
+ * A NUL byte within @len still terminates the string.
+ */
+bool __pure glob_match_len(char const *pat, char const *str, size_t len)
+{
+	return glob_match_str(pat, str, str + len);
+}
+EXPORT_SYMBOL(glob_match_len);
+
+static bool __pure glob_match_str(char const *pat, char const *str,
+				  char const *str_end)
 {
 	/*
 	 * Backtrack to previous * on mismatch and retry starting one
@@ -55,9 +81,11 @@ bool __pure glob_match(char const *pat, char const *str)
 	 * on mismatch, or true after matching the trailing nul bytes.
 	 */
 	for (;;) {
-		unsigned char c = *str++;
+		unsigned char c = (str_end && str >= str_end) ? '\0' : *str;
 		unsigned char d = *pat++;
 
+		str++;
+
 		switch (d) {
 		case '?':	/* Wildcard: anything but nul */
 			if (c == '\0')
@@ -125,4 +153,3 @@ bool __pure glob_match(char const *pat, char const *str)
 		}
 	}
 }
-EXPORT_SYMBOL(glob_match);
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 213504915737..38996c4baa40 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1253,8 +1253,8 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 	mmap_read_unlock(mm);
 	mmput(mm);
 free_mem:
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 	return ret;
 }
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index c3e4c871b0bb..4752d6118eb9 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -140,6 +140,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
 	 */
 	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
+	hotness = max(min(hotness, DAMOS_MAX_SCORE), 0);
 
 	return hotness;
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..b72f8c23c322 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4671,7 +4671,7 @@ static inline bool can_do_cachestat(struct file *f)
 {
 	if (f->f_mode & FMODE_WRITE)
 		return true;
-	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
+	if (file_owner_or_capable(f))
 		return true;
 	return file_permission(f, MAY_WRITE) == 0;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..d6e04041f5dc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto xa_unlocked;
 	}
 
-	if (!is_shmem) {
+xa_locked:
+	xas_unlock_irq(&xas);
+xa_unlocked:
+
+	/*
+	 * If collapse is successful, flush must be done now before copying.
+	 * If collapse is unsuccessful, does flush actually need to be done?
+	 * Do it anyway, to clear the state.
+	 */
+	try_to_unmap_flush();
+
+	if (result == SCAN_SUCCEED && !is_shmem && !mapping_large_folio_support(mapping)) {
+		/*
+		 * invalidate_lock as shared excludes against concurrent opens
+		 * in do_dentry_open() truncating the page cache. This is
+		 * particularly important if there are dirty folios in transit.
+		 */
+		filemap_invalidate_lock_shared(mapping);
 		filemap_nr_thps_inc(mapping);
 		/*
 		 * Paired with the fence in do_dentry_open() -> get_write_access()
 		 * to ensure i_writecount is up to date and the update to nr_thps
 		 * is visible. Ensures the page cache will be truncated if the
-		 * file is opened writable.
+		 * file is opened writable. If collapse looks to be successful,
+		 * flush any dirty pages out the page cache. With the nr_thps
+		 * incremented, there won't be any new writers (nor new dirties).
 		 */
 		smp_mb();
-		if (inode_is_open_for_write(mapping->host)) {
+		if (inode_is_open_for_write(mapping->host) || filemap_write_and_wait(mapping)) {
 			result = SCAN_FAIL;
 			filemap_nr_thps_dec(mapping);
+			filemap_invalidate_unlock_shared(mapping);
+			goto rollback;
 		}
+		filemap_invalidate_unlock_shared(mapping);
 	}
 
-xa_locked:
-	xas_unlock_irq(&xas);
-xa_unlocked:
-
-	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
-	 */
-	try_to_unmap_flush();
-
 	if (result == SCAN_SUCCEED && nr_none &&
 	    !shmem_charge(mapping->host, nr_none))
 		result = SCAN_FAIL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 69708e953cf5..5665785e5ac3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -336,8 +336,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 296f2e3922b5..c8757c5085bf 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -227,8 +227,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 5754d1c36462..2311ae7c2ff4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -504,7 +504,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			break;
 		case MAP_DROPPABLE:
 			if (VM_DROPPABLE == VM_NONE)
-				return -ENOTSUPP;
+				return -EOPNOTSUPP;
 			/*
 			 * A locked or stack area makes no sense to be droppable.
 			 *
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 76b3f750cf65..d6c1a9b1e34a 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -59,12 +59,14 @@ static inline int shrinker_unit_alloc(struct shrinker_info *new,
 	return 0;
 }
 
-void free_shrinker_info(struct mem_cgroup *memcg)
+static void __free_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_per_node *pn;
 	struct shrinker_info *info;
 	int nid;
 
+	lockdep_assert_held(&shrinker_mutex);
+
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = rcu_dereference_protected(pn->shrinker_info, true);
@@ -74,6 +76,13 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 	}
 }
 
+void free_shrinker_info(struct mem_cgroup *memcg)
+{
+	mutex_lock(&shrinker_mutex);
+	__free_shrinker_info(memcg);
+	mutex_unlock(&shrinker_mutex);
+}
+
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	int nid, ret = 0;
@@ -98,8 +107,8 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	return ret;
 
 err:
+	__free_shrinker_info(memcg);
 	mutex_unlock(&shrinker_mutex);
-	free_shrinker_info(memcg);
 	return -ENOMEM;
 }
 
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index affa64437302..cafb56630132 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -57,8 +57,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	if (!count_per_node)
 		return -ENOMEM;
 
-	rcu_read_lock();
-
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
@@ -88,8 +86,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-
 	kfree(count_per_node);
 	return ret;
 }
@@ -187,10 +183,12 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0440, entry, shrinker,
-			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0220, entry, shrinker,
-			    &shrinker_debugfs_scan_fops);
+	if (shrinker->count_objects)
+		debugfs_create_file("count", 0440, entry, shrinker,
+				    &shrinker_debugfs_count_fops);
+	if (shrinker->scan_objects)
+		debugfs_create_file("scan", 0220, entry, shrinker,
+				    &shrinker_debugfs_scan_fops);
 	return 0;
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..9365501d0df1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4537,15 +4537,17 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	gfp_t init_flags = flags & gfp_allowed_mask;
 
 	/*
-	 * For kmalloc object, the allocated memory size(object_size) is likely
-	 * larger than the requested size(orig_size). If redzone check is
-	 * enabled for the extra space, don't zero it, as it will be redzoned
-	 * soon. The redzone operation for this extra space could be seen as a
-	 * replacement of current poisoning under certain debug option, and
-	 * won't break other sanity checks.
+	 * For kmalloc object, the allocated size (object_size) can be larger
+	 * than the requested size (orig_size). We however need to zero the
+	 * whole object_size to handle possible later krealloc() with
+	 *__GFP_ZERO properly.
+	 *
+	 * But if we keep track of the requested size, krealloc() uses that
+	 * information. Additionally if red zoning is enabled, the extra space
+	 * is also red zone, so we should not overwrite it. So limit zeroing to
+	 * orig_size if we track it.
 	 */
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
-	    (s->flags & SLAB_KMALLOC))
+	if (slub_debug_orig_size(s))
 		zero_size = orig_size;
 
 	/*
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index de779fed8c21..95c38e54dd58 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -124,6 +124,8 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 		return 0;
 
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	if (unlikely(!ctrl->map))
+		return 0;
 	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9174f1eeffb0..74a1e324449d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1054,6 +1054,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		swap_cluster_unlock(ci);
 		if (to_scan <= 0)
 			break;
+		cond_resched();
 	}
 }
 
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 7b374595328d..a4dde85664f2 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -117,9 +117,9 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
 				return ret;
 			}
 		} else {
-			spin_unlock_bh(&lowpan_nhc_lock);
 			netdev_warn(dev, "received nhc id for %s which is not implemented.\n",
 				    nhc->name);
+			spin_unlock_bh(&lowpan_nhc_lock);
 			return -ENOTSUPP;
 		}
 	} else {
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 960a19b3e26d..4dbbc44a950d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -777,20 +777,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
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
@@ -817,10 +807,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
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
index 1a6aa3f8d4d6..ee8d92ea1e5a 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -308,7 +308,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 restart:
 	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
-		/* Prevent early freeing of sk due to unlink and sock_kill */
+		/* The reference from bt_accept_get() keeps sk alive. */
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
@@ -324,13 +324,11 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 		next = bt_accept_get(parent, sk);
 
-		/* sk is safely in the parent list so reduce reference count */
-		sock_put(sk);
-
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
 			bt_accept_unlink(sk);
 			release_sock(sk);
+			sock_put(sk);
 			continue;
 		}
 
@@ -340,16 +338,6 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
-			/* Hand the caller a reference taken while sk is
-			 * still locked.  bt_accept_unlink() just dropped
-			 * the accept-queue reference; without this hold a
-			 * concurrent teardown (e.g. l2cap_conn_del() ->
-			 * l2cap_sock_kill()) could free sk between
-			 * release_sock() and the caller using it.  Every
-			 * caller drops this with sock_put() when done.
-			 */
-			sock_hold(sk);
-
 			release_sock(sk);
 			if (next)
 				sock_put(next);
@@ -357,6 +345,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 		}
 
 		release_sock(sk);
+		sock_put(sk);
 	}
 
 	return NULL;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5c5f53ff30e8..ed3ca38d8a6e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -562,14 +562,18 @@ static int bnep_session(void *arg)
 	return 0;
 }
 
-static struct device *bnep_get_device(struct bnep_session *session)
+static struct l2cap_conn *bnep_get_conn(struct bnep_session *session)
 {
-	struct l2cap_conn *conn = l2cap_pi(session->sock->sk)->chan->conn;
+	struct l2cap_chan *chan = l2cap_pi(session->sock->sk)->chan;
+	struct l2cap_conn *conn;
 
-	if (!conn || !conn->hcon)
-		return NULL;
+	l2cap_chan_lock(chan);
+	conn = chan->conn;
+	if (conn)
+		l2cap_conn_get(conn);
+	l2cap_chan_unlock(chan);
 
-	return &conn->hcon->dev;
+	return conn;
 }
 
 static const struct device_type bnep_type = {
@@ -581,6 +585,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	u32 valid_flags = BIT(BNEP_SETUP_RESPONSE);
 	struct net_device *dev;
 	struct bnep_session *s, *ss;
+	struct l2cap_conn *conn = NULL;
 	u8 dst[ETH_ALEN], src[ETH_ALEN];
 	int err;
 
@@ -640,10 +645,18 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	bnep_set_default_proto_filter(s);
 #endif
 
-	SET_NETDEV_DEV(dev, bnep_get_device(s));
+	conn = bnep_get_conn(s);
+	if (!conn) {
+		err = -ENOTCONN;
+		goto failed;
+	}
+
+	SET_NETDEV_DEV(dev, &conn->hcon->dev);
 	SET_NETDEV_DEVTYPE(dev, &bnep_type);
 
 	err = register_netdev(dev);
+	l2cap_conn_put(conn);
+	conn = NULL;
 	if (err)
 		goto failed;
 
@@ -665,6 +678,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	return 0;
 
 failed:
+	if (conn)
+		l2cap_conn_put(conn);
 	up_write(&bnep_session_sem);
 	free_netdev(dev);
 	return err;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54eabaa46960..eba4a548bef5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	conn->abort_reason = reason;
 
-	/* If the connection is pending check the command opcode since that
-	 * might be blocking on hci_cmd_sync_work while waiting its respective
-	 * event so we need to hci_cmd_sync_cancel to cancel it.
-	 *
-	 * hci_connect_le serializes the connection attempts so only one
-	 * connection can be in BT_CONNECT at time.
+	/* Cancel the connect attempt. A return of 0 means the create command
+	 * was still queued and got dequeued, so there is nothing to disconnect.
 	 */
-	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
-		switch (hci_skb_event(hdev->sent_cmd)) {
-		case HCI_EV_CONN_COMPLETE:
-		case HCI_EV_LE_CONN_COMPLETE:
-		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
-		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, ECANCELED);
-			break;
-		}
-	/* Cancel connect attempt if still queued/pending */
-	} else if (!hci_cancel_connect_sync(hdev, conn)) {
+	if (!hci_cancel_connect_sync(hdev, conn))
 		return 0;
-	}
 
 	/* Run immediately if on cmd_sync_work since this may be called
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index df23245d6ccd..a3df69bdec1e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() at done.
+	 */
+	hci_conn_get(conn);
+
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
 			hci_conn_del(conn);
+			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 					     &own_addr_type);
 	if (err)
 		goto done;
+
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
 	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
@@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+
 	if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
+	hci_conn_put(conn);
 	return err;
 }
 
@@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-					sizeof(cp), &cp,
-					HCI_EV_CONN_COMPLETE,
-					conn->conn_timeout, NULL);
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() below.
+	 */
+	hci_conn_get(conn);
+
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
+
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+	hci_conn_put(conn);
+
+	return err;
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7037,22 +7067,97 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return (err == -EEXIST) ? 0 : err;
 }
 
-int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_acl_cancel_create_conn_sync(struct hci_dev *hdev,
+					   struct hci_conn *conn)
 {
-	if (conn->state != BT_OPEN)
-		return -EINVAL;
+	struct hci_cmd_sync_work_entry *entry;
+	int err = -EBUSY;
+
+	/* cmd_sync_work_lock makes the HCI_CONN_CREATE test and the cancel
+	 * atomic against the worker, which takes this lock to dequeue every
+	 * entry: while it is held no other command can become pending, so
+	 * hci_cmd_sync_cancel() cannot cancel an unrelated command.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	/* In flight: this connection owns the pending request, cancel it. */
+	if (test_bit(HCI_CONN_CREATE, &conn->flags)) {
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+		goto unlock;
+	}
+
+	/* Still queued: a successful dequeue means it never started, so there
+	 * is nothing to disconnect.
+	 */
+	entry = _hci_cmd_sync_lookup_entry(hdev, hci_acl_create_conn_sync, conn,
+					   NULL);
+	if (entry) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		err = 0;
+	}
+
+unlock:
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return err;
+}
+
+static int hci_le_cancel_create_conn_sync(struct hci_dev *hdev,
+					  struct hci_conn *conn)
+{
+	struct hci_cmd_sync_work_entry *entry;
+	int err = -EBUSY;
+
+	/* cmd_sync_work_lock keeps the HCI_CONN_CREATE test and the cancel
+	 * atomic against the cmd_sync worker.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
 
+	if (test_bit(HCI_CONN_CREATE, &conn->flags)) {
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+		goto unlock;
+	}
+
+	entry = _hci_cmd_sync_lookup_entry(hdev, hci_le_create_conn_sync, conn,
+					   create_le_conn_complete);
+	if (entry) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		err = 0;
+	}
+
+unlock:
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return err;
+}
+
+static int hci_cis_cancel_create_conn_sync(struct hci_dev *hdev,
+					   struct hci_conn *conn)
+{
+	/* LE Create CIS is shared by the whole CIG and cannot be dequeued
+	 * per-connection, so only an in-flight command can be cancelled.
+	 * cmd_sync_work_lock keeps the test and the cancel atomic against the
+	 * cmd_sync worker.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return -EBUSY;
+}
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
 	switch (conn->type) {
 	case ACL_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev,
-						  hci_acl_create_conn_sync,
-						  conn, NULL);
+		return hci_acl_cancel_create_conn_sync(hdev, conn);
 	case LE_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
-						  conn, create_le_conn_complete);
+		return hci_le_cancel_create_conn_sync(hdev, conn);
+	case CIS_LINK:
+		return hci_cis_cancel_create_conn_sync(hdev, conn);
+	default:
+		return -ENOENT;
 	}
-
-	return -ENOENT;
 }
 
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3abd8111dda8..7186e8d88c75 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1589,6 +1589,7 @@ static void iso_conn_big_sync(struct sock *sk)
 {
 	int err;
 	struct hci_dev *hdev;
+	struct iso_conn *conn;
 	bdaddr_t src, dst;
 	u8 src_type;
 
@@ -1611,8 +1612,17 @@ static void iso_conn_big_sync(struct sock *sk)
 	hci_dev_lock(hdev);
 	lock_sock(sk);
 
+	/* The socket lock was dropped for hci_get_route(), so the connection
+	 * may have been torn down meanwhile: iso_chan_del() clears conn and
+	 * the broadcast teardown path can clear conn->hcon on its own. Check
+	 * both before dereferencing conn->hcon.
+	 */
+	conn = iso_pi(sk)->conn;
+	if (!conn || !conn->hcon)
+		goto unlock;
+
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-		err = hci_conn_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+		err = hci_conn_big_create_sync(hdev, conn->hcon,
 					       &iso_pi(sk)->qos,
 					       iso_pi(sk)->sync_handle,
 					       iso_pi(sk)->bc_num_bis,
@@ -1621,6 +1631,7 @@ static void iso_conn_big_sync(struct sock *sk)
 			bt_dev_err(hdev, "hci_big_create_sync: %d", err);
 	}
 
+unlock:
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..32f0c8b73b17 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -411,7 +411,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_put(chan);
 		return;
 	}
@@ -422,6 +422,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -434,10 +437,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
-
 	mutex_unlock(&conn->lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -490,6 +493,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn)
+		l2cap_conn_put(chan->conn);
+
 	kfree(chan);
 }
 
@@ -593,7 +599,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -648,30 +654,26 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
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
+	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
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
 	}
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
@@ -1776,19 +1778,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	disable_delayed_work_sync(&conn->info_timer);
 	disable_delayed_work_sync(&conn->id_addr_timer);
 
+	cancel_work_sync(&conn->pending_rx_work);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
-
-	/* We can not call flush_work(&conn->pending_rx_work) here since we
-	 * might block if we are running on a worker from the same workqueue
-	 * pending_rx_work is waiting on.
-	 */
-	if (work_pending(&conn->pending_rx_work))
-		cancel_work_sync(&conn->pending_rx_work);
-
 	ida_destroy(&conn->tx_ida);
 
 	l2cap_unregister_all_users(conn);
@@ -1903,7 +1899,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -1924,7 +1920,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2565,7 +2561,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	int err;
 	struct sk_buff_head seg_queue;
 
-	if (!chan->conn)
+	if (test_bit(FLAG_DEL, &chan->flags))
 		return -ENOTCONN;
 
 	/* Connectionless channel */
@@ -3052,13 +3048,24 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 	return NULL;
 }
 
-static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
-				     unsigned long *val)
+static inline int l2cap_get_conf_opt(void **ptr, void *end, int *type,
+				     int *olen, unsigned long *val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 	int len;
 
+	/* opt->len is attacker-controlled. Validate that the full option
+	 * (header + value) actually fits in the buffer before touching
+	 * opt->val, otherwise the switch below reads past the end of the
+	 * caller's buffer.
+	 */
+	if (end - *ptr < L2CAP_CONF_OPT_SIZE)
+		return -EINVAL;
+
 	len = L2CAP_CONF_OPT_SIZE + opt->len;
+	if (end - *ptr < len)
+		return -EINVAL;
+
 	*ptr += len;
 
 	*type = opt->type;
@@ -3160,12 +3167,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
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
@@ -3426,6 +3437,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	void *ptr = rsp->data;
 	void *endptr = data + data_size;
 	void *req = chan->conf_req;
+	void *req_end = req + chan->conf_len;
 	int len = chan->conf_len;
 	int type, hint, olen;
 	unsigned long val;
@@ -3439,9 +3451,11 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&req, req_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3669,6 +3683,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
 	void *endptr = data + size;
+	void *rsp_end = rsp + len;
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
@@ -3677,9 +3692,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&rsp, rsp_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3930,6 +3947,7 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
 	int type, olen;
 	unsigned long val;
+	void *rsp_end = rsp + len;
 	/* Use sane default values in case a misbehaving remote device
 	 * did not send an RFC or extended window size option.
 	 */
@@ -3948,9 +3966,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int ret = l2cap_get_conf_opt(&rsp, rsp_end, &type, &olen, &val);
+
+		if (ret < 0)
 			break;
+		len -= ret;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c138aa4ae266..1e93de155987 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1482,8 +1482,8 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 
 	/* Close not yet accepted channels.
 	 *
-	 * bt_accept_dequeue() now returns sk with an extra reference held
-	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * bt_accept_dequeue() returns sk with its temporary queue-walk
+	 * reference held, so a concurrent l2cap_conn_del()
 	 * -> l2cap_sock_kill() cannot free sk under us.
 	 *
 	 * cleanup_listen() runs under the parent sk lock, so unlike
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f4aa814a0397..7c164a17ef59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7661,6 +7661,8 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 	if (!err) {
 		struct hci_conn_params *params;
 
+		hci_dev_lock(hdev);
+
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 
@@ -7669,6 +7671,7 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
 				     cp->addr.type, hdev->conn_flags,
 				     params ? params->flags : 0);
+		hci_dev_unlock(hdev);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 8a6a069329d2..1147ae4fee97 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -403,6 +403,9 @@ ebt_check_match(struct ebt_entry_match *m, struct xt_mtchk_param *par,
 	    left - sizeof(struct ebt_entry_match) < m->match_size)
 		return -EINVAL;
 
+	if (strnlen(m->u.name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return -EINVAL;
+
 	match = xt_find_match(NFPROTO_BRIDGE, m->u.name, m->u.revision);
 	if (IS_ERR(match) || match->family != NFPROTO_BRIDGE) {
 		if (!IS_ERR(match))
@@ -921,8 +924,7 @@ static int translate_table(struct net *net, const char *name,
 		 * if an error occurs
 		 */
 		newinfo->chainstack =
-			vmalloc_array(nr_cpu_ids,
-				      sizeof(*(newinfo->chainstack)));
+			vcalloc(nr_cpu_ids, sizeof(*(newinfo->chainstack)));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
 		for_each_possible_cpu(i) {
@@ -1434,6 +1436,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return -EINVAL;
 
@@ -2273,6 +2277,8 @@ static int compat_copy_ebt_replace_from_user(struct ebt_replace *repl,
 
 	memcpy(repl, &tmp, offsetof(struct ebt_replace, hook_entry));
 
+	repl->name[sizeof(repl->name) - 1] = '\0';
+
 	/* starting with hook_entry, 32 vs. 64 bit structures are different */
 	for (i = 0; i < NF_BR_NUMHOOKS; i++)
 		repl->hook_entry[i] = compat_ptr(tmp.hook_entry[i]);
@@ -2395,6 +2401,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
+	hlp.name[sizeof(hlp.name) - 1] = '\0';
+
 	/* try real handler in case userland supplied needed padding */
 	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
 		return update_counters(net, arg, len);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 3f4a17fa5713..9004e3145c11 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -814,14 +814,6 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 			container_of(rcu_head, struct netpoll_info, rcu);
 
 	skb_queue_purge(&npinfo->txq);
-
-	/* we can't call cancel_delayed_work_sync here, as we are in softirq */
-	cancel_delayed_work(&npinfo->tx_work);
-
-	/* clean after last, unfinished work */
-	__skb_queue_purge(&npinfo->txq);
-	/* now cancel it again */
-	cancel_delayed_work(&npinfo->tx_work);
 	kfree(npinfo);
 }
 
@@ -845,6 +837,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 			ops->ndo_netpoll_cleanup(np->dev);
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+		disable_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a9ad39064f3b..523aecb3c9be 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1918,6 +1918,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 #endif
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
+		ip_mc_hash_remove(in_dev, i);
 		in_dev->mc_list = i->next_rcu;
 		in_dev->mc_count--;
 		ip_mc_clear_src(i);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index c0e85cc171ae..ca1180dba1de 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1058,7 +1058,9 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &init_net.ipv4.sysctl_tcp_max_reordering,
 	},
 	{
 		.procname	= "tcp_retries1",
@@ -1293,7 +1295,8 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_max_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "tcp_dsack",
@@ -1676,6 +1679,9 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 				 */
 				table[i].mode &= ~0222;
 			}
+			if (table[i].extra2 >= (void *)&init_net.ipv4 &&
+			    table[i].extra2 < (void *)(&init_net.ipv4 + 1))
+				table[i].extra2 += (void *)net - (void *)&init_net;
 		}
 	}
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 36984e905070..69c11bfd8f2b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -270,8 +270,9 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree_sensitive(key);
 }
 
-static void tcp_ao_info_free(struct tcp_ao_info *ao)
+static void tcp_ao_info_free_rcu(struct rcu_head *head)
 {
+	struct tcp_ao_info *ao = container_of(head, struct tcp_ao_info, rcu);
 	struct tcp_ao_key *key;
 	struct hlist_node *n;
 
@@ -311,7 +312,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 
 	if (!twsk)
 		tcp_ao_sk_omem_free(sk, ao);
-	tcp_ao_info_free(ao);
+	call_rcu(&ao->rcu, tcp_ao_info_free_rcu);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6e4bb411dc04..193637a58dcc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2687,7 +2687,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	struct sk_buff *skb, *nskb, *next;
 	struct net *net = sock_net(sk);
 	int probe_size;
-	int size_needed;
+	u64 size_needed;
 	int copy, len;
 	int mss_now;
 	int interval;
@@ -2711,7 +2711,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	mss_now = tcp_current_mss(sk);
 	probe_size = tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
 				    icsk->icsk_mtup.search_low) >> 1);
-	size_needed = probe_size + (tp->reordering + 1) * tp->mss_cache;
+	size_needed = probe_size + (tp->reordering + 1) * (u64)tp->mss_cache;
 	interval = icsk->icsk_mtup.search_high - icsk->icsk_mtup.search_low;
 	/* When misfortune happens, we are reprobing actively,
 	 * and then reprobe timer has expired. We stick with current
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..7edca05dbfc9 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -418,7 +418,7 @@ find_prev_fhdr(struct sk_buff *skb, u8 *prevhdrp, int *prevhoff, int *fhoff)
 			return -1;
 		}
 		if (skb_copy_bits(skb, start, &hdr, sizeof(hdr)))
-			BUG();
+			return -1;
 		if (nexthdr == NEXTHDR_AUTH)
 			hdrlen = ipv6_authlen(&hdr);
 		else
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18cd9..3216f897a305 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1218,6 +1218,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				goto out;
 			}
 			strcpy(x->calg->alg_name, a->name);
+			x->calg->alg_key_len = 0;
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 3706b4a85a0f..955556513eeb 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1480,7 +1480,11 @@ ip_set_dump_done(struct netlink_callback *cb)
 		struct ip_set_net *inst =
 			(struct ip_set_net *)cb->args[IPSET_CB_NET];
 		ip_set_id_t index = (ip_set_id_t)cb->args[IPSET_CB_INDEX];
-		struct ip_set *set = ip_set_ref_netlink(inst, index);
+		struct ip_set *set;
+
+		rcu_read_lock();
+		set = ip_set_ref_netlink(inst, index);
+		rcu_read_unlock();
 
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
@@ -1686,7 +1690,9 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_callback *cb)
 release_refcount:
 	/* If there was an error or set is done, release set */
 	if (ret || !cb->args[IPSET_CB_ARG0]) {
+		rcu_read_lock();
 		set = ip_set_ref_netlink(inst, index);
+		rcu_read_unlock();
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
 		pr_debug("release set %s\n", set->name);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index befa7e83ee49..d429f9c9546c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3173,7 +3173,7 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 			if (l3proto && exp->tuple.src.l3num != l3proto)
 				continue;
 
-			if (!net_eq(nf_ct_net(exp->master), net))
+			if (!net_eq(nf_ct_exp_net(exp), net))
 				continue;
 
 			if (cb->args[1]) {
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 785d8c244a77..d06ce0848b68 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -345,10 +345,8 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 
 	nf_ct_refresh(flow->ct, NF_CT_DAY);
 
-	if (nf_flowtable_hw_offload(flow_table)) {
-		__set_bit(NF_FLOW_HW, &flow->flags);
+	if (nf_flowtable_hw_offload(flow_table))
 		nf_flow_offload_add(flow_table, flow);
-	}
 
 	return 0;
 }
@@ -369,7 +367,8 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
 	    test_bit(NF_FLOW_CLOSING, &flow->flags))
 		return;
 
-	nf_flow_offload_add(flow_table, flow);
+	if (test_bit(NF_FLOW_HW, &flow->flags))
+		nf_flow_offload_refresh(flow_table, flow);
 }
 EXPORT_SYMBOL_GPL(flow_offload_refresh);
 
@@ -505,8 +504,13 @@ static u32 nf_flow_table_tcp_timeout(const struct nf_conn *ct)
  */
 static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 {
-	static const u32 min_timeout = 5 * 60 * HZ;
-	u32 expires = nf_ct_expires(ct);
+	static const s32 min_timeout = 5 * 60 * HZ;
+	u32 ct_timeout = READ_ONCE(ct->timeout);
+	s32 expires;
+
+	expires = ct_timeout - nfct_time_stamp;
+	if (expires <= 0) /* already expired */
+		return;
 
 	/* normal case: large enough timeout, nothing to do. */
 	if (likely(expires >= min_timeout))
@@ -524,7 +528,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	if (nf_ct_is_confirmed(ct) &&
 	    test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
 		u8 l4proto = nf_ct_protonum(ct);
-		u32 new_timeout = true;
+		u32 new_timeout = 1;
 
 		switch (l4proto) {
 		case IPPROTO_UDP:
@@ -549,7 +553,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 		 */
 		if (new_timeout) {
 			new_timeout += nfct_time_stamp;
-			cmpxchg(&ct->timeout, expires, new_timeout);
+			cmpxchg(&ct->timeout, ct_timeout, new_timeout);
 		}
 	}
 
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 002ec15d988b..801a3dd9ceea 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1101,9 +1101,17 @@ nf_flow_offload_work_alloc(struct nf_flowtable *flowtable,
 	return offload;
 }
 
+static bool nf_flow_offload_unsupported(struct flow_offload *flow)
+{
+	if (flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.tun_num ||
+	    flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.tun_num)
+		return true;
 
-void nf_flow_offload_add(struct nf_flowtable *flowtable,
-			 struct flow_offload *flow)
+	return false;
+}
+
+void nf_flow_offload_refresh(struct nf_flowtable *flowtable,
+			     struct flow_offload *flow)
 {
 	struct flow_offload_work *offload;
 
@@ -1114,6 +1122,16 @@ void nf_flow_offload_add(struct nf_flowtable *flowtable,
 	flow_offload_queue_work(offload);
 }
 
+void nf_flow_offload_add(struct nf_flowtable *flowtable,
+			 struct flow_offload *flow)
+{
+	if (nf_flow_offload_unsupported(flow))
+		return;
+
+	set_bit(NF_FLOW_HW, &flow->flags);
+	nf_flow_offload_refresh(flowtable, flow);
+}
+
 void nf_flow_offload_del(struct nf_flowtable *flowtable,
 			 struct flow_offload *flow)
 {
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index fa3657599861..5fee61b3813c 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -676,7 +676,7 @@ __build_packet_message(struct nfnl_log_net *log,
 			goto nla_put_failure;
 
 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
-			BUG();
+			goto nla_put_failure;
 	}
 
 	nlh->nlmsg_len = inst->skb->tail - old_tail;
@@ -698,6 +698,21 @@ static const struct nf_loginfo default_loginfo = {
 	},
 };
 
+static unsigned int nfulnl_get_copy_len(const struct nf_loginfo *li,
+					const struct sk_buff *skb,
+					unsigned int copy_len)
+{
+	unsigned int len = skb->len;
+
+	if ((li->u.ulog.flags & NF_LOG_F_COPY_LEN) &&
+	    li->u.ulog.copy_len < copy_len)
+		copy_len = li->u.ulog.copy_len;
+	if (!skb_frags_readable(skb))
+		len = skb_headlen(skb);
+
+	return min(len, copy_len);
+}
+
 /* log handler for internal netfilter logging api */
 static void
 nfulnl_log_packet(struct net *net,
@@ -790,14 +805,7 @@ nfulnl_log_packet(struct net *net,
 		break;
 
 	case NFULNL_COPY_PACKET:
-		data_len = inst->copy_range;
-		if ((li->u.ulog.flags & NF_LOG_F_COPY_LEN) &&
-		    (li->u.ulog.copy_len < data_len))
-			data_len = li->u.ulog.copy_len;
-
-		if (data_len > skb->len)
-			data_len = skb->len;
-
+		data_len = nfulnl_get_copy_len(li, skb, inst->copy_range);
 		size += nla_total_size(data_len);
 		break;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index c5e29fec419b..e0cf9977887f 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -690,6 +690,17 @@ static int nfqnl_put_master_ifindex(struct sk_buff *nlskb, int attr,
 }
 #endif
 
+static unsigned int nfqnl_get_data_len(const struct sk_buff *entskb,
+				       unsigned int copy_range)
+{
+	unsigned int data_len = entskb->len;
+
+	if (!skb_frags_readable(entskb))
+		data_len = skb_headlen(entskb);
+
+	return min(data_len, copy_range);
+}
+
 static struct sk_buff *
 nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			   struct nf_queue_entry *entry,
@@ -755,10 +766,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		    nf_queue_checksum_help(entskb))
 			return NULL;
 
-		data_len = READ_ONCE(queue->copy_range);
-		if (data_len > entskb->len)
-			data_len = entskb->len;
-
+		data_len = nfqnl_get_data_len(entskb, READ_ONCE(queue->copy_range));
 		hlen = skb_zerocopy_headlen(entskb);
 		hlen = min_t(unsigned int, hlen, data_len);
 		size += sizeof(struct nlattr) + hlen;
diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
index 117d4615d668..1ae7f926b0df 100644
--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -14,8 +14,8 @@
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_u32.h>
 
-static bool u32_match_it(const struct xt_u32 *data,
-			 const struct sk_buff *skb)
+static int u32_match_it(const struct xt_u32 *data,
+			const struct sk_buff *skb)
 {
 	const struct xt_u32_test *ct;
 	unsigned int testind;
@@ -40,7 +40,8 @@ static bool u32_match_it(const struct xt_u32 *data,
 			return false;
 
 		if (skb_copy_bits(skb, pos, &n, sizeof(n)) < 0)
-			BUG();
+			return -1;
+
 		val   = ntohl(n);
 		nnums = ct->nnums;
 
@@ -68,7 +69,7 @@ static bool u32_match_it(const struct xt_u32 *data,
 
 				if (skb_copy_bits(skb, at + pos, &n,
 						    sizeof(n)) < 0)
-					BUG();
+					return -1;
 				val = ntohl(n);
 				break;
 			}
@@ -90,9 +91,14 @@ static bool u32_match_it(const struct xt_u32 *data,
 static bool u32_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_u32 *data = par->matchinfo;
-	bool ret;
+	int ret;
 
 	ret = u32_match_it(data, skb);
+	if (ret < 0) {
+		par->hotdrop = true;
+		return false;
+	}
+
 	return ret ^ data->invert;
 }
 
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..1ca4d2c03e61 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(nskb))
 			return qdisc_drop(skb, sch, to_free);
 
-		cnt = 1;
+		cnt = 0;
 		byte_len = 0;
 		orig_len = qdisc_pkt_len(skb);
 		skb_list_walk_safe(nskb, nskb, next) {
@@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				byte_len += nskb->len;
 			}
 		}
-		if (cnt > 1) {
+		if (cnt > 0) {
 			/* The caller will add the original skb stats to its
 			 * backlog, compensate this if any nskb is enqueued.
 			 */
-			--cnt;
-			byte_len -= orig_len;
+			qdisc_tree_reduce_backlog(sch, 1 - cnt,
+						  orig_len - byte_len);
 		}
-		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
 		consume_skb(skb);
-		return err;
+		return cnt > 0 ? NET_XMIT_SUCCESS : err;
 	}
 	return dualpi2_enqueue_skb(skb, sch, to_free);
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index f8a0638eb095..96594a0f8de6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -377,7 +377,7 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_recv_err(wc, &ctxt->rc_cid);
 dropped:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -1001,7 +1001,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		if (ret == -EINVAL)
 			svc_rdma_send_error(rdma_xprt, ctxt, ret);
 		svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma_xprt);
 		return ret;
 	}
 	return 0;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 402e2ceca4ff..73d17ac83911 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -313,7 +313,7 @@ static void svc_rdma_reply_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_reply_err(wc, &cc->cc_cid);
 	}
 
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -345,7 +345,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	 * some of the outgoing RPC message. Signal the loss
 	 * to the client by closing the connection.
 	 */
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -390,7 +390,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	 */
 	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /*
@@ -754,216 +754,6 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 	return xdr->len;
 }
 
-/*
- * Cap contiguous RDMA Read sink allocations at order-4.
- * Higher orders risk allocation failure under
- * __GFP_NORETRY, which would negate the benefit of the
- * contiguous fast path.
- */
-#define SVC_RDMA_CONTIG_MAX_ORDER	4
-
-/**
- * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
- * @nr_pages: number of pages needed
- * @order: on success, set to the allocation order
- *
- * Attempts a higher-order allocation, falling back to smaller orders.
- * The returned pages are split immediately so each sub-page has its
- * own refcount and can be freed independently.
- *
- * Returns a pointer to the first page on success, or NULL if even
- * order-1 allocation fails.
- */
-static struct page *
-svc_rdma_alloc_read_pages(unsigned int nr_pages, unsigned int *order)
-{
-	unsigned int o;
-	struct page *page;
-
-	o = min(get_order(nr_pages << PAGE_SHIFT),
-		SVC_RDMA_CONTIG_MAX_ORDER);
-
-	while (o >= 1) {
-		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN,
-				   o);
-		if (page) {
-			split_page(page, o);
-			*order = o;
-			return page;
-		}
-		o--;
-	}
-	return NULL;
-}
-
-/*
- * svc_rdma_fill_contig_bvec - Replace rq_pages with a contiguous allocation
- * @rqstp: RPC transaction context
- * @head: context for ongoing I/O
- * @bv: bvec entry to fill
- * @pages_left: number of data pages remaining in the segment
- * @len_left: bytes remaining in the segment
- *
- * On success, fills @bv with a bvec spanning the contiguous range and
- * advances rc_curpage/rc_page_count. Returns the byte length covered,
- * or zero if the allocation failed or would overrun rq_maxpages.
- */
-static unsigned int
-svc_rdma_fill_contig_bvec(struct svc_rqst *rqstp,
-			  struct svc_rdma_recv_ctxt *head,
-			  struct bio_vec *bv, unsigned int pages_left,
-			  unsigned int len_left)
-{
-	unsigned int order, npages, chunk_pages, chunk_len, i;
-	struct page *page;
-
-	page = svc_rdma_alloc_read_pages(pages_left, &order);
-	if (!page)
-		return 0;
-	npages = 1 << order;
-
-	if (head->rc_curpage + npages > rqstp->rq_maxpages) {
-		for (i = 0; i < npages; i++)
-			__free_page(page + i);
-		return 0;
-	}
-
-	/*
-	 * Replace rq_pages[] entries with pages from the contiguous
-	 * allocation. If npages exceeds chunk_pages, the extra pages
-	 * stay in rq_pages[] for later reuse or normal rqst teardown.
-	 */
-	for (i = 0; i < npages; i++) {
-		svc_rqst_page_release(rqstp,
-				      rqstp->rq_pages[head->rc_curpage + i]);
-		rqstp->rq_pages[head->rc_curpage + i] = page + i;
-	}
-
-	chunk_pages = min(npages, pages_left);
-	chunk_len = min_t(unsigned int, chunk_pages << PAGE_SHIFT, len_left);
-	bvec_set_page(bv, page, chunk_len, 0);
-	head->rc_page_count += chunk_pages;
-	head->rc_curpage += chunk_pages;
-	return chunk_len;
-}
-
-/*
- * svc_rdma_fill_page_bvec - Add a single rq_page to the bvec array
- * @head: context for ongoing I/O
- * @ctxt: R/W context whose bvec array is being filled
- * @cur: page to add
- * @bvec_idx: pointer to current bvec index, not advanced on merge
- * @len_left: bytes remaining in the segment
- *
- * If @cur is physically contiguous with the preceding bvec, it is
- * merged by extending that bvec's length. Otherwise a new bvec
- * entry is created. Returns the byte length covered.
- */
-static unsigned int
-svc_rdma_fill_page_bvec(struct svc_rdma_recv_ctxt *head,
-			struct svc_rdma_rw_ctxt *ctxt, struct page *cur,
-			unsigned int *bvec_idx, unsigned int len_left)
-{
-	unsigned int chunk_len = min_t(unsigned int, PAGE_SIZE, len_left);
-
-	head->rc_page_count++;
-	head->rc_curpage++;
-
-	if (*bvec_idx > 0) {
-		struct bio_vec *prev = &ctxt->rw_bvec[*bvec_idx - 1];
-
-		if (page_to_phys(prev->bv_page) + prev->bv_offset +
-		    prev->bv_len == page_to_phys(cur)) {
-			prev->bv_len += chunk_len;
-			return chunk_len;
-		}
-	}
-
-	bvec_set_page(&ctxt->rw_bvec[*bvec_idx], cur, chunk_len, 0);
-	(*bvec_idx)++;
-	return chunk_len;
-}
-
-/**
- * svc_rdma_build_read_segment_contig - Build RDMA Read WR with contiguous pages
- * @rqstp: RPC transaction context
- * @head: context for ongoing I/O
- * @segment: co-ordinates of remote memory to be read
- *
- * Greedily allocates higher-order pages to cover the segment,
- * building one bvec per contiguous chunk. Each allocation is
- * split so sub-pages have independent refcounts. When a
- * higher-order allocation fails, remaining pages are covered
- * individually, merging adjacent pages into the preceding bvec
- * when they are physically contiguous. The split sub-pages
- * replace entries in rq_pages[] so downstream cleanup is
- * unchanged.
- *
- * Returns:
- *   %0: the Read WR was constructed successfully
- *   %-ENOMEM: allocation failed
- *   %-EIO: a DMA mapping error occurred
- */
-static int svc_rdma_build_read_segment_contig(struct svc_rqst *rqstp,
-					      struct svc_rdma_recv_ctxt *head,
-					      const struct svc_rdma_segment *segment)
-{
-	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
-	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
-	unsigned int nr_data_pages, bvec_idx;
-	struct svc_rdma_rw_ctxt *ctxt;
-	unsigned int len_left;
-	int ret;
-
-	nr_data_pages = PAGE_ALIGN(segment->rs_length) >> PAGE_SHIFT;
-	if (head->rc_curpage + nr_data_pages > rqstp->rq_maxpages)
-		return -ENOMEM;
-
-	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_data_pages);
-	if (!ctxt)
-		return -ENOMEM;
-
-	bvec_idx = 0;
-	len_left = segment->rs_length;
-	while (len_left) {
-		unsigned int pages_left = PAGE_ALIGN(len_left) >> PAGE_SHIFT;
-		unsigned int chunk_len = 0;
-
-		if (pages_left >= 2)
-			chunk_len = svc_rdma_fill_contig_bvec(rqstp, head,
-							      &ctxt->rw_bvec[bvec_idx],
-							      pages_left, len_left);
-		if (chunk_len) {
-			bvec_idx++;
-		} else {
-			struct page *cur =
-				rqstp->rq_pages[head->rc_curpage];
-			chunk_len = svc_rdma_fill_page_bvec(head, ctxt, cur,
-							    &bvec_idx,
-							    len_left);
-		}
-
-		len_left -= chunk_len;
-	}
-
-	ctxt->rw_nents = bvec_idx;
-
-	head->rc_pageoff = offset_in_page(segment->rs_length);
-	if (head->rc_pageoff)
-		head->rc_curpage--;
-
-	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
-				   segment->rs_handle, segment->rs_length,
-				   DMA_FROM_DEVICE);
-	if (ret < 0)
-		return -EIO;
-	percpu_counter_inc(&svcrdma_stat_read);
-
-	list_add(&ctxt->rw_list, &cc->cc_rwctxts);
-	cc->cc_sqecount += ret;
-	return 0;
-}
-
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
  * @rqstp: RPC transaction context
@@ -990,14 +780,6 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	if (check_add_overflow(head->rc_pageoff, len, &total))
 		return -EINVAL;
 	nr_bvec = PAGE_ALIGN(total) >> PAGE_SHIFT;
-
-	if (head->rc_pageoff == 0 && nr_bvec >= 2) {
-		ret = svc_rdma_build_read_segment_contig(rqstp, head,
-							 segment);
-		if (ret != -ENOMEM)
-			return ret;
-	}
-
 	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_bvec);
 	if (!ctxt)
 		return -ENOMEM;
@@ -1343,11 +1125,6 @@ static void svc_rdma_clear_rqst_pages(struct svc_rqst *rqstp,
 {
 	unsigned int i;
 
-	/*
-	 * Move only pages containing RPC data into rc_pages[]. Pages
-	 * from a contiguous allocation that were not used for the
-	 * payload remain in rq_pages[] for subsequent reuse.
-	 */
 	for (i = 0; i < head->rc_page_count; i++) {
 		head->rc_pages[i] = rqstp->rq_pages[i];
 		rqstp->rq_pages[i] = NULL;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 8b3f0c8c14b2..88ad6bbed69b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -395,7 +395,7 @@ int svc_rdma_post_send_err(struct svcxprt_rdma *rdma,
 			   int sqecount, int ret)
 {
 	trace_svcrdma_sq_post_err(rdma, cid, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 
 	/* If even one WR was posted, a Send completion will
 	 * return the reserved SQ slots.
@@ -437,7 +437,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	else
 		trace_svcrdma_wc_send_flush(wc, &ctxt->sc_cid);
 	svc_rdma_send_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -1158,7 +1158,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	svc_rdma_send_ctxt_put(rdma, sctxt);
 drop_connection:
 	trace_svcrdma_send_err(rqstp, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 	return -ENOTCONN;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f18bc60d9f4f..246f332db2f7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -98,10 +98,27 @@ struct svc_xprt_class svc_rdma_class = {
 	.xcl_ident = XPRT_TRANSPORT_RDMA,
 };
 
+/**
+ * svc_rdma_xprt_deferred_close - Close an RDMA transport (deferred)
+ * @rdma: transport to close
+ */
+void svc_rdma_xprt_deferred_close(struct svcxprt_rdma *rdma)
+{
+	svc_xprt_deferred_close(&rdma->sc_xprt);
+
+	/* Release parked sc_sq_ticket_wait and sc_send_wait waiters.
+	 * Once XPT_CLOSE is observed each returns -ENOTCONN.
+	 */
+	wake_up_all(&rdma->sc_sq_ticket_wait);
+	wake_up_all(&rdma->sc_send_wait);
+}
+
 /* QP event handler */
 static void qp_event_handler(struct ib_event *event, void *context)
 {
 	struct svc_xprt *xprt = context;
+	struct svcxprt_rdma *rdma =
+		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
 	trace_svcrdma_qp_error(event, (struct sockaddr *)&xprt->xpt_remote);
 	switch (event->event) {
@@ -119,7 +136,7 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	case IB_EVENT_QP_ACCESS_ERR:
 	case IB_EVENT_DEVICE_FATAL:
 	default:
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma);
 		break;
 	}
 }
@@ -340,7 +357,7 @@ static int svc_rdma_cma_handler(struct rdma_cm_id *cma_id,
 		svc_xprt_enqueue(xprt);
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma);
 		break;
 	default:
 		break;
@@ -597,6 +614,15 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
 	rdma_disconnect(rdma->sc_cm_id);
+
+	/*
+	 * Most close paths go through svc_rdma_xprt_deferred_close(),
+	 * which wakes the SQ waitqueues. svc_xprt_close() reaches
+	 * detach without that helper, so wake any threads parked in
+	 * svc_rdma_sq_wait() here as well.
+	 */
+	wake_up_all(&rdma->sc_sq_ticket_wait);
+	wake_up_all(&rdma->sc_send_wait);
 }
 
 /**
diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 76a1585d3f6b..10d1ec593084 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -497,12 +497,13 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
  */
 int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr,
-			struct sk_buff_head *retrq)
+			struct sk_buff_head *retrq, bool *valid)
 {
 	struct sk_buff_head *inputq = &tipc_bc_base(net)->inputq;
 	struct tipc_gap_ack_blks *ga;
 	struct sk_buff_head xmitq;
 	int rc = 0;
+	u16 glen;
 
 	__skb_queue_head_init(&xmitq);
 
@@ -510,13 +511,18 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 	if (msg_type(hdr) != STATE_MSG) {
 		tipc_link_bc_init_rcv(l, hdr);
 	} else if (!msg_bc_ack_invalid(hdr)) {
-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
-		if (!sysctl_tipc_bc_retruni)
-			retrq = &xmitq;
-		rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
-					  msg_bc_gap(hdr), ga, &xmitq,
-					  retrq);
-		rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
+		glen = tipc_get_gap_ack_blks(&ga, l, hdr, false);
+		if (glen > msg_data_sz(hdr)) {
+			/* Malformed Gap ACK blocks; caller drops the msg */
+			*valid = false;
+		} else {
+			if (!sysctl_tipc_bc_retruni)
+				retrq = &xmitq;
+			rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
+						  msg_bc_gap(hdr), ga, &xmitq,
+						  retrq);
+			rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
+		}
 	}
 	tipc_bcast_unlock(net);
 
diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h
index 2d9352dc7b0e..55d17b5413e1 100644
--- a/net/tipc/bcast.h
+++ b/net/tipc/bcast.h
@@ -97,7 +97,7 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr);
 int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr,
-			struct sk_buff_head *retrq);
+			struct sk_buff_head *retrq, bool *valid);
 int tipc_nl_add_bc_link(struct net *net, struct tipc_nl_msg *msg,
 			struct tipc_link *bcl);
 int tipc_nl_bc_link_set(struct net *net, struct nlattr *attrs[]);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..8e4ef2630ae4 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1831,12 +1831,15 @@ static void tipc_node_mcast_rcv(struct tipc_node *n)
 }
 
 static void tipc_node_bc_sync_rcv(struct tipc_node *n, struct tipc_msg *hdr,
-				  int bearer_id, struct sk_buff_head *xmitq)
+				  int bearer_id, struct sk_buff_head *xmitq,
+				  bool *valid)
 {
 	struct tipc_link *ucl;
 	int rc;
 
-	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq);
+	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq, valid);
+	if (!*valid)
+		return;
 
 	if (rc & TIPC_LINK_DOWN_EVT) {
 		tipc_node_reset_links(n);
@@ -2140,12 +2143,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 
 	/* Ensure broadcast reception is in synch with peer's send state */
 	if (unlikely(usr == LINK_PROTOCOL)) {
+		bool valid = true;
+
 		if (unlikely(skb_linearize(skb))) {
 			tipc_node_put(n);
 			goto discard;
 		}
 		hdr = buf_msg(skb);
-		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq);
+		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq, &valid);
+		if (!valid) {
+			tipc_node_put(n);
+			goto discard;
+		}
 	} else if (unlikely(tipc_link_acked(n->bc_entry.link) != bc_ack)) {
 		tipc_bcast_ack_rcv(net, n->bc_entry.link, hdr);
 	}
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..fc97dd873974 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -150,6 +150,19 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
+        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+            // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
+            // has not been added to the VFS on this cleanup path.
+            unsafe { bindings::put_disk(gendisk) };
+            // SAFETY: `data` came from `into_foreign()` above and has not been
+            // converted back on this cleanup path.
+            drop(unsafe { T::QueueData::from_foreign(data) });
+        });
+
+        // The failure guard now owns both pieces of cleanup; the early guard
+        // must not run on this path anymore.
+        recover_data.dismiss();
+
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
@@ -172,7 +185,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        recover_data.dismiss();
+        cleanup_failure.dismiss();
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
@@ -215,6 +228,11 @@ fn drop(&mut self) {
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
 
+        // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
+        // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
+        // reference and trigger the remaining release path.
+        unsafe { bindings::put_disk(self.gendisk) };
+
         // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
         // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
         // `ForeignOwnable::from_foreign` is only called here.
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..a20bd5006f38 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1323,7 +1323,7 @@ impl<T: Driver> Registration<T> {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
 
-        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
     }
 
     /// Driver's `update_limit` callback.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..3ce21482b079 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -153,7 +153,7 @@ pub struct Bar<const SIZE: usize = 0> {
 }
 
 impl<const SIZE: usize> Bar<SIZE> {
-    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+    pub(super) fn new(pdev: &Device, num: u32, name: &'static CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -252,7 +252,7 @@ impl Device<device::Bound> {
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
@@ -261,7 +261,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 8311d91549e1..4517c1bc547a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -3,14 +3,27 @@
 //! String representations.
 
 use crate::{
-    alloc::{flags::*, AllocError, KVec},
-    error::{to_result, Result},
-    fmt::{self, Write},
-    prelude::*,
+    alloc::{
+        AllocError,
+        KVec, //
+    },
+    error::{
+        to_result,
+        Result, //
+    },
+    fmt::{
+        self,
+        Write, //
+    },
+    prelude::*, //
 };
 use core::{
     marker::PhantomData,
-    ops::{Deref, DerefMut, Index},
+    ops::{
+        Deref,
+        DerefMut,
+        Index, //
+    }, //
 };
 
 pub use crate::prelude::CStr;
diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
index f7540bcf595a..df864437cef7 100644
--- a/scripts/rustdoc_test_builder.rs
+++ b/scripts/rustdoc_test_builder.rs
@@ -28,7 +28,7 @@ fn main() {
     //
     // ```
     // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_28_0() {
-    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl ::core::fmt::Debug> {
+    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl core::fmt::Debug> {
     // ```
     //
     // It should be unlikely that doctest code matches such lines (when code is formatted properly).
@@ -47,12 +47,16 @@ fn main() {
         })
         .expect("No test function found in `rustdoc`'s output.");
 
-    // Qualify `Result` to avoid the collision with our own `Result` coming from the prelude.
+    // Replicate `rustdoc` 1.87+ behaviour [1] by fully qualifying `Result` to avoid the collision
+    // with our own `Result` coming from the prelude.
+    //
+    // [1]: https://github.com/rust-lang/rust/pull/137807
+    //
+    // TODO: Remove this when MSRV is bumped above 1.87.
     let body = body.replace(
-        &format!("{rustdoc_function_name}() -> Result<(), impl ::core::fmt::Debug> {{"),
-        &format!(
-            "{rustdoc_function_name}() -> ::core::result::Result<(), impl ::core::fmt::Debug> {{"
-        ),
+        &format!("{rustdoc_function_name}() -> Result<(), impl core::fmt::Debug> {{"),
+        // This intentionally does not use absolute paths to match `rustdoc` 1.87 behaviour.
+        &format!("{rustdoc_function_name}() -> core::result::Result<(), impl core::fmt::Debug> {{"),
     );
 
     // For tests that get generated with `Result`, like above, `rustdoc` generates an `unwrap()` on
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..7b98f5d1e2be 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_lsm.h>
 #include <uapi/linux/lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -24,6 +26,7 @@ static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
 			   &bpf_lsmid);
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 06b6bd845060..04b69b43fbf5 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -90,11 +90,12 @@ static struct landlock_details *get_current_details(void)
 		return ERR_CAST(buffer);
 
 	/*
-	 * Create the new details according to the path's length.  Do not
-	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
-	 * caller.
+	 * Create the new details according to the path's length.  Account to
+	 * the calling task's memcg, like the other Landlock per-domain
+	 * allocations, even if it may not control the related size.
 	 */
-	details = kzalloc_flex(*details, exe_path, path_size);
+	details =
+		kzalloc_flex(*details, exe_path, path_size, GFP_KERNEL_ACCOUNT);
 	if (!details)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index a9d57db0120d..35cac8f6daee 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -33,10 +33,7 @@ enum landlock_log_status {
  * Rarely accessed, mainly when logging the first domain's denial.
  *
  * The contained pointers are initialized at the domain creation time and never
- * changed again.  Contrary to most other Landlock object types, this one is
- * not allocated with GFP_KERNEL_ACCOUNT because its size may not be under the
- * caller's control (e.g. unknown exe_path) and the data is not explicitly
- * requested nor used by tasks.
+ * changed again.
  */
 struct landlock_details {
 	/**
diff --git a/security/landlock/net.c b/security/landlock/net.c
index c368649985c5..a38bdfcffc22 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -198,6 +198,7 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	audit_net.family = address->sa_family;
+	audit_net.sk = sock->sk;
 	landlock_log_denial(subject,
 			    &(struct landlock_request){
 				    .type = LANDLOCK_REQUEST_NET_ACCESS,
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index c3ebb6de4789..7bb541577a26 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -948,6 +948,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name, "Headphone Switch");
 			ldev->lineout_ctrl = ctl;
@@ -961,12 +963,16 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch");
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detected");
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fd63d219bf86..ea699491f0c3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1083,15 +1083,18 @@ static int snd_compr_task_new(struct snd_compr_stream *stream, struct snd_compr_
 	   file descriptors are allocated before fd_install() */
 	if (!task->input || !task->input->file || !task->output || !task->output->file) {
 		retval = -EINVAL;
-		goto cleanup;
+		goto free_driver_task;
 	}
 	fd_i = get_unused_fd_flags(O_WRONLY|O_CLOEXEC);
-	if (fd_i < 0)
-		goto cleanup;
+	if (fd_i < 0) {
+		retval = fd_i;
+		goto free_driver_task;
+	}
 	fd_o = get_unused_fd_flags(O_RDONLY|O_CLOEXEC);
 	if (fd_o < 0) {
+		retval = fd_o;
 		put_unused_fd(fd_i);
-		goto cleanup;
+		goto free_driver_task;
 	}
 	/* keep dmabuf reference until freed with task free ioctl */
 	get_dma_buf(task->input);
@@ -1103,6 +1106,8 @@ static int snd_compr_task_new(struct snd_compr_stream *stream, struct snd_compr_
 	list_add_tail(&task->list, &stream->runtime->tasks);
 	stream->runtime->total_tasks++;
 	return 0;
+free_driver_task:
+	stream->ops->task_free(stream, task);
 cleanup:
 	snd_compr_task_free(task);
 	return retval;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index aaf808316c30..670f6599e002 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -364,7 +364,7 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 	size = snd_seq_event_packet_size(event);
 	memcpy(&cell->ump, event, size);
 #if IS_ENABLED(CONFIG_SND_SEQ_UMP)
-	if (size < sizeof(cell->event))
+	if (size < sizeof(cell->ump))
 		cell->ump.raw.extra = 0;
 #endif
 
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 2b7f071d593b..33c9dd48b3b0 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -179,7 +179,8 @@ static void isight_packet(struct fw_iso_context *context, u32 cycle,
 	if (likely(length >= 16 &&
 		   payload->signature == cpu_to_be32(0x73676874/*"sght"*/))) {
 		count = be32_to_cpu(payload->sample_count);
-		if (likely(count <= (length - 16) / 4)) {
+		if (likely(count <= (length - 16) / 4 &&
+			   count <= MAX_FRAMES_PER_PACKET)) {
 			total = be32_to_cpu(payload->sample_total);
 			if (unlikely(total != isight->total_samples)) {
 				if (!isight->first_packet)
diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index f20d1715da62..1f4d646724ed 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -1549,6 +1549,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
+	SND_PCI_QUIRK(0x103c, 0x8595, "HP EliteDesk 800 G5 Mini", 1),
 	SND_PCI_QUIRK(0x103c, 0x83f3, "HP ProDesk 400", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
@@ -2285,6 +2286,7 @@ EXPORT_SYMBOL_NS_GPL(snd_hda_hdmi_acomp_init, "SND_HDA_CODEC_HDMI");
 enum {
 	MODEL_GENERIC,
 	MODEL_GF,
+	MODEL_LOONGSON,
 };
 
 static int generichdmi_probe(struct hda_codec *codec,
@@ -2302,6 +2304,11 @@ static int generichdmi_probe(struct hda_codec *codec,
 	if (id->driver_data == MODEL_GF)
 		codec->no_sticky_stream = 1;
 
+	if (id->driver_data == MODEL_LOONGSON) {
+		if (codec->bus && codec->bus->pci->revision == 0x2)
+			codec->eld_jack_detect = 1; /* Jack-detection by ELD */
+	}
+
 	return 0;
 }
 
@@ -2319,7 +2326,7 @@ static const struct hda_codec_ops generichdmi_codec_ops = {
 /*
  */
 static const struct hda_device_id snd_hda_id_generichdmi[] = {
-	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_GENERIC),
+	HDA_CODEC_ID_MODEL(0x00147a47, "Loongson HDMI",		MODEL_LOONGSON),
 	HDA_CODEC_ID_MODEL(0x10951390, "SiI1390 HDMI",		MODEL_GENERIC),
 	HDA_CODEC_ID_MODEL(0x10951392, "SiI1392 HDMI",		MODEL_GENERIC),
 	HDA_CODEC_ID_MODEL(0x11069f84, "VX11 HDMI/DP",		MODEL_GENERIC),
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index dcbc669842e0..1f6fdbb45fc7 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7567,6 +7567,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x51b3, "Clevo NS70AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5700, "Clevo X560WN[RST]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x6480, "Clevo V6xxAW", ALC245_FIXUP_CLEVO_NOISY_MIC),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70f2, "Clevo NH79EPY", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index acfccc848f82..64a5bd895fd1 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1325,6 +1325,43 @@ static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ct
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(cs35l41_hda_fw_ids), cs35l41_hda_fw_ids);
 }
 
+static void cs35l41_remove_controls(struct cs35l41_hda *cs35l41)
+{
+	if (!cs35l41->codec)
+		return;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->mute_override_ctl);
+	cs35l41->mute_override_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_load_ctl);
+	cs35l41->fw_load_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_type_ctl);
+	cs35l41->fw_type_ctl = NULL;
+}
+
+static int cs35l41_add_control(struct cs35l41_hda *cs35l41,
+			       struct snd_kcontrol_new *ctl,
+			       struct snd_kcontrol **kctl)
+{
+	int ret;
+
+	*kctl = snd_ctl_new1(ctl, cs35l41);
+	if (!*kctl)
+		return -ENOMEM;
+
+	ret = snd_ctl_add(cs35l41->codec->card, *kctl);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", ctl->name, ret);
+		*kctl = NULL;
+		return ret;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", ctl->name);
+
+	return 0;
+}
+
 static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 {
 	char fw_type_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -1360,32 +1397,23 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
 		  cs35l41->amp_name);
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_type_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
-
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_load_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_load_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &fw_type_ctl, &cs35l41->fw_type_ctl);
+	if (ret)
+		goto err;
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
-			ret);
-		return ret;
-	}
+	ret = cs35l41_add_control(cs35l41, &fw_load_ctl, &cs35l41->fw_load_ctl);
+	if (ret)
+		goto err;
 
-	dev_dbg(cs35l41->dev, "Added Control %s\n", mute_override_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &mute_override_ctl, &cs35l41->mute_override_ctl);
+	if (ret)
+		goto err;
 
 	return 0;
+
+err:
+	cs35l41_remove_controls(cs35l41);
+	return ret;
 }
 
 static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
@@ -1522,6 +1550,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 		memset(comp, 0, sizeof(*comp));
+
+		cs35l41_remove_controls(cs35l41);
+		cancel_work_sync(&cs35l41->fw_load_work);
+		cs35l41->codec = NULL;
 	}
 }
 
@@ -2060,6 +2092,7 @@ void cs35l41_hda_remove(struct device *dev)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+	cancel_work_sync(&cs35l41->fw_load_work);
 
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.h b/sound/hda/codecs/side-codecs/cs35l41_hda.h
index 7d003c598e93..56ec07c0bb74 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.h
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.h
@@ -57,6 +57,8 @@ enum control_bus {
 	SPI
 };
 
+struct snd_kcontrol;
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -75,6 +77,9 @@ struct cs35l41_hda {
 	int speaker_id;
 	struct mutex fw_mutex;
 	struct work_struct fw_load_work;
+	struct snd_kcontrol *fw_type_ctl;
+	struct snd_kcontrol *fw_load_ctl;
+	struct snd_kcontrol *mute_override_ctl;
 
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;
diff --git a/sound/hda/common/jack.c b/sound/hda/common/jack.c
index 98ba1c4d5ba4..e0a5cc38540b 100644
--- a/sound/hda/common/jack.c
+++ b/sound/hda/common/jack.c
@@ -58,6 +58,12 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid, int dev_id)
 				  AC_VERB_GET_PIN_SENSE, dev_id);
 	if (codec->inv_jack_detect)
 		val ^= AC_PINSENSE_PRESENCE;
+	if (codec->eld_jack_detect) {
+		if (val & AC_PINSENSE_ELDV)
+			val |= AC_PINSENSE_PRESENCE;
+		else
+			val &= ~AC_PINSENSE_PRESENCE;
+	}
 	return val;
 }
 
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index a0757e1ede46..08ccb4d80ade 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -851,6 +851,8 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control1, gus);
 	else
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.index = control_index;
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index cd73b6833639..ff4bfbf94b81 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2637,16 +2637,22 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 		}
 		if (cm->can_ac3_hw) {
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_default, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_mask, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_stream, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 280125eff362..b6dcb721fffc 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1655,6 +1655,8 @@ static int snd_es1938_mixer(struct es1938 *chip)
 	for (idx = 0; idx < ARRAY_SIZE(snd_es1938_controls); idx++) {
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(&snd_es1938_controls[idx], chip);
+		if (!kctl)
+			return -ENOMEM;
 		switch (idx) {
 			case 0:
 				chip->master_volume = kctl;
diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 1191a2686dfd..d6abff2978f3 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1891,6 +1891,8 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
 				kctl = snd_ctl_new1(&cs8415_controls[i], ice);
+				if (!kctl)
+					return -ENOMEM;
 				if (i > 1)
 					kctl->id.device = ice->pcm->device;
 				err = snd_ctl_add(ice->card, kctl);
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 1e39b985bef2..4cec56769c0f 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2346,21 +2346,29 @@ int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 	if (snd_BUG_ON(!ice->pcm_pro))
 		return -EIO;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm_pro->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 65bf48647d08..b16c84983b81 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2379,16 +2379,22 @@ static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 		return err;
 
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = ice->pcm->device;
 	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index b9a09568afc9..2ccb976e68e0 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1781,16 +1781,22 @@ int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
 	if (snd_BUG_ON(!chip->pcm_spdif))
 		return -ENXIO;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_default, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_mask, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_stream, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 5c70fdf61cc1..2db4d1332df1 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -330,7 +330,7 @@ static void snd_usb_caiaq_tks4_dispatch(struct snd_usb_caiaqdev *cdev,
 {
 	struct device *dev = caiaqdev_to_dev(cdev);
 
-	while (len) {
+	while (len >= TKS4_MSGBLOCK_SIZE) {
 		unsigned int i, block_id = (buf[0] << 8) | buf[1];
 
 		switch (block_id) {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6fbcb117555c..24cd7692bd01 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1780,8 +1780,16 @@ static void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 		/*
 		 * skip empty packets. At least M-Audio's Fast Track Ultra stops
 		 * streaming once it received a 0-byte OUT URB
+		 *
+		 * However, on devices where bytes==0 means every sync-source
+		 * packet errored (e.g. Behringer Flow 8 returning -EXDEV bursts
+		 * for entire capture URBs), an unconditional return starves the
+		 * IFB-fed OUT ring permanently. Such devices set
+		 * QUIRK_FLAG_IFB_SILENCE_ON_EMPTY to fall through and enqueue a
+		 * packet_info with size 0 packets, so playback emits silence
+		 * and the OUT ring keeps moving.
 		 */
-		if (bytes == 0)
+		if (bytes == 0 && !(ep->chip->quirk_flags & QUIRK_FLAG_IFB_SILENCE_ON_EMPTY))
 			return;
 
 		spin_lock_irqsave(&ep->lock, flags);
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1bdaa46d4fe1..06d111e687eb 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -333,6 +333,7 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
 	int index = kcontrol->private_value & 0xff;
 	unsigned int value = ucontrol->value.integer.value[0];
 	int old_value = kcontrol->private_value >> 8;
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (value > 1)
@@ -341,7 +342,11 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	kcontrol->private_value = (value << 8) | index;
 	err = snd_audigy2nx_led_update(mixer, value, index);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_audigy2nx_led_resume(struct usb_mixer_elem_list *list)
@@ -487,6 +492,7 @@ static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct usb_mixer_interface *mixer = list->mixer;
 	unsigned int value = ucontrol->value.enumerated.item[0];
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (value > 1)
@@ -497,7 +503,11 @@ static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
 
 	kcontrol->private_value = value;
 	err = snd_emu0204_ch_switch_update(mixer, value);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_emu0204_ch_switch_resume(struct usb_mixer_elem_list *list)
@@ -567,46 +577,30 @@ static bool snd_dualsense_ih_match(struct input_handler *handler,
 {
 	struct dualsense_mixer_elem_info *mei;
 	struct usb_device *snd_dev;
-	char *input_dev_path, *usb_dev_path;
-	size_t usb_dev_path_len;
-	bool match = false;
+	struct device *parent;
 
 	mei = container_of(handler, struct dualsense_mixer_elem_info, ih);
 	snd_dev = mei->info.head.mixer->chip->dev;
 
-	input_dev_path = kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
-	if (!input_dev_path) {
-		dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
-		return false;
-	}
-
-	usb_dev_path = kobject_get_path(&snd_dev->dev.kobj, GFP_KERNEL);
-	if (!usb_dev_path) {
-		dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
-		goto free_paths;
-	}
-
 	/*
 	 * Ensure the VID:PID matched input device supposedly owned by the
 	 * hid-playstation driver belongs to the actual hardware handled by
-	 * the current USB audio device, which implies input_dev_path being
-	 * a subpath of usb_dev_path.
+	 * the current USB audio device.
 	 *
 	 * This verification is necessary when there is more than one identical
 	 * controller attached to the host system.
+	 *
+	 * The input device is registered below the HID device, USB interface and
+	 * USB device, so compare the parent chain directly instead of building
+	 * kobject path strings. This avoids dereferencing kobject names while the
+	 * USB device hierarchy is being torn down during disconnect.
 	 */
-	usb_dev_path_len = strlen(usb_dev_path);
-	if (usb_dev_path_len >= strlen(input_dev_path))
-		goto free_paths;
-
-	usb_dev_path[usb_dev_path_len] = '/';
-	match = !memcmp(input_dev_path, usb_dev_path, usb_dev_path_len + 1);
-
-free_paths:
-	kfree(input_dev_path);
-	kfree(usb_dev_path);
+	for (parent = dev->dev.parent; parent; parent = parent->parent) {
+		if (parent == &snd_dev->dev)
+			return true;
+	}
 
-	return match;
+	return false;
 }
 
 static int snd_dualsense_ih_connect(struct input_handler *handler,
@@ -821,7 +815,11 @@ static int snd_xonar_u1_switch_put(struct snd_kcontrol *kcontrol,
 
 	kcontrol->private_value = new_status;
 	err = snd_xonar_u1_switch_update(list->mixer, new_status);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_status;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_xonar_u1_switch_resume(struct usb_mixer_elem_list *list)
@@ -1159,7 +1157,8 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
-	u8 oldval = (kcontrol->private_value >> 24) & 0xff;
+	unsigned long old_pval = kcontrol->private_value;
+	u8 oldval = (old_pval >> 24) & 0xff;
 	u8 newval = ucontrol->value.integer.value[0];
 	int err;
 
@@ -1169,7 +1168,11 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 	kcontrol->private_value &= ~(0xff << 24);
 	kcontrol->private_value |= (unsigned int)newval << 24;
 	err = snd_ni_update_cur_val(list);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static const struct snd_kcontrol_new snd_nativeinstruments_ta6_mixers[] = {
@@ -1324,7 +1327,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
-	unsigned int pval = list->kctl->private_value;
+	unsigned long old_pval = list->kctl->private_value;
+	unsigned int pval = old_pval;
 	int cur_val, err, new_val;
 
 	cur_val = pval >> 24;
@@ -1335,7 +1339,11 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	kctl->private_value &= ~(0xff << 24);
 	kctl->private_value |= new_val << 24;
 	err = snd_ftu_eff_switch_update(list);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kctl->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
@@ -2114,13 +2122,18 @@ static int snd_soundblaster_e1_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	unsigned char value = !!ucontrol->value.integer.value[0];
+	unsigned long old_pval = kcontrol->private_value;
 	int err;
 
 	if (kcontrol->private_value == value)
 		return 0;
 	kcontrol->private_value = value;
 	err = snd_soundblaster_e1_switch_update(list->mixer, value);
-	return err < 0 ? err : 1;
+	if (err < 0) {
+		kcontrol->private_value = old_pval;
+		return err;
+	}
+	return 1;
 }
 
 static int snd_soundblaster_e1_switch_resume(struct usb_mixer_elem_list *list)
@@ -2998,12 +3011,14 @@ static int snd_bbfpro_ctl_put(struct snd_kcontrol *kcontrol,
 	if (val == old_value)
 		return 0;
 
+	err = snd_bbfpro_ctl_update(mixer, reg, idx, val);
+	if (err < 0)
+		return err;
+
 	kcontrol->private_value = reg
 		| ((idx & SND_BBFPRO_CTL_IDX_MASK) << SND_BBFPRO_CTL_IDX_SHIFT)
 		| ((val & SND_BBFPRO_CTL_VAL_MASK) << SND_BBFPRO_CTL_VAL_SHIFT);
-
-	err = snd_bbfpro_ctl_update(mixer, reg, idx, val);
-	return err < 0 ? err : 1;
+	return 1;
 }
 
 static int snd_bbfpro_ctl_resume(struct usb_mixer_elem_list *list)
@@ -3188,11 +3203,13 @@ static int snd_bbfpro_vol_put(struct snd_kcontrol *kcontrol,
 
 	new_val = uvalue & SND_BBFPRO_MIXER_VAL_MASK;
 
+	err = snd_bbfpro_vol_update(mixer, idx, new_val);
+	if (err < 0)
+		return err;
+
 	kcontrol->private_value = idx
 		| (new_val << SND_BBFPRO_MIXER_VAL_SHIFT);
-
-	err = snd_bbfpro_vol_update(mixer, idx, new_val);
-	return err < 0 ? err : 1;
+	return 1;
 }
 
 static int snd_bbfpro_vol_resume(struct usb_mixer_elem_list *list)
@@ -4451,6 +4468,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x821b): /* Focusrite Scarlett 16i16 4th Gen */
 	case USB_ID(0x1235, 0x821c): /* Focusrite Scarlett 18i16 4th Gen */
 	case USB_ID(0x1235, 0x821d): /* Focusrite Scarlett 18i20 4th Gen */
+	case USB_ID(0x1235, 0x821e): /* Focusrite ISA C8X */
 		err = snd_fcp_init(mixer);
 		break;
 
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 1bb01e827654..673eb8d8724d 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -680,7 +680,9 @@ static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
 	val = ucontrol->value.integer.value[0];
 	val = val + opt->start;
 	if (val != oval) {
-		snd_usb_set_cur_mix_value(elem, 0, 0, val);
+		err = snd_usb_set_cur_mix_value(elem, 0, 0, val);
+		if (err < 0)
+			return err;
 		return 1;
 	}
 	return 0;
diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 8a02964e5d7b..ebff185cbd2c 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -224,14 +224,14 @@ static int snd_us16x08_route_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(route_msg));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set routing, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_master_info(struct snd_kcontrol *kcontrol,
@@ -283,14 +283,14 @@ static int snd_us16x08_master_put(struct snd_kcontrol *kcontrol,
 	buf[5] = index + 1;
 	err = snd_us16x08_send_urb(chip, buf, sizeof(mix_msg_out));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set master, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
@@ -324,14 +324,14 @@ static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 		break;
 	}
 
-	if (err > 0) {
-		elem->cached |= 1;
-		elem->cache_val[0] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set bus parameter, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1;
+	elem->cache_val[0] = val;
+	return 1;
 }
 
 static int snd_us16x08_bus_get(struct snd_kcontrol *kcontrol,
@@ -392,14 +392,14 @@ static int snd_us16x08_channel_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(mix_msg_in));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set channel, err:%d\n", err);
+		return err;
 	}
 
-	return err > 0 ? 1 : 0;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
+	return 1;
 }
 
 static int snd_us16x08_mix_info(struct snd_kcontrol *kcontrol,
@@ -435,6 +435,7 @@ static int snd_us16x08_comp_put(struct snd_kcontrol *kcontrol,
 	int index = ucontrol->id.index;
 	char buf[sizeof(comp_msg)];
 	int val_idx, val;
+	int threshold, ratio, attack, release, gain, switch_on;
 	int err;
 
 	val = ucontrol->value.integer.value[0];
@@ -447,36 +448,61 @@ static int snd_us16x08_comp_put(struct snd_kcontrol *kcontrol,
 	/* new control value incl. bias*/
 	val_idx = elem->head.id - SND_US16X08_ID_COMP_BASE;
 
-	store->val[val_idx][index] = ucontrol->value.integer.value[0];
+	threshold = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD)]
+		[index];
+	ratio = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO)][index];
+	attack = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK)][index];
+	release = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE)]
+		[index];
+	gain = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN)][index];
+	switch_on = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH)]
+		[index];
+
+	switch (val_idx) {
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD):
+		threshold = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO):
+		ratio = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK):
+		attack = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE):
+		release = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN):
+		gain = val;
+		break;
+	case COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH):
+		switch_on = val;
+		break;
+	}
 
 	/* prepare compressor URB message from template  */
 	memcpy(buf, comp_msg, sizeof(comp_msg));
 
 	/* place comp values in message buffer watch bias! */
-	buf[8] = store->val[
-		COMP_STORE_IDX(SND_US16X08_ID_COMP_THRESHOLD)][index]
-		- SND_US16X08_COMP_THRESHOLD_BIAS;
-	buf[11] = ratio_map[store->val[
-		COMP_STORE_IDX(SND_US16X08_ID_COMP_RATIO)][index]];
-	buf[14] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_ATTACK)][index]
-		+ SND_US16X08_COMP_ATTACK_BIAS;
-	buf[17] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_RELEASE)][index]
-		+ SND_US16X08_COMP_RELEASE_BIAS;
-	buf[20] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_GAIN)][index];
-	buf[26] = store->val[COMP_STORE_IDX(SND_US16X08_ID_COMP_SWITCH)][index];
+	buf[8] = threshold - SND_US16X08_COMP_THRESHOLD_BIAS;
+	buf[11] = ratio_map[ratio];
+	buf[14] = attack + SND_US16X08_COMP_ATTACK_BIAS;
+	buf[17] = release + SND_US16X08_COMP_RELEASE_BIAS;
+	buf[20] = gain;
+	buf[26] = switch_on;
 
 	/* place channel selector in message buffer */
 	buf[5] = index + 1;
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(comp_msg));
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set compressor, err:%d\n", err);
+		return err;
 	}
 
+	store->val[val_idx][index] = val;
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 
@@ -529,13 +555,13 @@ static int snd_us16x08_eqswitch_put(struct snd_kcontrol *kcontrol,
 		msleep(15);
 	}
 
-	if (err > 0) {
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set eq switch, err:%d\n", err);
+		return err;
 	}
 
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 
@@ -578,11 +604,10 @@ static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 	/* copy URB buffer from EQ template */
 	memcpy(buf, eqs_msq, sizeof(eqs_msq));
 
-	store->val[b_idx][p_idx][index] = val;
-	buf[20] = store->val[b_idx][3][index];
-	buf[17] = store->val[b_idx][2][index];
-	buf[14] = store->val[b_idx][1][index];
-	buf[11] = store->val[b_idx][0][index];
+	buf[20] = p_idx == 3 ? val : store->val[b_idx][3][index];
+	buf[17] = p_idx == 2 ? val : store->val[b_idx][2][index];
+	buf[14] = p_idx == 1 ? val : store->val[b_idx][1][index];
+	buf[11] = p_idx == 0 ? val : store->val[b_idx][0][index];
 
 	/* place channel index in URB buffer */
 	buf[5] = index + 1;
@@ -592,14 +617,15 @@ static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 
 	err = snd_us16x08_send_urb(chip, buf, sizeof(eqs_msq));
 
-	if (err > 0) {
-		/* store new value in EQ band cache */
-		elem->cached |= 1 << index;
-		elem->cache_val[index] = val;
-	} else {
+	if (err < 0) {
 		usb_audio_dbg(chip, "Failed to set eq param, err:%d\n", err);
+		return err;
 	}
 
+	store->val[b_idx][p_idx][index] = val;
+	/* store new value in EQ band cache */
+	elem->cached |= 1 << index;
+	elem->cache_val[index] = val;
 	return 1;
 }
 
@@ -1418,4 +1444,3 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 
 	return 0;
 }
-
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f4e885f96e83..ed66e2af9514 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2365,6 +2365,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x1397, 0x0509, /* Behringer UMC404HD */
 		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x1397, 0x050c, /* Behringer Flow 8 */
+		   QUIRK_FLAG_IFB_SILENCE_ON_EMPTY),
 	DEVICE_FLG(0x13e5, 0x0001, /* Serato Phono */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x152a, 0x880a, /* NeuralDSP Quad Cortex */
@@ -2606,6 +2608,7 @@ static const char *const snd_usb_audio_quirk_flag_names[] = {
 	QUIRK_STRING_ENTRY(SKIP_IFACE_SETUP),
 	QUIRK_STRING_ENTRY(MIXER_PLAYBACK_LINEAR_VOL),
 	QUIRK_STRING_ENTRY(MIXER_CAPTURE_LINEAR_VOL),
+	QUIRK_STRING_ENTRY(IFB_SILENCE_ON_EMPTY),
 	NULL
 };
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 58fd07f8c3c9..9afcad8f143a 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -236,6 +236,12 @@ extern bool snd_usb_skip_validation;
  * QUIRK_FLAG_MIXER_CAPTURE_LINEAR_VOL
  *  Similar to QUIRK_FLAG_MIXER_PLAYBACK_LINEAR_VOL, but for capture streams.
  *  Overrides QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
+ * QUIRK_FLAG_IFB_SILENCE_ON_EMPTY
+ *  In implicit feedback mode, when an entire capture URB returns with
+ *  all iso_frame_desc[i].status != 0 (bytes==0), do not silently return
+ *  from snd_usb_handle_sync_urb. Instead fall through and enqueue a
+ *  packet_info containing only size-0 packets, so the OUT ring keeps
+ *  moving (emits silence). Needed by Behringer Flow 8 (1397:050c).
  */
 
 enum {
@@ -268,6 +274,7 @@ enum {
 	QUIRK_TYPE_SKIP_IFACE_SETUP		= 26,
 	QUIRK_TYPE_MIXER_PLAYBACK_LINEAR_VOL	= 27,
 	QUIRK_TYPE_MIXER_CAPTURE_LINEAR_VOL	= 28,
+	QUIRK_TYPE_IFB_SILENCE_ON_EMPTY		= 29,
 /* Please also edit snd_usb_audio_quirk_flag_names */
 };
 
@@ -302,5 +309,6 @@ enum {
 #define QUIRK_FLAG_SKIP_IFACE_SETUP		QUIRK_FLAG(SKIP_IFACE_SETUP)
 #define QUIRK_FLAG_MIXER_PLAYBACK_LINEAR_VOL	QUIRK_FLAG(MIXER_PLAYBACK_LINEAR_VOL)
 #define QUIRK_FLAG_MIXER_CAPTURE_LINEAR_VOL	QUIRK_FLAG(MIXER_CAPTURE_LINEAR_VOL)
+#define QUIRK_FLAG_IFB_SILENCE_ON_EMPTY		QUIRK_FLAG(IFB_SILENCE_ON_EMPTY)
 
 #endif /* __USBAUDIO_H */
diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 94553b61013c..58ef23146f20 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -585,19 +585,24 @@ static void tascam_disconnect(struct usb_interface *intf)
 		return;
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
-		/* Ensure all deferred work is complete before freeing resources */
 		snd_card_disconnect(tascam->card);
-		cancel_work_sync(&tascam->stop_work);
-		cancel_work_sync(&tascam->capture_work);
-		cancel_work_sync(&tascam->midi_in_work);
-		cancel_work_sync(&tascam->midi_out_work);
-		cancel_work_sync(&tascam->stop_pcm_work);
 
+		/*
+		 * Kill the URBs before cancelling the work, so a late URB
+		 * completion cannot re-arm a work that then runs after
+		 * snd_card_free().
+		 */
 		usb_kill_anchored_urbs(&tascam->playback_anchor);
 		usb_kill_anchored_urbs(&tascam->capture_anchor);
 		usb_kill_anchored_urbs(&tascam->feedback_anchor);
 		usb_kill_anchored_urbs(&tascam->midi_in_anchor);
 		usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+
+		cancel_work_sync(&tascam->stop_work);
+		cancel_work_sync(&tascam->capture_work);
+		cancel_work_sync(&tascam->midi_in_work);
+		cancel_work_sync(&tascam->midi_out_work);
+		cancel_work_sync(&tascam->stop_pcm_work);
 		timer_delete_sync(&tascam->error_timer);
 		tascam_free_urbs(tascam);
 		snd_card_free(tascam->card);
diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mkii_capture.c
index af120bf62173..fa01da98151a 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -302,7 +302,6 @@ void capture_urb_complete(struct urb *urb)
 	}
 
 	usb_get_urb(urb);
-	usb_anchor_urb(urb, &tascam->capture_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_err_ratelimited(tascam->card->dev,
@@ -312,6 +311,7 @@ void capture_urb_complete(struct urb *urb)
 		usb_put_urb(urb);
 		atomic_dec(
 			&tascam->active_urbs); /* Decrement on failed resubmission */
+		return;
 	}
 out:
 	usb_put_urb(urb);
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index ffb903d56297..45f7b6a5b308 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -18,6 +18,21 @@ static const snd_ctl_elem_type_t g_v2a_type_map[] = {
 	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
 };
 
+/* Map for converting VirtIO types to maximum value counts. */
+static const unsigned int g_v2a_count_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer64),
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.enumerated),
+	[VIRTIO_SND_CTL_TYPE_BYTES] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.bytes),
+	[VIRTIO_SND_CTL_TYPE_IEC958] = 1
+};
+
 /* Map for converting VirtIO access rights to ALSA access rights. */
 static const unsigned int g_v2a_access_map[] = {
 	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -36,6 +51,37 @@ static const unsigned int g_v2a_mask_map[] = {
 	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
 };
 
+static int virtsnd_kctl_validate_info(struct virtio_snd *snd, u32 cid,
+				      struct virtio_snd_ctl_info *kinfo)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+
+	if (type >= ARRAY_SIZE(g_v2a_type_map)) {
+		dev_err(&vdev->dev, "control #%u: unknown type %u\n",
+			cid, type);
+		return -EINVAL;
+	}
+
+	if (count > g_v2a_count_map[type] ||
+	    (type == VIRTIO_SND_CTL_TYPE_IEC958 && count != 1)) {
+		dev_err(&vdev->dev, "control #%u: invalid count %u for type %u\n",
+			cid, count, type);
+		return -EINVAL;
+	}
+
+	if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED &&
+	    !le32_to_cpu(kinfo->value.enumerated.items)) {
+		dev_err(&vdev->dev,
+			"control #%u: no items for enumerated control\n",
+			cid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * virtsnd_kctl_info() - Returns information about the control.
  * @kcontrol: ALSA control element.
@@ -385,6 +431,10 @@ int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
 		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
 		unsigned int type = le32_to_cpu(kinfo->type);
 
+		rc = virtsnd_kctl_validate_info(snd, i, kinfo);
+		if (rc)
+			return rc;
+
 		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
 			rc = virtsnd_kctl_get_enum_items(snd, i);
 			if (rc)
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index eb9cc8131905..be3893de40a5 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -77,7 +77,8 @@ static const struct virtsnd_v2a_rate g_v2a_rate_map[] = {
 	[VIRTIO_SND_PCM_RATE_88200] = { SNDRV_PCM_RATE_88200, 88200 },
 	[VIRTIO_SND_PCM_RATE_96000] = { SNDRV_PCM_RATE_96000, 96000 },
 	[VIRTIO_SND_PCM_RATE_176400] = { SNDRV_PCM_RATE_176400, 176400 },
-	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 }
+	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 },
+	[VIRTIO_SND_PCM_RATE_384000] = { SNDRV_PCM_RATE_384000, 384000 }
 };
 
 /**
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 6297a9c61e70..1105e7ff3523 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -90,7 +90,8 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 	{ 88200, VIRTIO_SND_PCM_RATE_88200 },
 	{ 96000, VIRTIO_SND_PCM_RATE_96000 },
 	{ 176400, VIRTIO_SND_PCM_RATE_176400 },
-	{ 192000, VIRTIO_SND_PCM_RATE_192000 }
+	{ 192000, VIRTIO_SND_PCM_RATE_192000 },
+	{ 384000, VIRTIO_SND_PCM_RATE_384000 }
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index 54c7265ab52d..583bb699404e 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -33,7 +33,7 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
-	unsigned long partial, objects, slabs, objects_partial, objects_total;
+	unsigned long partial, objects, slabs, objects_partial, total_objects;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
 	unsigned long free_frozen, free_add_partial, free_remove_partial;
@@ -798,7 +798,7 @@ static void slab_debug(struct slabinfo *s)
 			fprintf(stderr, "%s can only enable trace for one slab at a time\n", s->name);
 	}
 	if (!tracing && s->trace)
-		set_obj(s, "trace", 1);
+		set_obj(s, "trace", 0);
 }
 
 static void totals(void)
@@ -1263,7 +1263,7 @@ static void read_slab_dir(void)
 			slab->object_size = get_obj("object_size");
 			slab->objects = get_obj("objects");
 			slab->objects_partial = get_obj("objects_partial");
-			slab->objects_total = get_obj("objects_total");
+			slab->total_objects = get_obj("total_objects");
 			slab->objs_per_slab = get_obj("objs_per_slab");
 			slab->order = get_obj("order");
 			slab->partial = get_obj("partial");
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index d075904dccce..e1b99b8f55eb 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -9,6 +9,22 @@
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
 
+#ifndef F_GET_RW_HINT
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#endif
+
+#ifndef F_SET_RW_HINT
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+#endif
+
+#ifndef F_GET_FILE_RW_HINT
+#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
+#endif
+
+#ifndef F_SET_FILE_RW_HINT
+#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+#endif
+
 static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size, bool show_prefix)
 {
 	return val ? scnprintf(bf, size, "%s", "0") :
diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 834005b2b0f0..f45fdef35681 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -45,17 +45,25 @@ struct audit_message {
 	};
 };
 
-static const struct timeval audit_tv_dom_drop = {
+static const struct timeval audit_tv_default = {
 	/*
-	 * Because domain deallocation is tied to asynchronous credential
-	 * freeing, receiving such event may take some time.  In practice,
-	 * on a small VM, it should not exceed 100k usec, but let's wait up
-	 * to 1 second to be safe.
+	 * Default socket timeout for audit_match_record() callers that expect a
+	 * record to arrive.  Asynchronous kauditd delivery can exceed 1 usec
+	 * under heavy debug configs (KASAN, lockdep), where kauditd_thread
+	 * scheduling between audit_log_end() and netlink_unicast() takes longer
+	 * than the previous 1 usec timeout. 1 second is a generous ceiling: on
+	 * the happy path, kauditd delivers within dozens of usec.
 	 */
 	.tv_sec = 1,
 };
 
-static const struct timeval audit_tv_default = {
+static const struct timeval audit_tv_fast = {
+	/*
+	 * Fast timeout for paths that expect no record (audit_init() drain,
+	 * audit_count_records(), probes).  Causes audit_recv() to return
+	 * -EAGAIN once the socket buffer is empty, naturally terminating the
+	 * read loop.
+	 */
 	.tv_usec = 1,
 };
 
@@ -334,8 +342,13 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
  * Matches a domain deallocation record.  When expected_domain_id is non-zero,
  * the pattern includes the specific domain ID so that stale deallocation
  * records from a previous test (with a different domain ID) are skipped by
- * audit_match_record(), and the socket timeout is temporarily increased to
- * audit_tv_dom_drop to wait for the asynchronous kworker deallocation.
+ * audit_match_record(), waiting for the asynchronous kworker deallocation with
+ * the default patient timeout.
+ *
+ * When expected_domain_id is zero, the caller is probing for any dealloc record
+ * that may or may not arrive.  Temporarily lowers the socket timeout to
+ * audit_tv_fast for this probe so it returns promptly when no record is
+ * pending; restores audit_tv_default after.
  */
 static int __maybe_unused
 matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
@@ -361,16 +374,21 @@ matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
 	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
-			   &audit_tv_dom_drop, sizeof(audit_tv_dom_drop));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_fast, sizeof(audit_tv_fast)))
+			return -errno;
+	}
 
 	err = audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
 				 domain_id);
 
-	if (expected_domain_id)
-		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			   sizeof(audit_tv_default));
+	if (!expected_domain_id) {
+		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
+			       &audit_tv_default, sizeof(audit_tv_default)) &&
+		    !err)
+			err = -errno;
+	}
 
 	return err;
 }
@@ -381,30 +399,46 @@ struct audit_records {
 };
 
 /*
- * WARNING: Do not assert records.domain == 0 without a preceding
- * audit_match_record() call.  Domain deallocation records are emitted
- * asynchronously from kworker threads and can arrive after the drain in
- * audit_init(), corrupting the domain count.  A preceding audit_match_record()
- * call consumes stale records while scanning, making the assertion safe in
- * practice because stale deallocation records arrive before the expected access
- * records.
+ * Counts remaining audit records by type, skipping domain deallocation records.
+ * Deallocation records are emitted asynchronously from kworker threads after a
+ * previous test's child has exited, so they can arrive after the drain in
+ * audit_init() and after the preceding audit_match_record() call.  Allocation
+ * records are emitted synchronously during landlock_log_denial() in the current
+ * test's syscall context, so only those are counted in records->domain.
+ *
+ * Temporarily lowers SO_RCVTIMEO to audit_tv_fast for the read loop: this is a
+ * "no record expected" path that should terminate on the first -EAGAIN.  The
+ * default patient timeout is restored on exit for subsequent
+ * audit_match_record() callers.
  */
 static int audit_count_records(int audit_fd, struct audit_records *records)
 {
+	static const char dealloc_pattern[] = REGEX_LANDLOCK_PREFIX
+		" status=deallocated ";
 	struct audit_message msg;
-	int err;
+	regex_t dealloc_re;
+	int ret, err = 0;
+
+	ret = regcomp(&dealloc_re, dealloc_pattern, 0);
+	if (ret)
+		return -ENOMEM;
 
 	records->access = 0;
 	records->domain = 0;
 
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+		       sizeof(audit_tv_fast))) {
+		err = -errno;
+		goto out;
+	}
+
 	do {
 		memset(&msg, 0, sizeof(msg));
 		err = audit_recv(audit_fd, &msg);
 		if (err) {
 			if (err == -EAGAIN)
-				return 0;
-			else
-				return err;
+				err = 0;
+			break;
 		}
 
 		switch (msg.header.nlmsg_type) {
@@ -412,12 +446,24 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
 			records->access++;
 			break;
 		case AUDIT_LANDLOCK_DOMAIN:
-			records->domain++;
+			ret = regexec(&dealloc_re, msg.data, 0, NULL, 0);
+			if (ret == REG_NOMATCH) {
+				records->domain++;
+			} else if (ret != 0) {
+				err = -EIO;
+				goto out;
+			}
 			break;
 		}
 	} while (true);
 
-	return 0;
+out:
+	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+		       sizeof(audit_tv_default)) &&
+	    !err)
+		err = -errno;
+	regfree(&dealloc_re);
+	return err;
 }
 
 static int audit_init(void)
@@ -436,9 +482,9 @@ static int audit_init(void)
 	if (err)
 		goto err_close;
 
-	/* Sets a timeout for negative tests. */
-	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
-			 sizeof(audit_tv_default));
+	/* Uses the fast timeout to drain stale records below. */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
+			 sizeof(audit_tv_fast));
 	if (err) {
 		err = -errno;
 		goto err_close;
@@ -454,6 +500,19 @@ static int audit_init(void)
 	while (audit_recv(fd, NULL) == 0)
 		;
 
+	/*
+	 * Restores the default timeout for audit_match_record() callers that
+	 * expect a record to arrive.  Paths that expect no record restore the
+	 * fast timeout locally (audit_count_records(), the expected_domain_id
+	 * == 0 probe in matches_log_domain_deallocated()).
+	 */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
+			 sizeof(audit_tv_default));
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
+
 	return fd;
 
 err_close:
@@ -494,10 +553,9 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 {
 	struct audit_filter new_filter;
+	int err = 0;
 
 	if (audit_fd < 0 || !filter) {
-		int err;
-
 		/*
 		 * Simulates audit_init_with_exe_filter() when called from
 		 * FIXTURE_TEARDOWN_PARENT().
@@ -508,23 +566,19 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err) {
-			close(audit_fd);
-			return err;
-		}
+		if (err)
+			goto err_close;
 	}
 
 	/* Filters might not be in place. */
 	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
 	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
 
-	/*
-	 * Because audit_cleanup() might not be called by the test auditd
-	 * process, it might not be possible to explicitly set it.  Anyway,
-	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
-	 * process will exit.
-	 */
-	return close(audit_fd);
+	err = audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
+
+err_close:
+	close(audit_fd);
+	return err;
 }
 
 static int audit_init_with_exe_filter(struct audit_filter *filter)
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 93ae5bd0dcce..bd9f207b36e4 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -730,6 +730,7 @@ TEST_F(audit_flags, signal)
 		} else {
 			EXPECT_EQ(1, records.access);
 		}
+		EXPECT_EQ(0, records.domain);
 
 		/* Updates filter rules to match the drop record. */
 		set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -849,10 +850,8 @@ FIXTURE_SETUP(audit_exec)
 FIXTURE_TEARDOWN(audit_exec)
 {
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
-	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter,
-				      AUDIT_DEL_RULE));
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
 	clear_cap(_metadata, CAP_AUDIT_CONTROL);
-	EXPECT_EQ(0, close(self->audit_fd));
 }
 
 TEST_F(audit_exec, signal_and_open)
@@ -917,6 +916,7 @@ TEST_F(audit_exec, signal_and_open)
 	/* Tests that there was no denial until now. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	/*
 	 * Wait for the child to do a first denied action by layer1 and
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4c528154ea92..0c256e7c8675 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2026,4 +2026,66 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, close(sock_fd));
 }
 
+static int matches_log_tcp_bound(int audit_fd, const char *const addr,
+				 __u16 lport, __u16 dport)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=net\\.connect_tcp laddr=%s lport=%u daddr=%s dest=%u$";
+	/* Slack for two addresses and two port numbers. */
+	char log_match[sizeof(log_template) + 40];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
+				 addr, lport, addr, dport);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+/*
+ * After a bind() to an allowed port, a denied connect must report laddr/lport
+ * from the bound socket (made available through audit_net.sk) in addition to
+ * the connect sockaddr's daddr/dest.
+ */
+TEST_F(audit, connect_tcp_bound)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	const struct landlock_net_port_attr rule_bind = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = self->srv0.port,
+	};
+	struct service_fixture srv_remote;
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	/* Uses a second port as the denied connect target. */
+	ASSERT_EQ(0, set_service(&srv_remote, variant->prot, 1));
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &rule_bind, 0));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(0, bind_variant(sock_fd, &self->srv0));
+	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &srv_remote));
+	EXPECT_EQ(0, matches_log_tcp_bound(self->audit_fd, variant->addr,
+					   self->srv0.port, srv_remote.port));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 1b6c8b53bf33..4f64c90583cd 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -342,6 +342,7 @@ TEST_F(audit, trace)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	yama_ptrace_scope = get_yama_ptrace_scope();
 	ASSERT_LE(0, yama_ptrace_scope);
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index c47491d2d1c1..72f97648d4a7 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -312,6 +312,7 @@ TEST_F(scoped_audit, connect_to_child)
 	/* Makes sure there is no superfluous logged records. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
 
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 37c808fbe1e9..90268d86684f 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -386,4 +386,46 @@ TEST_F(liveupdate_device, prevent_double_preservation)
 	ASSERT_EQ(close(session_fd2), 0);
 }
 
+/*
+ * Test Case: Create Session with No Null Termination
+ *
+ * Verifies that filling the entire 64-byte name field with non-null characters
+ * (no '\0' terminator) is rejected by the kernel with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_no_null_termination)
+{
+	struct liveupdate_ioctl_create_session args = {};
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	/* Fill entire name field with 'X', no null terminator */
+	args.size = sizeof(args);
+	memset(args.name, 'X', sizeof(args.name));
+
+	EXPECT_LT(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test Case: Create Session with Empty Name
+ *
+ * Verifies that creating a session with an empty string name fails
+ * with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_empty_name)
+{
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "");
+	EXPECT_EQ(session_fd, -EINVAL);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
index 44940f75c461..5f74827a714d 100644
--- a/tools/testing/selftests/mm/droppable.c
+++ b/tools/testing/selftests/mm/droppable.c
@@ -17,10 +17,10 @@
 
 int main(int argc, char *argv[])
 {
-	size_t alloc_size = 134217728;
-	size_t page_size = getpagesize();
+	const size_t alloc_size = 2 * 1024 * 1024;
+	int retry_count = 10;
+	bool dropped;
 	void *alloc;
-	pid_t child;
 
 	ksft_print_header();
 	ksft_set_plan(1);
@@ -28,26 +28,32 @@ int main(int argc, char *argv[])
 	alloc = mmap(0, alloc_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
 	assert(alloc != MAP_FAILED);
 	memset(alloc, 'A', alloc_size);
-	for (size_t i = 0; i < alloc_size; i += page_size)
-		assert(*(uint8_t *)(alloc + i));
-
-	child = fork();
-	assert(child >= 0);
-	if (!child) {
-		for (;;)
-			*(char *)malloc(page_size) = 'B';
-	}
 
-	for (bool done = false; !done;) {
-		for (size_t i = 0; i < alloc_size; i += page_size) {
-			if (!*(uint8_t *)(alloc + i)) {
-				done = true;
-				break;
+	while (retry_count--) {
+		if (madvise(alloc, alloc_size, MADV_PAGEOUT)) {
+			if (errno == EINVAL) {
+				ksft_test_result_skip("madvise(MADV_PAGEOUT) not supported\n");
+				exit(KSFT_SKIP);
 			}
+			ksft_test_result_fail("madvise(MADV_PAGEOUT) error: %s\n", strerror(errno));
+			exit(KSFT_FAIL);
 		}
+
+		dropped = memchr(alloc, 'A', alloc_size) == NULL;
+
+		/*
+		 * Speculative reference can temporarily prevent some
+		 * pages from getting dropped. So sleep and retry.
+		 *
+		 * If a page is not droppable for 10s, something
+		 * is seriously messed up and we want to fail.
+		 */
+		if (dropped)
+			break;
+		sleep(1);
 	}
-	kill(child, SIGTERM);
 
-	ksft_test_result_pass("MAP_DROPPABLE: PASS\n");
-	exit(KSFT_PASS);
+	ksft_test_result(dropped, "madvise(MADV_PAGEOUT) behavior\n");
+
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/mm/ksft_process_madv.sh b/tools/testing/selftests/mm/ksft_process_madv.sh
index 2c3137ae8bc8..edad2d2d888f 100755
--- a/tools/testing/selftests/mm/ksft_process_madv.sh
+++ b/tools/testing/selftests/mm/ksft_process_madv.sh
@@ -1,4 +1,4 @@
 #!/bin/sh -e
 # SPDX-License-Identifier: GPL-2.0
 
-./run_vmtests.sh -t mmap
+./run_vmtests.sh -t process_madv
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 7f9428d6062c..0222a3dda029 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1366,7 +1366,7 @@ void *thread_proc(void *mem)
 			ksft_exit_fail_msg("pthread_barrier_wait\n");
 
 		for (i = 0; i < access_per_thread; ++i)
-			__atomic_add_fetch(m + i * (0x1000 / sizeof(*m)), 1, __ATOMIC_SEQ_CST);
+			__atomic_add_fetch(m + i * (page_size / sizeof(*m)), 1, __ATOMIC_SEQ_CST);
 
 		ret = pthread_barrier_wait(&end_barrier);
 		if (ret && ret != PTHREAD_BARRIER_SERIAL_THREAD)
@@ -1401,15 +1401,15 @@ static void transact_test(int page_size)
 	if (pthread_barrier_init(&end_barrier, NULL, nthreads + 1))
 		ksft_exit_fail_msg("pthread_barrier_init\n");
 
-	mem = mmap(NULL, 0x1000 * nthreads * pages_per_thread, PROT_READ | PROT_WRITE,
+	mem = mmap(NULL, page_size * nthreads * pages_per_thread, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (mem == MAP_FAILED)
 		ksft_exit_fail_msg("Error mmap %s.\n", strerror(errno));
 
-	wp_init(mem, 0x1000 * nthreads * pages_per_thread);
-	wp_addr_range(mem, 0x1000 * nthreads * pages_per_thread);
+	wp_init(mem, page_size * nthreads * pages_per_thread);
+	wp_addr_range(mem, page_size * nthreads * pages_per_thread);
 
-	memset(mem, 0, 0x1000 * nthreads * pages_per_thread);
+	memset(mem, 0, page_size * nthreads * pages_per_thread);
 
 	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
 	ksft_test_result(count > 0, "%s count %u\n", __func__, count);
@@ -1418,7 +1418,7 @@ static void transact_test(int page_size)
 
 	finish = 0;
 	for (i = 0; i < nthreads; ++i)
-		pthread_create(&th, NULL, thread_proc, mem + 0x1000 * i * pages_per_thread);
+		pthread_create(&th, NULL, thread_proc, mem + page_size * i * pages_per_thread);
 
 	extra_pages = 0;
 	for (i = 0; i < iter_count; ++i) {
diff --git a/tools/usb/usbip/libsrc/usbip_common.c b/tools/usb/usbip/libsrc/usbip_common.c
index b8d7d480595a..f4734f552d31 100644
--- a/tools/usb/usbip/libsrc/usbip_common.c
+++ b/tools/usb/usbip/libsrc/usbip_common.c
@@ -29,6 +29,8 @@ static const struct speed_string speed_strings[] = {
 	{ USB_SPEED_HIGH, "480", "High Speed(480Mbps)" },
 	{ USB_SPEED_WIRELESS, "53.3-480", "Wireless"},
 	{ USB_SPEED_SUPER, "5000", "Super Speed(5000Mbps)" },
+	{ USB_SPEED_SUPER_PLUS, "10000", "Super Speed Plus(10000Mbps)" },
+	{ USB_SPEED_SUPER_PLUS, "20000", "Super Speed Plus(20000Mbps)" },
 	{ 0, NULL, NULL }
 };
 
diff --git a/tools/usb/usbip/libsrc/usbip_device_driver.c b/tools/usb/usbip/libsrc/usbip_device_driver.c
index 1dfbb76ab26c..c9b3619d86f3 100644
--- a/tools/usb/usbip/libsrc/usbip_device_driver.c
+++ b/tools/usb/usbip/libsrc/usbip_device_driver.c
@@ -57,6 +57,10 @@ static struct {
 		.speed = USB_SPEED_SUPER,
 		.name = "super-speed",
 	},
+	{
+		.speed = USB_SPEED_SUPER_PLUS,
+		.name = "super-speed-plus",
+	},
 };
 
 static
diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index 8159fd98680b..4ca3783ee5b7 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -338,6 +338,7 @@ int usbip_vhci_get_free_port(uint32_t speed)
 
 		switch (speed) {
 		case	USB_SPEED_SUPER:
+		case	USB_SPEED_SUPER_PLUS:
 			if (vhci_driver->idev[i].hub != HUB_SPEED_SUPER)
 				continue;
 		break;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..3694d5405a5e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset)
+		  unsigned int fd, uoff_t offset)
 {
-	loff_t size = slot->npages << PAGE_SHIFT;
+	uoff_t size = slot->npages << PAGE_SHIFT;
 	unsigned long start, end;
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
 	int r = -EINVAL;
 
+	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
 	file = fget(fd);
@@ -664,8 +665,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	inode = file_inode(file);
 
-	if (offset < 0 || !PAGE_ALIGNED(offset) ||
-	    offset + size > i_size_read(inode))
+	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
 		goto err;
 
 	filemap_invalidate_lock(inode->i_mapping);
@@ -858,7 +858,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return ret;
 }
 
-long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
+long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
+		       long npages, bool may_writeback_src,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
 	struct kvm_memory_slot *slot;
@@ -892,8 +893,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 
 		if (src) {
 			unsigned long uaddr = (unsigned long)src + i * PAGE_SIZE;
+			unsigned int flags = may_writeback_src ? FOLL_WRITE : 0;
 
-			ret = get_user_pages_fast(uaddr, 1, 0, &src_page);
+			ret = get_user_pages_fast(uaddr, 1, flags, &src_page);
 			if (ret < 0)
 				break;
 			if (ret != 1) {
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..7510ca915dd1 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -3,6 +3,9 @@
 #ifndef __KVM_MM_H__
 #define __KVM_MM_H__ 1
 
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
@@ -72,7 +75,7 @@ int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, loff_t offset);
+		  unsigned int fd, uoff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -82,7 +85,7 @@ static inline int kvm_gmem_init(struct module *module)
 static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
-					 unsigned int fd, loff_t offset)
+					 unsigned int fd, uoff_t offset)
 {
 	WARN_ON_ONCE(1);
 	return -EIO;

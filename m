Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365073;
	b=3KYHJ+zi/RFtojjcHydKpy1XvV8dUgKS7b7D8aSCd1oihXgPpkg5BYliHgApYFSZoqW7
	 rRJkqn78dwt0Q4+6wJFWrUrGu7ddp+IWBj5ME8KCu6GMTxBlne+MkzVKw7cbtqEjbeAsl
	 AzK3lrNOAZarL9d8sFxY/H1xzXiJrc6CDjcwkfaM3evTnVNEIuKxcYq5BuyvvaLfhEPS9
	 B59hP5P6peHUsZhyD6CzXpVLxMLYtz+jOsCM6SmL9PZjmrlK0PXvf2mEjJIaRlYDKEWDD
	 geN7xdwRhFlVKpYAspzNX/KUHHSWFYY6O0yx1oFKY0IZLrsO4sIJJPG6BnNM+uNV4Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b7vbatyEEsIyXmdMM2l7pvX5/9RyMlw4NawbI81ZxJs=;
	b=3Uibj5j/tE43SPONM5Fm1gMNQyBo4I1N5WK1fCa4fs98jYTdJ0XGPc1nkR8lNjg6ooso
	 4SSUWpO0G+H8GHm1UKnIO2a8gQlpSukR4pXxNJCuPIjp9xX+v5n+/GWhd/6RAW5Do54NP
	 1HZPUiPPqLgCXVgQMqsQnvjX33asTobC0YMjsQQzNN8NjuJ8I5SWUZ3t3d38hl8q68SQH
	 Vh8S0DYsbxU5E+nUGK+zS0VJJIuVK3RkqZq40QYUhIWQXm5UIAY0TE6GdAxbD73DjfjBB
	 E5RRx3NRBcpo3v2Ca7YsyHF/6YmVOaOCpI3Pa8K8/ukZCduVPwJrKEn24HvYcqvIEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hAYyp9Jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11287606A31A;
	Fri, 30 Oct 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hAYyp9Jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5311F000C1;
	Fri, 30 Oct 2026 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365070;
	bh=b7vbatyEEsIyXmdMM2l7pvX5/9RyMlw4NawbI81ZxJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hAYyp9Jc7SPjUwC75spyiFDEsowqWj8M77BkFVZzbIZIXyE9zn7D48rzPbOo/o/ag
	 C3yc2hZjNqOfiBamh3nfgWn7V2T2r3aqvmyTNbdmiEI/7RTWJuVcWHoWVWqTelcPuT
	 tKqPm4hv3SfU4mCLoZjBVykxhhlcaoOL30jjZmyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.224
Date: Fri, 30 Oct 2026 13:57:38 +0100
Message-ID: <2026103038-maverick-crystal-3a25@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026103038-graceless-starboard-a2a7@gregkh>
References: <2026103038-graceless-starboard-a2a7@gregkh>
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

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index b2590a08c711..73dff0057b25 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -138,6 +138,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3821522        | ARM64_ERRATUM_3821522       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..ab814c326b95 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -77,7 +77,7 @@ Functions
 
      strp_done is called to release any resources held by the stream
      parser instance. This must be called after the stream processor
-     has been stopped.
+     has been stopped. The socket lock must not be held.
 
      ::
 
diff --git a/Makefile b/Makefile
index 95ad57e8d444..39856e1c9c4a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 223
+SUBLEVEL = 224
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 06ef732c0472..3e617076128d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -716,9 +716,17 @@ config ARM64_ERRATUM_2441009
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+	bool
+	# Targeting errata affecting AMEVCNTR01, the AMU constant counter.
+	# On affected CPUs the counter may not increment at the expected rate,
+	# making it unreliable. As a result, AMU users should treat it as
+	# unavailable rather than relying on misleading counter values.
+
 config ARM64_ERRATUM_2457168
 	bool "Cortex-A510: 2457168: workaround for AMEVCNTR01 incrementing incorrectly"
 	depends on ARM64_AMU_EXTN
+	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A510 erratum 2457168.
@@ -733,6 +741,28 @@ config ARM64_ERRATUM_2457168
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3821522
+	bool "Cortex-A725: 3821522: workaround for possible CNT_CYCLES increment error due to WFE/WFI"
+	depends on ARM64_AMU_EXTN
+	select ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A725 erratum 3821522.
+
+	  On affected A725 cores, the CNT_CYCLES event may incur a significant
+	  increment error when entering and subsequently exiting WFx.
+	  As a result, the CNT_CYCLES may diverge from the system counter
+	  frequency at which it is expected to increment.
+	  This renders the AMU counter AMEVCNTR01, that implements CNT_CYCLES,
+	  being unreliable and unsuitable for use.
+
+	  Since there is no hardware workaround, reads of the affected CNT_CYCLES
+	  counter return 0 in the relevant paths. This causes users of the counter
+	  to treat it as unavailable and is functionally equivalent to firmware
+	  disabling the affected counter.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 	bool
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index cf2df9e2ccf3..798c566674f8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -85,6 +85,14 @@ hdmi_con: endpoint {
 		};
 	};
 
+	reserved-memory {
+		/* Cont splash region set up by the bootloader */
+		cont_splash_mem: framebuffer@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x2400000>;
+			no-map;
+		};
+	};
+
 	lt9611_1v8: lt9611-vdd18-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "LT9611_1V8";
@@ -488,6 +496,7 @@ &i2c14 {
 };
 
 &mdss {
+	memory-region = <&cont_splash_mem>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e9f0b46e6f65..0529d0e5bdf5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -259,6 +259,20 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
+static const struct midr_range workaround_amu_constcnt_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2457168
+	/* Cortex-A510 r0p0-r1p1 */
+	MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_3821522
+	/* Cortex-A725 r0p0 - r0p2 */
+	MIDR_RANGE(MIDR_CORTEX_A725, 0, 0, 0, 2),
+#endif
+	{}
+};
+#endif /* CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT */
+
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
@@ -660,14 +674,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
 #endif
-
-#ifdef CONFIG_ARM64_ERRATUM_2457168
+#ifdef CONFIG_ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT
 	{
-		.desc = "ARM erratum 2457168",
-		.capability = ARM64_WORKAROUND_2457168,
+		.desc = "Broken AMU AMEVCNTR01 (const counter)",
+		.capability = ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
-		/* Cortex-A510 r0p0-r1p1 */
-		CAP_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1)
+		CAP_MIDR_RANGE_LIST(workaround_amu_constcnt_list)
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1742098
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a2518ccc5e98..7fd2f014c479 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1785,7 +1785,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
-		if (!this_cpu_has_cap(ARM64_WORKAROUND_2457168))
+		if (!this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT))
 			update_freq_counters_refs();
 	}
 }
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 877c68f47282..b142254d8c0f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -280,12 +280,13 @@ static void cpu_read_corecnt(void *val)
 static void cpu_read_constcnt(void *val)
 {
 	/*
-	 * Return 0 if the current CPU is affected by erratum 2457168. A value
-	 * of 0 is also returned if the current CPU does not support AMUs or if
-	 * the counter is disabled. A return value of 0 at counter read is
-	 * properly handled as an error case by the users of the counter.
+	 * Return 0 if the current CPU is affected by a HW erratum.
+	 * A value of 0 is also returned if the current CPU does not
+	 * support AMUs or if the counter is disabled. A return
+	 * value of 0 at counter read is properly handled as an error
+	 * case by the users of the counter.
 	 */
-	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_2457168) ?
+	*(u64 *)val = this_cpu_has_cap(ARM64_WORKAROUND_BROKEN_AMU_CONSTCNT) ?
 		      0UL : read_constcnt();
 }
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7d04f9670644..c5697cbbfabe 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -904,32 +904,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
-static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
+static int get_vma_page_shift(struct vm_area_struct *vma)
 {
-	unsigned long pa;
-
 	if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
 		return huge_page_shift(hstate_vma(vma));
 
-	if (!(vma->vm_flags & VM_PFNMAP))
-		return PAGE_SHIFT;
-
-	VM_BUG_ON(is_vm_hugetlb_page(vma));
-
-	pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
-	    ALIGN_DOWN(hva, PUD_SIZE) >= vma->vm_start &&
-	    ALIGN(hva, PUD_SIZE) <= vma->vm_end)
-		return PUD_SHIFT;
-#endif
-
-	if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
-	    ALIGN_DOWN(hva, PMD_SIZE) >= vma->vm_start &&
-	    ALIGN(hva, PMD_SIZE) <= vma->vm_end)
-		return PMD_SHIFT;
-
 	return PAGE_SHIFT;
 }
 
@@ -1038,7 +1017,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma);
 	}
 
 	shared = (vma->vm_flags & VM_SHARED);
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 054aec8a72e3..e6ed23b14623 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2151,6 +2151,14 @@ static int vgic_its_save_ite(struct vgic_its *its, struct its_device *dev,
 	u32 next_offset;
 	u64 val;
 
+	/*
+	 * MAPC with V=0 keeps the ITEs mapped but drops their collection,
+	 * and with it the ICID. Save a zeroed entry, which the restore path
+	 * reads back as invalid.
+	 */
+	if (!ite->collection)
+		return vgic_its_write_entry_lock(its, gpa, 0ULL, ite_esz);
+
 	next_offset = compute_next_eventid_offset(&dev->itt_head, ite);
 	val = ((u64)next_offset << KVM_ITS_ITE_NEXT_SHIFT) |
 	       ((u64)ite->irq->intid << KVM_ITS_ITE_PINTID_SHIFT) |
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d293aac8c554..0155330b9d0d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
@@ -123,6 +124,7 @@ static void show_pte(unsigned long addr)
 	struct mm_struct *mm;
 	pgd_t *pgdp;
 	pgd_t pgd;
+	unsigned long flags;
 
 	if (is_ttbr0_addr(addr)) {
 		/* TTBR0 */
@@ -144,6 +146,9 @@ static void show_pte(unsigned long addr)
 	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 vabits_actual, mm_to_pgd_phys(mm));
+
+	local_irq_save(flags);
+
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
@@ -157,31 +162,35 @@ static void show_pte(unsigned long addr)
 		if (pgd_none(pgd) || pgd_bad(pgd))
 			break;
 
-		p4dp = p4d_offset(pgdp, addr);
+		p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 		p4d = READ_ONCE(*p4dp);
 		pr_cont(", p4d=%016llx", p4d_val(p4d));
 		if (p4d_none(p4d) || p4d_bad(p4d))
 			break;
 
-		pudp = pud_offset(p4dp, addr);
+		pudp = pud_offset_lockless(p4dp, p4d, addr);
 		pud = READ_ONCE(*pudp);
 		pr_cont(", pud=%016llx", pud_val(pud));
 		if (pud_none(pud) || pud_bad(pud))
 			break;
 
-		pmdp = pmd_offset(pudp, addr);
+		pmdp = pmd_offset_lockless(pudp, pud, addr);
 		pmd = READ_ONCE(*pmdp);
 		pr_cont(", pmd=%016llx", pmd_val(pmd));
 		if (pmd_none(pmd) || pmd_bad(pmd))
 			break;
 
-		ptep = pte_offset_map(pmdp, addr);
+		ptep = pte_offset_map(&pmd, addr);
+		if (!ptep)
+			break;
+
 		pte = READ_ONCE(*ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
 	} while(0);
 
 	pr_cont("\n");
+	local_irq_restore(flags);
 }
 
 /*
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index e7f4ae17f31b..84baf77e847a 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -55,7 +55,6 @@ WORKAROUND_1463225
 WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_1742098
-WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
@@ -71,3 +70,4 @@ WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
+WORKAROUND_BROKEN_AMU_CONSTCNT
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index 69004e07a1ba..b6b415ae17a0 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -27,7 +27,7 @@ static inline __sum16 csum_fold(__wsum sum)
 		"add	%0, %0, r8\n"
 		"nor	%0, %0, %0\n"
 		: "=r" (sum)
-		: "r" (sum << 16), "0" (sum)
+		: "r" ((__force u32)sum << 16), "0" (sum)
 		: "r8");
 	return (__force __sum16) sum;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cc7da8d84061..4af4d45e65d4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3985,8 +3985,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				      unsigned long token)
 {
-	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt inti = {};
+	struct kvm_s390_irq irq = {};
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 335c281811c7..c8f882e06ab2 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -138,6 +138,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 	if (off || (count < sizeof(*report)))
 		return -EINVAL;
 
+	if (count < (report->length + sizeof(*report)))
+		return -EINVAL;
+
 	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
 
 	return ret ? ret : count;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 589c850fe4b0..234edbea1e08 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5620,12 +5620,6 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
-	if (version >= 5) {
-		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
-		if (x86_pmu.intel_cap.anythread_deprecated)
-			pr_cont(" AnyThread deprecated, ");
-	}
-
 	/*
 	 * Install the hw-cache-events table:
 	 */
@@ -6306,8 +6300,10 @@ __init int intel_pmu_init(void)
 				     (u64)fixed_mask);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
-	if (x86_pmu.intel_cap.anythread_deprecated)
+	if (version >= 5 && edx.split.anythread_deprecated) {
 		x86_pmu.format_attrs = intel_arch_formats_attr;
+		pr_cont("AnyThread deprecated, ");
+	}
 
 	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
 					  x86_pmu.num_counters,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4ed9641dccb0..068f35eb5003 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -593,7 +593,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
-		u64	anythread_deprecated:1;
+		u64	__reserved:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 081547246801..a768cbe23808 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2336,7 +2336,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 16d2b697dc63..f280155560a2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -656,8 +656,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	u32 offset;
 	u32 *msrpm;
 
-	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
-				      to_svm(vcpu)->msrpm;
+	msrpm = __va(__sme_clr(to_svm(vcpu)->vmcb->control.msrpm_base_pa));
 
 	offset    = svm_msrpm_offset(msr);
 	bit_write = 2 * (msr & 0x0f) + 1;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3249454c6f77..b6c302786b93 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3538,8 +3538,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
-	if (!from_vmentry)
+	if (!from_vmentry) {
+		nested_ept_uninit_mmu_context(vcpu);
 		return NVMX_VMENTRY_VMEXIT;
+	}
 
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index f7854e742e8c..468d80c7fb25 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -219,7 +219,7 @@ static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
-	u64 gen = kvm_memslots(vcpu->kvm)->generation;
+	u64 gen = kvm_vcpu_memslots(vcpu)->generation;
 
 	if (unlikely(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS))
 		return;
@@ -236,7 +236,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.mmio_gen == kvm_memslots(vcpu->kvm)->generation;
+	return vcpu->arch.mmio_gen == kvm_vcpu_memslots(vcpu)->generation;
 }
 
 /*
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 011139660172..1dfa927a27ea 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1976,7 +1976,6 @@ static int drbg_kcapi_seed(struct crypto_rng *tfm,
  */
 static inline int __init drbg_healthcheck_sanity(void)
 {
-	int len = 0;
 #define OUTBUFLEN 16
 	unsigned char buf[OUTBUFLEN];
 	struct drbg_state *drbg = NULL;
@@ -2018,12 +2017,12 @@ static inline int __init drbg_healthcheck_sanity(void)
 	max_addtllen = drbg_max_addtl(drbg);
 	max_request_bytes = drbg_max_request_bytes(drbg);
 	drbg_string_fill(&addtl, buf, max_addtllen + 1);
-	/* overflow addtllen with additonal info string */
-	len = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
-	BUG_ON(0 < len);
+	/* overflow addtllen with additional info string */
+	ret = drbg_generate(drbg, buf, OUTBUFLEN, &addtl);
+	BUG_ON(ret == 0);
 	/* overflow max_bits */
-	len = drbg_generate(drbg, buf, (max_request_bytes + 1), NULL);
-	BUG_ON(0 < len);
+	ret = drbg_generate(drbg, buf, max_request_bytes + 1, NULL);
+	BUG_ON(ret == 0);
 
 	/* overflow max addtllen with personalization string */
 	ret = drbg_seed(drbg, &addtl, false);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index e490166261d9..262e43a9e8ba 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -748,18 +748,31 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *child_parent __free(fwnode_handle) = NULL;
 	struct fwnode_handle *next;
 
-	if (IS_ERR_OR_NULL(fwnode))
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an child from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (child) {
+		child_parent = fwnode_get_parent(child);
+		parent = child_parent;
+	} else {
+		parent = fwnode;
+	}
+	if (IS_ERR_OR_NULL(parent))
 		return NULL;
 
 	/* Try to find a child in primary fwnode */
-	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
+	return fwnode_get_next_child_node(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9f71b27d235..5c44967b1c73 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -885,8 +885,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -899,8 +898,11 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0635df202dfa..4d0766cbb41a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -246,7 +246,8 @@ static void btintel_hw_error(struct hci_dev *hdev, u8 code)
 		return;
 	}
 
-	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
+	bt_dev_err(hdev, "Exception info %.*s", (int)(skb->len - 1),
+		   (char *)(skb->data + 1));
 
 	kfree_skb(skb);
 }
@@ -358,8 +359,16 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 	/* DDC file contains one or more DDC structure which has
 	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2).
 	 */
-	while (fw->size > fw_ptr - fw->data) {
-		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
+	while (fw->size > (size_t)(fw_ptr - fw->data)) {
+		size_t remaining = fw->size - (fw_ptr - fw->data);
+		unsigned int cmd_plen = fw_ptr[0] + 1U;
+
+		if (cmd_plen < 3 || cmd_plen > U8_MAX || cmd_plen > remaining) {
+			bt_dev_err(hdev, "Malformed DDC record (plen=%u, remaining=%zu)",
+				   cmd_plen, remaining);
+			release_firmware(fw);
+			return -EINVAL;
+		}
 
 		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
 				     HCI_INIT_TIMEOUT);
diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 11c7e04bf394..4ce8354ebb86 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -188,7 +188,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return 0;
 
 hci_free_dev:
+	rpmsg_destroy_ept(btq->cmd_channel);
+	rpmsg_destroy_ept(btq->acl_channel);
 	hci_free_dev(hdev);
+	return ret;
 destroy_cmd_channel:
 	rpmsg_destroy_ept(btq->cmd_channel);
 destroy_acl_channel:
@@ -197,17 +200,16 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int btqcomsmd_remove(struct platform_device *pdev)
+static void btqcomsmd_remove(struct platform_device *pdev)
 {
 	struct btqcomsmd *btq = platform_get_drvdata(pdev);
 
 	hci_unregister_dev(btq->hdev);
-	hci_free_dev(btq->hdev);
 
 	rpmsg_destroy_ept(btq->cmd_channel);
 	rpmsg_destroy_ept(btq->acl_channel);
 
-	return 0;
+	hci_free_dev(btq->hdev);
 }
 
 static const struct of_device_id btqcomsmd_of_match[] = {
@@ -218,7 +220,7 @@ MODULE_DEVICE_TABLE(of, btqcomsmd_of_match);
 
 static struct platform_driver btqcomsmd_driver = {
 	.probe = btqcomsmd_probe,
-	.remove = btqcomsmd_remove,
+	.remove_new = btqcomsmd_remove,
 	.driver  = {
 		.name  = "btqcomsmd",
 		.of_match_table = btqcomsmd_of_match,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d6a89d6604c7..6620db520568 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -301,6 +301,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3503), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index bc22178f83e8..440c001c746b 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -156,18 +156,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
 
 	return devm_hwrng_register(dev, &priv->rng);
 }
 
-static int stm32_rng_remove(struct platform_device *ofdev)
-{
-	pm_runtime_disable(&ofdev->dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int stm32_rng_runtime_suspend(struct device *dev)
 {
@@ -209,7 +204,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 41a677a82ed4..fe148431ad9c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -934,6 +934,36 @@ void dma_release_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
 
+static void dmaenginem_release_channel(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error pointer.
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	struct dma_chan *chan = dma_request_chan(dev, name);
+	int ret = 0;
+
+	if (!IS_ERR(chan))
+		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674..08cb7d68c160 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2940,7 +2940,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	err.csrow = m->synd & 0x3;
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 902a385ae733..320424dccc4e 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -166,6 +166,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	index = ida_alloc(&ida_index, GFP_KERNEL);
 	if (index < 0)
 		return index;
+	exar_gpio->index = index;
 
 	ret = devm_add_action_or_reset(dev, exar_devm_ida_free, exar_gpio);
 	if (ret)
@@ -181,7 +182,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->gpio_chip.set = exar_set_value;
 	exar_gpio->gpio_chip.base = -1;
 	exar_gpio->gpio_chip.ngpio = ngpios;
-	exar_gpio->index = index;
 	exar_gpio->first_pin = first_pin;
 
 	ret = devm_gpiochip_add_data(dev, &exar_gpio->gpio_chip, exar_gpio);
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 91259076d48a..21617c5b32e3 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -291,14 +291,7 @@ static void xgpio_save_regs(struct xgpio_instance *chip)
 
 static int xgpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(chip->parent);
-	/*
-	 * If the device is already active pm_runtime_get() will return 1 on
-	 * success, but gpio_request still needs to return 0.
-	 */
-	return ret < 0 ? ret : 0;
+	return pm_runtime_resume_and_get(chip->parent);
 }
 
 static void xgpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 314d527c8eaa..62ee3217842b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -128,16 +128,14 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
 	struct amdgpu_device *adev;
 
 	apd = container_of(genpd, struct acp_pm_domain, gpd);
-	if (apd != NULL) {
-		adev = apd->adev;
+	adev = apd->adev;
 	/* call smu to POWER GATE ACP block
 	 * smu will
 	 * 1. turn off the acp clock
 	 * 2. power off the acp tiles
 	 * 3. check and enter ulv state
 	 */
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
-	}
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
 	return 0;
 }
 
@@ -147,16 +145,14 @@ static int acp_poweron(struct generic_pm_domain *genpd)
 	struct amdgpu_device *adev;
 
 	apd = container_of(genpd, struct acp_pm_domain, gpd);
-	if (apd != NULL) {
-		adev = apd->adev;
+	adev = apd->adev;
 	/* call smu to UNGATE ACP block
 	 * smu will
 	 * 1. exit ulv
 	 * 2. turn on acp clock
 	 * 3. power on acp tiles
 	 */
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
-	}
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
 	return 0;
 }
 
@@ -193,7 +189,7 @@ static int acp_genpd_remove_device(struct device *dev, void *data)
 static int acp_hw_init(void *handle)
 {
 	int r;
-	uint64_t acp_base;
+	u64 acp_base;
 	u32 val = 0;
 	u32 count = 0;
 	struct i2s_platform_data *i2s_pdata = NULL;
@@ -220,37 +216,32 @@ static int acp_hw_init(void *handle)
 		return -EINVAL;
 
 	acp_base = adev->rmmio_base;
-
-
 	adev->acp.acp_genpd = kzalloc(sizeof(struct acp_pm_domain), GFP_KERNEL);
-	if (adev->acp.acp_genpd == NULL)
+	if (!adev->acp.acp_genpd)
 		return -ENOMEM;
 
 	adev->acp.acp_genpd->gpd.name = "ACP_AUDIO";
 	adev->acp.acp_genpd->gpd.power_off = acp_poweroff;
 	adev->acp.acp_genpd->gpd.power_on = acp_poweron;
-
-
 	adev->acp.acp_genpd->adev = adev;
 
 	pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, false);
 
-	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
-							GFP_KERNEL);
+	adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell), GFP_KERNEL);
 
-	if (adev->acp.acp_cell == NULL) {
+	if (!adev->acp.acp_cell) {
 		r = -ENOMEM;
 		goto failure;
 	}
 
 	adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
-	if (adev->acp.acp_res == NULL) {
+	if (!adev->acp.acp_res) {
 		r = -ENOMEM;
 		goto failure;
 	}
 
 	i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
-	if (i2s_pdata == NULL) {
+	if (!i2s_pdata) {
 		r = -ENOMEM;
 		goto failure;
 	}
@@ -346,15 +337,14 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
 	adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
 
-	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
-								ACP_DEVS);
+	r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, ACP_DEVS);
 	if (r)
 		goto failure;
 
 	r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 				  acp_genpd_add_device);
 	if (r)
-		goto failure;
+		goto failure_remove_mfd;
 
 	/* Assert Soft reset of ACP */
 	val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
@@ -371,7 +361,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -389,7 +379,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -399,6 +389,11 @@ static int acp_hw_init(void *handle)
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
 
+failure_remove_mfd:
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
+	mfd_remove_devices(adev->acp.parent);
+
 failure:
 	kfree(i2s_pdata);
 	kfree(adev->acp.acp_res);
@@ -548,8 +543,7 @@ static const struct amd_ip_funcs acp_ip_funcs = {
 	.set_powergating_state = acp_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version acp_ip_block =
-{
+const struct amdgpu_ip_block_version acp_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_ACP,
 	.major = 2,
 	.minor = 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49711776b351..f4f5dc704c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -73,6 +73,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	int r;
 	bool pm_pg_lock, use_bank, use_ring;
 	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
+	u32 *data __free(kfree) = NULL;
 
 	pm_pg_lock = use_bank = use_ring = false;
 	instance_bank = sh_bank = se_bank = me = pipe = queue = vmid = 0;
@@ -110,6 +111,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (!read && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -142,28 +157,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		mutex_lock(&adev->pm.mutex);
 
 	while (size) {
-		uint32_t value;
-
-		if (read) {
-			value = RREG32(*pos >> 2);
-			r = put_user(value, (uint32_t *)buf);
-		} else {
-			r = get_user(value, (uint32_t *)buf);
-			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (read)
+			data[result >> 2] = RREG32(*pos >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2]);
 
 		result += 4;
-		buf += 4;
 		*pos += 4;
 		size -= 4;
 	}
 
-end:
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -179,6 +182,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (read && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
@@ -851,7 +858,6 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_device *adev = f->f_inode->i_private;
 	int r;
-	ssize_t result = 0;
 	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
 
 	if (size > 4096 || size & 3 || *pos & 3)
@@ -896,25 +902,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
 
-	while (size) {
-		uint32_t value;
-
-		value = data[result >> 2];
-		r = put_user(value, (uint32_t *)buf);
-		if (r) {
-			amdgpu_virt_disable_access_debugfs(adev);
-			goto err;
-		}
-
-		result += 4;
-		buf += 4;
-		size -= 4;
-	}
-
+	r = copy_to_user(buf, data, size) ? -EFAULT : size;
 	kfree(data);
-	amdgpu_virt_disable_access_debugfs(adev);
-	return result;
+	return r;
 
 err:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -1140,8 +1132,10 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	r = down_read_killable(&adev->reset_sem);
-	if (r)
+	if (r) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e00d1637859f..1b64e5c8c347 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -693,20 +693,17 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-		/* MacBookPros with switchable graphics put VRAM at 0 when
-		 * the iGPU is enabled which results in cursor issues if
-		 * the cursor ends up at 0.  Reserve vram at 0 in that case.
-		 */
-		if (adev->gmc.vram_start == 0)
-			adev->mman.keep_stolen_vga_memory = true;
-		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
 	}
+	/* MacBookPros with switchable graphics put VRAM at 0 when
+	 * the iGPU is enabled which results in cursor issues if
+	 * the cursor ends up at 0.  Reserve vram at 0 in that case.
+	 */
+	if ((adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
+	    (adev->gmc.vram_start == 0))
+		adev->mman.keep_stolen_vga_memory = true;
 
 	if (amdgpu_sriov_vf(adev) ||
 	    !amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 8f9a2e9c276a..8d894a55c5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3222,6 +3222,15 @@ static int gfx_v6_0_sw_fini(void *handle)
 
 	amdgpu_gfx_rlc_fini(adev);
 
+	release_firmware(adev->gfx.pfp_fw);
+	adev->gfx.pfp_fw = NULL;
+	release_firmware(adev->gfx.me_fw);
+	adev->gfx.me_fw = NULL;
+	release_firmware(adev->gfx.ce_fw);
+	adev->gfx.ce_fw = NULL;
+	release_firmware(adev->gfx.rlc_fw);
+	adev->gfx.rlc_fw = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 135727b59c41..0b6f271f5bd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -460,6 +460,9 @@ static void sdma_v3_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	else
 		ref_and_mask = REG_SET_FIELD(ref_and_mask, GPU_HDP_FLUSH_DONE, SDMA1, 1);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
@@ -487,6 +490,10 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 				      unsigned flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
+
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
@@ -495,7 +502,11 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 
 	/* optionally write high bits as well */
 	if (write64bit) {
+		/* Hang workaround */
+		amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 		addr += 4;
+
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
@@ -1049,6 +1060,9 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for idle */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1077,6 +1091,9 @@ static void sdma_v3_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 {
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for flush */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1584,11 +1601,11 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
 	.get_wptr = sdma_v3_0_ring_get_wptr,
 	.set_wptr = sdma_v3_0_ring_set_wptr,
 	.emit_frame_size =
-		6 + /* sdma_v3_0_ring_emit_hdp_flush */
+		6 + 1 + /* sdma_v3_0_ring_emit_hdp_flush */
 		3 + /* hdp invalidate */
-		6 + /* sdma_v3_0_ring_emit_pipeline_sync */
-		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + /* sdma_v3_0_ring_emit_vm_flush */
-		10 + 10 + 10, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
+		6 + 1 + /* sdma_v3_0_ring_emit_pipeline_sync */
+		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + 1 + /* sdma_v3_0_ring_emit_vm_flush */
+		(10 + 1) * 3, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v3_0_ring_emit_ib */
 	.emit_ib = sdma_v3_0_ring_emit_ib,
 	.emit_fence = sdma_v3_0_ring_emit_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 96e13896ad1b..6095ddf1d7b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -957,7 +957,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
 
 static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCE,
-	.align_mask = 0xf,
+	.align_mask = 0x1f,
 	.nop = VCE_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6d64d603a97a..ef26e8973829 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1432,10 +1432,31 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+struct vi_reset_quirk {
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u8 revision;
+};
+
+static const struct vi_reset_quirk vi_reset_quirks[] = {
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
+};
+
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 {
+	unsigned int i;
 	u32 clock_cntl, pc;
 
+	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
+		if (adev->pdev->device == vi_reset_quirks[i].device &&
+		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
+		    adev->pdev->subsystem_device == vi_reset_quirks[i].subsystem_device &&
+		    adev->pdev->revision == vi_reset_quirks[i].revision)
+			return true;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4530d2213935..d22c05f68f87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2440,9 +2440,14 @@ static int dm_suspend(void *handle)
 #endif
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
+		if (!dm->cached_dc_state) {
+			drm_err(adev_to_drm(adev),
+				"Failed to allocate cached DC state during suspend\n");
+			mutex_unlock(&dm->dc_lock);
+			return -ENOMEM;
+		}
 
-		if (dm->cached_dc_state)
-			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -6024,11 +6029,16 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
+	/* Inserted modes copy the native sync; a sink mode with equal totals may not */
 	if (scale_enabled) {
 		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else if (native_mode->clock == drm_mode->clock &&
 			native_mode->htotal == drm_mode->htotal &&
-			native_mode->vtotal == drm_mode->vtotal) {
+			native_mode->vtotal == drm_mode->vtotal &&
+			native_mode->hsync_start == drm_mode->hsync_start &&
+			native_mode->hsync_end == drm_mode->hsync_end &&
+			native_mode->vsync_start == drm_mode->vsync_start &&
+			native_mode->vsync_end == drm_mode->vsync_end) {
 		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else {
 		/* no scaling nor amdgpu inserted, no need to patch */
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index bf72d3f60d7f..6a5c8a4cc32e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1354,7 +1354,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 7e37354a0341..640350bbd908 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -269,15 +269,21 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_lookup_voltage_type_v3(
 	unsigned int offset = offsetof(ATOM_VOLTAGE_OBJECT_INFO_V3_1, asVoltageObj[0]);
 	uint8_t *start = (uint8_t *)voltage_object_info_table;
 
-	while (offset < size) {
+	while (offset + sizeof(ATOM_VOLTAGE_OBJECT_HEADER_V3) <= size) {
 		const ATOM_VOLTAGE_OBJECT_V3 *voltage_object =
 			(const ATOM_VOLTAGE_OBJECT_V3 *)(start + offset);
+		u16 obj_size;
+
+		obj_size = le16_to_cpu(voltage_object->asGpioVoltageObj.sHeader.usSize);
+		if (obj_size < sizeof(voltage_object->asGpioVoltageObj.sHeader) ||
+		    offset + obj_size > size)
+			break;
 
 		if (voltage_type == voltage_object->asGpioVoltageObj.sHeader.ucVoltageType &&
 			voltage_mode == voltage_object->asGpioVoltageObj.sHeader.ucVoltageMode)
 			return voltage_object;
 
-		offset += le16_to_cpu(voltage_object->asGpioVoltageObj.sHeader.usSize);
+		offset += obj_size;
 	}
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
index a47a47238e2b..e5aa78718202 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
@@ -36,16 +36,21 @@ static const union atom_voltage_object_v4 *pp_atomfwctrl_lookup_voltage_type_v4(
 			offsetof(struct atom_voltage_objects_info_v4_1, voltage_object[0]);
 	unsigned long start = (unsigned long)voltage_object_info_table;
 
-	while (offset < size) {
+	while (offset + sizeof(struct atom_voltage_object_header_v4) <= size) {
 		const union atom_voltage_object_v4 *voltage_object =
 			(const union atom_voltage_object_v4 *)(start + offset);
+		u16 obj_size;
+
+		obj_size = le16_to_cpu(voltage_object->gpio_voltage_obj.header.object_size);
+		if (obj_size < sizeof(voltage_object->gpio_voltage_obj.header) ||
+		    offset + obj_size > size)
+			break;
 
 		if (voltage_type == voltage_object->gpio_voltage_obj.header.voltage_type &&
 		    voltage_mode == voltage_object->gpio_voltage_obj.header.voltage_mode)
 			return voltage_object;
 
-		offset += le16_to_cpu(voltage_object->gpio_voltage_obj.header.object_size);
-
+		offset += obj_size;
 	}
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 8cf2ad07ce62..f24eda530e21 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -5164,7 +5164,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
+	if ((adev->flags & AMD_IS_MOBILITY) &&
+	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
 		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
 
 	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {
@@ -7132,6 +7133,19 @@ static void si_parse_pplib_non_clock_info(struct amdgpu_device *adev,
 		adev->pm.dpm.uvd_ps = rps;
 }
 
+static void si_update_limits(struct amdgpu_clock_and_voltage_limits *limits,
+			     struct rv7xx_pl *pl)
+{
+	if (pl->sclk > limits->sclk)
+		limits->sclk = pl->sclk;
+	if (pl->mclk > limits->mclk)
+		limits->mclk = pl->mclk;
+	if (pl->vddc > limits->vddc)
+		limits->vddc = pl->vddc;
+	if (pl->vddci > limits->vddci)
+		limits->vddci = pl->vddci;
+}
+
 static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 				      struct amdgpu_ps *rps, int index,
 				      union pplib_clock_info *clock_info)
@@ -7140,7 +7154,6 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct  si_ps *ps = si_get_ps(rps);
-	struct amdgpu_clock_and_voltage_limits *limits;
 	u16 leakage_voltage;
 	struct rv7xx_pl *pl = &ps->performance_levels[index];
 	int ret;
@@ -7205,26 +7218,14 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	 * VBIOS can contain conflicting values between:
 	 * - the maximum allowed clocks and voltages on AC or DC
 	 * - the clocks and voltages in power states on AC or DC
+	 *
+	 * Assume that the AC limits are the maximum of all power states,
+	 * and the DC limits are the maximum of battery power states.
 	 */
+	si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_ac, pl);
 	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
-	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
-		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
-	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
 		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
-		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
-	else
-		limits = NULL;
-
-	if (limits) {
-		if (pl->sclk > limits->sclk)
-			limits->sclk = pl->sclk;
-		if (pl->mclk > limits->mclk)
-			limits->mclk = pl->mclk;
-		if (pl->vddc > limits->vddc)
-			limits->vddc = pl->vddc;
-		if (pl->vddci > limits->vddci)
-			limits->vddci = pl->vddci;
-	}
+		si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_dc, pl);
 }
 
 union pplib_power_state {
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 65f172807a0d..fb225912bb30 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -181,13 +181,12 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	}
 	reset_control_deassert(priv->rst);
 
-	priv->clk = devm_clk_get(drm->dev, NULL);
+	priv->clk = devm_clk_get_enabled(drm->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev,
-			"missing or invalid clk device tree entry");
+			"failed to get and enable clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b8815e7f5832..5eedbe47474e 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -3459,7 +3459,9 @@ static int dp_aux_backlight_update_status(struct backlight_device *bd)
 
 	if (!backlight_is_blank(bd)) {
 		if (!bl->enabled) {
-			drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
+			ret = drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
+			if (ret)
+				return ret;
 			bl->enabled = true;
 			return 0;
 		}
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index bc265aa0f692..acd90c22ea1f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1841,11 +1841,11 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 	drm_client_modeset_probe(&fb_helper->client, width, height);
 	ret = drm_fb_helper_single_fb_probe(fb_helper, bpp_sel);
 	if (ret < 0) {
-		if (ret == -EAGAIN) {
-			fb_helper->preferred_bpp = bpp_sel;
-			fb_helper->deferred_setup = true;
+		fb_helper->preferred_bpp = bpp_sel;
+		/* modesets are probed but fb_helper->fb isn't; defer restore too */
+		fb_helper->deferred_setup = true;
+		if (ret == -EAGAIN)
 			ret = 0;
-		}
 		mutex_unlock(&fb_helper->lock);
 
 		return ret;
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index ce7369211dba..c67400c5b39f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -475,6 +475,7 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
 	for_each_new_connector_in_state(state, connector, connector_state, i) {
 		if (connector_state->crtc)
 			break;
+		connector_state = NULL;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 0e04d4dd1c13..a0d6eb90d55a 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -477,7 +477,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -492,13 +492,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		dmc_info->mmioaddr[i] = _MMIO(mmioaddr[i]);
 		dmc_info->mmiodata[i] = mmiodata[i];
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(&i915->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(&i915->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -506,12 +514,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(&i915->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!dmc_info->payload)
 		return 0;
 
+	dmc_info->mmio_count = mmio_count;
+	dmc_info->start_mmioaddr = start_mmioaddr;
+	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(dmc_info->payload, payload, payload_size);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 86e8f48e352b..4811e9996422 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1680,6 +1680,7 @@ static int eb_reinit_userptr(struct i915_execbuffer *eb)
 static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb,
 					   struct i915_request *rq)
 {
+	const unsigned int count = eb->buffer_count;
 	bool have_copy = false;
 	struct eb_vma *ev;
 	int err = 0;
@@ -1804,7 +1805,6 @@ static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb,
 
 out:
 	if (have_copy) {
-		const unsigned int count = eb->buffer_count;
 		unsigned int i;
 
 		for (i = 0; i < count; i++) {
diff --git a/drivers/gpu/drm/i915/gt/intel_rps.c b/drivers/gpu/drm/i915/gt/intel_rps.c
index 0a03fbed9f9b..3f2101885cfc 100644
--- a/drivers/gpu/drm/i915/gt/intel_rps.c
+++ b/drivers/gpu/drm/i915/gt/intel_rps.c
@@ -1752,7 +1752,8 @@ static void rps_work(struct work_struct *work)
 
 out:
 	spin_lock_irq(&gt->irq_lock);
-	gen6_gt_pm_unmask_irq(gt, rps->pm_events);
+	if (intel_rps_is_active(rps))
+		gen6_gt_pm_unmask_irq(gt, rps->pm_events);
 	spin_unlock_irq(&gt->irq_lock);
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 95c31009bbec..ae35e7be077f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1867,7 +1867,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
 	if (ret) {
-		a6xx_destroy(&(a6xx_gpu->base.base));
+		a6xx_llc_slices_destroy(a6xx_gpu);
+		kfree(a6xx_gpu);
 		return ERR_PTR(ret);
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 37e6984a89ce..ef046d30ed02 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -934,6 +934,8 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->revn = adreno_gpu->info->revn;
 	adreno_gpu->rev = config->rev;
 
+	gpu->pdev = pdev;
+
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 
 	adreno_gpu_config.nr_rings = nr_rings;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8250d86d11e7..eec4ee4be93c 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -900,7 +900,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	if (IS_ERR(gpu->gpu_cx))
 		gpu->gpu_cx = NULL;
 
-	gpu->pdev = pdev;
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
 	msm_devfreq_init(gpu);
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a112a8eba2b8..7a5751496fed 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -277,11 +277,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
 		rep->domain = NOUVEAU_GEM_DOMAIN_VRAM;
 	rep->offset = nvbo->offset;
 	if (vmm->vmm.object.oclass >= NVIF_CLASS_VMM_NV50) {
+		int ret;
+
+		ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
+		if (ret)
+			return ret;
+
 		vma = nouveau_vma_find(nvbo, vmm);
-		if (!vma)
+		if (!vma) {
+			ttm_bo_unreserve(&nvbo->bo);
 			return -EINVAL;
+		}
 
 		rep->offset = vma->addr;
+		ttm_bo_unreserve(&nvbo->bo);
 	}
 
 	rep->size = nvbo->bo.base.size;
diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 63bdc9f6fc24..1fecb46d421f 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -49,6 +49,7 @@
 static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 {
 	uint8_t __iomem *bios;
+	uint8_t val1, val2;
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
 
@@ -63,7 +64,10 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 
-	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
+	val1 = readb(&bios[0]);
+	val2 = readb(&bios[1]);
+
+	if (size == 0 || val1 != 0x55 || val2 != 0xaa) {
 		iounmap(bios);
 		return false;
 	}
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 4703f180cde6..f09f1f062e31 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -994,6 +994,7 @@ static void vc4_bo_cache_destroy(struct drm_device *dev, void *unused)
 	cancel_work_sync(&vc4->bo_cache.time_work);
 
 	vc4_bo_cache_purge(dev);
+	kfree(vc4->bo_cache.size_list);
 
 	for (i = 0; i < vc4->num_labels; i++) {
 		if (vc4->bo_labels[i].num_allocated) {
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 7bb3067f8425..5e440e75eaff 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include "vc4_drv.h"
 #include "vc4_regs.h"
@@ -476,8 +477,15 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 
 	pm_runtime_disable(dev);
 
+	/* A straggler vc4_reset() re-enables the interrupt. */
+	timer_shutdown_sync(&vc4->hangcheck.timer);
+	cancel_work_sync(&vc4->hangcheck.reset_work);
+
 	vc4_irq_uninstall(drm);
 
+	/* Flush rather than cancel, so queued completions release their jobs. */
+	flush_work(&vc4->job_done_work);
+
 	/* Disable the binner's overflow memory address, so the next
 	 * driver probe (if any) doesn't try to reuse our old
 	 * allocation.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 8a9b61920496..590267c8a2fd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -155,6 +155,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	unsigned box_count;
+	u64 src_extent;
 	void *virtual;
 	bool dummy;
 	struct vmw_dma_cmd {
@@ -163,6 +164,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	} *cmd;
 	int i, ret;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != 4);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed */
@@ -200,8 +203,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		return;
 	}
 
+	if (box->w == 0 || box->h == 0)
+		return;
+
+	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
+		     (u64)box->w * 4;
+	if (src_extent > bo->base.size) {
+		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
+			  src_extent, bo->base.size);
+		return;
+	}
+
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
-	kmap_num = (64*64*4) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -215,13 +229,13 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &dummy);
 
-	if (box->w == 64 && cmd->dma.guest.pitch == 64*4) {
+	if (box->w == 64 && box->h == 64 && cmd->dma.guest.pitch == 64*4) {
 		memcpy(srf->snooper.image, virtual, 64*64*4);
 	} else {
-		/* Image is unsigned pointer. */
+		/* The destination stride is in pixels. */
 		for (i = 0; i < box->h; i++)
 			memcpy(srf->snooper.image + i * 64,
-			       virtual + i * cmd->dma.guest.pitch,
+			       virtual + (size_t)i * cmd->dma.guest.pitch,
 			       box->w * 4);
 	}
 
diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 72c21014de84..25da18017500 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -827,7 +827,20 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 static void alps_remove(struct hid_device *hdev)
 {
+	struct alps_dev *data = hid_get_drvdata(hdev);
+
+	/*
+	 * input2 ("DualPoint Stick") is allocated separately and is not
+	 * tracked in hdev->inputs, so the default remove path
+	 * (hid_hw_stop -> hidinput_disconnect) does not unregister it.
+	 *
+	 * Stop the device first so that no URB callback can touch input2
+	 * while it is being unregistered, then drop it explicitly.
+	 */
 	hid_hw_stop(hdev);
+
+	if (data->input2)
+		input_unregister_device(data->input2);
 }
 
 static const struct hid_device_id alps_id[] = {
@@ -847,14 +860,12 @@ static struct hid_driver alps_driver = {
 	.name = "hid-alps",
 	.id_table		= alps_id,
 	.probe			= alps_probe,
-	.remove			= alps_remove,
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-#ifdef CONFIG_PM
-	.resume			= alps_post_resume,
-	.reset_resume		= alps_post_reset,
-#endif
+	.resume			= pm_ptr(alps_post_resume),
+	.reset_resume		= pm_ptr(alps_post_reset),
+	.remove			= alps_remove,
 };
 
 module_hid_driver(alps_driver);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 783f55a259cd..b94106ae9b1c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1873,13 +1873,35 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  * @interrupt: distinguish between interrupt and control transfers
  *
  * This is data entry for lower layers.
+ * Legacy, please use hid_safe_input_report() instead.
  */
 int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int interrupt)
+{
+	return hid_safe_input_report(hid, type, data, size, size, interrupt);
+}
+EXPORT_SYMBOL_GPL(hid_input_report);
+
+/**
+ * hid_safe_input_report - report data from lower layer (usb, bt...)
+ *
+ * @hid: hid device
+ * @type: HID report type (HID_*_REPORT)
+ * @data: report contents
+ * @bufsize: allocated size of the data buffer
+ * @size: useful size of data parameter
+ * @interrupt: distinguish between interrupt and control transfers
+ *
+ * This is data entry for lower layers.
+ * Please use this function instead of the non safe version because we provide
+ * here the size of the buffer, allowing hid-core to make smarter decisions
+ * regarding the incoming buffer.
+ */
+int hid_safe_input_report(struct hid_device *hid, int type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
-	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -1924,7 +1946,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 	up(&hid->driver_input_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hid_input_report);
+EXPORT_SYMBOL_GPL(hid_safe_input_report);
 
 bool hid_match_one_id(const struct hid_device *hdev,
 		      const struct hid_device_id *id)
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c330d5a20ca0..b4858304c18d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3085,7 +3085,9 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		del_timer_sync(&sc->ghl_poke_timer);
+		/* poison, not kill: a pending timer must not re-submit during teardown */
+		usb_poison_urb(sc->ghl_urb);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
 		usb_free_urb(sc->ghl_urb);
 	}
 
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index fc616db4231b..4ba922d750df 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -114,11 +114,13 @@ struct steam_device {
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
 	struct mutex mutex;
-	bool client_opened;
+	struct mutex registration_mutex;
+	unsigned long client_opened;
 	struct input_dev __rcu *input;
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	bool registered;
 	char serial_no[STEAM_SERIAL_LEN + 1];
 	struct power_supply_desc battery_desc;
 	struct power_supply __rcu *battery;
@@ -293,9 +295,14 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool client_opened;
 
+	spin_lock_irqsave(&steam->lock, flags);
+	client_opened = steam->client_opened;
+	spin_unlock_irqrestore(&steam->lock, flags);
 	mutex_lock(&steam->mutex);
-	if (!steam->client_opened && lizard_mode)
+	if (!client_opened && lizard_mode)
 		steam_set_lizard_mode(steam, false);
 	mutex_unlock(&steam->mutex);
 	return 0;
@@ -304,9 +311,14 @@ static int steam_input_open(struct input_dev *dev)
 static void steam_input_close(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool client_opened;
 
+	spin_lock_irqsave(&steam->lock, flags);
+	client_opened = steam->client_opened;
+	spin_unlock_irqrestore(&steam->lock, flags);
 	mutex_lock(&steam->mutex);
-	if (!steam->client_opened && lizard_mode)
+	if (!client_opened && lizard_mode)
 		steam_set_lizard_mode(steam, true);
 	mutex_unlock(&steam->mutex);
 }
@@ -380,6 +392,7 @@ static int steam_battery_register(struct steam_device *steam)
 			&steam->battery_desc, &battery_cfg);
 	if (IS_ERR(battery)) {
 		ret = PTR_ERR(battery);
+		devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 		hid_err(steam->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -504,69 +517,78 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	bool client_opened;
 
+	mutex_lock(&steam->registration_mutex);
 	/*
 	 * This function can be called several times in a row with the
 	 * wireless adaptor, without steam_unregister() between them, because
 	 * another client send a get_connection_status command, for example.
 	 * The battery and serial number are set just once per device.
 	 */
-	if (!steam->serial_no[0]) {
-		/*
-		 * Unlikely, but getting the serial could fail, and it is not so
-		 * important, so make up a serial number and go on.
-		 */
-		mutex_lock(&steam->mutex);
-		if (steam_get_serial(steam) < 0)
-			strlcpy(steam->serial_no, "XXXXXXXXXX",
-					sizeof(steam->serial_no));
-		mutex_unlock(&steam->mutex);
-
-		hid_info(steam->hdev, "Steam Controller '%s' connected",
-				steam->serial_no);
-
-		/* ignore battery errors, we can live without it */
-		if (steam->quirks & STEAM_QUIRK_WIRELESS)
-			steam_battery_register(steam);
-
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
+	if (steam->registered) {
+		mutex_unlock(&steam->registration_mutex);
+		return 0;
 	}
 
 	mutex_lock(&steam->mutex);
-	client_opened = steam->client_opened;
-	if (!client_opened)
-		steam_set_lizard_mode(steam, lizard_mode);
+	/*
+	 * Unlikely, but getting the serial could fail, and it is not so
+	 * important, so make up a serial number and go on.
+	 */
+	if (steam_get_serial(steam) < 0 || !steam->serial_no[0])
+		strlcpy(steam->serial_no, "XXXXXXXXXX",
+				sizeof(steam->serial_no));
+
+	hid_info(steam->hdev, "Steam Controller '%s' connected",
+			steam->serial_no);
+
+	steam_set_lizard_mode(steam, lizard_mode);
 	mutex_unlock(&steam->mutex);
 
-	if (!client_opened)
-		ret = steam_input_register(steam);
-	else
-		ret = 0;
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
 
+	ret = steam_input_register(steam);
+	if (ret != 0)
+		goto steam_register_input_fail;
+
+	steam->registered = true;
+	mutex_unlock(&steam->registration_mutex);
+	mutex_lock(&steam_devices_lock);
+	if (list_empty(&steam->list))
+		list_add(&steam->list, &steam_devices);
+	mutex_unlock(&steam_devices_lock);
+	return 0;
+
+steam_register_input_fail:
+	steam_battery_unregister(steam);
+	mutex_unlock(&steam->registration_mutex);
 	return ret;
 }
 
 static void steam_unregister(struct steam_device *steam)
 {
+	if (!steam->registered)
+		return;
+
+	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+			steam->serial_no);
+	mutex_lock(&steam->registration_mutex);
+	steam->registered = false;
 	steam_battery_unregister(steam);
 	steam_input_unregister(steam);
-	if (steam->serial_no[0]) {
-		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
-				steam->serial_no);
-		mutex_lock(&steam_devices_lock);
-		list_del_init(&steam->list);
-		mutex_unlock(&steam_devices_lock);
-		steam->serial_no[0] = 0;
-	}
+	mutex_unlock(&steam->registration_mutex);
+	mutex_lock(&steam_devices_lock);
+	list_del_init(&steam->list);
+	mutex_unlock(&steam_devices_lock);
+	steam->serial_no[0] = 0;
 }
 
 static void steam_work_connect_cb(struct work_struct *work)
@@ -575,19 +597,20 @@ static void steam_work_connect_cb(struct work_struct *work)
 							work_connect);
 	unsigned long flags;
 	bool connected;
+	bool opened;
 	int ret;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	opened = steam->client_opened;
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (connected) {
+	if (connected && !opened) {
 		ret = steam_register(steam);
-		if (ret) {
+		if (ret)
 			hid_err(steam->hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-		}
 	} else {
 		steam_unregister(steam);
 	}
@@ -632,12 +655,13 @@ static void steam_client_ll_stop(struct hid_device *hdev)
 static int steam_client_ll_open(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
+	unsigned long flags;
 
-	mutex_lock(&steam->mutex);
-	steam->client_opened = true;
-	mutex_unlock(&steam->mutex);
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->client_opened++;
+	spin_unlock_irqrestore(&steam->lock, flags);
 
-	steam_input_unregister(steam);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -645,22 +669,13 @@ static int steam_client_ll_open(struct hid_device *hdev)
 static void steam_client_ll_close(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
-
 	unsigned long flags;
-	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	connected = steam->connected;
+	steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	mutex_lock(&steam->mutex);
-	steam->client_opened = false;
-	if (connected)
-		steam_set_lizard_mode(steam, lizard_mode);
-	mutex_unlock(&steam->mutex);
-
-	if (connected)
-		steam_input_register(steam);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -747,35 +762,25 @@ static int steam_probe(struct hid_device *hdev,
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
 	mutex_init(&steam->mutex);
+	mutex_init(&steam->registration_mutex);
 	steam->quirks = id->driver_data;
 	INIT_WORK(&steam->work_connect, steam_work_connect_cb);
 	INIT_LIST_HEAD(&steam->list);
 
-	steam->client_hdev = steam_create_client_hid(hdev);
-	if (IS_ERR(steam->client_hdev)) {
-		ret = PTR_ERR(steam->client_hdev);
-		goto client_hdev_fail;
-	}
-	steam->client_hdev->driver_data = steam;
-
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
 	 * Instead, create the client_hid and connect that.
 	 */
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
 	if (ret)
-		goto hid_hw_start_fail;
-
-	ret = hid_add_device(steam->client_hdev);
-	if (ret)
-		goto client_hdev_add_fail;
+		goto err_cancel_work;
 
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev,
 			"%s:hid_hw_open\n",
 			__func__);
-		goto hid_hw_open_fail;
+		goto err_hw_stop;
 	}
 
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
@@ -791,19 +796,33 @@ static int steam_probe(struct hid_device *hdev,
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-			goto input_register_fail;
+			goto err_hw_close;
 		}
 	}
 
+	steam->client_hdev = steam_create_client_hid(hdev);
+	if (IS_ERR(steam->client_hdev)) {
+		ret = PTR_ERR(steam->client_hdev);
+		goto err_stream_unregister;
+	}
+	steam->client_hdev->driver_data = steam;
+
+	ret = hid_add_device(steam->client_hdev);
+	if (ret)
+		goto err_destroy;
+
 	return 0;
 
-input_register_fail:
-hid_hw_open_fail:
-client_hdev_add_fail:
-	hid_hw_stop(hdev);
-hid_hw_start_fail:
+err_destroy:
 	hid_destroy_device(steam->client_hdev);
-client_hdev_fail:
+err_stream_unregister:
+	if (steam->connected)
+		steam_unregister(steam);
+err_hw_close:
+	hid_hw_close(hdev);
+err_hw_stop:
+	hid_hw_stop(hdev);
+err_cancel_work:
 	cancel_work_sync(&steam->work_connect);
 steam_alloc_fail:
 	hid_err(hdev, "%s: failed with error %d\n",
@@ -820,26 +839,24 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
+	hid_hw_close(hdev);
 	hid_destroy_device(steam->client_hdev);
-	steam->client_opened = false;
+	steam->client_hdev = NULL;
+	steam->client_opened = 0;
 	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	hid_hw_stop(hdev);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
 {
-	unsigned long flags;
 	bool changed;
 
-	spin_lock_irqsave(&steam->lock, flags);
 	changed = steam->connected != connected;
 	steam->connected = connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
 
 	if (changed && schedule_work(&steam->work_connect) == 0)
 		dbg_hid("%s: connected=%d event already queued\n",
@@ -1006,8 +1023,6 @@ static void steam_do_input_event(struct steam_device *steam,
 static void steam_do_battery_event(struct steam_device *steam,
 		struct power_supply *battery, u8 *data)
 {
-	unsigned long flags;
-
 	s16 volts = steam_le16(data + 12);
 	u8 batt = data[14];
 
@@ -1015,10 +1030,8 @@ static void steam_do_battery_event(struct steam_device *steam,
 	rcu_read_lock();
 	battery = rcu_dereference(steam->battery);
 	if (likely(battery)) {
-		spin_lock_irqsave(&steam->lock, flags);
 		steam->voltage = volts;
 		steam->battery_charge = batt;
-		spin_unlock_irqrestore(&steam->lock, flags);
 		power_supply_changed(battery);
 	}
 	rcu_read_unlock();
@@ -1031,10 +1044,12 @@ static int steam_raw_event(struct hid_device *hdev,
 	struct steam_device *steam = hid_get_drvdata(hdev);
 	struct input_dev *input;
 	struct power_supply *battery;
+	unsigned long flags;
 
 	if (!steam)
 		return 0;
 
+	spin_lock_irqsave(&steam->lock, flags);
 	if (steam->client_opened)
 		hid_input_report(steam->client_hdev, HID_FEATURE_REPORT,
 				data, size, 0);
@@ -1055,12 +1070,12 @@ static int steam_raw_event(struct hid_device *hdev,
 	 */
 
 	if (size != 64 || data[0] != 1 || data[1] != 0)
-		return 0;
+		goto out;
 
 	switch (data[2]) {
 	case STEAM_EV_INPUT_DATA:
 		if (steam->client_opened)
-			return 0;
+			goto out;
 		rcu_read_lock();
 		input = rcu_dereference(steam->input);
 		if (likely(input))
@@ -1098,6 +1113,8 @@ static int steam_raw_event(struct hid_device *hdev,
 		}
 		break;
 	}
+out:
+	spin_unlock_irqrestore(&steam->lock, flags);
 	return 0;
 }
 
@@ -1106,6 +1123,8 @@ static int steam_param_set_lizard_mode(const char *val,
 {
 	struct steam_device *steam;
 	int ret;
+	bool client_opened;
+	unsigned long flags;
 
 	ret = param_set_bool(val, kp);
 	if (ret)
@@ -1113,10 +1132,14 @@ static int steam_param_set_lizard_mode(const char *val,
 
 	mutex_lock(&steam_devices_lock);
 	list_for_each_entry(steam, &steam_devices, list) {
-		mutex_lock(&steam->mutex);
-		if (!steam->client_opened)
+		spin_lock_irqsave(&steam->lock, flags);
+		client_opened = steam->client_opened;
+		spin_unlock_irqrestore(&steam->lock, flags);
+		if (!client_opened) {
+			mutex_lock(&steam->mutex);
 			steam_set_lizard_mode(steam, lizard_mode);
-		mutex_unlock(&steam->mutex);
+			mutex_unlock(&steam->mutex);
+		}
 	}
 	mutex_unlock(&steam_devices_lock);
 	return 0;
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 6edfbfab55d3..93f7dfde6d29 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -518,8 +518,9 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
 
 	if (test_bit(I2C_HID_STARTED, &ihid->flags))
-		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
-				ret_size - 2, 1);
+		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
+				      ihid->inbuf + 2, ihid->bufsize - 2,
+				      ret_size - 2, 1);
 
 	return;
 }
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 09da654d2b05..9121eed46685 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -597,8 +597,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -608,8 +608,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b182b288991a..114aa5b6d396 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -281,9 +281,9 @@ static void hid_irq_in(struct urb *urb)
 			break;
 		usbhid_mark_busy(usbhid);
 		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
-			hid_input_report(urb->context, HID_INPUT_REPORT,
-					 urb->transfer_buffer,
-					 urb->actual_length, 1);
+			hid_safe_input_report(urb->context, HID_INPUT_REPORT,
+					      urb->transfer_buffer, urb->transfer_buffer_length,
+					      urb->actual_length, 1);
 			/*
 			 * autosuspend refused while keys are pressed
 			 * because most keyboards don't wake up when
@@ -480,9 +480,10 @@ static void hid_ctrl(struct urb *urb)
 	switch (status) {
 	case 0:			/* success */
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
-			hid_input_report(urb->context,
+			hid_safe_input_report(urb->context,
 				usbhid->ctrl[usbhid->ctrltail].report->type,
-				urb->transfer_buffer, urb->actual_length, 0);
+				urb->transfer_buffer, urb->transfer_buffer_length,
+				urb->actual_length, 0);
 		break;
 	case -ESHUTDOWN:	/* unplug */
 		unplug = 1;
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 47fb412eafd3..09863960c4b0 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -274,7 +274,6 @@ int vmbus_connect(void)
 cleanup:
 	pr_err("Unable to connect to host\n");
 
-	vmbus_connection.conn_state = DISCONNECTED;
 	vmbus_disconnect();
 
 	kfree(msginfo);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7125bccebe2a..85ef058f9ecd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2807,7 +2807,6 @@ static void __exit vmbus_exit(void)
 
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
-	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	if (vmbus_irq == -1) {
diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 5bac2b0fc7bb..b3de637a3a1f 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -165,6 +165,7 @@ static int drivetemp_scsi_command(struct drivetemp_data *st,
 {
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
 	int data_dir;
+	int err;
 
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0] = ATA_16;
@@ -192,9 +193,12 @@ static int drivetemp_scsi_command(struct drivetemp_data *st,
 	scsi_cmd[12] = lba_high;
 	scsi_cmd[14] = ata_command;
 
-	return scsi_execute_req(st->sdev, scsi_cmd, data_dir,
-				st->smartdata, ATA_SECT_SIZE, NULL, HZ, 5,
-				NULL);
+	err = scsi_execute_req(st->sdev, scsi_cmd, data_dir,
+			       st->smartdata, ATA_SECT_SIZE, NULL, HZ, 5,
+			       NULL);
+	if (err > 0)
+		err = -EIO;
+	return err;
 }
 
 static int drivetemp_ata_command(struct drivetemp_data *st, u8 feature,
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index f12b9a28a232..05ba32d44230 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -291,7 +291,13 @@ static void pwm_fan_pwm_disable(void *__ctx)
 
 	ctx->pwm_state.enabled = false;
 	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
-	del_timer_sync(&ctx->rpm_timer);
+}
+
+static void pwm_fan_timer_cleanup(void *__ctx)
+{
+	struct pwm_fan_ctx *ctx = __ctx;
+
+	timer_shutdown_sync(&ctx->rpm_timer);
 }
 
 static int pwm_fan_probe(struct platform_device *pdev)
@@ -424,6 +430,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	if (ctx->tach_count > 0) {
+		ret = devm_add_action_or_reset(dev, pwm_fan_timer_cleanup, ctx);
+		if (ret)
+			return ret;
+
 		ctx->sample_start = ktime_get();
 		mod_timer(&ctx->rpm_timer, jiffies + HZ);
 
@@ -490,6 +500,9 @@ static int pwm_fan_disable(struct device *dev)
 
 static void pwm_fan_shutdown(struct platform_device *pdev)
 {
+	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+
+	pwm_fan_timer_cleanup(ctx);
 	pwm_fan_disable(&pdev->dev);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e..30fae661090f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -716,26 +716,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
 static ssize_t cntr_val_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int i, ret = 0;
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
 	if (!local_read(&drvdata->mode)) {
 		spin_lock(&drvdata->spinlock);
-		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
-				       i, config->cntr_val[i]);
+		val = config->cntr_val[config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
-		return ret;
-	}
-
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
+	} else {
+		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
 	}
 
-	return ret;
+	return sysfs_emit(buf, "%#x\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 28ed1bde3d68..593881902a0d 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -919,8 +919,14 @@ int at91_twi_probe_master(struct platform_device *pdev,
 	at91_calc_twi_clock(dev);
 
 	rc = at91_init_twi_recovery_info(pdev, dev);
-	if (rc == -EPROBE_DEFER)
+	if (rc == -EPROBE_DEFER) {
+		/*
+		 * The DMA channels were already set up above, release them
+		 * before deferring the probe so they are not leaked.
+		 */
+		at91_twi_dma_release(dev);
 		return rc;
+	}
 
 	dev->adapter.algo = &at91_twi_algorithm;
 	dev->adapter.quirks = &at91_twi_quirks;
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index b353732f593b..fa0b4ce5c2f9 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -824,7 +824,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* Setup the DMA */
-	i2c->dmach = dma_request_chan(dev, "rx-tx");
+	i2c->dmach = devm_dma_request_chan(dev, "rx-tx");
 	if (IS_ERR(i2c->dmach)) {
 		return dev_err_probe(dev, PTR_ERR(i2c->dmach),
 				     "Failed to request dma\n");
@@ -862,9 +862,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adapter);
 
-	if (i2c->dmach)
-		dma_release_channel(i2c->dmach);
-
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index eae21899e0f3..46c922613b70 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -168,12 +168,12 @@ static irqreturn_t cci_isr(int irq, void *dev)
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M0_MASK;
+		reset |= CCI_RESET_CMD_M0_MASK;
 		ret = IRQ_HANDLED;
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M1_MASK;
+		reset |= CCI_RESET_CMD_M1_MASK;
 		ret = IRQ_HANDLED;
 	}
 
diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 88f5aafdce5b..33d085e564f5 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -391,7 +391,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	i2c_dev->clk = of_clk_get(np, 0);
+	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
 		dev_err(&pdev->dev, "unable to request clock\n");
 		return PTR_ERR(i2c_dev->clk);
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 04bfd86688bc..ee8d6e520ca0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2429,6 +2429,20 @@ int i2c_get_device_id(const struct i2c_client *client,
 }
 EXPORT_SYMBOL_GPL(i2c_get_device_id);
 
+/**
+ * i2c_client_get_device_id - get the driver match table entry of a device
+ * @client: the device to query. The device must be bound to a driver
+ *
+ * Returns a pointer to the matching entry if found, NULL otherwise.
+ */
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client)
+{
+	const struct i2c_driver *drv = to_i2c_driver(client->dev.driver);
+
+	return i2c_match_id(drv->id_table, client);
+}
+EXPORT_SYMBOL_GPL(i2c_client_get_device_id);
+
 /* ----------------------------------------------------
  * the i2c address scanning function
  * Will not work for 10-bit addresses!
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 48f4f2e31e59..6e02c91060ab 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -529,6 +529,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
 
+static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
+{
+	kfree(dev);
+}
+
 static void i3c_masterdev_release(struct device *dev)
 {
 	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
@@ -541,6 +546,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -728,11 +735,6 @@ static void i3c_device_release(struct device *dev)
 	kfree(i3cdev);
 }
 
-static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
-{
-	kfree(dev);
-}
-
 static struct i3c_dev_desc *
 i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
 			 const struct i3c_device_info *info)
@@ -1604,6 +1606,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -1624,7 +1628,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
@@ -1830,7 +1835,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 594a383169c7..ea5a2e09e60d 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1050,7 +1050,7 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 9174269c7653..1d0ab8230e70 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -645,7 +645,7 @@ static int sca3000_write_raw_samp_freq(struct sca3000_state *st, int val)
 
 	if (val == base_freq / 2)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_2;
-	if (val == base_freq / 4)
+	else if (val == base_freq / 4)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_4;
 	else if (val != base_freq)
 		return -EINVAL;
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 34ec0c28b2df..012cc9291bef 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -221,7 +221,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->rst);
 		goto reset_error;
 	}
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		goto reset_error;
 
 	model_data = of_device_get_match_data(&pdev->dev);
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 29c1824162cd..c427fdf93dcb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -409,6 +409,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		}
 		data = rxbuf[0];
 	}
+
+	/*
+	 * Differential channels are bipolar and the device returns the sample
+	 * in two's complement, so sign-extend it from the resolution bit.
+	 */
+	if (chan->differential)
+		data = sign_extend32(data, st->chip_info->bits - 1);
+
 	*val = data;
 
 error_ret:
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..6aa42d998977 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -645,10 +645,10 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		 * thermal because no thermal DT node is found.
 		 */
 		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
-			dev_err(&pdev->dev,
-				"could not register thermal sensor: %ld\n",
-				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
+			ret = dev_err_probe(&pdev->dev,
+					    PTR_ERR(info->tzd),
+					    "could not register thermal sensor\n");
+			goto err_map;
 		}
 	}
 
@@ -664,7 +664,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
@@ -675,7 +674,6 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 71295709f2b9..eb7ab53824ea 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -145,7 +145,7 @@ static int adis16136_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
-	debugfs_create_file_unsafe("serial_number", 0400,
+	debugfs_create_file("serial_number", 0400,
 		d, adis16136, &adis16136_serial_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
 		d, adis16136, &adis16136_product_id_fops);
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 9bcd9a9261b9..5b5eca0663c8 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -279,7 +279,7 @@ static int adis16400_debugfs_init(struct iio_dev *indio_dev)
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
-		debugfs_create_file_unsafe("serial_number", 0400,
+		debugfs_create_file("serial_number", 0400,
 				d, st, &adis16400_serial_number_fops);
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
 		debugfs_create_file_unsafe("product_id", 0400,
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 44bbe3d19907..798c7386c7e0 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -300,9 +300,9 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16480 *adis16480 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
-	debugfs_create_file_unsafe("firmware_revision", 0400,
+	debugfs_create_file("firmware_revision", 0400,
 		d, adis16480, &adis16480_firmware_revision_fops);
-	debugfs_create_file_unsafe("firmware_date", 0400,
+	debugfs_create_file("firmware_date", 0400,
 		d, adis16480, &adis16480_firmware_date_fops);
 	debugfs_create_file_unsafe("serial_number", 0400,
 		d, adis16480, &adis16480_serial_number_fops);
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c81dbd2f0972..30d20e3ef051 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1187,6 +1187,8 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
+	guard(mutex)(&indio_dev->mlock);
+
 	iio_disable_buffers(indio_dev);
 	iio_buffer_deactivate_all(indio_dev);
 }
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..cbc2bf79d2b7 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -513,6 +513,8 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
+	cancel_work_sync(&trig->reenable_work);
+
 	if (trig->subirq_base) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d1d9f2d319e4..53207b2bff48 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1570,6 +1570,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 	iio_trigger_unregister(data->trig);
 error_free_irq:
 	free_irq(client->irq, indio_dev);
+	irq_work_sync(&data->work);
 error_uninit_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_regulator_disable:
@@ -1592,6 +1593,7 @@ static int gp2ap020a00f_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_trigger_unregister(data->trig);
 	free_irq(client->irq, indio_dev);
+	irq_work_sync(&data->work);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(data->vled_reg);
 
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 3ccc95cf645c..7fa6bdcc6cb4 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -227,7 +227,7 @@ static int isl29501_register_read(struct isl29501_private *isl29501,
 	return ret;
 }
 
-static u32 isl29501_register_write(struct isl29501_private *isl29501,
+static int isl29501_register_write(struct isl29501_private *isl29501,
 				   enum isl29501_register_name name,
 				   u32 value)
 {
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 27026c060ab9..5cbab749779e 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -299,12 +299,14 @@ static int lidar_probe(struct i2c_client *client,
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto error_unreg_buffer;
+		goto error_unreg_dev;
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
 	return 0;
 
+error_unreg_dev:
+	iio_device_unregister(indio_dev);
 error_unreg_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index ff83638db16f..e85f3660188f 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -584,16 +584,26 @@ static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
 		return IRQ_HANDLED;
 	}
 
-	if (!(isr & VCNL_ICR_THRES_EN))
+	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))
 		return IRQ_NONE;
 
-	iio_push_event(indio_dev,
-		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
-				            IIO_EV_TYPE_THRESH,
-				            IIO_EV_DIR_RISING),
-		       iio_get_time_ns(indio_dev));
+	if (isr & VCNL_INT_TH_HI) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if (isr & VCNL_INT_TH_LOW) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+	}
 
-	rc = regmap_write(data->regmap, VCNL_ISR, isr & VCNL_ICR_THRES_EN);
+	rc = regmap_write(data->regmap, VCNL_ISR, isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW));
 	if (rc)
 		dev_err(data->dev, "Error (%d) writing in reg (0x%x)\n",
 			rc, VCNL_ISR);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 43b661f97188..32d8a4eb385b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6209,7 +6209,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
+	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq",
+						    WQ_MEM_RECLAIM);
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "failed to create irq workqueue.\n");
 		ret = -ENOMEM;
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 174b51ba7794..aa63735d5038 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1969,6 +1969,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 6e0c5f5a2713..90553efd2522 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -426,7 +426,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		del_timer(&priv->timer);
+		timer_shutdown_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a0a35970bd5..a4c05b358aea 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -188,6 +188,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2058", /* E490 */
+	"LEN205b", /* T490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
@@ -1808,8 +1809,10 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 			return -ENXIO;
 		}
 
-		/* Disable intertouch on known-broken board revisions */
-		if (info->board_id == 2722) {
+		/* Disable intertouch on known-broken T440p board revisions */
+		if (info->board_id == 2722 &&
+		    psmouse_matches_pnp_id(psmouse,
+					   (const char * const []){"LEN0036", NULL})) {
 			psmouse_info(psmouse,
 				     "Disabling intertouch for board id %u\n",
 				     info->board_id);
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 2fedcce29cc6..b05f4629dcb2 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -660,6 +660,15 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
 	},
+	{
+		/* Fujitsu LIFEBOOK U7410 */
+		/* Mux mode also disturbs the EC keyboard, causing spurious ACKs */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U7410"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Gigabyte M912 */
 		.matches = {
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 4b7eee01c6aa..69eae79e2087 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -109,6 +109,11 @@ static inline void exc3000_schedule_timer(struct exc3000_data *data)
 	mod_timer(&data->timer, jiffies + msecs_to_jiffies(EXC3000_TIMEOUT_MS));
 }
 
+static void exc3000_shutdown_timer(void *timer)
+{
+	timer_shutdown_sync(timer);
+}
+
 static int exc3000_read_frame(struct exc3000_data *data, u8 *buf)
 {
 	struct i2c_client *client = data->client;
@@ -386,6 +391,11 @@ static int exc3000_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
+	error = devm_add_action_or_reset(&client->dev, exc3000_shutdown_timer,
+					 &data->timer);
+	if (error)
+		return error;
+
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, exc3000_interrupt, IRQF_ONESHOT,
 					  client->name, data);
diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 85a1f465c097..6f1827cfc720 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -510,10 +510,22 @@ static int __maybe_unused s6sy761_suspend(struct device *dev)
 static int __maybe_unused s6sy761_resume(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
+	int err;
+
+	err = s6sy761_power_on(sdata);
+	if (err)
+		return err;
 
 	enable_irq(sdata->client->irq);
 
-	return s6sy761_power_on(sdata);
+	mutex_lock(&sdata->input->mutex);
+
+	if (input_device_enabled(sdata->input))
+		err = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+
+	mutex_unlock(&sdata->input->mutex);
+
+	return err;
 }
 
 static const struct dev_pm_ops s6sy761_pm_ops = {
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 0f00be62438d..973092543eb7 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -304,15 +304,9 @@ static void capincci_alloc_minor(struct capidev *cdev, struct capincci *np)
 static void capincci_free_minor(struct capincci *np)
 {
 	struct capiminor *mp = np->minorp;
-	struct tty_struct *tty;
 
 	if (mp) {
-		tty = tty_port_tty_get(&mp->port);
-		if (tty) {
-			tty_vhangup(tty);
-			tty_kref_put(tty);
-		}
-
+		tty_port_tty_vhangup(&mp->port);
 		capiminor_free(mp);
 	}
 }
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 37c8740d6d99..04b11ad0d7c7 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -338,8 +338,6 @@ struct cache {
 	struct list_head invalidation_requests;
 
 	sector_t migration_threshold;
-	wait_queue_head_t migration_wait;
-	atomic_t nr_allocated_migrations;
 
 	/*
 	 * The number of in flight migrations that are performing
@@ -395,7 +393,11 @@ struct cache {
 	bool loaded_mappings:1;
 	bool loaded_discards:1;
 
-	struct rw_semaphore background_work_lock;
+	/* background work management */
+	bool background_work_allowed;
+	unsigned background_work_nr;
+	spinlock_t background_work_lock;
+	wait_queue_head_t background_work_wait;
 
 	struct batcher committer;
 	struct work_struct commit_ws;
@@ -486,19 +488,13 @@ static struct dm_cache_migration *alloc_migration(struct cache *cache)
 	memset(mg, 0, sizeof(*mg));
 
 	mg->cache = cache;
-	atomic_inc(&cache->nr_allocated_migrations);
 
 	return mg;
 }
 
 static void free_migration(struct dm_cache_migration *mg)
 {
-	struct cache *cache = mg->cache;
-
-	if (atomic_dec_and_test(&cache->nr_allocated_migrations))
-		wake_up(&cache->migration_wait);
-
-	mempool_free(mg, &cache->migration_pool);
+	mempool_free(mg, &mg->cache->migration_pool);
 }
 
 /*----------------------------------------------------------------*/
@@ -1026,34 +1022,39 @@ static void calc_discard_block_range(struct cache *cache, struct bio *bio,
 
 static void prevent_background_work(struct cache *cache)
 {
-	lockdep_off();
-	down_write(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	cache->background_work_allowed = false;
+	wait_event_lock_irq(cache->background_work_wait,
+			    cache->background_work_nr == 0,
+			    cache->background_work_lock);
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 static void allow_background_work(struct cache *cache)
 {
-	lockdep_off();
-	up_write(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	cache->background_work_allowed = true;
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 static bool background_work_begin(struct cache *cache)
 {
 	bool r;
 
-	lockdep_off();
-	r = down_read_trylock(&cache->background_work_lock);
-	lockdep_on();
-
+	spin_lock_irq(&cache->background_work_lock);
+	r = cache->background_work_allowed;
+	if (r)
+		cache->background_work_nr++;
+	spin_unlock_irq(&cache->background_work_lock);
 	return r;
 }
 
 static void background_work_end(struct cache *cache)
 {
-	lockdep_off();
-	up_read(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	if (--cache->background_work_nr == 0)
+		wake_up(&cache->background_work_wait);
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 /*----------------------------------------------------------------*/
@@ -1453,6 +1454,9 @@ static void invalidate_complete(struct dm_cache_migration *mg, bool success)
 	struct bio_list bios;
 	struct cache *cache = mg->cache;
 
+	if (success)
+		atomic_inc(&cache->stats.demotion);
+
 	bio_list_init(&bios);
 	if (mg->cell) {
 		if (dm_cell_unlock_v2(cache->prison, mg->cell, &bios))
@@ -1697,7 +1701,6 @@ static int map_bio(struct cache *cache, struct bio *bio, dm_oblock_t block,
 		if (passthrough_mode(cache)) {
 			if (bio_data_dir(bio) == WRITE) {
 				bio_drop_shared_lock(cache, bio);
-				atomic_inc(&cache->stats.demotion);
 				invalidate_start(cache, cblock, block, bio);
 				return DM_MAPIO_SUBMITTED;
 			} else
@@ -2475,9 +2478,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 
 	spin_lock_init(&cache->lock);
 	bio_list_init(&cache->deferred_bios);
-	atomic_set(&cache->nr_allocated_migrations, 0);
 	atomic_set(&cache->nr_io_migrations, 0);
-	init_waitqueue_head(&cache->migration_wait);
 
 	r = -ENOMEM;
 	atomic_set(&cache->nr_dirty, 0);
@@ -2559,8 +2560,10 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 		     issue_op, cache, cache->wq);
 	dm_iot_init(&cache->tracker);
 
-	init_rwsem(&cache->background_work_lock);
-	prevent_background_work(cache);
+	init_waitqueue_head(&cache->background_work_wait);
+	spin_lock_init(&cache->background_work_lock);
+	cache->background_work_allowed = false;
+	cache->background_work_nr = 0;
 
 	*result = cache;
 	return 0;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index abc13c8dc4ed..4899b6d16d0f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1740,7 +1740,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 	struct bio *base_bio = io->base_bio;
-	blk_status_t error = io->error;
 
 	if (!atomic_dec_and_test(&io->io_pending))
 		return;
@@ -1753,7 +1752,7 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 	else
 		kfree(io->integrity_metadata);
 
-	base_bio->bi_status = error;
+	base_bio->bi_status = io->error;
 
 	bio_endio(base_bio);
 }
@@ -2854,8 +2853,13 @@ static int crypt_ctr_cipher_new(struct dm_target *ti, char *cipher_in, char *key
 		}
 	}
 
-	if (*ivmode && !strcmp(*ivmode, "lmk"))
+	if (*ivmode && !strcmp(*ivmode, "lmk")) {
+		if (crypt_integrity_aead(cc)) {
+			ti->error = "AEAD transforms not supported for LMK";
+			return -EINVAL;
+		}
 		cc->tfms_count = 64;
+	}
 
 	if (*ivmode && !strcmp(*ivmode, "essiv")) {
 		if (!*ivopts) {
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 5bdc31943b27..d9475a669090 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -263,8 +263,7 @@ static int ebs_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	r = -EINVAL;
 	if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1 ||
-	    tmp != (sector_t)tmp ||
-	    (sector_t)tmp >= ti->len) {
+	    tmp != (sector_t)tmp) {
 		ti->error = "Invalid device offset sector";
 		goto bad;
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index cebffb0b5a1a..a3a223f096a3 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1725,7 +1725,7 @@ static void integrity_metadata(struct work_struct *w)
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			sector_t bi_sector = dio->bio_details.bi_iter.bi_sector;
 			unsigned bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned max_blocks = max_size / ic->tag_size;
 			memset(checksums, DISCARD_FILLER, max_size);
 
@@ -3360,6 +3360,9 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->physical_block_size = ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 	}
+
+	if (ic->internal_hash && (ic->mode == 'D' || ic->mode == 'B'))
+		ti->needs_stable_writes = true;
 }
 
 static void calculate_journal_section_size(struct dm_integrity_c *ic)
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index b946cbdc8e96..816b9527394c 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -538,10 +538,16 @@ static void *get_result_buffer(struct dm_ioctl *param, size_t param_size,
 {
 	param->data_start = align_ptr(param + 1) - (void *) param;
 
-	if (param->data_start < param_size)
+	if (param->data_start < param_size) {
 		*len = param_size - param->data_start;
-	else
+	} else {
+		/*
+		 * The buffer can be as small as offsetof(*param, data), which
+		 * is less than sizeof(*param), so don't run off the end of it.
+		 */
 		*len = 0;
+		param->data_start = param_size;
+	}
 
 	return ((void *) param) + param->data_start;
 }
@@ -1145,6 +1151,7 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		fmode_t new_map_mode;
 
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
@@ -1172,6 +1179,7 @@ static int do_resume(struct dm_ioctl *param)
 			}
 		}
 
+		new_map_mode = dm_table_get_mode(new_map);
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1184,7 +1192,7 @@ static int do_resume(struct dm_ioctl *param)
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
 
-		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+		if (new_map_mode & FMODE_WRITE)
 			set_disk_ro(dm_disk(md), 0);
 		else
 			set_disk_ro(dm_disk(md), 1);
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index d3716d5c45c2..3a026f543478 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1322,6 +1322,20 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad_store;
 	}
 
+	/*
+	 * snapshot-merge requires the optional prepare_merge/commit_merge
+	 * callbacks; the transient exception store does not implement them.
+	 * The handover path checks this in __validate_exception_handover(),
+	 * but a directly constructed snapshot-merge never goes through it.
+	 */
+	if (dm_target_is_snapshot_merge(ti) &&
+	    (!s->store->type->prepare_merge ||
+	     !s->store->type->commit_merge)) {
+		ti->error = "Snapshot exception store does not support snapshot-merge.";
+		r = -EINVAL;
+		goto bad_hash_tables;
+	}
+
 	argv += args_used;
 	argc -= args_used;
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0f815bcf751f..b9fe92337b36 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1974,7 +1974,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 
-	return blk_queue_stable_writes(q);
+	return ti->needs_stable_writes || blk_queue_stable_writes(q);
 }
 
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a37a82183024..ab95d77ce883 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5662,6 +5662,7 @@ static void md_free(struct kobject *ko)
 
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 	kfree(mddev);
 }
 
@@ -5949,6 +5950,13 @@ int md_run(struct mddev *mddev)
 			goto exit_bio_set;
 	}
 
+	if (!bioset_initialized(&mddev->io_acct_set)) {
+		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
+				  offsetof(struct md_io_acct, bio_clone), 0);
+		if (err)
+			goto exit_sync_set;
+	}
+
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
 	if (!pers || !try_module_get(pers->owner)) {
@@ -6124,6 +6132,8 @@ int md_run(struct mddev *mddev)
 	module_put(pers->owner);
 	md_bitmap_destroy(mddev);
 abort:
+	bioset_exit(&mddev->io_acct_set);
+exit_sync_set:
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
@@ -6361,6 +6371,7 @@ void md_stop(struct mddev *mddev)
 	__md_stop(mddev);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -8674,23 +8685,6 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
-int acct_bioset_init(struct mddev *mddev)
-{
-	int err = 0;
-
-	if (!bioset_initialized(&mddev->io_acct_set))
-		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
-			offsetof(struct md_io_acct, bio_clone), 0);
-	return err;
-}
-EXPORT_SYMBOL_GPL(acct_bioset_init);
-
-void acct_bioset_exit(struct mddev *mddev)
-{
-	bioset_exit(&mddev->io_acct_set);
-}
-EXPORT_SYMBOL_GPL(acct_bioset_exit);
-
 static void md_end_io_acct(struct bio *bio)
 {
 	struct md_io_acct *md_io_acct = bio->bi_private;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 99780e89531e..1c84daba6bb7 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -729,8 +729,6 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
-int acct_bioset_init(struct mddev *mddev);
-void acct_bioset_exit(struct mddev *mddev);
 void md_account_bio(struct mddev *mddev, struct bio **bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 2290307e0910..ba046c41b34a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -381,7 +381,6 @@ static void raid0_free(struct mddev *mddev, void *priv)
 	struct r0conf *conf = priv;
 
 	free_conf(mddev, conf);
-	acct_bioset_exit(mddev);
 }
 
 static int raid0_run(struct mddev *mddev)
@@ -396,16 +395,11 @@ static int raid0_run(struct mddev *mddev)
 	if (md_check_no_bitmap(mddev))
 		return -EINVAL;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid0:%s: alloc acct bioset failed.\n", mdname(mddev));
-		return -ENOMEM;
-	}
-
 	/* if private is not null, we are here after takeover */
 	if (mddev->private == NULL) {
 		ret = create_strip_zones(mddev, &conf);
 		if (ret < 0)
-			goto exit_acct_set;
+			return ret;
 		mddev->private = conf;
 	}
 	conf = mddev->private;
@@ -445,15 +439,9 @@ static int raid0_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret)
-		goto free;
+		free_conf(mddev, conf);
 
 	return ret;
-
-free:
-	free_conf(mddev, conf);
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
 }
 
 /*
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 901d1c821874..95d72dcc40fb 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7472,19 +7472,12 @@ static int raid5_run(struct mddev *mddev)
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
 	sector_t reshape_offset = 0;
-	int i, ret = 0;
+	int i;
 	long long min_offset_diff = 0;
 	int first = 1;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid456:%s: alloc acct bioset failed.\n", mdname(mddev));
+	if (mddev_init_writes_pending(mddev) < 0)
 		return -ENOMEM;
-	}
-
-	if (mddev_init_writes_pending(mddev) < 0) {
-		ret = -ENOMEM;
-		goto exit_acct_set;
-	}
 
 	if (mddev->recovery_cp != MaxSector)
 		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
@@ -7515,8 +7508,7 @@ static int raid5_run(struct mddev *mddev)
 	    (mddev->bitmap_info.offset || mddev->bitmap_info.file)) {
 		pr_notice("md/raid:%s: array cannot have both journal and bitmap\n",
 			  mdname(mddev));
-		ret = -EINVAL;
-		goto exit_acct_set;
+		return -EINVAL;
 	}
 
 	if (mddev->reshape_position != MaxSector) {
@@ -7541,15 +7533,13 @@ static int raid5_run(struct mddev *mddev)
 		if (journal_dev) {
 			pr_warn("md/raid:%s: don't support reshape with journal - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 
 		if (mddev->new_level != mddev->level) {
 			pr_warn("md/raid:%s: unsupported reshape required - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		old_disks = mddev->raid_disks - mddev->delta_disks;
 		/* reshape_position must be on a new-stripe boundary, and one
@@ -7565,8 +7555,7 @@ static int raid5_run(struct mddev *mddev)
 		if (sector_div(here_new, chunk_sectors * new_data_disks)) {
 			pr_warn("md/raid:%s: reshape_position not on a stripe boundary\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		reshape_offset = here_new * chunk_sectors;
 		/* here_new is the stripe we will write to */
@@ -7588,8 +7577,7 @@ static int raid5_run(struct mddev *mddev)
 			else if (mddev->ro == 0) {
 				pr_warn("md/raid:%s: in-place reshape must be started in read-only mode - aborting\n",
 					mdname(mddev));
-				ret = -EINVAL;
-				goto exit_acct_set;
+				return -EINVAL;
 			}
 		} else if (mddev->reshape_backwards
 		    ? (here_new * chunk_sectors + min_offset_diff <=
@@ -7599,8 +7587,7 @@ static int raid5_run(struct mddev *mddev)
 			/* Reading from the same stripe as writing to - bad */
 			pr_warn("md/raid:%s: reshape_position too early for auto-recovery - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		pr_debug("md/raid:%s: reshape will continue\n", mdname(mddev));
 		/* OK, we should be able to continue; */
@@ -7624,10 +7611,8 @@ static int raid5_run(struct mddev *mddev)
 	else
 		conf = mddev->private;
 
-	if (IS_ERR(conf)) {
-		ret = PTR_ERR(conf);
-		goto exit_acct_set;
-	}
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
 
 	if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
 		if (!journal_dev) {
@@ -7827,10 +7812,7 @@ static int raid5_run(struct mddev *mddev)
 	free_conf(conf);
 	mddev->private = NULL;
 	pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
-	ret = -EIO;
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
+	return -EIO;
 }
 
 static void raid5_free(struct mddev *mddev, void *priv)
@@ -7838,7 +7820,6 @@ static void raid5_free(struct mddev *mddev, void *priv)
 	struct r5conf *conf = priv;
 
 	free_conf(conf);
-	acct_bioset_exit(mddev);
 	mddev->to_remove = &raid5_attrs_group;
 }
 
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index c10997e2271d..6691042cc421 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -880,6 +880,9 @@ static int get_resources(struct saa7164_dev *dev)
 		if (request_mem_region(pci_resource_start(dev->pci, 2),
 			pci_resource_len(dev->pci, 2), dev->name))
 			return 0;
+
+		release_mem_region(pci_resource_start(dev->pci, 0),
+				   pci_resource_len(dev->pci, 0));
 	}
 
 	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx or 0x%llx\n",
@@ -993,6 +996,9 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 		       dev->name, dev->pci->subsystem_vendor,
 		       dev->pci->subsystem_device);
 
+		mutex_lock(&devlist);
+		list_del(&dev->devlist);
+		mutex_unlock(&devlist);
 		saa7164_devcount--;
 		return -ENODEV;
 	}
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index fc9e6db3bb72..9a2acf5c4014 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -367,9 +367,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
 {
 	card->next_request = h_memstick_set_rw_addr;
 	memstick_new_req(card->host);
-	if (!wait_for_completion_timeout(&card->mrq_complete,
-			msecs_to_jiffies(500)))
-		card->current_mrq.error = -ETIMEDOUT;
+	wait_for_completion(&card->mrq_complete);
 
 	return card->current_mrq.error;
 }
@@ -403,9 +401,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
 
 		card->next_request = h_memstick_read_dev_id;
 		memstick_new_req(host);
-		if (!wait_for_completion_timeout(&card->mrq_complete,
-				msecs_to_jiffies(500)))
-			card->current_mrq.error = -ETIMEDOUT;
+		wait_for_completion(&card->mrq_complete);
 
 		if (card->current_mrq.error)
 			goto err_out;
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 43ec4948daa2..4c90bf886684 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -27,7 +27,6 @@ struct rtsx_usb_ms {
 	struct memstick_host	*msh;
 	struct memstick_request	*req;
 
-	struct mutex		host_mutex;
 	struct work_struct	handle_req;
 	struct delayed_work	poll_card;
 
@@ -511,6 +510,13 @@ static void rtsx_usb_ms_handle_req(struct work_struct *work)
 	struct memstick_host *msh = host->msh;
 	int rc;
 
+	/* Fail requests after eject so their waiters are released. */
+	if (host->eject) {
+		while (!memstick_next_req(msh, &host->req))
+			host->req->error = -ENOMEDIUM;
+		return;
+	}
+
 	if (!host->req) {
 		pm_runtime_get_sync(ms_dev(host));
 		do {
@@ -544,8 +550,7 @@ static void rtsx_usb_ms_request(struct memstick_host *msh)
 
 	dev_dbg(ms_dev(host), "--> %s\n", __func__);
 
-	if (!host->eject)
-		schedule_work(&host->handle_req);
+	schedule_work(&host->handle_req);
 }
 
 static int rtsx_usb_ms_set_param(struct memstick_host *msh,
@@ -778,7 +783,6 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 	host->power_mode = MEMSTICK_POWER_OFF;
 	platform_set_drvdata(pdev, host);
 
-	mutex_init(&host->host_mutex);
 	INIT_WORK(&host->handle_req, rtsx_usb_ms_handle_req);
 
 	INIT_DELAYED_WORK(&host->poll_card, rtsx_usb_ms_poll_card);
@@ -809,27 +813,12 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 {
 	struct rtsx_usb_ms *host = platform_get_drvdata(pdev);
 	struct memstick_host *msh = host->msh;
-	int err;
 
 	host->eject = true;
 	msh->removing = true;
-	cancel_work_sync(&host->handle_req);
+	flush_work(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
 
-	mutex_lock(&host->host_mutex);
-	if (host->req) {
-		dev_dbg(ms_dev(host),
-			"%s: Controller removed during transfer\n",
-			dev_name(&msh->dev));
-		host->req->error = -ENOMEDIUM;
-		do {
-			err = memstick_next_req(msh, &host->req);
-			if (!err)
-				host->req->error = -ENOMEDIUM;
-		} while (!err);
-	}
-	mutex_unlock(&host->host_mutex);
-
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal
 	 */
@@ -838,6 +827,8 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(ms_dev(host));
 	memstick_remove_host(msh);
+	/* No card, no new requests; wait for the last failed one to finish. */
+	cancel_work_sync(&host->handle_req);
 	dev_dbg(ms_dev(host),
 		": Realtek USB Memstick controller has been removed\n");
 	memstick_free_host(msh);
diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 12dca91a8ef6..ce55689ffe5c 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -300,9 +300,12 @@ static int octeon_mmc_remove(struct platform_device *pdev)
 	u64 dma_cfg;
 	int i;
 
-	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i])
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+	}
 
 	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
 	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 202b1d6da678..cba939b34341 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -173,9 +173,12 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	u64 dma_cfg;
 	int i;
 
-	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i])
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+	}
 
 	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
 	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 627159482d12..f857c2d410ce 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2702,6 +2702,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(mmc);
+	cancel_delayed_work_sync(&host->req_timeout);
 	msdc_deinit_hw(host);
 	msdc_gate_clock(host);
 
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 872d7f513c30..22ab92c7f917 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -743,6 +743,10 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 5bf508b6db0e..3ae8f005f8fe 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1208,6 +1208,10 @@ static void via_sd_remove(struct pci_dev *pcidev)
 
 	free_irq(pcidev->irq, sdhost);
 
+	cancel_work_sync(&sdhost->carddet_work);
+	/* carddet_work may re-enable the interrupt via via_reset_pcictrl(). */
+	writeb(0x0, sdhost->pcictrl_mmiobase + VIA_CRDR_PCIINTCTRL);
+
 	del_timer_sync(&sdhost->timer);
 
 	tasklet_kill(&sdhost->finish_tasklet);
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index c08721b11642..58ec5d0525ec 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -269,7 +269,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)dev->blkdev->bd_inode->i_size % erase_size) {
+	if (!erase_size || (long)dev->blkdev->bd_inode->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index f96a165fccc7..3667faefe6c5 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -720,7 +720,7 @@ static int vmu_can_unload(struct maple_device *mdev)
 	card = maple_get_drvdata(mdev);
 	for (x = 0; x < card->partitions; x++) {
 		mtd = &((card->mtd)[x]);
-		if (mtd->usecount > 0)
+		if (kref_read(&mtd->refcnt))
 			return 0;
 	}
 	return 1;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 16077e5a2df1..bfbb319ef33f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -92,10 +92,48 @@ static void mtd_release(struct device *dev)
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	dev_t index = MTD_DEVT(mtd->index);
 
+	idr_remove(&mtd_idr, mtd->index);
+	of_node_put(mtd_get_of_node(mtd));
+
+	if (mtd_is_partition(mtd))
+		release_mtd_partition(mtd);
+
 	/* remove /dev/mtdXro node */
 	device_destroy(&mtd_class, index + 1);
 }
 
+/*
+ * No-op device release used in add_mtd_device() error paths.
+ * Prevents mtd_release() from being called via device_release(),
+ * which would free the mtd_info that the caller still manages.
+ */
+static void mtd_dev_release_nop(struct device *dev)
+{
+}
+
+static void mtd_device_release(struct kref *kref)
+{
+	struct mtd_info *mtd = container_of(kref, struct mtd_info, refcnt);
+	bool is_partition = mtd_is_partition(mtd);
+
+	debugfs_remove_recursive(mtd->dbg.dfs_dir);
+
+	/* Try to remove the NVMEM provider */
+	nvmem_unregister(mtd->nvmem);
+
+	device_unregister(&mtd->dev);
+
+	/*
+	 *  Clear dev so mtd can be safely re-registered later if desired.
+	 *  Should not be done for partition,
+	 *  as it was already destroyed in device_unregister().
+	 */
+	if (!is_partition)
+		memset(&mtd->dev, 0, sizeof(mtd->dev));
+
+	module_put(THIS_MODULE);
+}
+
 #define MTD_DEVICE_ATTR_RO(name) \
 static DEVICE_ATTR(name, 0444, mtd_##name##_show, NULL)
 
@@ -623,7 +661,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	}
 
 	mtd->index = i;
-	mtd->usecount = 0;
+	kref_init(&mtd->refcnt);
 
 	/* default value if not set by driver */
 	if (mtd->bitflip_threshold == 0)
@@ -671,10 +709,8 @@ int add_mtd_device(struct mtd_info *mtd)
 	dev_set_drvdata(&mtd->dev, mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
-	if (error) {
-		put_device(&mtd->dev);
+	if (error)
 		goto fail_added;
-	}
 
 	/* Add the nvmem provider */
 	error = mtd_nvmem_add(mtd);
@@ -701,8 +737,16 @@ int add_mtd_device(struct mtd_info *mtd)
 	return 0;
 
 fail_nvmem_add:
-	device_unregister(&mtd->dev);
+	device_del(&mtd->dev);
 fail_added:
+	/*
+	 * Clear type and set nop release to prevent mtd_release() ->
+	 * release_mtd_partition() -> free_partition() from freeing mtd.
+	 * The caller handles cleanup on failure.
+	 */
+	mtd->dev.type = NULL;
+	mtd->dev.release = mtd_dev_release_nop;
+	put_device(&mtd->dev);
 	of_node_put(mtd_get_of_node(mtd));
 	idr_remove(&mtd_idr, i);
 fail_locked:
@@ -737,25 +781,8 @@ int del_mtd_device(struct mtd_info *mtd)
 	list_for_each_entry(not, &mtd_notifiers, list)
 		not->remove(mtd);
 
-	if (mtd->usecount) {
-		printk(KERN_NOTICE "Removing MTD device #%d (%s) with use count %d\n",
-		       mtd->index, mtd->name, mtd->usecount);
-		ret = -EBUSY;
-	} else {
-		debugfs_remove_recursive(mtd->dbg.dfs_dir);
-
-		/* Try to remove the NVMEM provider */
-		if (mtd->nvmem)
-			nvmem_unregister(mtd->nvmem);
-
-		device_unregister(&mtd->dev);
-
-		idr_remove(&mtd_idr, mtd->index);
-		of_node_put(mtd_get_of_node(mtd));
-
-		module_put(THIS_MODULE);
-		ret = 0;
-	}
+	kref_put(&mtd->refcnt, mtd_device_release);
+	ret = 0;
 
 out_error:
 	mutex_unlock(&mtd_table_mutex);
@@ -924,8 +951,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return 0;
 
 err:
-	if (mtd->otp_user_nvmem)
-		nvmem_unregister(mtd->otp_user_nvmem);
+	nvmem_unregister(mtd->otp_user_nvmem);
 	return err;
 }
 
@@ -1031,14 +1057,13 @@ int mtd_device_unregister(struct mtd_info *master)
 {
 	int err;
 
-	if (master->_reboot)
+	if (master->_reboot) {
 		unregister_reboot_notifier(&master->reboot_notifier);
+		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
+	}
 
-	if (master->otp_user_nvmem)
-		nvmem_unregister(master->otp_user_nvmem);
-
-	if (master->otp_factory_nvmem)
-		nvmem_unregister(master->otp_factory_nvmem);
+	nvmem_unregister(master->otp_user_nvmem);
+	nvmem_unregister(master->otp_factory_nvmem);
 
 	err = del_mtd_partitions(master);
 	if (err)
@@ -1153,25 +1178,27 @@ int __get_mtd_device(struct mtd_info *mtd)
 	struct mtd_info *master = mtd_get_master(mtd);
 	int err;
 
-	if (!try_module_get(master->owner))
-		return -ENODEV;
-
 	if (master->_get_device) {
-		err = master->_get_device(mtd);
-
-		if (err) {
-			module_put(master->owner);
+		err = master->_get_device(master);
+		if (err)
 			return err;
-		}
 	}
 
-	master->usecount++;
+	if (!try_module_get(master->owner)) {
+		if (master->_put_device)
+			master->_put_device(master);
+		return -ENODEV;
+	}
 
-	while (mtd->parent) {
-		mtd->usecount++;
+	while (mtd) {
+		if (mtd != master)
+			kref_get(&mtd->refcnt);
 		mtd = mtd->parent;
 	}
 
+	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+		kref_get(&master->refcnt);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__get_mtd_device);
@@ -1227,18 +1254,23 @@ void __put_mtd_device(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 
-	while (mtd->parent) {
-		--mtd->usecount;
-		BUG_ON(mtd->usecount < 0);
-		mtd = mtd->parent;
+	while (mtd) {
+		/* kref_put() can relese mtd, so keep a reference mtd->parent */
+		struct mtd_info *parent = mtd->parent;
+
+		if (mtd != master)
+			kref_put(&mtd->refcnt, mtd_device_release);
+		mtd = parent;
 	}
 
-	master->usecount--;
+	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+		kref_put(&master->refcnt, mtd_device_release);
+
+	module_put(master->owner);
 
+	/* must be the last as master can be freed in the _put_device */
 	if (master->_put_device)
 		master->_put_device(master);
-
-	module_put(master->owner);
 }
 EXPORT_SYMBOL_GPL(__put_mtd_device);
 
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b5eefeabf310..b014861a06a6 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -12,6 +12,7 @@ int __must_check add_mtd_device(struct mtd_info *mtd);
 int del_mtd_device(struct mtd_info *mtd);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
+void release_mtd_partition(struct mtd_info *mtd);
 
 struct mtd_partitions;
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 44384726aa44..63d8a5fff35e 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -31,6 +31,12 @@ static inline void free_partition(struct mtd_info *mtd)
 	kfree(mtd);
 }
 
+void release_mtd_partition(struct mtd_info *mtd)
+{
+	WARN_ON(!list_empty(&mtd->part.node));
+	free_partition(mtd);
+}
+
 static struct mtd_info *allocate_partition(struct mtd_info *parent,
 					   const struct mtd_partition *part,
 					   int partno, uint64_t cur_offset)
@@ -309,13 +315,11 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 
 	sysfs_remove_files(&mtd->dev.kobj, mtd_partition_attrs);
 
+	list_del_init(&mtd->part.node);
 	err = del_mtd_device(mtd);
 	if (err)
 		return err;
 
-	list_del(&mtd->part.node);
-	free_partition(mtd);
-
 	return 0;
 }
 
@@ -334,6 +338,7 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			__del_mtd_partitions(child);
 
 		pr_info("Deleting %s MTD partition\n", child->name);
+		list_del_init(&child->part.node);
 		ret = del_mtd_device(child);
 		if (ret < 0) {
 			pr_err("Error when deleting partition \"%s\" (%d)\n",
@@ -341,9 +346,6 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			err = ret;
 			continue;
 		}
-
-		list_del(&child->part.node);
-		free_partition(child);
 	}
 
 	return err;
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index e2c8de38cc93..74dccc4f846f 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2850,6 +2850,9 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		goto free_buf_desc;
 	}
 
+	spin_lock_init(&cdns_ctrl->irq_lock);
+	init_completion(&cdns_ctrl->complete);
+
 	if (devm_request_irq(cdns_ctrl->dev, cdns_ctrl->irq, cadence_nand_isr,
 			     IRQF_SHARED, "cadence-nand-controller",
 			     cdns_ctrl)) {
@@ -2858,9 +2861,6 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		goto free_buf;
 	}
 
-	spin_lock_init(&cdns_ctrl->irq_lock);
-	init_completion(&cdns_ctrl->complete);
-
 	ret = cadence_nand_hw_init(cdns_ctrl);
 	if (ret)
 		goto disable_irq;
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 40d70f991d89..4e536e53df9b 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -504,6 +504,11 @@ static int vf610_nfc_exec_op(struct nand_chip *chip,
 				      check_only);
 }
 
+static unsigned int vf610_nfc_spare_size(struct mtd_info *mtd)
+{
+	return min_t(unsigned int, mtd->oobsize, 64);
+}
+
 static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 					 uint8_t *oob, int page)
 {
@@ -513,6 +518,7 @@ static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 	u8 ecc_status;
 	u8 ecc_count;
 	int flips_threshold = nfc->chip.ecc.strength / 2;
+	int ret;
 
 	ecc_status = vf610_nfc_read(nfc, ecc_status_off) & 0xff;
 	ecc_count = ecc_status & ECC_STATUS_ERR_COUNT;
@@ -520,16 +526,22 @@ static inline int vf610_nfc_correct_data(struct nand_chip *chip, uint8_t *dat,
 	if (!(ecc_status & ECC_STATUS_MASK))
 		return ecc_count;
 
+	/* The failed decode leaves a bogus correction in SRAM; re-read without ECC */
 	nfc->data_access = true;
-	nand_read_oob_op(&nfc->chip, page, 0, oob, mtd->oobsize);
+	ret = nand_read_page_op(&nfc->chip, page, 0, dat, mtd->writesize);
+	if (!ret)
+		ret = nand_read_oob_op(&nfc->chip, page, 0, oob,
+				       vf610_nfc_spare_size(mtd));
 	nfc->data_access = false;
+	if (ret)
+		return ret;
 
 	/*
-	 * On an erased page, bit count (including OOB) should be zero or
-	 * at least less then half of the ECC strength.
+	 * Run the erased-page check with the driver's historic threshold
+	 * of half the ECC strength.
 	 */
-	return nand_check_erased_ecc_chunk(dat, nfc->chip.ecc.size, oob,
-					   mtd->oobsize, NULL, 0,
+	return nand_check_erased_ecc_chunk(dat, mtd->writesize, oob,
+					   vf610_nfc_spare_size(mtd), NULL, 0,
 					   flips_threshold);
 }
 
@@ -550,7 +562,7 @@ static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
 {
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	int trfr_sz = mtd->writesize + mtd->oobsize;
+	int trfr_sz = mtd->writesize + vf610_nfc_spare_size(mtd);
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	int stat;
 
@@ -576,11 +588,16 @@ static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
 	 */
 	vf610_nfc_rd_from_sram(buf, nfc->regs + NFC_MAIN_AREA(0),
 			       mtd->writesize, false);
-	if (oob_required)
+	if (oob_required) {
+		unsigned int spare = vf610_nfc_spare_size(mtd);
+
 		vf610_nfc_rd_from_sram(chip->oob_poi,
 				       nfc->regs + NFC_MAIN_AREA(0) +
 						   mtd->writesize,
-				       mtd->oobsize, false);
+				       spare, false);
+		/* Not transferred, and never written: reads back erased */
+		memset(chip->oob_poi + spare, 0xff, mtd->oobsize - spare);
+	}
 
 	stat = vf610_nfc_correct_data(chip, buf, chip->oob_poi, page);
 
@@ -598,7 +615,7 @@ static int vf610_nfc_write_page(struct nand_chip *chip, const uint8_t *buf,
 {
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	int trfr_sz = mtd->writesize + mtd->oobsize;
+	int trfr_sz = mtd->writesize + vf610_nfc_spare_size(mtd);
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	u8 status;
 	int ret;
@@ -739,6 +756,49 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
 	}
 }
 
+/*
+ * With 64 byte OOB chips the core's large page layout matches what
+ * U-Boot uses, and on chips with more, U-Boot and older kernels clamped
+ * mtd->oobsize to 64. Modifying the OOB size is no longer possible, the
+ * actual chip geometry must be respected, so to avoid breaking those
+ * existing setups use our own layout: the core's large page one,
+ * computed over the first 64 spare bytes only.
+ */
+static int vf610_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	unsigned int total_ecc_bytes = nand->ecc.ctx.total;
+
+	if (section || !total_ecc_bytes)
+		return -ERANGE;
+
+	oobregion->length = total_ecc_bytes;
+	oobregion->offset = vf610_nfc_spare_size(mtd) - oobregion->length;
+
+	return 0;
+}
+
+static int vf610_nfc_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	unsigned int total_ecc_bytes = nand->ecc.ctx.total;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = vf610_nfc_spare_size(mtd) - total_ecc_bytes - 2;
+	oobregion->offset = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops vf610_nfc_ooblayout_ops = {
+	.ecc = vf610_nfc_ooblayout_ecc,
+	.free = vf610_nfc_ooblayout_free,
+};
+
 static int vf610_nfc_attach_chip(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -769,12 +829,7 @@ static int vf610_nfc_attach_chip(struct nand_chip *chip)
 		return -ENXIO;
 	}
 
-	/* Only 64 byte ECC layouts known */
-	if (mtd->oobsize > 64)
-		mtd->oobsize = 64;
-
-	/* Use default large page ECC layout defined in NAND core */
-	mtd_set_ooblayout(mtd, nand_get_large_page_ooblayout());
+	mtd_set_ooblayout(mtd, &vf610_nfc_ooblayout_ops);
 	if (chip->ecc.strength == 32) {
 		nfc->ecc_mode = ECC_60_BYTE;
 		chip->ecc.bytes = 60;
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8292c1c18b70..ef8b0d9accb9 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -179,7 +179,10 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
 	bool enable = false;
+	int ret;
 
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
@@ -189,8 +192,22 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 	    spinand->op_templates.update_cache->data.buswidth == 4)
 		enable = true;
 
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
+
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,
@@ -1241,12 +1258,17 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 	mtd->_resume = spinand_mtd_resume;
 
-	if (nand->ecc.engine) {
-		ret = mtd_ooblayout_count_freebytes(mtd);
-		if (ret < 0)
-			goto err_cleanup_ecc_engine;
+	if (!nand->ecc.engine) {
+		if (spinand->eccinfo.ooblayout)
+			mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+		else
+			mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
 	}
 
+	ret = mtd_ooblayout_count_freebytes(mtd);
+	if (ret < 0)
+		goto err_cleanup_ecc_engine;
+
 	mtd->oobavail = ret;
 
 	/* Propagate ECC information to mtd_info */
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b74732d2924b..12dc1d3c6e2b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4915,35 +4915,36 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 				       struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *slave = NULL;
+	struct slave *slave = NULL, *last = NULL;
 	struct list_head *iter;
 	bool xmit_suc = false;
-	bool skb_used = false;
 
+	/* The slave list can change under us during the RCU walk, so which
+	 * slave is "last" is only known once the walk is over: clone for
+	 * every up slave but the last one seen, then hand the original skb
+	 * to that one after the loop.
+	 */
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
-			skb2 = skb;
-			skb_used = true;
-		} else {
+		if (last) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
-			if (!skb2) {
+			if (!skb2)
 				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
 						    bond_dev->name, __func__);
-				continue;
-			}
+			else if (bond_dev_queue_xmit(bond, skb2, last->dev) == NETDEV_TX_OK)
+				xmit_suc = true;
 		}
-
-		if (bond_dev_queue_xmit(bond, skb2, slave->dev) == NETDEV_TX_OK)
-			xmit_suc = true;
+		last = slave;
 	}
 
-	if (!skb_used)
+	if (!last)
 		dev_kfree_skb_any(skb);
+	else if (bond_dev_queue_xmit(bond, skb, last->dev) == NETDEV_TX_OK)
+		xmit_suc = true;
 
 	if (xmit_suc)
 		return NETDEV_TX_OK;
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index ec624cfc1b07..e59d5cbb644a 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -203,6 +203,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
@@ -233,6 +234,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 0b2403e9853e..012da4b8abe0 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -213,6 +213,7 @@ static void slc_bump(struct slcan *sl)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, &cf, sizeof(struct can_frame));
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 276f6a8631fb..a7b98c0b5f28 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -763,25 +763,16 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 
 		if (comp_ctx->status == ENA_CMD_COMPLETED) {
 			netdev_err(admin_queue->ena_dev->net_device,
-				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				   comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
-			/* Check if fallback to polling is enabled */
-			if (admin_queue->auto_polling)
-				admin_queue->polling = true;
+				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d)\n",
+				   comp_ctx->cmd_opcode);
 		} else {
 			netdev_err(admin_queue->ena_dev->net_device,
 				   "The ena device didn't send a completion for the admin cmd %d status %d\n",
 				   comp_ctx->cmd_opcode, comp_ctx->status);
 		}
-		/* Check if shifted to polling mode.
-		 * This will happen if there is a completion without an interrupt
-		 * and autopolling mode is enabled. Continuing normal execution in such case
-		 */
-		if (!admin_queue->polling) {
-			admin_queue->running_state = false;
-			ret = -ETIME;
-			goto err;
-		}
+		admin_queue->running_state = false;
+		ret = -ETIME;
+		goto err;
 	}
 
 	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
@@ -1658,12 +1649,6 @@ void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling)
 	ena_dev->admin_queue.polling = polling;
 }
 
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling)
-{
-	ena_dev->admin_queue.auto_polling = polling;
-}
-
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 3c5081d9d25d..bb33fe209eec 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -227,9 +227,6 @@ struct ena_com_admin_queue {
 	/* Indicate if the admin queue should poll for completion */
 	bool polling;
 
-	/* Define if fallback to polling mode should occur */
-	bool auto_polling;
-
 	u16 curr_cmd_id;
 
 	/* Indicate that the ena was initialized and can
@@ -484,17 +481,6 @@ bool ena_com_get_admin_running_state(struct ena_com_dev *ena_dev);
  */
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling);
 
-/* ena_com_set_admin_auto_polling_mode - Enable autoswitch to polling mode
- * @ena_dev: ENA communication layer struct
- * @polling: Enable/Disable polling mode
- *
- * Set the autopolling mode.
- * If autopolling is on:
- * In case of missing interrupt when data is available switch to polling.
- */
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling);
-
 /* ena_com_admin_q_comp_intr_handler - admin queue interrupt handler
  * @ena_dev: ENA communication layer struct
  *
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index be030e50ecb7..5831f7bd81c2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4517,6 +4517,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index fa140c5175a6..055ab74d861b 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -422,8 +422,10 @@ static void bcm_sysport_update_mib_counters(struct bcm_sysport_priv *priv)
 			if (priv->is_lite)
 				continue;
 
-			if (s->type != BCM_SYSPORT_STAT_MIB_RX)
+			if (s->type == BCM_SYSPORT_STAT_MIB_TX)
 				offset = UMAC_MIB_STAT_OFFSET;
+			else if (s->type == BCM_SYSPORT_STAT_RUNT)
+				offset = 2 * UMAC_MIB_STAT_OFFSET;
 			val = umac_readl(priv, UMAC_MIB_START + j + offset);
 			break;
 		case BCM_SYSPORT_STAT_RXCHK:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9ea0d6e78ca6..8fb7b9823270 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -439,7 +439,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq;
 	int i;
 	dma_addr_t mapping;
-	unsigned int length, pad = 0;
+	unsigned int length;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
 	u16 prod, last_frag;
 	struct pci_dev *pdev = bp->pdev;
@@ -458,6 +458,14 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
 	prod = txr->tx_prod;
 
+	/* Must be done before skb_shinfo(skb)->nr_frags is sampled,
+	 * because skb_put_padto() might linearize the skb.
+	 */
+	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
+		/* SKB already freed. */
+		goto tx_kick_pending;
+	}
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
@@ -586,14 +594,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 normal_tx:
-	if (length < BNXT_MIN_PKT_SIZE) {
-		pad = BNXT_MIN_PKT_SIZE - length;
-		if (skb_pad(skb, pad))
-			/* SKB already freed. */
-			goto tx_kick_pending;
-		length = BNXT_MIN_PKT_SIZE;
-	}
-
 	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
 	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
@@ -668,10 +668,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 	}
 
-	flags &= ~TX_BD_LEN;
-	txbd->tx_bd_len_flags_type =
-		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
-			    TX_BD_FLAGS_PACKET_END);
+	txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);
 
 	netdev_tx_sent_queue(txq, skb->len);
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index a3b6b9af0b05..437a87b1ed4f 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3745,9 +3745,11 @@ bnad_pci_probe(struct pci_dev *pdev,
 	bnad_res_free(bnad, &bnad->mod_res_info[0], BNA_MOD_RES_T_MAX);
 disable_ioceth:
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	/* The IOC timers rearm one another.  Shut down all of them. */
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.iocpf_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
@@ -3788,9 +3790,11 @@ bnad_pci_remove(struct pci_dev *pdev)
 
 	mutex_lock(&bnad->conf_mutex);
 	bnad_ioceth_disable(bnad);
-	del_timer_sync(&bnad->bna.ioceth.ioc.ioc_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.sem_timer);
-	del_timer_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	/* The IOC timers rearm one another.  Shut down all of them. */
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.ioc_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.sem_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.hb_timer);
+	timer_shutdown_sync(&bnad->bna.ioceth.ioc.iocpf_timer);
 	spin_lock_irqsave(&bnad->bna_lock, flags);
 	bna_uninit(bna);
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 59683f79959c..1bf0079f909b 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -390,7 +390,7 @@ static void chcr_ktls_dev_del(struct net_device *netdev,
 		cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 				 tx_info->tid, tx_info->ip_family);
 
-		xa_erase(&u_ctx->tid_list, tx_info->tid);
+		xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
 	}
 
 	port_stats = &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port_id];
@@ -581,7 +581,7 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
 			 tx_info->tid, tx_info->ip_family);
 
-	xa_erase(&u_ctx->tid_list, tx_info->tid);
+	xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
 
 put_module:
 	/* release module refcount */
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index f16449735a99..4e2b9e0eeaa2 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -597,10 +597,6 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc != 0) {
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
-		do {
-			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
 		goto out_free_buffer_pools;
 	}
 
@@ -632,6 +628,9 @@ static int ibmveth_open(struct net_device *netdev)
 out_free_irq:
 	free_irq(netdev->irq, netdev);
 out_free_buffer_pools:
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	while (--i >= 0) {
 		if (adapter->rx_buff_pool[i].active)
 			ibmveth_free_buffer_pool(adapter,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b4a0af5a1ef0..129ffaa20956 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -704,10 +704,12 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 		} while (!last_wqe);
 	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
-	sq->cc = sqcc;
-
 	mlx5_cqwq_update_db_record(&cq->wq);
 
+	/* ensure cq space is freed before enabling more cqes */
+	dma_wmb();
+
+	sq->cc = sqcc;
 	return i;
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 99927adcb37a..d38def0f2d53 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -82,6 +83,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static void pdp_context_delete(struct pdp_ctx *pctx);
 
@@ -109,7 +111,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
 			return pdp;
@@ -125,7 +128,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
 			return pdp;
@@ -141,7 +145,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms_addr_ip4.s_addr == ms_addr)
 			return pdp;
@@ -722,9 +727,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -1112,6 +1119,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
@@ -1119,6 +1127,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, GFP_KERNEL);
 		err = 0;
 	}
+	mutex_unlock(&gtp_pdp_lock);
 
 out_unlock:
 	rtnl_unlock();
@@ -1173,6 +1182,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -1193,6 +1204,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index af5dbdd8f138..8c9b56c40f70 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -535,21 +535,23 @@ static void team_adjust_ops(struct team *team)
 
 	if (!team->en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
-		team->ops.transmit = team_dummy_transmit;
+		WRITE_ONCE(team->ops.transmit, team_dummy_transmit);
 	else
-		team->ops.transmit = team->mode->ops->transmit;
+		WRITE_ONCE(team->ops.transmit, team->mode->ops->transmit);
 
 	if (!team->en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
-		team->ops.receive = team_dummy_receive;
+		WRITE_ONCE(team->ops.receive, team_dummy_receive);
 	else
-		team->ops.receive = team->mode->ops->receive;
+		WRITE_ONCE(team->ops.receive, team->mode->ops->receive);
 }
 
 /*
- * We can benefit from the fact that it's ensured no port is present
- * at the time of mode change. Therefore no packets are in fly so there's no
- * need to set mode operations in any special way.
+ * team_change_mode() ensures no ports are present during mode change,
+ * but lockless readers can still reach team_xmit().  Avoid touching
+ * transmit/receive -- they are already set to dummies by
+ * team_adjust_ops() since no ports are enabled.  synchronize_net()
+ * drains in-flight readers before destroying old mode state.
  */
 static int __team_change_mode(struct team *team,
 			      const struct team_mode *new_mode)
@@ -558,9 +560,21 @@ static int __team_change_mode(struct team *team,
 	if (team_is_mode_set(team)) {
 		void (*exit_op)(struct team *team) = team->ops.exit;
 
-		/* Clear ops area so no callback is called any longer */
-		memset(&team->ops, 0, sizeof(struct team_mode_ops));
-		team_adjust_ops(team);
+		/* Clear cold-path ops used only under RTNL.  transmit and
+		 * receive are already dummies (no ports) so leave them
+		 * alone -- overwriting them is the source of the race.
+		 */
+		team->ops.init = NULL;
+		team->ops.exit = NULL;
+		team->ops.port_enter = NULL;
+		team->ops.port_leave = NULL;
+		team->ops.port_change_dev_addr = NULL;
+		team->ops.port_tx_disabled = NULL;
+
+		/* Wait for in-flight readers before tearing down mode
+		 * state they may reference.
+		 */
+		synchronize_net();
 
 		if (exit_op)
 			exit_op(team);
@@ -583,7 +597,12 @@ static int __team_change_mode(struct team *team,
 	}
 
 	team->mode = new_mode;
-	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
+	team->ops.init = new_mode->ops->init;
+	team->ops.exit = new_mode->ops->exit;
+	team->ops.port_enter = new_mode->ops->port_enter;
+	team->ops.port_leave = new_mode->ops->port_leave;
+	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
+	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
 	team_adjust_ops(team);
 
 	return 0;
@@ -739,7 +758,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 		/* allow exact match delivery for disabled ports */
 		res = RX_HANDLER_EXACT;
 	} else {
-		res = team->ops.receive(team, port, skb);
+		res = READ_ONCE(team->ops.receive)(team, port, skb);
 	}
 	if (res == RX_HANDLER_ANOTHER) {
 		struct team_pcpu_stats *pcpu_stats;
@@ -798,7 +817,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -806,11 +826,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 	if (!team->queue_override_enabled || !skb->queue_mapping)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
-	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
-	}
-	return false;
+	port = list_first_or_null_rcu(qom_list, struct team_port, qom_list);
+	if (!port)
+		return false;
+	*tx_success = !team_dev_queue_xmit(team, port, skb);
+	return true;
 }
 
 static void __team_queue_override_port_del(struct team *team,
@@ -940,8 +960,6 @@ static void team_port_enable(struct team *team,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
-	if (team->ops.port_enabled)
-		team->ops.port_enabled(team, port);
 	team_notify_peers(team);
 	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
@@ -966,8 +984,8 @@ static void team_port_disable(struct team *team,
 {
 	if (!team_port_enabled(port))
 		return;
-	if (team->ops.port_disabled)
-		team->ops.port_disabled(team, port);
+	if (team->ops.port_tx_disabled)
+		team->ops.port_tx_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
 	port->index = -1;
@@ -1737,9 +1755,8 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+	if (!team_queue_override_transmit(team, skb, &tx_success))
+		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index b095a4b4957b..89ee6bee049c 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -672,7 +672,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -682,7 +682,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 2d6b8fddb9d4..ea38555b4933 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1483,11 +1483,11 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 1;
 		}
 
-		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len - 2);
 		if (!ax_skb)
 			return 0;
-		skb_put(ax_skb, pkt_len);
-		memcpy(ax_skb->data, skb->data + 2, pkt_len);
+		skb_put(ax_skb, pkt_len - 2);
+		memcpy(ax_skb->data, skb->data + 2, pkt_len - 2);
 
 		ax88179_rx_checksum(ax_skb, pkt_hdr);
 		usbnet_skb_return(dev, ax_skb);
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3f9ebf20fe7e..3675f4f5db13 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1090,6 +1090,7 @@ static const struct usb_device_id products[] = {
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0122)},	/* Quectel RG650V */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
+	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x030b)},	/* Quectel EM060K/EG120K-EA */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0620)},	/* Quectel EM160R-GL */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0800)},	/* Quectel RM500Q-GL */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c1ee03aebed5..162a329be447 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -791,12 +791,16 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
 	int flush = 1;
-	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
+	struct vxlan_sock *vs;
 	__be32 flags;
 	struct gro_remcsum grc;
 
 	skb_gro_remcsum_init(&grc);
 
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		goto out;
+
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh   = skb_gro_header_fast(skb, off_vx);
@@ -2086,13 +2090,15 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	struct ipv6hdr *pip6;
 	u8 *daddr;
 	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int headroom;
 	int ns_olen;
 	int i, len;
 
 	if (dev == NULL || !pskb_may_pull(request, request->len))
 		return NULL;
 
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+	headroom = LL_RESERVED_SPACE(dev);
+	len = headroom + sizeof(struct ipv6hdr) +
 		sizeof(*na) + na_olen + dev->needed_tailroom;
 	reply = alloc_skb(len, GFP_ATOMIC);
 	if (reply == NULL)
@@ -2100,7 +2106,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 
 	reply->protocol = htons(ETH_P_IPV6);
 	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(request->dev));
+	skb_reserve(reply, headroom);
 	skb_push(reply, sizeof(struct ethhdr));
 	skb_reset_mac_header(reply);
 
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 720952b92e78..bccaaca66e67 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -784,10 +784,11 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
 
 	/* Success! Copy everything to peer */
 	down_write(&handshake->lock);
-	/* It's important to check that the state is still the same, while we
-	 * have an exclusive lock.
+	/* Check that the state is the same and that this is still the
+	 * initiation we started with, while we have an exclusive lock.
 	 */
-	if (handshake->state != state) {
+	if (handshake->state != state ||
+	    crypto_memneq(handshake->ephemeral_private, ephemeral_private, NOISE_PUBLIC_KEY_LEN)) {
 		up_write(&handshake->lock);
 		goto fail;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 81a8e1102d72..a13252fd16b8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4500,6 +4500,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
 	ar->num_peers = 0;
+	ar->num_stations = 0;
 	ar->allocated_vdev_map = 0;
 
 	/* Configure monitor status ring with default rx_filter to get rx status
diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index e1a35c2eadb6..f3d850edbdbc 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1007,7 +1007,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	del_timer(&wcn->tx_ack_timer);
+	timer_shutdown_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a778e3e0599e..6ab91ff8338c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3174,6 +3174,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_GTK_OFFLOAD_GETINFO_RSP:
 	case WCN36XX_HAL_HOST_RESUME_RSP:
 	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 860376037265..26c02ec7557d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1481,8 +1481,31 @@ void brcmf_detach(struct device *dev)
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
 	/* make sure primary interface removed last */
 	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
-		if (drvr->iflist[i])
-			brcmf_remove_interface(drvr->iflist[i], false);
+		struct brcmf_if *ifp = drvr->iflist[i];
+
+		if (!ifp)
+			continue;
+
+		if (ifp->ndev) {
+			brcmf_remove_interface(ifp, false);
+			continue;
+		}
+
+		/* The P2P device interface has no netdev. Its removal can
+		 * race with NL80211_CMD_DEL_INTERFACE issued by a user space
+		 * process that is exiting (e.g. wpa_supplicant), which ends
+		 * in brcmf_p2p_del_vif() under RTNL and the wiphy mutex. If
+		 * both paths remove the interface, the wdev is unregistered
+		 * twice and the vif is used after being freed. Take the same
+		 * locks and re-read iflist, so only one path removes it.
+		 */
+		rtnl_lock();
+		wiphy_lock(drvr->wiphy);
+		ifp = drvr->iflist[i];
+		if (ifp)
+			brcmf_remove_interface(ifp, true);
+		wiphy_unlock(drvr->wiphy);
+		rtnl_unlock();
 	}
 	brcmf_bus_stop(drvr->bus_if);
 
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 1f2d089e1fdf..8a73124b9927 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3845,6 +3845,7 @@ il3945_pci_remove(struct pci_dev *pdev)
 
 	il_free_channel_map(il);
 	il_free_geos(il);
+	il_eeprom_free(il);
 	kfree(il->scan_cmd);
 	dev_kfree_skb(il->beacon_skb);
 	ieee80211_free_hw(il->hw);
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index 459c35912d76..553deea6af3a 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -52,6 +52,13 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 		u32 code = le32_to_cpu(bootrec->code);
 		switch (code) {
 		case BR_CODE_COMPONENT_ID:
+			if (len < sizeof(struct bootrec_comp_id) /
+				sizeof(*bootrec->data)) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component ID is too short\n");
+				return -EINVAL;
+			}
+
 			priv->fw_interface = be32_to_cpup((__be32 *)
 					     bootrec->data);
 			switch (priv->fw_interface) {
@@ -72,16 +79,41 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 			}
 			break;
 		case BR_CODE_COMPONENT_VERSION:
+			if (len < DIV_ROUND_UP(sizeof(struct bootrec_comp_ver),
+					       sizeof(*bootrec->data))) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component version is too short\n");
+				return -EINVAL;
+			}
+
 			/* 24 bytes should be enough for all firmwares */
-			if (strnlen((unsigned char *) bootrec->data, 24) < 24)
-				fw_version = (unsigned char *) bootrec->data;
+			if (strnlen((unsigned char *)bootrec->data,
+				    sizeof(struct bootrec_comp_ver)) <
+				    sizeof(struct bootrec_comp_ver))
+				fw_version = (unsigned char *)bootrec->data;
 			break;
 		case BR_CODE_DESCR: {
 			struct bootrec_desc *desc =
 				(struct bootrec_desc *)bootrec->data;
-			priv->rx_start = le32_to_cpu(desc->rx_start);
-			/* FIXME add sanity checking */
-			priv->rx_end = le32_to_cpu(desc->rx_end) - 0x3500;
+			u32 rx_start, rx_end;
+
+			/* 0xa is the shortest descriptor in supported firmware. */
+			if (len < 0xa) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor is too short\n");
+				return -EINVAL;
+			}
+
+			rx_start = le32_to_cpu(desc->rx_start);
+			rx_end = le32_to_cpu(desc->rx_end);
+			if (rx_end < 0x3500 || rx_end - 0x3500 <= rx_start) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor has invalid RX range\n");
+				return -EINVAL;
+			}
+
+			priv->rx_start = rx_start;
+			priv->rx_end = rx_end - 0x3500;
 			priv->headroom = desc->headroom;
 			priv->tailroom = desc->tailroom;
 			priv->privacy_caps = desc->privacy_caps;
diff --git a/drivers/net/wireless/marvell/libertas/tx.c b/drivers/net/wireless/marvell/libertas/tx.c
index d56969920506..aeb481740df6 100644
--- a/drivers/net/wireless/marvell/libertas/tx.c
+++ b/drivers/net/wireless/marvell/libertas/tx.c
@@ -116,13 +116,6 @@ netdev_tx_t lbs_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->wdev->iftype == NL80211_IFTYPE_MONITOR) {
 		struct tx_radiotap_hdr *rtap_hdr = (void *)skb->data;
 
-		if (skb->len < sizeof(*rtap_hdr) + 4 + ETH_ALEN) {
-			lbs_deb_tx("tx err: short monitor frame %u\n", skb->len);
-			dev->stats.tx_dropped++;
-			dev->stats.tx_errors++;
-			goto free;
-		}
-
 		/* set txpd fields from the radiotap header */
 		txpd->tx_control = cpu_to_le32(convert_radiotap_rate_to_mv(rtap_hdr->rate));
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9bcc137da20f..526491b1ec08 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5171,14 +5171,19 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 {
 	struct sk_buff *skb;
 	unsigned long flags;
-	int pending = 0;
 
 	spin_lock_irqsave(&priv->rx_urb_lock, flags);
 
 	if (!priv->shutdown) {
 		list_add_tail(&rx_urb->list, &priv->rx_urb_pending_list);
 		priv->rx_urb_pending_count++;
-		pending = priv->rx_urb_pending_count;
+		/*
+		 * Arm the worker under rx_urb_lock so this is atomic with the
+		 * shutdown check: moving it out of the lock would let a
+		 * completion arm the work after rtl8xxxu_stop() canceled it.
+		 */
+		if (priv->rx_urb_pending_count > RTL8XXXU_RX_URB_PENDING_WATER)
+			schedule_work(&priv->rx_urb_wq);
 	} else {
 		skb = (struct sk_buff *)rx_urb->urb.context;
 		dev_kfree_skb_irq(skb);
@@ -5186,9 +5191,6 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
 	}
 
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
-
-	if (pending > RTL8XXXU_RX_URB_PENDING_WATER)
-		schedule_work(&priv->rx_urb_wq);
 }
 
 static void rtl8xxxu_rx_urb_work(struct work_struct *work)
@@ -6465,6 +6467,13 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	priv->shutdown = true;
 	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
 
+	/*
+	 * Cancel before killing rx_anchor: the worker re-anchors every URB
+	 * it drained via rtl8xxxu_submit_rx_urb(), so a worker still running
+	 * after the kill could submit a URB that escapes it.
+	 */
+	cancel_work_sync(&priv->rx_urb_wq);
+
 	usb_kill_anchored_urbs(&priv->rx_anchor);
 	usb_kill_anchored_urbs(&priv->tx_anchor);
 	if (priv->usb_interrupts)
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index cbb95682d21b..91310368e012 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -349,6 +349,7 @@ static int cw1200_bh_tx_helper(struct cw1200_common *priv,
 			       int *tx_burst)
 {
 	size_t tx_len;
+	size_t aligned_len;
 	u8 *data;
 	int ret;
 	struct wsm_hdr *wsm;
@@ -381,9 +382,14 @@ static int cw1200_bh_tx_helper(struct cw1200_common *priv,
 
 	atomic_inc(&priv->bh_tx);
 
-	tx_len = priv->hwbus_ops->align_size(
+	aligned_len = priv->hwbus_ops->align_size(
 		priv->hwbus_priv, tx_len);
 
+	/* Zero the bus alignment padding so no stale data is sent. */
+	if (aligned_len > tx_len)
+		memset(data + tx_len, 0, aligned_len - tx_len);
+	tx_len = aligned_len;
+
 	/* Check if not exceeding CW1200 capabilities */
 	if (WARN_ON_ONCE(tx_len > EFFECTIVE_BUF_SIZE))
 		pr_debug("Write aligned len: %zu\n", tx_len);
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index 9c998f4ac4a9..f3d937b3bb4b 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -14,6 +14,7 @@
 #include "wsm.h"
 #include "bh.h"
 #include "sta.h"
+#include "hwbus.h"
 #include "debug.h"
 
 #define CW1200_INVALID_RATE_ID (0xFF)
@@ -716,6 +717,7 @@ void cw1200_tx(struct ieee80211_hw *dev,
 	struct ieee80211_sta *sta;
 	struct wsm_tx *wsm;
 	bool tid_update = false;
+	size_t pad_len;
 	u8 flags = 0;
 	int ret;
 
@@ -765,6 +767,18 @@ void cw1200_tx(struct ieee80211_hw *dev,
 	rcu_read_lock();
 	sta = rcu_dereference(t.sta);
 
+	/*
+	 * The bus transfer is padded up to the bus alignment and the
+	 * padding is transferred from the frame buffer.  Make sure the
+	 * buffer has room for the padding so the device never receives
+	 * data past the end of the frame.
+	 */
+	pad_len = priv->hwbus_ops->align_size(priv->hwbus_priv, skb->len) -
+		skb->len;
+	if (skb_tailroom(skb) < pad_len &&
+	    pskb_expand_head(skb, 0, pad_len, GFP_ATOMIC))
+		goto drop;
+
 	spin_lock_bh(&priv->ps_state_lock);
 	{
 		tid_update = cw1200_tx_h_pm_state(priv, &t);
diff --git a/drivers/net/wireless/ti/wl12xx/main.c b/drivers/net/wireless/ti/wl12xx/main.c
index c6da0cfb4afb..de045fe4ca1e 100644
--- a/drivers/net/wireless/ti/wl12xx/main.c
+++ b/drivers/net/wireless/ti/wl12xx/main.c
@@ -1919,19 +1919,16 @@ static int wl12xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wl12xx_remove(struct platform_device *pdev)
+static void wl12xx_remove(struct platform_device *pdev)
 {
 	struct wl1271 *wl = platform_get_drvdata(pdev);
 	struct wl12xx_priv *priv;
 
-	if (!wl)
-		goto out;
 	priv = wl->priv;
 
 	kfree(priv->rx_mem_addr);
 
-out:
-	return wlcore_remove(pdev);
+	wlcore_remove(pdev);
 }
 
 static const struct platform_device_id wl12xx_id_table[] = {
@@ -1942,7 +1939,7 @@ MODULE_DEVICE_TABLE(platform, wl12xx_id_table);
 
 static struct platform_driver wl12xx_driver = {
 	.probe		= wl12xx_probe,
-	.remove		= wl12xx_remove,
+	.remove_new	= wl12xx_remove,
 	.id_table	= wl12xx_id_table,
 	.driver = {
 		.name	= "wl12xx_driver",
diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 0b3cf8477c6c..d4a89401f2c4 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -2033,7 +2033,7 @@ MODULE_DEVICE_TABLE(platform, wl18xx_id_table);
 
 static struct platform_driver wl18xx_driver = {
 	.probe		= wl18xx_probe,
-	.remove		= wlcore_remove,
+	.remove_new	= wlcore_remove,
 	.id_table	= wl18xx_id_table,
 	.driver = {
 		.name	= "wl18xx_driver",
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 9856d92f84a4..e4ac9c0a7bbb 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6803,7 +6803,7 @@ int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(wlcore_probe);
 
-int wlcore_remove(struct platform_device *pdev)
+void wlcore_remove(struct platform_device *pdev)
 {
 	struct wlcore_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
 	struct wl1271 *wl = platform_get_drvdata(pdev);
@@ -6817,8 +6817,10 @@ int wlcore_remove(struct platform_device *pdev)
 
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
-	if (!wl->initialized)
-		return 0;
+	if (!wl->initialized) {
+		pm_runtime_put_noidle(wl->dev);
+		return;
+	}
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);
@@ -6838,8 +6840,6 @@ int wlcore_remove(struct platform_device *pdev)
 
 	free_irq(wl->irq, wl);
 	wlcore_free_hw(wl);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(wlcore_remove);
 
diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
index 81c94d390623..1f8511bf9bb3 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
@@ -497,7 +497,7 @@ struct wl1271 {
 };
 
 int wlcore_probe(struct wl1271 *wl, struct platform_device *pdev);
-int wlcore_remove(struct platform_device *pdev);
+void wlcore_remove(struct platform_device *pdev);
 struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 				     u32 mbox_size);
 int wlcore_free_hw(struct wl1271 *wl);
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 4b19d54fa2e2..2ad6bcd965e4 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1228,8 +1228,16 @@ static int handle_incoming_queue(struct netfront_queue *queue,
 	while ((skb = __skb_dequeue(rxq)) != NULL) {
 		int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
-		if (pull_to > skb_headlen(skb))
-			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
+		/* pull_to comes from the first slot's length, which the
+		 * backend controls.  Make sure the head holds at least an
+		 * Ethernet header for eth_type_trans().
+		 */
+		if (!pskb_may_pull(skb, max(pull_to, ETH_HLEN))) {
+			kfree_skb(skb);
+			packets_dropped++;
+			queue->info->netdev->stats.rx_errors++;
+			continue;
+		}
 
 		/* Ethernet work: Delayed to here as it peeks the header. */
 		skb->protocol = eth_type_trans(skb, queue->info->netdev);
@@ -1332,8 +1340,10 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 		skb->data_len = rx->status;
 		skb->len += rx->status;
 
-		if (unlikely(xennet_fill_frags(queue, skb, &tmpq)))
+		if (unlikely(xennet_fill_frags(queue, skb, &tmpq))) {
+			__skb_queue_head(&tmpq, skb);
 			goto err;
+		}
 
 		if (rx->flags & XEN_NETRXF_csum_blank)
 			skb->ip_summed = CHECKSUM_PARTIAL;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d34c732baee5..97c6d6aa4ccf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3953,6 +3953,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
 	blk_cleanup_disk(disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c6e28d0f33e9..a2797091653f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -548,7 +548,8 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		u32 nr_nsids;
 		size_t nsid_buf_size;
 
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
+		if (WARN_ON_ONCE(offset > ctrl->ana_log_size ||
+				 sizeof(*desc) > ctrl->ana_log_size - offset))
 			return -EINVAL;
 
 		nr_nsids = le32_to_cpu(desc->nnsids);
@@ -564,7 +565,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
+		if (WARN_ON_ONCE(nsid_buf_size > ctrl->ana_log_size - offset))
 			return -EINVAL;
 
 		error = cb(ctrl, desc, data);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 36daf0025e5f..8ce4dc96313f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -643,7 +643,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	return ret;
 }
 
-static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
+static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 		struct nvme_tcp_r2t_pdu *pdu)
 {
 	struct nvme_tcp_data_pdu *data = req->pdu;
@@ -652,32 +652,11 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
+	req->state = NVME_TCP_SEND_H2C_PDU;
+	req->offset = 0;
 	req->pdu_len = le32_to_cpu(pdu->r2t_length);
 	req->pdu_sent = 0;
 
-	if (unlikely(!req->pdu_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len is %u, probably a bug...\n",
-			rq->tag, req->pdu_len);
-		return -EPROTO;
-	}
-
-	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
-			req->data_sent);
-		return -EPROTO;
-	}
-
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset),
-			req->data_sent);
-		return -EPROTO;
-	}
-
 	memset(data, 0, sizeof(*data));
 	data->hdr.type = nvme_tcp_h2c_data;
 	data->hdr.flags = NVME_TCP_F_DATA_LAST;
@@ -693,7 +672,6 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->command_id = nvme_cid(rq);
 	data->data_offset = pdu->r2t_offset;
 	data->data_length = cpu_to_le32(req->pdu_len);
-	return 0;
 }
 
 static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
@@ -701,7 +679,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 {
 	struct nvme_tcp_request *req;
 	struct request *rq;
-	int ret;
+	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -712,13 +690,35 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
-	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
-	if (unlikely(ret))
-		return ret;
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
 
-	req->state = NVME_TCP_SEND_H2C_PDU;
-	req->offset = 0;
+	if (unlikely(!r2t_length)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len is %u, probably a bug...\n",
+			rq->tag, r2t_length);
+		return -EPROTO;
+	}
+
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, r2t_length, req->data_len, req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
+		return -EPROTO;
+	}
 
+	nvme_tcp_setup_h2c_data_pdu(req, pdu);
 	nvme_tcp_queue_request(req, false, true);
 
 	return 0;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a3d3a1bfd292..110d33900a00 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -339,6 +339,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	struct nvmet_subsys *subsys = ns->subsys;
 	size_t len;
 	int ret;
+	char *new_path = NULL;
 
 	mutex_lock(&subsys->lock);
 	ret = -EBUSY;
@@ -350,12 +351,14 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	if (!len)
 		goto out_unlock;
 
-	kfree(ns->device_path);
 	ret = -ENOMEM;
-	ns->device_path = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!ns->device_path)
+	new_path = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!new_path)
 		goto out_unlock;
 
+	kfree(ns->device_path);
+	ns->device_path = new_path;
+
 	mutex_unlock(&subsys->lock);
 	return count;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0483a85850ea..34e7b86c7d0f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1041,7 +1041,7 @@ static int nvmet_req_alloc_p2pmem_sgls(struct pci_dev *p2p_dev,
 
 	return 0;
 out_free_sg:
-	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+	pci_p2pmem_free_sgl(p2p_dev, req->sg);
 out_err:
 	return -ENOMEM;
 }
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 5c4254ab5d83..ecc74f12e3e6 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -407,10 +407,16 @@ int of_irq_get(struct device_node *dev, int index)
 		return rc;
 
 	domain = irq_find_host(oirq.np);
-	if (!domain)
-		return -EPROBE_DEFER;
+	if (!domain) {
+		rc = -EPROBE_DEFER;
+		goto out;
+	}
+
+	rc = irq_create_of_mapping(&oirq);
+out:
+	of_node_put(oirq.np);
 
-	return irq_create_of_mapping(&oirq);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(of_irq_get);
 
@@ -582,6 +588,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 	list_for_each_entry_safe(desc, temp_desc, &intc_parent_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
+		of_node_put(desc->dev);
 		kfree(desc);
 	}
 err:
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index cea5ad907235..28a340816a2b 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -241,6 +241,9 @@ static struct property *dup_and_fixup_symbol_prop(
 	if (!target_path)
 		return NULL;
 	target_path_len = strlen(target_path);
+	/* a root target renders as "/"; drop it to avoid "//" results */
+	if (target_path_len == 1 && target_path[0] == '/' && path_tail_len)
+		target_path_len = 0;
 
 	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
 	if (!new_prop)
@@ -346,12 +349,13 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		return -ENOMEM;
 
 	if (!prop) {
-		if (!target->in_livetree) {
+		ret = of_changeset_add_property(&ovcs->cset, target->np,
+						new_prop);
+		/* the detached node owns the property until the apply */
+		if (!ret && !target->in_livetree) {
 			new_prop->next = target->np->deadprops;
 			target->np->deadprops = new_prop;
 		}
-		ret = of_changeset_add_property(&ovcs->cset, target->np,
-						new_prop);
 	} else {
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
@@ -829,6 +833,10 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 err_out:
 	pr_err("%s() failed, ret = %d\n", __func__, ret);
 
+	/* let free_overlay_changeset() put the fragments set up so far */
+	if (ovcs->fragments)
+		ovcs->count = cnt;
+
 	return ret;
 }
 
@@ -839,7 +847,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	if (ovcs->cset.entries.next)
 		of_changeset_destroy(&ovcs->cset);
 
-	if (ovcs->id) {
+	/* a failed idr_alloc() leaves its negative error in ovcs->id */
+	if (ovcs->id > 0) {
 		idr_remove(&ovcs_idr, ovcs->id);
 		list_del(&ovcs->ovcs_list);
 		ovcs->id = 0;
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dbd69d8e44e4..4bcea866954a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1720,12 +1720,12 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		return ret;
 	}
 
-	list_add(&new_opp->node, head);
-	mutex_unlock(&opp_table->lock);
-
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
+	list_add(&new_opp->node, head);
+	mutex_unlock(&opp_table->lock);
+
 	opp_debug_create_one(new_opp, opp_table);
 
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ab7e61aa9e5c..adda41abdbed 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3637,8 +3637,21 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	}
 
 	root = pcie_find_root_port(dev);
-	if (!root)
+	if (!root) {
+
+		/*
+		 * A hypervisor may expose a topology with the root port
+		 * not visible to the guest.  If the hypervisor has already
+		 * set AtomicOp Requester Enable in the endpoint, we assume
+		 * it has verified support in the root port, so it is safe
+		 * for the driver to use AtomicOps.
+		 */
+		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
+		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
+			return 0;
+
 		return -EINVAL;
+	}
 
 	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
 	if ((cap & cap_mask) != cap_mask)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8c9dd9fbfe85..5e89718a2dbc 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -46,6 +46,63 @@ static struct lock_class_key sunxi_pinctrl_irq_request_class;
 static struct irq_chip sunxi_pinctrl_edge_irq_chip;
 static struct irq_chip sunxi_pinctrl_level_irq_chip;
 
+/*
+ * The sunXi PIO registers are organized as a series of banks, with registers
+ * for each bank in the following order:
+ *  - Mux config
+ *  - Data value
+ *  - Drive level
+ *  - Pull direction
+ *
+ * Multiple consecutive registers are used for fields wider than one bit.
+ *
+ * The following functions calculate the register and the bit offset to access.
+ * They take a pin number which is relative to the start of the current device.
+ */
+static void sunxi_mux_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * MUX_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + MUX_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(MUX_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_data_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DATA_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DATA_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DATA_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_dlevel_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DLEVEL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DLEVEL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DLEVEL_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_pull_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * PULL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + PULL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(PULL_FIELD_WIDTH) - 1) << *shift;
+}
+
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
 {
@@ -457,21 +514,17 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
 };
 
 static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
-			   u32 *offset, u32 *shift, u32 *mask)
+			   u32 *reg, u32 *shift, u32 *mask)
 {
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		*offset = sunxi_dlevel_reg(pin);
-		*shift = sunxi_dlevel_offset(pin);
-		*mask = DLEVEL_PINS_MASK;
+		sunxi_dlevel_reg(pin, reg, shift, mask);
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_DISABLE:
-		*offset = sunxi_pull_reg(pin);
-		*shift = sunxi_pull_offset(pin);
-		*mask = PULL_PINS_MASK;
+		sunxi_pull_reg(pin, reg, shift, mask);
 		break;
 
 	default:
@@ -486,17 +539,17 @@ static int sunxi_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	u32 offset, shift, mask, val;
+	u32 reg, shift, mask, val;
 	u16 arg;
 	int ret;
 
 	pin -= pctl->desc->pin_base;
 
-	ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+	ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 	if (ret < 0)
 		return ret;
 
-	val = (readl(pctl->membase + offset) >> shift) & mask;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	switch (pinconf_to_config_param(*config)) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -552,16 +605,15 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 	pin -= pctl->desc->pin_base;
 
 	for (i = 0; i < num_configs; i++) {
+		u32 arg, reg, shift, mask, val;
 		enum pin_config_param param;
 		unsigned long flags;
-		u32 offset, shift, mask, reg;
-		u32 arg, val;
 		int ret;
 
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+		ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 		if (ret < 0)
 			return ret;
 
@@ -598,9 +650,8 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 		}
 
 		raw_spin_lock_irqsave(&pctl->lock, flags);
-		reg = readl(pctl->membase + offset);
-		reg &= ~(mask << shift);
-		writel(reg | val << shift, pctl->membase + offset);
+		writel((readl(pctl->membase + reg) & ~mask) | val << shift,
+		       pctl->membase + reg);
 		raw_spin_unlock_irqrestore(&pctl->lock, flags);
 	} /* for each config */
 
@@ -716,16 +767,31 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 				 u8 config)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 reg, shift, mask;
 	unsigned long flags;
-	u32 val, mask;
+
+	pin -= pctl->desc->pin_base;
+	sunxi_mux_reg(pin, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	pin -= pctl->desc->pin_base;
-	val = readl(pctl->membase + sunxi_mux_reg(pin));
-	mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
-	writel((val & ~mask) | config << sunxi_mux_offset(pin),
-		pctl->membase + sunxi_mux_reg(pin));
+	writel((readl(pctl->membase + reg) & ~mask) | config << shift,
+	       pctl->membase + reg);
+
+	/*
+	 * A pin muxed to gpio_out directly through a pinmux node bypasses
+	 * sunxi_pinctrl_gpio_set() and drives whatever its output latch
+	 * holds.  Now that the pin is in output mode the data register
+	 * reads back the latch, so refresh the shadow to keep such pins
+	 * driving their pre-existing level.
+	 */
+	if (config == SUN4I_FUNC_OUTPUT) {
+		u32 *shadow = &pctl->dat_shadow[pin / PINS_PER_BANK];
+
+		sunxi_data_reg(pin, &reg, &shift, &mask);
+		*shadow = (*shadow & ~mask) |
+			  (readl(pctl->membase + reg) & mask);
+	}
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
@@ -856,43 +922,51 @@ static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
 static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
 	bool set_mux = pctl->desc->irq_read_needs_mux &&
 		gpiochip_line_is_irq(chip, offset);
 	u32 pin = offset + chip->base;
-	u32 val;
+	u32 reg, shift, mask, val;
+
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
 
-	val = (readl(pctl->membase + reg) >> index) & DATA_PINS_MASK;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_IRQ);
 
-	return !!val;
+	return val;
 }
 
 static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
+	u32 *shadow = &pctl->dat_shadow[offset / PINS_PER_BANK];
+	u32 reg, shift, mask;
 	unsigned long flags;
-	u32 regval;
 
-	raw_spin_lock_irqsave(&pctl->lock, flags);
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
-	regval = readl(pctl->membase + reg);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
+	/*
+	 * Reading the data register returns the pin level, not the output
+	 * latch, for pins muxed as inputs.  A read-modify-write based on
+	 * the register would therefore corrupt the latches of input-muxed
+	 * pins in the same bank (e.g. an emulated open-drain I2C line
+	 * released high), making them drive the wrong level once switched
+	 * to output.  Base the read-modify-write on a shadow copy of the
+	 * latches instead.
+	 */
 	if (value)
-		regval |= BIT(index);
+		*shadow |= mask;
 	else
-		regval &= ~(BIT(index));
+		*shadow &= ~mask;
 
-	writel(regval, pctl->membase + reg);
+	writel(*shadow, pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
@@ -1413,7 +1487,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct pinmux_ops *pmxops;
-	int i, ret, last_pin, pin_idx;
+	int i, ret, last_pin, pin_idx, nbanks;
 	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
@@ -1438,6 +1512,37 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->irq_array)
 		return -ENOMEM;
 
+	/*
+	 * The bus clock has to be enabled before the pinctrl device
+	 * registers, as the pin hogs claimed from there access registers.
+	 */
+	ret = of_clk_get_parent_count(node);
+	clk = devm_clk_get_enabled(&pdev->dev, ret == 1 ? NULL : "apb");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	/*
+	 * Seed the output latch shadow from the hardware so pins the
+	 * bootloader left in output mode keep their state; see
+	 * sunxi_pinctrl_gpio_set() for why a shadow is needed.  This must
+	 * happen before the pinctrl device registers, as pin hogs can mux
+	 * pins to gpio_out and thereby update the shadow.
+	 */
+	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
+	nbanks = DIV_ROUND_UP(last_pin + 1 - pctl->desc->pin_base,
+			      PINS_PER_BANK);
+	pctl->dat_shadow = devm_kcalloc(&pdev->dev, nbanks,
+					sizeof(*pctl->dat_shadow), GFP_KERNEL);
+	if (!pctl->dat_shadow)
+		return -ENOMEM;
+
+	for (i = 0; i < nbanks; i++) {
+		u32 reg, shift, mask;
+
+		sunxi_data_reg(i * PINS_PER_BANK, &reg, &shift, &mask);
+		pctl->dat_shadow[i] = readl(pctl->membase + reg);
+	}
+
 	ret = sunxi_pinctrl_build_state(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
@@ -1492,7 +1597,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->chip)
 		return -ENOMEM;
 
-	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
 	pctl->chip->owner = THIS_MODULE;
 	pctl->chip->request = gpiochip_generic_request;
 	pctl->chip->free = gpiochip_generic_free;
@@ -1525,31 +1629,20 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	ret = of_clk_get_parent_count(node);
-	clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto gpiochip_error;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto gpiochip_error;
-
 	pctl->irq = devm_kcalloc(&pdev->dev,
 				 pctl->desc->irq_banks,
 				 sizeof(*pctl->irq),
 				 GFP_KERNEL);
 	if (!pctl->irq) {
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
 		pctl->irq[i] = platform_get_irq(pdev, i);
 		if (pctl->irq[i] < 0) {
 			ret = pctl->irq[i];
-			goto clk_error;
+			goto gpiochip_error;
 		}
 	}
 
@@ -1560,7 +1653,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
@@ -1592,8 +1685,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 
 	return 0;
 
-clk_error:
-	clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 	return ret;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a32bb5bcb754..86bf203445d6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -36,23 +36,15 @@
 
 #define BANK_MEM_SIZE		0x24
 #define MUX_REGS_OFFSET		0x0
+#define MUX_FIELD_WIDTH		4
 #define DATA_REGS_OFFSET	0x10
+#define DATA_FIELD_WIDTH	1
 #define DLEVEL_REGS_OFFSET	0x14
+#define DLEVEL_FIELD_WIDTH	2
 #define PULL_REGS_OFFSET	0x1c
+#define PULL_FIELD_WIDTH	2
 
 #define PINS_PER_BANK		32
-#define MUX_PINS_PER_REG	8
-#define MUX_PINS_BITS		4
-#define MUX_PINS_MASK		0x0f
-#define DATA_PINS_PER_REG	32
-#define DATA_PINS_BITS		1
-#define DATA_PINS_MASK		0x01
-#define DLEVEL_PINS_PER_REG	16
-#define DLEVEL_PINS_BITS	2
-#define DLEVEL_PINS_MASK	0x03
-#define PULL_PINS_PER_REG	16
-#define PULL_PINS_BITS		2
-#define PULL_PINS_MASK		0x03
 
 #define IRQ_PER_BANK		32
 
@@ -84,6 +76,7 @@
 #define IO_BIAS_MASK		GENMASK(3, 0)
 
 #define SUN4I_FUNC_INPUT	0
+#define SUN4I_FUNC_OUTPUT	1
 #define SUN4I_FUNC_IRQ		6
 
 #define PINCTRL_SUN5I_A10S	BIT(1)
@@ -168,6 +161,12 @@ struct sunxi_pinctrl {
 	int				*irq;
 	unsigned			*irq_array;
 	raw_spinlock_t			lock;
+	/*
+	 * Output latch shadow, one word per bank.  Seeded lockless at
+	 * probe before the pinctrl device registers, protected by @lock
+	 * afterwards.
+	 */
+	u32				*dat_shadow;
 	struct pinctrl_dev		*pctl_dev;
 	unsigned long			variant;
 };
@@ -215,83 +214,6 @@ struct sunxi_pinctrl {
 		.irqnum = _irq,					\
 	}
 
-/*
- * The sunXi PIO registers are organized as is:
- * 0x00 - 0x0c	Muxing values.
- *		8 pins per register, each pin having a 4bits value
- * 0x10		Pin values
- *		32 bits per register, each pin corresponding to one bit
- * 0x14 - 0x18	Drive level
- *		16 pins per register, each pin having a 2bits value
- * 0x1c - 0x20	Pull-Up values
- *		16 pins per register, each pin having a 2bits value
- *
- * This is for the first bank. Each bank will have the same layout,
- * with an offset being a multiple of 0x24.
- *
- * The following functions calculate from the pin number the register
- * and the bit offset that we should access.
- */
-static inline u32 sunxi_mux_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += MUX_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / MUX_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_mux_offset(u16 pin)
-{
-	u32 pin_num = pin % MUX_PINS_PER_REG;
-	return pin_num * MUX_PINS_BITS;
-}
-
-static inline u32 sunxi_data_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DATA_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DATA_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_data_offset(u16 pin)
-{
-	u32 pin_num = pin % DATA_PINS_PER_REG;
-	return pin_num * DATA_PINS_BITS;
-}
-
-static inline u32 sunxi_dlevel_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DLEVEL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DLEVEL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_dlevel_offset(u16 pin)
-{
-	u32 pin_num = pin % DLEVEL_PINS_PER_REG;
-	return pin_num * DLEVEL_PINS_BITS;
-}
-
-static inline u32 sunxi_pull_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += PULL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / PULL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_pull_offset(u16 pin)
-{
-	u32 pin_num = pin % PULL_PINS_PER_REG;
-	return pin_num * PULL_PINS_BITS;
-}
-
 static inline u32 sunxi_irq_hw_bank_num(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
 	if (!desc->irq_bank_map)
diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 2b8c90d84325..0a1f79600c60 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -304,7 +304,7 @@ static int ds2780_get_capacity(struct ds2780_device_info *dev_info,
 		return ret;
 
 	*capacity = raw;
-	return raw;
+	return 0;
 }
 
 static int ds2780_get_status(struct ds2780_device_info *dev_info, int *status)
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 04b61692da30..2017acf67a32 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -430,19 +430,15 @@ static const struct power_supply_desc max17040_battery_desc = {
 	.num_properties		= ARRAY_SIZE(max17040_battery_props),
 };
 
-static int max17040_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int max17040_probe(struct i2c_client *client)
 {
-	struct i2c_adapter *adapter = client->adapter;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
 	enum chip_id chip_id;
 	bool enable_irq = false;
 	int ret;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-		return -EIO;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -599,7 +595,7 @@ static struct i2c_driver max17040_i2c_driver = {
 		.of_match_table = max17040_of_match,
 		.pm	= MAX17040_PM_OPS,
 	},
-	.probe		= max17040_probe,
+	.probe_new	= max17040_probe,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 89b414fac6c3..310cae3f61f0 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1583,8 +1583,20 @@ static const struct regmap_config rt9455_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
-static int rt9455_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static void rt9455_cancel_all_delayed_works(void *data)
+{
+	struct rt9455_info *info = data;
+
+	/*
+	 * Both pwr_rdy_work and batt_presence_work can queue
+	 * max_charging_time_work, so cancel them first.
+	 */
+	cancel_delayed_work_sync(&info->pwr_rdy_work);
+	cancel_delayed_work_sync(&info->batt_presence_work);
+	cancel_delayed_work_sync(&info->max_charging_time_work);
+}
+
+static int rt9455_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
@@ -1674,6 +1686,10 @@ static int rt9455_probe(struct i2c_client *client,
 		goto put_usb_notifier;
 	}
 
+	ret = devm_add_action_or_reset(dev, rt9455_cancel_all_delayed_works, info);
+	if (ret)
+		goto put_usb_notifier;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					rt9455_irq_handler_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1715,10 +1731,6 @@ static int rt9455_remove(struct i2c_client *client)
 		usb_unregister_notifier(info->usb_phy, &info->nb);
 #endif
 
-	cancel_delayed_work_sync(&info->pwr_rdy_work);
-	cancel_delayed_work_sync(&info->max_charging_time_work);
-	cancel_delayed_work_sync(&info->batt_presence_work);
-
 	return ret;
 }
 
@@ -1743,7 +1755,7 @@ MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
 #endif
 
 static struct i2c_driver rt9455_driver = {
-	.probe		= rt9455_probe,
+	.probe_new	= rt9455_probe,
 	.remove		= rt9455_remove,
 	.id_table	= rt9455_i2c_id_table,
 	.driver = {
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index f4d8ea21f173..405baea41357 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -232,7 +232,7 @@ static const struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] =
 	LTC3676_FIXED_REG(LDO4, ldo4, LDOB, 2),
 };
 
-static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned int reg)
+static bool ltc3676_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
@@ -243,6 +243,15 @@ static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
+		return true;
+	}
+	return false;
+}
+
 static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -255,8 +264,8 @@ static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config ltc3676_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.writeable_reg = ltc3676_readable_writeable_reg,
-	.readable_reg = ltc3676_readable_writeable_reg,
+	.writeable_reg = ltc3676_writeable_reg,
+	.readable_reg = ltc3676_readable_reg,
 	.volatile_reg = ltc3676_volatile_reg,
 	.max_register = LTC3676_CLIRQ,
 	.use_single_read = true,
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index b4a520056b1a..189a3f3cdcaa 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -357,6 +357,12 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	config->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(config->ioaddr))
+		return PTR_ERR(config->ioaddr);
+
+	spin_lock_init(&config->lock);
+
 	status = devm_request_irq(&pdev->dev, irq, spear_rtc_irq, 0, pdev->name,
 			config);
 	if (status) {
@@ -365,10 +371,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	config->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(config->ioaddr))
-		return PTR_ERR(config->ioaddr);
-
 	config->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(config->clk))
 		return PTR_ERR(config->clk);
@@ -377,7 +379,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	if (status < 0)
 		return status;
 
-	spin_lock_init(&config->lock);
 	platform_set_drvdata(pdev, config);
 
 	config->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index cde36a3b6c03..add71c296d53 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -824,7 +824,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
 
 	fsm_deltimer(&grp->timer);
 
-	if (grp->saved_xid2->xid2_flag2 == 0x40) {
+	if (priv->xid->xid2_flag2 == 0x40) {
 		priv->xid->xid2_flag2 = 0x00;
 		if (grp->estconnfunc) {
 			grp->estconnfunc(grp->port_num, 1,
@@ -1633,7 +1633,6 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
 			"The XID used in the MPC protocol is not valid, "
 			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
-		grp->saved_xid2->xid2_flag2 = 0x40;
 	}
 
 	return rc;
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 27012908b586..c1f714664bfc 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -110,7 +110,6 @@ typedef struct {
 	int                 minor;
 	char                name[8];
 	struct scsi_device  *device;
-	struct scsi_device  **dt;        /* ptrs to data transfer elements */
 	u_int               firsts[CH_TYPES];
 	u_int               counts[CH_TYPES];
 	u_int               unit_attention;
@@ -357,16 +356,10 @@ ch_readconfig(scsi_changer *ch)
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
@@ -382,10 +375,8 @@ ch_readconfig(scsi_changer *ch)
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
@@ -395,18 +386,16 @@ ch_readconfig(scsi_changer *ch)
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
@@ -570,7 +559,6 @@ static void ch_destroy(struct kref *ref)
 	scsi_changer *ch = container_of(ref, scsi_changer, ref);
 
 	ch->device = NULL;
-	kfree(ch->dt);
 	kfree(ch);
 }
 
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index fbb5eecbb7ca..a50e0b4e94e9 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1083,13 +1083,15 @@ static int iscsi_handle_reject(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 			spin_unlock(&conn->session->frwd_lock);
 			spin_lock(&conn->session->back_lock);
 		} else {
-			struct iscsi_task *task;
+			struct iscsi_task *task = NULL;
 			/*
 			 * Our nop as ping got dropped. We know the target
 			 * and transport are ok so just clean up
 			 */
-			task = iscsi_itt_to_task(conn, rejected_pdu.itt);
-			if (!task) {
+			if (!iscsi_verify_itt(conn, rejected_pdu.itt))
+				task = iscsi_itt_to_task(conn, rejected_pdu.itt);
+			if (!task || task->state == ISCSI_TASK_FREE ||
+			    task->sc) {
 				iscsi_conn_printk(KERN_ERR, conn,
 						 "Invalid pdu reject. Could "
 						 "not lookup rejected task.\n");
@@ -1132,7 +1134,7 @@ struct iscsi_task *iscsi_itt_to_task(struct iscsi_conn *conn, itt_t itt)
 		session->tt->parse_pdu_itt(conn, itt, &i, NULL);
 	else
 		i = get_itt(itt);
-	if (i >= session->cmds_max)
+	if (i < 0 || i >= session->cmds_max)
 		return NULL;
 
 	return session->cmds[i];
@@ -1225,7 +1227,7 @@ int __iscsi_complete_pdu(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 	case ISCSI_OP_SCSI_TMFUNC_RSP:
 	case ISCSI_OP_NOOP_IN:
 		task = iscsi_itt_to_task(conn, hdr->itt);
-		if (!task)
+		if (!task || task->state == ISCSI_TASK_FREE || task->sc)
 			return ISCSI_ERR_BAD_ITT;
 		break;
 	default:
@@ -1325,7 +1327,7 @@ int iscsi_verify_itt(struct iscsi_conn *conn, itt_t itt)
 		return ISCSI_ERR_BAD_ITT;
 	}
 
-	if (i >= session->cmds_max) {
+	if (i < 0 || i >= session->cmds_max) {
 		iscsi_conn_printk(KERN_ERR, conn,
 				  "received invalid itt index %u (max cmds "
 				   "%u.\n", i, session->cmds_max);
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 76b2e6484f90..6d3fcf128c9b 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2669,8 +2669,6 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 	snprintf(host_buf, sizeof(host_buf), "host_%d", qedi->shost->host_no);
 	qedi_ops->common->set_name(qedi->cdev, host_buf);
 
-	qedi_ops->register_ops(qedi->cdev, &qedi_cb_ops, qedi);
-
 	memset(&params, 0, sizeof(params));
 	params.mtu = DEF_PATH_MTU + IPV6_HDR_LEN + TCP_HDR_LEN;
 	qedi->ll2_mtu = DEF_PATH_MTU;
@@ -2687,6 +2685,7 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 		spin_lock_init(&qedi->task_idx_lock);
 		mutex_init(&qedi->stats_lock);
 	}
+	qedi_ops->register_ops(qedi->cdev, &qedi_cb_ops, qedi);
 	qedi_ops->ll2->register_cb_ops(qedi->cdev, &qedi_ll2_cb_ops, qedi);
 	qedi_ops->ll2->start(qedi->cdev, &params);
 
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index f4b56708dfca..b2ab0e3db335 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -158,6 +158,12 @@ qla24xx_proc_fcp_prio_cfg_cmd(struct bsg_job *bsg_job)
 		goto exit_fcp_prio_cfg;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t)) {
+		ret = -EINVAL;
+		goto exit_fcp_prio_cfg;
+	}
+
 	/* Get the sub command */
 	oper = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
 
@@ -756,6 +762,10 @@ qla2x00_process_loopback(struct bsg_job *bsg_job)
 		return -EIO;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 3 * sizeof(uint32_t))
+		return -EINVAL;
+
 	memset(&elreq, 0, sizeof(elreq));
 
 	elreq.req_sg_cnt = dma_map_sg(&ha->pdev->dev,
@@ -988,6 +998,10 @@ qla84xx_reset(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	flag = bsg_request->rqst_data.h_vendor.vendor_cmd[1];
 
 	rval = qla84xx_reset_chip(vha, flag == A84_ISSUE_RESET_DIAG_FW);
@@ -1032,6 +1046,10 @@ qla84xx_updatefw(struct bsg_job *bsg_job)
 		return -EINVAL;
 	}
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	sg_cnt = dma_map_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!sg_cnt) {
@@ -1482,6 +1500,10 @@ qla2x00_read_optrom(struct bsg_job *bsg_job)
 	struct qla_hw_data *ha = vha->hw;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	if (ha->flags.nic_core_reset_hdlr_active)
 		return -EBUSY;
 
@@ -1519,6 +1541,10 @@ qla2x00_update_optrom(struct bsg_job *bsg_job)
 	struct qla_hw_data *ha = vha->hw;
 	int rval = 0;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + 2 * sizeof(uint32_t))
+		return -EINVAL;
+
 	mutex_lock(&ha->optrom_mutex);
 	rval = qla2x00_optrom_setup(bsg_job, vha, 1);
 	if (rval) {
@@ -2010,6 +2036,11 @@ qlafx00_mgmt_cmd(struct bsg_job *bsg_job)
 	struct fc_port *fcport;
 	char  *type = "FC_BSG_HST_FX_MGMT";
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + sizeof(uint32_t) +
+	    sizeof(struct qla_mt_iocb_rqst_fx00))
+		return -EINVAL;
+
 	/* Copy the IOCB specific information */
 	piocb_rqst = (struct qla_mt_iocb_rqst_fx00 *)
 	    &bsg_request->rqst_data.h_vendor.vendor_cmd[1];
@@ -2412,7 +2443,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");
@@ -2812,6 +2843,13 @@ qla2x00_process_vendor_specific(struct scsi_qla_host *vha, struct bsg_job *bsg_j
 {
 	struct fc_bsg_request *bsg_request = bsg_job->request;
 
+	if (bsg_job->request_len <
+	    sizeof(struct fc_bsg_request) + sizeof(uint32_t)) {
+		ql_log(ql_log_warn, vha, 0x7000,
+		       "BSG request too small for vendor cmd.\n");
+		return -EINVAL;
+	}
+
 	ql_dbg(ql_dbg_edif, vha, 0x911b, "%s FC_BSG_HST_VENDOR cmd[0]=0x%x\n",
 	    __func__, bsg_request->rqst_data.h_vendor.vendor_cmd[0]);
 
@@ -2931,8 +2969,11 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 	}
 
 	/* Disable port will bring down the chip, allow enable command */
-	if (bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_MANAGE_HOST_PORT ||
-	    bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_GET_HOST_STATS)
+	if (bsg_request->msgcode == FC_BSG_HST_VENDOR &&
+	    bsg_job->request_len >=
+		sizeof(struct fc_bsg_request) + sizeof(uint32_t) &&
+	    (bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_MANAGE_HOST_PORT ||
+	     bsg_request->rqst_data.h_vendor.vendor_cmd[0] == QL_VND_GET_HOST_STATS))
 		goto skip_chip_chk;
 
 	if (vha->hw->flags.port_isolated) {
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index afde7a71474f..73aec10e2f22 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9938,9 +9938,26 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
 {
 	int ret = QLA_FUNCTION_FAILED;
 	struct qla_hw_data *ha = qpair->hw;
+	struct rsp_que *rsp = qpair->rsp;
 
 	qpair->delete_in_progress = 1;
 
+	/*
+	 * The response-queue interrupt schedules qla_do_work(), which
+	 * dereferences qpair->rsp->req.  Release the interrupt and flush
+	 * any pending work before the request queue is freed below so a
+	 * late completion cannot touch the freed request queue.  The
+	 * firmware queue-delete order (request then response) is kept.
+	 */
+	if (rsp && rsp->msix && rsp->msix->have_irq) {
+		free_irq(rsp->msix->vector, rsp->msix->handle);
+		rsp->msix->have_irq = 0;
+		rsp->msix->in_use = 0;
+		rsp->msix->handle = NULL;
+	}
+	if (rsp && ha->wq)
+		cancel_work_sync(&qpair->q_work);
+
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)
 		goto fail;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7bccd525ee19..f080e1952927 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2347,11 +2347,13 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	/* Prep packet */
 	req->cnt -= req_cnt;
 	pkt = req->ring_ptr;
-	memset(pkt, 0, REQUEST_ENTRY_SIZE);
 	if (IS_QLAFX00(ha)) {
+		memset_io((void __iomem __force *)pkt, 0,
+			  REQUEST_ENTRY_SIZE);
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
 	} else {
+		memset(pkt, 0, REQUEST_ENTRY_SIZE);
 		pkt->entry_count = req_cnt;
 		pkt->handle = handle;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 509853860ada..870962df1f9c 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1053,14 +1053,6 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, void **pkt,
 
 	do {
 		while ((total_bytes > 0) && (entry_count_remaining > 0)) {
-			if (rsp_q->ring_ptr->signature == RESPONSE_PROCESSED) {
-				ql_dbg(ql_dbg_async, vha, 0x5084,
-				       "Ran out of IOCBs, partial data 0x%x\n",
-				       buffer_copy_offset);
-				cpu_relax();
-				continue;
-			}
-
 			new_pkt = (sts_cont_entry_t *)rsp_q->ring_ptr;
 			*pkt = new_pkt;
 
@@ -3963,10 +3955,25 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					       "SCM not active for this port\n");
 					break;
 				}
+				__update_rsp_in(1, is_shadow_hba, rsp, rsp_in);
+				if (qla_chk_cont_iocb_avail(vha, rsp,
+				    (response_t *)pkt, rsp_in)) {
+					/*
+					 * ring_ptr and ring_index were
+					 * pre-incremented above. Reset them
+					 * back to current. Wait for next
+					 * interrupt with all IOCBs to arrive
+					 * and re-process.
+					 */
+					rsp->ring_ptr = (response_t *)pkt;
+					rsp->ring_index = cur_ring_index;
+
+					ql_dbg(ql_dbg_init, vha, 0x5095,
+					    "Defer processing FPIN...\n");
+					return;
+				}
 				pure_item = qla27xx_copy_fpin_pkt(vha,
 							  (void **)&pkt, &rsp);
-				__update_rsp_in(follow_inptr, is_shadow_hba,
-						rsp, rsp_in);
 				if (!pure_item)
 					break;
 				qla24xx_queue_purex_item(vha, pure_item,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 991360c138a6..7b511a5cb70a 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5650,7 +5650,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5661,8 +5661,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 7e1956d0435d..68b1e5129d6c 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -583,16 +583,19 @@ qla25xx_free_req_que(struct scsi_qla_host *vha, struct req_que *req)
 {
 	struct qla_hw_data *ha = vha->hw;
 	uint16_t que_id = req->id;
+	size_t req_entry_size = sizeof(request_t);
 
-	dma_free_coherent(&ha->pdev->dev, (req->length + 1) *
-		sizeof(request_t), req->ring, req->dma);
+	if (req->ring)
+		dma_free_coherent(&ha->pdev->dev,
+				  (req->length + 1) * req_entry_size,
+				  req->ring, req->dma);
 	req->ring = NULL;
 	req->dma = 0;
 	if (que_id) {
+		mutex_lock(&ha->mq_lock);
 		ha->req_q_map[que_id] = NULL;
-		mutex_lock(&ha->vport_lock);
 		clear_bit(que_id, ha->req_qid_map);
-		mutex_unlock(&ha->vport_lock);
+		mutex_unlock(&ha->mq_lock);
 	}
 	kfree(req->outstanding_cmds);
 	kfree(req);
@@ -604,6 +607,7 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 {
 	struct qla_hw_data *ha = vha->hw;
 	uint16_t que_id = rsp->id;
+	size_t rsp_entry_size = sizeof(response_t);
 
 	if (rsp->msix && rsp->msix->have_irq) {
 		free_irq(rsp->msix->vector, rsp->msix->handle);
@@ -611,15 +615,22 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 		rsp->msix->in_use = 0;
 		rsp->msix->handle = NULL;
 	}
-	dma_free_coherent(&ha->pdev->dev, (rsp->length + 1) *
-		sizeof(response_t), rsp->ring, rsp->dma);
+
+	/* Flush any queued response work before freeing the queue/qpair. */
+	if (rsp->qpair && ha->wq)
+		cancel_work_sync(&rsp->qpair->q_work);
+
+	if (rsp->ring)
+		dma_free_coherent(&ha->pdev->dev,
+				  (rsp->length + 1) * rsp_entry_size,
+				  rsp->ring, rsp->dma);
 	rsp->ring = NULL;
 	rsp->dma = 0;
 	if (que_id) {
+		mutex_lock(&ha->mq_lock);
 		ha->rsp_q_map[que_id] = NULL;
-		mutex_lock(&ha->vport_lock);
 		clear_bit(que_id, ha->rsp_qid_map);
-		mutex_unlock(&ha->vport_lock);
+		mutex_unlock(&ha->mq_lock);
 	}
 	kfree(rsp);
 	rsp = NULL;
@@ -805,9 +816,6 @@ qla25xx_create_req_que(struct qla_hw_data *ha, uint16_t options,
 		if (ret != QLA_SUCCESS) {
 			ql_log(ql_log_fatal, base_vha, 0x00df,
 			    "%s failed.\n", __func__);
-			mutex_lock(&ha->mq_lock);
-			clear_bit(que_id, ha->req_qid_map);
-			mutex_unlock(&ha->mq_lock);
 			goto que_failed;
 		}
 		vha->flags.qpairs_req_created = 1;
@@ -919,9 +927,6 @@ qla25xx_create_rsp_que(struct qla_hw_data *ha, uint16_t options,
 		if (ret != QLA_SUCCESS) {
 			ql_log(ql_log_fatal, base_vha, 0x00e7,
 			    "%s failed.\n", __func__);
-			mutex_lock(&ha->mq_lock);
-			clear_bit(que_id, ha->rsp_qid_map);
-			mutex_unlock(&ha->mq_lock);
 			goto que_failed;
 		}
 		vha->flags.qpairs_rsp_created = 1;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 9746f6debdcb..84caaa188000 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -304,8 +304,8 @@ static void qla_nvme_ls_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
-	schedule_work(&priv->abort_work);
+	if (!schedule_work(&priv->abort_work))
+		kref_put(&priv->sp->cmd_kref, priv->sp->put_fn);
 }
 
 static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
@@ -342,6 +342,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	priv->sp = sp;
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	nvme = &sp->u.iocb_cmd;
 	priv->fd = fd;
 	nvme->u.nvme.desc = fd;
@@ -386,8 +387,8 @@ static void qla_nvme_fcp_abort(struct nvme_fc_local_port *lport,
 	}
 	spin_unlock_irqrestore(&priv->cmd_lock, flags);
 
-	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
-	schedule_work(&priv->abort_work);
+	if (!schedule_work(&priv->abort_work))
+		kref_put(&priv->sp->cmd_kref, priv->sp->put_fn);
 }
 
 static inline int qla2x00_start_nvme_mq(srb_t *sp)
@@ -646,6 +647,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
+	INIT_WORK(&priv->abort_work, qla_nvme_abort_work);
 	sp->priv = priv;
 	priv->sp = sp;
 	sp->type = SRB_NVME_CMD;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 31d9eec75ee1..2e787858f9d5 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4431,23 +4431,36 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 
 fail_elsrej:
 	dma_pool_destroy(ha->purex_dma_pool);
+	ha->purex_dma_pool = NULL;
 fail_flt:
 	dma_free_coherent(&ha->pdev->dev, sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE,
 	    ha->flt, ha->flt_dma);
+	ha->flt = NULL;
+	ha->flt_dma = 0;
 
 fail_flt_buffer:
 	dma_free_coherent(&ha->pdev->dev, SFP_DEV_SIZE,
 	    ha->sfp_data, ha->sfp_data_dma);
+	ha->sfp_data = NULL;
+	ha->sfp_data_dma = 0;
 fail_sfp_data:
 	kfree(ha->loop_id_map);
+	ha->loop_id_map = NULL;
 fail_loop_id_map:
 	dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_dma);
+	ha->async_pd = NULL;
+	ha->async_pd_dma = 0;
 fail_async_pd:
 	dma_pool_free(ha->s_dma_pool, ha->sf_init_cb, ha->sf_init_cb_dma);
+	ha->sf_init_cb = NULL;
+	ha->sf_init_cb_dma = 0;
 fail_sf_init_cb:
 	dma_pool_free(ha->s_dma_pool, ha->ex_init_cb, ha->ex_init_cb_dma);
+	ha->ex_init_cb = NULL;
+	ha->ex_init_cb_dma = 0;
 fail_ex_init_cb:
 	kfree(ha->npiv_info);
+	ha->npiv_info = NULL;
 fail_npiv_info:
 	dma_free_coherent(&ha->pdev->dev, ((*rsp)->length + 1) *
 		sizeof(response_t), (*rsp)->ring, (*rsp)->dma);
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 90d0f8ddd179..d84a9c1d76c5 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -223,7 +223,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t lba = sectors_to_logical(sdkp->device, sector);
+	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -234,7 +234,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!sdkp->capacity)
+	if (!capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -242,8 +242,9 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && lba < sdkp->capacity) {
-		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
+	while (zone_idx < nr_zones && sector < capacity) {
+		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
+				sectors_to_logical(sdkp->device, sector), true);
 		if (ret)
 			goto out;
 
@@ -261,7 +262,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		lba += sdkp->zone_info.zone_blocks * i;
+		sector += sd_zbc_zone_sectors(sdkp) * i;
 	}
 
 	ret = zone_idx;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index dc0c6508d254..2783419ef5f4 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3184,14 +3184,20 @@ static int set_location(struct scsi_tape *STp, unsigned int block, int partition
 	    partition >= ST_NBR_PARTITIONS)
 		return (-EINVAL);
 	if (partition != STp->partition) {
-		if (get_location(STp, &blk, &p, 1))
+		/*
+		 * Save the location for the partition the drive reports,
+		 * not for STp->partition: after a reset STp->partition may
+		 * not match the partition the drive is in.
+		 */
+		if (get_location(STp, &blk, &p, 1) ||
+		    p < 0 || p >= ST_NBR_PARTITIONS)
 			STps->last_block_valid = 0;
 		else {
-			STps->last_block_valid = 1;
-			STps->last_block_visited = blk;
+			STp->ps[p].last_block_valid = 1;
+			STp->ps[p].last_block_visited = blk;
 			DEBC_printk(STp, "Visited block %d for "
 				    "partition %d saved.\n",
-				    blk, STp->partition);
+				    blk, p);
 		}
 	}
 
@@ -4433,11 +4439,11 @@ static int st_remove(struct device *dev)
 	remove_cdevs(tpnt);
 
 	mutex_lock(&st_ref_mutex);
-	kref_put(&tpnt->kref, scsi_tape_release);
-	mutex_unlock(&st_ref_mutex);
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, index);
 	spin_unlock(&st_index_lock);
+	kref_put(&tpnt->kref, scsi_tape_release);
+	mutex_unlock(&st_ref_mutex);
 	return 0;
 }
 
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0868b7d406fb..8d79b3ee42b8 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -364,7 +364,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
 	}
 
 	i = 0;
-	while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
+	while (1) {
+		clk = of_clk_get(dev->of_node, i++);
+		if (IS_ERR(clk)) {
+			error = PTR_ERR(clk);
+			if (error == -ENOENT)
+				break;
+
+			dev_err(dev, "failed to get clock %d: %d\n", i - 1,
+				error);
+			pm_clk_destroy(dev);
+			return error;
+		}
+
 		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
 		error = pm_clk_add_clk(dev, clk);
 		if (error) {
@@ -443,7 +455,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
@@ -617,7 +629,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 				parent_domain->name, child_domain->name);
 		}
 
-		rockchip_pm_add_subdomain(pmu, np);
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error)
+			goto err_out;
 	}
 
 	return 0;
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e57e1f75cd9f..1dc579d9e3c4 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -669,7 +669,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_master_resume(master);
+	ret = spi_master_resume(master);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index dc4ed0ff1ae2..87e9e349b3c6 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -915,7 +915,6 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
 {
 	struct gb_tty *gb_tty = gb_gbphy_get_data(gbphy_dev);
 	struct gb_connection *connection = gb_tty->connection;
-	struct tty_struct *tty;
 	int ret;
 
 	ret = gbphy_runtime_get_sync(gbphy_dev);
@@ -928,11 +927,7 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
 	wake_up_all(&gb_tty->wioctl);
 	mutex_unlock(&gb_tty->mutex);
 
-	tty = tty_port_tty_get(&gb_tty->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&gb_tty->port);
 
 	gb_connection_disable_rx(connection);
 	tty_unregister_device(gb_tty_driver, gb_tty->minor);
@@ -960,7 +955,8 @@ static int gb_tty_init(void)
 	gb_tty_driver->minor_start = 0;
 	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			       TTY_DRIVER_RESET_SAVED_TERMIOS;
 	gb_tty_driver->init_termios = tty_std_termios;
 	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
 		CREAD | HUPCL | CLOCAL;
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 41b93f09e6df..8b87213f69a7 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1017,8 +1017,8 @@ static int rkvdec_probe(struct platform_device *pdev)
 	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					rkvdec_irq_handler, IRQF_ONESHOT,
diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 11d415c0c05d..b6a9fef71ba2 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -832,7 +832,7 @@ static int zoran_init_video_device(struct zoran *zr, struct video_device *video_
 static void zoran_exit_video_devices(struct zoran *zr)
 {
 	video_unregister_device(zr->video_dev);
-	kfree(zr->video_dev);
+	zr->video_dev = NULL;
 }
 
 static int zoran_init_video_devices(struct zoran *zr)
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index a1cd81d4a114..16fb72eb3d18 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -578,7 +578,7 @@ static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 6604fe7b378a..29a83f1e1fbf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2023,7 +2023,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		if (i + 1 >= in_len)
+			break;
+
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 90f0983767f3..c92db34b2ad6 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -275,7 +275,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, 0,
 				      base, pitch, Bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index aff69661c8e6..a693d9f1d0d5 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -73,7 +73,7 @@ struct lynx_accel {
 			   u32 rop2);
 
 	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
-			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+			    u32 start_bit, u32 d_base, u32 d_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 			    u32 height, u32 f_color, u32 b_color, u32 rop2);
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 24b9077a634a..eb47c18a585d 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -301,8 +301,6 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
  * sm750_hw_imageblit
  * @accel: Acceleration device data
  * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *	      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
  * @dBase: Address of destination: offset in frame buffer
@@ -317,7 +315,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 startBit, u32 dBase, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2)
 {
@@ -406,7 +404,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
 
-		pSrcbuf += srcDelta;
+		pSrcbuf += ulBytesPerScan;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..df48ed57a054 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -220,8 +220,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 /**
  * sm750_hw_imageblit
  * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
  * @dBase: Address of destination: offset in frame buffer
@@ -236,7 +234,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 startBit, u32 dBase, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2);
 
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 4ae5314e8c45..a0a024ae652f 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1284,17 +1284,24 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 		return -EINVAL;
 	}
 
+	if (iscsit_get_tpg(discovery_tpg) < 0)
+		return -EINVAL;
+
 	param = iscsi_find_param_from_key(AUTHMETHOD,
 				discovery_tpg->param_list);
-	if (!param)
-		return -EINVAL;
+	if (!param) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (op) {
 		/*
 		 * Reset the AuthMethod key to CHAP.
 		 */
-		if (iscsi_update_param_value(param, CHAP) < 0)
-			return -EINVAL;
+		if (iscsi_update_param_value(param, CHAP) < 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		discovery_tpg->tpg_attrib.authentication = 1;
 		iscsit_global->discovery_acl.node_auth.enforce_discovery_auth = 1;
@@ -1305,8 +1312,10 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 		/*
 		 * Reset the AuthMethod key to CHAP,None
 		 */
-		if (iscsi_update_param_value(param, "CHAP,None") < 0)
-			return -EINVAL;
+		if (iscsi_update_param_value(param, "CHAP,None") < 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		discovery_tpg->tpg_attrib.authentication = 0;
 		iscsit_global->discovery_acl.node_auth.enforce_discovery_auth = 0;
@@ -1315,7 +1324,10 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 			" Discovery TPG\n");
 	}
 
-	return count;
+	err = count;
+out:
+	iscsit_put_tpg(discovery_tpg);
+	return err;
 }
 
 CONFIGFS_ATTR(iscsi_disc_, enforce_discovery_auth);
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 50c0d839fe75..a1bb5652d908 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -707,14 +707,6 @@ static int optee_probe(struct platform_device *pdev)
 	}
 	optee->supp_teedev = teedev;
 
-	rc = tee_device_register(optee->teedev);
-	if (rc)
-		goto err;
-
-	rc = tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err;
-
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_wait_queue_init(&optee->wait_queue);
@@ -744,14 +736,24 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err_remove;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err_remove;
+
 	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
-	if (rc) {
-		optee_remove(pdev);
-		return rc;
-	}
+	if (rc)
+		goto err_remove;
 
 	pr_info("initialized driver\n");
 	return 0;
+
+err_remove:
+	optee_remove(pdev);
+	return rc;
 err:
 	if (optee) {
 		/*
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 7c070a58f4b9..36c64ed467d5 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -65,7 +65,6 @@ struct tb_ctl {
 #define tb_ctl_dbg(ctl, format, arg...) \
 	dev_dbg(&(ctl)->nhi->pdev->dev, format, ## arg)
 
-static DECLARE_WAIT_QUEUE_HEAD(tb_cfg_request_cancel_queue);
 /* Serializes access to request kref_get/put */
 static DEFINE_MUTEX(tb_cfg_request_lock);
 
@@ -123,11 +122,14 @@ void tb_cfg_request_put(struct tb_cfg_request *req)
 static int tb_cfg_request_enqueue(struct tb_ctl *ctl,
 				  struct tb_cfg_request *req)
 {
+	tb_cfg_request_get(req);
+
 	WARN_ON(test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags));
 	WARN_ON(req->ctl);
 
 	mutex_lock(&ctl->request_queue_lock);
 	if (!ctl->running) {
+		tb_cfg_request_put(req);
 		mutex_unlock(&ctl->request_queue_lock);
 		return -ENOTCONN;
 	}
@@ -138,28 +140,24 @@ static int tb_cfg_request_enqueue(struct tb_ctl *ctl,
 	return 0;
 }
 
+static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
+{
+	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
+}
+
 static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 {
 	struct tb_ctl *ctl = req->ctl;
 
 	mutex_lock(&ctl->request_queue_lock);
-	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
-		mutex_unlock(&ctl->request_queue_lock);
-		return;
+	if (tb_cfg_request_is_active(req)) {
+		list_del(&req->list);
+		clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
+		tb_cfg_request_put(req);
 	}
-
-	list_del(&req->list);
-	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
-	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
-		wake_up(&tb_cfg_request_cancel_queue);
 	mutex_unlock(&ctl->request_queue_lock);
 }
 
-static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
-{
-	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
-}
-
 static struct tb_cfg_request *
 tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 {
@@ -169,7 +167,8 @@ tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 	mutex_lock(&pkg->ctl->request_queue_lock);
 	list_for_each_entry(req, &pkg->ctl->request_queue, list) {
 		tb_cfg_request_get(req);
-		if (req->match(req, pkg)) {
+		if (!test_bit(TB_CFG_REQUEST_CANCELED, &req->flags) &&
+		    req->match(req, pkg)) {
 			found = true;
 			break;
 		}
@@ -496,8 +495,11 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	 */
 	req = tb_cfg_request_find(pkg->ctl, pkg);
 	if (req) {
-		if (req->copy(req, pkg))
+		mutex_lock(&pkg->ctl->request_queue_lock);
+		if (!test_bit(TB_CFG_REQUEST_CANCELED, &req->flags) &&
+		    req->copy(req, pkg))
 			schedule_work(&req->work);
+		mutex_unlock(&pkg->ctl->request_queue_lock);
 		tb_cfg_request_put(req);
 	}
 
@@ -513,7 +515,6 @@ static void tb_cfg_request_work(struct work_struct *work)
 		req->callback(req->callback_data);
 
 	tb_cfg_request_dequeue(req);
-	tb_cfg_request_put(req);
 }
 
 /**
@@ -537,10 +538,9 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 	INIT_WORK(&req->work, tb_cfg_request_work);
 	INIT_LIST_HEAD(&req->list);
 
-	tb_cfg_request_get(req);
 	ret = tb_cfg_request_enqueue(ctl, req);
 	if (ret)
-		goto err_put;
+		return ret;
 
 	ret = tb_ctl_tx(ctl, req->request, req->request_size,
 			req->request_type);
@@ -554,9 +554,6 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 
 err_dequeue:
 	tb_cfg_request_dequeue(req);
-err_put:
-	tb_cfg_request_put(req);
-
 	return ret;
 }
 
@@ -570,9 +567,11 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
  */
 void tb_cfg_request_cancel(struct tb_cfg_request *req, int err)
 {
+	mutex_lock(&req->ctl->request_queue_lock);
 	set_bit(TB_CFG_REQUEST_CANCELED, &req->flags);
-	schedule_work(&req->work);
-	wait_event(tb_cfg_request_cancel_queue, !tb_cfg_request_is_active(req));
+	mutex_unlock(&req->ctl->request_queue_lock);
+	cancel_work_sync(&req->work);
+	tb_cfg_request_dequeue(req);
 	req->result.err = err;
 }
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index aee53c8759ac..d0f60fff1f0a 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -353,6 +353,10 @@ static int tb_xdp_properties_request(struct tb_ctl *ctl, u64 route,
 
 		len += sizeof(res->hdr.xd_hdr) / 4;
 		len -= sizeof(*res) / 4;
+		if (len > TB_XDP_PROPERTIES_MAX_DATA_LENGTH) {
+			ret = -EINVAL;
+			goto err;
+		}
 
 		if (res->offset != req.offset) {
 			ret = -EINVAL;
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 1e60dbef676c..171ca448145e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1144,11 +1144,6 @@ static int rs_ioctl(struct tty_struct *tty,
 				local_irq_save(flags);
 				cnow = info->icount; /* atomic copy */
 				local_irq_restore(flags);
-				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
-				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
-					ret = -EIO; /* no change => error */
-					break;
-				}
 				if ( ((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 				     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 				     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
@@ -1156,6 +1151,10 @@ static int rs_ioctl(struct tty_struct *tty,
 					ret = 0;
 					break;
 				}
+				if (tty_io_error(tty)) {
+					ret = -EIO;
+					break;
+				}
 				schedule();
 				/* see if a signal did it */
 				if (signal_pending(current)) {
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 8a32418feb74..50986099ecb3 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1155,8 +1155,8 @@ static int brcmuart_remove(struct platform_device *pdev)
 	struct brcmuart_priv *priv = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(priv->debugfs_dir);
-	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
+	hrtimer_cancel(&priv->hrt);
 	brcmuart_free_bufs(&pdev->dev, priv);
 	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b9ef426d5aae..11338cb7b211 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
@@ -2005,6 +2006,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, int ch)
 {
@@ -2472,11 +2476,18 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
-	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	mutex_lock(&imx_uart_ports_lock);
+	if (imx_uart_ports[sport->port.line]) {
+		ret = -EBUSY;
+	} else {
+		imx_uart_ports[sport->port.line] = sport;
+		ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+		if (ret)
+			imx_uart_ports[sport->port.line] = NULL;
+	}
+	mutex_unlock(&imx_uart_ports_lock);
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2484,11 +2495,13 @@ static int imx_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_uart_remove(struct platform_device *pdev)
+static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	guard(mutex)(&imx_uart_ports_lock);
+	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
@@ -2655,7 +2668,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove = imx_uart_remove,
+	.remove_new = imx_uart_remove,
 
 	.driver = {
 		.name = "imx-uart",
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index d988511f8b32..11d3fe649fcb 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -190,6 +190,11 @@ static void cleanup_kgdboc(void)
 		return;
 	kgdboc_unregister_kbd();
 	kgdb_unregister_io_module(&kgdboc_io_ops);
+
+	if (kgdb_tty_driver) {
+		tty_driver_kref_put(kgdb_tty_driver);
+		kgdb_tty_driver = NULL;
+	}
 }
 
 static int configure_kgdboc(void)
@@ -250,6 +255,10 @@ static int configure_kgdboc(void)
 	kgdb_unregister_io_module(&kgdboc_io_ops);
 noconfig:
 	kgdboc_unregister_kbd();
+	if (kgdb_tty_driver) {
+		tty_driver_kref_put(kgdb_tty_driver);
+		kgdb_tty_driver = NULL;
+	}
 	configured = 0;
 
 	return err;
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 8290ab72c05a..c31cce1c0182 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -568,12 +568,11 @@ static void max3100_shutdown(struct uart_port *port)
 		del_timer_sync(&s->timer);
 
 	if (s->workqueue) {
-		flush_workqueue(s->workqueue);
+		free_irq(s->irq, s);
+		cancel_work_sync(&s->work);
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (s->irq)
-		free_irq(s->irq, s);
 
 	/* set shutdown mode to save power */
 	if (s->max3100_hw_suspend)
@@ -832,6 +831,15 @@ static int max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->workqueue) {
+				free_irq(s->irq, s);
+				cancel_work_sync(&s->work);
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 85b245bafbad..1d0533da4ab8 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1017,9 +1017,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
 	 * only.
 	 */
-	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
-						: GENI_DEFAULT_BW;
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
+	avg_bw_core = baud > 115200 ? CORE_2X_50_MHZ : CORE_2X_19_2_MHZ;
+	port->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(avg_bw_core);
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 52d5c72227e7..85f9f347ef47 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -307,11 +307,19 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
 	unsigned int lsr, tmout = 10000;
+	bool clear_tx = !!(fcr_bits & UART_FCR_CLEAR_XMIT);
 
 	if (tup->rts_active)
 		set_rts(tup, false);
 
-	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
+	/*
+	 * Leaving FIFO mode below is a workaround for a Tegra30
+	 * restriction on clearing the Tx FIFO while FIFO mode is
+	 * enabled. It empties both FIFOs, so applying it to an
+	 * Rx-only reset would destroy an in-flight transmission.
+	 * Only take that path when the caller asked for CLEAR_XMIT.
+	 */
+	if (tup->cdata->allow_txfifo_reset_fifo_mode || !clear_tx) {
 		fcr |= fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 		tegra_uart_write(tup, fcr, UART_FCR);
 	} else {
@@ -336,9 +344,15 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
 
+	/*
+	 * Only wait for the transmitter to drain when the Tx FIFO was
+	 * part of the reset. For an Rx-only reset it is left intact,
+	 * and waiting for TEMT here would spin for a full frame time.
+	 */
 	do {
 		lsr = tegra_uart_read(tup, UART_LSR);
-		if ((lsr & UART_LSR_TEMT) && !(lsr & UART_LSR_DR))
+		if ((!clear_tx || (lsr & UART_LSR_TEMT)) &&
+		    !(lsr & UART_LSR_DR))
 			break;
 		udelay(1);
 	} while (--tmout);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 404354727d19..a52e88a750f9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1213,12 +1213,12 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&uport->lock);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 		spin_unlock_irq(&uport->lock);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
@@ -3036,7 +3036,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
-	struct tty_struct *tty;
 	int ret = 0;
 
 	mutex_lock(&port_mutex);
@@ -3064,11 +3063,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	tty_port_unregister_device(port, drv->tty_driver, uport->line);
 
-	tty = tty_port_tty_get(port);
-	if (tty) {
-		tty_vhangup(port->tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(port);
 
 	/*
 	 * If the port is used as a console, unregister it
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index e15b2bf69904..868bc25bfc88 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -677,6 +677,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(vt8500_port->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
+		clk_put(vt8500_port->clk);
 		return ret;
 	}
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d63ab274ff4a..ce15f9232195 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -158,14 +158,13 @@ static int tty_fasync(int fd, struct file *filp, int on);
 static void release_tty(struct tty_struct *tty, int idx);
 
 /**
- *	free_tty_struct		-	free a disused tty
- *	@tty: tty struct to free
+ * free_tty_struct	-	free a disused tty
+ * @tty: tty struct to free
  *
- *	Free the write buffers, tty queue and tty memory itself.
+ * Free the write buffers, tty queue and tty memory itself.
  *
- *	Locking: none. Must be called after tty is definitely unused
+ * Locking: none. Must be called after tty is definitely unused
  */
-
 static void free_tty_struct(struct tty_struct *tty)
 {
 	tty_ldisc_deinit(tty);
@@ -206,8 +205,9 @@ void tty_add_file(struct tty_struct *tty, struct file *file)
 	spin_unlock(&tty->files_lock);
 }
 
-/*
+/**
  * tty_free_file - free file->private_data
+ * @file: to free private_data of
  *
  * This shall be used only for fail path handling when tty_add_file was not
  * called yet.
@@ -233,15 +233,14 @@ static void tty_del_file(struct file *file)
 }
 
 /**
- *	tty_name	-	return tty naming
- *	@tty: tty structure
+ * tty_name	-	return tty naming
+ * @tty: tty structure
  *
- *	Convert a tty structure into a name. The name reflects the kernel
- *	naming policy and if udev is in use may not reflect user space
+ * Convert a tty structure into a name. The name reflects the kernel naming
+ * policy and if udev is in use may not reflect user space
  *
- *	Locking: none
+ * Locking: none
  */
-
 const char *tty_name(const struct tty_struct *tty)
 {
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
@@ -303,16 +302,15 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 }
 
 /**
- *	get_tty_driver		-	find device of a tty
- *	@device: device identifier
- *	@index: returns the index of the tty
+ * get_tty_driver		-	find device of a tty
+ * @device: device identifier
+ * @index: returns the index of the tty
  *
- *	This routine returns a tty driver structure, given a device number
- *	and also passes back the index number.
+ * This routine returns a tty driver structure, given a device number and also
+ * passes back the index number.
  *
- *	Locking: caller must hold tty_mutex
+ * Locking: caller must hold tty_mutex
  */
-
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
@@ -329,17 +327,17 @@ static struct tty_driver *get_tty_driver(dev_t device, int *index)
 }
 
 /**
- *	tty_dev_name_to_number	-	return dev_t for device name
- *	@name: user space name of device under /dev
- *	@number: pointer to dev_t that this function will populate
+ * tty_dev_name_to_number	-	return dev_t for device name
+ * @name: user space name of device under /dev
+ * @number: pointer to dev_t that this function will populate
  *
- *	This function converts device names like ttyS0 or ttyUSB1 into dev_t
- *	like (4, 64) or (188, 1). If no corresponding driver is registered then
- *	the function returns -ENODEV.
+ * This function converts device names like ttyS0 or ttyUSB1 into dev_t like
+ * (4, 64) or (188, 1). If no corresponding driver is registered then the
+ * function returns -%ENODEV.
  *
- *	Locking: this acquires tty_mutex to protect the tty_drivers list from
- *		being modified while we are traversing it, and makes sure to
- *		release it before exiting.
+ * Locking: this acquires tty_mutex to protect the tty_drivers list from
+ *	being modified while we are traversing it, and makes sure to
+ *	release it before exiting.
  */
 int tty_dev_name_to_number(const char *name, dev_t *number)
 {
@@ -381,13 +379,12 @@ EXPORT_SYMBOL_GPL(tty_dev_name_to_number);
 #ifdef CONFIG_CONSOLE_POLL
 
 /**
- *	tty_find_polling_driver	-	find device of a polled tty
- *	@name: name string to match
- *	@line: pointer to resulting tty line nr
+ * tty_find_polling_driver	-	find device of a polled tty
+ * @name: name string to match
+ * @line: pointer to resulting tty line nr
  *
- *	This routine returns a tty driver structure, given a name
- *	and the condition that the tty driver is capable of polled
- *	operation.
+ * This routine returns a tty driver structure, given a name and the condition
+ * that the tty driver is capable of polled operation.
  */
 struct tty_driver *tty_find_polling_driver(char *name, int *line)
 {
@@ -515,14 +512,13 @@ static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
 /**
- *	tty_wakeup	-	request more data
- *	@tty: terminal
+ * tty_wakeup	-	request more data
+ * @tty: terminal
  *
- *	Internal and external helper for wakeups of tty. This function
- *	informs the line discipline if present that the driver is ready
- *	to receive more output data.
+ * Internal and external helper for wakeups of tty. This function informs the
+ * line discipline if present that the driver is ready to receive more output
+ * data.
  */
-
 void tty_wakeup(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld;
@@ -540,11 +536,11 @@ void tty_wakeup(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
- *	tty_release_redirect	-	Release a redirect on a pty if present
- *	@tty: tty device
+ * tty_release_redirect	-	Release a redirect on a pty if present
+ * @tty: tty device
  *
- *	This is available to the pty code so if the master closes, if the
- *	slave is a redirect it can release the redirect.
+ * This is available to the pty code so if the master closes, if the slave is a
+ * redirect it can release the redirect.
  */
 static struct file *tty_release_redirect(struct tty_struct *tty)
 {
@@ -561,27 +557,29 @@ static struct file *tty_release_redirect(struct tty_struct *tty)
 }
 
 /**
- *	__tty_hangup		-	actual handler for hangup events
- *	@tty: tty device
- *	@exit_session: if non-zero, signal all foreground group processes
- *
- *	This can be called by a "kworker" kernel thread.  That is process
- *	synchronous but doesn't hold any locks, so we need to make sure we
- *	have the appropriate locks for what we're doing.
- *
- *	The hangup event clears any pending redirections onto the hung up
- *	device. It ensures future writes will error and it does the needed
- *	line discipline hangup and signal delivery. The tty object itself
- *	remains intact.
- *
- *	Locking:
- *		BTM
- *		  redirect lock for undoing redirection
- *		  file list lock for manipulating list of ttys
- *		  tty_ldiscs_lock from called functions
- *		  termios_rwsem resetting termios data
- *		  tasklist_lock to walk task list for hangup event
- *		    ->siglock to protect ->signal/->sighand
+ * __tty_hangup		-	actual handler for hangup events
+ * @tty: tty device
+ * @exit_session: if non-zero, signal all foreground group processes
+ *
+ * This can be called by a "kworker" kernel thread. That is process synchronous
+ * but doesn't hold any locks, so we need to make sure we have the appropriate
+ * locks for what we're doing.
+ *
+ * The hangup event clears any pending redirections onto the hung up device. It
+ * ensures future writes will error and it does the needed line discipline
+ * hangup and signal delivery. The tty object itself remains intact.
+ *
+ * Locking:
+ *  * BTM
+ *
+ *   * redirect lock for undoing redirection
+ *   * file list lock for manipulating list of ttys
+ *   * tty_ldiscs_lock from called functions
+ *   * termios_rwsem resetting termios data
+ *   * tasklist_lock to walk task list for hangup event
+ *
+ *    * ->siglock to protect ->signal/->sighand
+ *
  */
 static void __tty_hangup(struct tty_struct *tty, int exit_session)
 {
@@ -638,6 +636,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 
 	tty_ldisc_hangup(tty, cons_filp != NULL);
 
+	wake_up_interruptible(&tty->break_wait);
+
 	spin_lock_irq(&tty->ctrl.lock);
 	clear_bit(TTY_THROTTLED, &tty->flags);
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -682,13 +682,12 @@ static void do_tty_hangup(struct work_struct *work)
 }
 
 /**
- *	tty_hangup		-	trigger a hangup event
- *	@tty: tty to hangup
+ * tty_hangup		-	trigger a hangup event
+ * @tty: tty to hangup
  *
- *	A carrier loss (virtual or otherwise) has occurred on this like
- *	schedule a hangup sequence to run after this event.
+ * A carrier loss (virtual or otherwise) has occurred on @tty. Schedule a
+ * hangup sequence to run after this event.
  */
-
 void tty_hangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "hangup\n");
@@ -697,14 +696,13 @@ void tty_hangup(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_hangup);
 
 /**
- *	tty_vhangup		-	process vhangup
- *	@tty: tty to hangup
+ * tty_vhangup		-	process vhangup
+ * @tty: tty to hangup
  *
- *	The user has asked via system call for the terminal to be hung up.
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * The user has asked via system call for the terminal to be hung up. We do
+ * this synchronously so that when the syscall returns the process is complete.
+ * That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "vhangup\n");
@@ -714,11 +712,10 @@ EXPORT_SYMBOL(tty_vhangup);
 
 
 /**
- *	tty_vhangup_self	-	process vhangup for own ctty
+ * tty_vhangup_self	-	process vhangup for own ctty
  *
- *	Perform a vhangup on the current controlling tty
+ * Perform a vhangup on the current controlling tty
  */
-
 void tty_vhangup_self(void)
 {
 	struct tty_struct *tty;
@@ -731,16 +728,15 @@ void tty_vhangup_self(void)
 }
 
 /**
- *	tty_vhangup_session		-	hangup session leader exit
- *	@tty: tty to hangup
+ * tty_vhangup_session	-	hangup session leader exit
+ * @tty: tty to hangup
  *
- *	The session leader is exiting and hanging up its controlling terminal.
- *	Every process in the foreground process group is signalled SIGHUP.
+ * The session leader is exiting and hanging up its controlling terminal.
+ * Every process in the foreground process group is signalled %SIGHUP.
  *
- *	We do this synchronously so that when the syscall returns the process
- *	is complete. That guarantee is necessary for security reasons.
+ * We do this synchronously so that when the syscall returns the process is
+ * complete. That guarantee is necessary for security reasons.
  */
-
 void tty_vhangup_session(struct tty_struct *tty)
 {
 	tty_debug_hangup(tty, "session hangup\n");
@@ -748,13 +744,11 @@ void tty_vhangup_session(struct tty_struct *tty)
 }
 
 /**
- *	tty_hung_up_p		-	was tty hung up
- *	@filp: file pointer of tty
+ * tty_hung_up_p	-	was tty hung up
+ * @filp: file pointer of tty
  *
- *	Return true if the tty has been subject to a vhangup or a carrier
- *	loss
+ * Return: true if the tty has been subject to a vhangup or a carrier loss
  */
-
 int tty_hung_up_p(struct file *filp)
 {
 	return (filp && filp->f_op == &hung_up_tty_fops);
@@ -771,20 +765,18 @@ void __stop_tty(struct tty_struct *tty)
 }
 
 /**
- *	stop_tty	-	propagate flow control
- *	@tty: tty to stop
+ * stop_tty	-	propagate flow control
+ * @tty: tty to stop
  *
- *	Perform flow control to the driver. May be called
- *	on an already stopped device and will not re-call the driver
- *	method.
+ * Perform flow control to the driver. May be called on an already stopped
+ * device and will not re-call the &tty_driver->stop() method.
  *
- *	This functionality is used by both the line disciplines for
- *	halting incoming flow and by the driver. It may therefore be
- *	called from any context, may be under the tty atomic_write_lock
- *	but not always.
+ * This functionality is used by both the line disciplines for halting incoming
+ * flow and by the driver. It may therefore be called from any context, may be
+ * under the tty %atomic_write_lock but not always.
  *
- *	Locking:
- *		flow.lock
+ * Locking:
+ *	flow.lock
  */
 void stop_tty(struct tty_struct *tty)
 {
@@ -807,15 +799,15 @@ void __start_tty(struct tty_struct *tty)
 }
 
 /**
- *	start_tty	-	propagate flow control
- *	@tty: tty to start
+ * start_tty	-	propagate flow control
+ * @tty: tty to start
  *
- *	Start a tty that has been stopped if at all possible. If this
- *	tty was previous stopped and is now being started, the driver
- *	start method is invoked and the line discipline woken.
+ * Start a tty that has been stopped if at all possible. If @tty was previously
+ * stopped and is now being started, the &tty_driver->start() method is invoked
+ * and the line discipline woken.
  *
- *	Locking:
- *		flow.lock
+ * Locking:
+ *	flow.lock
  */
 void start_tty(struct tty_struct *tty)
 {
@@ -908,18 +900,17 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 
 
 /**
- *	tty_read	-	read method for tty device files
- *	@iocb: kernel I/O control block
- *	@to: destination for the data read
+ * tty_read	-	read method for tty device files
+ * @iocb: kernel I/O control block
+ * @to: destination for the data read
  *
- *	Perform the read system call function on this terminal device. Checks
- *	for hung up devices before calling the line discipline method.
+ * Perform the read system call function on this terminal device. Checks
+ * for hung up devices before calling the line discipline method.
  *
- *	Locking:
- *		Locks the line discipline internally while needed. Multiple
- *	read calls may be outstanding in parallel.
+ * Locking:
+ *	Locks the line discipline internally while needed. Multiple read calls
+ *	may be outstanding in parallel.
  */
-
 static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int i;
@@ -1069,13 +1060,12 @@ static inline ssize_t do_tty_write(
  * @tty: the destination tty_struct
  * @msg: the message to write
  *
- * This is used for messages that need to be redirected to a specific tty.
- * We don't put it into the syslog queue right now maybe in the future if
- * really needed.
+ * This is used for messages that need to be redirected to a specific tty. We
+ * don't put it into the syslog queue right now maybe in the future if really
+ * needed.
  *
  * We must still hold the BTM and test the CLOSING flag for the moment.
  */
-
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
 	if (tty) {
@@ -1113,18 +1103,18 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 }
 
 /**
- *	tty_write		-	write method for tty device file
- *	@iocb: kernel I/O control block
- *	@from: iov_iter with data to write
+ * tty_write		-	write method for tty device file
+ * @iocb: kernel I/O control block
+ * @from: iov_iter with data to write
  *
- *	Write data to a tty device via the line discipline.
+ * Write data to a tty device via the line discipline.
  *
- *	Locking:
- *		Locks the line discipline as required
- *		Writes to the tty driver are serialized by the atomic_write_lock
- *		and are then processed in chunks to the device. The line
- *		discipline write method will not be invoked in parallel for
- *		each device.
+ * Locking:
+ *	Locks the line discipline as required
+ *	Writes to the tty driver are serialized by the atomic_write_lock
+ *	and are then processed in chunks to the device. The line
+ *	discipline write method will not be invoked in parallel for
+ *	each device.
  */
 static ssize_t tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -1154,14 +1144,15 @@ ssize_t redirected_tty_write(struct kiocb *iocb, struct iov_iter *iter)
 	return tty_write(iocb, iter);
 }
 
-/*
- *	tty_send_xchar	-	send priority character
+/**
+ * tty_send_xchar	-	send priority character
+ * @tty: the tty to send to
+ * @ch: xchar to send
  *
- *	Send a high priority character to the tty even if stopped
+ * Send a high priority character to the tty even if stopped.
  *
- *	Locking: none for xchar method, write ordering for write method.
+ * Locking: none for xchar method, write ordering for write method.
  */
-
 int tty_send_xchar(struct tty_struct *tty, char ch)
 {
 	bool was_stopped = tty->flow.stopped;
@@ -1188,15 +1179,15 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 }
 
 /**
- *	pty_line_name	-	generate name for a pty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 6 bytes
+ * pty_line_name	-	generate name for a pty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 6 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a @driver reference and write it to the output buffer
+ * @p.
  *
- *	Locking: None
+ * Locking: None
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1209,15 +1200,15 @@ static void pty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_line_name	-	generate name for a tty
- *	@driver: the tty driver in use
- *	@index: the minor number
- *	@p: output buffer of at least 7 bytes
+ * tty_line_name	-	generate name for a tty
+ * @driver: the tty driver in use
+ * @index: the minor number
+ * @p: output buffer of at least 7 bytes
  *
- *	Generate a name from a driver reference and write it to the output
- *	buffer.
+ * Generate a name from a @driver reference and write it to the output buffer
+ * @p.
  *
- *	Locking: None
+ * Locking: None
  */
 static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 {
@@ -1229,15 +1220,15 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 }
 
 /**
- *	tty_driver_lookup_tty() - find an existing tty, if any
- *	@driver: the driver for the tty
- *	@file:   file object
- *	@idx:	 the minor number
+ * tty_driver_lookup_tty() - find an existing tty, if any
+ * @driver: the driver for the tty
+ * @file: file object
+ * @idx: the minor number
  *
- *	Return the tty, if found. If not found, return NULL or ERR_PTR() if the
- *	driver lookup() method returns an error.
+ * Return: the tty, if found. If not found, return %NULL or ERR_PTR() if the
+ * driver lookup() method returns an error.
  *
- *	Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
+ * Locking: tty_mutex must be held. If the tty is found, bump the tty kref.
  */
 static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct file *file, int idx)
@@ -1260,13 +1251,12 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_init_termios	-  helper for termios setup
- *	@tty: the tty to set up
+ * tty_init_termios	-  helper for termios setup
+ * @tty: the tty to set up
  *
- *	Initialise the termios structure for this tty. This runs under
- *	the tty_mutex currently so we can be relaxed about ordering.
+ * Initialise the termios structure for this tty. This runs under the
+ * %tty_mutex currently so we can be relaxed about ordering.
  */
-
 void tty_init_termios(struct tty_struct *tty)
 {
 	struct ktermios *tp;
@@ -1300,16 +1290,15 @@ int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
 /**
- *	tty_driver_install_tty() - install a tty entry in the driver
- *	@driver: the driver for the tty
- *	@tty: the tty
+ * tty_driver_install_tty() - install a tty entry in the driver
+ * @driver: the driver for the tty
+ * @tty: the tty
  *
- *	Install a tty object into the driver tables. The tty->index field
- *	will be set by the time this is called. This method is responsible
- *	for ensuring any need additional structures are allocated and
- *	configured.
+ * Install a tty object into the driver tables. The @tty->index field will be
+ * set by the time this is called. This method is responsible for ensuring any
+ * need additional structures are allocated and configured.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
@@ -1319,14 +1308,14 @@ static int tty_driver_install_tty(struct tty_driver *driver,
 }
 
 /**
- *	tty_driver_remove_tty() - remove a tty from the driver tables
- *	@driver: the driver for the tty
- *	@tty: tty to remove
+ * tty_driver_remove_tty() - remove a tty from the driver tables
+ * @driver: the driver for the tty
+ * @tty: tty to remove
  *
- *	Remvoe a tty object from the driver tables. The tty->index field
- *	will be set by the time this is called.
+ * Remove a tty object from the driver tables. The tty->index field will be set
+ * by the time this is called.
  *
- *	Locking: tty_mutex for now
+ * Locking: tty_mutex for now
  */
 static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *tty)
 {
@@ -1337,13 +1326,13 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 }
 
 /**
- *	tty_reopen()	- fast re-open of an open tty
- *	@tty: the tty to open
+ * tty_reopen()	- fast re-open of an open tty
+ * @tty: the tty to open
  *
- *	Return 0 on success, -errno on error.
- *	Re-opens on master ptys are not allowed and return -EIO.
+ * Re-opens on master ptys are not allowed and return -%EIO.
  *
- *	Locking: Caller must hold tty_lock
+ * Locking: Caller must hold tty_lock
+ * Return: 0 on success, -errno on error.
  */
 static int tty_reopen(struct tty_struct *tty)
 {
@@ -1381,30 +1370,28 @@ static int tty_reopen(struct tty_struct *tty)
 }
 
 /**
- *	tty_init_dev		-	initialise a tty device
- *	@driver: tty driver we are opening a device on
- *	@idx: device index
+ * tty_init_dev		-	initialise a tty device
+ * @driver: tty driver we are opening a device on
+ * @idx: device index
  *
- *	Prepare a tty device. This may not be a "new" clean device but
- *	could also be an active device. The pty drivers require special
- *	handling because of this.
+ * Prepare a tty device. This may not be a "new" clean device but could also be
+ * an active device. The pty drivers require special handling because of this.
  *
- *	Locking:
- *		The function is called under the tty_mutex, which
- *	protects us from the tty struct or driver itself going away.
+ * Locking:
+ *	The function is called under the tty_mutex, which protects us from the
+ *	tty struct or driver itself going away.
  *
- *	On exit the tty device has the line discipline attached and
- *	a reference count of 1. If a pair was created for pty/tty use
- *	and the other was a pty master then it too has a reference count of 1.
+ * On exit the tty device has the line discipline attached and a reference
+ * count of 1. If a pair was created for pty/tty use and the other was a pty
+ * master then it too has a reference count of 1.
  *
- * WSH 06/09/97: Rewritten to remove races and properly clean up after a
- * failed open.  The new code protects the open with a mutex, so it's
- * really quite straightforward.  The mutex locking can probably be
- * relaxed for the (most common) case of reopening a tty.
+ * WSH 06/09/97: Rewritten to remove races and properly clean up after a failed
+ * open. The new code protects the open with a mutex, so it's really quite
+ * straightforward. The mutex locking can probably be relaxed for the (most
+ * common) case of reopening a tty.
  *
- *	Return: returned tty structure
+ * Return: new tty structure
  */
-
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -1505,10 +1492,10 @@ void tty_save_termios(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_save_termios);
 
 /**
- *	tty_flush_works		-	flush all works of a tty/pty pair
- *	@tty: tty device to flush works for (or either end of a pty pair)
+ * tty_flush_works	-	flush all works of a tty/pty pair
+ * @tty: tty device to flush works for (or either end of a pty pair)
  *
- *	Sync flush all works belonging to @tty (and the 'other' tty).
+ * Sync flush all works belonging to @tty (and the 'other' tty).
  */
 static void tty_flush_works(struct tty_struct *tty)
 {
@@ -1521,19 +1508,19 @@ static void tty_flush_works(struct tty_struct *tty)
 }
 
 /**
- *	release_one_tty		-	release tty structure memory
- *	@work: work of tty we are obliterating
+ * release_one_tty	-	release tty structure memory
+ * @work: work of tty we are obliterating
  *
- *	Releases memory associated with a tty structure, and clears out the
- *	driver table slots. This function is called when a device is no longer
- *	in use. It also gets called when setup of a device fails.
+ * Releases memory associated with a tty structure, and clears out the
+ * driver table slots. This function is called when a device is no longer
+ * in use. It also gets called when setup of a device fails.
  *
- *	Locking:
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Locking:
+ *	takes the file list lock internally when working on the list of ttys
+ *	that the driver keeps.
  *
- *	This method gets called from a work queue so that the driver private
- *	cleanup ops can sleep (needed for USB at least)
+ * This method gets called from a work queue so that the driver private
+ * cleanup ops can sleep (needed for USB at least)
  */
 static void release_one_tty(struct work_struct *work)
 {
@@ -1570,13 +1557,12 @@ static void queue_release_one_tty(struct kref *kref)
 }
 
 /**
- *	tty_kref_put		-	release a tty kref
- *	@tty: tty device
+ * tty_kref_put		-	release a tty kref
+ * @tty: tty device
  *
- *	Release a reference to a tty device and if need be let the kref
- *	layer destruct the object for us
+ * Release a reference to the @tty device and if need be let the kref layer
+ * destruct the object for us.
  */
-
 void tty_kref_put(struct tty_struct *tty)
 {
 	if (tty)
@@ -1585,18 +1571,17 @@ void tty_kref_put(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_kref_put);
 
 /**
- *	release_tty		-	release tty structure memory
- *	@tty: tty device release
- *	@idx: index of the tty device release
- *
- *	Release both @tty and a possible linked partner (think pty pair),
- *	and decrement the refcount of the backing module.
+ * release_tty		-	release tty structure memory
+ * @tty: tty device release
+ * @idx: index of the tty device release
  *
- *	Locking:
- *		tty_mutex
- *		takes the file list lock internally when working on the list
- *	of ttys that the driver keeps.
+ * Release both @tty and a possible linked partner (think pty pair),
+ * and decrement the refcount of the backing module.
  *
+ * Locking:
+ *	tty_mutex
+ *	takes the file list lock internally when working on the list of ttys
+ *	that the driver keeps.
  */
 static void release_tty(struct tty_struct *tty, int idx)
 {
@@ -1621,12 +1606,12 @@ static void release_tty(struct tty_struct *tty, int idx)
 }
 
 /**
- *	tty_release_checks - check a tty before real release
- *	@tty: tty to check
- *	@idx: index of the tty
+ * tty_release_checks - check a tty before real release
+ * @tty: tty to check
+ * @idx: index of the tty
  *
- *	Performs some paranoid checking before true release of the @tty.
- *	This is a no-op unless TTY_PARANOIA_CHECK is defined.
+ * Performs some paranoid checking before true release of the @tty. This is a
+ * no-op unless %TTY_PARANOIA_CHECK is defined.
  */
 static int tty_release_checks(struct tty_struct *tty, int idx)
 {
@@ -1663,12 +1648,12 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 }
 
 /**
- *      tty_kclose      -       closes tty opened by tty_kopen
- *      @tty: tty device
+ * tty_kclose      -       closes tty opened by tty_kopen
+ * @tty: tty device
  *
- *      Performs the final steps to release and free a tty device. It is the
- *      same as tty_release_struct except that it also resets TTY_PORT_KOPENED
- *      flag on tty->port.
+ * Performs the final steps to release and free a tty device. It is the same as
+ * tty_release_struct() except that it also resets %TTY_PORT_KOPENED flag on
+ * @tty->port.
  */
 void tty_kclose(struct tty_struct *tty)
 {
@@ -1693,12 +1678,12 @@ void tty_kclose(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_kclose);
 
 /**
- *	tty_release_struct	-	release a tty struct
- *	@tty: tty device
- *	@idx: index of the tty
+ * tty_release_struct	-	release a tty struct
+ * @tty: tty device
+ * @idx: index of the tty
  *
- *	Performs the final steps to release and free a tty device. It is
- *	roughly the reverse of tty_init_dev.
+ * Performs the final steps to release and free a tty device. It is roughly the
+ * reverse of tty_init_dev().
  */
 void tty_release_struct(struct tty_struct *tty, int idx)
 {
@@ -1722,24 +1707,23 @@ void tty_release_struct(struct tty_struct *tty, int idx)
 EXPORT_SYMBOL_GPL(tty_release_struct);
 
 /**
- *	tty_release		-	vfs callback for close
- *	@inode: inode of tty
- *	@filp: file pointer for handle to tty
+ * tty_release		-	vfs callback for close
+ * @inode: inode of tty
+ * @filp: file pointer for handle to tty
  *
- *	Called the last time each file handle is closed that references
- *	this tty. There may however be several such references.
+ * Called the last time each file handle is closed that references this tty.
+ * There may however be several such references.
  *
- *	Locking:
- *		Takes bkl. See tty_release_dev
+ * Locking:
+ *	Takes BKL. See tty_release_dev().
  *
- * Even releasing the tty structures is a tricky business.. We have
- * to be very careful that the structures are all released at the
- * same time, as interrupts might otherwise get the wrong pointers.
+ * Even releasing the tty structures is a tricky business. We have to be very
+ * careful that the structures are all released at the same time, as interrupts
+ * might otherwise get the wrong pointers.
  *
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-
 int tty_release(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -1882,15 +1866,15 @@ int tty_release(struct inode *inode, struct file *filp)
 }
 
 /**
- *	tty_open_current_tty - get locked tty of current task
- *	@device: device number
- *	@filp: file pointer to tty
- *	@return: locked tty of the current task iff @device is /dev/tty
+ * tty_open_current_tty - get locked tty of current task
+ * @device: device number
+ * @filp: file pointer to tty
+ * @return: locked tty of the current task iff @device is /dev/tty
  *
- *	Performs a re-open of the current task's controlling tty.
+ * Performs a re-open of the current task's controlling tty.
  *
- *	We cannot return driver and index like for the other nodes because
- *	devpts will not work then. It expects inodes to be from devpts FS.
+ * We cannot return driver and index like for the other nodes because devpts
+ * will not work then. It expects inodes to be from devpts FS.
  */
 static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 {
@@ -1918,16 +1902,17 @@ static struct tty_struct *tty_open_current_tty(dev_t device, struct file *filp)
 }
 
 /**
- *	tty_lookup_driver - lookup a tty driver for a given device file
- *	@device: device number
- *	@filp: file pointer to tty
- *	@index: index for the device in the @return driver
- *	@return: driver for this inode (with increased refcount)
+ * tty_lookup_driver - lookup a tty driver for a given device file
+ * @device: device number
+ * @filp: file pointer to tty
+ * @index: index for the device in the @return driver
  *
- *	If @return is not erroneous, the caller is responsible to decrement the
- *	refcount by tty_driver_kref_put.
+ * If returned value is not erroneous, the caller is responsible to decrement
+ * the refcount by tty_driver_kref_put().
  *
- *	Locking: tty_mutex protects get_tty_driver
+ * Locking: %tty_mutex protects get_tty_driver()
+ *
+ * Return: driver for this inode (with increased refcount)
  */
 static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
 		int *index)
@@ -2003,19 +1988,18 @@ static struct tty_struct *tty_kopen(dev_t device, int shared)
 }
 
 /**
- *	tty_kopen_exclusive	-	open a tty device for kernel
- *	@device: dev_t of device to open
+ * tty_kopen_exclusive	-	open a tty device for kernel
+ * @device: dev_t of device to open
  *
- *	Opens tty exclusively for kernel. Performs the driver lookup,
- *	makes sure it's not already opened and performs the first-time
- *	tty initialization.
+ * Opens tty exclusively for kernel. Performs the driver lookup, makes sure
+ * it's not already opened and performs the first-time tty initialization.
  *
- *	Returns the locked initialized &tty_struct
+ * Claims the global %tty_mutex to serialize:
+ *  * concurrent first-time tty initialization
+ *  * concurrent tty driver removal w/ lookup
+ *  * concurrent tty removal from driver table
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Return: the locked initialized &tty_struct
  */
 struct tty_struct *tty_kopen_exclusive(dev_t device)
 {
@@ -2024,13 +2008,13 @@ struct tty_struct *tty_kopen_exclusive(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen_exclusive);
 
 /**
- *	tty_kopen_shared	-	open a tty device for shared in-kernel use
- *	@device: dev_t of device to open
+ * tty_kopen_shared	-	open a tty device for shared in-kernel use
+ * @device: dev_t of device to open
  *
- *	Opens an already existing tty for in-kernel use. Compared to
- *	tty_kopen_exclusive() above it doesn't ensure to be the only user.
+ * Opens an already existing tty for in-kernel use. Compared to
+ * tty_kopen_exclusive() above it doesn't ensure to be the only user.
  *
- *	Locking is identical to tty_kopen() above.
+ * Locking: identical to tty_kopen() above.
  */
 struct tty_struct *tty_kopen_shared(dev_t device)
 {
@@ -2039,19 +2023,20 @@ struct tty_struct *tty_kopen_shared(dev_t device)
 EXPORT_SYMBOL_GPL(tty_kopen_shared);
 
 /**
- *	tty_open_by_driver	-	open a tty device
- *	@device: dev_t of device to open
- *	@filp: file pointer to tty
+ * tty_open_by_driver	-	open a tty device
+ * @device: dev_t of device to open
+ * @filp: file pointer to tty
+ *
+ * Performs the driver lookup, checks for a reopen, or otherwise performs the
+ * first-time tty initialization.
  *
- *	Performs the driver lookup, checks for a reopen, or otherwise
- *	performs the first-time tty initialization.
  *
- *	Returns the locked initialized or re-opened &tty_struct
+ * Claims the global tty_mutex to serialize:
+ *  * concurrent first-time tty initialization
+ *  * concurrent tty driver removal w/ lookup
+ *  * concurrent tty removal from driver table
  *
- *	Claims the global tty_mutex to serialize:
- *	  - concurrent first-time tty initialization
- *	  - concurrent tty driver removal w/ lookup
- *	  - concurrent tty removal from driver table
+ * Return: the locked initialized or re-opened &tty_struct
  */
 static struct tty_struct *tty_open_by_driver(dev_t device,
 					     struct file *filp)
@@ -2106,29 +2091,28 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 }
 
 /**
- *	tty_open		-	open a tty device
- *	@inode: inode of device file
- *	@filp: file pointer to tty
+ * tty_open	-	open a tty device
+ * @inode: inode of device file
+ * @filp: file pointer to tty
  *
- *	tty_open and tty_release keep up the tty count that contains the
- *	number of opens done on a tty. We cannot use the inode-count, as
- *	different inodes might point to the same tty.
+ * tty_open() and tty_release() keep up the tty count that contains the number
+ * of opens done on a tty. We cannot use the inode-count, as different inodes
+ * might point to the same tty.
  *
- *	Open-counting is needed for pty masters, as well as for keeping
- *	track of serial lines: DTR is dropped when the last close happens.
- *	(This is not done solely through tty->count, now.  - Ted 1/27/92)
+ * Open-counting is needed for pty masters, as well as for keeping track of
+ * serial lines: DTR is dropped when the last close happens.
+ * (This is not done solely through tty->count, now.  - Ted 1/27/92)
  *
- *	The termios state of a pty is reset on first open so that
- *	settings don't persist across reuse.
+ * The termios state of a pty is reset on the first open so that settings don't
+ * persist across reuse.
  *
- *	Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
- *		 tty->count should protect the rest.
- *		 ->siglock protects ->signal/->sighand
+ * Locking:
+ *  * %tty_mutex protects tty, tty_lookup_driver() and tty_init_dev().
+ *  * @tty->count should protect the rest.
+ *  * ->siglock protects ->signal/->sighand
  *
- *	Note: the tty_unlock/lock cases without a ref are only safe due to
- *	tty_mutex
+ * Note: the tty_unlock/lock cases without a ref are only safe due to %tty_mutex
  */
-
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
@@ -2200,19 +2184,17 @@ static int tty_open(struct inode *inode, struct file *filp)
 }
 
 
-
 /**
- *	tty_poll	-	check tty status
- *	@filp: file being polled
- *	@wait: poll wait structures to update
+ * tty_poll	-	check tty status
+ * @filp: file being polled
+ * @wait: poll wait structures to update
  *
- *	Call the line discipline polling method to obtain the poll
- *	status of the device.
+ * Call the line discipline polling method to obtain the poll status of the
+ * device.
  *
- *	Locking: locks called line discipline but ldisc poll method
- *	may be re-entered freely by other callers.
+ * Locking: locks called line discipline but ldisc poll method may be
+ * re-entered freely by other callers.
  */
-
 static __poll_t tty_poll(struct file *filp, poll_table *wait)
 {
 	struct tty_struct *tty = file_tty(filp);
@@ -2280,20 +2262,18 @@ static int tty_fasync(int fd, struct file *filp, int on)
 }
 
 /**
- *	tiocsti			-	fake input character
- *	@tty: tty to fake input into
- *	@p: pointer to character
+ * tiocsti		-	fake input character
+ * @tty: tty to fake input into
+ * @p: pointer to character
  *
- *	Fake input to a tty device. Does the necessary locking and
- *	input management.
+ * Fake input to a tty device. Does the necessary locking and input management.
  *
- *	FIXME: does not honour flow control ??
+ * FIXME: does not honour flow control ??
  *
- *	Locking:
- *		Called functions take tty_ldiscs_lock
- *		current->signal->tty check is safe without locks
+ * Locking:
+ *  * Called functions take tty_ldiscs_lock
+ *  * current->signal->tty check is safe without locks
  */
-
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
@@ -2316,16 +2296,15 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 }
 
 /**
- *	tiocgwinsz		-	implement window query ioctl
- *	@tty: tty
- *	@arg: user buffer for result
+ * tiocgwinsz		-	implement window query ioctl
+ * @tty: tty
+ * @arg: user buffer for result
  *
- *	Copies the kernel idea of the window size into the user buffer.
+ * Copies the kernel idea of the window size into the user buffer.
  *
- *	Locking: tty->winsize_mutex is taken to ensure the winsize data
- *		is consistent.
+ * Locking: @tty->winsize_mutex is taken to ensure the winsize data is
+ * consistent.
  */
-
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	int err;
@@ -2338,14 +2317,13 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tty_do_resize		-	resize event
- *	@tty: tty being resized
- *	@ws: new dimensions
+ * tty_do_resize	-	resize event
+ * @tty: tty being resized
+ * @ws: new dimensions
  *
- *	Update the termios variables and send the necessary signals to
- *	peform a terminal resize correctly
+ * Update the termios variables and send the necessary signals to peform a
+ * terminal resize correctly.
  */
-
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 {
 	struct pid *pgrp;
@@ -2369,20 +2347,19 @@ int tty_do_resize(struct tty_struct *tty, struct winsize *ws)
 EXPORT_SYMBOL(tty_do_resize);
 
 /**
- *	tiocswinsz		-	implement window size set ioctl
- *	@tty: tty side of tty
- *	@arg: user buffer for result
+ * tiocswinsz		-	implement window size set ioctl
+ * @tty: tty side of tty
+ * @arg: user buffer for result
  *
- *	Copies the user idea of the window size to the kernel. Traditionally
- *	this is just advisory information but for the Linux console it
- *	actually has driver level meaning and triggers a VC resize.
+ * Copies the user idea of the window size to the kernel. Traditionally this is
+ * just advisory information but for the Linux console it actually has driver
+ * level meaning and triggers a VC resize.
  *
- *	Locking:
- *		Driver dependent. The default do_resize method takes the
- *	tty termios mutex and ctrl.lock. The console takes its own lock
- *	then calls into the default method.
+ * Locking:
+ *	Driver dependent. The default do_resize method takes the tty termios
+ *	mutex and ctrl.lock. The console takes its own lock then calls into the
+ *	default method.
  */
-
 static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 {
 	struct winsize tmp_ws;
@@ -2397,14 +2374,13 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
 }
 
 /**
- *	tioccons	-	allow admin to move logical console
- *	@file: the file to become console
+ * tioccons	-	allow admin to move logical console
+ * @file: the file to become console
  *
- *	Allow the administrator to move the redirected console device
+ * Allow the administrator to move the redirected console device.
  *
- *	Locking: uses redirect_lock to guard the redirect information
+ * Locking: uses redirect_lock to guard the redirect information
  */
-
 static int tioccons(struct file *file)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -2437,15 +2413,14 @@ static int tioccons(struct file *file)
 }
 
 /**
- *	tiocsetd	-	set line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocsetd	-	set line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Set the line discipline according to user request.
+ * Set the line discipline according to user request.
  *
- *	Locking: see tty_set_ldisc, this function is just a helper
+ * Locking: see tty_set_ldisc(), this function is just a helper
  */
-
 static int tiocsetd(struct tty_struct *tty, int __user *p)
 {
 	int disc;
@@ -2460,16 +2435,15 @@ static int tiocsetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tiocgetd	-	get line discipline
- *	@tty: tty device
- *	@p: pointer to user data
+ * tiocgetd	-	get line discipline
+ * @tty: tty device
+ * @p: pointer to user data
  *
- *	Retrieves the line discipline id directly from the ldisc.
+ * Retrieves the line discipline id directly from the ldisc.
  *
- *	Locking: waits for ldisc reference (in case the line discipline
- *		is changing or the tty is being hungup)
+ * Locking: waits for ldisc reference (in case the line discipline is changing
+ * or the @tty is being hungup)
  */
-
 static int tiocgetd(struct tty_struct *tty, int __user *p)
 {
 	struct tty_ldisc *ld;
@@ -2484,20 +2458,20 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	send_break	-	performed time break
- *	@tty: device to break on
- *	@duration: timeout in mS
+ * send_break	-	performed time break
+ * @tty: device to break on
+ * @duration: timeout in mS
+ * @file: file object
  *
- *	Perform a timed break on hardware that lacks its own driver level
- *	timed break functionality.
- *
- *	Locking:
- *		atomic_write_lock serializes
+ * Perform a timed break on hardware that lacks its own driver level timed
+ * break functionality.
  *
+ * Locking:
+ *	@tty->atomic_write_lock serializes
  */
-
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
+	long timeout;
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
@@ -2511,13 +2485,26 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		return -EINTR;
 
 	retval = tty->ops->break_ctl(tty, -1);
-	if (!retval) {
-		msleep_interruptible(duration);
-		retval = tty->ops->break_ctl(tty, 0);
-	} else if (retval == -EOPNOTSUPP) {
-		/* some drivers can tell only dynamically */
-		retval = 0;
+	if (retval) {
+		if (retval == -EOPNOTSUPP) {
+			/* some drivers can tell only dynamically */
+			retval = 0;
+		}
+		goto out_unlock;
+	}
+
+	timeout = msecs_to_jiffies(duration);
+	timeout = wait_event_interruptible_timeout(tty->break_wait,
+						   tty_hung_up_p(file),
+						   timeout);
+	/* return early on hangup only */
+	if (timeout > 0) {
+		retval = -EIO;
+		goto out_unlock;
 	}
+
+	retval = tty->ops->break_ctl(tty, 0);
+out_unlock:
 	tty_write_unlock(tty);
 
 	if (signal_pending(current))
@@ -2527,16 +2514,15 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 }
 
 /**
- *	tty_tiocmget		-	get modem status
- *	@tty: tty device
- *	@p: pointer to result
+ * tty_tiocmget		-	get modem status
+ * @tty: tty device
+ * @p: pointer to result
  *
- *	Obtain the modem status bits from the tty driver if the feature
- *	is supported. Return -ENOTTY if it is not available.
+ * Obtain the modem status bits from the tty driver if the feature is
+ * supported. Return -%ENOTTY if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
-
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
 	int retval = -ENOTTY;
@@ -2551,17 +2537,16 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 }
 
 /**
- *	tty_tiocmset		-	set modem status
- *	@tty: tty device
- *	@cmd: command - clear bits, set bits or set all
- *	@p: pointer to desired bits
+ * tty_tiocmset		-	set modem status
+ * @tty: tty device
+ * @cmd: command - clear bits, set bits or set all
+ * @p: pointer to desired bits
  *
- *	Set the modem status bits from the tty driver if the feature
- *	is supported. Return -ENOTTY if it is not available.
+ * Set the modem status bits from the tty driver if the feature
+ * is supported. Return -%ENOTTY if it is not available.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
-
 static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	     unsigned __user *p)
 {
@@ -2593,13 +2578,13 @@ static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 }
 
 /**
- *	tty_get_icount		-	get tty statistics
- *	@tty: tty device
- *	@icount: output parameter
+ * tty_get_icount	-	get tty statistics
+ * @tty: tty device
+ * @icount: output parameter
  *
- *	Gets a copy of the tty's icount statistics.
+ * Gets a copy of the @tty's icount statistics.
  *
- *	Locking: none (up to the driver)
+ * Locking: none (up to the driver)
  */
 int tty_get_icount(struct tty_struct *tty,
 		   struct serial_icounter_struct *icount)
@@ -2772,10 +2757,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 * This is used by the tcdrain() termios function.
 		 */
 		if (!arg)
-			return send_break(tty, 250);
+			return send_break(file, tty, 250);
 		return 0;
 	case TCSBRKP:	/* support for POSIX tcsendbreak() */
-		return send_break(tty, arg ? arg*100 : 250);
+		return send_break(file, tty, arg ? arg * 100 : 250);
 
 	case TIOCMGET:
 		return tty_tiocmget(tty, p);
@@ -3112,14 +3097,15 @@ static struct device *tty_get_device(struct tty_struct *tty)
 }
 
 
-/*
- *	alloc_tty_struct
+/**
+ * alloc_tty_struct - allocate a new tty
+ * @driver: driver which will handle the returned tty
+ * @idx: minor of the tty
  *
- *	This subroutine allocates and initializes a tty structure.
+ * This subroutine allocates and initializes a tty structure.
  *
- *	Locking: none - tty in question is not exposed at this point
+ * Locking: none - @tty in question is not exposed at this point
  */
-
 struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
@@ -3143,6 +3129,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
+	init_waitqueue_head(&tty->break_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl.lock);
@@ -3161,17 +3148,18 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 }
 
 /**
- *	tty_put_char	-	write one character to a tty
- *	@tty: tty
- *	@ch: character
+ * tty_put_char	- write one character to a tty
+ * @tty: tty
+ * @ch: character to write
+ *
+ * Write one byte to the @tty using the provided @tty->ops->put_char() method
+ * if present.
  *
- *	Write one byte to the tty using the provided put_char method
- *	if present. Returns the number of characters successfully output.
+ * Note: the specific put_char operation in the driver layer may go
+ * away soon. Don't call it directly, use this method
  *
- *	Note: the specific put_char operation in the driver layer may go
- *	away soon. Don't call it directly, use this method
+ * Return: the number of characters successfully output.
  */
-
 int tty_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	if (tty->ops->put_char)
@@ -3202,24 +3190,23 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 }
 
 /**
- *	tty_register_device - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
+ * tty_register_device - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *	This field is optional, if there is no known struct device
+ *	for this tty device it can be set to NULL safely.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * This call is required to be made to register an individual tty device
+ * if the tty driver's flags have the %TTY_DRIVER_DYNAMIC_DEV bit set.  If
+ * that bit is not set, this function should not be called by a tty
+ * driver.
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * Locking: ??
  *
- *	Locking: ??
+ * Return: A pointer to the struct device for this tty device (or
+ * ERR_PTR(-EFOO) on error).
  */
-
 struct device *tty_register_device(struct tty_driver *driver, unsigned index,
 				   struct device *device)
 {
@@ -3234,24 +3221,23 @@ static void tty_device_create_release(struct device *dev)
 }
 
 /**
- *	tty_register_device_attr - register a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
- *	@device: a struct device that is associated with this tty device.
- *		This field is optional, if there is no known struct device
- *		for this tty device it can be set to NULL safely.
- *	@drvdata: Driver data to be set to device.
- *	@attr_grp: Attribute group to be set on device.
+ * tty_register_device_attr - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *	This field is optional, if there is no known struct device
+ *	for this tty device it can be set to %NULL safely.
+ * @drvdata: Driver data to be set to device.
+ * @attr_grp: Attribute group to be set on device.
  *
- *	Returns a pointer to the struct device for this tty device
- *	(or ERR_PTR(-EFOO) on error).
+ * This call is required to be made to register an individual tty device if the
+ * tty driver's flags have the %TTY_DRIVER_DYNAMIC_DEV bit set. If that bit is
+ * not set, this function should not be called by a tty driver.
  *
- *	This call is required to be made to register an individual tty device
- *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
- *	that bit is not set, this function should not be called by a tty
- *	driver.
+ * Locking: ??
  *
- *	Locking: ??
+ * Return: A pointer to the struct device for this tty device (or
+ * ERR_PTR(-EFOO) on error).
  */
 struct device *tty_register_device_attr(struct tty_driver *driver,
 				   unsigned index, struct device *device,
@@ -3294,14 +3280,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 		goto err_put;
 
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
-		/*
-		 * Free any saved termios data so that the termios state is
-		 * reset when reusing a minor number.
-		 */
-		tp = driver->termios[index];
-		if (tp) {
-			driver->termios[index] = NULL;
-			kfree(tp);
+		if (driver->flags & TTY_DRIVER_RESET_SAVED_TERMIOS) {
+			/*
+			 * Free any saved termios data so that the termios
+			 * state is reset when reusing a minor number.
+			 */
+			tp = driver->termios[index];
+			if (tp) {
+				driver->termios[index] = NULL;
+				kfree(tp);
+			}
 		}
 
 		retval = tty_cdev_add(driver, devt, index, 1);
@@ -3324,16 +3312,15 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_register_device_attr);
 
 /**
- *	tty_unregister_device - unregister a tty device
- *	@driver: the tty driver that describes the tty device
- *	@index: the index in the tty driver for this tty device
+ * tty_unregister_device - unregister a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
  *
- *	If a tty device is registered with a call to tty_register_device() then
- *	this function must be called when the tty device is gone.
+ * If a tty device is registered with a call to tty_register_device() then
+ * this function must be called when the tty device is gone.
  *
- *	Locking: ??
+ * Locking: ??
  */
-
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(tty_class,
@@ -3349,10 +3336,10 @@ EXPORT_SYMBOL(tty_unregister_device);
  * __tty_alloc_driver -- allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
- * @flags: some of TTY_DRIVER_* flags, will be set in driver->flags
+ * @flags: some of %TTY_DRIVER_ flags, will be set in driver->flags
  *
  * This should not be called directly, some of the provided macros should be
- * used instead. Use IS_ERR and friends on @retval.
+ * used instead. Use IS_ERR() and friends on @retval.
  */
 struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
 		unsigned long flags)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 2f1061a9d926..7dbfabf2d902 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -312,11 +312,12 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
-static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+static void tty_port_shutdown_locked(struct tty_port *port, struct tty_struct *tty)
 {
-	mutex_lock(&port->mutex);
+	lockdep_assert_held(&port->mutex);
+
 	if (port->console)
-		goto out;
+		return;
 
 	if (tty_port_initialized(port)) {
 		tty_port_set_initialized(port, 0);
@@ -330,7 +331,12 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
-out:
+}
+
+static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
+{
+	mutex_lock(&port->mutex);
+	tty_port_shutdown_locked(port, tty);
 	mutex_unlock(&port->mutex);
 }
 
@@ -348,6 +354,7 @@ void tty_port_hangup(struct tty_port *port)
 	struct tty_struct *tty;
 	unsigned long flags;
 
+	mutex_lock(&port->mutex);
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
 	tty = port->tty;
@@ -356,7 +363,8 @@ void tty_port_hangup(struct tty_port *port)
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_port_set_active(port, 0);
-	tty_port_shutdown(port, tty);
+	tty_port_shutdown_locked(port, tty);
+	mutex_unlock(&port->mutex);
 	tty_kref_put(tty);
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->delta_msr_wait);
@@ -364,10 +372,9 @@ void tty_port_hangup(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_hangup);
 
 /**
- * tty_port_tty_hangup - helper to hang up a tty
- *
+ * tty_port_tty_hangup - helper to hang up a tty asynchronously
  * @port: tty port
- * @check_clocal: hang only ttys with CLOCAL unset?
+ * @check_clocal: hang only ttys with %CLOCAL unset?
  */
 void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
@@ -379,6 +386,25 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 }
 EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 
+/**
+ * tty_port_tty_vhangup - helper to hang up a tty synchronously
+ * @port: tty port
+ */
+void tty_port_tty_vhangup(struct tty_port *port)
+{
+	struct tty_struct *tty;
+
+	mutex_lock(&port->mutex);
+	tty = tty_port_tty_get(port);
+	mutex_unlock(&port->mutex);
+
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
+}
+EXPORT_SYMBOL_GPL(tty_port_tty_vhangup);
+
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
  *
@@ -694,6 +720,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 			int retval = port->ops->activate(port, tty);
 
 			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				mutex_unlock(&port->mutex);
 				return retval;
 			}
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 71356d9684ba..d05f4ea794d1 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -491,7 +491,7 @@ static ssize_t domain_show(struct device *dev,
 
 static int vcc_send_ctl(struct vcc_port *port, int ctl)
 {
-	struct vio_vcc pkt;
+	struct vio_vcc pkt = {};
 	int rv;
 
 	pkt.tag.type = VIO_TYPE_CTRL;
@@ -985,7 +985,8 @@ static void vcc_cleanup(struct tty_struct *tty)
 
 	port = vcc_get(tty->index, true);
 	if (port) {
-		port->tty = NULL;
+		scoped_guard(spinlock_irqsave, &port->lock)
+			port->tty = NULL;
 
 		if (port->removed) {
 			vcc_table_remove(tty->index);
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 27b44dc12385..22735ca14395 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -643,6 +643,19 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		ret = copy_from_user(con_buf, buf, this_round);
 		console_lock();
 
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer; recheck here, before
+		 * if (ret), so every break path below passes a fresh vc to the
+		 * post-loop vcs_scr_updated(). Return data written so far.
+		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
+
 		if (ret) {
 			this_round -= ret;
 			if (!this_round) {
@@ -655,18 +668,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				goto unlock_out;
 			}
 		}
-
-		/* The vc might have been freed or vcs_size might have changed
-		 * while we slept to grab the user buffer, so recheck.
-		 * Return data written up to now on failure.
-		 */
-		vc = vcs_vc(inode, &viewed);
-		if (!vc) {
-			if (written)
-				break;
-			ret = -ENXIO;
-			goto unlock_out;
-		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a10b7ebbbe91..187d42f61426 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1160,6 +1160,8 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	return 0;
 err_free:
 	visual_deinit(vc);
+	if (*vc->vc_uni_pagedir_loc)
+		con_free_unimap(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return err;
@@ -2543,7 +2545,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			csi_J(vc, 2);
 			vc->vc_video_erase_char =
 				(vc->vc_video_erase_char & 0xff00) | ' ';
-			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+			if (con_should_update(vc))
+				do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 		}
 		return;
 	case ESsetG0:
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ff10668b0f13..c8872be1edf2 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3265,6 +3265,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 	usb_del_gadget(&priv_dev->gadget);
 	devm_free_irq(cdns->dev, cdns->dev_irq, priv_dev);
 
+	/* The works can still be queued until the IRQ is freed. */
+	cancel_work_sync(&priv_dev->pending_status_wq);
+	cancel_work_sync(&priv_dev->aligned_buf_wq);
+
 	cdns3_free_all_eps(priv_dev);
 
 	while (!list_empty(&priv_dev->aligned_buf_list)) {
diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 92ae5d443350..2f321ce033be 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -99,6 +99,11 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 
 	if (pci_is_enabled(func)) {
 		wrap = pci_get_drvdata(func);
+		if (!wrap) {
+			dev_err(&pdev->dev,
+				"second function not initialized, retrying\n");
+			return -EPROBE_DEFER;
+		}
 	} else {
 		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
 		if (!wrap)
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index d5ec2a55aa14..44820a020e66 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -320,7 +320,6 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 		difference = acm->ctrlin ^ newctrl;
 		spin_lock_irqsave(&acm->read_lock, flags);
 		acm->ctrlin = newctrl;
-		acm->oldcount = acm->iocount;
 
 		if (difference & ACM_CTRL_DSR)
 			acm->iocount.dsr++;
@@ -994,11 +993,16 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 	DECLARE_WAITQUEUE(wait, current);
 	struct async_icount old, new;
 
-	do {
+	spin_lock_irq(&acm->read_lock);
+	old = acm->iocount;
+	spin_unlock_irq(&acm->read_lock);
+
+	add_wait_queue(&acm->wioctl, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&acm->read_lock);
-		old = acm->oldcount;
 		new = acm->iocount;
-		acm->oldcount = new;
 		spin_unlock_irq(&acm->read_lock);
 
 		if ((arg & TIOCM_DSR) &&
@@ -1011,22 +1015,20 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 			old.rng != new.rng)
 			break;
 
-		add_wait_queue(&acm->wioctl, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		remove_wait_queue(&acm->wioctl, &wait);
 		if (acm->disconnected) {
-			if (arg & TIOCM_CD)
-				break;
-			else
-				rv = -ENODEV;
-		} else {
-			if (signal_pending(current))
-				rv = -ERESTARTSYS;
+			rv = -ENODEV;
+			break;
 		}
-	} while (!rv);
 
-	
+		schedule();
+
+		if (signal_pending(current)) {
+			rv = -ERESTARTSYS;
+			break;
+		}
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&acm->wioctl, &wait);
 
 	return rv;
 }
@@ -1560,7 +1562,6 @@ static int acm_probe(struct usb_interface *intf,
 static void acm_disconnect(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
-	struct tty_struct *tty;
 	int i;
 
 	/* sibling interface is already cleaning up */
@@ -1587,11 +1588,7 @@ static void acm_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(acm->data, NULL);
 	mutex_unlock(&acm->mutex);
 
-	tty = tty_port_tty_get(&acm->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&acm->port);
 
 	cancel_delayed_work_sync(&acm->dwork);
 
@@ -2082,7 +2079,7 @@ static int __init acm_init(void)
 {
 	int retval;
 	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(acm_tty_driver))
 		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 705ea2feeb40..95dee47115a6 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -118,7 +118,6 @@ struct acm {
 	unsigned int ctrlin;				/* input control lines (DCD, DSR, RI, break, overruns) */
 	unsigned int ctrlout;				/* output control lines (DTR, RTS) */
 	struct async_icount iocount;			/* counters for control line changes */
-	struct async_icount oldcount;			/* for comparison of counter */
 	wait_queue_head_t wioctl;			/* for ioctl */
 	unsigned int writesize;				/* max packet size for the output bulk endpoint */
 	unsigned int readsize,ctrlsize;			/* buffer sizes for freeing */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c26303dd0645..cd95bab0214c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -56,8 +56,11 @@
 /*
  * Give SS hubs 200ms time after wake to train downstream links before
  * assuming no port activity and allowing hub to runtime suspend back.
+ * Root hubs have no upstream hub whose wake propagation needs to be
+ * accounted for, so they need less time, use 120ms for them.
  */
 #define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
+#define USB_SS_RH_PORT_U0_WAKE_TIME     120 /* ms */
 
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
@@ -1319,7 +1322,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 
 		queue_delayed_work(system_power_efficient_wq,
 				   &hub->post_resume_work,
-				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
+				   msecs_to_jiffies(hdev->parent ?
+				USB_SS_PORT_U0_WAKE_TIME :
+				USB_SS_RH_PORT_U0_WAKE_TIME));
 		return;
 	}
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 94c01050aeb7..58046946411f 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1331,7 +1331,8 @@ static void remove_intf_ep_devs(struct usb_interface *intf)
  *
  * Disables the endpoint for URB submission and nukes all pending URBs.
  * If @reset_hardware is set then also deallocates hcd/hardware state
- * for the endpoint.
+ * for the endpoint (clearing both ep_in and ep_out pointers for
+ * bidirectional non-ep0 control endpoints).
  */
 void usb_disable_endpoint(struct usb_device *dev, unsigned int epaddr,
 		bool reset_hardware)
@@ -1352,6 +1353,11 @@ void usb_disable_endpoint(struct usb_device *dev, unsigned int epaddr,
 			dev->ep_in[epnum] = NULL;
 	}
 	if (ep) {
+		if (reset_hardware && epnum != 0 &&
+		    usb_endpoint_xfer_control(&ep->desc)) {
+			dev->ep_out[epnum] = NULL;
+			dev->ep_in[epnum] = NULL;
+		}
 		ep->enabled = 0;
 		usb_hcd_flush_endpoint(dev, ep);
 		if (reset_hardware)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 109b02830d88..cfc02759f492 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5115,14 +5115,13 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 	}
 
 	cancel_work_sync(&hsotg->phy_reset_work);
-
-	del_timer(&hsotg->wkp_timer);
 }
 
 static void dwc2_hcd_release(struct dwc2_hsotg *hsotg)
 {
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
+	timer_shutdown_sync(&hsotg->wkp_timer);
 
 	dwc2_hcd_free(hsotg);
 }
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5a37ad5a7f89..78491e893d49 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -42,6 +42,7 @@
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 #define DWC3_ISOC_MAX_RETRIES	5
+#define DWC3_ERR_RECOVERY_MAX	3
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
 #define DWC3_EVENT_BUFFERS_SIZE	4096
@@ -796,6 +797,12 @@ enum dwc3_link_state {
 	DWC3_LINK_STATE_MASK		= 0x0f,
 };
 
+enum dwc3_err_state {
+	DWC3_ERR_NONE = 0,
+	DWC3_ERR_RECOVERY,
+	DWC3_ERR_UNRECOVERABLE,
+};
+
 /* TRB Length, PCM and Status */
 #define DWC3_TRB_SIZE_MASK	(0x00ffffff)
 #define DWC3_TRB_SIZE_LENGTH(n)	((n) & DWC3_TRB_SIZE_MASK)
@@ -947,6 +954,7 @@ struct dwc3_scratchpad_array {
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
+ * @err_recovery_work: workqueue used for controller error recovery
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
  * @scratchbuf: address of scratch buffer
@@ -958,6 +966,7 @@ struct dwc3_scratchpad_array {
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
  * @mutex: for mode switching
+ * @connect_mutex: for the pull-up and err_recovery_work
  * @dev: pointer to our struct device
  * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
@@ -1014,6 +1023,9 @@ struct dwc3_scratchpad_array {
  * @ep0_next_event: hold the next expected event
  * @ep0state: state of endpoint zero
  * @link_state: link state
+ * @err_state: current error recovery state.
+ * @err_recovery_count: number of consecutive error recovery attempts until
+ *		confirmed healthy and reset to 0 on reset event.
  * @speed: device speed (super, high, full, low)
  * @hwparams: copy of hwparams registers
  * @regset: debugfs pointer to regdump file
@@ -1099,6 +1111,7 @@ struct dwc3_scratchpad_array {
  */
 struct dwc3 {
 	struct work_struct	drd_work;
+	struct work_struct	err_recovery_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
 	void			*scratchbuf;
@@ -1115,6 +1128,9 @@ struct dwc3 {
 	/* mode switching lock */
 	struct mutex		mutex;
 
+	/* serializes pull-up run/stop vs error recovery */
+	struct mutex		connect_mutex;
+
 	struct device		*dev;
 	struct device		*sysdev;
 
@@ -1229,6 +1245,9 @@ struct dwc3 {
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
 	enum dwc3_link_state	link_state;
+	enum dwc3_err_state	err_state;
+
+	u32			err_recovery_count;
 
 	u16			u2sel;
 	u16			u2pel;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 0d94dd4152e7..9dd5f6f88e3b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -198,6 +198,11 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
 	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
@@ -265,6 +270,10 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep0_set_halt(ep, value);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index cccc86f80c81..f17eafe2a1b0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1084,6 +1084,10 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -1974,6 +1978,10 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_queue(dep, req);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2203,6 +2211,10 @@ static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2217,6 +2229,10 @@ static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	dep->flags |= DWC3_EP_WEDGE;
 
 	if (dep->number == 0 || dep->number == 1)
@@ -2338,6 +2354,10 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	int			ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_wakeup(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2671,10 +2691,13 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
+	/* Serialize against dwc3_err_recovery_work() */
+	mutex_lock(&dwc->connect_mutex);
 	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	else
 		ret = dwc3_gadget_soft_connect(dwc);
+	mutex_unlock(&dwc->connect_mutex);
 
 	pm_runtime_put(dwc->dev);
 
@@ -3922,6 +3945,10 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	dwc->suspended = false;
 
+	/* The controller is recovered. */
+	if (dwc->err_state == DWC3_ERR_NONE)
+		dwc->err_recovery_count = 0;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4383,6 +4410,12 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	return ret;
 }
 
+static void dwc3_schedule_err_recovery(struct dwc3 *dwc)
+{
+	dwc->err_state = DWC3_ERR_RECOVERY;
+	schedule_work(&dwc->err_recovery_work);
+}
+
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
@@ -4417,9 +4450,21 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		return IRQ_NONE;
 
 	if (count > evt->length) {
-		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
 			count, evt->length);
-		return IRQ_NONE;
+		/*
+		 * This is a fatal error - the driver and controller are out of
+		 * sync on which event has been consumed. Reinitializing the
+		 * controller is required to recover. Write the bogus count back
+		 * to GEVNTCOUNT to clear the IRQ source, consistent with the
+		 * stale event clearing in dwc3_event_buffers_setup(), then
+		 * schedule error recovery.
+		 */
+		spin_lock(&dwc->lock);
+		dwc3_schedule_err_recovery(dwc);
+		spin_unlock(&dwc->lock);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+		return IRQ_HANDLED;
 	}
 
 	evt->count = count;
@@ -4485,6 +4530,57 @@ static void dwc_gadget_release(struct device *dev)
 	kfree(gadget);
 }
 
+static void dwc3_err_recovery_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, err_recovery_work);
+	unsigned long flags;
+	int ret;
+
+	/* serializes against dwc3_gadget_pullup() */
+	mutex_lock(&dwc->connect_mutex);
+
+	ret = dwc3_gadget_soft_disconnect(dwc);
+
+	dwc3_disconnect_gadget_sleepable(dwc);
+
+	if (ret)
+		goto err_unrecoverable;
+
+	if (dwc->softconnect) {
+		u32 count;
+		/*
+		 * Wait irq to finish before soft_connect resets evt->lpos and
+		 * the event buffer registers to avoid racing with
+		 * dwc3_process_event_buf().
+		 */
+		synchronize_irq(dwc->irq_gadget);
+
+		spin_lock_irqsave(&dwc->lock, flags);
+		count = ++dwc->err_recovery_count;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+
+		if (count > DWC3_ERR_RECOVERY_MAX)
+			goto err_unrecoverable;
+
+		ret = dwc3_gadget_soft_connect(dwc);
+		if (ret)
+			goto err_unrecoverable;
+	}
+	mutex_unlock(&dwc->connect_mutex);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_NONE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return;
+
+err_unrecoverable:
+	dev_err(dwc->dev, "Unable to recover the controller\n");
+	mutex_unlock(&dwc->connect_mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_UNRECOVERABLE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4528,6 +4624,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	INIT_WORK(&dwc->err_recovery_work, dwc3_err_recovery_work);
+	mutex_init(&dwc->connect_mutex);
 	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
 	if (!dwc->gadget) {
 		ret = -ENOMEM;
@@ -4618,6 +4716,8 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	cancel_work_sync(&dwc->err_recovery_work);
+	mutex_destroy(&dwc->connect_mutex);
 	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 4861ce78bc28..267b08672d54 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1351,8 +1351,9 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		break;
 	case FUNCTIONFS_ENDPOINT_DESC:
 	{
+		const struct usb_endpoint_descriptor *desc;
+		struct usb_endpoint_descriptor desc1;
 		int desc_idx;
-		struct usb_endpoint_descriptor desc1, *desc;
 
 		switch (epfile->ffs->gadget->speed) {
 		case USB_SPEED_SUPER:
@@ -1366,7 +1367,17 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 			desc_idx = 0;
 		}
 
-		desc = epfile->ep->descs[desc_idx];
+		do {
+			desc = epfile->ep->descs[desc_idx];
+		} while (!desc && --desc_idx >= 0);
+
+		if (!desc)
+			desc = epfile->ep->ep->desc;
+		if (!desc) {
+			ret = -EINVAL;
+			break;
+		}
+
 		memcpy(&desc1, desc, desc->bLength);
 
 		spin_unlock_irq(&epfile->ffs->eps_lock);
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 42cd7112a89a..b20aabf3fb2f 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2592,6 +2592,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
 	struct fsg_buffhd *bh, *buffhds;
 	int i;
 
+	if (n < 2)
+		return -EINVAL;
+
 	buffhds = kcalloc(n, sizeof(*buffhds), GFP_KERNEL);
 	if (!buffhds)
 		return -ENOMEM;
diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 6b1efbb57072..6724228da7ab 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -797,6 +797,9 @@ f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	con->data[cmd] = value;
 
 	return 0;
@@ -804,6 +807,9 @@ static int generic_set_cmd(struct usb_audio_control *con, u8 cmd, int value)
 
 static int generic_get_cmd(struct usb_audio_control *con, u8 cmd)
 {
+	if (cmd >= ARRAY_SIZE(con->data))
+		return -EINVAL;
+
 	return con->data[cmd];
 }
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..90d56ac19a88 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -267,6 +267,9 @@ static int ast_vhub_remove(struct platform_device *pdev)
 	for (i = 0; i < vhub->max_ports; i++)
 		ast_vhub_del_dev(&vhub->ports[i].dev);
 
+	/* Final drain; the worker takes vhub->lock, so stay outside of it */
+	cancel_work_sync(&vhub->wake_work);
+
 	spin_lock_irqsave(&vhub->lock, flags);
 
 	/* Mask & ack all interrupts  */
@@ -327,6 +330,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&vhub->lock);
+	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
 	vhub->pdev = pdev;
 	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
 				      VHUB_IRQ_DEV1_BIT);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index c5f712383775..98398d330de5 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -270,7 +270,7 @@ static int ast_vhub_udc_wakeup(struct usb_gadget* gadget)
 	int rc = -EINVAL;
 
 	spin_lock_irqsave(&d->vhub->lock, flags);
-	if (!d->wakeup_en)
+	if (!d->wakeup_en || !d->registered)
 		goto err;
 
 	DDBG(d, "Device initiated wakeup\n");
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 16a12d2d492e..17250c82a593 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -527,7 +527,7 @@ void ast_vhub_device_connect(struct ast_vhub *vhub,
 		ast_vhub_send_host_wakeup(vhub);
 }
 
-static void ast_vhub_wake_work(struct work_struct *work)
+void ast_vhub_wake_work(struct work_struct *work)
 {
 	struct ast_vhub *vhub = container_of(work,
 					     struct ast_vhub,
@@ -557,6 +557,8 @@ static void ast_vhub_wake_work(struct work_struct *work)
 
 void ast_vhub_hub_wake_all(struct ast_vhub *vhub)
 {
+	lockdep_assert_held(&vhub->lock);
+
 	/*
 	 * A device is trying to wake the world, because this
 	 * can recurse into the device, we break the call chain
@@ -1041,7 +1043,6 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 int ast_vhub_init_hub(struct ast_vhub *vhub)
 {
 	vhub->speed = USB_SPEED_UNKNOWN;
-	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
 
 	return ast_vhub_init_desc(vhub);
 }
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 87a5dea12d3c..243bc3639d15 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -545,6 +545,7 @@ void ast_vhub_hub_suspend(struct ast_vhub *vhub);
 void ast_vhub_hub_resume(struct ast_vhub *vhub);
 void ast_vhub_hub_reset(struct ast_vhub *vhub);
 void ast_vhub_hub_wake_all(struct ast_vhub *vhub);
+void ast_vhub_wake_work(struct work_struct *work);
 
 /* dev.c */
 int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx);
diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index d9ad9adf7348..dfd320eb8673 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1803,6 +1803,19 @@ static void at91udc_of_init(struct at91_udc *udc, struct device_node *np)
 		udc->caps = match->data;
 }
 
+/*
+ * The work handler re-arms this timer, so shut the timer down before
+ * draining the work; otherwise it restarts the polling cycle.
+ */
+static void at91_udc_shutdown_vbus_timer(struct at91_udc *udc)
+{
+	if (!(udc->board.vbus_pin && udc->board.vbus_polled))
+		return;
+
+	timer_shutdown_sync(&udc->vbus_timer);
+	cancel_work_sync(&udc->vbus_timer_work);
+}
+
 static int at91udc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -1924,7 +1937,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	}
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval)
-		goto err_unprepare_iclk;
+		goto err_shutdown_vbus;
 	dev_set_drvdata(dev, udc);
 	device_init_wakeup(dev, 1);
 	create_debug_file(udc);
@@ -1932,6 +1945,8 @@ static int at91udc_probe(struct platform_device *pdev)
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 
+err_shutdown_vbus:
+	at91_udc_shutdown_vbus_timer(udc);
 err_unprepare_iclk:
 	clk_unprepare(udc->iclk);
 err_unprepare_fclk:
@@ -1942,7 +1957,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int at91udc_remove(struct platform_device *pdev)
+static void at91udc_remove(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
@@ -1950,8 +1965,14 @@ static int at91udc_remove(struct platform_device *pdev)
 	DBG("remove\n");
 
 	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
+
+	at91_udc_shutdown_vbus_timer(udc);
+
+	if (udc->driver) {
+		dev_err(&pdev->dev,
+			"Driver still in use but removing anyhow\n");
+		return;
+	}
 
 	spin_lock_irqsave(&udc->lock, flags);
 	pullup(udc, 0);
@@ -1961,8 +1982,6 @@ static int at91udc_remove(struct platform_device *pdev)
 	remove_debug_file(udc);
 	clk_unprepare(udc->fclk);
 	clk_unprepare(udc->iclk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2018,7 +2037,7 @@ static int at91udc_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver at91_udc_driver = {
-	.remove		= at91udc_remove,
+	.remove_new	= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 00cbb5d5fbc4..37e50ec6ad73 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -339,9 +339,11 @@ static void dummy_giveback(struct dummy *dum, struct usb_ep *_ep,
 {
 	bool fifo = req == &dum->fifo_req;
 
+	++dum->callback_usage;
 	spin_unlock(&dum->lock);
 	usb_gadget_giveback_request(_ep, &req->req);
 	spin_lock(&dum->lock);
+	--dum->callback_usage;
 	if (fifo)
 		dum->fifo_req_busy = 0;
 }
@@ -755,11 +757,13 @@ static int dummy_queue(struct usb_ep *_ep, struct usb_request *_req,
 		req->req.complete = fifo_complete;
 
 		list_add_tail(&req->queue, &ep->queue);
+		++dum->callback_usage;
 		spin_unlock(&dum->lock);
 		_req->actual = _req->length;
 		_req->status = 0;
 		usb_gadget_giveback_request(_ep, _req);
 		spin_lock(&dum->lock);
+		--dum->callback_usage;
 	}  else
 		list_add_tail(&req->queue, &ep->queue);
 	spin_unlock_irqrestore(&dum->lock, flags);
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 1371b0c249ec..7e9c2672555d 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -464,6 +464,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 
 err_remove_hcd:
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 err:
 	usb_put_hcd(hcd);
 	return error;
@@ -474,6 +475,7 @@ static int ohci_da8xx_remove(struct platform_device *pdev)
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	usb_put_hcd(hcd);
 
 	return 0;
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 1bec9b585e2d..731f1d2cb6cf 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -337,6 +337,7 @@ ohci_hcd_s3c2410_remove(struct platform_device *dev)
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	s3c2410_stop_hc(dev);
 	usb_put_hcd(hcd);
 	return 0;
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index b4cd9e6c72fd..7d798b3e7517 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -105,8 +105,8 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	device_wakeup_disable(hcd->self.controller);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index ac796ccd93ef..e890173a5e70 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -243,6 +243,7 @@ static int st_ohci_platform_remove(struct platform_device *dev)
 	int clk;
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 
 	if (pdata->power_off)
 		pdata->power_off(dev);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fee939389a30..36b6dc304e79 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5320,6 +5320,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	unsigned int		minor_rev;
 	int			retval;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5388,16 +5389,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	mutex_init(&xhci->mutex);
 	xhci->cap_regs = hcd->regs;
-	xhci->op_regs = hcd->regs +
-		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
+	hc_capbase = readl(&xhci->cap_regs->hc_capbase);
+	if (hc_capbase == U32_MAX) {
+		xhci_warn(xhci, "Host controller not accessible, removed?\n");
+		return -ENODEV;
+	}
+	xhci->op_regs = hcd->regs + HC_LENGTH(hc_capbase);
 	xhci->run_regs = hcd->regs +
 		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
 	/* Cache read-only capability registers */
 	xhci->hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
-	xhci->hcc_params = readl(&xhci->cap_regs->hc_capbase);
-	xhci->hci_version = HC_VERSION(xhci->hcc_params);
+	xhci->hci_version = HC_VERSION(hc_capbase);
 	xhci->hcc_params = readl(&xhci->cap_regs->hcc_params);
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e38142acd38..545849f8e41e 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -167,7 +167,11 @@ int usb_serial_bus_register(struct usb_serial_driver *driver)
 
 void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 {
-	free_dynids(driver);
 	driver_unregister(&driver->driver);
+	free_dynids(driver);
 }
 
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver)
+{
+	driver_remove_file(&driver->driver, &driver_attr_new_id);
+}
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index beae02e433f2..4999abacc5e0 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -223,6 +223,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
 	{ USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair USB Dongle */
+	{ USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair AX1500i Power Supply */
 	{ USB_DEVICE(0x1B93, 0x1013) }, /* Phoenix Contact UPS Device */
 	{ USB_DEVICE(0x1BA4, 0x0002) },	/* Silicon Labs 358x factory default */
 	{ USB_DEVICE(0x1BE3, 0x07A6) }, /* WAGO 750-923 USB Service Cable */
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 15b6dee3a8e5..64890f6d78e0 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -268,6 +268,7 @@ EXPORT_SYMBOL_GPL(usb_serial_generic_chars_in_buffer);
 void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	unsigned int bps;
 	unsigned long period;
 	unsigned long expire;
@@ -287,7 +288,14 @@ void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
 					__func__, jiffies_to_msecs(timeout),
 					jiffies_to_msecs(period));
 	expire = jiffies + timeout;
-	while (!port->serial->type->tx_empty(port)) {
+	for (;;) {
+		mutex_lock(&tport->mutex);
+		if (tty_io_error(tty) || port->serial->type->tx_empty(port)) {
+			mutex_unlock(&tport->mutex);
+			break;
+		}
+		mutex_unlock(&tport->mutex);
+
 		schedule_timeout_interruptible(period);
 		if (signal_pending(current))
 			break;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index dd018abda6c3..3690fb93a844 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -261,6 +261,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM060K_12a		0x012a
 #define QUECTEL_PRODUCT_EM060K_12b		0x012b
 #define QUECTEL_PRODUCT_EM060K_12c		0x012c
+#define QUECTEL_PRODUCT_RG660QB			0x013d
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -281,6 +282,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EG060W			0x6004
 #define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EG916Q			0x6007
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
@@ -1269,12 +1271,15 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG060W, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916Q, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG660QB, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG660QB, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x40) },
@@ -2169,6 +2174,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x902b, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(0x1e0e, 0x9071),				/* Simcom SIM8230 RMNET mode */
 	  .driver_info = RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),	/* Simcom SIM8230 ECM mode */
@@ -2430,6 +2437,13 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x4d22, 0xff, 0x10, 0x01) },	/* Compal EXC-T1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x4d22, 0xff, 0x10, 0x02) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x4d22, 0xff, 0x10, 0x03) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x4d22, 0xff, 0x10, 0x04) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x30) },	/* Compal EXM-G1x */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 0207ab7ce099..ee912236091d 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -54,6 +54,7 @@
 #define QT2_XMIT_FLUSH      0x05  /* no following info */
 #define QT2_CONTROL_ESCAPE  0xff  /* pass through previous 2 control bytes */
 
+#define  MIN_BAUD_RATE              50
 #define  MAX_BAUD_RATE              921600
 #define  DEFAULT_BAUD_RATE          9600
 
@@ -158,7 +159,7 @@ static inline int calc_baud_divisor(int baudrate)
 
 static inline int qt2_set_port_config(struct usb_device *dev,
 				      unsigned char port_number,
-				      u16 baudrate, u16 lcr)
+				      speed_t baudrate, u16 lcr)
 {
 	int divisor = calc_baud_divisor(baudrate);
 	u16 index = ((u16) (lcr << 8) | (u16) (port_number));
@@ -267,9 +268,9 @@ static void qt2_set_termios(struct tty_struct *tty,
 	struct usb_device *dev = port->serial->dev;
 	struct qt2_port_private *port_priv;
 	struct ktermios *termios = &tty->termios;
-	u16 baud;
 	unsigned int cflag = termios->c_cflag;
 	u16 new_lcr = 0;
+	speed_t baud;
 	int status;
 
 	port_priv = usb_get_serial_port_data(port);
@@ -301,6 +302,18 @@ static void qt2_set_termios(struct tty_struct *tty,
 	if (!baud)
 		baud = 9600;
 
+	if (baud < MIN_BAUD_RATE || baud > MAX_BAUD_RATE) {
+		if (old_termios)
+			baud = tty_termios_baud_rate(old_termios);
+		else
+			baud = clamp(baud, MIN_BAUD_RATE, MAX_BAUD_RATE);
+
+		tty_encode_baud_rate(tty, baud, baud);
+
+		if (!baud)
+			baud = 9600;
+	}
+
 	status = qt2_set_port_config(dev, port_priv->device_port, baud,
 				     new_lcr);
 	if (status < 0)
@@ -397,7 +410,7 @@ static int qt2_open(struct tty_struct *tty, struct usb_serial_port *port)
 	port_priv->device_port = (u8) device_port;
 
 	if (tty)
-		qt2_set_termios(tty, port, &tty->termios);
+		qt2_set_termios(tty, port, NULL);
 
 	return 0;
 
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 3baf7c0f5a98..44feb6937b8d 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -34,6 +34,7 @@
 
 #define  SERIAL_EVEN_PARITY         (UART_LCR_PARITY | UART_LCR_EPAR)
 
+#define  MIN_BAUD_RATE              50
 #define  MAX_BAUD_RATE              460800
 
 #define ATC_DISABLED                0x00
@@ -219,9 +220,10 @@ static void ssu100_set_termios(struct tty_struct *tty,
 {
 	struct usb_device *dev = port->serial->dev;
 	struct ktermios *termios = &tty->termios;
-	u16 baud, divisor, remainder;
+	speed_t baud, remainder;
 	unsigned int cflag = termios->c_cflag;
 	u16 urb_value = 0; /* will hold the new flags */
+	u16 divisor;
 	int result;
 
 	if (cflag & PARENB) {
@@ -251,6 +253,18 @@ static void ssu100_set_termios(struct tty_struct *tty,
 	if (!baud)
 		baud = 9600;
 
+	if (baud < MIN_BAUD_RATE || baud > MAX_BAUD_RATE) {
+		if (old_termios)
+			baud = tty_termios_baud_rate(old_termios);
+		else
+			baud = clamp(baud, MIN_BAUD_RATE, MAX_BAUD_RATE);
+
+		tty_encode_baud_rate(tty, baud, baud);
+
+		if (!baud)
+			baud = 9600;
+	}
+
 	dev_dbg(&port->dev, "%s - got baud = %d\n", __func__, baud);
 
 
@@ -326,7 +340,7 @@ static int ssu100_open(struct tty_struct *tty, struct usb_serial_port *port)
 		dev_dbg(&port->dev, "%s - set uart failed\n", __func__);
 
 	if (tty)
-		ssu100_set_termios(tty, port, &tty->termios);
+		ssu100_set_termios(tty, port, NULL);
 
 	return usb_serial_generic_open(tty, port);
 }
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 255fb9583c0a..e01d5c9373b2 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -225,17 +225,17 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	serial = port->serial;
 	if (!try_module_get(serial->type->driver.owner))
-		goto error_module_get;
+		goto err_put_serial;
 
 	retval = usb_autopm_get_interface(serial->interface);
 	if (retval)
-		goto error_get_interface;
+		goto err_put_module;
 
 	init_termios = (driver->termios[idx] == NULL);
 
 	retval = tty_standard_install(driver, tty);
 	if (retval)
-		goto error_init_termios;
+		goto err_put_autopm;
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -247,11 +247,11 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
+err_put_autopm:
 	usb_autopm_put_interface(serial->interface);
- error_get_interface:
+err_put_module:
 	module_put(serial->type->driver.owner);
- error_module_get:
+err_put_serial:
 	usb_serial_put(serial);
 	mutex_unlock(&serial->disc_mutex);
 	return retval;
@@ -401,17 +401,13 @@ static unsigned int serial_chars_in_buffer(struct tty_struct *tty)
 static void serial_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct usb_serial *serial = port->serial;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (!port->serial->type->wait_until_sent)
 		return;
 
-	mutex_lock(&serial->disc_mutex);
-	if (!serial->disconnected)
-		port->serial->type->wait_until_sent(tty, timeout);
-	mutex_unlock(&serial->disc_mutex);
+	port->serial->type->wait_until_sent(tty, timeout);
 }
 
 static void serial_throttle(struct tty_struct *tty)
@@ -439,8 +435,13 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct tty_port *tport = &port->port;
 	unsigned int close_delay, closing_wait;
+	int ret = 0;
 
 	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	close_delay = jiffies_to_msecs(tport->close_delay) / 10;
 	closing_wait = tport->closing_wait;
@@ -453,10 +454,10 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 
 	if (port->serial->type->get_serial)
 		port->serial->type->get_serial(tty, ss);
-
+out_unlock:
 	mutex_unlock(&tport->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
@@ -472,6 +473,10 @@ static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 		closing_wait = msecs_to_jiffies(closing_wait * 10);
 
 	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if (close_delay != tport->close_delay ||
@@ -499,6 +504,7 @@ static int serial_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	int retval = -ENOIOCTLCMD;
 
 	dev_dbg(&port->dev, "%s - cmd 0x%04x\n", __func__, cmd);
@@ -509,8 +515,21 @@ static int serial_ioctl(struct tty_struct *tty,
 			retval = port->serial->type->tiocmiwait(tty, arg);
 		break;
 	default:
-		if (port->serial->type->ioctl)
+		if (!port->serial->type->ioctl)
+			break;
+
+		if (cmd == TIOCSRS485)
+			down_write(&tty->termios_rwsem);
+
+		mutex_lock(&tport->mutex);
+		if (tty_io_error(tty))
+			retval = -EIO;
+		else
 			retval = port->serial->type->ioctl(tty, cmd, arg);
+		mutex_unlock(&tport->mutex);
+
+		if (cmd == TIOCSRS485)
+			up_write(&tty->termios_rwsem);
 	}
 
 	return retval;
@@ -519,25 +538,40 @@ static int serial_ioctl(struct tty_struct *tty,
 static void serial_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->set_termios)
-		port->serial->type->set_termios(tty, port, old);
-	else
+	if (!port->serial->type->set_termios) {
 		tty_termios_copy_hw(&tty->termios, old);
+		return;
+	}
+
+	mutex_lock(&tport->mutex);
+	if (!tty_io_error(tty))
+		port->serial->type->set_termios(tty, port, old);
+	mutex_unlock(&tport->mutex);
 }
 
 static int serial_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret = 0;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->break_ctl)
+	if (!port->serial->type->break_ctl)
+		return 0;
+
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
 		port->serial->type->break_ctl(tty, break_state);
+	mutex_unlock(&tport->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int serial_proc_show(struct seq_file *m, void *v)
@@ -578,24 +612,44 @@ static int serial_proc_show(struct seq_file *m, void *v)
 static int serial_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->tiocmget)
-		return port->serial->type->tiocmget(tty);
-	return -ENOTTY;
+	if (!port->serial->type->tiocmget)
+		return -ENOTTY;
+
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
+		ret = port->serial->type->tiocmget(tty);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_tiocmset(struct tty_struct *tty,
 			    unsigned int set, unsigned int clear)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->tiocmset)
-		return port->serial->type->tiocmset(tty, set, clear);
-	return -ENOTTY;
+	if (!port->serial->type->tiocmset)
+		return -ENOTTY;
+
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
+		ret = port->serial->type->tiocmset(tty, set, clear);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_get_icount(struct tty_struct *tty,
@@ -1175,7 +1229,6 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 	struct usb_serial *serial = usb_get_intfdata(interface);
 	struct device *dev = &interface->dev;
 	struct usb_serial_port *port;
-	struct tty_struct *tty;
 
 	/* sibling interface is cleaning up */
 	if (!serial)
@@ -1190,20 +1243,21 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 
 	for (i = 0; i < serial->num_ports; ++i) {
 		port = serial->port[i];
-		tty = tty_port_tty_get(&port->port);
-		if (tty) {
-			tty_vhangup(tty);
-			tty_kref_put(tty);
-		}
+		tty_port_tty_vhangup(&port->port);
 		usb_serial_port_poison_urbs(port);
 		wake_up_interruptible(&port->port.delta_msr_wait);
 		cancel_work_sync(&port->work);
-		if (device_is_registered(&port->dev))
-			device_del(&port->dev);
 	}
+
 	if (serial->type->disconnect)
 		serial->type->disconnect(serial);
 
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (device_is_registered(&port->dev))
+			device_del(&port->dev);
+	}
+
 	release_sibling(serial, interface);
 
 	/* let the last holder of this object cause it to be cleaned up */
@@ -1320,7 +1374,8 @@ static int __init usb_serial_init(void)
 	int result;
 
 	usb_serial_tty_driver = tty_alloc_driver(USB_SERIAL_TTY_MINORS,
-			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(usb_serial_tty_driver))
 		return PTR_ERR(usb_serial_tty_driver);
 
@@ -1328,7 +1383,7 @@ static int __init usb_serial_init(void)
 	result = bus_register(&usb_serial_bus_type);
 	if (result) {
 		pr_err("%s - registering bus driver failed\n", __func__);
-		goto exit_bus;
+		goto err_put_driver;
 	}
 
 	usb_serial_tty_driver->driver_name = "usbserial";
@@ -1346,25 +1401,23 @@ static int __init usb_serial_init(void)
 	result = tty_register_driver(usb_serial_tty_driver);
 	if (result) {
 		pr_err("%s - tty_register_driver failed\n", __func__);
-		goto exit_reg_driver;
+		goto err_unregister_bus;
 	}
 
 	/* register the generic driver, if we should */
 	result = usb_serial_generic_register();
 	if (result < 0) {
 		pr_err("%s - registering generic driver failed\n", __func__);
-		goto exit_generic;
+		goto err_unregister_driver;
 	}
 
 	return result;
 
-exit_generic:
+err_unregister_driver:
 	tty_unregister_driver(usb_serial_tty_driver);
-
-exit_reg_driver:
+err_unregister_bus:
 	bus_unregister(&usb_serial_bus_type);
-
-exit_bus:
+err_put_driver:
 	pr_err("%s - returning with error %d\n", __func__, result);
 	tty_driver_kref_put(usb_serial_tty_driver);
 	return result;
@@ -1472,7 +1525,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 {
 	int rc;
 	struct usb_driver *udriver;
-	struct usb_serial_driver * const *sd;
+	struct usb_serial_driver * const *sd, * const *s;
 
 	/*
 	 * udriver must be registered before any of the serial drivers,
@@ -1509,13 +1562,13 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
 	rc = usb_register(udriver);
 	if (rc)
-		goto failed_usb_register;
+		goto err_free_driver;
 
 	for (sd = serial_drivers; *sd; ++sd) {
 		(*sd)->usb_driver = udriver;
 		rc = usb_serial_register(*sd);
 		if (rc)
-			goto failed;
+			goto err_deregister_drivers;
 	}
 
 	/* Now set udriver's id_table and look for matches */
@@ -1523,11 +1576,13 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 	rc = driver_attach(&udriver->drvwrap.driver);
 	return 0;
 
- failed:
+err_deregister_drivers:
+	for (s = serial_drivers; s < sd; ++s)
+		usb_serial_bus_remove_new_id(*s);
+	usb_deregister(udriver);
 	while (sd-- > serial_drivers)
 		usb_serial_deregister(*sd);
-	usb_deregister(udriver);
-failed_usb_register:
+err_free_driver:
 	kfree(udriver);
 	return rc;
 }
@@ -1544,10 +1599,23 @@ EXPORT_SYMBOL_GPL(usb_serial_register_drivers);
 void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_drivers[])
 {
 	struct usb_driver *udriver = (*serial_drivers)->usb_driver;
+	struct usb_serial_driver * const *sd;
+
+	/*
+	 * udriver must be deregistered before the serial drivers so that
+	 * I/O is stopped before unbinding the ports.
+	 *
+	 * Remove the new_id attributes to prevent ids from being added and
+	 * triggering a probe of udriver after it has been deregistered.
+	 */
+	for (sd = serial_drivers; *sd; ++sd)
+		usb_serial_bus_remove_new_id(*sd);
+
+	usb_deregister(udriver);
 
 	for (; *serial_drivers; ++serial_drivers)
 		usb_serial_deregister(*serial_drivers);
-	usb_deregister(udriver);
+
 	kfree(udriver);
 }
 EXPORT_SYMBOL_GPL(usb_serial_deregister_drivers);
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index a026c6cb6e68..de82d8260d72 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -915,7 +915,6 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	us->proto_handler = rts51x_invoke_transport;
 
 	chip->timer_expires = 0;
-	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
 	/* enable autosuspend function of the usb device */
@@ -933,10 +932,7 @@ static void realtek_cr_destructor(void *extra)
 		return;
 
 #ifdef CONFIG_REALTEK_AUTOPM
-	if (ss_en) {
-		del_timer(&chip->rts51x_suspend_timer);
-		chip->timer_expires = 0;
-	}
+	timer_shutdown_sync(&chip->rts51x_suspend_timer);
 #endif
 	kfree(chip->status);
 }
@@ -981,6 +977,9 @@ static int init_realtek_cr(struct us_data *us)
 
 	us->extra = chip;
 	us->extra_destructor = realtek_cr_destructor;
+#ifdef CONFIG_REALTEK_AUTOPM
+	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
+#endif
 	us->max_lun = chip->max_lun = rts51x_get_max_lun(us);
 	chip->us = us;
 
diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index b9f78ef3edc3..93cbdbada807 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -77,6 +77,13 @@ static int sierra_get_swoc_info(struct usb_device *udev,
 			sizeof(struct swoc_info),	/* __u16 size 	     */
 			USB_CTRL_SET_TIMEOUT);		/* int timeout 	     */
 
+	/*
+	 * A short IN transfer leaves the tail of swocInfo uninitialized;
+	 * only a full transfer is valid.
+	 */
+	if (result != sizeof(struct swoc_info))
+		return -EIO;
+
 	swocInfo->LinuxSKU = le16_to_cpu(swocInfo->LinuxSKU);
 	swocInfo->LinuxVer = le16_to_cpu(swocInfo->LinuxVer);
 	return result;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ce997d6844f3..4396c38a22e1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -514,9 +514,12 @@ static const char * const pd_rev[] = {
 	 (tcpm_cc_is_source((port)->cc2) && \
 	  !tcpm_cc_is_source((port)->cc1)))
 
-#define tcpm_port_is_debug(port) \
+#define tcpm_port_is_debug_source(port) \
 	(tcpm_cc_is_source((port)->cc1) && tcpm_cc_is_source((port)->cc2))
 
+#define tcpm_port_is_debug(port) \
+	tcpm_port_is_debug_source(port)
+
 #define tcpm_port_is_audio(port) \
 	(tcpm_cc_is_audio((port)->cc1) && tcpm_cc_is_audio((port)->cc2))
 
@@ -3951,7 +3954,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
-		if (tcpm_port_is_debug(port))
+		if (tcpm_port_is_debug_source(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
 		else if (tcpm_port_is_audio(port))
@@ -4954,7 +4957,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 
 	switch (port->state) {
 	case TOGGLING:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		else if (tcpm_port_is_sink(port))
@@ -4962,7 +4965,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		break;
 	case SRC_UNATTACHED:
 	case ACC_UNATTACHED:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		break;
@@ -5459,22 +5462,38 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 				port->upcoming_state = FR_SWAP_SEND;
 				ret = tcpm_ams_start(port, FAST_ROLE_SWAP);
 				if (ret == -EAGAIN)
-					port->upcoming_state = INVALID_STATE;
+					tcpm_set_state(port, ERROR_RECOVERY, 0);
 			} else {
 				tcpm_log(port, "Discarding FRS_SIGNAL! Not in sink ready");
 			}
 		}
 		if (events & TCPM_SOURCING_VBUS) {
-			tcpm_log(port, "sourcing vbus");
 			/*
 			 * In fast role swap case TCPC autonomously sources vbus. Set vbus_source
-			 * true as TCPM wouldn't have called tcpm_set_vbus.
+			 * true conditionally as TCPM wouldn't have called tcpm_set_vbus.
+			 * If TCPM calls tcpm_set_vbus to source vbus, vbus_source would already
+			 * be true.
 			 *
-			 * When vbus is sourced on the command on TCPM i.e. TCPM called
-			 * tcpm_set_vbus to source vbus, vbus_source would already be true.
+			 * When TCPM_FRS_EVENT and TCPM_SOURCING_VBUS arrive simultaneously,
+			 * handling TCPM_FRS_EVENT above transitions the state to AMS_START
+			 * with upcoming_state FR_SWAP_SEND.
 			 */
-			port->vbus_source = true;
-			_tcpm_pd_vbus_on(port);
+
+			if (tcpm_port_is_source(port) ||
+			    tcpm_port_is_debug_source(port) ||
+			    (port->state == AMS_START && port->upcoming_state == FR_SWAP_SEND) ||
+			    port->state == FR_SWAP_SEND ||
+			    port->state == FR_SWAP_SEND_TIMEOUT ||
+			    port->state == FR_SWAP_SNK_SRC_TRANSITION_TO_OFF ||
+			    port->state == FR_SWAP_SNK_SRC_NEW_SINK_READY ||
+			    port->state == FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED) {
+				tcpm_log(port, "sourcing vbus");
+				port->vbus_source = true;
+				_tcpm_pd_vbus_on(port);
+			} else {
+				tcpm_log(port, "Discarding sourcing vbus! Invalid state %s",
+					 tcpm_states[port->state]);
+			}
 		}
 
 		spin_lock(&port->pd_event_lock);
diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2f32c3fceef8..6c5c00394650 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -218,7 +218,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
-	struct typec_partner_desc desc;
+	struct typec_partner_desc desc = { };
 	enum typec_pwr_opmode mode;
 	u16 pwr_status;
 	int ret;
@@ -234,7 +234,6 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 
 	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
 	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
-	desc.identity = NULL;
 
 	if (desc.usb_pd) {
 		ret = tps6598x_read_partner_identity(tps);
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 5d78f9ba3b02..1d92020b0664 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -71,11 +71,14 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	if (ret < 0) {
 		if (ucsi->version > 0x0100)
 			goto err_unlock;
-		cur = 0xff;
 	}
 
-	if (cur < UCSI_MAX_ALTMODES) {
-		ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
+	if (cur != 0xff) {
+		if (cur < UCSI_MAX_ALTMODES)
+			ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
+		else
+			ret = -EINVAL;
+
 		goto err_unlock;
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 34b6965ee30b..e37ceb2c085e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1081,10 +1081,21 @@ static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
 {
 	struct fwnode_handle *fwnode;
 	int i = 1;
+	int ret;
+	u32 port;
 
-	device_for_each_child_node(con->ucsi->dev, fwnode)
-		if (i++ == con->num)
-			return fwnode;
+	device_for_each_child_node(con->ucsi->dev, fwnode) {
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			if (i == con->num)
+				return fwnode;
+		} else {
+			if (port == con->num - 1)
+				return fwnode;
+		}
+
+		i++;
+	}
 	return NULL;
 }
 
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 0c88d5bf09ca..17567bd134d1 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "ucsi.h"
 
@@ -25,6 +26,16 @@ struct ucsi_acpi {
 	guid_t guid;
 };
 
+static const struct dmi_system_id ucsi_acpi_quirks[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		},
+	},
+	{ }
+};
+
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 {
 	union acpi_object *obj;
@@ -45,6 +56,7 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 			  void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	u16 *version = val;
 	int ret;
 
 	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
@@ -53,6 +65,12 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 
 	memcpy(val, (const void __force *)(ua->base + offset), val_len);
 
+	if (offset == UCSI_VERSION && val_len == sizeof(*version) && !*version &&
+	    dmi_check_system(ucsi_acpi_quirks)) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.2\n");
+		*version = 0x0120;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index fe7a8e403409..9f150532ef12 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1654,6 +1654,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 	return enclave_fd;
 
 put_file:
+	enclave_file->private_data = NULL;
 	fput(enclave_file);
 put_fd:
 	put_unused_fd(enclave_fd);
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 688b112e712b..9f279c0e13a6 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -252,7 +252,7 @@ static void cpu5wdt_exit(void)
 	if (cpu5wdt_device.queue) {
 		cpu5wdt_device.queue = 0;
 		wait_for_completion(&cpu5wdt_device.stop);
-		del_timer(&cpu5wdt_device.timer);
+		timer_shutdown_sync(&cpu5wdt_device.timer);
 	}
 
 	misc_deregister(&cpu5wdt_misc);
diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 834b94ff3f90..e963be4df8c4 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -94,16 +94,11 @@ static const struct of_device_id rtd119x_wdt_dt_ids[] = {
 	 { }
 };
 
-static void rtd119x_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
-	int ret;
+	unsigned long rate;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -113,22 +108,18 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->clk = devm_clk_get(dev, NULL);
+	data->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(dev, rtd119x_clk_disable_unprepare,
-				       data->clk);
-	if (ret)
-		return ret;
+	rate = clk_get_rate(data->clk);
+	if (!rate)
+		return -EINVAL;
 
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
-	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
+	data->wdt_dev.max_timeout = 0xffffffff / rate;
 	data->wdt_dev.min_timeout = 1;
 	data->wdt_dev.parent = dev;
 
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index efdc76732fae..49e8111aaf26 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -12,15 +12,13 @@
  */
 static autofs_wqt_t autofs_next_wait_queue = 1;
 
-void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
 
-	mutex_lock(&sbi->wq_mutex);
-	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
-		mutex_unlock(&sbi->wq_mutex);
+	lockdep_assert_held(&sbi->wq_mutex);
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return;
-	}
 
 	pr_debug("entering catatonic mode\n");
 
@@ -40,6 +38,21 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 	fput(sbi->pipe);	/* Close the pipe */
 	sbi->pipe = NULL;
 	sbi->pipefd = -1;
+}
+
+void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+{
+	mutex_lock(&sbi->wq_mutex);
+	autofs_catatonic_mode_locked(sbi);
+	mutex_unlock(&sbi->wq_mutex);
+}
+
+static void autofs_catatonic_mode_for_pipe(struct autofs_sb_info *sbi,
+					   struct file *pipe)
+{
+	mutex_lock(&sbi->wq_mutex);
+	if (sbi->pipe == pipe)
+		autofs_catatonic_mode_locked(sbi);
 	mutex_unlock(&sbi->wq_mutex);
 }
 
@@ -170,7 +183,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
 		autofs_wait_release(sbi, wq->wait_queue_token, ret);
 		break;
 	default:
-		autofs_catatonic_mode(sbi);
+		autofs_catatonic_mode_for_pipe(sbi, pipe);
 		break;
 	}
 	fput(pipe);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index aa03f2bbcc11..d19260ccb1c3 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -516,6 +516,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->need_commit_sem = 1;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3d5cb6e6b3bb..5a44cd54d071 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -685,8 +685,10 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	}
 	ret = paths_from_inode(inum, ipath);
 
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_put_root(local_root);
 		goto err;
+	}
 
 	/*
 	 * we deliberately ignore the bit ipath might have been too small to
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 466af8e0cbce..ba2b918a5dfe 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -422,6 +422,16 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	return dentry;
 }
 
+static int ceph_export_copy_name(char *name, const char *src, u32 len)
+{
+	if (len > NAME_MAX)
+		return -ENAMETOOLONG;
+
+	memcpy(name, src, len);
+	name[len] = '\0';
+	return 0;
+}
+
 static int __get_snap_name(struct dentry *parent, char *name,
 			   struct dentry *child)
 {
@@ -487,9 +497,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 			BUG_ON(!rde->inode.in);
 			if (ceph_snap(inode) ==
 			    le64_to_cpu(rde->inode.in->snapid)) {
-				memcpy(name, rde->name, rde->name_len);
-				name[rde->name_len] = '\0';
-				err = 0;
+				err = ceph_export_copy_name(name, rde->name,
+							    rde->name_len);
 				goto out;
 			}
 		}
@@ -551,8 +560,12 @@ static int ceph_get_name(struct dentry *parent, char *name,
 
 	if (!err) {
 		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
-		memcpy(name, rinfo->dname, rinfo->dname_len);
-		name[rinfo->dname_len] = 0;
+
+		err = ceph_export_copy_name(name, rinfo->dname,
+					    rinfo->dname_len);
+	}
+
+	if (!err) {
 		dout("get_name %p ino %llx.%llx name %s\n",
 		     child, ceph_vinop(inode), name);
 	} else {
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 3872bef8c063..3baafbc12f1a 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -96,8 +96,23 @@ cifs_idmap_key_destroy(struct key *key)
 		kfree(key->payload.data[0]);
 }
 
+static int
+cifs_idmap_key_vet_description(const char *description)
+{
+	/*
+	 * cifs.idmap descriptions are authority-bearing inputs to the
+	 * cifs.idmap upcall helper.  Only allow the kernel to create this
+	 * type of key using the private root_cred installed in
+	 * init_cifs_idmap; reject userspace request_key(2)/add_key(2).
+	 */
+	if (current_cred() != root_cred)
+		return -EPERM;
+	return 0;
+}
+
 static struct key_type cifs_idmap_key_type = {
 	.name        = "cifs.idmap",
+	.vet_description = cifs_idmap_key_vet_description,
 	.instantiate = cifs_idmap_key_instantiate,
 	.destroy     = cifs_idmap_key_destroy,
 	.describe    = user_describe,
@@ -1732,11 +1747,13 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 				cifs_put_tlink(tlink);
 				return rc;
 			}
-			if (mode_from_sid)
-				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
-			else /* cifsacl */
-				nsecdesclen += le16_to_cpu(dacl_ptr->size);
+			/*
+			 * Worst case: every ACE is rewritten with a new SID of
+			 * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(cifs_ace) each,
+			 * plus the cifs_acl header replace_sids_and_copy_aces() emits.
+			 */
+			nsecdesclen += sizeof(struct cifs_acl) +
+				le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
 		}
 	}
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 7bdeaecc6c50..e3572c30be4f 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1171,8 +1171,19 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
-		len = src_inode->i_size - off;
+	if (len == 0) {
+		loff_t src_size = i_size_read(src_inode);
+
+		if (off > src_size) {
+			rc = -EINVAL;
+			goto unlock;
+		}
+		len = src_size - off;
+		if (!len) {
+			rc = 0;
+			goto unlock;
+		}
+	}
 
 	cifs_dbg(FYI, "about to flush pages\n");
 	/* should we flush first and last page first */
@@ -1188,6 +1199,7 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	/* force revalidate of size and timestamps of target file now
 	   that target is updated on the server */
 	CIFS_I(target_inode)->time = 0;
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
 	unlock_two_nondirectories(src_inode, target_inode);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 9b08020634f1..be53b788ea4f 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1265,9 +1265,9 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d35474b83600..a91d3f6ae5be 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1574,6 +1574,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 		kfree(tcp_ses->hostname);
 		if (tcp_ses->ssocket)
 			sock_release(tcp_ses->ssocket);
+		smbd_destroy(tcp_ses);
 		kfree(tcp_ses);
 	}
 	return ERR_PTR(rc);
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 83c929dd6ed5..5b7d419a8186 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -167,7 +167,7 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 static int
 cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	       struct tcon_link *tlink, unsigned oflags, umode_t mode,
-	       __u32 *oplock, struct cifs_fid *fid)
+	       __u32 *oplock, struct cifs_fid *fid, bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -182,6 +182,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
 
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -199,6 +200,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -215,11 +217,9 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 				/*
 				 * The server may allow us to open things like
 				 * FIFOs, but the client isn't set up to deal
-				 * with that. If it's not a regular file, just
-				 * close it and proceed as if it were a normal
-				 * lookup.
+				 * with that. Keep the handle until the caller
+				 * can finish the lookup.
 				 */
-				CIFSSMBClose(xid, tcon, fid->netfid);
 				goto cifs_create_get_file_info;
 			}
 			/* success, no need to query */
@@ -314,6 +314,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
 		goto out;
 	}
+	*opened = true;
 
 	/*
 	 * If Open reported that we actually created a file then we now have to
@@ -398,7 +399,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -418,6 +419,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_pending_open open;
 	__u32 oplock;
 	struct cifsFileInfo *file_info;
+	bool is_regular;
+	bool opened;
 
 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
 		return -EIO;
@@ -475,16 +478,29 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_add_pending_open(&fid, tlink, &open);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
+			    &oplock, &fid, &opened);
 
 	if (rc) {
 		cifs_del_pending_open(&open);
 		goto out;
 	}
 
-	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+	is_regular = d_is_reg(direntry);
+	if (!is_regular || !opened) {
+		if (opened && server->ops->close)
+			server->ops->close(xid, tcon, &fid);
+		cifs_del_pending_open(&open);
+	}
+
+	if (is_regular && opened &&
+	    (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 		file->f_mode |= FMODE_CREATED;
 
+	if (!is_regular || !opened) {
+		rc = finish_no_open(file, NULL);
+		goto out;
+	}
+
 	rc = finish_open(file, direntry, generic_file_open);
 	if (rc) {
 		if (server->ops->close)
@@ -534,6 +550,7 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
@@ -555,8 +572,8 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 		server->ops->new_lease_key(&fid);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
-	if (!rc && server->ops->close)
+			    &oplock, &fid, &opened);
+	if (!rc && opened && server->ops->close)
 		server->ops->close(xid, tcon, &fid);
 
 	cifs_put_tlink(tlink);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71f585a41d45..affb1ade0c15 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -901,11 +901,18 @@ int cifs_close(struct inode *inode, struct file *file)
 					cifsFileInfo_get(cfile);
 			} else {
 				/* Deferred close for files */
-				queue_delayed_work(deferredclose_wq,
-						&cfile->deferred, cifs_sb->ctx->closetimeo);
-				cfile->deferred_close_scheduled = true;
-				spin_unlock(&cinode->deferred_lock);
-				return 0;
+				/*
+				 * Each queued execution owns one reference.
+				 * If nothing was queued, the reference of
+				 * the closing file is dropped below.
+				 */
+				if (queue_delayed_work(deferredclose_wq,
+						       &cfile->deferred,
+						       cifs_sb->ctx->closetimeo)) {
+					cfile->deferred_close_scheduled = true;
+					spin_unlock(&cinode->deferred_lock);
+					return 0;
+				}
 			}
 			spin_unlock(&cinode->deferred_lock);
 			_cifsFileInfo_put(cfile, true, false);
@@ -4886,8 +4893,11 @@ void cifs_oplock_break(struct work_struct *work)
 			TASK_UNINTERRUPTIBLE);
 
 	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink))
+	if (IS_ERR(tlink)) {
+		/* drop the reference taken when the break was queued */
+		_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 		goto out;
+	}
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index bb0b172c5a74..dae9d2d97475 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -623,6 +623,7 @@ smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *
 	/* fattr->cf_rdev = le32_to_cpu(info->DeviceId); */
 
 	if (symlink) {
+		fattr->cf_mode &= ~S_IFMT;
 		fattr->cf_mode |= S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
 	} else if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
@@ -2713,9 +2714,13 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 			goto out;
 	}
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
-		attrs->ia_valid &= ~ATTR_MODE;
+	/*
+	 * This function is only called when Unix extensions are in effect,
+	 * so the mode is always sent to and stored on the server.  Do not
+	 * skip the mode change when clearing setuid/setgid bits: dropping
+	 * ATTR_MODE here would leave those bits set on the server after a
+	 * write, which is a security issue.
+	 */
 
 	args = kmalloc(sizeof(*args), GFP_KERNEL);
 	if (args == NULL) {
@@ -2898,8 +2903,22 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID))
 		attrs->ia_valid &= ~(ATTR_UID | ATTR_GID);
 
-	/* skip mode change if it's just for clearing setuid/setgid */
-	if (attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
+	/*
+	 * Skip the mode change if it is only being done to clear the
+	 * setuid/setgid bits *and* the mode is emulated via the DOS
+	 * read-only attribute (the default, non-ACL case), which cannot
+	 * represent the setuid/setgid bits anyway.
+	 *
+	 * When the mode is instead stored on the server - i.e. with the
+	 * cifsacl or modefromsid mount options (via an ACL) - the cleared
+	 * mode must be pushed to the server.  Dropping ATTR_MODE here
+	 * would leave the setuid/setgid bit set on the server after a
+	 * write, which is a security issue (the bits are not stripped as
+	 * they are on local filesystems).
+	 */
+	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
+	    !(cifs_sb->mnt_cifs_flags &
+	      (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)))
 		attrs->ia_valid &= ~ATTR_MODE;
 
 	if (attrs->ia_valid & ATTR_MODE) {
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 4308b27ba346..ec1b9cd44b51 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -384,7 +384,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
@@ -398,20 +398,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	if (utf16_path == NULL)
 		return -ENOMEM;
 
-	pfile_info = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			     GFP_KERNEL);
-
-	if (pfile_info == NULL) {
-		kfree(utf16_path);
-		return  -ENOMEM;
-	}
-
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, pfile_info, NULL,
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, &file_info, NULL,
 		       NULL, NULL);
 	if (rc)
 		goto qmf_out_open_fail;
 
-	if (pfile_info->EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		/* it's not a symlink */
 		rc = -ENOENT; /* Is there a better rc to return? */
 		goto qmf_out;
@@ -429,7 +421,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index cb7fb2c4ea71..c7f846e50fc5 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -620,10 +620,11 @@ void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
 	 * open_file_lock to enforce the validity of it for the oplock
 	 * break handler. The matching put is done at the end of the
 	 * handler.
+	 *
+	 * Only take a reference if the work is actually queued.
 	 */
-	cifsFileInfo_get(cfile);
-
-	queue_work(cifsoplockd_wq, &cfile->oplock_break);
+	if (queue_work(cifsoplockd_wq, &cfile->oplock_break))
+		cifsFileInfo_get(cfile);
 }
 
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 41e468d06b5b..55aa58460dff 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -319,12 +319,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr)
 	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
 				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
 
-	/* validate target area */
 	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
 				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
 
 	data_area_of_tgt += total_in_tgt;
 
+	/*
+	 * DataOffset fields are server-supplied and not validated against
+	 * buffer bounds; check both data pointers before mutating the
+	 * target header.
+	 */
+	if (data_area_of_tgt < (char *)target_hdr +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_tgt + total_in_src >
+	    (char *)target_hdr + CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "%s: target data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+	if (data_area_of_src < second_buf +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_src + total_in_src >
+	    second_buf + smbCalcSize((struct smb_hdr *)second_buf)) {
+		cifs_dbg(VFS, "%s: secondary data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+
 	total_in_tgt += total_in_src;
 	/* is the result too big for the field? */
 	if (total_in_tgt > USHRT_MAX) {
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index c8171dc04bf4..40c7e4fac055 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -787,7 +787,8 @@ smb2_cancelled_close_fid(struct work_struct *work)
  */
 static int
 __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
-			    __u64 persistent_fid, __u64 volatile_fid)
+			    __u64 persistent_fid, __u64 volatile_fid,
+			    bool account_remote_open)
 {
 	struct close_cancelled_open *cancelled;
 
@@ -801,6 +802,8 @@ __smb2_handle_cancelled_cmd(struct cifs_tcon *tcon, __u16 cmd, __u64 mid,
 	cancelled->cmd = cmd;
 	cancelled->mid = mid;
 	INIT_WORK(&cancelled->work, smb2_cancelled_close_fid);
+	if (account_remote_open)
+		atomic_inc(&tcon->num_remote_opens);
 	WARN_ON(queue_work(cifsiod_wq, &cancelled->work) == false);
 
 	return 0;
@@ -837,7 +840,7 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	rc = __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
-					 persistent_fid, volatile_fid);
+					 persistent_fid, volatile_fid, false);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
 
@@ -865,7 +868,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *serve
 					 le16_to_cpu(hdr->Command),
 					 le64_to_cpu(hdr->MessageId),
 					 rsp->PersistentFileId,
-					 rsp->VolatileFileId);
+					 rsp->VolatileFileId, true);
 	if (rc)
 		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_mid);
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8b..781fe599dda7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
 #include <linux/falloc.h>
+#include <linux/fscache.h>
 #include <linux/scatterlist.h>
 #include <linux/uuid.h>
 #include <linux/sort.h>
@@ -521,13 +522,20 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 
 	bytes_left = buf_len;
 	p = buf;
-	while (bytes_left >= sizeof(*p)) {
+	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		nb_iface++;
 		next = le32_to_cpu(p->Next);
 		if (!next) {
 			bytes_left -= sizeof(*p);
 			break;
 		}
+		/* Validate that Next doesn't point beyond the buffer */
+		if (next < sizeof(*p) || next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu out of range [%zu, %zd]\n",
+				 __func__, next, sizeof(*p), bytes_left);
+			rc = -EINVAL;
+			goto out;
+		}
 		p = (struct network_interface_info_ioctl_rsp *)((u8 *)p+next);
 		bytes_left -= next;
 	}
@@ -539,7 +547,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	}
 
 	/* Azure rounds the buffer size up 8, to a 16 byte boundary */
-	if ((bytes_left > 8) || p->Next)
+	if ((bytes_left > 8) ||
+	    (bytes_left >= offsetof(struct network_interface_info_ioctl_rsp, Next)
+	     + sizeof(p->Next) && p->Next))
 		cifs_dbg(VFS, "%s: incomplete interface info\n", __func__);
 
 
@@ -556,7 +566,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	info = *iface_list;
 	bytes_left = buf_len;
 	p = buf;
-	while (bytes_left >= sizeof(*p)) {
+	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		info->speed = le64_to_cpu(p->LinkSpeed);
 		info->rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
 		info->rss_capable = le32_to_cpu(p->Capability & RSS_CAPABLE) ? 1 : 0;
@@ -1115,8 +1125,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1171,14 +1182,21 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 		if (!src->next_entry_offset)
 			break;
 
-		if (src_size < le32_to_cpu(src->next_entry_offset)) {
-			/* stop before overrun buffer */
-			rc = -ERANGE;
-			break;
+		next_off = le32_to_cpu(src->next_entry_offset);
+		if (next_off < sizeof(*src) || src_size < next_off) {
+			cifs_dbg(FYI, "EA next_entry_offset %u out of range [%zu, %zu]\n",
+				 next_off, sizeof(*src), src_size);
+			rc = -EIO;
+			goto out;
+		}
+		src_size -= next_off;
+		src = (void *)((char *)src + next_off);
+		if (src_size > 0 && src_size < sizeof(*src)) {
+			cifs_dbg(FYI, "EA next_entry_offset %u left truncated entry (%zu bytes)\n",
+				 next_off, src_size);
+			rc = -EIO;
+			goto out;
 		}
-		src_size -= le32_to_cpu(src->next_entry_offset);
-		src = (void *)((char *)src +
-			       le32_to_cpu(src->next_entry_offset));
 	}
 
 	/* didn't find the named attribute */
@@ -2143,7 +2161,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		src_off, dest_off, len);
 
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2168,6 +2186,13 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+#ifdef CONFIG_CIFS_FSCACHE
+		fscache_invalidate(CIFS_I(inode)->fscache);
+#endif
+	}
+
 duplicate_extents_out:
 	return rc;
 }
@@ -2271,8 +2296,14 @@ smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
 		 * and retry the ioctl again with larger array size sufficient
 		 * to hold all of the snapshot GMT tokens on the second try.
 		 */
-		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
+		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE) {
+			if (ret_data_len < sizeof(struct smb_snapshot_array)) {
+				rc = -EIO;
+				kfree(retbuf);
+				return rc;
+			}
 			ret_data_len = sizeof(struct smb_snapshot_array);
+		}
 
 		/*
 		 * We return struct SRV_SNAPSHOT_ARRAY, followed by
@@ -3587,8 +3618,12 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
+	 *
+	 * Start at the old EOF when extending so the folio straddling it, which
+	 * may hold data written past EOF through an mmap, is dropped too.
 	 */
-	truncate_pagecache_range(inode, offset, offset + len - 1);
+	truncate_pagecache_range(inode, min(offset, i_size_read(inode)),
+				 offset + len - 1);
 
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
@@ -4402,25 +4437,37 @@ smb3_create_lease_buf(u8 *lease_key, u8 oplock)
 static __u8
 smb2_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 {
-	struct create_lease *lc = (struct create_lease *)buf;
+	struct create_context *cc = buf;
+	struct lease_context lc;
 
 	*epoch = 0; /* not used */
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS)
+	if (le32_to_cpu(cc->DataLength) != sizeof(lc))
+		return 0;
+
+	memcpy(&lc, (u8 *)cc + le16_to_cpu(cc->DataOffset), sizeof(lc));
+	if (lc.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
-	return le32_to_cpu(lc->lcontext.LeaseState);
+	return le32_to_cpu(lc.LeaseState);
 }
 
 static __u8
 smb3_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 {
-	struct create_lease_v2 *lc = (struct create_lease_v2 *)buf;
+	struct create_context *cc = buf;
+	struct lease_context_v2 lc;
+
+	if (le32_to_cpu(cc->DataLength) != sizeof(lc)) {
+		*epoch = 0;
+		return 0;
+	}
 
-	*epoch = le16_to_cpu(lc->lcontext.Epoch);
-	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS)
+	memcpy(&lc, (u8 *)cc + le16_to_cpu(cc->DataOffset), sizeof(lc));
+	*epoch = le16_to_cpu(lc.Epoch);
+	if (lc.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
 	if (lease_key)
-		memcpy(lease_key, &lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-	return le32_to_cpu(lc->lcontext.LeaseState);
+		memcpy(lease_key, lc.LeaseKey, SMB2_LEASE_KEY_SIZE);
+	return le32_to_cpu(lc.LeaseState);
 }
 
 static unsigned int
@@ -5222,6 +5269,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	length = decrypt_raw_data(server, buf, buf_size, NULL, 0, 0, false);
 	if (length)
 		return length;
+	pdu_length = buf_size;
 
 	next_is_large = server->large_buf;
 one_more:
@@ -5234,8 +5282,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (next_cmd) {
-		if (WARN_ON_ONCE(next_cmd > pdu_length))
+		if (next_cmd < (HEADER_SIZE(server) - 1) ||
+		    next_cmd > pdu_length ||
+		    pdu_length - next_cmd < (HEADER_SIZE(server) - 1)) {
+			unsigned int max_next = pdu_length > (unsigned int)(HEADER_SIZE(server) - 1) ?
+					pdu_length - (unsigned int)(HEADER_SIZE(server) - 1) : 0;
+			cifs_server_dbg(VFS, "invalid NextCommand offset %u out of range [%zu, %u]\n",
+					next_cmd, (HEADER_SIZE(server) - 1), max_next);
 			return -1;
+		}
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
@@ -5271,6 +5326,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
+		next_buffer = NULL;
 		goto one_more;
 	} else if (ret != 0) {
 		/*
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index e93dd51a8855..2c7bcb768a64 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2019,23 +2019,32 @@ create_reconnect_durable_buf(struct cifs_fid *fid)
 static void
 parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 {
-	struct create_on_disk_id *pdisk_id = (struct create_on_disk_id *)cc;
+	u16 doff = le16_to_cpu(cc->DataOffset);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *beg;
 
-	cifs_dbg(FYI, "parse query id context 0x%llx 0x%llx\n",
-		pdisk_id->DiskFileId, pdisk_id->VolumeId);
-	buf->IndexNumber = pdisk_id->DiskFileId;
+	if (dlen < sizeof(__le64))
+		return;
+
+	beg = (u8 *)cc + doff;
+	memcpy(&buf->IndexNumber, beg, sizeof(__le64));
+	cifs_dbg(FYI, "parse query id context 0x%llx\n",
+		 le64_to_cpu(buf->IndexNumber));
 }
 
 static void
 parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 struct create_posix_rsp *posix)
 {
-	int sid_len;
 	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
-	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *end = beg + dlen;
+	int sid_len;
 	u8 *sid;
 
 	memset(posix, 0, sizeof(*posix));
+	if (dlen < 3 * sizeof(__le32))
+		return;
 
 	posix->nlink = get_unaligned_le32(beg);
 	posix->reparse_tag = get_unaligned_le32(beg + 4);
@@ -2071,6 +2080,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
 	struct create_context *cc;
 	size_t rem, off, len;
+	size_t cc_len;
 	size_t doff, dlen;
 	size_t noff, nlen;
 	char *name;
@@ -2093,29 +2103,41 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 		buf->IndexNumber = 0;
 
 	while (rem >= sizeof(*cc)) {
+		off = le32_to_cpu(cc->Next);
+		if (off) {
+			if ((off & 0x7) || off >= rem || off < sizeof(*cc))
+				return -EINVAL;
+			cc_len = off;
+		} else {
+			cc_len = rem;
+		}
+
 		doff = le16_to_cpu(cc->DataOffset);
 		dlen = le32_to_cpu(cc->DataLength);
-		if (check_add_overflow(doff, dlen, &len) || len > rem)
+		if (doff < sizeof(*cc) ||
+		    check_add_overflow(doff, dlen, &len) || len > cc_len)
 			return -EINVAL;
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen > doff)
+		if (noff < sizeof(*cc) ||
+		    check_add_overflow(noff, nlen, &len) || len > cc_len ||
+		    (dlen && len > doff))
 			return -EINVAL;
 
 		name = (char *)cc + noff;
 		switch (nlen) {
 		case 4:
-			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+			if (dlen && !strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
 				*oplock = server->ops->parse_lease_buf(cc, epoch,
 								       lease_key);
-			} else if (buf &&
+			} else if (dlen && buf &&
 				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
 				parse_query_id_ctxt(cc, buf);
 			}
 			break;
 		case 16:
-			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
+			if (dlen && posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
 			break;
 		default:
@@ -2127,13 +2149,18 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 		}
 
 		off = le32_to_cpu(cc->Next);
-		if (!off)
+		if (!off) {
+			rem = 0;
 			break;
+		}
 		if (check_sub_overflow(rem, off, &rem))
 			return -EINVAL;
 		cc = (struct create_context *)((u8 *)cc + off);
 	}
 
+	if (rem)
+		return -EINVAL;
+
 	if (rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
 		*oplock = rsp->OplockLevel;
 
@@ -2939,6 +2966,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	int resp_buftype = CIFS_NO_BUFFER;
 	int rc = 0;
 	int flags = 0;
+	struct smb2_file_all_info *file_info = buf;
 
 	cifs_dbg(FYI, "create/open\n");
 	if (!ses || !server)
@@ -2981,10 +3009,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 			tcon->need_reconnect = true;
 		}
 		goto creat_exit;
-	} else
-		trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid,
-				     ses->Suid, oparms->create_options,
-				     oparms->desired_access);
+	}
 
 	atomic_inc(&tcon->num_remote_opens);
 	oparms->fid->persistent_fid = rsp->PersistentFileId;
@@ -2994,21 +3019,27 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	oparms->fid->mid = le64_to_cpu(rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	if (buf) {
-		buf->CreationTime = rsp->CreationTime;
-		buf->LastAccessTime = rsp->LastAccessTime;
-		buf->LastWriteTime = rsp->LastWriteTime;
-		buf->ChangeTime = rsp->ChangeTime;
-		buf->AllocationSize = rsp->AllocationSize;
-		buf->EndOfFile = rsp->EndofFile;
-		buf->Attributes = rsp->FileAttributes;
-		buf->NumberOfLinks = cpu_to_le32(1);
-		buf->DeletePending = 0;
+	if (file_info) {
+		file_info->CreationTime = rsp->CreationTime;
+		file_info->LastAccessTime = rsp->LastAccessTime;
+		file_info->LastWriteTime = rsp->LastWriteTime;
+		file_info->ChangeTime = rsp->ChangeTime;
+		file_info->AllocationSize = rsp->AllocationSize;
+		file_info->EndOfFile = rsp->EndofFile;
+		file_info->Attributes = rsp->FileAttributes;
+		file_info->NumberOfLinks = cpu_to_le32(1);
+		file_info->DeletePending = 0;
 	}
 
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
-				 oparms->fid->lease_key, oplock, buf, posix);
+				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
+
+	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
+			     oparms->create_options, oparms->desired_access);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 712d256c0d4f..1a8dc4602487 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -571,7 +571,7 @@ struct create_context {
 #define SMB2_LEASE_HANDLE_CACHING	cpu_to_le32(0x02)
 #define SMB2_LEASE_WRITE_CACHING	cpu_to_le32(0x04)
 
-#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS cpu_to_le32(0x00000002)
+#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE cpu_to_le32(0x00000002)
 #define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET cpu_to_le32(0x00000004)
 
 #define SMB2_LEASE_KEY_SIZE 16
@@ -653,12 +653,12 @@ struct durable_reconnect_context_v2 {
 } __packed;
 
 /* See MS-SMB2 2.2.14.2.9 */
-struct create_on_disk_id {
+struct create_disk_id_rsp {
 	struct create_context ccontext;
 	__u8   Name[8];
 	__le64 DiskFileId;
 	__le64 VolumeId;
-	__u32  Reserved[4];
+	__u8  Reserved[16];
 } __packed;
 
 /* See MS-SMB2 2.2.14.2.12 */
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index fbf0b154169a..e729d9150c9e 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1064,6 +1064,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc = 0;
+	int num_processed = 0;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] = {false};
 	struct cifs_credits credits[MAX_COMPOUND] = {
@@ -1197,6 +1198,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			break;
 	}
 	if (rc != 0) {
+		/*
+		 * A completed CREATE earlier in the compound chain may have
+		 * opened a remote handle even though a later wait was
+		 * interrupted. Mark it cancelled so _cifs_mid_q_entry_release()
+		 * invokes the existing unmatched-open cleanup.
+		 */
+		spin_lock(&GlobalMid_Lock);
+		for (j = 0; j < i; j++)
+			midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+		spin_unlock(&GlobalMid_Lock);
+
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
@@ -1219,6 +1231,17 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 		rc = cifs_sync_mid_result(midQ[i], server);
 		if (rc != 0) {
+			/*
+			 * A previous CREATE may have completed before this
+			 * response failed. Mark it cancelled so its remote
+			 * handle is closed when the mid is released.
+			 */
+			spin_lock(&GlobalMid_Lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&GlobalMid_Lock);
+			/* Keep their response buffers for cancelled-mid cleanup. */
+			num_processed = 0;
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] = true;
 			goto out;
@@ -1228,9 +1251,26 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
+			spin_lock(&GlobalMid_Lock);
+			for (j = 0; j < i; j++)
+				midQ[j]->mid_flags |= MID_WAIT_CANCELLED;
+			spin_unlock(&GlobalMid_Lock);
+			num_processed = 0;
 			goto out;
 		}
 
+		rc = server->ops->check_receive(midQ[i], server,
+						     flags & CIFS_LOG_ERROR);
+		num_processed = i + 1;
+	}
+
+out:
+	/*
+	 * Delay moving response buffers out of their mids until response
+	 * synchronization completes. This lets cancelled-mid cleanup inspect
+	 * an earlier CREATE response if a later MID fails.
+	 */
+	for (i = 0; i < num_processed; i++) {
 		buf = (char *)midQ[i]->resp_buf;
 		resp_iov[i].iov_base = buf;
 		resp_iov[i].iov_len = midQ[i]->resp_buf_size +
@@ -1241,9 +1281,6 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		else
 			resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
-		rc = server->ops->check_receive(midQ[i], server,
-						     flags & CIFS_LOG_ERROR);
-
 		/* mark it so buf will not be freed by cifs_delete_mid */
 		if ((flags & CIFS_NO_RSP_BUF) == 0)
 			midQ[i]->resp_buf = NULL;
@@ -1253,17 +1290,18 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	/*
 	 * Compounding is never used during session establish.
 	 */
-	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
-		struct kvec iov = {
-			.iov_base = resp_iov[0].iov_base,
-			.iov_len = resp_iov[0].iov_len
-		};
-		mutex_lock(&server->srv_mutex);
-		smb311_update_preauth_hash(ses, &iov, 1);
-		mutex_unlock(&server->srv_mutex);
+	if (num_processed == num_rqst) {
+		if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
+			struct kvec iov = {
+				.iov_base = resp_iov[0].iov_base,
+				.iov_len = resp_iov[0].iov_len
+			};
+			mutex_lock(&server->srv_mutex);
+			smb311_update_preauth_hash(ses, &iov, 1);
+			mutex_unlock(&server->srv_mutex);
+		}
 	}
 
-out:
 	/*
 	 * This will dequeue all mids. After this it is important that the
 	 * demultiplex_thread will not process any of these mids any futher.
diff --git a/fs/dcache.c b/fs/dcache.c
index 54208fcef338..7d75ff9d507d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1477,6 +1477,8 @@ EXPORT_SYMBOL(path_has_submounts);
  *
  * Only one of d_invalidate() and d_set_mounted() must succeed.  For
  * this reason take rename_lock and d_lock on dentry and ancestors.
+ * Likewise for dont_mount() which marks a dentry that is being removed
+ * under d_lock.
  */
 int d_set_mounted(struct dentry *dentry)
 {
@@ -1493,7 +1495,7 @@ int d_set_mounted(struct dentry *dentry)
 		spin_unlock(&p->d_lock);
 	}
 	spin_lock(&dentry->d_lock);
-	if (!d_unlinked(dentry)) {
+	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
 		ret = -EBUSY;
 		if (!d_mountpoint(dentry)) {
 			dentry->d_flags |= DCACHE_MOUNTED;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index ffe12593a8b7..88ef7ad1494e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -449,6 +449,8 @@ int dlm_search_rsb_tree(struct rb_root *tree, char *name, int len,
 	struct dlm_rsb *r;
 	int rc;
 
+	if (len > DLM_RESNAME_MAXLEN)
+		return -EINVAL;
 	while (node) {
 		r = rb_entry(node, struct dlm_rsb, res_hashnode);
 		rc = rsb_cmp(r, name, len);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index cd21b4edeca1..9298847d7549 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -275,10 +275,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 get_cache:
 	si->cache_mem = 0;
 
-	/* build gc */
-	if (sbi->gc_thread)
-		si->cache_mem += sizeof(struct f2fs_gc_kthread);
-
 	/* build merge flush thread */
 	if (SM_I(sbi)->fcc_info)
 		si->cache_mem += sizeof(struct flush_cmd_control);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index da717e4d6aee..8ec23b8af64e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -372,6 +372,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_put_page(dentry_page, 0);
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe17f1025737..bd13a38ab57f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1561,6 +1561,26 @@ struct decompress_io_ctx {
 #define MAX_COMPRESS_LOG_SIZE		8
 #define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
 
+struct f2fs_gc_kthread {
+	struct task_struct *f2fs_gc_task;
+	wait_queue_head_t gc_wait_queue_head;
+
+	/* for gc sleep time */
+	unsigned int urgent_sleep_time;
+	unsigned int min_sleep_time;
+	unsigned int max_sleep_time;
+	unsigned int no_gc_sleep_time;
+
+	/* for changing gc mode */
+	unsigned int gc_wake;
+
+	/* for GC_MERGE mount option */
+	wait_queue_head_t fggc_wq;		/*
+						 * caller of f2fs_balance_fs()
+						 * will wait on this wait queue.
+						 */
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1677,7 +1697,7 @@ struct f2fs_sb_info {
 						 * semaphore for GC, avoid
 						 * race between GC and GC or CP
 						 */
-	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
+	struct f2fs_gc_kthread gc_thread;	/* GC thread */
 	struct atgc_management am;		/* atgc management */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69a51fcfbead..663835527298 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -30,9 +30,9 @@ static unsigned int count_bits(const unsigned long *addr,
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
-	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
-	wait_queue_head_t *fggc_wq = &sbi->gc_thread->fggc_wq;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
+	wait_queue_head_t *wq = &sbi->gc_thread.gc_wait_queue_head;
+	wait_queue_head_t *fggc_wq = &sbi->gc_thread.fggc_wq;
 	unsigned int wait_ms;
 
 	wait_ms = gc_th->min_sleep_time;
@@ -146,16 +146,10 @@ static int gc_thread_func(void *data)
 
 int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	int err = 0;
 
-	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
-	if (!gc_th) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
@@ -163,30 +157,27 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->gc_wake = 0;
 
-	sbi->gc_thread = gc_th;
-	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
-	init_waitqueue_head(&sbi->gc_thread->fggc_wq);
-	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
+	init_waitqueue_head(&gc_th->gc_wait_queue_head);
+	init_waitqueue_head(&gc_th->fggc_wq);
+	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		err = PTR_ERR(gc_th->f2fs_gc_task);
-		kfree(gc_th);
-		sbi->gc_thread = NULL;
+		gc_th->f2fs_gc_task = NULL;
 	}
-out:
 	return err;
 }
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th = &sbi->gc_thread;
 
-	if (!gc_th)
+	if (!gc_th->f2fs_gc_task)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
+	gc_th->f2fs_gc_task = NULL;
 	wake_up_all(&gc_th->fggc_wq);
-	kfree(gc_th);
-	sbi->gc_thread = NULL;
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 3fe145e8e594..f29c3ca07d70 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -30,26 +30,6 @@
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
-struct f2fs_gc_kthread {
-	struct task_struct *f2fs_gc_task;
-	wait_queue_head_t gc_wait_queue_head;
-
-	/* for gc sleep time */
-	unsigned int urgent_sleep_time;
-	unsigned int min_sleep_time;
-	unsigned int max_sleep_time;
-	unsigned int no_gc_sleep_time;
-
-	/* for changing gc mode */
-	unsigned int gc_wake;
-
-	/* for GC_MERGE mount option */
-	wait_queue_head_t fggc_wq;		/*
-						 * caller of f2fs_balance_fs()
-						 * will wait on this wait queue.
-						 */
-};
-
 struct gc_inode_list {
 	struct list_head ilist;
 	struct radix_tree_root iroot;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 339239bb7f63..fd17ed279f28 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -171,7 +171,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -230,12 +231,16 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 out_put:
 	f2fs_put_page(page, 0);
 out:
-	if (file_enc_name(inode))
+	if (file_enc_name(inode)) {
 		name = "<encrypted>";
-	else
+		name_len = sizeof("<encrypted>") - 1;
+	} else {
 		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %lx, err = %d",
-		    __func__, ino_of_node(ipage), name,
+		name_len = min_t(unsigned int, le32_to_cpu(raw_inode->i_namelen),
+				 F2FS_NAME_LEN);
+	}
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %lx, err = %d",
+		    __func__, ino_of_node(ipage), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -282,7 +287,8 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
 static int recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -332,13 +338,18 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (file_enc_name(inode))
+	if (file_enc_name(inode)) {
 		name = "<encrypted>";
-	else
-		name = F2FS_INODE(page)->i_name;
+		name_len = sizeof("<encrypted>") - 1;
+	} else {
+		name = raw->i_name;
+		name_len = min_t(unsigned int, le32_to_cpu(raw->i_namelen),
+				 F2FS_NAME_LEN);
+	}
 
-	f2fs_notice(F2FS_I_SB(inode), "recover_inode: ino = %x, name = %s, inline = %x",
-		    ino_of_node(page), name, raw->i_inline);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
+		    __func__, ino_of_node(page), name_len, name,
+		    raw->i_inline);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6c47cebbd0f1..0d10bea63937 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -522,15 +522,14 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 		f2fs_submit_merged_write(sbi, DATA);
 		f2fs_submit_all_merged_ipu_writes(sbi);
 
-		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
-					sbi->gc_thread->f2fs_gc_task) {
+		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread.f2fs_gc_task) {
 			DEFINE_WAIT(wait);
 
-			prepare_to_wait(&sbi->gc_thread->fggc_wq, &wait,
+			prepare_to_wait(&sbi->gc_thread.fggc_wq, &wait,
 						TASK_UNINTERRUPTIBLE);
-			wake_up(&sbi->gc_thread->gc_wait_queue_head);
+			wake_up(&sbi->gc_thread.gc_wait_queue_head);
 			io_schedule();
-			finish_wait(&sbi->gc_thread->fggc_wq, &wait);
+			finish_wait(&sbi->gc_thread.fggc_wq, &wait);
 		} else {
 			down_write(&sbi->gc_lock);
 			f2fs_gc(sbi, false, false, false, NULL_SEGNO);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 757f0bd843dd..a40dc08b3a1e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2349,11 +2349,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if ((*flags & SB_RDONLY) ||
 			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
 			!test_opt(sbi, GC_MERGE))) {
-		if (sbi->gc_thread) {
+		if (sbi->gc_thread.f2fs_gc_task) {
 			f2fs_stop_gc_thread(sbi);
 			need_restart_gc = true;
 		}
-	} else if (!sbi->gc_thread) {
+	} else if (!sbi->gc_thread.f2fs_gc_task) {
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
 			goto restore_opts;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index cb13d4772543..70bdc2a6a5a2 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -58,7 +58,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
+		return (unsigned char *)&sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
 	else if (struct_type == DCC_INFO)
@@ -499,10 +499,10 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			sbi->gc_mode = GC_NORMAL;
 		} else if (t == 1) {
 			sbi->gc_mode = GC_URGENT_HIGH;
-			if (sbi->gc_thread) {
-				sbi->gc_thread->gc_wake = 1;
+			if (sbi->gc_thread.f2fs_gc_task) {
+				sbi->gc_thread.gc_wake = 1;
 				wake_up_interruptible_all(
-					&sbi->gc_thread->gc_wait_queue_head);
+					&sbi->gc_thread.gc_wait_queue_head);
 				wake_up_discard_thread(sbi, true);
 			}
 		} else if (t == 2) {
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 14ab4660d024..cdc13f97d7ad 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -307,6 +307,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
+		/* nothing is ever written to it */
+		if (IS_IMMUTABLE(inode))
+			return -EPERM;
 		if (copy_from_user(&h, argp, sizeof(h)))
 			return -EFAULT;
 		hint = (enum rw_hint) h;
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 056466848979..108da9eb2e64 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -191,6 +191,9 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	ret = -EINVAL;
 	if (target.mnt->mnt_root != target.dentry)
 		goto err_path;
+	/* kernel-internal superblocks are nobody's to reconfigure */
+	if (target.dentry->d_sb->s_flags & SB_NOUSER)
+		goto err_path;
 
 	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
 	if (IS_ERR(fc)) {
diff --git a/fs/inode.c b/fs/inode.c
index 0a3a14b9ee46..bfeec2830fb0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -584,21 +584,18 @@ EXPORT_SYMBOL(__remove_inode_hash);
 void clear_inode(struct inode *inode)
 {
 	/*
-	 * We have to cycle the i_pages lock here because reclaim can be in the
-	 * process of removing the last page (in __delete_from_page_cache())
-	 * and we must not free the mapping under it.
+	 * We have to cycle the i_pages lock here because reclaim
+	 * can be in the process of removing the last page (in
+	 * __delete_from_page_cache()) and we must not free the mapping
+	 * under it.  We also remove nodes which are empty; these
+	 * can occur in two different ways.  The first is that radix
+	 * tree expansion can fail partway and the second is that THP
+	 * collapse_file() can allocate some temporary nodes and not
+	 * clean them up.
 	 */
-	xa_lock_irq(&inode->i_data.i_pages);
+	xa_destroy(&inode->i_data.i_pages);
+
 	BUG_ON(inode->i_data.nrpages);
-	/*
-	 * Almost always, mapping_empty(&inode->i_data) here; but there are
-	 * two known and long-standing ways in which nodes may get left behind
-	 * (when deep radix-tree node allocation failed partway; or when THP
-	 * collapse_file() failed). Until those two known cases are cleaned up,
-	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
-	 * nor even WARN_ON(!mapping_empty).
-	 */
-	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(inode->i_state & I_CLEAR);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index be8a541b694f..88ce1b3d0f97 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1612,7 +1612,7 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	in_len = le16_to_cpu(req->SecurityBufferLength);
 	out_blob = (char *)&rsp->hdr.ProtocolId +
 		le16_to_cpu(rsp->SecurityBufferOffset);
-	out_len = work->response_sz -
+	out_len = work->response_sz - work->next_smb2_rsp_hdr_off -
 		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
 	/* Check previous session */
@@ -5196,6 +5196,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		struct object_id_info *info;
 
 		info = (struct object_id_info *)(rsp->Buffer);
+		memset(info, 0, sizeof(*info));
 
 		if (!user_guest(sess->user))
 			memcpy(info->objid, user_passkey(sess->user), 16);
@@ -5247,6 +5248,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FreeSpaceStopFiltering = 0;
 		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->FileSystemControlFlags = 0;
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
 		break;
@@ -5268,6 +5270,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			info->FileSysIdentifier =
+				cpu_to_le64((u64)(u32)stfs.f_fsid.val[1] << 32 |
+					    (u32)stfs.f_fsid.val[0]);
 			rsp->OutputBufferLength = cpu_to_le32(56);
 		}
 		break;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9e2a67bfd070..bba701e1a608 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nlmsvc_unlock_all_by_sb);
 static int
 nlmsvc_match_ip(void *datap, struct nlm_host *host)
 {
-	return rpc_cmp_addr(nlm_srcaddr(host), datap);
+	return rpc_cmp_addr(nlm_srcaddr(datap), (struct sockaddr *)host);
 }
 
 /**
diff --git a/fs/namespace.c b/fs/namespace.c
index 2c502d554f61..542ac0d7cc10 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1079,7 +1079,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_UMOUNT);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
@@ -1518,6 +1518,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		/* A mount is unmounted once. */
+		WARN_ON_ONCE(p->mnt.mnt_flags & MNT_UMOUNT);
 		p->mnt.mnt_flags |= MNT_UMOUNT;
 		list_move(&p->mnt_list, &tmp_list);
 	}
@@ -1692,6 +1694,9 @@ static int do_umount(struct mount *mnt, int flags)
  * detach_mounts allows lazily unmounting those mounts instead of
  * leaking them.
  *
+ * The dentry is unhashed before the mounts go so that no lookup finds
+ * what they covered. The caller removes it for good afterwards.
+ *
  * The caller may hold dentry->d_inode->i_mutex.
  */
 void __detach_mounts(struct dentry *dentry)
@@ -1705,6 +1710,8 @@ void __detach_mounts(struct dentry *dentry)
 	if (!mp)
 		goto out_unlock;
 
+	/* the name goes first, what covered it goes second */
+	d_drop(dentry);
 	event++;
 	while (!hlist_empty(&mp->m_list)) {
 		mnt = hlist_entry(mp->m_list.first, struct mount, mnt_mp_list);
@@ -2168,14 +2175,30 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			struct mountpoint *dest_mp,
 			bool moving)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
+	struct user_namespace *user_ns = ns->user_ns;
 	struct mountpoint *smp;
 	struct mount *child, *p;
 	struct hlist_node *n;
 	int err;
 
+	/*
+	 * A caller in an unprivileged mount namespaces may trigger an
+	 * automount and propagate locked mounts into privileged mount
+	 * namespaces. Take ownership from the target mount namespace.
+	 * It's equivalent for everything but the automount case.
+	 *
+	 * Detached trees in anonymous mount namespaces by be handed
+	 * over via SCM_RIGHTS or inherited in other ways on purpose
+	 * the attaching task's mount namespace is authoritative, not
+	 * the creator of the detached tree.
+	 */
+	if (is_anon_ns(ns))
+		user_ns = current->nsproxy->mnt_ns->user_ns;
+	else
+		user_ns = ns->user_ns;
+
 	/* Preallocate a mountpoint in case the new mounts need
 	 * to be tucked under other mounts.
 	 */
@@ -2384,6 +2407,9 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
+	if (recurse && !old->mnt_ns)
+		return ERR_PTR(-EINVAL);
+
 	if (!recurse && has_locked_children(old, old_path->dentry))
 		return mnt;
 
@@ -2921,7 +2947,7 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
 		if (!(mnt_flags & MNT_SHRINKABLE))
 			return -EINVAL;
 		/* ... and for those we'd better have mountpoint still alive */
-		if (!parent->mnt_ns)
+		if (!is_mounted(&parent->mnt))
 			return -EINVAL;
 	}
 
@@ -3154,6 +3180,11 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	}
 	while (!list_empty(&graveyard)) {
 		mnt = list_first_entry(&graveyard, struct mount, mnt_expire);
+		/* an earlier umount_tree() may have moved a busy mount here */
+		if (propagate_mount_busy(mnt, 1)) {
+			list_move(&mnt->mnt_expire, mounts);
+			continue;
+		}
 		touch_mnt_namespace(mnt->mnt_ns);
 		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
@@ -3163,17 +3194,37 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
 
+/*
+ * Unmount @mnt if it's a shrinkable mount without children that nobody uses.
+ *
+ * mount_lock must be held for write
+ */
+static bool shrink_submount(struct mount *mnt)
+{
+	if (propagate_mount_busy(mnt, 1))
+		return false;
+	touch_mnt_namespace(mnt->mnt_ns);
+	umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+	return true;
+}
+
 /*
  * Ripoff of 'select_parent()'
  *
- * search the list of submounts for a given mountpoint, and move any
- * shrinkable submounts to the 'graveyard' list.
+ * unmount the shrinkable submounts of @parent that aren't busy, children
+ * before their parent, and say whether anything went
+ *
+ * The cursor into the children of @this_parent survives the umount of a
+ * child mount without child mounts. The mounts that get umounted together with
+ * it are located under receiving mounts of @this_parent and never under
+ * @this_parent itself. The one exception is @this_parent getting unmounted
+ * then the walk starts over.
  */
-static int select_submounts(struct mount *parent, struct list_head *graveyard)
+static bool __shrink_submounts(struct mount *parent)
 {
 	struct mount *this_parent = parent;
 	struct list_head *next;
-	int found = 0;
+	bool shrunk = false;
 
 repeat:
 	next = this_parent->mnt_mounts.next;
@@ -3192,42 +3243,45 @@ static int select_submounts(struct mount *parent, struct list_head *graveyard)
 			this_parent = mnt;
 			goto repeat;
 		}
-
-		if (!propagate_mount_busy(mnt, 1)) {
-			list_move_tail(&mnt->mnt_expire, graveyard);
-			found++;
-		}
+		if (!shrink_submount(mnt))
+			continue;
+		shrunk = true;
+		if (unlikely(this_parent->mnt.mnt_flags & MNT_UMOUNT))
+			return true;
 	}
 	/*
 	 * All done at this level ... ascend and resume the search
 	 */
 	if (this_parent != parent) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
+		struct mount *mnt = this_parent;
+
+		next = mnt->mnt_child.next;
+		this_parent = mnt->mnt_parent;
+		/* its children are gone, maybe it can go as well */
+		if (shrink_submount(mnt)) {
+			shrunk = true;
+			if (unlikely(this_parent->mnt.mnt_flags & MNT_UMOUNT))
+				return true;
+		}
 		goto resume;
 	}
-	return found;
+	return shrunk;
 }
 
 /*
- * process a list of expirable mountpoints with the intent of discarding any
- * submounts of a specific parent mountpoint
+ * unmount the shrinkable submounts of @mnt that aren't busy
+ *
+ * The busy check and the umount of a mount are adjacent. An umount can
+ * still empty or move a mount in a part of the tree that was walked
+ * already, so walk again until nothing goes.
  *
  * mount_lock must be held for write
  */
 static void shrink_submounts(struct mount *mnt)
 {
-	LIST_HEAD(graveyard);
-	struct mount *m;
-
-	/* extract submounts of 'mountpoint' from the expiration list */
-	while (select_submounts(mnt, &graveyard)) {
-		while (!list_empty(&graveyard)) {
-			m = list_first_entry(&graveyard, struct mount,
-						mnt_expire);
-			touch_mnt_namespace(m->mnt_ns);
-			umount_tree(m, UMOUNT_PROPAGATE|UMOUNT_SYNC);
-		}
+	for (;;) {
+		if (!__shrink_submounts(mnt))
+			break;
 	}
 }
 
@@ -3899,14 +3953,15 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	new_mnt = real_mount(new.mnt);
 	root_mnt = real_mount(root.mnt);
 	old_mnt = real_mount(old.mnt);
+	/* only a mounted mount has a parent that namespace_sem pins */
+	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
+		goto out4;
 	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
 		IS_MNT_SHARED(ex_parent) ||
 		IS_MNT_SHARED(root_parent))
 		goto out4;
-	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
-		goto out4;
 	if (new_mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out4;
 	error = -ENOENT;
@@ -4035,6 +4090,7 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 {
 	struct mount *m = mnt, *last = NULL;
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	if (!is_mounted(&m->mnt)) {
 		*err = -EINVAL;
 		goto out;
@@ -4144,6 +4200,13 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 		 * propagation.
 		 */
 		namespace_lock();
+		/* invent_group_ids() walks the tree, only walk a mounted one */
+		if (!is_mounted(&mnt->mnt) ||
+		    !(mnt_has_parent(mnt) ? check_mnt(mnt) :
+		      is_anon_ns(mnt->mnt_ns))) {
+			namespace_unlock();
+			return -EINVAL;
+		}
 		if (kattr->propagation == MS_SHARED) {
 			err = invent_group_ids(mnt, kattr->recurse);
 			if (err) {
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index be0c8f1ce4e3..b95ad4980053 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -67,6 +67,7 @@ struct nfsd_net {
 	bool grace_end_forced;
 	bool client_tracking_active;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index f8b91aacd817..cd6de7aca989 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -115,14 +115,19 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
-			      argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
-			      argp->acl_default);
-	if (error)
-		goto out_drop_lock;
+	error = 0;
+	if (argp->mask & NFS_ACL) {
+		error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+				      argp->acl_access);
+		if (error)
+			goto out_drop_lock;
+	}
+	if (argp->mask & NFS_DFACL) {
+		error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+				      argp->acl_default);
+		if (error)
+			goto out_drop_lock;
+	}
 
 	inode_unlock(inode);
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8db5b820ac55..4aa9c5e09beb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -762,7 +762,23 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
+	/* Sanitize cr_type to avoid returning ATTRNOTSUPP. */
+	switch (create->cr_type) {
+	case NF4LNK:
+	case NF4BLK:
+	case NF4CHR:
+	case NF4SOCK:
+	case NF4FIFO:
+	case NF4DIR:
+		break;
+	default:
+		status = nfserr_badtype;
+		goto out_aftermask;
+	}
+
 	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
+	if (status != nfs_ok)
+		goto out_aftermask;
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -829,6 +845,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
@@ -1778,12 +1795,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out;
 		}
 		status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
-		if (status)
-			return nfserr_offload_denied;
+		if (status) {
+			status = nfserr_offload_denied;
+			goto out;
+		}
 	} else {
 		status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 673c10c36ad6..0b7c70b27ab4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6030,7 +6030,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8278,6 +8278,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 91e9921db725..bc8abf74a4cd 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -201,7 +201,7 @@ TRACE_EVENT(nfsd_fh_verify,
 	TP_ARGS(rqstp, fhp, type, access),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
@@ -240,7 +240,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 	TP_CONDITION(error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(server, rqstp->rq_xprt->xpt_locallen)
 		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
 		__field(u32, xid)
 		__field(u32, fh_hash)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7b0bc4507ad0..225916fc0c8d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -129,8 +129,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 	int err = 0;
 
 	err = follow_down(&path);
-	if (err < 0)
+	if (err < 0) {
+		path_put(&path);
 		goto out;
+	}
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b419a5ccf192..136230a0b017 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -686,6 +686,11 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 		goto out_err;
 	}
 
+	if (conn->flags & FSNOTIFY_CONN_FLAG_DESTROYING) {
+		err = -ENOENT;
+		goto out_err;
+	}
+
 	/* is mark the first mark? */
 	if (hlist_empty(&conn->list)) {
 		hlist_add_head_rcu(&mark->obj_list, &conn->list);
@@ -868,6 +873,12 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
 		return;
+	/*
+	 * New marks could be inserted before our cursor and survive the final
+	 * detachment of the connector from the object. Prevent additions to
+	 * this connector before dropping its lock.
+	 */
+	conn->flags |= FSNOTIFY_CONN_FLAG_DESTROYING;
 	/*
 	 * We have to be careful since we can race with e.g.
 	 * fsnotify_clear_marks_by_group() and once we drop the conn->lock, the
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index e06bcb433ede..717362c3ee31 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -580,7 +580,7 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 		mlog(ML_ERROR,
 		     "Checksum failed for dir index root block %llu\n",
 		     (unsigned long long)bh->b_blocknr);
-		return ret;
+		goto bail;
 	}
 
 	if (!OCFS2_IS_VALID_DX_ROOT(dx_root)) {
@@ -588,8 +588,54 @@ static int ocfs2_validate_dx_root(struct super_block *sb,
 				  "Dir Index Root # %llu has bad signature %.*s\n",
 				  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
 				  7, dx_root->dr_signature);
+		goto bail;
 	}
 
+	if (!(dx_root->dr_flags & OCFS2_DX_FLAG_INLINE)) {
+		struct ocfs2_extent_list *el = &dx_root->dr_list;
+
+		if (le16_to_cpu(el->l_count) != ocfs2_extent_recs_per_dx_root(sb)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid l_count %u (expected %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(el->l_count),
+					  ocfs2_extent_recs_per_dx_root(sb));
+			goto bail;
+		}
+
+		if (le16_to_cpu(el->l_next_free_rec) > le16_to_cpu(el->l_count)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid l_next_free_rec %u (l_count %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(el->l_next_free_rec),
+					  le16_to_cpu(el->l_count));
+			goto bail;
+		}
+	} else {
+		struct ocfs2_dx_entry_list *dl_list = &dx_root->dr_entries;
+
+		if (le16_to_cpu(dl_list->de_count) !=
+		    ocfs2_dx_entries_per_root(sb)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_count %u (expected %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_count),
+					  ocfs2_dx_entries_per_root(sb));
+			goto bail;
+		}
+
+		if (le16_to_cpu(dl_list->de_num_used) >
+		    le16_to_cpu(dl_list->de_count)) {
+			ret = ocfs2_error(sb,
+					  "Dir Index Root # %llu has invalid de_num_used %u (de_count %u)\n",
+					  (unsigned long long)le64_to_cpu(dx_root->dr_blkno),
+					  le16_to_cpu(dl_list->de_num_used),
+					  le16_to_cpu(dl_list->de_count));
+			goto bail;
+		}
+	}
+
+bail:
 	return ret;
 }
 
@@ -626,10 +672,25 @@ static int ocfs2_validate_dx_leaf(struct super_block *sb,
 		return ret;
 	}
 
-	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf)) {
-		ret = ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
-				  7, dx_leaf->dl_signature);
-	}
+	if (!OCFS2_IS_VALID_DX_LEAF(dx_leaf))
+		return ocfs2_error(sb, "Dir Index Leaf has bad signature %.*s\n",
+				   7, dx_leaf->dl_signature);
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_count) !=
+	    ocfs2_dx_entries_per_leaf(sb))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_count %u (expected %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_count),
+				   ocfs2_dx_entries_per_leaf(sb));
+
+	if (le16_to_cpu(dx_leaf->dl_list.de_num_used) >
+	    le16_to_cpu(dx_leaf->dl_list.de_count))
+		return ocfs2_error(sb,
+				   "Dir Index Leaf # %llu has invalid de_num_used %u (de_count %u)\n",
+				   (unsigned long long)le64_to_cpu(dx_leaf->dl_blkno),
+				   le16_to_cpu(dx_leaf->dl_list.de_num_used),
+				   le16_to_cpu(dx_leaf->dl_list.de_count));
 
 	return ret;
 }
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index fd2022712167..2ec4586f0bbd 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -435,6 +435,8 @@ enum {
 	DLM_DEREF_LOCKRES_DONE		= 522,
 };
 
+extern spinlock_t dlm_reco_state_lock;
+
 struct dlm_reco_node_data
 {
 	int state;
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 5badebfe87a1..17c01229328b 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -792,8 +792,11 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
 				 buf + out, len - out);
 	out += scnprintf(buf + out, len - out, "\n");
 
+	spin_unlock(&dlm->spinlock);
+
 	/* Recovery Node State: */
 	out += scnprintf(buf + out, len - out, "Recovery Node State:\n");
+	spin_lock(&dlm_reco_state_lock);
 	list_for_each_entry(node, &dlm->reco.node_data, list) {
 		switch (node->state) {
 		case DLM_RECO_NODE_DATA_INIT:
@@ -825,7 +828,7 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
 				node->node_num, state);
 	}
 
-	spin_unlock(&dlm->spinlock);
+	spin_unlock(&dlm_reco_state_lock);
 
 	return out;
 }
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 44b6234be93d..20efba123a58 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -80,7 +80,7 @@ static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
 
 static u64 dlm_get_next_mig_cookie(void);
 
-static DEFINE_SPINLOCK(dlm_reco_state_lock);
+DEFINE_SPINLOCK(dlm_reco_state_lock);
 static DEFINE_SPINLOCK(dlm_mig_cookie_lock);
 static u64 dlm_mig_cookie = 1;
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 0a8095070b70..117ae6af14e4 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -749,9 +749,11 @@ pipe_fasync(int fd, struct file *filp, int on)
 	if (filp->f_mode & FMODE_READ)
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
 	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
+		int read_ret = retval;
+
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_writers);
-		if (retval < 0 && (filp->f_mode & FMODE_READ))
-			/* this can happen only if on == T */
+		/* Undo only a reader entry added by this call. */
+		if (retval < 0 && read_ret > 0)
 			fasync_helper(-1, filp, 0, &pipe->fasync_readers);
 	}
 	__pipe_unlock(pipe);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed9..d946ccfd9018 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
@@ -227,9 +228,15 @@ struct unicode_map *utf8_load(const char *version)
 }
 EXPORT_SYMBOL(utf8_load);
 
+/*
+ * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare() of a
+ * filesystem that is being torn down and read the map through its
+ * superblock, so the map has to outlive the grace period.
+ */
 void utf8_unload(struct unicode_map *um)
 {
-	kfree(um);
+	if (um)
+		kfree_rcu(um, rcu);
 }
 EXPORT_SYMBOL(utf8_unload);
 
diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
index 24d1b54de807..4e3327ce2756 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on !PAGE_SIZE_256KB && !PPC_256K_PAGES
 	select CRYPTO
 	# SHA-256 is implied as it's intended to be the default hash algorithm.
 	# To avoid bloat, other wanted algorithms must be selected explicitly.
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 95157f5a5a6c..c4d1c7d436ef 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -26,6 +26,7 @@
 #include "xfs_ag.h"
 #include "xfs_ag_resv.h"
 #include "xfs_bmap.h"
+#include "xfs_health.h"
 
 extern kmem_zone_t	*xfs_bmap_free_item_zone;
 
@@ -3078,18 +3079,42 @@ xfs_alloc_read_agf(
 		if (allocbt_blks > 0)
 			atomic64_add(allocbt_blks, &mp->m_allocbt_blks);
 	}
+
 #ifdef DEBUG
-	else if (!xfs_is_shutdown(mp)) {
-		ASSERT(pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks));
-		ASSERT(pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks));
-		ASSERT(pag->pagf_flcount == be32_to_cpu(agf->agf_flcount));
-		ASSERT(pag->pagf_longest == be32_to_cpu(agf->agf_longest));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_BNOi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_CNTi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]));
+	/*
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
+	 */
+	if (!xfs_is_shutdown(mp)) {
+		bool	ok = true;
+
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks);
+		ok &= pag->pagf_flcount == be32_to_cpu(agf->agf_flcount);
+		ok &= pag->pagf_longest == be32_to_cpu(agf->agf_longest);
+		ok &= pag->pagf_levels[XFS_BTNUM_BNOi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]);
+		ok &= pag->pagf_levels[XFS_BTNUM_CNTi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]);
+
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGF);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
 	}
-#endif
+#endif /* DEBUG */
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 31dc8e5d8725..9b14a6e4e48c 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -27,6 +27,7 @@
 #include "xfs_log.h"
 #include "xfs_rmap.h"
 #include "xfs_ag.h"
+#include "xfs_health.h"
 
 /*
  * Lookup a record by ino in the btree given by cur.
@@ -2619,12 +2620,35 @@ xfs_ialloc_read_agi(
 		pag->pagi_init = 1;
 	}
 
+#ifdef DEBUG
 	/*
-	 * It's possible for these to be out of sync if
-	 * we are in the middle of a forced shutdown.
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
 	 */
-	ASSERT(pag->pagi_freecount == be32_to_cpu(agi->agi_freecount) ||
-		xfs_is_shutdown(mp));
+	if (!xfs_is_shutdown(mp)) {
+		bool	ok = true;
+
+		ok &= pag->pagi_freecount == be32_to_cpu(agi->agi_freecount);
+		ok &= pag->pagi_count == be32_to_cpu(agi->agi_count);
+
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGI);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
+	}
+#endif /* DEBUG */
+
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e95a6b2ecded..ad3b7f6e70ee 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1081,26 +1081,23 @@ xfs_sync_sb_buf(
 	struct xfs_mount	*mp)
 {
 	struct xfs_trans	*tp;
-	struct xfs_buf		*bp;
 	int			error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
-	bp = xfs_trans_getsb(tp);
 	xfs_log_sb(tp);
-	xfs_trans_bhold(tp, bp);
 	xfs_trans_set_sync(tp);
 	error = xfs_trans_commit(tp);
 	if (error)
-		goto out;
-	/*
-	 * write out the sb buffer to get the changes to disk
-	 */
-	error = xfs_bwrite(bp);
-out:
-	xfs_buf_relse(bp);
+		return error;
+
+	/* Re-acquire and write the sb to disk. */
+	xfs_buf_lock(mp->m_sb_bp);
+	error = xfs_bwrite(mp->m_sb_bp);
+	xfs_buf_unlock(mp->m_sb_bp);
+
 	return error;
 }
 
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 51ffdec5e4fa..631dbf945310 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -465,7 +465,7 @@ xfs_bui_item_recover(
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*bmap;
 	struct xfs_bud_log_item		*budp;
 	xfs_filblks_t			count;
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 9f8225ed234e..8147c8737f02 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -21,6 +21,7 @@
 #include "xfs_dquot.h"
 #include "xfs_trace.h"
 #include "xfs_log.h"
+#include "xfs_log_priv.h"
 
 
 kmem_zone_t	*xfs_buf_item_zone;
@@ -30,6 +31,63 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
+				0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_zone, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+
+	if (atomic_read(&bip->bli_refcount))
+		return;
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -428,7 +486,7 @@ xfs_buf_item_format(
 	 * occurs during recovery.
 	 */
 	if (bip->bli_flags & XFS_BLI_INODE_BUF) {
-		if (xfs_has_v3inodes(lip->li_mountp) ||
+		if (xfs_has_v3inodes(lip->li_log->l_mp) ||
 		    !((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) &&
 		      xfs_log_item_in_current_chkpt(lip)))
 			bip->__bli_format.blf_flags |= XFS_BLF_INODE_BUF;
@@ -451,10 +509,18 @@ xfs_buf_item_format(
  * This is called to pin the buffer associated with the buf log item in memory
  * so it cannot be written out.
  *
- * We also always take a reference to the buffer log item here so that the bli
- * is held while the item is pinned in memory. This means that we can
- * unconditionally drop the reference count a transaction holds when the
- * transaction is completed.
+ * We take a reference to the buffer log item here so that the BLI life cycle
+ * extends at least until the buffer is unpinned via xfs_buf_item_unpin() and
+ * inserted into the AIL.
+ *
+ * We also need to take a reference to the buffer itself as the BLI unpin
+ * processing requires accessing the buffer after the BLI has dropped the final
+ * BLI reference. See xfs_buf_item_unpin() for an explanation.
+ * If unpins race to drop the final BLI reference and only the
+ * BLI owns a reference to the buffer, then the loser of the race can have the
+ * buffer fgreed from under it (e.g. on shutdown). Taking a buffer reference per
+ * pin count ensures the life cycle of the buffer extends for as
+ * long as we hold the buffer pin reference in xfs_buf_item_unpin().
  */
 STATIC void
 xfs_buf_item_pin(
@@ -469,13 +535,66 @@ xfs_buf_item_pin(
 
 	trace_xfs_buf_item_pin(bip);
 
+	xfs_buf_hold(bip->bli_buf);
 	atomic_inc(&bip->bli_refcount);
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
 /*
- * This is called to unpin the buffer associated with the buf log item which
- * was previously pinned with a call to xfs_buf_item_pin().
+ * For a stale BLI, process all the necessary completions that must be
+ * performed when the final BLI reference goes away. The buffer will be
+ * referenced and locked here - we return to the caller with the buffer still
+ * referenced and locked for them to finalise processing of the buffer.
+ */
+static void
+xfs_buf_item_finish_stale(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_log_item	*lip = &bip->bli_item;
+
+	ASSERT(bip->bli_flags & XFS_BLI_STALE);
+	ASSERT(xfs_buf_islocked(bp));
+	ASSERT(bp->b_flags & XBF_STALE);
+	ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
+	ASSERT(list_empty(&lip->li_trans));
+	ASSERT(!bp->b_transp);
+
+	if (bip->bli_flags & XFS_BLI_STALE_INODE) {
+		xfs_buf_item_done(bp);
+		xfs_buf_inode_iodone(bp);
+		ASSERT(list_empty(&bp->b_li_list));
+		return;
+	}
+
+	/*
+	 * We may or may not be on the AIL here, xfs_trans_ail_delete() will do
+	 * the right thing regardless of the situation in which we are called.
+	 */
+	xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
+	xfs_buf_item_relse(bip);
+	ASSERT(bp->b_log_item == NULL);
+}
+
+/*
+ * This is called to unpin the buffer associated with the buf log item which was
+ * previously pinned with a call to xfs_buf_item_pin().  We enter this function
+ * with a buffer pin count, a buffer reference and a BLI reference.
+ *
+ * We must drop the BLI reference before we unpin the buffer because the AIL
+ * doesn't acquire a BLI reference whenever it accesses it. Therefore if the
+ * refcount drops to zero, the bli could still be AIL resident and the buffer
+ * submitted for I/O at any point before we return. This can result in IO
+ * completion freeing the buffer while we are still trying to access it here.
+ * This race condition can also occur in shutdown situations where we abort and
+ * unpin buffers from contexts other that journal IO completion.
+ *
+ * Hence we have to hold a buffer reference per pin count to ensure that the
+ * buffer cannot be freed until we have finished processing the unpin operation.
+ * The reference is taken in xfs_buf_item_pin(), and we must hold it until we
+ * are done processing the buffer state. In the case of an abort (remove =
+ * true) then we re-use the current pin reference as the IO reference we hand
+ * off to IO failure handling.
  */
 STATIC void
 xfs_buf_item_unpin(
@@ -492,61 +611,56 @@ xfs_buf_item_unpin(
 
 	trace_xfs_buf_item_unpin(bip);
 
-	/*
-	 * Drop the bli ref associated with the pin and grab the hold required
-	 * for the I/O simulation failure in the abort case. We have to do this
-	 * before the pin count drops because the AIL doesn't acquire a bli
-	 * reference. Therefore if the refcount drops to zero, the bli could
-	 * still be AIL resident and the buffer submitted for I/O (and freed on
-	 * completion) at any point before we return. This can be removed once
-	 * the AIL properly holds a reference on the bli.
-	 */
 	freed = atomic_dec_and_test(&bip->bli_refcount);
-	if (freed && !stale && remove)
-		xfs_buf_hold(bp);
 	if (atomic_dec_and_test(&bp->b_pin_count))
 		wake_up_all(&bp->b_waiters);
 
-	 /* nothing to do but drop the pin count if the bli is active */
-	if (!freed)
+	/*
+	 * Nothing to do but drop the buffer pin reference if the BLI is
+	 * still active.
+	 */
+	if (!freed) {
+		xfs_buf_rele(bp);
 		return;
+	}
 
 	if (stale) {
-		ASSERT(bip->bli_flags & XFS_BLI_STALE);
-		ASSERT(xfs_buf_islocked(bp));
-		ASSERT(bp->b_flags & XBF_STALE);
-		ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
-		ASSERT(list_empty(&lip->li_trans));
-		ASSERT(!bp->b_transp);
-
 		trace_xfs_buf_item_unpin_stale(bip);
 
 		/*
-		 * If we get called here because of an IO error, we may or may
-		 * not have the item on the AIL. xfs_trans_ail_delete() will
-		 * take care of that situation. xfs_trans_ail_delete() drops
-		 * the AIL lock.
+		 * The buffer has been locked and referenced since it was marked
+		 * stale so we own both lock and reference exclusively here. We
+		 * do not need the pin reference any more, so drop it now so
+		 * that we only have one reference to drop once item completion
+		 * processing is complete.
 		 */
-		if (bip->bli_flags & XFS_BLI_STALE_INODE) {
-			xfs_buf_item_done(bp);
-			xfs_buf_inode_iodone(bp);
-			ASSERT(list_empty(&bp->b_li_list));
-		} else {
-			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
-			ASSERT(bp->b_log_item == NULL);
-		}
+		xfs_buf_rele(bp);
+		xfs_buf_item_finish_stale(bip);
 		xfs_buf_relse(bp);
-	} else if (remove) {
+		return;
+	}
+
+	if (remove) {
 		/*
-		 * The buffer must be locked and held by the caller to simulate
-		 * an async I/O failure. We acquired the hold for this case
-		 * before the buffer was unpinned.
+		 * We need to simulate an async IO failures here to ensure that
+		 * the correct error completion is run on this buffer. This
+		 * requires a reference to the buffer and for the buffer to be
+		 * locked. We can safely pass ownership of the pin reference to
+		 * the IO to ensure that nothing can free the buffer while we
+		 * wait for the lock and then run the IO failure completion.
 		 */
 		xfs_buf_lock(bp);
 		bp->b_flags |= XBF_ASYNC;
 		xfs_buf_ioend_fail(bp);
+		return;
 	}
+
+	/*
+	 * BLI has no more active references - it will be moved to the AIL to
+	 * manage the remaining BLI/buffer life cycle. There is nothing left for
+	 * us to do here so drop the pin reference to the buffer.
+	 */
+	xfs_buf_rele(bp);
 }
 
 STATIC uint
@@ -594,43 +708,42 @@ xfs_buf_item_push(
  * Drop the buffer log item refcount and take appropriate action. This helper
  * determines whether the bli must be freed or not, since a decrement to zero
  * does not necessarily mean the bli is unused.
- *
- * Return true if the bli is freed, false otherwise.
  */
-bool
+void
 xfs_buf_item_put(
 	struct xfs_buf_log_item	*bip)
 {
-	struct xfs_log_item	*lip = &bip->bli_item;
-	bool			aborted;
-	bool			dirty;
+
+	ASSERT(xfs_buf_islocked(bip->bli_buf));
 
 	/* drop the bli ref and return if it wasn't the last one */
 	if (!atomic_dec_and_test(&bip->bli_refcount))
-		return false;
+		return;
 
-	/*
-	 * We dropped the last ref and must free the item if clean or aborted.
-	 * If the bli is dirty and non-aborted, the buffer was clean in the
-	 * transaction but still awaiting writeback from previous changes. In
-	 * that case, the bli is freed on buffer writeback completion.
-	 */
-	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-		  xfs_is_shutdown(lip->li_mountp);
-	dirty = bip->bli_flags & XFS_BLI_DIRTY;
-	if (dirty && !aborted)
-		return false;
+	/* If the BLI is in the AIL, then it is still dirty and in use */
+	if (test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags)) {
+		ASSERT(bip->bli_flags & XFS_BLI_DIRTY);
+		return;
+	}
 
 	/*
-	 * The bli is aborted or clean. An aborted item may be in the AIL
-	 * regardless of dirty state.  For example, consider an aborted
-	 * transaction that invalidated a dirty bli and cleared the dirty
-	 * state.
+	 * In shutdown conditions, we can be asked to free a dirty BLI that
+	 * isn't in the AIL. This can occur due to a checkpoint aborting a BLI
+	 * instead of inserting it into the AIL at checkpoint IO completion. If
+	 * there's another bli reference (e.g. a btree cursor holds a clean
+	 * reference) and it is released via xfs_trans_brelse(), we can get here
+	 * with that aborted, dirty BLI. In this case, it is safe to free the
+	 * dirty BLI immediately, as it is not in the AIL and there are no
+	 * other references to it.
+	 *
+	 * We should never get here with a stale BLI via that path as
+	 * xfs_trans_brelse() specifically holds onto stale buffers rather than
+	 * releasing them.
 	 */
-	if (aborted)
-		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
-	return true;
+	ASSERT(!(bip->bli_flags & XFS_BLI_DIRTY) ||
+			test_bit(XFS_LI_ABORTED, &bip->bli_item.li_flags));
+	ASSERT(!(bip->bli_flags & XFS_BLI_STALE));
+	xfs_buf_item_relse(bip);
 }
 
 /*
@@ -651,6 +764,15 @@ xfs_buf_item_put(
  * if necessary but do not unlock the buffer.  This is for support of
  * xfs_trans_bhold(). Make sure the XFS_BLI_HOLD field is cleared if we don't
  * free the item.
+ *
+ * If the XFS_BLI_STALE flag is set, the last reference to the BLI *must*
+ * perform a completion abort of any objects attached to the buffer for IO
+ * tracking purposes. This generally only happens in shutdown situations,
+ * normally xfs_buf_item_unpin() will drop the last BLI reference and perform
+ * completion processing. However, because transaction completion can race with
+ * checkpoint completion during a shutdown, this release context may end up
+ * being the last active reference to the BLI and so needs to perform this
+ * cleanup.
  */
 STATIC void
 xfs_buf_item_release(
@@ -658,18 +780,19 @@ xfs_buf_item_release(
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
 	struct xfs_buf		*bp = bip->bli_buf;
-	bool			released;
 	bool			hold = bip->bli_flags & XFS_BLI_HOLD;
 	bool			stale = bip->bli_flags & XFS_BLI_STALE;
-#if defined(DEBUG) || defined(XFS_WARN)
-	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
-	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
 	bool			aborted = test_bit(XFS_LI_ABORTED,
 						   &lip->li_flags);
+	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
+#if defined(DEBUG) || defined(XFS_WARN)
+	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
 #endif
 
 	trace_xfs_buf_item_release(bip);
 
+	ASSERT(xfs_buf_islocked(bp));
+
 	/*
 	 * The bli dirty state should match whether the blf has logged segments
 	 * except for ordered buffers, where only the bli should be dirty.
@@ -685,16 +808,56 @@ xfs_buf_item_release(
 	bp->b_transp = NULL;
 	bip->bli_flags &= ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED);
 
+	/* If there are other references, then we have nothing to do. */
+	if (!atomic_dec_and_test(&bip->bli_refcount))
+		goto out_release;
+
 	/*
-	 * Unref the item and unlock the buffer unless held or stale. Stale
-	 * buffers remain locked until final unpin unless the bli is freed by
-	 * the unref call. The latter implies shutdown because buffer
-	 * invalidation dirties the bli and transaction.
+	 * Stale buffer completion frees the BLI, unlocks and releases the
+	 * buffer. Neither the BLI or buffer are safe to reference after this
+	 * call, so there's nothing more we need to do here.
+	 *
+	 * If we get here with a stale buffer and references to the BLI remain,
+	 * we must not unlock the buffer as the last BLI reference owns lock
+	 * context, not us.
 	 */
-	released = xfs_buf_item_put(bip);
-	if (hold || (stale && !released))
+	if (stale) {
+		xfs_buf_item_finish_stale(bip);
+		xfs_buf_relse(bp);
+		ASSERT(!hold);
+		return;
+	}
+
+	/*
+	 * Dirty or clean, aborted items are done and need to be removed from
+	 * the AIL and released. This frees the BLI, but leaves the buffer
+	 * locked and referenced.
+	 */
+	if (aborted || xlog_is_shutdown(lip->li_log)) {
+		ASSERT(list_empty(&bip->bli_buf->b_li_list));
+		xfs_buf_item_done(bp);
+		goto out_release;
+	}
+
+	/*
+	 * Clean, unreferenced BLIs can be immediately freed, leaving the buffer
+	 * locked and referenced.
+	 *
+	 * Dirty, unreferenced BLIs *must* be in the AIL awaiting writeback.
+	 */
+	if (!dirty)
+		xfs_buf_item_relse(bip);
+	else
+		ASSERT(test_bit(XFS_LI_IN_AIL, &lip->li_flags));
+
+	/* Not safe to reference the BLI from here */
+out_release:
+	/*
+	 * If we get here with a stale buffer, we must not unlock the
+	 * buffer as the last BLI reference owns lock context, not us.
+	 */
+	if (stale || hold)
 		return;
-	ASSERT(!stale || aborted);
 	xfs_buf_relse(bp);
 }
 
@@ -749,33 +912,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -997,32 +1133,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_zone, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1042,5 +1152,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 50aa0f5ef959..c39202c0135a 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,8 +51,7 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
 void	xfs_buf_inode_iodone(struct xfs_buf *);
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index a4b8caa2c601..8833b1590310 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -597,7 +597,7 @@ xfs_efi_item_recover(
 	struct list_head		*capture_list)
 {
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
 	struct xfs_extent		*extp;
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8d5458b463e3..b609759de490 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -898,7 +898,15 @@ xfs_reclaim_inode(
 
 	if (xfs_is_shutdown(ip->i_mount)) {
 		xfs_iunpin_wait(ip);
-		xfs_iflush_abort(ip);
+		/*
+		 * Avoid a ABBA deadlock on the inode cluster buffer vs
+		 * concurrent xfs_ifree_cluster() trying to mark the inode
+		 * stale. We don't need the inode locked to run the flush abort
+		 * code, but the flush abort needs to lock the cluster buffer.
+		 */
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+		xfs_iflush_shutdown_abort(ip);
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 98955cd0de40..3f2cc6204153 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2492,7 +2492,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
@@ -3648,7 +3648,7 @@ xfs_iflush_cluster(
 
 	/*
 	 * We must use the safe variant here as on shutdown xfs_iflush_abort()
-	 * can remove itself from the list.
+	 * will remove itself from the list.
 	 */
 	list_for_each_entry_safe(lip, n, &bp->b_li_list, li_bio_list) {
 		iip = (struct xfs_inode_log_item *)lip;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index cda71e0c70f6..1e9980a5f80e 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -544,10 +544,17 @@ xfs_inode_item_push(
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
-	ASSERT(iip->ili_item.li_buf);
+	if (!bp || (ip->i_flags & XFS_ISTALE)) {
+		/*
+		 * Inode item/buffer is being being aborted due to cluster
+		 * buffer deletion. Trigger a log force to have that operation
+		 * completed and items removed from the AIL before the next push
+		 * attempt.
+		 */
+		return XFS_ITEM_PINNED;
+	}
 
-	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp) ||
-	    (ip->i_flags & XFS_ISTALE))
+	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp))
 		return XFS_ITEM_PINNED;
 
 	if (xfs_iflags_test(ip, XFS_IFLUSHING))
@@ -827,46 +834,143 @@ xfs_buf_inode_io_fail(
 }
 
 /*
- * This is the inode flushing abort routine.  It is called when
- * the filesystem is shutting down to clean up the inode state.  It is
- * responsible for removing the inode item from the AIL if it has not been
- * re-logged and clearing the inode's flush state.
+ * Clear the inode logging fields so no more flushes are attempted.  If we are
+ * on a buffer list, it is now safe to remove it because the buffer is
+ * guaranteed to be locked. The caller will drop the reference to the buffer
+ * the log item held.
+ */
+static void
+xfs_iflush_abort_clean(
+	struct xfs_inode_log_item *iip)
+{
+	iip->ili_last_fields = 0;
+	iip->ili_fields = 0;
+	iip->ili_fsync_fields = 0;
+	iip->ili_flush_lsn = 0;
+	iip->ili_item.li_buf = NULL;
+	list_del_init(&iip->ili_item.li_bio_list);
+}
+
+/*
+ * Abort flushing the inode from a context holding the cluster buffer locked.
+ *
+ * This is the normal runtime method of aborting writeback of an inode that is
+ * attached to a cluster buffer. It occurs when the inode and the backing
+ * cluster buffer have been freed (i.e. inode is XFS_ISTALE), or when cluster
+ * flushing or buffer IO completion encounters a log shutdown situation.
+ *
+ * If we need to abort inode writeback and we don't already hold the buffer
+ * locked, call xfs_iflush_shutdown_abort() instead as this should only ever be
+ * necessary in a shutdown situation.
  */
 void
 xfs_iflush_abort(
 	struct xfs_inode	*ip)
 {
 	struct xfs_inode_log_item *iip = ip->i_itemp;
-	struct xfs_buf		*bp = NULL;
+	struct xfs_buf		*bp;
 
-	if (iip) {
-		/*
-		 * Clear the failed bit before removing the item from the AIL so
-		 * xfs_trans_ail_delete() doesn't try to clear and release the
-		 * buffer attached to the log item before we are done with it.
-		 */
-		clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
-		xfs_trans_ail_delete(&iip->ili_item, 0);
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	/*
+	 * Remove the inode item from the AIL before we clear its internal
+	 * state. Whilst the inode is in the AIL, it should have a valid buffer
+	 * pointer for push operations to access - it is only safe to remove the
+	 * inode from the buffer once it has been removed from the AIL.
+	 *
+	 * We also clear the failed bit before removing the item from the AIL
+	 * as xfs_trans_ail_delete()->xfs_clear_li_failed() will release buffer
+	 * references the inode item owns and needs to hold until we've fully
+	 * aborted the inode log item and detached it from the buffer.
+	 */
+	clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
+	xfs_trans_ail_delete(&iip->ili_item, 0);
+
+	/*
+	 * Grab the inode buffer so can we release the reference the inode log
+	 * item holds on it.
+	 */
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	xfs_iflush_abort_clean(iip);
+	spin_unlock(&iip->ili_lock);
 
+	xfs_iflags_clear(ip, XFS_IFLUSHING);
+	if (bp)
+		xfs_buf_rele(bp);
+}
+
+/*
+ * Abort an inode flush in the case of a shutdown filesystem. This can be called
+ * from anywhere with just an inode reference and does not require holding the
+ * inode cluster buffer locked. If the inode is attached to a cluster buffer,
+ * it will grab and lock it safely, then abort the inode flush.
+ */
+void
+xfs_iflush_shutdown_abort(
+	struct xfs_inode	*ip)
+{
+	struct xfs_inode_log_item *iip = ip->i_itemp;
+	struct xfs_buf		*bp;
+
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	if (!bp) {
+		spin_unlock(&iip->ili_lock);
+		xfs_iflush_abort(ip);
+		return;
+	}
+
+	/*
+	 * We have to take a reference to the buffer so that it doesn't get
+	 * freed when we drop the ili_lock and then wait to lock the buffer.
+	 * We'll clean up the extra reference after we pick up the ili_lock
+	 * again.
+	 */
+	xfs_buf_hold(bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_buf_lock(bp);
+
+	spin_lock(&iip->ili_lock);
+	if (!iip->ili_item.li_buf) {
 		/*
-		 * Clear the inode logging fields so no more flushes are
-		 * attempted.
+		 * Raced with another removal, hold the only reference
+		 * to bp now. Inode should not be in the AIL now, so just clean
+		 * up and return;
 		 */
-		spin_lock(&iip->ili_lock);
-		iip->ili_last_fields = 0;
-		iip->ili_fields = 0;
-		iip->ili_fsync_fields = 0;
-		iip->ili_flush_lsn = 0;
-		bp = iip->ili_item.li_buf;
-		iip->ili_item.li_buf = NULL;
-		list_del_init(&iip->ili_item.li_bio_list);
+		ASSERT(list_empty(&iip->ili_item.li_bio_list));
+		ASSERT(!test_bit(XFS_LI_IN_AIL, &iip->ili_item.li_flags));
+		xfs_iflush_abort_clean(iip);
 		spin_unlock(&iip->ili_lock);
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		xfs_buf_relse(bp);
+		return;
 	}
-	xfs_iflags_clear(ip, XFS_IFLUSHING);
-	if (bp)
-		xfs_buf_rele(bp);
+
+	/*
+	 * Got two references to bp. The first will get dropped by
+	 * xfs_iflush_abort() when the item is removed from the buffer list, but
+	 * we can't drop our reference until _abort() returns because we have to
+	 * unlock the buffer as well. Hence we abort and then unlock and release
+	 * our reference to the buffer.
+	 */
+	ASSERT(iip->ili_item.li_buf == bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_iflush_abort(ip);
+	xfs_buf_relse(bp);
 }
 
+
 /*
  * convert an xfs_inode_log_format struct from the old 32 bit version
  * (which can have different field alignments) to the native 64 bit version
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index 403b45ab9aa2..9c829cf5c839 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -44,6 +44,7 @@ static inline int xfs_inode_clean(struct xfs_inode *ip)
 extern void xfs_inode_item_init(struct xfs_inode *, struct xfs_mount *);
 extern void xfs_inode_item_destroy(struct xfs_inode *);
 extern void xfs_iflush_abort(struct xfs_inode *);
+extern void xfs_iflush_shutdown_abort(struct xfs_inode *);
 extern int xfs_inode_item_format_convert(xfs_log_iovec_t *,
 					 struct xfs_inode_log_format *);
 
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 68473e51593f..e65bbbde6e37 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1072,7 +1072,7 @@ xfs_log_item_init(
 	int			type,
 	const struct xfs_item_ops *ops)
 {
-	item->li_mountp = mp;
+	item->li_log = mp->m_log;
 	item->li_ailp = mp->m_ail;
 	item->li_type = type;
 	item->li_ops = ops;
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eafe30843ff0..af91ea1025c0 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1428,7 +1428,7 @@ bool
 xfs_log_item_in_current_chkpt(
 	struct xfs_log_item	*lip)
 {
-	struct xfs_cil		*cil = lip->li_mountp->m_log->l_cilp;
+	struct xfs_cil		*cil = lip->li_log->l_cilp;
 
 	if (list_empty(&lip->li_cil))
 		return false;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 8ef842d17916..cc9bda6b6277 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -459,7 +459,7 @@ xfs_cui_item_recover(
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	xfs_fsblock_t			new_fsb;
 	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 15e7b01740a7..06d86a6fa128 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -512,7 +512,7 @@ xfs_rui_item_recover(
 	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	enum xfs_rmap_intent_type	type;
 	xfs_exntst_t			state;
 	int				i;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ebd17ddba024..3682dd11581a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1309,7 +1309,7 @@ DECLARE_EVENT_CLASS(xfs_log_item_class,
 		__field(xfs_lsn_t, lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
@@ -1362,7 +1362,7 @@ DECLARE_EVENT_CLASS(xfs_ail_class,
 		__field(xfs_lsn_t, new_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 95c183072e7a..5eec011841b9 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -648,7 +648,7 @@ xfs_trans_add_item(
 	struct xfs_trans	*tp,
 	struct xfs_log_item	*lip)
 {
-	ASSERT(lip->li_mountp == tp->t_mountp);
+	ASSERT(lip->li_log == tp->t_mountp->m_log);
 	ASSERT(lip->li_ailp == tp->t_mountp->m_ail);
 	ASSERT(list_empty(&lip->li_trans));
 	ASSERT(!test_bit(XFS_LI_DIRTY, &lip->li_flags));
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index faba74d4c702..d655abb5c235 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -8,6 +8,7 @@
 
 /* kernel only transaction subsystem defines */
 
+struct xlog;
 struct xfs_buf;
 struct xfs_buftarg;
 struct xfs_efd_log_item;
@@ -31,7 +32,7 @@ struct xfs_log_item {
 	struct list_head		li_ail;		/* AIL pointers */
 	struct list_head		li_trans;	/* transaction list */
 	xfs_lsn_t			li_lsn;		/* last on-disk lsn */
-	struct xfs_mount		*li_mountp;	/* ptr to fs mount */
+	struct xlog			*li_log;
 	struct xfs_ail			*li_ailp;	/* ptr to AIL */
 	uint				li_type;	/* item type */
 	unsigned long			li_flags;	/* misc flags */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index f887eb21e178..a7d2283d4996 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -43,11 +43,13 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
+ * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
+	u32 skbcnt;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
@@ -105,6 +107,7 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e60fbdde9308..408e9b2c412b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -404,7 +404,10 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
-	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	/*
+	 * Sequence number for cgroup.kill. Incremented with both cgroup_mutex
+	 * and css_set_lock held. Readers hold either one.
+	 */
 	unsigned int kill_seq;
 
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 114553b487ef..3cd473e166a8 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -356,6 +356,11 @@ struct dm_target {
 	 */
 	bool discards_supported:1;
 
+	/*
+	 * Set if this target requires stable data during writeback.
+	 */
+	bool needs_stable_writes:1;
+
 	/*
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 04826a793039..e4f4838f3b7b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1486,6 +1486,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1522,6 +1523,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 514faca8be42..3b4dd5aeb879 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -474,6 +474,7 @@ struct fsnotify_mark_connector {
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_DESTROYING	0x04
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index afc678d7fc86..c9a30ba3dc2d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -559,8 +559,9 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
 extern ftrace_func_t ftrace_trace_function;
+struct trace_array;
 
-int ftrace_regex_open(struct ftrace_ops *ops, int flag,
+int ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file);
 ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
 			    size_t cnt, loff_t *ppos);
@@ -774,7 +775,7 @@ static inline unsigned long ftrace_location(unsigned long ip)
  * have them defined when ftrace is not enabled, but these
  * functions may still be called. Use a macro instead of inline.
  */
-#define ftrace_regex_open(ops, flag, inod, file) ({ -ENODEV; })
+#define ftrace_regex_open(tr, ops, flag, inode, file) ({ -ENODEV; })
 #define ftrace_set_early_filter(ops, buf, enable) do { } while (0)
 #define ftrace_set_filter_ip(ops, ip, remove, reset) ({ -ENODEV; })
 #define ftrace_set_filter(ops, buf, len, reset) ({ -ENODEV; })
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..09f757f14d01 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,26 +23,30 @@ struct task_struct;
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
- *       (but private mapping on an mm, and reference taken on it)
+ *       (but private mapping on an mm)
 */
 
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    1 /* We set bit 0 if shared key identifies an inode */
+#define FUT_OFF_MMSHARED 2 /* We set bit 1 if shared key identifies an mm */
 
 union futex_key {
+	/* For FUT_OFF_INODE */
 	struct {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
 	} shared;
+
+	/* For FUT_OFF_MMSHARED or private */
 	struct {
 		union {
-			struct mm_struct *mm;
-			u64 __tmp;
+			struct mm_struct *mm; /* for private */
+			u64 mm_seq; /* for FUT_OFF_MMSHARED */
 		};
 		unsigned long address;
 		unsigned int offset;
 	} private;
+
 	struct {
 		u64 ptr;
 		unsigned long word;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ab088e77742c..d9eb1f815614 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -815,11 +815,11 @@ struct hid_driver {
 	void (*feature_mapping)(struct hid_device *hdev,
 			struct hid_field *field,
 			struct hid_usage *usage);
-#ifdef CONFIG_PM
+
 	int (*suspend)(struct hid_device *hdev, pm_message_t message);
 	int (*resume)(struct hid_device *hdev);
 	int (*reset_resume)(struct hid_device *hdev);
-#endif
+
 /* private: */
 	struct device_driver driver;
 };
@@ -937,6 +937,8 @@ extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
+int hid_safe_input_report(struct hid_device *hid, int type, u8 *data,
+			  size_t bufsize, u32 size, int interrupt);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 996886f187a1..b115fb9e2071 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -188,6 +188,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					      u8 *values);
 int i2c_get_device_id(const struct i2c_client *client,
 		      struct i2c_device_identity *id);
+const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_client *client);
 #endif /* I2C */
 
 /**
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 762c77d13e7d..a1fadb70dd52 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,8 +121,7 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_enabled)(struct team *team, struct team_port *port);
-	void (*port_disabled)(struct team *team, struct team_port *port);
+	void (*port_tx_disabled)(struct team *team, struct team_port *port);
 };
 
 extern int team_modeop_port_enter(struct team *team, struct team_port *port);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 3728e3978f83..2759d3846666 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -346,6 +346,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 {
 	struct vlan_ethhdr *veth;
 
+	if (unlikely(!pskb_may_pull(skb, mac_len)))
+		return -EINVAL;
+
 	if (skb_cow_head(skb, VLAN_HLEN) < 0)
 		return -ENOMEM;
 
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 5caf3ce82373..1336c14138ab 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -158,6 +158,7 @@ struct key_type {
 				     const void *in, const void *in2);
 
 	/* internal fields */
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
 } __randomize_layout;
diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..4a81a5242f4b 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -101,6 +101,7 @@ struct keyring_name;
 
 struct key_tag {
 	struct rcu_head		rcu;
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	refcount_t		usage;
 	bool			removed;	/* T when subject removed */
 };
@@ -123,6 +124,8 @@ struct keyring_index_key {
 	struct key_type		*type;
 	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
+	u64			type_id;	/* Cached index IDs */
+	u64			domain_id;
 };
 
 union key_payload {
@@ -244,6 +247,8 @@ struct key {
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
+			u64		type_id;
+			u64		domain_id;
 		};
 	};
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 24b0eaa5de30..e5262feff826 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -177,6 +177,7 @@ struct kprobe_blacklist_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_KPROBES
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 70ce419e2709..d6034b8bbb7d 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -265,7 +265,7 @@ void		  nsm_release(struct nsm_handle *nsm);
  * This is used in garbage collection and resource reclaim
  * A return value != 0 means destroy the lock/block/share
  */
-typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
+typedef int	  (*nlm_host_match_fn_t)(void *owner, struct nlm_host *ref);
 
 /*
  * Server-side lock handling
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 071dd864a7b2..bd69dd6c5e9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2581,7 +2581,7 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07285b44d831..4a663b39585b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -580,6 +580,10 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
+#ifdef CONFIG_FUTEX
+		atomic64_t futex_unique_id;
+#endif
+
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..8855beffb1e4 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -52,7 +52,7 @@ struct fs_context;
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
 			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
-			    MNT_CURSOR)
+			    MNT_CURSOR | MNT_UMOUNT)
 
 #define MNT_INTERNAL	0x4000
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8a2c60235ebb..c5a644f5cd4e 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -377,7 +377,7 @@ struct mtd_info {
 
 	struct module *owner;
 	struct device dev;
-	int usecount;
+	struct kref refcnt;
 	struct mtd_debug_info dbg;
 	struct nvmem_device *nvmem;
 	struct nvmem_device *otp_user_nvmem;
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index a27e5e17836b..8e6f4f4c8e0c 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -158,7 +158,8 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
 int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
 			       __u32 portid, __u32 group, gfp_t allocation,
-			       int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
 			       void *filter_data);
 int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
 int netlink_register_notifier(struct notifier_block *nb);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8531f375d061..edc701da824f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -957,8 +957,8 @@ enum {
 	NVME_ZRASF_ZONE_STATE_IMP_OPEN	= 0x02,
 	NVME_ZRASF_ZONE_STATE_EXP_OPEN	= 0x03,
 	NVME_ZRASF_ZONE_STATE_CLOSED	= 0x04,
-	NVME_ZRASF_ZONE_STATE_READONLY	= 0x05,
-	NVME_ZRASF_ZONE_STATE_FULL	= 0x06,
+	NVME_ZRASF_ZONE_STATE_FULL	= 0x05,
+	NVME_ZRASF_ZONE_STATE_READONLY	= 0x06,
 	NVME_ZRASF_ZONE_STATE_OFFLINE	= 0x07,
 	NVME_REPORT_ZONE_PARTIAL	= 1,
 };
diff --git a/include/linux/property.h b/include/linux/property.h
index 840f0545d4f9..180d4a027ab3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -11,6 +11,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
 
@@ -124,6 +125,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
+
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..c54580c48076 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -265,17 +265,12 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * QUP Core 2X clock votes used by GENI clients through the "qup-core" ICC
+ * path. Values are in Bps and must be converted with Bps_to_icc() before
+ * setting avg_bw.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13c95782c063..324a3fd0f3c3 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -119,8 +119,9 @@ struct signal_struct {
 	 * process will inherit a flag if they should look for a
 	 * child_subreaper process at exit.
 	 */
-	unsigned int		is_child_subreaper:1;
-	unsigned int		has_child_subreaper:1;
+	bool			is_child_subreaper;
+	bool			has_child_subreaper;
+	unsigned int		autoreap:1;
 
 #ifdef CONFIG_POSIX_TIMERS
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 24ceeab1b509..e2483ac59382 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1346,7 +1346,7 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
 	__skb_set_hash(skb, hash, true, is_l4);
 }
 
-void __skb_get_hash(struct sk_buff *skb);
+void __skb_get_hash_net(const struct net *net, struct sk_buff *skb);
 u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
@@ -1426,10 +1426,18 @@ void skb_flow_dissect_hash(const struct sk_buff *skb,
 			   struct flow_dissector *flow_dissector,
 			   void *target_container);
 
+static inline __u32 skb_get_hash_net(const struct net *net, struct sk_buff *skb)
+{
+	if (!skb->l4_hash && !skb->sw_hash)
+		__skb_get_hash_net(net, skb);
+
+	return skb->hash;
+}
+
 static inline __u32 skb_get_hash(struct sk_buff *skb)
 {
 	if (!skb->l4_hash && !skb->sw_hash)
-		__skb_get_hash(skb);
+		__skb_get_hash_net(NULL, skb);
 
 	return skb->hash;
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 168e57e40bbb..cccbadedf6e7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -122,33 +122,85 @@ struct tty_operations;
 /**
  * struct tty_struct - state associated with a tty while open
  *
- * @flow.lock: lock for flow members
- * @flow.stopped: tty stopped/started by tty_stop/tty_start
- * @flow.tco_stopped: tty stopped/started by TCOOFF/TCOON ioctls (it has
- *		      precedense over @flow.stopped)
+ * @magic: magic value set early in @alloc_tty_struct to %TTY_MAGIC, for
+ *	   debugging purposes
+ * @kref: reference counting by tty_kref_get() and tty_kref_put(), reaching zero
+ *	  frees the structure
+ * @dev: class device or %NULL (e.g. ptys, serdev)
+ * @driver: &struct tty_driver operating this tty
+ * @ops: &struct tty_operations of @driver for this tty (open, close, etc.)
+ * @index: index of this tty (e.g. to construct @name like tty12)
+ * @ldisc_sem: protects line discipline changes (@ldisc) -- lock tty not pty
+ * @ldisc: the current line discipline for this tty (n_tty by default)
+ * @atomic_write_lock: protects against concurrent writers, i.e. locks
+ *		       @write_cnt, @write_buf and similar
+ * @legacy_mutex: leftover from history (BKL -> BTM -> @legacy_mutex),
+ *		  protecting several operations on this tty
+ * @throttle_mutex: protects against concurrent tty_throttle_safe() and
+ *		    tty_unthrottle_safe() (but not tty_unthrottle())
+ * @termios_rwsem: protects @termios and @termios_locked
+ * @winsize_mutex: protects @winsize
+ * @termios: termios for the current tty, copied from/to @driver.termios
+ * @termios_locked: locked termios (by %TIOCGLCKTRMIOS and %TIOCSLCKTRMIOS
+ *		    ioctls)
+ * @name: name of the tty constructed by tty_line_name() (e.g. ttyS3)
+ * @flags: bitwise OR of %TTY_THROTTLED, %TTY_IO_ERROR, ...
+ * @count: count of open processes, reaching zero cancels all the work for
+ *	   this tty and drops a @kref too (but does not free this tty)
+ * @winsize: size of the terminal "window" (cf. @winsize_mutex)
+ * @flow: flow settings grouped together, see also @flow.unused
+ * @flow.lock: lock for @flow members
+ * @flow.stopped: tty stopped/started by stop_tty()/start_tty()
+ * @flow.tco_stopped: tty stopped/started by %TCOOFF/%TCOON ioctls (it has
+ *		      precedence over @flow.stopped)
  * @flow.unused: alignment for Alpha, so that no members other than @flow.* are
  *		 modified by the same 64b word store. The @flow's __aligned is
  *		 there for the very same reason.
- * @ctrl.lock: lock for ctrl members
+ * @ctrl: control settings grouped together, see also @ctrl.unused
+ * @ctrl.lock: lock for @ctrl members
  * @ctrl.pgrp: process group of this tty (setpgrp(2))
  * @ctrl.session: session of this tty (setsid(2)). Writes are protected by both
- *		  @ctrl.lock and legacy mutex, readers must use at least one of
+ *		  @ctrl.lock and @legacy_mutex, readers must use at least one of
  *		  them.
- * @ctrl.pktstatus: packet mode status (bitwise OR of TIOCPKT_* constants)
+ * @ctrl.pktstatus: packet mode status (bitwise OR of %TIOCPKT_ constants)
  * @ctrl.packet: packet mode enabled
+ * @ctrl.unused: alignment for Alpha, see @flow.unused for explanation
+ * @hw_stopped: not controlled by the tty layer, under @driver's control for CTS
+ *		handling
+ * @receive_room: bytes permitted to feed to @ldisc without any being lost
+ * @flow_change: controls behavior of throttling, see tty_throttle_safe() and
+ *		 tty_unthrottle_safe()
+ * @link: link to another pty (master -> slave and vice versa)
+ * @fasync: state for %O_ASYNC (for %SIGIO); managed by fasync_helper()
+ * @write_wait: concurrent writers are waiting in this queue until they are
+ *		allowed to write
+ * @read_wait: readers wait for data in this queue
+ * @break_wait: wait queue for timed breaks
+ * @hangup_work: normally a work to perform a hangup (do_tty_hangup()); while
+ *		 freeing the tty, (re)used to release_one_tty()
+ * @disc_data: pointer to @ldisc's private data (e.g. to &struct n_tty_data)
+ * @driver_data: pointer to @driver's private data (e.g. &struct uart_state)
+ * @files_lock:	protects @tty_files list
+ * @tty_files: list of (re)openers of this tty (i.e. linked &struct
+ *	       tty_file_private)
+ * @closing: when set during close, n_tty processes only START & STOP chars
+ * @write_buf: temporary buffer used during tty_write() to copy user data to
+ * @write_cnt: count of bytes written in tty_write() to @write_buf
+ * @SAK_work: if the tty has a pending do_SAK, it is queued here
+ * @port: persistent storage for this device (i.e. &struct tty_port)
  *
  * All of the state associated with a tty while the tty is open. Persistent
- * storage for tty devices is referenced here as @port in struct tty_port.
+ * storage for tty devices is referenced here as @port and is documented in
+ * &struct tty_port.
  */
 struct tty_struct {
 	int	magic;
 	struct kref kref;
-	struct device *dev;	/* class device or NULL (e.g. ptys, serdev) */
+	struct device *dev;
 	struct tty_driver *driver;
 	const struct tty_operations *ops;
 	int index;
 
-	/* Protects ldisc changes: Lock tty not pty */
 	struct ld_semaphore ldisc_sem;
 	struct tty_ldisc *ldisc;
 
@@ -157,12 +209,11 @@ struct tty_struct {
 	struct mutex throttle_mutex;
 	struct rw_semaphore termios_rwsem;
 	struct mutex winsize_mutex;
-	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
 	char name[64];
 	unsigned long flags;
 	int count;
-	struct winsize winsize;		/* winsize_mutex */
+	struct winsize winsize;
 
 	struct {
 		spinlock_t lock;
@@ -181,17 +232,18 @@ struct tty_struct {
 	} __aligned(sizeof(unsigned long)) ctrl;
 
 	int hw_stopped;
-	unsigned int receive_room;	/* Bytes free for queue */
+	unsigned int receive_room;
 	int flow_change;
 
 	struct tty_struct *link;
 	struct fasync_struct *fasync;
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
+	wait_queue_head_t break_wait;
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-	spinlock_t files_lock;		/* protects tty_files list */
+	spinlock_t files_lock;
 	struct list_head tty_files;
 
 #define N_TTY_BUF_SIZE 4096
@@ -199,7 +251,6 @@ struct tty_struct {
 	int closing;
 	unsigned char *write_buf;
 	int write_cnt;
-	/* If the tty has a pending do_SAK, queue it here - akpm */
 	struct work_struct SAK_work;
 	struct tty_port *port;
 } __randomize_layout;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index c20431d8def8..aa0564b34fd7 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -395,6 +395,10 @@ static inline void tty_set_operations(struct tty_driver *driver,
  *	other words create /dev/ttyprintk and not /dev/ttyprintk0.
  *	Applicable only when a driver for a single tty device is
  *	being allocated.
+ *
+ * TTY_DRIVER_RESET_SAVED_TERMIOS -- reset any saved termios settings on
+ *	device registration when reusing a minor number. Must only be set by
+ *	drivers that guarantee that the minor number is no longer in use.
  */
 #define TTY_DRIVER_INSTALLED		0x0001
 #define TTY_DRIVER_RESET_TERMIOS	0x0002
@@ -404,6 +408,7 @@ static inline void tty_set_operations(struct tty_driver *driver,
 #define TTY_DRIVER_HARDWARE_BREAK	0x0020
 #define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
 #define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+#define TTY_DRIVER_RESET_SAVED_TERMIOS	0x0200
 
 /* tty driver types */
 #define TTY_DRIVER_TYPE_SYSTEM		0x0001
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 6e86e9e118b6..7b0a1c360ff4 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -187,6 +187,7 @@ void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
 void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void tty_port_tty_vhangup(struct tty_port *port);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 74484d44c755..b82625a02368 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -8,6 +8,7 @@
 struct unicode_map {
 	const char *charset;
 	int version;
+	struct rcu_head rcu;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 16ea5a4cc586..72b183bf34f7 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -382,6 +382,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 
 int usb_serial_bus_register(struct usb_serial_driver *device);
 void usb_serial_bus_deregister(struct usb_serial_driver *device);
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver);
 
 extern struct bus_type usb_serial_bus_type;
 extern struct tty_driver *usb_serial_tty_driver;
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index f742e50207fb..2b5dd17cb58a 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -204,6 +204,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b906151c0783..bb5c8fdd9d33 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -60,7 +60,7 @@ struct inquiry_entry {
 		NAME_PENDING,
 		NAME_KNOWN,
 	} name_state;
-	__u32			timestamp;
+	unsigned long		timestamp;
 	struct inquiry_data	data;
 };
 
@@ -76,7 +76,7 @@ struct discovery_state {
 	struct list_head	all;	/* All devices found during inquiry */
 	struct list_head	unknown;	/* Name state not known */
 	struct list_head	resolve;	/* Name needs to be resolved */
-	__u32			timestamp;
+	unsigned long		timestamp;
 	bdaddr_t		last_adv_addr;
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index ba8d3702853d..d483830188f3 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -210,6 +210,7 @@ struct rfcomm_dlc {
 #define RFCOMM_AUTH_REJECT  7
 #define RFCOMM_DEFER_SETUP  8
 #define RFCOMM_ENC_DROP     9
+#define RFCOMM_CLOSED       10
 
 /* Scheduling flags and events */
 #define RFCOMM_SCHED_WAKEUP 31
diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index d289b91dcd65..f7615981d39e 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -154,6 +154,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
diff --git a/include/net/mctpdevice.h b/include/net/mctpdevice.h
index 71a11012fac7..3a439463f055 100644
--- a/include/net/mctpdevice.h
+++ b/include/net/mctpdevice.h
@@ -17,6 +17,8 @@
 struct mctp_dev {
 	struct net_device	*dev;
 
+	refcount_t		refs;
+
 	unsigned int		net;
 
 	/* Only modified under RTNL. Reads have addrs_lock held */
@@ -32,4 +34,7 @@ struct mctp_dev {
 struct mctp_dev *mctp_dev_get_rtnl(const struct net_device *dev);
 struct mctp_dev *__mctp_dev_get(const struct net_device *dev);
 
+void mctp_dev_hold(struct mctp_dev *mdev);
+void mctp_dev_put(struct mctp_dev *mdev);
+
 #endif /* __NET_MCTPDEVICE_H */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2b977d5d6f30..e05e2d85f67b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -435,7 +435,7 @@ struct nft_set_ops {
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
 						  const struct nft_set_elem *elem,
-						  struct nft_set_ext **ext);
+						  void **priv);
 	void				(*activate)(const struct net *net,
 						    const struct nft_set *set,
 						    const struct nft_set_elem *elem);
@@ -1373,24 +1373,28 @@ void nft_unregister_flowtable_type(struct nf_flowtable_type *type);
 /**
  *	struct nft_traceinfo - nft tracing information and state
  *
+ *	@trace: other struct members are initialised
+ *	@nf_trace: copy of skb->nf_trace before rule evaluation
+ *	@type: event type (enum nft_trace_types)
+ *	@skbid: hash of skb to be used as trace id
+ *	@packet_dumped: packet headers sent in a previous traceinfo message
  *	@pkt: pktinfo currently processed
  *	@basechain: base chain currently processed
  *	@chain: chain currently processed
  *	@rule:  rule that was evaluated
  *	@verdict: verdict given by rule
- *	@type: event type (enum nft_trace_types)
- *	@packet_dumped: packet headers sent in a previous traceinfo message
- *	@trace: other struct members are initialised
  */
 struct nft_traceinfo {
+	bool				trace;
+	bool				nf_trace;
+	bool				packet_dumped;
+	enum nft_trace_types		type:8;
+	u32				skbid;
 	const struct nft_pktinfo	*pkt;
 	const struct nft_base_chain	*basechain;
 	const struct nft_chain		*chain;
 	const struct nft_rule		*rule;
 	const struct nft_verdict	*verdict;
-	enum nft_trace_types		type;
-	bool				packet_dumped;
-	bool				trace;
 };
 
 void nft_trace_init(struct nft_traceinfo *info, const struct nft_pktinfo *pkt,
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 7922ec72eaa6..eb9edddd7309 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -23,6 +23,7 @@ struct xfrm_policy_hash {
 struct xfrm_policy_hthresh {
 	struct work_struct	work;
 	seqlock_t		lock;
+	bool			work_disabled;
 	u8			lbits4;
 	u8			rbits4;
 	u8			lbits6;
diff --git a/include/net/strparser.h b/include/net/strparser.h
index a191486eb1e4..7856577224d5 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -86,11 +86,11 @@ static inline struct strp_msg *strp_msg(struct sk_buff *skb)
 struct strparser {
 	struct sock *sk;
 
-	u32 stopped : 1;
-	u32 paused : 1;
-	u32 aborted : 1;
-	u32 interrupted : 1;
-	u32 unrecov_intr : 1;
+	u8 stopped;
+	u8 paused;
+	u8 aborted;
+	u8 interrupted;
+	u8 unrecov_intr;
 
 	struct sk_buff **skb_nextp;
 	struct sk_buff *skb_head;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a0f3dd3faf60..0dec2857f5b5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -974,6 +974,10 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 					const struct sk_buff *from)
 {
+#ifdef CONFIG_TLS_DEVICE
+	if (from->decrypted != to->decrypted)
+		return false;
+#endif
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from));
 }
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..ea36620df1c9 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -34,8 +34,9 @@
 #define CLONE_IO		0x80000000	/* Clone io context */
 
 /* Flags for the clone3() syscall. */
-#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
-#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_CLEAR_SIGHAND	(1ULL << 32) /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP	(1ULL << 33) /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_AUTOREAP		(1ULL << 34) /* Auto-reap child on exit. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index f57743d911b4..22f732a4a006 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1224,6 +1224,8 @@ static bool io_task_work_match(struct callback_head *cb, void *data)
 void io_wq_exit_start(struct io_wq *wq)
 {
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	/* Pairs with task_work_add() in io_queue_worker_create(). */
+	smp_mb__after_atomic();
 }
 
 static void io_wq_cancel_tw_create(struct io_wq *wq)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8747c585a077..8d5791d8f403 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2797,7 +2797,10 @@ static void io_req_task_complete(struct io_kiocb *req, bool *locked)
 
 static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 {
-	io_req_io_end(req);
+	if (req->rw.kiocb.ki_flags & IOCB_WRITE)
+		fsnotify_modify(req->file);
+	else
+		fsnotify_access(req->file);
 	io_req_task_complete(req, locked);
 }
 
@@ -2807,6 +2810,10 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
 	if (__io_complete_rw_common(req, res))
 		return;
+	/* ring owner may block in freeze_super() before task_work runs */
+	if (kiocb->ki_flags & IOCB_WRITE)
+		io_req_end_write(req);
+
 	req->result = io_fixup_rw_res(req, res);
 	req->io_task_work.func = io_req_rw_complete;
 	io_req_task_work_add(req);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 2c21b4b1d763..7d794ed27a7d 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -543,22 +543,38 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
+	bool need_sync = false;
 
 	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
 		entry = container_of(rule, struct audit_entry, rule);
 
-		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
 			audit_tree_log_remove_rule(context, rule);
-			if (entry->rule.exe)
-				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
 			list_del_rcu(&entry->list);
 			list_del(&entry->rule.list);
-			call_rcu(&entry->rcu, audit_free_rule_rcu);
+			if (entry->rule.exe)
+				need_sync = true;
+		} else {
+			list_del_init(&rule->rlist);
 		}
 	}
+
+	if (list_empty(&tree->rules))
+		return;
+
+	if (need_sync)
+		synchronize_rcu();
+
+	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
+		entry = container_of(rule, struct audit_entry, rule);
+
+		list_del_init(&rule->rlist);
+		if (entry->rule.exe)
+			audit_remove_mark(entry->rule.exe);
+		call_rcu(&entry->rcu, audit_free_rule_rcu);
+	}
 }
 
 /*
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index dc42970dda97..a13a270c9aa2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -158,6 +158,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	return &array->map;
 }
 
+static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
+{
+	return array->value + (u64)array->elem_size * index;
+}
+
 /* Called from syscall or from eBPF program */
 static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 {
@@ -167,7 +172,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return array->value + array->elem_size * (index & array->index_mask);
+	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
@@ -325,7 +330,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		       value, map->value_size);
 	} else {
 		val = array->value +
-			array->elem_size * (index & array->index_mask);
+			(u64)array->elem_size * (index & array->index_mask);
 		if (map_flags & BPF_F_LOCK)
 			copy_map_value_locked(map, val, value, false);
 		else
@@ -393,8 +398,7 @@ static void array_map_free_timers(struct bpf_map *map)
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		bpf_timer_cancel_and_free(array->value + array->elem_size * i +
-					  map->timer_off);
+		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
@@ -534,7 +538,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -553,7 +557,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
@@ -674,7 +678,7 @@ static int bpf_for_each_array_elem(struct bpf_map *map, void *callback_fn,
 		if (is_percpu)
 			val = this_cpu_ptr(array->pptrs[i]);
 		else
-			val = array->value + array->elem_size * i;
+			val = array_map_elem_ptr(array, i);
 		num_elems++;
 		key = i;
 		ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2048fc3e2256..47d7fd21f9b2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6228,10 +6228,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6282,6 +6279,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	put_css_set(cset);
 	fput(f);
 	kargs->cgrp = dst_cgrp;
+	kargs->kill_seq = dst_cgrp->kill_seq;
 	return ret;
 
 err:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc59568a538f..fc2d2f273445 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6691,18 +6691,20 @@ void perf_event_wakeup(struct perf_event *event)
 static void perf_sigtrap(struct perf_event *event)
 {
 	/*
-	 * We'd expect this to only occur if the irq_work is delayed and either
-	 * ctx->task or current has changed in the meantime. This can be the
-	 * case on architectures that do not implement arch_irq_work_raise().
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting or exec-ing. We can determine if such a race has
+	 * occurred by checking if perf_event_exit_task(), which will set
+	 * ctx->task to TASK_TOMBSTONE, has already been called.
 	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
+	if (event->ctx->task == TASK_TOMBSTONE)
 		return;
 
 	/*
-	 * Both perf_pending_task() and perf_pending_irq() can race with the
-	 * task exiting.
+	 * We'd expect this to only occur if the irq_work is delayed and either
+	 * ctx->task or current has changed in the meantime. This can be the
+	 * case on architectures that do not implement arch_irq_work_raise().
 	 */
-	if (current->flags & PF_EXITING)
+	if (WARN_ON_ONCE(event->ctx->task != current))
 		return;
 
 	send_sig_perf((void __user *)event->pending_addr,
@@ -12425,7 +12427,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || attr.text_poke) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
diff --git a/kernel/fork.c b/kernel/fork.c
index 70696b49c104..25fb13362d38 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1082,6 +1082,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_FUTEX
+	atomic64_set(&mm->futex_unique_id, 0);
+#endif
 
 	if (current->mm) {
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
@@ -2105,6 +2108,18 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_AUTOREAP) {
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+		if (clone_flags & CLONE_PARENT)
+			return ERR_PTR(-EINVAL);
+		if (args->exit_signal)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if ((clone_flags & CLONE_PARENT) && current->signal->autoreap)
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2479,6 +2494,8 @@ static __latent_entropy struct task_struct *copy_process(
 			 */
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
+			if (clone_flags & CLONE_AUTOREAP)
+				p->signal->autoreap = 1;
 			list_add_tail(&p->sibling, &p->real_parent->children);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
@@ -2903,7 +2920,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
+	      CLONE_AUTOREAP))
 		return false;
 
 	/*
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 8a3a27967973..0055c446b0c6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -473,39 +473,27 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 }
 
 /*
- * Generate a machine wide unique identifier for this inode.
+ * Generate a machine wide unique identifier for this object (inode or mm).
  *
  * This relies on u64 not wrapping in the life-time of the machine; which with
  * 1ns resolution means almost 585 years.
- *
- * This further relies on the fact that a well formed program will not unmap
- * the file while it has a (shared) futex waiting on it. This mapping will have
- * a file reference which pins the mount and inode.
- *
- * If for some reason an inode gets evicted and read back in again, it will get
- * a new sequence number and will _NOT_ match, even though it is the exact same
- * file.
- *
- * It is important that match_futex() will never have a false-positive, esp.
- * for PI futexes that can mess up the state. The above argues that false-negatives
- * are only possible for malformed programs.
  */
-static u64 get_inode_sequence_number(struct inode *inode)
+static u64 get_object_id(atomic64_t *object_seq)
 {
-	static atomic64_t i_seq;
+	static atomic64_t last_assigned_seq;
 	u64 old;
 
-	/* Does the inode already have a sequence number? */
-	old = atomic64_read(&inode->i_sequence);
+	/* Does the object already have a sequence number? */
+	old = atomic64_read(object_seq);
 	if (likely(old))
 		return old;
 
 	for (;;) {
-		u64 new = atomic64_add_return(1, &i_seq);
+		u64 new = atomic64_add_return(1, &last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
-		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
+		old = atomic64_cmpxchg_relaxed(object_seq, 0, new);
 		if (old)
 			return old;
 		return new;
@@ -528,7 +516,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *
- * [ also see get_inode_sequence_number() ]
+ * [ also see get_object_id() ]
  *
  * For private mappings (or when !@fshared), the key is:
  *
@@ -680,8 +668,8 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -716,7 +704,22 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.i_seq = get_inode_sequence_number(inode);
+		/*
+		 * This relies on the fact that a well formed program will not
+		 * unmap the file while it has a (shared) futex waiting on it.
+		 * This mapping will have a file reference which pins the mount
+		 * and inode.
+		 *
+		 * If for some reason an inode gets evicted and read back in
+		 * again, it will get a new sequence number and will _NOT_ match,
+		 * even though it is the exact same file.
+		 *
+		 * It is important that match_futex() will never have a
+		 * false-positive, esp. for PI futexes that can mess up the state.
+		 * The above argues that false-negatives are only possible for
+		 * malformed programs.
+		 */
+		key->shared.i_seq = get_object_id(&inode->i_sequence);
 		key->shared.pgoff = page_to_pgoff(tail);
 		rcu_read_unlock();
 	}
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0d463859ad32..f2bcfae09fd9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -485,14 +485,16 @@ static int kprobe_queued(struct kprobe *p)
 static struct kprobe *get_optimized_kprobe(unsigned long addr)
 {
 	int i;
-	struct kprobe *p = NULL;
+	struct kprobe *p;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH; i++) {
 		p = get_kprobe((void *)(addr - i));
+		/* A disabled probe can have prepared, but inactive, optinsns. */
+		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
+			continue;
 
-	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (arch_within_optimized_kprobe(op, addr))
 			return p;
@@ -1427,11 +1429,20 @@ static bool __within_kprobe_blacklist(unsigned long addr)
 	/*
 	 * If there exists a kprobe_blacklist, verify and
 	 * fail any probe registration in the prohibited area
+	 * Note: this can return true during transition period where
+	 * (start_addr, end_addr) in the black list is shrinking
+	 * but old entry has not been removed yet. This is acceptable
+	 * because the worst case is that we reject more probes than
+	 * we should.
 	 */
-	list_for_each_entry(ent, &kprobe_blacklist, list) {
-		if (addr >= ent->start_addr && addr < ent->end_addr)
+	rcu_read_lock();
+	list_for_each_entry_rcu(ent, &kprobe_blacklist, list) {
+		if (addr >= ent->start_addr && addr < ent->end_addr) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+	rcu_read_unlock();
 	return false;
 }
 
@@ -2258,7 +2269,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	ent->start_addr = entry;
 	ent->end_addr = entry + size;
 	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
+	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
 
 	return (int)size;
 }
@@ -2287,8 +2298,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
 		if (ent->start_addr < start || ent->start_addr >= end)
 			continue;
-		list_del(&ent->list);
-		kfree(ent);
+		list_del_rcu(&ent->list);
+		kfree_rcu(ent, rcu);
 	}
 }
 
diff --git a/kernel/params.c b/kernel/params.c
index 1233673b42ec..32682334ca7f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -1,18 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Helpers for initial module or kernel cmdline parsing
-   Copyright (C) 2001 Rusty Russell.
-
-*/
-#include <linux/kernel.h>
-#include <linux/string.h>
+/*
+ * Helpers for initial module or kernel cmdline parsing
+ * Copyright (C) 2001 Rusty Russell.
+ */
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
+#include <linux/overflow.h>
 #include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -47,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
@@ -263,22 +265,29 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-	if (strlen(val) > 1024) {
+	char *tmp;
+	size_t len, maxlen = 1024;
+
+	len = strnlen(val, maxlen + 1);
+	if (len == maxlen + 1) {
 		pr_err("%s: string parameter too long\n", kp->name);
 		return -ENOSPC;
 	}
 
-	maybe_kfree_parameter(*(char **)kp->arg);
-
-	/* This is a hack.  We can't kmalloc in early boot, and we
-	 * don't need to; this mangled commandline is preserved. */
+	/*
+	 * This is a hack. We can't kmalloc() in early boot, and we
+	 * don't need to; this mangled commandline is preserved.
+	 */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(strlen(val)+1);
-		if (!*(char **)kp->arg)
+		tmp = kmalloc_parameter(len + 1);
+		if (!tmp)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		memcpy(tmp, val, len + 1);
 	} else
-		*(const char **)kp->arg = val;
+		tmp = (char *)val;
+
+	maybe_kfree_parameter(*(char **)kp->arg);
+	*(char **)kp->arg = tmp;
 
 	return 0;
 }
@@ -310,7 +319,7 @@ int param_set_bool(const char *val, const struct kernel_param *kp)
 	if (!val) val = "1";
 
 	/* One of =[yYnN01] */
-	return strtobool(val, kp->arg);
+	return kstrtobool(val, kp->arg);
 }
 EXPORT_SYMBOL(param_set_bool);
 
@@ -511,7 +520,7 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
 
-	if (strlen(val)+1 > kps->maxlen) {
+	if (strnlen(val, kps->maxlen) == kps->maxlen) {
 		pr_err("%s: string doesn't fit in %u chars.\n",
 		       kp->name, kps->maxlen-1);
 		return -ENOSPC;
@@ -736,8 +745,10 @@ void module_param_sysfs_remove(struct module *mod)
 {
 	if (mod->mkobj.mp) {
 		sysfs_remove_group(&mod->mkobj.kobj, &mod->mkobj.mp->grp);
-		/* We are positive that no one is using any param
-		 * attrs at this point.  Deallocate immediately. */
+		/*
+		 * We are positive that no one is using any param
+		 * attrs at this point. Deallocate immediately.
+		 */
 		free_module_param_attrs(&mod->mkobj);
 	}
 }
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 8e949e40bfe3..9f3d6f4ee173 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -584,7 +584,8 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
 	if (!dead && thread_group_empty(p)) {
 		if (!same_thread_group(p->real_parent, tracer))
 			dead = do_notify_parent(p, p->exit_signal);
-		else if (ignoring_children(tracer->sighand)) {
+		else if (ignoring_children(tracer->sighand) ||
+			 p->signal->autoreap) {
 			__wake_up_parent(p, tracer);
 			dead = true;
 		}
diff --git a/kernel/signal.c b/kernel/signal.c
index 9a63c7bb167a..c4091812ea89 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2121,6 +2121,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
 			sig = 0;
 	}
+	if (!tsk->ptrace && tsk->signal->autoreap) {
+		autoreap = true;
+		sig = 0;
+	}
 	/*
 	 * Send with __send_signal as si_pid and si_uid are in the
 	 * parent's namespaces.
@@ -2970,6 +2974,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	sigset_t retarget;
 	struct task_struct *t;
 
+	/* Nobody dequeues them in a dying group, see get_signal(). */
+	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	sigandsets(&retarget, &tsk->signal->shared_pending.signal, which);
 	if (sigisemptyset(&retarget))
 		return;
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..87892f4c3f29 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -557,33 +557,40 @@ void clockevents_handle_noop(struct clock_event_device *dev)
 {
 }
 
-/**
- * clockevents_exchange_device - release and request clock devices
- * @old:	device to release (can be NULL)
- * @new:	device to request (can be NULL)
- *
- * Called from various tick functions with clockevents_lock held and
- * interrupts disabled.
- */
-void clockevents_exchange_device(struct clock_event_device *old,
-				 struct clock_event_device *new)
+void __clockevents_exchange_device(struct clock_event_device *old,
+				   struct clock_event_device *new)
 {
 	/*
 	 * Caller releases a clock event device. We queue it into the
 	 * released list and do a notify add later.
 	 */
 	if (old) {
-		module_put(old->owner);
 		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
 		list_move(&old->list, &clockevents_released);
 	}
 
 	if (new) {
-		BUG_ON(!clockevent_state_detached(new));
+		WARN_ON(!clockevent_state_detached(new));
 		clockevents_shutdown(new);
 	}
 }
 
+/**
+ * clockevents_exchange_device - release and request clock devices
+ * @old:	device to release (can be NULL)
+ * @new:	device to request (can be NULL)
+ *
+ * Called from various tick functions with clockevents_lock held and
+ * interrupts disabled.
+ */
+void clockevents_exchange_device(struct clock_event_device *old,
+				 struct clock_event_device *new)
+{
+	__clockevents_exchange_device(old, new);
+	if (old)
+		module_put(old->owner);
+}
+
 /**
  * clockevents_suspend - suspend clock devices
  */
@@ -650,7 +657,7 @@ void tick_cleanup_dead_cpu(int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) == 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 13a71a894cc1..5ca420e0f7d3 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -162,23 +162,32 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
  */
 void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
-	struct clock_event_device *cur = tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
 
-	if (tick_set_oneshot_wakeup_device(dev, cpu))
-		return;
+	{
+		guard(raw_spinlock_irqsave)(&tick_broadcast_lock);
 
-	if (!tick_check_broadcast_device(cur, dev))
-		return;
+		if (tick_set_oneshot_wakeup_device(dev, cpu))
+			return;
 
-	if (!try_module_get(dev->owner))
-		return;
+		cur = tick_broadcast_device.evtdev;
+		if (!tick_check_broadcast_device(cur, dev))
+			return;
 
-	clockevents_exchange_device(cur, dev);
+		if (!try_module_get(dev->owner))
+			return;
+
+		__clockevents_exchange_device(cur, dev);
+		if (cur)
+			cur->event_handler = clockevents_handle_noop;
+		WRITE_ONCE(tick_broadcast_device.evtdev, dev);
+		if (!cpumask_empty(tick_broadcast_mask))
+			tick_broadcast_start_periodic(dev);
+	}
+
+	/* Module release must be outside of the lock */
 	if (cur)
-		cur->event_handler = clockevents_handle_noop;
-	tick_broadcast_device.evtdev = dev;
-	if (!cpumask_empty(tick_broadcast_mask))
-		tick_broadcast_start_periodic(dev);
+		module_put(cur->owner);
 
 	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return;
@@ -1205,7 +1214,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1213,7 +1222,7 @@ bool tick_broadcast_oneshot_available(void)
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+	struct clock_event_device *bc = READ_ONCE(tick_broadcast_device.evtdev);
 
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..52e6fec7377d 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -48,6 +48,8 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 }
 
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern void __clockevents_exchange_device(struct clock_event_device *old,
+					  struct clock_event_device *new);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_switch_state(struct clock_event_device *dev,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0e5d6264735c..fdc400663165 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -69,6 +69,8 @@
 #define INIT_OPS_HASH(opsname)	\
 	.func_hash		= &opsname.local_hash,			\
 	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
+/* Used only to synchronize the initialization of ftrace_ops */
+static DEFINE_MUTEX(ops_mutex);
 #else
 #define INIT_OPS_HASH(opsname)
 #endif
@@ -131,10 +133,17 @@ static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
 {
 #ifdef CONFIG_DYNAMIC_FTRACE
-	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
+	unsigned long flags = smp_load_acquire(&ops->flags);
+
+	if (!(flags & FTRACE_OPS_FL_INITIALIZED)) {
+		guard(mutex)(&ops_mutex);
+		/* Could have been initialized before lock taken */
+		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+			return;
 		mutex_init(&ops->local_hash.regex_lock);
 		ops->func_hash = &ops->local_hash;
-		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
+		flags = ops->flags | FTRACE_OPS_FL_INITIALIZED;
+		smp_store_release(&ops->flags, flags);
 	}
 #endif
 }
@@ -3767,7 +3776,8 @@ ftrace_enabled_open(struct inode *inode, struct file *file)
 
 /**
  * ftrace_regex_open - initialize function tracer filter files
- * @ops: The ftrace_ops that hold the hash filters
+ * @tr: The trace_array that holds the ftrace_ops [optional]
+ * @ops: The ftrace_ops that hold the hash filters [optional]
  * @flag: The type of filter to process
  * @inode: The inode, usually passed in to your open routine
  * @file: The file, usually passed in to your open routine
@@ -3780,25 +3790,46 @@ ftrace_enabled_open(struct inode *inode, struct file *file)
  * ftrace_notrace_write() if @flag has FTRACE_ITER_NOTRACE set.
  * tracing_lseek() should be used as the lseek routine, and
  * release must call ftrace_regex_release().
+ *
+ * Note, If @tr is not NULL, its reference has to be taken before
+ *       @ops may be referenced.
+ *       If @ops is NULL and @tr is not, then @tr->ops is used.
+ *       If @tr is NULL and @ops is not then @ops->private is uesd for @tr.
+ *       If both @tr and @ops are NULL, then the &global_ops is
+ *         to be used, and @tr will be the global_ops.private pointer.
+ *
+ * Returns: 0 on success or a negative errno value on failure
  */
 int
-ftrace_regex_open(struct ftrace_ops *ops, int flag,
+ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file)
 {
-	struct ftrace_iterator *iter;
+	struct ftrace_iterator *iter = NULL;
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
-	struct trace_array *tr = ops->private;
-	int ret = -ENOMEM;
-
-	ftrace_ops_init(ops);
+	int ret = -ENODEV;
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	if (!tr) {
+		if (!ops)
+			ops = &global_ops;
+		tr = ops->private;
+	}
+
 	if (tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
+	if (!ops)
+		ops = tr->ops;
+
+	if (WARN_ON_ONCE(!ops))
+		goto out;
+
+	ftrace_ops_init(ops);
+
+	ret = -ENOMEM;
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter)
 		goto out;
@@ -3876,21 +3907,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 static int
 ftrace_filter_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops,
-			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
-			inode, file);
+	return ftrace_regex_open(tr, NULL,
+				 FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
+				 inode, file);
 }
 
 static int
 ftrace_notrace_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
+	return ftrace_regex_open(tr, NULL, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
 
@@ -6169,15 +6198,15 @@ static const struct file_operations ftrace_graph_notrace_fops = {
 };
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent)
 {
 
 	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_filter_fops);
+			  tr, &ftrace_filter_fops);
 
 	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_notrace_fops);
+			  tr, &ftrace_notrace_fops);
 }
 
 /*
@@ -6202,14 +6231,13 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
-
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
 	trace_create_file("enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
-	ftrace_create_filter_files(&global_ops, d_tracer);
+	ftrace_create_filter_files(NULL, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	trace_create_file("set_graph_function", TRACE_MODE_WRITE, d_tracer,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 84f3b0d0bc88..9c43f01fa2c2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -877,15 +877,15 @@ static void rb_wake_up_waiters(struct irq_work *work)
 		/* Only cpu_buffer sets the above flags */
 		struct ring_buffer_per_cpu *cpu_buffer =
 			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+		unsigned long flags;
 
-		/* Called from interrupt context */
-		raw_spin_lock(&cpu_buffer->reader_lock);
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
 
 		/* Waking up all waiters, they will reset the shortest full */
 		cpu_buffer->shortest_full = 0;
-		raw_spin_unlock(&cpu_buffer->reader_lock);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 		wake_up_all(&rbwork->full_waiters);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a632965446b8..4e99f9b5c212 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1093,7 +1093,7 @@ extern void clear_ftrace_function_probes(struct trace_array *tr);
 int register_ftrace_command(struct ftrace_func_command *cmd);
 int unregister_ftrace_command(struct ftrace_func_command *cmd);
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent);
 void ftrace_destroy_filter_files(struct ftrace_ops *ops);
 
@@ -1116,11 +1116,11 @@ static inline void clear_ftrace_function_probes(struct trace_array *tr)
 {
 }
 
+#define ftrace_create_filter_files(tr, parent) do { } while (0)
 /*
  * The ops parameter passed in is usually undefined.
  * This must be a macro.
  */
-#define ftrace_create_filter_files(ops, parent) do { } while (0)
 #define ftrace_destroy_filter_files(ops) do { } while (0)
 #endif /* CONFIG_FUNCTION_TRACER && CONFIG_DYNAMIC_FTRACE */
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 7b3014e10eb6..9a54b848ece4 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -537,6 +537,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 			top--;					/* #12 */
 		}
 	}
+	/* Only the inner loop can complete a non-empty expression. */
+	if (N) {
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
+		goto out_free;
+	}
  out:
 	if (top != op_stack) {
 		/* Too many '(' */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 69a7e83926a2..223b38f9ac0e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -217,7 +217,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 
 	u64 val = operand->fn(operand, elt, buffer, rbe, event);
 
-	return (u64) ilog2(roundup_pow_of_two(val));
+	return order_base_2(val);
 }
 
 static u64 hist_field_bucket(struct hist_field *hist_field,
@@ -294,7 +294,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
-	return (u64)(unsigned long)*addr;				\
+	return (u64)*addr;						\
 }
 
 DEFINE_HIST_FIELD_FN(s64);
@@ -372,7 +372,7 @@ struct field_var {
 };
 
 struct field_var_hist {
-	struct hist_trigger_data	*hist_data;
+	struct trace_event_file		*file;
 	char				*cmd;
 };
 
@@ -665,7 +665,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
 
-	u64 ts = ring_buffer_event_time_stamp(buffer, rbe);
+	u64 ts = tracing_event_time_stamp(buffer, rbe);
 
 	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
 		ts = ns2usecs(ts);
@@ -1800,7 +1800,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -2617,8 +2618,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Save the compatible histogram information */
-	var_hist->hist_data = hist_data;
+	/* Needed to remove the histogram when the target goes away */
+	var_hist->file = file;
 
 	/* Create the new histogram with our variable */
 	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
@@ -2633,20 +2634,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
 	kfree(cmd);
 
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
 	/* If we can't find the variable, something went wrong */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
 	if (IS_ERR_OR_NULL(event_var)) {
-		kfree(var_hist->cmd);
-		kfree(var_hist);
 		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
-	n = target_hist_data->n_field_var_hists;
-	target_hist_data->field_var_hists[n] = var_hist;
-	target_hist_data->n_field_var_hists++;
-
 	return event_var;
 }
 
@@ -2812,6 +2811,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret =  -ENOMEM;
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var->var = var;
 	field_var->val = val;
@@ -3429,7 +3429,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
@@ -5399,7 +5402,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
-		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		file = hist_data->field_var_hists[i]->file;
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
 					      "!hist", "hist", cmd);
@@ -5641,12 +5644,6 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		data->ops = &event_hist_trigger_named_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (hist_data->enable_timestamps) {
 		char *clock = hist_data->attrs->clock;
 
@@ -5659,6 +5656,15 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		tracing_set_filter_buffering(file->tr, true);
 	}
 
+	if (data->ops->init) {
+		ret = data->ops->init(data->ops, data);
+		if (ret < 0) {
+			if (hist_data->enable_timestamps)
+				tracing_set_filter_buffering(file->tr, false);
+			goto out;
+		}
+	}
+
 	if (named_data)
 		destroy_hist_data(hist_data);
 
@@ -5988,6 +5994,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 
 	kfree(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 18b8580971f6..37a9b31e776a 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -90,7 +90,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 	if (!tr->ops)
 		return -EINVAL;
 
-	ftrace_create_filter_files(tr->ops, parent);
+	ftrace_create_filter_files(tr, parent);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..c6b2f622ffa1 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -499,7 +499,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 	struct ftrace_ops *ops = inode->i_private;
 
 	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
+	return ftrace_regex_open(NULL, ops, FTRACE_ITER_FILTER,
 				 inode, file);
 }
 
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 6ed37bc95cb7..b14dbef34499 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -102,7 +102,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, mask, note, offset, len, nr_notes;
 	bool done = false;
 
 	if (!pipe)
@@ -116,8 +116,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
-	if (note >= wqueue->nr_notes)
+	/* Pairs with the smp_store_release() in watch_queue_set_size(). */
+	nr_notes = smp_load_acquire(&wqueue->nr_notes);
+	note = find_first_bit(wqueue->notes_bitmap, nr_notes);
+	if (note >= nr_notes)
 		goto lost;
 
 	page = wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
@@ -305,7 +307,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-	wqueue->nr_notes = nr_notes;
+	/* Pairs with the smp_load_acquire() in post_one_notification(). */
+	smp_store_release(&wqueue->nr_notes, nr_notes);
 	return 0;
 
 error_p:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 42d689df822e..99b4d84f22b3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1394,7 +1394,7 @@ static bool is_chained_work(struct workqueue_struct *wq)
 	 * Return %true iff I'm a worker executing a work item on @wq.  If
 	 * I'm @worker, it's safe to dereference it without locking.
 	 */
-	return worker && worker->current_pwq->wq == wq;
+	return worker && worker->current_pwq && worker->current_pwq->wq == wq;
 }
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5dad4b6ec6d6..cd44744724d0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1642,6 +1642,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+
+			if (pmd_present(orig_pmd) && pmd_dirty(orig_pmd))
+				set_page_dirty(page);
 		}
 
 		spin_unlock(ptl);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e0908e491065..947610e37a33 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1144,8 +1144,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 
 static struct page *dequeue_huge_page_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct page *page = NULL;
 	struct mempolicy *mpol;
@@ -1162,10 +1161,6 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 			h->free_huge_pages - h->resv_huge_pages == 0)
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1179,7 +1174,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (!page)
 		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (page && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
 	}
@@ -2775,17 +2770,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			vma_end_reservation(h, vma, addr);
 			return ERR_PTR(-ENOSPC);
 		}
-
-		/*
-		 * Even though there was no reservation in the region/reserve
-		 * map, there could be reservations associated with the
-		 * subpool that can be used.  This would be indicated if the
-		 * return value of hugepage_subpool_get_pages() is zero.
-		 * However, if avoid_reserve is specified we still avoid even
-		 * the subpool reservations.
-		 */
-		if (avoid_reserve)
-			gbl_chg = 1;
 	}
 
 	/* If this allocation is not consuming a reservation, charge it now.
@@ -2808,7 +2792,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	page = dequeue_huge_page_vma(h, vma, addr, gbl_chg);
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
diff --git a/mm/mmap.c b/mm/mmap.c
index 273e06dad3c6..53fa4f5167dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1288,6 +1288,13 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
  * acceptable for merging, so we can do all of this optimistically. But
  * we do that READ_ONCE() to make sure that we never re-load the pointer.
  *
+ * The READ_ONCE() establishes an address dependency between anon_vma and
+ * any access to its fields, which pairs with the assignment to
+ * vma->anon_vma performed with release semantics in __anon_vma_prepare().
+ *
+ * This is especially important as anon_vma's are SLAB_TYPESAFE_BY_RCU so
+ * accessing an uninitialised anon_vma's fields may result in a UAF.
+ *
  * IOW: that the "list_is_singular()" test on the anon_vma_chain only
  * matters for the 'stable anon_vma' case (ie the thing we want to avoid
  * is to return an anon_vma that is "complex" due to having gone through
@@ -1300,6 +1307,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_area_struct *a, struct vm_area_struct *b)
 {
 	if (anon_vma_compatible(a, b)) {
+		/* Paired with a memory barrier in __anon_vma_prepare(). */
 		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
 
 		if (anon_vma && list_is_singular(&old->anon_vma_chain))
@@ -3273,7 +3281,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -3281,6 +3289,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -3289,13 +3298,27 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
+		can_self_merge = true;
 	}
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+
+	/*
+	 * If the original VMA is kept (MREMAP_DONTUNMAP), the source and
+	 * destination VMA must be treated distinctly.
+	 *
+	 * A merge violates this, so in this case disallow a self-merge. A
+	 * self-merge can only occur if the new range is immediately adjacent to
+	 * the source VMA, so simply do not attempt to merge in that case.
+	 */
+	if (can_self_merge && keep_source &&
+	    (addr == vma->vm_end || vma->vm_start == addr + len))
+		new_vma = NULL;
+	else
+		new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+				    vma->anon_vma, vma->vm_file, pgoff,
+				    vma_policy(vma), vma->vm_userfaultfd_ctx);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mremap.c b/mm/mremap.c
index 3a3cf4cc2c63..5d8b8309ae2a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -578,6 +578,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	int split = 0;
 	int err = 0;
 	bool need_rmap_locks;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -587,9 +589,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
@@ -607,6 +609,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if ((flags & MREMAP_DONTUNMAP) && (vma->vm_flags & VM_LOCKED)) {
+		if (split_before)
+			err = split_vma(mm, vma, old_addr, 1);
+		if (!err && split_after)
+			err = split_vma(mm, vma, old_addr + old_len, 0);
+		if (err)
+			return err;
+	}
+
 	if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT)) {
 		if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
 			return -ENOMEM;
@@ -614,7 +629,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT))
 			vm_unacct_memory(new_len >> PAGE_SHIFT);
@@ -671,6 +686,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_moved(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
@@ -678,9 +696,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * anon_vma links of the old vma is no longer needed after its page
 		 * table has been moved.
 		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
-			vma->vm_end == (old_addr + old_len))
+		if (vma->vm_start == old_addr &&
+			vma->vm_end == (old_addr + old_len)) {
+			const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+
 			unlink_anon_vmas(vma);
+			/*
+			 * The VMA is now unfaulted and it is an invariant that
+			 * unfaulted anonymous VMAs have page offset equal to
+			 * vma->vm_start >> PAGE_SHIFT.
+			 */
+			if (vma_is_anonymous(vma) && !vma->vm_file)
+				vma->vm_pgoff = pgoff_unfaulted;
+		}
 
 		/* Because we won't unmap we don't need to touch locked_vm */
 		return new_addr;
diff --git a/mm/rmap.c b/mm/rmap.c
index c103e01d2232..24da8320a601 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -207,7 +207,11 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	/* page_table_lock to protect against threads */
 	spin_lock(&mm->page_table_lock);
 	if (likely(!vma->anon_vma)) {
-		vma->anon_vma = anon_vma;
+		/*
+		 * Make anon_vma fields visible before anon_vma is published.
+		 * Paired with an address dependency in reusable_anon_vma().
+		 */
+		smp_store_release(&vma->anon_vma, anon_vma);
 		anon_vma_chain_link(vma, avc, anon_vma);
 		anon_vma->num_active_vmas++;
 		allocated = NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 502f51b86fa3..d87385ed84e1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -134,6 +134,8 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
+	int ret = 0;
+
 	if (max_page_shift < PMD_SHIFT)
 		return 0;
 
@@ -149,10 +151,23 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
 		return 0;
 
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+	if (!pmd_present(*pmd))
+		return pmd_set_huge(pmd, phys_addr, prot);
+
+	/*
+	 * Acquire the mmap read lock to exclude ptdump, which walks
+	 * kernel page tables it does not own under the mmap write lock.
+	 *
+	 * Concurrent read lock holders are safe: each exclusively owns
+	 * the range it operates on and cannot reach this page table.
+	 */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (pmd_free_pte_page(pmd, addr))
+		ret = pmd_set_huge(pmd, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return pmd_set_huge(pmd, phys_addr, prot);
+	return ret;
 }
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
@@ -184,6 +199,8 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
+	int ret = 0;
+
 	if (max_page_shift < PUD_SHIFT)
 		return 0;
 
@@ -199,10 +216,17 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+	if (!pud_present(*pud))
+		return pud_set_huge(pud, phys_addr, prot);
+
+	/* See comment in vmap_try_huge_pmd(). */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (pud_free_pmd_page(pud, addr))
+		ret = pud_set_huge(pud, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return pud_set_huge(pud, phys_addr, prot);
+	return ret;
 }
 
 static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
@@ -235,6 +259,8 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
+	int ret = 0;
+
 	if (max_page_shift < P4D_SHIFT)
 		return 0;
 
@@ -250,10 +276,17 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+	if (!p4d_present(*p4d))
+		return p4d_set_huge(p4d, phys_addr, prot);
+
+	/* See comment in vmap_try_huge_pmd(). */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (p4d_free_pud_page(p4d, addr))
+		ret = p4d_set_huge(p4d, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return p4d_set_huge(p4d, phys_addr, prot);
+	return ret;
 }
 
 static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a587472c5f12..c31919623d1b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3949,8 +3949,10 @@ int hci_register_dev(struct hci_dev *hdev)
 		return id;
 
 	error = dev_set_name(&hdev->dev, "hci%u", id);
-	if (error)
+	if (error) {
+		ida_free(&hci_index_ida, id);
 		return error;
+	}
 
 	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
@@ -4792,6 +4794,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 	__check_timeout(hdev, cnt, ACL_LINK);
 
+	hci_dev_lock(hdev);
+
 	while (hdev->acl_cnt &&
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
@@ -4823,6 +4827,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 	if (cnt != hdev->acl_cnt)
 		hci_prio_recalculate(hdev, ACL_LINK);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_sched_acl_blk(struct hci_dev *hdev)
@@ -4917,6 +4923,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 	__check_timeout(hdev, *cnt, LE_LINK);
 
+	hci_dev_lock(hdev);
+
 	tmp = *cnt;
 	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
@@ -4945,6 +4953,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_tx_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2f9b2165ec95..b4ff99a4e531 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -366,7 +366,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
-		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
+		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %lu\n",
 			   &data->bdaddr,
 			   data->pscan_rep_mode, data->pscan_period_mode,
 			   data->pscan_mode, data->dev_class[2],
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index a317cacd9d9e..8a819aed6a75 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1157,8 +1157,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 	 */
 	hdev = hci_pi(sk)->hdev;
 	if (hdev && hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		write_lock(&hci_sk_list.lock);
 		hci_pi(sk)->hdev = NULL;
 		sk->sk_state = BT_OPEN;
+		write_unlock(&hci_sk_list.lock);
 		hci_dev_put(hdev);
 	}
 	hdev = NULL;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 435c03d20ac1..b127882cc02f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -598,6 +598,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
 
+	/* Caller must ensure l2cap_chan is linked to l2cap_conn only once */
+	if (WARN_ON_ONCE(chan->conn || test_bit(FLAG_DEL, &chan->flags)))
+		return;
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = l2cap_conn_get(conn);
@@ -8355,7 +8359,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
-	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+	if ((cid && __l2cap_get_chan_by_dcid(conn, cid)) || chan->conn ||
+	    test_bit(FLAG_DEL, &chan->flags)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
 		goto chan_unlock;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index bef6a948d7d5..0cc0508298b9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -109,6 +109,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			return -EINVAL;
 	}
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -174,6 +175,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
@@ -435,11 +437,26 @@ static int l2cap_get_mode(struct l2cap_chan *chan)
 	return -EINVAL;
 }
 
+static struct l2cap_conn *l2cap_chan_conn(struct l2cap_chan *chan)
+{
+	lockdep_assert_held(&chan->lock);
+
+	/* l2cap_conn_del() sets FLAG_DEL while holding chan->lock before
+	 * conn->hcon is deleted. If not set and conn is non-NULL, conn->hcon
+	 * remains alive during this chan->lock critical section.
+	 */
+	if (test_bit(FLAG_DEL, &chan->flags))
+		return NULL;
+
+	return chan->conn;
+}
+
 static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 				     char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn;
 	struct l2cap_options opts;
 	struct l2cap_conninfo cinfo;
 	int err = 0;
@@ -451,6 +468,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -536,9 +554,15 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		conn = l2cap_chan_conn(chan);
+		if (!conn) {
+			err = -ENOTCONN;
+			break;
+		}
+
 		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = chan->conn->hcon->handle;
-		memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
+		cinfo.hci_handle = conn->hcon->handle;
+		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
@@ -552,6 +576,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+
 	return err;
 }
 
@@ -560,6 +586,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn;
 	struct bt_security sec;
 	struct bt_power pwr;
 	u32 phys;
@@ -576,6 +603,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -587,12 +615,14 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		conn = l2cap_chan_conn(chan);
+
 		memset(&sec, 0, sizeof(sec));
-		if (chan->conn) {
-			sec.level = chan->conn->hcon->sec_level;
+		if (conn) {
+			sec.level = conn->hcon->sec_level;
 
 			if (sk->sk_state == BT_CONNECTED)
-				sec.key_size = chan->conn->hcon->enc_key_size;
+				sec.key_size = conn->hcon->enc_key_size;
 		} else {
 			sec.level = chan->sec_level;
 		}
@@ -668,12 +698,14 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state != BT_CONNECTED) {
+		conn = l2cap_chan_conn(chan);
+
+		if (sk->sk_state != BT_CONNECTED || !conn) {
 			err = -ENOTCONN;
 			break;
 		}
 
-		phys = hci_conn_get_phy(chan->conn->hcon);
+		phys = hci_conn_get_phy(conn->hcon);
 
 		if (put_user(phys, (u32 __user *) optval))
 			err = -EFAULT;
@@ -706,6 +738,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
@@ -736,6 +769,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 
 	BT_DBG("sk %p", sk);
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -839,6 +873,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
@@ -902,6 +937,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	switch (optname) {
@@ -929,11 +965,10 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		chan->sec_level = sec.level;
 
-		if (!chan->conn)
+		conn = l2cap_chan_conn(chan);
+		if (!conn)
 			break;
 
-		conn = chan->conn;
-
 		/* change security for LE channels */
 		if (chan->scid == L2CAP_CID_ATT) {
 			if (smp_conn_security(conn->hcon, sec.level)) {
@@ -990,7 +1025,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (opt == BT_FLUSHABLE_OFF) {
-			conn = chan->conn;
+			conn = l2cap_chan_conn(chan);
+
 			/* proceed further only when we have l2cap_conn and
 			   No Flush support in the LM */
 			if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
@@ -1127,6 +1163,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	}
 
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5b67247587ba..76d7dd777225 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -459,13 +459,10 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY &&
-		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 6324e03ff0d0..1e21e1e38543 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -63,10 +63,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
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
 
@@ -364,28 +363,17 @@ static int rfcomm_check_channel(u8 channel)
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
@@ -420,14 +408,84 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
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
@@ -507,8 +565,14 @@ int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
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
@@ -756,12 +820,12 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
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
@@ -791,24 +855,16 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
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
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index df7e9694d5da..0ff5fb555318 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -50,8 +50,11 @@ static void rfcomm_sock_kill(struct sock *sk);
 static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 {
 	struct sock *sk = d->owner;
-	if (!sk)
+
+	if (!sk) {
+		kfree_skb(skb);
 		return;
+	}
 
 	atomic_add(skb->len, &sk->sk_rmem_alloc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 6962fa62bd12..21b87794b1ea 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -132,7 +132,7 @@ static void rfcomm_dev_shutdown(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 
-	if (dev->tty_dev->parent)
+	if (dev->tty_dev && dev->tty_dev->parent)
 		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
 
 	/* close the dlc */
@@ -439,7 +439,6 @@ static int __rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
-	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -465,13 +464,9 @@ static int __rfcomm_release_dev(void __user *arg)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
-	tty = tty_port_tty_get(&dev->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&dev->port);
 
-	if (!test_bit(RFCOMM_TTY_OWNED, &dev->status))
+	if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
 
 	tty_port_put(&dev->port);
@@ -736,10 +731,9 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	 * when the last process closes the tty. The behaviour is expected by
 	 * userspace.
 	 */
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-		set_bit(RFCOMM_TTY_OWNED, &dev->status);
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags) &&
+	    !test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
-	}
 
 	return 0;
 }
diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index a89aec831416..b9a3546fb4b4 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -367,7 +367,7 @@ static u32 ccm_tlv_extract(struct sk_buff *skb, u32 index,
 }
 
 /* note: already called with rcu_read_lock */
-static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 {
 	u32 mdlevel, interval, size, index, max;
 	const struct br_cfm_common_hdr *hdr;
@@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 	return 1;
 }
 
-static struct br_frame_type cfm_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_CFM),
-	.frame_handler = br_cfm_frame_rx,
-};
-
 int br_cfm_mep_create(struct net_bridge *br,
 		      const u32 instance,
 		      struct br_cfm_mep_create *const create,
@@ -559,7 +554,7 @@ int br_cfm_mep_create(struct net_bridge *br,
 	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
 
 	if (hlist_empty(&br->mep_list))
-		br_add_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, true);
 
 	hlist_add_tail_rcu(&mep->head, &br->mep_list);
 
@@ -588,7 +583,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 	kfree_rcu(mep, rcu);
 
 	if (hlist_empty(&br->mep_list))
-		br_del_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, false);
 }
 
 int br_cfm_mep_delete(struct net_bridge *br,
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 4886be8970a8..0bfdfe2e7ac3 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -506,7 +506,6 @@ void br_dev_setup(struct net_device *dev)
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
 	INIT_HLIST_HEAD(&br->fdb_list);
-	INIT_HLIST_HEAD(&br->frame_type_list);
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	INIT_HLIST_HEAD(&br->mrp_list);
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index a66df464f856..8ef1001764f4 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -268,17 +268,25 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	return RX_HANDLER_CONSUMED;
 }
 
+#define BR_CFM_MRP_OPTS \
+	((IS_ENABLED(CONFIG_BRIDGE_CFM) ? BIT(BROPT_CFM_ENABLED) : 0UL) | \
+	 (IS_ENABLED(CONFIG_BRIDGE_MRP) ? BIT(BROPT_MRP_ENABLED) : 0UL))
+
 /* Return 0 if the frame was not processed otherwise 1
  * note: already called with rcu_read_lock
  */
 static int br_process_frame_type(struct net_bridge_port *p,
 				 struct sk_buff *skb)
 {
-	struct br_frame_type *tmp;
+	struct net_bridge *br = p->br;
+
+	if (skb->protocol == htons(ETH_P_CFM) &&
+	    br_opt_get(br, BROPT_CFM_ENABLED))
+		return br_cfm_frame_rx(p, skb);
 
-	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
-		if (unlikely(tmp->type == skb->protocol))
-			return tmp->frame_handler(p, skb);
+	if (skb->protocol == htons(ETH_P_MRP) &&
+	    br_opt_get(br, BROPT_MRP_ENABLED))
+		return br_mrp_process(p, skb);
 
 	return 0;
 }
@@ -371,7 +379,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	if (unlikely(br_process_frame_type(p, skb)))
+	if (unlikely((READ_ONCE(p->br->options) & BR_CFM_MRP_OPTS) &&
+		     br_process_frame_type(p, skb)))
 		return RX_HANDLER_PASS;
 
 forward:
@@ -408,19 +417,3 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 
 	return br_handle_frame;
 }
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
-}
-
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	struct br_frame_type *tmp;
-
-	hlist_for_each_entry(tmp, &br->frame_type_list, list)
-		if (ft == tmp) {
-			hlist_del_rcu(&ft->list);
-			return;
-		}
-}
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index a837ff7d6f36..79d6bc62179e 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -6,13 +6,6 @@
 static const u8 mrp_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 };
 static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
 
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
-
-static struct br_frame_type mrp_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_MRP),
-	.frame_handler = br_mrp_process,
-};
-
 static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
 				struct net_bridge_port *s_port,
 				struct net_bridge_port *port)
@@ -486,7 +479,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	kfree_rcu(mrp, rcu);
 
 	if (hlist_empty(&br->mrp_list))
-		br_del_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, false);
 }
 
 /* Adds a new MRP instance.
@@ -536,7 +529,7 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	rcu_assign_pointer(mrp->s_port, p);
 
 	if (hlist_empty(&br->mrp_list))
-		br_add_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, true);
 
 	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
 	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
@@ -1241,7 +1234,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
  * normal forwarding.
  * note: already called with rcu_read_lock
  */
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	/* If there is no MRP instance do normal forwarding */
 	if (likely(!(p->flags & BR_MRP_AWARE)))
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a91c133ce296..916438a7b217 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -80,6 +80,10 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 			 bool blocked);
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports);
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
 
 static int br_mc_disabled_update(struct net_device *dev, bool value,
@@ -436,7 +440,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(sgmp, p, pp);
+			__br_multicast_del_pg(sgmp, p, pp, false);
 		else
 			pp = &p->next;
 	}
@@ -675,16 +679,21 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(pg, rcu);
 }
 
-void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
-			 struct net_bridge_port_group *pg,
-			 struct net_bridge_port_group __rcu **pp)
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -692,7 +701,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		if (sg_del_exclude_ports)
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
@@ -703,6 +713,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 		mod_timer(&mp->timer, jiffies);
 }
 
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp)
+{
+	__br_multicast_del_pg(mp, pg, pp, true);
+}
+
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg)
 {
@@ -710,6 +727,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;
@@ -1859,10 +1883,19 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 {
+	struct net_bridge *br = pmctx->port->br;
+	bool del = false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	del_timer_sync(&pmctx->ip6_mc_router_timer);
 #endif
 	del_timer_sync(&pmctx->ip4_mc_router_timer);
+
+	spin_lock_bh(&br->multicast_lock);
+	del |= br_ip6_multicast_rport_del(pmctx);
+	del |= br_ip4_multicast_rport_del(pmctx);
+	br_multicast_rport_del_notify(pmctx, del);
+	spin_unlock_bh(&br->multicast_lock);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 62fdafbcc7e7..4db48270f3d7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -447,12 +447,13 @@ enum net_bridge_opts {
 	BROPT_NO_LL_LEARN,
 	BROPT_VLAN_BRIDGE_BINDING,
 	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
+	BROPT_CFM_ENABLED,
+	BROPT_MRP_ENABLED,
 };
 
 struct net_bridge {
 	spinlock_t			lock;
 	spinlock_t			hash_lock;
-	struct hlist_head		frame_type_list;
 	struct net_device		*dev;
 	unsigned long			options;
 	/* These fields are accessed on each packet */
@@ -841,16 +842,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
 
-struct br_frame_type {
-	__be16			type;
-	int			(*frame_handler)(struct net_bridge_port *port,
-						 struct sk_buff *skb);
-	struct hlist_node	list;
-};
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
-
 static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->rx_handler) == br_get_rx_handler(dev);
@@ -1854,6 +1845,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 bool br_mrp_enabled(struct net_bridge *br);
 void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 #else
 static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 			       struct nlattr *attr, int cmd,
@@ -1877,6 +1869,11 @@ static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 	return 0;
 }
 
+static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+{
+	return 0;
+}
+
 #endif
 
 /* br_cfm.c */
@@ -1885,6 +1882,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 bool br_cfm_created(struct net_bridge *br);
 void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
@@ -1909,6 +1907,12 @@ static inline void br_cfm_port_del(struct net_bridge *br,
 {
 }
 
+static inline int br_cfm_frame_rx(struct net_bridge_port *port,
+				  struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
 {
 	return -EOPNOTSUPP;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 95b7cc548675..cd31c4e014d1 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -644,10 +644,8 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 void can_set_skb_uid(struct sk_buff *skb)
 {
 	/* create non-zero unique skb identifier together with *skb */
-	while (!(skb->hash))
-		skb->hash = atomic_inc_return(&skbcounter);
-
-	skb->sw_hash = 1;
+	while (!(can_skb_prv(skb)->skbcnt))
+		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
 }
 EXPORT_SYMBOL(can_set_skb_uid);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 235156223394..2cf63940f6a9 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -338,6 +338,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
@@ -1576,6 +1577,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1037d2c2e61a..46b71e2bded2 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -287,6 +287,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
@@ -848,6 +849,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
@@ -876,7 +878,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	WRITE_ONCE(so->cfecho, skb->hash);
+	WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
@@ -939,7 +941,7 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (READ_ONCE(so->cfecho) != skb->hash)
+	if (READ_ONCE(so->cfecho) != can_skb_prv(skb)->skbcnt)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
@@ -1161,6 +1163,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	/* set uid in tx skb to identify CF echo frames */
 	can_set_skb_uid(skb);
@@ -1202,7 +1205,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		WRITE_ONCE(so->cfecho, skb->hash);
+		WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 	} else {
 		/* send first frame */
 
@@ -1219,7 +1222,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			WRITE_ONCE(so->cfecho, skb->hash);
+			WRITE_ONCE(so->cfecho, can_skb_prv(skb)->skbcnt);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index c088f1d8150f..585de1dad6f4 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -895,6 +895,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 74638cf04172..55bbcf73c873 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -612,6 +612,7 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
@@ -1550,6 +1551,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
diff --git a/net/can/raw.c b/net/can/raw.c
index ffbb622f8842..fccc2904bb18 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,8 +74,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
+	u32 skbcnt;
 	const struct sk_buff *skb;
-	u32 hash;
 	unsigned int join_rx_count;
 };
 
@@ -136,7 +136,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
+	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
 		if (ro->join_filters) {
 			this_cpu_inc(ro->uniq->join_rx_count);
 			/* drop frame until all enabled filters matched */
@@ -147,7 +147,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
+		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
@@ -829,6 +829,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index db5677fbf81d..d1b975818bc9 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -895,6 +895,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 	result = bpf_prog_run_pin_on_cpu(prog, ctx);
 
+	/* bpf_flow_keys offsets are u16: do not let @hlen be truncated. */
+	hlen = min_t(int, hlen, U16_MAX);
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
 				   flow_keys->nhoff, hlen);
@@ -943,6 +945,7 @@ bool __skb_flow_dissect(const struct net *net,
 	int mpls_lse = 0;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
+	u32 thoff;
 	bool ret;
 
 	if (!data) {
@@ -1500,7 +1503,13 @@ bool __skb_flow_dissect(const struct net *net,
 	ret = true;
 
 out:
-	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
+	thoff = min_t(u32, nhoff, skb ? skb->len : hlen);
+	if (unlikely(thoff > U16_MAX)) {
+		/* Cannot be represented in key_control->thoff. */
+		thoff = U16_MAX;
+		ret = false;
+	}
+	key_control->thoff = thoff;
 	key_basic->n_proto = proto;
 	key_basic->ip_proto = ip_proto;
 
@@ -1685,7 +1694,8 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
 
 /**
- * __skb_get_hash: calculate a flow hash
+ * __skb_get_hash_net: calculate a flow hash
+ * @net: associated network namespace, derived from @skb if NULL
  * @skb: sk_buff to calculate flow hash from
  *
  * This function calculates a flow hash based on src/dst addresses
@@ -1693,18 +1703,24 @@ EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
  * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
  * if hash is a canonical 4-tuple hash over transport ports.
  */
-void __skb_get_hash(struct sk_buff *skb)
+void __skb_get_hash_net(const struct net *net, struct sk_buff *skb)
 {
 	struct flow_keys keys;
 	u32 hash;
 
+	memset(&keys, 0, sizeof(keys));
+
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   &keys, NULL, 0, 0, 0,
+			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+
 	__flow_hash_secret_init();
 
-	hash = ___skb_get_hash(skb, &keys, &hashrnd);
+	hash = __flow_hash_from_keys(&keys, &hashrnd);
 
 	__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
 }
-EXPORT_SYMBOL(__skb_get_hash);
+EXPORT_SYMBOL(__skb_get_hash_net);
 
 __u32 skb_get_hash_perturb(const struct sk_buff *skb,
 			   const siphash_key_t *perturb)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b3047197a5e8..c0102e518da6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -594,7 +594,8 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 		    size > max_size))
 		return NULL;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 __alignof__(struct skb_shared_info)));
 	*offset = pool->frag_offset;
 
 	if (page && *offset + size > max_size) {
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b40b45331a81..68bc9f06f0a3 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -45,10 +45,8 @@ bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 
 	rcu_read_lock();
 	sn = rcu_dereference(hsr->self_node);
-	if (!sn) {
-		WARN_ONCE(1, "HSR: No self node\n");
+	if (!sn)
 		goto out;
-	}
 
 	if (ether_addr_equal(addr, sn->macaddress_A) ||
 	    ether_addr_equal(addr, sn->macaddress_B))
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ccc59b4ca019..bf480844d23b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -512,6 +512,9 @@ size_t fib_nlmsg_size(struct fib_info *fi)
 			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
 			size_t nhsize;
 
+			if (!nhc)
+				break;
+
 			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
 
 			if (nhs != 1)
@@ -852,7 +855,7 @@ static void fib_rebalance(struct fib_info *fi)
 	change_nexthops(fi) {
 		int upper_bound;
 
-		if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
+		if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
 			upper_bound = -1;
 		} else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
 			   nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 03dac903d96b..3657e61defd4 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1079,8 +1079,6 @@ void fib_alias_hw_flags_set(struct net *net, const struct fib_rt_info *fri)
 
 	err = fib_dump_info(skb, 0, 0, RTM_NEWROUTE, fri, 0);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in fib_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 816d8aad5a68..eae75cd12085 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -665,11 +665,40 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 
 #ifdef IPCONFIG_DHCP
 
+static bool __init
+ic_dhcp_add_option(u8 **options, const u8 *end, u8 type, const void *value,
+		   int len)
+{
+	u8 *e = *options;
+
+	/* leave room for the option header and the END marker */
+	if (len > U8_MAX || end - e < len + 3)
+		return false;
+
+	*e++ = type;
+	*e++ = len;
+	memcpy(e, value, len);
+	*options = e + len;
+
+	return true;
+}
+
 static void __init
 ic_dhcp_init_options(u8 *options, struct ic_device *d)
 {
-	u8 mt = ((ic_servaddr == NONE)
-		 ? DHCPDISCOVER : DHCPREQUEST);
+	static const u8 ic_req_params[] = {
+		1,	/* Subnet mask */
+		3,	/* Default gateway */
+		6,	/* DNS server */
+		12,	/* Host name */
+		15,	/* Domain name */
+		17,	/* Boot path */
+		26,	/* MTU */
+		40,	/* NIS domain name */
+		42,	/* NTP servers */
+	};
+	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
+	u8 *end = options + sizeof(((struct bootp_pkt *)0)->exten);
 	u8 *e = options;
 	int len;
 
@@ -694,52 +723,25 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		e += 4;
 	}
 
-	/* always? */
-	{
-		static const u8 ic_req_params[] = {
-			1,	/* Subnet mask */
-			3,	/* Default gateway */
-			6,	/* DNS server */
-			12,	/* Host name */
-			15,	/* Domain name */
-			17,	/* Boot path */
-			26,	/* MTU */
-			40,	/* NIS domain name */
-			42,	/* NTP servers */
-		};
-
-		*e++ = 55;	/* Parameter request list */
-		*e++ = sizeof(ic_req_params);
-		memcpy(e, ic_req_params, sizeof(ic_req_params));
-		e += sizeof(ic_req_params);
-
-		if (ic_host_name_set) {
-			*e++ = 12;	/* host-name */
-			len = strlen(utsname()->nodename);
-			*e++ = len;
-			memcpy(e, utsname()->nodename, len);
-			e += len;
-		}
-		if (*vendor_class_identifier) {
+	*e++ = 55;	/* Parameter request list */
+	*e++ = sizeof(ic_req_params);
+	memcpy(e, ic_req_params, sizeof(ic_req_params));
+	e += sizeof(ic_req_params);
+
+	if (ic_host_name_set) {
+		len = strlen(utsname()->nodename);
+		ic_dhcp_add_option(&e, end, 12, utsname()->nodename, len);
+	}
+	if (*vendor_class_identifier) {
+		len = strlen(vendor_class_identifier);
+		if (ic_dhcp_add_option(&e, end, 60, vendor_class_identifier, len))
 			pr_info("DHCP: sending class identifier \"%s\"\n",
 				vendor_class_identifier);
-			*e++ = 60;	/* Class-identifier */
-			len = strlen(vendor_class_identifier);
-			*e++ = len;
-			memcpy(e, vendor_class_identifier, len);
-			e += len;
-		}
-		len = strlen(dhcp_client_identifier + 1);
-		/* the minimum length of identifier is 2, include 1 byte type,
-		 * and can not be larger than the length of options
-		 */
-		if (len >= 1 && len < 312 - (e - options) - 1) {
-			*e++ = 61;
-			*e++ = len + 1;
-			memcpy(e, dhcp_client_identifier, len + 1);
-			e += len + 1;
-		}
 	}
+	len = strlen(dhcp_client_identifier + 1);
+	/* the minimum length of identifier is 2, include 1 byte type */
+	if (len >= 1)
+		ic_dhcp_add_option(&e, end, 61, dhcp_client_identifier, len + 1);
 
 	*e++ = 255;	/* End of the list */
 }
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 5e582eab1ea1..d5ae2df481a4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3115,7 +3115,8 @@ int __init ip_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip_mrt_cache",
 				       sizeof(struct mfc_cache),
-				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				       SLAB_ACCOUNT,
 				       NULL);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 8b5b6f196cdc..fb9796e21074 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -38,7 +38,7 @@ mr_table_alloc(struct net *net, u32 id,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL);
+	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL_ACCOUNT);
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5b277e12f398..d504d8cdd030 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1094,6 +1094,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 
 			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
 				nhc = fib_info_nhc(res.fi, nhsel);
+				if (!nhc)
+					break;
 				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 						      jiffies + net->ipv4.ip_rt_mtu_expires);
 			}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 280b7a3791ea..5e1c3ad6d1c5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4053,9 +4053,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		if (get_user(len, optlen))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (put_user(len, optlen))
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index d6db7c25649f..ef7a8d810265 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -201,7 +201,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	if (ext & (1 << (INET_DIAG_DCTCPINFO - 1)) ||
 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
 		memset(&info->dctcp, 0, sizeof(info->dctcp));
-		if (inet_csk(sk)->icsk_ca_ops != &dctcp_reno) {
+		if (READ_ONCE(inet_csk(sk)->icsk_ca_ops) != &dctcp_reno) {
 			info->dctcp.dctcp_enabled = 1;
 			info->dctcp.dctcp_ce_state = (u16) ca->ce_state;
 			info->dctcp.dctcp_alpha = ca->dctcp_alpha;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b746b62b854a..4a481dd4579b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4017,6 +4017,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 old_ack:
+	/* An old ACK can carry new data. Update TS.Recent before SACK
+	 * processing can trigger a retransmission.
+	 */
+	if (flag & FLAG_UPDATE_TS_RECENT)
+		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
+
 	/* If data was SACKed, tag it and see if we should send more data.
 	 * If data was DSACKed, see if we can undo a cwnd reduction.
 	 */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3ebd5765fb9f..65780cf993ea 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -821,6 +821,15 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+
 	return __udp4_lib_err(skb, info, &udp_table);
 }
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index fb766066bcb0..fc1b27cd7554 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -917,7 +917,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	struct net_device_stats *stats;
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1050,10 +1049,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	/* Push GRE header. */
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
-
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab745cda1179..6db5f2501736 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -257,33 +257,34 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct net *net = sock_net(sk);
 	unsigned int head_room;
+	struct net_device *dev;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
-	int hlimit = -1;
+	int ret, hlimit = -1;
 	u32 mtu;
 
+	rcu_read_lock();
+
+	dev = dst_dev_rcu(dst);
 	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive while we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
-			return -ENOBUFS;
+			ret = -ENOBUFS;
+			goto unlock;
 		}
-		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -331,17 +332,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * skb to its handler for processing
 		 */
 		skb = l3mdev_ip6_out((struct sock *)sk, skb);
-		if (unlikely(!skb))
-			return 0;
+		if (unlikely(!skb)) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* hooks should never assume socket lock is held.
 		 * we promote our socket to non const
 		 */
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dev,
-			       dst_output);
+		ret = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			      net, (struct sock *)sk, skb, NULL, dev,
+			      dst_output);
+		goto unlock;
 	}
 
+	ret = -EMSGSIZE;
 	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
@@ -350,7 +355,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 909a2bc2a020..a793dcd24813 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1357,7 +1357,7 @@ int __init ip6_mr_init(void)
 
 	mrt_cachep = kmem_cache_create("ip6_mrt_cache",
 				       sizeof(struct mfc6_cache),
-				       0, SLAB_HWCACHE_ALIGN,
+				       0, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 				       NULL);
 	if (!mrt_cachep)
 		return -ENOMEM;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6e3e20eae124..c9dc099c9023 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6270,8 +6270,6 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	err = rt6_fill_node(net, skb, f6i, NULL, NULL, NULL, 0, RTM_NEWROUTE, 0,
 			    0, 0);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3e4dd2141613..2820e8a8dfee 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -116,7 +116,7 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	u32 hash;
 
 	if (do_flowlabel > 0) {
-		hash = skb_get_hash(skb);
+		hash = skb_get_hash_net(net, skb);
 		hash = rol32(hash, 16);
 		flowlabel = (__force __be32)hash & IPV6_FLOWLABEL_MASK;
 	} else if (!do_flowlabel && skb->protocol == htons(ETH_P_IPV6)) {
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index d691d06236da..8247f1f6c20b 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -206,12 +206,6 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	phs_hdr->flags = flags;
 	if (flags == AF_IUCV_FLAG_SYN)
 		phs_hdr->window = iucv->msglimit;
-	else if ((flags == AF_IUCV_FLAG_WIN) || !flags) {
-		confirm_recv = atomic_read(&iucv->msg_recv);
-		phs_hdr->window = confirm_recv;
-		if (confirm_recv)
-			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
-	}
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -246,13 +240,22 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 
+	/* Claim the receive credit here, not while building the header: every
+	 * way this frame can be dropped has now been ruled out, so the window
+	 * is zeroed only for as long as the transmit itself takes.
+	 */
+	if (flags == AF_IUCV_FLAG_WIN || !flags) {
+		confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
+		phs_hdr->window = confirm_recv;
+		if (confirm_recv)
+			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
+	}
+
 	atomic_inc(&iucv->skbs_in_xmit);
 	err = dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
 		atomic_dec(&iucv->skbs_in_xmit);
-	} else {
-		atomic_sub(confirm_recv, &iucv->msg_recv);
-		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
+		atomic_add(confirm_recv, &iucv->msg_recv);
 	}
 	return net_xmit_eval(err);
 
@@ -1241,6 +1244,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win = false;
 	int err = 0;
 	u32 offset;
 
@@ -1333,16 +1337,20 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		if (skb_queue_empty(&iucv->backlog_skb_q)) {
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
-			if (atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2) {
-				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
-				if (err) {
-					sk->sk_state = IUCV_DISCONN;
-					sk->sk_state_change(sk);
-				}
-			}
+			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
+			    atomic_read(&iucv->msg_recv) >=
+							iucv->msglimit / 2)
+				send_win = true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
+
+		if (send_win) {
+			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
+			if (err) {
+				sk->sk_state = IUCV_DISCONN;
+				sk->sk_state_change(sk);
+			}
+		}
 	}
 
 done:
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 0d2bab9d351c..f6a7eb7181c8 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -103,7 +103,7 @@ void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	del_timer_sync(&tid_rx->session_timer);
+	timer_shutdown_sync(&tid_rx->session_timer);
 
 	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
 	spin_lock_bh(&tid_rx->reorder_lock);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index f32d8d07d6a3..f33bd3cc2a2d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -940,6 +940,7 @@ void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_chanctx *ctx = sdata->reserved_chanctx;
+	struct ieee80211_chanctx *old_ctx = NULL;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
@@ -954,6 +955,7 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 			if (WARN_ON(!ctx->replace_ctx))
 				return -EINVAL;
 
+			old_ctx = ctx->replace_ctx;
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
 			WARN_ON(ctx->replace_ctx->replace_ctx != ctx);
@@ -964,6 +966,10 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 
 			list_del_rcu(&ctx->list);
 			kfree_rcu(ctx, rcu_head);
+
+			if (ieee80211_chanctx_refcount(sdata->local,
+						       old_ctx) == 0)
+				ieee80211_free_chanctx(sdata->local, old_ctx);
 		} else {
 			ieee80211_free_chanctx(sdata->local, ctx);
 		}
@@ -1177,7 +1183,9 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, old_ctx) == 0 &&
+	    !(old_ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      old_ctx->replace_ctx))
 		ieee80211_free_chanctx(local, old_ctx);
 
 	ieee80211_recalc_chanctx_min_def(local, new_ctx);
@@ -1240,7 +1248,8 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 }
 
 static bool
-ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
+ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 
@@ -1249,6 +1258,9 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
 	new_ctx = sdata->reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
+	if (new_ctx != ctx)
+		return false;
+
 	if (!old_ctx)
 		return false;
 
@@ -1261,6 +1273,12 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
 	if (new_ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 		return false;
 
+	if (new_ctx->replace_ctx != old_ctx)
+		return false;
+
+	if (old_ctx->replace_ctx != new_ctx)
+		return false;
+
 	return true;
 }
 
@@ -1311,7 +1329,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
 			if (!ieee80211_vif_has_in_place_reservation(
-					sdata))
+					sdata, ctx))
 				continue;
 
 			old_ctx = ieee80211_vif_get_chanctx(sdata);
@@ -1418,7 +1436,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(sdata, &ctx->replace_ctx->assigned_vifs,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (sdata->reserved_chanctx) {
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx)) {
 				n_reserved++;
 				if (sdata->reserved_ready)
 					n_ready++;
@@ -1439,7 +1457,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ctx->conf.radar_enabled = false;
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
-			if (ieee80211_vif_has_in_place_reservation(sdata) &&
+			if (ieee80211_vif_has_in_place_reservation(sdata, ctx) &&
 			    !sdata->reserved_ready)
 				return -EAGAIN;
 
@@ -1509,7 +1527,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				    reserved_chanctx_list) {
 			u32 changed = 0;
 
-			if (!ieee80211_vif_has_in_place_reservation(sdata))
+			if (!ieee80211_vif_has_in_place_reservation(sdata, ctx))
 				continue;
 
 			rcu_assign_pointer(sdata->vif.chanctx_conf, &ctx->conf);
@@ -1562,7 +1580,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
 					 reserved_chanctx_list) {
 			if (WARN_ON(ieee80211_vif_has_in_place_reservation(
-					sdata)))
+					sdata, ctx)))
 				continue;
 
 			if (WARN_ON(sdata->reserved_chanctx != ctx))
@@ -1649,7 +1667,9 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 	}
 
 	ieee80211_assign_vif_chanctx(sdata, NULL);
-	if (ieee80211_chanctx_refcount(local, ctx) == 0)
+	if (ieee80211_chanctx_refcount(local, ctx) == 0 &&
+	    !(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED &&
+	      ctx->replace_ctx))
 		ieee80211_free_chanctx(local, ctx);
 
 	sdata->radar_required = false;
diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index a13ae148937e..c70732409df7 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -95,6 +95,14 @@ static int aes_siv_encrypt(const u8 *key, size_t key_len,
 	if (res)
 		return res;
 
+	/* With an empty plaintext there is no ciphertext to produce and
+	 * the S2V result is the complete output.
+	 */
+	if (!plain_len) {
+		memcpy(out, v, AES_BLOCK_SIZE);
+		return 0;
+	}
+
 	/* Use a temporary buffer of the plaintext to handle need for
 	 * overwriting this during AES-CTR.
 	 */
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index e7b9dcf30adc..f2970f33f96c 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -407,8 +407,10 @@ struct mesh_path *mesh_path_add(struct ieee80211_sub_if_data *sdata,
 		return ERR_PTR(-ENOSPC);
 
 	new_mpath = mesh_path_new(sdata, dst, GFP_ATOMIC);
-	if (!new_mpath)
+	if (!new_mpath) {
+		atomic_dec(&sdata->u.mesh.mpaths);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	tbl = &sdata->u.mesh.mesh_paths;
 	spin_lock_bh(&tbl->walk_lock);
@@ -421,6 +423,7 @@ struct mesh_path *mesh_path_add(struct ieee80211_sub_if_data *sdata,
 
 	if (mpath) {
 		kfree(new_mpath);
+		atomic_dec(&sdata->u.mesh.mpaths);
 
 		if (IS_ERR(mpath))
 			return mpath;
@@ -446,10 +449,15 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 	if (is_multicast_ether_addr(dst))
 		return -ENOTSUPP;
 
+	if (!atomic_add_unless(&sdata->u.mesh.mpaths, 1, MESH_MAX_MPATHS))
+		return -ENOSPC;
+
 	new_mpath = mesh_path_new(sdata, dst, GFP_ATOMIC);
 
-	if (!new_mpath)
+	if (!new_mpath) {
+		atomic_dec(&sdata->u.mesh.mpaths);
 		return -ENOMEM;
+	}
 
 	memcpy(new_mpath->mpp, mpp, ETH_ALEN);
 	tbl = &sdata->u.mesh.mpp_paths;
@@ -462,8 +470,10 @@ int mpp_path_add(struct ieee80211_sub_if_data *sdata,
 		hlist_add_head_rcu(&new_mpath->walk_list, &tbl->walk_head);
 	spin_unlock_bh(&tbl->walk_lock);
 
-	if (ret)
+	if (ret) {
 		kfree(new_mpath);
+		atomic_dec(&sdata->u.mesh.mpaths);
+	}
 
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5617540b40b2..bfd4654d404f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3310,6 +3310,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	u16 capab_info, aid;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee802_11_elems *bss_elems = NULL;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
@@ -3376,7 +3377,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
 
 		rcu_read_lock();
 		ies = rcu_dereference(cbss->ies);
@@ -3432,8 +3432,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
-
-		kfree(bss_elems);
 	}
 
 	/*
@@ -3685,6 +3683,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	ret = true;
  out:
 	kfree(elems);
+	kfree(bss_elems);
 	kfree(bss_ies);
 	return ret;
 }
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 90238170dec3..168fbf176492 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/debugfs.h>
+#include <linux/limits.h>
 #include <linux/random.h>
 #include <linux/moduleparam.h>
 #include <linux/ieee80211.h>
@@ -1852,14 +1853,39 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
+static int minstrel_ht_fixed_rate_idx_get(void *data, u64 *val)
+{
+	*val = *(u32 *)data;
+	return 0;
+}
+
+static int minstrel_ht_fixed_rate_idx_set(void *data, u64 val)
+{
+	u32 idx = val;
+
+	/* U32_MAX is the default and keeps fixed rate processing disabled */
+	if (val != U32_MAX &&
+	    (val > U16_MAX ||
+	     MI_RATE_GROUP(idx) >= ARRAY_SIZE(minstrel_mcs_groups) ||
+	     MI_RATE_IDX(idx) >= MCS_GROUP_RATES))
+		return -EINVAL;
+
+	*(u32 *)data = idx;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(minstrel_ht_fixed_rate_idx_fops,
+			 minstrel_ht_fixed_rate_idx_get,
+			 minstrel_ht_fixed_rate_idx_set, "%llu\n");
+
 static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
 				    struct dentry *debugfsdir)
 {
 	struct minstrel_priv *mp = priv;
 
 	mp->fixed_rate_idx = (u32) -1;
-	debugfs_create_u32("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
-			   &mp->fixed_rate_idx);
+	debugfs_create_file("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
+			    &mp->fixed_rate_idx, &minstrel_ht_fixed_rate_idx_fops);
 }
 #endif
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f9a5bda1f925..5fa51c24d663 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -89,6 +89,8 @@ static void __cleanup_single_sta(struct sta_info *sta)
 	struct ieee80211_local *local = sdata->local;
 	struct ps_data *ps;
 
+	cancel_work_sync(&sta->drv_deliver_wk);
+
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
 	    test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
 	    test_sta_flag(sta, WLAN_STA_PS_DELIVER)) {
@@ -129,8 +131,6 @@ static void __cleanup_single_sta(struct sta_info *sta)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_sta_cleanup(sta);
 
-	cancel_work_sync(&sta->drv_deliver_wk);
-
 	/*
 	 * Destroy aggregation state here. It would be nice to wait for the
 	 * driver to finish aggregation stop and then clean up, but for now
@@ -1090,6 +1090,8 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 
 	sta->dead = true;
 
+	cancel_work_sync(&sta->drv_deliver_wk);
+
 	local->num_sta--;
 	local->sta_generation++;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b7865f3b9787..a919d585b6b1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4467,6 +4467,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4514,6 +4515,11 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		sdata = container_of(sdata->bss,
 				     struct ieee80211_sub_if_data, u.ap);
 
+	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	if (unlikely(!chanctx_conf))
+		goto out_free;
+	info->band = chanctx_conf->def.chan->band;
+
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
diff --git a/net/mctp/device.c b/net/mctp/device.c
index a11d5aca201c..639d2c664178 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -35,14 +35,6 @@ struct mctp_dev *mctp_dev_get_rtnl(const struct net_device *dev)
 	return rtnl_dereference(dev->mctp_ptr);
 }
 
-static void mctp_dev_destroy(struct mctp_dev *mdev)
-{
-	struct net_device *dev = mdev->dev;
-
-	dev_put(dev);
-	kfree_rcu(mdev, rcu);
-}
-
 static int mctp_fill_addrinfo(struct sk_buff *skb, struct netlink_callback *cb,
 			      struct mctp_dev *mdev, mctp_eid_t eid)
 {
@@ -263,6 +255,19 @@ static int mctp_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 }
 
+void mctp_dev_hold(struct mctp_dev *mdev)
+{
+	refcount_inc(&mdev->refs);
+}
+
+void mctp_dev_put(struct mctp_dev *mdev)
+{
+	if (refcount_dec_and_test(&mdev->refs)) {
+		dev_put(mdev->dev);
+		kfree_rcu(mdev, rcu);
+	}
+}
+
 static struct mctp_dev *mctp_add_dev(struct net_device *dev)
 {
 	struct mctp_dev *mdev;
@@ -277,11 +282,13 @@ static struct mctp_dev *mctp_add_dev(struct net_device *dev)
 
 	mdev->net = mctp_default_net(dev_net(dev));
 
-	/* associate to net_device */
-	rcu_assign_pointer(dev->mctp_ptr, mdev);
+	refcount_set(&mdev->refs, 1);
 	dev_hold(dev);
 	mdev->dev = dev;
 
+	/* Associate to net_device, publish the mdev. */
+	rcu_assign_pointer(dev->mctp_ptr, mdev);
+
 	return mdev;
 }
 
@@ -353,7 +360,7 @@ static void mctp_unregister(struct net_device *dev)
 	mctp_neigh_remove_dev(mdev);
 	kfree(mdev->addrs);
 
-	mctp_dev_destroy(mdev);
+	mctp_dev_put(mdev);
 }
 
 static int mctp_register(struct net_device *dev)
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index 18a6be38f172..b184a5d164e8 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -47,7 +47,7 @@ static int mctp_neigh_add(struct mctp_dev *mdev, mctp_eid_t eid,
 	}
 	INIT_LIST_HEAD(&neigh->list);
 	neigh->dev = mdev;
-	dev_hold(neigh->dev->dev);
+	mctp_dev_hold(neigh->dev);
 	neigh->eid = eid;
 	neigh->source = source;
 	memcpy(neigh->ha, lladdr, lladdr_len);
@@ -63,7 +63,7 @@ static void __mctp_neigh_free(struct rcu_head *rcu)
 {
 	struct mctp_neigh *neigh = container_of(rcu, struct mctp_neigh, rcu);
 
-	dev_put(neigh->dev->dev);
+	mctp_dev_put(neigh->dev);
 	kfree(neigh);
 }
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index f087cc73ca35..2b3d9b356b6d 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -420,7 +420,7 @@ static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
 static void mctp_route_release(struct mctp_route *rt)
 {
 	if (refcount_dec_and_test(&rt->refs)) {
-		dev_put(rt->dev->dev);
+		mctp_dev_put(rt->dev);
 		kfree_rcu(rt, rcu);
 	}
 }
@@ -777,7 +777,7 @@ static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 	rt->max = daddr_start + daddr_extent;
 	rt->mtu = mtu;
 	rt->dev = mdev;
-	dev_hold(rt->dev->dev);
+	mctp_dev_hold(rt->dev);
 	rt->type = type;
 	rt->output = rtfn;
 
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 9523104a90da..8a2beac5a53e 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -157,7 +157,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 
 	if (SET_WITH_COUNTER(set))
 		ip_set_init_counter(ext_counter(x, set), ext);
-	if (SET_WITH_COMMENT(set))
+	if (SET_WITH_COMMENT(set) && !ext->target)
 		ip_set_init_comment(set, ext_comment(x, set), ext);
 	if (SET_WITH_SKBINFO(set))
 		ip_set_init_skbinfo(ext_skbinfo(x, set), ext);
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 73361a4df43b..bc150438c452 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -591,6 +591,9 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 	if (cp->protocol != IPPROTO_UDP)
 		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
 	flags = cp->flags;
+	/* Only visible templates can control multiple connections */
+	if (flags & IP_VS_CONN_F_TEMPLATE)
+		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
 	/* Bind with the destination and its corresponding transmitter */
 	if (flags & IP_VS_CONN_F_SYNC) {
 		/* Synced conns are hashed, so they can not get this flag */
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index e2480f33a196..49ff1f9fe147 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -205,7 +205,11 @@ ip_vs_lblc_new(struct ip_vs_lblc_table *tbl, const union nf_inet_addr *daddr,
 		if (en->dest == dest)
 			return en;
 		ip_vs_lblc_del(en);
+		atomic_dec(&tbl->entries);
 	}
+	if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+		return NULL;
+
 	en = kmalloc(sizeof(*en), GFP_ATOMIC);
 	if (!en)
 		return NULL;
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 7469547c8a44..6feab18861e1 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -365,6 +365,9 @@ ip_vs_lblcr_new(struct ip_vs_lblcr_table *tbl, const union nf_inet_addr *daddr,
 
 	en = ip_vs_lblcr_get(af, tbl, daddr);
 	if (!en) {
+		if (atomic_read(&tbl->entries) >= tbl->max_size * 3 / 2)
+			return NULL;
+
 		en = kmalloc(sizeof(*en), GFP_ATOMIC);
 		if (!en)
 			return NULL;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 56e371b18fc2..deac3c1715da 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -950,6 +950,21 @@ static void ip_vs_proc_conn(struct netns_ipvs *ipvs, struct ip_vs_conn_param *pa
 	ip_vs_conn_put(cp);
 }
 
+/* Check for incompatible flags */
+static bool ip_vs_sync_validate_flags(u32 flags)
+{
+	/* We do not expect NO_CPORT, especially to allow lookups
+	 * to hit templates
+	 */
+	if (flags & IP_VS_CONN_F_NO_CPORT) {
+		if (flags & IP_VS_CONN_F_TEMPLATE)
+			return false;
+	}
+	if (flags & IP_VS_CONN_F_ONE_PACKET)
+		return false;
+	return true;
+}
+
 /*
  *  Process received multicast message for Version 0
  */
@@ -973,8 +988,7 @@ static void ip_vs_process_message_v0(struct netns_ipvs *ipvs, const char *buffer
 			return;
 		}
 		s = (struct ip_vs_sync_conn_v0 *) p;
-		flags = ntohs(s->flags) | IP_VS_CONN_F_SYNC;
-		flags &= ~IP_VS_CONN_F_HASHED;
+		flags = ntohs(s->flags);
 		if (flags & IP_VS_CONN_F_SEQ_MASK) {
 			opt = (struct ip_vs_sync_conn_options *)&s[1];
 			p += FULL_CONN_SIZE;
@@ -987,6 +1001,13 @@ static void ip_vs_process_message_v0(struct netns_ipvs *ipvs, const char *buffer
 			p += SIMPLE_CONN_SIZE;
 		}
 
+		if (!ip_vs_sync_validate_flags(flags)) {
+			IP_VS_DBG(2, "BACKUP v0, Invalid flags 0x%X\n", flags);
+			continue;
+		}
+		flags &= IP_VS_CONN_F_BACKUP_MASK;
+		flags |= IP_VS_CONN_F_SYNC;
+
 		state = ntohs(s->state);
 		if (!(flags & IP_VS_CONN_F_TEMPLATE)) {
 			pp = ip_vs_proto_get(s->protocol);
@@ -1142,7 +1163,13 @@ static inline int ip_vs_proc_sync_conn(struct netns_ipvs *ipvs, __u8 *p, __u8 *m
 	}
 
 	/* Get flags and Mask off unsupported */
-	flags  = ntohl(s->v4.flags) & IP_VS_CONN_F_BACKUP_MASK;
+	flags = ntohl(s->v4.flags);
+	if (!ip_vs_sync_validate_flags(flags)) {
+		IP_VS_DBG(3, "BACKUP, Invalid flags 0x%X\n", flags);
+		retc = 25;
+		goto out;
+	}
+	flags &= IP_VS_CONN_F_BACKUP_MASK;
 	flags |= IP_VS_CONN_F_SYNC;
 	state = ntohs(s->v4.state);
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b5273255b738..f2332b097745 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -627,7 +627,6 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 		elem.priv = catchall->elem;
 		nft_set_elem_change_active(ctx->net, set, ext);
 		nft_setelem_data_deactivate(ctx->net, set, &elem);
-		break;
 	}
 }
 
@@ -5172,7 +5171,6 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 		nft_clear(ctx->net, ext);
 		elem.priv = catchall->elem;
 		nft_setelem_data_activate(ctx->net, set, &elem);
-		break;
 	}
 }
 
@@ -6075,16 +6073,19 @@ EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
-				       struct nft_set_ext **pext)
+				       void **priv)
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (nft_set_elem_active(ext, genmask)) {
-			*pext = ext;
+		if (nft_set_elem_active(ext, genmask) &&
+		    !__nft_set_elem_expired(ext, tstamp) &&
+		    !nft_set_elem_is_dead(ext)) {
+			*priv = catchall->elem;
 			return -EEXIST;
 		}
 	}
@@ -6102,14 +6103,15 @@ static int nft_setelem_catchall_insert(const struct net *net,
 static int nft_setelem_insert(const struct net *net,
 			      struct nft_set *set,
 			      const struct nft_set_elem *elem,
-			      struct nft_set_ext **ext, unsigned int flags)
+			      void **elem_priv,
+			      unsigned int flags)
 {
 	int ret;
 
 	if (flags & NFT_SET_ELEM_CATCHALL)
-		ret = nft_setelem_catchall_insert(net, set, elem, ext);
+		ret = nft_setelem_catchall_insert(net, set, elem, elem_priv);
 	else
-		ret = set->ops->insert(net, set, elem, ext);
+		ret = set->ops->insert(net, set, elem, elem_priv);
 
 	return ret;
 }
@@ -6143,11 +6145,14 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set_elem *elem)
 {
 	struct nft_set_elem_catchall *catchall;
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_set_ext *ext;
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active_next(net, ext))
+		if (!nft_is_active_next(net, ext) ||
+		    __nft_set_elem_expired(ext, tstamp) ||
+		    nft_set_elem_is_dead(ext))
 			continue;
 
 		kfree(elem->priv);
@@ -6255,6 +6260,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
+	void *elem_priv;
+	bool set_full = false;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -6541,17 +6548,27 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (err < 0)
 		goto err_elem_expr;
 
+	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
+		unsigned int max = set->size ? set->size + set->ndeact : UINT_MAX;
+		unsigned int nelems;
+
+		nelems = atomic_inc_return(&set->nelems);
+		if (nelems > max)
+			set_full = true;
+	}
+
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
 	if (trans == NULL) {
 		err = -ENOMEM;
-		goto err_elem_expr;
+		goto err_set_size;
 	}
 
 	ext->genmask = nft_genmask_cur(ctx->net);
 
-	err = nft_setelem_insert(ctx->net, set, &elem, &ext2, flags);
+	err = nft_setelem_insert(ctx->net, set, &elem, &elem_priv, flags);
 	if (err) {
 		if (err == -EEXIST) {
+			ext2 = nft_set_elem_ext(set, elem_priv);
 			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
 			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
 			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
@@ -6576,20 +6593,16 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_element_clash;
 	}
 
-	if (!(flags & NFT_SET_ELEM_CATCHALL) && set->size &&
-	    !atomic_add_unless(&set->nelems, 1, set->size + set->ndeact)) {
-		err = -ENFILE;
-		goto err_set_full;
-	}
-
 	nft_trans_elem(trans) = elem;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
-	return 0;
 
-err_set_full:
-	nft_setelem_remove(ctx->net, set, &elem);
+	return set_full ? -ENFILE : 0;
+
 err_element_clash:
 	kfree(trans);
+err_set_size:
+	if (!(flags & NFT_SET_ELEM_CATCHALL))
+		atomic_dec(&set->nelems);
 err_elem_expr:
 	nf_tables_set_elem_destroy(ctx, set, elem.priv);
 err_parse_data:
@@ -8112,6 +8125,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 					       &flowtable->hook_list,
 					       flowtable);
 	if (err < 0) {
+		synchronize_rcu();
 		nft_flowtable_hooks_destroy(&flowtable->hook_list);
 		goto err4;
 	}
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 2ab4216d2a90..bbbd3bbbd1ea 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -25,9 +25,7 @@ static noinline void __nft_trace_packet(struct nft_traceinfo *info,
 					const struct nft_chain *chain,
 					enum nft_trace_types type)
 {
-	const struct nft_pktinfo *pkt = info->pkt;
-
-	if (!info->trace || !pkt->skb->nf_trace)
+	if (!info->trace || !info->nf_trace)
 		return;
 
 	info->chain = chain;
@@ -36,17 +34,28 @@ static noinline void __nft_trace_packet(struct nft_traceinfo *info,
 	nft_trace_notify(info);
 }
 
-static inline void nft_trace_packet(struct nft_traceinfo *info,
+static inline void nft_trace_packet(const struct nft_pktinfo *pkt,
+				    struct nft_traceinfo *info,
 				    const struct nft_chain *chain,
 				    const struct nft_rule *rule,
 				    enum nft_trace_types type)
 {
 	if (static_branch_unlikely(&nft_trace_enabled)) {
+		info->nf_trace = pkt->skb->nf_trace;
 		info->rule = rule;
 		__nft_trace_packet(info, chain, type);
 	}
 }
 
+static inline void nft_trace_copy_nftrace(const struct nft_pktinfo *pkt,
+					  struct nft_traceinfo *info)
+{
+	if (static_branch_unlikely(&nft_trace_enabled)) {
+		if (info->trace)
+			info->nf_trace = pkt->skb->nf_trace;
+	}
+}
+
 static void nft_bitwise_fast_eval(const struct nft_expr *expr,
 				  struct nft_regs *regs)
 {
@@ -92,8 +101,15 @@ static noinline void __nft_trace_verdict(struct nft_traceinfo *info,
 	case NFT_RETURN:
 		type = NFT_TRACETYPE_RETURN;
 		break;
+	case NF_STOLEN:
+		type = NFT_TRACETYPE_RULE;
+		/* can't access skb->nf_trace; use copy */
+		break;
 	default:
 		type = NFT_TRACETYPE_RULE;
+
+		if (info->trace)
+			info->nf_trace = info->pkt->skb->nf_trace;
 		break;
 	}
 
@@ -244,9 +260,10 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 		switch (regs.verdict.code) {
 		case NFT_BREAK:
 			regs.verdict.code = NFT_CONTINUE;
+			nft_trace_copy_nftrace(pkt, &info);
 			continue;
 		case NFT_CONTINUE:
-			nft_trace_packet(&info, chain, rule,
+			nft_trace_packet(pkt, &info, chain, rule,
 					 NFT_TRACETYPE_RULE);
 			continue;
 		}
@@ -288,7 +305,7 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 		goto next_rule;
 	}
 
-	nft_trace_packet(&info, basechain, NULL, NFT_TRACETYPE_POLICY);
+	nft_trace_packet(pkt, &info, basechain, NULL, NFT_TRACETYPE_POLICY);
 
 	if (static_branch_unlikely(&nft_counters_enabled))
 		nft_update_chain_stats(basechain, pkt);
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 84a7dea46efa..1d28ce62c337 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/static_key.h>
 #include <linux/hash.h>
-#include <linux/jhash.h>
+#include <linux/siphash.h>
 #include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
@@ -25,22 +25,6 @@
 DEFINE_STATIC_KEY_FALSE(nft_trace_enabled);
 EXPORT_SYMBOL_GPL(nft_trace_enabled);
 
-static int trace_fill_id(struct sk_buff *nlskb, struct sk_buff *skb)
-{
-	__be32 id;
-
-	/* using skb address as ID results in a limited number of
-	 * values (and quick reuse).
-	 *
-	 * So we attempt to use as many skb members that will not
-	 * change while skb is with netfilter.
-	 */
-	id = (__be32)jhash_2words(hash32_ptr(skb), skb_get_hash(skb),
-				  skb->skb_iif);
-
-	return nla_put_be32(nlskb, NFTA_TRACE_ID, id);
-}
-
 static int trace_fill_header(struct sk_buff *nlskb, u16 type,
 			     const struct sk_buff *skb,
 			     int off, unsigned int len)
@@ -186,6 +170,7 @@ void nft_trace_notify(struct nft_traceinfo *info)
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int size;
+	u32 mark = 0;
 	u16 event;
 
 	if (!nfnetlink_has_listeners(nft_net(pkt), NFNLGRP_NFTRACE))
@@ -229,7 +214,7 @@ void nft_trace_notify(struct nft_traceinfo *info)
 	if (nla_put_be32(skb, NFTA_TRACE_TYPE, htonl(info->type)))
 		goto nla_put_failure;
 
-	if (trace_fill_id(skb, pkt->skb))
+	if (nla_put_u32(skb, NFTA_TRACE_ID, info->skbid))
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, NFTA_TRACE_CHAIN, info->chain->name))
@@ -249,16 +234,24 @@ void nft_trace_notify(struct nft_traceinfo *info)
 	case NFT_TRACETYPE_RULE:
 		if (nft_verdict_dump(skb, NFTA_TRACE_VERDICT, info->verdict))
 			goto nla_put_failure;
+
+		/* pkt->skb undefined iff NF_STOLEN, disable dump */
+		if (info->verdict->code == NF_STOLEN)
+			info->packet_dumped = true;
+		else
+			mark = pkt->skb->mark;
+
 		break;
 	case NFT_TRACETYPE_POLICY:
+		mark = pkt->skb->mark;
+
 		if (nla_put_be32(skb, NFTA_TRACE_POLICY,
 				 htonl(info->basechain->policy)))
 			goto nla_put_failure;
 		break;
 	}
 
-	if (pkt->skb->mark &&
-	    nla_put_be32(skb, NFTA_TRACE_MARK, htonl(pkt->skb->mark)))
+	if (mark && nla_put_be32(skb, NFTA_TRACE_MARK, htonl(mark)))
 		goto nla_put_failure;
 
 	if (!info->packet_dumped) {
@@ -283,9 +276,20 @@ void nft_trace_init(struct nft_traceinfo *info, const struct nft_pktinfo *pkt,
 		    const struct nft_verdict *verdict,
 		    const struct nft_chain *chain)
 {
+	static siphash_key_t trace_key __read_mostly;
+	struct sk_buff *skb = pkt->skb;
+
 	info->basechain = nft_base_chain(chain);
 	info->trace = true;
+	info->nf_trace = pkt->skb->nf_trace;
 	info->packet_dumped = false;
 	info->pkt = pkt;
 	info->verdict = verdict;
+
+	net_get_random_once(&trace_key, sizeof(trace_key));
+
+	info->skbid = (u32)siphash_3u32(hash32_ptr(skb),
+					skb_get_hash_net(nft_net(pkt), skb),
+					skb->skb_iif,
+					&trace_key);
 }
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index e1d7231b8774..9101971dfb2b 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -351,6 +351,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (tcph)
 		flow_offload_ct_tcp(ct);
 
+	__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
 	ret = flow_offload_add(flowtable, flow);
 	if (ret < 0)
 		goto err_flow_add;
@@ -394,6 +395,7 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	u8 genmask = nft_genmask_next(ctx->net);
 	struct nft_flowtable *flowtable;
+	int err;
 
 	if (!tb[NFTA_FLOW_TABLE_NAME])
 		return -EINVAL;
@@ -408,7 +410,11 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 
 	priv->flowtable = flowtable;
 
-	return nf_ct_netns_get(ctx->net, ctx->family);
+	err = nf_ct_netns_get(ctx->net, ctx->family);
+	if (err < 0)
+		nft_use_dec(&flowtable->use);
+
+	return err;
 }
 
 static void nft_flow_offload_deactivate(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 028955a9cb09..ec12d0f81435 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -123,7 +123,7 @@ static void *nft_bitmap_get(const struct net *net, const struct nft_set *set,
 
 static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     void **elem_priv)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *new = elem->priv, *be;
@@ -132,7 +132,7 @@ static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 
 	be = nft_bitmap_elem_find(set, new, genmask);
 	if (be) {
-		*ext = &be->ext;
+		*elem_priv = be;
 		return -EEXIST;
 	}
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 5a74ee4b7dfb..60c0d72fb98b 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -168,7 +168,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 
 static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem,
-			    struct nft_set_ext **ext)
+			    void **elem_priv)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	struct nft_rhash_elem *he = elem->priv;
@@ -185,7 +185,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 	if (IS_ERR(prev))
 		return PTR_ERR(prev);
 	if (prev) {
-		*ext = &prev->ext;
+		*elem_priv = prev;
 		return -EEXIST;
 	}
 	return 0;
@@ -588,7 +588,7 @@ static u32 nft_jhash(const struct nft_set *set, const struct nft_hash *priv,
 
 static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 			   const struct nft_set_elem *elem,
-			   struct nft_set_ext **ext)
+			   void **elem_priv)
 {
 	struct nft_hash_elem *this = elem->priv, *he;
 	struct nft_hash *priv = nft_set_priv(set);
@@ -600,7 +600,7 @@ static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 		if (!memcmp(nft_set_ext_key(&this->ext),
 			    nft_set_ext_key(&he->ext), set->klen) &&
 		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
+			*elem_priv = he;
 			return -EEXIST;
 		}
 	}
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 1825db84c222..ef8441fe586a 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1233,13 +1233,13 @@ static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
- * @ext2:	Filled with pointer to &struct nft_set_ext in inserted element
+ * @elem_priv:	Filled with private pointer to inserted or existing element
  *
  * Return: 0 on success, error pointer on failure.
  */
 static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext2)
+			     void **elem_priv)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1274,7 +1274,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		if (!memcmp(start, dup_key->data, sizeof(*dup_key->data)) &&
 		    !memcmp(end, dup_end->data, sizeof(*dup_end->data))) {
-			*ext2 = &dup->ext;
+			*elem_priv = dup;
 			return -EEXIST;
 		}
 
@@ -1290,7 +1290,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	if (PTR_ERR(dup) != -ENOENT) {
 		if (IS_ERR(dup))
 			return PTR_ERR(dup);
-		*ext2 = &dup->ext;
+		*elem_priv = dup;
 		return -ENOTEMPTY;
 	}
 
@@ -1352,7 +1352,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		put_cpu_ptr(m->scratch);
 	}
 
-	*ext2 = &e->ext;
+	*elem_priv = e;
 
 	pipapo_map(m, rulemap, e);
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 23e4e656f7f0..db0ad96d1091 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -319,7 +319,7 @@ static struct nft_rbtree_elem *nft_rbtree_prev_active(struct nft_rbtree_elem *rb
 
 static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_rbtree_elem *new,
-			       struct nft_set_ext **ext)
+			       void **elem_priv)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL, *rbe_prev;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
@@ -437,7 +437,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_ge && !nft_rbtree_cmp(set, new, rbe_ge) &&
 	    nft_rbtree_interval_start(rbe_ge) == nft_rbtree_interval_start(new)) {
-		*ext = &rbe_ge->ext;
+		*elem_priv = rbe_ge;
 		return -EEXIST;
 	}
 
@@ -446,7 +446,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_le && !nft_rbtree_cmp(set, new, rbe_le) &&
 	    nft_rbtree_interval_end(rbe_le) == nft_rbtree_interval_end(new)) {
-		*ext = &rbe_le->ext;
+		*elem_priv = rbe_le;
 		return -EEXIST;
 	}
 
@@ -506,7 +506,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     void **elem_priv)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe = elem->priv;
@@ -520,7 +520,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		write_lock_bh(&priv->lock);
 		write_seqcount_begin(&priv->count);
-		err = __nft_rbtree_insert(net, set, rbe, ext);
+		err = __nft_rbtree_insert(net, set, rbe, elem_priv);
 		write_seqcount_end(&priv->count);
 		write_unlock_bh(&priv->lock);
 	} while (err == -EAGAIN);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 1029c87ea913..3671071482a0 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -463,7 +463,7 @@ netlink_unlock_table(void)
 
 struct netlink_compare_arg
 {
-	possible_net_t pnet;
+	u64 net_cookie;
 	u32 portid;
 };
 
@@ -478,14 +478,14 @@ static inline int netlink_compare(struct rhashtable_compare_arg *arg,
 	const struct netlink_sock *nlk = ptr;
 
 	return nlk->portid != x->portid ||
-	       !net_eq(sock_net(&nlk->sk), read_pnet(&x->pnet));
+	       sock_net(&nlk->sk)->net_cookie != x->net_cookie;
 }
 
 static void netlink_compare_arg_init(struct netlink_compare_arg *arg,
 				     struct net *net, u32 portid)
 {
 	memset(arg, 0, sizeof(*arg));
-	write_pnet(&arg->pnet, net);
+	arg->net_cookie = net->net_cookie;
 	arg->portid = portid;
 }
 
@@ -1339,6 +1339,8 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	if (netlink_is_kernel(sk))
 		return netlink_unicast_kernel(sk, skb, ssk);
 
+	skb_reset_network_header(skb);
+	skb_reset_mac_header(skb);
 	if (sk_filter(sk, skb)) {
 		err = skb->len;
 		kfree_skb(skb);
@@ -1468,11 +1470,15 @@ static void do_one_broadcast(struct sock *sk,
 			p->delivery_failure = 1;
 		goto out;
 	}
+
 	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
 		goto out;
 	}
+
+	skb_reset_network_header(p->skb2);
+	skb_reset_mac_header(p->skb2);
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
@@ -1500,10 +1506,12 @@ static void do_one_broadcast(struct sock *sk,
 	sock_put(sk);
 }
 
-int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb, u32 portid,
-	u32 group, gfp_t allocation,
-	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
-	void *filter_data)
+int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
+			       u32 portid,
+			       u32 group, gfp_t allocation,
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
+			       void *filter_data)
 {
 	struct net *net = sock_net(ssk);
 	struct netlink_broadcast_data info;
@@ -1555,7 +1563,7 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
 		      u32 group, gfp_t allocation)
 {
 	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
-		NULL, NULL);
+					  NULL, NULL);
 }
 EXPORT_SYMBOL(netlink_broadcast);
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 7a568292e0d1..c0d6950e2165 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1101,6 +1101,7 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 struct ctrl_dump_policy_ctx {
 	struct netlink_policy_dump_state *state;
 	const struct genl_family *rt;
+	struct module *owner;
 	unsigned int opidx;
 	u32 op;
 	u16 fam_id;
@@ -1144,6 +1145,9 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		return -ENOENT;
 
 	ctx->rt = rt;
+	ctx->owner = rt->module;
+	if (!try_module_get(ctx->owner))
+		return -ENOENT;
 
 	if (tb[CTRL_ATTR_OP]) {
 		ctx->single_op = true;
@@ -1152,14 +1156,19 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		err = genl_get_cmd(ctx->op, rt, &op);
 		if (err) {
 			NL_SET_BAD_ATTR(cb->extack, tb[CTRL_ATTR_OP]);
-			return err;
+			goto err_put_owner;
 		}
 
-		if (!op.policy)
-			return -ENODATA;
+		if (!op.policy) {
+			err = -ENODATA;
+			goto err_put_owner;
+		}
 
-		return netlink_policy_dump_add_policy(&ctx->state, op.policy,
-						      op.maxattr);
+		err = netlink_policy_dump_add_policy(&ctx->state, op.policy,
+						     op.maxattr);
+		if (err)
+			goto err_free_state;
+		return 0;
 	}
 
 	for (i = 0; i < genl_get_cmd_cnt(rt); i++) {
@@ -1174,12 +1183,16 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 		}
 	}
 
-	if (!ctx->state)
-		return -ENODATA;
+	if (!ctx->state) {
+		err = -ENODATA;
+		goto err_put_owner;
+	}
 	return 0;
 
 err_free_state:
 	netlink_policy_dump_free(ctx->state);
+err_put_owner:
+	module_put(ctx->owner);
 	return err;
 }
 
@@ -1314,6 +1327,7 @@ static int ctrl_dumppolicy_done(struct netlink_callback *cb)
 	struct ctrl_dump_policy_ctx *ctx = (void *)cb->ctx;
 
 	netlink_policy_dump_free(ctx->state);
+	module_put(ctx->owner);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fd22d3632ba..aea8a4eb9cde 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -380,7 +380,12 @@ static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
 static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
 				 __be32 addr[4], const __be32 new_addr[4])
 {
-	int transport_len = skb->len - skb_transport_offset(skb);
+	int transport_len;
+
+	if (l4_proto == NEXTHDR_FRAGMENT)
+		return;
+
+	transport_len = skb->len - skb_transport_offset(skb);
 
 	if (l4_proto == NEXTHDR_TCP) {
 		if (likely(transport_len >= sizeof(struct tcphdr)))
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index ee42c9357dff..ff610c320c28 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1037,7 +1037,8 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		 * connections which we will commit, we may need to attach
 		 * the helper here.
 		 */
-		if (info->commit && info->helper && !nfct_help(ct)) {
+		if (!nf_ct_is_confirmed(ct) && info->commit &&
+		    info->helper && !nfct_help(ct)) {
 			int err = __nf_ct_try_assign_helper(ct, info->ct,
 							    GFP_ATOMIC);
 			if (err)
@@ -1051,14 +1052,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 			}
 		}
 
-		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached") or a
-		 *   helper was just attached ("add_helper") for a confirmed
-		 *   connection, or
-		 * - When committing an unconfirmed connection.
+		/* Call the helper only if nf_conntrack_in() was executed
+		 * above ("!cached") or a helper was just attached ("add_helper").
+		 *
+		 * For unconfirmed connections it will be called later during
+		 * commit as we need to have all the other extensions allocated
+		 * before the call.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit) &&
+		if (nf_ct_is_confirmed(ct) && (!cached || add_helper) &&
 		    ovs_ct_helper(skb, info->family) != NF_ACCEPT) {
 			return -EINVAL;
 		}
@@ -1274,6 +1275,12 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 					 &info->labels.mask);
 		if (err)
 			return err;
+
+		/* Call the helpers now.  We couldn't do this before as
+		 * all the extensions must be allocated before the call.
+		 */
+		if (ovs_ct_helper(skb, info->family) != NF_ACCEPT)
+			return -EINVAL;
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index afe15cfbba09..5b62748d0bdf 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1474,6 +1474,12 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
+	/*
+	 * Not needed for safety. Stops every spin_unlock_bh() in
+	 * ovs_flow_stats_get() from running the softirq backlog.
+	 */
+	local_bh_disable();
+
 	ti = rcu_dereference(dp->table.ti);
 	for (;;) {
 		struct sw_flow *flow;
@@ -1494,6 +1500,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = bucket;
 		cb->args[1] = obj;
 	}
+
+	local_bh_enable();
 	rcu_read_unlock();
 	return skb->len;
 }
diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 10e30a85d5c5..7c31995618d6 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -190,11 +190,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev);
-	dev_put(vport->dev);
-	vport->dev = NULL;
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 904e06e648a3..1174b9234321 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1926,7 +1926,8 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 
 	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
+	if (dev_has_header(dev))
+		skb_push(skb, skb->data - skb_mac_header(skb));
 
 	/*
 	 *	The SOCK_PACKET socket receives _all_ frames.
@@ -2871,6 +2872,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
+		/* Prevent the byte count from wrapping into a negative errno */
+		if (unlikely(tp_len > INT_MAX - len_sum))
+			break;
 		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index f71f073fd27a..3f7da1d7ad18 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -52,7 +52,7 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 {
 	/* this can be null in the listening path */
 	struct rds_connection *conn = cm_id->context;
-	struct rds_transport *trans;
+	struct rds_transport *trans = &rds_ib_transport;
 	int ret = 0;
 	int *err;
 	u8 len;
@@ -60,9 +60,6 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 	rdsdebug("conn %p id %p handling event %u (%s)\n", conn, cm_id,
 		 event->event, rdma_event_msg(event->event));
 
-	if (cm_id->device->node_type == RDMA_NODE_IB_CA)
-		trans = &rds_ib_transport;
-
 	/* Prevent shutdown from tearing down the connection
 	 * while we're executing. */
 	if (conn) {
@@ -82,16 +79,47 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
+		/* Only the IB transport is supported, but RDS listens on
+		 * every RDMA device: reject a request that arrived on any
+		 * other kind.  A non-zero return has rdma_cm destroy the
+		 * request's id, which is what we want here and only here.
+		 */
+		if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+			ret = 1;
+			break;
+		}
 		ret = trans->cm_handle_connect(cm_id, event, isv6);
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
 		if (conn) {
+			/* The address resolved to a device RDS has no
+			 * transport for.  Do not go on to resolve a route:
+			 * an iWARP route leaves cm_id->route.path_rec
+			 * unset, which the ROUTE_RESOLVED case below
+			 * dereferences.  Drop the connection instead; the
+			 * id is still ic->i_cm_id, so return 0 and let the
+			 * shutdown destroy it.
+			 */
+			if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+				rds_conn_drop(conn);
+				break;
+			}
 			rdma_set_service_type(cm_id, conn->c_tos);
 			rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
-			/* XXX do we need to clean up if this fails? */
 			ret = rdma_resolve_route(cm_id,
 						 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+			if (ret) {
+				/* A non-zero return has the rdma_cm destroy
+				 * the id, but it is still ic->i_cm_id, which
+				 * the connection's shutdown would then
+				 * disconnect and destroy again.  Drop the
+				 * connection and keep the id for that
+				 * shutdown.
+				 */
+				rds_conn_drop(conn);
+				ret = 0;
+			}
 		}
 		break;
 
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index fba2c7a2210b..f8bf7356f78d 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -231,16 +231,19 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
 	write_lock_bh(&sock->sk->sk_callback_lock);
 
-	/* done under the callback_lock to serialize with write_space */
+	/* done under the callback_lock to serialize with write_space.
+	 * Set t_sock inside rds_tcp_tc_list_lock so readers walking
+	 * rds_tcp_tc_list under the same lock cannot observe an
+	 * entry whose t_sock is NULL.
+	 */
 	spin_lock(&rds_tcp_tc_list_lock);
+	tc->t_sock = sock;
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	/* accepted sockets need our listen data ready undone */
 	if (sock->sk->sk_data_ready == rds_tcp_listen_data_ready)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
-
-	tc->t_sock = sock;
 	tc->t_cpath = cp;
 	tc->t_orig_data_ready = sock->sk->sk_data_ready;
 	tc->t_orig_write_space = sock->sk->sk_write_space;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c0bdeb522cfc..0f3285916ea9 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -137,9 +137,10 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 {
 	struct tcf_idrinfo *idrinfo = p->idrinfo;
 
-	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
-		if (bind)
-			atomic_dec(&p->tcfa_bindcnt);
+	mutex_lock(&idrinfo->lock);
+	if (bind)
+		atomic_dec(&p->tcfa_bindcnt);
+	if (refcount_dec_and_test(&p->tcfa_refcnt)) {
 		idr_remove(&idrinfo->action_idr, p->tcfa_index);
 		mutex_unlock(&idrinfo->lock);
 
@@ -147,9 +148,7 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 		return 1;
 	}
 
-	if (bind)
-		atomic_dec(&p->tcfa_bindcnt);
-
+	mutex_unlock(&idrinfo->lock);
 	return 0;
 }
 
@@ -807,19 +806,14 @@ EXPORT_SYMBOL(tcf_action_exec);
 
 int tcf_action_destroy(struct tc_action *actions[], int bind)
 {
-	const struct tc_action_ops *ops;
 	struct tc_action *a;
 	int ret = 0, i;
 
 	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
 		a = actions[i];
 		actions[i] = NULL;
-		ops = a->ops;
-		ret = __tcf_idr_release(a, bind, true);
-		if (ret == ACT_P_DELETED)
-			module_put(ops->owner);
-		else if (ret < 0)
-			return ret;
+		/* Drop our reference even if the action is still bound to a filter. */
+		ret = tcf_idr_release(a, bind);
 	}
 	return ret;
 }
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ace3e9e4626c..abe45d7a6c13 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2155,7 +2155,20 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 errout:
-	if (err && tp_state == TP_CREATED)
+	if (err && !IS_ERR_OR_NULL(tp) &&
+	    (tp_state == TP_CREATED || tp->ops->delete_empty))
+		/*
+		 * The request is dropping its reference to tp. If it was
+		 * the last user (the idr is empty now), reclaim the proto.
+		 * A tp this request created is reclaimed unconditionally:
+		 * it is the only owner, so marking it for deletion is
+		 * safe. Otherwise only classifiers with a delete_empty
+		 * callback are reclaimed -- the callback admits an empty
+		 * proto only, so a live shared proto is never unlinked.
+		 * Classifiers without one (deleting is set
+		 * unconditionally) are rtnl-serialized, so the raced
+		 * window this guard closes cannot arise for them.
+		 */
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index b01077820665..d4fa6fe2560f 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1412,6 +1412,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			return -EINVAL;
 		}
 		nla_opt_msk = nla_next(nla_opt_msk, &msk_depth);
+
+		if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
+			NL_SET_ERR_MSG(extack, "A mask attribute is invalid");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 23f9e2b5f3b6..cb4d2bfd03d2 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -709,8 +709,23 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+static void u32_unbind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			      struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID])
+		tcf_unbind_filter(tp, &n->res);
+}
+
+static void u32_bind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			    unsigned long base, struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID]) {
+		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
+		tcf_bind_filter(tp, &n->res, base);
+	}
+}
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
-			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags,
 			 struct netlink_ext_ack *extack)
@@ -756,10 +771,6 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		if (ht_old)
 			ht_old->refcnt--;
 	}
-	if (tb[TCA_U32_CLASSID]) {
-		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
-		tcf_bind_filter(tp, &n->res, base);
-	}
 
 	if (ifindex >= 0)
 		n->ifindex = ifindex;
@@ -898,7 +909,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
+		err = u32_set_parms(net, tp, new, tb,
 				    tca[TCA_RATE], flags, extack);
 
 		if (err) {
@@ -906,8 +917,12 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 			return err;
 		}
 
+		u32_bind_filter(tp, new, base, tb);
+
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			u32_unbind_filter(tp, new, tb);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1108,15 +1123,18 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE], flags,
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE], flags,
 			    extack);
+
+	u32_bind_filter(tp, n, base, tb);
+
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1134,7 +1152,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	u32_unbind_filter(tp, n, tb);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
@@ -1298,6 +1318,9 @@ static void u32_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
 {
 	struct tc_u_knode *n = fh;
 
+	if (TC_U32_KEY(n->handle) == 0)
+		return;
+
 	if (n && n->res.classid == classid) {
 		if (cl)
 			__tcf_bind_filter(q, &n->res, base);
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index f176afb70559..1df4d16f44f3 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -51,6 +51,9 @@ static int em_text_change(struct net *net, void *data, int len,
 	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
 		return -EINVAL;
 
+	if (!memchr(conf->algo, '\0', sizeof(conf->algo)))
+		return -EINVAL;
+
 	if (conf->from_layer > conf->to_layer)
 		return -EINVAL;
 
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 9e4e9b1a7ed8..31f601beb0f0 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -231,7 +231,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 	codel_params_init(&q->params);
 	codel_vars_init(&q->vars);
 	codel_stats_init(&q->stats);
-	q->params.mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
+	q->params.mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), 1 << 20);
 
 	if (opt) {
 		int err = codel_change(sch, opt, extack);
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index f801b6af33c0..bfb7d77c294a 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -499,8 +499,8 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 	q->flows_cnt = 1024;
 	q->memory_limit = 32 << 20; /* 32 MBytes */
 	q->drop_batch_size = 64;
-	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, FQ_CODEL_QUANTUM_MAX);
-	q->quantum = mtu;
+	mtu = min_t(u32, psched_mtu(qdisc_dev(sch)), FQ_CODEL_QUANTUM_MAX);
+	q->quantum = clamp_t(u32, mtu, 256, FQ_CODEL_QUANTUM_MAX);
 	INIT_LIST_HEAD(&q->new_flows);
 	INIT_LIST_HEAD(&q->old_flows);
 	codel_params_init(&q->cparams);
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 1f354cffb998..acd0eb5b4271 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -206,8 +206,10 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 	chunk->chunk_end = ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
 	skb_pull(chunk->skb, sizeof(*ch));
 	chunk->subh.v = NULL; /* Subheader is no longer valid.  */
-
-	if (chunk->chunk_end + sizeof(*ch) <= skb_tail_pointer(chunk->skb)) {
+	if (unlikely(ntohs(ch->length) < sizeof(*ch))) {
+		chunk->pdiscard = 1;
+	} else if (chunk->chunk_end + sizeof(*ch) <=
+		   skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton = 0;
 	} else if (chunk->chunk_end > skb_tail_pointer(chunk->skb)) {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 3dc0b3a7e2c4..e2b0d2ce380e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1783,6 +1783,18 @@ static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
 	return 1;
 }
 
+static int sctp_sendmsg_check_stream(struct sctp_association *asoc,
+				     struct sctp_sndrcvinfo *sinfo)
+{
+	if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt))
+		return -EINVAL;
+
+	if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext))
+		return sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_stream);
+
+	return 0;
+}
+
 static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 				struct msghdr *msg, size_t msg_len,
 				struct sctp_transport *transport,
@@ -1797,16 +1809,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 	long timeo;
 	int err;
 
-	if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
-		err = -EINVAL;
+	err = sctp_sendmsg_check_stream(asoc, sinfo);
+	if (err)
 		goto err;
-	}
-
-	if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
-		err = sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_stream);
-		if (err)
-			goto err;
-	}
 
 	if (sp->disable_fragments && msg_len > asoc->frag_point) {
 		err = -EMSGSIZE;
@@ -1830,10 +1835,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
-		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
-			err = -EINVAL;
+		err = sctp_sendmsg_check_stream(asoc, sinfo);
+		if (err)
 			goto err;
-		}
 	}
 
 	if (sctp_state(asoc, CLOSED)) {
@@ -1844,6 +1848,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 		if (asoc->ep->intl_enable) {
 			timeo = sock_sndtimeo(sk, 0);
 			err = sctp_wait_for_connect(asoc, &timeo);
+			if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
+				err = -ESRCH;
+				goto err;
+			}
+			err = sctp_sendmsg_check_stream(asoc, sinfo);
 			if (err) {
 				err = -ESRCH;
 				goto err;
@@ -7516,11 +7525,7 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 		/* Not allocated yet, means all stats are 0 */
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-		retval = 0;
-		goto out;
-	}
-
-	if (policy == SCTP_PR_SCTP_ALL) {
+	} else if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
 		for (policy = 0; policy <= SCTP_PR_INDEX(MAX); policy++) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1fa44d64958c..1d642e0df1da 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2291,6 +2291,7 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
 		       int peer)
 {
 	struct smc_sock *smc;
+	int rc = -EBADF;
 
 	if (peer && (sock->sk->sk_state != SMC_ACTIVE) &&
 	    (sock->sk->sk_state != SMC_APPCLOSEWAIT1))
@@ -2298,7 +2299,11 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
 
 	smc = smc_sk(sock->sk);
 
-	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock)
+		rc = smc->clcsock->ops->getname(smc->clcsock, addr, peer);
+	mutex_unlock(&smc->clcsock_release_lock);
+	return rc;
 }
 
 static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 5dbe6f7c019a..4a001afebeea 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -511,12 +511,16 @@ void strp_unpause(struct strparser *strp)
 EXPORT_SYMBOL_GPL(strp_unpause);
 
 /* strp must already be stopped so that strp_recv will no longer be called.
- * Note that strp_done is not called with the lower socket held.
+ * Note that strp_done must not be called with the lower socket held.
  */
 void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
+	lock_sock(strp->sk);
+	/* sync with pending strp_recv */
+	release_sock(strp->sk);
+
 	cancel_delayed_work_sync(&strp->msg_timer_work);
 	cancel_work_sync(&strp->work);
 
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index ee91f4d641e6..967943ae61c6 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -222,7 +222,8 @@ static int gssx_dec_linux_creds(struct xdr_stream *xdr,
 
 	return 0;
 out_free_groups:
-	groups_free(creds->cr_group_info);
+	put_group_info(creds->cr_group_info);
+	creds->cr_group_info = NULL;
 	return err;
 }
 
@@ -230,6 +231,7 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 				 struct gssx_option_array *oa)
 {
 	struct svc_cred *creds;
+	bool creds_decoded = false;
 	u32 count, i;
 	__be32 *p;
 	int err;
@@ -242,12 +244,12 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 		return 0;
 
 	/* we recognize only 1 currently: CREDS_VALUE */
-	oa->count = 1;
-
 	oa->data = kmalloc(sizeof(struct gssx_option), GFP_KERNEL);
 	if (!oa->data)
 		return -ENOMEM;
 
+	oa->count = 1;
+
 	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
 	if (!creds) {
 		err = -ENOMEM;
@@ -280,9 +282,14 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 		if (length == sizeof(CREDS_VALUE) &&
 		    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
 			/* We have creds here. parse them */
+			if (creds_decoded) {
+				err = -EINVAL;
+				goto free_creds;
+			}
 			err = gssx_dec_linux_creds(xdr, creds);
 			if (err)
 				goto free_creds;
+			creds_decoded = true;
 			oa->data[0].value.len = 1; /* presence */
 		} else {
 			/* consume uninteresting buffer */
@@ -294,8 +301,10 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 	return 0;
 
 free_creds:
+	free_svc_cred(creds);
 	kfree(creds);
 free_oa:
+	oa->count = 0;
 	kfree(oa->data);
 	oa->data = NULL;
 	return err;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index dd7e8fad4213..a83f1638a45c 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -144,7 +144,7 @@ struct tipc_tfm {
  * @rcu: struct rcu_head
  * @key: the aead key
  * @gen: the key's generation
- * @seqno: the key seqno (cluster scope)
+ * @seqno: the per-key TX nonce counter
  * @refcnt: the key reference counter
  */
 struct tipc_aead {
@@ -190,7 +190,6 @@ struct tipc_crypto_stats {
  * @rekeying_intv: rekeying interval (in minutes)
  * @stats: the crypto statistics
  * @name: the crypto name
- * @sndnxt: the per-peer sndnxt (TX)
  * @timer1: general timer 1 (jiffies)
  * @timer2: general timer 2 (jiffies)
  * @working: the crypto is working or not
@@ -219,7 +218,6 @@ struct tipc_crypto {
 	struct tipc_crypto_stats __percpu *stats;
 	char name[48];
 
-	atomic64_t sndnxt ____cacheline_aligned;
 	unsigned long timer1;
 	unsigned long timer2;
 	union {
@@ -1071,14 +1069,11 @@ static int tipc_ehdr_build(struct net *net, struct tipc_aead *aead,
 	WARN_ON(skb_headroom(skb) < ehsz);
 	ehdr = (struct tipc_ehdr *)skb_push(skb, ehsz);
 
-	/* Obtain a seqno first:
-	 * Use the key seqno (= cluster wise) if dest is unknown or we're in
-	 * cluster key mode, otherwise it's better for a per-peer seqno!
+	/*
+	 * Keep the nonce unique for the lifetime of the TX key,
+	 * including key state changes and peer reconnection.
 	 */
-	if (!__rx || aead->mode == CLUSTER_KEY)
-		seqno = atomic64_inc_return(&aead->seqno);
-	else
-		seqno = atomic64_inc_return(&__rx->sndnxt);
+	seqno = atomic64_inc_return(&aead->seqno);
 
 	/* Revoke the key if seqno is wrapped around */
 	if (unlikely(!seqno))
@@ -1257,7 +1252,6 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 	tipc_crypto_key_set_state(c, 0, 0, 0);
 	for (k = KEY_MIN; k <= KEY_MAX; k++)
 		tipc_crypto_key_detach(c->aead[k], &c->lock);
-	atomic64_set(&c->sndnxt, 0);
 	spin_unlock_bh(&c->lock);
 }
 
@@ -1404,8 +1398,6 @@ static struct tipc_aead *tipc_crypto_key_pick_tx(struct tipc_crypto *tx,
  * It also considers if peer has no key, then we need to make own master key
  * (if any) taking over i.e. starting grace period and also trigger key
  * distributing process.
- *
- * The "per-peer" sndnxt is also reset when the peer key has switched.
  */
 static void tipc_crypto_key_synch(struct tipc_crypto *rx, struct sk_buff *skb)
 {
@@ -1456,7 +1448,6 @@ static void tipc_crypto_key_synch(struct tipc_crypto *rx, struct sk_buff *skb)
 		if (cur)
 			tipc_aead_users_dec(tx->aead[cur], 0);
 
-		atomic64_set(&rx->sndnxt, 0);
 		/* Mark the point TX key users changed */
 		tx->timer1 = jiffies;
 
@@ -1521,7 +1512,6 @@ int tipc_crypto_start(struct tipc_crypto **crypto, struct net *net,
 	tipc_crypto_key_set_state(c, 0, 0, 0);
 	atomic_set(&c->key_distr, 0);
 	atomic_set(&c->peer_rx_active, 0);
-	atomic64_set(&c->sndnxt, 0);
 	c->timer1 = jiffies;
 	c->timer2 = jiffies;
 	c->rekeying_intv = TIPC_REKEYING_INTV_DEF;
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 256904240987..e27e70c6366c 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1335,7 +1335,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_write_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_write_unlock_fast(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
@@ -2421,8 +2423,11 @@ static struct tipc_node *tipc_node_find_by_name(struct net *net,
 			}
 		}
 		tipc_node_read_unlock(n);
-		if (found_node)
+		if (found_node) {
+			if (!kref_get_unless_zero(&found_node->kref))
+				found_node = NULL;
 			break;
+		}
 	}
 	rcu_read_unlock();
 
@@ -2507,6 +2512,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struct genl_info *info)
 	tipc_node_read_unlock(node);
 	tipc_bearer_xmit(net, bearer_id, &xmitq, &node->links[bearer_id].maddr,
 			 NULL);
+	tipc_node_put(node);
 	return res;
 }
 
@@ -2558,12 +2564,14 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 		link = node->links[bearer_id].link;
 		if (!link) {
 			tipc_node_read_unlock(node);
+			tipc_node_put(node);
 			err = -EINVAL;
 			goto err_free;
 		}
 
 		err = __tipc_nl_add_link(net, &msg, link, 0);
 		tipc_node_read_unlock(node);
+		tipc_node_put(node);
 		if (err)
 			goto err_free;
 	}
@@ -2634,11 +2642,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
 	if (!link) {
 		spin_unlock_bh(&le->lock);
 		tipc_node_read_unlock(node);
+		tipc_node_put(node);
 		return -EINVAL;
 	}
 	tipc_link_reset_stats(link);
 	spin_unlock_bh(&le->lock);
 	tipc_node_read_unlock(node);
+	tipc_node_put(node);
 	return 0;
 }
 
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 0445c91db009..435fa14468e4 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -54,7 +54,7 @@
 /**
  * struct tipc_topsrv - TIPC server structure
  * @conn_idr: identifier set of connection
- * @idr_lock: protect the connection identifier set
+ * @idr_lock: protect the connection identifier set and listener
  * @idr_in_use: amount of allocated identifier entry
  * @net: network namspace instance
  * @awork: accept work item
@@ -217,6 +217,10 @@ static struct tipc_conn *tipc_conn_lookup(struct tipc_topsrv *s, int conid)
 	struct tipc_conn *con;
 
 	spin_lock_bh(&s->idr_lock);
+	if (!s->listener) {
+		spin_unlock_bh(&s->idr_lock);
+		return NULL;
+	}
 	con = idr_find(&s->conn_idr, conid);
 	if (!connected(con) || !kref_get_unless_zero(&con->kref))
 		con = NULL;
@@ -300,10 +304,20 @@ static void tipc_conn_send_to_sock(struct tipc_conn *con)
 static void tipc_conn_send_work(struct work_struct *work)
 {
 	struct tipc_conn *con = container_of(work, struct tipc_conn, swork);
+	struct tipc_topsrv *srv;
+
+	srv = con->server;
+	spin_lock_bh(&srv->idr_lock);
+	if (!srv->listener) {
+		spin_unlock_bh(&srv->idr_lock);
+		goto out;
+	}
+	spin_unlock_bh(&srv->idr_lock);
 
 	if (connected(con))
 		tipc_conn_send_to_sock(con);
 
+out:
 	conn_put(con);
 }
 
@@ -333,8 +347,14 @@ void tipc_topsrv_queue_evt(struct net *net, int conid,
 	list_add_tail(&e->list, &con->outqueue);
 	spin_unlock_bh(&con->outqueue_lock);
 
-	if (queue_work(srv->send_wq, &con->swork))
-		return;
+	spin_lock_bh(&srv->idr_lock);
+	if (srv->listener) {
+		if (queue_work(srv->send_wq, &con->swork)) {
+			spin_unlock_bh(&srv->idr_lock);
+			return;
+		}
+	}
+	spin_unlock_bh(&srv->idr_lock);
 err:
 	conn_put(con);
 }
@@ -345,14 +365,20 @@ void tipc_topsrv_queue_evt(struct net *net, int conid,
  */
 static void tipc_conn_write_space(struct sock *sk)
 {
+	struct tipc_topsrv *srv;
 	struct tipc_conn *con;
 
 	read_lock_bh(&sk->sk_callback_lock);
 	con = sk->sk_user_data;
 	if (connected(con)) {
-		conn_get(con);
-		if (!queue_work(con->server->send_wq, &con->swork))
-			conn_put(con);
+		srv = con->server;
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener) {
+			conn_get(con);
+			if (!queue_work(srv->send_wq, &con->swork))
+				conn_put(con);
+		}
+		spin_unlock_bh(&srv->idr_lock);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -417,8 +443,17 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 static void tipc_conn_recv_work(struct work_struct *work)
 {
 	struct tipc_conn *con = container_of(work, struct tipc_conn, rwork);
+	struct tipc_topsrv *srv;
 	int count = 0;
 
+	srv = con->server;
+	spin_lock_bh(&srv->idr_lock);
+	if (!srv->listener) {
+		spin_unlock_bh(&srv->idr_lock);
+		goto out;
+	}
+	spin_unlock_bh(&srv->idr_lock);
+
 	while (connected(con)) {
 		if (tipc_conn_rcv_from_sock(con))
 			break;
@@ -429,6 +464,7 @@ static void tipc_conn_recv_work(struct work_struct *work)
 			count = 0;
 		}
 	}
+out:
 	conn_put(con);
 }
 
@@ -437,14 +473,20 @@ static void tipc_conn_recv_work(struct work_struct *work)
  */
 static void tipc_conn_data_ready(struct sock *sk)
 {
+	struct tipc_topsrv *srv;
 	struct tipc_conn *con;
 
 	read_lock_bh(&sk->sk_callback_lock);
 	con = sk->sk_user_data;
 	if (connected(con)) {
-		conn_get(con);
-		if (!queue_work(con->server->rcv_wq, &con->rwork))
-			conn_put(con);
+		srv = con->server;
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener) {
+			conn_get(con);
+			if (!queue_work(srv->rcv_wq, &con->rwork))
+				conn_put(con);
+		}
+		spin_unlock_bh(&srv->idr_lock);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -498,8 +540,12 @@ static void tipc_topsrv_listener_data_ready(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	srv = sk->sk_user_data;
-	if (srv)
-		queue_work(srv->rcv_wq, &srv->awork);
+	if (srv) {
+		spin_lock_bh(&srv->idr_lock);
+		if (srv->listener)
+			queue_work(srv->rcv_wq, &srv->awork);
+		spin_unlock_bh(&srv->idr_lock);
+	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -695,23 +741,27 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_conn *con;
 	int id;
 
+	spin_lock_bh(&srv->idr_lock);
+	srv->listener = NULL;
+	spin_unlock_bh(&srv->idr_lock);
+	tipc_topsrv_work_stop(srv);
+
 	spin_lock_bh(&srv->idr_lock);
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
 		if (con) {
-			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
 			tipc_conn_close(con);
-			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
+			continue;
 		}
+		spin_unlock_bh(&srv->idr_lock);
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-	srv->listener = NULL;
 	spin_unlock_bh(&srv->idr_lock);
 
-	tipc_topsrv_work_stop(srv);
 	sock_release(lsock);
 	idr_destroy(&srv->conn_idr);
 	kfree(srv);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 10f7b35673bc..636e10667905 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -224,7 +224,7 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 	int err = 0;
 	u8 *rcd_sn;
 
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
@@ -493,7 +493,8 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) {
+			if ((flags & (MSG_SENDPAGE_NOTLAST | MSG_MORE)) &&
+			    record->num_frags < MAX_SKB_FRAGS - 1) {
 				more = true;
 				break;
 			}
@@ -1107,7 +1108,7 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	 * SKBs where only part of the payload needs to be encrypted.
 	 * So mark the last skb in the write queue as end of record.
 	 */
-	skb = tcp_write_queue_tail(sk);
+	skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 972e00d987a0..0712c8339f92 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -328,6 +328,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
+/**
+ * vsock_check_source - validate a packet source against a socket peer
+ * @vsk: socket receiving the packet
+ * @transport: transport receiving the packet
+ * @src: source address from the packet
+ *
+ * Return: true if the packet arrived on the socket's assigned transport and
+ * its source matches the stored peer. Loopback packets are generated
+ * internally and always use the local CID as their source, including
+ * connections using a valid CID alias.
+ *
+ * The caller must hold the socket lock and must not call this for listening
+ * sockets, which accept packets from any source and have no assigned
+ * transport.
+ */
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src)
+{
+	if (vsk->transport != transport)
+		return false;
+
+	if (src->svm_port != vsk->remote_addr.svm_port)
+		return false;
+
+	if (src->svm_cid == vsk->remote_addr.svm_cid)
+		return true;
+
+	return transport->get_local_cid() == VMADDR_CID_LOCAL;
+}
+EXPORT_SYMBOL_GPL(vsock_check_source);
+
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
 	/* Transport reassignment must not remove the binding. */
@@ -1493,23 +1525,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		/* Connection established. Whatever happens to socket once we
-		 * release it, that's not connect()'s concern. No need to go
+		/* Connection was established. Whatever happens to socket once
+		 * we release it, that's not connect()'s concern. No need to go
 		 * into signal and timeout handling. Call it a day.
 		 *
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			break;
+		if (sk->sk_state == TCP_ESTABLISHED ||
+		    sk->sk_state == TCP_CLOSING) {
+			err = 0;
+			goto out_wait;
+		}
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
-		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
+		 * to retry, so we keep the binding and the transport assigned.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 12eb365c1603..9216ffe6a88a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1320,7 +1320,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, pkt);
 		release_sock(sk);
 		sock_put(sk);
diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 1b4d6c87a5c5..823274728711 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -38,6 +38,7 @@ MODULE_DESCRIPTION("lib80211 crypt: TKIP");
 MODULE_LICENSE("GPL");
 
 #define TKIP_HDR_LEN 8
+#define MICHAEL_MIC_LEN 8
 
 struct lib80211_tkip_data {
 #define TKIP_KEY_LEN 32
@@ -585,16 +586,18 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 					int hdr_len, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
-	u8 mic[8];
+	u8 mic[MICHAEL_MIC_LEN];
 
-	if (!tkey->key_set)
+	if (!tkey->key_set || skb->len < hdr_len + MICHAEL_MIC_LEN)
 		return -1;
 
 	michael_mic_hdr(skb, tkey->rx_hdr);
 	if (michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
-			skb->data + hdr_len, skb->len - 8 - hdr_len, mic))
+			skb->data + hdr_len,
+			skb->len - MICHAEL_MIC_LEN - hdr_len, mic))
 		return -1;
-	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
+	if (memcmp(mic, skb->data + skb->len - MICHAEL_MIC_LEN,
+		   MICHAEL_MIC_LEN) != 0) {
 		struct ieee80211_hdr *hdr;
 		hdr = (struct ieee80211_hdr *)skb->data;
 		printk(KERN_DEBUG "%s: Michael MIC verification failed for "
@@ -612,7 +615,7 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	tkey->rx_iv32 = tkey->rx_iv32_new;
 	tkey->rx_iv16 = tkey->rx_iv16_new;
 
-	skb_trim(skb, skb->len - 8);
+	skb_trim(skb, skb->len - MICHAEL_MIC_LEN);
 
 	return 0;
 }
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 5063f43cceda..bd1f702edada 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1767,20 +1767,22 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			return false;
 		}
 
-		old = rcu_access_pointer(known->pub.beacon_ies);
+		if (!new->pub.hidden_beacon_bss) {
+			old = rcu_access_pointer(known->pub.beacon_ies);
 
-		rcu_assign_pointer(known->pub.beacon_ies, new->pub.beacon_ies);
+			rcu_assign_pointer(known->pub.beacon_ies, new->pub.beacon_ies);
 
-		/* Override IEs if they were from a beacon before */
-		if (old == rcu_access_pointer(known->pub.ies))
-			rcu_assign_pointer(known->pub.ies, new->pub.beacon_ies);
+			/* Override IEs if they were from a beacon before */
+			if (old == rcu_access_pointer(known->pub.ies))
+				rcu_assign_pointer(known->pub.ies, new->pub.beacon_ies);
 
-		cfg80211_update_hidden_bsses(known,
-					     rcu_access_pointer(new->pub.beacon_ies),
-					     old);
+			cfg80211_update_hidden_bsses(known,
+						     rcu_access_pointer(new->pub.beacon_ies),
+						     old);
 
-		if (old)
-			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+			if (old)
+				kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+		}
 	}
 
 	known->pub.beacon_interval = new->pub.beacon_interval;
@@ -2756,10 +2758,9 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 
 	if (new) {
 		/* to save time, update IEs for transmitting bss only */
-		if (cfg80211_update_known_bss(rdev, cbss, new, false)) {
-			new->pub.proberesp_ies = NULL;
-			new->pub.beacon_ies = NULL;
-		}
+		cfg80211_update_known_bss(rdev, cbss, new, false);
+		new->pub.proberesp_ies = NULL;
+		new->pub.beacon_ies = NULL;
 
 		list_for_each_entry_safe(nontrans_bss, tmp,
 					 &new->pub.nontrans_list,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 536b945e1eeb..15d50b5a22ef 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1378,7 +1378,10 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 
 void xfrm_policy_hash_rebuild(struct net *net)
 {
-	schedule_work(&net->xfrm.policy_hthresh.work);
+	write_seqlock(&net->xfrm.policy_hthresh.lock);
+	if (!net->xfrm.policy_hthresh.work_disabled)
+		schedule_work(&net->xfrm.policy_hthresh.work);
+	write_sequnlock(&net->xfrm.policy_hthresh.lock);
 }
 EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
 
@@ -4088,6 +4091,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 	net->xfrm.policy_hthresh.rbits6 = 128;
 
 	seqlock_init(&net->xfrm.policy_hthresh.lock);
+	net->xfrm.policy_hthresh.work_disabled = false;
 
 	INIT_LIST_HEAD(&net->xfrm.policy_all);
 	INIT_LIST_HEAD(&net->xfrm.inexact_bins);
@@ -4113,6 +4117,19 @@ static void xfrm_policy_fini(struct net *net)
 	unsigned int sz;
 	int dir;
 
+	/* Prevent new policy hash rebuilds before draining the work item.
+	 *
+	 * The upstream fix uses disable_work_sync(), which is unavailable
+	 * in v5.15. Protecting work_disabled and schedule_work() with the
+	 * same seqlock closes the check-to-queue race, while the subsequent
+	 * cancel_work_sync() drains work that was queued or running before
+	 * teardown disabled it.
+	 */
+	write_seqlock(&net->xfrm.policy_hthresh.lock);
+	net->xfrm.policy_hthresh.work_disabled = true;
+	write_sequnlock(&net->xfrm.policy_hthresh.lock);
+	cancel_work_sync(&net->xfrm.policy_hthresh.work);
+
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
diff --git a/samples/pidfd/Makefile b/samples/pidfd/Makefile
index 9754e2d81f70..d82409f7061f 100644
--- a/samples/pidfd/Makefile
+++ b/samples/pidfd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-usertprogs-always-y += pidfd-metadata
+userprogs-always-y += pidfd-metadata
 
 userccflags += -I usr/include
diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 55986388dfae..a987bd117d88 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -22,7 +22,7 @@ struct aa_ns;
 
 #define LOCAL_VEC_ENTRIES 8
 #define DEFINE_VEC(T, V)						\
-	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES];	\
+	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES + 1];	\
 	struct aa_ ## T **(V)
 
 #define vec_setup(T, V, N, GFP)						\
@@ -30,10 +30,10 @@ struct aa_ns;
 	if ((N) <= LOCAL_VEC_ENTRIES) {					\
 		typeof(N) i;						\
 		(V) = (_ ## V ## _localtmp);				\
-		for (i = 0; i < (N); i++)				\
+		for (i = 0; i <= (N); i++)				\
 			(V)[i] = NULL;					\
 	} else								\
-		(V) = kzalloc(sizeof(struct aa_ ## T *) * (N), (GFP));	\
+		(V) = kcalloc((N) + 1, sizeof(struct aa_ ## T *), (GFP)); \
 	(V) ? 0 : -ENOMEM;						\
 })
 
diff --git a/security/keys/key.c b/security/keys/key.c
index f2a84d86eab4..e671876619fc 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -586,11 +586,18 @@ int key_reject_and_link(struct key *key,
 	ret = -EBUSY;
 
 	if (keyring) {
-		if (keyring->restrict_link)
-			return -EPERM;
-
 		link_ret = __key_link_lock(keyring, &key->index_key);
 		if (link_ret == 0) {
+			/*
+			 * Check the restriction under the keyring semaphore.
+			 * keyring_restrict() installs it while holding the
+			 * semaphore, so testing it beforehand races with a
+			 * concurrent restriction install.
+			 */
+			if (keyring->restrict_link) {
+				__key_link_end(keyring, &key->index_key, edit);
+				return -EPERM;
+			}
 			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
@@ -845,9 +852,6 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	key_check(keyring);
 
-	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
-		restrict_link = keyring->restrict_link;
-
 	key_ref = ERR_PTR(-ENOTDIR);
 	if (keyring->type != &key_type_keyring)
 		goto error_put_type;
@@ -885,6 +889,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
+		restrict_link = keyring->restrict_link;
+
 	if (restrict_link && restrict_link->check) {
 		ret = restrict_link->check(keyring, index_key.type,
 					   &prep.payload, restrict_link->key);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 127c17191785..e9fa1b94d0d0 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
@@ -806,8 +808,12 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
 
 	down_read(&key->sem);
 	ret = key_validate(key);
-	if (ret == 0)
-		ret = key->type->read(key, buffer, buflen);
+	if (ret == 0) {
+		if (key->type->read)
+			ret = key->type->read(key, buffer, buflen);
+		else
+			ret = -EOPNOTSUPP;
+	}
 	up_read(&key->sem);
 	return ret;
 }
@@ -861,11 +867,6 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
-	if (!key->type->read) {
-		ret = -EOPNOTSUPP;
-		goto key_put_out;
-	}
-
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
 		ret = __keyctl_read_key(key, NULL, 0);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index fc26d339a962..83fa6f0a54d4 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
 #include <keys/keyring-type.h>
 #include <keys/user-type.h>
 #include <linux/assoc_array_priv.h>
@@ -147,49 +150,46 @@ static int keyring_instantiate(struct key *keyring,
 }
 
 /*
- * Multiply 64-bits by 32-bits to 96-bits and fold back to 64-bit.  Ideally we'd
- * fold the carry back too, but that requires inline asm.
+ * Give key types and domains address-independent identities.  Zero means that
+ * an ID has not yet been allocated.  As with inode sequence numbers used by
+ * futexes, this relies on the 64-bit counter not wrapping in a machine's
+ * lifetime.
  */
-static u64 mult_64x32_and_fold(u64 x, u32 y)
+static u64 key_index_id(atomic64_t *id)
 {
-	u64 hi = (u64)(u32)(x >> 32) * y;
-	u64 lo = (u64)(u32)(x) * y;
-	return lo + ((u64)(u32)hi << 32) + (u32)(hi >> 32);
+	static atomic64_t next_id;
+	u64 old, new;
+
+	old = atomic64_read(id);
+	if (likely(old))
+		return old;
+
+	do {
+		new = atomic64_inc_return(&next_id);
+	} while (WARN_ON_ONCE(!new));
+
+	old = 0;
+	if (!atomic64_try_cmpxchg_relaxed(id, &old, new))
+		return old;
+	return new;
 }
 
 /*
- * Hash a key type and description.
+ * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
+ * traversal order, so no part of the index may contain kernel addresses.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
-	const char *description = index_key->description;
-	unsigned long hash, type;
-	u32 piece;
+	static siphash_key_t hash_key __read_mostly;
+	unsigned long hash;
 	u64 acc;
-	int n, desc_len = index_key->desc_len;
-
-	type = (unsigned long)index_key->type;
-	acc = mult_64x32_and_fold(type, desc_len + 13);
-	acc = mult_64x32_and_fold(acc, 9207);
-	piece = (unsigned long)index_key->domain_tag;
-	acc = mult_64x32_and_fold(acc, piece);
-	acc = mult_64x32_and_fold(acc, 9207);
-
-	for (;;) {
-		n = desc_len;
-		if (n <= 0)
-			break;
-		if (n > 4)
-			n = 4;
-		piece = 0;
-		memcpy(&piece, description, n);
-		description += n;
-		desc_len -= n;
-		acc = mult_64x32_and_fold(acc, piece);
-		acc = mult_64x32_and_fold(acc, 9207);
-	}
+
+	get_random_once(&hash_key, sizeof(hash_key));
+	acc = siphash(index_key->description, index_key->desc_len, &hash_key);
+	acc = siphash_3u64(index_key->type_id, index_key->domain_id, acc,
+			   &hash_key);
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
@@ -209,7 +209,7 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 /*
  * Finalise an index key to include a part of the description actually in the
- * index key, to set the domain tag and to calculate the hash.
+ * index key, to set the domain tag and index IDs, and to calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
@@ -225,6 +225,14 @@ void key_set_index_key(struct keyring_index_key *index_key)
 			index_key->domain_tag = &default_domain_tag;
 	}
 
+	/* Preserve the IDs when copying an existing key's index.  In
+	 * particular, its type may already have been unregistered.
+	 */
+	if (!index_key->type_id)
+		index_key->type_id = key_index_id(&index_key->type->index_id);
+	if (!index_key->domain_id)
+		index_key->domain_id = key_index_id(&index_key->domain_tag->index_id);
+
 	hash_key_type_and_desc(index_key);
 }
 
@@ -263,15 +271,19 @@ void key_remove_domain(struct key_tag *domain_tag)
 /*
  * Build the next index key chunk.
  *
+ * The hash and inline description are followed by the 64-bit type and domain
+ * IDs, low word first, and then by the rest of the description.
  * We return it one word-sized chunk at a time.
  */
 static unsigned long keyring_get_key_chunk(const void *data, int level)
 {
+	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
 	const struct keyring_index_key *index_key = data;
+	int desc_len = index_key->desc_len;
 	unsigned long chunk = 0;
-	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int n = sizeof(chunk);
 	unsigned int offset;
+	const u8 *d;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -279,27 +291,30 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return index_key->hash;
 	case 1:
 		return index_key->x;
-	case 2:
-		return (unsigned long)index_key->type;
-	case 3:
-		return (unsigned long)index_key->domain_tag;
-	default:
-		level -= 4;
-		offset = sizeof(index_key->desc) + level * sizeof(long);
-		if (desc_len <= offset)
-			return 0;
-
-		d = index_key->description + offset;
-		desc_len -= offset;
-		if (desc_len > n)
-			desc_len = n;
-		d += desc_len;
-		do {
-			chunk <<= 8;
-			chunk |= *--d;
-		} while (--desc_len > 0);
-		return chunk;
 	}
+
+	level -= 2;
+	if (level < id_chunks)
+		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+	if (level < id_chunks)
+		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+
+	offset = sizeof(index_key->desc) + level * sizeof(long);
+	if (desc_len <= offset)
+		return 0;
+
+	d = index_key->description + offset;
+	desc_len -= offset;
+	if (desc_len > n)
+		desc_len = n;
+	d += desc_len;
+	do {
+		chunk <<= 8;
+		chunk |= *--d;
+	} while (--desc_len > 0);
+	return chunk;
 }
 
 static unsigned long keyring_get_object_key_chunk(const void *object, int level)
@@ -331,6 +346,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	const struct keyring_index_key *b = data;
 	unsigned long seg_a, seg_b;
 	int level, i;
+	u64 diff;
 
 	level = 0;
 	seg_a = a->hash;
@@ -339,28 +355,22 @@ static int keyring_diff_objects(const void *object, const void *data)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
 
-	/* The number of bits contributed by the hash is controlled by a
-	 * constant in the assoc_array headers.  Everything else thereafter we
-	 * can deal with as being machine word-size dependent.
-	 */
+	/* The inline description contributes one machine-word-sized chunk. */
 	seg_a = a->x;
 	seg_b = b->x;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += sizeof(unsigned long);
 
-	/* The next bit may not work on big endian */
-	seg_a = (unsigned long)a->type;
-	seg_b = (unsigned long)b->type;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->type_id ^ b->type_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
-	seg_a = (unsigned long)a->domain_tag;
-	seg_b = (unsigned long)b->domain_tag;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->domain_id ^ b->domain_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
 	i = sizeof(a->desc);
 	if (a->desc_len <= i)
@@ -1105,6 +1115,7 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 {
 	struct key *keyring, *key;
 	const void *object;
+	guard(rcu)();
 
 	keyring = key_ref_to_ptr(keyring_ref);
 
@@ -1157,7 +1168,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, keyring->uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b2..bdab99539326 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -33,25 +33,31 @@ static int key_create_persistent_register(struct user_namespace *ns)
 }
 
 /*
- * Create the persistent keyring for the specified user.
+ * Get or create the persistent keyring for the specified user.
  *
  * Called with the namespace's sem locked for writing.
+ *
+ * Returns a boolean indicating whether the keyring already existed,
+ * or a negative error. On success, *persistent_ref holds a reference
+ * to the keyring.
  */
-static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
-				       struct keyring_index_key *index_key)
+static int key_get_or_create_persistent(struct user_namespace *ns, kuid_t uid,
+					struct keyring_index_key *index_key,
+					key_ref_t *persistent_ref)
 {
 	struct key *persistent;
-	key_ref_t reg_ref, persistent_ref;
+	key_ref_t reg_ref;
 
 	if (!ns->persistent_keyring_register) {
-		long err = key_create_persistent_register(ns);
+		int err = key_create_persistent_register(ns);
+
 		if (err < 0)
-			return ERR_PTR(err);
+			return err;
 	} else {
 		reg_ref = make_key_ref(ns->persistent_keyring_register, true);
-		persistent_ref = find_key_to_update(reg_ref, index_key);
-		if (persistent_ref)
-			return persistent_ref;
+		*persistent_ref = find_key_to_update(reg_ref, index_key);
+		if (*persistent_ref)
+			return 1;
 	}
 
 	persistent = keyring_alloc(index_key->description,
@@ -61,9 +67,10 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
 				   ns->persistent_keyring_register);
 	if (IS_ERR(persistent))
-		return ERR_CAST(persistent);
+		return PTR_ERR(persistent);
 
-	return make_key_ref(persistent, true);
+	*persistent_ref = make_key_ref(persistent, true);
+	return 0;
 }
 
 /*
@@ -78,6 +85,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	key_ref_t reg_ref, persistent_ref;
 	char buf[32];
 	long ret;
+	bool created = false;
 
 	/* Look in the register if it exists */
 	memset(&index_key, 0, sizeof(index_key));
@@ -100,23 +108,24 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	 * also need to create the register.
 	 */
 	down_write(&ns->keyring_sem);
-	persistent_ref = key_create_persistent(ns, uid, &index_key);
+	ret = key_get_or_create_persistent(ns, uid, &index_key,
+					   &persistent_ref);
 	up_write(&ns->keyring_sem);
-	if (!IS_ERR(persistent_ref))
-		goto found;
-
-	return PTR_ERR(persistent_ref);
+	if (ret < 0)
+		return ret;
+	created = ret == 0;
 
 found:
+	persistent = key_ref_to_ptr(persistent_ref);
 	ret = key_task_permission(persistent_ref, current_cred(), KEY_NEED_LINK);
-	if (ret == 0) {
-		persistent = key_ref_to_ptr(persistent_ref);
+	if (ret == 0)
 		ret = key_link(key_ref_to_ptr(dest_ref), persistent);
-		if (ret == 0) {
-			key_set_timeout(persistent, persistent_keyring_expiry);
-			ret = persistent->serial;
-		}
-	}
+
+	if (ret == 0 || created)
+		key_set_timeout(persistent, persistent_keyring_expiry);
+
+	if (ret == 0)
+		ret = persistent->serial;
 
 	key_ref_put(persistent_ref);
 	return ret;
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..4b2b8a75eb1f 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -556,9 +556,8 @@ key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
 	    ) {
 		const struct cred *cred = ctx->cred;
 
-		if (key_validate(cred->request_key_auth) == 0) {
-			rka = ctx->cred->request_key_auth->payload.data[0];
-
+		rka = dereference_key_rcu(cred->request_key_auth);
+		if (rka && key_validate(cred->request_key_auth) == 0) {
 			//// was search_process_keyrings() [ie. recursive]
 			ctx->cred = rka->cred;
 			key_ref = search_cred_keyrings_rcu(ctx);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 4863ee08b7b1..06a2b45ab6d8 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -959,8 +959,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = tpm2_unseal_trusted(chip, p, options);
 	else
 		ret = key_unseal(p, options);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("key_unseal failed (%d)\n", ret);
+		goto out;
+	}
 
 	if (options->pcrlock) {
 		ret = pcrlock(options->pcrlock);
@@ -1058,10 +1060,10 @@ static int __init trusted_tpm_init(void)
 static void trusted_tpm_exit(void)
 {
 	if (chip) {
+		unregister_key_type(&key_type_trusted);
 		put_device(&chip->dev);
 		kfree(digests);
 		trusted_shash_release();
-		unregister_key_type(&key_type_trusted);
 	}
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index bbd6ffb67cd6..ebd83cba18a7 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -124,7 +124,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 70eeed3e44c0..04efc9582c56 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -588,7 +588,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 		}
 	} else {
 		if (seqno > avc->avc_cache.latest_notif)
-			avc->avc_cache.latest_notif = seqno;
+			WRITE_ONCE(avc->avc_cache.latest_notif, seqno);
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -1191,7 +1191,8 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(struct selinux_state *state)
 {
-	return state->avc->avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(state->avc->avc_cache.latest_notif);
 }
 
 void avc_disable(void)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fa91dc75cdb5..dac313afa107 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -677,8 +677,12 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * will be used for both mounts)
 	 */
 	if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
-	    && !opts)
+		&& !opts) {
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
+		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		goto out;
+	}
 
 	root_isec = backing_inode_security_novalidate(root);
 
@@ -730,6 +734,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
+		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		rc = 0;
 		goto out;
 	}
diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index c0ce6236dc7f..65c385f3ef89 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -44,7 +44,9 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 		goto error;
 	data->kernel = NULL;
 
+	mutex_lock(&client->ioctl_mutex);
 	err = snd_seq_kernel_client_ctl(client->number, cmd, data);
+	mutex_unlock(&client->ioctl_mutex);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 0dc5381cdc39..ede7a94cf16a 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -798,7 +798,7 @@ static int adau1372_set_power(struct adau1372 *adau1372, bool enable)
 		if (ret)
 			return ret;
 		if (adau1372->pd_gpio)
-			gpiod_set_value(adau1372->pd_gpio, 0);
+			gpiod_set_value_cansleep(adau1372->pd_gpio, 0);
 
 		if (adau1372->switch_mode)
 			adau1372->switch_mode(adau1372->dev);
@@ -818,8 +818,7 @@ static int adau1372_set_power(struct adau1372 *adau1372, bool enable)
 							   ADAU1372_CLK_CTRL_PLL_EN,
 							   0);
 				regcache_cache_only(adau1372->regmap, true);
-				if (adau1372->pd_gpio)
-					gpiod_set_value(adau1372->pd_gpio, 1);
+				gpiod_set_value_cansleep(adau1372->pd_gpio, 1);
 				clk_disable_unprepare(adau1372->mclk);
 				return ret;
 			}
@@ -836,7 +835,7 @@ static int adau1372_set_power(struct adau1372 *adau1372, bool enable)
 			 * map. No need to do any register writes to manually
 			 * turn things off.
 			 */
-			gpiod_set_value(adau1372->pd_gpio, 1);
+			gpiod_set_value_cansleep(adau1372->pd_gpio, 1);
 			regcache_mark_dirty(adau1372->regmap);
 		} else {
 			regmap_update_bits(adau1372->regmap, ADAU1372_REG_CLK_CTRL,
@@ -1000,6 +999,17 @@ int adau1372_probe(struct device *dev, struct regmap *regmap,
 
 	regmap_write(regmap, ADAU1372_REG_OP_STAGE_MUTE, 0x0);
 
+	/*
+	 * Set sane default values for the Output ASRC and DAC input muxes,
+	 * since the power-on reset defaults are invalid "Reserved" states.
+	 */
+	regmap_write(regmap, ADAU1372_REG_ASRCO_SOURCE_0_1,
+		     0x54); /* Decimator0, Decimator1 */
+	regmap_write(regmap, ADAU1372_REG_ASRCO_SOURCE_2_3,
+		     0x76); /* Decimator2, Decimator3 */
+	regmap_write(regmap, ADAU1372_REG_DAC_SOURCE,
+		     0xdc); /* Input ASRC0, Input ASRC1 */
+
 	regmap_write(regmap, 0x7, 0x01); /* CLOCK OUT */
 
 	return  devm_snd_soc_register_component(dev, &adau1372_driver, &adau1372_dai_driver, 1);
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index c19ad3c24702..0a7957789bf2 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -273,7 +273,7 @@ static const char * const cs42l52_ng_type_text[] = {
 };
 
 static SOC_ENUM_SINGLE_DECL(ng_type_enum,
-			    CS42L52_NOISE_GATE_CTL, 6,
+			    CS42L52_NOISE_GATE_CTL, 7,
 			    cs42l52_ng_type_text);
 
 static const char * const left_swap_text[] = {
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index f0af8c18e5ef..7e75b98a4005 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -449,7 +449,7 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
 			0, 0x3f, 0, 0),
 	SOC_SINGLE_TLV("Limiter MAX", CS42L56_LIM_THRESHOLD_CTL,
 			5, 0x07, 1, alc_tlv),
-	SOC_SINGLE_TLV("Limiter Cushion", CS42L56_ALC_THRESHOLD,
+	SOC_SINGLE_TLV("Limiter Cushion", CS42L56_LIM_THRESHOLD_CTL,
 			2, 0x07, 1, alc_tlv),
 
 	SOC_SINGLE("NG Switch", CS42L56_NOISE_GATE_CTL, 6, 1, 1),
diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index e424779db02b..f0614c47f364 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -166,7 +166,7 @@ static const struct snd_kcontrol_new max98371_snd_controls[] = {
 			0, (1<<MAX98371_DHT_MAX_WIDTH)-1, 0,
 			max98371_dht_max_gain),
 	SOC_SINGLE_TLV("Speaker DHT Min Volume", MAX98371_DHT_GAIN,
-			0, (1<<MAX98371_DHT_GAIN_WIDTH)-1, 0,
+			4, (1<<MAX98371_DHT_GAIN_WIDTH)-1, 0,
 			max98371_dht_min_gain),
 	SOC_SINGLE_TLV("Speaker DHT Rotation Volume", MAX98371_DHT_GAIN,
 			0, (1<<MAX98371_DHT_ROT_WIDTH)-1, 0,
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 6ffd0f5e3a60..7273e0184768 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -379,9 +379,9 @@ static const struct snd_kcontrol_new nau8822_snd_controls[] = {
 		NAU8822_REG_RIGHT_ADC_BOOST_CONTROL, 0, 7, 0, boost_tlv),
 
 	SOC_SINGLE("DAC 128x Oversampling Switch",
-		NAU8822_REG_DAC_CONTROL, 5, 1, 0),
+		NAU8822_REG_DAC_CONTROL, 3, 1, 0),
 	SOC_SINGLE("ADC 128x Oversampling Switch",
-		NAU8822_REG_ADC_CONTROL, 5, 1, 0),
+		NAU8822_REG_ADC_CONTROL, 3, 1, 0),
 };
 
 /* LMAIN and RMAIN Mixer */
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 2aece113e7c0..b5e5cdb376c5 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -106,7 +106,7 @@ static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_func, PCM3168A_DAC_ATT_DEMP_ZF,
 static const char *const pcm3168a_pol[] = { "Active High", "Active Low" };
 
 static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_pol, PCM3168A_DAC_ATT_DEMP_ZF,
-		PCM3168A_DAC_ATSPDA_SHIFT, pcm3168a_pol);
+		PCM3168A_DAC_ZREV_SHIFT, pcm3168a_pol);
 
 static const char *const pcm3168a_con[] = { "Differential", "Single-Ended" };
 
diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 0d3773c576f8..db46a45b8bd2 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -619,9 +619,11 @@ static int rt274_hw_params(struct snd_pcm_substream *substream,
 	unsigned int val = 0;
 	int d_len_code = 0, c_len_code = 0;
 
+	/* bit 14 Sample Rate Base, 0: 48kHz 1: 44.1kHz */
 	switch (params_rate(params)) {
-	/* bit 14 0:48K 1:44.1K */
 	case 44100:
+		val |= BIT(14);
+		break;
 	case 48000:
 		break;
 	default:
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 75f30154c809..168d4f680a65 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -678,7 +678,7 @@ SOC_ENUM("DRC Decay Rate", drc_decay),
 SOC_ENUM("DRC FF Delay", drc_ff_delay),
 SOC_SINGLE("DRC Anticlip Switch", WM8903_DRC_0, 1, 1, 0),
 SOC_SINGLE("DRC QR Switch", WM8903_DRC_0, 2, 1, 0),
-SOC_SINGLE_TLV("DRC QR Threshold Volume", WM8903_DRC_0, 6, 3, 0, drc_tlv_max),
+SOC_SINGLE_TLV("DRC QR Threshold Volume", WM8903_DRC_1, 6, 3, 0, drc_tlv_max),
 SOC_ENUM("DRC QR Decay Rate", drc_qr_decay),
 SOC_SINGLE("DRC Smoothing Switch", WM8903_DRC_0, 3, 1, 0),
 SOC_SINGLE("DRC Smoothing Hysteresis Switch", WM8903_DRC_0, 0, 1, 0),
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 7091e1a9d516..8ec48019f5b8 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -255,9 +255,9 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 
 	/* DAC / ADC oversampling */
 	SOC_SINGLE("DAC 128x Oversampling Switch", WM8978_DAC_CONTROL,
-		   5, 1, 0),
+		   3, 1, 0),
 	SOC_SINGLE("ADC 128x Oversampling Switch", WM8978_ADC_CONTROL,
-		   5, 1, 0),
+		   3, 1, 0),
 };
 
 /* Mixer #1: Output (OUT1, OUT2) Mixer: mix AUX, Input mixer output and DAC */
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 17fc844182d8..1225438b21a6 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -967,8 +967,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 		if (drvdata->mi2s_playback_sd_mode[dai_id] ==
 			LPAIF_I2SCTL_MODE_QUAD01) {
-			variant->dai_driver[dai_id].playback.channels_min = 4;
-			variant->dai_driver[dai_id].playback.channels_max = 4;
+			variant->dai_driver[i].playback.channels_min = 4;
+			variant->dai_driver[i].playback.channels_max = 4;
 		}
 	}
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 309badc97290..b63d381d02ed 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1525,9 +1525,16 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		goto err_disable_pm;
 
 	priv->op_clk = clk_get_parent(priv->clk_table[CLK_I2S_RCLK_SRC]);
+	ret = clk_prepare_enable(priv->op_clk);
+	if (ret < 0) {
+		priv->op_clk = NULL;
+		goto err_unregister_clk;
+	}
 
 	return 0;
 
+err_unregister_clk:
+	i2s_unregister_clock_provider(priv);
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 err_del_sec:
@@ -1550,6 +1557,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 
 	i2s_unregister_clock_provider(priv);
 	i2s_delete_secondary_device(priv);
+	clk_disable_unprepare(priv->op_clk);
 	clk_disable_unprepare(priv->clk);
 
 	pm_runtime_put_noidle(&pdev->dev);
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 80f7761cbcb7..441e2a7c3daf 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -727,7 +727,7 @@ static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
 
 	if (err) {
 		regmap_read(spdifrx->regmap, STM32_SPDIFRX_CR, &cr);
-		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) &&
+		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) ==
 			     SPDIFRX_SPDIFEN_SYNC;
 
 		/* SPDIFRX is in STATE_STOP. Disable SPDIFRX to clear errors */
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index b4b4765725ce..bc35c36148ac 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -562,6 +562,9 @@ static int snd_probe(struct usb_interface *intf,
 	ret = init_card(caiaqdev(card));
 	if (ret < 0) {
 		dev_err(&usb_dev->dev, "unable to init card! (ret=%d)\n", ret);
+#ifdef CONFIG_SND_USB_CAIAQ_INPUT
+		snd_usb_caiaq_input_disconnect(caiaqdev(card));
+#endif
 		snd_card_free(card);
 		return ret;
 	}
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 6ec95b2edf86..0d860c57d9d9 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -89,7 +89,7 @@ struct snd_usb_endpoint {
 	struct snd_urb_ctx urb[MAX_URBS];
 
 	struct snd_usb_packet_info {
-		uint32_t packet_size[MAX_PACKS_HS];
+		int packet_size[MAX_PACKS_HS];
 		int packets;
 	} next_packet[MAX_URBS];
 	unsigned int next_packet_head;	/* ring buffer offset to read */
@@ -115,6 +115,7 @@ struct snd_usb_endpoint {
 	unsigned int phase;		/* phase accumulator */
 	unsigned int maxpacksize;	/* max packet size in bytes */
 	unsigned int maxframesize;      /* max packet size in frames */
+	unsigned int max_urb_packs;	/* packets allocated per data URB */
 	unsigned int max_urb_frames;	/* max URB size in frames */
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;      /* current packet size in frames (for capture) */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e995b7ab88b1..5219111b79e5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -477,7 +477,7 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 		unsigned long flags;
 		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
-		int err, i;
+		int err;
 
 		spin_lock_irqsave(&ep->lock, flags);
 		if ((!implicit_fb || ep->next_packet_queued > 0) &&
@@ -496,9 +496,10 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 
 		/* copy over the length information */
 		if (implicit_fb) {
-			ctx->packets = packet->packets;
-			for (i = 0; i < packet->packets; i++)
-				ctx->packet_size[i] = packet->packet_size[i];
+			ctx->packets = min_t(int, packet->packets,
+					     ep->max_urb_packs);
+			memcpy(ctx->packet_size, packet->packet_size,
+			       ctx->packets * sizeof(packet->packet_size[0]));
 		}
 
 		/* call the data handler to fill in playback data */
@@ -1247,15 +1248,16 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
 		ep->nurbs = min(max_urbs, urbs_per_period * ep->cur_buffer_periods);
 	}
 
+	if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
+		urb_packs++; /* for transfer delimiter */
+	ep->max_urb_packs = urb_packs;
+
 	/* allocate and initialize data urbs */
 	for (i = 0; i < ep->nurbs; i++) {
 		struct snd_urb_ctx *u = &ep->urb[i];
 		u->index = i;
 		u->ep = ep;
 		u->packets = urb_packs;
-
-		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
-			u->packets++; /* for transfer delimiter */
 		u->buffer_size = maxsize * u->packets;
 		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
 		if (!u->urb)
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 8233c61e23f1..0da1998dd5ad 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -182,6 +182,13 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 		fsize *= bytes_per_frame;
 
+		if (fsize > line6pcm->max_packet_size_out) {
+			dev_err(line6pcm->line6->ifcdev,
+				"playback packet too large: %d > %d\n",
+				fsize, line6pcm->max_packet_size_out);
+			return -EMSGSIZE;
+		}
+
 		fout->offset = urb_size;
 		fout->length = fsize;
 		urb_size += fsize;
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 4d23ec97475d..c43f4e4a8d67 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1022,6 +1022,15 @@ static int detect_usb_format(struct ua101 *ua)
 	}
 	ua->playback.usb_pipe = usb_sndisocpipe(ua->dev, usb_endpoint_num(epd));
 	ua->playback.max_packet_bytes = usb_endpoint_maxp(epd);
+
+	if (ua->capture.max_packet_bytes / ua->capture.frame_bytes *
+	    ua->playback.frame_bytes > ua->playback.max_packet_bytes) {
+		dev_err(&ua->dev->dev,
+			"playback packet size %u too small for %u capture frames\n",
+			ua->playback.max_packet_bytes,
+			ua->capture.max_packet_bytes / ua->capture.frame_bytes);
+		return -ENXIO;
+	}
 	return 0;
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 1278d8a3cc12..112b9d541084 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1947,8 +1947,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
 		   QUIRK_FLAG_DSD_RAW),
-	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
-		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
 		   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
@@ -2006,6 +2004,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x25ce, /* Mytek devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2708, /* Audient devices */
+		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	VENDOR_FLG(0x278b, /* Rotel? */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x292b, /* Gustard/Ess based devices */
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 150ab3e37013..1a4007c99c53 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -349,8 +349,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	vdev->config->del_vqs(vdev);
 	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -378,8 +378,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	vdev->config->del_vqs(vdev);
 	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 440434027557..4f30b25b926a 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -7,7 +7,13 @@ bindir ?= /usr/bin
 # isn't set and when invoked from selftests build, where srctree
 # is set to ".". building_out_of_srctree is undefined for in srctree
 # builds
+ifeq ($(srctree),)
+update_srctree := 1
+endif
 ifndef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index fa03ff0dc083..4486de74eca9 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -29,11 +29,12 @@
 
 static int epoll_pwait_loop(void)
 {
+	struct epoll_event events;
 	int i;
 
 	/* Should fail NR_ITERS times */
 	for (i = 0; i < NR_ITERS; i++)
-		epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
+		epoll_pwait(-(i + 1), &events, 0, 0, NULL);
 	return 0;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7e4939640196..f0750b8bf66c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1686,7 +1686,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 					return -1;
 				if (parse_events_term__num(&term,
 						   PARSE_EVENTS__TERM_TYPE_USER,
-						   config, 1, false, &config,
+						   config, 1, false, NULL,
 						   NULL) < 0) {
 					free(list);
 					free(config);
diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
new file mode 100644
index 000000000000..cc6df762845f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - reject incomplete logical expressions
+# requires: events/sched/sched_switch/filter
+# flags: instance
+
+filter=events/sched/sched_switch/filter
+
+for base in \
+    'common_pid == 1' \
+    'common_pid == 1 || common_pid == 2' \
+    'common_pid == 1 && common_pid == 2' \
+    '!(common_pid == 1 || common_pid == 2)'
+do
+    printf '%s' "$base" > "$filter"
+    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
+        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
+            echo "Accepted incomplete filter: $base $tail"
+            exit_fail
+        fi
+    done
+done
+
+echo 0 > "$filter"

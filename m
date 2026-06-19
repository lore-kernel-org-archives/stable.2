Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38993815D6;
	Fri, 19 Jun 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870437; cv=none; b=TrNHPTBGjf0WVmtdizWFNnpps3o+RBzw/SgfsdnsPPyGX354zqQoMGhtKHUeE0Eb9wx44ZBugeOc13f7/L5Z9sIcmrgoHxffBT3Jxlv+ZcQdXSMcwoU4HLoxC29mibAdTupTyF0f18zrL26pLkK6yDo5LRENtXUWj3+DNtgWZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870437; c=relaxed/simple;
	bh=/x6kN+jBAY73cEEvPSMsZAAxzyum7ab4DeZyp2WaGew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srbXWVRD/uNUdzYcHEzZC3I1VDApKO1HdDzH6j2/feXV6sLoqiovDcevqNzQcVNEJnN+te/y+7HcjfUtNdEXO7G8O92o7VUYJU3F5GtpNtZUVYz2XBO+ap8/JZe4RvM51IyldCU1wB4EssbbZ+KeumwAnYKdlEOS7+/L6VfZ/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOxrGDBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOxrGDBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74171F00A3D;
	Fri, 19 Jun 2026 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781870408;
	bh=wRlhgyl6OYGmUghcNN2j89BEtjs2NxcuwL/9Lxez+Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOxrGDBJSFpTsLKeQiBJeP0IjL9E4tgbQwP3wnv8qLQX/JKzuWTb1GP5LWufurWZq
	 LQgzsPvdgv5NLzY48l5fWApBRLAJ041+fGL/PAeop6msm9vx1trF2CwayCr4v6epxx
	 QMcQmo9nLeD6JAOtOC37Yf6Lr2X4QgcRJgQAfX7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.210
Date: Fri, 19 Jun 2026 13:58:43 +0200
Message-ID: <2026061943-deflator-equate-7450@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026061943-earthling-unused-3e5a@gregkh>
References: <2026061943-earthling-unused-3e5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index e80392db30f7..b2590a08c711 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -98,14 +98,26 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76AE    | #4193801        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #4193798        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78AE    | #4193793        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #4193794        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
@@ -118,6 +130,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
@@ -126,16 +140,28 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #4193792        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #4193786        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #4118414        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #4193781        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -144,6 +170,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
@@ -152,16 +180,30 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #4193790        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Premium      | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Ultra        | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
@@ -200,6 +242,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | Olympus core    | T410-OLY-1029   | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -247,3 +291,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/Makefile b/Makefile
index f5bfc7745621..8f0f22303f62 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 209
+SUBLEVEL = 210
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 79d246ac93ab..d927459858cf 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -56,8 +56,19 @@ void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
  * the bus. Rather than special-case the machine, just let the compiler
  * generate the access for CPUs prior to ARMv6.
  */
-#define __raw_readw(a)         (__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
-#define __raw_writew(v,a)      ((void)(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v)))
+#define __raw_writew __raw_writew
+static __no_kasan_or_inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	__chk_io_ptr(addr);
+	*(volatile unsigned short __force *)addr = val;
+}
+
+#define __raw_readw __raw_readw
+static __no_kasan_or_inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	__chk_io_ptr(addr);
+	return *(const volatile unsigned short __force *)addr;
+}
 #else
 /*
  * When running under a hypervisor, we want to avoid I/O accesses with
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 201191cf68f3..349e6c54518e 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -78,6 +78,7 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	socfpga_scu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 	if (!socfpga_scu_base_addr)
 		return;
 	scu_enable(socfpga_scu_base_addr);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6f016a6b61a3..06ef732c0472 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -889,6 +889,56 @@ config ARM64_ERRATUM_3194386
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4193714
+	bool "C1-Pro: 4193714: SME DVMSync early acknowledgement"
+	depends on ARM64_SME
+	default y
+	help
+	  Enable workaround for C1-Pro acknowledging the DVMSync before
+	  the SME memory accesses are complete. This will cause TLB
+	  maintenance for processes using SME to also issue an IPI to
+	  the affected CPUs.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_4118414
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	default y
+	select ARM64_WORKAROUND_REPEAT_TLBI
+	help
+	  This option adds a workaround for the following errata:
+
+	  * ARM C1-Premium erratum 4193780
+	  * ARM C1-Ultra erratum 4193780
+	  * ARM Cortex-A76 erratum 4193800
+	  * ARM Cortex-A76AE erratum 4193801
+	  * ARM Cortex-A77 erratum 4193798
+	  * ARM Cortex-A78 erratum 4193791
+	  * ARM Cortex-A78AE erratum 4193793
+	  * ARM Cortex-A78C erratum 4193794
+	  * ARM Cortex-A710 erratum 4193788
+	  * ARM Cortex-X1 erratum 4193791
+	  * ARM Cortex-X1C erratum 4193792
+	  * ARM Cortex-X2 erratum 4193788
+	  * ARM Cortex-X3 erratum 4193786
+	  * ARM Cortex-X4 erratum 4118414
+	  * ARM Cortex-X925 erratum 4193781
+	  * ARM Neoverse-N1 erratum 4193800
+	  * ARM Neoverse-N2 erratum 4193789
+	  * ARM Neoverse-V1 erratum 4193790
+	  * ARM Neoverse-V2 erratum 4193787
+	  * ARM Neoverse-V3 erratum 4193784
+	  * ARM Neoverse-V3AE erratum 4193784
+	  * Microsoft Azure Cobalt 100 4193789
+	  * NVIDIA Olympus erratum T410-OLY-1029
+
+	  On affected cores, some memory accesses might not be completed by
+	  broadcast TLB invalidation.
+
+	  This issue is also known as CVE-2025-10263.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d49743d01fe6..e2e3580441a5 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -97,7 +97,9 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
+#define ARM_CPU_PART_C1_PREMIUM		0xD90
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -121,6 +123,7 @@
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
+#define NVIDIA_CPU_PART_OLYMPUS		0x010
 
 #define FUJITSU_CPU_PART_A64FX		0x001
 
@@ -165,7 +168,9 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
+#define MIDR_C1_PREMIUM MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PREMIUM)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
@@ -183,6 +188,7 @@
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 02d378887743..1733eb87c29f 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -207,8 +207,8 @@ static inline void __invalidate_icache_guest_page(void *va, size_t size)
 	if (icache_is_aliasing()) {
 		/* any kind of VIPT cache */
 		icache_inval_all_pou();
-	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
-		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
+	} else {
+		/* PIPT */
 		icache_inval_pou((unsigned long)va, (unsigned long)va + size);
 	}
 }
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..cd6997187104 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,7 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
-	bool last_level = !tlb->freed_tables;
+	bool last_level = !(tlb->freed_tables || tlb->unshared_tables);
 	unsigned long stride = tlb_get_unmap_size(tlb);
 	int tlb_level = tlb_get_level(tlb);
 
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 412a3b9a3c25..cc6e47172f8f 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -30,19 +30,11 @@
  */
 #define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE			       \
 			       "tlbi " #op "\n"				       \
-		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op,	       \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : )
 
 #define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
-			       "tlbi " #op ", %0\n"			       \
-		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op ", %0",     \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
-			    : : "r" (arg))
+			       "tlbi " #op ", %x0\n"			       \
+			    : : "rZ" (arg))
 
 #define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
 
@@ -158,6 +150,37 @@ static inline unsigned long get_trans_granule(void)
 #define __TLBI_RANGE_NUM(pages, scale)	\
 	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
 
+#define __repeat_tlbi_sync(op, arg)						\
+do {										\
+	asm volatile(								\
+	ALTERNATIVE("nop\n			nop",				\
+		    "tlbi " #op ", %x0\n	dsb ish",			\
+		    ARM64_WORKAROUND_REPEAT_TLBI,				\
+		    CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)			\
+	:									\
+	: "rZ" (arg));								\
+} while (0)
+
+/*
+ * Complete broadcast TLB maintenance issued by the host which invalidates
+ * stage 1 information in the host's own translation regime.
+ */
+static inline void __tlbi_sync_s1ish(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale1is, 0);
+}
+
+/*
+ * Complete broadcast TLB maintenance issued by hyp code which invalidates
+ * stage 1 translation information in any translation regime.
+ */
+static inline void __tlbi_sync_s1ish_hyp(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale2is, 0);
+}
+
 /*
  *	TLB Invalidation
  *	================
@@ -239,7 +262,7 @@ static inline void flush_tlb_all(void)
 {
 	dsb(ishst);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 
@@ -251,7 +274,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	asid = __TLBI_VADDR(0, ASID(mm));
 	__tlbi(aside1is, asid);
 	__tlbi_user(aside1is, asid);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 }
 
 static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
@@ -269,7 +292,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
 	flush_tlb_page_nosync(vma, uaddr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 }
 
 /*
@@ -357,7 +380,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 		}
 		scale++;
 	}
-	dsb(ish);
+	__tlbi_sync_s1ish();
 }
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
@@ -386,7 +409,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
 		__tlbi(vaale1is, addr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 
@@ -400,7 +423,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
-	dsb(ish);
+	__tlbi_sync_s1ish();
 	isb();
 }
 #endif
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 531bb76bc56e..e9f0b46e6f65 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -225,7 +225,37 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
 	},
 #endif
-	{},
+#ifdef CONFIG_ARM64_ERRATUM_4118414
+	{
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+			MIDR_ALL_VERSIONS(MIDR_C1_PREMIUM),
+			MIDR_ALL_VERSIONS(MIDR_C1_ULTRA),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
+			MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
+			{}
+		})),
+	},
+#endif
+	{}
 };
 #endif
 
@@ -514,7 +544,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 	{
-		.desc = "Qualcomm erratum 1009, or ARM erratum 1286807, 2441009",
+		.desc = "Broken broadcast TLBI completion",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index b88a52f7188f..416195f37681 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -38,7 +38,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
 			__tlbi(aside1is, __TLBI_VADDR(0, 0));
-			dsb(ish);
+			__tlbi_sync_s1ish();
 		}
 
 		ret = caches_clean_inval_user_pou(start, start + chunk);
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index d296d617f589..76973e3b48a0 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -81,31 +81,9 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	 */
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (icache_is_vpipt())
-		icache_inval_all_pou();
-
 	__tlb_switch_to_host(&cxt);
 }
 
@@ -119,7 +97,7 @@ void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu)
 	__tlb_switch_to_guest(mmu, &cxt);
 
 	__tlbi(vmalls12e1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -144,18 +122,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 }
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index 24cef9b87f9e..59aa22b48e95 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -105,7 +105,7 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	 */
 	dsb(ish);
 	__tlbi(vmalle1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -121,7 +121,7 @@ void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu)
 	__tlb_switch_to_guest(mmu, &cxt);
 
 	__tlbi(vmalls12e1is);
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 	isb();
 
 	__tlb_switch_to_host(&cxt);
@@ -146,18 +146,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
-	dsb(ish);
+	__tlbi_sync_s1ish_hyp();
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e3e4defdea42..739d00a69be1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -886,10 +886,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 
 		WARN_ON(!pte_present(pte));
 		pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-		if (free_mapped)
+		if (free_mapped) {
+			/* CONT blocks are not supported in the vmemmap */
+			WARN_ON(pte_cont(pte));
+			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 			free_hotplug_page_range(pte_page(pte),
 						PAGE_SIZE, altmap);
+		}
+		/* unmap_hotplug_range() flushes TLB for !free_mapped */
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
@@ -910,15 +914,14 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 		WARN_ON(!pmd_present(pmd));
 		if (pmd_sect(pmd)) {
 			pmd_clear(pmdp);
-
-			/*
-			 * One TLBI should be sufficient here as the PMD_SIZE
-			 * range is mapped with a single block entry.
-			 */
-			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-			if (free_mapped)
+			if (free_mapped) {
+				/* CONT blocks are not supported in the vmemmap */
+				WARN_ON(pmd_cont(pmd));
+				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
 				free_hotplug_page_range(pmd_page(pmd),
 							PMD_SIZE, altmap);
+			}
+			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
@@ -943,15 +946,12 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 		WARN_ON(!pud_present(pud));
 		if (pud_sect(pud)) {
 			pud_clear(pudp);
-
-			/*
-			 * One TLBI should be sufficient here as the PUD_SIZE
-			 * range is mapped with a single block entry.
-			 */
-			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-			if (free_mapped)
+			if (free_mapped) {
+				flush_tlb_kernel_range(addr, addr + PUD_SIZE);
 				free_hotplug_page_range(pud_page(pud),
 							PUD_SIZE, altmap);
+			}
+			/* unmap_hotplug_range() flushes TLB for !free_mapped */
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
@@ -981,6 +981,7 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 				bool free_mapped, struct vmem_altmap *altmap)
 {
+	unsigned long start = addr;
 	unsigned long next;
 	pgd_t *pgdp, pgd;
 
@@ -1002,6 +1003,9 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 		WARN_ON(!pgd_present(pgd));
 		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
+
+	if (!free_mapped)
+		flush_tlb_kernel_range(start, end);
 }
 
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6c1ada204bcf..2ad2c454b982 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1111,14 +1111,6 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 		/* Erratum 1076: CPB feature bit not being set in CPUID. */
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
-
-		/*
-		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
-		 * Branch Type Confusion, but predate the allocation of the
-		 * BTC_NO bit.
-		 */
-		if (c->x86 == 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
-			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
 
 	pr_notice_once("AMD Zen1 FPDSS bug detected, enabling mitigation.\n");
@@ -1178,6 +1170,16 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
+		 * Branch Type Confusion, but predate the allocation of the
+		 * BTC_NO bit.
+		 */
+		if (!cpu_has(c, X86_FEATURE_BTC_NO))
+			set_cpu_cap(c, X86_FEATURE_BTC_NO);
+	}
 }
 
 static void init_amd_zen4(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1ba590e6ef7b..83c788ba309a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -940,7 +940,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
-	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
+	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
 	ret = generic_load_microcode(cpu, &iter);
 
 	release_firmware(firmware);
@@ -959,7 +959,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 
 	iov.iov_base = (void __user *)buf;
 	iov.iov_len = size;
-	iov_iter_init(&iter, WRITE, &iov, 1, size);
+	iov_iter_init(&iter, ITER_SOURCE, &iov, 1, size);
 
 	return generic_load_microcode(cpu, &iter);
 }
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 61fdff5406b5..1179c4bee705 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1337,7 +1337,7 @@ int blkcg_activate_policy(struct request_queue *q,
 retry:
 	spin_lock_irq(&q->queue_lock);
 
-	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
+	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
@@ -1375,21 +1375,20 @@ int blkcg_activate_policy(struct request_queue *q,
 				goto enomem;
 		}
 
-		blkg->pd[pol->plid] = pd;
+		spin_lock(&blkg->blkcg->lock);
+
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		pd->online = false;
-	}
+		blkg->pd[pol->plid] = pd;
 
-	/* all allocated, init in the same order */
-	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
-			pol->pd_init_fn(blkg->pd[pol->plid]);
+		if (pol->pd_init_fn)
+			pol->pd_init_fn(pd);
 
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		if (pol->pd_online_fn)
-			pol->pd_online_fn(blkg->pd[pol->plid]);
-		blkg->pd[pol->plid]->online = true;
+			pol->pd_online_fn(pd);
+		pd->online = true;
+
+		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
@@ -1406,14 +1405,19 @@ int blkcg_activate_policy(struct request_queue *q,
 	return ret;
 
 enomem:
-	/* alloc failed, nothing's initialized yet, free everything */
+	/* alloc failed, take down everything */
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
+		struct blkg_policy_data *pd;
 
 		spin_lock(&blkcg->lock);
-		if (blkg->pd[pol->plid]) {
-			pol->pd_free_fn(blkg->pd[pol->plid]);
+		pd = blkg->pd[pol->plid];
+		if (pd) {
+			if (pd->online && pol->pd_offline_fn)
+				pol->pd_offline_fn(pd);
+			pd->online = false;
+			pol->pd_free_fn(pd);
 			blkg->pd[pol->plid] = NULL;
 		}
 		spin_unlock(&blkcg->lock);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 163a1283a866..2398306ab5ce 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -750,7 +750,7 @@ static int build_cipher_test_sglists(struct cipher_test_sglists *tsgls,
 	struct iov_iter input;
 	int err;
 
-	iov_iter_kvec(&input, WRITE, inputs, nr_inputs, src_total_len);
+	iov_iter_kvec(&input, ITER_SOURCE, inputs, nr_inputs, src_total_len);
 	err = build_test_sglist(&tsgls->src, cfg->src_divs, alignmask,
 				cfg->inplace ?
 					max(dst_total_len, src_total_len) :
@@ -1133,7 +1133,7 @@ static int build_hash_sglist(struct test_sglist *tsgl,
 
 	kv.iov_base = (void *)vec->plaintext;
 	kv.iov_len = vec->psize;
-	iov_iter_kvec(&input, WRITE, &kv, 1, vec->psize);
+	iov_iter_kvec(&input, ITER_SOURCE, &kv, 1, vec->psize);
 	return build_test_sglist(tsgl, cfg->src_divs, alignmask, vec->psize,
 				 &input, divs);
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 005ece1a658e..b284f9284b88 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2596,6 +2596,7 @@ static struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -2605,6 +2606,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Check if the device was created by genpd at attach. */
+	is_virt_dev = dev->bus == &genpd_bus_type;
+
+	/* Disable runtime PM if we enabled it at attach. */
+	if (is_virt_dev)
+		pm_runtime_disable(dev);
+
 	/* Drop the default performance state */
 	if (dev_gpd_data(dev)->default_pstate) {
 		dev_pm_genpd_set_performance_state(dev, 0);
@@ -2630,7 +2638,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 13f9911bc026..226661f6d97c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1843,7 +1843,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 
 	/* THINK  if (signal_pending) return ... ? */
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
 
 	if (sock == connection->data.socket) {
 		rcu_read_lock();
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ea38dd43c6b0..f9cf6428a3d1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -507,7 +507,7 @@ static int drbd_recv_short(struct socket *sock, void *buf, size_t size, int flag
 	struct msghdr msg = {
 		.msg_flags = (flags ? flags : MSG_WAITALL | MSG_NOSIGNAL)
 	};
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 	return sock_recvmsg(sock, &msg, msg.msg_flags);
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a612370dd9ec..45684136e837 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -310,7 +310,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -388,7 +388,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -429,7 +429,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_offset = 0;
 		b.bv_len = bvec.bv_len;
 
-		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
+		iov_iter_bvec(&i, ITER_DEST, &b, 1, b.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0) {
 			ret = len;
@@ -551,7 +551,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, bool rw)
+		     loff_t pos, int rw)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
@@ -607,7 +607,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
-	if (rw == WRITE)
+	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
@@ -651,14 +651,14 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, WRITE);
+			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (lo->transfer)
 			return lo_read_transfer(lo, rq, pos);
 		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, READ);
+			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
 		else
 			return lo_read_simple(lo, rq, pos);
 	default:
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 79b0056edbaf..b606faa03229 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -562,7 +562,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
 
-	iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+	iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 
 	type = req_to_nbd_cmd_type(req);
 	if (type == U32_MAX)
@@ -648,7 +648,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
-			iov_iter_bvec(&from, WRITE, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, bvec.bv_len);
 			if (skip) {
 				if (skip >= iov_iter_count(&from)) {
 					skip -= iov_iter_count(&from);
@@ -700,7 +700,7 @@ static int nbd_read_reply(struct nbd_device *nbd, int index,
 	int result;
 
 	reply->magic = 0;
-	iov_iter_kvec(&to, READ, &iov, 1, sizeof(*reply));
+	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
@@ -777,7 +777,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 		struct iov_iter to;
 
 		rq_for_each_segment(bvec, req, iter) {
-			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&to, ITER_DEST, &bvec, 1, bvec.bv_len);
 			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
@@ -1228,7 +1228,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
-		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+		iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret < 0)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 12bcc07e2e50..08525a8d378f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3448,7 +3448,13 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 		    "firmware rome 0x%x build 0x%x",
 		    rver_rom, rver_patch, ver_rom, ver_patch);
 
-	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
+	/* Allow rampatch when the patch version equals the firmware version.
+	 * A firmware download may be aborted by a transient USB error (e.g.
+	 * disconnect) after the controller updates version info but before
+	 * completion.
+	 * Allowing equal versions enables re-flashing during recovery.
+	 */
+	if (rver_rom != ver_rom || rver_patch < ver_patch) {
 		bt_dev_err(hdev, "rampatch file version did not match with firmware");
 		err = -EINVAL;
 		goto done;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c0de1b22e753..d6bf5058a430 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -46,13 +46,12 @@
 #define HCI_MAX_IBS_SIZE	10
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
-#define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	200
+#define IBS_BTSOC_TX_IDLE_TIMEOUT	msecs_to_jiffies(200)
 #define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
-#define CMD_TRANS_TIMEOUT_MS		100
-#define MEMDUMP_TIMEOUT_MS		8000
-#define IBS_DISABLE_SSR_TIMEOUT_MS \
-	(MEMDUMP_TIMEOUT_MS + FW_DOWNLOAD_TIMEOUT_MS)
-#define FW_DOWNLOAD_TIMEOUT_MS		3000
+#define CMD_TRANS_TIMEOUT		msecs_to_jiffies(100)
+#define MEMDUMP_TIMEOUT			msecs_to_jiffies(8000)
+#define FW_DOWNLOAD_TIMEOUT		msecs_to_jiffies(3000)
+#define IBS_DISABLE_SSR_TIMEOUT		(MEMDUMP_TIMEOUT + FW_DOWNLOAD_TIMEOUT)
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -1058,7 +1057,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				    dump_size);
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
-					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)
+					   MEMDUMP_TIMEOUT
 					  );
 
 			skb_pull(skb, sizeof(dump_size));
@@ -1326,7 +1325,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	if (hu->serdev)
 		serdev_device_wait_until_sent(hu->serdev,
-		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+		      CMD_TRANS_TIMEOUT);
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
@@ -1356,8 +1355,8 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 
 static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
+	int timeout = CMD_TRANS_TIMEOUT;
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
@@ -1556,7 +1555,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT);
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
@@ -2345,7 +2344,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 static void qca_serdev_shutdown(struct device *dev)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
+	int timeout = CMD_TRANS_TIMEOUT;
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
@@ -2403,7 +2402,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	bool tx_pending = false;
 	int ret = 0;
 	u8 cmd;
-	u32 wait_timeout = 0;
+	unsigned long wait_timeout = 0;
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
@@ -2424,15 +2423,15 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	if (test_bit(QCA_IBS_DISABLED, &qca->flags) ||
 	    test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
 		wait_timeout = test_bit(QCA_SSR_TRIGGERED, &qca->flags) ?
-					IBS_DISABLE_SSR_TIMEOUT_MS :
-					FW_DOWNLOAD_TIMEOUT_MS;
+					IBS_DISABLE_SSR_TIMEOUT :
+					FW_DOWNLOAD_TIMEOUT;
 
 		/* QCA_IBS_DISABLED flag is set to true, During FW download
 		 * and during memory dump collection. It is reset to false,
 		 * After FW download complete.
 		 */
 		wait_on_bit_timeout(&qca->flags, QCA_IBS_DISABLED,
-			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(wait_timeout));
+			    TASK_UNINTERRUPTIBLE, wait_timeout);
 
 		if (test_bit(QCA_IBS_DISABLED, &qca->flags)) {
 			bt_dev_err(hu->hdev, "SSR or FW download time out");
@@ -2484,7 +2483,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	if (tx_pending) {
 		serdev_device_wait_until_sent(hu->serdev,
-					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+					      CMD_TRANS_TIMEOUT);
 		serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 	}
 
@@ -2493,7 +2492,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	 */
 	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
 			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
-			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
+			IBS_BTSOC_TX_IDLE_TIMEOUT);
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
 		goto error;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8642326de6e1..b10c75de7a51 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1236,7 +1236,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 			return ret;
 	}
 
-	ret = import_single_range(READ, ubuf, len, &iov, &iter);
+	ret = import_single_range(ITER_DEST, ubuf, len, &iov, &iter);
 	if (unlikely(ret))
 		return ret;
 	return get_random_bytes_user(&iter);
@@ -1347,7 +1347,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(len, p++))
 			return -EFAULT;
-		ret = import_single_range(WRITE, p, len, &iov, &iter);
+		ret = import_single_range(ITER_SOURCE, p, len, &iov, &iter);
 		if (unlikely(ret))
 			return ret;
 		ret = write_pool_user(&iter);
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index f5199474c0e9..55114cf4a09a 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -273,6 +273,7 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 	/* Step 2a : make sure trigger sources are unique */
 
 	err |= comedi_check_trigger_is_unique(cmd->convert_src);
+	err |= comedi_check_trigger_is_unique(cmd->scan_begin_src);
 	err |= comedi_check_trigger_is_unique(cmd->stop_src);
 
 	/* Step 2b : and mutually compatible */
@@ -323,10 +324,10 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 		arg = min(arg,
 			  rounddown(UINT_MAX, (unsigned int)NSEC_PER_USEC));
 		arg = NSEC_PER_USEC * DIV_ROUND_CLOSEST(arg, NSEC_PER_USEC);
-		if (cmd->scan_begin_arg == TRIG_TIMER) {
+		if (cmd->scan_begin_src == TRIG_TIMER) {
 			/* limit convert_arg to keep scan_begin_arg in range */
 			limit = UINT_MAX / cmd->scan_end_arg;
-			limit = rounddown(limit, (unsigned int)NSEC_PER_SEC);
+			limit = rounddown(limit, (unsigned int)NSEC_PER_USEC);
 			arg = min(arg, limit);
 		}
 		err |= comedi_check_trigger_arg_is(&cmd->convert_arg, arg);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 35c4e29033d5..724de2da7f28 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -3264,7 +3264,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dpaa2_fl_set_addr(out_fle, key_dma);
 	dpaa2_fl_set_len(out_fle, digestsize);
 
-	print_hex_dump_debug("key_in@" __stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -3284,7 +3284,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-		print_hex_dump_debug("digested key@" __stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 36ef738e4a18..25eabcadc4ab 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -390,7 +390,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	append_seq_store(desc, digestsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-	print_hex_dump_debug("key_in@"__stringify(__LINE__)": ",
+	print_hex_dump_devel("key_in@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
@@ -405,7 +405,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		wait_for_completion(&result.completion);
 		ret = result.err;
 
-		print_hex_dump_debug("digested key@"__stringify(__LINE__)": ",
+		print_hex_dump_devel("digested key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
 				     digestsize, 1);
 	}
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2d27c6ec1ce..698387103da7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -829,7 +829,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_iounmap(pdev, idxd->reg_base);
 	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 489a9d885076..ee208dfdd0cb 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1271,6 +1271,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 97045a8d9422..8572fac30051 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -640,7 +640,7 @@ static void sbefifo_collect_async_ffdc(struct sbefifo *sbefifo)
 	}
         ffdc_iov.iov_base = ffdc;
 	ffdc_iov.iov_len = SBEFIFO_MAX_FFDC_SIZE;
-        iov_iter_kvec(&ffdc_iter, READ, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
+        iov_iter_kvec(&ffdc_iter, ITER_DEST, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
 	cmd[0] = cpu_to_be32(2);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_SBE_FFDC);
 	rc = sbefifo_do_command(sbefifo, cmd, 2, &ffdc_iter);
@@ -737,7 +737,7 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 	rbytes = (*resp_len) * sizeof(__be32);
 	resp_iov.iov_base = response;
 	resp_iov.iov_len = rbytes;
-        iov_iter_kvec(&resp_iter, READ, &resp_iov, 1, rbytes);
+        iov_iter_kvec(&resp_iter, ITER_DEST, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
 	mutex_lock(&sbefifo->lock);
@@ -817,7 +817,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	/* Prepare iov iterator */
 	resp_iov.iov_base = buf;
 	resp_iov.iov_len = len;
-	iov_iter_init(&resp_iter, READ, &resp_iov, 1, len);
+	iov_iter_init(&resp_iter, ITER_DEST, &resp_iov, 1, len);
 
 	/* Perform the command */
 	mutex_lock(&sbefifo->lock);
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index d331745da1a3..df2eefc1554a 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -649,11 +649,10 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (!bank->irq)
 		return -EINVAL;
 
-	bank->clk = of_clk_get(bank->of_node, 0);
+	bank->clk = devm_clk_get_enabled(bank->dev, NULL);
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
-	clk_prepare_enable(bank->clk);
 	id = readl(bank->reg_base + gpio_regs_v2.version_id);
 
 	/* If not gpio v2, that is default to v1. */
@@ -663,7 +662,6 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 		bank->db_clk = of_clk_get(bank->of_node, 1);
 		if (IS_ERR(bank->db_clk)) {
 			dev_err(bank->dev, "cannot find debounce clk\n");
-			clk_disable_unprepare(bank->clk);
 			return -EINVAL;
 		}
 	} else {
@@ -737,7 +735,6 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
-		clk_disable_unprepare(bank->clk);
 		mutex_unlock(&bank->deferred_lock);
 		return ret;
 	}
@@ -773,7 +770,6 @@ static int rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(bank->clk);
 	gpiochip_remove(&bank->gpio_chip);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8ccd43ec6882..89a3018ad376 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1016,8 +1016,13 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 	if (size == 0)
 		return 0;
 
+	if (!connector->base.state || !connector->base.state->crtc)
+		return -ENODEV;
+
 	acrtc_state = to_dm_crtc_state(connector->base.state->crtc->state);
 
+	write_size = min_t(size_t, size, sizeof(data));
+
 	r = copy_from_user(data, buf, write_size);
 
 	write_size -= r;
diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 706c803c4d3b..c0e0c2206ab8 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -291,8 +291,8 @@ bool dal_vector_reserve(struct vector *vector, uint32_t capacity)
 	if (capacity <= vector->capacity)
 		return true;
 
-	new_container = krealloc(vector->container,
-				 capacity * vector->struct_size, GFP_KERNEL);
+	new_container = krealloc_array(vector->container,
+				       capacity, vector->struct_size, GFP_KERNEL);
 
 	if (new_container) {
 		vector->container = new_container;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index bebdc9b53bb6..e186d4daae55 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -547,8 +547,10 @@ static enum bp_result bios_parser_get_gpio_pin_info(
 		info->offset_en = info->offset + 1;
 		info->offset_mask = info->offset - 1;
 
-		info->mask = (uint32_t) (1 <<
-			header->gpio_pin[i].gpio_bitshift);
+		if (header->gpio_pin[i].gpio_bitshift >= 32)
+			return BP_RESULT_BADBIOSTABLE;
+
+		info->mask = 1u << header->gpio_pin[i].gpio_bitshift;
 		info->mask_y = info->mask + 2;
 		info->mask_en = info->mask + 1;
 		info->mask_mask = info->mask - 1;
@@ -1856,14 +1858,16 @@ static enum bp_result get_integrated_info_v11(
 	info_v11->extdispconninfo.checksum;
 
 	info->dp0_ext_hdmi_slv_addr = info_v11->dp0_retimer_set.HdmiSlvAddr;
-	info->dp0_ext_hdmi_reg_num = info_v11->dp0_retimer_set.HdmiRegNum;
+	info->dp0_ext_hdmi_reg_num = min_t(u8, info_v11->dp0_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp0_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_reg_num; i++) {
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp0_ext_hdmi_6g_reg_num = info_v11->dp0_retimer_set.Hdmi6GRegNum;
+	info->dp0_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp0_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp0_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_6g_reg_num; i++) {
 		info->dp0_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -1872,14 +1876,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp1_ext_hdmi_slv_addr = info_v11->dp1_retimer_set.HdmiSlvAddr;
-	info->dp1_ext_hdmi_reg_num = info_v11->dp1_retimer_set.HdmiRegNum;
+	info->dp1_ext_hdmi_reg_num = min_t(u8, info_v11->dp1_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp1_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_reg_num; i++) {
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp1_ext_hdmi_6g_reg_num = info_v11->dp1_retimer_set.Hdmi6GRegNum;
+	info->dp1_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp1_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp1_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_6g_reg_num; i++) {
 		info->dp1_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -1888,14 +1894,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp2_ext_hdmi_slv_addr = info_v11->dp2_retimer_set.HdmiSlvAddr;
-	info->dp2_ext_hdmi_reg_num = info_v11->dp2_retimer_set.HdmiRegNum;
+	info->dp2_ext_hdmi_reg_num = min_t(u8, info_v11->dp2_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp2_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_reg_num; i++) {
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp2_ext_hdmi_6g_reg_num = info_v11->dp2_retimer_set.Hdmi6GRegNum;
+	info->dp2_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp2_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp2_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_6g_reg_num; i++) {
 		info->dp2_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -1904,14 +1912,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp3_ext_hdmi_slv_addr = info_v11->dp3_retimer_set.HdmiSlvAddr;
-	info->dp3_ext_hdmi_reg_num = info_v11->dp3_retimer_set.HdmiRegNum;
+	info->dp3_ext_hdmi_reg_num = min_t(u8, info_v11->dp3_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp3_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_reg_num; i++) {
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp3_ext_hdmi_6g_reg_num = info_v11->dp3_retimer_set.Hdmi6GRegNum;
+	info->dp3_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp3_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp3_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_6g_reg_num; i++) {
 		info->dp3_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp3_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2059,14 +2069,16 @@ static enum bp_result get_integrated_info_v2_1(
 	info->ext_disp_conn_info.checksum =
 		info_v2_1->extdispconninfo.checksum;
 	info->dp0_ext_hdmi_slv_addr = info_v2_1->dp0_retimer_set.HdmiSlvAddr;
-	info->dp0_ext_hdmi_reg_num = info_v2_1->dp0_retimer_set.HdmiRegNum;
+	info->dp0_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp0_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp0_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_reg_num; i++) {
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp0_ext_hdmi_6g_reg_num = info_v2_1->dp0_retimer_set.Hdmi6GRegNum;
+	info->dp0_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp0_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp0_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_6g_reg_num; i++) {
 		info->dp0_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2074,14 +2086,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp1_ext_hdmi_slv_addr = info_v2_1->dp1_retimer_set.HdmiSlvAddr;
-	info->dp1_ext_hdmi_reg_num = info_v2_1->dp1_retimer_set.HdmiRegNum;
+	info->dp1_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp1_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp1_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_reg_num; i++) {
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp1_ext_hdmi_6g_reg_num = info_v2_1->dp1_retimer_set.Hdmi6GRegNum;
+	info->dp1_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp1_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp1_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_6g_reg_num; i++) {
 		info->dp1_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2089,14 +2103,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp2_ext_hdmi_slv_addr = info_v2_1->dp2_retimer_set.HdmiSlvAddr;
-	info->dp2_ext_hdmi_reg_num = info_v2_1->dp2_retimer_set.HdmiRegNum;
+	info->dp2_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp2_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp2_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_reg_num; i++) {
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp2_ext_hdmi_6g_reg_num = info_v2_1->dp2_retimer_set.Hdmi6GRegNum;
+	info->dp2_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp2_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp2_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_6g_reg_num; i++) {
 		info->dp2_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2104,14 +2120,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp3_ext_hdmi_slv_addr = info_v2_1->dp3_retimer_set.HdmiSlvAddr;
-	info->dp3_ext_hdmi_reg_num = info_v2_1->dp3_retimer_set.HdmiRegNum;
+	info->dp3_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp3_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp3_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_reg_num; i++) {
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp3_ext_hdmi_6g_reg_num = info_v2_1->dp3_retimer_set.Hdmi6GRegNum;
+	info->dp3_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp3_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp3_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_6g_reg_num; i++) {
 		info->dp3_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp3_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 40286e8dd4e1..65ed5b5a1935 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -533,7 +533,8 @@ enum mod_hdcp_status mod_hdcp_read_rx_id_list(struct mod_hdcp *hdcp)
 	} else {
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
 				hdcp->auth.msg.hdcp2.rx_id_list,
-				hdcp->auth.msg.hdcp2.rx_id_list_size);
+				MIN(hdcp->auth.msg.hdcp2.rx_id_list_size,
+				    sizeof(hdcp->auth.msg.hdcp2.rx_id_list)));
 	}
 	return status;
 }
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index c0155c6271bf..0fee78756c38 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -18,16 +18,16 @@
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
+
+/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
 
-#define SYNTHVID_DEPTH_WIN7 16
 #define SYNTHVID_DEPTH_WIN8 32
-#define SYNTHVID_FB_SIZE_WIN7 (4 * 1024 * 1024)
+#define SYNTHVID_WIDTH_WIN8 1600
+#define SYNTHVID_HEIGHT_WIN8 1200
 #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
-#define SYNTHVID_WIDTH_MAX_WIN7 1600
-#define SYNTHVID_HEIGHT_MAX_WIN7 1200
 
 enum pipe_msg_type {
 	PIPE_MSG_INVALID,
@@ -396,8 +396,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
@@ -422,30 +425,92 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev)
+static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
 	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
+	size_t hdr_size;
+	size_t need;
 
 	if (!hv)
 		return;
 
-	msg = (struct synthvid_msg *)hv->recv_buf;
-
-	/* Complete the wait event */
-	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
-	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
-	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
-		complete(&hv->wait);
+	hdr_size = sizeof(struct pipe_msg_hdr) +
+		   sizeof(struct synthvid_msg_hdr);
+	if (bytes_recvd < hdr_size) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for header: %u\n",
+				    bytes_recvd);
 		return;
 	}
 
-	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+	msg = (struct synthvid_msg *)hv->recv_buf;
+	need = hdr_size;
+
+	switch (msg->vid_hdr.type) {
+	case SYNTHVID_VERSION_RESPONSE:
+		need += sizeof(struct synthvid_version_resp);
+		break;
+	case SYNTHVID_RESOLUTION_RESPONSE:
+		/*
+		 * The resolution response is variable length: the host
+		 * fills resolution_count entries, not the full
+		 * SYNTHVID_MAX_RESOLUTION_COUNT array. Require the fixed
+		 * prefix first so resolution_count can be read, then
+		 * demand exactly the count-sized array.
+		 */
+		need += offsetof(struct synthvid_supported_resolution_resp,
+				 supported_resolution);
+		if (bytes_recvd < need)
+			break;
+		if (msg->resolution_resp.resolution_count >
+		    SYNTHVID_MAX_RESOLUTION_COUNT) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid resolution count too large: %u\n",
+					    msg->resolution_resp.resolution_count);
+			return;
+		}
+		need += msg->resolution_resp.resolution_count *
+			sizeof(struct hvd_screen_info);
+		break;
+	case SYNTHVID_VRAM_LOCATION_ACK:
+		need += sizeof(struct synthvid_vram_location_ack);
+		break;
+	case SYNTHVID_FEATURE_CHANGE:
+		/*
+		 * Not a completion-driving message: validate its own payload
+		 * and consume it here rather than falling through to the
+		 * memcpy/complete shared by the wait-event responses.
+		 */
+		if (bytes_recvd < need +
+		    sizeof(struct synthvid_feature_change)) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid feature change packet too small: %u\n",
+					    bytes_recvd);
+			return;
+		}
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
+		return;
+	default:
+		return;
+	}
+
+	/*
+	 * Shared completion path for the wait-event responses
+	 * (VERSION_RESPONSE, RESOLUTION_RESPONSE, VRAM_LOCATION_ACK):
+	 * require the type-specific payload before handing the buffer to
+	 * the waiter.
+	 */
+	if (bytes_recvd < need) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for type %u: %u < %zu\n",
+				    msg->vid_hdr.type, bytes_recvd, need);
+		return;
 	}
+	memcpy(hv->init_buf, msg, bytes_recvd);
+	complete(&hv->wait);
 }
 
 static void hyperv_receive(void *ctx)
@@ -466,9 +531,21 @@ static void hyperv_receive(void *ctx)
 		ret = vmbus_recvpacket(hdev->channel, recv_buf,
 				       VMBUS_MAX_PACKET_SIZE,
 				       &bytes_recvd, &req_id);
-		if (bytes_recvd > 0 &&
-		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+		if (ret) {
+			/*
+			 * A nonzero return (e.g. -ENOBUFS for an oversized
+			 * packet) is itself a malformed message: bytes_recvd
+			 * then reports the required length rather than a copied
+			 * payload, so it must not be forwarded to the
+			 * sub-handler. Channel recovery is not attempted.
+			 */
+			drm_err_ratelimited(&hv->dev,
+					    "vmbus_recvpacket failed: %d (need %u)\n",
+					    ret, bytes_recvd);
+		} else if (bytes_recvd > 0 &&
+			   recv_buf->pipe_hdr.type == PIPE_MSG_DATA) {
+			hyperv_receive_sub(hdev, bytes_recvd);
+		}
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
@@ -496,12 +573,6 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
 		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WS2008:
-	case VERSION_WIN7:
-		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN7);
 		break;
 	default:
 		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
@@ -513,18 +584,19 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		goto error;
 	}
 
-	if (hv->synthvid_version == SYNTHVID_VERSION_WIN7)
-		hv->screen_depth = SYNTHVID_DEPTH_WIN7;
-	else
-		hv->screen_depth = SYNTHVID_DEPTH_WIN8;
+	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
 	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
-		hv->screen_width_max = SYNTHVID_WIDTH_MAX_WIN7;
-		hv->screen_height_max = SYNTHVID_HEIGHT_MAX_WIN7;
+	}
+
+	if (!hv->screen_width_max) {
+		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
+		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 90e055f05699..ef4c280d2cb6 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1554,6 +1554,7 @@ struct intel_dp {
 	u8 lttpr_phy_caps[DP_MAX_LTTPR_COUNT][DP_LTTPR_PHY_CAP_SIZE];
 	u8 fec_capable;
 	u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE];
+	u8 intel_wa_dpcd;
 	/* source rates */
 	int num_source_rates;
 	const int *source_rates;
diff --git a/drivers/gpu/drm/i915/display/intel_dpcd.h b/drivers/gpu/drm/i915/display/intel_dpcd.h
new file mode 100644
index 000000000000..4aea5326f2ed
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_dpcd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef __INTEL_DPCD_H__
+#define __INTEL_DPCD_H__
+
+#define INTEL_DPCD_INTEL_WA_REGISTER_CAPS					0x3f0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK	REG_GENMASK(1, 0)
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1			0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE		1
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE		2
+
+#endif /* __INTEL_DPCD_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 93d2fd4cd16b..fca55ae3ffe5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -30,6 +30,7 @@
 #include "intel_atomic.h"
 #include "intel_de.h"
 #include "intel_display_types.h"
+#include "intel_dpcd.h"
 #include "intel_dp_aux.h"
 #include "intel_hdmi.h"
 #include "intel_psr.h"
@@ -363,6 +364,12 @@ void intel_psr_init_dpcd(struct intel_dp *intel_dp)
 			intel_dp_get_su_granularity(intel_dp);
 		}
 	}
+
+	if (intel_dp->psr.sink_psr2_support)
+		drm_dp_dpcd_read(&intel_dp->aux,
+				 INTEL_DPCD_INTEL_WA_REGISTER_CAPS,
+				 &intel_dp->intel_wa_dpcd,
+				 sizeof(intel_dp->intel_wa_dpcd));
 }
 
 static void hsw_psr_setup_aux(struct intel_dp *intel_dp)
@@ -817,6 +824,30 @@ static bool psr2_granularity_check(struct intel_dp *intel_dp,
 	return true;
 }
 
+static bool apply_scanline_indication_wa(struct intel_dp *intel_dp,
+					 struct intel_crtc_state *crtc_state)
+{
+	u8 early_scanline_support = intel_dp->intel_wa_dpcd &
+		INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK;
+
+	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
+		return true;
+
+	switch (early_scanline_support)	{
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return false;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE:
+		return true;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return true;
+	default:
+		MISSING_CASE(early_scanline_support);
+		return false;
+	}
+}
+
 static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_dp,
 							struct intel_crtc_state *crtc_state)
 {
@@ -837,7 +868,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(intel_dp, crtc_state);
 }
 
 static bool _compute_psr2_wake_times(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
index 7986612f48fa..e8aa6d9acfda 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
@@ -16,6 +16,17 @@
 #include "i915_gem_region.h"
 #include "i915_scatterlist.h"
 
+/* Abuse scatterlist to store pointer instead of struct page. */
+static inline void __set_phys_vaddr(struct scatterlist *sg, void *vaddr)
+{
+	sg_assign_page(sg, (struct page *)vaddr);
+}
+
+static inline void *__get_phys_vaddr(struct scatterlist *sg)
+{
+	return (void *)sg_page(sg);
+}
+
 static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
@@ -51,7 +62,7 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	sg->offset = 0;
 	sg->length = obj->base.size;
 
-	sg_assign_page(sg, (struct page *)vaddr);
+	__set_phys_vaddr(sg, vaddr);
 	sg_dma_address(sg) = dma;
 	sg_dma_len(sg) = obj->base.size;
 
@@ -95,7 +106,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 			       struct sg_table *pages)
 {
 	dma_addr_t dma = sg_dma_address(pages->sgl);
-	void *vaddr = sg_page(pages->sgl);
+	void *vaddr = __get_phys_vaddr(pages->sgl);
 
 	__i915_gem_object_release_shmem(obj, pages, false);
 
@@ -138,7 +149,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
 int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
 				const struct drm_i915_gem_pwrite *args)
 {
-	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
+	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
 	char __user *user_data = u64_to_user_ptr(args->data_ptr);
 	int err;
 
@@ -168,7 +179,7 @@ int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
 int i915_gem_object_pread_phys(struct drm_i915_gem_object *obj,
 			       const struct drm_i915_gem_pread *args)
 {
-	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
+	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
 	char __user *user_data = u64_to_user_ptr(args->data_ptr);
 	int err;
 
diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
index 47852b9dd5ea..d2a89a99bd71 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
@@ -166,6 +166,7 @@ static int exp_approx_q(int x)
  * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
  * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
  * @use_5_taps: indicates whether to use 5 taps or 7 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output filter coefficients
  */
 static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
@@ -262,7 +263,9 @@ static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
  * @src_length: length of input
  * @dst_length: length of output
  * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output coefficients
+ * @nn_interpolation: whether to use nearest neighbor instead of gaussian filter
  */
 static void dcss_scaler_filter_design(int src_length, int dst_length,
 				      bool use_5_taps, bool phase0_identity,
diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index 7cf82b071de2..82543a23ec06 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -288,15 +288,16 @@ static bool require_uniform_address_uniform(struct vc4_validated_shader_info *va
 {
 	uint32_t o = validated_shader->num_uniform_addr_offsets;
 	uint32_t num_uniforms = validated_shader->uniforms_size / 4;
+	u32 *offsets;
 
-	validated_shader->uniform_addr_offsets =
-		krealloc(validated_shader->uniform_addr_offsets,
-			 (o + 1) *
-			 sizeof(*validated_shader->uniform_addr_offsets),
-			 GFP_KERNEL);
-	if (!validated_shader->uniform_addr_offsets)
+	offsets = krealloc_array(validated_shader->uniform_addr_offsets,
+				 o + 1,
+				 sizeof(*validated_shader->uniform_addr_offsets),
+				 GFP_KERNEL);
+	if (!offsets)
 		return false;
 
+	validated_shader->uniform_addr_offsets = offsets;
 	validated_shader->uniform_addr_offsets[o] = num_uniforms;
 	validated_shader->num_uniform_addr_offsets++;
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4fb573ee31b2..e106b59b55da 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1775,8 +1775,8 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
-		int interrupt)
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
@@ -1784,16 +1784,24 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 	int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	unsigned int a;
 	u32 rsize, csize = size;
+	size_t bsize = bufsize;
 	u8 *cdata = data;
 	int ret = 0;
 
 	report = hid_get_report(report_enum, data);
 	if (!report)
-		goto out;
+		return 0;
+
+	if (unlikely(bsize < csize)) {
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
+				     report->id, csize, bsize);
+		return -EINVAL;
+	}
 
 	if (report_enum->numbered) {
 		cdata++;
 		csize--;
+		bsize--;
 	}
 
 	rsize = hid_compute_report_size(report);
@@ -1806,9 +1814,15 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 	else if (rsize > max_buffer_size)
 		rsize = max_buffer_size;
 
+	if (bsize < rsize) {
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
+				     report->id, rsize, bsize);
+		return -EINVAL;
+	}
+
 	if (csize < rsize) {
 		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
+			csize, rsize);
 		memset(cdata + csize, 0, rsize - csize);
 	}
 
@@ -1817,7 +1831,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 	if (hid->claimed & HID_CLAIMED_HIDRAW) {
 		ret = hidraw_report_event(hid, data, size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield) {
@@ -1830,7 +1844,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
-out:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
@@ -1851,6 +1865,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
+	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -1889,7 +1904,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
 			goto unlock;
 	}
 
-	ret = hid_report_raw_event(hid, type, data, size, interrupt);
+	ret = hid_report_raw_event(hid, type, data, bufsize, size, interrupt);
 
 unlock:
 	up(&hid->driver_input_lock);
diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 699186ff2349..d2a56bf92b41 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -66,7 +66,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 	switch (data[1]) {
 	case GFRM100_SEARCH_KEY_DOWN:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_dn,
-					   sizeof(search_key_dn), 1);
+					   sizeof(search_key_dn), sizeof(search_key_dn), 1);
 		break;
 
 	case GFRM100_SEARCH_KEY_AUDIO_DATA:
@@ -74,7 +74,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	case GFRM100_SEARCH_KEY_UP:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_up,
-					   sizeof(search_key_up), 1);
+					   sizeof(search_key_up), sizeof(search_key_up), 1);
 		break;
 
 	default:
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7ed851bf5bc8..812ed660c555 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3440,7 +3440,7 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
 	memcpy(&consumer_report[1], &data[3], 4);
 	/* We are called from atomic context */
 	hid_report_raw_event(hidpp->hid_dev, HID_INPUT_REPORT,
-			     consumer_report, 5, 1);
+			     consumer_report, sizeof(consumer_report), 5, 1);
 
 	return 1;
 }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 7a092a2a1bf0..df87d7ae94c4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -479,7 +479,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		}
 
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
-					   size, 0);
+					   size, size, 0);
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c
index 1e6413d07cae..16e2a811eda9 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -44,7 +44,7 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 			data[0] |= (1 << (data[idx] - 0xE0));
 			data[idx] = 0;
 		}
-		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, 0);
+		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, size, 0);
 		return 1;
 
 	default:	/* unknown report */
diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index d57ec1767037..fdfea1355ee7 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -126,7 +126,7 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 	}
 
 	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
-				   report_len, 0);
+				   report_len, report_len, 0);
 	if (ret) {
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
 			 field->report->id);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c8a8daedff3d..07de763a4ee3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -79,7 +79,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		int err;
 
 		size = kfifo_out(fifo, buf, sizeof(buf));
-		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
+		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
 		if (err) {
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
@@ -324,7 +324,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					       data, n, WAC_CMD_RETRIES);
 			if (ret == n && features->type == HID_GENERIC) {
 				ret = hid_report_raw_event(hdev,
-					HID_FEATURE_REPORT, data, n, 0);
+					HID_FEATURE_REPORT, data, n, n, 0);
 			} else if (ret == 2 && features->type != HID_GENERIC) {
 				features->touch_max = data[1];
 			} else {
@@ -346,6 +346,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
+		hid_data->inputmode_field_index = field->index;
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -385,7 +386,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					data, n, WAC_CMD_RETRIES);
 		if (ret == n) {
 			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
-						   data, n, 0);
+						   data, n, n, 0);
 		} else {
 			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
 				 __func__);
@@ -561,9 +562,14 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 
 	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
 	r = re->report_id_hash[hid_data->inputmode];
-	if (r) {
-		r->field[0]->value[hid_data->inputmode_index] = 2;
-		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+	if (r && hid_data->inputmode_field_index >= 0 &&
+	    hid_data->inputmode_field_index < r->maxfield) {
+		struct hid_field *field = r->field[hid_data->inputmode_field_index];
+
+		if (field && hid_data->inputmode_index < field->report_count) {
+			field->value[hid_data->inputmode_index] = 2;
+			hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+		}
 	}
 	return 0;
 }
@@ -2821,6 +2827,7 @@ static int wacom_probe(struct hid_device *hdev,
 		return error;
 
 	wacom_wac->hid_data.inputmode = -1;
+	wacom_wac->hid_data.inputmode_field_index = -1;
 	wacom_wac->mode_report = -1;
 
 	if (hid_is_usb(hdev)) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 4ea1910ec3fa..0491b19430cd 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -296,6 +296,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode_field_index; /* InputMode HID feature field index in the report */
 	bool sense_state;
 	bool inrange_state;
 	bool invert_state;
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 2bdb86ab2ea8..eae21899e0f3 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -683,8 +683,8 @@ static int cci_remove(struct platform_device *pdev)
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			of_node_put(cci->master[i].adap.dev.of_node);
+			cci_halt(cci, i);
 		}
-		cci_halt(cci, i);
 	}
 
 	disable_irq(cci->irq);
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 654776a5c37b..caeddb750006 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -673,6 +673,9 @@ static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 	if (!of_property_read_bool(i2c_dev->dev->of_node, "i2c-digital-filter"))
 		i2c_dev->dnf_dt = STM32F7_I2C_DNF_DEFAULT;
 
+	i2c_dev->analog_filter = of_property_read_bool(i2c_dev->dev->of_node,
+						       "i2c-analog-filter");
+
 	do {
 		ret = stm32f7_i2c_compute_timing(i2c_dev, setup,
 						 &i2c_dev->timing);
@@ -694,9 +697,6 @@ static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 		return ret;
 	}
 
-	i2c_dev->analog_filter = of_property_read_bool(i2c_dev->dev->of_node,
-						       "i2c-analog-filter");
-
 	dev_dbg(i2c_dev->dev, "I2C Speed(%i), Clk Source(%i)\n",
 		setup->speed_freq, setup->clock_src);
 	dev_dbg(i2c_dev->dev, "I2C Rise(%i) and Fall(%i) Time\n",
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 444867cef682..996d6ecec7e4 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1873,29 +1873,38 @@ static int __maybe_unused tegra_i2c_runtime_suspend(struct device *dev)
 }
 
 static int __maybe_unused tegra_i2c_suspend(struct device *dev)
+{
+	/*
+	 * Bring the controller up and hold a usage count so it stays
+	 * available until the noirq phase.
+	 */
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int __maybe_unused tegra_i2c_suspend_noirq(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-	int err;
 
 	i2c_mark_adapter_suspended(&i2c_dev->adapter);
 
-	if (!pm_runtime_status_suspended(dev)) {
-		err = tegra_i2c_runtime_suspend(dev);
-		if (err)
-			return err;
-	}
-
-	return 0;
+	/*
+	 * Runtime PM is already disabled at this point, so invoke the
+	 * runtime_suspend callback directly to put the controller down.
+	 */
+	return tegra_i2c_runtime_suspend(dev);
 }
 
-static int __maybe_unused tegra_i2c_resume(struct device *dev)
+static int __maybe_unused tegra_i2c_resume_noirq(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int err;
 
 	/*
-	 * We need to ensure that clocks are enabled so that registers can be
-	 * restored in tegra_i2c_init().
+	 * Runtime PM is still disabled at this point, so invoke the
+	 * runtime_resume callback directly to bring the controller back up
+	 * before re-initializing the hardware. The adapter is then marked
+	 * resumed so that consumers can issue transfers from their own
+	 * resume_noirq() handlers and onwards.
 	 */
 	err = tegra_i2c_runtime_resume(dev);
 	if (err)
@@ -1905,24 +1914,22 @@ static int __maybe_unused tegra_i2c_resume(struct device *dev)
 	if (err)
 		return err;
 
-	/*
-	 * In case we are runtime suspended, disable clocks again so that we
-	 * don't unbalance the clock reference counts during the next runtime
-	 * resume transition.
-	 */
-	if (pm_runtime_status_suspended(dev)) {
-		err = tegra_i2c_runtime_suspend(dev);
-		if (err)
-			return err;
-	}
-
 	i2c_mark_adapter_resumed(&i2c_dev->adapter);
 
 	return 0;
 }
 
+static int __maybe_unused tegra_i2c_resume(struct device *dev)
+{
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops tegra_i2c_pm = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend_noirq,
+				      tegra_i2c_resume_noirq)
 	SET_RUNTIME_PM_OPS(tegra_i2c_runtime_suspend, tegra_i2c_runtime_resume,
 			   NULL)
 };
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 9fefceb3a95d..e18d14bf94a9 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -476,12 +476,13 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-		if (arg > INT_MAX)
+		/*
+		 * For historical reasons, user-space sets the timeout value in
+		 * units of 10 ms.
+		 */
+		if (arg > INT_MAX / 10)
 			return -EINVAL;
 
-		/* For historical reasons, user-space sets the timeout
-		 * value in units of 10 ms.
-		 */
 		client->adapter->timeout = msecs_to_jiffies(arg * 10);
 		break;
 	default:
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 1028b101cf56..8723b21c0230 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
 			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
-			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			mutex_unlock(&vb->lock);
 			error = -EREMOTEIO;
+			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 9fa754b56b52..644e69e26039 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -819,6 +819,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
+	int seq_mode;
 	int ret;
 	int i;
 
@@ -826,6 +827,12 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels; i++)
 		scan_mask |= BIT(indio_dev->channels[i].scan_index);
 
+	/*
+	 * Use the correct sequencer mode for the idle state: simultaneous
+	 * mode for dual external mux configurations, continuous otherwise.
+	 */
+	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
+
 	/* Enable all channels and calibration */
 	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
 	if (ret)
@@ -836,11 +843,11 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_CONTINUOUS);
+				  seq_mode);
 	if (ret)
 		return ret;
 
-	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
+	return xadc_power_adc_b(xadc, seq_mode);
 }
 
 static int xadc_preenable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 87d9aabd20c7..4c64f9afd315 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -82,7 +82,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
  */
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 {
-	struct hw_consumer_buffer *buf;
+	struct hw_consumer_buffer *buf, *tmp;
 	struct iio_hw_consumer *hwc;
 	struct iio_channel *chan;
 	int ret;
@@ -113,7 +113,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 	return hwc;
 
 err_put_buffers:
-	list_for_each_entry(buf, &hwc->buffers, head)
+	list_for_each_entry_safe(buf, tmp, &hwc->buffers, head)
 		iio_buffer_put(&buf->buffer);
 	iio_channel_release_all(hwc->channels);
 err_free_hwc:
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 9fe6bbe9ee04..26216154c859 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -198,112 +199,104 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			  int *val, int *val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 	u16 tmp;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->output) {
 			*val = state->pressure_comp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		}
 
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
+			return ret;
 
 		ret = scd30_read(state);
 		if (ret) {
 			iio_device_release_direct_mode(indio_dev);
-			break;
+			return ret;
 		}
 
 		*val = state->meas[chan->address];
 		iio_device_release_direct_mode(indio_dev);
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = 1;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scd30_command_read(state, CMD_MEAS_INTERVAL, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = 0;
 		*val2 = 1000000000 / tmp;
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = scd30_command_read(state, CMD_TEMP_OFFSET, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = tmp;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 			   int val, int val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
-			break;
+		if (val || !val2)
+			return -EINVAL;
 
 		val = 1000000000 / val2;
 		if (val < SCD30_MEAS_INTERVAL_MIN_S || val > SCD30_MEAS_INTERVAL_MAX_S)
-			break;
+			return -EINVAL;
 
 		ret = scd30_command_write(state, CMD_MEAS_INTERVAL, val);
 		if (ret)
-			break;
+			return ret;
 
 		state->meas_interval = val;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_PRESSURE:
 			if (val < SCD30_PRESSURE_COMP_MIN_MBAR ||
 			    val > SCD30_PRESSURE_COMP_MAX_MBAR)
-				break;
+				return -EINVAL;
 
 			ret = scd30_command_write(state, CMD_START_MEAS, val);
 			if (ret)
-				break;
+				return ret;
 
 			state->pressure_comp = val;
-			break;
+			return 0;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val < 0 || val > SCD30_TEMP_OFFSET_MAX)
-			break;
+			return -EINVAL;
 		/*
 		 * Manufacturer does not explicitly specify min/max sensible
 		 * values hence check is omitted for simplicity.
 		 */
-		ret = scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+		return scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw_get_fmt(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index dd0e8dc2377a..79487c1e5ff5 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -602,6 +602,7 @@ static int ssp_remove(struct spi_device *spi)
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
+	cancel_delayed_work_sync(&data->work_refresh);
 
 	del_timer_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index be705f8148cc..584f232f0899 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -154,7 +154,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&st->lock);
@@ -513,7 +513,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -525,9 +525,9 @@ int ad5686_probe(struct device *dev,
 		goto error_disable_reg;
 	}
 
-	val = (voltage_uv | ref_bit_msk);
+	val = voltage_uv ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		goto error_disable_reg;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index f89a6f92b427..62f6c52b0316 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -44,6 +44,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index bd0b7f361154..db768aebb269 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -91,6 +91,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -104,7 +105,13 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(outbuf))
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index eaf57bd339ed..36130446c82f 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -288,6 +288,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		adis_dev_lock(adis);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index d1c125a77308..5391a5bd0cc7 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -34,7 +34,7 @@ static int itg3200_read_all_channels(struct i2c_client *i2c, __be16 *buf)
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
-			.buf = (char *)&buf,
+			.buf = (char *)buf,
 		},
 	};
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 93b8b5da74c5..2ca90a247b88 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -585,7 +585,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	 * must be passed a buffer that is aligned to 8 bytes so
 	 * as to allow insertion of a naturally aligned timestamp.
 	 */
-	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
+	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8) = { };
 	u8 tag;
 	bool reset_ts = false;
 	int i, err, read_len;
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index fd9a8c27de2e..1ab708b9a072 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 9ffd50d796bf..824b1cd6429b 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -504,6 +504,11 @@ static const struct st_sensors_platform_data default_magn_pdata = {
 	.drdy_int_pin = 2,
 };
 
+/* LIS2MDL only supports DRDY on INT1 */
+static const struct st_sensors_platform_data alt_magn_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -632,8 +637,12 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	if (!pdata) {
+		if (mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index bbfbad9a8767..0350b066dc8f 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }
diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 8ab4eea5a0a5..394d7e1f7375 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o iter.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
new file mode 100644
index 000000000000..3ed351e8fcf6
--- /dev/null
+++ b/drivers/infiniband/core/iter.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#include <linux/export.h>
+#include <rdma/iter.h>
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist, unsigned int nents,
+			     unsigned long pgsz)
+{
+	memset(biter, 0, sizeof(struct ib_block_iter));
+	biter->__sg = sglist;
+	biter->__sg_nents = nents;
+
+	/* Driver provides best block size to use */
+	biter->__pg_bit = __fls(pgsz);
+}
+EXPORT_SYMBOL(__rdma_block_iter_start);
+
+bool __rdma_block_iter_next(struct ib_block_iter *biter)
+{
+	dma_addr_t block_offset;
+	dma_addr_t delta;
+
+	if (!biter->__sg_nents || !biter->__sg)
+		return false;
+
+	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
+	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
+	delta = BIT_ULL(biter->__pg_bit) - block_offset;
+
+	while (biter->__sg_nents && biter->__sg &&
+	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
+		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
+		biter->__sg_advance = 0;
+		biter->__sg = sg_next(biter->__sg);
+		biter->__sg_nents--;
+	}
+	biter->__sg_advance += delta;
+
+	return true;
+}
+EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 53552559917c..e18f1f211af0 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2950,41 +2950,3 @@ int rdma_init_netdev(struct ib_device *device, u32 port_num,
 					     netdev, params.param);
 }
 EXPORT_SYMBOL(rdma_init_netdev);
-
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist, unsigned int nents,
-			     unsigned long pgsz)
-{
-	memset(biter, 0, sizeof(struct ib_block_iter));
-	biter->__sg = sglist;
-	biter->__sg_nents = nents;
-
-	/* Driver provides best block size to use */
-	biter->__pg_bit = __fls(pgsz);
-}
-EXPORT_SYMBOL(__rdma_block_iter_start);
-
-bool __rdma_block_iter_next(struct ib_block_iter *biter)
-{
-	unsigned int block_offset;
-	unsigned int delta;
-
-	if (!biter->__sg_nents || !biter->__sg)
-		return false;
-
-	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
-	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	delta = BIT_ULL(biter->__pg_bit) - block_offset;
-
-	while (biter->__sg_nents && biter->__sg &&
-	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
-		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
-		biter->__sg_advance = 0;
-		biter->__sg = sg_next(biter->__sg);
-		biter->__sg_nents--;
-	}
-	biter->__sg_advance += delta;
-
-	return true;
-}
-EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 2bdb428fd273..64c3ef8985ee 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -46,7 +46,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <rdma/ib_verbs.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index a2c71a1d93d5..88db7e527728 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -32,9 +32,9 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <rdma/ib_umem.h>
 #include <linux/atomic.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "iw_cxgb4.h"
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index cacdf4af9206..7ef8bc61e568 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -7,9 +7,9 @@
 #include <linux/log2.h>
 
 #include <rdma/ib_addr.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index d4fa0fd52294..a34483af9696 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -34,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include "hns_roce_device.h"
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
 {
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 0e998e080198..2e3a0933c0f0 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -37,8 +37,8 @@
 #include <rdma/rdma_cm.h>
 #include <rdma/iw_cm.h>
 #include <rdma/ib_user_verbs.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 #include "status.h"
 #include "osdep.h"
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index a40bf58bcdd3..004311925dbf 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -33,6 +33,7 @@
 
 #include <linux/slab.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "mlx4_ib.h"
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 844545064c9e..0ef192546f6d 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 768aba0987cc..adbd1509306a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -42,6 +42,7 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include "dm.h"
 #include "mlx5_ib.h"
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 0db6b391fada..736c65006789 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -35,8 +35,8 @@
  */
 
 #include <rdma/ib_smi.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/sched.h>
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 4b8f990955f9..df223f20e696 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -44,9 +44,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "ocrdma.h"
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index c0993e3bad12..d1879483b2b9 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -39,9 +39,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/qed/common_hsi.h>
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index 763ddc6f25d1..23e547d4b3a7 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -53,8 +53,8 @@
 #include <linux/pci.h>
 #include <linux/semaphore.h>
 #include <linux/workqueue.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/vmw_pvrdma-abi.h>
 
 #include "pvrdma_ring.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 05ae3d183b21..595d4e7b91d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -100,8 +100,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		return -ENOMEM;
 	}
 
-	srq->rq.queue = q;
-
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
 			   q->buf_size, &q->ip);
 	if (err) {
@@ -119,7 +117,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	}
 
 	srq->rq.queue = q;
-	init->attr.max_wr = srq->rq.max_wr;
 
 	return 0;
 }
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 6082695a02d8..35d840e7e668 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1388,6 +1388,12 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
 			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
+	if (unlikely(wc->byte_len < ISER_HEADERS_LEN)) {
+		isert_dbg("login request length %u is too short\n",
+			  wc->byte_len);
+		return;
+	}
+
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
 	if (isert_conn->conn) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index dbd51e5be3a6..797d5d61c0b2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -968,7 +968,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	refcount_set(&req->ref, 1);
 	req->mp_policy = clt_path->clt->mp_policy;
 
-	iov_iter_kvec(&iter, WRITE, vec, 1, usr_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, 1, usr_len);
 	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
 	WARN_ON(len != usr_len);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2938d7040f90..bc10eca37c24 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1929,7 +1929,8 @@ static int srp_post_recv(struct srp_rdma_ch *ch, struct srp_iu *iu)
 	return ib_post_recv(ch->qp, &wr, NULL);
 }
 
-static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
+static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp,
+			    u32 byte_len)
 {
 	struct srp_target_port *target = ch->target;
 	struct srp_request *req;
@@ -1970,10 +1971,27 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		scmnd->result = rsp->status;
 
 		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
-			memcpy(scmnd->sense_buffer, rsp->data +
-			       be32_to_cpu(rsp->resp_data_len),
-			       min_t(int, be32_to_cpu(rsp->sense_data_len),
-				     SCSI_SENSE_BUFFERSIZE));
+			u32 resp_len = be32_to_cpu(rsp->resp_data_len);
+			u32 sense_len = be32_to_cpu(rsp->sense_data_len);
+
+			/*
+			 * The sense data starts resp_data_len bytes past the
+			 * response data area; both lengths come from the
+			 * target-controlled response.  Copy the sense data
+			 * only if it has not been truncated, that is, only if
+			 * the full sense region fits within the bytes actually
+			 * received.  Otherwise the copy source would run past
+			 * the receive buffer (sized to the target-chosen
+			 * max_ti_iu_len), reading out of bounds.
+			 */
+			if (sizeof(*rsp) + (u64)resp_len + sense_len <= byte_len)
+				memcpy(scmnd->sense_buffer,
+				       rsp->data + resp_len,
+				       min(sense_len, SCSI_SENSE_BUFFERSIZE));
+			else
+				shost_printk(KERN_ERR, target->scsi_host,
+					     "dropping truncated sense data (resp_data_len %u sense_data_len %u, %u bytes received)\n",
+					     resp_len, sense_len, byte_len);
 		}
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
@@ -2083,7 +2101,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	switch (opcode) {
 	case SRP_RSP:
-		srp_process_rsp(ch, iu->buf);
+		srp_process_rsp(ch, iu->buf, wc->byte_len);
 		break;
 
 	case SRP_CRED_REQ:
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 1c033020efc4..bc7f16e0ac83 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1939,6 +1939,21 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 67636fd217fa..596202206a15 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1598,7 +1598,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
 	usb_kill_urb(pcu->urb_in);
 	usb_free_urb(pcu->urb_in);
 
-	usb_free_coherent(pcu->udev, pcu->max_out_size,
+	usb_free_coherent(pcu->udev, pcu->max_in_size,
 			  pcu->urb_in_buf, pcu->read_dma);
 
 	kfree(pcu->urb_out_buf);
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index a5f067b93ab9..4f421dcdb93b 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -646,6 +646,11 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 		return error;
 	}
 
+	if (fw->size < data->fw_signature_address + sizeof(signature)) {
+		dev_err(dev, "firmware file too small\n");
+		return -EBADF;
+	}
+
 	/* Firmware file must match signature data */
 	fw_signature = &fw->data[data->fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) != 0) {
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 058a15276982..e53795136d86 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -187,6 +187,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"LEN2058", /* E490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index cbff90382ad7..ed8088d4b835 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1443,7 +1443,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 			}
 			cfg->raw_pos += offset;
 
-			if (i > mxt_obj_size(object))
+			if (i >= mxt_obj_size(object))
 				continue;
 
 			byte_offset = reg + i - cfg->start_ofs;
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 43c521f50c85..8dceda54c9a5 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1061,6 +1061,11 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 	if (x_len > 0xff)
 		x_len -= 0x80;
 
+	if (data_len > usbtouch->data_size - sizeof(*packet))
+		data_len = usbtouch->data_size - sizeof(*packet);
+	if (x_len > data_len)
+		x_len = data_len;
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 	if (ret)
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index ba3115fd0f86..70fdbedd78b7 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -910,21 +910,27 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
 
-static void __init dummy_tlb_flush_all(void *cookie)
+/*
+ * __noipa prevents gcc from turning indirect iommu_flush_ops calls
+ * into direct calls from a specialized __arm_v7s_unmap() that triggers
+ * a build time section mismatch assertion.
+ */
+static __noipa void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static __noipa void __init dummy_tlb_flush(unsigned long iova, size_t size,
+					   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static __noipa void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+					      unsigned long iova,
+					      size_t granule,
+					      void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a77195e378b7..c24771336f61 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -706,7 +706,7 @@ l1oip_socket_thread(void *data)
 		printk(KERN_DEBUG "%s: socket created and open\n",
 		       __func__);
 	while (!signal_pending(current)) {
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, recvbuf_size);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, recvbuf_size);
 		recvlen = sock_recvmsg(socket, &msg, 0);
 		if (recvlen > 0) {
 			l1oip_socket_parse(hc, &sin_rx, recvbuf, recvlen);
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 95b0670c32ac..e5c4d7ff2c65 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -1585,18 +1585,22 @@ static int smq_invalidate_mapping(struct dm_cache_policy *p, dm_cblock_t cblock)
 	struct smq_policy *mq = to_smq_policy(p);
 	struct entry *e = get_entry(&mq->cache_alloc, from_cblock(cblock));
 	unsigned long flags;
-
-	if (!e->allocated)
-		return -ENODATA;
+	int r = 0;
 
 	spin_lock_irqsave(&mq->lock, flags);
+	if (!e->allocated) {
+		r = -ENODATA;
+		goto out;
+	}
 	// FIXME: what if this block has pending background work?
 	del_queue(mq, e);
 	h_remove(&mq->table, e);
 	free_entry(&mq->cache_alloc, e);
+
+out:
 	spin_unlock_irqrestore(&mq->lock, flags);
 
-	return 0;
+	return r;
 }
 
 static uint32_t smq_get_hint(struct dm_cache_policy *p, dm_cblock_t cblock)
diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 3e9988ee785f..2c4aceb2a592 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
 #include <media/rc-core.h>
@@ -34,7 +35,7 @@ struct igorplugusb {
 	struct device *dev;
 
 	struct urb *urb;
-	struct usb_ctrlrequest request;
+	struct usb_ctrlrequest *request;
 
 	struct timer_list timer;
 
@@ -123,7 +124,7 @@ static void igorplugusb_cmd(struct igorplugusb *ir, int cmd)
 {
 	int ret;
 
-	ir->request.bRequest = cmd;
+	ir->request->bRequest = cmd;
 	ir->urb->transfer_flags = 0;
 	ret = usb_submit_urb(ir->urb, GFP_ATOMIC);
 	if (ret)
@@ -165,20 +166,24 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	if (!ir)
 		return -ENOMEM;
 
+	ir->request = kzalloc(sizeof(*ir->request), GFP_KERNEL);
+	if (!ir->request)
+		goto fail;
+
 	ir->dev = &intf->dev;
 
 	timer_setup(&ir->timer, igorplugusb_timer, 0);
 
-	ir->request.bRequest = GET_INFRACODE;
-	ir->request.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
-	ir->request.wLength = cpu_to_le16(sizeof(ir->buf_in));
+	ir->request->bRequest = GET_INFRACODE;
+	ir->request->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
+	ir->request->wLength = cpu_to_le16(sizeof(ir->buf_in));
 
 	ir->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ir->urb)
 		goto fail;
 
 	usb_fill_control_urb(ir->urb, udev,
-		usb_rcvctrlpipe(udev, 0), (uint8_t *)&ir->request,
+		usb_rcvctrlpipe(udev, 0), (uint8_t *)ir->request,
 		ir->buf_in, sizeof(ir->buf_in), igorplugusb_callback, ir);
 
 	usb_make_path(udev, ir->phys, sizeof(ir->phys));
@@ -223,6 +228,7 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	rc_free_device(ir->rc);
 	usb_free_urb(ir->urb);
 	del_timer(&ir->timer);
+	kfree(ir->request);
 
 	return ret;
 }
@@ -236,6 +242,7 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	usb_kill_urb(ir->urb);
 	usb_free_urb(ir->urb);
+	kfree(ir->request);
 }
 
 static const struct usb_device_id igorplugusb_table[] = {
diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 629787d53ee1..f429316bb423 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -32,7 +32,7 @@ struct ttusbir {
 
 	struct led_classdev led;
 	struct urb *bulk_urb;
-	uint8_t bulk_buffer[5];
+	u8 *bulk_buffer;
 	int bulk_out_endp, iso_in_endp;
 	bool led_on, is_led_on;
 	atomic_t led_complete;
@@ -188,13 +188,16 @@ static int ttusbir_probe(struct usb_interface *intf,
 	struct rc_dev *rc;
 	int i, j, ret;
 	int altsetting = -1;
+	u8 *buffer;
 
 	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc) {
+	if (!tt || !rc || !buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
+	tt->bulk_buffer = buffer;
 
 	/* find the correct alt setting */
 	for (i = 0; i < intf->num_altsetting && altsetting == -1; i++) {
@@ -283,8 +286,8 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt->bulk_buffer[3] = 0x01;
 
 	usb_fill_bulk_urb(tt->bulk_urb, tt->udev, usb_sndbulkpipe(tt->udev,
-		tt->bulk_out_endp), tt->bulk_buffer, sizeof(tt->bulk_buffer),
-						ttusbir_bulk_complete, tt);
+			  tt->bulk_out_endp), tt->bulk_buffer, 5,
+			  ttusbir_bulk_complete, tt);
 
 	tt->led.name = "ttusbir:green:power";
 	tt->led.default_trigger = "rc-feedback";
@@ -353,6 +356,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 		kfree(tt);
 	}
 	rc_free_device(rc);
+	kfree(buffer);
 
 	return ret;
 }
@@ -375,6 +379,7 @@ static void ttusbir_disconnect(struct usb_interface *intf)
 	}
 	usb_kill_urb(tt->bulk_urb);
 	usb_free_urb(tt->bulk_urb);
+	kfree(tt->bulk_buffer);
 	usb_set_intfdata(intf, NULL);
 	kfree(tt);
 }
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e83c1c7b34c2..c93bd19e2beb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -232,6 +232,8 @@ struct fastrpc_user {
 	spinlock_t lock;
 	/* lock for allocations */
 	struct mutex mutex;
+	/* Reference count */
+	struct kref refcount;
 };
 
 static void fastrpc_free_map(struct kref *ref)
@@ -352,15 +354,57 @@ static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
 	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
 }
 
+static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
+
+static void fastrpc_user_free(struct kref *ref)
+{
+	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
+	struct fastrpc_invoke_ctx *ctx, *n;
+	struct fastrpc_map *map, *m;
+	struct fastrpc_buf *buf, *b;
+
+	if (fl->init_mem)
+		fastrpc_buf_free(fl->init_mem);
+
+	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
+		list_del(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
+	list_for_each_entry_safe(map, m, &fl->maps, node)
+		fastrpc_map_put(map);
+
+	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
+		list_del(&buf->node);
+		fastrpc_buf_free(buf);
+	}
+
+	fastrpc_channel_ctx_put(fl->cctx);
+	mutex_destroy(&fl->mutex);
+	kfree(fl);
+}
+
+static void fastrpc_user_get(struct fastrpc_user *fl)
+{
+	kref_get(&fl->refcount);
+}
+
+static void fastrpc_user_put(struct fastrpc_user *fl)
+{
+	kref_put(&fl->refcount, fastrpc_user_free);
+}
+
 static void fastrpc_context_free(struct kref *ref)
 {
 	struct fastrpc_invoke_ctx *ctx;
 	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_user *fl;
 	unsigned long flags;
 	int i;
 
 	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
 	cctx = ctx->cctx;
+	fl = ctx->fl;
 
 	for (i = 0; i < ctx->nscalars; i++)
 		fastrpc_map_put(ctx->maps[i]);
@@ -376,6 +420,8 @@ static void fastrpc_context_free(struct kref *ref)
 	kfree(ctx->olaps);
 	kfree(ctx);
 
+	/* Release the reference taken in fastrpc_context_alloc() */
+	fastrpc_user_put(fl);
 	fastrpc_channel_ctx_put(cctx);
 }
 
@@ -485,6 +531,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	/* Released in fastrpc_context_put() */
 	fastrpc_channel_ctx_get(cctx);
+	/* Take a reference to user, released in fastrpc_context_free() */
+	fastrpc_user_get(user);
 
 	ctx->sc = sc;
 	ctx->retval = -1;
@@ -515,6 +563,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	spin_lock(&user->lock);
 	list_del(&ctx->node);
 	spin_unlock(&user->lock);
+	fastrpc_user_put(user);
 	fastrpc_channel_ctx_put(cctx);
 	kfree(ctx->maps);
 	kfree(ctx->olaps);
@@ -826,7 +875,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].addr = ctx->maps[i]->phys;
 
 			mmap_read_lock(current->mm);
-			vma = find_vma(current->mm, ctx->args[i].ptr);
+			vma = vma_lookup(current->mm, ctx->args[i].ptr);
 			if (vma)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;
@@ -1181,9 +1230,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	struct fastrpc_invoke_ctx *ctx, *n;
-	struct fastrpc_map *map, *m;
-	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
 
 	fastrpc_release_current_dsp_process(fl);
@@ -1192,28 +1238,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
-
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
-
-	list_for_each_entry_safe(map, m, &fl->maps, node)
-		fastrpc_map_put(map);
-
-	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-		list_del(&buf->node);
-		fastrpc_buf_free(buf);
-	}
-
 	fastrpc_session_free(cctx, fl->sctx);
-	fastrpc_channel_ctx_put(cctx);
-
-	mutex_destroy(&fl->mutex);
-	kfree(fl);
 	file->private_data = NULL;
+	/* Release the reference taken in fastrpc_device_open */
+	fastrpc_user_put(fl);
 
 	return 0;
 }
@@ -1253,6 +1281,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
+	kref_init(&fl->refcount);
 
 	return 0;
 }
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index fe67e39d6854..b1383f20ba21 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -3032,7 +3032,7 @@ ssize_t vmci_qpair_enqueue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&from, WRITE, &v, 1, buf_size);
+	iov_iter_kvec(&from, ITER_SOURCE, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3076,7 +3076,7 @@ ssize_t vmci_qpair_dequeue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3121,7 +3121,7 @@ ssize_t vmci_qpair_peek(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 958bd901a136..b88c40223cd2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1339,7 +1339,9 @@ static void mmc_select_driver_type(struct mmc_card *card)
 
 	card->drive_strength = drive_strength;
 
-	if (drv_type)
+	if (fixed_drv_type >= 0 && drive_strength)
+		mmc_set_driver_type(card->host, drive_strength);
+	else if (drv_type)
 		mmc_set_driver_type(card->host, drv_type);
 }
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 7660f7ea74dd..6bd8478f412e 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -231,6 +231,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eb7213a8b5ea..088c6ffa6fb2 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -213,10 +213,13 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	extra &= ~BIT(0);
 	sdhci_writel(host, extra, reg);
 
+	/* Disable clock while config DLL */
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
 	if (clock <= 400000) {
 		/* Disable DLL to reset sample clock */
 		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
-		return;
+		goto enable_clk;
 	}
 
 	/* Reset DLL */
@@ -234,7 +237,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 				 500 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
-		return;
+		goto enable_clk;
 	}
 
 	extra = 0x1 << 16 | /* tune clock stop en */
@@ -255,6 +258,16 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 		DLL_STRBIN_TAPNUM_DEFAULT |
 		DLL_STRBIN_TAPNUM_FROM_SW;
 	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
+
+enable_clk:
+	/*
+	 * The sdclk frequency select bits in SDHCI_CLOCK_CONTROL are not functional
+	 * on Rockchip's SDHCI implementation. Instead, the clock frequency is fully
+	 * controlled via external clk provider by calling clk_set_rate(). Consequently,
+	 * passing 0 to sdhci_enable_clk() only re-enables the already-configured clock,
+	 * which matches the hardware's actual behavior.
+	 */
+	sdhci_enable_clk(host, 0);
 }
 
 static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 285c73e6b196..86367723d155 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3760,6 +3760,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 		host->pwr = 0;
 		host->clock = 0;
 		host->reinit_uhs = true;
+		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 980f4c09c91d..4c970c33957a 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -112,6 +112,8 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
+		bool needs_write_enable = (len > 1);
+
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
@@ -125,6 +127,17 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/*
+		 * Byte program clears the write enable latch. If more
+		 * data needs to be written using the AAI sequence,
+		 * re-enable writes.
+		 */
+		if (needs_write_enable) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5321d9dca698..f4322b4d8f6b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1776,6 +1776,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	int link_reporting;
 	int res = 0, i;
 
+	if (slave_dev->type == ARPHRD_CAN) {
+		BOND_NL_ERR(bond_dev, extack,
+			    "CAN devices cannot be enslaved");
+		return -EPERM;
+	}
+
 	if (slave_dev->flags & IFF_MASTER &&
 	    !netif_is_bond_master(slave_dev)) {
 		BOND_NL_ERR(bond_dev, extack,
@@ -4244,11 +4250,11 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 
 	slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
 
-	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
-
 	if (!slave_dev)
 		return -ENODEV;
 
+	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
+
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
 		res = bond_enslave(bond_dev, slave_dev, NULL);
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 77d06b682ce6..beb7221b75f0 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1395,8 +1395,8 @@ static int ucan_probe(struct usb_interface *intf,
 	 * Stage 3 for the final driver initialisation.
 	 */
 
-	/* Prepare Memory for control transferes */
-	ctl_msg_buffer = devm_kzalloc(&udev->dev,
+	/* Prepare Memory for control transfers */
+	ctl_msg_buffer = devm_kzalloc(&intf->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
 	if (!ctl_msg_buffer) {
@@ -1529,7 +1529,7 @@ static int ucan_probe(struct usb_interface *intf,
 	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
 				     sizeof(union ucan_ctl_payload));
 	if (ret > 0) {
-		/* copy string while ensuring zero terminiation */
+		/* copy string while ensuring zero termination */
 		strncpy(firmware_str, up->ctl_msg_buffer->raw,
 			sizeof(union ucan_ctl_payload));
 		firmware_str[sizeof(union ucan_ctl_payload)] = '\0';
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 70d76fdb9f56..58a59b2d70cf 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1399,8 +1399,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 		pcnet32_restart(dev, CSR0_START);
 		netif_wake_queue(dev);
 	}
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&lp->lock, flags);
 		/* clear interrupt masks */
 		val = lp->a->read_csr(ioaddr, CSR3);
 		val &= 0x00ff;
@@ -1408,9 +1410,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 
 		/* Set interrupt enable. */
 		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
+		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&lp->lock, flags);
 	return work_done;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 74344722d63d..79aa239fa7cc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4552,7 +4552,7 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
-	if (!bp->irq_tbl)
+	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
 	atomic_inc(&bp->intr_sem);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e4e25f3ba849..f93551ee3cb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3585,7 +3585,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024)) {
+			     qpi->rxq.databuffer_size < 128)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 6174b4bd44d3..f9c76d0b0874 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2777,7 +2777,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = pnp;
+	ppdev->dev.of_node = of_node_get(pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index fdfdd55fdb1d..c4951eb88241 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3912,14 +3912,14 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 
 	while (rx_done < rx_todo) {
 		struct mvpp2_rx_desc *rx_desc = mvpp2_rxq_next_desc_get(rxq);
+		u32 rx_status, timestamp, metasize = 0;
 		struct mvpp2_bm_pool *bm_pool;
 		struct page_pool *pp = NULL;
 		struct sk_buff *skb;
-		unsigned int frag_size;
+		unsigned int frag_size, rx_sync_size;
 		dma_addr_t dma_addr;
 		phys_addr_t phys_addr;
-		u32 rx_status, timestamp;
-		int pool, rx_bytes, err, ret;
+		int pool, rx_bytes, rx_offset, err, ret;
 		struct page *page;
 		void *data;
 
@@ -3932,6 +3932,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		rx_status = mvpp2_rxdesc_status_get(port, rx_desc);
 		rx_bytes = mvpp2_rxdesc_size_get(port, rx_desc);
 		rx_bytes -= MVPP2_MH_SIZE;
+		rx_sync_size = rx_bytes + MVPP2_MH_SIZE;
+		rx_offset = MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 		dma_addr = mvpp2_rxdesc_dma_addr_get(port, rx_desc);
 
 		pool = (rx_status & MVPP2_RXD_BM_POOL_ID_MASK) >>
@@ -3945,9 +3947,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			dma_dir = DMA_FROM_DEVICE;
 		}
 
-		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
-					rx_bytes + MVPP2_MH_SIZE,
-					dma_dir);
+		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
+					      MVPP2_SKB_HEADROOM,
+					      rx_sync_size,
+					      dma_dir);
 
 		/* Buffer header not supported */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
@@ -3969,6 +3972,12 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		else
 			frag_size = bm_pool->frag_size;
 
+		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
+		if (err) {
+			netdev_err(port->dev, "failed to refill BM pools\n");
+			goto err_drop_frame;
+		}
+
 		if (xdp_prog) {
 			struct xdp_rxq_info *xdp_rxq;
 
@@ -3977,32 +3986,48 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			else
 				xdp_rxq = &rxq->xdp_rxq_long;
 
-			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
+			xdp_init_buff(&xdp, bm_pool->frag_size, xdp_rxq);
 			xdp_prepare_buff(&xdp, data,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
-					 rx_bytes, false);
+					 rx_bytes, true);
 
 			ret = mvpp2_run_xdp(port, xdp_prog, &xdp, pp, &ps);
 
 			if (ret) {
 				xdp_ret |= ret;
-				err = mvpp2_rx_refill(port, bm_pool, pp, pool);
-				if (err) {
-					netdev_err(port->dev, "failed to refill BM pools\n");
-					goto err_drop_frame;
-				}
-
 				ps.rx_packets++;
 				ps.rx_bytes += rx_bytes;
 				continue;
 			}
+
+			rx_sync_size = max_t(unsigned int, rx_sync_size,
+					     xdp.data_end - xdp.data_hard_start -
+					     MVPP2_SKB_HEADROOM);
+
+			/* Update offset and length to reflect any XDP adjustments. */
+			rx_offset = xdp.data     - data;
+			rx_bytes  = xdp.data_end - xdp.data;
+
+			metasize = xdp.data - xdp.data_meta;
 		}
 
 		skb = build_skb(data, frag_size);
 		if (!skb) {
 			netdev_warn(port->dev, "skb build failed\n");
-			goto err_drop_frame;
+			if (pp) {
+				page_pool_put_page(pp, virt_to_head_page(data),
+						   rx_sync_size, true);
+			} else {
+				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
+						       bm_pool->buf_size,
+						       DMA_FROM_DEVICE,
+						       DMA_ATTR_SKIP_CPU_SYNC);
+				mvpp2_frag_free(bm_pool, pp, data);
+			}
+			goto err_drop_frame_retired;
 		}
+		if (pp)
+			skb_mark_for_recycle(skb);
 
 		/* If we have RX hardware timestamping enabled, grab the
 		 * timestamp from the queue and convert.
@@ -4013,16 +4038,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 					 skb_hwtstamps(skb));
 		}
 
-		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
-		if (err) {
-			netdev_err(port->dev, "failed to refill BM pools\n");
-			dev_kfree_skb_any(skb);
-			goto err_drop_frame;
-		}
-
-		if (pp)
-			skb_mark_for_recycle(skb);
-		else
+		if (!pp)
 			dma_unmap_single_attrs(dev->dev.parent, dma_addr,
 					       bm_pool->buf_size, DMA_FROM_DEVICE,
 					       DMA_ATTR_SKIP_CPU_SYNC);
@@ -4030,8 +4046,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		ps.rx_packets++;
 		ps.rx_bytes += rx_bytes;
 
-		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
+		skb_reserve(skb, rx_offset);
 		skb_put(skb, rx_bytes);
+		if (metasize)
+			skb_metadata_set(skb, metasize);
 		skb->ip_summed = mvpp2_rx_csum(port, rx_status);
 		skb->protocol = eth_type_trans(skb, dev);
 
@@ -4039,13 +4057,14 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		continue;
 
 err_drop_frame:
-		dev->stats.rx_errors++;
-		mvpp2_rx_error(port, rx_desc);
 		/* Return the buffer to the pool */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
 			mvpp2_buff_hdr_pool_put(port, rx_desc, pool, rx_status);
 		else
 			mvpp2_bm_pool_put(port, pool, dma_addr, phys_addr);
+err_drop_frame_retired:
+		dev->stats.rx_errors++;
+		mvpp2_rx_error(port, rx_desc);
 	}
 
 	if (xdp_ret & MVPP2_XDP_REDIR)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index d97a4123438f..d92657761586 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1096,10 +1096,13 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx *cgx, u8 lmac_id)
 {
 	const char *lmac_string;
+	unsigned int speed;
 
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
-	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
+	speed = FIELD_GET(RESP_LINKSTAT_SPEED, lstat);
+	linfo->speed = speed < ARRAY_SIZE(cgx_speed_mbps) ?
+		       cgx_speed_mbps[speed] : 0;
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8333340b1ea9..502c0b87770f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1258,11 +1258,13 @@ static int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		err = otx2_sync_mbox_msg(&pfvf->mbox);
 		if (err) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return err;
 		}
 		aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
 		if (!aq) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return -ENOMEM;
 		}
 	}
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 49d40685136d..8db83741aaa5 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -792,6 +792,36 @@ static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 		   "MAC address set to %pM\n", addr);
 }
 
+static void lan743x_mac_rx_enable_fse(struct lan743x_adapter *adapter)
+{
+	u32 mac_rx;
+	bool rxen;
+
+	mac_rx = lan743x_csr_read(adapter, MAC_RX);
+	if (mac_rx & MAC_RX_FSE_)
+		return;
+
+	rxen = mac_rx & MAC_RX_RXEN_;
+	if (rxen) {
+		mac_rx &= ~MAC_RX_RXEN_;
+		lan743x_csr_write(adapter, MAC_RX, mac_rx);
+		lan743x_csr_wait_for_bit(adapter, MAC_RX, MAC_RX_RXD_,
+					 1, 1000, 20000, 100);
+	}
+
+	/* Per AN2948, hardware prevents modification of the FSE bit while the
+	 * MAC receiver is enabled (RXEN bit set). Use separate register write
+	 * to assert the FSE bit before enabling the RXEN bit in MAC_RX
+	 */
+	mac_rx |= MAC_RX_FSE_;
+	lan743x_csr_write(adapter, MAC_RX, mac_rx);
+
+	if (rxen) {
+		mac_rx |= MAC_RX_RXEN_;
+		lan743x_csr_write(adapter, MAC_RX, mac_rx);
+	}
+}
+
 static int lan743x_mac_init(struct lan743x_adapter *adapter)
 {
 	bool mac_address_valid = true;
@@ -831,6 +861,8 @@ static int lan743x_mac_init(struct lan743x_adapter *adapter)
 	lan743x_mac_set_address(adapter, adapter->mac_address);
 	eth_hw_addr_set(netdev, adapter->mac_address);
 
+	lan743x_mac_rx_enable_fse(adapter);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index a1226ab0fb42..40351d38299a 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -118,6 +118,7 @@
 #define MAC_RX				(0x104)
 #define MAC_RX_MAX_SIZE_SHIFT_		(16)
 #define MAC_RX_MAX_SIZE_MASK_		(0x3FFF0000)
+#define MAC_RX_FSE_			BIT(2)
 #define MAC_RX_RXD_			BIT(1)
 #define MAC_RX_RXEN_			BIT(0)
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 7d8401da6f22..ccf2e31a5f4b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1037,12 +1037,14 @@ static void qed_cid_map_free(struct qed_hwfn *p_hwfn)
 	u32 type, vf;
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
-		kfree(p_mngr->acquired[type].cid_map);
+		bitmap_free(p_mngr->acquired[type].cid_map);
+		p_mngr->acquired[type].cid_map = NULL;
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
-			kfree(p_mngr->acquired_vf[type][vf].cid_map);
+			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
+			p_mngr->acquired_vf[type][vf].cid_map = NULL;
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
@@ -1055,15 +1057,10 @@ qed_cid_map_alloc_single(struct qed_hwfn *p_hwfn,
 			 u32 cid_start,
 			 u32 cid_count, struct qed_cid_acquired_map *p_map)
 {
-	u32 size;
-
 	if (!cid_count)
 		return 0;
 
-	size = DIV_ROUND_UP(cid_count,
-			    sizeof(unsigned long) * BITS_PER_BYTE) *
-	       sizeof(unsigned long);
-	p_map->cid_map = kzalloc(size, GFP_KERNEL);
+	p_map->cid_map = bitmap_zalloc(cid_count, GFP_KERNEL);
 	if (!p_map->cid_map)
 		return -ENOMEM;
 
@@ -1217,7 +1214,6 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 	struct qed_cid_acquired_map *p_map;
 	struct qed_conn_type_cfg *p_cfg;
 	int type;
-	u32 len;
 
 	/* Reset acquired cids */
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
@@ -1226,11 +1222,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 		p_cfg = &p_mngr->conn_cfg[type];
 		if (p_cfg->cid_count) {
 			p_map = &p_mngr->acquired[type];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 
 		if (!p_cfg->cids_per_vf)
@@ -1238,11 +1230,7 @@ void qed_cxt_mngr_setup(struct qed_hwfn *p_hwfn)
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			p_map = &p_mngr->acquired_vf[type][vf];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   sizeof(unsigned long) *
-					   BITS_PER_BYTE) *
-			      sizeof(unsigned long);
-			memset(p_map->cid_map, 0, len);
+			bitmap_zero(p_map->cid_map, p_map->max_count);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 9d52b949ae3f..bef2c71b9059 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1447,7 +1447,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1467,7 +1468,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 058472f42938..1e374de5cf8e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -956,12 +957,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = pfn_to_page(PHYS_PFN(paddr));
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 79ce61a78644..011665c81f15 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -824,7 +824,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		if (pn + 1 > rx_sa->next_pn_halves.lower) {
 			rx_sa->next_pn_halves.lower = pn + 1;
 		} else if (secy->xpn &&
-			   !pn_same_half(pn, rx_sa->next_pn_halves.lower)) {
+			   (pn + 1 == 0 ||
+			    !pn_same_half(pn, rx_sa->next_pn_halves.lower))) {
 			rx_sa->next_pn_halves.upper++;
 			rx_sa->next_pn_halves.lower = pn + 1;
 		}
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index fcfbff691b3c..17273895bbb3 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -285,12 +285,13 @@ enum rgmii_clock_delay {
 #define PHY_ID_VSC8540			  0x00070760
 #define PHY_ID_VSC8541			  0x00070770
 #define PHY_ID_VSC8552			  0x000704e0
-#define PHY_ID_VSC856X			  0x000707e0
+#define PHY_ID_VSC856X			  0x000707e1
 #define PHY_ID_VSC8572			  0x000704d0
 #define PHY_ID_VSC8574			  0x000704a0
-#define PHY_ID_VSC8575			  0x000707d0
-#define PHY_ID_VSC8582			  0x000707b0
-#define PHY_ID_VSC8584			  0x000707c0
+#define PHY_ID_VSC8575			  0x000707d1
+#define PHY_ID_VSC8582			  0x000707b1
+#define PHY_ID_VSC8584			  0x000707c1
+#define PHY_VENDOR_MSCC			0x00070400
 
 #define MSCC_VDDMAC_1500		  1500
 #define MSCC_VDDMAC_1800		  1800
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index acc9e1a26631..53f37ca2e0ff 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1713,12 +1713,6 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	 * in this pre-init function.
 	 */
 	if (phy_package_init_once(phydev)) {
-		/* The following switch statement assumes that the lowest
-		 * nibble of the phy_id_mask is always 0. This works because
-		 * the lowest nibble of the PHY_ID's below are also 0.
-		 */
-		WARN_ON(phydev->drv->phy_id_mask & 0xf);
-
 		switch (phydev->phy_id & phydev->drv->phy_id_mask) {
 		case PHY_ID_VSC8504:
 		case PHY_ID_VSC8552:
@@ -2257,11 +2251,6 @@ static int vsc8584_probe(struct phy_device *phydev)
 	   VSC8531_DUPLEX_COLLISION};
 	int ret;
 
-	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
-		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
-		return -ENOTSUPP;
-	}
-
 	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
 	if (!vsc8531)
 		return -ENOMEM;
@@ -2524,9 +2513,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 },
 {
-	.phy_id		= PHY_ID_VSC856X,
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC856X),
 	.name		= "Microsemi GE VSC856X SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2598,9 +2586,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 },
 {
-	.phy_id		= PHY_ID_VSC8575,
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8575),
 	.name		= "Microsemi GE VSC8575 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2622,9 +2609,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 },
 {
-	.phy_id		= PHY_ID_VSC8582,
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8582),
 	.name		= "Microsemi GE VSC8582 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2646,9 +2632,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_stats      = &vsc85xx_get_stats,
 },
 {
-	.phy_id		= PHY_ID_VSC8584,
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8584),
 	.name		= "Microsemi GE VSC8584 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2676,20 +2661,7 @@ static struct phy_driver vsc85xx_driver[] = {
 module_phy_driver(vsc85xx_driver);
 
 static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
-	{ PHY_ID_VSC8502, 0xfffffff0, },
-	{ PHY_ID_VSC8504, 0xfffffff0, },
-	{ PHY_ID_VSC8514, 0xfffffff0, },
-	{ PHY_ID_VSC8530, 0xfffffff0, },
-	{ PHY_ID_VSC8531, 0xfffffff0, },
-	{ PHY_ID_VSC8540, 0xfffffff0, },
-	{ PHY_ID_VSC8541, 0xfffffff0, },
-	{ PHY_ID_VSC8552, 0xfffffff0, },
-	{ PHY_ID_VSC856X, 0xfffffff0, },
-	{ PHY_ID_VSC8572, 0xfffffff0, },
-	{ PHY_ID_VSC8574, 0xfffffff0, },
-	{ PHY_ID_VSC8575, 0xfffffff0, },
-	{ PHY_ID_VSC8582, 0xfffffff0, },
-	{ PHY_ID_VSC8584, 0xfffffff0, },
+	{ PHY_ID_MATCH_VENDOR(PHY_VENDOR_MSCC) },
 	{ }
 };
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 2b76a8695fdb..8c28292ed33c 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -492,7 +492,7 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	ret = -EFAULT;
 	iov.iov_base = buf;
 	iov.iov_len = count;
-	iov_iter_init(&to, READ, &iov, 1, count);
+	iov_iter_init(&to, ITER_DEST, &iov, 1, count);
 	if (skb_copy_datagram_iter(skb, 0, &to, skb->len))
 		goto outf;
 	ret = skb->len;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index a08adca412b4..3a91972485cc 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1143,6 +1143,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1152,6 +1153,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5c9e7d0beffa..aad0760c8d92 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2422,8 +2422,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
-	if (unlikely(datasize < ETH_HLEN))
+	if (unlikely(datasize < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		return -EINVAL;
+	}
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
@@ -2466,6 +2468,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index bd2b44071781..7967b429dfcf 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2753,7 +2753,7 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
@@ -2816,7 +2816,7 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 26e09c30d596..67d01478eb76 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -177,16 +177,6 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 	trailer_len = padding_len + noise_encrypted_len(0);
 	plaintext_len = skb->len + padding_len;
 
-	/* Expand data section to have room for padding and auth tag. */
-	num_frags = skb_cow_data(skb, trailer_len, &trailer);
-	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
-		return false;
-
-	/* Set the padding to zeros, and make sure it and the auth tag are part
-	 * of the skb.
-	 */
-	memset(skb_tail_pointer(trailer), 0, padding_len);
-
 	/* Expand head section to have room for our header and the network
 	 * stack's headers.
 	 */
@@ -198,6 +188,16 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 		     skb_checksum_help(skb)))
 		return false;
 
+	/* Expand data section to have room for padding and auth tag. */
+	num_frags = skb_cow_data(skb, trailer_len, &trailer);
+	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
+		return false;
+
+	/* Set the padding to zeros, and make sure it and the auth tag are part
+	 * of the skb.
+	 */
+	memset(skb_tail_pointer(trailer), 0, padding_len);
+
 	/* Only after checksumming can we safely add on the padding at the end
 	 * and the header.
 	 */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index f9f18ff451ea..f46e40900217 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -392,10 +392,8 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
 	if (!cfg->btcoex)
 		return;
 
-	if (cfg->btcoex->timer_on) {
-		cfg->btcoex->timer_on = false;
-		del_timer_sync(&cfg->btcoex->timer);
-	}
+	del_timer_sync(&cfg->btcoex->timer);
+	cfg->btcoex->timer_on = false;
 
 	cancel_work_sync(&cfg->btcoex->work);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 5006aa831751..76b2953725c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2474,8 +2474,10 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
 		kthread_stop(bus->watchdog_tsk);
+		put_task_struct(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4549,8 +4551,10 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
 			kthread_stop(bus->watchdog_tsk);
+			put_task_struct(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index f006a3d72b40..6ba7082d65b6 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -399,7 +399,7 @@ static void mwifiex_invalidate_lists(struct mwifiex_adapter *adapter)
 static void
 mwifiex_adapter_cleanup(struct mwifiex_adapter *adapter)
 {
-	del_timer(&adapter->wakeup_timer);
+	del_timer_sync(&adapter->wakeup_timer);
 	del_timer_sync(&adapter->devdump_timer);
 	mwifiex_cancel_all_pending_cmd(adapter);
 	wake_up_interruptible(&adapter->cmd_wait_q.wait);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 08cf66141889..fa302d5e7839 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1766,7 +1766,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (pdev->device == 0xc821 && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C &&
+	    bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 22c498860c03..a0e665f958c4 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <linux/gpio/consumer.h>
@@ -268,6 +269,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
+	unsigned long irqflags;
 	int r;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -304,9 +306,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 	if (r < 0)
 		return r;
 
+	/*
+	 * ACPI platforms may report incorrect IRQ trigger types
+	 * (e.g. level-high), which can lead to interrupt storms.
+	 *
+	 * Use the historically stable rising-edge trigger for ACPI devices.
+	 *
+	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
+	 * provided trigger type, falling back to rising-edge if not set.
+	 */
+	if (ACPI_COMPANION(dev)) {
+		irqflags = IRQF_TRIGGER_RISING;
+	} else {
+		irqflags = irq_get_trigger_type(client->irq);
+		if (!irqflags)
+			irqflags = IRQF_TRIGGER_RISING;
+	}
+
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_ONESHOT,
+				 irqflags | IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1be8f7867a06..249a92e4bfc0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -297,7 +297,7 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	if (!iov_iter_count(&req->iter) &&
 	    req->data_sent < req->data_len) {
 		req->curr_bio = req->curr_bio->bi_next;
-		nvme_tcp_init_iter(req, WRITE);
+		nvme_tcp_init_iter(req, ITER_SOURCE);
 	}
 }
 
@@ -775,7 +775,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 				nvme_tcp_init_recv_ctx(queue);
 				return -EIO;
 			}
-			nvme_tcp_init_iter(req, READ);
+			nvme_tcp_init_iter(req, ITER_DEST);
 		}
 
 		/* we can read only from what is left in this bio */
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 098b6bf12cd0..f576a959e36c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -92,10 +92,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
 		call_iter = req->ns->file->f_op->write_iter;
-		rw = WRITE;
+		rw = ITER_SOURCE;
 	} else {
 		call_iter = req->ns->file->f_op->read_iter;
-		rw = READ;
+		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index c6cc1dfef92c..29ed707e76e0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -351,7 +351,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_bvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
+	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
 		      nr_pages, cmd->pdu_len);
 }
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 62f8407923d4..3a4f525308bf 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -223,10 +223,14 @@ static void get_lowlevel_driver(void)
 static int port_check(struct device *dev, void *dev_drv)
 {
 	struct parport_driver *drv = dev_drv;
+	struct parport *port;
 
 	/* only send ports, do not send other devices connected to bus */
-	if (is_parport(dev))
-		drv->match_port(to_parport_dev(dev));
+	if (is_parport(dev)) {
+		port = to_parport_dev(dev);
+		if (test_bit(PARPORT_ANNOUNCED, &port->devflags))
+			drv->match_port(port);
+	}
 	return 0;
 }
 
@@ -553,6 +557,7 @@ void parport_announce_port(struct parport *port)
 		if (slave)
 			attach_driver_chain(slave);
 	}
+	set_bit(PARPORT_ANNOUNCED, &port->devflags);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_announce_port);
@@ -582,6 +587,8 @@ void parport_remove_port(struct parport *port)
 
 	mutex_lock(&registration_lock);
 
+	clear_bit(PARPORT_ANNOUNCED, &port->devflags);
+
 	/* Spread the word. */
 	detach_driver_chain(port);
 
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index e1c8ce06bf5a..2dd1668c659a 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -20,8 +20,8 @@
 /* FUSE USB_CALIB registers */
 #define HS_CURR_LEVEL_PADX_SHIFT(x)	((x) ? (11 + (x - 1) * 6) : 0)
 #define HS_CURR_LEVEL_PAD_MASK		0x3f
-#define HS_TERM_RANGE_ADJ_SHIFT		7
-#define HS_TERM_RANGE_ADJ_MASK		0xf
+#define HS_TERM_RANGE_ADJ_PADX_SHIFT(x)	((x) ? (5 + (x - 1) * 4) : 7)
+#define HS_TERM_RANGE_ADJ_PAD_MASK	0xf
 #define HS_SQUELCH_SHIFT		29
 #define HS_SQUELCH_MASK			0x7
 
@@ -238,7 +238,7 @@
 struct tegra_xusb_fuse_calibration {
 	u32 *hs_curr_level;
 	u32 hs_squelch;
-	u32 hs_term_range_adj;
+	u32 *hs_term_range_adj;
 	u32 rpd_ctrl;
 };
 
@@ -612,6 +612,10 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	value &= ~USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
+	udelay(100);
+
+	clk_disable_unprepare(priv->usb2_trk_clk);
+
 	mutex_unlock(&padctl->lock);
 }
 
@@ -636,8 +640,6 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	value |= USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
-	clk_disable_unprepare(priv->usb2_trk_clk);
-
 	mutex_unlock(&padctl->lock);
 }
 
@@ -862,7 +864,7 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~TERM_RANGE_ADJ(~0);
-	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj);
+	value |= TERM_RANGE_ADJ(priv->calib.hs_term_range_adj[index]);
 	value &= ~RPD_CTRL(~0);
 	value |= RPD_CTRL(priv->calib.rpd_ctrl);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
@@ -1398,17 +1400,23 @@ static const char * const tegra186_usb3_functions[] = {
 static int
 tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 {
+	const struct tegra_xusb_padctl_soc *soc = padctl->base.soc;
 	struct device *dev = padctl->base.dev;
 	unsigned int i, count;
 	u32 value, *level;
+	u32 *hs_term_range_adj;
 	int err;
 
-	count = padctl->base.soc->ports.usb2.count;
+	count = soc->ports.usb2.count;
 
 	level = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
 	if (!level)
 		return -ENOMEM;
 
+	hs_term_range_adj = devm_kcalloc(dev, count, sizeof(u32), GFP_KERNEL);
+	if (!hs_term_range_adj)
+		return -ENOMEM;
+
 	err = tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
 	if (err) {
 		if (err != -EPROBE_DEFER)
@@ -1427,8 +1435,8 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.hs_squelch = (value >> HS_SQUELCH_SHIFT) &
 					HS_SQUELCH_MASK;
-	padctl->calib.hs_term_range_adj = (value >> HS_TERM_RANGE_ADJ_SHIFT) &
-						HS_TERM_RANGE_ADJ_MASK;
+	hs_term_range_adj[0] = (value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(0)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
 
 	err = tegra_fuse_readl(TEGRA_FUSE_USB_CALIB_EXT_0, &value);
 	if (err) {
@@ -1440,6 +1448,17 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
 
 	padctl->calib.rpd_ctrl = (value >> RPD_CTRL_SHIFT) & RPD_CTRL_MASK;
 
+	for (i = 1; i < count; i++) {
+		if (soc->has_per_pad_term)
+			hs_term_range_adj[i] =
+				(value >> HS_TERM_RANGE_ADJ_PADX_SHIFT(i)) &
+				HS_TERM_RANGE_ADJ_PAD_MASK;
+		else
+			hs_term_range_adj[i] = hs_term_range_adj[0];
+	}
+
+	padctl->calib.hs_term_range_adj = hs_term_range_adj;
+
 	return 0;
 }
 
@@ -1641,6 +1660,7 @@ const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc = {
 	.supply_names = tegra194_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
+	.has_per_pad_term = true,
 };
 EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
 #endif
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 034f7a2c28d6..5fb58df54953 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -431,6 +431,7 @@ struct tegra_xusb_padctl_soc {
 	unsigned int num_supplies;
 	bool supports_gen2;
 	bool need_fake_usb3_port;
+	bool has_per_pad_term;
 };
 
 struct tegra_xusb_padctl {
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 558f3f4e1859..ba1c9bd2fb9d 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1391,7 +1391,7 @@ static void fcoe_ctlr_recv_clr_vlink(struct fcoe_ctlr *fip,
 
 	while (rlen >= sizeof(*desc)) {
 		dlen = desc->fip_dlen * FIP_BPW;
-		if (dlen > rlen)
+		if (dlen < sizeof(*desc) || dlen > rlen)
 			goto err;
 		/* Drop CVL if there are duplicate critical descriptors */
 		if ((desc->fip_dtype < 32) &&
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index fbe2036ca619..45fa6488aded 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -744,6 +744,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 	}
 }
 
+static void
+fc_fpin_pname_stats_update(struct Scsi_Host *shost,
+			   struct fc_rport *attach_rport, u16 event_type,
+			   u32 desc_len, u32 fixed_len, u32 pname_count,
+			   __be64 *pname_list,
+			   void (*stats_update)(u16 event_type,
+						struct fc_fpin_stats *stats))
+{
+	u32 i;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		pname_count = 0;
+	else
+		pname_count = min(pname_count, (desc_len - fixed_len) /
+				   sizeof(pname_list[0]));
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			stats_update(event_type, &rport->fpin_stats);
+		}
+	}
+}
+
 /*
  * fc_fpin_li_stats_update - routine to update Link Integrity
  * event statistics.
@@ -754,13 +785,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
 	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(li_desc->attached_wwpn));
@@ -771,22 +800,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(li_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(li_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(li_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_li_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(li_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
+				   be32_to_cpu(li_desc->pname_count),
+				   li_desc->pname_list, fc_li_stats_update);
 
 	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
 		fc_li_stats_update(event_type, &fc_host->fpin_stats);
@@ -834,13 +852,11 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
 	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(pc_desc->attached_wwpn));
@@ -851,22 +867,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(pc_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(pc_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_cn_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(pc_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
+				   be32_to_cpu(pc_desc->pname_count),
+				   pc_desc->pname_list, fc_cn_stats_update);
 }
 
 /*
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 18c9c1d7107f..96ff232bef7a 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1721,7 +1721,7 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	Sg_scatter_hold *rsv_schp = &sfp->reserve;
 	struct request_queue *q = sfp->parentdp->device->request_queue;
 	struct rq_map_data *md, map_data;
-	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? ITER_SOURCE : ITER_DEST;
 	unsigned char *long_cmdp = NULL;
 
 	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430b..defd22edcb41 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1394,15 +1394,12 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 	switch (action) {
 	case QCOM_SSR_BEFORE_SHUTDOWN:
 	case SERVREG_SERVICE_STATE_DOWN:
-		/* Make sure the last dma xfer is finished */
-		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
 			pm_runtime_get_noresume(ctrl->ctrl.dev);
 			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 			qcom_slim_ngd_down(ctrl);
 			qcom_slim_ngd_exit_dma(ctrl);
 		}
-		mutex_unlock(&ctrl->tx_lock);
 		break;
 	case QCOM_SSR_AFTER_POWERUP:
 	case SERVREG_SERVICE_STATE_UP:
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index bcb52601804a..e09e54b02dc0 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -1003,7 +1003,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_master(dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(dev, "failed to register spi_master\n");
 		goto err_wq_destroy;
@@ -1027,6 +1027,10 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
+	spi_master_get(spi->master);
+
+	spi_unregister_master(spi->master);
+
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_CLC);
 	rx_fifo_flush(spi);
@@ -1037,6 +1041,8 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
 
+	spi_master_put(spi->master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2cc9bb413c10..e57c4f29f4e5 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -386,20 +386,20 @@ static void spi_qup_write(struct spi_qup *controller)
 	} while (remainder);
 }
 
-static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
+static int spi_qup_prep_sg(struct spi_controller *host, struct scatterlist *sgl,
 			   unsigned int nents, enum dma_transfer_direction dir,
 			   dma_async_tx_callback callback)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan *chan;
 	dma_cookie_t cookie;
 
 	if (dir == DMA_MEM_TO_DEV)
-		chan = master->dma_tx;
+		chan = host->dma_tx;
 	else
-		chan = master->dma_rx;
+		chan = host->dma_rx;
 
 	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
 	if (IS_ERR_OR_NULL(desc))
@@ -413,13 +413,13 @@ static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
 	return dma_submit_error(cookie);
 }
 
-static void spi_qup_dma_terminate(struct spi_master *master,
+static void spi_qup_dma_terminate(struct spi_controller *host,
 				  struct spi_transfer *xfer)
 {
 	if (xfer->tx_buf)
-		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(host->dma_tx);
 	if (xfer->rx_buf)
-		dmaengine_terminate_all(master->dma_rx);
+		dmaengine_terminate_all(host->dma_rx);
 }
 
 static u32 spi_qup_sgl_get_nents_len(struct scatterlist *sgl, u32 max,
@@ -446,8 +446,8 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
-	struct spi_master *master = spi->master;
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_controller *host = spi->controller;
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	struct scatterlist *tx_sgl, *rx_sgl;
 	int ret;
 
@@ -482,20 +482,20 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			return ret;
 		}
 		if (rx_sgl) {
-			ret = spi_qup_prep_sg(master, rx_sgl, rx_nents,
+			ret = spi_qup_prep_sg(host, rx_sgl, rx_nents,
 					      DMA_DEV_TO_MEM, rx_done);
 			if (ret)
 				return ret;
-			dma_async_issue_pending(master->dma_rx);
+			dma_async_issue_pending(host->dma_rx);
 		}
 
 		if (tx_sgl) {
-			ret = spi_qup_prep_sg(master, tx_sgl, tx_nents,
+			ret = spi_qup_prep_sg(host, tx_sgl, tx_nents,
 					      DMA_MEM_TO_DEV, tx_done);
 			if (ret)
 				return ret;
 
-			dma_async_issue_pending(master->dma_tx);
+			dma_async_issue_pending(host->dma_tx);
 		}
 
 		if (!wait_for_completion_timeout(&qup->done, timeout))
@@ -514,8 +514,8 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
-	struct spi_master *master = spi->master;
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_controller *host = spi->controller;
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	int ret, n_words, iterations, offset = 0;
 
 	n_words = qup->n_words;
@@ -660,7 +660,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 /* set clock freq ... bits per word, determine mode */
 static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(spi->master);
+	struct spi_qup *controller = spi_controller_get_devdata(spi->controller);
 	int ret;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
@@ -681,9 +681,9 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (controller->n_words <= (controller->in_fifo_sz / sizeof(u32)))
 		controller->mode = QUP_IO_M_MODE_FIFO;
-	else if (spi->master->can_dma &&
-		 spi->master->can_dma(spi->master, spi, xfer) &&
-		 spi->master->cur_msg_mapped)
+	else if (spi->controller->can_dma &&
+		 spi->controller->can_dma(spi->controller, spi, xfer) &&
+		 spi->controller->cur_msg_mapped)
 		controller->mode = QUP_IO_M_MODE_BAM;
 	else
 		controller->mode = QUP_IO_M_MODE_BLOCK;
@@ -694,7 +694,7 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 /* prep qup for another spi transaction of specific type */
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(spi->master);
+	struct spi_qup *controller = spi_controller_get_devdata(spi->controller);
 	u32 config, iomode, control;
 	unsigned long flags;
 
@@ -842,11 +842,11 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int spi_qup_transfer_one(struct spi_master *master,
+static int spi_qup_transfer_one(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	unsigned long timeout, flags;
 	int ret;
 
@@ -880,21 +880,21 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
 	if (ret && spi_qup_is_dma_xfer(controller->mode))
-		spi_qup_dma_terminate(master, xfer);
+		spi_qup_dma_terminate(host, xfer);
 
 	return ret;
 }
 
-static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
+static bool spi_qup_can_dma(struct spi_controller *host, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	size_t dma_align = dma_get_cache_alignment();
 	int n_words;
 
 	if (xfer->rx_buf) {
 		if (!IS_ALIGNED((size_t)xfer->rx_buf, dma_align) ||
-		    IS_ERR_OR_NULL(master->dma_rx))
+		    IS_ERR_OR_NULL(host->dma_rx))
 			return false;
 		if (qup->qup_v1 && (xfer->len % qup->in_blk_sz))
 			return false;
@@ -902,7 +902,7 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
 
 	if (xfer->tx_buf) {
 		if (!IS_ALIGNED((size_t)xfer->tx_buf, dma_align) ||
-		    IS_ERR_OR_NULL(master->dma_tx))
+		    IS_ERR_OR_NULL(host->dma_tx))
 			return false;
 		if (qup->qup_v1 && (xfer->len % qup->out_blk_sz))
 			return false;
@@ -915,30 +915,30 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
 	return true;
 }
 
-static void spi_qup_release_dma(struct spi_master *master)
+static void spi_qup_release_dma(struct spi_controller *host)
 {
-	if (!IS_ERR_OR_NULL(master->dma_rx))
-		dma_release_channel(master->dma_rx);
-	if (!IS_ERR_OR_NULL(master->dma_tx))
-		dma_release_channel(master->dma_tx);
+	if (!IS_ERR_OR_NULL(host->dma_rx))
+		dma_release_channel(host->dma_rx);
+	if (!IS_ERR_OR_NULL(host->dma_tx))
+		dma_release_channel(host->dma_tx);
 }
 
-static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
+static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 {
-	struct spi_qup *spi = spi_master_get_devdata(master);
+	struct spi_qup *spi = spi_controller_get_devdata(host);
 	struct dma_slave_config *rx_conf = &spi->rx_conf,
 				*tx_conf = &spi->tx_conf;
 	struct device *dev = spi->dev;
 	int ret;
 
 	/* allocate dma resources, if available */
-	master->dma_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(master->dma_rx))
-		return PTR_ERR(master->dma_rx);
+	host->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_rx))
+		return PTR_ERR(host->dma_rx);
 
-	master->dma_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
-		ret = PTR_ERR(master->dma_tx);
+	host->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
+		ret = PTR_ERR(host->dma_tx);
 		goto err_tx;
 	}
 
@@ -953,13 +953,13 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	tx_conf->dst_addr = base + QUP_OUTPUT_FIFO;
 	tx_conf->dst_maxburst = spi->out_blk_sz;
 
-	ret = dmaengine_slave_config(master->dma_rx, rx_conf);
+	ret = dmaengine_slave_config(host->dma_rx, rx_conf);
 	if (ret) {
 		dev_err(dev, "failed to configure RX channel\n");
 		goto err;
 	}
 
-	ret = dmaengine_slave_config(master->dma_tx, tx_conf);
+	ret = dmaengine_slave_config(host->dma_tx, tx_conf);
 	if (ret) {
 		dev_err(dev, "failed to configure TX channel\n");
 		goto err;
@@ -968,9 +968,12 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	return 0;
 
 err:
-	dma_release_channel(master->dma_tx);
+	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
-	dma_release_channel(master->dma_rx);
+	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 
@@ -980,7 +983,7 @@ static void spi_qup_set_cs(struct spi_device *spi, bool val)
 	u32 spi_ioc;
 	u32 spi_ioc_orig;
 
-	controller = spi_master_get_devdata(spi->master);
+	controller = spi_controller_get_devdata(spi->controller);
 	spi_ioc = readl_relaxed(controller->base + SPI_IO_CONTROL);
 	spi_ioc_orig = spi_ioc;
 	if (!val)
@@ -994,7 +997,7 @@ static void spi_qup_set_cs(struct spi_device *spi, bool val)
 
 static int spi_qup_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *iclk, *cclk;
 	struct spi_qup *controller;
 	struct resource *res;
@@ -1030,32 +1033,32 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	master = spi_alloc_master(dev, sizeof(struct spi_qup));
-	if (!master) {
-		dev_err(dev, "cannot allocate master\n");
+	host = spi_alloc_master(dev, sizeof(struct spi_qup));
+	if (!host) {
+		dev_err(dev, "cannot allocate host\n");
 		return -ENOMEM;
 	}
 
 	/* use num-cs unless not present or out of range */
 	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs) ||
 	    num_cs > SPI_NUM_CHIPSELECTS)
-		master->num_chipselect = SPI_NUM_CHIPSELECTS;
+		host->num_chipselect = SPI_NUM_CHIPSELECTS;
 	else
-		master->num_chipselect = num_cs;
+		host->num_chipselect = num_cs;
 
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->max_speed_hz = max_freq;
-	master->transfer_one = spi_qup_transfer_one;
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->dma_alignment = dma_get_cache_alignment();
-	master->max_dma_len = SPI_MAX_XFER;
+	host->bus_num = pdev->id;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->max_speed_hz = max_freq;
+	host->transfer_one = spi_qup_transfer_one;
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->dma_alignment = dma_get_cache_alignment();
+	host->max_dma_len = SPI_MAX_XFER;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	controller = spi_master_get_devdata(master);
+	controller = spi_controller_get_devdata(host);
 
 	controller->dev = dev;
 	controller->base = base;
@@ -1063,16 +1066,16 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->cclk = cclk;
 	controller->irq = irq;
 
-	ret = spi_qup_init_dma(master, res->start);
+	ret = spi_qup_init_dma(host, res->start);
 	if (ret == -EPROBE_DEFER)
 		goto error;
 	else if (!ret)
-		master->can_dma = spi_qup_can_dma;
+		host->can_dma = spi_qup_can_dma;
 
 	controller->qup_v1 = (uintptr_t)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
-		master->set_cs = spi_qup_set_cs;
+		host->set_cs = spi_qup_set_cs;
 
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
@@ -1150,7 +1153,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto disable_pm;
 
@@ -1162,17 +1165,17 @@ static int spi_qup_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
 error_dma:
-	spi_qup_release_dma(master);
+	spi_qup_release_dma(host);
 error:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 #ifdef CONFIG_PM
 static int spi_qup_pm_suspend_runtime(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	u32 config;
 
 	/* Enable clocks auto gaiting */
@@ -1188,8 +1191,8 @@ static int spi_qup_pm_suspend_runtime(struct device *device)
 
 static int spi_qup_pm_resume_runtime(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	u32 config;
 	int ret;
 
@@ -1214,8 +1217,8 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 #ifdef CONFIG_PM_SLEEP
 static int spi_qup_suspend(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	if (pm_runtime_suspended(device)) {
@@ -1223,7 +1226,7 @@ static int spi_qup_suspend(struct device *device)
 		if (ret)
 			return ret;
 	}
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -1238,8 +1241,8 @@ static int spi_qup_suspend(struct device *device)
 
 static int spi_qup_resume(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(controller->iclk);
@@ -1256,7 +1259,7 @@ static int spi_qup_resume(struct device *device)
 	if (ret)
 		goto disable_clk;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		goto disable_clk;
 
@@ -1271,8 +1274,8 @@ static int spi_qup_resume(struct device *device)
 
 static int spi_qup_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(&pdev->dev);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1290,7 +1293,7 @@ static int spi_qup_remove(struct platform_device *pdev)
 			 ERR_PTR(ret));
 	}
 
-	spi_qup_release_dma(master);
+	spi_qup_release_dma(host);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 6c44dda9ee8c..f453e3c1a26b 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -372,7 +372,7 @@ static int spi_st_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
 		goto rpm_disable;
@@ -394,10 +394,16 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
+	spi_master_put(master);
+
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	return 0;
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index a8fba310d700..ab99cc743865 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -503,7 +503,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		goto err_pm_disable;
@@ -521,8 +521,16 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index d79853ba7792..834957bb04ba 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -688,7 +688,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		goto err_pm_disable;
@@ -714,12 +714,19 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
 		dma_release_channel(master->dma_rx);
+
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index dc188f9202c9..4422fe9d92ff 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -719,7 +719,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_master(sspi->dev, master);
+	ret = spi_register_master(master);
 	if (ret)
 		goto disable_pm;
 
@@ -740,10 +740,16 @@ static int synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 30a699ba9b4c..39a34fbe6cea 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1417,7 +1417,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	}
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_free_irq;
@@ -1443,6 +1443,10 @@ static int tegra_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	free_irq(tspi->irq, tspi);
 
 	if (tspi->tx_dma_chan)
@@ -1455,6 +1459,8 @@ static int tegra_spi_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 6915451cc93e..8ac062d0460c 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -507,7 +507,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_pm_disable;
@@ -530,12 +530,18 @@ static int tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index cefe525d1fd0..f026ddaf8bcc 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -895,7 +895,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->mmap_enabled = false;
 	qspi->current_cs = -1;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (!ret)
 		return 0;
 
@@ -907,21 +907,20 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_qspi_remove(struct platform_device *pdev)
+static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
-	int rc;
 
-	rc = spi_master_suspend(qspi->master);
-	if (rc)
-		return rc;
+	spi_master_get(qspi->master);
+
+	spi_unregister_master(qspi->master);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
 
-	return 0;
+	spi_master_put(qspi->master);
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
@@ -930,7 +929,7 @@ static const struct dev_pm_ops ti_qspi_pm_ops = {
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove = ti_qspi_remove,
+	.remove_new = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cd2af4c0ba1d..4b8996393b5d 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1417,7 +1417,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	return ret;
 }
 
-static int pch_spi_pd_remove(struct platform_device *plat_dev)
+static void pch_spi_pd_remove(struct platform_device *plat_dev)
 {
 	struct pch_spi_board_data *board_dat = dev_get_platdata(&plat_dev->dev);
 	struct pch_spi_data *data = platform_get_drvdata(plat_dev);
@@ -1450,13 +1450,16 @@ static int pch_spi_pd_remove(struct platform_device *plat_dev)
 		free_irq(board_dat->pdev->irq, data);
 	}
 
+	spi_master_get(data->master);
+
+	spi_unregister_master(data->master);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_master(data->master);
 
-	return 0;
+	spi_master_put(data->master);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
@@ -1537,7 +1540,7 @@ static struct platform_driver pch_spi_pd_driver = {
 		.name = "pch-spi",
 	},
 	.probe = pch_spi_pd_probe,
-	.remove = pch_spi_pd_remove,
+	.remove_new = pch_spi_pd_remove,
 	.suspend = pch_spi_pd_suspend,
 	.resume = pch_spi_pd_resume
 };
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index cc0da4822231..05f43d67d624 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -751,7 +751,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	master->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret)
 		goto out_release_dma;
 
@@ -780,6 +780,10 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
 	if (master->dma_rx)
@@ -787,6 +791,8 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 77ea6b522348..f1c1047c949a 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -652,7 +652,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	xqspi = spi_controller_get_devdata(ctlr);
 	xqspi->dev = dev;
-	platform_set_drvdata(pdev, xqspi);
+	platform_set_drvdata(pdev, ctlr);
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -722,9 +722,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	/* QSPI controller initializations */
 	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto clk_dis_all;
 	}
 
@@ -752,13 +752,20 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  */
 static int zynq_qspi_remove(struct platform_device *pdev)
 {
-	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
 
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
 
+	spi_controller_put(ctlr);
+
 	return 0;
 }
 
diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index adb91286803a..49b42c0ab078 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -201,7 +201,7 @@ static void gb_hid_init_report(struct gb_hid *ghid, struct hid_report *report)
 	 * we just need to setup the input fields, so using
 	 * hid_report_raw_event is safe.
 	 */
-	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, size, 1);
+	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, ghid->bufsize, size, 1);
 }
 
 static void gb_hid_init_reports(struct gb_hid *ghid)
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b07271870132..c7bd7759a5ac 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2296,8 +2296,9 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 		if (conn->conn_ops->DataDigest) {
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
-						  text_in, rx_size, 0, NULL,
-						  &data_crc);
+						  text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL, &data_crc);
 
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
@@ -2317,6 +2318,7 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 32a2852352db..2ff2cbdd2598 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -870,10 +870,14 @@ static int iscsi_target_handle_csg_zero(
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
-	if (ret < 0)
+	if (ret < 0) {
+		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_INITIATOR_ERR,
+				ISCSI_LOGIN_STATUS_INIT_ERR);
 		return -1;
+	}
 
 	if (!iscsi_check_negotiated_keys(conn->param_list)) {
 		if (conn->tpg->tpg_attrib.authentication &&
@@ -941,6 +945,7 @@ static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_log
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 62004e3fe1cc..74624c67d189 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -1419,19 +1419,42 @@ int iscsi_decode_text_input(
 	return -1;
 }
 
+/*
+ * Append "key=value" plus a trailing NUL into @textbuf at *@length.
+ * Returns 0 on success and advances *@length, or -EMSGSIZE if the
+ * record (including the NUL) would not fit in the remaining buffer.
+ */
+static int iscsi_encode_text_record(char *textbuf, u32 *length,
+				    u32 textbuf_size,
+				    const char *key, const char *value)
+{
+	int n;
+	u32 avail;
+
+	if (*length >= textbuf_size)
+		return -EMSGSIZE;
+
+	avail = textbuf_size - *length;
+	n = snprintf(textbuf + *length, avail, "%s=%s", key, value);
+	if (n < 0 || (u32)n + 1 > avail)
+		return -EMSGSIZE;
+
+	*length += n + 1;
+	return 0;
+}
+
 int iscsi_encode_text_output(
 	u8 phase,
 	u8 sender,
 	char *textbuf,
 	u32 *length,
+	u32 textbuf_size,
 	struct iscsi_param_list *param_list,
 	bool keys_workaround)
 {
-	char *output_buf = NULL;
 	struct iscsi_extra_response *er;
 	struct iscsi_param *param;
-
-	output_buf = textbuf + *length;
+	int ret;
 
 	if (iscsi_enforce_integrity_rules(phase, param_list) < 0)
 		return -1;
@@ -1443,10 +1466,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_RESPONSE_SENT(param) &&
 		    !IS_PSTATE_REPLY_OPTIONAL(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_RESPONSE_SENT(param);
 			pr_debug("Sending key: %s=%s\n",
 				param->name, param->value);
@@ -1456,10 +1481,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_ACCEPTOR(param) &&
 		    !IS_PSTATE_PROPOSER(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_PROPOSER(param);
 			iscsi_check_proposer_for_optional_reply(param,
 							        keys_workaround);
@@ -1469,14 +1496,21 @@ int iscsi_encode_text_output(
 	}
 
 	list_for_each_entry(er, &param_list->extra_response_list, er_list) {
-		*length += sprintf(output_buf, "%s=%s", er->key, er->value);
-		*length += 1;
-		output_buf = textbuf + *length;
+		ret = iscsi_encode_text_record(textbuf, length, textbuf_size,
+					       er->key, er->value);
+		if (ret < 0)
+			goto err_overflow;
 		pr_debug("Sending key: %s=%s\n", er->key, er->value);
 	}
 	iscsi_release_extra_responses(param_list);
 
 	return 0;
+
+err_overflow:
+	pr_err("iSCSI login response buffer (%u bytes) exhausted, dropping login.\n",
+	       textbuf_size);
+	iscsi_release_extra_responses(param_list);
+	return -1;
 }
 
 int iscsi_check_negotiated_keys(struct iscsi_param_list *param_list)
diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index 240c4c4344f6..6d02d19eb8cf 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -46,7 +46,7 @@ extern struct iscsi_param *iscsi_find_param_from_key(char *, struct iscsi_param_
 extern int iscsi_extract_key_value(char *, char **, char **);
 extern int iscsi_update_param_value(struct iscsi_param *, char *);
 extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsi_conn *);
-extern int iscsi_encode_text_output(u8, u8, char *, u32 *,
+extern int iscsi_encode_text_output(u8, u8, char *, u32 *, u32,
 			struct iscsi_param_list *, bool);
 extern int iscsi_check_negotiated_keys(struct iscsi_param_list *);
 extern void iscsi_set_connection_parameters(struct iscsi_conn_ops *,
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 6998c0eec3d4..c533938484f3 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1231,7 +1231,7 @@ int rx_data(
 		return -1;
 
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1267,7 +1267,7 @@ int tx_data(
 
 	memset(&msg, 0, sizeof(struct msghdr));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		int tx_loop = sock_sendmsg(conn->sock, &msg);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 538009a83c97..e11d9897a5e4 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -472,7 +472,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 		len += se_dev->dev_attrib.block_size;
 	}
 
-	iov_iter_bvec(&iter, WRITE, bvec, nolb, len);
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nolb, len);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
 
 	kfree(bvec);
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index d0f397c90242..2386bbd38ce7 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -10,7 +10,11 @@
 struct optee_supp_req {
 	struct list_head link;
 
+	int id;
+
 	bool in_queue;
+	bool processed;
+
 	u32 func;
 	u32 ret;
 	size_t num_params;
@@ -19,6 +23,9 @@ struct optee_supp_req {
 	struct completion c;
 };
 
+/* It is temporary request used for revoked pending request in supp->idr. */
+#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-EBADF))
+
 void optee_supp_init(struct optee_supp *supp)
 {
 	memset(supp, 0, sizeof(*supp));
@@ -39,21 +46,23 @@ void optee_supp_release(struct optee_supp *supp)
 {
 	int id;
 	struct optee_supp_req *req;
-	struct optee_supp_req *req_tmp;
 
 	mutex_lock(&supp->mutex);
 
-	/* Abort all request retrieved by supplicant */
+	/* Abort all request */
 	idr_for_each_entry(&supp->idr, req, id) {
 		idr_remove(&supp->idr, id);
-		req->ret = TEEC_ERROR_COMMUNICATION;
-		complete(&req->c);
-	}
+		/* Skip if request was already marked invalid */
+		if (IS_ERR(req))
+			continue;
 
-	/* Abort all queued requests */
-	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
-		list_del(&req->link);
-		req->in_queue = false;
+		/* For queued requests where supplicant has not seen it */
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
+		}
+
+		req->processed = true;
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
 	}
@@ -100,8 +109,16 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 
 	/* Insert the request in the request list */
 	mutex_lock(&supp->mutex);
+	req->id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
+	if (req->id < 0) {
+		mutex_unlock(&supp->mutex);
+		kfree(req);
+		return TEEC_ERROR_OUT_OF_MEMORY;
+	}
+
 	list_add_tail(&req->link, &supp->reqs);
 	req->in_queue = true;
+	req->processed = false;
 	mutex_unlock(&supp->mutex);
 
 	/* Tell an eventual waiter there's a new request */
@@ -117,21 +134,43 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
 		if (req->in_queue) {
+			/* Supplicant has not seen this request yet. */
+			idr_remove(&supp->idr, req->id);
 			list_del(&req->link);
 			req->in_queue = false;
+
+			ret = TEEC_ERROR_COMMUNICATION;
+		} else if (req->processed) {
+			/*
+			 * Supplicant has processed this request. Ignore the
+			 * kill signal for now and submit the result. req is not
+			 * in supp->reqs (removed by supp_pop_entry()) nor in
+			 * supp->idr (removed by supp_pop_req()).
+			 */
+			ret = req->ret;
+		} else {
+			/*
+			 * Supplicant is in the middle of processing this
+			 * request. Replace req with INVALID_REQ_PTR so that
+			 * the ID remains busy, causing optee_supp_send() to
+			 * fail on the next call to supp_pop_req() with this ID.
+			 */
+			idr_replace(&supp->idr, INVALID_REQ_PTR, req->id);
+			ret = TEEC_ERROR_COMMUNICATION;
 		}
+
 		mutex_unlock(&supp->mutex);
-		req->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret = req->ret;
 	}
 
-	ret = req->ret;
 	kfree(req);
 
 	return ret;
 }
 
 static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
-					      int num_params, int *id)
+					      int num_params)
 {
 	struct optee_supp_req *req;
 
@@ -153,10 +192,6 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
-	if (*id < 0)
-		return ERR_PTR(-ENOMEM);
-
 	list_del(&req->link);
 	req->in_queue = false;
 
@@ -214,7 +249,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	struct optee *optee = tee_get_drvdata(teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req = NULL;
-	int id;
 	size_t num_meta;
 	int rc;
 
@@ -224,15 +258,11 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 
 	while (true) {
 		mutex_lock(&supp->mutex);
-		req = supp_pop_entry(supp, *num_params - num_meta, &id);
+		req = supp_pop_entry(supp, *num_params - num_meta);
+		if (req)
+			break; /* Keep mutex held. */
 		mutex_unlock(&supp->mutex);
 
-		if (req) {
-			if (IS_ERR(req))
-				return PTR_ERR(req);
-			break;
-		}
-
 		/*
 		 * If we didn't get a request we'll block in
 		 * wait_for_completion() to avoid needless spinning.
@@ -245,6 +275,13 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 			return -ERESTARTSYS;
 	}
 
+	/* supp->mutex held and req != NULL. */
+
+	if (IS_ERR(req)) {
+		mutex_unlock(&supp->mutex);
+		return PTR_ERR(req);
+	}
+
 	if (num_meta) {
 		/*
 		 * tee-supplicant support meta parameters -> requsts can be
@@ -252,13 +289,11 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		 */
 		param->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
 			      TEE_IOCTL_PARAM_ATTR_META;
-		param->u.value.a = id;
+		param->u.value.a = req->id;
 		param->u.value.b = 0;
 		param->u.value.c = 0;
 	} else {
-		mutex_lock(&supp->mutex);
-		supp->req_id = id;
-		mutex_unlock(&supp->mutex);
+		supp->req_id = req->id;
 	}
 
 	*func = req->func;
@@ -266,6 +301,7 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	memcpy(param + num_meta, req->param,
 	       sizeof(struct tee_param) * req->num_params);
 
+	mutex_unlock(&supp->mutex);
 	return 0;
 }
 
@@ -297,12 +333,17 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
+	/* optee_supp_thrd_req() already returned to optee. */
+	if (IS_ERR(req))
+		goto failed_req;
+
 	if ((num_params - nm) != req->num_params)
 		return ERR_PTR(-EINVAL);
 
+	*num_meta = nm;
+failed_req:
 	idr_remove(&supp->idr, id);
 	supp->req_id = -1;
-	*num_meta = nm;
 
 	return req;
 }
@@ -328,10 +369,9 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 
 	mutex_lock(&supp->mutex);
 	req = supp_pop_req(supp, num_params, param, &num_meta);
-	mutex_unlock(&supp->mutex);
-
 	if (IS_ERR(req)) {
-		/* Something is wrong, let supplicant restart. */
+		mutex_unlock(&supp->mutex);
+		/* Something is wrong, let supplicant handel it. */
 		return PTR_ERR(req);
 	}
 
@@ -355,9 +395,10 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 		}
 	}
 	req->ret = ret;
-
+	req->processed = true;
 	/* Let the requesting thread continue */
 	complete(&req->c);
+	mutex_unlock(&supp->mutex);
 
 	return 0;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bb3a4b672036..acea77b7c8d9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -778,6 +778,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1260,8 +1261,10 @@ thermal_zone_device_register(const char *type, int num_trips, int mask,
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
-	if (result)
+	if (result) {
+		thermal_set_governor(tz, NULL);
 		goto remove_id;
+	}
 
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
@@ -1385,8 +1388,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_remove_hwmon_sysfs(tz);
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index dc555cda98e6..d7598df98b7d 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uuid.h>
@@ -34,10 +35,11 @@ struct tb_property_dir_entry {
 };
 
 #define TB_PROPERTY_ROOTDIR_MAGIC	0x55584401
+#define TB_PROPERTY_MAX_DEPTH		8
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
-	bool is_root);
+	bool is_root, unsigned int depth);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -52,13 +54,18 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
 static bool tb_property_entry_valid(const struct tb_property_entry *entry,
 				  size_t block_len)
 {
+	u32 end;
+
 	switch (entry->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 	case TB_PROPERTY_TYPE_DATA:
 	case TB_PROPERTY_TYPE_TEXT:
+		if (!entry->length)
+			return false;
 		if (entry->length > block_len)
 			return false;
-		if (entry->value + entry->length > block_len)
+		if (check_add_overflow(entry->value, entry->length, &end) ||
+		    end > block_len)
 			return false;
 		break;
 
@@ -93,7 +100,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -114,7 +122,7 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false, depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -159,21 +167,35 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 }
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
-	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root)
+	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root,
+	unsigned int depth)
 {
 	const struct tb_property_entry *entries;
 	size_t i, content_len, nentries;
 	unsigned int content_offset;
 	struct tb_property_dir *dir;
 
+	if (depth > TB_PROPERTY_MAX_DEPTH)
+		return NULL;
+
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
 		return NULL;
 
+	INIT_LIST_HEAD(&dir->properties);
+
 	if (is_root) {
 		content_offset = dir_offset + 2;
 		content_len = dir_len;
+		if (content_offset + content_len > block_len) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 	} else {
+		if (dir_len < 4) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
 				    GFP_KERNEL);
 		if (!dir->uuid) {
@@ -187,12 +209,10 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	entries = (const struct tb_property_entry *)&block[content_offset];
 	nentries = content_len / (sizeof(*entries) / 4);
 
-	INIT_LIST_HEAD(&dir->properties);
-
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i], depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -229,7 +249,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index d66ea4d616fd..df5e40c6876c 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -96,7 +96,9 @@ static bool tb_xdomain_match(const struct tb_cfg_request *req,
 static bool tb_xdomain_copy(struct tb_cfg_request *req,
 			    const struct ctl_pkg *pkg)
 {
-	memcpy(req->response, pkg->buffer, req->response_size);
+	size_t len = min_t(size_t, pkg->frame.size, req->response_size);
+
+	memcpy(req->response, pkg->buffer, len);
 	req->result.err = 0;
 	return true;
 }
@@ -370,6 +372,8 @@ static int tb_xdp_properties_request(struct tb_ctl *ctl, u64 route,
 			}
 		}
 
+		if (req.offset + len > data_len)
+			len = data_len - req.offset;
 		memcpy(data + req.offset, res->data, len * 4);
 		req.offset += len;
 	} while (!data_len || req.offset < data_len);
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 23c4e0e79694..8d2364787a4f 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -418,8 +418,10 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct altera_jtaguart_platform_uart *platp =
 			dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
-	struct resource *res_irq, *res_mem;
+	struct resource *res_mem;
 	int i = pdev->id;
+	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -438,9 +440,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res_irq)
-		port->irq = res_irq->start;
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq > 0)
+		port->irq = irq;
 	else if (platp)
 		port->irq = platp->irq;
 	else
@@ -457,7 +461,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index e9edabc5a211..05f22e76a508 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -544,14 +544,48 @@ static int dz_encode_baud_rate(unsigned int baud)
 static void dz_reset(struct dz_port *dport)
 {
 	struct dz_mux *mux = dport->mux;
+	unsigned short tcr;
+	int loops = 10000;
+	int line;
 
 	if (mux->initialised)
 		return;
 
+	tcr = dz_in(dport, DZ_TCR);
+
+	/* Do not disturb any ongoing transmissions.  */
+	if (dz_in(dport, DZ_CSR) & DZ_MSE) {
+		unsigned short csr, mask;
+
+		mask = tcr;
+		while ((mask & DZ_LNENB) && loops--) {
+			csr = dz_in(dport, DZ_CSR);
+			if (!(csr & DZ_TRDY))
+				continue;
+			mask &= ~(1 << ((csr & DZ_TLINE) >> 8));
+			dz_out(dport, DZ_TCR, mask);
+			iob();
+			udelay(2);		/* 1.4us TRDY recovery.  */
+		}
+		udelay(1200);			/* Transmitter drain.  */
+	}
+
 	dz_out(dport, DZ_CSR, DZ_CLR);
 	while (dz_in(dport, DZ_CSR) & DZ_CLR);
 	iob();
 
+	/*
+	 * Set parameters across all lines such as not to interfere
+	 * with the initial PROM-based console.  Otherwise any output
+	 * produced before the console handover would cause the system
+	 * firmware to produce rubbish.
+	 */
+	for (line = 0; line < DZ_NB_PORT; line++)
+		dz_out(dport, DZ_LPR, DZ_B9600 | DZ_CS8 | line);
+
+	/* Re-enable transmission for the initial PROM-based console.  */
+	dz_out(dport, DZ_TCR, tcr);
+
 	/* Enable scanning.  */
 	dz_out(dport, DZ_CSR, DZ_MSE);
 
@@ -632,26 +666,6 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
-/*
- * Hack alert!
- * Required solely so that the initial PROM-based console
- * works undisturbed in parallel with this one.
- */
-static void dz_pm(struct uart_port *uport, unsigned int state,
-		  unsigned int oldstate)
-{
-	struct dz_port *dport = to_dport(uport);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dport->port.lock, flags);
-	if (state < 3)
-		dz_start_tx(&dport->port);
-	else
-		dz_stop_tx(&dport->port);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
-}
-
-
 static const char *dz_type(struct uart_port *uport)
 {
 	return "DZ";
@@ -747,7 +761,6 @@ static const struct uart_ops dz_ops = {
 	.startup	= dz_startup,
 	.shutdown	= dz_shutdown,
 	.set_termios	= dz_set_termios,
-	.pm		= dz_pm,
 	.type		= dz_type,
 	.release_port	= dz_release_port,
 	.request_port	= dz_request_port,
@@ -872,10 +885,7 @@ static int __init dz_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dport->port.lock);	/* For dz_pm().  */
-
 	dz_reset(dport);
-	dz_pm(uport, 0, -1);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6684f6512fb1..859dd75246f6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1279,7 +1279,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 
 	if (!nent) {
 		dev_err(sport->port.dev, "DMA Rx mapping error\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_buf;
 	}
 
 	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
@@ -1291,7 +1292,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	if (ret < 0) {
 		dev_err(sport->port.dev,
 				"DMA Rx slave config failed, err = %d\n", ret);
-		return ret;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
@@ -1302,7 +1303,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 				 DMA_PREP_INTERRUPT);
 	if (!sport->dma_rx_desc) {
 		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
-		return -EFAULT;
+		ret = -ENOMEM;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
@@ -1320,6 +1322,13 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	}
 
 	return 0;
+
+err_unmap_sg:
+	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+err_free_buf:
+	kfree(ring->buf);
+	ring->buf = NULL;
+	return ret;
 }
 
 static void lpuart_dma_rx_free(struct uart_port *port)
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index a741278e4bdb..69d516463a17 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -707,8 +707,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		pci_dev_put(dma_dev);
-		return;
+		goto err_pci_get;
 	}
 	priv->chan_tx = chan;
 
@@ -722,18 +721,26 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Rx)\n",
 			__func__);
-		dma_release_channel(priv->chan_tx);
-		priv->chan_tx = NULL;
-		pci_dev_put(dma_dev);
-		return;
+		goto err_req_tx;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
+	if (!priv->rx_buf_virt)
+		goto err_req_rx;
 	priv->chan_rx = chan;
 
 	pci_dev_put(dma_dev);
+	return;
+
+err_req_rx:
+	dma_release_channel(chan);
+err_req_tx:
+	dma_release_channel(priv->chan_tx);
+	priv->chan_tx = NULL;
+err_pci_get:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_dma_rx_complete(void *arg)
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 45010c77fe3a..85b245bafbad 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -35,72 +35,57 @@
 #define SE_UART_MANUAL_RFR		0x2ac
 
 /* SE_UART_TRANS_CFG */
-#define UART_TX_PAR_EN		BIT(0)
-#define UART_CTS_MASK		BIT(1)
-
-/* SE_UART_TX_WORD_LEN */
-#define TX_WORD_LEN_MSK		GENMASK(9, 0)
+#define UART_TX_PAR_EN			BIT(0)
+#define UART_CTS_MASK			BIT(1)
 
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_MSK	GENMASK(23, 0)
-#define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_1_5	1
-#define TX_STOP_BIT_LEN_2	2
-
-/* SE_UART_TX_TRANS_LEN */
-#define TX_TRANS_LEN_MSK	GENMASK(23, 0)
+#define TX_STOP_BIT_LEN_1		0
+#define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_INS_STATUS_BIT	BIT(2)
-#define UART_RX_PAR_EN		BIT(3)
+#define UART_RX_PAR_EN			BIT(4)
 
 /* SE_UART_RX_WORD_LEN */
-#define RX_WORD_LEN_MASK	GENMASK(9, 0)
+#define RX_WORD_LEN_MASK		GENMASK(9, 0)
 
 /* SE_UART_RX_STALE_CNT */
-#define RX_STALE_CNT		GENMASK(23, 0)
+#define RX_STALE_CNT			GENMASK(23, 0)
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
-#define PAR_CALC_EN		BIT(0)
-#define PAR_MODE_MSK		GENMASK(2, 1)
-#define PAR_MODE_SHFT		1
-#define PAR_EVEN		0x00
-#define PAR_ODD			0x01
-#define PAR_SPACE		0x10
-#define PAR_MARK		0x11
+#define PAR_CALC_EN			BIT(0)
+#define PAR_EVEN			0x00
+#define PAR_ODD				0x01
+#define PAR_SPACE			0x10
 
 /* SE_UART_MANUAL_RFR register fields */
-#define UART_MANUAL_RFR_EN	BIT(31)
-#define UART_RFR_NOT_READY	BIT(1)
-#define UART_RFR_READY		BIT(0)
+#define UART_MANUAL_RFR_EN		BIT(31)
+#define UART_RFR_NOT_READY		BIT(1)
+#define UART_RFR_READY			BIT(0)
 
 /* UART M_CMD OP codes */
-#define UART_START_TX		0x1
-#define UART_START_BREAK	0x4
-#define UART_STOP_BREAK		0x5
+#define UART_START_TX			0x1
 /* UART S_CMD OP codes */
-#define UART_START_READ		0x1
-#define UART_PARAM		0x1
-
-#define UART_OVERSAMPLING	32
-#define STALE_TIMEOUT		16
-#define DEFAULT_BITS_PER_CHAR	10
-#define GENI_UART_CONS_PORTS	1
-#define GENI_UART_PORTS		3
-#define DEF_FIFO_DEPTH_WORDS	16
-#define DEF_TX_WM		2
-#define DEF_FIFO_WIDTH_BITS	32
-#define UART_RX_WM		2
+#define UART_START_READ			0x1
+
+#define UART_OVERSAMPLING		32
+#define STALE_TIMEOUT			16
+#define DEFAULT_BITS_PER_CHAR		10
+#define GENI_UART_CONS_PORTS		1
+#define GENI_UART_PORTS			3
+#define DEF_FIFO_DEPTH_WORDS		16
+#define DEF_TX_WM			2
+#define DEF_FIFO_WIDTH_BITS		32
+#define UART_RX_WM			2
 
 /* SE_UART_LOOPBACK_CFG */
-#define RX_TX_SORTED	BIT(0)
-#define CTS_RTS_SORTED	BIT(1)
-#define RX_TX_CTS_RTS_SORTED	(RX_TX_SORTED | CTS_RTS_SORTED)
+#define RX_TX_SORTED			BIT(0)
+#define CTS_RTS_SORTED			BIT(1)
+#define RX_TX_CTS_RTS_SORTED		(RX_TX_SORTED | CTS_RTS_SORTED)
 
 /* UART pin swap value */
-#define DEFAULT_IO_MACRO_IO0_IO1_MASK		GENMASK(3, 0)
+#define DEFAULT_IO_MACRO_IO0_IO1_MASK	GENMASK(3, 0)
 #define IO_MACRO_IO0_SEL		0x3
-#define DEFAULT_IO_MACRO_IO2_IO3_MASK		GENMASK(15, 4)
+#define DEFAULT_IO_MACRO_IO2_IO3_MASK	GENMASK(15, 4)
 #define IO_MACRO_IO2_IO3_SWAP		0x4640
 
 /* We always configure 4 bytes per FIFO word */
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7d3630ddebb3..1d8f5d3f440b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -242,11 +242,8 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
-	unsigned int ucon, ufcon;
 	int count = 10000;
-
-	spin_lock_irqsave(&port->lock, flags);
+	u32 ucon, ufcon;
 
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
@@ -260,23 +257,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
-	unsigned int ucon;
-
-	spin_lock_irqsave(&port->lock, flags);
+	u32 ucon;
 
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)
@@ -344,7 +336,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 				dma->tx_transfer_addr, dma->tx_size,
 				DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
 	port->icount.tx += count;
@@ -354,7 +346,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 		uart_write_wakeup(port);
 
 	s3c24xx_serial_start_next_tx(ourport);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
@@ -620,7 +612,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 	received  = dma->rx_bytes_requested - state.residue;
 	async_tx_ack(dma->rx_desc);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (received)
 		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
@@ -632,7 +624,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 
 	s3c64xx_start_rx_dma(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
@@ -664,7 +656,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -687,7 +679,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -712,18 +704,19 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
 
 static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
-	unsigned int utrstat, received;
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
 	struct tty_port *t = &port->state->port;
 	struct dma_tx_state state;
+	unsigned int received;
+	u32 utrstat;
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
 		s3c64xx_start_rx_dma(ourport);
@@ -752,7 +745,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -849,9 +842,9 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	s3c24xx_serial_rx_drain_fifo(ourport);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -933,11 +926,11 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	s3c24xx_serial_tx_chars(ourport);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 	return IRQ_HANDLED;
 }
 
@@ -1000,7 +993,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
+	u32 umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -1023,9 +1016,9 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
-	unsigned int ucon;
+	u32 ucon;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ucon = rd_regl(port, S3C2410_UCON);
 
@@ -1036,7 +1029,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 
 	wr_regl(port, S3C2410_UCON, ucon);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
@@ -1204,7 +1197,7 @@ static void apple_s5l_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	unsigned int ucon;
+	u32 ucon;
 
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
@@ -1272,7 +1265,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ufcon;
+	u32 ufcon;
 	int ret;
 
 	wr_regl(port, S3C64XX_UINTM, 0xf);
@@ -1295,7 +1288,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1305,7 +1298,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_clear_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
@@ -1317,7 +1310,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ufcon;
+	u32 ufcon;
 	int ret;
 
 	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
@@ -1333,7 +1326,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1343,7 +1336,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
@@ -1559,9 +1552,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
 	unsigned int baud, quot, clk_sel = 0;
-	unsigned int ulcon;
-	unsigned int umcon;
 	unsigned int udivslot = 0;
+	u32 ulcon, umcon;
 
 	/*
 	 * We don't support modem control lines.
@@ -1644,7 +1636,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 		ulcon |= S3C2410_LCON_PNONE;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	dev_dbg(port->dev,
 		"setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
@@ -1702,7 +1694,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= RXSTAT_DUMMY_READ;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *s3c24xx_serial_type(struct uart_port *port)
@@ -2147,7 +2139,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 		break;
 	case TYPE_APPLE_S5L: {
-		unsigned int ucon;
+		u32 ucon;
 
 		ucon = rd_regl(port, S3C2410_UCON);
 		ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
@@ -2366,7 +2358,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 		/* restore IRQ mask */
 		switch (ourport->info->type) {
 		case TYPE_S3C6400: {
-			unsigned int uintm = 0xf;
+			u32 uintm = 0xf;
 
 			if (ourport->tx_enabled)
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
@@ -2382,7 +2374,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 			break;
 		}
 		case TYPE_APPLE_S5L: {
-			unsigned int ucon;
+			u32 ucon;
 			int ret;
 
 			ret = clk_prepare_enable(ourport->clk);
@@ -2445,7 +2437,7 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 static struct uart_port *cons_uart;
 
 static int
-s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
+s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	unsigned long ufstat, utrstat;
@@ -2464,7 +2456,7 @@ s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
 }
 
 static bool
-s3c24xx_port_configured(unsigned int ucon)
+s3c24xx_port_configured(u32 ucon)
 {
 	/* consider the serial port configured if the tx/rx mode set */
 	return (ucon & 0xf) != 0;
@@ -2491,8 +2483,8 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 		unsigned char c)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
-	unsigned int ucon = rd_regl(port, S3C2410_UCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
@@ -2508,7 +2500,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 static void
 s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
@@ -2533,11 +2525,9 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			   int *parity, int *bits)
 {
 	struct clk *clk;
-	unsigned int ulcon;
-	unsigned int ucon;
-	unsigned int ubrdiv;
 	unsigned long rate;
 	unsigned int clk_sel;
+	u32 ulcon, ucon, ubrdiv;
 	char clk_name[MAX_CLK_NAME_LENGTH];
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aa4f0803c8d3..0085d357a724 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2753,7 +2753,7 @@ static int sci_request_port(struct uart_port *port)
 
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0)) {
-		release_resource(res);
+		release_mem_region(port->mapbase, sport->reg_size);
 		return ret;
 	}
 
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 4b4f604646a7..0609944fe246 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -105,18 +105,24 @@ struct zs_parms {
 
 static struct zs_scc zs_sccs[ZS_NUM_SCCS];
 
+/*
+ * Set parameters in WR5, WR12, WR13 such as not to interfere
+ * with the initial PROM-based console.  Otherwise any output
+ * produced before the console handover would cause the system
+ * firmware to hang (TxENAB) or produce rubbish (Tx8, B9600).
+ */
 static u8 zs_init_regs[ZS_NUM_REGS] __initdata = {
 	0,				/* write 0 */
 	PAR_SPEC,			/* write 1 */
 	0,				/* write 2 */
 	0,				/* write 3 */
 	X16CLK | SB1,			/* write 4 */
-	0,				/* write 5 */
+	Tx8 | TxENAB,			/* write 5 */
 	0, 0, 0,			/* write 6, 7, 8 */
 	MIE | DLC | NV,			/* write 9 */
 	NRZ,				/* write 10 */
 	TCBR | RCBR,			/* write 11 */
-	0, 0,				/* BRG time constant, write 12 + 13 */
+	0x16, 0x00,			/* BRG time constant, write 12 + 13 */
 	BRSRC | BRENABL,		/* write 14 */
 	0,				/* write 15 */
 };
@@ -679,9 +685,9 @@ static void zs_status_handle(struct zs_port *zport, struct zs_port *zport_a)
 			uart_handle_dcd_change(uport,
 					       zport->mctrl & TIOCM_CAR);
 		if (delta & TIOCM_RNG)
-			uport->icount.dsr++;
-		if (delta & TIOCM_DSR)
 			uport->icount.rng++;
+		if (delta & TIOCM_DSR)
+			uport->icount.dsr++;
 
 		if (delta)
 			wake_up_interruptible(&uport->state->port.delta_msr_wait);
@@ -825,21 +831,22 @@ static void zs_shutdown(struct uart_port *uport)
 
 static void zs_reset(struct zs_port *zport)
 {
+	struct zs_port *zport_a = &zport->scc->zport[ZS_CHAN_A];
 	struct zs_scc *scc = zport->scc;
 	int irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&scc->zlock, flags);
 	irq = !irqs_disabled_flags(flags);
-	if (!scc->initialised) {
+	if (!zport->initialised) {
 		/* Reset the pointer first, just in case...  */
 		read_zsreg(zport, R0);
 		/* And let the current transmission finish.  */
 		zs_line_drain(zport, irq);
-		write_zsreg(zport, R9, FHWRES);
+		write_zsreg(zport, R9, zport == zport_a ? CHRA : CHRB);
 		udelay(10);
 		write_zsreg(zport, R9, 0);
-		scc->initialised = 1;
+		zport->initialised = 1;
 	}
 	load_zsregs(zport, zport->regs, irq);
 	spin_unlock_irqrestore(&scc->zlock, flags);
@@ -955,23 +962,6 @@ static void zs_set_termios(struct uart_port *uport, struct ktermios *termios,
 	spin_unlock_irqrestore(&scc->zlock, flags);
 }
 
-/*
- * Hack alert!
- * Required solely so that the initial PROM-based console
- * works undisturbed in parallel with this one.
- */
-static void zs_pm(struct uart_port *uport, unsigned int state,
-		  unsigned int oldstate)
-{
-	struct zs_port *zport = to_zport(uport);
-
-	if (state < 3)
-		zport->regs[5] |= TxENAB;
-	else
-		zport->regs[5] &= ~TxENAB;
-	write_zsreg(zport, R5, zport->regs[5]);
-}
-
 
 static const char *zs_type(struct uart_port *uport)
 {
@@ -1054,7 +1044,6 @@ static const struct uart_ops zs_ops = {
 	.startup	= zs_startup,
 	.shutdown	= zs_shutdown,
 	.set_termios	= zs_set_termios,
-	.pm		= zs_pm,
 	.type		= zs_type,
 	.release_port	= zs_release_port,
 	.request_port	= zs_request_port,
@@ -1209,7 +1198,6 @@ static int __init zs_console_setup(struct console *co, char *options)
 		return ret;
 
 	zs_reset(zport);
-	zs_pm(uport, 0, -1);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
diff --git a/drivers/tty/serial/zs.h b/drivers/tty/serial/zs.h
index 26ef8eafa1c1..8e51f847bc03 100644
--- a/drivers/tty/serial/zs.h
+++ b/drivers/tty/serial/zs.h
@@ -22,6 +22,7 @@
 struct zs_port {
 	struct zs_scc	*scc;			/* Containing SCC.  */
 	struct uart_port port;			/* Underlying UART.  */
+	int		initialised;		/* For the console port.  */
 
 	int		clk_mode;		/* May be 1, 16, 32, or 64.  */
 
@@ -41,7 +42,6 @@ struct zs_scc {
 	struct zs_port	zport[2];
 	spinlock_t	zlock;
 	atomic_t	irq_guard;
-	int		initialised;
 };
 
 #endif /* __KERNEL__ */
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 19830cdf8588..ff10668b0f13 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2812,9 +2812,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
 
 	if (request) {
-		if (trb)
+		if (trb) {
 			*trb = trb_tmp;
 
+			/*
+			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
+			 * Manually reset EP_TRADDR to the current TRB to prevent
+			 * the hardware from skipping the interrupted request.
+			 */
+			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
+						priv_req->start_trb * TRB_SIZE),
+						&priv_dev->regs->ep_traddr);
+		}
+
 		cdns3_rearm_transfer(priv_ep, 1);
 	}
 
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 9cb647203dcf..c4f5b6a6cf90 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -120,14 +120,14 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns->usb2_phy))
 		return PTR_ERR(cdns->usb2_phy);
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return PTR_ERR(cdns->usb3_phy);
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
@@ -181,6 +181,9 @@ static int cdns3_plat_remove(struct platform_device *pdev)
 	struct device *dev = cdns->dev;
 
 	pm_runtime_get_sync(dev);
+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
+		pm_runtime_allow(dev);
+
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	cdns_remove(cdns);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 6541bec61cc8..c42614319265 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -659,12 +659,6 @@ static int ci_usb_role_switch_set(struct usb_role_switch *sw,
 	return 0;
 }
 
-static struct usb_role_switch_desc ci_role_switch = {
-	.set = ci_usb_role_switch_set,
-	.get = ci_usb_role_switch_get,
-	.allow_userspace_control = true,
-};
-
 static int ci_get_platdata(struct device *dev,
 		struct ci_hdrc_platform_data *platdata)
 {
@@ -791,9 +785,6 @@ static int ci_get_platdata(struct device *dev,
 			cable->connected = false;
 	}
 
-	if (device_property_read_bool(dev, "usb-role-switch"))
-		ci_role_switch.fwnode = dev->fwnode;
-
 	platdata->pctl = devm_pinctrl_get(dev);
 	if (!IS_ERR(platdata->pctl)) {
 		struct pinctrl_state *p;
@@ -1013,6 +1004,7 @@ ATTRIBUTE_GROUPS(ci);
 
 static int ci_hdrc_probe(struct platform_device *pdev)
 {
+	struct usb_role_switch_desc ci_role_switch = {};
 	struct device	*dev = &pdev->dev;
 	struct ci_hdrc	*ci;
 	struct resource	*res;
@@ -1154,7 +1146,11 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (ci_role_switch.fwnode) {
+	if (device_property_read_bool(dev, "usb-role-switch")) {
+		ci_role_switch.set = ci_usb_role_switch_set;
+		ci_role_switch.get = ci_usb_role_switch_get;
+		ci_role_switch.allow_userspace_control = true;
+		ci_role_switch.fwnode = dev_fwnode(dev);
 		ci_role_switch.driver_data = ci;
 		ci->role_switch = usb_role_switch_register(dev,
 					&ci_role_switch);
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index bf8690bb654f..593db4491ff7 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2310,6 +2310,14 @@ static void usbtmc_interrupt(struct urb *urb)
 
 	switch (status) {
 	case 0: /* SUCCESS */
+		/* ensure at least two bytes of headers were transferred */
+		if (urb->actual_length < 2) {
+			dev_warn(dev,
+				"actual length %d not sufficient for interrupt headers\n",
+				urb->actual_length);
+			goto exit;
+		}
+
 		/* check for valid STB notification */
 		if (data->iin_buffer[0] > 0x81) {
 			data->bNotify1 = data->iin_buffer[0];
@@ -2436,6 +2444,12 @@ static int usbtmc_probe(struct usb_interface *intf,
 		data->iin_ep = int_in->bEndpointAddress;
 		data->iin_wMaxPacketSize = usb_endpoint_maxp(int_in);
 		data->iin_interval = int_in->bInterval;
+		/* wMaxPacketSize should be 0x02 or more as per USB488 Table 22 */
+		if (iface_desc->desc.bInterfaceProtocol == 1 &&
+		    data->iin_wMaxPacketSize < 2) {
+			retcode = -EINVAL;
+			goto err_put;
+		}
 		dev_dbg(&intf->dev, "Found Int in endpoint at %u\n",
 				data->iin_ep);
 	}
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 7c5ec9b5202e..f2818c8a16f5 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -165,7 +165,14 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 			(desc->bMaxBurst + 1);
 	else
 		max_tx = 999999;
-	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
+	/*
+	 * wBytesPerInterval > max_tx is bogus, but USB3 spec doesn't forbid the opposite.
+	 * Experience shows that wBytesPerInterval < wMaxPacketSize on common interrupt IN
+	 * endpoints is usually bogus too, and recent HCs enforce interrupt BW limits.
+	 */
+	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx ||
+	    (le16_to_cpu(desc->wBytesPerInterval) < usb_endpoint_maxp(&ep->desc) &&
+	     usb_endpoint_is_int_in(&ep->desc))) {
 		dev_notice(ddev, "%s endpoint with wBytesPerInterval of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to %d\n",
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 860948e46893..60b35e332272 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -353,9 +353,7 @@ static const u8 ss_rh_config_descriptor[] = {
 	USB_DT_ENDPOINT, /* __u8 ep_bDescriptorType; Endpoint */
 	0x81,       /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
 	0x03,       /*  __u8  ep_bmAttributes; Interrupt */
-		    /* __le16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8)
-		     * see hub.c:hub_configure() for details. */
-	(USB_MAXCHILDREN + 1 + 7) / 8, 0x00,
+	0x02, 0x00, /* __le16 ep_wMaxPacketSize; 2 bytes per USB3 10.15.1 */
 	0x0c,       /*  __u8  ep_bInterval; (256ms -- usb 2.0 spec) */
 
 	/* one SuperSpeed endpoint companion descriptor */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 069ffa0b628b..1c796bbaca9e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -497,6 +497,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
 	{ USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Lenovo ThinkPad USB-C Dock Gen2 USB 3.1 and USB 2.0 hub controllers */
+	{ USB_DEVICE(0x17ef, 0xa391), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x17ef, 0xa392), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* BUILDWIN Photo Frame */
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
 			USB_QUIRK_HONOR_BNUMINTERFACES },
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index c4d90c0f5180..109b02830d88 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4837,6 +4837,7 @@ static int _dwc2_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	int rc;
 	unsigned long flags;
+	int urb_status;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD URB Dequeue\n");
 	dwc2_dump_urb_info(hcd, urb, "urb_dequeue");
@@ -4861,11 +4862,12 @@ static int _dwc2_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
 
 	/* Higher layer software sets URB status */
 	spin_unlock(&hsotg->lock);
+	urb_status = urb->status;
 	usb_hcd_giveback_urb(hcd, urb, status);
 	spin_lock(&hsotg->lock);
 
 	dev_dbg(hsotg->dev, "Called usb_hcd_giveback_urb()\n");
-	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb->status);
+	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb_status);
 out:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9966b016190..63a8528da1ba 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -978,12 +978,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
@@ -1023,6 +1017,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err1;
 
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a6f3a9b38789..df545763a591 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -165,15 +165,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(usb3_phy);
-	if (ret < 0) {
-		phy_exit(usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	/* Set PIPE Power Present signal in FPD Power Present Register*/
@@ -185,20 +183,18 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(usb3_phy);
-	if (ret < 0) {
-		phy_exit(usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 skip_usb3_phy:
 	/*
@@ -212,6 +208,10 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 	}
 
+	return 0;
+
+err_phy_exit:
+	phy_exit(usb3_phy);
 err:
 	return ret;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 9fcf27e6f0e4..6efa8ac71b1a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -592,7 +592,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		/* unlocks spinlock */
 		ret = __ffs_ep0_queue_wait(ffs, data, len);
-		if ((ret > 0) && (copy_to_user(buf, data, len)))
+		if ((ret > 0) && (copy_to_user(buf, data, ret)))
 			ret = -EFAULT;
 		goto done_mutex;
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f8cc26af702c..7b19f8ffa871 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1265,7 +1265,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
 	mutex_lock(&opts->lock);
-	++opts->refcnt;
 
 	spin_lock_init(&hidg->write_spinlock);
 	spin_lock_init(&hidg->read_spinlock);
@@ -1278,11 +1277,8 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.class = hidg_class;
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
-	if (ret) {
-		--opts->refcnt;
-		mutex_unlock(&opts->lock);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1293,14 +1289,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 					    opts->report_desc_length,
 					    GFP_KERNEL);
 		if (!hidg->report_desc) {
-			put_device(&hidg->dev);
-			--opts->refcnt;
-			mutex_unlock(&opts->lock);
-			return ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_put_device;
 		}
 	}
 	hidg->use_out_ep = !opts->no_out_endpoint;
 
+	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
 	hidg->func.name    = "hid";
@@ -1315,6 +1310,11 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
+
+err_put_device:
+	put_device(&hidg->dev);
+	mutex_unlock(&opts->lock);
+	return ERR_PTR(ret);
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index d95caa486e13..51819a75925f 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2122,6 +2122,8 @@ static int dummy_hub_control(
 	case ClearHubFeature:
 		break;
 	case ClearPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -2236,6 +2238,8 @@ static int dummy_hub_control(
 		retval = -EPIPE;
 		break;
 	case SetPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_LINK_STATE:
 			if (hcd->speed != HCD_USB3) {
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 16e7d2db6411..310ce3eb5506 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3796,10 +3796,8 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 done:
-	if (dev) {
+	if (dev)
 		net2280_remove(pdev);
-		kfree(dev);
-	}
 	return retval;
 }
 
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 14a772feab79..0f936aeb88d0 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -210,6 +210,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 };
 
 struct tegra_xusb_context {
@@ -1211,14 +1212,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	struct tegra_xusb_mbox_msg msg;
 	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
 						    tegra->otg_usb2_port);
+	bool host_mode;
 	u32 status;
 	int ret;
 
-	dev_dbg(tegra->dev, "host mode %s\n", tegra->host_mode ? "on" : "off");
-
 	mutex_lock(&tegra->lock);
 
-	if (tegra->host_mode)
+	host_mode = tegra->host_mode;
+
+	dev_dbg(tegra->dev, "host mode %s\n", host_mode ? "on" : "off");
+
+	if (host_mode)
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
 	else
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
@@ -1229,42 +1233,44 @@ static void tegra_xhci_id_work(struct work_struct *work)
 								    tegra->otg_usb2_port);
 
 	pm_runtime_get_sync(tegra->dev);
-	if (tegra->host_mode) {
-		/* switch to host mode */
-		if (tegra->otg_usb3_port >= 0) {
-			if (tegra->soc->otg_reset_sspi) {
-				/* set PP=0 */
-				tegra_xhci_hc_driver.hub_control(
-					xhci->shared_hcd, GetPortStatus,
-					0, tegra->otg_usb3_port+1,
-					(char *) &status, sizeof(status));
-				if (status & USB_SS_PORT_STAT_POWER)
-					tegra_xhci_set_port_power(tegra, false,
-								  false);
-
-				/* reset OTG port SSPI */
-				msg.cmd = MBOX_CMD_RESET_SSPI;
-				msg.data = tegra->otg_usb3_port+1;
-
-				ret = tegra_xusb_mbox_send(tegra, &msg);
-				if (ret < 0) {
-					dev_info(tegra->dev,
-						"failed to RESET_SSPI %d\n",
-						ret);
+	if (tegra->soc->otg_set_port_power) {
+		if (host_mode) {
+			/* switch to host mode */
+			if (tegra->otg_usb3_port >= 0) {
+				if (tegra->soc->otg_reset_sspi) {
+					/* set PP=0 */
+					tegra_xhci_hc_driver.hub_control(
+						xhci->shared_hcd, GetPortStatus,
+						0, tegra->otg_usb3_port+1,
+						(char *) &status, sizeof(status));
+					if (status & USB_SS_PORT_STAT_POWER)
+						tegra_xhci_set_port_power(tegra, false,
+									  false);
+
+					/* reset OTG port SSPI */
+					msg.cmd = MBOX_CMD_RESET_SSPI;
+					msg.data = tegra->otg_usb3_port+1;
+
+					ret = tegra_xusb_mbox_send(tegra, &msg);
+					if (ret < 0) {
+						dev_info(tegra->dev,
+							"failed to RESET_SSPI %d\n",
+							ret);
+					}
 				}
-			}
 
-			tegra_xhci_set_port_power(tegra, false, true);
-		}
+				tegra_xhci_set_port_power(tegra, false, true);
+			}
 
-		tegra_xhci_set_port_power(tegra, true, true);
-		pm_runtime_mark_last_busy(tegra->dev);
+			tegra_xhci_set_port_power(tegra, true, true);
+			pm_runtime_mark_last_busy(tegra->dev);
 
-	} else {
-		if (tegra->otg_usb3_port >= 0)
-			tegra_xhci_set_port_power(tegra, false, false);
+		} else {
+			if (tegra->otg_usb3_port >= 0)
+				tegra_xhci_set_port_power(tegra, false, false);
 
-		tegra_xhci_set_port_power(tegra, true, false);
+			tegra_xhci_set_port_power(tegra, true, false);
+		}
 	}
 	pm_runtime_put_autosuspend(tegra->dev);
 }
@@ -2289,6 +2295,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2325,6 +2332,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2366,6 +2374,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -2397,6 +2406,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.mbox = {
 		.cmd = 0x68,
 		.data_in = 0x6c,
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index efc91ee0d896..80b132af1a86 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -194,6 +194,9 @@ static void belkin_sa_read_int_callback(struct urb *urb)
 
 	usb_serial_debug_data(&port->dev, __func__, urb->actual_length, data);
 
+	if (urb->actual_length < BELKIN_SA_MSR_INDEX + 1)
+		goto exit;
+
 	/* Handle known interrupt data */
 	/* ignore data[0] and data[1] */
 
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 6924fa95f6bd..2ca7e7af714f 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -447,6 +447,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(struct cypress_private), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -1018,8 +1026,8 @@ static void cypress_read_int_callback(struct urb *urb)
 	char tty_flag = TTY_NORMAL;
 	int bytes = 0;
 	int result;
-	int i = 0;
 	int status = urb->status;
+	int i;
 
 	switch (status) {
 	case 0: /* success */
@@ -1057,22 +1065,32 @@ static void cypress_read_int_callback(struct urb *urb)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	result = urb->actual_length;
+	i = 0;
 	switch (priv->pkt_fmt) {
 	default:
 	case packet_format_1:
 		/* This is for the CY7C64013... */
+		if (result < 2)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = data[1] + 2;
 		i = 2;
 		break;
 	case packet_format_2:
 		/* This is for the CY7C63743... */
+		if (result < 1)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = (data[0] & 0x07) + 1;
 		i = 1;
 		break;
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
+	if (i == 0) {
+		dev_dbg(dev, "%s - short packet received: %d bytes\n",
+			__func__, result);
+		goto continue_read;
+	}
 	if (result < bytes) {
 		dev_dbg(dev,
 			"%s - wrong packet size - received %d bytes but packet said %d bytes\n",
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index af65eb863d70..6edc1b50a364 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1228,15 +1228,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
 static int digi_startup(struct usb_serial *serial)
 {
 	struct digi_serial *serial_priv;
+	int oob_port_num;
 	int ret;
+	int i;
+
+	/*
+	 * The port bulk-out buffers must be large enough for header and
+	 * buffered data.
+	 */
+	for (i = 0; i < serial->type->num_ports; i++) {
+		if (serial->port[i]->bulk_out_size < DIGI_OUT_BUF_SIZE + 2)
+			return -EINVAL;
+	}
+
+	/*
+	 * The OOB port bulk-out buffer must be large enough for the two
+	 * commands in digi_set_modem_signals().
+	 */
+	oob_port_num = serial->type->num_ports;
+	if (serial->port[oob_port_num]->bulk_out_size < 8)
+		return -EINVAL;
 
 	serial_priv = kzalloc(sizeof(*serial_priv), GFP_KERNEL);
 	if (!serial_priv)
 		return -ENOMEM;
 
 	spin_lock_init(&serial_priv->ds_serial_lock);
-	serial_priv->ds_oob_port_num = serial->type->num_ports;
-	serial_priv->ds_oob_port = serial->port[serial_priv->ds_oob_port_num];
+	serial_priv->ds_oob_port_num = oob_port_num;
+	serial_priv->ds_oob_port = serial->port[oob_port_num];
 
 	ret = digi_port_init(serial_priv->ds_oob_port,
 						serial_priv->ds_oob_port_num);
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index feba2a8d1233..da3b5599306b 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -772,6 +772,12 @@ static int get_manuf_info(struct edgeport_serial *serial, u8 *buffer)
 	}
 
 	/* Read the descriptor data */
+	if (le16_to_cpu(rom_desc->Size) != sizeof(struct edge_ti_manuf_descriptor)) {
+		dev_err(dev, "unexpected Edge descriptor length: %u\n",
+			le16_to_cpu(rom_desc->Size));
+		status = -EINVAL;
+		goto exit;
+	}
 	status = read_rom(serial, start_address+sizeof(struct ti_i2c_desc),
 					le16_to_cpu(rom_desc->Size), buffer);
 	if (status)
@@ -837,6 +843,11 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 	/* Pointer to fw_down memory image */
 	img_header = (struct ti_i2c_image_header *)&fw->data[4];
 
+	if (le16_to_cpu(img_header->Length) >
+			buffer_size - sizeof(struct ti_i2c_firmware_rec)) {
+		kfree(buffer);
+		return -EINVAL;
+	}
 	memcpy(buffer + sizeof(struct ti_i2c_firmware_rec),
 		&fw->data[4 + sizeof(struct ti_i2c_image_header)],
 		le16_to_cpu(img_header->Length));
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 1cfcd805f286..5e7a89c669ee 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1184,6 +1184,10 @@ static void usa49wg_indat_callback(struct urb *urb)
 	len = 0;
 
 	while (i < urb->actual_length) {
+		if (urb->actual_length - i < 3) {
+			dev_warn_ratelimited(&urb->dev->dev, "malformed indat packet\n");
+			break;
+		}
 
 		/* Check port number from message */
 		if (data[i] >= serial->num_ports) {
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index f1e9628a9907..3fea0a0cebf7 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -357,8 +357,8 @@ static int klsi_105_prepare_write_buffer(struct usb_serial_port *port,
 	unsigned char *buf = dest;
 	int count;
 
-	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN, size,
-								&port->lock);
+	count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
+				 size - KLSI_HDR_LEN, &port->lock);
 	put_unaligned_le16(count, buf);
 
 	return count + KLSI_HDR_LEN;
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index ecd5b921e374..a359669df3df 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -378,6 +378,7 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv;
+	u16 pid;
 
 	/* check first to simplify error handling */
 	if (!serial->port[1] || !serial->port[1]->interrupt_in_urb) {
@@ -385,6 +386,16 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * Compensate for a hardware bug: although the Sitecom U232-P25
+	 * device reports a maximum output packet size of 32 bytes,
+	 * it seems to be able to accept only 16 bytes (and that's what
+	 * SniffUSB says too...)
+	 */
+	pid = le16_to_cpu(serial->dev->descriptor.idProduct);
+	if (pid == MCT_U232_SITECOM_PID)
+		port->bulk_out_size = min(16, port->bulk_out_size);
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -410,7 +421,6 @@ static void mct_u232_port_remove(struct usb_serial_port *port)
 
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 	int retval = 0;
 	unsigned int control_state;
@@ -418,15 +428,6 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char last_lcr;
 	unsigned char last_msr;
 
-	/* Compensate for a hardware bug: although the Sitecom U232-P25
-	 * device reports a maximum output packet size of 32 bytes,
-	 * it seems to be able to accept only 16 bytes (and that's what
-	 * SniffUSB says too...)
-	 */
-	if (le16_to_cpu(serial->dev->descriptor.idProduct)
-						== MCT_U232_SITECOM_PID)
-		port->bulk_out_size = 16;
-
 	/* Do a defined restart: the normal serial device seems to
 	 * always turn on DTR and RTS here, so do the same. I'm not
 	 * sure if this is really necessary. But it should not harm
@@ -543,6 +544,11 @@ static void mct_u232_read_int_callback(struct urb *urb)
 		goto exit;
 	}
 
+	if (urb->actual_length < 2) {
+		dev_warn_ratelimited(&port->dev, "short interrupt-in packet\n");
+		goto exit;
+	}
+
 	/*
 	 * The interrupt-in pipe signals exceptional conditions (modem line
 	 * signal changes and errors). data[0] holds MSR, data[1] holds LSR.
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index eb45a9b0005c..b4270beb6fe0 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct usb_serial *serial,
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
 
+	/*
+	 * The bulk-out buffers must be large enough for the four-byte header
+	 * (and following data), but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
+		return -EINVAL;
+
 	for (i = 1; i < num_ports; ++i)
 		epds->bulk_out[i] = epds->bulk_out[0];
 
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 41f1b872d277..51bf6bef691b 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -30,6 +30,10 @@
 /* This one seems to be a re-branded ZyXEL device */
 #define BT_IGNITIONPRO_ID	0x2000
 
+#define OMNINET_HEADERLEN	4
+#define OMNINET_BULKOUTSIZE	64
+#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
+
 /* function prototypes */
 static void omninet_process_read_urb(struct urb *urb);
 static int omninet_prepare_write_buffer(struct usb_serial_port *port,
@@ -55,6 +59,7 @@ static struct usb_serial_driver zyxel_omninet_device = {
 	.description =		"ZyXEL - omni.net usb",
 	.id_table =		id_table,
 	.num_bulk_out =		2,
+	.bulk_out_size =	OMNINET_BULKOUTSIZE,
 	.calc_num_ports =	omninet_calc_num_ports,
 	.port_probe =		omninet_port_probe,
 	.port_remove =		omninet_port_remove,
@@ -131,10 +136,6 @@ static void omninet_port_remove(struct usb_serial_port *port)
 	kfree(od);
 }
 
-#define OMNINET_HEADERLEN	4
-#define OMNINET_BULKOUTSIZE	64
-#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
-
 static void omninet_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f9f563fad127..f98536fe9aca 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -202,6 +202,7 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5821E_ESIM			0x81e0
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
+#define DELL_PRODUCT_5826E_ESIM			0x81ea
 
 #define DELL_PRODUCT_FM101R_ESIM		0x8213
 #define DELL_PRODUCT_FM101R			0x8215
@@ -1123,6 +1124,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_5826E_ESIM, 0xff),
+	  .driver_info = RSVD(1) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
 	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
@@ -2450,6 +2453,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM825WN (Diag) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825WN (AT) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825WN (NMEA) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x60) },	/* MeiG SRM813Q (NMEA) */
+
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
@@ -2470,7 +2479,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
-	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff) },			/* Rolling RW135R-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff),			/* Rolling RW135R-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 6accbecb6318..f9332b2c3560 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -259,6 +259,7 @@ static int safe_prepare_write_buffer(struct usb_serial_port *port,
 static int safe_startup(struct usb_serial *serial)
 {
 	struct usb_interface_descriptor	*desc;
+	int bulk_out_size;
 
 	if (serial->dev->descriptor.bDeviceClass != CDC_DEVICE_CLASS)
 		return -ENODEV;
@@ -279,6 +280,16 @@ static int safe_startup(struct usb_serial *serial)
 	default:
 		return -EINVAL;
 	}
+
+	/*
+	 * The bulk-out buffer needs to be large enough for the two-byte
+	 * trailer in safe mode, but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	bulk_out_size = serial->port[0]->bulk_out_size;
+	if (bulk_out_size > 0 && bulk_out_size < 8)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 939a98c2d3f7..d6f86d5db3bf 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -132,6 +132,13 @@ UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
 
+/* Reported-by: Sam Burkels <sam@1a38.nl> */
+UNUSUAL_DEV(0x154b, 0xf009, 0x0000, 0x9999,
+		"PNY",
+		"PNY ELITE PSSD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X | US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
 UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
 		"PNY",
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index d6725bfde016..2c5264d5ce50 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -286,6 +286,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			dp->data.conf = 0;
 			break;
 		case DP_CMD_STATUS_UPDATE:
+			if (count < 2)
+				break;
 			dp->data.status = *vdo;
 			ret = dp_altmode_status_update(dp);
 			break;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d70813c89fff..f8ef556a795d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4576,6 +4576,8 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 5d34466a0abf..36052a44537b 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -444,9 +444,11 @@ static int wcove_start_toggling(struct tcpc_dev *tcpc,
 	return regmap_write(wcove->regmap, USBC_CONTROL1, usbc_ctrl);
 }
 
-static int wcove_read_rx_buffer(struct wcove_typec *wcove, void *msg)
+static int wcove_read_rx_buffer(struct wcove_typec *wcove,
+				struct pd_message *msg)
 {
-	unsigned int info;
+	unsigned int info, val, len;
+	u8 *buf = (u8 *)msg;
 	int ret;
 	int i;
 
@@ -454,12 +456,13 @@ static int wcove_read_rx_buffer(struct wcove_typec *wcove, void *msg)
 	if (ret)
 		return ret;
 
-	/* FIXME: Check that USBC_RXINFO_RXBYTES(info) matches the header */
+	len = min(USBC_RXINFO_RXBYTES(info), sizeof(*msg));
 
-	for (i = 0; i < USBC_RXINFO_RXBYTES(info); i++) {
-		ret = regmap_read(wcove->regmap, USBC_RX_DATA + i, msg + i);
+	for (i = 0; i < len; i++) {
+		ret = regmap_read(wcove->regmap, USBC_RX_DATA + i, &val);
 		if (ret)
 			return ret;
+		buf[i] = val;
 	}
 
 	return regmap_write(wcove->regmap, USBC_RXSTATUS,
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index e3b5fa3b5f95..11c7da45a562 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -240,6 +240,10 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 				dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 			break;
 		case DP_CMD_CONFIGURE:
+			if (count < 2) {
+				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
+				break;
+			}
 			dp->data.conf = *data;
 			if (ucsi_displayport_configure(dp)) {
 				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 05a2909e84fd..34b6965ee30b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -669,7 +669,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	struct ucsi *ucsi = con->ucsi;
 	struct ucsi_connector_status pre_ack_status;
 	struct ucsi_connector_status post_ack_status;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	enum usb_role u_role = USB_ROLE_NONE;
 	u16 inferred_changes;
 	u16 changed_flags;
@@ -706,6 +706,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	 * short transitional changes.
 	 */
 
+	prev_role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
+
 	/* 1. First UCSI_GET_CONNECTOR_STATUS */
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 	ret = ucsi_send_command(ucsi, command, &pre_ack_status,
@@ -783,7 +785,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		ucsi_port_psy_changed(con);
 	}
 
-	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) &&
+	    role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 
 		/* Complete pending power role swap */
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index dffdb5eb506b..68a693d92dd0 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1156,6 +1156,11 @@ static int do_flash(struct ucsi_ccg *uc, enum enum_flash_mode mode)
 	 *****************************************************************/
 
 	p = strnchr(fw->data, fw->size, ':');
+	if (!p) {
+		dev_err(dev, "Bad FW format: no ':' record header found\n");
+		err = -EINVAL;
+		goto release_mem;
+	}
 	while (p < eof) {
 		s = strnchr(p + 1, eof - p - 1, ':');
 
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index e604bd759506..916732015b97 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -309,7 +309,7 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 	if (!sock || !buf || !size)
 		return -EINVAL;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 
 	usbip_dbg_xmit("enter\n");
 
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 2bc428f2e261..dcbfed30806d 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
 {
 	struct vudc *udc = platform_get_drvdata(pdev);
 
+	v_stop_timer(udc);
 	usb_del_gadget_udc(&udc->gadget);
 	cleanup_vudc_hw(udc);
 	kfree(udc);
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index 7e801fee33bf..94b9549c14cb 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -490,7 +490,8 @@ void v_stop_timer(struct vudc *udc)
 {
 	struct transfer_timer *t = &udc->tr_timer;
 
-	/* timer itself will take care of stopping */
+	/* Delete the timer synchronously before teardown frees udc. */
 	dev_dbg(&udc->pdev->dev, "timer stop");
+	timer_delete_sync(&t->timer);
 	t->state = VUDC_TR_STOPPED;
 }
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 9d454da41995..3d98af5045bb 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -615,7 +615,7 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 	/* Skip header. TODO: support TSO. */
 	size_t len = iov_length(vq->iov, out);
 
-	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
 	return iov_iter_count(iter);
@@ -1193,14 +1193,14 @@ static void handle_rx(struct vhost_net *net)
 			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		/* On overrun, truncate and discard */
 		if (unlikely(headcount > UIO_MAXIOV)) {
-			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
+			iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, 1, 1);
 			err = sock->ops->recvmsg(sock, &msg,
 						 1, MSG_DONTWAIT | MSG_TRUNC);
 			pr_debug("Discarded rx packet: len %zd\n", sock_len);
 			continue;
 		}
 		/* We don't need to be notified again. */
-		iov_iter_init(&msg.msg_iter, READ, vq->iov, in, vhost_len);
+		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
 		if (unlikely((vhost_hlen))) {
 			/* We will supply the header ourselves
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index dff93612fcfd..ff430b6d2e1f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -558,7 +558,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
 		       se_cmd->scsi_sense_length);
 
-		iov_iter_init(&iov_iter, READ, &cmd->tvc_resp_iov,
+		iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
@@ -863,7 +863,7 @@ vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	 * point at the start of the outgoing WRITE payload, if
 	 * DMA_TO_DEVICE is set.
 	 */
-	iov_iter_init(&vc->out_iter, WRITE, vq->iov, vc->out, vc->out_size);
+	iov_iter_init(&vc->out_iter, ITER_SOURCE, vq->iov, vc->out, vc->out_size);
 	ret = 0;
 
 done:
@@ -1016,7 +1016,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			data_direction = DMA_FROM_DEVICE;
 			exp_data_len = vc.in_size - vc.rsp_size;
 
-			iov_iter_init(&in_iter, READ, &vq->iov[vc.out], vc.in,
+			iov_iter_init(&in_iter, ITER_DEST, &vq->iov[vc.out], vc.in,
 				      vc.rsp_size + exp_data_len);
 			iov_iter_advance(&in_iter, vc.rsp_size);
 			data_iter = in_iter;
@@ -1146,7 +1146,7 @@ vhost_scsi_send_tmf_resp(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.response = tmf_resp_code;
 
-	iov_iter_init(&iov_iter, READ, resp_iov, in_iovs, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, resp_iov, in_iovs, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
@@ -1241,7 +1241,7 @@ vhost_scsi_send_an_resp(struct vhost_scsi *vs,
 	memset(&rsp, 0, sizeof(rsp));	/* event_actual = 0 */
 	rsp.response = VIRTIO_SCSI_S_OK;
 
-	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 973e079025a9..9f6e41e28d6a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -841,7 +841,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 				     VHOST_ACCESS_WO);
 		if (ret < 0)
 			goto out;
-		iov_iter_init(&t, WRITE, vq->iotlb_iov, ret, size);
+		iov_iter_init(&t, ITER_SOURCE, vq->iotlb_iov, ret, size);
 		ret = copy_to_iter(from, size, &t);
 		if (ret == size)
 			ret = 0;
@@ -880,7 +880,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 			       (unsigned long long) size);
 			goto out;
 		}
-		iov_iter_init(&f, READ, vq->iotlb_iov, ret, size);
+		iov_iter_init(&f, ITER_DEST, vq->iotlb_iov, ret, size);
 		ret = copy_from_iter(to, size, &f);
 		if (ret == size)
 			ret = 0;
@@ -2137,7 +2137,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 			vq_err(vq, "Translation failure %d in indirect.\n", ret);
 		return ret;
 	}
-	iov_iter_init(&from, READ, vq->indirect, ret, len);
+	iov_iter_init(&from, ITER_DEST, vq->indirect, ret, len);
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 13b75213ebaa..e478a2c88f95 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1160,7 +1160,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 	if (ret < 0)
 		return ret;
 
-	iov_iter_bvec(&iter, READ, iov, ret, len);
+	iov_iter_bvec(&iter, ITER_DEST, iov, ret, len);
 
 	ret = copy_from_iter(dst, len, &iter);
 
@@ -1179,7 +1179,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 	if (ret < 0)
 		return ret;
 
-	iov_iter_bvec(&iter, WRITE, iov, ret, len);
+	iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, len);
 
 	return copy_to_iter(src, len, &iter);
 }
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a53d7bf40461..235cb8dee1b6 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -166,7 +166,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
+		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
 		payload_len = pkt->len - pkt->off;
 
 		/* If the packet is greater than the space available in the
@@ -372,7 +372,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		return NULL;
 
 	len = iov_length(vq->iov, out);
-	iov_iter_init(&iov_iter, WRITE, vq->iov, out, len);
+	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
 	nbytes = copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
 	if (nbytes != sizeof(pkt->hdr)) {
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index c2a0a936d5fb..e348f4c15d81 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -23,6 +23,75 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
+/*
+ * struct fb_deferred_io_state
+ */
+
+struct fb_deferred_io_state {
+	struct kref ref;
+
+	struct mutex lock; /* mutex that protects the pageref list */
+	/* fields protected by lock */
+	struct fb_info *info;
+};
+
+static struct fb_deferred_io_state *fb_deferred_io_state_alloc(void)
+{
+	struct fb_deferred_io_state *fbdefio_state;
+
+	fbdefio_state = kzalloc(sizeof(*fbdefio_state), GFP_KERNEL);
+	if (!fbdefio_state)
+		return NULL;
+
+	kref_init(&fbdefio_state->ref);
+	mutex_init(&fbdefio_state->lock);
+
+	return fbdefio_state;
+}
+
+static void fb_deferred_io_state_release(struct fb_deferred_io_state *fbdefio_state)
+{
+	mutex_destroy(&fbdefio_state->lock);
+
+	kfree(fbdefio_state);
+}
+
+static void fb_deferred_io_state_get(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_get(&fbdefio_state->ref);
+}
+
+static void __fb_deferred_io_state_release(struct kref *ref)
+{
+	struct fb_deferred_io_state *fbdefio_state =
+		container_of(ref, struct fb_deferred_io_state, ref);
+
+	fb_deferred_io_state_release(fbdefio_state);
+}
+
+static void fb_deferred_io_state_put(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_put(&fbdefio_state->ref, __fb_deferred_io_state_release);
+}
+
+/*
+ * struct vm_operations_struct
+ */
+
+static void fb_deferred_io_vm_open(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_get(fbdefio_state);
+}
+
+static void fb_deferred_io_vm_close(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_put(fbdefio_state);
+}
+
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
 	void *screen_base = (void __force *) info->screen_base;
@@ -93,17 +162,31 @@ static void fb_deferred_io_pageref_put(struct fb_deferred_io_pageref *pageref,
 /* this is to find and return the vmalloc-ed fb pages */
 static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 {
+	struct fb_info *info;
 	unsigned long offset;
 	struct page *page;
-	struct fb_info *info = vmf->vma->vm_private_data;
+	vm_fault_t ret;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
+
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
 
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= info->fix.smem_len)
-		return VM_FAULT_SIGBUS;
+	if (offset >= info->fix.smem_len) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	page = fb_deferred_io_page(info, offset);
-	if (!page)
-		return VM_FAULT_SIGBUS;
+	if (!page) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	get_page(page);
 
@@ -115,8 +198,14 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 	BUG_ON(!page->mapping);
 	page->index = vmf->pgoff; /* for page_mkclean() */
 
+	mutex_unlock(&fbdefio_state->lock);
+
 	vmf->page = page;
 	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&fbdefio_state->lock);
+	return ret;
 }
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
@@ -143,8 +232,9 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct fb_info *info = vmf->vma->vm_private_data;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
+	struct fb_info *info;
+	struct fb_deferred_io *fbdefio;
 	struct fb_deferred_io_pageref *pageref;
 	unsigned long offset;
 	vm_fault_t ret;
@@ -160,7 +250,15 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	file_update_time(vmf->vma->vm_file);
 
 	/* protect against the workqueue changing the page list */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
+
+	fbdefio = info->fbdefio;
 
 	/* first write in this cycle, notify the driver */
 	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
@@ -182,18 +280,20 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	 */
 	lock_page(pageref->page);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 	return VM_FAULT_LOCKED;
 
 err_mutex_unlock:
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 	return ret;
 }
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
+	.open		= fb_deferred_io_vm_open,
+	.close		= fb_deferred_io_vm_close,
 	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
@@ -215,7 +315,10 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
 	if (!(info->flags & FBINFO_VIRTFB))
 		vma->vm_flags |= VM_IO;
-	vma->vm_private_data = info;
+	vma->vm_private_data = info->fbdefio_state;
+
+	fb_deferred_io_state_get(info->fbdefio_state); /* released in vma->vm_ops->close() */
+
 	return 0;
 }
 
@@ -225,9 +328,10 @@ static void fb_deferred_io_work(struct work_struct *work)
 	struct fb_info *info = container_of(work, struct fb_info, deferred_work.work);
 	struct fb_deferred_io_pageref *pageref, *next;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	/* here we mkclean the pages, then do all deferred IO */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
 	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
 		struct page *cur = pageref->page;
 		lock_page(cur);
@@ -242,12 +346,13 @@ static void fb_deferred_io_work(struct work_struct *work)
 	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
 		fb_deferred_io_pageref_put(pageref, info);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 }
 
 int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 	struct fb_deferred_io_pageref *pagerefs;
 	unsigned long npagerefs, i;
 	int ret;
@@ -257,7 +362,11 @@ int fb_deferred_io_init(struct fb_info *info)
 	if (WARN_ON(!info->fix.smem_len))
 		return -EINVAL;
 
-	mutex_init(&fbdefio->lock);
+	fbdefio_state = fb_deferred_io_state_alloc();
+	if (!fbdefio_state)
+		return -ENOMEM;
+	fbdefio_state->info = info;
+
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
@@ -276,10 +385,12 @@ int fb_deferred_io_init(struct fb_info *info)
 	info->npagerefs = npagerefs;
 	info->pagerefs = pagerefs;
 
+	info->fbdefio_state = fbdefio_state;
+
 	return 0;
 
 err:
-	mutex_destroy(&fbdefio->lock);
+	fb_deferred_io_state_release(fbdefio_state);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
@@ -320,11 +431,18 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_release);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	fb_deferred_io_lastclose(info);
 
+	info->fbdefio_state = NULL;
+
+	mutex_lock(&fbdefio_state->lock);
+	fbdefio_state->info = NULL;
+	mutex_unlock(&fbdefio_state->lock);
+
+	fb_deferred_io_state_put(fbdefio_state);
+
 	kvfree(info->pagerefs);
-	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index ec3c883400f7..4a06e71ae443 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		info->fbops->fb_sync(info);
 
 	if (ops->fd_size < d_cellsize * len) {
+		kfree(ops->fontbuffer);
+		ops->fontbuffer = NULL;
+		ops->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		}
 
 		ops->fd_size = d_cellsize * len;
-		kfree(ops->fontbuffer);
 		ops->fontbuffer = dst;
 	}
 
diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index ccd316aac467..1608d21a51ae 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -434,7 +434,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 			  fbi->palette_cpu, fbi->palette_phys);
 failed_free_mem_virt:
 	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
-			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
+			  fbi->fb.screen_base, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index a1e8b6eab69d..50dc72c5e4ab 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -129,13 +129,13 @@ static bool pvcalls_conn_back_read(void *opaque)
 	if (masked_prod < masked_cons) {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = wanted;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 1, wanted);
 	} else {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = array_size - masked_prod;
 		vec[1].iov_base = data->in;
 		vec[1].iov_len = wanted - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 2, wanted);
 	}
 
 	atomic_set(&map->read, 0);
@@ -188,13 +188,13 @@ static bool pvcalls_conn_back_write(struct sock_mapping *map)
 	if (pvcalls_mask(prod, array_size) > pvcalls_mask(cons, array_size)) {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = size;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, size);
 	} else {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = array_size - pvcalls_mask(cons, array_size);
 		vec[1].iov_base = data->out;
 		vec[1].iov_len = size - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 2, size);
 	}
 
 	atomic_set(&map->write, 0);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 606d33ef35c6..7f69ea0ebbc6 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -50,7 +50,7 @@ static int v9fs_fid_readpage(void *data, struct page *page)
 	if (retval == 0)
 		return retval;
 
-	iov_iter_bvec(&to, READ, &bvec, 1, PAGE_SIZE);
+	iov_iter_bvec(&to, ITER_DEST, &bvec, 1, PAGE_SIZE);
 
 	retval = p9_client_read(fid, page_offset(page), &to, &err);
 	if (err) {
@@ -163,7 +163,7 @@ static int v9fs_vfs_writepage_locked(struct page *page)
 	bvec.bv_page = page;
 	bvec.bv_offset = 0;
 	bvec.bv_len = len;
-	iov_iter_bvec(&from, WRITE, &bvec, 1, len);
+	iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, len);
 
 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index b6a5a0be444d..67bbcf24ed2a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -108,7 +108,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
 			int n;
-			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
+			iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
 			if (err)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 31799ac10e33..5283ba599a83 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -32,7 +32,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	struct iov_iter to;
 	int err;
 
-	iov_iter_kvec(&to, READ, &kvec, 1, buffer_size);
+	iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buffer_size);
 
 	attr_fid = p9_client_xattrwalk(fid, name, &attr_size);
 	if (IS_ERR(attr_fid)) {
@@ -117,7 +117,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 	struct iov_iter from;
 	int retval, err;
 
-	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
+	iov_iter_kvec(&from, ITER_SOURCE, &kvec, 1, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index cedd627e1fae..573969a882e0 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -298,7 +298,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, afs_eproto_cb_count);
 		call->iter = &call->def_iter;
-		iov_iter_discard(&call->def_iter, READ, call->count2 * 3 * 4);
+		iov_iter_discard(&call->def_iter, ITER_DEST, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 		fallthrough;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d4bd6efc8c44..b44c0ce8ed44 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -315,7 +315,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
-	iov_iter_xarray(&req->def_iter, READ, &dvnode->vfs_inode.i_mapping->i_pages,
+	iov_iter_xarray(&req->def_iter, ITER_DEST, &dvnode->vfs_inode.i_mapping->i_pages,
 			0, i_size);
 	req->iter = &req->def_iter;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6774e1fcf7c5..c52005a68ae2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -305,7 +305,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
 
-	iov_iter_xarray(&fsreq->def_iter, READ,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST,
 			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
@@ -327,7 +327,7 @@ static int afs_symlink_readpage(struct page *page)
 	fsreq->len	= PAGE_SIZE;
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
-	iov_iter_xarray(&fsreq->def_iter, READ, &page->mapping->i_pages,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST, &page->mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
 	ret = afs_fetch_data(fsreq->vnode, fsreq);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3918dfbd72a4..9caae7bb2a8d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1296,7 +1296,7 @@ static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t si
 	call->iov_len = size;
 	call->kvec[0].iov_base = buf;
 	call->kvec[0].iov_len = size;
-	iov_iter_kvec(&call->def_iter, READ, call->kvec, 1, size);
+	iov_iter_kvec(&call->def_iter, ITER_DEST, call->kvec, 1, size);
 }
 
 static inline void afs_extract_to_tmp(struct afs_call *call)
@@ -1314,7 +1314,7 @@ static inline void afs_extract_to_tmp64(struct afs_call *call)
 static inline void afs_extract_discard(struct afs_call *call, size_t size)
 {
 	call->iov_len = size;
-	iov_iter_discard(&call->def_iter, READ, size);
+	iov_iter_discard(&call->def_iter, ITER_DEST, size);
 }
 
 static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ea40da937fcd..5441520125bd 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -358,7 +358,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
@@ -399,7 +399,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 					RX_USER_ABORT, ret, "KSD");
 	} else {
 		len = 0;
-		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
 				       &msg.msg_iter, &len, false,
 				       &call->abort_code, &call->service_id);
@@ -484,7 +484,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
 			len = 0;
-			iov_iter_kvec(&call->def_iter, READ, NULL, 0, 0);
+			iov_iter_kvec(&call->def_iter, ITER_DEST, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &call->def_iter,
 						     &len, false, &remote_abort,
@@ -821,7 +821,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, NULL, 0, 0);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -861,7 +861,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	iov[0].iov_len		= len;
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, len);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index a75c4742062a..9ec481b52cc5 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -601,7 +601,7 @@ static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
 	if (start < i_size) {
 		_debug("write back %x @%llx [%llx]", len, start, i_size);
 
-		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
 		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
 		_debug("write discard %x @%llx [%llx]", len, start, i_size);
@@ -972,7 +972,7 @@ int afs_launder_page(struct page *page)
 		bv[0].bv_page = page;
 		bv[0].bv_offset = f;
 		bv[0].bv_len = t - f;
-		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
 		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);
diff --git a/fs/aio.c b/fs/aio.c
index 0f02ea16305c..f502a7c84190 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1546,7 +1546,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_DEST, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
@@ -1574,7 +1574,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_SOURCE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 181c2d9041d1..62cf96fa12f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4691,6 +4691,8 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
+	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(inode), false);
+
 	/* now the directory is empty */
 	err = btrfs_unlink_inode(trans, BTRFS_I(dir),
 			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 388eee966a7a..d56d6144707b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3612,7 +3612,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -3668,7 +3668,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		ret = -EFAULT;
 
 	kfree(dest_orig);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e1096ca1a39b..7b65d4b5ebe8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -263,7 +263,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
 	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 43c8d7cde494..f1572609066e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -721,7 +721,8 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				d_add(dentry, NULL);
+				if (d_unhashed(dentry))
+					d_add(dentry, NULL);
 			}
 		}
 	}
@@ -777,7 +778,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
 			spin_unlock(&ci->i_ceph_lock);
 			dout(" dir %p complete, -ENOENT\n", dir);
-			d_add(dentry, NULL);
+			if (d_unhashed(dentry))
+				d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
 		}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index dad7a9ec4ad1..ca8d228ee395 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1111,7 +1111,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, READ, osd_data->bvec_pos.bvecs,
+			iov_iter_bvec(&i, ITER_DEST, osd_data->bvec_pos.bvecs,
 				      osd_data->num_bvecs, len);
 			iov_iter_advance(&i, rc);
 			iov_iter_zero(zlen, &i);
@@ -1347,7 +1347,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, READ, bvecs, num_pages, len);
+				iov_iter_bvec(&i, ITER_DEST, bvecs, num_pages, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bf861fef2f0c..0588b7f76f5d 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -753,6 +753,78 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 }
 #endif
 
+static int validate_dacl(struct cifs_acl *pdacl, char *end_of_acl)
+{
+	int i, ace_hdr_size, ace_size, min_ace_size;
+	u16 dacl_size;
+	u32 num_aces;
+	char *acl_base, *end_of_dacl;
+	struct cifs_ace *pace;
+
+	if (!pdacl)
+		return 0;
+
+	if (end_of_acl < (char *)pdacl + sizeof(struct cifs_acl)) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	dacl_size = le16_to_cpu(pdacl->size);
+	if (dacl_size < sizeof(struct cifs_acl) ||
+	    end_of_acl < (char *)pdacl + dacl_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	num_aces = le32_to_cpu(pdacl->num_aces);
+	if (!num_aces)
+		return 0;
+
+	ace_hdr_size = offsetof(struct cifs_ace, sid) +
+		offsetof(struct cifs_sid, sub_auth);
+	min_ace_size = ace_hdr_size + sizeof(__le32);
+	if (num_aces > (dacl_size - sizeof(struct cifs_acl)) / min_ace_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	end_of_dacl = (char *)pdacl + dacl_size;
+	acl_base = (char *)pdacl;
+	ace_size = sizeof(struct cifs_acl);
+
+	for (i = 0; i < num_aces; ++i) {
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		pace = (struct cifs_ace *)(acl_base + ace_size);
+		acl_base = (char *)pace;
+
+		if (end_of_dacl - acl_base < ace_hdr_size ||
+		    pace->sid.num_subauth == 0 ||
+		    pace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = ace_hdr_size + sizeof(__le32) * pace->sid.num_subauth;
+		if (end_of_dacl - acl_base < ace_size ||
+		    le16_to_cpu(pace->size) < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = le16_to_cpu(pace->size);
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		       struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
@@ -760,7 +832,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	int i;
 	int num_aces = 0;
 	int acl_size;
-	char *acl_base;
+	char *acl_base, *end_of_dacl;
 	struct cifs_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
@@ -772,11 +844,8 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		return;
 	}
 
-	/* validate that we do not go past end of acl */
-	if (end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
-		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+	if (validate_dacl(pdacl, end_of_acl))
 		return;
-	}
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
@@ -787,6 +856,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	   user/group/other have no permissions */
 	fattr->cf_mode &= ~(0777);
 
+	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct cifs_acl);
 
@@ -804,9 +874,10 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 		for (i = 0; i < num_aces; ++i) {
 			ppace[i] = (struct cifs_ace *) (acl_base + acl_size);
 #ifdef CONFIG_CIFS_DEBUG2
-			dump_ace(ppace[i], end_of_acl);
+			dump_ace(ppace[i], end_of_dacl);
 #endif
 			if (mode_from_special_sid &&
+			    ppace[i]->sid.num_subauth >= 3 &&
 			    (compare_sids(&(ppace[i]->sid),
 					  &sid_unix_NFS_mode) == 0)) {
 				/*
@@ -1183,6 +1254,17 @@ static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
 	return 0;
 }
 
+static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
+{
+	if (acl_len < sizeof(struct cifs_acl))
+		return false;
+
+	if (dacloffset < sizeof(struct cifs_ntsd))
+		return false;
+
+	return dacloffset <= acl_len - sizeof(struct cifs_acl);
+}
+
 
 /* Convert CIFS ACL to POSIX form */
 static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
@@ -1203,7 +1285,6 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1234,11 +1315,18 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		return rc;
 	}
 
-	if (dacloffset)
+	if (dacloffset) {
+		if (!dacl_offset_valid(acl_len, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+			return -EINVAL;
+		}
+
+		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
 		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
 			   group_sid_ptr, fattr, get_mode_from_special_sid);
-	else
+	} else {
 		cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default perms? */
+	}
 
 	return rc;
 }
@@ -1261,11 +1349,15 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
-		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
-		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
-			cifs_dbg(VFS, "Server returned illegal ACL size\n");
+		if (!dacl_offset_valid(secdesclen, dacloffset)) {
+			cifs_dbg(VFS, "Server returned illegal DACL offset\n");
 			return -EINVAL;
 		}
+
+		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+		rc = validate_dacl(dacl_ptr, end_of_acl);
+		if (rc)
+			return rc;
 	}
 
 	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
@@ -1624,7 +1716,19 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct cifs_ntsd) + (sizeof(struct cifs_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
+			if (!dacl_offset_valid(secdesclen, dacloffset)) {
+				cifs_dbg(VFS, "Server returned illegal DACL offset\n");
+				rc = -EINVAL;
+				goto id_mode_to_cifs_acl_exit;
+			}
+
 			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
+			if (rc) {
+				kfree(pntsd);
+				cifs_put_tlink(tlink);
+				return rc;
+			}
 			if (mode_from_sid)
 				nsecdesclen +=
 					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
@@ -1660,6 +1764,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		rc = ops->set_acl(pnntsd, nsecdesclen, inode, path, aclflag);
 		cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
 	}
+id_mode_to_cifs_acl_exit:
 	cifs_put_tlink(tlink);
 
 	kfree(pnntsd);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 098a2ad8cec4..5fd909825090 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -621,7 +621,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg = {};
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
-	iov_iter_kvec(&smb_msg.msg_iter, READ, &iov, 1, to_read);
+	iov_iter_kvec(&smb_msg.msg_iter, ITER_DEST, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -636,7 +636,7 @@ cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
 	 *  and cifs_readv_from_socket sets msg_control and msg_controllen
 	 *  so little to initialize in struct msghdr
 	 */
-	iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
+	iov_iter_discard(&smb_msg.msg_iter, ITER_DEST, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -648,7 +648,7 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	struct msghdr smb_msg = {};
 	struct bio_vec bv = {
 		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
-	iov_iter_bvec(&smb_msg.msg_iter, READ, &bv, 1, to_read);
+	iov_iter_bvec(&smb_msg.msg_iter, ITER_DEST, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 10bb1f955188..71f585a41d45 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3265,7 +3265,7 @@ static ssize_t __cifs_writev(
 		ctx->iter = *from;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, from, WRITE);
+		rc = setup_aio_ctx_iter(ctx, from, ITER_SOURCE);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
@@ -4010,7 +4010,7 @@ static ssize_t __cifs_readv(
 		ctx->iter = *to;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, to, READ);
+		rc = setup_aio_ctx_iter(ctx, to, ITER_DEST);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index e846c18b71d2..281515ed473d 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -262,7 +262,7 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		break;
 	case SMB2_ENCRYPTION_AES256_CCM:
 	case SMB2_ENCRYPTION_AES256_GCM:
-		out.session_key_length = CIFS_SESS_KEY_SIZE;
+		out.session_key_length = ses->auth_key.len;
 		out.server_in_key_length = out.server_out_key_length = SMB3_GCM256_CRYPTKEY_SIZE;
 		break;
 	default:
diff --git a/fs/cifs/netlink.c b/fs/cifs/netlink.c
index 291cb606f149..ab055f98e172 100644
--- a/fs/cifs/netlink.c
+++ b/fs/cifs/netlink.c
@@ -33,13 +33,17 @@ static const struct nla_policy cifs_genl_policy[CIFS_GENL_ATTR_MAX + 1] = {
 static const struct genl_ops cifs_genl_ops[] = {
 	{
 		.cmd = CIFS_GENL_CMD_SWN_NOTIFY,
+		.flags = GENL_ADMIN_PERM,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = cifs_swn_notify,
 	},
 };
 
 static const struct genl_multicast_group cifs_genl_mcgrps[] = {
-	[CIFS_GENL_MCGRP_SWN] = { .name = CIFS_GENL_MCGRP_SWN_NAME },
+	[CIFS_GENL_MCGRP_SWN] = {
+		.name = CIFS_GENL_MCGRP_SWN_NAME,
+		.flags = GENL_MCAST_CAP_NET_ADMIN,
+	},
 };
 
 struct genl_family cifs_genl_family = {
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 0a62720590da..c372ab703965 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1826,6 +1826,12 @@ smb2_ioctl_query_info(const unsigned int xid,
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 		if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
+		if (qi.input_buffer_length > 0 &&
+		    struct_size(qi_rsp, Buffer, qi.input_buffer_length) >
+		    rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
 				 sizeof(qi.input_buffer_length))) {
@@ -4954,13 +4960,13 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
 		iov.iov_base = buf + data_offset;
 		iov.iov_len = data_len;
-		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
+		iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, data_len);
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index ffae3a7f46ce..f1e981328bc8 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -291,7 +291,8 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 }
 
 static int generate_key(struct cifs_ses *ses, struct kvec label,
-			struct kvec context, __u8 *key, unsigned int key_size)
+			struct kvec context, __u8 *key, unsigned int key_size,
+			unsigned int full_key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
@@ -312,7 +313,7 @@ static int generate_key(struct cifs_ses *ses, struct kvec label,
 	}
 
 	rc = crypto_shash_setkey(server->secmech.hmacsha256,
-		ses->auth_key.response, SMB2_NTLMV2_SESSKEY_SIZE);
+		ses->auth_key.response, full_key_size);
 	if (rc) {
 		cifs_server_dbg(VFS, "%s: Could not set with session key\n", __func__);
 		goto smb3signkey_ret;
@@ -393,10 +394,9 @@ static int
 generate_smb3signingkey(struct cifs_ses *ses,
 			const struct derivation_triplet *ptriplet)
 {
-	int rc;
-#ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
+	unsigned int full_key_size = SMB2_NTLMV2_SESSKEY_SIZE;
 	struct TCP_Server_Info *server = ses->server;
-#endif
+	int rc;
 
 	/*
 	 * All channels use the same encryption/decryption keys but
@@ -412,30 +412,46 @@ generate_smb3signingkey(struct cifs_ses *ses,
 		rc = generate_key(ses, ptriplet->signing.label,
 				  ptriplet->signing.context,
 				  cifs_ses_binding_channel(ses)->signkey,
-				  SMB3_SIGN_KEY_SIZE);
+				  SMB3_SIGN_KEY_SIZE,
+				  SMB2_NTLMV2_SESSKEY_SIZE);
 		if (rc)
 			return rc;
 	} else {
 		rc = generate_key(ses, ptriplet->signing.label,
 				  ptriplet->signing.context,
 				  ses->smb3signingkey,
-				  SMB3_SIGN_KEY_SIZE);
+				  SMB3_SIGN_KEY_SIZE,
+				  SMB2_NTLMV2_SESSKEY_SIZE);
 		if (rc)
 			return rc;
 
+		/*
+		 * Per MS-SMB2 3.2.5.3.1, signing key always uses Session.SessionKey
+		 * (first 16 bytes). Encryption/decryption keys use
+		 * Session.FullSessionKey when dialect is 3.1.1 and cipher is
+		 * AES-256-CCM or AES-256-GCM, otherwise Session.SessionKey.
+		 */
+
+		if (server->dialect == SMB311_PROT_ID &&
+		    (server->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+		     server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+			full_key_size = ses->auth_key.len;
+
 		memcpy(ses->chans[0].signkey, ses->smb3signingkey,
 		       SMB3_SIGN_KEY_SIZE);
 
 		rc = generate_key(ses, ptriplet->encryption.label,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
+				  SMB3_ENC_DEC_KEY_SIZE,
+				  full_key_size);
 		if (rc)
 			return rc;
 		rc = generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
+				  SMB3_ENC_DEC_KEY_SIZE,
+				  full_key_size);
 		if (rc)
 			return rc;
 	}
@@ -450,7 +466,7 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			&ses->Suid);
 	cifs_dbg(VFS, "Cipher type   %d\n", server->cipher_type);
 	cifs_dbg(VFS, "Session Key   %*ph\n",
-		 SMB2_NTLMV2_SESSKEY_SIZE, ses->auth_key.response);
+		 (int)ses->auth_key.len, ses->auth_key.response);
 	cifs_dbg(VFS, "Signing Key   %*ph\n",
 		 SMB3_SIGN_KEY_SIZE, ses->smb3signingkey);
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 48bd879349fb..c9bda34fd2f5 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1084,8 +1084,10 @@ static int smbd_negotiate(struct smbd_connection *info)
 	log_rdma_event(INFO, "smbd_post_recv rc=%d iov.addr=%llx iov.length=%x iov.lkey=%x\n",
 		       rc, response->sge.addr,
 		       response->sge.length, response->sge.lkey);
-	if (rc)
+	if (rc) {
+		put_receive_buffer(info, response);
 		return rc;
+	}
 
 	init_completion(&info->negotiate_completion);
 	info->negotiate_done = false;
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c5c1e743359d..65a225a9c6cf 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -349,7 +349,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
 		};
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, &hiov, 1, 4);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, &hiov, 1, 4);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			goto unmask;
@@ -370,7 +370,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			size += iov[i].iov_len;
 		}
 
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, iov, n_vec, size);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, iov, n_vec, size);
 
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
@@ -386,7 +386,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
 					     &bvec.bv_offset);
 
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
+			iov_iter_bvec(&smb_msg.msg_iter, ITER_SOURCE,
 				      &bvec, 1, bvec.bv_len);
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index b4be6c524815..87773583b7da 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -140,6 +140,7 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 
 	if (rq->inplace_io) {
 		if (rq->partial_decoding || !support_0padding ||
+		    nrpages_out < nrpages_in ||
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index eee9b0b31b63..ac140587505b 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -37,20 +37,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		nameoff = le16_to_cpu(de->nameoff);
 		de_name = (char *)dentry_blk + nameoff;
 
-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
 			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);
 
-		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		/* a corrupted entry is found (including negative namelen) */
+		if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;
 
 		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
@@ -62,6 +60,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 	}
 	*ofs = maxsize;
 	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int erofs_readdir(struct file *f, struct dir_context *ctx)
@@ -95,8 +97,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		nameoff = le16_to_cpu(de->nameoff);
 
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
+		if (!nameoff || nameoff >= PAGE_SIZE ||
+		    (nameoff % sizeof(struct erofs_dirent))) {
 			erofs_err(dir->i_sb,
 				  "invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, EROFS_I(dir)->nid);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 80b7783c65b4..e6dbb2dfb331 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1736,6 +1736,13 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	err = ext4_ext_get_access(handle, inode, path + k);
 	if (err)
 		return err;
+	if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {
+		EXT4_ERROR_INODE(inode,
+				 "path[%d].p_idx %p > EXT_LAST_INDEX %p",
+				 k, path[k].p_idx,
+				 EXT_LAST_INDEX(path[k].p_hdr));
+		return -EFSCORRUPTED;
+	}
 	path[k].p_idx->ei_block = border;
 	err = ext4_ext_dirty(handle, inode, path + k);
 	if (err)
@@ -1748,6 +1755,14 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
 			break;
+		if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {
+			EXT4_ERROR_INODE(inode,
+					 "path[%d].p_idx %p > EXT_LAST_INDEX %p",
+					 k, path[k].p_idx,
+					 EXT_LAST_INDEX(path[k].p_hdr));
+			err = -EFSCORRUPTED;
+			break;
+		}
 		path[k].p_idx->ei_block = border;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6fe3f3aa101e..9d1d0c9d924c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -339,6 +339,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
 					page->index != nid_of_node(page));
+		if (f2fs_in_warm_node_list(sbi, page))
+			f2fs_del_fsync_node_entry(sbi, page);
 
 		dec_page_count(sbi, type);
 
@@ -350,8 +352,6 @@ static void f2fs_write_end_io(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		if (f2fs_in_warm_node_list(sbi, page))
-			f2fs_del_fsync_node_entry(sbi, page);
 		clear_page_private_gcing(page);
 		end_page_writeback(page);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31968257ad8e..439b80be611d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1798,6 +1798,9 @@ struct f2fs_sb_info {
 	spinlock_t iostat_lat_lock;
 	struct iostat_lat_info *iostat_io_lat;
 #endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key cp_global_sem_key;
+#endif
 };
 
 struct f2fs_private_dio {
@@ -3467,7 +3470,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 03d31ee7eb61..d0efb4a02ea9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -771,7 +771,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 int f2fs_inline_data_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
 {
-	__u64 byteaddr, ilen;
+	__u64 byteaddr = 0, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
@@ -804,9 +804,14 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	if (err)
 		goto out;
 
-	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
-	byteaddr += (char *)inline_data_addr(inode, ipage) -
-					(char *)F2FS_INODE(ipage);
+	if (__is_valid_data_blkaddr(ni.blk_addr)) {
+		byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+		byteaddr += (char *)inline_data_addr(inode, ipage) -
+						(char *)F2FS_INODE(ipage);
+	} else {
+		f2fs_bug_on(F2FS_I_SB(inode), ni.blk_addr != NEW_ADDR);
+		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
+	}
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b284a28afed..52d5915cee96 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1741,7 +1741,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 }
 
 /* This comes from f2fs_put_super */
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1755,7 +1755,7 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
 
-	f2fs_bug_on(sbi, atomic_read(&dcc->discard_cmd_cnt));
+	f2fs_bug_on(sbi, need_check && atomic_read(&dcc->discard_cmd_cnt));
 	return dropped;
 }
 
@@ -2197,7 +2197,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	 * fill_super(), it needs to give a chance to handle them.
 	 */
 	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
-		f2fs_issue_discard_timeout(sbi);
+		f2fs_issue_discard_timeout(sbi, true);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 08fe8fa95924..757f0bd843dd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1600,7 +1600,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	dropped = f2fs_issue_discard_timeout(sbi);
+	dropped = f2fs_issue_discard_timeout(sbi, true);
 
 	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
 					!sbi->discard_blks && !dropped) {
@@ -1667,6 +1667,9 @@ static void f2fs_put_super(struct super_block *sb)
 		kvfree(sbi->write_io[i]);
 #ifdef CONFIG_UNICODE
 	utf8_unload(sb->s_encoding);
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&sbi->cp_global_sem_key);
 #endif
 	kfree(sbi);
 }
@@ -2409,8 +2412,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		} else {
 			dcc = SM_I(sbi)->dcc_info;
 			f2fs_stop_discard_thread(sbi);
+			/*
+			 * f2fs_ioc_fitrim() won't race w/ "remount ro"
+			 * so it's safe to check discard_cmd_cnt in
+			 * f2fs_issue_discard_timeout().
+			 */
 			if (atomic_read(&dcc->discard_cmd_cnt))
-				f2fs_issue_discard_timeout(sbi);
+				f2fs_issue_discard_timeout(sbi, *flags & SB_RDONLY);
 			need_restart_discard = true;
 		}
 	}
@@ -4118,6 +4126,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	init_rwsem(&sbi->gc_lock);
 	mutex_init(&sbi->writepages);
 	init_rwsem(&sbi->cp_global_sem);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&sbi->cp_global_sem_key);
+	lockdep_set_class(&sbi->cp_global_sem,
+					&sbi->cp_global_sem_key);
+#endif
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
 
@@ -4519,6 +4532,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
 	kfree(sbi);
 
 	/* give only one another chance */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index d8ff5a48be5e..14ab4660d024 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -801,11 +801,11 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
@@ -842,11 +842,11 @@ int send_sigurg(struct fown_struct *fown)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 86416f7b8b55..231b1c14b767 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1599,6 +1599,10 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (!S_ISREG(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	index = outarg.offset >> PAGE_SHIFT;
@@ -1770,7 +1774,10 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (!S_ISREG(inode->i_mode))
+			err = -EINVAL;
+		else
+			err = fuse_retrieve(fm, inode, &outarg);
 		iput(inode);
 	}
 	up_read(&fc->killsb);
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 2f26b5c8e955..34d07727a3b7 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -264,7 +264,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		ap.args.in_pages = true;
 
 		err = -EFAULT;
-		iov_iter_init(&ii, WRITE, in_iov, in_iovs, in_size);
+		iov_iter_init(&ii, ITER_SOURCE, in_iov, in_iovs, in_size);
 		for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 			c = copy_page_from_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 			if (c != PAGE_SIZE && iov_iter_count(&ii))
@@ -331,7 +331,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		goto out;
 
 	err = -EFAULT;
-	iov_iter_init(&ii, READ, out_iov, out_iovs, transferred);
+	iov_iter_init(&ii, ITER_DEST, out_iov, out_iovs, transferred);
 	for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 		c = copy_page_to_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 		if (c != PAGE_SIZE && iov_iter_count(&ii))
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 26ebac4c6042..41f4f56f90fa 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -287,3 +287,54 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 	fd->bnode = bnode;
 	return res;
 }
+
+/**
+ * hfsplus_brec_read_cat - read and validate a catalog record
+ * @fd: find data structure
+ * @entry: pointer to catalog entry to read into
+ *
+ * Reads a catalog record and validates its size matches the expected
+ * size based on the record type.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
+{
+	int res;
+	u32 expected_size;
+
+	res = hfs_brec_read(fd, entry, sizeof(hfsplus_cat_entry));
+	if (res)
+		return res;
+
+	/* Validate catalog record size based on type */
+	switch (be16_to_cpu(entry->type)) {
+	case HFSPLUS_FOLDER:
+		expected_size = sizeof(struct hfsplus_cat_folder);
+		break;
+	case HFSPLUS_FILE:
+		expected_size = sizeof(struct hfsplus_cat_file);
+		break;
+	case HFSPLUS_FOLDER_THREAD:
+	case HFSPLUS_FILE_THREAD:
+		/* Ensure we have at least the fixed fields before reading nodeName.length */
+		if (fd->entrylength < HFSPLUS_MIN_THREAD_SZ) {
+			pr_err("thread record too short (got %u)\n", fd->entrylength);
+			return -EIO;
+		}
+		expected_size = hfsplus_cat_thread_size(&entry->thread);
+		break;
+	default:
+		pr_err("unknown catalog record type %d\n",
+		       be16_to_cpu(entry->type));
+		return -EIO;
+	}
+
+	if (fd->entrylength != expected_size) {
+		pr_err("catalog record size mismatch (type %d, got %u, expected %u)\n",
+		       be16_to_cpu(entry->type), fd->entrylength, expected_size);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cba750e..136aa1017af2 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -194,12 +194,12 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd)
 {
-	hfsplus_cat_entry tmp;
+	hfsplus_cat_entry tmp = {0};
 	int err;
 	u16 type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
-	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
+	err = hfsplus_brec_read_cat(fd, &tmp);
 	if (err)
 		return err;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 17e651bd04ad..578da2528bee 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -49,7 +49,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	if (unlikely(err < 0))
 		goto fail;
 again:
-	err = hfs_brec_read(&fd, &entry, sizeof(entry));
+	err = hfsplus_brec_read_cat(&fd, &entry);
 	if (err) {
 		if (err == -ENOENT) {
 			hfs_find_exit(&fd);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 610ba01f19c3..22d890072dd9 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -533,6 +533,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
+static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
+{
+	return offsetof(struct hfsplus_cat_thread, nodeName) +
+	       offsetof(struct hfsplus_unistr, unicode) +
+	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
+}
+
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
+
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
  *
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 8d2155ef7e81..9646cde02010 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -539,9 +539,11 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto out_put_root;
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
-	if (unlikely(err < 0))
+	if (unlikely(err < 0)) {
+		hfs_find_exit(&fd);
 		goto out_put_root;
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
+	}
+	if (!hfsplus_brec_read_cat(&fd, &entry)) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
diff --git a/fs/hpfs/alloc.c b/fs/hpfs/alloc.c
index 66617b1557c6..f5150372618e 100644
--- a/fs/hpfs/alloc.c
+++ b/fs/hpfs/alloc.c
@@ -372,8 +372,8 @@ int hpfs_check_free_dnodes(struct super_block *s, int n)
 				return 0;
 			}
 		}
+		hpfs_brelse4(&qbh);
 	}
-	hpfs_brelse4(&qbh);
 	i = 0;
 	if (hpfs_sb(s)->sb_c_bitmap != -1) {
 		bmp = hpfs_map_bitmap(s, b, &qbh, "chkdn1");
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 8fc7a1fffd55..1947edb0cd28 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -13,6 +13,7 @@
 #include <linux/xattr.h>
 #include <crypto/hash.h>
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
@@ -281,7 +282,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto out;
 	}
 
-	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
+	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
+			  CIFS_HMAC_MD5_HASH_SIZE))
 		rc = -EINVAL;
 out:
 	if (ctx)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9fef4d88ee8b..d029227f2ba6 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4,6 +4,7 @@
  *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
  */
 
+#include <crypto/algapi.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
@@ -8440,7 +8441,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 				signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
@@ -8528,7 +8529,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ecf9db3d69c3..5e21424aa97a 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1265,10 +1265,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, access_req) > aces_size)
+			if (aces_size < offsetof(struct smb_ace, sid) +
+			    CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
-			if (ace_size > aces_size)
+			if (ace_size > aces_size ||
+			    ace_size < offsetof(struct smb_ace, sid) +
+				       CIFS_SID_BASE_SIZE)
 				break;
 			aces_size -= ace_size;
 			granted |= le32_to_cpu(ace->access_req);
@@ -1286,13 +1289,19 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
-		if (ace_size > aces_size)
+		if (ace_size > aces_size ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			       CIFS_SID_BASE_SIZE)
 			break;
 		aces_size -= ace_size;
 
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+			break;
+
 		if (!compare_sids(&sid, &ace->sid) ||
 		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
 			found = 1;
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 7ef201b7ddb5..28dc86dfb030 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -191,6 +191,8 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	t = alloc_transport(client_sk);
 	if (!t) {
 		sock_release(client_sk);
+		if (server_conf.max_connections)
+			atomic_dec(&active_num_conn);
 		return -ENOMEM;
 	}
 
@@ -246,7 +248,7 @@ static int ksmbd_kthread_fn(void *p)
 		}
 
 		if (server_conf.max_connections &&
-		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
+		    atomic_inc_return(&active_num_conn) > server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
 					    atomic_read(&active_num_conn));
 			atomic_dec(&active_num_conn);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 46a7fd731ba0..e02c5650e2ac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5439,9 +5439,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		int len = xdr->buf->len - post_err_offset;
 
 		so->so_replay.rp_status = op->status;
-		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, post_err_offset,
+		if (len <= NFSD4_REPLAY_ISIZE) {
+			so->so_replay.rp_buflen = len;
+			read_bytes_from_xdr_buf(xdr->buf,
+						post_err_offset,
 						so->so_replay.rp_buf, len);
+		} else {
+			so->so_replay.rp_buflen = 0;
+		}
 	}
 status:
 	*p = op->status;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ba2eaf3744ef..cc0dea883fbd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1460,17 +1460,24 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_program;
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 
 	return 0;
 
+out_proc_error:
+	nfsd_stat_counters_destroy(nn);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 477828dbfc66..53298bdcfb3d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -430,11 +430,18 @@ struct nfs4_client_reclaim {
 	struct xdr_netobj	cr_princhash;
 };
 
-/* A reasonable value for REPLAY_ISIZE was estimated as follows:  
- * The OPEN response, typically the largest, requires 
- *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +  8(verifier) + 
- *   4(deleg. type) + 8(deleg. stateid) + 4(deleg. recall flag) + 
- *   20(deleg. space limit) + ~32(deleg. ace) = 112 bytes 
+/*
+ * REPLAY_ISIZE is sized for an OPEN response with delegation:
+ *   4(status) + 8(stateid) + 20(changeinfo) + 4(rflags) +
+ *   8(verifier) + 4(deleg. type) + 8(deleg. stateid) +
+ *   4(deleg. recall flag) + 20(deleg. space limit) +
+ *   ~32(deleg. ace) = 112 bytes
+ *
+ * Some responses can exceed this. A LOCK denial includes the conflicting
+ * lock owner, which can be up to 1024 bytes (NFS4_OPAQUE_LIMIT). Responses
+ * larger than REPLAY_ISIZE are not cached in rp_ibuf; only rp_status is
+ * saved. Enlarging this constant increases the size of every
+ * nfs4_stateowner.
  */
 
 #define NFSD4_REPLAY_ISIZE       112 
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 7a58dba0045c..6d1c6067c80e 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -113,11 +113,11 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 14525e854cba..b9329285bc1d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -15,7 +15,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_counters_init(struct nfsd_net *nn);
 void nfsd_stat_counters_destroy(struct nfsd_net *nn);
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4a81e338585c..e1737984e0ca 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1027,7 +1027,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, READ, vec, vlen, *count);
+	iov_iter_kvec(&iter, ITER_DEST, vec, vlen, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
@@ -1117,7 +1117,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4a7753384b0e..5016f0ef75d5 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -140,6 +140,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	memset(Add2Ptr(ea_p, size), 0, add_bytes);
 
+	err = -EINVAL;
 	/* Check all attributes for consistency. */
 	for (off = 0; off < size; off += ea_size) {
 		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63..785cabd71d67 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -900,7 +900,7 @@ static int o2net_recv_tcp_msg(struct socket *sock, void *data, size_t len)
 {
 	struct kvec vec = { .iov_len = len, .iov_base = data, };
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT, };
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, len);
 	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 0cf3dcb76d2f..0c9de88c9fb8 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -53,7 +53,7 @@ static int orangefs_writepage_locked(struct page *page,
 	bv.bv_len = wlen;
 	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
-	iov_iter_bvec(&iter, WRITE, &bv, 1, wlen);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
@@ -111,7 +111,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 		else
 			ow->bv[i].bv_offset = 0;
 	}
-	iov_iter_bvec(&iter, WRITE, ow->bv, ow->npages, ow->len);
+	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
 	WARN_ON(ow->off >= len);
 	if (ow->off + ow->len > len)
@@ -269,7 +269,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 	offset = readahead_pos(rac);
 	i_pages = &rac->mapping->i_pages;
 
-	iov_iter_xarray(&iter, READ, i_pages, offset, readahead_length(rac));
+	iov_iter_xarray(&iter, ITER_DEST, i_pages, offset, readahead_length(rac));
 
 	/* read in the pages. */
 	if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
@@ -302,7 +302,7 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	bv.bv_page = page;
 	bv.bv_len = PAGE_SIZE;
 	bv.bv_offset = 0;
-	iov_iter_bvec(&iter, READ, &bv, 1, PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, PAGE_SIZE);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
 	    PAGE_SIZE, inode->i_size, NULL, NULL, file);
diff --git a/fs/read_write.c b/fs/read_write.c
index b4b15279b66b..da1bb81355a9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -399,7 +399,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, READ, &iov, 1, len);
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -439,7 +439,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = file->f_op->read_iter(&kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
@@ -502,7 +502,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, WRITE, &iov, 1, len);
+	iov_iter_init(&iter, ITER_SOURCE, &iov, 1, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -535,7 +535,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, iov.iov_len);
 	ret = file->f_op->write_iter(&kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
@@ -905,7 +905,7 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		ret = do_iter_read(file, &iter, pos, flags);
 		kfree(iov);
@@ -922,7 +922,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(WRITE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		file_start_write(file);
 		ret = do_iter_write(file, &iter, pos, flags);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index b17ee4c4f618..df7a5eb7573b 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -156,7 +156,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
-	iov_iter_init(&iter, READ, &iov, 1, size);
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, size);
 
 	kiocb.ki_pos = *ppos;
 	ret = seq_read_iter(&kiocb, &iter);
diff --git a/fs/splice.c b/fs/splice.c
index e8591211044a..a43152bb106f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -304,7 +304,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	unsigned int i_head;
 	int ret;
 
-	iov_iter_pipe(&to, READ, pipe, len);
+	iov_iter_pipe(&to, ITER_DEST, pipe, len);
 	i_head = to.head;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
@@ -685,7 +685,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			n++;
 		}
 
-		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
+		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
@@ -1296,9 +1296,9 @@ static int vmsplice_type(struct fd f, int *type)
 	if (!f.file)
 		return -EBADF;
 	if (f.file->f_mode & FMODE_WRITE) {
-		*type = WRITE;
+		*type = ITER_SOURCE;
 	} else if (f.file->f_mode & FMODE_READ) {
-		*type = READ;
+		*type = ITER_DEST;
 	} else {
 		fdput(f);
 		return -EBADF;
@@ -1347,7 +1347,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 
 	if (!iov_iter_count(&iter))
 		error = 0;
-	else if (iov_iter_rw(&iter) == WRITE)
+	else if (type == ITER_SOURCE)
 		error = vmsplice_to_pipe(f.file, &iter, flags);
 	else
 		error = vmsplice_to_user(f.file, &iter, flags);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 69e4f00ce791..f58a48fc0ade 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1658,8 +1658,9 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int new_size;
 
+		new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;
 		new_loc = kcalloc(new_size, sizeof(*new_loc), GFP_KERNEL);
 		if (!new_loc)
 			return ERR_PTR(-ENOMEM);
@@ -1669,6 +1670,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 9c7949ebc159..01422c2078f7 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -942,6 +942,7 @@ struct drm_panel;
 # define DP_EDP_14			    0x03
 # define DP_EDP_14a                         0x04    /* eDP 1.4a */
 # define DP_EDP_14b                         0x05    /* eDP 1.4b */
+# define DP_EDP_15			    0x06    /* eDP 1.5 */
 
 #define DP_EDP_GENERAL_CAP_1		    0x701
 # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 22aa64d07c79..78ef00b94a46 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -22,6 +22,7 @@
 #ifndef __DRM_FOURCC_H__
 #define __DRM_FOURCC_H__
 
+#include <linux/math.h>
 #include <linux/types.h>
 #include <uapi/drm/drm_fourcc.h>
 
@@ -276,7 +277,7 @@ int drm_format_info_plane_width(const struct drm_format_info *info, int width,
 	if (plane == 0)
 		return width;
 
-	return width / info->hsub;
+	return DIV_ROUND_UP(width, info->hsub);
 }
 
 /**
@@ -298,7 +299,7 @@ int drm_format_info_plane_height(const struct drm_format_info *info, int height,
 	if (plane == 0)
 		return height;
 
-	return height / info->vsub;
+	return DIV_ROUND_UP(height, info->vsub);
 }
 
 const struct drm_format_info *__drm_format_info(u32 format);
diff --git a/include/linux/compat.h b/include/linux/compat.h
index d91fb5225dbf..c5441ac9050f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -72,6 +72,10 @@
 	__diag_push();								\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(clang, 23, "-Wunknown-warning-option",			\
+		      "Avoid breaking versions without -Wattribute-alias");	\
+	__diag_ignore(clang, 23, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");	\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3397f6809c86..f0b218c914f1 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -119,3 +119,31 @@
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
 #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_clang(version, severity, s) \
+	__diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore	ignored
+#define __diag_clang_warn	warning
+#define __diag_clang_error	error
+
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
+
+#if CONFIG_CLANG_VERSION >= 110000
+#define __diag_clang_11(s)	__diag(s)
+#else
+#define __diag_clang_11(s)
+#endif
+
+#if CONFIG_CLANG_VERSION >= 230000
+#define __diag_clang_23(s)	__diag(s)
+#else
+#define __diag_clang_23(s)
+#endif
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 5ee9e2aeab63..55fb9c75391a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -327,6 +327,17 @@
 # define __compiletime_warning(msg)
 #endif
 
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-noipa
+ */
+#if __has_attribute(noipa)
+# define __noipa __attribute__((noipa))
+#else
+# define __noipa
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ca9345e2934d..2eda6f701696 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -345,6 +345,10 @@ struct ftrace_likely_data {
 #define __diag_GCC(version, severity, string)
 #endif
 
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
 #define __diag_push()	__diag(push)
 #define __diag_pop()	__diag(pop)
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b79a833524ef..9b3c198b0682 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -213,12 +213,13 @@ struct fb_deferred_io {
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
 	int open_count; /* number of opened files; protected by fb_info lock */
-	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
 	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
+
+struct fb_deferred_io_state;
 #endif
 
 /*
@@ -480,6 +481,7 @@ struct fb_info {
 	unsigned long npagerefs;
 	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 #endif
 
 	const struct fb_ops *fbops;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 671403f208c9..c92c5e2ae24f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1206,8 +1206,8 @@ static inline u32 hid_report_len(struct hid_report *report)
 	return DIV_ROUND_UP(report->size, 8) + (report->id > 0);
 }
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
-		int interrupt);
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt);
 
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
@@ -1248,4 +1248,15 @@ do {									\
 #define hid_dbg_once(hid, fmt, ...)			\
 	dev_dbg_once(&(hid)->dev, fmt, ##__VA_ARGS__)
 
+#define hid_err_ratelimited(hid, fmt, ...)			\
+	dev_err_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice_ratelimited(hid, fmt, ...)			\
+	dev_notice_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_ratelimited(hid, fmt, ...)			\
+	dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info_ratelimited(hid, fmt, ...)			\
+	dev_info_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg_ratelimited(hid, fmt, ...)			\
+	dev_dbg_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
+
 #endif
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 1c16ffb8b908..532a07643e60 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -245,6 +245,7 @@ struct parport {
 
 	unsigned long devflags;
 #define PARPORT_DEVPROC_REGISTERED	0
+#define PARPORT_ANNOUNCED		1
 	struct pardevice *proc_device;	/* Currently register proc device */
 
 	struct list_head full_list;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index ff5062bf9b33..05a1bd8aa6bb 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -740,6 +740,19 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+#if defined(DEBUG)
+#define print_hex_dump_devel(prefix_str, prefix_type, rowsize,		\
+			     groupsize, buf, len, ascii)		\
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
+		       groupsize, buf, len, ascii)
+#else
+static inline void print_hex_dump_devel(const char *prefix_str, int prefix_type,
+					int rowsize, int groupsize,
+					const void *buf, size_t len, bool ascii)
+{
+}
+#endif
+
 /**
  * print_hex_dump_bytes - shorthand form of print_hex_dump_debug() with default
  *                        params
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 5d52d15faee0..740e03619921 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -8,7 +8,6 @@
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			 randomize_kstack_offset);
-DECLARE_PER_CPU(u32, kstack_offset);
 
 /*
  * Do not use this anywhere else in the kernel. This is used here because
@@ -39,28 +38,57 @@ DECLARE_PER_CPU(u32, kstack_offset);
  */
 #define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
 
-/*
- * These macros must be used during syscall entry when interrupts and
- * preempt are disabled, and after user registers have been stored to
- * the stack.
+/**
+ * add_random_kstack_offset - Increase stack utilization by previously
+ *			      chosen random offset
+ *
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. Preemption may be enabled. For testing the resulting
+ * entropy, please see: tools/testing/selftests/lkdtm/stack-entropy.sh
  */
 #define add_random_kstack_offset() do {					\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
 		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
 
+/**
+ * choose_random_kstack_offset - Choose the random offset for the next
+ *				 add_random_kstack_offset()
+ *
+ * This should only be used during syscall exit. Preemption may be enabled. This
+ * position in the syscall flow is done to frustrate attacks from userspace
+ * attempting to learn the next offset:
+ * - Maximize the timing uncertainty visible from userspace: if the
+ *   offset is chosen at syscall entry, userspace has much more control
+ *   over the timing between choosing offsets. "How long will we be in
+ *   kernel mode?" tends to be more difficult to predict than "how long
+ *   will we be in user mode?"
+ * - Reduce the lifetime of the new offset sitting in memory during
+ *   kernel mode execution. Exposure of "thread-local" memory content
+ *   (e.g. current, percpu, etc) tends to be easier than arbitrary
+ *   location memory exposure.
+ */
 #define choose_random_kstack_offset(rand) do {				\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		offset = ror32(offset, 5) ^ (rand);			\
-		raw_cpu_write(kstack_offset, offset);			\
+		current->kstack_offset = offset;			\
 	}								\
 } while (0)
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+static inline void random_kstack_task_init(struct task_struct *tsk)
+{
+	tsk->kstack_offset = 0;
+}
+#else
+#define random_kstack_task_init(tsk)		do { } while (0)
+#endif
+
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 141039b6d905..df4817deee20 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1461,6 +1461,10 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	u32				kstack_offset;
+#endif
+
 #ifdef CONFIG_X86_MCE
 	void __user			*mce_vaddr;
 	__u64				mce_kflags;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b8037a46ff41..ce63109333a5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -239,6 +239,10 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__diag_push();							\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(clang, 23, "-Wunknown-warning-option",		\
+		      "Avoid breaking versions without -Wattribute-alias");\
+	__diag_ignore(clang, 23, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));	\
 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..4d53a6ff8c28 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -27,6 +27,9 @@ enum iter_type {
 	ITER_DISCARD,
 };
 
+#define ITER_SOURCE	1	// == WRITE
+#define ITER_DEST	0	// == READ
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;
diff --git a/include/net/act_api.h b/include/net/act_api.h
index ab67d62ff317..29d5dc201b5c 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -41,6 +41,7 @@ struct tc_action {
 	struct tc_cookie	__rcu *act_cookie;
 	struct tcf_chain	__rcu *goto_chain;
 	u32			tcfa_flags;
+	struct rcu_head         tcfa_rcu;
 	u8			hw_stats;
 	u8			used_hw_stats;
 	bool			used_hw_stats_valid;
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b08b559f5242..a5fe5743ea35 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -291,6 +291,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
 struct bt_sock {
 	struct sock sk;
 	struct list_head accept_q;
+	spinlock_t accept_q_lock; /* protects accept_q */
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
@@ -315,6 +316,8 @@ void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 15b4b2d97f42..6e48bd56f4c3 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -33,6 +33,7 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
+#define L2CAP_SIG_MTU			48	/* BR/EDR signaling MTU */
 #define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
 #define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
 #define L2CAP_DEFAULT_TX_WINDOW		63
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 3cfa33a0aa16..58fdf6de2e5e 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -8,16 +8,19 @@
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+/* Binding to multicast group requires %CAP_NET_ADMIN */
+#define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
+/* Binding to multicast group requires %CAP_SYS_ADMIN */
+#define GENL_MCAST_CAP_SYS_ADMIN	BIT(1)
+
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
- * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
- * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
+ * @flags: GENL_MCAST_* flags
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
-	u8			cap_sys_admin:1;
 };
 
 struct genl_ops;
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 59f8412de45a..41e20b7e8e88 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1396,8 +1396,7 @@ int register_ip_vs_scheduler(struct ip_vs_scheduler *scheduler);
 int unregister_ip_vs_scheduler(struct ip_vs_scheduler *scheduler);
 int ip_vs_bind_scheduler(struct ip_vs_service *svc,
 			 struct ip_vs_scheduler *scheduler);
-void ip_vs_unbind_scheduler(struct ip_vs_service *svc,
-			    struct ip_vs_scheduler *sched);
+void ip_vs_unbind_scheduler(struct ip_vs_service *svc);
 struct ip_vs_scheduler *ip_vs_scheduler_get(const char *sched_name);
 void ip_vs_scheduler_put(struct ip_vs_scheduler *scheduler);
 struct ip_vs_conn *
diff --git a/include/net/mctp.h b/include/net/mctp.h
index 8c225091e46c..b516d7891cae 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -25,6 +25,9 @@ struct mctp_hdr {
 #define MCTP_VER_MIN	1
 #define MCTP_VER_MAX	1
 
+/* Definitions for ver field */
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
+
 /* Definitions for flags_seq_tag field */
 #define MCTP_HDR_FLAG_SOM	BIT(7)
 #define MCTP_HDR_FLAG_EOM	BIT(6)
diff --git a/include/net/sock.h b/include/net/sock.h
index ee9c398dd8f2..962acf4a644d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1868,6 +1868,7 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
 			     gfp_t priority);
 void skb_orphan_partial(struct sk_buff *skb);
 void sock_rfree(struct sk_buff *skb);
+void sock_rmem_free(struct sk_buff *skb);
 void sock_efree(struct sk_buff *skb);
 #ifdef CONFIG_INET
 void sock_edemux(struct sk_buff *skb);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 875f7dc4706e..a042f130f99b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -584,6 +584,7 @@ struct xfrm_mgr {
 					   const struct xfrm_migrate *m,
 					   int num_bundles,
 					   const struct xfrm_kmaddress *k,
+					   struct net *net,
 					   const struct xfrm_encap_tmpl *encap);
 	bool			(*is_alive)(const struct km_event *c);
 };
@@ -1684,7 +1685,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_bundles,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 2381e482fab3..a08c4fac5788 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -70,37 +70,6 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
-
-static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
-						struct ib_umem *umem,
-						unsigned long pgsz)
-{
-	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
-				umem->sgt_append.sgt.nents, pgsz);
-	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
-	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
-}
-
-static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
-{
-	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
-}
-
-/**
- * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
- * @umem: umem to iterate over
- * @pgsz: Page size to split the list into
- *
- * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
- * returned DMA blocks will be aligned to pgsz and span the range:
- * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
- *
- * Performs exactly ib_umem_num_dma_blocks() iterations.
- */
-#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
-	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
-	     __rdma_umem_block_iter_next(biter);)
-
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
@@ -116,7 +85,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -129,6 +98,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  *
  * If the pgoff_bitmask requires either alignment in the low bit or an
  * unavailable page size for the high bits, this function returns 0.
+ *
+ * Returns: best HW page size for the parameters or 0 if none available
+ *   for the given parameters.
  */
 static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 						    unsigned long pgsz_bitmap,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index eada75848eec..8e62e746842a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2808,22 +2808,6 @@ struct ib_client {
 	u8 no_kverbs_req:1;
 };
 
-/*
- * IB block DMA iterator
- *
- * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
- * to a HW supported page size.
- */
-struct ib_block_iter {
-	/* internal states */
-	struct scatterlist *__sg;	/* sg holding the current aligned block */
-	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
-	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
-	unsigned int __sg_nents;	/* number of SG entries */
-	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
-	unsigned int __pg_bit;		/* alignment of current block */
-};
-
 struct ib_device *_ib_alloc_device(size_t size);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
@@ -2845,38 +2829,6 @@ void ib_unregister_device_queued(struct ib_device *ib_dev);
 int ib_register_client   (struct ib_client *client);
 void ib_unregister_client(struct ib_client *client);
 
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist,
-			     unsigned int nents,
-			     unsigned long pgsz);
-bool __rdma_block_iter_next(struct ib_block_iter *biter);
-
-/**
- * rdma_block_iter_dma_address - get the aligned dma address of the current
- * block held by the block iterator.
- * @biter: block iterator holding the memory block
- */
-static inline dma_addr_t
-rdma_block_iter_dma_address(struct ib_block_iter *biter)
-{
-	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
-}
-
-/**
- * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
- * @sglist: sglist to iterate over
- * @biter: block iterator holding the memory block
- * @nents: maximum number of sg entries to iterate over
- * @pgsz: best HW supported page size to use
- *
- * Callers may use rdma_block_iter_dma_address() to get each
- * blocks aligned DMA address.
- */
-#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
-	for (__rdma_block_iter_start(biter, sglist, nents,	\
-				     pgsz);			\
-	     __rdma_block_iter_next(biter);)
-
 /**
  * ib_get_client_data - Get IB client context
  * @device:Device to get context for
diff --git a/include/rdma/iter.h b/include/rdma/iter.h
new file mode 100644
index 000000000000..19d64ef04ba9
--- /dev/null
+++ b/include/rdma/iter.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef _RDMA_ITER_H_
+#define _RDMA_ITER_H_
+
+#include <linux/scatterlist.h>
+#include <rdma/ib_umem.h>
+
+/**
+ * IB block DMA iterator
+ *
+ * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
+ * to a HW supported page size.
+ */
+struct ib_block_iter {
+	/* internal states */
+	struct scatterlist *__sg;	/* sg holding the current aligned block */
+	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
+	unsigned int __sg_nents;	/* number of SG entries */
+	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
+	unsigned int __pg_bit;		/* alignment of current block */
+};
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist,
+			     unsigned int nents,
+			     unsigned long pgsz);
+bool __rdma_block_iter_next(struct ib_block_iter *biter);
+
+/**
+ * rdma_block_iter_dma_address - get the aligned dma address of the current
+ * block held by the block iterator.
+ * @biter: block iterator holding the memory block
+ */
+static inline dma_addr_t
+rdma_block_iter_dma_address(struct ib_block_iter *biter)
+{
+	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
+}
+
+/**
+ * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
+ * @sglist: sglist to iterate over
+ * @biter: block iterator holding the memory block
+ * @nents: maximum number of sg entries to iterate over
+ * @pgsz: best HW supported page size to use
+ *
+ * Callers may use rdma_block_iter_dma_address() to get each
+ * blocks aligned DMA address.
+ */
+#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
+	for (__rdma_block_iter_start(biter, sglist, nents,	\
+				     pgsz);			\
+	     __rdma_block_iter_next(biter);)
+
+static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
+						struct ib_umem *umem,
+						unsigned long pgsz)
+{
+	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
+				umem->sgt_append.sgt.nents, pgsz);
+	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
+	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
+}
+
+static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
+{
+	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
+ * @umem: umem to iterate over
+ * @pgsz: Page size to split the list into
+ *
+ * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
+ * returned DMA blocks will be aligned to pgsz and span the range:
+ * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
+ *
+ * Performs exactly ib_umem_num_dma_blocks() iterations.
+ */
+#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
+	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
+	     __rdma_umem_block_iter_next(biter);)
+
+#endif /* _RDMA_ITER_H_ */
diff --git a/init/main.c b/init/main.c
index 0b6071b26ccb..4e9c76a0e5a4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -882,7 +882,6 @@ static void __init mm_init(void)
 #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
-DEFINE_PER_CPU(u32, kstack_offset);
 
 static int __init early_randomize_kstack_offset(char *buf)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8ecf01f1b689..8747c585a077 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5525,7 +5525,7 @@ static bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
  */
 static inline bool io_poll_get_ownership(struct io_kiocb *req)
 {
-	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
+	if (unlikely((unsigned int)atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
 		return io_poll_get_ownership_slowpath(req);
 	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index d33d6e548c61..f09b25e6dac2 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -402,15 +402,17 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 	 * We want to destroy segments without users and with already
 	 * exit'ed originating process.
 	 *
-	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
+	 * shm_nattch can be changed under shm_perm.lock without holding the
+	 * rwsem, so take the object lock before checking shm_may_destroy().
 	 */
 	if (!list_empty(&shp->shm_clist))
 		return 0;
 
-	if (shm_may_destroy(shp)) {
-		shm_lock_by_ptr(shp);
+	shm_lock_by_ptr(shp);
+	if (shm_may_destroy(shp))
 		shm_destroy(ns, shp);
-	}
+	else
+		shm_unlock(shp);
 	return 0;
 }
 
diff --git a/ipc/util.c b/ipc/util.c
index fa2d86ef3fb8..8e7332172525 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -253,7 +253,7 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-				0, GFP_NOWAIT);
+				ipc_mni, GFP_NOWAIT);
 	}
 	if (idx >= 0)
 		new->id = (new->seq << ipcmni_seq_shift()) + idx;
diff --git a/kernel/fork.c b/kernel/fork.c
index eb772b1e819f..f55be5303dc7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <linux/randomize_kstack.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
@@ -2300,6 +2301,7 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	random_kstack_task_init(p);
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
diff --git a/kernel/pid.c b/kernel/pid.c
index 61f6649568b2..fe2aed73c729 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -637,10 +637,12 @@ static struct file *__pidfd_fget(struct task_struct *task, int fd)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
-		file = fget_task(task, fd);
-	else
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
 		file = ERR_PTR(-EPERM);
+	else if (task->flags & PF_EXITING)
+		file = ERR_PTR(-ESRCH);
+	else
+		file = fget_task(task, fd);
 
 	up_read(&task->signal->exec_update_lock);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c1d219289872..c4e9fac7507a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4491,7 +4491,7 @@ void sched_post_fork(struct task_struct *p)
 	uclamp_post_fork(p);
 }
 
-unsigned long to_ratio(u64 period, u64 runtime)
+u64 to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
 		return BW_UNIT;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c5122e5f258e..22b71e37c97d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2606,7 +2606,7 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 {
 	struct rt_schedulable_data *d = data;
 	struct task_group *child;
-	unsigned long total, sum = 0;
+	u64 total, sum = 0;
 	u64 period, runtime;
 
 	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8eba31190d30..f58040a51e33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2340,7 +2340,7 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define RATIO_SHIFT		8
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
-unsigned long to_ratio(u64 period, u64 runtime);
+u64 to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8fc1da382448..10a315e461d3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1364,6 +1364,7 @@ int zap_other_threads(struct task_struct *p)
 	int count = 0;
 
 	p->signal->group_stop_count = 0;
+	task_clear_jobctl_pending(p, JOBCTL_PENDING_MASK);
 
 	while_each_thread(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index df582f24f0d7..b7f6b9dbf940 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -207,7 +207,7 @@ SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
 		    get_user(new_ts.tv_nsec, &tv->tv_usec))
 			return -EFAULT;
 
-		if (new_ts.tv_nsec > USEC_PER_SEC || new_ts.tv_nsec < 0)
+		if (new_ts.tv_nsec >= USEC_PER_SEC || new_ts.tv_nsec < 0)
 			return -EINVAL;
 
 		new_ts.tv_nsec *= NSEC_PER_USEC;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 47044927a726..f45a31cad6b6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -647,6 +647,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(offset, EVENT_TOO_BIG);
+		goto out;
+	}
+
 	ret = -ENOMEM;
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index b08aa3946868..97003a41b6c1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -33,6 +33,7 @@
 #define MAX_ARRAY_LEN		64
 #define MAX_ARG_NAME_LEN	32
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -455,7 +456,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
 	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
 	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),\
-	C(SAME_PROBE,		"There is already the exact same probe event"),
+	C(SAME_PROBE,		"There is already the exact same probe event"),\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..38e83507e6fd 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -337,6 +337,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->unregfunc && !static_key_enabled(&tp->key))
+			tp->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 0b0449ee21aa..43d28c2aa7bf 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1059,7 +1059,7 @@ struct self_test {
 
 static __initconst const struct debug_obj_descr descr_type_test;
 
-static bool __init is_static_object(void *addr)
+static __noipa bool __init is_static_object(void *addr)
 {
 	struct self_test *obj = addr;
 
diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index 3cb6bd148fa9..b6efe618e614 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -453,7 +453,7 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff) {
+		while (len && !*buff && lzeros < nbytes) {
 			lzeros++;
 			len--;
 			buff++;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6d8036671e60..dbb0f0fb2e59 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -383,10 +383,10 @@ static struct page *damon_get_page(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
 
-	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
+	if (!page || !get_page_unless_zero(page))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
+	if (!PageLRU(page)) {
 		put_page(page);
 		page = NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e9c5de967b2c..934c08de74f4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1994,7 +1994,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
 			page_remove_rmap(page, true);
+			add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 			put_page(page);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64dfa3fcd554..8b4bc38e1c0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6493,6 +6493,7 @@ void __init hugetlb_cma_reserve(int order)
 	 * let's allocate 1 GB on first three nodes and ignore the last one.
 	 */
 	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
+	per_node = round_up(per_node, PAGE_SIZE << order);
 	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
 		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 5dd5706270b0..ef9382f77624 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1251,7 +1251,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto out;
 	}
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret < 0)
 		goto out;
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 66c6fbb07bc4..1f992e93301b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -252,7 +252,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		};
 		struct iov_iter from;
 
-		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
+		iov_iter_bvec(&from, ITER_SOURCE, &bv, 1, PAGE_SIZE);
 		init_sync_kiocb(&kiocb, swap_file);
 		kiocb.ki_pos = page_file_offset(page);
 
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 4bcc11958089..78dfaf9e8990 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -263,7 +263,7 @@ static ssize_t process_vm_rw(pid_t pid,
 	struct iovec *iov_r;
 	struct iov_iter iter;
 	ssize_t rc;
-	int dir = vm_write ? WRITE : READ;
+	int dir = vm_write ? ITER_SOURCE : ITER_DEST;
 
 	if (flags != 0)
 		return -EINVAL;
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 52fad5dad9f7..d762c49e722f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
 					      const struct lowpan_iphc_ctx *ctx,
 					      const struct in6_addr *ipaddr)
 {
-	u8 data[6];
+	u8 data[6] = {};
 
 	/* flags/scope, reserved (RIID) */
 	memcpy(data, &ipaddr->s6_addr[1], 2);
 	/* group ID */
-	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
 	lowpan_push_hc_data(hc_ptr, data, 6);
 
 	return LOWPAN_IPHC_DAM_00;
diff --git a/net/802/garp.c b/net/802/garp.c
index f6012f8e59f0..2c456b362621 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -452,7 +452,7 @@ static int garp_pdu_parse_attr(struct garp_applicant *app, struct sk_buff *skb,
 	if (!pskb_may_pull(skb, ga->len))
 		return -1;
 	skb_pull(skb, ga->len);
-	dlen = sizeof(*ga) - ga->len;
+	dlen = ga->len - sizeof(*ga);
 
 	if (attrtype > app->app->maxattr)
 		return 0;
diff --git a/net/802/mrp.c b/net/802/mrp.c
index c10a432a5b43..017839c14184 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -702,6 +702,12 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 	valen = be16_to_cpu(get_unaligned(&mrp_cb(skb)->vah->lenflags) &
 			    MRP_VECATTR_HDR_LEN_MASK);
 
+	/* If valen is 0, only a LeaveAllEvent is present; FirstValue and
+	 * Vector fields are absent per IEEE 802.1ak.
+	 */
+	if (valen == 0)
+		return 0;
+
 	/* The VectorAttribute structure in a PDU carries event information
 	 * about one or more attributes having consecutive values. Only the
 	 * value for the first attribute is contained in the structure. So
@@ -752,6 +758,9 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 		vaevents %= __MRP_VECATTR_EVENT_MAX;
 		vaevent = vaevents;
 		mrp_pdu_parse_vecattr_event(app, skb, vaevent);
+		valen--;
+		mrp_attrvalue_inc(mrp_cb(skb)->attrvalue,
+				  mrp_cb(skb)->mh->attrlen);
 	}
 	return 0;
 }
diff --git a/net/9p/client.c b/net/9p/client.c
index 5f0b3fdc70e2..5cd26bdaf33d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2096,7 +2096,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	struct kvec kv = {.iov_base = data, .iov_len = count};
 	struct iov_iter to;
 
-	iov_iter_kvec(&to, READ, &kv, 1, count);
+	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
 	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
 		 fid->fid, offset, count);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 58c18e22603d..669f77eed073 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -224,6 +224,8 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	hard_iface->bat_iv.ogm_buff = NULL;
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
+
+	cancel_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
@@ -528,8 +530,10 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
  * @if_incoming: interface where the packet was received
  * @if_outgoing: interface for which the retransmission should be considered
  * @own_packet: true if it is a self-generated ogm
+ *
+ * Return: whether forward packet was scheduled
  */
-static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
+static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
@@ -553,13 +557,13 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	skb = netdev_alloc_skb_ip_align(NULL, skb_size);
 	if (!skb)
-		return;
+		return false;
 
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
 	if (!forw_packet_aggr) {
 		kfree_skb(skb);
-		return;
+		return false;
 	}
 
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
@@ -581,6 +585,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 			  batadv_iv_send_outstanding_bat_ogm_packet);
 
 	batadv_forw_packet_ogmv1_queue(bat_priv, forw_packet_aggr, send_time);
+
+	return true;
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -610,8 +616,10 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
  * @if_outgoing: interface for which the retransmission should be considered
  * @own_packet: true if it is a self-generated ogm
  * @send_time: timestamp (jiffies) when the packet is to be sent
+ *
+ * Return: whether forward packet was scheduled
  */
-static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
+static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    unsigned char *packet_buff,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
@@ -663,14 +671,16 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
 			send_time += max_aggregation_jiffies;
 
-		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
-					    send_time, direct_link,
-					    if_incoming, if_outgoing,
-					    own_packet);
+		return batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
+						   send_time, direct_link,
+						   if_incoming, if_outgoing,
+						   own_packet);
 	} else {
 		batadv_iv_ogm_aggregate(forw_packet_aggr, packet_buff,
 					packet_len, direct_link);
 		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
+		return true;
 	}
 }
 
@@ -782,6 +792,9 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
+	bool reschedule = false;
+	bool scheduled;
+	int ret;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -805,9 +818,15 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * appended as it may alter the tt tvlv container
 		 */
 		batadv_tt_local_commit_changes(bat_priv);
-		tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-							    ogm_buff_len,
-							    BATADV_OGM_HLEN);
+		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+						       ogm_buff_len,
+						       BATADV_OGM_HLEN);
+		if (ret < 0) {
+			reschedule = true;
+			goto out;
+		}
+
+		tvlv_len = ret;
 	}
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
@@ -826,8 +845,11 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		/* OGMs from secondary interfaces are only scheduled on their
 		 * respective interfaces.
 		 */
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
-					hard_iface, hard_iface, 1, send_time);
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+						    hard_iface, hard_iface, 1, send_time);
+		if (!scheduled)
+			reschedule = true;
+
 		goto out;
 	}
 
@@ -842,15 +864,28 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
 			continue;
 
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
-					*ogm_buff_len, hard_iface,
-					tmp_hard_iface, 1, send_time);
-
+		scheduled = batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
+						    *ogm_buff_len, hard_iface,
+						    tmp_hard_iface, 1, send_time);
 		batadv_hardif_put(tmp_hard_iface);
+
+		if (!scheduled && tmp_hard_iface == hard_iface)
+			reschedule = true;
 	}
 	rcu_read_unlock();
 
 out:
+	if (reschedule) {
+		/* there was a failure scheduling the own forward packet.
+		 * as result, the batadv_iv_send_outstanding_bat_ogm_packet()
+		 * work item is no longer scheduled. it is therefore necessary
+		 * to reschedule it manually
+		 */
+		queue_delayed_work(batadv_event_workqueue,
+				   &hard_iface->bat_iv.reschedule_work,
+				   msecs_to_jiffies(atomic_read(&bat_priv->orig_interval)));
+	}
+
 	batadv_hardif_put(primary_if);
 }
 
@@ -865,6 +900,17 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
 
+static void batadv_iv_ogm_reschedule(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = container_of(delayed_work,
+				  struct batadv_hard_iface,
+				  bat_iv.reschedule_work);
+	batadv_iv_ogm_schedule(hard_iface);
+}
+
 /**
  * batadv_iv_orig_ifinfo_sum() - Get bcast_own sum for originator over interface
  * @orig_node: originator which reproadcasted the OGMs directly
@@ -2268,6 +2314,8 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 {
+	INIT_DELAYED_WORK(&hard_iface->bat_iv.reschedule_work, batadv_iv_ogm_reschedule);
+
 	/* begin scheduling originator messages on that interface */
 	batadv_iv_ogm_schedule(hard_iface);
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c357cf72396e..63337e02cf2f 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -116,14 +116,14 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_send_to_if() - send a batman ogm using a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to send
  * @hard_iface: the interface to use to send the OGM
  */
-static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
+static void batadv_v_ogm_send_to_if(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
 		return;
@@ -190,6 +190,7 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_aggr_send() - flush & send aggregation queue
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the interface with the aggregation queue to flush
  *
  * Aggregates all OGMv2 packets currently in the aggregation queue into a
@@ -199,7 +200,8 @@ static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_iface)
  *
  * Caller needs to hold the hard_iface->bat_v.aggr_list.lock.
  */
-static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
+static void batadv_v_ogm_aggr_send(struct batadv_priv *bat_priv,
+				   struct batadv_hard_iface *hard_iface)
 {
 	unsigned int aggr_len = hard_iface->bat_v.aggr_len;
 	struct sk_buff *skb_aggr;
@@ -229,27 +231,32 @@ static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 		consume_skb(skb);
 	}
 
-	batadv_v_ogm_send_to_if(skb_aggr, hard_iface);
+	batadv_v_ogm_send_to_if(bat_priv, skb_aggr, hard_iface);
 }
 
 /**
  * batadv_v_ogm_queue_on_if() - queue a batman ogm on a given interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the OGM to queue
  * @hard_iface: the interface to queue the OGM on
  */
-static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
+static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	if (hard_iface->soft_iface != bat_priv->soft_iface) {
+		kfree_skb(skb);
+		return;
+	}
 
 	if (!atomic_read(&bat_priv->aggregated_ogms)) {
-		batadv_v_ogm_send_to_if(skb, hard_iface);
+		batadv_v_ogm_send_to_if(bat_priv, skb, hard_iface);
 		return;
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
-		batadv_v_ogm_aggr_send(hard_iface);
+		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
@@ -265,9 +272,9 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char *ogm_buff;
-	int ogm_buff_len;
-	u16 tvlv_len = 0;
+	unsigned char **ogm_buff;
+	int *ogm_buff_len;
+	u16 tvlv_len;
 	int ret;
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
@@ -275,25 +282,27 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
-	ogm_buff = bat_priv->bat_v.ogm_buff;
-	ogm_buff_len = bat_priv->bat_v.ogm_buff_len;
+	ogm_buff = &bat_priv->bat_v.ogm_buff;
+	ogm_buff_len = &bat_priv->bat_v.ogm_buff_len;
+
 	/* tt changes have to be committed before the tvlv data is
 	 * appended as it may alter the tt tvlv container
 	 */
 	batadv_tt_local_commit_changes(bat_priv);
-	tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, &ogm_buff,
-						    &ogm_buff_len,
-						    BATADV_OGM2_HLEN);
+	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+					       ogm_buff_len,
+					       BATADV_OGM2_HLEN);
+	if (ret < 0)
+		goto reschedule;
 
-	bat_priv->bat_v.ogm_buff = ogm_buff;
-	bat_priv->bat_v.ogm_buff_len = ogm_buff_len;
+	tvlv_len = ret;
 
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff_len);
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + *ogm_buff_len);
 	if (!skb)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_put_data(skb, ogm_buff, ogm_buff_len);
+	skb_put_data(skb, *ogm_buff, *ogm_buff_len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
@@ -348,7 +357,7 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 			break;
 		}
 
-		batadv_v_ogm_queue_on_if(skb_tmp, hard_iface);
+		batadv_v_ogm_queue_on_if(bat_priv, skb_tmp, hard_iface);
 		batadv_hardif_put(hard_iface);
 	}
 	rcu_read_unlock();
@@ -388,12 +397,14 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
 {
 	struct batadv_hard_iface_bat_v *batv;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 
 	batv = container_of(work, struct batadv_hard_iface_bat_v, aggr_wq.work);
 	hard_iface = container_of(batv, struct batadv_hard_iface, bat_v);
+	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
-	batadv_v_ogm_aggr_send(hard_iface);
+	batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -583,7 +594,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 		   if_outgoing->net_dev->name, ntohl(ogm_forward->throughput),
 		   ogm_forward->ttl, if_incoming->net_dev->name);
 
-	batadv_v_ogm_queue_on_if(skb, if_outgoing);
+	batadv_v_ogm_queue_on_if(bat_priv, skb, if_outgoing);
 
 out:
 	batadv_orig_ifinfo_put(orig_ifinfo);
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f768a4e0bc0f..452e78fd70c0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -355,12 +355,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	soft_iface = primary_if->soft_iface;
+	soft_iface = READ_ONCE(primary_if->soft_iface);
+	if (!soft_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->soft_iface,
+			 soft_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
@@ -513,8 +515,8 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
-	atomic_set(&entry->request_sent, 0);
-	atomic_set(&entry->wait_periods, 0);
+	entry->state = BATADV_BLA_BACKBONE_GW_SYNCED;
+	entry->wait_periods = 0;
 	ether_addr_copy(entry->orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
 	kref_init(&entry->refcount);
@@ -543,9 +545,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 		batadv_bla_send_announce(bat_priv, entry);
 
 		/* this will be decreased in the worker thread */
-		atomic_inc(&entry->request_sent);
-		atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
-		atomic_inc(&bat_priv->bla.num_requests);
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (entry->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+			entry->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
+			entry->wait_periods = BATADV_BLA_WAIT_PERIODS;
+			atomic_inc(&bat_priv->bla.num_requests);
+		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	return entry;
@@ -648,10 +654,12 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
-	if (!atomic_read(&backbone_gw->request_sent)) {
+	spin_lock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
+	if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_SYNCED) {
+		backbone_gw->state = BATADV_BLA_BACKBONE_GW_UNSYNCED;
 		atomic_inc(&backbone_gw->bat_priv->bla.num_requests);
-		atomic_set(&backbone_gw->request_sent, 1);
 	}
+	spin_unlock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
 }
 
 /**
@@ -872,10 +880,12 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		/* if we have sent a request and the crc was OK,
 		 * we can allow traffic again.
 		 */
-		if (atomic_read(&backbone_gw->request_sent)) {
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED) {
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
 		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	batadv_backbone_gw_put(backbone_gw);
@@ -1254,9 +1264,13 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				purged = true;
 
 				/* don't wait for the pending request anymore */
-				if (atomic_read(&backbone_gw->request_sent))
+				spin_lock_bh(&bat_priv->bla.num_requests_lock);
+				if (backbone_gw->state == BATADV_BLA_BACKBONE_GW_UNSYNCED)
 					atomic_dec(&bat_priv->bla.num_requests);
 
+				backbone_gw->state = BATADV_BLA_BACKBONE_GW_STOPPED;
+				spin_unlock_bh(&bat_priv->bla.num_requests_lock);
+
 				batadv_bla_del_backbone_claims(backbone_gw);
 
 				hlist_del_rcu(&backbone_gw->hash_entry);
@@ -1507,7 +1521,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 				batadv_bla_send_loopdetect(bat_priv,
 							   backbone_gw);
 
-			/* request_sent is only set after creation to avoid
+			/* state is only set to unsynced after creation to avoid
 			 * problems when we are not yet known as backbone gw
 			 * in the backbone.
 			 *
@@ -1516,14 +1530,21 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			 * some grace time.
 			 */
 
-			if (atomic_read(&backbone_gw->request_sent) == 0)
-				continue;
+			spin_lock_bh(&bat_priv->bla.num_requests_lock);
+			if (backbone_gw->state != BATADV_BLA_BACKBONE_GW_UNSYNCED)
+				goto unlock_next;
 
-			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
-				continue;
+			if (backbone_gw->wait_periods > 0)
+				backbone_gw->wait_periods--;
+
+			if (backbone_gw->wait_periods > 0)
+				goto unlock_next;
 
+			backbone_gw->state = BATADV_BLA_BACKBONE_GW_SYNCED;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
+
+unlock_next:
+			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5207cd8d6ad8..04a4638034d2 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -262,6 +262,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
+	batadv_tp_stop_all(bat_priv);
 
 	batadv_gw_node_free(bat_priv);
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index bff86ccadc2c..b46480ec7bd1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -785,6 +785,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+	spin_lock_init(&bat_priv->bla.num_requests_lock);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 464fca0ca8ac..c7b48d51e2ae 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -8,10 +8,12 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -253,6 +255,7 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
  * batadv_tp_list_find() - find a tp_vars object in the global list
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the other endpoint MAC address to look for
+ * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point and return it after
  * having increment the refcounter. Return NULL is not found
@@ -260,7 +263,8 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
  * Return: matching tp_vars or NULL when no tp_vars with @dst was found
  */
 static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
-						  const u8 *dst)
+						  const u8 *dst,
+						  enum batadv_tp_meter_role role)
 {
 	struct batadv_tp_vars *pos, *tp_vars = NULL;
 
@@ -269,6 +273,9 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(pos->other_end, dst))
 			continue;
 
+		if (pos->role != role)
+			continue;
+
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sens to pay more when the session is
 		 * finished and to speed the process up during the measurement
@@ -284,12 +291,33 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 	return tp_vars;
 }
 
+/**
+ * batadv_tp_list_active() - check if session from/to destination is ongoing
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @dst: the other endpoint MAC address to look for
+ *
+ * Return: if matching session with @dst was found
+ */
+static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
+	__must_hold(&bat_priv->tp_list_lock)
+{
+	struct batadv_tp_vars *tp_vars;
+
+	hlist_for_each_entry_rcu(tp_vars, &bat_priv->tp_list, list) {
+		if (batadv_compare_eth(tp_vars->other_end, dst))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * batadv_tp_list_find_session() - find tp_vars session object in the global
  *  list
  * @bat_priv: the bat priv with all the soft interface information
  * @dst: the other endpoint MAC address to look for
  * @session: session identifier
+ * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point, session as tp meter
  * session and return it after having increment the refcounter. Return NULL
@@ -299,7 +327,7 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
  */
 static struct batadv_tp_vars *
 batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
-			    const u8 *session)
+			    const u8 *session, enum batadv_tp_meter_role role)
 {
 	struct batadv_tp_vars *pos, *tp_vars = NULL;
 
@@ -311,6 +339,9 @@ batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
 		if (memcmp(pos->session, session, sizeof(pos->session)) != 0)
 			continue;
 
+		if (pos->role != role)
+			continue;
+
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sense to pay more when the session is
 		 * finished and to speed the process up during the measurement
@@ -365,32 +396,41 @@ static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
- * @bat_priv: the bat priv with all the soft interface information
- * @tp_vars: the private data of the current TP meter session to cleanup
+ * batadv_tp_list_detach() - remove tp session from mesh session list once
+ * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
-				     struct batadv_tp_vars *tp_vars)
+static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
 {
-	cancel_delayed_work(&tp_vars->finish_work);
+	bool detached = false;
 
 	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
+	if (!hlist_unhashed(&tp_vars->list)) {
+		hlist_del_init_rcu(&tp_vars->list);
+		detached = true;
+	}
 	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
 
+	if (!detached)
+		return;
+
+	atomic_dec(&tp_vars->bat_priv->tp_num);
+
 	/* drop list reference */
 	batadv_tp_vars_put(tp_vars);
+}
 
-	atomic_dec(&tp_vars->bat_priv->tp_num);
+/**
+ * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
+ * @tp_vars: the private data of the current TP meter session to cleanup
+ */
+static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
+{
+	cancel_delayed_work_sync(&tp_vars->finish_work);
+
+	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
-	del_timer_sync(&tp_vars->timer);
-	/* the worker might have rearmed itself therefore we kill it again. Note
-	 * that if the worker should run again before invoking the following
-	 * del_timer(), it would not re-arm itself once again because the status
-	 * is OFF now
-	 */
-	del_timer(&tp_vars->timer);
+	timer_shutdown_sync(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 
@@ -402,11 +442,14 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 				 struct batadv_tp_vars *tp_vars)
 {
+	enum batadv_tp_meter_reason reason;
 	u32 session_cookie;
 
+	reason = atomic_read(&tp_vars->send_result);
+
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Test towards %pM finished..shutting down (reason=%d)\n",
-		   tp_vars->other_end, tp_vars->reason);
+		   tp_vars->other_end, reason);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
@@ -419,7 +462,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 	session_cookie = batadv_tp_session_cookie(tp_vars->session,
 						  tp_vars->icmp_uid);
 
-	batadv_tp_batctl_notify(tp_vars->reason,
+	batadv_tp_batctl_notify(reason,
 				tp_vars->other_end,
 				bat_priv,
 				tp_vars->start_time,
@@ -435,10 +478,18 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (atomic_xchg(&tp_vars->sending, 0) != 1)
-		return;
+	atomic_cmpxchg(&tp_vars->send_result, 0, reason);
+}
 
-	tp_vars->reason = reason;
+/**
+ * batadv_tp_sender_stopped() - check if tp session was stopped with reason
+ * @tp_vars: the private data of the current TP meter session
+ *
+ * Return: whether stop reason was found
+ */
+static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
+{
+	return atomic_read(&tp_vars->send_result) != 0;
 }
 
 /**
@@ -468,7 +519,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 	/* most of the time this function is invoked while normal packet
 	 * reception...
 	 */
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
@@ -488,7 +539,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	struct batadv_tp_vars *tp_vars = from_timer(tp_vars, t, timer);
 	struct batadv_priv *bat_priv = tp_vars->bat_priv;
 
-	if (atomic_read(&tp_vars->sending) == 0)
+	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
 	/* if the user waited long enough...shutdown the test */
@@ -643,14 +694,11 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 
 	/* find the tp_vars */
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session);
+					      icmp->session, BATADV_TP_SENDER);
 	if (unlikely(!tp_vars))
 		return;
 
-	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
-		goto out;
-
-	if (unlikely(atomic_read(&tp_vars->sending) == 0))
+	if (unlikely(batadv_tp_sender_stopped(tp_vars)))
 		goto out;
 
 	/* old ACK? silently drop it.. */
@@ -816,21 +864,21 @@ static int batadv_tp_send(void *arg)
 
 	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
 	if (unlikely(!orig_node)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (unlikely(!primary_if)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		tp_vars->reason = err;
+		batadv_tp_sender_shutdown(tp_vars, err);
 		goto out;
 	}
 
@@ -849,7 +897,7 @@ static int batadv_tp_send(void *arg)
 	queue_delayed_work(batadv_event_workqueue, &tp_vars->finish_work,
 			   msecs_to_jiffies(tp_vars->test_length));
 
-	while (atomic_read(&tp_vars->sending) != 0) {
+	while (!batadv_tp_sender_stopped(tp_vars)) {
 		if (unlikely(!batadv_tp_avail(tp_vars, payload_len))) {
 			batadv_tp_wait_available(tp_vars, payload_len);
 			continue;
@@ -872,8 +920,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_xchg(&tp_vars->sending, 0) == 1)
-				tp_vars->reason = err;
+			batadv_tp_sender_shutdown(tp_vars, err);
 			break;
 		}
 
@@ -889,7 +936,8 @@ static int batadv_tp_send(void *arg)
 	batadv_orig_node_put(orig_node);
 
 	batadv_tp_sender_end(bat_priv, tp_vars);
-	batadv_tp_sender_cleanup(bat_priv, tp_vars);
+	batadv_tp_sender_cleanup(tp_vars);
+	complete(&tp_vars->finished);
 
 	batadv_tp_vars_put(tp_vars);
 
@@ -921,7 +969,8 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 		batadv_tp_vars_put(tp_vars);
 
 		/* cleanup of failed tp meter variables */
-		batadv_tp_sender_cleanup(bat_priv, tp_vars);
+		batadv_tp_sender_cleanup(tp_vars);
+		complete(&tp_vars->finished);
 		return;
 	}
 
@@ -957,10 +1006,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		return;
 	}
 
-	tp_vars = batadv_tp_list_find(bat_priv, dst);
-	if (tp_vars) {
+	if (batadv_tp_list_active(bat_priv, dst)) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
-		batadv_tp_vars_put(tp_vars);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: test to or from the same node already ongoing, aborting\n");
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_ALREADY_ONGOING,
@@ -979,6 +1026,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -992,7 +1040,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	ether_addr_copy(tp_vars->other_end, dst);
 	kref_init(&tp_vars->refcount);
 	tp_vars->role = BATADV_TP_SENDER;
-	atomic_set(&tp_vars->sending, 1);
+	atomic_set(&tp_vars->send_result, 0);
 	memcpy(tp_vars->session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
@@ -1027,6 +1075,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->start_time = jiffies;
 
 	init_waitqueue_head(&tp_vars->more_bytes);
+	init_completion(&tp_vars->finished);
 
 	spin_lock_init(&tp_vars->unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
@@ -1079,18 +1128,14 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!orig_node)
 		return;
 
-	tp_vars = batadv_tp_list_find(bat_priv, orig_node->orig);
+	tp_vars = batadv_tp_list_find(bat_priv, orig_node->orig, BATADV_TP_SENDER);
 	if (!tp_vars) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: trying to interrupt an already over connection\n");
 		goto out_put_orig_node;
 	}
 
-	if (unlikely(tp_vars->role != BATADV_TP_SENDER))
-		goto out_put_tp_vars;
-
 	batadv_tp_sender_shutdown(tp_vars, return_value);
-out_put_tp_vars:
 	batadv_tp_vars_put(tp_vars);
 out_put_orig_node:
 	batadv_orig_node_put(orig_node);
@@ -1133,14 +1178,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 		   "Shutting down for inactivity (more than %dms) from %pM\n",
 		   BATADV_TP_RECV_TIMEOUT, tp_vars->other_end);
 
-	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
-	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
-
-	/* drop list reference */
-	batadv_tp_vars_put(tp_vars);
-
-	atomic_dec(&bat_priv->tp_num);
+	batadv_tp_list_detach(tp_vars);
 
 	spin_lock_bh(&tp_vars->unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
@@ -1150,6 +1188,9 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* drop reference of timer */
+	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
+		return;
+
 	batadv_tp_vars_put(tp_vars);
 }
 
@@ -1350,7 +1391,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		goto out_unlock;
 
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session);
+					      icmp->session, BATADV_TP_RECEIVER);
 	if (tp_vars)
 		goto out_unlock;
 
@@ -1361,11 +1402,14 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
+	atomic_set(&tp_vars->receiving, 1);
 	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
 	tp_vars->bat_priv = bat_priv;
@@ -1418,7 +1462,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		}
 	} else {
 		tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-						      icmp->session);
+						      icmp->session, BATADV_TP_RECEIVER);
 		if (!tp_vars) {
 			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 				   "Unexpected packet from %pM!\n",
@@ -1427,13 +1471,6 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		}
 	}
 
-	if (unlikely(tp_vars->role != BATADV_TP_RECEIVER)) {
-		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-			   "Meter: dropping packet: not expected (role=%u)\n",
-			   tp_vars->role);
-		goto out;
-	}
-
 	tp_vars->last_recv_time = jiffies;
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
@@ -1503,6 +1540,56 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 	consume_skb(skb);
 }
 
+/**
+ * batadv_tp_stop_all() - stop all currently running tp meter sessions
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+void batadv_tp_stop_all(struct batadv_priv *bat_priv)
+{
+	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
+	struct batadv_tp_vars *tp_var;
+	size_t count = 0;
+	size_t i;
+
+	spin_lock_bh(&bat_priv->tp_list_lock);
+	hlist_for_each_entry(tp_var, &bat_priv->tp_list, list) {
+		if (WARN_ON_ONCE(count >= BATADV_TP_MAX_NUM))
+			break;
+
+		if (!kref_get_unless_zero(&tp_var->refcount))
+			continue;
+
+		tp_vars[count++] = tp_var;
+	}
+	spin_unlock_bh(&bat_priv->tp_list_lock);
+
+	for (i = 0; i < count; i++) {
+		tp_var = tp_vars[i];
+
+		switch (tp_var->role) {
+		case BATADV_TP_SENDER:
+			batadv_tp_sender_shutdown(tp_var,
+						  BATADV_TP_REASON_CANCEL);
+			wake_up(&tp_var->more_bytes);
+			wait_for_completion(&tp_var->finished);
+			break;
+		case BATADV_TP_RECEIVER:
+			batadv_tp_list_detach(tp_var);
+			timer_shutdown_sync(&tp_var->timer);
+
+			if (atomic_xchg(&tp_var->receiving, 0) != 1)
+				break;
+
+			batadv_tp_vars_put(tp_var);
+			break;
+		}
+
+		batadv_tp_vars_put(tp_var);
+	}
+
+	synchronize_net();
+}
+
 /**
  * batadv_tp_meter_init() - initialize global tp_meter structures
  */
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index f0046d366eac..4e97cd10cd02 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -17,6 +17,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value);
+void batadv_tp_stop_all(struct batadv_priv *bat_priv);
 void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_TP_METER_H_ */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 76cf40d85990..e4d55b27f255 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -843,17 +843,19 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 				   s32 *tt_len)
 {
 	u16 num_vlan = 0;
-	u16 num_entries = 0;
 	u16 tvlv_len = 0;
 	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
+	u16 total_entries = 0;
 	u8 *tt_change_ptr;
+	int vlan_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
 	change_offset = sizeof(**tt_data);
@@ -861,7 +863,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
 		*tt_len = 0;
@@ -882,14 +884,27 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = sizeof(**tt_data);
+	change_offset += num_vlan * sizeof(*tt_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 
@@ -934,11 +949,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		if (vlan_entries < 1)
-			continue;
-
-		num_vlan++;
 		total_entries += vlan_entries;
+		num_vlan++;
 	}
 
 	change_offset = sizeof(**tt_data);
@@ -962,6 +974,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -972,8 +985,16 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = sizeof(**tt_data);
+	change_offset += num_vlan * sizeof(*tt_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 992773376e51..de0c13942683 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -7,11 +7,13 @@
 #include "main.h"
 
 #include <linux/byteorder/generic.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -159,10 +161,10 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
  *
  * Return: size of all currently registered tvlv containers in bytes.
  */
-static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
+static size_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_container *tvlv;
-	u16 tvlv_len = 0;
+	size_t tvlv_len = 0;
 
 	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
@@ -306,26 +308,35 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
  *
- * Return: size of all appended tvlv containers in bytes.
+ * Return: size of all appended tvlv containers in bytes (max U16_MAX), negative
+ *  if operation failed
  */
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len)
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_len;
+	size_t tvlv_value_len;
 	void *tvlv_value;
+	int tvlv_len_ret;
 	bool ret;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
 	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
+	if (tvlv_value_len > U16_MAX) {
+		tvlv_len_ret = -E2BIG;
+		goto end;
+	}
 
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);
-
-	if (!ret)
+	if (!ret) {
+		tvlv_len_ret = -ENOMEM;
 		goto end;
+	}
+
+	tvlv_len_ret = tvlv_value_len;
 
 	if (!tvlv_value_len)
 		goto end;
@@ -344,7 +355,8 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 
 end:
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-	return tvlv_value_len;
+
+	return tvlv_len_ret;
 }
 
 /**
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 54f2a35653d0..ffbc93f78688 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -15,7 +15,7 @@
 void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len);
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 19fd1c9adf49..f1a835edd115 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -14,6 +14,7 @@
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
@@ -82,6 +83,9 @@ struct batadv_hard_iface_bat_iv {
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
+	/** @reschedule_work: recover OGM schedule after schedule error */
+	struct delayed_work reschedule_work;
+
 	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
 	struct mutex ogm_buff_mutex;
 };
@@ -1023,6 +1027,12 @@ struct batadv_priv_bla {
 	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
 
+	/**
+	 * @num_requests_lock: locks update num_requests +
+	 * batadv_backbone_gw::state + batadv_backbone_gw::wait_periods update
+	 */
+	spinlock_t num_requests_lock;
+
 	/**
 	 * @claim_hash: hash table containing mesh nodes this host has claimed
 	 */
@@ -1387,15 +1397,21 @@ struct batadv_tp_vars {
 	/** @role: receiver/sender modi */
 	enum batadv_tp_meter_role role;
 
-	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
-	atomic_t sending;
+	/**
+	 * @send_result: 0 when sending is ongoing and otherwise
+	 * enum batadv_tp_meter_reason
+	 */
+	atomic_t send_result;
 
-	/** @reason: reason for a stopped session */
-	enum batadv_tp_meter_reason reason;
+	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
+	atomic_t receiving;
 
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
+	/** @finished: completion signaled when a sender thread exits */
+	struct completion finished;
+
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 
@@ -1784,6 +1800,27 @@ struct batadv_socket_packet {
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 
+enum batadv_bla_backbone_gw_state {
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_STOPPED: backbone gw is being removed
+	 * and it must not longer work on requests
+	 */
+	BATADV_BLA_BACKBONE_GW_STOPPED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_UNSYNCED: backbone was detected out
+	 * of sync and a request was send. No traffic is forwarded until the
+	 * situation is resolved
+	 */
+	BATADV_BLA_BACKBONE_GW_UNSYNCED,
+
+	/**
+	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is consider to be in
+	 * sync. traffic can be forwarded
+	 */
+	BATADV_BLA_BACKBONE_GW_SYNCED,
+};
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  */
@@ -1809,16 +1846,12 @@ struct batadv_bla_backbone_gw {
 	/**
 	 * @wait_periods: grace time for bridge forward delays and bla group
 	 *  forming at bootup phase - no bcast traffic is formwared until it has
-	 *  elapsed
+	 *  elapsed. Must only be access with num_requests_lock.
 	 */
-	atomic_t wait_periods;
+	u8 wait_periods;
 
-	/**
-	 * @request_sent: if this bool is set to true we are out of sync with
-	 *  this backbone gateway - no bcast traffic is formwared until the
-	 *  situation was resolved
-	 */
-	atomic_t request_sent;
+	/** @state: sync state. Must only be access with num_requests_lock. */
+	enum batadv_bla_backbone_gw_state state;
 
 	/** @crc: crc16 checksum over all claims */
 	u16 crc;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index b70d3a38fded..9424d153f323 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -449,7 +449,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	iv.iov_len = skb->len;
 
 	memset(&msg, 0, sizeof(msg));
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, skb->len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
 	err = l2cap_chan_send(chan, &msg, skb->len);
 	if (err > 0) {
@@ -485,6 +485,8 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb)
+				continue;
 
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name,
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1fcc482397c3..e7adb8a98cf9 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -56,7 +56,7 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *dat
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, total_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, total_len);
 
 	l2cap_chan_send(chan, &msg, total_len);
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2a55738000ae..a9de0a2135a7 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -138,6 +138,36 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 	return err;
 }
 
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+	spin_lock_init(&bt_sk(sk)->accept_q_lock);
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state    = BT_OPEN;
+
+	/* Init peer information so it can be properly monitored */
+	if (!kern) {
+		spin_lock(&sk->sk_peer_lock);
+		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_cred = get_current_cred();
+		spin_unlock(&sk->sk_peer_lock);
+	}
+
+	return sk;
+}
+EXPORT_SYMBOL(bt_sock_alloc);
+
 void bt_sock_link(struct bt_sock_list *l, struct sock *sk)
 {
 	write_lock(&l->lock);
@@ -178,6 +208,10 @@ EXPORT_SYMBOL(bt_sock_linked);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
+	const struct cred *old_cred;
+	struct pid *old_pid;
+	struct bt_sock *par = bt_sk(parent);
+
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
@@ -187,15 +221,30 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
-	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	spin_lock_bh(&par->accept_q_lock);
+	list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
+	sk_acceptq_added(parent);
+	spin_unlock_bh(&par->accept_q_lock);
+
+	/* Copy credentials from parent since for incoming connections the
+	 * socket is allocated by the kernel.
+	 */
+	spin_lock(&sk->sk_peer_lock);
+	old_pid = sk->sk_peer_pid;
+	old_cred = sk->sk_peer_cred;
+	sk->sk_peer_pid = get_pid(parent->sk_peer_pid);
+	sk->sk_peer_cred = get_cred(parent->sk_peer_cred);
+	spin_unlock(&sk->sk_peer_lock);
+
+	put_pid(old_pid);
+	put_cred(old_cred);
+
 	if (bh)
 		bh_unlock_sock(sk);
 	else
 		release_sock(sk);
-
-	sk_acceptq_added(parent);
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
@@ -204,45 +253,72 @@ EXPORT_SYMBOL(bt_accept_enqueue);
  */
 void bt_accept_unlink(struct sock *sk)
 {
+	struct sock *parent = bt_sk(sk)->parent;
+
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
 	list_del_init(&bt_sk(sk)->accept_q);
-	sk_acceptq_removed(bt_sk(sk)->parent);
+	sk_acceptq_removed(parent);
+	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
+static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
+{
+	struct bt_sock *bt = bt_sk(parent);
+	struct sock *next = NULL;
+
+	/* accept_q is modified from child teardown paths too, so take a
+	 * temporary reference before dropping the queue lock.
+	 */
+	spin_lock_bh(&bt->accept_q_lock);
+
+	if (sk) {
+		if (bt_sk(sk)->parent != parent)
+			goto out;
+
+		if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
+			next = &list_next_entry(bt_sk(sk), accept_q)->sk;
+			sock_hold(next);
+		}
+	} else if (!list_empty(&bt->accept_q)) {
+		next = &list_first_entry(&bt->accept_q,
+					 struct bt_sock, accept_q)->sk;
+		sock_hold(next);
+	}
+
+out:
+	spin_unlock_bh(&bt->accept_q_lock);
+	return next;
+}
+
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 {
-	struct bt_sock *s, *n;
-	struct sock *sk;
+	struct sock *sk, *next;
 
 	BT_DBG("parent %p", parent);
 
 restart:
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
-		sk = (struct sock *)s;
-
+	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
 		/* Prevent early freeing of sk due to unlink and sock_kill */
-		sock_hold(sk);
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
 		 * bt_accept_unlink() due to serialisation caused by sk locking
 		 */
-		if (!bt_sk(sk)->parent) {
+		if (bt_sk(sk)->parent != parent) {
 			BT_DBG("sk %p, already unlinked", sk);
 			release_sock(sk);
 			sock_put(sk);
 
-			/* Restart the loop as sk is no longer in the list
-			 * and also avoid a potential infinite loop because
-			 * list_for_each_entry_safe() is not thread safe.
-			 */
 			goto restart;
 		}
 
+		next = bt_accept_get(parent, sk);
+
 		/* sk is safely in the parent list so reduce reference count */
 		sock_put(sk);
 
@@ -259,7 +335,19 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
+			/* Hand the caller a reference taken while sk is
+			 * still locked.  bt_accept_unlink() just dropped
+			 * the accept-queue reference; without this hold a
+			 * concurrent teardown (e.g. l2cap_conn_del() ->
+			 * l2cap_sock_kill()) could free sk between
+			 * release_sock() and the caller using it.  Every
+			 * caller drops this with sock_put() when done.
+			 */
+			sock_hold(sk);
+
 			release_sock(sk);
+			if (next)
+				sock_put(next);
 			return sk;
 		}
 
@@ -458,18 +546,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
 
 static inline __poll_t bt_accept_poll(struct sock *parent)
 {
-	struct bt_sock *s, *n;
+	struct bt_sock *bt = bt_sk(parent);
+	struct bt_sock *s;
 	struct sock *sk;
+	__poll_t mask = 0;
+
+	spin_lock_bh(&bt->accept_q_lock);
+	list_for_each_entry(s, &bt->accept_q, accept_q) {
+		int state;
 
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
-		if (sk->sk_state == BT_CONNECTED ||
-		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
-			return EPOLLIN | EPOLLRDNORM;
+		state = READ_ONCE(sk->sk_state);
+
+		if (state == BT_CONNECTED ||
+		    (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
+		     state == BT_CONNECT2)) {
+			mask = EPOLLIN | EPOLLRDNORM;
+			break;
+		}
 	}
+	spin_unlock_bh(&bt->accept_q_lock);
 
-	return 0;
+	return mask;
 }
 
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index f3b9c1dee1bb..627ce3de29c8 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -206,14 +206,11 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 	return 0;
 }
 
-static int bnep_rx_control(struct bnep_session *s, void *data, int len)
+static int bnep_rx_control_cmd(struct bnep_session *s, u8 cmd, void *data,
+			       int len)
 {
-	u8  cmd = *(u8 *)data;
 	int err = 0;
 
-	data++;
-	len--;
-
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
 	case BNEP_SETUP_CONN_RSP:
@@ -254,6 +251,14 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 	return err;
 }
 
+static int bnep_rx_control(struct bnep_session *s, void *data, int len)
+{
+	if (len < 1)
+		return -EILSEQ;
+
+	return bnep_rx_control_cmd(s, *(u8 *)data, data + 1, len - 1);
+}
+
 static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct bnep_ext_hdr *h;
@@ -299,19 +304,26 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
+	u8 *data;
 	u8 type, ctrl_type;
 
 	dev->stats.rx_bytes += skb->len;
 
-	type = *(u8 *) skb->data;
-	skb_pull(skb, 1);
-	ctrl_type = *(u8 *)skb->data;
+	data = skb_pull_data(skb, sizeof(type));
+	if (!data)
+		goto badframe;
+	type = *data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
+		data = skb_pull_data(skb, sizeof(ctrl_type));
+		if (!data)
+			goto badframe;
+		ctrl_type = *data;
+
+		if (bnep_rx_control_cmd(s, ctrl_type, skb->data, skb->len) < 0) {
 			dev->stats.tx_errors++;
 			kfree_skb(skb);
 			return 0;
@@ -324,15 +336,25 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 		/* Verify and pull ctrl message since it's already processed */
 		switch (ctrl_type) {
-		case BNEP_SETUP_CONN_REQ:
-			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
-			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
+		case BNEP_SETUP_CONN_REQ: {
+			u8 uuid_size;
+
+			/* Pull uuid_size and the dst/src service UUIDs. */
+			data = skb_pull_data(skb, sizeof(uuid_size));
+			if (!data)
+				goto badframe;
+			uuid_size = *data;
+			if (!skb_pull(skb, uuid_size + uuid_size))
 				goto badframe;
 			break;
+		}
 		case BNEP_FILTER_MULTI_ADDR_SET:
 		case BNEP_FILTER_NET_TYPE_SET:
-			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
-			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+			/* Pull: len (2 b), data (len bytes) */
+			data = skb_pull_data(skb, sizeof(u16));
+			if (!data)
+				goto badframe;
+			if (!skb_pull(skb, get_unaligned_be16(data)))
 				goto badframe;
 			break;
 		default:
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index d515571b2afb..59762d82761c 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -204,21 +204,13 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &bnep_proto, kern);
+	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &bnep_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&bnep_sk_list, sk);
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc79a362aef7..7ce4ae5a6ba1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4953,9 +4953,11 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
 
 	conn->passkey_notify = __le32_to_cpu(ev->passkey);
 	conn->passkey_entered = 0;
@@ -4964,6 +4966,9 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -4973,14 +4978,16 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
 
 	switch (ev->type) {
 	case HCI_KEYPRESS_STARTED:
 		conn->passkey_entered = 0;
-		return;
+		goto unlock;
 
 	case HCI_KEYPRESS_ENTERED:
 		conn->passkey_entered++;
@@ -4995,13 +5002,16 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case HCI_KEYPRESS_COMPLETED:
-		return;
+		goto unlock;
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 28222c7c098e..68c4ba43cca4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2091,18 +2091,12 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hci_sk_proto, protocol, GFP_ATOMIC,
+			   kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-
 	sock->state = SS_UNCONNECTED;
-	sk->sk_state = BT_OPEN;
 	sk->sk_destruct = hci_sock_destruct;
 
 	bt_sock_link(&hci_sk_list, sk);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index cc7d4a8ed8ce..b1886e517a78 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -81,10 +81,12 @@ static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		hci_release_dev(hdev);
-	else
+	} else {
+		cleanup_srcu_struct(&hdev->srcu);
 		kfree(hdev);
+	}
 	module_put(THIS_MODULE);
 }
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 968c02903ab4..e359d448efe9 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	u8 *hdr;
+	int i;
+
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		return;
 
-	switch (skb->data[0]) {
+	switch (*hdr) {
 	case 0x01:	/* Keyboard report */
+		udata = skb_pull_data(skb, 8);
+		if (!udata)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +222,10 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		sdata = skb_pull_data(skb, 3);
+		if (!sdata)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
@@ -222,7 +235,7 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		input_report_rel(dev, REL_X, sdata[1]);
 		input_report_rel(dev, REL_Y, sdata[2]);
 
-		if (size > 3)
+		if (skb->len > 0)
 			input_report_rel(dev, REL_WHEEL, sdata[3]);
 		break;
 	}
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 595fb3c9d6c3..19c932673bf1 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -255,21 +255,13 @@ static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hidp_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hidp_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &hidp_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&hidp_sk_list, sk);
 
 	return 0;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5db427c13de..ed2388e31c6c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -435,8 +435,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn)
+	if (!conn) {
+		l2cap_chan_put(chan);
 		return;
+	}
 
 	mutex_lock(&conn->chan_lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
@@ -6222,6 +6224,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*rsp);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		struct l2cap_chan *orig;
 		u16 dcid;
 
 		if (chan->ident != cmd->ident ||
@@ -6243,8 +6246,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
 
+		orig = __l2cap_get_chan_by_dcid(conn, dcid);
+
 		/* Check if dcid is already in use */
-		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+		if (dcid && orig) {
 			/* If a device receives a
 			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
 			 * already-assigned Destination CID, then both the
@@ -6253,10 +6258,24 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			 */
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
-			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
+
+			/* Check that the dcid channel mode is
+			 * L2CAP_MODE_EXT_FLOWCTL since this procedure is only
+			 * valid for that mode and shouldn't disconnect a dcid
+			 * in other modes.
+			 */
+			if (orig->mode == L2CAP_MODE_EXT_FLOWCTL) {
+				l2cap_chan_lock(orig);
+				/* Disconnect the original channel as it may be
+				 * considered connected since dcid has already
+				 * been assigned; don't call l2cap_chan_close
+				 * directly since that could lead to
+				 * l2cap_chan_del and then removing the channel
+				 * from the list while we're iterating over it.
+				 */
+				__set_chan_timer(orig, 0);
+				l2cap_chan_unlock(orig);
+			}
 			continue;
 		}
 
@@ -6422,14 +6441,20 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result)
+	if (!result) {
+		list_for_each_entry(chan, &conn->chan_l, list) {
+			if (chan->ident == cmd->ident)
+				chan->ident = 0;
+		}
 		return 0;
+	}
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		if (chan->ident != cmd->ident)
 			continue;
 
-		l2cap_chan_hold(chan);
+		if (!l2cap_chan_hold_unless_zero(chan))
+			continue;
 		l2cap_chan_lock(chan);
 
 		l2cap_chan_del(chan, ECONNRESET);
@@ -6583,6 +6608,15 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 ident)
+{
+	struct l2cap_cmd_rej_mtu rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
+	rej.max_mtu = cpu_to_le16(L2CAP_SIG_MTU);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -6595,6 +6629,43 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	/*
+	 * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
+	 * signaling channel has a fixed signaling MTU (MTUsig) whose
+	 * minimum and default is 48 octets.  Section 4.1 says that on
+	 * an MTUExceeded command reject the identifier "shall match
+	 * the first request command in the L2CAP packet" and that
+	 * packets containing only response commands "shall be
+	 * silently discarded".
+	 *
+	 * Linux intentionally deviates from that prescription:
+	 *
+	 *   1. Silently discarding desynchronizes the peer.  The
+	 *      remote stack never learns its responses were dropped,
+	 *      so any state machine waiting on a paired response
+	 *      stalls until its own timer fires.
+	 *
+	 *   2. Locating "the first request command" requires walking
+	 *      command headers past MTUsig, i.e. processing bytes
+	 *      from a packet we have already decided is too large to
+	 *      process.
+	 *
+	 * Reject every over-MTUsig signaling packet with one
+	 * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
+	 * reason field is what tells the peer that the whole packet
+	 * was discarded; the identifier value is informational, so
+	 * we use the identifier from the first command header, a
+	 * single fixed-offset byte read.
+	 */
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = skb->data[1];
+
+		BT_DBG("signaling packet exceeds MTU: %u > %u",
+		       skb->len, L2CAP_SIG_MTU);
+		l2cap_sig_send_mtu_rej(conn, ident);
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0fbf063fbd7b..091dea5569d2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -177,21 +177,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return err;
 }
 
-static void l2cap_sock_init_pid(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-	/* Only L2CAP_MODE_EXT_FLOWCTL ever need to access the PID in order to
-	 * group the channels being requested.
-	 */
-	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
-		return;
-
-	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid = get_pid(task_tgid(current));
-	spin_unlock(&sk->sk_peer_lock);
-}
-
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			      int alen, int flags)
 {
@@ -267,8 +252,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	l2cap_sock_init_pid(sk);
-
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -324,8 +307,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	l2cap_sock_init_pid(sk);
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
@@ -366,8 +347,13 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -1444,22 +1430,56 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Close not yet accepted channels.
+	 *
+	 * bt_accept_dequeue() now returns sk with an extra reference held
+	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * -> l2cap_sock_kill() cannot free sk under us.
+	 *
+	 * cleanup_listen() runs under the parent sk lock, so unlike
+	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
+	 * establish sk_lock -> conn->lock and invert the established
+	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
+	 *
+	 * Instead, briefly take the child sk lock to fetch and pin its chan.
+	 * l2cap_conn_del() reaches the chan free only via
+	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
+	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
+	 * therefore guarantees the chan cannot be freed while we read and
+	 * pin it (hold_unless_zero() additionally skips a chan already past
+	 * its last reference).  We then drop the sk lock before taking
+	 * chan->lock, so sk and chan locks are never held together.
+	 *
+	 * Since we cannot call l2cap_chan_close() without conn->lock,
+	 * schedule l2cap_chan_timeout to close the channel; it already
+	 * acquires conn->lock -> chan->lock in the correct order.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		struct l2cap_chan *chan;
+
+		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		release_sock(sk);
+		if (!chan) {
+			/* l2cap_conn_del() already tearing this child down */
+			sock_put(sk);
+			continue;
+		}
 
 		BT_DBG("child chan %p state %s", chan,
 		       state_to_string(chan->state));
 
-		l2cap_chan_hold(chan);
 		l2cap_chan_lock(chan);
-
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
-
+		/* Since we cannot call l2cap_chan_close() without
+		 * conn->lock, schedule its timer to trigger the close
+		 * and cleanup of this channel.
+		 */
+		if (chan->conn)
+			__set_chan_timer(chan, 0);
 		l2cap_chan_unlock(chan);
+
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
 }
 
@@ -1876,21 +1896,13 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	struct sock *sk;
 	struct l2cap_chan *chan;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto, kern);
+	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state = BT_OPEN;
-
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09232c424446..5b67247587ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7635,6 +7635,12 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (!cur_len)
 			continue;
 
+		/* If the current field length would exceed the total data
+		 * length, then it's invalid.
+		 */
+		if (i + cur_len >= len)
+			return false;
+
 		if (data[i + 1] == EIR_FLAGS &&
 		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
@@ -7651,12 +7657,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (data[i + 1] == EIR_APPEARANCE &&
 		    appearance_managed(adv_flags))
 			return false;
-
-		/* If the current field length would exceed the total data
-		 * length, then it's invalid.
-		 */
-		if (i + cur_len >= len)
-			return false;
 	}
 
 	return true;
@@ -8078,15 +8078,22 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_add_ext_adv_data *cp = data;
 	struct mgmt_rp_add_ext_adv_data rp;
+	struct hci_request req;
 	u8 schedule_instance = 0;
 	struct adv_info *next_instance;
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
+	u16 expected_len;
 
 	BT_DBG("%s", hdev->name);
 
+	expected_len = struct_size(cp, data, cp->adv_data_len +
+				   cp->scan_rsp_len);
+	if (expected_len > data_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4f54c7df3a94..374187def190 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1427,10 +1427,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, int cr, struct rfcomm_pn *pn)
 
 static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_pn *pn = (void *) skb->data;
+	struct rfcomm_pn *pn;
 	struct rfcomm_dlc *d;
-	u8 dlci = pn->dlci;
+	u8 dlci;
+
+	pn = skb_pull_data(skb, sizeof(*pn));
+	if (!pn)
+		return -EILSEQ;
 
+	dlci = pn->dlci;
 	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
 
 	if (!dlci)
@@ -1479,8 +1484,8 @@ static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 
 static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_buff *skb)
 {
-	struct rfcomm_rpn *rpn = (void *) skb->data;
-	u8 dlci = __get_dlci(rpn->dlci);
+	struct rfcomm_rpn *rpn;
+	u8 dlci;
 
 	u8 bit_rate  = 0;
 	u8 data_bits = 0;
@@ -1491,15 +1496,16 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 	u8 xoff_char = 0;
 	u16 rpn_mask = RFCOMM_RPN_PM_ALL;
 
-	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x",
-		dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
-		rpn->xon_char, rpn->xoff_char, rpn->param_mask);
+	if (len == 1) {
+		rpn = skb_pull_data(skb, 1);
+		if (!rpn)
+			return -EILSEQ;
 
-	if (!cr)
-		return 0;
+		dlci = __get_dlci(rpn->dlci);
+
+		if (!cr)
+			return 0;
 
-	if (len == 1) {
-		/* This is a request, return default (according to ETSI TS 07.10) settings */
 		bit_rate  = RFCOMM_RPN_BR_9600;
 		data_bits = RFCOMM_RPN_DATA_8;
 		stop_bits = RFCOMM_RPN_STOP_1;
@@ -1510,6 +1516,19 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 		goto rpn_out;
 	}
 
+	rpn = skb_pull_data(skb, sizeof(*rpn));
+	if (!rpn)
+		return -EILSEQ;
+
+	dlci = __get_dlci(rpn->dlci);
+
+	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x",
+	       dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
+	       rpn->xon_char, rpn->xoff_char, rpn->param_mask);
+
+	if (!cr)
+		return 0;
+
 	/* Check for sane values, ignore/accept bit_rate, 8 bits, 1 stop bit,
 	 * no parity, no flow control lines, normal XON/XOFF chars */
 
@@ -1585,9 +1604,14 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 
 static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_rls *rls = (void *) skb->data;
-	u8 dlci = __get_dlci(rls->dlci);
+	struct rfcomm_rls *rls;
+	u8 dlci;
 
+	rls = skb_pull_data(skb, sizeof(*rls));
+	if (!rls)
+		return -EILSEQ;
+
+	dlci = __get_dlci(rls->dlci);
 	BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
 
 	if (!cr)
@@ -1604,10 +1628,15 @@ static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb)
 {
-	struct rfcomm_msc *msc = (void *) skb->data;
+	struct rfcomm_msc *msc;
 	struct rfcomm_dlc *d;
-	u8 dlci = __get_dlci(msc->dlci);
+	u8 dlci;
+
+	msc = skb_pull_data(skb, sizeof(*msc));
+	if (!msc)
+		return -EILSEQ;
 
+	dlci = __get_dlci(msc->dlci);
 	BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
 
 	d = rfcomm_dlc_get(s, dlci);
@@ -1640,17 +1669,19 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 
 static int rfcomm_recv_mcc(struct rfcomm_session *s, struct sk_buff *skb)
 {
-	struct rfcomm_mcc *mcc = (void *) skb->data;
+	struct rfcomm_mcc *mcc;
 	u8 type, cr, len;
 
+	mcc = skb_pull_data(skb, sizeof(*mcc));
+	if (!mcc)
+		return -EILSEQ;
+
 	cr   = __test_cr(mcc->type);
 	type = __get_mcc_type(mcc->type);
 	len  = __get_mcc_len(mcc->len);
 
 	BT_DBG("%p type 0x%x cr %d", s, type, cr);
 
-	skb_pull(skb, 2);
-
 	switch (type) {
 	case RFCOMM_PN:
 		rfcomm_recv_pn(s, cr, skb);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index d1f2c936a8a8..31f62dfbb5a9 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -122,7 +122,7 @@ static struct sock *__rfcomm_get_listen_sock_by_addr(u8 channel, bdaddr_t *src)
 }
 
 /* Find socket with channel and source bdaddr.
- * Returns closest match.
+ * Returns closest match with an extra reference held.
  */
 static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
 {
@@ -136,15 +136,25 @@ static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *
 
 		if (rfcomm_pi(sk)->channel == channel) {
 			/* Exact match. */
-			if (!bacmp(&rfcomm_pi(sk)->src, src))
+			if (!bacmp(&rfcomm_pi(sk)->src, src)) {
+				sock_hold(sk);
 				break;
+			}
 
 			/* Closest match */
-			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY))
+			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY)) {
+				if (sk1)
+					sock_put(sk1);
+
 				sk1 = sk;
+				sock_hold(sk1);
+			}
 		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&rfcomm_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -180,6 +190,8 @@ static void rfcomm_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		rfcomm_sock_close(sk);
 		rfcomm_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -268,18 +280,16 @@ static struct proto rfcomm_proto = {
 	.obj_size	= sizeof(struct rfcomm_pinfo)
 };
 
-static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
+				      int proto, gfp_t prio, int kern)
 {
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &rfcomm_proto, kern);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	d = rfcomm_dlc_alloc(prio);
 	if (!d) {
 		sk_free(sk);
@@ -298,11 +308,6 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int
 	sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 	sk->sk_rcvbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	bt_sock_link(&rfcomm_sk_list, sk);
 
 	BT_DBG("sk %p", sk);
@@ -503,8 +508,13 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 		}
 
 		nsk = bt_accept_dequeue(sk, newsock);
-		if (nsk)
+		if (nsk) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps nsk alive from here.
+			 */
+			sock_put(nsk);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
@@ -941,6 +951,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 {
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
+	bool defer_setup = false;
 	int result = 0;
 
 	BT_DBG("session %p channel %d", s, channel);
@@ -954,6 +965,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN)
+		goto done;
+
+	defer_setup = test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -981,9 +997,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 done:
 	release_sock(parent);
 
-	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+	if (defer_setup)
 		parent->sk_state_change(parent);
 
+	sock_put(parent);
+
 	return result;
 }
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d0ef74c45914..0a9742d2587a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -394,6 +394,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		sco_sock_close(sk);
 		sco_sock_kill(sk);
+		/* Drop the reference handed back by bt_accept_dequeue(). */
+		sock_put(sk);
 	}
 
 	parent->sk_state  = BT_CLOSED;
@@ -499,21 +501,13 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &sco_proto, kern);
+	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = sco_sock_destruct;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -687,8 +681,13 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 		}
 
 		ch = bt_accept_dequeue(sk, newsock);
-		if (ch)
+		if (ch) {
+			/* Drop the bridging ref from bt_accept_dequeue();
+			 * the grafted socket keeps ch alive from here.
+			 */
+			sock_put(ch);
 			break;
+		}
 
 		if (!timeo) {
 			err = -EAGAIN;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b77984905124..85bd00479a74 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -605,7 +605,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iv, 2, 1 + len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iv, 2, 1 + len);
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index de80939d1e10..742b3a24f9c8 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -199,11 +199,12 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
 			if ((p && (p->flags & BR_PROXYARP)) ||
-			    (f->dst && (f->dst->flags & (BR_PROXYARP_WIFI |
-							 BR_NEIGH_SUPPRESS)))) {
+			    (dst && (dst->flags & (BR_PROXYARP_WIFI |
+						   BR_NEIGH_SUPPRESS)))) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, n->ha, sha, 0, 0);
@@ -463,9 +464,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
-			if (f->dst && (f->dst->flags & BR_NEIGH_SUPPRESS)) {
+			if (dst && (dst->flags & BR_NEIGH_SUPPRESS)) {
 				if (vid != 0)
 					br_nd_send(br, p, skb, n,
 						   skb->vlan_proto,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 83ec74b67340..c7c74a042184 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -121,6 +121,7 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct net_device *dev = NULL;
 	struct net_bridge *br;
@@ -133,8 +134,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 	br = netdev_priv(br_dev);
 	rcu_read_lock();
 	f = br_fdb_find_rcu(br, addr, vid);
-	if (f && f->dst)
-		dev = f->dst->dev;
+	if (f) {
+		dst = READ_ONCE(f->dst);
+		if (dst)
+			dev = dst->dev;
+	}
 	rcu_read_unlock();
 
 	return dev;
@@ -224,7 +228,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		vg = nbp_vlan_group(op);
 		if (op != p && ether_addr_equal(op->dev->dev_addr, addr) &&
 		    (!vid || br_vlan_find(vg, vid))) {
-			f->dst = op;
+			WRITE_ONCE(f->dst, op);
 			clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 			return;
 		}
@@ -235,7 +239,7 @@ static void fdb_delete_local(struct net_bridge *br,
 	/* Maybe bridge device has same hw addr? */
 	if (p && ether_addr_equal(br->dev->dev_addr, addr) &&
 	    (!vid || (v && br_vlan_should_use(v)))) {
-		f->dst = NULL;
+		WRITE_ONCE(f->dst, NULL);
 		clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 		return;
 	}
@@ -462,6 +466,7 @@ int br_fdb_test_addr(struct net_device *dev, unsigned char *addr)
 int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		   unsigned long maxnum, unsigned long skip)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct __fdb_entry *fe = buf;
 	int num = 0;
@@ -477,7 +482,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			continue;
 
 		/* ignore pseudo entry for local MAC address */
-		if (!f->dst)
+		dst = READ_ONCE(f->dst);
+		if (!dst)
 			continue;
 
 		if (skip) {
@@ -489,8 +495,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		memcpy(fe->mac_addr, f->key.addr.addr, ETH_ALEN);
 
 		/* due to ABI compat need to split into hi/lo */
-		fe->port_no = f->dst->port_no;
-		fe->port_hi = f->dst->port_no >> 8;
+		fe->port_no = dst->port_no;
+		fe->port_hi = dst->port_no >> 8;
 
 		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
 		if (!test_bit(BR_FDB_STATIC, &f->flags))
@@ -836,9 +842,11 @@ int br_fdb_dump(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		const struct net_bridge_port *dst = READ_ONCE(f->dst);
+
 		if (*idx < cb->args[2])
 			goto skip;
-		if (filter_dev && (!f->dst || f->dst->dev != filter_dev)) {
+		if (filter_dev && (!dst || dst->dev != filter_dev)) {
 			if (filter_dev != dev)
 				goto skip;
 			/* !f->dst is a special case for bridge
@@ -846,10 +854,10 @@ int br_fdb_dump(struct sk_buff *skb,
 			 * Therefore need a little more filtering
 			 * we only want to dump the !f->dst case
 			 */
-			if (f->dst)
+			if (dst)
 				goto skip;
 		}
-		if (!filter_dev && f->dst)
+		if (!filter_dev && dst)
 			goto skip;
 
 		err = fdb_fill_info(skb, br, f,
diff --git a/net/bridge/netfilter/ebt_snat.c b/net/bridge/netfilter/ebt_snat.c
index 7dfbcdfc30e5..c9e229af0366 100644
--- a/net/bridge/netfilter/ebt_snat.c
+++ b/net/bridge/netfilter/ebt_snat.c
@@ -31,6 +31,9 @@ ebt_snat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 		const struct arphdr *ap;
 		struct arphdr _ah;
 
+		if (skb_ensure_writable(skb, sizeof(_ah) + ETH_ALEN))
+			return EBT_DROP;
+
 		ap = skb_header_pointer(skb, 0, sizeof(_ah), &_ah);
 		if (ap == NULL)
 			return EBT_DROP;
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index c74efcc2b499..2083facfc87d 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1951,6 +1951,25 @@ enum compat_mwt {
 	EBT_COMPAT_TARGET,
 };
 
+static bool match_size_ok(const struct xt_match *match, unsigned int match_size)
+{
+	u16 csize;
+
+	if (match->matchsize == -1) /* cannot validate ebt_among */
+		return true;
+
+	csize = match->compatsize ? : match->matchsize;
+
+	return match_size >= csize;
+}
+
+static bool tgt_size_ok(const struct xt_target *tgt, unsigned int tgt_size)
+{
+	u16 csize = tgt->compatsize ? : tgt->targetsize;
+
+	return tgt_size >= csize;
+}
+
 static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 				enum compat_mwt compat_mwt,
 				struct ebt_entries_buf_state *state,
@@ -1976,6 +1995,11 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 		if (IS_ERR(match))
 			return PTR_ERR(match);
 
+		if (!match_size_ok(match, match_size)) {
+			module_put(match->me);
+			return -EINVAL;
+		}
+
 		off = ebt_compat_match_offset(match, match_size);
 		if (dst) {
 			if (match->compat_from_user)
@@ -1995,6 +2019,12 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 					    mwt->u.revision);
 		if (IS_ERR(wt))
 			return PTR_ERR(wt);
+
+		if (!tgt_size_ok(wt, match_size)) {
+			module_put(wt->me);
+			return -EINVAL;
+		}
+
 		off = xt_compat_target_offset(wt);
 
 		if (dst) {
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 2cb5ffdf071a..6290b062d631 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -30,7 +30,7 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 	if (!buf)
 		msg.msg_flags |= MSG_TRUNC;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, len);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
@@ -49,7 +49,7 @@ static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
-	iov_iter_bvec(&msg.msg_iter, READ, &bvec, 1, length);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 41f26df5cce0..c3b1371e41f8 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -167,7 +167,7 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 						  bv.bv_offset, bv.bv_len,
 						  CEPH_MSG_FLAGS);
 		} else {
-			iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, bv.bv_len);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
 			ret = sock_sendmsg(sock, &msg);
 		}
 		if (ret <= 0) {
@@ -224,7 +224,7 @@ static void reset_in_kvecs(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_kvec_cnt = 0;
-	iov_iter_kvec(&con->v2.in_iter, READ, con->v2.in_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.in_iter, ITER_DEST, con->v2.in_kvecs, 0, 0);
 }
 
 static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
@@ -232,7 +232,7 @@ static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_bvec = *bv;
-	iov_iter_bvec(&con->v2.in_iter, READ, &con->v2.in_bvec, 1, bv->bv_len);
+	iov_iter_bvec(&con->v2.in_iter, ITER_DEST, &con->v2.in_bvec, 1, bv->bv_len);
 }
 
 static void set_in_skip(struct ceph_connection *con, int len)
@@ -240,7 +240,7 @@ static void set_in_skip(struct ceph_connection *con, int len)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	dout("%s con %p len %d\n", __func__, con, len);
-	iov_iter_discard(&con->v2.in_iter, READ, len);
+	iov_iter_discard(&con->v2.in_iter, ITER_DEST, len);
 }
 
 static void add_out_kvec(struct ceph_connection *con, void *buf, int len)
@@ -264,7 +264,7 @@ static void reset_out_kvecs(struct ceph_connection *con)
 
 	con->v2.out_kvec_cnt = 0;
 
-	iov_iter_kvec(&con->v2.out_iter, WRITE, con->v2.out_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.out_iter, ITER_SOURCE, con->v2.out_kvecs, 0, 0);
 	con->v2.out_iter_sendpage = false;
 }
 
@@ -276,7 +276,7 @@ static void set_out_bvec(struct ceph_connection *con, const struct bio_vec *bv,
 
 	con->v2.out_bvec = *bv;
 	con->v2.out_iter_sendpage = zerocopy;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
@@ -289,7 +289,7 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 	con->v2.out_bvec.bv_offset = 0;
 	con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
 	con->v2.out_iter_sendpage = true;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
diff --git a/net/compat.c b/net/compat.c
index 210fc3b4d0d8..bbb0e3cc1f1c 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -98,7 +98,7 @@ int get_compat_msghdr(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE, compat_ptr(ptr), len,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE, compat_ptr(ptr), len,
 			   UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
 }
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 24ace3f94b56..ad5d3090f13f 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -184,7 +184,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", .cap_sys_admin = 1 },
+	{ .name = "events", .flags = GENL_MCAST_CAP_SYS_ADMIN, },
 };
 
 static void send_dm_alert(struct work_struct *work)
diff --git a/net/core/filter.c b/net/core/filter.c
index 87447a7843b5..6a1210abe462 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1641,15 +1641,24 @@ int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk)
 	return err;
 }
 
+static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
+	struct bpf_prog *prog = aux->prog;
+
+	bpf_release_orig_filter(prog);
+	bpf_prog_free(prog);
+}
+
 void sk_reuseport_prog_free(struct bpf_prog *prog)
 {
 	if (!prog)
 		return;
 
-	if (prog->type == BPF_PROG_TYPE_SK_REUSEPORT)
-		bpf_prog_put(prog);
+	if (bpf_prog_was_classic(prog))
+		call_rcu(&prog->aux->rcu, sk_reuseport_prog_free_rcu);
 	else
-		bpf_prog_destroy(prog);
+		bpf_prog_put(prog);
 }
 
 struct bpf_scratchpad {
@@ -2828,7 +2837,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a8d09eff26f1..82add06ca935 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4814,7 +4814,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
 }
 EXPORT_SYMBOL_GPL(skb_cow_data);
 
-static void sock_rmem_free(struct sk_buff *skb)
+void sock_rmem_free(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
 
@@ -4823,8 +4823,8 @@ static void sock_rmem_free(struct sk_buff *skb)
 
 static void skb_set_err_queue(struct sk_buff *skb)
 {
-	/* pkt_type of skbs received on local sockets is never PACKET_OUTGOING.
-	 * So, it is safe to (mis)use it to mark skbs on the error queue.
+	/* The error-queue test in skb_is_err_queue() matches this marker
+	 * with the sock_rmem_free destructor installed by sock_queue_err_skb().
 	 */
 	skb->pkt_type = PACKET_OUTGOING;
 	BUILD_BUG_ON(PACKET_OUTGOING == 0);
@@ -6256,6 +6256,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			kfree(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6404,6 +6406,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		kfree(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb);
 
 	skb->head = data;
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 49c0a2a77f02..6ce40f95d8ab 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -43,6 +43,9 @@ static int fallback_set_params(struct eeprom_req_info *request,
 	if (offset >= modinfo->eeprom_len)
 		return -EINVAL;
 
+	if (length > modinfo->eeprom_len - offset)
+		return -EINVAL;
+
 	eeprom->cmd = ETHTOOL_GMODULEEEPROM;
 	eeprom->len = length;
 	eeprom->offset = offset;
@@ -69,7 +72,7 @@ static int eeprom_fallback(struct eeprom_req_info *request,
 	if (err < 0)
 		return err;
 
-	data = kmalloc(eeprom.len, GFP_KERNEL);
+	data = kzalloc(eeprom.len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	err = ethtool_get_module_eeprom_call(dev, &eeprom, data);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e0aeeeda3c87..0b3d9dfbe6d6 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -123,8 +123,10 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *node;
 	struct hsr_node *tmp;
 
-	list_for_each_entry_safe(node, tmp, node_db, mac_list)
-		kfree(node);
+	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
+		list_del_rcu(&node->mac_list);
+		kfree_rcu(node, rcu_head);
+	}
 }
 
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 0c07662b44c0..4df76ff50699 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -255,6 +255,11 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 
 	pr_debug("package xmit\n");
 
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
 
 	/* We must take a copy of the skb before we modify/replace the ipv6
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 6eea1e9e998d..f37c6813d740 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -27,9 +27,7 @@ static void *ah_alloc_tmp(struct crypto_ahash *ahash, int nfrags,
 {
 	unsigned int len;
 
-	len = size + crypto_ahash_digestsize(ahash) +
-	      (crypto_ahash_alignmask(ahash) &
-	       ~(crypto_tfm_ctx_alignment() - 1));
+	len = size + crypto_ahash_digestsize(ahash);
 
 	len = ALIGN(len, crypto_tfm_ctx_alignment());
 
@@ -46,10 +44,9 @@ static inline u8 *ah_tmp_auth(void *tmp, unsigned int offset)
 	return tmp + offset;
 }
 
-static inline u8 *ah_tmp_icv(struct crypto_ahash *ahash, void *tmp,
-			     unsigned int offset)
+static inline u8 *ah_tmp_icv(void *tmp, unsigned int offset)
 {
-	return PTR_ALIGN((u8 *)tmp + offset, crypto_ahash_alignmask(ahash) + 1);
+	return tmp + offset;
 }
 
 static inline struct ahash_request *ah_tmp_req(struct crypto_ahash *ahash,
@@ -127,9 +124,14 @@ static void ah_output_done(struct crypto_async_request *base, int err)
 	struct iphdr *top_iph = ip_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph = AH_SKB_CB(skb)->tmp;
-	icv = ah_tmp_icv(ahp->ahash, iph, ihl);
+	seqhi = (__be32 *)((char *)iph + ihl);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 
 	top_iph->tos = iph->tos;
@@ -141,7 +143,7 @@ static void ah_output_done(struct crypto_async_request *base, int err)
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
@@ -182,7 +184,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	if (!iph)
 		goto out;
 	seqhi = (__be32 *)((char *)iph + ihl);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
@@ -273,13 +275,18 @@ static void ah_input_done(struct crypto_async_request *base, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int ihl = ip_hdrlen(skb);
 	int ah_hlen = (ah->hdrlen + 2) << 2;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
-	auth_data = ah_tmp_auth(work_iph, ihl);
-	icv = ah_tmp_icv(ahp->ahash, auth_data, ahp->icv_trunc_len);
+	seqhi = (__be32 *)((char *)work_iph + ihl);
+	auth_data = ah_tmp_auth(seqhi, seqhi_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
@@ -374,7 +381,7 @@ static int ah_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	seqhi = (__be32 *)((char *)work_iph + ihl);
 	auth_data = ah_tmp_auth(seqhi, seqhi_len);
-	icv = ah_tmp_icv(ahash, auth_data, ahp->icv_trunc_len);
+	icv = ah_tmp_icv(auth_data, ahp->icv_trunc_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 0b062959871f..27d14f7a7e7e 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -459,8 +459,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index da1b5038bdfd..4afdaaab6162 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -543,6 +543,10 @@ int ip_options_get(struct net *net, struct ip_options_rcu **optp,
 		kfree(opt);
 		return -EINVAL;
 	}
+	if (opt->opt.srr && !ns_capable(net->user_ns, CAP_NET_RAW)) {
+		kfree(opt);
+		return -EPERM;
+	}
 	kfree(*optp);
 	*optp = opt;
 	return 0;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 3737188ba4e1..f535b875a02b 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -194,7 +194,7 @@ EXPORT_SYMBOL_GPL(iptunnel_handle_offloads);
  */
 static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph;
 	struct icmphdr *icmph;
 	struct iphdr *niph;
 	struct ethhdr eh;
@@ -208,7 +208,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, 576 - sizeof(*niph) - sizeof(*icmph));
 	if (err)
@@ -218,7 +217,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	err = skb_cow(skb, sizeof(*niph) + sizeof(*icmph) + ETH_HLEN);
 	if (err)
 		return err;
-
+	iph = ip_hdr(skb);
 	icmph = skb_push(skb, sizeof(*icmph));
 	*icmph = (struct icmphdr) {
 		.type			= ICMP_DEST_UNREACH,
@@ -263,7 +262,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct icmphdr *icmph = icmp_hdr(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 
 	if (mtu < 576 || iph->frag_off != htons(IP_DF))
@@ -274,9 +272,17 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 	    ipv4_is_lbcast(iph->saddr)  || ipv4_is_multicast(iph->saddr))
 		return 0;
 
-	if (iph->protocol == IPPROTO_ICMP && icmp_is_err(icmph->type))
-		return 0;
+	if (iph->protocol == IPPROTO_ICMP) {
+		const struct icmphdr *icmph;
 
+		if (!pskb_network_may_pull(skb, iph->ihl * 4 +
+						offsetofend(struct icmphdr, type)))
+			return 0;
+		iph = ip_hdr(skb);
+		icmph = (void *)iph + iph->ihl * 4;
+		if (icmp_is_err(icmph->type))
+			return 0;
+	}
 	return iptunnel_pmtud_build_icmp(skb, mtu);
 }
 
@@ -290,7 +296,7 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ip6h;
 	struct icmp6hdr *icmp6h;
 	struct ipv6hdr *nip6h;
 	struct ethhdr eh;
@@ -305,7 +311,6 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, IPV6_MIN_MTU - sizeof(*nip6h) - sizeof(*icmp6h));
 	if (err)
@@ -316,6 +321,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (err)
 		return err;
 
+	ip6h = ipv6_hdr(skb);
 	icmp6h = skb_push(skb, sizeof(*icmp6h));
 	*icmp6h = (struct icmp6hdr) {
 		.icmp6_type		= ICMPV6_PKT_TOOBIG,
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 92bc90ee7674..2c39529769f1 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -701,14 +701,12 @@ static int copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct arpt_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct arpt_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1326,9 +1324,8 @@ static int compat_copy_entry_to_user(struct arpt_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct arpt_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_arpt_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_arpt_entry);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index aee7cd584c92..15a9e303a153 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -833,14 +833,12 @@ copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct ipt_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct ipt_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1229,9 +1227,8 @@ compat_copy_entry_to_user(struct ipt_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct ipt_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_ipt_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_ipt_entry);
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 273b64e3f2f9..37d948d64f77 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -118,7 +118,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1f22e72074fd..a7d335ab0004 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1415,10 +1415,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
 	struct ctl_table *table;
 
-	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
 	kfree(table);
+	kfree(net->ipv4.sysctl_local_reserved_ports);
 }
 
 static __net_initdata struct pernet_operations ipv4_sysctl_ops = {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index dbb834d7eaee..280b7a3791ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1886,7 +1886,7 @@ static int receive_fallback_to_copy(struct sock *sk,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  inq, &iov, &msg.msg_iter);
 	if (err)
 		return err;
@@ -1920,7 +1920,7 @@ static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  copylen, &iov, &msg.msg_iter);
 	if (err)
 		return err;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 43415de60d7f..7e4a9090abd7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -78,6 +78,7 @@
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
@@ -763,7 +764,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 
 	}
@@ -1467,7 +1468,7 @@ static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
 				      hash_expected,
 				      NULL, skb);
 
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s L3 index %d\n",
 				     &iph->saddr, ntohs(th->source),
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4b50898e45be..df749b2f2ecd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1502,15 +1502,17 @@ static inline int ipv6_saddr_preferred(int type)
 	return 0;
 }
 
-static bool ipv6_use_optimistic_addr(struct net *net,
-				     struct inet6_dev *idev)
+static bool ipv6_use_optimistic_addr(const struct net *net,
+				     const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
-	if (!net->ipv6.devconf_all->use_optimistic && !idev->cnf.use_optimistic)
+	if (!READ_ONCE(net->ipv6.devconf_all->use_optimistic) &&
+	    !READ_ONCE(idev->cnf.use_optimistic))
 		return false;
 
 	return true;
@@ -1519,13 +1521,14 @@ static bool ipv6_use_optimistic_addr(struct net *net,
 #endif
 }
 
-static bool ipv6_allow_optimistic_dad(struct net *net,
-				      struct inet6_dev *idev)
+static bool ipv6_allow_optimistic_dad(const struct net *net,
+				      const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
 
 	return true;
@@ -1807,7 +1810,7 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 		idev = __in6_dev_get(dst_dev);
 		if ((dst_type & IPV6_ADDR_MULTICAST) ||
 		    dst.scope <= IPV6_ADDR_SCOPE_LINKLOCAL ||
-		    (idev && idev->cnf.use_oif_addrs_only)) {
+		    (idev && READ_ONCE(idev->cnf.use_oif_addrs_only))) {
 			use_oif_addr = true;
 		}
 	}
@@ -2631,8 +2634,8 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		};
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-		if ((net->ipv6.devconf_all->optimistic_dad ||
-		     in6_dev->cnf.optimistic_dad) &&
+		if ((READ_ONCE(net->ipv6.devconf_all->optimistic_dad) ||
+		     READ_ONCE(in6_dev->cnf.optimistic_dad)) &&
 		    !net->ipv6.devconf_all->forwarding && sllao)
 			cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3229,8 +3232,8 @@ void addrconf_add_linklocal(struct inet6_dev *idev,
 	struct inet6_ifaddr *ifp;
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	if ((dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad ||
-	     idev->cnf.optimistic_dad) &&
+	if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad) ||
+	     READ_ONCE(idev->cnf.optimistic_dad)) &&
 	    !dev_net(idev->dev)->ipv6.devconf_all->forwarding)
 		cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3798,10 +3801,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 */
 	if (!unregister && !idev->cnf.disable_ipv6) {
 		/* aggregate the system setting and interface setting */
-		int _keep_addr = net->ipv6.devconf_all->keep_addr_on_down;
+		int _keep_addr = READ_ONCE(net->ipv6.devconf_all->keep_addr_on_down);
 
 		if (!_keep_addr)
-			_keep_addr = idev->cnf.keep_addr_on_down;
+			_keep_addr = READ_ONCE(idev->cnf.keep_addr_on_down);
 
 		keep_addr = (_keep_addr > 0);
 	}
@@ -4024,8 +4027,8 @@ static void addrconf_dad_begin(struct inet6_ifaddr *ifp)
 
 	net = dev_net(dev);
 	if (dev->flags&(IFF_NOARP|IFF_LOOPBACK) ||
-	    (net->ipv6.devconf_all->accept_dad < 1 &&
-	     idev->cnf.accept_dad < 1) ||
+	    (READ_ONCE(net->ipv6.devconf_all->accept_dad) < 1 &&
+	     READ_ONCE(idev->cnf.accept_dad) < 1) ||
 	    !(ifp->flags&IFA_F_TENTATIVE) ||
 	    ifp->flags & IFA_F_NODAD) {
 		bool send_na = false;
@@ -4117,8 +4120,8 @@ static void addrconf_dad_work(struct work_struct *w)
 		action = DAD_ABORT;
 		ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
-		if ((dev_net(idev->dev)->ipv6.devconf_all->accept_dad > 1 ||
-		     idev->cnf.accept_dad > 1) &&
+		if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->accept_dad) > 1 ||
+		     READ_ONCE(idev->cnf.accept_dad) > 1) &&
 		    !idev->cnf.disable_ipv6 &&
 		    !(ifp->flags & IFA_F_STABLE_PRIVACY)) {
 			struct in6_addr addr;
@@ -4256,8 +4259,8 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 
 	/* send unsolicited NA if enabled */
 	if (send_na &&
-	    (ifp->idev->cnf.ndisc_notify ||
-	     dev_net(dev)->ipv6.devconf_all->ndisc_notify)) {
+	    (READ_ONCE(ifp->idev->cnf.ndisc_notify) ||
+	     READ_ONCE(dev_net(dev)->ipv6.devconf_all->ndisc_notify))) {
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifp->addr,
 			      /*router=*/ !!ifp->idev->cnf.forwarding,
 			      /*solicited=*/ false, /*override=*/ true,
@@ -6431,7 +6434,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
 
-			net->ipv6.devconf_dflt->addr_gen_mode = new_val;
+			WRITE_ONCE(net->ipv6.devconf_dflt->addr_gen_mode, new_val);
 			for_each_netdev(net, dev) {
 				idev = __in6_dev_get(dev);
 				if (idev &&
@@ -6442,7 +6445,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 			}
 		}
 
-		*((u32 *)ctl->data) = new_val;
+		WRITE_ONCE(*((u32 *)ctl->data), new_val);
 	}
 
 out:
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 589f008dcee9..2d2a7a60e4a8 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -79,9 +79,7 @@ static void *ah_alloc_tmp(struct crypto_ahash *ahash, int nfrags,
 {
 	unsigned int len;
 
-	len = size + crypto_ahash_digestsize(ahash) +
-	      (crypto_ahash_alignmask(ahash) &
-	       ~(crypto_tfm_ctx_alignment() - 1));
+	len = size + crypto_ahash_digestsize(ahash);
 
 	len = ALIGN(len, crypto_tfm_ctx_alignment());
 
@@ -103,10 +101,9 @@ static inline u8 *ah_tmp_auth(u8 *tmp, unsigned int offset)
 	return tmp + offset;
 }
 
-static inline u8 *ah_tmp_icv(struct crypto_ahash *ahash, void *tmp,
-			     unsigned int offset)
+static inline u8 *ah_tmp_icv(void *tmp, unsigned int offset)
 {
-	return PTR_ALIGN((u8 *)tmp + offset, crypto_ahash_alignmask(ahash) + 1);
+	return tmp + offset;
 }
 
 static inline struct ahash_request *ah_tmp_req(struct crypto_ahash *ahash,
@@ -323,14 +320,19 @@ static void ah6_output_done(struct crypto_async_request *base, int err)
 	struct ipv6hdr *top_iph = ipv6_hdr(skb);
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	struct tmp_ext *iph_ext;
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	extlen = skb_network_header_len(skb) - sizeof(struct ipv6hdr);
 	if (extlen)
 		extlen += sizeof(*iph_ext);
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	iph_base = AH_SKB_CB(skb)->tmp;
 	iph_ext = ah_tmp_ext(iph_base);
-	icv = ah_tmp_icv(ahp->ahash, iph_ext, extlen);
+	seqhi = (__be32 *)((char *)iph_ext + extlen);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
@@ -338,7 +340,7 @@ static void ah6_output_done(struct crypto_async_request *base, int err)
 	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
@@ -387,7 +389,7 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 
 	iph_ext = ah_tmp_ext(iph_base);
 	seqhi = (__be32 *)((char *)iph_ext + extlen);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
@@ -477,13 +479,18 @@ static void ah6_input_done(struct crypto_async_request *base, int err)
 	struct ip_auth_hdr *ah = ip_auth_hdr(skb);
 	int hdr_len = skb_network_header_len(skb);
 	int ah_hlen = ipv6_authlen(ah);
+	int seqhi_len = 0;
+	__be32 *seqhi;
 
 	if (err)
 		goto out;
 
+	if (x->props.flags & XFRM_STATE_ESN)
+		seqhi_len = sizeof(*seqhi);
 	work_iph = AH_SKB_CB(skb)->tmp;
 	auth_data = ah_tmp_auth(work_iph, hdr_len);
-	icv = ah_tmp_icv(ahp->ahash, auth_data, ahp->icv_trunc_len);
+	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 
 	err = crypto_memneq(icv, auth_data, ahp->icv_trunc_len) ? -EBADMSG : 0;
 	if (err)
@@ -591,7 +598,7 @@ static int ah6_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	auth_data = ah_tmp_auth((u8 *)work_iph, hdr_len);
 	seqhi = (__be32 *)(auth_data + ahp->icv_trunc_len);
-	icv = ah_tmp_icv(ahash, seqhi, seqhi_len);
+	icv = ah_tmp_icv(seqhi, seqhi_len);
 	req = ah_tmp_req(ahash, icv);
 	sg = ah_req_sg(ahash, req);
 	seqhisg = sg + nfrags;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index d8af31805133..8f772274f0da 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -611,6 +611,18 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	}
 }
 
+static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
+{
+	u16 len;
+
+	if (ptr + 2 > skb_tail_pointer(skb))
+		return 0;
+
+	len = (ptr[1] + 1) << 3;
+
+	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;
+}
+
 void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 				    struct sk_buff *skb)
 {
@@ -637,7 +649,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	/* HbH is allowed only once */
 	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, len, ptr);
 	}
 
 	if (opt->lastopt &&
@@ -658,26 +673,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 			unsigned int len;
 			u8 *ptr = nh + off;
 
+			if (ptr + 2 > skb_tail_pointer(skb))
+				return;
+
 			switch (nexthdr) {
 			case IPPROTO_DSTOPTS:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.dstopts)
 					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
 				break;
 			case IPPROTO_ROUTING:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.srcrt)
 					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 2) << 2;
+				if (ptr + len > skb_tail_pointer(skb))
+					return;
 				break;
 			default:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				break;
 			}
 
@@ -699,19 +725,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	}
 	if (np->rxopt.bits.ohopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst0) {
 		u8 *ptr = nh + opt->dst0;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.osrcrt && opt->srcrt) {
 		struct ipv6_rt_hdr *rthdr = (struct ipv6_rt_hdr *)(nh + opt->srcrt);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, (rthdr->hdrlen+1) << 3, rthdr);
+		u16 len = ipv6_get_exthdr_len(skb, (u8 *)rthdr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, len, rthdr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst1) {
 		u8 *ptr = nh + opt->dst1;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 0aaafc0bd8fa..7e50a58098bb 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -495,8 +495,8 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 343b957e6337..3c6de4ccbf53 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -183,6 +183,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_JUMBO:
 					if (!ipv6_hop_jumbo(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_CALIPSO:
 					if (!ipv6_hop_calipso(skb, off))
@@ -200,6 +202,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_HAO:
 					if (!ipv6_dest_hao(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 #endif
 				default:
@@ -378,9 +382,8 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	accept_seg6 = net->ipv6.devconf_all->seg6_enabled;
-	if (accept_seg6 > idev->cnf.seg6_enabled)
-		accept_seg6 = idev->cnf.seg6_enabled;
+	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
+			  READ_ONCE(idev->cnf.seg6_enabled));
 
 	if (!accept_seg6) {
 		kfree_skb(skb);
@@ -557,7 +560,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
@@ -685,11 +688,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
 	struct net *net = dev_net(skb->dev);
-	int accept_source_route = net->ipv6.devconf_all->accept_source_route;
+	int accept_source_route;
 
 	idev = __in6_dev_get(skb->dev);
-	if (idev && accept_source_route > idev->cnf.accept_source_route)
-		accept_source_route = idev->cnf.accept_source_route;
+	accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
+
+	if (idev)
+		accept_source_route = min(accept_source_route,
+					  READ_ONCE(idev->cnf.accept_source_route));
 
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
@@ -946,14 +952,20 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		goto drop;
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!__in6_dev_get(skb->dev)->cnf.ioam6_enabled)
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index bb7ad0d1cacf..45283e982566 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -645,7 +645,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_namespace *ns,
 				    struct ioam6_trace_hdr *trace,
 				    struct ioam6_schema *sc,
-				    u8 sclen)
+				    unsigned int sclen)
 {
 	struct __kernel_sock_timeval ts;
 	u64 raw64;
@@ -673,7 +673,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -681,7 +681,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -758,7 +758,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
@@ -766,7 +766,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
@@ -863,7 +863,7 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
 			   struct ioam6_trace_hdr *trace)
 {
 	struct ioam6_schema *sc;
-	u8 sclen = 0;
+	unsigned int sclen = 0;
 
 	/* Skip if Overflow flag is set
 	 */
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index c1c29432367c..cf577cc3b48c 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -228,7 +228,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	if (!ipv6_addr_is_multicast(&hdr->daddr) &&
 	    (skb->pkt_type == PACKET_BROADCAST ||
 	     skb->pkt_type == PACKET_MULTICAST) &&
-	    idev->cnf.drop_unicast_in_l2_multicast)
+	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast))
 		goto err;
 
 	/* RFC4291 2.7
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 190aa3b19591..077aae4b1bb3 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -105,6 +105,7 @@ vti6_tnl_lookup(struct net *net, const struct in6_addr *remote,
 	hash = HASH(&any, local);
 	for_each_vti6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
 		if (ipv6_addr_equal(local, &t->parms.laddr) &&
+		    ipv6_addr_any(&t->parms.raddr) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
@@ -112,6 +113,7 @@ vti6_tnl_lookup(struct net *net, const struct in6_addr *remote,
 	hash = HASH(remote, &any);
 	for_each_vti6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
 		if (ipv6_addr_equal(remote, &t->parms.raddr) &&
+		    ipv6_addr_any(&t->parms.laddr) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
@@ -728,10 +730,11 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
 static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
 		       bool keep_mtu)
 {
-	struct net *net = dev_net(t->dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct net *net = t->net;
+	struct vti6_net *ip6n;
 	int err;
 
+	ip6n = net_generic(net, vti6_net_id);
 	vti6_tnl_unlink(ip6n, t);
 	synchronize_net();
 	err = vti6_tnl_change(t, p, keep_mtu);
@@ -840,17 +843,24 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			err = -EPERM;
+			if (!ns_capable(self->net->user_ns, CAP_NET_ADMIN))
+				break;
+			t = vti6_locate(self->net, &p1, false);
 			if (t) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
 				}
 			} else
-				t = netdev_priv(dev);
+				t = self;
 
 			err = vti6_update(t, &p1, false);
+		} else {
+			t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		}
 		if (t) {
 			err = 0;
@@ -1037,11 +1047,12 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	struct ip6_tnl *t;
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct net *net = t->net;
 	struct __ip6_tnl_parm p;
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n;
 
+	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 77a9f17c816b..978e5086b2f5 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -159,9 +159,9 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	int iv;
 
 	if (mld_in_v1_mode(idev))
-		iv = idev->cnf.mldv1_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv1_unsolicited_report_interval);
 	else
-		iv = idev->cnf.mldv2_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv2_unsolicited_report_interval);
 
 	return iv > 0 ? iv : 1;
 }
@@ -1201,15 +1201,15 @@ static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 
 static int mld_force_mld_version(const struct inet6_dev *idev)
 {
+	const struct net *net = dev_net(idev->dev);
+	int all_force;
+
+	all_force = READ_ONCE(net->ipv6.devconf_all->force_mld_version);
 	/* Normally, both are 0 here. If enforcement to a particular is
 	 * being used, individual device enforcement will have a lower
 	 * precedence over 'all' device (.../conf/all/force_mld_version).
 	 */
-
-	if (dev_net(idev->dev)->ipv6.devconf_all->force_mld_version != 0)
-		return dev_net(idev->dev)->ipv6.devconf_all->force_mld_version;
-	else
-		return idev->cnf.force_mld_version;
+	return all_force ?: READ_ONCE(idev->cnf.force_mld_version);
 }
 
 static bool mld_in_v2_mode_only(const struct inet6_dev *idev)
@@ -1392,9 +1392,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1426,8 +1426,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1477,7 +1477,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 74e82982ecd0..5c448867b902 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -450,7 +450,7 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	tclass = idev ? idev->cnf.ndisc_tclass : 0;
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
 	rcu_read_unlock();
 
 	skb_push(skb, sizeof(*hdr));
@@ -538,7 +538,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		src_addr = solicited_addr;
 		if (ifp->flags & IFA_F_OPTIMISTIC)
 			override = false;
-		inc_opt |= ifp->idev->cnf.force_tllao;
+		inc_opt |= READ_ONCE(ifp->idev->cnf.force_tllao);
 		in6_ifa_put(ifp);
 	} else {
 		if (ipv6_dev_get_saddr(dev_net(dev), dev, daddr,
@@ -991,7 +991,7 @@ static void ndisc_recv_na(struct sk_buff *skb)
 	 * and thus should not be accepted.
 	 */
 	if (!msg->icmph.icmp6_solicited && idev &&
-	    idev->cnf.drop_unsolicited_na)
+	    READ_ONCE(idev->cnf.drop_unsolicited_na))
 		return;
 
 	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts)) {
@@ -1749,7 +1749,7 @@ static bool ndisc_suppress_frag_ndisc(struct sk_buff *skb)
 	if (!idev)
 		return true;
 	if (IP6CB(skb)->flags & IP6SKB_FRAGMENTED &&
-	    idev->cnf.suppress_frag_ndisc) {
+	    READ_ONCE(idev->cnf.suppress_frag_ndisc)) {
 		net_warn_ratelimited("Received fragmented ndisc packet. Carefully consider disabling suppress_frag_ndisc.\n");
 		return true;
 	}
@@ -1824,8 +1824,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 		idev = in6_dev_get(dev);
 		if (!idev)
 			break;
-		if (idev->cnf.ndisc_notify ||
-		    net->ipv6.devconf_all->ndisc_notify)
+		if (READ_ONCE(idev->cnf.ndisc_notify) ||
+		    READ_ONCE(net->ipv6.devconf_all->ndisc_notify))
 			ndisc_send_unsol_na(dev);
 		in6_dev_put(idev);
 		break;
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index afd22ea9f555..f2de34f0de23 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -850,14 +850,12 @@ copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct ip6t_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct ip6t_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1246,9 +1244,8 @@ compat_copy_entry_to_user(struct ip6t_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct ip6t_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_ip6t_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_ip6t_entry);
diff --git a/net/ipv6/netfilter/ip6t_eui64.c b/net/ipv6/netfilter/ip6t_eui64.c
index da69a27e8332..bbb684f9964c 100644
--- a/net/ipv6/netfilter/ip6t_eui64.c
+++ b/net/ipv6/netfilter/ip6t_eui64.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/ipv6.h>
+#include <linux/if_arp.h>
 #include <linux/if_ether.h>
 
 #include <linux/netfilter/x_tables.h>
@@ -21,8 +22,10 @@ eui64_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	unsigned char eui64[8];
 
-	if (!(skb_mac_header(skb) >= skb->head &&
-	      skb_mac_header(skb) + ETH_HLEN <= skb->data)) {
+	if (!skb->dev || skb->dev->type != ARPHRD_ETHER)
+		return false;
+
+	if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN) {
 		par->hotdrop = true;
 		return false;
 	}
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index b7e543d4d57b..a8343877fdf7 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -189,7 +189,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		}
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, pkt->skb,
 				      lookup_flags);
 	if (rt->dst.error)
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 68acff337e41..13c7b7f54c40 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -242,6 +242,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	struct sr6_tlv_hmac *tlv;
 	struct ipv6_sr_hdr *srh;
 	struct inet6_dev *idev;
+	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
 	if (!idev)
@@ -251,16 +252,17 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 
 	tlv = seg6_get_tlv_hmac(srh);
 
+	require_hmac = READ_ONCE(idev->cnf.seg6_require_hmac);
 	/* mandatory check but no tlv */
-	if (idev->cnf.seg6_require_hmac > 0 && !tlv)
+	if (require_hmac > 0 && !tlv)
 		return false;
 
 	/* no check */
-	if (idev->cnf.seg6_require_hmac < 0)
+	if (require_hmac < 0)
 		return true;
 
 	/* check only if present */
-	if (idev->cnf.seg6_require_hmac == 0 && !tlv)
+	if (require_hmac == 0 && !tlv)
 		return true;
 
 	/* now, seg6_require_hmac >= 0 && tlv */
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 3bc02ab9ceac..bc5db4a9dbfa 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -971,6 +971,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ip_rt_put(rt);
 		goto tx_error;
 	}
+	iph6 = ipv6_hdr(skb);
 
 	if (df) {
 		mtu = dst_mtu(&rt->dst) - t_hlen;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e1ca8b73ec08..e972bbb75418 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -63,6 +63,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
@@ -810,7 +811,7 @@ static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 				      hash_expected,
 				      NULL, skb);
 
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u L3 index %d\n",
 				     genhash ? "failed" : "mismatch",
@@ -1088,7 +1089,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			goto out;
 
 		genhash = tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 	}
 #endif
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index e6cb3e1cbbf9..3188d719a2e4 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1533,7 +1533,7 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int val;
-	int len;
+	int len, rc;
 
 	if (level != SOL_IUCV)
 		return -ENOPROTOOPT;
@@ -1546,26 +1546,34 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	len = min_t(unsigned int, len, sizeof(int));
 
+	rc = 0;
+
+	lock_sock(sk);
 	switch (optname) {
 	case SO_IPRMDATA_MSG:
 		val = (iucv->flags & IUCV_IPRMDATA) ? 1 : 0;
 		break;
 	case SO_MSGLIMIT:
-		lock_sock(sk);
 		val = (iucv->path != NULL) ? iucv->path->msglim	/* connected */
 					   : iucv->msglimit;	/* default */
-		release_sock(sk);
 		break;
 	case SO_MSGSIZE:
-		if (sk->sk_state == IUCV_OPEN)
-			return -EBADFD;
+		if (sk->sk_state == IUCV_OPEN) {
+			rc = -EBADFD;
+			break;
+		}
 		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
 				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
 				0x7fffffff;
 		break;
 	default:
-		return -ENOPROTOOPT;
+		rc = -ENOPROTOOPT;
+		break;
 	}
+	release_sock(sk);
+
+	if (rc)
+		return rc;
 
 	if (put_user(len, optlen))
 		return -EFAULT;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 638333f1b8c7..68e9beb6ef4b 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3548,7 +3548,7 @@ static int set_ipsecrequest(struct sk_buff *skb,
 #ifdef CONFIG_NET_KEY_MIGRATE
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	int i;
@@ -3653,7 +3653,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* broadcast migrate message to sockets */
-	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, &init_net);
+	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, net);
 
 	return 0;
 
@@ -3664,7 +3664,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/net/mctp/device.c b/net/mctp/device.c
index aec7ffad2666..a11d5aca201c 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -55,6 +55,7 @@ static int mctp_fill_addrinfo(struct sk_buff *skb, struct netlink_callback *cb,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ifa_family = AF_MCTP;
 	hdr->ifa_prefixlen = 0;
 	hdr->ifa_flags = 0;
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index bc75a263719c..18a6be38f172 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -217,6 +217,7 @@ static int mctp_fill_neigh(struct sk_buff *skb, u32 portid, u32 seq, int event,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ndm_family = AF_MCTP;
 	hdr->ndm_ifindex = dev->ifindex;
 	hdr->ndm_state = 0; // TODO other state bits?
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 48d32bfd3863..f087cc73ca35 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -229,6 +229,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	unsigned long f;
 	u8 tag, flags;
 	int rc;
+	u8 ver;
 
 	msk = NULL;
 	rc = -EINVAL;
@@ -246,7 +247,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	mh = mctp_hdr(skb);
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -859,6 +861,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_skb_cb *cb;
 	struct mctp_route *rt;
 	struct mctp_hdr *mh;
+	u8 ver;
 
 	/* basic non-data sanity checks */
 	if (dev->type != ARPHRD_MCTP)
@@ -872,7 +875,8 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto err_drop;
 
 	cb = __mctp_cb(skb);
@@ -1031,6 +1035,7 @@ static int mctp_fill_rtinfo(struct sk_buff *skb, struct mctp_route *rt,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->rtm_family = AF_MCTP;
 
 	/* we use the _len fields as a number of EIDs, rather than
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 85fcc378c711..cd576b40d4db 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -555,7 +555,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret = false;
-	u64 ack_seq;
 
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
@@ -587,14 +586,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	ack_seq = READ_ONCE(msk->ack_seq);
 	if (READ_ONCE(msk->use_64bit_ack)) {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
-		opts->ext_copy.data_ack = ack_seq;
 		opts->ext_copy.ack64 = 1;
 	} else {
 		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
-		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
 		opts->ext_copy.ack64 = 0;
 	}
 	opts->ext_copy.use_ack = 1;
@@ -1235,17 +1231,16 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(const struct tcp_sock *tp, u64 ack_seq)
 {
 	const struct sock *ssk = (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq += tp->rcv_wnd;
 
 	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent))) {
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
@@ -1369,13 +1364,26 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 
 		if (mpext->use_ack) {
+			const struct sock *ssk = (const struct sock *)tp;
+			struct mptcp_subflow_context *subflow;
+			struct mptcp_sock *msk;
+			u64 ack_seq;
+
+			/* DSS option is set only by mptcp_established_options,
+			 * the caller is __tcp_transmit_skb() and ssk is always
+			 * not NULL.
+			 */
+			subflow = mptcp_subflow_ctx(ssk);
+			msk = mptcp_sk(subflow->conn);
+			ack_seq = READ_ONCE(msk->ack_seq);
 			if (mpext->ack64) {
-				put_unaligned_be64(mpext->data_ack, ptr);
+				put_unaligned_be64(ack_seq, ptr);
 				ptr += 2;
 			} else {
-				put_unaligned_be32(mpext->data_ack32, ptr);
+				put_unaligned_be32(ack_seq, ptr);
 				ptr += 1;
 			}
+			mptcp_set_rwin(tp, ack_seq);
 		}
 
 		if (mpext->use_map) {
@@ -1559,9 +1567,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			i += 4;
 		}
 	}
-
-	if (tp)
-		mptcp_set_rwin(tp);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d52e1d295010..737fb96ff690 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -270,6 +270,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
+	bool skip_add_addr = false;
 	int ret = false;
 	u8 add_addr;
 	u8 family;
@@ -291,24 +292,43 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
-
-	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
-	if (remaining < mptcp_add_addr_len(family, *echo, port))
-		goto out_unlock;
-
 	if (*echo) {
 		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
+		port = !!msk->pm.remote.port;
+		family = msk->pm.remote.family;
 	} else {
 		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+		port = !!msk->pm.local.port;
+		family = msk->pm.local.family;
 	}
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
+	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+		if (!*drop_other_suboptions)
+			goto out_unlock;
+
+		if (!*echo)
+			skip_add_addr = true;
+		goto drop_signal_mark;
+	}
+
 	ret = true;
 
+drop_signal_mark:
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
+
 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
+	 * clear the signal bit, cancel the matching retransmission timer, and
+	 * let the PM state machine progress.
+	 */
+	if (skip_add_addr) {
+		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_subflow_established(msk);
+	}
 	return ret;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e99247f906a3..01ecd546e844 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -330,8 +330,15 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		sk_reset_timer(sk, timer, jiffies + HZ);
 		goto out;
 	}
 
@@ -341,7 +348,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal_addr(msk)) {
+	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	 * callback. Once cancel updates retrans_times to MAX, suppress further
+	 * retransmissions here. If this callback acquires pm.lock first, one
+	 * final transmit attempt is still possible.
+	 */
+	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
+	    !mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
@@ -358,6 +371,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 
@@ -384,8 +398,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	/* Note: entry might have been removed by another thread.
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
-	if (stop_timer)
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	if (stop_timer) {
+		if (check_id)
+			sk_stop_timer(sk, &entry->add_timer);
+		else
+			sk_stop_timer_sync(sk, &entry->add_timer);
+	}
 
 	rcu_read_unlock();
 	return entry;
@@ -828,6 +846,9 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!addresses_equal(&local, addr, addr->port))
 			continue;
@@ -1196,7 +1217,7 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 	[MPTCP_PM_CMD_GRP_OFFSET]	= { .name = MPTCP_PM_CMD_GRP_NAME, },
 	[MPTCP_PM_EV_GRP_OFFSET]        = { .name = MPTCP_PM_EV_GRP_NAME,
-					    .flags = GENL_UNS_ADMIN_PERM,
+					    .flags = GENL_MCAST_CAP_NET_ADMIN,
 					  },
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f679ad0f15b..fe22e4f57093 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -329,10 +329,26 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
+
 drop:
 	mptcp_drop(sk, skb);
 	return false;
@@ -2539,6 +2555,10 @@ static void __mptcp_retrans(struct sock *sk)
 
 	release_sock(ssk);
 
+	/* With csum enabled retransmission can send new data. */
+	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
+		WRITE_ONCE(msk->snd_nxt, dfrag->already_sent + dfrag->data_seq);
+
 reset_timer:
 	if (!mptcp_rtx_timer_pending(sk))
 		mptcp_reset_rtx_timer(sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cd4b3c243b02..9e0fd3bffd94 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -231,15 +231,19 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
 
 		lock_sock(ssk);
-		sock_set_timestamping(ssk, optname, timestamping);
+		err = sock_set_timestamping(ssk, optname, timestamping);
 		release_sock(ssk);
+
+		if (err < 0 && ret == 0)
+			ret = err;
 	}
 
 	release_sock(sk);
 
-	return 0;
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,
diff --git a/net/netfilter/ipset/ip_set_bitmap_ipmac.c b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
index 2c625e0f49ec..752f59ef8744 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ipmac.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ipmac.c
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/errno.h>
+#include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
 #include <linux/jiffies.h>
@@ -220,8 +221,8 @@ bitmap_ipmac_kadt(struct ip_set *set, const struct sk_buff *skb,
 		return -IPSET_ERR_BITMAP_RANGE;
 
 	/* Backward compatibility: we don't check the second flag */
-	if (skb_mac_header(skb) < skb->head ||
-	    (skb_mac_header(skb) + ETH_HLEN) > skb->data)
+	if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+	    !skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
 		return -EINVAL;
 
 	e.id = ip_to_id(map, ip);
diff --git a/net/netfilter/ipset/ip_set_hash_ipmac.c b/net/netfilter/ipset/ip_set_hash_ipmac.c
index 467c59a83c0a..b9a2681e2488 100644
--- a/net/netfilter/ipset/ip_set_hash_ipmac.c
+++ b/net/netfilter/ipset/ip_set_hash_ipmac.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/errno.h>
 #include <linux/random.h>
+#include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -89,8 +90,8 @@ hash_ipmac4_kadt(struct ip_set *set, const struct sk_buff *skb,
 	struct hash_ipmac4_elem e = { .ip = 0, { .foo[0] = 0, .foo[1] = 0 } };
 	struct ip_set_ext ext = IP_SET_INIT_KEXT(skb, opt, set);
 
-	if (skb_mac_header(skb) < skb->head ||
-	    (skb_mac_header(skb) + ETH_HLEN) > skb->data)
+	if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+	    !skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
 		return -EINVAL;
 
 	if (opt->flags & IPSET_DIM_TWO_SRC)
@@ -205,8 +206,8 @@ hash_ipmac6_kadt(struct ip_set *set, const struct sk_buff *skb,
 	};
 	struct ip_set_ext ext = IP_SET_INIT_KEXT(skb, opt, set);
 
-	if (skb_mac_header(skb) < skb->head ||
-	    (skb_mac_header(skb) + ETH_HLEN) > skb->data)
+	if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+	    !skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
 		return -EINVAL;
 
 	if (opt->flags & IPSET_DIM_TWO_SRC)
diff --git a/net/netfilter/ipset/ip_set_hash_mac.c b/net/netfilter/ipset/ip_set_hash_mac.c
index 718814730acf..41a122591fe2 100644
--- a/net/netfilter/ipset/ip_set_hash_mac.c
+++ b/net/netfilter/ipset/ip_set_hash_mac.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/errno.h>
+#include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <net/netlink.h>
 
@@ -77,8 +78,8 @@ hash_mac4_kadt(struct ip_set *set, const struct sk_buff *skb,
 	struct hash_mac4_elem e = { { .foo[0] = 0, .foo[1] = 0 } };
 	struct ip_set_ext ext = IP_SET_INIT_KEXT(skb, opt, set);
 
-	if (skb_mac_header(skb) < skb->head ||
-	    (skb_mac_header(skb) + ETH_HLEN) > skb->data)
+	if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+	    !skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
 		return -EINVAL;
 
 	if (opt->flags & IPSET_DIM_ONE_SRC)
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 4c9ef2ae4d68..0805c9083eaa 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1417,7 +1417,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	if (ret_hooks >= 0)
 		ip_vs_unregister_hooks(ipvs, u->af);
 	if (svc != NULL) {
-		ip_vs_unbind_scheduler(svc, sched);
+		ip_vs_unbind_scheduler(svc);
 		ip_vs_service_free(svc);
 	}
 	ip_vs_scheduler_put(sched);
@@ -1479,9 +1479,8 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 	old_sched = rcu_dereference_protected(svc->scheduler, 1);
 	if (sched != old_sched) {
 		if (old_sched) {
-			ip_vs_unbind_scheduler(svc, old_sched);
-			RCU_INIT_POINTER(svc->scheduler, NULL);
-			/* Wait all svc->sched_data users */
+			ip_vs_unbind_scheduler(svc);
+			/* Wait all svc->scheduler/sched_data users */
 			synchronize_rcu();
 		}
 		/* Bind the new scheduler */
@@ -1489,6 +1488,10 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 			ret = ip_vs_bind_scheduler(svc, sched);
 			if (ret) {
 				ip_vs_scheduler_put(sched);
+				/* Try to restore the old_sched */
+				if (old_sched &&
+				    !ip_vs_bind_scheduler(svc, old_sched))
+					old_sched = NULL;
 				goto out;
 			}
 		}
@@ -1545,7 +1548,7 @@ static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup)
 
 	/* Unbind scheduler */
 	old_sched = rcu_dereference_protected(svc->scheduler, 1);
-	ip_vs_unbind_scheduler(svc, old_sched);
+	ip_vs_unbind_scheduler(svc);
 	ip_vs_scheduler_put(old_sched);
 
 	/* Unbind persistence engine, keep svc->pe */
diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index 83e452916403..63c78a1f3918 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -10,7 +10,8 @@
 #include <net/ip_vs.h>
 
 static int
-sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+		unsigned int sctphoff);
 
 static int
 sctp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -108,7 +109,7 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!sctp_csum_check(cp->af, skb, pp))
+		if (!sctp_csum_check(cp->af, skb, pp, sctphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -156,7 +157,7 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!sctp_csum_check(cp->af, skb, pp))
+		if (!sctp_csum_check(cp->af, skb, pp, sctphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -185,19 +186,12 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 }
 
 static int
-sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+		unsigned int sctphoff)
 {
-	unsigned int sctphoff;
 	struct sctphdr *sh;
 	__le32 cmp, val;
 
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		sctphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		sctphoff = ip_hdrlen(skb);
-
 	sh = (struct sctphdr *)(skb->data + sctphoff);
 	cmp = sh->checksum;
 	val = sctp_compute_cksum(skb, sctphoff);
diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index 7da51390cea6..ede4fa3b63f5 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -29,7 +29,8 @@
 #include <net/ip_vs.h>
 
 static int
-tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int tcphoff);
 
 static int
 tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -166,7 +167,7 @@ tcp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -244,7 +245,7 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/*
@@ -301,17 +302,9 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
 static int
-tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int tcphoff)
 {
-	unsigned int tcphoff;
-
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		tcphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		tcphoff = ip_hdrlen(skb);
-
 	switch (skb->ip_summed) {
 	case CHECKSUM_NONE:
 		skb->csum = skb_checksum(skb, tcphoff, skb->len - tcphoff, 0);
@@ -322,7 +315,7 @@ tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 			if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					    &ipv6_hdr(skb)->daddr,
 					    skb->len - tcphoff,
-					    ipv6_hdr(skb)->nexthdr,
+					    IPPROTO_TCP,
 					    skb->csum)) {
 				IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 						 "Failed checksum for");
diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
index 68260d91c988..ffbebda547fc 100644
--- a/net/netfilter/ipvs/ip_vs_proto_udp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
@@ -25,7 +25,8 @@
 #include <net/ip6_checksum.h>
 
 static int
-udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int udphoff);
 
 static int
 udp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -155,7 +156,7 @@ udp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -238,7 +239,7 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -297,17 +298,10 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
 static int
-udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int udphoff)
 {
 	struct udphdr _udph, *uh;
-	unsigned int udphoff;
-
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		udphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		udphoff = ip_hdrlen(skb);
 
 	uh = skb_header_pointer(skb, udphoff, sizeof(_udph), &_udph);
 	if (uh == NULL)
@@ -325,7 +319,7 @@ udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 				if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 						    &ipv6_hdr(skb)->daddr,
 						    skb->len - udphoff,
-						    ipv6_hdr(skb)->nexthdr,
+						    IPPROTO_UDP,
 						    skb->csum)) {
 					IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 							 "Failed checksum for");
diff --git a/net/netfilter/ipvs/ip_vs_sched.c b/net/netfilter/ipvs/ip_vs_sched.c
index d4903723be7e..49b2e5d2b2c8 100644
--- a/net/netfilter/ipvs/ip_vs_sched.c
+++ b/net/netfilter/ipvs/ip_vs_sched.c
@@ -57,19 +57,19 @@ int ip_vs_bind_scheduler(struct ip_vs_service *svc,
 /*
  *  Unbind a service with its scheduler
  */
-void ip_vs_unbind_scheduler(struct ip_vs_service *svc,
-			    struct ip_vs_scheduler *sched)
+void ip_vs_unbind_scheduler(struct ip_vs_service *svc)
 {
-	struct ip_vs_scheduler *cur_sched;
+	struct ip_vs_scheduler *sched;
 
-	cur_sched = rcu_dereference_protected(svc->scheduler, 1);
-	/* This check proves that old 'sched' was installed */
-	if (!cur_sched)
+	sched = rcu_dereference_protected(svc->scheduler, 1);
+	if (!sched)
 		return;
 
+	/* Reset the scheduler before initiating any RCU callbacks */
+	rcu_assign_pointer(svc->scheduler, NULL);
+	smp_wmb();	/* paired with smp_rmb() in ip_vs_schedule() */
 	if (sched->done_service)
 		sched->done_service(svc);
-	/* svc->scheduler can be set to NULL only by caller */
 }
 
 
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 0c061f94d695..e1dea9a82050 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1617,7 +1617,7 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 	EnterFunction(7);
 
 	/* Receive a packet */
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, buflen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, buflen);
 	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 	if (len < 0)
 		return len;
diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 159e1e4441a4..7a0c645a11c3 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -202,7 +202,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 			if (parse_dcc(data, data_limit, &dcc_ip,
 				       &dcc_port, &addr_beg_p, &addr_end_p)) {
 				pr_debug("unable to parse dcc command\n");
-				continue;
+				goto out;
 			}
 
 			pr_debug("DCC bound ip/port: %pI4:%u\n",
@@ -216,7 +216,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 				net_warn_ratelimited("Forged DCC command from %pI4: %pI4:%u\n",
 						     &tuple->src.u3.ip,
 						     &dcc_ip, dcc_port);
-				continue;
+				goto out;
 			}
 
 			exp = nf_ct_expect_alloc(ct);
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 10bd7f604ebb..7c8012f4c8de 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1170,7 +1170,8 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			new_state = old_state;
 		}
 		if (((test_bit(IPS_SEEN_REPLY_BIT, &ct->status)
-			 && ct->proto.tcp.last_index == TCP_SYN_SET)
+			 && ct->proto.tcp.last_index == TCP_SYN_SET
+			 && ct->proto.tcp.last_dir != dir)
 			|| (!test_bit(IPS_ASSURED_BIT, &ct->status)
 			    && ct->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == ct->proto.tcp.last_end) {
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 7000e069bc07..cae95c7963d7 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -72,7 +72,10 @@ dump_arp_packet(struct nf_log_buf *m,
 	else
 		logflags = NF_LOG_DEFAULT_MASK;
 
-	if (logflags & NF_LOG_MACDECODE) {
+	if ((logflags & NF_LOG_MACDECODE) &&
+	    skb->dev && skb->dev->type == ARPHRD_ETHER &&
+	    skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) >= ETH_HLEN) {
 		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
 			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
 		nf_log_dump_vlan(m, skb);
@@ -781,6 +784,9 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
 
 	switch (dev->type) {
 	case ARPHRD_ETHER:
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
+			return;
+
 		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
 			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
 		nf_log_dump_vlan(m, skb);
@@ -793,8 +799,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int i;
 
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 049a88f03801..91d3e3eea1be 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -21,6 +21,8 @@
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <net/netfilter/nf_synproxy.h>
 
+static DEFINE_MUTEX(synproxy_mutex);
+
 unsigned int synproxy_net_id;
 EXPORT_SYMBOL_GPL(synproxy_net_id);
 
@@ -199,6 +201,8 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 	if (skb_ensure_writable(skb, optend))
 		return 0;
 
+	th = (struct tcphdr *)(skb->data + protoff);
+
 	while (optoff < optend) {
 		unsigned char *op = skb->data + optoff;
 
@@ -788,26 +792,31 @@ static const struct nf_hook_ops ipv4_synproxy_ops[] = {
 
 int nf_synproxy_ipv4_init(struct synproxy_net *snet, struct net *net)
 {
-	int err;
+	int err = 0;
 
+	mutex_lock(&synproxy_mutex);
 	if (snet->hook_ref4 == 0) {
 		err = nf_register_net_hooks(net, ipv4_synproxy_ops,
 					    ARRAY_SIZE(ipv4_synproxy_ops));
 		if (err)
-			return err;
+			goto out;
 	}
 
 	snet->hook_ref4++;
-	return 0;
+out:
+	mutex_unlock(&synproxy_mutex);
+	return err;
 }
 EXPORT_SYMBOL_GPL(nf_synproxy_ipv4_init);
 
 void nf_synproxy_ipv4_fini(struct synproxy_net *snet, struct net *net)
 {
+	mutex_lock(&synproxy_mutex);
 	snet->hook_ref4--;
 	if (snet->hook_ref4 == 0)
 		nf_unregister_net_hooks(net, ipv4_synproxy_ops,
 					ARRAY_SIZE(ipv4_synproxy_ops));
+	mutex_unlock(&synproxy_mutex);
 }
 EXPORT_SYMBOL_GPL(nf_synproxy_ipv4_fini);
 
@@ -1212,27 +1221,32 @@ static const struct nf_hook_ops ipv6_synproxy_ops[] = {
 int
 nf_synproxy_ipv6_init(struct synproxy_net *snet, struct net *net)
 {
-	int err;
+	int err = 0;
 
+	mutex_lock(&synproxy_mutex);
 	if (snet->hook_ref6 == 0) {
 		err = nf_register_net_hooks(net, ipv6_synproxy_ops,
 					    ARRAY_SIZE(ipv6_synproxy_ops));
 		if (err)
-			return err;
+			goto out;
 	}
 
 	snet->hook_ref6++;
-	return 0;
+out:
+	mutex_unlock(&synproxy_mutex);
+	return err;
 }
 EXPORT_SYMBOL_GPL(nf_synproxy_ipv6_init);
 
 void
 nf_synproxy_ipv6_fini(struct synproxy_net *snet, struct net *net)
 {
+	mutex_lock(&synproxy_mutex);
 	snet->hook_ref6--;
 	if (snet->hook_ref6 == 0)
 		nf_unregister_net_hooks(net, ipv6_synproxy_ops,
 					ARRAY_SIZE(ipv6_synproxy_ops));
+	mutex_unlock(&synproxy_mutex);
 }
 EXPORT_SYMBOL_GPL(nf_synproxy_ipv6_fini);
 #endif /* CONFIG_IPV6 */
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 7c2931e024bb..e8978a0aa740 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -454,6 +454,9 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
+	if ((flags & NFT_EXTHDR_F_PRESENT) && len != 1)
+		return -EINVAL;
+
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 1fd4b2054e8f..6b4dc8d9eb67 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -105,6 +105,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
+	if (priv->flags & NFTA_FIB_F_PRESENT) {
+		if (priv->result != NFT_FIB_RESULT_OIF)
+			return -EINVAL;
+		len = sizeof(u8);
+	}
+
 	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
 				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 95f823032228..b2c6e30ccd76 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -669,7 +669,7 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_tunnel_obj *priv = nft_obj_data(obj);
 
-	metadata_dst_free(priv->md);
+	dst_release(&priv->md->dst);
 }
 
 static struct nft_object_type nft_tunnel_obj_type;
diff --git a/net/netfilter/xt_NFQUEUE.c b/net/netfilter/xt_NFQUEUE.c
index 466da23e36ff..b32d153e3a18 100644
--- a/net/netfilter/xt_NFQUEUE.c
+++ b/net/netfilter/xt_NFQUEUE.c
@@ -91,7 +91,7 @@ nfqueue_tg_v3(struct sk_buff *skb, const struct xt_action_param *par)
 
 	if (info->queues_total > 1) {
 		if (info->flags & NFQ_FLAG_CPU_FANOUT) {
-			int cpu = smp_processor_id();
+			int cpu = raw_smp_processor_id();
 
 			queue = info->queuenum + cpu % info->queues_total;
 		} else {
diff --git a/net/netfilter/xt_cpu.c b/net/netfilter/xt_cpu.c
index 3bdc302a0f91..9cb259902a58 100644
--- a/net/netfilter/xt_cpu.c
+++ b/net/netfilter/xt_cpu.c
@@ -34,7 +34,7 @@ static bool cpu_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_cpu_info *info = par->matchinfo;
 
-	return (info->cpu == smp_processor_id()) ^ info->invert;
+	return (info->cpu == raw_smp_processor_id()) ^ info->invert;
 }
 
 static struct xt_match cpu_mt_reg __read_mostly = {
diff --git a/net/netfilter/xt_mac.c b/net/netfilter/xt_mac.c
index bd2354760895..7fc5156825e4 100644
--- a/net/netfilter/xt_mac.c
+++ b/net/netfilter/xt_mac.c
@@ -29,9 +29,7 @@ static bool mac_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 	if (skb->dev == NULL || skb->dev->type != ARPHRD_ETHER)
 		return false;
-	if (skb_mac_header(skb) < skb->head)
-		return false;
-	if (skb_mac_header(skb) + ETH_HLEN > skb->data)
+	if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) < ETH_HLEN)
 		return false;
 	ret  = ether_addr_equal(eth_hdr(skb)->h_source, info->srcaddr);
 	ret ^= info->invert;
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 566ba4397ee4..4c4b91ce446d 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -114,14 +114,14 @@ static struct genl_family netlbl_unlabel_gnl_family;
 /* NetLabel Netlink attribute policy */
 static const struct nla_policy netlbl_unlabel_genl_policy[NLBL_UNLABEL_A_MAX + 1] = {
 	[NLBL_UNLABEL_A_ACPTFLG] = { .type = NLA_U8 },
-	[NLBL_UNLABEL_A_IPV6ADDR] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in6_addr) },
-	[NLBL_UNLABEL_A_IPV6MASK] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in6_addr) },
-	[NLBL_UNLABEL_A_IPV4ADDR] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in_addr) },
-	[NLBL_UNLABEL_A_IPV4MASK] = { .type = NLA_BINARY,
-				      .len = sizeof(struct in_addr) },
+	[NLBL_UNLABEL_A_IPV6ADDR] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[NLBL_UNLABEL_A_IPV6MASK] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[NLBL_UNLABEL_A_IPV4ADDR] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
+	[NLBL_UNLABEL_A_IPV4MASK] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
 	[NLBL_UNLABEL_A_IFACE] = { .type = NLA_NUL_STRING,
 				   .len = IFNAMSIZ - 1 },
 	[NLBL_UNLABEL_A_SECCTX] = { .type = NLA_BINARY }
@@ -764,24 +764,14 @@ static int netlbl_unlabel_addrinfo_get(struct genl_info *info,
 				       void **mask,
 				       u32 *len)
 {
-	u32 addr_len;
-
 	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR] &&
 	    info->attrs[NLBL_UNLABEL_A_IPV4MASK]) {
-		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
-		if (addr_len != sizeof(struct in_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
-			return -EINVAL;
-		*len = addr_len;
+		*len = sizeof(struct in_addr);
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
 		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4MASK]);
 		return 0;
 	} else if (info->attrs[NLBL_UNLABEL_A_IPV6ADDR]) {
-		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
-		if (addr_len != sizeof(struct in6_addr) &&
-		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
-			return -EINVAL;
-		*len = addr_len;
+		*len = sizeof(struct in6_addr);
 		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
 		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6MASK]);
 		return 0;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 65eb164d00c4..731c53178eb5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,9 +1482,14 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
-	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
-	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
-		NETLINK_CB(p->skb2).nsid_is_set = true;
+
+	NETLINK_CB(p->skb2).nsid_is_set = false;
+	if (!net_eq(sock_net(sk), p->net)) {
+		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
+		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
+			NETLINK_CB(p->skb2).nsid_is_set = true;
+	}
+
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 789cdc1dbcdf..7a568292e0d1 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1372,10 +1372,10 @@ static int genl_bind(struct net *net, int group)
 			continue;
 
 		grp = &family->mcgrps[i];
-		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
-		if (grp->cap_sys_admin &&
+		if ((grp->flags & GENL_MCAST_CAP_SYS_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ceb87db57cdb..7fc8f20e0d54 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -861,6 +861,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *frag_skb;
 	int msg_len;
 
+	if (!pskb_may_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)skb->data;
 	if ((packet->header & ~NFC_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&hdev->rx_hcp_frags, skb);
@@ -904,6 +909,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NFC_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index e04634f22b49..c7de44637e01 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1225,6 +1225,15 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 
 	sk = &llcp_sock->sk;
 
+	lock_sock(sk);
+
+	/* Check if socket was destroyed whilst waiting for the lock */
+	if (!sk_hashed(sk)) {
+		release_sock(sk);
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
+
 	/* Unlink from connecting and link to the client array */
 	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	nfc_llcp_sock_link(&local->sockets, sk);
@@ -1236,6 +1245,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 	sk->sk_state = LLCP_CONNECTED;
 	sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	nfc_llcp_sock_put(llcp_sock);
 }
 
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 6e1fba208493..54af85d939c6 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -640,6 +640,8 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else if (sk->sk_state == LLCP_CONNECTING)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	else
 		nfc_llcp_sock_unlink(&local->sockets, sk);
 
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 93ebb703144a..33a870946385 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -439,6 +439,11 @@ void nci_hci_data_received_cb(void *context,
 		return;
 	}
 
+	if (!pskb_may_pull(skb, NCI_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)skb->data;
 	if ((packet->header & ~NCI_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&ndev->hci_dev->rx_hcp_frags, skb);
@@ -482,6 +487,11 @@ void nci_hci_data_received_cb(void *context,
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NCI_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 16ee704bab04..0202111cda35 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1261,6 +1261,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
+			reply = NULL;
 			goto err_unlock_ovs;
 		}
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d1ad069271f8..e0ea02e86b38 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2729,7 +2729,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2829,16 +2830,20 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
-			vnet_hdr = data;
-			data += sizeof(*vnet_hdr);
-			tp_len -= sizeof(*vnet_hdr);
-			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			data += sizeof(vnet_hdr);
+			tp_len -= sizeof(vnet_hdr);
+			if (tp_len < 0) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			memcpy(&vnet_hdr, data - sizeof(vnet_hdr), sizeof(vnet_hdr));
+			if (__packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2875,12 +2880,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			}
 		}
 
-		if (po->has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 0d9d9936579e..f93fcebd0cf0 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -32,7 +32,7 @@ enum psample_nl_multicast_groups {
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
 	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
-				      .flags = GENL_UNS_ADMIN_PERM },
+				      .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 431fd1f2b80c..6f4b901afc33 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -702,13 +702,13 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
 	if (port == QRTR_PORT_CTRL)
 		port = 0;
 
-	__sock_put(&ipc->sk);
-
 	xa_erase(&qrtr_ports, port);
 
 	/* Ensure that if qrtr_port_lookup() did enter the RCU read section we
 	 * wait for it to up increment the refcount */
 	synchronize_rcu();
+
+	__sock_put(&ipc->sk);
 }
 
 /* Assign port number to socket.
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index c41e7b3b2fc2..559aad0e3621 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -21,6 +21,7 @@ static struct {
 	struct socket *sock;
 	struct sockaddr_qrtr bcast_sq;
 	struct list_head lookups;
+	u32 lookup_count;
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
 	void (*saved_data_ready)(struct sock *sk);
@@ -66,9 +67,24 @@ struct qrtr_server {
 
 struct qrtr_node {
 	unsigned int id;
-	struct radix_tree_root servers;
+	struct xarray servers;
 };
 
+/* Max lookup limit is chosen based on the current platform requirements. If the
+ * requirement changes in the future, this value can be increased.
+ */
+#define QRTR_NS_MAX_LOOKUPS 64
+
+/* Max nodes, server, lookup limits are chosen based on the current platform
+ * requirements. If the requirement changes in the future, these values can be
+ * increased.
+ */
+#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_SERVERS 256
+#define QRTR_NS_MAX_LOOKUPS 64
+
+static u8 node_count;
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -77,18 +93,26 @@ static struct qrtr_node *node_get(unsigned int node_id)
 	if (node)
 		return node;
 
+	if (node_count >= QRTR_NS_MAX_NODES) {
+		pr_err_ratelimited("QRTR clients exceed max node limit!\n");
+		return NULL;
+	}
+
 	/* If node didn't exist, allocate and insert it to the tree */
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
 	node->id = node_id;
+	xa_init(&node->servers);
 
 	if (radix_tree_insert(&nodes, node_id, node)) {
 		kfree(node);
 		return NULL;
 	}
 
+	node_count++;
+
 	return node;
 }
 
@@ -193,40 +217,23 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
-	struct radix_tree_iter iter;
 	struct qrtr_server *srv;
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	int ret;
 
 	node = node_get(qrtr_ns.local_node);
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Announce the list of servers registered in this node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&node->servers, index, srv) {
 		ret = service_announce_new(sq, srv);
 		if (ret < 0) {
 			pr_err("failed to announce new service\n");
 			return ret;
 		}
-
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -256,14 +263,17 @@ static struct qrtr_server *server_add(unsigned int service,
 		goto err;
 
 	/* Delete the old server on the same port */
-	old = radix_tree_lookup(&node->servers, port);
+	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
-		radix_tree_delete(&node->servers, port);
-		kfree(old);
+		if (xa_is_err(old)) {
+			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
+			       srv->service, srv->instance, xa_err(old));
+			goto err;
+		} else {
+			kfree(old);
+		}
 	}
 
-	radix_tree_insert(&node->servers, port, srv);
-
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
 				 srv->node, srv->port);
 
@@ -280,11 +290,11 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	struct qrtr_server *srv;
 	struct list_head *li;
 
-	srv = radix_tree_lookup(&node->servers, port);
+	srv = xa_load(&node->servers, port);
 	if (!srv)
 		return -ENOENT;
 
-	radix_tree_delete(&node->servers, port);
+	xa_erase(&node->servers, port);
 
 	/* Broadcast the removal of local servers */
 	if (srv->node == qrtr_ns.local_node && bcast)
@@ -344,15 +354,14 @@ static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_ctrl_pkt pkt;
 	struct qrtr_server *srv;
 	struct sockaddr_qrtr sq;
 	struct msghdr msg = { };
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
-	int ret;
+	int ret = 0;
 
 	iv.iov_base = &pkt;
 	iv.iov_len = sizeof(pkt);
@@ -361,44 +370,22 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Advertise removal of this client to all servers of remote node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
+	xa_for_each(&node->servers, index, srv)
 		server_del(node, srv->port, true);
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
 
 	/* Advertise the removal of this client to all local servers */
 	local_node = node_get(qrtr_ns.local_node);
-	if (!local_node)
-		return 0;
+	if (!local_node) {
+		ret = 0;
+		goto delete_node;
+	}
 
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.cmd = cpu_to_le32(QRTR_TYPE_BYE);
 	pkt.client.node = cpu_to_le32(from->sq_node);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -409,21 +396,24 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
 		if (ret < 0) {
 			pr_err("failed to send bye cmd\n");
-			return ret;
+			goto delete_node;
 		}
-		rcu_read_lock();
 	}
 
-	rcu_read_unlock();
+	/* Ignore -ENODEV */
+	ret = 0;
 
-	return 0;
+delete_node:
+	xa_erase(&nodes, from->sq_node);
+	kfree(node);
+
+	return ret;
 }
 
 static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			       unsigned int node_id, unsigned int port)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_lookup *lookup;
 	struct qrtr_ctrl_pkt pkt;
 	struct msghdr msg = { };
@@ -432,7 +422,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	struct qrtr_node *node;
 	struct list_head *tmp;
 	struct list_head *li;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
 	int ret;
 
@@ -457,6 +447,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 
 		list_del(&lookup->li);
 		kfree(lookup);
+		qrtr_ns.lookup_count--;
 	}
 
 	/* Remove the server belonging to this port but don't broadcast
@@ -477,18 +468,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	pkt.client.node = cpu_to_le32(node_id);
 	pkt.client.port = cpu_to_le32(port);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -501,11 +481,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			pr_err("failed to send del client cmd\n");
 			return ret;
 		}
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -578,18 +554,22 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 			       unsigned int service, unsigned int instance)
 {
-	struct radix_tree_iter node_iter;
 	struct qrtr_server_filter filter;
-	struct radix_tree_iter srv_iter;
 	struct qrtr_lookup *lookup;
+	struct qrtr_server *srv;
 	struct qrtr_node *node;
-	void __rcu **node_slot;
-	void __rcu **srv_slot;
+	unsigned long node_idx;
+	unsigned long srv_idx;
 
 	/* Accept only local observers */
 	if (from->sq_node != qrtr_ns.local_node)
 		return -EINVAL;
 
+	if (qrtr_ns.lookup_count >= QRTR_NS_MAX_LOOKUPS) {
+		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
+		return -ENOSPC;
+	}
+
 	lookup = kzalloc(sizeof(*lookup), GFP_KERNEL);
 	if (!lookup)
 		return -ENOMEM;
@@ -598,45 +578,20 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	lookup->service = service;
 	lookup->instance = instance;
 	list_add_tail(&lookup->li, &qrtr_ns.lookups);
+	qrtr_ns.lookup_count++;
 
 	memset(&filter, 0, sizeof(filter));
 	filter.service = service;
 	filter.instance = instance;
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(node_slot, &nodes, &node_iter, 0) {
-		node = radix_tree_deref_slot(node_slot);
-		if (!node)
-			continue;
-		if (radix_tree_deref_retry(node)) {
-			node_slot = radix_tree_iter_retry(&node_iter);
-			continue;
-		}
-		node_slot = radix_tree_iter_resume(node_slot, &node_iter);
-
-		radix_tree_for_each_slot(srv_slot, &node->servers,
-					 &srv_iter, 0) {
-			struct qrtr_server *srv;
-
-			srv = radix_tree_deref_slot(srv_slot);
-			if (!srv)
-				continue;
-			if (radix_tree_deref_retry(srv)) {
-				srv_slot = radix_tree_iter_retry(&srv_iter);
-				continue;
-			}
-
+	xa_for_each(&nodes, node_idx, node) {
+		xa_for_each(&node->servers, srv_idx, srv) {
 			if (!server_match(srv, &filter))
 				continue;
 
-			srv_slot = radix_tree_iter_resume(srv_slot, &srv_iter);
-
-			rcu_read_unlock();
 			lookup_notify(from, srv, true);
-			rcu_read_lock();
 		}
 	}
-	rcu_read_unlock();
 
 	/* Empty notification, to indicate end of listing */
 	lookup_notify(from, NULL, true);
@@ -664,6 +619,7 @@ static void ctrl_cmd_del_lookup(struct sockaddr_qrtr *from,
 
 		list_del(&lookup->li);
 		kfree(lookup);
+		qrtr_ns.lookup_count--;
 	}
 }
 
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 26b069e1999d..5289afbb61aa 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -656,6 +656,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 
 sends_out:
 	vfree(ic->i_sends);
+	ic->i_sends = NULL;
 
 ack_dma_out:
 	rds_dma_hdr_free(rds_ibdev->dev, ic->i_ack, ic->i_ack_dma,
diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index 4190b90ff3b1..1909cd440a4b 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -170,6 +170,8 @@ static struct rds_message *rds_ib_send_unmap_op(struct rds_ib_connection *ic,
 		break;
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
 	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
 		if (send->s_op) {
 			rm = container_of(send->s_op, struct rds_message, atomic);
 			rds_ib_send_unmap_atomic(ic, send->s_op, wc_status);
diff --git a/net/rds/info.c b/net/rds/info.c
index b6b46a8214a0..b3ee5f8238c4 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -235,7 +235,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 out:
 	if (pages)
-		unpin_user_pages(pages, nr_pages);
+		unpin_user_pages_dirty_lock(pages, nr_pages, true);
 	kfree(pages);
 
 	return ret;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 0b4deb33bdf7..20944a2e162e 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -109,11 +109,6 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 }
 EXPORT_SYMBOL(tcf_action_set_ctrlact);
 
-/* XXX: For standalone actions, we don't need a RCU grace period either, because
- * actions are always connected to filters and filters are already destroyed in
- * RCU callbacks, so after a RCU grace period actions are already disconnected
- * from filters. Readers later can not find us.
- */
 static void free_tcf(struct tc_action *p)
 {
 	struct tcf_chain *chain = rcu_dereference_protected(p->goto_chain, 1);
@@ -126,7 +121,7 @@ static void free_tcf(struct tc_action *p)
 	if (chain)
 		tcf_chain_put_by_act(chain);
 
-	kfree(p);
+	kfree_rcu(p, tcfa_rcu);
 }
 
 static void tcf_action_cleanup(struct tc_action *p)
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a4ffee135c85..60249d7b333a 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -72,9 +72,13 @@ static int fw_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			}
 		}
 	} else {
-		struct Qdisc *q = tcf_block_q(tp->chain->block);
+		struct Qdisc *q;
 
 		/* Old method: classify the packet using its skb mark. */
+		if (tcf_block_shared(tp->chain->block))
+			return -1;
+
+		q = tcf_block_q(tp->chain->block);
 		if (id && (TC_H_MAJ(id) == 0 ||
 			   !(TC_H_MAJ(id ^ q->handle)))) {
 			res->classid = id;
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 497bc022fc0c..45787f7d8647 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -439,7 +439,7 @@ static struct sk_buff *sfb_dequeue(struct Qdisc *sch)
 	struct Qdisc *child = q->qdisc;
 	struct sk_buff *skb;
 
-	skb = child->dequeue(q->qdisc);
+	skb = qdisc_dequeue_peeked(child);
 
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 2cf5ee7a698e..dccf4509190c 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -266,15 +266,15 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 
 	lock_sock(sk);
 
-	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
-	if (!rep) {
-		release_sock(sk);
-		return -ENOMEM;
+	if (ep != assoc->ep || assoc->base.dead) {
+		err = -ESTALE;
+		goto out_unlock;
 	}
 
-	if (ep != assoc->ep) {
-		err = -EAGAIN;
-		goto out;
+	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
+	if (!rep) {
+		err = -ENOMEM;
+		goto out_unlock;
 	}
 
 	err = inet_sctp_diag_fill(sk, assoc, rep, req, sk_user_ns(NETLINK_CB(skb).sk),
@@ -289,8 +289,9 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 	return nlmsg_unicast(sock_net(skb->sk)->diag_nlsk, rep, NETLINK_CB(skb).portid);
 
 out:
-	release_sock(sk);
 	kfree_skb(rep);
+out_unlock:
+	release_sock(sk);
 	return err;
 }
 
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 182898cb754a..70530cbe57d0 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1197,6 +1197,14 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.
+	 */
+	if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 2f9f24b18852..3ca6b7b81124 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2583,11 +2583,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 	 */
 	sctp_add_cmd_sf(commands, SCTP_CMD_DEL_NON_PRIMARY, SCTP_NULL());
 
-	/* If we've sent any data bundled with COOKIE-ECHO we will need to
-	 * resend
-	 */
-	sctp_add_cmd_sf(commands, SCTP_CMD_T1_RETRAN,
-			SCTP_TRANSPORT(asoc->peer.primary_path));
+	sctp_add_cmd_sf(commands, SCTP_CMD_PURGE_OUTQUEUE, SCTP_NULL());
 
 	/* Cast away the const modifier, as we want to just
 	 * rerun it through as a sideffect.
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 11040232ee93..136b122d87c5 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9369,6 +9369,8 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 0527728aee98..d38e5431f359 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -1038,6 +1038,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 			stsn, rtsn, GFP_ATOMIC);
 	} else if (req->type == SCTP_PARAM_RESET_ADD_OUT_STREAMS) {
 		struct sctp_strreset_addstrm *addstrm;
+		const struct sctp_sched_ops *sched;
 		__u16 number;
 
 		addstrm = (struct sctp_strreset_addstrm *)req;
@@ -1048,7 +1049,10 @@ struct sctp_chunk *sctp_process_strreset_resp(
 			for (i = number; i < stream->outcnt; i++)
 				SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
 		} else {
-			sctp_stream_shrink_out(stream, number);
+			sched = sctp_sched_ops_from_stream(stream);
+			sched->unsched_all(stream);
+			sctp_stream_outq_migrate(stream, NULL, number);
+			sched->sched_all(stream);
 			stream->outcnt = number;
 		}
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5425c46a2e7c..6b60a5dd240d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -123,10 +123,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 
 static struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 static struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 int smc_hash_sk(struct sock *sk)
@@ -2938,8 +2940,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 757ba06fa9d9..fb214faf5f98 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -361,7 +361,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
 	clc_sk->sk_rcvtimeo = timeout;
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1,
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (signal_pending(current)) {
@@ -408,7 +408,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	} else {
 		recvlen = datlen;
 	}
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 	krflags = MSG_WAITALL;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < recvlen || !smc_clc_msg_hdr_valid(clcm, check_trl)) {
@@ -425,7 +425,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		/* receive remaining proposal message */
 		recvlen = datlen > SMC_CLC_RECV_BUF_LEN ?
 						SMC_CLC_RECV_BUF_LEN : datlen;
-		iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
 		if (len < recvlen) {
 			smc->sk.sk_err = EPROTO;
diff --git a/net/socket.c b/net/socket.c
index f3d0a8d66cce..24dd5f26585a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -761,7 +761,7 @@ EXPORT_SYMBOL(sock_sendmsg);
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 	return sock_sendmsg(sock, msg);
 }
 EXPORT_SYMBOL(kernel_sendmsg);
@@ -787,7 +787,7 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!sock->ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 
 	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
@@ -795,12 +795,13 @@ EXPORT_SYMBOL(kernel_sendmsg_locked);
 
 static bool skb_is_err_queue(const struct sk_buff *skb)
 {
-	/* pkt_type of skbs enqueued on the error queue are set to
-	 * PACKET_OUTGOING in skb_set_err_queue(). This is only safe to do
-	 * in recvmsg, since skbs received on a local socket will never
-	 * have a pkt_type of PACKET_OUTGOING.
+	/* Error-queue skbs are marked as PACKET_OUTGOING in
+	 * skb_set_err_queue() and use the destructor installed by
+	 * sock_queue_err_skb(). PACKET_OUTGOING alone is not unique:
+	 * AF_PACKET outgoing taps use the same pkt_type.
 	 */
-	return skb->pkt_type == PACKET_OUTGOING;
+	return skb->pkt_type == PACKET_OUTGOING &&
+	       skb->destructor == sock_rmem_free;
 }
 
 /* On transmit, software and hardware timestamps are returned independently.
@@ -1007,7 +1008,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size, int flags)
 {
 	msg->msg_control_is_user = false;
-	iov_iter_kvec(&msg->msg_iter, READ, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, vec, num, size);
 	return sock_recvmsg(sock, msg, flags);
 }
 EXPORT_SYMBOL(kernel_recvmsg);
@@ -2048,7 +2049,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct iovec iov;
 	int fput_needed;
 
-	err = import_single_range(WRITE, buff, len, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_SOURCE, buff, len, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2109,7 +2110,7 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	int err, err2;
 	int fput_needed;
 
-	err = import_single_range(READ, ubuf, size, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_DEST, ubuf, size, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2380,7 +2381,7 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE,
 			    msg.msg_iov, msg.msg_iovlen,
 			    UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index d52313af82bc..eabb95360885 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -213,7 +213,7 @@ static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
 static int xprt_send_kvec(struct socket *sock, struct msghdr *msg,
 			  struct kvec *vec, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, 1, vec->iov_len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
 	return xprt_sendmsg(sock, msg, seek);
 }
 
@@ -226,7 +226,7 @@ static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec, xdr_buf_pagecount(xdr),
+	iov_iter_bvec(&msg->msg_iter, ITER_SOURCE, xdr->bvec, xdr_buf_pagecount(xdr),
 		      xdr->page_len + xdr->page_base);
 	return xprt_sendmsg(sock, msg, base + xdr->page_base);
 }
@@ -249,7 +249,7 @@ static int xprt_send_rm_and_kvec(struct socket *sock, struct msghdr *msg,
 	};
 	size_t len = iov[0].iov_len + iov[1].iov_len;
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, iov, 2, len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, iov, 2, len);
 	return xprt_sendmsg(sock, msg, base);
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 112236dd7290..e1ba75824aee 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -260,7 +260,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	rqstp->rq_respages = &rqstp->rq_pages[i];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	iov_iter_bvec(&msg.msg_iter, READ, bvec, i, buflen);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
 	if (seek) {
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
@@ -871,7 +871,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, want);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
 		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
 		if (len < 0)
 			return len;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index a829da4bbb09..72b1b636e880 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -363,7 +363,7 @@ static ssize_t
 xs_read_kvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct kvec *kvec, size_t count, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, READ, kvec, 1, count);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, kvec, 1, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -372,7 +372,7 @@ xs_read_bvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct bio_vec *bvec, unsigned long nr, size_t count,
 		size_t seek)
 {
-	iov_iter_bvec(&msg->msg_iter, READ, bvec, nr, count);
+	iov_iter_bvec(&msg->msg_iter, ITER_DEST, bvec, nr, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -380,7 +380,7 @@ static ssize_t
 xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
-	iov_iter_discard(&msg->msg_iter, READ, count);
+	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
 	return sock_recvmsg(sock, msg, flags);
 }
 
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 4292c0f1e3da..0445c91db009 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -396,7 +396,7 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 	iov.iov_base = &s;
 	iov.iov_len = sizeof(s);
 	msg.msg_name = NULL;
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 54c75cf4b53d..10f7b35673bc 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -571,7 +571,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	kaddr = kmap(page);
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
-	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, &iov, 1, size);
 	rc = tls_push_data(sk, &msg_iter, size,
 			   flags, TLS_RECORD_TYPE_DATA);
 	kunmap(page);
@@ -646,7 +646,7 @@ static int tls_device_push_pending_record(struct sock *sk, int flags)
 {
 	struct iov_iter	msg_iter;
 
-	iov_iter_kvec(&msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, NULL, 0, 0);
 	return tls_push_data(sk, &msg_iter, 0, flags, TLS_RECORD_TYPE_DATA);
 }
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index e8bcaf9c5be3..ac68f1afc44e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -972,8 +972,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0)
+		if (err < 0) {
 			vsock_remove_pending(sk, pending);
+			sk_acceptq_removed(sk);
+		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index ebb9ee8906f4..8b41f8654832 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -342,6 +342,10 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			err = -ENOBUFS;
 		goto unlock;
 	}
+	if (emsg->len) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
 
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
@@ -358,7 +362,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	*((__be16 *)buf) = cpu_to_be16(msglen);
 	pfx_iov.iov_base = buf;
 	pfx_iov.iov_len = sizeof(buf);
-	iov_iter_kvec(&pfx_iter, WRITE, &pfx_iov, 1, pfx_iov.iov_len);
+	iov_iter_kvec(&pfx_iter, ITER_SOURCE, &pfx_iov, 1, pfx_iov.iov_len);
 
 	err = sk_msg_memcopy_from_iter(sk, &pfx_iter, &emsg->skmsg,
 				       pfx_iov.iov_len);
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 7f326a01cbce..6ab0b2166a59 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -781,9 +781,12 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+
+		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		put_net(net);
+	}
 	local_bh_enable();
 }
 
@@ -792,6 +795,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 				       struct sk_buff *))
 {
 	struct xfrm_trans_tasklet *trans;
+	struct net *hold_net;
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
@@ -800,8 +804,12 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
+	hold_net = maybe_get_net(net);
+	if (!hold_net)
+		return -ENODEV;
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 851029a5383a..d8348730e2d0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1124,15 +1124,6 @@ static void __xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b, bool
 	}
 }
 
-static void xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b)
-{
-	struct net *net = read_pnet(&b->k.net);
-
-	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
-	__xfrm_policy_inexact_prune_bin(b, false);
-	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-}
-
 static void __xfrm_policy_inexact_flush(struct net *net)
 {
 	struct xfrm_pol_inexact_bin *bin, *t;
@@ -1720,12 +1711,12 @@ xfrm_policy_bysel_ctx(struct net *net, const struct xfrm_mark *mark, u32 if_id,
 		}
 		ret = pol;
 	}
+	if (bin && delete)
+		__xfrm_policy_inexact_prune_bin(bin, false);
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 
 	if (ret && delete)
 		xfrm_policy_kill(ret);
-	if (bin && delete)
-		xfrm_policy_inexact_prune_bin(bin);
 	return ret;
 }
 EXPORT_SYMBOL(xfrm_policy_bysel_ctx);
@@ -4488,7 +4479,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* Stage 5 - announce */
-	km_migrate(sel, dir, type, m, num_migrate, k, encap);
+	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
 	xfrm_pol_put(pol);
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f7f568bfb93a..f7c0d980dc43 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -681,12 +681,12 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		x->km.state = XFRM_STATE_DEAD;
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
-		hlist_del_rcu(&x->bydst);
-		hlist_del_rcu(&x->bysrc);
-		if (x->km.seq)
-			hlist_del_rcu(&x->byseq);
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		hlist_del_init_rcu(&x->bydst);
+		hlist_del_init_rcu(&x->bysrc);
+		if (!hlist_unhashed(&x->byseq))
+			hlist_del_init_rcu(&x->byseq);
+		if (!hlist_unhashed(&x->byspi))
+			hlist_del_init_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
@@ -2302,7 +2302,7 @@ EXPORT_SYMBOL(km_policy_expired);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_migrate,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap)
 {
 	int err = -EINVAL;
@@ -2313,7 +2313,7 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	list_for_each_entry_rcu(km, &xfrm_km_list, list) {
 		if (km->migrate) {
 			ret = km->migrate(sel, dir, type, m, num_migrate, k,
-					  encap);
+					  net, encap);
 			if (!ret)
 				err = ret;
 		}
@@ -2581,10 +2581,14 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	const struct xfrm_type *type = READ_ONCE(x->type);
 	struct crypto_aead *aead;
 	u32 blksize, net_adj = 0;
+	u32 overhead, payload_mtu;
 
 	if (x->km.state != XFRM_STATE_VALID ||
-	    !type || type->proto != IPPROTO_ESP)
+	    !type || type->proto != IPPROTO_ESP) {
+		if (mtu <= x->props.header_len)
+			return 1;
 		return mtu - x->props.header_len;
+	}
 
 	aead = x->data;
 	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
@@ -2604,8 +2608,17 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 		break;
 	}
 
-	return ((mtu - x->props.header_len - crypto_aead_authsize(aead) -
-		 net_adj) & ~(blksize - 1)) + net_adj - 2;
+	overhead = x->props.header_len + crypto_aead_authsize(aead) + net_adj;
+	if (mtu <= overhead)
+		return 1;
+
+	payload_mtu = mtu - overhead;
+	payload_mtu &= ~(blksize - 1);
+	if (payload_mtu <= 2)
+		return 1;
+
+	return payload_mtu + net_adj - 2;
+
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5f5a0d410a4d..bd6a02480957 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2774,10 +2774,9 @@ static int build_migrate(struct sk_buff *skb, const struct xfrm_migrate *m,
 
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
-	struct net *net = &init_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -2795,7 +2794,7 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index c670b25235a4..4d720ff060a7 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -846,6 +846,8 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	}
 
 	if (unpack_nameX(e, AA_STRUCT, "policydb")) {
+		size_t state_count;
+
 		/* generic policy dfa - optional and may be NULL */
 		info = "failed to unpack policydb";
 		profile->policy.dfa = unpack_dfa(e);
@@ -860,13 +862,12 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 		if (!unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] = DFA_START;
-		} else {
-			size_t state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		}
 
-			if (profile->policy.start[0] >= state_count) {
-				info = "invalid dfa start state";
-				goto fail;
-			}
+		state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		if (profile->policy.start[0] >= state_count) {
+			info = "invalid dfa start state";
+			goto fail;
 		}
 
 		/* setup class index */
@@ -889,16 +890,18 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 		info = "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
+		size_t state_count;
+
 		if (!unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start = DFA_START;
-		} else {
-			size_t state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		}
 
-			if (profile->file.start >= state_count) {
-				info = "invalid dfa start state";
-				goto fail;
-			}
+		state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+		if (profile->file.start >= state_count) {
+			info = "invalid dfa start state";
+			goto fail;
 		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 255115251ce5..aa1dc43b16dd 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1256,7 +1256,7 @@ long keyctl_instantiate_key(key_serial_t id,
 		struct iov_iter from;
 		int ret;
 
-		ret = import_single_range(WRITE, (void __user *)_payload, plen,
+		ret = import_single_range(ITER_SOURCE, (void __user *)_payload, plen,
 					  &iov, &from);
 		if (unlikely(ret))
 			return ret;
@@ -1288,7 +1288,7 @@ long keyctl_instantiate_key_iov(key_serial_t id,
 	if (!_payload_iov)
 		ioc = 0;
 
-	ret = import_iovec(WRITE, _payload_iov, ioc,
+	ret = import_iovec(ITER_SOURCE, _payload_iov, ioc,
 				    ARRAY_SIZE(iovstack), &iov, &from);
 	if (ret < 0)
 		return ret;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 69143a216a3c..1c0f8209f130 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
-	    !strcmp(sb->s_type->name, "pstore"))
+	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 1abee841cc45..293ea2d2600e 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -121,10 +121,9 @@ static int onyx_snd_vol_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 l, r;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
-	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = l + VOLUME_RANGE_SHIFT;
 	ucontrol->value.integer.value[1] = r + VOLUME_RANGE_SHIFT;
@@ -145,15 +144,13 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > -1 + VOLUME_RANGE_SHIFT)
 		return -EINVAL;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
 
 	if (l + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[0] &&
-	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1]) {
-		mutex_unlock(&onyx->mutex);
+	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1])
 		return 0;
-	}
 
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT,
 			    ucontrol->value.integer.value[0]
@@ -161,7 +158,6 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT,
 			    ucontrol->value.integer.value[1]
 			     - VOLUME_RANGE_SHIFT);
-	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -197,9 +193,8 @@ static int onyx_snd_inputgain_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 ig;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &ig);
-	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] =
 		(ig & ONYX_ADC_PGA_GAIN_MASK) + INPUTGAIN_RANGE_SHIFT;
@@ -216,14 +211,13 @@ static int onyx_snd_inputgain_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < 3 + INPUTGAIN_RANGE_SHIFT ||
 	    ucontrol->value.integer.value[0] > 28 + INPUTGAIN_RANGE_SHIFT)
 		return -EINVAL;
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	n = v;
 	n &= ~ONYX_ADC_PGA_GAIN_MASK;
 	n |= (ucontrol->value.integer.value[0] - INPUTGAIN_RANGE_SHIFT)
 		& ONYX_ADC_PGA_GAIN_MASK;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, n);
-	mutex_unlock(&onyx->mutex);
 
 	return n != v;
 }
@@ -251,9 +245,8 @@ static int onyx_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 v;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
-	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.enumerated.item[0] = !!(v&ONYX_ADC_INPUT_MIC);
 
@@ -264,13 +257,12 @@ static void onyx_set_capture_source(struct onyx *onyx, int mic)
 {
 	s8 v;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	v &= ~ONYX_ADC_INPUT_MIC;
 	if (mic)
 		v |= ONYX_ADC_INPUT_MIC;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, v);
-	mutex_unlock(&onyx->mutex);
 }
 
 static int onyx_snd_capture_source_put(struct snd_kcontrol *kcontrol,
@@ -311,9 +303,8 @@ static int onyx_snd_mute_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 c;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &c);
-	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !(c & ONYX_MUTE_LEFT);
 	ucontrol->value.integer.value[1] = !(c & ONYX_MUTE_RIGHT);
@@ -328,9 +319,9 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 	u8 v = 0, c = 0;
 	int err = -EBUSY;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	if (onyx->analog_locked)
-		goto out_unlock;
+		return -EBUSY;
 
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	c = v;
@@ -341,9 +332,6 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 		c |= ONYX_MUTE_RIGHT;
 	err = onyx_write_register(onyx, ONYX_REG_DAC_CONTROL, c);
 
- out_unlock:
-	mutex_unlock(&onyx->mutex);
-
 	return !err ? (v != c) : err;
 }
 
@@ -372,9 +360,8 @@ static int onyx_snd_single_bit_get(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, address, &c);
-	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !!(c & mask) ^ polarity;
 
@@ -393,11 +380,10 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	if (spdiflock && onyx->spdif_locked) {
 		/* even if alsamixer doesn't care.. */
-		err = -EBUSY;
-		goto out_unlock;
+		return -EBUSY;
 	}
 	onyx_read_register(onyx, address, &v);
 	c = v;
@@ -406,9 +392,6 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 		c |= mask;
 	err = onyx_write_register(onyx, address, c);
 
- out_unlock:
-	mutex_unlock(&onyx->mutex);
-
 	return !err ? (v != c) : err;
 }
 
@@ -489,7 +472,7 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	ucontrol->value.iec958.status[0] = v & 0x3e;
 
@@ -501,7 +484,6 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	ucontrol->value.iec958.status[4] = v & 0x0f;
-	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -512,7 +494,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	v = (v & ~0x3e) | (ucontrol->value.iec958.status[0] & 0x3e);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO1, v);
@@ -527,7 +509,6 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	v = (v & ~0x0f) | (ucontrol->value.iec958.status[4] & 0x0f);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO4, v);
-	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -672,14 +653,13 @@ static int onyx_usable(struct codec_info_item *cii,
 	struct onyx *onyx = cii->codec_data;
 	int spdif_enabled, analog_enabled;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	spdif_enabled = !!(v & ONYX_SPDIF_ENABLE);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	analog_enabled =
 		(v & (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT))
 		 != (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT);
-	mutex_unlock(&onyx->mutex);
 
 	switch (ti->tag) {
 	case 0: return 1;
@@ -695,9 +675,8 @@ static int onyx_prepare(struct codec_info_item *cii,
 {
 	u8 v;
 	struct onyx *onyx = cii->codec_data;
-	int err = -EBUSY;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 
 #ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
 	if (substream->runtime->format == SNDRV_PCM_FMTBIT_COMPRESSED_16BE) {
@@ -706,10 +685,9 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DAC_CONTROL,
 					v | ONYX_MUTE_RIGHT | ONYX_MUTE_LEFT))
-			goto out_unlock;
+			return -EBUSY;
 		onyx->analog_locked = 1;
-		err = 0;
-		goto out_unlock;
+		return 0;
 	}
 #endif
 	switch (substream->runtime->rate) {
@@ -719,8 +697,7 @@ static int onyx_prepare(struct codec_info_item *cii,
 		/* these rates are ok for all outputs */
 		/* FIXME: program spdif channel control bits here so that
 		 *	  userspace doesn't have to if it only plays pcm! */
-		err = 0;
-		goto out_unlock;
+		return 0;
 	default:
 		/* got some rate that the digital output can't do,
 		 * so disable and lock it */
@@ -728,16 +705,12 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DIG_INFO4,
 					v & ~ONYX_SPDIF_ENABLE))
-			goto out_unlock;
+			return -EBUSY;
 		onyx->spdif_locked = 1;
-		err = 0;
-		goto out_unlock;
+		return 0;
 	}
 
- out_unlock:
-	mutex_unlock(&onyx->mutex);
-
-	return err;
+	return -EBUSY;
 }
 
 static int onyx_open(struct codec_info_item *cii,
@@ -745,9 +718,8 @@ static int onyx_open(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx->open_count++;
-	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -757,11 +729,10 @@ static int onyx_close(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	onyx->open_count--;
 	if (!onyx->open_count)
 		onyx->spdif_locked = onyx->analog_locked = 0;
-	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -771,7 +742,7 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	/* this *MUST* be more elaborate later... */
 	switch (what) {
 	case CLOCK_SWITCH_PREPARE_SLAVE:
@@ -783,7 +754,6 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 	default: /* silence warning */
 		break;
 	}
-	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -794,27 +764,21 @@ static int onyx_suspend(struct codec_info_item *cii, pm_message_t state)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
-	int err = -ENXIO;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		goto out_unlock;
+		return -ENXIO;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v | ONYX_ADPSV | ONYX_DAPSV);
 	/* Apple does a sleep here but the datasheet says to do it on resume */
-	err = 0;
- out_unlock:
-	mutex_unlock(&onyx->mutex);
-
-	return err;
+	return 0;
 }
 
 static int onyx_resume(struct codec_info_item *cii)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
-	int err = -ENXIO;
 
-	mutex_lock(&onyx->mutex);
+	guard(mutex)(&onyx->mutex);
 
 	/* reset codec */
 	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
@@ -826,17 +790,13 @@ static int onyx_resume(struct codec_info_item *cii)
 
 	/* take codec out of suspend (if it still is after reset) */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		goto out_unlock;
+		return -ENXIO;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));
 	/* FIXME: should divide by sample rate, but 8k is the lowest we go */
 	msleep(2205000/8000);
 	/* reset all values */
 	onyx_register_init(onyx);
-	err = 0;
- out_unlock:
-	mutex_unlock(&onyx->mutex);
-
-	return err;
+	return 0;
 }
 
 #endif /* CONFIG_PM */
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index ab19a37e2a68..734b629495a1 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -235,10 +235,9 @@ static int tas_snd_vol_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->cached_volume_l;
 	ucontrol->value.integer.value[1] = tas->cached_volume_r;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -254,18 +253,15 @@ static int tas_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > 177)
 		return -EINVAL;
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	if (tas->cached_volume_l == ucontrol->value.integer.value[0]
-	 && tas->cached_volume_r == ucontrol->value.integer.value[1]) {
-		mutex_unlock(&tas->mtx);
+	 && tas->cached_volume_r == ucontrol->value.integer.value[1])
 		return 0;
-	}
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -285,10 +281,9 @@ static int tas_snd_mute_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = !tas->mute_l;
 	ucontrol->value.integer.value[1] = !tas->mute_r;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -297,18 +292,15 @@ static int tas_snd_mute_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	if (tas->mute_l == !ucontrol->value.integer.value[0]
-	 && tas->mute_r == !ucontrol->value.integer.value[1]) {
-		mutex_unlock(&tas->mtx);
+	 && tas->mute_r == !ucontrol->value.integer.value[1])
 		return 0;
-	}
 
 	tas->mute_l = !ucontrol->value.integer.value[0];
 	tas->mute_r = !ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -337,10 +329,9 @@ static int tas_snd_mixer_get(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->mixer_l[idx];
 	ucontrol->value.integer.value[1] = tas->mixer_r[idx];
-	mutex_unlock(&tas->mtx);
 
 	return 0;
 }
@@ -351,19 +342,16 @@ static int tas_snd_mixer_put(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	if (tas->mixer_l[idx] == ucontrol->value.integer.value[0]
-	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1]) {
-		mutex_unlock(&tas->mtx);
+	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1])
 		return 0;
-	}
 
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
 	if (tas->hw_enabled)
 		tas_set_mixer(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -396,9 +384,8 @@ static int tas_snd_drc_range_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_range;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -411,16 +398,13 @@ static int tas_snd_drc_range_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[0] > TAS3004_DRC_MAX)
 		return -EINVAL;
 
-	mutex_lock(&tas->mtx);
-	if (tas->drc_range == ucontrol->value.integer.value[0]) {
-		mutex_unlock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
+	if (tas->drc_range == ucontrol->value.integer.value[0])
 		return 0;
-	}
 
 	tas->drc_range = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -440,9 +424,8 @@ static int tas_snd_drc_switch_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_enabled;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -451,16 +434,13 @@ static int tas_snd_drc_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
-	if (tas->drc_enabled == ucontrol->value.integer.value[0]) {
-		mutex_unlock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
+	if (tas->drc_enabled == ucontrol->value.integer.value[0])
 		return 0;
-	}
 
 	tas->drc_enabled = !!ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -486,9 +466,8 @@ static int tas_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.enumerated.item[0] = !!(tas->acr & TAS_ACR_INPUT_B);
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -500,7 +479,7 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	oldacr = tas->acr;
 
 	/*
@@ -512,13 +491,10 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0])
 		tas->acr |= TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL |
 		      TAS_ACR_B_MON_SEL_RIGHT;
-	if (oldacr == tas->acr) {
-		mutex_unlock(&tas->mtx);
+	if (oldacr == tas->acr)
 		return 0;
-	}
 	if (tas->hw_enabled)
 		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -557,9 +533,8 @@ static int tas_snd_treble_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->treble;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -571,16 +546,13 @@ static int tas_snd_treble_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_TREBLE_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_TREBLE_MAX)
 		return -EINVAL;
-	mutex_lock(&tas->mtx);
-	if (tas->treble == ucontrol->value.integer.value[0]) {
-		mutex_unlock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
+	if (tas->treble == ucontrol->value.integer.value[0])
 		return 0;
-	}
 
 	tas->treble = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_treble(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -608,9 +580,8 @@ static int tas_snd_bass_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->bass;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -622,16 +593,13 @@ static int tas_snd_bass_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_BASS_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_BASS_MAX)
 		return -EINVAL;
-	mutex_lock(&tas->mtx);
-	if (tas->bass == ucontrol->value.integer.value[0]) {
-		mutex_unlock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
+	if (tas->bass == ucontrol->value.integer.value[0])
 		return 0;
-	}
 
 	tas->bass = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_bass(tas);
-	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -722,13 +690,13 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
 		break;
 	case CLOCK_SWITCH_SLAVE:
 		/* Clocks are back, re-init the codec */
-		mutex_lock(&tas->mtx);
-		tas_reset_init(tas);
-		tas_set_volume(tas);
-		tas_set_mixer(tas);
-		tas->hw_enabled = 1;
-		tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
-		mutex_unlock(&tas->mtx);
+		scoped_guard(mutex, &tas->mtx) {
+			tas_reset_init(tas);
+			tas_set_volume(tas);
+			tas_set_mixer(tas);
+			tas->hw_enabled = 1;
+			tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
+		}
 		break;
 	default:
 		/* doesn't happen as of now */
@@ -743,23 +711,21 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
 static int tas_resume(struct tas *tas)
 {
 	/* reset codec */
-	mutex_lock(&tas->mtx);
+	guard(mutex)(&tas->mtx);
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
 	tas->hw_enabled = 1;
-	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -802,14 +768,13 @@ static int tas_init_codec(struct aoa_codec *codec)
 		return -EINVAL;
 	}
 
-	mutex_lock(&tas->mtx);
-	if (tas_reset_init(tas)) {
-		printk(KERN_ERR PFX "tas failed to initialise\n");
-		mutex_unlock(&tas->mtx);
-		return -ENXIO;
+	scoped_guard(mutex, &tas->mtx) {
+		if (tas_reset_init(tas)) {
+			printk(KERN_ERR PFX "tas failed to initialise\n");
+			return -ENXIO;
+		}
+		tas->hw_enabled = 1;
 	}
-	tas->hw_enabled = 1;
-	mutex_unlock(&tas->mtx);
 
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 39bb409b27f6..19ed0e6907da 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -212,10 +212,9 @@ static void ftr_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	mutex_lock(&notif->mutex);
+	guard(mutex)(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
-	mutex_unlock(&notif->mutex);
 }
 
 static void gpio_enable_dual_edge(int gpio)
@@ -341,19 +340,17 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!irq)
 		return -ENODEV;
 
-	mutex_lock(&notif->mutex);
+	guard(mutex)(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify) {
-		err = 0;
-		goto out_unlock;
-	}
+	if (!old && !notify)
+		return 0;
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		goto out_unlock;
+		return err;
 	}
 
 	if (old && !notify)
@@ -362,16 +359,13 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		err = request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
 		if (err)
-			goto out_unlock;
+			return err;
 	}
 
 	notif->notify = notify;
 	notif->data = data;
 
-	err = 0;
- out_unlock:
-	mutex_unlock(&notif->mutex);
-	return err;
+	return 0;
 }
 
 static int ftr_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/core/gpio-pmf.c b/sound/aoa/core/gpio-pmf.c
index 37866039d1ea..e76bde25e41a 100644
--- a/sound/aoa/core/gpio-pmf.c
+++ b/sound/aoa/core/gpio-pmf.c
@@ -74,10 +74,9 @@ static void pmf_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	mutex_lock(&notif->mutex);
+	guard(mutex)(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
-	mutex_unlock(&notif->mutex);
 }
 
 static void pmf_gpio_init(struct gpio_runtime *rt)
@@ -154,19 +153,17 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 		return -EINVAL;
 	}
 
-	mutex_lock(&notif->mutex);
+	guard(mutex)(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify) {
-		err = 0;
-		goto out_unlock;
-	}
+	if (!old && !notify)
+		return 0;
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		goto out_unlock;
+		return err;
 	}
 
 	if (old && !notify) {
@@ -178,10 +175,8 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		irq_client = kzalloc(sizeof(struct pmf_irq_client),
 				     GFP_KERNEL);
-		if (!irq_client) {
-			err = -ENOMEM;
-			goto out_unlock;
-		}
+		if (!irq_client)
+			return -ENOMEM;
 		irq_client->data = notif;
 		irq_client->handler = pmf_handle_notify_irq;
 		irq_client->owner = THIS_MODULE;
@@ -192,17 +187,14 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 			printk(KERN_ERR "snd-aoa: gpio layer failed to"
 					" register %s irq (%d)\n", name, err);
 			kfree(irq_client);
-			goto out_unlock;
+			return err;
 		}
 		notif->gpio_private = irq_client;
 	}
 	notif->notify = notify;
 	notif->data = data;
 
-	err = 0;
- out_unlock:
-	mutex_unlock(&notif->mutex);
-	return err;
+	return 0;
 }
 
 static int pmf_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 0c1056efbe02..14631e65aa70 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -411,6 +411,9 @@ static int i2sbus_resume(struct macio_dev* dev)
 	int err, ret = 0;
 
 	list_for_each_entry(i2sdev, &control->list, item) {
+		if (list_empty(&i2sdev->sound.codec_list))
+			continue;
+
 		/* reset i2s bus format etc. */
 		i2sbus_pcm_prepare_both(i2sdev);
 
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index a9e502a6cdeb..2637507b9f66 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -79,11 +79,10 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	u64 formats = 0;
 	unsigned int rates = 0;
 	struct transfer_info v;
-	int result = 0;
 	int bus_factor = 0, sysclock_factor = 0;
 	int found_this;
 
-	mutex_lock(&i2sdev->lock);
+	guard(mutex)(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
@@ -92,8 +91,7 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 
 	if (pi->active) {
 		/* alsa messed up */
-		result = -EBUSY;
-		goto out_unlock;
+		return -EBUSY;
 	}
 
 	/* we now need to assign the hw */
@@ -117,10 +115,8 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 			ti++;
 		}
 	}
-	if (!masks_inited || !bus_factor || !sysclock_factor) {
-		result = -ENODEV;
-		goto out_unlock;
-	}
+	if (!masks_inited || !bus_factor || !sysclock_factor)
+		return -ENODEV;
 	/* bus dependent stuff */
 	hw->info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME |
@@ -169,17 +165,16 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	 * currently in use (if any). */
 	hw->rate_min = 5512;
 	hw->rate_max = 192000;
-	/* if the other stream is active, then we can only
-	 * support what it is currently using.
-	 * FIXME: I lied. This comment is wrong. We can support
-	 * anything that works with the same serial format, ie.
-	 * when recording 24 bit sound we can well play 16 bit
-	 * sound at the same time iff using the same transfer mode.
+	/* If the other stream is already prepared, keep this stream
+	 * on the same duplex format and rate.
+	 *
+	 * i2sbus_pcm_prepare() still programs one shared transport
+	 * configuration for both directions, so mixed duplex formats
+	 * are not supported here.
 	 */
 	if (other->active) {
-		/* FIXME: is this guaranteed by the alsa api? */
 		hw->formats &= pcm_format_to_bits(i2sdev->format);
-		/* see above, restrict rates to the one we already have */
+		/* Restrict rates to the one already in use. */
 		hw->rate_min = i2sdev->rate;
 		hw->rate_max = i2sdev->rate;
 	}
@@ -194,15 +189,12 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	hw->periods_max = MAX_DBDMA_COMMANDS;
 	err = snd_pcm_hw_constraint_integer(pi->substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (err < 0) {
-		result = err;
-		goto out_unlock;
-	}
+	if (err < 0)
+		return err;
 	list_for_each_entry(cii, &sdev->codec_list, list) {
 		if (cii->codec->open) {
 			err = cii->codec->open(cii, pi->substream);
 			if (err) {
-				result = err;
 				/* unwind */
 				found_this = 0;
 				list_for_each_entry_reverse(rev,
@@ -214,14 +206,12 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 					if (rev == cii)
 						found_this = 1;
 				}
-				goto out_unlock;
+				return err;
 			}
 		}
 	}
 
- out_unlock:
-	mutex_unlock(&i2sdev->lock);
-	return result;
+	return 0;
 }
 
 #undef CHECK_RATE
@@ -232,7 +222,7 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 	struct pcm_info *pi;
 	int err = 0, tmp;
 
-	mutex_lock(&i2sdev->lock);
+	guard(mutex)(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, NULL);
 
@@ -246,7 +236,6 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 
 	pi->substream = NULL;
 	pi->active = 0;
-	mutex_unlock(&i2sdev->lock);
 	return err;
 }
 
@@ -293,6 +282,23 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
 }
 #endif
 
+static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi;
+
+	guard(mutex)(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+	pi->active = 0;
+}
+
+static inline int i2sbus_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params, int in)
+{
+	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
+	return 0;
+}
+
 static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 {
 	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
@@ -301,14 +307,27 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
+	i2sbus_pcm_clear_active(i2sdev, in);
 	return 0;
 }
 
+static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	return i2sbus_hw_params(substream, params, 0);
+}
+
 static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 0);
 }
 
+static int i2sbus_record_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	return i2sbus_hw_params(substream, params, 1);
+}
+
 static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 1);
@@ -330,33 +349,25 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	int input_16bit;
 	struct pcm_info *pi, *other;
 	int cnt;
-	int result = 0;
 	unsigned int cmd, stopaddr;
 
-	mutex_lock(&i2sdev->lock);
+	guard(mutex)(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
-	if (pi->dbdma_ring.running) {
-		result = -EBUSY;
-		goto out_unlock;
-	}
+	if (pi->dbdma_ring.running)
+		return -EBUSY;
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
 
-	if (!pi->substream || !pi->substream->runtime) {
-		result = -EINVAL;
-		goto out_unlock;
-	}
+	if (!pi->substream || !pi->substream->runtime)
+		return -EINVAL;
 
 	runtime = pi->substream->runtime;
-	pi->active = 1;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
-	     || (i2sdev->rate != runtime->rate))) {
-		result = -EINVAL;
-		goto out_unlock;
-	}
+	     || (i2sdev->rate != runtime->rate)))
+		return -EINVAL;
 
 	i2sdev->format = runtime->format;
 	i2sdev->rate = runtime->rate;
@@ -400,6 +411,9 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	/* set stop command */
 	command->command = cpu_to_le16(DBDMA_STOP);
 
+	cii = list_first_entry(&i2sdev->sound.codec_list,
+			       struct codec_info_item, list);
+
 	/* ok, let's set the serial format and stuff */
 	switch (runtime->format) {
 	/* 16 bit formats */
@@ -407,15 +421,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	case SNDRV_PCM_FORMAT_U16_BE:
 		/* FIXME: if we add different bus factors we need to
 		 * do more here!! */
-		bi.bus_factor = 0;
-		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-			bi.bus_factor = cii->codec->bus_factor;
-			break;
-		}
-		if (!bi.bus_factor) {
-			result = -ENODEV;
-			goto out_unlock;
-		}
+		bi.bus_factor = cii->codec->bus_factor;
 		input_16bit = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -426,22 +432,16 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		input_16bit = 0;
 		break;
 	default:
-		result = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 	/* we assume all sysclocks are the same! */
-	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-		bi.sysclock_factor = cii->codec->sysclock_factor;
-		break;
-	}
+	bi.sysclock_factor = cii->codec->sysclock_factor;
 
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,
 			       runtime->rate,
-			       &sfr) < 0) {
-		result = -EINVAL;
-		goto out_unlock;
-	}
+			       &sfr) < 0)
+		return -EINVAL;
 	switch (bi.bus_factor) {
 	case 32:
 		sfr |= I2S_SF_SERIAL_FORMAT_I2S_32X;
@@ -457,10 +457,8 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		int err = 0;
 		if (cii->codec->prepare)
 			err = cii->codec->prepare(cii, &bi, pi->substream);
-		if (err) {
-			result = err;
-			goto out_unlock;
-		}
+		if (err)
+			return err;
 	}
 	/* codecs are fine with it, so set our clocks */
 	if (input_16bit)
@@ -474,9 +472,11 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 
 	/* early exit if already programmed correctly */
 	/* not locking these is fine since we touch them only in this function */
-	if (in_le32(&i2sdev->intfregs->serial_format) == sfr
-	 && in_le32(&i2sdev->intfregs->data_word_sizes) == dws)
-		goto out_unlock;
+	if (in_le32(&i2sdev->intfregs->serial_format) == sfr &&
+	    in_le32(&i2sdev->intfregs->data_word_sizes) == dws) {
+		pi->active = 1;
+		return 0;
+	}
 
 	/* let's notify the codecs about clocks going away.
 	 * For now we only do mastering on the i2s cell... */
@@ -514,9 +514,8 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		if (cii->codec->switch_clock)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
- out_unlock:
-	mutex_unlock(&i2sdev->lock);
-	return result;
+	pi->active = 1;
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -772,6 +771,7 @@ static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_playback_ops = {
 	.open =		i2sbus_playback_open,
 	.close =	i2sbus_playback_close,
+	.hw_params =	i2sbus_playback_hw_params,
 	.hw_free =	i2sbus_playback_hw_free,
 	.prepare =	i2sbus_playback_prepare,
 	.trigger =	i2sbus_playback_trigger,
@@ -840,6 +840,7 @@ static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_record_ops = {
 	.open =		i2sbus_record_open,
 	.close =	i2sbus_record_close,
+	.hw_params =	i2sbus_record_hw_params,
 	.hw_free =	i2sbus_record_hw_free,
 	.prepare =	i2sbus_record_prepare,
 	.trigger =	i2sbus_record_trigger,
diff --git a/sound/core/misc.c b/sound/core/misc.c
index d32a19976a2b..edd29fcde420 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -171,14 +171,18 @@ static LIST_HEAD(snd_fasync_list);
 static void snd_fasync_work_fn(struct work_struct *work)
 {
 	struct snd_fasync *fasync;
+	int signal, poll;
 
 	spin_lock_irq(&snd_fasync_lock);
 	while (!list_empty(&snd_fasync_list)) {
 		fasync = list_first_entry(&snd_fasync_list, struct snd_fasync, list);
 		list_del_init(&fasync->list);
+		if (!fasync->on)
+			continue;
+		signal = fasync->signal;
+		poll = fasync->poll;
 		spin_unlock_irq(&snd_fasync_lock);
-		if (fasync->on)
-			kill_fasync(&fasync->fasync, fasync->signal, fasync->poll);
+		kill_fasync(&fasync->fasync, signal, poll);
 		spin_lock_irq(&snd_fasync_lock);
 	}
 	spin_unlock_irq(&snd_fasync_lock);
@@ -234,7 +238,11 @@ void snd_fasync_free(struct snd_fasync *fasync)
 {
 	if (!fasync)
 		return;
-	fasync->on = 0;
+
+	spin_lock_irq(&snd_fasync_lock);
+	list_del_init(&fasync->list);
+	spin_unlock_irq(&snd_fasync_lock);
+
 	flush_work(&snd_fasync_work);
 	kfree(fasync);
 }
diff --git a/sound/core/timer.c b/sound/core/timer.c
index ecad57a1bc5b..4abcecdf771b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1842,6 +1842,7 @@ static int snd_timer_user_params(struct file *file,
 	struct snd_timer *t;
 	int err;
 
+	guard(mutex)(&register_mutex);
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 12f12a294df5..c083b223df85 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -98,6 +98,9 @@ struct loopback_ops {
 struct loopback_cable {
 	spinlock_t lock;
 	struct loopback_pcm *streams[2];
+	/* in-flight peer stops running outside cable->lock */
+	atomic_t stop_count;
+	wait_queue_head_t stop_wait;
 	struct snd_pcm_hardware hw;
 	/* flags */
 	unsigned int valid;
@@ -341,8 +344,12 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		return -EIO;
 	} else {
+		/* close must not free the peer runtime below */
+		atomic_inc(&cable->stop_count);
 		snd_pcm_stop(cable->streams[SNDRV_PCM_STREAM_CAPTURE]->
 					substream, SNDRV_PCM_STATE_DRAINING);
+		if (atomic_dec_and_test(&cable->stop_count))
+			wake_up(&cable->stop_wait);
 	      __notify:
 		runtime = cable->streams[SNDRV_PCM_STREAM_PLAYBACK]->
 							substream->runtime;
@@ -994,24 +1001,29 @@ static void free_cable(struct snd_pcm_substream *substream)
 	struct loopback *loopback = substream->private_data;
 	int dev = get_cable_index(substream);
 	struct loopback_cable *cable;
+	struct loopback_pcm *dpcm;
+	bool other_alive;
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable)
 		return;
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		spin_lock_irq(&cable->lock);
-		cable->streams[substream->stream] = NULL;
-		spin_unlock_irq(&cable->lock);
-	} else {
-		struct loopback_pcm *dpcm = substream->runtime->private_data;
 
-		if (cable->ops && cable->ops->close_cable && dpcm)
-			cable->ops->close_cable(dpcm);
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
-	}
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = NULL;
+	other_alive = cable->streams[!substream->stream] != NULL;
+	spin_unlock_irq(&cable->lock);
+
+	/* Pair with the stop_count increment in loopback_check_format(). */
+	wait_event(cable->stop_wait, !atomic_read(&cable->stop_count));
+	if (other_alive)
+		return;
+
+	dpcm = substream->runtime->private_data;
+	if (cable->ops && cable->ops->close_cable && dpcm)
+		cable->ops->close_cable(dpcm);
+	/* free the cable */
+	loopback->cables[substream->number][dev] = NULL;
+	kfree(cable);
 }
 
 static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
@@ -1206,6 +1218,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 			goto unlock;
 		}
 		spin_lock_init(&cable->lock);
+		atomic_set(&cable->stop_count, 0);
+		init_waitqueue_head(&cable->stop_wait);
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source)
 			cable->ops = &loopback_snd_timer_ops;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3aa722970e86..51a22ed7325d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1970,6 +1970,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x1558, 0x14a1, "TUXEDO InfinityBook S 14 Gen6", 1),
 	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index e0a09dadfa7c..344bc61b9dc2 100644
--- a/sound/soc/codecs/simple-mux.c
+++ b/sound/soc/codecs/simple-mux.c
@@ -40,7 +40,7 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
 	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
 
-	if (ucontrol->value.enumerated.item[0] > e->items)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 
 	if (priv->mux == ucontrol->value.enumerated.item[0])
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 923e69c7695c..d54bc667175f 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -39,6 +39,7 @@ struct byt_cht_es8316_private {
 	struct gpio_desc *speaker_en_gpio;
 	struct device *codec_dev;
 	bool speaker_en;
+	bool mclk_enabled;
 };
 
 enum {
@@ -169,6 +170,15 @@ static struct snd_soc_jack_pin byt_cht_es8316_jack_pins[] = {
 	},
 };
 
+static void byt_cht_es8316_disable_mclk(struct byt_cht_es8316_private *priv)
+{
+	if (!priv->mclk_enabled)
+		return;
+
+	clk_disable_unprepare(priv->mclk);
+	priv->mclk_enabled = false;
+}
+
 static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_component *codec = asoc_rtd_to_codec(runtime, 0)->component;
@@ -225,12 +235,14 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret)
 		dev_err(card->dev, "unable to enable MCLK\n");
+	else
+		priv->mclk_enabled = true;
 
 	ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(runtime, 0), 0, 19200000,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		dev_err(card->dev, "can't set codec clock %d\n", ret);
-		return ret;
+		goto err_disable_mclk;
 	}
 
 	ret = snd_soc_card_jack_new(card, "Headset",
@@ -239,13 +251,25 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 				    ARRAY_SIZE(byt_cht_es8316_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "jack creation failed %d\n", ret);
-		return ret;
+		goto err_disable_mclk;
 	}
 
 	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 	snd_soc_component_set_jack(codec, &priv->jack, NULL);
 
 	return 0;
+
+err_disable_mclk:
+	byt_cht_es8316_disable_mclk(priv);
+	return ret;
+}
+
+static void byt_cht_es8316_exit(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
+
+	byt_cht_es8316_disable_mclk(priv);
 }
 
 static int byt_cht_es8316_codec_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -355,6 +379,7 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.init = byt_cht_es8316_init,
+		.exit = byt_cht_es8316_exit,
 		SND_SOC_DAILINK_REG(ssp2_port, ssp2_codec, platform),
 	},
 };
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9bc32751870e..6f778e7f9e64 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -191,7 +191,6 @@ static void event_handler(uint32_t opcode, uint32_t token,
 				   prtd->pcm_count, 0, 0, 0);
 		break;
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		break;
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
 		prtd->pcm_irq_pos += prtd->pcm_count;
@@ -239,9 +238,19 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	/* rate and channels are sent to audio driver */
 	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
-		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
-		q6asm_unmap_memory_regions(substream->stream,
-					   prtd->audio_client);
+		ret = q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+		if (ret < 0) {
+			dev_err(dev, "Failed to close q6asm stream %d\n", prtd->stream_id);
+			return ret;
+		}
+
+		ret = q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+		if (ret < 0) {
+			dev_err(dev, "Failed to unmap memory regions for q6asm stream %d\n",
+				prtd->stream_id);
+			return ret;
+		}
+
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -309,8 +318,6 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
 open_err:
 	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 
 	return ret;
 }
@@ -330,7 +337,6 @@ static int q6asm_dai_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
@@ -448,12 +454,12 @@ static int q6asm_dai_close(struct snd_soc_component *component,
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state)
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
-
-		q6asm_unmap_memory_regions(substream->stream,
+			q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
+		}
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -546,8 +552,6 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 			snd_compr_drain_notify(prtd->cstream);
 			prtd->notify_on_drain = false;
 
-		} else {
-			prtd->state = Q6ASM_STREAM_STOPPED;
 		}
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		break;
@@ -670,7 +674,7 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state) {
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
 			if (prtd->next_track_stream_id) {
@@ -678,11 +682,11 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 					  prtd->next_track_stream_id,
 					  CMD_CLOSE);
 			}
-		}
 
-		snd_dma_free_pages(&prtd->dma_buffer);
-		q6asm_unmap_memory_regions(stream->direction,
+			q6asm_unmap_memory_regions(stream->direction,
 					   prtd->audio_client);
+		}
+		snd_dma_free_pages(&prtd->dma_buffer);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -912,7 +916,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		goto q6_err;
+		goto routing_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -938,11 +942,11 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 
 q6_err:
+	q6routing_stream_close(rtd->dai_link->id, dir);
+routing_err:
 	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 
 open_err:
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 	return ret;
 }
 
@@ -1010,7 +1014,6 @@ static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 83e8f9466d62..c570d8f65a0c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1491,3 +1491,59 @@ brmcast_check_sg_state()
 		check_err_fail $should_fail $? "Entry $src has blocked flag"
 	done
 }
+
+u16_to_bytes()
+{
+	local u16=$1; shift
+
+	printf "%04x" $u16 | sed 's/^/000/;s/^.*\(..\)\(..\)$/\1:\2/'
+}
+
+# Given a mausezahn-formatted payload (colon-separated bytes given as %02x),
+# possibly with a keyword CHECKSUM stashed where a 16-bit checksum should be,
+# calculate checksum as per RFC 1071, assuming the CHECKSUM field (if any)
+# stands for 00:00.
+payload_template_calc_checksum()
+{
+	local payload=$1; shift
+
+	(
+	    # Set input radix.
+	    echo "16i"
+	    # Push zero for the initial checksum.
+	    echo 0
+
+	    # Pad the payload with a terminating 00: in case we get an odd
+	    # number of bytes.
+	    echo "${payload%:}:00:" |
+		sed 's/CHECKSUM/00:00/g' |
+		tr '[:lower:]' '[:upper:]' |
+		# Add the word to the checksum.
+		sed 's/\(..\):\(..\):/\1\2+\n/g' |
+		# Strip the extra odd byte we pushed if left unconverted.
+		sed 's/\(..\):$//'
+
+	    echo "10000 ~ +"	# Calculate and add carry.
+	    echo "FFFF r - p"	# Bit-flip and print.
+	) |
+	    dc |
+	    tr '[:upper:]' '[:lower:]'
+}
+
+payload_template_expand_checksum()
+{
+	local payload=$1; shift
+	local checksum=$1; shift
+
+	local ckbytes=$(u16_to_bytes $checksum)
+
+	echo "$payload" | sed "s/CHECKSUM/$ckbytes/g"
+}
+
+payload_template_nbytes()
+{
+	local payload=$1; shift
+
+	payload_template_expand_checksum "${payload%:}" 0 |
+		sed 's/:/\n/g' | wc -l
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 1853285d78e6..6108488ca42e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -462,7 +462,7 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
 			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -475,7 +475,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -491,7 +491,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2

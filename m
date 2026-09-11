Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7242BE93
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123306; cv=none; b=dTV957MeOA+9fw+RJFoZZ1RfG2d7+GnyG08rWOd9jjdqwpon4x5MEOBqfMFHr9r1rg1Iz5rnIlyKVQup2HzSWnGOZlow9Nw5Y//iZ7+O+86fIBMem65L3n2ND4CuAw78ZNgyeFO15+NcNV7fiTJcRwILfmuja0OdabrUt63guaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123306; c=relaxed/simple;
	bh=0+Ap1RHUfm+yahYtR7oSLIH+3378kdJWvr/T62k09Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgNXJZDL2QPFw0p/ETYANGFqogWaOLvA/Lt/Hh6X2M4BKn0GBaEQFHEbxXx00xpcQocMuQ/yVSEPAEFtDQEVaqjdS5T9F/uOXD8B948knu/1q9MKCIyz/UPWEGi7CkoXORG2m1VjsxNEoPJ74o3qJ50XqJi+7vddOfSctsQPSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN9RPyRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN9RPyRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201971F00899;
	Fri, 11 Sep 2026 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123294;
	bh=yoaNPSL3GBgmy5seSN+Z9GbePI3xDr1CI0OhF+esm68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GN9RPyRaSuUusCJtiV86x53dSgVs+l0iz+TOpNJr/5xTpNqjB84p2928e98IjMm8D
	 C8uhOn1e5UerpyvPGVFGqeeNNaetPZ6xpjUlb7v2juz2gYt9h9sDmqB9C94e2Cmnju
	 BtH9duyO16aM1pk07XdOuJ6UX0Jflky7iU0vtaBKERhInClNHaQepTgFAs00WV5wxL
	 VJF8b/FylWqT8bDJfkvy4UJcA/KbhKB2yNibXdA+jcYOVJvXMYE8LGjKhDHItQcdEf
	 f3mZmaShlnx8q3wLLTLiVIZ+cYjSQgihpkrkqoNUlSoMOygcFNHwFjVXKqgT1rEqhm
	 q3fIVYTNzpY7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 8/9] KVM: x86: Move the bulk of MSR specific code from x86.c to msrs.{c,h}
Date: Fri, 11 Sep 2026 06:41:22 -0400
Message-ID: <20260911104123.189614-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104123.189614-1-sashal@kernel.org>
References: <2026090914-waviness-supermom-9b84@gregkh>
 <20260911104123.189614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 7a268308015843c7e8b15dda588b2e9adf45223f ]

Introduce msrs.{c,h}, and move the vast majority of MSR specific code out
of x86.{c,h}.  Use a plural "msrs" instead of just "msr" to be consistent
with regs.{c,h}, and to make it easier to differentiate KVM's code from the
other 5+ msr.c files in the kernel.

Opportunistically drop the "x86.h" include from mtrr.c, mostly as proof
that the bulk of the MSR code is indeed being relocated to msrs.c.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-15-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Stable adaptation: this tree retains the register code in x86.c and
does not contain regs.c. Add msrs.o to its existing KVM object list
without importing the upstream regs.o entry. Keep the MSR relocation
so e62392bf39eb can update efer_reserved_bits in msrs.c and
kvm_setup_efer_caps() in x86.c without conflicts.

Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/Makefile |    2 +-
 arch/x86/kvm/msrs.c   | 2732 +++++++++++++++++++++++
 arch/x86/kvm/msrs.h   |  128 ++
 arch/x86/kvm/mtrr.c   |    2 +-
 arch/x86/kvm/x86.c    | 4816 +++++++++--------------------------------
 arch/x86/kvm/x86.h    |   87 +-
 6 files changed, 3920 insertions(+), 3847 deletions(-)
 create mode 100644 arch/x86/kvm/msrs.c
 create mode 100644 arch/x86/kvm/msrs.h

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 77337c37324b1..20f7cc52ecec1 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -5,7 +5,7 @@ ccflags-$(CONFIG_KVM_WERROR) += -Werror
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o pmu.o mtrr.o \
+kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o msrs.o pmu.o mtrr.o \
 			   debugfs.o mmu/mmu.o mmu/page_track.o mmu/spte.o
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
new file mode 100644
index 0000000000000..07f2a22d2607d
--- /dev/null
+++ b/arch/x86/kvm/msrs.c
@@ -0,0 +1,2732 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm_host.h>
+#include <asm/intel_pt.h>
+#include <asm/vmx.h>
+
+#include "hyperv.h"
+#include "lapic.h"
+#include "msrs.h"
+#include "pmu.h"
+#include "trace.h"
+#include "vmx/vmx.h"
+#include "xen.h"
+#include "x86.h"
+
+bool __read_mostly ignore_msrs = 0;
+module_param(ignore_msrs, bool, 0644);
+
+bool __read_mostly report_ignored_msrs = true;
+module_param(report_ignored_msrs, bool, 0644);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
+
+/* EFER defaults:
+ * - enable syscall per default because its emulated by KVM
+ * - enable LME and LMA per default on 64 bit KVM
+ */
+#ifdef CONFIG_X86_64
+static
+u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
+#else
+static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
+#endif
+
+#define MAX_IO_MSRS 256
+
+/*
+ * Restoring the host value for MSRs that are only consumed when running in
+ * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
+ * returns to userspace, i.e. the kernel can run with the guest's value.
+ */
+#define KVM_MAX_NR_USER_RETURN_MSRS 16
+
+struct kvm_user_return_msrs {
+	struct user_return_notifier urn;
+	bool registered;
+	struct kvm_user_return_msr_values {
+		u64 host;
+		u64 curr;
+	} values[KVM_MAX_NR_USER_RETURN_MSRS];
+};
+
+u32 __read_mostly kvm_nr_uret_msrs;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
+static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
+static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
+
+void kvm_destroy_user_return_msrs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(per_cpu(user_return_msrs, cpu).registered);
+
+	kvm_nr_uret_msrs = 0;
+}
+
+static void kvm_on_user_return(struct user_return_notifier *urn)
+{
+	unsigned slot;
+	struct kvm_user_return_msrs *msrs
+		= container_of(urn, struct kvm_user_return_msrs, urn);
+	struct kvm_user_return_msr_values *values;
+
+	msrs->registered = false;
+	user_return_notifier_unregister(urn);
+
+	for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
+		values = &msrs->values[slot];
+		if (values->host != values->curr) {
+			wrmsrq(kvm_uret_msrs_list[slot], values->host);
+			values->curr = values->host;
+		}
+	}
+}
+
+static int kvm_probe_user_return_msr(u32 msr)
+{
+	u64 val;
+	int ret;
+
+	preempt_disable();
+	ret = rdmsrq_safe(msr, &val);
+	if (ret)
+		goto out;
+	ret = wrmsrq_safe(msr, val);
+out:
+	preempt_enable();
+	return ret;
+}
+
+int kvm_add_user_return_msr(u32 msr)
+{
+	BUG_ON(kvm_nr_uret_msrs >= KVM_MAX_NR_USER_RETURN_MSRS);
+
+	if (kvm_probe_user_return_msr(msr))
+		return -1;
+
+	kvm_uret_msrs_list[kvm_nr_uret_msrs] = msr;
+	return kvm_nr_uret_msrs++;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_add_user_return_msr);
+
+int kvm_find_user_return_msr(u32 msr)
+{
+	int i;
+
+	for (i = 0; i < kvm_nr_uret_msrs; ++i) {
+		if (kvm_uret_msrs_list[i] == msr)
+			return i;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_find_user_return_msr);
+
+void kvm_user_return_msr_cpu_online(void)
+{
+	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
+	u64 value;
+	int i;
+
+	for (i = 0; i < kvm_nr_uret_msrs; ++i) {
+		rdmsrq_safe(kvm_uret_msrs_list[i], &value);
+		msrs->values[i].host = value;
+		msrs->values[i].curr = value;
+	}
+}
+
+static void kvm_user_return_register_notifier(struct kvm_user_return_msrs *msrs)
+{
+	if (!msrs->registered) {
+		msrs->urn.on_user_return = kvm_on_user_return;
+		user_return_notifier_register(&msrs->urn);
+		msrs->registered = true;
+	}
+}
+
+int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
+{
+	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
+	int err;
+
+	value = (value & mask) | (msrs->values[slot].host & ~mask);
+	if (value == msrs->values[slot].curr)
+		return 0;
+	err = wrmsrq_safe(kvm_uret_msrs_list[slot], value);
+	if (err)
+		return 1;
+
+	msrs->values[slot].curr = value;
+	kvm_user_return_register_notifier(msrs);
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_user_return_msr);
+
+u64 kvm_get_user_return_msr(unsigned int slot)
+{
+	return this_cpu_ptr(&user_return_msrs)->values[slot].curr;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_user_return_msr);
+
+void drop_user_return_notifiers(void)
+{
+	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
+
+	if (msrs->registered)
+		kvm_on_user_return(&msrs->urn);
+}
+
+/*
+ * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
+ * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
+ * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
+ * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
+ * MSRs that KVM emulates without strictly requiring host support.
+ * msr_based_features holds MSRs that enumerate features, i.e. are effectively
+ * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
+ * msrs_to_save and emulated_msrs.
+ */
+
+static const u32 msrs_to_save_base[] = {
+	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
+	MSR_STAR,
+#ifdef CONFIG_X86_64
+	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+#endif
+	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
+	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
+	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
+	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
+	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
+	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
+	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
+	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
+	MSR_IA32_UMWAIT_CONTROL,
+
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR, MSR_IA32_XSS,
+
+	MSR_IA32_U_CET, MSR_IA32_S_CET,
+	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
+	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
+	MSR_IA32_DEBUGCTLMSR,
+	MSR_IA32_LASTBRANCHFROMIP, MSR_IA32_LASTBRANCHTOIP,
+	MSR_IA32_LASTINTFROMIP, MSR_IA32_LASTINTTOIP,
+};
+
+static const u32 msrs_to_save_pmu[] = {
+	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
+	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
+	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
+
+	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
+	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
+	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
+	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
+	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
+	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
+
+	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
+	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
+
+	/* This part of MSRs should match KVM_MAX_NR_AMD_GP_COUNTERS. */
+	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
+	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
+	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
+	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+
+	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
+};
+
+static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
+			ARRAY_SIZE(msrs_to_save_pmu)];
+static unsigned num_msrs_to_save;
+
+static const u32 emulated_msrs_all[] = {
+	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
+	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
+
+#ifdef CONFIG_KVM_HYPERV
+	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
+	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
+	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
+	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
+	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
+	HV_X64_MSR_RESET,
+	HV_X64_MSR_VP_INDEX,
+	HV_X64_MSR_VP_RUNTIME,
+	HV_X64_MSR_SCONTROL,
+	HV_X64_MSR_STIMER0_CONFIG,
+	HV_X64_MSR_VP_ASSIST_PAGE,
+	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
+	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
+	HV_X64_MSR_SYNDBG_OPTIONS,
+	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
+	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
+	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
+#endif
+
+	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
+
+	MSR_IA32_TSC_ADJUST,
+	MSR_IA32_TSC_DEADLINE,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+	MSR_IA32_MISC_ENABLE,
+	MSR_IA32_MCG_STATUS,
+	MSR_IA32_MCG_CTL,
+	MSR_IA32_MCG_EXT_CTL,
+	MSR_IA32_SMBASE,
+	MSR_SMI_COUNT,
+	MSR_PLATFORM_INFO,
+	MSR_MISC_FEATURES_ENABLES,
+	MSR_AMD64_VIRT_SPEC_CTRL,
+	MSR_AMD64_TSC_RATIO,
+	MSR_IA32_POWER_CTL,
+	MSR_IA32_UCODE_REV,
+
+	/*
+	 * KVM always supports the "true" VMX control MSRs, even if the host
+	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
+	 * doesn't strictly require them to exist in the host (ignoring that
+	 * KVM would refuse to load in the first place if the core set of MSRs
+	 * aren't supported).
+	 */
+	MSR_IA32_VMX_BASIC,
+	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+	MSR_IA32_VMX_TRUE_EXIT_CTLS,
+	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+	MSR_IA32_VMX_MISC,
+	MSR_IA32_VMX_CR0_FIXED0,
+	MSR_IA32_VMX_CR4_FIXED0,
+	MSR_IA32_VMX_VMCS_ENUM,
+	MSR_IA32_VMX_PROCBASED_CTLS2,
+	MSR_IA32_VMX_EPT_VPID_CAP,
+	MSR_IA32_VMX_VMFUNC,
+
+	MSR_K7_HWCR,
+	MSR_KVM_POLL_CONTROL,
+};
+
+static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
+static unsigned num_emulated_msrs;
+
+/*
+ * List of MSRs that control the existence of MSR-based features, i.e. MSRs
+ * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
+ * feature MSRs, but are handled separately to allow expedited lookups.
+ */
+static const u32 msr_based_features_all_except_vmx[] = {
+	MSR_AMD64_DE_CFG,
+	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+	MSR_PLATFORM_INFO,
+};
+
+static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
+			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
+static unsigned int num_msr_based_features;
+
+int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msrs_to_save,
+			 num_msrs_to_save * sizeof(u32)))
+		return -EFAULT;
+
+	if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
+			 &emulated_msrs, num_emulated_msrs * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int kvm_get_feature_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msr_based_features;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msr_based_features,
+			 num_msr_based_features * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * All feature MSRs except uCode revID, which tracks the currently loaded uCode
+ * patch, are immutable once the vCPU model is defined.
+ */
+static bool kvm_is_immutable_feature_msr(u32 msr)
+{
+	int i;
+
+	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
+		if (msr == msr_based_features_all_except_vmx[i])
+			return msr != MSR_IA32_UCODE_REV;
+	}
+
+	return false;
+}
+
+static bool kvm_is_advertised_msr(u32 msr_index)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msrs_to_save; i++) {
+		if (msrs_to_save[i] == msr_index)
+			return true;
+	}
+
+	for (i = 0; i < num_emulated_msrs; i++) {
+		if (emulated_msrs[i] == msr_index)
+			return true;
+	}
+
+	return false;
+}
+
+
+/*
+ * Some IA32_ARCH_CAPABILITIES bits have dependencies on MSRs that KVM
+ * does not yet virtualize. These include:
+ *   10 - MISC_PACKAGE_CTRLS
+ *   11 - ENERGY_FILTERING_CTL
+ *   12 - DOITM
+ *   18 - FB_CLEAR_CTRL
+ *   21 - XAPIC_DISABLE_STATUS
+ *   23 - OVERCLOCKING_STATUS
+ */
+
+#define KVM_SUPPORTED_ARCH_CAP \
+	(ARCH_CAP_RDCL_NO | ARCH_CAP_IBRS_ALL | ARCH_CAP_RSBA | \
+	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
+	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
+	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO | ARCH_CAP_ITS_NO)
+
+u64 kvm_get_arch_capabilities(void)
+{
+	u64 data = kvm_host.arch_capabilities & KVM_SUPPORTED_ARCH_CAP;
+
+	/*
+	 * If nx_huge_pages is enabled, KVM's shadow paging will ensure that
+	 * the nested hypervisor runs with NX huge pages.  If it is not,
+	 * L1 is anyway vulnerable to ITLB_MULTIHIT exploits from other
+	 * L1 guests, so it need not worry about its own (L2) guests.
+	 */
+	data |= ARCH_CAP_PSCHANGE_MC_NO;
+
+	/*
+	 * If we're doing cache flushes (either "always" or "cond")
+	 * we will do one whenever the guest does a vmlaunch/vmresume.
+	 * If an outer hypervisor is doing the cache flush for us
+	 * (ARCH_CAP_SKIP_VMENTRY_L1DFLUSH), we can safely pass that
+	 * capability to the guest too, and if EPT is disabled we're not
+	 * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
+	 * require a nested hypervisor to do a flush of its own.
+	 */
+	if (l1tf_vmx_mitigation != VMENTER_L1D_FLUSH_NEVER)
+		data |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
+
+	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+		data |= ARCH_CAP_RDCL_NO;
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		data |= ARCH_CAP_SSB_NO;
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
+		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
+		data |= ARCH_CAP_ITS_NO;
+
+	if (!boot_cpu_has(X86_FEATURE_RTM)) {
+		/*
+		 * If RTM=0 because the kernel has disabled TSX, the host might
+		 * have TAA_NO or TSX_CTRL.  Clear TAA_NO (the guest sees RTM=0
+		 * and therefore knows that there cannot be TAA) but keep
+		 * TSX_CTRL: some buggy userspaces leave it set on tsx=on hosts,
+		 * and we want to allow migrating those guests to tsx=off hosts.
+		 */
+		data &= ~ARCH_CAP_TAA_NO;
+	} else if (!boot_cpu_has_bug(X86_BUG_TAA)) {
+		data |= ARCH_CAP_TAA_NO;
+	} else {
+		/*
+		 * Nothing to do here; we emulate TSX_CTRL if present on the
+		 * host so the guest can choose between disabling TSX or
+		 * using VERW to clear CPU buffers.
+		 */
+	}
+
+	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
+		data |= ARCH_CAP_GDS_NO;
+
+	return data;
+}
+
+static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			       bool host_initiated)
+{
+	WARN_ON_ONCE(!host_initiated);
+
+	switch (index) {
+	case MSR_IA32_ARCH_CAPABILITIES:
+		*data = kvm_get_arch_capabilities();
+		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		*data = kvm_caps.supported_perf_cap;
+		break;
+	case MSR_PLATFORM_INFO:
+		*data = MSR_PLATFORM_INFO_CPUID_FAULT;
+		break;
+	case MSR_IA32_UCODE_REV:
+		rdmsrq_safe(index, data);
+		break;
+	default:
+		return kvm_x86_call(get_feature_msr)(index, data);
+	}
+	return 0;
+}
+
+typedef int (*msr_access_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			    bool host_initiated);
+
+static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
+					     u64 *data, bool host_initiated,
+					     enum kvm_msr_access rw,
+					     msr_access_t msr_access_fn)
+{
+	const char *op = rw == MSR_TYPE_W ? "wrmsr" : "rdmsr";
+	int ret;
+
+	BUILD_BUG_ON(rw != MSR_TYPE_R && rw != MSR_TYPE_W);
+
+	/*
+	 * Zero the data on read failures to avoid leaking stack data to the
+	 * guest and/or userspace, e.g. if the failure is ignored below.
+	 */
+	ret = msr_access_fn(vcpu, msr, data, host_initiated);
+	if (ret && rw == MSR_TYPE_R)
+		*data = 0;
+
+	if (ret != KVM_MSR_RET_UNSUPPORTED)
+		return ret;
+
+	/*
+	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
+	 * advertises to userspace, even if an MSR isn't fully supported.
+	 * Simply check that @data is '0', which covers both the write '0' case
+	 * and all reads (in which case @data is zeroed on failure; see above).
+	 */
+	if (host_initiated && !*data && kvm_is_advertised_msr(msr))
+		return 0;
+
+	if (!ignore_msrs) {
+		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
+				      op, msr, *data);
+		return ret;
+	}
+
+	if (report_ignored_msrs)
+		kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n", op, msr, *data);
+
+	return 0;
+}
+
+static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	return kvm_do_msr_access(vcpu, index, data, true, MSR_TYPE_R,
+				 kvm_get_feature_msr);
+}
+
+static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIBRS))
+		return false;
+
+	if (efer & EFER_FFXSR && !guest_cpu_cap_has(vcpu, X86_FEATURE_FXSR_OPT))
+		return false;
+
+	if (efer & EFER_SVME && !guest_cpu_cap_has(vcpu, X86_FEATURE_SVM))
+		return false;
+
+	if (efer & (EFER_LME | EFER_LMA) &&
+	    !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
+		return false;
+
+	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
+		return false;
+
+	return true;
+
+}
+bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+{
+	if (efer & efer_reserved_bits)
+		return false;
+
+	return __kvm_valid_efer(vcpu, efer);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
+
+static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	u64 old_efer = vcpu->arch.efer;
+	u64 efer = msr_info->data;
+	int r;
+
+	if (efer & efer_reserved_bits)
+		return 1;
+
+	if (!msr_info->host_initiated) {
+		if (!__kvm_valid_efer(vcpu, efer))
+			return 1;
+
+		if (is_paging(vcpu) &&
+		    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
+			return 1;
+	}
+
+	efer &= ~EFER_LMA;
+	efer |= vcpu->arch.efer & EFER_LMA;
+
+	r = kvm_x86_call(set_efer)(vcpu, efer);
+	if (r) {
+		WARN_ON(r > 0);
+		return r;
+	}
+
+	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
+		kvm_mmu_reset_context(vcpu);
+
+	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
+	    (efer & EFER_SVME))
+		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
+
+	return 0;
+}
+
+void kvm_enable_efer_bits(u64 mask)
+{
+       efer_reserved_bits &= ~mask;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
+
+bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
+{
+	struct kvm_x86_msr_filter *msr_filter;
+	struct msr_bitmap_range *ranges;
+	struct kvm *kvm = vcpu->kvm;
+	bool allowed;
+	int idx;
+	u32 i;
+
+	/* x2APIC MSRs do not support filtering. */
+	if (index >= 0x800 && index <= 0x8ff)
+		return true;
+
+	idx = srcu_read_lock(&kvm->srcu);
+
+	msr_filter = srcu_dereference(kvm->arch.msr_filter, &kvm->srcu);
+	if (!msr_filter) {
+		allowed = true;
+		goto out;
+	}
+
+	allowed = msr_filter->default_allow;
+	ranges = msr_filter->ranges;
+
+	for (i = 0; i < msr_filter->count; i++) {
+		u32 start = ranges[i].base;
+		u32 end = start + ranges[i].nmsrs;
+		u32 flags = ranges[i].flags;
+		unsigned long *bitmap = ranges[i].bitmap;
+
+		if ((index >= start) && (index < end) && (flags & type)) {
+			allowed = test_bit(index - start, bitmap);
+			break;
+		}
+	}
+
+out:
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return allowed;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_msr_allowed);
+
+/*
+ * Write @data into the MSR specified by @index.  Select MSR specific fault
+ * checks are bypassed if @host_initiated is %true.
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
+			 bool host_initiated)
+{
+	struct msr_data msr;
+
+	switch (index) {
+	case MSR_FS_BASE:
+	case MSR_GS_BASE:
+	case MSR_KERNEL_GS_BASE:
+	case MSR_CSTAR:
+	case MSR_LSTAR:
+		if (is_noncanonical_msr_address(data, vcpu))
+			return 1;
+		break;
+	case MSR_IA32_SYSENTER_EIP:
+	case MSR_IA32_SYSENTER_ESP:
+		/*
+		 * IA32_SYSENTER_ESP and IA32_SYSENTER_EIP cause #GP if
+		 * non-canonical address is written on Intel but not on
+		 * AMD (which ignores the top 32-bits, because it does
+		 * not implement 64-bit SYSENTER).
+		 *
+		 * 64-bit code should hence be able to write a non-canonical
+		 * value on AMD.  Making the address canonical ensures that
+		 * vmentry does not fail on Intel after writing a non-canonical
+		 * value, and that something deterministic happens if the guest
+		 * invokes 64-bit SYSENTER.
+		 */
+		data = __canonical_address(data, max_host_virt_addr_bits());
+		break;
+	case MSR_TSC_AUX:
+		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
+			return 1;
+
+		if (!host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
+			return 1;
+
+		/*
+		 * Per Intel's SDM, bits 63:32 are reserved, but AMD's APM has
+		 * incomplete and conflicting architectural behavior.  Current
+		 * AMD CPUs completely ignore bits 63:32, i.e. they aren't
+		 * reserved and always read as zeros.  Enforce Intel's reserved
+		 * bits check if the guest CPU is Intel compatible, otherwise
+		 * clear the bits.  This ensures cross-vendor migration will
+		 * provide consistent behavior for the guest.
+		 */
+		if (guest_cpuid_is_intel_compatible(vcpu) && (data >> 32) != 0)
+			return 1;
+
+		data = (u32)data;
+		break;
+	case MSR_IA32_U_CET:
+	case MSR_IA32_S_CET:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (!kvm_is_valid_u_s_cet(vcpu, data))
+			return 1;
+		break;
+	case MSR_KVM_INTERNAL_GUEST_SSP:
+		if (!host_initiated)
+			return 1;
+		fallthrough;
+		/*
+		 * Note that the MSR emulation here is flawed when a vCPU
+		 * doesn't support the Intel 64 architecture. The expected
+		 * architectural behavior in this case is that the upper 32
+		 * bits do not exist and should always read '0'. However,
+		 * because the actual hardware on which the virtual CPU is
+		 * running does support Intel 64, XRSTORS/XSAVES in the
+		 * guest could observe behavior that violates the
+		 * architecture. Intercepting XRSTORS/XSAVES for this
+		 * special case isn't deemed worthwhile.
+		 */
+	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
+			return KVM_MSR_RET_UNSUPPORTED;
+		/*
+		 * MSR_IA32_INT_SSP_TAB is not present on processors that do
+		 * not support Intel 64 architecture.
+		 */
+		if (index == MSR_IA32_INT_SSP_TAB && !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (is_noncanonical_msr_address(data, vcpu))
+			return 1;
+		/* All SSP MSRs except MSR_IA32_INT_SSP_TAB must be 4-byte aligned */
+		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
+			return 1;
+		break;
+	}
+
+	msr.data = data;
+	msr.index = index;
+	msr.host_initiated = host_initiated;
+
+	return kvm_x86_call(set_msr)(vcpu, &msr);
+}
+
+static int _kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			bool host_initiated)
+{
+	return __kvm_set_msr(vcpu, index, *data, host_initiated);
+}
+
+static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
+				     u32 index, u64 data, bool host_initiated)
+{
+	return kvm_do_msr_access(vcpu, index, &data, host_initiated, MSR_TYPE_W,
+				 _kvm_set_msr);
+}
+
+/*
+ * Read the MSR specified by @index into @data.  Select MSR specific fault
+ * checks are bypassed if @host_initiated is %true.
+ * Returns 0 on success, non-0 otherwise.
+ * Assumes vcpu_load() was already called.
+ */
+static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			 bool host_initiated)
+{
+	struct msr_data msr;
+	int ret;
+
+	switch (index) {
+	case MSR_TSC_AUX:
+		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
+			return 1;
+
+		if (!host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
+			return 1;
+		break;
+	case MSR_IA32_U_CET:
+	case MSR_IA32_S_CET:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
+			return KVM_MSR_RET_UNSUPPORTED;
+		break;
+	case MSR_KVM_INTERNAL_GUEST_SSP:
+		if (!host_initiated)
+			return 1;
+		fallthrough;
+	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
+			return KVM_MSR_RET_UNSUPPORTED;
+		break;
+	}
+
+	msr.index = index;
+	msr.host_initiated = host_initiated;
+
+	ret = kvm_x86_call(get_msr)(vcpu, &msr);
+	if (!ret)
+		*data = msr.data;
+	return ret;
+}
+
+static int kvm_get_msr_ignored_check(struct kvm_vcpu *vcpu,
+				     u32 index, u64 *data, bool host_initiated)
+{
+	return kvm_do_msr_access(vcpu, index, data, host_initiated, MSR_TYPE_R,
+				 __kvm_get_msr);
+}
+
+int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
+{
+	return __kvm_set_msr(vcpu, index, data, true);
+}
+
+int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
+{
+	return __kvm_get_msr(vcpu, index, data, true);
+}
+
+int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
+{
+	return kvm_get_msr_ignored_check(vcpu, index, data, false);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_emulate_msr_read);
+
+int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
+{
+	return kvm_set_msr_ignored_check(vcpu, index, data, false);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_emulate_msr_write);
+
+int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
+{
+	if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_READ))
+		return KVM_MSR_RET_FILTERED;
+
+	return __kvm_emulate_msr_read(vcpu, index, data);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_read);
+
+int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
+{
+	if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_WRITE))
+		return KVM_MSR_RET_FILTERED;
+
+	return __kvm_emulate_msr_write(vcpu, index, data);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
+
+static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
+	switch (msr) {
+	case APIC_BASE_MSR + (APIC_ICR >> 4):
+		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
+		    kvm_x2apic_icr_write_fast(vcpu->arch.apic, data))
+			return EXIT_FASTPATH_NONE;
+		break;
+	case MSR_IA32_TSC_DEADLINE:
+		kvm_set_lapic_tscdeadline_msr(vcpu, data);
+		break;
+	default:
+		return EXIT_FASTPATH_NONE;
+	}
+
+	trace_kvm_msr_write(msr, data);
+
+	if (!kvm_skip_emulated_instruction(vcpu))
+		return EXIT_FASTPATH_EXIT_USERSPACE;
+
+	return EXIT_FASTPATH_REENTER_GUEST;
+}
+
+fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
+{
+	return __handle_fastpath_wrmsr(vcpu, kvm_ecx_read(vcpu),
+				       kvm_read_edx_eax(vcpu));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr);
+
+fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	return __handle_fastpath_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr_imm);
+
+static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->run->msr.error) {
+		kvm_eax_write(vcpu, vcpu->run->msr.data);
+		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
+	}
+}
+
+static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
+{
+	if (err) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
+	return kvm_emulate_instruction(vcpu, EMULTYPE_NO_DECODE | EMULTYPE_SKIP |
+				       EMULTYPE_COMPLETE_USER_EXIT);
+}
+
+static int complete_emulated_msr_access(struct kvm_vcpu *vcpu)
+{
+	return complete_emulated_insn_gp(vcpu, vcpu->run->msr.error);
+}
+
+static int complete_emulated_rdmsr(struct kvm_vcpu *vcpu)
+{
+	complete_userspace_rdmsr(vcpu);
+	return complete_emulated_msr_access(vcpu);
+}
+
+static int complete_fast_msr_access(struct kvm_vcpu *vcpu)
+{
+	return kvm_x86_call(complete_emulated_msr)(vcpu, vcpu->run->msr.error);
+}
+
+static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
+{
+	complete_userspace_rdmsr(vcpu);
+	return complete_fast_msr_access(vcpu);
+}
+
+static int complete_fast_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->run->msr.error)
+		kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
+				   vcpu->run->msr.data);
+
+	return complete_fast_msr_access(vcpu);
+}
+
+static u64 kvm_msr_reason(int r)
+{
+	switch (r) {
+	case KVM_MSR_RET_UNSUPPORTED:
+		return KVM_MSR_EXIT_REASON_UNKNOWN;
+	case KVM_MSR_RET_FILTERED:
+		return KVM_MSR_EXIT_REASON_FILTER;
+	default:
+		return KVM_MSR_EXIT_REASON_INVAL;
+	}
+}
+
+static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
+			      u32 exit_reason, u64 data,
+			      int (*completion)(struct kvm_vcpu *vcpu),
+			      int r)
+{
+	u64 msr_reason = kvm_msr_reason(r);
+
+	/* Check if the user wanted to know about this MSR fault */
+	if (!(vcpu->kvm->arch.user_space_msr_mask & msr_reason))
+		return 0;
+
+	vcpu->run->exit_reason = exit_reason;
+	vcpu->run->msr.error = 0;
+	memset(vcpu->run->msr.pad, 0, sizeof(vcpu->run->msr.pad));
+	vcpu->run->msr.reason = msr_reason;
+	vcpu->run->msr.index = index;
+	vcpu->run->msr.data = data;
+	vcpu->arch.complete_userspace_io = completion;
+
+	return 1;
+}
+
+static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
+			       int (*complete_rdmsr)(struct kvm_vcpu *))
+{
+	u64 data;
+	int r;
+
+	r = kvm_emulate_msr_read(vcpu, msr, &data);
+
+	if (!r) {
+		trace_kvm_msr_read(msr, data);
+
+		if (reg < 0) {
+			kvm_eax_write(vcpu, data);
+			kvm_edx_write(vcpu, data >> 32);
+		} else {
+			kvm_register_write(vcpu, reg, data);
+		}
+	} else {
+		/* MSR read failed? See if we should ask user space */
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
+				       complete_rdmsr, r))
+			return 0;
+		trace_kvm_msr_read_ex(msr);
+	}
+
+	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
+}
+
+int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_rdmsr(vcpu, kvm_ecx_read(vcpu), -1,
+				   complete_fast_rdmsr);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr);
+
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	vcpu->arch.cui_rdmsr_imm_reg = reg;
+
+	return __kvm_emulate_rdmsr(vcpu, msr, reg, complete_fast_rdmsr_imm);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr_imm);
+
+static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	int r;
+
+	r = kvm_emulate_msr_write(vcpu, msr, data);
+	if (!r) {
+		trace_kvm_msr_write(msr, data);
+	} else {
+		/* MSR write failed? See if we should ask user space */
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_WRMSR, data,
+				       complete_fast_msr_access, r))
+			return 0;
+		/* Signal all other negative errors to userspace */
+		if (r < 0)
+			return r;
+		trace_kvm_msr_write_ex(msr, data);
+	}
+
+	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
+}
+
+int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_wrmsr(vcpu, kvm_ecx_read(vcpu),
+				   kvm_read_edx_eax(vcpu));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr);
+
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	return __kvm_emulate_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr_imm);
+
+int kvm_emulator_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
+				     u64 *pdata)
+{
+	int r;
+
+	r = kvm_emulate_msr_read(vcpu, msr_index, pdata);
+	if (r < 0)
+		return X86EMUL_UNHANDLEABLE;
+
+	if (r) {
+		if (kvm_msr_user_space(vcpu, msr_index, KVM_EXIT_X86_RDMSR, 0,
+				       complete_emulated_rdmsr, r))
+			return X86EMUL_IO_NEEDED;
+
+		trace_kvm_msr_read_ex(msr_index);
+		return X86EMUL_PROPAGATE_FAULT;
+	}
+
+	trace_kvm_msr_read(msr_index, *pdata);
+	return X86EMUL_CONTINUE;
+}
+
+int kvm_emulator_set_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
+				     u64 data)
+{
+	int r;
+
+	r = kvm_emulate_msr_write(vcpu, msr_index, data);
+	if (r < 0)
+		return X86EMUL_UNHANDLEABLE;
+
+	if (r) {
+		if (kvm_msr_user_space(vcpu, msr_index, KVM_EXIT_X86_WRMSR, data,
+				       complete_emulated_msr_access, r))
+			return X86EMUL_IO_NEEDED;
+
+		trace_kvm_msr_write_ex(msr_index, data);
+		return X86EMUL_PROPAGATE_FAULT;
+	}
+
+	trace_kvm_msr_write(msr_index, data);
+	return X86EMUL_CONTINUE;
+}
+
+int kvm_emulator_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
+{
+	/*
+	 * Treat emulator accesses to the current shadow stack pointer as host-
+	 * initiated, as they aren't true MSR accesses (SSP is a "just a reg"),
+	 * and this API is used only for implicit accesses, i.e. not RDMSR, and
+	 * so the index is fully KVM-controlled.
+	 */
+	if (unlikely(msr_index == MSR_KVM_INTERNAL_GUEST_SSP))
+		return kvm_msr_read(vcpu, msr_index, pdata);
+
+	return __kvm_emulate_msr_read(vcpu, msr_index, pdata);
+}
+
+/*
+ * Returns true if the MSR in question is managed via XSTATE, i.e. is context
+ * switched with the rest of guest FPU state.
+ *
+ * Note, S_CET is _not_ saved/restored via XSAVES/XRSTORS.
+ */
+static bool is_xstate_managed_msr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (!vcpu)
+		return false;
+
+	switch (msr) {
+	case MSR_IA32_U_CET:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ||
+		       guest_cpu_cap_has(vcpu, X86_FEATURE_IBT);
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+	default:
+		return false;
+	}
+}
+
+/*
+ * Lock (and if necessary, re-load) the guest FPU, i.e. XSTATE, and access an
+ * MSR that is managed via XSTATE.  Note, the caller is responsible for doing
+ * the initial FPU load, this helper only ensures that guest state is resident
+ * in hardware (the kernel can load its FPU state in IRQ context).
+ *
+ * Note, loading guest values for U_CET and PL[0-3]_SSP while executing in the
+ * kernel is safe, as U_CET is specific to userspace, and PL[0-3]_SSP are only
+ * consumed when transitioning to lower privilege levels, i.e. are effectively
+ * only consumed by userspace as well.
+ */
+static __always_inline void kvm_access_xstate_msr(struct kvm_vcpu *vcpu,
+						  struct msr_data *msr_info,
+						  int access)
+{
+	BUILD_BUG_ON(access != MSR_TYPE_R && access != MSR_TYPE_W);
+
+	KVM_BUG_ON(!is_xstate_managed_msr(vcpu, msr_info->index), vcpu->kvm);
+	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
+
+	kvm_fpu_get();
+	if (access == MSR_TYPE_R)
+		rdmsrq(msr_info->index, msr_info->data);
+	else
+		wrmsrq(msr_info->index, msr_info->data);
+	kvm_fpu_put();
+}
+
+static void kvm_set_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_W);
+}
+
+static void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
+}
+
+static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
+{
+	int version;
+	int r;
+	struct pvclock_wall_clock wc;
+	u32 wc_sec_hi;
+	u64 wall_nsec;
+
+	if (!wall_clock)
+		return;
+
+	r = kvm_read_guest(kvm, wall_clock, &version, sizeof(version));
+	if (r)
+		return;
+
+	if (version & 1)
+		++version;  /* first time write, random junk */
+
+	++version;
+
+	if (kvm_write_guest(kvm, wall_clock, &version, sizeof(version)))
+		return;
+
+	wall_nsec = kvm_get_wall_clock_epoch(kvm);
+
+	wc.nsec = do_div(wall_nsec, NSEC_PER_SEC);
+	wc.sec = (u32)wall_nsec; /* overflow in 2106 guest time */
+	wc.version = version;
+
+	kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
+
+	if (sec_hi_ofs) {
+		wc_sec_hi = wall_nsec >> 32;
+		kvm_write_guest(kvm, wall_clock + sec_hi_ofs,
+				&wc_sec_hi, sizeof(wc_sec_hi));
+	}
+
+	version++;
+	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
+}
+
+static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
+				  bool old_msr, bool host_initiated)
+{
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+
+	if (vcpu->vcpu_id == 0 && !host_initiated) {
+		if (ka->boot_vcpu_runs_old_kvmclock != old_msr)
+			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
+
+		ka->boot_vcpu_runs_old_kvmclock = old_msr;
+	}
+
+	vcpu->arch.time = system_time;
+	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
+
+	/* we verify if the enable bit is set... */
+	if (system_time & 1)
+		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
+				 sizeof(struct pvclock_vcpu_time_info));
+	else
+		kvm_gpc_deactivate(&vcpu->arch.pv_time);
+
+	return;
+}
+
+/* These helpers are safe iff @msr is known to be an MCx bank MSR. */
+static bool is_mci_control_msr(u32 msr)
+{
+	return (msr & 3) == 0;
+}
+static bool is_mci_status_msr(u32 msr)
+{
+	return (msr & 3) == 1;
+}
+
+/*
+ * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
+ */
+static bool can_set_mci_status(struct kvm_vcpu *vcpu)
+{
+	/* McStatusWrEn enabled? */
+	if (guest_cpuid_is_amd_compatible(vcpu))
+		return !!(vcpu->arch.msr_hwcr & BIT_ULL(18));
+
+	return false;
+}
+
+static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	u64 mcg_cap = vcpu->arch.mcg_cap;
+	unsigned bank_num = mcg_cap & 0xff;
+	u32 msr = msr_info->index;
+	u64 data = msr_info->data;
+	u32 offset, last_msr;
+
+	switch (msr) {
+	case MSR_IA32_MCG_STATUS:
+		vcpu->arch.mcg_status = data;
+		break;
+	case MSR_IA32_MCG_CTL:
+		if (!(mcg_cap & MCG_CTL_P) &&
+		    (data || !msr_info->host_initiated))
+			return 1;
+		if (data != 0 && data != ~(u64)0)
+			return 1;
+		vcpu->arch.mcg_ctl = data;
+		break;
+	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
+		last_msr = MSR_IA32_MCx_CTL2(bank_num) - 1;
+		if (msr > last_msr)
+			return 1;
+
+		if (!(mcg_cap & MCG_CMCI_P) && (data || !msr_info->host_initiated))
+			return 1;
+		/* An attempt to write a 1 to a reserved bit raises #GP */
+		if (data & ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK))
+			return 1;
+		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL2,
+					    last_msr + 1 - MSR_IA32_MC0_CTL2);
+		vcpu->arch.mci_ctl2_banks[offset] = data;
+		break;
+	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
+		last_msr = MSR_IA32_MCx_CTL(bank_num) - 1;
+		if (msr > last_msr)
+			return 1;
+
+		/*
+		 * Only 0 or all 1s can be written to IA32_MCi_CTL, all other
+		 * values are architecturally undefined.  But, some Linux
+		 * kernels clear bit 10 in bank 4 to workaround a BIOS/GART TLB
+		 * issue on AMD K8s, allow bit 10 to be clear when setting all
+		 * other bits in order to avoid an uncaught #GP in the guest.
+		 *
+		 * UNIXWARE clears bit 0 of MC1_CTL to ignore correctable,
+		 * single-bit ECC data errors.
+		 */
+		if (is_mci_control_msr(msr) &&
+		    data != 0 && (data | (1 << 10) | 1) != ~(u64)0)
+			return 1;
+
+		/*
+		 * All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR.
+		 * AMD-based CPUs allow non-zero values, but if and only if
+		 * HWCR[McStatusWrEn] is set.
+		 */
+		if (!msr_info->host_initiated && is_mci_status_msr(msr) &&
+		    data != 0 && !can_set_mci_status(vcpu))
+			return 1;
+
+		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
+					    last_msr + 1 - MSR_IA32_MC0_CTL);
+		vcpu->arch.mce_banks[offset] = data;
+		break;
+	default:
+		return 1;
+	}
+	return 0;
+}
+
+static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
+{
+	gpa_t gpa = data & ~0x3f;
+
+	/* Bits 4:5 are reserved, Should be zero */
+	if (data & 0x30)
+		return 1;
+
+	if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_VMEXIT) &&
+	    (data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT))
+		return 1;
+
+	if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT) &&
+	    (data & KVM_ASYNC_PF_DELIVERY_AS_INT))
+		return 1;
+
+	if (!lapic_in_kernel(vcpu))
+		return data ? 1 : 0;
+
+	if (__kvm_pv_async_pf_enabled(data) &&
+	    kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
+				      sizeof(u64)))
+		return 1;
+
+	vcpu->arch.apf.msr_en_val = data;
+
+	if (__kvm_pv_async_pf_enabled(data)) {
+		kvm_async_pf_wakeup_all(vcpu);
+	} else {
+		kvm_clear_async_pf_completion_queue(vcpu);
+		kvm_async_pf_hash_reset(vcpu);
+	}
+	return 0;
+}
+
+static int kvm_pv_enable_async_pf_int(struct kvm_vcpu *vcpu, u64 data)
+{
+	/* Bits 8-63 are reserved */
+	if (data >> 8)
+		return 1;
+
+	if (!lapic_in_kernel(vcpu))
+		return 1;
+
+	vcpu->arch.apf.msr_int_val = data;
+
+	vcpu->arch.apf.vec = data & KVM_ASYNC_PF_VEC_MASK;
+
+	return 0;
+}
+
+#ifdef CONFIG_X86_64
+static inline u64 kvm_guest_supported_xfd(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_supported_xcr0 & XFEATURE_MASK_USER_DYNAMIC;
+}
+#endif
+
+int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	u32 msr = msr_info->index;
+	u64 data = msr_info->data;
+
+	/*
+	 * Do not allow host-initiated writes to trigger the Xen hypercall
+	 * page setup; it could incur locking paths which are not expected
+	 * if userspace sets the MSR in an unusual location.
+	 */
+	if (kvm_xen_is_hypercall_page_msr(vcpu->kvm, msr) &&
+	    !msr_info->host_initiated)
+		return kvm_xen_write_hypercall_page(vcpu, data);
+
+	switch (msr) {
+	case MSR_AMD64_NB_CFG:
+	case MSR_IA32_UCODE_WRITE:
+	case MSR_VM_HSAVE_PA:
+	case MSR_AMD64_PATCH_LOADER:
+	case MSR_AMD64_BU_CFG2:
+	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
+	case MSR_F15H_EX_CFG:
+		break;
+
+	case MSR_IA32_UCODE_REV:
+		if (msr_info->host_initiated)
+			vcpu->arch.microcode_version = data;
+		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated ||
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return KVM_MSR_RET_UNSUPPORTED;
+		vcpu->arch.arch_capabilities = data;
+		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		if (!msr_info->host_initiated ||
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (data & ~kvm_caps.supported_perf_cap)
+			return 1;
+
+		/*
+		 * Note, this is not just a performance optimization!  KVM
+		 * disallows changing feature MSRs after the vCPU has run; PMU
+		 * refresh will bug the VM if called after the vCPU has run.
+		 */
+		if (vcpu->arch.perf_capabilities == data)
+			break;
+
+		vcpu->arch.perf_capabilities = data;
+		kvm_pmu_refresh(vcpu);
+		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
+		break;
+	case MSR_IA32_PRED_CMD: {
+		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
+
+		if (!msr_info->host_initiated) {
+			if ((!guest_has_pred_cmd_msr(vcpu)))
+				return 1;
+
+			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+			    !guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBPB))
+				reserved_bits |= PRED_CMD_IBPB;
+
+			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SBPB))
+				reserved_bits |= PRED_CMD_SBPB;
+		}
+
+		if (!boot_cpu_has(X86_FEATURE_IBPB))
+			reserved_bits |= PRED_CMD_IBPB;
+
+		if (!boot_cpu_has(X86_FEATURE_SBPB))
+			reserved_bits |= PRED_CMD_SBPB;
+
+		if (data & reserved_bits)
+			return 1;
+
+		if (!data)
+			break;
+
+		wrmsrq(MSR_IA32_PRED_CMD, data);
+		break;
+	}
+	case MSR_IA32_FLUSH_CMD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D))
+			return 1;
+
+		if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D) || (data & ~L1D_FLUSH))
+			return 1;
+		if (!data)
+			break;
+
+		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		break;
+	case MSR_EFER:
+		return set_efer(vcpu, msr_info);
+	case MSR_K7_HWCR: {
+		/*
+		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
+		 * through at least v6.6 whine if TscFreqSel is clear,
+		 * depending on F/M/S.
+		 */
+		u64 valid = BIT_ULL(18) | BIT_ULL(24);
+
+		data &= ~(u64)0x40;	/* ignore flush filter disable */
+		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
+		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
+			valid |= MSR_K7_HWCR_CPUID_USER_DIS;
+
+		if (data & ~valid) {
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+			return 1;
+		}
+		vcpu->arch.msr_hwcr = data;
+		break;
+	}
+	case MSR_FAM10H_MMIO_CONF_BASE:
+		if (data != 0) {
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+			return 1;
+		}
+		break;
+	case MSR_IA32_CR_PAT:
+		if (!kvm_pat_valid(data))
+			return 1;
+
+		vcpu->arch.pat = data;
+		break;
+	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
+	case MSR_MTRRdefType:
+		return kvm_mtrr_set_msr(vcpu, msr, data);
+	case MSR_IA32_APICBASE:
+		return kvm_apic_set_base(vcpu, data, msr_info->host_initiated);
+	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
+		return kvm_x2apic_msr_write(vcpu, msr, data);
+	case MSR_IA32_TSC_DEADLINE:
+		kvm_set_lapic_tscdeadline_msr(vcpu, data);
+		break;
+	case MSR_IA32_TSC_ADJUST:
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_TSC_ADJUST)) {
+			if (!msr_info->host_initiated) {
+				s64 adj = data - vcpu->arch.ia32_tsc_adjust_msr;
+				adjust_tsc_offset_guest(vcpu, adj);
+				/* Before back to guest, tsc_timestamp must be adjusted
+				 * as well, otherwise guest's percpu pvclock time could jump.
+				 */
+				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+			}
+			vcpu->arch.ia32_tsc_adjust_msr = data;
+		}
+		break;
+	case MSR_IA32_MISC_ENABLE: {
+		u64 old_val = vcpu->arch.ia32_misc_enable_msr;
+
+		if (!msr_info->host_initiated) {
+			/* RO bits */
+			if ((old_val ^ data) & MSR_IA32_MISC_ENABLE_PMU_RO_MASK)
+				return 1;
+
+			/* R bits, i.e. writes are ignored, but don't fault. */
+			data = data & ~MSR_IA32_MISC_ENABLE_EMON;
+			data |= old_val & MSR_IA32_MISC_ENABLE_EMON;
+		}
+
+		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT) &&
+		    ((old_val ^ data)  & MSR_IA32_MISC_ENABLE_MWAIT)) {
+			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XMM3))
+				return 1;
+			vcpu->arch.ia32_misc_enable_msr = data;
+			vcpu->arch.cpuid_dynamic_bits_dirty = true;
+		} else {
+			vcpu->arch.ia32_misc_enable_msr = data;
+		}
+		break;
+	}
+	case MSR_IA32_SMBASE:
+		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
+			return 1;
+		vcpu->arch.smbase = data;
+		break;
+	case MSR_IA32_POWER_CTL:
+		vcpu->arch.msr_ia32_power_ctl = data;
+		break;
+	case MSR_IA32_TSC:
+		if (msr_info->host_initiated) {
+			kvm_synchronize_tsc(vcpu, &data);
+		} else if (!vcpu->arch.guest_tsc_protected) {
+			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
+			adjust_tsc_offset_guest(vcpu, adj);
+			vcpu->arch.ia32_tsc_adjust_msr += adj;
+		}
+		break;
+	case MSR_IA32_XSS:
+		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (data & ~vcpu->arch.guest_supported_xss)
+			return 1;
+		if (vcpu->arch.ia32_xss == data)
+			break;
+		vcpu->arch.ia32_xss = data;
+		vcpu->arch.cpuid_dynamic_bits_dirty = true;
+		break;
+	case MSR_SMI_COUNT:
+		if (!msr_info->host_initiated)
+			return 1;
+		vcpu->arch.smi_count = data;
+		break;
+	case MSR_KVM_WALL_CLOCK_NEW:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		vcpu->kvm->arch.wall_clock = data;
+		kvm_write_wall_clock(vcpu->kvm, data, 0);
+		break;
+	case MSR_KVM_WALL_CLOCK:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		vcpu->kvm->arch.wall_clock = data;
+		kvm_write_wall_clock(vcpu->kvm, data, 0);
+		break;
+	case MSR_KVM_SYSTEM_TIME_NEW:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		kvm_write_system_time(vcpu, data, false, msr_info->host_initiated);
+		break;
+	case MSR_KVM_SYSTEM_TIME:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		kvm_write_system_time(vcpu, data, true,  msr_info->host_initiated);
+		break;
+	case MSR_KVM_ASYNC_PF_EN:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (kvm_pv_enable_async_pf(vcpu, data))
+			return 1;
+		break;
+	case MSR_KVM_ASYNC_PF_INT:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (kvm_pv_enable_async_pf_int(vcpu, data))
+			return 1;
+		break;
+	case MSR_KVM_ASYNC_PF_ACK:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (data & 0x1) {
+			/*
+			 * Pairs with the smp_mb__after_atomic() in
+			 * kvm_arch_async_page_present_queued().
+			 */
+			smp_store_mb(vcpu->arch.apf.pageready_pending, false);
+
+			kvm_check_async_pf_completion(vcpu);
+		}
+		break;
+	case MSR_KVM_STEAL_TIME:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (unlikely(!sched_info_on()))
+			return 1;
+
+		if (data & KVM_STEAL_RESERVED_MASK)
+			return 1;
+
+		vcpu->arch.st.msr_val = data;
+
+		if (!(data & KVM_MSR_ENABLED))
+			break;
+
+		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+
+		break;
+	case MSR_KVM_PV_EOI_EN:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (kvm_lapic_set_pv_eoi(vcpu, data, sizeof(u8)))
+			return 1;
+		break;
+
+	case MSR_KVM_POLL_CONTROL:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		/* only enable bit supported */
+		if (data & (-1ULL << 1))
+			return 1;
+
+		vcpu->arch.msr_kvm_poll_control = data;
+		break;
+
+	case MSR_IA32_MCG_CTL:
+	case MSR_IA32_MCG_STATUS:
+	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
+	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
+		return set_msr_mce(vcpu, msr_info);
+
+	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
+	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
+	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
+	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
+		if (kvm_pmu_is_valid_msr(vcpu, msr))
+			return kvm_pmu_set_msr(vcpu, msr_info);
+
+		if (data)
+			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+		break;
+	case MSR_K7_CLK_CTL:
+		/*
+		 * Ignore all writes to this no longer documented MSR.
+		 * Writes are only relevant for old K7 processors,
+		 * all pre-dating SVM, but a recommended workaround from
+		 * AMD for these chips. It is possible to specify the
+		 * affected processor models on the command line, hence
+		 * the need to ignore the workaround.
+		 */
+		break;
+#ifdef CONFIG_KVM_HYPERV
+	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
+	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
+	case HV_X64_MSR_SYNDBG_OPTIONS:
+	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
+	case HV_X64_MSR_CRASH_CTL:
+	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
+		return kvm_hv_set_msr_common(vcpu, msr, data,
+					     msr_info->host_initiated);
+#endif
+	case MSR_IA32_BBL_CR_CTL3:
+		/* Drop writes to this legacy MSR -- see rdmsr
+		 * counterpart for further detail.
+		 */
+		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+		break;
+	case MSR_AMD64_OSVW_ID_LENGTH:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
+			return 1;
+		vcpu->arch.osvw.length = data;
+		break;
+	case MSR_AMD64_OSVW_STATUS:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
+			return 1;
+		vcpu->arch.osvw.status = data;
+		break;
+	case MSR_PLATFORM_INFO:
+		if (!msr_info->host_initiated)
+			return 1;
+		vcpu->arch.msr_platform_info = data;
+		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
+		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
+		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
+			return 1;
+		vcpu->arch.msr_misc_features_enables = data;
+		break;
+#ifdef CONFIG_X86_64
+	case MSR_IA32_XFD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		if (data & ~kvm_guest_supported_xfd(vcpu))
+			return 1;
+
+		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
+		break;
+	case MSR_IA32_XFD_ERR:
+		if (!msr_info->host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		if (data & ~kvm_guest_supported_xfd(vcpu))
+			return 1;
+
+		vcpu->arch.guest_fpu.xfd_err = data;
+		break;
+#endif
+	case MSR_IA32_U_CET:
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		kvm_set_xstate_msr(vcpu, msr_info);
+		break;
+	default:
+		if (kvm_pmu_is_valid_msr(vcpu, msr))
+			return kvm_pmu_set_msr(vcpu, msr_info);
+
+		return KVM_MSR_RET_UNSUPPORTED;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_msr_common);
+
+static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
+{
+	u64 data;
+	u64 mcg_cap = vcpu->arch.mcg_cap;
+	unsigned bank_num = mcg_cap & 0xff;
+	u32 offset, last_msr;
+
+	switch (msr) {
+	case MSR_IA32_P5_MC_ADDR:
+	case MSR_IA32_P5_MC_TYPE:
+		data = 0;
+		break;
+	case MSR_IA32_MCG_CAP:
+		data = vcpu->arch.mcg_cap;
+		break;
+	case MSR_IA32_MCG_CTL:
+		if (!(mcg_cap & MCG_CTL_P) && !host)
+			return 1;
+		data = vcpu->arch.mcg_ctl;
+		break;
+	case MSR_IA32_MCG_STATUS:
+		data = vcpu->arch.mcg_status;
+		break;
+	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
+		last_msr = MSR_IA32_MCx_CTL2(bank_num) - 1;
+		if (msr > last_msr)
+			return 1;
+
+		if (!(mcg_cap & MCG_CMCI_P) && !host)
+			return 1;
+		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL2,
+					    last_msr + 1 - MSR_IA32_MC0_CTL2);
+		data = vcpu->arch.mci_ctl2_banks[offset];
+		break;
+	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
+		last_msr = MSR_IA32_MCx_CTL(bank_num) - 1;
+		if (msr > last_msr)
+			return 1;
+
+		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
+					    last_msr + 1 - MSR_IA32_MC0_CTL);
+		data = vcpu->arch.mce_banks[offset];
+		break;
+	default:
+		return 1;
+	}
+	*pdata = data;
+	return 0;
+}
+
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	switch (msr_info->index) {
+	case MSR_IA32_PLATFORM_ID:
+	case MSR_IA32_EBL_CR_POWERON:
+	case MSR_IA32_LASTBRANCHFROMIP:
+	case MSR_IA32_LASTBRANCHTOIP:
+	case MSR_IA32_LASTINTFROMIP:
+	case MSR_IA32_LASTINTTOIP:
+	case MSR_AMD64_SYSCFG:
+	case MSR_K8_TSEG_ADDR:
+	case MSR_K8_TSEG_MASK:
+	case MSR_VM_HSAVE_PA:
+	case MSR_K8_INT_PENDING_MSG:
+	case MSR_AMD64_NB_CFG:
+	case MSR_FAM10H_MMIO_CONF_BASE:
+	case MSR_AMD64_BU_CFG2:
+	case MSR_IA32_PERF_CTL:
+	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
+	case MSR_F15H_EX_CFG:
+	/*
+	 * Intel Sandy Bridge CPUs must support the RAPL (running average power
+	 * limit) MSRs. Just return 0, as we do not want to expose the host
+	 * data here. Do not conditionalize this on CPUID, as KVM does not do
+	 * so for existing CPU-specific MSRs.
+	 */
+	case MSR_RAPL_POWER_UNIT:
+	case MSR_PP0_ENERGY_STATUS:	/* Power plane 0 (core) */
+	case MSR_PP1_ENERGY_STATUS:	/* Power plane 1 (graphics uncore) */
+	case MSR_PKG_ENERGY_STATUS:	/* Total package */
+	case MSR_DRAM_ENERGY_STATUS:	/* DRAM controller */
+		msr_info->data = 0;
+		break;
+	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
+	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
+	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
+	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
+		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
+			return kvm_pmu_get_msr(vcpu, msr_info);
+		msr_info->data = 0;
+		break;
+	case MSR_IA32_UCODE_REV:
+		msr_info->data = vcpu->arch.microcode_version;
+		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return KVM_MSR_RET_UNSUPPORTED;
+		msr_info->data = vcpu->arch.arch_capabilities;
+		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
+			return KVM_MSR_RET_UNSUPPORTED;
+		msr_info->data = vcpu->arch.perf_capabilities;
+		break;
+	case MSR_IA32_POWER_CTL:
+		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
+		break;
+	case MSR_IA32_TSC: {
+		/*
+		 * Intel SDM states that MSR_IA32_TSC read adds the TSC offset
+		 * even when not intercepted. AMD manual doesn't explicitly
+		 * state this but appears to behave the same.
+		 *
+		 * On userspace reads and writes, however, we unconditionally
+		 * return L1's TSC value to ensure backwards-compatible
+		 * behavior for migration.
+		 */
+		u64 offset, ratio;
+
+		if (msr_info->host_initiated) {
+			offset = vcpu->arch.l1_tsc_offset;
+			ratio = vcpu->arch.l1_tsc_scaling_ratio;
+		} else {
+			offset = vcpu->arch.tsc_offset;
+			ratio = vcpu->arch.tsc_scaling_ratio;
+		}
+
+		msr_info->data = kvm_scale_tsc(rdtsc(), ratio) + offset;
+		break;
+	}
+	case MSR_IA32_CR_PAT:
+		msr_info->data = vcpu->arch.pat;
+		break;
+	case MSR_MTRRcap:
+	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
+	case MSR_MTRRdefType:
+		return kvm_mtrr_get_msr(vcpu, msr_info->index, &msr_info->data);
+	case 0xcd: /* fsb frequency */
+		msr_info->data = 3;
+		break;
+		/*
+		 * MSR_EBC_FREQUENCY_ID
+		 * Conservative value valid for even the basic CPU models.
+		 * Models 0,1: 000 in bits 23:21 indicating a bus speed of
+		 * 100MHz, model 2 000 in bits 18:16 indicating 100MHz,
+		 * and 266MHz for model 3, or 4. Set Core Clock
+		 * Frequency to System Bus Frequency Ratio to 1 (bits
+		 * 31:24) even though these are only valid for CPU
+		 * models > 2, however guests may end up dividing or
+		 * multiplying by zero otherwise.
+		 */
+	case MSR_EBC_FREQUENCY_ID:
+		msr_info->data = 1 << 24;
+		break;
+	case MSR_IA32_APICBASE:
+		msr_info->data = vcpu->arch.apic_base;
+		break;
+	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
+		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
+	case MSR_IA32_TSC_DEADLINE:
+		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
+		break;
+	case MSR_IA32_TSC_ADJUST:
+		msr_info->data = (u64)vcpu->arch.ia32_tsc_adjust_msr;
+		break;
+	case MSR_IA32_MISC_ENABLE:
+		msr_info->data = vcpu->arch.ia32_misc_enable_msr;
+		break;
+	case MSR_IA32_SMBASE:
+		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
+			return 1;
+		msr_info->data = vcpu->arch.smbase;
+		break;
+	case MSR_SMI_COUNT:
+		msr_info->data = vcpu->arch.smi_count;
+		break;
+	case MSR_IA32_PERF_STATUS:
+		/* TSC increment by tick */
+		msr_info->data = 1000ULL;
+		/* CPU multiplier */
+		msr_info->data |= (((uint64_t)4ULL) << 40);
+		break;
+	case MSR_EFER:
+		msr_info->data = vcpu->arch.efer;
+		break;
+	case MSR_KVM_WALL_CLOCK:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->kvm->arch.wall_clock;
+		break;
+	case MSR_KVM_WALL_CLOCK_NEW:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->kvm->arch.wall_clock;
+		break;
+	case MSR_KVM_SYSTEM_TIME:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.time;
+		break;
+	case MSR_KVM_SYSTEM_TIME_NEW:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.time;
+		break;
+	case MSR_KVM_ASYNC_PF_EN:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.apf.msr_en_val;
+		break;
+	case MSR_KVM_ASYNC_PF_INT:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.apf.msr_int_val;
+		break;
+	case MSR_KVM_ASYNC_PF_ACK:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = 0;
+		break;
+	case MSR_KVM_STEAL_TIME:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.st.msr_val;
+		break;
+	case MSR_KVM_PV_EOI_EN:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.pv_eoi.msr_val;
+		break;
+	case MSR_KVM_POLL_CONTROL:
+		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		msr_info->data = vcpu->arch.msr_kvm_poll_control;
+		break;
+	case MSR_IA32_P5_MC_ADDR:
+	case MSR_IA32_P5_MC_TYPE:
+	case MSR_IA32_MCG_CAP:
+	case MSR_IA32_MCG_CTL:
+	case MSR_IA32_MCG_STATUS:
+	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
+	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
+		return get_msr_mce(vcpu, msr_info->index, &msr_info->data,
+				   msr_info->host_initiated);
+	case MSR_IA32_XSS:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
+			return 1;
+		msr_info->data = vcpu->arch.ia32_xss;
+		break;
+	case MSR_K7_CLK_CTL:
+		/*
+		 * Provide expected ramp-up count for K7. All other
+		 * are set to zero, indicating minimum divisors for
+		 * every field.
+		 *
+		 * This prevents guest kernels on AMD host with CPU
+		 * type 6, model 8 and higher from exploding due to
+		 * the rdmsr failing.
+		 */
+		msr_info->data = 0x20000000;
+		break;
+#ifdef CONFIG_KVM_HYPERV
+	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
+	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
+	case HV_X64_MSR_SYNDBG_OPTIONS:
+	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
+	case HV_X64_MSR_CRASH_CTL:
+	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
+		return kvm_hv_get_msr_common(vcpu,
+					     msr_info->index, &msr_info->data,
+					     msr_info->host_initiated);
+#endif
+	case MSR_IA32_BBL_CR_CTL3:
+		/* This legacy MSR exists but isn't fully documented in current
+		 * silicon.  It is however accessed by winxp in very narrow
+		 * scenarios where it sets bit #19, itself documented as
+		 * a "reserved" bit.  Best effort attempt to source coherent
+		 * read data here should the balance of the register be
+		 * interpreted by the guest:
+		 *
+		 * L2 cache control register 3: 64GB range, 256KB size,
+		 * enabled, latency 0x1, configured
+		 */
+		msr_info->data = 0xbe702111;
+		break;
+	case MSR_AMD64_OSVW_ID_LENGTH:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
+			return 1;
+		msr_info->data = vcpu->arch.osvw.length;
+		break;
+	case MSR_AMD64_OSVW_STATUS:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
+			return 1;
+		msr_info->data = vcpu->arch.osvw.status;
+		break;
+	case MSR_PLATFORM_INFO:
+		if (!msr_info->host_initiated &&
+		    !vcpu->kvm->arch.guest_can_read_msr_platform_info)
+			return 1;
+		msr_info->data = vcpu->arch.msr_platform_info;
+		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		msr_info->data = vcpu->arch.msr_misc_features_enables;
+		break;
+	case MSR_K7_HWCR:
+		msr_info->data = vcpu->arch.msr_hwcr;
+		break;
+#ifdef CONFIG_X86_64
+	case MSR_IA32_XFD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
+		break;
+	case MSR_IA32_XFD_ERR:
+		if (!msr_info->host_initiated &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		msr_info->data = vcpu->arch.guest_fpu.xfd_err;
+		break;
+#endif
+	case MSR_IA32_U_CET:
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		kvm_get_xstate_msr(vcpu, msr_info);
+		break;
+	default:
+		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
+			return kvm_pmu_get_msr(vcpu, msr_info);
+
+		return KVM_MSR_RET_UNSUPPORTED;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_msr_common);
+
+static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	return kvm_get_msr_ignored_check(vcpu, index, data, true);
+}
+
+static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	u64 val;
+
+	/*
+	 * Reject writes to immutable feature MSRs if the vCPU model is frozen,
+	 * as KVM doesn't support modifying the guest vCPU model on the fly,
+	 * e.g. changing the VMX capabilities MSRs while L2 is active is
+	 * nonsensical.  Allow writes of the same value, e.g. so that userspace
+	 * can blindly stuff all MSRs when emulating RESET.
+	 */
+	if (!kvm_can_set_cpuid_and_feature_msrs(vcpu) &&
+	    kvm_is_immutable_feature_msr(index) &&
+	    (do_get_msr(vcpu, index, &val) || *data != val))
+		return -EINVAL;
+
+	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
+}
+
+/*
+ * Read or write a bunch of msrs. All parameters are kernel addresses.
+ *
+ * @return number of msrs set successfully.
+ */
+static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
+		    struct kvm_msr_entry *entries,
+		    int (*do_msr)(struct kvm_vcpu *vcpu,
+				  unsigned index, u64 *data))
+{
+	bool fpu_loaded = false;
+	int i;
+
+	for (i = 0; i < msrs->nmsrs; ++i) {
+		/*
+		 * If userspace is accessing one or more XSTATE-managed MSRs,
+		 * temporarily load the guest's FPU state so that the guest's
+		 * MSR value(s) is resident in hardware and thus can be accessed
+		 * via RDMSR/WRMSR.
+		 */
+		if (!fpu_loaded && is_xstate_managed_msr(vcpu, entries[i].index)) {
+			kvm_load_guest_fpu(vcpu);
+			fpu_loaded = true;
+		}
+		if (do_msr(vcpu, entries[i].index, &entries[i].data))
+			break;
+	}
+	if (fpu_loaded)
+		kvm_put_guest_fpu(vcpu);
+
+	return i;
+}
+
+/*
+ * Read or write a bunch of msrs. Parameters are user addresses.
+ *
+ * @return number of msrs set successfully.
+ */
+static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
+		  int (*do_msr)(struct kvm_vcpu *vcpu,
+				unsigned index, u64 *data),
+		  int writeback)
+{
+	struct kvm_msrs msrs;
+	struct kvm_msr_entry *entries;
+	unsigned size;
+	int r;
+
+	r = -EFAULT;
+	if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))
+		goto out;
+
+	r = -E2BIG;
+	if (msrs.nmsrs >= MAX_IO_MSRS)
+		goto out;
+
+	size = sizeof(struct kvm_msr_entry) * msrs.nmsrs;
+	entries = memdup_user(user_msrs->entries, size);
+	if (IS_ERR(entries)) {
+		r = PTR_ERR(entries);
+		goto out;
+	}
+
+	r = __msr_io(vcpu, &msrs, entries, do_msr);
+
+	if (writeback && copy_to_user(user_msrs->entries, entries, size))
+		r = -EFAULT;
+
+	kfree(entries);
+out:
+	return r;
+}
+
+int kvm_get_feature_msrs(struct kvm_msrs __user *user_msrs)
+{
+	return msr_io(NULL, user_msrs, do_get_feature_msr, 1);
+}
+
+int kvm_get_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_get_msr, 1);
+}
+
+int kvm_set_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_set_msr, 0);
+}
+
+static int kvm_get_one_msr(struct kvm_vcpu *vcpu, u32 msr, u64 __user *user_val)
+{
+	u64 val;
+
+	if (do_get_msr(vcpu, msr, &val))
+		return -EINVAL;
+
+	if (put_user(val, user_val))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_set_one_msr(struct kvm_vcpu *vcpu, u32 msr, u64 __user *user_val)
+{
+	u64 val;
+
+	if (get_user(val, user_val))
+		return -EFAULT;
+
+	if (do_set_msr(vcpu, msr, &val))
+		return -EINVAL;
+
+	return 0;
+}
+
+struct kvm_x86_reg_id {
+	__u32 index;
+	__u8  type;
+	__u8  rsvd1;
+	__u8  rsvd2:4;
+	__u8  size:4;
+	__u8  x86;
+};
+
+static int kvm_translate_kvm_reg(struct kvm_vcpu *vcpu,
+				 struct kvm_x86_reg_id *reg)
+{
+	switch (reg->index) {
+	case KVM_REG_GUEST_SSP:
+		/*
+		 * FIXME: If host-initiated accesses are ever exempted from
+		 * ignore_msrs (in kvm_do_msr_access()), drop this manual check
+		 * and rely on KVM's standard checks to reject accesses to regs
+		 * that don't exist.
+		 */
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
+			return -EINVAL;
+
+		reg->type = KVM_X86_REG_TYPE_MSR;
+		reg->index = MSR_KVM_INTERNAL_GUEST_SSP;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
+			void __user *argp)
+{
+	struct kvm_one_reg one_reg;
+	struct kvm_x86_reg_id *reg;
+	u64 __user *user_val;
+	bool load_fpu;
+	int r;
+
+	if (copy_from_user(&one_reg, argp, sizeof(one_reg)))
+		return -EFAULT;
+
+	if ((one_reg.id & KVM_REG_ARCH_MASK) != KVM_REG_X86)
+		return -EINVAL;
+
+	reg = (struct kvm_x86_reg_id *)&one_reg.id;
+	if (reg->rsvd1 || reg->rsvd2)
+		return -EINVAL;
+
+	if (reg->type == KVM_X86_REG_TYPE_KVM) {
+		r = kvm_translate_kvm_reg(vcpu, reg);
+		if (r)
+			return r;
+	}
+
+	if (reg->type != KVM_X86_REG_TYPE_MSR)
+		return -EINVAL;
+
+	if ((one_reg.id & KVM_REG_SIZE_MASK) != KVM_REG_SIZE_U64)
+		return -EINVAL;
+
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	load_fpu = is_xstate_managed_msr(vcpu, reg->index);
+	if (load_fpu)
+		kvm_load_guest_fpu(vcpu);
+
+	user_val = u64_to_user_ptr(one_reg.addr);
+	if (ioctl == KVM_GET_ONE_REG)
+		r = kvm_get_one_msr(vcpu, reg->index, user_val);
+	else
+		r = kvm_set_one_msr(vcpu, reg->index, user_val);
+
+	if (load_fpu)
+		kvm_put_guest_fpu(vcpu);
+	return r;
+}
+
+int kvm_get_reg_list(struct kvm_vcpu *vcpu,
+		     struct kvm_reg_list __user *user_list)
+{
+	u64 nr_regs = guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ? 1 : 0;
+	u64 user_nr_regs;
+
+	if (get_user(user_nr_regs, &user_list->n))
+		return -EFAULT;
+
+	if (put_user(nr_regs, &user_list->n))
+		return -EFAULT;
+
+	if (user_nr_regs < nr_regs)
+		return -E2BIG;
+
+	if (nr_regs &&
+	    put_user(KVM_X86_REG_KVM(KVM_REG_GUEST_SSP), &user_list->reg[0]))
+		return -EFAULT;
+
+	return 0;
+}
+
+static struct kvm_x86_msr_filter *kvm_alloc_msr_filter(bool default_allow)
+{
+	struct kvm_x86_msr_filter *msr_filter;
+
+	msr_filter = kzalloc_obj(*msr_filter, GFP_KERNEL_ACCOUNT);
+	if (!msr_filter)
+		return NULL;
+
+	msr_filter->default_allow = default_allow;
+	return msr_filter;
+}
+
+void kvm_free_msr_filter(struct kvm_x86_msr_filter *msr_filter)
+{
+	u32 i;
+
+	if (!msr_filter)
+		return;
+
+	for (i = 0; i < msr_filter->count; i++)
+		kfree(msr_filter->ranges[i].bitmap);
+
+	kfree(msr_filter);
+}
+
+static int kvm_add_msr_filter(struct kvm_x86_msr_filter *msr_filter,
+			      struct kvm_msr_filter_range *user_range)
+{
+	unsigned long *bitmap;
+	size_t bitmap_size;
+
+	if (!user_range->nmsrs)
+		return 0;
+
+	if (user_range->flags & ~KVM_MSR_FILTER_RANGE_VALID_MASK)
+		return -EINVAL;
+
+	if (!user_range->flags)
+		return -EINVAL;
+
+	bitmap_size = BITS_TO_LONGS(user_range->nmsrs) * sizeof(long);
+	if (!bitmap_size || bitmap_size > KVM_MSR_FILTER_MAX_BITMAP_SIZE)
+		return -EINVAL;
+
+	bitmap = memdup_user((__user u8*)user_range->bitmap, bitmap_size);
+	if (IS_ERR(bitmap))
+		return PTR_ERR(bitmap);
+
+	msr_filter->ranges[msr_filter->count] = (struct msr_bitmap_range) {
+		.flags = user_range->flags,
+		.base = user_range->base,
+		.nmsrs = user_range->nmsrs,
+		.bitmap = bitmap,
+	};
+
+	msr_filter->count++;
+	return 0;
+}
+
+int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, struct kvm_msr_filter *filter)
+{
+	struct kvm_x86_msr_filter *new_filter, *old_filter;
+	bool default_allow;
+	bool empty = true;
+	int r;
+	u32 i;
+
+	if (filter->flags & ~KVM_MSR_FILTER_VALID_MASK)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(filter->ranges); i++)
+		empty &= !filter->ranges[i].nmsrs;
+
+	default_allow = !(filter->flags & KVM_MSR_FILTER_DEFAULT_DENY);
+	if (empty && !default_allow)
+		return -EINVAL;
+
+	new_filter = kvm_alloc_msr_filter(default_allow);
+	if (!new_filter)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(filter->ranges); i++) {
+		r = kvm_add_msr_filter(new_filter, &filter->ranges[i]);
+		if (r) {
+			kvm_free_msr_filter(new_filter);
+			return r;
+		}
+	}
+
+	mutex_lock(&kvm->lock);
+	old_filter = rcu_replace_pointer(kvm->arch.msr_filter, new_filter,
+					 mutex_is_locked(&kvm->lock));
+	mutex_unlock(&kvm->lock);
+	synchronize_srcu(&kvm->srcu);
+
+	kvm_free_msr_filter(old_filter);
+
+	/*
+	 * Recalc MSR intercepts as userspace may want to intercept accesses to
+	 * MSRs that KVM would otherwise pass through to the guest.
+	 */
+	kvm_make_all_cpus_request(kvm, KVM_REQ_RECALC_INTERCEPTS);
+
+	return 0;
+}
+
+
+static void kvm_probe_feature_msr(u32 msr_index)
+{
+	u64 data;
+
+	if (kvm_get_feature_msr(NULL, msr_index, &data, true))
+		return;
+
+	msr_based_features[num_msr_based_features++] = msr_index;
+}
+
+static void kvm_probe_msr_to_save(u32 msr_index)
+{
+	u32 dummy[2];
+
+	if (rdmsr_safe(msr_index, &dummy[0], &dummy[1]))
+		return;
+
+	/*
+	 * Even MSRs that are valid in the host may not be exposed to guests in
+	 * some cases.
+	 */
+	switch (msr_index) {
+	case MSR_IA32_BNDCFGS:
+		if (!kvm_mpx_supported())
+			return;
+		break;
+	case MSR_TSC_AUX:
+		if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP) &&
+		    !kvm_cpu_cap_has(X86_FEATURE_RDPID))
+			return;
+		break;
+	case MSR_IA32_UMWAIT_CONTROL:
+		if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
+			return;
+		break;
+	case MSR_IA32_RTIT_CTL:
+	case MSR_IA32_RTIT_STATUS:
+		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
+			return;
+		break;
+	case MSR_IA32_RTIT_CR3_MATCH:
+		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
+			return;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		    (!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
+		     !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
+			return;
+		break;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		    (msr_index - MSR_IA32_RTIT_ADDR0_A >=
+		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
+			return;
+		break;
+	case MSR_ARCH_PERFMON_PERFCTR0 ...
+	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
+		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
+		    kvm_pmu_cap.num_counters_gp)
+			return;
+		break;
+	case MSR_ARCH_PERFMON_EVENTSEL0 ...
+	     MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
+		if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
+		    kvm_pmu_cap.num_counters_gp)
+			return;
+		break;
+	case MSR_ARCH_PERFMON_FIXED_CTR0 ...
+	     MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
+		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
+		    kvm_pmu_cap.num_counters_fixed)
+			return;
+		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
+		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
+			return;
+		break;
+	case MSR_IA32_XFD:
+	case MSR_IA32_XFD_ERR:
+		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
+			return;
+		break;
+	case MSR_IA32_TSX_CTRL:
+		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
+			return;
+		break;
+	case MSR_IA32_XSS:
+		if (!kvm_caps.supported_xss)
+			return;
+		break;
+	case MSR_IA32_U_CET:
+	case MSR_IA32_S_CET:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
+		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+			return;
+		break;
+	case MSR_IA32_INT_SSP_TAB:
+		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
+			return;
+		fallthrough;
+	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
+			return;
+		break;
+	default:
+		break;
+	}
+
+	msrs_to_save[num_msrs_to_save++] = msr_index;
+}
+
+void kvm_init_msr_lists(void)
+{
+	unsigned i;
+
+	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
+			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
+
+	num_msrs_to_save = 0;
+	num_emulated_msrs = 0;
+	num_msr_based_features = 0;
+
+	for (i = 0; i < ARRAY_SIZE(msrs_to_save_base); i++)
+		kvm_probe_msr_to_save(msrs_to_save_base[i]);
+
+	if (enable_pmu) {
+		for (i = 0; i < ARRAY_SIZE(msrs_to_save_pmu); i++)
+			kvm_probe_msr_to_save(msrs_to_save_pmu[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(emulated_msrs_all); i++) {
+		if (!kvm_x86_call(has_emulated_msr)(NULL,
+						    emulated_msrs_all[i]))
+			continue;
+
+		emulated_msrs[num_emulated_msrs++] = emulated_msrs_all[i];
+	}
+
+	for (i = KVM_FIRST_EMULATED_VMX_MSR; i <= KVM_LAST_EMULATED_VMX_MSR; i++)
+		kvm_probe_feature_msr(i);
+
+	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++)
+		kvm_probe_feature_msr(msr_based_features_all_except_vmx[i]);
+}
+
+int kvm_spec_ctrl_test_value(u64 value)
+{
+	/*
+	 * test that setting IA32_SPEC_CTRL to given value
+	 * is allowed by the host processor
+	 */
+
+	u64 saved_value;
+	unsigned long flags;
+	int ret = 0;
+
+	local_irq_save(flags);
+
+	if (rdmsrq_safe(MSR_IA32_SPEC_CTRL, &saved_value))
+		ret = 1;
+	else if (wrmsrq_safe(MSR_IA32_SPEC_CTRL, value))
+		ret = 1;
+	else
+		wrmsrq(MSR_IA32_SPEC_CTRL, saved_value);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_spec_ctrl_test_value);
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
new file mode 100644
index 0000000000000..25b75fe39b801
--- /dev/null
+++ b/arch/x86/kvm/msrs.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_KVM_MSR_H
+#define ARCH_X86_KVM_MSR_H
+
+#include <linux/kvm_host.h>
+#include <linux/user-return-notifier.h>
+
+#include "cpuid.h"
+#include "regs.h"
+
+extern bool report_ignored_msrs;
+extern bool ignore_msrs;
+
+static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled WRMSR(0x%x) = 0x%llx\n", msr, data);
+}
+
+static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	if (report_ignored_msrs)
+		vcpu_unimpl(vcpu, "Unhandled RDMSR(0x%x)\n", msr);
+}
+
+/*
+ * The first...last VMX feature MSRs that are emulated by KVM.  This may or may
+ * not cover all known VMX MSRs, as KVM doesn't emulate an MSR until there's an
+ * associated feature that KVM supports for nested virtualization.
+ */
+#define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
+#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
+
+/*
+ * KVM's internal, non-ABI indices for synthetic MSRs. The values themselves
+ * are arbitrary and have no meaning, the only requirement is that they don't
+ * conflict with "real" MSRs that KVM supports. Use values at the upper end
+ * of KVM's reserved paravirtual MSR range to minimize churn, i.e. these values
+ * will be usable until KVM exhausts its supply of paravirtual MSR indices.
+ */
+#define MSR_KVM_INTERNAL_GUEST_SSP	0x4b564dff
+
+#define MSR_IA32_CR_PAT_DEFAULT	\
+	PAT_VALUE(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC)
+
+void kvm_init_msr_lists(void);
+int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list);
+int kvm_get_feature_msr_index_list(struct kvm_msr_list __user *user_msr_list);
+int kvm_get_feature_msrs(struct kvm_msrs __user *user_msrs);
+
+int kvm_get_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs);
+int kvm_set_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs);
+
+int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
+			void __user *argp);
+int kvm_get_reg_list(struct kvm_vcpu *vcpu,
+		     struct kvm_reg_list __user *user_list);
+
+void kvm_user_return_msr_cpu_online(void);
+void drop_user_return_notifiers(void);
+void kvm_destroy_user_return_msrs(void);
+
+fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
+fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
+
+int kvm_emulator_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
+				     u64 *pdata);
+int kvm_emulator_set_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
+				     u64 data);
+int kvm_emulator_get_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
+
+bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type);
+
+enum kvm_msr_access {
+	MSR_TYPE_R	= BIT(0),
+	MSR_TYPE_W	= BIT(1),
+	MSR_TYPE_RW	= MSR_TYPE_R | MSR_TYPE_W,
+};
+
+/*
+ * Internal error codes that are used to indicate that MSR emulation encountered
+ * an error that should result in #GP in the guest, unless userspace handles it.
+ * Note, '1', '0', and negative numbers are off limits, as they are used by KVM
+ * as part of KVM's lightly documented internal KVM_RUN return codes.
+ *
+ * UNSUPPORTED	- The MSR isn't supported, either because it is completely
+ *		  unknown to KVM, or because the MSR should not exist according
+ *		  to the vCPU model.
+ *
+ * FILTERED	- Access to the MSR is denied by a userspace MSR filter.
+ */
+#define  KVM_MSR_RET_UNSUPPORTED	2
+#define  KVM_MSR_RET_FILTERED		3
+
+int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, struct kvm_msr_filter *filter);
+void kvm_free_msr_filter(struct kvm_x86_msr_filter *msr_filter);
+
+int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data);
+int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
+
+u64 kvm_get_arch_capabilities(void);
+int kvm_spec_ctrl_test_value(u64 value);
+
+#define CET_US_RESERVED_BITS		GENMASK(9, 6)
+#define CET_US_SHSTK_MASK_BITS		GENMASK(1, 0)
+#define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
+#define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
+
+static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
+{
+	if (data & CET_US_RESERVED_BITS)
+		return false;
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+	    (data & CET_US_SHSTK_MASK_BITS))
+		return false;
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
+	    (data & CET_US_IBT_MASK_BITS))
+		return false;
+	if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
+		return false;
+	/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
+	if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
+		return false;
+
+	return true;
+}
+
+#endif
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 6f74e2b27c1ed..c4ec024943bb8 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -19,7 +19,7 @@
 #include <asm/mtrr.h>
 
 #include "cpuid.h"
-#include "x86.h"
+#include "msrs.h"
 
 static u64 *find_mtrr(struct kvm_vcpu *vcpu, unsigned int msr)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7c31ec98ba723..a0e74a4e40d06 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -80,7 +80,6 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
-#include <asm/intel_pt.h>
 #include <asm/emulate_prefix.h>
 #include <asm/sgx.h>
 #include <asm/virt.h>
@@ -90,8 +89,6 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#define MAX_IO_MSRS 256
-
 /*
  * Note, kvm_caps fields should *never* have default values, all fields must be
  * recomputed from scratch during vendor module load, e.g. to account for a
@@ -108,17 +105,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 #define emul_to_vcpu(ctxt) \
 	((struct kvm_vcpu *)(ctxt)->vcpu)
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
-static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
-
 #define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
@@ -152,13 +138,6 @@ EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
-static bool __read_mostly ignore_msrs = 0;
-module_param(ignore_msrs, bool, 0644);
-
-bool __read_mostly report_ignored_msrs = true;
-module_param(report_ignored_msrs, bool, 0644);
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
-
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
@@ -185,27 +164,6 @@ module_param(pi_inject_timer, bint, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
-/*
- * Restoring the host value for MSRs that are only consumed when running in
- * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
- * returns to userspace, i.e. the kernel can run with the guest's value.
- */
-#define KVM_MAX_NR_USER_RETURN_MSRS 16
-
-struct kvm_user_return_msrs {
-	struct user_return_notifier urn;
-	bool registered;
-	struct kvm_user_return_msr_values {
-		u64 host;
-		u64 curr;
-	} values[KVM_MAX_NR_USER_RETURN_MSRS];
-};
-
-u32 __read_mostly kvm_nr_uret_msrs;
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
-static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
-static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
-
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
@@ -308,249 +266,6 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 
 static struct kmem_cache *x86_emulator_cache;
 
-/*
- * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
- * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
- * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
- * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
- * MSRs that KVM emulates without strictly requiring host support.
- * msr_based_features holds MSRs that enumerate features, i.e. are effectively
- * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
- * msrs_to_save and emulated_msrs.
- */
-
-static const u32 msrs_to_save_base[] = {
-	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
-	MSR_STAR,
-#ifdef CONFIG_X86_64
-	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
-#endif
-	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
-	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
-	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
-	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
-	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
-	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
-	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
-	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
-	MSR_IA32_UMWAIT_CONTROL,
-
-	MSR_IA32_XFD, MSR_IA32_XFD_ERR, MSR_IA32_XSS,
-
-	MSR_IA32_U_CET, MSR_IA32_S_CET,
-	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
-	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
-	MSR_IA32_DEBUGCTLMSR,
-	MSR_IA32_LASTBRANCHFROMIP, MSR_IA32_LASTBRANCHTOIP,
-	MSR_IA32_LASTINTFROMIP, MSR_IA32_LASTINTTOIP,
-};
-
-static const u32 msrs_to_save_pmu[] = {
-	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
-	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
-	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
-
-	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
-	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
-	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
-	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
-	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
-	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
-
-	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
-	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
-
-	/* This part of MSRs should match KVM_MAX_NR_AMD_GP_COUNTERS. */
-	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
-	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
-	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
-	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
-
-	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
-};
-
-static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
-			ARRAY_SIZE(msrs_to_save_pmu)];
-static unsigned num_msrs_to_save;
-
-static const u32 emulated_msrs_all[] = {
-	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
-	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
-
-#ifdef CONFIG_KVM_HYPERV
-	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
-	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
-	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
-	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
-	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
-	HV_X64_MSR_RESET,
-	HV_X64_MSR_VP_INDEX,
-	HV_X64_MSR_VP_RUNTIME,
-	HV_X64_MSR_SCONTROL,
-	HV_X64_MSR_STIMER0_CONFIG,
-	HV_X64_MSR_VP_ASSIST_PAGE,
-	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
-	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
-	HV_X64_MSR_SYNDBG_OPTIONS,
-	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
-	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
-	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
-#endif
-
-	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
-	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
-
-	MSR_IA32_TSC_ADJUST,
-	MSR_IA32_TSC_DEADLINE,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-	MSR_IA32_MISC_ENABLE,
-	MSR_IA32_MCG_STATUS,
-	MSR_IA32_MCG_CTL,
-	MSR_IA32_MCG_EXT_CTL,
-	MSR_IA32_SMBASE,
-	MSR_SMI_COUNT,
-	MSR_PLATFORM_INFO,
-	MSR_MISC_FEATURES_ENABLES,
-	MSR_AMD64_VIRT_SPEC_CTRL,
-	MSR_AMD64_TSC_RATIO,
-	MSR_IA32_POWER_CTL,
-	MSR_IA32_UCODE_REV,
-
-	/*
-	 * KVM always supports the "true" VMX control MSRs, even if the host
-	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
-	 * doesn't strictly require them to exist in the host (ignoring that
-	 * KVM would refuse to load in the first place if the core set of MSRs
-	 * aren't supported).
-	 */
-	MSR_IA32_VMX_BASIC,
-	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
-	MSR_IA32_VMX_TRUE_EXIT_CTLS,
-	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-	MSR_IA32_VMX_MISC,
-	MSR_IA32_VMX_CR0_FIXED0,
-	MSR_IA32_VMX_CR4_FIXED0,
-	MSR_IA32_VMX_VMCS_ENUM,
-	MSR_IA32_VMX_PROCBASED_CTLS2,
-	MSR_IA32_VMX_EPT_VPID_CAP,
-	MSR_IA32_VMX_VMFUNC,
-
-	MSR_K7_HWCR,
-	MSR_KVM_POLL_CONTROL,
-};
-
-static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
-static unsigned num_emulated_msrs;
-
-/*
- * List of MSRs that control the existence of MSR-based features, i.e. MSRs
- * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
- * feature MSRs, but are handled separately to allow expedited lookups.
- */
-static const u32 msr_based_features_all_except_vmx[] = {
-	MSR_AMD64_DE_CFG,
-	MSR_IA32_UCODE_REV,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-	MSR_PLATFORM_INFO,
-};
-
-static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
-			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
-static unsigned int num_msr_based_features;
-
-/*
- * All feature MSRs except uCode revID, which tracks the currently loaded uCode
- * patch, are immutable once the vCPU model is defined.
- */
-static bool kvm_is_immutable_feature_msr(u32 msr)
-{
-	int i;
-
-	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
-		return true;
-
-	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
-		if (msr == msr_based_features_all_except_vmx[i])
-			return msr != MSR_IA32_UCODE_REV;
-	}
-
-	return false;
-}
-
-static bool kvm_is_advertised_msr(u32 msr_index)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_msrs_to_save; i++) {
-		if (msrs_to_save[i] == msr_index)
-			return true;
-	}
-
-	for (i = 0; i < num_emulated_msrs; i++) {
-		if (emulated_msrs[i] == msr_index)
-			return true;
-	}
-
-	return false;
-}
-
-typedef int (*msr_access_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
-			    bool host_initiated);
-
-static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
-					     u64 *data, bool host_initiated,
-					     enum kvm_msr_access rw,
-					     msr_access_t msr_access_fn)
-{
-	const char *op = rw == MSR_TYPE_W ? "wrmsr" : "rdmsr";
-	int ret;
-
-	BUILD_BUG_ON(rw != MSR_TYPE_R && rw != MSR_TYPE_W);
-
-	/*
-	 * Zero the data on read failures to avoid leaking stack data to the
-	 * guest and/or userspace, e.g. if the failure is ignored below.
-	 */
-	ret = msr_access_fn(vcpu, msr, data, host_initiated);
-	if (ret && rw == MSR_TYPE_R)
-		*data = 0;
-
-	if (ret != KVM_MSR_RET_UNSUPPORTED)
-		return ret;
-
-	/*
-	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
-	 * advertises to userspace, even if an MSR isn't fully supported.
-	 * Simply check that @data is '0', which covers both the write '0' case
-	 * and all reads (in which case @data is zeroed on failure; see above).
-	 */
-	if (host_initiated && !*data && kvm_is_advertised_msr(msr))
-		return 0;
-
-	if (!ignore_msrs) {
-		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
-				      op, msr, *data);
-		return ret;
-	}
-
-	if (report_ignored_msrs)
-		kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n", op, msr, *data);
-
-	return 0;
-}
-
 static struct kmem_cache *kvm_alloc_emulator_cache(void)
 {
 	unsigned int useroffset = offsetof(struct x86_emulate_ctxt, src);
@@ -564,128 +279,6 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
-static void kvm_destroy_user_return_msrs(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		WARN_ON_ONCE(per_cpu(user_return_msrs, cpu).registered);
-
-	kvm_nr_uret_msrs = 0;
-}
-
-static void kvm_on_user_return(struct user_return_notifier *urn)
-{
-	unsigned slot;
-	struct kvm_user_return_msrs *msrs
-		= container_of(urn, struct kvm_user_return_msrs, urn);
-	struct kvm_user_return_msr_values *values;
-
-	msrs->registered = false;
-	user_return_notifier_unregister(urn);
-
-	for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
-		values = &msrs->values[slot];
-		if (values->host != values->curr) {
-			wrmsrq(kvm_uret_msrs_list[slot], values->host);
-			values->curr = values->host;
-		}
-	}
-}
-
-static int kvm_probe_user_return_msr(u32 msr)
-{
-	u64 val;
-	int ret;
-
-	preempt_disable();
-	ret = rdmsrq_safe(msr, &val);
-	if (ret)
-		goto out;
-	ret = wrmsrq_safe(msr, val);
-out:
-	preempt_enable();
-	return ret;
-}
-
-int kvm_add_user_return_msr(u32 msr)
-{
-	BUG_ON(kvm_nr_uret_msrs >= KVM_MAX_NR_USER_RETURN_MSRS);
-
-	if (kvm_probe_user_return_msr(msr))
-		return -1;
-
-	kvm_uret_msrs_list[kvm_nr_uret_msrs] = msr;
-	return kvm_nr_uret_msrs++;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_add_user_return_msr);
-
-int kvm_find_user_return_msr(u32 msr)
-{
-	int i;
-
-	for (i = 0; i < kvm_nr_uret_msrs; ++i) {
-		if (kvm_uret_msrs_list[i] == msr)
-			return i;
-	}
-	return -1;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_find_user_return_msr);
-
-static void kvm_user_return_msr_cpu_online(void)
-{
-	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
-	u64 value;
-	int i;
-
-	for (i = 0; i < kvm_nr_uret_msrs; ++i) {
-		rdmsrq_safe(kvm_uret_msrs_list[i], &value);
-		msrs->values[i].host = value;
-		msrs->values[i].curr = value;
-	}
-}
-
-static void kvm_user_return_register_notifier(struct kvm_user_return_msrs *msrs)
-{
-	if (!msrs->registered) {
-		msrs->urn.on_user_return = kvm_on_user_return;
-		user_return_notifier_register(&msrs->urn);
-		msrs->registered = true;
-	}
-}
-
-int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
-{
-	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
-	int err;
-
-	value = (value & mask) | (msrs->values[slot].host & ~mask);
-	if (value == msrs->values[slot].curr)
-		return 0;
-	err = wrmsrq_safe(kvm_uret_msrs_list[slot], value);
-	if (err)
-		return 1;
-
-	msrs->values[slot].curr = value;
-	kvm_user_return_register_notifier(msrs);
-	return 0;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_user_return_msr);
-
-u64 kvm_get_user_return_msr(unsigned int slot)
-{
-	return this_cpu_ptr(&user_return_msrs)->values[slot].curr;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_user_return_msr);
-
-static void drop_user_return_notifiers(void)
-{
-	struct kvm_user_return_msrs *msrs = this_cpu_ptr(&user_return_msrs);
-
-	if (msrs->registered)
-		kvm_on_user_return(&msrs->urn);
-}
-
 /*
  * Handle a fault on a hardware virtualization (VMX or SVM) instruction.
  *
@@ -940,17 +533,6 @@ int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_complete_insn_gp);
 
-static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
-{
-	if (err) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
-	return kvm_emulate_instruction(vcpu, EMULTYPE_NO_DECODE | EMULTYPE_SKIP |
-				       EMULTYPE_COMPLETE_USER_EXIT);
-}
-
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
 			   bool from_hardware)
 {
@@ -1221,13 +803,6 @@ static void kvm_load_host_pkru(struct kvm_vcpu *vcpu)
 	}
 }
 
-#ifdef CONFIG_X86_64
-static inline u64 kvm_guest_supported_xfd(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.guest_supported_xcr0 & XFEATURE_MASK_USER_DYNAMIC;
-}
-#endif
-
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
 	u64 xcr0 = xcr;
@@ -1589,3104 +1164,1345 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdpmc);
 
-/*
- * Some IA32_ARCH_CAPABILITIES bits have dependencies on MSRs that KVM
- * does not yet virtualize. These include:
- *   10 - MISC_PACKAGE_CTRLS
- *   11 - ENERGY_FILTERING_CTL
- *   12 - DOITM
- *   18 - FB_CLEAR_CTRL
- *   21 - XAPIC_DISABLE_STATUS
- *   23 - OVERCLOCKING_STATUS
- */
-
-#define KVM_SUPPORTED_ARCH_CAP \
-	(ARCH_CAP_RDCL_NO | ARCH_CAP_IBRS_ALL | ARCH_CAP_RSBA | \
-	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
-	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
-	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO | ARCH_CAP_ITS_NO)
-
-static u64 kvm_get_arch_capabilities(void)
+int kvm_emulate_as_nop(struct kvm_vcpu *vcpu)
 {
-	u64 data = kvm_host.arch_capabilities & KVM_SUPPORTED_ARCH_CAP;
-
-	/*
-	 * If nx_huge_pages is enabled, KVM's shadow paging will ensure that
-	 * the nested hypervisor runs with NX huge pages.  If it is not,
-	 * L1 is anyway vulnerable to ITLB_MULTIHIT exploits from other
-	 * L1 guests, so it need not worry about its own (L2) guests.
-	 */
-	data |= ARCH_CAP_PSCHANGE_MC_NO;
-
-	/*
-	 * If we're doing cache flushes (either "always" or "cond")
-	 * we will do one whenever the guest does a vmlaunch/vmresume.
-	 * If an outer hypervisor is doing the cache flush for us
-	 * (ARCH_CAP_SKIP_VMENTRY_L1DFLUSH), we can safely pass that
-	 * capability to the guest too, and if EPT is disabled we're not
-	 * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
-	 * require a nested hypervisor to do a flush of its own.
-	 */
-	if (l1tf_vmx_mitigation != VMENTER_L1D_FLUSH_NEVER)
-		data |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
-
-	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
-		data |= ARCH_CAP_RDCL_NO;
-	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		data |= ARCH_CAP_SSB_NO;
-	if (!boot_cpu_has_bug(X86_BUG_MDS))
-		data |= ARCH_CAP_MDS_NO;
-	if (!boot_cpu_has_bug(X86_BUG_RFDS))
-		data |= ARCH_CAP_RFDS_NO;
-	if (!boot_cpu_has_bug(X86_BUG_ITS))
-		data |= ARCH_CAP_ITS_NO;
-
-	if (!boot_cpu_has(X86_FEATURE_RTM)) {
-		/*
-		 * If RTM=0 because the kernel has disabled TSX, the host might
-		 * have TAA_NO or TSX_CTRL.  Clear TAA_NO (the guest sees RTM=0
-		 * and therefore knows that there cannot be TAA) but keep
-		 * TSX_CTRL: some buggy userspaces leave it set on tsx=on hosts,
-		 * and we want to allow migrating those guests to tsx=off hosts.
-		 */
-		data &= ~ARCH_CAP_TAA_NO;
-	} else if (!boot_cpu_has_bug(X86_BUG_TAA)) {
-		data |= ARCH_CAP_TAA_NO;
-	} else {
-		/*
-		 * Nothing to do here; we emulate TSX_CTRL if present on the
-		 * host so the guest can choose between disabling TSX or
-		 * using VERW to clear CPU buffers.
-		 */
-	}
-
-	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
-		data |= ARCH_CAP_GDS_NO;
-
-	return data;
+	return kvm_skip_emulated_instruction(vcpu);
 }
 
-static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
-			       bool host_initiated)
+int kvm_emulate_invd(struct kvm_vcpu *vcpu)
 {
-	WARN_ON_ONCE(!host_initiated);
-
-	switch (index) {
-	case MSR_IA32_ARCH_CAPABILITIES:
-		*data = kvm_get_arch_capabilities();
-		break;
-	case MSR_IA32_PERF_CAPABILITIES:
-		*data = kvm_caps.supported_perf_cap;
-		break;
-	case MSR_PLATFORM_INFO:
-		*data = MSR_PLATFORM_INFO_CPUID_FAULT;
-		break;
-	case MSR_IA32_UCODE_REV:
-		rdmsrq_safe(index, data);
-		break;
-	default:
-		return kvm_x86_call(get_feature_msr)(index, data);
-	}
-	return 0;
+	/* Treat an INVD instruction as a NOP and just skip it. */
+	return kvm_emulate_as_nop(vcpu);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_invd);
 
-static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
 {
-	return kvm_do_msr_access(vcpu, index, data, true, MSR_TYPE_R,
-				 kvm_get_feature_msr);
+	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
+		return EXIT_FASTPATH_NONE;
+
+	if (!kvm_emulate_invd(vcpu))
+		return EXIT_FASTPATH_EXIT_USERSPACE;
+
+	return EXIT_FASTPATH_REENTER_GUEST;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_invd);
 
-static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+int kvm_handle_invalid_op(struct kvm_vcpu *vcpu)
 {
-	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIBRS))
-		return false;
+	kvm_queue_exception(vcpu, UD_VECTOR);
+	return 1;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_handle_invalid_op);
 
-	if (efer & EFER_FFXSR && !guest_cpu_cap_has(vcpu, X86_FEATURE_FXSR_OPT))
-		return false;
 
-	if (efer & EFER_SVME && !guest_cpu_cap_has(vcpu, X86_FEATURE_SVM))
-		return false;
+static int kvm_emulate_monitor_mwait(struct kvm_vcpu *vcpu, const char *insn)
+{
+	bool enabled;
 
-	if (efer & (EFER_LME | EFER_LMA) &&
-	    !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
-		return false;
+	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS))
+		goto emulate_as_nop;
 
-	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
-		return false;
+	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
+		enabled = guest_cpu_cap_has(vcpu, X86_FEATURE_MWAIT);
+	else
+		enabled = vcpu->arch.ia32_misc_enable_msr & MSR_IA32_MISC_ENABLE_MWAIT;
 
-	return true;
+	if (!enabled)
+		return kvm_handle_invalid_op(vcpu);
 
+emulate_as_nop:
+	pr_warn_once("%s instruction emulated as NOP!\n", insn);
+	return kvm_emulate_as_nop(vcpu);
 }
-bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+int kvm_emulate_mwait(struct kvm_vcpu *vcpu)
 {
-	if (efer & efer_reserved_bits)
-		return false;
-
-	return __kvm_valid_efer(vcpu, efer);
+	return kvm_emulate_monitor_mwait(vcpu, "MWAIT");
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_mwait);
 
-static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_emulate_monitor(struct kvm_vcpu *vcpu)
 {
-	u64 old_efer = vcpu->arch.efer;
-	u64 efer = msr_info->data;
-	int r;
-
-	if (efer & efer_reserved_bits)
-		return 1;
-
-	if (!msr_info->host_initiated) {
-		if (!__kvm_valid_efer(vcpu, efer))
-			return 1;
-
-		if (is_paging(vcpu) &&
-		    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
-			return 1;
-	}
-
-	efer &= ~EFER_LMA;
-	efer |= vcpu->arch.efer & EFER_LMA;
-
-	r = kvm_x86_call(set_efer)(vcpu, efer);
-	if (r) {
-		WARN_ON(r > 0);
-		return r;
-	}
-
-	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
-		kvm_mmu_reset_context(vcpu);
-
-	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
-	    (efer & EFER_SVME))
-		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
-
-	return 0;
+	return kvm_emulate_monitor_mwait(vcpu, "MONITOR");
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_monitor);
 
-void kvm_enable_efer_bits(u64 mask)
+static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
-       efer_reserved_bits &= ~mask;
+	xfer_to_guest_mode_prepare();
+
+	return READ_ONCE(vcpu->mode) == EXITING_GUEST_MODE ||
+	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
 
-bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
-{
-	struct kvm_x86_msr_filter *msr_filter;
-	struct msr_bitmap_range *ranges;
-	struct kvm *kvm = vcpu->kvm;
-	bool allowed;
-	int idx;
-	u32 i;
-
-	/* x2APIC MSRs do not support filtering. */
-	if (index >= 0x800 && index <= 0x8ff)
-		return true;
-
-	idx = srcu_read_lock(&kvm->srcu);
-
-	msr_filter = srcu_dereference(kvm->arch.msr_filter, &kvm->srcu);
-	if (!msr_filter) {
-		allowed = true;
-		goto out;
-	}
+#ifdef CONFIG_X86_64
+struct pvclock_clock {
+	int vclock_mode;
+	u64 cycle_last;
+	u64 mask;
+	u32 mult;
+	u32 shift;
+	u64 base_cycles;
+	u64 offset;
+};
 
-	allowed = msr_filter->default_allow;
-	ranges = msr_filter->ranges;
+struct pvclock_gtod_data {
+	seqcount_t	seq;
 
-	for (i = 0; i < msr_filter->count; i++) {
-		u32 start = ranges[i].base;
-		u32 end = start + ranges[i].nmsrs;
-		u32 flags = ranges[i].flags;
-		unsigned long *bitmap = ranges[i].bitmap;
+	struct pvclock_clock clock; /* extract of a clocksource struct */
+	struct pvclock_clock raw_clock; /* extract of a clocksource struct */
 
-		if ((index >= start) && (index < end) && (flags & type)) {
-			allowed = test_bit(index - start, bitmap);
-			break;
-		}
-	}
+	ktime_t		offs_boot;
+	u64		wall_time_sec;
+};
 
-out:
-	srcu_read_unlock(&kvm->srcu, idx);
+static struct pvclock_gtod_data pvclock_gtod_data;
 
-	return allowed;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_msr_allowed);
+static void update_pvclock_gtod(struct timekeeper *tk)
+{
+	struct pvclock_gtod_data *vdata = &pvclock_gtod_data;
 
-/*
- * Write @data into the MSR specified by @index.  Select MSR specific fault
- * checks are bypassed if @host_initiated is %true.
- * Returns 0 on success, non-0 otherwise.
- * Assumes vcpu_load() was already called.
- */
-static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
-			 bool host_initiated)
-{
-	struct msr_data msr;
-
-	switch (index) {
-	case MSR_FS_BASE:
-	case MSR_GS_BASE:
-	case MSR_KERNEL_GS_BASE:
-	case MSR_CSTAR:
-	case MSR_LSTAR:
-		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
-		break;
-	case MSR_IA32_SYSENTER_EIP:
-	case MSR_IA32_SYSENTER_ESP:
-		/*
-		 * IA32_SYSENTER_ESP and IA32_SYSENTER_EIP cause #GP if
-		 * non-canonical address is written on Intel but not on
-		 * AMD (which ignores the top 32-bits, because it does
-		 * not implement 64-bit SYSENTER).
-		 *
-		 * 64-bit code should hence be able to write a non-canonical
-		 * value on AMD.  Making the address canonical ensures that
-		 * vmentry does not fail on Intel after writing a non-canonical
-		 * value, and that something deterministic happens if the guest
-		 * invokes 64-bit SYSENTER.
-		 */
-		data = __canonical_address(data, max_host_virt_addr_bits());
-		break;
-	case MSR_TSC_AUX:
-		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
-			return 1;
+	write_seqcount_begin(&vdata->seq);
 
-		if (!host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
-			return 1;
+	/* copy pvclock gtod data */
+	vdata->clock.vclock_mode	= tk->tkr_mono.clock->vdso_clock_mode;
+	vdata->clock.cycle_last		= tk->tkr_mono.cycle_last;
+	vdata->clock.mask		= tk->tkr_mono.mask;
+	vdata->clock.mult		= tk->tkr_mono.mult;
+	vdata->clock.shift		= tk->tkr_mono.shift;
+	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
+	vdata->clock.offset		= tk->tkr_mono.base;
 
-		/*
-		 * Per Intel's SDM, bits 63:32 are reserved, but AMD's APM has
-		 * incomplete and conflicting architectural behavior.  Current
-		 * AMD CPUs completely ignore bits 63:32, i.e. they aren't
-		 * reserved and always read as zeros.  Enforce Intel's reserved
-		 * bits check if the guest CPU is Intel compatible, otherwise
-		 * clear the bits.  This ensures cross-vendor migration will
-		 * provide consistent behavior for the guest.
-		 */
-		if (guest_cpuid_is_intel_compatible(vcpu) && (data >> 32) != 0)
-			return 1;
+	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->vdso_clock_mode;
+	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
+	vdata->raw_clock.mask		= tk->tkr_raw.mask;
+	vdata->raw_clock.mult		= tk->tkr_raw.mult;
+	vdata->raw_clock.shift		= tk->tkr_raw.shift;
+	vdata->raw_clock.base_cycles	= tk->tkr_raw.xtime_nsec;
+	vdata->raw_clock.offset		= tk->tkr_raw.base;
 
-		data = (u32)data;
-		break;
-	case MSR_IA32_U_CET:
-	case MSR_IA32_S_CET:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (!kvm_is_valid_u_s_cet(vcpu, data))
-			return 1;
-		break;
-	case MSR_KVM_INTERNAL_GUEST_SSP:
-		if (!host_initiated)
-			return 1;
-		fallthrough;
-		/*
-		 * Note that the MSR emulation here is flawed when a vCPU
-		 * doesn't support the Intel 64 architecture. The expected
-		 * architectural behavior in this case is that the upper 32
-		 * bits do not exist and should always read '0'. However,
-		 * because the actual hardware on which the virtual CPU is
-		 * running does support Intel 64, XRSTORS/XSAVES in the
-		 * guest could observe behavior that violates the
-		 * architecture. Intercepting XRSTORS/XSAVES for this
-		 * special case isn't deemed worthwhile.
-		 */
-	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
-			return KVM_MSR_RET_UNSUPPORTED;
-		/*
-		 * MSR_IA32_INT_SSP_TAB is not present on processors that do
-		 * not support Intel 64 architecture.
-		 */
-		if (index == MSR_IA32_INT_SSP_TAB && !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
-		/* All SSP MSRs except MSR_IA32_INT_SSP_TAB must be 4-byte aligned */
-		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
-			return 1;
-		break;
-	}
+	vdata->wall_time_sec            = tk->xtime_sec;
 
-	msr.data = data;
-	msr.index = index;
-	msr.host_initiated = host_initiated;
+	vdata->offs_boot		= tk->offs_boot;
 
-	return kvm_x86_call(set_msr)(vcpu, &msr);
+	write_seqcount_end(&vdata->seq);
 }
 
-static int _kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
-			bool host_initiated)
+static s64 get_kvmclock_base_ns(void)
 {
-	return __kvm_set_msr(vcpu, index, *data, host_initiated);
+	/* Count up from boot time, but with the frequency of the raw clock.  */
+	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
 }
-
-static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
-				     u32 index, u64 data, bool host_initiated)
+#else
+static s64 get_kvmclock_base_ns(void)
 {
-	return kvm_do_msr_access(vcpu, index, &data, host_initiated, MSR_TYPE_W,
-				 _kvm_set_msr);
+	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
+	return ktime_get_boottime_ns();
 }
+#endif
 
-/*
- * Read the MSR specified by @index into @data.  Select MSR specific fault
- * checks are bypassed if @host_initiated is %true.
- * Returns 0 on success, non-0 otherwise.
- * Assumes vcpu_load() was already called.
- */
-static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
-			 bool host_initiated)
+static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 {
-	struct msr_data msr;
-	int ret;
+	do_shl32_div32(dividend, divisor);
+	return dividend;
+}
 
-	switch (index) {
-	case MSR_TSC_AUX:
-		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
-			return 1;
+static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
+			       s8 *pshift, u32 *pmultiplier)
+{
+	uint64_t scaled64;
+	int32_t  shift = 0;
+	uint64_t tps64;
+	uint32_t tps32;
 
-		if (!host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
-			return 1;
-		break;
-	case MSR_IA32_U_CET:
-	case MSR_IA32_S_CET:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
-			return KVM_MSR_RET_UNSUPPORTED;
-		break;
-	case MSR_KVM_INTERNAL_GUEST_SSP:
-		if (!host_initiated)
-			return 1;
-		fallthrough;
-	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
-			return KVM_MSR_RET_UNSUPPORTED;
-		break;
+	tps64 = base_hz;
+	scaled64 = scaled_hz;
+	while (tps64 > scaled64*2 || tps64 & 0xffffffff00000000ULL) {
+		tps64 >>= 1;
+		shift--;
 	}
 
-	msr.index = index;
-	msr.host_initiated = host_initiated;
+	tps32 = (uint32_t)tps64;
+	while (tps32 <= scaled64 || scaled64 & 0xffffffff00000000ULL) {
+		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
+			scaled64 >>= 1;
+		else
+			tps32 <<= 1;
+		shift++;
+	}
 
-	ret = kvm_x86_call(get_msr)(vcpu, &msr);
-	if (!ret)
-		*data = msr.data;
-	return ret;
+	*pshift = shift;
+	*pmultiplier = div_frac(scaled64, tps32);
 }
 
-int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
-{
-	return __kvm_set_msr(vcpu, index, data, true);
-}
+#ifdef CONFIG_X86_64
+static atomic_t kvm_guest_has_master_clock = ATOMIC_INIT(0);
+#endif
 
-int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
-{
-	return __kvm_get_msr(vcpu, index, data, true);
-}
+static DEFINE_PER_CPU(unsigned long, cpu_tsc_khz);
+static unsigned long max_tsc_khz;
 
-static int kvm_get_msr_ignored_check(struct kvm_vcpu *vcpu,
-				     u32 index, u64 *data, bool host_initiated)
+static u32 adjust_tsc_khz(u32 khz, s32 ppm)
 {
-	return kvm_do_msr_access(vcpu, index, data, host_initiated, MSR_TYPE_R,
-				 __kvm_get_msr);
+	u64 v = (u64)khz * (1000000 + ppm);
+	do_div(v, 1000000);
+	return v;
 }
 
-int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
-{
-	return kvm_get_msr_ignored_check(vcpu, index, data, false);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_emulate_msr_read);
+static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier);
 
-int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
+static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 {
-	return kvm_set_msr_ignored_check(vcpu, index, data, false);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_emulate_msr_write);
+	u64 ratio;
 
-int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
-{
-	if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_READ))
-		return KVM_MSR_RET_FILTERED;
+	/* Guest TSC same frequency as host TSC? */
+	if (!scale) {
+		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
+		return 0;
+	}
+
+	/* TSC scaling supported? */
+	if (!kvm_caps.has_tsc_control) {
+		if (user_tsc_khz > tsc_khz) {
+			vcpu->arch.tsc_catchup = 1;
+			vcpu->arch.tsc_always_catchup = 1;
+			return 0;
+		} else {
+			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
+			return -1;
+		}
+	}
+
+	/* TSC scaling required  - calculate ratio */
+	ratio = mul_u64_u32_div(1ULL << kvm_caps.tsc_scaling_ratio_frac_bits,
+				user_tsc_khz, tsc_khz);
+
+	if (ratio == 0 || ratio >= kvm_caps.max_tsc_scaling_ratio) {
+		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
+			            user_tsc_khz);
+		return -1;
+	}
 
-	return __kvm_emulate_msr_read(vcpu, index, data);
+	kvm_vcpu_write_tsc_multiplier(vcpu, ratio);
+	return 0;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_read);
 
-int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
+static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 {
-	if (!kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_WRITE))
-		return KVM_MSR_RET_FILTERED;
+	u32 thresh_lo, thresh_hi;
+	int use_scaling = 0;
 
-	return __kvm_emulate_msr_write(vcpu, index, data);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
+	/* tsc_khz can be zero if TSC calibration fails */
+	if (user_tsc_khz == 0) {
+		/* set tsc_scaling_ratio to a safe value */
+		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
+		return -1;
+	}
 
+	/* Compute a scale to convert nanoseconds in TSC cycles */
+	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
+			   &vcpu->arch.virtual_tsc_shift,
+			   &vcpu->arch.virtual_tsc_mult);
+	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
 
-static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
-{
-	if (!vcpu->run->msr.error) {
-		kvm_eax_write(vcpu, vcpu->run->msr.data);
-		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
+	/*
+	 * Compute the variation in TSC rate which is acceptable
+	 * within the range of tolerance and decide if the
+	 * rate being applied is within that bounds of the hardware
+	 * rate.  If so, no scaling or compensation need be done.
+	 */
+	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
+	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
+	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
+		pr_debug("requested TSC rate %u falls outside tolerance [%u,%u]\n",
+			 user_tsc_khz, thresh_lo, thresh_hi);
+		use_scaling = 1;
 	}
+	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
 }
 
-static int complete_emulated_msr_access(struct kvm_vcpu *vcpu)
+static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	return complete_emulated_insn_gp(vcpu, vcpu->run->msr.error);
+	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
+				      vcpu->arch.virtual_tsc_mult,
+				      vcpu->arch.virtual_tsc_shift);
+	tsc += vcpu->arch.this_tsc_write;
+	return tsc;
 }
 
-static int complete_emulated_rdmsr(struct kvm_vcpu *vcpu)
+#ifdef CONFIG_X86_64
+static inline bool gtod_is_based_on_tsc(int mode)
 {
-	complete_userspace_rdmsr(vcpu);
-	return complete_emulated_msr_access(vcpu);
+	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
 }
+#endif
 
-static int complete_fast_msr_access(struct kvm_vcpu *vcpu)
+static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 {
-	return kvm_x86_call(complete_emulated_msr)(vcpu, vcpu->run->msr.error);
-}
+#ifdef CONFIG_X86_64
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 
-static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
-{
-	complete_userspace_rdmsr(vcpu);
-	return complete_fast_msr_access(vcpu);
-}
+	/*
+	 * To use the masterclock, the host clocksource must be based on TSC
+	 * and all vCPUs must have matching TSCs.  Note, the count for matching
+	 * vCPUs doesn't include the reference vCPU, hence "+1".
+	 */
+	bool use_master_clock = (ka->nr_vcpus_matched_tsc + 1 ==
+				 atomic_read(&vcpu->kvm->online_vcpus)) &&
+				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
-static int complete_fast_rdmsr_imm(struct kvm_vcpu *vcpu)
-{
-	if (!vcpu->run->msr.error)
-		kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
-				   vcpu->run->msr.data);
+	/*
+	 * Request a masterclock update if the masterclock needs to be toggled
+	 * on/off, or when starting a new generation and the masterclock is
+	 * enabled (compute_guest_tsc() requires the masterclock snapshot to be
+	 * taken _after_ the new generation is created).
+	 */
+	if ((ka->use_master_clock && new_generation) ||
+	    (ka->use_master_clock != use_master_clock))
+		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 
-	return complete_fast_msr_access(vcpu);
+	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
+			    atomic_read(&vcpu->kvm->online_vcpus),
+		            ka->use_master_clock, gtod->clock.vclock_mode);
+#endif
 }
 
-static u64 kvm_msr_reason(int r)
+/*
+ * Multiply tsc by a fixed point number represented by ratio.
+ *
+ * The most significant 64-N bits (mult) of ratio represent the
+ * integral part of the fixed point number; the remaining N bits
+ * (frac) represent the fractional part, ie. ratio represents a fixed
+ * point number (mult + frac * 2^(-N)).
+ *
+ * N equals to kvm_caps.tsc_scaling_ratio_frac_bits.
+ */
+static inline u64 __scale_tsc(u64 ratio, u64 tsc)
 {
-	switch (r) {
-	case KVM_MSR_RET_UNSUPPORTED:
-		return KVM_MSR_EXIT_REASON_UNKNOWN;
-	case KVM_MSR_RET_FILTERED:
-		return KVM_MSR_EXIT_REASON_FILTER;
-	default:
-		return KVM_MSR_EXIT_REASON_INVAL;
-	}
+	return mul_u64_u64_shr(tsc, ratio, kvm_caps.tsc_scaling_ratio_frac_bits);
 }
 
-static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
-			      u32 exit_reason, u64 data,
-			      int (*completion)(struct kvm_vcpu *vcpu),
-			      int r)
+u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 {
-	u64 msr_reason = kvm_msr_reason(r);
-
-	/* Check if the user wanted to know about this MSR fault */
-	if (!(vcpu->kvm->arch.user_space_msr_mask & msr_reason))
-		return 0;
-
-	vcpu->run->exit_reason = exit_reason;
-	vcpu->run->msr.error = 0;
-	memset(vcpu->run->msr.pad, 0, sizeof(vcpu->run->msr.pad));
-	vcpu->run->msr.reason = msr_reason;
-	vcpu->run->msr.index = index;
-	vcpu->run->msr.data = data;
-	vcpu->arch.complete_userspace_io = completion;
-
-	return 1;
-}
-
-static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
-			       int (*complete_rdmsr)(struct kvm_vcpu *))
-{
-	u64 data;
-	int r;
-
-	r = kvm_emulate_msr_read(vcpu, msr, &data);
-
-	if (!r) {
-		trace_kvm_msr_read(msr, data);
-
-		if (reg < 0) {
-			kvm_eax_write(vcpu, data);
-			kvm_edx_write(vcpu, data >> 32);
-		} else {
-			kvm_register_write(vcpu, reg, data);
-		}
-	} else {
-		/* MSR read failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
-				       complete_rdmsr, r))
-			return 0;
-		trace_kvm_msr_read_ex(msr);
-	}
-
-	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
-}
-
-int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
-{
-	return __kvm_emulate_rdmsr(vcpu, kvm_ecx_read(vcpu), -1,
-				   complete_fast_rdmsr);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr);
+	u64 _tsc = tsc;
 
-int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
-{
-	vcpu->arch.cui_rdmsr_imm_reg = reg;
+	if (ratio != kvm_caps.default_tsc_scaling_ratio)
+		_tsc = __scale_tsc(ratio, tsc);
 
-	return __kvm_emulate_rdmsr(vcpu, msr, reg, complete_fast_rdmsr_imm);
+	return _tsc;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr_imm);
 
-static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 {
-	int r;
+	u64 tsc;
 
-	r = kvm_emulate_msr_write(vcpu, msr, data);
-	if (!r) {
-		trace_kvm_msr_write(msr, data);
-	} else {
-		/* MSR write failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_WRMSR, data,
-				       complete_fast_msr_access, r))
-			return 0;
-		/* Signal all other negative errors to userspace */
-		if (r < 0)
-			return r;
-		trace_kvm_msr_write_ex(msr, data);
-	}
+	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
 
-	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
+	return target_tsc - tsc;
 }
 
-int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
 {
-	return __kvm_emulate_wrmsr(vcpu, kvm_ecx_read(vcpu),
-				   kvm_read_edx_eax(vcpu));
+	return vcpu->arch.l1_tsc_offset +
+		kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_l1_tsc);
 
-int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier)
 {
-	return __kvm_emulate_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr_imm);
+	u64 nested_offset;
 
-int kvm_emulate_as_nop(struct kvm_vcpu *vcpu)
-{
-	return kvm_skip_emulated_instruction(vcpu);
-}
+	if (l2_multiplier == kvm_caps.default_tsc_scaling_ratio)
+		nested_offset = l1_offset;
+	else
+		nested_offset = mul_s64_u64_shr((s64) l1_offset, l2_multiplier,
+						kvm_caps.tsc_scaling_ratio_frac_bits);
 
-int kvm_emulate_invd(struct kvm_vcpu *vcpu)
-{
-	/* Treat an INVD instruction as a NOP and just skip it. */
-	return kvm_emulate_as_nop(vcpu);
+	nested_offset += l2_offset;
+	return nested_offset;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_invd);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_offset);
 
-fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
+u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 {
-	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
-		return EXIT_FASTPATH_NONE;
-
-	if (!kvm_emulate_invd(vcpu))
-		return EXIT_FASTPATH_EXIT_USERSPACE;
+	if (l2_multiplier != kvm_caps.default_tsc_scaling_ratio)
+		return mul_u64_u64_shr(l1_multiplier, l2_multiplier,
+				       kvm_caps.tsc_scaling_ratio_frac_bits);
 
-	return EXIT_FASTPATH_REENTER_GUEST;
+	return l1_multiplier;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_invd);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-int kvm_handle_invalid_op(struct kvm_vcpu *vcpu)
+void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 {
-	kvm_queue_exception(vcpu, UD_VECTOR);
-	return 1;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_handle_invalid_op);
-
+	if (vcpu->arch.guest_tsc_protected)
+		return;
 
-static int kvm_emulate_monitor_mwait(struct kvm_vcpu *vcpu, const char *insn)
-{
-	bool enabled;
+	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
+				   vcpu->arch.l1_tsc_offset,
+				   l1_offset);
 
-	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS))
-		goto emulate_as_nop;
+	vcpu->arch.l1_tsc_offset = l1_offset;
 
-	if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
-		enabled = guest_cpu_cap_has(vcpu, X86_FEATURE_MWAIT);
+	/*
+	 * If we are here because L1 chose not to trap WRMSR to TSC then
+	 * according to the spec this should set L1's TSC (as opposed to
+	 * setting L1's offset for L2).
+	 */
+	if (is_guest_mode(vcpu))
+		vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
+			l1_offset,
+			kvm_x86_call(get_l2_tsc_offset)(vcpu),
+			kvm_x86_call(get_l2_tsc_multiplier)(vcpu));
 	else
-		enabled = vcpu->arch.ia32_misc_enable_msr & MSR_IA32_MISC_ENABLE_MWAIT;
-
-	if (!enabled)
-		return kvm_handle_invalid_op(vcpu);
-
-emulate_as_nop:
-	pr_warn_once("%s instruction emulated as NOP!\n", insn);
-	return kvm_emulate_as_nop(vcpu);
-}
-int kvm_emulate_mwait(struct kvm_vcpu *vcpu)
-{
-	return kvm_emulate_monitor_mwait(vcpu, "MWAIT");
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_mwait);
-
-int kvm_emulate_monitor(struct kvm_vcpu *vcpu)
-{
-	return kvm_emulate_monitor_mwait(vcpu, "MONITOR");
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_monitor);
-
-static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
-{
-	xfer_to_guest_mode_prepare();
+		vcpu->arch.tsc_offset = l1_offset;
 
-	return READ_ONCE(vcpu->mode) == EXITING_GUEST_MODE ||
-	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
+	kvm_x86_call(write_tsc_offset)(vcpu);
 }
 
-static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
 {
-	if (!kvm_pmu_is_fastpath_emulation_allowed(vcpu))
-		return EXIT_FASTPATH_NONE;
-
-	switch (msr) {
-	case APIC_BASE_MSR + (APIC_ICR >> 4):
-		if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(vcpu->arch.apic) ||
-		    kvm_x2apic_icr_write_fast(vcpu->arch.apic, data))
-			return EXIT_FASTPATH_NONE;
-		break;
-	case MSR_IA32_TSC_DEADLINE:
-		kvm_set_lapic_tscdeadline_msr(vcpu, data);
-		break;
-	default:
-		return EXIT_FASTPATH_NONE;
-	}
-
-	trace_kvm_msr_write(msr, data);
-
-	if (!kvm_skip_emulated_instruction(vcpu))
-		return EXIT_FASTPATH_EXIT_USERSPACE;
+	vcpu->arch.l1_tsc_scaling_ratio = l1_multiplier;
 
-	return EXIT_FASTPATH_REENTER_GUEST;
-}
+	/* Userspace is changing the multiplier while L2 is active */
+	if (is_guest_mode(vcpu))
+		vcpu->arch.tsc_scaling_ratio = kvm_calc_nested_tsc_multiplier(
+			l1_multiplier,
+			kvm_x86_call(get_l2_tsc_multiplier)(vcpu));
+	else
+		vcpu->arch.tsc_scaling_ratio = l1_multiplier;
 
-fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
-{
-	return __handle_fastpath_wrmsr(vcpu, kvm_ecx_read(vcpu),
-				       kvm_read_edx_eax(vcpu));
+	if (kvm_caps.has_tsc_control)
+		kvm_x86_call(write_tsc_multiplier)(vcpu);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr);
 
-fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+static inline bool kvm_check_tsc_unstable(void)
 {
-	return __handle_fastpath_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
+#ifdef CONFIG_X86_64
+	/*
+	 * TSC is marked unstable when we're running on Hyper-V,
+	 * 'TSC page' clocksource is good.
+	 */
+	if (pvclock_gtod_data.clock.vclock_mode == VDSO_CLOCKMODE_HVCLOCK)
+		return false;
+#endif
+	return check_tsc_unstable();
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr_imm);
 
 /*
- * Adapt set_msr() to msr_io()'s calling convention
+ * Infers attempts to synchronize the guest's tsc from host writes. Sets the
+ * offset for the vcpu and tracks the TSC matching generation that the vcpu
+ * participates in.
  */
-static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
+				  u64 ns, bool matched, bool user_set_tsc)
 {
-	return kvm_get_msr_ignored_check(vcpu, index, data, true);
-}
+	struct kvm *kvm = vcpu->kvm;
 
-static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
-{
-	u64 val;
+	lockdep_assert_held(&kvm->arch.tsc_write_lock);
+
+	if (vcpu->arch.guest_tsc_protected)
+		return;
+
+	if (user_set_tsc)
+		vcpu->kvm->arch.user_set_tsc = true;
 
 	/*
-	 * Reject writes to immutable feature MSRs if the vCPU model is frozen,
-	 * as KVM doesn't support modifying the guest vCPU model on the fly,
-	 * e.g. changing the VMX capabilities MSRs while L2 is active is
-	 * nonsensical.  Allow writes of the same value, e.g. so that userspace
-	 * can blindly stuff all MSRs when emulating RESET.
+	 * We also track th most recent recorded KHZ, write and time to
+	 * allow the matching interval to be extended at each write.
 	 */
-	if (!kvm_can_set_cpuid_and_feature_msrs(vcpu) &&
-	    kvm_is_immutable_feature_msr(index) &&
-	    (do_get_msr(vcpu, index, &val) || *data != val))
-		return -EINVAL;
-
-	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
-}
+	kvm->arch.last_tsc_nsec = ns;
+	kvm->arch.last_tsc_write = tsc;
+	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	kvm->arch.last_tsc_offset = offset;
 
-#ifdef CONFIG_X86_64
-struct pvclock_clock {
-	int vclock_mode;
-	u64 cycle_last;
-	u64 mask;
-	u32 mult;
-	u32 shift;
-	u64 base_cycles;
-	u64 offset;
-};
+	vcpu->arch.last_guest_tsc = tsc;
 
-struct pvclock_gtod_data {
-	seqcount_t	seq;
+	kvm_vcpu_write_tsc_offset(vcpu, offset);
 
-	struct pvclock_clock clock; /* extract of a clocksource struct */
-	struct pvclock_clock raw_clock; /* extract of a clocksource struct */
+	if (!matched) {
+		/*
+		 * We split periods of matched TSC writes into generations.
+		 * For each generation, we track the original measured
+		 * nanosecond time, offset, and write, so if TSCs are in
+		 * sync, we can match exact offset, and if not, we can match
+		 * exact software computation in compute_guest_tsc()
+		 *
+		 * These values are tracked in kvm->arch.cur_xxx variables.
+		 */
+		kvm->arch.cur_tsc_generation++;
+		kvm->arch.cur_tsc_nsec = ns;
+		kvm->arch.cur_tsc_write = tsc;
+		kvm->arch.cur_tsc_offset = offset;
+		kvm->arch.nr_vcpus_matched_tsc = 0;
+	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
+		kvm->arch.nr_vcpus_matched_tsc++;
+	}
 
-	ktime_t		offs_boot;
-	u64		wall_time_sec;
-};
+	/* Keep track of which generation this VCPU has synchronized to */
+	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
+	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
+	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
 
-static struct pvclock_gtod_data pvclock_gtod_data;
+	kvm_track_tsc_matching(vcpu, !matched);
+}
 
-static void update_pvclock_gtod(struct timekeeper *tk)
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
-	struct pvclock_gtod_data *vdata = &pvclock_gtod_data;
+	u64 data = user_value ? *user_value : 0;
+	struct kvm *kvm = vcpu->kvm;
+	u64 offset, ns, elapsed;
+	unsigned long flags;
+	bool matched = false;
+	bool synchronizing = false;
 
-	write_seqcount_begin(&vdata->seq);
+	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+	offset = kvm_compute_l1_tsc_offset(vcpu, data);
+	ns = get_kvmclock_base_ns();
+	elapsed = ns - kvm->arch.last_tsc_nsec;
 
-	/* copy pvclock gtod data */
-	vdata->clock.vclock_mode	= tk->tkr_mono.clock->vdso_clock_mode;
-	vdata->clock.cycle_last		= tk->tkr_mono.cycle_last;
-	vdata->clock.mask		= tk->tkr_mono.mask;
-	vdata->clock.mult		= tk->tkr_mono.mult;
-	vdata->clock.shift		= tk->tkr_mono.shift;
-	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
-	vdata->clock.offset		= tk->tkr_mono.base;
-
-	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->vdso_clock_mode;
-	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
-	vdata->raw_clock.mask		= tk->tkr_raw.mask;
-	vdata->raw_clock.mult		= tk->tkr_raw.mult;
-	vdata->raw_clock.shift		= tk->tkr_raw.shift;
-	vdata->raw_clock.base_cycles	= tk->tkr_raw.xtime_nsec;
-	vdata->raw_clock.offset		= tk->tkr_raw.base;
-
-	vdata->wall_time_sec            = tk->xtime_sec;
-
-	vdata->offs_boot		= tk->offs_boot;
-
-	write_seqcount_end(&vdata->seq);
-}
-
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Count up from boot time, but with the frequency of the raw clock.  */
-	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
-}
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-	return ktime_get_boottime_ns();
-}
-#endif
-
-static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
-{
-	int version;
-	int r;
-	struct pvclock_wall_clock wc;
-	u32 wc_sec_hi;
-	u64 wall_nsec;
-
-	if (!wall_clock)
-		return;
-
-	r = kvm_read_guest(kvm, wall_clock, &version, sizeof(version));
-	if (r)
-		return;
-
-	if (version & 1)
-		++version;  /* first time write, random junk */
-
-	++version;
-
-	if (kvm_write_guest(kvm, wall_clock, &version, sizeof(version)))
-		return;
-
-	wall_nsec = kvm_get_wall_clock_epoch(kvm);
-
-	wc.nsec = do_div(wall_nsec, NSEC_PER_SEC);
-	wc.sec = (u32)wall_nsec; /* overflow in 2106 guest time */
-	wc.version = version;
-
-	kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
-
-	if (sec_hi_ofs) {
-		wc_sec_hi = wall_nsec >> 32;
-		kvm_write_guest(kvm, wall_clock + sec_hi_ofs,
-				&wc_sec_hi, sizeof(wc_sec_hi));
-	}
-
-	version++;
-	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
-}
-
-static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
-				  bool old_msr, bool host_initiated)
-{
-	struct kvm_arch *ka = &vcpu->kvm->arch;
-
-	if (vcpu->vcpu_id == 0 && !host_initiated) {
-		if (ka->boot_vcpu_runs_old_kvmclock != old_msr)
-			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
-
-		ka->boot_vcpu_runs_old_kvmclock = old_msr;
-	}
-
-	vcpu->arch.time = system_time;
-	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
-
-	/* we verify if the enable bit is set... */
-	if (system_time & 1)
-		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
-				 sizeof(struct pvclock_vcpu_time_info));
-	else
-		kvm_gpc_deactivate(&vcpu->arch.pv_time);
-
-	return;
-}
-
-static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
-{
-	do_shl32_div32(dividend, divisor);
-	return dividend;
-}
-
-static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
-			       s8 *pshift, u32 *pmultiplier)
-{
-	uint64_t scaled64;
-	int32_t  shift = 0;
-	uint64_t tps64;
-	uint32_t tps32;
-
-	tps64 = base_hz;
-	scaled64 = scaled_hz;
-	while (tps64 > scaled64*2 || tps64 & 0xffffffff00000000ULL) {
-		tps64 >>= 1;
-		shift--;
-	}
-
-	tps32 = (uint32_t)tps64;
-	while (tps32 <= scaled64 || scaled64 & 0xffffffff00000000ULL) {
-		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
-			scaled64 >>= 1;
-		else
-			tps32 <<= 1;
-		shift++;
-	}
-
-	*pshift = shift;
-	*pmultiplier = div_frac(scaled64, tps32);
-}
-
-#ifdef CONFIG_X86_64
-static atomic_t kvm_guest_has_master_clock = ATOMIC_INIT(0);
-#endif
-
-static DEFINE_PER_CPU(unsigned long, cpu_tsc_khz);
-static unsigned long max_tsc_khz;
-
-static u32 adjust_tsc_khz(u32 khz, s32 ppm)
-{
-	u64 v = (u64)khz * (1000000 + ppm);
-	do_div(v, 1000000);
-	return v;
-}
-
-static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier);
-
-static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
-{
-	u64 ratio;
-
-	/* Guest TSC same frequency as host TSC? */
-	if (!scale) {
-		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
-		return 0;
-	}
-
-	/* TSC scaling supported? */
-	if (!kvm_caps.has_tsc_control) {
-		if (user_tsc_khz > tsc_khz) {
-			vcpu->arch.tsc_catchup = 1;
-			vcpu->arch.tsc_always_catchup = 1;
-			return 0;
-		} else {
-			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
-			return -1;
-		}
-	}
-
-	/* TSC scaling required  - calculate ratio */
-	ratio = mul_u64_u32_div(1ULL << kvm_caps.tsc_scaling_ratio_frac_bits,
-				user_tsc_khz, tsc_khz);
-
-	if (ratio == 0 || ratio >= kvm_caps.max_tsc_scaling_ratio) {
-		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
-			            user_tsc_khz);
-		return -1;
-	}
-
-	kvm_vcpu_write_tsc_multiplier(vcpu, ratio);
-	return 0;
-}
-
-static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
-{
-	u32 thresh_lo, thresh_hi;
-	int use_scaling = 0;
-
-	/* tsc_khz can be zero if TSC calibration fails */
-	if (user_tsc_khz == 0) {
-		/* set tsc_scaling_ratio to a safe value */
-		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
-		return -1;
-	}
-
-	/* Compute a scale to convert nanoseconds in TSC cycles */
-	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
-			   &vcpu->arch.virtual_tsc_shift,
-			   &vcpu->arch.virtual_tsc_mult);
-	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
-
-	/*
-	 * Compute the variation in TSC rate which is acceptable
-	 * within the range of tolerance and decide if the
-	 * rate being applied is within that bounds of the hardware
-	 * rate.  If so, no scaling or compensation need be done.
-	 */
-	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
-	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
-	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
-		pr_debug("requested TSC rate %u falls outside tolerance [%u,%u]\n",
-			 user_tsc_khz, thresh_lo, thresh_hi);
-		use_scaling = 1;
-	}
-	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
-}
-
-static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
-{
-	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc += vcpu->arch.this_tsc_write;
-	return tsc;
-}
-
-#ifdef CONFIG_X86_64
-static inline bool gtod_is_based_on_tsc(int mode)
-{
-	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
-}
-#endif
-
-static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
-{
-#ifdef CONFIG_X86_64
-	struct kvm_arch *ka = &vcpu->kvm->arch;
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-
-	/*
-	 * To use the masterclock, the host clocksource must be based on TSC
-	 * and all vCPUs must have matching TSCs.  Note, the count for matching
-	 * vCPUs doesn't include the reference vCPU, hence "+1".
-	 */
-	bool use_master_clock = (ka->nr_vcpus_matched_tsc + 1 ==
-				 atomic_read(&vcpu->kvm->online_vcpus)) &&
-				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
-
-	/*
-	 * Request a masterclock update if the masterclock needs to be toggled
-	 * on/off, or when starting a new generation and the masterclock is
-	 * enabled (compute_guest_tsc() requires the masterclock snapshot to be
-	 * taken _after_ the new generation is created).
-	 */
-	if ((ka->use_master_clock && new_generation) ||
-	    (ka->use_master_clock != use_master_clock))
-		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
-
-	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
-			    atomic_read(&vcpu->kvm->online_vcpus),
-		            ka->use_master_clock, gtod->clock.vclock_mode);
-#endif
-}
-
-/*
- * Multiply tsc by a fixed point number represented by ratio.
- *
- * The most significant 64-N bits (mult) of ratio represent the
- * integral part of the fixed point number; the remaining N bits
- * (frac) represent the fractional part, ie. ratio represents a fixed
- * point number (mult + frac * 2^(-N)).
- *
- * N equals to kvm_caps.tsc_scaling_ratio_frac_bits.
- */
-static inline u64 __scale_tsc(u64 ratio, u64 tsc)
-{
-	return mul_u64_u64_shr(tsc, ratio, kvm_caps.tsc_scaling_ratio_frac_bits);
-}
-
-u64 kvm_scale_tsc(u64 tsc, u64 ratio)
-{
-	u64 _tsc = tsc;
-
-	if (ratio != kvm_caps.default_tsc_scaling_ratio)
-		_tsc = __scale_tsc(ratio, tsc);
-
-	return _tsc;
-}
-
-u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
-{
-	u64 tsc;
-
-	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
-
-	return target_tsc - tsc;
-}
-
-u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
-{
-	return vcpu->arch.l1_tsc_offset +
-		kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_l1_tsc);
-
-u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier)
-{
-	u64 nested_offset;
-
-	if (l2_multiplier == kvm_caps.default_tsc_scaling_ratio)
-		nested_offset = l1_offset;
-	else
-		nested_offset = mul_s64_u64_shr((s64) l1_offset, l2_multiplier,
-						kvm_caps.tsc_scaling_ratio_frac_bits);
-
-	nested_offset += l2_offset;
-	return nested_offset;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_offset);
-
-u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
-{
-	if (l2_multiplier != kvm_caps.default_tsc_scaling_ratio)
-		return mul_u64_u64_shr(l1_multiplier, l2_multiplier,
-				       kvm_caps.tsc_scaling_ratio_frac_bits);
-
-	return l1_multiplier;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
-
-void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
-{
-	if (vcpu->arch.guest_tsc_protected)
-		return;
-
-	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
-				   vcpu->arch.l1_tsc_offset,
-				   l1_offset);
-
-	vcpu->arch.l1_tsc_offset = l1_offset;
-
-	/*
-	 * If we are here because L1 chose not to trap WRMSR to TSC then
-	 * according to the spec this should set L1's TSC (as opposed to
-	 * setting L1's offset for L2).
-	 */
-	if (is_guest_mode(vcpu))
-		vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(
-			l1_offset,
-			kvm_x86_call(get_l2_tsc_offset)(vcpu),
-			kvm_x86_call(get_l2_tsc_multiplier)(vcpu));
-	else
-		vcpu->arch.tsc_offset = l1_offset;
-
-	kvm_x86_call(write_tsc_offset)(vcpu);
-}
-
-static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
-{
-	vcpu->arch.l1_tsc_scaling_ratio = l1_multiplier;
-
-	/* Userspace is changing the multiplier while L2 is active */
-	if (is_guest_mode(vcpu))
-		vcpu->arch.tsc_scaling_ratio = kvm_calc_nested_tsc_multiplier(
-			l1_multiplier,
-			kvm_x86_call(get_l2_tsc_multiplier)(vcpu));
-	else
-		vcpu->arch.tsc_scaling_ratio = l1_multiplier;
-
-	if (kvm_caps.has_tsc_control)
-		kvm_x86_call(write_tsc_multiplier)(vcpu);
-}
-
-static inline bool kvm_check_tsc_unstable(void)
-{
-#ifdef CONFIG_X86_64
-	/*
-	 * TSC is marked unstable when we're running on Hyper-V,
-	 * 'TSC page' clocksource is good.
-	 */
-	if (pvclock_gtod_data.clock.vclock_mode == VDSO_CLOCKMODE_HVCLOCK)
-		return false;
-#endif
-	return check_tsc_unstable();
-}
-
-/*
- * Infers attempts to synchronize the guest's tsc from host writes. Sets the
- * offset for the vcpu and tracks the TSC matching generation that the vcpu
- * participates in.
- */
-static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
-				  u64 ns, bool matched, bool user_set_tsc)
-{
-	struct kvm *kvm = vcpu->kvm;
-
-	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-
-	if (vcpu->arch.guest_tsc_protected)
-		return;
-
-	if (user_set_tsc)
-		vcpu->kvm->arch.user_set_tsc = true;
-
-	/*
-	 * We also track th most recent recorded KHZ, write and time to
-	 * allow the matching interval to be extended at each write.
-	 */
-	kvm->arch.last_tsc_nsec = ns;
-	kvm->arch.last_tsc_write = tsc;
-	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
-	kvm->arch.last_tsc_offset = offset;
-
-	vcpu->arch.last_guest_tsc = tsc;
-
-	kvm_vcpu_write_tsc_offset(vcpu, offset);
-
-	if (!matched) {
-		/*
-		 * We split periods of matched TSC writes into generations.
-		 * For each generation, we track the original measured
-		 * nanosecond time, offset, and write, so if TSCs are in
-		 * sync, we can match exact offset, and if not, we can match
-		 * exact software computation in compute_guest_tsc()
-		 *
-		 * These values are tracked in kvm->arch.cur_xxx variables.
-		 */
-		kvm->arch.cur_tsc_generation++;
-		kvm->arch.cur_tsc_nsec = ns;
-		kvm->arch.cur_tsc_write = tsc;
-		kvm->arch.cur_tsc_offset = offset;
-		kvm->arch.nr_vcpus_matched_tsc = 0;
-	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
-		kvm->arch.nr_vcpus_matched_tsc++;
-	}
-
-	/* Keep track of which generation this VCPU has synchronized to */
-	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
-	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
-	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
-
-	kvm_track_tsc_matching(vcpu, !matched);
-}
-
-void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
-{
-	u64 data = user_value ? *user_value : 0;
-	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
-	unsigned long flags;
-	bool matched = false;
-	bool synchronizing = false;
-
-	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, data);
-	ns = get_kvmclock_base_ns();
-	elapsed = ns - kvm->arch.last_tsc_nsec;
-
-	if (vcpu->arch.virtual_tsc_khz) {
-		if (data == 0) {
-			/*
-			 * Force synchronization when creating a vCPU, or when
-			 * userspace explicitly writes a zero value.
-			 */
-			synchronizing = true;
-		} else if (kvm->arch.user_set_tsc) {
-			u64 tsc_exp = kvm->arch.last_tsc_write +
-						nsec_to_cycles(vcpu, elapsed);
-			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
-			/*
-			 * Here lies UAPI baggage: when a user-initiated TSC write has
-			 * a small delta (1 second) of virtual cycle time against the
-			 * previously set vCPU, we assume that they were intended to be
-			 * in sync and the delta was only due to the racy nature of the
-			 * legacy API.
-			 *
-			 * This trick falls down when restoring a guest which genuinely
-			 * has been running for less time than the 1 second of imprecision
-			 * which we allow for in the legacy API. In this case, the first
-			 * value written by userspace (on any vCPU) should not be subject
-			 * to this 'correction' to make it sync up with values that only
-			 * come from the kernel's default vCPU creation. Make the 1-second
-			 * slop hack only trigger if the user_set_tsc flag is already set.
-			 */
-			synchronizing = data < tsc_exp + tsc_hz &&
-					data + tsc_hz > tsc_exp;
-		}
-	}
-
-
-	/*
-	 * For a reliable TSC, we can match TSC offsets, and for an unstable
-	 * TSC, we add elapsed time in this computation.  We could let the
-	 * compensation code attempt to catch up if we fall behind, but
-	 * it's better to try to match offsets from the beginning.
-         */
-	if (synchronizing &&
-	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!kvm_check_tsc_unstable()) {
-			offset = kvm->arch.cur_tsc_offset;
-		} else {
-			u64 delta = nsec_to_cycles(vcpu, elapsed);
-			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, data);
-		}
-		matched = true;
-	}
-
-	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, !!user_value);
-	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
-}
-
-#ifdef CONFIG_X86_64
-
-static u64 read_tsc(void)
-{
-	u64 ret = (u64)rdtsc_ordered();
-	u64 last = pvclock_gtod_data.clock.cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	/*
-	 * GCC likes to generate cmov here, but this branch is extremely
-	 * predictable (it's just a function of time and the likely is
-	 * very likely) and there's a data dependence, so force GCC
-	 * to generate a branch instead.  I don't barrier() because
-	 * we don't actually need a barrier, and if this function
-	 * ever gets inlined it will generate worse code.
-	 */
-	asm volatile ("");
-	return last;
-}
-
-static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
-			  int *mode)
-{
-	u64 tsc_pg_val;
-	long v;
-
-	switch (clock->vclock_mode) {
-	case VDSO_CLOCKMODE_HVCLOCK:
-		if (hv_read_tsc_page_tsc(hv_get_tsc_page(),
-					 tsc_timestamp, &tsc_pg_val)) {
-			/* TSC page valid */
-			*mode = VDSO_CLOCKMODE_HVCLOCK;
-			v = (tsc_pg_val - clock->cycle_last) &
-				clock->mask;
-		} else {
-			/* TSC page invalid */
-			*mode = VDSO_CLOCKMODE_NONE;
-		}
-		break;
-	case VDSO_CLOCKMODE_TSC:
-		*mode = VDSO_CLOCKMODE_TSC;
-		*tsc_timestamp = read_tsc();
-		v = (*tsc_timestamp - clock->cycle_last) &
-			clock->mask;
-		break;
-	default:
-		*mode = VDSO_CLOCKMODE_NONE;
-	}
-
-	if (*mode == VDSO_CLOCKMODE_NONE)
-		*tsc_timestamp = v = 0;
-
-	return v * clock->mult;
-}
-
-/*
- * As with get_kvmclock_base_ns(), this counts from boot time, at the
- * frequency of CLOCK_MONOTONIC_RAW (hence adding gtos->offs_boot).
- */
-static int do_kvmclock_base(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->raw_clock.base_cycles;
-		ns += vgettsc(&gtod->raw_clock, tsc_timestamp, &mode);
-		ns >>= gtod->raw_clock.shift;
-		ns += ktime_to_ns(ktime_add(gtod->raw_clock.offset, gtod->offs_boot));
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
-/*
- * This calculates CLOCK_MONOTONIC at the time of the TSC snapshot, with
- * no boot time offset.
- */
-static int do_monotonic(s64 *t, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-		ns += ktime_to_ns(gtod->clock.offset);
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-	*t = ns;
-
-	return mode;
-}
-
-static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
-{
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
-	unsigned long seq;
-	int mode;
-	u64 ns;
-
-	do {
-		seq = read_seqcount_begin(&gtod->seq);
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->clock.base_cycles;
-		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
-		ns >>= gtod->clock.shift;
-	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
-/*
- * Calculates the kvmclock_base_ns (CLOCK_MONOTONIC_RAW + boot time) and
- * reports the TSC value from which it do so. Returns true if host is
- * using TSC based clocksource.
- */
-static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
-{
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
-		return false;
-
-	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
-						     tsc_timestamp));
-}
-
-/*
- * Calculates CLOCK_MONOTONIC and reports the TSC value from which it did
- * so. Returns true if host is using TSC based clocksource.
- */
-bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
-{
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
-		return false;
-
-	return gtod_is_based_on_tsc(do_monotonic(kernel_ns,
-						 tsc_timestamp));
-}
-
-/*
- * Calculates CLOCK_REALTIME and reports the TSC value from which it did
- * so. Returns true if host is using TSC based clocksource.
- *
- * DO NOT USE this for anything related to migration. You want CLOCK_TAI
- * for that.
- */
-static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
-					   u64 *tsc_timestamp)
-{
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
-		return false;
-
-	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
-}
-#endif
-
-/*
- *
- * Assuming a stable TSC across physical CPUS, and a stable TSC
- * across virtual CPUs, the following condition is possible.
- * Each numbered line represents an event visible to both
- * CPUs at the next numbered event.
- *
- * "timespecX" represents host monotonic time. "tscX" represents
- * RDTSC value.
- *
- * 		VCPU0 on CPU0		|	VCPU1 on CPU1
- *
- * 1.  read timespec0,tsc0
- * 2.					| timespec1 = timespec0 + N
- * 					| tsc1 = tsc0 + M
- * 3. transition to guest		| transition to guest
- * 4. ret0 = timespec0 + (rdtsc - tsc0) |
- * 5.				        | ret1 = timespec1 + (rdtsc - tsc1)
- * 				        | ret1 = timespec0 + N + (rdtsc - (tsc0 + M))
- *
- * Since ret0 update is visible to VCPU1 at time 5, to obey monotonicity:
- *
- * 	- ret0 < ret1
- *	- timespec0 + (rdtsc - tsc0) < timespec0 + N + (rdtsc - (tsc0 + M))
- *		...
- *	- 0 < N - M => M < N
- *
- * That is, when timespec0 != timespec1, M < N. Unfortunately that is not
- * always the case (the difference between two distinct xtime instances
- * might be smaller then the difference between corresponding TSC reads,
- * when updating guest vcpus pvclock areas).
- *
- * To avoid that problem, do not allow visibility of distinct
- * system_timestamp/tsc_timestamp values simultaneously: use a master
- * copy of host monotonic time values. Update that master copy
- * in lockstep.
- *
- * Rely on synchronization of host TSCs and guest TSCs for monotonicity.
- *
- */
-
-static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
-{
-#ifdef CONFIG_X86_64
-	struct kvm_arch *ka = &kvm->arch;
-	int vclock_mode;
-	bool host_tsc_clocksource, vcpus_matched;
-
-	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
-			atomic_read(&kvm->online_vcpus));
-
-	/*
-	 * If the host uses TSC clock, then passthrough TSC as stable
-	 * to the guest.
-	 */
-	host_tsc_clocksource = kvm_get_time_and_clockread(
-					&ka->master_kernel_ns,
-					&ka->master_cycle_now);
-
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
-				&& !ka->backwards_tsc_observed
-				&& !ka->boot_vcpu_runs_old_kvmclock;
-
-	if (ka->use_master_clock)
-		atomic_set(&kvm_guest_has_master_clock, 1);
-
-	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
-	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
-#endif
-}
-
-static void kvm_make_mclock_inprogress_request(struct kvm *kvm)
-{
-	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
-}
-
-static void __kvm_start_pvclock_update(struct kvm *kvm)
-{
-	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
-	write_seqcount_begin(&kvm->arch.pvclock_sc);
-}
-
-static void kvm_start_pvclock_update(struct kvm *kvm)
-{
-	kvm_make_mclock_inprogress_request(kvm);
-
-	/* no guest entries from this point */
-	__kvm_start_pvclock_update(kvm);
-}
-
-static void kvm_end_pvclock_update(struct kvm *kvm)
-{
-	struct kvm_arch *ka = &kvm->arch;
-	struct kvm_vcpu *vcpu;
-	unsigned long i;
-
-	write_seqcount_end(&ka->pvclock_sc);
-	raw_spin_unlock_irq(&ka->tsc_write_lock);
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
-
-	/* guest entries allowed */
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
-}
-
-static void kvm_update_masterclock(struct kvm *kvm)
-{
-	kvm_hv_request_tsc_page_update(kvm);
-	kvm_start_pvclock_update(kvm);
-	pvclock_update_vm_gtod_copy(kvm);
-	kvm_end_pvclock_update(kvm);
-}
-
-/*
- * Use the kernel's tsc_khz directly if the TSC is constant, otherwise use KVM's
- * per-CPU value (which may be zero if a CPU is going offline).  Note, tsc_khz
- * can change during boot even if the TSC is constant, as it's possible for KVM
- * to be loaded before TSC calibration completes.  Ideally, KVM would get a
- * notification when calibration completes, but practically speaking calibration
- * will complete before userspace is alive enough to create VMs.
- */
-static unsigned long get_cpu_tsc_khz(void)
-{
-	if (static_cpu_has(X86_FEATURE_CONSTANT_TSC))
-		return tsc_khz;
-	else
-		return __this_cpu_read(cpu_tsc_khz);
-}
-
-/* Called within read_seqcount_begin/retry for kvm->pvclock_sc.  */
-static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-{
-	struct kvm_arch *ka = &kvm->arch;
-	struct pvclock_vcpu_time_info hv_clock;
-
-	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
-	get_cpu();
-
-	data->flags = 0;
-	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
-#ifdef CONFIG_X86_64
-		struct timespec64 ts;
-
-		if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-			data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-			data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-		} else
-#endif
-		data->host_tsc = rdtsc();
-
-		data->flags |= KVM_CLOCK_TSC_STABLE;
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-	} else {
-		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
-	}
-
-	put_cpu();
-}
-
-static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
-{
-	struct kvm_arch *ka = &kvm->arch;
-	unsigned seq;
-
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-		__get_kvmclock(kvm, data);
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-}
-
-u64 get_kvmclock_ns(struct kvm *kvm)
-{
-	struct kvm_clock_data data;
-
-	get_kvmclock(kvm, &data);
-	return data.clock;
-}
-
-static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
-				    struct kvm_vcpu *vcpu,
-				    struct gfn_to_pfn_cache *gpc,
-				    unsigned int offset)
-{
-	struct pvclock_vcpu_time_info *guest_hv_clock;
-	struct pvclock_vcpu_time_info hv_clock;
-	unsigned long flags;
-
-	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
-
-	read_lock_irqsave(&gpc->lock, flags);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
-
-		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
-			return;
-
-		read_lock_irqsave(&gpc->lock, flags);
-	}
-
-	guest_hv_clock = (void *)(gpc->khva + offset);
-
-	/*
-	 * This VCPU is paused, but it's legal for a guest to read another
-	 * VCPU's kvmclock, so we really have to follow the specification where
-	 * it says that version is odd if data is being modified, and even after
-	 * it is consistent.
-	 */
-
-	guest_hv_clock->version = hv_clock.version = (guest_hv_clock->version + 1) | 1;
-	smp_wmb();
-
-	/* retain PVCLOCK_GUEST_STOPPED if set in guest copy */
-	hv_clock.flags |= (guest_hv_clock->flags & PVCLOCK_GUEST_STOPPED);
-
-	memcpy(guest_hv_clock, &hv_clock, sizeof(*guest_hv_clock));
-
-	smp_wmb();
-
-	guest_hv_clock->version = ++hv_clock.version;
-
-	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
-
-	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
-}
-
-int kvm_guest_time_update(struct kvm_vcpu *v)
-{
-	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags, tgt_tsc_khz;
-	unsigned seq;
-	struct kvm_vcpu_arch *vcpu = &v->arch;
-	struct kvm_arch *ka = &v->kvm->arch;
-	s64 kernel_ns;
-	u64 tsc_timestamp, host_tsc;
-	bool use_master_clock;
-
-	kernel_ns = 0;
-	host_tsc = 0;
-
-	/*
-	 * If the host uses TSC clock, then passthrough TSC as stable
-	 * to the guest.
-	 */
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-		use_master_clock = ka->use_master_clock;
-		if (use_master_clock) {
-			host_tsc = ka->master_cycle_now;
-			kernel_ns = ka->master_kernel_ns;
+	if (vcpu->arch.virtual_tsc_khz) {
+		if (data == 0) {
+			/*
+			 * Force synchronization when creating a vCPU, or when
+			 * userspace explicitly writes a zero value.
+			 */
+			synchronizing = true;
+		} else if (kvm->arch.user_set_tsc) {
+			u64 tsc_exp = kvm->arch.last_tsc_write +
+						nsec_to_cycles(vcpu, elapsed);
+			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
+			/*
+			 * Here lies UAPI baggage: when a user-initiated TSC write has
+			 * a small delta (1 second) of virtual cycle time against the
+			 * previously set vCPU, we assume that they were intended to be
+			 * in sync and the delta was only due to the racy nature of the
+			 * legacy API.
+			 *
+			 * This trick falls down when restoring a guest which genuinely
+			 * has been running for less time than the 1 second of imprecision
+			 * which we allow for in the legacy API. In this case, the first
+			 * value written by userspace (on any vCPU) should not be subject
+			 * to this 'correction' to make it sync up with values that only
+			 * come from the kernel's default vCPU creation. Make the 1-second
+			 * slop hack only trigger if the user_set_tsc flag is already set.
+			 */
+			synchronizing = data < tsc_exp + tsc_hz &&
+					data + tsc_hz > tsc_exp;
 		}
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-
-	/* Keep irq disabled to prevent changes to the clock */
-	local_irq_save(flags);
-	tgt_tsc_khz = get_cpu_tsc_khz();
-	if (unlikely(tgt_tsc_khz == 0)) {
-		local_irq_restore(flags);
-		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
-		return 1;
-	}
-	if (!use_master_clock) {
-		host_tsc = rdtsc();
-		kernel_ns = get_kvmclock_base_ns();
 	}
 
-	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
 
 	/*
-	 * We may have to catch up the TSC to match elapsed wall clock
-	 * time for two reasons, even if kvmclock is used.
-	 *   1) CPU could have been running below the maximum TSC rate
-	 *   2) Broken TSC compensation resets the base at each VCPU
-	 *      entry to avoid unknown leaps of TSC even when running
-	 *      again on the same CPU.  This may cause apparent elapsed
-	 *      time to disappear, and the guest to stand still or run
-	 *	very slowly.
-	 */
-	if (vcpu->tsc_catchup) {
-		u64 tsc = compute_guest_tsc(v, kernel_ns);
-		if (tsc > tsc_timestamp) {
-			adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
-			tsc_timestamp = tsc;
-		}
-	}
-
-	local_irq_restore(flags);
-
-	/* With all the info we got, fill in the values */
-
-	if (kvm_caps.has_tsc_control) {
-		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
-					    v->arch.l1_tsc_scaling_ratio);
-		tgt_tsc_khz = tgt_tsc_khz ? : 1;
-	}
-
-	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
-		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
-				   &vcpu->pvclock_tsc_shift,
-				   &vcpu->pvclock_tsc_mul);
-		vcpu->hw_tsc_khz = tgt_tsc_khz;
-	}
-
-	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
-	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
-	hv_clock.tsc_timestamp = tsc_timestamp;
-	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
-	vcpu->last_guest_tsc = tsc_timestamp;
-
-	/* If the host uses TSC clocksource, then it is stable */
-	hv_clock.flags = 0;
-	if (use_master_clock)
-		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
-
-	if (vcpu->pv_time.active) {
-		/*
-		 * GUEST_STOPPED is only supported by kvmclock, and KVM's
-		 * historic behavior is to only process the request if kvmclock
-		 * is active/enabled.
-		 */
-		if (vcpu->pvclock_set_guest_stopped_request) {
-			hv_clock.flags |= PVCLOCK_GUEST_STOPPED;
-			vcpu->pvclock_set_guest_stopped_request = false;
+	 * For a reliable TSC, we can match TSC offsets, and for an unstable
+	 * TSC, we add elapsed time in this computation.  We could let the
+	 * compensation code attempt to catch up if we fall behind, but
+	 * it's better to try to match offsets from the beginning.
+         */
+	if (synchronizing &&
+	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
+		if (!kvm_check_tsc_unstable()) {
+			offset = kvm->arch.cur_tsc_offset;
+		} else {
+			u64 delta = nsec_to_cycles(vcpu, elapsed);
+			data += delta;
+			offset = kvm_compute_l1_tsc_offset(vcpu, data);
 		}
-		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->pv_time, 0);
-
-		hv_clock.flags &= ~PVCLOCK_GUEST_STOPPED;
-	}
-
-	kvm_hv_setup_tsc_page(v->kvm, &hv_clock);
-
-#ifdef CONFIG_KVM_XEN
-	/*
-	 * For Xen guests we may need to override PVCLOCK_TSC_STABLE_BIT as unless
-	 * explicitly told to use TSC as its clocksource Xen will not set this bit.
-	 * This default behaviour led to bugs in some guest kernels which cause
-	 * problems if they observe PVCLOCK_TSC_STABLE_BIT in the pvclock flags.
-	 *
-	 * Note!  Clear TSC_STABLE only for Xen clocks, i.e. the order matters!
-	 */
-	if (ka->xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE)
-		hv_clock.flags &= ~PVCLOCK_TSC_STABLE_BIT;
-
-	if (vcpu->xen.vcpu_info_cache.active)
-		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_info_cache,
-					offsetof(struct compat_vcpu_info, time));
-	if (vcpu->xen.vcpu_time_info_cache.active)
-		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_time_info_cache, 0);
-#endif
-	return 0;
-}
-
-/*
- * The pvclock_wall_clock ABI tells the guest the wall clock time at
- * which it started (i.e. its epoch, when its kvmclock was zero).
- *
- * In fact those clocks are subtly different; wall clock frequency is
- * adjusted by NTP and has leap seconds, while the kvmclock is a
- * simple function of the TSC without any such adjustment.
- *
- * Perhaps the ABI should have exposed CLOCK_TAI and a ratio between
- * that and kvmclock, but even that would be subject to change over
- * time.
- *
- * Attempt to calculate the epoch at a given moment using the *same*
- * TSC reading via kvm_get_walltime_and_clockread() to obtain both
- * wallclock and kvmclock times, and subtracting one from the other.
- *
- * Fall back to using their values at slightly different moments by
- * calling ktime_get_real_ns() and get_kvmclock_ns() separately.
- */
-uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
-{
-#ifdef CONFIG_X86_64
-	struct pvclock_vcpu_time_info hv_clock;
-	struct kvm_arch *ka = &kvm->arch;
-	unsigned long seq, local_tsc_khz;
-	struct timespec64 ts;
-	uint64_t host_tsc;
-
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-
-		local_tsc_khz = 0;
-		if (!ka->use_master_clock)
-			break;
-
-		/*
-		 * The TSC read and the call to get_cpu_tsc_khz() must happen
-		 * on the same CPU.
-		 */
-		get_cpu();
-
-		local_tsc_khz = get_cpu_tsc_khz();
-
-		if (local_tsc_khz &&
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
-			local_tsc_khz = 0; /* Fall back to old method */
-
-		put_cpu();
-
-		/*
-		 * These values must be snapshotted within the seqcount loop.
-		 * After that, it's just mathematics which can happen on any
-		 * CPU at any time.
-		 */
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-
-	/*
-	 * If the conditions were right, and obtaining the wallclock+TSC was
-	 * successful, calculate the KVM clock at the corresponding time and
-	 * subtract one from the other to get the guest's epoch in nanoseconds
-	 * since 1970-01-01.
-	 */
-	if (local_tsc_khz) {
-		kvm_get_time_scale(NSEC_PER_SEC, local_tsc_khz * NSEC_PER_USEC,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		return ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec -
-			__pvclock_read_cycles(&hv_clock, host_tsc);
-	}
-#endif
-	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
-}
-
-/*
- * kvmclock updates which are isolated to a given vcpu, such as
- * vcpu->cpu migration, should not allow system_timestamp from
- * the rest of the vcpus to remain static.
- *
- * So in those cases, request a kvmclock update for all vcpus.
- * The worst case for a remote vcpu to update its kvmclock
- * is then bounded by maximum nohz sleep latency.
- */
-static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
-{
-	unsigned long i;
-	struct kvm_vcpu *vcpu;
-	struct kvm *kvm = v->kvm;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
-		kvm_vcpu_kick(vcpu);
+		matched = true;
 	}
-}
-
-/* These helpers are safe iff @msr is known to be an MCx bank MSR. */
-static bool is_mci_control_msr(u32 msr)
-{
-	return (msr & 3) == 0;
-}
-static bool is_mci_status_msr(u32 msr)
-{
-	return (msr & 3) == 1;
-}
-
-/*
- * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
- */
-static bool can_set_mci_status(struct kvm_vcpu *vcpu)
-{
-	/* McStatusWrEn enabled? */
-	if (guest_cpuid_is_amd_compatible(vcpu))
-		return !!(vcpu->arch.msr_hwcr & BIT_ULL(18));
 
-	return false;
-}
-
-static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-{
-	u64 mcg_cap = vcpu->arch.mcg_cap;
-	unsigned bank_num = mcg_cap & 0xff;
-	u32 msr = msr_info->index;
-	u64 data = msr_info->data;
-	u32 offset, last_msr;
-
-	switch (msr) {
-	case MSR_IA32_MCG_STATUS:
-		vcpu->arch.mcg_status = data;
-		break;
-	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P) &&
-		    (data || !msr_info->host_initiated))
-			return 1;
-		if (data != 0 && data != ~(u64)0)
-			return 1;
-		vcpu->arch.mcg_ctl = data;
-		break;
-	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
-		last_msr = MSR_IA32_MCx_CTL2(bank_num) - 1;
-		if (msr > last_msr)
-			return 1;
-
-		if (!(mcg_cap & MCG_CMCI_P) && (data || !msr_info->host_initiated))
-			return 1;
-		/* An attempt to write a 1 to a reserved bit raises #GP */
-		if (data & ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK))
-			return 1;
-		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL2,
-					    last_msr + 1 - MSR_IA32_MC0_CTL2);
-		vcpu->arch.mci_ctl2_banks[offset] = data;
-		break;
-	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-		last_msr = MSR_IA32_MCx_CTL(bank_num) - 1;
-		if (msr > last_msr)
-			return 1;
-
-		/*
-		 * Only 0 or all 1s can be written to IA32_MCi_CTL, all other
-		 * values are architecturally undefined.  But, some Linux
-		 * kernels clear bit 10 in bank 4 to workaround a BIOS/GART TLB
-		 * issue on AMD K8s, allow bit 10 to be clear when setting all
-		 * other bits in order to avoid an uncaught #GP in the guest.
-		 *
-		 * UNIXWARE clears bit 0 of MC1_CTL to ignore correctable,
-		 * single-bit ECC data errors.
-		 */
-		if (is_mci_control_msr(msr) &&
-		    data != 0 && (data | (1 << 10) | 1) != ~(u64)0)
-			return 1;
-
-		/*
-		 * All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR.
-		 * AMD-based CPUs allow non-zero values, but if and only if
-		 * HWCR[McStatusWrEn] is set.
-		 */
-		if (!msr_info->host_initiated && is_mci_status_msr(msr) &&
-		    data != 0 && !can_set_mci_status(vcpu))
-			return 1;
-
-		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
-					    last_msr + 1 - MSR_IA32_MC0_CTL);
-		vcpu->arch.mce_banks[offset] = data;
-		break;
-	default:
-		return 1;
-	}
-	return 0;
+	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, !!user_value);
+	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 }
 
-static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
-{
-	gpa_t gpa = data & ~0x3f;
+#ifdef CONFIG_X86_64
 
-	/* Bits 4:5 are reserved, Should be zero */
-	if (data & 0x30)
-		return 1;
+static u64 read_tsc(void)
+{
+	u64 ret = (u64)rdtsc_ordered();
+	u64 last = pvclock_gtod_data.clock.cycle_last;
 
-	if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_VMEXIT) &&
-	    (data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT))
-		return 1;
+	if (likely(ret >= last))
+		return ret;
 
-	if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT) &&
-	    (data & KVM_ASYNC_PF_DELIVERY_AS_INT))
-		return 1;
+	/*
+	 * GCC likes to generate cmov here, but this branch is extremely
+	 * predictable (it's just a function of time and the likely is
+	 * very likely) and there's a data dependence, so force GCC
+	 * to generate a branch instead.  I don't barrier() because
+	 * we don't actually need a barrier, and if this function
+	 * ever gets inlined it will generate worse code.
+	 */
+	asm volatile ("");
+	return last;
+}
 
-	if (!lapic_in_kernel(vcpu))
-		return data ? 1 : 0;
+static inline u64 vgettsc(struct pvclock_clock *clock, u64 *tsc_timestamp,
+			  int *mode)
+{
+	u64 tsc_pg_val;
+	long v;
 
-	if (__kvm_pv_async_pf_enabled(data) &&
-	    kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
-				      sizeof(u64)))
-		return 1;
+	switch (clock->vclock_mode) {
+	case VDSO_CLOCKMODE_HVCLOCK:
+		if (hv_read_tsc_page_tsc(hv_get_tsc_page(),
+					 tsc_timestamp, &tsc_pg_val)) {
+			/* TSC page valid */
+			*mode = VDSO_CLOCKMODE_HVCLOCK;
+			v = (tsc_pg_val - clock->cycle_last) &
+				clock->mask;
+		} else {
+			/* TSC page invalid */
+			*mode = VDSO_CLOCKMODE_NONE;
+		}
+		break;
+	case VDSO_CLOCKMODE_TSC:
+		*mode = VDSO_CLOCKMODE_TSC;
+		*tsc_timestamp = read_tsc();
+		v = (*tsc_timestamp - clock->cycle_last) &
+			clock->mask;
+		break;
+	default:
+		*mode = VDSO_CLOCKMODE_NONE;
+	}
 
-	vcpu->arch.apf.msr_en_val = data;
+	if (*mode == VDSO_CLOCKMODE_NONE)
+		*tsc_timestamp = v = 0;
 
-	if (__kvm_pv_async_pf_enabled(data)) {
-		kvm_async_pf_wakeup_all(vcpu);
-	} else {
-		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
-	}
-	return 0;
+	return v * clock->mult;
 }
 
-static int kvm_pv_enable_async_pf_int(struct kvm_vcpu *vcpu, u64 data)
+/*
+ * As with get_kvmclock_base_ns(), this counts from boot time, at the
+ * frequency of CLOCK_MONOTONIC_RAW (hence adding gtos->offs_boot).
+ */
+static int do_kvmclock_base(s64 *t, u64 *tsc_timestamp)
 {
-	/* Bits 8-63 are reserved */
-	if (data >> 8)
-		return 1;
-
-	if (!lapic_in_kernel(vcpu))
-		return 1;
-
-	vcpu->arch.apf.msr_int_val = data;
+	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	unsigned long seq;
+	int mode;
+	u64 ns;
 
-	vcpu->arch.apf.vec = data & KVM_ASYNC_PF_VEC_MASK;
+	do {
+		seq = read_seqcount_begin(&gtod->seq);
+		ns = gtod->raw_clock.base_cycles;
+		ns += vgettsc(&gtod->raw_clock, tsc_timestamp, &mode);
+		ns >>= gtod->raw_clock.shift;
+		ns += ktime_to_ns(ktime_add(gtod->raw_clock.offset, gtod->offs_boot));
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
+	*t = ns;
 
-	return 0;
+	return mode;
 }
 
-static void kvmclock_reset(struct kvm_vcpu *vcpu)
+/*
+ * This calculates CLOCK_MONOTONIC at the time of the TSC snapshot, with
+ * no boot time offset.
+ */
+static int do_monotonic(s64 *t, u64 *tsc_timestamp)
 {
-	kvm_gpc_deactivate(&vcpu->arch.pv_time);
-	vcpu->arch.time = 0;
-}
+	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	unsigned long seq;
+	int mode;
+	u64 ns;
 
-static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *vcpu)
-{
-	++vcpu->stat.tlb_flush;
-	kvm_x86_call(flush_tlb_all)(vcpu);
+	do {
+		seq = read_seqcount_begin(&gtod->seq);
+		ns = gtod->clock.base_cycles;
+		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
+		ns >>= gtod->clock.shift;
+		ns += ktime_to_ns(gtod->clock.offset);
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
+	*t = ns;
 
-	/* Flushing all ASIDs flushes the current ASID... */
-	kvm_clear_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+	return mode;
 }
 
-static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
+static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
 {
-	++vcpu->stat.tlb_flush;
+	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	unsigned long seq;
+	int mode;
+	u64 ns;
 
-	if (!tdp_enabled) {
-		/*
-		 * A TLB flush on behalf of the guest is equivalent to
-		 * INVPCID(all), toggling CR4.PGE, etc., which requires
-		 * a forced sync of the shadow page tables.  Ensure all the
-		 * roots are synced and the guest TLB in hardware is clean.
-		 */
-		kvm_mmu_sync_roots(vcpu);
-		kvm_mmu_sync_prev_roots(vcpu);
-	}
+	do {
+		seq = read_seqcount_begin(&gtod->seq);
+		ts->tv_sec = gtod->wall_time_sec;
+		ns = gtod->clock.base_cycles;
+		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
+		ns >>= gtod->clock.shift;
+	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
 
-	kvm_x86_call(flush_tlb_guest)(vcpu);
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
 
-	/*
-	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
-	 * grained flushing.
-	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	return mode;
 }
 
-
-static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
+/*
+ * Calculates the kvmclock_base_ns (CLOCK_MONOTONIC_RAW + boot time) and
+ * reports the TSC value from which it do so. Returns true if host is
+ * using TSC based clocksource.
+ */
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	++vcpu->stat.tlb_flush;
-	kvm_x86_call(flush_tlb_current)(vcpu);
+	/* checked again under seqlock below */
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+		return false;
+
+	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
+						     tsc_timestamp));
 }
 
 /*
- * Service "local" TLB flush requests, which are specific to the current MMU
- * context.  In addition to the generic event handling in vcpu_enter_guest(),
- * TLB flushes that are targeted at an MMU context also need to be serviced
- * prior before nested VM-Enter/VM-Exit.
+ * Calculates CLOCK_MONOTONIC and reports the TSC value from which it did
+ * so. Returns true if host is using TSC based clocksource.
  */
-void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
+bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
-		kvm_vcpu_flush_tlb_current(vcpu);
+	/* checked again under seqlock below */
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+		return false;
 
-	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu))
-		kvm_vcpu_flush_tlb_guest(vcpu);
+	return gtod_is_based_on_tsc(do_monotonic(kernel_ns,
+						 tsc_timestamp));
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
-static void record_steal_time(struct kvm_vcpu *vcpu)
+/*
+ * Calculates CLOCK_REALTIME and reports the TSC value from which it did
+ * so. Returns true if host is using TSC based clocksource.
+ *
+ * DO NOT USE this for anything related to migration. You want CLOCK_TAI
+ * for that.
+ */
+static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
+					   u64 *tsc_timestamp)
 {
-	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
-	u64 steal;
-	u32 version;
-
-	if (kvm_xen_msr_enabled(vcpu->kvm)) {
-		kvm_xen_runstate_set_running(vcpu);
-		return;
-	}
-
-	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
-		return;
-
-	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
-		return;
+	/* checked again under seqlock below */
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+		return false;
 
-	slots = kvm_memslots(vcpu->kvm);
+	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
+}
+#endif
 
-	if (unlikely(slots->generation != ghc->generation ||
-		     gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
-		/* We rely on the fact that it fits in a single page. */
-		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
+/*
+ *
+ * Assuming a stable TSC across physical CPUS, and a stable TSC
+ * across virtual CPUs, the following condition is possible.
+ * Each numbered line represents an event visible to both
+ * CPUs at the next numbered event.
+ *
+ * "timespecX" represents host monotonic time. "tscX" represents
+ * RDTSC value.
+ *
+ * 		VCPU0 on CPU0		|	VCPU1 on CPU1
+ *
+ * 1.  read timespec0,tsc0
+ * 2.					| timespec1 = timespec0 + N
+ * 					| tsc1 = tsc0 + M
+ * 3. transition to guest		| transition to guest
+ * 4. ret0 = timespec0 + (rdtsc - tsc0) |
+ * 5.				        | ret1 = timespec1 + (rdtsc - tsc1)
+ * 				        | ret1 = timespec0 + N + (rdtsc - (tsc0 + M))
+ *
+ * Since ret0 update is visible to VCPU1 at time 5, to obey monotonicity:
+ *
+ * 	- ret0 < ret1
+ *	- timespec0 + (rdtsc - tsc0) < timespec0 + N + (rdtsc - (tsc0 + M))
+ *		...
+ *	- 0 < N - M => M < N
+ *
+ * That is, when timespec0 != timespec1, M < N. Unfortunately that is not
+ * always the case (the difference between two distinct xtime instances
+ * might be smaller then the difference between corresponding TSC reads,
+ * when updating guest vcpus pvclock areas).
+ *
+ * To avoid that problem, do not allow visibility of distinct
+ * system_timestamp/tsc_timestamp values simultaneously: use a master
+ * copy of host monotonic time values. Update that master copy
+ * in lockstep.
+ *
+ * Rely on synchronization of host TSCs and guest TSCs for monotonicity.
+ *
+ */
 
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
-		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
-			return;
-	}
+static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
+{
+#ifdef CONFIG_X86_64
+	struct kvm_arch *ka = &kvm->arch;
+	int vclock_mode;
+	bool host_tsc_clocksource, vcpus_matched;
+
+	lockdep_assert_held(&kvm->arch.tsc_write_lock);
+	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
+			atomic_read(&kvm->online_vcpus));
 
-	st = (struct kvm_steal_time __user *)ghc->hva;
 	/*
-	 * Doing a TLB flush here, on the guest's behalf, can avoid
-	 * expensive IPIs.
+	 * If the host uses TSC clock, then passthrough TSC as stable
+	 * to the guest.
 	 */
-	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
-		u8 st_preempted = 0;
-		int err = -EFAULT;
-
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		asm volatile("1: xchgb %0, %2\n"
-			     "xor %1, %1\n"
-			     "2:\n"
-			     _ASM_EXTABLE_UA(1b, 2b)
-			     : "+q" (st_preempted),
-			       "+&r" (err),
-			       "+m" (st->preempted));
-		if (err)
-			goto out;
-
-		user_access_end();
+	host_tsc_clocksource = kvm_get_time_and_clockread(
+					&ka->master_kernel_ns,
+					&ka->master_cycle_now);
 
-		vcpu->arch.st.preempted = 0;
+	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
+				&& !ka->backwards_tsc_observed
+				&& !ka->boot_vcpu_runs_old_kvmclock;
 
-		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
-				       st_preempted & KVM_VCPU_FLUSH_TLB);
-		if (st_preempted & KVM_VCPU_FLUSH_TLB)
-			kvm_vcpu_flush_tlb_guest(vcpu);
+	if (ka->use_master_clock)
+		atomic_set(&kvm_guest_has_master_clock, 1);
 
-		if (!user_access_begin(st, sizeof(*st)))
-			goto dirty;
-	} else {
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
+	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
+	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
+					vcpus_matched);
+#endif
+}
 
-		unsafe_put_user(0, &st->preempted, out);
-		vcpu->arch.st.preempted = 0;
-	}
+static void kvm_make_mclock_inprogress_request(struct kvm *kvm)
+{
+	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
+}
 
-	unsafe_get_user(version, &st->version, out);
-	if (version & 1)
-		version += 1;  /* first time write, random junk */
+static void __kvm_start_pvclock_update(struct kvm *kvm)
+{
+	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
+	write_seqcount_begin(&kvm->arch.pvclock_sc);
+}
 
-	version += 1;
-	unsafe_put_user(version, &st->version, out);
+static void kvm_start_pvclock_update(struct kvm *kvm)
+{
+	kvm_make_mclock_inprogress_request(kvm);
 
-	smp_wmb();
+	/* no guest entries from this point */
+	__kvm_start_pvclock_update(kvm);
+}
 
-	unsafe_get_user(steal, &st->steal, out);
-	steal += current->sched_info.run_delay -
-		vcpu->arch.st.last_steal;
-	vcpu->arch.st.last_steal = current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
+static void kvm_end_pvclock_update(struct kvm *kvm)
+{
+	struct kvm_arch *ka = &kvm->arch;
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
 
-	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	write_seqcount_end(&ka->pvclock_sc);
+	raw_spin_unlock_irq(&ka->tsc_write_lock);
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 
- out:
-	user_access_end();
- dirty:
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	/* guest entries allowed */
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
 }
 
-/*
- * Returns true if the MSR in question is managed via XSTATE, i.e. is context
- * switched with the rest of guest FPU state.
- *
- * Note, S_CET is _not_ saved/restored via XSAVES/XRSTORS.
- */
-static bool is_xstate_managed_msr(struct kvm_vcpu *vcpu, u32 msr)
+static void kvm_update_masterclock(struct kvm *kvm)
 {
-	if (!vcpu)
-		return false;
-
-	switch (msr) {
-	case MSR_IA32_U_CET:
-		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ||
-		       guest_cpu_cap_has(vcpu, X86_FEATURE_IBT);
-	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
-		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
-	default:
-		return false;
-	}
+	kvm_hv_request_tsc_page_update(kvm);
+	kvm_start_pvclock_update(kvm);
+	pvclock_update_vm_gtod_copy(kvm);
+	kvm_end_pvclock_update(kvm);
 }
 
 /*
- * Lock (and if necessary, re-load) the guest FPU, i.e. XSTATE, and access an
- * MSR that is managed via XSTATE.  Note, the caller is responsible for doing
- * the initial FPU load, this helper only ensures that guest state is resident
- * in hardware (the kernel can load its FPU state in IRQ context).
- *
- * Note, loading guest values for U_CET and PL[0-3]_SSP while executing in the
- * kernel is safe, as U_CET is specific to userspace, and PL[0-3]_SSP are only
- * consumed when transitioning to lower privilege levels, i.e. are effectively
- * only consumed by userspace as well.
+ * Use the kernel's tsc_khz directly if the TSC is constant, otherwise use KVM's
+ * per-CPU value (which may be zero if a CPU is going offline).  Note, tsc_khz
+ * can change during boot even if the TSC is constant, as it's possible for KVM
+ * to be loaded before TSC calibration completes.  Ideally, KVM would get a
+ * notification when calibration completes, but practically speaking calibration
+ * will complete before userspace is alive enough to create VMs.
  */
-static __always_inline void kvm_access_xstate_msr(struct kvm_vcpu *vcpu,
-						  struct msr_data *msr_info,
-						  int access)
+static unsigned long get_cpu_tsc_khz(void)
 {
-	BUILD_BUG_ON(access != MSR_TYPE_R && access != MSR_TYPE_W);
-
-	KVM_BUG_ON(!is_xstate_managed_msr(vcpu, msr_info->index), vcpu->kvm);
-	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
-
-	kvm_fpu_get();
-	if (access == MSR_TYPE_R)
-		rdmsrq(msr_info->index, msr_info->data);
+	if (static_cpu_has(X86_FEATURE_CONSTANT_TSC))
+		return tsc_khz;
 	else
-		wrmsrq(msr_info->index, msr_info->data);
-	kvm_fpu_put();
+		return __this_cpu_read(cpu_tsc_khz);
 }
 
-static void kvm_set_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+/* Called within read_seqcount_begin/retry for kvm->pvclock_sc.  */
+static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
-	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_W);
-}
+	struct kvm_arch *ka = &kvm->arch;
+	struct pvclock_vcpu_time_info hv_clock;
 
-static void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-{
-	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
+	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
+	get_cpu();
+
+	data->flags = 0;
+	if (ka->use_master_clock &&
+	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
+#ifdef CONFIG_X86_64
+		struct timespec64 ts;
+
+		if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
+			data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+			data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
+		} else
+#endif
+		data->host_tsc = rdtsc();
+
+		data->flags |= KVM_CLOCK_TSC_STABLE;
+		hv_clock.tsc_timestamp = ka->master_cycle_now;
+		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
+				   &hv_clock.tsc_shift,
+				   &hv_clock.tsc_to_system_mul);
+		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+	} else {
+		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
+	}
+
+	put_cpu();
 }
 
-int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
-	u32 msr = msr_info->index;
-	u64 data = msr_info->data;
+	struct kvm_arch *ka = &kvm->arch;
+	unsigned seq;
 
-	/*
-	 * Do not allow host-initiated writes to trigger the Xen hypercall
-	 * page setup; it could incur locking paths which are not expected
-	 * if userspace sets the MSR in an unusual location.
-	 */
-	if (kvm_xen_is_hypercall_page_msr(vcpu->kvm, msr) &&
-	    !msr_info->host_initiated)
-		return kvm_xen_write_hypercall_page(vcpu, data);
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
+		__get_kvmclock(kvm, data);
+	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+}
 
-	switch (msr) {
-	case MSR_AMD64_NB_CFG:
-	case MSR_IA32_UCODE_WRITE:
-	case MSR_VM_HSAVE_PA:
-	case MSR_AMD64_PATCH_LOADER:
-	case MSR_AMD64_BU_CFG2:
-	case MSR_AMD64_DC_CFG:
-	case MSR_AMD64_TW_CFG:
-	case MSR_F15H_EX_CFG:
-		break;
+u64 get_kvmclock_ns(struct kvm *kvm)
+{
+	struct kvm_clock_data data;
 
-	case MSR_IA32_UCODE_REV:
-		if (msr_info->host_initiated)
-			vcpu->arch.microcode_version = data;
-		break;
-	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!msr_info->host_initiated ||
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
-			return KVM_MSR_RET_UNSUPPORTED;
-		vcpu->arch.arch_capabilities = data;
-		break;
-	case MSR_IA32_PERF_CAPABILITIES:
-		if (!msr_info->host_initiated ||
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
-			return KVM_MSR_RET_UNSUPPORTED;
+	get_kvmclock(kvm, &data);
+	return data.clock;
+}
 
-		if (data & ~kvm_caps.supported_perf_cap)
-			return 1;
+static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
+				    struct kvm_vcpu *vcpu,
+				    struct gfn_to_pfn_cache *gpc,
+				    unsigned int offset)
+{
+	struct pvclock_vcpu_time_info *guest_hv_clock;
+	struct pvclock_vcpu_time_info hv_clock;
+	unsigned long flags;
 
-		/*
-		 * Note, this is not just a performance optimization!  KVM
-		 * disallows changing feature MSRs after the vCPU has run; PMU
-		 * refresh will bug the VM if called after the vCPU has run.
-		 */
-		if (vcpu->arch.perf_capabilities == data)
-			break;
+	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-		vcpu->arch.perf_capabilities = data;
-		kvm_pmu_refresh(vcpu);
-		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
-		break;
-	case MSR_IA32_PRED_CMD: {
-		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
+	read_lock_irqsave(&gpc->lock, flags);
+	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
+		read_unlock_irqrestore(&gpc->lock, flags);
 
-		if (!msr_info->host_initiated) {
-			if ((!guest_has_pred_cmd_msr(vcpu)))
-				return 1;
+		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
+			return;
 
-			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-			    !guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBPB))
-				reserved_bits |= PRED_CMD_IBPB;
+		read_lock_irqsave(&gpc->lock, flags);
+	}
 
-			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SBPB))
-				reserved_bits |= PRED_CMD_SBPB;
-		}
+	guest_hv_clock = (void *)(gpc->khva + offset);
 
-		if (!boot_cpu_has(X86_FEATURE_IBPB))
-			reserved_bits |= PRED_CMD_IBPB;
+	/*
+	 * This VCPU is paused, but it's legal for a guest to read another
+	 * VCPU's kvmclock, so we really have to follow the specification where
+	 * it says that version is odd if data is being modified, and even after
+	 * it is consistent.
+	 */
 
-		if (!boot_cpu_has(X86_FEATURE_SBPB))
-			reserved_bits |= PRED_CMD_SBPB;
+	guest_hv_clock->version = hv_clock.version = (guest_hv_clock->version + 1) | 1;
+	smp_wmb();
 
-		if (data & reserved_bits)
-			return 1;
+	/* retain PVCLOCK_GUEST_STOPPED if set in guest copy */
+	hv_clock.flags |= (guest_hv_clock->flags & PVCLOCK_GUEST_STOPPED);
 
-		if (!data)
-			break;
+	memcpy(guest_hv_clock, &hv_clock, sizeof(*guest_hv_clock));
 
-		wrmsrq(MSR_IA32_PRED_CMD, data);
-		break;
-	}
-	case MSR_IA32_FLUSH_CMD:
-		if (!msr_info->host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D))
-			return 1;
+	smp_wmb();
 
-		if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D) || (data & ~L1D_FLUSH))
-			return 1;
-		if (!data)
-			break;
+	guest_hv_clock->version = ++hv_clock.version;
 
-		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
-		break;
-	case MSR_EFER:
-		return set_efer(vcpu, msr_info);
-	case MSR_K7_HWCR: {
-		/*
-		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
-		 * through at least v6.6 whine if TscFreqSel is clear,
-		 * depending on F/M/S.
-		 */
-		u64 valid = BIT_ULL(18) | BIT_ULL(24);
+	kvm_gpc_mark_dirty_in_slot(gpc);
+	read_unlock_irqrestore(&gpc->lock, flags);
 
-		data &= ~(u64)0x40;	/* ignore flush filter disable */
-		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
-		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
+}
 
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
-			valid |= MSR_K7_HWCR_CPUID_USER_DIS;
+int kvm_guest_time_update(struct kvm_vcpu *v)
+{
+	struct pvclock_vcpu_time_info hv_clock = {};
+	unsigned long flags, tgt_tsc_khz;
+	unsigned seq;
+	struct kvm_vcpu_arch *vcpu = &v->arch;
+	struct kvm_arch *ka = &v->kvm->arch;
+	s64 kernel_ns;
+	u64 tsc_timestamp, host_tsc;
+	bool use_master_clock;
 
-		if (data & ~valid) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-			return 1;
-		}
-		vcpu->arch.msr_hwcr = data;
-		break;
-	}
-	case MSR_FAM10H_MMIO_CONF_BASE:
-		if (data != 0) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-			return 1;
-		}
-		break;
-	case MSR_IA32_CR_PAT:
-		if (!kvm_pat_valid(data))
-			return 1;
+	kernel_ns = 0;
+	host_tsc = 0;
 
-		vcpu->arch.pat = data;
-		break;
-	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
-	case MSR_MTRRdefType:
-		return kvm_mtrr_set_msr(vcpu, msr, data);
-	case MSR_IA32_APICBASE:
-		return kvm_apic_set_base(vcpu, data, msr_info->host_initiated);
-	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
-		return kvm_x2apic_msr_write(vcpu, msr, data);
-	case MSR_IA32_TSC_DEADLINE:
-		kvm_set_lapic_tscdeadline_msr(vcpu, data);
-		break;
-	case MSR_IA32_TSC_ADJUST:
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_TSC_ADJUST)) {
-			if (!msr_info->host_initiated) {
-				s64 adj = data - vcpu->arch.ia32_tsc_adjust_msr;
-				adjust_tsc_offset_guest(vcpu, adj);
-				/* Before back to guest, tsc_timestamp must be adjusted
-				 * as well, otherwise guest's percpu pvclock time could jump.
-				 */
-				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
-			}
-			vcpu->arch.ia32_tsc_adjust_msr = data;
+	/*
+	 * If the host uses TSC clock, then passthrough TSC as stable
+	 * to the guest.
+	 */
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
+		use_master_clock = ka->use_master_clock;
+		if (use_master_clock) {
+			host_tsc = ka->master_cycle_now;
+			kernel_ns = ka->master_kernel_ns;
 		}
-		break;
-	case MSR_IA32_MISC_ENABLE: {
-		u64 old_val = vcpu->arch.ia32_misc_enable_msr;
+	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 
-		if (!msr_info->host_initiated) {
-			/* RO bits */
-			if ((old_val ^ data) & MSR_IA32_MISC_ENABLE_PMU_RO_MASK)
-				return 1;
+	/* Keep irq disabled to prevent changes to the clock */
+	local_irq_save(flags);
+	tgt_tsc_khz = get_cpu_tsc_khz();
+	if (unlikely(tgt_tsc_khz == 0)) {
+		local_irq_restore(flags);
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
+		return 1;
+	}
+	if (!use_master_clock) {
+		host_tsc = rdtsc();
+		kernel_ns = get_kvmclock_base_ns();
+	}
 
-			/* R bits, i.e. writes are ignored, but don't fault. */
-			data = data & ~MSR_IA32_MISC_ENABLE_EMON;
-			data |= old_val & MSR_IA32_MISC_ENABLE_EMON;
-		}
+	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
 
-		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT) &&
-		    ((old_val ^ data)  & MSR_IA32_MISC_ENABLE_MWAIT)) {
-			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XMM3))
-				return 1;
-			vcpu->arch.ia32_misc_enable_msr = data;
-			vcpu->arch.cpuid_dynamic_bits_dirty = true;
-		} else {
-			vcpu->arch.ia32_misc_enable_msr = data;
+	/*
+	 * We may have to catch up the TSC to match elapsed wall clock
+	 * time for two reasons, even if kvmclock is used.
+	 *   1) CPU could have been running below the maximum TSC rate
+	 *   2) Broken TSC compensation resets the base at each VCPU
+	 *      entry to avoid unknown leaps of TSC even when running
+	 *      again on the same CPU.  This may cause apparent elapsed
+	 *      time to disappear, and the guest to stand still or run
+	 *	very slowly.
+	 */
+	if (vcpu->tsc_catchup) {
+		u64 tsc = compute_guest_tsc(v, kernel_ns);
+		if (tsc > tsc_timestamp) {
+			adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
+			tsc_timestamp = tsc;
 		}
-		break;
 	}
-	case MSR_IA32_SMBASE:
-		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
-			return 1;
-		vcpu->arch.smbase = data;
-		break;
-	case MSR_IA32_POWER_CTL:
-		vcpu->arch.msr_ia32_power_ctl = data;
-		break;
-	case MSR_IA32_TSC:
-		if (msr_info->host_initiated) {
-			kvm_synchronize_tsc(vcpu, &data);
-		} else if (!vcpu->arch.guest_tsc_protected) {
-			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
-			adjust_tsc_offset_guest(vcpu, adj);
-			vcpu->arch.ia32_tsc_adjust_msr += adj;
-		}
-		break;
-	case MSR_IA32_XSS:
-		if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
-			return KVM_MSR_RET_UNSUPPORTED;
-
-		if (data & ~vcpu->arch.guest_supported_xss)
-			return 1;
-		if (vcpu->arch.ia32_xss == data)
-			break;
-		vcpu->arch.ia32_xss = data;
-		vcpu->arch.cpuid_dynamic_bits_dirty = true;
-		break;
-	case MSR_SMI_COUNT:
-		if (!msr_info->host_initiated)
-			return 1;
-		vcpu->arch.smi_count = data;
-		break;
-	case MSR_KVM_WALL_CLOCK_NEW:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return KVM_MSR_RET_UNSUPPORTED;
 
-		vcpu->kvm->arch.wall_clock = data;
-		kvm_write_wall_clock(vcpu->kvm, data, 0);
-		break;
-	case MSR_KVM_WALL_CLOCK:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return KVM_MSR_RET_UNSUPPORTED;
+	local_irq_restore(flags);
 
-		vcpu->kvm->arch.wall_clock = data;
-		kvm_write_wall_clock(vcpu->kvm, data, 0);
-		break;
-	case MSR_KVM_SYSTEM_TIME_NEW:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return KVM_MSR_RET_UNSUPPORTED;
+	/* With all the info we got, fill in the values */
 
-		kvm_write_system_time(vcpu, data, false, msr_info->host_initiated);
-		break;
-	case MSR_KVM_SYSTEM_TIME:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return KVM_MSR_RET_UNSUPPORTED;
+	if (kvm_caps.has_tsc_control) {
+		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
+					    v->arch.l1_tsc_scaling_ratio);
+		tgt_tsc_khz = tgt_tsc_khz ? : 1;
+	}
 
-		kvm_write_system_time(vcpu, data, true,  msr_info->host_initiated);
-		break;
-	case MSR_KVM_ASYNC_PF_EN:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
-			return KVM_MSR_RET_UNSUPPORTED;
+	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
+				   &vcpu->pvclock_tsc_shift,
+				   &vcpu->pvclock_tsc_mul);
+		vcpu->hw_tsc_khz = tgt_tsc_khz;
+	}
 
-		if (kvm_pv_enable_async_pf(vcpu, data))
-			return 1;
-		break;
-	case MSR_KVM_ASYNC_PF_INT:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return KVM_MSR_RET_UNSUPPORTED;
+	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
+	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
+	hv_clock.tsc_timestamp = tsc_timestamp;
+	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
+	vcpu->last_guest_tsc = tsc_timestamp;
 
-		if (kvm_pv_enable_async_pf_int(vcpu, data))
-			return 1;
-		break;
-	case MSR_KVM_ASYNC_PF_ACK:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (data & 0x1) {
-			/*
-			 * Pairs with the smp_mb__after_atomic() in
-			 * kvm_arch_async_page_present_queued().
-			 */
-			smp_store_mb(vcpu->arch.apf.pageready_pending, false);
+	/* If the host uses TSC clocksource, then it is stable */
+	hv_clock.flags = 0;
+	if (use_master_clock)
+		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
 
-			kvm_check_async_pf_completion(vcpu);
+	if (vcpu->pv_time.active) {
+		/*
+		 * GUEST_STOPPED is only supported by kvmclock, and KVM's
+		 * historic behavior is to only process the request if kvmclock
+		 * is active/enabled.
+		 */
+		if (vcpu->pvclock_set_guest_stopped_request) {
+			hv_clock.flags |= PVCLOCK_GUEST_STOPPED;
+			vcpu->pvclock_set_guest_stopped_request = false;
 		}
-		break;
-	case MSR_KVM_STEAL_TIME:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
-			return KVM_MSR_RET_UNSUPPORTED;
-
-		if (unlikely(!sched_info_on()))
-			return 1;
+		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->pv_time, 0);
 
-		if (data & KVM_STEAL_RESERVED_MASK)
-			return 1;
+		hv_clock.flags &= ~PVCLOCK_GUEST_STOPPED;
+	}
 
-		vcpu->arch.st.msr_val = data;
+	kvm_hv_setup_tsc_page(v->kvm, &hv_clock);
 
-		if (!(data & KVM_MSR_ENABLED))
-			break;
+#ifdef CONFIG_KVM_XEN
+	/*
+	 * For Xen guests we may need to override PVCLOCK_TSC_STABLE_BIT as unless
+	 * explicitly told to use TSC as its clocksource Xen will not set this bit.
+	 * This default behaviour led to bugs in some guest kernels which cause
+	 * problems if they observe PVCLOCK_TSC_STABLE_BIT in the pvclock flags.
+	 *
+	 * Note!  Clear TSC_STABLE only for Xen clocks, i.e. the order matters!
+	 */
+	if (ka->xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE)
+		hv_clock.flags &= ~PVCLOCK_TSC_STABLE_BIT;
 
-		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+	if (vcpu->xen.vcpu_info_cache.active)
+		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_info_cache,
+					offsetof(struct compat_vcpu_info, time));
+	if (vcpu->xen.vcpu_time_info_cache.active)
+		kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_time_info_cache, 0);
+#endif
+	return 0;
+}
 
-		break;
-	case MSR_KVM_PV_EOI_EN:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
-			return KVM_MSR_RET_UNSUPPORTED;
+/*
+ * The pvclock_wall_clock ABI tells the guest the wall clock time at
+ * which it started (i.e. its epoch, when its kvmclock was zero).
+ *
+ * In fact those clocks are subtly different; wall clock frequency is
+ * adjusted by NTP and has leap seconds, while the kvmclock is a
+ * simple function of the TSC without any such adjustment.
+ *
+ * Perhaps the ABI should have exposed CLOCK_TAI and a ratio between
+ * that and kvmclock, but even that would be subject to change over
+ * time.
+ *
+ * Attempt to calculate the epoch at a given moment using the *same*
+ * TSC reading via kvm_get_walltime_and_clockread() to obtain both
+ * wallclock and kvmclock times, and subtracting one from the other.
+ *
+ * Fall back to using their values at slightly different moments by
+ * calling ktime_get_real_ns() and get_kvmclock_ns() separately.
+ */
+uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
+{
+#ifdef CONFIG_X86_64
+	struct pvclock_vcpu_time_info hv_clock;
+	struct kvm_arch *ka = &kvm->arch;
+	unsigned long seq, local_tsc_khz;
+	struct timespec64 ts;
+	uint64_t host_tsc;
 
-		if (kvm_lapic_set_pv_eoi(vcpu, data, sizeof(u8)))
-			return 1;
-		break;
+	do {
+		seq = read_seqcount_begin(&ka->pvclock_sc);
 
-	case MSR_KVM_POLL_CONTROL:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
-			return KVM_MSR_RET_UNSUPPORTED;
+		local_tsc_khz = 0;
+		if (!ka->use_master_clock)
+			break;
 
-		/* only enable bit supported */
-		if (data & (-1ULL << 1))
-			return 1;
+		/*
+		 * The TSC read and the call to get_cpu_tsc_khz() must happen
+		 * on the same CPU.
+		 */
+		get_cpu();
 
-		vcpu->arch.msr_kvm_poll_control = data;
-		break;
+		local_tsc_khz = get_cpu_tsc_khz();
 
-	case MSR_IA32_MCG_CTL:
-	case MSR_IA32_MCG_STATUS:
-	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
-		return set_msr_mce(vcpu, msr_info);
+		if (local_tsc_khz &&
+		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
+			local_tsc_khz = 0; /* Fall back to old method */
 
-	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
-	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
-	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
-		if (kvm_pmu_is_valid_msr(vcpu, msr))
-			return kvm_pmu_set_msr(vcpu, msr_info);
+		put_cpu();
 
-		if (data)
-			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-		break;
-	case MSR_K7_CLK_CTL:
 		/*
-		 * Ignore all writes to this no longer documented MSR.
-		 * Writes are only relevant for old K7 processors,
-		 * all pre-dating SVM, but a recommended workaround from
-		 * AMD for these chips. It is possible to specify the
-		 * affected processor models on the command line, hence
-		 * the need to ignore the workaround.
-		 */
-		break;
-#ifdef CONFIG_KVM_HYPERV
-	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
-	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
-	case HV_X64_MSR_SYNDBG_OPTIONS:
-	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
-	case HV_X64_MSR_CRASH_CTL:
-	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
-	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
-	case HV_X64_MSR_TSC_EMULATION_CONTROL:
-	case HV_X64_MSR_TSC_EMULATION_STATUS:
-	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
-		return kvm_hv_set_msr_common(vcpu, msr, data,
-					     msr_info->host_initiated);
-#endif
-	case MSR_IA32_BBL_CR_CTL3:
-		/* Drop writes to this legacy MSR -- see rdmsr
-		 * counterpart for further detail.
+		 * These values must be snapshotted within the seqcount loop.
+		 * After that, it's just mathematics which can happen on any
+		 * CPU at any time.
 		 */
-		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-		break;
-	case MSR_AMD64_OSVW_ID_LENGTH:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
-		vcpu->arch.osvw.length = data;
-		break;
-	case MSR_AMD64_OSVW_STATUS:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
-		vcpu->arch.osvw.status = data;
-		break;
-	case MSR_PLATFORM_INFO:
-		if (!msr_info->host_initiated)
-			return 1;
-		vcpu->arch.msr_platform_info = data;
-		break;
-	case MSR_MISC_FEATURES_ENABLES:
-		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
-		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
-			return 1;
-		vcpu->arch.msr_misc_features_enables = data;
-		break;
-#ifdef CONFIG_X86_64
-	case MSR_IA32_XFD:
-		if (!msr_info->host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
-
-		if (data & ~kvm_guest_supported_xfd(vcpu))
-			return 1;
-
-		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
-		break;
-	case MSR_IA32_XFD_ERR:
-		if (!msr_info->host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
-
-		if (data & ~kvm_guest_supported_xfd(vcpu))
-			return 1;
+		hv_clock.tsc_timestamp = ka->master_cycle_now;
+		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 
-		vcpu->arch.guest_fpu.xfd_err = data;
-		break;
-#endif
-	case MSR_IA32_U_CET:
-	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
-		kvm_set_xstate_msr(vcpu, msr_info);
-		break;
-	default:
-		if (kvm_pmu_is_valid_msr(vcpu, msr))
-			return kvm_pmu_set_msr(vcpu, msr_info);
+	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 
-		return KVM_MSR_RET_UNSUPPORTED;
+	/*
+	 * If the conditions were right, and obtaining the wallclock+TSC was
+	 * successful, calculate the KVM clock at the corresponding time and
+	 * subtract one from the other to get the guest's epoch in nanoseconds
+	 * since 1970-01-01.
+	 */
+	if (local_tsc_khz) {
+		kvm_get_time_scale(NSEC_PER_SEC, local_tsc_khz * NSEC_PER_USEC,
+				   &hv_clock.tsc_shift,
+				   &hv_clock.tsc_to_system_mul);
+		return ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec -
+			__pvclock_read_cycles(&hv_clock, host_tsc);
 	}
-	return 0;
+#endif
+	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_msr_common);
 
-static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
+/*
+ * kvmclock updates which are isolated to a given vcpu, such as
+ * vcpu->cpu migration, should not allow system_timestamp from
+ * the rest of the vcpus to remain static.
+ *
+ * So in those cases, request a kvmclock update for all vcpus.
+ * The worst case for a remote vcpu to update its kvmclock
+ * is then bounded by maximum nohz sleep latency.
+ */
+static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
 {
-	u64 data;
-	u64 mcg_cap = vcpu->arch.mcg_cap;
-	unsigned bank_num = mcg_cap & 0xff;
-	u32 offset, last_msr;
-
-	switch (msr) {
-	case MSR_IA32_P5_MC_ADDR:
-	case MSR_IA32_P5_MC_TYPE:
-		data = 0;
-		break;
-	case MSR_IA32_MCG_CAP:
-		data = vcpu->arch.mcg_cap;
-		break;
-	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P) && !host)
-			return 1;
-		data = vcpu->arch.mcg_ctl;
-		break;
-	case MSR_IA32_MCG_STATUS:
-		data = vcpu->arch.mcg_status;
-		break;
-	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
-		last_msr = MSR_IA32_MCx_CTL2(bank_num) - 1;
-		if (msr > last_msr)
-			return 1;
-
-		if (!(mcg_cap & MCG_CMCI_P) && !host)
-			return 1;
-		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL2,
-					    last_msr + 1 - MSR_IA32_MC0_CTL2);
-		data = vcpu->arch.mci_ctl2_banks[offset];
-		break;
-	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-		last_msr = MSR_IA32_MCx_CTL(bank_num) - 1;
-		if (msr > last_msr)
-			return 1;
-
-		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
-					    last_msr + 1 - MSR_IA32_MC0_CTL);
-		data = vcpu->arch.mce_banks[offset];
-		break;
-	default:
-		return 1;
+	unsigned long i;
+	struct kvm_vcpu *vcpu;
+	struct kvm *kvm = v->kvm;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+		kvm_vcpu_kick(vcpu);
 	}
-	*pdata = data;
-	return 0;
 }
 
-int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-{
-	switch (msr_info->index) {
-	case MSR_IA32_PLATFORM_ID:
-	case MSR_IA32_EBL_CR_POWERON:
-	case MSR_IA32_LASTBRANCHFROMIP:
-	case MSR_IA32_LASTBRANCHTOIP:
-	case MSR_IA32_LASTINTFROMIP:
-	case MSR_IA32_LASTINTTOIP:
-	case MSR_AMD64_SYSCFG:
-	case MSR_K8_TSEG_ADDR:
-	case MSR_K8_TSEG_MASK:
-	case MSR_VM_HSAVE_PA:
-	case MSR_K8_INT_PENDING_MSG:
-	case MSR_AMD64_NB_CFG:
-	case MSR_FAM10H_MMIO_CONF_BASE:
-	case MSR_AMD64_BU_CFG2:
-	case MSR_IA32_PERF_CTL:
-	case MSR_AMD64_DC_CFG:
-	case MSR_AMD64_TW_CFG:
-	case MSR_F15H_EX_CFG:
-	/*
-	 * Intel Sandy Bridge CPUs must support the RAPL (running average power
-	 * limit) MSRs. Just return 0, as we do not want to expose the host
-	 * data here. Do not conditionalize this on CPUID, as KVM does not do
-	 * so for existing CPU-specific MSRs.
-	 */
-	case MSR_RAPL_POWER_UNIT:
-	case MSR_PP0_ENERGY_STATUS:	/* Power plane 0 (core) */
-	case MSR_PP1_ENERGY_STATUS:	/* Power plane 1 (graphics uncore) */
-	case MSR_PKG_ENERGY_STATUS:	/* Total package */
-	case MSR_DRAM_ENERGY_STATUS:	/* DRAM controller */
-		msr_info->data = 0;
-		break;
-	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
-	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
-	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
-		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
-			return kvm_pmu_get_msr(vcpu, msr_info);
-		msr_info->data = 0;
-		break;
-	case MSR_IA32_UCODE_REV:
-		msr_info->data = vcpu->arch.microcode_version;
-		break;
-	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
-			return KVM_MSR_RET_UNSUPPORTED;
-		msr_info->data = vcpu->arch.arch_capabilities;
-		break;
-	case MSR_IA32_PERF_CAPABILITIES:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
-			return KVM_MSR_RET_UNSUPPORTED;
-		msr_info->data = vcpu->arch.perf_capabilities;
-		break;
-	case MSR_IA32_POWER_CTL:
-		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
-		break;
-	case MSR_IA32_TSC: {
-		/*
-		 * Intel SDM states that MSR_IA32_TSC read adds the TSC offset
-		 * even when not intercepted. AMD manual doesn't explicitly
-		 * state this but appears to behave the same.
-		 *
-		 * On userspace reads and writes, however, we unconditionally
-		 * return L1's TSC value to ensure backwards-compatible
-		 * behavior for migration.
-		 */
-		u64 offset, ratio;
+static void kvmclock_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_gpc_deactivate(&vcpu->arch.pv_time);
+	vcpu->arch.time = 0;
+}
 
-		if (msr_info->host_initiated) {
-			offset = vcpu->arch.l1_tsc_offset;
-			ratio = vcpu->arch.l1_tsc_scaling_ratio;
-		} else {
-			offset = vcpu->arch.tsc_offset;
-			ratio = vcpu->arch.tsc_scaling_ratio;
-		}
+static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *vcpu)
+{
+	++vcpu->stat.tlb_flush;
+	kvm_x86_call(flush_tlb_all)(vcpu);
 
-		msr_info->data = kvm_scale_tsc(rdtsc(), ratio) + offset;
-		break;
-	}
-	case MSR_IA32_CR_PAT:
-		msr_info->data = vcpu->arch.pat;
-		break;
-	case MSR_MTRRcap:
-	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
-	case MSR_MTRRdefType:
-		return kvm_mtrr_get_msr(vcpu, msr_info->index, &msr_info->data);
-	case 0xcd: /* fsb frequency */
-		msr_info->data = 3;
-		break;
+	/* Flushing all ASIDs flushes the current ASID... */
+	kvm_clear_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+}
+
+static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
+{
+	++vcpu->stat.tlb_flush;
+
+	if (!tdp_enabled) {
 		/*
-		 * MSR_EBC_FREQUENCY_ID
-		 * Conservative value valid for even the basic CPU models.
-		 * Models 0,1: 000 in bits 23:21 indicating a bus speed of
-		 * 100MHz, model 2 000 in bits 18:16 indicating 100MHz,
-		 * and 266MHz for model 3, or 4. Set Core Clock
-		 * Frequency to System Bus Frequency Ratio to 1 (bits
-		 * 31:24) even though these are only valid for CPU
-		 * models > 2, however guests may end up dividing or
-		 * multiplying by zero otherwise.
+		 * A TLB flush on behalf of the guest is equivalent to
+		 * INVPCID(all), toggling CR4.PGE, etc., which requires
+		 * a forced sync of the shadow page tables.  Ensure all the
+		 * roots are synced and the guest TLB in hardware is clean.
 		 */
-	case MSR_EBC_FREQUENCY_ID:
-		msr_info->data = 1 << 24;
-		break;
-	case MSR_IA32_APICBASE:
-		msr_info->data = vcpu->arch.apic_base;
-		break;
-	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
-		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
-	case MSR_IA32_TSC_DEADLINE:
-		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
-		break;
-	case MSR_IA32_TSC_ADJUST:
-		msr_info->data = (u64)vcpu->arch.ia32_tsc_adjust_msr;
-		break;
-	case MSR_IA32_MISC_ENABLE:
-		msr_info->data = vcpu->arch.ia32_misc_enable_msr;
-		break;
-	case MSR_IA32_SMBASE:
-		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
-			return 1;
-		msr_info->data = vcpu->arch.smbase;
-		break;
-	case MSR_SMI_COUNT:
-		msr_info->data = vcpu->arch.smi_count;
-		break;
-	case MSR_IA32_PERF_STATUS:
-		/* TSC increment by tick */
-		msr_info->data = 1000ULL;
-		/* CPU multiplier */
-		msr_info->data |= (((uint64_t)4ULL) << 40);
-		break;
-	case MSR_EFER:
-		msr_info->data = vcpu->arch.efer;
-		break;
-	case MSR_KVM_WALL_CLOCK:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return KVM_MSR_RET_UNSUPPORTED;
+		kvm_mmu_sync_roots(vcpu);
+		kvm_mmu_sync_prev_roots(vcpu);
+	}
 
-		msr_info->data = vcpu->kvm->arch.wall_clock;
-		break;
-	case MSR_KVM_WALL_CLOCK_NEW:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return KVM_MSR_RET_UNSUPPORTED;
+	kvm_x86_call(flush_tlb_guest)(vcpu);
 
-		msr_info->data = vcpu->kvm->arch.wall_clock;
-		break;
-	case MSR_KVM_SYSTEM_TIME:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return KVM_MSR_RET_UNSUPPORTED;
+	/*
+	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
+	 * grained flushing.
+	 */
+	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+}
 
-		msr_info->data = vcpu->arch.time;
-		break;
-	case MSR_KVM_SYSTEM_TIME_NEW:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return KVM_MSR_RET_UNSUPPORTED;
 
-		msr_info->data = vcpu->arch.time;
-		break;
-	case MSR_KVM_ASYNC_PF_EN:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
-			return KVM_MSR_RET_UNSUPPORTED;
+static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
+{
+	++vcpu->stat.tlb_flush;
+	kvm_x86_call(flush_tlb_current)(vcpu);
+}
 
-		msr_info->data = vcpu->arch.apf.msr_en_val;
-		break;
-	case MSR_KVM_ASYNC_PF_INT:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return KVM_MSR_RET_UNSUPPORTED;
+/*
+ * Service "local" TLB flush requests, which are specific to the current MMU
+ * context.  In addition to the generic event handling in vcpu_enter_guest(),
+ * TLB flushes that are targeted at an MMU context also need to be serviced
+ * prior before nested VM-Enter/VM-Exit.
+ */
+void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
+{
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
+		kvm_vcpu_flush_tlb_current(vcpu);
 
-		msr_info->data = vcpu->arch.apf.msr_int_val;
-		break;
-	case MSR_KVM_ASYNC_PF_ACK:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return KVM_MSR_RET_UNSUPPORTED;
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu))
+		kvm_vcpu_flush_tlb_guest(vcpu);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
-		msr_info->data = 0;
-		break;
-	case MSR_KVM_STEAL_TIME:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
-			return KVM_MSR_RET_UNSUPPORTED;
+static void record_steal_time(struct kvm_vcpu *vcpu)
+{
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
+	struct kvm_steal_time __user *st;
+	struct kvm_memslots *slots;
+	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	u64 steal;
+	u32 version;
 
-		msr_info->data = vcpu->arch.st.msr_val;
-		break;
-	case MSR_KVM_PV_EOI_EN:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
-			return KVM_MSR_RET_UNSUPPORTED;
+	if (kvm_xen_msr_enabled(vcpu->kvm)) {
+		kvm_xen_runstate_set_running(vcpu);
+		return;
+	}
 
-		msr_info->data = vcpu->arch.pv_eoi.msr_val;
-		break;
-	case MSR_KVM_POLL_CONTROL:
-		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
-			return KVM_MSR_RET_UNSUPPORTED;
+	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
+		return;
 
-		msr_info->data = vcpu->arch.msr_kvm_poll_control;
-		break;
-	case MSR_IA32_P5_MC_ADDR:
-	case MSR_IA32_P5_MC_TYPE:
-	case MSR_IA32_MCG_CAP:
-	case MSR_IA32_MCG_CTL:
-	case MSR_IA32_MCG_STATUS:
-	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
-		return get_msr_mce(vcpu, msr_info->index, &msr_info->data,
-				   msr_info->host_initiated);
-	case MSR_IA32_XSS:
-		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
-			return 1;
-		msr_info->data = vcpu->arch.ia32_xss;
-		break;
-	case MSR_K7_CLK_CTL:
-		/*
-		 * Provide expected ramp-up count for K7. All other
-		 * are set to zero, indicating minimum divisors for
-		 * every field.
-		 *
-		 * This prevents guest kernels on AMD host with CPU
-		 * type 6, model 8 and higher from exploding due to
-		 * the rdmsr failing.
-		 */
-		msr_info->data = 0x20000000;
-		break;
-#ifdef CONFIG_KVM_HYPERV
-	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
-	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
-	case HV_X64_MSR_SYNDBG_OPTIONS:
-	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
-	case HV_X64_MSR_CRASH_CTL:
-	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
-	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
-	case HV_X64_MSR_TSC_EMULATION_CONTROL:
-	case HV_X64_MSR_TSC_EMULATION_STATUS:
-	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
-		return kvm_hv_get_msr_common(vcpu,
-					     msr_info->index, &msr_info->data,
-					     msr_info->host_initiated);
-#endif
-	case MSR_IA32_BBL_CR_CTL3:
-		/* This legacy MSR exists but isn't fully documented in current
-		 * silicon.  It is however accessed by winxp in very narrow
-		 * scenarios where it sets bit #19, itself documented as
-		 * a "reserved" bit.  Best effort attempt to source coherent
-		 * read data here should the balance of the register be
-		 * interpreted by the guest:
-		 *
-		 * L2 cache control register 3: 64GB range, 256KB size,
-		 * enabled, latency 0x1, configured
-		 */
-		msr_info->data = 0xbe702111;
-		break;
-	case MSR_AMD64_OSVW_ID_LENGTH:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
-		msr_info->data = vcpu->arch.osvw.length;
-		break;
-	case MSR_AMD64_OSVW_STATUS:
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
-		msr_info->data = vcpu->arch.osvw.status;
-		break;
-	case MSR_PLATFORM_INFO:
-		if (!msr_info->host_initiated &&
-		    !vcpu->kvm->arch.guest_can_read_msr_platform_info)
-			return 1;
-		msr_info->data = vcpu->arch.msr_platform_info;
-		break;
-	case MSR_MISC_FEATURES_ENABLES:
-		msr_info->data = vcpu->arch.msr_misc_features_enables;
-		break;
-	case MSR_K7_HWCR:
-		msr_info->data = vcpu->arch.msr_hwcr;
-		break;
-#ifdef CONFIG_X86_64
-	case MSR_IA32_XFD:
-		if (!msr_info->host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
+		return;
 
-		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
-		break;
-	case MSR_IA32_XFD_ERR:
-		if (!msr_info->host_initiated &&
-		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+	slots = kvm_memslots(vcpu->kvm);
 
-		msr_info->data = vcpu->arch.guest_fpu.xfd_err;
-		break;
-#endif
-	case MSR_IA32_U_CET:
-	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
-		kvm_get_xstate_msr(vcpu, msr_info);
-		break;
-	default:
-		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
-			return kvm_pmu_get_msr(vcpu, msr_info);
+	if (unlikely(slots->generation != ghc->generation ||
+		     gpa != ghc->gpa ||
+		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+		/* We rely on the fact that it fits in a single page. */
+		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
 
-		return KVM_MSR_RET_UNSUPPORTED;
+		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
+		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
+			return;
 	}
-	return 0;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_msr_common);
 
-/*
- * Read or write a bunch of msrs. All parameters are kernel addresses.
- *
- * @return number of msrs set successfully.
- */
-static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
-		    struct kvm_msr_entry *entries,
-		    int (*do_msr)(struct kvm_vcpu *vcpu,
-				  unsigned index, u64 *data))
-{
-	bool fpu_loaded = false;
-	int i;
+	st = (struct kvm_steal_time __user *)ghc->hva;
+	/*
+	 * Doing a TLB flush here, on the guest's behalf, can avoid
+	 * expensive IPIs.
+	 */
+	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
+		u8 st_preempted = 0;
+		int err = -EFAULT;
 
-	for (i = 0; i < msrs->nmsrs; ++i) {
-		/*
-		 * If userspace is accessing one or more XSTATE-managed MSRs,
-		 * temporarily load the guest's FPU state so that the guest's
-		 * MSR value(s) is resident in hardware and thus can be accessed
-		 * via RDMSR/WRMSR.
-		 */
-		if (!fpu_loaded && is_xstate_managed_msr(vcpu, entries[i].index)) {
-			kvm_load_guest_fpu(vcpu);
-			fpu_loaded = true;
-		}
-		if (do_msr(vcpu, entries[i].index, &entries[i].data))
-			break;
-	}
-	if (fpu_loaded)
-		kvm_put_guest_fpu(vcpu);
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
 
-	return i;
-}
+		asm volatile("1: xchgb %0, %2\n"
+			     "xor %1, %1\n"
+			     "2:\n"
+			     _ASM_EXTABLE_UA(1b, 2b)
+			     : "+q" (st_preempted),
+			       "+&r" (err),
+			       "+m" (st->preempted));
+		if (err)
+			goto out;
 
-/*
- * Read or write a bunch of msrs. Parameters are user addresses.
- *
- * @return number of msrs set successfully.
- */
-static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
-		  int (*do_msr)(struct kvm_vcpu *vcpu,
-				unsigned index, u64 *data),
-		  int writeback)
-{
-	struct kvm_msrs msrs;
-	struct kvm_msr_entry *entries;
-	unsigned size;
-	int r;
+		user_access_end();
 
-	r = -EFAULT;
-	if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))
-		goto out;
+		vcpu->arch.st.preempted = 0;
 
-	r = -E2BIG;
-	if (msrs.nmsrs >= MAX_IO_MSRS)
-		goto out;
+		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
+				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		if (st_preempted & KVM_VCPU_FLUSH_TLB)
+			kvm_vcpu_flush_tlb_guest(vcpu);
 
-	size = sizeof(struct kvm_msr_entry) * msrs.nmsrs;
-	entries = memdup_user(user_msrs->entries, size);
-	if (IS_ERR(entries)) {
-		r = PTR_ERR(entries);
-		goto out;
+		if (!user_access_begin(st, sizeof(*st)))
+			goto dirty;
+	} else {
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
+
+		unsafe_put_user(0, &st->preempted, out);
+		vcpu->arch.st.preempted = 0;
 	}
 
-	r = __msr_io(vcpu, &msrs, entries, do_msr);
+	unsafe_get_user(version, &st->version, out);
+	if (version & 1)
+		version += 1;  /* first time write, random junk */
 
-	if (writeback && copy_to_user(user_msrs->entries, entries, size))
-		r = -EFAULT;
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
 
-	kfree(entries);
-out:
-	return r;
+	smp_wmb();
+
+	unsafe_get_user(steal, &st->steal, out);
+	steal += current->sched_info.run_delay -
+		vcpu->arch.st.last_steal;
+	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	unsafe_put_user(steal, &st->steal, out);
+
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
+
+ out:
+	user_access_end();
+ dirty:
+	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
 static inline bool kvm_can_mwait_in_guest(void)
@@ -4971,88 +2787,33 @@ static int __kvm_x86_dev_get_attr(struct kvm_device_attr *attr, u64 *val)
 	switch (attr->attr) {
 	case KVM_X86_XCOMP_GUEST_SUPP:
 		*val = kvm_caps.supported_xcr0;
-		return 0;
-	default:
-		return -ENXIO;
-	}
-}
-
-static int kvm_x86_dev_get_attr(struct kvm_device_attr *attr)
-{
-	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
-	int r;
-	u64 val;
-
-	r = __kvm_x86_dev_get_attr(attr, &val);
-	if (r < 0)
-		return r;
-
-	if (put_user(val, uaddr))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
-{
-	u64 val;
-
-	return __kvm_x86_dev_get_attr(attr, &val);
-}
-
-static int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list)
-{
-	struct kvm_msr_list msr_list;
-	unsigned int n;
-
-	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-		return -EFAULT;
-
-	n = msr_list.nmsrs;
-	msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
-	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-		return -EFAULT;
-
-	if (n < msr_list.nmsrs)
-		return -E2BIG;
-
-	if (copy_to_user(user_msr_list->indices, &msrs_to_save,
-			 num_msrs_to_save * sizeof(u32)))
-		return -EFAULT;
-
-	if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
-			 &emulated_msrs, num_emulated_msrs * sizeof(u32)))
-		return -EFAULT;
-
-	return 0;
+		return 0;
+	default:
+		return -ENXIO;
+	}
 }
 
-static int kvm_get_feature_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+static int kvm_x86_dev_get_attr(struct kvm_device_attr *attr)
 {
-	struct kvm_msr_list msr_list;
-	unsigned int n;
-
-	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-		return -EFAULT;
-
-	n = msr_list.nmsrs;
-	msr_list.nmsrs = num_msr_based_features;
-	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-		return -EFAULT;
+	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
+	int r;
+	u64 val;
 
-	if (n < msr_list.nmsrs)
-		return -E2BIG;
+	r = __kvm_x86_dev_get_attr(attr, &val);
+	if (r < 0)
+		return r;
 
-	if (copy_to_user(user_msr_list->indices, &msr_based_features,
-			 num_msr_based_features * sizeof(u32)))
+	if (put_user(val, uaddr))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int kvm_get_feature_msrs(struct kvm_msrs __user *user_msrs)
+static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
 {
-	return msr_io(NULL, user_msrs, do_get_feature_msr, 1);
+	u64 val;
+
+	return __kvm_x86_dev_get_attr(attr, &val);
 }
 
 long kvm_arch_dev_ioctl(struct file *filp,
@@ -6052,148 +3813,6 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	}
 }
 
-struct kvm_x86_reg_id {
-	__u32 index;
-	__u8  type;
-	__u8  rsvd1;
-	__u8  rsvd2:4;
-	__u8  size:4;
-	__u8  x86;
-};
-
-static int kvm_translate_kvm_reg(struct kvm_vcpu *vcpu,
-				 struct kvm_x86_reg_id *reg)
-{
-	switch (reg->index) {
-	case KVM_REG_GUEST_SSP:
-		/*
-		 * FIXME: If host-initiated accesses are ever exempted from
-		 * ignore_msrs (in kvm_do_msr_access()), drop this manual check
-		 * and rely on KVM's standard checks to reject accesses to regs
-		 * that don't exist.
-		 */
-		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
-			return -EINVAL;
-
-		reg->type = KVM_X86_REG_TYPE_MSR;
-		reg->index = MSR_KVM_INTERNAL_GUEST_SSP;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static int kvm_get_one_msr(struct kvm_vcpu *vcpu, u32 msr, u64 __user *user_val)
-{
-	u64 val;
-
-	if (do_get_msr(vcpu, msr, &val))
-		return -EINVAL;
-
-	if (put_user(val, user_val))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int kvm_set_one_msr(struct kvm_vcpu *vcpu, u32 msr, u64 __user *user_val)
-{
-	u64 val;
-
-	if (get_user(val, user_val))
-		return -EFAULT;
-
-	if (do_set_msr(vcpu, msr, &val))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
-			       void __user *argp)
-{
-	struct kvm_one_reg one_reg;
-	struct kvm_x86_reg_id *reg;
-	u64 __user *user_val;
-	bool load_fpu;
-	int r;
-
-	if (copy_from_user(&one_reg, argp, sizeof(one_reg)))
-		return -EFAULT;
-
-	if ((one_reg.id & KVM_REG_ARCH_MASK) != KVM_REG_X86)
-		return -EINVAL;
-
-	reg = (struct kvm_x86_reg_id *)&one_reg.id;
-	if (reg->rsvd1 || reg->rsvd2)
-		return -EINVAL;
-
-	if (reg->type == KVM_X86_REG_TYPE_KVM) {
-		r = kvm_translate_kvm_reg(vcpu, reg);
-		if (r)
-			return r;
-	}
-
-	if (reg->type != KVM_X86_REG_TYPE_MSR)
-		return -EINVAL;
-
-	if ((one_reg.id & KVM_REG_SIZE_MASK) != KVM_REG_SIZE_U64)
-		return -EINVAL;
-
-	guard(srcu)(&vcpu->kvm->srcu);
-
-	load_fpu = is_xstate_managed_msr(vcpu, reg->index);
-	if (load_fpu)
-		kvm_load_guest_fpu(vcpu);
-
-	user_val = u64_to_user_ptr(one_reg.addr);
-	if (ioctl == KVM_GET_ONE_REG)
-		r = kvm_get_one_msr(vcpu, reg->index, user_val);
-	else
-		r = kvm_set_one_msr(vcpu, reg->index, user_val);
-
-	if (load_fpu)
-		kvm_put_guest_fpu(vcpu);
-	return r;
-}
-
-static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
-			    struct kvm_reg_list __user *user_list)
-{
-	u64 nr_regs = guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ? 1 : 0;
-	u64 user_nr_regs;
-
-	if (get_user(user_nr_regs, &user_list->n))
-		return -EFAULT;
-
-	if (put_user(nr_regs, &user_list->n))
-		return -EFAULT;
-
-	if (user_nr_regs < nr_regs)
-		return -E2BIG;
-
-	if (nr_regs &&
-	    put_user(KVM_X86_REG_KVM(KVM_REG_GUEST_SSP), &user_list->reg[0]))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int kvm_get_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
-{
-	guard(srcu)(&vcpu->kvm->srcu);
-
-	return msr_io(vcpu, user_msrs, do_get_msr, 1);
-}
-
-static int kvm_set_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
-{
-	guard(srcu)(&vcpu->kvm->srcu);
-
-	return msr_io(vcpu, user_msrs, do_set_msr, 0);
-}
-
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -6996,113 +4615,6 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	return r;
 }
 
-static struct kvm_x86_msr_filter *kvm_alloc_msr_filter(bool default_allow)
-{
-	struct kvm_x86_msr_filter *msr_filter;
-
-	msr_filter = kzalloc_obj(*msr_filter, GFP_KERNEL_ACCOUNT);
-	if (!msr_filter)
-		return NULL;
-
-	msr_filter->default_allow = default_allow;
-	return msr_filter;
-}
-
-static void kvm_free_msr_filter(struct kvm_x86_msr_filter *msr_filter)
-{
-	u32 i;
-
-	if (!msr_filter)
-		return;
-
-	for (i = 0; i < msr_filter->count; i++)
-		kfree(msr_filter->ranges[i].bitmap);
-
-	kfree(msr_filter);
-}
-
-static int kvm_add_msr_filter(struct kvm_x86_msr_filter *msr_filter,
-			      struct kvm_msr_filter_range *user_range)
-{
-	unsigned long *bitmap;
-	size_t bitmap_size;
-
-	if (!user_range->nmsrs)
-		return 0;
-
-	if (user_range->flags & ~KVM_MSR_FILTER_RANGE_VALID_MASK)
-		return -EINVAL;
-
-	if (!user_range->flags)
-		return -EINVAL;
-
-	bitmap_size = BITS_TO_LONGS(user_range->nmsrs) * sizeof(long);
-	if (!bitmap_size || bitmap_size > KVM_MSR_FILTER_MAX_BITMAP_SIZE)
-		return -EINVAL;
-
-	bitmap = memdup_user((__user u8*)user_range->bitmap, bitmap_size);
-	if (IS_ERR(bitmap))
-		return PTR_ERR(bitmap);
-
-	msr_filter->ranges[msr_filter->count] = (struct msr_bitmap_range) {
-		.flags = user_range->flags,
-		.base = user_range->base,
-		.nmsrs = user_range->nmsrs,
-		.bitmap = bitmap,
-	};
-
-	msr_filter->count++;
-	return 0;
-}
-
-static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm,
-				       struct kvm_msr_filter *filter)
-{
-	struct kvm_x86_msr_filter *new_filter, *old_filter;
-	bool default_allow;
-	bool empty = true;
-	int r;
-	u32 i;
-
-	if (filter->flags & ~KVM_MSR_FILTER_VALID_MASK)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(filter->ranges); i++)
-		empty &= !filter->ranges[i].nmsrs;
-
-	default_allow = !(filter->flags & KVM_MSR_FILTER_DEFAULT_DENY);
-	if (empty && !default_allow)
-		return -EINVAL;
-
-	new_filter = kvm_alloc_msr_filter(default_allow);
-	if (!new_filter)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(filter->ranges); i++) {
-		r = kvm_add_msr_filter(new_filter, &filter->ranges[i]);
-		if (r) {
-			kvm_free_msr_filter(new_filter);
-			return r;
-		}
-	}
-
-	mutex_lock(&kvm->lock);
-	old_filter = rcu_replace_pointer(kvm->arch.msr_filter, new_filter,
-					 mutex_is_locked(&kvm->lock));
-	mutex_unlock(&kvm->lock);
-	synchronize_srcu(&kvm->srcu);
-
-	kvm_free_msr_filter(old_filter);
-
-	/*
-	 * Recalc MSR intercepts as userspace may want to intercept accesses to
-	 * MSRs that KVM would otherwise pass through to the guest.
-	 */
-	kvm_make_all_cpus_request(kvm, KVM_REQ_RECALC_INTERCEPTS);
-
-	return 0;
-}
-
 #ifdef CONFIG_KVM_COMPAT
 /* for KVM_X86_SET_MSR_FILTER */
 struct kvm_msr_filter_range_compat {
@@ -7623,157 +5135,6 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return r;
 }
 
-static void kvm_probe_feature_msr(u32 msr_index)
-{
-	u64 data;
-
-	if (kvm_get_feature_msr(NULL, msr_index, &data, true))
-		return;
-
-	msr_based_features[num_msr_based_features++] = msr_index;
-}
-
-static void kvm_probe_msr_to_save(u32 msr_index)
-{
-	u32 dummy[2];
-
-	if (rdmsr_safe(msr_index, &dummy[0], &dummy[1]))
-		return;
-
-	/*
-	 * Even MSRs that are valid in the host may not be exposed to guests in
-	 * some cases.
-	 */
-	switch (msr_index) {
-	case MSR_IA32_BNDCFGS:
-		if (!kvm_mpx_supported())
-			return;
-		break;
-	case MSR_TSC_AUX:
-		if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP) &&
-		    !kvm_cpu_cap_has(X86_FEATURE_RDPID))
-			return;
-		break;
-	case MSR_IA32_UMWAIT_CONTROL:
-		if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
-			return;
-		break;
-	case MSR_IA32_RTIT_CTL:
-	case MSR_IA32_RTIT_STATUS:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
-			return;
-		break;
-	case MSR_IA32_RTIT_CR3_MATCH:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
-		    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
-			return;
-		break;
-	case MSR_IA32_RTIT_OUTPUT_BASE:
-	case MSR_IA32_RTIT_OUTPUT_MASK:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
-		    (!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
-		     !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
-			return;
-		break;
-	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
-		    (msr_index - MSR_IA32_RTIT_ADDR0_A >=
-		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
-			return;
-		break;
-	case MSR_ARCH_PERFMON_PERFCTR0 ...
-	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
-		    kvm_pmu_cap.num_counters_gp)
-			return;
-		break;
-	case MSR_ARCH_PERFMON_EVENTSEL0 ...
-	     MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
-		    kvm_pmu_cap.num_counters_gp)
-			return;
-		break;
-	case MSR_ARCH_PERFMON_FIXED_CTR0 ...
-	     MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
-		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
-		    kvm_pmu_cap.num_counters_fixed)
-			return;
-		break;
-	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
-	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
-	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
-	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
-		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
-			return;
-		break;
-	case MSR_IA32_XFD:
-	case MSR_IA32_XFD_ERR:
-		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
-			return;
-		break;
-	case MSR_IA32_TSX_CTRL:
-		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
-			return;
-		break;
-	case MSR_IA32_XSS:
-		if (!kvm_caps.supported_xss)
-			return;
-		break;
-	case MSR_IA32_U_CET:
-	case MSR_IA32_S_CET:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
-		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
-			return;
-		break;
-	case MSR_IA32_INT_SSP_TAB:
-		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
-			return;
-		fallthrough;
-	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
-			return;
-		break;
-	default:
-		break;
-	}
-
-	msrs_to_save[num_msrs_to_save++] = msr_index;
-}
-
-static void kvm_init_msr_lists(void)
-{
-	unsigned i;
-
-	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
-			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
-
-	num_msrs_to_save = 0;
-	num_emulated_msrs = 0;
-	num_msr_based_features = 0;
-
-	for (i = 0; i < ARRAY_SIZE(msrs_to_save_base); i++)
-		kvm_probe_msr_to_save(msrs_to_save_base[i]);
-
-	if (enable_pmu) {
-		for (i = 0; i < ARRAY_SIZE(msrs_to_save_pmu); i++)
-			kvm_probe_msr_to_save(msrs_to_save_pmu[i]);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(emulated_msrs_all); i++) {
-		if (!kvm_x86_call(has_emulated_msr)(NULL,
-						    emulated_msrs_all[i]))
-			continue;
-
-		emulated_msrs[num_emulated_msrs++] = emulated_msrs_all[i];
-	}
-
-	for (i = KVM_FIRST_EMULATED_VMX_MSR; i <= KVM_LAST_EMULATED_VMX_MSR; i++)
-		kvm_probe_feature_msr(i);
-
-	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++)
-		kvm_probe_feature_msr(msr_based_features_all_except_vmx[i]);
-}
-
 static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
 			   void *__v)
 {
@@ -8716,61 +6077,22 @@ static int emulator_get_msr_with_filter(struct x86_emulate_ctxt *ctxt,
 					u32 msr_index, u64 *pdata)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	int r;
-
-	r = kvm_emulate_msr_read(vcpu, msr_index, pdata);
-	if (r < 0)
-		return X86EMUL_UNHANDLEABLE;
 
-	if (r) {
-		if (kvm_msr_user_space(vcpu, msr_index, KVM_EXIT_X86_RDMSR, 0,
-				       complete_emulated_rdmsr, r))
-			return X86EMUL_IO_NEEDED;
-
-		trace_kvm_msr_read_ex(msr_index);
-		return X86EMUL_PROPAGATE_FAULT;
-	}
-
-	trace_kvm_msr_read(msr_index, *pdata);
-	return X86EMUL_CONTINUE;
+	return kvm_emulator_get_msr_with_filter(vcpu, msr_index, pdata);
 }
 
 static int emulator_set_msr_with_filter(struct x86_emulate_ctxt *ctxt,
 					u32 msr_index, u64 data)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	int r;
-
-	r = kvm_emulate_msr_write(vcpu, msr_index, data);
-	if (r < 0)
-		return X86EMUL_UNHANDLEABLE;
-
-	if (r) {
-		if (kvm_msr_user_space(vcpu, msr_index, KVM_EXIT_X86_WRMSR, data,
-				       complete_emulated_msr_access, r))
-			return X86EMUL_IO_NEEDED;
-
-		trace_kvm_msr_write_ex(msr_index, data);
-		return X86EMUL_PROPAGATE_FAULT;
-	}
 
-	trace_kvm_msr_write(msr_index, data);
-	return X86EMUL_CONTINUE;
+	return kvm_emulator_set_msr_with_filter(vcpu, msr_index, data);
 }
 
 static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
 			    u32 msr_index, u64 *pdata)
 {
-	/*
-	 * Treat emulator accesses to the current shadow stack pointer as host-
-	 * initiated, as they aren't true MSR accesses (SSP is a "just a reg"),
-	 * and this API is used only for implicit accesses, i.e. not RDMSR, and
-	 * so the index is fully KVM-controlled.
-	 */
-	if (unlikely(msr_index == MSR_KVM_INTERNAL_GUEST_SSP))
-		return kvm_msr_read(emul_to_vcpu(ctxt), msr_index, pdata);
-
-	return __kvm_emulate_msr_read(emul_to_vcpu(ctxt), msr_index, pdata);
+	return kvm_emulator_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
 }
 
 static int emulator_check_rdpmc_early(struct x86_emulate_ctxt *ctxt, u32 pmc)
@@ -14127,32 +11449,6 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 #endif
 #endif
 
-int kvm_spec_ctrl_test_value(u64 value)
-{
-	/*
-	 * test that setting IA32_SPEC_CTRL to given value
-	 * is allowed by the host processor
-	 */
-
-	u64 saved_value;
-	unsigned long flags;
-	int ret = 0;
-
-	local_irq_save(flags);
-
-	if (rdmsrq_safe(MSR_IA32_SPEC_CTRL, &saved_value))
-		ret = 1;
-	else if (wrmsrq_safe(MSR_IA32_SPEC_CTRL, value))
-		ret = 1;
-	else
-		wrmsrq(MSR_IA32_SPEC_CTRL, saved_value);
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_spec_ctrl_test_value);
-
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
 	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index fe6ecd1efdb14..aab5542d3b9e1 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -6,6 +6,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/mce.h>
 #include <asm/pvclock.h>
+#include "msrs.h"
 #include "mmu.h"
 #include "regs.h"
 #include "kvm_emulate.h"
@@ -45,14 +46,6 @@ do {											\
 	failed;								\
 })
 
-/*
- * The first...last VMX feature MSRs that are emulated by KVM.  This may or may
- * not cover all known VMX MSRs, as KVM doesn't emulate an MSR until there's an
- * associated feature that KVM supports for nested virtualization.
- */
-#define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
-#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
-
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW	2
@@ -61,16 +54,6 @@ do {											\
 #define KVM_SVM_DEFAULT_PLE_WINDOW_MAX	USHRT_MAX
 #define KVM_SVM_DEFAULT_PLE_WINDOW	3000
 
-/*
- * KVM's internal, non-ABI indices for synthetic MSRs. The values themselves
- * are arbitrary and have no meaning, the only requirement is that they don't
- * conflict with "real" MSRs that KVM supports. Use values at the upper end
- * of KVM's reserved paravirtual MSR range to minimize churn, i.e. these values
- * will be usable until KVM exhausts its supply of paravirtual MSR indices.
- */
-
-#define MSR_KVM_INTERNAL_GUEST_SSP	0x4b564dff
-
 static inline unsigned int __grow_ple_window(unsigned int val,
 		unsigned int base, unsigned int modifier, unsigned int max)
 {
@@ -101,9 +84,6 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
 	return max(val, min);
 }
 
-#define MSR_IA32_CR_PAT_DEFAULT	\
-	PAT_VALUE(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC)
-
 void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
 int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 
@@ -377,15 +357,12 @@ int handle_ud(struct kvm_vcpu *vcpu);
 void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 				   struct kvm_queued_exception *ex);
 
-int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data);
-int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code);
 int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 				    void *insn, int insn_len);
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len);
-fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
-fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
+
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
@@ -431,20 +408,6 @@ extern bool enable_vmware_backdoor;
 
 extern int pi_inject_timer;
 
-extern bool report_ignored_msrs;
-
-static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
-{
-	if (report_ignored_msrs)
-		vcpu_unimpl(vcpu, "Unhandled WRMSR(0x%x) = 0x%llx\n", msr, data);
-}
-
-static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
-{
-	if (report_ignored_msrs)
-		vcpu_unimpl(vcpu, "Unhandled RDMSR(0x%x)\n", msr);
-}
-
 static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
 {
 	return pvclock_scale_delta(nsec, vcpu->arch.virtual_tsc_mult,
@@ -562,32 +525,9 @@ static inline void kvm_machine_check(void)
 #endif
 }
 
-int kvm_spec_ctrl_test_value(u64 value);
 int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 			      struct x86_exception *e);
 int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva);
-bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type);
-
-enum kvm_msr_access {
-	MSR_TYPE_R	= BIT(0),
-	MSR_TYPE_W	= BIT(1),
-	MSR_TYPE_RW	= MSR_TYPE_R | MSR_TYPE_W,
-};
-
-/*
- * Internal error codes that are used to indicate that MSR emulation encountered
- * an error that should result in #GP in the guest, unless userspace handles it.
- * Note, '1', '0', and negative numbers are off limits, as they are used by KVM
- * as part of KVM's lightly documented internal KVM_RUN return codes.
- *
- * UNSUPPORTED	- The MSR isn't supported, either because it is completely
- *		  unknown to KVM, or because the MSR should not exist according
- *		  to the vCPU model.
- *
- * FILTERED	- Access to the MSR is denied by a userspace MSR filter.
- */
-#define  KVM_MSR_RET_UNSUPPORTED	2
-#define  KVM_MSR_RET_FILTERED		3
 
 int kvm_sev_es_mmio(struct kvm_vcpu *vcpu, bool is_write, gpa_t gpa,
 		    unsigned int bytes, void *data);
@@ -647,27 +587,4 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
-#define CET_US_RESERVED_BITS		GENMASK(9, 6)
-#define CET_US_SHSTK_MASK_BITS		GENMASK(1, 0)
-#define CET_US_IBT_MASK_BITS		(GENMASK_ULL(5, 2) | GENMASK_ULL(63, 10))
-#define CET_US_LEGACY_BITMAP_BASE(data)	((data) >> 12)
-
-static inline bool kvm_is_valid_u_s_cet(struct kvm_vcpu *vcpu, u64 data)
-{
-	if (data & CET_US_RESERVED_BITS)
-		return false;
-	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
-	    (data & CET_US_SHSTK_MASK_BITS))
-		return false;
-	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
-	    (data & CET_US_IBT_MASK_BITS))
-		return false;
-	if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
-		return false;
-	/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
-	if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
-		return false;
-
-	return true;
-}
 #endif
-- 
2.53.0


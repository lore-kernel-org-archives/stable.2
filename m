Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40F3563E8;
	Tue, 14 Jul 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991515; cv=none; b=en+QisTE0qpvCtkt47g1j7O+44x4/DCW1ZFTBjyLRNlyxkjM96koLuCZGoBVf7FlzEyiiPWclVxS3ZdxI3RB0+Si1tYe31P58rMBDfHJ2EN0iF2DEz0K9Mn6LTmYQOHzsLQOkNwdHuCYLAfqN44GmZ1Wb+e3VF962iTQ0JQat5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991515; c=relaxed/simple;
	bh=1I9xKo+B0sPJiU3VMq7qLztBdA3pEoXC6/9r7kuahrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4FCEPSNVVhpk+jM5g65vDzZbm16IYlzh+5tG9csMcxCJfTxNPjlGKr8Ir6JkV1byvPcF1OTYLV1UEuo+lGsgkozpW0GKx5p7hS5a53d6V6Qu77sPBVdqXunNsoV6WwZ8PFwGzZvSDhoI9vkARNzNh1hN/2ejONeGb/U/V8jZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA2M+0/E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA2M+0/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991514; x=1815527514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1I9xKo+B0sPJiU3VMq7qLztBdA3pEoXC6/9r7kuahrM=;
  b=AA2M+0/Ep4lBvzS2O4sDz2ZhLEac2zCqVSlNGOpZbbZNeKKbw6imH46z
   PySJ7nSRXekAT4XGCmFYjFJBh1/s0TM7mtJguAbxWjdnDQUP8uQsLE+91
   5Vl/BE/rpGmEbrEoB4tl/8AA6vNhlqAOd/Iip0KUnVV2zI2Kz3Jiy73np
   jWGFfRuCCoHBcdsbLoR7pcetsmOHihehksIz9q/AM7WiP6BWPwHndIjjy
   hjGvBYWqDDTO5y/0utXdjERVmKtRjvN4mObHFhgv3sVP/zPvrydx0RsXE
   YpnzYhvjSjmvrb75Lvuzb8Cy0ElhEFw6bFU5zQqRxxdVgNE6KCyaxtDf3
   g==;
X-CSE-ConnectionGUID: 2/RflV3/QwWkwxXi886pMg==
X-CSE-MsgGUID: Bt3wCqyiT1uyqL95HYXYfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95212060"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95212060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:53 -0700
X-CSE-ConnectionGUID: 3QPxLhxNShOFmCGenOKkFg==
X-CSE-MsgGUID: BF1KqhFSQnWIVMQXZNu5Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255212631"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:53 -0700
Date: Mon, 13 Jul 2026 18:11:52 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.18.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT allocation
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-2-755f60c55705@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>

commit a3af84b0fa00ead01fcd0e28b5d773ff25990a0d upstream.

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

This hardening applies only when BPF-JIT is in use. Guard the enabling
under CONFIG_BPF_JIT so that bugs.c still builds with CONFIG_BPF_JIT=n.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 ++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 08ed5a2e46a5..71e9861a16a8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -386,6 +386,10 @@ extern void srso_alias_return_thunk(void);
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
index d7fa03bf51b4..fd0b7880cf7e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -1796,8 +1797,21 @@ static inline const char *spectre_v2_module_string(void)
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
@@ -2240,8 +2254,7 @@ static void __init bhi_apply_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2383,6 +2396,27 @@ static void __init spectre_v2_update_mitigation(void)
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
@@ -2459,6 +2493,14 @@ static void __init spectre_v2_apply_mitigation(void)
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
@@ -3544,9 +3586,7 @@ static const char *spectre_bhi_state(void)
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

-- 
2.43.0



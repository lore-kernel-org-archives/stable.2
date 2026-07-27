Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57642CAE4;
	Mon, 27 Jul 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192958; cv=none; b=ubyYiWSqIO73ZyXf7PQYLte1Q6f1OK6nwKE1fMggoBYgstZK1Gc1dkUfwUtXNpbjC5MTrnchs5d/aQ+mNXsBfPVMEgcgre46avhNiyKO2rA/W1I+spE5LkzzVMtvTMimZ1Ce/TVOaBgNE4HCB0sRAtGQFWQtWQ67BefwU8vLNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192958; c=relaxed/simple;
	bh=4+wSuBjD+7eL3D5Q94LrjE5+riuANpFumC772DnL1XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd8GlLkBP+gKBpUhAujRqLAaN2A035L3SS9eaRSt1fv55sJg5n/YS2v2yT56AqaICsGhbSCVQBin/GHi0j9xei2QNsjp4A+ReGv4ITD07EODL8BwegS0cTJjZMvkD4G8svHgu5MJUwfQqghi+mV8av3ho18sHUfXz2/0U4tQDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7BF4sMo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7BF4sMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785192958; x=1816728958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+wSuBjD+7eL3D5Q94LrjE5+riuANpFumC772DnL1XY=;
  b=U7BF4sMo5zs0FjXFTDD+SFhI3ErJMCk0UgNFtzT+i/86t22la3VCdC1o
   s5kBywdl37q6LISYfeZYDIbEZ5qxHouLVvB+rW4t+6oLLaGmGwtPJSIMK
   IgPTzZEjG3rX6DvgWTCMi9ivEBBvLfSrhLz3jSk/AxQ8BN3i9NVP8MeBI
   3wkOj2cjMsXdmHu/CKjiu0/Zz4USotL9+7eWL47kM/SNtjU/+BXfw9FAL
   eJSWfRnysDnRK2jjZyM5+dCanhitOTTEisAklMeT8Op0xCVy4af0ZMeJ9
   eN/1ft5xbmMu0ElD1SzE/wNZJz043EAXrW31SLHIxsWa7AunuiZUpJW8E
   Q==;
X-CSE-ConnectionGUID: JDDT9l0kTQ+jBqwRRV99iw==
X-CSE-MsgGUID: iJYZX9FJTpWEykJGgfeqhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="88309447"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="88309447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:57 -0700
X-CSE-ConnectionGUID: ysLY9BcvTmWCsrz8YpHc2Q==
X-CSE-MsgGUID: MvbdNkp0SWKYw2Rk1nDBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="259594440"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:55:57 -0700
Date: Mon, 27 Jul 2026 15:55:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, x86@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT allocation
Message-ID: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-2-eb80dcf1eb6e@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>

commit a3af84b0fa00ead01fcd0e28b5d773ff25990a0d upstream.

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

This hardening applies only when BPF-JIT is in use. Guard the enabling
under CONFIG_BPF_JIT so that bugs.c still builds with CONFIG_BPF_JIT=n.

  [ pawan: Use entry_ibpb() instead of write_ibpb(). JIT hardening enable
	   moved to spectre_v2_select_mitigation() because there is no
	   spectre_v2_apply_mitigation()]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 ++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 818a5913f219..40842aabd217 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -280,6 +280,10 @@ extern void srso_alias_untrain_ret(void);
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
+#ifdef CONFIG_BPF_JIT
+extern void bpf_arch_ibpb(void);
+#endif
+
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a0b362ac50a1..662d13612ef4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -1298,8 +1299,21 @@ static inline const char *spectre_v2_module_string(void)
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
@@ -1780,8 +1794,7 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -1803,6 +1816,27 @@ static void __init bhi_select_mitigation(void)
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
 }
 
+#ifdef CONFIG_BPF_JIT
+static void __bpf_arch_ibpb(void *unused)
+{
+	entry_ibpb();
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
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -1985,6 +2019,14 @@ static void __init spectre_v2_select_mitigation(void)
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
 
+#ifdef CONFIG_BPF_JIT
+	if (cpu_wants_ibpb_bpf()) {
+		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
+		static_branch_enable(&bpf_pred_flush_enabled);
+		pr_info("Enabling IBPB for BPF\n");
+	}
+#endif
+
 	/* Set up IBPB and STIBP depending on the general spectre V2 command */
 	spectre_v2_cmd = cmd;
 }
@@ -3157,9 +3199,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
-		 rrsba_disabled)
+	else if (retpoline_seq_enabled() && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";

-- 
2.43.0



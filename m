Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FD4446E6;
	Tue, 14 Jul 2026 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055538; cv=none; b=XpClG0uvIarKkD1QCSwBJwMtIY+iU/XWxZOZHsb03f8FKaqhH3K9dUp120GnhoQJ+K0jFKAaSiikTTc2P49uV0V4T63KxHZn8G2rPxLkB46XnVzSekShp39PSIOi98UyiPvD0JSn4fDu/kJwPJPJ498FzA/WdndFa9DlcCHG0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055538; c=relaxed/simple;
	bh=308lxv/LdGOA4mzg6tIBL5HGLe1XbEhrU2sCM8nxSUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDiJF+QJ10QPBoLZ6UqjnvixkI73Y2RUDxKLDSddm/Br5fv5Am1rjrQDkIZXh5ioxgayjfvkN9H3PhcbDroWjRk6sDLOcZUl0IObnh89Ywmtzc9nr4bQZ8+bqijaT66gWEeyfsnM1nsE/gfiAI9ZtxRzxyrrkKMXOohc6/mgYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2ceoevt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2ceoevt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055536; x=1815591536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=308lxv/LdGOA4mzg6tIBL5HGLe1XbEhrU2sCM8nxSUY=;
  b=P2ceoevt+trlTrbbUtIeOC/QJCd0R66vVFujePRE/BKbafYSdYEVpaTo
   saHp9pH+0+50Fw+DLzdz7y6GpnxEkpG4HNnf9rU7a8z3Y5uAyKT7BEEmm
   KaiVjlu41hVhxJSLD5iv7Nh0wgHfTKoi+ZLhdftL8va6Km4Ol/xZRxTDD
   CtPj+6dWMQgQy0NSy72CBj9+H0QTdXiAxJTIepzbImf12cWbVIjnVyWIL
   4vPTzgjk1g9zTwsNTsZ7phgOeXUkM1LJTUrFrjAaAKxz02V9AWwx5R4qc
   3+jVOxiE/W/s5/oXyiyHc4fUJmgDnrj3A7vbP6uVuxkR6Me9A6nr9oYzu
   Q==;
X-CSE-ConnectionGUID: sGltpvztTx6/6K5XG81eJw==
X-CSE-MsgGUID: IUUFV1WhTgGUZaD6D2dV6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102241274"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102241274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:56 -0700
X-CSE-ConnectionGUID: kIKJW1PRT9eZ8/0fvn870A==
X-CSE-MsgGUID: r+lIuXvDQhirwqnXIeKzNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279224851"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:55 -0700
Date: Tue, 14 Jul 2026 11:58:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.16.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT allocation
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-2-2fc3e16263ac@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>

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
index e29f82466f43..0c95f6ac5c99 100644
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
index 65e253ef5218..512d58d6040c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -1625,8 +1626,21 @@ static inline const char *spectre_v2_module_string(void)
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
@@ -2138,8 +2152,7 @@ static void __init bhi_apply_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2234,6 +2247,27 @@ static void __init spectre_v2_update_mitigation(void)
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
@@ -2310,6 +2344,14 @@ static void __init spectre_v2_apply_mitigation(void)
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
@@ -3421,9 +3463,7 @@ static const char *spectre_bhi_state(void)
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



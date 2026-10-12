Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E73B5303
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804962; cv=none; b=Y+ZDoyb0mgiTCfJSIRmMS+Gdu8C1Klo5fgqRBEeK7UHMWzNToxmDUKUl8UxxsYrkPyhSN62o9BWme0N21PKg1Xc0ACERqvCjQL/9MU7gy3C27K5jtIt58ne6kQi9tgBCcTKd39lmvZXN/tEBWiuAX1xl1uvLulQLIHQdZaa5R+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804962; c=relaxed/simple;
	bh=LS809FKnZxGRcBmfeFy+sqZsFM+wBdW8fm10C4ndVK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oFIJ6Rrq3KTHZr0Brf3vsmJmCrsdtmR0Ue+o5r0eSBbtW5ywg0M/cW2kkTsWjN6nwZ2kVS1wWyZQjHei5BMkpeq0Ftad147KGC1gyBOA8NvDb0qNI3wIfdEff901dZWEVvpLxodvpuq66hGpX+TjJgqd63GA9qQrT7/bvuebG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwhSq68d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwhSq68d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52F1F0089B;
	Mon, 12 Oct 2026 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791804961;
	bh=6uOjdkPsQ/gA/DlyA9sNG02Rdo4dC57oG6NwWfreDIQ=;
	h=Subject:To:Cc:From:Date;
	b=xwhSq68dhZp+JQ33mt0azv+zt9v7JqucyZklt9ueOnt74BKWYqxuf7RNNtzmxomKn
	 v4W4rdG32TAvfg7ypvRMGTUBch87P0KaN7GjtaULwnTmkMnvPUM7E7YW45MKMIkzug
	 QVZ5fmEjNYX79M/SeWDs0joPilq/wSZYjz99GwjE=
Subject: FAILED: patch "[PATCH] x86/CPU/AMD: Fix AMD TLBI Erratum #1718" failed to apply to 6.18-stable tree
To: bp@alien8.de,ljs@kernel.org,riel@surriel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:36:06 +0200
Message-ID: <2026101206-disparity-thrive-6c91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 87db7795cbaaf636ae22ae031f4906db7bb77803
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101206-disparity-thrive-6c91@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87db7795cbaaf636ae22ae031f4906db7bb77803 Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 2 Oct 2026 14:16:17 -0700
Subject: [PATCH] x86/CPU/AMD: Fix AMD TLBI Erratum #1718

The processor may fail to invalidate a TLB entry while executing an
INVLPGB/TLBSYNC instruction pair.

Detect the erratum and apply a software workaround when a microcode fix
is not present.

Fixes: 82378c6c2f43 ("x86/mm: Use INVLPGB for kernel TLB flushes")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Rik van Riel <riel@surriel.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20261002211617.1001617-1-bp@kernel.org

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f70ee74b5f92..fe84cf4e97d3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -477,6 +477,8 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+
+#define X86_FEATURE_TLBSYNC_SFW_NO	(20*32+ 4) /* TLBI Erratum #1718 fixed in microcode */
 #define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
 
@@ -587,4 +589,5 @@
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET from P-SEAMLDR clears the current VMCS */
+#define X86_BUG_TLBI			X86_BUG( 1*32+12) /* "tlbi" AMD TLBI Erratum #1718 */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..eba925c85f52 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -110,6 +110,12 @@ static inline void __tlbsync(void)
 
 	/* TLBSYNC: supported in binutils >= 0.36. */
 	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
+
+	if (!static_cpu_has_bug(X86_BUG_TLBI))
+		return;
+
+	/* TLBSYNC: supported in binutils >= 0.36. */
+	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
 }
 #else
 /* Some compilers (I'm looking at you clang!) simply can't do DCE */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54e14ed276b5..40463bad1078 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1049,6 +1049,10 @@ static void init_amd_zen5(struct cpuinfo_x86 *c)
 		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
 	}
+
+	if (cpu_has(c, X86_FEATURE_INVLPGB) &&
+	    !cpu_has(c, X86_FEATURE_TLBSYNC_SFW_NO))
+		set_cpu_bug(c, X86_BUG_TLBI);
 }
 
 static void init_amd(struct cpuinfo_x86 *c)


Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08E3B8922
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833368; cv=none; b=DkB6gL0ovvSCUYPHI4SyEMvGfQrr/M+O3Q9GhieK0vSvxMBb+IbweP3m7YVx6MEA6TDSmbI0824gC+lHRrRndZ0dAEmsY4OfFz2CHvkN20SC2heEnIdIsU86DPfCNjmmp/plOALJvPgG29AZJ5GroG+e5oKvntFhXMpj6hUSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833368; c=relaxed/simple;
	bh=OAj3oXpR/M1+E0qRvtMvpBJmSDuAv48e2NXwXIWlHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNjdunbP0ONgo/Pq3mdiwfuU4jBzp/JoZvP+MVxPFPHjwVdQlK/sFPnkcOd/epLVJcM13WPuCU4+Uq5ub9z69/M/RDlK6ZB5ArEy3di/r7WfVWrnQfJhusvCWliTKgfd4/bCFE71hoYSZ1ZCFlWWxyVy2fMkQlTwwUNgSW0FoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cjq1/sa2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cjq1/sa2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39D9F40E03BE;
	Mon, 12 Oct 2026 19:29:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pKEppLVksWrx; Mon, 12 Oct 2026 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791833358; bh=mu4smEvkN4ta7iNt6U6UbXKE9cDMHW91zRQ0UnIwUZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cjq1/sa2WlXgs4WruAr9GVdOKBAAOcRTVNCfTHhwl4AaXPGYt7PywWuFobLCAnMTt
	 szLGGOx8C9Ju9OrIFWrwa5g4XptCKmICe7DrEApMbNy6zSR2TNToUaveslJoJ0n/EC
	 y+D0Hqew84ZHbwDsxOnjQPKdpbXjmyyVpkz6KOoqisivP4LoctIftjzjVu9QIM5eI/
	 N/Do0dGKDSZHsR3GEqJLYmTtmdvVJV2h9UwahshmH0ZeyojqFIx6Guh1nOhv5SCl5F
	 uyAPKnksKDFmY126xL+oBNUK4Zbo6JhY522l7UekOvqE0//fpo3A+1kmhPK7sNJPh8
	 Qoq2IHNnq7g3ALk+WQc+eazP+UeSieRq941hiJId/u8T17rLQJSIFYKa3sTbhvZOeM
	 INxc/1ESygDG4Uy09ICj/9PbhKANZB8c/tf/vrc3PEE8OfVQiLzS9hBhmxeiWTCLT5
	 XjxXXtKtUOyzNqiCiXhEiSVSV+uVZRSYMLs70bAyAJDXfGRBgAqlIvBiA2nnPP8pEB
	 7LeTqDlmRv05FqOzy2GEEGCK3Bum9bvCMaEVY0uyJxEq0hp6uvrFb3R2YjyLC/00ye
	 LJqRi6XSF2nb88Iw6IrPus7XQ8q8vjgFqA397AonlwnQnidAGtMlU3CrjglevT64kR
	 2B/D82WN/UeV71OnSqgm9gfc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8E8040E02B3;
	Mon, 12 Oct 2026 19:29:13 +0000 (UTC)
Date: Mon, 12 Oct 2026 12:29:11 -0700
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: ljs@kernel.org, riel@surriel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Fix AMD TLBI Erratum #1718"
 failed to apply to 6.18-stable tree
Message-ID: <20261012192911.GBas01B5yAgDcJnPjz@fat_crate.local>
References: <2026101206-disparity-thrive-6c91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026101206-disparity-thrive-6c91@gregkh>

On Mon, Oct 12, 2026 at 01:36:06PM +0200, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Try this one:

From d1ce723f8cd686062d680d97e973a43a070dbab4 Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 2 Oct 2026 14:16:17 -0700
Subject: [PATCH] x86/CPU/AMD: Fix AMD TLBI Erratum #1718

Commit 87db7795cbaaf636ae22ae031f4906db7bb77803 upstream.

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
---
 arch/x86/include/asm/cpufeatures.h | 4 ++++
 arch/x86/include/asm/tlb.h         | 6 ++++++
 arch/x86/kernel/cpu/amd.c          | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4091a776e37a..f4c85555b7e4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -458,6 +458,8 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+
+#define X86_FEATURE_TLBSYNC_SFW_NO	(20*32+ 4) /* TLBI Erratum #1718 fixed in microcode */
 #define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
 
@@ -556,4 +558,6 @@
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
+
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
index b8efe8691b2a..ca4265a1f4bb 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1050,6 +1050,10 @@ static void init_amd_zen5(struct cpuinfo_x86 *c)
 		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
 	}
+
+	if (cpu_has(c, X86_FEATURE_INVLPGB) &&
+	    !cpu_has(c, X86_FEATURE_TLBSYNC_SFW_NO))
+		set_cpu_bug(c, X86_BUG_TLBI);
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
-- 
2.53.0



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

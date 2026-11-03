Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730158;
	b=JDzosJhuouWUxk7hmOnLuluiLhJCL8FgGu7v7V+21LaEM97puOUbQWiTty4N+EMg9WfO
	 HWNP9KT4n39Ewh66cr0iL2Si8ZTsoFAKIFccxjGNo3prY15EiWxcIz1LeI1OrLFlpGf/B
	 vQmjOUrWFVPufj2PiEQO1UBMbxTf0BH4TKNtYnZvls5NJKMhvpsACgg5xx1cbTIxWI5ue
	 +7XkpfoPWrqA94vBfAGLDY/mq3w8pT3i+KgNyqgqgRzWeD+Y7UgzFkolA3uoZe2AfDGQq
	 2IHgfoIsitHJmQA7fHp0lI3ZrfUOmZ6/6px5GHLhAerNU9ZTEK4MwDRKBdQwHxdG+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WAerwT2OH+XzmHpdyGVTZp3cb+XmEIFweKOVx/wV2Vc=;
	b=i4e4ZZzRdPTTuN3KcZQ47bH5oAhgi2g4kypMlUEtZamVEn+/DPGBfLbjsbrbSvje8sh8
	 C561qNLgfWJLwZsv9I443U6boHeNGxkAhAuyh4el36WieXLK7Vlskybic0rOJhMwYupBF
	 RHCZUxpvPvk9/KLFTLGA3o2XO4taUJcQT3AIjzHPdvkVxjmoJOj53kKuAKdRg5LxUhRvL
	 ncmSJuHC5P5jIvRNQfssBNwJ3D5qhsYrbFVB/4KuT5SBwHyR9ImXlG8DuR18hBdbgmKmV
	 oBDCYvpftKl3z+Kortc1pKbNCR4zoZvje9zCgsD9JQd/r3bKOIaGdRP7vYEvM2VIWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXIAcnrg;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FB606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXIAcnrg
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ac926f28c9so275676c88.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730157; x=1794334957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WAerwT2OH+XzmHpdyGVTZp3cb+XmEIFweKOVx/wV2Vc=;
        b=hXIAcnrgmxfMkBfyB1YgDhKSwgyuq1WIfybTBbF7pEocKctXJOU8L+Wd2llRQDfOP1
         PrTpYD7+0fZ6RV764Boj2dRpVuyjinsrVMppskhyTjIEKni0HaTAa/rbBcSGL276vZQ0
         sehpXIQA1KoqWTE1nO89ZXGPGoqlq2FMIlJ5ZoAaxxb13QethVikfM0/InUSP7nib2hC
         bNnlZtcIYnIwd9bsYi7OAsJYzuWYwSRNObTFJCY1bYCuxo0uX5RTVCR7RCvx7xXkh3kv
         2UhU4W8HXf5eUSTkLf90dyY054kgimGKkI7PcRxIXVYUzxK9rKX+TUzpZYYSh7Xl2ENi
         bhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730157; x=1794334957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAerwT2OH+XzmHpdyGVTZp3cb+XmEIFweKOVx/wV2Vc=;
        b=CMNOFvzxXujnX4VCcUrx9xSFVpHrLb7CcNwQXufoB6hGCg3sQLG6IaYx18dxjMTo6G
         Xg9WQZ/P+qckGJpagXetivk0TELlIIsMQOM3ZZB3/MYfoNES1KcKvoIcX3plfC5+6QYX
         cNjnIQik1i5iHwYa4948J0/2p2ro8s7TurVt/8AwLi3Qch0S9SU4HQTr5JmV5A6c3Dd+
         vcQ5aFGyl6O0TdKOwBWV8XpsQ6morRZer7df3eOaqY6jtBSgS3TRpVXIMIS6xGkRiF/Q
         wWTSbW8RswR14+J7Oe1xr4+fUkU79FftRIx19pmZqMFHGsHF7XLGdmf9ueKGJEw2fxVk
         o9sA==
X-Gm-Message-State: APuU4Z8iJARVxyAqYFjBJOzProtv8qFPfvJDcQuXNBy7sOHpvNF8f+p5
	FnpFdIajAzDPr7sPy0OJKU9EYk/5pPfeSTib7WqZ/AzTBcRVqDDBq+OpVqhpjunxS+g=
X-Gm-Gg: AYBFou1TiyolNH5ZzFr/zdO2+WQzWE9Ab30fwKLshuzbBupY1wJISmou/YPHvNVxGLq
	KH+XG9MJrTiIkUmCM9HmOj/U2RiyhyToaZaem3J0XrJGh6cffwQkUPSAMtdrn6DeFF+eLsVtSai
	CE1KU+/44G5WZji9SlyE/O6Tg1mXvRYcvhWxnD1BYWRk2/FDJ7+9EYd/NLpYyXt5MXs3+FLnyrZ
	IP1Drdae+VW3gndIPPdmPW7pcele9NpiUbQPSJCB1j+OCLnBRy3J53M9ffTWzCPlHgz7qR/cFwR
	eQnLaEBY7vtzSlsZnwYhUvtXxFuy/plv6e2RJTES39KMKhPOn4t4R4a+EGDNMEJuX4uIsPB7g6V
	NUocTor4Oy87Ya0uvdXuPBvihxpOiy0xGavmlpmixdiY8+EKY1UNvTGRz6F86yL51sYhm7j/kDT
	ljuVukc5YR4ajU0U6FNjM9YqhWK+JTDlXWZ1dvIbVI/ujDEeWWlbR4gcJEMIX81s5xw1WB2Ma76
	i37+20spqPT5xYQMxPr9d00ADWyKh/Oh2z0+A6qF/Roh/Gau5KaOcbLgaM9ovtQgS3PNxylwXAq
	/4OfAOu3BgladW2bfmaAEdV3PL8Y8iQLgJcN7jrl31ws7/YmcUGrwBezubTYTIjZxUDK
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id a92af1059eb24-1ac5b7dcb2bmr34222236c88.2.1793730156639;
        Tue, 03 Nov 2026 10:22:36 -0800 (PST)
Received: from SCSSASHAIJU01.amd.com ([136.226.78.189])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm598817c88.4.2026.11.03.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:22:35 -0800 (PST)
From: "S Shaiju (AMD)" <sshaiju.lkml@gmail.com>
To: stable@vger.kernel.org
Cc: bp@alien8.de,
	sshaiju.lkml@gmail.com
Subject: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Date: Tue,  3 Nov 2026 10:21:43 -0800
Message-ID: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit ae1d2082d93bc04604dc08e9b7f9cdba5e0c28e6 upstream.

Zen6 has BTB protection which isolates the different contexts
(user/kernel, guest/host) from one another. This makes the SafeRET
mitigation there unnecessary leaving the user/user and guest/guest
attack vectors open, whose protection is handled by the Spectre v2
mitigation setting to do IBPB on a context switch.

Detect that setting and report it with a new mitigation string.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260822013231.1109255-1-bp@kernel.org
Signed-off-by: S Shaiju (AMD) <sshaiju.lkml@gmail.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/bugs.c         | 18 ++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c    |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f4c85555b7e4..b60b4a82ea20 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -411,6 +411,7 @@
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
+#define X86_FEATURE_BTB_CTX_ISOLATION	(17*32+ 4) /* AMD: Branch predictions contexts isolated */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* "avx512_4vnniw" AVX-512 Neural Network Instructions */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fbc465555e67..a39d97eee8bd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1320,6 +1320,7 @@ enum srso_mitigation {
 	SRSO_MITIGATION_IBPB,
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
 	SRSO_MITIGATION_BP_SPEC_REDUCE,
+	SRSO_MITIGATION_USER_IBPB,
 };
 
 static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_AUTO;
@@ -3055,7 +3056,8 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_SAFE_RET]		= "Mitigation: Safe RET",
 	[SRSO_MITIGATION_IBPB]			= "Mitigation: IBPB",
 	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only",
-	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
+	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation",
+	[SRSO_MITIGATION_USER_IBPB]		= "Mitigation: IBPB on context switch",
 };
 
 static int __init srso_parse_cmdline(char *str)
@@ -3095,7 +3097,9 @@ static void __init srso_select_mitigation(void)
 		 * required.  Otherwise the 'microcode' mitigation is sufficient
 		 * to protect the user->user and guest->guest vectors.
 		 */
-		if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		if ((cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) &&
+		    !boot_cpu_has(X86_FEATURE_BTB_CTX_ISOLATION))
+					||
 		    (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) &&
 		     !boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))) {
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
@@ -3171,6 +3175,16 @@ static void __init srso_update_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
+	/*
+	 * See if IBPB on context switch is the only thing needed to address
+	 * GUEST/GUEST and USER/USER vectors.
+	 */
+	if (srso_mitigation == SRSO_MITIGATION_MICROCODE  &&
+	    boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO) &&
+	    boot_cpu_has(X86_FEATURE_BTB_CTX_ISOLATION) &&
+	    spectre_v2_user_ibpb != SPECTRE_V2_USER_NONE)
+		srso_mitigation = SRSO_MITIGATION_USER_IBPB;
+
 	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index caa4dc885c21..c4bc3c259f3f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -56,6 +56,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
+	{ X86_FEATURE_BTB_CTX_ISOLATION,	CPUID_ECX,  8, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.53.0


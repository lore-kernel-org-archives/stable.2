Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D73839A1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324948; cv=none; b=k8BE+odpdCUIp7ZNocssiJRkkkiiY6jd7TTtWqXoav8DZ14egYWfUDrp6j6XA/JjVvZgkIN/E5zy/O/tm644yO12ZYogI8eK5/0NcbfTNS6U6Pi3ruQ4IBXW31G23RTyYee8P6+E7snGtyg9AxKNaNSin+TME+6RG5C64F12AEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324948; c=relaxed/simple;
	bh=xDgaYx1EFS+199xB8Wpw7zO7kBJdMPgykC466D5JTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7x/KpI9tnj08ozO2XK8A0H2Z4ENQq/rby17IE9fcrV+muNwwIHpVbbygrsHDOnMgDaSkaeIPejsRYoT+ADNOr6s3YaecJHIGDdEmvH1vjMPVukxQFMz36ztvEE4QYIvt7WTA1k8ha7woHpENqdFk8eP3MDTSqE1X9mqA4FoyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CKYlDEkN; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CKYlDEkN"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6de3360d905so824181eaf.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791324946; x=1791929746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhS/FnZjdJag3+q0E1Ont8ZosVleeXOvI2+Sfd5L34Y=;
        b=CKYlDEkNnzliuXdycBoUfCwd7+ht1pWB942cCG/h4iTFtidKSR7nBdxWMWIDpzwIuR
         aSUQS2OoCn/LydvjZXD54w//i8KDTgUjYbbNvCtqJLi1xn85NU7ZcSl4nSZplbuSrDuj
         MU8tpABVd87OmLjhg2SqqgcrEEUFIXpJNeXAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324946; x=1791929746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhS/FnZjdJag3+q0E1Ont8ZosVleeXOvI2+Sfd5L34Y=;
        b=pZHTcPUF410eqtJ1YAuNEZ/Pry4X0IF7ws+qKSk2POABbYpIPFkFng8tGq3GpI3aPy
         uaRDcQFeJWREvbnaDkMCqXUDg4ClTQZyjhQM/Jdgw5mGLHPv4rQTdQA/LZgfKSanKkgH
         jAuL3Ha/196WF66Lh+hS8k8WQ7xdm0iI0Sdss6kRtg9KTaqbWzgN2jvjJHBZ7F/IY+NR
         EY9MOFr5/ACTPofutrNYdd3OL2Bu06c7fEdxXd5/rqlAs9+rVMNzIxkOtZDxdJnCl8NG
         nptuPa2pqwqSvUsaACBIrGwgwj8gPghzDH+T2F7rtCGDdZXZBvY/GFxYcDPo7yfxLyX2
         PXVw==
X-Forwarded-Encrypted: i=1; AKwUvBw7jsZRDvBOvhrUxV4yXjdiSQCPSuL1RvxkF3Ua7uBGBq+A919KCE+XF5f78xob8HrH2sNJYLE=@vger.kernel.org
X-Gm-Message-State: AFuF++mMJPK5TidZ/P+lgHxHf81lhK4CqcNYgC5KKNK6NfQMac0xXOii
	ELW2SysP77gCmqLbFLPn0Lh14uDf/H1CLxVlfjslhq3Dj3DvtALoV0e2LotHia++i+c=
X-Gm-Gg: AYBFou1xEOrFlT5ZqUjSKp9EPXmwaHrrSMznIWOorgA06NtBcGcKj4OyhdimZ0p0UO/
	RLvvwOGhOE5orFeyaDdrvuiki3tJ30QYSXOaP5FZoU3WFHW/MUK/g3tgkRS33VOCjmgOEPk4mZ7
	PJgtpB6yUGgI1LqD8smaO40vA3uQIVgeuDRM+67nxgfKRXoBVxaTiNnXnW8DIdl9osSqq0KI71N
	5A8lQdWm2j1afhA2/rdm2CTaqhjX4eyr/JYMUJaiuJ37JmImDjFlY2di3MbOP5laUkqY4MZ6Huu
	gW57j2j97W8qphF/jiWYnqeDceTrVveQveNWdb5benmeqotuPbe0rKV1Zoo9qEO0MfSpVmkAOhp
	tfBZpiijO+iNCw5BtygeBFn/iSWWDarCKV4fWOy83pFl3SH7wgQHHE1Uv6BQGAIaIIc3YZ2847L
	gY1+p98ID9LDK5m/UDzIvn4R/n1+p5K/x+q3CUXmeliGjAJAovF+a13DH5t5QcOctQTXDDcL49g
	FxN1lE5/5imZIE8xKYayrxqEsrBPLWmyxPKjAONo9VUhXAo4PrLdt8M9VOu0lcJW+Fese++wWU=
X-Received: by 2002:a05:6820:16a2:b0:6d7:58ee:fd72 with SMTP id 006d021491bc7-6e7a5c989f7mr660751eaf.14.1791324945800;
        Tue, 06 Oct 2026 15:15:45 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e793f68bf6sm689793eaf.8.2026.10.06.15.15.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:15:45 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/fpu: Avoid kernel-address leaks in the FXSAVE workaround
Date: Tue,  6 Oct 2026 15:15:41 -0700
Message-ID: <20261006221541.35963-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On AMD CPUs without XSaveErPtr, restoring x87 state without a pending
exception can leave FDP/FIP/FOP unchanged.  The existing workaround
replaces the previous context's pointers by executing FILD on a kernel
fpstate.  This exposes the kernel instruction and operand addresses
instead.  On TCG qemu64, an unprivileged task can recover the kernel
text slide with FNSTENV at ELF entry, even though FXSAVE64 reports zero
error pointers.

Use FNINIT to clear the pointers without recording new addresses.  It
also clears pending exceptions without waiting for them, and the
following restore reloads the intended x87 state.

Apply the workaround in the FXRSTOR and FP-capable XRSTOR helpers,
including the safe and user-sigframe variants.  This also covers the
init-state and direct sigreturn paths, which must not retain pointers
from kernel FPU use or another task.  Retain preparation for the
no-FXSR FRSTOR fallback too: it was covered by the old common
workaround, and TCG qemu64 can also leave the legacy pointers unchanged
after that restore.  Only initialize x87 when the restore mask includes
FP, so partial and supervisor-only restores keep the unrequested state
intact.

Fixes: 18bd057b1408 ("[PATCH] i386/x86-64: Fix x87 information leak between processes")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 arch/x86/kernel/fpu/core.c     | 14 --------------
 arch/x86/kernel/fpu/internal.h | 19 +++++++++++++++++++
 arch/x86/kernel/fpu/legacy.h   | 14 ++++++++++++++
 arch/x86/kernel/fpu/xstate.h   |  5 +++++
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d1aeecd57f5e..9113f55b80d8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -161,20 +161,6 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 
 void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 {
-	/*
-	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
-	 * FDP/FIP/FOP unless an exception is pending. Clear the x87 state
-	 * here by setting it to fixed values.  "m" is a random variable
-	 * that should be in L1.
-	 */
-	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
-		asm volatile(
-			"fnclex\n\t"
-			"emms\n\t"
-			"fildl %[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (*fpstate));
-	}
-
 	if (use_xsave()) {
 		/*
 		 * Dynamically enabled features are enabled in XCR0, but
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 975de070c9c9..3b4d178edc31 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,6 +2,9 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
+#include <asm/cpufeature.h>
+#include <asm/fpu/types.h>
+
 extern struct fpstate init_fpstate;
 
 /* CPU feature check wrappers */
@@ -15,6 +18,22 @@ static __always_inline __pure bool use_fxsr(void)
 	return cpu_feature_enabled(X86_FEATURE_FXSR);
 }
 
+/*
+ * AMD CPUs without XSaveErPtr may leave FDP/FIP/FOP unchanged on restore
+ * when no x87 exception is pending.  Using an x87 load to overwrite them
+ * leaks the kernel instruction and operand addresses through FNSTENV.
+ *
+ * FNINIT clears the pointers without recording any new ones.  Only do this
+ * when the x87 state is about to be replaced; a partial XRSTOR must leave
+ * unrequested components alone.
+ */
+static inline void fpregs_restore_prepare(u64 mask)
+{
+	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK)) &&
+	    (mask & XFEATURE_MASK_FP))
+		asm volatile("fninit");
+}
+
 #ifdef CONFIG_X86_DEBUG_FPU
 # define WARN_ON_FPU(x) WARN_ON_ONCE(x)
 #else
diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
index 098f367bb8a7..fe825c9a00c7 100644
--- a/arch/x86/kernel/fpu/legacy.h
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -4,6 +4,8 @@
 
 #include <asm/fpu/types.h>
 
+#include "internal.h"
+
 extern unsigned int mxcsr_feature_mask;
 
 static inline void ldmxcsr(u32 mxcsr)
@@ -63,6 +65,8 @@ static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 
 static inline void fxrstor(struct fxregs_state *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -71,6 +75,8 @@ static inline void fxrstor(struct fxregs_state *fx)
 
 static inline int fxrstor_safe(struct fxregs_state *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -79,6 +85,8 @@ static inline int fxrstor_safe(struct fxregs_state *fx)
 
 static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -87,16 +95,22 @@ static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 
 static inline void frstor(struct fregs_state *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline int frstor_safe(struct fregs_state *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
+	fpregs_restore_prepare(XFEATURE_MASK_FP);
+
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 38a2862f09d3..ac378d839534 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -7,6 +7,8 @@
 #include <asm/fpu/xcr.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
 #endif
@@ -240,6 +242,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 
 	xfd_validate_state(fpstate, mask, true);
+	fpregs_restore_prepare(mask);
 	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
 }
 
@@ -334,6 +337,7 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
 	int err;
 
 	xfd_validate_state(x86_task_fpu(current)->fpstate, mask, true);
+	fpregs_restore_prepare(mask);
 
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
@@ -355,6 +359,7 @@ static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
 
 	/* Ensure that XFD is up to date */
 	xfd_update_state(fpstate);
+	fpregs_restore_prepare(mask);
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-- 
2.53.0


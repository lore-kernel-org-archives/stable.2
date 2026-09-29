Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D54E9C10
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694668; cv=none; b=JlHzSGxCKOZeBE1L4iGwgWjopMXySFhxLMRIY+jzMKK0+RTe82OvNyNPM7JwfLky/PV/R57ZPShrHZraATncKRHotz1KfhNnacENKczydGTrFMrIqQxTMpSCKjhaVdDDF6SXik/TAGmdWDfnQR7Xj2sbgtYxHakrpac6K/OXQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694668; c=relaxed/simple;
	bh=JOeaS9aUeBrTQEvyJy9Zvse1y4Ni9NeQZu5p2BMSjbc=;
	h=Content-Type:To:Subject:Mime-Version:From:Date:Cc:Message-Id; b=BwNHPyTHbiOe3w+8XOrKA17wLaIYAavE03UiB2F7inIoQ8EgemItiaIJyaiS3DNJ5j+tJXGjJddGew8V/SnE+01ywE7+BoUdkbyz5Kmx7G+rvhU5/4nH6M4Gm5svWDsEwHFgMU11WVxOJxGY0V05DFiigbMRfHapES6050T+4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I2Xkefmb; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I2Xkefmb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1790694638; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=O3IJCO3Fxa+KIWY5We9OpQjzjeolrtdQXzDOuRowT8k=;
 b=I2XkefmbFfmQpL440lQWV3tlrRHyscqqfYz16Cdy7RzsLyQBkV7h05w2bgadcACFs840Ic
 tgpPfAmlHyPHFMpXf72FQXJIe6gXfDBeNdVc7XlgGgwRjgpqXQc2GlGb8RbTM21ngjuEsj
 RpI3mkltFy42I+HqQHRJwqybJP8g06pKJg93nfRe2roEvVFzaHpyjRmDudlRPf2f0evD0h
 meso99d7f1ou7kcKTjridkw5doC4HKHBE9angLrG566Q+nZ8K+eUqW2KpNcNXKdY/oOozU
 UCnDnIMKMDKEw/QgiVARD1Rbjtc8fNxzsY8WcWPD7t3dMoBEbEZAGuH0ynhnXw==
Content-Type: text/plain; charset=UTF-8
To: <x86@kernel.org>
Subject: [PATCH] x86/fpu: Free dynamic fpstate on exec()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26abbd4ec+58b1c1+vger.kernel.org+weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Tue, 29 Sep 2026 23:10:06 +0800
X-Mailer: git-send-email 2.50.1
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, 
	"Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, 
	"Chang S . Bae" <chang.seok.bae@intel.com>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Message-Id: <20260929151013.81562-2-weiguixiong@bytedance.com>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>

The fpstate embedded in struct fpu only accommodates the default
xfeatures. When a task first uses a dynamically enabled xfeature,
fpstate_realloc() installs a larger fpstate allocated with vzalloc().

fpu_flush_thread() resets fpu->fpstate to the embedded fpstate on exec()
without freeing the dynamically allocated one. Once the pointer is
overwritten, arch_release_task_struct() cannot free the allocation when
the task exits.

Preserve the old fpstate pointer across fpstate_reset() and free it only
after fpu_reset_fpstate_regs() has invalidated FPU register ownership.
This ordering prevents a context switch from saving FPU registers through
a freed fpstate pointer.

Make fpstate_free() operate on the fpstate pointer itself so it can free
the detached allocation. Use it for the existing reallocation and task
release paths as well.

On an AMX-capable system, 1000 iterations of requesting XTILEDATA
permission, executing TILEZERO and calling execve() on the same image
left 1000 16 KiB allocations attributed to __xfd_enable_feature() in
/proc/vmallocinfo. None remained after this change.

Fixes: 500afbf645a0 ("x86/fpu/xstate: Add fpstate_realloc()/free()")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/include/asm/fpu/api.h |  6 +++---
 arch/x86/kernel/fpu/core.c     | 11 ++++++++++-
 arch/x86/kernel/fpu/xstate.c   | 10 ++++------
 arch/x86/kernel/process.c      |  2 +-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 90c63fe19c0fb..3e0c3b7dce73b 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -123,11 +123,11 @@ extern void fpu__resume_cpu(void);
 DECLARE_PER_CPU(bool, kernel_fpu_allowed);
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-/* Process cleanup */
+/* Dynamic fpstate cleanup */
 #ifdef CONFIG_X86_64
-extern void fpstate_free(struct fpu *fpu);
+extern void fpstate_free(struct fpstate *fpstate);
 #else
-static inline void fpstate_free(struct fpu *fpu) { }
+static inline void fpstate_free(struct fpstate *fpstate) { }
 #endif
 
 /* fpstate-related functions which are exported to KVM */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d1aeecd57f5ed..08f5c77d990aa 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -866,8 +866,17 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpstate_reset(x86_task_fpu(current));
+	struct fpu *fpu = x86_task_fpu(current);
+	struct fpstate *oldfpstate = fpu->fpstate;
+
+	fpstate_reset(fpu);
 	fpu_reset_fpstate_regs();
+
+	/*
+	 * Free the old state only after register state ownership has been
+	 * invalidated. Otherwise, a context switch could save into it.
+	 */
+	fpstate_free(oldfpstate);
 }
 /*
  * Load FPU context before returning to userspace.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea2..ea3736a74fd43 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1556,10 +1556,10 @@ static int __init xfd_update_static_branch(void)
 }
 arch_initcall(xfd_update_static_branch)
 
-void fpstate_free(struct fpu *fpu)
+void fpstate_free(struct fpstate *fpstate)
 {
-	if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
-		vfree(fpu->fpstate);
+	if (fpstate && fpstate->is_valloc)
+		vfree(fpstate);
 }
 
 /**
@@ -1640,9 +1640,7 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 		xfd_update_state(fpu->fpstate);
 	fpregs_unlock();
 
-	/* Only free valloc'ed state */
-	if (curfps && curfps->is_valloc)
-		vfree(curfps);
+	fpstate_free(curfps);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 346c438ac8801..b7306f257f4b0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -118,7 +118,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	if (fpu_state_size_dynamic() && !(tsk->flags & (PF_KTHREAD | PF_USER_WORKER)))
-		fpstate_free(x86_task_fpu(tsk));
+		fpstate_free(x86_task_fpu(tsk)->fpstate);
 }
 #endif
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.50.1 (Apple Git-155)

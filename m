Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300F3BF672
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439332; cv=none; b=T+71q/iOXtWkW6GuxSo5fPwpglVGVOv6qXBc8pVEtiwConp7sUdKS6LgTw8gC0U24+paX6xwQyMxN04jbLD1vbvp5uc6eYpeV2H7rPwZVMWUt74geZgsJyKMo/VM/9rkF7o9aa6FTphbtOfXgDNxLV32YUudngjiXDJ9D1O1AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439332; c=relaxed/simple;
	bh=Ha3b03iGBkpUSCPc7yMkgYgsjiDrxvIUlt5lpHgohBk=;
	h=To:References:Date:Message-Id:In-Reply-To:Content-Type:
	 Mime-Version:Cc:From:Subject; b=NGQOBABk5PE//uQQSUgEfrCN2lXoe5zA+2mbjnQqsAETEN/u7l30gapP6xxWI4eHNW+ULlYIdm5D3+2S5rVmN28FyttF609AsvGHYkbNPZct1A7//RvCxBSeKueOwNCXk8K0ZIXyzPeqdiPWmppBIlciHQFqTmel2NaRJRiY03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kSFs/JBo; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kSFs/JBo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791439325; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cUOkFUQoB+U5z0DM+IxlJtdkFvuZpJh59IQX5jKa4xs=;
 b=kSFs/JBojelJGhBk52MKT8dSLsgNx0NuXdCIv0uvfvCT9yoC9aW1ySszfHA6iDDWcdzoZO
 0Go4s0IWTdCVJov5qxH09sZkMvE/QfE8hNo+LCQ8GisvcUbPfbvu72kJpmEo1S4CdMPoT6
 VGym7ixnISaTsL1yIXFbCwmAh1WQ1vcaWe6dW5jtEi/v52zHA9BlXTUJXfiWKztYjET44E
 dccq69XwjXkjHFwMaJ+oPSM2UAmJIqsRkNiPvNSBNjOf1VEi31GiouACZkjX3lktRbBdwc
 jZbqr412U95aBDDKbsY15mHsv8ib19m7AIT7LYhWInC3FbKbFp1lAbFLwxQyCQ==
To: <x86@kernel.org>
References: <cover.1791428412.git.weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26ac731db+eb59a6+vger.kernel.org+weiguixiong@bytedance.com>
Date: Thu,  8 Oct 2026 13:59:35 +0800
Message-Id: <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
In-Reply-To: <cover.1791428412.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.55.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, 
	"Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, 
	"Chang S . Bae" <chang.seok.bae@intel.com>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Subject: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()

The fpstate embedded in struct fpu only accommodates the default
xfeatures. After a task obtains permission for an XFD-controlled
xfeature, its first use raises #NM. The handler calls
__xfd_enable_feature(), which uses fpstate_realloc() to install a larger
fpstate allocated with vzalloc().

On exec(), fpu_flush_thread() calls fpstate_reset(), which overwrites
fpu->fpstate with the embedded fpstate. This leaks the dynamic
allocation because arch_release_task_struct() cannot free it when the
task exits.

Make fpstate_reset() own the complete lifetime transition. Preserve the
old pointer, install and initialize the embedded fpstate, and then free
the old allocation. This detaches the allocation from fpu->fpstate
before freeing it and makes future reset callers release dynamic state
automatically.

Since fpstate_reset() now releases the old state, initialize
dst_fpu->fpstate to NULL before invoking it from fpu_clone().

Make fpstate_free() operate on the fpstate pointer itself so it can free
the detached allocation. Use it for the existing reallocation and task
release paths as well.

On an AMX-capable KVM guest, 1000 iterations left 1000 dynamic fpstate
allocations on an unfixed kernel and none with this change.

Fixes: 500afbf645a0 ("x86/fpu/xstate: Add fpstate_realloc()/free()")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/include/asm/fpu/api.h |  6 +++---
 arch/x86/kernel/fpu/core.c     |  5 +++++
 arch/x86/kernel/fpu/xstate.c   | 10 ++++------
 arch/x86/kernel/process.c      |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

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
index d1aeecd57f5ed..bcebe1f0d82b7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -594,6 +594,8 @@ static void __fpstate_reset(struct fpstate *fpstate)
 
 void fpstate_reset(struct fpu *fpu)
 {
+	struct fpstate *oldfpstate = fpu->fpstate;
+
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
 	__fpstate_reset(fpu->fpstate);
@@ -610,6 +612,8 @@ void fpstate_reset(struct fpu *fpu)
 	 * guest FPUs, which allows for common guest and userspace ABI.
 	 */
 	fpu->guest_perm.__user_state_size = fpu_user_cfg.default_size;
+
+	fpstate_free(oldfpstate);
 }
 
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
@@ -670,6 +674,7 @@ int fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
+	dst_fpu->fpstate = NULL;
 	fpstate_reset(dst_fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
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
 
-- 
2.50.1 (Apple Git-155)

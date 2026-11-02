Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614387;
	b=BGMcoHhPQTvTt4t0oV+8Tz+jhglYRQ3gKKpXJpqA0gH9mZjm5fHJWXz3dkk89Up/DzMG
	 MZp8lgpMve4WsKYWtlvlCFBM2UyqZyYGaV241nXUCc0tSjm4vL77mCV199GZhUf1bxB7a
	 enaPLIY06did748Rq6XeROkM9SuJR+qH8mx3kcT4EJ8Me78TmzJ6jA+mrsMGOdcyk6zC/
	 40V/rH2jtbxUt2Y4fqeJchr/kT0OwOXkOc3J/MrsSd02iNPpnKORza/xtAZMmtO76gz+/
	 A2eZSiAruUHSPlXG6hIA3P9ann+j8tqyAX2eaQekJW3suiE249k2p4SIIlF92V0baRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614387;
	h=DMARC-Filter:DKIM-Signature:To:Cc:References:X-Lms-Return-Path:From:
	 Message-Id:Mime-Version:Content-Type:X-Mailer:X-Original-From:Subject:
	 Date:In-Reply-To:Content-Transfer-Encoding;
	bh=aituG1bxTpae/DDlLBLRyzfIzZb6iuG1m7AYxCW4Jno=;
	b=Aaid7YPPobllXRHaACW6GiltLyPPPW3YO0cjVAy5tZ7Hj5w690fPqvwwbnSw5iSNnJcc
	 nz3BvmP2qpUtMCuguAVwPdChFUeYFU+KOSphJLiJPuejuQJ77kSzhW0YoB/DkPg2GboQH
	 8IfQeD57LVEmVFFiRv7xlrB0kkuzrv9Akpw64zWVxVxKKe94Px4+veEMR8yP3zgjB7jez
	 ypFbskDkFV0cm3yR1MIRBshPhYta6jin5q9glvpPg75a1BkWLpDNXkpv2jlfHK8PaFw+P
	 +oDbS4S9gcvD1dZCWkCFezdfJY/nzYgcVgiL5JLVFrsKBdMct8UfwiL+q5xaMLZjCrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gQJdPfoX;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95516606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95516606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=gQJdPfoX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793614376; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=aituG1bxTpae/DDlLBLRyzfIzZb6iuG1m7AYxCW4Jno=;
 b=gQJdPfoXvJnVd+IqicP+EaqX3m3USc5TP74OjQPaxQpbJsUZX0VHd8wMt7v6wQjjc0etKO
 lgAJE5vebRfJ5tBp40mkSKgeBGSip9+seqHjVbLRs/aypvkp6VLD2SaeG50krJKKlYjwek
 BnIy1o0MOM8jyTqNcR22usYWgBkA025t4c80asOxQZuCStRqmnFnsmQ1YwWW4sDncaVghE
 i8kwfb+kkw3jl6m1B95UdMamB8IldJsF+GOYJyWlFTrnE26+/yZMMDXD8O/P83HDHzgefw
 KBEpRFdh2nWc+p9QK/dQA37Cj56RGC0vE9BqVcUgGzsyMoUJdovGFySYPdBxig==
To: <x86@kernel.org>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Chang S. Bae" <chang.seok.bae@intel.com>, <stable@vger.kernel.org>
References: <cover.1793604327.git.weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26ae86226+25c787+vger.kernel.org+weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Message-Id: <728ed963f43b44c97f4807a2060f77c0b362521e.1793604327.git.weiguixiong@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.55.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Subject: [PATCH v4 1/2] x86/fpu: Fix memory leak with dynamic fpstate and exec()
Date: Mon,  2 Nov 2026 18:10:50 +0800
In-Reply-To: <cover.1793604327.git.weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit

Using an XFD-controlled xfeature can allocate a larger fpstate. On
exec(), fpstate_reset() replaces fpu->fpstate with the embedded buffer
without freeing the dynamic allocation. Once the pointer is overwritten,
the allocation cannot be freed on task exit.

Free dynamic state at the start of fpstate_reset(). In fpu_clone(),
clear the new task's fpstate pointer before resetting its state, so the
parent's allocation is not freed.

fpstate_reset() may now free the current task's buffer. fpu_flush_thread()
calls it before fpu_reset_fpstate_regs() sets TIF_NEED_FPU_LOAD. If a
context switch or a kernel FPU user happens in that window, the register
state still looks live and gets saved into the freed buffer. Set
TIF_NEED_FPU_LOAD before the reset so that nothing saves the hardware
state until it is reloaded from the reset in-memory state.

Fixes: 500afbf645a0 ("x86/fpu/xstate: Add fpstate_realloc()/free()")
Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/kernel/fpu/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d1aeecd57f5ed..af1c1688d69bf 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -592,8 +592,15 @@ static void __fpstate_reset(struct fpstate *fpstate)
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
 }
 
+/*
+ * Callers resetting the current task must ensure that its FPU register
+ * state isn't saved on context switch as the buffer may be freed here.
+ */
 void fpstate_reset(struct fpu *fpu)
 {
+	/* Free dynamic fpstate (if any) before resetting pointer: */
+	fpstate_free(fpu);
+
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
 	__fpstate_reset(fpu->fpstate);
@@ -670,6 +677,8 @@ int fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
+	/* Break the link to the other FPU's fpstate: */
+	dst_fpu->fpstate = NULL;
 	fpstate_reset(dst_fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
@@ -866,6 +875,9 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
+	/* Prevent the hardware state from being saved on context switch */
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+
 	fpstate_reset(x86_task_fpu(current));
 	fpu_reset_fpstate_regs();
 }

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

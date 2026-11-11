Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404948;
	b=lyeW7P3uPn1nTtlNCTvIV33xv/gIvL3FfQ4zZLyMyv1W2dVBXGQtUUaHBFKeHO0JjY20
	 fzAfAPy+NA3NsKzyIZnG03qMWywLW21W+91Tz1/Ww5YJjDpWJtEknTLCr5gC+PYVF5Uo8
	 E00R6eszdyuSgh0+03wqJDazfTmAwKfDpl4Dli1aPYKNOyNsyk7DpA6Rk+tfbsL6I+Tzm
	 bwHZUx0NxYY6XiRPpSB2FZN/K6Re1Of06KsTejYA+i952IncWBrD82gigGlLiK7cSgNdR
	 PVTc3fiVXiNT7Z2Ik5UagPTco+hW8IGAU/rKCI9jmntQpvNbbmGSDnNPsn3SAh6o6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HTfyp21AwsYXKG+Btvfp1QrfytZVLqFJ1Xoi7e+JfTI=;
	b=rjOMVLdS2ob9KcSgVUYp2cuNiSX4LRf2Bh4QomVbRIMHdH1vPIBDvRw5OKJbafNXFrMb
	 VECqPYzCAPlo2ri0tvfMzo3mJOMpDj77Q7x0bh9tHzxZzlE6ozvc+ecTQZkzj5xUi3CI3
	 lrOVgOiipT0tjwTXEGoBtqVToIdlpmTTl/k7CrF9Mj/v80HEnXSfqRuDK5quPxfg2zwUr
	 CwRfyi438IJSmFtYQlkitbq1upNOIxRJvPuqlLctlDtP61IrOVdNIdrTGTr1gl7hj4BGE
	 NwlT4cCHEgM+ipxgqtIwh7kATFqbNBxhEpYJyiv9CT6AAGjmUbk5W8MPpH4XYi1ftAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2iREnu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672B606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2iREnu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EF81F00A05;
	Wed, 11 Nov 2026 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404948;
	bh=HTfyp21AwsYXKG+Btvfp1QrfytZVLqFJ1Xoi7e+JfTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2iREnu6AwuzC1hQ7fdwatxW0Xyc+837Ikv+sTcq0aqGIXDnG9wM09XTvdtbbQkC8
	 Z1pYNZwAk2xhzsN7Ldpz+G0ZWJLAxVdUAPh+eCIlQ4eoLiWMLM11rFKafc3tKMgePy
	 O3SUaqSE7rQC70keAsJEzPasDsw1+NGNwQqGfAuQDDtJggqzWe4PAMhO29BWlKkCJE
	 u/Ey0UEGOL6evVfP9TcS+Aduj6eBkXts5JkW0M7er1TML8NWiTsP5e2n+zI+6SzGcZ
	 4IfvplDIIRUsxsaDRyOhqf9MTpsT4VKVykov0lKxiHyW0q4WigKiScraBqTMgUPVmH
	 T2SjSPkC2PDvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] arm64/gcs: release GCS on failed fork
Date: Wed, 11 Nov 2026 08:49:06 -0500
Message-ID: <20261111134838.1649375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051555-failed-6.18-078e122f3bf0@kernel.org>
References: <20261107051555-failed-6.18-078e122f3bf0@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

[ Upstream commit 078e122f3bf000dd45965997b66deac10ee580fa ]

copy_thread() can map a CLONE_VM GCS and still return 0. A later
copy_process() failure calls exit_thread(), but arm64 did not
implement it, so the VMA stayed in the parent's mm. Wire
HAVE_EXIT_THREAD to gcs_free().

Kernel threads created with CLONE_VM (io_uring and vhost workers)
inherit the parent's gcs_base/gcs_size from arch_dup_task_struct()
without allocating their own GCS. When such a thread exits,
exit_mm() -> mm_release() -> deactivate_mm() -> gcs_free() unmaps the
parent's GCS. With the new exit_thread(), a failed copy_process() for
one of these threads would do the same. Clear these fields in
copy_thread().

Fixes: 506496bcbb42 ("arm64/gcs: Ensure that new threads have a GCS")
Cc: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ sashal: Placed exit_thread() before the existing erratum helper conditional block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/process.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2e567a7d89c9b..66b7284ce751d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -222,6 +222,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4c328b7c79ba3..b3cde5f60b00f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -319,9 +319,18 @@ static int copy_thread_gcs(struct task_struct *p,
 	return 0;
 }
 
+static void gcs_reset_thread(struct task_struct *task)
+{
+	task->thread.gcs_base = 0;
+	task->thread.gcs_size = 0;
+	task->thread.gcspr_el0 = 0;
+}
+
 #else
 
 static void flush_gcs(void) { }
+static void gcs_reset_thread(struct task_struct *task) { }
+
 static int copy_thread_gcs(struct task_struct *p,
 			   const struct kernel_clone_args *args)
 {
@@ -340,6 +349,12 @@ void flush_thread(void)
 	flush_gcs();
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	/* Failed fork after copy_thread(); deactivate_mm() does not run. */
+	gcs_free(tsk);
+}
+
 #ifdef CONFIG_ARM64_ERRATUM_4193714
 
 static void arch_dup_tlbbatch_mask(struct task_struct *dst)
@@ -537,6 +552,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.cpu_context.x19 = (unsigned long)args->fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
+		/* Kernel threads sharing the parent's mm must not free its GCS. */
+		gcs_reset_thread(p);
 
 		if (system_supports_poe())
 			p->thread.por_el0 = POR_EL0_INIT;
-- 
2.53.0


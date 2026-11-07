Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046557;
	b=RE8GxXODP3TH9MJ9Muxs4lM/YG+pCFPSvftllO2B0EmvTYNpfQR53YNNwK8nQGUeqCjL
	 VwqsM1M0gZkfPrrO959QDd5dwLux4Q31uo7U16+e70fOeYqFxZL1vThY4RzInrKh2MHnb
	 m9v8Wuhhj09Tmrh/OIfqsRVp85WpNcaMmui/Yfb0EgXYRJW14YIzY3HjdNVxME3KBD6xm
	 iHd5o6+boTzuc3V/dwmr+p5DL7rs0ExapDB4r+ht1Q8h8m26eG0TSW9Z/RZS/h3t7EUp+
	 lCscULefesBa3dVvhPn2888iEGDPI04bGZnBCE9puEIzhU8yh9nvvPSsL2UmIjd/35w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2n6Mzdub620oKlGVQEU2q0xzgywKIa6ZecbakL+qbWk=;
	b=uMR/QNk05p09b5lKNC6Y9Ya96fiX+GG9hObNu1Rzt4x6tpm09hPSp299uRZd92mjeMEk
	 ZxdGaczc/yiWPfSqVPaVi6DT76d5alnaD7YUBGgrA+YrrVUYzN8yL7oOvZy0vz0hlPJ9I
	 QWh2Q4euG9i+JjDo56QfeNDjLqz8ZWcaqcgFHM1zKIXzJr3UWpO5paf5UGkzTOcy/BW5Y
	 uy9RMD/2A4YlOsEkmYJ99Zh2+4DuR1QFB2OWo0QvG0NaDaumEuEXV8m/vGALuM6IpX1Aw
	 3CQ0fzFlaKezfRfuYZ1MSJCfHbu4rUf7hPYGbBCDrb951pOUb/q3eUCXsjmZCbAFODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkXU1Rnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2306606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkXU1Rnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338A51F0089F;
	Sat,  7 Nov 2026 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046556;
	bh=2n6Mzdub620oKlGVQEU2q0xzgywKIa6ZecbakL+qbWk=;
	h=From:To:Cc:Subject:Date;
	b=JkXU1RnbwTwPYfaIJMpTCf3Da7v5yQzrUErKHQZVL/YG1KG7YACdMMuGDbTT8ngl9
	 U3ErRDA3PNEhmFFdbD/PDdICtOVzWv4k+j00U7icKcEug9dbDoTtjaWgwMkPLdnOKW
	 7g0/x3IFuK6CevV/naJjQzktadadRGHD9cfm1hf5mI9oturKeqJYKXrWJUscUJ7s3a
	 AR1a8AdOnIbBrnMzkeiKGtILPCXyUUrJWlg9SyMtDsin3aCJ5gjCTLwbtT0u2ZWpcY
	 Tea2h6en+g/cjnEHzXCHu82O3BvF1d+6Df9klzt5fMuBeJG7Wp6q4KdHykQtjZvd+s
	 EdI96J2LmGsrQ==
From: Sasha Levin <sashal@kernel.org>
To: ivanrwcm25@gmail.com,
	broonie@kernel.org,
	catalin.marinas@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64/gcs: release GCS on failed fork" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:55 -0500
Message-ID: <20261107051555-failed-6.18-078e122f3bf0@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 078e122f3bf000dd45965997b66deac10ee580fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051555-failed-6.18-078e122f3bf0@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 078e122f3bf000dd45965997b66deac10ee580fa Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Date: Wed, 28 Oct 2026 12:43:12 -0300
Subject: [PATCH] arm64/gcs: release GCS on failed fork
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/process.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8593ad10a9c48..7587cf86d9411 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -199,6 +199,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 581f80e9b9b73..42b15b0c069ff 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -320,9 +320,18 @@ static int copy_thread_gcs(struct task_struct *p,
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
@@ -341,6 +350,12 @@ void flush_thread(void)
 	flush_gcs();
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	/* Failed fork after copy_thread(); deactivate_mm() does not run. */
+	gcs_free(tsk);
+}
+
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	fpsimd_release_task(tsk);
@@ -503,6 +518,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.cpu_context.x19 = (unsigned long)args->fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
+		/* Kernel threads sharing the parent's mm must not free its GCS. */
+		gcs_reset_thread(p);
 
 		if (system_supports_poe())
 			p->thread.por_el0 = POR_EL0_INIT;
-- 
2.53.0





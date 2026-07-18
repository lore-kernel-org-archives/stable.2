Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09134F462
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387614; cv=none; b=GIm4WkktgA67WYzuZtah4sw1zLXM3LhttFb8ITzLoYKP+dkPJPRMlJE5G9CFi1GVuhB2PA0FejDiTb2z2X/zA44eRKA9vRgYrVHNXCg3PXHcgSrIVisAn2RZFwe1haMVrOB9bKZTDpB8neRElkU1pTmGj0A4QW6JzSKLf7uVkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387614; c=relaxed/simple;
	bh=PJDRd5tsyxtyt0BEH8TTcZXa9BzUkeBpZ4AsC1QU1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru7+NS83zGPINWKz0P3Njt5KhxrT7TTmNwKGFtPxsgVfZQ6Amkgu0Ho6+x/7iAeaGMmSnTkw3/Abl9pxOQmF2tAFd7GoCHRY8mS+tkMa7eKT9A/PWYxw8wdopGLAqiJiec/I/T3WBK/JHVEWU9FoNjyIuMs6WQX5cfMPk8qLbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJesfIvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJesfIvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B549C1F00A3A;
	Sat, 18 Jul 2026 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784387612;
	bh=K0cm3YBCi5g/gigINTA59oY2r573tq46vOpoca0LyqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJesfIvmjQqY2UcZNOIk7slqBaB/s7JlxOlaSg3PuAZ8K8b57ASUKj/K6xD5eI787
	 w2Qyr6Xq94qXb9TU/3y2QSBhe1O/RQ/LOXbRmkx74cGbc4SJ3pqav1oVM4bFJhZRhp
	 BXrTCpNpn6wLLg5/iBL+HZWcBuNdD0+1C5iwB5awk4+oTs5o+BHk4zDabCrPqH/kK9
	 CPnJgbAm34ABD900sSjU/wvOwl96AGZ+136KMZOTRObIO1/k4dO7/LgyUGEASeJTPt
	 prVS+GXcp6mH82sM8fl0r9f9TvmKyTr6sY8po+miGT0RRijk2l/f4YC0mhWK5/ul1T
	 nKXMlfbmBYyPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Henriette Herzog <henriette.herzog@rub.de>,
	Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
Date: Sat, 18 Jul 2026 11:13:27 -0400
Message-ID: <20260718151329.3271163-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718151329.3271163-1-sashal@kernel.org>
References: <2026071449-absurd-charm-2576@gregkh>
 <20260718151329.3271163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luis Gerhorst <luis.gerhorst@fau.de>

[ Upstream commit 03c68a0f8c68936a0bb915b030693923784724cb ]

JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier to
skip analysis/patching for the respective vulnerability. For v4, this
will reduce the number of barriers the verifier inserts. For v1, it
allows more programs to be accepted.

The primary motivation for this is to not regress unpriv BPF's
performance on ARM64 in a future commit where BPF_NOSPEC is also used
against Spectre v1.

This has the user-visible change that v1-induced rejections on
non-vulnerable PowerPC CPUs are avoided.

For now, this does not change the semantics of BPF_NOSPEC. It is still a
v4-only barrier and must not be implemented if bypass_spec_v4 is always
true for the arch. Changing it to a v1 AND v4-barrier is done in a
future commit.

As an alternative to bypass_spec_v1/v4, one could introduce NOSPEC_V1
AND NOSPEC_V4 instructions and allow backends to skip their lowering as
suggested by commit f5e81d111750 ("bpf: Introduce BPF nospec instruction
for mitigating Spectre v4"). Adding bpf_jit_bypass_spec_v1/v4() was
found to be preferable for the following reason:

* bypass_spec_v1/v4 benefits non-vulnerable CPUs: Always performing the
  same analysis (not taking into account whether the current CPU is
  vulnerable), needlessly restricts users of CPUs that are not
  vulnerable. The only use case for this would be portability-testing,
  but this can later be added easily when needed by allowing users to
  force bypass_spec_v1/v4 to false.

* Portability is still acceptable: Directly disabling the analysis
  instead of skipping the lowering of BPF_NOSPEC(_V1/V4) might allow
  programs on non-vulnerable CPUs to be accepted while the program will
  be rejected on vulnerable CPUs. With the fallback to speculation
  barriers for Spectre v1 implemented in a future commit, this will only
  affect programs that do variable stack-accesses or are very complex.

For PowerPC, the SEC_FTR checking in bpf_jit_bypass_spec_v4() is based
on the check that was previously located in the BPF_NOSPEC case.

For LoongArch, it would likely be safe to set both
bpf_jit_bypass_spec_v1() and _v4() according to
commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip speculation
barrier opcode"). This is omitted here as I am unable to do any testing
for LoongArch.

Hari's ack concerns the PowerPC part only.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Cc: Henriette Herzog <henriette.herzog@rub.de>
Cc: Maximilian Ott <ott@cs.fau.de>
Cc: Milan Stephan <milan.stephan@fau.de>
Link: https://lore.kernel.org/r/20250603211318.337474-1-luis.gerhorst@fau.de
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 2f884d371faf ("bpf: Allow LPM map access from sleepable BPF programs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c     | 21 ++++++++++++---------
 arch/powerpc/net/bpf_jit_comp64.c | 21 +++++++++++++++++----
 include/linux/bpf.h               | 11 +++++++++--
 kernel/bpf/core.c                 | 15 +++++++++++++++
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c852749405e0c7..907bcc64d42435 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1558,15 +1558,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 
 	/* speculation barrier */
 	case BPF_ST | BPF_NOSPEC:
-		/*
-		 * Nothing required here.
-		 *
-		 * In case of arm64, we rely on the firmware mitigation of
-		 * Speculative Store Bypass as controlled via the ssbd kernel
-		 * parameter. Whenever the mitigation is enabled, it works
-		 * for all of the kernel code with no need to provide any
-		 * additional instructions.
-		 */
+		/* See bpf_jit_bypass_spec_v4() */
 		break;
 
 	/* ST: *(size *)(dst + off) = imm */
@@ -2730,6 +2722,17 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_bypass_spec_v4(void)
+{
+	/* In case of arm64, we rely on the firmware mitigation of Speculative
+	 * Store Bypass as controlled via the ssbd kernel parameter. Whenever
+	 * the mitigation is enabled, it works for all of the kernel code with
+	 * no need to provide any additional instructions. Therefore, skip
+	 * inserting nospec insns against Spectre v4.
+	 */
+	return true;
+}
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index af8b07cc5fcbf1..5a51476ec92828 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -440,6 +440,23 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	return 0;
 }
 
+bool bpf_jit_bypass_spec_v1(void)
+{
+#if defined(CONFIG_PPC_E500) || defined(CONFIG_PPC_BOOK3S_64)
+	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR));
+#else
+	return true;
+#endif
+}
+
+bool bpf_jit_bypass_spec_v4(void)
+{
+	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_STF_BARRIER) &&
+		 stf_barrier_type_get() != STF_BARRIER_NONE);
+}
+
 /*
  * We spill into the redzone always, even if the bpf program has its own stackframe.
  * Offsets hardcoded based on BPF_PPC_STACK_SAVE -- see bpf_jit_stack_local()
@@ -864,10 +881,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * BPF_ST NOSPEC (speculation barrier)
 		 */
 		case BPF_ST | BPF_NOSPEC:
-			if (!security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) ||
-					!security_ftr_enabled(SEC_FTR_STF_BARRIER))
-				break;
-
 			switch (stf_barrier) {
 			case STF_BARRIER_EIEIO:
 				EMIT(PPC_RAW_EIEIO() | 0x02000000);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e8d9803cc6756f..c2d03364168f54 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2216,6 +2216,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	return ret;
 }
 
+bool bpf_jit_bypass_spec_v1(void);
+bool bpf_jit_bypass_spec_v4(void);
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -2386,12 +2389,16 @@ static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 
 static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
+	return bpf_jit_bypass_spec_v1() ||
+		cpu_mitigations_off() ||
+		bpf_token_capable(token, CAP_PERFMON);
 }
 
 static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
+	return bpf_jit_bypass_spec_v4() ||
+		cpu_mitigations_off() ||
+		bpf_token_capable(token, CAP_PERFMON);
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 517710c89fa505..00e42c9598fae1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3032,6 +3032,21 @@ bool __weak bpf_jit_needs_zext(void)
 	return false;
 }
 
+/* By default, enable the verifier's mitigations against Spectre v1 and v4 for
+ * all archs. The value returned must not change at runtime as there is
+ * currently no support for reloading programs that were loaded without
+ * mitigations.
+ */
+bool __weak bpf_jit_bypass_spec_v1(void)
+{
+	return false;
+}
+
+bool __weak bpf_jit_bypass_spec_v4(void)
+{
+	return false;
+}
+
 /* Return true if the JIT inlines the call to the helper corresponding to
  * the imm.
  *
-- 
2.53.0


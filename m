Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA51632DD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238653; cv=none; b=vD2eYdS63tOraZIYInWtzzn+Ku8RsNdTtUMfxDdOmpZ/6ib4CPVbfbFoMOZ3YIBYHhJWVoyMtqlSRGHEflhS6mmgxN9+VwjHeNo89ZSbOYUlofXuwO1j1N23TPoijv1yL/SdvZcImaGGj6Gqfd9nkLFBl84GvZH7b+tTOtYdq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238653; c=relaxed/simple;
	bh=XWuUTIIcpZE+dwyZGjAtfyRFnc+Fb7ItuXklFQNNLMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kn/ArY216XCm7FjnRt9HXIyTwUJskg7krRjRW8zLTzMgAXig9XzljE+tde0uBtep2Gc5iIqDQ/HtM6bIKzzpn36wswd7THeBCf6dzVB+NBA+F571Q0+RlOJN2kmZ3+E7amMEOWFMmKEzy/N3/YQD2ErVF3A28h/ljPBB2zidWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQxkBlnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQxkBlnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBFC1F00893;
	Mon,  5 Oct 2026 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238651;
	bh=MVcG0L1U0+dGb97Tb8JgfBEmTk2scNqXiB13jpNsb8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQxkBlnxmW2qZ6y10iTOz3iQgY+FRicFDAhiYhe9c6zQf2XnVuxxKUiQ51d1d8xz+
	 9R09wUiLQB7q4BQPGbrKZG3GAoJy+jZPuw46HElLOblxidAkBSbHM/O0D1RWxvXdvJ
	 u7PP5DNJ8waWYHl9P6fF4ORpZcX9cyOEkm0s9FltPZhyAguP3XiHCCstoGMwTKlQPt
	 XWu5rPPx0dYegqlRcIlIVOEsJGs0M0ZbDjpQfZlha3LmuKh4PzF2K8Wh5u/PWtmN+I
	 WlyAI2zeUpspj49qydJr9WKC7pGZYnwc9/MvrEB7+Ayezc8CrfnsrOj2Y17qxoqJJ1
	 6wNVtJS6i7bNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] arm64/fpsimd: signal: Consistently read FPSIMD context
Date: Mon,  5 Oct 2026 18:17:26 -0400
Message-ID: <20261005221636.3436132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-amigo-discolor-973f@gregkh>
References: <2026100534-amigo-discolor-973f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit be625d803c3bbfa9652697eb57589fe6f2f24b89 ]

For historical reasons, restore_sve_fpsimd_context() has an open-coded
copy of the logic from read_fpsimd_context(), which is used to either
restore an FPSIMD-only context, or to merge FPSIMD state into an
SVE state when restoring an SVE+FPSIMD context. The logic is *almost*
identical.

Refactor the logic to avoid duplication and make this clearer.

This comes with two functional changes that I do not believe will be
problematic in practice:

* The user_fpsimd_state::size field will be checked in all restore paths
  that consume it user_fpsimd_state. The kernel always populates this
  field when delivering a signal, and so this should contain the
  expected value unless it has been corrupted.

* If a read of user_fpsimd_state fails, we will return early without
  modifying TIF_SVE, the saved SVCR, or the save fp_type. This will
  leave the task in a consistent state, without potentially resurrecting
  stale FPSIMD state. A read of user_fpsimd_state should never fail
  unless the structure has been corrupted or the stack has been
  unmapped.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250508132644.1395904-5-mark.rutland@arm.com
[will: Ensure read_fpsimd_context() returns negative error code or zero]
Signed-off-by: Will Deacon <will@kernel.org>

Route header-only non-streaming SVE contexts through the existing
FPSIMD restore path so that the FPSIMD context size is checked and user
reads complete before the task's FPSIMD state flags are changed. Clear
saved streaming mode in that path to preserve the state transition
previously performed by the SVE restore path.

Retain the inline register reads in the existing restore functions instead
of extracting a new helper. Check the FPSIMD context size in the SVE
payload path as well, and return read errors before updating the hardware
registers.

Include the streaming-mode flag handling and payload requirement expected
by the subsequent SME-only signal-context validation fix. A streaming SVE
context without a payload must fail validation rather than fall back to
FPSIMD-only restoration.

Stable-dep-of: e060d9069b49 ("arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/signal.c | 48 ++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f7b05267a76b2..59d9e7fca936a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -265,7 +265,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 static int restore_fpsimd_context(struct user_ctxs *user)
 {
 	struct user_fpsimd_state fpsimd;
-	int err = 0;
+	int err;
 
 	/* check the size information */
 	if (user->fpsimd_size != sizeof(struct fpsimd_context))
@@ -276,15 +276,16 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 			       sizeof(fpsimd.vregs));
 	__get_user_error(fpsimd.fpsr, &(user->fpsimd->fpsr), err);
 	__get_user_error(fpsimd.fpcr, &(user->fpsimd->fpcr), err);
+	if (err)
+		return -EFAULT;
 
 	clear_thread_flag(TIF_SVE);
+	current->thread.svcr &= ~SVCR_SM_MASK;
 	current->thread.fp_type = FP_STATE_FPSIMD;
 
 	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
-
-	return err ? -EFAULT : 0;
+	fpsimd_update_current_state(&fpsimd);
+	return 0;
 }
 
 static int preserve_fpmr_context(struct fpmr_context __user *ctx)
@@ -391,6 +392,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
 	u16 user_vl, flags;
+	bool sm;
 
 	if (user->sve_size < sizeof(*user->sve))
 		return -EINVAL;
@@ -400,7 +402,8 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return err;
 
-	if (flags & SVE_SIG_FLAG_SM) {
+	sm = flags & SVE_SIG_FLAG_SM;
+	if (sm) {
 		if (!system_supports_sme())
 			return -EINVAL;
 
@@ -420,12 +423,17 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (user_vl != vl)
 		return -EINVAL;
 
-	if (user->sve_size == sizeof(*user->sve)) {
-		clear_thread_flag(TIF_SVE);
-		current->thread.svcr &= ~SVCR_SM_MASK;
-		current->thread.fp_type = FP_STATE_FPSIMD;
-		goto fpsimd_only;
-	}
+	/*
+	 * Non-streaming SVE state may be preserved without an SVE payload, in
+	 * which case the SVE context only has a header with VL==0, and all
+	 * state can be restored from the FPSIMD context.
+	 *
+	 * Streaming SVE state is always preserved with an SVE payload. For
+	 * consistency and robustness, reject restoring streaming SVE state
+	 * without an SVE payload.
+	 */
+	if (!sm && user->sve_size == sizeof(*user->sve))
+		return restore_fpsimd_context(user);
 
 	vq = sve_vq_from_vl(vl);
 
@@ -455,25 +463,29 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return -EFAULT;
 
-	if (flags & SVE_SIG_FLAG_SM)
+	if (sm)
 		current->thread.svcr |= SVCR_SM_MASK;
 	else
 		set_thread_flag(TIF_SVE);
 	current->thread.fp_type = FP_STATE_SVE;
 
-fpsimd_only:
+	/* check the size information */
+	if (user->fpsimd_size != sizeof(struct fpsimd_context))
+		return -EINVAL;
+
 	/* copy the FP and status/control registers */
 	/* restore_sigframe() already checked that user->fpsimd != NULL. */
 	err = __copy_from_user(fpsimd.vregs, user->fpsimd->vregs,
 			       sizeof(fpsimd.vregs));
 	__get_user_error(fpsimd.fpsr, &user->fpsimd->fpsr, err);
 	__get_user_error(fpsimd.fpcr, &user->fpsimd->fpcr, err);
+	if (err)
+		return -EFAULT;
 
-	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
+	/* Merge the FPSIMD registers into the SVE state */
+	fpsimd_update_current_state(&fpsimd);
 
-	return err ? -EFAULT : 0;
+	return 0;
 }
 
 #else /* ! CONFIG_ARM64_SVE */
-- 
2.53.0


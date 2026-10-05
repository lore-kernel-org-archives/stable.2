Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10ED1632DD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238655; cv=none; b=Ke3kmIJHC+o5nxzUozfS9/rnS8G9knNhbLy6YPmvG6huHoue32AP5mjcmlw/KVPOWyDGELvMdTZARGyLP5naNDXMOHV+Pbx6oEyNQVS6KJIn1CuR94LG1qy2B26ZfHs1sFV/Tf+c7CdOzjVNEpGi57cks/R7vXIKfjk3sh4fsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238655; c=relaxed/simple;
	bh=HtlWRYVx55XPFHLaXNC15T5DQTTXKW1alDum9H22kq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqYY/fJ3Ngm1wsfgq8dKtV/ybjZmF4go7Wc6A3y2lJpbJR1QBslTv6iqgEqnwx+Qsg7A1s+x5brPD3Q9UkGXDLRtAbWlgmvLmgB67PLaY+aLZGy0qwQZyulV995XXk3CuYNB784Bw4Qber55K9LG6u4iEfkaopwCXexCP418x3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD7p8ty/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD7p8ty/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E41F000FF;
	Mon,  5 Oct 2026 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238653;
	bh=ay/hSsIOHUUHzoqB4jU5UFFQOkfAQ5cWtSi7HWbeayY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UD7p8ty/AhRW0Lj8hFPhvbUox3Njmn3rCR3mwFZTM25xe0aIloUU4CVa36RfumceT
	 LAFFTiGl9VP3OGGtk1AfbpLTywOGumaq3Eb7hMHrcZi5IRsqz5OGAc5oufbs6Gufmb
	 uCLcRVHcT3sH+k7LJ3ve3XJbsywnIrmEtrrZdn6ZkQkvNoqzFG+bUrUuppFjw5TKbd
	 1LGqFVhavbuuI9KJj1y/Vb9W5X2cKk290kr5ufjF7qs5br8fkPsvkN2nMkUpOkgSZT
	 puYYTkQBMqpOlgf4FR8Jwi5mPfi/bDsZVPRqL+daozsHro66rFU7svP+YL0pJD+Ogt
	 e8CdWdDAx5Qzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems
Date: Mon,  5 Oct 2026 18:17:27 -0400
Message-ID: <20261005221636.3436132-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005221636.3436132-1-sashal@kernel.org>
References: <2026100534-amigo-discolor-973f@gregkh>
 <20261005221636.3436132-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit e060d9069b49fe55f38057dfe592068014652671 ]

When system_supports_sme() is true but system_supports_sve() is false,
restoring a specifically crafted SVE signal context can result in the
task erroneously having non-streaming SVE state. Subsequent attempts to
manipulate the task's FPSIMD/SVE/SME state can result in a variety of
problems, including fatal EL1 UNDEFs.

In such configurations, the kernel always creates an SVE signal context
when delivering a signal, and this can only be in one of two states:

(1) SVE_SIG_FLAG_SM is set, and an SVE payload is present containing
    streaming mode SVE state. The recorded VL is the task's live
    streaming VL.

(2) SVE_SIG_FLAG_SM is clear, and an SVE payload is not present. The
    FPSIMD context contains the non-streaming mode FPSIMD state. The
    recorded VL is 0.

Currently restore_sve_fpsimd_context() correctly rejects cases where
SVE_SIG_FLAG_SM is set and an SVE payload is not present, but fails to
reject cases where SVE_SIG_FLAG_SM is clear and an SVE payload is
present. Consequently, restore_sve_fpsimd_context() can place the task
in a state where it has non-streaming SVE state even when this is not
supported by HW.

For example, this can cause a later EL1 UNDEF when the kernel attempts to
restore the task's ZCR_EL1 value:

| # ./sme-sigcontext-to-sve
| Internal error: Oops - Undefined instruction: 0000000002000000 [#1]  SMP
| Modules linked in:
| CPU: 0 UID: 0 PID: 131 Comm: sme-sigcontext- Not tainted 7.3.0-rc1 #1 PREEMPT
| Hardware name: linux,dummy-virt (DT)
| pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : fpsimd_restore_current_state+0x258/0x458
| lr : exit_to_user_mode_loop+0xb8/0x188
| sp : ffff80008056be40
| x29: ffff80008056be40 x28: fff00000c1670000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80008056bec0 x22: 0000000000000008 x21: 0000000000000040
| x20: 0000000000000081 x19: 0000000008800010 x18: 0000000000000000
| x17: 0000fffffd412570 x16: 0000000000001000 x15: 0000fffffd4123b0
| x14: 0000fffffd412780 x13: 0000fffffd412be8 x12: 0000000047435300
| x11: 0000fffffd412570 x10: 0000000000000000 x9 : 0000000045585401
| x8 : fff00000c18a6c44 x7 : 0000000000000000 x6 : 0000000000000002
| x5 : 0000000000000002 x4 : ffff800080568000 x3 : 0000000000000001
| x2 : 0000000008800010 x1 : fff00000c1670000 x0 : 0000000008800000
| Call trace:
|  fpsimd_restore_current_state+0x258/0x458 (P)
|  exit_to_user_mode_loop+0xb8/0x188
|  el0_svc+0x1cc/0x1d0
|  el0t_64_sync_handler+0xa0/0xe4
|  el0t_64_sync+0x198/0x19c
| Code: d5384101 f9400020 53175c03 36b80de0 (d5381202)
| ---[ end trace 0000000000000000 ]---
| Kernel panic - not syncing: Oops - Undefined instruction: Fatal exception in interrupt
| Kernel Offset: 0x291fb1000000 from 0xffff800080000000
| PHYS_OFFSET: 0x40000000
| CPU features: 0x0,00000000,0052802f,ffb88f43,3afcf73f
| Memory Limit: none

Rework restore_sve_fpsimd_context() to reject cases where
SVE_SIG_FLAG_SM is clear and an SVE payload is not present. As
parse_user_sigframe() rejects SVE signal frames when neither SVE nor SME
are supported, it isn't necessary for restore_sve_fpsimd_context() to
handle the case where neither are supported.

Fixes: 7dde62f0687c  ("arm64/signal: Always accept SVE signal frames on SME only systems")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/signal.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 59d9e7fca936a..13f4a95ca2315 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -392,6 +392,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	unsigned int vl, vq;
 	struct user_fpsimd_state fpsimd;
 	u16 user_vl, flags;
+	bool fpsimd_only;
 	bool sm;
 
 	if (user->sve_size < sizeof(*user->sve))
@@ -402,19 +403,33 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (err)
 		return err;
 
+	fpsimd_only = (user->sve_size == sizeof(*user->sve));
 	sm = flags & SVE_SIG_FLAG_SM;
+
 	if (sm) {
 		if (!system_supports_sme())
 			return -EINVAL;
 
+		/*
+		 * Streaming SVE state is always preserved with an SVE payload.
+		 * Only accept streaming state which has an SVE payload.
+		 */
+		if (fpsimd_only)
+			return -EINVAL;
+
 		vl = task_get_sme_vl(current);
 	} else {
 		/*
-		 * A SME only system use SVE for streaming mode so can
-		 * have a SVE formatted context with a zero VL and no
-		 * payload data.
+		 * Non-streaming SVE state may be preserved without an SVE
+		 * payload, in which case all state is saved in the FPSIMD
+		 * context.
+		 *
+		 * On SME-only systems, non-streaming (FPSIMD-only) state is
+		 * always preserved without an SVE payload, and with VL==0. On
+		 * such systems, only accept non-streaming state without an SVE
+		 * payload.
 		 */
-		if (!system_supports_sve() && !system_supports_sme())
+		if (!system_supports_sve() && !fpsimd_only)
 			return -EINVAL;
 
 		vl = task_get_sve_vl(current);
@@ -423,16 +438,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (user_vl != vl)
 		return -EINVAL;
 
-	/*
-	 * Non-streaming SVE state may be preserved without an SVE payload, in
-	 * which case the SVE context only has a header with VL==0, and all
-	 * state can be restored from the FPSIMD context.
-	 *
-	 * Streaming SVE state is always preserved with an SVE payload. For
-	 * consistency and robustness, reject restoring streaming SVE state
-	 * without an SVE payload.
-	 */
-	if (!sm && user->sve_size == sizeof(*user->sve))
+	if (fpsimd_only)
 		return restore_fpsimd_context(user);
 
 	vq = sve_vq_from_vl(vl);
-- 
2.53.0


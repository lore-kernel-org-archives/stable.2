Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BF2DA749
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560542; cv=none; b=sGVQBXcLfw2nMW6sukPiysITKdI8nrhfRM8X2zMCzIOJN2Fb6bBr3O//hG4xkGyt5bNN9Glf+paqvlLUH+7gdt15ri3MHyys752vK9/JGdTsvaMby+CB7rYVyKAJc6ULSHsR9Ir640GEDV//ay8dH3QR8SK7W2nxiME8PVG8YfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560542; c=relaxed/simple;
	bh=kVgcz3rBCPtryI6d8HiZEcGZ6yL6CFkxECZJfSsgwf4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lqeSVHEuMoXxx2AbLsT0Zj25G5kw64nO9KI9dSxRZNMkNhNN6Pxu80jj8biZawKYvSm6WyWXdCbdmoin872SogcI1Q7oqg+HyK9MQpZBykNHyqppcJHZQE1DuQ+lhkcEOKT0gvSyxegRSh2uxPIiLs0ZXKVLyhOz8lZthqYK8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZxCLFoAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZxCLFoAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DD11F000E9;
	Mon, 20 Jul 2026 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560541;
	bh=ph8PXCh6yX5mpoKNyInGaRCmbPMofJC610lnrH8dS3w=;
	h=Subject:To:Cc:From:Date;
	b=ZxCLFoAZQPm3rChpMnDCMwZBP7mGoirJHa1LF/C6r5XAeAcet866NcW1bJ+s8NCLp
	 UX2m8kuz6fVLwBa034X6Us72CQyw/G6ptqdEVmkseI/sIltpwSoJHJ+riyT7w0V1SE
	 Rxz5bwIip+eCOllV5oDLFjrrDcnZFFj0CL8ARALg=
Subject: FAILED: patch "[PATCH] bpf: Reset register bounds before narrowing retval range in" failed to apply to 6.12-stable tree
To: tristan@talencesecurity.com,ast@kernel.org,eddyz87@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:15:11 +0200
Message-ID: <2026072011-poach-marina-ef6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5e0b273e0a62cc04ec338c7b502797c66c2ed42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072011-poach-marina-ef6e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e0b273e0a62cc04ec338c7b502797c66c2ed42a Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Mon, 22 Jun 2026 23:01:22 +0000
Subject: [PATCH] bpf: Reset register bounds before narrowing retval range in
 check_mem_access()

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260622230123.3695446-2-tristmd@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2b348f98080..21a365d436a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6201,6 +6201,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)


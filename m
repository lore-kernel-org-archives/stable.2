Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116752EEE73
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263683; cv=none; b=YvYhCSVMWa/t/VP8uUhlBFWFR6Y/MDqRcnvxxhQxoZCiKrTbhL3ejI3rBcMCae2PjTiK/NNKFBJ5l1gAZ9l5iqPUoIfBsqHI+wG5m87GrBqmiT6mIIA8PvT9BgN4I/SrKz8s28Xusb0WF/ebDtD9f4pxmc1jOz2ZRQtYWqQ0Xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263683; c=relaxed/simple;
	bh=21qpONp5GiYMOsGB6QEeDD/jAVfYAtzReSx/0vCIy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+HkEzDcrrNNmeZPjcZSWT3MFkF38BB2akbVfnx5DBFLlN2r07MfmAp3d5jyeAuv+JzCQVjNd9OYegRApSWYpgivthqaI/+xcs1PVxIxMRfVtdvujcTUuyTTnAY7Bb2c034eQ53aLSAleTFFLvLzhwhwU3v+pMxZXPZKZgBF1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+ux7Wsf; arc=none smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+ux7Wsf"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-698447ea5aeso3866063a12.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263680; x=1784868480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jl9U9nMuaI7f/0zWnVu/LVhBlsqXAL2CUYCsrYnW834=;
        b=P+ux7WsfY1d0xAMpmnIqI0WmMh0MmM9jjAfP5om2abNcKOYCNscdFfdez/ONww841a
         GfsTPSid9WGyOkOE1mqlRsDtmlO8wbqu3quytfvSpXNfPjYf/n8kAcBU/Yz39uQ15sRo
         ILD36XlmHaKVp0H1CdI7+KIh6u7VK+NPokg1roS19VctPTMT6kq/zz01PAQt/2RxD5Rc
         jQCOiAGHTf2+cmA6/SlXx5e/YaprAEIVyPclWoaXd6jYe+z1rIakEbaukgvlSx92n0Ip
         njf1JFkil8g8nTD/XTNoVbgGfIMUDHMWlXcODFUeacHFF8yuIZWFfgRehcYtVSS26WzY
         zAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263680; x=1784868480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jl9U9nMuaI7f/0zWnVu/LVhBlsqXAL2CUYCsrYnW834=;
        b=Vbekt8VNZWsRWNYwW9yVl7hLBjvrhQqF0PoX92kOt6vdkc4rG3RWOnCdEJxtWhIsh7
         5PpdMeH2VnYZVu/TSVS8D4n8Iru0Y3SfxUl4yg0DPtCmQbEjFESqtNGuP93GB5w0m10W
         a5DNvA0+XaeUzWpqWipw2I3DvJb21hAPvUR9FukAji1VxnT6mFvONAS/Y2sjDIgD+0v5
         xwGMY0wcFoAHCzaiCjJGUloVkPpZ9FTATndRj9Gov9B3dt8QIjUhfIn3J2E/Ni1Uc2Fi
         nhpZEJbtcual/Hcwie9bNHOw7Agrp0hFcaiLc+PRVgf33tidEEVTA+GUHH2gdfuH5Sue
         Zasg==
X-Gm-Message-State: AOJu0Yz6ISoq+CMmstBMoXjv5Gp+dcYNggZ7jtNs+RBRmxjhRavtO1Gy
	8i5DTDF9IyOlySEk6xbQbFl9JtmiYXNpnacU7jtxzTDJPcRJ0jH7DH2LDpD2I2imd8R4I4kXVIy
	Sby9dGh54i28q
X-Gm-Gg: AfdE7clYsIJ1J9CxWVTBHLXOhvmarR4EcDh0zkaLPCyjbP9QKpS0uws76yqDqyTAuEt
	BY19ITNt0P0Fd/qN7QNxwQlEsqiudwfPayvkmM8LsPxVoDeiv8PJzHXJ2mc7Y8tbDgv7/+ivI3P
	LmdIKKS8JlgophPjrKoneCzMTflYMw7akl4Fv+6xsQyJy1LAlxpGXyg+Z2a447I0i23qsGFEHRl
	ifQ8aKw7oWpisPGUpO8biR2U4fU4NCVtXIarCQnGsAIG9X9r3P9R+dKF/ouuLpjMVASZ6iZ9ABj
	DOFlQ3KgLZICQ08Xp4D5b3AXqsBv9sv5oaIfkONiCTkExsbQcWEfWY+H8P2rjcfGEZ+UFK3IqXW
	h86YBPuOczKylaBOR5ddji1OMmS0+QzA4AMvahiQzc2LVxgUi9uYDNDf6PR/Xau07l+dKWFr3Wk
	a9WYrV87yADj8r2bFF5jj4jTbEL+g9Lgc=
X-Received: by 2002:a17:907:1b13:b0:c12:d971:1c1d with SMTP id a640c23a62f3a-c16b4837dc7mr29346066b.45.1784263680172;
        Thu, 16 Jul 2026 21:48:00 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3e0sm222899b3a.43.2026.07.16.21.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:47:58 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 4/6] bpf: Clear delta when clearing reg id for non-{add,sub} ops
Date: Fri, 17 Jul 2026 12:47:27 +0800
Message-ID: <20260717044731.121353-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044731.121353-1-shung-hsi.yu@suse.com>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 1b327732c84640c1e3da487eefe9d00cc9f2dd34 upstream.

When a non-{add,sub} alu op such as xor is performed on a scalar
register that previously had a BPF_ADD_CONST delta, the else path
in adjust_reg_min_max_vals() only clears dst_reg->id but leaves
dst_reg->delta unchanged.

This stale delta can propagate via assign_scalar_id_before_mov()
when the register is later used in a mov. It gets a fresh id but
keeps the stale delta from the old (now-cleared) BPF_ADD_CONST.
This stale delta can later propagate leading to a verifier-vs-
runtime value mismatch.

The clear_id label already correctly clears both delta and id.
Make the else path consistent by also zeroing the delta when id
is cleared. More generally, this introduces a helper clear_scalar_id()
which internally takes care of zeroing. There are various other
locations in the verifier where only the id is cleared. By using
the helper we catch all current and future locations.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: `delta` field was called `off` before commit 3d91c618aca4 ("bpf:
rename bpf_reg_state->off to bpf_reg_state->delta"), and clear_singular_ids()
does not exists before commit b2a0aa3a8739 ("bpf: Clear singular ids for
scalars in is_state_visited()")]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dcf591acd50..bf8cadd19593 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5013,27 +5013,30 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+static void clear_scalar_id(struct bpf_reg_state *reg)
+{
+	reg->id = 0;
+	reg->off = 0;
+}
+
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
 	if (src_reg->type != SCALAR_VALUE)
 		return;
-
-	if (src_reg->id & BPF_ADD_CONST) {
-		/*
-		 * The verifier is processing rX = rY insn and
-		 * rY->id has special linked register already.
-		 * Cleared it, since multiple rX += const are not supported.
-		 */
-		src_reg->id = 0;
-		src_reg->off = 0;
-	}
-
+	/*
+	 * The verifier is processing rX = rY insn and
+	 * rY->id has special linked register already.
+	 * Cleared it, since multiple rX += const are not supported.
+	 */
+	if (src_reg->id & BPF_ADD_CONST)
+		clear_scalar_id(src_reg);
+	/*
+	 * Ensure that src_reg has a valid ID that will be copied to
+	 * dst_reg and then will be used by sync_linked_regs() to
+	 * propagate min/max range.
+	 */
 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
-		/* Ensure that src_reg has a valid ID that will be copied to
-		 * dst_reg and then will be used by sync_linked_regs() to
-		 * propagate min/max range.
-		 */
 		src_reg->id = ++env->id_gen;
 }
 
@@ -5466,7 +5469,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 * coerce_reg_to_size will adjust the boundaries.
 				 */
 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					state->regs[dst_regno].id = 0;
+					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -15476,7 +15479,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	 * any existing ties and avoid incorrect bounds propagation.
 	 */
 	if (need_bswap || insn->imm == 16 || insn->imm == 32)
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 
 	if (need_bswap) {
 		if (insn->imm == 16)
@@ -15845,8 +15848,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * we cannot accumulate another val into rx->off.
 			 */
 clear_id:
-			dst_reg->off = 0;
-			dst_reg->id = 0;
+			clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
 				dst_reg->id |= BPF_ADD_CONST32;
@@ -15859,7 +15861,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
 		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 	}
 	return 0;
 }
@@ -15990,7 +15992,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
@@ -16016,7 +16018,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -16026,7 +16028,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
@@ -16856,7 +16858,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 		e->is_reg = is_reg;
 		e->regno = spi_or_reg;
 	} else {
-		reg->id = 0;
+		clear_scalar_id(reg);
 	}
 }
 
-- 
2.54.0


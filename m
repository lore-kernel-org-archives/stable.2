Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D539EB47
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040881; cv=none; b=Qb+BfIGzI8ndt/C/l8zzrGYcUTcF2HE+oj0q8/8ldrcjVfXO1p+BZRpml96NecYEOzBs8CCPBur1XIYy5uzNIJL/2H+jjFhH9hp5bWqK6v0NzZb2Fgl83KXo2jnUnuMNJtbhKJLOXu9WpiQx8ryO+PVLHZOhA4fOrkZU/cWF4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040881; c=relaxed/simple;
	bh=gOfqvfcaBfUegwgi53QMffIYNK8wRK8rOY0Pwj8EoF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0rCDQ07sRGak0O9/n0ElRmvlzAtT8X0pHp7yNIK1/e0CJQdVbequArUpCt0skDYi5TQDDyAUrbQ5WnvCUIvkuCB3WcuWVjtKsLv5Y/yMufJ9VImq7Buyt7sjgQKSyxAGCJ0vQxBjVXDOamHuPappHhp2XyWmXxe2JWTsuP2hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QmIlNVd0; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QmIlNVd0"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so18889575e9.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787040878; x=1787645678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAe3EyE5yp/fepJWO36UIb2SLqa/osz3kekJke6xxDo=;
        b=QmIlNVd0rWXJnnUEnqNbpa00Xfuzotn6e7uE+FF75Nr0sCMq62AJiH1nDtslzWAviy
         gaYSFw0Ejb6bA0pJaFEsbmhtS491olJmluhf3MMYmme1xJ4LuKgf6YJ24/4TGnDSn1A5
         H4T3ysTDobr1xrz0NkQwHLmPTyCti0RypEy9oFRZR+3QdYnqYB0Hz9r1T5qKC5+7iARM
         9ZcS42oNH9YQE/JGncZzodNH6TVKEsu/U6fVvxLMiOJDwTs+VjuzZl8q1ryzMrRYhuoU
         qjexqgQp5wyLcSbVNQa3QwhunUpAjNyjc886zZbML7obmdS/jVcFzWb86c6AeBilEUQX
         N1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040878; x=1787645678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAe3EyE5yp/fepJWO36UIb2SLqa/osz3kekJke6xxDo=;
        b=M5Bte7YOy5Qc5ZZATCSuKqh226/FUhpM01kuo73mj006GzdMK2YeZjK/3H6EaYzK+i
         9YuozaBmXB/4Pt9MO9G4HL2M+KmSstMQ3zNo0qGJJOr7D3XpZDs9RvWaQswDxWSiUqDZ
         iprCCn9ON0eFQ8/5CkLBMfClg3yNAyvR7HW494RIJasTcSuEzrlEW3uYMg7iTdNsSb4v
         7TULQl2/3PFqtuHtV/6UgCFC+0FT/VOsFyZHMjZD+oas3PTjKzsnSi0t42eeIWbiOzol
         bVU/LOljgQLP2I/7OOPM0VT/B3k+N7B+2h9+/XHlCHNrmWm4TTf0isCrKRRrV2MBSIlD
         ZGuA==
X-Gm-Message-State: AOJu0YwpqZ8LdExU4mEdI3fLV1j9NY1uTJr0CzAh4JbwoZ1OwwKC+uc6
	5UBFvmyXrJuxTQNJyOgCSy1e1dDH9Sfd3mfi4lZYlzc7jeh5ID5LTf+oYeh2VMT9UVfcf+1p6aZ
	BzTGD8JUnbkFN
X-Gm-Gg: AR+sD13DBRv/u66F9CANvEUkmIg8+AyREcUDqIGQxSKHfT5onVsvquFVyQP0iltHfsA
	7RV7UVY6g+YutiyJF1+Aiw3FXgcx7xRAWSTpeLxWlCJ9XYIZsua4FGbZ3k+NHbbNZLuhd2YoNqM
	IGywgkiMcihnU9wQ+fKE6XuE2B2iDqXTj+cdEJUqnj5TP1A5S+Gct3CXfhhYRZzNu4QJ7KICpxP
	yH6LjOQLuDVVrW6YDJP6yodMYXEs3g9iIvbrMG57MWKj62O6dBz96nGwAYrmvvmVIrcD1FRcjtJ
	GHY5xD2F7YRZoBQZMfpiqYcGllTqymSk0UFkGfnRLTZ/AUou0Dr4+tU1Syr79q4NKnOIZsabafQ
	3Qa9U2Qda3KAiAXWEWnuLBg5q4u1Lo7ri0H5WHOTSvwl4Zz+n4cHlloFArVqlYEE2a8JWCctuuD
	80wLdvHglRhXuM6E3uh5lLwtx5Hh6PEjj6X8WPWt2lW8jEfMQ+atCSSkqEF7XiGs3WLDv2jjno4
	jTOtIrFrjx2Sj7nRQ==
X-Received: by 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-4998ae1bb69mr391080785e9.12.1787040878062;
        Tue, 18 Aug 2026 01:14:38 -0700 (PDT)
Received: from localhost (27-240-49-235.adsl.fetnet.net. [27.240.49.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b40basm5247299a91.14.2026.08.18.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:14:37 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 2/4] bpf: Clear delta when clearing reg id for non-{add,sub} ops
Date: Tue, 18 Aug 2026 16:14:20 +0800
Message-ID: <20260818081428.57938-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818081428.57938-1-shung-hsi.yu@suse.com>
References: <20260818081428.57938-1-shung-hsi.yu@suse.com>
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
[shung-hsi.yu:
 - reverse 'off' -> 'delta' renaming done later in commit 3d91c618aca4 ("bpf:
   rename bpf_reg_state->off to bpf_reg_state->delta")
 - kept "dst_reg->live |= REG_LIVE_WRITTEN", which got removed in commit
   107e16979905 ("bpf: disable and remove registers chain based liveness")
 - dropped hunk in scalar_byte_swap(), which was added later in commit
   9d2119984224 ("bpf: Add bitwise tracking for BPF_END")
 - dropped hunk in clear_singular_ids(), which was added later in commit
   b2a0aa3a8739 ("bpf: Clear singular ids for scalars in is_state_visited()")]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 48 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb84924799a4..c77df8654111 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4635,27 +4635,30 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
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
 
@@ -5093,7 +5096,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 * coerce_reg_to_size will adjust the boundaries.
 				 */
 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					state->regs[dst_regno].id = 0;
+					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -14554,8 +14557,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
 			 */
-			dst_reg->off = 0;
-			dst_reg->id = 0;
+			clear_scalar_id(dst_reg);
 		} else {
 			dst_reg->id |= BPF_ADD_CONST;
 			dst_reg->off = val;
@@ -14565,7 +14567,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
 		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 	}
 	return 0;
 }
@@ -14689,7 +14691,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
@@ -14716,7 +14718,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
@@ -14727,7 +14729,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->live |= REG_LIVE_WRITTEN;
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
@@ -15558,7 +15560,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 		e->is_reg = is_reg;
 		e->regno = spi_or_reg;
 	} else {
-		reg->id = 0;
+		clear_scalar_id(reg);
 	}
 }
 
-- 
2.55.0


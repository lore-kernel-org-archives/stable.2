Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC2F7EFE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.210.215.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760031; cv=none; b=kdEll7di7UfXAJjTFBiuj0hJawsf/PHhRkulIAC2fD/wrgNQaJiVzp2PV3G0SLggpScdXSG71ppLlQdzvyF38M+5Rd1tej45PJ7NgVGdU8AX+QTkaZcisuQGfoc7ZgaWt9VeYdn2S/jL2LxMA7LzV39UbMFwB/fKGxNmYotGY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760031; c=relaxed/simple;
	bh=zb7NfYizIYa/fAz4BNHIqZDmtSOXvTHqApzRGe1bEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swcyMwSXSf2j9rz4GWfV5T4huZGtpJLZlzWswFuHzVJjViON8iNPV8raDf7MJDRd0QdxipJGdV0l+ZrXvwTxlNFE0KvICTWmfeOl5QpvRbeH+PCbxGgvrFLJgBQsGTNx59qjL+yIXbl6WVLQEF9dc04U0qNIu7vhjrmzHIiyQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; arc=none smtp.client-ip=202.210.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: from iot-shnota-vm.. (iot-shnota-vm.priv.miraclelinux.com [10.2.1.238])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id DCDD51400A8;
	Wed, 30 Sep 2026 18:11:40 +0900 (JST)
From: Shun Ota <shun.ota@miraclelinux.com>
To: stable@vger.kernel.org
Cc: Andrei Matei <andreimatei1@gmail.com>,
	Hao Sun <sunhao.th@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: [PATCH 6.1.y] bpf: Fix accesses to uninit stack slots
Date: Wed, 30 Sep 2026 18:11:19 +0900
Message-ID: <20260930091119.749424-1-shun.ota@miraclelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrei Matei <andreimatei1@gmail.com>

[ Upstream commit 6b4a64bafd107e521c01eec3453ce94a3fb38529 ]

Privileged programs are supposed to be able to read uninitialized stack
memory (ever since 6715df8d5) but, before this patch, these accesses
were permitted inconsistently. In particular, accesses were permitted
above state->allocated_stack, but not below it. In other words, if the
stack was already "large enough", the access was permitted, but
otherwise the access was rejected instead of being allowed to "grow the
stack". This undesired rejection was happening in two places:
- in check_stack_slot_within_bounds()
- in check_stack_range_initialized()
This patch arranges for these accesses to be permitted. A bunch of tests
that were relying on the old rejection had to change; all of them were
changed to add also run unprivileged, in which case the old behavior
persists. One tests couldn't be updated - global_func16 - because it
can't run unprivileged for other reasons.

This patch also fixes the tracking of the stack size for variable-offset
reads. This second fix is bundled in the same commit as the first one
because they're inter-related. Before this patch, writes to the stack
using registers containing a variable offset (as opposed to registers
with fixed, known values) were not properly contributing to the
function's needed stack size. As a result, it was possible for a program
to verify, but then to attempt to read out-of-bounds data at runtime
because a too small stack had been allocated for it.

Each function tracks the size of the stack it needs in
bpf_subprog_info.stack_depth, which is maintained by
update_stack_depth(). For regular memory accesses, check_mem_access()
was calling update_state_depth() but it was passing in only the fixed
part of the offset register, ignoring the variable offset. This was
incorrect; the minimum possible value of that register should be used
instead.

This tracking is now fixed by centralizing the tracking of stack size in
grow_stack_state(), and by lifting the calls to grow_stack_state() to
check_stack_access_within_bounds() as suggested by Andrii. The code is
now simpler and more convincingly tracks the correct maximum stack size.
check_stack_range_initialized() can now rely on enough stack having been
allocated for the access; this helps with the fix for the first issue.

A few tests were changed to also check the stack depth computation. The
one that fails without this patch is verifier_var_off:stack_write_priv_vs_unpriv.

Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20231208032519.260451-3-andreimatei1@gmail.com

Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com/
[ Resolved conflict in check_stack_write_var_off() by dropping grow_stack_state()
  and omitting upstream dynptr logic not present in 6.1.y.
  The following test files were omitted as they do not exist in 6.1.y:
  - tools/testing/selftests/bpf/progs/iters.c
  - tools/testing/selftests/bpf/progs/verifier_basic_stack.c
  - tools/testing/selftests/bpf/progs/verifier_int_ptr.c
  - tools/testing/selftests/bpf/progs/verifier_raw_stack.c
  - tools/testing/selftests/bpf/progs/verifier_var_off.c ]
Signed-off-by: Shun Ota <shun.ota@miraclelinux.com>
---
 kernel/bpf/verifier.c                         | 66 ++++++++-----------
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ----
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 4 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2ce9f664a40..d7e9b84ff491 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1026,7 +1026,10 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
 	return 0;
 }
 
-static int grow_stack_state(struct bpf_func_state *state, int size)
+/* Possibly update state->allocated_stack to be at least size bytes. Also
+ * possibly update the function's high-water mark in its bpf_subprog_info.
+ */
+static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
 	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
 
@@ -1038,6 +1041,11 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
 		return -ENOMEM;
 
 	state->allocated_stack = size;
+
+	/* update known max for given subprogram */
+	if (env->subprog_info[state->subprogno].stack_depth < size)
+		env->subprog_info[state->subprogno].stack_depth = size;
+
 	return 0;
 }
 
@@ -3214,9 +3222,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = NULL;
 	u32 dst_reg = insn->dst_reg;
 
-	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
-	if (err)
-		return err;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
@@ -3367,11 +3372,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	if (value_reg && register_is_null(value_reg))
 		writing_zero = true;
 
-	err = grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE));
-	if (err)
-		return err;
-
-
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4406,20 +4406,6 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 					   strict);
 }
 
-static int update_stack_depth(struct bpf_verifier_env *env,
-			      const struct bpf_func_state *func,
-			      int off)
-{
-	u16 stack = env->subprog_info[func->subprogno].stack_depth;
-
-	if (stack >= -off)
-		return 0;
-
-	/* update known max for given subprogram */
-	env->subprog_info[func->subprogno].stack_depth = -off;
-	return 0;
-}
-
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -4849,13 +4835,14 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(s64 off,
-					  struct bpf_func_state *state,
-					  enum bpf_access_type t)
+static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
+                                          s64 off,
+                                          struct bpf_func_state *state,
+                                          enum bpf_access_type t)
 {
 	int min_valid_off;
 
-	if (t == BPF_WRITE)
+	if (t == BPF_WRITE || env->allow_uninit_stack)
 		min_valid_off = -MAX_BPF_STACK;
 	else
 		min_valid_off = -state->allocated_stack;
@@ -4904,7 +4891,7 @@ static int check_stack_access_within_bounds(
 		max_off = reg->smax_value + off + access_size;
 	}
 
-	err = check_stack_slot_within_bounds(min_off, state, type);
+	err = check_stack_slot_within_bounds(env, min_off, state, type);
 	if (!err && max_off > 0)
 		err = -EINVAL; /* out of stack access into non-negative offsets */
 	if (!err && access_size < 0)
@@ -4924,8 +4911,10 @@ static int check_stack_access_within_bounds(
 			verbose(env, "invalid variable-offset%s stack R%d var_off=%s size=%d\n",
 				err_extra, regno, tn_buf, access_size);
 		}
+		return err;
 	}
-	return err;
+
+	return grow_stack_state(env, state, round_up(-min_off, BPF_REG_SIZE));
 }
 
 /* check whether memory at (regno + off) is accessible for t = (read | write)
@@ -4940,7 +4929,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	struct bpf_func_state *state;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -5084,11 +5072,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			return err;
 
-		state = func(env, reg);
-		err = update_stack_depth(env, state, off);
-		if (err)
-			return err;
-
 		if (t == BPF_READ)
 			err = check_stack_read(env, regno, off, size,
 					       value_regno);
@@ -5281,7 +5264,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
- * on the access type, that all elements of the stack are initialized.
+ * on the access type and privileges, that all elements of the stack are
+ * initialized.
  *
  * 'off' includes 'regno->off', but not its dynamic part (if any).
  *
@@ -5364,8 +5348,11 @@ static int check_stack_range_initialized(
 
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
-		if (state->allocated_stack <= slot)
-			goto err;
+		if (state->allocated_stack <= slot) {
+			verbose(env, "verifier bug: allocated_stack too small");
+			return -EFAULT;
+		}
+
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
@@ -5389,7 +5376,6 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-err:
 		if (tnum_is_const(reg->var_off)) {
 			verbose(env, "invalid%s read from stack R%d off %d+%d size %d\n",
 				err_extra, regno, min_off, i - min_off, access_size);
@@ -5414,7 +5400,7 @@ static int check_stack_range_initialized(
 		 * helper may write to the entire memory range.
 		 */
 	}
-	return update_stack_depth(env, state, min_off);
+	return 0;
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
index e7206304632e..e3e64bc472cd 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func16.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -13,7 +13,7 @@ __noinline int foo(int (*arr)[10])
 }
 
 SEC("cgroup_skb/ingress")
-__failure __msg("invalid indirect read from stack")
+__success
 int global_func16(struct __sk_buff *skb)
 {
 	int array[10];
diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index b39665f33524..096219311951 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -83,17 +83,6 @@
 	.result = REJECT,
 	.errstr = "!read_ok",
 },
-{
-	"Can't use cmpxchg on uninit memory",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 3),
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid read from stack",
-},
 {
 	"BPF_W cmpxchg should zero top 32 bits",
 	.insns = {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index a201d2871bfb..a8ce7f534ba6 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1501,7 +1501,9 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.fixup_map_hash_8b = { 23 },
 	.result = REJECT,
-	.errstr = "invalid read from stack R7 off=-16 size=8",
+	.errstr = "R0 invalid mem access 'scalar'",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack R7 off=-16 size=8",
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
-- 
2.43.0


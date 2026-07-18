Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B130DD2A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375078; cv=none; b=sFXMlArV/PRhsGzLkDelJe5VpAYFpPxXVnc8Ud8iEgEJm9q1hcBSeja0kxlMzM9lKXV7KCnwROu3MQV1rnOBZLCSVssxm/OaszuH4CeYTxl2nV1ReOLOLBQoKuGihUCn0YFzHpl5+nzz/tYkmEvjgzUwq+9L7LjNmdOikkn5mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375078; c=relaxed/simple;
	bh=amU+2abFMRaXcd/uGy1yWModmouwsvnhBWDFPsXSxIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNRPizBGeCCLoX2NPms67eNFrUJRReQncHYiB1pE0j2j7z/P4Nwqy2ABx4dWlFqk+c4R4VUGaK87jNALguUZ63MPVzoIXVnuts/z/9UAjqR4sa4MV2NqgKvk3Xkwg0NXL7VcJ5VwBwLyiB7tRlQNiPCLCXoiqr4dpncgCTCueGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBFvCrkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBFvCrkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B601F000E9;
	Sat, 18 Jul 2026 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375077;
	bh=nNA45ENjn23PjxlvIJD/IGdTSBmsWRKs01tC7jwMEiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBFvCrkNwenQ0qMsTabFaOnsaq6m0t7z/0LehXk+05+rLKUHsvM4XXFJuICj3uTkW
	 nEYRYHeIpK2lKlW8klAAIu1qNf8Mt0rqd6XajREYlb/OfrsXHWjAx2LTYNDRtJ8eHU
	 3WIDnArrNaWCeu3AVDwrW9a70+VB67cHsgHn1iRRRXZ2ejcANJN3IW9KTLh6AewhL7
	 oaM34w2qeVnNXsfDM3fTRYJZ9iyQMeZnAqi9qm5cJ2rmSvpPWPaYEBfMlQTvlJfW9U
	 A4bZ/CykjKsi5g8PSrUE9LqBdVMpZZD3FB1lmx4yld98UhpRj65PQh0TLiaGrEX6Zw
	 9p9D8tZdcZ0IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] bpf: Consistently use reg_state() for register access in the verifier
Date: Sat, 18 Jul 2026 07:44:32 -0400
Message-ID: <20260718114435.3046796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071438-pester-imperial-a2dc@gregkh>
References: <2026071438-pester-imperial-a2dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 7af3339948601e188d93d7e03326aeb8fcbd6bea ]

Replace the pattern of declaring a local regs array from cur_regs()
and then indexing into it with the more concise reg_state() helper.
This simplifies the code by eliminating intermediate variables and
makes register access more consistent throughout the verifier.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20260113134826.2214860-1-mykyta.yatsenko5@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 53040a81ae57 ("bpf: Keep dynamic inner array lookups nullable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dcf591acd50d2..90f3cf19849fdc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5686,8 +5686,8 @@ static int check_stack_write(struct bpf_verifier_env *env,
 static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 				 int off, int size, enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_map *map = regs[regno].map_ptr;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_map *map = reg->map_ptr;
 	u32 cap = bpf_map_flags_to_cap(map);
 
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
@@ -6191,8 +6191,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 			       int size, bool zero_size_allowed)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	/* We may have added a variable offset to the packet pointer; but any
@@ -6279,8 +6278,7 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 			     u32 regno, int off, int size,
 			     enum bpf_access_type t)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_insn_access_aux info = {};
 	bool valid;
 
@@ -7465,8 +7463,7 @@ static int check_stack_access_within_bounds(
 		int regno, int off, int access_size,
 		enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = regs + regno;
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
 	s64 min_off, max_off;
 	int err;
@@ -8409,7 +8406,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 {
 	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
 	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
 	bool is_irq = flags & PROCESS_LOCK_IRQ;
@@ -8525,7 +8522,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 				   enum btf_field_type field_type)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
@@ -8572,7 +8569,7 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
 			      struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8596,7 +8593,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 static int process_wq_func(struct bpf_verifier_env *env, int regno,
 			   struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8617,7 +8614,7 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 				  struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8637,7 +8634,7 @@ static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct btf_field *kptr_field;
 	struct bpf_map *map_ptr;
 	struct btf_record *rec;
@@ -8710,7 +8707,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
@@ -8830,7 +8827,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
 
@@ -9302,7 +9299,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			  const u32 *arg_btf_id,
 			  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
 	int i, j;
@@ -9715,7 +9712,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  int insn_idx)
 {
 	u32 regno = BPF_REG_1 + arg;
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
@@ -11245,7 +11242,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_reg_state *regs = cur_regs(env), *reg;
+	struct bpf_reg_state *reg;
 	struct bpf_map *map = meta->map_ptr;
 	u64 val, max;
 	int err;
@@ -11257,7 +11254,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EINVAL;
 	}
 
-	reg = &regs[BPF_REG_3];
+	reg = reg_state(env, BPF_REG_3);
 	val = reg->var_off.value;
 	max = map->max_entries;
 
@@ -11403,8 +11400,7 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[BPF_REG_4];
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
@@ -12675,7 +12671,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
-- 
2.53.0


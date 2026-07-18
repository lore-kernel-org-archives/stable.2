Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285E330B32
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375079; cv=none; b=qeKP8gGJcwR32NuEo8dOgMFuB6sHrZhPn98R/R5wQTq57VVhEzhy2PSoDtcAJTv1WWxc1ocfV/DWpmMOMsu2D0fXm28tnZX31xnMSzDY1rMbHPOb2B0MWL4vSC1vMRmd98ZPa0psbQwyw71avtKi7ViXeUWzehlUzJ+Ysdu9AX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375079; c=relaxed/simple;
	bh=cFoR2U5CJ2e15Ggan4zGUjMyQKH2u/7+F+ki2ryjCZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phfTGuOVnJ1r2paamEVsYBNGZRDoziS/4shQvW9vmuGbAuPaHzWbPqht+kNNrMnj7x8pH6+M8UVWiiyRBulMnXfyXnOwZAmEXygMuH2PdDxOeaKTXEXtH36GJHvfVZvxd0PqtVcWmcUNqiDtVeBG5AqHvCKFpeJ4tsDoX4hMWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDPaEI3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDPaEI3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E11F00A3E;
	Sat, 18 Jul 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375078;
	bh=2oMu3QKdFhC4ai2PB0FhOhMG1Z2vfqQQ4lSbJ4pDybA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDPaEI3fjAcAb3M4gyjBMY021KYsghjxAJ8vn0yer4MFRXGShVeRum+ZePjuT5WAZ
	 wMctv8Ua1XAS+J1pHOZhekAyVfVE84KmRLjzKToIuHziVucrDpA+Vw/sLXPHc9bdly
	 /Vx10D3YAbsKo2VBiiQWaI/aRmLNTc987tCunda6Hb2XBuOv37i5D4B4E1yta7RHOI
	 qHCYglA6Y7u6E65mfRpKnsWvdIksmNgVW5H8A8FjV+yOU7i5SSqbEraPCdKmmHWyV2
	 XaHIqPVt8hayJOm53RfgtHNCNIj/BH5UUl2f+569APDErru0g/kQyzQSvz6kgmapmE
	 T3B6pgG2UXiEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] bpf: Introduce struct bpf_map_desc in verifier
Date: Sat, 18 Jul 2026 07:44:33 -0400
Message-ID: <20260718114435.3046796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718114435.3046796-1-sashal@kernel.org>
References: <2026071438-pester-imperial-a2dc@gregkh>
 <20260718114435.3046796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 98c4fd2963cb2bc5eae22b5365e6bbf3a5cd0f14 ]

Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
instead of having different representations:
 - bpf_call_arg_meta had separate map_ptr and map_uid fields
 - bpf_kfunc_call_arg_meta had an anonymous inline struct

This unifies the map fields layout across both metadata structures,
making the code more consistent and preparing for further refactoring of
map field pointer validation.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Link: https://lore.kernel.org/r/20260130-verif_special_fields-v2-1-2c59e637da7d@meta.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 53040a81ae57 ("bpf: Keep dynamic inner array lookups nullable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 79 ++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90f3cf19849fdc..4bd1c89ae4ee88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -274,8 +274,13 @@ static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
 	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
 }
 
+struct bpf_map_desc {
+	struct bpf_map *ptr;
+	int uid;
+};
+
 struct bpf_call_arg_meta {
-	struct bpf_map *map_ptr;
+	struct bpf_map_desc map;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -285,7 +290,6 @@ struct bpf_call_arg_meta {
 	u64 msize_max_value;
 	int ref_obj_id;
 	int dynptr_id;
-	int map_uid;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -345,10 +349,7 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
-	struct {
-		struct bpf_map *ptr;
-		int uid;
-	} map;
+	struct bpf_map_desc map;
 	u64 mem_size;
 };
 
@@ -8577,7 +8578,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 	if (err)
 		return err;
 
-	if (meta->map_ptr) {
+	if (meta->map.ptr) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
@@ -8585,8 +8586,8 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
 	return 0;
 }
 
@@ -8650,7 +8651,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 		rec = map_ptr->record;
-		meta->map_ptr = map_ptr;
+		meta->map.ptr = map_ptr;
 	}
 
 	if (!tnum_is_const(reg->var_off)) {
@@ -9157,13 +9158,13 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
 {
-	if (!meta->map_ptr) {
+	if (!meta->map.ptr) {
 		/* kernel subsystem misconfigured verifier */
 		verifier_bug(env, "invalid map_ptr to access map->type");
 		return -EFAULT;
 	}
 
-	switch (meta->map_ptr->map_type) {
+	switch (meta->map.ptr->map_type) {
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
@@ -9812,7 +9813,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
-		if (meta->map_ptr) {
+		if (meta->map.ptr) {
 			/* Use map_uid (which is unique id of inner map) to reject:
 			 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
 			 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
@@ -9825,23 +9826,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 *
 			 * Comparing map_ptr is enough to distinguish normal and outer maps.
 			 */
-			if (meta->map_ptr != reg->map_ptr ||
-			    meta->map_uid != reg->map_uid) {
+			if (meta->map.ptr != reg->map_ptr ||
+			    meta->map.uid != reg->map_uid) {
 				verbose(env,
 					"timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-					meta->map_uid, reg->map_uid);
+					meta->map.uid, reg->map_uid);
 				return -EINVAL;
 			}
 		}
-		meta->map_ptr = reg->map_ptr;
-		meta->map_uid = reg->map_uid;
+		meta->map.ptr = reg->map_ptr;
+		meta->map.uid = reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
 		 */
-		if (!meta->map_ptr) {
+		if (!meta->map.ptr) {
 			/* in function declaration map_ptr must come before
 			 * map_key, so that it's verified and known before
 			 * we have to check map_key here. Otherwise it means
@@ -9850,11 +9851,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->key");
 			return -EFAULT;
 		}
-		key_size = meta->map_ptr->key_size;
+		key_size = meta->map.ptr->key_size;
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -9872,13 +9873,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
 		 */
-		if (!meta->map_ptr) {
+		if (!meta->map.ptr) {
 			/* kernel subsystem misconfigured verifier */
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+		err = check_helper_mem_access(env, regno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
 		break;
@@ -11196,7 +11197,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_map *map = meta->map_ptr;
+	struct bpf_map *map = meta->map.ptr;
 
 	if (func_id != BPF_FUNC_tail_call &&
 	    func_id != BPF_FUNC_map_lookup_elem &&
@@ -11229,11 +11230,11 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	}
 
 	if (!aux->map_ptr_state.map_ptr)
-		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1, false);
-	else if (aux->map_ptr_state.map_ptr != meta->map_ptr)
-		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1, true);
+		bpf_map_ptr_store(aux, meta->map.ptr,
+				  !meta->map.ptr->bypass_spec_v1, false);
+	else if (aux->map_ptr_state.map_ptr != meta->map.ptr)
+		bpf_map_ptr_store(aux, meta->map.ptr,
+				  !meta->map.ptr->bypass_spec_v1, true);
 	return 0;
 }
 
@@ -11243,7 +11244,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	struct bpf_reg_state *reg;
-	struct bpf_map *map = meta->map_ptr;
+	struct bpf_map *map = meta->map.ptr;
 	u64 val, max;
 	int err;
 
@@ -11809,22 +11810,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		 * can check 'value_size' boundary of memory access
 		 * to map element returned from bpf_map_lookup_elem()
 		 */
-		if (meta.map_ptr == NULL) {
+		if (meta.map.ptr == NULL) {
 			verifier_bug(env, "unexpected null map_ptr");
 			return -EFAULT;
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map_ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr->map_type) &&
 		    meta.const_map_key >= 0 &&
-		    meta.const_map_key < meta.map_ptr->max_entries)
+		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
 
-		regs[BPF_REG_0].map_ptr = meta.map_ptr;
-		regs[BPF_REG_0].map_uid = meta.map_uid;
+		regs[BPF_REG_0].map_ptr = meta.map.ptr;
+		regs[BPF_REG_0].map_uid = meta.map.uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (!type_may_be_null(ret_flag) &&
-		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
+		    btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		break;
@@ -11927,7 +11928,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id = ++env->id_gen;
 
-	if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
+	if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
 		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
 			     func_id_name(func_id), func_id);
 		return -EFAULT;
@@ -11939,7 +11940,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
-	} else if (is_acquire_function(func_id, meta.map_ptr)) {
+	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
@@ -11954,7 +11955,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
-	err = check_map_func_compatibility(env, meta.map_ptr, func_id);
+	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
 
-- 
2.53.0


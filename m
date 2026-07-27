Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD673B14CE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166867; cv=none; b=b8DnZhHMAgxmPE5tiEAWEdaY3bLOgpB6qGYkQxs2aWkBQao/q3Wp7ZZ1qRKKSMiVMK5BkvwLmeHZiUK6Q40c6Bp5QtWaVpJdxElNZjGEY7m907Wk4Fo0m7BjgXXOuxcnbLzGoDin+mH+xKxTe7/bmzbL1VHR0mUBAZlNVCwx8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166867; c=relaxed/simple;
	bh=FlWNOeL6EUfztIAHO5T7aE/HN8NBfGCb5PHDF3jP94M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz6fFiSsEhg5J38BbrqCM1M9bHM/I3GBSm4DpIEiqd/NT1Nk9LKBjWODR7dO/SrlHyhLD+WF+nrKZVyH2rO637ZGFaUvBC5iUSyV+xwtPgoiehrR09ic2aP9ag9H27OoXAjxw5edsPXorU8oMsCSi+hyibuc1KoReB4fp7xP6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCJ+zFEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCJ+zFEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9B1F00A3E;
	Mon, 27 Jul 2026 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166866;
	bh=svX9eNuhlLapaTIPrJjoPK6Yj2++grkCoj+ZmfgjANY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SCJ+zFEKjmUoOCQXUkoOFZQeqvhLNs1aeGWw0/qromGfhqzabDGHQ83jPWPotgUnA
	 znAFCuGNli8q4YcZ6+eJj4hImThV1gYdnrg/GfFPDdbNd3ylNwT5VTnicep/MNRrGM
	 ImVo79iczI34eqWsNy5JVUIeHBoEwe11YRY8snei8HzXrZsXL1165vJfuCtxQBmRki
	 +zzBuIFbm8ABaZHMh9ORq0xFKs8DJWnIIpriBNSOqtKNzCLSQCxW9TXwUOhxpprL9T
	 /E4soAysBRd4R6K9gw6NlRfC4+76TpnlbTYZzw9vR7ylairDmxnTdAM8xzEci916M9
	 K9Vlsfi1k9GXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] bpf: Refactor check_ctx_access()
Date: Mon, 27 Jul 2026 11:41:02 -0400
Message-ID: <20260727154103.1515347-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727154103.1515347-1-sashal@kernel.org>
References: <2026072011-poach-marina-ef6e@gregkh>
 <20260727154103.1515347-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 201b62ccc83153d2925d310a2afe762905e0c455 ]

Reduce the variable passing madness surrounding check_ctx_access().
Currently, check_mem_access() passes many pointers to local variables to
check_ctx_access(). They are used to initialize "struct
bpf_insn_access_aux info" in check_ctx_access() and then passed to
is_valid_access(). Then, check_ctx_access() takes the data our from
info and write them back the pointers to pass them back. This can be
simpilified by moving info up to check_mem_access().

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/20250221175644.1822383-1-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 5e0b273e0a62 ("bpf: Reset register bounds before narrowing retval range in check_mem_access()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3351145457495..373e6a2326946e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5829,18 +5829,10 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
-			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
+			    enum bpf_access_type t, struct bpf_insn_access_aux *info)
 {
-	struct bpf_insn_access_aux info = {
-		.reg_type = *reg_type,
-		.log = &env->log,
-		.is_retval = false,
-		.is_ldsx = is_ldsx,
-	};
-
 	if (env->ops->is_valid_access &&
-	    env->ops->is_valid_access(off, size, t, env->prog, &info)) {
+	    env->ops->is_valid_access(off, size, t, env->prog, info)) {
 		/* A non zero info.ctx_field_size indicates that this field is a
 		 * candidate for later verifier transformation to load the whole
 		 * field and then apply a mask when accessed with a narrower
@@ -5848,15 +5840,8 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 * will only allow for whole field access and rejects any other
 		 * type of narrower access.
 		 */
-		*reg_type = info.reg_type;
-		*is_retval = info.is_retval;
-
-		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
-			*btf = info.btf;
-			*btf_id = info.btf_id;
-		} else {
-			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
-		}
+		if (base_type(info->reg_type) != PTR_TO_BTF_ID)
+			env->insn_aux_data[insn_idx].ctx_field_size = info->ctx_field_size;
 		/* remember the offset of last byte accessed in ctx */
 		if (env->prog->aux->max_ctx_offset < off + size)
 			env->prog->aux->max_ctx_offset = off + size;
@@ -7224,9 +7209,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err < 0)
 			return err;
 
-		err = check_ctx_access(env, insn_idx, off, size, t, &info.reg_type,
-				       &info.btf, &info.btf_id, &info.is_retval,
-				       info.is_ldsx);
+		err = check_ctx_access(env, insn_idx, off, size, t, &info);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
-- 
2.53.0


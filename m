Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5733537E0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040827; cv=none; b=Q0I6qpear3g1GKRKMzmsF1XwZ2ACCvhzJhdwYVnza8RHtUfhL3MT7ovrgX/J+WBr4WdL21qfGh0MPBL9U3XGO5ur3tup4VaaPCCM5dBgiC7Omwov6/89wMy/iwdHxQmGdpy3D+hoCSkTUcUoSTP1eoPnRAQMtR+ViGa0957IChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040827; c=relaxed/simple;
	bh=Cv5E6pNY4LU2L79ioUWlLJc2+M4Bru79f7eoU1Ha8Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7nUwDoDKJ0R3jzDjxfkbEXpLLBZS35y7ij6DeQzN1s1ZU1Cfiignl/Z306X9phL50qFM0m//AUWCLltCjHxoJVny2jin4ThrDMK96QuNcVNQxPa0wh2tgYi3akDd91G/2LLNWrGBmFxL0r1Zb9Z++R9auodTmjjqDMQpcTnhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlZyXiJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlZyXiJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087F61F00898;
	Thu, 10 Sep 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040824;
	bh=4WACZblNeuVZ8Tg3+XMuny0a5+qxbTryaB42OYRlGvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XlZyXiJP+1ZZgYZ4PfhXhE1En0yBBHWXPul/MnPe8v7yIzcAN162sz6UOhdMhsgf2
	 zTWXMe+5elyVlLEqR5o+psWaJ8RmCvqb1ooTFbLndv7Ynlhd/imAlE9JEnp45yA5HQ
	 l7SGDb+vh+EV3AwKP/eNPHFJ8uHpMxTdirhq5ecVJImVqYyc30pvsjYTxiJHO6G9Wc
	 dYZgBBlpPu4WiEGL/z1/xEk+PFSbez8nVUHvbqu7zr0G15XWMEsMvrZfGe32i2p429
	 ENI/qqQE1pay5N34r7Qnk87V5bI74+AOmF8aiH4CGq+XFOz57x/fmm5U77Vo+eGsnu
	 mJjSliJ0VBw/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] tracing/probes: Fix BTF kflag check for anonymous struct member access
Date: Thu, 10 Sep 2026 07:47:01 -0400
Message-ID: <20260910114701.98485-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910114701.98485-1-sashal@kernel.org>
References: <2026090848-unicycle-recant-e7b4@gregkh>
 <20260910114701.98485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 47e93045a2db80d24f5fef65adecc6b2b32efa23 ]

btf_find_struct_member() traverses into nested anonymous structures and
unions to find a struct member. However, get_bitoffset_of_field() in
trace_probe.c checked btf_type_kflag(type) using the outer parent type
instead of the actual anonymous structure/union that directly contains
the found member.

If the parent structure and anonymous structure have mismatched kflags
(e.g., the parent has kflag=0 while the anonymous structure has kflag=1
because it contains bitfields), the bitfield size encoded in the upper
8 bits of member->offset is erroneously treated as part of the byte/bit
offset, corrupting the resolved offset and failing to set last_bitsize.
Similarly, btf_find_struct_member() pushed anonymous member offsets
onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.

To fix this problem, update btf_find_struct_member() to return actual
containing structure/union type via member_type, use appropriate
__btf_member_bit_offset() to get bit offset, and use member_type for
btf_type_kflag() in get_bitoffset_of_field().

Link: https://lore.kernel.org/all/178827250904.123716.17452648791331881284.stgit@devnote2/

Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
[ applied changes to parse_btf_field() because get_bitoffset_of_field() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_btf.c   | 19 +++++++++++--------
 kernel/trace/trace_btf.h   |  3 ++-
 kernel/trace/trace_probe.c |  5 +++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25a..33de9b80118cf 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -61,16 +61,17 @@ struct btf_anon_stack {
 
 /*
  * Find a member of data structure/union by name and return it.
- * Return NULL if not found, or -EINVAL if parameter is invalid.
- * If the member is an member of anonymous union/structure, the offset
- * of that anonymous union/structure is stored into @anon_offset. Caller
- * can calculate the correct offset from the root data structure by
- * adding anon_offset to the member's offset.
+ * Return NULL if not found, or ERR_PTR(-EINVAL) if parameter is invalid.
+ * If the member is a member of an anonymous union/structure, the bit offset
+ * of that anonymous union/structure is stored into @anon_offset.
+ * If @member_type is non-NULL, the actual containing structure/union type
+ * of the found member is stored into @member_type.
  */
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
-						u32 *anon_offset)
+						u32 *anon_offset,
+						const struct btf_type **member_type)
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
@@ -94,14 +95,16 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
 			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
-				anon_stack[top++].offset =
-					cur_offset + member->offset;
+				anon_stack[top++].offset = cur_offset +
+					__btf_member_bit_offset(type, member);
 			}
 		} else {
 			name = btf_name_by_offset(btf, member->name_off);
 			if (name && !strcmp(member_name, name)) {
 				if (anon_offset)
 					*anon_offset = cur_offset;
+				if (member_type)
+					*member_type = type;
 				goto out;
 			}
 		}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6f..4bd26bceae23a 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -8,4 +8,5 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
-						u32 *anon_offset);
+						u32 *anon_offset,
+						const struct btf_type **member_type);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2d58cf99b6f70..aae60fbebeafb 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -578,6 +578,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 {
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
+	const struct btf_type *mtype;
 	u32 bitoffs, anon_offs;
 	bool is_struct = ctx->struct_btf != NULL;
 	struct btf *btf = ctx_btf(ctx);
@@ -612,7 +613,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 
 			anon_offs = 0;
 			field = btf_find_struct_member(btf, type, fieldname,
-						       &anon_offs);
+						       &anon_offs, &mtype);
 			if (IS_ERR(field)) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return PTR_ERR(field);
@@ -625,7 +626,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			bitoffs += anon_offs;
 
 			/* Accumulate the bit-offsets of the dot-connected fields */
-			if (btf_type_kflag(type)) {
+			if (btf_type_kflag(mtype)) {
 				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
 				ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
 			} else {
-- 
2.53.0


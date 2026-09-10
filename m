Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A1488D91
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044776; cv=none; b=XLQ+3v7wult7PhcVMvbFSFpqVC+wfcuENrcb8CfrYH2iCMUrOIAMmit9v1Ossyso1lkCn2Kc3mqiWri8mVMk0rFv2xEpowa0zTsNmmNjAVr4Q9AaQOVG3tXz/ZMPBouqXEnp3kdLFDZ+KKC08kd3epCGSzfbkZSCEdNVzDFx20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044776; c=relaxed/simple;
	bh=stZKr7VVTql1uTGlWydqhK/H9/SKZywixb30BdS7lr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srrg6TWRFrVhyJZ9gW4Y9qJHDvg/9WIk0pZKMO+q2xFdKyWNTkJp0TAtI7+skAVMIF+NSBBKcFBTj8kNZUIsHHtOr8ngUOzi7rdiemEzI1HYjCq5ImwP8OPEZe7NrWqaUOiMUfn3kggSijTijiIxIqy4k0ytH+cyMQFzxAO+aQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdOnbqsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdOnbqsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6131F00899;
	Thu, 10 Sep 2026 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044774;
	bh=sHx9UfrgXHWe3DnZY66YxT+hrkcVdj7wleUpATdllcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OdOnbqsUKJOpZKSysjiSI+ehkXKaeDWqE8KzQ/koceJ+79zivxfhzoviMGfwdMc1W
	 VhMHvvnUx2WX4QsSE2tnYMSzGAMa7btYD6YtdhIXi6xcV491fIGWZ3pMuWZR5yI1sp
	 6aejDyRcKhsAv/ld0QphdoCjLPNDcsuF6WAbDWWiesVWqZGDwgYkARe8CZ6N2Z7ld8
	 OeMHg0C2rF6ULkWPZK/2xENseDEtJfHPyBcZqok2JLAQyqPPL6dQ5HW8f5poODcs9/
	 /LXJCiq3ZiUfJOM+ktJKqVXcHTC/rAGVa5I2f99HOX5Sg+vTSJjM0SRYu1VIpaITCm
	 5uDBhgrhX+mzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] tracing/probes: Fix BTF kflag check for anonymous struct member access
Date: Thu, 10 Sep 2026 08:52:51 -0400
Message-ID: <20260910125251.183207-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125251.183207-1-sashal@kernel.org>
References: <2026090849-pronto-annuity-bccb@gregkh>
 <20260910125251.183207-1-sashal@kernel.org>
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
[ Applied get_bitoffset_of_field() changes to the equivalent logic in parse_btf_field(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_btf.c   | 19 +++++++++++--------
 kernel/trace/trace_btf.h   |  3 ++-
 kernel/trace/trace_probe.c |  5 +++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 5bbdbcbbde3cd..807d03ff8f063 100644
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
index 4d0b563fb3bd9..d580b3ff806c7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -534,6 +534,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 {
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
+	const struct btf_type *mtype;
 	u32 bitoffs, anon_offs;
 	char *next;
 	int is_ptr;
@@ -562,7 +563,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 
 			anon_offs = 0;
 			field = btf_find_struct_member(ctx->btf, type, fieldname,
-						       &anon_offs);
+						       &anon_offs, &mtype);
 			if (IS_ERR(field)) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return PTR_ERR(field);
@@ -575,7 +576,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			bitoffs += anon_offs;
 
 			/* Accumulate the bit-offsets of the dot-connected fields */
-			if (btf_type_kflag(type)) {
+			if (btf_type_kflag(mtype)) {
 				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
 				ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
 			} else {
-- 
2.53.0


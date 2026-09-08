Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEB5452AE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872090; cv=none; b=AWucT7rZlkrqPekCe0PCiNl1nLSytkYl//aHhqCybjoWv9EsTwEmUIIx0+4wbceuNs3i5k7k3GEKKpfuD2/uXlZgNG+w53pvhhV8llf2T9EsrNobNcJfOaQA33/r1E4zjEaJnTgnF8RUACLWq7E208PNnT2y1VYmUCZtL0G+6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872090; c=relaxed/simple;
	bh=WKhAwVROo5rYeYdoPH9QTs17Gpm3C0j6DxhtThS8aYs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fyMzlXYnxptOF2tkx3/+pWCjgaxuDKiM3mVriq6IhMP2KBgxAiyVEn9Q4+xqdY1SnslNF2exoPeqKKyJwU3LL/COtiNlfDI7PzNgMC3m2XUYHsmz9yXxKWHeCkgQK04tiv7A9RHFtDvGoHICKu79kjjwxZfz3qJeJJkwseAqiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE011F00A3A;
	Tue,  8 Sep 2026 12:54:47 +0000 (UTC)
Subject: FAILED: patch "[PATCH] tracing/probes: Fix BTF kflag check for anonymous struct" failed to apply to 6.12-stable tree
To: mhiramat@kernel.org,rostedt@goodmis.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:45:49 +0200
Message-ID: <2026090849-pronto-annuity-bccb@gregkh>
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
git cherry-pick -x 47e93045a2db80d24f5fef65adecc6b2b32efa23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090849-pronto-annuity-bccb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47e93045a2db80d24f5fef65adecc6b2b32efa23 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 1 Sep 2026 23:21:49 +0900
Subject: [PATCH] tracing/probes: Fix BTF kflag check for anonymous struct
 member access

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

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index d3ba356d5503..ee7a04886bf6 100644
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
 			if (mtype && btf_type_is_struct(mtype) &&
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
index 4bc44bc261e6..4bd26bceae23 100644
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
index c4163904ba74..144e790077c6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -625,6 +625,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 {
 	const struct btf_type *type = *ptype;
 	const struct btf_member *field;
+	const struct btf_type *mtype;
 	struct btf *btf = ctx_btf(ctx);
 	char *fieldname = *pfieldname;
 	int bitoffs = 0;
@@ -640,7 +641,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 
 		anon_offs = 0;
 		field = btf_find_struct_member(btf, type, fieldname,
-						&anon_offs);
+						&anon_offs, &mtype);
 		if (IS_ERR(field)) {
 			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 			return PTR_ERR(field);
@@ -653,7 +654,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		bitoffs += anon_offs;
 
 		/* Accumulate the bit-offsets of the dot-connected fields */
-		if (btf_type_kflag(type)) {
+		if (btf_type_kflag(mtype)) {
 			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
 			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
 		} else {


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147154488D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871519; cv=none; b=mxWvRgKH7lE1Gucc4Nq1bf2BbrA6egqg3mnQNum1/phEVadnmThkJEfjgbBn/kNBDwlbZJANMrJ2Jawv8/PbwG+NflmEMQ8P40dfWTbXtSGi7S8bLhWXr1XEMKug8cQ11U5pffjr+NliROQ+JHzsREV81DEmw3lzauZMV8ThPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871519; c=relaxed/simple;
	bh=2mx/ryQ5Wdqi7vP+BbtEbTj/frKpzGOYpBvigs1Swq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mz3kB7OCE711qX5fTlaU21RkYKxvcGbAS+1vTXCpC30MnnAvusF+E753v1JWXId75OF5XMMOrwNCInch+41k5L0Lv0iVcsG7iVzbLS+8iKHk04Bsob1wzSg0P83b2fb+FEDkRjdL2EMo+uJfPr8GeSxn8fPJfIFSWROhz/fziS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEED91F00A3F;
	Tue,  8 Sep 2026 12:45:17 +0000 (UTC)
Subject: FAILED: patch "[PATCH] tracing/probes: Fix anon_stack check for unnamed bitfields in" failed to apply to 6.18-stable tree
To: mhiramat@kernel.org,rostedt@goodmis.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:45:10 +0200
Message-ID: <2026090810-jasmine-divided-a4e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f36d94a20ca185bcadef3a10b980cd2cfd72d53a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090810-jasmine-divided-a4e9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f36d94a20ca185bcadef3a10b980cd2cfd72d53a Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 1 Sep 2026 23:21:37 +0900
Subject: [PATCH] tracing/probes: Fix anon_stack check for unnamed bitfields in
 btf_find_struct_member

btf_find_struct_member() traverses into nested anonymous structures
and unions by pushing members with !member->name_off onto anon_stack.
However, it does not consider the unnamed bitfields (e.g. `int : 5`
or `unsigned int : 0`) which also have member->name_off == 0.

If such an unnamed bitfield is pushed to anon_stack, the
btf_find_struct_member() return an error even if there are other
valid entries in anon_stack.

To fix this, only push unnamed struct/union members to anon_stack.
Also move the btf_type_is_struct() check to the entry of this function
because now it is sure only struct/union are pushed to anon_stack.

Link: https://lore.kernel.org/all/178827249775.123716.7813217688423513612.stgit@devnote2/

Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kernel.org/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..d3ba356d5503 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -74,24 +74,24 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
+	const struct btf_type *mtype;
 	u32 tid, cur_offset = 0;
 	const char *name;
 	int i, top = 0;
 
+	if (!btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
+
 	anon_stack = kzalloc_objs(*anon_stack, BTF_ANON_STACK_MAX);
 	if (!anon_stack)
 		return ERR_PTR(-ENOMEM);
 
 retry:
-	if (!btf_type_is_struct(type)) {
-		member = ERR_PTR(-EINVAL);
-		goto out;
-	}
-
 	for_each_member(i, type, member) {
 		if (!member->name_off) {
 			/* Anonymous union/struct: push it for later use */
-			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
+			mtype = btf_type_skip_modifiers(btf, member->type, &tid);
+			if (mtype && btf_type_is_struct(mtype) &&
 			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
 				anon_stack[top++].offset =


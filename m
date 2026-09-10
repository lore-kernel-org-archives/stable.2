Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32063470136
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039826; cv=none; b=HbFYBCyk+AxB2RCaKRCoyXEOgWhZnsfrPI1Tq1dzNL0vPNoacSshHoYncA0pwSE6FVfBZ5VyEWEmFzwNEkgrAOEzsH7wiBHwn7pcR6S1VdmDQ3arWP9p6UYK4ohrS0/065uQP8LajAYfr9ixORDvJR4KIES3Ipvs7PMsCdq4/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039826; c=relaxed/simple;
	bh=F6lohWUYc2QNMuIHc/MWOd0fU5LKPXL3/YoO6V/UA94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oroA/rthuu9XLbiU9evOpPxvCvM66bFM7rHX3amKpFzCvnRDUgG9lZ5KvCDdnbLxOsddyFUuyOEVnelpcsns01xrQWO5A5G9yxk8/NbAGuyZI3KqXLMatBorA8O43HdKz6WOY4nWfoXlvNDWTRT/nNBtjwLltcEcxbEIvWl0g4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPKB/4YF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPKB/4YF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202551F000FF;
	Thu, 10 Sep 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039823;
	bh=KUB5e1oZPv+hl7t1ZEc3bPZ35WbuSPcniF5D8IqsfbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPKB/4YFXZY2ko9ObZIVXaCYgKpcSTiX06KfmDqBAjRUW6A0LfW9WqSxjxLoX9wsP
	 SAOZ5FOmLCAU36/nospqfNxRmSRhwSxt2+ZhTOpOEHvOsoEQqA+SMCpJXUe9ANNtul
	 gnufpPsaz8EvLhcZsoaR2DbB5N1+aq7JI06YwawZ7ImI7RjzH97+I2rqGoiKuXfdLs
	 81g40CZZT+jPTCAnsQ6bR7wldxykFuxiYh7BfGuVGKlfC0ztLz2X/oKhNYGwSNsM66
	 YK1rewCDQZitRxEzynFdRte0TYWIGMkSGQPtU+b8vFSbf/mPscY9XKCICdDiTT2qrJ
	 cUMJv83xxTCWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
Date: Thu, 10 Sep 2026 07:30:21 -0400
Message-ID: <20260910113021.62834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090810-jasmine-divided-a4e9@gregkh>
References: <2026090810-jasmine-divided-a4e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit f36d94a20ca185bcadef3a10b980cd2cfd72d53a ]

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
[ retained the existing kcalloc() allocation instead of upstream’s kzalloc_objs() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_btf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 5bbdbcbbde3cd..40e66eb59abbc 100644
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
 	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
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
-- 
2.53.0


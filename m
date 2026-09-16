Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9254BF925
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585681; cv=none; b=SvRKTJTlKI/M33/Yr09rNkFlocXwqL6LsWeZ3IzFRYznG3vDi7B6in+E/Vc8qkrdyZffMGW39qEWKGTcaNPnU3hAbhgLNQYFtyecMDxIsHzfUXbj54hhktF8Xaod2k+jlES2r4czKssOestt8I8kmjxhJl/fmT4T45aueklXmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585681; c=relaxed/simple;
	bh=H+vDDgMkTKFf5QNBDOxEGjC5HCXQp030ODwzfKnKJhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udiJgDejEA89QdMprH+b6jeCGXyvnOegEbwnCAzhVQOYrC6Qm1/9ZTs98DdPJ9MJgsTDtMVcuvi8xGqgGECGd5lHgXKenz/jOr7wTnb1G1JWVv/9Pz0/idqmY3Ikh1lXD5Wx5EdBtLkt67Gh6K/n9iPryvLcf9A1eFN5g7U84RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaYrQdbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaYrQdbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689941F0089F;
	Wed, 16 Sep 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585663;
	bh=RTNACyIUjSplTj5FdCXPoNTJqrhnSRYi6ytLvkmrUmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jaYrQdbvMCpTCvciko8kAlHvR9xM0ozb1FPjGkgT0gNZfNr7i3BMWnq86twHccLi3
	 /7If81/XunBz2rXTogppVjQ1TFTLyb3RKrircdNaYEU4FZrrzGs86WukJfs4LAIAXB
	 ykO8R/ivLN9ag5sYkm3nKzorwbtejRwe87GPmRTIBa9mOM7c38wwXI4yf0YMPBYwYR
	 wsel7Asf6ZeOGzfm2cyGAl3NGSNaD4a7nb2KtL1ZI+VGlziOl7LX7llrLLb7rm7jIr
	 iZa8w6LPqRahYgeA/zeGt22F7QMzpDXdMvdHY+/+Crk353JfCRFKjLBc5zDWJ6iWkL
	 5H6vibxC3Gp/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing: Free histogram var refs regardless of how often they are referenced
Date: Wed, 16 Sep 2026 15:07:42 -0400
Message-ID: <20260916190742.1969073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091623-revolt-calorie-d643@gregkh>
References: <2026091623-revolt-calorie-d643@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 4bddcb346a6cf4615ca77f69a589623b877ca267 ]

Using the same variable three or more times in one hist trigger leaks the
variable reference and its strings when the trigger is removed.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made a trigger's var_refs[] array the only owner of a var ref:
destroy_hist_field() returns early for HIST_FIELD_FL_VAR_REF, so the field
expressions never destroy one. One entry, freed once, no count needed.

commit 8bcebc77e85f ("tracing: Fix histogram code when expression has same
var as value") then made repeated references share one object and added a
count of them. Only the increment side exists, since those expressions
still return early and never drop a reference, so __destroy_hist_field()
sees how many references were created rather than how many are left. It
frees when the decremented count is 0 or 1, so two references work and
three or more leak.

Sharing kept one array entry per object, and create_var_ref() searches and
appends within a single trigger, so nothing outside it holds the object.
Removing a trigger whose variables are still referenced is already refused
by check_var_refs() with -EBUSY. Drop the count and free unconditionally.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com
Fixes: 8bcebc77e85f ("tracing: Fix histogram code when expression has same var as value")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Adjusted struct hist_field context to preserve 5.10’s layout and fn function pointer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 32f9ab82a8810..35a5bbb11157c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -116,7 +116,6 @@ struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
 	hist_field_fn_t			fn;
-	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -1561,16 +1560,8 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
-static void get_hist_field(struct hist_field *hist_field)
-{
-	hist_field->ref++;
-}
-
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
-	if (--hist_field->ref > 1)
-		return;
-
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 	kfree(hist_field->type);
@@ -1615,8 +1606,6 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
-	hist_field->ref = 1;
-
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -1842,10 +1831,8 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_var_refs; i++) {
 		ref_field = hist_data->var_refs[i];
 		if (ref_field->var.idx == var_field->var.idx &&
-		    ref_field->var.hist_data == var_field->hist_data) {
-			get_hist_field(ref_field);
+		    ref_field->var.hist_data == var_field->hist_data)
 			return ref_field;
-		}
 	}
 	/* Sanity check to avoid out-of-bound write on 'hist_data->var_refs' */
 	if (hist_data->n_var_refs >= TRACING_MAP_VARS_MAX)
@@ -2686,7 +2673,6 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;
-- 
2.53.0


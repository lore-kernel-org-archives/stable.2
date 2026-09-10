Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C56472090
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041102; cv=none; b=bUM9qcPSvgcjhz14QNgkc4sRDNkymt2VtQkYw6G/8BPaCuXTF7v4N2cYvyMRY6ub53BrjpRwObw5WkzqhSThQecc2tBF5Y38pVcb4cQs+kE2DCo4o9HWzn2Glakm0WL0BPhgztvxLqSpvqHDxTAabuRTUdFmNz9+A4a/iQlRKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041102; c=relaxed/simple;
	bh=RIuTPdeqzMkwmPMk47x2Ccix5jbovzwoL+LMF3XA5p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emIbcWfqzOm0rnSgOoXWNZMu8WO8v4pdyAAhve4hrCfHHU0LY8pddSv2tlhPwA+/x7ETcyiiDVuWiExvAPVYLxXR9aj8Jw/3Jv6qUFLafuQTA0c4m1FKgK9Yf8gXjU6vHaE4oBZHKnx6LwQfuPNYwEDRCewpqxyoFDzZwbZv4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqsVEg+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqsVEg+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7651F00893;
	Thu, 10 Sep 2026 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041101;
	bh=W1n2b4S7T2DlMZXkjb4ICdTmBuCmn0eM8vmFo8Yn4qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqsVEg+FeLGOHJbuN4CjKG98y6DF8yM6qSpe8SRMBnpf9A8b9u7vcECipvXqozLwQ
	 UkQdwOYaDmW6265y5FHVVwpDFaQcXgKWDV+xdYLeX/IF2csi4/YD42TT6qC0QZdbII
	 pJ34Yp/+guCrYPsU/qSxLkqcUDsib5POK7+AtJDSfLi9Aq98jpj+ARmXtobwK4KsNY
	 +z6IsRdDBcVpoKSpnd3o9BzdPoZgX9/ycaES2vD0HFcYtcaHJpW4t4T9V1m3tlCMbb
	 k8vqkpTc6rJvGVjanHGITZRCFOoFKUN8rtHS2ZjIMSUOSU/aJ2d8uQkLCNFcM61nVm
	 uZA4L7XW4LThw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] tracing/probes: ignore id update from btf_type_skip_modifiers
Date: Thu, 10 Sep 2026 07:51:38 -0400
Message-ID: <20260910115139.111324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090849-jawed-juggling-59e4@gregkh>
References: <2026090849-jawed-juggling-59e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit 823b37855829bc328d46102a56e4d0b2f7a3d0d1 ]

We can pass NULL as id pointer to btf_type_skip_modifiers if we do not
need the id of the returned btf_type.

Link: https://lore.kernel.org/all/20260623132937.3494895-1-martin@kaiser.cx/

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 47e93045a2db ("tracing/probes: Fix BTF kflag check for anonymous struct member access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8e1df280d3114..813e2ddefdaab 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -355,9 +355,8 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 {
 	const struct btf_type *real_type;
 	u32 intdata;
-	s32 tid;
 
-	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
 	if (!real_type)
 		return false;
 
@@ -374,14 +373,13 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	const struct btf_type *real_type;
 	const struct btf_array *array;
 	u32 intdata;
-	s32 tid;
 
 	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
 		return false;
 
 	array = (const struct btf_array *)(type + 1);
 
-	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
@@ -584,7 +582,6 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
-	s32 tid;
 
 	do {
 		if (!is_struct) {
@@ -595,7 +592,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			}
 
 			/* Convert a struct pointer type to a struct type */
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			type = btf_type_skip_modifiers(btf, type->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -635,7 +632,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -754,7 +751,7 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
 found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-- 
2.53.0


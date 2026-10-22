Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680821;
	b=MumbebUZSW5IQmMz/ui4NmD0HgQqgGoIWLNACJfD9z3tQX8wQ/bb28m31AuVaSyWqfz2
	 Fs87/B48F94cEKixx86XfOy3Ahe8hvFxGGs3iGW02Vkk+97YuODX1ZFPkrJiuoaJ/MM0w
	 nBdPQKfnj7jYSoRs7z152Z2+Eke6oPl+8RO0jPoioJhe7l+qD6Ho1Iez336Rhh0TvAaGx
	 tg57QBojJAKIVerEgex4HxAllv2nHv/DpDWEySw5drthA5punLKpYw1kk4mSGLvMzsXpQ
	 +yNaDY0nsVVBb3FSTy1R9vHlyBS0QGgiSDpwH+PjIDYs0kl8NgMEAvMCc77nXs1SwTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IeNvWa19c8pPq/Jp8DeSeaRIQHNdutrDA07L8wNK3vk=;
	b=o52I+WTIsykEu+Us0Bagg1eIyprx2IOw4q0rlpMey6nFAj+epLQMeC8FVetDWsI79HjM
	 w3GeW+QdMcVeNLg9uNXwq+Qcv5+vQEY4UpQq8oPvr238ey22bBtul3hscVP6zsSfJ3I6B
	 bx4zu8d2/A44eNRXdy2R7RgV2cLiHgZZoXRlRnlJMVJB4s+ZNGUvfkVV0CtGjlOqU1Lkm
	 KDZXSiBD/4L6IE/LG+TWzh2rGFqRbhHuHpJTwJBkjkJpFUfsePOOmSOyuWZZKLC8HvEix
	 JuKDFWrZ/FYcGGh+f5IL11SwyFqeQBVhaz8AWQMDXJQm4Ok3xEyL6A9y9OStdhEifmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AolWh892;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75A606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AolWh892
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F17F1F000C5;
	Thu, 22 Oct 2026 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680820;
	bh=IeNvWa19c8pPq/Jp8DeSeaRIQHNdutrDA07L8wNK3vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AolWh89279iW3Lyb6nrYGVV+b2vxRiX1ekuHIqlch9oqOirLmEXu9JCsHirCA3P9H
	 vKtrb5pUgYeB9cTkE6HD7ao9LeLCyulouWE+imhYf5dP0hvSs/MgJNncRxNEnnlLdO
	 4QDockGWc1X1uu9EABztEsJ1gPlyyVia4/XbQULzjP3zSolDCe44+aHyUujKDkabWO
	 fFJm4T+BmenlSMquLp0YRBQNsS3Ec7cp+Y1ZyuDo+N3KkPHDCVIc0Zv/xfCGUHAIDX
	 68uBOq2/HrlL9VRiDfTPRA3ZfE4/Ah6l2a8QfviXV9eg9rAr6v298hXEwZlcawN9xd
	 Oh6YO2AOYOgIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] tracing: Bound histogram expression strings with seq_buf
Date: Thu, 22 Oct 2026 10:53:36 -0400
Message-ID: <20261022145315.1599452-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022145315.1599452-1-sashal@kernel.org>
References: <2026102123-faceplate-shallow-02a0@gregkh>
 <20261022145315.1599452-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 935601a4276f28105498609f7f98aa66e86e9c96 ]

expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
expression names with a series of raw strcat() appends. Nested operands,
constants, field flags, and generated field names can push the rendered
string past that fixed limit before the name is attached to the hist
field.

Build expression strings with seq_buf and return -E2BIG when the
rendered name would exceed MAX_FILTER_STR_VAL. This keeps the existing
tracing-side limit while replacing the raw append logic with bounded
construction.

Link: https://patch.msgid.link/20260611055945.22348-4-pengpeng@iscas.ac.cn
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Stable-dep-of: a0777b9e5315 ("tracing: Fix NULL dereference when copying keys for a field variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 57 ++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 96dd7cbe116fa..18e3503bdc79b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -93,7 +93,6 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
-#define HIST_CONST_DIGITS_MAX	21
 #define HIST_DIV_SHIFT		20  /* For optimizing division by constants */
 
 enum field_op_id {
@@ -1710,33 +1709,36 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
-static void expr_field_str(struct hist_field *field, char *expr)
+static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 {
+	const char *field_name;
+
 	if (field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (!field->system)
-			strcat(expr, "$");
-	} else if (field->flags & HIST_FIELD_FL_CONST) {
-		char str[HIST_CONST_DIGITS_MAX];
+			seq_buf_putc(s, '$');
+	} else if (field->flags & HIST_FIELD_FL_CONST)
+		seq_buf_printf(s, "%llu", field->constant);
 
-		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
-		strcat(expr, str);
-	}
+	field_name = hist_field_name(field, 0);
+	if (!field_name)
+		return false;
 
-	strcat(expr, hist_field_name(field, 0));
+	seq_buf_puts(s, field_name);
 
 	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
-		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
-		}
+		if (flags_str)
+			seq_buf_printf(s, ".%s", flags_str);
 	}
+
+	return !seq_buf_has_overflowed(s);
 }
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr __free(kfree) = NULL;
+	struct seq_buf s;
 
 	if (level > 1)
 		return NULL;
@@ -1745,47 +1747,54 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (!expr)
 		return NULL;
 
+	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
+
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
+		if (!expr_field_str(field, &s))
+			return ERR_PTR(-E2BIG);
+
 		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
 		if (!subexpr)
 			return NULL;
 
-		strcat(expr, subexpr);
-		strcat(expr, ")");
-
+		seq_buf_printf(&s, "-(%s)", subexpr);
 		kfree(subexpr);
 
+		if (seq_buf_has_overflowed(&s))
+			return ERR_PTR(-E2BIG);
+
 		return_ptr(expr);
 	}
 
-	expr_field_str(field->operands[0], expr);
+	if (!expr_field_str(field->operands[0], &s))
+		return ERR_PTR(-E2BIG);
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
-		strcat(expr, "-");
+		seq_buf_putc(&s, '-');
 		break;
 	case FIELD_OP_PLUS:
-		strcat(expr, "+");
+		seq_buf_putc(&s, '+');
 		break;
 	case FIELD_OP_DIV:
-		strcat(expr, "/");
+		seq_buf_putc(&s, '/');
 		break;
 	case FIELD_OP_MULT:
-		strcat(expr, "*");
+		seq_buf_putc(&s, '*');
 		break;
 	default:
 		return NULL;
 	}
 
-	expr_field_str(field->operands[1], expr);
+	if (seq_buf_has_overflowed(&s) ||
+	    !expr_field_str(field->operands[1], &s))
+		return ERR_PTR(-E2BIG);
 
 	return_ptr(expr);
 }
-- 
2.53.0


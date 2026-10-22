Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678145;
	b=47e8H6gPpti0iRWAd7qpGl+rPv6JILLuhmLFKihNzPIRVtzLbd2acBEiXP0jNtjxHzl/
	 UAC3ZIRD2vxPQWB/NWdSZTniG60GS1ojWEWadP0NvJuJMNo80fxYWPiK5HZxZD4etKrim
	 OO1oWR+aT9DxPU4Xif8bD8SB3gg4PwzJXfbdqTk9G20bVwgaStyLvX819xhAKexTQgMga
	 EhXFrLb7lNYbGZgLEz7d+MrttjKPJGMAlaXb0ccSVqxKUL5cQwwK7X1lwVOtWQrxWrvpr
	 aDYoWwrt/k5XVcErcx06Fz3b3nKpnbOCzHhWapCCIVPhT6xvBcBU7/rwUpbXe5oFQQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U7H5v4cwrTEp+TB101E5vL9gOVRXg8XCTzQ6V7Tpas4=;
	b=CLADpDj8C/ZGFeyYmyvJUi7lQx6Q4nnHRM7nFJaoB+07/kQmixtgWdmqkOuqF+htZxuu
	 ZV302kz6HdhwErIutjnJAky9c8L7qAQ73aa3zxmPbhINJGkJb1KKlgRiDs7nyumwL97bu
	 reveiIQT43XT1ZfdlgTvBCS556a6BV8Bbr/oeMHixnVJztF4RMsmLcSgqpgNyI5nMeNVq
	 G1BMm/SvJda4J7kPzcCC0vDrI3m2/SuRMM1dz7UZ64xCOGYGqe3WyvKYh44CaR0LRnpyl
	 Yg0MQx067hKnZC74pYQEIGnA4vWWY3+SolKxv64FPWvWy3XMI17MWYigObXBP+H4psw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVg6S7ud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D03606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVg6S7ud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F591F000C1;
	Thu, 22 Oct 2026 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678144;
	bh=U7H5v4cwrTEp+TB101E5vL9gOVRXg8XCTzQ6V7Tpas4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVg6S7udMb7WtLZjr8kvIvs+YkXCQd+zZOixeSuebo61HuiMPntagS0ysAhaudMpz
	 Y4p76ODthyDUuKru6DpoBlXueGnpVbHXczvj2RP3nQ8vIN9cXG4qGLm5DDVUscxSfE
	 SsKk2cKs2FsQarWBuHjDQsdNu6RV9Dw4Ojfx28tCfV92BZeg5/jDUCNcusZuqMSc+m
	 atnspau7VwgWJTiKHe2REFuOkQx+eELSyxfVhuonz2CL6/9pYdcXLDXSAX6lDp/HB0
	 de6YOYnuD9JPoXGOgQBSxvqWyzE0RPbtD373kfHaSqjaQK/pPxCeAnAuK5P4qxAURT
	 /7iQzrOkZUBHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] tracing: Bound histogram expression strings with seq_buf
Date: Thu, 22 Oct 2026 10:09:00 -0400
Message-ID: <20261022140848.1513845-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022140848.1513845-1-sashal@kernel.org>
References: <2026102122-sandy-lazy-aa40@gregkh>
 <20261022140848.1513845-1-sashal@kernel.org>
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
index 5e3232c405afc..4f1c8dd3b83c3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -94,7 +94,6 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
-#define HIST_CONST_DIGITS_MAX	21
 #define HIST_DIV_SHIFT		20  /* For optimizing division by constants */
 
 enum field_op_id {
@@ -1725,33 +1724,36 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
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
@@ -1760,47 +1762,54 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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


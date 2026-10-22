Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678671;
	b=ZoGQ8DkxRzpFwaUvmdN2rhQSmAeoOp/iSkh9/bX5i9UuXadLRBNKTbFE89EYXd44CmpT
	 xTFbz0kyUjt/U+C/p4B0mAsHSY5tpVdrtQOdnpQ7kDPISrGhY3sSWEDqyR/rI1OcYFXky
	 NmBM0q49lUCd3neVvs40caX3SEiJ6zn/cOqgXHDPGs66Sc1gqgloIpTRIVNVpTeuRkfu3
	 KrVGe4ca0knSfsSHfV8srpZ+ewVt9CmWoXi/GwKfqH439yL2g8ezovP3nAsjkiKwBsdbZ
	 s/+a0M9vg1HZnzVdz1kJwDR4jADFtaKG8v+6FS8NqXytFgJEh3HSBk5PF7oH5U5yPNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8iZE5H94wUtdLm+aj8AZsWNnXvTzSPr9PUmQVxtSouk=;
	b=LLKcbXdNZEbrtQttRDiDaQz6w28xO7PGg8E/72l3lHJsptmQV+c2OWB11G5QbiahCnlH
	 UYFVSwOrPijRKdwcifoQ/A3QK4sEvZuopZw3G8/oiV2cOMAMWZIbQxYfLjW5x8YddVIYM
	 fPmf9uxdpsFYLowa1OF8loY5y6A946CtPQX3lAFm1qgYVevwAQFGd/QGUhV32UJ8D/3Rc
	 GA4dfMwd5gi7X1BLNspRJHl/7EuckAU6cOz0DjDWbIihNPK3YGMcsJepxSexI+5wKfhh3
	 WfBXexzfj7gfNlESZ7pOqjgDJOnkOvW4sQ+avQsm5Yq6E5n6hHuDLsI5KCzRo3s/bcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWAYcOL+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB470606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWAYcOL+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF6C1F000C2;
	Thu, 22 Oct 2026 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678670;
	bh=8iZE5H94wUtdLm+aj8AZsWNnXvTzSPr9PUmQVxtSouk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWAYcOL+Q7dlwrsBBNsiqu3SaPrwgLtUwmuq1PrrBM0H83lFlVZuKURo6FVw2sLur
	 9MlY0uoxWkIbeuMsm1KemKYeKsCux4xuLeH6xiKs5u6CkVJQF68UBRv83FIaJyXc8Q
	 euIgCZydmzbSwJto6yCn1LPWr3QJuDk3kY6+TmtiVh5xZ87gDYkGjNVVFQQ+eVe3kW
	 kclXTZvlo3k9BMoA4+sz1xPQ+gJ/zqqWuGE/dgvy4j8Zo/rCz39RF2BeSfOlIG6wcm
	 P0AZrSXAZxadgclFXAX9nosmm3dbKKHdrJtjSfLra5ZBkjsMJBk2+peUNWOQ7w68hj
	 BHf7237Nuwzlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] tracing: Use __free() for expr_str() buffer
Date: Thu, 22 Oct 2026 10:17:46 -0400
Message-ID: <20261022141718.1585988-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022141718.1585988-1-sashal@kernel.org>
References: <2026102123-crushable-fragrance-1b92@gregkh>
 <20261022141718.1585988-1-sashal@kernel.org>
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

[ Upstream commit 988995c0552b6213b6bf16cea57258d4842c1488 ]

expr_str() allocates a temporary expression buffer and manually frees it
on some error paths.

Convert the buffer to __free(kfree) and return it with return_ptr() on
success. This keeps ownership handling separate from the later ERR_PTR()
conversion and string-bound change.

Link: https://patch.msgid.link/20260611055945.22348-2-pengpeng@iscas.ac.cn
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Stable-dep-of: a0777b9e5315 ("tracing: Fix NULL dereference when copying keys for a field variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d92ac0b37a378..68939bb7fdbc0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1751,7 +1751,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
-	char *expr;
+	char *expr __free(kfree) = NULL;
 
 	if (level > 1)
 		return NULL;
@@ -1762,7 +1762,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
-		return expr;
+		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
@@ -1770,16 +1770,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 		strcat(expr, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
-		if (!subexpr) {
-			kfree(expr);
+		if (!subexpr)
 			return NULL;
-		}
+
 		strcat(expr, subexpr);
 		strcat(expr, ")");
 
 		kfree(subexpr);
 
-		return expr;
+		return_ptr(expr);
 	}
 
 	expr_field_str(field->operands[0], expr);
@@ -1798,13 +1797,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 		strcat(expr, "*");
 		break;
 	default:
-		kfree(expr);
 		return NULL;
 	}
 
 	expr_field_str(field->operands[1], expr);
 
-	return expr;
+	return_ptr(expr);
 }
 
 /*
-- 
2.53.0


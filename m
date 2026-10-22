Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680820;
	b=ydkwJge8INEVG0UFSLHvUAZ/9VqXfNySDvPM2A1KEkUQzpnJpT3Tqx06HKZaetjzE8+y
	 u8R+xlj5wQYFGx8Z6tJ/i9K5ZGl6aVJHrfCWtaFfuJLjiUkJlVvZllBbR5ZpGeuF7+hLk
	 a27czHBvSG8H+Dm8BmI9UFhwAcp+ppzjml0Rr8VkqDFXXvYa/J8+R+fZUi+hcbr0ldbP5
	 7arlqC5MN2H09njzWWaFERuG1fv3/DbLl6SdVN8WY2IO8fQTBuGUCXGM1f+jXF0u1IHzv
	 /DJlT7ttX85vb9C0+rnvB2wCO1BsNFu/oGBMVXsd6D+IRxXZffQsTHh981tP7utaDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680820;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xQjyna7GSiGTdxvjR5ggbFOwIyj+p7m4fco/htB52dU=;
	b=Q0A3VVXmyleGLjY1DRMeenr3BTqcUFSzlrfmXdXQ7SiIWWNsLung82t3MD79RvvoZM9h
	 jo8K4STOXCSrN+kyg/HziM0yshaZrTFZLUUxKRY35MHjhoHUVXVckaaJCEP7rNI6Ue9VR
	 eUNZ/IgGpvWzss6R7RriuDNVUslU8XhbZLx6CLDdYXc/kmdljJQ5YcbgSHYc8vsITp+12
	 K/FIwnevRMxgdemQ9Tb7VL/mZf3KYO30pPifswA5w06d6dZKvYbEpbbh3Uh4JgpX/LRWd
	 aKFBfgg6CMzW/Hd1L5KUoYlffO/gUlDaP+HALfKem58UmdoqN1W9p1NHdcCDIIFOWjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bluFErdD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F9606A32A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bluFErdD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5C01F000C3;
	Thu, 22 Oct 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680819;
	bh=xQjyna7GSiGTdxvjR5ggbFOwIyj+p7m4fco/htB52dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bluFErdDoT1p1kvqy8nVtxs6dhEO6vL8nX35BgvIVGlCrfLwzzHEMbrGZBiQ6owIh
	 Ot3n3L829+DCY3MuVsnLdWj0HQU8923qBAINJCasc+qxCrtVO8bfXQZJpDIcvsKFD3
	 aCindvI6fXgEVwJE/FmYUrxTDeI3hwFmelR/85PPNhXg0Lru63JBNHkT2esydUBywp
	 4umP/i81WUQ3XrSOJyulZgbP2tFUzj+vgyfAossvCRXwOr1+rXD/nZ1Ayje5FUi66J
	 uG64r+3zVFZRWEXOV06gcudclIbopy3CRJJjeoXD/IAdGQGc59WUGc7lZpSRAr5rzL
	 xJMzVm0ULFgaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] tracing: Use __free() for expr_str() buffer
Date: Thu, 22 Oct 2026 10:53:35 -0400
Message-ID: <20261022145315.1599452-2-sashal@kernel.org>
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
index f2af4605c9894..96dd7cbe116fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1736,7 +1736,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
-	char *expr;
+	char *expr __free(kfree) = NULL;
 
 	if (level > 1)
 		return NULL;
@@ -1747,7 +1747,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
-		return expr;
+		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
@@ -1755,16 +1755,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
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
@@ -1783,13 +1782,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678144;
	b=p9/O27oE/5/31RtYWIm6+LDIkVCrXs5IPF50Lju2C4U8C/v3jTiYIEVnFdjK/ACwwWj6
	 2Mc2HMUsxqsHvX2yoE0EytA6BY3kFUFpaqt0iO0CdL8NIHEpUoJqkVGSd1rI/aNoy+tqy
	 pdXCHcDvOAxwCgh7IR6r5d5vTLYvkiFyDSEFY124+VCWOSV2H3Dc2QH/XWfuZpzIbB7aV
	 vFj26ZLfzarZnYoSTzzBrLwYb6vg6ywCQVNUmsPrV3q1PAr8nPHS5aP0AZrsP9hqY+6aI
	 CeCXWhdu7dAYUW3wMEQvpZTfuAPQREAOSf7DKkVnBI2azfHPZsHTeFKkHyjnOpodp1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678144;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zDBPMT6f8kMcGlsE9vENH3IZ32Hp4qTbt1rWjBc4EY0=;
	b=uq23i4eRObzPE1HdIKqRRfmSb9ix8durP01IQEJ8IuzVX9Z6TsAvX3udkAxKPVRQwkwA
	 D5IubcuxBm/YIVVmpdFLOQP/PNmVuJiY5eKT90J33904EWQ7B/O8snR50bvnhIVBy5iXZ
	 hVMa5XuY3fqYjDBgCRv+qOo0OXrDAnEDmvAGtW6wY2aUUae7Olx+4GvtFUTmm7oxZ1C/c
	 IkFYC3pa3nxNtPFbYyq4qMTuH6Yd9uGWR026hT5W+DUmr7Jg1efuUuYTXVlNUsQ7gXlK2
	 qlgnXj6AyyUmgeVfE3qG+WGgSNASEuExsHgeVFvOHSxyv6R8s2hZGua9yB9jPaavRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UENQP/6T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AB606A322
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UENQP/6T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F651F000C3;
	Thu, 22 Oct 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678143;
	bh=zDBPMT6f8kMcGlsE9vENH3IZ32Hp4qTbt1rWjBc4EY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UENQP/6Tgp+vLdvIxwa2ItnmwxRqCEs9rziamv+baepuNrOuK+sPBFd76RcPAowMP
	 nsrg0BN0zIh3QPV+RqXtGtR7Fvn+Kqv+GqC5mDj1Yu9XAied9sUAc/LJow8iDMPiNm
	 IvC4+iu2N0pEIGKWDsXG2fP81Egw7OxWgxdTqjlvOAm1/q4tltwva8wMm91qoAaI6/
	 C5vfDGDvpKQK0YnPW8PSXadQFX8ldkiz0Beh/rNiPv+uXm+ZqdLArLg39haxbBGu8r
	 YXILH72GEe298hwlVEuHIbKxWZZOwgDKBs1p83MRijn1z0OtEhdf/H7PWVTYz5wyaY
	 G29I7uCxQP5GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] tracing: Use __free() for expr_str() buffer
Date: Thu, 22 Oct 2026 10:08:59 -0400
Message-ID: <20261022140848.1513845-2-sashal@kernel.org>
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
index 31563c47bb8d9..5e3232c405afc 100644
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


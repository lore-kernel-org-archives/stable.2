Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676565;
	b=cx65ekco03jxgxJupNLNj5J8q99xuO3HOan8HLbyMVWFVl/LNPSHyXSNz/46xfdbwvsP
	 da01wRnnlyN2+YiHDqf3IQ43pH3rTkkcIoyF2wmFLpc53y0KRH8oIJQo8cuMUDogVtgKx
	 6DhVtGfoALMnrcEQUhDx+Eo0mfekaXThyB++XDznQdvDQhNCXG1+3oWqI5iWPSYlUs9IN
	 FaldwrLM68Z8v/wM2BYHc2KYWESM9sVf8GsGRgNUvl19DmYM0EtzJnulocdEQGpdNsg50
	 TenGQnUqmTmEq4OhWnjFjRQe0eLdtTgGr4wjyA3bO4o1zr0My9qwbbIk6hOi1VUn0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2GAd8m/l11foSieKPTENM3i7SGZJRwXocA4LYYbz/iA=;
	b=kFk57mSv6ah9IOPZPfFw9Qhu4NPutXQGfAWr2lcGuMR6CFmagZdQdMQERa+0qmtVlLP4
	 RHNJhYVdmfjMs2vD/2aeGDqQ6uQqSb4lVczQSCO1GrkxQdDkAgSSbNMCZeNTxmiVGCClz
	 lzwTIaIWbyM59L2G7y0l1Ed9WOHEVo9Mk0ItSQqoiFnkgN3ZXjh3rKs81TDNucRBKuaid
	 lM7lanAjpJzTHSlMQDcR9PZ87FQ4OOskbUp6Qd3YRrgzQMp1kdbvV1lekBrJYsPGvErm/
	 OTa0B8iuMKtu0UVaxKokruGLBMHFwzirdTOIo2PWcfKGE3RjiiPMBPV4nF/16zZzM8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeMqTXyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B360A262D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeMqTXyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36E1F000C4;
	Thu, 22 Oct 2026 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676565;
	bh=2GAd8m/l11foSieKPTENM3i7SGZJRwXocA4LYYbz/iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeMqTXykBuV8oZVNA6ItgJMkmW7M7kS5OCm8IoK8LNMGk/lOGpsr1+Io2eAV7L5Rm
	 PurXlqHLyoc3yGKFQoyH/O/wacCDfZG4dlAAqykAzpBn+tZ9fAG1bf3l6KO/LV5BMH
	 atYL5uuSKFGmhMx0O4cGbqRV6fy8o7ZoObVELhXfXB7sOlB3ecewEE0orGVE2toHTF
	 MyfwpQGEM0U2PGP+m6PIDUE/262reaTbLMRms7/l7+haoF4oY6LqnW8VKvOyRYLBGr
	 pVfhcI4BvKdPiP126PCNCdEBPdrP+YS/E/ms2cYrIL40GoxijkvneTLSTwT/83W9rx
	 7MzHnnEl+lfbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] tracing: Use __free() for expr_str() buffer
Date: Thu, 22 Oct 2026 09:42:40 -0400
Message-ID: <20261022134230.1444063-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022134230.1444063-1-sashal@kernel.org>
References: <2026102122-spinster-handler-2d56@gregkh>
 <20261022134230.1444063-1-sashal@kernel.org>
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
index dab2b3dc176b9..cbf387491bc86 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1761,7 +1761,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
-	char *expr;
+	char *expr __free(kfree) = NULL;
 
 	if (level > 1)
 		return NULL;
@@ -1772,7 +1772,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
-		return expr;
+		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
@@ -1780,16 +1780,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
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
@@ -1808,13 +1807,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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


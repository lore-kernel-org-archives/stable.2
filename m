Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673698;
	b=I7KZ/4lUnbYYJBnIa/kwB3TBd9pbneDVlWA7B+ef6F6qHERh1LLlQ+sA+ONzZGyI1jpw
	 LwkuFjIIdtEwmhfaf8qlncaALTBwLGxsvsSq284CGlM/SRXk6qs4En7Y4F0aT5jL91DYz
	 ZcB+nac7wYeG2ZAj6SrLmv8qxAI2xfPIxfno77qJdBApEWww4+A8zP2MKcLAUbdbNnMBh
	 pQoo+c/MkdarUga9BSP111qQVVP16TAL9mizoBMxiLnTR2nf5BRMhquQGcf+YOb9wg+PC
	 8ydAtH96QmgB+3A2LRJgWVy3uVxx8SMQl8oXTZVcqYx01p646X+1QmfBzFyVMdDCJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i07aKEUwhXFLXTojR0CU7v/ISTIlnWIztn5GzMyxDQ4=;
	b=0jmir8QQgY0o4/2SCJTR6AiEIXQBBZ/H2prTA96+8xz3C3ZvaEatJU32c3eFEjz99uUM
	 z77lkv+15ibSTwk5pExOrvrUrfaEQvfqx9QSYyqF3yYYGnOec3XYVSv07RtywPBHJLEXq
	 stRvLyxC+QfsRfEe9HmGrg8MBG0ZZ7Csc3mk/duxisGDzmimE9/EXuRqHLtUkKDUWknpn
	 lEzr/cR4wk+7PDKCe8799HjQ3a7bNwmnxLnrh3RgZaxngL1dvZuqQyBIL22hoO+3Dqq2U
	 If2szOg5z0q1G3/D5NMRClDSPPebSCsHWax/dabmHQtYfi6CwqmoDCD3PcEgd0NPj4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN8NKMls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN8NKMls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DF21F000C1;
	Thu, 22 Oct 2026 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673698;
	bh=i07aKEUwhXFLXTojR0CU7v/ISTIlnWIztn5GzMyxDQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TN8NKMlsguUJz66jaeCvIH/kWQVZ0yShEAnhYzu3eALSPaJrIdXxnDkaZYGokF6tK
	 YfCGqUIxLJB5B8scFdVIBpYum8FQHpkIx8cIbkmFcvfQQC/Vy+CUm32XgeWG10LngY
	 qaADt5Uc5LiHrGwrIBNJWrs+XlTtvmFHibu6SFlKvOZlRw0mGymYh2CYWb6B1VX1OE
	 vmL7YIXCUZ5DMP7/zm2VBwhePU9le6aTgEr6V69dyG2b2rEw9EAcTCxb46mjIsaTTd
	 Pb+Xb+EL6qg7fs5a0f2vEUukzcq58NfnyDcHt0LvTxLPTjn5U4JkspBEL9GxHRuBP3
	 OfoywvAeEpqyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] tracing: Use __free() for expr_str() buffer
Date: Thu, 22 Oct 2026 08:54:54 -0400
Message-ID: <20261022125436.1346436-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102121-bronchial-ozone-0317@gregkh>
References: <2026102121-bronchial-ozone-0317@gregkh>
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
index 160445760545c..81bb1cf96c751 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1758,7 +1758,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
-	char *expr;
+	char *expr __free(kfree) = NULL;
 
 	if (level > 1)
 		return NULL;
@@ -1769,7 +1769,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
-		return expr;
+		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
@@ -1777,16 +1777,15 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
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
@@ -1805,13 +1804,12 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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


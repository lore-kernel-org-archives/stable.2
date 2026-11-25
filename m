Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642194;
	b=3ucjoPd0wIR+9OfHu1Ra9FG6Tusd+6t4Oqt9Z215BM4+j77Wpk+1B2Fp9f1gOJL9ABqT
	 6TnROs0nQQVzECQlu1tKwNpYgt+vMBaWa9Cv3UcRofm6/ULIzerqqR0Vj6EeM+QZtCSKh
	 Gley97GdS5+bVKECO31nvRhCyf2gafbtdsv86z6TL3SV8bvblddFwFGNdkfm0InZR0OKq
	 5qmwuJvU12B9cLR1Z7zB5gcBBA5mqNyAKSKiPKq0b56/FzhG0Q+XxUtffV9ebLeRxrvnM
	 OqPgGXz14pEsaftGmsue234N0LApQL1DXL1i9WW6GlcIs6uUXxX619YdUUfdqTHNRlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nweU+CAUs6qDkjRnEXG0BocdTF5YLDwigq3zPXOFKf0=;
	b=brDx6Ff+l3fMEvbeeOzX56Ytmvbkdzrnyz2kKEuf3jlHfDu3s0rIT+d1y0gv9ddPX7FC
	 JdCSZmStcodj20SG289HtGl7v9lIIMz8SoEOgzyDgg9cf39gEkaIsxoFRv8umq8m4lGiX
	 ipS4lpsnSnYqnXoliJvdcZydU4LIsA4SdTAzCMmUIcKpkaZPyJrzmbfMqa2Ml1akcWYpE
	 DzeHVuf8qYCbhRSlhRxviTgne2XoLXX9pbqy6TZQrsvBWkhmydhCn4RXS3e5OYZvz1Pt4
	 +YwEYCsI6zvOXHyVIOAA1mIniKCKeoQSh/uBY4hP+AulatyAK5a/BWobA81kUj6Tg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJaYq7P9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5B606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJaYq7P9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97251F000C4;
	Wed, 25 Nov 2026 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642194;
	bh=nweU+CAUs6qDkjRnEXG0BocdTF5YLDwigq3zPXOFKf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJaYq7P96pbgQ16Hpq/w2aYeMyOv6rBUr1Q309vkYUqSdVKzbmBSFZu3iRqnXeSBW
	 rc+VbCFM6bgF9h+JjZBPxsWb3UtnrKOTt5oc5RUcgkZVqdfLZb7ApJ0pXCkOE5ioRL
	 Rkc3QF+kcT9F06Aake7XmAelhVYjkLIt2neBRFHah1BHOPdrhXD/rAE2FqUil/liTG
	 XTdJ9zMlIWkAl5dFtb+OG1aI7GISsqjmDd7ZQxZ5R4a02MLPDXqusm/bnD2lhgwkrk
	 VM2POT6sXNPzUS37flbegtgKGdB7GiPWmgJykWLJyCTs1c6L4QoD6UWQuOxCvWKWFV
	 cRyiNIZJ5cBqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing/probes: Reject array count on non-dereference string sources
Date: Wed, 25 Nov 2026 16:29:52 -0500
Message-ID: <20261125212930.1536052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-broadband-national-e3ac@gregkh>
References: <2026112524-broadband-national-e3ac@gregkh>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 0941144ebeaf3ce46c80711f00e935921eb28b21 ]

The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
preceding memory dereference instruction so it can advance the pointer
address on each iteration. Non-dereference string sources such as $comm,
immediate strings, and eprobe event fields cannot be indexed as pointer
arrays, but finalize_fetch_insn() still accepts an array count on them
and emits an invalid FETCH_OP_LP_ARRAY sequence.

Reject string array counts when the preceding operation is not a memory
dereference.

Link: https://lore.kernel.org/all/179455855309.403392.4197028577158545202.stgit@devnote2/

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: adapted to the pre-refactor function layout with a goto fail error path, and added FETCH_OP_TP_ARG to the fail-path kfree loop to avoid leaking the eprobe field name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e9f09576c1e45..bf7d424058e00 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -704,6 +704,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 * For the symstr, it doesn't need to dereference, thus
 			 * it just get the value.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				goto fail;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(offset, TOO_MANY_OPS);
@@ -777,7 +783,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (ret) {
 		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
 			if (code->op == FETCH_NOP_SYMBOL ||
-			    code->op == FETCH_OP_DATA)
+			    code->op == FETCH_OP_DATA ||
+			    code->op == FETCH_OP_TP_ARG)
 				kfree(code->data);
 	}
 	kfree(tmp);
-- 
2.53.0


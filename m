Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639334;
	b=yIewku1PH0gDCG3a5HBJaikyfjnstG3x+jMtTdBfp378IU0q0qJcO6e1Jk7k+LLJettj
	 n++Bcf+MP+l1G6K6Y8/bw4OSpM+Bb6nn9v/B7zFFMfq3j8TrvigE7tE0ivfRhAci+yJH0
	 hiAd7gNB3murY7AVuIh+xBlRaQmthO7JolBMVjiAE3ErbmQRTfFURJYP40o4F3wVOddzI
	 XKtNXx60nJ/B1Sc3V6FJqYe9aB0uV+oidJiipWiwoGewYgEvmlwLReUGUFlT8k4szpvsF
	 LdSY8HURJq/EeNDc+z5RI62yroBLlc979IBkLzY559k2PoZnhNovglxQMHpsXX3HEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639334;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xMc3sEDUQJShTwjpaQjAm3r41ITNHDx3rS4ADQC7Cmo=;
	b=29PajeDjp8qnrX6BCgy3FeKi9d3Mev6QTaOApRyFKMKp1BxpPG3j7csnqSssWQqX3ULc
	 dWyQpYGQadvHSG1KeLA1o5pzKKEs2aW00Dvq8wUH81OLqeJFM36ksjptLUNFrrfSG68Pn
	 q/CAnNMCWuI9/xB6gHxEUdKmRcHDTMR3iOWnw9pVjwhOsGMwo+qwI69ySQ6kWf5asrDKP
	 qEq0nNUFiCvt2myeA+E17BW/SFWLbJ0DfxSjoFDO07SD1Q69VISwwgzCuSlQPfEe6GLMQ
	 F7AvQbWIwTjSnGoJkO0UyJtJPaPfox8nMW9rEyBw7zgbcD4lkZqLv6IlIyPimjfkkgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW1IU0IF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBC606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW1IU0IF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7691F000CA;
	Wed, 25 Nov 2026 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639333;
	bh=xMc3sEDUQJShTwjpaQjAm3r41ITNHDx3rS4ADQC7Cmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UW1IU0IFyFBJYh5AmSFH1TE/cnzoN4n0dTEXzJkccZVRJdxjDXGoghY6lfNpVpAFw
	 SV4f0tf0RSNd5Qro7q/g1YTKWbGRhJks8Zp5OakEQyqZVtHNNEJIsWgvoqUDQVxr7f
	 P85Qjqgb2hTj/FwyARSof2eyd85xaD4F6626TXvq0+C4/Rkoxw99nTwTWJMwbX3ex0
	 IEIhMI5VBpeRztVFDPzrLna1yo/y87C0P6b+YVcKG9PqoyHWDqTj00un0ujg9b1y1f
	 UzINWf63PAAdxGqtBa4QSQ1qEfbUevvnh/lIGJmrJwmuUK5Ibqwg6HC5zpCr6BH4iC
	 /u+NoNZGpT98A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing/probes: Fix user-space dereference string array store type
Date: Wed, 25 Nov 2026 15:42:12 -0500
Message-ID: <20261125204200.1464708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-periscope-fretful-f22f@gregkh>
References: <2026112543-periscope-fretful-f22f@gregkh>
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

[ Upstream commit 2721573e6c6faaba2e31f352f2c02ec5f3ecf5e9 ]

When finalizing a string array argument (e.g. +0u(%reg):string[N]),
finalize_fetch_insn() advances the instruction pointer to a new slot
for the store operation before checking whether the preceding operation
was FETCH_OP_UDEREF. As a result, user-space dereference string arrays
with type "string" emit FETCH_OP_ST_STRING (kernel memory read) instead
of FETCH_OP_ST_USTRING.

Check for FETCH_OP_UDEREF before advancing the instruction pointer.

Link: https://lore.kernel.org/all/179455854396.403392.18073771811100192405.stgit@devnote2/

Fixes: e65f7ae7f4da ("tracing/probe: Support user-space dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Adapted the fix to the older inline code in traceprobe_parse_probe_arg_body(), since finalize_fetch_insn() doesn't exist there, and adjusted the context (FETCH_OP_DATA instead of FETCH_OP_IMMSTR). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e9f09576c1e45..1c250ca48f133 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -675,6 +675,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	ret = -EINVAL;
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
@@ -692,6 +694,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				goto fail;
 			}
 		}
+
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
@@ -711,8 +715,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			}
 		}
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else if (!strcmp(parg->type->name, "symstr"))
 			code->op = FETCH_OP_ST_SYMSTR;
-- 
2.53.0


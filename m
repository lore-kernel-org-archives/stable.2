Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639945;
	b=GsrlSXMQPiIzELpX5i+XIXu7UnZrhHX1OIlORqvOtUhgeS9Bqwge8P7IAjOGHsT3ZuQg
	 YrcEZgqpIuCyEpreqUVTfbLH86f1ZAkNbDO9SSVt1PS04xdxbT5D+9lgpPgDhqYAsZ1HO
	 aBVS9GMt5wGJTgkIkh3j3xxzxRw5jLwwJdLcn4brP6MLN3fZT9fdwZOH0Rg//eBp1mlgg
	 mn2aRHAWw6aqSqQUPasCfXccT8xHctVn5guQsi+4qbPtzCJ+E5dqP+5WajMRJVKLoJl7M
	 uGQDGMTeRSYlmRm4vC7feMLTURErYe8D7XZ/p+qcONgcw0rvv5+qHuKCbOoXTv4TvDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JmnYOSnSI+lUsuJ1iT+RdbLZJvo0vjGjXB2eQ90ufZQ=;
	b=D7TkDMq9ZRuHqVxBtkHFX/AdBTL8HmN/NNXLcsNe/s1dwuVzwcjMwLpveTr/XiP+hy+x
	 HVQSLFcKcln6UIJf7aTdZScxO7jxMLkAU+oaN6h5StGpcYWOBaCu3H0VTpBGnTK3pD8Ls
	 ArTTEwanj9zRR17UlBGrPLCaTLQsM491rwSglG/jlFI7/+HDRn6BbeCjPAS+1/p+Po6gA
	 yZjdnXbP8q60SY9pfNCiY1CtDAcwiKCOSeUJ1z080gm+5kEJ0ssielueMnoyzWGprGcds
	 pcUdt5VOop8UIojxLi+bq7NW6Ls/zROekUGkdOfsNFFsCNvTC+jGa0RJV02g4fhE/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsPIF+HR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A02606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsPIF+HR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DFD1F000C0;
	Wed, 25 Nov 2026 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639945;
	bh=JmnYOSnSI+lUsuJ1iT+RdbLZJvo0vjGjXB2eQ90ufZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsPIF+HRJ7pFqqNyp/VcgrU3iESILwmIP6TmIqA8c5VgxY6eWuI7JX+Bqw+FhhAjl
	 eEKtyDjE3SBnMN5XZjafKGP/wseEjZ3OX8Nwa/H2ipjlLFVOXqKiBPhpV3iQFE8Uj+
	 nCOO0jA4I3ttKT9+8PCJk7GHjTfKLlAOmWGJM/e5BPiias72cbhkALN8WRZShpCkGS
	 +ht1Q4O0bn+LzpcCS25PlR8m0tRDliV5fdedDHW1OEb+Pd+zqLrWSy7G+meY1Vn6Gl
	 SyczYActDL6NbFX4CbcB1gCjnQkpJj2Wcm6OM0ZuvRhIL1BezgcmmzdZzaWiSKYW3a
	 ctXLDl3/ForYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing/probes: Fix user-space dereference string array store type
Date: Wed, 25 Nov 2026 15:52:23 -0500
Message-ID: <20261125205212.1483348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112544-quack-omit-0946@gregkh>
References: <2026112544-quack-omit-0946@gregkh>
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
[ sashal: adapted the fix to the inline string-handling code in traceprobe_parse_probe_arg_body(), since the finalize_fetch_insn() helper and its symstr/IMMSTR/TP_ARG handling don't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8613b16bb11f0..9b242902ce276 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -636,6 +636,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Store operation */
 	if (!strcmp(parg->type->name, "string") ||
 	    !strcmp(parg->type->name, "ustring")) {
+		bool is_uderef;
+
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
 		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
 		    code->op != FETCH_OP_DATA) {
@@ -644,6 +646,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			ret = -EINVAL;
 			goto fail;
 		}
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || parg->count) {
 			/*
@@ -660,8 +663,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			}
 		}
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else
 			code->op = FETCH_OP_ST_STRING;
-- 
2.53.0


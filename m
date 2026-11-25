Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639036;
	b=frWmijEOC4O9JM7oCn77ZSMh1YhTgcs1X/qHtI4KYQruQqpf12ecAX48wkDbkoSy3Ds+
	 Gc1RkIMEIFi+2qFlupXch44S33ZCRZRS9yABVMId6RDEtjPPF3WE06FQH4smhqAeyE8Ad
	 6Xk+qnnIbBa8RCnQLhKEBRnwYu6bCm64wFsveMzDKSTjge/ASPXxmJkcQdGbPwy+ovpIj
	 zSzV4lBGq9Hbvt8hrG71hswUEPCU6TeFuhSm8buSIOaU2Rciv5cKfeLvtkc0Bma0jepu/
	 hwSj4F11R6DRjHOYi3Cc/xhLn1ZI5N6NQzQcGu42md75yGlbWiOFbRnWZAgLMdDhC3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YfE5Nsaam9raimIAGJfkOSiO5vhzJmJVbn5xiySEvSQ=;
	b=XHbRW+rcmVuA8wsC6vbHP1ujgRou8VrMU8vg+ruzwt3b/asLbB9p4av0RLcnha+8WakL
	 uvNqQd7FqipCITHWZQZLztDnjQTQnoMh/jO7SYRAneub/hfEuYaH6jAZ3GoSBfnpZkjQH
	 dEge7IVmtJjG63tHobVMmf3ARXtAPBY7ZI6YakxdZnL1NWn8OfaPFJeRFYurhzEFl7MBv
	 okaE1+kEOG3zVbSxOibohq8pKKKtC8shC6YLZxI9Nr/Uf7YHUboN6NaFncbW7eLyrU9h0
	 N5R0iH8h5+/T627MyBp9e9KL6qUHT9rKB38IFBfbqIRtVUuovQif6bqlm8Ek8HbMjPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmcriStL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE7606A334
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmcriStL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B271F000D1;
	Wed, 25 Nov 2026 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639036;
	bh=YfE5Nsaam9raimIAGJfkOSiO5vhzJmJVbn5xiySEvSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CmcriStL5gqpr99yHfiUaomG8vsbrWrzq9sPqeHXO/b0NIIAFVwCKAuy0c5YjAcWl
	 DSNKd8t6IFUKJSTQehOoItTTpR4wfRKY5YyRftRJGev1HLeuvE4xQ7R5l5B3OLG9oN
	 tq2iJ/r35wSGpo/5aZP77ONP3/gVOTvNEMqIbLfv9gPsY8gdZZGYgVIjDoVv4NGGMg
	 yonnrOpV0X6xcK4AP9vZeKk/GuXTxlMXAkVjievwg93rG2uuuqUGvE3CXM2ZwDcorP
	 OaWp5biOY4s8WA+9ysb2PTfAQNRA1fYsm29yfG7541aQ+ko2jGQsMAViQecBGYF0sF
	 5+/BXYeo6Z36g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/probes: Fix user-space dereference string array store type
Date: Wed, 25 Nov 2026 15:37:14 -0500
Message-ID: <20261125203703.1441513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-bobsled-cofounder-303b@gregkh>
References: <2026112543-bobsled-cofounder-303b@gregkh>
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
[ sashal: Adapted to older code: the string store logic sits inline in traceprobe_parse_probe_arg_body() rather than finalize_fetch_insn(), and the context uses FETCH_OP_DATA instead of FETCH_OP_IMMSTR. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index f5df2a2d3681d..9fdd0cbf50143 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -679,6 +679,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	ret = -EINVAL;
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
@@ -696,6 +698,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				goto fail;
 			}
 		}
+
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
@@ -715,8 +719,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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


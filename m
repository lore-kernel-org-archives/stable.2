Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638531;
	b=0G5Zk/F8RL13gpVZpwN5KgArBpc7REu9cptK+eehH8zNO6hxIfdNDtLJHVbHW2KQYKz8
	 Tt8X3Xwlm9avMQUNXb0ubSzG3MjFAJKXt/stT8oaZ/MOnApNSdMMV/E8yI9t3gJfl4fzy
	 MkzrwVCQ/6fB/V+nDItO/uG9K/gGVFR1za5qjN6m8tCd71+m8JRpcvjFVxPYwSCMW8CGq
	 ZNbCSJoqXst2szfuHIlIoMdwUjHmv9hS19awPq48epdJsYnWSqNjHVHJNC9Puwolg0YKf
	 JT+MFYWdoAq83VBWhiYGkNsnDpSnqoU36w0c1P4ZuIEb3LJJiPAMVKSOC1qjY2gEVPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PpLn6yPX3Eo+oazpEDgQlQXRkIYzVNNj+DW9Rynl9y0=;
	b=cInPj35jxy4zdolAh3wAQui2wPyBNlyjLQHxmRLE4Ic8Fd6aAIrt8EO+//KD6GDVQrTg
	 gIxw0nKRcUgAHnF7UHK7aHqWrrqITNlQj/RPEgC1jUC/42UpmHq4RefBZcYCxX2VEmz5B
	 31th2BQNh+2q2C/mQvFo2+eG59dxDAgX1kDOHE6jPK8KPhsWnqD3RcD6H85MPQ6w6OCTK
	 OvtMieqzi7cW3DQrLUQEOJtGbCg0qjNyGSi2ouGo8k3dxVI6sZpRXwL3rx2AseI6GYFx7
	 vKurAwkO/qfabdWjvC4Kjrj7suCvS5miaUDYGercf7kd6JFuwtzZayi71n23Uxk1RDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFyNELfa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFyNELfa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393251F000D0;
	Wed, 25 Nov 2026 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638530;
	bh=PpLn6yPX3Eo+oazpEDgQlQXRkIYzVNNj+DW9Rynl9y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFyNELfagjvGdAflM3U1S7dgGDWPsSXOXgjnH3cqATetAtsfYS84dX0/Paz+ZXKc2
	 JlkwLw72swckvU46aoxGI+EHl785jEIDVWaLJModnDTkBWI1/Q/UHlwIPyYqB2f3KK
	 0hSKMxrpDRHNfRsy5IYJS7Tx7MUiqgM4kopmXIA/tnPCZN3uBVhsaHe/joLO1mEKJB
	 1YzTxernMxpXquO2N3LuHt2N+QPqCtMBmv9YoCbNUTlpi/du8cJ+UOPpa7ErpEM7Ed
	 BIAchpfJ0401juuaY0Fghal1oQovBkTjzABO1FbT/2fN/GRAkNzOmobNUGTfBTxoHl
	 MO8B5twSYYflw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing/probes: Fix user-space dereference string array store type
Date: Wed, 25 Nov 2026 15:28:49 -0500
Message-ID: <20261125202832.1415785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-secluding-hatchback-2d84@gregkh>
References: <2026112543-secluding-hatchback-2d84@gregkh>
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
[ sashal: Moved the store-op fix from finalize_fetch_insn() into the same inline block in traceprobe_parse_probe_arg_body(), and dropped a context comment that doesn't exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4265518ce967c..08cac25e6a2fc 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1384,6 +1384,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	ret = -EINVAL;
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
 			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
@@ -1401,6 +1403,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				goto fail;
 			}
 		}
+
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
@@ -1420,8 +1424,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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


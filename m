Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643132;
	b=gVeZQnlcOoTx7SHQtuctKHy4oc4HhuhIYRCcuV9KXmeqKQ2mZjgUCqGgVRCtWZKP3OKR
	 NoSEaFnkpmbB6e8pXKySOXcIORgDT/Gfnlv3oWlovCvpHRdvWcH23mw/uIF38y4jv392M
	 +PaUFw3CmYnD2QhlrrPaN68ZhoMnJWKXqUucRPZ/BuiHcUlmRWWVbGwHGddgxdMZGtjU3
	 /vjcqR94mTKDmsRtWbefKJjtcIkUpPRz9kZznDj7bMux14OXQkkR5msfJ/Lymw8POGzmz
	 ghMpch25d1GsjBLriMIiq+bHgFVEGBVcKVOoOdyJh382bAi+CvTsQ/ezgHWwVH29sYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643132;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=omkgVtNdGp4t1YR+Q4z8hB/keL7yw6TMvXV12NKNUt4=;
	b=4UC4geT5Lvw43xoGbcu99WH+PCjSwlkn81vmGKKCCfcSeLMnQcztElMBvZNMHq9KVkcj
	 g03el8UeCTPo199Y3kbZjsLkM/Mzl/fUAaNlDzg1I5NXhVZyQOVSoAijC0WgAYbFGb9J+
	 kISacOKrJ3W5GP8kLGTiJP7YoQ6g+Q16VaCFxME/CjtUhUOhzEuTjS8DMZZG58Fkndh/d
	 JikLBTrgShi1yNSuOhM7p+MxNIIVQy+DPEEibvPPr8tO25VkoB+1qBDmSfcXJjdYsvgvn
	 a72NmRTm28Bjh8wnNAB4AldwzXggk1URMLAJIiOa4rxgv8Wa11rCUQ5Ab3v++gh89gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYYtxx+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88930606A336
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYYtxx+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110841F000D2;
	Wed, 25 Nov 2026 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643131;
	bh=omkgVtNdGp4t1YR+Q4z8hB/keL7yw6TMvXV12NKNUt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYYtxx+i9KIc5X0V2XS4iM9VeZylYo1bszKlP8Y3ij7uwTgAiaUU2KloL3LX+VKOU
	 vd3nbWZdjWyW95Lhd01mTY453iK0prKlq4eK27AsJFhofPK9Hy/WuakCkgaOJxsHmp
	 hUh7jRSvPRfo6M8Wh74UfYnYgIQ2bCv12kH4xpsVrao8VmnweJgWpPIgb5hz9+3VkT
	 yvP+Z5PkeniB6ubuKcxzNtZmvlC5C1tcDq7DyawxtlJCHEy1aQbEwkl1r2J4Vsgjy1
	 h9nJHMzEdI3xJKCqusMwzaTAEt4oOG/50zlbZJ9mPBbCtKm7T64eyEZUFUGyVWsXHZ
	 q70w8EWS4eVvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing/probes: Reject array count on non-dereference string sources
Date: Wed, 25 Nov 2026 16:45:29 -0500
Message-ID: <20261125214507.1566623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-deflator-chunk-bba2@gregkh>
References: <2026112525-deflator-chunk-bba2@gregkh>
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
[ sashal: Replaced the upstream ctx->offset + type_offset and bare return -EINVAL with the local offset + (t ? (t - arg) : 0) expression and ret = -EINVAL; goto fail;, since the function has no ctx and must free code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8613b16bb11f0..eaeae5a3c391f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -652,6 +652,13 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			 * array of string pointers instead of string address
 			 * itself.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				ret = -EINVAL;
+				goto fail;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(offset, TOO_MANY_OPS);
-- 
2.53.0


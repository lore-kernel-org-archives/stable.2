Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640634;
	b=MXK4PfZHZPApAWdVc40I6Rq/iOGbYCZ/jO9TuO272tu48ST6BInOohj0ii1vB/BTyCif
	 0wUbnAEG7F2i8S6ErX+plZEab0vT63skpBoZKxlARDedTKAKigmHeR6iaBp+HBq4CkUPn
	 eMe46FIQNd3T82j/zYKfgq7A1Hl5fc4f1oahP5wqqrTaEjA+K1r9F5/lAeoRG9DC411TU
	 wnyjmb2xjEzXfkVKGN7iM1fRzYX6ZQZMQTF88ziNxmrEiRytpSmnzC4pSbIVxmcsNSDZQ
	 dU2HhUjVNpcypaz7MyzPwpezQ5HxsvrYzH9L/7o9zYgbBGi3y5/1+MTU1f9eWL6TAQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5OTAK1uAtegPpsHOSYypHM12nsFNRGQTE2lcrsXD3XA=;
	b=GlNB/vfc0nlW7XZzD22JtLUTE1/QxKzWAvcZxiy8cYjoVlQHqpf4J1LttXFT/h3P4WGt
	 cCwgNCZ5vj7aTzDgR4LFXBDuMNv2o4Qr+OE9MWET+3buuHz3tr9oJeVGY9AuULNvfVjNH
	 tLacMrwMJ1/38mfa3WHN7eWVLysJUMgZ7pWGV3XU43Nsd70ujRBvVBiCV7CIzSW8oEys6
	 GKRj2duW8cGfaqHntAX9+CZ5N696vZPv5N1m3D0qUb//Ll6ifJefQFR9psvtQJJSAmg7F
	 L0woYRwMNmqFcxsHHoJudu8q48tgOtGBvmx8eSvPgT1M/os6F2kvJMosAb7+PYjZqIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkQyak9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC28606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkQyak9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847661F000C4;
	Wed, 25 Nov 2026 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640634;
	bh=5OTAK1uAtegPpsHOSYypHM12nsFNRGQTE2lcrsXD3XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkQyak9taBwr50tvVkuyOgnBHoMLEAHvAzz0SKOj47LuvXJdMElPB35Lv2My821oS
	 pBhEl1LoRMa3HGWIRdElA6G3WIJEAkoQwxpoXeXMwHPeU1qkQZUAcCTG9OJHXXKJXK
	 QLcAstMWLfj2zGdQJCuDMWcU/fiagZHsz+pr/crhRiJXdDN89Yr47EIbj/BzM5EwSN
	 /tpNKc6NrK/TbxmkLArzQxiHJo/6OY3ChDoxPwGIcjV+ZbqeD+eOr4IDQLnJpUQJYj
	 7fV5+CgA3uzE8pGdS0hp15+Vg4xb7yuIzjwmjY0FAoHCNnU73aTMqEIRIS7+1NrXXa
	 U9MqlaSkcIZ/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/probes: Reject array count on non-dereference string sources
Date: Wed, 25 Nov 2026 16:03:52 -0500
Message-ID: <20261125210328.1480331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-glacial-playpen-f78d@gregkh>
References: <2026112524-glacial-playpen-f78d@gregkh>
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
[ sashal: Added a check rejecting string-array counts on non-dereference sources, inlined in the parser with goto fail, plus a FETCH_OP_TP_ARG case in the fail: cleanup to free the string. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index f5df2a2d3681d..0a02919e6291e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -708,6 +708,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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
@@ -781,7 +787,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
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


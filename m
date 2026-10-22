Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678146;
	b=dXRHc0dwNJ22wYB2Mf872sR8Fi4FB36SNcjM1Fa2uPwjvp4gl05TKRaJ0WsuaAcLbeiB
	 PUn3Hru60IxWgho+XYhDatoVLnEFvcsmHc+xavQ/B0aetjUcAY7RM6hdmUYvitDMbbZRg
	 05Gwy/+h4M3QAqM6rppClYZCJjgIaATTPYEoz3aydNRsApV/KL28PAaoBqJggvNj77eou
	 2fmclYBuaEKGR3jqBsJhxBT9Qdxj62VA4QBfenYnJ/mGXCKEFVvV5KnstMVwuut2MP6NN
	 DxRyyWAerFE+t/0NlzkQTPJnzXuI23HrExZcI4Z+gJHNTYeUm8NzgbUYsRCbXDvXg8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Des9Er5fxTgJUhI8uLjnrvM3lsEQs8KbQboamZltPyo=;
	b=pl6p3LU69oI8lNfLo74D5wZga9JMqnHSfMva+8/0eQ0WTYYhwFxEvdgfvP5DiScix1/i
	 u3GhDTeUcDkWYuN2zvTP+XE5rY7HhlfHnizLqXCg3flfKPiF2l+F+2oCdbNkCrWikJ7Uk
	 UkFSdL4fgvwU1HM6si3o1w0zJhc3W0U2XJzchASmOHLZSYnUVXMttO8gNY6p1Vu3J38fW
	 rM29OktRbPCK4Nahx94q+0Cc7DjkGTrXvlIU1VvIV8YlYIf1+pAPloloSghb5rNKqowf5
	 Rb6qBbtDjZXXs6uzw7pWhZp08qXm76bmqFu2+K2xsr/HDXSiuCPnlwbUaWLQEeBlwCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp9ND22n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3677606A32D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp9ND22n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171D01F000C2;
	Thu, 22 Oct 2026 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678145;
	bh=Des9Er5fxTgJUhI8uLjnrvM3lsEQs8KbQboamZltPyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zp9ND22nTfWZN2w66LHEej67NNtBgaNa0kS1bRYR6g65quRFwjsdVodl5+F0YKrSP
	 dDU2j6gUIR4zHXHo5r7u0gH5lxwgQ2t8RWPXiCggwoqAlDwxuSzvhrntuoleDtSZkp
	 oKxqY62HLf/M+mtaWg46Qm3PXl5Ij+qkULn/6g1WxBD5wyrrTiOw6tdsCvZskadF8Q
	 XiGYQDlwP2ZYZUTvDsVzOcstYxvsY+ddcxNM5A8RYa9//UxBtHk25jcDxMzBk0i+n3
	 m3ovmU4BSwOQ4cKH6jvto+ch7XszORJF0WraqOb5lyTo0JngZgWVEM83r/ubqRJhD5
	 Ba5jJ/v082Erw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taeyang Lee <0wn@theori.io>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing: Keep the predicate limit separate from program capacity
Date: Thu, 22 Oct 2026 10:09:03 -0400
Message-ID: <20261022140850.1513412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102144-unhappy-crafter-afa2@gregkh>
References: <2026102144-unhappy-crafter-afa2@gregkh>
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

From: Taeyang Lee <0wn@theori.io>

[ Upstream commit 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445 ]

predicate_parse() adds two to nr_preds to reserve the terminal TRUE
and FALSE entries. It also uses that increased value as the limit for
parsed predicates. If the initial count is smaller than the number
actually parsed, the program can fill the allocation and subsequent
accesses can go past its end.

Keep nr_preds as the predicate limit and use a separate value for the
allocation size. This leaves space for both terminal entries and a
zeroed entry when parsing stops at the limit.

Cc: stable@vger.kernel.org
Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Link: https://patch.msgid.link/atELCd1XjKVhrkFL@Taeyangs-MacBook-Pro.local
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ sashal: Adapted kzalloc_objs() allocation to kcalloc(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ada02ae893c20..cd89fbf2fb208 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds_alloc, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
-- 
2.53.0


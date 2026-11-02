Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622439;
	b=cnGXeMhKMbDuSzjZo/qh54TU0D5nCf3ES0cYyZ3lnDobzwBUzerNUgUO5fLY3iIL9Qv+
	 l9HdmDSQ3C9KZrltB1LYUj5GainRMCL5TfbUNxrdkbrQxAcF7bJnUvN6W15mzbN9X8bvQ
	 s/vb7EGz9YDHuJvsumkF+smL2SlZX7xl84/AUILMEuOT0/GPrRolp/8o5JNakIo4cYqq2
	 K/PVPie9tJ9DAl0v6fYLxz/67UGGhwIUVfqKb/ow4TcNN/ATe+1fDSyTG5Bq6flZT9b9k
	 egwrpcl2yNlksfex+dEQuVa1dwTAOPvxS2QgK0m9Aij4aWrTxvpkg8lNpgDQR6oJ4ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dWeFzrm4tmzGqdpwCPQdK9Ie3fl1Bu5Kg+/Kvvmk3/I=;
	b=OBkCzZwvL2Wh+B3ZRsSTqlFNxF+tXKqTjm5KOpcXLjULwkK1CeooVHH9Fn9Eto3qDW9/
	 5/F7v1rV85N1V+Qm4U8i6TYa09GAfilCdscVW3XCbfpKdeq3OOk8zI8rNOGnD1h1DpMEE
	 djKUveyww4Wt6+cUyUgtLkrV4S+NgKwQWCHL3kyRMGPisZjsBucTbksTYiFHOWpRHTB8g
	 k3n3r6nZEUUr8oWqTznY+nQG3H7lK+JvCWSlCqMJoinnjCm6rvOLv6cQi4rlc5VoeKn2C
	 ExhonV3RX//JfuAFQa3ksUzs6RK9opC7VbL0k0CNkHNsIXq7hWFj8QmbtvL0YWpZwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1LwG04l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A669606A782;
	Mon,  2 Nov 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1LwG04l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386261F00A16;
	Mon,  2 Nov 2026 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622438;
	bh=dWeFzrm4tmzGqdpwCPQdK9Ie3fl1Bu5Kg+/Kvvmk3/I=;
	h=From:To:Cc:Subject:Date;
	b=X1LwG04lWOCJ9gCLGDibqbsTOEhzUX9JIXgz9mnlPw04Diy54A4snnFcEf5UzJfD/
	 kGFd2X+Jk+bH9YDvFTrCieVRsHSQaohz22AXk73tnrleNSb2KeNZ7u8NmDu6+V7VNw
	 +Iv/9JzZ5lkYuRzHca5ku8Q6FMugGiithSGwcAerFC6TYJwBTFhHwC+xXUT+I2v5ys
	 C9vP4IKHUM6TpKv7xVKxG69njkEbAXewtbHhpyDc9noXIKkuu3YJ/jMMIi6cOt9QPE
	 mC9mIcZUGW/NzReyLu6qNZicamOqhql6Bpq//GYFvohABNu7ISPAxFXoN4oik2iwtG
	 Cb227k4APMYZQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Zanussi <tzanussi@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Taeyang Lee <0wn@theori.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [STABLE v6.1-v5.10] tracing: Keep the predicate limit separate from program capacity
Date: Mon,  2 Nov 2026 12:27:13 +0000
Message-ID: <20261102122714.656104-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
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
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1c4e81b3fff1..3062ff7ff09d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -459,18 +459,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
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
2.56.0.317.g454f8302e1-goog


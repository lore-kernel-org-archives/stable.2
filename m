Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594956;
	b=wBozbtfbBFlNvZ18UO6axaHM64tLpRd72HevRV2MldYpEaTNzMi69gmEqCiDZ6s+KbrP
	 4DDpsnvMB/PUh1UY6eTh0iP170dndEjGBIjwehGYAWKNyUuefWpFcmg2FN3sRd8SupAYu
	 toLR9X02SsbRqHcxc4dRnwSCvMzd+8d4KLNxkySfg8g1mgXOslBxH1dXfmQDOMmBTBPgi
	 +d0xJe3+6dmD8seJP+nCKseYJhC1r4fNhIvs1Rz95SMymAZ1DgeqUjhXuof5CNaNpQtl/
	 wkp8sP/+IAYgYwRdFQCNIZAYY1Hj5uEHFrQ+nmAav+iAQXdLUtgs73wYw6cbcHJWXUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594956;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3G+2OkvetPcLTJbfj+WbEx55KYlx3cuGp74ttWBjPzw=;
	b=5dn0sU2Hc5c2we/C3dB5NG8RW2lzuYi0RvOzmruXviP3jIn9WI3VvLtq43TqR6Ie6IsM
	 qfdoJFzH+0sKrQg3TDUoelW5U0abOKXSyahrOyxdLKjmay6AzPkYkUr2XigZG1p+ONZ5n
	 N2hYo9RUHMrpNfqk7AZzmndmRM847AcZ75/X5gFtHCIyQXB9GDaJqWBFTd9KR20T+azZ9
	 B2M0xESEFKeVDC0AVHkab7OB/kc3X0FTR27U96JjJ0ZMKkrVJGzVpEgLpXxKJAaYPvZhW
	 5sfR/lb/0tDPkpwU9bOSbw0K++KS6d+2bS3oqpMvByamKaodzGx2v3BmNvVE3zwGLXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SlwiuOd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F04606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SlwiuOd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA31F000C2;
	Wed, 21 Oct 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594955;
	bh=3G+2OkvetPcLTJbfj+WbEx55KYlx3cuGp74ttWBjPzw=;
	h=Subject:To:Cc:From:Date;
	b=SlwiuOd2Gdh9pgaeq0HWbB8BKRxD5OsPnl4SUlUEpd8hwiyRXwwvawnQjxYuHTCbM
	 621TiYFFq+pXDxdZYgiUN+S2csoEuySqptRpM4yFS+Ba1Li8YcHGgNnZw4VeohYUKD
	 Jo0j4UKISV3pgjxg9zFF2snmMkAGSFT4UyfycmDk=
Subject: FAILED: patch "[PATCH] tracing: Keep the predicate limit separate from program" failed to apply to 6.18-stable tree
To: 0wn@theori.io,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:43 +0200
Message-ID: <2026102143-backlog-glove-c78f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102143-backlog-glove-c78f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445 Mon Sep 17 00:00:00 2001
From: Taeyang Lee <0wn@theori.io>
Date: Fri, 16 Oct 2026 02:19:05 +0900
Subject: [PATCH] tracing: Keep the predicate limit separate from program
 capacity

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

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..781416ba6bdf 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_objs(*op_stack, nr_parens);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kzalloc_objs(*prog_stack, nr_preds);
+	prog_stack = kzalloc_objs(*prog_stack, nr_preds_alloc);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;


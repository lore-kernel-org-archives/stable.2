Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594960;
	b=LKFeIt3P45qXQs9GvZyfi0L+vmHIrDeRFbQiF61fUrcTcJm9hss/pWRLkpM6ZeQ4lOOI
	 uBbS1mBNRGWyQSKL80ca8xdLNcxJ9bIWk7UzaBS6Ig7yMGKeIRcJdf4N0+AGOGL8OGFJg
	 CVbTe877QTlkmBtOQm7aAOo4aIxgg84cgHaDeLr1EifK/k390VkH+fOqM30NLUX6zIYC2
	 Rt2iTvFS93xIIGkLfI/FlsQgC28tnFYkFWTe2F8UYz0CVJ5YyfWL/qrnRonWjm2q0RZHM
	 RLk3HJWmDMqonIS2rupQBBTfGxtZUMldDRmsFywmXUzG/n9uAz8/lrxn2Mvpde+r/vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594960;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ruFLS+ugmQj3Zd+42tm7F2CnTSZe2d6VwJ94J+cA0WA=;
	b=NBJu3Ay1b+H1x1GmPuNv7drqF0Cf4hjrZWpVW3mpvEUoz8yTTbKQCCB26iUcz3Pb9V9i
	 FnrhGv7ARAGNfaBFl1sKIvvUAiBoasTK/tnl+H1bbIn3nemxCJx9WQHoQ1gKW4A7SUCgE
	 CLk1lMj1mPSnEAF1foPI3kk2j2OXAC7/scDUOIBnPDSFj2HVQ6Ra/1Z4oMjoUmfuGXYu6
	 rSMCBxvl/3kxCFBnogDaTLIBiQGdUVK7nGC3c43hSkL0vxT5BIvP2a9BnFRPP4uo8q0uo
	 grSw51UmkcklrtF/V6gWzsBXuOW8XQ876c0XbkMk6hsmEbXZRpZ69efYyEs9y0zkH8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T0YtoIcl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808C606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T0YtoIcl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A393F1F000C1;
	Wed, 21 Oct 2026 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594959;
	bh=ruFLS+ugmQj3Zd+42tm7F2CnTSZe2d6VwJ94J+cA0WA=;
	h=Subject:To:Cc:From:Date;
	b=T0YtoIclsA4bc2UF8s0wXm/FPwFZtgn41aGToinuCrkHK3lG94vCaF7ZW3izc8STJ
	 9Sg++GEpOIec8VPMuaVvhnrssoD4cpYlbC5bYP7cCn7nqGoq5X8ZGpqTctEbn0ewFL
	 8Lx7gFwOKvhL4/1SurUL+KoKQU9rKKsLNtDVyHFU=
Subject: FAILED: patch "[PATCH] tracing: Keep the predicate limit separate from program" failed to apply to 6.6-stable tree
To: 0wn@theori.io,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:44 +0200
Message-ID: <2026102144-unhappy-crafter-afa2@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102144-unhappy-crafter-afa2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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


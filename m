Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0128505E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918451; cv=none; b=uYkDqXCn4L/03lgUsAhPzFIyUkoTYx4dKpF1xr9+QaI3kM4/Ajw3AF5ZzOiyI2YN8P8q5+T/zB9kQ+BtrP+2Z8Wb9zdOs1lrLz6Z4mgDt95I+FahxxJApTtOFuDaHTU9fxpi/JNsPD1J6ss1N4K7HEOpAJun9o5t64m889Xxa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918451; c=relaxed/simple;
	bh=b7+ix9TJk2IDMjxl6FzJuEnYtEwfyGTBsmlNcMhcwwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhCEnysJrDgsPzOBkUYdvmVG7HJIAZdF7dYWuoVQBbebL6CnA5Ca6ioM843xAnMvfotkTIseefCBZJSb0y5kkFyNwk0SOIPZHpJRvdEYQfZA6c8SmIA7YcXUt9F4GCzNTjnW/0T5rd7kFDEy7QIOugIEL1DqDx38iaYzjcG1yJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVtAD2GW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVtAD2GW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04171F00A3A;
	Wed,  9 Sep 2026 01:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918450;
	bh=hKx+Q8Z4kAZCdvi7jA1ZX/HLAx1ExIvsiXQi7W5tgSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVtAD2GWVMHRaVdFHaJTzdZe4RMqp6U2fgDj1zrrnJOC3l/5NhuxTD4U/9CiF+H09
	 +5HAm8TBRIvdC7+MSvIwS6T6m6YzxNS1Wnzh4wdWqRm7YPvcmvEAmnoTYGCyuN6+19
	 Jq+zDZ8ws7yVoJN3YmIV5NJ3Kqkdtrc3FIlzHPZI1InWJ2UZVw3zJfnM3dQpolbQaS
	 /wBhb0emeSA5C6p3o2MYHrb5x+stcexvlTXgSfObW0EmS62mNmoaerEvAxYscYkBfP
	 7AWkI/DZa46edRpCF5S2XFw0A0Y2Ab3pNy9wGOrygyKbDAbpNI6RPP6vnp4gtu49fL
	 quFWdPSHPoV0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 21:47:28 -0400
Message-ID: <20260909014728.928965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-lip-cognitive-6180@gregkh>
References: <2026090350-lip-cognitive-6180@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit c479bde671cbe2f9e152834a8b0eb7c3c295bbaf ]

svc_rqst_free() frees rqstp->rq_argp and rqstp->rq_resp synchronously
via kfree(), but defers the rqstp struct free via kfree_rcu().  After
svc_exit_thread() calls list_del_rcu() and svc_rqst_free(), there is
a window where RCU readers that started before list_del_rcu() can still
traverse the thread list and find the rqstp.  These readers (e.g.
nfsd_nl_rpc_status_get_dumpit()) dereference rqstp->rq_argp, which has
already been freed — a use-after-free.

Fix this by moving the kfree of rq_argp and rq_resp into an explicit
call_rcu() callback alongside the struct free.  Resources not accessed
by RCU readers (bvec, buffer pages, scratch folio, auth_data) remain
synchronously freed.

Fixes: 812443865c5f ("sunrpc: add a rcu_head to svc_rqst and use kfree_rcu to free it")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-4-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ adjusted context around svc_rqst_free() to match the older exported function with page-based cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 92d88aac2adff..06ed7bfe11620 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -841,6 +841,15 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 }
 EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
 
+static void svc_rqst_free_rcu(struct rcu_head *head)
+{
+	struct svc_rqst *rqstp = container_of(head, struct svc_rqst, rq_rcu_head);
+
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp);
+}
+
 /*
  * Called from a server thread as it's exiting. Caller must hold the "service
  * mutex" for the service.
@@ -851,10 +860,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
+	call_rcu(&rqstp->rq_rcu_head, svc_rqst_free_rcu);
 }
 EXPORT_SYMBOL_GPL(svc_rqst_free);
 
-- 
2.53.0


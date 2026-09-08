Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB554936E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907040; cv=none; b=hn8L+xDvq1P7yZ5rX1IHaMC4nx54ukok5gEXm6UjS0lpfxDO9iv4ADh0+By2LJytadfL8ITlxcwVilT74xZx1mUNSestn7qLIjXi8/mVvHa+DNx+Gty7/gYYCK8/AwwQt8MmpqvkI5LCizlpjss0A/nX0uQjfG17kgkGOmN2ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907040; c=relaxed/simple;
	bh=dX7lG/ioxdPdqrKib+rCIYvMSEmaHpSZY20/epeE6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAhUYhZ70qie1xpTz9jZphFhpor8zb501EICJri3N75E76TgkoDWGiR2IJVzEBr9kNpLPAm45rgMWmprQnWC8jOawupf57O9w0/vL4cLL9F3ta6OWSw7ug50qGBKWPo4D2tQ+ZzhO1nWlKe2ztVhOhx3sCOm1DdUrt9tiy8XTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dllVxjv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dllVxjv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A21F00ACA;
	Tue,  8 Sep 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907035;
	bh=agVfxgLIJ6GBmBtE/CE4KWWkQYK71YXiUfrd8eNbrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dllVxjv6YbnpZDTDuoFtN968QbYqOvTZxlQq4yxm0x7sVa2jwBULfPsqd0I0hx/2M
	 40RrH67flGdT9/W2WA2RU1HHFNiIBqtXu7FvodyB59jHnEDGFuNm1ecvdQlykaoMKu
	 hq0NsDxwESZMsO/J9fGd5kSgXo/PJ41sHNYm3r0fgEdkEN9/yFgGOsStkD91CqssVR
	 4/Xo6menLINrk96WDDC/dzgG1Ks/J/+XawKESR+kiCx+mvatOOo+FVw9t0Np6y8E+5
	 GOFRBiuKagYMzIqlZe3L8IVTkqmtwCYMrJnvzY2jUPoMA7H7ZBrSLC7Y/MxVlriURu
	 L1gsfoVB3uYGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 18:37:10 -0400
Message-ID: <20260908223710.506600-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223710.506600-1-sashal@kernel.org>
References: <2026090350-breeze-repugnant-70de@gregkh>
 <20260908223710.506600-1-sashal@kernel.org>
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
[ placed the RCU callback beside the older exported svc_rqst_free() while retaining page-based synchronous cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bf88a955920f2..ca0a854c9fdcf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -946,6 +946,15 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 	}
 }
 
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
@@ -957,10 +966,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
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


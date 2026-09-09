Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D32FBDE0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918927; cv=none; b=bJ9r2lEh+q7xvAA7d1cJ4T/zB0eYn45eFKzZK/qHYMIYRdMb16MOY4LeYUJwsK8ZZ7sc7xYiHuMFzglUKnGtrhQl2SZ9bqaUW1uqGpiMWwgaT4QR71eZe1h11xFnK528WqvxwqTS7G7Xk79wTWiMSMmplQngWoVZ/sYgN2jsuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918927; c=relaxed/simple;
	bh=5eXdY1FAluQboaiS7d/12eBIDSu0pVkDz7AQePI4qm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENDXM4C5QpMkbFpF3BjvXCJXy+W9InlzWHpcqCDSdCTw+rWK4S/aeGDnwdftp3APH0mxyfjGuj2DVMeVVVIropWn0K/B5t1nZVbfB7uegNlh+w/+d/LWhWWZMyOmc2dGDZEffEJkys1URNRqDrNex2vkFPOcte1X63L3/WaUqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vka5+C0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vka5+C0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956E91F00A3E;
	Wed,  9 Sep 2026 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918926;
	bh=mHy6lu9vUwyx0cE+UZA19589XWq5kxSR7zoNplvQ8Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vka5+C0gV8PRlcDGAg4bx7LoFofhO+HrqBcmLDHswj8Hl9PDSGDN6fqE7CxGYpI4k
	 9QSzW80ni6/W49Xr9dr99nRPzUQ7OMcNBupfVFn3EPt8MAFlm2fMNdfQU8z75SfLQz
	 /VFUhBQ7clnuofzH0dPHP+zChpthiY1wdPLeTO+nxnZub02FIihBxfEsaKsYJBkfY9
	 hyTktSwZtSYA5xNGV6IIt3mjF9Lj0azeNHp5J7W9obvzQa3M37ntmao/NyAj9Wz05/
	 ysS1YAgqHuMiKdK4R6GMcMnb5nwSHtZ0Jd+9Cie5DPF+zrRevi98MsFt2MlaAN5zTS
	 z3uVzSP/3waNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 21:55:24 -0400
Message-ID: <20260909015524.954830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-divinely-underpay-2e28@gregkh>
References: <2026090351-divinely-underpay-2e28@gregkh>
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
index 4212fb1c3d887..4eda1ac73481a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -839,6 +839,15 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
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
@@ -849,10 +858,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
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


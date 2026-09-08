Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6F4349A6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895724; cv=none; b=TeetmfP36mL1mvtQgSnvPtokwKbBsECVE5tNOt/br4pn8KZgWvu9G5K+g9k8Z1V5Lf0ABlt/ChRn+7iKA5QDEt3YoIa497Cx1fmSl/3rbs3vUx+8rZYwAvLIx40M8q6XXeVgpr4oD+Dy3hrGGJzgTe4v3a1QRzrqkBImazPDCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895724; c=relaxed/simple;
	bh=VGJ4RmiZoJGBFSGqYclaPflN9sxqaac9OGKWdwmvxgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+emyGPMZkzh+JLJKuL/YUfpeIKFJ+t5i9uxjzUrOSC9Y4WiVlaxlZUOuxs84+WJUGvhNe7oboZ87ssrzkXrG9ifkUld8OXSqrmirbAPEwwJ2rcMoor8uMK6J3+/WF6WmWHpxIsFPw4G7ryDrMWEGvbq5Du9jxlWwdW33KJT1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axd3YoGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axd3YoGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936601F00AC4;
	Tue,  8 Sep 2026 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895717;
	bh=TJOZfseQ52vMwBOu8VdeOY836kUM7FTKszBFd5wUBcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Axd3YoGJmpFw4UrAcoTs5+P7UgFKJuxcBhKroB//ILjN+Lo+pavdZvB0LBVq/jqMe
	 8GfyqzlXjAToQccD3/H0v2anv5x7yt2ZqWv3Wce3MBdO9PWG+CJnhsMZWnqOhGXTl7
	 KmL6xpdEtpIZlFpmdQKhsNiq6s23BAwjCrJZatkUcKB+qMr7Iw0fA3UA6JK4Yn57cQ
	 bM2l2k+BVMok0RZ8cWF34vrOHE4AcgJo2IgtJNbtW1ToMBcQap9CJxnAyT/mDmoL7w
	 RKFsEDCBo9cXiRTN2G55enkBaAkLHzU+yWx7lcTWhhWK8f2L3epIXoeNgkhnTykG4x
	 RfhDgKi/gLPTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sunrpc: defer rq_argp and rq_resp free until after RCU grace period
Date: Tue,  8 Sep 2026 15:28:34 -0400
Message-ID: <20260908192834.296848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-throwing-hardware-8a25@gregkh>
References: <2026090349-throwing-hardware-8a25@gregkh>
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
[ preserved rq_scratch_page cleanup while moving only rq_argp, rq_resp, and the request structure into the RCU callback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index df4dacd70beac..bd1b0a27f7e90 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -729,6 +729,15 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
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
 static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
@@ -736,10 +745,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_page)
 		put_page(rqstp->rq_scratch_page);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
+	call_rcu(&rqstp->rq_rcu_head, svc_rqst_free_rcu);
 }
 
 static struct svc_rqst *
-- 
2.53.0


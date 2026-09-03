Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4C4BA9F4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445818; cv=none; b=QjfQTJxRKGbxYeHhHSPHQ1hmDbgDLhXF6tu8AqF6jYIZe9/iawRe2136L4T9PGy3NUl8lxlL/T1HXxmFeLUK7vqC0mz2e9x8iuZPa5LIQ9zwYP57oN4bo2imrubSjRBsYO681FC4a5IZ3m9TeD3ys9FxcLVjJA2alnSTmz2kYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445818; c=relaxed/simple;
	bh=MF0I05VTQZTQp6wsL2YgoOrnOmEkpIdg74X3RyXrx4I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WJUF1R38Sij9QGkk0pesD7Cj32tdhZPFptjvpKOFkrqOYZSh64WDOTy2b9XBXX1uURf/b4ESjSfu06FH9JSysorxYxWrpZqwQpiMmkj6H1I/mFXuEQlg+fdoeBNobGyAw4CfAl1I/2WD5pQRKzNO6AgAeHYVOWUWI423LuUrZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwcdshZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwcdshZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D611F00A3E;
	Thu,  3 Sep 2026 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445807;
	bh=v2goLWBc7k1VSW3OhpPQ4G2nCyBaMq5kIhpI0nkIW4s=;
	h=Subject:To:Cc:From:Date;
	b=gwcdshZqfUIlykxe8ras+ihB4y65aBICz/ZB9neZjvUrbyvhuGsEM4aNiYTv8sTR0
	 I85fOT66NLvDv+ctVBd+dO5lNu8XxB/lrksB/+ubqpWHDG3ULh9b2kSl8wAGFrtm8i
	 1lyRrUsoYo5lHLMpZ9S4Poh5JeVtVMbT/XJ94C8Q=
Subject: FAILED: patch "[PATCH] sunrpc: defer rq_argp and rq_resp free until after RCU grace" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:06:50 +0200
Message-ID: <2026090350-comment-projector-6988@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c479bde671cbe2f9e152834a8b0eb7c3c295bbaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-comment-projector-6988@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c479bde671cbe2f9e152834a8b0eb7c3c295bbaf Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:47 -0400
Subject: [PATCH] sunrpc: defer rq_argp and rq_resp free until after RCU grace
 period
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 86d39610cf0a..dd80a2eaaa74 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -716,6 +716,15 @@ svc_release_buffer(struct svc_rqst *rqstp)
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
 static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
@@ -724,10 +733,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_folio)
 		folio_put(rqstp->rq_scratch_folio);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
+	call_rcu(&rqstp->rq_rcu_head, svc_rqst_free_rcu);
 }
 
 static struct svc_rqst *


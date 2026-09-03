Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DC4B8DE2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445838; cv=none; b=cegwyjieSF5MzSCADZXtao2WZUm2rxrFLi4rvGG90Z7+JJATdfgVgL71epa5qkoP3YRpfcSSLbid4BRd1ipNlr0WXQpoEOrQK6bCirqx4PFj8i92ZnDxVSXnUZYgcbGfdYKX9ux1fCfsK17aL2GDqgnuR7AfPvJ4OhQ/WCzBk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445838; c=relaxed/simple;
	bh=gaeuULTvdiWt161V7+4HsNbke3hv3wVI/C5MklMyinQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PHYFfnVCV31yJ8rGUUxNAsfO4bv+NQgqZzlG/QfG7z+5chzHMPYcFlhlMCT8ummqlU6L7Uu5E3rqHzKEwnsYurWQaLzLMKHTMQaBzWOs9jJoKO9Xgpf91TWNFbNgsNOq+L8w/kDRlaRj00d8e+7jX3WFWZ8YrmKZn+08j5mXTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1nbMQn4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1nbMQn4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3111F00A3F;
	Thu,  3 Sep 2026 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445815;
	bh=/O3tGR8JWeK9aypoQufm8x/VqQxTslI3okP/6NgyMx8=;
	h=Subject:To:Cc:From:Date;
	b=1nbMQn4Egua2F1+Y2Nb+LCbsrn2fOqD3sTs05i0zRkwjQzi0+0bjQ6ovp65sWEp1x
	 cY5Y3TlRIr4dWFE8gyqAtWuZkeUBZOIVD3/xeU1thnbvOf+yg5LC/xbYVl3eybeZzo
	 PfwtPYcNxvB2PIhFFVbIsxBXOEOYjxYhOvTIk+pE=
Subject: FAILED: patch "[PATCH] sunrpc: defer rq_argp and rq_resp free until after RCU grace" failed to apply to 5.10-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:06:51 +0200
Message-ID: <2026090351-divinely-underpay-2e28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c479bde671cbe2f9e152834a8b0eb7c3c295bbaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090351-divinely-underpay-2e28@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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


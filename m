Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5D331ED2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445823; cv=none; b=d26jKm5ReS8u6HWkOqTBtCXR7NZfuF7TfUOMin1QzehH8MQ1MiAmhuWYiTrHjfAFQgybE3G7lcGEV6Pp6YPeCEJnuCYBzuNdIyVFUuuLKSMSKXyW36yfOp0TFgvoAYMxQnFmPd4bYlQWcqfRWW2qpuBA7PDWaMMnPNhJYAGDvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445823; c=relaxed/simple;
	bh=KYSqCYIV+OaIVMkHem5FROQt5XM588dQ53qyxXgMLVg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NLWQODT8ldrgV5WqwadCBPeBpAj02uzoWM3Np6f57sJcukku2+E+QgRjU9f5mDfr4vaPf/ZA550V+IMtix2G2i14Z4Dl+q6q3nMOIEMpqQAtBuY/fZyQIL7DAFRdbD0oEYNSWL2QN87s5Sgqlbwn13LLIJKmQpDAP6AqkmSFL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7AaZslw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7AaZslw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0421F00ADB;
	Thu,  3 Sep 2026 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445810;
	bh=w1GN4cj81kZi0wKX5HwAc0QuASXkJ3e6MujZ7DE11yc=;
	h=Subject:To:Cc:From:Date;
	b=t7AaZslwEinTnhj/GGxp9BDaBAKI826b/64kp3m57B8YweISmsXEVVfbIZM/FctDN
	 pACdv2UGSJ/qyVwW6DZtzxy2J1LzDV0wbHYGQMDLenH4gNJUOkPBzm8kk+ffp6i/Lz
	 l94C9vQ63wGFOwFJLUKgefm8xsfQEdzFgZDHhj8U=
Subject: FAILED: patch "[PATCH] sunrpc: defer rq_argp and rq_resp free until after RCU grace" failed to apply to 5.15-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:06:50 +0200
Message-ID: <2026090350-lip-cognitive-6180@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c479bde671cbe2f9e152834a8b0eb7c3c295bbaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-lip-cognitive-6180@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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


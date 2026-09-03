Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE00336892
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445824; cv=none; b=J6L8XxrGnYsmX9uRRIPSGsxJp+8gB+lgqT1TLCKeSsZs6KSnTTcWb17Vd5UAhpAeDrHIz7HBrhbIl2CdxZ95N6sIsc+opb3OqYGlaoZ4ULbbacwFBynhrU6r7JggYuQoJQ3gg0EVe9HUoesI9YfEpguM402uNRJsTuqcfgbsEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445824; c=relaxed/simple;
	bh=OfqQSLVX1hzMo/B419yipwdXXAygFKj+rzIqJwRjI88=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7ctoaFIv4Ibt+KGlAjHfiDSY0/0YG0hDCIG5NwJRizHPMiBCojc3uAtbwTiBeVjx19LXfQtJF1UUKpHxIv05HH0vd8AQHcFGQTjCPGvaCTBA3HZAGOBGi0oYFpZ67IgMUIfTsPvyJzhYA3GymwfsErW4ik4r7twfTM9bJO0AT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZThWRazF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZThWRazF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C74C1F00A3D;
	Thu,  3 Sep 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445813;
	bh=56LAg7/xLSzw0nsoUQd25hV/k6G9lkE/ZbYqP1htnV0=;
	h=Subject:To:Cc:From:Date;
	b=ZThWRazFYhqg62h0BRB1jF23A6bmq8tQ2ESt9NInb3o/T4VOl4ZeNHhx44IGKfVP/
	 dhbWGOD52mbuHAH0JvrheqpU1/xokWY2TscuSGJegu+hyusPyFGyTMpVyKbl6kZCnE
	 RPoVW1gMhY/BEHrt+N4wNnz82Q9gaz9yFE2J7FiM=
Subject: FAILED: patch "[PATCH] sunrpc: defer rq_argp and rq_resp free until after RCU grace" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:06:50 +0200
Message-ID: <2026090350-breeze-repugnant-70de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c479bde671cbe2f9e152834a8b0eb7c3c295bbaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-breeze-repugnant-70de@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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


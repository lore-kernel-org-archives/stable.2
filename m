Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAD4BB5BA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445869; cv=none; b=oJ8UIAftAILB1qEJn9oJVyD21lwmuf3Xp8em0N93k5bTfkrWWYdWmf0sG2/33IhOsqb9WO7niZQSU/Z7p5+6AKtCv2hcfc1PG5eg7SnMbfCdag06ewZREN7DBCtqsUjBnCUJNJFUvdqXauaXqx/e9sEQMQAnCEDPxrNJ6HcNcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445869; c=relaxed/simple;
	bh=viwao1LGzCeEySxR0kX6F+icv1GUjTuorT3cIUyhjkM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cy9wRnfZVNUa7MhrqZug+oVgIU/zZKeCq0b9ESuwJqzldSPCYwBwx3yVFRrO5Akg3H3+u+VfBHDUPY1CFMs8SZLz3788B+ML/tWbFiWxCBLxZmtI3TKXoLYcmzHmzTD/75Ly5OEW55jQAfmCSp6zeBk26Rq3sZumm/7hb9yVBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZiHon46v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZiHon46v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E63C1F00A3F;
	Thu,  3 Sep 2026 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445858;
	bh=E64s+RzFI9mxYnZmkyobP3pOyMLp9OOFL6ODKV9R/vk=;
	h=Subject:To:Cc:From:Date;
	b=ZiHon46vNxCgpAIVlbgdjAut4QAIHvWilznM8KW/N/+EpGxCPiab0TlACirugeTI6
	 OXHsSWRkFHyn213IL9dFyPL5qYYrj6qVYvUi42buEI0aOCCnjJrXKT2VTHPTFfSaTT
	 eg5VnuRBRepCEhtfUS//eS+kp7e4Tbgclq38IIJQ=
Subject: FAILED: patch "[PATCH] svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id" failed to apply to 6.18-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:09:08 +0200
Message-ID: <2026090308-barstool-liftoff-6f6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 4488e912973773d64368828acf3b8e39d93650ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090308-barstool-liftoff-6f6d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4488e912973773d64368828acf3b8e39d93650ae Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:12 -0400
Subject: [PATCH] svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id

svc_rdma_free() caches rdma->sc_cm_id->device before teardown,
then calls rdma_destroy_id(sc_cm_id) which frees the cm_id.
rpcrdma_rn_unregister() follows, but between those two calls
the transport's sc_rn entry is still installed in the device's
rd_xa. A concurrent ib_unregister_device walk can dispatch
svc_rdma_xprt_done() against the now-freed sc_cm_id.

Move rpcrdma_rn_unregister() before rdma_destroy_id() so the
transport's notification entry is removed from the xarray before
the cm_id it references is destroyed.

Also guard the sc_cm_id dereference with a NULL check: the
following patches introduce paths that reach svc_rdma_free()
with sc_cm_id == NULL (listener create failure, ADDR_CHANGE
replacement failure).

Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-2-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9268b6105a74..55e2ca036584 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -648,10 +648,15 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
-	struct ib_device *device = rdma->sc_cm_id->device;
+	struct ib_device *device;
 
 	might_sleep();
 
+	if (!rdma->sc_cm_id)
+		goto out_free;
+
+	device = rdma->sc_cm_id->device;
+
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
@@ -676,11 +681,13 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
-		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+out_free:
 	kfree(rdma);
 }
 


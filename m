Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C514B66CD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445880; cv=none; b=sGXPBP4I0jMBmLw5UgTuTREnrcrjgmsJvw+NS4QWqFXNmMuuk6WvHDRgr9fmN3uQhSF+9mpj12ar9Z4b1DY5QwOl+/X4DeKoRsp2K8x7JFzKp+LRrsxpgCRPqW0E0TTlnz3h8utVZ8ugG00wTRHiHPblvdISia8wpdaNvrdayj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445880; c=relaxed/simple;
	bh=R4Mjp1Z6BDvxqaAHhj/mtjSC9MOTHmiRV0m9tkEpq+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CKa/XtwtlO0mipFE8Xgi0e9UoxH2sPjG+CMbCdsO9SH4aS05AnQv6Dc8z+mxtgfMWuCCTIXoIp0L+27LQEGtP9QeNWI+XiDM4EBGV8y7SrCKtykW6f+IFUYhLjIAqnIssy8pj77x9GPCoi39rdv3CfIXHPf74iFAvHq5487tIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/HR/Fyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/HR/Fyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D0D1F00AC4;
	Thu,  3 Sep 2026 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445860;
	bh=THy9mWXCq+fKN7UA8eNBGeCsdgtYg6uq/BN3B7EC5TE=;
	h=Subject:To:Cc:From:Date;
	b=u/HR/Fydj8WHVHknMJ8GdqkPfAeVDBxYPWO7R0EOX9mu3a+mbQMlW75gyHIHeI5Pt
	 wCu25NXHZZAn1lLQ+cWBpVudEjTjPb4ll5vghMW+u2jzdAdg2+rUzdr0X97TH8dKWb
	 GaBuatwthz9pMfPHdSWz7HRXxP13gry7cHaX6hgM=
Subject: FAILED: patch "[PATCH] svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id" failed to apply to 6.12-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:09:09 +0200
Message-ID: <2026090308-mutual-wrangle-377a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4488e912973773d64368828acf3b8e39d93650ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090308-mutual-wrangle-377a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 


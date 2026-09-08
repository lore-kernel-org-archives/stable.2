Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760C55408D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909912; cv=none; b=aU8wUSmRUDgi8XWUslPieoqF24+X0UI62DU5LzxVFRr3erWrHF/KChruRVqyOIeoWkMoCS0ZxdkNkV3T6qGNvwpBtm/ftkwTAAs5O9D9e5Me1RvMyw02um5JajLj+r6cUqC3GdlnKtEZHfRp6HjHF+hR6WT9RzkbB6mVitgp9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909912; c=relaxed/simple;
	bh=2eAAjI7mPk6rSJSSl3l2KlCV50JAX0KLqQdfvHRGiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI8xhDLfve3WbJC3fKvrD+LGmaMC+2ZdrvE2evY+nsUTWN2NAwVIrWQgNDSiBnehpkLdx4BH2881MbNlunZG62dIU8jW/TTytYCrVenuqvO0422Rv+ULzVa0PPQBBIBBMcuSy5wt0+RVHK3qgIHde/d/9ODwtRhyf8ZL3i5ZkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDw9yl2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDw9yl2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3979D1F00A3D;
	Tue,  8 Sep 2026 23:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909910;
	bh=O/+ygq37FdzUFXAe5SPJ637Iwiu50zTzBBX7ge46kSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDw9yl2ky32jXJtwbJX4M3ed5GyV9a6sD2go/NlcxVbPC/5cwyt8e7Kjjfr/mMIoA
	 BD0JlnicQnnvdqTywziWgEtV20gx0eBpCnjB2yNLmmlUOqCYamF/h9InpQfg1iSLJX
	 hHEzace94p8w43P55NU+DErd7E26sqQtsIlMjGdzNPZVrBaLOEHvRS3iblBw0oe77A
	 6mE9CiqexWVcAtIGF2q1XR8asGCvBL0UOKASFQYkYHwvQOByciCPdq6PieraFVEXKU
	 TYPhTsj5kmfg+kGWTIsyvWak2tMVm4HcoaYrGCav5ZJ4uEHbypkBuDNDW3T43YMEYW
	 4eYlLo0/XOE1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] svcrdma: Release transport resources synchronously
Date: Tue,  8 Sep 2026 19:25:07 -0400
Message-ID: <20260908232508.645100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-mutual-wrangle-377a@gregkh>
References: <2026090308-mutual-wrangle-377a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit bf94dea7fd4e6708d1a784be23db65eff84d82f1 ]

NFSD has always supported added network listeners. The new netlink
protocol now enables the removal of listeners.

Olga noticed that if an RDMA listener is removed and immediately
re-added, the deferred __svc_rdma_free() function might not have
run yet, so some or all of the old listener's RDMA resources
linger, which prevents a new listener on the same address from
being created.

Also, svc_xprt_free() does a module_put() just after calling
->xpo_free(). That means if there is deferred work going on, the
module could be unloaded before that work is even started,
resulting in a UAF.

Neil asks:
> What particular part of __svc_rdma_free() needs to run in order for a
> subsequent registration to succeed?
> Can that bit be run directory from svc_rdma_free() rather than be
> delayed?
> (I know almost nothing about rdma so forgive me if the answers to these
> questions seems obvious)

The reasons I can recall are:

 - Some of the transport tear-down work can sleep
 - Releasing a cm_id is tricky and can deadlock

We might be able to mitigate the second issue with judicious
application of transport reference counting.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/linux-nfs/20250821204328.89218-1-okorniev@redhat.com/
Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 4488e9129737 ("svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c8d994272f6f0..72b653d38bc78 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -613,12 +613,18 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 	rdma_disconnect(rdma->sc_cm_id);
 }
 
-static void __svc_rdma_free(struct work_struct *work)
+/**
+ * svc_rdma_free - Release class-specific transport resources
+ * @xprt: Generic svc transport object
+ */
+static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
-		container_of(work, struct svcxprt_rdma, sc_work);
+		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct ib_device *device = rdma->sc_cm_id->device;
 
+	might_sleep();
+
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
@@ -651,15 +657,6 @@ static void __svc_rdma_free(struct work_struct *work)
 	kfree(rdma);
 }
 
-static void svc_rdma_free(struct svc_xprt *xprt)
-{
-	struct svcxprt_rdma *rdma =
-		container_of(xprt, struct svcxprt_rdma, sc_xprt);
-
-	INIT_WORK(&rdma->sc_work, __svc_rdma_free);
-	schedule_work(&rdma->sc_work);
-}
-
 static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
-- 
2.53.0


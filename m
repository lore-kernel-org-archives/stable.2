Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FF492E55
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909572; cv=none; b=ZOMLcMYJjKww+aWZTkJwl+om/4LrDTSsL0BRNKM4vhRU0+Q4bHd7C84LXiuSNyWjR1luMtmuafgV8eeGGbukEparINZkjk+nQzDlAuH2/q6GaqTjAUH/JNjmfwzHA3/7LBirFVKcVc619aAymrz1gyZpViw5/AFeywiuuowK7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909572; c=relaxed/simple;
	bh=2eAAjI7mPk6rSJSSl3l2KlCV50JAX0KLqQdfvHRGiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+xnLSohOZWXyW6ZyMAUlKWiGvhubk9YqjybwVEr51qGJOy0I2whwpwTDlmWzGAjb2SMe5GN0I3HD/VYFGm2WLyd35yheHSPyjBeZiu62E+xx6ArnKYN36SSZJO8PKtqlfxseIrongFrj+BxcObn3cp8CmtYbSk838PaNoLpZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNBOPmI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNBOPmI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B171F00A3A;
	Tue,  8 Sep 2026 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909571;
	bh=O/+ygq37FdzUFXAe5SPJ637Iwiu50zTzBBX7ge46kSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNBOPmI+V/UGeb8KnldXdZarHIIiaklM5+ugvpHP0qWmNxGrDfFPcdQO79KayfORp
	 4A+R+DuZuI+oIXC6mEQp1XCO+LZUZ/32zTcMON+nNdFGMs0rcXoV/uL6FklWjRuvQ4
	 UakCgEVumKNWB0la/zIH2JHSUBFheKKPZNCug9MdIlcoA+B2EFK316y1Bz3rulitcn
	 Bj/lKFIL/t08/ETMvxCwBoLYxTROITYCQPVmz+vmdXeJzv5PM+AmjY7qV6XlISC/uY
	 svysZsDpY/QLLvU3M+NPMAxAwNnHBOexlNJPuIJOqimuTsqX4HgtFm6ga205cogwX2
	 xtDDT4rgsqBJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] svcrdma: Release transport resources synchronously
Date: Tue,  8 Sep 2026 19:19:27 -0400
Message-ID: <20260908231929.624931-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-barstool-liftoff-6f6d@gregkh>
References: <2026090308-barstool-liftoff-6f6d@gregkh>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B919CD0A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914188; cv=none; b=VcfGvi7aUZNBFKhnORh1eCPgY7+lVlFAqnSwPvGJ0YvtBDtFuekwJNAwiLt+Ccd7OK5oZGj5vqdSV3KAl21bU7C1UMkwu1WdC5GRuM5qn5KNXWHrgK8DGzJJcMlUCWdwieg1UITNs7g/AuNZTYKd2aWfQCTzBkqPc9zBCUUjyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914188; c=relaxed/simple;
	bh=TL5cGBNF9y9MLrbJm4U5rWjMuWNsdei3Z0PcjUIoUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw+FKfFwxQqo7ozTrvj/q84hE4TtV6ObrllLrjFxe+T/nXwWAsA34hjzR048moeFkYwDTGZhrBT1G8WSLi7nrP3R3rNv++QpNGa65eoBqA7+qMDT4llQWJH0867ZaGKmjza7MVNFnCq80BZdla5mNgPKUSpR66RgnOpeUf1YW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAav5mQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAav5mQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C9E1F00A3E;
	Wed,  9 Sep 2026 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914187;
	bh=rPtJ2359vJv/kjNCDTpOnA5A7VXInNVBSrIbrGf2jVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAav5mQXVs3Mnr3BDP8va7hW0lmYoF894kUKLhoDU9p8gzPUyXa1MhRhdf0+dLour
	 J7eInQIoK9sQUhF7PmfMfHmJvVSFM3mQwVEpEZYgWMZdzn3P1oVOWJa/DJGyMhj11G
	 UgAAqUS2rbqMSWApWupi/g8Zn1p7JiFWoW998XSpEzBq91k/5NrfSRF8/xbaGZ2IQ8
	 /skoavt9l8/15i0DitVmXJb2tHKlaNlgM7SpGBVTTjgNZYfoVWn8JDc7BppqKnte35
	 hIZW1bQszk25M5Dhuao/u3CY9yzMqQiuA90SyUfvH95mTcWfBSPR59SQSr8xCsH0Sx
	 Gy/g1Uf/d02Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails
Date: Tue,  8 Sep 2026 20:36:24 -0400
Message-ID: <20260909003624.747050-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909003624.747050-1-sashal@kernel.org>
References: <2026090326-unclamped-ecosphere-df9a@gregkh>
 <20260909003624.747050-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 01500306e1d50de7ca7a2cdcdfa28ac0523eb747 ]

When svc_rdma_listen_handler() handles RDMA_CM_EVENT_ADDR_CHANGE,
it creates a replacement listener cm_id and returns 1, telling
the CM core to destroy the old one. If the replacement allocation
fails, sc_cm_id still points at the old cm_id that the CM core is
about to destroy. Any subsequent dereference of sc_cm_id --
such as svc_rdma_detach()'s rdma_disconnect() call -- is a
use-after-free.

NULL sc_cm_id on the failure path and guard svc_rdma_detach()'s
rdma_disconnect() call against NULL so that the listener can
be torn down safely when the server shuts down.

Fixes: d1b586e75ec6 ("svcrdma: Handle ADDR_CHANGE CM event properly")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-5-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ added the missing sc_cm_id NULL guard to the existing __svc_rdma_free() cleanup worker. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c8d994272f6f0..aa02c47ae5734 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -311,6 +311,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 		if (IS_ERR(listen_id)) {
 			pr_err("Listener dead, address change failed for device %s\n",
 				cma_id->device->name);
+			cma_xprt->sc_cm_id = NULL;
 		} else
 			cma_xprt->sc_cm_id = listen_id;
 		return 1;
@@ -610,14 +611,20 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
-	rdma_disconnect(rdma->sc_cm_id);
+	if (rdma->sc_cm_id)
+		rdma_disconnect(rdma->sc_cm_id);
 }
 
 static void __svc_rdma_free(struct work_struct *work)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(work, struct svcxprt_rdma, sc_work);
-	struct ib_device *device = rdma->sc_cm_id->device;
+	struct ib_device *device;
+
+	if (!rdma->sc_cm_id)
+		goto out_free;
+
+	device = rdma->sc_cm_id->device;
 
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
@@ -648,6 +655,7 @@ static void __svc_rdma_free(struct work_struct *work)
 
 	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
 		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+out_free:
 	kfree(rdma);
 }
 
-- 
2.53.0


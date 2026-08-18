Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE747011D
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056117; cv=none; b=d0hvdyi5yNg4l0maXZNKhHzj8gk0Mkv8HM7mXcyQYeDhe137PwJbuF3zC6OM9rSNGgvcruQ0STsSqBwEcgwC+2qQJltjHgf4ZD4N5gmc1P2HVpvokQGj2y3GxYWAHMZh7rla2wnfMlvl33HVhOqQdqZP0inz8jvYarw4H97JF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056117; c=relaxed/simple;
	bh=Pkwt2hDBDz8qy7k0qN6/dUzy+riJUzrZwcXFtAZBDsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R85whf/Q0x+lrFt84BzkTKG85kPs9tSBNaqS5/TFWwOLnQM4a2aBQG1XskguPeh2806m6V7GCg+DyvZW4+lNteB6lKvKz+Xon3aFnPaFRW3e6ccnhdQS4CplbAD08+uC+kcOKxg7hlQyqFcbzFvTunNI+Z/RKv3yK0JyEA9uAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ewwAMt7L; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ewwAMt7L"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so5896135a91.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787056110; x=1787660910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVLz9paoRPKsg+say+PvUSJCk/ebDqgQIfxDMFhtIBs=;
        b=ewwAMt7L7s2AbSH9S/yl1mFmUJv0F3AkfU0PQ2IMJcoasay56zagEcJ5d8iAJoX8bJ
         nDvabgcO/no0NjHE1aqHLEOx3gdytpTyn8+yPR3DhbHEqmRCpf/mobM+/v2JyyM4zHfa
         kDVx2r5gv9xJxjarG31HtQvCZ+BnVN0b5U/CpRRqqSfaSk78vX/lWmEkd21LYvqPRijS
         95u9jQYmDYhFJZdqor8rerpSbMOV7pGHpNZlxt/iMniDfa7GKm5JRBooR4xkjnDGEMxs
         UCoor9CF04stlEwUrJi6bL9O6BINypmpS5zxV89F2ck+K/tvm3T1XpQrcg4RcF+ZV/sx
         7yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056110; x=1787660910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVLz9paoRPKsg+say+PvUSJCk/ebDqgQIfxDMFhtIBs=;
        b=S7wTXIbHe2WV1MU060+7j6PW03YY3A1H1a6KiMl13un5xuY/VZw/TSejUqhTEVveLd
         tDO86IrYvCZlz1Zn5csvemhXrUh02nwEHf744PZItanC7qk85/fO+aJzf89OFC7XOMG4
         SuOLjNbktWw2qKIj4rhLyM5U4qJiTVtv7leuDiol8CZ5DqRkqVmYBk8W1IDYWbGHyeDw
         BH7d4lD4wUWzf22dRx1HV0Vhzdzy6Ju7YCIZtkrSeILdFEkzy5eiFezGAnGCXayFy0hl
         0nGo+gQozDHGA57/cBFlbrk2EvuWL3TsyW5sDAJxt4hE2seLIw5FR73ZTq5QqXiDsNjd
         8R2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrHCl3sgcC1ghudBcO7acnzS9s+hjnV3baQRnFYNlAc6migcYxcMsMIYvhkl4X/5p3OHGbL91o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHAiURNQxNMyRI/bATUV3ivg5IJ8s9N2AP0Mot9zz5eErH/bk
	+79qNKslDcC9xN2JUCUoALM20b2UVGCPskBXNSCii4s3ZSoGGl3CGQKPb5mzbtB3v2ABdvnW65/
	TIR8dLW0O8nG/5Gk8F69SL+PeSy1EkZx5DWSs
X-Gm-Gg: AR+sD11btPiLPvxxGCyIEOKxVNBUBd2+4n0ltx+hMsgrcE3wP918wSI1IP7Y9q5XljQ
	d5yUg0F7wSk+9Oqg09B2yk3PdJvGzYrbhPculGJvkP7+GJjpJihV9IpLlHHMfWfH/ODOKBHKvfp
	dgY8OGS3HGw7h1vvLsFsOm4IPD49GmMCCURwor3O8VX1MO3Y6OpX+3WBAODwUxdKU1raigy9590
	hMkrEEKfaN9NXZjNspbw56LYvSrf79q7TvhLcDeOVoqaG8acXSv6gVMU/wdnpTjVtU9HN9WRjSS
	yTLNJqf0B+2WKTFQvPwWIUnb2tkKwvHCf0feHZZ2pU0WeHQcS6+01xSv9aXZx01W0xC4iw+WhHs
	BfuWBDxDQRxyNSkUn/z+bvjBTSG/kS8e3K18ZLg==
X-Received: by 2002:a17:90b:4984:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-3955a762459mr10433711a91.8.1787056109290;
        Tue, 18 Aug 2026 05:28:29 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39531ddcf26sm3889873a91.4.2026.08.18.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:28:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id A99293404E1;
	Tue, 18 Aug 2026 05:28:28 -0700 (PDT)
From: tmenninger@purestorage.com
To: trondmy@kernel.org,
	anna@kernel.org
Cc: tom@talpey.com,
	cel@kernel.org,
	linux-nfs@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>,
	stable@vger.kernel.org
Subject: [PATCH] xprtrdma: serialize unmap_sync with xprt_disconnect
Date: Tue, 18 Aug 2026 12:28:25 +0000
Message-Id: <20260818122825.2347594-1-tmenninger@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Menninger <tmenninger@purestorage.com>

frwr_unmap_sync() posts LOCAL_INV Work Requests to the QP and waits
for the matching CQE. This can race with rpcrdma_xprt_disconnect():

  1. frwr_unmap_sync() snapshots r_xprt->rx_ep
  2. rpcrdma_xprt_disconnect() drains the QP
  3. frwr_unmap_sync() posts LOCAL_INV WRs after the drain
  4. No CQE arrives and wait_for_completion() blocks indefinitely

The hung task appears in the rpciod workqueue:

  Workqueue: rpciod rpc_async_schedule [sunrpc]
  wait_for_completion()
  frwr_unmap_sync()
  xprt_rdma_free()
  xprt_release()

Serialize synchronous MR invalidation against QP teardown with
rx_unmap_rwsem. frwr_unmap_sync() holds the read side through
ib_post_send(), then drops it before waiting for completion so that
disconnect can acquire the write side and drain the QP.

Track admitted synchronous unmaps with rx_unmap_active. Disconnect
waits for the count to reach zero after draining the QP and before
destroying transport resources. This ensures that no synchronous
unmap is still accessing the endpoint or MR completion state when
those resources are freed.

Tested on v7.2-rc6 under pNFS load with repeated data server restarts
to provoke rapid QP disconnect/reconnect cycling. Without the fix, a
hung task in frwr_unmap_sync() reproduced twice in six attempts. With
the fix, no hang occurred across 300 cycles.

The issue has also been observed on v6.8 and v6.18.34. The race has
been present since synchronous FRWR invalidation was introduced.

Fixes: c9918ff56dfb ("xprtrdma: Add ro_unmap_sync method for FRWR")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@purestorage.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  | 23 +++++++++++++++++++++--
 net/sunrpc/xprtrdma/transport.c |  3 +++
 net/sunrpc/xprtrdma/verbs.c     | 13 +++++++++++--
 net/sunrpc/xprtrdma/xprt_rdma.h |  5 +++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index e5c71cf705a3..a4733d75664f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -567,11 +567,20 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, **prev, *last;
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
+	struct rpcrdma_ep *ep;
 	struct rpcrdma_mr *mr;
 	int rc;
 
+	/* serialize against rpcrdma_xprt_disconnect() */
+	down_read(&r_xprt->rx_unmap_rwsem);
+
+	ep = r_xprt->rx_ep;
+	if (!ep)
+		goto out_unlock;
+
+	atomic_inc(&r_xprt->rx_unmap_active);
+
 	/* ORDER: Invalidate all of the MRs first
 	 *
 	 * Chain the LOCAL_INV Work Requests and post them with
@@ -614,6 +623,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	bad_wr = NULL;
 	rc = ib_post_send(ep->re_id->qp, first, &bad_wr);
 
+	up_read(&r_xprt->rx_unmap_rwsem);
+
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
 	 * not happen, so don't wait in that case.
@@ -621,7 +632,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	if (bad_wr != first)
 		wait_for_completion(&mr->mr_linv_done);
 	if (!rc)
-		return;
+		goto out_atomic_dec;
 
 	/* On error, the MRs get destroyed once the QP has drained. */
 	trace_xprtrdma_post_linv_err(req, rc);
@@ -629,6 +640,14 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	/* Force a connection loss to ensure complete recovery.
 	 */
 	rpcrdma_force_disconnect(ep);
+
+out_atomic_dec:
+	if (atomic_dec_and_test(&r_xprt->rx_unmap_active))
+		wake_up_var(&r_xprt->rx_unmap_active);
+	return;
+
+out_unlock:
+	up_read(&r_xprt->rx_unmap_rwsem);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index d4e6746d8ecd..e2b6287511a4 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -364,6 +364,9 @@ xprt_setup_rdma(struct xprt_create *args)
 	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
 			  xprt_rdma_connect_worker);
 
+	init_rwsem(&new_xprt->rx_unmap_rwsem);
+	atomic_set(&new_xprt->rx_unmap_active, 0);
+
 	xprt->max_payload = RPCRDMA_MAX_DATA_SEGS << PAGE_SHIFT;
 
 	return xprt;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 04b286223b24..ae8d06d1cf29 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -580,18 +580,24 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
  */
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rpcrdma_ep *ep;
 	struct rdma_cm_id *id;
 	int rc;
 
+	down_write(&r_xprt->rx_unmap_rwsem);
+
+	ep = r_xprt->rx_ep;
 	if (!ep)
-		return;
+		goto out_unlock;
 
 	id = ep->re_id;
 	rc = rdma_disconnect(id);
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
 	rpcrdma_xprt_drain(r_xprt);
+	wait_var_event(&r_xprt->rx_unmap_active,
+		       !atomic_read(&r_xprt->rx_unmap_active));
+
 	rpcrdma_reps_unmap(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
@@ -601,6 +607,9 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 		rdma_destroy_id(id);
 
 	r_xprt->rx_ep = NULL;
+
+out_unlock:
+	up_write(&r_xprt->rx_unmap_rwsem);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 4cbc941e4a3e..419d5952150a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -46,6 +46,7 @@
 #include <linux/spinlock.h> 		/* spinlock_t, etc */
 #include <linux/atomic.h>		/* atomic_t, etc */
 #include <linux/kref.h>			/* struct kref */
+#include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct work_struct */
 #include <linux/llist.h>
 
@@ -449,6 +450,10 @@ struct rpcrdma_xprt {
 	struct delayed_work	rx_connect_worker;
 	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
+
+	/* for serializing xprt disconnect and sync MR unmap */
+	struct rw_semaphore	rx_unmap_rwsem;
+	atomic_t                rx_unmap_active;
 };
 
 #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
-- 
2.34.1


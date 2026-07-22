Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44348123E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720034; cv=none; b=jLEJXSgfNqVkrotjlMZFB4HBlfErhzSAf4EWQQNyOoZz072zMpqAh0+pLHFKxFVWrf4v7k0BrnuOk/V3579XhRP97oWen8C3TVUHm9RMUauqJiZAcDAPW9iAWcK350muL5IqVyItVYyBk7rPGCQ9wOr3Nmd6ipLchhB4NCaQHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720034; c=relaxed/simple;
	bh=B/5tm3bPVGx54VCSD3d4Jkq39iR5qbyvu2wlNgjBjMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdOsXK4KnAazPc9UnlqFfv+wFLqD/i5m1m+gwv4SGSPPvaUiZvc7zpO+Kvdl+4gcs0OpDesgJlmodX5NEGhBorkj1GbdLuBI+H5FIA2edgWOY1WV9V1Ej+FDxjsF1YFcPFbAy6Pip5eYimvViimy/XpBUexMfoC+u5zMWX/KaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aayTxn76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aayTxn76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A431F000E9;
	Wed, 22 Jul 2026 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720033;
	bh=QY6GsjSSVRM7bLOhz9Cz6ia9uak6YEpOgoJSV1Z3OKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aayTxn76vqZrvZyP3jqmBnqXvLZGY1Ggl5DL1rKWbd0ZvHA51cHm5csw79sIPPudr
	 H+lT+SW4GX5Utd0pkEANLFmRqAxG6VALXxjEtg48BwwzSXSDJLAPoIrFEqNmoKYQVB
	 ypSyrMhiNYS96Wu6tyDNrnY77D22fH+pQiOkdpDDmeU4AEaxrmNV7uKGTNLbR9Mbm9
	 xG9WJEiOCeLWaKYk7wKl4KXRWrOm70jz1sWOVY3PT6wjRd58TqS5KloWY55etyGQ87
	 YbyyB5zvBwYxAvFdV6yjoNHwJdcYlCSZOBBgjNXd5I7Otf1opF30Xx5iqYN0nmQJKM
	 6XmfMe1egekgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fuse-uring: fix race between registration and connection abortion
Date: Wed, 22 Jul 2026 07:33:50 -0400
Message-ID: <20260722113350.1151043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071627-barracuda-persuaded-fb11@gregkh>
References: <2026071627-barracuda-persuaded-fb11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 952b5d36f6a298f57c52a59e72076c69386a8aaf ]

This fixes this race:
- thread a: io_uring_enter -> register sqe ->
  fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
  yet
- thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
  fuse_uring_abort() is a no-op due to queue ref being 0
- thread a: grabs the queue_ref, queue_ref is now 1, rest of
  fuse_uring_do_register() logic executes
- thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
  and calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
The abort/unmount thread will hang indefinitely in unkillable state as
nothing will decrement queue_refs or wake stop_waitq, and the ring,
queue, and ent are leaked.

Fix this by checking fch->connected under fch->lock after the created
ent has grabbed a ref count on the queue. This ensures that in the
scenario above, it is guaranteed that we either release the queue ref
and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
waiting) in fuse_uring_do_register() when we detect !fch->connected, or
if the connection is aborted after the check, it is guaranteed that the
async teardown worker will be running in the background cleaning up ents
and decrementing the ent's ref on the queue, which will unblock the
eventual queue and ring teardown.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ changed fch->lock/fch->connected references to fc->lock/fc->connected since struct fuse_chan does not exist in this tree ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 42c82b54765934..6f74c345080f47 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -998,15 +998,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
+				  struct io_uring_cmd *cmd,
+				  unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	spin_lock(&fc->lock);
+	/* abort teardown path is running or has run */
+	if (!fc->connected) {
+		spin_unlock(&fc->lock);
+		if (atomic_dec_and_test(&ring->queue_refs))
+			wake_up_all(&ring->stop_waitq);
+		kfree(ent);
+		return -ECONNABORTED;
+	}
+	spin_unlock(&fc->lock);
+
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
 	spin_lock(&queue->lock);
@@ -1023,6 +1034,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fc->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1138,9 +1150,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-	fuse_uring_do_register(ent, cmd, issue_flags);
-
-	return 0;
+	return fuse_uring_do_register(ent, cmd, issue_flags);
 }
 
 /*
-- 
2.53.0


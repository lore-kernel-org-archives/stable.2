Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E1379960
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719475; cv=none; b=M1S/GMNA5oj399x6Wfxbo0x354cUZV4Glajh/brX8ymrBrOtnNaZieNU4Z8VeIxKITrpXfUWF/zKGkGcD39uGcg/WOonabDgh5ShkRjQuRJAoOl7QOIt+H7wlmEdYm09W1tq/ElYWszsTZkXPJbfbhuiQEVJCcj57Or0L+1L2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719475; c=relaxed/simple;
	bh=pFcdnmrYtFkegUQAbaHYV0C65UFCp5NkX/IaBKHKuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdPCxAG1roi0Dk3Z6yMgoXUUWkfI3SFvHUNIAqHLHFpxeRqLVFW7O3FXH9mJ42A2Q9bhRhgSSQv7GsfNzBzt9cot4w0kRCHlxRstwyvnJlw99Q+l1OLQMltb8jH439/g48aNdjCz+GiOlbs+0NAWyDxO6kJbCGGUu/Oojyk5bYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIfin86p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIfin86p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0871F000E9;
	Wed, 22 Jul 2026 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784719474;
	bh=a4uT4P5Xpp8WOUk+fIDnn2c0blEThGvknCUgm1oM3Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIfin86p8PICAzTGb3ZZ0WwktYUGyl8b7t8/G6tEmG42t6rpU3mIZSScc3jsB32Vf
	 58N+eq74oIjbCHnG4zaHQpI9eAOzTu78n2oWiULs6fVzSjy/AGNuSNua+AG8I6Tkaj
	 xhIiJG7G3ZXABmnWx3HF+k4VRtI3axpr1mR+b9k5CPVcViq21A/AhNG5j3XemmySh1
	 If5i6Ru6MidH+nI8wkaVveZKbi0ArZCz6JejPJKE70B3r65lMFQT/gkBD/6jX3pGDb
	 4VocxqiPhkZT6wmdXcuRFLkowUijJaJzKhMOICQdkwAVS+v9GbRMIqtVI60lpfahMu
	 gMAjxpVj1PFDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] fuse-uring: fix race between registration and connection abortion
Date: Wed, 22 Jul 2026 07:24:31 -0400
Message-ID: <20260722112431.1115514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071627-appendage-diabolic-1e66@gregkh>
References: <2026071627-appendage-diabolic-1e66@gregkh>
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
index 4fde6336cf5ced..8155c35cf56ae0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -995,15 +995,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
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
@@ -1020,6 +1031,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fc->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1136,9 +1148,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
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


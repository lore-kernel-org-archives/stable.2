Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B5372070
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194590; cv=none; b=Pw8yewiMnQ0bj0Nk/m8pEn7EEvvlKrjs4YeSAjg/Sq6xeucyK0VoLx3frorqPgk2lRlWJIEmdZjSLXLpcq7RqGfFFj0+CMImD2QvyE7buS6E42XwsL6XvNbQb7L7+7wQD/RMS1WWMW82MCddbH3X5ORc2h/UjBei/lRrH3zfaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194590; c=relaxed/simple;
	bh=VSY/IgiPguB9hEWScz8PyhVEqV1XXOHO2izGl7WSZuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTJS7JpMQNAUbQSHnMPDOBfDv8N7BJ/x5/YKufn77x6ja0GYe1aUxBu+bMrKpfeFRb+I6vvJ3JNUkC3QJ42TmRBiA1Zce9Vq2shfZp1fgK9zcmzYuf0a/8DgEO93BxosiZ7wcPHRG1kTQDSvkWwO75t6txciH2aTTTaYbbjreCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuGq4dD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuGq4dD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A94C1F000E9;
	Mon, 31 Aug 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194589;
	bh=gxMe28NJa+jZgEcKXB+KwkZ0/5cYtsPhwJ+GUPzzn2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UuGq4dD0fQBLWiZ3D/HjDeaZixhhIeHtUMnkq1Dte+2A/XQES0/dfe2sV8e/PtAht
	 lZkAEe6J/KnJaIdjzRys6ajODEG7exTrNtaoMsIDW0VzVeD4BZCgaiBn3kykZCZF8/
	 fxr5ecd5Pi1+ydQj6DNjCU4Cs+KeyTVO6E85JxJxxRFiIebQ8iH9bQVzClk2oKtcOq
	 TkC2C245AGE9JtubXbcixsnzXPtcvOGoQtBr/IdCg/dg4h6KU/H3rWDgTwM/X61Onl
	 HYBcL2yLbl57wjWLTT2BwEXeyYR3830a3Vv3bZuO3y9xSGzpCwrQJ5xatqtiBL9i0d
	 0nCjX0A3QCPxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fuse: publish io-uring queues with release semantics
Date: Mon, 31 Aug 2026 12:43:03 -0400
Message-ID: <20260831164303.270170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083152-cucumber-unwieldy-2691@gregkh>
References: <2026083152-cucumber-unwieldy-2691@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 42df916e5a5f8fb4b60c8cefb54318d1ec02c580 ]

fuse_uring_create_queue() initializes a fuse_ring_queue and then
publishes the pointer into ring->queues[qid] with WRITE_ONCE() under the
fch->lock. There are several readers that may concurrently be fetching
that pointer locklessly and then deferencing it.

WRITE_ONCE() doesn't ensure ordering of the queue's field
initialization before the ring->queues[qid] pointer assignment. The
queue must be published with smp_store_release() so the field
initialization is guaranteed to happen before.

Readers in paths where the read may happen concurrently with the store
need to use READ_ONCE() because any race involving a plain access is
undefined.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ renamed `fch->lock` to `fc->lock` since this tree lacks `struct fuse_chan` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 6f74c345080f4..0a58f7bdc00b3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -194,7 +194,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 		return;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 		struct fuse_ring_ent *ent, *next;
 
 		if (!queue)
@@ -213,7 +213,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 
 		kfree(queue->fpq.processing);
 		kfree(queue);
-		ring->queues[qid] = NULL;
+		WRITE_ONCE(ring->queues[qid], NULL);
 	}
 
 	kfree(ring->queues);
@@ -307,9 +307,11 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	}
 
 	/*
-	 * write_once and lock as the caller mostly doesn't take the lock at all
+	 * fc->lock serializes concurrent creators for this qid.
+	 * smp_store_release() are for the lockless readers who must see a
+	 * fully initialized queue after &ring->queues[qid] is set
 	 */
-	WRITE_ONCE(ring->queues[qid], queue);
+	smp_store_release(&ring->queues[qid], queue);
 	spin_unlock(&fc->lock);
 
 	return queue;
@@ -406,7 +408,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	struct fuse_ring_ent *ent;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
 			continue;
@@ -911,7 +913,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (qid >= ring->nr_queues)
 		return -EINVAL;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue)
 		return err;
 	fpq = &queue->fpq;
@@ -980,7 +982,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 		if (current_qid == qid)
 			continue;
 
-		queue = ring->queues[qid];
+		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue) {
 			ready = false;
 			break;
@@ -1134,7 +1136,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
@@ -1286,7 +1288,7 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 		      ring->nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
 
 	return queue;
-- 
2.53.0


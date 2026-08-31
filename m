Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1B372B39
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194598; cv=none; b=BYgJb7YN82GqFfJdRCzmEAa7njxUHaQ6pFQTKNiNERICoJFope4vFSAwIrBa7NwNg2vOBnsc6APk5rHeBc0n64MS7GJABOwXZlnLQPGpJx+5rKqvYj7SGHRXqemQStCzDwBlpAg1y90ZmLjOdKUHAcj8wHHJ7usHbXypGbMLiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194598; c=relaxed/simple;
	bh=yGI65JIB8GJgRprwvlTdcQ7TYnzfTNyBVEQ0tE9O+uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAdK+N1AgUFsrcd07occ1FVsjoeoBYgLNAkuK6eiEfXPgBV8PYvfDX6lsRO9AEwxbRALQNDOU5Pwis+xWsdK8hOe0773OTjRzUC8G74Swj9aMn+GjGABdO2Aw/g2gyN8nKzRId5KlJ+BkYq93n9ldlrDE9qfPYtJ3NUTNF3E2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtJCBrJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtJCBrJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78D91F00A3D;
	Mon, 31 Aug 2026 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194597;
	bh=r9wluAFJS2Nqh+s4Pox+cpkqMASsj+3Aw+nqrka43x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtJCBrJStJoEpJuVC8FQpLCI/BfDi/j9vi8InnDJTXxyJx867e5BqS9LHmGmOEuuY
	 o9+5iejLVAM8h6SMG5dI2l/yJk6KiiX04ogzi1vkr0IWjImwDR8R5d+/GBDq+E0JkZ
	 mcgoN1NpGCfWRuUhs7qoFRtswofe8GfJFGpBrpryaWzZZwamR582nhaw3OrW++jHTT
	 1Gb5fZhwEK6fk7tnED5JWG4DMpOb+/nwEApfozkJvkhf3QxSNmIP7NkxGgsU+72BAm
	 H+DMbvevfFZ2qxku5dJpDbHOQp+vhg51JrDYy8gJHCxx9VaryYD60ATvKSIQO5zUmz
	 +Po1HJOu+dXxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] fuse: fix race between interrupt and resend
Date: Mon, 31 Aug 2026 12:43:13 -0400
Message-ID: <20260831164313.270365-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831164313.270365-1-sashal@kernel.org>
References: <2026083132-jaybird-willed-acf3@gregkh>
 <20260831164313.270365-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit ed9c881f3b498383f73c42712b359419da42a7b0 ]

After commit f8fce75fedf7 ("fuse: clear intr_entry in fuse_resend and
fuse_remove_pending_req") the WARN_ON(!list_empty(&req->intr_entry)) in
fuse_request_free() still triggers due to the following race:

In request_wait_answer()
  if (test_bit(FR_SENT, &req->flags)) -> returns true

In fuse_chan_resend()
  clear_bit(FR_SENT, &req->flags)

In request_wait_answer()
  queue_interrupt(req)

Fix by:

 - move clearing FR_SENT inside fpq->lock

 - move setting FR_PENDING inside fiq->lock

 - recheck FR_SENT after acquiring fiq->lock in fuse_dev_queue_interrupt()

Reported-by: zdi-disclosures@trendmicro.com
Fixes: f8fce75fedf7 ("fuse: clear intr_entry in fuse_resend and fuse_remove_pending_req")
Cc: stable@vger.kernel.org # 6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ adjusted context to use `fc->iq` in `fuse_resend()` since `struct fuse_chan` doesn't exist in this tree ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8a38a263295fe..8bbff1f19d6bd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -353,7 +353,8 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
-	if (list_empty(&req->intr_entry)) {
+	/* Repeat FR_SENT test after obtaining the lock to prevent race with fuse_resend() */
+	if (list_empty(&req->intr_entry) && test_bit(FR_SENT, &req->flags)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
 		 * Pairs with smp_mb() implied by test_and_set_bit()
@@ -2010,7 +2011,7 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 static void fuse_resend(struct fuse_conn *fc)
 {
 	struct fuse_dev *fud;
-	struct fuse_req *req, *next;
+	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fc->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
@@ -2025,24 +2026,20 @@ static void fuse_resend(struct fuse_conn *fc)
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
-		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-			list_splice_tail_init(&fpq->processing[i], &to_queue);
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			struct list_head *this_queue = &fpq->processing[i];
+
+			list_for_each_entry(req, this_queue, list)
+				clear_bit(FR_SENT, &req->flags);
+			list_splice_tail_init(this_queue, &to_queue);
+		}
 		spin_unlock(&fpq->lock);
 	}
 	spin_unlock(&fc->lock);
 
-	list_for_each_entry_safe(req, next, &to_queue, list) {
-		set_bit(FR_PENDING, &req->flags);
-		clear_bit(FR_SENT, &req->flags);
-		/* mark the request as resend request */
-		req->in.h.unique |= FUSE_UNIQUE_RESEND;
-	}
-
 	spin_lock(&fiq->lock);
 	if (!fiq->connected) {
 		spin_unlock(&fiq->lock);
-		list_for_each_entry(req, &to_queue, list)
-			clear_bit(FR_PENDING, &req->flags);
 		fuse_dev_end_requests(&to_queue);
 		return;
 	}
@@ -2051,6 +2048,10 @@ static void fuse_resend(struct fuse_conn *fc)
 	 * intr_entry on fiq->interrupts after the request is re-queued.
 	 */
 	list_for_each_entry(req, &to_queue, list) {
+		set_bit(FR_PENDING, &req->flags);
+		/* mark the request as resend request */
+		req->in.h.unique |= FUSE_UNIQUE_RESEND;
+
 		if (test_bit(FR_INTERRUPTED, &req->flags))
 			list_del_init(&req->intr_entry);
 	}
-- 
2.53.0


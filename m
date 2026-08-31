Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C770440A34
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201104; cv=none; b=APfAevON9EcOPP/bgydY91iPyJOkzB26K6uoHol00ZdbYgVUO52jZ5GF2b5CanhWeFYOcYc0it4pz+Z08J4cZ7sCjgWZgEQcJByfULd5/2x2LYlcrcSfSh7j1I5CyvdgBT5OJI20BNbWyzMz7R8C3bGb6W3+mbgoMYvfRas/qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201104; c=relaxed/simple;
	bh=Dne5C8pe3AeullQWLIS1vw/j/hpxw1JQGV/3d+C0YZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+1ot37+hAediSWCoTHT6NgoCycPR93lln7DNC5k7gAVk/CqCzRTz4sPx5U5t+VZkaIikcQ7Zxsozsh5zmkN/+FR0Q1Hbpli7Fs/AEVcF2olecgWedlGKDdPWjcMuw1JUwhU/amCsCvkdXdpvtVRMoDtSRW6pm9946aWOXH//HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVxVHGkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVxVHGkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABEE1F000E9;
	Mon, 31 Aug 2026 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201102;
	bh=zQtOwbqunLbRWR9jwi19/s2COB88bW0S92NDDzTTfJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVxVHGkWf7CpBS0vBowlQ5rajjINbH9Py1neeBa3zIM08rPxr8RC5iWYW4rTmMUJh
	 j1yDLXY98+FmLrE3X3KC2MHcn8NihFJfSSRvWf+bMz1MzAlDHibiW79kF3+I3u45xj
	 U0z7q3LZG5HArMH6uJRUig5ZZsGr3OMscs/wcpkgdjARsAsle3SNUjNHU8v3Av3UfT
	 7FgYB5EqelKruMdRNOwHscRni1MGuMEou/G9D5oSU57mpL1V3p+y290+HC5h337ooN
	 WAP+AAVGZMIqisQAN1ZqdxsAcyDkQTL5bavtXQgsPh+jJqUL81Y6c77UvwBQvkwWLP
	 DRXpfNuu6KDXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	zdi-disclosures@trendmicro.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fuse: fix race between interrupt and resend
Date: Mon, 31 Aug 2026 14:31:40 -0400
Message-ID: <20260831183140.1672819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083132-jaundice-glutinous-0a68@gregkh>
References: <2026083132-jaundice-glutinous-0a68@gregkh>
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
[ renamed upstream's fuse_chan_resend()/fuse_dev_end_requests() identifiers back to this tree's pre-refactor fuse_resend()/end_requests() names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c3e7267517a88..cd26399b96ca3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -267,7 +267,8 @@ static void fuse_dev_queue_forget(struct fuse_iqueue *fiq, struct fuse_forget_li
 static void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
-	if (list_empty(&req->intr_entry)) {
+	/* Repeat FR_SENT test after obtaining the lock to prevent race with fuse_resend() */
+	if (list_empty(&req->intr_entry) && test_bit(FR_SENT, &req->flags)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
 		 * Pairs with smp_mb() implied by test_and_set_bit()
@@ -1846,7 +1847,7 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 static void fuse_resend(struct fuse_conn *fc)
 {
 	struct fuse_dev *fud;
-	struct fuse_req *req, *next;
+	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fc->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
@@ -1861,24 +1862,20 @@ static void fuse_resend(struct fuse_conn *fc)
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
 		end_requests(&to_queue);
 		return;
 	}
@@ -1887,6 +1884,10 @@ static void fuse_resend(struct fuse_conn *fc)
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


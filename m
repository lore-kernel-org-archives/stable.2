Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6995583ACC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971245; cv=none; b=YrhPhXwDtDipWe6TlsjUc6w2kHSKwpK03c7sZdHXG3rqqEoYTtksiwNcjYbDV+uJrQT5fipTKV2Yr7XVWAql3MjlK3H6y9vI0FIx2D0wH11uBjJOKJKglvAy04xUuTqD0/U8jBzgTSuCUuEpnb7B9+ctRZMqGf/xMYb9I/Yhrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971245; c=relaxed/simple;
	bh=cbcI4Hp4G7WGfGKZnFXvY9MwIk5RVvWi/juN/NHxSXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auU7zvyZ5yiDKrgHy/774eU/NPJOvBR3n2xRJuv1L+kkmc9nJX6rOF+JJxxiHaCMBVF2SypBF+TESN3/Nso15WFQHKTEkTT3zszZ3HMNpiVnE5m/QDdTpW56VxNPI4dJltaz7QlYUctYvfMJ50zvcvHA+8e2HWuazCk3dIOWjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar6I1yu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar6I1yu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6280C1F000FF;
	Wed,  9 Sep 2026 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971243;
	bh=8DRCJYCck/byZ6rqft/vATUH7nkmi5Vb2kAm9tsNY1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ar6I1yu8PNvmrzOfLcRyHZ6uUPbpGTnLlKJuFeoRryVvZSBAqCnGkQX4tHZb8sBXb
	 K8t3neOzjTrXXUKopfWJmdUTwFfjqMjw0R4q2+N9B7SEJC50kBJdlrsLoZu09jVJBM
	 kZqrxsUhixh9txHTEf4/y45/sJ/QLz28JzkPEuP/yQdCS4tiUXQLmihRkzyXokcHKV
	 buyq66uG6oHdoKFL4lTjfMv78JNrTmXrhtruWHjMIGDptEZbUQMTPQLzyihPszvmBT
	 sqe2JbYQGiYK4Abfilk75ri8lX42Z1VkbGROJpzT6wvziR3gK55UaH2/oryrq+YZlR
	 xuVs9CAF0wFIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] io_uring/waitid: have io_waitid_complete() remove wait queue entry
Date: Wed,  9 Sep 2026 12:27:17 -0400
Message-ID: <20260909162719.2984896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-dolly-jolliness-3485@gregkh>
References: <2026090345-dolly-jolliness-3485@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a48c0cbf28c03f6c590a14ceb31bf6e619c2f6da ]

Both callers of this need the entry potentially removed, so shift the
removal into the completion side and kill it from the two callers.

While at it, add a helper for removing the wait_queue_entry based
on the passed in io_kiocb.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 14572de82e50 ("io_uring/waitid: honor task_work cancellation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/waitid.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index ef2283728c2b3..b67b6d5bc6830 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -115,6 +115,22 @@ static int io_waitid_finish(struct io_kiocb *req, int ret)
 	return ret;
 }
 
+static void io_waitid_remove_wq(struct io_kiocb *req)
+{
+	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
+	struct wait_queue_head *head;
+
+	head = READ_ONCE(iw->head);
+	if (head) {
+		struct io_waitid_async *iwa = req->async_data;
+
+		iw->head = NULL;
+		spin_lock_irq(&head->lock);
+		list_del_init(&iwa->wo.child_wait.entry);
+		spin_unlock_irq(&head->lock);
+	}
+}
+
 static void io_waitid_complete(struct io_kiocb *req, int ret)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
@@ -125,6 +141,7 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 	lockdep_assert_held(&req->ctx->uring_lock);
 
 	hlist_del_init(&req->hash_node);
+	io_waitid_remove_wq(req);
 
 	ret = io_waitid_finish(req, ret);
 	if (ret < 0)
@@ -135,7 +152,8 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
-	struct io_waitid_async *iwa = req->async_data;
+
+	lockdep_assert_held(&req->ctx->uring_lock);
 
 	/*
 	 * Mark us canceled regardless of ownership. This will prevent a
@@ -147,9 +165,6 @@ static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	spin_lock_irq(&iw->head->lock);
-	list_del_init(&iwa->wo.child_wait.entry);
-	spin_unlock_irq(&iw->head->lock);
 	io_waitid_complete(req, -ECANCELED);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
@@ -251,8 +266,7 @@ static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
 				io_waitid_drop_issue_ref(req);
 				return;
 			}
-
-			remove_wait_queue(iw->head, &iwa->wo.child_wait);
+			/* fall through to complete, will kill waitqueue */
 		}
 	}
 
-- 
2.53.0


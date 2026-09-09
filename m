Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69381311C1D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966589; cv=none; b=Yl+b5k1kFaMM/mJfiP/p7XZgC71zT54GWk4AHoyBHPziH253JZdStE7X5tEOSPJ7HsWoqJ0BLcSkIWx+bk9zvQJNaAvbSfT4uD2IV9RxvwyrR+Dh/v/PYuqDDdcZzl9gWAStKeyfiBCy1KS8m9swW/veJS26Hw43uk8wMgWCDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966589; c=relaxed/simple;
	bh=H7Vtl8qusSnp6U0hXtBFgJZPZo65LOtfEpm55wBg3ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn5EdbFx3dCnUAv9wQg4t11y0fZ/0lEdpcNFoJp4qhgDCrthL93kn6idE+bw6pPUvEGTU4SCNydHtrvwE5VbcJ9r/YIsOcNiq1s7QXDm8OYRBQeOtK+bwd/scA4+035c5ra+VQDdXtxU1yi8wJqfxVDYLXspnyCDkTp2Zqpe5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFFtmWX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFFtmWX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3811F00A3E;
	Wed,  9 Sep 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966588;
	bh=lf2kC5CZha3XVn7Fv+1Bfnxbp6BgDfZTZz5RzXBANiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XFFtmWX0cCG/F+NVfDxap0BbUB4fy7i51YowNWI44v/74y+X4YMLiEhoBdJuM2/nf
	 ZTRaYG5/1336+9K1KHytqT1JzvMtHsQkgc4LVD5RVg47zOS1J+ci7dy7+le9j4uRFo
	 ldVAsOFDmFIVtAw9H1RLjH10o/X1lAlZ/ReFaBpYe8uTQqSCk9DleeQpVFeagJg83y
	 jobpIRlXpETdNawoPIX8AWEXI6IWvBcnbWtKGcSvLAxbitEMFjShpgTzS66QQp6OAF
	 yKIQxbJBKYBAYJGrZ7xlEJpXElpnJAA8i8Y9gfMVWspejpRdwruX4SIAFUwfYlyasW
	 b8GIX5ikyxvGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] io_uring/waitid: have io_waitid_complete() remove wait queue entry
Date: Wed,  9 Sep 2026 11:09:41 -0400
Message-ID: <20260909150945.2815896-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909150945.2815896-1-sashal@kernel.org>
References: <2026090354-alabaster-robbing-fd51@gregkh>
 <20260909150945.2815896-1-sashal@kernel.org>
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
Stable-dep-of: 2cf20c4e0f72 ("io_uring/waitid: avoid siginfo copy during ring teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/waitid.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 97cce0bd2d50e..ecd60ade08c8b 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -109,6 +109,22 @@ static int io_waitid_finish(struct io_kiocb *req, int ret)
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
@@ -119,6 +135,7 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 	lockdep_assert_held(&req->ctx->uring_lock);
 
 	hlist_del_init(&req->hash_node);
+	io_waitid_remove_wq(req);
 
 	ret = io_waitid_finish(req, ret);
 	if (ret < 0)
@@ -129,7 +146,8 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 static bool __io_waitid_cancel(struct io_kiocb *req)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
-	struct io_waitid_async *iwa = req->async_data;
+
+	lockdep_assert_held(&req->ctx->uring_lock);
 
 	/*
 	 * Mark us canceled regardless of ownership. This will prevent a
@@ -141,9 +159,6 @@ static bool __io_waitid_cancel(struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	spin_lock_irq(&iw->head->lock);
-	list_del_init(&iwa->wo.child_wait.entry);
-	spin_unlock_irq(&iw->head->lock);
 	io_waitid_complete(req, -ECANCELED);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
@@ -209,8 +224,7 @@ static void io_waitid_cb(struct io_kiocb *req, io_tw_token_t tw)
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


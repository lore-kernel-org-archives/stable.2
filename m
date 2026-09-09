Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DF2D2394
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966598; cv=none; b=VrORuXH9RSBaayQByAvUvbQUwPpQ2GnPjmhoG3wwlF5lf7TQDfcI22uaLlFYWVpvjH8qnUR6/RlkgSPlsytyeTEseHfC58A3Dy3zsM3QTyzEtbECp/aXXUEN4+4bqrEC/XFlPS22oJx2otfbimn7Rc/e49qxQ0VYnHpHSmTH83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966598; c=relaxed/simple;
	bh=2tZmHhhSaV2G4eeftbMwI+6gcv80QMmA9GwTA2WycA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR2eRcx763tSXyQ3k+ZOebO7DTQlB0D/rX8+kRrh+cPUx4ypRf0mPOFq3LqKRiXog7+AphsVyNpyW+khsP2mgaufEwyMWYDs2B+mfhCLnD2+8pF3FmLrHa4a34lX2qrF2h8oaADXM9gomnQyg0dgC76cHXOHyh4NhEo4xonxlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQBtgFNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQBtgFNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB271F00A3D;
	Wed,  9 Sep 2026 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966596;
	bh=+jSIxT9x6T3ldtjHAUqSOcGbGjqv7s5hiQStulYlOOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IQBtgFNJUBjX8qfH/fHBR6QEgSaj3xvXEH8uYaLVFp2Gauildy3cnKRQTYMeeDhS8
	 l7CYB6VwrtxU3v9yanKDSOvXbiWO33JV5af2g5fZZHsagU8mQBBPjmUfV14EO622Mp
	 EDXaZD86gJZTAdsMRDGXg8vF6x5r9AQnzgQPuU3rg8UXFikTEPADuRDwdtk1WS/Qf0
	 N3zbUmKg5YgCqJEbF5ZVwEA9eUJZ7vtfX80j1wjuc4HBGxB8SEOmq2fn1KHWz7glbC
	 BydphbRw0xu95c3J0OQ2DONygY21qbmTKDbSJfVOaMvI8+QifK1SS1LC3FrrOgtO1U
	 r3DsJ4BWRdUpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] io_uring/waitid: have io_waitid_complete() remove wait queue entry
Date: Wed,  9 Sep 2026 11:09:51 -0400
Message-ID: <20260909150954.2816677-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909150954.2816677-1-sashal@kernel.org>
References: <2026090344-mooned-reconfirm-9822@gregkh>
 <20260909150954.2816677-1-sashal@kernel.org>
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


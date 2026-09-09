Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38758125F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971214; cv=none; b=qNlpS1e9/ArcvUwFe2gcfj2F2Dj3R9hUz4ySd3A0y0LkSjPvoONg5zrDNTlnbu2Sj4uDOClZpznfjOHNHlH98xyFT4JyaG9vFKfk/13c/T22h4zEMo6X6zL+w6VZ5DBR9HB0jiAK9N3Yamz6gy2r0BMr9jTBLUZejyQKk6iQfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971214; c=relaxed/simple;
	bh=y5jA758TsnLCSdxCHXBFUHV0dtg5/1WHoMkOVyGI+vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9eoAVCOQxcPtTQ//Pj4+2Fmg2aDdHiwRCnyHzwFVbFqFNQh+xGdnklWgVC3NH7PcJ3/wrYHgJvV+WMcSfqBfHFNOEWRQujSK7JiVK4uvndlAq7P+1qWc1Z6BoG4taFEgfrHTTHo4n/LKOBBLG6JhpxnnreOpWbagWLg7fqn8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWGCtfSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWGCtfSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980101F0089A;
	Wed,  9 Sep 2026 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971213;
	bh=Fc733AjDh0IgcVSrPVJZUnQfC53pKtIF40bZCukJnOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWGCtfSoyen8K8/STbaY9Y9Ksn61vjQA4rp7zr/gzf8Cde/3T14LvE9VdCCrcTZ/G
	 F8WpWi32CanEe00akvkpS4155yicLAz5v6RMJmR0ac9XhUaPPHbG6ipkQ5xFiVaR7D
	 O4JbiRXmA2JYFlDiEcp6hbkAV0gZCzn9znQbPOG1gwew6qB44uM8BKX9ZW0Ez8grID
	 EOlF8wv9NaDoIs0FOPWiunYQPotyWEn1W9f2oxyXBLDuGOBx8V/kHNvYqFu5e73LJN
	 4aVoiXNPR2TRhXFaGTO20+gSXXpMPAfHPZwGisYiYpbDZwMxJE4fz2qpSlVuoZSzcM
	 5jcmnx13WIj0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] io_uring/waitid: have io_waitid_complete() remove wait queue entry
Date: Wed,  9 Sep 2026 12:26:48 -0400
Message-ID: <20260909162650.2981584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090355-lavish-nimbly-617c@gregkh>
References: <2026090355-lavish-nimbly-617c@gregkh>
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


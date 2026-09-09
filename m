Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D7582BB1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971246; cv=none; b=hjHZBR/ObrY1cY8ik/KpAvAhq83M9y7pdFwK3msE6KQPpSIIvttzg1aquwdj7aUE8ods8ABKBfsXsMpG1AWo11w3F9du7oplTv2SvllRl/o1p+rgXsLsiuz2oYaNIvyRWANsLP7KfC51XJSfe+zNnWMfUNJECIUrtpYNO1z8whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971246; c=relaxed/simple;
	bh=BKhFh0OAfHqwXiFFLTLEfkOH1kXUOsw/N3L3lHHOhTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMcYKdrV6pQ+kXe1qnjApujGXf+zsx9Sn9Hz1l7Rq9/8erFAtI0Of0Vx0iRyNcl291BX6e38KHsL2NCAjbryj80l1+Ms2e3kTRxh1YaS0x2f77pWImQLHQlZD3xdRP6EeYFouPQOa1AbiYj880QsmU/vZnNHUv9kuE1gSB/Dzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1tL6lIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1tL6lIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E625C1F00898;
	Wed,  9 Sep 2026 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971245;
	bh=+pv+XRo+UWIaT1LyWsknh49KzNun8G/4Ip7nGZbvYco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1tL6lIK0hmzOmF027pQmnP80JvhSAleW+CMmZ2D+88USoMOkd7M22usVzNDXuiYP
	 VF/9veZta/68i92Apx/yKd05/0d600Am+0xcaEDLFpBC2QDg9VWqzV8NCtx2HaReJj
	 R4up3mEwGEDqaSXnHXYyKhf0C8wkGqPQmT4FZkhZd52eJ5kqDv6wl+MpCgmmJT+QkD
	 wkalcTe+Mt6E+9f/JGe/ymng6CfdX74SgELPrbQdqlokM6JppBoT41xoUOXvBqDf5n
	 y11tI/VqHXS1R9czEn92nOGuftOWTZcoqsSnL8R8HYQbeb+Hcu2lYBaYRXWL2fbded
	 qc6DHVBzkV4mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] io_uring/waitid: honor task_work cancellation
Date: Wed,  9 Sep 2026 12:27:19 -0400
Message-ID: <20260909162719.2984896-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162719.2984896-1-sashal@kernel.org>
References: <2026090345-dolly-jolliness-3485@gregkh>
 <20260909162719.2984896-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 14572de82e5022899e5856008bc9cac97004a88c ]

io_waitid_cb() may run through the fallback task_work path when
task_work_add() can no longer queue work to the originating task. The
fallback runs from a kworker and io_uring marks such task work as
canceled through tw.cancel.

io_waitid_cb() currently ignores tw.cancel and calls __do_wait().
waitid is task-context dependent: __do_wait() performs child lookup
relative to current, and the retry path also uses
current->signal->wait_chldexit. If the callback runs from the fallback
kworker, current is therefore not the task that submitted the request.

Honor tw.cancel before entering __do_wait(). Complete the request with
-ECANCELED and skip the siginfo copy, since canceled task work may run
without the submitting task's userspace execution context.

Keep the existing siginfo handling for normal waitid completion and
explicit cancellation.

Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Link: https://patch.msgid.link/20260818103336.1922818-2-sh_def@163.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/waitid.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index f3222cb30cdea..d0ae5194191bf 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -131,7 +131,7 @@ static void io_waitid_remove_wq(struct io_kiocb *req)
 	}
 }
 
-static void io_waitid_complete(struct io_kiocb *req, int ret)
+static void io_waitid_complete(struct io_kiocb *req, int ret, bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -143,7 +143,10 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 	hlist_del_init(&req->hash_node);
 	io_waitid_remove_wq(req);
 
-	ret = io_waitid_finish(req, ret);
+	if (copy_si)
+		ret = io_waitid_finish(req, ret);
+	else
+		io_waitid_free(req);
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
@@ -165,7 +168,7 @@ static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	io_waitid_complete(req, -ECANCELED);
+	io_waitid_complete(req, -ECANCELED, true);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
@@ -244,6 +247,11 @@ static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	int ret;
 
 	io_tw_lock(ctx, tw);
+	if (unlikely(tw.cancel)) {
+		io_waitid_complete(req, -ECANCELED, false);
+		io_req_task_complete(tw_req, tw);
+		return;
+	}
 
 	ret = __do_wait(&iwa->wo);
 
@@ -271,7 +279,7 @@ static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 		}
 	}
 
-	io_waitid_complete(req, ret);
+	io_waitid_complete(req, ret, true);
 	io_req_task_complete(tw_req, tw);
 }
 
-- 
2.53.0


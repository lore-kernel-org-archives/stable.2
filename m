Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF2582BB7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971216; cv=none; b=oz8I5pTTK0ZOT/2w5zu/y43PL/hhALZmJ0hEl1HBNbr8a994Sux78hZOXOwYgfuOJ2VVURzHUEtRwb6OuwISDFe73aaCechXLyTVM1xHXtotDPt6kvaXrfjCX88DiWLiY7ih1nRGNeSedN00svvhjfUBCAxDd//LTZp0LQ4KJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971216; c=relaxed/simple;
	bh=qoCsfnPogew1EnrQ9xU7Wc3fdqMBpP9sPBo2N4c9ooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD+HDA4hUgE+zhze/8yLRIssCHudYRHocnwfN1W7985FgtFKafxPhUEF/U0UbVz+hDVESsAbayZ/5skcumM54GMSkyMQ/XfzYyJJfqxd0OvYGE+/v2JOjWR2pBqfHKTFxP3bRreN+inYKrndJcEi1kqugI0FqEZPrCrVn/n5uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do5v1pyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do5v1pyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B861F000FF;
	Wed,  9 Sep 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971213;
	bh=fBpuqVlNn9S2JS1t2EqMTNmu5qeigPCZWQebS6qAeuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=do5v1pyAyuQXTQLK4IkcU4gM+MVFbzkoLSrfZ5b6H++UAe4J3zyiJrZxlgIZ/dSTO
	 zHcC4+u3AZJGOyEpOXsEG9Za7IXCSiUbv4uQb+0qVbHOCRciqNHwe7plWmiZf7I2Jj
	 j2KskX8TtLW+46QTgVtjZ89N3OzlFXg0w06os7pHQdzks2U13N80eHERAVLkTjqpwS
	 dgvTUAhQFN7KWI9NkGC4qThl0xSYd1fWtYU2U+DjrjGv9uOW+3bw3yXWCCBBFJLDUY
	 ymZyI+h5pUXWxciYOJYGhn0C0+aqv1INKw7I+UuxvWioSDxf/Oyf9WC6RABqthHaGj
	 7YWbVIa/r1ADQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] io_uring/waitid: avoid siginfo copy during ring teardown
Date: Wed,  9 Sep 2026 12:26:49 -0400
Message-ID: <20260909162650.2981584-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162650.2981584-1-sashal@kernel.org>
References: <2026090355-lavish-nimbly-617c@gregkh>
 <20260909162650.2981584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 2cf20c4e0f72d523b8673053e7120d092ff1f074 ]

During ring teardown, io_ring_exit_work() cancels outstanding requests
from a kworker with a NULL tctx. The waitid cancellation path eventually
reaches io_waitid_finish(), which copies the stored siginfo to the
userspace pointer supplied with the request.

Ring-wide teardown does not run in the task context that submitted the
request, so it must not access that task's userspace pointer. Depending
on the address and mm state, the copy may fail with -EFAULT, but the
uaccess itself is inappropriate from the teardown kworker.

Use a no-copy cancellation callback when io_waitid_remove_all() is
called without an owning task context. Complete the request with
-ECANCELED while releasing the waitid state without touching siginfo.

Keep the existing siginfo handling for explicit async cancellation and
task-scoped cancellation.

Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Link: https://patch.msgid.link/20260818103336.1922818-3-sh_def@163.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adapted copy_si handling to older direct cancellation helpers using task instead of tctx. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/waitid.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index b67b6d5bc6830..e0f049ce5280a 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -131,7 +131,7 @@ static void io_waitid_remove_wq(struct io_kiocb *req)
 	}
 }
 
-static void io_waitid_complete(struct io_kiocb *req, int ret)
+static void io_waitid_complete(struct io_kiocb *req, int ret, bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -143,13 +143,17 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
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
 }
 
-static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			       bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -165,7 +169,7 @@ static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	io_waitid_complete(req, -ECANCELED);
+	io_waitid_complete(req, -ECANCELED, copy_si);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
@@ -185,7 +189,7 @@ int io_waitid_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		if (req->cqe.user_data != cd->data &&
 		    !(cd->flags & IORING_ASYNC_CANCEL_ANY))
 			continue;
-		if (__io_waitid_cancel(ctx, req))
+		if (__io_waitid_cancel(ctx, req, true))
 			nr++;
 		if (!(cd->flags & IORING_ASYNC_CANCEL_ALL))
 			break;
@@ -211,7 +215,7 @@ bool io_waitid_remove_all(struct io_ring_ctx *ctx, struct task_struct *task,
 		if (!io_match_task_safe(req, task, cancel_all))
 			continue;
 		hlist_del_init(&req->hash_node);
-		__io_waitid_cancel(ctx, req);
+		__io_waitid_cancel(ctx, req, task != NULL);
 		found = true;
 	}
 
@@ -270,7 +274,7 @@ static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
 		}
 	}
 
-	io_waitid_complete(req, ret);
+	io_waitid_complete(req, ret, true);
 	io_req_task_complete(req, ts);
 }
 
-- 
2.53.0


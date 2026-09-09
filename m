Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6E311C1D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966600; cv=none; b=eg/nSkcUj57Gfo0g2Nksem7EOQOq1sgcBQyFsS+dNhKGjyBMLfHSENf9PFle52j91XjOEBfJfIg4ThRrZxppQplYQut97gLop2+cdWrA9z1SyBV1pm9ue38Z+D17vlDEbM52wfanGxNd9s8/1wz1hl7+vZxBBtFqGJqf/4sI2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966600; c=relaxed/simple;
	bh=T4GlgmX7p8/Q+FEg5lvd/Rj10NmfCsTHokzTrlLtBlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr64Z4OMBN9sQr0QWdadmfcSL87o5e+URSnyDJGH82azdAeDuvrzASlQtBjJu4uQj6Fq+mtsjyoGvG2rbghvg2S0FqcY8AIJA+8Jty2uK18sQY88IN5MGCYYCNwAEdI1BXAvbFlKTz/Ke1gBbVtd827mC/3yCUOSSigB/GhabNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzsqkEtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzsqkEtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B9E1F00A3D;
	Wed,  9 Sep 2026 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966599;
	bh=6LmMwFvt+h/g4D+NVwvXBBVT1OY7ClMHnGzKP9ueft0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzsqkEtSYUYmqmqqHaD3pRHeVQ9ugLkj0ChKSgtoQxpUWT92oXmatb43r9d+xO9TN
	 XKruu1MCHyselxcpzLaoF7r6/tVVS0aMbfwVxpcSbGmDcDa9IBRZt9sP/6NdwicXRX
	 mH8Svh21Poe/UiFcuhNqSzGXSz0t83XnaFzztcqEQmZXeU/r2iFHGQqRpryfUMDElt
	 cxuRbwJWs+HZmD+ZR8sAbFEprjs5ZTzdTSC5ty8mF1KELB5CIUIwfSNHiFxyZbI9sf
	 cthYzeY5/SPjy8gOpwqY+tQR59TkYNJwB4p2MZ7xMqre3pespPuCatf6AATucp0r8e
	 GaMK4YrmrtlLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] io_uring/waitid: honor task_work cancellation
Date: Wed,  9 Sep 2026 11:09:54 -0400
Message-ID: <20260909150954.2816677-5-sashal@kernel.org>
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
index e02e5855e221b..309f0a934b575 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -125,7 +125,7 @@ static void io_waitid_remove_wq(struct io_kiocb *req)
 	}
 }
 
-static void io_waitid_complete(struct io_kiocb *req, int ret)
+static void io_waitid_complete(struct io_kiocb *req, int ret, bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -137,7 +137,10 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
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
@@ -159,7 +162,7 @@ static bool __io_waitid_cancel(struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	io_waitid_complete(req, -ECANCELED);
+	io_waitid_complete(req, -ECANCELED, true);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
@@ -202,6 +205,11 @@ static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	int ret;
 
 	io_tw_lock(ctx, tw);
+	if (unlikely(tw.cancel)) {
+		io_waitid_complete(req, -ECANCELED, false);
+		io_req_task_complete(tw_req, tw);
+		return;
+	}
 
 	ret = __do_wait(&iwa->wo);
 
@@ -229,7 +237,7 @@ static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 		}
 	}
 
-	io_waitid_complete(req, ret);
+	io_waitid_complete(req, ret, true);
 	io_req_task_complete(tw_req, tw);
 }
 
-- 
2.53.0


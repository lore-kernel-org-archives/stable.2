Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190834B662
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966592; cv=none; b=q2T+yPDHEJ1ffpIBbqWCm5JCd3bRQhAYY/TD3Gap6amZd0/9p/svgaHjv5sX/gg9sQ5MlPRrq1/2PGiVfQrZIDbFXPqiebDgOx6hIX9NV7YFP1KWB08mhq2SRjlLYejNZe5BbfWrJemi+9wT/X6vW6+2E7QYoHQFxc8nmpLjmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966592; c=relaxed/simple;
	bh=jjKr5VJRUXR5TbDjVWTMuQWTjhQaIRZFqesXD9U/V2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwZIFNzxfoeIY6un3kzrKlUxk0dlhD8X3H1sAvvPjNd96hDJq2dnalIJOtHBmHBl1M8uCnTm0eRhPyrRkFqyZtqu3eH8yY3014DS0VqFQfqhU52KbdwfJbRqE63RNqmdwKwyBUxq1QFJMVSZA4unG6v3VQuzJr6D/eheogMAhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJDZMCam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJDZMCam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126AF1F00A3A;
	Wed,  9 Sep 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966590;
	bh=WrVY5Pj3JKqPE347WXQc0ANM3Imqb9GZaGYLTdxbAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJDZMCamlVP5B2vthh1vIHNbHQ5UKCTBFplpJOybOBeJZeYs5R4v6JVmseSEm+VGR
	 0mDjC3/hQ54QRPLbqrOt9CaO6Vyy4kdWdJDRf9Zz+nx8k8RAD2zJbCZYZKkslXVERo
	 NlWa3Rf+OixeyF13s/TwVDEJl4BZ/t0l3GxN5uUdV6uP3a75QV3CtOWpWgNecqmcos
	 QEoRZcYw6rKIhrUsZ7KZpBOtvLeFlqo1xgcpKXmLdiAx5eMpLhoXNvxk8Tg47EEFEP
	 a1cG28zRsnaM3km8WgtpBHzSoTcMC6iOD2sw2y6mFFkJCz1upDPZFEyIiKqUlvZD4G
	 4IJxjm90ZUAAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] io_uring/waitid: honor task_work cancellation
Date: Wed,  9 Sep 2026 11:09:44 -0400
Message-ID: <20260909150945.2815896-5-sashal@kernel.org>
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
Stable-dep-of: 2cf20c4e0f72 ("io_uring/waitid: avoid siginfo copy during ring teardown")
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


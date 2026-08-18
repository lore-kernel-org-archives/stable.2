Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342B453A56;
	Tue, 18 Aug 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049254; cv=none; b=Z+MMXKwaB1hOg7W3bCmrHrDpFSi57xaq3UQT6+wfQctTSOPpagWDz6+hy1OI0wM3J1fo89LOwHE/w+ecG0elwWIbU29+KZEu8O5xRWkYjGSWAj0TNH2DhR1i8oiQVfxnJAMxXO7OaFKQh39Ssz+xUAfs7AT1M7Cy2SDFCyX/POU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049254; c=relaxed/simple;
	bh=HYRee/naYhw1m2kJ6KDY0Qv9KcNEPD58Gm5TooiCJZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv7ZBpMMvaCl/MG8oZ99rRtIIPA2y1zJsRGYFc8vJgzM648shH+T3NrIvXSb73YmkVSClQa2ji1m3NsjUFCqfQBwyaT772etRtY2gHpElqU4bg2bhu+AwiKukWWChRc8PQNYxdTmSclB7Qx4hMXIC+26Qrnsi1uy274zKDW6ojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OUsi8oi2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OUsi8oi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SY
	UKvZOxkkeYjBvUYbk9lJKtNb0j9GiBvER068bosSQ=; b=OUsi8oi2DO1+6Lxers
	0N8RkLWvAYwYTwGfIivnal+W/bQuvfJrz5cfDgcXvvfqFnbm2AEO2Wns3z93wtdP
	cBRBs8JtbCc3KcyG6I/VIi/kEkvLZSPpwdaP2/s+XEPTabNjBezYP5H4wBmX1pyn
	T60ENUqV/Qj4r73pKHHGbpUE8=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnjzQPNYRqgpf1Mw--.28738S2;
	Tue, 18 Aug 2026 18:33:52 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	gganji11@naver.com,
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/waitid: honor task_work cancellation
Date: Tue, 18 Aug 2026 18:33:36 +0800
Message-ID: <20260818103336.1922818-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnjzQPNYRqgpf1Mw--.28738S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW5tFWUGFy3XFyUXFWxXrb_yoW5XFy8pF
	Wj9rZxKFWUXF93Ka1kJF48AF1Sv3sYyr47J34fu3ZrAry7Awn0gF48Kr1rXa1UCrWkJrZx
	Zr4vvrsrWw1qkFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsmitUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRANbGqENRCqEQAA3A

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
---
 io_uring/waitid.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 32f68fd7fcdd..7a23befd2579 100644
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
2.54.0


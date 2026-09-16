Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F934E06E6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591981; cv=none; b=NY3cvtVfVGw9jFXbIJeOZejGGpioZe+B/SYULwD5RNN9f/mu1QiiRp4fJe+Ofz9C+TS6QjHwHZ2dTeoSRdRZJqWP4agpl9C8meeDnsp6nQs3opOwFQbpj9hXmVTJoX/qvxqZ7M6xjt9RmPcZuNkwlcyezJHst58C1tADZkq7kUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591981; c=relaxed/simple;
	bh=y21hVAvo99Gq8YzT3jVXT4hbV/+9E08eHWxlhUz6xHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMQT4saA67ha10zYIFGcGVswit9ARcWztUTkAjC/v4Ye1nhQ1o22kKn06dTzX084w0lWy3CrRM/Qya2RBFxV4pisXThydTvYeJKx6HhaQ1tr6y8KSx7nhfqHJ3x3m4WQRPKbpv9/MheNOWkLb5e5Iy7qiQZjjl0sdfVtsqJX0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On8t7TIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On8t7TIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0EB1F00893;
	Wed, 16 Sep 2026 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591965;
	bh=OThOQxftxcCKbrcy7185G+G/2b8IB+FCbXeUevO/QLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=On8t7TIxmUApcisdPMciowUptJXk85ZvqkiMIDp0tg0K8CUoBeNCVvfwL5aX+kVEh
	 QzMwguFjj7lIO2fN9ALOhGQg41hO54kawrnty2qOye0jsVA3IUprCqVPVX2g8cVgYa
	 slRKlndx7zRcdHAK+ufXO/ac5N43BJxC0rsRHT5hfvJZ5XaiUGU8rTid4RNVIXl9ej
	 4e72XoWFrtZC/p8clamMTXOmzsGRUYh8jzcC6kHdrjpmYvFcXO2WKSDaN4DOM1zz3H
	 GpgemXqG3gZh0zQDwo4dFeTsWSYw3CjUniFUFjDKjzAKt5R8POlJ6oX+fyVpMw1kPr
	 tlPD81EBV2v9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot+2eb3d983669d3e49d4fa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] io_uring/rw: end write accounting from ->ki_complete
Date: Wed, 16 Sep 2026 16:52:43 -0400
Message-ID: <20260916205243.2744997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091623-wrangle-flammable-47de@gregkh>
References: <2026091623-wrangle-flammable-47de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 796aa0547557e63338657ed1c487906f9fac4c73 ]

Commit b000145e9907 moved both the fsnotify calls and the write
accounting out of the kiocb completion handler and into the
io_req_rw_complete() task_work. However, only the fsnotify part actually
needed to move as it may sleep. Ending the write accounting is just a
percpu_up_read() on the superblock writers sem.

Deferring it is a problem, because it makes dropping SB_FREEZE_WRITE
protection depend on the ring owner getting to running task_work. But
the task may be blocked in freeze_super(), causing it to never get to
that:

  task                             io-wq worker
  --------------------------------------------------------------
  io_write()
    io_kiocb_start_write()         (takes sb_writers, hidden from
                                    lockdep by __sb_writers_release)
    write_iter() -> -EIOCBQUEUED
  ioctl(FS_IOC_SHUTDOWN)
    bdev_freeze()
      freeze_super()
        percpu_down_write()        <- waits for the reader above
                                   io_write()
                                     kiocb_start_write()
                                       percpu_down_read()  <- queued
                                                              behind the
                                                              writer
  <bio completes>
    io_complete_rw()
      queues io_req_rw_complete()  <- never runs, task is in D state

End the write from io_complete_rw() instead, and leave only the fsnotify
calls in task_work.

Reported-by: syzbot+2eb3d983669d3e49d4fa@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Fixes: b000145e9907 ("io_uring/rw: defer fsnotify calls to task context")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adjusted io_complete_rw() context to preserve the existing IOCB_DIO_CALLER_COMP guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rw.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index b78006228cc7f..3666ff3d2e421 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -532,20 +532,15 @@ static void io_req_end_write(struct io_kiocb *req)
 	}
 }
 
-/*
- * Trigger the notifications after having done some IO, and finish the write
- * accounting, if any.
- */
-static void io_req_io_end(struct io_kiocb *req)
+/* Trigger the notifications after having done some IO. */
+static void io_req_io_notify(struct io_kiocb *req)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
-	if (rw->kiocb.ki_flags & IOCB_WRITE) {
-		io_req_end_write(req);
+	if (rw->kiocb.ki_flags & IOCB_WRITE)
 		fsnotify_modify(req->file);
-	} else {
+	else
 		fsnotify_access(req->file);
-	}
 }
 
 static void __io_complete_rw_common(struct io_kiocb *req, long res)
@@ -586,7 +581,7 @@ void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 		io_req_set_res(req, io_fixup_rw_res(req, res), 0);
 	}
 
-	io_req_io_end(req);
+	io_req_io_notify(req);
 
 	if (req->flags & (REQ_F_BUFFER_SELECTED|REQ_F_BUFFER_RING))
 		req->cqe.flags |= io_put_kbuf(req, req->cqe.res, NULL);
@@ -600,6 +595,10 @@ static void io_complete_rw(struct kiocb *kiocb, long res)
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
+	/* ring owner may block in freeze_super() before task_work runs */
+	if (kiocb->ki_flags & IOCB_WRITE)
+		io_req_end_write(req);
+
 	if (!kiocb->dio_complete || !(kiocb->ki_flags & IOCB_DIO_CALLER_COMP)) {
 		__io_complete_rw_common(req, res);
 		io_req_set_res(req, io_fixup_rw_res(req, res), 0);
@@ -675,10 +674,12 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 
 		__io_complete_rw_common(req, ret);
 		/*
-		 * Safe to call io_end from here as we're inline
+		 * Safe to notify from here as we're inline
 		 * from the submission path.
 		 */
-		io_req_io_end(req);
+		if (rw->kiocb.ki_flags & IOCB_WRITE)
+			io_req_end_write(req);
+		io_req_io_notify(req);
 		if (sel)
 			cflags = io_put_kbuf(req, ret, sel->buf_list);
 		io_req_set_res(req, final_ret, cflags);
-- 
2.53.0


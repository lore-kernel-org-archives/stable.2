Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7F36C5AE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607606; cv=none; b=uUth31DYC/GlAIgwRyvIFmDXDCdbQ8gnvPBB7pIrlyPtn8quQrRr0YGOdz9DM0RqViK0CSjNj9SlmmlVcIANb64ilfK99aI9RVVAT9a/GFGTd06edyZwZn365eePnXkm9RSR5sYu2UCj9QHp2fSN/+TSRfF4Y+dHXQrzMViRFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607606; c=relaxed/simple;
	bh=6OTohNjk/B5Ql/dmaRHHNw2vzF9cto7cUum/3C7p8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDoFexwfUFOuaaRkhqEtWISPBwAvU8MRSenypQEbggvcdTmBJnH/+ssPx4dKCUCxuEAIPRIorLg7t0OHxxvQIfbtuyQ319+odQAKA8zhT/edDsKkF/0Z5LEnyP5+hl9Ys36WGC65w8ZQPq46Wf3LMg+wB51gHfr8Cxrc8txhUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1kfzhQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1kfzhQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D38E1F00898;
	Thu, 17 Sep 2026 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607601;
	bh=xyRwKHol6YHMLlc9H4unaYZrOyID0uPvJY63UXRjpDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1kfzhQc1DuSnSkW/fEt16spbxYSmuJilN1gqWq/kVt9XyO0tiim3bjs+5XUeuPNf
	 GHJTFhUPoheovulHAtND0SBUQ2zPT97eK+NDWuol6Pt/tkN1l01Z9KproW6W33gr6z
	 LJ+ca7frXdtAaU0d/kKwyf7X8dNot8vZQvZITnXmO11yDbyWpMD59I3MaNNEtl53ls
	 cTFUEtKZNFI6gbwLHTjzXQ7l7P7bWH2JVYQHTTSrpJJl06AOH+J4rMfY01wUm8T2ie
	 xa3BtrhtQZOO+YOYqGpds0r7G/4i4RZ0eFjSKmktv4JRsa7i7klxKUE7k09d6eNmCj
	 7AbTXaCmg/pSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot+2eb3d983669d3e49d4fa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] io_uring/rw: end write accounting from ->ki_complete
Date: Wed, 16 Sep 2026 21:13:19 -0400
Message-ID: <20260917011319.3530989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091626-gout-compress-65e7@gregkh>
References: <2026091626-gout-compress-65e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ placed write-accounting release after __io_complete_rw_common() to accommodate the older retry path’s early return. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 01eff1694d8c6..e2e04a381315f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2792,7 +2792,10 @@ static void io_req_task_complete(struct io_kiocb *req, bool *locked)
 
 static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 {
-	io_req_io_end(req);
+	if (req->rw.kiocb.ki_flags & IOCB_WRITE)
+		fsnotify_modify(req->file);
+	else
+		fsnotify_access(req->file);
 	io_req_task_complete(req, locked);
 }
 
@@ -2802,6 +2805,10 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
 	if (__io_complete_rw_common(req, res))
 		return;
+	/* ring owner may block in freeze_super() before task_work runs */
+	if (kiocb->ki_flags & IOCB_WRITE)
+		io_req_end_write(req);
+
 	req->result = io_fixup_rw_res(req, res);
 	req->io_task_work.func = io_req_rw_complete;
 	io_req_task_work_add(req);
-- 
2.53.0


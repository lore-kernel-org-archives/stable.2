Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134B32ED21
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605444; cv=none; b=iXm/nuZqnvnaWFRaMDkYrGVYVS4GCM/gaKMbI7y+C9GhcYOr7eyXIfjS3M3BG/VvD1NPQ7EjU8W4pVhVfky+1H/WswKQ4HHT9DQYPqOfyrU7rQHJSbhvW4zSPMBf8i4fynC0fvxePAe/gVeNyOlUPX2PNYnD+9uXTjNiCQXpPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605444; c=relaxed/simple;
	bh=9y16ZkKh6oayW4vk8/srh0hY4h0R2VpVH/RD3OT85oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5a/jybYUNEWcGmOexxSqIZVDdphTPJDrw9gN6RZousdt/zklnlfVHfVVMrN5W7EeU3cdVxDdOerEhX/c6apEURmsnw8RjW9nK4TvLgAS6Ek4sP36tRi8w1usP5IaDxdFb8YteOIN2hWH31AGjN+c1EPe/G34weSL1Uj5xbuBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4/VCBlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4/VCBlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A73B1F000FF;
	Thu, 17 Sep 2026 00:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605442;
	bh=pIvxbapaaCSauMilZnF6MLq6V31ZWJuZaiGux9GlnfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4/VCBlGnIBsRN2v7wQ8zmvtGeOiJhb4VYk4yOOwKNz50LLH938Cd2Yxhanf1jHox
	 bONbkX0fn1FdDpBhQaUAj+x4zebtnJKELHob/NfoBwbwjpDKewwgAuOFTp22Ihog/5
	 M295HslWpSuCowOxg/wXVeK563V2SZ0QNz4kj3L5xvDdc8ZjV0IBOD6Gg2+Bg7Ai6O
	 Nlp6dN048J4cMfm68hszW+PqZ7BHKUuUG2Vd5FOR/55skVV9gGPsXUvg1ezpeylF5j
	 q5ea/7/93Ih3DeQ9rORYStBSCbnUUwm9XdHsbG1GOq0cwETdET8WeZASbO5dtjufaj
	 9UltXKc9Xx4Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot+2eb3d983669d3e49d4fa@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] io_uring/rw: end write accounting from ->ki_complete
Date: Wed, 16 Sep 2026 20:37:20 -0400
Message-ID: <20260917003720.3435921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091626-pacify-aluminum-bcbd@gregkh>
References: <2026091626-pacify-aluminum-bcbd@gregkh>
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
index 8747c585a0770..8d5791d8f4031 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2797,7 +2797,10 @@ static void io_req_task_complete(struct io_kiocb *req, bool *locked)
 
 static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 {
-	io_req_io_end(req);
+	if (req->rw.kiocb.ki_flags & IOCB_WRITE)
+		fsnotify_modify(req->file);
+	else
+		fsnotify_access(req->file);
 	io_req_task_complete(req, locked);
 }
 
@@ -2807,6 +2810,10 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
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


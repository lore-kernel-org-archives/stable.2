Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0A51E44C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572589; cv=none; b=e8rfwLoME6KenPAMsCqgR7fYedE1/jkoa8sz1SIYmrVZMzUkkMJTs0Vw0w70JR+QRe++p0KlXOq7CmE2ocqdMPdKxMgBY6+MOTccYRnF56cEzSKXGp5anMD5C3JYSjHMaMzueXa0n/sX/ulkixlYi+8a4l+fJkhBS+jYCKXxISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572589; c=relaxed/simple;
	bh=MxHJDrsgMOs6qdGLmg1oCGAXu61sNQ/gxuCmMVOhdQU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=goFjZPSjbciZoYGtbWtP+4FQ2Pn7uQs9/DlTpBIkBRdaFOq4+Hhjt+uNdvOa8XNYFLXBPKOoC0aVtRCJ/FmKECI1/ipVOJvOvJ0s8Nf3N3pSbqNFMuBoUuYL8DZsF9yZbSRNil0/LZFBK1SL+M3VXsDUxPn4pLliIcXxpvq8K+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1LAHt34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1LAHt34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D81F000FF;
	Wed, 16 Sep 2026 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572580;
	bh=9XMcQI0OcdNi59UaHsJkIVrwdB2db7rsbGWOo7v09jw=;
	h=Subject:To:Cc:From:Date;
	b=N1LAHt34hKUHeZuiz1U9qXPN1qQi0nMm4E44lST1fslDLkXemYGlwjGuT5uQvL8Yh
	 78J6E46luNEHpQqdPJPXbA06CRCvK1gcJ/8/Y0Ikj+BJ2TW6+Go1uS4jceY6Pt543o
	 X0DP3BZ4u+RuBmtks4DE2sKwkuDxye1z5dvehGdQ=
Subject: FAILED: patch "[PATCH] io_uring/rw: end write accounting from ->ki_complete" failed to apply to 6.1-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:20:25 +0100
Message-ID: <2026091625-maturing-defog-33c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 796aa0547557e63338657ed1c487906f9fac4c73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091625-maturing-defog-33c9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 796aa0547557e63338657ed1c487906f9fac4c73 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 8 Sep 2026 17:53:20 -0600
Subject: [PATCH] io_uring/rw: end write accounting from ->ki_complete

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

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 95106dd1d7eb..3e22f294bdf2 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -517,20 +517,25 @@ static void io_req_end_write(struct io_kiocb *req)
 	}
 }
 
-/*
- * Trigger the notifications after having done some IO, and finish the write
- * accounting, if any.
- */
+/* Trigger the notifications after having done some IO. */
+static void io_req_io_notify(struct io_kiocb *req)
+{
+	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
+
+	if (rw->kiocb.ki_flags & IOCB_WRITE)
+		fsnotify_modify(req->file);
+	else
+		fsnotify_access(req->file);
+}
+
+/* Finish write accounting and notify, for inline completions only. */
 static void io_req_io_end(struct io_kiocb *req)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
-	if (rw->kiocb.ki_flags & IOCB_WRITE) {
+	if (rw->kiocb.ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
-		fsnotify_modify(req->file);
-	} else {
-		fsnotify_access(req->file);
-	}
+	io_req_io_notify(req);
 }
 
 static void __io_complete_rw_common(struct io_kiocb *req, long res)
@@ -563,7 +568,7 @@ void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	struct io_kiocb *req = tw_req.req;
 
-	io_req_io_end(req);
+	io_req_io_notify(req);
 
 	if (req->flags & (REQ_F_BUFFER_SELECTED|REQ_F_BUFFER_RING))
 		req->cqe.flags |= io_put_kbuf(req, max(req->cqe.res, 0), NULL);
@@ -577,6 +582,10 @@ static void io_complete_rw(struct kiocb *kiocb, long res)
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
+	/* ring owner may block in freeze_super() before task_work runs */
+	if (kiocb->ki_flags & IOCB_WRITE)
+		io_req_end_write(req);
+
 	__io_complete_rw_common(req, res);
 	io_req_set_res(req, io_fixup_rw_res(req, res), 0);
 	req->io_task_work.func = io_req_rw_complete;


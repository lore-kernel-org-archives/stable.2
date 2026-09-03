Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE904C8FF0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448033; cv=none; b=VjbyHa3bdb2c2byjBd6+++legMT2DeZr/VYbejyIem94MEWrWYo8MVLgQ41JPaFMrLrwSytBgSQiL4H6Ubbg8nRsigsz0CbDptGV+bFK2hDYiZvXS4UUKijpMXXbKy7qvU660JEhi4E1h/I137NyOwVGWuYCtjSAGlDF/B/JNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448033; c=relaxed/simple;
	bh=Q+eD2Jxdol6w+0r1oCTrctZfKGUaTOxH8HwqfcdAsLw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=plhqKIyYGgX5n1fVwpNkxheraZtnnabQOPcs/x15CGVICnDZShFymt9+CPisZfKvKYRSaq26rFba8LUier+GhS1203Ahdpzajb90jRqo4eL3mleUitjDIa5OiqNAUA21ymzV/QVJx7AuEM1QgzfVfUc0KZqstM6uepFI/v7tHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLiv1wRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLiv1wRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DE81F000E9;
	Thu,  3 Sep 2026 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448031;
	bh=uFJq4KHAq4oCGDuoR0bKYsb0V+n/v8U2/r9t5XzLg4E=;
	h=Subject:To:Cc:From:Date;
	b=wLiv1wRzKm1bM45QcaOJIShhGiPS+8WEa7c6wKR8qMRbqedQMJZZvTP3O8sAD2Uo1
	 XOPYKHx7z70mrf/62SoEvyjvvQHnVIG/E8HNB4Twu7sSjqQO7S5SfETq3Q3QRn225B
	 SGciDueWb7GWh5QvWXZnnFNytl8zCRWYxgMfsdHU=
Subject: FAILED: patch "[PATCH] io_uring/waitid: avoid siginfo copy during ring teardown" failed to apply to 6.12-stable tree
To: sh_def@163.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:52:55 +0200
Message-ID: <2026090355-lavish-nimbly-617c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2cf20c4e0f72d523b8673053e7120d092ff1f074
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090355-lavish-nimbly-617c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2cf20c4e0f72d523b8673053e7120d092ff1f074 Mon Sep 17 00:00:00 2001
From: Hui Su <sh_def@163.com>
Date: Tue, 18 Aug 2026 18:33:37 +0800
Subject: [PATCH] io_uring/waitid: avoid siginfo copy during ring teardown

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

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 596f2da40260..2b756017423f 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -146,7 +146,7 @@ static void io_waitid_complete(struct io_kiocb *req, int ret, bool copy_si)
 	io_req_set_res(req, ret, 0);
 }
 
-static bool __io_waitid_cancel(struct io_kiocb *req)
+static bool __io_waitid_cancel(struct io_kiocb *req, bool copy_si)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 
@@ -162,21 +162,32 @@ static bool __io_waitid_cancel(struct io_kiocb *req)
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return false;
 
-	io_waitid_complete(req, -ECANCELED, true);
+	io_waitid_complete(req, -ECANCELED, copy_si);
 	io_req_queue_tw_complete(req, -ECANCELED);
 	return true;
 }
 
+static bool io_waitid_cancel_cb(struct io_kiocb *req)
+{
+	return __io_waitid_cancel(req, true);
+}
+
+static bool io_waitid_cancel_nocopy_cb(struct io_kiocb *req)
+{
+	return __io_waitid_cancel(req, false);
+}
+
 int io_waitid_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		     unsigned int issue_flags)
 {
-	return io_cancel_remove(ctx, cd, issue_flags, &ctx->waitid_list, __io_waitid_cancel);
+	return io_cancel_remove(ctx, cd, issue_flags, &ctx->waitid_list, io_waitid_cancel_cb);
 }
 
 bool io_waitid_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  bool cancel_all)
 {
-	return io_cancel_remove_all(ctx, tctx, &ctx->waitid_list, cancel_all, __io_waitid_cancel);
+	return io_cancel_remove_all(ctx, tctx, &ctx->waitid_list, cancel_all,
+				       tctx ? io_waitid_cancel_cb : io_waitid_cancel_nocopy_cb);
 }
 
 static inline bool io_waitid_drop_issue_ref(struct io_kiocb *req)


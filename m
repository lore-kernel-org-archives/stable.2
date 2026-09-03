Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29B4C77CF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448030; cv=none; b=OlWU2OrIW+5qk8w7hA6r6Wg+ucGf69jlKrPxyHy508rwA3fP8AKETU6sbItDjxIp83wfhRBv5t4YKgg98sHnQc576lYeEcqsHTJYCOPvIf2UOteIWBT3u2SFy2gK1O4M441ZiG2d6WNYjxpufQ5wiLXLw11CYp2zBf/vXw1qcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448030; c=relaxed/simple;
	bh=hnDI8BlARxrUR4Rkv650vp6qv6bcEVNJ0m4hSEi1bnA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FO2NGF3Tg/jpuDLWxBYnogLHYwXrCR3rkjvmAPRfZEqjYCvKKDY1QJrAt3khd57P5S5qovnpUSNXsX2pd67ENumEcK4OHCgrR+yh71Pf1QGPP/oRaxYTJC7iwEK64yTA1TurGyRE0qtDcChKHJ6+qpAmZMF/uEv3qSa9nNAgwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fw8gqqsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fw8gqqsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894F41F000E9;
	Thu,  3 Sep 2026 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448029;
	bh=YS6KVvhKP6m122Vb05bHWlgtjfZ8teBfmSxTx36L1ko=;
	h=Subject:To:Cc:From:Date;
	b=fw8gqqswnetR8AGO03Z9sBeUruJoUbL4tdRJ15ScgyeKcnV9KBKs4Hy+7rWcBPA4b
	 RDsAIaHee01N2VDHV6CPQqqigU8d9EE03Aj7GruhtvVdbCHQRwaUIDkFwKc0aLfbZb
	 nOvapWcChTKpCog/Ig75JHBtceYyHIFxQPSRIxek=
Subject: FAILED: patch "[PATCH] io_uring/waitid: avoid siginfo copy during ring teardown" failed to apply to 6.18-stable tree
To: sh_def@163.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:52:54 +0200
Message-ID: <2026090354-alabaster-robbing-fd51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2cf20c4e0f72d523b8673053e7120d092ff1f074
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090354-alabaster-robbing-fd51@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE94C77C1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448024; cv=none; b=tS3BVhs5kTquHJNFjjL07SMKJPddoF76dwKWqOmxyJcT6QhWjzj7v4RJKGUvlgA9WHYDWOWX75QUzsSiDZ6ezoAiDFJI6JNDm1ucZFbhC3LuKZfoULwx89WL/jP2tI6uxHDCjlb2WznKOeWDFUTtt2bs3l/115YFOv7wFlKCRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448024; c=relaxed/simple;
	bh=kazs3/AvmAKS5GMtHbEZ6zY5IUvtXvEYRgeuaX5Dm5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QDGv5OqUaVxcsSXtngPE7yjYX1er4JBhkCNXdPQu1KmlTHyrPHGFxpTJEYbRlxfFpdmenDjqUREngh+reR2hooHF5VmqKwXcWy9STaTZ0QsrtxqorDy4SWhRwFMoeIZrgdGnnDS2T/VWMAQVwcBCevEFg6n3Ik+fUC0z2yPYYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QlGlq5JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QlGlq5JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EDB1F000E9;
	Thu,  3 Sep 2026 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448023;
	bh=HpnMMv9ds47CVt4+3CbryAbWnP0ETB5sH/xEZJzHOfg=;
	h=Subject:To:Cc:From:Date;
	b=QlGlq5JBm5WmPSG8V8CZ7U0WeK0OiJoJqWYDJSTffA8CDK6u7y6uut7W9z4hYZPtf
	 zS46VR9m7o7rXDN+E9Il4bB1jqIVvOi+mJu22hYJX1u8nXMwcYuZM+vcg0oIsiPvt/
	 NSM2wW18L91lLoIOPxJzdcxm7sCJjrN1cEe67K3c=
Subject: FAILED: patch "[PATCH] io_uring/waitid: honor task_work cancellation" failed to apply to 6.18-stable tree
To: sh_def@163.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:52:44 +0200
Message-ID: <2026090344-mooned-reconfirm-9822@gregkh>
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
git cherry-pick -x 14572de82e5022899e5856008bc9cac97004a88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-mooned-reconfirm-9822@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14572de82e5022899e5856008bc9cac97004a88c Mon Sep 17 00:00:00 2001
From: Hui Su <sh_def@163.com>
Date: Tue, 18 Aug 2026 18:33:36 +0800
Subject: [PATCH] io_uring/waitid: honor task_work cancellation

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

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 76af129ba8ca..596f2da40260 100644
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
 


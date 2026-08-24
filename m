Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1D3AA1AE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568768; cv=none; b=K/yRejxktknyojtoQFiepe4mbODmZk4gNTb1pZFV4nXwS42GJCZljeTAhjjY/GsxTR4pZQlk4qoNPwiVAvgktd/aOnCES8Ds7CkZDV5cCwpVJQFJCwktpSXrluFspoTI/1WDVCXShi48rXlov1H4R/2b8ekkK4yI+2N+YW5E6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568768; c=relaxed/simple;
	bh=oB2p4zYs8wXBLLLfKndJB7HhSTx0bjDQGxnq2oq7+QY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tTTdOAVqbHiJNkxs2PmPwtp09V3+VEAQVXEhqazyxqDY/uzJGH8uK2qJ1Vbegl1+pT94Lk4OlcHm9QosDqgcOnSaaiZ0PU7eKZgv+kUM3RJ23eCGxXGeToFcLi0wimgo99EHByahbUkf8nAIyz008IZOIoof162EfSy7pwVEUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATwm4Xt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATwm4Xt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85311F000E9;
	Mon, 24 Aug 2026 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568766;
	bh=Yi8sA8qnhU8+Jz0J5UA9o6lyJHE60pq6lgynAQi5AyM=;
	h=Subject:To:Cc:From:Date;
	b=ATwm4Xt4NmTPPj66zHHxcUFBHTnLRvoRAXwBSqRdiqRY29J2XZqPIuM0KErO+9Ht3
	 Ztaj3AUhjL9sdMaigiNzksDxI+Fk5GlzT6ky+YbuqEgH4H5gyWZK3JcpVYvQrYOHI5
	 5hbRWdyaIro3+HJMwpxTvd+CQRuV8Y+Xjo998Je8=
Subject: FAILED: patch "[PATCH] io_uring/futex: only mark private futex waits as inflight" failed to apply to 6.18-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:52:42 +0200
Message-ID: <2026082442-slogan-feminine-7a8d@gregkh>
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
git cherry-pick -x 4d327bbd1cd2485783553b6b2b401aa475f90dd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082442-slogan-feminine-7a8d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d327bbd1cd2485783553b6b2b401aa475f90dd0 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 30 Jul 2026 06:50:47 -0600
Subject: [PATCH] io_uring/futex: only mark private futex waits as inflight

Inflight tracking of futex wait requests exists to ensure that do_exit()
-> io_uring_files_cancel() cancels them before the mm goes away, as a
private futex wait depends on the mm private futex hash staying alive
for the duration of the request.

Shared futexes have no such dependency. A FLAGS_SHARED request always
resolves to either an inode based key or an mm-shared key, both of which
fail futex_key_is_private() and hence always hash into the global futex
hash, whose lifetime isn't tied to the mm.

Only mark vectored futex waits as inflight if the futex is private.

Cc: stable@vger.kernel.org
Fixes: 079afb081c42 ("io_uring/futex: mark wait requests as inflight")
Link: https://lore.kernel.org/io-uring/CANGjgdn=R_qyUdE=j9za+vkmqcxacbP-84OHXF4nZ4ho9qRyVg@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/futex.c b/io_uring/futex.c
index eea0425f2bcb..f0d80a444f45 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -154,14 +154,16 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	int ret;
 
 	ret = io_futex_prep(req, sqe);
 	if (unlikely(ret))
 		return ret;
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	/* inflight tracking only needed for mm private hash */
+	if (!(iof->futex_flags & FLAGS_SHARED))
+		io_req_track_inflight(req);
 	return 0;
 }
 
@@ -186,6 +188,7 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	struct io_futexv_data *ifd;
+	unsigned int i;
 	int ret;
 
 	/* No flags or mask supported for waitv */
@@ -210,8 +213,14 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return ret;
 	}
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	/* inflight tracking only needed for mm private hash */
+	for (i = 0; i < iof->futex_nr; i++) {
+		if (!(ifd->futexv[i].w.flags & FLAGS_SHARED)) {
+			io_req_track_inflight(req);
+			break;
+		}
+	}
+
 	iof->futexv_unqueued = 0;
 	req->flags |= REQ_F_ASYNC_DATA;
 	req->async_data = ifd;


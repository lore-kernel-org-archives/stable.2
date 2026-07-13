Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB81293C4E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950393; cv=none; b=XEAHCGdli8vpQI/7AlLgwS2q+xtgXTItCSl0DATw5Siworwq4/1yWPEJK+CPffqxZxblB0tLoSl8sKFgZoscvJGMPLz3/30KANqQvWd75SKsOJx+RrN4O2lDnqOB7eFS3MPS8yC5sgKZ0vqs1FNv63NoDrnrSvW69NARrp6IAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950393; c=relaxed/simple;
	bh=Lt8zab7uLiTrrpyz2JGLM3Sq5KLqEu1wi34EXXQeGcQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=APwRS0V9RcWYX2Xv6HGjmWleq2lCGg0FLRdf3C2Okck3F/X//HMTmyVUVB67HivQHXEdoOeoxaXSX+Af4EkxctZqMGf5gsjX16IRk5e7WEHppgMyu+fereP23Zv645GB6d65LO12M9SDLiK4CpSQggl4z7i1v1lBcbGXfLhrlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQ1/HGUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQ1/HGUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5581F000E9;
	Mon, 13 Jul 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950391;
	bh=YsHL70N/6tNiT9V6Ss5He7mPVRnqxJ/B2L4OW2IhGFI=;
	h=Subject:To:Cc:From:Date;
	b=sQ1/HGUyR3RLs4u87e85FDfpiVxaU2Fw9axq53E/6knXlOX+oR6E/RHqAx1XTv8Ke
	 WlDYSY3Nfh70BWPHZEOT0iR6JeLn7Pdhh0dmaO9SweG+c1unuzJ2nL/fOFvoAr9jY1
	 iDrAj4z3hMcaTU/10QMuroVC/nxG865Fkvst1FnQ=
Subject: FAILED: patch "[PATCH] io_uring/rw: preserve partial result for iopoll" failed to apply to 6.12-stable tree
To: michael@wigham.net,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:39:57 +0200
Message-ID: <2026071357-gout-canyon-b50f@gregkh>
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
git cherry-pick -x c554246ff4c68abf71b61a89c6e39d3cf94f523e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071357-gout-canyon-b50f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c554246ff4c68abf71b61a89c6e39d3cf94f523e Mon Sep 17 00:00:00 2001
From: Michael Wigham <michael@wigham.net>
Date: Sat, 13 Jun 2026 23:52:16 +0100
Subject: [PATCH] io_uring/rw: preserve partial result for iopoll

A partial read will store the completed byte count in io->bytes_done.
The regular completion path applies io_fixup_rw_res() so that, when the
following operation reaches EOF, the number of bytes already read is
returned.

The iopoll completion path does not apply this fixup to the return value
and can return zero instead.

Use the fixup result when updating the CQE, and the raw result for the
reissue check.

Cc: stable@vger.kernel.org
Fixes: 4d9cb92ca41d ("io_uring/rw: fix short rw error handling")
Signed-off-by: Michael Wigham <michael@wigham.net>
Link: https://patch.msgid.link/20260613225240.34032-1-michael@wigham.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0c4834645279..63b6519e498c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -601,15 +601,15 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
+	int final_res = io_fixup_rw_res(req, res);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
-	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req))
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-		else
-			req->cqe.res = res;
-	}
+
+	if (res == -EAGAIN && io_rw_should_reissue(req))
+		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+	else if (unlikely(final_res != req->cqe.res))
+		req->cqe.res = final_res;
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);


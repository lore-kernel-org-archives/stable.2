Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340F1C5D72
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178992; cv=none; b=lQDwLkOusFflAV8HgkCRGYOGlUWpS3p4hzflhhZwYvJFiaZe0AljNOc5CIKYGKif5yTobNadIjfxEMt+nULrQ5RoQgmI8PDUI/aeesMAP2jhTktOeOyhQYdJ78Z472FwBcX2VEDiGIxRB69dtqaR8XdrS5nfEN/qBvgKxKmspV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178992; c=relaxed/simple;
	bh=kDSBAhO6eWua9daw0Mx+9DAAggzUZ3AqDmaVQGwWyfs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fyJtFBbqw5Ry7BOzMFsqUuAGJLneX/hEHb4tBlHO1/ShyMO+8ym9rXGtzco/VwZaeF5dBnwzu34Bc4kL51oygbs3mu+9Gt7jt/wYygvecTqYYypvqCn4JVhD83RPEG4qe6+KlYCLoU84mj+l5I71sjUZEE4eDVi+On3azNKxmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFSY/bYq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFSY/bYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7FB1F000E9;
	Mon, 31 Aug 2026 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178990;
	bh=GUxliUVJentyFjpwdk1i1E74mpgUstwW+O70r35RXWg=;
	h=Subject:To:Cc:From:Date;
	b=NFSY/bYqKw+GMCsef0K6G6UBeRdyB2Z/2d6ZNTvyxOrgiPvN/dXp9/X5GbPC5Tijj
	 bs4ySns4r/U/K7EP7+z3FlDKyUzxtviWPQl3esquoj/IViFpd1vRZvvGQ8WTQuz7fS
	 zdi4Wk6YUt9RDBNTMPS5mirbe+Huq1lRcI/baxVA=
Subject: FAILED: patch "[PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent" failed to apply to 7.1-stable tree
To: rochan.avlur@gmail.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:23:00 +0200
Message-ID: <2026083100-flyable-tidings-a936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 64b0b5cacbd2fea88001464cb712c9dfc795b26e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083100-flyable-tidings-a936@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64b0b5cacbd2fea88001464cb712c9dfc795b26e Mon Sep 17 00:00:00 2001
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Wed, 12 Aug 2026 20:58:36 -0700
Subject: [PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent
 use-after-free

The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
concurrently processing the same request (FR_LOCKED set), the caller
frees req->args while it is still being accessed, causing a
use-after-free.

Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
returning early.  The wait will not hang because fuse_abort_conn()
ensures all requests are ended.

Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 90dceb7da571..34106f6e66a0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -724,7 +724,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_chan_abort(fch, false);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -735,6 +735,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.


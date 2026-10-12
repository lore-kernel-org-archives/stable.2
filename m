Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B9466AED
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805417; cv=none; b=jgN/si7dqcSTRBxMovEygJ1PrbwTizzWGsKZ90JUTgzYDs/VNzC7rdfIVZ429ky6DFoPmFmqs4M2wVxxZ/2eTxYZMtpMaVhBbVSaDTG8EzHE+7wC2eODrYY4DK9t6rnXA7ABDGBQvACxw3ox0rt4uME00iydTVT9dMHQt+ep3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805417; c=relaxed/simple;
	bh=tly7a0gA1aT1o78ELMj1Kjjo35czO4RH4ft82yJHxd0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e2HCuMCKu+/UmFEwTDWu4lVzjkuz7OUYs58KH+gVSej7Gdo0LQeiYifLrPCfJg7ajcIZfOgvy59t3Py7NXCgiygk16WAwD0vcOHn4eRn4UfkurTtiCurw2p5a9G7FahWw0iIsCALdIw/25yMu4bbQcocjKYbzfbkp9Kx/YX6pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKs/0qLj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKs/0qLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0371F0089E;
	Mon, 12 Oct 2026 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805410;
	bh=OSIz4NnGRSv344kiWATLReU+QsxsWMTo6efelqY4JYc=;
	h=Subject:To:Cc:From:Date;
	b=VKs/0qLjWzFDyI6/Se7SZZ4kCWDEMoyufT238gJ8K0A9jQXo5m3YKY0PgknlYniBS
	 5BCkihhzvpDalKEYJdWSKf6X3A8ORsgey2bBll5eXD9l9AUOfgA3h6FW9gcbDDxCgK
	 SNWFDYIUsX1vdNjazlyR+Xrr9vHbNK9ItTvYBimE=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: don't charge provided buffer rings to" failed to apply to 7.2-stable tree
To: axboe@kernel.dk,hengyul@cs.unc.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:43:32 +0200
Message-ID: <2026101232-grew-smuggler-50c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x cde56daf4b93f474dc256dbcc5205035223ae6f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101232-grew-smuggler-50c9@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cde56daf4b93f474dc256dbcc5205035223ae6f5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 8 Oct 2026 13:07:38 -0600
Subject: [PATCH] io_uring/kbuf: don't charge provided buffer rings to
 RLIMIT_MEMLOCK

Just like with the SQ and CQ rings, the provided buffer rings were also
not charged against the memlock limit prior to the below mentioned
commit. Restore that behavior.

Fixes: ef62de3c4ad5 ("io_uring/kbuf: use region api for pbuf rings")
Reported-by: Hengyu Liang <hengyul@cs.unc.edu>
Cc: stable@vger.kernel.org
Tested-by: Hengyu Liang <hengyul@cs.unc.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 7c59ab9cfc8b..6e2facf34bfa 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -459,7 +459,7 @@ static int io_remove_buffers_legacy(struct io_ring_ctx *ctx,
 static void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
 {
 	if (bl->flags & IOBL_BUF_RING)
-		io_free_region(ctx->user, &bl->region);
+		io_free_region(NULL, &bl->region);
 	else
 		io_remove_buffers_legacy(ctx, bl, -1U);
 
@@ -676,7 +676,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = reg.ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx->user, &bl->region, &rd, mmap_offset);
+	ret = io_create_region(NULL, &bl->region, &rd, mmap_offset);
 	if (ret)
 		goto fail;
 	br = io_region_get_ptr(&bl->region);
@@ -709,7 +709,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (!ret)
 		return 0;
 fail:
-	io_free_region(ctx->user, &bl->region);
+	io_free_region(NULL, &bl->region);
 	kfree(bl);
 	return ret;
 }


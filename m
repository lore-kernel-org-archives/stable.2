Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB66399000
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210614; cv=none; b=JtuIi00n/HDzW2pOhV6b91oPKucDDMZieNVUamRAFuS+tgoe+UH6DvQArdMV3xGLExRbyTS9y+KtQWsSOej8U3JiXqjiNZTuNknssagAOlRgt5xU3ijOqiRx06kAMVbYor/Xvt0JjqVCLLs+/uwrshzWOGZUe5XTbaDtVveQB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210614; c=relaxed/simple;
	bh=ny38uoqu6+5eD3HVftbvTdsDj1lPr/bG2C5FsbQjDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxGtLKuPvHGpbUuyVSpKdkZQboun9rZ5xYRkJeUnOiPa3zlU2twy7rDOPEzBGLAwC83rmuceMLx2JNt0/w1RWYEaB3HA8db55kCagtGS2p9wmqdLGc6W/hxLBMiKHnPt5Yski0RpqJL1GG04PsjcDuDNIQt8YbdqU59e9KwmxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXXl6vaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXXl6vaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F761F00ACF;
	Mon, 31 Aug 2026 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210613;
	bh=wm7efkF/wdXLomV+pZNGUXeDlkpcIQsGeK0ou67SNlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXXl6vaE4HjZfR2/2hHTAIkCV9cXmSxm5YWQ3V86AUfh9KXnlFdW60tiZj2zUjaae
	 WyI5p0uYGeTLfxThoNiN9d7gcjSPHbBGbk7/W8X0Tv5ODzD+QB/2El3o95EF3K2/NX
	 uEOoeNB5TVa+9WOyb5vRDO1LqOK2thVLgozUSm6Jc4OmTLKSlqV2CQKmtusg2L08wR
	 9b87UL61+G4ekbKrfjFwzFOGKjBFXglE5eiJhhVwl+pWehXB6LpBVuLhwwDqfXKamo
	 66noUQmH9zAqmHL4/Fu1C4WJinENBB26hNtxyVDbBOvPXe+wb5uJAMxqxQPvuYfCcK
	 Q5IzR3dkgzw2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 6/6] fuse: copy request headers via a stack buffer for io-uring
Date: Mon, 31 Aug 2026 17:10:05 -0400
Message-ID: <20260831211005.1798781-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211005.1798781-1-sashal@kernel.org>
References: <2026083141-whacking-derby-c87d@gregkh>
 <20260831211005.1798781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit fd10f40af314f07b6d6e028b1ca25c8b49903aab ]

The fuse-io-uring transport copies req->in.h out to the ring in
fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
Both headers live inside the fuse_request slab object, whose cache
(fuse_req_cachep) is created without a usercopy whitelist, so copying
them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
panics:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'fuse_request' (offset 56, size 40)!
  kernel BUG at mm/usercopy.c:102!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:usercopy_abort (mm/usercopy.c:90)
  Call Trace:
   __check_heap_object (mm/slub.c:8268)
   __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercopy.c:223)
   copy_header_to_ring (fs/fuse/dev_uring.c:618)
   fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.c:785)
   fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
   tctx_task_work_run (io_uring/tw.c:96)
   task_work_run (kernel/task_work.c:233)
   io_run_task_work (io_uring/tw.h:84)
   io_cqring_wait (io_uring/wait.c:278)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Bounce both headers through an on-stack copy so the usercopy touches
stack memory, not the slab object.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ merged declaration of `in_header`/`out_header` alongside pre-existing `ring`/`fc` locals introduced by prior refactors ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c40cb2194598f..1d0e4fe04eae1 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -741,6 +741,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
+	struct fuse_in_header in_header;
 	int err;
 
 	err = -EIO;
@@ -762,8 +763,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
-				   sizeof(req->in.h));
+	in_header = req->in.h;
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
+				   sizeof(in_header));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
@@ -897,11 +899,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 {
 	struct fuse_ring *ring = ent->queue->ring;
 	struct fuse_conn *fc = ring->fc;
+	struct fuse_out_header out_header;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
-				  sizeof(req->out.h)))
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
+				  sizeof(out_header)))
 		goto out;
+	req->out.h = out_header;
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req, fc);
 	if (err) {
-- 
2.53.0


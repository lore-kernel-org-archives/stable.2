Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E622749E6
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201008; cv=none; b=isp8b63hkq0zVz6krvo7e3/NJqLr7RXBnd3oXjxj/QVB5fKUQP3Of5Wy9+qPVTm+Fq2l5ROxFn6IWxKjY+HI6yCmmdeho6C7xsUCfVnMYVNfFP2A7neRGUF2KwYAgM0nIp5jRhvAHm8EDSIEI88pbYBslqmDzw67jYcDm7EEosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201008; c=relaxed/simple;
	bh=u1fX0oqetFtO017FD2HfXn+Gl3ycJFvUmME5hZjqCSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEB2Wpm4jDh6UMZUjM2YcA81PsweSubEUj47+Q/kmrBI/cZp9+HlRuqsNhwO6GPWS7Dps2UMnS6I1VNsR6eeRiE3DpFviRA+78qkcX4hsRSdUzSodB/yzkJcbqN3obASVxveGv7pRJHwBIA2p6rYL7MaJpCsxJKYSYkfJ7rT704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFHLhMMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFHLhMMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05591F00A3E;
	Mon, 31 Aug 2026 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201006;
	bh=d1B/gtj24I9k5prQbH3cbo0Vy1bDv4+1L2Uq188orpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFHLhMMrWaG66Ns26cBoRHKqQrC3SQUlv2dsgghZLjj4Ogj6+Zz2Sy67ga42Rn4Cj
	 pOWZukBTVgK5ZeJRm0LHh4gcBO0a1chPJmhWbCg/rojXQ4tN1CgzQgqAHsj0BPV9Hg
	 lBjBzPAHZmXsnTmUnDw8vNLkYX3heDgVN0jVlSFb6yJNjswpzBLEKcTQCtaX84S4MP
	 iCsBSPiZv96H9jNuD5VcILC7kRcMEo2Thq57aJkcBkFvBkMALrwQk6Ob1JThuxh7j5
	 AnThnC6UNGYpJeaY3YujxoscZrP9BG8hQQkDtq5RA3hvq58D8tk1sAw+b1vLEoAiXk
	 tuof33FvCXmOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] fuse: copy request headers via a stack buffer for io-uring
Date: Mon, 31 Aug 2026 14:30:02 -0400
Message-ID: <20260831183002.1670211-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183002.1670211-1-sashal@kernel.org>
References: <2026083141-juicy-elated-cee2@gregkh>
 <20260831183002.1670211-1-sashal@kernel.org>
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
[ adapted context due to a pre-existing local `ring` local variable from an earlier already-backported commit shifting line numbers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 55e0ecdb20582..c4ec7a97a4746 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -743,6 +743,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
+	struct fuse_in_header in_header;
 	int err;
 
 	err = -EIO;
@@ -764,8 +765,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
-				   sizeof(req->in.h));
+	in_header = req->in.h;
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
+				   sizeof(in_header));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
@@ -870,11 +872,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
+	struct fuse_out_header out_header;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
-				  sizeof(req->out.h)))
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
+				  sizeof(out_header)))
 		goto out;
+	req->out.h = out_header;
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req);
 	if (err) {
-- 
2.53.0


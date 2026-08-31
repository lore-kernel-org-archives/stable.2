Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9833E6386
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179037; cv=none; b=iPRfUXrNSFTsapc7TKoyqyPXZYg8RWS78APfyTl5O94+tTPBOZYXC8QmiOTF6hK3YZbn5Zkpsy20Yp6RcmnShFS821oa15z8zNa22BeZ4xxtgbMrltwkfkrSzljf7aOv0zUH7HnH1KSz8RCMJarKipyctYSYSC1AWSmPCpqD8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179037; c=relaxed/simple;
	bh=Tvk6/ugfclbj827FEl5niTdYKUE/IKqLYAoZtowH0u8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ENIU3ToF6lUP14WfrHYJ72vPd80hn8MWnMEonmaY1Dd1tX8JzgxvPDxzP5yjGKcC64bjp6HipRwFbBg5QAtAzFNRXqNQy+kTl3jCmlfjyjtcw/JS6ihibb5x8U32tqJZQIKKeX008TDIcTGp0hV58x/wJF6+9Ihn38WZ+h9V7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABgmEUoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABgmEUoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55BD1F000E9;
	Mon, 31 Aug 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179036;
	bh=sOb6ZEechDAnXkGhkrBZ3qBvZd+cI+lfUxQKGOSYXsM=;
	h=Subject:To:Cc:From:Date;
	b=ABgmEUoN5r5GPuJoTk8AHxpS5aFxYLfw5a88LR8VCkUXbnOEtjDRPNc8K/HdIebjA
	 j5k1EozFmQdXIDZAKR4qJmNsedONHFdbGDohu81gA2M8uB1x5sbYxwi0H6MXRUxZp8
	 LXosxBZK2Y75HTbkWnz9wDXZV2E5ai6s5D6Qc4Qg=
Subject: FAILED: patch "[PATCH] fuse: copy request headers via a stack buffer for io-uring" failed to apply to 6.18-stable tree
To: xmei5@asu.edu,bernd@bsbernd.com,bestswngs@gmail.com,joannelkoong@gmail.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:23:42 +0200
Message-ID: <2026083142-defile-crewmate-74f2@gregkh>
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
git cherry-pick -x fd10f40af314f07b6d6e028b1ca25c8b49903aab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083142-defile-crewmate-74f2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd10f40af314f07b6d6e028b1ca25c8b49903aab Mon Sep 17 00:00:00 2001
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 27 Jul 2026 16:37:04 -0700
Subject: [PATCH] fuse: copy request headers via a stack buffer for io-uring

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

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1547a4f0d9b9..e22a48c9a678 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -922,6 +922,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 				   unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_in_header in_header;
 	int err;
 
 	err = -EIO;
@@ -943,8 +944,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
-				   sizeof(req->in.h));
+	in_header = req->in.h;
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
+				   sizeof(in_header));
 }
 
 static bool fuse_uring_req_has_copyable_payload(struct fuse_ring_ent *ent,
@@ -1151,11 +1153,13 @@ static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
 static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
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


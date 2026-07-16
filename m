Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635141F5FE
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207375; cv=none; b=lzEe37jbEOBrQyl+wyNc6+ff3Vtgli/zrg1qOY32EBA5nOYYtj4u3CfSPjf6emHd/YUIC0QN/r+dEF+PEDWwx+WY4n4+4L94SwQ2DADTyGvDDMqBgVSgT78JDQMwBWYlBDgr+Cg81k0jQcmO87rHEQT+o2wTkHc9+omYIN5T2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207375; c=relaxed/simple;
	bh=67oxrlItzAMEW00Z24tqO5K4br28CP9ga4xtPH0g7RE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DqjTv1IUnFJCoClDeMHFZkxJ31nT0DFxnCpm7kzwqc619Yhm5Iiv6dMJtzZ6XBmJKOCB7LbejP6goJWE+ihL6UBLyw0eKyrXwOV4ZtaIIBcGhYDE+8Dk7PPUCFODmeEbKHhEGMH0XJ9aKpf2vKqXzcOxKlcU3nt0m6UBL4z14z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dW3hkMcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dW3hkMcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C821F000E9;
	Thu, 16 Jul 2026 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784207374;
	bh=XMCPHMHJABADHDP3wudICc+0DZMU2dKd4CXtj3yQjNA=;
	h=Subject:To:Cc:From:Date;
	b=dW3hkMcVqLb/6U+37xzvVI7U0gPJbZMJ2W99vm2mb7AgzpPF452/w3Zy6kZ8QsKJX
	 6djOOpEfcOUmLuJCjIlPW+sPe5orHsavCymXjkq95k3ExiyXpbRhi97t0u5/wySc8B
	 LaD33CZCR9ndZ8nqQIvmWk1YjpHbcIOt87UvpD0g=
Subject: FAILED: patch "[PATCH] fuse-uring: fix race between registration and connection" failed to apply to 7.1-stable tree
To: joannelkoong@gmail.com,bernd@bsbernd.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 15:09:27 +0200
Message-ID: <2026071627-appendage-diabolic-1e66@gregkh>
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
git cherry-pick -x 952b5d36f6a298f57c52a59e72076c69386a8aaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071627-appendage-diabolic-1e66@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 952b5d36f6a298f57c52a59e72076c69386a8aaf Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 12:21:47 -0700
Subject: [PATCH] fuse-uring: fix race between registration and connection
 abortion

This fixes this race:
- thread a: io_uring_enter -> register sqe ->
  fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
  yet
- thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
  fuse_uring_abort() is a no-op due to queue ref being 0
- thread a: grabs the queue_ref, queue_ref is now 1, rest of
  fuse_uring_do_register() logic executes
- thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
  and calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
The abort/unmount thread will hang indefinitely in unkillable state as
nothing will decrement queue_refs or wake stop_waitq, and the ring,
queue, and ent are leaked.

Fix this by checking fch->connected under fch->lock after the created
ent has grabbed a ref count on the queue. This ensures that in the
scenario above, it is guaranteed that we either release the queue ref
and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
waiting) in fuse_uring_do_register() when we detect !fch->connected, or
if the connection is aborted after the check, it is guaranteed that the
async teardown worker will be running in the background cleaning up ents
and decrementing the ent's ref on the queue, which will unblock the
eventual queue and ring teardown.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 33b9fcee4fc3..16b9229c2dbd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -972,15 +972,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
+				  struct io_uring_cmd *cmd,
+				  unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	spin_lock(&fch->lock);
+	/* abort teardown path is running or has run */
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
+		if (atomic_dec_and_test(&ring->queue_refs))
+			wake_up_all(&ring->stop_waitq);
+		kfree(ent);
+		return -ECONNABORTED;
+	}
+	spin_unlock(&fch->lock);
+
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
 	spin_lock(&queue->lock);
@@ -997,6 +1008,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fc->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1113,9 +1125,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-	fuse_uring_do_register(ent, cmd, issue_flags);
-
-	return 0;
+	return fuse_uring_do_register(ent, cmd, issue_flags);
 }
 
 /*


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26D4E73D2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780373; cv=none; b=iRxZW9iThYdJqVdVLhhimbDagQApz9rAUshHEDQGZm9wfqt7yjsQk++bxsGvwjDWc4pBlU1eVBFWDyps81muBBy9+zQyNV9iVjd5UwguCyF185WQFyuUjeUXFXzqWG9YPjreHVFpoq3qAEdMy9ZNyqPrAozTBtCOBJ/4QcCoP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780373; c=relaxed/simple;
	bh=P4gnwfzavaVZtBY3nKcWd9a9hlh2CV4MbeksVJY9cYU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sm9Jq1xtl5XyNlaSuWG/NNiRcZGazW5Yy0ux6KMGU3mAgRS4DyR4dyU9sPDerwbNcw7CM3J9PwEa+lIKrELX3sFXmZgwk8VIMkGcPgLZJsvSB92XqNvk/qHrn6EovT5qy43kwQorL89pCb6X8ZCev80gGhxzmxe/YcnBeQWCxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxwQduE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxwQduE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F21F000FF;
	Wed, 30 Sep 2026 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790780365;
	bh=FuFiG2Iea/MAI7MWgcLVaDQutoJdCd8Jz2T0IsdFBfA=;
	h=Subject:To:Cc:From:Date;
	b=FxwQduE56pzTXns5GP7me45fCMqUulXmEq1d5Wjn0yTqmGh4Q2BxXsj5TK8xLsATU
	 GOkFw/YStMr3Zh8NWYEVNAy1oLQ3h0cPKRah+N9GFzBRBHfxdsky03UAZbzCEMIBnK
	 KjiZzj/VZf6lZYJsfby9b5VAGO8fqHOZxaqEBjrg=
Subject: FAILED: patch "[PATCH] io_uring/waitid: fix KCSAN warning on io_waitid->head" failed to apply to 6.12-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 16:59:19 +0200
Message-ID: <2026093018-boneless-remorse-ee12@gregkh>
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
git cherry-pick -x b994ace83a2bc7699420f6a4c6b860c8da133159
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093018-boneless-remorse-ee12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b994ace83a2bc7699420f6a4c6b860c8da133159 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 19 Jan 2026 19:46:26 -0700
Subject: [PATCH] io_uring/waitid: fix KCSAN warning on io_waitid->head

Storing of the iw->head entry inside the wait_queue callback, or when
removing a waitid item, really should use proper load/store
acquire/release semantics, and KCSAN correctly warns of that. Ensure
that they do so.

Reported-by: syzbot+eb441775f4f948a0902f@syzkaller.appspotmail.com
Fixes: a48c0cbf28c0 ("io_uring/waitid: have io_waitid_complete() remove wait queue entry")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 2d4cbd47c67c..d25d60aed6af 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -114,11 +114,11 @@ static void io_waitid_remove_wq(struct io_kiocb *req)
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 	struct wait_queue_head *head;
 
-	head = READ_ONCE(iw->head);
+	head = smp_load_acquire(&iw->head);
 	if (head) {
 		struct io_waitid_async *iwa = req->async_data;
 
-		iw->head = NULL;
+		smp_store_release(&iw->head, NULL);
 		spin_lock_irq(&head->lock);
 		list_del_init(&iwa->wo.child_wait.entry);
 		spin_unlock_irq(&head->lock);
@@ -246,7 +246,7 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 		return 0;
 
 	list_del_init(&wait->entry);
-	iw->head = NULL;
+	smp_store_release(&iw->head, NULL);
 
 	/* cancel is in progress */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)


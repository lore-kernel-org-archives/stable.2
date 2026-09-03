Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AA4772A1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440132; cv=none; b=pDNEl7mbfPspf+Tq0qnl8XnTmsagbdHV9AbEwlxYp/9VH4RRy3SLOSz55/oTLAokj08qzLwfUx1goa7iGKkshndNwMmDBo/fThe1iXnMMz/Qa/0PH52prvxih9wtheCcfAwd7ukZhC+0mtZzodLjwuSuSr/QzNER93QFSoao0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440132; c=relaxed/simple;
	bh=ri29d44DemkssMcG+S81lFBK1URXK7UqUgDIFNt855M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GIWptCZ7RtOaFu48MW2xPYK1LAwPvs8dr4ehP3qQ82/6qtHQqnBOYNFD3DQRc1c2RYgt7wVJ0XWHtJG9Rg+bt5fOe5WzCGc/Mq3ex0+FhvSDykCkBY+r2aS2NyJwbTrbr7OVfHS+M0OaDrmPV3l9Vx67nfS+pyeX3Q0vejvB4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igrIS+Gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igrIS+Gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A61F000E9;
	Thu,  3 Sep 2026 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440130;
	bh=d+EEkWEnmN/5yJNK0QomGhwUSUWXsP/UIZPCggNbflY=;
	h=Subject:To:Cc:From:Date;
	b=igrIS+Gna8jlJP4m7rmnGiETcs67BUKGF82gblpoYk4U1Fco+wFKw3XFUrpASkmvR
	 6R/p5nFfUTcS072uA/0P6NT7e1y87G0+VApwgtRnzejv9yUTvbh/xllj2HF4WtP58X
	 1gl+V2b6QSdKfYO6meJN4uBAB1BunvoN6SUAxHcU=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Fix Use-After-Free in AIO error path" failed to apply to 6.12-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,xingyuj@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:41:32 +0200
Message-ID: <2026090332-backlight-leggings-4547@gregkh>
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
git cherry-pick -x e78dcb1f7ec271449c54984dc90c62a5ba272de7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-backlight-leggings-4547@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e78dcb1f7ec271449c54984dc90c62a5ba272de7 Mon Sep 17 00:00:00 2001
From: Neill Kapron <nkapron@google.com>
Date: Fri, 24 Jul 2026 23:51:00 +0000
Subject: [PATCH] usb: gadget: f_fs: Fix Use-After-Free in AIO error path

In ffs_epfile_write_iter() and ffs_epfile_read_iter(), when ffs_epfile_io()
fails with an error other than -EIOCBQUEUED, the io_data structure (`p`) is
freed. However, for AIO operations, the kiocb cancel function was already
armed and kiocb->private was set to `p`.

If a concurrent cancel operation (such as sys_io_cancel()) executes after
ffs_epfile_io() fails but before the function frees `p`, a Use-After-Free
can occur when the cancellation handler accesses the freed pointer.

To securely fix this race condition, we must properly un-arm the
cancellation. Invoking `kiocb->ki_complete()` does exactly this by
acquiring `ctx->ctx_lock` and safely removing the kiocb from the active
sequence. In doing so, it ensures that a parallel io_cancel can no longer
discover the kiocb, effectively closing the race window.

We then return -EIOCBQUEUED to notify the VFS layer that the kiocb has been
consumed and it should avoid attempting to complete the request again or
triggering subsequent completion handlers.

Fixes: de2080d41b5d ("gadget/function/f_fs.c: close leaks")
Cc: stable@vger.kernel.org
Reported-by: Xingyu Jin <xingyuj@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260724235100.106011-1-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index cfa05266e551..43962e05eacf 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1296,8 +1296,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	if (res == -EIOCBQUEUED)
 		return res;
 	if (p->aio) {
+		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p);
+		return -EIOCBQUEUED;
 	} else {
 		*from = p->data;
 	}
@@ -1345,9 +1347,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 		return res;
 
 	if (p->aio) {
+		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p->to_free);
 		kfree(p);
+		return -EIOCBQUEUED;
 	} else {
 		*to = p->data;
 	}


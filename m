Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023C4A6CD1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440127; cv=none; b=E4mEoAi9kHjosN+IZ3SzG13LBEU2n7OP/H6uCW2T5stXko04IrFW7/lEdk1Ta0Wm7tX1jJS6uhWS0kLtQlvnf5CanEnaa8O0OUDX7nZLI1pHgKmZ04o3s50ar0PXHOeasyIVuT4hvFF5kyjzSFBX9M9nJis6nqluQroEvC6TFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440127; c=relaxed/simple;
	bh=GLYHTzzf43Hpsk0mX+g0ffWB2CvlVG4zy39yedivHKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p/hv6+CqOvUw3R0ptfHddZk6wqPQz8Mn0c4A+N3U2KH/s2cu5HPV53YnuSn74HKGwT/SBpeHKGkXjRY48iK2iSRKvI+djojO7R/BCDKBtVwHGQhc4IUMaTP3WrrryAOSoHv9QntlLJKdUDEBvroqWhQ9PYQXWAAl4WY4lweaDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHhJCklw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHhJCklw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E01F000E9;
	Thu,  3 Sep 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440125;
	bh=xflJ4G7SU1bfzM8l8CHpgRbHceKBStJ0/lvdOt9/TOE=;
	h=Subject:To:Cc:From:Date;
	b=xHhJCklwCsFZDwt6YG43/qiXJPiWG1DT75VHnCVUt1sWgrVZJkRu3qvCUw6w0touR
	 cCW+QebdU/3JUfGXxhB4ZnDsOR+e9g95lz5g2PRBUAKeHJM55kB7xP9VUOzBemAMbt
	 7OuPWwA7WjmxF8dtkaa2nl7d1S2F32jlD/ZvPsgE=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Fix Use-After-Free in AIO error path" failed to apply to 7.2-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,xingyuj@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:41:31 +0200
Message-ID: <2026090331-linoleum-freeware-d223@gregkh>
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
git cherry-pick -x e78dcb1f7ec271449c54984dc90c62a5ba272de7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-linoleum-freeware-d223@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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


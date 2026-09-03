Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276804A6CDD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440129; cv=none; b=bVqxQZIHjKxn5D2ErBf5bce0RnscRpKuENwJmoKAgWRU4WyDc5jRiub5k0QexgYkX0IV/dU6Fey3MuQHuukjKnEB049fq20CWozX0S6+fmr4n0hdcE51Li2Uccz3sHeItWOw8Uq4snI/iLrEikbDcaZqjy5fdyK0Xl2BaesCuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440129; c=relaxed/simple;
	bh=nsEs0Bj3rZ2zM38X0x3dwFvYQ5lP1rcZSfj+mZzvAb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dxqrl4EFHqATIe24/RAV7Ij02EYDsz/gp5X1ff+ATKtugl1u6l7nMG9EAubxrnSCqO1XjrW+dsZIktnPBFYWoITKiC75CnFrixFrePeR/uq/mfaF6DqxCaCLy6Lxst8xh+fcZldI0coXlk4UlPTL7Oq0zsWfJUIqt6kEdmmPHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EdsI2DXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EdsI2DXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC31F00A3A;
	Thu,  3 Sep 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440128;
	bh=7IBXpghcAjiA4w1iFggaRUmhB+xDOhrmthecuqIwMS4=;
	h=Subject:To:Cc:From:Date;
	b=EdsI2DXEFZzts3pLBjiuHZCkMclDipFjBY+MrKZIaBcpvV7hi6G7xC7BeVBt/qzxO
	 BLomlkL0HPoYzGMoYv1nTRXNvTIfQSD2f/Z86407ANyZoTqQkL5CgZxMpx3BFR78dt
	 i5xR5p2eGMzN0MLjzdj9wxn9+nl/AGOTWz3SfUcU=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Fix Use-After-Free in AIO error path" failed to apply to 6.6-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,xingyuj@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:41:32 +0200
Message-ID: <2026090332-unwind-impolite-0e7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e78dcb1f7ec271449c54984dc90c62a5ba272de7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-unwind-impolite-0e7b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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


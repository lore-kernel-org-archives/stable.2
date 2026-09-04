Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E0476072
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531911; cv=none; b=p0sHYszlwmNcdATSdXboNW1S55P9mu6Sn41i8J2zFhy+idgl3Z1VUHlstczunlpgF1qvETqv+XKspR4kjzs2DqOzjhtqqG8XCprDG2De7L2N6CPIJ5iT8W9sTHW5wbidxzpcvvdaSZjIiX9AcvF9y5ZRw+ESH0hvsLAgSEdRVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531911; c=relaxed/simple;
	bh=iFpxkGRspXany5+FhRUWDrKz8CoumgbKQqY55KzH1f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Npo1e4h5eKI2l/JJ0+NLdfo0/toG2QfOQClrFuW03aZ3T7QKA9yUEm8RbVJVFkDTvc8DEhWLieRAH6DTRbZ0UuVBCM1KzRwBjpa7iC6t8INAUYe2ELnlc731y8RY6gvYwz9j4+cf+M1lY+M2+7/H1bF62PXP1F7CdKYwtbi380E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg/lsbtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg/lsbtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133D1F00A3F;
	Fri,  4 Sep 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531909;
	bh=F1yaJogzqhMkZAMTcPY0GtH/ENoVlTj5wOJopMtfsrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lg/lsbtQkhneiT4sUMO4bfCoUMAs4UkWb8caCz1oJ7MNi4PM/g5tNqpRm6F4YjfOo
	 I1MPJwvfAjxKEVbYLxQGrp61VSnPZ/Ha5rhNm/VXopHiMYNjBmEW6pOw6Uz9WFxmNr
	 j808oyOimIeKlxLVTLu4lqtMgeAt3YjtotrJpwyJF9K+RR7eqcZJFD3BwsyEQxQEoK
	 Hl0NIHMPTpZc2aih4rsZXFSYrbHjDGz2/RxPGfcTZmpcVb9cDu3e6WbM4BWPAkNeH0
	 SE/WB+6g0ntxrh3HWzcCqY2eiDOB0IZvmOZGk4smkn656MDk6udpWMR3W1GlpGbsZU
	 NFgCwwyXUaS/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 10:25:06 -0400
Message-ID: <20260904142506.787176-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904142506.787176-1-sashal@kernel.org>
References: <2026090331-linoleum-freeware-d223@gregkh>
 <20260904142506.787176-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neill Kapron <nkapron@google.com>

[ Upstream commit e78dcb1f7ec271449c54984dc90c62a5ba272de7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c2b0512140f30..c5eb9642fd697 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1279,8 +1279,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1328,9 +1330,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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
-- 
2.53.0


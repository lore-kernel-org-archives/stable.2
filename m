Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCD4A2A75
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537224; cv=none; b=WPmleKpVBoak5iYzbiQROojPCQvFQFFXtQNxHzDOk/Sr9fCA6NaknsMXut/9bvDZah4aaHEQ3UIIaHaipGnLu4TkCU8xCzSAFep7kwZDJcaS6PnC/OblIUYJE9vju9/xV7xZBqF63iQbDMF35I2F82EXjxUBZw4Qzp04fSu6N58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537224; c=relaxed/simple;
	bh=xLKp4Wdh8kmBY+q4hDd3N9IejIIHC9Eu+M57ezHvBQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxZL9KxoewptJRgYCONd9I9ieBCBBJZiPVBLDo8UEECoDGf3gpBQr5daSlIVdSw00LpxSBVaeGwQm1wKgtsfQ4cymKxLW7gi3exFR3vXlNZ7hjvG/NtknY2ZzdNnZcqFWCw/YtUf+HBZ1AeULNh49pHRQOV7YIdO49u8xETmq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9oS3Cgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9oS3Cgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AC41F00ACA;
	Fri,  4 Sep 2026 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537222;
	bh=IyknKemI1Af/VSFwaEoIbQSUtCu7vvFSYWo6zi69R2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9oS3CgrzTvotlWxLGahQgBy6sLLJ0RVLb4qzqxGira/Dgk3thU0WbeQKdmJPZql3
	 kkmXuOKKxR8ASzxoBfw1IUISSsIUYAX/i0LsVSXtZchkOlLNaX320AsPE5zFwrqm28
	 yP2pJNI3jzoq2mNkAJOYnYDvQ9MD2LyBA/AWmIY6ocdniau4gG8OJZd15gPAWL8Bd5
	 XHBaQXJAdGrXTvzgVSe+WaqZEeAuNOlEQjg7y17GtGRoiBffwTS7gHgi0K5iG72R5f
	 /huc8AfYVV0pKJeA6AMU4TsHKI577CwJ9jl/bDmX4QJ97thQAhj+hlrFIwbSlYsAZW
	 eZ/l9+XWxxNgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 11:53:36 -0400
Message-ID: <20260904155336.1042108-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155336.1042108-1-sashal@kernel.org>
References: <2026090333-willfully-art-ea0b@gregkh>
 <20260904155336.1042108-1-sashal@kernel.org>
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
index 7edfa788e6836..cc728a830197d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1238,8 +1238,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1289,9 +1291,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFA4E66B9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534294; cv=none; b=qlCGtNI2z4d7C8o9aycHVt21qyeFfBSH+hK6Zqh3Y2cIhBFsmETbaTEppO9VheNijPgvisSoUblBwRj5Qoa8C8FAY079dH3d/jeU+ApBQCxQE4MNBP2mvLOck8/panLEf0ksXvpONoRWR1fL0nhDQF8f0DEppxI9v0duUcr56X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534294; c=relaxed/simple;
	bh=au8Uc+NRitPOLYXmCRCxxWh/PCXMZZzhD/Vr2eNCChA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMSzqDpUqygoAv1z0qjNj+dRgDIS3L7mj46GHXLP8PXN5A35fJNQFrUwiGKyEbjeQ37bzTikpVvVYJQOKHT64X7bgNvTvnmtcb/UrFj9mNIMRDbfRH6eDM4TxRK865nE0v6E2vHtNPdq5HptPLLbe5mC/S7Qy5igiE0r5ToBINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXXy3J7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXXy3J7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC1F1F00A3F;
	Fri,  4 Sep 2026 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534293;
	bh=BDcANqW+Rq/UvxLABfuBXgxKq0b88YHJ7dmOOrdjDJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXXy3J7jsS1+XyY9kFj8YpgMb8k1E/SR58pDMOX4s09JHd2sOobR4saSn+8boYz/y
	 SC5OoerUgUERBhhdJp2CZI5IX2pERM96cqOke/tHQ+BzxWyLnobVahQgDTwWJsjL3u
	 OIA2TtFLDUVAcvS5n96plOKquA1AZLVpXedt1vvUxZvBZ/ujFOs38VZOylMwauNCMt
	 O2WjMPlStcMDhkvwjuJHvHgtJG+0m+W2wG5VEcb5Gb9527Ycd2E/W77huiogHWsYNw
	 rlUknJKMIjEF4Vj6pSx93fqGJEoST67w9TD2Ys+McBO+kYU3XRVM7/uMjVtbEeYh0u
	 9hHeBzx69LVtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 11:04:50 -0400
Message-ID: <20260904150450.864888-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904150450.864888-1-sashal@kernel.org>
References: <2026090333-safehouse-purify-4f27@gregkh>
 <20260904150450.864888-1-sashal@kernel.org>
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
index 53d7c54ee267c..348d77019330e 100644
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


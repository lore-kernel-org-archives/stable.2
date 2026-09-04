Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AF48C8A5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537222; cv=none; b=lz7LuDD10jMzbv5XycqDvaX2PYAx3keZ2IRM3xo/H7wmK64e6QaFF3lSdUf4SGL0S5344OpeUUB4YHNaTPq7Sr4DpKPP+3vBhNBSHyRl7kX4zWqixjopNPb8VKEsPFFGhIFBEKLxle4PoTy4LOA0G6fN+epzmSzGmwhO4Vb5pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537222; c=relaxed/simple;
	bh=ixmqzwT8zUTKvkC+0tGMgiZDo6r+7JupF2B+dFR1kec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWCUJPTDAh9pxq3wWKYhuO2xMO+9biHXsvVgkAM2GI20mCzlyd6tOavYiWwaiOL/E7htwDHdNAarLSyyIbNQvmgEHs+/1tVnRX8GlnmqxNAzm8yPlAJfJfm57H/OfN+T9W8zDILFdRw/Z70Pur2Km4csCQT4iYbhf8rXdWGD+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTMrZS1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTMrZS1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F3A1F00A3F;
	Fri,  4 Sep 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537221;
	bh=JDaDIv27+8tE2sOAxNiaNS/tY73dvJSgvwX/rFHl3MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTMrZS1SYMSsUQ7+D9W7pWVfapOm4tF6qu9MzTe4SAXLe3U9OxKgpTlWgLGYTcqjD
	 yvsWsgeotdB5U/yois1dGI/vR+sLG8KrAqKb+bFrBjO+3nw53+MjV2tNIchtEpb/7E
	 hU4Cg6IW9xIp+HbQA9b7VBof5VXEJAPADT8WI1UNzpcJPCip/X0Cbg7q1kzumk7Tqy
	 xqDmB7jVMeC7fQHMXRyZz99g6wpr/Qdjfm14r6X6Trokni7X1tOe5pDFqzWRPNyPre
	 rzhpLM7NsKyPK/IgO6klzT4xAL0DCP5boqsqLuAiiaQMewCFu8OmmOSQ75rG4PEZTe
	 0GFV8frL9KAyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 11:53:35 -0400
Message-ID: <20260904155336.1042108-5-sashal@kernel.org>
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

From: Gabriel Prostitis <prostitisgabriel@gmail.com>

[ Upstream commit 5eb5c72c72fef76cb765ef1669b62b6a3ba1bfc8 ]

io_data stores a pointer to the submitting task's mm_struct,
but does not currently hold a reference to it while async
requests are pending.

This can result in a use-after-free if the task exits before
completion handling finishes.

Take a reference with mmgrab() when queuing the read request
and release it with mmdrop() on request completion.

Reported-by: Gabriel Prostitis <prostitisgabriel@gmail.com>
Signed-off-by: Gabriel Prostitis <prostitisgabriel@gmail.com>
Link: https://patch.msgid.link/20260601-mm-uaf-fix-v2-1-3c942a707bce@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0588be1109022..7edfa788e6836 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -836,9 +836,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	unsigned long flags;
 
 	if (io_data->read && ret > 0) {
-		kthread_use_mm(io_data->mm);
-		ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
-		kthread_unuse_mm(io_data->mm);
+		if (mmget_not_zero(io_data->mm)) {
+			kthread_use_mm(io_data->mm);
+			ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
+			kthread_unuse_mm(io_data->mm);
+			mmput(io_data->mm);
+		} else {
+			ret = -EFAULT;
+		}
+		mmdrop(io_data->mm);
 	}
 
 	io_data->kiocb->ki_complete(io_data->kiocb, ret);
@@ -1223,16 +1229,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	kiocb->private = p;
 
-	if (p->aio)
+	if (p->aio) {
+		mmgrab(p->mm);
 		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
+	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
-	if (p->aio)
+	if (p->aio) {
+		mmdrop(p->mm);
 		kfree(p);
-	else
+	} else {
 		*from = p->data;
+	}
 	return res;
 }
 
@@ -1269,14 +1279,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	kiocb->private = p;
 
-	if (p->aio)
+	if (p->aio) {
+		mmgrab(p->mm);
 		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
+	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
 
 	if (p->aio) {
+		mmdrop(p->mm);
 		kfree(p->to_free);
 		kfree(p);
 	} else {
-- 
2.53.0


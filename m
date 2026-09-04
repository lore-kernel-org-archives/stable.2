Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F24330D35
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532183; cv=none; b=rA7kUXKS05iytixGlh/19p9q4TFZ+lCQT4W5dA71AyyEVAdHEmwxUoCjcafxZIMkuakTnNdCrvk+fbBYqEQQKjwzITDQzIUFpo1XIQMQDrmY+x1St9uZLgS3MlDj1RfCD3t4aDNGhNyuQN4cy34E/vo/JiooCne4Ue1K9cVo+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532183; c=relaxed/simple;
	bh=LKfkAPEsOpFos/BavIJOvjN1BiZ6HKAdnR9T6j8g99Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgWiOjxVVkiddRe+bpz0/5DEJ8TW7OnS58jcLxb//hWm6UKVtuMz//gNH0V5E8XoZI44EjynYmn1MIqu8u0SV0XHaLvw1d1KzwCq7rhkX290puKz9vWojz36rfdpHy8oBnfEP3MQi3jGnJIBNFIwp6SmYVAzEygBJCrXGPQ1Uzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIPZ7dgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIPZ7dgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB571F00A3D;
	Fri,  4 Sep 2026 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532181;
	bh=kdvHMwnk3kgNnRM/ORJX2XoyEvSIfqXx7jShtABhuA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIPZ7dgoU0ihm29RRyrp4skFfjFy4pLAvQGzuGx7LI8MGmXSQ3qDGCogKnNSbugA4
	 AXBujEtYrFGKKJfTVbKl1jSRpj8QUSpqM1DjrgznR2Xecd/49WjrCUxTQ2c2J+nX+Y
	 sMLgiXda/bnc3uJjSek0qr9pWR/nGiOof+Xi4uvXLlUnQ4NPaIeGVDFGVX0t72lAdP
	 9OXaUllh9gDYvEgODJXpfy/bKIl3HiA526jbihGA+TAU02lCtzOlUmn2hA5g27mCB1
	 Tns8Tgpk2khlN9FWPA38gtFkd0Og7+m27PImpZPJorQs7k6gn7lSZPDhIV/U/2b5Gw
	 vTvWtxVCLYg5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 10:29:38 -0400
Message-ID: <20260904142939.798242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-width-covenant-cd4e@gregkh>
References: <2026090331-width-covenant-cd4e@gregkh>
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
index 3116060977185..a00bf66bdf878 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -857,9 +857,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
 
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
@@ -1240,16 +1246,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
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
 
@@ -1284,14 +1294,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
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


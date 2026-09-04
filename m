Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCB44999F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531910; cv=none; b=Xw+bmIkHPGrLg2kY6eSR6C+sQL1iMaSiCEQH69Z9UrooeojwgOuXT7/tPQJx1166KGkiZTe1IUqVDgf6L7Yz4BSOv9UKmy91v2jOB+PD07r9ht26JhUY8iuUSNyG1MVo6VZj1ja/i0g6TtOoxG1+oFyd0EmykMuvEW6IUor3tpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531910; c=relaxed/simple;
	bh=1Eq00YRDcJoQQX9u2+WBwfNh20EaqgvPCp9QT8Ru6pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqs46sC6Z6/c+EWtGV15DWgNF3DaXQsGO6cDZidNUgymQohQca2esszl/aiJX07mzNU1SdN8UC3VAW++zIpOgacx2/wcujxdedNc/BRLyR6O5gf8CoDWmrP2jdsvbmnBYoo0nIgkWjdaIWSclIxFyMx9WwGJWAxa/knZ3RVM2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbiJ5Nzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbiJ5Nzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243651F00A3D;
	Fri,  4 Sep 2026 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531908;
	bh=sZK91PqepCU2MVb001AY0ciuwqN6f1Wk+8GhSbCuVgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbiJ5NzmNNzu82G5dSgAvvuN7YgKWXDkOuo/BbZ397w/+kBS9PC9BbeIU2n9yjakA
	 5jBW+6s6gkKv+GO5E3U1Bu4e2ZqXKQdClpFyWlTRrLHksFOqJvBY7u3nMj9HXJVHMS
	 M2dibUGrgZHZKPU4vwk5DfsKQU6SC1P3Z+2rhtrFuY5ahnaAmOFaSp04MgasjxiSf/
	 8GcAVDO413oopXr5emeca7NVmApPbj7HIlbWr6qnWOrNkzjrOrukajzTfvsRfyuZZa
	 LE7cqM3bNQEf+Aq21F76iQw9E8qQ1VT0zGqY91Wqj7PKwCJdbelnY8SlrikiZjIi4h
	 KDC1umVw962ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 10:25:05 -0400
Message-ID: <20260904142506.787176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-linoleum-freeware-d223@gregkh>
References: <2026090331-linoleum-freeware-d223@gregkh>
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
index 44218be1e6768..c2b0512140f30 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -867,9 +867,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
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
@@ -1264,16 +1270,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
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
 
@@ -1308,14 +1318,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149E3859D3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534294; cv=none; b=bKnI2m/CELO/GGuw9RytGDtAfXcjfHHHteUMfF8L09OG8iU8yuvtkmd+Yi8I1Qr4JW22XnS+qthLYA2UXOCSP60YIr+lStEDHbhB52HjX5ngNznoo8wYDSYScpTKVbHUjYd2X2cuvVaaJ7UVt+aFIBFXyIKdgPkLmi0oviSI/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534294; c=relaxed/simple;
	bh=ABZNJHG0kF9e7QDfa9FSPncQwki8GBkFELWNkE4ovYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNDj3dB9MBshyDKzPGi8Lu4YRH8tyqPYG70iaSsJajP2oEl0Yocn0jyrYfSO0LVN792cVu9HJ8MkY5ov5x4+7Dwc45jgqPmIbbPzBk5ipEyPpiiA8UrFJzFax1x/zHTINW5vaeVf2z4y2owUXtxAZOTC8e0UiZNH9GKbuAL2q8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un51eBwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un51eBwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C855F1F00A3D;
	Fri,  4 Sep 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534292;
	bh=q5BYbb8gPrwGm6WEpeat0d7oNT01OxcbK7N33fYCz5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Un51eBwtoo99EDDOB/y3AxoTg8AAgCUlvWJBL9VC2AiGj8fUoKwt3p+xqhVmAzuRT
	 wuKqlDjNNFkNUvclOFgHJWEHpTfU8E/rVZIAECU8AYSLCwQXw550i503PPBy3Xkeiu
	 v6D/DcTxy2WeKU2pvPtkHF2OCBnidm23nE3ItmpkwSr0tBEUSFzIwgyjNK7GocIAfN
	 7vvMFaF4WCW4418pc2kQ2/gPhj7lAmgg5/QdoDEZF4Nz1kevB4/6cISk9I4Dq4bn8K
	 Pg0RCgG5LYN+djh8qG5ORrwr67fu/CichMf+2dN3CwpBEwV5g1deq9HR+YQIkTdHSi
	 hZ04fBtM45g5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 11:04:49 -0400
Message-ID: <20260904150450.864888-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-safehouse-purify-4f27@gregkh>
References: <2026090333-safehouse-purify-4f27@gregkh>
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
index f83992f8eeb76..53d7c54ee267c 100644
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


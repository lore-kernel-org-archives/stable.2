Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B484CA793
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533504; cv=none; b=c+y6YfATjS155TVSh13Mo1OWwR8ui8txH893zs1jcdhZbfewYGyVbQS67v7lKu04D0xFo7DFSm7o8mA2V0gGeHPbsrlXOTKaS21I6kr9kMIdAewFgUSpQxb2My+yWXdiYaIsrcM0iwwj3pnYaIg96GDc1Moxe6s0zdV7+3gN8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533504; c=relaxed/simple;
	bh=VSoNSatUnZ6Akh3tV8MAOrvTfC3aXRTzxr7aYFG7RP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3OTe8UBAfQffovEJW6do25865bUb6+By187XTaHDK1A3VpY07LKHVCM2stFYDT5VlySakbe/Vxw9Rjo6sdQDV+D7pmRtrJU9lPmp6lQL+hHTzJoNzOFr4e+8zU0hwFhwdqIbXBtfLF0LaHjlHlavG0793YkQWfszYl50bLXYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAaoVwRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAaoVwRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBBB1F00A3D;
	Fri,  4 Sep 2026 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533502;
	bh=/zkTuOmP9d7vFnjwd3ZTWJwYL3JgWMFm+/sFzRJIp2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SAaoVwRyAQQLjWNDI2ZChP2WnlRC+DY8+eLwb+K38EwqvHJ/AhOZWrmYBIiHG+0Ub
	 cL1fT40X7WN3TDljrkykTjgi6LGXSajCj3lHzz8u9OgXlTjsnFGeuY1LJNgl6TInJ5
	 lKLUIR0Zf319RzMSN/ZWwvOmYlkPcmBYzLku2IiOvj78skEsmW9zNwEMffJFmU7U4y
	 k3+CvPharyGlaqnVuKRWLFdikGgu5uCvjMzgg6NdKgr04Ppjqve76Fu3ikyRYAcGjW
	 p+JRuAfe7UyxDnMEQLclEy8nv9QEVqenEvUBXLSUvgQD+SIXiupA07MFe7BWj8pL5M
	 lParrihUImdiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 10:51:39 -0400
Message-ID: <20260904145140.837773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-unwind-impolite-0e7b@gregkh>
References: <2026090332-unwind-impolite-0e7b@gregkh>
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
index f4658e8986735..7e228ed9729d5 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -825,9 +825,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
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
@@ -1204,16 +1210,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
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
 
@@ -1248,14 +1258,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
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


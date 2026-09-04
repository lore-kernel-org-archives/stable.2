Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821032D0EE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532366; cv=none; b=mIezeuLCn/otnJ/AiFQSvjjnRK9M9mi+R0paVfs8S89pL6mbe/JKuxMMQdk/Gjl4dUV+5Y1Gxd5pUDy5WsSN1tn+HJ96NfvHbEH1ALaI6u3l5djAgnEeb1Ze+FiOVTGnd0wkv/NVBCaZ9+qxXkm2FvfDE+nbZmzWFNah5qA8RYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532366; c=relaxed/simple;
	bh=pkd/2GYnzAyygrYikwMwScncC+vXx9rKsoLqjVMzJKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBBGz7erMgzxF+0tAbc54XI7HkDfZo3TB2CZyLCyiSvX7OyaruSPUNTosafyBvWXZU7EkIuB3yh/46d8LvUhcL9SHbXDd1pPlm05kDeC7G5o52HzTU3VJv0KIVj9j8BoFbevsTr6LeuhoH+V+++E0CpSU3cLyIxvKnKiJxag3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAjvqxqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAjvqxqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260E1F00A3D;
	Fri,  4 Sep 2026 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532364;
	bh=AxD0MC1Tnc/o1xozej1h2douAmtkx5ZCiy6t62cfpmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nAjvqxqSIYkfKP3c1XH2Pv6nneMdapNmBrGo2xCwCbVQVvih2t+MeegbeSPG95E33
	 KCZRUqMMlFV631uhfcu20ir3J4mdpxXhV4YMKTiyYQxxOqzE9fje4hw/qy6d+QpSLB
	 BmLcUNtL0bdQwrJ8G4tuRaiviv3FyiT9DYnohkRwVnsilT2dP40qzxr/PCIKVY+gFu
	 Z+pVNPUlu7goP7FUginrteRnZRZJsv+yNXUyNSPzRx6ja24aESMA/IctKrr1jIZOc5
	 4HfOuUUn0/5Pu/E4k1E3iSr+q1CmYJDbKVPTVadTh5E0iNDHM+2ANV8/RkKSvNVns1
	 EVrgAVq3ROdmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Prostitis <prostitisgabriel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] USB: gadget: ffs: fix mm lifetime handling
Date: Fri,  4 Sep 2026 10:32:41 -0400
Message-ID: <20260904143242.806049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-backlight-leggings-4547@gregkh>
References: <2026090332-backlight-leggings-4547@gregkh>
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
index ae34a12080edb..c6eadd3433f27 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -860,9 +860,15 @@ static void ffs_user_copy_worker(struct work_struct *work)
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
@@ -1252,16 +1258,20 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
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
 
@@ -1296,14 +1306,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
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


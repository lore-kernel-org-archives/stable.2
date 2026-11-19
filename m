Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.154.241.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101601;
	b=jIWiGgadgjvU7gsuYe1nkRHTMjtbr9hVZWuyA+Z5e+mSlh/d/3OFwawqz3g/kP8Mz9gj
	 vc4dxfX30HoCxfSNRI5Psy136gu9zAcjpcPwzPlVov90cDFSu+MngCfh6pDVXOxjIYEwv
	 p7phUTTpHhZXFzFXCMGRDcLYXNs1XMdJac8soYL+fmTkS4pSs03oE/HKhhyj0JiA6/ml6
	 Xo5vwdFcmm2JVzPeQskFUSxELUGZ+VYlKYLkAhuVc0wi508GF/9zV24/kf9UVTdYPE7xH
	 80HdrCxHpuJZ+kpoiT2LgLQKgNVPZOIsBdJXI3wOTE7eT0E0nRjA9VuKZogZb3pfueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101601;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=FurqrIAPM85UON09aO72ujx4pHuxjDLH5EoJY08rtMU=;
	b=Aj19vbODLNnAa7YEC6wsR9qcMvQlvuN0Tz2juQrvmT9ZlPE87qtuN+NQkb2bHfxHtLkR
	 BtyMgmJ2lpEj+uk+7mdmlhVRALKj5ip6wmacNvOnStwFoaJ4+NI7aKq/Urz47JnyWoi8Z
	 WvyBkxUGeQAxBWbV0mxFiDCwGjYe9X6nyofRsUOjTO29qauos9rwN61zNRXiVbaf+vEWO
	 1WTc44UPO2Fxj2DwK4A/I314+OGpmkwiQpN4jbj2BuYwaTKQziA8y2DQOmTaIeXocdJ6B
	 D5X6Wh+H0VbtLA8AWibgK59+jc3+8J2vVIym2WlHRnMvdNL0GiJuI77dPO4tjzvES1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lauterbach.com;
	spf=pass smtp.mailfrom=lauterbach.com;
	arc=none smtp.remote-ip=62.154.241.218
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8B606A32C;
	Thu, 19 Nov 2026 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D8B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id 1A01A4303CC3;
	Thu, 19 Nov 2026 16:19:53 +0100 (CET)
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: gregkh@linuxfoundation.org
Cc: viro@zeniv.linux.org.uk,
	nkapron@google.com,
	me@samcday.com,
	michael.bommarito@gmail.com,
	linux-usb@vger.kernel.org,
	Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] usb: gadget: f_fs: register cancellation handler only after request queueing
Date: Thu, 19 Nov 2026 16:19:41 +0100
Message-ID: <20261119151942.44304-2-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119151942.44304-1-ingo.rohloff@lauterbach.com>
References: <20261119151942.44304-1-ingo.rohloff@lauterbach.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1795101593159

Call kiocb_set_cancel_fn() only after usb_ep_queue() completes
successfully.

This also undoes commit e78dcb1f7ec2 ("usb: gadget: f_fs: Fix
Use-After-Free in AIO error path"): The described error is avoided by
making sure the cancellation handler is only registered, if there is
something to cancel.

Registering the cancellation handler adds the kiocb to the context's
active request list (active_reqs in aio.c).  If usb_ep_queue() fails, the
request was never actually submitted to the hardware, which means the
request is not active.  The aio framework already deals with calling the
completion function ki_complete() automatically if you do not return
-EIOCBQUEUED.

Fixes: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Link: https://lore.kernel.org/linux-usb/20261110171222.22633-3-ingo.rohloff@lauterbach.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 drivers/usb/gadget/function/f_fs.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 704cfae49f11..cf0287064923 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -246,6 +246,7 @@ struct ffs_buffer {
 struct ffs_io_data {
 	bool aio;
 	bool read;
+	bool aio_active;
 
 	struct kiocb *kiocb;
 	struct iov_iter data;
@@ -887,6 +888,8 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	}
 	mmdrop(io_data->mm);
 
+	/* Make sure kiocb_set_cancel_fn() was already called. */
+	smp_cond_load_acquire(&io_data->aio_active, VAL == true);
 	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
@@ -1014,8 +1017,11 @@ static struct ffs_ep *ffs_epfile_wait_ep(struct ffs_epfile *epfile, struct file
 	return ep;
 }
 
+static int ffs_aio_cancel(struct kiocb *kiocb);
+
 static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 {
+	struct kiocb *kiocb = io_data->kiocb;
 	struct ffs_epfile *epfile = file->private_data;
 	struct usb_request *req;
 	struct ffs_ep *ep;
@@ -1205,6 +1211,14 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 			usb_ep_free_request(ep->ep, req);
 			goto error_lock;
 		}
+		kiocb->private = io_data;
+		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
+		/*
+		 * prevent ffs_user_copy_worker() from calling
+		 *    io_data->kiocb->ki_complete()
+		 * before kiocb_set_cancel_fn() was called.
+		 */
+		smp_store_release(&io_data->aio_active, true);
 
 		ret = -EIOCBQUEUED;
 		/*
@@ -1285,21 +1299,15 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	p->data = *from;
 	p->mm = current->mm;
 
-	kiocb->private = p;
-
-	if (p->aio) {
+	if (p->aio)
 		mmgrab(p->mm);
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
 	if (p->aio) {
-		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p);
-		return -EIOCBQUEUED;
 	} else {
 		*from = p->data;
 	}
@@ -1335,23 +1343,17 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 	}
 	p->mm = current->mm;
 
-	kiocb->private = p;
-
-	if (p->aio) {
+	if (p->aio)
 		mmgrab(p->mm);
-		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
-	}
 
 	res = ffs_epfile_io(kiocb->ki_filp, p);
 	if (res == -EIOCBQUEUED)
 		return res;
 
 	if (p->aio) {
-		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p->to_free);
 		kfree(p);
-		return -EIOCBQUEUED;
 	} else {
 		*to = p->data;
 	}
-- 
2.55.0


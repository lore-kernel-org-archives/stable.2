Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34593E44E4
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546926; cv=none; b=D2ERxPftKxS8g67XtiSMlpyWDbtbXu2PIlwUXnFrg4RUq71p0zeCnPYvIGoSPbs5S3vw8oBPLVtK5QBTYrPd0U2mGy/P3QldNvhe2z5AOSu2PRTx8KQfWICbXvwg01KG0pZR5t3muvknIi2oQCzCXTi5qyjcJq9eCKqsHhTKt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546926; c=relaxed/simple;
	bh=l/cL0/flrHXRq6z/mE1vyqueo0P3ULKj5aUuUIPDmug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOHkJd0MiXPwhKHoWF9vkQ9rycOzgYmPbEZygxzmjdgy1duc+Qrp4e+SC1oyyxXJvjPmqUyXyQWsq7dFLia7vnpxjW91kNr2N51ublouOslfsF9lx8VUYpPiOsjKfYXDcHl9Na0jkPg5nO6/9wk5xAlGo2+o4vpkH72YVZx1uAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQNIP2eU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQNIP2eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616141F00ACF;
	Fri,  4 Sep 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546912;
	bh=7ff67uWcNDkoOMwu5zHJkFtXnJLA87WGW/25BFPdLOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQNIP2eUmNI8p733c1zuH+UlJFq0CkMXg+28UYk4dzQh3VrsjZYDBPXJhxFDY4pic
	 DHpv419MYZemOX4kgaT+9tOIUzEwusIk47JgEw+OkqAJOeaUkfTuEvE3EfuyDzMoAc
	 vs/DQB7gYgSkjxOFPYfaIWrnHm3BPGjXRWjWDhdUfFKgQKKr8GAfndY08Rs9E7U5/e
	 ViHA4SqpuS1+MOaMlZG5Dx/4L5nmiTrDkkY0hrO9fC8KPoQmCJwn/HkGZcWwIOFdMp
	 luZXkJZmFZPI6wJGWN+R8XrBLdu9yWxzxskTym/mkOqmuSaNu1sJkf9JHMDsIm2BAz
	 3CWOP7Vq1134Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] fs: get rid of the res2 iocb->ki_complete argument
Date: Fri,  4 Sep 2026 14:35:08 -0400
Message-ID: <20260904183509.1323404-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183509.1323404-1-sashal@kernel.org>
References: <2026090334-tiring-good-fffe@gregkh>
 <20260904183509.1323404-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 6b19b766e8f077f29cdb47da5003469a85bbfb9c ]

The second argument was only used by the USB gadget code, yet everyone
pays the overhead of passing a zero to be passed into aio, where it
ends up being part of the aio res2 value.

Now that everybody is passing in zero, kill off the extra argument.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

[ sashal: Reduced backport -- upstream 6b19b766e8f07 touches 18 file(s), this
  backport carries 17. Not backported here:
  block/fops.c
  fs/cachefiles/io.c
  fs/io_uring.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c                    | 2 +-
 drivers/block/loop.c               | 4 ++--
 drivers/nvme/target/io-cmd-file.c  | 4 ++--
 drivers/target/target_core_file.c  | 4 ++--
 drivers/usb/gadget/function/f_fs.c | 2 +-
 drivers/usb/gadget/legacy/inode.c  | 9 +++------
 fs/aio.c                           | 6 +++---
 fs/block_dev.c                     | 2 +-
 fs/ceph/file.c                     | 2 +-
 fs/cifs/file.c                     | 4 ++--
 fs/direct-io.c                     | 2 +-
 fs/fuse/file.c                     | 2 +-
 fs/iomap/direct-io.c               | 2 +-
 fs/nfs/direct.c                    | 2 +-
 fs/overlayfs/file.c                | 4 ++--
 include/linux/fs.h                 | 2 +-
 io_uring/io_uring.c                | 6 +++---
 17 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 4af79af8d2f1e..8cc7768026856 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1030,7 +1030,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	af_alg_free_resources(areq);
 	sock_put(sk);
 
-	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
+	iocb->ki_complete(iocb, err ? err : (int)resultlen);
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3db4dad0d072a..82be0676a66c7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -497,7 +497,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
@@ -575,7 +575,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
-		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 9d1acc4a52538..e6280d08fd3a4 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -126,7 +126,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
@@ -223,7 +223,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 complete:
-	nvmet_file_io_done(&req->f.iocb, ret, 0);
+	nvmet_file_io_done(&req->f.iocb, ret);
 	return true;
 }
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 69547cea25383..4a533fd934e43 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -243,7 +243,7 @@ struct target_core_file_cmd {
 	struct kiocb	iocb;
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct target_core_file_cmd *cmd;
 
@@ -310,7 +310,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	kfree(bvec);
 
 	if (ret != -EIOCBQUEUED)
-		cmd_rw_aio_complete(&aio_cmd->iocb, ret, 0);
+		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index db562d417e9d6..19d7b0cec0b03 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -842,7 +842,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		mmdrop(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, 0);
+	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index cbe8016409162..8c6d73e5daf70 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -473,7 +473,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret, ret);
+	iocb->ki_complete(iocb, ret);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -500,10 +500,8 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		kfree(priv->to_free);
 		kfree(priv);
 		iocb->private = NULL;
-		/* aio_complete() reports bytes-transferred _and_ faults */
-
-		iocb->ki_complete(iocb, req->actual ? req->actual : req->status,
-				req->status);
+		iocb->ki_complete(iocb,
+				req->actual ? req->actual : (long)req->status);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
@@ -2136,4 +2134,3 @@ static void __exit cleanup (void)
 	unregister_filesystem (&gadgetfs_type);
 }
 module_exit (cleanup);
-
diff --git a/fs/aio.c b/fs/aio.c
index 22b6e20322741..e067ef1b4e6cb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1434,7 +1434,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void aio_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
@@ -1454,7 +1454,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	}
 
 	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
+	iocb->ki_res.res2 = 0;
 	iocb_put(iocb);
 }
 
@@ -1525,7 +1525,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		req->ki_complete(req, ret, 0);
+		req->ki_complete(req, ret);
 	}
 }
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 906f985c74e7c..c15926bba2804 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -352,7 +352,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 				ret = blk_status_to_errno(dio->bio.bi_status);
 			}
 
-			dio->iocb->ki_complete(iocb, ret, 0);
+			dio->iocb->ki_complete(iocb, ret);
 			if (dio->multi_bio)
 				bio_put(&dio->bio);
 		} else {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4d0bdda8d8f00..00b71559fbe9f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1052,7 +1052,7 @@ static void ceph_aio_complete(struct inode *inode,
 	ceph_put_cap_refs(ci, (aio_req->write ? CEPH_CAP_FILE_WR :
 						CEPH_CAP_FILE_RD));
 
-	aio_req->iocb->ki_complete(aio_req->iocb, ret, 0);
+	aio_req->iocb->ki_complete(aio_req->iocb, ret);
 
 	ceph_free_cap_flush(aio_req->prealloc_cf);
 	kfree(aio_req);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0da9c11cae278..ac6ba514e8821 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3125,7 +3125,7 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
@@ -3861,7 +3861,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index c64d4eb38995a..37fd7d2d22cc3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -308,7 +308,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 
 		if (ret > 0 && dio->op == REQ_OP_WRITE)
 			ret = generic_write_sync(dio->iocb, ret);
-		dio->iocb->ki_complete(dio->iocb, ret, 0);
+		dio->iocb->ki_complete(dio->iocb, ret);
 	}
 
 	kmem_cache_free(dio_cache, dio);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a8c080b485d03..062ebe70c2648 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -693,7 +693,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			spin_unlock(&fi->lock);
 		}
 
-		io->iocb->ki_complete(io->iocb, res, 0);
+		io->iocb->ki_complete(io->iocb, res);
 	}
 
 	kref_put(&io->refcnt, fuse_io_release);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d3aa7ddbd0774..d45aa48966346 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -139,7 +139,7 @@ static void iomap_dio_complete_work(struct work_struct *work)
 	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
 	struct kiocb *iocb = dio->iocb;
 
-	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
+	iocb->ki_complete(iocb, iomap_dio_complete(dio));
 }
 
 /*
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 499519f0f6ecd..432498b1362af 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -275,7 +275,7 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 			res = (long) dreq->count;
 			WARN_ON_ONCE(dreq->count < 0);
 		}
-		dreq->iocb->ki_complete(dreq->iocb, res, 0);
+		dreq->iocb->ki_complete(dreq->iocb, res);
 	}
 
 	complete(&dreq->completion);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4440ff43cb66d..5b6786a8f6245 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -279,14 +279,14 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	ovl_aio_put(aio_req);
 }
 
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
 {
 	struct ovl_aio_req *aio_req = container_of(iocb,
 						   struct ovl_aio_req, iocb);
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
 	ovl_aio_cleanup_handler(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res, res2);
+	orig_iocb->ki_complete(orig_iocb, res);
 }
 
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5417515c41119..1b50d344e7a9c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -332,7 +332,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 01eff1694d8c6..4608f4d5ad7dd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2796,7 +2796,7 @@ static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 	io_req_task_complete(req, locked);
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2807,7 +2807,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_req_task_work_add(req);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -3032,7 +3032,7 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		kiocb->ki_complete(kiocb, ret, 0);
+		kiocb->ki_complete(kiocb, ret);
 	}
 }
 
-- 
2.53.0


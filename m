Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AE4EBAE8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537222; cv=none; b=HYr4KMNH9h3M/cafLnK7xJvY6EC5DDiugC+AQJxuJzomEHR7ZmfTmsN9/9QpxtbJ1EXa+Eko3YRXYpFX0l4ZHaPzIzwBOfDyfZJW6H7ykjy9KAJ6JydCl+bt7I17bkCfRFoqqz9dYQoRb55gkFYbC+35m8ZbXswq+jEwMAulW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537222; c=relaxed/simple;
	bh=MW2jqOiKX16rAQ9+yaFZdRb7zH1titG4Z7kuQN+q5es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9eqYdTdDBjeZ9EDcZZeWOLvJm62tW8mbZLS+PJHFSw3wWiX3DMasfLH0JvF6J28SI5qv82q5kVPzCmHYvmWOI5eHG/Esl2H0ObVKfdBNGCsBD8ZYTz76sG3u3XmW9j1pkDqmzUREyE4WEzYzrkscfNcUh7OikL8lVSV05HMw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgzli07a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgzli07a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5741F00A3D;
	Fri,  4 Sep 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537220;
	bh=iIktOWWnQ4U17IoVOkVZOdvfItcrK9Ys5e69p2vwG8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgzli07awcxUVsTCC9dBAVKgwDd2Dv4V9zOkWJn+A6BG+CPhV3cgOZw0rf9ERNfC+
	 yG5ggwbFCuLAsyo312Js20GL5/uTvtVUnZSC1B5y7j/abjf4+Q9uiXvuXCJIGbTluA
	 a7xi+rQjZRw+RKqxjnGBC95WvGKaNlcKELXP5tQK9ju7tpHbKib8jU5V6xcVicelX/
	 TBNGd7Tq9mBq8r/58a0Wy2p3FhXCkMhbbFnfmzxAClzJAvzrJmtRe4UvYKkz7FyJxl
	 E1I5YJ673DDfY14mUCIJhUcnuUNPRUDVDhIvrqmNDWot/hftbBSJjUkhNZZQAesnJZ
	 PKYRjThVi7KQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] fs: get rid of the res2 iocb->ki_complete argument
Date: Fri,  4 Sep 2026 11:53:34 -0400
Message-ID: <20260904155336.1042108-4-sashal@kernel.org>
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

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 6b19b766e8f077f29cdb47da5003469a85bbfb9c ]

The second argument was only used by the USB gadget code, yet everyone
pays the overhead of passing a zero to be passed into aio, where it
ends up being part of the aio res2 value.

Now that everybody is passing in zero, kill off the extra argument.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/fops.c                       |  2 +-
 crypto/af_alg.c                    |  2 +-
 drivers/block/loop.c               |  4 ++--
 drivers/nvme/target/io-cmd-file.c  |  4 ++--
 drivers/target/target_core_file.c  |  4 ++--
 drivers/usb/gadget/function/f_fs.c |  2 +-
 drivers/usb/gadget/legacy/inode.c  |  5 ++---
 fs/aio.c                           |  6 +++---
 fs/cachefiles/io.c                 | 12 ++++++------
 fs/ceph/file.c                     |  2 +-
 fs/cifs/file.c                     |  4 ++--
 fs/direct-io.c                     |  2 +-
 fs/fuse/file.c                     |  2 +-
 fs/iomap/direct-io.c               |  2 +-
 fs/nfs/direct.c                    |  2 +-
 fs/overlayfs/file.c                |  4 ++--
 include/linux/fs.h                 |  2 +-
 io_uring/io_uring.c                |  6 +++---
 18 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9359368ca7cf4..45f57060c9296 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -173,7 +173,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 				ret = blk_status_to_errno(dio->bio.bi_status);
 			}
 
-			dio->iocb->ki_complete(iocb, ret, 0);
+			dio->iocb->ki_complete(iocb, ret);
 			if (dio->flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 8dfb94aa99285..cbc6e3f8db8ff 100644
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
index 45684136e8376..3fad77cd16bb5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -542,7 +542,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
@@ -615,7 +615,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	lo_rw_aio_do_completion(cmd);
 
 	if (ret != -EIOCBQUEUED)
-		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index f576a959e36c9..682d64b95d3a5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -107,7 +107,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
@@ -204,7 +204,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 complete:
-	nvmet_file_io_done(&req->f.iocb, ret, 0);
+	nvmet_file_io_done(&req->f.iocb, ret);
 	return true;
 }
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index e11d9897a5e43..c94d83e089f09 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -244,7 +244,7 @@ struct target_core_file_cmd {
 	struct bio_vec	bvecs[];
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
 {
 	struct target_core_file_cmd *cmd;
 
@@ -302,7 +302,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
 
 	if (ret != -EIOCBQUEUED)
-		cmd_rw_aio_complete(&aio_cmd->iocb, ret, 0);
+		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index bb1fe2f37289e..0588be1109022 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -841,7 +841,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, 0);
+	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index e6ffbc82d48c4..33b427c1b9cb8 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -473,7 +473,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret, 0);
+	iocb->ki_complete(iocb, ret);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -501,8 +501,7 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		kfree(priv);
 		iocb->private = NULL;
 		iocb->ki_complete(iocb,
-				req->actual ? req->actual : (long)req->status,
-				0);
+				req->actual ? req->actual : (long)req->status);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
diff --git a/fs/aio.c b/fs/aio.c
index f502a7c841909..cdb1030f4abc0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1433,7 +1433,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void aio_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
@@ -1453,7 +1453,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	}
 
 	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
+	iocb->ki_res.res2 = 0;
 	iocb_put(iocb);
 }
 
@@ -1524,7 +1524,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		req->ki_complete(req, ret, 0);
+		req->ki_complete(req, ret);
 	}
 }
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index fac2e8e7b533e..effe37ef86291 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -37,11 +37,11 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 /*
  * Handle completion of a read from the cache.
  */
-static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_read_complete(struct kiocb *iocb, long ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%ld", ret);
 
 	if (ki->term_func) {
 		if (ret >= 0)
@@ -139,7 +139,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_read_complete(&ki->iocb, ret, 0);
+		cachefiles_read_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
@@ -159,12 +159,12 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 /*
  * Handle completion of a write to the cache.
  */
-static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
-	_enter("%ld,%ld", ret, ret2);
+	_enter("%ld", ret);
 
 	/* Tell lockdep we inherited freeze protection from submission thread */
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
@@ -244,7 +244,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 		fallthrough;
 	default:
 		ki->was_async = false;
-		cachefiles_write_complete(&ki->iocb, ret, 0);
+		cachefiles_write_complete(&ki->iocb, ret);
 		if (ret > 0)
 			ret = 0;
 		break;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7ecb51384497b..cc8044d0471d4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1061,7 +1061,7 @@ static void ceph_aio_complete(struct inode *inode,
 	ceph_put_cap_refs(ci, (aio_req->write ? CEPH_CAP_FILE_WR :
 						CEPH_CAP_FILE_RD));
 
-	aio_req->iocb->ki_complete(aio_req->iocb, ret, 0);
+	aio_req->iocb->ki_complete(aio_req->iocb, ret);
 
 	ceph_free_cap_flush(aio_req->prealloc_cf);
 	kfree(aio_req);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71f585a41d456..11f0c4ee690ae 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3210,7 +3210,7 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
@@ -3951,7 +3951,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 	mutex_unlock(&ctx->aio_mutex);
 
 	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc, 0);
+		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
 	else
 		complete(&ctx->done);
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a1..072c4b5eeef9c 100644
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
index db9211464f1e0..ad3ab7c86b0e2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -725,7 +725,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			spin_unlock(&fi->lock);
 		}
 
-		io->iocb->ki_complete(io->iocb, res, 0);
+		io->iocb->ki_complete(io->iocb, res);
 	}
 
 	kref_put(&io->refcnt, fuse_io_release);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f5b36732b89b3..71f50ae0996df 100644
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
index 3185899676adf..cb08d8d57945c 100644
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
index 49d3feded593f..a99a73afa4862 100644
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
index 41b3ebe4e8e71..326598e3cba87 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -336,7 +336,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8747c585a0770..1cacfe63d7544 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2801,7 +2801,7 @@ static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 	io_req_task_complete(req, locked);
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -2812,7 +2812,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_req_task_work_add(req);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
@@ -3037,7 +3037,7 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 		ret = -EINTR;
 		fallthrough;
 	default:
-		kiocb->ki_complete(kiocb, ret, 0);
+		kiocb->ki_complete(kiocb, ret);
 	}
 }
 
-- 
2.53.0


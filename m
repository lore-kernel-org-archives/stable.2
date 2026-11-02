Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650489;
	b=J2YLq5ADNb4sxtfSnL4zABREoKVEsv1YYR+kQtU1ZxylFdMO0L8eY2ZXYdah+RJZHlXx
	 pspiKrLubSS7k3OO/vHueuZplP58F0Yg54p2tYgTabD+t5+S0zysP/UIwTycNBzBDE/Bz
	 a09mWgsVI8fSNskWxMBGFR8uQOioe5gn4IbFJCfre8SiOsuBjhrnDpKkxqKORay+A6jlB
	 zvZNV7hq3L6JhRPFcb5Ced2nL8jPNFKgC/TnZRxvfsvb/uXz8crZPlqo6OmwO/VpZyBKE
	 txhTfqubnA+eUi6K65GGVewHP9GuzHjXgWRihehh8dxOaZNisualojB3zffISxpAw5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ChwoMCFgtIR2KqbxLT1VLdvZN3wU1IvS74bgkVZalnw=;
	b=3/Bj9smS02t/8KaxuMEEr6ycgW5Efq2EfsuTzbzjqs+8XvXPM1LLc1Z1XT87RTiWNy9n
	 irU+DePbyM1Rw5vHOwxre65nfTi6yWtBuVvxlrKkb1aB4wqySgEL87jtqpIfSDR7EiBZi
	 3WLUeLpK91YlggiUlOlRfKO6wRU/3Oc2I9I4Hh5zMLgLFIF3qwH6ScOU2Tn0vL2hnDgKB
	 JewRTb0NRVOjrM/88CFq1KKn3AHQdk7KLCSWjD4y/1fsCEcSIhim0uVt+x/iAUsKDwHRL
	 Aa2DjpooMUtp/aXZN+4F5wbd0l69EG78Kue/sNFGsUu0d/AsLBccoaBHA6LS1EMDLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdVavhV1;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA80606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA80606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdVavhV1
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso21850a12.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650488; x=1794255288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ChwoMCFgtIR2KqbxLT1VLdvZN3wU1IvS74bgkVZalnw=;
        b=tdVavhV1RdFgLQZhWKVggX7EMfJQ+eoKkwnDYSDI51I9VO02J6efEOmyM4ae7gZZTW
         +AJqoql5O96fgTMpP3Dg3Rjbzo1dLYMgARTU9LwkX8s55GaPeNo7SlnuwBBAwoDDM5i1
         GnTBEiw0WCsGHJ9Olb+LTF3WfKuZMq4DcxFwP37rTBUD8sxk5OZU+stoudLSU+PhqHpX
         uSAJs7AtS8YdEg6sTC0ATgyTEjKqhVMC7QYv6j8trpJBq7GieXnD41THLWdWk/tBHc9B
         ZG1xXZtGlmsuxjv68L5LDmQ+Ut4Ce9g6giNupWcE2Ex5x1LqMOXdkw4RnvVmkagqatgw
         Opuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650488; x=1794255288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChwoMCFgtIR2KqbxLT1VLdvZN3wU1IvS74bgkVZalnw=;
        b=AxmscY1udeju/Odrd6+9SlvPvRhtJYDpqMw7kc2nOoEEUltV0kHTKQiclg3r0RsgTm
         pswlt4RCJHOhCso8nEBuxuqyML+Tn0Y/cZU6ZjvcnddShCryfP7MynW8bvTcBAqvJrDt
         LkW0XpFSU7pHBlYEIE7ZUxvm+wAs6h+NF1cfPe3cTuhAP8mwEx0Za7Yn/tabLHKXXaqX
         1cMwcaNgPFJ2HdQCEM0/e4Ef0mHIbiD7NQPR+BgOBzkrxVZlWXn8d7Hfo/ff93C3bTON
         UbpWTNcPRzaLsNp1vfY/ODsQ8OYS/vQRZjQrDHaJeyJmSpLHJqV+Ai8/jyo6bW1E2HFs
         ENqg==
X-Gm-Message-State: AFq9FYIwkTkiOYIR/7g1HjLhtNIgqNsiaYm+lFCdN9/wvde0pw4830Pb
	GDmo6Lrlq2zLrdW5CqPh4l+YuxWyT6Ypkb/UEQdiKgsQnHWfyf8pTQEewidC3Q==
X-Gm-Gg: AYBFou1yezR/QOo2aPXxXmvpkoOGrRZptbS0eFWkmqUceWJ3VXSvwIb3mqhdmnZw7qZ
	ld6t7xKQN9FA7TOc05bJcaZpHUHArGBdteQijBnHj508XXpzPMPT51PIwcgb27hoLwHplFuNtKa
	tIYRVfHP21yjYe0pTGxxtLu4dOpppOi6Gf/r64z+UK3fbzfn2jvdbkds28gFItGRYRU0rY1qxKI
	pjjyiV/kToHXHNf79DsITTsMohJKXFqvu3T1U4pu77wBoyg9hzPtWpexOaDwupskOQP6fG7uL1f
	c3wBSbdNqQb6A86iFQXtKVaMtHLUZdPr7VvJdltFcbdMTV1f1iqTwVkMAI0egkw1ByLQSiIAKRH
	Y8Dv/rp8KGBxDbbxUpwzpkIjaeBVB/1EX19SAqQrlkowRTqfkEEoqDADZvL9S2lHlqNJ3JghKty
	SKPCgoQms7cdT6A5YGbDBR0nhc2X3hkdY3qN97LL8bukoWbZXfVOuJhpxuDw4UFwmPbzZSZK66D
	eeL3IFdm3jTtjIOO5I4wgp8skxz1CN2meeToFN1S3feur/kh83C0ClVt6VC0Z/w8IyZgqaHI7CG
	eZMkkwDUPMtYjate+fBs88eQT0Rk7ijNCkmZgQGQmO25KKAnWisPtdMHLDQFyMulpFzmtEwhj4O
	wKVl+nXS+h8oVn3FNum4p1qtFrwXl4p6+TEtg+2+GF9lgJf/MgBZbN7P1I9mxK0LAR7liSpr/Wf
	rhncmkaqJDVM+uBH1cndBJ5ELgEeuUMA/RnAx7UvWc
X-Received: by 2002:a05:6a21:496:b0:3e1:42ac:2ee3 with SMTP id adf61e73a8af0-3e92894b72amr6738143637.22.1793650488120;
        Mon, 02 Nov 2026 12:14:48 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9c09086sm2330530b3a.23.2026.11.02.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:14:47 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	sfrench@samba.org,
	stfrench@microsoft.com,
	wozizhi@huawei.com,
	pc@manguebit.com,
	lsahlber@redhat.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	glaming@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH 6.6.y] smb: client: fix busy dentry warning on unmount after DIO
Date: Mon,  2 Nov 2026 20:14:10 +0000
Message-ID: <20261102201410.55089-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

commit 75f5c412fa867efa0bf9b646bffe0d912109e84a upstream.

In mainline, commit 75f5c412fa86 ("smb: client: fix busy dentry warning
on unmount after DIO") fixes a busy-dentry warning during unmount by
tracking in-flight netfs_io_request instances in cifs_init_request() and
cifs_free_request(), waiting for the counter to reach zero in
cifs_kill_sb() before kill_anon_super(), and then flushing
serverclose_wq and fileinfo_put_wq. Because mainline routes all CIFS I/O
(direct I/O, uncached I/O, buffered readahead, and buffered writeback)
through netfs_io_request, that single counter covers every path that
holds a cifsFileInfo reference across asynchronous I/O completion.

Kernel 6.6 predates the netfs I/O request conversion and instead splits
I/O across three reference-counted structures that each hold a
cifsFileInfo reference:
- struct cifs_aio_ctx, used by direct and uncached I/O (__cifs_readv()
  and __cifs_writev()).
- struct cifs_readdata, allocated for uncached reads
  (cifs_send_async_read()) and directly without a cifs_aio_ctx for
  buffered readahead (cifs_readahead()).
- struct cifs_writedata, allocated for uncached writes
  (cifs_write_from_iter(), cifs_writev_requeue()) and directly without a
  cifs_aio_ctx for buffered writeback
  (cifs_write_back_from_locked_folio()).

In both the DIO/uncached paths (where collect_uncached_read_data() and
collect_uncached_write_data() signal completion via complete(&ctx->done)
or ctx->iocb->ki_complete() before the worker drops its rdata/wdata and
ctx references) and the buffered paths (where cifs_readahead_complete()
unlocks folios and cifs_writev_complete() ends folio writeback before
calling kref_put() on rdata/wdata to drop their cfile reference), a
racing close() and umount() can reach shrink_dcache_for_umount() before
the final cifsFileInfo_put() has been queued and flushed. This triggers:

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]

followed by a use-after-free when deferred cifsFileInfo_put_work runs
after superblock teardown.

Fix this in 6.6 by:
1. Adding cifs_sb->outstanding_aio and incrementing it whenever
   ctx->cfile, rdata->cfile, or wdata->cfile is assigned.
2. Releasing wdata->cfile and rdata->cfile before dropping ctx->refcount
   in cifs_uncached_writedata_release() and cifs_readdata_release().
3. Decrementing cifs_sb->outstanding_aio in cifs_aio_ctx_release(),
   cifs_readdata_release(), and cifs_writedata_release() only after
   cifsFileInfo_put() has been called, and waiting for it to reach zero
   in cifs_kill_sb() before flushing serverclose_wq and fileinfo_put_wq.

Fixes: 340cea84f691 ("cifs: open files should not hold ref on superblock")
Tested-by: Gillian Laming <glaming@microsoft.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 fs/smb/client/cifs_fs_sb.h |  1 +
 fs/smb/client/cifsfs.c     | 11 +++++++++++
 fs/smb/client/connect.c    |  1 +
 fs/smb/client/file.c       | 33 ++++++++++++++++++++++++++++-----
 fs/smb/client/misc.c       |  4 ++++
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifs_fs_sb.h b/fs/smb/client/cifs_fs_sb.h
index 6517591922801..5011dd639dd9b 100644
--- a/fs/smb/client/cifs_fs_sb.h
+++ b/fs/smb/client/cifs_fs_sb.h
@@ -54,6 +54,7 @@ struct cifs_sb_info {
 	struct nls_table *local_nls;
 	struct smb3_fs_context *ctx;
 	atomic_t active;
+	atomic_t outstanding_aio;	/* nr of AIO contexts not yet fully deinitialized */
 	unsigned int mnt_cifs_flags;
 	struct delayed_work prune_tlinks;
 	struct rcu_head rcu;
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a3dfeda8144d9..27fc6c888135f 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -301,6 +301,17 @@ static void cifs_kill_sb(struct super_block *sb)
 		/* Wait for all opened files to release */
 		flush_workqueue(deferredclose_wq);
 
+		/*
+		 * Wait for all in-flight AIO contexts to finish cleanup so
+		 * that their cifsFileInfo final puts have been queued, then
+		 * drain the workqueues so the dentry refs are dropped before
+		 * kill_anon_super().
+		 */
+		wait_var_event(&cifs_sb->outstanding_aio,
+			       !atomic_read(&cifs_sb->outstanding_aio));
+		flush_workqueue(serverclose_wq);
+		flush_workqueue(fileinfo_put_wq);
+
 		/* finally release root dentry */
 		dput(cifs_sb->root);
 		cifs_sb->root = NULL;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 1c21ae3d61e24..3d0fd8bf8f352 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3396,6 +3396,7 @@ int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb)
 
 	spin_lock_init(&cifs_sb->tlink_tree_lock);
 	cifs_sb->tlink_tree = RB_ROOT;
+	atomic_set(&cifs_sb->outstanding_aio, 0);
 
 	cifs_dbg(FYI, "file mode: %04ho  dir mode: %04ho\n",
 		 ctx->file_mode, ctx->dir_mode);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index d329b8a3b756d..0ca0381fd7bb3 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2618,6 +2618,8 @@ cifs_writedata_release(struct kref *refcount)
 {
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
+	struct cifs_sb_info *cifs_sb = NULL;
+
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (wdata->mr) {
 		smbd_deregister_mr(wdata->mr);
@@ -2625,10 +2627,15 @@ cifs_writedata_release(struct kref *refcount)
 	}
 #endif
 
-	if (wdata->cfile)
+	if (wdata->cfile) {
+		cifs_sb = CIFS_SB(wdata->cfile->dentry->d_sb);
 		cifsFileInfo_put(wdata->cfile);
+	}
 
 	kfree(wdata);
+
+	if (cifs_sb && atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 /*
@@ -2690,6 +2697,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 			if (!is_retryable_error(rc))
 				rc = -EBADF;
 		} else {
+			atomic_inc(&CIFS_SB(inode->i_sb)->outstanding_aio);
 			wdata2->pid = wdata2->cfile->pid;
 			rc = server->ops->async_writev(wdata2,
 						       cifs_writedata_release);
@@ -2998,6 +3006,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	wdata->pid = cfile->pid;
 	wdata->credits = credits_on_stack;
 	wdata->cfile = cfile;
+	atomic_inc(&cifs_sb->outstanding_aio);
 	wdata->server = server;
 	cfile = NULL;
 
@@ -3491,9 +3500,10 @@ cifs_uncached_writedata_release(struct kref *refcount)
 {
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
+	struct cifs_aio_ctx *ctx = wdata->ctx;
 
-	kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
 	cifs_writedata_release(refcount);
+	kref_put(&ctx->refcount, cifs_aio_ctx_release);
 }
 
 static void collect_uncached_write_data(struct cifs_aio_ctx *ctx);
@@ -3704,6 +3714,7 @@ cifs_write_from_iter(loff_t fpos, size_t len, struct iov_iter *from,
 		wdata->sync_mode = WB_SYNC_ALL;
 		wdata->offset	= (__u64)fpos;
 		wdata->cfile	= cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		wdata->server	= server;
 		wdata->pid	= pid;
 		wdata->bytes	= cur_len;
@@ -3852,6 +3863,7 @@ static ssize_t __cifs_writev(
 		return -ENOMEM;
 
 	ctx->cfile = cifsFileInfo_get(cfile);
+	atomic_inc(&cifs_sb->outstanding_aio);
 
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
@@ -4067,19 +4079,27 @@ cifs_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
+	struct cifs_aio_ctx *ctx = rdata->ctx;
+	struct cifs_sb_info *cifs_sb = NULL;
 
-	if (rdata->ctx)
-		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
 		rdata->mr = NULL;
 	}
 #endif
-	if (rdata->cfile)
+	if (rdata->cfile) {
+		cifs_sb = CIFS_SB(rdata->cfile->dentry->d_sb);
 		cifsFileInfo_put(rdata->cfile);
+	}
 
 	kfree(rdata);
+
+	if (ctx)
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+
+	if (cifs_sb && atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
@@ -4234,6 +4254,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 
 		rdata->server	= server;
 		rdata->cfile	= cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		rdata->offset	= fpos;
 		rdata->bytes	= cur_len;
 		rdata->pid	= pid;
@@ -4387,6 +4408,7 @@ static ssize_t __cifs_readv(
 	ctx->direct_io	= direct;
 	ctx->len	= len;
 	ctx->cfile	= cifsFileInfo_get(cfile);
+	atomic_inc(&cifs_sb->outstanding_aio);
 	ctx->nr_pinned_pages = 0;
 
 	if (!is_sync_kiocb(iocb))
@@ -4881,6 +4903,7 @@ static void cifs_readahead(struct readahead_control *ractl)
 		rdata->offset	= ra_index * PAGE_SIZE;
 		rdata->bytes	= nr_pages * PAGE_SIZE;
 		rdata->cfile	= cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		rdata->server	= server;
 		rdata->mapping	= ractl->mapping;
 		rdata->pid	= pid;
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 8937095184ca6..48197d47ee821 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1185,6 +1185,7 @@ cifs_aio_ctx_release(struct kref *refcount)
 {
 	struct cifs_aio_ctx *ctx = container_of(refcount,
 					struct cifs_aio_ctx, refcount);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(ctx->cfile->dentry->d_sb);
 
 	cifsFileInfo_put(ctx->cfile);
 
@@ -1211,6 +1212,9 @@ cifs_aio_ctx_release(struct kref *refcount)
 	}
 
 	kfree(ctx);
+
+	if (atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 /**
-- 
2.43.0


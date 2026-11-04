Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813598;
	b=ZVS27VKjqTbsTgvjMTV9nPtmSswvfn1daz/UCMVVPx8I3jIfAniTZJpLEjCsdiVs6Lpo
	 aiV7qLF4k5grrKgsvnjZoCFpkwCO18KmQR8WcUunY8SQVB1vIQg8N+yfe1UiuVwcydjxW
	 e4ddZRj1krHYPFhbUOafOrFGcZpZwPjMS9M4GdTA4R7V7sVneshkrIDly/9Ccy6/Ki9Iq
	 xU2uEoJrJrnYDcKQvcBCSp93e5MGZyfGGJeIQ8ReM6/W3HTJz0ACzOMGMGHWHqCZKaomW
	 V0v15+ZRgODU4ubxqzG/ivoW6oVIrEl3ud5mwZ+d2FuAq5hod928Bb3XP95pEUVj98Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=N7zoqTKyhon1LbjY1PtqitP7DzTzSJ7647d2X3CozDI=;
	b=BObqAIyrpg1DU0Bsbp3dLi0T7ZWlgLi0Z/DQTywPL+etsH222y4DuH7QHbAlZIKkUYP5
	 VLN4oz204X4nIvHJAC+jNpjzQcZwwniEOV6Lx2mi5r8GfAicavm8vYHQW6iy0KxK22g+p
	 ElCbVgB3Jd1QZLeiTrm4VDcUW0vdZqA5B/0iPutniqZ34FHh52TlkOMNx3QFexZ2k2UmF
	 sHbveypp3gZdgZ3mR9kdstDtFWyBTTcvPKo62oc3k5px+SCSVQeDQUK1pp8GDtF9wZtxc
	 Q16HOjY4z5eydBezkQY1njPytfH8axpJ1lhEUmzawz+7lcgJelYnPpU3oFRXqK9Q+Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUxNp4+8;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA63606A917
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA63606A917
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUxNp4+8
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89f639ba307so443701b3a.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813597; x=1794418397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7zoqTKyhon1LbjY1PtqitP7DzTzSJ7647d2X3CozDI=;
        b=KUxNp4+8/wF9RhrSpuHEf0/GYLJxQy0x4bj1j3faKEkalkvLNo4GrSYT/8DL9VLSJl
         NWwHrxDdAjoMps9ahMDFCtzlNU3ZiJD0jpyQX7ggUHDoVe1CRO7XZpDaSCTBO8lJyEpF
         dBe6feCWuxy1NQZTlHduxgkAm+fs01xi5eg4Ob/cEOpd29Eiq2pnrUACgRFwfXAjz0RR
         DKjMhkL5pygMniaPQ6/MbjVeTUdp00QgvQ867DPF1s5T9GnM5WOtmSwdNYb59ewFre96
         j69r1dUq2f2VoIzVUea8floDFR1eQgdjA7s6XeozDUYcArht7qscAqwV5v2NWxRx/nfO
         8N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813597; x=1794418397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7zoqTKyhon1LbjY1PtqitP7DzTzSJ7647d2X3CozDI=;
        b=cflvML+j0cORL+J/b+BTQXx2VaggvtFGRcb1mUxeUupSsfSWbnlAhx3ZegXKg3md0C
         yU0m8K/PRF2NB7zXIzFuuDHCOoS+36eenR+9t7MAX3lq1/GuZWMuY1SiZ/Ej/pO1GLse
         DT7E+azVYLqchkXEPdJ6jlupNjXeYV5lRmP7UbVX1z6t43NW/ZkSs8O5XfC1EwrUo5MY
         aFBfisXtMzWQHgn2/Si5N0UFi8TTtzUKQVjnwpml8eS7CiXDBleIQv8qFhMmu0fgXuhf
         WSTMMBJxK4RYIHim2Qs3omIt2svHJhI7Misvpj512fvY3HAZDZYReIqfgNweoI13Nk4p
         DfKQ==
X-Gm-Message-State: APuU4Z9SpKNIypxJ/zW70BhTUmpIv/52iJq/PnA2ukytF17tVpaae+K3
	lkXiYPkEo5OMyAFy3KRvJ51lhjE1ERSUF8oqnqYbjuAZVyeWLarrDPMlr0j+7w==
X-Gm-Gg: AYBFou188puDNcazeuh+uS/QwHq/FC2qNp480dp6r4Y3jGNo9OrF+D2nSeF5FRwVY0h
	W47W2F2CzZrSxXmkDugL+fAaFUFOxWs9R7QKWvl2riql7Cb1fP8XtN7DvjBn8lkHP943zaOZfiS
	kwfadhawY48tBwO1bPiaxF5O6Tj8J0+bLhh1inXQ7SfUrwWm/w9vrAqXYc7k2Cz4k+Fsw8VLyHx
	5dNAJ0rh4H8IN/5SnmIk1QIasBxtgzVWgx3XROYsopnpJ/4/9d+naOxJMgChCAw1xP/YnDVzxMH
	4CShHPt8g7m5/giCDA03e9EjCoFsmnvYyZJC38wPCDFuPAdbYIEyWvROBuLuSF0F7KiXIAm2Vpp
	084elnssjmk6NbRX67JGGGAlFVG5R6vQfnLkKn3SrY75pQySonQg4mogxSXa5TxkMhHGjImjZnz
	HH/Mo0845zUCzkckucp8LtIYqdtuIpCyhv+6cEbUiNu0l37t7NwNbM987FffZmjqa1gjEYnSNO8
	JYJpf7ijVSM/WzrNZ8Q2qU4kEhyXvLum8P+E6Zkp/F9DHHNC1Ig2rtBSr4eOcYmW02nYiku3sqd
	U8P1KPICAnHkIFAQdKrLnWrW+Lom9qD2F1QcV9cFh7VKuloUXcZClrHsf1X5U4CGk7Iee4z2Vxh
	QehYqwK++Az0kQ1y9DQGqvGBudSurZqkDqZQjsQRFdCgjh3brCyLLBicsVnB5Zs9I+/WrPBcPSq
	KfvaXRKJMHtAzXiWGLGL0TQyp/zVNPqlgPlVBSiv5J
X-Received: by 2002:a05:6a00:3a21:b0:881:7ff5:606f with SMTP id d2e1a72fcca58-8a9bf71bbb0mr14226623b3a.43.1793813596414;
        Wed, 04 Nov 2026 09:33:16 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce084sm1163984b3a.19.2026.11.04.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:33:16 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: stable@vger.kernel.org
Cc: pc@manguebit.org,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	wozizhi@huawei.com,
	lsahlber@redhat.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	glaming@microsoft.com,
	linux-cifs@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH 6.1.y] smb: client: fix busy dentry warning on unmount after DIO
Date: Wed,  4 Nov 2026 17:33:09 +0000
Message-ID: <20261104173309.19150-1-sidchintamaneni@gmail.com>
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

We recently backported commit 75f5c412fa86 ("smb: client: fix busy
dentry warning on unmount after DIO") to the 6.6 stable kernel [1], and
the same issue exists in the 6.1 stable kernel.

In mainline, commit 75f5c412fa86 fixes a busy-dentry warning during
unmount by tracking in-flight netfs_io_request instances in
cifs_init_request() and cifs_free_request(), waiting for the counter to
reach zero in cifs_kill_sb() before kill_anon_super(), and then flushing
serverclose_wq and fileinfo_put_wq. Because mainline routes all CIFS I/O
(direct I/O, uncached I/O, buffered readahead, and buffered writeback)
through netfs_io_request, that single counter covers every path that
holds a cifsFileInfo reference across asynchronous I/O completion.

Like 6.6, kernel 6.1 predates the netfs I/O request conversion and
splits I/O across three reference-counted structures that each hold a
cifsFileInfo reference:
- struct cifs_aio_ctx, used by direct and uncached I/O (__cifs_readv()
  and __cifs_writev()).
- struct cifs_readdata, allocated for uncached reads
  (cifs_send_async_read()) and directly without a cifs_aio_ctx for
  buffered readahead (cifs_readahead()).
- struct cifs_writedata, allocated for uncached writes
  (cifs_write_from_iter(), cifs_writev_requeue()) and directly without a
  cifs_aio_ctx for buffered writeback (cifs_writepages()).

In both the DIO/uncached paths (where collect_uncached_read_data() and
collect_uncached_write_data() signal completion via complete(&ctx->done)
or ctx->iocb->ki_complete() before the worker drops its rdata/wdata and
ctx references) and the buffered paths (where cifs_readv_complete()
unlocks pages and cifs_writev_complete() ends page writeback before
calling kref_put() on rdata/wdata to drop their cfile reference), a
racing close() and umount() can reach shrink_dcache_for_umount() before
the final cifsFileInfo_put() has been queued and flushed. This triggers:

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]

followed by a use-after-free when deferred cifsFileInfo_put_work runs
after superblock teardown.

Fix this in 6.1 using the same approach as the 6.6 backport, adapted for
6.1's page-based writeback (cifs_writepages()) and separate
cifs_uncached_readdata_release() callback:
1. Add cifs_sb->outstanding_aio and increment it whenever ctx->cfile,
   rdata->cfile, or wdata->cfile is assigned.
2. Release wdata->cfile and rdata->cfile before dropping ctx->refcount
   in cifs_uncached_writedata_release() and
   cifs_uncached_readdata_release().
3. Decrement cifs_sb->outstanding_aio in cifs_aio_ctx_release(),
   cifs_readdata_release(), and cifs_writedata_release() only after
   cifsFileInfo_put() has been called, and wait for it to reach zero in
   cifs_kill_sb() before flushing serverclose_wq and fileinfo_put_wq.

Link: https://lore.kernel.org/all/20261102201410.55089-1-sidchintamaneni@gmail.com/ [1]
Fixes: 340cea84f691 ("cifs: open files should not hold ref on superblock")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 fs/smb/client/cifs_fs_sb.h |  1 +
 fs/smb/client/cifsfs.c     | 11 +++++++++++
 fs/smb/client/connect.c    |  1 +
 fs/smb/client/file.c       | 34 +++++++++++++++++++++++++++++-----
 fs/smb/client/misc.c       |  4 ++++
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifs_fs_sb.h b/fs/smb/client/cifs_fs_sb.h
index 013a4bd65280c..5c6498329b05e 100644
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
index c2a9d7004ff59..b08eb605a7b54 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -299,6 +299,17 @@ static void cifs_kill_sb(struct super_block *sb)
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
index a8f16cd8dca69..30e75d31b0ee7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3274,6 +3274,7 @@ int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb)
 
 	spin_lock_init(&cifs_sb->tlink_tree_lock);
 	cifs_sb->tlink_tree = RB_ROOT;
+	atomic_set(&cifs_sb->outstanding_aio, 0);
 
 	cifs_dbg(FYI, "file mode: %04ho  dir mode: %04ho\n",
 		 ctx->file_mode, ctx->dir_mode);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index caa55b5bc110c..84227c8393c59 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2379,6 +2379,8 @@ cifs_writedata_release(struct kref *refcount)
 {
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
+	struct cifs_sb_info *cifs_sb = NULL;
+
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (wdata->mr) {
 		smbd_deregister_mr(wdata->mr);
@@ -2386,11 +2388,16 @@ cifs_writedata_release(struct kref *refcount)
 	}
 #endif
 
-	if (wdata->cfile)
+	if (wdata->cfile) {
+		cifs_sb = CIFS_SB(wdata->cfile->dentry->d_sb);
 		cifsFileInfo_put(wdata->cfile);
+	}
 
 	kvfree(wdata->pages);
 	kfree(wdata);
+
+	if (cifs_sb && atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 /*
@@ -2454,6 +2461,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 			if (!is_retryable_error(rc))
 				rc = -EBADF;
 		} else {
+			atomic_inc(&CIFS_SB(inode->i_sb)->outstanding_aio);
 			wdata2->pid = wdata2->cfile->pid;
 			rc = server->ops->async_writev(wdata2,
 						       cifs_writedata_release);
@@ -2837,8 +2845,10 @@ static int cifs_writepages(struct address_space *mapping,
 				rc = get_file_rc;
 			else
 				rc = -EBADF;
-		} else
+		} else {
+			atomic_inc(&cifs_sb->outstanding_aio);
 			rc = wdata_send_pages(wdata, nr_pages, mapping, wbc);
+		}
 
 		for (i = 0; i < nr_pages; ++i)
 			unlock_page(wdata->pages[i]);
@@ -3185,11 +3195,12 @@ cifs_uncached_writedata_release(struct kref *refcount)
 	int i;
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
+	struct cifs_aio_ctx *ctx = wdata->ctx;
 
-	kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
 	for (i = 0; i < wdata->nr_pages; i++)
 		put_page(wdata->pages[i]);
 	cifs_writedata_release(refcount);
+	kref_put(&ctx->refcount, cifs_aio_ctx_release);
 }
 
 static void collect_uncached_write_data(struct cifs_aio_ctx *ctx);
@@ -3455,6 +3466,7 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		wdata->nr_pages = nr_pages;
 		wdata->offset = (__u64)offset;
 		wdata->cfile = cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		wdata->server = server;
 		wdata->pid = pid;
 		wdata->bytes = cur_len;
@@ -3615,6 +3627,7 @@ static ssize_t __cifs_writev(
 		return -ENOMEM;
 
 	ctx->cfile = cifsFileInfo_get(cfile);
+	atomic_inc(&cifs_sb->outstanding_aio);
 
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
@@ -3817,17 +3830,24 @@ cifs_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
+	struct cifs_sb_info *cifs_sb = NULL;
+
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
 
 	kvfree(rdata->pages);
 	kfree(rdata);
+
+	if (cifs_sb && atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 static int
@@ -3862,13 +3882,14 @@ cifs_uncached_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
+	struct cifs_aio_ctx *ctx = rdata->ctx;
 	unsigned int i;
 
-	kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 	for (i = 0; i < rdata->nr_pages; i++) {
 		put_page(rdata->pages[i]);
 	}
 	cifs_readdata_release(refcount);
+	kref_put(&ctx->refcount, cifs_aio_ctx_release);
 }
 
 /**
@@ -4172,6 +4193,7 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 
 		rdata->server = server;
 		rdata->cfile = cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		rdata->nr_pages = npages;
 		rdata->offset = offset;
 		rdata->bytes = cur_len;
@@ -4357,6 +4379,7 @@ static ssize_t __cifs_readv(
 		return -ENOMEM;
 
 	ctx->cfile = cifsFileInfo_get(cfile);
+	atomic_inc(&cifs_sb->outstanding_aio);
 
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
@@ -4895,6 +4918,7 @@ static void cifs_readahead(struct readahead_control *ractl)
 		rdata->nr_pages = nr_pages;
 		rdata->bytes	= readahead_batch_length(ractl);
 		rdata->cfile	= cifsFileInfo_get(open_file);
+		atomic_inc(&cifs_sb->outstanding_aio);
 		rdata->server	= server;
 		rdata->mapping	= ractl->mapping;
 		rdata->offset	= readahead_pos(ractl);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 049a14677c910..203baf11625b9 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1040,6 +1040,7 @@ cifs_aio_ctx_release(struct kref *refcount)
 {
 	struct cifs_aio_ctx *ctx = container_of(refcount,
 					struct cifs_aio_ctx, refcount);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(ctx->cfile->dentry->d_sb);
 
 	cifsFileInfo_put(ctx->cfile);
 
@@ -1060,6 +1061,9 @@ cifs_aio_ctx_release(struct kref *refcount)
 	}
 
 	kfree(ctx);
+
+	if (atomic_dec_and_test(&cifs_sb->outstanding_aio))
+		wake_up_var(&cifs_sb->outstanding_aio);
 }
 
 #define CIFS_AIO_KMALLOC_LIMIT (1024 * 1024)
-- 
2.43.0


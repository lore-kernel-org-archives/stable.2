Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA5572698
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097216; cv=none; b=ewESUIZrBR+nRCgb7tRJ4akveznXNqpDsNmXfRYqsYWJ5NPVjt+EhjuS/H97ZMxaaarmfU0kRZCnKbQLFXULkv1mFRwoSYn/Top7mUcI1z0FzsRwZBcjiVeMT64xXtjSh0JUODtu7vQZg99j1iQxc0bvdbtuO+F+69QKhSNNbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097216; c=relaxed/simple;
	bh=tqhfzQ9BgU1Taj3i8slQml8FBi6dVWogDsAHVpigyL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+WE7mw8m8GmPqk8LywneI3VhCIbLd57nk0BYPmzfbteAXgprU+UIKak0ejtuRjmU/HXxD1HFCX29zIlHk8VHwKFNrdM7pGPxzIuppHY+zJhXH1jxq/UOYDJgMxI6nqL3dzoVCWyoOgdaJZuMg1bBUf+NXYGm3sHhoPetFNSJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d5kKbgXy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d5kKbgXy"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 89A1D20B7167; Tue, 22 Sep 2026 10:12:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89A1D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790097166;
	bh=Vt0lJuS3WxrT9sOhoLZRBXmmnxEpb7iE3My88UjnR6A=;
	h=From:To:Cc:Subject:Date:From;
	b=d5kKbgXyanU2RugBJ7Y8K5DYFeri1eqpGCk0HOq7/Eot7VoLAymhIIg4ZC9R6gH1r
	 Tu4ctD5+ILjfkn0ZicT0tLd/u+TPK7Tpynb2kMb05kzowmtT2bwzH1XVn0CQTuYs7M
	 xzKYID8d7A3QlJsLjw1nN0DoykwRyyR2VyqtFnZc=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Zizhi Wo <wozizhi@huawei.com>,
	Steve French <stfrench@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.18.y] smb: client: fix busy dentry warning on unmount after DIO
Date: Tue, 22 Sep 2026 13:12:13 -0400
Message-ID: <20260922171213.3845560-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zizhi Wo <wozizhi@huawei.com>

[ Upstream commit 75f5c412fa867efa0bf9b646bffe0d912109e84a ]

Commit c68337442f03 ("cifs: Fix busy dentry used after unmounting") fixed
the issue in cifs where deferred close of a file led to a dentry reference
count not being released in umount, by flushing deferredclose_wq in
cifs_kill_sb() to solve it.

However, the cifs DIO path suffers from the same busy-dentry problem caused
by a delayed dentry reference-count release:

	[dio]			[cifsd]			[close + umount]
netfs_unbuffered_write_iter_locked
...
				cifs_demultiplex_thread
 netfs_unbuffered_write
  cifs_issue_write
  netfs_wait_for_in_progress_stream [1]
				...
				 netfs_write_subrequest_terminated
				  netfs_subreq_clear_in_progress
				   netfs_wake_collector // wake [1]
				  netfs_put_subrequest
 netfs_put_request
  queue_work(system_dfl_wq, xxx) [2]
 // dio write return					cifs_close
							 _cifsFileInfo_put
							  // cfile->count 2->1
							  --cfile->count [3]

							// umount
							cifs_kill_sb
							 kill_anon_super
							  // warning triggered!
							  shrink_dcache_for_umount [4]
[system_dfl_wq] [5]
netfs_free_request
 ...
 _cifsFileInfo_put
  // cfile->count 1->0
  --cfile->count
  queue_work(fileinfo_put_wq, xxx)

[fileinfo_put_wq] [6]
cifsFileInfo_put_work
 cifsFileInfo_put_final
  dput

If the umount path is triggered before [5], it results warning:
BUG: Dentry 00000000eab1f070{i=9a917b66ae404fec,n=test}  still in use (1)
[unmount of cifs cifs]

The existing per-inode ictx->io_count wait in cifs_evict_inode() does not
help: it lives in the inode eviction path, which runs after
shrink_dcache_for_umount() has already warned about the busy dentries.

Fix it by adding a per-superblock outstanding-rreq counter that is
incremented in cifs_init_request() and decremented in cifs_free_request().
In cifs_kill_sb(), before kill_anon_super(), wait for this counter to reach
0 - which guarantees that all cleanup_work for this sb have run and thus
all relevant cfile puts are queued on fileinfo_put_wq or serverclose_wq.
Then drain the workqueue so the dentry refs are dropped.

This is a targeted wait, not a flush of the system-wide system_dfl_wq.

Fixes: 340cea84f691c ("cifs: open files should not hold ref on superblock")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 fs/smb/client/cifs_fs_sb.h |  1 +
 fs/smb/client/cifsfs.c     | 12 ++++++++++++
 fs/smb/client/connect.c    |  1 +
 fs/smb/client/file.c       |  5 +++++
 4 files changed, 19 insertions(+)

diff --git a/fs/smb/client/cifs_fs_sb.h b/fs/smb/client/cifs_fs_sb.h
index fc75999ffdc4..87191ec7ddf5 100644
--- a/fs/smb/client/cifs_fs_sb.h
+++ b/fs/smb/client/cifs_fs_sb.h
@@ -57,6 +57,7 @@ struct cifs_sb_info {
 	struct smb3_fs_context *ctx;
 	atomic_t active;
 	atomic_t mnt_cifs_flags;
+	atomic_t outstanding_rreq;	/* nr of rreqs not yet fully deinitialized */
 	struct delayed_work prune_tlinks;
 	struct rcu_head rcu;
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 7bd950b28deb..6d35f3872266 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -342,6 +342,18 @@ static void cifs_kill_sb(struct super_block *sb)
 		/* Wait for all opened files to release */
 		flush_workqueue(deferredclose_wq);
 
+		/*
+		 * Wait for all in-flight netfs I/O requests to finish their
+		 * cleanup_work so that any cifsFileInfo final puts they queue
+		 * to fileinfo_put_wq/serverclose_wq have been queued, then
+		 * drain the workqueue so the cfile dentry refs are dropped to
+		 * avoid the busy dentry warning.
+		 */
+		wait_var_event(&cifs_sb->outstanding_rreq,
+			       !atomic_read(&cifs_sb->outstanding_rreq));
+		flush_workqueue(serverclose_wq);
+		flush_workqueue(fileinfo_put_wq);
+
 		/* finally release root dentry */
 		dput(cifs_sb->root);
 		cifs_sb->root = NULL;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index ae4d3f740065..9c94a11fc896 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3588,6 +3588,7 @@ int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb)
 
 	spin_lock_init(&cifs_sb->tlink_tree_lock);
 	cifs_sb->tlink_tree = RB_ROOT;
+	atomic_set(&cifs_sb->outstanding_rreq, 0);
 
 	cifs_dbg(FYI, "file mode: %04ho  dir mode: %04ho\n",
 		 ctx->file_mode, ctx->dir_mode);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 235e365f6093..301e159e2c34 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -289,6 +289,7 @@ static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
 		return -EIO;
 	}
 
+	atomic_inc(&cifs_sb->outstanding_rreq);
 	return 0;
 }
 
@@ -310,9 +311,13 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
 static void cifs_free_request(struct netfs_io_request *rreq)
 {
 	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 
 	if (req->cfile)
 		cifsFileInfo_put(req->cfile);
+
+	if (atomic_dec_and_test(&cifs_sb->outstanding_rreq))
+		wake_up_var(&cifs_sb->outstanding_rreq);
 }
 
 static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
-- 
2.55.0


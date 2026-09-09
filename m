Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848D531AE2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951264; cv=none; b=up15bE5n2tTCAk3ePvvlw5o7te40V5BKMShEWF011omNOO+RXRG5fcYvP9UcSKU8sRkuUpKeKhZRnEif4at1zz3fORzT1YmD9bo1z+Oao4qdAq3Zmc8NfKBHzKD8uGd6iLb14GmSUvY7WHJwUWtAV2/ka6xeRZJDB4z6ZsbaY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951264; c=relaxed/simple;
	bh=gQAMEyIQfKWpyRIW5lVuSz8SRRnlRyWkDoyZiMWqpuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/yLrdUKzR/Lk6JuuNnO7JwDogvKc2NrP0H/aq2GcOX0u6tnLL3xZfGpOnZyp0iwTG3SLIYmyhgl/jBh0aPuE3a8DutzkAFjYDS3T+mlkPKN5/W5sO2MuXOAF/xjYj2WdQrVN4glL9W3dzg9g7E2IqijosxCi6Cr9sJzRrCu2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUisZL3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUisZL3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABBE1F00A3A;
	Wed,  9 Sep 2026 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951260;
	bh=Y7oFTZI5IEAMR0h/iCD/Mf/vAso4/c5NUtjI1MnOaBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUisZL3CWQRb4UQinFPu1ifBY05/Of8dUAo4rgEQeBznNPR8Emirg4KU8dXNI1poQ
	 tJ9gWXmJYLsq9teegcGy2OmwwgfooP0nbL5XdQroiA6Tfc0LuRRj9TLU38g47gDiR5
	 XYVyf21kyXisKKuDOf0K66YcUAn79bSd5ZmXUorbpZmTrygqGlSS9p49/xEr286cDf
	 hYqWpI9bdT/aipUv+rTNm6MomUIOThHuhbov92/i0Em/GKfUqB4A2E/lHiqY9iEwTM
	 iqpsd7Hpx9gHIfflUyNxyKyOiriz4Hnzz2zIxNn13Pxz9mj5q3a3aU90MDrjPVQ7C9
	 WxnC1fD5N5jaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] filelock: split common fields into struct file_lock_core
Date: Wed,  9 Sep 2026 06:54:17 -0400
Message-ID: <20260909105418.1620378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-anatomy-sublevel-d97c@gregkh>
References: <2026090350-anatomy-sublevel-d97c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit a69ce85ec9af6bdc0b3511959a7dc1a324e5e16a ]

In a future patch, we're going to split file leases into their own
structure. Since a lot of the underlying machinery uses the same fields
move those into a new file_lock_core, and embed that inside struct
file_lock.

For now, add some macros to ensure that we can continue to build while
the conversion is in progress.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20240131-flsplit-v3-17-c6129007ee8d@kernel.org
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>

Backport notes for 6.6:
- Retain the stable tree's unsigned PID type in flc_pid.
- Omit the helper conversions whose functions and iterator are absent here;
  do not introduce new functions.
- Drop unrelated whitespace cleanups, including the obsolete CIFS writeback
  hunk, and preserve the stable CIFS implementation.
- Rename conflicting local variables, parameters and filelock trace-entry
  fields so the compatibility macros do not expand inside declarations.
  Keep the trace output labels and the existing variable types.
- Convert the owner argument in nlmclnt_locks_init_private() to c.flc_owner
  and match the upstream wrapping so 4c7fc129db061 applies unchanged.

[ sashal: Reduced backport -- upstream a69ce85ec9af6 touches 24 file(s), this
  backport carries 27. Not backported here:
  fs/open.c
  fs/posix_acl.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4c7fc129db06 ("lockd: fix NULL dereference on lockowner allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_file.c                |  7 ++--
 fs/afs/flock.c                  |  6 +--
 fs/afs/internal.h               |  1 +
 fs/ceph/locks.c                 |  1 +
 fs/dlm/plock.c                  |  5 ++-
 fs/fuse/file.c                  |  1 +
 fs/gfs2/file.c                  |  1 +
 fs/lockd/clntproc.c             | 24 ++++++------
 fs/locks.c                      |  9 +++--
 fs/nfs/file.c                   |  1 +
 fs/nfs/nfs4_fs.h                |  1 +
 fs/nfs/nfs4proc.c               | 10 ++---
 fs/nfs/nfs4state.c              | 14 +++----
 fs/nfs/write.c                  |  1 +
 fs/nfsd/netns.h                 |  1 +
 fs/nfsd/nfs4state.c             | 24 ++++++------
 fs/ocfs2/locks.c                |  1 +
 fs/ocfs2/stack_user.c           |  1 +
 fs/smb/client/cifsglob.h        |  1 +
 fs/smb/client/cifssmb.c         |  1 +
 fs/smb/client/file.c            |  1 +
 fs/smb/client/smb2file.c        |  1 +
 fs/smb/server/smb2pdu.c         |  1 +
 fs/smb/server/vfs.c             |  1 +
 include/linux/filelock.h        | 47 ++++++++++++++++-------
 include/linux/lockd/xdr.h       |  1 +
 include/trace/events/filelock.h | 66 ++++++++++++++++-----------------
 27 files changed, 136 insertions(+), 93 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 655e7bf602f1e..2cedba2d3187b 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/sched.h>
 #include <linux/file.h>
@@ -126,7 +127,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	struct p9_fid *fid;
 	uint8_t status = P9_LOCK_ERROR;
 	int res = 0;
-	unsigned char fl_type;
+	unsigned char saved_type;
 	struct v9fs_session_info *v9ses;
 
 	fid = filp->private_data;
@@ -213,11 +214,11 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	 * it locally
 	 */
 	if (res < 0 && fl->fl_type != F_UNLCK) {
-		fl_type = fl->fl_type;
+		saved_type = fl->fl_type;
 		fl->fl_type = F_UNLCK;
 		/* Even if this fails we want to return the remote error */
 		locks_lock_file_wait(filp, fl);
-		fl->fl_type = fl_type;
+		fl->fl_type = saved_type;
 	}
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5a..47273bf908709 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -112,16 +112,16 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 {
 	struct file_lock *p, *_p, *next = NULL;
 	struct key *key = vnode->lock_key;
-	unsigned int fl_type = F_RDLCK;
+	unsigned int requested_type = F_RDLCK;
 
 	_enter("");
 
 	if (vnode->lock_type == AFS_LOCK_WRITE)
-		fl_type = F_WRLCK;
+		requested_type = F_WRLCK;
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == fl_type &&
+		    p->fl_type == requested_type &&
 		    afs_file_key(p->fl_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d1287cc3d9381..5cf398812ee1c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 45ba83f202b8e..c1d92153bf7c9 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -7,6 +7,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/ceph/pagelist.h>
 
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e6b4c1a214466..af0e003dade79 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
@@ -295,7 +296,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->fl_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -352,7 +353,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = saved_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a18ec80f57f9b..7423fe73a30ba 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2adaffa58e88b..8130c6090a9e3 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/falloc.h>
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index fba6c7fa74747..d67af20386007 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs_fs.h>
 #include <linux/utsname.h>
@@ -485,7 +486,8 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
-	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host, fl->fl_owner);
+	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
+						       fl->c.flc_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
@@ -522,8 +524,8 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait block;
-	unsigned char fl_flags = fl->fl_flags;
-	unsigned char fl_type;
+	unsigned char saved_flags = fl->fl_flags;
+	unsigned char saved_type;
 	__be32 b_status;
 	int status = -ENOLCK;
 
@@ -533,7 +535,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 
 	fl->fl_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = saved_flags;
 	if (status < 0)
 		goto out;
 
@@ -595,7 +597,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-		fl->fl_flags = fl_flags;
+		fl->fl_flags = saved_flags;
 		status = 0;
 	}
 	if (status < 0)
@@ -605,7 +607,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	 * cases NLM_LCK_DENIED is returned for a permanent error.  So
 	 * turn it into an ENOLCK.
 	 */
-	if (resp->status == nlm_lck_denied && (fl_flags & FL_SLEEP))
+	if (resp->status == nlm_lck_denied && (saved_flags & FL_SLEEP))
 		status = -ENOLCK;
 	else
 		status = nlm_stat_to_errno(resp->status);
@@ -622,13 +624,13 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	fl_type = fl->fl_type;
+	saved_type = fl->fl_type;
 	fl->fl_type = F_UNLCK;
 	down_read(&host->h_rwsem);
 	do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_type = fl_type;
-	fl->fl_flags = fl_flags;
+	fl->fl_type = saved_type;
+	fl->fl_flags = saved_flags;
 	nlmclnt_async_call(cred, req, NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	return status;
 }
@@ -683,7 +685,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	int status;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->fl_flags;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
@@ -694,7 +696,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	down_read(&host->h_rwsem);
 	status = do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = saved_flags;
 	if (status == -ENOENT) {
 		status = 0;
 		goto out;
diff --git a/fs/locks.c b/fs/locks.c
index 19e9fcd1d4ca5..ad47a2fa982f6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -48,6 +48,7 @@
  * children.
  *
  */
+#define _NEED_FILE_LOCK_FIELD_MACROS
 
 #include <linux/capability.h>
 #include <linux/file.h>
@@ -2700,11 +2701,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
-	unsigned int fl_pid;
+	unsigned int lock_pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int type;
 
-	fl_pid = locks_translate_pid(fl, proc_pidns);
+	lock_pid = locks_translate_pid(fl, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
@@ -2752,11 +2753,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
+		seq_printf(f, "%d %02x:%02x:%lu ", lock_pid,
 				MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino);
 	} else {
-		seq_printf(f, "%d <none>:0 ", fl_pid);
+		seq_printf(f, "%d <none>:0 ", lock_pid);
 	}
 	if (IS_POSIX(fl)) {
 		if (fl->fl_end == OFFSET_MAX)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cf16ee710d42b..1fe601f60fb13 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -32,6 +32,7 @@
 #include <linux/compaction.h>
 
 #include <linux/uaccess.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "delegation.h"
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 47c5c1f86d662..f7856d60f1855 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -23,6 +23,7 @@
 #define NFS4_MAX_LOOP_ON_RECOVER (10)
 
 #include <linux/seqlock.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 struct idmap;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ce3ab0a9c0ef7..6790dd168a4f8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7074,7 +7074,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char saved_flags = request->fl_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
@@ -7109,7 +7109,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7427,7 +7427,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char saved_flags = request->fl_flags;
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
@@ -7439,7 +7439,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = fl_flags & ~FL_SLEEP;
+		request->fl_flags = saved_flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7449,7 +7449,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = saved_flags;
 	return status;
 }
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 78d52c2006dcc..c13da4633b9c6 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -847,11 +847,11 @@ void nfs4_close_sync(struct nfs4_state *state, fmode_t fmode)
  */
 static struct nfs4_lock_state *
 __nfs4_find_lock_state(struct nfs4_state *state,
-		       fl_owner_t fl_owner, fl_owner_t fl_owner2)
+		       fl_owner_t lock_owner_id, fl_owner_t fl_owner2)
 {
 	struct nfs4_lock_state *pos, *ret = NULL;
 	list_for_each_entry(pos, &state->lock_states, ls_locks) {
-		if (pos->ls_owner == fl_owner) {
+		if (pos->ls_owner == lock_owner_id) {
 			ret = pos;
 			break;
 		}
@@ -868,7 +868,7 @@ __nfs4_find_lock_state(struct nfs4_state *state,
  * exists, return an uninitialized one.
  *
  */
-static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t fl_owner)
+static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t lock_owner_id)
 {
 	struct nfs4_lock_state *lsp;
 	struct nfs_server *server = state->owner->so_server;
@@ -879,7 +879,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 	nfs4_init_seqid_counter(&lsp->ls_seqid);
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state = state;
-	lsp->ls_owner = fl_owner;
+	lsp->ls_owner = lock_owner_id;
 	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
 	if (lsp->ls_seqid.owner_id < 0)
 		goto out_free;
@@ -993,7 +993,7 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 		const struct nfs_lock_context *l_ctx)
 {
 	struct nfs4_lock_state *lsp;
-	fl_owner_t fl_owner, fl_flock_owner;
+	fl_owner_t lock_owner_id, fl_flock_owner;
 	int ret = -ENOENT;
 
 	if (l_ctx == NULL)
@@ -1002,11 +1002,11 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 	if (test_bit(LK_STATE_IN_USE, &state->flags) == 0)
 		goto out;
 
-	fl_owner = l_ctx->lockowner;
+	lock_owner_id = l_ctx->lockowner;
 	fl_flock_owner = l_ctx->open_context->flock_owner;
 
 	spin_lock(&state->state_lock);
-	lsp = __nfs4_find_lock_state(state, fl_owner, fl_flock_owner);
+	lsp = __nfs4_find_lock_state(state, lock_owner_id, fl_flock_owner);
 	if (lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags))
 		ret = -EIO;
 	else if (lsp != NULL && test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0) {
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 85426764017ce..e317ea53e9def 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/wait.h>
 #include <linux/iversion.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include <linux/uaccess.h>
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0ecc5527a8f1a..33e4f5d448a17 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..78bf5d520b4a2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7580,8 +7580,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int lkflg;
 	int err;
 	bool new = false;
-	unsigned char fl_type;
-	unsigned int fl_flags = FL_POSIX;
+	unsigned char lock_type;
+	unsigned int lock_flags = FL_POSIX;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
@@ -7643,13 +7643,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	if (lock->lk_reclaim)
-		fl_flags |= FL_RECLAIM;
+		lock_flags |= FL_RECLAIM;
 
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
 			if (nfsd4_has_session(cstate))
-				fl_flags |= FL_SLEEP;
+				lock_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
@@ -7657,11 +7657,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_RDLCK;
+			lock_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
 			if (nfsd4_has_session(cstate))
-				fl_flags |= FL_SLEEP;
+				lock_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
@@ -7669,7 +7669,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_WRLCK;
+			lock_type = F_WRLCK;
 			break;
 		default:
 			status = nfserr_inval;
@@ -7689,7 +7689,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * on those filesystems:
 	 */
 	if (nf->nf_file->f_op->lock)
-		fl_flags &= ~FL_SLEEP;
+		lock_flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
@@ -7699,11 +7699,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	file_lock = &nbl->nbl_lock;
-	file_lock->fl_type = fl_type;
+	file_lock->fl_type = lock_type;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
 	file_lock->fl_pid = current->tgid;
 	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = fl_flags;
+	file_lock->fl_flags = lock_flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
@@ -7716,7 +7716,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (fl_flags & FL_SLEEP) {
+	if (lock_flags & FL_SLEEP) {
 		nbl->nbl_time = ktime_get_boottime_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
@@ -7753,7 +7753,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	if (nbl) {
 		/* dequeue it if we queued it before */
-		if (fl_flags & FL_SLEEP) {
+		if (lock_flags & FL_SLEEP) {
 			spin_lock(&nn->blocked_locks_lock);
 			if (!list_empty(&nbl->nbl_list) &&
 			    !list_empty(&nbl->nbl_lru)) {
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index f37174e79fad4..8a9970dc852e7 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/fcntl.h>
 
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index eeb1c29b033e6..04ae9361e0270 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a4e0618c58efc..cdf2d9b0f3d06 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -28,6 +28,7 @@
 #include "../common/cifsglob.h"
 #include "../common/smb2pdu.h"
 #include "smb2pdu.h"
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #define SMB_PATH_MAX 260
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index e7df15011ae33..cf10da9ad44be 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -15,6 +15,7 @@
  /* want to reuse a stale file handle and only the caller knows the file info */
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/kernel.h>
 #include <linux/vfs.h>
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 94c8b173a8d63..1394a86e15a8a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/backing-dev.h>
 #include <linux/stat.h>
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 576c72691e374..99db66579424d 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -7,6 +7,7 @@
  *
  */
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d97ffe3d2a710..39ea8ca6d7019 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13,6 +13,7 @@
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
 #include <linux/mount.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 
 #include "glob.h"
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 69f807aff769c..10bf17e0556b0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/backing-dev.h>
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 95e868e09e298..a466566cec171 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -85,23 +85,28 @@ bool opens_in_grace(struct net *);
  *
  * Obviously, the last two criteria only matter for POSIX locks.
  */
-struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
-	struct list_head fl_list;	/* link into file_lock_context */
-	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_blocked_requests;	/* list of requests with
+
+struct file_lock_core {
+	struct file_lock *flc_blocker;	/* The lock that is blocking us */
+	struct list_head flc_list;	/* link into file_lock_context */
+	struct hlist_node flc_link;	/* node in global lists */
+	struct list_head flc_blocked_requests;	/* list of requests with
 						 * ->fl_blocker pointing here
 						 */
-	struct list_head fl_blocked_member;	/* node in
+	struct list_head flc_blocked_member;	/* node in
 						 * ->fl_blocker->fl_blocked_requests
 						 */
-	fl_owner_t fl_owner;
-	unsigned int fl_flags;
-	unsigned char fl_type;
-	unsigned int fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
+	fl_owner_t flc_owner;
+	unsigned int flc_flags;
+	unsigned char flc_type;
+	unsigned int flc_pid;
+	int flc_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t flc_wait;
+	struct file *flc_file;
+};
+
+struct file_lock {
+	struct file_lock_core c;
 	loff_t fl_start;
 	loff_t fl_end;
 
@@ -126,6 +131,22 @@ struct file_lock {
 	} fl_u;
 } __randomize_layout;
 
+/* Temporary macros to allow building during coccinelle conversion */
+#ifdef _NEED_FILE_LOCK_FIELD_MACROS
+#define fl_list c.flc_list
+#define fl_blocker c.flc_blocker
+#define fl_link c.flc_link
+#define fl_blocked_requests c.flc_blocked_requests
+#define fl_blocked_member c.flc_blocked_member
+#define fl_owner c.flc_owner
+#define fl_flags c.flc_flags
+#define fl_type c.flc_type
+#define fl_pid c.flc_pid
+#define fl_link_cpu c.flc_link_cpu
+#define fl_wait c.flc_wait
+#define fl_file c.flc_file
+#endif
+
 struct file_lock_context {
 	spinlock_t		flc_lock;
 	struct list_head	flc_flock;
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index b60fbcd8cdfad..c3ccf81a03728 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -11,6 +11,7 @@
 #define LOCKD_XDR_H
 
 #include <linux/fs.h>
+#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 3b1c8d93b2654..95c969057844a 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -69,11 +69,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_pid)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
+		__field(struct file_lock *, blocker)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, pid)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 		__field(loff_t, fl_start)
 		__field(loff_t, fl_end)
 		__field(int, ret)
@@ -83,11 +83,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_pid = fl ? fl->fl_pid : 0;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->blocker = fl ? fl->fl_blocker : NULL;
+		__entry->owner = fl ? fl->fl_owner : NULL;
+		__entry->pid = fl ? fl->fl_pid : 0;
+		__entry->flags = fl ? fl->fl_flags : 0;
+		__entry->type = fl ? fl->fl_type : 0;
 		__entry->fl_start = fl ? fl->fl_start : 0;
 		__entry->fl_end = fl ? fl->fl_end : 0;
 		__entry->ret = ret;
@@ -95,9 +95,9 @@ DECLARE_EVENT_CLASS(filelock_lock,
 
 	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
-		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type),
+		__entry->i_ino, __entry->blocker, __entry->owner,
+		__entry->pid, show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type),
 		__entry->fl_start, __entry->fl_end, __entry->ret)
 );
 
@@ -126,10 +126,10 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
+		__field(struct file_lock *, blocker)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 		__field(unsigned long, fl_break_time)
 		__field(unsigned long, fl_downgrade_time)
 	),
@@ -138,19 +138,19 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->blocker = fl ? fl->fl_blocker : NULL;
+		__entry->owner = fl ? fl->fl_owner : NULL;
+		__entry->flags = fl ? fl->fl_flags : 0;
+		__entry->type = fl ? fl->fl_type : 0;
 		__entry->fl_break_time = fl ? fl->fl_break_time : 0;
 		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
 
 	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
-		show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type),
+		__entry->i_ino, __entry->blocker, __entry->owner,
+		show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type),
 		__entry->fl_break_time, __entry->fl_downgrade_time)
 );
 
@@ -180,9 +180,9 @@ TRACE_EVENT(generic_add_lease,
 		__field(int, rcount)
 		__field(int, icount)
 		__field(dev_t, s_dev)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 	),
 
 	TP_fast_assign(
@@ -191,17 +191,17 @@ TRACE_EVENT(generic_add_lease,
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
 		__entry->icount = atomic_read(&inode->i_count);
-		__entry->fl_owner = fl->fl_owner;
-		__entry->fl_flags = fl->fl_flags;
-		__entry->fl_type = fl->fl_type;
+		__entry->owner = fl->fl_owner;
+		__entry->flags = fl->fl_flags;
+		__entry->type = fl->fl_type;
 	),
 
 	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->wcount, __entry->rcount,
-		__entry->icount, __entry->fl_owner,
-		show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type))
+		__entry->icount, __entry->owner,
+		show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type))
 );
 
 TRACE_EVENT(leases_conflict,
-- 
2.53.0


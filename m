Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473F346769
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711945; cv=none; b=ZW5TYzOgAWCZ0iEtz4DXET8oaJGmRxkUTqpdPGEGkEI4Fg9oojOe65FpRR/J8E0rtPlt31Q2JzGfMW8YVd17GVaIcJ0vAWegHf8W6SxPNWWEWAN8ptg9OMt3COqWFKg1W3iWvnlWJx7FEe57Slgy45Seo7+wDlhgpoXrjmfd+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711945; c=relaxed/simple;
	bh=ocVUPg2X6h7Vb4B/kY6Xq+YU2R7kPIjYil/pesNua9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCY6Y6WmcPjrB9xJIFgjEvUy4dzV6+oC0GiRybUVZ1M7rT7Yeh1U78cuWqb35Dr7UsNiGgKvYNPXQsrfNnSbFHo9ICrDVMubVmiuhvumGp7qV4zUjcAzLoXk0fUhipE/HsFuArY7t++FJmh8kW6IN/umjmf8qsJa2KYVVsJkOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULG+l2/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULG+l2/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF861F00A3A;
	Sun,  6 Sep 2026 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711940;
	bh=dPyzwURlNfbYGzDVQ+zzH02i+0t0NSKAitNJE1qK64Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULG+l2/1cG2uIBNgNEo9jZDEM9wn00tNVIYc+2tGrQpYQi5x+9uE4WX8s0zAxNV8o
	 RL2dQNDgddHi9L3sP6ZDrHmsgN9x3CsqkJPf0VnoxleaEdFlUCgaXB2bbhAWJR76jD
	 KvdwtDcNlIVNN4s3tw9Nsu5uPHpbM8nrwQOTsPeIkOTG+Fjt040GB5gpeh+p2KeOf8
	 uvXDym/MHu2JZvZ41TdXxzsvXJTMNCf1uLgnxns00EQfaS70QTVSLqu9AS/Hh1eKtN
	 5QYXp6I2L4Idjmcvw4CrzzoRobspZDoXe9LEK1lXVkhG76TbMBJGCYK5F883V4eo+U
	 LRT/KwovY4qXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15.y 1/2] ceph: pass the mdsc to several helpers
Date: Sun,  6 Sep 2026 12:25:37 -0400
Message-ID: <20260906162538.1573381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-atlantic-hangup-270a@gregkh>
References: <2026090356-atlantic-hangup-270a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

We will use the 'mdsc' to get the global_id in the following commits.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/caps.c              | 14 ++++---
 fs/ceph/debugfs.c           |  4 +-
 fs/ceph/dir.c               |  2 +-
 fs/ceph/file.c              |  2 +-
 fs/ceph/mds_client.c        | 77 ++++++++++++++++++++++++-------------
 fs/ceph/mds_client.h        |  3 +-
 fs/ceph/mdsmap.c            |  3 +-
 fs/ceph/snap.c              | 21 +++++-----
 fs/ceph/super.h             |  3 +-
 include/linux/ceph/mdsmap.h |  5 ++-
 10 files changed, 85 insertions(+), 49 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bf904dc861a4b..a25c5d8f5c4bd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1175,7 +1175,8 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	}
 }
 
-void ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
+void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+		     bool queue_release)
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
@@ -1316,6 +1317,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
  */
 void __ceph_remove_caps(struct ceph_inode_info *ci)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(ci->vfs_inode.i_sb);
 	struct rb_node *p;
 
 	/* lock i_ceph_lock, because ceph_d_revalidate(..., LOOKUP_RCU)
@@ -1325,7 +1327,7 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
 		p = rb_next(p);
-		ceph_remove_cap(cap, true);
+		ceph_remove_cap(mdsc, cap, true);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 }
@@ -3869,7 +3871,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		goto out_unlock;
 
 	if (target < 0) {
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	}
 
@@ -3904,7 +3906,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 				change_auth_cap_ses(ci, tcap->session);
 			}
 		}
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	} else if (tsession) {
 		/* add placeholder for the export tagert */
@@ -3921,7 +3923,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			spin_unlock(&mdsc->cap_dirty_lock);
 		}
 
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	}
 
@@ -4032,7 +4034,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 					ocap->mseq, mds, le32_to_cpu(ph->seq),
 					le32_to_cpu(ph->mseq));
 		}
-		ceph_remove_cap(ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
+		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
 	*old_issued = issued;
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 38b78b45811f9..44f776c71f427 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -81,7 +81,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
-			path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
+			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
 						    &pathbase, 0);
 			if (IS_ERR(path))
 				path = NULL;
@@ -100,7 +100,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		}
 
 		if (req->r_old_dentry) {
-			path = ceph_mdsc_build_path(req->r_old_dentry, &pathlen,
+			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &pathlen,
 						    &pathbase, 0);
 			if (IS_ERR(path))
 				path = NULL;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 74845a793aa36..1a0126ae3a44c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1083,7 +1083,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 	if (result) {
 		int pathlen = 0;
 		u64 base = 0;
-		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
+		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
 						  &base, 0);
 
 		/* mark error on parent + clear complete */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7ecb51384497b..95b40b4a1bc60 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -531,7 +531,7 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 		struct dentry *dentry = req->r_dentry;
 		int pathlen = 0;
 		u64 base = 0;
-		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
+		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
 						  &base, 0);
 
 		ceph_dir_clear_complete(req->r_parent);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7c47ce276a993..3092cb14e683c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -433,31 +433,33 @@ static int parse_reply_info_filelock(void **p, void *end,
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	dout("got %u sets of delegated inodes\n", sets);
+	doutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
-		u64 start, len, ino;
+		u64 start, len;
 
 		ceph_decode_64_safe(p, end, start, bad);
 		ceph_decode_64_safe(p, end, len, bad);
 
 		/* Don't accept a delegation of system inodes */
 		if (start < CEPH_INO_SYSTEM_BASE) {
-			pr_warn_ratelimited("ceph: ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
-					start, len);
+			pr_warn_ratelimited_client(cl,
+				"ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
+				start, len);
 			continue;
 		}
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, ino = start++,
+			int err = xa_insert(&s->s_delegated_inos, start++,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-				dout("added delegated inode 0x%llx\n",
-				     start - 1);
+				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
-				pr_warn("ceph: MDS delegated inode 0x%llx more than once.\n",
+				pr_warn_client(cl,
+					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
 			} else {
 				return err;
@@ -1965,6 +1967,7 @@ static bool drop_negative_children(struct dentry *dentry)
  */
 static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	int *remaining = arg;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int used, wanted, oissued, mine;
@@ -2006,7 +2009,7 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
-		ceph_remove_cap(cap, true);
+		ceph_remove_cap(mdsc, cap, true);
 		(*remaining)--;
 	} else {
 		struct dentry *dentry;
@@ -2362,6 +2365,7 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 /*
  * Build a dentry's path.  Allocate on heap; caller must kfree.  Based
  * on build_path_from_dentry in fs/cifs/dir.c.
+ * @mdsc: mds client
  *
  * If @stop_on_nosnap, generate path relative to the first non-snapped
  * inode.
@@ -2369,8 +2373,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
  * Encode hidden .snap dirs as a double /, i.e.
  *   foo/.snap/bar -> foo//bar
  */
-char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
-			   int stop_on_nosnap)
+char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
+			   int *plen, u64 *pbase, int stop_on_nosnap)
 {
 	struct dentry *temp;
 	char *path;
@@ -2447,9 +2451,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 	return path + pos;
 }
 
-static int build_dentry_path(struct dentry *dentry, struct inode *dir,
-			     const char **ppath, int *ppathlen, u64 *pino,
-			     bool *pfreepath, bool parent_locked)
+static int build_dentry_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
+			     struct inode *dir, const char **ppath, int *ppathlen,
+			     u64 *pino, bool *pfreepath, bool parent_locked)
 {
 	char *path;
 
@@ -2464,7 +2468,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 		return 0;
 	}
 	rcu_read_unlock();
-	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	*ppath = path;
@@ -2476,6 +2480,7 @@ static int build_inode_path(struct inode *inode,
 			    const char **ppath, int *ppathlen, u64 *pino,
 			    bool *pfreepath)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct dentry *dentry;
 	char *path;
 
@@ -2485,7 +2490,7 @@ static int build_inode_path(struct inode *inode,
 		return 0;
 	}
 	dentry = d_find_alias(inode);
-	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
 	dput(dentry);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
@@ -2498,10 +2503,11 @@ static int build_inode_path(struct inode *inode,
  * request arguments may be specified via an inode *, a dentry *, or
  * an explicit ino+path.
  */
-static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
-				  struct inode *rdiri, const char *rpath,
-				  u64 rino, const char **ppath, int *pathlen,
-				  u64 *ino, bool *freepath, bool parent_locked)
+static int set_request_path_attr(struct ceph_mds_client *mdsc,
+				 struct inode *rinode, struct dentry *rdentry,
+				 struct inode *rdiri, const char *rpath, u64 rino,
+				 const char **ppath, int *pathlen, u64 *ino,
+				 bool *freepath, bool parent_locked)
 {
 	int r = 0;
 
@@ -2510,7 +2516,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
 		     ceph_snap(rinode));
 	} else if (rdentry) {
-		r = build_dentry_path(rdentry, rdiri, ppath, pathlen, ino,
+		r = build_dentry_path(mdsc, rdentry, rdiri, ppath, pathlen, ino,
 					freepath, parent_locked);
 		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
 		     *ppath);
@@ -2562,7 +2568,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
 
-	ret = set_request_path_attr(req->r_inode, req->r_dentry,
+	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
 			      &path1, &pathlen1, &ino1, &freepath1,
 			      test_bit(CEPH_MDS_R_PARENT_LOCKED,
@@ -2573,7 +2579,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	}
 
 	/* If r_old_dentry is set, then assume that its parent is locked */
-	ret = set_request_path_attr(NULL, req->r_old_dentry,
+	ret = set_request_path_attr(mdsc, NULL, req->r_old_dentry,
 			      req->r_old_dentry_dir,
 			      req->r_path2, req->r_ino2.ino,
 			      &path2, &pathlen2, &ino2, &freepath2, true);
@@ -3782,6 +3788,7 @@ static struct dentry* d_find_primary(struct inode *inode)
 static int reconnect_caps_cb(struct inode *inode, struct ceph_cap *cap,
 			  void *arg)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	union {
 		struct ceph_mds_cap_reconnect v2;
 		struct ceph_mds_cap_reconnect_v1 v1;
@@ -3802,7 +3809,7 @@ static int reconnect_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	dentry = d_find_primary(inode);
 	if (dentry) {
 		/* set pathbase to parent dir when msg_version >= 2 */
-		path = ceph_mdsc_build_path(dentry, &pathlen, &pathbase,
+		path = ceph_mdsc_build_path(mdsc, dentry, &pathlen, &pathbase,
 					    recon_state->msg_version >= 2);
 		dput(dentry);
 		if (IS_ERR(path)) {
@@ -4031,6 +4038,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
@@ -4049,9 +4057,21 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	if (!reply)
 		goto fail_nomsg;
 
+	mutex_lock(&session->s_mutex);
+
+	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_return;
+	}
 
-	mutex_lock(&session->s_mutex);
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -4192,6 +4212,10 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 fail_nopagelist:
 	pr_err("error %d preparing reconnect for mds%d\n", err, mds);
 	return;
+
+fail_return:
+	ceph_pagelist_release(recon_state.pagelist);
+	return;
 }
 
 
@@ -5149,7 +5173,8 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		return;
 	}
 
-	newmap = ceph_mdsmap_decode(&p, end, ceph_msgr2(mdsc->fsc->client));
+	newmap = ceph_mdsmap_decode(mdsc, &p, end,
+				    ceph_msgr2(mdsc->fsc->client));
 	if (IS_ERR(newmap)) {
 		err = PTR_ERR(newmap);
 		goto bad_unlock;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4c2741933bf43..df8976aefc5c4 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -546,7 +546,8 @@ static inline void ceph_mdsc_free_path(char *path, int len)
 		__putname(path - (PATH_MAX - 1 - len));
 }
 
-extern char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *base,
+extern char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc,
+				  struct dentry *dentry, int *plen, u64 *base,
 				  int stop_on_nosnap);
 
 extern void __ceph_mdsc_drop_dentry_lease(struct dentry *dentry);
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 0e869b70a50c1..ce3d99661e96d 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -114,7 +114,8 @@ static int __decode_and_drop_compat_set(void **p, void* end)
  * Ignore any fields we don't care about (there are quite a few of
  * them).
  */
-struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
+struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
+				       void *end, bool msgr2)
 {
 	struct ceph_mdsmap *m;
 	const void *start = *p;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 74a1fc919c6be..f5527960fb521 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -319,8 +319,9 @@ static int cmpu64_rev(const void *a, const void *b)
 /*
  * build the snap context for a given realm.
  */
-static int build_snap_context(struct ceph_snap_realm *realm,
-			      struct list_head* dirty_realms)
+static int build_snap_context(struct ceph_mds_client *mdsc,
+			      struct ceph_snap_realm *realm,
+			      struct list_head *dirty_realms)
 {
 	struct ceph_snap_realm *parent = realm->parent;
 	struct ceph_snap_context *snapc;
@@ -334,7 +335,7 @@ static int build_snap_context(struct ceph_snap_realm *realm,
 	 */
 	if (parent) {
 		if (!parent->cached_context) {
-			err = build_snap_context(parent, dirty_realms);
+			err = build_snap_context(mdsc, parent, dirty_realms);
 			if (err)
 				goto fail;
 		}
@@ -417,16 +418,17 @@ static int build_snap_context(struct ceph_snap_realm *realm,
 /*
  * rebuild snap context for the given realm and all of its children.
  */
-static void rebuild_snap_realms(struct ceph_snap_realm *realm,
+static void rebuild_snap_realms(struct ceph_mds_client *mdsc,
+				struct ceph_snap_realm *realm,
 				struct list_head *dirty_realms)
 {
 	struct ceph_snap_realm *child;
 
 	dout("rebuild_snap_realms %llx %p\n", realm->ino, realm);
-	build_snap_context(realm, dirty_realms);
+	build_snap_context(mdsc, realm, dirty_realms);
 
 	list_for_each_entry(child, &realm->children, child_item)
-		rebuild_snap_realms(child, dirty_realms);
+		rebuild_snap_realms(mdsc, child, dirty_realms);
 }
 
 
@@ -669,7 +671,8 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
  * Queue cap_snaps for snap writeback for this realm and its children.
  * Called under snap_rwsem, so realm topology won't change.
  */
-static void queue_realm_cap_snaps(struct ceph_snap_realm *realm)
+static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
+				  struct ceph_snap_realm *realm)
 {
 	struct ceph_inode_info *ci;
 	struct inode *lastinode = NULL;
@@ -791,7 +794,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 	/* rebuild_snapcs when we reach the _end_ (root) of the trace */
 	if (realm_to_rebuild && p >= e)
-		rebuild_snap_realms(realm_to_rebuild, &dirty_realms);
+		rebuild_snap_realms(mdsc, realm_to_rebuild, &dirty_realms);
 
 	if (!first_realm)
 		first_realm = realm;
@@ -809,7 +812,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 		realm = list_first_entry(&dirty_realms, struct ceph_snap_realm,
 					 dirty_item);
 		list_del_init(&realm->dirty_item);
-		queue_realm_cap_snaps(realm);
+		queue_realm_cap_snaps(mdsc, realm);
 	}
 
 	if (realm_ret)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5e07715b895d1..6c82b4eac46cb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1140,7 +1140,8 @@ extern void ceph_add_cap(struct inode *inode,
 			 unsigned cap, unsigned seq, u64 realmino, int flags,
 			 struct ceph_cap **new_cap);
 extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
-extern void ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
+extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
 			 struct ceph_cap *cap);
diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
index 523fd04528562..d5e3ed0487f3e 100644
--- a/include/linux/ceph/mdsmap.h
+++ b/include/linux/ceph/mdsmap.h
@@ -5,6 +5,8 @@
 #include <linux/bug.h>
 #include <linux/ceph/types.h>
 
+struct ceph_mds_client;
+
 /*
  * mds map - describe servers in the mds cluster.
  *
@@ -64,7 +66,8 @@ static inline bool ceph_mdsmap_is_laggy(struct ceph_mdsmap *m, int w)
 }
 
 extern int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m);
-struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2);
+struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
+				       void *end, bool msgr2);
 extern void ceph_mdsmap_destroy(struct ceph_mdsmap *m);
 extern bool ceph_mdsmap_is_cluster_available(struct ceph_mdsmap *m);
 
-- 
2.53.0


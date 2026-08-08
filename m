Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DF30C159
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786157535; cv=none; b=DcBfhZsnXmC8nRFPBCG2lWT7MvVjIH1YQD5GyHaya95Mfa7NglUdj95OEh4HDVr5ba3pTS72FuSAhqButfdmOwhozdiKCnBFJ4iOovnaJiK+KKBSfVMu8SKrF74m5HygG4KEWsMR4bWzCIh2zyT9fPPzjyItfiCvdhoJ4d9Zod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786157535; c=relaxed/simple;
	bh=Z47pPeUWGc5Eu0b6yasjYCVp5K5baZ1sMNMEzRGity8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCkvpCX/GIHABxAKULkEqM1wlA6dx/l1miJzlHKGdbaaVJ4M46QIGXMdbL7vQBku+WdIceaHncE0vzTg0W7SUogiE3WkpnN/I0QKd+vytucDYCyg+Gml0khCT6K0Kjsd2fXlxlQnwfpHQdkRcRbpqBdkPtRqnVoZEENl/HSsJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohjlv3KV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohjlv3KV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6241F00A3A;
	Sat,  8 Aug 2026 02:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786157533;
	bh=+7hgoNz9tcL8AmbpB22hZ081JCDOG5fqfdMbFfrn/oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohjlv3KVVYTo1MYf8kL1H4oEnVehcdkw2WFtA2k1qC2bgc1ccP2LaWjzlPn/myz15
	 oUH+Uw9D+RJoKz3ZDDEi6VFIg841ka49wXBe0RmgT5zaFKcgUbCFksaUXuOPJQ9XYq
	 earf64S7nOOstMZDvc5ZWP8IpraM5364FhOlcEecMjGsaDH+yQbiOS6d/8iaq0CciA
	 LcmuHNa9PPiZAGhc/t/wploppCmda+qk2BvDL0Tzintf7Q7LdzxlA3dOVZeOPFkDbZ
	 vwUM+LGmuvaao3YkT3WY5KQueRH/plYNoyD3XqefIljQrvOnRkMwOdnjWg1khPTrun
	 yG5l9bl2r/vnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] ceph: pass the mdsc to several helpers
Date: Fri,  7 Aug 2026 22:52:08 -0400
Message-ID: <20260808025210.4027042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808025210.4027042-1-sashal@kernel.org>
References: <2026072910-waffle-backlight-0153@gregkh>
 <20260808025210.4027042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 197b7d792d6aead2e30d4b2c054ffabae2ed73dc ]

We will use the 'mdsc' to get the global_id in the following commits.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 50958bb928ba ("ceph: fix hanging __ceph_get_caps() with stale mds_wanted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c              | 15 +++++++++------
 fs/ceph/debugfs.c           |  4 ++--
 fs/ceph/dir.c               |  2 +-
 fs/ceph/file.c              |  2 +-
 fs/ceph/mds_client.c        | 38 ++++++++++++++++++++-----------------
 fs/ceph/mds_client.h        |  3 ++-
 fs/ceph/mdsmap.c            |  3 ++-
 fs/ceph/snap.c              | 16 ++++++++++------
 fs/ceph/super.h             |  3 ++-
 include/linux/ceph/mdsmap.h |  5 ++++-
 10 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 57603782e7e2a..0e400d309a367 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1176,7 +1176,8 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	}
 }
 
-void ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
+void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+		     bool queue_release)
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
@@ -1317,6 +1318,8 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
  */
 void __ceph_remove_caps(struct ceph_inode_info *ci)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct rb_node *p;
 
 	/* lock i_ceph_lock, because ceph_d_revalidate(..., LOOKUP_RCU)
@@ -1326,7 +1329,7 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
 		p = rb_next(p);
-		ceph_remove_cap(cap, true);
+		ceph_remove_cap(mdsc, cap, true);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 }
@@ -3900,7 +3903,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		goto out_unlock;
 
 	if (target < 0) {
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	}
 
@@ -3935,7 +3938,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 				change_auth_cap_ses(ci, tcap->session);
 			}
 		}
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	} else if (tsession) {
 		/* add placeholder for the export tagert */
@@ -3952,7 +3955,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			spin_unlock(&mdsc->cap_dirty_lock);
 		}
 
-		ceph_remove_cap(cap, false);
+		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	}
 
@@ -4065,7 +4068,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 					ocap->mseq, mds, le32_to_cpu(ph->seq),
 					le32_to_cpu(ph->mseq));
 		}
-		ceph_remove_cap(ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
+		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
 	*old_issued = issued;
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 3904333fa6c38..2f1e7498cd745 100644
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
index c4365a7d80d51..98374c3dc1984 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1118,7 +1118,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 	if (result) {
 		int pathlen = 0;
 		u64 base = 0;
-		char *path = ceph_mdsc_build_path(dentry, &pathlen,
+		char *path = ceph_mdsc_build_path(mdsc, dentry, &pathlen,
 						  &base, 0);
 
 		/* mark error on parent + clear complete */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 13ea8fd0bdee3..7e628e4ee3430 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -564,7 +564,7 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 	if (result) {
 		int pathlen = 0;
 		u64 base = 0;
-		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
+		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
 						  &base, 0);
 
 		pr_warn("async create failure path=(%llx)%s result=%d!\n",
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 741ca7d10032c..138872b203c9a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1971,6 +1971,7 @@ static bool drop_negative_children(struct dentry *dentry)
  */
 static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	int *remaining = arg;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int used, wanted, oissued, mine;
@@ -2018,7 +2019,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
-		ceph_remove_cap(cap, true);
+		ceph_remove_cap(mdsc, cap, true);
 		(*remaining)--;
 	} else {
 		struct dentry *dentry;
@@ -2383,8 +2384,8 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
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
@@ -2461,9 +2462,9 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
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
 
@@ -2478,7 +2479,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 		return 0;
 	}
 	rcu_read_unlock();
-	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	*ppath = path;
@@ -2490,6 +2491,7 @@ static int build_inode_path(struct inode *inode,
 			    const char **ppath, int *ppathlen, u64 *pino,
 			    bool *pfreepath)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct dentry *dentry;
 	char *path;
 
@@ -2499,7 +2501,7 @@ static int build_inode_path(struct inode *inode,
 		return 0;
 	}
 	dentry = d_find_alias(inode);
-	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
 	dput(dentry);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
@@ -2512,10 +2514,11 @@ static int build_inode_path(struct inode *inode,
  * request arguments may be specified via an inode *, a dentry *, or
  * an explicit ino+path.
  */
-static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
-				  struct inode *rdiri, const char *rpath,
-				  u64 rino, const char **ppath, int *pathlen,
-				  u64 *ino, bool *freepath, bool parent_locked)
+static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rinode,
+				 struct dentry *rdentry, struct inode *rdiri,
+				 const char *rpath, u64 rino, const char **ppath,
+				 int *pathlen, u64 *ino, bool *freepath,
+				 bool parent_locked)
 {
 	int r = 0;
 
@@ -2524,7 +2527,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
 		     ceph_snap(rinode));
 	} else if (rdentry) {
-		r = build_dentry_path(rdentry, rdiri, ppath, pathlen, ino,
+		r = build_dentry_path(mdsc, rdentry, rdiri, ppath, pathlen, ino,
 					freepath, parent_locked);
 		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
 		     *ppath);
@@ -2576,7 +2579,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
 
-	ret = set_request_path_attr(req->r_inode, req->r_dentry,
+	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
 			      &path1, &pathlen1, &ino1, &freepath1,
 			      test_bit(CEPH_MDS_R_PARENT_LOCKED,
@@ -2587,7 +2590,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	}
 
 	/* If r_old_dentry is set, then assume that its parent is locked */
-	ret = set_request_path_attr(NULL, req->r_old_dentry,
+	ret = set_request_path_attr(mdsc, NULL, req->r_old_dentry,
 			      req->r_old_dentry_dir,
 			      req->r_path2, req->r_ino2.ino,
 			      &path2, &pathlen2, &ino2, &freepath2, true);
@@ -3929,6 +3932,7 @@ static struct dentry* d_find_primary(struct inode *inode)
  */
 static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	union {
 		struct ceph_mds_cap_reconnect v2;
 		struct ceph_mds_cap_reconnect_v1 v1;
@@ -3946,7 +3950,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	dentry = d_find_primary(inode);
 	if (dentry) {
 		/* set pathbase to parent dir when msg_version >= 2 */
-		path = ceph_mdsc_build_path(dentry, &pathlen, &pathbase,
+		path = ceph_mdsc_build_path(mdsc, dentry, &pathlen, &pathbase,
 					    recon_state->msg_version >= 2);
 		dput(dentry);
 		if (IS_ERR(path)) {
@@ -5301,7 +5305,7 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		return;
 	}
 
-	newmap = ceph_mdsmap_decode(&p, end, ceph_msgr2(mdsc->fsc->client));
+	newmap = ceph_mdsmap_decode(mdsc, &p, end, ceph_msgr2(mdsc->fsc->client));
 	if (IS_ERR(newmap)) {
 		err = PTR_ERR(newmap);
 		goto bad_unlock;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0913959ccfa64..660200c30f2c3 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -561,7 +561,8 @@ static inline void ceph_mdsc_free_path(char *path, int len)
 		__putname(path - (PATH_MAX - 1 - len));
 }
 
-extern char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *base,
+extern char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc,
+				  struct dentry *dentry, int *plen, u64 *base,
 				  int stop_on_nosnap);
 
 extern void __ceph_mdsc_drop_dentry_lease(struct dentry *dentry);
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 4a089d70ebd07..8f93861f0138a 100644
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
index 82f7592e1747b..60a356b665e48 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -329,7 +329,8 @@ static int cmpu64_rev(const void *a, const void *b)
 /*
  * build the snap context for a given realm.
  */
-static int build_snap_context(struct ceph_snap_realm *realm,
+static int build_snap_context(struct ceph_mds_client *mdsc,
+			      struct ceph_snap_realm *realm,
 			      struct list_head *realm_queue,
 			      struct list_head *dirty_realms)
 {
@@ -425,7 +426,8 @@ static int build_snap_context(struct ceph_snap_realm *realm,
 /*
  * rebuild snap context for the given realm and all of its children.
  */
-static void rebuild_snap_realms(struct ceph_snap_realm *realm,
+static void rebuild_snap_realms(struct ceph_mds_client *mdsc,
+				struct ceph_snap_realm *realm,
 				struct list_head *dirty_realms)
 {
 	LIST_HEAD(realm_queue);
@@ -451,7 +453,8 @@ static void rebuild_snap_realms(struct ceph_snap_realm *realm,
 			continue;
 		}
 
-		last = build_snap_context(_realm, &realm_queue, dirty_realms);
+		last = build_snap_context(mdsc, _realm, &realm_queue,
+					  dirty_realms);
 		dout("%s %llx %p, %s\n", __func__, _realm->ino, _realm,
 		     last > 0 ? "is deferred" : !last ? "succeeded" : "failed");
 
@@ -705,7 +708,8 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
  * Queue cap_snaps for snap writeback for this realm and its children.
  * Called under snap_rwsem, so realm topology won't change.
  */
-static void queue_realm_cap_snaps(struct ceph_snap_realm *realm)
+static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
+				  struct ceph_snap_realm *realm)
 {
 	struct ceph_inode_info *ci;
 	struct inode *lastinode = NULL;
@@ -852,7 +856,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 	/* rebuild_snapcs when we reach the _end_ (root) of the trace */
 	if (realm_to_rebuild && p >= e)
-		rebuild_snap_realms(realm_to_rebuild, &dirty_realms);
+		rebuild_snap_realms(mdsc, realm_to_rebuild, &dirty_realms);
 
 	if (!first_realm)
 		first_realm = realm;
@@ -870,7 +874,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 		realm = list_first_entry(&dirty_realms, struct ceph_snap_realm,
 					 dirty_item);
 		list_del_init(&realm->dirty_item);
-		queue_realm_cap_snaps(realm);
+		queue_realm_cap_snaps(mdsc, realm);
 	}
 
 	if (realm_ret)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7ca74f5f70be5..d87483005650f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1188,7 +1188,8 @@ extern void ceph_add_cap(struct inode *inode,
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
index fcc95bff72a57..1f2171dd01bfa 100644
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
@@ -69,7 +71,8 @@ static inline bool ceph_mdsmap_is_laggy(struct ceph_mdsmap *m, int w)
 }
 
 extern int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m);
-struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2);
+struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
+				       void *end, bool msgr2);
 extern void ceph_mdsmap_destroy(struct ceph_mdsmap *m);
 extern bool ceph_mdsmap_is_cluster_available(struct ceph_mdsmap *m);
 
-- 
2.53.0


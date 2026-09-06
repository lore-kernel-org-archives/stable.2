Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16F38D017
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710237; cv=none; b=HmT3OtfeXGMdIMe0TzPZYU1pK7iMnIW7kXTdmR5hpeP3ZSJa61RXAmu/mK+9iUeF7yA6bCWY9UR+O9o4oFWvxDljFZzw2Z/hLr/BKQQmHbBXm+WnPG3Lpy/xqK15MhfUgWqI1bvwaKOJwMw53yu0J9JcHZU/cy0biDopXvxFEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710237; c=relaxed/simple;
	bh=aORLxXtdiqrrpfMY3MtuvIXWPtfwHuDBmrsXabnH/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DagO1j3r+OQphOsn4Bmf76eH93JnndOdWJKuUD905N/qAoJj6e4r8dAPaLwTo3/MlSRy0P47VaID9kihaWj38EAcjQRQjPxVptGusOpi7FCpy6GJg3y3TMugfd2O2dbny0wXC8isjkhz2onWPXu1orq48elSMiZelqxL8P8nnMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXVQT7Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXVQT7Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE13E1F00ACA;
	Sun,  6 Sep 2026 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710229;
	bh=WvEb4mgq/viXRisFFf1yOJS9452vp1MYCtEQtpKZr3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXVQT7IeLBMgNWAqqLyk/cG+D8YYaZ4P7X72MRDHrFdSZMp0g1Us/O9kLSUw9zRUI
	 NIZOOdDQ6v5I/rDjKQ7467JCfC3LMMVq4XFXXyRfkV4zYnxz3/6003sn3NY+tAcZBf
	 dvEn2+PEQwJFqLBOvdJsr+SVKy2RL4j0c4KozOhLCdvQTDMsLLoZa65jYcAXChstSI
	 In3D4RBQwSUbpx0jN5iYVMlV8780yRp6hS6ZI6cgNx8JWHlq/7QZBUDaeinasRoCzG
	 GRaYcxaCDRd7CTaYziAwulgLexmmXEm95nQnw4O2kKTjcGG9IdabvWCcvyKQq9okmQ
	 nShTo23c+dSbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: disallow file locking and delegations for NFSv4 reexport
Date: Sun,  6 Sep 2026 11:57:06 -0400
Message-ID: <20260906155707.1520411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090336-pleat-borough-58de@gregkh>
References: <2026090336-pleat-borough-58de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit 9254c8ae9b8172d9ad26e620a4bbc604a1efa7fa ]

We do not and cannot support file locking with NFS reexport over
NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
server reboot cannot allow clients to recover locks because the source
NFS server has not rebooted, and so it is not in grace.  Since the
source NFS server is not in grace, it cannot offer any guarantees that
the file won't have been changed between the locks getting lost and
any attempt to recover/reclaim them.  The same applies to delegations
and any associated locks, so disallow them too.

Clients are no longer allowed to get file locks or delegations from a
reexport server, any attempts will fail with operation not supported.

Update the "Reboot recovery" section accordingly in
Documentation/filesystems/nfs/reexport.rst

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 4683ca76b3b7 ("NFSD: Prevent client use-after-free during delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/nfs/reexport.rst | 10 ++-
 fs/nfs/export.c                            |  3 +-
 fs/nfsd/netns.h                            |  3 +
 fs/nfsd/nfs4state.c                        | 91 ++++++++++++++--------
 fs/nfsd/state.h                            |  2 +
 include/linux/exportfs.h                   |  1 +
 6 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
index ff9ae4a46530a..044be965d75e2 100644
--- a/Documentation/filesystems/nfs/reexport.rst
+++ b/Documentation/filesystems/nfs/reexport.rst
@@ -26,9 +26,13 @@ Reboot recovery
 ---------------
 
 The NFS protocol's normal reboot recovery mechanisms don't work for the
-case when the reexport server reboots.  Clients will lose any locks
-they held before the reboot, and further IO will result in errors.
-Closing and reopening files should clear the errors.
+case when the reexport server reboots because the source server has not
+rebooted, and so it is not in grace.  Since the source server is not in
+grace, it cannot offer any guarantees that the file won't have been
+changed between the locks getting lost and any attempt to recover them.
+The same applies to delegations and any associated locks.  Clients are
+not allowed to get file locks or delegations from a reexport server, any
+attempts will fail with operation not supported.
 
 Filehandle limits
 -----------------
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index aacf6220ab44e..4412c1a355007 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -168,5 +168,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
-		 EXPORT_OP_FLUSH_ON_CLOSE,
+		 EXPORT_OP_FLUSH_ON_CLOSE	|
+		 EXPORT_OP_NOLOCKS,
 };
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index be0c8f1ce4e3e..4ef41e18a7871 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -98,6 +98,9 @@ struct nfsd_net {
 	 */
 	struct list_head client_lru;
 	struct list_head close_lru;
+
+	/* protects del_recall_lru and delegation hash/unhash */
+	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
 	/* protected by blocked_locks_lock */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f390716ce3ffe..b3aa70adc9293 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -88,15 +88,6 @@ static void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 
-/* Locking: */
-
-/*
- * Currently used for the del_recall_lru and file hash table.  In an
- * effort to decrease the scope of the client_mutex, this spinlock may
- * eventually cover more:
- */
-static DEFINE_SPINLOCK(state_lock);
-
 enum nfsd4_st_mutex_lock_subclass {
 	OPEN_STATEID_MUTEX = 0,
 	LOCK_STATEID_MUTEX = 1,
@@ -1287,8 +1278,9 @@ nfs4_delegation_exists(struct nfs4_client *clp, struct nfs4_file *fp)
 {
 	struct nfs4_delegation *searchdp = NULL;
 	struct nfs4_client *searchclp = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	list_for_each_entry(searchdp, &fp->fi_delegations, dl_perfile) {
@@ -1317,8 +1309,9 @@ static int
 hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
@@ -1336,15 +1329,19 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char status)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 
 	if (!delegation_hashed(dp))
 		return false;
 
+	WARN_ON_ONCE(status != NFS4_CLOSED_DELEG_STID &&
+		     status != SC_STATUS_REVOKED);
 	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
@@ -1359,10 +1356,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 static void destroy_delegation(struct nfs4_delegation *dp)
 {
 	bool unhashed;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp);
-	spin_unlock(&state_lock);
+	spin_lock(&nn->deleg_lock);
+	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+	spin_unlock(&nn->deleg_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
 }
@@ -1378,9 +1377,10 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	if (clp->cl_minorversion) {
 		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
-		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
+	} else {
+		nfs4_put_stid(&dp->dl_stid);
 	}
 	destroy_unhashed_deleg(dp);
 }
@@ -2244,13 +2244,14 @@ __destroy_client(struct nfs4_client *clp)
 	struct list_head reaplist;
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp,
+						     NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
@@ -4888,12 +4889,12 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 	 * If the dl_time != 0, then we know that it has already been
 	 * queued for a lease break. Don't queue it again.
 	 */
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	if (delegation_hashed(dp) && dp->dl_time == 0) {
 		dp->dl_time = ktime_get_boottime_seconds();
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
@@ -5496,6 +5497,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 {
 	int status = 0;
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
@@ -5519,7 +5521,18 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		 */
 		return ERR_PTR(-EAGAIN);
 	}
-	spin_lock(&state_lock);
+
+	/*
+	 * File delegations and associated locks cannot be recovered if the
+	 * export is from an NFS proxy server.
+	 */
+	if (nf->nf_file->f_path.mnt->mnt_sb->s_export_op->flags &
+	    EXPORT_OP_NOLOCKS) {
+		nfsd_file_put(nf);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
@@ -5534,7 +5547,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (nf)
 		nfsd_file_put(nf);
 	if (status)
@@ -5577,11 +5590,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		goto out_unlock;
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&fp->fi_lock);
 	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 
 	if (status)
 		goto out_unlock;
@@ -6203,15 +6216,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		refcount_inc(&dp->dl_stid.sc_count);
+		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
@@ -7531,6 +7545,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
+	if (cstate->current_fh.fh_dentry->d_sb->s_export_op->flags &
+	    EXPORT_OP_NOLOCKS) {
+		status = nfserr_notsupp;
+		goto out;
+	}
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -7862,6 +7881,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserr_lock_range;
 		goto put_stateid;
 	}
+	if (nf->nf_file->f_path.mnt->mnt_sb->s_export_op->flags &
+	    EXPORT_OP_NOLOCKS) {
+		status = nfserr_notsupp;
+		goto put_file;
+	}
+
 	file_lock = locks_alloc_lock();
 	if (!file_lock) {
 		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
@@ -8183,6 +8208,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->client_lru);
 	INIT_LIST_HEAD(&nn->close_lru);
 	INIT_LIST_HEAD(&nn->del_recall_lru);
+	spin_lock_init(&nn->deleg_lock);
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
@@ -8311,13 +8337,14 @@ nfs4_state_shutdown_net(struct net *net)
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp,
+						     NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 53298bdcfb3d0..46ed4077fd89a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -97,6 +97,8 @@ struct nfs4_stid {
 #define NFS4_REVOKED_DELEG_STID 16
 #define NFS4_CLOSED_DELEG_STID 32
 #define NFS4_LAYOUT_STID 64
+/* Selector for unhashing a delegation that is about to be revoked. */
+#define SC_STATUS_REVOKED NFS4_REVOKED_DELEG_STID
 	struct list_head	sc_cp_list;
 	unsigned char		sc_type;
 	stateid_t		sc_stateid;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 218fc5c54e901..45916f1deff62 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -222,6 +222,7 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
+#define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
 	unsigned long	flags;
 };
 
-- 
2.53.0


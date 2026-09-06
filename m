Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94F5474E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704814; cv=none; b=ouFm7/XqoAKAulR8qrBbyXpXwb3C4TkWuI9vXVF6ZwX5UNlm7flqlfp0InoxezI0MU58b60YgFn+8q3ccmFwQtp3BXN+aO4QlTao75WVlqlxy9z3Vp9K9bqnven5wTKuEYikuPLWQjP+5mZsLj0eAeu0JcUppxQHaLdvxDmV/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704814; c=relaxed/simple;
	bh=4y8gfyUZmEomIeC81uu+gKLLIOFybI0cs5Qr1/3ZUG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txaMBA374T16c5ZxF+SdP+369z+Y+Wn6VCb8deZ2txAbGlGa68afbG/7Jo+XfscaCU9COdrd1oWd/8/rBcc8bww8wrVrA5jrEDQiFJeL9X2fjK6KJSIVoEmRdKYeKmaqOpOZflw+VzydlfeGFhgbGTdMAA1A4GTaaTUruXvrMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixpwonfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixpwonfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3041F00A3A;
	Sun,  6 Sep 2026 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788704809;
	bh=XOcTkiE6vxU7Z1rqpj6sD0jYvFQk5zbJn1SIxR3qNXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ixpwonfx3JOHI2HvB9XPo88PO7BaKBavKwnwWywmzfn2zuLSSCgTi2etNqZ1EvCoV
	 VzxE9DGFsc6Dn97z3jQ7nB1IAg+xFPRUd03Nj8rcfGuRoKGrYBtTeQFe+Hu6tjje1w
	 kk9+4tXadcZP+wkzZ/wCqGnpVRyAJzT3JSwfHmX+UXRJwhD9CUByU7ZcBZXu7E9hIF
	 0KgpOBbGgTbDwZdegTtu8U2TdLyrr+IWq9C1HuhjqrHOrGlRrwtq5qCMMjEliCwyBT
	 PjBZDWBuXxblcCi/ZKHl9rSHP+LK7mOhV/IlcQvQCI483S5ZYAYF7gX6GHKTycKXgh
	 fPwjm2JOOUD9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfsd: disallow file locking and delegations for NFSv4 reexport
Date: Sun,  6 Sep 2026 10:26:46 -0400
Message-ID: <20260906142647.1164860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090335-cramp-chemist-3707@gregkh>
References: <2026090335-cramp-chemist-3707@gregkh>
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
 fs/nfsd/nfs4state.c                        | 88 ++++++++++++++--------
 fs/nfsd/state.h                            |  1 +
 include/linux/exportfs.h                   |  1 +
 6 files changed, 70 insertions(+), 36 deletions(-)

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
index aeb17adcb2b64..a10dd5f9d0786 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -161,5 +161,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
-		 EXPORT_OP_FLUSH_ON_CLOSE,
+		 EXPORT_OP_FLUSH_ON_CLOSE	|
+		 EXPORT_OP_NOLOCKS,
 };
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0ecc5527a8f1a..6c01623ee8a3f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -99,6 +99,9 @@ struct nfsd_net {
 	 */
 	struct list_head client_lru;
 	struct list_head close_lru;
+
+	/* protects del_recall_lru and delegation hash/unhash */
+	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
 	/* protected by blocked_locks_lock */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..f48597aa3d21d 100644
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
@@ -1284,8 +1275,9 @@ nfs4_delegation_exists(struct nfs4_client *clp, struct nfs4_file *fp)
 {
 	struct nfs4_delegation *searchdp = NULL;
 	struct nfs4_client *searchclp = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	list_for_each_entry(searchdp, &fp->fi_delegations, dl_perfile) {
@@ -1314,8 +1306,9 @@ static int
 hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
@@ -1333,16 +1326,18 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 
 	if (!delegation_hashed(dp))
 		return false;
 
-	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
+	dp->dl_stid.sc_type = type;
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1356,10 +1351,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
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
@@ -1380,6 +1377,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 		spin_unlock(&clp->cl_lock);
 	}
 	destroy_unhashed_deleg(dp);
+	nfs4_put_stid(&dp->dl_stid);
 }
 
 /* 
@@ -2241,13 +2239,14 @@ __destroy_client(struct nfs4_client *clp)
 	struct list_head reaplist;
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp,
+						NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
@@ -4885,12 +4884,12 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
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
@@ -5493,6 +5492,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 {
 	int status = 0;
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
@@ -5537,7 +5537,17 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!nf)
 		return ERR_PTR(-EAGAIN);
 
-	spin_lock(&state_lock);
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
@@ -5552,7 +5562,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (nf)
 		nfsd_file_put(nf);
 	if (status)
@@ -5595,11 +5605,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6245,15 +6255,16 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -7597,6 +7608,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -7928,6 +7944,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -8242,6 +8264,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
+	spin_lock_init(&nn->deleg_lock);
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
@@ -8377,13 +8400,14 @@ nfs4_state_shutdown_net(struct net *net)
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp,
+						NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d1450fe7e2b90..3a2ea18286857 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -96,6 +96,7 @@ struct nfs4_stid {
 /* For a deleg stateid kept around only to process free_stateid's: */
 #define NFS4_REVOKED_DELEG_STID 16
 #define NFS4_CLOSED_DELEG_STID 32
+#define SC_STATUS_REVOKED NFS4_CLOSED_DELEG_STID
 #define NFS4_LAYOUT_STID 64
 	struct list_head	sc_cp_list;
 	unsigned char		sc_type;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 11fbd0ee13708..8ec2f1082169e 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -224,6 +224,7 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
+#define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
 	unsigned long	flags;
 };
 
-- 
2.53.0


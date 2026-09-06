Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0213CFF4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701327; cv=none; b=ZMoQehVqfM4h1JYVEsPcjEv8n5uz7t4zfLP3reoDQ9aCI6Mk0Bjsgdtk4RALmGsypKaJDOcfo1epSpPz4b3DJVeno/Q9wGMTObd8bEQD4wLclaT3O9MlwTdDGZoFzPpPToyIKR+7nTNBnNudoxdKCoJwPuY5FAtl8kpMYnhyB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701327; c=relaxed/simple;
	bh=HGE2CaBN6Okk0yipG0Zanz/69OXSXOcSE3ycsHT4Jmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2bpzsPQ9V5qB8zO6X32ff35LUSOXZ4PMd9db3kLDr4EgA8P9YJpB/bG0+Uz268Gu/zl2VQKza+g5DOqnvrE3F9aP9eQ+Mngep0koKHxtx3RWjxQxqZ00NqrsdxKgDjz/WxF5XWMzuI1WnadBPQ59rq55uwoMQmjR4L1nA5Sv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Gp3qzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Gp3qzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C31F00A3A;
	Sun,  6 Sep 2026 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701324;
	bh=HdrJNPByI6xymZTmEm+2kZjNadzdFOHrvREJ6tUJoGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7Gp3qzYEkqLDS+XuJCsAKsikJqt1h6I7k5wdXeNL14aSF0MnwbAm7aLsoBPU2ELX
	 1iSkauzUsV9pC2xsELv9MgFvUjphgrW7Ft8qzTUzNpNnbWYOF538DSu9WtmUsk7QdZ
	 EmJA07ulBi+x5UAnPI4QfQL05Kz9rJio3FojHtMNyK3bWbVjhLpGgnydoY86hoVEly
	 Po6h4hgKH8lH8VAvAG5o8MRAmhH3tXW0c2lyCE4zYp8je6uRtEHgP/vmb5E7Hv7no/
	 kpGOS9krtq2tP+oTpBidSIRAmjKu0tcst3MUg9coybNM/UHcgKIWcHBURk2VxwC11l
	 6j37bKWpT3FgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nfsd: disallow file locking and delegations for NFSv4 reexport
Date: Sun,  6 Sep 2026 09:28:41 -0400
Message-ID: <20260906132842.874935-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090335-putt-designate-4c42@gregkh>
References: <2026090335-putt-designate-4c42@gregkh>
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
 fs/nfsd/nfs4state.c                        | 75 ++++++++++++++--------
 fs/nfsd/state.h                            |  2 +-
 include/linux/exportfs.h                   |  1 +
 6 files changed, 61 insertions(+), 33 deletions(-)

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
index 09a06e46dab98..e9c95c8ce80d3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -100,6 +100,9 @@ struct nfsd_net {
 	 */
 	struct list_head client_lru;
 	struct list_head close_lru;
+
+	/* protects del_recall_lru and delegation hash/unhash */
+	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
 	/* protected by blocked_locks_lock */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 342de8d2c4aa8..0d05196441d06 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -89,15 +89,6 @@ static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_stat
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
 
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
@@ -1278,8 +1269,9 @@ nfs4_delegation_exists(struct nfs4_client *clp, struct nfs4_file *fp)
 {
 	struct nfs4_delegation *searchdp = NULL;
 	struct nfs4_client *searchclp = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	list_for_each_entry(searchdp, &fp->fi_delegations, dl_perfile) {
@@ -1308,8 +1300,9 @@ static int
 hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 	lockdep_assert_held(&clp->cl_lock);
 
@@ -1331,8 +1324,10 @@ static bool
 unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 
 	if (!delegation_hashed(dp))
 		return false;
@@ -1357,10 +1352,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 static void destroy_delegation(struct nfs4_delegation *dp)
 {
 	bool unhashed;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
 }
@@ -1827,11 +1824,11 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					refcount_inc(&stid->sc_count);
 					dp = delegstateid(stid);
-					spin_lock(&state_lock);
+					spin_lock(&nn->deleg_lock);
 					if (!unhash_delegation_locked(
 						    dp, SC_STATUS_ADMIN_REVOKED))
 						dp = NULL;
-					spin_unlock(&state_lock);
+					spin_unlock(&nn->deleg_lock);
 					if (dp)
 						revoke_delegation(dp);
 					else
@@ -2428,13 +2425,13 @@ __destroy_client(struct nfs4_client *clp)
 	struct nfs4_delegation *dp;
 	LIST_HEAD(reaplist);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
 		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
@@ -5254,12 +5251,12 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
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
@@ -5856,6 +5853,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 {
 	int status = 0;
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
@@ -5900,7 +5898,17 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -5915,7 +5923,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (nf)
 		nfsd_file_put(nf);
 	if (status)
@@ -5959,13 +5967,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		goto out_unlock;
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&clp->cl_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 
 	if (status)
 		goto out_unlock;
@@ -6673,7 +6681,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 
 	nfs40_clean_admin_revoked(nn, &lt);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
@@ -6682,7 +6690,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
@@ -8056,6 +8064,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status != nfs_ok)
 		return status;
 	sb = cstate->current_fh.fh_dentry->d_sb;
+	if (sb->s_export_op->flags & EXPORT_OP_NOLOCKS) {
+		status = nfserr_notsupp;
+		goto out;
+	}
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -8406,6 +8418,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -8727,6 +8745,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->client_lru);
 	INIT_LIST_HEAD(&nn->close_lru);
 	INIT_LIST_HEAD(&nn->del_recall_lru);
+	spin_lock_init(&nn->deleg_lock);
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
@@ -8853,13 +8872,13 @@ nfs4_state_shutdown_net(struct net *net)
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 5b3a4473ed0ac..9258b37a5e5fa 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -101,7 +101,7 @@ struct nfs4_stid {
 #define SC_TYPE_LAYOUT		BIT(3)
 	unsigned short		sc_type;
 
-/* state_lock protects sc_status for delegation stateids.
+/* nn->deleg_lock protects sc_status for delegation stateids.
  * ->cl_lock protects sc_status for open and lock stateids.
  * ->st_mutex also protect sc_status for open stateids.
  * ->ls_lock protects sc_status for layout stateids.
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c4..0ac405f884859 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -247,6 +247,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_NOLOCKS		(0x80) /* no file locking support */
 	unsigned long	flags;
 };
 
-- 
2.53.0


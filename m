Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF235A397
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660828; cv=none; b=IWX6m238kpP5YmVdOSWp1EtdIHBUO8s0fv2/7ku3VVrLIpFIb8mkKbsfn4dkgaxqyoQ/i8runUeSgeg1cw+oxtq3WevxXqVmXmWPYFp5V112rvaznjsktgSwIWyp3tQFiqvAu+m6nuw889v4PMSac8yIVMJ82jM0sQ1zEpTI3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660828; c=relaxed/simple;
	bh=xT5gu7uWxIO9952uTt/8OODAPewAdlFLGfb4DQs0zTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9rvmNjngFkI2ABOIptOUgt7yTsPHvIG4jmiVIq+lo8kVlOEkZV5OOW/xnaWnC92JukBt99No/gvOvw2q1zCR6P6XUjezJtmr/hIS1yHAHmg2IW370AdvcnBae3dFoaH6leRs0UI/JFlRxxiFKztdhy9wKPZ+a87YFkPAGnJ7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnHVMSPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnHVMSPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD201F00A3A;
	Sun,  6 Sep 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660815;
	bh=kWv7JRJjMUDQ0J+WqnNbAoqrVhArz5+Q7NBSoNh4UFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnHVMSPE72YHQZZ6QNfK8KFZrYD0hIXMy+L/8nKqn2drN3w0W1Xy8Kx9jaUXAT7Fu
	 QQe75ArEc7FOIkVQXbTikpkbgC6ce8yKm2oco/YWJK/LtV2hW/zEX+GqIEaTFFF5yA
	 RtrcaXhQQgo5psxR/CG7rOF7DFlVn0ol9Sa95XbKBYcbqGOJyaXhqDcy0+P449DlUN
	 bHn53IYlsnuGTKbg6SMZ0fK04G8G5MtS4aiKovQ7Ncs5W0GoBPcsLqWvPOoDdeG+9y
	 VHucLSQoBTE6qX26JHTtFuiUq691bnfulBrOL1RANB8Y9cuGlFvszozP4YGid5Ai0C
	 IIS9cAkZkOliQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nfsd: convert global state_lock to per-net deleg_lock
Date: Sat,  5 Sep 2026 22:13:32 -0400
Message-ID: <20260906021333.761242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090334-islamic-borrowing-13a1@gregkh>
References: <2026090334-islamic-borrowing-13a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 8be12e0cf21110f1e0b7fd21711ff13fb75bee72 ]

Replace the global state_lock spinlock with a per-nfsd_net deleg_lock.
The state_lock was only used to protect delegation lifecycle operations
(the del_recall_lru list and delegation hash/unhash), all of which are
scoped to a single network namespace. Making the lock per-net removes
a source of unnecessary contention between containers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 4683ca76b3b7 ("NFSD: Prevent client use-after-free during delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 53 +++++++++++++++++++++++----------------------
 fs/nfsd/state.h     |  2 +-
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fe8338735e7cc..db1b0c8f9c7ba 100644
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
index c9d9a7d46e7b2..6561460f27f9c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -91,13 +91,6 @@ static void deleg_reaper(struct nfsd_net *nn);
 
 /* Locking: */
 
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
@@ -1279,8 +1272,9 @@ nfs4_delegation_exists(struct nfs4_client *clp, struct nfs4_file *fp)
 {
 	struct nfs4_delegation *searchdp = NULL;
 	struct nfs4_client *searchclp = NULL;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 
 	list_for_each_entry(searchdp, &fp->fi_delegations, dl_perfile) {
@@ -1309,8 +1303,9 @@ static int
 hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 	lockdep_assert_held(&fp->fi_lock);
 	lockdep_assert_held(&clp->cl_lock);
 
@@ -1332,8 +1327,10 @@ static bool
 unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
+					  nfsd_net_id);
 
-	lockdep_assert_held(&state_lock);
+	lockdep_assert_held(&nn->deleg_lock);
 
 	if (!delegation_hashed(dp))
 		return false;
@@ -1358,10 +1355,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
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
@@ -1829,11 +1828,11 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
@@ -2499,13 +2498,13 @@ __destroy_client(struct nfs4_client *clp)
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
@@ -5443,12 +5442,12 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
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
@@ -6060,6 +6059,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 {
 	bool deleg_ts = nfsd4_want_deleg_timestamps(open);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
@@ -6119,7 +6119,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
@@ -6134,7 +6134,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	} else
 		fp->fi_delegees++;
 	spin_unlock(&fp->fi_lock);
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	if (nf)
 		nfsd_file_put(nf);
 	if (status)
@@ -6178,13 +6178,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6964,7 +6964,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 
 	nfs40_clean_admin_revoked(nn, &lt);
 
-	spin_lock(&state_lock);
+	spin_lock(&nn->deleg_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
@@ -6973,7 +6973,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
+	spin_unlock(&nn->deleg_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
@@ -9001,6 +9001,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->client_lru);
 	INIT_LIST_HEAD(&nn->close_lru);
 	INIT_LIST_HEAD(&nn->del_recall_lru);
+	spin_lock_init(&nn->deleg_lock);
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
@@ -9135,13 +9136,13 @@ nfs4_state_shutdown_net(struct net *net)
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
index 2eed2c5b3cd0c..6e926b2a9b6a9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -123,7 +123,7 @@ struct nfs4_stid {
 #define SC_TYPE_LAYOUT		BIT(3)
 	unsigned short		sc_type;
 
-/* state_lock protects sc_status for delegation stateids.
+/* nn->deleg_lock protects sc_status for delegation stateids.
  * ->cl_lock protects sc_status for open and lock stateids.
  * ->st_mutex also protect sc_status for open stateids.
  * ->ls_lock protects sc_status for layout stateids.
-- 
2.53.0


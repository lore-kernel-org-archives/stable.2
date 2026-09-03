Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE064AF9D0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443165; cv=none; b=GADp9xxaHCAsuZK7vwlxjuhl99LHUzQKsTLFMCoo8CG8nhUFIU3AGVCPd1jk6HfF9qlEOeFYPUdDjAFGZRuuu//U1MHuqRfSRswk2pxR2v1Whe9C0/4TyZqwCghW0kYV2e95523z5ZP2kkazmSadcgr+Yurv+SrISd4dEMGAjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443165; c=relaxed/simple;
	bh=2vQ2swQylbFcPS0rRoPeU7NJvjEPdOOgL1ypyrVh6ug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XDFrnQrr3sg0AV8oqoTzg7VeCSBxGYNrA0Fei0iB9mEKWGhYqNdV9Nkg/K+lXjCXF/x0MAuyG98LqkhSK/gcBm+k9JcV3Furvw7Sci3L6ZL6OPvIyLhhUZEgjIjFhXCjOET0wbenKyRDd8/rziGjQGqvMMLJ4mVQQMzFGSdGiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiC32Jt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fiC32Jt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB31F00A3E;
	Thu,  3 Sep 2026 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443149;
	bh=tygQlgPWDZymoOTin6QQDsm5IjSzAg4aph+IkKcibYw=;
	h=Subject:To:Cc:From:Date;
	b=fiC32Jt99/QSitnt2g4vR4i51kWKBY9vAQpbm3RZaY1NpUwJiiJUwM8T9gkr6d6W9
	 6ESlGdjJ2ICkD2xvJJ+wi0SMrEroxnZG2B1ZbriVYPjHDJ12uxwTt2Aza6TMoZOVy4
	 XPfkqnmvwwpVPTTI3Qdr4h4ZHMMIGSshgK8HvW/c=
Subject: FAILED: patch "[PATCH] NFSD: Prevent client use-after-free during delegation revoke" failed to apply to 6.6-stable tree
To: cel@kernel.org,jlayton@kernel.org,neil@brown.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:20:35 +0200
Message-ID: <2026090335-cramp-chemist-3707@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4683ca76b3b7e5808338491c6eb3c20e6b4894d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090335-cramp-chemist-3707@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4683ca76b3b7e5808338491c6eb3c20e6b4894d5 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Thu, 9 Jul 2026 13:40:25 -0400
Subject: [PATCH] NFSD: Prevent client use-after-free during delegation revoke

A delegation stateid holds only a bare pointer to its owning
nfs4_client and does not keep it alive.  The client survives its
stateids only because __destroy_client() drains cl_delegations and
cl_revoked before free_client() runs.

nfs4_laundromat() breaks that invariant: it unhashes an
expired delegation from cl_delegations, drops deleg_lock, then
revoke_delegation() relinks it onto cl_revoked under cl_lock.  In that
window the delegation is on neither list, so client_has_state() can
report no remaining state.

Every teardown path first requires cl_rpc_users to be zero, but
the laundromat holds no such reference.  A client whose recalled
delegation has just timed out can therefore reach free_client()
while revoke_delegation() is still about to dereference cl_lock,
a use-after-free.

Pin the client with cl_rpc_users across the revoke so teardown blocks
until it completes, then reap the delegation from cl_revoked.  A client
already expiring reaps its own, so skip it and leave the delegation on
del_recall_lru.

Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-2-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 03724bef10a7..a7bd7b67fa4f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -115,7 +115,8 @@ struct nfsd_net {
 	struct list_head client_lru;
 	struct list_head close_lru;
 
-	/* protects del_recall_lru and delegation hash/unhash */
+	/* protects del_recall_lru and delegation hash/unhash;
+	 * nests outside client_lock */
 	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
@@ -124,7 +125,8 @@ struct nfsd_net {
 
 	struct delayed_work laundromat_work;
 
-	/* client_lock protects the client lru list and session hash table */
+	/* client_lock protects the client lru list and session hash
+	 * table; nests inside deleg_lock */
 	spinlock_t client_lock;
 
 	/* protects blocked_locks_lru */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e000ed3e96e9..efeb2a2e9c8f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7457,6 +7457,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -7485,6 +7486,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		clp = dp->dl_stid.sc_client;
+		spin_lock(&nn->client_lock);
+		if (is_client_expired(clp)) {
+			spin_unlock(&nn->client_lock);
+			continue;
+		}
+		/*
+		 * Pin without reviving: get_client_locked() would
+		 * flip a courtesy client back to NFSD4_ACTIVE.
+		 */
+		atomic_inc(&clp->cl_rpc_users);
+		spin_unlock(&nn->client_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
@@ -7493,8 +7506,18 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
+		clp = dp->dl_stid.sc_client;
 		list_del_init(&dp->dl_recall_lru);
 		revoke_delegation(dp);
+		/*
+		 * Unpin without renewing: put_client_renew() would
+		 * renew the reaped client's lease.
+		 */
+		if (atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock)) {
+			if (is_client_expired(clp))
+				wake_up_all(&expiry_wq);
+			spin_unlock(&nn->client_lock);
+		}
 	}
 
 	spin_lock(&nn->client_lock);


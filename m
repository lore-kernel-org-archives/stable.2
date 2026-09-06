Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC46265621
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713282; cv=none; b=T3X+X983VdgrKAanunXStU0HEtWuDlS2I4AQfGfUJQLLGYRo5Ohzzxk00SZP2q9Q+Qc7QzL7ASGk4jYoePpKpL+qylRSA9xtHZoZvUf0+J+JvDBKgA7ADBik8mKZBQwMLQyznac6GXvRUPoprrhgCIV0h/hjO08G/KexR397pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713282; c=relaxed/simple;
	bh=68LIWo6duEVskPGdXzxa2A7dooyOmcPg0fViPsKT0Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvAKlghakabyMuRhVgHzi14ofO2ngClsSKPHqZpuV1PGzhHHRzQ5ZBSaZqMZq89CncX9CFOh0uYFA9YxLJC0EDXvXjIj0KOeJEuVibmYCSk6VcxRF3c5x9K1FOA5IqE7BkGSz5DFE1U6rewEHQYJUA5XRxMiONY/DTynpH6+mgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3B5z37O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3B5z37O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146381F00A3D;
	Sun,  6 Sep 2026 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788713280;
	bh=Ict4mDnLucsGrROoyvOaSMzjHDkXLIhyqH1OX2AhBQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3B5z37OvAvU/8G2WKHbr52W2JWHazCsb5GEq9WH5RRz0UBVuenhp8rIkfq8q9f7k
	 soHirabymUCmmAXVVE2Ocj1A5iUHK3TNrjWz0AQ+gXJ2b68DSoWb1h5Mb/qZ7KfsRC
	 YbJL9tr5/G8lg1dvXdprMTB1Tvi9RypHweZukMG37x50OY7eDZnXdmCQcLPGMw9ajW
	 ZX6SMclJ2INwXZ9jud34nMHD+Gx6TKUcw5+zZKsevkufadw8+9v38sjDa8IWQz8Dvf
	 EUyROn/XyiFm5+ohpRNVzdgp2Mcs90417NoysoDqdyKgYbPGQLe4SqBV8pehMl0Fuw
	 XehNTW85QKXtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] NFSD: Prevent client use-after-free during delegation revoke
Date: Sun,  6 Sep 2026 12:47:57 -0400
Message-ID: <20260906164757.1617855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906164757.1617855-1-sashal@kernel.org>
References: <2026090337-handwork-power-a1b4@gregkh>
 <20260906164757.1617855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 4683ca76b3b7e5808338491c6eb3c20e6b4894d5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h     |  6 ++++--
 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 4ef41e18a7871..d4aff2b4eb7ad 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -99,7 +99,8 @@ struct nfsd_net {
 	struct list_head client_lru;
 	struct list_head close_lru;
 
-	/* protects del_recall_lru and delegation hash/unhash */
+	/* protects del_recall_lru and delegation hash/unhash;
+	 * nests outside client_lock */
 	spinlock_t deleg_lock ____cacheline_aligned;
 	struct list_head del_recall_lru;
 
@@ -108,7 +109,8 @@ struct nfsd_net {
 
 	struct delayed_work laundromat_work;
 
-	/* client_lock protects the client lru list and session hash table */
+	/* client_lock protects the client lru list and session hash
+	 * table; nests inside deleg_lock */
 	spinlock_t client_lock;
 
 	/* protects blocked_locks_lru */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a167e7861d2ea..16ceaa541d8d8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6189,6 +6189,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6214,6 +6215,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6222,8 +6235,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
-- 
2.53.0


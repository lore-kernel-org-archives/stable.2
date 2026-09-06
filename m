Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5C31F985
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712514; cv=none; b=SqbBetvABAGV+4PqWsv5P9wNcUINAfobqFL58tbhExzO2W+y7yGgjTMyN4AC0qbUIwLDxR31+F8qqAVkxmQyqV28A2hnhYwxp0hEUL1rsnHroaZ1xizJ+esRxbH+DYJOalzEkQsqms1HpxuC3kvhPpgzLBrBV5yvXGE77Pp5oXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712514; c=relaxed/simple;
	bh=3FmXc6t/U3V2N5s+/zwRWMpTWqXSgA2JGgSGaFP8eUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuglCI47HnC5Xga2aoR/Ok5rHxlxPprlXJUDjg5zaZNxmNiknv8Prt4aObBNz7IRLAcbt5yNNCVrEYGOU8/r9GcI1VVecZE+OWqS+2fkoMbHlCzPoFeGIDKAex+Gk0dc+MWK3WO1FxAVo9oHa3HnbPIi0ow12EqNN6FkzZz7RWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBbD8iUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBbD8iUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D951F00A3D;
	Sun,  6 Sep 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788712513;
	bh=dbXLQxhOaMkB7cmxZP4YUeezYSQl+dGzx9HX7xAV8jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBbD8iUyyUYv8WI7oYU/RcUdP30Ocvps8CcEB3HKUaMJl4iwDFsld2SrEEsRqUXVo
	 KC0aoJfo6ynuVJY4A11jG8KjnRaZZLBvZxixpH5fPxoc7Dfosq+wmGCvgdud3qv9tq
	 eHqlUnPowdZaEODESvXDtO7sIV3DchgEjach6OKerdsWR0fzT/f6TD2q6gJhco+B/Y
	 84TrKs3SQ4iv2+AbbGq6R4SmLGiUMCnmml/oEiOxp5ULICVJJDtkq2466trPtYDVxN
	 z1uhhfXLxQKnX3rVzrhajjyp0vxnshOrGH+4a5jD8Z7x2LDrJQCnMWPtBGt+qnA0FN
	 Y9ozV72A+cE8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] NFSD: Prevent client use-after-free during delegation revoke
Date: Sun,  6 Sep 2026 12:35:10 -0400
Message-ID: <20260906163510.1599947-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906163510.1599947-1-sashal@kernel.org>
References: <2026090336-purplish-snowfall-6629@gregkh>
 <20260906163510.1599947-1-sashal@kernel.org>
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
index ddbe4bc1dd85c..4964b1d082a80 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6193,6 +6193,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6218,6 +6219,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6226,8 +6239,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


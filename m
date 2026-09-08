Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879624DCF6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828891; cv=none; b=nddbXAT6mhBXCnMt5ONfY1Bmbvk3ZiHbgAN3T+nYJqJoPne0Q09TzAbebew+k5Ozr7AKh+Gv3mXuEjLt0c8G9WvgY057s2IGP5te76vC9QePPm3I2VXn4fRlRHj6a5t52G+HGBg+9W7j9VrZR6kpzoo7yuhQqBMMcokeG/WPxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828891; c=relaxed/simple;
	bh=2jnrgt9I1b1JXAsnAKnwwZ4I+jZTKl0++kGsldXDZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuRkADZqoFrK2PXDyLwTVk9Z/tgmtMNVwWogUhGxCTEhqjkjrIYQovwu+HJlVUq2rDHb9ujlySJyVEbBJEEnlyHHKe3B8tfwJ1+ACkQMk71EURr311tt93CoQmfJ3zfWamo8UHSskFC7I24Zh5wcaUJVwPMUrmwHivvYQPcXbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxpZMUyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxpZMUyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDA71F00A3A;
	Tue,  8 Sep 2026 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828890;
	bh=6x5i0RaVbqX/q6P1TYzCREgkz9uiDDfg0SXbJAIE0W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PxpZMUySVv+lwT513dpY4qMcEhurJ3rVPfGGD4ZYzhxcbioKJdDxdzjPE4wmR+UMX
	 RK4BA2MjW96k62sDBhfBqX5QNWEeBBoLZR7iqUgMTOoZ826A1CujDNsDfmdKvmoj7c
	 +sfKk20/3HM0tPdgBYhlO98C4lg8j6tjzNGqfjnxZNH6ilU7BE8WoAh4k1GctoSh+l
	 zLqMXNrR8Udp+pbc3rQicmYTX5eMT2/xe+Vtu2BZzbBr+Ist16l2mN0gvW+lK35sYv
	 YTwz4wIGg18B5NyKw2VCImDjdzNqppW6PpOtHg6LrxLvZc/vTEZxrSIrbnQdJqOisp
	 PZv5ixM0bQ2Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 20:54:46 -0400
Message-ID: <20260908005448.1655398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-bazooka-pelvis-c71d@gregkh>
References: <2026090332-bazooka-pelvis-c71d@gregkh>
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
Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h     |  3 ++-
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index be0c8f1ce4e3e..ad457a1b48157 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -105,7 +105,8 @@ struct nfsd_net {
 
 	struct delayed_work laundromat_work;
 
-	/* client_lock protects the client lru list and session hash table */
+	/* client_lock protects the client lru list and session hash
+	 * table; nests inside state_lock */
 	spinlock_t client_lock;
 
 	/* protects blocked_locks_lru */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f390716ce3ffe..44afdb6179a65 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -91,9 +91,9 @@ static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 /* Locking: */
 
 /*
- * Currently used for the del_recall_lru and file hash table.  In an
- * effort to decrease the scope of the client_mutex, this spinlock may
- * eventually cover more:
+ * Currently used for the del_recall_lru and file hash table. It nests
+ * outside client_lock. In an effort to decrease the scope of the
+ * client_mutex, this spinlock may eventually cover more:
  */
 static DEFINE_SPINLOCK(state_lock);
 
@@ -6183,6 +6183,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6208,6 +6209,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
 		WARN_ON(!unhash_delegation_locked(dp));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
@@ -6215,8 +6228,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


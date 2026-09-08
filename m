Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA724BBEB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828894; cv=none; b=eiHLYBlC8b1NWb+CphFWhBzO/sRc4tgPCe9gUG4HrtrvVrP8Szh1fCu1RY6jCW0bAmWb4eOe39k7tS5oa2wnVpbwxB3RuHSpYTy/7ogh2pkHyYpsOHDEMjlP1/ZrDKHN0lWl0ZfIpayQQtfugSSC6kB5juYhpkPjQgIAGEBM5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828894; c=relaxed/simple;
	bh=c2QVIfNYimP5+ZTID8Jx8NvnQPos04cNqX49oxuHhb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heLCRY0FwR6ePqyMRyY4TPpdbYS55LoG70ACmh5Ln+ZB2bTGQc4BTwObJe/kVd/ZICqKzkx3YELRNd++ZUoEIxU6oe7lNQERyvu4A9I1uQ/yxpIpDQ4HxJpwmSKQvTxmsJhSYBx1KqT4GKmNnBymrkJDCZHK6HqlsSAR8ro0Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj7w5x/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj7w5x/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8774A1F00A3A;
	Tue,  8 Sep 2026 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828893;
	bh=qgv1ddCC4VOLJVWaOHax2Z8OLQiolv/PgOD5fuzV4uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oj7w5x/PrroKMPNm5rhfiBCUrL1lEFVDFHffkCZwbHctDxj9t23RfZtR5iYQxFyWL
	 dg32PAtld/HNtToXVPLmlN96R/73vz+oLvdX5qWd0e0Db0GxNAeDBWGmGPgIKELo6C
	 doXuRNXfCm93CZKl9lqQ05WW5L/gy6Pb9uq/0fFhAySiILbQ7PeEsUYloRDCeVP8Sv
	 7HZztyZ/dxoOY1qQ7vVasuGc5bz0glDleVGSiPNDbafCDhbYnt2nCbrLgnQJrwVflD
	 9+YyL7jdfNOR/UlT/Hvn2aFmPuqCXJuoxSqhkNPXX6Bi1NBJFk+Fe+CQPL7xQTr2Xh
	 TBtSOLKWkKbGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 20:54:48 -0400
Message-ID: <20260908005450.1655525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090306-arrival-oblong-578e@gregkh>
References: <2026090306-arrival-oblong-578e@gregkh>
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

[ sashal: Reduced backport -- upstream 4683ca76b3b7e touches 2 file(s), this
  backport carries 1. Not backported here:
  fs/nfsd/netns.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2330b788d732 ("NFSD: Prevent client use-after-free during close_lru reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f390716ce3ffe..11a509d2905f5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -93,7 +93,7 @@ static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 /*
  * Currently used for the del_recall_lru and file hash table.  In an
  * effort to decrease the scope of the client_mutex, this spinlock may
- * eventually cover more:
+ * eventually cover more. It nests outside client_lock:
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307403B28D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828366; cv=none; b=WIqrqfHC5erP+DbhbxQ7Fqp828w8fzZV6qvUj01DNG8spXe694JBR2BX8iRTseP2k/3d3NVrrMCJqvDaO6biWgTEXt7nN3V/49BLIUBBNrkzfwDWo/5fSG1Pe0y/Q34bJbW/9AzaeyH7RIh//oawc/FMGlxfmI2pxhpeFh3X6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828366; c=relaxed/simple;
	bh=09C3WXDVsh2VyvVqZv8c8gdRsHIo93rMG/TdlwVBi8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQIPR64Efd7rW//Ar4XAeUA4UjZGRBcxjF1CxnPQxzeg7ARQmv0vMCdwiHiKDxhMyxRy4EcSHgkVxcK2CS8fqueqQ3cVeEct21LIf3ZQESb+Gu5TcRxCEq9Ynp0hINd6UGTL17ii/Lx17uBnfm5dd8Kg5cYNkgnYVi/qGAOxNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXtQ8MxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXtQ8MxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC31F00A3A;
	Tue,  8 Sep 2026 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828364;
	bh=GiEYuCJoMPxJD+AKoSRlpWnZkb4gkU9+uw3W7cFwiTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXtQ8MxL9K3DY1/Yqirs11e2GILNU1DbSK1DosT1g+EVI6wcgWdFwYY9MzwZTfmFG
	 2k3RrROai40lchVsGBmdRU6eaBCDMeOh+dUVQjiVB7EGw9HiK1jZCYsdWLyiyYYcqn
	 i6xNBpK3cUyCA5KRtzQT7j77Em6KSpMOX1LAkoEAbRjc8X+Ye+mSsIJPoApmVV8vjk
	 pFU/6QMX0pLEBSRJ0lljVei8F77GVpAkNw6pr9ZnUqfVeX86/ueTb64yTF+D+nxGCE
	 /28qIbiilTGrwpYHREYJ5swvkKI6AkNNj09d/1yyS/aA/CmtWu5kO+hQ07FPsQwxHj
	 q7MxDk5m3eyFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 20:46:00 -0400
Message-ID: <20260908004602.1629619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-cardinal-sphere-4700@gregkh>
References: <2026090332-cardinal-sphere-4700@gregkh>
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
index 0ecc5527a8f1a..03c49e3af63e4 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -106,7 +106,8 @@ struct nfsd_net {
 
 	struct delayed_work laundromat_work;
 
-	/* client_lock protects the client lru list and session hash table */
+	/* client_lock protects the client lru list and session hash
+	 * table; nests inside state_lock */
 	spinlock_t client_lock;
 
 	/* protects blocked_locks_lru */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..0db50536a8765 100644
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
 
@@ -6225,6 +6225,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6250,6 +6251,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6257,8 +6270,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


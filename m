Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C6231C91
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829609; cv=none; b=s2H9u4It/6xqba0HI5NNeQhTFqFIbDfZ3169pWhRPD+g8A7+MZWoHIDstOc+MEJvvIFbMLh1X527Tr2SdxIez1tVf8nOXqonZwaS1hCWQIenWhvlxjQmQ/1DkzS8mMOo8jOiPmzBtoxRmyxCcHsvbBz1RJtxNW2lvJo6Y86LdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829609; c=relaxed/simple;
	bh=S3Pic/t94u/yXqrxEiiREVTwTXt6p/ybAbLTA0ehz3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5dvQsHe5nT9l6fzOmdRxfS0QqWks/wAyPaW8USBnMfEBNzZVbI1t6HWpq4Q82hcSMoZ4dM7F8uKXI1OoA2Sre+tk5LkSckVAf0uimWMBGx+E8jzCdQr/bXjHSx1cvcP2jsNryvQP1SsAcxW9zs7mC+QhSPf0jrDr1EQOtyWrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+hnnDd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+hnnDd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836851F00A3A;
	Tue,  8 Sep 2026 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829608;
	bh=C89bZmvN95lRlSCTARfV6DutgRDBtL5IBSHzeenwsU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+hnnDd509ztfkEZkU9kdEUGNW/8KEuS2fmvhOdmvPA280muEYjadIXqnVyjvzNti
	 l2itd4RmHZF+uPNxBIjzJZW0Q+mIJWYpISdLvTcHWWAetbuO5LInhsv00fPtfBOo+1
	 EZS+kJcs22nDugX/8pS74Z6zY0nqeqyeXSCPlPMjgz6+bCuqYYy+ib578bC0UZab2+
	 YQOdkD/m0e3r7PqxrtZYXTpd1YBCvOZWHxwDsYDg494Y/qXp0t/qVCHcv6owVjryPo
	 OH0gVFFL8hNVBLDZvl1FpkmxvAsVQ5Hnja1NLia7HbJmMDTFzm6ujqlbGxBYHbdebx
	 Stn26X+95YwxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 21:06:43 -0400
Message-ID: <20260908010645.1678749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-subdivide-jogger-d9a4@gregkh>
References: <2026090333-subdivide-jogger-d9a4@gregkh>
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
index c61e1a4ab620c..5ebf48de4cfce 100644
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
 
@@ -6180,6 +6180,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6205,6 +6206,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6212,8 +6225,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


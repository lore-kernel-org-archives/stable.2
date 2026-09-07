Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698E3B19BA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821970; cv=none; b=e2B16NaxAho7kHZbI4gaD5yhT6uUuOpCrjth+PmRSTQgs8kH6ZAZ8NKlXbSruFXM9HVxr+bMY0u3oOQ7UWQ0Z7vGZUzjUTCvlFeHowvYvns7MgP6ihUWhP0bS4nm/9Uo0ljkZTbgasGTg4PGgqwvkycWvJzMikqkhyAvZRoE1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821970; c=relaxed/simple;
	bh=wIa6/ZkiVvTmy4XAJrTKJYlaJE5lvk8aL12LxwOzHFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7/SwRHg/UNQgjPjdmcpLrnjkV69eTMVSIicr7VQ6Z+yEPy/u9hBM2C6DXzc8NvzMd23KfCOuB+dJb0uU/RpttnxOUlfEB+3z+9vG54O4grEAae5gC7bsKhIYqqkwTzf3ys4++7MXHjPTsOK7XEInXuQIr/tj3PQaS5HTw/3ZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioZs4NEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioZs4NEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67F81F00A3A;
	Mon,  7 Sep 2026 22:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821969;
	bh=ncjwgPE+NaXmfXkhI2Muh81b3HyRjYNTGDgYgX7oOKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ioZs4NEW5dtPen2uQRY/DosB1tUXtoG/1D8u04o1kY5xHpagdkJaQC3MRrS4ekzYZ
	 7WxPGyDwaa2gW2Jvu0JLaUupn0ZRjVbBVLReHlHN4bFUTTvg77zGweVh4d7HvPHD1h
	 g0tmxHE9nu/CasZIcRrmIfe41ZusYCJJsik50reifIyrrdwhAFAOtxWD1Zg0VjD7Ve
	 gj93dZre5OFU2r7tWJlKHlc3k5s+hg1H5gWLMQs+QHyNZkr1nMH5uqhXpmM6hr2LhF
	 5ykesi14s5l0j9k3iT9T1PROGyVXEHgZXs9AnquXH9JW5nCCahDgdiuCkDCTatz9Vx
	 b4woLIiASAxSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 18:59:24 -0400
Message-ID: <20260907225927.712336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-waking-garnish-23bc@gregkh>
References: <2026090304-waking-garnish-23bc@gregkh>
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
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 48715a55df8fa..1453f4769ab98 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -92,9 +92,9 @@ static void deleg_reaper(struct nfsd_net *nn);
 /* Locking: */
 
 /*
- * Currently used for the del_recall_lru and file hash table.  In an
- * effort to decrease the scope of the client_mutex, this spinlock may
- * eventually cover more:
+ * Currently used for the del_recall_lru and file hash table.  It nests
+ * outside client_lock.  In an effort to decrease the scope of the
+ * client_mutex, this spinlock may eventually cover more:
  */
 static DEFINE_SPINLOCK(state_lock);
 
@@ -7052,6 +7052,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -7080,6 +7081,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -7088,8 +7101,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


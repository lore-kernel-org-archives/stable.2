Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8043B19BA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821967; cv=none; b=UKqYYjYz/MNscM7LV0PXD0dO4YD2Sei1W07SQFu6tea3UbneDbbp5oxtO6gxxgKUSK5JfQrKtM2v8Go07UIjVQYv6HgiXo3/KtZSTGzN8UK1k3M3huBSbt/Cbue5JQQq3S/ta4GFVUqK2tUzwrBM9+dTodEXV3xni1NqlPsBzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821967; c=relaxed/simple;
	bh=5IFduWDpohVcFaWdE97zGa2YOAjVUqUE4+vNEelR94E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGPlODaqa0x8l6MaTLrkq6Zu++2OnRRqanLBM0LkCENBNByUCq4CdaolGUgINKA6uYam6jFEkVB8FvHqlfICIznR9e9N4dYBc+5eSOIoZX587V0kRMgCMfnvbTaxiXdwKSZnCp5Fcr+7AImBae7S8GGFF+ANIPkThqCI9l8eDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFrSca+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFrSca+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AB61F00A3A;
	Mon,  7 Sep 2026 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821965;
	bh=rGUvYrwWp4009/u/nQZL44xQ4EaDcYM3QH77qWwWr4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFrSca+i/ucs0AonkVh0+IGHRKRZffJ0ZqtSDEzcpCFy/53CwwxsTFTfa7+FgAJk3
	 SnrGPIxhrt9NcSE+CP7WGwzpRUg0CUrUjPymhR0FGFUpe8AxFBBFfTEq913xcl2LBl
	 wsG7OdVllaE9UEldKyP5Fn03qZuVrQ9/ez2Uw/iG1lwNNLQA4//k3BzED1yWtgiNEA
	 xiuEpLrsyT6W/k91mxQ+RPgooQJLP1csheRzSwmQ1VQ4xjDTIv6AUvapKde2NCAFZ3
	 h06Pfz+PmHgEgjiWRxCAUlZaeYyaSQHiFyT8g/qgZSZ0DtzLDsPuF8t1x81qvP2HL5
	 3k+rYbwvO0QWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] NFSD: Prevent client use-after-free during delegation revoke
Date: Mon,  7 Sep 2026 18:59:20 -0400
Message-ID: <20260907225923.712198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-remold-tapering-6ea7@gregkh>
References: <2026090331-remold-tapering-6ea7@gregkh>
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

Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c6f2324912bd5..4df10e8de7891 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6745,6 +6745,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.new_timeo = nn->nfsd4_lease
 	};
 	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp;
 	copy_stateid_t *cps_t;
 	int i;
 
@@ -6772,6 +6773,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6780,8 +6793,18 @@ nfs4_laundromat(struct nfsd_net *nn)
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


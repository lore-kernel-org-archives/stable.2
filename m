Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C7245005
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829610; cv=none; b=I9RQi2NmDDw6T6A2vXjYNHhjAwLf3nzV5W/SSr9KUmZK8HNVPW82BpnF/+7kM6f8zkqNH3d2ZWypsWMRel1ZhASscWIWzk/LXQTBVtSeyAOvfgKBI1VawY3+LNqRY+cLoVKOFeqnFf5aikVZVQJgZNNbjhy9/FYk3z31UV4r2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829610; c=relaxed/simple;
	bh=J38t7M5S+KOWYIArWPm9ZBOWwCbHP6KkfpY8Txj71C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhpfrUu2gAtGoLCbidWUK/bRyCWrvsKn7zRY37NsRDWkMb7EGLe+TivvZFrei7inLXUW2yRmR83BckuvihRcUPvvWh0dRD3xTFqAluQ4bcIYYNPffLbWw9lV2mwr85B+lGRd6Q31xtZRs3PuNoxYHH5+gMtteP4DJY26JroQq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBWshM/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBWshM/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFD1F00A3D;
	Tue,  8 Sep 2026 01:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829608;
	bh=+osd/MY2cYYH4KQK0hfaTH6DsEx+AW0LBj/1Djj11AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBWshM/KBcGgK1IDwo98jBQjhRlP0R1bWh9opTD5Ww/2u4Cl5Zeg1GuoRcUmJhD80
	 wQ93BnUYb3MajenkuaySDm1lNUCYlTiksuxImC5herenmXb/aYf7liVLNJ+cjDbqu+
	 eWGmU9f5qsZJKpul8u6XDcgByV7Pz7+8JgzJVZQaSqMb8PlBOVPFPylxEG0Ya+3nCc
	 8YVypgWPBwbJQSk4Lbj77HxKGk6U2amZ1s3Fm6PtI7Z9h03mf2dDIU64WAXY8rsot6
	 /PRx2czZ1ctLYXmb8BtafpkuYymjnhSDVGmhO70rkR8GBARiDCzWenDl1JJ+MMFV/t
	 HWepAcxbVc69w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] NFSD: Consolidate the revocation-path client unpin
Date: Mon,  7 Sep 2026 21:06:44 -0400
Message-ID: <20260908010645.1678749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908010645.1678749-1-sashal@kernel.org>
References: <2026090333-subdivide-jogger-d9a4@gregkh>
 <20260908010645.1678749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 3308cf3f11ed23c79f9f3f90b34bbbad3e3a6ea9 ]

The client use-after-free fixes in the state-revocation paths left
four open-coded copies of one idiom: drop a cl_rpc_users pin without
renewing the client's lease, waking force_expire_client() when the
last pin drops on a client it is tearing down.  The accompanying "do
not renew" rationale was documented at only one of the four sites.

put_client_renew_locked() and put_client_renew() already carry the
same pin-drop logic, but they renew a non-expired client's lease and
so would resurrect the client whose state is being revoked.  Factor
the common pin-drop into __put_client_locked(), parameterized by
whether to renew.  The renew helpers pass true; the new
put_client_no_renew_locked() and put_client_no_renew() pass false and
carry the revocation paths, which must not revive the client they are
tearing down.  No change in behavior.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-6-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5ebf48de4cfce..21812a19a5465 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -205,18 +205,28 @@ renew_client_locked(struct nfs4_client *clp)
 	clp->cl_state = NFSD4_ACTIVE;
 }
 
+/*
+ * Finish a cl_rpc_users unpin with the client_lock held. A
+ * revocation walk clears @renew so the client whose state it is
+ * revoking is not revived; every other caller renews the lease of
+ * a still-active client.
+ */
+static void __put_client_locked(struct nfs4_client *clp, bool renew)
+{
+	if (is_client_expired(clp))
+		wake_up_all(&expiry_wq);
+	else if (renew)
+		renew_client_locked(clp);
+}
+
 static void put_client_renew_locked(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
 	lockdep_assert_held(&nn->client_lock);
 
-	if (!atomic_dec_and_test(&clp->cl_rpc_users))
-		return;
-	if (!is_client_expired(clp))
-		renew_client_locked(clp);
-	else
-		wake_up_all(&expiry_wq);
+	if (atomic_dec_and_test(&clp->cl_rpc_users))
+		__put_client_locked(clp, true);
 }
 
 static void put_client_renew(struct nfs4_client *clp)
@@ -225,10 +235,17 @@ static void put_client_renew(struct nfs4_client *clp)
 
 	if (!atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock))
 		return;
-	if (!is_client_expired(clp))
-		renew_client_locked(clp);
-	else
-		wake_up_all(&expiry_wq);
+	__put_client_locked(clp, true);
+	spin_unlock(&nn->client_lock);
+}
+
+static void put_client_no_renew(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	if (!atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock))
+		return;
+	__put_client_locked(clp, false);
 	spin_unlock(&nn->client_lock);
 }
 
@@ -6228,15 +6245,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		clp = dp->dl_stid.sc_client;
 		list_del_init(&dp->dl_recall_lru);
 		revoke_delegation(dp);
-		/*
-		 * Unpin without renewing: put_client_renew() would
-		 * renew the reaped client's lease.
-		 */
-		if (atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock)) {
-			if (is_client_expired(clp))
-				wake_up_all(&expiry_wq);
-			spin_unlock(&nn->client_lock);
-		}
+		put_client_no_renew(clp);
 	}
 
 	spin_lock(&nn->client_lock);
-- 
2.53.0


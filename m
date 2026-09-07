Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89D2C0261
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821972; cv=none; b=XjmLDIdRqf4kTW78rbO42U6DdwUMtGLI8vwy9AnLaw+bCfsnIHQss6eM05hWQuwbmwbGGOMYmYcLBWaNIanerDW58V5YK+YhmXtIKT7Gr2s0Sm171JLclcfEAcULQmpb905X06jrgc6qyJyZcb9OME0gXWmgBnh6LPxDGrKspQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821972; c=relaxed/simple;
	bh=V18apeDhAP1fn2D4tHF5Fs5VomW6f2QwOBBcU1Z47hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAFlUD5n0setifY1m5mKIv6J7WyfzRd9QGAwI3waI5vmC+37y/dsCnl/PO+liUiEHFc3idkVCZ+Z+LI6+mzum+Zx0MDJmxtP5vQCtfz3HyAQSn5nnslJ6JbZn34CZX3fYIxFFOdSBTkmGcrnPlMnSZPhq85a4Af9fNrtxwcge3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWpNNljJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWpNNljJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6B71F00A3E;
	Mon,  7 Sep 2026 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821971;
	bh=mEB7mpSO18Mje+U0BvVA6AECPmKCN8x3ixczRWlhuQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWpNNljJMZuiF589aJar7hCi/b/UOKJXqeO2vu2UXMiodLHHRMuH5V88lsOM6gjnA
	 vfBZ827I7RGbqLlLK6PaHRBcQnH+YaKDelYxR+P8BLr2aHYjDinMsvLY5df1Hd217P
	 GUYy84VbjYmVlhbNyosU7s6zh7oBizWO59optRlOeIBneaupq2E0DtDa0/AClu6oeH
	 BJdCFQi4tQVRlsBi/qASICXmsHf8JE4kmgfAaA0jGOO1fp525z8W+Co/0HHs12OMvM
	 GVX1W0YgarfKatsGuVHrJLMnb034JB0C9zI1Z0X1oe416dv1wney3esTJl1TPosaJV
	 2Qan2JT2qnD6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] NFSD: Consolidate the revocation-path client unpin
Date: Mon,  7 Sep 2026 18:59:26 -0400
Message-ID: <20260907225927.712336-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907225927.712336-1-sashal@kernel.org>
References: <2026090304-waking-garnish-23bc@gregkh>
 <20260907225927.712336-1-sashal@kernel.org>
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
Stable-dep-of: 2330b788d732 ("NFSD: Prevent client use-after-free during close_lru reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 322f482182afd..07da5353644e1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -207,18 +207,28 @@ renew_client_locked(struct nfs4_client *clp)
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
@@ -227,10 +237,27 @@ static void put_client_renew(struct nfs4_client *clp)
 
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
+static void put_client_no_renew_locked(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	lockdep_assert_held(&nn->client_lock);
+
+	if (atomic_dec_and_test(&clp->cl_rpc_users))
+		__put_client_locked(clp, false);
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
 
@@ -1942,9 +1969,7 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
-				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
-				    is_client_expired(clp))
-					wake_up_all(&expiry_wq);
+				put_client_no_renew_locked(clp);
 				goto retry;
 			}
 		}
@@ -7047,9 +7072,7 @@ static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
 				nfsd4_drop_revoked_stid(stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
-				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
-				    is_client_expired(clp))
-					wake_up_all(&expiry_wq);
+				put_client_no_renew_locked(clp);
 				goto retry;
 			}
 		spin_unlock(&clp->cl_lock);
@@ -7122,15 +7145,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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


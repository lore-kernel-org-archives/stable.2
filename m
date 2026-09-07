Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F1423E99
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812335; cv=none; b=fM3Y0unglK5juLGcR+RebkxZb4+sRuJxVEUnsU3vY+8emh1Vz7Ai9ieHOnaSGI8C+d63RauMjrGZWhUfojnj5iRO24CT4GgaMkOSTs0RQl8VRhxKr6nbh5bVtB7pFBLXM1g3q1Gp6UGpvQHiz/bhw3+jV8Jdzr2nUsXDA7uD+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812335; c=relaxed/simple;
	bh=vLU77ZFOwNfHR8UjSvdeTgn7k6RkPCa4H5xSPQ/A09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co4og6Xj87VFQOUUy5AgbE2Nsn8WY37JR1qZBSKrHpvPjSjY7hsKxCRVm9sowXiJ3tl75NX8b2ykzjgz+41dxYSurmppSlPUD47+2JIY40gMYSzBQp7d6W++JF4mgIA+iehUS4zf76+wv7wrzWcqxeMQa9gAqBnGD1Eda3g3noM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb3x44Z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb3x44Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224B81F00A3E;
	Mon,  7 Sep 2026 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812333;
	bh=7Opz0Fdp2a3wry+pM5m6Ntc2wkSlcGrBi1izu2cGVFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eb3x44Z/OaV9YDAh1DhVgCes5xNzSl9osl1hD24s+wUYAvmUuUlBYzy7wP56WVJ7t
	 YLV/Zx9pTokktfyWUA7u2pDE2A7I5YIzxnzOn6BE6bsdHp0FnWwCjL9vZx+FMY74oH
	 otm1DKrsTrPjced4vMmlfqthIyvNSR+IJVtH0kOFPmv07mqn4xdH0xFn4XXpp1CFJ8
	 hLJR+9wxMXy72a83VkXkcCgoquuCCnM1VzLqeIKGXCm0mUVo8rJlHJW2lX2IKLweJx
	 Cp1ln2bvJgZUpsTBdA+nFIjay6lDrEAWyYiuMGAdxvB6dIcK0GXDaZgIqXeUVB3d//
	 cHMLKI/ZsE5bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/6] NFSD: Consolidate the revocation-path client unpin
Date: Mon,  7 Sep 2026 16:18:47 -0400
Message-ID: <20260907201848.382196-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907201848.382196-1-sashal@kernel.org>
References: <2026090331-frostbite-credibly-4ca0@gregkh>
 <20260907201848.382196-1-sashal@kernel.org>
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
 fs/nfsd/nfs4state.c | 69 +++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e26ea5b6295c2..9fde3505fac52 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -202,18 +202,28 @@ renew_client_locked(struct nfs4_client *clp)
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
@@ -222,10 +232,27 @@ static void put_client_renew(struct nfs4_client *clp)
 
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
 
@@ -1914,9 +1941,7 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
@@ -1988,9 +2013,7 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 				if (clp->cl_minorversion == 0)
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
-				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
-				    is_client_expired(clp))
-					wake_up_all(&expiry_wq);
+				put_client_no_renew_locked(clp);
 				goto retry;
 			}
 		}
@@ -7070,9 +7093,7 @@ static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
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
@@ -7145,15 +7166,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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


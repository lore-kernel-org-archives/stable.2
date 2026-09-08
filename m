Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C941C72
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828375; cv=none; b=UrnvrGCPXhc5BR/Y8agU3KEKmRCy0fMdf38DkQxLl2+iYDuC82E426vIATIUBq1jc8ciORKQuSded+WVoC2l+uoIkwAa4YWpJ/L7seeAdM0+e2pCPOtFbfF91Xs+CeKZ5iqpmTvg9S5d8+lbsmZPihPDhHmcEKtUekPQ0/KLnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828375; c=relaxed/simple;
	bh=+0cu6HrU8xqfD2mGaKRDWbkj09c1vSuLlO2P+QU3ing=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGojPA0SpgKq1yeLeRc+k9XcLkYID/rwfxzleBf1lahi3XYCXbfdhLCfr9O+Vh4/UNGMf+G/GygNZJ+N9qSSpsI3AUFOcouf1/4m39pWULbXxCsatHWMhVDrguhyWH9OYejpFXHrL06IigZuM6b64VxK/LcJOvSPeURxIHYwrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6BBapn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6BBapn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0571F00A3D;
	Tue,  8 Sep 2026 00:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828374;
	bh=PLBu7UlE0J4qnGYlgn8CdgAd2uHmxLxgzX9+kzb0MBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6BBapn4u2BfSy/C92xbSIGzO7c7EhmqVTOL5e67UyUl71r+L+Z0wQRm1n2z6S2/G
	 ykl8gn4AdSDIATI6CtbJVBIzlihgsEVMjLpn6txgrxg2odPuqjKn5L8ADTIHWYBk57
	 cRnEPjqjCOq6xccs/Ada/Wd3BdxiPt5cFmb1pjw0Ptx+4g2EE2e2LzQddcI4YsmC3B
	 oQVu1nphabW00fcrTLL/SY8HP7ITQaZymjrwW3n0v5Tet//o7npx3gTx11/yVLFkkf
	 EGZYGwMZV5vua+njZvqrvFfl+UFYvpErqz6c6axDb+8StrmLGlbzaHErlIEbPv0S/X
	 lW06YS6gdQOqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] NFSD: Consolidate the revocation-path client unpin
Date: Mon,  7 Sep 2026 20:46:09 -0400
Message-ID: <20260908004610.1630138-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908004610.1630138-1-sashal@kernel.org>
References: <2026090305-identical-flame-bc6a@gregkh>
 <20260908004610.1630138-1-sashal@kernel.org>
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
 fs/nfsd/nfs4state.c | 57 ++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bc471058a5fc5..1592a9b36a344 100644
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
@@ -225,10 +235,27 @@ static void put_client_renew(struct nfs4_client *clp)
 
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
+static void __maybe_unused put_client_no_renew_locked(struct nfs4_client *clp)
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
 
@@ -6273,15 +6300,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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


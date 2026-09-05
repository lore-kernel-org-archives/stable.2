Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835B330668
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578917; cv=none; b=HoSpVGNM5cVzmm1VAGdoTm1CxLt1oMMjv0RBno/zU/egW1j758Kgyj9+SgFB9WUArzL3LrBxGY6iXXpXpCF6rn5ZzNH8SGceOdECW570voAQLQ6Qcu+Eo++H+fepI1giT/beus86zikOob8e6jqsO1Zc5CX6FEE0XiQkwip7T24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578917; c=relaxed/simple;
	bh=BEz/S1kT5k8aa/1avK3w4Gi5Rs1AJg5mKr6Ebu4c4lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOcQ3Fky2+yeqdBvwpLDWRm6fCUZBSiXZKARXYFoNVb5dF3DvfzSygaDbe+zJ3dRjnGQQEwydqfViZS9gfHeYxL/+da2wEcvPdJyLPdXjWDpCgd9jyB/VvVD6rKxKT+FcVoS55QSrGaRRL5EnpU3PjAvbxo4mJ1/6OYFev+Fxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9N9kNFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9N9kNFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE901F00ACA;
	Sat,  5 Sep 2026 03:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578915;
	bh=vIUBIFwHMKEB0lkYRFzpDrm7kOCneW/8dU5ceiWFOYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9N9kNFqLZ5PyoTPCHHZZnFY16l7lgNsJIbrPoQkMmLQQ3tBCHl7beOGJ6vvbLQsD
	 B5K0nL5qkoyXZmWRFTGWbppi6MOwq+b1xv7VMHWlQcKWAPJrOcXXnHlA9AuozcvvLF
	 xIj2WsCSXIDbpFQk4f+ZX8Pa9FoAHNFa8j/YLHEEqJ3tYXlXX9nh94QqAqG4HiLKzW
	 QvXhedpjTflsPUnY5x2xELggv5k21W5SEiVUVR90JH0/RA9Q15DVVXA2yKC1TCVs0s
	 +94vggDu5Kp4d2MTe7v3K+DzecdUSF3AkOR30E12JutCQHO+/cflSRyQAl4n++pVMB
	 0pCWQ3jQ2cYyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] nfsd: avoid race after unhash_delegation_locked()
Date: Fri,  4 Sep 2026 23:28:28 -0400
Message-ID: <20260905032830.1915148-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032830.1915148-1-sashal@kernel.org>
References: <2026090305-dowry-plaster-fff3@gregkh>
 <20260905032830.1915148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 83e733161fde43e2f99cefa68e369944460fce39 ]

NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
purpose.
REVOKED is used for NFSv4.1 states which have been revoked because the
lease has expired.  CLOSED is used in other cases.
The difference has two practical effects.
1/ REVOKED states are on the ->cl_revoked list
2/ REVOKED states result in nfserr_deleg_revoked from
   nfsd4_verify_open_stid() and nfsd4_validate_stateid while
   CLOSED states result in nfserr_bad_stid.

Currently a state that is being revoked is first set to "CLOSED" in
unhash_delegation_locked(), then possibly to "REVOKED" in
revoke_delegation(), at which point it is added to the cl_revoked list.

It is possible that a stateid test could see the CLOSED state
which really should be REVOKED, and so return the wrong error code.  So
it is safest to remove this window of inconsistency.

With this patch, unhash_delegation_locked() always sets the state
correctly, and revoke_delegation() no longer changes the state.

Also remove a redundant test on minorversion when
NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
is non-zero.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: ca94ba361720 ("nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on racing delegation revoke")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3def9f493e12b..b870cb4ca77bc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1333,7 +1333,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
@@ -1342,7 +1342,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 	if (!delegation_hashed(dp))
 		return false;
 
-	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
+	if (dp->dl_stid.sc_client->cl_minorversion == 0)
+		type = NFS4_CLOSED_DELEG_STID;
+	dp->dl_stid.sc_type = type;
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1358,7 +1360,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 	bool unhashed;
 
 	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp);
+	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -1372,9 +1374,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (clp->cl_minorversion) {
+	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		spin_lock(&clp->cl_lock);
-		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
@@ -2244,7 +2245,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -5179,8 +5180,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 		goto out;
 	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		nfs4_put_stid(&deleg->dl_stid);
-		if (cl->cl_minorversion)
-			status = nfserr_deleg_revoked;
+		status = nfserr_deleg_revoked;
 		goto out;
 	}
 	flags = share_access_to_flags(open->op_share_access);
@@ -6250,7 +6250,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8380,7 +8380,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.53.0


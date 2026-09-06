Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3F35CB87
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660834; cv=none; b=thHO/3Z8u5QgtTbfPHfrBKTCCtM2e6fXokLHKWr65e5qL1ebOFooojLyOkMXMWz4/vRN1edQpWLhblUTm4c7Hg4giEUrYJCXcTfZadtycH1NOSEQOQGWgT362aE4G/Md3T7b7QJffV90uVmmSaNmXeeXG22jdIVNJpdbh9IhfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660834; c=relaxed/simple;
	bh=Avn+LgnSxbEmaBezFYD65o7bAN4jiMduHEBnjAIiG50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3Dukc96+LLjKjUhxG4Ns6q4Di/4ArH2TRTWhW8tHY0+WRBds0PTTTHfZMktbLRWjoN25A85JD5OIiMFtle+BwwiWTBm7489nV3pvhYBTWJivejs9vwXKBf/67P15sQ+Gjg0Mr4oecy1slmPDL9VQpFDxEtTdI+wZbYcJtBRT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkOQugnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkOQugnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD5F1F0155A;
	Sun,  6 Sep 2026 02:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660812;
	bh=UUmlAyDzcSPWkgKjtolD/r/10yu2NuZjlIN76jOJbF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KkOQugnh9iljcpzmA4UzuA45d3sPJALL9vpk+owicOpHtBLzFrZfQBO0dZUoaz7GF
	 WkTkSfyYcuUFsq2mXUc+UTNPQ057vwDA+yxo5GqYsNMgg/pCBApflRLHbpY1ofGQJ7
	 es+oPhVOE9wURh5YauUNd2pFNdxbl65eXFtnR0IXv1TQJ7qEDso1QMvb6KJ29Cgl7C
	 UakFHdaH1DNZFbG6Eoru0rFXZfev8JpHd660MpMV/EKOGgc0wZ/iZYq53hkrdAjJdq
	 5h0TGAnXcDryX2wNLI8XSflBoB4TRs23oUUkfymW7lTIUxlPTrkB5stzAxwC5jbRvN
	 Oc6yjsG2ebNrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] NFSD: Prevent client use-after-free during admin state revocation
Date: Sat,  5 Sep 2026 22:13:30 -0400
Message-ID: <20260906021330.760870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-food-custody-c3c1@gregkh>
References: <2026090309-food-custody-c3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit e270e5a0778e5bff852c8862ce9576ce70359393 ]

A stateid holds only a bare pointer to its nfs4_client; a stateid
reference does not pin it.  The client survives only because
__destroy_client() drains its stateids before free_client() runs.

nfsd4_revoke_states() drops nn->client_lock across revoke_one_stid(),
which dereferences the client to revoke a stateid and read
clp->cl_minorversion.  A teardown racing the dropped lock can free
the client first.

Pinning cl_rpc_users under client_lock blocks the DESTROY_CLIENTID and
EXCHANGE_ID teardown, which refuses while cl_rpc_users is non-zero.
force_expire_client() ignores it: once its wait for cl_rpc_users to
reach zero has passed, a later pin goes unnoticed.

Under client_lock, skip a client whose cl_time is already zero --
force_expire_client() clears it there before waiting -- otherwise pin
cl_rpc_users before dropping the lock.  The walk then either sees the
expiry and skips, or pins in time for that wait to cover the revoke.

Fixes: 1c13bf9f2e3c ("nfsd: allow lock state ids to be revoked and then freed")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-3-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ adapted revoke_one_stid() calls to the branch’s inline revocation logic ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9d9a7d46e7b2..10d7dd8422103 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1771,13 +1771,23 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
-								  sc_types);
+			struct nfs4_stid *stid;
+
+			/*
+			 * force_expire_client() ignores cl_rpc_users once
+			 * its wait_event() has passed, so pinning cannot
+			 * keep an already-expiring client alive; the
+			 * expiry path revokes its states instead.
+			 */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_sb_stid(clp, sb, sc_types);
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
 				struct nfs4_delegation *dp;
 				struct nfs4_layout_stateid *ls;
 
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
 				case SC_TYPE_OPEN:
@@ -1861,6 +1871,9 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}
@@ -3137,6 +3150,11 @@ static void force_expire_client(struct nfs4_client *clp)
 
 	trace_nfsd_clid_admin_expired(&clp->cl_clientid);
 
+	/*
+	 * cl_time is cleared under client_lock before the wait so a
+	 * revocation walk pinning cl_rpc_users under it either skips
+	 * this client or is seen by this wait_event().
+	 */
 	spin_lock(&nn->client_lock);
 	clp->cl_time = 0;
 	spin_unlock(&nn->client_lock);
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D143DA38
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821968; cv=none; b=jzO+gQleVjMH1iXoej5CTsxknJZ3cg3D0ejRNNmHKcc2dftdski+yMNNO1aoxgIMR31wdvJaiflqcPFwJ122zoW5WTHcMsN0kOaBQ4tUFobM0jpfPCvxfcS1FYkfg+1UGflW60/9efqtMKAzwlWF8XMPor+mHIXgnn2NOBtYYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821968; c=relaxed/simple;
	bh=ChHjw2gmlI0QsvJwl1+3DLGqMCJI9hfS1Kf0iIbjMk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0CfA7mjEjTKeS/zo0dp3g1wwHPLjyPwYQTrdx/jJLPBw1rsPEmyOXZ1vXCCFdIbdqTS3j3B2PvWzpAGW6fHNn8jmk7ahrebqDnC9U4vTVavfKLomGjcBGz1H+IdzrTgTaD0cf8LpTqNeOnZ0SymBNmlsSQyBsWCq2D5ktGGDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWRT/8Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWRT/8Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC01F00A3D;
	Mon,  7 Sep 2026 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821966;
	bh=v/TBwNgsjBUG0OQTn47QfO+pofQacjHhNQqoXKy5QgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mWRT/8EkDAu5Hw6xlRgp/UcDSJxr16FkqGB6PscIRQO+8pyVv3my6J0BVDEj5WvWx
	 ar8JYJHroQGXHgYU9pfKU7EiCv8Rzw3QBHTAKBGbzQjBwV4D52BwewrZTPXbRPtGtN
	 Ovukd3Cx9n6/CMHcYyeOm+yWcDJFDzdFgfG8ry9zeZ9+g13ZA9O+0f9t4Rma3S7yya
	 Nberi+sSem/VfBWqBuq6GN/CJC9AoXNfws+qjXFUw1vSyMdlXwYp1Qmlh5YWIoDZLy
	 fiZ6upeAu3d/NAax7+XxrqYCV24CDFNtcDlFq0oGE8x+z8V+uhWX2D2pD6Yz6F2xZr
	 Sx/sc+y1xjs0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] NFSD: Prevent client use-after-free during admin state revocation
Date: Mon,  7 Sep 2026 18:59:21 -0400
Message-ID: <20260907225923.712198-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907225923.712198-1-sashal@kernel.org>
References: <2026090331-remold-tapering-6ea7@gregkh>
 <20260907225923.712198-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4df10e8de7891..a26e275548d18 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1840,13 +1840,23 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
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
@@ -1930,6 +1940,9 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}
@@ -3122,6 +3135,11 @@ static void force_expire_client(struct nfs4_client *clp)
 
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A003DC4B6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812334; cv=none; b=DGM0r2aemq/eEWi7EAfV0ukG3vC7wbVzHo8qfla454gXS6BMAwHIE3WmA4Nu+hRIAoZ1GyT1hDOzZqz5/S1fklqXOcHm724pgxx5HdCFJNNesCUJYAlvqyDvGWBdpDX3M/V1FcmbtScih4hKyjRWxwefXz2cZryV5NsMwhQmDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812334; c=relaxed/simple;
	bh=qkV1X9ykWU3epTPIt8VC64rUtl1gqajhuE8/lOo6B2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POwDFp1bLdUVM19eYJDeaUrFZG716lsrmDJSu7LropT7nXSj2PfwnpnyFaCtnH7CkGuwOkXYxKmAztlU7w74Pjcc/Wgxoaxasx0osnHuZeXCayzBsOxyHjfbYt3In/O0apNTyjpWrkhNFYLb1wv2cK5LwhHq7wL9aZo4Gp/3tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLwatgs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLwatgs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF271F00AC4;
	Mon,  7 Sep 2026 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812332;
	bh=LSwhI5SQamTkVd2s3ON4VHeVBKTkL2bVwn+CYDhYrNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLwatgs0eBC2R4lqwJIGbD1ebXTL6TU87tFYh6kH3G3L+kxz1usMed6euhFypjThB
	 NDRgmtGl0gxRYiU8vnT8Gjhr+3gnvFc/rvIlIr33exYjw81udcoaY2wZMvQygPM2Nt
	 n0e7Mi74zcoU1Ep6hfV05UBfdNGNbfMp7dw0kkrNuF/zZbR6El0Hbgf6aSnpW0013z
	 pGCYk2e4I5gxhchbRXo+ppJPVHM/AvxmcztgYmjKIJcDk/mZKqd967UjAigr7f5b3v
	 iG0F7TcsX2scqLssxlhZJjfMIAK5gpifeBUlo0PQETWX5CsuTMyA7FiTqSnJzNqDIS
	 LVDIL7osHwHmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/6] NFSD: Prevent client use-after-free during NFSv4.0 revoked-state cleanup
Date: Mon,  7 Sep 2026 16:18:46 -0400
Message-ID: <20260907201848.382196-4-sashal@kernel.org>
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

[ Upstream commit 7b4f8a1586c42d3afc3c0ac779af2db7ab1a5c55 ]

nfs40_clean_admin_revoked() takes a stateid reference under
clp->cl_lock, drops nn->client_lock, and calls
nfsd4_drop_revoked_stid(), which dereferences the stateid's client
through s->sc_client->cl_lock.  The stateid reference does not pin the
client, so a teardown racing the dropped lock can free the client
while nfsd4_drop_revoked_stid() is still using it.

This cleanup runs from the laundromat, so a periodic sweep can race
force_expire_client() driven by a write to the clients/<id>/ctl file.

Skip a client that is already expiring and otherwise pin it with
cl_rpc_users under client_lock before dropping the lock, matching
nfsd4_revoke_states().

Fixes: d688d8585e6b ("nfsd: allow admin-revoked NFSv4.0 state to be freed.")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-5-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fd97042abbb2e..e26ea5b6295c2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7057,16 +7057,22 @@ static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
 
 		if (atomic_read(&clp->cl_admin_revoked) == 0)
 			continue;
+		if (is_client_expired(clp))
+			continue;
 
 		spin_lock(&clp->cl_lock);
 		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
 			if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
 				refcount_inc(&stid->sc_count);
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				/* this function drops ->cl_lock */
 				nfsd4_drop_revoked_stid(stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		spin_unlock(&clp->cl_lock);
-- 
2.53.0


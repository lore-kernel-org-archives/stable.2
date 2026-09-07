Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1A419304
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812330; cv=none; b=qC40S28PehycdaesOJBtYElR6Ofa+YXOgLQyoZei+iKh5Ef/7346iyv8B2zkxJOwBaZjpd6vPmslsx/JWPoYIBjNof9wR+qbIQIDWhOdmFV0xoGbi+dpIG5dEQQ61PrZ3KaV0xGfwUVf3jw67ou+8BQWqiZSKKz3H5yWCMvTF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812330; c=relaxed/simple;
	bh=2kdKtwX27DjJEhZTJ2X764cg+dn95YLwb1qeaKQEQxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoLn8/Q0vttsyR0utQH5c/9YByX1DIEK52SFrSMr1Ri0pw3c8rT3yguNN5VwcqC9e9zz5lXQUezP/2uuog78o37anXfA3jD5XskhS7yrnJXSX8Gbnx70g9gfSKYb84foRyMNhdZJRmpJU/YmTJqLxw1ipS5G1VA0ppYw45HPY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMCmb/V7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMCmb/V7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0701F00A3A;
	Mon,  7 Sep 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812329;
	bh=LJaSbpCWwK6iNSIDPNVk84nVXJO8SouaM1pM2bkw7q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMCmb/V78tIUj7R++SBs/CiNMmF8tuzrhyQJVcoMmlINdMRFnlIfHykA2AsvccPmI
	 g0vg/i/CKJa0YjNG5jylErn96BmpbWmrNayXuNGOTjc1DfwfTYxGuteX2zRALgLdwM
	 qHeIEJARIL0DvMZIiaEUQlwwJItfCFW0JC5VCseoN992E3stTEpHrKhGhUGATyLaqD
	 3BnCx/U3NYB90IvT49nTEGZydEarf9iHmQ2Rm6hyfqyw7FQ4CABtx+jhUcEUDwNCkY
	 5QrntOmXc+o5u9D1FzeNTXa4VJe5Nz44R1q6ApDO93GYo5ISUmOQiOrfqyekG3E1IA
	 ThCItdT+MEfIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/6] NFSD: Prevent client use-after-free during NFSv4.0 revoked-state cleanup
Date: Mon,  7 Sep 2026 16:18:42 -0400
Message-ID: <20260907201844.381343-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907201844.381343-1-sashal@kernel.org>
References: <2026090304-open-erasable-9a07@gregkh>
 <20260907201844.381343-1-sashal@kernel.org>
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
Stable-dep-of: 2330b788d732 ("NFSD: Prevent client use-after-free during close_lru reaping")
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A942252E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812333; cv=none; b=JNT0nVf+0Z5Lpg6Xi39UlmW9w4E5bT1BOfWP1AgsvZC4bZFevef77TCNMpEiXFo46gMKLerDuzRPz0EcLEW1vn+npz7NXjnjNa3xoMrJjLMh/ja4s3/lEst7+g9zE7nLxZeb2Z7omW0KgHY2lblJEhmfuvViPrXWCjbz9B4+/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812333; c=relaxed/simple;
	bh=nh2UGZrA3+KnvwUOzm+XMeSi+yqGXQXa6jwzm0foBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPyDXYxQ1GaB9r1z6pIR7cVE4rBlEkvj7c9RKTN/lQht4o2fDXIhjPETnn6sHdyFgFkOlE9vOiKUEyb039hyQKWhpCzS0z5jc6aBgi1QjXvD2M2q2Ba8T2uc7rVNFoT94eWkTaQjTrxRW0ezSDtm2qPOmuN1qv4LkFktRCr7adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEaUj90K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEaUj90K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9C41F00A3A;
	Mon,  7 Sep 2026 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812332;
	bh=smKLsfte2yhvRmR7StW+2WAVy5YJhhh58HhUAncdlws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEaUj90KxHS6AI0CLTiGBb96UMk9QtEgQ58CgnUUnioytm3a+CstHacX+J3OXTsPJ
	 +Mp/+07Hm1iD76TVapjRcDNVmijOf7C6/+lChgmDEDRr8z7wKgHhXOdznow2ix1vLq
	 CxprSarcbRjbR1yHoeQuOUJppl8l+ypO9RmZ/1Bgnb4uzVDcJVqicqxDTFzxKISIzv
	 R5j0hKBcOrLUak3YashXwS34lKSURLcE5YooruFd0Y0aNgXz6WJMhFNFBAJYxWy4Hf
	 rFU8ccyGE0nkU8HAk0EWZWDbxlPz4BqGSWaWTfasLkWBiHP00IvAYwWjU8+QkkgM1U
	 at1tW5ZKcMNhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/6] NFSD: Prevent client use-after-free during export state revocation
Date: Mon,  7 Sep 2026 16:18:45 -0400
Message-ID: <20260907201848.382196-3-sashal@kernel.org>
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

[ Upstream commit 2108de53568a64936a0da3e04d85c35df98d3fb6 ]

nfsd4_revoke_export_states() has the same use-after-free as
nfsd4_revoke_states(): it drops nn->client_lock across
revoke_one_stid() and the following read of clp->cl_minorversion, but
the stateid reference it holds does not pin the client.  A teardown
racing the dropped lock can free the client while revoke_one_stid()
still dereferences it.

exportfs -u drives this path through NFSD_CMD_UNLOCK_EXPORT, so an
administrator removing an export can race a client expiry.

Skip a client that is already expiring and otherwise pin it with
cl_rpc_users under client_lock before dropping the lock, matching
nfsd4_revoke_states().

Fixes: 2eac189bb059 ("NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-4-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 9026932ac8be ("NFSD: Prevent client use-after-free during blocked-lock reaping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8b0feceee5ac6..fd97042abbb2e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1973,10 +1973,14 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_export_stid(
-							clp, path,
-							sc_types);
+			struct nfs4_stid *stid;
+
+			/* Skip or pin clp as in nfsd4_revoke_states(). */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_export_stid(clp, path, sc_types);
 			if (stid) {
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
@@ -1984,6 +1988,9 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 				if (clp->cl_minorversion == 0)
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}
-- 
2.53.0


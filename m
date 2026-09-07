Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDAD3F4827
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812335; cv=none; b=jWuZh4kqKeTSgyqVA3bjPz7MsgdrmQ1txJ0AoCWgwHJFIMZ2KS69kEFuORfTLDN2OPeDyHe3viwUA5RCe1MZrs28DxxdRs143cfX5rkqkRaXy/jOlftv/KARMAFPmHd+10JwtTrTXaWr82Oqy3hi4vRidGa0qHgi2/DPsu+ZJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812335; c=relaxed/simple;
	bh=Nep8qgIaBKkl1SXovGDuFgGdblUIKbeCFeXAJsD1/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJWR3Uwaad621/Va6hpagdU9i91OxCIsklav17U2l6ha35vQWZ43R84eJKSyqV6oP06zf31GJbjN4VD682zynbuLJbR85jtP8BWvG4OOsRLmFZ1VQ+woqTgXYd1xXlIOQqib0mOipmuA3kUaW34kKKNmQh+bHk6vGqZ3b0VHU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMFGeP1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMFGeP1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A861F00A3A;
	Mon,  7 Sep 2026 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812334;
	bh=FqUKsLTpv/wvSWfssRE/vt7jjtT5WGGbRyAZP0pDG7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMFGeP1/YrJIUfl9w6FT2g1k5NOJhRIdFONqWY0M+Vb444zmTeayodgzMZm8C1dbp
	 L18WOSVobphEhFL+4KZdgeTzKUe+woxLqiGPqGx+LCedpQIzfp1Jvo8a5t6jl69urX
	 oIlqHH6B+m/Kcj3iSJiFz1ZJjT981vcne9ePEqo2IkLY9j1FG95f2mjl//cZJ/HIIM
	 rdGtfq2CKsmMfsmFBr8UGuQDZKikI+0lCgqmi5c+vfJf65S46Rgwg2Qz0zwZ+2vFs2
	 g3tfNSLYUPu5aSiDkdB+2TVtQNZJGZYiQeyjz9m7xkyRz0tODuED8O8o5ukNU0jOQu
	 WBMmR9BWXxfmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/6] NFSD: Prevent client use-after-free during blocked-lock reaping
Date: Mon,  7 Sep 2026 16:18:48 -0400
Message-ID: <20260907201848.382196-6-sashal@kernel.org>
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

[ Upstream commit 9026932ac8be4d0ae01db47f23619a98cc57b671 ]

A bare lock owner -- its only remaining reference a blocked lock on
nn->blocked_locks_lru -- holds a raw pointer to its nfs4_client but
no reference keeping the client alive. When the per-net laundromat
reaps such a lock, freeing the nbl drops the owner reference
held through flc_owner, and the final nfs4_put_stateowner()
takes the client's cl_lock. Because the laundromat detaches the
nbl first, __destroy_client() no longer finds it, so a concurrent
force_expire_client() can free the client before nfs4_put_stateowner()
runs, dereferencing cl_lock in freed memory.

Pin the client with cl_rpc_users before dropping
nn->blocked_locks_lock, and skip clients already expiring, whose
blocked locks __destroy_client() frees while holding an owner
reference. Take nn->client_lock outside nn->blocked_locks_lock.
Every other site holds nn->blocked_locks_lock as a leaf, acquiring
no further lock, so placing nn->client_lock outside it cannot form
a lock-order cycle.

Fixes: 7919d0a27f1e ("nfsd: add a LRU list for blocked locks")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260709-cel-v4-7-1d519d9be0cb@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9fde3505fac52..d682d65d74128 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -353,6 +353,16 @@ free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
+/* A blocked lock's flc_owner is its nfs4_lockowner. */
+static struct nfs4_client *
+nbl_client(struct nfsd4_blocked_lock *nbl)
+{
+	struct nfs4_lockowner *lo;
+
+	lo = (struct nfs4_lockowner *)nbl->nbl_lock.c.flc_owner;
+	return lo->lo_owner.so_client;
+}
+
 static void
 remove_blocked_locks(struct nfs4_lockowner *lo)
 {
@@ -7196,22 +7206,29 @@ nfs4_laundromat(struct nfsd_net *nn)
 	 * indefinitely once the lock does become free.
 	 */
 	BUG_ON(!list_empty(&reaplist));
+	spin_lock(&nn->client_lock);
 	spin_lock(&nn->blocked_locks_lock);
-	while (!list_empty(&nn->blocked_locks_lru)) {
-		nbl = list_first_entry(&nn->blocked_locks_lru,
-					struct nfsd4_blocked_lock, nbl_lru);
+	list_for_each_safe(pos, next, &nn->blocked_locks_lru) {
+		nbl = list_entry(pos, struct nfsd4_blocked_lock, nbl_lru);
 		if (!state_expired(&lt, nbl->nbl_time))
 			break;
+		clp = nbl_client(nbl);
+		if (is_client_expired(clp))
+			continue;
+		atomic_inc(&clp->cl_rpc_users);
 		list_move(&nbl->nbl_lru, &reaplist);
 		list_del_init(&nbl->nbl_list);
 	}
 	spin_unlock(&nn->blocked_locks_lock);
+	spin_unlock(&nn->client_lock);
 
 	while (!list_empty(&reaplist)) {
 		nbl = list_first_entry(&reaplist,
 					struct nfsd4_blocked_lock, nbl_lru);
+		clp = nbl_client(nbl);
 		list_del_init(&nbl->nbl_lru);
 		free_blocked_lock(nbl);
+		put_client_no_renew(clp);
 	}
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	/* service the server-to-server copy delayed unmount list */
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3453242D72
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830018; cv=none; b=ui20Jm41lferSuZX4w5vH65pftVOrnXX1sDoHKflf9yGRJ4BhQvD+6CJFjFIatEmyeR6gf6SwTTDwHBlRJMEhUfLDAkwhwDyHk/SxIn3vUssNbltqNvLYRlvZPA3FhxQfS41eic7dLG1jkuGxH8ONuEsLZBHEV0CwcVP8O67t4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830018; c=relaxed/simple;
	bh=XcKtuVsl4amfz/bNWMr0gf+Ds+0aXOUg6N81wGdpcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3ZLRRQEgYXSxh3xfTcgJQ0lFN7a124FsZGr/c2bVm+ih/J+4dNktan6wN4fT+XMQ5187+1j99mC6M+9AdrJyAulykvkL8Bhgdd9kLxTFM8FVse6K0UbVZlvwYMH1EKvPPu4FKji69Ft/CRVJjcaIOYzlt954IN6elwAYv9uhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR6L8P6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR6L8P6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334431F00A3D;
	Tue,  8 Sep 2026 01:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830017;
	bh=eRJBtLpzmlndt+Nxc70CskvDCJwByMQVB+FX8CMDvVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cR6L8P6ntec4l/7ss3+RZ5xPLmU9CcW5FN74+LcDafeDU1RlUdFtQrJE17w5EFGF1
	 7zjVSbPQ23DKaRHEQr2YAb5MMAbToxNgxmnCy0gbg9SimTu6HXkMqPTF+nYABJjrog
	 PTURaL6wqsD2fIWJC90cqtkrh0SXvYoWFYbylvWa4tDkoiCN+ncEQKTJzm6DlI5VUw
	 CkexRW7zQCk5WDQed4EOutmCywPxD2UJ1NkQleXE+VMn8BgS6bstGsBQKuX0cbdxB9
	 xalugBrodDynAeJaebzR6xVpi3mJxCYFyYZpxpbkhuIpTklTwppLVW6zcDkrzJhV84
	 qAZvF6Pl2TzsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] NFSD: Prevent client use-after-free during blocked-lock reaping
Date: Mon,  7 Sep 2026 21:13:33 -0400
Message-ID: <20260908011333.1693596-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908011333.1693596-1-sashal@kernel.org>
References: <2026090333-gutter-request-d440@gregkh>
 <20260908011333.1693596-1-sashal@kernel.org>
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
[ adapted nbl_lock.c.flc_owner access to the older nbl_lock.fl_owner layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4468c24145687..e08dcfd2e75b9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -346,6 +346,16 @@ free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
+/* A blocked lock's fl_owner is its nfs4_lockowner. */
+static struct nfs4_client *
+nbl_client(struct nfsd4_blocked_lock *nbl)
+{
+	struct nfs4_lockowner *lo;
+
+	lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_owner;
+	return lo->lo_owner.so_client;
+}
+
 static void
 remove_blocked_locks(struct nfs4_lockowner *lo)
 {
@@ -6279,22 +6289,29 @@ nfs4_laundromat(struct nfsd_net *nn)
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


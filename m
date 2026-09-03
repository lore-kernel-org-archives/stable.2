Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857034AF69C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443425; cv=none; b=ZyVPZRz02IwiNXQpHEjQXkqpw7tla3Swm2kVPBQ9KsZa3QoFjIOWcSS2WgFeMVyzHTdTS/+/c7fslFwqNSaWYczAPIqMqb4JgbqXeOHCTOgK7u01i10Pg2TrXpBAzsLfrVAEErY69U5VN2V/8Hlhf/Im8pVdRThAF3pc49k5o4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443425; c=relaxed/simple;
	bh=SrBhyLO1KYvGpY3aHQZMh6m86iDtJBjxy4wzgg2D9o4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tEha6o7WclEV5uYZkthW+Y9uWC6Gi2c9Xo55R2SuUy0OllEA5OfJGRh2ZowhZKlpNqYaYqjLyuWaKb7H9Nxm4GO1H6DDoh1y4c+cF87WeDtVhrDpSZcl0R0ctQYeY+8WfqutHazCHkbCdlfwyE6qvBL6rjF8cWNKqocXRPs8Z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygu0ozxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygu0ozxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939A81F00A3F;
	Thu,  3 Sep 2026 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443413;
	bh=UrQyjCtA969ZZBLWbQtdFmP7WLoPuxVpaK4ZXzzJ5/0=;
	h=Subject:To:Cc:From:Date;
	b=ygu0ozxOjQYqcEtO+m9I6vGLZpI3x1QJ1fA8mmOtYWkFyNtDX/5aH1cpQQAD8FyrP
	 GQaIlxzSB+v84HsCI4bnYJEFBMNdECi12aicJuLrciHDZFvU9K477y3Wz9VRdMo1UV
	 /BXdxm9BoHrKceJFbEjz6050/dt2FCB6SSTiFHoE=
Subject: FAILED: patch "[PATCH] NFSD: Prevent client use-after-free during blocked-lock" failed to apply to 6.18-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:32:31 +0200
Message-ID: <2026090331-qualm-umbilical-2cdb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9026932ac8be4d0ae01db47f23619a98cc57b671
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-qualm-umbilical-2cdb@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9026932ac8be4d0ae01db47f23619a98cc57b671 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Thu, 9 Jul 2026 13:40:30 -0400
Subject: [PATCH] NFSD: Prevent client use-after-free during blocked-lock
 reaping

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

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 142ba7d80539..4acd02f1642c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -357,6 +357,16 @@ free_blocked_lock(struct nfsd4_blocked_lock *nbl)
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
@@ -7591,22 +7601,29 @@ nfs4_laundromat(struct nfsd_net *nn)
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


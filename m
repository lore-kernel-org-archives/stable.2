Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F21378D9A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578917; cv=none; b=GdCcwYQBEmCfLz9XGoQEucrEz7uFSLrVQbzwtX4ffuNfWigRkRPkQ29svuZT/e9YHr5yLyVt2bw0PhcT7cWiNfR71e4oaz8WKp9hBgPRHgywwadMzmqY6SE2T6dj65zXjA+jGWzTyiRSsz8hkV+AkBp8GPdHTJ50igLRPQKtqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578917; c=relaxed/simple;
	bh=vLAH3R7io0+Dc3vlvdIPjArNFVqBcHFgXPLfTCJGAFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNXzGSrqD2b6jBsYXC2/MuZg5pRienbKZpEPu4RnY+8onefAIhUCNm3ybuqrnmDfEY0H21jkqnzO/X9fzFljeXIErKJkPHmb2bFrFidUCsQZgnRIhfUpgwtzhbfoLlJ2URH+FPMpefC7QyX1R5M/V7WvYWI0SGOIBXoSEIXVNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEP0K+8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEP0K+8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE21F00A3D;
	Sat,  5 Sep 2026 03:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578916;
	bh=1HrPsF4KDrtk4JpJQl+13+WLeXV6CuIRqNbnPzWy7vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jEP0K+8cGqvxHUPUM3xZOzS5d3aV18RmaTNKLm71+NjjLBUIWSuNlRYZX9QLebKfo
	 R9GSoZ4FlFSZT6ip7jQGm4AaZAZ1Sw69c8zj9wIkTJO3ZlaShIeDqgd4FHpO8lWgJ1
	 1t0MSx3OESwu5jdp/YRXfcgESCL4NvqY1xK0ZVWbGZubDtX3r7eEHBHQ9KkB2Kyifx
	 H7JmBis9r97pHgS0PZ7itRBqNz4dZQNd9ZIHIE+WX9KCHQuMVoBAbVLdRGM2XqENrr
	 42h9+Sx7B9AiNsUJSdihXcZfNflQhoRNZjmntJfQxUu9JbaLZb1A/7ygqEmvgIkEDA
	 GXepR7CIKNFRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] nfsd: use workqueue enable/disable APIs for v4_end_grace sync
Date: Fri,  4 Sep 2026 23:28:32 -0400
Message-ID: <20260905032834.1915305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090325-overpass-emoticon-993a@gregkh>
References: <2026090325-overpass-emoticon-993a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

[ Upstream commit 27e383ddeb3c88e20874c545285f2dce1a98f56a ]

"nfsd: provide locking for v4_end_grace" introduced a
client_tracking_active flag protected by nn->client_lock to prevent
the laundromat from being scheduled before client tracking
initialization or after shutdown begins. That commit is suitable for
backporting to LTS kernels that predate commit 86898fa6b8cd
("workqueue: Implement disable/enable for (delayed) work items").

However, the workqueue subsystem in recent kernels provides
enable_delayed_work() and disable_delayed_work_sync() for this
purpose. Using this mechanism enable us to remove the
client_tracking_active flag and associated spinlock operations
while preserving the same synchronization guarantees, which is
a cleaner long-term approach.

Signed-off-by: NeilBrown <neil@brown.name>
Tested-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9b57793863f6 ("nfsd: dedup nfs4_client_to_reclaim inserts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h     |  1 -
 fs/nfsd/nfs4state.c | 22 +++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fe8338735e7cc..d83c68872c4c3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -67,7 +67,6 @@ struct nfsd_net {
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
 	bool grace_end_forced;
-	bool client_tracking_active;
 	time64_t boot_time;
 
 	struct dentry *nfsd_client_dir;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9d9a7d46e7b2..8c47c7fbd6a34 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6653,14 +6653,14 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
 {
 	if (!nn->client_tracking_ops)
 		return false;
-	spin_lock(&nn->client_lock);
-	if (nn->grace_ended || !nn->client_tracking_active) {
-		spin_unlock(&nn->client_lock);
+	if (READ_ONCE(nn->grace_ended))
 		return false;
-	}
+	/* laundromat_work must be initialised now, though it might be disabled */
 	WRITE_ONCE(nn->grace_end_forced, true);
+	/* mod_delayed_work() doesn't queue work after
+	 * nfs4_state_shutdown_net() has called disable_delayed_work_sync()
+	 */
 	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-	spin_unlock(&nn->client_lock);
 	return true;
 }
 
@@ -8995,7 +8995,6 @@ static int nfs4_state_create_net(struct net *net)
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
-	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -9010,6 +9009,8 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	/* Make sure this cannot run until client tracking is initialised */
+	disable_delayed_work(&nn->laundromat_work);
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
@@ -9077,9 +9078,7 @@ nfs4_state_start_net(struct net *net)
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	/* safe for laundromat to run now */
-	spin_lock(&nn->client_lock);
-	nn->client_tracking_active = true;
-	spin_unlock(&nn->client_lock);
+	enable_delayed_work(&nn->laundromat_work);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
@@ -9128,10 +9127,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
-	spin_lock(&nn->client_lock);
-	nn->client_tracking_active = false;
-	spin_unlock(&nn->client_lock);
-	cancel_delayed_work_sync(&nn->laundromat_work);
+	disable_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-- 
2.53.0


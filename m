Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273531;
	b=sZy7eH2rjfgj9rYe1lB8AKZ9wFVWCPX48dF3D5OWg6KCPfMeFfWcTmn0dEmTRqbHbTlq
	 On1evqCTodFpp+Bj7CrWBiX22oMFICgPLHcFQE6Av+qi4M1DI8d5AdHk0iNn/N//BFmU5
	 A/k09arJ6PXAVt5LNlpTi2hRUDWMIvihalW4mlOeUO0Lna5oUUfAu+h7hzNe+d1PYo6PT
	 Yq+5EEyDha4EZcUKkQXwjwy7hPqqPbMhUYl7t7T2XgTM6rU1zqNB3pk9QLUSNqFQG7W7o
	 XdLgrxyUDRhXz3SrNIO/o7dkq8ZlL+9qSfP8y4e3+JDRfdl402d9L5A743mpUNXxWAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NRygqg2jFvU5ESHhvzWGeUf45PWZdVc/df4PC/H45hw=;
	b=qNzFaxZPDBqy+5qgcWQDU3fXgCzc9VMGPYObM2gYJNsUCNiId5C1mDNKBdfoBjyhQKM6
	 A9VQlpPqXY+B+KF8yAzjejiObnifVuAEfPCwSWV7Ks3Emx2IH55ky/XRrVknoCqo38+ue
	 4TbXZ2CyDrACaZtPfptfh1+nsdRj8YLGy16o7J5XZdDatMCG82BLZEHd6vNGA2PKYhvaj
	 IlDsQYlEjQgKnAwzvi5ZSYH8Hxsf3NxhmPn/BsDn1PpyUPXvUhEh2jgFmLwLLK++zxkHL
	 +GdJzHLkjFSUzoSGWSPOYuKL1N+ZJ8hhoZGkGdZHXXm2MQVVTWZKRnN4Y01KYK4vhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM+09GLY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18310606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM+09GLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A51F0089F;
	Tue, 10 Nov 2026 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273530;
	bh=NRygqg2jFvU5ESHhvzWGeUf45PWZdVc/df4PC/H45hw=;
	h=From:To:Cc:Subject:Date;
	b=KM+09GLYiKv3SRjEQCypLEvQtq9PISPDSpzYrN7U8jdwKBoPHrHPAf/FdKZx2czxU
	 o3f6m36x764SRY9mi8lBo1ER3ZOIvEA+xzdNFO1GSUexUF+rD779vljvxFmzziMMb9
	 AfGG1MFgN+pW2JXhpnVVNaIpMmsEeB8C6pr4Dm8TATeAlIzJ64T7Mz+nJNeFyqjMfy
	 avx9v22snvCvkytYNrgDpeVWoWEQv94c5Q5iqLbNoGnQo4eBy9JuboiJ0F6faun9MS
	 Jt/EbthBwLQ6lc5FYaS2KSSowOJNM/fpnLA4TP780gZjzD+rVCddocJhue+DQxVv9R
	 +v8DO8pwREyHg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	gourry@gourry.net,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory-tiers: unregister empty tiers outside memory_tier_lock" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:49 -0500
Message-ID: <20261109201849-failed-6.1-500624f28eca@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 500624f28eca441e35f978979ccfb373202fefd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201849-failed-6.1-500624f28eca@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 500624f28eca441e35f978979ccfb373202fefd3 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:15 +0100
Subject: [PATCH] mm/memory-tiers: unregister empty tiers outside
 memory_tier_lock

When offlining a node's last memory empties its tier,
clear_node_memory_tier() calls device_unregister() while holding
memory_tier_lock. A concurrent sysfs read can hold a kernfs active
reference and block in nodelist_show() on that mutex. device_unregister()
then waits in kernfs_drain() for the read to finish and release its active
reference, while the reader waits for the offlining task to release the
mutex.

Return the node's former tier from clear_node_memory_tier(), making the
helper more similar to set_node_memory_tier(), which also returns a
memory_tier pointer. Let the caller unlink an empty tier under
memory_tier_lock before rebuilding demotion targets, then unregister its
device after dropping the lock.

Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-46-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory-tiers.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 25e121851b586..8eda313cf6192 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -572,21 +572,14 @@ static struct memory_tier *set_node_memory_tier(int node)
 	return memtier;
 }
 
-static void destroy_memory_tier(struct memory_tier *memtier)
+static struct memory_tier *clear_node_memory_tier(int node)
 {
-	list_del(&memtier->list);
-	device_unregister(&memtier->dev);
-}
-
-static bool clear_node_memory_tier(int node)
-{
-	bool cleared = false;
 	pg_data_t *pgdat;
 	struct memory_tier *memtier;
 
 	pgdat = NODE_DATA(node);
 	if (!pgdat)
-		return false;
+		return NULL;
 
 	/*
 	 * Make sure that anybody looking at NODE_DATA who finds
@@ -604,14 +597,10 @@ static bool clear_node_memory_tier(int node)
 		synchronize_rcu();
 		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
-		if (nodes_empty(memtype->nodes)) {
+		if (nodes_empty(memtype->nodes))
 			list_del_init(&memtype->tier_sibling);
-			if (list_empty(&memtier->memory_types))
-				destroy_memory_tier(memtier);
-		}
-		cleared = true;
 	}
-	return cleared;
+	return memtier;
 }
 
 static void release_memtype(struct kref *kref)
@@ -884,13 +873,21 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 {
 	struct memory_tier *memtier;
 	struct node_notify *nn = _arg;
+	bool empty = false;
 
 	switch (action) {
 	case NODE_REMOVED_LAST_MEMORY:
 		mutex_lock(&memory_tier_lock);
-		if (clear_node_memory_tier(nn->nid))
+		memtier = clear_node_memory_tier(nn->nid);
+		if (memtier) {
+			empty = list_empty(&memtier->memory_types);
+			if (empty)
+				list_del(&memtier->list);
 			establish_demotion_targets();
+		}
 		mutex_unlock(&memory_tier_lock);
+		if (empty)
+			device_unregister(&memtier->dev);
 		break;
 	case NODE_ADDED_FIRST_MEMORY:
 		mutex_lock(&memory_tier_lock);
-- 
2.53.0





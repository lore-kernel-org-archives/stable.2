Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450825;
	b=ZVUVlc2vEtzN0SKRMYQbf7D3Pm3C7NrKdWuNSTfKrUrIlUiiwZlNfU1qFnQhTzD3xKoj
	 YkDKutEDBkF+ZWMa+3SU3xA7yYGFcA8nODxHj6ShXOx6sxYPMUHfGsPod/WzyFCXVuchh
	 QQPbGPPkCuTy1mSlALycxJNjYOgzYB9YoksxHGVyLH/LGPv6mjaaSzrda9fKvwvYMNiO8
	 nuDTtxuFc1NRmvPAu2/8sVBCL+WyBy8NEH/SA7nthwwHxiUMNV2IzLW1fGgqb43UGlLPr
	 fA4XuwJo4C2vWWmApeYToZVTcbRb7FI/NqGdQDTjKynswbA/xOcBNeT5ubvmDP4i4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1B6fi4Ecvv4PV1ftyLVkdLlwLYu5vLqVrhQkbYdiK3U=;
	b=c2kv2+9dc/dTcBLt5CIX2yAkw71KnX9hSzk9mv7qdZSOa6g4KSE41y7fhdcIvDR2e+cP
	 F91fng6tj2aVtrDyAxyqxCAMq4ErVfLWFNkJvdM0tDRrDDB3Xs2kCAeWATPrIgTKAJR2u
	 Mc8TnSBt4I3pFjwR93hvlpfDGsVm12hOXSmzQueDRN8lHiMJhxBZoPNXX/lTOgt2ihDpA
	 +CDvgPW+vB+j9BQm6dVNP8BG6fCNESr1DMKR9+yaXJ7sIZa+YQvMl9HnwHdG7jYenWG8w
	 C3nLPlCK6xeIjnW8obigPLKgoh8XP80Y+i/aQLlRMQOnTxvnvwJKTCpkoPUW/LXgLSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EalWNyay;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BE606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EalWNyay
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C64F1F00A06;
	Thu, 12 Nov 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450825;
	bh=1B6fi4Ecvv4PV1ftyLVkdLlwLYu5vLqVrhQkbYdiK3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EalWNyaygoO6Qw9GUil+zfocju1NeeKMH2rR3ga3Tq8mGX8x1bng2jh/Ble7ye/6Z
	 XNulAFi+ERLnXxsaunVBVT3HZ6CW5h4dRkUs5aNdKI8LTFUC7xq6vdeD4M703M3bRV
	 gVpta3JK2GZ6cJS/CCSkxamP6Q6nFXC+1X1xLq1PYcmPiz1k95D7dGVIp1zuHxxYMg
	 5hwFivGr92OUG2z4z7Oz9yCwRvVL9vK5NnJJRxB0HKUGynr5Rtw2bQsYlrrsNut3HE
	 T2fGUANAmNgGrck0V1+a/GT4f8NQ0WRCc8JMz+xlCcDVUTp4DUfEMwaQ+RRgi2tOFj
	 O3iE1WCNPt2nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/memory-tiers: unregister empty tiers outside memory_tier_lock
Date: Wed, 11 Nov 2026 21:33:43 -0500
Message-ID: <20261112023330.1376745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201402-failed-6.6-500624f28eca@kernel.org>
References: <20261109201402-failed-6.6-500624f28eca@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 500624f28eca441e35f978979ccfb373202fefd3 ]

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
[ sashal: adapted node notifications to memory notifications using status_change_nid and the existing last-memory guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-tiers.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 93cb8eed4bc23..72995fe83f47f 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -502,21 +502,14 @@ static struct memory_tier *set_node_memory_tier(int node)
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
@@ -534,14 +527,10 @@ static bool clear_node_memory_tier(int node)
 		synchronize_rcu();
 		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
-		if (nodes_empty(memtype->nodes)) {
+		if (nodes_empty(memtype->nodes))
 			list_del_init(&memtype->tier_sibiling);
-			if (list_empty(&memtier->memory_types))
-				destroy_memory_tier(memtier);
-		}
-		cleared = true;
 	}
-	return cleared;
+	return memtier;
 }
 
 static void release_memtype(struct kref *kref)
@@ -757,6 +746,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 {
 	struct memory_tier *memtier;
 	struct memory_notify *arg = _arg;
+	bool empty = false;
 
 	/*
 	 * Only update the node migration order when a node is
@@ -768,9 +758,16 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 	switch (action) {
 	case MEM_OFFLINE:
 		mutex_lock(&memory_tier_lock);
-		if (clear_node_memory_tier(arg->status_change_nid))
+		memtier = clear_node_memory_tier(arg->status_change_nid);
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
 	case MEM_ONLINE:
 		mutex_lock(&memory_tier_lock);
-- 
2.53.0


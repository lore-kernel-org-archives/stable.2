Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451158;
	b=h92bjz/36I8y13HhTS8G8YH5mUlIey0HAmuxF9bvCDUsKV/OdMJ/bW5pYl37taNBQxlN
	 pwfdwN04zxt3vtOVu+BrgXGyELedVybGwWwMDQyJMqd/d6Ln58TdYUZhnkdCedo7x1UDP
	 HkCi3dLOiuDCZflsJ5GQf2AXEHZzJBRcebTIhjnCl0p4KIA2HaPvFzgBwf/7OyNwiv9Lh
	 x14VDkoJMmzLrdA4QGqNEv43UiS5LB2YMKxmO8sUuxO5n0pMMs/O5azQRjPaY8N7YUW5S
	 biRNbvP434KXPpIp+CKEYL17WntnLymXP/nK1vkM7jmBRR0eQRyrdKZhGroan1tvtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/s8w8plmH88dsVAGSoItILgEzxooWOwVGFGCpt2lqf4=;
	b=oDNsvROhw1hrPtb3SjFKDdV/D8HmtDe6KiaD9cJz7OXmBRUbAgMhiqUqmVmbKzsTHuKs
	 Y7kmhvI721VLLPKGRCeA8QKDx42zkHfwE3T1p4nfdK293xUqqace8trcMBstVhj6+2Jsv
	 8/D0RCnBBvdvCeY0AUc6/qSknOk8Bxz16KytpKOQsbBBJfAL8bWeG5Da+eNDydks2pH1x
	 7vYNlGwFsZ+93qal9VpPykphJmO5v2xh8x9DP9ZSH3iDgWnfAx31dbmYQ7HihDqI6YDji
	 wBWbzZ57yqF5+8g3IBSOhT2npFxwE3x4zUgZiEL7m/k6+K5TVXl5xsqg1iVjRUsq8KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jxnd/lu1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B4606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxnd/lu1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A451F00A05;
	Thu, 12 Nov 2026 02:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451157;
	bh=/s8w8plmH88dsVAGSoItILgEzxooWOwVGFGCpt2lqf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxnd/lu1vcxUfY9GbAnW8j9lff05Ilm88rWnLy3dPYKXc667TtLjvYNna8Gd+6aDK
	 kcxYesLjvmMWl3ttBrS3LHlL7mpuc1FRpSEPeTqQ6HqGJtcslZ9dhOOWF3a4Rym47X
	 +9HMK4gTHzmtalrqNWV96s69spqWYybXRVEoMuxQECHEiQGSkQop4sq1PDdNdAGsPn
	 o5HHQ/NFAMcXEppIR0d5kj1wZqIVhWlvciNBWJxjuxTQvvOasJKrkIBFvqQSiIiNGK
	 3KY1DyC5Kd69vAl6+lmwxSRFeZ89+MdeE1BDybSK1+hxlHOMyF+Rk+chDllmT1O8EF
	 pYIRnpTqHcuUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/memory-tiers: unregister empty tiers outside memory_tier_lock
Date: Wed, 11 Nov 2026 21:39:15 -0500
Message-ID: <20261112023846.1410920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201849-failed-6.1-500624f28eca@kernel.org>
References: <20261109201849-failed-6.1-500624f28eca@kernel.org>
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
[ sashal: adapted node hotplug notifications to the older memory notifier API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-tiers.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index ba863f46759d3..77f531d788e87 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -495,21 +495,14 @@ static struct memory_tier *set_node_memory_tier(int node)
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
@@ -527,14 +520,10 @@ static bool clear_node_memory_tier(int node)
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
@@ -598,6 +587,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 {
 	struct memory_tier *memtier;
 	struct memory_notify *arg = _arg;
+	bool empty = false;
 
 	/*
 	 * Only update the node migration order when a node is
@@ -609,9 +599,16 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
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


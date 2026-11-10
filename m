Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273244;
	b=b1D7vJA/mbdkqssXn1cryeBzKRoiLS4TBb4BMjlVuGvy5LlPJJVCDdz6Oe7npkrjB9ac
	 +4UvgUvfh4gx+suSlF2C6MAR/cMHHSQhNHCNgInGdXiX6PLv6IodFQuqYCPw3JiRawX9f
	 Sg8L1YII169KHPXXD1gNYGDvEMLmA1vUbesH1Ks4HPWsF4ACWChlB591PBuNMmSChv4Kd
	 mEZ+Fc9RAVp58C1NFFOhEM/UGpWNZE2gaOdjgZbYpqX4PO29posq53nv6rGah5I24AOBd
	 ZzOhEBKrSflztMPUW9yud+aHApeCDAqOnXJ4lvkuLtwe8i0ijuryeE+am0G6YTb0mLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273244;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b4GqD33bDgG2jSeoAtBIBYkAngMpRaCIfPvaTq5DS3w=;
	b=eMpAeF4AqBuNo5fJLo1oEYKLzhNjQpq4VRCHpkMFFvFACPgSvMBDtzWQBf2K9q+TkJUQ
	 xoDyV0ihylZaa0HI0S1E0ZPzeGffLqi/A+moEUCRTwH0Y3QozFJRATR3XkzDHtKrIKPhm
	 CA6NegFlSNzD148LoB+hZ3vXNcShguyMqhCuWa/8euqsnrre/QRpR0Ir1jIW9+Pqs5ssS
	 m+zL6n3g5xftPXDIBoi6Rsm5SmZUubiB2Ps31eQDVXvAVFA/Uf/wtqN+z/NUdpdC7G7Tz
	 bFa22HbeK7CPiq6j5G3W6q7bIIY997przxB05Cv0P1eMYvWVSIF26VOXjW/FmjwrWrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C05Vbqdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C05Vbqdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E86B1F0089F;
	Tue, 10 Nov 2026 01:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273244;
	bh=b4GqD33bDgG2jSeoAtBIBYkAngMpRaCIfPvaTq5DS3w=;
	h=From:To:Cc:Subject:Date;
	b=C05VbqdfF+ZmP+AI3xpromn/QSe/cMfItvwtijzszty6e4i1wkpvQSHIeLSsK/o6e
	 aoXSkN4dg8W/EoJ8v+QgtJ2i/lFR4lu20dbbd5gWY6fCXfpi7QHiAcFl8NT+hZH1uj
	 hQaIhsEsbR8p4ePdgT7i/tVfVOJCG59nRHnoq2jmkBBtF9ZlkdAJRMRS+BRUYC0gKP
	 z4RUoQCNm4GO8hwvmUf+9CQ1KB9zTsOLkmYKdjd3Z1z9QIuR0P7v+ndZYtpIV86p25
	 XQJ7b6BxH4clFQPcIJRorBxaokYN77JKb77ag3xLRcD9QI5AR7Tqbe4i0tpIjG3iU0
	 Q8dUrBD+TgXlA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	gourry@gourry.net,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory-tiers: unregister empty tiers outside memory_tier_lock" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:02 -0500
Message-ID: <20261109201402-failed-6.6-500624f28eca@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 500624f28eca441e35f978979ccfb373202fefd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201402-failed-6.6-500624f28eca@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





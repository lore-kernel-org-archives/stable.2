Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450182;
	b=p9i/DiuwNslYGKGDj0bgw+gS5/ptRF0UloZ6JLjyHsYvc23eBLFuEmGLebLWTt9Qe1Q7
	 QGn5TjXu1ztpBl8r9Fj7lzE9+LXnVx+VxZUQ/A0gjLpveO1/qLy1OlpQMzSSbPyodwCrN
	 p/ofqz0OuCwdg2eVKnpfUdsZIvWRsrS57R0YEiJxruFSGtwExgw56pB/BCHWcU4q5rUxS
	 zYFSKUpZaol4gaQsJ54tbUFgwPE4+R3y3oGPT/86aNWDuro6HbE9BxEddztJwAlw+SNBQ
	 GLSIbFOvmmjhmcDPoZbWTZWV+5EibJ+xEGqfxeI55u7gKECP7aOitsG7YSmTpokgJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WkOXKriwGpMqNC9sry6zVAUZSF+VIaFbOYU/4yr0Ows=;
	b=cMe7lB/nMYjNmbkqd8uLixx7zoCG6amcFkCInoSz4PVJJ4v2HmS7zLkPETvHaBssydwj
	 ElnmJ3vPVUI9+gBt+1Cx4FqPUpfvXeKyDl8wHszVdhLCXMSECekpsjx1D1beuvLRYMIXr
	 g81S6TqZcv7JdlLSWJRvEo2h4Y5D6oeQw1kEGRsG3FAjhclHdtyEbxVr8kwPDShUZrSxL
	 Zwr7/0S1hcYCOE471eZGOcisl11a0U4PJsmRQvn432lZM0fZqf5u2tI/Mmim+da1lwrK2
	 0jXlBfFVXJu7kwKGC4S3EclSNkANkp9U3oOMziOfpg0Qs6QWJ2N0J86AgUvKzjPrHBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlskag29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB2606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlskag29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255EB1F00A05;
	Thu, 12 Nov 2026 02:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450181;
	bh=WkOXKriwGpMqNC9sry6zVAUZSF+VIaFbOYU/4yr0Ows=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vlskag29bS51whnWdiCNazuoYvGLdEVi4UWcCVMuWqzwvbIGgN2JQXRVoAXZJAQSt
	 x7IoJh1/O6AWPjrPKVaReCeTKECorThVfFHmr4XTjEu5Sykq2gPofOEgwy10vfU+I4
	 m2cx1YxgIaVis7jgFGAD3n2yYWnQ1LHPwkc08H2uUuaaYMngksOqcAS5iwlyqgGOnT
	 3UzLiEmbACVKwUY4QtwVW0/RBDzrLQgsl77nPFMavTv4vWHDUizu/52IgZHjsA/6jg
	 ZPIXZFkpDG5hILYCGdvT8wiwrBW+eAEbRNA/vqACRAxkJfCcb1Lpkv2Q6P3fmSthZg
	 x3pXtAiXgIxgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/memory-tiers: unregister empty tiers outside memory_tier_lock
Date: Wed, 11 Nov 2026 21:22:59 -0500
Message-ID: <20261112022111.1345214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200921-failed-6.12-500624f28eca@kernel.org>
References: <20261109200921-failed-6.12-500624f28eca@kernel.org>
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
[ sashal: adapted node notifications to the existing memory-notifier API using arg->status_change_nid instead of nn->nid. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-tiers.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc14fe53e9b75..a8733cd8d554b 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -561,21 +561,14 @@ static struct memory_tier *set_node_memory_tier(int node)
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
@@ -593,14 +586,10 @@ static bool clear_node_memory_tier(int node)
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
@@ -873,6 +862,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 {
 	struct memory_tier *memtier;
 	struct memory_notify *arg = _arg;
+	bool empty = false;
 
 	/*
 	 * Only update the node migration order when a node is
@@ -884,9 +874,16 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
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


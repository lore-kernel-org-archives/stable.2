Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F03905EE
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686689; cv=none; b=J43iao2pMJM4fRnoXyVU+u2A8tNdJjn4EKz+M0/uVVPGqwacvrmG5jv9Ayh6h5sPvXYb/9KohGiMWRKaXgf1t87/ARb+M2rD0D1NJmLpLlgccngfs4NSmlTplM1c+LK9H1nG6CSRJgdpDumSQ8in65CWuWQQMRDLcplJUxclROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686689; c=relaxed/simple;
	bh=B1fSA4lHmjp6pyVCM5e1W4YXWgAA4KKl6On33givD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UU4vMu4Wj13h0JJoBg3ZbsZCjm9qt/XsUXQB4/+wwqnzuG34wy2HRlAZrv28bWemHcLKZQ5FleyLB104de3mtXGf2RNpsTGXVquGq7MIOOiWNPDqDzx7kHAY2aydm9D9PeJ4e2Vcvs5e+jQIx0cocQfa17zIWzvc3CM8ftV+2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfigpFQs; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfigpFQs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781686681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z+0oawbYAvCbDfWFytofWS7kpNw2bfjZSR+3b+oyM0U=;
	b=bfigpFQs9ZnUA/co/pq01dfms67+/z/n4KaDrR9aRUYNVt7dKK/khuGJihn5qG6Eue6TU0
	mt5Yit1VbnEyZ4hA+KOqOgs+TvRAp6qNpcUfjm7PC2kwyV+brJky8g+C9dF8kyG2RewbuZ
	dYbU1vX6jzmjOnmBsPMQNxaiT38w7cw=
From: Qi Zheng <qi.zheng@linux.dev>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: shrinker: fix shrinker_info teardown race with expansion
Date: Wed, 17 Jun 2026 16:56:58 +0800
Message-ID: <20260617085658.27096-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

The expand_shrinker_info() iterates all visible memcgs under
shrinker_mutex, including memcgs that have not finished ->css_online()
yet.

Once pn->shrinker_info has been published, teardown must stay serialized
with expand_shrinker_info() until that memcg is either fully online or
no longer visible to iteration. Today alloc_shrinker_info() breaks that
rule by dropping shrinker_mutex before freeing a partially initialized
shrinker_info array, which may cause the following race:

CPU0                   CPU1
====                   ====

css_create
--> list_add_tail_rcu(&css->sibling, &parent_css->children);
    online_css
    --> mem_cgroup_css_online
        --> alloc_shrinker_info
            --> alloc node0 info
                rcu_assign_pointer(C->node0->shrinker_info, old0)
                alloc node1 info -> FAIL -> goto err
                mutex_unlock(shrinker_mutex)

                       shrinker_alloc()
                       --> shrinker_memcg_alloc
                           --> mutex_lock(shrinker_mutex)
                               expand_shrinker_info
                               --> mem_cgroup_iter see the memcg
                                   expand_one_shrinker_info
                                   --> old0 = C->node0->shrinker_info
                                       memcpy(new->unit, old0->unit, ...);

                free_shrinker_info
                --> kvfree(old0);

                                       /* double free !! */
                                       kvfree_rcu(old0, rcu);

The same problem exists later in mem_cgroup_css_online(). If
alloc_shrinker_info() succeeds but a subsequent objcg allocation fails,
the free_objcg -> free_shrinker_info() unwind path tears down the already
published pn->shrinker_info arrays without shrinker_mutex. The
expand_one_shrinker_info() can race with that teardown in the same way,
leading to use-after-free or double-free of the old shrinker_info.

Fix this by serializing shrinker_info teardown with shrinker_mutex, and by
keeping alloc_shrinker_info() error cleanup inside the locked section.

Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 7082d01c8c9d..a70aab124a0e 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -59,12 +59,14 @@ static inline int shrinker_unit_alloc(struct shrinker_info *new,
 	return 0;
 }
 
-void free_shrinker_info(struct mem_cgroup *memcg)
+static void __free_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_per_node *pn;
 	struct shrinker_info *info;
 	int nid;
 
+	lockdep_assert_held(&shrinker_mutex);
+
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = rcu_dereference_protected(pn->shrinker_info, true);
@@ -74,6 +76,13 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 	}
 }
 
+void free_shrinker_info(struct mem_cgroup *memcg)
+{
+	mutex_lock(&shrinker_mutex);
+	__free_shrinker_info(memcg);
+	mutex_unlock(&shrinker_mutex);
+}
+
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	int nid, ret = 0;
@@ -98,8 +107,8 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	return ret;
 
 err:
+	__free_shrinker_info(memcg);
 	mutex_unlock(&shrinker_mutex);
-	free_shrinker_info(memcg);
 	return -ENOMEM;
 }
 
-- 
2.54.0


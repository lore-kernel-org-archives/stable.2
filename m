Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D93644AF
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311913; cv=none; b=MF56EgaJ5Z22mfDggqIR+4Dpid+RcdS50Bfoox8NiScfTNL3XhT7B1M+HMDjDJXB61Y/L7eamekOyIWms0KYsMC0ZAgdkR5Uf+uX0znwofzzI5InM9kc/GRLNsPfkN0F/22a0cFwn9yO2XVXD0qkzYVyoHqRxgDzo6zADIHLUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311913; c=relaxed/simple;
	bh=pSRI0rZ4BfTUmCaIpkpM4W93AlrvZlRSwULn6Tteb4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9wxUQ+s068+heeT3Hqb24eprofG+l7pEaTLeHez/t39eufWHvwYbGZcnimufaazAFaNFpfjrKB8WDxOq1NP1G0ZeHlJDtaY/CYxJG8CXmsr3ljDDcKeTZWjVxGA2WUxxYngsoY68AbuZcMN4hNy59dVNWVGvPyfbymBKm5lvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL888p/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL888p/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145A1F00893;
	Mon,  1 Jun 2026 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311912;
	bh=3iMF883LjtmwNFfGkcdvXMVzIow9/nMZ9QWeFOv+dZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IL888p/Fhgy/YqUgz6+tTR4UiVZioERFLpIQdygqY9noX+eQ8Ty5T9MSaBiWVrnwL
	 lmunyriGDcevd+m6/yZIwuXePSzrHqGNxf+59ZUKVgAIMWengvD2K8g2EPXgP7mMW9
	 lKKG/HDAeKMAQDhvjdxv2nxtSnEqslb2JvGGwi6Ni3rJKtClP0LNUOlKX8A/vNFy53
	 t2ICGRr+/hxW8wrcz4LQChyNk1IQD5xlH+vN9rYVJpWDncD0LSbqS4DKZAkK1J9e5f
	 aGZxWaqy/3nuyS/HEPh/WK6IcTwLuALw6FlxpEIIdBTjZx6eTLYgr9KluWBYMZIvY/
	 6KZaQdWYWudIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Wang <wangqing7171@gmail.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/slub: hold cpus_read_lock around flush_rcu_sheaves_on_cache()
Date: Mon,  1 Jun 2026 07:05:09 -0400
Message-ID: <20260601110509.447056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052843-flavoring-boat-ccba@gregkh>
References: <2026052843-flavoring-boat-ccba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

[ Upstream commit 67ea9d353d0ba12bdbc9183ff568dead9e949b80 ]

flush_rcu_sheaves_on_cache() calls queue_work_on() in a
for_each_online_cpu() loop, which requires the cpu to stay online.
But cpus_read_lock() is not held in kvfree_rcu_barrier_on_cache() and the
set of "online cpus" is subject to change.

There are two paths that call flush_rcu_sheaves_on_cache():

  // has cpus_read_lock()
  flush_all_rcu_sheaves()
    -> flush_rcu_sheaves_on_cache()

  // no cpus_read_lock()
  kvfree_rcu_barrier_on_cache()
    -> flush_rcu_sheaves_on_cache()

Fix this by holding cpus_read_lock() in kvfree_rcu_barrier_on_cache().

Why not move cpus_read_lock() from flush_all_rcu_sheaves() into
flush_rcu_sheaves_on_cache()? The reason is it would introduce a new lock
order (slab_mutex -> cpu_hotplug_lock). The reverse order
(cpu_hotplug_lock -> slab_mutex) is established by

- cpuhp_setup_state_nocalls(..., slub_cpu_setup, ...)
- kmem_cache_destroy()

The two orders together would form an AB-BA deadlock.

Finally, add lockdep_assert_cpus_held() in flush_rcu_sheaves_on_cache()
to catch the same problem in the future.

Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Link: https://patch.msgid.link/20260512035035.762317-1-wangqing7171@gmail.com
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab_common.c | 2 ++
 mm/slub.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0f58265ca200e..04583044a2bf0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2135,7 +2135,9 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 {
 	if (s->cpu_sheaves) {
+		cpus_read_lock();
 		flush_rcu_sheaves_on_cache(s);
+		cpus_read_unlock();
 		rcu_barrier();
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index a89df6ddcc587..5fdec3b837060 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4203,6 +4203,7 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
 
 	for_each_online_cpu(cpu) {
-- 
2.53.0


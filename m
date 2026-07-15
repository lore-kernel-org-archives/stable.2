Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38819370D6E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115648; cv=none; b=NcsYonRA7aaxeMXUCsaI1/vl/KdtEXvosyjYf5eu7ux9J3oyS+QT5fghZDAmt4wDfb+Scbst3CVgBGi3y4prLHNYKaPGOCMri0rvaHa+Ic2MIlqI4wQYu/QQ/mNzIc2bQEfPFKHOsvITCOyuEK73DF81KNKELerGCgNjYCWBohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115648; c=relaxed/simple;
	bh=RFHhQfxElteARj2RcdPs/S4uUGEoMld/klgTGJ0oDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt7LqFV3eJmy+PJ6IG077NU0ROQJ9y/hB+ms+stfZY3qQkqqjBC+1VRvUAnFxXKVMrH078xw0cL9bbiRymBtTnnZgRaFjFb0zzc/oIkPYSEVI20uTOnBHWPWUdD5k/4gx50VU5Q9fkU5OZ+foMucg1MOvBeog1H23cr7Y/RsJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss6qkqVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss6qkqVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A41F00A3E;
	Wed, 15 Jul 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115646;
	bh=dUmNmBym/Z+Lx9nrGYigGkS5Z2Svkhr974r6mshNWBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ss6qkqVAsrON7iH0eO8Ex8fsa0sNAqmz77rO0nZ9E90r2nzUffY1OsAoG1N7a3F9L
	 OCMEbInO730b7NiFZG1PdXh/wb6uGApdxPFugCT0U5z2Lxe6Uxgzb13D0owVhf9JvM
	 cfVsPiezqkK+6yuI2QCEjDUxdmtsuD4FEFIyWoicB1/vY7gbkxQhAH8zIyAUwZXrxN
	 i/bheQEFXO2da/dYT+S/EM0wu2ZrdpfatnWhKIs3D76EMcQRCmHt3c4WeCs8A/M7yF
	 6quoYpWjPKRJgCmxl25axcgYLth/i7HdJwXHm9/PbJuu6mJCD13BgG/PF5IjYRzUq3
	 BOkRbAOMefC0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()
Date: Wed, 15 Jul 2026 07:40:37 -0400
Message-ID: <20260715114037.728053-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715114037.728053-1-sashal@kernel.org>
References: <2026071317-sandfish-tulip-2010@gregkh>
 <20260715114037.728053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

[ Upstream commit b902890c62d200b3509cb5e09cf1e0a66553c128 ]

Reading the debugfs "count" file of a memcg-aware shrinker can sleep
inside an RCU read-side critical section:

  BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:421
  RCU nest depth: 1, expected: 0
   css_rstat_flush
   mem_cgroup_flush_stats
   zswap_shrinker_count
   shrinker_debugfs_count_show

shrinker_debugfs_count_show() invokes the ->count_objects() callback under
rcu_read_lock().  The zswap callback flushes memcg stats via
css_rstat_flush(), which may sleep, so it must not run under RCU.

The RCU lock is not needed here.  mem_cgroup_iter() takes RCU internally
and returns a memcg holding a css reference (dropped on the next iteration
or by mem_cgroup_iter_break()), so the memcg stays alive without it.  The
shrinker is kept alive by the open debugfs file: shrinker_free() removes
the debugfs entries via debugfs_remove_recursive(), which waits for
in-flight readers to drain, before call_rcu(..., shrinker_free_rcu_cb).
The sibling "scan" handler already invokes the sleeping ->scan_objects()
callback with no RCU section.

Drop the rcu_read_lock()/rcu_read_unlock().

Link: https://lore.kernel.org/20260610232048.62930-1-shakeel.butt@linux.dev
Fixes: 5035ebc644ae ("mm: shrinkers: introduce debugfs interface for memory shrinkers")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Closes: https://lore.kernel.org/all/c052a064-cddb-494f-a0d8-f8a10b4b1c4d@linux.dev/
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
Tested-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shrinker_debug.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 61702bdc1af48d..56b1e3a5020dd5 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -55,8 +55,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	if (!count_per_node)
 		return -ENOMEM;
 
-	rcu_read_lock();
-
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
@@ -86,8 +84,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-
 	kfree(count_per_node);
 	return ret;
 }
-- 
2.53.0


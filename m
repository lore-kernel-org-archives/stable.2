Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608A35DA43
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133019; cv=none; b=C0zEfC/palPBfBXtbTGIB8Tdwe5Pyq/Gp7XrmG3sjv+ERcvqqXCsoz7iqBBhPjhM/9Q/ssig2hQ2lu9m1N+3LRJlnibjU0b8uYjgISS3wQ6JZ9YGhWBztk//WSE21e+SB0GiOkwoZN/UUyGVPgMZRX0+anDAzeIUekpoB/I40UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133019; c=relaxed/simple;
	bh=1s1qibg43Wp2YNjXrofhytdQGEaNBIgPfBIcdTIe4iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl5jpJn0qpFl+pbXrN0B79byhcDLRqmVPb4GrtT/ZVidpv7C5uxEGY0KrrOEtzn8vFekTnV8NYhi3SfKgRGqHQLvOlWwIgq4Ixdy3U86FLfIZaN0xm9L/K7nlvgiCEYmrz6ghDXKMjv1LbAPJ6dWPK79FH18Wz9t1mVI4/I1MmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL6Qzz6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL6Qzz6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5813F1F00A3D;
	Wed, 15 Jul 2026 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133017;
	bh=OtvHW7DdF2PFA0Y1xvmn1rUxtQB7PLFknr3CaOn0pDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BL6Qzz6ES3Opv5yQ01ecKDhe7ZkhCjjm1qmpeUjpPd0nU9F+ee4fQrcGwpIuj6lrq
	 xXfekVtVYphUqMZ7mUxf7w8JeajTXMC8DmvUzn3qN+vDSNnEy3fvR6UAFd9kaQFeH4
	 0QzJH7EU6mAmmuz7lHJq2j5iT58c8cXH6zABQblgwLnahsMzBadZapOKqoWt0SNmfD
	 HpbViE+Lq3l6M2rwpGYGSTUJ6Ql1qX+n5APTp9B+mRqubAmv5FNy10sPB3Ovly4V3m
	 3NqsjLMumvaVh1CS23pGRAmuSKHOc+7D3QZ4onrgLTzteLujKX8XjvMAwXZLPRB4u6
	 igNop4gXMO+1w==
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
Subject: [PATCH 6.1.y 2/2] mm/shrinker: do not hold RCU lock in shrinker_debugfs_count_show()
Date: Wed, 15 Jul 2026 12:30:06 -0400
Message-ID: <20260715163006.950613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163006.950613-1-sashal@kernel.org>
References: <2026071318-kindling-retrial-f9b4@gregkh>
 <20260715163006.950613-1-sashal@kernel.org>
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
index b0d818eacbeb5d..ce8c284ddf6b8e 100644
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8042EEDE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950403; cv=none; b=aPNzxHV8UNVO33BhsYalBfLTPCghvd0pKhkMTTTKSZJzjPRGVzDkkQY2vmee8/ZOhWUTMHp/8tAnhgplSUw4hMAKPbWy/R5aF/QpxQG37hmLrrL9Kicd5MR8qL0BkiHM+ogfKYPv3+T7dZPyL/zV3FLfk163vJjum957npoWuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950403; c=relaxed/simple;
	bh=il3yrrOMYQEeJx9ce3HkgBRe9MbJxD/mSsWEP7zviQE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EumfTeKVrCdcrdV4w7T1hTk1RpFK4EsCMua0ms3WR7+yT++muWbT8JSqwjGdlesAWmbcZ8ZUAv+k2CEtzlM8CtelUY6tbDVrjHvDpOj0J9PI13qh0I6y+LtbO96G51etS5lumpniNiRGnyVokOFD5xavr9fs4R9FbmdtwCZdjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xV5YS/Vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xV5YS/Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29F31F000E9;
	Mon, 13 Jul 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950402;
	bh=6SjfR4u6rYbpm7dM3harGuhXp7nXzlooTs7n8PfQJOE=;
	h=Subject:To:Cc:From:Date;
	b=xV5YS/Vvo9T55DezudjA7i2NsYtrq0ef7GPDD3y7UyBUNs0M18G9WYIxw1MFBv5UY
	 9EnZYydwPSvqPYM4hPcPapaiQAcosBgPUQ4+yACijDX2LASU1qlqypNyLjM2e/gedN
	 7mvlO+Ac2m1hDTPp0Rcx+b/wNnzMGUGAq+9NkBjg=
Subject: FAILED: patch "[PATCH] mm/shrinker: do not hold RCU lock in" failed to apply to 6.6-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,david@fromorbit.com,muchun.song@linux.dev,nphamcs@gmail.com,qi.zheng@linux.dev,roman.gushchin@linux.dev,sj@kernel.org,stable@vger.kernel.org,zenghui.yu@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:42:17 +0200
Message-ID: <2026071317-sandfish-tulip-2010@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b902890c62d200b3509cb5e09cf1e0a66553c128
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071317-sandfish-tulip-2010@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b902890c62d200b3509cb5e09cf1e0a66553c128 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 10 Jun 2026 16:20:48 -0700
Subject: [PATCH] mm/shrinker: do not hold RCU lock in
 shrinker_debugfs_count_show()

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

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index affa64437302..cda4e86428c8 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -57,8 +57,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	if (!count_per_node)
 		return -ENOMEM;
 
-	rcu_read_lock();
-
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
@@ -88,8 +86,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	rcu_read_unlock();
-
 	kfree(count_per_node);
 	return ret;
 }


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CD3EC801
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496793; cv=none; b=MVBjsLwjR0BkopZ4zIVdRSZEvck1TkS528BLO+9ZO73NACe15TSKcphxublLt4k7pPwjkX624QS2zYQOvK6tq5wBRwOSN8RsvTsrHo5Lk0NmNDutlrhtI0B7/V0glxPtabj5mtAzIgHS8uikyrsxIRe1Zu6ENc/53VSeRr/qvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496793; c=relaxed/simple;
	bh=VMY/JC6Pk9G394uXk1SsWORYi5Qj4zw+Z967l15miFs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YRFrMAWtLn5DN05AtdGGRzMPm9bBwyyC+pHjLzZSWuY9VAZu1nvZ2aq0yEnbZ8DhCT4POsC8663j6uNElF7ESo3ZGUzNmuDsrWAPGhrFIAhbwRaIyn7cuJmCj18RtkVRzwBUapTjufvIz9Jz2h6rmSJ+HLQ0clJo/tFRtFLOm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uy1eU+4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uy1eU+4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2892C1F00A3D;
	Fri,  4 Sep 2026 04:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496791;
	bh=Xfvq/OU6+zbpiTgRBvagkNc6gxPYKs1mjQ9LY/naZww=;
	h=Subject:To:Cc:From:Date;
	b=Uy1eU+4FncI1HBE7CTPhUGRAt6rn56Gtxr0q0f5IbtgJbKJcqW4ZQAWcgWbuJLQHT
	 a2vKjng6LBHC4D5c2atx56xZ4Vb0/cRMfy/sNvZL9t57buO7/fGKQofiK4wIXYSTXm
	 pJYkx4SlA9xvgW2ctynKh0ucmRe5pPig54qE5aBQ=
Subject: FAILED: patch "[PATCH] dm-pcache: reject a kset that overruns its segment" failed to apply to 7.2-stable tree
To: hexlabsecurity@proton.me,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:39:25 +0200
Message-ID: <2026090425-mutiny-unsent-560b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 7ac1f10f987a2ffae4aecf0e2ceca8f552b665cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090425-mutiny-unsent-560b@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ac1f10f987a2ffae4aecf0e2ceca8f552b665cb Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 17 Jul 2026 06:26:58 -0500
Subject: [PATCH] dm-pcache: reject a kset that overruns its segment

cache_replay(), the writeback worker and the GC worker read a kset of
get_kset_onmedia_size() bytes and advance the position by it. A forged
key_num makes that size exceed the segment's remaining space, so the
advance walks past the segment and trips the cache_pos_advance() BUG_ON.

Reject a kset whose on-media size exceeds cache_seg_remain() before use.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-pcache/cache_gc.c b/drivers/md/dm-pcache/cache_gc.c
index 1ed513745023..c483c7a3afaf 100644
--- a/drivers/md/dm-pcache/cache_gc.c
+++ b/drivers/md/dm-pcache/cache_gc.c
@@ -146,6 +146,11 @@ void pcache_cache_gc_fn(struct work_struct *work)
 			continue;
 		}
 
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&key_tail)) {
+			atomic_inc(&cache->gc_errors);
+			return;
+		}
+
 		for (i = 0; i < kset_onmedia->key_num; i++) {
 			struct pcache_cache_key key_tmp = { 0 };
 
diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index f4459b2e1b3b..d00497f9e462 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -818,6 +818,11 @@ int cache_replay(struct pcache_cache *cache)
 		}
 
 		/* Replay the kset and check for errors. */
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(pos)) {
+			ret = -EIO;
+			goto out;
+		}
+
 		ret = kset_replay(cache, kset_onmedia);
 		if (ret)
 			goto out;
diff --git a/drivers/md/dm-pcache/cache_writeback.c b/drivers/md/dm-pcache/cache_writeback.c
index 34c34b448e04..7a85a9aed18e 100644
--- a/drivers/md/dm-pcache/cache_writeback.c
+++ b/drivers/md/dm-pcache/cache_writeback.c
@@ -261,6 +261,11 @@ void cache_writeback_fn(struct work_struct *work)
 		goto queue_work;
 	}
 
+	if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&dirty_tail)) {
+		atomic_inc(&cache->writeback_errors);
+		goto unlock;
+	}
+
 	ret = cache_kset_insert_tree(cache, kset_onmedia);
 	if (ret) {
 		atomic_inc(&cache->writeback_errors);


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93C3F8ED6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496855; cv=none; b=mcHtSkxd2qdc7vHwUCFYhW9TUx+aVYutuuYKO2kxGg1ApX97GWQvh1xfSzEMyinsxCEP/jF8SJiLqpePeHryVNxH9vDxS5PVeXPy+ITSrnbxAVSiV0cXde+qZGeocbHT3yylbWMxZzgLubAhcXkmNzL9KnxKM5PlwHpdCG4vipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496855; c=relaxed/simple;
	bh=H+K6S8PlrseNdfi3cUFr7+2W6g8jas3R4a0nhaa4g54=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CCF41xVW3uwljNxb4lom9y8D64L/KaKFYZ3C2hwx3hibY9chOjXvL1qcugmNlCjpf9C5zFZpin+nEH95iANY0Zm6oKqdZrk5DobghaKxteaoBAR4G7NpROtjc6AJQdFuj/eanSaEXJmnG3ge8J6vzhEZFLbajT6un3YE5CYvwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhPy8/Ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhPy8/Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5851F00A3E;
	Fri,  4 Sep 2026 04:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496854;
	bh=Iu1aujYTX4KWhl6kBry2K7HqR0xruxTKVXCP6bKIbFs=;
	h=Subject:To:Cc:From:Date;
	b=UhPy8/Ez4AUva8dFmEet6rFwCEGhzO5QToT2KZUDjB2B0BpJZ05FZ6OwFLMH9t1KM
	 KSEdylcX8hOrE9hLZ1usLhDycCYW8T3set5EkuY9gHbnGL29ysr1UdnVo1oPWBTR+4
	 aIvAMByMKz8FzORPmRxIU0xJWnDsQ4oLSj+FR9is=
Subject: FAILED: patch "[PATCH] dm-pcache: validate the persisted dirty_tail chain at load" failed to apply to 6.18-stable tree
To: hexlabsecurity@proton.me,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:40:11 +0200
Message-ID: <2026090411-harsh-specks-0d82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 58d620ee9e01d4bdbceaf2ae1450d307a2a9d58b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090411-harsh-specks-0d82@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58d620ee9e01d4bdbceaf2ae1450d307a2a9d58b Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 17 Jul 2026 06:27:03 -0500
Subject: [PATCH] dm-pcache: validate the persisted dirty_tail chain at load

The writeback worker follows the persisted dirty_tail chain, which is
decoded from the cache device independently of the key_tail chain that
cache_replay() walks and bounds. A crafted image, whose on-media fields are
authenticated only by a crc32c with a fixed seed, can aim dirty_tail at a
chain of last ksets that never terminates, so cache_writeback_fn() re-arms
itself with no delay forever.

Walk the dirty_tail chain once at load with the same hop cap cache_replay()
uses and fail the table load with -EIO if it does not reach an end within
n_segs hops.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
index a94eadb7affd..b0b3e21677de 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -202,6 +202,7 @@ static int cache_tail_init(struct pcache_cache *cache)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
 	bool new_cache = !(cache->cache_info.flags & PCACHE_CACHE_FLAGS_INIT_DONE);
+	int ret;
 
 	if (new_cache) {
 		__set_bit(0, cache->seg_map);
@@ -218,6 +219,12 @@ static int cache_tail_init(struct pcache_cache *cache)
 			pcache_dev_err(pcache, "Corrupted key tail or dirty tail.\n");
 			return -EIO;
 		}
+
+		ret = cache_verify_dirty_tail(cache);
+		if (ret) {
+			pcache_dev_err(pcache, "dirty tail chain does not terminate (crafted cache image?)\n");
+			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
index d9e3e09f18e3..8809ec5ae943 100644
--- a/drivers/md/dm-pcache/cache.h
+++ b/drivers/md/dm-pcache/cache.h
@@ -666,6 +666,8 @@ static inline int cache_decode_dirty_tail(struct pcache_cache *cache)
 				&cache->dirty_tail_index);
 }
 
+int cache_verify_dirty_tail(struct pcache_cache *cache);
+
 int pcache_cache_init(void);
 void pcache_cache_exit(void);
 #endif /* _PCACHE_CACHE_H */
diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index f3ce319037be..1caea11a61a3 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -858,6 +858,75 @@ int cache_replay(struct pcache_cache *cache)
 	return ret;
 }
 
+/*
+ * cache_verify_dirty_tail - reject a persisted dirty_tail whose last-kset
+ * chain does not terminate.
+ *
+ * dirty_tail is decoded independently of the key_tail chain cache_replay()
+ * walks, so replay's hop cap does not cover it. A crafted chain that loops
+ * back on itself makes the writeback worker re-arm forever; walk it once here
+ * with the same cap and fail the load if it does not end within n_segs hops.
+ */
+int cache_verify_dirty_tail(struct pcache_cache *cache)
+{
+	struct pcache_cache_pos pos;
+	struct pcache_cache_kset_onmedia *kset_onmedia;
+	u32 to_copy, last_hops = 0, count = 0;
+	int ret = 0;
+
+	kset_onmedia = kzalloc(PCACHE_KSET_ONMEDIA_SIZE_MAX, GFP_KERNEL);
+	if (!kset_onmedia)
+		return -ENOMEM;
+
+	cache_pos_copy(&pos, &cache->dirty_tail);
+
+	while (true) {
+		to_copy = min(PCACHE_KSET_ONMEDIA_SIZE_MAX, cache_seg_remain(&pos));
+		ret = copy_mc_to_kernel(kset_onmedia, cache_pos_addr(&pos), to_copy);
+		if (ret) {
+			ret = -EIO;
+			goto out;
+		}
+
+		/* A missing, short or corrupt kset is the normal end of the chain. */
+		if (!kset_onmedia_valid(kset_onmedia) ||
+		    kset_onmedia->crc != cache_kset_crc(kset_onmedia)) {
+			ret = 0;
+			goto out;
+		}
+
+		if (kset_onmedia->flags & PCACHE_KSET_FLAGS_LAST) {
+			if (!cache_seg_id_valid(cache, kset_onmedia->next_cache_seg_id)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			if (++last_hops > cache->n_segs) {
+				ret = -EIO;
+				goto out;
+			}
+
+			pos.cache_seg = &cache->segments[kset_onmedia->next_cache_seg_id];
+			pos.seg_off = 0;
+			continue;
+		}
+
+		if (get_kset_onmedia_size(kset_onmedia) > cache_seg_remain(&pos)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		cache_pos_advance(&pos, get_kset_onmedia_size(kset_onmedia));
+		if (++count > 512) {
+			cond_resched();
+			count = 0;
+		}
+	}
+out:
+	kfree(kset_onmedia);
+	return ret;
+}
+
 int cache_tree_init(struct pcache_cache *cache, struct pcache_cache_tree *cache_tree, u32 n_subtrees)
 {
 	int ret;


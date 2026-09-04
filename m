Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052C377A8E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496480; cv=none; b=ermtIRMoavPennKYiurYsrO+6T+UUwzNpYbzpAuotLo1HLDx2arWWMI8cUU1rAnY/NJxTUetKAqJOhx+VtKngu8AXVBdQepmZV2mtChwFjC3ZoWkytCrO9QviugPc6UelP8P6hnwJHFULUfyYdLFLj3U9c8cCzmPRWTKrM4JeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496480; c=relaxed/simple;
	bh=NbCvYcNKY/VTTJGKq2mGgR7bJn3gYfuuyFEnBZJ4+EM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lpZczFLD1ymPz8jJWauvYXcQhlvZA5v5b88CsyTC5NYZaKn7ZUYknE6h4WuCtXvg8xJoJJRBbFHofmcQogRxA9blGUt7njn/7kze2WEmnUpDQnp5JBQxXo3K4XSPyE5+KB0hYbXOW3R8nH94IlLo5BFSo4oL8pU6Ezq2ampaSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4xhcfyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4xhcfyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6D81F00A3D;
	Fri,  4 Sep 2026 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496478;
	bh=CHUnU+EdyW4hoONe12UnWCFbssZ4q1LPoy1eJsSygkU=;
	h=Subject:To:Cc:From:Date;
	b=L4xhcfyxV+laxNaRqnawHoscFeMiW+K8UplE9uHlpo8T5vt0aqA5L7260Y/1OEazA
	 46e0k5Smcnyxz3REoIYq2IqJHXVR/SNfvvj0wPDYrY0XLD2kaU8Ahfy4L+vf0otXcv
	 S/30HAV1MrZ3x7d5F4gYfSv/ul8WNrwymPe65Vxk=
Subject: FAILED: patch "[PATCH] dm-pcache: bound the logical key offset from persistent" failed to apply to 7.2-stable tree
To: hexlabsecurity@proton.me,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:34:33 +0200
Message-ID: <2026090433-ebony-snore-69ef@gregkh>
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
git cherry-pick -x 97fc4b53dbe4a983fdf093243067fa6a64562307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090433-ebony-snore-69ef@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97fc4b53dbe4a983fdf093243067fa6a64562307 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 17 Jul 2026 06:27:00 -0500
Subject: [PATCH] dm-pcache: bound the logical key offset from persistent
 memory

cache_key_decode() takes a key's logical off from the cache device and
later indexes req_key_tree->subtrees[] by it in get_subtree(). An off
past the device forms a subtree pointer outside the array, which
rb_insert() writes through during replay.

Reject a key of zero length, or whose off+len (computed in 64 bits)
exceeds the device size, before it is used.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-pcache/cache_key.c b/drivers/md/dm-pcache/cache_key.c
index 2284dbc0807b..86cc9565ffc7 100644
--- a/drivers/md/dm-pcache/cache_key.c
+++ b/drivers/md/dm-pcache/cache_key.c
@@ -90,10 +90,19 @@ int cache_key_decode(struct pcache_cache *cache,
 			struct pcache_cache_key *key)
 {
 	struct dm_pcache *pcache = CACHE_TO_PCACHE(cache);
+	u64 dev_bytes = (u64)cache->dev_size << SECTOR_SHIFT;
 
 	key->off = key_onmedia->off;
 	key->len = key_onmedia->len;
 
+	if (key_onmedia->len == 0 ||
+	    key_onmedia->len > dev_bytes ||
+	    key_onmedia->off > dev_bytes - key_onmedia->len) {
+		pcache_dev_err(pcache, "key off %llu + len %u exceeds device size\n",
+				key_onmedia->off, key_onmedia->len);
+		return -EIO;
+	}
+
 	if (!cache_seg_id_valid(cache, key_onmedia->cache_seg_id)) {
 		pcache_dev_err(pcache, "invalid cache_seg_id %u in cache key (n_segs %u)\n",
 				key_onmedia->cache_seg_id, cache->n_segs);


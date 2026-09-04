Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633537F33A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496483; cv=none; b=qJxIey1BhLrh0e6DXLvtMDf/gQdBxwWRCEApZQg6ct6yXossV0PVEgT+eY4eKLnXrXtVQHxFq2G1htkjplxTnP0k64udC6hZrszLBeDLnkzvLLYmiHO7FPCwBUt8tMzeTlnPDi9ZBizVvou3O2HTy9X233Y4ob8xVJhAkH2tUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496483; c=relaxed/simple;
	bh=TamTCnz7ns7vP84hqoAsG22QEF3dwlbS/peOUFSjqoE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qWTcTofHp2Ffn0TZfV2rMlhSKDEXHicTV60lU/a15jV0dMqGFkygeb/1L5uTS8Jj04NCNCgitzakyLYQ91ls120QBra94hmmYTM7S3CVLL4QwZRNZUbr7wdE0bY5bb68Q+VX0GxoxFNM4/EchfboRgFEuYt9DD5nxKyJU2FqHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7BPr1S4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7BPr1S4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB4E1F00A3D;
	Fri,  4 Sep 2026 04:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496482;
	bh=Fjte5e4S0F3DBZx1C3Nu4XhX+NLLBdMdXCg0jYUXIJU=;
	h=Subject:To:Cc:From:Date;
	b=w7BPr1S4x3R6XxlvE5SrBOXpQPsfqPek0nl7ccCWM6dlNvp8WV7BsayfekwpEMhYg
	 Q9NDwjSs9AO2AN5LQu7t+vJ/Lgw50EfZ9YwMP6WY99n+Jo5nBlkGDaMqIgSR+8vN4/
	 61Jm9i27TUd4JTqGCn8opvL7bBLvxmkO0DtP5K4U=
Subject: FAILED: patch "[PATCH] dm-pcache: bound the logical key offset from persistent" failed to apply to 6.18-stable tree
To: hexlabsecurity@proton.me,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:34:33 +0200
Message-ID: <2026090433-clothing-lyricist-8896@gregkh>
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
git cherry-pick -x 97fc4b53dbe4a983fdf093243067fa6a64562307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090433-clothing-lyricist-8896@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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


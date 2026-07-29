Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6848AE17
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333070; cv=none; b=anflv82gnu0N+QMywb86BfDCZVWtun4kHlPrnQeKGzF3egJLvNX9mwbQYwvh42zdNP2OIRy8u0VOLnX/BNpvvwHd9fHjLKH9YPxE8cOgOYkdYCORWeF6yDZwvYfPzidKm7tqM8Ws/C134YWcgWob2zO7i57AU9hfvwLe3/IpYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333070; c=relaxed/simple;
	bh=egcRscMAsE92kMhSVehqLfx/TQaGNHPHjT1Y4wS1low=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sKrccQW2ehA/Oxp5C5AyemTyDP9r+ANS4twGBBUjUd/iSw0VemiQZNXI97WcxJNajXvIqS0jSfiU2D4wXGqGBt8oo3H3pfEagfKyRmzOTREHqFaRdGWVN+0+Ww4N0pn7/udTaoQNU/aGdWXlnL+2UiyS5IeWQYXWRAaeN1pvo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dauIAXgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dauIAXgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588C01F000E9;
	Wed, 29 Jul 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333065;
	bh=+D969LNYm5AHg9/V/sFF6rxB6DrOBFKoWYgQBEoCSSI=;
	h=Subject:To:Cc:From:Date;
	b=dauIAXgbWt28QV3Hh3D/Qh9p6zoz6xFpcy5bAequnhnLe/NJekvep0UA4Yl2RTuD3
	 GSvELtXW4Ft24tNtL8HCaYu8ZrvCGq19Sq81XVtG3ozriVVfefrHW6QWmyEeQUPs2x
	 kMIya1zQtVvnT2yLtKFU+YgbIqUjHZe3kidfmrho=
Subject: FAILED: patch "[PATCH] mm/slub: fix lost local objects when bulk remote free batch" failed to apply to 6.18-stable tree
To: hu.shengming@zte.com.cn,harry@kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:50:52 +0200
Message-ID: <2026072952-macaroni-erased-2eca@gregkh>
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
git cherry-pick -x af9ea231c0b4530edc389a3126a69e0699b7699d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072952-macaroni-erased-2eca@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af9ea231c0b4530edc389a3126a69e0699b7699d Mon Sep 17 00:00:00 2001
From: Shengming Hu <hu.shengming@zte.com.cn>
Date: Mon, 6 Jul 2026 21:39:09 +0800
Subject: [PATCH] mm/slub: fix lost local objects when bulk remote free batch
 fills

In free_to_pcs_bulk(), when remote_objects[] fills to PCS_BATCH_MAX,
the code jumps to flush_remote to free the batch. If all remote entries
have already been compacted out of p[] via tail swaps while local objects
remain, the flush_remote path returns early since `i < size` no longer
holds. The leftover local objects are then neither cached in the sheaf
nor returned to the slab freelist, causing a memory leak.

For illustration:
 size = 64, local objects at p[0..31], remote objects at p[32..63]
 After scanning all remotes: i = 32, size = 32
 p[0..31] local objects are dropped.

Harry pointed out that, although the logic contains a real leak, it does
not appear to be triggerable with the current in-tree users. To hit this
path, at least PCS_BATCH_MAX objects, currently hardcoded to 32, need to
be collected in remote_objects[]. Looking at current kmem_cache_free_bulk()
users:

* maple_node has sheaf_capacity = 32
* skbuff_head_cache has sheaf_capacity = 28
* panthor and msm drivers have sheaf_capacity = 4

The sheaf capacity is, at least for now, derived purely from the object
size, with the user-requested capacity used as a minimum. Therefore, among
the current users, only maple_node has a sheaf_capacity large enough to
reach PCS_BATCH_MAX.

However, for the bug to trigger in maple_node, all objects in the sheaf
would have to be from remote nodes. In that case, there would be no local
objects left to leak. So this issue was found by code review rather than
from a runtime report, and it does not seem to be triggerable by current
users.

Still, the bug could become reachable with future users, a different sheaf
capacity, or a change to PCS_BATCH_MAX. Fix the logic by freeing a full
remote batch in place during the scan and then continuing to process the
compacted array. This keeps all local objects on the normal fast path,
while the tail path only handles any leftover partial remote batch. The
redundant next_remote_batch jump label is removed as well.

Fixes: 989b09b73978 ("slab: skip percpu sheaves for remote object freeing")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Link: https://patch.msgid.link/202607062139095043SOsLi6TIf403tcjPf8fm@zte.com.cn
Cc: stable@vger.kernel.org
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/slub.c b/mm/slub.c
index 9ec774dc7009..65febe957886 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6217,7 +6217,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	void *remote_objects[PCS_BATCH_MAX];
 	unsigned int remote_nr = 0;
 
-next_remote_batch:
 	while (i < size) {
 		struct slab *slab = virt_to_slab(p[i]);
 
@@ -6232,8 +6231,11 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (unlikely(!can_free_to_pcs(slab))) {
 			remote_objects[remote_nr] = p[i];
 			p[i] = p[--size];
-			if (++remote_nr >= PCS_BATCH_MAX)
-				goto flush_remote;
+			if (++remote_nr >= PCS_BATCH_MAX) {
+				__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
+				stat_add(s, FREE_SLOWPATH, remote_nr);
+				remote_nr = 0;
+			}
 			continue;
 		}
 
@@ -6317,10 +6319,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (remote_nr) {
 		__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
 		stat_add(s, FREE_SLOWPATH, remote_nr);
-		if (i < size) {
-			remote_nr = 0;
-			goto next_remote_batch;
-		}
 	}
 }
 


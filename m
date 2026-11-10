Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272482;
	b=Y20C13/MktkRpvreYtUhZ8pStGPuCZMf0OVOZB2WL9lfHOGacuOTPAQ83a0fmGKp1RAp
	 nRrzEDax0voMsr5mCtp6ycJnTJEvsUSFdnWTqK5xU57jpwuCVcly/PP5ClysAkbKOK4I2
	 aJUM7X5KrUTgAU15I6yvGmoRfVYob5f6OPzWPsAUhiWhUU4F73cVDixyHaGyN7aEOcPnS
	 8AwagvwR/b4gACfnZuEiMcbml9+ILLaV7aYvHrUG/JR1fuAEXZVwcnnYMfPwCjXk272nG
	 iC3/sRhgCmt8t46mwCZQ001nLg2IpG27NLGgFfxCXgJH98EzIKCcaeCcOH5dO22bDhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6w9t/4PZB5CctcgoO1G0JBuI1pjodw8KZa41sTEKqCw=;
	b=qIKZyo6qlsoTOsNiCfIUFHaHJkoAda5o1GsTu9bTNz5Pw37TAhkdFP2KaJfa+t8NYPRC
	 xZkpqrLJQaybpqeBm3TLgPLfKgxTYZpFvY5zlaRicvyg7OzYvOHYnemBIBRsdBpiSiEgY
	 fIZG5L4Np3u6vp0P4RSGJfhyUiI4oU1Aka6ITWhTi3etHjMLdwYDgoVBfTvsvTZYOvNwX
	 QDV0V5V6YymFhqxLo9jHnbFNAPQTcvRTO2luwR9HTLpnBg1vLKZCWe9eIt6nNCkS1bu7z
	 hx6HlqSK6TBu2/cp2eUNG7/XZKxOTOZvSFCPhh1lPvbbvMWO5X2v6stcIJvL8pfVwAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmWqi6FL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmWqi6FL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DEC1F0089F;
	Tue, 10 Nov 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272481;
	bh=6w9t/4PZB5CctcgoO1G0JBuI1pjodw8KZa41sTEKqCw=;
	h=From:To:Cc:Subject:Date;
	b=kmWqi6FL2csBCusU+LzpDrkm43PTKu8VgQ3ww69UgjXRXe1JpuKQ28EH2Ph5mvFQv
	 ILFFYxde63vcNg2sfq38c1soAV08kQNLN/kKRXipkDjwBe6egeU8LvrRvDx65+5fSc
	 Zg20hrYT8Fp9RqqlVtwBAwfkTmMsWozsJ4l9cVWfybun71fAd3TrtzTdjRBYBddAH5
	 C2d3RSpe/I8/eyjeSCITRy3wYoYhSr/jMVGEsi6rDDGkPPYJdATsKTUjw9c8GefoBL
	 Jg4JZx5KdfZqX0ZnMCET9lfnBBbeRkg9yVXA+WuTGSWcp5XVZNqsbuNdO6P/1G2d6E
	 xWkA8FrvscwTQ==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	pfalcato@suse.de,
	kas@kernel.org,
	nphamcs@gmail.com,
	baolin.wang@linux.alibaba.com,
	gourry@gourry.net,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: hold off eviction in shmem_writeout()" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:19 -0500
Message-ID: <20261109200119-failed-7.3-8f59173b5ca3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 8f59173b5ca358bf4d1017b44da3cbe6faa80daf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200119-failed-7.3-8f59173b5ca3@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8f59173b5ca358bf4d1017b44da3cbe6faa80daf Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 11:43:27 +0100
Subject: [PATCH] mm/shmem: hold off eviction in shmem_writeout()

Once shmem_writeout() has moved the folio from the page cache to the
swap cache, the folio lock no longer keeps the inode alive: truncation
and eviction find a swap entry, free it and do not wait for anybody.
That did not matter as long as swap_writeout() was the last thing the
function did.  But since it puts the folio back when swap_writeout()
returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
afterwards:

  reclaim                               last close of an unlinked file
  shmem_writeout()
    shmem_delete_from_page_cache()
    swap_writeout()
      zswap_store() fails               shmem_evict_inode()
      writeback is disabled               shmem_truncate_range()
      return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
                                        destroy_inode()
                                        ... RCU grace period, freed
    shmem_add_to_page_cache(mapping)
      xas_lock_irq()            <- use after free

swap_writeout() behaves that way if zswap is enabled, cannot take the
folio and the memcg or one of its ancestors has memory.zswap.writeback
set to 0.

shmem_unuse() already added infrastructure to deal with that.
Reuse info->stop_eviction to protect the inode during writeout. Increment
it before removing the folio from the page cache, and decrement it after
swap_writeout() and any attempted reinsertion and inode accounting.
In shmem_evict_inode(), wait for the counter to reach zero even if
swapoff has already removed the inode from the swap list. Add some helpers
to make the code easier to digest.

There is a known remaining issue with two swapoffs racing, and the empty
list check not being able to detect that race. That will be addressed
separately later.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() reactivates")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
[ david: code cleanups; improve description ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-6-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6df0237832c00..c44d2dd71c893 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1616,6 +1616,17 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
 	return error;
 }
 
+static void shmem_disallow_eviction(struct shmem_inode_info *info)
+{
+	atomic_inc(&info->stop_eviction);
+}
+
+static void shmem_allow_eviction(struct shmem_inode_info *info)
+{
+	if (atomic_dec_and_test(&info->stop_eviction))
+		wake_up_var(&info->stop_eviction);
+}
+
 static void shmem_evict_inode(struct inode *inode)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -1628,16 +1639,21 @@ static void shmem_evict_inode(struct inode *inode)
 		mapping_set_exiting(inode->i_mapping);
 		shmem_truncate_range(inode, 0, (loff_t)-1);
 		shmem_unused_huge_del(inode);
-		while (!list_empty(&info->swaplist)) {
-			/* Wait while shmem_unuse() is scanning this inode... */
+		/*
+		 * Writeout may still use the inode after swapoff has removed it
+		 * from the swaplist, so always wait at least once.
+		 */
+		do {
 			wait_var_event(&info->stop_eviction,
 				       !atomic_read(&info->stop_eviction));
+			if (list_empty(&info->swaplist))
+				break;
 			spin_lock(&shmem_swaplist_lock);
 			/* ...but beware of the race if we peeked too early */
 			if (!atomic_read(&info->stop_eviction))
 				list_del_init(&info->swaplist);
 			spin_unlock(&shmem_swaplist_lock);
-		}
+		} while (!list_empty(&info->swaplist));
 	}
 
 	simple_xattrs_free(&sbinfo->xa_cache, &info->xattrs, sbinfo->max_inodes ? &freed : NULL);
@@ -1776,15 +1792,14 @@ int shmem_unuse(unsigned int type)
 		 * remove placeholder inode from swaplist, nor let it be freed
 		 * (igrab() would protect from unlink, but not from unmount).
 		 */
-		atomic_inc(&info->stop_eviction);
+		shmem_disallow_eviction(info);
 		spin_unlock(&shmem_swaplist_lock);
 
 		error = shmem_unuse_inode(&info->vfs_inode, type);
 		cond_resched();
 
 		spin_lock(&shmem_swaplist_lock);
-		if (atomic_dec_and_test(&info->stop_eviction))
-			wake_up_var(&info->stop_eviction);
+		shmem_allow_eviction(info);
 		if (error)
 			break;
 		if (list_empty(&info->swaplist))
@@ -1915,6 +1930,13 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 			spin_unlock(&shmem_swaplist_lock);
 		}
 
+		/*
+		 * Once the folio has left the page cache, its lock no longer
+		 * keeps the inode from being evicted and freed: hold eviction
+		 * off, in case the folio has to be put back below.
+		 */
+		shmem_disallow_eviction(info);
+
 		folio_dup_swap(folio, NULL);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
@@ -1922,6 +1944,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		error = swap_writeout(ctx, folio);
 		if (error != AOP_WRITEPAGE_ACTIVATE) {
 			/* folio has been unlocked */
+			shmem_allow_eviction(info);
 			return error;
 		}
 
@@ -1938,6 +1961,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 			shmem_recalc_inode(inode, 0, -nr_pages);
 			folio_put_swap(folio, NULL);
 		}
+		shmem_allow_eviction(info);
 
 		/*
 		 * The swap_cache_del_folio() below could be left for
-- 
2.53.0





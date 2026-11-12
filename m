Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449978;
	b=1dHK7k9cSzLvXXDE5mg7EyN9An4WAmqH6JDPcWUzqftO0sPSbOtRZfQ74qx2GZ4rF08y
	 v31VbIL/MD3ETu6Gnod6JZrDAYkO6/pe4mYvFNxINGW/3ifJ4XzqWDJIEgryXwhhP+U56
	 6X4Z5zd9sAgSzks93JqWFifPd+EhLxCdjN5q28aQX/kh/88hjrThqa+ItiynJZmcLCuzO
	 h5ebK7a6gb7C3AJGC1qnK60kgFCcm7ajnU1SBH1FG6TNaPEEclrunKOGy+Rw41/WkNFPl
	 ljzSLfpglbeKki82xjuI4JhBDOW7AQ9BT82MZKCl4V8f8UA3Le3L4kNKkJxIwbR+8Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qxuxjduQc6jKkSindglVDMpGLR9a0IBkl2G1KOUgmfg=;
	b=LO0xGfQSopDKo9ror4E7j1/V4pPN94H+fmBNlVrd/AwwHgK6AobCp65lDfjA0HN8ukQZ
	 HUtpZK7cCw6sH+jk6zdAjzEb+LMEcI/jtzb4iSDVPFSVdev3qgF856XFZqYZmQNXm2oTb
	 HlAp3XPh+qWZMgMEJz6UpmaJv/BlNoknXGh4vcQHVh1ZFUsLDBIXPt40i3MltZksbebRh
	 ZlRie0MyF0ibRl0+PbQsQbGi6p5ObgqTcpwr1ZN+OTbNMIlKE4mA4vzJKz4fs3ZyKFWLI
	 93+l0bWNttxQXO/EAO4tO+stgeEdln9VwSD0yjC8g3Ok+ioKpbMQhukUipLyWJdIN4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BficyMhS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025A606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BficyMhS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03381F00A06;
	Thu, 12 Nov 2026 02:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449977;
	bh=qxuxjduQc6jKkSindglVDMpGLR9a0IBkl2G1KOUgmfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BficyMhS8ZcIsOoELt89Xt/GVAQdV/HD0PzWRpB8DsknSxEqcaN+VZ5/RTL7Ce/mp
	 HJoWs7ucI8WJtcbBavuhpjAbxEn74SQyilCCqSCehjaI532gNjS3NpfNZm2q9VdvfP
	 Q02P/FuIIaXQXodx2wvEH7K9mRLbe1GfYpHGdmLSzV2NvRkaNOdR0CpR1S1iZfQSl1
	 7RF1WT4gP2321L+Zj1dQuvADt7p/woGfmoSVVgdQ0Ur6h71+Wmqz1wsePWiAKIYcrH
	 krBmvrt+Jx3hjTmcQcoUnRgfwb7E+L00luxcRo2G65SPsRR1Vzfp2EQJDq/hZEWL2U
	 BXvxO1sGX3unA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] mm/shmem: hold off eviction in shmem_writeout()
Date: Wed, 11 Nov 2026 21:19:32 -0500
Message-ID: <20261112021641.1245345-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112021641.1245345-1-sashal@kernel.org>
References: <20261109200119-failed-7.3-8f59173b5ca3@kernel.org>
 <20261112021641.1245345-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8f59173b5ca358bf4d1017b44da3cbe6faa80daf ]

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
[ sashal: expanded upstream eviction helpers inline at their call sites to avoid adding new functions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index bb5d24e7202dd..b20587118f227 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1442,16 +1442,21 @@ static void shmem_evict_inode(struct inode *inode)
 			}
 			spin_unlock(&sbinfo->shrinklist_lock);
 		}
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
@@ -1732,6 +1737,13 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 			spin_unlock(&shmem_swaplist_lock);
 		}
 
+		/*
+		 * Once the folio has left the page cache, its lock no longer
+		 * keeps the inode from being evicted and freed: hold eviction
+		 * off, in case the folio has to be put back below.
+		 */
+		atomic_inc(&info->stop_eviction);
+
 		folio_dup_swap(folio, NULL);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
@@ -1739,6 +1751,8 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		error = swap_writeout(ctx, folio);
 		if (error != AOP_WRITEPAGE_ACTIVATE) {
 			/* folio has been unlocked */
+			if (atomic_dec_and_test(&info->stop_eviction))
+				wake_up_var(&info->stop_eviction);
 			return error;
 		}
 
@@ -1755,6 +1769,8 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 			shmem_recalc_inode(inode, 0, -nr_pages);
 			folio_put_swap(folio, NULL);
 		}
+		if (atomic_dec_and_test(&info->stop_eviction))
+			wake_up_var(&info->stop_eviction);
 
 		/*
 		 * The swap_cache_del_folio() below could be left for
-- 
2.53.0


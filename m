Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450996;
	b=OJ3/nS8vNTytn2YNXNKnML54pjD4ZZHyV9xfXu6C+eEC0zuabblx0wQuM4PteRRJF2ph
	 3lmRPARInnTr4DAk8P8tkhs0RhPOv8kz/+Yhmj5hWfWbGvz6pZODycglfU4o9wxjnBMgV
	 HDSpSQ0cZn4S41hvp7Yx5sl5lQEedEB3NzBhqToZ0RJH6TD5OHY5qW/L5ok7TgFY+nYxA
	 1Oth0YlNPX+naSXgo06JruHD/oiD2gFySau1r7Y0e925BWj2BOCaJFJsvX11+ZM6/zkzD
	 VE/8XsuZGLRG+VadxC0IB3e2Fpx6etWdXlZC/mpdTf1HT/2PRY8oMlkhzS7wAKk2Shg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xZGVOml7+HKAoz2oDlO6zH7bN2XdiV2Sr1i0bf7FP0k=;
	b=4GJ3xzLQe8veEDLuERRwq8kZugbX+1zoF1WCLmhTHLewuhi6oPLhYDRKgiBjvb6wEl8E
	 5BnSmV7dNsks0g2X9PMfnDPVbBwx2XRcMq/v4r9By++79qzHNe+NEDoV0gI5WoAcdj27f
	 Ltw4vvgMLe8FYqXCcOwSK7ouNII4DPUS1vG70f50YTNhTg7jG+hqLjpQyCd+NsGXjywiq
	 tuu5FiLBPS6k3P3cT6CSvaWposw9CFcfDBL8f78ZF5yrTfXohsPwbDVzNZwa6LNOZysX3
	 dGYv0argHRlBSjjbRkKBT6Thsn2feGMhqrQIIuDgrtHQrbngGzM8z9WIMqcW1doot5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5++hkE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A75606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5++hkE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0F01F00A05;
	Thu, 12 Nov 2026 02:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450995;
	bh=xZGVOml7+HKAoz2oDlO6zH7bN2XdiV2Sr1i0bf7FP0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5++hkE1xpct7+KitP+qUmZWzdu0MVOK469iz1frjGH9iNlyc5lhSUdEqzYWZb1Ir
	 iTx1quIOuoaz4ucrtnLoMk4TpMZeLHdJQjTHhpX7HUA+P0420CyujraUefkZT2cHsp
	 TZSZ+1csBhsuDJH3zEt+a3oCidpsy91ekM793lB+h8qmvDh/kX+0SYjB3uhDR1rdgl
	 ksTqrbf1omcvzIsA63ktNv974CboTqeXurvUOZMStXeu3/owHohQaA4BlNv7LxSOn2
	 nyFBtl6h4zAL3hQbrSNhnP6aYqKLgXi3wY3eF+zhXY0XtzzYJrNlLCMHl4rkb1eas9
	 2W1764BXWAcvw==
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
Subject: [PATCH 6.18.y] mm/shmem: hold off eviction in shmem_writeout()
Date: Wed, 11 Nov 2026 21:36:32 -0500
Message-ID: <20261112023510.1371560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200258-failed-6.18-8f59173b5ca3@kernel.org>
References: <20261109200258-failed-6.18-8f59173b5ca3@kernel.org>
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
[ sashal: inlined upstream eviction helpers at their call sites to avoid adding new functions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5efde9fcc3057..c318b7445d89b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1407,16 +1407,21 @@ static void shmem_evict_inode(struct inode *inode)
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
 
 	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
@@ -1681,6 +1686,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 			spin_unlock(&shmem_swaplist_lock);
 		}
 
+		/*
+		 * Once the folio has left the page cache, its lock no longer
+		 * keeps the inode from being evicted and freed: hold eviction
+		 * off, in case the folio has to be put back below.
+		 */
+		atomic_inc(&info->stop_eviction);
+
 		swap_shmem_alloc(folio->swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
@@ -1688,6 +1700,8 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		error = swap_writeout(folio, plug);
 		if (error != AOP_WRITEPAGE_ACTIVATE) {
 			/* folio has been unlocked */
+			if (atomic_dec_and_test(&info->stop_eviction))
+				wake_up_var(&info->stop_eviction);
 			return error;
 		}
 
@@ -1704,6 +1718,8 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 			shmem_recalc_inode(inode, 0, -nr_pages);
 			swap_free_nr(folio->swap, nr_pages);
 		}
+		if (atomic_dec_and_test(&info->stop_eviction))
+			wake_up_var(&info->stop_eviction);
 
 		/*
 		 * The swap_cache_del_folio() below could be left for
-- 
2.53.0


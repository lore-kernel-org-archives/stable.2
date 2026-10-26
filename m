Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007693;
	b=zbEE9vhEApf6js/B1l+VSXCJCfdFfnpmjj+2YxZkyRBX5wiwEggEtE0JpBbU1EosEw2p
	 kZPy2tRAL54PLyoTB/+z5dwDYX7r8BX2+/MPXlQAcLRFz154nNvKNrC5ieeVGhUqPE1K8
	 WZj5Zv/cb16Rr0MO0WC0QEEgsbsvTNbvKn5/f0yQgOgrXxEkUI29xY9jOLwbxw814m49R
	 suOpDzqL6dRQQH9uPHUMrVf1Hsgt0uux0y4PrkO784bnE2puLHrHYcqKrqzbO3ju0JzV9
	 qCSEBcmvcev0tNMTa/o1kyoHJptMBZd197CW0MoGF7TVVoqbSanvt4ZkBHzCg++FOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007693;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nmBz+/RTdpUCFQ9pqbTORh8JacvbOfiqJsVOZ0p8atk=;
	b=zR1UYt0RqUQKfjXdXtWHvyzpT3aDigFmX2cYbtDtFyq9w2nHIks1HV+FfVMCT17IfzSq
	 MBn5weCNhi7KWj1/uggslpXgZUb7ZuPN7SBR8g6XHMJ+m+kOKqAG5cKv147wxVpMwM6Bp
	 62U67EOQczIW3iJpFAzLf9/FOQ7Lzx9Nt3uqz1OQkzQg4lBEf2RWWzD+XEzyWtYWhee12
	 iI0OPAo/CfICWt1440NHbSm+/ZBt5Le9MHZteL4FZDGCEMzxbbw+uh1SF+YPLWK8J/Ojx
	 LFJFiWMCoOKUm/7NFesxffuZay6cK5IvGed37RI8uEA7e5xRD+zM0uj8LG8O2m2Rc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdxdyErG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52389606A323;
	Mon, 26 Oct 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdxdyErG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CDC1F01825;
	Mon, 26 Oct 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007693;
	bh=nmBz+/RTdpUCFQ9pqbTORh8JacvbOfiqJsVOZ0p8atk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KdxdyErGNR8+Kdh1oGHiW9TptryCXWrie4ChSPdDFePi194rJNX0Z21JDPPrgujkG
	 suKJw30KcdrF4UOX1Fbgg0b9rMqIRnCWSfi0xayvlSLTQTG9jGSN8xYyiG5obGUOM9
	 OgW3GleYE3akeWhXEkDnCg6bkWiJyn3FSQAPgh4Sg44R+mjldmqQcyj6zK1zwg1/oz
	 LDoBkFDpfFE92j4QYymh/OCSS2G4nqbULDeo5a7J4WhOVgeY75eV0J99UBismUwc4y
	 6EHMCAzHvxhWNgFO9Jc+XEJRms9onjhF6aZt4c7yTw4R8OlrRmI3hal3ytdCQboJP9
	 14oeQxP+WdjUQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:39 +0100
Subject: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=david@kernel.org;
 h=from:subject:message-id; bh=w2umf3c0pIqcT0tacT6D+QxAKf6c7D/WDtmAa+uURHs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4hxn7836fdj0TL3T68mXpYP9d8mrH5Yz07gxeaj1
 Vodrhr2HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEO5ORYbaY+ZbE/gn+vRO1
 ljmHr7hWuMlwm+Kr78u/pAdePSH7Kpjhv8ti8ZZXR55cE4kK2quoYLlSM595U7Rbubzv3+vmFpy
 WrAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

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

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() reactivates")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: code cleanups; improve description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 86b9d19f26c7e..c551e33c697fe 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1619,6 +1619,17 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
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
@@ -1631,16 +1642,21 @@ static void shmem_evict_inode(struct inode *inode)
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
@@ -1779,15 +1795,14 @@ int shmem_unuse(unsigned int type)
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
@@ -1918,6 +1933,13 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
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
 
@@ -1925,6 +1947,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		error = swap_writeout(ctx, folio);
 		if (error != AOP_WRITEPAGE_ACTIVATE) {
 			/* folio has been unlocked */
+			shmem_allow_eviction(info);
 			return error;
 		}
 
@@ -1941,6 +1964,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 			shmem_recalc_inode(inode, 0, -nr_pages);
 			folio_put_swap(folio, NULL);
 		}
+		shmem_allow_eviction(info);
 
 		/*
 		 * The swap_cache_del_folio() below could be left for

-- 
2.43.0


Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17C29A31C
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286799; cv=none; b=D1RlLKGhSq/wjGgXE/oP3mpicmVcm3xwqAo41FvSOkabIBzVl8zGIv0qDFB33Mm9krcAjtJ3uhqFZ0J27KWTZuB8e/kfKjzt7WcHohL7LYifQZx5YcwmG9dg2uFI71OvxjHcitnb9+fq8j3PAPM/BQaNId/EQVK5iSYfzJoGUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286799; c=relaxed/simple;
	bh=xhGuLRvLj8smcgZAjpNxl2k9r7i+qqyKJat52jZHjcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFrkSRjiNfTb0ULvsbQhB0ynotV5pJ3imQEt1M4AnWXeYVusWsqNyNxWwEZYT7Q4WGOR0nQqooRHg318pJaYIK57vZnjBgs6mTW/hApgrLf7A9CAbj8KldwiTEQfZcM00uhJHRoLEUA1ueFP3Oobg27f44vstPc844D/ixIOxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 9 Aug 2026 23:46:28 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Jianyue Wu <wujianyue000@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	her0gyugyu@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] mm, swap: don't free a hibernation slot that is in the swap cache
Date: Sun,  9 Aug 2026 23:45:56 +0900
Message-Id: <20260809144559.2104856-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809144559.2104856-1-youngjun.park@lge.com>
References: <20260809144559.2104856-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A slot with a folio in the swap cache is freed when the folio leaves the
cache, not when its count drops.  swap_put_entries_cluster() follows that
rule.  swap_free_hibernation_slot() does not, it calls
__swap_cluster_free_entries() whether or not a folio sits on the slot.

Cluster readahead can put one there.  It walks a raw page_cluster sized
window of offsets around the faulting entry, and a hibernation slot passes
__swap_cache_add_check() because it is not a folio and its count is not
zero.  Freeing the slot then clears the entry under that folio.

The folio is now unreachable from the swap table, and the offset goes back
to the allocator.  The folio is still on the LRU though, so reclaim can
pick it up later.  It then takes the old offset out of folio->swap and
overwrites the table entry there, which by then may belong to someone else.

Check for a cached folio before freeing.  The slot is then left in the
ordinary state where only the swap cache holds it, and it is freed when the
folio leaves the cache, either through the reclaim below or through normal
reclaim later.

Fixes: 0d6af9bcf383 ("mm, swap: use the swap table to track the swap count")
Cc: <stable@vger.kernel.org>
Acked-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dea2d3b36e06..f5dfc7e59191 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2202,7 +2202,14 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 
 	ci = swap_cluster_lock(si, offset);
 	__swap_cluster_put_entry(ci, offset % SWAPFILE_CLUSTER);
-	__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
+	/*
+	 * A slot with a folio in the swap cache is freed when the folio
+	 * leaves the cache, the same rule swap_put_entries_cluster() follows.
+	 * Readahead can put a folio here, and freeing the slot now would
+	 * leave that folio with no entry behind it.
+	 */
+	if (!swp_tb_is_folio(__swap_table_get(ci, offset % SWAPFILE_CLUSTER)))
+		__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
 	swap_cluster_unlock(ci);
 
 	/* In theory readahead might add it to the swap cache by accident */
-- 
2.48.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403579;
	b=hmimo5xvcon1zV+vdG8bSjGpXYB7Z1RT7tSaNgRoeLTgggF1qUt1TiVdeJGzONjCt9Of
	 A/oALOf7b+Y3tQE+m+EKK2OEY4VtKoMAABA9qkc7+qkNUD9k9vrVXFNj79A9RRVn7Onrd
	 jT0WmGTPttlEeGEDA7VSWhGijy3JeW3vm/wSLnjXkY+Em6jyiowngNYqS4fChOVB77UNw
	 UPiNpRyjp5rszKWL9PNRaWgyM+tuv0CCWA1xm7r0Y9/ATzOcy5VZGQ0IEA6gXenTEWDFa
	 LOBOr16O+0/h0zdbs+2SYLAOJgb1IjgkphqYXCbX4glN6xAcF9gX0cEB3znTkshqmWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yqaceEAEsX0llWUjkrvAFRFx+MyCmZ1dx+MeqRjKWo4=;
	b=dq4c+Acq5MBbRFl3j/N2nkRaaKFkJbrd8gIv4184DyE+zXTP7S2VEcdX3ktRREtl331T
	 oIYMtFFLkf4m+UNXZNHRxqJpdoV75kqwEMaLtEjW015/nLhQ04iWYsfy2Pl0K3wpsAtkk
	 mevVBJknFtxAr/vg6ty0OXxoFo+PxIKPA7Ok7UcGeSjCjGD1ekGY1Ye6k88A8FHXI5/YI
	 GGAK7hQhOVSaN6hRZS+1S/dKKpWNc3stla1Ou/Dh0DkMvfLjz5h5FiPHlBQsQz803qKHq
	 W5hdevGPle0TTHII/m7BqStyHpGNpXTHoIyT1AdOrjP90d8qVjEkaYdOBj/4umpMAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LAgrwL9C;
	arc=none smtp.remote-ip=95.215.58.236
Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506F606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E506F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LAgrwL9C
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WoLLWbuKRMhcKeu8sGGV56fP4gqbpfql+s/1EAbwlb8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794403577; v=1; x=1795008377;
 b=LAgrwL9Cfbc2n8d+zMzU/2nTQ5hU5Ianu1jf4ZzDwETBuIfQfrXXVgtkftB6sa1eikqR+xyX
 OOKwyYsFrSww/t40aprZEPSKDBOaRqjNXcFwZIKTVPTedYHD0ZkeiAvdc/nAmIrGmRvfCJDdZoY
 tXFqpNMgFbU7CBmGAt32I6GA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7d8bc716077fab9;
	Wed, 11 Nov 2026 13:26:17 +0000
X-Mizu-Trace-ID: d7d8bc716077fab9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 6.12.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Wed, 11 Nov 2026 21:26:05 +0800
Message-ID: <20261111132605.88959-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109200933-failed-6.12-eadce52a9ef6@kernel.org>
References: <20261109200933-failed-6.12-eadce52a9ef6@kernel.org>
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

collapse_file() can call page_cache_sync_readahead() while still holding
source folios locked. If truncate holds mapping->invalidate_lock
exclusively and waits for one of those folios, readahead waits for
invalidate_lock and neither side can make progress.

We need to release those folio locks before starting readahead. On a page
cache miss, roll back first, populate the collapse range, and retry once.
Doing readahead after rollback avoids an extra pass when all folios are
already present. If another miss occurs on retry, give up rather than keep
retrying while truncate or reclaim removes folios.

Keep page_cache_sync_readahead() and wait for read I/O with
filemap_lock_folio(), releasing each folio before moving to the next. The
existing uptodate check during collapse still handles read errors.

Shmem uses shmem_get_folio() for swapin and fallocated folios without
taking mapping->invalidate_lock, so it is unaffected.

Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.dev
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

(cherry picked from commit eadce52a9ef657d561b3e76c9b5f178bd99735f5)
---
Backport to 6.12:
- 6.12 still takes invalidate_lock in collapse_file() after locking the
  source folios. Use filemap_invalidate_trylock_shared() and roll back
  on contention, otherwise the same deadlock is possible even after
  moving readahead.

 mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7a54ce0f126b..e783a15f30ec 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1817,6 +1817,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
+	bool do_readahead = false;
+	bool readahead_done = false;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -1828,6 +1830,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
@@ -1892,17 +1898,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 		} else {	/* !is_shmem */
 			if (!folio || xa_is_value(folio)) {
-				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
-							  end - index);
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
-				folio = filemap_lock_folio(mapping, index);
-				if (IS_ERR(folio)) {
-					result = SCAN_FAIL;
-					goto xa_unlocked;
-				}
+				do_readahead = !readahead_done;
+				result = SCAN_FAIL;
+				goto xa_locked;
 			} else if (folio_test_dirty(folio)) {
 				/*
 				 * khugepaged only works on read-only fd,
@@ -2040,7 +2038,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * in do_dentry_open() truncating the page cache. This is
 		 * particularly important if there are dirty folios in transit.
 		 */
-		filemap_invalidate_lock_shared(mapping);
+		if (!filemap_invalidate_trylock_shared(mapping)) {
+			result = SCAN_FAIL;
+			goto rollback;
+		}
 		filemap_nr_thps_inc(mapping);
 		/*
 		 * Paired with the fence in do_dentry_open() -> get_write_access()
@@ -2241,6 +2242,30 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	new_folio->mapping = NULL;
 
 	folio_unlock(new_folio);
+
+	/* Readahead may take invalidate_lock; source folios are unlocked. */
+	if (do_readahead) {
+		for (index = start; index < end;) {
+			folio = filemap_lock_folio(mapping, index);
+			if (IS_ERR(folio)) {
+				page_cache_sync_readahead(mapping, &file->f_ra,
+							  file, index, end - index);
+				folio = filemap_lock_folio(mapping, index);
+				if (IS_ERR(folio)) {
+					result = SCAN_FAIL;
+					goto out_put;
+				}
+			}
+			index = folio_next_index(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+		/* Drain the local LRU batch before retrying isolation. */
+		lru_add_drain();
+		readahead_done = true;
+		goto retry;
+	}
+out_put:
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-- 
2.49.0


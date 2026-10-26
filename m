Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028036;
	b=y+ryaxtPlm7dzP/mpz1FKrs/w0pQGD1kg/P072eQ1yjs9qN+iS/Mltalj3cEdhG/jzcL
	 aSz7ifoHn6OROR8zrS/2qLji4IdFt+hVn6iuyAIIBpwFk8Dw5MKN4xQx+8lKCSDh09DFF
	 2TwnX4SP3LgQOq1e3wnYZtzTd4zwZk4HSJrlYDBQxLAyrdeJLHzJps+8axx6jXlNNkdAk
	 RfpOrgPTw5+dEeFaWpR/QYZ4iLnwDSh5b91BqYQRQprMCBVLKvAQcVmgN6xhFkRLjzxkt
	 Pa7nnjZBeCdROJ9IwCHCp3XAk9Y8PnlXYQ1TfrvI6fwXIWeYMEYopYYjmV2JnN6hWDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028036;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BakHxwsKEl4wEb5dVq2y9HEY/A5llL3ub2wEKFZvMME=;
	b=lYfca8IGvgnmzSjns7rLmkqi/pz88edsbzMeOePJ1gB2o8rBP9USxmGC3mk3jQyh8Yta
	 UZD+7aC9Hya2D2thRdDPFU17+KKgAj7Ux9hTiW/xjLLl3AXQyGuBPC0aa9KqZCdxLrmKv
	 dMEwtboxsHYeP6wu86PnFEuvfjHCl01KqpvqDaHsWF8DHqsrh1RayTQukyp12ggm2Dd0J
	 W1P+sk3vVSFfXb8JosCKLzZ2sWuvTHrZidvliNEQppBT3DUwLwj6XXlP47uwTu/prH9QJ
	 nv1kg8ICVA4FoOX0AnZyGJIh9ERWW3T6wrHGbvrtIXooUaCsgfxKkWHrOqi5KNBQ+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u9+GLdp6;
	arc=none smtp.remote-ip=95.215.58.252
Received: from mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB63606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u9+GLdp6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D2dq0y7/R+47sGNlmCNomNPSpPiujMaxii50Q4fB8XA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793028033; v=1; x=1793632833;
 b=u9+GLdp6rEvci+OtGYIYUdKuXybDgkOK8yLhdFUNZYTL+X4HeClBQ07ZKOmhqmoQ7zOIpGua
 LsJ6ShR582YAspm7koJTvAYmPP/HvZV1muCzefgYSgWy1OsQ+J4qROkITTcnJKCwCWgNB5srF3J
 hrMPA199l03H8yiQXWC2NDTM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c68f61dd7087423c;
	Mon, 26 Oct 2026 15:20:24 +0000
X-Mizu-Trace-ID: c68f61dd7087423c
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	pfalcato@suse.de,
	ngocthang2710.1999@gmail.com,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v4] khugepaged: fix readahead lock inversion in collapse_file()
Date: Mon, 26 Oct 2026 23:20:13 +0800
Message-ID: <20261026152013.10511-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
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
---
v3 -> v4:
 - Move readahead after rollback and retry collapse once (per Pedro).
 - Drop the preparation pass and its redundant uptodate check (per
   Baolin and Pedro). Thanks!
 - https://lore.kernel.org/all/20261016065920.4153-1-lance.yang@linux.dev/

 mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index da91762f6358..0d3bd9e23613 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2239,6 +2239,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	enum scan_result result = SCAN_SUCCEED;
 	int nr_none = 0;
 	bool is_shmem = shmem_file(file);
+	bool do_readahead = false;
+	bool readahead_done = false;
 
 	/*
 	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
@@ -2256,6 +2258,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
@@ -2320,17 +2326,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
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
 				 * This page is dirty because it hasn't
@@ -2657,6 +2655,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
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


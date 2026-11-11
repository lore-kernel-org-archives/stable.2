Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403548;
	b=d4f1BAMgTZaYoQnH+uh+O4D5Th2tHSZ9j5EPADChWnwYNLPXI4sZWLyXbzuGj8GtkG6z
	 rKZIHU+YTvED7vtZDBViWFSDxAU1yZIL8bkwpS3uthThHjMCa0e3DHZYq7GjBscJugJSA
	 loln+UDTBlI9hde2h1vIkCR3KZI4/x8KmxWdNoutAIQ9Q9H5APcn0TLcQaiUJk50rCrWR
	 xD15iGG/3LtXz30D1+WsGt6qLd75dl90m2J4GDdM/3gN9LNkVCWmk3ntJsQSCz/OZeHyR
	 IrXvezwDa++8ai9l/2UQOMJ9TjpLBTgcGWH1ee9k3NEo6Rqkd8MuWa2mgDYhf2VLvVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403548;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7j6K4ymAuzBMX9W5WRAXhD0XKR3tDm8GZC3I5ImshWs=;
	b=3KOGuGTlUbLtwAYQylVDndcf1B8pnbmHF8p7t+LW/FFOzRK73jmO4sVKxIUVnc5EyGa0
	 VklxjNwrpzxlNf/8Y5KCkpzbd7tA3xjSRQwTbovVxzCFEB20vWz9ogK5RHbap156FyNya
	 rOoe/CHVBALJxGhcNQ//3yV0qFmYvAtRVTr818esM6yeuDTZxk33hwIeFN3G50+KiZouA
	 APbcRZlzNkON+m/qsH6hXzizJ60f0hNjpChWJCPvE3FGosR4ebtmPTGXipEBIm2DHxeO/
	 khpvQS0zdQ1JdTvxdYAovMlM8VeQwC8NqwJE/pUCu4nHKEAryY3Qpwr7i7Rt7rmIqvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ttEE+jcA;
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647E606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C647E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ttEE+jcA
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pZ1tVJT3sizNNG5ieAh672I7HNNd/9qK1uI+Hcm/IN0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794403545; v=1; x=1795008345;
 b=ttEE+jcAp8sv2SM7hjB3TvOqI/mYGu8jVHq00g8sWEXUA/63W2oC/htGPIvaWgLOzpKgQQVC
 nkoPHrC391xRg9nnK6BVOuVfAastBV3GldlSwGumzKcMB5geCLxZQRGrlaYMbQ3tmPKBgl/h/ja
 bNyrDEp9j6W6FZZyCmxKKWWc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 30e8c23962f2caf9;
	Wed, 11 Nov 2026 13:25:45 +0000
X-Mizu-Trace-ID: 30e8c23962f2caf9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 6.6.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Wed, 11 Nov 2026 21:25:33 +0800
Message-ID: <20261111132533.88889-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109201407-failed-6.6-eadce52a9ef6@kernel.org>
References: <20261109201407-failed-6.6-eadce52a9ef6@kernel.org>
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
Backport to 6.6:
- Use find_lock_page(), unlock_page() and put_page() for the existing
  page-based collapse code.

 mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 42330aeb7638..396963ced1ce 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1793,6 +1793,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
+	bool do_readahead = false;
+	bool readahead_done = false;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
@@ -1803,6 +1805,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
@@ -1867,17 +1873,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
-				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
-							  end - index);
-				/* drain lru cache to help isolate_lru_page() */
-				lru_add_drain();
-				page = find_lock_page(mapping, index);
-				if (unlikely(page == NULL)) {
-					result = SCAN_FAIL;
-					goto xa_unlocked;
-				}
+				do_readahead = !readahead_done;
+				result = SCAN_FAIL;
+				goto xa_locked;
 			} else if (PageDirty(page)) {
 				/*
 				 * khugepaged only works on read-only fd,
@@ -2204,6 +2202,30 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	new_folio->mapping = NULL;
 
 	folio_unlock(new_folio);
+
+	/* Readahead may take invalidate_lock; source pages are unlocked. */
+	if (do_readahead) {
+		for (index = start; index < end; index++) {
+			struct page *page = find_lock_page(mapping, index);
+
+			if (!page) {
+				page_cache_sync_readahead(mapping, &file->f_ra,
+							  file, index, end - index);
+				page = find_lock_page(mapping, index);
+				if (!page) {
+					result = SCAN_FAIL;
+					goto out_put;
+				}
+			}
+			unlock_page(page);
+			put_page(page);
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


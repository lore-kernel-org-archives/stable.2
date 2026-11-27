Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767371;
	b=zf8bBjp3Pu7uqNiZEhrf37bPMqzBdZ7l/t1oQq91353wm/ps+l0/fLyuu9ST8t7sfEWo
	 gg8W+fLGNLi9qBgjvEhw/OBUWhM7QzqoPnSw1GcBJ/S0Cm/xPhmFXkNi+wQEjOwqrVG7O
	 0Crk4rUUYPD57rf1OVxNZ6A2FH5MTKyUwpyjC4gHk0doamzA7TLFxdRMsuO0/Pqqz/eWB
	 jZkffXNsL+/A9tI8EmDFsxUD0Oo2ppnxTwni6QMr0mPV7w+oiFPiTrwKqqvnKzWP/VsuK
	 JRfAOKLZ9qz7X+DokbGGgq8H6LbPkRmymgFMBMVnPxfkBMgQjXUhMapfruTtWFLascg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767371;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aEaw6zXYAnbzSN5FvjsyXr4Fz++GceZvdQNsG6RfKog=;
	b=B4aGV8uDDC67XLNTISojT50KmDiqqJxpZ0TxwOeOyV5oyuevB6zQtFb1bd1FnTtnoChe
	 YhYdx+xvoqmGNj8M7XqzF+K4WSNZWhoyEP5O13kM+ZY9HT/l/ola38q8LK/1e9g5hgGLM
	 P2PkHeT4+lF1UT7z5YxmpxddJjSPSzEr/aCa7K+QtJ5/eq0cKapzJ8INjw9PiT5AaY8r7
	 LM1xNazBiOZfwGd15wP+ziBYdypMzKGLkwXKvbi1cs67O7A9cgMOcop3H0h4FPFsLBl84
	 ftCW05scbbc9XQch6gx6WK1JG57uXnARGUGVADnosE/77BLR1TBYUsnA/vLVK7Yw6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KCk6CGko;
	arc=none smtp.remote-ip=91.218.175.199
Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76915606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76915606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KCk6CGko
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u4DU1GOy75OmGkFTohhNH7HUoBsqLv1pDAQQCubbGDE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795767368; v=1; x=1796372168;
 b=KCk6CGkolYnMQ3VVCL3qG3JQAoDUmIJ4yNhiV0PP3C/6f0ZeoB6PGb1CGcTrMt9MIpOqDIX9
 AmoYU5Hp5VXzavyDhDb7ZEYSfjxoIkT1sMCa9do96O4YsASGTNn8ki3x/OiK6YBU551f0/IAPpS
 8kiFkXpfa7Hz6zcKF20uf6No=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ddd24e0855af21a5;
	Fri, 27 Nov 2026 08:16:08 +0000
X-Mizu-Trace-ID: ddd24e0855af21a5
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 6.1.y v2] khugepaged: fix readahead lock inversion in collapse_file()
Date: Fri, 27 Nov 2026 16:15:56 +0800
Message-ID: <20261127081556.31348-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109201858-failed-6.1-eadce52a9ef6@kernel.org>
References: <20261109201858-failed-6.1-eadce52a9ef6@kernel.org>
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
Backport to 6.1:
- Use find_lock_page(), unlock_page() and put_page() for the existing
  page-based collapse code.

v1 -> v2:
- Refresh context after the shmem_mapping() update.
- https://lore.kernel.org/all/20261111132506.88827-1-lance.yang@linux.dev/

 mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c9ee735a2b1d..35f2a66c6eb2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1780,6 +1780,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
+	bool do_readahead = false;
+	bool readahead_done = false;
 	int nr;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
@@ -1791,6 +1793,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	/*
 	 * Ensure we have slots for all the pages in the range.  This is
 	 * almost certainly a no-op because most of the pages must be present
@@ -1875,17 +1881,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
-				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
-							  end - index);
-				/* drain pagevecs to help isolate_lru_page() */
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
@@ -2151,6 +2149,29 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	if (hpage)
 		unlock_page(hpage);
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
+					goto out;
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
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
 	if (hpage) {
-- 
2.49.0


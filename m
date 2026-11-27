Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767388;
	b=YNJ8fm0O4eABphLbN3XHVLnrdB4S5gfFaxZ68fcGOMqVZs3MVmYE9dcp9RFLk2Zv7h+b
	 EXja7kKihyLqeAXlUqUiEXkeqWCmGYuDwWjT48v7X6x0/M5en3jzvt1ePTdK1V6z0FKkP
	 LlL4gV4GaNJXo1nvag3z/rpxAVLRThoGkN3xnfxvdbLqrORnUJL9JKZpSLxx9iXKI2uZ6
	 hgHsqMJ/uf5P7HeJFx31BEb62xIKo09gun+cpfWWDECrawyDq0Au9ZLfVHrIjUCL4Ve8a
	 ZqbEoeDIM1BpAK/aC6tLVNj6xq5Qs/QPuEdDBIEO/ca5QsvkqbLK5/TgTcsyv0EifeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767388;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U3kEF0HwRaHzA0wfE1McDGZbTTwDPKseW0SYRoDT/vI=;
	b=bfes5CvMFycL4tHmqV9aeY8Gv+kXHa0opbvZ/qegStncGrSafraOtxUbK9TY+grKy9db
	 RWlsdkCSXsFOse0GV3EwZASHvcB5NTDRPJ2z6bB2C0Cd4b/yOF6M4k/VHrvZty+sT5wTN
	 LQmKj+XfsTPtTqejW6iD342y10Yd9fk3g6eQacQY4M1Lj35MidVTYe8k3bkeTvX87lrxB
	 KCfVfA7FTXThHua48edkXewrI+LU9su/U9+77RDg/8Lexvmdz1eEQWlHvb88SmctsvLoD
	 2fLqcxt+I/6p8eGrvOYLyhroMJ4JYWomiFatv8zpox0cDWjtdkZS54fLM/kc57o1hQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G2F3pm4z;
	arc=none smtp.remote-ip=95.215.58.161
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA5C606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G2F3pm4z
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hx0atzyzVkdZcDn41H5uI/1WEnpp5t6ZUupr9IoEQ7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795767385; v=1; x=1796372185;
 b=G2F3pm4z26ZUpfZDCYcQVOVNGvQzQMkHUNn4c0vxl+EleY7PtmTzDyIHcHwU5DKQWSp4ZQh7
 noh4txAXEm/st/Ergb4IzKZAUMcNm92CU1vYSR9aLzIL1DUtQr4/RlQyxvZ9wzdoGb04F1eLg4q
 iNCRgRp6ci1Gmd1O19BAnbvM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40b379b951d1b627;
	Fri, 27 Nov 2026 08:16:25 +0000
X-Mizu-Trace-ID: 40b379b951d1b627
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 5.15.y v2] khugepaged: fix readahead lock inversion in collapse_file()
Date: Fri, 27 Nov 2026 16:16:18 +0800
Message-ID: <20261127081618.31491-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109202404-failed-5.15-eadce52a9ef6@kernel.org>
References: <20261109202404-failed-5.15-eadce52a9ef6@kernel.org>
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
Backport to 5.15:
- Use find_lock_page(), unlock_page() and put_page() for the existing
  page-based collapse code.

v1 -> v2:
- Refresh context after the shmem_mapping() update.
- https://lore.kernel.org/all/20261111132424.88744-1-lance.yang@linux.dev/

 mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index bd909aa4b8fe..33a67a88a105 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1701,6 +1701,8 @@ static void collapse_file(struct mm_struct *mm,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
+	bool do_readahead = false;
+	bool readahead_done = false;
 	int nr;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
@@ -1721,6 +1723,10 @@ static void collapse_file(struct mm_struct *mm,
 	}
 	count_memcg_page_event(new_page, THP_COLLAPSE_ALLOC);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	/* This will be less messy when we use multi-index entries */
 	do {
 		xas_lock_irq(&xas);
@@ -1791,17 +1797,9 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -2034,6 +2032,29 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 	unlock_page(new_page);
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
 	if (!IS_ERR_OR_NULL(*hpage))
-- 
2.49.0


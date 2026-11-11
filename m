Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403478;
	b=PU/PNLhx4IL9aM4NQU5GFQ73o312FZuvaNny0HCI6fXJufs0hCqeiAJKSeRMlDcWO6z9
	 fNsaDhdXeBSbXIgiJVjh7qzigq2IcRJxftwVQP82H6gXhtyWNrmrbev8Z/Z1BIAwoHIeG
	 i79QGT4Vwb3oBIhYOK4Cyblf7bbtApXh/oCvIivfzwhXVkgWORK5NvQTJff3o5G4n6X+k
	 BpY7mIgMG5kVbmchW9psOTaxj8KTAGpm9s3gtYp/mcXuDEqX8ztFadibTQqThTZTbnuxy
	 LVPKm/1u8aUgQWJsBksxZMaXpkOkBUkMUdROnFl1HfvWvGF2pzDSOH8KzVsW5Xj/sXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403478;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aTpninWTAe85GlgXcHUYyNqLlagIIAlBlFTO3qCfJ8w=;
	b=fwnwWzEVUvN+CpFjlnZzDp7CnO9QBKAXHNb7spbLTBFqcNDcqfX+Tp+uIkA+81dNSmgI
	 GWd0vVqPtRsnizqv2HRM18+BqReCrkZsseL22oyxq3l31zlLQjozeZ65IVhXZ6362FgyI
	 CpQfgK/BIdVVk7IiuxNOC9G+Blqq1EykCEu1399cM/Sak/A+ULM+JkYIcvmVb8y1AsJwT
	 YNdEEMHv/fQ9WxKwoKcW7lLxzsAphFDWp4eUiquUULyjWUeO5cuyLmFrLgk30oa7MOQOx
	 qE1ddN/jWNI1f2A9KTysjygJDtOlqv/0XGKy0VJDaW5JvjABquddZJ8GS5lRD/uzujQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YF0tFt6b;
	arc=none smtp.remote-ip=95.215.58.133
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4923606A881
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4923606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YF0tFt6b
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ry15bVUOMX1b1mZOFV9G9axjJGO1Lbq+pKkUeZX/f1o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794403475; v=1; x=1795008275;
 b=YF0tFt6bUSQREI9DhwI9ZtUtrdSezanscJMvEdbV1Np5EQ90ztENr/srPLeHKZ+r+GnAoxeZ
 rYsxxpZ8+XEdvCpemJ2Oh54CcrgBafa0EuEKW//xoqa3cep6g4UXR6jpJr2AAvywclqN+byYPhh
 pnUSZJeQzBhiBuYVz6jj51kw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02297ab2b5c37ad7;
	Wed, 11 Nov 2026 13:24:35 +0000
X-Mizu-Trace-ID: 02297ab2b5c37ad7
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 5.15.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Wed, 11 Nov 2026 21:24:24 +0800
Message-ID: <20261111132424.88744-1-lance.yang@linux.dev>
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

 mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7a8e6bc70b0..0b333d0d4053 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1701,6 +1701,8 @@ static void collapse_file(struct mm_struct *mm,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
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


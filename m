Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403517;
	b=uwMaR33jMsS3B4mfgeqDb1hISNI8VZEMT2nln98d4N9bd8L4iZPWzqIL1fpaqyIeOKNH
	 UG6OQE2ZonDzpHuEqp2sqlKXWJmpCYhFcdkpvHwV91H2Wu5WPwUiOx+poWGYGMGdMoiyq
	 +oENdYi9hskUEs1erxz2ckafkue8nPVG/4+KL+CaqEl/OhjxchwNfE/LT3LnHmIL1A2mm
	 d01m+32l2lDpZQfJQ08pE8bsrhyTDrNJip4u75jvmftQWL/3Zy6u8WLRFeFgbSr8lSJl0
	 JV4VdT7AYCgXSgPwFBdFxBZQPvm0o44D1CA0svfGrfwSdfYX3ZhYhHwevVlEhVWGjlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403517;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eJNT/VdkbrqGrEw6gKdBlP+dalU2tZyI5HnyQExAmMc=;
	b=loHiUKBjaLo0YG2/tvvQGDiMRooXPErBAb2rn12JBG1CXmvT4T1m7dojE6RZoMWn0cBX
	 NPVlY6i5snuUzdGWyTERHlja80zUorFggi6jdRTsGkjV6ri8dC5gX04UW4FHoVhLFre+o
	 FMpAC+7D3X+rBXjaOpbB/yQ7tzyeshFkpsd/8FmXg3pQOA4VWLfn/rqi0YP4MM6bZ7KQ/
	 NoR1x5DB5XNxWk2YtIqpz4cLkz6QwRPz0jYmQftNVBXEaFvIlqeHU5vQf0c8Rf7LkNtLo
	 YmKTwoeNqhgZsMCuU6+3a1KxZvFYHJ/WVzzvveINgNvoXF2pnV+numWMIaX+sdwXzjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Lw77bvy6;
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04054606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04054606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Lw77bvy6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yoExrapFOLtghFbcLctct3JNOERc7cokVmPwkaRmCGw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794403514; v=1; x=1795008314;
 b=Lw77bvy6KHNCnwn7q1UwKHxijpQl4fVcXkpbkHDPK9CeEZHKG7F8guLWY9ybksMf67Wf7ttD
 tbdsWSd8xrzJmKH+7+ZGfAJWCZ6mj+Pg+bIHwvV4asGxjlU8b1jBe5y0B8fRJmy2dBvKlUsbPq0
 PHQixXNj5kMeUaxXR4nMqkY8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bad35e8f732a4047;
	Wed, 11 Nov 2026 13:25:14 +0000
X-Mizu-Trace-ID: bad35e8f732a4047
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org
Cc: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 6.1.y] khugepaged: fix readahead lock inversion in collapse_file()
Date: Wed, 11 Nov 2026 21:25:06 +0800
Message-ID: <20261111132506.88827-1-lance.yang@linux.dev>
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

 mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4c3581364cb2..1dc800b380f6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1780,6 +1780,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
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
@@ -2147,6 +2145,29 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
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


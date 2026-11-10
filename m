Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273846;
	b=eEF53+UWaOa3z08fC0gD64ym6IxY6ExoFwoSSe1RkMsJMTYMog0XRXD2tQFR/o0VHzFe
	 kAs138SvcIszQi2oIzZqqsFiafsjYjvxNZQ4v+Xfd2etPBhYeef1KKPVOC7IOQU41+dd+
	 LMonjOCttx2txJAnl7fns6Z3bpr2/ca1mnvR+nTopVl3ck/xuYJsnzw9piUeI+UfxgzYs
	 goYICdjaLqatew8bEnpkVssFdb5yOYrcOJG/LXh/HxrUCplT7TJtElc9F2N1MHhAdk7T5
	 4lnDR3KNi6l6qEabwVmLY098DgYSYGVuHh6l2w7BQF2wsHHar1rqWlv2SkUWvMJ78vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pBv91j8p1092tA4lbfCN+tcLKxE4FiFgQkSejmtGp5k=;
	b=NPR4v1RQut1hJSOzNIU0ZyPJBNdsg360nNn489SOCRUkxN6hGiYCkq3NtyPmm/Tg6wcd
	 tfXfJRIX3WF6qbTqsuPd09yPV5erRKzcUoze8qWivqdkPGTrONc2XPm7ACE+bwr5HPR1e
	 +nj748UKF4sBhKDv1lPYhuUQ3wDXze3MpGPqomwEp5aHUFHWpwuIRE0MNOd93ACB4M9pd
	 BuyVUdGeKYQucsFRMfCYgGbYkOzhZiVRXx1sgrGPpA9zsoEcyUwTaFfgQ8NEdvXX17DuJ
	 mxN9cGT4OXQ27SPBl3wUXuVkx4tjhceELOp3IteldDklEL0kpTEGa2yuyR8980qhgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVrp9Xmv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1360A3801
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVrp9Xmv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD71F0089F;
	Tue, 10 Nov 2026 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273846;
	bh=pBv91j8p1092tA4lbfCN+tcLKxE4FiFgQkSejmtGp5k=;
	h=From:To:Cc:Subject:Date;
	b=IVrp9Xmv9Jgy3XdYQiVdB2/MbnzrAjsnR13Ly+dzyG3qlr/Lb3etxZf9Qg9GW1aUa
	 1fY+TAeOfIjLQbbVlbZ9SrxLa5tJfiQbLaKzpm5DcOvJq300kfYfzszc5DM6oLRn2I
	 Uz3T17YA1Ljcvbq8xP4C57EKeRZc1ab7uXRenavRAaeQ1oCViwNj527ndqWqvW++Uq
	 pSqOhwJ7o0zqholfyRIBc+lRRNVVabiXdtXBMxSDSEOulJKxuOsVxAMwEw4yUK3ryb
	 g20YzN5y8rj9ECkjdxeAU0i4sbRyybK5xDgk9Oc/Jfnn25nXJsRZkS954JCT0tm9TX
	 KLzBfUJJwxcww==
From: Sasha Levin <sashal@kernel.org>
To: lance.yang@linux.dev,
	pfalcato@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] khugepaged: fix readahead lock inversion in collapse_file()" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:04 -0500
Message-ID: <20261109202404-failed-5.15-eadce52a9ef6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eadce52a9ef657d561b3e76c9b5f178bd99735f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202404-failed-5.15-eadce52a9ef6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eadce52a9ef657d561b3e76c9b5f178bd99735f5 Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Mon, 26 Oct 2026 23:20:13 +0800
Subject: [PATCH] khugepaged: fix readahead lock inversion in collapse_file()

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
---
 mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ce794d9760a87..6d5a44cf3a00b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2240,6 +2240,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	enum scan_result result = SCAN_SUCCEED;
 	int nr_none = 0;
+	bool do_readahead = false;
+	bool readahead_done = false;
 
 	/*
 	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
@@ -2257,6 +2259,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
@@ -2321,17 +2327,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2654,6 +2652,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
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
2.53.0





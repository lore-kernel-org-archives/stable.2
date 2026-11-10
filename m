Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273249;
	b=CIuAniO3dfVc8B8An7AkU6YVpAlY6Zvwy0VNXRTiNvH4oVtp4VCVNbN2//PTQsU1/h0n
	 XWtqdu/1hrxddKRb+bFtCI1Y6X63/8sHTkQKjLCRaKhyfDB3B1lJaIhRoiMjZPyXn+FL4
	 K4E7/CwmqtSfASQ9BlB6BbE0ozYOMb+Ik1eLC+4IDXf/oFlovNgxmActCYwkYjZjwwvRA
	 VBlOSnGxIHPABXrxek4E4/6GiiphQv4Rza+A85BRlQmqblp6Mpc0jl1ZaIurf+g+0ICsm
	 d2ejhNIBFHHZMxfRRIjbi7+uYKB3HXdd/C4FdTXV05EizzTOtabZ9E8h2D0FHQKEEXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/iwhHVefkbGqCF4CKIY/g81nZTJ9ta0H1pQCbsdzk+E=;
	b=MiI1pnP0cn18cvM9FwiWZ8qyLvYeR2cio3s83J3312VFfv18QzwgTpjkJVLqgbcnuNfr
	 PsWWejf00oPeMusbWQXyMCSS7XcacYXEXqP1QFA8KzhAIsIN6KnlkZuwmFXSi4tkT6d9D
	 FGVORPvX4MZx+FSZpCQ+12bkIMz9PxpWH7lc9mezoJF6cBJq2+ZN1StpRXQCaV+29p3IZ
	 ELyRtKIx6vPnrseA0yVu9a5bPUG22xriqxhPphEKgGKCcbByIm9Fi+xm3rx6F4+loyFlj
	 Hz/obt7bpKriJ7aBLhtt+7ldtRVhM6+Olk+QFeGhj+DQWwQDmqi1a9guACAtd8kYrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+TCvaI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+TCvaI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C9E1F008A1;
	Tue, 10 Nov 2026 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273249;
	bh=/iwhHVefkbGqCF4CKIY/g81nZTJ9ta0H1pQCbsdzk+E=;
	h=From:To:Cc:Subject:Date;
	b=N+TCvaI6d7NZ+Rq0ptYiQKKPxp4j5xzDHmSYV7A5QI5nvydNX5I5gvq3JZI9N5VTB
	 BTJffaR0+wQ3aZg0D5ADPAij2+0/rWE6fiot16bTboLizxeObs51VkyfqIhcOKI5pB
	 IKf2j5QGzbY4tvoXHIuuzHgOEFuUvYSGcknilMyvlaHVR3ogrt2fXhlOaN2NZ6FIcW
	 1IOSHgiG5++CgqkwsTKW8W5F89QR+tsoRYu1hJ7jqB5UsEXrzDcMQCl6Luyk4B3mxf
	 tMbzzrz4N9RSg3xr82WUgvGWTF+TMMAUrzkvkS0JT4vxa2VyIZM5pREME5T/gxXM9b
	 GPj0LK6gI1Alg==
From: Sasha Levin <sashal@kernel.org>
To: lance.yang@linux.dev,
	pfalcato@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] khugepaged: fix readahead lock inversion in collapse_file()" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:07 -0500
Message-ID: <20261109201407-failed-6.6-eadce52a9ef6@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x eadce52a9ef657d561b3e76c9b5f178bd99735f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201407-failed-6.6-eadce52a9ef6@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





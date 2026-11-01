Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793562058;
	b=A+C/DbgDBqdIvAtT6hZ+pZrEgT23fvFxHmpsqFUZXYxpZEoXvt1CsNewLFaM6qjeeFh3
	 qMOK7qkVn3KnfWQddNvarOes15j9Um/8SC0KduuOUd7r3frD/OQnFE6hAGB747KJrDWXG
	 bG699B2+aXHljxlkArRWFeJVEQvDlt2kL2UsmaTfSnsaYbO9xte3gH7NMbLV4aoxErSva
	 KXsm/nOeAf5HPrRElPoHr2G3nC4JpSfKE9oWWS0v5mY6CYBmQv1Rf5HcDFrrG3jjhhnCy
	 E+o2uybONPL6zb13VLSbZLDzpAoGpWXQnHD87cYNPyDInrmQiWBKxN7LE8mIYWXwiJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562058;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7XMDi9CyJyqlkPG+GPZu8bn2Eo00P3/ky4TB2vvOoyk=;
	b=gvuSUCwkZYVPsw76okbi/Y83F4PqtkWjC2nPSiz0P0JfABs7Zx23gUE5YGU6DFbp88+n
	 eGkt45+F/UcUElMgt9bIWA9s5zHmt6Lkv+fRuhhlUzaQi+bzGOOtfeWx79X3ZayRFp9fH
	 0dMFjewuFfiUuveNavRMvML5K35A7//Cu/O0BaGMvVDgfykrHqRrQgRdppSr33WXFEYJd
	 hGGOHExvK6co7eCJ443ltNDRd2gsSMq5DW2Dx3o5tpUHn6QwljGXdYVYdWXHJc9jRBvJS
	 /XxZaATxHZJF+I4hIf7moMYzd+YlapRE2Pr3tTxs+fVdNuyGGyxZO88SdUs/WIpkIBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqVyDMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01621606A324;
	Sun,  1 Nov 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqVyDMf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793562057;
	b=zxZV+Oy8wV1D+AyQbLyRO0WlY9+e48SJoHoI3ba53/7kVdXYxU+YyJJZS/T2ox4UIg/J
	 hU1qHvLuKTHaw42KHaSSbnLA/gAYqMD5EPQndtlPBoi8oGTiK8Hhyr7KsNTw1v7c8n6+0
	 1JEotGO1s6BRK//BWGTV6nCj4sE/qkd5zXDX51ZOHwFj6W9i8r2RqDJ0aULEOmCe0QOfN
	 wik3Yx2iuOOvLhjgPh1Nf/ARUqbATfKTxtwI5hRNRsfjma4nyb2hcG7Fsc0o7STzjoFy1
	 dggr8Ld9N97jV/IDF5XgxEU36s92jI2ji1XQmTIFcMXanz4u+xpIItb4lHxS5C36ZtA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793562057;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7XMDi9CyJyqlkPG+GPZu8bn2Eo00P3/ky4TB2vvOoyk=;
	b=yV6dYbOEhu5JSD9PZm+qO7GCj+GKioutI2rBIwDtrBnSplwzk1gaMoatfFeMGfHVNFvI
	 Gmg9RrksfbCLMT9Q3RPRHsOTYyU7kmfoyqIP6acFkA3uc/cVQAIQDJBHvtqKQ0np2HStD
	 2yfctUnfimcJhox5ZSVZ5d2YM5OxQB2T7S82wKV+j+JoC+8JsKzL/z1mFzewa/1wOXRFI
	 dYnOn0hhFP3kAw1c3C32FwCaUAnz3Ly0b3NM384g/S8oHghGe+EcIDkVqp8CP3zCbTKD6
	 ScY3Q751oXn1iFfETMXqH12TE9MQD6Ll8WSxZ1iqpX16K/nurTGY/8u2llnVIcPK6+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 030231F000C1;
	Sun,  1 Nov 2026 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562057;
	bh=7XMDi9CyJyqlkPG+GPZu8bn2Eo00P3/ky4TB2vvOoyk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=LYqVyDMfZgOyNqQRM6wvXgEYSfdlTOIM0SKR3H5shrw+i0/XRhQA7JeuOpfdkj/QB
	 dlYHRh7G4IibxzD7/fQ5MnJt/ErZCfxxDAf9nIB7ecTjK6G9gS+Fn/LWtqkDHFeE6c
	 fZXivq0fOwDu5n6QK7kAVfjAUJbGNc2WnaBj19zy1iG1BiUfj358mdrnzzTipnQog/
	 i9dhE9qEP6SfaYXZB4K4uC2nW2l9Pcluzrxs+h+5XPw5FnUJYsb0fDdJRKqw3GqCcb
	 /6ZdiLzZrFw7hlqdOb+IcIkRBr8OG0nw1lrQAe/8N8y/5fkzI+6Ak87UDE02QRa5Px
	 gb1MlGNkv0nug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 573A546250;
	Sun,  1 Nov 2026 19:40:56 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Sun, 01 Nov 2026 14:40:56 -0500
Subject: [PATCH] mm/memory_hotplug: don't offline a hwpoisoned page still
 in the page cache
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBG4Vchs3aSUhSjr2JcjOWXjglt0+IlI
 by7FZff4pyFCrKi0LlZKOOlRWOoaHcNOS9hBOtQTdbYvjX2xBMmn9i/U9QSAycZ4cR5sPTo5GD
 30h0N1Txl3PWzrS/Xv8vz9oCbfz9a1y+oKOfyfAAAAA==
X-Change-ID: 20261029-memhp-hwpoison-pagecache-a6e3a524a370
To: David Hildenbrand <david@kernel.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793562056; l=5557;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=4LOLUja2zhU2UmZEiAhPn4FmO7n0a/B92rAAWeju898=;
 b=id4ER9EJOI/KEW5CRMKHacr3GbM19oDkiK8h+mizdyCCmDEw/R1+cUw4WSv8ve40O0ZIjZKFC
 wBbU5QsS08nBzG1vzh9tN0wgXi5yoVweIBBzOmid+9oGZFmLC906wZe
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Memory offline skips hwpoisoned pages, assuming nobody uses them
anymore.  memory_failure() however sets PG_hwpoison before it takes the
page, and taking it waits on pcp_batch_high_lock, which offline_pages()
holds for the whole offline.  A memory error during the offline thus
marks the page and then waits while the offline skips it:

  Task A (offline_pages)               Task B (memory_failure)
  zone_pcp_disable()
                                       TestSetPageHWPoison(P)
                                       get_hwpoison_page()
                                         /* waits for Task A */
  do_migrate_range()
    /* P is poisoned (not migrated) */
  test_pages_isolated()
    /* P is poisoned (accepted) */
  zone_pcp_enable()
                                       /* P is off the LRU (Ignored) */

The block goes offline while the file still points to P, and the next
walk of the file's pages (here drop_caches on ext4) crashes on a struct
page of offlined memory:

  [   11.710348] Memory failure: 0x24224: unhandlable page.
  [   11.710372] Memory failure: 0x24224: recovery action for get hwpoison page: Ignored
  [   11.765371] page:000000008c304eee is uninitialized and poisoned
  [   11.765389] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
  [   11.765440] kernel BUG at include/linux/mm.h:1990!
  [   11.765458] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  [   11.772284] CPU: 3 UID: 0 PID: 85 Comm: mfoffline Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [   11.777970] RIP: 0010:find_lock_entries+0x8ee/0xad0
  [   11.798761] Call Trace:
  [   11.799297]  <TASK>
  [   11.803284]  mapping_try_invalidate+0xfd/0x2c0
  [   11.810571]  drop_pagecache_sb+0x111/0x330
  [   11.811572]  __iterate_supers+0x2e2/0x370
  [   11.815863]  drop_caches_sysctl_handler+0x74/0xb0
  [   11.816994]  proc_sys_call_handler+0x2ec/0x440
  [   11.821360]  vfs_write+0x545/0x1250
  [   11.825220]  ksys_write+0xfa/0x200
  [   11.830202]  do_syscall_64+0xfb/0x590
  [   11.832084]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   11.848423]  </TASK>

Once the memory is also removed it's a use-after-free of the memory map.
tmpfs and the swap cache can end up the same way without the race.
Since commit a76054266661 ("mm: shmem: don't truncate page if memory
failure happens"), memory_failure() leaves a poisoned tmpfs folio in the
page cache on purpose, and it does the same for a dirty folio in the
swap cache.

Treat a hwpoisoned page whose folio is still in a page cache or swap
cache as busy in scan_movable_pages() and
__test_page_isolated_in_pageblock() so that the offline fails and a
waiting memory_failure() can go on.  A later offline succeeds once the
page is out of the cache.  With the fix, the offline fails with -EBUSY
and the file doesn't point to offlined memory anymore.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 10s.

Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Taking get_online_mems() in memory_failure(), as in Gregory's series
[1], would close only the race and not the tmpfs or swap cache case.

[1] https://lore.kernel.org/all/20261027042204.3741307-4-gourry@gourry.net/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/mfoffline.c
---
 mm/internal.h       | 9 +++++++++
 mm/memory_hotplug.c | 2 ++
 mm/page_isolation.c | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed1..ba7b1650a5ca 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1195,6 +1195,15 @@ static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, b
 }
 #endif
 
+/*
+ * A hwpoisoned page can be skipped by memory offline only once no page
+ * cache or swap cache can find it anymore.
+ */
+static inline bool hwpoison_page_offlineable(const struct page *page)
+{
+	return !folio_mapping(page_folio(page));
+}
+
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c9cc42e54f05..3d36f7f2e04b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1820,6 +1820,8 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		struct folio *folio;
 
 		page = pfn_to_page(pfn);
+		if (PageHWPoison(page) && !hwpoison_page_offlineable(page))
+			return -EBUSY;
 		if (PageLRU(page) || page_has_movable_ops(page))
 			goto found;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 5aaad037384e..beb09ef345ee 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -593,7 +593,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 			 */
 			pfn += 1 << buddy_order(page);
 		else if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) &&
-			 PageHWPoison(page))
+			 PageHWPoison(page) && hwpoison_page_offlineable(page))
 			/* A HWPoisoned page cannot be also PageBuddy */
 			pfn++;
 		else if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) &&

---
base-commit: 243e8cdab64129d6207c398f8cf5fbb1962ff7e1
change-id: 20261029-memhp-hwpoison-pagecache-a6e3a524a370

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>



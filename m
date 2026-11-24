Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534702;
	b=cYYE9HaK/7dYjAUMCIzsnrlCSY00JFJ9DnIf96c3MpgdT2+fdtDnBY+Ik4kJ9cJeND3B
	 HvWenk3BXFREznqEVvxsnXRQBaIOtYSEbNNxWi0t+6gSKFOyyIQz1KsCmpkgk5EjqPCgV
	 WukQCF35aQpIGtx2msvT9z8Su95tfJIpRvapO+qmqm9Ls0xIaS8aZl6VRW/NLqzyuKEEk
	 H2qlXvsCC9G15gR6FCDll/ApGU3hQe4ydyiNGkJzulY4WX8RybClRs2dXpqtfJIbpCTwk
	 wjA8iuJuVLKtyDlunSsAvWPDPKgooXbdLgNnz9TYbWkJfBkhIAjE6eRcKbIli8qVI4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534702;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Oixfz4LRBrmmzd6bjqab5Bc7yRi4GHHQArdh/LzoSqI=;
	b=l1/vqGN/h5SxhPwTyxXlmYEGJyiitFfCLmOgxmDwPoBQFYOcaSmbnLSgTpzFY3oRUGS8
	 frSz5hQ2aDYfCf7izmNjG+g647Id+8CFKP79QFh2mknjlUEmFJp0FhMWWz1koSVu9KStU
	 v/5c6pJNeUx5ghVfuEaSzT9V+Xix/KOQzeF0zEeUjTc8yI4Qy43V+VjzW+NrPAkctpxPa
	 fi3h7CpX4e7zn/BPoJ6y2m6pvjR/Oj9fwRGoHeVqrSiflSsv0jJ1yExrXy9E0ZVhXTntr
	 o5tev+MXsrhjqV4++Q45LCwuwkh1+a+RUwsYUvXfqj7d+uSWgKFwLkDQE67VOy9zITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=X8x5eiKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BC606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=X8x5eiKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1A1F000D2;
	Tue, 24 Nov 2026 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534702;
	bh=Oixfz4LRBrmmzd6bjqab5Bc7yRi4GHHQArdh/LzoSqI=;
	h=Subject:To:Cc:From:Date;
	b=X8x5eiKObctv1omI/A/Ho6HJVikR/rgg2YILwZ/ntRwIn5RpsCdztodjWCGPooMAE
	 C3qP7oh3fjceZFS/tyw2CnkAl61YJjZnGRE/1W24dIK7nWx4UBjBvPvD8pntRGs3+O
	 4RpuuTw8++4T7dlt8iOMgNCXf7IXwgxynWXnM7I8=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't undo another isolation in" failed to apply to 6.12-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:38:42 +0100
Message-ID: <2026112442-privacy-freehand-c0d0@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112442-privacy-freehand-c0d0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Tue, 27 Oct 2026 00:22:02 -0400
Subject: [PATCH] mm/page_alloc: don't undo another isolation in
 alloc_contig_range

An alloc_contig_range() that overlaps a block going offline can leave
the offline spinning until it gets a signal, holding the device hotplug
lock.  When isolation fails, alloc_contig_frozen_range() undoes it over
the whole range, clearing the offline's MIGRATE_ISOLATE too:

  CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
  start_isolate_page_range()
    blocks are MIGRATE_ISOLATE
                                      start_isolate_page_range()
                                        -EBUSY on CPU 1's blocks
                                      undo_isolate_page_range()
                                        blocks are MIGRATE_MOVABLE
  test_pages_isolated()
    never succeeds again

start_isolate_page_range() fails only on a block someone else isolated,
after undoing its own, so this undo only ever clears another caller's.
Return directly, as before alloc_contig_range() went pageblock granular.

With offline_pages() parked after isolating a DIMM block and a 1G
hugetlb allocation made over it, the offline on base still loops 30s
later in 4 of 4 runs:

  offline_pages+0x5b2/0x1570
  memory_subsys_offline+0x17e/0x470
  device_offline+0x250/0x340
  state_store+0x88/0x110

With this patch the allocation still fails, and the offline completes in
3 of 3 runs.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261027042204.3741307-5-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f10cc628177..cc291016ea03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7364,9 +7364,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
+	/*
+	 * On failure this has undone its own isolation, and any other
+	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 */
 	ret = start_isolate_page_range(start, end, mode);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534864;
	b=ZmQKRwOCZmF2hd35JJM9hfZRoJAJJ+/RSPo5ITbWs8Fjg0aJps/zfv+Sa/G/fO0mk2yq
	 AiVhnekC0aCr8VxQ6qxWQWSCrrGjidLaMGMtSYa+CVyQ3JqEMYueF5MkWHhb035v3u8Al
	 Md5GlwVmbZcLk/25B5XDi8rgID4k2CUEKhbbAkWOH6KxDWoYjn6J/SXBH6aX/g9YmCohl
	 yAaqGwEgx4VJEVLcYU0gNZy9lXmDx8/M4Uhbzf9lPhPbsRSr8S1dIpIXc2ggWfosJsHwy
	 u5bYj7cCRTbKSjPzWaIPI/6318mVFf+SKPMm0eUZ5Ntf5PG/hUSBT0I/BFDCE9ekv/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534864;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3k5ZDdgnGpsRzilJ6OAc3K7HgGb+MXCMjm/SDVq0VIY=;
	b=LRkhlzDXBWM4MNT6fFXrn1rqKInGp01Tf7Yvzduvqnh7zIh5cUv/wS4MSiOzedjvfr3g
	 s4nCxOMtOz7qqGBk6qtXGwcr/w4xgopWY2WEK9ltkJ1cxnDOEYLheGK5TcnSGOdhbufLY
	 Tv6VeFjNJN5PxeNYhmkSSglHdqoMWv5f2a8/C3okgxuSdSEBc7G6AF8HipHtqhM6NBTEX
	 5bL3XHgGJH5EH6mdKpfzJk0eU6WGsaDUsfx8IqNCNSf9J6+gtyR2BMTx7Cch22R8Gxdn0
	 0InBYMSk54b/GbDEmx/WA+E6vx6l5qe8w62dyC3n8PFnmsKo7LhfZLvgWpv72e6ZSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FFY2hCz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AE606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FFY2hCz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC331F000C4;
	Tue, 24 Nov 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534863;
	bh=3k5ZDdgnGpsRzilJ6OAc3K7HgGb+MXCMjm/SDVq0VIY=;
	h=Subject:To:Cc:From:Date;
	b=FFY2hCz91M76hx5g9Ayo9paf7HMTYBDNVzIJm8bQxXLuPARshgWxkMVA0a5PFUw1k
	 N6M5m+FAJRsmMyrofQDCHEGAMNJu9wFgSvZn/NjpU3MoMPM5TCHIoaHeU9LOY5DL/c
	 L7NUsB+8KJZ0s3bX3gG2GKZvfyOLzHj8c3k2CN7o=
Subject: FAILED: patch "[PATCH] mm/page_alloc: remove the zone_spans_pfn() check from" failed to apply to 5.15-stable tree
To: vbabka@kernel.org,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:41:11 +0100
Message-ID: <2026112411-resolved-runway-7889@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2122887b04f3f2d76daa80055c2c273926032fa0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112411-resolved-runway-7889@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2122887b04f3f2d76daa80055c2c273926032fa0 Mon Sep 17 00:00:00 2001
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 3 Nov 2026 17:16:51 +0100
Subject: [PATCH] mm/page_alloc: remove the zone_spans_pfn() check from
 get_pfnblock_bitmap_bitidx()

Whenever the flags of a pageblock are read or written, a kernel with
CONFIG_DEBUG_VM makes sure that the pfn lies within the zone of the page.
Unlike bad_range(), that check reads zone->zone_start_pfn and
zone->spanned_pages without zone->span_seqlock.

Memory hotplug changes the two fields one after the other. If the lower
end of a zone moves, the zone seems to end before its last pages in
between. A page of that part which is freed at that moment, on another
CPU, ends in

  page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
  kernel BUG at mm/page_alloc.c:372!
   free_unref_folios+0x55e/0xed0
   folios_put_refs+0x2b5/0x530

An attempt has been made [1] to fix this with the span seqlock check.
But that can trigger all sorts of problems in restricted contexts, as
noted by sashiko [2].

Since this is just a sanity debug check and anything with BUG_ON is
frowned upon anyway, just remove it altogether.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/all/20261027-pgalloc-ai-hotfixes-v1-9-9c7d1aca801e@kernel.org/ [1]
Link: https://lore.kernel.org/all/sashiko-outbox-188081@kernel.org/ [2]
Fixes: 86051ca5eaf5 ("mm: fix usemap initialization")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103-pgalloc-ai-hotfixes-v2-5-e0d2890ab74f@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b39ea1e51187..e3a2f54f63e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -370,7 +370,6 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
 	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	*bitidx = pfn_to_bitidx(page, pfn);


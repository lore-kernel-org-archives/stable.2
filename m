Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534850;
	b=MI1LbMDB4T79kwY/4z1q/CtHK8n1+m4g9JfpgRZ7p2a9BwILdlNw++zGANJ4DepHPjhc
	 Kl1KmKvJGZXtdeCtmS2CDZRMOi+lH93Ea2iiJ05bb4tUHVzD0A1kQZtVAMXi32jluf5BI
	 Ru9anJox97FIFVNOh0aPcwVGfxukXaM2XQ4p0Dn/Ip3JhozllZD4tGvNP9kpdTJgebori
	 LZ5qq6mTccRIfF00rEuWGj0t/4O6YytMBBK4AzfgNKdWwTtX0ZjLbJQN/kiVLNf+Iifc9
	 4IjOPdu1nbY9SXf0dz1Rk0fPw7Zsi3sNQVn7KnjJxnE2Buwwe+f6pV0jgfkwZ1tNgeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534850;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vnEmVo6ZZAIqvZrpMijIkkaqWvMK5v/O8WSru8B/JK4=;
	b=Tr0hL2cViHlFUscZpynchCnM/rXn1zMKZ4ZcnPXtMLpIoW45R3PWSbH6vNGT1wqodkir
	 lfpj/yDDdiUsmDRx9vSfn7QPBGoAuNnELsqDCZKg39c01io8OrflVQBZqEPs5O4jTbjVS
	 IrJmmMbzNMYGvN2gfnOxKgITcbETOIGfdyKO0l0EbpF1Rcm7wEq3cvOmcVA7jGD3w0k40
	 q7zKud7PbKMO4RRmqHu3vOxXObluj0b2lGBaXR8Ayt0XSJqEz9ZfBF5LstqmZmPGdBElR
	 ocd1gcHemlt4aZ+BuBQhlszBIxS7oKOYR1aAZG+8jcnPOHli6S+LUXB2e2Zj15qxKFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ET2rajrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428C606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ET2rajrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FF1F000C6;
	Tue, 24 Nov 2026 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534849;
	bh=vnEmVo6ZZAIqvZrpMijIkkaqWvMK5v/O8WSru8B/JK4=;
	h=Subject:To:Cc:From:Date;
	b=ET2rajrVFmYQJyne2bUxXIFrZpcgznfBJ2I72NPC5K+IkaGMxXth7lT9wqTWJuyiD
	 Bc54DxG4+bIkxwJlGuIaCbdf7ghUYES4RbZ+kK1N24lNScqP4bBTHe3lJLP055aMFh
	 mML28wNTWGPiRis8K6SJR3qIw01wDpoAK3JUXbHI=
Subject: FAILED: patch "[PATCH] mm/page_alloc: remove the zone_spans_pfn() check from" failed to apply to 6.18-stable tree
To: vbabka@kernel.org,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:41:10 +0100
Message-ID: <2026112410-negligent-mutiny-06fc@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2122887b04f3f2d76daa80055c2c273926032fa0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112410-negligent-mutiny-06fc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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


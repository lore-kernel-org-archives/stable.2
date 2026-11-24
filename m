Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551766;
	b=eWz2fNaaaPDRYV2msDkdukKj0HqdKYKxrFNKgawXuWrMrQZcse0K95YoHMkpISRyHxnJ
	 TBdouAWqBmUNcXYnHVbgAfhgMVFM/th/RRrfFRz+0a/BmJ9WnIzxbLLCiJM0d5+7hfYRn
	 8FrCRRO/zxoTkqOyC2qYWVXGCSvxT5Zjy4O7t58A2w5Q43QMF6z0zaKGtSX34iVOPeRor
	 Ma4luJ9vlgzaixT8TOgIt69kK7dfMFiM/BAcBuSzgOG+E97NCAn/mIBpVWcZ17f5xRzjg
	 F57wNAu4bwUJtfxeKOl5C2aw2pgL4PTogJtwAMtPsmt4uNSiJq7pdcLySvfZ9JRNpXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551766;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/n717ZOjuF5gIpvr5PlWuUQOsrJqtcDtnwa+AQOz0X4=;
	b=VDIvm1qSmCuJ+x1KhqpIUJOchsMXxC78sgGQt3EuKxE9UbfCVvRVJwnl7kJlvaBgMiCh
	 52m1KX+jpWVvO6NJgKInw8vNRrbIgbnXHutSzP5bvilQqUVoxAE887ToPZI8UWMqbUD7M
	 CNQDjf6f86V29e8pwWMQsgnJlkOIvD620zJTyJoyHfmJfIlw1OY/vySK6pwEQHIjyqgC8
	 5fjkas0eo96LPal8ctmEMKsmVves/gnRQb98a72KhWBNBjOWe8qafAlfik1oUAO05Ke4S
	 L+ad4aLnLWFTlBak6iq1+c9T0dProYsFNq4SUEIxbrgo+kWNGIC9rb1rPu9I+QLDo+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fa4bHHrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F914606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fa4bHHrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0AC1F000C0;
	Tue, 24 Nov 2026 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551765;
	bh=/n717ZOjuF5gIpvr5PlWuUQOsrJqtcDtnwa+AQOz0X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fa4bHHrtJMh9EAdNC/f+nAXJdO5scLiEvZiitYAlTC0tw2+bqgWda5Lke/ak42SAq
	 fFd0ehubhVYIYlN67riJj1YOW1Aet25YZuzxwCCfn775vTsFCj26CRimtXHHAUj3xH
	 IvQveghGGaIJpf6Zb26kSo6RkaH1qEQd7kw9I+cfOERlZpx5oBcjWTJlQcNqR+3hy7
	 9l9eJT4cwZZwzBGGwQUZ0xkfrV/36Ggpv2Bv9bl0qzVbQqBXYRteRu8zew9oKTxHFa
	 Lob+rITgEmOTe2l4g9qsz/dFIsDdh5acuXu1IFc7Zm4sEVCy5A6tiJ0h/LayJxmZ5q
	 6c8ZPAsACE8Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_alloc: don't undo another isolation in alloc_contig_range
Date: Tue, 24 Nov 2026 15:22:43 -0500
Message-ID: <20261124202220.2580490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112444-removable-storm-556a@gregkh>
References: <2026112444-removable-storm-556a@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375 ]

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
[ sashal: Used alloc_contig_range()’s start_isolate_page_range() call, which takes migratetype, 0, and gfp_mask in place of mode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50cb81d42b1c0..02bdbe9cc5426 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6264,9 +6264,13 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
+	/*
+	 * On failure this has undone its own isolation, and any other
+	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 */
 	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551246;
	b=tB4QClUNyeGrameu/FUdAClVkOOGP6esxgg3ThEtOalLCmSd82vI1TibkYWeOWuf6xtI
	 D0h60cof94J/GMgazMT4kjgWw0MRjN9q8rgVhxk49UVL7XncNrORvsfYS7okpvs4lD0Hl
	 z89hggmPmqZeASlYv7MZsYeRsjo3SmHguOnJYh/mcTe4mWwG/dw41rewbZ1ix6wUVWPpz
	 UndL6fp1XQ43QL52FlgJcNs+FOLiAqG/FUW8V1xh8fQgfrWBs6ZBIiikHufBPsNO+JI07
	 BAWjlv72G1xKObfTWO+rnSNfWdmCHmBjzu6j0qA4Tv7TOc3J3aqZczClwyBnMcHYkrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551246;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mWNHb80n2j/uT+N0YxCkUL0HZRVpFFgqkCHPu2UvGiQ=;
	b=X4jJm9jrO5PIWyPeNw3lXM+9eDjAPTHiNjW/LTQEnTLmHNvMScNXIl6zbGeuPwfHpv+u
	 GWiU9Ve7ly5cSwoumYCQonBs7JfxKIEhF5/nIY6zXbF+/WEBMj3lbMGRumCj+CM6J12No
	 HT8M4TTIbSOrqZ4JLtbjdj6Z+B0MoJ4X0nilY0aERzjBFDqKvRRhJtZoYAf6GFRDQvI5Y
	 XvgBc9nXhYFdd0cpSjTJqnf7e7AHT6P3Hp8FALKUnIIGutSwtjPqC23ctgDk+YWZXM/Bl
	 8apJCbKxVvYBlzUGE07a22pcppfcA+9T4ZWto0dQWBBfp7YZGfUfjxrABFGTZLXyfyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk96InXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA3606A6A8
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk96InXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F211F000CA;
	Tue, 24 Nov 2026 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551245;
	bh=mWNHb80n2j/uT+N0YxCkUL0HZRVpFFgqkCHPu2UvGiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bk96InXaxYmvTvdBSfXOkA59sCdcXxfOmML4EJejrzlEa3wMMpK89lfInZCjXcGat
	 d8KvoRy30/HMLEGSS9FHPA85KDZJuS2ei6BKf57WWg6MTDQOqPlCTRdvgKpxQnqRuL
	 BMR/YmMB6K1IpoUZozvEYB8OpHi4FORAouunM8rGIomVTP3LuAMOFsxg2cviptTmts
	 5xkY5utaGKGzZ54ij/lrKZCcPHzI/3m5FTP5L3Yz3OdNBSgW5IwdLEqb4H09e1hMkM
	 UyteELqBRxI3bziPnYQOIgUHC9y8iUo1UYNZ/5J0VDfbmoAKJX8iucm1sGhJLppwut
	 A1/fpC6e9olXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/page_alloc: don't undo another isolation in alloc_contig_range
Date: Tue, 24 Nov 2026 15:14:02 -0500
Message-ID: <20261124201317.2567949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112442-privacy-freehand-c0d0@gregkh>
References: <2026112442-privacy-freehand-c0d0@gregkh>
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
[ sashal: Adjusted the context to match the existing five-argument start_isolate_page_range() call in alloc_contig_range_noprof(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e9aadaf6e91b6..e592ee1b7fd03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6755,9 +6755,13 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
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


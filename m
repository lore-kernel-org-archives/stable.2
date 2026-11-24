Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552051;
	b=AkVN+1/AJUJdONN0FS2A59gxltJ/0kctpOM+cKFei9s3aHb6Tox3XyFpMxyl63kHT7Y6
	 vwCpo1V5D0pX29+E2tKF63IdBjuzEKDNHuAfVO24yGkpvTHBF8ywKUsj5FCD0w4FIxCb1
	 sYuuT64DyCsO3UNa2WgRLP4/O08qlIvmvro+pDPNxWeF1j7FD6DCzPx16CTBZfIIImWwU
	 9cFGnRFvMIuRZhdW/BaX0hGnzS7TLhXzhSVXsdyI7wZBMXuyy56fWr2VlUJ7F3RhfH05M
	 29ggVBIL4hMQ93mYLc+x4xuTiKvDmKKqDdnxJwb08tCXCA+ykPbyg0Vk045FixfSZ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEbs46BmQbPoNqmhI/JvyMr0ABkzwedIosc+vFTPXhY=;
	b=JIfYJADaGSybSqxsWl5ExZ0/q1UX1XoaYj4zZcCs+SFVVBKPR9x/sM7lCKBXnp08QIrA
	 NvlXBWpVMkC7r//SLGToQsn31XmPbdjx/UJqvMK05eps3X9lAAfu+YMgpG5aFu69FhNpV
	 BwcqQM1/h4JhutZTNjj4ZXqpOD+OBncfRgfEq5p3HMLEB5MAZ8Oms4JpMxCyvgSBGG7hk
	 Fu6oVk5Ig1UaTUuYm3RNWULfSayMmDer81oq+UrSrTyG+nk/QadtC5AoJIGJrQ+uute3D
	 n39RS7wMkD7Q7bTiEzo81+P8ATZfhN9I3ZM8ejJ/NODM+ZrcddHY1NBymZ6LfoIvHvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiYLh8hG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D4606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiYLh8hG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AD21F000C4;
	Tue, 24 Nov 2026 20:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552050;
	bh=zEbs46BmQbPoNqmhI/JvyMr0ABkzwedIosc+vFTPXhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iiYLh8hG350ZR+UitieyMMqTPb5+DeVFC3w9I6pIKSjYJkTA/LrUcK/uQQnJKyewR
	 qjKKl2PmfbOUz4vmCajBO/dJUKOMf2EGGlIRQBICLPmffOTbHxtoKvSYhfjBqoWnhG
	 ts9TU4dGqD6eypxdiqWX3irCfjQX+v4x7Ji7Nnp6IJP7y+hqXCZFwoyKEjAZbqeY0H
	 oQVMAIgn7RffxsC3Kjj+zm0CuCWEnt2g1wzlpqsBqLGqNfd/IT1B1pzoLWUaa6NUgY
	 bgFkOYZ+iK057G9sQNybYUu73JW8Akr1aKbhVJYzW0xantDEzmFeOxzcUG2x9/ATSq
	 6OKUdrxPHVggQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_alloc: don't undo another isolation in alloc_contig_range
Date: Tue, 24 Nov 2026 15:27:28 -0500
Message-ID: <20261124202645.2592499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112445-quartet-reseal-bdc1@gregkh>
References: <2026112445-quartet-reseal-bdc1@gregkh>
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
[ sashal: Adapted the change to alloc_contig_range(), where start_isolate_page_range() takes migratetype, 0, and gfp_mask instead of mode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba7f386331a65..155029b96bf7e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9328,9 +9328,13 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993693;
	b=D6776Ip6LOg956uie3T38v45tx7paMYb/Fx3+mlUmoiFU4fXbpG+LA9mQnG/OdcXPthq
	 SYG49L4Fx+3ji4YgjjE7gp1YLwDS5Beg+zQI1y8Tr1DSRlzuaShwTiF2IW52UMudkv6J3
	 mUvYy1Hh8pvy5tk3q6TQgxFM4ih5J8HYrINl16dkgK4LPYAu8PoUQG12FsK0MYvyPpdaI
	 MS5O4ITuQmbp5JJ3DQ/AfYjNrtWgp83yNkPOMXW/SHLwYp5GOk8KNx7PkwDvjuNwosr7J
	 NfCOSB9ZsDejDQbU5EPv2KZuHDMoG0fvjagCUMIWc0YWsnHG+VRDz+UPEUOZJeu+c5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993693;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lcN03BFrUVuRLyZhzYAenj3/VDeI8OU1AfZJ+NJkCIg=;
	b=ohOtJi92p9tPXLXxUMJur0x60KzU5tf1+zcvLf5E7AaZwvdS9IoNMGTh5rXlvI6P+Hxc
	 44kPK5v+meIXxRfKVwGFUA4NCASTi6BbZ66JxSBE31sT7V/CA6WN/qghlj2kZ9t6hdGHr
	 ivnczjkaxE1C07GeNIIA+7r5C/FlmbG5ABrpNgYfmqHzhmQL6NjlJtOJqYr9WBuSKfmYy
	 dweraYfC2MonjK8oKwrOdvGBgVg2L8pi9oE+Ursm+oIu++cRtjWMsc6a2YJsBIDSaGN1i
	 L64uhPcpV9C9gjwuYn9W9mtmqkPhZERbkXvg98BYlk/IjUjLh5us0ZmUFlsii9nOJig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzZLpbCK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80E606A31C;
	Wed, 18 Nov 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzZLpbCK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362CC1F000C4;
	Wed, 18 Nov 2026 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993693;
	bh=lcN03BFrUVuRLyZhzYAenj3/VDeI8OU1AfZJ+NJkCIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HzZLpbCK9AGaEnuP4cFp3OGO+VnzS4PHvl2aJ/d4Rc1W4oOUBXGlvkpHcGrUaytVJ
	 wcxCe/JTjMIULeKrzpUPwLMfE+/0tb5AMfpANxx3MRFklA5sIXW15u8H24VCUf7jn1
	 Ok7PXGqOw5T7NtvDM1j4+aMBK+2yX9uJ9fHxRG4I+o7MperUm21DHkExkJ+8BCJb0Q
	 HVOkl/4urAo6Ab3ZBQIbQB2/0kxKajG7dUtKyhs2BCWedrZPiXzOI1AsgzB5uxPLq3
	 PyWcuYgeVkrPDHd4G7mt9wdGizua/w58hbyiqZlSJvRNmS9/LFngCZYFK200TQ9zLx
	 bhDgVuxNeoVhQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 10:20:37 +0100
Subject: [PATCH 2/4] mm/vmscan: flush deferred writable TLB entries before
 unlocking the folio
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
In-Reply-To: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, 
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>, 
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>, 
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=david@kernel.org;
 h=from:subject:message-id; bh=w4iaf/Vfi3av01ERqlZd2baVtI78nCv5zLerY8P7EDY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+5v6c83aReG8Nl90RhW+nKhPaYlqenO/X/xQnXuIbJ
 c6WmDu/o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIlsZmdkWGO7Uyn66WXpJ7NO
 NPOuWaTv23Ly9tSQjVvC3Hae3LwgT5Xhr3T94+vKwXku1pIqUd0HpOYwJQYJHGiYkXZZTtMliuM
 BPwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

try_to_unmap() with TTU_BATCH_FLUSH transfers the PTE dirty bit to the
folio and defers the TLB flush.

Reclaim must flush the TLB before unlocking the folio, otherwise stale
writable TLB entries might be left behind temporarily: writeback started
by other mechanisms (e.g., fsync) will not find any mappings in
folio_mkclean(), so it will neither write-protect nor flush anything.

A write through a stale TLB entry after the folio was cleaned gets lost
once the folio is reclaimed.

However, reclaim currently does not flush the TLB if the now-dirty folio
does not get written back (e.g., gets activated or kept instead). Fix it
by flushing right after try_to_unmap() if the folio is dirty, which makes
the existing flush before pageout() unnecessary.

For dirty page-cache folios that reclaim activates, we will now flush the
TLB immediately after unmapping them instead of batching the flush, which
is the right thing to do. Performance-wise, it shouldn't really matter
much, because folios with dirty PTEs are usually young and reclaim won't
even try to unmap them.

Fixes: d950c9477d51 ("mm: defer flush of writable TLB entries")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vmscan.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5495d9be90e88..af7831643ecf5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1455,6 +1455,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				flags |= TTU_SYNC;
 
 			try_to_unmap(folio, flags);
+			/*
+			 * Flush deferred writable TLB entries before we could
+			 * drop the folio lock and others could start writeback.
+			 */
+			if (folio_test_dirty(folio))
+				try_to_unmap_flush_dirty();
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked &&
@@ -1496,12 +1502,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (!sc->may_writepage)
 				goto keep_locked;
 
-			/*
-			 * Folio is dirty. Flush the TLB if a writable entry
-			 * potentially exists to avoid CPU writes after I/O
-			 * starts and then write it out here.
-			 */
-			try_to_unmap_flush_dirty();
 			switch (pageout(&ctx, mapping, folio, folio_list)) {
 			case PAGE_KEEP:
 				goto keep_locked;

-- 
2.56.1


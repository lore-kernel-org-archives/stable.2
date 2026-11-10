Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320755;
	b=if9KD9A4aUTo3ievFrHHqVs3I1WdC6r8EneahS2CThgYTG0c1FSDeHAWiZsUlUiBymQ0
	 EOoTaN2FHd60rbskIZDQNGBHSCzTCcufWUI/DegYDEiLlmipon7WrPM+UCq04wuSEUeq1
	 38OQj+wVQkpwdJn6q6gDuUI/DQU6LQx9Uevo6FYUIG/IONvO1/Yz2VKnGIVpv0Dvcgrt1
	 SWzqBKukryOiERfeIo/1tkbA6dH0P0afdNmEEta3pEZkzba8w2i+diVkQ0E7aNGqVcXsl
	 +bexP1w/2/63bODgphgMjEJBSdbpticEjbxgDFFs233+lzXvoH6mkMuKQQ6C2CSeqfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320755;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1SdcJCc/iiKKfdxpjKj0mAt0eliJYcVIqUBY2Eb0LBs=;
	b=Qh2wJMo2cJcM9G6dqnSW8BOvYK+qIS74DAxSoUUYCPiIusGrPf44lvE60RsPrHgubJXY
	 PPQV0REcfAUH0nMYkwnT7FBGGqOCybeJ8TpG1whblUUa72WdI7E55KVxeh0PIlD0IOPKD
	 SRsdahN+9MPnZ7ypNLzxcL6XgOQ4AYfUljl5WI4vKa6a54xJvd2PbD8el/fLsqZiekf0/
	 ca5oHIyb6FlTdM90tExNuk4ok5EVXPery5RLRWWikM8ms55gQI60pWD7CQbXl6bd30lEe
	 TjCZnkt4sdU1bajwlGolaANhY/DAaR3xG78PFiUaQ34syj4xmrTY8K300SONIs7XR5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4ufB3bb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BC60A3817
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4ufB3bb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B821F0089F;
	Tue, 10 Nov 2026 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320754;
	bh=1SdcJCc/iiKKfdxpjKj0mAt0eliJYcVIqUBY2Eb0LBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4ufB3bbcY0gOvWuTU+zyCOYr5mQfLh4rWyvXyYO5UDFZ4qYjZC3x/nTl2LwBszNt
	 ksBFCsRFdx+bIWHJvxd3cifcAbwIOH/z3w/amJm0DNsc0p81M8u4iYS1AsFros3c36
	 Lxk9qwsusSk3n5RYT7wU2ij5zk9U+PeUdMDMtmFnlY3oKs093Dw+CiUFOExHqnZ2jW
	 1vI1ViWgEm1xzPNc94jslYyD4+YD0Bk70CxIopP3ijyMmnxw4P4KORJKVh6XBLl1qU
	 nUtPbBERWYWFskjK+Gzzo3GI9St/A3UyFNM+qk/gikD7dqt3OmYJpMZ/VlwtxylELG
	 zAE7PCAynjsbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Usama Arif <usama.arif@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/huge_memory: do not touch frozen folios in deferred_split_isolate()
Date: Tue, 10 Nov 2026 09:25:51 -0500
Message-ID: <20261110142541.1866536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051938-failed-6.12-5da8ec3262bb@kernel.org>
References: <20261107051938-failed-6.12-5da8ec3262bb@kernel.org>
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

[ Upstream commit 5da8ec3262bbb40f057f3b0dacc18f37bda06f95 ]

Patch series "Fix deferred_split_isolate() and drop the split workaround",
v2.

deferred_split_isolate() probes each queued folio with folio_try_get().
folio_try_get() failure is treated as a lost race with folio_put().

It leads to wrong results when !folio_try_get() was not caused by
folio_put(): for a frozen folio, PG_partially_mapped gets wrongfully
cleared and the folio dropped from the queue.

It came up in the review of my collapse RFC series:

  https://lore.kernel.org/all/20260824131224.73344-1-lance.yang@linux.dev/

The bug is inert in upstream code:

  - __folio_split() works around it;
  - __folio_migrate_mapping() freezes a folio it is about to replace;
  - reclaim freezes only what try_to_unmap() already unmapped.

No cc:stable needed.  But my collapse rework steps on it, so it is worth
fixing.

The branch the first patch removes also hid an inert, pre-existing bug in
the zone device path:

  https://lore.kernel.org/all/20260827163838.1813081-1-usama.arif@linux.dev/

The first patch fixes deferred_split_isolate().

The second patch removes the workaround for this deferred_split_isolate()
behaviour from __folio_freeze_and_split_unmapped().

Tested in a VM: split_huge_page_test, folio_split_race_test and cow pass.

Also ran a test that leaves 16 partially mapped THPs on the deferred split
queue and drives thp-deferred_split through debugfs, checking
nr_anon_partially_mapped.

This patch (of 2):

deferred_split_isolate() probes each queued folio with folio_try_get().
folio_try_get() failure is treated as a lost race with folio_put(): clear
PG_partially_mapped, correct MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, take the
folio off the queue.

The folio_put() race is the most common case for !folio_try_get(), but it
is not the only option.  Another scenario is folio_ref_freeze().

A zero refcount in such cases does not mean the folio is going away.  It
means "don't touch me" and current deferred_split_isolate() doesn't
respect it.  It can lead to unqueueing folios from the deferred list for
no reason:

    CPU 0                            CPU 1
    ---------------------------      ------------------------------
    freeze a mapped folio            deferred_split_scan()
      folio_ref_freeze()               folio_try_get() fails
                                       folio_clear_partially_mapped()
                                       NR_ANON_PARTIALLY_MAPPED--
                                       folio off the queue
    give up, put it back
      folio_ref_unfreeze()

The folio is still partially mapped, but it is no longer a split
candidate.  Nothing queues it again until part of it is unmapped once
more.

Skip the folio instead: whoever freezes the folio, owns it and owner is
responsible for its fate.  It also covers the folio_put() case:
__folio_put() unqueues the folio via folio_unqueue_deferred_split().

Nothing is lost by skipping.  Everything that frees a queued folio
unqueues it first, and folio_unqueue_deferred_split() clears
PG_partially_mapped and brings MTHP_STAT_NR_ANON_PARTIALLY_MAPPED down on
the way:

    __folio_put(), folios_put_refs()   mm/folio.c
    __folio_migrate_mapping()          mm/migrate.c
    shrink_folio_list()                mm/vmscan.c

__folio_freeze_and_split_unmapped() does the same by hand, under the
list_lru lock it holds across the freeze.  A freeze that ends in
folio_ref_unfreeze() leaves a folio that is still partially mapped and
still belongs on the queue.

Link: https://lore.kernel.org/20260831091514.1879786-1-kirill@shutemov.name
Link: https://lore.kernel.org/20260831091514.1879786-2-kirill@shutemov.name
Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lance Yang <lance.yang@linux.dev>
Closes: https://lore.kernel.org/all/20260824131224.73344-1-lance.yang@linux.dev/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: Claude-Code:claude-opus-5
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
[ sashal: Adapted deferred_split_isolate() changes to deferred_split_scan() because the list_lru conversion is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d175e93988a92..7fdf980a49d67 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3860,18 +3860,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
 							_deferred_list) {
-		if (folio_try_get(folio)) {
+		if (folio_try_get(folio))
 			list_move(&folio->_deferred_list, &list);
-		} else {
-			/* We lost race with folio_put() */
-			if (folio_test_partially_mapped(folio)) {
-				folio_clear_partially_mapped(folio);
-				mod_mthp_stat(folio_order(folio),
-					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
-			}
-			list_del_init(&folio->_deferred_list);
-			ds_queue->split_queue_len--;
-		}
 		if (!--sc->nr_to_scan)
 			break;
 	}
-- 
2.53.0


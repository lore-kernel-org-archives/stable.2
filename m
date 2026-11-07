Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046127;
	b=01+AFeCQTVn1N8h3jzPFVfjus2ddhA3lcZ1lQFjhMyeskbX/GItS/GDHP9MUpzPssDUS
	 rcOk9zkqOHB+2C8fYrcZYGoCmfksnL2zQpnuHf1EiCazJR7Fcpqj2nhFptR1kv0Jbqvl+
	 JizDGN4Msd9JKlM78kIUss2zy6KWGazg+dUS23EyOBOB3WBbV78tPNRNO9r0LaI9mDzI0
	 WzZpy7LFOs9kqd3jfENYE9Br2OdQaAqhYY2o/J+vx4Yq86YGUvTgvuNxl5NtwAStxRAWC
	 mGQ5RT+QxXcs2gGk0z0eEM60rTUHzseNNn6iPg2E2dZhy9eaMVc2G3AezIKP8nXEw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z8Sqp99AqUOH7GbRfon13s1b/wmq6YyBIOy7RQMXJbM=;
	b=eelqbzPOIyVT7w01/AvBs3+XBt+fKrKv+IbkBXu3t6DXaEIiDXyCz7poCchLhDBoH4yK
	 nGjdw3x0K8Oc5fQdgES+VbvKuiBFoZ7X/ItrT/ryJWaaCYdvUMtO9pA0BrvKF/gsweXMD
	 Ln36UOUTh5yR5aroFCkYJmBJ6S7TxzjEg+1qAaUFJ95x7kpUsTROFXTEcoL6Tf/wbuLbh
	 9xVK9hIS1K6OsLkX7gyh8ifY8iNBtbhtZHF+Hvil6jq6pNKYz/PaT+PaYFD7buBVfngjp
	 NjC3j8GR8zESUQhNYFg291Gv0VeUxoZadZyXJ3nRkWcGK+6NN4qFp+8dIYR+EumTvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJxW6slN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJxW6slN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121A21F0089F;
	Sat,  7 Nov 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046126;
	bh=Z8Sqp99AqUOH7GbRfon13s1b/wmq6YyBIOy7RQMXJbM=;
	h=From:To:Cc:Subject:Date;
	b=OJxW6slNYuBwZd38DHQCFcLHMv9rI/hqo4/NzqpvdQ9KHBoD+htH10WMwWQaKRPSy
	 D984X8UuLemdUgaqdKD1zHtgpm1ukM/X24uDCayEee/s7+UUEYC7NogU9n+gLA65hO
	 pV9vHxQ/+1QpSm3EQN4Czn+e9RD7bGy0aTz/rNnqRfsyqOKCAU8wbMNgucT6pB3NR1
	 f5MnvnJtElthE7XaP0j9gAdo3efk+xGWB87zUmM1ThpBU2aI2SsLF/fkDsUToP4Zu6
	 Te+s3QCzgXnx1Nszwv5jHDmP8Gv07aXhA8lULI3YjNwA3OhIP0lHI899IpVl4oxRcw
	 jdGewTXTmofPQ==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	usama.arif@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	balbirs@nvidia.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	kasong@tencent.com,
	liam@infradead.org,
	ljs@kernel.org,
	ryan.roberts@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/huge_memory: do not touch frozen folios in deferred_split_isolate()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:43 -0500
Message-ID: <20261107050843-failed-6.18-5da8ec3262bb@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5da8ec3262bbb40f057f3b0dacc18f37bda06f95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050843-failed-6.18-5da8ec3262bb@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5da8ec3262bbb40f057f3b0dacc18f37bda06f95 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Mon, 31 Aug 2026 10:15:13 +0100
Subject: [PATCH] mm/huge_memory: do not touch frozen folios in
 deferred_split_isolate()

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
---
 mm/huge_memory.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 54494c3fa9835..779c02e0bf6cc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4638,22 +4638,11 @@ static enum lru_status deferred_split_isolate(struct list_head *item,
 	struct folio *folio = container_of(item, struct folio, _deferred_list);
 	struct list_head *freeable = cb_arg;
 
-	if (folio_try_get(folio)) {
-		list_lru_isolate_move(lru, item, freeable);
-		return LRU_REMOVED;
-	}
+	/* Lost race to folio_put() or the folio is under folio_ref_freeze() */
+	if (!folio_try_get(folio))
+		return LRU_SKIP;
 
-	/*
-	 * We lost race with folio_put(). Read folio state before the
-	 * isolate: folio_unqueue_deferred_split() checks list_empty()
-	 * locklessly, so once removed the folio can be freed any time.
-	 */
-	if (folio_test_partially_mapped(folio)) {
-		folio_clear_partially_mapped(folio);
-		mod_mthp_stat(folio_order(folio),
-			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
-	}
-	list_lru_isolate(lru, item);
+	list_lru_isolate_move(lru, item, freeable);
 	return LRU_REMOVED;
 }
 
-- 
2.53.0





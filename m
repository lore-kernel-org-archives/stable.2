Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B84C6F06
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447660; cv=none; b=YRCHjH2q7ml48e8DImeHa7rRHAOvTIy5bBlUnUTStI5fsb+LivxJ0tpoEAh+IjRr8rZasO89vVKO9+QS5AIIJS5bjTQeB0BB5WezYnxEIMazAa7tNFmY9WT2rA+HUfHx5aRejrC3CzPwef70dMM1R/E7TgqKGuTam5NOYJoNGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447660; c=relaxed/simple;
	bh=Rtca/pj0INU3dQ+/DVchIeO41O3YJyoBxs0PYiSwZs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYN7fv71eVQSUHUwE1H30cym6ie6xh46VZ1rJ4SeTqlET6HY7gpJOq9E8KwDgU8klnq+y1xOVa/QGzV/kir7GCVXsB57c5ByW/YWVZaaBGR0o+lK6dyy4hsKEx+7o/f6X1heKIIAjHb7VOKNel32YNs/WiWA3tCD5lBUsOUt8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhuauml0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhuauml0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A45D1F00A3D;
	Thu,  3 Sep 2026 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447659;
	bh=4JE/ZwJQ10Bghrlyv6FD/WlpZAJkjjcPDvextFcWNfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fhuauml0a7KnXggiqhuX12FWSFCcLz6JSz/toPqSZNYr7RymGUpvW7OpC4y0Jbphj
	 kCGFAe7INaVzd4TSDDJmfUDOqhimu54fmPoYfsmlhklm6Z8/JElGIQmMeaC0Pdospf
	 +57gaTOL4wNlafSN+8/s719rVTHY2+gYRKjSM+R2awPVV457QlkMLHzlHATBQFRR5d
	 tXsUgnk+7g2maahL8bZOmuw3Yj2gPcv+zUEGOdlLUKW6Ui97Q7RYdWSyNjQk3JRMVJ
	 vW6omh1QeSME+MHnW4NvMsNAK4ilbUkMH3+bmjER0YKYnXhh1WTnK/VegO5XXyBqao
	 YwW2KH/kC6ynA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
Date: Thu,  3 Sep 2026 11:00:51 -0400
Message-ID: <20260903150051.856389-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903150051.856389-1-sashal@kernel.org>
References: <2026090322-cucumber-clumsily-daf5@gregkh>
 <20260903150051.856389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 078e1a0fc41a42baaf113383b52dab8874c0b967 ]

folio_may_be_lru_cached() is currently only true for small folios, and
for small folios FOLL_PIN adds GUP_PIN_COUNTING_BIAS references instead
of 1 in try_grab_folio()/try_grab_folio_fast().

Consequently, our

	folio_ref_count(folio) != folio_expected_ref_count(folio) + 1

check in collect_longterm_unpinnable_folios() will currently always
identify "reference mismatch" and first drain the local LRU cache to then
drain the LRU cache on all CPUs, as collect_longterm_unpinnable_folios()
is really called after pinning the folios with FOLL_PIN.

Add a comment because the current code is not quite intuitive: we used to
drain only to make sure the folio_isolate_lru() would succeed. But then we
also started draining to make later migration more reliable.

We'll refactor that code soon a bit, to also make it usable in other
context where we really want to remove any references from LRU caches.

Let's add CC stable, because having an easy way for excessive LRU cache
draining on all CPUs does not sound right. In common scenarios we
don't expect to ever have to drain.

Link: https://lore.kernel.org/20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org
Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drain_all()")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 937865ecfae00..810a4c32ee870 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2362,6 +2362,7 @@ static unsigned long collect_longterm_unpinnable_folios(
 
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
+		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
 
 		if (folio_is_longterm_pinnable(folio))
 			continue;
@@ -2376,15 +2377,20 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
+		/*
+		 * We drain not only to make the folio_isolate_lru() succeed,
+		 * but also to remove any other folio references from LRU
+		 * caches.
+		 */
 		if (drained == 0 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
+				folio_expected_ref_count(folio) + pin_refs) {
 			lru_add_drain();
 			drained = 1;
 		}
 		if (drained == 1 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
+				folio_expected_ref_count(folio) + pin_refs) {
 			lru_add_drain_all();
 			drained = 2;
 		}
-- 
2.53.0


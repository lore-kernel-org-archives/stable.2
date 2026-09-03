Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0B36B939
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459457; cv=none; b=c8P2q+Fiua9qYzKRCv3lcMcSXNRsU9Qdr7Ud2sjMxkVAstWI6Z3N1BXnz4AX2Vby/fqES4LXOPSFNOMvYtdeRrvgJdkPUQvy9YELrXauZmWsvX2eEBkgt1kMaTKAgX/l1V6L1ADPOAk5C9IckM7nG6QuIu0bur++q/uKc+jnYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459457; c=relaxed/simple;
	bh=qs+bKvVjb6CBmcdl36J+jxDGjUps8bRYSswsAbo6x6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llXdzx4gtPOU1xcnbI7+K0qgJ68W6VPU3Dz528spHZrBavYTvSWeXCa2L8DKTlVzH1J3kKW6LJ5rdXDvY3Q420t6dKWEqSM5rEw7TvK/WAARxi6vY1qVG2p7Xm9NqPlam84jHMo7l2SCIRVR/35rTZ9Ov8HdfP9X9YcdEE+U3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5lXPTwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5lXPTwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336B11F00AC4;
	Thu,  3 Sep 2026 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459455;
	bh=JpKVqvM4/i7fNq6yfICvsgSnFR8EG6WNiDrseHUrLEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5lXPTwTnVfOSp+WJQnSoTyc9Cpv/wET1zq1pRBuLEEwxiNx05SegpSYVYf4nDvxs
	 tzVKilu7x9L96bzCH44KbURSci3XSx0GGdmFx7LzRLRyeIdjwha27QXAEjN+bwVFbj
	 Ax2Poc7SttbOxQusbrTTOlofhpwoX/tjHkCQJvDUcbvmXoxW0dje8cfR6o8wvECp+b
	 SIteTS31OB+6r66MwXuGuT3mbzlur2MxUSK4lYCYrnuwTYtuHNU920GrYBKXgBPeXQ
	 9YtW+wLOqDsxLtmb1+ancoeMwQwurngK34WzmI/VsZe2sy2y4XkoMP6XqQ+dxKzoDt
	 YKGWnJ6BJpSVA==
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
Subject: [PATCH 6.6.y 3/3] mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
Date: Thu,  3 Sep 2026 14:17:27 -0400
Message-ID: <20260903181727.1432502-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903181727.1432502-1-sashal@kernel.org>
References: <2026090339-stapling-ecosystem-7341@gregkh>
 <20260903181727.1432502-1-sashal@kernel.org>
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
index 67620c13acd8f..a5d52471ea341 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1970,6 +1970,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
+		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
 
 		if (folio_is_longterm_pinnable(folio))
 			continue;
@@ -1984,15 +1985,20 @@ static unsigned long collect_longterm_unpinnable_pages(
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


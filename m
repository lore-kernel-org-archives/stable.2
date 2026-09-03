Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B02382F28
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463907; cv=none; b=nQ7rjxRqJY8/w6RU10V79OIuqkCa0DNQY9QwPiBpM3J4b43r9dgbti050608CEkHmrLQ2gw42mBm1gbpVSwtdQBmfeosjgwFo2cs10J10c1Qy395hutCgR20OE7hHuTZ0vXknSjrNno2l68y5de6ZeEpGwGeJbrlB3k9rvF7/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463907; c=relaxed/simple;
	bh=bxoR50/4lvHFzJofApKvO7WHZ/sBpeTSQTcYcp49Opo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjjL/37JJBiTc7t4Q+BC5ONVq1mMUsB2aNbbFCUrbdHlhyQXX9YNo0lNoS5CLQz0ByES5XjG1m9VB1noSltbk04QgACTwIPE4FgNtxiqBvhBJHfc8Pm3EGwF1hGtlopvH1XAOZrn2Y2U+j2w+t9uyoPl5NaxsHo3AfPP73XZ/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTg3kgKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTg3kgKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9031F000E9;
	Thu,  3 Sep 2026 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463897;
	bh=9SXjOobqieHguZBrDM5DlIsO+yERis4KMVcJY/lpDnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTg3kgKzA2dhKgsKVoGzvvDsWzF5fanOEHk9FS2x3toNiDtXD3P5ZWWrFEql6rq0/
	 PCDvqjy0XT3KtnujySl3/mqdARxAUUiwjDmW8q4Ou1LJtNmSsQFTaGj8kEeHaGie9a
	 mFejJK+3Cw9x8YNPzZE8YspuT6b7B5U6CH8vIwpxfLABz3AZ+oCTmHFyBrEndst8jc
	 THog2zrSKE/FtLpHpZRgtIf0G8K4VAIxoa2zr1G5Qsb167SGU4xFUqiDMV69O4LnUt
	 68zheY6phwBYyLYKvUMgl26Rg6Q5z6KE0mjryBbjR5pyLIbDA1SFPXfZzI2ZsMhiAE
	 GM983MZMJweYw==
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
Subject: [PATCH 6.1.y] mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()
Date: Thu,  3 Sep 2026 15:31:34 -0400
Message-ID: <20260903193134.1609095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-crisped-bouncy-5af4@gregkh>
References: <2026090339-crisped-bouncy-5af4@gregkh>
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
[ adapted pages_or_folios iteration to page-array iteration and folio_has_pincount() to folio_test_large() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 72e01b8311d7c..bed94c3d6e82b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1972,6 +1972,8 @@ static unsigned long collect_longterm_unpinnable_pages(
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
+		const int pin_refs = folio_test_large(folio) ?
+			1 : GUP_PIN_COUNTING_BIAS;
 
 		if (folio == prev_folio)
 			continue;
@@ -1990,15 +1992,20 @@ static unsigned long collect_longterm_unpinnable_pages(
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


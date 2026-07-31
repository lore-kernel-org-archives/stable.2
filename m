Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24A3783C5;
	Fri, 31 Jul 2026 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529679; cv=none; b=bni79MMbwHmXaYLkJm7f58D3FIi79Tceq4nlevgQoX1vMDhNDwE7qxiB/XxPdcSjzqTsAEIRFReKvaFdTAfsCRC0UbEAZanlIsd87ZxpzFoYn1pt8Qe/LjmSL5vEtrMXbx4mMgiS2xbFXD+KrVZH5Xg7zNxU0sXBNoCeGUbAfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529679; c=relaxed/simple;
	bh=48Z5mFiX7lolv5LIYTw8xaRjvIjy1WKS/COUjFxDGLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EY/YFcyA0eWAxuWBpLk5G7JthjQgdN3k9yoESvba6keL/LIsoBTulPPTdV8TV/ymjtBqZ7ggOqm8F7ZYcAL6zKmpqc6EUju+331jZKBY29GDIu3zaHW6950UAMS5NEo3ZnstQpwOKVtjrxjwggX1ZlVaCcss3p0aLAvZvS3eQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFIjkNX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFIjkNX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26181F00AC4;
	Fri, 31 Jul 2026 20:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529678;
	bh=9qfPqO6NrOfLYn7J/1lyzBCINOrMbaXhOXxJLpXlDBk=;
	h=From:Date:Subject:To:Cc;
	b=CFIjkNX0/mn+iwlSjgM5yeRja1CmlZeC4sfDNOh4l+ry6LAVWl6faT4OZPMJoyYLM
	 iN7lVe/Z1eSsz+AWv50TNXaF3Qh7HkD9Bv6+3RyTPATzXQYuREwbltG/T4cO+jj8O/
	 uTbsUvi1DpbMujI788V6TYeCdIzifxMGxZr+Bb+RTj5qBMhNJD+7UFbT1E+hqscYOu
	 wjhance+0jzDI5wbD2vcDIAXyRbqj/3j6z3G8GM7RBzZJ0MONcGeWFDwu42dKS/2/w
	 p1RJ0bm7O5YLxCcYpJX1AQGHD+GYbx9uwzEaQnCaFNE09S7BktO8Pvoxgdf0sgiCMa
	 lLaTHtQ9MHK4A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 31 Jul 2026 22:27:53 +0200
Subject: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEgFbWoC/yXNQQqDMBBA0avIrBuIxljaq5QSYjLqtJpIxoog3
 t20Xb7N/zswJkKGe7FDwpWYYsgoLwW4wYYeBflsqGTVyKsqhRvQvY0N3kzUJ7ugmeJq2xFNF0e
 KLGqlpdS6udXKQ87MCTvafovH82/+tC90y7cLx3EC44Xgq4QAAAA=
X-Change-ID: 20260731-check_and_migrate_movable_folios-43500556943d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Ackerley Tng <ackerleytng@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2

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
don't expect to every have to drain.

Fixes: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
Fixes: a09a8a1fbb37 ("mm/gup: local lru_add_drain() to avoid lru_add_drain_all()")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Found by code inspection. If someone has a testcase that can easily
trigger this and result in migration problems, please test! But this
change seems to be "obvious the right thing to do".
---
 mm/gup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 99902c15703b0..41c3317e0f0f4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2273,6 +2273,7 @@ static unsigned long collect_longterm_unpinnable_folios(
 
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
+		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
 
 		if (folio_is_longterm_pinnable(folio))
 			continue;
@@ -2287,15 +2288,20 @@ static unsigned long collect_longterm_unpinnable_folios(
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

---

base-commit: e5492213654050379e78ec6f9acfd6c9fe00f334

change-id: 20260731-check_and_migrate_movable_folios-43500556943d

--

Cheers,

David


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD14A8FF2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439486; cv=none; b=Y8nI2GHtExM954TRRdOCMyvXQbeF0Euy/6rHMvB8QvdatMBYuQJEso4elH0zLSEU9FWVW+rzaRz3hfhSSkJH0OqGlJNqyIMJKm9bBBkfXj9nvvzH7c9fyqx/JcaPg2+wYs/N1xL4LQnr5VKTH2qDmQYXEMf7rCFrGjKNtLhvrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439486; c=relaxed/simple;
	bh=ppb2PfRgqvtj1GLera4WsE331au/rjST4AsU6fhCir4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rEeQjVlAUZ8KgPtFdfvVfJsO0R6DroT/un5DT5vKH/7s9FWndmCAqDre7SjGWfaY33u79uwQPEnoeEt2ihMbT0ONcISKE383pwhD86Z+u38GZLYm36VMPRFFfMpVp6vntvOmHoDakxnD6Rsh7Eauhla9TewbG0Ge0xYJnIHhNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EzTof1t6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EzTof1t6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA6C1F000E9;
	Thu,  3 Sep 2026 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439485;
	bh=OZj91Mr9dZc3bRBMcONi4UdGr/vR6pjxYGke5vEmIao=;
	h=Subject:To:Cc:From:Date;
	b=EzTof1t6YCzzhO1KF8dTwapS90Oio9Z031vyaSHdezWu9fUTeKRB0iptNcNazKqYf
	 wIaBx6J6GZFQ5A3AwDxRta7REfGF9KS3KNscHj8QfDjgYq3QgNb9VDk/IQdECqzDuC
	 50sjy2HVi7dWfRS2KtQmBgveQVASzL8doz9vm0Sc=
Subject: FAILED: patch "[PATCH] mm/gup: fix always draining LRU caches in" failed to apply to 6.6-stable tree
To: david@kernel.org,ackerleytng@google.com,akpm@linux-foundation.org,hughd@google.com,jgg@ziepe.ca,jhubbard@nvidia.com,kas@kernel.org,peterx@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:46:39 +0200
Message-ID: <2026090339-stapling-ecosystem-7341@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 078e1a0fc41a42baaf113383b52dab8874c0b967
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090339-stapling-ecosystem-7341@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 078e1a0fc41a42baaf113383b52dab8874c0b967 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 31 Jul 2026 22:27:53 +0200
Subject: [PATCH] mm/gup: fix always draining LRU caches in
 collect_longterm_unpinnable_folios()

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

diff --git a/mm/gup.c b/mm/gup.c
index 8ea3de60e82d..bce275c7dbb6 100644
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


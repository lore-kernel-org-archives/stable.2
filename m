Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050926;
	b=ml7C94Zn7+DnsxM/VIvTUS+d8Ho/o4MZBQpki7z+/EMk8cLJbD0ADh9Uqf/aTpQCxBjv
	 4rDuEuS1HW4hWQiFGKFJsHpu+XzZWv6HoB5a1ZU2tXejOAMfAe4bf+qg4SU5NpU3bcj0R
	 bMD97Zn2A/GYnYNnyNXx2eMVtgUGYLR0fdHmrDDaFLOHJk0Hm3ktolFQCjB1/uLnTZD3F
	 72xFYOGT8s+/2OaJ/XU3sX+gx6rMlHQ+BJIvJsFgLiiEWQWhn0q0yr1pT/DvaH0cXiNej
	 aCNbtfhVPa6coqP7l3KHqGisXGmTDq2sto4id6fD/gwuattDZjprzMJFczfV1loeXRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TfNMy7Ac0s4h1/NW1lWU0RU/aurtt6aUGogufxk0BcE=;
	b=JTKVh19yjrcPw57cgABcR+fMSoyzJj1bshpyEAjFWJopX2RG9N6GFVMVOqbE6OAm5e3+
	 +gJ4s6lbRS6HqcDXP+BFNW1mVqpoDsEuX6mM5/H5bqI1EB/eRVfDhmqQeLjXYbuGRIU7L
	 eyEJ0zffVioaGDZ98Sq8Vk26Xq2WlQpjPixIqw/tpNkOKfTQVdloHSYGnJJxdOp6GHS4x
	 oRjbqIbjNdQ7O6p/4KsXNfGBt/0NwlBVQNmP15RNBN0viYpEu3jy4p5gb1ZTFk50bBqSn
	 7eKQsjkMvkuNf7aBFBK8GfrZnzq1vqJFF3vEEoFjWo76/tyLjXhJgVZ5Fbq+KqRdwNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYDYn1+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC838606D80E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYDYn1+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A7A1F008A2;
	Sat,  7 Nov 2026 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050925;
	bh=TfNMy7Ac0s4h1/NW1lWU0RU/aurtt6aUGogufxk0BcE=;
	h=From:To:Cc:Subject:Date;
	b=NYDYn1+4JCXk9wfn04t2qyOVuzZzZ/NYR5vSnCRzg+1NA7RXx4v2BIRYwN4XfOZqt
	 S6q0S4dyVS27fM6D2g9szS4ZYp/uG8uozPf6wvr0cSxH+e4/p5rXbiTivs1jFFr2tv
	 tsW0m4yCrie1yrprpyJnMbn3mBplVt1pVXH17ZEP1JaiAMjr2Fzrz33aGaM4ufFQaB
	 /HHrqXT6aRhZUXvrWFGiiSZYp3hoj0buyZdgJoN1bO/UaQdftEZzyVOtsYqLKOHLYZ
	 lh55FHLQceXKA8gdZ1XAHtGujMcCT5ug7++OHDQWZgx4MAiAhEZTuRFPBQ+zbQEMaS
	 z/jkpIDeDkS6w==
From: Sasha Levin <sashal@kernel.org>
To: pfalcato@suse.de,
	akpm@linux-foundation.org,
	samarth.colleges@gmail.com,
	gourry@gourry.net,
	ziy@nvidia.com,
	ljs@kernel.org,
	david@kernel.org,
	sj@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:42 -0500
Message-ID: <20261107062842-failed-5.10-246c8cc33438@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 246c8cc33438a71c28f9b86baa492d9a0a130316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062842-failed-5.10-246c8cc33438@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 246c8cc33438a71c28f9b86baa492d9a0a130316 Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Tue, 13 Oct 2026 20:17:19 +0100
Subject: [PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD

As-is, madvise_cold_or_pageout_pte_range() discards the hardware young bit
by invalidating the PMD, doing pmd_mkold() and subsequently writing to the
pmd again.  However, it does so in a racy manner, looking at a
possibly-stale snapshot.  It's entirely possible that a write elsewhere
set the hardware D bit, which this logic now loses.

Fix it by using pmdp_test_and_clear_young().  This is an atomic
modification of the PMD entry, and thus safe against any possible racing
writes.  As a (nice) side-effect, this elides one non-required TLB flush
in pmdp_invalidate().

This bug can interact with the swapping system in complicated ways,
leading to data loss.  For instance, if a folio is marked lazyfree, but
was later read from, and then MADV_COLD'd while racing a write to that
same THP, dropping the dirty bit may lead to data loss as
reclaim/MADV_PAGEOUT drops the "clean" anon folio:

T0                                T1
================================================================
MADV_FREE(thp)			|
  folio marked lazyfree		|
read(thp)			|
  PMD marked young by hardware	|
				| MADV_COLD(thp)
write(thp)			|   if (pmd_young(pmd)) {
  PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
MADV_PAGEOUT/reclaim		|
  dirty bit may or may not be   |
  set				|
    reclaim/pageout may drop    |
    the folio			|

Link: https://lore.kernel.org/20261013191719.95502-1-pfalcato@suse.de
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8702b082a02d8..75b409e97dbf2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -430,10 +430,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.53.0





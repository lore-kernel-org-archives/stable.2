Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049903;
	b=ir9dfnPzvz3xAAU5Ie7U2LMMXv9pOFjfUNbWBs9q7kThWUajwX+ZUJkDoFH6nIOWZpD6
	 ujpDZyVfU8MM+VstbTMdgmewfIs/Lfxf/ZfKj9cem8bscwl54NBL1oeA8PK1dlk4bYgHg
	 Zh8BkZsAlbVCThiIyizoyL0HwEEnjYvYnixiHStw0vXGnc7UZ2OBtTN0S39WzpspEFto3
	 TxVFUT7ae0Do7R9R51EZ7L/EwXpOdabKdclEvx1lzKtrlJy5CElwONquN5Ga3rYWxFc7Q
	 32xlJqa08tfiugHQebXfe/5uFGPRelzSisWywmYw2xylAsDATRhMrDmj6GTwPX+s9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049903;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U+C+bjaC0EkEETaSmmjTvNYa1GyzKclAK8/O5K80RXI=;
	b=R+NIZJbKhSGhh/aaSSpm21DFpFi95iV7WPWWxtftT9Lifqc0AV4Jrd/DB9Y1xTMVzqKV
	 gm5rvUXmIjpjPtIBNwRBRn2PqruSHtSV18E8hdjU5qQkn/5ZHQu6Yb5BV0Fc17iYqrCdq
	 YH0syRESh4I7Hb4m1En2DcEbk4OxoORTHYK3wZfTU3PaOovaID4EQCbeo4NRTl/OWHNpM
	 Tl2GID14BiwLLfv4LOgVeNAf0RG3vp+b+aIQwR337M9KKvovMke/g2dgYiwdHXcVr037K
	 Niu1dtnTt9ljqdTTUAj+pdvmsMHq4JmEWaM9B4YZG2wXJSRvfwyUUy2Ezz1OPHSSm4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZUYnT/un";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB04606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUYnT/un
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295301F0089F;
	Sat,  7 Nov 2026 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049902;
	bh=U+C+bjaC0EkEETaSmmjTvNYa1GyzKclAK8/O5K80RXI=;
	h=From:To:Cc:Subject:Date;
	b=ZUYnT/unvr5f+c0h/i6H8SL7mjEPw2whppgfDIeRHy/v44j+eoPCcjr9r126r7cdA
	 LA2T72wghMAzkm2DNMxEoPyKqQ+1iAx5gOzFSPOC+Bg0Ax6dcc8UyHyFcugi9Xv0xe
	 XbEH1wpC9fKQgoFM6JtnfW7gUI98m4C0s5VsjCePIlqHHGE1FB9nh5k6UISIK4MxM5
	 gQbCFCtHdpw0pqtUURDWqb3S7Iquw3pPiXHh46EZPCk6bzc76Wbxv5/qLLjpLIxfeY
	 UZtA/tZXSrjalCQLs/4FB0o9svdEdhWJZFXxo5oMHmFNyGuWczn1e+KRe4hFz+yACk
	 MQIVhOw0QrIBg==
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
Subject: FAILED: patch "[PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:39 -0500
Message-ID: <20261107061139-failed-5.15-246c8cc33438@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 246c8cc33438a71c28f9b86baa492d9a0a130316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061139-failed-5.15-246c8cc33438@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050911;
	b=qnh2NDcYirYPew3GEcIgzwt3JlZbg6IyvKB8wm240FgyG+Dl3aTGQ1yHzqol+K6c8LWD
	 0W6n/ART7BLb9c/QW03POfBT2VVYoUgWppUbJpNR6s6GKXfJ4HiT8mgc3eDM86hBdx61J
	 pIZ04qZDecfa6J8cYLowEudeoe9kaDjvTRJlnVCdtr/PqZPCkkBlospQqsb+XSTdYf1rO
	 L+YRYUiJs9qHIGwC8xG18gFNCxyS5hmTD+7e9VNfpkiLIXzHXsn89ZgDNiZMeMmg4tUyM
	 +poTuoOED+sxyfqeQaXRjXH7qQLiijdYkwHFb4dXEf/Yp7oxXpx1xgDbhe8xoyWgdLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aTR/kWn1a3oZGLcsdQAI9NEu3yZJgm505jmOKYu9io0=;
	b=QuarG+LjiFe8a9J0sw/PHGkjqWaU28RLh8XaO1IEIKgMbKTJFiThYu717g/RFZu6rZOC
	 FRi6hyGKuaFaJYRxoSpVBxVZlMwDKuhy2aS8s3vQF6l5zIH3/ArHaWnPrzyNJPzVbUMnq
	 eoimrG3FSYU9jlnmiAVeQbnXjmf7qPs8XU0eAr31TPH8filSOxJbEUCsXX5sfiQyZWAon
	 FnOE2q1ZVSev+TMPoMfLDtu/8UqAfEYiqcugIEHAVqDPFMiCnV2APQtZL+6ed9CYfoIZE
	 4QqMnV4tSbhBGqyaTETV133Cgwl15w4hbtGjK5PQ12l4Da9mlXN3wAI4DGOCjH0rPbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlUd061+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlUd061+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02A71F008A1;
	Sat,  7 Nov 2026 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050910;
	bh=aTR/kWn1a3oZGLcsdQAI9NEu3yZJgm505jmOKYu9io0=;
	h=From:To:Cc:Subject:Date;
	b=RlUd061+gteaP8y8eiYyaZfeRzRWRdKUSIkjNum0ByeCUojL4NnGfNWz6G0sHw1ra
	 abnXAs6BvLQNXXfIS/NLClMfHjfKynH3zZm534BztxUl5xuJsEehUPwdcbP+MVyx0K
	 ir0rBtymofPCDn0Rh1T4P5LzsAa9+R/TQLmQ3HcVrASobGt9ozclEYTwSXVCTKRLin
	 JKDEar5NFWXR3SPfvRE69Euw/MeMpNiZXcdNIPXcXHwTAveOqKnRqE5azwaR/3FsYR
	 HXxJ7T39R5NRr/qX1wZcTfGGdxYflv1UNtZVV7SxdwH4fbJJKcFpftIZmxYPgpqORt
	 556dIr4sykwIg==
From: Sasha Levin <sashal@kernel.org>
To: albinwyang@tencent.com,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:28 -0500
Message-ID: <20261107062828-failed-5.10-f5cfc8e3b20a@kernel.org>
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
git cherry-pick -x f5cfc8e3b20ad71949a1e5623ff45882c063a71b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062828-failed-5.10-f5cfc8e3b20a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5cfc8e3b20ad71949a1e5623ff45882c063a71b Mon Sep 17 00:00:00 2001
From: Wei Yang <albinwyang@tencent.com>
Date: Sat, 10 Oct 2026 10:40:42 +0800
Subject: [PATCH] mm/madvise: add cond_resched() in THP branch of
 madvise_cold_or_pageout_pte_range()

During stress testing with stress-ng on a 256-CPU system, a softlockup was
observed when madvise(MADV_COLD) was called on a 31GB memory region backed
by transparent hugepages.  The region contains 15935 THP PMD entries, and
the softlockup was triggered after 14485 of them had been processed.

The THP branch of madvise_cold_or_pageout_pte_range() has no scheduling
point.  walk_pmd_range() invokes it once per 2MB PMD entry with no
cond_resched() anywhere in the loop.  Each iteration calls
pmdp_invalidate() which issues a synchronous TLB shootdown (dsb ish)
waiting for all CPUs to acknowledge.  This operation can be time-consuming
under heavy system load, causing the accumulated time across all PMD
entries to exceed the softlockup threshold (20s) and panic when
softlockup_panic=1.  On a CONFIG_PREEMPT_NONE=y kernel, there is no other
opportunity to reschedule during this entire traversal.

The regular PTE path already has an unconditional cond_resched() at the
function tail (introduced by commit 9c276cc65a58 ("mm: introduce
MADV_COLD") and commit 1a4e58cce84e ("mm: introduce MADV_PAGEOUT") when
MADV_COLD and MADV_PAGEOUT were first introduced) and a conditional one
inside the loop (commit b2f557a21bc8 ("mm/madvise: add cond_resched() in
madvise_cold_or_pageout_pte_range()")).  The THP branch never received
equivalent treatment.

Fix by adding cond_resched() at the huge_unlock exit path after
spin_unlock(ptl) and reclaim_pages(), which is the single exit point for
all goto paths in the THP branch.

Crash log:
  watchdog: BUG: soft lockup - CPU#63 stuck for 23s! [stress-ng-vm:1665914]
  ...
  Call trace:
  pmdp_invalidate+0x48/0x68
  madvise_cold_or_pageout_pte_range+0x84c/0xb00
  walk_pmd_range.isra.0+0x1ac/0x3b0
  walk_pud_range+0x120/0x190
  walk_pgd_range+0x170/0x1b8
  __walk_page_range+0x184/0x198
  walk_page_range_vma+0x94/0x128
  madvise_cold+0xd8/0x198
  madvise_vma_behavior+0x234/0x638
  madvise_walk_vmas.constprop.0+0xdc/0x210
  madvise_do_behavior+0xa8/0x328
  do_madvise+0xd8/0x140
  __arm64_sys_madvise+0x2c/0xe0

Link: https://lore.kernel.org/20261010024042.4070048-1-albin_yang@163.com
Signed-off-by: Wei Yang <albinwyang@tencent.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8f407610c089f..8702b082a02d8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -454,6 +454,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		spin_unlock(ptl);
 		if (pageout)
 			reclaim_pages(&folio_list);
+		cond_resched();
 		return 0;
 	}
 
-- 
2.53.0





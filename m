Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439867;
	b=L77JvqAPQZ3xArHpOmIE1cZw5iUpDR0eBOWmBBScMgm4uSRDpIG5GXM+oa7Lt48lrMWa
	 OonOn9Xs90mAH/Ox4mcCH+tmLdYy74Ryml0I3kQxoyZ5H4mzzg6D0S9uvwO0wbDMIIni+
	 +rjxmUmejNAW+uul4VegjR7fEerK4VQ90x5m/HkzY9BxeuW/MLV1Tn5M2rD6FdW+vJalj
	 3xbC5oI5WFB6clnjbJO/khDzVFoWyPqNaNSklsjmlLuOyHu9W9ty5prxJUCaJctKRXoPP
	 aqIvsikdL+0gIWN/zghE7LEtwwEGtcEezC/sFWsfoJ5NX9cIxoN6TfAexnElKy7L3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k+1O9jPeELVKycW88hpFgQtUmLFKkI8Ct3uwvEaLDCU=;
	b=4bTWuh5gkxZozH8myQ1yPeR1aDNkFr37xR7j1WT90QM+FAq5zd2uQnTPWbAKgdb0yIjP
	 elbq3tcw1eWvwqdJKQLWhZ1zhxZbrhpm0bsTPgHSuJ2Vb4qa3jkniH09dBT5UO5LbR1Nj
	 LkWhY2Cjs6Rld7EvWjWQSdfqvI1OI7488pT6DNpxvNICzmvMnXr+V+XG2WfQ0eti2Dh+F
	 PBCvHlP/Jm4IEyOHLkn/AZcuLPoEO5Ov8WE2d5aZGfLTjRk3kEAW1B9ET3Ew2yhLpZQga
	 0PZkwm/r08jW+uFC8LNuwoaab7G7S+PjVGJhkOFyEQzMoCEld9jFtDE0PuFQOdjRPtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V+S4epV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DD606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+S4epV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731F71F00A05;
	Wed, 11 Nov 2026 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439867;
	bh=k+1O9jPeELVKycW88hpFgQtUmLFKkI8Ct3uwvEaLDCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+S4epV/FRUEMrFql1rt7W1/h5eYa7kvDD40nEcY105JloUbjP1RIMqYMYggURstf
	 rCvmGln5hnnVsoBC+1+dKvIbfkV9Ik7c9/wHpQLnxbkWnS/NMlzfporptjCMO+JHzm
	 +ifxGK8wxEaXU8TaIj+9rGqohUintkTXY2DYO5joD2X7mC5tvw290HEVd04jxI0pQI
	 GmQpajZEGvQW7Y72muOa5hOV29GyPqeA1f2X8FqOU68jAL7gp2k1hRfwaOGUUljlf5
	 XBudyYpmdjw1kIntB8eC3h0DfseMMDp3hT4kbNlcW8hxKKLRiS27RG/7vXEzuoai3W
	 Cwajudf4U7ceQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <albinwyang@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()
Date: Wed, 11 Nov 2026 18:31:05 -0500
Message-ID: <20261111233039.627729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062828-failed-5.10-f5cfc8e3b20a@kernel.org>
References: <20261107062828-failed-5.10-f5cfc8e3b20a@kernel.org>
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

From: Wei Yang <albinwyang@tencent.com>

[ Upstream commit f5cfc8e3b20ad71949a1e5623ff45882c063a71b ]

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
[ sashal: adjusted context for reclaim_pages() using page_list instead of folio_list ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8b6ed35c1d265..e98256595fdd0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -383,6 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		spin_unlock(ptl);
 		if (pageout)
 			reclaim_pages(&page_list);
+		cond_resched();
 		return 0;
 	}
 
-- 
2.53.0


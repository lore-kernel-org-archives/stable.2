Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439461;
	b=FyApaeYWqicUutx8jVLxITTo6SbdAYijoFPBSctwpz2tCaQv5KXhvK0YD1PIQ0kb80Xl
	 6QNNkZaOuD3sLzy9phw5igZJxFp6DU5umUYtOdKsInc+joPd+QVZLAZ7Gvw5W6tYPQOpH
	 cO+sly3NO2GjixFHnr2CV9GnYrvJ4YLs3c6jtMBPOXCTd9fZuxU0GzfKJhnCddTSnqXx8
	 upDkRV5iD34SOG916gh/ef12pV7G06dBpcNiXTiRSZGDg5RpMz5pHZ7e5LqEStWz3923Y
	 MPRuCH1CP0G0+2eNoOO7zgUuP6dmXIHRMvKR/Ggy+6kaq1TIF9r1WMx7CIGYv0v4UHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4NB1N9SBrZSq6FdH11+V5mDiYB1ugRNBVW4MjRCA8l8=;
	b=k9Ub3Pt0ikoO5CdTLzW1NfEPitzC/62bJQR3WrE6dSw6SmyhmcQUnlzqjGT8VpfbIA5G
	 8Rwy484NokyGSzCSz7hU44KZAKHDm4kzu/Y3b7s/Jm9qORx+YLqVRyKT2c/wZ+CsJ3yyR
	 Gxea7Px3oIGSL4mZWRseK8YVJnrTYfcVf24qxqz4M7D17g0oiJfxDsAG+rWkMVXFwSVQn
	 6Il4EW6ogJKMAMTUYPNmGKcu21oFTjchb/rf1gB7EWMdK+N1lAF1KV/X07+c29W4zf5OW
	 NA9R5qttcvXPK2G4X9z5DTQwv6ZezddHF+I2X2wr1pQESMWcKvKq6cJi1xXZZnPMZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYyMBkoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49530606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYyMBkoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43111F00A05;
	Wed, 11 Nov 2026 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439460;
	bh=4NB1N9SBrZSq6FdH11+V5mDiYB1ugRNBVW4MjRCA8l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYyMBkoMVX588MFNDEZwN+1Xce5oDjG7u9xpTQOfrMZwCHmmzz25AAijdlSDZNVDY
	 EcIwKUhWWQ/4jNKr3BY0Uls16EanBBXjDXDaNDKggHC8LxkwmdIO+1hfKK3sS5G+Nc
	 OQhgB7fa+iBPiGdLr9QgCy3Orkjz/pAe2ZvUnr/V3JV8NLF0uQSbQkkDCLWjAg3yQ8
	 WQzVFjo+5AQSFzJ8ag2sYMYoVbQgaV54R3tYJGELOts2QXdcAcrmMv1WfID8HACmHS
	 Q1DJzDZ6Me6W1i1PW+3RsOar3BVhlmZpkbD2Mgszpe2c0MXdU/aG7EgdIetlIpPAZ4
	 FjB/Nf1kbK2RQ==
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
Subject: [PATCH 6.1.y] mm/madvise: add cond_resched() in THP branch of madvise_cold_or_pageout_pte_range()
Date: Wed, 11 Nov 2026 18:24:18 -0500
Message-ID: <20261111232356.485300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055415-failed-6.1-f5cfc8e3b20a@kernel.org>
References: <20261107055415-failed-6.1-f5cfc8e3b20a@kernel.org>
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
[ sashal: Adjusted patch context to retain page_list where upstream uses folio_list. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index b271cc1b48edb..447b2ae438fe9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -401,6 +401,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		spin_unlock(ptl);
 		if (pageout)
 			reclaim_pages(&page_list);
+		cond_resched();
 		return 0;
 	}
 
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077833D994
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785803856; cv=none; b=gI7HD5f+B2dSA0ITYAKmjWdrxAiG0IzTKxFPL3mHO+e0QE8+1b/SL5KD0/WDiDWM2cgo8FlDBziEniUZpd4hcEN7Ufva5BX3zfomGIeiL5lxa5rs7/MkZTltYcEu0cpYtQFsUe860EE7nWNmNJcx7SP++sQdmjtCJfgUZfQlwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785803856; c=relaxed/simple;
	bh=b8RVIt7lQdUaJae+RcGuITsWUZOF2lSJoHD7Fu4dImo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thxgD42JnfT3fV/PVQZy6DciAMAeJyGwWbOqWb+P3MItP7+IXgMqplS9ucwFHVv5Lu1IPiCIs+NkZCSZsjLwH9+95JxfWfBnd/ylErQ9XSSMstOafab1AQiQMKFcU0q3i+jFiDbY6ymqxbTyaA/07GN/Fr89/UW3ZD6vMQqjADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbDL8vOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbDL8vOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC981F000E9;
	Tue,  4 Aug 2026 00:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785803854;
	bh=W9DygNyHW+E1VUj2JEzj3GqHGlULW7/nccPrZjgZMO0=;
	h=From:To:Cc:Subject:Date;
	b=GbDL8vOf3FtW0krOJtwvRUdJj00bVX4UPXzOsLf9u6y9J14kK8XTFR80E2XLKgSRl
	 IBRZ+jSj+s15+nni9G58BlRT2xUfRPJROpqkS2gkMOsboChxiNEBB1Oh1z7/odKuD+
	 O9Ed9Yo4Nsy41UpI0IoC0oIveGEKRbsQgCeT+LDsg3krjl4sfq63hO8oJH/yW0JFyy
	 jjmQxdzN+oBadG2o3fpDgoa6CspsxhLH67diEvw2S9Rhu8KWCA2H+4TBqRD+1BazX7
	 qCACpxgDDfZMMn2FI3XLBXB/b+IJ3o4839nBKPLtiY0+BUjRh78yTPbo/a17+I1CZs
	 yR06vRXtPoHxQ==
From: luto@kernel.org
To: linux-mm@kvack.org
Cc: luto@amacapital.net,
	Andy Lutomirski <luto@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH] Fix incorrect flush address in direct page table reclaim
Date: Mon,  3 Aug 2026 17:37:08 -0700
Message-ID: <20260804003708.49830-1-luto@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Lutomirski <luto@kernel.org>

When zap_pte_range reclaims a page table, it does:

    pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);

and this is unconditionally wrong: if this code executes, addr *always*
points one past the end of the range covered by the table.  The addr
parameter is used to flush the TLB (really the paging-structure-cache)
to drop references to the to-be-freed table, and any architecture that
cares about the parameter will flush the wrong address.  (But they'll
still free the correct page).

I think it's worth contemplating why the kernel works at all.

If we hit the offending line of code, we will first clear the PMD entry
(line 1954, zap_empty_pte_table), then we will issue pending flushes if
force_flush is set (tlb_flush_mmu_tlbonly(tlb)), then we will skip the
retry on line 1979 (phew!), and then we will do the offending
pte_free_tlb call.  *Or* we will clear the PMD entry immediately before
pte_free_tlb (line 1983, zap_pte_table_if_empty).

If we have any pending flushes (i.e. we actually zapped any last-level
entries) at the time we clear the PMD entry, then the flush really ought
to flush all references to the table (Linus certainly seems to think it
will on all architectures [0]).

The condition under which we have no accumulated flushes at the time of
the clear is very complex (the whole zap_pte_range function has absurdly
complex control flow).  If we do hit the bad case, then we will end up
clearing the PMD entry after the last time the range is flushed, and any
CPU is free to cache a reference to the (empty) page table.  If this
happens due to an ordinary read or write, it would segfault, so it would
be rare.  But the cache could be speculatively filled as well.  Then
we'll flush the wrong address and then free and possibly reuse the
table.

On x86, even flushing the wrong address works on non-KPTI Intel systems
because INVLPG flushes *all* paging-structure-caches, not just the ones
for the target address.  But INVPCID does not, and flush_tlb_one_user
will use INVPCID if it's available.  And then we're toast.  AMD systems
are more susceptible: we set the EFER.TCE bit, which makes even INVLPG
only flush the target address.

P.S. IMO zap_pte_range is a mess.  The control flow is excessively
complex.  The direct_reclaim variable itself has a confused meaning --
for the first part of the function it means, approximately, "we should
free the table if can_reclaim_pt".  But, later on, it means "we ALREADY
reclaimed the table".  And the goto retry on line 1979 is IMO just
asking for trouble if the condition ever changes such that it might
happen after clearing the PMD.

I think this might fix an issue in ripgrep reported here:
https://github.com/BurntSushi/ripgrep/issues/3494

[0] https://lore.kernel.org/all/CA+55aFzBggoXtNXQeng5d_mRoDnaMBE5Y+URs+PHR67nUpMtaw@mail.gmail.com/T/#u

Fixes: 4c640eb4181c ("mm: move pte table reclaim code to memory.c")
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 86a973119bd4..13b70861c8a3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1981,7 +1981,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 	if (can_reclaim_pt) {
 		if (direct_reclaim || zap_pte_table_if_empty(mm, pmd, start, &pmdval)) {
-			pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
+			pte_free_tlb(tlb, pmd_pgtable(pmdval), start);
 			mm_dec_nr_ptes(mm);
 		}
 	}
-- 


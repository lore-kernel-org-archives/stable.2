Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A327603F;
	Sun, 18 Oct 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288254; cv=none; b=L6kCBX6r/JFI62qvvN6r4QiLa/RyElx/WbtzxeEsH5VjWGsiNCvocBgAIQCZu9D1uKM/J2xR23KBFQEVrpTAPZ9b4yJQOhqOs/cSjgATad3wXXGr69ayMfSzAeDYK9ZOfY1d+KuATCiV05da4gV2obo/rhFvWicU3fvo0U5h9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288254; c=relaxed/simple;
	bh=OJIJLF91CANG65mkI7qgb235ZC6+G4eslkxuklyWzcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHPivOljkL/6gXWeHMoJ8JDrLwooX6a9pAFAmCu/Ci5o1iIrcbNCYJH2YPjpdFKJOm1hLkmVnDxRuxMvmgxGU9VV8WyjRHL5tIgUOqA1t6KrGOGmLF1FAJ3IC2c7NcxCCe+eBp2Aaji7SjvagsrirCywxZNsQ5YlB2rnuHRzKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xIG2u-004Ekp-RQ;
	Sat, 17 Oct 2026 21:50:44 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2] mm/mremap: do not charge a shrinking move twice
Date: Sat, 17 Oct 2026 21:50:44 -0400
Message-ID: <20261018015044.798412-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017180412.a79a36e873c5268df126cde1@linux-foundation.org>
References: <20261017180412.a79a36e873c5268df126cde1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v6.15 every mremap() that shrinks an accounted mapping and moves
it with MREMAP_MAYMOVE | MREMAP_FIXED leaves old_len - new_len bytes
charged to vm_committed_as for good; the charge outlives the process.
An unprivileged process that repeats such a call keeps raising
Committed_AS in /proc/meminfo.  With vm.overcommit_memory=2 it reaches
CommitLimit, after which every accounted allocation in the system
(private writable mmap(), brk(), fork()) fails with ENOMEM until other
processes release enough committed memory; the leaked charge itself is
never released.  A loop of 1000 calls moving a 2 MiB private anonymous
mapping to a 1 MiB fixed destination raises Committed_AS by 1 GiB.

mremap_to() first unmaps the tail of the source with shrink_vma(),
which uncharges it, and then sets old_len to new_len so that the move
looks like a same-size one.  vrm->delta, the absolute difference of the
two lengths computed in do_mremap(), is not updated, and
vrm_calc_charge() charges delta pages for the move.  For an ordinary
move, which unmaps the source, only an increase in mapping size
requires additional commit accounting.  Here shrink_vma() has already
unmapped and uncharged the tail, so the remaining same-size move
requires no additional charge.  Before the refactor move_vma() charged
new_len - old_len with the updated old_len.

Recompute delta after the shrink.  vrm_set_delta() now also runs after
old_len has been adjusted, so its comment no longer calls the
difference user-specified.

Tested under QEMU (x86_64 defconfig) with a program that repeats the
call 1000 times: Committed_AS grows by 1 GiB per run without this
patch and stays flat with it.

Fixes: d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Changes in v2, after Andrew Morton's review:
    - The sentence on which move needs a charge had it backwards; an
      ordinary move unmaps the source and is charged only for growth,
      MREMAP_DONTUNMAP keeps the source and is charged the whole new
      length.  Reworded as suggested.
    - The ENOMEM state lasts until other processes release committed
      memory, not until reboot; only the leaked charge is permanent.
    - Comment on vrm_set_delta() updated, since it now also runs after
      old_len has been adjusted.
    - Fixes: now d5c8aec0542e, the commit that replaced the new_len - old_len
      charge in move_vma() with vrm->delta; b714ccb02a76 only reorganised
      that code.  The reproducer leaks on d5c8aec0542e and not on its parent.
    
    v1: https://lore.kernel.org/all/20261017233527.797191-1-nickolai@csail.mit.edu/

 mm/mremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 444f37d7cd28..479befed1b2a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -887,7 +887,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 	return pmc_progress(pmc);
 }
 
-/* Set vrm->delta to the difference in VMA size specified by user. */
+/* Set vrm->delta to the absolute difference between old_len and new_len. */
 static void vrm_set_delta(struct vma_remap_struct *vrm)
 {
 	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
@@ -1523,6 +1523,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 
 		/* Set up for the move now shrink has been executed. */
 		vrm->old_len = vrm->new_len;
+		vrm_set_delta(vrm);
 	}
 
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.53.0


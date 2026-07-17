Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5213EC68B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304674; cv=none; b=dvKypLxWg52RVVwKJG72zvQ+51NI5+opVmhUBzHlpd7oYEY6FXOj7NjrhYR7PTwkavA6OU95bNQI5MmTtzfyUh441U5TWDZM6XOKsKZEIDSkMkF/G/+uCeXXB25nPbYSfqlfPyagaF9aElUTgWdV2RqSAE09n2jgfOBcKGUEbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304674; c=relaxed/simple;
	bh=8XmzPHHLac1BAEO/8BCt+dGNeXUdTN+Iy3oomvKGrdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzXWOU8rgRj6r7kt7nwgMLmB96DkdxdO8pjy9pDle5ySJ9YF2hSflJjHJ/yirSsHgUBMTnxLY5dQdIi+XtWbkoywM/FtbZ9NIDDgK2kyl2kP218xsQJDboqUQBqlscmScMapyJ4hKJhk4g83nO3SALljXQ5UTaiybYh6d/9ixHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=bQNdminc; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="bQNdminc"
From: Eric Hagberg <ehagberg@janestreet.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 	sashal@kernel.org,
 	dave.hansen@intel.com,
 	dave.hansen@linux.intel.com,
 	peterz@infradead.org,
 	luto@kernel.org,
 	x86@kernel.org,
 	linux-kernel@vger.kernel.org,
 	sforshee@kernel.org,
 	gthelen@google.com,
 	ehagberg@janestreet.com,
 	nbarnes@janestreet.com,
 	Stephen Dolan <sdolan@janestreet.com>
Subject: [PATCH 6.1.y 6.6.y 6.12.y] x86/mm: Fix check/use ordering in switch_mm_irqs_off()
Date: Fri, 17 Jul 2026 12:04:30 -0400
Message-ID: <20260717160430.2857897-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1784304314;
  bh=+qFxQR3RFaq/ALtLCKtXkSDMyDLzKDdocHVaibS4brk=;
  h=From:To:Cc:Subject:Date;
  b=bQNdmincD6T6MolgO8Y2ISOmyesP8PTk/v0903nWGBu2ckNRTj7mx36Lpj5i1/+u3
  woFPP6hoedOjhf5g6WWFEEdm903HvwQoweadvgGn9uv20R5Nh3MIVUsH3I/OzEBVHu
  L43RdCDBH9a92BcHB9kEGOvOc6hsv/ViLe+A6eIEL2Ko9V2oqjt3xzAoJJhjU7EpzY
  k4lQy2TRgGUyicFStOi/VVbZnEFuB2zXXduRvoUpvXM4g0BFF989yMQNwNgSy1iFZO
  ao79f0nV0BOh74Xrr2aCSoOSgBhCy4nhsL0cjaiihRAx89ULdOp/JMldTI12U5Qy8W
  LeYoYCT5RKGUw==

This is a stable-specific fix. There is no single upstream commit to
cherry-pick; the equivalent mainline fix is commit 83b0177a6c48
("x86/mm: Fix SMP ordering in switch_mm_irqs_off()"), which is in
v6.18 but does not apply to these trees because the surrounding code
was refactored.

The backports of commit fea4e317f9e7 ("x86/mm: Eliminate window where
TLB flushes may be inadvertently skipped") -- the fix for
CVE-2025-37964 -- to the 6.1, 6.6 and 6.12 trees ended up with two
code blocks in the wrong order relative to mainline. The fix depends
on setting cpu_tlbstate.loaded_mm to LOADED_MM_SWITCHING *before*
reading tlb_gen, so that a concurrent TLB shootdown either sees
LOADED_MM_SWITCHING and sends the IPI, or the switching CPU sees the
updated tlb_gen. In the stable trees the write of LOADED_MM_SWITCHING
was placed after the tlb_gen read, so the race window fea4e317f9e7 was
meant to close is still open and CVE-2025-37964 is unfixed there:
a process can be left running with stale TLB entries, which typically
manifests as rare, hard-to-bisect memory corruption or segfaults.

This has been confirmed by several independent parties:

  - reproduced on 6.1.y/6.6.y/6.12.y with the test program in [1],
    and confirmed fixed by this patch
  - Seth Forshee saw segfaults on 6.12.y within ~30 minutes of running
    a test workload; with this patch it ran 18 hours cleanly [2]
  - Greg Thelen reports 6.6.y- and 6.12.y-based test failures fixed by
    this patch [3]

Dave Hansen acked the patch [4] and has no objection to it going into
stable [5].

The patch below is against 6.12.y; the identical change applies to
6.1.y and 6.6.y. (The cpumask_test_cpu()/smp_mb() portion of the
mainline fix is not needed here because commit 209954cbc7d0
("x86/mm/tlb: Update mm_cpumask lazily") was never backported to these
trees.)

[1] https://lore.kernel.org/lkml/CAHDw0oGd0B4=uuv8NGqbUQ_ZVmSheU2bN70e4QhFXWvuAZdt2w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/aZYWXe739XUJrBld@do-x1carbon/
[3] https://lore.kernel.org/lkml/CAHH2K0brx9omC9QYyB6Lio3t_1Lf8v=VaFoiaG23UgQ-aec89Q@mail.gmail.com/
[4] https://lore.kernel.org/lkml/281e8018-5506-4a79-8775-e0de7e58b95f@intel.com/
[5] https://lore.kernel.org/lkml/86421ee5-5332-46c2-bb48-d40310b818be@intel.com/

Fixes: fea4e317f9e7 ("x86/mm: Eliminate window where TLB flushes may be inadvertently skipped")  # 6.1.y/6.6.y/6.12.y backports
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Seth Forshee <sforshee@kernel.org>
Tested-by: Eric Hagberg <ehagberg@janestreet.com>
Signed-off-by: Stephen Dolan <sdolan@janestreet.com>
---
 arch/x86/mm/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8629d90fdcd9..e87ef47cfb09 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -606,6 +606,14 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 */
 		cond_mitigation(tsk);
 
+		/*
+		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
+		 * and others are sensitive to the window where mm_cpumask(),
+		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		/*
 		 * Stop remote flushes for the previous mm.
 		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
@@ -623,14 +631,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-		/*
-		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
-		 * and others are sensitive to the window where mm_cpumask(),
-		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
-		 */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 	}
 
 	new_lam = mm_lam_cr3_mask(next);


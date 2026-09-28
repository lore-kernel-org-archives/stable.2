Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A64DEC1F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606546; cv=none; b=s8HKYvnKhzao6No+TMYv3heFRAOe7M9Grjjje0vHhycjpuSUP0J15MEI2rzSIVP9WckX/J4QLlZo1ET5uG8x30PvQSE5IiHCXxq02kZj5Og36suqYA/M9j2f7uMvpK6ycR3ALdB8g/s05JNycJbD9GfUstIdpqpvOC1qpC3Tgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606546; c=relaxed/simple;
	bh=ZC7P9layHKwxTaZQrf8DeEUaUxIpEdi/Fjb4t9SoPIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spnfCW09lpSQj+f6ZCJwmNXm1hVs3SUlvIsPui2Ab6mA/+NhunSF+NJbWyV4yDkGiT6TzeTvzFQsRVeACtHCxIesn4u9bSB8Ncby1/Zo8/lmleOm+qUO16TanDU/s7bA47PIF1qjbnRvQ9TpObvQTqdxatkfBYpQmE0KE/ZudkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsaiDo6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsaiDo6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C136E1F000FF;
	Mon, 28 Sep 2026 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606541;
	bh=1ynFbGdpiKPW/M+THl5bA0HB8Uf0jOanIeZdS7URUok=;
	h=From:To:Cc:Subject:Date;
	b=PsaiDo6p0zqAGO89q5LUGKpGSHq79YtrlbIhE4TMM/FOiErl+jyB5bKoYAcSmPKiI
	 KnJTg4wnTUc6/ZjeKlQ7SpkZETyPSVTNbkPpmx+y+RZQfM/y78hY4t0MXmLXk9lKgI
	 756IrKCym79o2aHPAEjg6gXOU6feIzEfgIGsgH6BfnZRaHwcg5wCEFvH3ecbP6t/m4
	 AMENkyvuZQCpowJ8Pk+kDVf5VlPpzhKMhCRjUgnUrvKU+7XgYTQFIWxnuLpPH5Ce45
	 S2xDnX035rkNmU2T+CJZHobozIN0O4lGX12ITSs/8D5H1PXmVu4kYwTAfRzjHhTJ19
	 FskD5zaQv6lDw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	sdolan@janestreet.com,
	dave.hansen@intel.com,
	sashal@kernel.org,
	x86@kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: [STABLE v5.15] x86/mm: Fix check/use ordering in switch_mm_irqs_off()
Date: Mon, 28 Sep 2026 14:42:05 +0000
Message-ID: <20260928144205.3881537-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Dolan <sdolan@janestreet.com>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Lee: The v5.15.y backport of fea4e317f9e7 (12f703811af0) placed the
      LOADED_MM_SWITCHING write after the tlb_gen read too, so v5.15.y
      suffers from the same issue.  Applies cleanly]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 arch/x86/mm/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 11a43d373bae..f6e541c24ae2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -596,6 +596,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
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
@@ -615,14 +623,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-		/*
-		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
-		 * and others are sensitive to the window where mm_cpumask(),
-		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
- 		 */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 	}
 
 	if (need_flush) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


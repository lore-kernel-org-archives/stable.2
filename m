Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26339CD0E
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154979; cv=none; b=Mif+8XczHPmD+ZAfJuNwAuNJrXmmgWvSyohcgc7MyPcRRXfokgw0KuyzR5WMcqJ86V4yzTz5vHXoXSCnpiCEs1bFdgygWer4NGG9P0R4Q1+WTbkz3xfmY4202rVJkLJaIDNzj25pgAeXbLiK97c7R0Pf/J5Pn/fRp/IzqJZKRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154979; c=relaxed/simple;
	bh=Op/XItXxXOAr/NkxxBOxih26AjZkhlDofAzSF9G6YbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+CEW7+6kfZuM5K6GHaPyr2VccQ5oT0JAoi4aN2jAPwSFNDP+vvBzN5GFkWQ3HWRgmwznlS6L58uFXGQVKwOt/TZ2Uf+rFkmKCkVQlRx1qY5FSqWtJjoPBBpizwWQpvnMPBuXc4pXlOBKkaxpve0aNERIEYVGElHqGq3qlqhSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxcGGzQV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxcGGzQV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436668d20so557980f8f.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788154975; x=1788759775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8abeE7yuo9J9DmBCNkbVrY67aO7PUOd2dMVcC0+Ats=;
        b=JxcGGzQV2lYzX4MWfIHSNq5yO2suK+UtR5PzirGp9VSiqOtv54nuptzDjQN33dJTim
         gSPufnmmAUo18VkoJffw8IaQgvgchASM2Hmc+ynsVZzEkG+3ilDtNPL2dft9tkW2kYOd
         2BLnEeJH09aUAlFUmz34bUJi9taGcGRYk4AbxH7kE6EYK12cfVAmiG2coPHhMaPNO9IW
         pBOkXFycdpYG2zibnQz6q27YEbUIbtvKakY8ag9lGZdehMdIy4GZ89U4phDlGOLZ2RX9
         MVZAVrRe0J1p6GW9TYDYwilCM58P3BOMOI++wWtuyWHdOL+v9gRB8YCyWZ3O0aG7Zx7A
         9Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154975; x=1788759775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8abeE7yuo9J9DmBCNkbVrY67aO7PUOd2dMVcC0+Ats=;
        b=hpf0nYC8yWLCWe5mjIfB4nBdF5a7/4NRJtm31JKPGm3qD/FOL24AgzdbVlLAK5K7T9
         B8QoM1znA0C3eGGwwjDowE1cawdMJLET+NVRbEF3jI4LUxK2vtN0JxgdZtOJ2Oq1JzJA
         yX0eh5IXQbvu1TodsrIdBQeyh6kEhfcgGByaW7oVG9xwfPCBkdl8RlNsTSuuT4pReyFh
         HyPIprMakKRWsvIxZ4nQZcrDdIeOCtxPcVhrjC34fADUR7McUzgbe/8m4vD47tASlWYF
         +GEhvYEoUGf8e81SvePqit3oUeNIRU0Kc4lhBKEyuBUZ0x+jRG+6X4qXkZicsS8X+Bol
         kS5A==
X-Gm-Message-State: AFuF++k5HscXcIBVUNLzfvv8/mSs4FeHUxdF6nnYesuMUIoltDq1gsbC
	FCNOJa6YBYl/EyHK3N4MFTMnmfznTZRB08ImoUB5etnOHrFasXPW4xea8XTaMm9c
X-Gm-Gg: AYBFou3QGfgja4aVRPnvqybJg+5zALf6Yxbwngc9PIdAiUJlpOrqNxRLcWW1miInc/x
	gkyt45RaVs0qL05Ry/2EpP9uNN23WJOgudbJrDXyGmRtyGpCvUUOq+wdvN0aWfcK+eS7p+CRHer
	KN0VyeUeTne1jJjU9jIwahKaj1vJqPgDVP4/PBnuHyVMgBDbXWeoBeGvkqPcAfcRiGZbnzXfK1n
	1G1mk82r5i/CxEyFgi1kaplXKYPGAT3L9ETsPT0JtxQIjMVYPig0OIyLij4q0EaRnbiNfSs632W
	bt/iF1RcJqX2WwXxXhd43p1zSOBsb4GMmbMCpyx+O2XihHMAhYy6If4gciTHRLFIEBVVqth3PiH
	/yAgyJRHEwCDfxwkeCBEaQtdpskfaGRTlUKRKp59x5n1k7cQc6UzECa0yxlNxGALAV0LymRzdwH
	mgIHP2OApKcBfkmzoLHOLv0lYOWfwcrCGZKz4OAPPa+NIMR+CtCQUBoiZq0FxUZthOx5F30Nw0q
	TxI3zmO4igWVm7WZl0V4+u+YPrAfjlWCycPpd3zIUoCQMH2dMpr6HgihqNqJmfBKlFBBu+igex4
	/pq07hsVEkIbEiQNO0jtGjmgAyIdFAit71nvLA/Tf7DFSomJablC50fIrjPmkJLhag==
X-Received: by 2002:a05:6000:38f:b0:484:3317:a1a with SMTP id ffacd0b85a97d-48433170bb5mr22283097f8f.27.1788154975401;
        Sun, 30 Aug 2026 22:42:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb284cbsm20138400f8f.30.2026.08.30.22.42.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 22:42:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 6.6.y] arm64: mm: clear extra idmap level before use
Date: Mon, 31 Aug 2026 07:42:47 +0200
Message-Id: <20260831054247.33352-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.6.y adaptation of commit 0e9df1c905d8 ("arm64: mm: Don't remap
pgtables for allocate vs populate") removes the clearing performed by
early_pgtable_alloc().  Its replacement clears allocations made by the
generic page-table walkers, but 6.6's create_idmap() still allocates an
extra root level directly when a sub-48-bit VA kernel is loaded
sufficiently high in physical memory.

memblock_phys_alloc_range() does not zero the returned memory.  The direct
caller therefore publishes an uncleared root page and passes it to
__create_pgd_mapping().  A stale nonzero entry can trip the bad-descriptor
BUG_ON or be followed as a page-table descriptor, preventing the kernel
from booting.

Clear the direct allocation through its linear alias before publishing it.
init_clear_pgtable() also supplies the barrier required before the table
descriptor becomes visible.

Mainline is not affected because commit e6128a8e523c ("arm64: mm: Use
48-bit virtual addressing for the permanent ID map") removed the dynamic
extra level before page-table initialization moved out of the allocator.

Fixes: 54322d95309d ("arm64: mm: Don't remap pgtables for allocate vs populate")
---
A deterministic QEMU A/B used 16 KiB pages, a 36-bit VA, a 48-bit PA, an
Image loaded at 0x1000200000, and test-only instrumentation that filled the
extra root with 0x02.  The affected kernel hit the expected bad-descriptor
BUG_ON.  With this patch, the same poisoned allocation survived
create_idmap() before the test stopped deliberately.

The injected contents make the allocator's permitted nonzero return
deterministic; they do not estimate real-world incidence.

Tested on:
  6.6.y a4a971135a2ff64382ae4235b3ae60503bb1036a (Linux 6.6.155)

 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e075792d722575d38488e8352df8947c6aaddd2b..4e9e997e08daf543e5c09799563f991a9f8a7cc0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -777,9 +777,10 @@ static void __init create_idmap(void)
 	/* check if we need an additional level of translation */
 	if (VA_BITS < 48 && idmap_t0sz < (64 - VA_BITS_MIN)) {
 		pgd_phys = early_pgtable_alloc(PAGE_SHIFT);
+		pgd = __va(pgd_phys);
+		init_clear_pgtable(pgd);
 		set_pgd(&idmap_pg_dir[start >> VA_BITS],
 			__pgd(pgd_phys | P4D_TYPE_TABLE));
-		pgd = __va(pgd_phys);
 	}
 	__create_pgd_mapping(pgd, start, start, size, PAGE_KERNEL_ROX,
 			     early_pgtable_alloc, 0);
-- 
2.39.5 (Apple Git-154)

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588532;
	b=L1vg/GauVkkNzV8QmeRF+aYHKNkmfRdO0/pPLo2D4FJQJrbw3GOUd+2LXCsZ4aegFf/v
	 PKlbrf7gijSFwXvWfFfvszOlMXcpIw55MyxdmulXGWLVfF43CAWVu8FGBD3F/elkDFqqk
	 uS629xEYHZHMxqe/HsWgQ7OHiLKQ5+hAj18zxLQgRpKwzISFEyg+BuEGaqhcwofPM63od
	 ZE02/huRVa0MC6abguqpK31iXg2tt31V+nb/ub3YYj2sGflc5XH37Eo0q2GjzBxVyGe2r
	 ovfgE+Il4U7fKLsKhoQ3bPvd2Kydq+LH8RnotSC6aQrR5dnYhnmepVUJZkaXnrkwWfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588532;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I6+kzu5wlP2gNqaFOLzY8J/HA+tCbkwiTb+BR4uUO2I=;
	b=fkrm9+7eLaKpGCsw4qJaapEl6PTzsslS6DGBlozdXlWDu+L3hsZ0piuCCMc9UwhG4rPL
	 viTTfAMW2S/LWm5kWYt60m4sH3DKWZrxtQw1lEBDzIAru+lsomdBvqUcwAHZqIoIhfZcJ
	 Mk3cqOF12uDS/3hevq5w5dFdUD/9dfgO+GFUqW/s8nrf7j0YPd1T2VjTFy1tm4p89oY6B
	 zJ2KVfgzJ0DIGPp0FvoaKqbccC8sLczRLx67oeZw8vXbt2+s8bOQT6SFnv+n2Luk7ShH9
	 DrTfvqpySzmYYnaMAZaHvMoSR7Y7tjex/hhigDAz8z77yLE3auu7MkbjAtWVUOofmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iHqOCSvg;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB9606A321;
	Wed, 25 Nov 2026 06:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iHqOCSvg
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795588528; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=I6+kzu5wlP2gNqaFOLzY8J/HA+tCbkwiTb+BR4uUO2I=;
	b=iHqOCSvgZIBUMTOo4cuC2CMO0SJJgwLdRYTUDv+Z3R4iaWFdl8DKIRySpKtBj61MxHggj4jM+gCmf0t0R3ADv2+hlfv8jwo9rPzdoiZokTgGKAY9If/BYcAXQ9jE1lS0/ziacUizleZzO1hRqAsGcwH8Q/h2Cs+bkKJKwsMOpmM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XFQjoFf_1795588525;
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0XFQjoFf_1795588525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:35:27 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	ying.huang@linux.alibaba.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	robh@kernel.org,
	gregkh@linuxfoundation.org,
	ptg-linux-kernel@linux.alibaba.com,
	yadong.qi@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Wed, 25 Nov 2026 14:32:24 +0800
Message-Id: <20261125063224.553-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
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

__set_fixmap() installs a new PTE with __set_pte() but never invalidates
the TLB; only the clear path calls flush_tlb_kernel_range(). The
dsb(ishst)/isb that __set_pte() emits makes the new PTE visible to the
table walker but does not invalidate stale TLB entries. Overwriting a
still-valid slot therefore leaves the old translation cached and
violates break-before-make: accesses may keep hitting the old output
address, and changing the attributes of a cached entry can trigger TLB
conflict aborts or CONSTRAINED UNPREDICTABLE behaviour.

Two in-tree callers overwrite a valid FIX_EARLYCON_MEM_BASE slot:

 - earlycon: earlycon_map() maps the UART before match->setup() runs.
   If setup fails, con->write is unset, or the DT reg-io-width is
   unsupported, the slot stays valid but no console is registered. The
   console_is_registered() guard only blocks successful registrations,
   so a later attempt (e.g. a failed DT earlycon followed by earlycon=
   on the command line) remaps the slot to a different UART.

 - samsung_tty: apple_s5l_early_console_setup() overrides the
   just-installed entry from PROT_DEVICE_nGnRE (FIXMAP_PAGE_IO) to
   PROT_DEVICE_nGnRnE on the normal successful boot path.

Both are valid-to-valid changes (different output address or memory
type), which arm64 requires to be break-before-make.

Fix this in __set_fixmap() by invalidating any existing valid mapping
up front: clear the old PTE and flush the TLB, then install the new PTE
only when setting. The old translation is gone before the new one is
created, so the two can never coexist in the TLB. A first-time mapping
(old entry invalid) skips the invalidation and pays no extra cost, and
clearing a slot is handled by the same step.

A clear (!flags) always clears and flushes, even when the PTE is already
invalid. An invalid PTE does not imply an invalid TLB: another CPU may
have cleared the PTE but not yet completed its TLB flush, leaving a stale
entry cached locally. The unconditional flush preserves clear_fixmap()'s
TLB shootdown guarantee, which callers such as the KVM VNCR unmap path
rely on when racing with a remote invalidation.

This belongs in the callee, as on x86: __set_fixmap() there calls
set_pte_vaddr(), which flushes the TLB unconditionally after writing the
PTE. x86 can flush after the write because it has no break-before-make
requirement; arm64 must invalidate and flush before installing the new
valid entry to avoid TLB conflict aborts.

Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
Cc: stable@vger.kernel.org
Reported-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
---
v2:
- Rebase to arm64 for-next/fixes
- Fix comments from sashiko: always clear and flush on the clear path
  (!flags), even when the PTE is already invalid.
---
 arch/arm64/mm/fixmap.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index 951004ad700c..5da49e201b6f 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -126,13 +126,49 @@ void __set_fixmap(enum fixed_addresses idx,
 
 	ptep = fixmap_pte(addr);
 
+	/*
+	 * Break-before-make: when the slot still holds a valid mapping
+	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
+	 * old entry and flush the TLB entries caching it before a new
+	 * mapping is installed, so old and new translations never coexist.
+	 *
+	 * A clear (!flags) always flushes even if the PTE is already invalid:
+	 * a remote CPU may have cleared the PTE but not yet completed its TLB
+	 * flush, leaving a stale entry cached locally. Take KVM VNCR unmap as
+	 * example:
+	 * When CPU1 wins atomic_xchg_relaxed(&vt->cpu, -1) in unmap_l1_vncr(),
+	 * CPU0 calls clear_fixmap() on its own slot so it cannot finish
+	 * vcpu_put() before the local TLB entry is invalidated:
+	 *      CPU0                                  CPU1
+	 *                                 invalidate_vncr()
+	 *                                 unmap_l1_vncr()
+	 *                                   atomic_xchg_relaxed(&vt->cpu, -1)
+	 *                                   clear_fixmap(vncr_fixmap(0))
+	 *                                     __pte_clear(..., ptep)
+	 *                                     <delayed before TLB flush>
+	 * kvm_vcpu_put_hw_mmu()
+	 * this_cpu_reset_vncr_fixmap()
+	 *   unmap_l1_vncr() == -1
+	 *   clear_fixmap(vncr_fixmap(0))
+	 *     !pte_valid(__ptep_get(ptep))
+	 *     <skips flush_tlb_kernel_range()>
+	 *                    <stale TLB entry still live on CPU0>
+	 * If another nested vCPU then schedules on CPU0 and calls
+	 * kvm_map_l1_vncr() before CPU1 finishes flush_tlb_kernel_range(),
+	 * __set_fixmap() also sees !pte_valid(__ptep_get(ptep)) and installs
+	 * the new PTE while the old translation is still cached in CPU0's TLB.
+	 * Unconditionally clearing and flushing when !pgprot_val(flags)
+	 * preserves clear_fixmap()'s TLB shootdown guarantee.
+	 */
+	if (pte_valid(__ptep_get(ptep)) || !pgprot_val(flags)) {
+		__pte_clear(&init_mm, addr, ptep);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	}
+
 	if (pgprot_val(flags)) {
 		/* The slot must be usable on return, even in lazy MMU mode. */
 		__set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 		emit_pte_barriers();
-	} else {
-		__pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
 }
 
-- 
2.43.0


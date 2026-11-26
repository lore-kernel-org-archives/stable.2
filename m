Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659768;
	b=cKS81ZNEPfrvc4J35GhhMEZ0GSZQL8RB2o1enIwgjOOJdznvdpk8pfvtGi9+h6VB8MIm
	 uIKFCWG/PBSJKbaMh0wtaMmx88on0DEwX+YNzc7RYUuMW9Sx9APNoMzdZkptqlTLuDE8/
	 c1PJiOKxwfswDhzIwjiWqtH3j/F94oIDVCh7DHqGhj98hBO8opRGMUkfHyScuL5c16l3y
	 KhsCTmFrKZf8x/FVPLZkV24W6h+oeBLvZz4p+amWLysyFeke2xYHAbbe6CvnHCWEwiK0p
	 ovHqXZObRqh5343eUK//vMN29WW6h6j2UiGoe7yoH6XbcBPnWyrkbk+4CaTg+i1STIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659768;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yyx3uSOohB+Fl4XAtSucbcMbOjZ0KFt5ODHENuzoZHY=;
	b=OYL0ci2zVQ7t5DDlG3+C5euf5yPmVHIQcGxS9p77PxKvPkEhl8RD5kIyYpVGezaswt/Y
	 0T0OmVPzbJjhZQTywZhzS+dsy8lEECjiwGtUU/SRAwQdbCs7wrRpOO0K1z37QcB1Df4PN
	 t7lCCLXtQohMuPQ0jQABZls+RfllLP48iqSp+bmIj6XDsTHCaDaXCryUXIok9LLQc54nH
	 8/xA3JzcvRUkLIkSqwbVHQ8QS/7iQfCZQufj7PHMkW8X7bcxgMxiFrpQ7DjjlExThpjyP
	 PIsjWeZMV1GzQ2s/NxJBMUTspxL5KtEWsC/j+LpNhhp9OwU0yZm92SX+w1pSeaOcyDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bVlg5bQt;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58184606A31E;
	Thu, 26 Nov 2026 02:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58184606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bVlg5bQt
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795659763; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yyx3uSOohB+Fl4XAtSucbcMbOjZ0KFt5ODHENuzoZHY=;
	b=bVlg5bQt8W6y/438ecggUpd7nhtDdg5IxfDI7vRYYtVcPuU+sPUvPLOGpThMRrWBNdrboIRqNhH9HbJJ3qsROCxTu8DbKA1OpMWQZLimfkeHkSvApx67+i0TxHll2e+EzLSzIHOqh+dnMpjPvfvhlzrA/DvFfMONm/+j/KLpXG4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XFT3lz9_1795659761;
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0XFT3lz9_1795659761 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 10:22:43 +0800
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
Subject: [PATCH v3] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Thu, 26 Nov 2026 10:22:27 +0800
Message-Id: <20261126022227.1618-1-yadong.qi@linux.alibaba.com>
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
entry cached locally. Take KVM arm64 VNCR unmap path as example:: in
this_cpu_reset_vncr_fixmap(), a CPU that loses the atomic_xchg_relaxed()
ownership race in unmap_l1_vncr() still calls clear_fixmap() on its own
slot. Gating that flush on pte_valid() would let vcpu_put() return while
the winner's TLB flush is still in flight, so a new vCPU could remap the
slot with the old translation still cached. The unconditional flush
preserves clear_fixmap()'s TLB shootdown guarantee.

This belongs in the callee, as on x86: __set_fixmap() there calls
set_pte_vaddr(), which flushes the TLB unconditionally after writing the
PTE. x86 can flush after the write because it has no break-before-make
requirement; arm64 must invalidate and flush before installing the new
valid entry to avoid TLB conflict aborts.

Fixes: bf4b558eba92 ("arm64: add early_ioremap support")
Cc: stable@vger.kernel.org
Reported-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
v3:
- Change the Fixes to bf4b558eba92 ("arm64: add early_ioremap support")
- Shorten the code comment to a few lines; the rationale stays in the
  commit log 
v2:
- Rebase to arm64 for-next/fixes
- Fix comments from sashiko: always clear and flush on the clear path
  (!flags), even when the PTE is already invalid.
---
 arch/arm64/mm/fixmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index 951004ad700c..c8a0d008cf2a 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -126,13 +126,20 @@ void __set_fixmap(enum fixed_addresses idx,
 
 	ptep = fixmap_pte(addr);
 
+	/*
+	 * Break-before-make if the slot holds a valid mapping. Always
+	 * flush on clear since another CPU may have cleared the pte
+	 * without completing its TLBI yet.
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


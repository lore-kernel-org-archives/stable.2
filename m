Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831139;
	b=aFryE7kz269xVxynBOA4bolxDVQ+/s9gmonlG76tmdPzAw7LFFBUc1ArNlAtNk1FnL1t
	 /EnvLcpGhqSP89YMgY7asufHwE6uTAHu5XhPp5dcA4WlcxvdxR492yVoXZjoUPwwK8rwp
	 AJuVBFhbr15sPy9Fm6ESGvpn8T6Cgh7ZoEmZ72hLPRdRnJc6rxZnJNtdwMAkyvqcQhQah
	 ShUQlR8PkE0LITsnGUb5vOn0TOLglOC0phJvDFTvihuNoGFUIuEr2VkF+iqoeaBaNtpOw
	 rhWW2zKgaIkmjGWonBzYp5gbriXXbP2Xiamag8Rh2zYuoAsPLH60GQDtXGnxaK98rGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s4cLW+mj2CRQgx4QZSLLIuYW3Zy846HNKAh0LPOyz9A=;
	b=FVJxQcUlyLs06HNS9MSUC4E2IP5000WKSIS5O5p9eG0wYUqtnje8RiHv6Ci3jiuO/4bb
	 gBC/orxnSrJLvYdeAk6teD+Y/EQrgOJ2ApAPfq4aRo+3xT8FSC01Og8n3oOsIwSNt9E3I
	 6cXM+oYHMsYOQmAKL/4KMzLhyXX0eDsAfAGKb5HlhfYMijKeQiZw/K1f8PaaiG3hVQd5p
	 +akPlhmMjsF0AuebXY082y/32gmmWoofMoEI5tcluf+l5uTpD4YE5waRC/YrRfrwpdQwC
	 w534EDBIiMMT3ljWNe4zcMnqxO58Qvu2p89vk/VFxIflLffJ3rWsOs4zOBqPZMeWtbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc5LHj51;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06585606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06585606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc5LHj51
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1171342a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792831138; x=1793435938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4cLW+mj2CRQgx4QZSLLIuYW3Zy846HNKAh0LPOyz9A=;
        b=bc5LHj51bpwXSf+LVspR3J1a68Tyhz7v9oaGy9hh6zYPXytsOtWq+sivEd79DhS9Q2
         gT69sgdRmBCTwzg5W7hCG+6Pm+jZx6YRbsN4sCTK6V7rZUVEIVrlhMcRPigCP2wv75cF
         kG4nmTDdkJ36wXLl14RS/kM7K3m8UwqfDLM31Wrl79AhkCmSk7u7z8amKJda08rA2R5U
         17puwcZHRE1vlcrppMeKvl8y+noor3lYOCOegsx4RHeis+ESZuqyIskiOKseAvQ2RMZf
         AsTiBe9OALkvgTwXI99P/JWFmWKAZDaMb8TEbk17HUdoFK88vKvPua3z5DuFRCQ+/0vR
         oOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831138; x=1793435938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4cLW+mj2CRQgx4QZSLLIuYW3Zy846HNKAh0LPOyz9A=;
        b=s8dXx7+l+6dvasF3inrQ/u5VKKgU8SM9DwoMuho4jcheyuXTxlpHde2IOU8lMpeIW9
         mXj7eAgCXf8/0UHlWtoD1J/DoHE2xlNDWCWTXrjqEyUBykwgc0Lx5nezuUlVaCZWu604
         yyM4hsfxGpEr3PdqNxgvyQ4aKaUBXYb5riH0fJ7yjYfPIClUDkVeDHehiDFotfjeivfK
         unvoXEljCtTDiqPzlj2Phg1BngAV0i3t4WCEAUZYtwliituXPMj6mqCdDkP9f/DOg6te
         H1L4gElSwaSTrxsFqfE67KbEiVKXhl/2b1tgBPj00xS8GuTOGthl8EbV4NF+7Kr1olO8
         o1YA==
X-Gm-Message-State: AFq9FYJnq+bFzIl0fNFFox6QV6883X5HnLptkXmOzWnOax6XYoosRyw3
	QwPez2ZERHtxPpqJKchCKcIi/DeNTjCf1Uvd/B0z/JbtGZ20PyR1iDzNLeqzIxMG
X-Gm-Gg: AYBFou2vnlsyynZgy0QtjZm9mFOI1zv/WOUpZdEScX+h0qCR97EwG9GfjZukaeyjZpr
	s+XHyM3cBxPgx9gW2PsLsAKt8jxdaKwj+e4jTOg7iuQr1Z1Mr5qIZWrDGcbjUSGsduo979TGguY
	84GOr+FqZJlDj8K0QJ6KFzFY0V2+R/zspMThwkl7C0h/zkBhAIEUNAIq0pCqZPbs/sNgGp3UyCM
	tFEScFKH5dyguNQD7Iv93whn6aeLm15btCBsJLdWjeiVpinyrQIUE3rcCNhIYstb5qhK7nyNIbT
	8yRjkc7iIMrZxgB4GMey0je4GOnjNO7wuBK3NsKFhGzxzNUTQUohfVtmH+IAc4xJxhYuuQjOcky
	Ia/8DHBSx8Nk8F3+abn8m3f9A0Z3JPE2l/2ADKItgJAY/YbST5WF9ndos0kRJjXB5zdowG7M4sk
	4b8WqdIt9C+yadrIcYO9/flMCxQRDJy16ZdLaw8WRkYSCvVfHDDNQuQBrnuvm3BQuB0hSYhNPEe
	WDLr7laF6iRexEcMffFEilXoLfUkmzsOtoa9v8Cgs9P8tJ2/6iQFbfFWPQfp80GvYsaAWANM7IJ
	OgFR7vgOjCTPG5Ltu0dxMO/aVJ3AYDzUoGNci2R/OWEpF3CoSC3RYxeROFP6blEHhTDut5kOlE/
	6VFmXA9CL33KAy/arrsEApbCc15wC0VruY55ufUPLOMzJ7vQ8w5kluMFt/1L3tfr4M8lSfEVz2m
	Qk0ReanmL/EijFlbRAhoep2lLsCjAFWoh3l61RpzvDdNnPHEYxaCdZ7LCt
X-Received: by 2002:a17:90a:dfcc:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3adeafc6fe1mr1422055a91.61.1792831138351;
        Sat, 24 Oct 2026 01:38:58 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32f70sm2191251a91.1.2026.10.24.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 01:38:58 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Usama Arif <usama.arif@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:38:48 +0800
Message-ID: <20261024083848.496-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090849-unrivaled-active-a82e@gregkh>
References: <2026090849-unrivaled-active-a82e@gregkh>
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

From: Usama Arif <usama.arif@linux.dev>

[ Upstream commit fe6cf984939d8e12cb33a99673c8d026c5135e68 ]

zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
file case, but not the dirty bit.  The pte path does propagate it, in
zap_present_folio_ptes() and so does the pmd split path, in
__split_huge_pmd_locked().

For most file mappings the omission is harmless, because writing to a
shared file mapping goes through page_mkwrite(), which dirties the folio.
tmpfs is different: it has no page_mkwrite(), and vma_wants_writenotify()
is false for it, so a *read* fault on a MAP_SHARED tmpfs mapping installs
a writable pmd via do_read_fault().  do_read_fault() does not call
fault_dirty_shared_page(), so subsequent stores through that mapping set
only the hardware dirty bit in the pmd and never call folio_mark_dirty().
A shmem folio allocated by a fault is marked uptodate but not dirty (see
the clear: block in shmem_get_folio_gfp()), so PG_dirty is never set at
all.

Unmapping such a folio - munmap(), or exit_mmap() when the process dies -
then loses the only record that it was written, because zap_huge_pmd()
drops the pmd without transferring the dirty bit.  Reclaim afterwards sees
a clean shmem folio: the whole swap-out block in shrink_folio_list() is
inside "if (folio_test_dirty(folio))", so pageout() is skipped and the
folio falls into __remove_mapping().  There, folio_is_file_lru() is false
for a swapbacked folio, so no shadow entry is created and
__filemap_remove_folio(folio, NULL) simply empties the i_pages slot.  The
data is freed without ever being written to swap, and the next fault on
that index returns a freshly zeroed folio.

This is silent data loss for any process that keeps state in a MAP_SHARED
tmpfs segment across an unmap - for example a cache handed from one
process generation to the next through /dev/shm.  It requires the folio to
be PMD-mapped, so it only shows up once shmem THP is enabled (which is
what we did in Meta fleet and started noticing crashes); with THP off the
pte path transfers the dirty bit correctly.  It also only becomes visible
when swap is enabled, because with no swap device shmem folios (which are
on the anon LRU) are not scanned by reclaim at all, so the clean folio is
never dropped.

Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
2MB-backed region, write a known pattern through the resulting mapping,
munmap, force reclaim of the cgroup, then re-map and read back.  Without
this patch the region reads back as zeros and vmstat shows zswpout 0 - the
data was discarded rather than swapped.  With this patch the region reads
back correctly and the pages are swapped out as expected.  With
huge=never, or when the first touch is a write, the test passes either
way.

Link: https://lore.kernel.org/20260819101222.3732660-1-usama.arif@linux.dev
Fixes: b5072380eb61 ("thp: support file pages in zap_huge_pmd()")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: Hugh Dickins <hughd@google.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Ting-Han: zap_huge_pmd_folio() does not exist in this tree; the file
  branch is open-coded in zap_huge_pmd(), so transfer the dirty bit
  there. This tree has no folio_mark_dirty(), so use set_page_dirty()
  on the head page, as zap_pte_range() does for dirty ptes ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on v5.15.223 (x86_64, QEMU/KVM, swap on virtio-blk) with the
reproducer described in the changelog: tmpfs mounted huge=within_size,
read-fault a 16MB MAP_SHARED mapping (ShmemPmdMapped: 16384 kB), write
a pattern through it, munmap, force reclaim of the memcg through
memory.max, then read the file back with pread(). Without this patch
4080 of 4096 pages read back as zeros and pswpout does not move; with
it all pages are intact and 4096 pages are swapped out. huge=never
passes either way. Also ran the patched kernel with PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP, DEBUG_VM and KASAN: no splats. No new W=1 or
sparse warnings in mm/huge_memory.c.

 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5dad4b6ec6d63..cd44744724d0a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1642,6 +1642,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+
+			if (pmd_present(orig_pmd) && pmd_dirty(orig_pmd))
+				set_page_dirty(page);
 		}
 
 		spin_unlock(ptl);
-- 
2.53.0


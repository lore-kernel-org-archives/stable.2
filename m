Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831130;
	b=x6okf8UPSxYDakO0enkjL0STX9JYSgT/+81SvriHs4gEiiPBK3RFQtapwryAgv62Dru1
	 Si3qXc+352ETmWi2FnSVkyyPYYJDPrhhSUvX+m5VPBVw1B/vHItJvNxspd7w9AQ1MUCkA
	 jAh3l1kza/hDWzBdivSYwQHsEVUAi6xoabhkRJYNlVjA39el2aPI2H6QFBalxNR+JGAJt
	 tk3dr0kBSz6m9weGBQH9iQoAzCPjtS63UUmFgUoiyokeSQzC3dggTy53k7CVR1uaxslXK
	 6fJNIW/BJVqHFxYYcIiBsKw69PlbgAJSL/KlLX9grl5Hwu8lq519gCDpj+Jj2fCM3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jSE5cJwe816eE39Je/l7NKnetM6+WNJKDUOcIMuwm4=;
	b=vs4TBLy1UFYQOjqg2BaypBngfuAMX0Q4/V8aBbOajoS8OiFiPAE3DB7ZRF2sgTJhmEoc
	 SXCNCOeuPioUCcM9xSmenuzH2FhoyCFFPUCYlTN1pr1YX1I+mz2yxnaOf3H7/lOx1RraS
	 veiZvPHmZM7ajZeNfJL7KgJ/lgXHdHOno0ULwrLGRTG2VQV7kOS9tBjSj4kBeaHJgHOhs
	 cxltv+qCEfTbK1StzKRw8eMQ+pP+WYJA5lak9V4ECOrE24fPxWEy/M0gerhTnEyB76ogX
	 eEWT2oGK4ASZdJGB3VmyfW0lm/rrmDbTbD+u5pzXUjATiKE+xJYTTyEHdyTEfEXTNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAIH8DNn;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3769606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3769606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAIH8DNn
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c9879395so530067a12.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792831129; x=1793435929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jSE5cJwe816eE39Je/l7NKnetM6+WNJKDUOcIMuwm4=;
        b=ZAIH8DNnTB+UB3pSmX9Jabs4KrHgbqwBlFa3E7C1FqF75DRJcFg0vqmvIyGGyKX9ag
         CTzUX92fUV60/2LyEG3ug88NUbzqJ9DXYpFQp024w+jWuLpDZ39AW+IXOK4THZltyqSb
         p3GOmCGGCyRXNlivKyKKUDSa2r/otoMo/108AXc8a547X2KTsfvu4c4vtI5HtRkVEpaq
         X2X87lyeeVzeZckXUU/MDko8oZR/nzqjECEWQmQ32TQLi9Jf5G+zmHDU5uFkNYddhpcd
         vQiA6kPf3ZtLQxgNm25Tp+qi3iFmc38Fk/s3gs+hZGUZaS2xcq4jlLURW4PH7SVAnB49
         yLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831129; x=1793435929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jSE5cJwe816eE39Je/l7NKnetM6+WNJKDUOcIMuwm4=;
        b=WDf3TqhtjWVAMFlnGpuihJLTIg2d9oGcRQ0aaLof3FKnicAwLgueH6o6vXhFN+Ses6
         KrcAm2BMYDCjM5zsGgrFjBaosFmKNxdidmr3HUXKzh1NtaolvyqpWRmc6z1CoHo6Arso
         VxDF60TRjpbZdUTngdTIBdZVJZ6jBL9052zfqg3DbtwG5WJrQm5iz8BDsUU05ft76T1O
         sQTNbb3aOUAMOfy/pZ3i1+gpwgxts/JduKh3eCLnkDLoz5pts4IZtt+GEm5OPxH3BTrb
         365zYJ6levfCbw6XrS1q0VAO8asUSsPe7RiF0C69Oxa0itDiPBXLjQcyN7LfjFPehXHW
         pJpQ==
X-Gm-Message-State: AFq9FYJV9rWnexxrTdEJuefYIxvF9Wc7ONtMECA3rbBcXTvw2XX+gqmA
	AGoeTUGnwjoNMLeVjgGcz21xeIn7BvgK9q3XZrLlJu3jxQ2iGpfo3a/Hnji6KyA6ZVk=
X-Gm-Gg: AYBFou0KT219s+yRSENQvHiFyGSOh38ZrtD7rXpTYAB0a+WjRBaIjLqBeQLKhkd7a/Q
	Ii1/wr/FiO5OTwRLc92snFNE5aPP65FMECdv9uLAWG+On5Y67nwpOXaCqgdsXseJzo81VO7APS7
	vHOclNs9WAcsexQVhVgKlHi0XyuCidAkbEi2cMbJofytLaQCf42MS7qbIunB56soyF+kzKUlKBS
	2O3FgZWdXuiPdXGwL9Dk1B6zeQR4v2QSX02AI3vMwL3DxH1wlVBBSn8z68wgfx2yR74Fpbo6JPZ
	wACJnxRtayCvRbIqwU9cHHygF3mWI7IymLS6AhumD3ZMMLOA8mRPljGXO1L4SuTE/Z1HRaJMJfH
	X8rlrI4sngSqn91M8nvQH5w3hki1YOOnt5k71OJ4DV2FcBKL/LqpmeHSMnW6D/vIBsgYAt5JVeb
	wnCLYRo6oT9yoRuxWCJU+zSonSU1ya9red5gYCADiUdZ/r8hH/nkr9R/o9cYQzc0dbll9pC4VWk
	EzZZ+jLdla3mmEocFu10+nblTXeOz2ONWCfKcDZBM0v+MDoD6U1wZ9Zhznh6R9fFukyi2ForWpy
	qbCUJgAL0PIV5qpwhzWSgjCA03xaoCrkRo+vnyYNT7oqpNdpCeMAw0srO3+qT4Uerm4ZSKTS502
	0ZRHz0Bzb91vu7VKaeOae8+9eqYMQ69y1QzFY8RZGnIBQFGCECAUbNTcTcgQBKjlT6/XFu1KIEb
	5ccaUSrE9yBocmClMQECwlpHKfPUrPnxknirKM8DiZ2fq7VFHPuui/LV5n
X-Received: by 2002:a17:90b:4cd1:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3adead44808mr1244833a91.18.1792831129084;
        Sat, 24 Oct 2026 01:38:49 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb819729sm2225200a91.0.2026.10.24.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 01:38:48 -0700 (PDT)
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
Subject: [PATCH 6.1.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:38:34 +0800
Message-ID: <20261024083834.466-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090848-observer-disrupt-ef38@gregkh>
References: <2026090848-observer-disrupt-ef38@gregkh>
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
  there, as the 6.6.y backport does ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on v6.1.190 (x86_64, QEMU/KVM, swap on virtio-blk) with the
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
index 483cdc373a20c..06bdc218100c4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1701,6 +1701,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			if (arch_needs_pgtable_deposit())
 				zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
+
+			if (pmd_present(orig_pmd) && pmd_dirty(orig_pmd))
+				folio_mark_dirty(page_folio(page));
 		}
 
 		spin_unlock(ptl);
-- 
2.53.0


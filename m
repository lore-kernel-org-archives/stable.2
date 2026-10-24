Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831149;
	b=UFxzpdOoB6kPj5x7/E0q7rkKyCW/Q6R38IkddnX0T/jH+GELxZJr7V94tH3i7fVzoKAB
	 RoSnjr77gHLec7IRFaStj0t7s5bcBDQMyIrsscBWrxr8NOmzfRk86ETX+6emw4pgSRmKX
	 GFWbIEUWc1J0deAvK9HrwLN4YHX5CirSPiaNIe3+dfhTVn+xN4YCQR8Lns33TkdnIeQDc
	 +yW7gWddhFF6d72l3kzIk5yj96YO49vYy9C8ub887xZ8mFDn5C7lWiI/CLFKYsSxmy3+t
	 svzwgsgfy15WlflthFr+eA+cLgFlxlHhhVlFQdkBgI84dS4KZBmiNB7JlKea6NTaHZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XuZYyPIpPfET6wo4kPmM2WOsWM2aeFyFoCKMG4TitDg=;
	b=RuClQLCU1c2lQBzuvLfl01zV4fO8SVv5FJ4DLTXfwARlrtipYaolJn2bzMmu15r1iTDb
	 8tfMdSRWBaM4xy+0nzHR1LZSwUpE+a6Kx6iAYQMNY0G6fp/tob2qEkq0TWlefQxfFbo70
	 gjVEhGu9DByR/lYkLHBCvtkl2pKH+woRtlopZWfEnynR0pl7XaVf94a4A9QY+1kPwDzLe
	 AgwkXbgJtmLnyPlMwo+hcKW1DCbr8ei+bwlB/jVhqsor0FpiiZs8eMTtJwqGZl8WgjEY9
	 Q2OipuLW550c+4R07wrbUK7eS6C/BppJ316sR2a3nUV1KhN9Nfg92wu9TGgLULxL4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L21KeWPX;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12F606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D12F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L21KeWPX
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e5fb79ce82so10260035ad.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792831148; x=1793435948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XuZYyPIpPfET6wo4kPmM2WOsWM2aeFyFoCKMG4TitDg=;
        b=L21KeWPXh1D41fhLAtxD93QTJW8APqsfcI1afmHID0PC/1oao1sBqpbLTkjrNn6bCu
         UUMdIyFZKI59jxH2sFLIDdrLydpN1HVj6Jd1kC5XJ3PmMWjrc1Vjkql7wx60gFM/t0Iy
         iK0wnoS47Px7XdSdjx9nj2QvgFYVz0AJo5yl0wc7B3zRDdcV4L++RuAn2uf/SPHnTFFI
         p/pbCM6mz9RiDuRfl3IOg271c9I3CZZ+g3lq+pUO+JHdqR9fodzNbDGb+/o4cscfH0T+
         HFVwkAoR3vHifPC16mg5OQcBw4LQ7cUdsWCZXx9BJIOlM3jkQrCFxT8vAmoYoVDlQaNZ
         TLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792831148; x=1793435948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XuZYyPIpPfET6wo4kPmM2WOsWM2aeFyFoCKMG4TitDg=;
        b=MV96gW1R84m28VbU9nXUrn/9dAzR1hKwjdPHuW41SfygAa9+/YFfMmUOkjIh8Xqy3F
         a7Bgz+cs0zE8xli9MEdX8IBPJdgimTJm5yO8Z1uW+zaxR6+JSa4tR7MheLV7RQf9Gt+f
         zWgFGudD8TcDcGGUa1mCXg1drM0gd47Uoka+zeNk+Ek621s33u5uJxJ7Af72K2JyvQo4
         cNaeDCY80SDzLGEdy4TBj5kOqVUODKWzPDy9zecd/4p+vKR2sM1mEaEc/ohjBaLMnBOg
         suppcqWBTI4j3IeYK2WMtFDvsNpxdBkT2SAmderx58ij9LA6cNP/LazZiZVlCfxFVPFK
         dZ1g==
X-Gm-Message-State: AFq9FYL9H0GRS2yu62DKEMtA8ffrF2EY720+6Af6/LQ33qHUdOouZ6z5
	jm/rcrro0zDAZygPeudLVe44BGywCmKOXWVdxpmcnnmTROj4lSH+Cz27tJQoqLhr/Rg=
X-Gm-Gg: AYBFou0X+ayRLPYqYgUJMJ0x9Y8ugR1PRZvXkkM118Eo0l94pQvIbdk4zP3Ar+YA68D
	GHK8Ia6V+AjxllXr0aTIHAQqWwX9WaTx+lit9Am3qWnrbGtAB/ssVfCyPvUS0w8NfR+OTnp1fOa
	E+AsLZRe9ZlrGIVSZ2iffPOX8Bw1czp1i+YOdPQthdN7lx/GAb8UhHst15N+R4l/8jQbdxIpZnS
	bdeL8HobNMv45fyiimXqtI4BwzE9raBYh1WHjClLTS6bppVvDgCBSkLumXfRU1z6s3SX8+J+XJX
	eTlTdb4+pM1fohTANRy3nyR8hB7eASgLwh6X41WUDIizwL63KtjXkmVfqML0nYh9MXh/5V8I9U2
	o4LYdslFHzBf4+emcx+6AEgexhL6Nv+Cn/6F562ySWuuU6MR8z+ikcKP1SW0wqTGHkOm7q2gGTY
	7cxat5MBSgg1MUr9WWFuKxKZuLgJicK/5+jrJEn3y9VcVTdhxvghi02jPO/s2l+C4TINshsW+j+
	ZdtEVw/u3/5nMdSOti5T4ckwiaGwKd/sNf6UCzMa4VeV6Wcvzc1Ez2LYQUna1v4vzCmRCk/kxc0
	1qa729jG1SANDy03zAXFo4UHNxA5lE/YukPslhoMcp/XDEcvFL9LQWsfYCipnnaHAqfAHhCOyaJ
	TxUyoFy35N2dm3jrT06nixjBT5b8BV+nsuqhlqtGdp19Esx0eb70Pit+83Ubccx3RX37avPBjNo
	33p0+fEGEdv6QPcW2gCEehxCbjnydRFf1oVNWQcBEZz+PlFgOnH3pHHWf6bV9cGxOJ19fVFPDeh
	lTPqQ==
X-Received: by 2002:a17:902:ecca:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2ea9c6c22a3mr12466055ad.19.1792831147795;
        Sat, 24 Oct 2026 01:39:07 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a15d6sm3821105ad.46.2026.10.24.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 01:39:07 -0700 (PDT)
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
Subject: [PATCH 5.10.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:38:57 +0800
Message-ID: <20261024083857.520-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090850-matchbox-foil-749a@gregkh>
References: <2026090850-matchbox-foil-749a@gregkh>
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
Tested on v5.10.272 (x86_64, QEMU/KVM, swap on virtio-blk) with the
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
index ecbd84a4a97b0..f6fd1d3527b68 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1719,6 +1719,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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


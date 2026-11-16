Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841645;
	b=SX6Yp8O8N+/ssNcvtOV6PKQazDnFTnlvzcklj0j5iFBeqzU5Kk7NskAlXO4FyA6ttSSq
	 7Mw6oswfJE9naYEwl8k9GJMHfi8iCaYTn8aq6gy8gHEZ60bsrY9WY1VofAWDe24EFY/ON
	 Wvvywj2Ya6Rb4T1fWLhVNmVX/ney3wc/gg6e6Dub6OFFf4vRCfvcsJ+OlvJLzXrH4kvez
	 nbR/cjVtgBPWuD51VJ4Tyl4I4m1HtMvkqMdqZDyDFRwKjurPA2QBx8JTDNa3RZ39TbTZE
	 JMV/IsGsUS60Tcvol8HJdznvGDwAMsuIrd36yFLG9k6wO3bSuh0YP1Rqketx9ak5xjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841645;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=24dnBicOCQ6PU4ccpK1L/KabNcmlceCnSlc0y8c9XPY=;
	b=Xa8I/foVQhweZaibE5wLVq4ENx/2A/sWEL67vBLnWz4jesF8V9busOIpunyZsTdkaoHK
	 iDW0nP8ZvdQEmTfT2d0R1KZllcbxi0zrnyhgqsghyUwIukruRUPymOg7LNI88thXeWLco
	 9FWi3P9G35wezsTNxnT15sDYnG0aixcBuxGkWbSwftpP/iKFzhdfFeziCJbO0CxhnlHFF
	 qff+2/3BAoh9m2P9/IBhVZ0QEv23hyG6QZIXmxuLhjv694fP9aVZ/mWWWjzRiQvF+4yvR
	 L/dEnAmTidIuK5K27qQpo1BSb9T0IU+KN1KXPWn96HAPGN/JzhhECEC+Zc7Vsox2vVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIVLEBCK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B21606A884;
	Mon, 16 Nov 2026 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIVLEBCK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E9C1F000CB;
	Mon, 16 Nov 2026 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841645;
	bh=24dnBicOCQ6PU4ccpK1L/KabNcmlceCnSlc0y8c9XPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eIVLEBCKZaXYk+6Gsa+Dnak6kXQnbgYrTF2ZOVKnJTK53Oy5209FcWLTc09Kb8Qq9
	 VrCy4aXVquNsuZFGecpln6bZSgAgpZLDGJvN/rszeTNwXMiG4Z8byZIVr2PvD5px1W
	 h9vlnLauKsj+3EZ3K6rBZ0I2R/XedySwoUxfSGExtIK2Se6P8tiTVzJn6s6crreGDB
	 HglGs7UkGQbb1ywJVbmgEbLNPdLt5ipJn68r0zisZrR/+RiXFcVBsiZOixCrnSODVU
	 SuZveU0Jv7x/bQ82Tut0yaft/sgeHCyZZ+CaN/TRkOG2ckB9/yURGwSWJN7661nDnR
	 Ce3JKoEoBSdnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 16:06:58 +0100
Subject: [PATCH v2 1/2] mm/mmu_gather: delay rmap removal on UP as well
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-dirty_file_pmd-v2-1-571883053174@kernel.org>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
In-Reply-To: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
To: Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
 Ross Zwisler <zwisler@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3184; i=david@kernel.org;
 h=from:subject:message-id; bh=9KD+JeN6DdWJ9WBFO59zy3LWV7p62xtB70jlMZmuFgI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+y0jbTp8sf80hWcz5l4dA9MH2Ux+7MudN2tLzw4PnU
 li+2SWejlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYSk87wm60veS1X7Deu/9VM
 hVWfX3xpXjeJI0RoRhO3dPij8kPbUhn+J8Yfz1954tB7HZeA5o1bA7pZ7+fFd4eIzdI0kC77Nm8
 dCwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
has been flushed") introduced delayed rmap removal of dirty pages until
after the TLB flush, so writeback cannot clean a page that is still
writable through a stale TLB entry.

It skips this on UP, because on UP there are no remote TLBs (single CPU)
and because the PTL prevents preemption.

The PTL prevents preemption while removing the rmap, but the local TLB
flush is usually only performed after dropping the PTL.

Consequently, after dropping the PTL we could reschedule to another
thread of the same mm, which does not flush the TLB. A kworker could
then run into the original race with writeback: it cleans the folio,
but the other thread can still modify it through the stale TLB entries,
and these writes get lost.

Fix it by simply not special-casing UP. Now, only architectures that
select MMU_GATHER_NO_GATHER (s390) will skip delay_rmap handling.

Fixes: 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been flushed")
Cc: stable@vger.kernel.org
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Link: https://lore.kernel.org/r/avrxOt_GyXLXNqtR@gremlin
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 6 +-----
 mm/mmu_gather.c           | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4bba02fd5d543..cb087315b4e72 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -249,23 +249,19 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, in
 bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 		unsigned int nr_pages, bool delay_rmap);
 
-#ifdef CONFIG_SMP
 /*
  * This both sets 'delayed_rmap', and returns true. It would be an inline
  * function, except we define it before the 'struct mmu_gather'.
  */
 #define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
-#endif
 
 #endif
 
 /*
  * We have a no-op version of the rmap removal that doesn't
  * delay anything. That is used on S390, which flushes remote
- * TLBs synchronously, and on UP, which doesn't have any
- * remote TLBs to flush and is not preemptible due to this
- * all happening under the page table lock.
+ * TLBs synchronously.
  */
 #ifndef tlb_delay_rmap
 #define tlb_delay_rmap(tlb) (false)
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index e98397ac577c4..c022aeb7c84d0 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -49,7 +49,6 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	return true;
 }
 
-#ifdef CONFIG_SMP
 static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
 {
 	struct encoded_page **pages = batch->encoded_pages;
@@ -91,7 +90,6 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 		tlb_flush_rmap_batch(tlb->active, vma);
 	tlb->delayed_rmap = 0;
 }
-#endif
 
 /*
  * We might end up freeing a lot of pages. Reschedule on a regular

-- 
2.56.1


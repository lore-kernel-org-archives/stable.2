Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389886;
	b=CHIB6FeLJ04h+AUlv/Af2HGIWh4jdbjpT4Tgl4GJ4n7W3WlJup3baR3E29/UIhWidtmA
	 TIA2wAUQVnCUtwbw6mLFL7VQ8rrq3eM8ffPtXBJ1QKvIa1GEU+nz6J8b0bDdjfkIcUUqN
	 A2DEbLn8uF2XHiNC41b39QE1Ny9MjrUq62lKKeXa/w6w+ya/lku0f8K18Xns7XKMribGV
	 lK5/xckCG3mmgLWzcshxtJQ+bGaT6X6nzQj40GseBkKxBdj52LRunzrMZroRlqjG6IGTC
	 6GPDJPriipkYHAPZMALI9PfY04WyqAObQoEQ6+97Bft3zb9f9xKfmaZkIBUR+5rm/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mlI2hSgARAsESdSujlJ/ayVkPK6G1sKTaez08nG/rjk=;
	b=LmtuolPyW8mdjLKEy5Ybf4wKXDDTOl3XIZkGE9XImVTBPpIvPzU0YQCh6ZaDHFDQ3cFK
	 QEI8/yxfVRmZxJOah/NG70OqgmDxOxCAojD2xRmx00GaJdELKHWA52kx5vcYTAiJu4qkV
	 yPXSVtOPhwQWURgU9AlrEiAXU8Zxl16BDPOUsUP1DNmZwIOzwfBTVCZaz1GAjW6sDEJTl
	 yAROG2cHV3iLlqw486mduIf/oH3xjPjcGJMEY0YDwXF6pAj1HjzpXeuRp61JQ4EoEgn3Q
	 UiIt7erMxOOkG6UuLrtKe+4Uuitqrbq0tYRYM1qkgjEVMqIi3vedPb2eUhgCdD+fMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zgm48Ofx;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56639606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56639606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zgm48Ofx
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f6295304dso3808870eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794389884; x=1794994684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlI2hSgARAsESdSujlJ/ayVkPK6G1sKTaez08nG/rjk=;
        b=Zgm48Ofxl21FGBkrlHF5gDrVbftQ+STGBI/4ooxBGqMSJbydCwVl6sCHL5nFtygXi4
         uGFNmpJ49L/NbICbOyiM36wpnxVf+MKDQn14BWDQdOYVJxvxfBt785yqWKlAJ5m9daCh
         H3zBqbdeLM3chDniXlZK/INvjPIv4mpA7Xs+zxEd56A/bHskYVLW+22DVLajn5qtRujz
         dYo+xyLgFT/M08FIImBdetnP0we98esiK3nmppdvt6ejCNLSqAPlq0+VOGkMgObThUST
         2yQKzHIg2zBEbTE+z2oSTU8DUePWZAfk9o+ObEVgzkAcYrw1JrHh0NIjr3j8g/LZBO9A
         KLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389884; x=1794994684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlI2hSgARAsESdSujlJ/ayVkPK6G1sKTaez08nG/rjk=;
        b=m6pjgWknx/FzSAwlk0bIaABu6NoBfjarDBtGAvUOnOKYJZiITwGc9ozbOiSwo3TDKx
         nqmKNACKotP7GsipGAWHx7fwxuPGtp5/6Jyqq5E+sTJ41iPr34wvX5N5+Exd3VTZ++ws
         Deg5TcfLI2rDA5aOuGIY01ydSzcqsdaLeOYNfEni4qe8ueCAHp7LnAs/PYY84zK2q4BI
         0FuWHvh2JxkuAHBXspAI7pehL6fyLBXRMqxFvgtGASmJ1uHoocDxdmG/xBHL6xMntsEH
         x3BpUdvFzOkE6ez4vPF7awD1ACc6+HP5QbAr4EvnGNa2mweas9PeUVrRczFQ+VsuA1Io
         4zJA==
X-Forwarded-Encrypted: i=1; AL+hErEz6JgBm9Y1hpuzKe54h/+NFStm/3DEK1MTBYVl6DtOsV16zHC2NTkyMqBvzP7NGmRuMCJKah8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Hi3DPPPhH6GZs7qym2zwtWidEYngF4vj+Ut0ALRw8EkOLqpQI
	zqXqC/fxEvtR2oj4CmZcMtl4lwFFTEjKESFjHAtIueUQZbIga5tzhmDn1nrttuyAT24=
X-Gm-Gg: AYBFou2Epp8+KOJUQ8Ev0X5g4UuvAYHxyxCxid05+ZoVpAUQPuKu2eF0I2L/fbKlkNC
	haNUS8iB+Fd6itNHdKKVxLlMhN5uZ13RSKWEsDF0tMWCjsETRBLg50/K8/jQx9D9KuQ9l3ApusC
	tk1W7E0Fu4hKOZBMjv1P72YuKvel14j1DeKZEUEgFCGBiQwMN+IHwlnPdH60LHe1G5n1trczXPO
	144teaKNh0dGPVeKSmFELibo/xRQ5oINu+8xdyTf2+ZhEw3HArJzBCuz63PEY7zCGSY0lagr3C4
	+YW2S71lCzNrM54Az3OwgX+Sm8vnXhmeYAIXq2PcVSVOdp2NtsiHeDQHQ3mS+DMJbRJ/nxb5A4Z
	31z9JurE1yQ4uEhzn27ddypzOBP7ltnQzeUzy8yKWaDxdX8GkVIrhsYp+NGSU3Mca5nhfXy4Uxe
	iXoVrSHgSXCFzX/+j4FkYTrl9xvxUZOcS+UQ9Ekx73m577QJaEVWhnPOYhxfJ5NEFj7AsGrykdA
	W69GL9KsHxeB72lSQOG4KDTDti5zh9x/isGgRpC97NEQtbfyhjyr4BPvR0DhhULNOciwssiXlhq
	lbsTqvBBLfIF7TYUJTEwM2PYikuVuBYpcLMjiyKRCOL4nriYaFLLKe189aI3CTg=
X-Received: by 2002:a05:7301:dcd:b0:370:d7fe:6585 with SMTP id 5a478bee46e88-37685c7a46dmr2269843eec.11.1794389884220;
        Wed, 11 Nov 2026 01:38:04 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm29016749eec.23.2026.11.11.01.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 01:38:03 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/hugetlb_vmemmap: fix PMD split TLB flush race
Date: Wed, 11 Nov 2026 17:37:45 +0800
Message-ID: <20261111093747.50048-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111093747.50048-1-songmuchun@bytedance.com>
References: <20261111093747.50048-1-songmuchun@bytedance.com>
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

Bulk HVO optimization converts vmemmap PMDs for a list of folios into
PTE tables before issuing a single global TLB flush. After publishing
a PTE table, a concurrent single-folio optimization can observe it and
remap its PTEs before the deferred flush:

CPU0                             CPU1
hugetlb_vmemmap_optimize_folios()
  hugetlb_vmemmap_pteify_folio()
    vmemmap_split_pmd()
      pmd_populate_kernel()
      /* TLB flush deferred */
                                 hugetlb_vmemmap_optimize_folio()
                                   vmemmap_pmd_entry()
                                   /* sees a PTE table */
                                   vmemmap_optimize_pte()
                                     set_pte_at()
  flush_tlb_all()

Modern MMUs permit overlapping TLB entries with different mapping
granularities only when they translate to the same physical address. In
this race, the stale PMD translation still points at the original vmemmap
backing range while the new PTE can point at a shared or replacement
vmemmap page for the same virtual address.

Serialize deferred PMD splitting against PTE remapping with the HVO
rwsem. Hold it for write across the split-only pteify batch and its TLB
flush, then downgrade it before remapping the folios' vmemmap pages.
This guarantees that no PTE remapper can observe a newly split PMD until
the stale PMD translations have been invalidated.

Fixes: f4b7e3efaddb ("hugetlb: batch PMD split for bulk vmemmap dedup")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fbdc3410-a4cf-457e-88e6-684380fbadfe
---
 mm/hugetlb_vmemmap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 79ca68dff635..6fba3184356c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -311,6 +311,9 @@ static inline int vmemmap_restore_range(unsigned long start, unsigned long end,
  * is skipped, the caller must flush TLBs after all pteify operations are complete
  * before remapping the folio's vmemmap pages.
  *
+ * Note: The caller must hold vmemmap_remap_rwsem for write from the first
+ * pteify operation through the final TLB flush.
+ *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
@@ -321,6 +324,8 @@ static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
 		.flags		= flags,
 	};
 
+	rwsem_assert_held_write(&vmemmap_remap_rwsem);
+
 	return vmemmap_remap_range(start, end, &walk);
 }
 
@@ -400,6 +405,7 @@ static int vmemmap_restore_folio(const struct folio *folio, unsigned long flags)
 	if (ret)
 		return ret;
 
+	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	return vmemmap_restore_range(start, end, &vmemmap_pages, flags);
 }
 
@@ -568,6 +574,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	if (list_empty(folio_list))
 		return;
 
+	down_write(&vmemmap_remap_rwsem);
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
@@ -592,12 +599,14 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	if (!nr_to_optimize)
+	if (!nr_to_optimize) {
+		up_write(&vmemmap_remap_rwsem);
 		return;
+	}
 
 	flush_tlb_all();
+	downgrade_write(&vmemmap_remap_rwsem);
 
-	guard(rwsem_read)(&vmemmap_remap_rwsem);
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
@@ -620,6 +629,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	}
 
 	flush_tlb_all();
+	up_read(&vmemmap_remap_rwsem);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.54.0


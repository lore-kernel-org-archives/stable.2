Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655571;
	b=mBKl5L4Rt1f3TpT8Zca2YuY0+C1IePqmKe0NfcX7xGvpNv6A8QUGrsXpd3cQajZRY5BY
	 a3KinvUxPUyB4GyZTol6cbkrfA4IQOUWqZqVCQYtzmyaBI5jr9RQZIw993o5X8n8eXznl
	 LL28lF8ipByifRgqo0XDaO81KcTA/I8oE2vJb3T3oMao+vP6crKow/8icS6A7utOtu5Dp
	 LL71TMylmexTjfdhcKRU8gG/Ve7Q8e16Bve8rsObID1bKxdAwojGfhgaVfFtP3gqLRDQa
	 4M73/z+bCfTxGZpbHJFBEz72zs92zRClQtPkf0/3vXZNnoSu8msEwXRHAISGBzGIhvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yojspyjk6M/XCMUXwgemrJOhlA57VD8UrAkmCoHaT+M=;
	b=WzhQhEiBcnz35W9VSnx8QAisNSuVgzsJqfmh51wEzZWnYXAKXgImbdM29ctN9eHgCDaL
	 6qSk+7DdNufTlbxDPx6+JbWJ0+dWY0IFlYt0QQLCE8aqXYwyUKJ/IP913XsmT4Repf6h8
	 Vp4AIMtXXtKeztyD1//fRc1Fpd5wf1dR3oXA/NO9BD3YO8LoqWclZT/aMyk9L0O6Ichdz
	 dOQJKEHZeS0Tbv1EdM68W0QJu5zVZ4PRBAj6WbIXsP3VmQKR1ix+HHayMBFjS0k9jJRl/
	 JpXya2lCO26ThO2TaNMuwuefXz3trwj9BljUpnvIVekMedzMOtZ4TPjivMrEvzfJP4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Vmj9pFsE;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F5606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B3F5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Vmj9pFsE
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so2624530c88.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 03:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794655570; x=1795260370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yojspyjk6M/XCMUXwgemrJOhlA57VD8UrAkmCoHaT+M=;
        b=Vmj9pFsEQ/S2z5X6V9lWXqXuC0Hz9CHAmf3gNjCbHT0noCdvcf+34B0kFdPCxPnjN9
         F1QWs3Xp9i70g62lofYJilwisuB8w3LugZQu3CBY1VK7qtFUOw7hAhbpV6W8hCyVWilG
         1sHEQTXC9ikByO5N20N0PUyCHRH3M/REfrjKLEinYEb3eqrWb5+6fZxUDv7DvuamY/Aj
         32oVaAQCyiXBmnpGXBk/soYbpVXJopgbwHfMUHdE8yHf/zLPfEJo/0B40hWX8l1Q6Yc8
         hKq6y5Vu5x20EGEdRMvx3PSLc6jwjX80D4Ji7/269OWBXX2lnfq4eNXKORMdfZoZ0TFx
         2NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655570; x=1795260370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yojspyjk6M/XCMUXwgemrJOhlA57VD8UrAkmCoHaT+M=;
        b=0vhEXdOD5ryMlJAKuL7Nwtt83YRXusFOxsc+uwi0jrdxZkpPAcpbbFF4wjSf/Bq8xB
         sh878CEjDC9dB/4ctP700jG8DJ9oEBCxI3kagp401atsH2RuJRr7pKVX9KNr0A0Tvc6W
         fOX3kGOFaoN8f2CZQ6zM+LCq1oPGEmHrs+bTyEKpSzsHAc1aSF0MPbopLGjelYG0v81+
         QBlpydMAjNAIRLHkACgVHynsI4RzgF8738JH0N8nHye+fRwCIX/CpfOMUz2GOkwt4DDK
         LpnZwKX//ZYlU3ewvDExlpHSjUdPZ7g+cJTW63cNJjBMd/yV4X5zj1z9HhpFNwI1umkQ
         Cktw==
X-Forwarded-Encrypted: i=1; AL+hErEjYwI1leirD3aZcCUB2Cgi6Rjc28eR45mhj/NFqMRLAMnH/xWO5idWJudFQf1eQGvnH80hUSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l8uy7gTsVoMMyuhu/7+iv4R2RIwyzkQNlYfR6sBwg/D3eYAZu
	skeL6WAw7cZ3ThAcJsPPy97HshtUqyQdAxSL49ahKkG6C9ehWXc1ZXA3E/MvkeyDsV0=
X-Gm-Gg: AYBFou1u4vp3kkHKMQCRi447GLUbYyzBeadgdn9YR/jVzcyC/nu/FoJOcUkx3axzovD
	YzjAwOt/IC1HJnGYIFQHP3dRFCZUxycfs+Di48H8xPEpkpyPdmZeg7DnTzg/+xntLgWPcbbCd5h
	06pq+fBc43aX/7fcp9UHrXA3Pzbgu941VapbHWHoEXgoAKzkkhfUdhKc/jxnYjTMxXtdGnkkrS4
	zpzRzp+4oOhdeLI704Yjzcf/YvB+xXPwsbuqAIUGiuly817M6nkBYQN0wrwKAmk+7yIDB4ccYO5
	BFCdSzeUHoVtWv0wrOKMgCvtilwZ9LMMMN4E5+JN10M0AFI4khTb/nMUALNWds6ft/tupnzc7fS
	34TucJx5vJoon5MAPm5kQZ5rB+4OKpvDmvBe1c9eTIF7mQSzcN9YELrQMMcozxt/l+uhV3tA4ZW
	U7UlLBGJPDa9lcNu4ZoTfGI9X+G7mEqBreEmfVWdsCioHkdmY8+qr3BAPF8wDE7ekG68H7Roz+2
	C1iE1F/otcdUeY3H7c0pu1FUZ/g9ITkVOnyHPiXDnMU0xYFHcxYot3TNpLMOLCzo2Nsy27EbwuC
	O82vbpXU/dtKYlyKQ2UrzEsGZaHFhOAG6FTU/2Da89Xxw5RWzQTi9eEBlLAvUeTz1FdkAt6d5g2
	cE8fHbg==
X-Received: by 2002:a05:7300:5609:b0:377:a1c8:a628 with SMTP id 5a478bee46e88-3796676addcmr4689862eec.6.1794655569869;
        Sat, 14 Nov 2026 03:26:09 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:9d36:3b30:f4a3:7b5f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm16190627eec.5.2026.11.14.03.26.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 03:26:09 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/3] mm/hugetlb_vmemmap: fix PMD split TLB flush race
Date: Sat, 14 Nov 2026 19:25:22 +0800
Message-ID: <20261114112523.75208-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114112523.75208-1-songmuchun@bytedance.com>
References: <20261114112523.75208-1-songmuchun@bytedance.com>
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
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
v3:
- Collect Reviewed-by from Jose A. Perez de Azpillaga
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


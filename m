Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309912;
	b=TnXHeETtxFMTKFoInaVEAbQ3/Yjo6oeXU0wbwkYAl8jBVeJQPuKA/iD4YMLuSAspiWhk
	 nRS3EAyFbyFhyZEoxv5NU4yzblaizRt0mPreX2bWotuFa8meCqZQK3MPxaTgsuz2K5cEj
	 7G3NburnNPcbu36zDLXXBVWwsUXhI7NmckyevItAby8G/1UER5RsRTngNpvIOd8SNWPNG
	 FgjOwKjIl1sSILf0plQP6opz8bhsJDMoDkl2pYo/F6XIRR9MWZTFPCinsJuS3syPcQExM
	 PiKRoGShw3K1vwEp9BFNUz0IvvVDR93ViGSFPTBSUICpmmWBhUOI6uUBJK+34yYQTUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=olyA0GkCFOlLCJET/iZgvs7pvm9Jf8w/7sECMvsdEs0=;
	b=ry02DdfXSJy3sMhq65ORXTd3HMT6H6XQ/2vC1mrCy3YvzXM7kvHeCpjMZ6e/0KjnoW93
	 z86Dn27zCDmLy+SnaA51v/UPvziXgZPDrVNBx/9oFuWl2oHt7lBnlgkkfwpxnSBIgcCRo
	 rdm0mieWzoSSsyH3A2OTeStwO7rhjdrDfXPdCSe5kGm4kbabnqlNRUcqYPGGTNX0x1zhB
	 0COebeItH/F4RndClmJl0yu3BJzPZhjVBAs9Xt0+4Hyes4wstUhK1XonXrWJazaXi4Kxv
	 3biST1ef37IAfZ9hCSO+nkO/4Ja9yIoBGwNJMmrG44lFvUjFT3pisRiPdAwOkmIip0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T8yWAAYk;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F0606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1F0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=T8yWAAYk
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3837763eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794309910; x=1794914710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=olyA0GkCFOlLCJET/iZgvs7pvm9Jf8w/7sECMvsdEs0=;
        b=T8yWAAYkgz2a+nkOHuIH9bIYxYu5yNNTOvK3dDPfSZjQZYOb1MhwXxRQStfiX+HXum
         RU2XOqcQDy6cfalegyRSO7c+u0XYRx2svEHpBNXRFeqHMi77HOBGDssUWiO9yePLG6+0
         4oAYsFleFq/PfWACKOn2IlmdMKTLurs/g4TbsYqfV+fCvOl5B/3b40QKpYh6IzJDPkxX
         AZaLuM8ofZj4og0fb5RvRqLQxigNnqMRCXpxlLB5LufP1WeuiQND5XmgnQBQ1QwA4MZa
         S3QCn7j4ndeGbiS1Iru7LaE18aFo6DvuDqgQh30HTy5eXjT1nyyM6XvfLV792823ZYwf
         IKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309910; x=1794914710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=olyA0GkCFOlLCJET/iZgvs7pvm9Jf8w/7sECMvsdEs0=;
        b=iTBLx8lXv8HGTBsXh2iY9bvC/hSdRQiKoadfU81dJ5dubOWN2VCvsGtMA0hOdrYsEc
         cMtaX72P2Ky8UaoZrYgynVXG9NEHURJsVi0nARRa1yRxJ68fmQDU4VgQ5omO3Xl2wV7M
         WVd1ZFJmt4pXv7HhYebkof6747yRu6wAXzOYTMUiUEf5wXX8ci5x0aa2oKLBw2hGpIT6
         FzGRSzwtZqRt1nqsGWXOwp+txwQNSRD/MYK/tQNtTyDa12wv7I0crzHhJ1B2oJzNmJTQ
         ST7qMkRqT1JOJjv2W1/xnCG3hNmMTc+qxHPskop0TVDgKyOyNKmlpIG6whPG+L5Watg5
         4vnA==
X-Forwarded-Encrypted: i=1; AL+hErFrsL/XuarEDGGqCeCTOO+Howaj0B1bRwR1s2DRp9nnBvU90b5liFPbcABnZwhaiw2pr588Kvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oMcOWdd194XZ81W3hGM1dZkA6geCu5jZCdCf+U6GKCSVobJcx
	mp8bxf9sbENMVmuL5MvrM7lT0o+cI//yETtradFyLHoSoTa7jpuYzmtZ9GO1K1BRZa0=
X-Gm-Gg: AYBFou1LDkzRMDFdeUeEOPWt2SErRUT3FuZiXJaoWtfAg0OBy96XuhaK3VUNnagbdq+
	O2TWf7kS3MltX0bB/fL18KfFygLv7g2V1MbcLpMW2XqL3buU9vyEG+XfxmecEwsldEBjs59Fos7
	MHg71l9USsGx2LGusooHZ9SHOM83SdOnz0LrpHg0z4d9sJwtUnOflieM2O2UNldlKIwKJ0gGAT8
	yDL89j86N5YeqQjSg7UtA4dOHKZiqd72MOaTj92zP1/A3kpyforjEtSAYzNTvbrfPEatZIAqYYf
	ofohXpeG4g9tNuwEo96ApSjsXTWxrjvj1q2o8IrglValpt8JmU67Dk/eJ79zKnBpF+IcXboDwNu
	3xjFaEtRC0woQ4auQaqaOhEWnUZNbGwHN513VTYCTNS5Xp022hB1IeVWqMk+cTl7uTDMYbTkUAI
	8kNBLZJriLxlDqqd4K6WpGmzT1hjsf6EW8vTUZgl2J1MvMAsmdNB2GQkYxhyZZOImsauGdnNkM2
	e2hxT9wtKiCThKa3LIAzd4+JX1fLtBuXNhxhGCL3/1avYhTTD1vSQIUxx9ih0/pZY5+6osCbizQ
	+9fW7+GxQMS3OSETuRriJSca7fkXJLMcpXn6BazCmIV5rTIsFn3EGind+R+uHxd/KQ==
X-Received: by 2002:a05:7301:1522:b0:36a:1089:9836 with SMTP id 5a478bee46e88-3751ee747dfmr2528761eec.15.1794309910199;
        Tue, 10 Nov 2026 03:25:10 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm7608755eec.19.2026.11.10.03.25.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 03:25:09 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/hugetlb_vmemmap: fix PMD split TLB flush race
Date: Tue, 10 Nov 2026 19:24:56 +0800
Message-ID: <20261110112456.62827-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

This can create overlapping TLB entries at different granularities
that map the same virtual address to different physical pages.

Serialize deferred PMD splitting against PTE remapping with init_mm's
mmap lock. Hold it for write across the entire pteify batch and the
final TLB flush, while optimize and restore remaps hold it for read.
A remapper can then observe a split PMD only after stale PMD
translations have been invalidated.

Fixes: f4b7e3efaddb ("hugetlb: batch PMD split for bulk vmemmap dedup")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fbdc3410-a4cf-457e-88e6-684380fbadfe
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba8e11e399b2..ba6559bef742 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -158,10 +158,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
-	mmap_read_lock(&init_mm);
 	ret = walk_kernel_page_table_range(start, end, &vmemmap_remap_ops,
 				    NULL, walk);
-	mmap_read_unlock(&init_mm);
 	if (ret)
 		return ret;
 
@@ -308,6 +306,9 @@ static inline int vmemmap_restore_range(unsigned long start, unsigned long end,
  * is skipped, the caller must flush TLBs after all pteify operations are complete
  * before remapping the folio's vmemmap pages.
  *
+ * Note: The caller must hold init_mm's mmap write lock for all pteify operations
+ * and the final TLB flush.
+ *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
@@ -318,6 +319,8 @@ static int vmemmap_pteify_folio(const struct folio *folio, unsigned long flags)
 		.flags		= flags,
 	};
 
+	mmap_assert_write_locked(&init_mm);
+
 	return vmemmap_remap_range(start, end, &walk);
 }
 
@@ -358,6 +361,7 @@ static int vmemmap_optimize_folio(const struct folio *folio,
 	if (ret)
 		return ret;
 
+	guard(mmap_read_lock)(&init_mm);
 	ret = vmemmap_remap_range(start, end, &walk);
 	if (!ret || !walk.nr_walked)
 		return ret;
@@ -392,6 +396,8 @@ static int vmemmap_restore_folio(const struct folio *folio, unsigned long flags)
 	if (ret)
 		return ret;
 
+	guard(mmap_read_lock)(&init_mm);
+
 	return vmemmap_restore_range(start, end, &vmemmap_pages, flags);
 }
 
@@ -559,6 +565,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	if (list_empty(folio_list))
 		return;
 
+	mmap_write_lock(&init_mm);
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
@@ -583,11 +590,13 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
+	if (nr_to_optimize)
+		flush_tlb_all();
+	mmap_write_unlock(&init_mm);
+
 	if (!nr_to_optimize)
 		return;
 
-	flush_tlb_all();
-
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 

base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f
-- 
2.54.0


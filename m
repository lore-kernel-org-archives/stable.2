Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CF346E43
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236763; cv=none; b=TqPv6s+fivg3vPUvyMH27w1OP13AZz2PaHL+HUTbQ2Ghh217fqT54pv3x2RrMsWjZiW0ioPRT8vgoLJMTcgd5/81mhLZkH+9q6HeHWLLoFSyRyu0BwwYSAqngikQU2/lGrl+w4/xaW9fZyh7vgB6qU/WAkiCVSfQOMvbHk5xuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236763; c=relaxed/simple;
	bh=FFo5YVsN5RJTkQY/ToQ5Yxygot9j3fKn+T8WvprpE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWUWmdg5wbb5hZ9pBIgYCRqCzuHmV0KjZxi8mjY6Iu/vCFsWdGoOp/B/0884Oh9RweiGK7CJJcPy546VD/vXlL3mMi42rrKMnE3Rs+lZ/qQUSuUkLzA7WTsdUTdr7/kATQeqcSMiDgUGGS3u8zEYEnVCR20gjHi21DUwaNq/+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MvIHTsmB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MvIHTsmB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842307473b5so454759b3a.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 20:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236761; x=1781841561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLckvYu5EL2MaiuWaMvOvK8C88YkCBw4frh2Emu1ze4=;
        b=MvIHTsmBhUSl3/N+RL4IOIs3LDxos8NdcD6WI3EBazC5Y0nXuIWaaZbE8j3uY4lZbU
         TGWBomM7h7Pu7MkXJHrXUhSgVBNKGlQLYCWpkXKgP3P8LhH4DGIJ6HuqpACIT7Vi2e9S
         7F0c4DzAYZ+NMjfwLX2IdfMWRzXlo+3bAqCxgY+TbjWCcq56/RkdvEAjLQTcYbF19M6Q
         /jwpLIxbZ60Nh+7tY0s3hOaYHKRO6GZO8md9ON+AW1djPnoQdsoWpSdN3UVDMIOfhyRm
         1Y1zDyTeeJKKEQEtPNb4rl/5EvFhP9NOMx81AbbmtaYITdcuRhJkxLMAShPihGGAP4Rr
         pJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236761; x=1781841561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLckvYu5EL2MaiuWaMvOvK8C88YkCBw4frh2Emu1ze4=;
        b=gcpq4rBn253spQT/1G+Mj9xi/y1aHUnAvjG4GI7PP1fDYQr4MEbyPpWQ6sSZskyH2Z
         aliFv+sopkjiQIwr8c3YjuljYJbfcF9IbiAVmXhU6mQnNc1ZP53Njnqzn1MfnF0Cvg4r
         GxvQln/+B9cdbRsTlP4iReHGNZCgnd++6CKIbOQLpvz0RZXX7P6sz7GgsKvIa1s+b59A
         TEsQu2C6O+7lQQF6fF48aj1G/HxUOrBVo0OwOM9TH0H3yvNM8zPbF4zcIMPc/excJxWN
         2SxyBUpSFeHZ3+0tLwjpCSgZPwErVnPzmzpDR12ohv5yx4DDE0tE0eOM0A4WIgumZ6Lt
         Z8BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wujODrNvG5FBj4AEuN3P91UBENgnhHBMQmRskWxpvbP4e4Fz9w42MGQtoOjWn+A5GQLp9pnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLpVsXubePlpJcdgVQ9yd2FYfp9608liTMysOjexIuAa/WO7N
	y90Ewl9teLICLjtGN2C7b2U6JyYJ9A+ziWUXWzoGNCnE43B99J4IhaglEJfKl3Otc9o=
X-Gm-Gg: Acq92OHqwZ8HeXBr+ew8M82aqJTYxOgMklPlj6G1mPBN018mAtQgNPDmIKdQyWEQhTD
	ziIaXLOqo8ZtXlnh1LsIcxtGBEJKTnI37I8rcSbyJ+OiSQABKBVqftfYZVJ02oTeEQMJc2R6+AI
	OyavTpcgYXetnHdwQN3lA3mKCR2L/6+9E+PNL0Qib0WWAnbAmgYUBk0s3dXf+NBVt36bc6FjB9Q
	ptvg0NufCtovS1YOrbUUF6W1oeNRj6d7zV7MgHL0Z9RV9rQr2bFBndn7Nwd+sGQmMEJ9Vmx2Cip
	mTTG+TETxrH6sUx2fkdjvHiqfeukWenMH7c0apk6UffkeQHei/5wo/qWxpct1fyCH0qB/ltbR3m
	m5Dh1NFcOmDYmJV6A0cnUycbdkvPZg2RhWq5GhMPbvzHEtK0snD4QTW5LhnK+rHKHv0+YGUmi49
	pve2ZX39svH6eOZT7hhcLodaxU0th7/Eu1X+IhIfNARt4=
X-Received: by 2002:a05:6a00:2d19:b0:842:4f49:71bc with SMTP id d2e1a72fcca58-8434cecab4dmr1092576b3a.46.1781236761177;
        Thu, 11 Jun 2026 20:59:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:20 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/19] mm/hugetlb_vmemmap: Fix __hugetlb_vmemmap_optimize_folios()
Date: Fri, 12 Jun 2026 11:58:46 +0800
Message-ID: <20260612035903.2468601-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handling
bootmem HugeTLB folios.

The section number passed to register_page_bootmem_memmap() is derived from
the vmemmap virtual address of folio->page instead of the folio PFN, so the
bootmem memmap metadata can be registered against the wrong section. The
helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it expects a
page count, not a size in bytes. In addition, the write-protect range is
based on pages_per_huge_page(h), which does not cover the full HugeTLB
vmemmap area and can leave part of the shared tail vmemmap mapping writable.

Fix the section lookup to use folio_pfn(folio), use
HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages, and
use hugetlb_vmemmap_size(h) for the write-protect range.

Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb_vmemmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c713c0d2593a..ea6af85bfec1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -635,12 +635,12 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			 * mirrored tail page structs RO.
 			 */
 			spfn = (unsigned long)&folio->page;
-			epfn = spfn + pages_per_huge_page(h);
+			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(spfn),
+			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
 					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_SIZE);
+					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 
-- 
2.54.0


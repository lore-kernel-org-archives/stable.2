Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810999;
	b=tkgbU8lhZwIAb+n3xaG3L4HamYrfAUwHinF+oxP4LOiwjDJ+a3fUbZO9d8vPx11Kdxeg
	 RmIsM/rb6FtP61CIrKkKR/hfbduuD5SRN7loyWL2v2se0wUDRgnR382S9St7DmzV+6OQy
	 tOFWeFyD1M7YhnybdcUZnRPAxL8Yq3WKNT1LHfmUAaMB89pHZ4lBZwmoOuOoDFmnRSjZt
	 m2KYys8ys3zvbOCYAqx2m4F+RfzqZD5tZL4txbuASe4nHHykJIkLYKiEApszf14WFasgR
	 WwDrRr4rv1WlpNWPUrsTXz7KLRQEIxjkqY//zywSw8V1mc097OBBgvG4IfwdFfH2PDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810999;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bGG8fJWiVLN4rBloB6l6LP9fwezC9+FtgrPy8Y99xzo=;
	b=ZMhFYwKY+BRLr3yJl1cHNGTZeZ0ySuLo3eFltw7VOKTCl6kB8qURmCHCp/JrfyFKmHy8
	 /aqZwsJ9XG6IOhTTCP/IjdW05j41tuuoTU5a0KnKXZzV0FnaTMoRmhdL0xHzrOokLvD+V
	 Md4TzeohhWIMk1+lVajwvUR7UMAJbPCwhOL0ujE9UskMCXdZZNS0LP9Bf/SdVN6OCQzvs
	 Kdx2sYLkUsx5jDM/XuCtIO6IRd/rvkjQ3gIS1fluxxrt2jGRmxomAdLxOjtKIJpiyl+0t
	 RT8BBT3BVMu1TiONcwZaoFv+I76qDQhLDiFPxkm9JU4d3yNlMfdkVuvWqynXNpU4zVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KLMNlCQY;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DA606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940DA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KLMNlCQY
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X9w4h4OFbGo7OVBtANSE6gWeEcgqw70QG2tZixDGK8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794810996; v=1; x=1795415796;
 b=KLMNlCQYhmLCVnrnszOFfT+rMJ46gPccZaFkEkubwn4U2M+vgPiciINABWPKugWKs14mhBIH
 ij75iSZRLFHNteZ6AlN6T6Is4aXESdL39gkVwAKWZU59oGNVU+OQB1+AW8N7+aEJXFGCTF7u7lQ
 ADpFOIQs50WBkNU46ymyF01A=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c888f79b8281b000;
	Mon, 16 Nov 2026 06:36:36 +0000
X-Mizu-Trace-ID: c888f79b8281b000
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] mm/migrate_device: avoid leaking folio references during THP splitting
Date: Sun, 15 Nov 2026 22:34:55 -0800
Message-ID: <20261116063624.1382944-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261116063624.1382944-1-usama.arif@linux.dev>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
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

migrate_vma_split_unmapped_folio() takes an extra folio reference because
split_huge_pmd_address(..., true) drops one when it splits a PMD.

However, migrate_vma only holds mmap_lock for reading. A concurrent
MADV_DONTNEED can clear the migration PMD, or split it into PTE migration
entries, before the split helper takes the PMD lock. The helper then does
nothing and leaves the extra reference behind. folio_split_unmapped()
fails with -EAGAIN due to the unexpected reference, and the reference is
never dropped, so the source THP is leaked.

If a THP is faulted in at the same address inside that window it is
worse: freeze = true replaces the new folio's mappings with migration
entries that nothing will ever remove, and drops a reference the caller
never took.

An existing migration PMD is expanded into PTE migration entries even
with freeze = false. Use that mode and remove the extra folio_get(). The
reference already held by migration keeps the source folio alive whether
or not its PMD migration entry still exists.

Reported-by: Zi Yan <ziy@nvidia.com>
Closes: https://lore.kernel.org/all/DLZ48KMS7YG8.3BTM0UUU8CTU2@nvidia.com/
Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/migrate_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c6..3286bb8a4b73e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -920,12 +920,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	unsigned long flags;
 	int ret = 0;
 
-	/*
-	 * take a reference, since split_huge_pmd_address() with freeze = true
-	 * drops a reference at the end.
-	 */
-	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	split_huge_pmd_address(migrate->vma, addr, false);
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
-- 
2.53.1-Meta


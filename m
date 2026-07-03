Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80A3B3C11;
	Fri,  3 Jul 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078956; cv=none; b=HAQh/0Jc4ZL8la4wZUjsa7gYakCyzY3C7cySIYU21v/xaknQrDxK02qxv7ZBQ9342QdI/Pc52ISVmw7MGPfo+VSU+XC/eT5RdslhJPCtZYfID7KteNCSHjsgrw1jYd7ghQuqpev4wJPX6rW1DamDvJRtrM5qeLZegPXXJ5HE1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078956; c=relaxed/simple;
	bh=AQZap/nO3QOWdmBME1D8S/QnzexpIaKu0FkaoBnYCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF1zkS838qAQD9Od/uWrfMq5+t5ZTpxHfrh/5q22vR5V9N9UEuoL8EeFiw/58ev3umzjLXZkQk0hK0BOF3d1Z+tiPGndRyCWVogO3tcpmp5liTC2JMHfb72a5Blrdyih1kkGgGVVGbpxp3SaKzdpYX6o3jvq38sN9e0jvDYIbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ChmdZguI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ChmdZguI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8CA1FC4;
	Fri,  3 Jul 2026 04:42:29 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 746DF3F673;
	Fri,  3 Jul 2026 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783078954; bh=AQZap/nO3QOWdmBME1D8S/QnzexpIaKu0FkaoBnYCDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChmdZguIcwq+gbFANUj06T8ixoLKDm7ElI3FTPt3rVY2FhgYf4zdNmCdcx3GXnc09
	 yN1Wyvali5Hcevy9BtFOkUpoEe0FB+kPRvhN1aTyCsK4Sk/BC5ZEc6eLBJGlQSsUO4
	 3lO31Kmy2StVH9amzSTZiDwRvCYmBmM+cKo+ypuY=
From: Dev Jain <dev.jain@arm.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apopple@nvidia.com,
	rcampbell@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	ak@linux.intel.com,
	nao.horiguchi@gmail.com,
	mel@csn.ul.ie,
	j-nomura@ce.jp.nec.com,
	pfalcato@suse.de,
	tglx@kernel.org,
	dave.hansen@intel.com,
	jpoimboe@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned addresses
Date: Fri,  3 Jul 2026 11:41:54 +0000
Message-ID: <20260703114202.365553-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703114202.365553-1-dev.jain@arm.com>
References: <20260703114202.365553-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

huge_ptep_get() can be handed a virtual address pointing to the middle of
a contpmd/contpte mapped hugetlb folio (examples of callers are
pagemap_hugetlb_range, page_mapped_in_vma).

The arm64 helper rewalks the pgtables in find_num_contig to answer whether
the huge pte we have maps a contpmd or a contpte hugetlb folio, and
returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over the
contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
if the addr is not aligned.

Fix this by aligning the pmdp pointer down to a contpmd base before
checking equality with the passed huge pte pointer, to correctly answer
whether the huge pte is the base of a contpmd block.

Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery mechanisms")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 30772a909aea3..8e799c1fe0aa6 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -87,7 +87,7 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	p4dp = p4d_offset(pgdp, addr);
 	pudp = pud_offset(p4dp, addr);
 	pmdp = pmd_offset(pudp, addr);
-	if ((pte_t *)pmdp == ptep) {
+	if ((pte_t *)PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS) == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
 	}
-- 
2.43.0


Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD2410D1B
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681000; cv=none; b=a5RxE2hzjVsE+gEYM+lhnSo1KYznWXeAHsbTZYAvBWtdZhkigHOL7Sx2PMcCiTZPAbQYrub4zMmbhUwY8ZhVqAm+nDYXQhbRt5a2238wNGeD72UeSxN2zDuXUC/tRj6fpDTR3gXqXe+oaddVzGC2jidSprPTiFcpL1P7ERflaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681000; c=relaxed/simple;
	bh=LQDcjo4puHASaMWvmWKlMKWUn+DHMhyXa6SkGs/PyzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ujw7ORxLKJJvg8Mj03PLJdWxniIystqThH50sWkElwS83fwdra2+jnbZCFh7iA7jMnIMqI40lYXQ+SqKe/UAmWvZtt2xY1rlBa401fm2ZEKWn8rbpcCpu7dttxQDBNbEmPyLlhOBKJWRMf+TFLHGywR2kisGxGWHELwHeaud+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ON5e/gYP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ON5e/gYP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783680996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/976mRd2cZjP/VBKknODLU4xXVA+kkf4lFHLX7WcpM=;
	b=ON5e/gYPsrMuRZSzRp8rV82PX86lwCFqokmnB0Fb/eRWDcDOdHDA7Byw3uDGk8Qdb7SQeu
	GdbJtqhtHLnndIcI9s/sPXUo81ZvaKgj5rPpt4Apj4mDdRDXl182WUzkxklAZ4ewoNgWyX
	37P62V9h9hG+gdAkOCdsEDWluabss4I=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	npache@redhat.com,
	rakie.kim@sk.com,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org
Cc: sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mm/madvise: skip device-private PMDs in cold and pageout walks
Date: Fri, 10 Jul 2026 03:55:22 -0700
Message-ID: <20260710105557.1987433-3-usama.arif@linux.dev>
In-Reply-To: <20260710105557.1987433-1-usama.arif@linux.dev>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

madvise_cold_or_pageout_pte_range() takes pmd_trans_huge_lock(), whose
pmd_is_huge() check returns true for a device-private PMD. The subsequent
!pmd_present() branch has a VM_BUG_ON() asserting migration is the only
allowed non-present case; a device-private PMD trips it.

Skip device-private PMDs in that non-present branch and continue to
huge_unlock before calling pmd_folio(). Downgrade the check to
VM_WARN_ON_ONCE() so an unexpected PMD softleaf logs a warning rather
than panicking. Drop the thp_migration_supported() guard: it expands to
IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_SOFTLEAF), and both
pmd_is_migration_entry() and pmd_is_device_private_entry() already
return false when that config is not selected, so the guard suppresses
only the case where the warning would already be silent.

Potential trigger: an HMM-based GPU driver races with
madvise(MADV_COLD)/MADV_PAGEOUT: pmd_trans_huge(*pmd) reads true, then
migrate_vma_pages() flips the PMD to a device-private entry before the
PMD lock is acquired.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9292f60b19aa..c557023c3fad 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -388,8 +388,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			goto huge_unlock;
 
 		if (unlikely(!pmd_present(orig_pmd))) {
-			VM_BUG_ON(thp_migration_supported() &&
-					!pmd_is_migration_entry(orig_pmd));
+			VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
+					!pmd_is_device_private_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
-- 
2.53.0-Meta


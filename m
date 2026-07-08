Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC81E98EF
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471216; cv=none; b=ZkpPUIr2C3H8ZV43zQ2wd2XympSZUKOSFADAulOr7QD7iwrnQWMudweBnS8962yd9auFG+iSrqwvcuGQmQEuE4MQIU8VgSZRYvHxvMMrf89Etcl4Gpe5oCJFhtJvOUu5jbH/ORj76qYIunMEgyIdQRi5vC0Q9WryFKUX75anSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471216; c=relaxed/simple;
	bh=Z962C2eAB+XgIMb5PId0FRyH4PYHckFHojkUmlX2FdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ymf5J19W5KIPV161tzr7gl1tQwMQUkJscSnUDM1toEkHVTp6m/3vjA8AwJadWjp6RsAnDfLlN+gfKQfhR88yjb/Qm178GfuRZdfh/1I24IARLuaPVsh2P/YFfuXHAOM6AgLV58I7okdEqumLYTCbwNK3MBavOYJ+eKHhv34TlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1QNtpTQ/; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1QNtpTQ/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Fk3MIUF4Gkn1bddZDU2fyqFtcDmI5XfWkObgOV3oB24=;
	b=1QNtpTQ/NKaR0DmWSQ3Ej99RRFEfxx4IaVhMQuYjlxPjBfGsnZHzQ98hYS/a8HKZ9YVZVjYvY
	YGAVGLDsa7efarxebUpAt/Oey0XrUbniEOXY/npjcqWIlqX4mevMNK+nhWdMqc/2MFgD5dMqhRK
	ampRiTPJRFb3j0/i8gYFq0w=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvzXX6fllzKmYb;
	Wed,  8 Jul 2026 08:30:52 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F23B402AB;
	Wed,  8 Jul 2026 08:40:09 +0800 (CST)
Received: from localhost.localdomain (10.50.87.83) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jul 2026 08:40:08 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>
CC: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua
 Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
	<linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE
Date: Wed, 8 Jul 2026 08:39:55 +0800
Message-ID: <20260708003955.4024340-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf100008.china.huawei.com (7.185.36.138)

pte_pfn() and pte_dirty() have undefined behaviour when called on a
non-present PTE. In migrate_vma_collect_pmd(), these functions may be
invoked on non-present entries (e.g., device-private entries), leading
to potential crashes from pte_pfn() or incorrect dirty folio accounting
from pte_dirty(). Fix both by guarding with pte_present() checks.

Fixes: fd35ca3d12cc ("mm/migrate_device.c: copy pte dirty bit to page")
Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
- correct changelog and Fixes tags, suggested by David.
- cc stable, suggested by Andrew.

 mm/migrate_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 052167f9ad54..6e711381f092 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -411,7 +411,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(pte));
+			if (pte_present(pte))
+				flush_cache_page(vma, addr, pte_pfn(pte));
 			anon_exclusive = folio_test_anon(folio) &&
 					  PageAnonExclusive(page);
 			if (anon_exclusive) {
@@ -432,7 +433,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			migrate->cpages++;
 
 			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
+			if (pte_present(pte) && pte_dirty(pte))
 				folio_mark_dirty(folio);
 
 			/* Setup special migration page table entry */
-- 
2.27.0


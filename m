Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915A36DA03
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567923; cv=none; b=tIY21LxSfEHW6f2+8V5QScGeEZOsfT9z56H8WXWMAfUxyPiy49gsgZPf2qsGLdWEucB3FTa5AybWXchGHkdNMXGRdsyuULvMPX2ZBC0b1ZacT8RILTynjtvj06rYr17LI2k74/YcTIA4JBp7JB5zwuTn1Gd0n0avqSqzdlLvzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567923; c=relaxed/simple;
	bh=sdTICWsF8Gg9xVi/txzCViLwgo5JzWiDEQ+TQjrHAII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeiR4Tdv/pIZCpAsdSRQpJt7hhosos9SDOS5v5DXPvDfvi5+C0JuO1a4uYWwEHqjVMydJ5b65R1kEdn2NzzQaKLYxlIzfq8LOTEDVe6No6e11NXZHR3HjYuQqRV7b7BUiiJqD0vIdW2+Fa8yz8wwL3AqIVsvI2fVk420U0H4tJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzBbQoQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzBbQoQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324AC1F000E9;
	Mon, 15 Jun 2026 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567920;
	bh=V6isKLp7UB5A1v0a+aE494HpQ0z3KBILeG+CKaX5+cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EzBbQoQvBbTBuqZ2cBqCBdowcejUr5wyiutJ8ghaHJe5KQ72xSceCKIU+vHwBbx6/
	 TUQpK4u38041xE54/RcJIJYTnAj8zpaBzrfDM7aR4IMUB0TlZ0xKaZy5g1HbPH30A8
	 NZVPhXb/GqaneHZQbhTHtNkXxIwButUKZw7n4iMN9veDBopbED8T6WMr2VFBgFEFN7
	 5n6X6IEHutM8/4KBE8hGEpzXG87wn3sbgeWh30bB6tzEFyvu3pefLQTKtj7ScWGYzZ
	 0LMRpoMRW2WX0QQdn0BL/6bitrTmpPzp9QcsloKvt9o+FdL76RWn9xRzQ+xw7szgiV
	 a9DMEwFoCQhOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yin Tirui <yintirui@huawei.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Chen Jun <chenjun102@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yang Shi <yang.shi@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/huge_memory: update file PMD counter before folio_put()
Date: Mon, 15 Jun 2026 19:58:37 -0400
Message-ID: <20260615235837.2561574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061509-perjurer-trio-7c92@gregkh>
References: <2026061509-perjurer-trio-7c92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yin Tirui <yintirui@huawei.com>

[ Upstream commit 8d878059924f12c1bc24556a92ec56add74de3c8 ]

__split_huge_pmd_locked() updates the file/shmem RSS counter after
dropping the PMD mapping's folio reference.  If folio_put() drops the last
reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Link: https://lore.kernel.org/20260526101337.1984081-1-yintirui@huawei.com
Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ changed folio API calls (folio_remove_rmap_pmd/mm_counter_file(folio)/folio_put) to page-based equivalents (page_remove_rmap/mm_counter_file(page)/put_page) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2c118713f77126..7023bdf4896055 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2085,7 +2085,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
 			page_remove_rmap(page, vma, true);
+			add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 			put_page(page);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-- 
2.53.0


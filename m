Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A91624D5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579837; cv=none; b=PPUoTBIxXs4Tty/BWNeeyqf7nwCPXapFebCw7x3oe2WS5S+FuEcxa4VKbUDb5odzeY7HY0DqfOdNVT17K7Pyb/nggwc7g9Gs5+rd7qoTVWc78EnlpYyZHlvDPXf1a0FH/lTIoxDX/jQOxxRjUQ76bev2jZixm/YpotTLJjsl09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579837; c=relaxed/simple;
	bh=MYyIY46OEMj1V7Xegxwtiy5iy1803yy/qq+NtwanQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1SzWGHA+rZNoaeGAjXT/z9TIo1DhzH7U1oZZf8RCXZP/HI41jHMFycQJW5a3nXYW0mFJEmyiySqt20c06hywiPz3RH1OOXME/BwgDNnjrxjwjrUELW/1nTTaji0m8urVnal2oq9N4qsAe7m+Hj+UXM1IqtWmFWHpQrwbM9iuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de+CbaBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de+CbaBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389261F000E9;
	Tue, 16 Jun 2026 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579835;
	bh=S4Df92AAoIYYlD3L2J6HEgIR23h3GtBrYG7PSjziyiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=de+CbaBZBDxbAITeG2SpvbXxxtEsN172LOFTT0NmYIgFK0qOz4Up49CV9xna94m9s
	 wYB15uuJDVBuWLVyqOgVx41PMVtBqp09BnUGnZgDIwCIHRPSHGx/13gNy4QB51frOc
	 VX44JeuXAyr7afbtL9M+dh52WCvwe+8D+p1o+K8P/Q58OGVcANfi16XsEo1UmG1SP+
	 wemL9rsc9sk0K0s9OpUjYE5n/12D6Cor7zBKKAfs5F0cwsMEmSM1ieBQqMRKcQGN44
	 p51VT32ht1DnwnFSXDLyLer16F7Tq0WrbPgVi8bs0SAy/dtPK3pS/PCjyNwDIe/BSe
	 Cyj4gMjxMWJYQ==
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
Subject: [PATCH 5.10.y] mm/huge_memory: update file PMD counter before folio_put()
Date: Mon, 15 Jun 2026 23:17:12 -0400
Message-ID: <20260616031712.2780366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061514-baked-magnolia-385e@gregkh>
References: <2026061514-baked-magnolia-385e@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 92550e398e5da3..fdcf89e3b1d27d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2066,7 +2066,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
 			page_remove_rmap(page, true);
+			add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 			put_page(page);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-- 
2.53.0


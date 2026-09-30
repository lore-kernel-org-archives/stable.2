Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1DBA45
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726651; cv=none; b=GJVNo9UOohoDIr2mlo2gYXCahoQ4kXXwrPuyhJdhRf/qT5eFy1tFA3PTBHHUoheqqJqtlVyjkyrpfeWLUZbsJPbXcHSTZ14hpnpkYcDlhzWpfouXWIG36u1FVb+Mq3ypDZK9etM7TQmuKe1K8mQfq476cpo6Aj+gsmNXEjNeaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726651; c=relaxed/simple;
	bh=hegpg6y9a4FPtQaZIGBoMhcIQW7N7P6EMEzXzNd34fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qupz3OCM3qBuGNoipe/zoTTWAM3WbjPNz4T0tYqTQXpT9PHkw4HfPeyHGdrRS+Q1PmdxIMK3dH4FOIPaZq4wLkzNKfvb35nOfp9CbUMQkQZFCAatCAiBqMAC/DbtgtV4vJDOSaMrpE8Z8uiYmMeHopiMwFXaX5p59CrtNGVUyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILNXmeoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILNXmeoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED3F1F00893;
	Wed, 30 Sep 2026 00:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726650;
	bh=LOhlq4fsT4eGZR+iWLJvAUf/i1Cu0nezia2WpsImSJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILNXmeoc/kAVuYBTV/WYHYI2YFGGZl9jY4OUIePcvRfJN3tGG2waiUQpPQGdtAKmH
	 2lZ2CeVcpbZEofjCgQoFTD9GofriSNVlr6CG1SwKx3KEoDU6knHkvgzKPVp6MUPP8l
	 97+cWesJNkgsNzmZMQX9qz5NgpdioaSxW4ZynsyWvHcC4nuXEp4y1N3upiPV64KxHh
	 aj3wRbWHiqAKX9j8wnN2fXw9vq9lmgEyNqqcZrRsQJYrD89fZZ/URqrpXtwh/oFJ3e
	 wQjcoCWO0+sNGAK8Mkz5gRrce1fXcYV/IKb/DChEO8JQKZlAk1qxLylXtIDBScsc4p
	 yfFktvhzIHEOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 20:04:04 -0400
Message-ID: <20260930000404.2861901-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000404.2861901-1-sashal@kernel.org>
References: <2026092905-greeter-coke-d3db@gregkh>
 <20260930000404.2861901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit a363c62a653cc8b3e21da9545fa4e028ef50f9c3 ]

dissolve_free_hugetlb_folio() doesn't check
hstate_is_gigantic_no_runtime(h) though remove_hugetlb_folio()/
update_and_free_hugetlb_folio() silently bail for such folios, so it frees
a still-listed folio and, on vmemmap restore failure, the
add_hugetlb_folio() rollback corrupts the free list.

Link: https://lore.kernel.org/20260823044118.1097121-2-xialonglong2025@163.com
Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Codex:gpt-5.6-sol
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c7a1faebd047..879c9663302fb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2363,6 +2363,15 @@ int dissolve_free_huge_page(struct page *page)
 		struct hstate *h = folio_hstate(folio);
 		bool adjust_surplus = false;
 
+		/*
+		 * remove_hugetlb_folio()/update_and_free_hugetlb_folio() bail
+		 * for gigantic hstates without runtime support, so dissolving one
+		 * here would leave it on the free list and, on vmemmap restore
+		 * failure, the add_hugetlb_folio() rollback corrupts that list.
+		 */
+		if (hstate_is_gigantic_no_runtime(h))
+			goto out;
+
 		if (!available_huge_pages(h))
 			goto out;
 
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C7125A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726644; cv=none; b=hqSLSQBKOyGdcKfFwX5PGKD1aW/8OUgOb0lizxUNeodRHsJeJH44V1mms5fLCZu+rKLnCK25usSa08d29NlfbU5wYFHruIUNVW4/YNwn7AP8THusMHTmxjnbxH0fbu8QceD02kDrhymfC3esk6ts4ZZEQmZZZKC5X8rNpx3F8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726644; c=relaxed/simple;
	bh=+EtPrwGh917kW/U83niSsKt7jNNxkC3hpOcroybv6Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3tLmIH6DiFdIIq+ZAWlnZMrBq641IQZXftlJcuSQYpsH8NgR+9d1Cy/lyATGFU/bU+mf3VjkbOlPDhkzhxHvlP24kWNxqAeEdZ2STxURE7n507PtZaqEDlEvOmQfdI1lK24D7A4bgRhg7PkCUyM4cJ8yJXIRnYtoGo6jK/qCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSYwWcBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSYwWcBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA71F000FF;
	Wed, 30 Sep 2026 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726643;
	bh=2LnV8ST5oDdKfL8R/6xaK6OM4DtpFrHwoMDuMQkS9jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSYwWcBEeTJ3bzV/L3ezT25t6Y4Bv1flGjKhn+I5XIsQ5IT6tTObB37kxJ39mFBs0
	 dTwIvKFrkHZQNjc31FzoKKuhe2AbjSyZtrYNjTIxm8AGva0WpcMXzI6eo4IBSxJ8PL
	 LYznEZmUG7iHbjYM2IHOI6YTUmODP+EG9R5qMwOENgkYY8R2g6NQVze9eZzVpTAnJf
	 FNDzPN5wbagAdByuvMPwqIdX7e6H6Se+s3HmViwWqUpo07MmISg9LUzj11F6Pk/8DB
	 xsEpgNwH7mOtoAb49PflJH8YqdNBelQHUgB+3x+LTnyvmvvGHMx40q0izFRS//ga8I
	 e/aw9jdj5JPWA==
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
Subject: [PATCH 6.6.y 3/3] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 20:03:58 -0400
Message-ID: <20260930000358.2861523-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000358.2861523-1-sashal@kernel.org>
References: <2026092904-singer-headphone-fefa@gregkh>
 <20260930000358.2861523-1-sashal@kernel.org>
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
index f5b434f2ac474..02bc36d52e2e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2314,6 +2314,15 @@ int dissolve_free_huge_page(struct page *page)
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


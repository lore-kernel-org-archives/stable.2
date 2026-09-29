Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761F3DB64A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707622; cv=none; b=Sd8eO6zZCRnmQm6sA4/NfGd1nIGWtJ/x/9MtKhgHPBupcGUdjPZ6LbfgnaNmqvzsfLj0EOH5kFRrYTvfhS5ANk+svVLMOkNPHBfBMaCIlTteu5DNJPIOj3RcsxufhDWoDVDb6U3adRtzX9GsD7HFVfguuRvRpeMOVG+OlYm6QQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707622; c=relaxed/simple;
	bh=2x/qsyWf6spbxOu1Eh3777efLdHiV+SzjQBwmoW5NCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+lqnoG8+/ZlouiQbZITPhqmhtRJLCDBeQWfDYfQznGsACyOVn5CITM3wdEELxggQDnygrwfrC2qUWiGEXt+VZeHs3KY3P1XihnKCCNd71JPLXv10DIhhwUGuWWIDEo2wXqgIiAwCy8rv6D8x3LDX6A4SYxFFaT0wzoOsIkkads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShxuxQSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShxuxQSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F62F1F000FF;
	Tue, 29 Sep 2026 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707621;
	bh=D+x/49x2ZxHii/LQWT/9eWAXeAKFm6PxWp+5WixfN2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShxuxQSiYXHXoyQmpFpaOG2STeA6GfFzQlc9eE4KduxP30KYVI475qZT8ORhOmxUQ
	 KvhfRCc0kONecV8083DDqEQ0nzvVr3uODUdpNfC+DWgeZ5F57bdbWa++0dySEaTE24
	 b673lWJc8aMtPlk7L91RJjiEdDvvDIDLq4DHFtb7brKcdWiOOS+5xr9tvj3m6l6QAD
	 uautYupm+L1B2NP5ZQB/w3Bvy66IVV0PTA86Ns/aAZpEWgqYTBheuzS+5QlVJJVnlm
	 SiAhAHmegEG/hEnA+e+8pbc4Vmu0cFn/k0yebXPWb+48VPkbzozBgadBR3E7TV4NRe
	 lxDpTiW7v0wUw==
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
Subject: [PATCH 6.18.y 2/2] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 14:46:57 -0400
Message-ID: <20260929184657.522286-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929184657.522286-1-sashal@kernel.org>
References: <2026092902-struck-raving-0494@gregkh>
 <20260929184657.522286-1-sashal@kernel.org>
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
index e1ac2f5dab8f8..aa0fe95f416d0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2126,6 +2126,15 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
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


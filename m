Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0136B907
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711257; cv=none; b=ayUT4iigv80nCUP9W+qynAeBGHv6fZjAAAmgIrDUIVExbD5Z4T9Jdr3ooA5J/Tek9e1ESgAxMZUhVZ98BeGJYD422H46OfK9G5lU/DH9PGqWb4WN62Ks9/n7nbNkyS7EEwLhoEliraN57t9O3do1YYe83edN4gZ1aOX37OH6hJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711257; c=relaxed/simple;
	bh=i9rv+6ej2xzoLbxegfI3iLuut2xJMVuwBwVYYlq5PY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaxgjfkzL+5GWpIZOFvyOn90QgiPC3xJB+xSGQqkYuxk1zvO289+j2fRKQyJescFmfU+ec1bEOE9UcOxJ7RZB6vPDvwtUjjxyk1Xguck03NwfYg8Hbx1eqf307hTVXciMYJMFOxDiIyAzFYF3hgadCyp8e0uRH1MAz3y5UyAVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drChOHU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drChOHU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB801F000FF;
	Tue, 29 Sep 2026 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711256;
	bh=mgqMx8pRX33RQq4r6+z9aG8F8LZ7xWNwbxCYidaJQYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drChOHU9exFhRzzQ52Q70g6Gq2vtoJbQ+D9k0anP1j0/jGxc8dzBNzaeGD7UBwm2k
	 XhK04rwRDHcqdln14lQHoM5XL58NwpIIYFy2LC1hfb5mreDJkFgdYRfDNY8jCau+de
	 vhXv+MrEVnYBaUBohI3l/okfi+XGTtGpHdQJMP/w5vOeV3N4deSXWmjl9GNq2zmq4X
	 ax+yB3fGPff2XJWUl6ZDnHtlY9KS4w155LSLW0LPr/xUUX5D4MDICUWpffUZjz9lWj
	 jXE1cGhr4Bk2kVf9ayXS0UC44s7Q5mLmkc3/cuNqt2GHNRwognXzoGI0Us+jNNv4qS
	 CBD3ows4b2n9w==
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
Subject: [PATCH 6.6.y] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 15:47:33 -0400
Message-ID: <20260929194733.835453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092904-singer-headphone-fefa@gregkh>
References: <2026092904-singer-headphone-fefa@gregkh>
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
[ replaced unavailable hstate_is_gigantic_no_runtime() with hstate_is_gigantic(h) && !gigantic_page_runtime_supported(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd8752a5356b7..6004261af2e80 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2303,6 +2303,16 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!folio_ref_count(folio)) {
 		struct hstate *h = folio_hstate(folio);
+
+		/*
+		 * remove_hugetlb_folio()/update_and_free_hugetlb_folio() bail
+		 * for gigantic hstates without runtime support, so dissolving one
+		 * here would leave it on the free list and, on vmemmap restore
+		 * failure, the add_hugetlb_folio() rollback corrupts that list.
+		 */
+		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+			goto out;
+
 		if (!available_huge_pages(h))
 			goto out;
 
-- 
2.53.0


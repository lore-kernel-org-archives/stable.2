Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25956855D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710213; cv=none; b=Q7PIEsncSfvkgLBR24OtSIrSq8wHRgddGzYE5u65/pUb4kf6p7RIRdPVdw2WpBAFO3bEpBTvjAQMJ96yMqI6SMRBGhp/EWlm9gsY14o+7U6n/FHJtsLOYur0+XkwTkORrEiCZYzlnzA9wHuaSH/yKO89i6PfMVbxH6hGRDlShVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710213; c=relaxed/simple;
	bh=8794efWG/aMuhPFfposeoKJFH3MtDLm35KMWUjtX+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHzmpcmMAux9oS8qvuRKpqdtgvLR5QW6Ixw6w6cnNhGA6y1kYuLyr7JbXZZdo4uM2byDg//4cnYxwGeDqD2UGfELb4M2/e6aIhgaA/HGosEHujIToKyNmn8tMhKV9hNncyKTXfF2PfJaJpEBqgJm9oNtHMy+TFcyYBphAnElffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3P4OxpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3P4OxpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402371F00899;
	Tue, 29 Sep 2026 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710212;
	bh=pDNyASWfMSmgm1BxU4pkM5/Tp7kmkV1ODEGN5oMg2IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3P4OxpM9PnsbbSgKGme7oyu/sFsQ1CKFHZx6vuRtHuRC2Zjyyqnj7VFu0Z6rh2mp
	 QC06L+Hb9dhqHyoL0JAg0lhxUslTBgrq30sHXjIfJ7EzIafFVauObyZDhqsYGgsiNl
	 pZ//Io3StGhNJpIeEsL7rN7hOLhQQiqwhaiCf4I3aaqFHm0kaGjNBuP1cvejF7yo9G
	 AaFK19gU4O+l2icMFdH3HNAx9/fHfFDsgAWNO6sy3EG6cKnLGSdKsjINXHRRuqHkWf
	 RJtQV5YIFnbvpvLPra9QR/cl6QBin8pdLpp7FPALhZppCzTvOSWvluQ9/5wQvKAaN4
	 sLuTw5/J5WGPw==
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
Subject: [PATCH 6.12.y 2/2] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 15:30:08 -0400
Message-ID: <20260929193008.822363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929193008.822363-1-sashal@kernel.org>
References: <2026092904-charbroil-reroute-765c@gregkh>
 <20260929193008.822363-1-sashal@kernel.org>
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
[ adjusted context in dissolve_free_hugetlb_folio() due to the missing adjust_surplus declaration. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 763044653ff66..29866761d06f1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2212,6 +2212,16 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
 
 	if (!folio_ref_count(folio)) {
 		struct hstate *h = folio_hstate(folio);
+
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


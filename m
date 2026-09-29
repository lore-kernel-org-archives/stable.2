Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18E569F1C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710217; cv=none; b=iiZunQx+gbLbMyFIVD+YulDRpQTU55Rpn1Dd3EhpET/9CCEMEvI6lQZUNga9eX8Qh0eWLm/Hxn75QaYmKSLwdXg86JwSg88PVs0OAMhmUOJ0GMNrQIdbEH561WQ80n25yoP6zb8wJSFrJAZelMVMWqxNdJIIfFMewn2LzHnugck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710217; c=relaxed/simple;
	bh=+SzaZvrwiT1prm1o4jirHQEjfrldvkAG7wiAnyF3oZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXJRno2wRXqn+Z36Oino/UATTEJMLTmEcwPpjaTfsheU5faGvkwbekifE4O7bB7lz4m9vktaAEWP7YRwVM+dJFMY68aEOUoCwLaPqBFYNwPYtDwjS9UJ2RGL34UM1OQI5XJNqbF85m82LrPkT2iJdarZBeDzdR9p+LNJa5t/qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHpn5AIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHpn5AIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E3D1F000FF;
	Tue, 29 Sep 2026 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710216;
	bh=03dhnVc9VlqBl+6rzyTN/nYqopJftWglGKxSG0Qikpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHpn5AILy2cnmpSxi+YNXacsIy6if3A/OdnQ9iAaJwEOlCMKrVIxSlFCf+dhQHX+d
	 qMpbOlrUjUdSHQ8o5At6FR7B8UpDheYD3hDtEMWTTEPchDRE2uvtC0lYttu2VttDtu
	 SIlFSX48JD+RclpZMWM63bEgBwA0BdreQkMzZmMBKVvEXdlo1X+T7kvZKbfiAcDHlI
	 TbC1FjlsOEOFSAs3dInsN3vX6OKICj8OaJWqDHcRbedLTonpdEPT6+9D390rTP2sdh
	 yn8nzGe25gB5Cu7TAtxxCmCJ37Y9YX/KiiVmtNf6U3Mydw0WQ2HEfxH100nhtn8XN0
	 t8g41BXY9mExA==
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
Subject: [PATCH 6.12.y 3/3] mm/hugetlb: do not dissolve gigantic pages without runtime support
Date: Tue, 29 Sep 2026 15:30:11 -0400
Message-ID: <20260929193011.822493-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929193011.822493-1-sashal@kernel.org>
References: <2026092904-charbroil-reroute-765c@gregkh>
 <20260929193011.822493-1-sashal@kernel.org>
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
index 738e1c9f7c588..5766465e6b4db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2214,6 +2214,15 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
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


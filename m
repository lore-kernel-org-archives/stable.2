Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334245;
	b=JlXYE6L1eW3m6CO40kGFd75BiMlrsbINJPS3wZJo2DIbpbsUjHgA32/b6dIXqfWZT1sX
	 XAEIH1DXRSiTetzXiA8zSLyKfrfooJKFMYr+hfTvplDTCk7UFdCPtMxMqv0WPrvJq7p20
	 XOV7TfUfUeEfAjJ8+DM4cjt9emCuCWp4TU5Wqpf9Ct9QnGXXZgPZbMRWOHgA2LYepHD5h
	 KrV06+X4LQ3+es1BCEVUz411c59Mvn6AwPqbEFvmDgrZjqmvVJXsA/KpQgXsZppyTqr3P
	 iro/gvJKmyjkQJpfTLpWuOoF7j2bYE4zBabt35Ry/7U+XZOP5iRMZGQ6XnIn/55DxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AVeHV/0ig34Jvn/XnhURaJvAE59/0nVBt0wdtY1TPbs=;
	b=rpqLE4FPb0U86RwYKX4Jm2rvMvK3uJ2AhAe8dpDqGWUwIR15EFchV2Lbrtm8MFu1Iz3N
	 YKP9XM2zkEhcBDvpLJHqCNbw75U/QYMx45/v7z/fdlj6e7JDSOCtoKm6QZveTSEToCaPh
	 4bi/B2jCAKruZeANi5Aq6HcXwcNFarz6pt6zrE4jxlIYqN97t2vQWkld+ess1bXGIGTE6
	 2uPLMttPLZDPH8Yase6ORUEV3Dh4nJz5CCSkj/QweY6FzpKlPwC5xMpkgH+aSM4BqTibz
	 XhVEqpTpnJ6pt9nh9OHdbECpR2qguHtMKR4OfT/w+b4zIMT6Xmr/w5k9W7K6xTKWT5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqRNYstW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1703606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqRNYstW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607461F0089F;
	Tue, 10 Nov 2026 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334245;
	bh=AVeHV/0ig34Jvn/XnhURaJvAE59/0nVBt0wdtY1TPbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqRNYstWTbYsjgY5TcvDF+tctoy+dcG5/+CCtX80rMEX5RbEHHjkJh+XAtj915Ipx
	 5b1XiucCry9t1IKHR2xzKFPdtdQwiYq0AuzocdcxD06sGJkAD1NLgrUKt9GzdVQOXX
	 iRP0aqzjWM7K9PT/cxQgNEW6zYtyTcrL3RoY2Cnrh5HraN2tU34FHq8nK4jjpKA0/X
	 7vLdLv3JQFLFBG2pXy6K17wwTDSHcrvyLshlcc+ctG5wTZrOV6zlAMrBX1uTDVpDh7
	 30yTWoMd+EMmxMKH7vfkKS7UKKL4KQai4S/eCCG5/o06F6Ta2nQKTdttf4lNg2vhxh
	 9BHvW0jIyWEWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <roxy520tt@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vega <vega@nebusec.ai>,
	Ye Liu <liuye@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_table_check: skip zero pages
Date: Tue, 10 Nov 2026 13:10:43 -0500
Message-ID: <20261110181016.3096221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053208-failed-6.6-33afd07412a1@kernel.org>
References: <20261107053208-failed-6.6-33afd07412a1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <roxy520tt@gmail.com>

[ Upstream commit 33afd07412a1efe5b750a3fd5eb0272ebdd12761 ]

page_table_check_set() accounts pages by whether they are PageAnon().  The
shared zero page is a special page, not an ordinary file-backed page.
Read faults on private anonymous mappings can install many read-only PTEs
that point at the zero page, but page_table_check currently accounts them
in file_map_count.

That lets an unprivileged process populate enough zero-page mappings to
overflow file_map_count and trip the BUG_ON() in page_table_check_set().

Skip zero pages in page_table_check accounting.  They do not need the
anonymous/file mapping conflict checks that page_table_check performs for
ordinary pages, and this keeps the existing counter size and page_ext
layout unchanged.

Link: https://lore.kernel.org/1f8848512d2e3ded944f8d595c29faee8fdaeab0.1784645969.git.roxy520tt@gmail.com
Fixes: df4e817b7108 ("mm: page table check")
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Cc: Ye Liu <liuye@kylinos.cn>
Cc: <stable@vger.kernel.org>
[ sashal: Replaced unavailable is_huge_zero_pfn() with is_huge_zero_page(compound_head(pfn_to_page(pfn))). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_table_check.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 75269bc47547f..4356aa8563c5b 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -67,7 +67,8 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_page(compound_head(pfn_to_page(pfn))))
 		return;
 
 	page = pfn_to_page(pfn);
@@ -107,7 +108,8 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_page(compound_head(pfn_to_page(pfn))))
 		return;
 
 	page = pfn_to_page(pfn);
-- 
2.53.0


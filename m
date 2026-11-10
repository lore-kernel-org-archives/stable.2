Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335541;
	b=ml8KZVqgStRiwKAaArywDLJ5pp3Dwux9BVSSNwWAhFatTZYrERKKSSoOstBIdDmoY3I6
	 o1wLliMij5sITD4OVS9fn5gFoSsSr84BedeguhOxW0Dth6O/98ueLmmj6ffJOF/C/SyPc
	 zyNFTC5tlFoWJu35PbNbeDoqrWkd39tbZ3uVaE3OhLocn1Qm5sOz9fCty1P6R39Up14bo
	 AXodyXy4g/hkrLCfyjN24Nsei3HddPCZ83/cwzA+a4fwP0DPkBmSUs23vM1s3/9iaFgUM
	 jmY0dBPg19ftDdjZhVFdMB+ZW8RK4c1ol3cAvVPT6zUjDuXThhM4uZEwLqXgVUAQNyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v2KCY7m2LIQNOtRQIFxykWIbAEe2ELAmdUP5c2kD5Xg=;
	b=5nYj/QMb1FNk3CFAXa6yhjmT7SFXQSUzC1FRgS7Xg41/2qFLgcoUJIG6WQCCuDj/p+f/
	 VP0i3rjaE7ao1ul9HBAwkO/MXaanC94NHgg7KbNMC38lZmD5+Jcq+e1cvtSB5GiSdGI3i
	 ARfEr4jnvGtK/wpJVSJu3WKpdO1cRwkFoWSgP4veDRG6oVOyU5KVHhNVEAoh/h8yTWIfx
	 4PtWVG0rS15toQGk05aWTs870vUNTuE0NK4wk+USGT/BJCM3jaLKIRJY7/+xRYcCWNTCZ
	 9kd9tmO2uMT777nHnMq6/lSDUnGb5VSP+5YEho9Z/y4dG6F4MXRscU6nNj6ZV7Ynp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHOZ8OUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F118606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHOZ8OUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102EE1F0089F;
	Tue, 10 Nov 2026 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335540;
	bh=v2KCY7m2LIQNOtRQIFxykWIbAEe2ELAmdUP5c2kD5Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHOZ8OUVphYxbT1/YTOyurpiMG6W8muqKgKP+RufcW+Qim6gxH2muMuRYJ8/rwhwK
	 qNVM/KPwMqZWmusIpFPNXBpuxLJvrxVwXwgHW2rG+WikK5kuMA+gzmSMNUZDOSOpH2
	 Hq0Ii9FiI+Pkez2VE47+m6XV0KJ/AGUPFwUhYXHxB0uTmxjX4AddzphhoM36o4+0vk
	 G+3fWxL+pwzEg1fn5aHq933XZX9Anh4lmI1IjK6CR4PQxZQKYHKBSSdRbTsiUXNkGc
	 E8k86lJPTYRDRe7C45rZX6VGxbuntwJi98vBkWxbGGBl3I483pvsELwB2dRNN3kNBq
	 YUpqtcMi8XF2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <roxy520tt@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vega <vega@nebusec.ai>,
	Ye Liu <liuye@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_table_check: skip zero pages
Date: Tue, 10 Nov 2026 13:32:18 -0500
Message-ID: <20261110183156.3135507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054455-failed-6.1-33afd07412a1@kernel.org>
References: <20261107054455-failed-6.1-33afd07412a1@kernel.org>
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
index 451114bdc3401..631470b230358 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -64,7 +64,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_page(compound_head(pfn_to_page(pfn))))
 		return;
 
 	page = pfn_to_page(pfn);
@@ -105,7 +106,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_page(compound_head(pfn_to_page(pfn))))
 		return;
 
 	page = pfn_to_page(pfn);
-- 
2.53.0


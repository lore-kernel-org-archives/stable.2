Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333255;
	b=APSiSL69jnGA5QtNrDhSRRIZol0WLxjg872TLGPAXQ5opubnDnFSyjI9NhYKVXh0osyw
	 ckHJsNyv2kKpj9+PSOB00+OIJ/zjb6QA+90S7KpjqVcXcfPSf/inK2v94v+hbB2bCeo4K
	 jtHmB+ZBrDHmZBGs76cHp7r0V6noRHJc5nNmyNcxys5nAi31cDHi/Siuyliz5KxCU7crg
	 dpOKRS5NGbJ6mvnZeaSb8aTliawJuKBfmjarylE6eUtrxfFKYi4YNOIdGpY3UrS7zxlTG
	 oF+6niShRYzMAOka5LLwyGzViaqLO4mGBQbS0kbwAlb6eJU5rajKWTtTcuTbRn+wFsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333255;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vzbjzKuQrzRPtBdYMB1Q6wfdhJUh/ZNDkq6muU6Gcig=;
	b=Y7g9daz0WSoo9xQ983JBn4khf6hA0JsSpnmlcLVJdNDPhcJ9hUSiNq5Q5h1PjcXraeyv
	 vHAO8NvmSniTTjHeRDQMfqcRsiNf2NeFFIKTE7UQDthxbg587U5iPMiXFmFYAIMy7Avuf
	 Kjjl5ZxNJgllkaajqBTJZ69/BJeHjzHSFMKRtoTc9KY0IyFe0RgHwVWuZtdTtZLMKvOXI
	 SGDz0o5i5/oxTbErH0NRA+2lqnblqY82Ul54MvsMqMHKsxNpfGi7sh361AnDflh7s5hK0
	 J6rLU4hV5+35yZ9L0ZejW/H+wr2ZqP8OIv30DppvHNDirp4v5+THYDPOnrWiqPabUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMfVvYBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMfVvYBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE71F00904;
	Tue, 10 Nov 2026 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333254;
	bh=vzbjzKuQrzRPtBdYMB1Q6wfdhJUh/ZNDkq6muU6Gcig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMfVvYBdY1duRB4WdlebBA9Dh70OHjdFW2syQ5HkstKKx42PQisMGJN33QVGHLWQw
	 9VJxnXgkpdEnvOCN56m53jcdSvswtFrbLlMBgfUqgqwFMXOr2SKeefUu0OqN70YDTI
	 aMA0DCgpnlkMOi65Wy3BIjF2Skx55ut2AHsYTHMCQZSm7RI4sAISaYyXmsQK/QV64G
	 V7I95JDa6l/u8cjACTFJe3o+GJy0GCOYExmL1FY8jRnSvCrELQkRMSDNW9GQ1a76rZ
	 yZ1vOzJ/7PeOCEuqYRPuQzeiPraPUQQkhPG25+/UcUtrp06JEWfZT0sJ3xgGESsHGM
	 9UqsmB0omyfTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <roxy520tt@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vega <vega@nebusec.ai>,
	Ye Liu <liuye@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/page_table_check: skip zero pages
Date: Tue, 10 Nov 2026 12:54:12 -0500
Message-ID: <20261110175354.2995296-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051936-failed-6.12-33afd07412a1@kernel.org>
References: <20261107051936-failed-6.12-33afd07412a1@kernel.org>
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
[ sashal: Replaced unavailable is_huge_zero_pfn(pfn) with is_huge_zero_folio(pfn_folio(pfn)). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_table_check.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2efa910eef23e..1076f8e055f31 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -67,7 +67,8 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_folio(pfn_folio(pfn)))
 		return;
 
 	page = pfn_to_page(pfn);
@@ -107,7 +108,8 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 	unsigned long i;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) ||
+	    is_huge_zero_folio(pfn_folio(pfn)))
 		return;
 
 	page = pfn_to_page(pfn);
-- 
2.53.0


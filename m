Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311500;
	b=t5su3wjrQU7vq9Q7OrxBumRZRmEC+1rHoYP3ktR3uzPridhiDKr2GPsgIwwdAWhC4CVN
	 2aemLcsJUC1C6YfoLzAhYA3FGq926xvLjLJ6bNBTPUYVma6E7WEqUcK30jpemUWSe4zXK
	 sUcOqu/zr+7PHsc36AjJLX3g24Q5i/bL8vEE4jJ/nbtCvGEKbr7ENxN7MfqSWic0h7NWR
	 aojjFmgLIJugvvkrCuKPDWg25+0nXZzmpcRYroiWX8LdsefvJw1A4n2FKYzDbKQw5MrDW
	 hJai5q2yNRXFi85JHlPTPLnClKLdfmQS46yyVLDh86TeXn1ev28jmFcbHtbUkHHNVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311500;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w8IApesAfeYSZgOZIJ6aDU+FSco1TstGhSdiWeuwk68=;
	b=kvAiz+U5oBBveXpD0f96FJDNI+1sLOAgZx/i74KyonjnyYmLa+3xLQpvw8HYd5KYw+hU
	 2Ha7uOCnUtqsIzvXQ9QhwrprY+S+nV4eHX1hpPXCANlRWOhk456lkYyo/OAa5o/WH7WnD
	 dDnXbXpoTZUAYG9Dasq8f0kLvszjJ0+ZG1KxFuUIqyIEQiYQ/kdzC7/gNUPb9Rp6VlfqZ
	 EB/eK8WGo5oNZbA93ss1asTZo4oBALbLQ8EiP13T8wupUpqDl0AgQEguPINolhmSJGBYk
	 +GzSKeO8E+87/fqRAQoCNciDR9sjq60k/5LM7tHgf5TtDE0/del3KIfGPojCDbZdcqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8OfJR63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51660A383D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8OfJR63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E401F008A2;
	Tue, 10 Nov 2026 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311500;
	bh=w8IApesAfeYSZgOZIJ6aDU+FSco1TstGhSdiWeuwk68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8OfJR63gKYDTveYyxOLTdgvQ1/JiC11trKwfMJIqUKWDxtccW5WypE4iEVG1fVLh
	 PecrEWtBpd9gki9d1Gw1pl3HcgVJWqo7CeeROly7uyi79boCWYZE3X+wWFMejeyo9m
	 70MoxYAftH2/PiD0LU+4EkWMcltxI9MAhsTjYAE9i1jfrHf2/uVubmIDdRegXIDNem
	 RcA76HD6bB8irRpVqqEUZiI1dGEj319oDBeBdnGX4CR/Xbk7PjAiu+dcDZbnm2Zh9/
	 BEPkL6SRGoZZNJW5H2Uv4CYLvn+8KamadUGgNS/+Xq1def1YWoNBDre4YLJl6hdRWV
	 XoMluD1ah/L3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Xi <xiqi2@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/page_isolation: guard compound_order() against racing
Date: Tue, 10 Nov 2026 06:51:36 -0500
Message-ID: <20261110115129.609167-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115129.609167-1-sashal@kernel.org>
References: <20261107051925-failed-6.12-4c767c5dd9bc@kernel.org>
 <20261110115129.609167-1-sashal@kernel.org>
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

From: Qi Xi <xiqi2@huawei.com>

[ Upstream commit 4c767c5dd9bc3521fed11e6fe1d52621fe5abf7b ]

The PageCompound branch reads compound_head() without holding a reference.
A racing split or free can cause compound_head() to return a stale
pointer, and compound_nr() reads the order from that stale head, leading
to out-of-range shifts and making the skip distance meaningless.

Read the order explicitly with compound_order() and validate it is within
MAX_FOLIO_ORDER before shifting.  Also verify the derived head_pfn against
the legitimate pfn: the head must not be past pfn, must be aligned to
nr_pages, and pfn must fall within the compound page.  Bail out with
-EBUSY if any check fails.

Link: https://lore.kernel.org/20260825120549.966271-3-xiqi2@huawei.com
Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Signed-off-by: Qi Xi <xiqi2@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_isolation.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6989c5ffd4741..702db2e28a77c 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -401,10 +401,28 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		if (PageCompound(page)) {
 			struct page *head = compound_head(page);
 			unsigned long head_pfn = page_to_pfn(head);
-			unsigned long nr_pages = compound_nr(head);
+			unsigned int order = compound_order(head);
+			unsigned long nr_pages;
+
+			/* compound_order() is racy. Cap it at MAX_FOLIO_ORDER. */
+			if (order > MAX_FOLIO_ORDER)
+				goto failed;
+
+			nr_pages = 1UL << order;
+
+			/*
+			 * compound_head() is also racy, so the derived head_pfn
+			 * needs additional checks to make sure it is valid.
+			 * Otherwise, just fail the check. pfn comes from
+			 * __first_valid_page() as a legitimate PFN, so use it to
+			 * check head_pfn.
+			 */
+			if (head_pfn > pfn || !IS_ALIGNED(head_pfn, nr_pages) ||
+			    pfn - head_pfn >= nr_pages)
+				goto failed;
 
 			if (head_pfn + nr_pages <= boundary_pfn ||
-			    PageHuge(page)) {
+			    PageHuge(head)) {
 				pfn = head_pfn + nr_pages;
 				continue;
 			}
-- 
2.53.0


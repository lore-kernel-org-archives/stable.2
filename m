Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046779;
	b=gs8VtoRAOu1xYNlyWf5Zdwu1myHkWnJAcnN/8grwqZ1/7H0E5vRLoL8va0gYzy5Aru5j
	 AD/AwpeK1mN0Bq+adD6xeFwKmWz9XuTAsefZSad1WIS3GE+ZnId4fwTr/DO0LRS1jlUXa
	 OOUvCheTnAg/8kCFBAvEo1KTnxzUXNbzf71HxGC80qUK7K+xgPRC0n4biWfmCid0GzTRE
	 xZ1Qx8Vv990fzQyJz6Sm79nhq1HQ4vtTGUidJsFYkygToQWu9x5MG53s6zpY4uJ9QdlJ6
	 6Uof79EPZw2Bvp8G54BhyFHlA1tXhhhY9mmghfUtPt035On1/hxZQB4Nj3S5GxAA7IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EYSkzzHYXIb41OWKWJV6qauHH3/LH4Y6zZlc08hrLU0=;
	b=j41d2JizXAdcwf/SLgljTp61VrKXfdGkjfpO6S542V5w4Jal7n1JNjY70T5ztv8E0XZT
	 xNTfjZR3RnNyfCFmX1NTOf/ZUBEROXLx99flBs5QFtivjcxfg2PDpHLbCwNk4UxvQBQ79
	 sxM7Y6sFJEKXcXOMc/An1MwpUcXlmcXS5ZKcwFPuz22DunWeklHuld3EBd9HtqMl/C3UI
	 +SB/5HJ/XoVuWLf+dbPmHN8ILe/SPz6W5uxk1P/4NzuUlpSl/JgxLQGJCL/48HeHdLZMH
	 D+DGFuUhMXmpiMrbAvyhSzO2JsLwxL1qLQ8igxZZtZucwIsJLm9nly3Z4tVUuwRtslA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AplRwNIv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0460606D804
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AplRwNIv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975AE1F0089F;
	Sat,  7 Nov 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046778;
	bh=EYSkzzHYXIb41OWKWJV6qauHH3/LH4Y6zZlc08hrLU0=;
	h=From:To:Cc:Subject:Date;
	b=AplRwNIvYSNY8zTkFNmykhvyOjhDeID5o7ZrRNztQDSyg2CJRm3rg2dLwcQnfOyv+
	 pv128PjsPhRriNy/Ll6v2Ptd3H69olwqUmr86svmykgQziLIGmwezsy275BpJsTtYR
	 0oO1hlTRvZmSeFBbh2FitiSGJnTJIkIclVW2HntJJmDfyyFbpOU94/4arfxebUH7nh
	 hrPYbElx+iifgtGaGlNhKkcgN6AQLCYeDTfNXMswIQpcEocTU5HCKQY2jwCdySUgjF
	 rzwX4TiqXuQtqeBUpESrA36dy6V6/1RIOh/eZz19AQ7odGTNkwyaJMMKBD4/XV+5oe
	 tseOS5UeqXbpw==
From: Sasha Levin <sashal@kernel.org>
To: roxy520tt@gmail.com,
	enjou1224z@gmail.com,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	liuye@kylinos.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_table_check: skip zero pages" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:36 -0500
Message-ID: <20261107051936-failed-6.12-33afd07412a1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 33afd07412a1efe5b750a3fd5eb0272ebdd12761
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051936-failed-6.12-33afd07412a1@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33afd07412a1efe5b750a3fd5eb0272ebdd12761 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <roxy520tt@gmail.com>
Date: Tue, 21 Jul 2026 23:56:38 +0800
Subject: [PATCH] mm/page_table_check: skip zero pages

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
---
 mm/page_table_check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index ed3e1a76f2664..143a918c0bde2 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -67,7 +67,7 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 	struct page *page;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
@@ -102,7 +102,7 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 	struct page *page;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
-- 
2.53.0





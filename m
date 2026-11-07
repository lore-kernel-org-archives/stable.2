Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048297;
	b=YpPqwwBgYPUoGW//vG3PBoRGvL6ixeQLX0hAmBs0qWPdhRHhNPRguJmTFcceVjCjYsBw
	 kys8sXVrpY/d9XprZDUFlKmdl09OKrbk31VHVX9dP8VHsGvY5imJYbyRLJPzcL0RQZNy2
	 gLxSqSUXHXrmRcYuDnWeDi81L0bJR7tF8S2HlNh5ztbExmCi66xxNvrvUqMKlYPQ7JIMz
	 MKeh1kflMrNY3e/EZc8WhV4tA49FcmGsAM+JdPQrec/YmU0AJEnstLr1LUjaxE+Qup94B
	 yHyfdtPP8GRcO2CfYzEY4wvpNIOttoOSBRS3pcgNX7VFUGUk9PLKafSIfvMFGlTv7hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VVoBd55RRNu9PjAuVfYtAV7TV5d/Rz/YmY8CLzYFyeY=;
	b=3pz5LWWtpMx8LdQ9SWHRWNk7PFyUrZBAOpY9mxZ7gO2LEOB4p47eRGFnmDxpaG+Jj6G9
	 VX3PSkyulGrVIfvJtWsmhNYTUszPk6RGcZmio7hHnzmQ+2e+boFOYxGk1HxVkDF8Qe4hV
	 HQKHxRa5exodFj9gTdQgYr43RzmJ7qpsaARwzm8WXCp27diiYfqlF/x4cBuREo83Vtg1b
	 dubunbSKpxpZb+J/5EYMy34/cC97Sz/TYmNgixaBWQ6X/idx5pcJQ5pDP49WrKjmMKgjN
	 biDSgNDBOFidpsv3r1kz/YlX4/BuUB+4pwnewTcXhdrLsr9ggGHXBj9ihMHPgRaLvXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYkebGCA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYkebGCA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC711F008A1;
	Sat,  7 Nov 2026 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048297;
	bh=VVoBd55RRNu9PjAuVfYtAV7TV5d/Rz/YmY8CLzYFyeY=;
	h=From:To:Cc:Subject:Date;
	b=gYkebGCAtuXg9VWYGjFQefSDYKSAXfRq9HZcHC0NxqKBuDQ+YNpJCJhBJgcAdVosL
	 xQtgyHLlLGttAvdo33KPN5WL+SOC9Fodp7CZSzoNxkmKT4o9zZbsCnND+a34yYb+4K
	 OKaQnYjGBSiKGGCpBwTTqmEcxe3ct3fSUs0L5Ck9F22hVod5YHcS1BeZm/6+k5rSYc
	 eIDKvJn75SUxDfBb6AC9XcseytDW5EfDRIrRLiMtalCVq9w5nHjk6aSXdpJg3AVPzR
	 z7STM70MXQJEttVDbMtK3xQwByGFH5ufhN9G2ibsiTknwJ5/nGi6/eNqLkmealo/02
	 4MyZrRjfg+P8w==
From: Sasha Levin <sashal@kernel.org>
To: roxy520tt@gmail.com,
	enjou1224z@gmail.com,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	liuye@kylinos.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_table_check: skip zero pages" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:55 -0500
Message-ID: <20261107054455-failed-6.1-33afd07412a1@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 33afd07412a1efe5b750a3fd5eb0272ebdd12761
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054455-failed-6.1-33afd07412a1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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





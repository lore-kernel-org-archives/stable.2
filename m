Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE121D596
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550213; cv=none; b=KFhyKqQ5jkeS6w45DJdvKhBfHjkS6fmOK94go9bBuXzbr5QVnrdadERCRUE6raUzzJ0tgXIlnfI5dY2qUMBKoO0s+s9cKfkXJ2xaBx8ISxgw78SAEsvfMUMIFf9SF6bAndo/LlBMgq5H0aU/3/7DEzKbNj3x7eybA5zhZRO+YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550213; c=relaxed/simple;
	bh=pKZtcY7s8BKoTGS0uHvLQiuPSzwRBP9uZ/ADqfcnH40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZbhiAnLKUmLXDi22qB8hLdtaX2EykNstRl+bJFmy19FI7m8WmHD+Ts81np55McRv22cFp5XsGhiyf5HQSEU8YIzYGKPBhllxJiPg6W5LvzHQnLKMpHtYOWHLZHLsEMwVUhFK2EHLxvQcKo9TZENHk7OqsAZ2JGV1hARq5zZ8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ediAjHmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ediAjHmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1144B1F000E9;
	Mon, 15 Jun 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781550211;
	bh=6eIAYBQbkcdv9t2ktHqB++NElMOL2b5Lt9PeL8KjFq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ediAjHmyQN9C41dIAyJhple2NqsCSF3WMeMVmFhJm3pbp7VmVV0fgbKiFR1u+LvXn
	 K3vKCb+NF23vWKGiV6h1Ifuy2qJFQk2rmjO9ruPV8ZoqJ39tqPRbKPvdiJY56yzUfV
	 Y7ybuVdUDpBK0cdzr4Y1rJFdXohDyxou9AKAAacoO4J7Yw9sRiZt+rTjtehkcngL0S
	 9AIBpZRfVp77SeyI2xHNMWU1FhaZHDLkcmdIX6Gdp7Ys0sa02tcRt2gm9tEtSy5iwE
	 f8ReIDewn78iNo/Eg1VE4naXe04D0vhlbr3nvYTxoQt8/95rrH4Xpltc3IFp2OibXx
	 J0RMbAaghLFRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 15 Jun 2026 15:03:29 -0400
Message-ID: <20260615190329.2368312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061530-traps-spool-56b7@gregkh>
References: <2026061530-traps-spool-56b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef ]

damon_get_folio() speculatively calls folio_test_lru() before
folio_try_get().  The folio can get freed and reallocated to a tail page.
In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
Remove the speculative call.

Also mark folio_test_lru() check right after folio_try_get() success as no
more unlikely.

The race should be rare.  Also the problem can happen only if the kernel
has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
has been made so far.  This fix is based on only theoretical analysis.
That said, a bug is a bug.  A similar issue was also fixed via commit
3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
reference in next_uptodate_folio()").  I don't expect this change will
make a meaningful impact to DAMON performance in the real world, though I
will be happy to be corrected from the real world reports.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: Leonard Foerster <foersleo@amazon.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/ops-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 0b75a8d5c70684..cea4401e95a35e 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -23,10 +23,10 @@ struct page *damon_get_page(unsigned long pfn)
 {
 	struct page *page = pfn_to_online_page(pfn);
 
-	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
+	if (!page || !get_page_unless_zero(page))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
+	if (!PageLRU(page)) {
 		put_page(page);
 		page = NULL;
 	}
-- 
2.53.0


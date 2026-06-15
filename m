Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98B3B27DF
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552259; cv=none; b=ClJiqwq2U95FQjtppxBGC0KDlwoCDw3niFjMzeYMbO8EbHXjqO6tbaoPSws58sv6IbuExi3n8QE9kgBO7naGrvam895A6Z+R8Sral3LkrdtMU7RK7Ncz2jCOyiidcSsNRerczCVRELEazHPheVVRfx78exCx7aUs3lTpTvvXAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552259; c=relaxed/simple;
	bh=hrO1p3Flczlpy63OXoBUozbBPvL34FX/Zlc6CkozlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIvB5z1JV7nDtwu+3J6i6Z/zha1aAuBEWAsPmjg00Vm5+1kLkReJf8qLc5iPXMpD+lRMpDzLwosOvHNSoG19IMw2OBsYnVOOUvX3ZyzhRBkvmLIWqpAVBZcs63xSXcap/+8id5Sa3TYFOjYXZO7/yxkDWiBg3NFaDru9fFj7xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXNsInsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXNsInsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9751F00A3E;
	Mon, 15 Jun 2026 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552253;
	bh=MUJPp3ptbuvo28ndU79lO2ZThsS/yPH6M/1hFz/JeOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXNsInsvTPahxm1DUtIYG6nAtVPR6iFBLQvvyMlxzQkex7hwoUgNVU4S3BbUeGQow
	 6bX1DVRjEmVfq/+OC4+sNczs17I/UEvenuYWMdF1V6efcTcFogXueTT3SYsxvBv7Yw
	 mbPiMCiyu+CVkWY0M/z7g1kEuVpYn8k8p/cZedqh/XhVe1HGFlTCSdNi2Jmi77PrDS
	 fisF6BM/MhVcvNG3bCsx283Hpt1FNKoh9Wke/iqaL1YmXMbTyae3T2j31+JW88mENM
	 Ws0sqWph2ey08fNwiYYgf3L8xAYziwGa7HGibJXsFrC8/eE2uIvW2PsHeLi3vaNX4U
	 Y2BQ2FlOzZbMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 15 Jun 2026 15:37:31 -0400
Message-ID: <20260615193731.2389762-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061532-emu-stopped-b17a@gregkh>
References: <2026061532-emu-stopped-b17a@gregkh>
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
 mm/damon/vaddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6d8036671e60e5..dbb0f0fb2e598c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -383,10 +383,10 @@ static struct page *damon_get_page(unsigned long pfn)
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


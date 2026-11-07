Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046768;
	b=f9CTjSinA60kMde5DaQVOcibTcxXknqg1cl5VxaPS2SvWbFBS+DNHkg7EsQipQf479HT
	 BKRHUHL8w6c3a0po5suEVuXvQSLNYPl2CIVmeAJg68QaeTIcb9YE9mOCbBl2PqHgO5HnD
	 J2x0XIFjoEItqJn+IQQVUzBmzzwB1iwAd3qAI5mIXaS2IpLcCX5wGHUIRVudAlhPg21k0
	 CFAYHrXFeSQFV7pzfuHPcacaynxNxb9sOfBMhNP9M6BjNJL9vJA7BbIFq8pnS0nE4AupI
	 3732cAP884hbYpJtSLDGk49MG9b6PDTjzKVu/tRGdle4lehjyECXXN6e46NYL3B8TmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1ZrSbB5G5NqS41iVZ8/WIn8mCWXKmYNEhF6hc8wuQVA=;
	b=x60jSP1sgIdi1nG0HiNqHDmqOcyWKT7hiqLenr9WCPvKYpZkBeaUqyD3FUZ8NNWN8EvZ
	 68pXdGa6pzWyn9cqWszywcniAG2JbtNaGteGtQ6jpWmHsm8TiFcCDQIc5WCowHAWLL0i9
	 CdLoKMGTBnNJAGiyMwCX8bwaNTfFDgk8lQ8vTx5mNqG0DoRChMJ7h1xUwnCokqcBBHZ8B
	 h6FNSQjBL1qUUIY+bzJpyIY4KsdcW+bfEOpL6XQiJJ6OKWqXKXEQtcZXLZyHgx7YqP8oQ
	 7CsW+R1G5aWYEA7Yyu7hae232SG0v0+1S9yIR6HxHO6FezJYyPJEp17scMyNJXFg+sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmWE3E1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AB606EEB3
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmWE3E1V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BA61F008A3;
	Sat,  7 Nov 2026 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046768;
	bh=1ZrSbB5G5NqS41iVZ8/WIn8mCWXKmYNEhF6hc8wuQVA=;
	h=From:To:Cc:Subject:Date;
	b=LmWE3E1VMlqQVgOyknZEtQD8anE2WCZPNFfBO023et7NdbO+emjf/ma4KEhIFGLRc
	 P4hrAN/lqSec3rSZnXq/+w5RJuNjh3qLYExiDTlFDNbapOBuOekTpnITsl40/vzFe5
	 zZvbEngGCMI4uPh1+2lzEkadmcYVtXqJ4c6fZ4FSVTh64vqm+QL6wUqZSZ9WzdDC3U
	 Vy85c2WFUiBgpCbjJChPkaUoumA5ffsQEiCL1HWST0y5i98OskHiGkw10lqlPCS+m+
	 yfbqZveVEP5l23xEVAsi77Zh2ZAkdTJL6mIPsa6XJZup2PovwOSNFfbSsKA8GRDQoF
	 JHW7H7wM+HDEg==
From: Sasha Levin <sashal@kernel.org>
To: xiqi2@huawei.com,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	wangkefeng.wang@huawei.com,
	mhocko@suse.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_isolation: guard compound_order() against racing" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:25 -0500
Message-ID: <20261107051925-failed-6.12-4c767c5dd9bc@kernel.org>
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
git cherry-pick -x 4c767c5dd9bc3521fed11e6fe1d52621fe5abf7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051925-failed-6.12-4c767c5dd9bc@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4c767c5dd9bc3521fed11e6fe1d52621fe5abf7b Mon Sep 17 00:00:00 2001
From: Qi Xi <xiqi2@huawei.com>
Date: Tue, 25 Aug 2026 20:05:49 +0800
Subject: [PATCH] mm/page_isolation: guard compound_order() against racing

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
---
 mm/page_isolation.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e4ee998c00f3b..5aaad037384e4 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -419,10 +419,28 @@ static int isolate_single_pageblock(unsigned long boundary_pfn,
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





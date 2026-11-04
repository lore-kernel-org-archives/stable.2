Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834653;
	b=rod+pr/1WdrbVhNOwY6n6aqbBUbohzwyNifQ2zTFMtqDJT+vR6C8BHvZWYbYEPApSqI2
	 dC+H4EPUWvDNxGVrrB8ldgNoRzXRffm3bj/egooeSLA2tuW/dxLZjv+0EIS9T0u6jYR2Y
	 7XqNvqN+s+hWe1GHJw1bkg/KyDgZ78f/CKK7D1H/ScRsEihbCQD4uL0iKz5z9xQfVIbpO
	 fhwww4AL+gOf/hXF+4t+a4RGLm5Nyn3vLqXCwGfH4tX9HQxrZlkMB2Z0icjpKJt3550jo
	 Nf3WcqM8hNqcAUuO/V7XdBRXwFz9koPwfMaTGRaqKqdjfSMvV15XeoHrbTXCzQ3Z5gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HwVF3DNHZD4A3EFj8867gK9RIhk2o9tBhFNVHKFjgmg=;
	b=oD/TEikTtQ/MqkPuacpsTH0sQNCOn5SHbnURTZW71EMLjt3kE7zDkP/jIhw1TNEhEmzM
	 9/3+NWZQsMe4EsDyH7DQ8sZIGqyUJa+/Q02efDlQa9Xe4bBoYLe6T3izjZy7xLf0DDFRi
	 +VUz4lGWQJKftWeu9/w0kL0LEA5Z2ZpgwfVA1tX33Adg2V7W5VxzCz+dE5DKRpk5BSNP0
	 LbCGWcEbh3Jhzjhc13JGtZd+FEVrfmcDLE96se7xLUfHlohmSgKUcXeHL6v1javG3iyaF
	 PiS14iTyDVQHfHWZx4x1W2FOUmbX5twhZXjkT8uhC8fGRkW3YdFJDOJvMls+EbhFflw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbod3PAK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A3606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbod3PAK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD6D1F00919;
	Wed,  4 Nov 2026 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834652;
	bh=HwVF3DNHZD4A3EFj8867gK9RIhk2o9tBhFNVHKFjgmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hbod3PAKlCnwAU4lnMRBl27hNtwSCgYklX1w7FgESI+IXK5VP1YdaJ3noEHMt+j53
	 Yg+CJ0Er7saTx58JyubIqVKs+QpLGH+2hs5xu4oIWOuQctJ8R2TGxGKGyrZY4WC7fu
	 HbXhXfjH51sgm5aJW1mtnbSVxq8CP9ASClilQFptI/rsLYNb72TND7dnG920WmqImx
	 8dZcLiXnaE0hTMZSjesURCFnzBxt2oR2MacdvQs9DhRwO9963eYMaYBguARgqQIQ0e
	 mMcrr3M7AYj8aMHOMmWxoKEp48/wKFzlfV5C8IcoemB2jMru1434EZ3VRt74jil18d
	 sZhF+2xIomjeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Brian Foster <bfoster@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	yizhang089@gmail.com,
	Yang Erkun <yangerkun@huawei.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	yukuai@fnnas.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/truncate: look up the end-edge straddler by index
Date: Wed,  4 Nov 2026 18:24:09 -0500
Message-ID: <20261104232343.890460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-reenact-degraded-eaf5@gregkh>
References: <2026110400-reenact-degraded-eaf5@gregkh>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit f47dee903b9f0f1e4e7181e8a398a7678cabf0a5 ]

In truncate_inode_partial_folio(), after the first split at the start
edge, folio_split() unlocks and drops the refcount of the after-split
sub-folios.  The sub-folio straddling the end of the truncation range is
therefore unlocked and only transiently ref'd in the page cache while the
code still derives it from a page pointer inside the original folio.

Between the first split finishing and page_folio() resolving split_at2,
that tail page can be reclaimed, freed and reallocated as a new large
folio in the same mapping at a different file offset.  folio2 then points
at a folio that does not cover the end boundary, yet folio2->mapping ==
folio->mapping still holds, so the stale pointer passes the mapping check
and folio_split_or_unmap() splits a folio at a wrong position (or, with a
transient refcount, a use-after-free window opens between try_get and the
split).  __folio_split()'s own folio != page_folio(split_at) check cannot
catch this either since split_at2 has been reallocated as part of the new
folio, so page_folio(split_at2) resolves back to folio2.

Look the straddler up by its page index instead.  __filemap_get_folio()
returns the folio currently covering the boundary, ref'd and locked, with
the mapping validated under the lock, so the split target is always the
real folio at the end edge.

Link: https://lore.kernel.org/20260928120833.3440834-3-yi.zhang@huaweicloud.com
Link: https://lore.kernel.org/linux-mm/DLGXT0ERY79Z.3C5DYVJVX6S9Z@nvidia.com/
Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260916094500.C30061F00893%40smtp.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: <yizhang089@gmail.com>
Cc: Yang Erkun <yangerkun@huawei.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <yukuai@fnnas.com>
Cc: <stable@vger.kernel.org>
[ sashal: Retained try_folio_split_or_unmap() instead of folio_split_or_unmap() to preserve the uniform-split fallback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/truncate.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 4bf64fd610c94..9b1baa688a104 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -259,30 +259,32 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 * for shmem truncate
 		 */
 		struct folio *folio2;
+		pgoff_t end_idx;
 
 		if (offset + length == size)
 			goto no_split;
 
-		split_at2 = folio_page(folio,
-				PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
-		folio2 = page_folio(split_at2);
-
-		if (!folio_try_get(folio2))
+		/*
+		 * After the first split at the start edge, the folio at the
+		 * end edge may be freed and reused concurrently.
+		 * __filemap_get_folio() looks up the straddler at end_idx
+		 * and returns it locked and ref'd with the mapping
+		 * validated.
+		 */
+		end_idx = (pos + offset + length) >> PAGE_SHIFT;
+		folio2 = __filemap_get_folio(folio->mapping, end_idx,
+					     FGP_LOCK | FGP_NOWAIT, 0);
+		if (IS_ERR(folio2))
 			goto no_split;
 
+		/* make sure folio2 is large */
 		if (!folio_test_large(folio2))
 			goto out;
 
-		if (!folio_trylock(folio2))
-			goto out;
-
-		/* make sure folio2 is large and does not change its mapping */
-		if (folio_test_large(folio2) &&
-		    folio2->mapping == folio->mapping)
-			try_folio_split_or_unmap(folio2, split_at2, min_order);
-
-		folio_unlock(folio2);
+		split_at2 = folio_page(folio2, (end_idx - folio2->index));
+		try_folio_split_or_unmap(folio2, split_at2, min_order);
 out:
+		folio_unlock(folio2);
 		folio_put(folio2);
 no_split:
 		return true;
-- 
2.53.0


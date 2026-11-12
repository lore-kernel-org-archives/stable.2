Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456010;
	b=WOrvqg+c2q/VCSlOuE1qnko53EQHS16V0buXbHlkHbR8HzbyM3BvGXKAUvqxpc8fRKK2
	 bBzLtLSUpKNcjkcZ7fPIrO76m2S5Md3GCLAIOpZBgiyVGL1rioaoGZwWMYabMHmfy4igw
	 uHJZu9F0hXI4tZhvIs3DEU4y/KPjOcFylA+q4uB2eVlwgw+Wk5TTDiZ9DMwG880tM1ou0
	 Unkf9OiazFWz8HCK3y1reo1+ACAkX4nsjo1XMGId+1NbiDbY7XcqH7U6Kb7dciW+4ifeg
	 zYv9Lqb4RlF20JXYv/a8qlIvhCLjGJ2o7AQxSrQVhBIvjlAp83FhSJQG+SUTQU3/t9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9DMCJyibQYGxf3DCn0HRsKXneZ5ieRpxbWLe2iH9uII=;
	b=ZYM3znadLh/GSmGj0L6FzGsBCJV5pHc62ZrX7LpqzoXFzGftafguMkoTKd7KwBOJhV3P
	 y9kg3mv27Nf+Mk4y1EhtlaeArU1LwVyTB8Xl+AeVCfVpGE2m1EhtRIJWGC6CGogJVsXP3
	 Ee5oooq1R8kk6j0WrYdydROF9LBKluLnFAGBHnd9Jtn6W155JM68BuQxowLe1BbJgPiLJ
	 zz4iWX0/x6iVyT9XanrI3G9zkTc6n/3qM7XR1m2df8/19ACf9K6ze6wATMPfH6NmhTJx4
	 NSJDq0J68/+HevFBqmm87Ra3/vah1QF8XpzvXqVch2/Hu6lM41n55O/GyaCt9YQUlIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxDWxT86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A8606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxDWxT86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD91F00A05;
	Thu, 12 Nov 2026 04:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456010;
	bh=9DMCJyibQYGxf3DCn0HRsKXneZ5ieRpxbWLe2iH9uII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxDWxT86/58wBvyGYwenXDt6Hy4LFDhgRjvhAp8Opf6B7Nwn9Oh50zlyvR+zpJs30
	 y8zpjYxHOvw/REc1f8PZCCy1SGuxCYX25pXbaYbPHP2GtPsVMyN2H0BKPM5gLSbb0z
	 yla7dkxi4xT7zzqT45tBFfF47RmDABxHFJjjx95hGlr7UyaxOStN+/l0wbBrap820A
	 YBUUrBUzMim8K4zGeagYihmCmm2lLc+zKj2XtK1HGjEWokVhj4SCptipO6txeTtvyw
	 0+yeeupgRXcjJFbPKuECXw6qXYqY9mlsPSuieUAwKgZLpq1n0AMcX7tZCJwNcsx+YQ
	 To9Z0N9yWK0XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Wed, 11 Nov 2026 23:00:08 -0500
Message-ID: <20261112035604.1726100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202821-failed-5.10-4c2dec1dce36@kernel.org>
References: <20261109202821-failed-5.10-4c2dec1dce36@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 4c2dec1dce368ad9e9b1814307cb5ef3832fa07e ]

A folio read from a swap slot previously shared by KSM can remain in the
swap cache after the process that first mapped it exits. Its anon_vma
can then be freed, so ksm_might_need_to_copy() must not dereference it
to compare roots.

Doing so can result in some false-positives, resulting in the reverse
mapping missing the new folio mapping, preventing migration and reclaim.

SLAB_TYPESAFE_BY_RCU allows individual anon_vma objects to be reused
immediately after freeing. A stale pointer can then refer to another
anon_vma whose root matches, even though the target VMA is not linked
to that anon_vma.

Move the anonymous rmap compatibility checks into
folio_anon_rmap_compatible(). Keep the page-index check and compare the
folio's anon_vma pointer against the VMA's own anon_vma and root first.

If neither matches, bite the bullet and walk the VMA's anon_vma_chain.
The VMA keeps these anon_vmas alive, and finding a match guarantees that
reverse mapping can find the new mapping.

Lorenzo Stoakes says in a private discussion:

  "This isn't quite equivalent to the existing check.

  Every anon_vma in an anon_vma_chain shares the same root, but if you
  split a VMA then fork both of them like this:

                  VMA A
               /        \         <split>
            VMA B      VMA C
               \        /
        root <- anon_vma 1
               ----^ ^----        <fork>
              /   parent  \
        anon_vma 2   anon_vma 3
             |            |
           VMA D        VMA E

  VMA's D and E both get their own new
  anon_vma's such that:

  VMA D: anon_vma 2 -> anon_vma 1 -> root
  VMA E: anon_vma 3 -> anon_vma 1 -> root

  And if you found a folio referencing anon_vma 2, the existing check:

	anon_vma->root == vma->anon-vma->root

  Would be true for VMA's B, C, D & E.

  However after your change it'd be true for VMA D only, as it's the only
  one with anon_vma 2 in its anon_vma_chain.

  Whether or not that could actually happen in practice... 🙂 I don't
  know.

  [...] after your change it'd be true for VMA D only, as it's the only
  one with anon_vma 2 in its anon_vma_chain. [...] I would [...] say that
  you are making the test stricter but more correct.
"

If this affects performance when KSM was never even involved, we could
just track whether KSM ever merged anything and just skip these checks.

There isn't really a lot we can do otherwise: for mapped folios we might
be able to use folio_get_anon_vma(), but for unmapped folios there really
is no easy way to see if the anon_vma is still valid.

Document the (confusing) lifetime requirements of folio_anon_vma().

Fixes: ba6f0ff3981e ("ksm: fix ksm swapin time optimization")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-40-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: inlined the folio compatibility helper into ksm_might_need_to_copy() using page-based APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c  | 16 +++++++++++++---
 mm/util.c | 13 +++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 466ca19997551..89a8ae28ff83d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2667,6 +2667,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct anon_vma *anon_vma = page_anon_vma(page);
+	struct anon_vma_chain *avc;
 	struct page *new_page;
 
 	if (PageKsm(page)) {
@@ -2675,9 +2676,18 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			return page;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return page;		/* no need to copy it */
-	} else if (anon_vma->root == vma->anon_vma->root &&
-		 page->index == linear_page_index(vma, address)) {
-		return page;		/* still no need to copy it */
+	} else if (page->index == linear_page_index(vma, address)) {
+		/*
+		 * Careful: anon_vma might have been freed, so we cannot safely
+		 * dereference it. Add a fast path before we walk the anon_vma chain.
+		 */
+		if (anon_vma == vma->anon_vma || anon_vma == vma->anon_vma->root)
+			return page;	/* still no need to copy it */
+
+		list_for_each_entry(avc, &vma->anon_vma_chain, same_vma) {
+			if (avc->anon_vma == anon_vma)
+				return page;
+		}
 	}
 	if (!PageUptodate(page))
 		return page;		/* let do_swap_page report the error */
diff --git a/mm/util.c b/mm/util.c
index 9e0c86555adf0..52ea9aa638294 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -766,6 +766,19 @@ bool page_mapped(struct page *page)
 }
 EXPORT_SYMBOL(page_mapped);
 
+/**
+ * page_anon_vma - Get a page's raw anon_vma pointer.
+ * @page: The page.
+ *
+ * The returned pointer may be stale for an unmapped page. The caller
+ * must ensure the anon_vma stays alive before dereferencing it. A page
+ * reference or lock alone is insufficient; use page_get_anon_vma() when
+ * the anon_vma's lifetime is not otherwise protected. Note that
+ * page_get_anon_vma() is only useful for pages that are still mapped.
+ *
+ * Return: The raw anon_vma pointer for an anonymous, non-KSM page, or
+ * %NULL otherwise.
+ */
 struct anon_vma *page_anon_vma(struct page *page)
 {
 	unsigned long mapping;
-- 
2.53.0


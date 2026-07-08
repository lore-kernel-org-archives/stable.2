Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA53DA7C3;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548774; cv=none; b=t21MZGi567Mf+b92FYuF/tCT6fqo0KnOabiUmqkHwzks7GMlbeQdoiFN8y0JBm4Kw0Hqnk0zihZG2RCOxCt3xf0rDvNgJGFNF7fZpd9uS3/MRL6u9WZ+zxZl6P8KQpkSC7f16IcERuKTEY/OStfIWHKLcjxlOR8pUf+U1c3RPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548774; c=relaxed/simple;
	bh=AkD3Vk4B07kPFDKXwHOUP1icWldJ4DzrSHE+2Ogit/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a64KpwuGvaEbF1uQ/Waw7dEipTq2C8DgKN8DZy4XjlxR0f9QL1sT6A6l/bjszMIFIsguS0R6hX0yOubnyMrP9pEtVJh/lI+5pVGnqWNcmp/Okzyo3sb+z5jmyzyGczJuLDTMWS3+ion5kqfrx81GdoqV3gBkJPhN4fm3LY+CXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktXBXh0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktXBXh0g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1748AC2BCFC;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783548774;
	bh=AkD3Vk4B07kPFDKXwHOUP1icWldJ4DzrSHE+2Ogit/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ktXBXh0gg83rtUpyKeXx9mhQdiyYqSz6tJeiXLUCum96riA/ZNra5XlFpqJxaKmYK
	 6meg0aIDbU9cxnh+Meww9xzd6k388a4T0Ttgl1doB9b7uy0mOB3J8alM/BbJGgvB+Z
	 mTJz58DZgOiQstziNPPdo3lDJHzv7Q4eN4p0BdORDfj4H5PcOtUltPsCDMYZ8MBUqY
	 OdluOvRKOg10DD1ll4sN05Ao7cXRxqz/ytgtJxTVEW52772mbjyytdD56uvUvC3GBo
	 68uKrBD011EjRUt4XovUsJkg/Y9xms2g51EzUHQ+l2gRrCOThtiVJKfGZzaVao9bLh
	 iUAfikyoSV8Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06639C43458;
	Wed,  8 Jul 2026 22:12:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 08 Jul 2026 15:12:53 -0700
Subject: [PATCH v2 5/5] mm: hugetlb: Move memcg charge earlier to prevent
 reservation leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-hugetlb-alloc-failure-fixes-v2-5-c7f27cbb462b@google.com>
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
 Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
 jthoughton@google.com
Cc: vannapurve@google.com, erdemaktas@google.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783548773; l=2730;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=aDc4LeCjf9Msx78DCPQ6R0pVUvWtCQbT0+pt5lURw5A=;
 b=C/Vy+QfzINHzFrWHsVd2Hc4hHJO95u4DUt+Y/R5xhEOPitzw3jg3OzKoQPYxnnBqtqUyIy91U
 VA+6kJWQ3QyDecXnoBFpg9D6y68TwiYF811Q3SspObCEMxjI1Nd5bFn
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb() fails, alloc_hugetlb_folio() clears the
charges and frees the folio. The reservation committed via
vma_commit_reservation() was not undone, leaving the reservation map in an
inconsistent state, causing resv_huge_pages to leak when the process
exited.

Fix this by moving the mem_cgroup_charge_hugetlb() call earlier in
alloc_hugetlb_folio(), before vma_commit_reservation() is called.

If the charge fails now, the reservation is not yet committed. Jump to
out_subpool_put, which will then call vma_end_reservation() to abort the
reservation and keep the reservation map and resv_huge_pages counter
consistent.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3e1d99f03c70e..e000af6f28585 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2954,6 +2954,25 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	spin_unlock_irq(&hugetlb_lock);
 
+	ret = mem_cgroup_charge_hugetlb(folio, gfp);
+	/*
+	 * Unconditionally increment NR_HUGETLB here. If it turns out that
+	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
+	 * decrement NR_HUGETLB.
+	 */
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
+
+	if (ret == -ENOMEM) {
+		folio_put(folio);
+		/*
+		 * Charges to hugetlb_cgroup for usage and
+		 * reservations were already committed, so folio_put()
+		 * would have uncharged those. Go straight to undoing
+		 * subpool charges.
+		 */
+		goto out_subpool_put;
+	}
+
 	hugetlb_set_folio_subpool(folio, spool);
 
 	if (map_chg != MAP_CHG_ENFORCED) {
@@ -2981,19 +3000,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		}
 	}
 
-	ret = mem_cgroup_charge_hugetlb(folio, gfp);
-	/*
-	 * Unconditionally increment NR_HUGETLB here. If it turns out that
-	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
-	 * decrement NR_HUGETLB.
-	 */
-	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
-
-	if (ret == -ENOMEM) {
-		folio_put(folio);
-		goto err;
-	}
-
 	return folio;
 
 out_uncharge_cgroup:
@@ -3014,7 +3020,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
-err:
+
 	/*
 	 * Return -ENOSPC when this function fails to allocate or
 	 * charge a huge page. If a standard (PAGE_SIZE) page

-- 
2.55.0.795.g602f6c329a-goog



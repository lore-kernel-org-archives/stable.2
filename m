Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495D23AE87
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937428; cv=none; b=FDxUJufYnQP2XtgYZbhuDIoBohT/Ys9gPxw8mnUsPC60IRhy5pYe1PX1YToVFY0uVr29DM7smYLkG1NUIDnpmAHpM4/RlSOkVe7uBP7VXmHINwZkXO6OKCJ5GMfQcdwu/Jw+UjnQZq1XtTcYoR/CbmOBQP8/HlMHSVbmA3EhzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937428; c=relaxed/simple;
	bh=iaVsW9dYSqVbneBiU0MvY71SRQHcSi1dt811T6LnSnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8oE2ScmF1OM9OmsIgqbry7oMNpizjdFZ+t2OUla+ChV24QBatFZAq8p06Kq7X8jUjayguLJ8Lu2pigH7q5Vapf4+K16R+dlRYX1as3WE71/etpamciOvchfvCfO41x/9xB4G833rMLo/KP7BPe5wrWlHJ30KIlvMJ4dGuVe0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=BsTxm3wH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKFNokbB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="BsTxm3wH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKFNokbB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9373B1D00171;
	Wed,  5 Aug 2026 09:43:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Aug 2026 09:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937425; x=
	1786023825; bh=mE04psZOD33Pi8Lqhpo+dbtDR+C88w5R4pEGJZb1fCA=; b=B
	sTxm3wHyghvSZgh+2P4Q6oKETTdmpjoMIOgkhy9AyG/KJ46qnEJ8iljok8/hXa2E
	e2vl87BDQTTOnJKNpFaJATXCvnPWJ7d3dxoZbhTyjslk75I2Xjn5aLw4hItqYoWU
	ZeOb2d4iY60K6IXEnzriMYkTb04d2s/rUOKOJtqp3N5Ze1GBGtEB+lcemI677DyS
	xmN45KcP7y9rE979fLv6fcyMaQ1Q98JjglzgIDZz66Q3128c3hHt0iSFNGTWlG1S
	TephR6Zqkr7S1Vsj0Qmhg1Rt2ULAKZDtTgZx1bn0TjAqJkuZwGijxPsGaiBWnkZd
	sWYlw4erVaz5RBk9ZSoGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937425; x=1786023825; bh=m
	E04psZOD33Pi8Lqhpo+dbtDR+C88w5R4pEGJZb1fCA=; b=UKFNokbBsZF4dlHbF
	KRQwmdCL2Z9ZpObHk5mk6jZowDJY49D+9y98kL5dipulRSOiA5fHi350eYFbuCka
	2BUy0ooYzTJfG4ZRsTnRpsvMhqDDCKzDNVFLgFocH25qsdo5cEPZbgk/ElJi5US7
	QzBwr1k26tdrsqfWg9pSDn9c/aAasbSabYL+obgGOXDkujEL5j42b5AGmwr7IpRQ
	wqqoFcDBhQrNjt2MM9Dg8KQLS1iXTMRCBaBPDUi8P6RVVOwu8oRZ7d98zK746zBE
	Z573MsB6u9TVD70jopcfthRz+cr+b9AvSYBHKrd+X5N0mK+hCW+F2goB8MIQlMB+
	wqCyg==
X-ME-Sender: <xms:ET5zam5k1_GTQkwi5jO0xgSeVzV64LLBYJXEAPql9GBNhsaF6vx1tg>
    <xme:ET5zau-RwQSgZKPG1CIagIcpdCupCnKZtVHgJNnH_DMgcxH8juLeFhvnhKm7CKnFx
    krQLXYmx_mFQ1D0CBYJ8CeF67AC0tp6IBaWoLIxkTQNmn_8cRWqLPQ>
X-ME-Received: <xmr:ET5zarqaaE3Rigtz2RhS4dQNcD_WCu4yUtem7fdiKjH0vcXz5sWGdTJo45E>
X-ME-Proxy-Cause: dmFkZTGBRAs0ifpC+bV18Yb7txt+PthwywnJFv9LX2mQR508LI0G7bXc4hSAgTqIse5aOJ
    KOOqZ6a2cdUC6JdkTzB6W4FdPJGfzSQphIFOhxzdyJpspvYPOYWGhnudaqX61/sg073roS
    Q6WB36tIJT8BMIOzw/jjlC/yVFQRoH+LaOBnJApMgJmMiOzj5DDc8B2kismF1LEEvvqRhP
    Kuopf0/CV7Y3WSTQ2g9I4uxpB+E8aB9RSBYwWO/mSLxp3IkrdUyx+aQcnVP8yy6Gs2cfsK
    AcmcI4WnGINZqIYaI7Ux/UyMtEUIl655Vuz8EykTAeEkLQoJOMyBrsQG6pQOEct4V6AsZo
    Q8PHz3Idl9lCVXAXenTvjlyMr3qLSj6McR2J1uI4xI9A4ZqKiObnC86I093NuUL4Jo5OBZ
    4oPWOR8ZNB7Xl6aI5GeAt4IeWlq2J7jRownuodxu7qmNqos30YeHBZzCCVWLcG4l15qdA+
    v9E8Ghq6p1oZdC5Br3HW4tfa0wnyAJ2X/ZIaKsTB05H1/3v8cVKuc0I4uigc3UK7HpBc51
    4awY+8XXxuEDL89qIcmoL3GAvQ6vk98OpbRvS+6HMeMvKx9k9mzyLcOjIjHoxxg7brjnyV
    yR3dXLP1+IaoKSrdGOUypzl0msqRUwmrov/PhuF2A4gq/VyS99w05zsUuR4g
X-ME-Proxy: <xmx:ET5zavoa7lT1JxJ4TtDJij7OAo7HHajci-Sl6QCHoqImY-eAJ3szJQ>
    <xmx:ET5zau2mVOiCz9oAXMncpLk4NTsVr8Tg20rXCw2OnTriINdGIcRQgQ>
    <xmx:ET5zatH-N0ObszlGoBjEUS1aCpEdayoi81MJi_z9MZwsP6rxQub79g>
    <xmx:ET5zapGVNpe87Ii0oMxBuqeuCb9obggVwOm5cb4H6OiCza9JJYQAAg>
    <xmx:ET5zajSzFIkAkNyzFACdsAEWeQWa8PFk0lC54oSXiZluLfsdNfTRydWe>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:44 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Wed,  5 Aug 2026 14:43:43 +0100
Message-ID: <20260805134343.2776514-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080515-mangle-frail-8d50@gregkh>
References: <2026080515-mangle-frail-8d50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

copy_hugetlb_page_range() clears the uffd-wp bit of migration and hwpoison
entries with huge_pte_clear_uffd_wp(), which operates on the present-PTE
bit position.  Swap entries keep the uffd-wp state elsewhere -- the
migration branch reads and sets it with pte_swp_uffd_wp() and
pte_swp_mkuffd_wp() -- and the present-PTE position falls into the swap
payload.  On x86-64 it lands in the inverted swap offset, where a
naturally-aligned hugetlb PFN always has the affected bit set, so the
clear advances the encoded PFN by two pages.

No userfaultfd needs to be involved: the clear is guarded only by the
child VMA not being uffd-wp registered, so a plain fork() with an
in-flight hugetlb migration entry (or a poisoned hugetlb page) corrupts
the entry copied into the child.  Instrumenting the clear and forking
after MADV_HWPOISON on a 2MB anon hugetlb page shows:

  offset before=120e00
  offset after =120e02

The fallout is mostly latent: rmap walks match migration entries by folio
range and remove_migration_pte() rebuilds the PTE from the folio, so a
within-folio PFN skew heals once migration completes.  But any path that
re-encodes the corrupted offset -- e.g.  hugetlb_change_protection()
rewriting a writable migration entry via
make_readable_migration_entry(swp_offset(entry)) -- propagates it.

Migration entries legitimately carry uffd-wp, so clear it with
pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
move_huge_pte().

A hwpoison entry, on the other hand, never carries the uffd-wp bit: it is
installed fresh by make_hwpoison_entry() (try_to_unmap_one() does not
preserve uffd-wp on the hwpoison path) and hugetlb_change_protection()
leaves hwpoison entries untouched.  There was nothing to clear there, only
the corruption, so drop the clear entirely.

Link: https://lore.kernel.org/20260708090110.136162-1-kirill@shutemov.name
Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260703140011.99E601F000E9@smtp.kernel.org/
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: Claude:claude-fable-5
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 83abe2fd5b3aeb3123b5408a5a91709c5538fb23)
[ kas: adapt to the pre-softleaf idiom ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/hugetlb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 17865215fda7..d53f9252dfa2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5280,8 +5280,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
-			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+			/*
+			 * A hwpoison entry never carries the uffd-wp bit: it is
+			 * installed fresh by make_hwpoison_entry() and
+			 * hugetlb_change_protection() leaves it untouched, so
+			 * there is nothing to clear for the child.
+			 */
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
@@ -5300,7 +5304,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				set_huge_pte_at(src, addr, src_pte, entry, sz);
 			}
 			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+				entry = pte_swp_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_pte_marker(entry))) {
 			pte_marker marker = copy_pte_marker(
-- 
2.54.0


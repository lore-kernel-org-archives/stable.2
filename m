Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED9330B01
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937425; cv=none; b=JzkKd2R+wHTbLLdXRnTUwmzUzXOT1iclMw5dm4hKVZ76y13OJQTEEjMnE6BOrAUud+hbxjDVeiJCPAFz5J1vZ1s7ZFhueg53yyr4LE6WJpLm8M8Uwua30hzzEZAKLazt524mN1cROBuEQcSPDPhEZP36uoiCt4eblSd2oXirYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937425; c=relaxed/simple;
	bh=zsuINpOzZurs/oxsXIHStLV3E3n/5NPemJFrCT80qno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5LTzosu/i39b/t9YVuLaEBQcT2OJ6bWskkCqIJWAtfmas/m1amhdqoAD1qeefmbd12+KlQby5mSSEQH9VCZfhMA1Y1m0/FKh+CYCpJBa+oeBBWl3Y1ThY21gtmMF1WE19B0c+qUh3GxNkYGpyRP6J6D3zfzBiLMOOUJn0mADR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=IeKlEzXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnYf4pkk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="IeKlEzXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnYf4pkk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E3EA1D0012F;
	Wed,  5 Aug 2026 09:43:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937422; x=
	1786023822; bh=fJa3BR0pdQPP174BHt6/ij+Fq9xcNNs8JWE9qrpejvs=; b=I
	eKlEzXTvKiixWIUSLqKbP9+9ioBbdtkfvZndIHxPjqGVsFNwx5usb11GHjiEAxZ1
	3cW//kRjZK+WvF8GhWYbgqyDl+WW1s/nJsyEmzvZuK4IrJdEsrGdM5zI6eI8b3wh
	O0zHKDIjy+LUcaCorGPgiJqca/Xa6gicPyo1YXQUXO+gg+lhagqjRbYYu1oIyvdi
	ajzHH6AWn/QeFjulENcljJhTbRVG4aLg9BWq7k4mJ1xT4nZRw4mhWecyt4YEnd7u
	Tjy/NHp8JmwOOSPLpV3KDw1mhdCJHOiksVZ3ktMSTxSshMYxFNLaVs0g4J0lWYpv
	cO+dGTaHpCzsJwwtrCJZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937422; x=1786023822; bh=f
	Ja3BR0pdQPP174BHt6/ij+Fq9xcNNs8JWE9qrpejvs=; b=JnYf4pkklzXSFW2Ko
	eogl+CEYP3+p33ZO04LYGVFRSayy1EGuXRvyNEVCI00/YfVHcCjWKjQlQZI73/Hi
	HG3wuR6PvGYn+/LmJ+ogQEBQZ2W1I9NE21yMd2Rfn+wT2ykfojK8dTX5z5kaI/0z
	9h+EiXROJ0/BRVXwxrGvYcYdP+hNQAkK+JA+H9gmocHfVf2RFNTL6o20t8XfGY0g
	Z0C8gl7l8TnR41HvE3CqOOLjhV5img5L80Q0RUYJnJy4kf1zFlyvEmsZcrnQzHmo
	rhVBDsklAo/KgyvfHhNrfebdeBISDj0E9D+gNwV0JqwZdv8foy/2RJ6jcekWcnRx
	ijDAQ==
X-ME-Sender: <xms:Dj5zanXlvHAFBLdJbF_DTEWl6DOk8CKPO5jjqKC75UGugpCKDAPtfQ>
    <xme:Dj5zaurL2ULtKUAoqgwrAOTgs6Wst0uPYFSKxB5LQ9BVe9TjVzrmG_iZSmVsWqxbO
    YYg8wc5xY3GZAcNFLMS8maJhWaXeEUml_eMPCA1XkeAMQ9tT6QND90L>
X-ME-Received: <xmr:Dj5zapnMNJ9UuRG5dBO8IBFaglabdvmMj59doj79af6Pv6vkxuLdmewfKU4>
X-ME-Proxy-Cause: dmFkZTGBRAs0ifpC+bV18Yb7txt+PthwywnJFv9LX2mQR508LI0G7bXc4hSAgTqIse5aOJ
    KOOqZ6a2cdUC6JdkTzB6W4FdPJGfzSQphIFOhxzdyJpspvYPOYWGhnudaqX61/sg073roS
    Q6WB36tIJT8BMIOzw/jjlC/yVFQRoH+LaOBnJApMgJmMiOzj5DDc8B2kismF1LEEvvqRhP
    Kuopf0/CV7Y3WSTQ2g9I4uxpB+E8aB9RSBYwWO/mSLxp3IkrdUyx+aQcnVP8yy6Gs2cfsK
    AcmcI4WnGINZqIYaI7Ux/UyMtEUIl655Vuz8EykTAeEkLQoJOMyBrsQG6pQOEct4V6Aso8
    Ji3+7NxaLe5xq6Apw5j2mNVymG3EjeYSxUms3QUa/AJpwhimbzPAw6eaCXJu9vGuN7+oMQ
    0sRVPAugvXYMyZecc/wRcG4p+X/L8MddwXjd/lCEi2wcfTIHtN0Vss3dLpQQQkYy1wITM0
    HY/nPcWJeqyGPQH5l9PrIIM562uH5iW7hzanZx3B/WeZYVSdcNtkWHVPynjT1VVKqZbEQL
    vclmj9BGwTRRQPIG30JsyafDH4C9OPvv4kwOH5cBIsrfcJQVYmrclEDaSo0ntOjjflDLci
    j+ZokWo8NpIZSRBRndPP1NmnwMIlAxX5MiJhaLKLgsAkOOcaqG+v2moPJ0uw
X-ME-Proxy: <xmx:Dj5zau2wQfltynfuJwSfZmW5OOTBR-mhLPLsSvocr5Rju_6W6O2Gmg>
    <xmx:Dj5zamTRp-7EWFySfxs10IVw9pLv6d3OPoON_jvYDNdO52CT5Q-1OA>
    <xmx:Dj5zanz9ewTr8wB4xokMERkOt0w3oSpdxotwbMmDafb9Qk5rP2ZGKQ>
    <xmx:Dj5zamCmmwdHCsU32h72DoVy8H567Mb4qnnLnAkBX8qDI_GXOO0tsg>
    <xmx:Dj5zajvyLDl3EQNHUHUD6fNewLL-k6JsJxiNzCrHCs-jgZLx7P3kWtbP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:41 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Wed,  5 Aug 2026 14:43:38 +0100
Message-ID: <20260805134338.2776503-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080516-turkey-eccentric-1ef1@gregkh>
References: <2026080516-turkey-eccentric-1ef1@gregkh>
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
index 5da54cef2f72..a3f685670797 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5112,8 +5112,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5132,7 +5136,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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


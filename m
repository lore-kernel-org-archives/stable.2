Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819645DF76
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937421; cv=none; b=g2Qj8OhfTdnIROhzDjEVGa/ljwjfaSLpCDFrJtjoFRm91WTP9cpG2+Mjk+kAcIBlpZSs2BHhlo3Ps9ImTRzHfmhPpzSkjxRDkm3ZaqzaOSdlSEOZtn9CL4Qc4wx7gyD4V+v6PoQPj0H/FPOFOjpqciab0qsufynn1CiOrFKZPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937421; c=relaxed/simple;
	bh=ZxKDCL5bPPFGGIgKl0zqbUW1YWgaMXfBERemY9yWPhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCF51WFLSiETmn9PzP8+avC9RahYxwqBeLJX/EJhEN8+dEb1FJr0AslLTSdYovoZInvgnllw3LqW3U4V8WXBz00QW/1xP8iC7WBng5TK51p7mQYGzvLkvjUycV7urUthg2FXz5SXtKsZSTGiCihtjMZbMKxC0wesPydCg4IbZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ox71WCgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8G/j0WJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ox71WCgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8G/j0WJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4437E1D00027;
	Wed,  5 Aug 2026 09:43:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 09:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937418; x=
	1786023818; bh=QQaOX1nxig0ggvWfXVP9pHCit8uz5EYLTLypCO7QKn0=; b=O
	x71WCgUlXwe7MG3iGsLmc1SWCLJrXAYWs5XAFM65hF42p3orGUU6uMtBMN3o62Tj
	01DAlZXuo/6IQIMkfdzDzeeYNg1PGO+OUpBW/TLDczUKB5wvfk/JkTGpU3W5+HKv
	e0zqdrFmkAOj/WAtiDkTVWi1uh0PTI9hbo2MzFVQk6j8yzQVZwa9SQ6fK1JxQhMa
	X60iJohMXdmPL6poeTofBvOjvK2bNA3aVcJaYvjdqeAhLmyC/5r9daP8LjkyIza0
	Np6NUHfnDQcjrCFEDH+phJtH96XZQDhts+6cXeIjHI+oKf7UVIGtdvmvLkyKCgFK
	mrO4kmw/edPgWb0t1I2sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937418; x=1786023818; bh=Q
	QaOX1nxig0ggvWfXVP9pHCit8uz5EYLTLypCO7QKn0=; b=H8G/j0WJP1RcZFEDF
	gk7wufnugzDl4/gEacbvYyX+51Rnee0ybNGi2snG7rvkP0NSAEzsvkRf73rgrU1j
	YgR1FwGUmICQNbLvQzgUjr2utSAop2/TOQ5q/pI0BR76OAeEKXu9UPNOjtQIRlRO
	Qjwitdhs9Ipa70fsBCIlPvGs85wh0oD18ONbmrFyyvANbG7yKSok0E+ye5N6Sxt/
	knyKMKC8ozkSvHByxt1EyMOpG8k3oAiaH0XHcYsjDxuQS0TIX7nor3yhZLHptkd3
	FCdHCK4qA4acUZ09dbumSJj9rNSaqDvh7kvL4QzLAmKNJijVzsWUvSuVjUlU8/3O
	Wr9/Q==
X-ME-Sender: <xms:CT5zavtR9Cs1jmpKgHRTK2xhys-fFdO0f4UPzRtmIgyTNWNsLfgPUw>
    <xme:CT5zavhkewSU-_ZwjFeZDg6BwC3I3EyekxNgPXIMohTTPgV5gRV7jrjA28tsr__le
    4zy-kfV9T6H-zdW8S6tCuBhHDDD-TVsPFS7D719Ddss_tyCONnpEhhF>
X-ME-Received: <xmr:CT5zao-LbX00RI3YmdZizTWFS3jlGBJKooMP2GsWetdInId9Kk9B_nI2hU8>
X-ME-Proxy-Cause: dmFkZTFjQi0qus4HXW1Ygv/5UV2JuUMPnx4qZXfeEY8SiPSdw/pp4dedR2NJfRwFbB153f
    5MDfjTpvbXInJFDTVYcbdWaklEwOwVppz1CyxgIF0j2zlYgYbYnhZXAw3RBaZfRZ4ySqKv
    4bqAGyVUx0pAShWyGgnv1IfzZIL0d3yAE7d2/TSFJKZJfyX+HhoIDS1g8NrMcnHWejfO7a
    8Q51+US0EUMgbl3XeFgPNPVblCE4QvhwB/FmU9XpHMr0R0UjgNI1MhoXklG9LiQZMBmHC5
    O5ozos/3nnf224s2wbM6lsVEvPSOZAXGKgY88BT0s1whoAsGJ2Knjut2jzh2hYLi9nsrAQ
    KvVbTg7Fw0RGirp5+VjbXUyc48+atZckK8Z9gUciXoW648oQaKkbQUJFSyS1gqGKwsKLkP
    nhbU2s+XQ7rZVDEaF7QybolljHvDv1d9yBIY1iJQ7UOYGe+OiVJy75kGfbdk3Ki6eCu1X/
    5rvKtTDfVdiWaoNCIio+FW6IB5OcPYnK63EFoevymn7VUSMSwephypkbNJ/wGSiQ/gcomg
    JmQ3IAJq3GHlXr8YmJdj3Pc0jx9ngOJBiiwiPv7rdoi/sUuhBajcU56SdB/qcw0zjKwrQz
    u3M5jbWas8MAFA5QTkjHS60yP8aXObgF0lGwIg0mg7Jb7nnNTBXRSaniIUQQ
X-ME-Proxy: <xmx:CT5zaqsDxPHmTCiLFyK6yjHwDAJbNfKSp-nOLWwxc4uxNxtz81p5eg>
    <xmx:CT5zakrAo9_g05bL3QRmRSJi67uDLo3eBhnAubsFCIQ-NcJ8LTYPxA>
    <xmx:CT5zampZa6ieVn1DZQ6-Z8PqjGJoIqPTnnAI51zdzaMDPvngD3LKMg>
    <xmx:CT5zaraehQRUU7-mDcZAN-IZz46E7UwODHml0p1C65M9YYlRJoKlmw>
    <xmx:Cj5zasFKOK4cPYN8iyNnP5fkfis0cCjD7TwIs5BgMXv_-23QY5y-QkSe>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:37 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Wed,  5 Aug 2026 14:43:30 +0100
Message-ID: <20260805134330.2776491-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080516-marathon-disjoin-9332@gregkh>
References: <2026080516-marathon-disjoin-9332@gregkh>
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
[ kas: 6.1 predates the huge_pte_*uffd_wp() -> pte_swp_*uffd_wp()
  conversion in copy_hugetlb_page_range() (commit 5a2f8d22ace4), so apply
  the fix inline: convert the migration branch's uffd-wp read and set to
  the swap-position helpers too, otherwise the src re-encode
  (huge_pte_mkuffd_wp) corrupts the offset the same way; and drop the
  hwpoison clear ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/hugetlb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 74203552fec0..b3f59bba4c14 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5106,14 +5106,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
-			bool uffd_wp = huge_pte_uffd_wp(entry);
-
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
-				entry = huge_pte_clear_uffd_wp(entry);
+			/*
+			 * A hwpoison entry never carries the uffd-wp bit: it is
+			 * installed fresh by make_hwpoison_entry() and
+			 * hugetlb_change_protection() leaves it untouched, so
+			 * there is nothing to clear for the child.
+			 */
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
-			bool uffd_wp = huge_pte_uffd_wp(entry);
+			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(swp_entry) && cow) {
 				/*
@@ -5124,11 +5126,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
-					entry = huge_pte_mkuffd_wp(entry);
+					entry = pte_swp_mkuffd_wp(entry);
 				set_huge_pte_at(src, addr, src_pte, entry);
 			}
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
-				entry = huge_pte_clear_uffd_wp(entry);
+			if (!userfaultfd_wp(dst_vma))
+				entry = pte_swp_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
 			/*
-- 
2.54.0


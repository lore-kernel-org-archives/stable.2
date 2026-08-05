Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36D40D590
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937431; cv=none; b=mEkjqI+ycgewpG5+UfGAGafuzDI1sDVQNiBil1bl4THkdPSmFScvjjscrE9BNOIsYrTmrI+HG2rtPtDEwLUo5M9oJ82smjpWeuJphzlU77XwH+7fKhJS/Y4KrKe/+Pn64J/rtxq5UwsFypo+tF5xlKlTCymM2TRhT7prX6MotBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937431; c=relaxed/simple;
	bh=kuK9yexfGQAOT+8+Rf+SLn+XceInBJ5E675/lruK9Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFqoRJ4VaGA29yt5mGyaLzF6u4qSe7G9O9B177968V1luRl3a59HbZZnlACFY64OMu/sQykyPxebPQ3/pAx0rj+A8w6Lk65FG/D7oXof2MAOieth8VvXT4tGBTjhVheZk1ozxGMuBK+V9YpO6KrJuwEuFmn8Dro14OYajylzpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=chfK2IIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LCL9zbaA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="chfK2IIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCL9zbaA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90B8A7A014D;
	Wed,  5 Aug 2026 09:43:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937428; x=
	1786023828; bh=bKmvPLLIRMJXI2uzQb//dcpbL7nm14xVg6kbmxHqdZY=; b=c
	hfK2IImACnPUejq2n2TIZND6Heg7h/CpvfqguNk6zbj1l3eF54oi163UlqT/dTYv
	3a4T/OJF7tKVjI63XicSJEBOl6mJTLfimdiQTMUsKfmGMbGi6sdbeyomEWKaslqG
	Z+NYfVhLdPQdfU4TRTi2joZE+lNTteLSSL3GRn6MuWudW3TlZsTQBcz4NXhfE4fu
	FkmQd/gKjx54QDcxMj05tHnqt1Z1+MdBO4xyJUaURnUfpWtQsgrRAGv3FnDlGyPh
	oM6qDwvClTGJfWil76AV2vl2YNPwibmjM2WmC9hXrTHv9f5DE/UzIy4uhXUccZkM
	JmAk+s6exAsn9wlbJxr6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937428; x=1786023828; bh=b
	KmvPLLIRMJXI2uzQb//dcpbL7nm14xVg6kbmxHqdZY=; b=LCL9zbaA5zMpFeGPn
	x8s1kwBPgkvGJVMatHjnj+iiWue5icJI4Et53u8J0725dwlzpXl3rAubdoeagMpQ
	Wo1SqWoyKpJ1ddBOYqNRks9puDt9QbrEdrFE4o3ioBShU7dAcC7TfC64fYOOyAim
	eskqu74kWC+3bC5VJxoVDPIv5XkDID82LDMVlD7sPwEOZkhVe5xFdDAQafZhTkZX
	UdbtY/2caiGLTBiti13ts7rSb2qqU9TUBQpS7YIiOZZa27E0aRXrX8PZQL+smTrU
	mIE846It+JV6QQMpPPR8W6l99+pqBlVi3NQGjJf9khYtc5WfTGU1Y+Nt6PX69iQa
	Ac1Hw==
X-ME-Sender: <xms:FD5zagBgHrT4a8U4gjrLxP_8mvIIp9pVcqEhgPsazhYXwMInAo41-A>
    <xme:FD5zahnblwm4rHu_CBpQ_hSHSe-xLRvcaXJwotH30qxneCYuwjIfMkJqAGiRM3Ysl
    zyrgJQbA-5WheeL2J7A_01qqUvpVl3gSvHxaHPrIcdEWbmQK9Zyz1xz>
X-ME-Received: <xmr:FD5zapx9GcFiZoD-gSpiDedIWoIRxWXBw6Fp1GRZWY-WSHjyuRw6T8c1fms>
X-ME-Proxy-Cause: dmFkZTFjQi0qus4HXW1Ygv/5UV2JuUMPnx4qZXfeEY8SiPSdw/pp4dedR2NJfRwFbB153f
    5MDfjTpvbXInJFDTVYcbdWaklEwOwVppz1CyxgIF0j2zlYgYbYnhZXAw3RBaZfRZ4ySqKv
    4bqAGyVUx0pAShWyGgnv1IfzZIL0d3yAE7d2/TSFJKZJfyX+HhoIDS1g8NrMcnHWejfO7a
    8Q51+US0EUMgbl3XeFgPNPVblCE4QvhwB/FmU9XpHMr0R0UjgNI1MhoXklG9LiQZMBmHC5
    O5ozos/3nnf224s2wbM6lsVEvPSOZAXGKgY88BT0s1whoAsGJ2Knjut2jzh2hYLi9nsrB3
    EUATmxa1owehduRgjF1l0QSS5rALfGirFMsbo1WX7t7QYdYdpj1E6Hq8RN/W6iQ10gzbJu
    h3N/rzKgWaXB3i+PigvQJfl+MWsy3jE87WNDYQJbgmdcjOz5HvxOARL08IEM9FCZ5gPFS1
    M5zQxueIs5+dVAWT7bICHM1tC+HeIXrZ88eMJFLM174/+9QI1hGtGGqBB7Ez9rpxd9Bvqe
    Ei192tTuwYCC4Ybr9DPIAZBVDQv9Lr7pBKUdam/cuizzULxMOVG/iyHaPq55LiIwJ+mZkI
    Txz6I8CxuIoWS6VQnOV1aTYxEn+7G5g7C39IKsyLmb2GaJZXrUBlPQfqwX4w
X-ME-Proxy: <xmx:FD5zajTBbad7H-qcutgcOqF5ZI8pv6Qtx1iDu5W7BCWEmQIssFnLnw>
    <xmx:FD5zap-JfkFUWUyQU-fRjxaxdhGxnQ-DE9t7q5VYCTW9OrbbyooyWw>
    <xmx:FD5zaptw0TM2Fb7S4_WzIHLTbMHBL-Ztaa7fahJCaBw301rXcPF4aw>
    <xmx:FD5zapOE__Z_9K5xy_Mx-Gies6pVMKYVY3B89GiBzyjk_okXrPgnsg>
    <xmx:FD5zasZyI4xsx3Bcl5Wr8kTAYudTC7K_e2J5S0ROtyE0ozCNGppi4YXu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:43:47 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Wed,  5 Aug 2026 14:43:46 +0100
Message-ID: <20260805134346.2776524-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080514-idealist-duvet-aa1d@gregkh>
References: <2026080514-idealist-duvet-aa1d@gregkh>
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
index 9ac5df16b1a9..ecde673578d5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5633,8 +5633,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5653,7 +5657,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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


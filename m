Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455426;
	b=hmTaPocRIkH9/HBEwHPnYiXuBouwOaEaVrQZivDrC6buZXq7+m5YlWD1LhskzzLjZy0N
	 lCvmUwhtf92BtPHd0bX+z65fZWbxnjDiX1FERoasKiLl/CaeCBlg6DViWDm/eSwXL9p6I
	 D02wFDX8YAowy8l8pfSqIltNORk97uLnC02+I75gCowdj2amEOUWGRsIdpYTlG+JuJBhG
	 VBR+6suIB79dNZ9nnpMLpemcaI3BMxPxzDMWVUW8c3DFTPp0W3NMMjMh4Kcru4W0QdZIA
	 HIbEUKCGSTB1svULPWhypiVdCbmHB+2z20aPT8fSIejA1NYSD4YBVyygI8veuIhsB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VzWx7GAXVs3UGq4MtUENoIm9tw68LBNyQV02Qh11VaY=;
	b=Kg4GIIUJ0irvbrAQimzSvU+LWi/y0QRhd2wQboD7y94y6cjLmiPiuN1aoIvTI99uGLu9
	 QV4ooPVmmRny4Vhvo9X2eXrJTzn70ip8Ul5RXDkJaWRtQFdNjMwdtPN/ulPXhvVIxOY08
	 VWrQ+Pte4MCjLfJy8FoYdc7dEr1ZWUd/xirBHu17BFPt4Z56O+JJbmnRXt3oXYs+6Xe7P
	 VEb5owmNFjRUHrY8KctWTJ/nw0fmYgNx4qFn5e3J9G0ZGp/jUsY55jtnPoioy3CWNF8TZ
	 mKNjuhBMo7FPkQskO0VR8JQDJrBzqQ8YEw5lTfcBPbzFr/Feugw2DWMw6gN1QtZKKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiJrO4Hi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A2606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiJrO4Hi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7D21F00A05;
	Thu, 12 Nov 2026 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455426;
	bh=VzWx7GAXVs3UGq4MtUENoIm9tw68LBNyQV02Qh11VaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WiJrO4Him5izO1gbMlrXhXgnYyub2jyQT1+Wm2ANa7SHASQ+2FWGEvgCqifdod4v5
	 E7axIT7nFf1EIkQWzxaI1En7T4dHaz9kQRKByARPyXsO+vpB9L1IOnW0/i3hvcdl0y
	 kwi9SukMM7jwzjPD+abG9RmViGTuxNf8/WQ5DvJFMFbBx36tkm2VQ9YMW4YwkZcmFC
	 bxumtwf0S/aNqPwbVgms5v1MsxdZR0W/wCv8xaU3TDGZ/xnVdlgpDGONYtmf2cvMAG
	 v3SKnF63yBgNI2I1jgosLKQe0OabDNFpSgQ6iJLMS4cvhStS5ZQ2GKnQXJiKVCgIWe
	 ACoOlmtBvyPlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Wed, 11 Nov 2026 22:50:24 -0500
Message-ID: <20261112034405.1566183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202351-failed-5.15-4c2dec1dce36@kernel.org>
References: <20261109202351-failed-5.15-4c2dec1dce36@kernel.org>
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
[ sashal: Adapted folio compatibility checks to page APIs inside the existing ksm_might_need_to_copy() function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c  | 16 +++++++++++++---
 mm/util.c | 13 +++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3ed1bd6085f91..437cecc415866 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2658,6 +2658,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct anon_vma *anon_vma = page_anon_vma(page);
+	struct anon_vma_chain *avc;
 	struct page *new_page;
 
 	if (PageKsm(page)) {
@@ -2666,9 +2667,18 @@ struct page *ksm_might_need_to_copy(struct page *page,
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
index af6c9bce8314e..ea436993a7cdc 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -778,6 +778,19 @@ bool page_mapped(struct page *page)
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


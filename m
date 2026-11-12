Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452134;
	b=Jo49KqxRNGxoBY6prQ3DTKwFHFlpRsVDBCsmQCupHDviCElTaQGxOMzPs6qHVa3m0RYC
	 BHZySmSVhbXlkZ+SCDZZfxObT4RLsGMyyVndJ5LA3cfe8RESicLPZKkuqc9eRMJmKEvpV
	 SLMuM+776MCb3dltnHQrSchnCNvz1CF1uSyXhwlkZD5YKjT8A31Z/No4teoD6yZUA9oxn
	 CTriogJPAlDUCHSurN5aVwQ/yidVISMXcdmQRzZMr0CxKO55iaHnkQUZBWODnnXZ7DpdB
	 yq2BQHV22cD2cir3nj02Yb8Sr6J+kiLXpDdDyCEn83mCQIFCMHD849Ps6Ok7m+wDvWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y8lXmTlS8kBuVlv1+UICzQ2lhYXXlQSCeWzK+N2TpCg=;
	b=l+IOl3EDxmvrxCHxC+ydjZG3GnQ8TwgSxoSu6osPwaJPXkOIgRHBVVFhv7P0taLDOoEl
	 W7DUhLqMq99maRcpRk2hTzpiFlDuV8gH3j3sHW+UBo47q5uLiGaqgdqHpJDVxnVptYE4C
	 T5qm/VpUEJfocHl72PvgxbsMW8UsiJd7mpxf08SMB1RQ97vvtPAX6h0oiyOg1j2JvAGKG
	 cmXu4HOuCeRqNHy/YR2BRlNpwX2FqTlWcm1kJDf3RuXl6U4uayHkG54A4g4ndlssIle9T
	 C2PRRFFOPl+FlTxi+Jgy1MeP7zaNjqY4cWHlKyLXGXwmztq4MQf5/lEjEBfbxQ89Dkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxcEojww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB9606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxcEojww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837521F00A05;
	Thu, 12 Nov 2026 02:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452134;
	bh=Y8lXmTlS8kBuVlv1+UICzQ2lhYXXlQSCeWzK+N2TpCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxcEojwwaaa95f+Pi2yKpREvoECVtr70cG19aaqbF3Ol812uAjZbW+CtLW39t8QSe
	 eYUWueSyb/r5nT3Dk/YFV4qs58LFXb8tDhfUXy2MS8QM/S5/SGMkQJMY8FUhbVTONJ
	 zc06qTH0d/3gMpIcNypZ5dGNx/W+zViIapMWYepF6wpM2vAkydIauucdmlNFlsf9MS
	 usZdiXPk/rUgTZzhX6U3Qe7oZ3/UslUNEMQIlGQKlCjYBFXzFCfG9vLBORSm5YPAvr
	 8lGG5DqDYrBu+I9Px7mVlPxtRKdgmm3Q9WtaMJHUkpRvuuaFMbt8nVMhvKTI+T/Bba
	 kK7RA4zIRJCZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Wed, 11 Nov 2026 21:55:32 -0500
Message-ID: <20261112024516.1377303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201359-failed-6.6-4c2dec1dce36@kernel.org>
References: <20261109201359-failed-6.6-4c2dec1dce36@kernel.org>
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
[ sashal: inlined folio_anon_rmap_compatible() checks into the existing page-based ksm_might_need_to_copy() routine ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c  | 17 ++++++++++++++---
 mm/util.c | 13 +++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index fa4229a224060..902258abee418 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2919,9 +2919,20 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			return page;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return page;		/* no need to copy it */
-	} else if (page->index == linear_page_index(vma, address) &&
-			anon_vma->root == vma->anon_vma->root) {
-		return page;		/* still no need to copy it */
+	} else if (page->index == linear_page_index(vma, address)) {
+		struct anon_vma_chain *avc;
+
+		/*
+		 * Careful: anon_vma might have been freed, so we cannot safely
+		 * dereference it. Add a fast path before we walk the anon_vma chain.
+		 */
+		if (anon_vma == vma->anon_vma || anon_vma == vma->anon_vma->root)
+			return page;
+
+		list_for_each_entry(avc, &vma->anon_vma_chain, same_vma) {
+			if (avc->anon_vma == anon_vma)
+				return page;
+		}
 	}
 	if (PageHWPoison(page))
 		return ERR_PTR(-EHWPOISON);
diff --git a/mm/util.c b/mm/util.c
index b8a7ec4471922..67b3d4014e235 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -764,6 +764,19 @@ void *vcalloc(size_t n, size_t size)
 }
 EXPORT_SYMBOL(vcalloc);
 
+/**
+ * folio_anon_vma - Get a folio's raw anon_vma pointer.
+ * @folio: The folio.
+ *
+ * The returned pointer may be stale for an unmapped folio. The caller
+ * must ensure the anon_vma stays alive before dereferencing it. A folio
+ * reference or lock alone is insufficient; use folio_get_anon_vma() when
+ * the anon_vma's lifetime is not otherwise protected. Note that
+ * folio_get_anon_vma() is only useful for folios that are still mapped.
+ *
+ * Return: The raw anon_vma pointer for an anonymous, non-KSM folio, or
+ * %NULL otherwise.
+ */
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
-- 
2.53.0


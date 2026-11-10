Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273242;
	b=bYsB8wslpY6TLtWnFMuuk3unRmW8ToDBfABCPrSj4vDkV4BauKRLH8yVG2KzhuBpdfhl
	 8eHKtU1fAWjfFkhSZLebxdqkyD1GfdtdTS6cfJZsv23N+3OjcUSkdbAZHWDTTTZMg5ojc
	 TJfRJQ3faUomK1t2Lv0Xg7uYXmnr7xWkYKLv2ZTH2S7qdDujbXq0RLMfDSVvPNjmw0DrC
	 sDK06ClLWXtQbfDGwwbS9btBMW0WRG6TSd0bYhHfIrdoLOYPoMOHaVnPKwx5ZtQz0eMyV
	 bkN+YBPC0pkGKamCq9CtLzBKMr5FzmQMplUgxDycQc5PQql4gxy8uN6teOctM+IRrxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s1X+xMHoFauHd5RStqHo0pluhWMek2mqq8pGVlk0z1A=;
	b=NEffjnGugRxwuz3sjFSbuoVMChJ8Amp0/Zz016EuqqgbDcQVwBtIWJg6b1BLIZFFfXQY
	 7cC7z7PPnq8Ja0eoFnAwTeBq2kARm7wBukjZSTbxzza6RqpQKHGUjFj4FPOfgYPX0/ahi
	 4XZ4poSSTcQZjO6lIL7ENDwRUIE0GRHCJeMB6kQAhea5YlneuM2A47cctpObI2tt7LDmo
	 wEYeCGI/fuENbB2OYEMqro8WY23/4onnQKlMiBbdmUSAq4G9uyaotApeyimtmdTrWjH79
	 Fd9+rYmcZk3jUA6sQwK3hvJPSDmVfb1lL/gvRE1SSubaxCf2hplPM3zwi6Aef99AzOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCR93TXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE51606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCR93TXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46DA1F0089F;
	Tue, 10 Nov 2026 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273241;
	bh=s1X+xMHoFauHd5RStqHo0pluhWMek2mqq8pGVlk0z1A=;
	h=From:To:Cc:Subject:Date;
	b=RCR93TXSFHTEHZj8YhpvYekwjG6q6hgOxRezjHgajlen4HVo1z7oNSIB5M8WGFT+H
	 OQRyl3H7ppK58UOupjGcCV1z5lWqgUX2CmN7873PFBnfgPB86s5Xf+KjK0y3nOvneF
	 MJdzWrHO/lMf4aijXR2GTdAi/Ektjpyv04SommOmThmBYomwOD/RQgVHOTgtuoCfeW
	 tmK/j+TQjdohZHk+xox0B6kgQPMXAptQzCiN4N24BhuJe9zF2eDSFPbTOv2eENrFne
	 Jd1C++/pBPS3qE5fEgxx4r+CyS4Eux1saBD2TsiuPVao2p8V7iBfUjVeiENp5lnVvE
	 z0UgfJEgBEt9g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	mason@kernel.org,
	ljs@kernel.org,
	xu.xin@linux.dev,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: fix use of a freed anon_vma at swap-in" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:59 -0500
Message-ID: <20261109201359-failed-6.6-4c2dec1dce36@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4c2dec1dce368ad9e9b1814307cb5ef3832fa07e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201359-failed-6.6-4c2dec1dce36@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4c2dec1dce368ad9e9b1814307cb5ef3832fa07e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:09 +0100
Subject: [PATCH] mm/ksm: fix use of a freed anon_vma at swap-in
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 mm/ksm.c  | 36 +++++++++++++++++++++++++++++++-----
 mm/util.c | 13 +++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 9c51925825cbf..e050b1bdf810d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3137,11 +3137,40 @@ void __ksm_exit(struct mm_struct *mm)
 	trace_ksm_exit(mm);
 }
 
+static bool folio_anon_rmap_compatible(const struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	const struct anon_vma *anon_vma = folio_anon_vma(folio);
+	struct anon_vma_chain *avc;
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_large(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_ksm(folio), folio);
+	vma_assert_stabilised(vma);
+
+	if (!anon_vma)
+		return true;
+	if (folio->index != linear_anon_page_index(vma, addr))
+		return false;
+
+	/*
+	 * Careful: anon_vma might have been freed, so we cannot safely
+	 * dereference it. Add a fast path before we walk the anon_vma chain.
+	 */
+	if (anon_vma == vma->anon_vma || anon_vma == vma->anon_vma->root)
+		return true;
+
+	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma) {
+		if (avc->anon_vma == anon_vma)
+			return true;
+	}
+	return false;
+}
+
 struct folio *ksm_might_need_to_copy(struct folio *folio,
 			struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *page = folio_page(folio, 0);
-	struct anon_vma *anon_vma = folio_anon_vma(folio);
 	struct folio *new_folio;
 
 	if (folio_test_large(folio))
@@ -3151,10 +3180,7 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
 			return folio;	/* no need to copy it */
-	} else if (!anon_vma) {
-		return folio;		/* no need to copy it */
-	} else if (folio->index == linear_anon_page_index(vma, addr) &&
-			anon_vma->root == vma->anon_vma->root) {
+	} else if (folio_anon_rmap_compatible(folio, vma, addr)) {
 		return folio;		/* still no need to copy it */
 	}
 	if (PageHWPoison(page))
diff --git a/mm/util.c b/mm/util.c
index 8acfe2148ba52..80f6c714844f2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -697,6 +697,19 @@ void *vcalloc_noprof(size_t n, size_t size)
 }
 EXPORT_SYMBOL(vcalloc_noprof);
 
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
 struct anon_vma *folio_anon_vma(const struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
-- 
2.53.0





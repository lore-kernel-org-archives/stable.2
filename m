Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450218;
	b=AFPFtura3tYl8r2amgUFtoPB3dwaaBgkrAZeRrBYA3n3Mw8+KeXvebgi+AMU5l9DyjDx
	 eUkh1Es3MoeUklnoOlwznxeCPg9ziIhMoetsMxn0iwAJoJAq+jx5nm+7YCynNYNJO7/b8
	 pkryj6t/aps5L9IH66L3meDzmZSPM1BtYw8f3AAhVnDiI+bf8/wDYG+spusut3TgjRSPr
	 uHbfy7UY17tLJqZYiq1Z4xnaqgLIqn2SmAydZwkuEcuXhUBmuZPaioOxsG89YBikZLOMf
	 9F49jUn9Ahkd067R+Jzn55YXCYBpYxzWqe6+F4/fYTQDLqmwhIHkmBtn1K8NEFJGcsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jna9adLG5h1V4+iTdYUVCVgRGCs7b7EMfiN4dk8fhaw=;
	b=kHcLaMj5EWgKxgGyTH32v7f4jLWzvDyU0oN7xndOxV2QNtl/yMnYDf+yxMZiY3LkOFUP
	 OUfHI2GrncHT7WUelqXxWVNCjtN7ALXc5nlVTjylrUsYTNq+5EH0im5fEQRE5RO1Rwxwr
	 fGy/djO59lMd6UHI5Ofrz+FLBnQW8P91urRLCm94zByM3HpVkyEvQIrx1wE+/km9FZXyL
	 tnTu5DC4gN8nTgreHDbQ7rd9r155COjsNLgTgS371+uW4Qc7vn/hIkGeOfaQf1wpbgN0I
	 WEBR+i8llfSzmQ1lV1DjY/JzAF3uavgQIeAt2jyercU81sCZBsYAmnrfoRWrFPfDAiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap0K3ZCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466E606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap0K3ZCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B377C1F00A05;
	Thu, 12 Nov 2026 02:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450218;
	bh=Jna9adLG5h1V4+iTdYUVCVgRGCs7b7EMfiN4dk8fhaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ap0K3ZCYkGBpm+ZYkYMO/CAsf1fckoTdTIzbOtzbj+MVANHdlRq+FOCXtoofq88p4
	 QvS8V1REqXYgVSXUysncsD+fRxqBQUuU4uKXA+3pmDgZ/0wlTwD+Mo/+xODD0g8DhR
	 Au9DsxrQ31uId9jeS6+JDsNhP0TmE1lIBjoIqHDsujM+zbj3oOZNT6xFhMaD2a+HvM
	 9u1km7LsXnaliDtXJYxq1Dm0tUFLTMjSCIumAtAtNMJ+okPyZYydaZFvlQfkzZ2t+T
	 h3wBD0dZJRxFqZYDdS1lGA4O44z3GsCCveZcwrcQWaW57tKWv5oQH5hw4Ey+M5k5mq
	 ocoNWkDiv/xfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Wed, 11 Nov 2026 21:23:35 -0500
Message-ID: <20261112021215.1258651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200923-failed-6.12-4c2dec1dce36@kernel.org>
References: <20261109200923-failed-6.12-4c2dec1dce36@kernel.org>
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
[ sashal: adapted the helper to use linear_page_index() and a non-const folio parameter without the unavailable vma_assert_stabilised() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c  | 35 ++++++++++++++++++++++++++++++-----
 mm/util.c | 13 +++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8ce4cd5a382ce..e64a0dbcad5dd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3059,11 +3059,39 @@ void __ksm_exit(struct mm_struct *mm)
 	trace_ksm_exit(mm);
 }
 
+static bool folio_anon_rmap_compatible(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	const struct anon_vma *anon_vma = folio_anon_vma(folio);
+	struct anon_vma_chain *avc;
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_large(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_ksm(folio), folio);
+
+	if (!anon_vma)
+		return true;
+	if (folio->index != linear_page_index(vma, addr))
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
@@ -3073,10 +3101,7 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
 			return folio;	/* no need to copy it */
-	} else if (!anon_vma) {
-		return folio;		/* no need to copy it */
-	} else if (folio->index == linear_page_index(vma, addr) &&
-			anon_vma->root == vma->anon_vma->root) {
+	} else if (folio_anon_rmap_compatible(folio, vma, addr)) {
 		return folio;		/* still no need to copy it */
 	}
 	if (PageHWPoison(page))
diff --git a/mm/util.c b/mm/util.c
index 4f1275023eb73..8c6d8d4d62c4f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -820,6 +820,19 @@ void *vcalloc_noprof(size_t n, size_t size)
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
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
-- 
2.53.0


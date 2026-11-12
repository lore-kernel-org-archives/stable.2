Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447749;
	b=zL82LAzprKakYmvqV/c7qZMORShX09U9LYjlyO9qSU/SfLle05WKlqSyYEIjqCiG1LJU
	 PCpPlKjr60S+SXD3QnPK7CFB3Qek8/HRyaEomKIrdD2jWIkmTItBCd0RtZfim6Xk3I00c
	 07DqxFT7jNbxrOpzucHZFwqERRzfaSwIlp7kBrO0BRgM/PMuqOcEblSmqJIu2e3HhEcYX
	 vLXfp2yvxl2m8QOe4nT1A4Bq+PS7JhpP6hj+odoBYZtUmhjEq5/ETl8Sin4+ZaekngQZ+
	 1hYq8X5HGgXd/zMb1L0TZ1+Q8cxrDXOziPeWUOVfP9YFOYLkUKuVmkxP0D1HWKTsDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BHcBRQ3iHeuAf3SS57vHF6Z9/C9bxi+ZO0Y7ebvFVz4=;
	b=FBAynir7Bby8uJupLMCr9zbsbMwddcDWOKTDzjrzXwnlEcELNOZo9NtB5doHJiarz1vY
	 fcDnc+zp/1G7VEtDSnhI9UpJzkyLKCuhipI9tG0LlwWMm2ljaZDiM1zOxreMAZMaJDvKA
	 bRxyR1SFerzpTTk5lBRDGbQ0KrCiFwF6cchyFP9Ptx+po6F48u1b2lwb3rnU91HbRwZAq
	 zofBhuaRrEUB1lH/KNiUydV3kHicBq+/ubUJbxMI1gsbttIVOBe1W4bMdyQXK3+iK74US
	 hXVmGxsKlAz/2e+8JNz5oXrWRvMj01J/j3cbn6v/8vIFTWhloDZj6RLFYzESSqTiLGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auHSWLel;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286B606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auHSWLel
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E41F00A05;
	Thu, 12 Nov 2026 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447748;
	bh=BHcBRQ3iHeuAf3SS57vHF6Z9/C9bxi+ZO0Y7ebvFVz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auHSWLelWzo3MO2YS3woRB4SUHrfHvwysnVVOQOpTwO8Y4TiLVOTZT8oN7RYPEEwV
	 NnVpnCNyYSkGceC6IcM250fHW+fhs8ZjCWolAnkWBm9MNkiNK6w0Gj9lV7nN924WCp
	 /FiaDWODGTsKVXs6/CnVCQDPDDL58Q7wDvPJBoyfmLG552LhBmS5FPGWBFkW7un3CO
	 pNjKYuCKerAryn/kflFH2/UoBYGHe2llcL84vt8t/VOC07SQjS98SJXr9wA6nuGleu
	 kK7z5SU1OvesYV2YQwpFSadMzuhWVmA9KbM4tT+qVj6+goP+GzsfSzXrjNSnGv52pS
	 sv/mPPO/5Ekxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Wed, 11 Nov 2026 20:42:26 -0500
Message-ID: <20261112013216.1227890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200517-failed-6.18-4c2dec1dce36@kernel.org>
References: <20261109200517-failed-6.18-4c2dec1dce36@kernel.org>
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
[ sashal: Replaced linear_anon_page_index() with linear_page_index() and omitted the unavailable vma_assert_stabilised() assertion. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c  | 35 ++++++++++++++++++++++++++++++-----
 mm/util.c | 13 +++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index bcaca6e99b1ce..78dc717633818 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3080,11 +3080,39 @@ void __ksm_exit(struct mm_struct *mm)
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
@@ -3094,10 +3122,7 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
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
index 31a59c038ba0a..ec9239b1ea1e2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -668,6 +668,19 @@ void *vcalloc_noprof(size_t n, size_t size)
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


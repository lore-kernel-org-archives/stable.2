Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46A30ACFF
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007343; cv=none; b=L2zCSemdQgrVxAxKc0yzw06CLcEaxnja9h0ttIxwEFc4FhFbJwocAlMuFYkz2ux7VGYu7epMouauPSyzRyR1FygVqvRfqtHTXCbz5Nlbi1kZ3oZhY1PfiqQzPbe1RztXIK3L6RuWg8XggCg0qLtQ/qJCVj9tbEiEvI6PYcP6VXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007343; c=relaxed/simple;
	bh=E3PqlsXQqVqc/deOd2kY5vHnNNIjEvjDiyaoJk5tA4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqyPLKnlow7DViCZyqYJD3yEpbhqAbltFMY21TYfNYCv61eO/A8FSfv/K9ZQ3lk8s/pEZA9iNgaYZOPhn7bWB1fle6ktif+q0BxqZVmT6mO3/KsdO5jJF6aF4HU07dOyS+f5Cuv4FByn3aLCZaCdvodUWZRe5pBO+X4eNE37J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP6PkLiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP6PkLiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37AA1F00A3D;
	Thu,  2 Jul 2026 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007342;
	bh=Z3wAEB9MuuyQgdz6Wq19MjzziB+0fVpyCfK0I5xUSSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WP6PkLiDzf4A4OJ9+oZlYDzE7qd2cruUGKkKPa5rpJR8Mpg70j5aZ5ezDL34ejqfi
	 y0g6DmIcIJeKclmJim9JEZ1pin8VzmvljtedA8X+kW/75vQyUANZw4CknMA7maIJmz
	 mbpxJ1o3eUsMNW8x0tG8aAKqNzhZvaGeDLvkYUNz7vTaR88ovYW04ujXxBoEkAFQvB
	 0UwP0XC7eBVpGnWWud8DD+pQk0v7kufGAamFETBTuMhGLkPVpcPDCZOMzBCXXxr9qZ
	 PIwiVsdCv4kSj56+dmlbMbKcT+mjqLi/CXcNFYp6w6f/7pC8X+Hqm174rugf7lKymI
	 9RcMXzKWx+vTw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A3FE2F40068;
	Thu,  2 Jul 2026 11:49:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 11:49:00 -0400
X-ME-Sender: <xms:bIhGagIbcMa_Qn-FeD57QqQQyOtXeQb_0IbCTk22hUNIcK8884O6gg>
    <xme:bIhGaoVcSZoLON3OA20fS4_wvZMkWDeMvldrG3BJBW3GOh8qvJm_HcDv5X3KDrFmj
    OTcjxAzt45bYKmBra93TEbyrcJU9qC4KY2wDmDieiJ0lhd4fqnVOjY>
X-ME-Received: <xmr:bIhGasSkcsQJ7-JiCySglvsBDzuho8YsKWw3JWQkA2LxXh70fNUJSvvSLQEGgA>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7PU
    8ghd6tHhq8OfeuIk4+yeTtK43ZBpu5ULQkdrUfD+FXtczLKGjOdOj+dO+arKELZRSruBG6
    FxbobCvpo2W8UG27w/6ZI+ol6BjSHFb954xaAmmAtJSTW8qD+hSefbUo/zGKzpwf+p/Qrh
    BKkFGscPft090bi8I3e7WZCXZRywY8sAkXd+sqIAHCd9IrRDlHVj314ft9/Qfh2AEa8VZu
    kgrN0zkQaqqnvZUxiVw0Rmkps0FG18ALERcz4LfeaibVv/UGSTvtBAV5BvU5YNP1zAzPt3
    u79GHwZg5rNJqaR3WumP21gMXAZaBTWe4pcFgZ8s/YpE2+HUyDEj4ZD190vw
X-ME-Proxy: <xmx:bIhGaoDFAORg7ILj8EcvTiqyxoEImApFhhr8xm__o0P-Om1trvTYyw>
    <xmx:bIhGajJbE8_0yA3nY5-fyx1bYsmzbuuSPe0nF_Jtr97aJJqPmTb8Bg>
    <xmx:bIhGajCTKfSa7_glYjGUkcrPIF3QoGZfTI-Cff0a4LpMe_x2ZAwtoA>
    <xmx:bIhGaovm-28Y8PkvcT7uUnZnXCnXCUOnBaIdwxWa0fbhXpPgCUC6LA>
    <xmx:bIhGahR2t84wHlx9YCIIFOp_zo2JYlcCKfRd1Zr46UHDdjbKPXItpxtK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:00 -0400 (EDT)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:48:59 +0100
Message-ID: <20260702154859.975356-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070240-sultry-bankbook-e1b3@gregkh>
References: <2026070240-sultry-bankbook-e1b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
without taking the page table lock and then apply pte_write() /
huge_pte_write() to it.  Those accessors decode bits from the present
encoding only; on a swap or migration entry they read the offset bits that
happen to share the same position and return an undefined result.

The intent of the check is "is this fault still WP-blocked?".  A
non-marker swap entry means the page is in transit -- the userfault
context the original fault delivered against is no longer the same, and
the swap-in or migration completion path will re-deliver a fresh fault if
userspace still needs to handle it.  Worst case under the current code the
garbage write bit says "wait", and the thread stays asleep until a
UFFDIO_WAKE that may never arrive.

Gate the writability check on pte_present() so the lockless re-check only
inspects present-PTE bits when the entry is actually present.  The
non-present, non-marker case returns "don't wait" and lets the fault path
retry.

Link: https://lore.kernel.org/20260529172331.356655-6-kas@kernel.org
Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

(cherry picked from commit 8e80af52db652fbc41320eee45a4f73bc029faf2)
[ kas: apply to fs/userfaultfd.c and fold the pte_present()/
  huge_pte_present() gate into the existing writability checks; this tree
  predates the marker/return-style refactor of these functions ]
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/userfaultfd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0d6c00e9b493..6773227fbe88 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -251,7 +251,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (huge_pte_none(pte))
 		ret = true;
-	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
+	/*
+	 * Gate the writability check on pte_present(): huge_pte_write() on a
+	 * non-present migration entry decodes random offset bits. The
+	 * migration completion path re-delivers the fault if still needed.
+	 */
+	if (pte_present(pte) && !huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
 out:
 	return ret;
@@ -332,7 +337,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (pte_none(*pte))
 		ret = true;
-	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
+	/*
+	 * Gate the writability check on pte_present(): pte_write() on a
+	 * non-present swap/migration entry decodes random offset bits. The
+	 * page-in path re-delivers the fault if it still needs userspace.
+	 */
+	if (pte_present(*pte) && !pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
 
-- 
2.54.0


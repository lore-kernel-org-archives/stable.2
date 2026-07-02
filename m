Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848D33E35C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007349; cv=none; b=ouq9XeyPJywM9NZLrDnMDjFSj5Tyz0fvthP8Erwjb9QWRkBpsjOv6s4K0xAMYjLa99jB9k6XQdX+CS9crytJbIDnC6IaABVHYgOX0hwt1Xg+tQb6sUU0NYYT32ZkshLMjpkgmObHyuahCOwp7w1rcjkiJBN87TD9onZzRoqcQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007349; c=relaxed/simple;
	bh=OS5un17BQ48G/FDo4X9DwVmtBnb9t/17LP3y8+/kNco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAYNyKy1CL4zs24eB7RrHfZpZ4dCzmbtUA4+HFA0YWedkvJz3QKsIqBHzaGDKlTkNLBMx3hn72Hr/sacq8JG3ShRFxCu5t6Wb5Iw4hgKtTJoVwLHhTtkdjQQQu/e6k78OHwPUms7Pu5NaLYnI6aoOQAXOP8479ytKdxcQ48Ez+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGYcpaxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGYcpaxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D21E1F000E9;
	Thu,  2 Jul 2026 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007346;
	bh=/4tQxja0CIhrk3u6hPMQ17QSrBUXUcSigd33nvZsyWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGYcpaxACq1uYgtWtC9qQJnZZ6LrYfhzi7FfSnT6RzwfSTUZBO8oASPh2vSA72296
	 NUUozpNC4yyZk3Pgx6ToSXLv76PBKjMUOmbAj3VAWX3E1/kTynLYJTfeK29Ck4mI7/
	 gRE4T99c6gFM5ISqGyOSSti25zqIa3oR4x2Uj4DGOp+Yhb1k0p6b61fjvlCJh88rfs
	 s57zrV3zOFqmK/Y15CcHNb+GEuGCT45Zw+xn+ZfAik+vg7pkMVdPi9TPYcpicB38/g
	 sdUDg75GyuB27+pekyWhXp+uhNF6vl/uxVHahFmRScvRz6qa3WdNyLlDfXiYvpF2sl
	 iWv4o6rEkmdSQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 664FFF40068;
	Thu,  2 Jul 2026 11:49:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 11:49:05 -0400
X-ME-Sender: <xms:cYhGajOIwp025y0Q-ApgnHWNenvri7JXe8Cm7SmtniwNgfF_oZUmtA>
    <xme:cYhGamLgp322C-Usu9eNlCh3zHeH1dAROoW_JMsHSHHMW4c-8hysKr3gKvJHcr6af
    45tpAjgxRTAArYlkkBm1oM-jFBP-TQ3JnCgeEflwASinOE2jjm0DQA>
X-ME-Received: <xmr:cYhGat1X5bMoVLpRV3HBKGXxVZCOVVlX69fEihA9NZb3Vum0UUDjVXCgLAkJPQ>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7To
    c+k8wlPZ0neSzblgF14q7L7Y3i4OzfaoTWavNVj1IfCGWF+lMv5VW+XbSZGm2K0cri7ZqN
    tonVhpqQhlFvL5ewDfY2ebsfoRUDRuROmwdvZkirDbRcAVJZPKzWfSsRfkzybjTXdA0Zhl
    WSmLr0VzJPoqQ1K/H+Mcx1268kCMwcEXzS5IVQILOuoBpvQYISXpcVbMunKP2WSM6X3W9v
    T5uHkff0i/BgaQbjT8nVOrDpcfKfj4+rX3QwhwRBcr4bX/4FJf2Q7mRM0ijhqctOBmzMxE
    2CY/THT6DXDo68Z6PDylkE/DRmEneJVfENm1nadGLsC8RHNpPzXkCTCWraVw
X-ME-Proxy: <xmx:cYhGaiV9y63nFM1Ncpk5LgVUcEIflQLpaZdcM8eqTdW-MsnEzXfRcA>
    <xmx:cYhGanPKfT01Ghvmxa-iLnsjA6dbM2ic6J0MluySzMLjVRzIzZ3yGQ>
    <xmx:cYhGat1XW4XzLwp-kZNV1ylFKGOf_oLe1qHk8y8LEatGb-nrGTtzaA>
    <xmx:cYhGajQSXE7GC60zYySvJTDxqvJSRYTe4W69-Nywvap9kSiHD_JAfg>
    <xmx:cYhGagnjr7JY-JghzHVOyXDEri5dvoRv_ueeHowHk0WsiXPLUaj7ufoE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:04 -0400 (EDT)
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
Subject: [PATCH 6.6.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:04 +0100
Message-ID: <20260702154904.975468-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070239-armless-humpback-0396@gregkh>
References: <2026070239-armless-humpback-0396@gregkh>
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
index 74c468cc432e..49f074262598 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -300,7 +300,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (huge_pte_none_mostly(pte))
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
@@ -375,7 +380,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	ptent = ptep_get(pte);
 	if (pte_none_mostly(ptent))
 		ret = true;
-	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
+	/*
+	 * Gate the writability check on pte_present(): pte_write() on a
+	 * non-present swap/migration entry decodes random offset bits. The
+	 * page-in path re-delivers the fault if it still needs userspace.
+	 */
+	if (pte_present(ptent) && !pte_write(ptent) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
 
-- 
2.54.0


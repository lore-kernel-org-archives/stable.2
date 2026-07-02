Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960730ACFF
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007354; cv=none; b=S9Qht5RSYfE3GYvClg/W+oh2v+C6RReDqIRTYmQnGmkJklPLUOGYUWAYA9QttoJapkOolVe7xUydUgzzEvyKv3VDz0fKX0YRPXH5XsFfBAE8UpMpchcLJcU/R4gMP/bOAZThEI5JLDcjWUuwm3l6RExwPMXZ5jhfgAkqI4nyQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007354; c=relaxed/simple;
	bh=RDZSJqRNICQ3tD7uC5O4G/7iRPUUCsbOrhVV2kU4tcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKmXcEbtR4aimtax4GbHlCLfDfb5S9zPJRIMjHnRcbM+CY6bPzfUwgpt1719KMLyqyyxnQ9pInI67NOC9lN1RqW8hmwuwAMJ0yTiIbGimOc8gwugGdEB/zCLrtJ0RxC5T0YKb+ApgS72Rpuo9iaedh7vLCnOoHa1wjAAEI8WI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd9f1YOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd9f1YOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB701F00A3F;
	Thu,  2 Jul 2026 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007349;
	bh=DFhQOIHWTHoFlKX3iXpR7xXeEZj65AEZOPGhkZDpMp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sd9f1YOwk+6lQIH2k+VsF34zfTihVix4CeBr6PlrQK62jLfuKJGpRhfkP8bGiGEcQ
	 VdEYEzHb3cdzZ5K+zTyg2gKHmSZdqf7jDlGriowMbwGaiv3y8BoZW6ApnmXqaRG1hp
	 SMXGLtc9Ovkz/MDOHoMHaE16SwHacqgpqa/2tRjLnNqrjHFulDaGQOksWgRbeLbLCz
	 kF5PaQ3T8T9PeEik4hAFlrIC5fMEL4krfMenwyBAx/+OOcictH3cXjsxaFKrJhI+Oe
	 v2QrzMDcsMghzGzKr942iecKeRoAPi7TKFCOz/XZnNGx8XboOOqVZjnCUodfwjxpmc
	 WDEZbDI+ky7ig==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 888F7F40069;
	Thu,  2 Jul 2026 11:49:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 02 Jul 2026 11:49:08 -0400
X-ME-Sender: <xms:dIhGao92NEnBdAIzBwkaGMpsPUTAgDh9f-vOs63Y0p1vD1szsJAtOg>
    <xme:dIhGao4FIV7KJ73zjalN1hob_waNDiDFwlKC5jt8MbZ28omHefSqjRdiWfUQBMJL-
    nSmwK0ksbliU01h0IFXJjbzoe_VFPsXXoUHhMriP7qqp3CqxjRBuw>
X-ME-Received: <xmr:dIhGapmzb4sriCWbA7-XLqZgMGY3qhbit9wgtKhizXlW8yLzfwlo2t4lOl01KA>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7Vf
    3GiKJci/HMJlzBe+LyMqSocVAuRNGVFYGaIMLIXvAD3qRMCEegplxAyUwGQXKnjQkdQZ8R
    NQc6u6oJG91xbTS/zuIwi+qmKthnm34oEPWvmwoPxP7kNJPUksPZ4vFuoHduhxgOG+TfCi
    pRc07OLjoA5jntKMzYPBPl4LFGQFquUDN2geMKSjDmO99tIXaTYuJ3+Tk9ODASu4GSBW0b
    RrPql85vYtDl70fuGDLM1uPwZgbw6Q9FrLSchGb0naquSfE2R0YY/W/kUAOQT0gqpg728p
    YKvTUsJU5CLxxXu1/syz4SxiN0ngZmP0bbQz25Xa/+y3JzYbJlfTiXQ43vTQ
X-ME-Proxy: <xmx:dIhGajF0b1tkjj0v85XndwWeee_n_3ykHzIUq-jek8_ssb3EwmJ8ZQ>
    <xmx:dIhGao_CUqN7bbfYOxVPS9aGApDC2ZDSGF_0a7ee-7L9uzSpVVz6yg>
    <xmx:dIhGaskjwjnHo8Zb4qXv_l048M6ReALNLCn7_Eph5hoQ0AyH4lh7_Q>
    <xmx:dIhGarDt5h7Nuh0rdNZWKc4pflFLjPF3APiowYC6BlurFqGZBn4QAQ>
    <xmx:dIhGatW-UB0GJL042u-RcsVA9AdCT1IN9i6lgNbKjMPsZeK-H_T3DzWD>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:07 -0400 (EDT)
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
Subject: [PATCH 6.18.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:07 +0100
Message-ID: <20260702154907.975486-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070238-shadiness-ivory-4087@gregkh>
References: <2026070238-shadiness-ivory-4087@gregkh>
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
index df18fb453403..1377b76fe3c5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -251,7 +251,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
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
@@ -326,7 +331,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9A31AF2D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007346; cv=none; b=pepu4ELQ6YRBJne45Ov015liMyLkNgjfp6Kq3pO0UHemdX+iR1RfrT32iS5Pe5okty4Chvmjl7NGkdoRjKSfeau2IB4RDhbPC+JHqJP02V66biJAwB6X81WtKLhkTD/uZyPEoZkPftWQSAVcYiWvJdjOQkHiA1scLB/4nvdiOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007346; c=relaxed/simple;
	bh=2HCsY+XdRJoQZm/OzGq6cSgoeNZzuVPxrVOCFskJ/AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d07297nqRUirPSGsCIMyUmhAXTjo55nUEyvHMKLkUML2/fXuvbeDg68dY26lfH2rjb0puZ4AaXiqhUUcNV5Vh1PWDOXFaoaxuCki7J6VGA0YeS/A8L/gjG9Nkshm0ehZoKcjcDpM4aUpxtevXFZDoOBs10+m0svTTP5c4Teptlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOaLEPE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOaLEPE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58481F00A3D;
	Thu,  2 Jul 2026 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007345;
	bh=XoUhM18BERiuJ9PwuUmPnDCKX/WUcdTBVUTmXpO/ajk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOaLEPE5Xbvba6ewnOY76jgMsZE8OGf/Go8fBCU67u3SnrTNRm4ywsoC/l61XVSl1
	 7G0rCHiS9YDK4STLZ828hkIiig86MQTOmQyi2j9zsXlPg9iEBAmrLgyyfp6bN6Zz48
	 EgsAQ8iHZvq16uzVqxTWlDX4ztKZE//6jVPPZueKOr0ccyZDp6gE74byy2D8d5DHwL
	 oMuP/N+rX/pbToSkvTKYUVQ2K/g8EPcvYh9GKunV7dWlUGWYM0dyKbHBqgkze4T5bR
	 hNE5luyrohCmg7FExUX0KgEZCn6NuL7YFqjgTgqZ0rtKV1bNMZ1UW6ziV5J+tKwDtC
	 mZk/KUBfSBBIg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF5ECF40069;
	Thu,  2 Jul 2026 11:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 11:49:03 -0400
X-ME-Sender: <xms:b4hGaopf-d0wCo4vGXy5o_ID7vPFQpmzXsYhF384Nl3AEJRtulGzXQ>
    <xme:b4hGam26rRDIo5MmPNuBtrxYLEzzyncpG1lvsSg0lgsSJuptGRDygVj4bQesisP9a
    qzZuJcnuYFqcWtNpEM-s6rcmK82SdH4Sesy6__9Tt8GDLQm3fiIMuk>
X-ME-Received: <xmr:b4hGaowQbRvRxahvjatah2n33Y5rCURzZ-f1qH5NlDoNiQ9DXoOgHCTNQZ4YNw>
X-ME-Proxy-Cause: dmFkZTF1vRgtVynWsiQ2KQyYddXmYTN2POwtBxQdqcveT4l+Q4wv5YVlz3ZsaXEBFSiacX
    AS3eluxLlALbL/+oEbeP26QXXgGRoRclJkMvlQQ67J8AUfr3u7jHU3RxjkVFmfsIlWKw1U
    f9CbVf6fWN11XNx8630yBfD0/4wLFRXlidIBYa3UqMr/twRYSsDhFJkSkao3ZXTB5FEyrw
    nW0MF4hOwELCkQ6CMHeOE0agtPVbdQ27b54D13NOxBAfQaWc02sQsYhGTuBHUM5WbCmWAA
    EwehyYgdrb9lCXp8QvSnlxUb/y3r55nWosN4Phr37Tlz/R8NCQpZ2Sv98Mpv4N95F92fb1
    0RMBueUN4AxJIadLZGQdJO2Cu6LrV1rrkpdzxmiN7fRQmWPH0aftw+X7RYGsUrky9V6YSs
    1DsUI5Qdi/F/8KHp3RjSrwkV1KA96TqzVbsC8MwJzrSozMN7XkXN4frJLhyrwsfK/6TT5W
    IsWjsNJ90E/GKbpUqczCmXfK1rMoDBdSq5VcutDRTTCPwwezRhVzh7vGGBB1hjHyIT5igR
    43kXghbAE/k2YaEA6J9RkWbnTVp5eneLBY7L5MePh0LEJqpxL4+nnq5k5kPBTPemeXDSnN
    C2czBRewIpYphjfhuor7C8N0L9b73RTpLLD4xEb/6kQV09BVHDil7jQufD7g
X-ME-Proxy: <xmx:b4hGaqhZ1rWRwNIH8ofAcVsSw_p86sDAEsnh7CCJJ5kdtzcnVd06Qw>
    <xmx:b4hGajpg_04wiiOYPpYRIjcLLMWv3OjXfP5XI13RcE6By9tMSK0m4Q>
    <xmx:b4hGapjnjAtYQiEKDlrUZ-H-uEC4fSG-YfzCsW_9HArlE0AC1KEH6Q>
    <xmx:b4hGatNG_KLxYf678QkhAruTddhgvJy0CDcuDMeRptq8Uqdua-yCmw>
    <xmx:b4hGarwkwQ48VegGrRMA3sFP0r3WpdCS6OlNg5rYt_jHRApfpvVp3h7n>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:03 -0400 (EDT)
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
Subject: [PATCH 6.1.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:02 +0100
Message-ID: <20260702154902.975458-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070239-eject-banking-8632@gregkh>
References: <2026070239-eject-banking-8632@gregkh>
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
index 7f8b397597b0..6ebee2b3a5a8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -273,7 +273,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
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
@@ -355,7 +360,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (pte_none_mostly(*pte))
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


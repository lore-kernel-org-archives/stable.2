Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415031355D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007357; cv=none; b=l8DHYr/+tksFiumTxyUDS7YRRD+zVKUi7kAsuAAiJEpCqL0qu3Nuxmsb3HbL5nuLrO6V8AZlDXz6d+uS0Z5zaB7LBOFWNtF7WNOT5SinMrtUBSH+GUm1bm1bumn7H+iWuSR19HlvEspXhix2EreARGFx3Dg7SwZ7u2Z/un1XrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007357; c=relaxed/simple;
	bh=XoyVG3Gk3MAAbbvOhwUWr8j4hodi95DXtvh67jM78Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4EAco+BoBoQx0/n5GPbSkdLc1Z5I/qWuw1YKi1Qr43pG6dpbZMfGt9OIbw5WmILpAwId9arzh8u27Glh+nDFhuxFzC6lFCOb4M7tWhlIqKjnGB9OLCsAhfLlMVq6UuNpS1Ynp6QKniKFi77AcycJY8QDn+XCgfSc/PIKKUzDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZntcUq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZntcUq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E433E1F00ACA;
	Thu,  2 Jul 2026 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007351;
	bh=2PvkKmGz6/f+zLwaxJ5es9zCghKUZnxCl8dar40vQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZntcUq0A+itlpo8fILOswsnOEaCEscZRdPtgd4w1YYpAIkphlSD1GdVz9LrougRn
	 oX+pk1Bk88waMksSHhPRapeRiJG7Y99vi8uZYRnCcvPcvERZw23toAc+wZGpX0htfx
	 H4VlNoNPdpQ6NnMVWhJDYT8e9STSKG57svuyoKNR3XNhcmfX8++c3BL+sYR5g5WiQb
	 abKLe4oUrPNGjwEyvaQhEXCSFKwH8HdrWCMNEq7vYShoY/jnd2/EIPID87BWpqZtdo
	 lgBnEKvBFqWySZeQ4kjtlgWTP/b5S4CUUWglVkF2aSk9MYVT97iTJ1ZCjD81jsuK5g
	 l/EpcIB6f93Mw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 08BD6F4006A;
	Thu,  2 Jul 2026 11:49:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 02 Jul 2026 11:49:10 -0400
X-ME-Sender: <xms:dYhGamUDnRwouj4JjmynbAFCcI3dqVPvJqxP09g020dpgys2VvkaHg>
    <xme:dYhGaiTyfYAbS8H2-ygT0mHXYWp_hAZYn2QOSXIPKVHn3eoGS-TBrWSGSuFNwE_po
    aqtyFVvjBhMkcyS5hhJBdjhK11_7UdqZ4kd5b1uVodJs1e5JL9atA>
X-ME-Received: <xmr:dYhGamD31LAxzUhvNuSa1GkHpQaIrsx6CgcbSolakQKbZYO3pxs7uKGXOXApcw>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7Dk
    /R7OjKClZbcQR974PAxUJOOshnhHnEvVlXkmwYBH7BYIlxELBdcNvL8GfZGacILR9pO6Ua
    Tzv7RYnZXL8dwu9FdveZzUDNcSmvPyZpv3+x9lmsrs0q/QHR90khe9q8MKUfOBzx5aizb6
    mUxJI7lQyJfTHXxVUJJ5oVrMHDtYu2luli/PCe6DE24ORhMSWzWyAB+IPFnGdA0PiFyw9b
    eAsPVExBRcVkKu8hSUazF27fOD5Us5TODjP08ckySelLje5lYS3qCBr+OII41Kn9vZEdt/
    TxeSpDBnCND3cKeLZPKzARVsIClAS/pWzjy/xhsLgurUtvVRgrhjqhFK5dtQ
X-ME-Proxy: <xmx:dYhGapLXu-TlsMM--7zCuhw0jPT0b40DvwcB3Ip7gGPmJosFU86Uhg>
    <xmx:dohGahDIJHXe_Ld3M8i16oXpCLlRJMwP053tkW2eIdfuZv15TRGyTA>
    <xmx:dohGauup8grTgqh5lpOl-6Ehg9H1GY3ruazQZY8N2CrSHwoRu_XaAw>
    <xmx:dohGavTl0NkoW1hGKIA9TJvdsJ-osuC4a6ccrOsK6SKprSSdi0wpow>
    <xmx:dohGalJazMkOeZBOdZD34KoGUjEYScoFCx60PYUNxabQjgwCjYtm7oDW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:09 -0400 (EDT)
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
Subject: [PATCH 7.1.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:08 +0100
Message-ID: <20260702154908.975523-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070237-oversold-dairy-c1ed@gregkh>
References: <2026070237-oversold-dairy-c1ed@gregkh>
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
[ kas: apply to fs/userfaultfd.c; these checks moved to mm/userfaultfd.c
  only after 7.1, the change is otherwise identical to upstream ]
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 fs/userfaultfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4b53dc4a3266..648249037731 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -253,6 +253,15 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(pte))
 		return true;
+	/*
+	 * Concurrent migration may have replaced the present PTE with a
+	 * non-marker swap entry between fault delivery and this lockless
+	 * re-check. huge_pte_write() on a swap entry decodes random offset
+	 * bits, so gate it on pte_present(). The migration completion path
+	 * will re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(pte))
+		return false;
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
@@ -339,6 +348,17 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	/* UFFD PTE markers require userspace to resolve the fault. */
 	if (pte_is_uffd_marker(ptent))
 		goto out;
+	/*
+	 * Concurrent swap-out / migration may have replaced the present PTE
+	 * with a non-marker swap entry between fault delivery and this
+	 * lockless re-check. pte_write() on a swap entry decodes random
+	 * offset bits, so gate it on pte_present(). The page-in path will
+	 * re-deliver the fault if it still needs userspace.
+	 */
+	if (!pte_present(ptent)) {
+		ret = false;
+		goto out;
+	}
 	/*
 	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
 	 * resolve the fault.
-- 
2.54.0


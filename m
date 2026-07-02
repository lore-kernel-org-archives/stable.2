Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBD31AF2D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007344; cv=none; b=sCkq69QBQ6kEAsKSvlfBtZLsP5Bi3ApHrh14zi0oeB+m18Rxc7XcU3JOG8mhdXkM7ng8Bp0NMpvA04iG971Q0kG31M0lDjq2ScykLDlsF1o6CzCmG5MI4eytgrRU70QTskw7n0A8P6G0iqFAtBJcF43fPcyInpVoHwJvkokBUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007344; c=relaxed/simple;
	bh=Zd4yG/QSiVOs1aUmuaHm7FASVagb16I5i5mzer1zCCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdxMWz4UYNj0BtscMzcqneyL17UvKLKfwvz5Xf8CtGR7CtrU1xauQgZtz3CEJED7J23pKl56uw0+pdmufHUaglLMtOZjgENyzh07frdPt4lUXXcBzdHIuWIfgxrObOpKNWhTc7yvEp5Q2+iWWKDqOAQNocxeFi039uIW9q2ehoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na2QKQGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na2QKQGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF61F000E9;
	Thu,  2 Jul 2026 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007343;
	bh=+89XCyuENSANksnjhQn/pTdLf1Pbda6axUIjZcmffgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Na2QKQGF2HQxeQJVB2AHJ85ou2pXTQmea6AcrJZ0e53ecn/2HSOx1YMINRp6PyG+S
	 axWFqnsYIVU1twUMG4XTUMfpwzxA3C8hNEAlq5NT5lLQqznyz+E8ziQHcvcdVqXRHZ
	 jz16AOScvutTGZ1bkSL/7QRDmfdT2gjii78e3euRzf19V+3nVHXBb6tEbdYODMpUl3
	 fZqYGDKfF+ZvNI3zhSe8v+eWOjeSYMq4wtfdZPFwe3oxgzrhEe7YUAqA6lv6O2ao1o
	 QjnjomeYhFbzXhCjumgg6JVoG6QzUSKDhK6tldmvUWhfLYtQTWvYNfEAAJU20/47i5
	 dvSw1bFHZqVRQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49522F40068;
	Thu,  2 Jul 2026 11:49:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jul 2026 11:49:02 -0400
X-ME-Sender: <xms:bohGamhTk8ouZ7MjD0GLVvgd-6Y09faKM275ZXLhu70-Tc4Sn0Ellg>
    <xme:bohGavMD_HNM9VuMTLvF_wfH3u1k9m_r9CEVxYT1oDqmyXoDfHKC3vdwBE-muD-bi
    lzpto_a53UA9dVcRqWIc9d0uaDYAF6AdsrmCDaVnBunKnc7ZvFh0Q>
X-ME-Received: <xmr:bohGaprCWLVEJnZk0vopXd7_-jYx9Y9BAbX8FdoiMtQQpsYnzANpdoAl67Y4-w>
X-ME-Proxy-Cause: dmFkZTG0Ih/t8cHbMCodKXQLkUxQJqy59wDK3mLTRA7dVIErvl2/d1Ah+epBvIXb5j+AYP
    IXeEFDcIBfVLytuYu4/vLDhgRVlW3a+843BEiRDknGKdd2YPYw+W7qSRgjHbAB7tPzyIg1
    K/iaGu6PpbNvdlBe1ylT3w+4CnduN7fXaIiVz2SFU4GsotfIh0Hdi2izsWXFRQyA1Pgmvd
    bz3VM1BdljYqC26bMo/Uu8GxRLOKa/FHGZ/ez2IuhQ+NgorPxPnwdGD70mq06prVA+bGMW
    J3iimRYR/yORdPuHTUcQx20NCsiqIhAYZRtSAvfP/TF7cp/wxVykEXOIXpNkkJ9g0C+7OF
    aKFW7YuVKywECuWyp3k31tGp9nqK3J5Qbc5yPxNdLa8uS2QYYbpJDB9VL25Q5c4xIEz6wV
    kxQfjebchCnaW+J0JYdceXblKF7ol+1dyZuusl9EYh5FqU0+7azS0T0H5yZg+2xsND0k7A
    Tgq2M5ZuWDSr4leA7mdnXfIYq1tZsYxkSdxdIEle29IMDw9WrylmjWpFHneJXkH6MW/C49
    buGQaWIVpdB1Lw0GO5d6CeViMqZnfTLXfBQ81QTYZIv59vn7xPrrq92Tq6RrVeuEnFlOgV
    WKYP8L/2gCz+qyN8NIrrI32+QEAg09VPEVXt/RHKLntcUsbkEeEt6SjYVAsg
X-ME-Proxy: <xmx:bohGap69EUrWjDvQgrTRiLxW7Hju_DfrAxl-qntMpKV4RA8nhkHTcA>
    <xmx:bohGavjz30Jj7ammTOnDdptRt7TMMk5gN6I1McpTVvmQ-qFe3nOLSg>
    <xmx:bohGan6DEJ6DHbWzUMwefbXEzdPU4CS2pQzt0fFbbHgb4vs18m14pw>
    <xmx:bohGasFLHm_9YhRQf3c3yp-uvpXukBdry-UowMn5nyPtVvM4Nd4iww>
    <xmx:bohGahISE3lCXxSoQquanKFmuj8PFPCbG72lhiDXC4B6jdQ8DslZ1g62>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:49:01 -0400 (EDT)
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
Subject: [PATCH 5.15.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Thu,  2 Jul 2026 16:49:00 +0100
Message-ID: <20260702154900.975365-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026070240-femur-pork-cbe9@gregkh>
References: <2026070240-femur-pork-cbe9@gregkh>
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
index 868405f3cfa0..271ce399f6b6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -249,7 +249,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
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
@@ -330,7 +335,12 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
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


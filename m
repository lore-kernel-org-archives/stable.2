Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534598;
	b=G7RbPKUbNvz/ddyVWK+nAx7YRAT/zkh2ntNOLugszFJOTO6mF4P1q7RSfJrMpQozUbOv
	 hJ5FR6mIFAcBPaXnpBF5Up9waOdIBzsHbSmclMonYNIJmS4V/OnkDUNSMJ/6mv0OBbXCE
	 KrUuP3kfqkj2NSNAIweegmu8Q21PHyl7vTzw23dG1xBUpgdjCaXvVAh/3emEoRWXgSiiu
	 nqNtYBej8UetMK15YhASSl+lazSvvd6Tci94lmgjkfyjkAmcqkwb3F9QC66g106ckS9uo
	 us2Io837pykAu8QHkfVqGc7Mcl4wC3XssDcFz6Segfi8m6JGn0FatGYRk5NaFQRzpIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534598;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NCR3tHIir7LmseO1jBCPN/UzE0JIGrYQbMeLn/gvGcg=;
	b=3b3M1HGhvHBsmaOXR1Zk7qLndOzx2aXUiej1Tu+Ypped8FJIigVzM+Aa2sR8zhEwaGpe
	 MMR6zfw908Co+CMEESCKPs/t3YtpugEFPWb3qZ2szLevzO6NdTu7uMUxHSeBGpGAtLimi
	 LFfJB+ehUT12D0XaAu+RleZ41K0tbZoZu3XBu1Nrh/UxFxVRjI7eyrTFgbuxzdJjO97Ln
	 BeqxOy99kVi28ZMf52+EaBCL6dOLVBfmQYdf3YXESl612TR8XwFXBqzoyOp5WrLwThbIV
	 gb3sRmMoMFsfxzThet1oMsh9pB8LvFTdTfcPZNgiTwrJoJZ+WvPoKjorF55b4GWyc8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=peF7CJu2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F65606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=peF7CJu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F91F000C6;
	Tue, 24 Nov 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534598;
	bh=NCR3tHIir7LmseO1jBCPN/UzE0JIGrYQbMeLn/gvGcg=;
	h=Subject:To:Cc:From:Date;
	b=peF7CJu2adAd7dyVTQE0UP9MydF8h5NsMmPMPqUlBcEwXAw19fmWW+9D1Pwko6CQ+
	 CMBEMrYeNi9J2lPlRuPxPNp6rp414//Zhx3ux7lELzR8WRJi+/HhxDj2jPfx0ipRcx
	 GOotC2wZ/N0Y9GfcFN+X6wBuFgYejOkQRlE9YlRI=
Subject: FAILED: patch "[PATCH] mm/page_alloc: retry alloc_contig_pages() when the zonelist" failed to apply to 5.10-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:36:38 +0100
Message-ID: <2026112438-underwent-easiness-72c6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x da0d7a895e9021dc2cffa90fb6fafd8b9379e544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112438-underwent-easiness-72c6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da0d7a895e9021dc2cffa90fb6fafd8b9379e544 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 31 Oct 2026 22:13:38 -0400
Subject: [PATCH] mm/page_alloc: retry alloc_contig_pages() when the zonelist
 is rebuilt

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.
alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
and nodemask, then loads the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
caller can get a range from another node.  Gigantic pages are kept out
of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
non-migrateable gigantic pages from movable zones").

Check zonelist_update_seq before using each zone, and restart the walk
if it changed, as the hugetlb pool walk does.  Check again before
escalating to the pass that may migrate hugetlb pages, so a pass a
rebuild cut short is redone rather than escalated.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
{2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
and neither with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-11-gourry@gourry.net
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 98c17ee12207..1c3ad1af77ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7570,6 +7570,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7578,8 +7579,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 
 retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -7614,6 +7620,9 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 	 * second pass, we will try moving HugeTLB pages when those pages are
 	 * smaller than the requested contiguous region size.
 	 */
+	/* Redo a pass that a rebuild cut short before escalating. */
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	if (skip_hugetlb && skipped_hugetlb) {
 		skip_hugetlb = false;
 		goto retry;


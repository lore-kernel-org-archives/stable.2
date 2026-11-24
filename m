Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534584;
	b=bzzDL7rZmX93lnlX4F5VY4meGRTaIj1detNNfV35OpG+NbL3qw9S5lbSLNU1zwCjIlvD
	 68VKkufgFUMoyv5uIsJ6XW+WfZSkL5Q7SZH0UiLC2wrOeXg4MPDTsJWuwdTEx64YjJBph
	 OXtGQOzbMKHXpXmpQQN/zlIJqOEi1z38HL0z81Epm8Tsan/RUCiJd0KYGCgBOwBPKwhLo
	 BOvMAkpuT40+YMCCvYrBKLpKfonwZj2JwfZGt39SRchoHdS+eQat6iSpZp0NUEqD5lW2p
	 UrYpe63BrCgzw/0p4Zpa03pE8eSH9pNtic+luLk/Zh9D0/EfbL1dnTI/dyqgKD6YJrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534584;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oEsErZ9N5w+tSoez+hiapj7jth9SAzx/Gm18WQg9LE4=;
	b=l/GouRjSGz0/KMwECJQRkHBXdZPfS2IH01WFFFXEDL5yC7cDw/tZoXjjBHKKBPvCWRDA
	 1z9sa+NL4niK9edAHifyT86sqdEd5aHAe6HByQSLTbYboJG4D+5f2GG0345BfxcbnXV2X
	 1tyYPTg0WR5iR2Fj9Fu4FmJkrMqoypzuubpIU8zxyhVZeaW+ivl+HRrupGY3GjAd+lcfY
	 cycbk+aHqYd8Pu4wvtWQlx3QXPio8FnZ8+JHAyyRFyFUDUcoAIBh41qPNWCqU3Z3Y7uEg
	 1uk6J2IG+6dio14GXnt6aDcibUu+OZvMOSHrkYp7p0ZCs0Pby3Rj8eS66EK/Rk3WPTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OWua8RoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2139606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OWua8RoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576341F000D4;
	Tue, 24 Nov 2026 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534582;
	bh=oEsErZ9N5w+tSoez+hiapj7jth9SAzx/Gm18WQg9LE4=;
	h=Subject:To:Cc:From:Date;
	b=OWua8RoNmdhvEBcXHr5xcLnPBIwDP2XP3B2D85ehDgMB1Em+ZTXWbI5w1cawPEBNw
	 Zpya9pcuDjzNwhWhDXtt2PayU+CzlvVcqeVnDCc//4a9xd0ygmtztRgD8WmEPmMsR3
	 Nq78OGXMYqKH5kJ9vpyOXgjeug898mBuW+2Tjsbk=
Subject: FAILED: patch "[PATCH] mm/page_alloc: retry alloc_contig_pages() when the zonelist" failed to apply to 6.18-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:36:35 +0100
Message-ID: <2026112435-unnoticed-capsule-b761@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x da0d7a895e9021dc2cffa90fb6fafd8b9379e544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112435-unnoticed-capsule-b761@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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


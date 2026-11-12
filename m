Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449766;
	b=1gTC0N+RRlr7LSHCuIQbRkkH0Nh/gLXNWDIZ3uvV5kFKvKrlYs40pWSMRJD9fPvRR7QA
	 GLa7ZZQMxPnCoM2QZJXwvh4UELcnoVuIhK+ibknkEKBnwmLBW576nH3P6X4X7DZL2nMnH
	 g8dq4+2pvWV07ao4OAZgyMlpDiAHwcC5cRlbP3Cmax4QR2nf3PJkJquMiXnPfBSbEWXag
	 0IyDZ8Qo/oekAi6l6O8uwObhS4lKqw2RZkUeqFJLl8yS/aO+zvSF2CeDTISV2NZWfZQ4u
	 yaw9yABwZNQVS4QJaDlocGEuF5POzI+JRDn2X188IWuDQDOfP7foLngy0s2o3GMYR6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449766;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FwTv2GjEBlQR54GrEgezu3FqUMu0/uxeIqk78GyVHCk=;
	b=uivqFVGAjPbZOBgKC//CnzAwLr7xCQq4SULgA2HbM58lHQ8Qt+IasOx3O2r963d56Nmy
	 W71I+LgBp+WbdVw+5azyVw4DNgvqyBbYnYi5jds9u8vE+/zKcypDXYfVEFKo5DzBxSGHt
	 v3CWgsrBemqF06A/0b2GVH0Zwhbhz0Rib0Xr1ZKYrepcfy/Jna0IBK0r5HPaRUH+trvKD
	 05A6veyt1Xz6WNQNoMHd6Q16U3wtotV0vgu/ejqGn+l5A4tr61r5XPDoqBHoFSiNQY/G4
	 5WX2JRNxV9FS6pqFBWxbF8/o3Kpp6EWYnRpdUApRTJc0i5wmoL2vCbx9twDrWFB+bxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TbsS8hG2;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E7606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884E7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TbsS8hG2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QdTK9vDoJhaUIW/U2XIf5FYJQ9anojdg/JfxOCFPB4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794449763; v=1; x=1795054563;
 b=TbsS8hG2H99euT9cfkFIu7YsULdZtjHsHuxSUFjw8Hba4NXZu0/Oeq3XY6uQpyx1OOqVd1DF
 z7x4fvyzNZq/zZl6+T91em8H/T15Ux3brX+voPeNeCwq+sbApl3nH58ZfYLLQnQ4uKiDZnML1JQ
 qApNnAS6yCS77VRM1mXrEV70=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8cb470a74291e90a;
	Thu, 12 Nov 2026 02:16:03 +0000
X-Mizu-Trace-ID: 8cb470a74291e90a
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Thu, 12 Nov 2026 10:15:33 +0800
Subject: [PATCH v3] mm/hugetlb: charge hugetlb cgroup and memcg in
 alloc_hugetlb_folio_reserve()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-for-alloc_hugetlb-1109-v3-1-7a144510a373@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2Zq2AoIn/8MQA8sCq01rWiASw
 r8L6NXjm8zMmyGQZwpwiWbwNHJgZ1c4HSLArrQtCa5XBi11qpTMReO8KI1xeO+GlnpTiT2WiCU
 mGaV5rWAdvzw1/N6Pb8WXw1A9CPvtbWt0HHrnp9086q33kyj5TzJqoYROznmCFMdNJq/PybB14
 YgWimVZPmoS6KLPAAAA
X-Change-ID: 20261109-for-alloc_hugetlb-1109-0ccac58e69d1
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>
Cc: hongfu.li@linux.dev, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
 Daehyeon Ko <4ncienth@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794449756; l=4820;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=pFMQxDRwAloKyD9un+uH5Do41KW7aYnWyhIKwB42GmM=;
 b=/krm/uLaEvhDJqjULlNLgkdgLTXQAtC9oZ422Irx8PjuQC4YU55WHVduK3DsU3hy4K7MraGOi
 h+Slav7AQIXDQvA+jQRTMv8UzitiRTOeRBPXBGpqA0hDZJWg0X+/dif
X-Developer-Key: i=lihongfu@kylinos.cn; a=ed25519;
 pk=rUpDSpB3neoNZRlGG6dHlFb3RepiJakcev+ucyqaZzw=

From: Hongfu Li <lihongfu@kylinos.cn>

alloc_hugetlb_folio_reserve() hands out a folio from the hugetlb pool and
consumes a global reservation, but unlike the fault path it never charged
the folio to the hugetlb cgroup or to the memcg.  Folios allocated for
memfd_pin_folios() through memfd_alloc_folio() were therefore silently
bypassing the accounting: they are never charged to the hugetlb cgroup
usage counter (hugetlb.<size>.current or hugetlb.<size>.usage_in_bytes),
so the limits (hugetlb.<size>.max or hugetlb.<size>.limit_in_bytes) are
bypassed.  In cgroup v2, with memory_hugetlb_accounting enabled, these
folios are also not accounted in memory.current and are not bounded by
memory.max.

Charge the folios to both the hugetlb cgroup and the memcg, just like
hugetlb_alloc_folio() does.

Test with a process that creates a hugetlb memfd and pins pages through
UDMABUF_CREATE. The counters were read while the folio was still pinned:

Before this patch:
$ echo $$ > /sys/fs/cgroup/test/cgroup.procs
$ ./memfd-alloc-folio 1 &
$ cat /sys/fs/cgroup/test/hugetlb.2MB.current
0
$ cat /sys/fs/cgroup/test/memory.current
1351680
$

After this patch:
$ echo $$ > /sys/fs/cgroup/test/cgroup.procs
$ ./memfd-alloc-folio 1 &
$ cat /sys/fs/cgroup/test/hugetlb.2MB.current
2097152
$ cat /sys/fs/cgroup/test/memory.current
3313664
$

memfd_pin_folios() can now fail because the memcg charge fails. Two
tasks allocating concurrently against the same memory.max may see a
spurious failure. That failure frees the folio, returns the global
reservation, and undoes the hugetlb cgroup charge, so no accounting is
left behind.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
---
Changes in v3:
- Updated the commit message to describe the new -ENOMEM condition on
  memfd_pin_folios() when the memcg charge fails, as suggested by
  Gregory Price.
- Added Gregory Price's Reviewed-by and Tested-by tags.

Changes in v2:
- Rebased on a tree that includes Daehyeon's "mm/hugetlb_cgroup: prevent
  use-after-free during cgroup offlining", as suggested by Andrew Morton.
  No functional change.
- Since 268d64fabbf1 ("mm/hugetlb: fix NR_HUGETLB accounting for surplus
  folios") reworked the NR_HUGETLB accounting, use mod_hugetlb_memcg_state()
  instead of lruvec_stat_mod_folio(), called after a successful memcg
  charge.
- Return early once a folio has been dequeued, instead of falling
  through to a shared return.
- Corrected the Fixes tag to 89c1905d9c14.
- Updated the commit message to qualify the memory.max claim: only in
  cgroup v2 with memory_hugetlb_accounting enabled.
---
 mm/hugetlb.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da1c17f14a62..256bb2095b59 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2223,12 +2223,19 @@ struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
+	struct hugetlb_cgroup *h_cg = NULL;
+	size_t nr_pages = pages_per_huge_page(h);
 	struct folio *folio;
+	int idx = hstate_index(h);
+	int ret;
+
+	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg))
+		return NULL;
 
 	spin_lock_irq(&hugetlb_lock);
 	if (!h->resv_huge_pages) {
 		spin_unlock_irq(&hugetlb_lock);
-		return NULL;
+		goto err_uncharge_hugetlb_cgroup;
 	}
 
 	folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask, preferred_nid,
@@ -2236,11 +2243,31 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 	if (folio) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
-	}
+		hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
 
+		spin_unlock_irq(&hugetlb_lock);
+
+		ret = mem_cgroup_charge_hugetlb(folio, current->mm,
+						gfp_mask | __GFP_RETRY_MAYFAIL);
+		if (ret == -ENOMEM) {
+			folio_put(folio);
+			/*
+			 * Skip uncharging hugetlb_cgroup since the charges
+			 * were committed to the folio and freeing the folio
+			 * would have cleared those up.
+			 */
+			return NULL;
+		}
+
+		mod_hugetlb_memcg_state(folio, nr_pages);
+
+		return folio;
+	}
 	spin_unlock_irq(&hugetlb_lock);
 
-	return folio;
+err_uncharge_hugetlb_cgroup:
+	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
+	return NULL;
 }
 
 /* folio migration callback function */

---
base-commit: 2c5dafa7f289d760f4492260b0988029aab478b0
change-id: 20261109-for-alloc_hugetlb-1109-0ccac58e69d1

Best regards,
--  
Hongfu Li <lihongfu@kylinos.cn>


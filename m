Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290771;
	b=p0UQCBfRVIHqy9UM93gY1Z2HCqeb9LfRJOk5a9qTCzzDepmYrAd646FEG06SG0ZXZt9/
	 Bpq6q+M/KDxkkc0nCXGdLj2NE73Egmq8mvzpp537csmKdB9KwUJgGi2ggZuXcseKALF/r
	 HQMC1kpXJfqQAeTgC9DRgP8pL8BZMiR/9gA887Z7a7FZoQXWIAgrF+MU8+aiHgedOiDCW
	 AqxjXP+wfNYR5tTkubREJW8x1V/0HyktX3He+Cu+8fraDzU7uw73HxhF5AF/uCesmi+j/
	 A97wT73AzJPy5Kl40Q1NWH6Y3Cyl//sNkhr3L58CL1aTzHNObDbWjCAAK0yJ4pCGKYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290771;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=782GmxyFzfSf9cS8To0AwNPsA3l9Ic+2fBQKfnHkhgs=;
	b=VWPfSk1VCWv0vpswip0kIocLVXVN4BCSjw6DdyzJh7ZT6b+BWmz1ig2GVka0GMUZ7ebM
	 pqeHGvgzj3f21ls9fOxmkdxk1od1oEdmEjMDeRGLch6SIy/3D67z5JvETfTSSPDkF9990
	 q2BOyJQ2AakpgEWv0Op3fcl5KBX2EY9gjb96LTt5CS6Zpk5u8QbO4X12VVlj+BmyC1kjH
	 ZCxkGfKkS3UDezNW1HduMnKrRPK4FcD/TAtc5D0GpBd8JKiCVGW5+4jyfmnE0+rgBzFXJ
	 +2z5UYgGoAceP90sl30LRWh47fJXgy4AQZBoCnDAArkJdWebNbhm9m0oTQB/APeCrqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LNL3ving;
	arc=none smtp.remote-ip=91.218.175.79
Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF48606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF48606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LNL3ving
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Qn99IbL0tjCg14t3VJn4RbTaLqaX5gh8tDLA/0sbaFA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794290762; v=1; x=1794895562;
 b=LNL3ving+fxbEK9pr8Ym7VT41SGSHfO6hW43i4RWxp10cdVP85ocYorX7C1VsZANtL29sEmF
 c3OUG+OaNVUQKdf4o+dJ3kZj56lx3j0zLHFvykdw4mT/S8H4n2wdV44p/Y4cOvVuNO7f+Wv9k/+
 Vg3hfSPxXPDnSJvDTgjwOJnc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0dab969928a6af50;
	Tue, 10 Nov 2026 06:06:02 +0000
X-Mizu-Trace-ID: 0dab969928a6af50
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Tue, 10 Nov 2026 14:05:34 +0800
Subject: [PATCH v2] mm/hugetlb: charge hugetlb cgroup and memcg in
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
Message-Id: <20261110-for-alloc_hugetlb-1109-v2-1-25795ce44f80@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM4QpAMBSG4VvR+W21rQi3ImmOg6Nl2pCSezf8f
 L763gsCeaYAVXKBp4MDuyVCpwngZJaRBPfRoKXOlZKlGJwXxlqH7bSPtNlOfLNENJgVlJe9gnh
 ePQ18fuG6+R32bibc3hrc9wOwAr27egAAAA==
X-Change-ID: 20261109-for-alloc_hugetlb-1109-0ccac58e69d1
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>
Cc: hongfu.li@linux.dev, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>, Daehyeon Ko <4ncienth@gmail.com>, 
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290755; l=4187;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=+K2qRQIWYp4nrXE3VguRotyo4IOkkSIXCtrdykxyQqY=;
 b=GIgizEEZ8nTXph1cEv8EAm4eZob/if3HWtcDVOQuQ8Y1ipBOyHd1Ve5iF5KaqD2pZBsnrHSQt
 GVWYlvdbewwAQxFS6W9BWVtRueBeUwMacw9TH+qNQmisMWHLXl3N+eP
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

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
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


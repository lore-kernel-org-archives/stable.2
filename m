Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486032;
	b=TCxuNCBRzM7Gh9i1CzugzHZpTTAAovvzH0qHzpZBAUHXEmyqrmibfMzV/9rH4w0CpIDm
	 WtyRdwPx1EioU7d6RM0mCpxhMHf5eix/IPF/eEKs7eDQbEwPsJaWLzC5+ll0BDmz5gqT2
	 9C3aHjR4iXtIMesM2+GtPW59lJ1DR7868N4o7GhWQ+AqfPn9Tvz/j6Q1oOb3il3b1M+xi
	 CpjNLl99QDfNDT11DnlCDwK106kchMsJa815M4+c613HxNSpc2B4/84IIYc/mpQl2cr6B
	 jdjEMD171gdM53WKBoTUSCaFLSTOo4gE/joz+0LtstePQ3DQEF5zqb0RRrZ3xnDAfJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486032;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=54htZqDx8IcPvoQ5GW/HM2qiVh5OPSFZJzSyn6By+zs=;
	b=Csi9lWRKJ6zoy/aispupxPpegKPetWBOgnzkIoAfu70fL1G1e+eDRbpxErpF4a/4pvnQ
	 lBoibmGnA9Gf0vQf1IwM2kxDQIBcDj5cwE9dja33KCmE3/sMbBnJ2qzxkttKFVSRNLPFW
	 a6AJaJBHSNp0HxG0FyQfSBIwcZBMfyC87PxnT8WUrwVVBx84Z7xUJjwLioHtAHZe3Ie2u
	 Mcvgiu8rU9hVfeH8x2oar47/Flp//xpxfCnFa/j4T2/aFRWOr4iE6RSiL2nCVj4DIuG0N
	 seEExK/srob5BbkLz1h/4QKAnciw6uvkw72K19q1XD7hLmhozuDQ/it1JSN50AWZsjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F0ZLLANj;
	arc=none smtp.remote-ip=95.215.58.147
Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2960A2601
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E2960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F0ZLLANj
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xCCvVkqwA/gvOvrWt1gYYjIKWBs4Cqg/yh1DeergSOg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792486029; v=1; x=1793090829;
 b=F0ZLLANjY9iV2f894FrY3RftmNVEagi5f688G6PpzyHhwgrvb/kkks/0tOr3s3dyY5ua7PRB
 Z6CtLd8aLSsedz8fNapTFcjaZcxc33qFfbrhXpgKSx6TxxbbmBw/VSpqO6E20BkWceiH3RCEOdB
 pDRvDcY8YKhg0ixYqt34RRHA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b46a699f94547d5f;
	Tue, 20 Oct 2026 08:47:09 +0000
X-Mizu-Trace-ID: b46a699f94547d5f
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
Date: Tue, 20 Oct 2026 16:46:30 +0800
Subject: [PATCH] mm/hugetlb: charge hugetlb cgroup and memcg in
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
Message-Id: <20261020-for-alloc_hugetlb-1020-v1-1-e6eac82dd754@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM4QpAMBSG4VvR+W11tkK5FUmzHRwt04aU3Lvh5
 /PV914QKTBFqLMLAh0c2S8JMs/ATHoZSbBNBoWqlKhQDD4I7Zw33bSPtLlefDMiKWsrXZRWQjq
 vgQY+v3DT/o57P5PZ3hrc9wNf+nEpegAAAA==
X-Change-ID: 20261020-for-alloc_hugetlb-1020-00e2dd7a56d1
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Steve Sistare <steven.sistare@oracle.com>
Cc: hongfu.li@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792486026; l=3395;
 i=lihongfu@kylinos.cn; s=20260915; h=from:subject:message-id;
 bh=smxh7KjhK+88XH3fNI2hv0AD+wsJkhBDxzNm2aVgsW8=;
 b=mtTAju+8iai/GzL9RcaM34UF7B+nDlXEw6LQEc+TwcOFbxGA0v4acni9RBgeuHdmIFG1iesKY
 Vb0qrWq2EhaBF53Ewq4gnMFh5NcmbaO4S/c+DDATLwivzCytr3UuxNu
X-Developer-Key: i=lihongfu@kylinos.cn; a=ed25519;
 pk=rUpDSpB3neoNZRlGG6dHlFb3RepiJakcev+ucyqaZzw=

From: Hongfu Li <lihongfu@kylinos.cn>

alloc_hugetlb_folio_reserve() hands out a folio from the hugetlb pool and
consumes a global reservation, but unlike the fault path it never charged
the folio to the hugetlb cgroup or to the memcg.  Folios allocated for
memfd_pin_folios() through memfd_alloc_folio() were therefore silently
bypassing the accounting: they are never charged to the hugetlb cgroup
usage counter (hugetlb.<size>.current) nor to the memcg (memory.current),
so both limits (hugetlb.<size>.max, memory.max) are bypassed.

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

Fixes: 26a8ea80929c ("mm/hugetlb: fix memfd_pin_folios resv_huge_pages leak")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 mm/hugetlb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc..62b819b84faa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2193,12 +2193,19 @@ struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
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
@@ -2206,15 +2213,33 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 	if (folio) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
+		hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
 
-	if (folio)
-		lruvec_stat_mod_folio(folio, NR_HUGETLB,
-				      folio_nr_pages(folio));
+	if (!folio)
+		goto err_uncharge_hugetlb_cgroup;
+
+	ret = mem_cgroup_charge_hugetlb(folio, current->mm,
+					gfp_mask | __GFP_RETRY_MAYFAIL);
+	/*
+	 * Unconditionally increment NR_HUGETLB here because if
+	 * mem_cgroup_charge_hugetlb failed, freeing the page will
+	 * decrement NR_HUGETLB.
+	 */
+	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
+
+	if (ret) {
+		folio_put(folio);
+		return NULL;
+	}
 
 	return folio;
+
+err_uncharge_hugetlb_cgroup:
+	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
+	return NULL;
 }
 
 /* folio migration callback function */

---
base-commit: 2887e63d2e8e0cf55402612d8996ce955a2c3e55
change-id: 20261020-for-alloc_hugetlb-1020-00e2dd7a56d1

Best regards,
--  
Hongfu Li <lihongfu@kylinos.cn>


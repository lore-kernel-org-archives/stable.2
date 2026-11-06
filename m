Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002849;
	b=NW+O99oikScid4kRC9gcJqpxGEW3Tg7jXr9NbOW7dH7WmNw/GsO9vWOp6FkFAmiioEKC
	 jm1zzy8jdaif9p6zvNHrncugdgTjDbbTIFYCqRWvt3IWGSzehAqKv1tQUfYrXHqHzJmL1
	 4V7j0bMPJQB9EZQf/aJLdeueLlTPNrwB1siVKlyZTHGbdnDhi9C5LqniO+VwVa2Hll3vb
	 laZHuEQYIgUyDUbs354bBVNDqEQgv9sIM11MV5vLCgRnIlkx54h5ijDd6giAW70KMOeB6
	 v7Ehb8NhZA7zB/xrUwp8IKZEg5JPL7pJV4g0ko6r0v3apeGFyyz/1qH577u3knrt8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002849;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=hljN27FJOQcafFkagbdcshN27epPCiw3mH4c5x0nBM0=;
	b=0SKIB4pIIVY3eRdi7/qVW9aPyiCgi6Fk+uDSgn2dznt9EE8+RGinRFFg43SME/xNWhch
	 hmmp0nDb3kLelqx5BxFwvCBeYM7tSh6UQjClAZVQ/QHjiYSywIDW19md22ai4O2rTxT6l
	 V3OeJfPDdmx2egVKz1WBwkRBE7grEBWnpYt3MktHgrJmeqaxQRt6btSLk/FycNUD5GFbB
	 pWdocw/IAIY8jZkgrN+GxNmmK8B7l6newhxPcy5w2b4MsHecFf4cYdn0JSy0vVm+m5C4G
	 QuSwBb/ViaKFeismwuWMmYli6hveZT/h5R5R2yfKYZLzVe/z5Ep7JPaciPAFphKiM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rsW+e796;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D4606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 22:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F24D4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rsW+e796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794002848; x=1825538848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hljN27FJOQcafFkagbdcshN27epPCiw3mH4c5x0nBM0=;
  b=rsW+e796cLWle3+PuKK/u2isTYio0xR3S1Pu8prSOBKK0yVtzkfCF8qA
   RiqhLumGyA+6FIlZVlbzLiaQZ52BZtsPfPVQlZnMyE3MU+t3fc00mDWh9
   hGbHOTc3h8G3Y9cpSKil4NSdNXfRuIMchOohCeY8Ye47en78Ydi261rtx
   LtLwwXjG1tTTt06hDObXgOdR/T51sLM0DaORuuy0C1nh3BwukVvsmePUo
   +FXAoyqB8QqxKxv3X23hjofjzontpCxbjJffgGowhGDTtp52bt0QLgNU9
   U9SlQefqnII9JsGaKJStIMWbvuZ+IV2MrQPDqykBvZf+9O1Ht9JmJ04Bc
   g==;
X-CSE-ConnectionGUID: B+rTyIGwQpqaxY4DsXe9YA==
X-CSE-MsgGUID: aEXIzBKJTgqu99q2PrcDcQ==
X-IronPort-AV: E=Sophos;i="6.27,199,1787011200"; 
   d="scan'208";a="33137117"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 22:07:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:20636]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id 371097e3-7e73-414f-9548-a5feb17523b3; Fri, 6 Nov 2026 22:07:28 +0000 (UTC)
X-Farcaster-Flow-ID: 371097e3-7e73-414f-9548-a5feb17523b3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:28 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 22:07:27 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, Ge Yang
	<yangge1116@126.com>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
	<21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH v2 6.1 2/2] mm/hugetlb: fix kernel NULL pointer dereference when replacing free hugetlb folios
Date: Fri, 6 Nov 2026 22:07:15 +0000
Message-ID: <20261106220715.2869940-3-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106220715.2869940-1-mkbund@amazon.com>
References: <20261105070346.3099207-1-mkbund@amazon.com>
 <20261106220715.2869940-1-mkbund@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Ge Yang <yangge1116@126.com>

[ Upstream commit 113ed54ad276c352ee5ce109bdcf0df118a43bda ]

A kernel crash was observed when replacing free hugetlb folios:

BUG: kernel NULL pointer dereference, address: 0000000000000028
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 28 UID: 0 PID: 29639 Comm: test_cma.sh Tainted 6.15.0-rc6-zp #41 PREEMPT(voluntary)
RIP: 0010:alloc_and_dissolve_hugetlb_folio+0x1d/0x1f0
RSP: 0018:ffffc9000b30fa90 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000342cca RCX: ffffea0043000000
RDX: ffffc9000b30fb08 RSI: ffffea0043000000 RDI: 0000000000000000
RBP: ffffc9000b30fb20 R08: 0000000000001000 R09: 0000000000000000
R10: ffff88886f92eb00 R11: 0000000000000000 R12: ffffea0043000000
R13: 0000000000000000 R14: 00000000010c0200 R15: 0000000000000004
FS:  00007fcda5f14740(0000) GS:ffff8888ec1d8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000391402000 CR4: 0000000000350ef0
Call Trace:
<TASK>
 replace_free_hugepage_folios+0xb6/0x100
 alloc_contig_range_noprof+0x18a/0x590
 ? srso_return_thunk+0x5/0x5f
 ? down_read+0x12/0xa0
 ? srso_return_thunk+0x5/0x5f
 cma_range_alloc.constprop.0+0x131/0x290
 __cma_alloc+0xcf/0x2c0
 cma_alloc_write+0x43/0xb0
 simple_attr_write_xsigned.constprop.0.isra.0+0xb2/0x110
 debugfs_attr_write+0x46/0x70
 full_proxy_write+0x62/0xa0
 vfs_write+0xf8/0x420
 ? srso_return_thunk+0x5/0x5f
 ? filp_flush+0x86/0xa0
 ? srso_return_thunk+0x5/0x5f
 ? filp_close+0x1f/0x30
 ? srso_return_thunk+0x5/0x5f
 ? do_dup2+0xaf/0x160
 ? srso_return_thunk+0x5/0x5f
 ksys_write+0x65/0xe0
 do_syscall_64+0x64/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

There is a potential race between __update_and_free_hugetlb_folio() and
replace_free_hugepage_folios():

CPU1                              CPU2
__update_and_free_hugetlb_folio   replace_free_hugepage_folios
                                    folio_test_hugetlb(folio)
                                    -- It's still hugetlb folio.

  __folio_clear_hugetlb(folio)
  hugetlb_free_folio(folio)
                                    h = folio_hstate(folio)
                                    -- Here, h is NULL pointer

When the above race condition occurs, folio_hstate(folio) returns NULL,
and subsequent access to this NULL pointer will cause the system to crash.
To resolve this issue, execute folio_hstate(folio) under the protection
of the hugetlb_lock lock, ensuring that folio_hstate(folio) does not
return NULL.

Link: https://lkml.kernel.org/r/1747884137-26685-1-git-send-email-yangge1116@126.com
Fixes: 04f13d241b8b ("mm: replace free hugepage folios after migration")
Signed-off-by: Ge Yang <yangge1116@126.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 mm/hugetlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 46031ca5a7fb..6901faf1d2a2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3094,12 +3094,20 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 
 	while (start_pfn < end_pfn) {
 		folio = pfn_folio(start_pfn);
+
+		/*
+		 * The folio might have been dissolved from under our feet, so make sure
+		 * to carefully check the state under the lock.
+		 */
+		spin_lock_irq(&hugetlb_lock);
 		if (folio_test_hugetlb(folio)) {
 			h = folio_hstate(folio);
 		} else {
+			spin_unlock_irq(&hugetlb_lock);
 			start_pfn++;
 			continue;
 		}
+		spin_unlock_irq(&hugetlb_lock);
 
 		if (!folio_ref_count(folio)) {
 			ret = alloc_and_dissolve_huge_page(h, &folio->page,
-- 
2.50.1


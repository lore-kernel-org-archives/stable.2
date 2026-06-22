Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C3364EB8
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135425; cv=none; b=RXbhkcBrnpVpqFVUGJp6sacOyM81Nx2j6EnEaA4Bu+lP0hKJW6hUcjuq9I03q4hkxbB/N+6N3Px4MZYTSNI6w7NOF7Hmug5BEDp4fj1layYEiSzyZ/94rU6X5miT8X0V624IHvQsiN4lf8+eEtKjOkmT6078MDY9aoQVaOM02Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135425; c=relaxed/simple;
	bh=2YjrjSdke3TrENgE0yIYIZB4hJaOR3eRuoNfxO/Pha8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVD0IAv+d0EvBwfg7T31Es4ETSf9s1awEsLNyTKu/obbNyLgfpzC0k0sWK/0U+J7kFue1Ay7vaVtKKagTSCNqLKEnhE0P9CYHjb+OTxXAyz9IyZYKhuWFVioTrX95I7iOsi7yOuCrHgMHSLo5Y8ytei/PDOl8yrizNNSvmmm/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb0+qoqa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb0+qoqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782135422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MpL0/m//a1N0g+UG0x2QtOyAObY7kAUaSri0f5qAM1I=;
	b=fb0+qoqacEyACJMKpQyiMyJ1kDWijxYCAeIbj+OqdRpMzr+i1Sh/xYuKL5vXRWe3B/Qcxm
	JwkaNDX/GUCmeH4/Ws48z3bzM1SD7qcw7dsyrEojrJdL611aqZaNjs+BmRFUg5nVZW72ol
	aESn4MgD9MhA/4d3O+6xFqQc/n37Q2k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-T9SAifPbNROhxKIU2JU9mw-1; Mon,
 22 Jun 2026 09:36:58 -0400
X-MC-Unique: T9SAifPbNROhxKIU2JU9mw-1
X-Mimecast-MFC-AGG-ID: T9SAifPbNROhxKIU2JU9mw_1782135416
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4964A1955F61;
	Mon, 22 Jun 2026 13:36:56 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39E26195608F;
	Mon, 22 Jun 2026 13:36:53 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying root entries
Date: Mon, 22 Jun 2026 10:35:40 -0300
Message-ID: <20260622133540.48591-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When translation is already enabled at boot (e.g. kdump), the vt-d driver
copies context tables from the previous kernel's root table. In scalable
mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
wards to root_entry[bus].lo instead of .hi in copy_translation_tables().

As consequence, devices on bus 0x80 with devfn >= 0x80 fail DMA with
fault 0x39, which breaks drivers running in kernels with translation
pre-enabled. This fixes NO_PASID DMAR faults for UCTP-only buses such as:

DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear

Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..737936f942a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			      struct context_entry **tbl,
 			      int bus, bool ext)
 {
-	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
+	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
 	struct context_entry *new_ce = NULL, ce;
 	struct context_entry *old_ce = NULL;
 	struct root_entry re;
@@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *iommu,
 		if (idx == 0) {
 			/* First save what we may have and clean up */
 			if (new_ce) {
-				tbl[tbl_idx] = new_ce;
+				tbl[tbl_idx + tbl_slot] = new_ce;
 				__iommu_flush_cache(iommu, new_ce,
 						    VTD_PAGE_SIZE);
-				pos = 1;
 			}
 
 			if (old_ce)
@@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *iommu,
 				}
 			}
 
+			/* Track if saving UCTP or LCTP entries in scalable mode */
+			tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
+
 			ret = -ENOMEM;
 			old_ce = memremap(old_ce_phys, PAGE_SIZE,
 					MEMREMAP_WB);
@@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 		new_ce[idx] = ce;
 	}
 
-	tbl[tbl_idx + pos] = new_ce;
+	tbl[tbl_idx + tbl_slot] = new_ce;
 
 	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
 
-- 
2.54.0


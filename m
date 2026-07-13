Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5802FD665;
	Mon, 13 Jul 2026 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943458; cv=none; b=Bp31kAOJ9KWfLZZdDe8UwR3ySaLG/CUy/Xp4oH0Tc3iI33KrVuRn2BTmX+WLgUM3upex5cd1UbEAZbO+XBktAC/NPqisXnRGt6HfvjQIJdoAqsRt1zWc5KO5t9T7PdwO0Rg/C4lwBXYJldGMZm0lEgugLu6/KwgGnEoA3YlSqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943458; c=relaxed/simple;
	bh=CL75+9ML7uU1G0rYExGM4x711b7iz+krqLhefU/7pb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdjMpqMijpGUMvG+XnxlJK81uAePeMdaHONlwXLMUb+ORV/uahHFYOBXdjiSACSBZe3Ue6/T4Sp5xtWH74SRsVJbtwlOAT93TCSl8y+RaYtcYZDz9g6avRaAA1ngISG5XIv0f0UTQb/1RolSr4JNLtZ8iym5L9z0je4Uu/CodmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14a764c67eb111f1aa26b74ffac11d73-20260713
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5e2ff409-49b6-4a6e-ad9b-29162985b8f9,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:5e2ff409-49b6-4a6e-ad9b-29162985b8f9,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d130ebfbf25e73115cc0a35aa7111af6,BulkI
	D:260713195045ABOGV230,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 14a764c67eb111f1aa26b74ffac11d73-20260713
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 672932306; Mon, 13 Jul 2026 19:50:44 +0800
From: Song Hu <husong@kylinos.cn>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Song Hu <husong@kylinos.cn>
Subject: [PATCH] mm/hugetlb: restore failed global reservations to subpool in alloc_hugetlb_folio
Date: Mon, 13 Jul 2026 19:50:08 +0800
Message-ID: <20260713115008.937175-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hugetlb_alloc_folio() fails, alloc_hugetlb_folio() only rolls back
spool->used_hpages in the out_subpool_put path when gbl_chg == 0. For
gbl_chg > 0 (e.g. a size= hugetlbfs mount), hugepage_subpool_get_pages()
has already incremented used_hpages, but the error path skips the
rollback, so each failed fault permanently leaks one used_hpage until
the subpool is exhausted and hugepage_subpool_get_pages() itself fails.

Decrement used_hpages for the gbl_chg > 0 case too, mirroring the
hugetlb_reserve_pages() fix.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: Song Hu <husong@kylinos.cn>
---
 mm/hugetlb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6c812d1857b..8413ec92d836 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3073,6 +3073,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (map_chg && !gbl_chg) {
 		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -gbl_reserve);
+	} else if (map_chg && gbl_chg > 0 && spool) {
+		/*
+		 * Restore used_hpages for the globally-requested page that
+		 * hugepage_subpool_get_pages() counted against the subpool's
+		 * maximum, but which we failed to back from the global pool.
+		 * Mirrors the fix in hugetlb_reserve_pages() (1d3f9bb4c8af).
+		 */
+		unsigned long flags;
+
+		spin_lock_irqsave(&spool->lock, flags);
+		if (spool->max_hpages != -1)
+			spool->used_hpages -= gbl_chg;
+		unlock_or_release_subpool(spool, flags);
 	}
 
 out_end_reservation:
-- 
2.43.0


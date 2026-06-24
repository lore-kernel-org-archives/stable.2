Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679138837F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284100; cv=none; b=VET0uU6ki3NMR+YqgWM7AaNW4zFSR3tjpDCIU4VrkL58kQ6VSPuhSj3NAmmWCo5cCa5QV/i9VFsR4M8SzP0zSXR7sF4QABabiFEt717E8lJ9wNG3WJD3xidfLGV0XR1Ner/n0NcFBGWm42g51xt6N2aE8cSzmuzCifmqdAeKtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284100; c=relaxed/simple;
	bh=QAg6dLZz7JUcvu3ygEJFaGilWKrUiArOGp8JwZrF1lU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dFFl3S9irUlcmKmuey4PuSXHsnYSW4vQNgSs5gc0vMTYjs6RNpwSUUuYxmieN//3Y7x6YitLgtK3ZPSdH053c0yr0dV6sFrXBYHYctEeDosWFAfoHxsEeYpTExtri68krgvwuQpaoIXmKl03P87Z1puJenewJSEbqDeq4TbEBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kokBevYq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kokBevYq"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c08acccf4a4so77343666b.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284097; x=1782888897; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgXzFb3dVx+G0VhkHfJ6LeyUsAoRLr+Nz9RsQ6xstwc=;
        b=kokBevYq1oSZiDgmLu7Re/RixUJ1bmTfwDJhyfpN1i00uxntH4aHNvGholvd1HcAaR
         ifmWJW/i7EbgFAcI/xRksxN17/WykHL/yvSCBSMd09SlemKxZdzpm2SBOLcFi2Vm087k
         RPu/1b3S2IEdV21T4BAPoHQZLOUf6mqlxBzTDLk1x9GjdZcshvaBB3sdOk07p767PT84
         zLQJkTrzjDCgBy/kJ4CDShwDebCOimmdIKosTDYLmm+bFRvrRdrE//+lKK4G7YFFlUzv
         3fTf3aB1oJRoFUrrJDJSKEKLJgwmIsRNLWcAG97wCBdSwATIRS9uuFzdCPkWgrfacwZr
         QzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284097; x=1782888897;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgXzFb3dVx+G0VhkHfJ6LeyUsAoRLr+Nz9RsQ6xstwc=;
        b=Lu1WvL+LsakzwJcikAvwYqViVcmPx2/nOoeUzksClw3c85MNzN8hPqv3LKG52Oq3Fq
         JCjtx21uLFW6GHV0IaCVExztJe/ADhHoXVDgZCTtNMWw+nAuJSIytiZQGWd5wtwcjju8
         VaUFWfrukI8V+E+NHz959Enh71Xz2ogiT5a3ZI4WI4yuVmOlS372epCW5+63ifuT0SIE
         r2clrZoRaYzwM5wj/MJ2JpS86836VenIgxMIkLqvC2An4EWfG0mTtU244+O7AaBC3kFs
         /NySEM9XJx4H+XnIQt36fPdwjBrRBaW7baKQQ6WjsTi6HtQ1j7j2x3Xahy/6NURSXrDx
         +3Sw==
X-Forwarded-Encrypted: i=1; AFNElJ+d8Y9mOSxfj51eeWZVKX3F+Jiptneyfns/gopc26QI6MYqts9fLcyr8dsvfTodXRjdfr20H4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hGGj5vIXXxg5u14x/fxcMwdSEbPARCnFPIAwZ/Blj+ROxDNP
	ViWpssVwONUCgTueDLoR4rUAmYHEyTlNaZJ2Jg/NsNKXQMuPg6jq6peF
X-Gm-Gg: AfdE7cnNz4Lyj+4KHJ7cKTBrM80910Jaig+Pbavx1NH6/rX23Xqq8ZFnkZZoJLEIYoz
	6Mw5bnkiDoRt4WWPmK5/Yz8t1KRQhn9Pf/v6hbFZ9Ue0VOCiSk2DR0aFuohkJf2VSnFG0TcT1i4
	am2osM7hrLwBd2wxBnrMPUMhvNFgU9Pzs9GekbZ6N3uaRMrTVBaZnhnzhoGcoUC+h6+IEApZkji
	FC2Wau8F0ylf1oUFDzg8VGIT7e06qrQQdu7sOuZeg0iVuVkecSF+qf89+NjE5z1rJvZmoYOJzTB
	1uqz5+wr6gE2b5OTzYUDrCWFkyy8zTorkZQMZ5YFwstmPLb1/suI8j6eMgdyMrB0hkKDWqV5CCA
	qWsu0Nl+YESwDfKR1ca/RYh6RRRGRI3u8eQ74ldCxN9svgpi0MpEi7Lm/IYiXen0OvEmPHC8H+z
	eiA/ZDTCn4oc8=
X-Received: by 2002:a17:907:e895:b0:bef:db4:296e with SMTP id a640c23a62f3a-c107d00be34mr326784066b.10.1782284096711;
        Tue, 23 Jun 2026 23:54:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac98c9sm606560866b.29.2026.06.23.23.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2026 23:54:56 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	ziy@nvidia.com,
	sj@kernel.org,
	balbirs@nvidia.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD handling
Date: Wed, 24 Jun 2026 06:53:53 +0000
Message-Id: <20260624065353.1622-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
device-private entries") introduced the concept of device-private
PMD entries, but did not correctly update the rmap walk code to
account for them.

As a result, when page_vma_mapped_walk() encounters device-private
PMD entries, it takes no action other than to acquire the PMD lock
and exit.

However this is highly problematic for two reasons - firstly,
device private entries possess a PFN so check_pmd() needs to be
called to ensure an overlapping PFN range.

Secondly, and more importantly, if PVMW_MIGRATION is set the
caller assumes the returned entry is a migration entry, resulting
in memory corruption when the caller tries to interpret the device
private entry as such.

In addition, commit 146287290023 ("mm/huge_memory: implement
device-private THP splitting") allowed device private PMDs to be
split like THP mappings, but again did not update this code path.

As a result, we might race a PMD split prior to acquiring the PMD
lock.

This patch addresses all of these issues by invoking check_pmd(),
ensuring PMVW_MIGRATION is not set and checks whether a split raced
us we do for PMD THP and migration entries.

Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>

---
v4:
  * refine subject and commit log based on Lorenzo's suggestion
  * put pmd device-private entry handling in its own if branch,
    suggested by Lorenzo

v3:
  * remove cleanup part, only fix the issue for device-private entry
  * refine user effect description based on Lorenzo's suggestion

v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
  * specify the possible error case of current code and user visible effect
  * besides fix, cleanup the pmd entry handling based on David's suggestion

v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
---
 mm/page_vma_mapped.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc1..17dff8aab9f9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
-		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
+		} else if (pmd_is_device_private_entry(pmde)) {
+			softleaf_t entry;
+
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			pmde = *pvmw->pmd;
+			entry = softleaf_from_pmd(pmde);
 
-			if (softleaf_is_device_private(entry)) {
-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+			if (likely(softleaf_is_device_private(entry))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+					return not_found(pvmw);
 				return true;
 			}
-
+			/* device-private pmd was split under us: handle on pte level */
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		} else if (!pmd_present(pmde)) {
 			if ((pvmw->flags & PVMW_SYNC) &&
 			    thp_vma_suitable_order(vma, pvmw->address,
 						   PMD_ORDER) &&
-- 
2.34.1


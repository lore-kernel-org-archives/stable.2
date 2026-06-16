Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53A3E9C20
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591738; cv=none; b=muhM4SeKk5eShz78z2Mdu4T0usVxO7reuHTc9ICP8ux+DGBPcJ8AOzkg9Q2reXY/Hyu08DRHboPzSuw9HeSGJLr2R1ImVMnOgAJ3ybhNAtrTjwJG875kUAe4FP4sn3QwRA4gFaTUukV6aA2aU74q/XRZAZMNtn1vMdwZiMbcgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591738; c=relaxed/simple;
	bh=0gCKrHQkb+EVkGxEna2KyYT8qO7MWJfrHGhHwz4b1As=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pZn0WXF6v9BzdAOh0sLSRTcVg1rbk7eF1WWsdrJVnEddq4dL1CWn+1+4+8a4ylOlm5ntS13MyKZZ9rl+AIuW1MryAYOOLazDGi9X8OJdCGnxwOcDaqoYpamvqrOCXHbNGtnPEMihnb2qecZpR+EBcsAnuhA2jcC4VZVwVoE3YWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMSPwUiZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMSPwUiZ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bef8b97655eso789839266b.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591734; x=1782196534; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcSp1ab9RHCfacXpIOA1Dw3GNq7dlQhldA+avXkmWd8=;
        b=KMSPwUiZpSBSWPX9/IqatmSeY982tPCUbbAlcEc5uXVyf5/Uso5Hf3MUONG2TYLpHH
         lmGhT+odKzrgiCkX1fPxU8zM3Y+2Nt1PFrmfJN+mTmFvnLMhRkkm0Sg31Fb9UFAfZhT9
         yBNIigaD0rSVcg8QDSaHt8KFWDfiGOzl0G/dlwRPARE9fNdxKVgXVnySRtRxNL3xPFXV
         1Ny7lkq7M6h4ab0dpl5U1NK3BYz4SMav3xP1fZuuINWqj3dW4ShPyjVcujvEAKsXOkXe
         o5cc3ZFn0EUg8SrjVw5U9Rd08wLQb3yKFPKjTRLOWfY1d9NNE4uHeCYy7APmNA4k+hca
         EVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591734; x=1782196534;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcSp1ab9RHCfacXpIOA1Dw3GNq7dlQhldA+avXkmWd8=;
        b=XTuxYeDA/48AewtIhrFqlCYhfwVkHJNe5YULLEN931t1LrPApp/LEavJ3TFXeVreXG
         ioWF99CsOCclTShJbLNVCDfh/flf0l5Sab3Lhc2POlrIiI1bVvLjTSbQKXG3m8C6MWU/
         jPamfd4ssttseDba8LbYeCp4irDME5H2MGJ1yRB48oNtEE+H0/EejCFyfXy7gj4GqSBx
         XuzS7wTpYPZ2WO12mOvlzB8oANgADNkXNMJJFXrFZGIHaC5fX546SWv5s4lMvux4fF3B
         6tC3tqoVrLfMX29IJc6QYA2BFLt36jLcz/wWP21Pm2fBBd+y7VIIArwFC6CmCG08ahc/
         4Fww==
X-Forwarded-Encrypted: i=1; AFNElJ/Cw4ifRoUzhhE04ondk5rQsfKqM6PYExjekjg4tuIfQTVeVKL0zFnWYG0hWn+HWkzTHdzxR5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5Nd2nrc7n8J0uhW/L25tT0KCPGRUliYE3+7wXFZgA0+S3pTB
	jpD/9jAtRWKLpIKuj/Tw6VEDIp85UEwRbnSIDp3dEwiXm/f5iG27p7GB
X-Gm-Gg: Acq92OEcSXdeAvBu6jZW4DQuLqUOS3OOdRpdizmRx0i3Xjyt9uB4HR2fSg0tWKQ/w/6
	ij3x/nmpxKLFiKe9HpS2irlgNZj+aadwEQJEb89+ojEZoONkpAM2bfDv7IYLqwRgydEe4vHmGvk
	e5kwG4MJvN0hW4BLDRJHDoJBNXPKZatPVdtA6zZnGbb/q6nGy+DjX+e+o/fJ1sfTq9W3Shfsr3y
	NbDq8JWL21bcyV786EzdRMxdriVXJzxI2m63p6pBydrWqTqwaTBvKFhzzIdXh+dZhHE/TpRv+LZ
	yFPPWL+bbyD2+j9MlDcnWFNHJJiMoqTNTHJnHBzZ5YmwEwvUSJBHVethxlWl2xV0kaSlkOmoyjY
	DI+V7sY88cBmb8G0jQroNv9HjkJuBwPgyNYGRBOjx/LtB5H1ApFh5C4I5be2xEVLnHpi2yOPqjp
	LbVcLvWQMqGUITFvgXuvw/eQ==
X-Received: by 2002:a17:906:7315:b0:bfb:b43a:b078 with SMTP id a640c23a62f3a-c0417813164mr114432366b.29.1781591733715;
        Mon, 15 Jun 2026 23:35:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4423439sm584158966b.2.2026.06.15.23.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2026 23:35:33 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	balbirs@nvidia.com,
	ziy@nvidia.com,
	sj@kernel.org
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: [Patch v2] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Tue, 16 Jun 2026 06:34:36 +0000
Message-Id: <20260616063436.20455-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

For pmd_trans_huge() and pmd_is_migration_entry(), we does following
before return the pmd entry:

  * re-validate pmd entry after PTL
  * check PVMW_MIGRATION
  * check_pmd()
  * handle on pte level if split under us

But for device-private pmd, we just return after pmd_lock().

This may return improper entry, e.g. if we are looking for a migration
entry, device-private entry could still be returned, which leads to data
corruption.

This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
support device-private entries") by following the same pattern as
pmd_trans_huge() and pmd_is_migration_entry() for device private entry.

While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().

  * Instead of handling trans huge/migration entry/device private entry
    in a mixed manner, we put each case into its own if condition and
    handle with the same pattern.
  * Also we grab PTL and make sure pmd is not changed under us after
    above check instead of do the check with PTL hold.
  * restart the process if pmd is changed under us

Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: <stable@vger.kernel.org>

---
v2:
  * specify the possible error case of current code and user visible effect
  * besides fix, cleanup the pmd entry handling based on David's suggestion

v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
---
 mm/page_vma_mapped.c | 63 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc1..21635fab209c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
-			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-			pmde = *pvmw->pmd;
-			if (!pmd_present(pmde)) {
-				softleaf_t entry;
-
-				if (!thp_migration_supported() ||
-				    !(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
-				entry = softleaf_from_pmd(pmde);
-
-				if (!softleaf_is_migration(entry) ||
-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
-					return not_found(pvmw);
-				return true;
-			}
-			if (likely(pmd_trans_huge(pmde))) {
-				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
-				if (!check_pmd(pmd_pfn(pmde), pvmw))
-					return not_found(pvmw);
-				return true;
-			}
-			/* THP pmd was split under us: handle on pte level */
-			spin_unlock(pvmw->ptl);
-			pvmw->ptl = NULL;
-		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
-
-			if (softleaf_is_device_private(entry)) {
-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-				return true;
-			}
+		if (pmd_present(pmde)) {
+			if (!pmd_leaf(pmde))
+				goto pte_table;
+			if (pvmw->flags & PVMW_MIGRATION)
+				return not_found(pvmw);
+			if (!check_pmd(pmd_pfn(pmde), pvmw))
+				return not_found(pvmw);
+		} else if (pmd_is_migration_entry(pmde)) {
+			softleaf_t entry = softleaf_from_pmd(pmde);
+
+			if (!(pvmw->flags & PVMW_MIGRATION))
+				return not_found(pvmw);
+			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+				return not_found(pvmw);
+		} else if (pmd_is_device_private_entry(pmde)) {
+			softleaf_t entry = softleaf_from_pmd(pmde);
 
+			if (pvmw->flags & PVMW_MIGRATION)
+				return not_found(pvmw);
+			if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+				return not_found(pvmw);
+		} else {
 			if ((pvmw->flags & PVMW_SYNC) &&
 			    thp_vma_suitable_order(vma, pvmw->address,
 						   PMD_ORDER) &&
@@ -286,6 +274,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+
+		/* Double-check under PTL that the PMD didn't change. */
+		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+		if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
+			return true;
+		spin_unlock(pvmw->ptl);
+		pvmw->ptl = NULL;
+		goto restart;
+pte_table:
 		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
 				goto restart;
-- 
2.34.1


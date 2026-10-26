Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021825;
	b=3JB/WJsBb2M3o6P/XJd9PCqbhD8dN6b2N7XRSAFdIJScjB/PS7h3WU+imeeqtNemLq8r
	 5PARv2qwMHwFywwqbgC8cPZcaNMuk8k3W/G+HRpjFYepKedpGie+3CX3vO0GREq5cyBCp
	 0kJycG+ZKDGhraQYri1/PCFFi/Z00EUcvH2+F9TjNELtAsO8U8syhKQeN2ot5PBAWrL9E
	 n047m884oUyNAMCP9B0af5wMl/M8Tvs4uREvBe1vrOFtXXzl2Ffy4rEpqpIpzWkGBDFIU
	 hNjBISAEZ+7YEgnAXu7x8s2U40pjIVfVL4mFwnDreRf/DB+qA69G/CrRJn8PaC6FJeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
	b=Swi42uVmwPexkx2UriIwTMa9zx0if7oR78dLJyU6li7k4XLYaLXk1c+LpR1Gyca2c5C8
	 k8BwAqlAzlImVCVQOfs+G4knfZ3KzPmvsARXmbsLE3+mDi1NDdeYk1rqHJjqAOsoUJdnP
	 2vihD2w81C4eMIIQ6iznWYldF+bbYi+UFpGZmO+CvaeKflDQmaBDPbPjOvsl+MMROGZ/R
	 ePiaPkCCB1sdQF+mB7zcQ2vuj9uxLn/Xn5PwceApXF9tzePb0KRAecb69RKpoaCjtsZuF
	 cl17SH3/wIruj0CUY+wgmPOR428+U7R7vOkrJQNKhaCZd3GzsAX1hz6S31/MEfvplew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=NCTDIcSI;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8F606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF8F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=NCTDIcSI
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo8110347eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021823; x=1793626623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
        b=NCTDIcSIp/qQbuuAsKhDPyilHajdNZXntIojx/ZDrMTRJEN7j9tV2m3XwUaABC5uQq
         024j4gUvZn70Ymwon/ZM3CWUA3HTsiy7MTO5q/2xY97bpwtrX51lDS4QxMM4eK1zzseE
         ZzZkwzauWXr0wG5f25qy/Jq/QVXjxgPZckH4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021823; x=1793626623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4ed/RMVrv6O/H4HMl4G3Xz4VIpFThxQX+sYINSnX4Q=;
        b=nlpdsftq/U4c56x8ZezooUYsWAUUNhsyKdDGrxDgSDuTlYrgdmTUXyAy3PaswtblMZ
         aiXIWZTkgZwY+4Dq8ogERiJF2IBAJHUBU9kZhsXjVVgE+hDY9rDBcCSCzbtbnK9HcRAt
         54/Idi9WMzZVGdi+7NP9gLiyJfBrGN0Ww0MDcVRWMx3LtFyoAihSnR7zhzy5ZO5qtNf0
         m5sSbDgn52WRqh9oNznqQFQhR76cK5aODDXbXvC1chcYIotbqR/04PA/ssrsC2yy05Wm
         kUCODAVYzj01jTyCtD7XDU75kjsg5oSgFsdfZM1fknGS6nQTWwRhrzr8c/8K6szZp/gn
         +2Ow==
X-Forwarded-Encrypted: i=1; AKwUvBw7FW5kGenLPlqmaECih4ceLGIuKEXQ7yWE/fAqvJKwYfmP2qamIvA/zL9SE4f4wYkKhkMtnNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv1s8yGrP01L439GHQzPnKDL4gYq6di/2hUSdOUqFZTUBn4suq
	57nSFozi/X+khkXQOdbFMOf+QIjkMprKVEMge+WwYN3ibkhbb8DM/DVhsVo8bHcaw1U=
X-Gm-Gg: AYBFou0cBUFbFzeT7dj6PJHpozXB6Ji5rIyE+7g95MeJTmYI1G3SVtPwmdPPOD1i+pa
	z8TkF573sGE+cjo7Dj5oBKVSFSDnSGU70pjRMLGHkL+YjQ1RISFBzLKjvb2lWxxvX3YDtTBTiUL
	7jh+3nbE1sQfhlBDi/F0uSHZoMHcg3ai3hk/y03nsIWIkBFsjXkf8fHHjF8JS4zYKPptqNYAMnL
	166NJo88VJOro+DY8kx9NmvPDebcBw5abYxJBt4MU8bLNWAlP/8CfDVkic6qhPr5vOPG1slZZW4
	/yv3xcKSFiJG0t8yhOJLfDU3QaX92YdTV191SCpg4l2eGU/LqLbdNMsXGVgb18H0ih2HyumMY6r
	KPAoFcQDJN2U2uZ3sLo6pj5740NjREIPey//5AAsQapGHaB4PKyOESrGxkR1UFEdotlFL4C+PGh
	hhy/ILRHYDDEpwqULOhiDnI0f0q0BWtbOku2UkDFQ7b96sckjgSq5OAUMcKGw7sylMIirgrPaLj
	ejvaUsfvpUhIphZC0n3CqhszZUnltqoDfhUevaHU/ubaycrgMbVhUTGgP9mOWS2M5HHT68=
X-Received: by 2002:a05:701b:2085:10b0:190:d0d9:3110 with SMTP id a92af1059eb24-199406385f5mr9674399c88.45.1793021823146;
        Mon, 26 Oct 2026 06:37:03 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:37:02 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Date: Mon, 26 Oct 2026 13:36:44 +0000
Subject: [PATCH 2/2] iommu/io-pgtable-arm: invalidate iotlb on dirty pte
 read_and_clear
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
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-2-115b6b1cc0f5@snu.ac.kr>
References: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
In-Reply-To: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Use io_pgtable_tlb_add_page() instead of iommu_iotlb_gather_add_range()
to prevent the undesirable case where iotlb invalidation cannot be executed
because gather->pgsize is not updated before arm_smmu_iotlb_sync().

io_pgtable_tlb_add_page() leads to iommu_iotlb_gather_add_page(), which
updates gather->pgsize. It prevents missing iotlb invalidation because
arm_smmu_iotlb_sync() invalidates iotlb only when gather->pgsize is not
zero.

Update gather iova range only when IOMMU_DIRTY_NO_CLEAR flag is not set,
as record_dirty() does.

Since iommu_dirty_bitmap_record() becomes stale, discard it.

Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
Cc: stable@vger.kernel.org
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/iommu/io-pgtable-arm.c | 11 +++++++++--
 include/linux/iommu.h          | 17 -----------------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 01c3f9cd5d9c..6513dac26e79 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -870,9 +870,16 @@ static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
 	if (iopte_writeable_dirty(*ptep)) {
 		u64 iova = ALIGN_DOWN(walk_data->addr, size);
 
-		iommu_dirty_bitmap_record(dirty, iova, size);
-		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+		if (dirty->bitmap)
+			iova_bitmap_set(dirty->bitmap, iova, size);
+
+		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR)) {
 			iopte_set_writeable_clean(ptep);
+			if (dirty->gather)
+				io_pgtable_tlb_add_page(walk_data->iop,
+							dirty->gather, iova,
+							size);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..df57ead2cc3c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1106,17 +1106,6 @@ static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
 	dirty->gather = gather;
 }
 
-static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
-					     unsigned long iova,
-					     unsigned long length)
-{
-	if (dirty->bitmap)
-		iova_bitmap_set(dirty->bitmap, iova, length);
-
-	if (dirty->gather)
-		iommu_iotlb_gather_add_range(dirty->gather, iova, length);
-}
-
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
@@ -1449,12 +1438,6 @@ static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
 {
 }
 
-static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
-					     unsigned long iova,
-					     unsigned long length)
-{
-}
-
 static inline void iommu_device_unregister(struct iommu_device *iommu)
 {
 }

-- 
2.43.0


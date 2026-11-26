Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.211.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693689;
	b=ab57yMbGcFRVPsNcIapDOEck+Q5thUn2fs698O3COg5t7SpCiBo2n71IgkDaRKpl+zAG
	 DE5lQ7uvg/eHzUu8gCpeRSGt58e2A7DYhHKRHt9pzjt4NrfgSGVEOT/0vVCkY6CdmghK5
	 OZN/hXabyNkn+z6A/RGPKo/otnFaMWzqVzxI7UgglbS7cvCByXb4Awtk92Btimand7ogp
	 tgro5n627Ch5JnFYfFkSbK5edZs7Ix5la2g9ziccifPjfR4NDtqfl+55wTyRgL6g5DTCJ
	 ytpk401yXHOYbnlIi7opwz72UhLY6SbHvURyCO2rQPKPLnKkcp0m+GNv1P+brzDD9hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693689;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yUFA3aodD7h3Gv/Q2z05lq0mkFEsnyA5+gRezY214jM=;
	b=W4pLzst2gsFvXMM2qlq0wy0xbtBxNUaj57mGWDzWnFwWQ4f2OSSk7VbFIOTZdHl1wq9O
	 XNl6uebDWWc1I5EltFVi7FkQB0pBBItbQwzFUgfT3GBjrFBCRNDOQRijbC8AVH2HQdDsh
	 zfz70ODULxwPAEOoBST0Z0Or9i2Ix7aJCFsjecEl1z9iUl2bWu8GfhvxcJaNqU63jCsG0
	 AypNoDHuEoodxtHM/0OAQGOrVHombqGSF/fsASmyTP2i6xP0So/ocOx1R3usuwUJBOh9R
	 o4osdVAh7LQf3+GGWSCng6s6j8nbOQgxaibjuSl8RxxumrNWjPf40bdkXbapH9JXVcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=swemel.ru;
	spf=pass smtp.mailfrom=swemel.ru;
	dkim=pass header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=smpjLB2G;
	arc=none smtp.remote-ip=95.143.211.150
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B5606A6B5;
	Thu, 26 Nov 2026 11:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789B5606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=smpjLB2G
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1795693678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUFA3aodD7h3Gv/Q2z05lq0mkFEsnyA5+gRezY214jM=;
	b=smpjLB2GglBNYBr7v52garf51ALxie+ssZgtx2ncQQkvCrbSo1suK6BecKfnoXz5hTnB24
	sDqE62Ej1EqPlfmo+B5aTMWAYT1OJntymHAPkrhEwq3oIpYoNDDaXajllFuoq7VSNtaXSU
	y7ggwxKY9DJ7uQVMNvyJBPk2eJWE6Es=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 5.10] iommu/amd: Check return value of mmu_notifier_register()
Date: Thu, 26 Nov 2026 14:47:55 +0300
Message-ID: <20261126114758.58775-1-arefev@swemel.ru>
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

From: Denis Arefev <arefev@swemel.ru>

commit b09b56734fae28be9332021ae3e84c9b05020fda upstream.

Added a return value check for the function
mmu_notifier_register().

Return value of a function 'mmu_notifier_register'
called at iommu_v2.c:642 is not checked,
 but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
Link: https://lore.kernel.org/r/20221118104252.122809-1-arefev@swemel.ru
[joro: Fix commit message ]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Changes in v2:
- Drop the mm reference taken by get_task_mm() when
  mmu_notifier_register() fails (mm_struct refcount leak).
v1: https://lore.kernel.org/all/20261125084142.30679-1-arefev@swemel.ru/

 drivers/iommu/amd/iommu_v2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 16776e3c6eab..37b757e91198 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -640,7 +640,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (pasid_state->mm == NULL)
 		goto out_free;
 
-	mmu_notifier_register(&pasid_state->mn, mm);
+	ret = mmu_notifier_register(&pasid_state->mn, mm);
+	if (ret)
+		goto out_mm;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
@@ -668,6 +670,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 
 out_unregister:
 	mmu_notifier_unregister(&pasid_state->mn, mm);
+
+out_mm:
 	mmput(mm);
 
 out_free:
-- 
2.43.0


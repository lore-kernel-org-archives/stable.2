Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A04F4741
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954675; cv=none; b=SuWKWNekDetoWXdyQijCQYSJZkECtHinV8s6uXpqjr5Y6Cz/VOszX3bhft01PywtiaYVfkZk5T9juFTa+EnUc9NbxphbXC52IGHIyMMdFPgiuQ4m9bmPvmDD4ClwHw7Gz+pf/J1cdaCaq3uf6pEhNgxTUzy11NJed5Le0XgHJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954675; c=relaxed/simple;
	bh=Lk7VPCqFWFJfXhdAd5V0s8VGEqm7eap/qNG8n6V2vPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrvMa2g9Sk8GXb0Iwx7iPhfsye8Q9PKlDjxaQAY7KckGPE0xqTQhieSdHiiOYVW/4Bv81xWtctq6pmBnuw7o9rSkkYjSJ5kKyCoM5kqlYSGmoebuiyk7IUtAGtABDs0xCiHEb8CY3JYCjX48ejXwaTna552x7K6oQId2BEFBWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY8n57Ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY8n57Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C101F00A3A;
	Wed,  9 Sep 2026 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954674;
	bh=5LDigATfl70zOzr+ZTqDHJ0Lkdw7iKjLHgXCRYPeT0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gY8n57YsRBKuLBCeI/naiKji85cmQKY6CXTacxOWzqiji0VhxFWake8pi7HGGxBWx
	 qaoeIr/Fm9Yvfm12ULtZfB3xE5Sao0Yyyyd25q9/SoBuLiaaSopgeR72szrexXGl+5
	 bTWD+3IpaT3nVQ3dAJKjqkZJT0Rt6GrIx0lz288XFcWyjrfEn9QdprFhAJ+wQ2pK7D
	 JQDYMch+PaLANaCFqjE8Ia3aCYXeTTZSPVlhFI4EfnaupZUnKg3Ia2rnY5uiY7meSb
	 bJUZyBv7m9bXRz2QQIRTlr+FOUr+SiggxqSqfqoJVv0AhMgtTyRIM3Xi4P1WMyLwRp
	 2a7+N8vT4vGmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iommu/sva: Set handle->dev before the SVA handle is visible
Date: Wed,  9 Sep 2026 07:51:11 -0400
Message-ID: <20260909115111.2085593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-deck-monument-5171@gregkh>
References: <2026090353-deck-monument-5171@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 530f8f9c3546cb3ebee1b135375aaee08a073ebb ]

iommu_attach_device_pasid() installs the new SVA attach handle in the
group PASID lookup before iommu_sva_bind_device() returns. A concurrent
bind can therefore find and reuse the same handle after iommu_sva_lock is
dropped.

handle->dev was initialized after dropping iommu_sva_lock. This leaves a
window where a racing bind can return a handle whose dev pointer is still
NULL. A subsequent iommu_sva_unbind_device() can then dereference it via
handle->dev->iommu_group.

Initialize handle->dev before releasing iommu_sva_lock so any visible SVA
handle is fully initialized.

Fixes: be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
[ Adjusted context for per-bind SVA handles lacking handle->users reference counting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-sva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index a340b805b82b7..4605304410be1 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -100,8 +100,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_domain;
 	domain->users = 1;
 out:
-	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
+	mutex_unlock(&iommu_sva_lock);
 	handle->domain = domain;
 
 	return handle;
-- 
2.53.0


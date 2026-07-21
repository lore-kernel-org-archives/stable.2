Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607A397E9A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653981; cv=none; b=WSJKKKiLIXOcShTAjBEqt/vNMG3EVOz1kIoJ33R/FfIOkx65B7YkJx9nO2ULzyWtmBIPMHTQts7a8vUBt+5UW/+yQCxk+3UPhOMuoOSxGwrMDVATy/ArIcq7t6zl++6H4t0UsGDw1les1d88/TaP81DV+Y4OpcQQ8kE5s4Tl0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653981; c=relaxed/simple;
	bh=++1HmHcNPdY78Jd0LgpZPA1W8+99FsixkD/maWSLZuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9cssqwPO/I0HymQUFcT6B8tHtNY47MBC3AtRK4ggCc3cl+dFntH9vdIHl8aSp35yD7UPL+pOv/o/+zfJJEDnO4dPJi5NbPt7u7B9ikhs6/V8xu+0rY7q9rKWnZW2haESca9fNbLEtiohaJVg80/KQo6CUErPlHlzl0kKZG9iE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH84p51B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH84p51B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49BD1F00A3A;
	Tue, 21 Jul 2026 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653979;
	bh=Y17JZ2JvHoLPSOLBtQV5dFWIb1Jfruoz8W7UjKbeyoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GH84p51BDmzjoN81qnkCfAtPyjI26SUHBsGY+wHTRwXCHQ6bltCRwvikU/ks4Pshs
	 TWFUS3nclxxEevIihmdf1+aO7fH2sTMqTql6tvNXkG22LpyfEC2+bUi2ayyY8z+9Dd
	 EIpT2odRjvpMpfviZXcMTrDzJlOa86O7qHFhhomSSex0dqUxSHjCBH7FEUOtoubuNT
	 0HZYmRNX3Mf+GpP5wPwrWR64YA8BRuhwgdNJkjWndQc6fbdswAcOlYIqTJHIfxewz9
	 +PbYLEPXAZmHq6m34clQekYqwlQ98dbKr9njQxQJ6oSFMEmJNAAR4mqHJSz7yARJ2w
	 0Qf/3ziC0fqKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weinan Liu <wnliu@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Wei Wang <wei.w.wang@hotmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
Date: Tue, 21 Jul 2026 13:12:57 -0400
Message-ID: <20260721171257.107653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071647-unfrozen-iron-b8ab@gregkh>
References: <2026071647-unfrozen-iron-b8ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weinan Liu <wnliu@google.com>

[ Upstream commit 69fe699afe1afcb730164b86c228483c2da05f94 ]

We have observed multiple full invalidations occurring during device
detach when we are done using the vfio-device.

blocked_domain_attach_device()
  -> detach_device()
    -> amd_iommu_domain_flush_all()
      -> amd_iommu_domain_flush_pages(..., CMD_INV_IOMMU_ALL_PAGES_ADDRESS)

      	while (size != 0) {

          -> __domain_flush_pages( flush_size /* power of 2 flush_size */)
            -> domain_flush_pages_v1()
              -> build_inv_iommu_pages()
                -> build_inv_address()

         }

build_inv_address() will trigger a full invalidation  if the chunk
size > (1 << 51). Consequently, the guest will issue multiple full
invalidations for a single call to  amd_iommu_domain_flush_all()

Without this patch, we will see 10 time instead of 1 time full
invalidations for every amd_iommu_domain_flush_all().

Cc: stable@vger.kernel.org
Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 48cf9e9e15976c..bf8cd78abfbd93 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1431,7 +1431,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 static void domain_flush_pages(struct protection_domain *domain,
 			       u64 address, size_t size, int pde)
 {
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size, pde);
 		return;
 	}
-- 
2.53.0


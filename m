Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20940244D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654937; cv=none; b=QaxYBOZiKO2vyJeYNvQGZzKNLAr2hP5NK8UpP786JvjKLreO9aBrDLXxKmgb4EKryQ3ZX4bQhuIUDDhECAyABz4gLL2M4+A3FJ2ZVhONBRlNfamaP1/hqPfaNqPWCKhZ4KMerbalN9Pu5AduBFySSm4d/bOWo6I7vn+5X/lXU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654937; c=relaxed/simple;
	bh=WyqRoPXsVrHKdwl2J9XFk7p6M3EBXDqAvDpsBZP0XW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf/8/D5GBCZs8ELdaC025pZd7f6tn/TyUwNsAMrN5I7mRMnwj91RbnoyzAolspw+VhH0EwsJ5ji2jj/v6KI5WaMEk8CApfc0NYBt3yyMwUDWs61Z6zLkWnouyKYgtv013oL3VG5agR0xaFYQlkUJCgq9YoETZgm8AEF+yY35Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO8otqz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO8otqz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABD31F00A3A;
	Tue, 21 Jul 2026 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654935;
	bh=YiQsLKvFG9y9z6ojkxTZaOd0u2J+iHl4tP+F1/26nzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kO8otqz4upxMoOPrxv2KBFc0S/3pLzCPUBt+dsERvOn1iuX1sA42Nn+Ws7QPaDxeC
	 Rzn57S2DcIN7A0kNejFuE7al0TzVciA/MngZbB7sd3Lr28WknQEyLIlfPHNae69v4x
	 nvE2fBimqZrXJtir87UNRaywOKVigOdHrkTmwWkyyZtVzW93pqF2pub3SlWqP+KLPq
	 JK5kXxjTGOJHTKWXJLZx+KO4sPZVOf6HCUJVBuJ3rz2eUn42HiGIROwiiuR/jVLDcR
	 olJWTT49mOS5oaAHXLpfV28c8bNVX17NKsa7sb6kOXYwru79LVqnm7R+qx3JCJVeqa
	 Q3Ae1qoAO8RBw==
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
Subject: [PATCH 5.15.y] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
Date: Tue, 21 Jul 2026 13:28:53 -0400
Message-ID: <20260721172853.205813-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071648-ogle-phonics-2909@gregkh>
References: <2026071648-ogle-phonics-2909@gregkh>
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
index d3a11be8d1ddd3..b4e4f21fe2bed3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1284,7 +1284,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E83368A5
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654639; cv=none; b=eSn7ZIl+jdS3agQfhecL+4Q1/Qv7T6Vjoe4GjWvhaYof5tLY1Nupn7aFYhHNpwT5/6eLBCilPN3WRnoqi+AlHY2CrWUmpdvkozYuiGT4zymNSLlpexjtq8OvS9FumthuLf0JfOOdrX4rIW94o3FxvnhNzDQqFYrygp6JEedyyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654639; c=relaxed/simple;
	bh=YmM/biNNOwq+1WHYwUeepsVC8RUIUr0hVEt+fak1PmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+X+ufDpjWQc6dEFADbk0hZ+owTTitgKgmmyME9dRZDfJ+ddLLWw/kOipKUktaEx78eB4crz3iDKXL+i5x9Sn33ZmsWJUwTXABxdJUxXk2MlRzu1vZrXxfkCqHLhlV34DCNgA26vD+Xe4/oZXQ5hKA2ZXyBkhnR2HJPkNExf7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ3E5riV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ3E5riV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B01F00A3A;
	Tue, 21 Jul 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654637;
	bh=crpyBeM08QwflRDTH/AbCsNaitL5SlV0O5rHZkCpZ7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZ3E5riVa5CBEEHRXlLaDoBPvhvZ+vhExH6xLNO6s4p4z8/BcdzZ6uIQIgSQwzw+u
	 hAYXZqc1WHgcqthlY09f8J7ROCPolR4GVFiVY9MX8YVSQuaYnP9tMUQXgE0m4n4qLG
	 VOIDLpRXKbyY9L68CZ9klMU3rbDXbNcP+x/DpXyfUr0N9SLkahT7nPqCV5MKdZpZjX
	 26K2scvhYVUKs31KIbGprnO+SiIyPFT95wEoX5PvtOZiQIN1l/tsNPKsd6P2ekwwpq
	 IYMPQj/QNXMmZDUMvDWmJCUh6Zu9LwHPEIoRRgeBKpdV27SH9oiaHYXyDUdEYO98Tp
	 DlGTj8MXQStzA==
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
Subject: [PATCH 6.1.y] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()
Date: Tue, 21 Jul 2026 13:23:54 -0400
Message-ID: <20260721172354.120758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071648-splendor-barracuda-1843@gregkh>
References: <2026071648-splendor-barracuda-1843@gregkh>
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
index b778023388715b..d4b6a32f258e7d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1395,7 +1395,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
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


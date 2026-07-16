Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177CF41A779
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201767; cv=none; b=MIW2nnHH3WAFfFyOmiJ41YlLJQVOFrQHtXMewzESZ7Nv2OC6qWe50AC1BfMk6ypHkqdbZALurJasTVaavEAGbpbiR3yah3B1rC7otJiBub7n7IEBByPOhFEWN16JOILVOp2RakD73hi8kcBThQDgSJYf8yijW5OfTFaLflkhAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201767; c=relaxed/simple;
	bh=HkVd6u+q+1+0508vEy1ITA6pjVoMsjbbuqBxCo7znqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VD0m2h6I8KQRpJsTCzzM7L2q12naQLVzhoyjwkDkb91kjEYzlIPVtqWf1fo/xrnD/0nhhs4g7x5EjS02udd1H0nnlPR8hmKED19lPulegMP5R0N0dV8/XGvE/sS6q+siGYwJSHK8+lnzIEjLdbQClPEmhXSDxdcfQx0/zKPWR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AzK9arbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AzK9arbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBFC1F000E9;
	Thu, 16 Jul 2026 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201765;
	bh=yFN7H6f6kk8Nc99cqJg1s3Z2TL9xg2pEiTRVE/ZRhXU=;
	h=Subject:To:Cc:From:Date;
	b=AzK9arbtQxqplkUNtQglR74rbxc3KjyRL3oYSF/ZDfjqOlIgHaxaI4mstuEod0xRV
	 yL72ebGV8y5j5ze8I70JyAmLcEnAjEU2Ojd2agWybWsVBti8FNtcxSbCnJTBU4d4QH
	 ut2KX7AYpjJJaAp/GIZBzMWqjaCOyLI+AlEtw9vU=
Subject: FAILED: patch "[PATCH] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()" failed to apply to 6.1-stable tree
To: wnliu@google.com,jgg@nvidia.com,joerg.roedel@amd.com,josef@toxicpanda.com,skhawaja@google.com,suravee.suthikulpanit@amd.com,vasant.hegde@amd.com,wei.w.wang@hotmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:35:48 +0200
Message-ID: <2026071648-splendor-barracuda-1843@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 69fe699afe1afcb730164b86c228483c2da05f94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071648-splendor-barracuda-1843@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69fe699afe1afcb730164b86c228483c2da05f94 Mon Sep 17 00:00:00 2001
From: Weinan Liu <wnliu@google.com>
Date: Thu, 28 May 2026 22:31:47 +0000
Subject: [PATCH] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

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

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f1333071da10..0c042668b32d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1770,7 +1770,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */


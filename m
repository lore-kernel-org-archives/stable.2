Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0064279907
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201770; cv=none; b=OeQTKLyXOaW2Oji50lt9zdHSIE4hTr8dfhNoOSD8cn4lyFTubaG92vpnsbVf+LR3qYbpWmi0ao0V9ADwFVsN8/v4C6QxMg+8WzHgX/9h9LEhNRlwihFY0lE3StKw0evoYxVOylqJeSiOoRmaMez1iLj2JkqHqlsITCz+awPZH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201770; c=relaxed/simple;
	bh=GbxyAZgPTGNl5ONYEPJ/o/QoXWaHvZhD5MgJ8nnytS8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O4Ry94+hMDR/Wh4xGz5XA9LOt2xS623chLiSeVrtmE3mxkKarhgRqQCO3SQXhen7rEulrcgZLE1X3v5/XIsVQJYQcobtnqgaqmBahazvUtYVM6oKS8MA0s64QYisxxWO4jJiD01z6+yWyI797Iz/fJ8dkNAJPw05DVg9Uy0JClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NX9NvPyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NX9NvPyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080801F000E9;
	Thu, 16 Jul 2026 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201768;
	bh=8sqBJWEOmsZd8D36rccZ9FeiVPjl1h+5JfZ0UvY8rd4=;
	h=Subject:To:Cc:From:Date;
	b=NX9NvPyunRqzmCenphseF5YrjumWPHLknmQ6bfoaeOFZH/Ffd2D7tqH00XBxj25SB
	 ZM0XeZaqMeiLDksk4Rni/TT0xmJGZJLYmOn5gv4NEHTEmX+xWFQnduGHdUOMebAkPz
	 40K/mlDU/Qx6knIw2wddFIvw0/zkQqfyJzqg2bDw=
Subject: FAILED: patch "[PATCH] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()" failed to apply to 5.10-stable tree
To: wnliu@google.com,jgg@nvidia.com,joerg.roedel@amd.com,josef@toxicpanda.com,skhawaja@google.com,suravee.suthikulpanit@amd.com,vasant.hegde@amd.com,wei.w.wang@hotmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:35:49 +0200
Message-ID: <2026071649-fading-sensually-6e97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 69fe699afe1afcb730164b86c228483c2da05f94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071649-fading-sensually-6e97@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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


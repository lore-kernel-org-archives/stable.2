Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C330279907
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201756; cv=none; b=XwzPW6UqskPKMI4KDVQAcNT8Y2HjpyKOgGmkrYYhE8Zjo0YdTtXYkTqGXjt5DzKBjx1YV6klk1T6O/bFY+zpzhSjXnVw/zn2La2El01yUkRuxz0xnQ+O/MPxP3kNRVM2+TrVc0qwpnFhCsDJfOFjZF7GR2TEgig/DU+w+6km1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201756; c=relaxed/simple;
	bh=Qs1F96sw8kAahE3/DeJQJUC+epXrfzBs1rbsL+j0JLU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=npFUUCGalOG5FSsB1C4jBbbH8pYgsxK+rNRR8zmpQqRWJk84I7vCZFdO2is0z0C15Et87FsNMYh9QajxDmyOFAZEzBGHSDlUJRLzao3QWFYzMeW21lUWrpahK7+UDMl5GDpRpBABSp21GUwakGnivJV31k3lqKwtgcNkn6rorNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLMYRAR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLMYRAR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC161F000E9;
	Thu, 16 Jul 2026 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201754;
	bh=eb6BufZ+5+cwVcFLx5BirRaNVMwnUnk1vNP+aC27/3I=;
	h=Subject:To:Cc:From:Date;
	b=zLMYRAR3Bk/XI/roApxvGXkKQ56tl4zSVSwIOD5eoeFrMRHh9rZKQSqV+8CiXM9lK
	 no0oKCnC4j/88bDsXr+FZ6dN/hKMV1MRIJGr/FIfPrn7fPdKGPR/WO+YubMIJV/yOL
	 MdjWKdXmQkRQW3gMlFDWynn17GV1MdRa9VGMAaBs=
Subject: FAILED: patch "[PATCH] iommu/amd: Don't split flush for amd_iommu_domain_flush_all()" failed to apply to 6.6-stable tree
To: wnliu@google.com,jgg@nvidia.com,joerg.roedel@amd.com,josef@toxicpanda.com,skhawaja@google.com,suravee.suthikulpanit@amd.com,vasant.hegde@amd.com,wei.w.wang@hotmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:35:47 +0200
Message-ID: <2026071647-unfrozen-iron-b8ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 69fe699afe1afcb730164b86c228483c2da05f94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071647-unfrozen-iron-b8ab@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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


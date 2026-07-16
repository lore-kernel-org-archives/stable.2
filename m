Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EC41736D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201792; cv=none; b=lo9zbLXnpo7+TlaBS01Hd+zMFgn7dFu+mmQisVPHbSlNeo7+bPpuDtrda58bhjRGunPCKtChiLWNUbxi4Oulg5jQopvi3i44mqc1LL06j7qx5aJ1Yq5SHCIkvfg8MYzuEC4PALSLkFsx/uCblK0iZWgZYTiau+N6OOfraL6qmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201792; c=relaxed/simple;
	bh=OQ1eJdOWUPn/6s1MorQrx171PdB3mnmmL/bUc2nnrDY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TI4Txv00vHZmN5PzEFTz9Ow109cHQzn5mEcUIncRvuIWRSw6fzjAkM9yNgmj/89rCNGOhDmjLMnmb+hQla5rtFHySS3R7Zg4j7MOrq6cXTLsTR5rEAgN5DERRThW+ZcaaB96OmEY+XQLodDJtXqU1BedVtqIon+NMXLz4MAk3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zN4s8eXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zN4s8eXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3703A1F000E9;
	Thu, 16 Jul 2026 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201788;
	bh=E25Lw7Gv8s0oCieL4IYkAJLxvueefshhqJ5YwvogB64=;
	h=Subject:To:Cc:From:Date;
	b=zN4s8eXp9dOr0ysQ4LLhNOHTiMbFM3lpUzDNgf40M7+xvxVel5YM2WMBPBVqC6rAo
	 qfbteBaV6rPKeowKMbWa8eF4a1/Tuk/oWxZOD14pqVufjT1w1FucsZvRhYH2gHCuf5
	 +PeoTt9rSP4TGZBsLxUBXDlHl6KWtk7c9UaXk/bU=
Subject: FAILED: patch "[PATCH] iommufd: Move vevent memory allocation outside spinlock" failed to apply to 6.18-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:36:21 +0200
Message-ID: <2026071621-gentleman-famine-b64d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 47443565d10c51366c9382dbc8597cd6c460b8a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071621-gentleman-famine-b64d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47443565d10c51366c9382dbc8597cd6c460b8a2 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Thu, 21 May 2026 17:36:33 -0700
Subject: [PATCH] iommufd: Move vevent memory allocation outside spinlock

The veventq memory allocation happens inside the spinlock. Given its depth
is decided by the user space, this leaves a vulnerability, where userspace
can allocate large queues to exhaust atomic memory reserves.

Move the allocation outside the spinlock and use GFP_NOWAIT, which can fail
fast under memory pressure without dipping into the GFP_ATOMIC reserves or
direct-reclaiming from the threaded IRQ handler. On allocation failure,
queue the lost_events_header (so userspace learns of the drop) and return
-ENOMEM so the caller learns of the kernel-side memory pressure.

This is intentionally distinct from the queue-overflow path, which also
queues the lost_events_header but returns 0: a full queue is an expected
userspace-pacing condition rather than a kernel error.

A subsequent change will cap the upper bound of the veventq_depth.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Link: https://patch.msgid.link/r/5ff36b5d80f7f6299f851be532a5195c1d2f1dae.1779408671.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 61e6b02601d1..3b8067976eac 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
+	if (!vevent) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
+		rc = -ENOMEM;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_ATOMIC);
-	if (!vevent) {
-		rc = -ENOMEM;
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}


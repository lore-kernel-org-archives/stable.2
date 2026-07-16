Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9840D59E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201834; cv=none; b=VluUISfiQeN72zZEH8k8tDBnpZoJS876c5uFrUYfeI7+2mQ7qjh210foKYcamjKpXxwO4LyJ9FAkw3x/q1aXOah+AoZ3+Px0ry8PKRAVjtO6YLAhQfyEogHA/lHOPUcRHgsC+XPIEAuv8Mr48/xIvTKlD3w7terNHHgUZzBJgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201834; c=relaxed/simple;
	bh=6YwhJA70gUKNXq7UUycRzwc6TaUUuva4a0Uqz1SM8LM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qlKXG/TrVeMmM62CCKMgF6z/tdSGqQkgl3m6G5JSJEhISe6WQ0x9QMzNdX0zNJ12yk1ZRv8bjuYCiBTZb0i5i9cih4R0J3Pn4C/69kgbzw2iM/46KV2DuuWTqAEDSWBYNSxijnQmxDB9C0gjc6Q0Bm21nmIlkPFUyfMFjY/52Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U2MKxnzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U2MKxnzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E641F00A3D;
	Thu, 16 Jul 2026 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201829;
	bh=gVwTfQ+eLZUOAzkVYq8L6p/oEoq8SBHCymx+vo+vEl4=;
	h=Subject:To:Cc:From:Date;
	b=U2MKxnzvtpvnsTSBXZQ/OlQJETEPwDUnVGjd8FNZOf8G3dZ4FevVm6Fv1upUVeXOf
	 6br3ocTFscoRa1aTH1VLo4wJKpwE0lqpjLyj4lf0YAYEJ/w4k8n8L/BxedrjUJKM5R
	 ToGofkhifZsCl+0e+3mWgQvWALNkbVzBSLkfEWNo=
Subject: FAILED: patch "[PATCH] iommufd: Reject invalid read count in" failed to apply to 6.12-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com,praan@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:37:02 +0200
Message-ID: <2026071602-java-pointing-40af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 47916a54eeb2a9e654512ee609f71bd5b29db702
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071602-java-pointing-40af@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47916a54eeb2a9e654512ee609f71bd5b29db702 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Mon, 1 Jun 2026 13:42:35 -0700
Subject: [PATCH] iommufd: Reject invalid read count in
 iommufd_fault_fops_read()

The read count must be large enough to hold one fault or a group's faults.

iommufd_fault_fops_read() does not validate the count, but returns 0 as if
the read had succeeded while leaving the pending fault in the queue.

Return -EINVAL in the undersize cases.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/85c118a606fbedc5c132a1f5ec223a5ba23b92d2.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f55d173c59f6..613024ca8f1f 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -142,6 +142,9 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
+			/* Read count doesn't fit the first fault group */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 


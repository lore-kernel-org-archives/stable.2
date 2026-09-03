Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC64C8FFE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447916; cv=none; b=gQSyUlLasaZ9lNWPhuLGHx3Ex+9z3ajIlwZoonXlnQ0tFrjKrV4hagvnWr3RTlpRBWicEDz2+8zqr70iUHgHJWN72JbsChZJs2lxAF1BTWQ0VNIo/xd+sHo/qDRM/+AOgba/T+Xhobz9KGI3+qQIgjIR97QIZdgpcgX0qBwxInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447916; c=relaxed/simple;
	bh=3dbcs/KUBbWjo0nVQFrKteUs182+bKwnFedtx/7Kwpo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kdP0oKIXvdZsbUa75FThp8LawE3OaRhgESg7NTMzpd0tZr5bNQYtse1VWeM7xMixyXFBonafFjt9Irai26QUP9qtjRlUO99RoKstm9O7RC7bLEGfzs0Hl9EAP2L5oojzMhQZ2DlzsP9rFtYlXOwMt2DDSsIgh6d1c3Oze1jFivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGwJtF8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGwJtF8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFD81F00A3A;
	Thu,  3 Sep 2026 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447915;
	bh=YMZ5uqvXoTPTKUA9FTprpX5RrpxbqAWYKUCMiXSRr+o=;
	h=Subject:To:Cc:From:Date;
	b=ZGwJtF8uCc9JbxIQSrpmwYYcPTdWoApcSoXcdYJsApWTK8CbE5mIeLCjLsbTg1Z+I
	 k/jnKSSGioiORNVX46zB8Z8Ubask++z3QGxGiK6YP88k/yKuXlI4p7jV6wjI+QDUA/
	 nOy87bW9yj8YsinP3ebGb0FthyCzzAhHIe3qNSVM=
Subject: FAILED: patch "[PATCH] iommu/sva: Set handle->dev before the SVA handle is visible" failed to apply to 6.6-stable tree
To: xueshuai@linux.alibaba.com,baolu.lu@linux.intel.com,jgg@nvidia.com,joerg.roedel@amd.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:44:53 +0200
Message-ID: <2026090353-deck-monument-5171@gregkh>
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
git cherry-pick -x 530f8f9c3546cb3ebee1b135375aaee08a073ebb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-deck-monument-5171@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 530f8f9c3546cb3ebee1b135375aaee08a073ebb Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Sun, 26 Jul 2026 15:43:29 +0800
Subject: [PATCH] iommu/sva: Set handle->dev before the SVA handle is visible

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

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e..9742cb593577 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -145,8 +145,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
-	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
+	mutex_unlock(&iommu_sva_lock);
 	return handle;
 
 out_free_domain:


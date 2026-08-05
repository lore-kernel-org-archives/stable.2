Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE43F5BC0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921877; cv=none; b=cETsjxC+QfXIS7tKY3mDfTNirxWUBbic7kofa3u/sHe6QXt88BhBf/nykJ+SQ+Cm0B8UcQrI8flSUOUB20aPMq4uDsR8sii0k0IG1swkVfcFOAqhIbHVF1NjsVAaZmKyBD0PquUUNwoghHru8O6WgJTqeoQSJkXBwrV6kpRQujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921877; c=relaxed/simple;
	bh=FNTM7svZBQsWC6F/o8rOeOhryF8CSi1YAqI/kIqQr5I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hwi1ZtDpSui/a/ut3uMCkgqQQav2Y1JYmQGnJK28VLtmk4gUWQ9h7DppxWfq8zQiUKXo9CdaZIwGFWI0jNp+PZKIB2WgFKYOd/sPD3iJyoRklygtmaQZifBHGo5B8cWG9FpcNZUACDK0XcngQXEK8JCC5kGEufM42Zf6E0iCVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwH/BuTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwH/BuTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836E31F000E9;
	Wed,  5 Aug 2026 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785921875;
	bh=bOoUhQtGx4XGa1BeVJopkVbav3JdFoB+MaZ1yl02lQg=;
	h=Subject:To:Cc:From:Date;
	b=EwH/BuTgLKDm9hVbY5I7gxbNbfd5m8XnOUN6aVexpeA+in//X2S+h8wyAL6wLpWoj
	 oaWc3Rih9moU1N6r+pmaFXy8sUIHgSqYkpdAlQpg0BvWSjMGrMMIT2vELuT7gBdyaW
	 zsZppYIFyrQ7SuCCpulmVpTLsuoGmU9WNCguLVDw=
Subject: FAILED: patch "[PATCH] iommufd: Fix wrong hwpt passed to" failed to apply to 6.12-stable tree
To: peiyang_he@smail.nju.edu.cn,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:24:18 +0200
Message-ID: <2026080517-fiscally-lily-170a@gregkh>
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
git cherry-pick -x ba5c0f28a26e7d9be1e0997f8920dd638e2782fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080517-fiscally-lily-170a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba5c0f28a26e7d9be1e0997f8920dd638e2782fd Mon Sep 17 00:00:00 2001
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Date: Fri, 10 Jul 2026 20:29:52 +0800
Subject: [PATCH] iommufd: Fix wrong hwpt passed to
 iommufd_auto_response_faults on replace

iommufd_hwpt_replace_device() calls:

	iommufd_auto_response_faults(hwpt, old_handle);

passing the *new* hwpt together with the handle of
the device's *old* domain. This should be a parameter mismatch:

1. Semantically, iommufd_auto_response_faults(x, handle) scans
   x->fault's deliver list and response xarray for groups matching
   "handle". A group is queued under the hwpt that was attached at
   fault-delivery time. old_handle is fetched *before* the domain switch,
   so its group lives on old->fault, not on the new hwpt->fault.

2. Historically, the first argument was "old". The routine was
   introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
   attach/detach/replace") as __fault_domain_replace_dev() in
   fault.c, correctly calling iommufd_auto_response_faults(old, curr).
   Commit fb21b1568ada ("iommufd: Make attach_handle generic than
   fault specific") moved this into iommufd_hwpt_replace_device() in
   device.c and swapped it to "hwpt". This should be a refactor regression,
   not an intentional change.

Fix this by passing "old" instead.

Link: https://patch.msgid.link/r/9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn
Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault specific")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..2895e5370910 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -589,7 +589,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	if (rc)
 		goto out_free_handle;
 
-	iommufd_auto_response_faults(hwpt, old_handle);
+	iommufd_auto_response_faults(old, old_handle);
 	kfree(old_handle);
 
 	return 0;


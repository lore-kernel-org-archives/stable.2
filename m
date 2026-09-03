Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67304C77A2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447931; cv=none; b=mYUHSfhGts57P282qvJ0dmcgzd2HOLPiwnj7MqCHeR/9OfDZU934727tPP4J6OXLCuMPBkgq/Qk+6FskB7nIc8YZBnkFCnXRSa1s71q/8RMiHLRNUXRwkt96tnl/MLeqCZJ8o+PERh5qDTl4xdYd1BsnFGPuLALHybHVWqvyjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447931; c=relaxed/simple;
	bh=FxdJzricLYntAsuOoIbGBz5UvRuEgtQnKWFoVr0khIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lUnDyMtwDo7t2Vl80dgIXmL3wGtDNh2y3nLQlCIwx88vOp6xF9zp0HrDmfF5FW/hpidgiaV0d3Zz32Es41L6zoy9mJJeltf6CyrXUgTa/8lPP65c+qV8jz8Rihc0qpNKoBnrPkKScI9YcHvEk57C3MCLfz/nFUvEdSUAPZNIAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tP4haxhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tP4haxhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E31F000E9;
	Thu,  3 Sep 2026 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447929;
	bh=TYKl4C1f4Cb/ly8qrHT6G9GUmKzKip9xy4UCVVAgr9M=;
	h=Subject:To:Cc:From:Date;
	b=tP4haxhyexgPd80iH4ZycyFvdFfX5N9kE7/cTBTdyR/9yy8WNL4rPRHaWFoHGAib4
	 E4FvnD97FqSBwA2WBe0kBZ0nAilnd7AuLA4c4kDXa8jobMhxjg71kh8z7kdZTJfXuI
	 B9TUfyfU7HOojDXwS088v06vXOgOZ9zX+eQz5ta4=
Subject: FAILED: patch "[PATCH] iommufd: Fix UAF in selftest IOPF reporting" failed to apply to 6.12-stable tree
To: peiyang_he@smail.nju.edu.cn,jgg@nvidia.com,jgg@ziepe.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:46:23 +0200
Message-ID: <2026090323-coroner-freeload-0b49@gregkh>
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
git cherry-pick -x 8c07df7cdfcf52f1ff276c588612aabc6c6b8399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090323-coroner-freeload-0b49@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c07df7cdfcf52f1ff276c588612aabc6c6b8399 Mon Sep 17 00:00:00 2001
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Date: Tue, 11 Aug 2026 17:55:51 +0800
Subject: [PATCH] iommufd: Fix UAF in selftest IOPF reporting

IOMMUFD selftest TRIGGER_IOPF borrows an attach handle from
group->pasid_array without synchronizing against PASID detach,
then a concurrent iommu_report_device_fault() can dereference
that borrowed handle's domain pointer after the detach erases
the handle and frees the backing struct iommufd_attach_handle.
TRIGGER_IOPF then dereferences the freed handle, causing a UAF.

Fix by adding a iopf_rwsem in mock_dev to follow the expected design
of a real driver. Hold its read side across the whole
iommu_report_device_fault() call, and its write side around every
path that attaches, detaches, or replaces a device domain.
This can block new reports and drains in-flight reports before an old
attach handle or the IOPF fault parameter can be removed.
Also take the write side while registering a mock device, since
it can invoke the mock driver's default-domain attach callback.

Closes: https://lore.kernel.org/all/D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn/
Fixes: ddee19971081 ("iommufd/selftest: Add IOPF support for mock device")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Assisted-by: Codex:gpt-5.6-terra
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Link: https://patch.msgid.link/38C8DF0A118B7176+20260811095551.2756745-1-peiyang_he@smail.nju.edu.cn
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b021fc6bc5f5..ee706f18f7e9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -178,6 +178,7 @@ struct mock_dev {
 	struct device dev;
 	struct mock_viommu *viommu;
 	struct rw_semaphore viommu_rwsem;
+	struct rw_semaphore iopf_rwsem;
 	unsigned long flags;
 	unsigned long vdev_id;
 	int id;
@@ -998,6 +999,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		return ERR_PTR(-ENOMEM);
 
 	init_rwsem(&mdev->viommu_rwsem);
+	init_rwsem(&mdev->iopf_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
@@ -1023,7 +1025,9 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		goto err_put;
 	}
 
+	down_write(&mdev->iopf_rwsem);
 	rc = iommu_mock_device_add(&mdev->dev, &mock_iommu.iommu_dev);
+	up_write(&mdev->iopf_rwsem);
 	if (rc)
 		goto err_put;
 	return mdev;
@@ -1078,7 +1082,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_attach(idev, IOMMU_NO_PASID, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_unbind;
 
@@ -1093,7 +1099,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(idev, IOMMU_NO_PASID);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -1137,7 +1145,9 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_replace(sobj->idev.idev, IOMMU_NO_PASID, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
 
@@ -1742,10 +1752,16 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 {
 	struct iopf_fault event = {};
 	struct iommufd_device *idev;
+	struct mock_dev *mdev;
 
 	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
+	if (!iommufd_selftest_is_mock_dev(idev->dev)) {
+		iommufd_put_object(ucmd->ictx, &idev->obj);
+		return -EINVAL;
+	}
+	mdev = to_mock_dev(idev->dev);
 
 	event.fault.prm.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 	if (cmd->trigger_iopf.pasid != IOMMU_NO_PASID)
@@ -1756,7 +1772,9 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
 	event.fault.prm.perm = cmd->trigger_iopf.perm;
 
+	down_read(&mdev->iopf_rwsem);
 	iommu_report_device_fault(idev->dev, &event);
+	up_read(&mdev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 
 	return 0;
@@ -1864,14 +1882,19 @@ static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
 				   &cmd->pasid_attach.pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-	if (rc)
+	if (rc) {
+		down_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_detach(sobj->idev.idev, cmd->pasid_attach.pasid);
+		up_write(&sobj->idev.mock_dev->iopf_rwsem);
+	}
 
 out_sobj:
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
@@ -1888,8 +1911,10 @@ static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
 				    &cmd->pasid_attach.pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
 
@@ -1909,7 +1934,9 @@ static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return 0;
 }
@@ -1920,7 +1947,9 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
+		down_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
+		up_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3157ED85
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963061; cv=none; b=bfftGYuk+IlMrK7friFylMxXVwjm4hsKpLnv8b2k2XABhnr1t6O0aZvaFGfcXIPPfrqi9DGPPS/93hMb2dfYgRhFbeXJMYoqPFt0BOabhEeZhziDd0Koi/yFlkus1X14q51q03JEoykNhKNEwNy2LBuMa4GvAaz6sCseg0cCq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963061; c=relaxed/simple;
	bh=mm2ztdLRcBD7oNfyXO+PvyyjrXZAlG5Ra6+rqxqP4Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHlKkfkHKsDjJn6n+/5KEmEEn0+ijMNgL5/q5Dql2dOY27kkcgpm6Vied4KJXIKLiYVyMdeJHhLszCczqHYwk7sCzkiiQke7h4pRHdu2d9kD+1Ahq3FvcIQweRoGV02DBbqeTYyfgNHI/bL5Rqg7095q3BFLg1dGO7dHphwn7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU2HjjMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU2HjjMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F211F00AC4;
	Wed,  9 Sep 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963059;
	bh=z5CPHGO7UQ1gS+iJKQb3E07CCF34nAXczcaXSDASFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kU2HjjMvi5TndFm6HFePVm5JWOHEOgSFzEz4JyHKh+VtSD8kWUCD8XQTTnDd2xnQo
	 B1/aqrq4lbEmOKeyJ6prmmHMAF7B/mMuRYPeRHsgeAkNn636Vz3O1o8NsPefuZ72Uh
	 LB1Kl1TYtdiTe1yMHE5oVke/RqJIljPbErq4fhIsbYNAGVPFXBqwZIKffAEdJqJV7K
	 G0G+lv6ChBV6eZ2q1ijGXvgzHfS/lT7eKpEA1zyQ8MWE3Z/8cXqLuOk6+Bjzi5eiO2
	 Jw75qVycgZar506dNuVppqRA00C/ym/J8HoTCZId5NfoOdhAdXQvVW/4Yid/Ns90W6
	 OHP5L3oitA71w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iommufd: Fix UAF in selftest IOPF reporting
Date: Wed,  9 Sep 2026 10:10:56 -0400
Message-ID: <20260909141056.2382221-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141056.2382221-1-sashal@kernel.org>
References: <2026090323-coroner-freeload-0b49@gregkh>
 <20260909141056.2382221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peiyang He <peiyang_he@smail.nju.edu.cn>

[ Upstream commit 8c07df7cdfcf52f1ff276c588612aabc6c6b8399 ]

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
[ adapted locking to the older non-PASID selftest device APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/selftest.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index aed260d4a93cc..29d20d70d383a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -138,6 +138,7 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct rw_semaphore iopf_rwsem;
 	unsigned long flags;
 	int id;
 };
@@ -701,6 +702,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	init_rwsem(&mdev->iopf_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
@@ -715,7 +717,9 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (rc)
 		goto err_put;
 
+	down_write(&mdev->iopf_rwsem);
 	rc = device_add(&mdev->dev);
+	up_write(&mdev->iopf_rwsem);
 	if (rc)
 		goto err_put;
 	return mdev;
@@ -770,7 +774,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_attach(idev, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_unbind;
 
@@ -785,7 +791,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(idev);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -819,7 +827,9 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 		goto out_dev_obj;
 	}
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_dev_obj;
 
@@ -1415,10 +1425,16 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 {
 	struct iopf_fault event = { };
 	struct iommufd_device *idev;
+	struct mock_dev *mdev;
 
 	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
+	if (!iommufd_selftest_is_mock_dev(idev->dev)) {
+		iommufd_put_object(ucmd->ictx, &idev->obj);
+		return -EINVAL;
+	}
+	mdev = container_of(idev->dev, struct mock_dev, dev);
 
 	event.fault.prm.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 	if (cmd->trigger_iopf.pasid != IOMMU_NO_PASID)
@@ -1429,7 +1445,9 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
 	event.fault.prm.perm = cmd->trigger_iopf.perm;
 
+	down_read(&mdev->iopf_rwsem);
 	iommu_report_device_fault(idev->dev, &event);
+	up_read(&mdev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 
 	return 0;
@@ -1441,7 +1459,9 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
+		down_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_detach(sobj->idev.idev);
+		up_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;
-- 
2.53.0


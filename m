Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101C426419;
	Tue, 11 Aug 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442264; cv=none; b=Q0mLmWRTCQ7ZG/NXLq0egX04cBtWOJ8at9p4+8z+zeIhVqVQY7TLf8DJAiMWf2+M6JbIUHnrsreU2vmhiOn72foW/sL/yt5wvKn7+cFPtyfS28lJ5/FCswXTHycX5mAneF3HH0nodHuZxEI4yrUe6EPfAORB7RQj2F6fBRhbcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442264; c=relaxed/simple;
	bh=QXkcBLWhR/1op8VGuLPVm4NWn9S9Ua+RAO0cTDQgqgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQaBAXDXAr15TsIWLbqyYOFRW1AZcNzbwLqtWzqS6EnrCkWmXMjN7V5TMK4qL7i45twvQ8aevIeCw+JmEJ8o5ZiwoXkETfF6nYOkmQ/2F9s2jCL4XtzmmF8LjQCeOzm/iHneIkSawIIKMuuIywij7bEys1lZ4qWdvhnX2cXLah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=EtO1Kjgo; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="EtO1Kjgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1786442195;
	bh=V8fUJRdFiVI+WV6PymLEo3X+w9kpNPfa+6nMY4HGiRs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EtO1KjgoxIH+oSakaITV9wPQe8ITUcjuNZ81y8ylDjAnG1rNtG1gZFHrqszX8ON6i
	 Kv9mngackx3/nR7fLV6Vfla8UCTI+h5r4uwVAVpd+RXoNzijgN63v7gVLNQN6h1Dde
	 zlNGiuCsTkezUVdIFzJfGH4L3KxVVO8fboPZWYWk=
X-QQ-mid: esmtpgz16t1786442187t8a3150b4
X-QQ-Originating-IP: IIht5FCCP67OxJNZozIsI0VqmXKZB9owBsKM0Uo+WHg=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Aug 2026 17:56:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11890595383446028419
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	stable@vger.kernel.org,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommufd: Fix UAF in selftest IOPF reporting
Date: Tue, 11 Aug 2026 17:55:51 +0800
Message-ID: <38C8DF0A118B7176+20260811095551.2756745-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NTC/yvyq4yJ4zmyF80kFm0bnIMqROuVztq0YjQCJTgQcC6alSkfnrJHQ
	kjkZUM/5B6UlIO0bEvn6bsxAPz3sPDmPvcQMU9ZDPqPmW8OIv6IEUpjvnHt3W9xTN2jeF1y
	Llg1DFTy5TvMjdCqQOuaYKUjiLNSrs96smLyZl0tHM2SmzG+LL9Cd5vSNyZy6ADE6LL52Eg
	nuyqrYQDnZ62eKq9XwqIuX+5Ejym4S9WSJ98j1Wi0sK9hBn5IHmLgOm4MT+HrCluL408+3o
	mQeG7tj5umFGXZJDSorrKj9wWEuy9DEqvNSNdmkRi9yvH13gEMU1ZEz+G1u5xLmo+X+awq6
	l0x3nm5es5TrufICSdmKvtoSYB+U9BQ7plsfeflawoxWzOD9nSVAmDJnM4GawSO+nSedOfd
	tM0sQDh9K2/i64ewF9Rg89q7vfLNhEapjK38Lv9b7SMdmlfR6xBdlz92+sCgpuhQgS0Q4bQ
	2p0tVp1xjZ7D5HJP2UZrTWuDT64pUxpXhHIqWa1XXfNpdGblB/emJ34iYRoD2x+w3uL12Dj
	Wz9RYhLpQrzlPmmuMsKPdF9r27vDlrAIagDntBJEuYhhXeeFPaQRRi5yoVOKPY0oV4TMWSk
	cPZlT2RffsX3e/bzs6EIFBXuCwEya/0awJJFS0IXQ7LC+isD6AL6u7SFdvpDT7ZjrZkU5VU
	7SVG064rKBxbQv8iueadhaJ+eFOwYXAo7P1UykATAU0fgGBO2+PlxQSPwBVoMbd1eMCocfB
	XD9ebayMzlXRfr4mCO8ta6ugC7Vi/4g8JaeIRh49kJmkHGBbfZJAHbeZXmrePsCM9JHk3k/
	9ZiixEffCyxFNNcgtYYhHkqn+wg6Ju68TyrqKPq0qip+FiH7t6tG+2PZNqucaTJrMJbBfFz
	uROXTarJsUgAPnV8/A2OpVuqHN6yShKnHQPZ75zoRjZMQCuxpEijReFfbE2MMSlYV4FCjar
	EGMNxiLotUyL/WMpoAvuLaiHYjSc6JoZbh1zcONQAPCJtvXAzKeO2OwkTBpD2GA2O49iDWo
	hdpe4ByKODkPZ76/84pZHz46XOMSaDcvuWMwhOK5e9rFFGlKAYu9qRkEJMo8fsBCNWREIMh
	g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

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
---
 drivers/iommu/iommufd/selftest.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..727b59799d5f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -177,6 +177,7 @@ struct mock_dev {
 	struct device dev;
 	struct mock_viommu *viommu;
 	struct rw_semaphore viommu_rwsem;
+	struct rw_semaphore iopf_rwsem;
 	unsigned long flags;
 	unsigned long vdev_id;
 	int id;
@@ -997,6 +998,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		return ERR_PTR(-ENOMEM);
 
 	init_rwsem(&mdev->viommu_rwsem);
+	init_rwsem(&mdev->iopf_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
@@ -1022,7 +1024,9 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 		goto err_put;
 	}
 
+	down_write(&mdev->iopf_rwsem);
 	rc = iommu_mock_device_add(&mdev->dev, &mock_iommu.iommu_dev);
+	up_write(&mdev->iopf_rwsem);
 	if (rc)
 		goto err_put;
 	return mdev;
@@ -1077,7 +1081,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_attach(idev, IOMMU_NO_PASID, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_unbind;
 
@@ -1092,7 +1098,9 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(idev, IOMMU_NO_PASID);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -1136,7 +1144,9 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_replace(sobj->idev.idev, IOMMU_NO_PASID, &pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
 
@@ -1739,10 +1749,16 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
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
@@ -1753,7 +1769,9 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
 	event.fault.prm.perm = cmd->trigger_iopf.perm;
 
+	down_read(&mdev->iopf_rwsem);
 	iommu_report_device_fault(idev->dev, &event);
+	up_read(&mdev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 
 	return 0;
@@ -1861,14 +1879,19 @@ static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
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
@@ -1885,8 +1908,10 @@ static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
 				    &cmd->pasid_attach.pt_id);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
 
@@ -1906,7 +1931,9 @@ static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
 
+	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
+	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return 0;
 }
@@ -1917,7 +1944,9 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
+		down_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
+		up_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0

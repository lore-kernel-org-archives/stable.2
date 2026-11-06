Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966079;
	b=Fvry5ynZ4aS93jhSk7RiipxlqhDu7ptmA5FLlI2p2U84vHctH67sykPfdbXy55tcruAr
	 cKbHZB4ZRc5ds92avSK1WBrOh5hflOwxQoc/rIPf+ksKMl7CZJuiitQ4t+GsRaatikF1Q
	 NtFBaFwufauk5ExTz/2T9aIplgidPENWSNWxIeTOwRZ7uH5lpDswQ7q9e1QBMfST2YXQy
	 lh9mDpfHEuJyo6bh5Dzzk4+7Ahyn9GT8FBAzqdwu+6jhEpO4m+3cJag11DbytwbEpeSq3
	 c8NqH4cW7MgU+bHuS6WK0YpwBojSjwreAE/PZtWj+uMP9GI4cID4wg/mvHV93FRDf/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966079;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=noiWM2e47pR3UV7AWS0XMBszvLh3NBEomGUwlsGmzYE=;
	b=0AzryobN3TNcyMYIqClJKCiKn5q9TdLAVzGiwPT88v/ILZvrCuYVkTob3FaBCrbbVYV/
	 rLSLhD6BgZjZJpwv8S5Bb4WkmxQp6xu9oCKSZHP1LYWmA1Fr+s8N56n2rSnbLirbgYrBX
	 9HJDOazv2+7cpBpoJGKUBylPo4FBXoGW14pd7Aw5jBnF22NGJwZYrTpEvrFxJtwwuyOK1
	 iuJk5lwGwGGHohP715idqNr8ASLp0bP570AGGGMDcsMYkbqPZUYq74jT0bOY/14j+DTDA
	 n/43smIMU4jofktdZ050YHAN7badWn6KExnCu5LAN1fAN2UfUpwlZRvGZ1joyQi03ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=1sMQmz8D;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E0606A326;
	Fri,  6 Nov 2026 11:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=1sMQmz8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793966000;
	bh=noiWM2e47pR3UV7AWS0XMBszvLh3NBEomGUwlsGmzYE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=1sMQmz8DtSQCPViBsG+bmAa5RKppMzgZuwSCMi+9Hx8dFuoiXydOXBTKdW5ISuM6U
	 veP5xjJQE3CR58YUvgjAIHr5G6idWMQc/o9zAp8EFxSsiFWOvTPVBYcY4N9rpWOH9F
	 m4/gpoKrmUec48zLzVd03jjuWw5Dt/70nbBgcoYw=
X-QQ-mid: zesmtpsz9t1793965993t7c80609d
X-QQ-Originating-IP: AHAzsWyd8dv0CVe92GS0f1kSJ+NcSoeEsIgLyGurSFQ=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:53:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1157617563950253624
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	stable@vger.kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommufd/selftest: Fix leaked PASIDs on device teardown
Date: Fri,  6 Nov 2026 19:52:52 +0800
Message-ID: <CD846EC67F4302A7+20261106115252.87749-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M5Xz9JaOkZqz9Ydui3wdri+Ty3o1wG5sb+loBWpXsec7Zz37AGlK9Jjx
	iApjFKRduXQ6Llv4dOkGpw3Xdkq292yYE3spMBRj8m3HJy9UFObRHh3SPE1IGYUcmuLWnl6
	WuLYYTsJjCcVy/7nDtvFMlfY1JKoa/QTu28oaE66kB8deEptSn2ff2yz7bWWb29R9TNpnHt
	vOtSEzTCD/ZWwS9yb4wU+Tk/VuVFBl/uCYgmlyBbpQX+d4f7KOlgRbo9ICUKVPseRy+eryY
	gjuhUh+a/uL5W8slAJ1JOGUHmulFDP7/B/dH5wpjx++3Sc00/H7GblAbgmnT+7xaArePOY/
	DuVh0TJM/+bkCyjePmAz4jzC8GSVweT+bya3uYCDOr8GigV23cne3H6sbRSx5IKokIzo8//
	pCToatLeo8QIzg+H8Ir+ThMkbVd4nGFCVUb6feuKm6inp6QrF9H9S1xoHjBeTZSLdDXiB/P
	9gyisnE3WLQgzBfGTbjaTJnnKg+vsT0YCQyhpW6Smmn5EpDBsgSWLgdNOFG/EkCriWmvUDf
	EYPkIzYhl5NY8WMrs828d8ipf2tmQ8kjzrqtpWv/LGskV/SsthPdZPkIcy3ciNSSYomZZmF
	okQ1vP042nl/l07whMylg3GgFiDBryr6e/VSI4iRV7CuQfKpTP1FJoXT1lqK+uyvQUb+jGJ
	1/b/XNQ4rDFcfXjGPTOVJerMCD0EuxguHEZ+rlx6hPtBKyn2eyJDoPnYZBzo+aK5hBPIymO
	j6+jwvB6bEoXd7IZKVrUfzYvVrdpbX9fdKKg+mymqeqoklnCcMUA/YsS6HhhKJ4hmO+gbUQ
	wxyrMf3NKAX7jZsWdrwRicdJo9qxAQczI3gVEO4ix0Z3HBs94Mxs0Y/B284WZBHeDB0konu
	Wzwgzcj+bBi3elEr/gOxkFg0x4ZWZrV+nl5z1L/0nOGcMsiBELGneufR5xma5k2lmh64p3w
	x2zTOVRYvCBVfuQ2jT0dDjuUDhvYzWwwRrpZQavACxG+2TSq3nZBC9qR1O8UHUtYGf/OtVu
	kZkE0LrOIY+Mb1KaGWHZPUpalTgYA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The selftest mock device teardown only detaches IOMMU_NO_PASID.
If userspace attaches a non-default PASID with IOMMU_TEST_OP_PASID_ATTACH
and never issues IOMMU_TEST_OP_PASID_DETACH, the attachment keeps the
reference taken by iommufd_device_attach(). Unbind then fails and the
iommufd device and IOMMU group are leaked, triggering:

	WARNING: drivers/iommu/iommufd/iommufd_private.h:241 at iommufd_device_unbind+0x80/0xb0
	WARNING: drivers/iommu/iommu.c:744 at __iommu_group_free_device+0x1b2/0x400
	WARNING: drivers/iommu/iommufd/main.c:389 at iommufd_fops_release+0x380/0x3b0
	WARNING: drivers/iommu/iommufd/main.c:399 at iommufd_fops_release+0x3a3/0x3b0

Track attached PASIDs in an IDA, as VFIO does, and detach them all
before detaching IOMMU_NO_PASID and unbinding the mock device.

Fixes: c1b52b0a97ae ("iommufd/selftest: Add test ops to test pasid attach/detach")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
Found by a modified Syzkaller.

 drivers/iommu/iommufd/selftest.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 25387969a..18938002f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -196,6 +196,7 @@ static inline struct mock_dev *to_mock_dev(struct device *dev)
 struct selftest_obj {
 	struct iommufd_object obj;
 	enum selftest_obj_type type;
+	struct ida pasids;
 
 	union {
 		struct {
@@ -1058,6 +1059,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	sobj = iommufd_object_alloc(ucmd->ictx, sobj, IOMMUFD_OBJ_SELFTEST);
 	if (IS_ERR(sobj))
 		return PTR_ERR(sobj);
+	ida_init(&sobj->pasids);
 
 	sobj->idev.ictx = ucmd->ictx;
 	sobj->type = TYPE_IDEV;
@@ -1880,8 +1882,21 @@ static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
 		return PTR_ERR(sobj);
 
 	down_write(&sobj->idev.mock_dev->iopf_rwsem);
+	if (ida_exists(&sobj->pasids, cmd->pasid_attach.pasid)) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
+	rc = ida_alloc_range(&sobj->pasids, cmd->pasid_attach.pasid,
+			     cmd->pasid_attach.pasid, GFP_KERNEL);
+	if (rc < 0)
+		goto out_unlock;
+
 	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
 				   &cmd->pasid_attach.pt_id);
+	if (rc)
+		ida_free(&sobj->pasids, cmd->pasid_attach.pasid);
+out_unlock:
 	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	if (rc)
 		goto out_sobj;
@@ -1890,6 +1905,8 @@ static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
 	if (rc) {
 		down_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_detach(sobj->idev.idev, cmd->pasid_attach.pasid);
+		if (ida_exists(&sobj->pasids, cmd->pasid_attach.pasid))
+			ida_free(&sobj->pasids, cmd->pasid_attach.pasid);
 		up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	}
 
@@ -1933,6 +1950,8 @@ static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
 
 	down_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
+	if (ida_exists(&sobj->pasids, cmd->pasid_detach.pasid))
+		ida_free(&sobj->pasids, cmd->pasid_detach.pasid);
 	up_write(&sobj->idev.mock_dev->iopf_rwsem);
 	iommufd_put_object(ucmd->ictx, &sobj->obj);
 	return 0;
@@ -1941,10 +1960,15 @@ static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
+	int pasid;
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
 		down_write(&sobj->idev.mock_dev->iopf_rwsem);
+		while ((pasid = ida_find_first(&sobj->pasids)) >= 0) {
+			iommufd_device_detach(sobj->idev.idev, pasid);
+			ida_free(&sobj->pasids, pasid);
+		}
 		iommufd_device_detach(sobj->idev.idev, IOMMU_NO_PASID);
 		up_write(&sobj->idev.mock_dev->iopf_rwsem);
 		iommufd_device_unbind(sobj->idev.idev);

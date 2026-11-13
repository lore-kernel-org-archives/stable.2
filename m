Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579063;
	b=K9QP0D1FVOPkvexhlcxv7TuvbERE1DXRs4GFGTxx30FMbK6cGIGPWm4cYdiv+12+aP48
	 U7Y4KdrLAaOAiU11dK7n7wPVKUQKLuB0AeH9XU4eWucQEMSlE/dbO0x+83mtNggYcY8gp
	 pqieLw5U1KtcPSOx6SclX1TZewixwJ2LHm8mItemEgkjlmVi6mJ5aeJs4DawV/BlKAZKx
	 nfCiY/6r4fpVoIH/Zs18kWcG3eucfa7qm7nvl7lxaIKA0me7VikcY2b9LFIryO6ZwbXVb
	 gRpVZ1A0YtMqHbMiD11sepVp84T37QDTV2AzZMgFMXRdnxKZZjc5q2mNo+EqROagh4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579063;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+zZ0U3ghcAINLzNandCHI3s7lZsijJsLjqhLSAm5+iI=;
	b=l44slxt7RzrKdU6GQnVpvbo6gtvFUFmlXDADpEzpWoZ0AaV639VuGowQ/AgvyFDOLIYP
	 SH0kdyPbtDr2figZ1d4ZHmQDRyHI09BTV3Rvaf0B2eYzgFrOBXDRaKAuODutoVY5fekNv
	 C7rLUeA6Ku7PaqK9EwfBYFtYZYLexSv+i+KaxLbc1dd0BdQMvg77TSvpeBOBMaMRKgF9W
	 1IWo+XkpNPgulqMBmQsvnGcwYIdpnA59SCXTZj7CI0eLjaQ87uAFRhxFnCr1W+71jP76O
	 mFH37mp+sr8c0b9W1qnj1grhPZZQmnhFK2fkV5Ux2YLINHgYzSAdwwd7YgIvvyyWYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oiqPSMH2;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AC606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oiqPSMH2
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE62l2888925
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+zZ0U3ghcAINLzNan
	dCHI3s7lZsijJsLjqhLSAm5+iI=; b=oiqPSMH2enRwjOB4kEIAKf+b7+7kDUVV8
	rc673EODwF0OVYeKUBK3mqTsPOzi58bp9e2wPd4wlJnD11u5Bl2ZIvZMfLNxr7A5
	yt0uJGSbhdrl67v7V9mjm4C0iwbG1dcX4XTF77LV/jI367XLH6v67N18bQO3pr7K
	uhxZBsAfsyOHSJ+ovyGXx1Z6+K0oEw6eXrk/Gn+vEE+elykuIiJUQ6nFH455ASG0
	vCo6IKMAhoDQTKIFBRqfLqf6qYPJCRS2mrnZwQN4Kp3aaM2k/zcFcXMYANd0RiBJ
	Bu0OCV+ioFfWXMJ7QqysDLZ4Ib9HO79+Iu3Q5dG8bOVkws/SXy/Gw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7bv68-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCKInm2305810
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq11jn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAtc32490972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E3558057;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B4858058;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 13/20] s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
Date: Fri, 13 Nov 2026 09:10:35 -0500
Message-ID: <20261113141049.3747719-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
References: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX1oWuj2/2RMoN
 G4AZc2KiRHzGTYgtvVKlxAoSruAbDAklO4fFHt+wY2bb6fdrfr+wnMSie8e8vHyAjV/Qju03irq
 H3zyW0wKekjRQTDkxxuqjF2vk510PzU=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af71a72 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fxeDLeT5AZ2qCvnLJ4gA:9
X-Proofpoint-ORIG-GUID: xjvL6MYD2agY-a4YWmUnafvvEmW7s0kw
X-Proofpoint-GUID: xjvL6MYD2agY-a4YWmUnafvvEmW7s0kw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX8nle4UaWaujy
 oF7qwl42e1LBvjWhkFwaTYxb4yIiDS9mak6bXd3TqvZXcz/j3bIj2yjPHEcjRGYOn946GlLZZMc
 3YucFD88OTdSIWhKUqYu5Ov7Tm8xc1yL0TN6kjY62sRs6ecspC9EN9frc53EB0syMobrz9UXWp1
 5O79cQJtePpwkSLy/H11Oe0gmL5rjCgk8YtJBpsih5oKMvR6TMa2MAEhSzhVTkWGcE8v8vmOUFx
 86+R+XHLlvb0ykOLh8VnGRSUg6FUgTtYElau4mMW0hLmK8FBOlRsk64lwXU7psdfdYvxCzC4HfU
 gWVIGnMXpxDLEMUtAfl3laK3EeEAU/Ke3d6bVTty4efkey4LFuacS29eeruFy0I9mHHTn/wnN+A
 3WOH7X05VWvN+VVhUpWNVAiqmvJssm6ZWJeho6DcfcKfADxFa20Nfl6hK2ZI7c7diVIoLZeDEGD
 0jxg+Z4BuhCO+fPbl9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130054

When userspace registers IRQ notification eventfds via the
VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
takes a reference on the eventfd_ctx and stores it in
matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
respectively.

These references are dropped only when userspace explicitly replaces
or clears them via a subsequent SET_IRQS call.  If the device is
closed without that explicit teardown - because the guest exits,
the VM process crashes, or the device file is simply closed -
neither vfio_ap_mdev_close_device() nor the remove path releases
these references.  The eventfd_ctx backing objects and their
associated file references therefore leak for the lifetime of the
kernel.

Fix this by introducing vfio_ap_mdev_release_eventfds() and calling
it from vfio_ap_mdev_close_device() after vfio_ap_mdev_unset_kvm().
The VFIO core guarantees that close_device is called before
vfio_unregister_group_dev() returns in the remove path, so fixing
close_device is sufficient to cover both teardown paths.

Note:
~~~~
The matrix_dev->mdevs lock must be held during the call to
vfio_ap_mdev_release_eventfds(). There is a small window between the calls
to vfio_ap_mdev_unset_kvm() which gets and releases the update locks
and the acquisition of the matrix_dev->mdevs_lock mutex during which
it is possible - although highly unlikely during normal operation - whereby
a concurrent SET_IRQS call can get in.

Taking matrix_dev->mdevs_lock around vfio_ap_mdev_release_eventfds()
is sufficient to make this race-free. The SET_IRQS ioctl path writes
req_trigger and cfg_chg_trigger only from vfio_ap_mdev_ioctl(), which
holds mdevs_lock for its entire duration and always calls
eventfd_ctx_put() on the previous value before storing the new one.

Any number of concurrent SET_IRQS calls during the window between
vfio_ap_mdev_unset_kvm() and the acquisition of mdevs_lock are
therefore safe: each ioctl invocation puts the reference it found and
installs a new one, leaving exactly one live reference in the field
when it releases the lock. When release_eventfds subsequently acquires
mdevs_lock it finds that single surviving reference and puts it.
Conversely, a SET_IRQS call that loses the race and blocks on
mdevs_lock will find the field NULL after release_eventfds finishes,
take ownership of the reference it just created, and install it into a
field that will never be read again - a transient leak. To close that
final case, callers must ensure no new SET_IRQS ioctls can be issued
after close_device() is called, which the VFIO core guarantees by
releasing the device file before invoking close_device().

Fixes: bf48961f6f48 ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
Fixes: 07d89045bffe ("s390/vfio-ap: Signal eventfd when guest AP configuration is changed")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 892ea938d14b..729af61d8ad3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2421,12 +2421,28 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
 }
 
+static void vfio_ap_mdev_release_eventfds(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->req_trigger) {
+		eventfd_ctx_put(matrix_mdev->req_trigger);
+		matrix_mdev->req_trigger = NULL;
+	}
+	if (matrix_mdev->cfg_chg_trigger) {
+		eventfd_ctx_put(matrix_mdev->cfg_chg_trigger);
+		matrix_mdev->cfg_chg_trigger = NULL;
+	}
+}
+
 static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
 		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	vfio_ap_mdev_release_eventfds(matrix_mdev);
+	mutex_unlock(&matrix_dev->mdevs_lock);
 }
 
 static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
-- 
2.53.0


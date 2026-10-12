Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A14AE11D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819873; cv=none; b=OxmWHmkxw4qnWh+RNTm5O60qdIwySfI7bYo4wpCaXU7YnlpyT/KTMlp7xNhO0i+A+OhhjMJwpl7rEcwL5g/eS6xIUx0e+IHOEXHFPZ69S9TR9b4sj04Wkj+OxfY7KioWkuoA3LovanwQd+/kNzN56J4e1uUucG1BSQxAL8cs3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819873; c=relaxed/simple;
	bh=t2bLq0uAMUfi8piaam9aDXJo9UZUusjjLAbjyAfge1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVtu5aet6roZwTkO01C04YdwHHZg0qIsvUC4+tIIGUQGcDRLJ9/m4LXDv+BhV+qNbhHD32qCTqUIzr/0cF8UbcwyX3s1lXdQgx50q/2nXhbKGHlwfWn5TR+e+91v3wKYHqwc6XVxGHLtR6i88drA9Y/VPrJFAK85frAls2KPssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tXPMVZeg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tXPMVZeg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFi9Ir3074639
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Yy4grkn8zyJUCV8Q6
	daMenDJp4GyFD/sZc2YjC8Piz0=; b=tXPMVZegviMwV+/P+TC0p1xLT6laLN8aY
	5bDnYRivZUc/oJQKl0tP0f2AR2eu62dE+OmihPj9k1hskfrd49/hoMuy6aJiebcD
	n7HolEEcQ6GWxWVXtzamOL4WaXoo4JWZdY3gjfAzv/OH5Vewpd+PUAaQRdlGaY0c
	x6KVTXhCQu8EvBK7tOm+xP9vO1AvhdaUqSnRfNvao0VSDk8z8oxjSKN3tAG0/Jsd
	S5ACkfi+ZqOvrcvJmoLS8LtfuVr+YKD8uO4LDyUaO8rmxNd7FwG5MaFWSjcvJKMX
	JPKjgwga+JO7/gwq6JwcYxb+6Wmfhaj6Yz2XUFFpRPjsJe1LBgDVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9p37-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC56881212143
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnty1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFiS2Z23200356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:44:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CC295804E;
	Mon, 12 Oct 2026 15:44:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187E95803F;
	Mon, 12 Oct 2026 15:44:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:44:27 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v10 2/6] s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
Date: Mon, 12 Oct 2026 11:44:21 -0400
Message-ID: <20261012154425.2860783-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
References: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXzdu/QU+Mz3tp
 pCIfG+tTKXKkcHGLYlUJwyGcl71DjAVUD6qRKbSB5e32JuVU/CXxUKsshsMfx8eK1AX38uD4NnI
 GSBiPUKkfTSuBdgL35/BYz9hKWhkQQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX1Z4HwgkuWQht
 A053yG1nu277p3CX5BtQPyLjMMf9/ybJ7IERtRL1FpeVXq2wC37hPqFMKyTn8+YP0la5Rq/bT7S
 azO2FxpfNMgLN1FwpVpK2QfjDWYqyLF7Lw2OpxQcbpGvSYzcNQDdEM1pQGCyNubVJs4aYH8uP8J
 o5lGdOgduNDSjuLmDdeXK/vZeFPZr/9ijq+ZfSNkCYBjh39yH5YZyeLI4Yb4r4H7RJEKBKhhZHI
 EuqIYPSQp2axk4Qbe4cxLKhA8MlieqS7/zFgflSvtVLBSTkTY/Kz39BrmUpdrRkUiue7zSRCYxO
 r/KjVIhN9b8mS0VzH9PFrSKMvAzmFRthcf0J4GZVJrIQqvcyxBIYbV9CDAHn5ovwEI3HRH4dbIa
 qoKoLQFXk7Zce8dom23NbPZoH9zDYIK8wKnlCYw836j2PZcviIE6jf/uFKxh2vqu0Zr5ikqyF1Z
 Cqesj9oFfN4Q7RuKNWw==
X-Proofpoint-GUID: 0cJnVmQ4bRIRolMvG_bfEZQWhGTCptIu
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acd005f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fxeDLeT5AZ2qCvnLJ4gA:9
X-Proofpoint-ORIG-GUID: 0cJnVmQ4bRIRolMvG_bfEZQWhGTCptIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120062

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

Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 084a687762eb..394c478a4922 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2408,12 +2408,28 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
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


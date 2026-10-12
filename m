Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FD4A0926
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819875; cv=none; b=tLCSP3aIsTjoXh1rD3ZG2KqWGM6RaqtP40aH96Um9phDVvQexVN9xVuNF5KlduIXe5wicqNC2+jIveQqWn9qfNI7FGUiUkklm+ez3xbJWdzgvDds6MPtTHdQ+6NwPkXoWgc25fH8qABgfFkpkbsUpeCVRfbd90XbTbgG9eStgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819875; c=relaxed/simple;
	bh=9a1pwHIpt716K3HircBxYyMwJ+5zPjwxh5/wiD/M3F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy2K4lGViR4k1dINTAVEOcehXSzw4ClEJClkqhbh4hwNif+m3FDH7rBZgeXMNJVuhPVsu++/CmuYyxll8T9NNny492i8U0Z5s3sNwEtqpAfACkJ62npjd9aeazURAuDf1xusxN3p+9TS9bW1GOuv0Q7bDXbQSndmAvRao3u05LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YWljDvUb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YWljDvUb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiWSK3075166
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yCXnhk
	wOMtCpZOLBi928bwdzG2AKduoJuoCsplL6ips=; b=YWljDvUb8PljOOS1oe6uSW
	Rc0it1PBuUjNZHLoqlwOPV60Ik9suaOy/+I8jc7FxNrgj7txZivTNXEIt+3FdyAJ
	mbl2wApCqXPhqUKHPuhqWB/q+9YAyhCz6Udz5J5VWxjAj3FxnLEZjOnNbQ0jN5cY
	78nFHY2i4zhVtN9Ds0rdpV86Uv/yuWtMNKGquRT9Q9RTsX/Ry09T9IsED2WRpr2b
	yzEZ7tDCHDFiNNCOaJ/UnShPqofl4Iwp/LV1egA0TDPnkfvTmkbPKObozTs1SnFc
	gDBNYWqKD+F6Y1BizD0LJDNonEH5s+KBkZ6wYv7CwIsr269UZqNtwEJLTsNBtCWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9p38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4xhT1287098
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwrt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFiUSr4063946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:44:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 040B15804E;
	Mon, 12 Oct 2026 15:44:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73CA25803F;
	Mon, 12 Oct 2026 15:44:29 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:44:29 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v10 4/6] s390/vfio-ap: fix queue state leakage to guest and host
Date: Mon, 12 Oct 2026 11:44:23 -0400
Message-ID: <20261012154425.2860783-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
References: <20261012154425.2860783-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX+ap5uPMlbRF+
 0g78KCLfcZZm1bbZrDHsnMveul65lMhK+04je/XMW+v/dVZBJuOJXYfRgyaUp7AZbnfGE0Eh/um
 K7XdEwaHgPL06b3OxTWpTw272u5CngU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX3LQ0PUP/yn96
 qFIgjLLl4MkGWx731j3NCAQgpoo0V51jwJnoqtYYu2SPJJqj7n+kWpzyPmQLXHAJjUZUWmZgzR8
 zpsN6aPrPHCh0ZSAtM6HMEx7ZufA5TX17AVuOKI8LUSkD981GBgVmTh9dgy+edEQ0pZ1MToDYXE
 KBH8D8+wN9C3Vrn5XlmOziwDYlxAOkpv+/44noYzQNaTOuF7QSw3z9/JLwXv/hiZPdql6fNWl+P
 WqRWc1+vjG//2THOpzEwhqFwulzSGMHoPw7l9WTZTGtfMEJ+VyPqFCOM0ZDJu583eulGVF/TFhr
 LGy7ACfXct6I/hMlwxiU+O/iTOr/tX6zxonEsLe0VxZBZVJWJ13FMQn//G/f1+B8FQX+2/rMIGy
 iNo7zAW/3yfatn6Uc9T3sTqhINj3M31D++4g3PDiw9sMtuBTBAOXTCV02AnDqmLGslkQskr1CA3
 4nQMwIDa//KY+Cka6eg==
X-Proofpoint-GUID: LkHu2cqfa7FPYl-2qGe9w6zOiX2kFFkx
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acd0060 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jlZToIIxN1rEBdRxh4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LkHu2cqfa7FPYl-2qGe9w6zOiX2kFFkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120062

_queue_passable() accepted AP_RESPONSE_DECONFIGURED and
AP_RESPONSE_CHECKSTOPPED as passable states in addition to
AP_RESPONSE_NORMAL. Neither DECONFIGURED nor CHECKSTOPPED
confirms that the queue was zeroized; only AP_RESPONSE_NORMAL
(0) does. A queue not confirmed zeroized must not be passed
through to a guest, as it may contain key material from a
previous guest or host operation.

_queue_passable() is therefore changed to a two-step check.
First, reset_status.response_code is verified to be
AP_RESPONSE_NORMAL; if not, the queue is not passable
regardless of its current hardware state. Second, a live
PQAP(TAPQ) is issued to detect state changes that occurred
after the last reset — such as a subsequent deconfigure or
checkstop — without requiring a callback from the AP bus.
Only the response code from TAPQ is checked; queue_empty and
irq_enabled are not examined because reset_status ==
AP_RESPONSE_NORMAL already confirms the queue was zeroized
and interrupts were disabled at reset time. If TAPQ returns
AP_RESPONSE_BUSY, the queue state cannot be determined and
the queue is treated as not passable; since reset_status was
NORMAL this is expected to be transient and the queue will
be re-evaluated on the next filter_matrix call.

vfio_ap_mdev_probe_queue() calls vfio_ap_mdev_reset_queue()
and flush_work() while holding the update locks to guarantee
a clean queue before it can be admitted to a guest. This
adds at least AP_RESET_INTERVAL (20 ms) of lock-hold time
per probed queue, since apq_reset_check() sleeps before its
first TAPQ. In theory this is O(N) serialized under the
global mdevs_lock; in practice, AP hardware constraints and
typical deployment sizes bound the number of queues allocated
for guest use in a single LPAR to a modest number, so the
total probe cost is not necessarily a real-world concern.

Deferring the reset outside the lock-held section is not
safe: apq_reset_check() accesses q->reset_status and
q->aqic_resources without holding any lock, and
vfio_ap_mdev_remove_queue() can run concurrently and call
kfree(q) after releasing the locks, leaving the worker with
a dangling pointer. flush_work() inside the lock-held
section serializes against remove_queue and prevents this.

The fundamental remedy would be to replace the global
mdevs_lock with a per-mdev lock, scoping the blocking to
the single mdev whose queue is being probed and allowing
resets across different mdevs to proceed in parallel. That
is a non-trivial redesign of the locking architecture and
is deferred to a separate effort.

vfio_ap_mdev_set_kvm() is updated to call filter_matrix
before updating the guest APCB at open_device time. This
ensures that a queue which became operational (or
non-operational) after the shadow_apcb was last updated —
but before the guest was started — is correctly admitted or
excluded when the guest boots.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 55 ++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 627f8ed0a960..a9438b3c5a70 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -859,19 +859,38 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
 			     AP_DOMAINS);
 }
 
+/**
+ * _queue_passable:
+ *
+ * In order to prevent leaking of sensitive data to a guest, a queue must have
+ * been reset before passing it through. If the status stored for the most
+ * recent reset operation is anything other than AP_RESPONSE_NORMAL, then the
+ * queue can not be passed through. On the other hand, the status of the queue
+ * could have changed since the last reset; for example, the queue could have been
+ * deconfigured via the HMC/SE or the sysfs config interface for a crypto card,
+ * or something could have occurred - e.g., a hardware failure - that moved the
+ * queue status to check stop state. To verify the queue is still passable,
+ * the PQAP-TAPQ instruction will be executed to determine the current state
+ * of the queue.
+ *
+ * @q:	the object containing the data associated with a queue bound to the
+ *	vfio_ap device driver
+ *
+ * Returns:	true if the queue can be safely passed through to a guest;
+ *		otherwise,returns false
+ */
 static bool _queue_passable(struct vfio_ap_queue *q)
 {
+	struct ap_queue_status status;
+
 	if (!q)
 		return false;
 
-	switch (q->reset_status.response_code) {
-	case AP_RESPONSE_NORMAL:
-	case AP_RESPONSE_DECONFIGURED:
-	case AP_RESPONSE_CHECKSTOPPED:
-		return true;
-	default:
+	if (q->reset_status.response_code != AP_RESPONSE_NORMAL)
 		return false;
-	}
+
+	status = ap_tapq(q->apqn, NULL);
+	return status.response_code == AP_RESPONSE_NORMAL;
 }
 
 /*
@@ -2020,6 +2039,8 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct kvm *kvm)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
+
 	if (kvm->arch.crypto.crycbd) {
 		get_update_locks_for_kvm(kvm);
 		if (kvm->arch.crypto.pqap_hook) {
@@ -2030,6 +2051,15 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
+		/*
+		 * Filter the matrix to ensure the shadow_apcb reflects the
+		 * current operational state of all assigned queues. A queue
+		 * may have become operational (or non-operational) since the
+		 * shadow_apcb was last updated. Any adapters newly filtered
+		 * out are reset to prevent stale state from reaching the guest.
+		 */
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered))
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 		release_update_locks_for_kvm(kvm);
 	}
@@ -2357,9 +2387,9 @@ static void apq_reset_check(struct work_struct *reset_work)
 				 * the host kernel.
 				 *
 				 * Record the TAPQ status so the queue is marked
-				 * not-passable - _queue_passable() checks
-				 * reset_status.response_code == AP_RESPONSE_NORMAL -
-				 * and the queue is not passed through to a guest.
+				 * not-passable: _queue_passable() first checks
+				 * reset_status.response_code == AP_RESPONSE_NORMAL,
+				 * and the queue will not be passed through to a guest.
 				 */
 				memcpy(&q->reset_status, &status, sizeof(status));
 				return;
@@ -2912,6 +2942,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
 
 		/*
 		 * If we're in the process of handling the adding of adapters or
@@ -3001,8 +3033,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_unlink_queue_fr_mdev(q);
 
 	dev_set_drvdata(&apdev->device, NULL);
-	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
+	kfree(q);
 }
 
 /**
@@ -3408,3 +3440,4 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 
 	mutex_unlock(&matrix_dev->guests_lock);
 }
+
-- 
2.53.0


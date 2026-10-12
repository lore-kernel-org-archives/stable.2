Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACA4AA567
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819875; cv=none; b=kmtt/ZINDJD+OWJM7+aPNAVv5jd2U5s91Ww2HximmDxYaghFtAHOr7YNrvJdjL/bfEwcDtiieZxIAtOocvm00WsAx2itTLPKcOobxGpB81XlLdo9pnjzPxrzPJyCFANfeI5m89a7GvTZyTFPiN28eCzJApKZEOTWuQPS+Q15Nwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819875; c=relaxed/simple;
	bh=KP7f2dsc7V+pTZbsCvP4xYyqOyBOSrMc5SX1IolmH4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peig1KN8omRfx313w2oMTveWy9p6irywdh+HlBH7MPeniNjhVtfFbRSqSqD1Ac1BTenDZdHM66UivqwXYB8UusO8gWkYTUFJnFuY04QRURHdD2w+XcRVsrLPtlvtCjVtKj7t3C2hStZ4cwDd9uc8UjvWNgc+uSTzhQ4Se2SbKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6X31Iy/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6X31Iy/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiVVA3645346
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cZhPaezSpbH4qjnSj
	IAq1nZ3MfVs4CviD0Cu7y3/fxw=; b=h6X31Iy/1kXTYedYBfDP9ubyXfXmwe2od
	mIi5ES8ZxoxYwiHGKvbi+YD4otoP3JiYDwqeu+DFNPvUCVm/LFLwg8ypdDpheijY
	00aDmoqrvxFawzeg0TtB3QWG9umD8G7LTQ8Qt7IgTE3HnRDgiKFASS0fg7fjepCz
	XN6nc4TGdFxjikCeNTsY9/hUf+RNsnSmHs5m5UIfic54q4yeCVEcZ2QqjsqBVMwp
	KVQIeHtZgLPhPEcDuRHHmMznKehxP9u+o0ar8SMcLniv1mAJqSqYtjgomGxIPzZt
	7Dhg4lBzRHVXUzwvuA7U0+652k4EVqJSM9ntlQm8J8z25bhtbDrgg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv09btj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4tvu1286757
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwrt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFiTc729033046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:44:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A19E5804E;
	Mon, 12 Oct 2026 15:44:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B617F5803F;
	Mon, 12 Oct 2026 15:44:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:44:28 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v10 3/6] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
Date: Mon, 12 Oct 2026 11:44:22 -0400
Message-ID: <20261012154425.2860783-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX1RiIT4gnpxdw
 vKCITSE29544YSsXXOlkG5JGAKvPYTQnwwqPvD2Elrx47j+KqRInUxSuI4DzIafYd5Ec8MHJAOD
 6PYofiH9W+8WzBt/DQPIuyfIBVch44ILnwTLwLQ0F/TduchfyErp0GDL5O7HR//djVGU8KHSsFU
 fCh4bo8Hwey+O+mGeGtk2FKphFkOoU7k+I1U0VchJFrzITvAMBOlB9W6g8KB40omaHCZZMZIK48
 XFJtgqnmylEJE1gZrkqIBaSpa/XgyvJwoPKZViXJDaYEiDlOzRaW46YTKtRWRPHMmBq+BBr8trp
 gB8jPFXWJ25jX8L3N+t0R4qCw8FXSTmn7P66itIUe31f5ZOAn6c1V1PEs9u5W2abOXtydda7BAL
 LZIOy1vVSi+ubeVcToMtRrDhSa6E9RbHVQrBua8OdLe2HB8yAsWh4kErsV9joOnLdoz2v5NtT50
 zy28oL+780NbZmx6qDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXzJhx8z8PnVHe
 c8eg4Xo/bzYYuc8DLnWR2nsu+6b99DwPoY0DZ/vKcb6Xc+fAuNnxv2fggR4FmvQV7JfoVl+qhOf
 Z4W69r/obs3yUGedYNA+B7eG/9J5/Oo=
X-Proofpoint-ORIG-GUID: FM5krlLZJUR_4FOFDn83rCPfMdn1L2sR
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acd005f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=odYwHY3bu180nF8uCmMA:9
X-Proofpoint-GUID: FM5krlLZJUR_4FOFDn83rCPfMdn1L2sR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120062

The apq_reset_check() worker polls ap_tapq() in a while(true)
loop waiting for a queue reset to complete. When ap_tapq()
returns AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
apq_status_check() returns -EBUSY and the loop continues after
sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on how
many times the loop iterates, so if the hardware continuously
returns a busy response the worker runs indefinitely.

This is particularly harmful because several callers of
vfio_ap_mdev_reset_queue() - such as vfio_ap_mdev_reset_queues(),
vfio_ap_mdev_reset_qlist() and vfio_ap_mdev_remove_queue() -
call flush_work() on the queue's reset_work while holding one
or more of the global matrix_dev locks (guests_lock,
mdevs_lock) or the KVM lock. An indefinitely spinning worker
permanently blocks access to all ap_matrix_mdev objects, which
could hang other guests that are using them.

Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking
out of the poll loop when elapsed time reaches that threshold.

If apq_reset_check() times out before verifying completion of
the reset, the NIB page cannot be freed. The NIB is the active
DMA target for AP interrupt delivery until the reset completes;
freeing the pinned page would allow it to be reallocated to a
new owner. A subsequent hardware wild DMA-write to that physical
address would corrupt the new owner's memory and could crash or
compromise the host kernel.

The ISC registration is not a DMA target and can be freed
immediately at timeout. report_apq_reset_check_timeout()
unregisters the ISC on the KVM that was used at enable time
(held via kvm_get_kvm() since vfio_ap_irq_enable()), preventing
kvm_s390_gisa_destroy() from WARNing at VM teardown for every
queue whose reset timed out.

If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page will be leaked. This is
preferable to a compromised kernel or kernel crash, or waiting
indefinitely and blocking access to all mdevs, hanging the
guests to which they are attached.

To prevent a use-after-free when the leaked NIB outlives the
matrix_mdev, vfio_ap_unlink_mdev_fr_queue() clears the embedded
vdev pointer on unlinking so subsequent queue cleanup will not
dereference freed memory.

This patch also fixes a bug whereby AP_RESPONSE_NORMAL (0)
returned from PQAP(ZAPQ) was incorrectly treated as
confirmation that the queue was zeroized. AP_RESPONSE_NORMAL
only indicates that the ZAPQ was accepted; zeroization is
performed asynchronously. To confirm completion, the following
bits in the status word returned from PQAP(TAPQ) must all
be verified:

status->irq_enabled == 0
status->queue_empty == 1
status->replies_waiting == 0
status->async == 0

This patch also fixes a bug in the top-of-loop ZAPQ re-issue
branch of apq_reset_check(). When q->reset_status holds
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS from the initial ZAPQ,
the worker re-issues the ZAPQ but did not copy the result back
to q->reset_status. On the next iteration the stale response
code caused the ZAPQ to be re-issued again, repeating every
20ms until the 2s timeout regardless of what the re-issued ZAPQ
returned. The memcpy is added to update q->reset_status so the
loop transitions correctly to the TAPQ polling path once the
re-issued ZAPQ is accepted.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 188 ++++++++++++++++++++++--------
 1 file changed, 137 insertions(+), 51 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 394c478a4922..627f8ed0a960 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1020,6 +1020,15 @@ static void vfio_ap_unlink_queue_fr_mdev(struct vfio_ap_queue *q)
 	hash_del(&q->mdev_qnode);
 }
 
+/**
+ * vfio_ap_unlink_mdev_fr_queue - dissociate a queue from its matrix_mdev
+ * @q: the vfio_ap_queue
+ *
+ * Dissociates @q from its matrix_mdev and clears any references to the
+ * matrix_mdev's embedded vdev and kvm. This prevents a use-after-free
+ * if a reset timed out (which leaks AQIC resources) and the mdev is
+ * subsequently freed before the queue is destroyed.
+ */
 static void vfio_ap_unlink_mdev_fr_queue(struct vfio_ap_queue *q)
 {
 	q->matrix_mdev = NULL;
@@ -2232,7 +2241,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 		/*
 		 * These asynchronous response codes indicate a PQAP(AAPQ)
 		 * instruction to associate a secret with the guest failed. All
-		 * subsequent AP instructions will end with the asynchronous
+		 * subsequent PQAP-TAPQ invocations will end with the asynchronous
 		 * response code until the AP queue is reset. Re-issue the ZAPQ.
 		 */
 		return -EAGAIN;
@@ -2247,8 +2256,77 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	}
 }
 
+static void report_apq_reset_check_timeout(struct vfio_ap_queue *q)
+{
+	/*
+	 * The ISC registration updates the refcount in the GISA alert mask.
+	 * Unregister it now on the KVM that was used at enable time; the
+	 * reference kept since vfio_ap_irq_enable() guarantees the pointer
+	 * is valid here.  Leaving the ISC registered would prevent the
+	 * refcount from ever reaching zero, causing kvm_s390_gisa_destroy()
+	 * to WARN at VM teardown for every queue whose reset timed out.
+	 */
+	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
+		if (q->aqic_resources.kvm) {
+			kvm_s390_gisc_unregister(q->aqic_resources.kvm,
+						 q->aqic_resources.isc);
+			kvm_put_kvm(q->aqic_resources.kvm);
+			q->aqic_resources.kvm = NULL;
+		}
+		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+	}
+
+	if (q->aqic_resources.iova) {
+		if (q->matrix_mdev) {
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "Reset timed out for APQN %02x.%04x: leaking NIB page to prevent host crash\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn));
+		} else {
+			pr_warn_ratelimited("Reset timed out for APQN %02x.%04x: leaking NIB page to prevent host crash\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn));
+		}
+	} else {
+		if (q->matrix_mdev) {
+			dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
+					     "Reset timed out for APQN %02x.%04x\n",
+					     AP_QID_CARD(q->apqn),
+					     AP_QID_QUEUE(q->apqn));
+		} else {
+			pr_warn_ratelimited("Reset timed out for APQN %02x.%04x\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn));
+		}
+	}
+}
+
 #define WAIT_MSG "Waited %dms for reset of queue %02x.%04x (%u, %u, %u)"
 
+/**
+ * apq_reset_finalize - store final TAPQ status and free AQIC resources.
+ * @q:      the vfio_ap_queue
+ * @status: the final AP queue status returned by PQAP(TAPQ)
+ * @ret:    the return value from apq_status_check()
+ *
+ * Copies the full TAPQ status word to q->reset_status so that all status
+ * bits reflect the confirmed end state of the queue. If ret == 0,
+ * zeroization was confirmed and the response code is overridden with
+ * AP_RESPONSE_NORMAL so that _queue_passable() returns true. For
+ * ret == -ENODEV (DECONFIGURED or CHECKSTOPPED), the non-zero response
+ * code is left intact so _queue_passable() correctly returns false.
+ * AQIC resources are then freed.
+ */
+static void apq_reset_finalize(struct vfio_ap_queue *q,
+			       struct ap_queue_status *status, int ret)
+{
+	memcpy(&q->reset_status, status, sizeof(*status));
+	if (!ret)
+		q->reset_status.response_code = AP_RESPONSE_NORMAL;
+
+	vfio_ap_free_aqic_resources(q);
+}
+
 static void apq_reset_check(struct work_struct *reset_work)
 {
 	int ret = -EBUSY, elapsed = 0;
@@ -2260,65 +2338,73 @@ static void apq_reset_check(struct work_struct *reset_work)
 	while (true) {
 		msleep(AP_RESET_INTERVAL);
 		elapsed += AP_RESET_INTERVAL;
-		status = ap_tapq(q->apqn, NULL);
-		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO) {
-			/*
-			 * TAPQ returned an invalid response code indicating a
-			 * hardware or firmware bug. Since we cannot determine
-			 * whether the queue can still DMA-write to the NIB, the
-			 * AQIC resources are intentionally leaked lest the NIB
-			 * page is reallocated to a new owner. A subsequent
-			 * wild DMA-write to that physical address would corrupt
-			 * the new owner's memory which could crash or compromise
-			 * the host kernel.
-			 *
-			 * Record the TAPQ status so the queue is marked
-			 * not-passable - _queue_passable() checks
-			 * reset_status.response_code == AP_RESPONSE_NORMAL -
-			 * and the queue is not passed through to a guest.
-			 */
+
+		if (q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS) {
+			status = ap_zapq(q->apqn, 0);
 			memcpy(&q->reset_status, &status, sizeof(status));
-			return;
-		}
-		if (ret == -EBUSY) {
-			pr_notice_ratelimited(WAIT_MSG, elapsed,
-					      AP_QID_CARD(q->apqn),
-					      AP_QID_QUEUE(q->apqn),
-					      status.response_code,
-					      status.queue_empty,
-					      status.irq_enabled);
 		} else {
-			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
-			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
-			    ret == -EAGAIN) {
+			status = ap_tapq(q->apqn, NULL);
+			ret = apq_status_check(q->apqn, &status);
+			if (ret == -EIO) {
 				/*
-				 * RESET_IN_PROGRESS in reset_status means the
-				 * initial ZAPQ was rejected because a prior reset
-				 * was already running. That reset does not zeroize
-				 * the queue; re-issue the ZAPQ once it clears.
-				 *
-				 * STATE_CHANGE_IN_PROGRESS in reset_status means
-				 * the initial ZAPQ was rejected because the queue
-				 * was mid-transition; re-issue once it clears.
+				 * TAPQ returned an invalid response code indicating a
+				 * hardware or firmware bug. Since we cannot determine
+				 * whether the queue can still DMA-write to the NIB, the
+				 * AQIC resources are intentionally leaked lest the NIB
+				 * page is reallocated to a new owner. A subsequent
+				 * wild DMA-write to that physical address would corrupt
+				 * the new owner's memory which could crash or compromise
+				 * the host kernel.
 				 *
-				 * -EAGAIN means TAPQ returned an ASSOC error code
-				 * (0x35/0x36): the queue is stuck until reset.
-				 * Re-issue the ZAPQ to recover.
+				 * Record the TAPQ status so the queue is marked
+				 * not-passable - _queue_passable() checks
+				 * reset_status.response_code == AP_RESPONSE_NORMAL -
+				 * and the queue is not passed through to a guest.
 				 */
+				memcpy(&q->reset_status, &status, sizeof(status));
+				return;
+			} else if (ret == -EAGAIN) {
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
-				continue;
+			} else if (!ret || ret == -ENODEV) {
+				/*
+				 * We are here for one of two reasons:
+				 *
+				 * Zeroization confirmed (ret == 0): the TAPQ status bits
+				 * indicate the async portion of the ZAPQ completed
+				 * successfully.
+				 *
+				 * Queue non-operational (ret == -ENODEV): the queue is
+				 * deconfigured or checkstopped; interrupts are not
+				 * possible. Zeroization cannot be confirmed in this state,
+				 * but the queue cannot generate interrupts, so the
+				 * NIB page is no longer a DMA target.
+				 *
+				 * In either case, it is safe to free up the AQIC
+				 * resources.
+				 */
+				apq_reset_finalize(q, &status, ret);
+				return;
 			}
-			/*
-			 * We end up here when the reset has completed (TAPQ
-			 * returned NORMAL with all status bits clear, or
-			 * DECONFIGURED/CHECKSTOPPED). The queue is zeroized or
-			 * non-operational; free the AQIC resources.
-			 */
-			vfio_ap_free_aqic_resources(q);
-			break;
 		}
+
+		/*
+		 * If we haven't returned above, the reset is still in progress
+		 * or being retried. Check for timeout before continuing.
+		 */
+		if (elapsed >= AP_RESET_MAX_WAIT) {
+			report_apq_reset_check_timeout(q);
+			return;
+		}
+
+		if (ret == -EBUSY)
+			pr_notice_ratelimited(WAIT_MSG, elapsed,
+					      AP_QID_CARD(q->apqn),
+					      AP_QID_QUEUE(q->apqn),
+					      status.response_code,
+					      status.queue_empty,
+					      status.irq_enabled);
+
 	}
 }
 
-- 
2.53.0


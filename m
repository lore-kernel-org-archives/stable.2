Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579059;
	b=amWAniUD6/+bEFF5g+P9ebgGdhY/vZBQK3JqknAKu4eNemwxA2dlMGegs42QiX+G7ZGx
	 uXF7fzyPczV88dD+s6F0li7fQy4XB1Dwi6uE/fLRNKL0U2Vws/NQrS3T4O77DnctAVE5z
	 3IxkzSka1ZgIUW0YOi6jDG5JTvmk2w+Vbtd3nvtJqBfy1PI7KTGBtJJKDcj/avBss41Mx
	 JLmqBQWMVYdVpK/6A5OvexI65QK554f0sbIzVUi3YyoEDrA6U01/KTfMpcza9AE8P5zbJ
	 cNDCTFxaXcb2CN38S5VogxnQZfGyKYTk9m4Yx4JMM+NRrZ+5rOXTy5Bw9zphWGA3+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LvCY5XmUu2JlyPi/xLPqZv3G8qABve4TcwRdFql4Bps=;
	b=gGfs8OrYQJPqiRC4GYNwNYPpKI40tUe2CLhuZZp0Z1da/aspruCVWnZ+W6RgbAEcGQ0d
	 4mdq3dqaM836yI9b054lHWmjwQbf3Vfb4xXG5hShGrlN8H6Si1WiWH1bpHvXCSWVTT9rM
	 s6jtLuXnT3ZI4KOqID7vPt+prfXd8xVgm8nULssNVGYRC0cvGdr2nzpphVYb6r/70Dt0Y
	 rSr4hJ11SyZNSkojTFbBf1LHMaAftxaiDkcCnvG6zyEajLzG2LJhwmulf67wTDN+Wc1HE
	 a/lJLbUGXijQAsBFtLYIujiBLS/eq/XUJ8UMWGZZsv86wlDYraEgAOC7dQ10cHsNttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VBuxly+4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25555606A893
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25555606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VBuxly+4
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEF7j2893570
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LvCY5XmUu2JlyPi/x
	LPqZv3G8qABve4TcwRdFql4Bps=; b=VBuxly+4oAc5GMY3cHM9NEL1eSgfPxzL3
	xOTfV/AmFKSbS9RtPL41lVi2v5vXn+O9+uE4qIpoNc940dKhmzQkjgxx6Jmy2FiD
	0s3zo/clwr05a6T2Vb1ZTkI1hbXcNq9q7pnDx5MLWU41rDLp+lH7HIzlax57CDGN
	D+3ab8GQdzWVExOFjKjumPT/NJgbPi6L2+8fbE7hzZS3Y9RUfKkI4zEe+GCWXRT6
	YWsg4htwGzidNQvT/mjoX0cPc9ggiB3Shw2th+oOoVhcqbUuHjt0hgFpKp8SO5HZ
	qXILKW8ZESj2zj0rxZhP0ILZ0SzPUbldv909ayenMQmIw0LRn/GHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvamwa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5KcP2352642
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0tcm84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAudK31719982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03DBC58059;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2DF658058;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 14/20] s390/vfio-ap: bound the wait for a queue reset to complete
Date: Fri, 13 Nov 2026 09:10:36 -0500
Message-ID: <20261113141049.3747719-15-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXyZA0FiUKjLTF
 2p5TMk9tzX6/OeMOGHJiIj3vhc4TbVB6G+daf4Dy0TZADN8vOtrFdE8VskR+xYgzb/iTsUhM/lN
 XbhY4ALVgA4K91y2lzdr79kpQ8IbWfc=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af71a71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Em07ySnhIawSmG0C:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SUogfau1cZvqXH_5wnsA:9
X-Proofpoint-GUID: tp_-xQ-8O0RQPkbv08zj3tIe8-0y5Jub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXxXWEt5n5s4nQ
 VhaPF1UG4TiEbJP/7j6T12ui/5wB11VE2XzMPt4Q9tBApD1E35anP0uZI2KlGRzEXkFpbdA7dU9
 pZ8saaRYN3XjzHLGQaoRYN7vayl0aLibCgx2ZEzB8wJXsicscMaOs8ENs/ZaStFi23lSqDTFzMT
 cTcPG9HshgKp6nUL9K0vPHGmqJAa+CfMILYeQlKQ1kNxWSPm0b7QInugeHdBkWbOtLnTmeX19ph
 BGHgc5Xl6EzeD1y4/Ax3JI1u2oYXgWytzVJaN5fS6Qq5r6CuuPbReNQe+aaEyasmdiOSVk1RqeO
 8KfSIyvfwyt6sXBKgmV3bfwCQKNP07M5Un0rmZlN6LWvE6NyaudFLMxH+lIo6PfO5i62jj8oPZ1
 ss3J3n5KVNivXh2Q0KFkNJc2sFH8gEzP0LKczjf4ye9TsytP6L26FvbwjmxgkFqke6FVFp/tNMd
 gLd56sSvz7SoUKhJeng==
X-Proofpoint-ORIG-GUID: tp_-xQ-8O0RQPkbv08zj3tIe8-0y5Jub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

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

Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and giving up
when the elapsed time reaches that threshold. The check is made on
every iteration that has not completed the reset, including those
in which the ZAPQ was re-issued, so the loop is restructured to
fall through to it instead of using continue and break.

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
(kept alive by a reference on its VM file taken in
vfio_ap_irq_enable()), preventing kvm_s390_gisa_destroy() from
WARNing at VM teardown for every queue whose reset timed out.

If the reset eventually completes, interrupts will be
terminated, but the pinned NIB page will be leaked. This is
preferable to a compromised kernel or kernel crash, or waiting
indefinitely and blocking access to all mdevs, hanging the
guests to which they are attached.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 79 ++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 729af61d8ad3..a8a0452fe029 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -31,6 +31,7 @@
 #define AP_QUEUE_IN_USE "in use"
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
+#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
 
 static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
@@ -2261,6 +2262,50 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 	}
 }
 
+static void report_apq_reset_check_timeout(struct vfio_ap_queue *q)
+{
+	/*
+	 * The ISC registration updates the refcount in the GISA alert mask.
+	 * Unregister it now on the KVM that was used at enable time; the
+	 * reference held on its VM file since vfio_ap_irq_enable() guarantees
+	 * the KVM is valid here.  Leaving the ISC registered would prevent the
+	 * refcount from ever reaching zero, causing kvm_s390_gisa_destroy()
+	 * to WARN at VM teardown for every queue whose reset timed out.
+	 */
+	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
+		if (q->aqic_resources.kvm_file) {
+			kvm_s390_gisc_unregister(file_to_kvm_s390(q->aqic_resources.kvm_file),
+						 q->aqic_resources.isc);
+			vfio_ap_aqic_put_kvm(q);
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
 
 static void apq_reset_check(struct work_struct *reset_work)
@@ -2299,14 +2344,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 			vfio_ap_free_aqic_resources(q);
 			return;
 		}
-		if (ret == -EBUSY) {
-			pr_notice_ratelimited(WAIT_MSG, elapsed,
-					      AP_QID_CARD(q->apqn),
-					      AP_QID_QUEUE(q->apqn),
-					      status.response_code,
-					      status.queue_empty,
-					      status.irq_enabled);
-		} else {
+		if (ret != -EBUSY) {
 			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
 			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
 			    ret == -EAGAIN) {
@@ -2326,12 +2364,29 @@ static void apq_reset_check(struct work_struct *reset_work)
 				 */
 				status = ap_zapq(q->apqn, 0);
 				memcpy(&q->reset_status, &status, sizeof(status));
-				continue;
+			} else {
+				if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID)
+					vfio_ap_free_aqic_resources(q);
+				return;
 			}
-			if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID)
-				vfio_ap_free_aqic_resources(q);
-			break;
 		}
+
+		/*
+		 * The reset is still in progress or is being retried. Give up
+		 * if it has not completed within the maximum wait time.
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
 	}
 }
 
-- 
2.53.0


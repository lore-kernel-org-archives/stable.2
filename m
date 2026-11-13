Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579059;
	b=OylhXaz2qTy0rozCAwcyVKCwkPldt/LuJGGPjEzincghvkf5wmEG5c3I0sl2EwiF2gQa
	 CnCrJFC38c40ODFlCz9TTYPsMEXTwDKxr4+vvCNip1R/J7heDDqLHg2e9mLtntauBV0Kn
	 FDbQ7a/K6V7nudm7EyUtLAY3sl+SuquhOjwPNIxzeVan/7e9B17TWlbM4YpCPuZujazCX
	 UAnBR84IyAINzBeh8bCskKfK7nICf5AfeEa8Tvrqec4/sjTmGWCXfM92ZXuMeBAgWWpys
	 8myQjyS9i1KsfOBri4fvJu2+pOrpUWNdRYaK1WXsaK971u9vfEc1OaoFCQnnlTWEm5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PMPsyDD+i8ykDgsEpe+mcSpKwDtKLSMr0n+oCXK4ero=;
	b=TO6UBtv5T5g+WzAtQVb4m9GOV4r7n8i1hMLjQ0HXIk1lt12PPBaQnvlz9+YlBaOl4sIs
	 XxMV8KQBjOwX6aNM6KDxVkqG8FkSSIxj2WnzQ4yS0IeAgeY1lOAcwEDd01ioVZspEqZpY
	 CiWCpcHgZvHwB+xupPbrhSoA7nDmgCF3ROKSh/L621fJjXXDg1Qx5GI5hZmmCKRDLVEY9
	 tkrnJNwtf0mfBg8sMjc5GK1gtBMrr8bAbCtebkqtTgZqDOqmLhxvfPc4mNUJ8Xh3Keozf
	 nFLksxTNcEMB9jYgWk/0KTPTeP6R8l4rboF5rMzt7dcJ8bVQ492hVK/ezjbchgFJhnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MRuzAcp5;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D53606A89B
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D53606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MRuzAcp5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEFTF2893574
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PMPsyD
	D+i8ykDgsEpe+mcSpKwDtKLSMr0n+oCXK4ero=; b=MRuzAcp521d/hS8L1yAz9S
	gzrQE+mWGbJaWS/HOjTzYvEmP2avON/XNoFbWX4d/IugL/XB7mKwugmyULC3CLQy
	LJOu1kk+PWjF3iCKLOscX88OHqEKGIdC6hWtcg+ZWwLATm5PY46TNMRyJrOHUs6A
	s/VT2tFjSm76coWUwEvHOM1vg2nSLIFQnn8SRoW/m4r64DdZzitvACyy72g4LrGK
	9kG9miQ99WjvqumcTXPGGo65zUKL8n2qD7yOj1UaFHqnLdctPmm1TUgAupDdzmVU
	87RiDgb5OjZfFc5dUk/qBeDoTM+G8i92CX93qn/+ZETMGT3vVss6FnFCzC/OYRyQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvamwc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FI42213396
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAu9B31719984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65EF958058;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2189258057;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 15/20] s390/vfio-ap: confirm zeroization before treating a queue reset as complete
Date: Fri, 13 Nov 2026 09:10:37 -0500
Message-ID: <20261113141049.3747719-16-akrowiak@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX5BpvysVhYwqT
 O6Af3DdTnFRSWWF45zlHBTuW1oDBaskhd7O7KRc79j5cmAHmNAxvFdR+1qGyd4KMOl1C+JyUrj/
 Xlk9cFkf52wpIMv2xrzK69NtFCabTkk=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af71a72 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=098NVR5-sMsfbKwPeGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZO_tDhJWZi8MGnuZ9LsHUbN7VhYzSiG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXxWrbHRgGnMI9
 co4g/OLhc4mfjARnavlDrkV7FsUK9Y52sLfkvsBYuV4578iepl+vBYvMPHlpPAOUHO/wJlbTLP5
 INBNhYq5kNKrTQHQIn/DSFzHCDrvrXNlVYXjWNhJGm8K2U7f+ST+/7PrFCMD5/+5H7pLr/t0an8
 tLQLhofpbZ9UWxGiQD5jvVDDExtgZpUkjt0zQAPeK+n4Z093ofd1aLyGzP3inxfvD8RSjAwTPxL
 35Xn7dYu3YJYRdndI9f49R+kjAl0hRJa417k9qLvpT69IsyKA8Jy7aItgJh1u9UkbXDo1PmxSg1
 q8QpVXjJhMSu2ry1hcpW4djcVrHosiKMc3tcm6fLXgK7YZNhqw1izxZeCZco+Pye5WXoJRZfn73
 ak8rkCU6ihuMTRmTHAMLbnY9uiZt7bqIE9FOYHz0f3fei4lyFrIbw9yOshjqHK14BF81scJNt4q
 UwwJDktM4sLD+SfZgEw==
X-Proofpoint-ORIG-GUID: ZO_tDhJWZi8MGnuZ9LsHUbN7VhYzSiG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

apq_status_check() treated AP_RESPONSE_NORMAL (0) returned from
PQAP(TAPQ), as well as DECONFIGURED and CHECKSTOPPED, as
confirmation that a queue reset had completed. AP_RESPONSE_NORMAL
only indicates that the PQAP(ZAPQ) was accepted; zeroization is
performed asynchronously. To confirm completion, the following
bits in the status word returned from PQAP(TAPQ) must all be
verified:

status->irq_enabled == 0
status->queue_empty == 1
status->replies_waiting == 0
status->async == 0

Keep waiting until they are. This relies on the bounded wait
introduced by the previous patch: a guest can keep a queue
non-empty, so the wait must not be able to last forever.

When TAPQ returns AP_RESPONSE_DECONFIGURED or
AP_RESPONSE_CHECKSTOPPED, all status bits are zero, so there is no
way to distinguish a zeroized queue from one that was not
zeroized. Interrupts are not possible in these states, so the AQIC
resources can be freed, but zeroization cannot be confirmed.
Return -ENODEV rather than 0 so the caller does not record the
reset as confirmed.

Add apq_reset_finalize() to store the final TAPQ status in
q->reset_status and free the AQIC resources. If zeroization was
confirmed, the response code is set to AP_RESPONSE_NORMAL so that
_queue_passable() returns true. For DECONFIGURED and CHECKSTOPPED
the non-zero response code is kept, so that these queues can be
told apart from one whose zeroization was confirmed.

Document the handling of AP_RESPONSE_RESET_IN_PROGRESS and
AP_RESPONSE_BUSY in apq_status_check(). A reset in progress may be
the one started by our ZAPQ or a prior one, such as a RAPQ from the
AP bus or the guest; either zeroizes the queue, so keep waiting
until the status bits confirm it. BUSY says nothing about whether
our ZAPQ was accepted, so it is treated the same way, without
re-issuing the ZAPQ.

Fixes: 0daf9878a799 ("s390/vfio_ap: check TAPQ response code when waiting for queue reset")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 151 +++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 45 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a8a0452fe029..4c252e19304e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2235,12 +2235,50 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
 {
 	switch (status->response_code) {
 	case AP_RESPONSE_NORMAL:
+		/*
+		 * This response code only indicates that the PQAP(ZAPQ) has
+		 * been initiated. The following bit settings in the status
+		 * returned from TAPQ must be verified to confirm that the
+		 * asynchronous portion of the queue zeroization has completed.
+		 */
+		if (status->queue_empty && !status->replies_waiting &&
+		    !status->irq_enabled && !status->async)
+			return 0;
+
+		/* Async zeroization still in progress; keep waiting */
+		return -EBUSY;
+
 	case AP_RESPONSE_DECONFIGURED:
 	case AP_RESPONSE_CHECKSTOPPED:
-		return 0;
+		/*
+		 * The queue is non-operational: interrupts are not possible so
+		 * AQIC resources can be safely freed. However, zeroization
+		 * cannot be confirmed because all status bits are zeroed when
+		 * these response codes are returned — there is no way to
+		 * distinguish a zeroized queue from one that has not been
+		 * zeroized. Return -ENODEV to signal that AQIC resources should
+		 * be freed but that zeroization has not been confirmed.
+		 */
+		return -ENODEV;
+
 	case AP_RESPONSE_RESET_IN_PROGRESS:
+		/*
+		 * A reset is in progress. It may be our ZAPQ or a prior reset
+		 * (e.g. a RAPQ from the AP bus or guest). Either one zeroizes
+		 * the queue, so keep waiting; the status bits checked for
+		 * AP_RESPONSE_NORMAL confirm when zeroization has completed.
+		 */
+		return -EBUSY;
+
 	case AP_RESPONSE_BUSY:
+		/*
+		 * TAPQ returned BUSY (rc 05). This says the queue is busy but
+		 * tells us nothing about whether our ZAPQ was accepted: the
+		 * zeroization may already be in progress. Treat it the same as
+		 * RESET_IN_PROGRESS — keep waiting without re-issuing the ZAPQ.
+		 */
 		return -EBUSY;
+
 	case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
 	case AP_RESPONSE_ASSOC_FAILED:
 		/*
@@ -2308,6 +2346,30 @@ static void report_apq_reset_check_timeout(struct vfio_ap_queue *q)
 
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
@@ -2319,61 +2381,59 @@ static void apq_reset_check(struct work_struct *reset_work)
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
-		if (ret == -ENODEV) {
-			vfio_ap_free_aqic_resources(q);
-			return;
-		}
-		if (ret != -EBUSY) {
-			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
-			    q->reset_status.response_code == AP_RESPONSE_STATE_CHANGE_IN_PROGRESS ||
-			    ret == -EAGAIN) {
+		} else {
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
-			} else {
-				if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID)
-					vfio_ap_free_aqic_resources(q);
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
 				return;
 			}
 		}
 
 		/*
-		 * The reset is still in progress or is being retried. Give up
-		 * if it has not completed within the maximum wait time.
+		 * If we haven't returned above, the reset is still in progress
+		 * or being retried. Check for timeout before continuing.
 		 */
 		if (elapsed >= AP_RESET_MAX_WAIT) {
 			report_apq_reset_check_timeout(q);
@@ -2387,6 +2447,7 @@ static void apq_reset_check(struct work_struct *reset_work)
 					      status.response_code,
 					      status.queue_empty,
 					      status.irq_enabled);
+
 	}
 }
 
-- 
2.53.0


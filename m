Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579058;
	b=D4ZtDVewUNAZIaoUwQRFqh7X9f5WuKsUxg50TxGw2rfVNj9fuAheZ/1PCp33sA2nFiem
	 7gUbUzCR0/aVxeF6sqJ5Y9Cq0eQWwitMFN02xiFBS1AWi+TzqQX13SRIjVShL1cKqVq/I
	 hIr8nOwp9rinPo/ZCfE2E6F49/bERIi6Cr3SXp/k8Oil/+mQEfegQyzl5J5DvJ3elJ/kb
	 v8QzOVdGDVzAzpEZyPPLXLiSkzT6ejpD/3VPlPxEBSU+yGMuqxNHvUb7uwBsb3WelVD8d
	 6pr7l4fX1fOfHyPrzGEPImMd7WhCSesRhq7Oiaw0FcyY7l3h3CIiJUiZOpR9HLsbYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3mBQR3H56py69xFQqqLLKse6hq6DDD/LCjZ90Ioj1w8=;
	b=VutYDbgOF69ZZ+TTVBwIB7/TOCybgPAwHUka5ksCydZYrZNWPumusz32TTlIvm2kQrQZ
	 IUF9C9/LDaAKwQD90qB6ozJDDAy4hjmd8DAl8eUSgbdRbHV4xc1pTb7FJ3VzXdeCAO+91
	 4UN0d3dLDwjuC/sq/YhsgARhUjfy2akyzyp5VNCTNtDiB1Q4KbYjX/8P71yeYMMZphCj/
	 MqBmc/2l+CAXL5p91F4mr43BSqjMzYgWS1l2wJRn52GMDBT0Zeg4kLdiY8ITvj3J46tzE
	 qvhQoZTiwUGE7M70gtFyvZUG95VGNx4wMsWcU2QRjZPzHWb/0v80lKIRFvi1I5wexbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=thaIqZqP;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14D606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA14D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=thaIqZqP
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE8pc1247900
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3mBQR3
	H56py69xFQqqLLKse6hq6DDD/LCjZ90Ioj1w8=; b=thaIqZqPIqljUO6BmCmSN6
	qcfEUuDtTrSmB2QerJbe4GMSEhhOeDI4/Lee+5dSGepMT7U7VgorneXiWLnkb0Cd
	W2nUVS1/ap5Caovs3tHAEDub3YUWf/+mWFts+Wl8EpuAGr1NMySHr7JXU66fdUoZ
	jOOLt63XiS2w6Inx2GE0de1nZXl3UE3BukVxQ4k9nGkF8DOrT+ImeQK6YIAh+gKI
	gA2IlR7zSUD36XCnbFZ4N1l5/JYyB0lTdKO33PFXNUspstibOwVCUnmL4R80P0Y5
	iN7KyFk+ma3jsNm1TVRGSlOinDO7kz85uUPrYWNlbmJa4jnV75bhB/f2HgD8Ih/g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntm1uc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5Fs12245061
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85cbn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAsq562652776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D85858059;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0748058057;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 10/20] s390/vfio-ap: free AQIC resources only if interrupts are confirmed disabled
Date: Fri, 13 Nov 2026 09:10:32 -0500
Message-ID: <20261113141049.3747719-11-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX4QPhYzZgi3wb
 mWy1fb/rRynXsIjK+LW6TpZpihCKMoC7gfL+EqrTzfixItCxpQh9weZZX9EClsjQ81+Gtk8Zb5Z
 6U3k+Mrac2JL0zfiwDsOwkBABiVK9VN7/JEz67AYsw0umqIFxPeIEGheF8Bl7hwofsHqpJ/3zsf
 HzCp/4HQhpuwnfTcpYgKl+CyRO8JNUv382eO4hZSW2KcIDt8TG7jQudLnfYgNOWJdABTdJvIZHI
 q44ltOV1/fucHPwo27zSzpOBP2tbgN6Jw+FGyvrPAgMGtXIUBxelcDIMQW7Elm5gYELxrEnKQxd
 BmD8LL305ECfnb2T/p+sWrj2SEP+CB7jccpHrZbBkdqBbsa8GNz/xGlBPlut6Vihil5uMddvWzM
 RII9TWtLOoKl9qbeN+gdZbLezPuZAQol2sT2chqP/SkEIxM3g+xIC+ZFeA52gjkULrMFzRjywmo
 OvjfrmxYTKq4GQo+vjw==
X-Proofpoint-ORIG-GUID: b6gmmVq4GrXozr7hGeEfSvi_YIA0wbsC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX81jSFa6Zgh1G
 oBkAYb1Q+pazZPLet/gG1hyr/1C9dU8tEV0jjy9dtF4pnOzox15l/sdOvBojQKr4OKqnuwL3KT2
 BXtLgqFBsG2oyEBb3+W7ICwifDMSUow=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af71a70 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QFoqGeYetYrswlWG7-MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: b6gmmVq4GrXozr7hGeEfSvi_YIA0wbsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_irq_disable() issues PQAP(AQIC) to disable interrupts,
polls PQAP(TAPQ) until the IR bit is clear, and then frees the
AQIC resources. The polling helper, vfio_ap_wait_for_irqclear(),
returns nothing, so a failure to confirm IR=0 was ignored and the
pinned NIB page and the registered guest ISC were freed anyway. If
interrupts are not actually disabled, hardware can still write to
the NIB. If the page were unpinned and returned to the allocator,
a subsequent wild DMA write to that physical address would corrupt
memory belonging to the new owner and could crash or compromise
the host kernel.

PQAP(AQIC) disable initiates an asynchronous process, so a
condition code 0 completion does not guarantee that the IR bit has
been cleared. Change vfio_ap_wait_for_irqclear() to return:
 * 0:          IR=0 confirmed; safe to free the AQIC resources
 * -ENODEV:    the queue is non-operational; safe to free
 * -ETIMEDOUT: IR=0 could not be confirmed within the polling
               window, or TAPQ returned the asynchronous
               association response code 0x35 or 0x36
 * -EIO:       TAPQ returned an unexpected response code

Free the AQIC resources in vfio_ap_irq_disable() only for the
first two. In the others they are intentionally retained, and if
the TAPQ status was NORMAL or BUSY, AP_RESPONSE_OTHERWISE_CHANGED
is returned to the guest so that it does not conclude that the
disable succeeded and reuse the NIB.

Also document in vfio_ap_mdev_remove_queue() why freeing the AQIC
resources without a ZAPQ is safe when the queue is no longer in
the host's AP configuration.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 172 +++++++++++++++++++++++++-----
 1 file changed, 144 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a618dceb31c8..97048d9fa2b0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -226,27 +226,48 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
- * @apqn: The AP Queue number
- *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
+ * vfio_ap_wait_for_irqclear - wait for the IR bit to clear after a disable
+ *
+ * @apqn:		the APQN of the AP queue
+ * @tapq_status:	used to return the TAPQ status to the caller
+ *
+ * Repeatedly polls the AP queue status via PQAP(TAPQ) every 20ms until the IR
+ * bit is clear, the queue becomes non-operational, or 6 retries are exhausted.
+ *
+ * Because PQAP(AQIC) disable initiates an asynchronous process, a
+ * condition-code 0 completion does not guarantee the IR bit has been cleared.
+ * The host must confirm IR=0 before unpinning the NIB page to avoid a wild
+ * DMA write to a freed page.
+ *
+ * Return:
+ * 0		if the IR bit is clear (i.e., interrupts are disabled).
+ *
+ * -ENODEV	if the PQAP-TAPQ response code indicates the queue is not available,
+ *		is deconfigured, or is checkstopped (i.e., not operational).
+ *
+ * -ETIMEDOUT	the function timed out before the IR bit was cleared, or TAPQ
+ *		returned AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE or
+ *		AP_RESPONSE_ASSOC_FAILED, which mean the instruction was not
+ *		executed and will continue to be returned for all subsequent
+ *		instructions except ZAPQ until the queue is reset. Since IR=0
+ *		cannot be confirmed, the NIB must be treated as a potential DMA
+ *		target and leaked rather than freed.
+ *
+ * -EIO		PQAP-TAPQ returned an invalid response code
  */
-static void vfio_ap_wait_for_irqclear(int apqn)
+static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_status)
 {
 	struct ap_queue_status status;
 	int retry = 5;
 
 	do {
 		status = ap_tapq(apqn, NULL);
+		memcpy(tapq_status, &status, sizeof(status));
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 			if (!status.irq_enabled)
-				return;
+				return 0;
 			fallthrough;
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -254,15 +275,34 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ENODEV;
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
+			/*
+			 * The TAPQ instruction was not executed. Executing TAPQ
+			 * again will result in the same error until the queue
+			 * is reset. We shouldn't, however, reset the queue in
+			 * this context, so log a warning and return -ETIMEDOUT
+			 * since that would happen anyway if we continued to
+			 * execute the TAPQ.
+			 */
+			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
+				  status.response_code, apqn);
+			return -ETIMEDOUT;
 		default:
 			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
 				  status.response_code, apqn);
-			return;
+			return -EIO;
 		}
 	} while (--retry);
 
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
+	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
+		  __func__, status.response_code,
+		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	return -ETIMEDOUT;
 }
 
 /**
@@ -340,36 +380,87 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 }
 
 /**
- * vfio_ap_irq_disable - disables and clears an ap_queue interrupt
- * @q: The vfio_ap_queue
+ * vfio_ap_irq_disable - disable interrupts for an AP queue
+ * @q: the vfio_ap_queue
+ *
+ * Issues PQAP(AQIC) to disable interrupts for the AP queue. On success
+ * (AP_RESPONSE_NORMAL or AP_RESPONSE_OTHERWISE_CHANGED), polls via
+ * vfio_ap_wait_for_irqclear() until the IR bit is confirmed clear before
+ * freeing the pinned NIB page and unregistering the guest ISC. This wait is
+ * necessary because AQIC disable is asynchronous: freeing the NIB before IR=0
+ * is confirmed risks a wild DMA write to a freed host page.
  *
- * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
- * with the AP interrupt handling.
+ * Retries up to 5 times (with 20ms sleep) if the queue is busy or a reset is
+ * in progress.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
+ * If the IR bit cannot be confirmed clear (timeout), the NIB page and guest
+ * ISC are intentionally leaked. If the page were unpinned and returned to the
+ * allocator, a subsequent hardware DMA write to that physical address would
+ * corrupt memory belonging to a new owner — a wild DMA write that could crash
+ * or compromise the host kernel.
  *
- * Returns if ap_aqic function failed with invalid, deconfigured or
- * checkstopped AP.
+ * If the queue is non-operational (deconfigured, checkstopped, not available),
+ * resources are freed immediately since the hardware can no longer write to
+ * the NIB.
  *
  * Return: &struct ap_queue_status
  */
 static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 {
 	union ap_qirq_ctrl aqic_gisa = { .value = 0 };
-	struct ap_queue_status status;
-	int retries = 5;
+	struct ap_queue_status status, tapq_status;
+	int retries = 5, ret;
 
 	do {
 		status = ap_aqic(q->apqn, aqic_gisa, 0);
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
-			goto end_free;
+			/*
+			 * AQIC disable was accepted (NORMAL), or the queue was
+			 * already disabled or a prior async request is still
+			 * completing (OTHERWISE_CHANGED).  In both cases, we must
+			 * wait until interrupt processing has been disabled
+			 * before proceeding.
+			 */
+			ret = vfio_ap_wait_for_irqclear(q->apqn, &tapq_status);
+			if (ret == 0 || ret == -ENODEV)
+				goto end_free;
+
+			if (ret == -EIO) {
+				/*
+				 * An unknown TAPQ response code was returned which
+				 * indicates a bug or some type of hardware I/O issue.
+				 * Since we don't know whether queue interrupts were
+				 * disabled or not, the AQIC resources must be leaked.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+				goto end_fail;
+			}
+
+			/* Timed out waiting to confirm interrupts are disabled */
+			if (tapq_status.response_code == AP_RESPONSE_NORMAL ||
+			    tapq_status.response_code == AP_RESPONSE_BUSY) {
+				/*
+				 * If AQIC returned NORMAL, the guest would incorrectly
+				 * interpret that as a successful disable and may free or
+				 * reuse the NIB while hardware can still write to it.
+				 * AP_RESPONSE_BUSY is not valid for PQAP-AQIC.
+				 *
+				 * Return OTHERWISE_CHANGED to signal to the guest that
+				 * the disable interrupts operation did not complete.
+				 */
+				memset(&status, 0, sizeof(status));
+				status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
+			} else {
+				/*
+				 * For all other TAPQ response codes,
+				 * return the TAPQ status directly since those
+				 * codes are also valid for AQIC.
+				 */
+				memcpy(&status, &tapq_status, sizeof(status));
+			}
+			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
 			msleep(20);
@@ -388,7 +479,25 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 
 	WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 		  status.response_code);
+
+end_fail:
+	/*
+	 * IR=0 could not be confirmed. The NIB page and guest ISC cannot be
+	 * freed: hardware may still write to the NIB, and unpinning the page
+	 * would allow it to be reallocated to a new owner. A subsequent
+	 * hardware DMA write to that physical address would corrupt the new
+	 * owner's memory - a wild DMA write that could crash or compromise
+	 * the host kernel. The resources are therefore intentionally leaked.
+	 */
+	return status;
 end_free:
+	/*
+	 * This label is reached because the queue was successfully disabled,
+	 * or because the queue is not operational or not available, in which case
+	 * interrupts can not be processed, so free the AQIC resources - the pinned NIB
+	 * page and the registered guest ISC - used to enable interrupts so they will
+	 * not be leaked.
+	 */
 	vfio_ap_free_aqic_resources(q);
 	return status;
 }
@@ -2773,6 +2882,13 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
 	} else {
+		/*
+		 * The queue is no longer in the host's AP configuration.
+		 * The hardware cannot DMA-write to the NIB, so it is safe
+		 * to free the AQIC resources directly without issuing a
+		 * ZAPQ. If the queue is not assigned to an mdev,
+		 * vfio_ap_free_aqic_resources() is a no-op.
+		 */
 		vfio_ap_free_aqic_resources(q);
 	}
 
-- 
2.53.0


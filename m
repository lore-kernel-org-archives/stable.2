Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579058;
	b=vW0nU26t4onzZx86hd/8z8CrgwM5+oAmBPNbCMkuMiiB7mS8zyfbBPmbE87qm2w/lWMs
	 fJN7I+UvpEDTwy/+yoNJakenGq361tAEgTs+QYBeJYdM4WFqr5U+p6pS3+YzbvQGF1b4k
	 WrMG+0Oa68RMrXWYfwth+TiRvi4wdOGxrVHnkW5X+1t3WODXftgHYUYcfvBbVexx09KQV
	 Vf++cAvq73nEtDfwfnaKwE/80tdGQWmhPMC2Hl4gATn9gHXrPPYXI7Elo8J9Wraet3gfZ
	 6vqrA29seQaSryjx4FoTXM92Qv6KNBc4oCYhVnCvt4SNpc+Y394LvuuJPwKCdHwuaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qId2N0KCDoZzeaZ0WP4PoNkQxQEANJU0yudArtiK1AQ=;
	b=m+dKqJZ/XDGYQC5cw9GDKcdgJSr9/4bPo3+zt68UVFgsEJjgfjDSVsfhCpc/NksxvxA1
	 qWlsHunXcvA2QqjMF8hhAWXXKvtXyL+MeLV+aoUE4mjTseYtIdnsaYJVELbF6BwSqoH1t
	 Vp3QXXltL5C1FcEyoQIHCpZJk/GPwnW39Ibv4DPhTFt4IInSsy22l9lIoboEsRJBr2Yf5
	 MCSAyMse7zyRguGBUJHCSfWUvt+YMpVje0rMszZ0pXsL63/Y3AHxm43U8bM34bA3kcyMf
	 hI2O8JOzwsZUjOEWiYT73FfFse0TjgeBlwW6fZAd6Bc9gf90+kulKkJEE99JiICV0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g6xt3HuP;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11C606A895
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C11C606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g6xt3HuP
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE8LH3086489
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qId2N0
	KCDoZzeaZ0WP4PoNkQxQEANJU0yudArtiK1AQ=; b=g6xt3HuPFwABb97tCKjdBN
	YEgtooKKHlsYhSLaC/lQoWoTcGvDrdY7soa/ZClM2m9WNJNgW+lvzUppvR7+46n/
	VsbCM9ZjHtdqYgudzsctCVqJKUPCfUBShO2+JqM2TlAxDeXc2aFq1e8h4MJHmU7Z
	9yqtWCPAg7vP1FjE+RssHVImStzpfiwxad1UCXEX0CJ1BCEMObl/S24y4VvlqGI7
	seAef7fWayz/NAxIKXknieAuuRmQ00MtezH8sHQYnUhk7p5S09XckKIv7w26FWcO
	iPDOgdUoi51PlWn06YIZ79Xuy1OezLqp4EaXwGZjN3FLqRqVe2Z4fE4EDEQt5Knw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6m0ve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5Xm71149560
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8hg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAtBB2490970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26EE258059;
	Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6E9A58061;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 12/20] s390/vfio-ap: retain AQIC resources if PQAP(AQIC) disable is rejected
Date: Fri, 13 Nov 2026 09:10:34 -0500
Message-ID: <20261113141049.3747719-13-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lioDPKbkIlbcHRVsUeCj5J1zCS0VGM6e
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af71a71 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZYDmb5FrgpmMnPCT5yIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lioDPKbkIlbcHRVsUeCj5J1zCS0VGM6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX+ogFRhvhwrBi
 c4gSUQw1hH6DwF3U/oA8ps6RU4qZkuH2hEH6fQebTmF36sP+Rr6o5pWowpoe2A7UNBGhjIRVPHn
 IU4NhgUhEfmprzSd+yJYjr2cZAzQag1o5frZCSEvz7Wnkzh9BeF24H4OoiaEysa5z2mtMOoGawP
 2MVYOd1fBGrLgiaEjvfVMb6carEEZqsA5GCyQc+PNFKZJxtHbxR7i2xBl0P9A+volog25TdeXNV
 SQN8tsHQc1N3VVtUpFmcfDIFEYq1eq0dWLrc6FMnpA7OqD4svXDmEBpFcQqGp9I4cxSTN7+IuCI
 qLaftFO3OEwdvNqir5dmWjK4Sa+VWVVQQZZAB+CTX+dDZBYQMSL522pE329XZzYZ//MZamb2wk9
 WMlGEZttDsnW03e2xBNdkjP+d+KFYllZyqpFwa2PnmIziCPntTo5RkP4ZHBzq2OLzSRrKnEnlrU
 RWE/ZvH251icn2LusRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXwZqN9PoMbnHG
 t9hYSJwz0zqq4bAWgW0LWOHvKDfm4n8f5BxIipnZ0AGaKhzv1bpuN6aMOzQKzjCujDtDb7Oq6cw
 CFV8IteMUdJ4SZBCKw8M+LXWCVa3NOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_irq_disable() treated every response code from PQAP(AQIC)
that it did not handle explicitly as an indication that the queue
is not operational, and freed the AQIC resources. The valid
response codes for PQAP(AQIC) include AP_RESPONSE_INVALID_GISA
(08), AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE (35) and
AP_RESPONSE_ASSOC_FAILED (36). They mean the disable was not
executed and the hardware still holds the NIB address, so freeing
the pinned NIB page may allow hardware to write to memory that has
been returned to the allocator.

Retain the AQIC resources for those response codes, for
AP_RESPONSE_INVALID_ADDRESS and for any unrecognized response
code. Responses that mean the queue is not operational (not
available, deconfigured, checkstopped) still free the resources,
since the hardware can no longer write to the NIB.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index dec69f3ffb8b..892ea938d14b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -469,12 +469,23 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		case AP_RESPONSE_Q_NOT_AVAIL:
 		case AP_RESPONSE_DECONFIGURED:
 		case AP_RESPONSE_CHECKSTOPPED:
+			/* AP not operational; no further interrupts possible */
+			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
+				  status.response_code);
+			goto end_free;
 		case AP_RESPONSE_INVALID_ADDRESS:
+		case AP_RESPONSE_INVALID_GISA:
+		case AP_RESPONSE_ASSOC_SECRET_NOT_UNIQUE:
+		case AP_RESPONSE_ASSOC_FAILED:
 		default:
-			/* All cases in default means AP not operational */
+			/*
+			 * The AQIC disable was rejected; IRQ is still enabled
+			 * and the hardware still holds the NIB address. Do not
+			 * free resources.
+			 */
 			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
 				  status.response_code);
-			goto end_free;
+			goto end_fail;
 		}
 	} while (retries--);
 
@@ -483,14 +494,17 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 
 end_fail:
 	/*
-	 * IR=0 could not be confirmed. The NIB page and guest ISC cannot be
-	 * freed: hardware may still write to the NIB, and unpinning the page
-	 * would allow it to be reallocated to a new owner. A subsequent
-	 * hardware DMA write to that physical address would corrupt the new
-	 * owner's memory - a wild DMA write that could crash or compromise
-	 * the host kernel. The resources are therefore intentionally leaked.
+	 * We are here either because the AQIC instruction failed to disable
+	 * interrupts, or because IR=0 could not be confirmed. In either case
+	 * the NIB page and guest ISC cannot be freed: hardware may still write
+	 * to the NIB, and unpinning the page would allow it to be reallocated
+	 * to a new owner. A subsequent hardware DMA write to that physical
+	 * address would corrupt the new owner's memory — a wild DMA write that
+	 * could crash or compromise the host kernel. The resources are
+	 * therefore intentionally leaked.
 	 */
 	return status;
+
 end_free:
 	/*
 	 * This label is reached because the queue was successfully disabled,
-- 
2.53.0


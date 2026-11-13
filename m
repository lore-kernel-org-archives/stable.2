Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579055;
	b=v8PtqdK/gOq58X+WUELjZNWB7IEyTiqx/Eg3T2lri/DfXPB2pa0EaFOFszLT7RIPeWt4
	 enZdsxfwwZ8i4nm3I/DvVvVlhzGTbJO4do6zzk8yratyiK8hMdDbM4ln4gpE6R2dZADxy
	 nepdioupFiMVmXfnCD494zbV08cBP+7/4GfzDPJ22jJsiXGSZ8fUINUZADLIWGQXCP9P6
	 MJ4EnjMN/o99iFDUtlPALqmlDEa9T9BZyXA/kQVtF8QIdt9ySrQt4ATpFhZ0xFC37CFZt
	 Tcg1Lp/QoMa1bM9ucW7hVQeX8hLj0G//YR0+vrucvOAz3R6Au3O7laSED88YwKC/6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XKJT4ax0DnVObLFWQkK8OD0UQHTWqjHchI8KEFQfOHs=;
	b=W1vf8kzMDZU2EdM/H6oYhoVm0IbHXlmzHlFY721TbGS30hQ0E0sz+CtzkyZvTRaYdrM1
	 vvyNQlIvwRoroW91dyGi0pI6Kb+DWIoWv0/ew6kXattOPKUrUHUVhT8FjtrgKNOZ8xABO
	 z3x6wSu0QrEAtDANUuRANGfYzUHIlFVeF8FEYSC4bVgzbwFSiC22GeJLBlHtthBQ6rb+U
	 Qsl/Z/wTq2uzuwT/CGN0NUpVJXFJiVkci0wCnpe6nro+JMhwasfPBt5KvBJKESl3ysp/W
	 EsoSPcjOZm7BJr9kGDFpdW6JZN36RFJfk8OdgpS4l06l4iupuJrOw6kNyll9GzqnRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dg4Cy1QT;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2555606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2555606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dg4Cy1QT
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE6YV3085814
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XKJT4a
	x0DnVObLFWQkK8OD0UQHTWqjHchI8KEFQfOHs=; b=Dg4Cy1QTBRc5kpEyxJUoBF
	eIyUt9U0hDBVB964n8ayP6I8dtTwP3PAoEegSz06zke4Yo0JaXHKiGWr8mEy0Y3q
	l1TWTyAM0eLyob1hBRC1n15QYHLKgZ2cn8q19EQYNbySzQ70CyD/J2guUwie9wuX
	J4yFcBGed7js2+fPIwSl/hBsN3gSCexY5akxPcwHiINDMWNDqVdZGnagFJ73P9wk
	HDZam8H6BJ2iuJVV8199NkpfBVu+1Zm+xNzK3je5+pRCONtWJ0ACAZY44DXpIfZ6
	V+UXWxHrGO4vvI+GPW5BYafi4k0HAjRApI4+Tuw8vr+XQsUEOujCLRMLR6Oyo4SQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6m0v1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5I2J2213435
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEApIw32965250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8671A58058;
	Fri, 13 Nov 2026 14:10:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4263858057;
	Fri, 13 Nov 2026 14:10:51 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 03/20] s390/vfio-ap: fix leaks when PQAP(AQIC) enable is not accepted
Date: Fri, 13 Nov 2026 09:10:25 -0500
Message-ID: <20261113141049.3747719-4-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: P1mBren_kNIAX6xvu6j48KYkUouzdcXu
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af71a6d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1-dj_AUAaWMon3Pp0yMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P1mBren_kNIAX6xvu6j48KYkUouzdcXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX0HAy6tGfSxoK
 ZZB1+gjGw7WXpe6Ietr/ejaKafB+j9RmHMIrBo841W/R0O1Yym18Gupuo+Pg7W+Hs0/uR63OBfZ
 9yT7LlIIGwI+ghJXFEGyt4+nZXe6nhHOkWf8kyGyjVyzQGHnjf5w/+zorCj0ucx69+riHEogGSz
 NpAsAdjuCYo1vfCJVVXkoy1vyy9ruvhAWR55tJnlLke4bW9/4FEj1uSSPeRnzlJrjjF7a6CVHcm
 xAIVlAJ0ripkL6iLzJdEME47NHCErWDvI7GyefR1J2GQ0hmyi7p5nbB27IwrNjo1NIalUIit2+o
 8bH0019ZX/ew5GT1OtIZ/Q7UunrIBg/KEkKTVNObMGWa1uavmnRxanUUyFG/mQVm33Urjc0blkZ
 0wzJZ+M3mnWa04APPgdczavnknf6jc3OOwi2GIIp9es9GvID1XAzhEzDcK+1hrOwzOM8CsjT7WC
 Q7N/Q7QOgiAbS3Jy9Fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXwnPX2I55eRHs
 r//Xtcs6okvNvYaJX5UuYhP+R2sioxT5byRfo6xxGzPAy9lgQKCXYSZoCmvodnOwLRiTCH/M37K
 Ip6LJfylMQIZpSQMB2Fky5px8oUe6MU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_irq_enable() pins the guest's NIB page and registers the
guest ISC before it executes PQAP(AQIC) to enable interrupts.
If the instruction does not return AP_RESPONSE_NORMAL, the newly
acquired resources must be released and the previously saved
resources, which hardware is still using, must be left intact.

The AP_RESPONSE_OTHERWISE_CHANGED case does that. Any other
response code, however, ended up in a default case that only
logged a message and called vfio_ap_irq_disable(). That leaked the
newly pinned NIB page and the newly registered ISC, which can
cause memory exhaustion and depletion of KVM interrupt subclass
registrations over time. It also disabled interrupts that were
enabled by an earlier, successful PQAP(AQIC), and freed the
resources hardware was still using for them.

Handle all response codes other than AP_RESPONSE_NORMAL the same
way: release the newly pinned page and the newly registered ISC and
leave the saved resources intact.

AP_RESPONSE_OTHERWISE_CHANGED is not a failure of the instruction,
so it is no longer reported by the "PQAP(AQIC) failed" debug
feature message.

The kernel-doc and comments are updated to describe how the
resources are managed.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e6ffdd75af8a..b78c164215a4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -401,22 +401,29 @@ static int ensure_nib_shared(unsigned long addr)
 }
 
 /**
- * vfio_ap_irq_enable - Enable Interruption for a APQN
+ * vfio_ap_irq_enable - enable interrupts for an AP queue on behalf of a guest
  *
- * @q:	 the vfio_ap_queue holding AQIC parameters
+ * @q:	 the vfio_ap_queue for which interrupts are to be enabled
  * @isc: the guest ISC to register with the GIB interface
- * @vcpu: the vcpu object containing the registers specifying the parameters
- *	  passed to the PQAP(AQIC) instruction.
+ * @vcpu: the vcpu whose registers contain the PQAP(AQIC) parameters
  *
- * Pin the NIB saved in *q
- * Register the guest ISC to GIB interface and retrieve the
- * host ISC to issue the host side PQAP/AQIC
+ * Pins the guest NIB page, registers the guest ISC with the GIB to obtain a
+ * host ISC, and reissues PQAP(AQIC) with the translated host-absolute NIB
+ * address and host ISC on behalf of the guest.
  *
- * status.response_code may be set to AP_RESPONSE_INVALID_ADDRESS in case the
- * vfio_pin_pages or kvm_s390_gisc_register failed.
+ * The condition code and AP-queue status word returned by PQAP(AQIC) are
+ * reflected back to the guest as-is. IRQ state verification (polling until
+ * IR=1) is the responsibility of the guest AP bus, not the host.
  *
- * Otherwise return the ap_queue_status returned by the ap_aqic(),
- * all retry handling will be done by the guest.
+ * Resource management is based solely on whether hardware accepted the new NIB:
+ * - AP_RESPONSE_NORMAL (CC=0): hardware accepted the new NIB; the old pinned
+ *   NIB page and registered guest ISC are freed and the new ones saved.
+ * - All other responses: hardware did not accept the new NIB; the newly pinned
+ *   page and registered ISC are freed and the previously saved resources are
+ *   left intact.
+ *
+ * AP_RESPONSE_INVALID_ADDRESS is returned if vfio_pin_pages() or
+ * kvm_s390_gisc_register() fails before the AQIC instruction is issued.
  *
  * Return: &struct ap_queue_status
  */
@@ -489,27 +496,46 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
-		/* See if we did clear older IRQ configuration */
+		/*
+		 * Hardware accepted the new NIB address (CC=0). The old NIB and
+		 * guest ISC are no longer used by hardware and can be freed.
+		 * The new resources are saved for tracking and future teardown.
+		 *
+		 * IRQ state verification (polling until IR=1) is the
+		 * responsibility of the guest AP bus, not the host. The
+		 * condition code and status word are reflected back to the
+		 * guest to respond to the PQAP-AQIC instruction.
+		 */
 		vfio_ap_free_aqic_resources(q);
 		q->saved_iova = nib;
 		q->saved_isc = isc;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
-		/* We could not modify IRQ settings: clear new configuration */
+		/*
+		 * Interrupts are already enabled or a prior async request is still
+		 * completing. Either way, the hardware's current NIB is the one
+		 * saved in q->saved_iova/saved_isc — not the newly prepared resources.
+		 * Release the newly pinned page and registered ISC;
+		 * leave them intact.
+		 */
+		fallthrough;
+	default:
+		/*
+		 * Hardware did not accept the new NIB (CC=3 or error). The
+		 * previously saved NIB and guest ISC remain active and must
+		 * not be freed. Release the newly pinned page and registered
+		 * ISC that were prepared for this (rejected) request.
+		 */
 		ret = kvm_s390_gisc_unregister(kvm, isc);
 		if (ret)
 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
 					 __func__, ret, isc, q->apqn);
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
-	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
-		break;
 	}
 
-	if (status.response_code != AP_RESPONSE_NORMAL) {
+	if (status.response_code != AP_RESPONSE_NORMAL &&
+	    status.response_code != AP_RESPONSE_OTHERWISE_CHANGED) {
 		VFIO_AP_DBF_WARN("%s: PQAP(AQIC) failed with status=%#02x: "
 				 "zone=%#x, ir=%#x, gisc=%#x, f=%#x,"
 				 "gisa=%#x, isc=%#x, apqn=%#04x\n",
-- 
2.53.0


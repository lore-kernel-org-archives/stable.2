Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579060;
	b=yOXCT+ac9/FQpyvLhpFow6+4VdZUE9n3eUrfGknzjb46OHOWJSPETpXHDL0pMNU5aAaz
	 iY3YFcM8jCjeXLD5gu4tefElNV6RKwq3lN74yZIM0hDUtZAFy8lqHo+LDmRxpcjbkLz+i
	 zqLE5PGaHQ6+u8AJwSAIHP9vuOaE23KSd3LP0t0eGTJsqgQN+aDwGX8mMAKd4TZMlGQZC
	 NFSp7YtzjJcRAb3KsrcTm/q4Qp8zv3T1XI/HwTxEk1RCbRn5rslRiscViehrNCKC0/emI
	 WHKFu++ZFvVYlvVe6weMneCJNLMxPYNAe4BIrH1iicKHyOBd5zK7WifKgqqgQ7TVjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579060;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=D1q2FVNHkRyn+gvpAi5+vMFQJQuGmuK9U/NMb9MlrVg=;
	b=UjvADJUTmlik/p8f2OVC3SuGAstmdTmkdu6oHv6H28sfpP560DBrIs/PBe7a06bJgewS
	 TClQbVCQsgWNBJbAa0/e+lc7udi8sC9Khau31nebFnRphTzWWfH3+bzs2Mirsp/mXBwEP
	 dp4CEJ9hq351tpnKgbnoI7dPyLZ1EeD8lB8aRrxRafXZAISADT8reNyPPasRQQFGuayvX
	 gZGpK0uvWOseiZBGHxGsPr+Ws7/q9R8kuBP9Ts5nqTa9W6GqJWyFKSJwv0Cj79IU6UOdo
	 ThkqW8nbOWCglT5SHy9zxQfXs9VKle2sEOVen8hROCJnfF0cBRv/qEESIutP+CUywRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CZKDlkUz;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F479606A89A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F479606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CZKDlkUz
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE7dT2889032
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D1q2FVNHkRyn+gvpA
	i5+vMFQJQuGmuK9U/NMb9MlrVg=; b=CZKDlkUzHm1vWjKTdMz8hgNWhfluG4qtT
	APDaOMXEZsX8B0NvBf53muS8JipG3gyXMwRI9dBT23jTfGVCHJneQp/Ka6qZjleD
	jfXekFuZ6TSr7HAnKrWPBQm7ma4rAyBrKzIsRYkHUgKQ8mVYjAsKNgSJc5wuhQXi
	rcqipF5ajuq273nAu6Jji/GtIKBMSoxmmon9mOS3GzMyrXH0QLpm16ZByZSnnY/t
	LhFbUe1t/EQqh56T8uX7SbyEommtnxowJdQChKOpC5094tbsu29Og1CFXHIj539T
	X9qu4Hy2bnXU9UJv67qJn6dr0Dh3ac39u/KI8nszWFh60hQfCXhFA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7bv6c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5ZN61149622
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8hgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAvMW16056880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D7E58058;
	Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E330B58057;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 17/20] s390/vfio-ap: reset a queue when it is probed for an assigned mdev
Date: Fri, 13 Nov 2026 09:10:39 -0500
Message-ID: <20261113141049.3747719-18-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX1O4Slb9dTHho
 NHUoBgsF3/1IpQQjdOOkopcPgEIA4LCfUa1u7K0QYb38Z7kI7VDJMA5g5+cBwkMFTANrs/ajIDC
 XZZsztp4460SimL4im/A7y+ZkaWX2W4=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af71a72 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KGnN5MYeDhAF5gAjyRQA:9
X-Proofpoint-ORIG-GUID: 30HXGCnNnfel2-AMp1k1IgUBQCcdGDkX
X-Proofpoint-GUID: 30HXGCnNnfel2-AMp1k1IgUBQCcdGDkX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX7VEXHXYqn7Ib
 Y9BWFmc5zuEL8I+IOxXuKFcpQdXs4O8nNK0U5SE7EEUmJb5ylzUymoIkBKoOOH8oAJQsdJxDF8l
 k3YQ5UbMPlfHNJjk7toeW2TCfxNGDGz/ZCddeIrMBIUu3pDin3nwRRHatL0/1/b8lKM/NVWqDu3
 1M/kxQ9jsDvwE6EIXV/bTQ4oZ48FRLfJCXvvTnHgZoK+XbL226xLpayGnpVnU6VophW3Jvqse6B
 Z58Xiue2KSEZrC1ozqeyVAzjWTOxV9P38h+nL0/PPOCwubGGS92yRyOMgeLKFUJUhnfKbW6MFnT
 aHUZ9PjM9I/pByIZVZCtBfTm4tyeb26poIS9+gJWElYClLFi7mVJd+T4s0BTOSPWox4alrR6niU
 BKg8nQA+qA00GQW6/AV8JJwFBCBf79yEGQI28CBBs3zascmmL2ORRqESTsD/7jbdlF04CVgxAXt
 cfn/VkfpJNZmTS4woWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130054

When a queue is probed and its APQN is already assigned to a
matrix mdev, nothing guarantees that the queue has been reset
before it can be admitted to a guest. The new queue object starts
with a zeroed reset_status, which _queue_passable() reads as
AP_RESPONSE_NORMAL; a queue that this driver never reset therefore
looks as if its zeroization had been confirmed.

Reset the queue in vfio_ap_mdev_probe_queue() and wait for the
reset to complete with flush_work() before the queue can be
added to a guest's AP configuration, so that _queue_passable()
sees the status of a completed reset.

The reset is done while the update locks are held, which adds at
least AP_RESET_INTERVAL (20 ms) of lock-hold time per probed
queue, since apq_reset_check() sleeps before its first TAPQ. In
theory this is O(N) serialized under the global mdevs_lock; in
practice, AP hardware constraints and typical deployment sizes
bound the number of queues allocated for guest use in a single
LPAR to a modest number.

Deferring the reset until the locks are dropped is not safe:
apq_reset_check() accesses q->reset_status and q->aqic_resources
without holding any lock, and vfio_ap_mdev_remove_queue() can run
concurrently and free the queue, leaving the worker with a dangling
pointer. Calling flush_work() inside the lock-held section ensures
the worker has finished before the locks are dropped.

The fundamental remedy would be to replace the global mdevs_lock
with a per-mdev lock, scoping the blocking to the single mdev whose
queue is being probed and allowing resets across different mdevs to
proceed in parallel. That is a non-trivial redesign of the locking
architecture and is deferred to a separate effort.

Fixes: 260f3ea14138 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 86eb48df27f1..19638fea0ed3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2995,6 +2995,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
 
 		/*
 		 * If we're in the process of handling the adding of adapters or
-- 
2.53.0


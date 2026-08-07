Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB6327204
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127903; cv=none; b=t4gosyQVhbZ6tPfS9Rtkg3Znznse1oS+lKnK9pyQO/1FO7arPaBzoxPqRZ44pQSFEPXw2fGK7oYtG0P+5Pl4l0mmn+kdTrBb7Bmea+UIT+9BZP6X3SkSU40Q6VuJ9iC93Qce7ZqmozQWYHlSaotclxCA2/jx+NdUdAt+SBI8ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127903; c=relaxed/simple;
	bh=J1rx6b2/HsGD8Mil2pcZ06tE4mIRTYdsBR03JLTnrIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxxwLghhOBKNdi18E9c4csI3uRnu34vL01WD37vnOYMLWX+HkQux4wgyF/0+AHuaVoc1ZHKu/1V1hCx3UrqeXe8p+t1eWIDPtvWBajN0ZurZBCMMWJ9MZg/W9Wpsp7hSNaDTBkd6Rkjh4MexCh8ikZ8eK4yn3sqfR5jIEyJSSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RMY34cdX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RMY34cdX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlnHa2078529;
	Fri, 7 Aug 2026 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z+YqWTvHbxDdYTnkr
	k/nH7TwxPLL/74BI8uK9GjX4DE=; b=RMY34cdXnbTN4XogrWDc0xvCaStakSDfx
	Pf7xlm4K3IPH5wdV9vzyxR4hKhydJIe6YW0mFgw6frTZCW00rnyjmFlhTu0bf/6T
	hVixfiAVNIQyhJhX76cibAOqQccOA4HCwwTufr1p0SWCxeRYFTaU0AefvIIUGRuA
	ihtMU97B8vyA0zIUI/ipRL4FwWoNQaU0eWw1QzW3/+8nRkEJ0/uG//PnS0e1/UDM
	QoVVOCS99RyFTSXg0p9JlpphzLV4mJgOXEA4nheG4m7zNR+6nuynfrewmraY0Bcg
	iGxydspSt7oEqqVtuIR5z7r+X/2gpubtmJpYGWG/k3/yzG5ecFcLQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00d6dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677IQFX6001857;
	Fri, 7 Aug 2026 18:38:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgrqa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677IcGoV66847182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 18:38:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 509BD58054;
	Fri,  7 Aug 2026 18:38:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79BB058045;
	Fri,  7 Aug 2026 18:38:15 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 18:38:15 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 2/3] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Fri,  7 Aug 2026 11:38:12 -0700
Message-ID: <20260807183814.3035-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807183814.3035-1-alifm@linux.ibm.com>
References: <20260807183814.3035-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX5JDMlnXBYd1x
 HSO+45LDOBdJqmBE8QRcMs/ws+MXqJ7k6tF0+xuHFRO0Hc1oN7PZF61j2doDEA5TghcafBdBDTI
 yO/QNjz16cLRcGpE7ccnH4e9D6R7NTY=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a76261a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-ORIG-GUID: IJFlquzs6H72gv3kt4JW7SIcglhC-WMF
X-Proofpoint-GUID: IJFlquzs6H72gv3kt4JW7SIcglhC-WMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX2eGG5v/syNvq
 8UJ9rJvdo0TG8bGtwsdDD3rNPVPX5dUBMEJnXCy+ePQ41AoSY0Vwu76Zs1psRpYfe5rnqJLOevI
 rfEafi359fPExDtu7/BmQo27hzLPpH49lQCZDDAJzN4aFsTviQNkD/keWIiOW3MbCcpH+eHh89E
 t6oTXigpvp/ZhPUfDKsMNcjOODAB6tzHY1rIOCcYgPqvG7KEJwrQWvQ2Zz3p+Lu8GRZLlZmfADr
 +2YGuKMfPivdALHtn4ocmsbDkIbjp0d2YSPqwQDQ+RQpA9hjlSSlNfqn1C1mShTowGbKlnhgIMl
 AAgQmW40+/0mIkjYicmKroZKC/wyhVIcYltWjtGGt2um+b202STUZgsLK6mHQ8IyNsXatGdjTN9
 tfOFwk/9m9c2ER4lzCcmFgh8U04V8LzoVE6V5bWv4RJTsIC11dSYqroRubRgYoJKL+aMlm6BmyN
 mu2YS2Q+6H4I4Y6DuvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit f86842e4d6c482300f4567f492d512c9ccf5bc4f)
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 73989825b49a..7ee1f892c7fd 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -297,14 +297,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -348,6 +351,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0


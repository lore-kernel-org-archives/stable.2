Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8193655E6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567251; cv=none; b=ruqDw+Ta37nOx2KnGVbNdb4xNh//IIBKsgh5gxmxEDWKHf4iaSr5atwcPQNYl9ajmlid+AXbTxZ8facGCVfqj1lRmlqJzkILtyP0yhrzjiRrYtD6BGPCZy9uzpy/MIvcLvkuXsd4zGl3R5SBiA2e9CZPtVgHeuPc9moX3N5iv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567251; c=relaxed/simple;
	bh=9/9SxQuDFlSuyk3oBCBhkhP6UsGmnQqNny+UZK2ZPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8M6z1fkfsGm9ZZw4GCtlLezc8yZ2VZ1oL4ssh74LXKqf5vzmygwx084luBhKbDJJKX8Grx0ol5VXb18E/5F3IU/I6N5uh+UYLxPGAp1gC/A8kinK1X67bys/gs3TuTjr9GNeemPgNPVISIsihs4/zBcomHQlpRyC19Ky99oLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jLilRoPT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jLilRoPT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2pvn3381528;
	Wed, 12 Aug 2026 20:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9nGw4e3mKRTU4aFgA
	GFHNjx41F91fAu2bsidnXeZSfY=; b=jLilRoPTaLKTQ3o3B7G277fhO/MtSzkYW
	f2IeBKl8MfnouMI3lYZSOLbu6Usj/HBvNDUXR0KvXWLXDEe+eEEZLVT23C3paERD
	BNgNFWE+h66vmIn86vuqVdqCR6I1exBIBOOAcqUgzPQbYchSVx/r2SVilf+ZPK9w
	cr/jFE2Qf3lPoXkhmWoxGtH95efUcwcSG2uNfxtwO63fF+RLzlhFRi7RkZl4/TZc
	khJoc+/Md39eILLj2k8mREL/j6ciaWzxH8JDGlSGEaNFfdtz4U6FAhMolWwgiOUc
	fv8PUZnLIF56V6huA85bJR5O736Lta/O2dOA5yxs6Abv94WWONJwA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23w4ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKQGWp012884;
	Wed, 12 Aug 2026 20:40:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gftuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKejjq32768744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:40:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBCDF58059;
	Wed, 12 Aug 2026 20:40:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D1B58055;
	Wed, 12 Aug 2026 20:40:45 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:40:45 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 2/4] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Wed, 12 Aug 2026 13:40:41 -0700
Message-ID: <20260812204043.2536-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204043.2536-1-alifm@linux.ibm.com>
References: <20260812204043.2536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7cda4f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eJt398lxKxdzswCBiD4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX7RwNrrXfAEXx
 MQC3BfdNwRphA5K+YaB+9uq51URWR+guHPM1xinamznOjfmLbpsu715oF4lbplXl8YdKUpaBgf4
 IF4gefhXDIy0vLfScZiNbrj5l8RXhU3s84qmoTOelXSkADxAS70uCN6IbW0auHho0ZlfKTilPzm
 rvnJ6ExSp0MmWrRkj5iRZyfjkG1XmJja2ZnwJQd/ruW14Asb/8OUQvGSPw+SFloUPIt0XRQJWZi
 GKkMH7IsOYZS8WMAklUSQdk8Cpvt5CfNluIj9vHUVs3cME4WkLKdgRsW9sm1TD+6EoHwxBM71PP
 JeuQTYZUgifhroOlIiHbCCJLTtI/IhhppeSC/Mm9vVvxMlWK487RKjC4S/dDqZVyEZc2YPfWFSk
 a0++RB52QoSb3bmJAHmKEvtZWkuayoovOO+vcx0i8+jYoB9hc+OnS8cqEfZ+t5GmDieYsldAgoU
 clrpLlmrEo7jPx03Bhg==
X-Proofpoint-ORIG-GUID: 7U2pd_TW3NI3Di_cMS6gRYS9YdCm4tyc
X-Proofpoint-GUID: 7U2pd_TW3NI3Di_cMS6gRYS9YdCm4tyc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfXzSOITFPT4RPr
 wQf6h6aIC2tjfJ67JRJEG2TpXcpfzIiqNCHmwNA4/5f2l2Fc8NhbBm6G/Jqq7DlIV5nabHxxB/P
 VBDqRcqCYPKRyC6t/2pBood9oYRc7Ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

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
[alifm@linux.ibm.com: Resolve merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index f887e11b0f1e..a20fa27fa030 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -315,14 +315,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
@@ -374,6 +377,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
 	zdev->aisb = 0;
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0


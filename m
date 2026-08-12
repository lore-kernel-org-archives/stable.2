Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF13FF1B4
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572811; cv=none; b=uEofdWthwZRH79QsSkaAenHeYGiMEUnZ74NvmEQ2897yBOTvyceEtX8vNptM1kX5+IRlbf1U48XXU9YXJF4TZGQ0ksjIvyxwxH13o/Sp4pVywqMoCM+nEuQqqmtiXRzPshvfksy0xb92waaKEt7CXq5cr3qb7QkWIrjw78ZKN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572811; c=relaxed/simple;
	bh=MBxS2IVembf5yeCOWlwLPB8SD01mMwosPCz4H1EYs58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpRwTtVaYRLBzKzMQtMWw8CATKukyNq9oXYK/4/IUhB4V/1lSBT4C19gOqeeLhrNgyYTZnhZw7uKYoISAH0zEdWmn7Op8uL+0KTl/v0R0hJl3ja16KUCCUFi+hTd5qaIp2gBNOtJHHpefWk3YtPBBxiTurM18LPmhmGl002eVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z02X36Nr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z02X36Nr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2g5Z292013;
	Wed, 12 Aug 2026 22:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=He3u83V56tonXFRtA
	9+vdgnwoetc8XOdQEmbwbmGnX4=; b=Z02X36Nr1fJv1i23/ia3sBM0eWZpVjpYv
	otOuAG7i+EJUo4OLIjYvGmwpdtGM6K5MTWL9N3IvswjSYzb+O91/WX+HLsnN0tGP
	Wcl3H6dk4hx3p2RGchi+Cd56XWd8MF0Beows7XlBtNwnjiquoYZXfOgm5t6RcIcW
	k9VeEBbr5DWQhQPnndigiYOtKMdkULChMGrWDKKRikmVbki0NtYVIaRw7ElZpmY+
	h8w8Jrw8GmJ4v9Go2ayObR4jjqVarT2wgYhSqaj3SK/l7yHXA2tDssriZrF+u2ER
	AFOYbr6zJyrtGNl8ZWBathd/qADd7iTeproFN6AdzV83W1HwJ0UZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9w2u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBGec004094;
	Wed, 12 Aug 2026 22:13:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h88k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDPd728705318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73D4C5805A;
	Wed, 12 Aug 2026 22:13:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9C7D5803F;
	Wed, 12 Aug 2026 22:13:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:24 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 2/8] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Wed, 12 Aug 2026 15:13:17 -0700
Message-ID: <20260812221323.3645-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812221323.3645-1-alifm@linux.ibm.com>
References: <20260812221323.3645-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX8jYD1A8FIDuU
 KzTR6CITtFAn+c+1joU1nbvFCILkinujX47I9jfKjH5vtyBHmgB5/bLlL5StxZ3fqoFbwaY1VB+
 y4ZCB3ywwMyhD73qs43M5Z2esLKRSUiM+OD+/eda+OsnZR4GdPo4oIXk/EtUqw4T0/flywV4UVX
 +WB0kNRhNS8DpWcmnCWuTAUmmca0IJlvk9mRTHrYLraZ5YizbwJAxI8AWqIxVV/vhMCScl1VL5U
 s7f7NlyAdYgMtb2cZ1RMrNIZq0rc0l8teJpsAy85zVdCcZgzbB4KsKTyHOuhtCLt8apybiVWv2q
 MOI/1A997r0d8V9w+EcfdAowvZWwtnidZrmKWCpNon8sz9dF8b+L6XTs2BfhYMMH0pqCqONJUTs
 Z9JkZh5cBOL/MdOgpZZbnUH7vJNZjLfrKMWWGbSc9JFGOBtCUOJMWuCWh86gIiDJq3SrjROYV0D
 rUjVUunptQT1IJ2lApQ==
X-Proofpoint-ORIG-GUID: KxNjvi8hWxyw8i8OCtaKHBly5PDQu8aP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX/BjILVOkK/h2
 Re+/YTy+0zAKDAhcwykQHvpW+HvlXc5DiHEwwapdVwryTjsXMnBgHpFQxHZUVITs2tB2OZFcF9Y
 weg8lW7Ra4sVwg3TEBxkvti59IJS6Wc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cf007 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-GUID: KxNjvi8hWxyw8i8OCtaKHBly5PDQu8aP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177

The MPCIFC instruction doesn't allow registering adapter interrupts without
first unregistering. So reject any request to enable interrupt forwarding
if its already enabled for the zPCI device. This also fixes overwriting and
thus leaking resources when the ioctl is called multiple times for the same
device.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 8fa01be5a6149404adb82c0979a78f6347edd3ef)
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 9fe8c7237eac..e97f5a5af113 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -239,6 +239,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	if (zdev->gisa == 0)
 		return -EINVAL;
 
+	/* AIF already enabled for the device */
+	if (zdev->kzdev->fib.fmt0.aibv != 0)
+		return -EINVAL;
+
 	kvm = zdev->kzdev->kvm;
 	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
 
-- 
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2E442B03
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391498; cv=none; b=Q62B7nuTGng/68M7VRP/lEs9bTC99eANGSL2vhb8RK82jront9+aAhGqC7trmZb4jYAD3LjaLE0UoYai+ROh41AeF7Sa7FKhgrn/kcVtBjUKuLOnLJ++EDSma9iglGWVJcQOO/nkRrpT7ruh3qcqvjyGN1yvClP5S6gdPeh8Aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391498; c=relaxed/simple;
	bh=MBxS2IVembf5yeCOWlwLPB8SD01mMwosPCz4H1EYs58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzNT8pgPOXsAH1YENjRdzII98hy9Xbo78+dvP5liJc3IdJ2WvPY9qsRNdp83jgR9OoS0BoOYXGO8U+hveWNIRIPZxxbdaKTr/CCqHWGBmXyrKb7nNaqSTy5YokoZYA6BoS9O7HgoW5Z1C4fxmVGXkk58kLEakL6/gdzga/PUJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q8DjAIF7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q8DjAIF7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2JFh2392633;
	Mon, 10 Aug 2026 19:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=He3u83V56tonXFRtA
	9+vdgnwoetc8XOdQEmbwbmGnX4=; b=q8DjAIF7RpAWjcFt0PhaW722K6yqwpQi1
	dOm4jZ3Z9aMhsHbTHPFlKUF8S1slza7ouCfwO5kNyIWbw9MvLpCCWGDccQU1wKyb
	ThSvQvxHhkCPXoNxrsFIHA3lW7b55S0l10+lrSsUDa4mosz9tVk7iyTnwtPl0duQ
	f1uNFmTKHH+fYwzL2rEoLskL+dmL05eRFnxjQ6VdWb9q8LDdLIt1qxZ3jtybzDCj
	+3K6j0fj/847VcrLttF45N1/L35OXpMj4vWdcZL8hpyVGgV6QjrkVK0ZIDJeSu8Z
	dAyS2cwqvv5ph0huVA61npSoQJq8StNwtxIUk6eBn3U/gWUMOeEnQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2sbpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJfIGT006229;
	Mon, 10 Aug 2026 19:51:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx52c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJpWBk12845616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:51:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E451A58045;
	Mon, 10 Aug 2026 19:51:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE0858056;
	Mon, 10 Aug 2026 19:51:31 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:51:31 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 2/7] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Mon, 10 Aug 2026 12:51:23 -0700
Message-ID: <20260810195128.7861-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810195128.7861-1-alifm@linux.ibm.com>
References: <20260810195128.7861-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a2bc6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-GUID: IkPi_98MqLKZcxoKVZsfTZLsM1aEzNbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX5kZip7vyM9BI
 hsQloIOKd4JeR4bc5OifUbLSKQq41v8IF0pj1eymT3h8owlboReAECY71Q2dQEGmNcoiCUsbNcY
 YyT+n0oUnFB0zs+wirpRwoh9EPAEsLHMpfrsQTD22Wnda7GnSWsvsf0NwNjjc5RhPYm9y6MpS9E
 2W8NTZnFRiIwIhhmRuqoe3j1J5cU4oFcnZZnnKQqjHxVT3QTgEgceue5yOm/hcJLj/LDk9uH8YE
 1PG2hXPMHbXzMn4UXf4aaGLiSFmQ+7RqEGMkz93ROmA0RL1jIXaeWusQtydOCuZhuvkPefsf207
 Qtdfhg/fcp67yGoEH1GsD8/y3XNPOzlXWJ4qlSVX1C4FCt9Q88Ww6xBNBcGvKKVh4MUIXiyC/Dn
 nopJ9tsPhHtXwm8ua0Zdcx/+sYdp9qjzsiF+OfWUgJ3A+v2MhPMYygjHHafYRriGUVt11ThbXO0
 L/zdMNQCLDx5EpjP4bg==
X-Proofpoint-ORIG-GUID: IkPi_98MqLKZcxoKVZsfTZLsM1aEzNbq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfXyuKGp/MC49/O
 Vqc0Vh/baBCpHFmr/krCYjzE0L6hmNnLezmv1n7SCUEzoeAW1DHJjrfD9VEYm225BMOf/9q30+v
 4vaJTPbkKoS3wtoulqIHAkSyr5NpcI0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100166

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


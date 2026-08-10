Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8438CFED
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386096; cv=none; b=JC1BK4g7iTIUr1q5wfR7W9clV+Y6Il1VHx8OaOE2aaI4tLvBAlALA2YmD0IcQhCHtY7Tpl8ErZpVTvpt53VOhn1SJ8eyqCmgldUrrWa5mdKAVdY7kdO/AJrhFbr5nESQ2F8CXDr6CI02XZ2OPwREs5BN/E7hrNzup3q4qJLAc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386096; c=relaxed/simple;
	bh=bR0xBRx5V2FHcP9p47T+e1lUFT8mIlxVI6NqtRMIa44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iyWPCDpumyrDLRKwojhp9sr6llQKn+QZrkDSom7Uub4UXEScomDQOWBMlklVBuyHWTLjJIg83UjirlisyIK8KuJYMGyI+iQVKADDwPnERo5/zOO3HK5moy58gxFrWL6FY7lolil8GspWFU1Eg5y4uVaf8FiSOL5PSX0bePtDSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aD7kHBJ0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aD7kHBJ0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVYpF2154183;
	Mon, 10 Aug 2026 18:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ESa6rRAacDlLFI4ZX06Cjcd4pll7XoUDn9nWjOsOA
	a4=; b=aD7kHBJ0BOgdGmVLT2T6NWNRFcGUbbgStAHPptDMu/VIdkLmpFe1nfa2s
	rqFmvw/7QJraWwu01W4Qc7IMbFNQxirqpVvz3AdL4lRHtlLba4D0zDStb0IgsCzk
	Z01gjjvHFW0HS+Yw9JfrG5MngQoTl4YYOECfMTrKWWq30sHtiDb59cnOST3GV11H
	IMsdrDFn3w0LRYz+ztiWtP1HxCC3w+Atbwt9hfbDgil5GqAlvmOQHFKrZH90R7US
	rodPRRBqc7ryh90o8wSJU+NsgjivriwfcwEvq460OOKX7PU+i7PuG0AoCldBMgrB
	0W/v5MS6hp25S3KyJZHpkudnjoJXA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9hh2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIBQiM029188;
	Mon, 10 Aug 2026 18:21:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxwqna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AIKpPX60424650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 18:20:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAD0158058;
	Mon, 10 Aug 2026 18:21:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC4558057;
	Mon, 10 Aug 2026 18:21:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 18:21:29 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v2 stable 6.12 0/3] s390 KVM PCI backports for 6.12
Date: Mon, 10 Aug 2026 11:21:25 -0700
Message-ID: <20260810182128.5458-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfXzjaKxG1u111e
 lv8tOZSe8JRcv1VR1UDFziQ4FcwwXgLjK1QzEfH/I++1THfs+2xSFPwuv/JaXkfdXS8w1zoGydT
 FI3uB4gp9DpTojTuLwXVDCDkxOEwPdGnCh3Hj6XQjY8TFYUEj7b8afre6bdyzABqanbENeReu+S
 T1kngFYdAie9VPGiRW3/4xGNhelukwApPLNltlJU9yoY5pon3NVKv3aSJLHIU87Nc40Hhb8in3A
 4GxGUu9yjN8HWVx0QoyqRFYfpeImo43k4uukazlquq6w94hvFZBRwl90rt6bx+LtaZARs60MCYy
 9HUG3N4VCMu4qSTmmXfiqAymyvIbu8h1fohPoZ7Z+Ea/VgxH6VtkaN47iHiiTj1jKDSkhPRlNbT
 jpgj4mw+Z8Dj3UfjXTObSl1Vd3jA8mDWTUukaQ+FPdvpktw60YfxF+HrWMuUN4ADX6S9U69Zhlk
 9C807cA902mMMh0V7ZQ==
X-Proofpoint-ORIG-GUID: 0-70YHwU2al2Mm0jg23PJGtYQbR79ZGL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX3irxsztDnPXG
 9oYqYOUmQkRVeOW9y2O3aesJd4okTVtJH+ejSe+Lxc6//+98QGy3IPtgmrMg0rr6z1EMHSWr3fc
 WYsCukQAuAgp2wwWX3D9olfiF5Sv+QU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7a16ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=IaFvdaZldF81MyjaTVoA:9
X-Proofpoint-GUID: 0-70YHwU2al2Mm0jg23PJGtYQbR79ZGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100154

Hi,

This patchset backports the failed commits to stable-6.12. I have resolved
the merge conflicts and tested them on s390.

Thanks
Farhan

ChangeLog
---------
v1 -> v2
   - Resolve conflicts on latest 6.12 tree

Farhan Ali (3):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix resource leak on IRQ registration failure

 arch/s390/kvm/pci.c | 83 +++++++++++++++++++++++++++++++++------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 63 insertions(+), 22 deletions(-)

-- 
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EE32F76D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567250; cv=none; b=kAhyyB3wtp4xH7CydevHDw5cXzN8Tx1Qsbkg8of1IcVkguzEdQ8eYsy99UApvGl1fkJeXw2eqJ/Iw6yRg28UBCurL7gU/rk5gECiKHgSaa2dp6GYp9o7ziZT2HtI5k0gjq8k6S+Jut2MzQLqxPzMnz1EZvjHE1L/zKc4JnZDzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567250; c=relaxed/simple;
	bh=CzxPelwhf1Tr/bpCnKFmAM6hOxkgZpYkqgC48Akyd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFDoW55e56aqbIvknhiN6tVIaC2yrnEGxhA/cWhRJ5Ea+A1EXvkaWMmldw6MjZciQV0nvkAbMgD97/ijQIa4BtKG5f27T171EUmALT3pjDKgeE0J3XPAe3wjZY7vStsAAi39F3H2AhqRDmsuq9jwSSOuaCUXEQumEs3VUF1iAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N8FS3uhk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N8FS3uhk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2siF323325;
	Wed, 12 Aug 2026 20:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=md7psmAeqg80KyRsJV0PUrbCTfPSPk97yQw5KvqFr
	8w=; b=N8FS3uhkRvhiMtIT9iNQulEB3lf6iCSvq0r6MwWNx7e0jMmuUvGdDEZHP
	y4ejXOJ7e4AOymFf2FJT23xdTN/fe4sDsqRLRnHS25uP68eRbrFO6c6T7/tl6yjF
	e3J8NTBSV8dolOkpbzk+49BSJQpGuhg2IOw46A7WKN09WFLvuWsvItUt6CDwnLf2
	Y+DnNW/7qzzmBbpsZUIRGKnnWThX1XolpNi3cbdnko7iSH2MYnbIG/hBzxRLzbrL
	mbbz9IEVK65VxWzeLkTCrDCVoBRiax0Z/Xa9P/Cpw+0iYh6Q11fcmJizfcOugUWd
	c6BlrEU0Ow/nGOPZ0LYJ3trP7Ul7Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbrp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKQGqQ012469;
	Wed, 12 Aug 2026 20:40:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy7rwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKeiKk32047648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:40:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77E4E58043;
	Wed, 12 Aug 2026 20:40:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1120A58055;
	Wed, 12 Aug 2026 20:40:44 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:40:43 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v3 stable 6.12 0/4] s390 KVM PCI backports for 6.12
Date: Wed, 12 Aug 2026 13:40:39 -0700
Message-ID: <20260812204043.2536-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cda4e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=8cDa96Ns0dcFTkavgMAA:9
X-Proofpoint-GUID: OB8vNazu5RS4jMC1Q20KN11T7khSfuuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX0WDktCVu8Fpx
 wTRhTRt62YPeeC+5BVmSqJaLP67LLadchA68QeR7lIr+wkVwIe4iMcKNsd7IwvlpBJH0s/Cd+zb
 2MWzyG1T6a+OoY6AJ9tmRgaXLJOHF6c6bNSqUHLWxMcbytWysP0z6ZdLmD2DrbmWMa+Fgx6bld/
 XwuuDMRO5r3utM2hG72duRNMLMGYdPBggAhIWGvJwzMRK0I7y+Q5PP1h7EtBIpykJ+EFwpn3yTd
 y3iaPdQdw+syB1DvDm+Hvi4u5ssPlea/1QUOfaCIY/9ZoFs8btTFnb7vomE1oiqD0cyDWCcuuN1
 /bbJElssfLZUYXjaiTeBsclatI7KtqOoHRiwWY+0OlN1hftpKEnFtE2xtWeOYORMyqkWdhXfTF/
 OCOPa3RN3rcDAa3gWDS5sGNnrpRu5mS0jvmGh8PAPmellytyI68OVQKVHKPeRr1JBp4VRDn6Wys
 rZ3DkvyM8bHW1ArZ2Sg==
X-Proofpoint-ORIG-GUID: OB8vNazu5RS4jMC1Q20KN11T7khSfuuo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfXyfG25zu3gD4D
 P19b5CevA1RVRlnPzqcFNc2G2LTqRrzgO/QsT+l2/l5rmsJGrXvqIWkefgsMgiDQQqATsrH0m4H
 3s40ITqklDb/kTbM8r8B6Z1Vmu3Daac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

Hi,

This patchset backports the failed commits to stable-6.12. I have resolved
the merge conflicts and tested them on s390.

Thanks
Farhan

ChangeLog
---------
v2 -> v3
   - Fix an error in patch 1 to remove in loop read.
   - Add missing aisb calculation fix.

v1 -> v2
   - Resolve conflicts on latest 6.12 tree

Farhan Ali (3):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix resource leak on IRQ registration failure

Matthew Rosato (1):
  KVM: s390: pci: Fix aisb calculation

 arch/s390/kvm/pci.c | 86 ++++++++++++++++++++++++++++++++-------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.43.0


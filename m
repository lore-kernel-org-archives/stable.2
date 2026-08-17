Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10A306744
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997776; cv=none; b=a//wNrTiaNIoeTUEzUJ71Brtzz3rBlnPr6ATBQ5e9D9vZYYShFAAxFL/EfCzajMpvysdHdW8ZHUxpinqqNuhOTuXLq5OkoutB0ORQ/vkPLrj7VhYYIr3uHpuRWOl0hCdSRXkIzUtHGAhOiDuW+9IBUPWyTSIEZl71tDdQ4bNU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997776; c=relaxed/simple;
	bh=NbRWaNg0kBLEDnIWdeSCGdLYT/jsixjc8GivXP7yA+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg/NYBAJPJSD7ZFwQqb3cCfspeFEJllXSMITNcSIKBgWzQg4luSjg0Vo+g5GCTkTQCwemBu8Z6zVkuutABBzPO4urj7ImO9aQhr2NnvZVgegBiVo2ExTmEQgdQlC1Z9ApLRrgcsKW2tp/o7EQybdMRuePDEMR6XI2q5CxpueWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gOvkWzLd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gOvkWzLd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVR9o2125497;
	Mon, 17 Aug 2026 20:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XGRgt5w8wEqB0xGPJiiyI7yANLLClCNXNq1TiuZ0z
	0c=; b=gOvkWzLdf+jSRnKUfwC3WFujTOVw37lljijKnNvodAtB1eMkldQLuKKLb
	JRdKzav0ozNWYkZT6lpvxKwxBFwdWbEZUcA6mQnGmML0KSfVIhprPjbB4OA0/fjw
	LMqDj2yNSs0pzt5hPBcF6tJ/rKUV+4j3j4B+FOuRVmPyO0UuqXcDMAp/Rozt+nZK
	q39gsnpyi3eInzdSzy7p96H6U4oDIvDEGz0683i5qASdwMivYdjj4sfRbWftP90X
	Tycgsz2ho7Iuub3q7vyP83AFsOMANSDB/1282F4Dj2aiMk6amwzzUybNIaAV+hCi
	n0fUkDWP8h57tHH37nwvmpKprlmMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3m600-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJuKck021017;
	Mon, 17 Aug 2026 20:16:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y7a6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKG9UJ17957384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D514658065;
	Mon, 17 Aug 2026 20:16:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C4F55805D;
	Mon, 17 Aug 2026 20:16:09 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v3 stable 6.1 0/5] s390 KVM PCI backports for 6.1
Date: Mon, 17 Aug 2026 13:16:01 -0700
Message-ID: <20260817201606.3194-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Do1DJVCxxxSNQNa03f4Ofnrt_XbZlIj
X-Proofpoint-ORIG-GUID: 4Do1DJVCxxxSNQNa03f4Ofnrt_XbZlIj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX4KQMmZ1N+eDG
 16f1imz9s8jZJNNdua1aZn16FUbpz8/bZ/PFP2L6fl7p8CVMkXP0fuvA9s6oEVjYMjSjIt/ULRz
 HjE4/t3GZ0e6ki0hKSzR/NSeOe89x1Q=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a836c0b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=aJ6dwiji21v0oktMHTIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX+8NVwH7m5SyG
 kkWCe4iA5phmXZbywd3aR4EUD72KLOXbaXTK5mnZCf17CzJuv0Zky/oGzrcMQ2ChUlLrXivtHyF
 4z37Lb327GXoDY+PfeRbSe3masYdbH7Ec5bhv8HW5DEcIOEx7GggGeJ6TVUfcmXF9M3pcasx1QG
 tV88A+qiUqA2nqfKo627C+MxpXrWXKMeBVymV66GsojNtR00JN8qny9TaP7/syDI/rfCksFx/mX
 yjPrteJB4vknNV0fNEBOvwuo7CNiHBALv0yxk2WG5UHoKIrEm3XCNxEudTBY0upnq3RYy9llisR
 OKagdUT5fCGcBNJNixRt9W7a/fNxZMSAiVdmwrNhxGaN9h7mgqgkcpWg35AX6PIo2YNhdaZ7+P1
 +ux6QE5lBdoP5KwdRLsPak2S4nSjJKxtqBNXK1jCvfZS4jraD29djB6T7twqyuLgGwLuhhDJNr8
 7kCxz6KPqUeZhCuwcSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170153

Hi,

This patchset backports the s390 KVM PCI fixes to stable-6.1. The patchset
includes one dependency patch (patch 1) from Jason Gunthorpe, to export
free_uid(). This is needed to resolve a compilation error. I have resolved
all other merge conflicts and tested them on s390.

Thanks
Farhan

Farhan Ali (3):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix resource leak on IRQ registration failure

Jason Gunthorpe (1):
  kernel/user: Allow user_struct::locked_vm to be usable for iommufd

Matthew Rosato (1):
  KVM: s390: pci: Fix aisb calculation

 arch/s390/kvm/pci.c        | 86 +++++++++++++++++++++++++++-----------
 arch/s390/kvm/pci.h        |  2 +
 include/linux/sched/user.h |  2 +-
 kernel/user.c              |  1 +
 4 files changed, 66 insertions(+), 25 deletions(-)

-- 
2.43.0


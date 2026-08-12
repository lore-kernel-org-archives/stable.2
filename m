Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57D3FF1B4
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572809; cv=none; b=urZ6lexfA673qtaf3xMkQoqoAS97LYdgqdW8bdYmfdA0ot81n/Om/b6Sm3NBNO9dXPw/mmMKBiyjFxJDxNTostnO/4Md9VbKo5DWAPoVLBKd8DmQfKjYgdppnDBThbYTtdOPZ4iXGsrTU+J1JhnTYE7orWkDRbmeeLlYlN1iQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572809; c=relaxed/simple;
	bh=axSYStjM9c5UV941Q64kw+5LGN1Z+925dPkovOgkw4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3WngEgn4FbfRivf2cR7Fb28b8h7T74f8eBVmD/xwB/zPr3iwiDJNO2gjinlj/LPXr2J8+P8HOEfSa19z5b4Jb+DVXlONXMgQJGbRiXpFYfzuwiqv58ZAj8DKkF2QJwFAIjb4sAh/c3YlhA5oMvht7tHt3Fh8X/iOtGE5Ih21EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YvneC8zF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YvneC8zF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2tcP242918;
	Wed, 12 Aug 2026 22:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=B3o7piInJsA3/Ww12Vj0OObcpSCuEhQH7sXPUFwfT
	lc=; b=YvneC8zFLixqRw2SDU4f3aUkRyKIFS040r1jXYVTRHkw35Bv+nOGWXZzY
	RacsJUbRRBKF95h9C41yphxqz9tV6LB9Otz6n+cu8OMuoT9YZw7WFXW1vN4bx/j7
	Escu1kp5enYgNqJg7NW4Du8w1MQ1rQ5ZJi6cTkMA96oUcOf4CPcsLqTQuUB9vuzY
	g60GaT4Gx1F8IMCTsPp5Yjr/1IgsWaXH0won6BOQV5JeJVp6C2e9AeeRcci7EL8i
	Vvw5vedUfLFaSBdBskhW9Xvfk4NaK7HxLF1a17g5krOQEKaTJqrNYGVxVRr0i1Lm
	vn2G8TRBIgY3hxjEf8XA0L60THSUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9n024-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBIFA009201;
	Wed, 12 Aug 2026 22:13:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq8frf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDN3j29950594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39E258056;
	Wed, 12 Aug 2026 22:13:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763E75803F;
	Wed, 12 Aug 2026 22:13:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v2 stable 6.1 0/8] s390 KVM PCI backports for 6.1
Date: Wed, 12 Aug 2026 15:13:15 -0700
Message-ID: <20260812221323.3645-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C6A5JoZQaBAjCjoKWH9v3SkOmdSGEEcA
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7cf005 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Fsu3Zav_ABX-K4Jy_cwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfXys+G+GPiNO/w
 EP2qlpwUG9wNeFSklfdL/vPhcdGfD02xXYo6kbECyMGhyu/YUepTdHsBD3+bYbWueXLyqRtptCm
 5nJ3/1qvZ4w+8OsKKaclldC7OGSmHPeg0NEsTHaynAnN2zl5B/i8Rd2tIBOVg5Ll5nKNB17ZSHr
 DpktDzKGXcjRIunuTmtZm1Fz1JttcyqZaVTTObxeiwIVf3+ZVb2Ibco0vhbtounpUYzPGW28pFz
 bIfVTrcYz58Fcy2sde35KfwIuBToGFfc0CodV3F1utppUMy8TXYBB8CzXxTWL3TzfcbD3b7oGiV
 zx0ckzohq/LmlQ0IBIs/LmjCB1AjGruaX8+Kde1mqU06fZDp3kFuSaxgJKehOPJt+w8PIYlz9LJ
 6aE77LsNqxAmLnlKEJd9gdcOaR4wfC22aGCgYPhox36WeqH/BRibJFjL2/T9tZ3sb2gw5ex2KSS
 K6by+OEsoohEniL55Rw==
X-Proofpoint-ORIG-GUID: C6A5JoZQaBAjCjoKWH9v3SkOmdSGEEcA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX2CHy+xndYygf
 wt8eXJiHJ4C4WoecnjlUYZPG4DlnUhYNEi2afq4VOD9PqfV1PfL1/PmjMbCJozxhlS28vOVWex7
 vTdZ5L3AnLi13832djf//8e1zUj7+nA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120177

Hi,

This patchset backports the s390 KVM PCI fixes to stable-6.1. The patchset
includes one dependency patch (patch 1) from Jason Gunthorpe, to export
free_uid(). This is needed to resolve a compilation error. I have resolved
all other merge conflicts and tested them on s390.

Thanks
Farhan

Farhan Ali (6):
  KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
  KVM: s390: pci: Fix resource leak on IRQ registration failure
  KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Jason Gunthorpe (1):
  kernel/user: Allow user_struct::locked_vm to be usable for iommufd

Matthew Rosato (1):
  KVM: s390: pci: Fix aisb calculation

 arch/s390/kvm/pci.c        | 114 +++++++++++++++++++++++++++++--------
 arch/s390/kvm/pci.h        |   2 +
 include/linux/sched/user.h |   2 +-
 kernel/user.c              |   1 +
 4 files changed, 93 insertions(+), 26 deletions(-)

-- 
2.43.0


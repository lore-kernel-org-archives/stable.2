Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA222236F0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391496; cv=none; b=Okv2lTEjEaA1hiSbnm/l3WR4ful1vhGLcpZ3A5vLY7BHN4Z1k9Pz/Qwn/d7FzuZ0dVCFvJE81P23YVq6QNbemJqZiMs99aEzc6VEvgtsU51mii3MjOHiV+l80KxuPJvdT1N7B2yln7tAtMCVfGVADfuWOgxISXWIcuvmJmwEG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391496; c=relaxed/simple;
	bh=gTBxm2v/ZkELjwQzhQKvjFB7aCZv9qUL6BM97EFB2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFsQ24iI9wiLgiNxcEptAm1060o8gg8n9UTX5UMANCmMPC5MaMFf+8Sad3NA8sEJaE5GqpMqcXH/cvm0b88KL/etO5C/cHpxsHn73oIco6QsQf98kAUEwTND9IOypV50ENAn3HUBfZ+zEJ9nO7xIRqDJLqe+jReEA+mOcZEPnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKtOcobh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKtOcobh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ3D1N2435034;
	Mon, 10 Aug 2026 19:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=r03R1vyz1/E6eeZhM5gTFU4C/2/NoSXHg9gn7eqE5
	5Y=; b=FKtOcobhs3ZJs46KVaCpK6BseHnx/KWRLcySTnKTtXodQjRDADDm6rvIl
	akX0BlD6jB3APxr9bbsVftQV0/7W7Nt0jLfN8xKl/6N17qKJcVslueKwtsNmTzqg
	G149oUbMCU2DhWMGtXq9PoEbFz9rEAjo/d8P/4aS/G+8PLOnakE6n7HWp1sC2qno
	7Ls9AgsnCpTcB9qh2L/X/4bKhK40/mWmJEd1Q/K7dpuFzXO9dRKC2mN4a9D84ihC
	u2AeIRMeVdGfnNUW5hHVRYzeZSe2AQevxE2TtEeOjqgPvnsioKx552CyoGJWqtXD
	LapDH1iue5HRzrtyV9FqdeHcWK+pw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq99tbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJfPvY006283;
	Mon, 10 Aug 2026 19:51:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx528-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJpTcc52756788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:51:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A48A58052;
	Mon, 10 Aug 2026 19:51:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4CFF58045;
	Mon, 10 Aug 2026 19:51:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:51:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v1 stable 6.1 0/7] s390 KVM PCI backports for 6.1
Date: Mon, 10 Aug 2026 12:51:21 -0700
Message-ID: <20260810195128.7861-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJsGw-S9bjyrlhAr9wNmsgw5NcJyUNea
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a2bc2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Fsu3Zav_ABX-K4Jy_cwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX2BfQgvitk0mV
 8Po4g3iNEepSt38oUyDp9So5Sd12xj4iWcUMwVhFGAix28cf/97EIawFaq/GRzaAq1L3sRE3oCb
 8peHhUiAyX6gcbQmWx/OIA11BmL6gvkTF2Gi48eMkuFE62Ftpm8NJ25XPqGZ6kLiqIHMliZIuL7
 8e2bxK8DNIZ+4ZTQXkCreBbe5CEQiXpALF513FJVNwsk4ZSIElyOPcAWyQFaXDpEL//LIsSECWk
 u2JFtBr4PEsoSak2ykjL7Hi0J9nox6fNYLY22kApk58VZl2Kpmc/PTSw8/vfCK3jDhCjoIRhfZT
 KtqLnXxFArQs0KJ8flV6QnDQ1fMzlNARrzileBR5p3geKRcdOgmzzcC7H4oMA1ZMebEQSbj7yp9
 66QVw5FcUQu7ez45WsSQUWgQ9GApkEQQhA/JJRGUvSatp5R+dQ6pOjnNiAUgCZ3rdBhQ8kR6WBE
 e0nomgJlweQV73no/IQ==
X-Proofpoint-ORIG-GUID: HJsGw-S9bjyrlhAr9wNmsgw5NcJyUNea
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX+CB6W4mIsbnl
 7VpDq3nsDG2/iy+KC3OCezRcgZIDElG8wrI5Z44QM5/VlNSyZ6YtmVjD4gBwk0kDrNya/V18mBj
 bbl4iI/iLh3SpoB/Lpg2tixm1N63uNY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100166

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

 arch/s390/kvm/pci.c        | 112 +++++++++++++++++++++++++++++--------
 arch/s390/kvm/pci.h        |   2 +
 include/linux/sched/user.h |   2 +-
 kernel/user.c              |   1 +
 4 files changed, 92 insertions(+), 25 deletions(-)

-- 
2.43.0


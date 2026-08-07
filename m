Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78722E7391
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124756; cv=none; b=nb23sfuSJqoVWp4wnT2X3MiElQImSr+nTarpH2B6lvkUr0ZWn+4tf4J6gwsJvSILt6k8HFhrf1CuYJPPrKEYFmdZKQf3M6c3GLjpE5ePJvkXLi2eN35AUKfq5eaV4N1gc1SuFWF1OnC4MX5ldpc8XBi1UQcnJ2dZcYIVnzNCEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124756; c=relaxed/simple;
	bh=22wdNQ6AR2zSTpsRdjM5IKQcyJQ1E+DjenuzhfD1hzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ae3SzzhdmJwamx1Jx92vtn4pUFEpyNzHlGYXizxiAQzvb2+ylVjSE4JSO/u7QBk28VtAFTAtObrPq/9bFBovNKSAHCwmDH8bEuu1DZwwcD3D7Ldecca5TjoMk4xVg+7yd7JnUhHSoHhOKEzGOgjVg/78b0ULltLkLn81yE4jumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZOfX64S4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZOfX64S4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlwhN1928115;
	Fri, 7 Aug 2026 17:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Jy1DXKA+8mowrp/+ErJA0Gha2XJ/CB5rH5jqi5OnU
	6Q=; b=ZOfX64S4qp1iupLqpEHSP5uvE4oXOHf9WH9lCu6gLgaD2PTFKv6pNT1ux
	uzzjC87ByX7assZUiCU6tXQ+a7Jnr/m/7KA3wn2V/X3BlBXuV0dCnQuFcCC+z1fE
	Z+ZRLow7qQK00tih4iakKUCfTEkQXJK4lmJotBxQGwmC0g6Uonpcg38BBRkNEbTa
	hMK+r/MgJ30Igfiss7oxZKUL3QWPFbeJg4HXlvo9yodVyMf4BKPO+h31X32xvJiE
	g/syw1ZOfo4lUGYU2voKBUDcIeqZNbpKBkqcWeHhiGLdrArM4vA8sv6WqRLYqthW
	tOwGcTBw5GDJ9EGy7gb6OogviRLFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02d0ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:45:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HfOj1026500;
	Fri, 7 Aug 2026 17:45:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwgtrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:45:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HjpOO62128410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:45:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D99B58056;
	Fri,  7 Aug 2026 17:45:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B910158052;
	Fri,  7 Aug 2026 17:45:50 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:45:50 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH stable 6.12 0/3] s390 KVM PCI backports for 6.12
Date: Fri,  7 Aug 2026 10:45:47 -0700
Message-ID: <20260807174551.2359-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a7619d0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IprjC6OwZz564kVh1VsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX824BKABqt9Pb
 2iSo0UEIR9w78vcs4XIAGXSBgMIwxU2Cxmye9c1zQYVxuVDD1IiglW5ICoJ33JJCdnWTtyamAEv
 77C5omRkzpplKhP/CoMJPIpmdnRWTq6AWL4IqjB4XP/Xeo8xutXlpwLUdnJlKdjP8Gk5sZ669lT
 degc614Jv8exTD0jGbitL08zVlaHv8i1r/lS8U6/+J2RAvhPYuaWpsDFGV4WiVbsYUn1g/PfNME
 20AJ2lqUwVwjShdqA35z65zuEGiuIxJxB+gDJKuTxQPElDcirG+tvYEEZ0/rmhneHZD1hUPki8u
 MrDk0H4jSKs5UYCQSEPSq0TUa+ba2PV+Zibrn8RQzmdVw5QHOi2W9M+ZFJr/k2O5/KR07Ag1ypZ
 6EN11p/YLM30mVQ3soyUD1cPt2dnvwvRpYKAKaK9TJCdZe57ivwMS3Y16dSeMiG9Cit4M2Vn8pl
 Q79jO6wIqTin+PVF32g==
X-Proofpoint-ORIG-GUID: GT8LjIdtLZw2WyN4W-_c_GsS0qyrD-d5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX1ciaMKTnk/+V
 XnZginHBpSJE3QqPQcw2sVOxC16Cpne2SV5KshyYpQVHHh3MwJRRjoMWS0wTL7byEENLCurC44e
 auAMp5+YkIzeB8NMJ/KwUW7N7te8kFg=
X-Proofpoint-GUID: GT8LjIdtLZw2WyN4W-_c_GsS0qyrD-d5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

Hi,

This patchset backports the failed commits to stable-6.12. I have resolved
the merge conflicts and tested them on s390.

Thanks
Farhan

Farhan Ali (3):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix resource leak on IRQ registration failure

 arch/s390/kvm/pci.c | 84 ++++++++++++++++++++++++++++++++-------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.43.0


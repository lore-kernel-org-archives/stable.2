Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9184331202
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569849; cv=none; b=rD8a92HgApZHukP4XuUklkBo26MOf9pEA/YC+L8IL6yi0t3GHI9a1TIF0v2Enf0SZAyiO5ATWIIfqGXefEjIpsHLU/93bmJVDFZ83naSuiv1PrFJFD6Fk62zcPoH3hxNPrzTo77Rvwn2XvFbaVUPcP6YKGUPoZxd9ywogYnADrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569849; c=relaxed/simple;
	bh=JisRwrHIaN5KEUrvqW+yrWRotTULW8iLl9zVjKjqfUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI/GsrRl95eBFM36pl9EHoQMv49jjWoEVFDlTQc03xBd7zITvgzJ2HFo3Wviw/BMhUoIoTrqrW268KP5iV5nt30sxaG/EjBkaytvOGF4BsGoGCev1kSBaBhHWKjVrAsbYjOwKSmh273lLJzJ7ICIXqZofnNxwY4gGptP5HCdPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H4bKWdBK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H4bKWdBK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2pcs242716;
	Wed, 12 Aug 2026 21:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UVMWIVEDwI/Fr93AamaIXqSp9inNAUrdGke7mWMZo
	p4=; b=H4bKWdBKWDdC4dNQmGV9nJtuqSlXL1NDDQ6i/UrP7/kpaZbn87YRrCjp+
	1CAIbsa9UTYPwAZ6HuvdiVRV2ZY4a4hiur4gQK8FEd2CbpXvW4WUQhIpV7H+lxfc
	5ADIy+IFaYWg78XieSyfGDPa6Ht1uy1XOuSJ+na1GykSgimx/M9Bq0FVUvM3gyOR
	wjQ3NwYloOjQ3GRPrNn9q8MYEM6Z8qTmWkHEsXvRxi0zexj37dDUGxpFZUlU05rj
	CZ2KIdDfCOiNFAHWyRkKi0vS3cae34d9rwmt55+u5bZ9cIamhYzIVfMPIRfUT9S+
	cO4HNvslGJuwADIsYxD86c8GBB4Zw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9mt8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CLBHp7005581;
	Wed, 12 Aug 2026 21:24:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gg0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CLO4XA66453814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 21:24:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAD3C58055;
	Wed, 12 Aug 2026 21:24:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7269658043;
	Wed, 12 Aug 2026 21:24:03 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 21:24:03 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v3 stable 6.6 0/4] s390 KVM PCI backports for 6.6
Date: Wed, 12 Aug 2026 14:23:59 -0700
Message-ID: <20260812212403.3143-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 052-RPU43_et7FAH-EzrnEJNdXrEtdY-
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ce475 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=8cDa96Ns0dcFTkavgMAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX5Wsd0cd4DG/H
 KWGK1n0l7GeeZW/40mZ9NXanMRekDRUOxSkFTG2s97CB6IBYmBiIZ4oPcovq9RxcyqhI+s06jY5
 C7SdFRvMqiBLSWAQgPXSwqAOGDGlCoRmBExj+zl307a06ilAbcmQaH6DcRvwww29v1nmT4eVHem
 YnM0T6biQD+xVG3v/dbVGbkllTqo7ZPyOYaIwXtHtT/OxP+6gLqnqdhcQ0gAmcoMRR6zrPWc0bI
 jNZt2kvcw+P9XdpGNNdJehdaQHWzOn/r5qUdDib+01OYbrDYs7RF2xqw1kZ8UYM7zZ9DL+cJ3M4
 5tw+6sJY76HChGYx+v5IBCGUJk0ijXNeF79oyx41XtR3QjERO5e476pJWaxl/SfepiYKASvArCO
 pG8kXGawCAc02ld3q4/rkgGZXdcJ6E6oMSMKEltI9ERLp9V86IkGvUtwxP4eBy0OgUoPa+qrACN
 GRkMzSLNL15CZwYnwug==
X-Proofpoint-ORIG-GUID: 052-RPU43_et7FAH-EzrnEJNdXrEtdY-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX7zYVihioqy5l
 PZW9kZ0HMQvEz3wJolqPs8MpgB+tpKLTZLi6pNaVfFhCzROPT9I4wmSFYBUq9e3cFzVId+OHd8E
 MOzzzdUE0zAWNuyYFXSTcSAZLRlREmM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120169

Hi,

This patchset backports the failed commits to stable-6.6. I have resolved
the merge conflicts and tested them on s390.

Thanks
Farhan

ChangeLog
---------
v2 -> v3
   - Fix an error in patch 1 to remove in loop read.
   - Add missing aisb calculation fix

v1 -> v2
   - Resolve conflicts on latest 6.6 tree

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


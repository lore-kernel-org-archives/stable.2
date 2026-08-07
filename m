Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267A37A481
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127899; cv=none; b=jDBzlqJ9xYw9vtzJm8lSVZbHP445cYaCj+y3pRTZKE5KLZA7kqnqZGu/gBX156UQCGnrpHOMhXUcFk8nM7CAbOPYtyLh27IH0XHEE9ykr5tyRZO/coerSPMhRjMwAm3L7p67F73iA1Fp0SZg7iGW4mv9H5vpTO05A9XFui9ocAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127899; c=relaxed/simple;
	bh=g/ZQHD84jzsqdQXTPEaY701/pYFRn9MPxHTc0Xza/kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMwF6u7SknriP6JnwvN4wD1HWa0h1uRN87+nMWI8uN0QcuabW/QSPrbMyHKNZT+VmedAOT1A2QA/5zYSka/cw/yPDZuYwrK9+gx/M++CJBBR3TUFUsaIdGRnfMGLysp+ckbQT2WAwSfqkWSr5vny9JmC4gg481XBaGEJtVfH2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZO2hx527; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZO2hx527"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlkSp2001198;
	Fri, 7 Aug 2026 18:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VtbffAdUiWCP0FaZCKPeqP73RmlfW/K1EkPjN+ul0
	Fo=; b=ZO2hx527tJtsVuZT5prPlVibogvb+X46yBBfmuRZYHtB6djlTW2HzOtBw
	bQeXyCwgRI3m8UITJLZ/XYVX5YIplfGrjgzOZLkWq3fKUg/P1BErYkz2cPa8sQtI
	eToEMy8U+hPwUiiA9CHgGxvWoYaMbYf2nizmMU/YRqzt6aCfbz/wUH/GTnWQ5Ycq
	9o50aFxtHO7a9nG6mvb8WnvxzYXQEEUsdY1eudW7QJnBeSP0CwRARGSvG2tHAaJI
	TUb8d0kr7JZAIQPBi383EZu+kYQtAPbjNfKdoK0LlKMwH2pYYQ98ieitHVgb4B0o
	QQv6Vsh1yw+1bdUYMXXDwecdZvBJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy045cdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677IUowN010972;
	Fri, 7 Aug 2026 18:38:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu00p56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677IcEfb27853368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 18:38:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCA958050;
	Fri,  7 Aug 2026 18:38:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB0858045;
	Fri,  7 Aug 2026 18:38:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 18:38:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH stable 6.6 0/3] s390 KVM PCI backports for 6.6
Date: Fri,  7 Aug 2026 11:38:10 -0700
Message-ID: <20260807183814.3035-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX8742CbEGUj/l
 Z9Mi0Z/RMHkseyawiei7sPyxFiwily5APQpiCpdH0MZbeCz9Y6A3Mccg9KdM0bOI1q6TDX/OSzt
 T+aRhWU3rvNZElvWXjTliMx5qT+G3Rsf+5ORguF1EOUUHvkh9iFDLcqD3JkSAOgkNc983IQVoif
 VEiwdJe5g+WMrXmOCtbvDtD5h8qFWjjL2iRNJlyVSrdPkrZvdYVFWew4mjKl0p3cEiIQ1IBze0U
 mN9InN8kXnbKLqQpA37yRJa72YZQ6+qqSMhfAmPq8GikIem8HwKAvBl4ER+KEjf6VghTOzxxIOP
 M/WT49Fjerohm1C6pP/fmY3Kn9kOU0o9vNjGPBldU6z8usXweiWfuDgYWuNIrETGFVuqH9Q4NnS
 TzAeLH+A5JV2JNx2Yj4u0d0Xs0TUFm/XlxTj9NM/jBYz6twqMHKo6Qj2dmiGolahTQ4qPRiIIbg
 +neBXLGqOqU0PDPD68g==
X-Proofpoint-ORIG-GUID: NdWfUv8aqIktdmOG7x_s7u8VpluvjMwR
X-Proofpoint-GUID: NdWfUv8aqIktdmOG7x_s7u8VpluvjMwR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX+Vf8QdC+jNoe
 0UudMMIvxrD/c+IPJNmbbt+S3nRxThSoKCFtIjEfE12Vq5oD3myEHvRw1rCE4SJmglJg5YhuuAf
 XyEYyOWtTiOAa12weJLv8rawPboZLBI=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a762617 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IprjC6OwZz564kVh1VsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

Hi,

This patchset backports the failed commits to stable-6.6. I have resolved
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CC348C4C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388574; cv=none; b=Mq3h2EwcB7ClGkjxyDWqinRq4HSqaMBOr0OtUMKoJ/HHsIEkpQAa1dmaIqiaQhUWPe0nL7AnTy/09CFIcXMV8pd78pfd5ReGXPydr3oXN+1GmKP2Nvp5MusUswJRZqunJ3qoui51updnT5fWvQw3jVQoh3mpWCQ1AxEp6AY8mf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388574; c=relaxed/simple;
	bh=qLANAcSMXBB4eK7Z7ypxYcyXJqkwoiLlaGJ7TOK8YVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RONajVbO04zcCwnjs6hsHS4tIKeKOzXWJrHp4qebHLwRedasGnS62Dj9h+VAe6+ysEKJbCrhy36PyKo03u/kTGhlM4zC1bTDAwuXHDzyhsDYKWwp65yK0v47s6w5RUOV1S0KAiYN7mZdLD1w5Ex32SrUhBNbqiZQO/8TAbQOhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mGMYqKy/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mGMYqKy/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2LtJ1382334;
	Mon, 10 Aug 2026 19:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D5SAhaD112+j+YdM8aW7ykc0GbEo5aBitJ24TMfEo
	ic=; b=mGMYqKy/25+CD0SjxJLUj90DQrF/E5VF7qWuZfHtIv2w7+wFSevrzz+JP
	NUosJg7OHYwVB5H05VXmJK0DZky9saAx9K8AiYukjwWaNtaa2Y7kZFpSVkYVq4Pe
	iK6TSAESVAOAUZ9DaJlao3RjJ11NzhBAjOytBdkbZuLDIljoEf7qf7UuUJYMA6Am
	BiFl8bMOqnq/1gHykX3PDa9ThLuR6LdDCnZS39bTH3CHE7NmjwrBcGPSpx1IEs2p
	BWoJCKgd5tq6q7SNAG4uyaCyd14JFJDU49sl+aeqVfKpNvuGPNEPN/4CkeWKZAOz
	WKHAkQPTLiFq6PFKpP4+xViCem7Ag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23jhuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:02:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIQNYT026222;
	Mon, 10 Aug 2026 19:02:49 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespx7s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:02:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJ2mWd46924190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:02:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F7558065;
	Mon, 10 Aug 2026 19:02:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0290558059;
	Mon, 10 Aug 2026 19:02:48 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:02:47 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com
Subject: [PATCH v2 stable 6.6 0/3] s390 KVM PCI backports for 6.6
Date: Mon, 10 Aug 2026 12:02:44 -0700
Message-ID: <20260810190247.6344-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7a205a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IaFvdaZldF81MyjaTVoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX6Ymjm8lvgOpx
 TpR6Knx+AciQPsKK5S5+wnZZhICefqBE2cvY/r2vZAfX0sJAYaZcs7P4GLSA6qxZz7q+qZm9/9C
 1z+CfAz1Uzuyk/bA3kKppOcdIOSljqtyADkV1DrMginJwX/63doYP3krOZ1WRdp5FuwaxGoOoGF
 Yrkltyrr+uzyA4R5ndjDleRctB4bN6exh0W1l0OzndHnxFJ6JeevWhhGdjuBZRzYJ1mMZASRPKB
 7x66RGV8qTG1Yt7VpyWszCt6Pyql5HXVTYMLid0vW0miT3aWcReFJmtpua8OdC0DaxFQqrd49/I
 xiYXtcEaXsd7aijSP2gbLXHH0c86qVPpnMxduzT5UuRE09U+HuuB4RnVegGRlykrB0ESQcJFqnm
 /3nlw1VP5DhsLOlcyzmVGzA8TLd6ty8oJKhaqAe/FKaSPbUbkOiNuGtBeAHKtYGqND81V1dDyA4
 bqLY6Y4pW11PyvOyJZQ==
X-Proofpoint-ORIG-GUID: 6Gc7uPVZMwaRw-hkQvKEwMID5QPJXPgk
X-Proofpoint-GUID: 6Gc7uPVZMwaRw-hkQvKEwMID5QPJXPgk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX0t+OGlHR4nfe
 63iRt4CAyKxlffzJkxRygNtTOk2N+3/GYyOjomp1sNoMzNPF+O7Xu5qOGhGmZT8kz923srtJHAz
 +dyageTDMQ1tfanMyWlAF2sQKAPIX5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100162

Hi,

This patchset backports the failed commits to stable-6.6. I have resolved
the merge conflicts and tested them on s390.

Thanks
Farhan

ChangeLog
---------
v1 -> v2
   - Resolve conflicts on latest 6.6 tree

Farhan Ali (3):
  KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
  KVM: s390: pci: Fix missing error codes and memory unaccounting
  KVM: s390: pci: Fix resource leak on IRQ registration failure

 arch/s390/kvm/pci.c | 83 +++++++++++++++++++++++++++++++++------------
 arch/s390/kvm/pci.h |  2 ++
 2 files changed, 63 insertions(+), 22 deletions(-)

-- 
2.43.0


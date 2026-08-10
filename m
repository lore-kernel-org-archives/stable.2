Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA7436BFB
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386099; cv=none; b=bxl2NfXWOcK9MWrwe9VxuOVwaZ7MOH8dSk8BGWWiBX8fL8wIhkTkO/9AFgaFoaqXCPHQ0Twl/ktQY8H8OX8N3B5v4Yls/OAp/OGSjicedUOpCJqdUpKyo7/BdLdFZrvLLinarapFWVYgcecIUemVY32eNRajBYBvxIeHigwvsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386099; c=relaxed/simple;
	bh=E+yRqXZIs5ODktFgnNOcdiis9W8qkoE6TjCFFsKScoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7eIof1FazWHVboaNvqel4FcXFw1FcpeBltFcM9mc0BGPqhJZkGBiBw7pz5vE6MClCx//QCEVygKlJB8IvaSNbbJ+OjB2uzf55EFPuv9t3ZCMqoiWVGcKwF3q0303vtRl7OvkRs+7iBmif/EgZCVUz2YNFIGESpwwJ7nuxb5Fn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cCKxGjZ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cCKxGjZ6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVgkQ2110727;
	Mon, 10 Aug 2026 18:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ty9LnBJu1b9cOE0q7
	ON1YrYFrlcBFTqe/b0dXb1rLiE=; b=cCKxGjZ6OGoDjfuPKNAdIUVkfgC8E0KzE
	H3v7jnx23Y0OVvxsE0wJ30BJOHyh3WH+gJMyzF//PsfW3R6/flPA+BOkaxz5y8TB
	s9fyj/pFU+qUwVN29g6CQG4W+9V5/SAaanm4otSRHbVqbzn/udFZ8Ved26RwO/S4
	V2YerkxC+gMU/xP2/ocVj9Nh+Gh0STygs0e6M6GnQIYA0WemPsKMc3t8EKcZZNi4
	zzGuGjBvkMP1ZNncuCxOzzTl6kqsLSliHIn+1N7lqa097XRuWYuICzo39ae8er4X
	B9aUuf1aEbJzc5/nOS0g6fzwmO7AJIjwwAc+3wMZYJnpmMeoHAotA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq99fty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIBI27012379;
	Mon, 10 Aug 2026 18:21:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5t5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AILVJe28115526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 18:21:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27A6258057;
	Mon, 10 Aug 2026 18:21:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95ECE58058;
	Mon, 10 Aug 2026 18:21:30 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 18:21:30 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 2/3] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 10 Aug 2026 11:21:27 -0700
Message-ID: <20260810182128.5458-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810182128.5458-1-alifm@linux.ibm.com>
References: <20260810182128.5458-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n4i_j-QVCYFkpd0tj8Gj0hB4OXLaRosf
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7a16ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eJt398lxKxdzswCBiD4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX8TswIoqs1rIu
 1lNOTRhWw6D9NFz2m+1DbN+Alr8cYHgBS3A0o3QaNODQLtUNNL7DCgb6/sT301UuXlXvRs8Opax
 bbSxcw16RsEEdzixlBeWbwbxoJ1o71ldT50egcsIjGbKaKFMdQntzzsxvekTvGzoziyim4NmMAv
 wE8b6ipxHze6tllWtlmUAftV1ycG5p2nmIpyAjcTfoqUQrAK++o6TwdKOqTcl45wEUzMMNmEZjB
 PpTBmSfzNtWp6lND3lhFZlTYby8M3AX182XUfNdN6IffNMmzEouEMLbo+Hqjp93hy9ELBiBrQzm
 hrcrcQzfY1UpkkPq8LtrxrRg+lYLs+203wP2v+S0nR7xcdChXZHW2rC6M8tcK23hws9e682+/Te
 jUHQGqu+fO4nrwshRR+L6BpaLeI+LXj7Rf2dlgNaGzH+59xVQJA2YR+Td+/vqesiHXO5/AA7nsw
 BLN2KWLS4BVLyM+yaNg==
X-Proofpoint-ORIG-GUID: n4i_j-QVCYFkpd0tj8Gj0hB4OXLaRosf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX1m8HFzGtMXqn
 yAV0Zi0DqrjbdG0ZOVkP4ihrdmRoa/EbawYuaTLQjHG7qrAku+GIlS/oQ/XsJL+oGH8shxOD1KR
 LTEtMYhdbDnR/2uPshp4Vk6ujAH6Mlw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100154

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit f86842e4d6c482300f4567f492d512c9ccf5bc4f)
[alifm@linux.ibm.com: Resolve merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 54a7a2f38c69..56a19c00d3b7 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -316,14 +316,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -375,6 +378,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
 	zdev->aisb = 0;
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0


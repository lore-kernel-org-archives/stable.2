Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B214E77EF;
	Wed, 23 Sep 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188164; cv=none; b=KinuXYCwVQFERfudzxd64ILCM2Cx4fZmtA50mvMdf7xQe6FAj09cQZ7SecTffeWteQq9ohQ/CNn++V6Q40KxvdW1jmmifK1aZp1qQWZv71moGS8rm1Od+wh825R+7OvozcNRTffPkqI//kMxNVrdiEnFf4eZAbBzLh+zgN5P3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188164; c=relaxed/simple;
	bh=ZuhdfIdhnfSW4LL9CGp1sKtQ2Tkj0KT8VDa2575y9tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPfDZns5rSooUaxhD4jfViW1BvL3z4+c/Kz84qk7MEqJcJSyJiCzjosJLlCkXJhiiq1BQ9kYTWHDXyQv18NfCJoClPmzZtFycCmzHhhk9Kspr1/AysvHVaACsISFgpRJ6QQHVW2gq4vtOcf2rGjc/zxELrdyE0q2NmcborYGGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dG99u3yp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dG99u3yp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZUAC2748577;
	Wed, 23 Sep 2026 18:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ywCMTSCyeGAzbgXH5
	x2KBRyc3ZG46OMv0ToQVSC5CN8=; b=dG99u3ypLoVjczPELGUEhV6Qfg+/CW5QR
	Z5h0V5APZSjgvGo12d6eIghEFPhblH6LAPDZJBFY5fn4QZF5kqo3tPGGiu38Fejj
	ZuEkYAB75AeQZFFsZJfrSabby9LkrvhnJ7s6rPswZ3fOK4na8TWvSJKjkK8DFxCV
	gS24jq2duN+sBjLTRk008JZtRvSwP7aMB9YBQJaykxUk0LfBIyN762S2Fu1k7hjM
	UFpRtUxu5zRe0NR/+v7UwPQ29u2SYY1ibBZpINq/05VX7e5bQHJXRpYkTJCFTnAp
	GqDXQE2t1WwqxtKA2Y2Rl4Q4X5v99mru8LfHH3Gvd9b2+z7xKud9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqmc7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWvGg627784;
	Wed, 23 Sep 2026 18:29:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2t585-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NIT1IM39977254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2185020043;
	Wed, 23 Sep 2026 18:29:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8707C20040;
	Wed, 23 Sep 2026 18:28:55 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:28:55 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 02/12] pseries/plpks: fix error code for wrapping key reads
Date: Wed, 23 Sep 2026 23:58:06 +0530
Message-ID: <20260923182816.151451-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab41a71 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NZelvwgA2UR8l0CqTt0A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX8xBlUSKcUzLT
 /Ot8eOE+EK6KQkyouPcrWN/uP4Ec83dShNCgdJcsSoRPWVSgpQAg7fYUwVzQdOaHxo9Z+mkQkgJ
 xlWWLX0LOiqwxScakxkFFCx4Jx1mDtQ1I3ZqjKnhYDousp6oFO65Ehdm6Dcp/hUllTQ3XKKp/Q5
 u6j9GXYMnBffmuHsJ9oaWzM7C/OEmkU3V9qOIf0dc4cELHsBKze6ZrROZOjLL7zTSkM7ykfZxwP
 jUZUBnxjnP6TMHDy2T+ysQzWNVDqrjTH8OOzMUSD/AyZipdNHgczfIBxOj73ckVsH1/VOjC9XzX
 UwgEo0Ak2PsYzEKuVY1O3DCxo6WTLb8dhHam0+5QPGjUeixUXhIxslOmuE/UpFkd5prcMH8toNW
 nd3fL1HI2Z+FAcqBrii2hqAPbV2Gqi0Kvl9IdDZ9phKJKF6fA7JtFRUTwg3a8zQXI894Xvf0tBO
 GsE33ZsZdlHrMm+rUNg==
X-Proofpoint-ORIG-GUID: S7BzPrRGZtS10uKzJDj2g4kMevZHVlPE
X-Proofpoint-GUID: VowuZ-cfXH1a2eK1HrNdZa7bRnxQLKRV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX4ZCbHVE8Xgvu
 kUOy1XHw3ekRvqAfjknbZBBd88I7/WEX1U/vHKdZwflCpnW19bZ/um4a5dBm72zvLduBVRmaVsa
 fSd2w1DNQFa8PuMfJ9b2JMo7EwYY9og=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

PLPKS variables with the PLPKS_WRAPPINGKEY policy bit set are not
readable. Return -EPERM instead of -EINVAL in this case to better
reflect the access restriction being enforced.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 7e56b3dcacbc..ccf5765a907b 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -829,7 +829,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		return -EINVAL;
 
 	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EINVAL;
+		return -EPERM;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
-- 
2.52.0


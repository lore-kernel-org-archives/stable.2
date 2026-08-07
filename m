Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC85282F3A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121902; cv=none; b=BGUMKOYAsJnAh+oxfi/92Biutpg99dUGCvs8JJwdINi7mj0Xwveey9psMcdBqBb11qxh+q8650zz0+fUKKLPhBCMCsd5NgxRmyn/3p87RoLs0LWf+r4xLPFkliv9NZzEwFdzPb3XBMPxfVhonDUxWAsbf3k6OOAasXW+MDlX/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121902; c=relaxed/simple;
	bh=LnFh7j5pz+3+BZLs+1NSkLVwGHREyXiX1yVSyaZ936o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgHn+/JOt2XvqI+TSaqzv8O3EJc6jJR0yW8irsNaAOso7Tt0kqRcg1NZmU36XWSENsvmOwxssZFFO4LGOVq0VCdJQZLXr/TqMW3V3u9JdXPueq+1IF2Gq/FxOMSrqE6H4XMfm07XmCxlukyKcPZZpNumFsrzro+D93eUN6O3Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aki83WYm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aki83WYm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlsWQ1928075;
	Fri, 7 Aug 2026 16:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=g8SZOh7awY2VIPGlgtYL8BOLCtph5ryMuBUeDCY5B
	+E=; b=aki83WYm9j3V602nx1IubtVJDtZ0/InV0qOogdcx+SP+zbGRED7fXCKRV
	HguedVnOcAUBBO3Hkd7J/AfYpbrkN7Zpr+sjtcUeH9+Z1SQ5+VK51HEVTz1tMv/T
	dQyrpWoPOmfCxQds9LO6v76ro6W4WasvXasRYzxX3ceYwyWxMaaGTR1IrGr3Bhfk
	OyUfjfz1z00xJCC87iJXbVSETLVBYPovfPTsCwHlfRZ4CGGGSruZSD5kub8EZPvl
	NOvR3QzKWCnzO2rQ2NTCKsmpiJq7QRkhNtUTOuGkXGBDxYOiPYg831s2+TgyAcYF
	mkVY4Lu3wuk0xhQ2prHLQ7HOsSWjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02ct7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:58:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuHfN022013;
	Fri, 7 Aug 2026 16:58:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgrbbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:58:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677GwG8q54985196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 16:58:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E0158053;
	Fri,  7 Aug 2026 16:58:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F14C58061;
	Fri,  7 Aug 2026 16:58:16 +0000 (GMT)
Received: from ltcd41-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 16:58:16 +0000 (GMT)
Received: (from gcwilson@localhost)
	by ltcd41-lp6.ltc.tadn.ibm.com (8.16.1/8.16.1/Submit) id 677GwmtU038863;
	Fri, 7 Aug 2026 11:58:48 -0500
X-Authentication-Warning: ltcd41-lp6.ltc.tadn.ibm.com: gcwilson set sender to gcwilson@linux.ibm.com using -f
From: George Wilson <gcwilson@linux.ibm.com>
To: "Madhavan Srinivasan" <maddy@linux.ibm.com>
Cc: security@kernel.org, George Wilson <gcwilson@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: pci - logic bug
Date: Fri,  7 Aug 2026 11:58:36 -0500
Message-ID: <20260807165836.38853-1-gcwilson@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a760eaa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=yN_m9CU8FlU6N_bOEtgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0XLMb4OtQokf
 k2dzuMrM/flXh7mFKNOzO6by4rolmD1gBgKDf95O6QqWsi/dGVkbxTRIGqqgf2qu/pRvtNEnYUL
 ezdqT17rB2ml/StcojGJ9o0WHLgxlbH1jZ84WnLej2iufw8UiXaS/w6IytT2yvREi+GoCO55Cmo
 AgMWcN1hxUC3l3VdIVpuZ2U1/rLqs/y+HvRn6m6ucYtMFuwmWq8du9tnNsf/2SHXGFwpBw5eOiT
 Bfson6KYGUrH5VDMzVswKK7LWaj9lH420OpMda7VjNjE7v2cylUyR80OMsdt6cGligM32E1WoZU
 f/42FQuDyPX7baWGT26SG+pPEqRlIa4KDr52LYWK3qLrBgimP5ZhIiGEFyTA+/Xjr199lZ7oZpN
 GRs9gY8AY9W7LSV/GbsPeLX26SkEVbS4Xp+0rGOQGkikSIEuM28Czk7erXzmYLynscgxSEas9rP
 avCpA2IfPx9wT2fbwuQ==
X-Proofpoint-ORIG-GUID: EZx_j4cXmZwluy1gxuwrYCEzghB1i3JD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX/xUPKpzj/G+K
 YEMkg2B130oPF0OxdtCq18WsDoPbbJJ/OmT1Eu3juapf0hm5B+EBBDhLZchKB/bT4DBChhAJYra
 B2HfJHXgdXHd4v4Knx7NZE/f/VvpFh4=
X-Proofpoint-GUID: EZx_j4cXmZwluy1gxuwrYCEzghB1i3JD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131

The checks on num_vfs in pseries_pci_sriov_enable() are ANDed where OR
was apparently intended.  Change it to OR.

Fixes: 9a7f6b438664 ("powerpc/pseries/pci: Associate PEs to VFs in configure SR-IOV")
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Cc: stable@vger.kernel.org # 4.16
Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 84e4ffe957a8..d11a64a086c1 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -132,7 +132,7 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs && num_vfs > MAX_VFS_FOR_MAP_PE) {
+	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
 		dev_err(&pdev->dev,
 			"Num VFs %x > %x Configurable VFs\n",
 			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
-- 
2.47.3


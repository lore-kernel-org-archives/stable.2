Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB73AC0FB;
	Fri, 17 Jul 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285872; cv=none; b=DpEAzk7IIi2gxEeOD7LW+YK5lN4SQRE0eIjf9P6/s2XQQMyPv7WnDRxvjyFVjLDbaHS8rTLLnLMg8gNg4CzCFVlDlqSdAwec2ApJtEPsHjgNNwB9luWqevFvXK24gJzOTlRziI/olC8sI5PvBVF4m5xXwwU3YEUQamAZxNZrKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285872; c=relaxed/simple;
	bh=0QV8OHlMHbs20KiCCXNY7HrNlDmvZ8yQiELqy6wUlbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOL0y4GHtCV3bN4A/C7ooQqsJMoDwqbn62FZgT5aTY3KDqIarQSdt46ES7ud4etnc73bfS2t3YCBANexpbKTSLvzcSiPxbtAIrir2FWszwfO3wUYsK7SSKWEdRK3K8srTM+PP0/nz7gY8mDWtpGM9iNMisFk3fD2/cz7a5+28jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0isksLf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0isksLf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3BlrB2862211;
	Fri, 17 Jul 2026 10:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9YN3M1nnkvw+IScH3bnfz7DHnHiMg
	W1MsLHE9T21g0E=; b=I0isksLf7qOmOEXvMnW3eegysUCpk0IwAFXiefFibWqs/
	600XpqXKoGhl8UtYK1yXVUTrQ1qHirrIZuTCENlmCqnx0/NLlGLR+5XJe1qlsnu0
	klTZhXdmcVLaQTa4jzykQfcHDtCQ/itFaedKPMQ891tqV0CcXiBR5DW3ToQF8J8u
	rUkPPv+41WwnPo2f7+uyutHRUXrHMGRfanC0D2OsuiksTky2OCJg1CRRzEzBaKAg
	lLuCFWLPK0ZKMI133RMbVGQGfD+Nl85wBiqzCNuP5oDmH7vBgO0zaDVy1jgGUXvE
	eVzPfDV4uv3f5AQ0T83vBzOJVhwMyJtES1+j5U7zw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fdhn0ek73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66HArBp5032493;
	Fri, 17 Jul 2026 10:57:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9hevwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:24 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66HAvNDc005954;
	Fri, 17 Jul 2026 10:57:23 GMT
Received: from lmerwick-vm-ol9.osdevelopmeniad.oraclevcn.com (lmerwick-vm-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9hevvq-1;
	Fri, 17 Jul 2026 10:57:23 +0000 (GMT)
From: Liam Merwick <liam.merwick@oracle.com>
To: stable@vger.kernel.org
Cc: vasant.hegde@amd.com, joerg.roedel@amd.com, iommu@lists.linux.dev,
        dheerajkumar.srivastava@amd.com, bp@alien8.de, Michael.Roth@amd.com,
        sashal@kernel.org, linux-coco@lists.linux.dev, liam.merwick@oracle.com
Subject: [PATCH linux-6.12.y v1 0/2] Backporting SEV-SNP CVE-2023-20585 to linux-stable
Date: Fri, 17 Jul 2026 10:49:07 +0000
Message-ID: <20260717104909.3850331-1-liam.merwick@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607170109
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfX8silSO2j5NL6
 it9WPkmIGemMuLTeN6sGg0kOqxtXqzfrEAakDh3oOyk2wf8OtO/UpW+otYU1alDUoYUMlPxUbeP
 ASjX5Nck2q3izsOARic+esbngq/o1c2SQm25IoV35WjmDtYfdtKG
X-Proofpoint-GUID: 7alL5ygC0RPWyoKnMciRR_WgFSdlCvWt
X-Authority-Analysis: v=2.4 cv=ddewG3Xe c=1 sm=1 tr=0 ts=6a5a0a95 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8
 a=Hx8qFWEpdy21kD9xy8sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfX2Iy/SGFiAEQp
 MoZjRdY2RtAVC17bzglWG8Qfr3uJ/zXTPviYQrtKCZ9JXeqrau7gDP50t7fAgLqYruIi+I2efbT
 3DRqNRYtSp6XtMG3vmP2VOlrkLRn4M7hwpBBBdEMy6uWXNovDG6sg6M9OaO2UtLd1n+WTheqRTj
 e+f8SLEfI9MgYOCJocsvwuGLS2n4Apwh7Mqgg1rl+Rzj5FVYRt1GINrbXRDLKz+To8XP3ylc2Ib
 jPvDrTym/9xpj5heVJ2tcAhf21s7KqoFq6lImn9EYGzuJOPIfkyyBsSwoyc/NJlgO/1wks5jags
 ukrdLbPYl1ylA9paAWeaGmiMLQ8Nbs6IYkxRkXva0gr+G3l0ouYwAImjpXPIAAC5MjBthXxzp/9
 VKj12KJTMpGUZz98zRkcMBqWb9/c0BVWAX70ro8k6yK7u0QqJw7nkgGQGCwb8w0SBrLHVhJcKN6
 l8/RWPKiHrlvtK6I6AQ==
X-Proofpoint-ORIG-GUID: 7alL5ygC0RPWyoKnMciRR_WgFSdlCvWt

Two commits from Linux 7.1-rc3 fix CVE-2023-20585 which affects SEV-SNP.

"Insufficient checks of the RMP on host buffer access in IOMMU may allow an
attacker with privileges and a compromised hypervisor to trigger an out of
bounds condition without RMP checks, resulting in a potential loss of
confidential guest integrity." [1]

These are suitable candidates for stable branches but stable@vger.kernel.org 
wasn't CC'ed at the time. 

1f44aab79bac ("iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19") [v7.1-rc3~24^2~2]
58c0ac6125d8 ("iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19") [v7.1-rc3~24^2~3]

The upstream commits apply cleanly to linux-7.0.y and linux-6.18.y
and an AUTOSEL email[2] was sent (but not pulled so far).
[ The AI analysis in the AUTOSEL patch said that the patches didn't apply
 cleanly to linux-6.18.y but that is not my experience. ]

There are conflicts applying them to linux-6.12.y due to the lack of upstream
AMD IOMMU kdump buffer reuse code, introduced to v6.18 by commit 
f32fe7cb0198 ("iommu/amd: Add support to remap/unmap IOMMU buffers for kdump")
so I have included patches here which address those.

Tested on AMD machines with Zen4 (impacted) and Zen5 (not impacted) CPUs.

[1] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
[2] https://lore.kernel.org/all/20260520111944.3424570-59-sashal@kernel.org 

Vasant Hegde (2):
  iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
  iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19

 drivers/iommu/amd/amd_iommu.h       |  3 +
 drivers/iommu/amd/amd_iommu_types.h | 21 ++++---
 drivers/iommu/amd/init.c            | 90 ++++++++++++++++++++++-------
 drivers/iommu/amd/iommu.c           |  2 +-
 drivers/iommu/amd/ppr.c             | 10 ++--
 5 files changed, 92 insertions(+), 34 deletions(-)

-- 
2.52.0


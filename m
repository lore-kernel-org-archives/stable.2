Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A383DDDCE;
	Tue,  2 Jun 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402661; cv=none; b=XDuCM7YVkth3meCilUCOzAWYOsbEl82RNKI1LhYHTmeT6mUV4UOfusDwdT8RJQ25OnujErPWJxprS2telSGT4jBdLfNPSTqVHgxTt2CboZCLxOhYw10zQ4PHphw6TnegCjVTxqqO+oIwPufNgRW63g6A2HG0r5uxfJKAAtSGzdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402661; c=relaxed/simple;
	bh=Rc0n/4B8uVDfQQlpuMRda7zheY3mHHjkq98GKpiJjt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbHhEgQKYrcObAZfiLR22RavSMbwx30dqNQV8z96hLRFafkRC6659qeVF9OpQ0xwtVnDfSXAKvBBeS9+i4Yr1r4Yci5MJYlO1EiDFMXukc48vEbtVN0VYFqeWsesP2OgXLPvzWiSD4YMNLoT4uPbwBPDNlXwoYqZcT0CyQ2zDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Klhn/5DK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Klhn/5DK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6526Bijq3294139;
	Tue, 2 Jun 2026 12:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=S4LhiaiseoLditI98UzQIfvNCyICnetVjBlGJkixe
	yU=; b=Klhn/5DK+1DxBrF9vHBK+olY97gio7VwfgogTpncmig5xcoJbSxtVJPjX
	c4CEn+c/+mY98yD0rI+/SUDxoOqmcfNCvoCqmawpvs8pT9jjClRs6LoUN08G9p8d
	mTrvc1uhpYsHTik0LgTGBunhed9jnIY1rXbzCoIYvH0IHMOqSJQ/bwxaaWKRgQ34
	RIrjsP5ePnqbjfA35rHAdHA0saQNXHkMtjHdOyeKP3gQ8RJnwnP5m14OKTT38u5S
	zEeomXP0mFBsEsq2m7SroZ/QFc7tnT3JDUqux5dIpmnasgV1mlZtFbekgRKCo9V+
	oizgQW92mtU+yQnkffUKRpkYKOd6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahnjuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:17:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C99lH015688;
	Tue, 2 Jun 2026 12:17:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjwv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:17:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652CHE5c31588730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:17:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F97F20043;
	Tue,  2 Jun 2026 12:17:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 222832004B;
	Tue,  2 Jun 2026 12:17:12 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 12:17:11 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, harshpb@linux.ibm.com,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Tue,  2 Jun 2026 17:47:05 +0530
Message-ID: <20260602121706.8423-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX4fAjMt5ZWUGK
 +g/5MBYjv8J5mDxNulUhZtixi9m/KODxWl8NzXe/pMHQXRyxFnmH4NfuXDmhYgLPVPOIoti4dxr
 3C/mzt0XSl1RGVZrV0vldFLag7llOhngbURMOwxgWC2HQZ8toYD7nAyWXOIdhkpUFbqV58HdjNK
 Hb8JOtgMX4wbz6208rLxhupH5mWL5hQtKDyWAn5R95Kjn42cX5dQbLe9lS82CUG4HZ8FDVLtghv
 /UG65l7eS9YfBH2IXQNOkKO6blzsYI0ayjHRrtJ9bgXtRk4TvMnsQtVmCpfViFX5sGgHWWuiXtm
 SziQ5+XbrRLw37/QxCt5FdZQygWm2tQGctZR/pjqXDbSrgG3A0k8u+rKHc4Tvkh+MWhlYu8DB0U
 Z1/XQoDcVVjG9mTHv6h2GU459aQZGNofcwbVdX7i8w00T3LdVfGf9OSuKxpHQ2mkGLTPdAPy3yI
 B4NexoF6z2dAR6w35OQ==
X-Proofpoint-ORIG-GUID: jO8XjvYul8zzxp-2LfLi0xarIwr0ep75
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ec9cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=dkYHUGA-BDwxkZPz_lEA:9
X-Proofpoint-GUID: DKglUHwq6bgocDs4W-vNGNkRjis1Mobb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116

Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
cannot be used for KVM guests at all, unless explicitly enabled on
host kernel.

Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
being used.

Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: stable@vger.kernel.org # v6.13+
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3 -> v4:
1. Reword the patch description (Harsh)

v2 -> v3:
1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
(Sean)

v1 -> v2:
1. Rebased on latest master

 arch/powerpc/platforms/pseries/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
 	tristate "VPA PMU events"
 	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+	default m
 	help
 	  Enable access to the VPA PMU counters via perf. This enables
 	  code that support measurement for KVM on PowerVM(KoP) feature.
-- 
2.53.0


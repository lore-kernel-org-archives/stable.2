Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979123;
	b=pZudIYjcrUokhVjH5I66ziCsBT6/vmrClIIbn/iVZGCuooTtyBQdz0Hl4sIWxpqzDq12
	 RKa1sxhXkL2lEDk7VmRthKKrZDc8dC/puQEcbZFf3kR6IYeBSn97L9cuKEUU6yG0bNvsZ
	 qyPIZdtI+1i7Gbzx0vvPNxJ1kYxTQ/wzVEU2M0LVQqfQH77CpfBrnCalfokqLaRZ0hMAr
	 zojBiCnGeyWh7t74r81r7i/I4jf7pMuoV2IwlZCXNKlqRKCP/lbVmPqE345C5FXLyuIxl
	 Q9FMjboGpC7+XKApCQ4sws8OYafEe2aUeAdVtIYzpzaNAgjPCyQ7irS7x/LUu827G3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979123;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gujsXkF4M2W68fWc7gnblFgKMixT7m5crNREsLfkkzU=;
	b=QE4v/lybOvawExXrOzAEKT53hVjueTqo/czJhenLo4eOIpYBiouqYJ39v57H14Pl37I4
	 uzMloQG564UV86rgm27s1gJkapglHQEbbqh7wCBJYHv/xBfzQDrN96ysu7fzyciOCRu/j
	 aljbvWJc0QIASXMoC+FhUQxhTw9mPSLJMa61EH3/6po4BvnAwFqbS7GovKMV2erSywpCf
	 CtS4kizb7Iq6JvLvTCsXuLsrMsDnfstgggGsznoJCKf2zAYOSGObtb+kum3F9WgcP0fjn
	 r2ozJeQ9pFZLDWRNCUeF5ngroAVXniHcAmjeskaNnYZewUJlTqRJhYKm/hecvxKf82A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kcc8yb6S;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A7606A329;
	Fri,  6 Nov 2026 15:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kcc8yb6S
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEGU2726891;
	Fri, 6 Nov 2026 15:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gujsXkF4M2W68fWc7
	gnblFgKMixT7m5crNREsLfkkzU=; b=Kcc8yb6SQooaZtWPtI2DRhVfsR86Do2hQ
	IqeTlLy6Mtyxujhoio/P/cAdVwHD2W56SLdBvEzJU25qicHLKIaef6ssk08w89XL
	KKHqGV94cDCJeKG2X1l9x4CbxIcsNLK34IlvHUKbsIHiUmUIEP0L7lCKiukrsqXI
	sRNsXURtaJYdCBXHQaJ7Y/Rq0c/HNTtaq8lkmg5jVOlkdazBI4PtWfZbgOe1tUzr
	DL7CN9JYepT3p8cIa5Soss2R3fNuPsVtyGv3MTa1lwxbwGonm+A8pd5I51eILMp1
	ZhSBzz0GdiTNmcuvqCkc7x6fz0GTkoTrKDvohKDjD4rHyI2bXbXgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9d71m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F51XT2390205;
	Fri, 6 Nov 2026 15:31:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13nmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FVlAT34865618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:31:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4DB20063;
	Fri,  6 Nov 2026 15:31:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCF542005A;
	Fri,  6 Nov 2026 15:31:44 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.29.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:31:44 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        atrajeev@linux.ibm.com, tshah@linux.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 1/3] Revert "powerpc/perf: Add per-task/process monitoring to vpa_pmu driver"
Date: Fri,  6 Nov 2026 21:01:32 +0530
Message-ID: <20261106153136.330165-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106153136.330165-1-gautam@linux.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aedf2ea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TkzngpjIQldC6vJonygA:9
X-Proofpoint-GUID: epyXB5ABYhY70-51HJ7G1LVZHhzj52nG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXzMHFRpg/lDGJ
 k6HL2k62E5ikbmDjpy1s4Wl5HmXNUao/G7YIezTXL6dzeiUaAmUipj8xQaYp8qVveEEQZ4jGSzu
 1RLA9q2UcBE5VY5hGpFD9po1ynN+ERk=
X-Proofpoint-ORIG-GUID: JbyDhRt6V24NASiasSb_8ZX3vESGfKlD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX9w2CbtOBnqpQ
 FV3jd6Sc80bLDBtcNR/yzfRKPJQxOA8XoHHADU4fz/oK0okOu/Fp39+6vcn4DX+4mqFj0DhC1I6
 4dL8hVbBG85czoBIp1+WTGHrpVTGw7IN89AkgfCBFa54XAGZLG3Zbs2xbsTX10IxMNSXupJc3KO
 0L2uHcPm5bwGyV+8rvMUkiYvlgqSNhnmtMjvyIOvX8TxhrmU8Xx5DiiDpBcwxxwGaAOpYK2YywS
 PoKGgmrWvTrmyACA8srdF5iAy6Vntw7nnfo5NISqcpYtXQT0hkaOAmgrPsZhpg1Aq/ow64l/+fZ
 NPqNimQ3Luc165P8e1nF660liZhGb2VcuZN8ieBpOtYHh916LuyhyQFUXm8/gLmzAwsnYl64Ccq
 hzSYC6b55bSAPy7rCwvm2iM3cYUXHvtm+PP2GcBS9C4q331suBg61AayZhRGn9Z326xgQdTwl0o
 iQw8PQJdC85rl48qCgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

This reverts commit f26f9933e3e31b2117b804b6b8932388db88a131.

The local_paca holds a pointer to the vCPU currently running on the given
host CPU. When the vpa-pmu driver tries to get the vCPU pointer from
local_paca, it either receives NULL or the pointer to the vCPU which was
running on that host CPU previously. This is because the vCPU pointer in
PACA is updated by kvmhv_run_single_vcpu(), which runs after
vpa_pmu_add(). Also, on vCPU exit, the vCPU pointer in PACA is never
cleared. This results in incorrect numbers being reported by the vpa-pmu
driver.

Fix the problem by avoiding the use of vCPU pointer in PACA altogether.
When a vCPU is scheduled in and out on a host vCPU, vpa_pmu_add() and
vpa_pmu_del() can already calculate the correct latency values in
event->count. Drop the usage of the vCPU pointer in PACA and just rely
on the VPA counter values.

Fixes: f26f9933e3e3 ("powerpc/perf: Add per-task/process monitoring to vpa_pmu driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  3 --
 arch/powerpc/kvm/book3s_hv.c             | 45 ------------------------
 arch/powerpc/perf/vpa-pmu.c              | 15 ++------
 3 files changed, 3 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index b936e174eefd..f620e3126d68 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -691,9 +691,6 @@ void kvmhv_set_l2_counters_status(int cpu, bool status);
 u64 kvmhv_get_l1_to_l2_cs_time(void);
 u64 kvmhv_get_l2_to_l1_cs_time(void);
 u64 kvmhv_get_l2_runtime_agg(void);
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void);
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void);
-u64 kvmhv_get_l2_runtime_agg_vcpu(void);
 
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..5fa6f93548ad 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4212,51 +4212,6 @@ u64 kvmhv_get_l2_runtime_agg(void)
 }
 EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg);
 
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l1_to_l2_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l1_to_l2_cs_time_vcpu);
-
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_to_l1_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_to_l1_cs_time_vcpu);
-
-u64 kvmhv_get_l2_runtime_agg_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_runtime_agg;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg_vcpu);
-
 #else
 int kvmhv_get_l2_counters_status(void)
 {
diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index bff4cfab7b94..01d9196fcb0f 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -98,22 +98,13 @@ static unsigned long get_counter_data(struct perf_event *event)
 
 	switch (config) {
 	case L1_TO_L2_CS_LAT:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l1_to_l2_cs_time_vcpu();
-		else
-			data = kvmhv_get_l1_to_l2_cs_time();
+		data = kvmhv_get_l1_to_l2_cs_time();
 		break;
 	case L2_TO_L1_CS_LAT:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_to_l1_cs_time_vcpu();
-		else
-			data = kvmhv_get_l2_to_l1_cs_time();
+		data = kvmhv_get_l2_to_l1_cs_time();
 		break;
 	case L2_RUNTIME_AGG:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_runtime_agg_vcpu();
-		else
-			data = kvmhv_get_l2_runtime_agg();
+		data = kvmhv_get_l2_runtime_agg();
 		break;
 	default:
 		data = 0;
-- 
2.56.0


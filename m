Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCD390C88;
	Mon, 31 Aug 2026 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160641; cv=none; b=CVqk7G6RVuzGuhDpAE/X6aGOYQWVlSMQckgn2pCogpvnx9xWHO/4JB/FoFljSCZsHz4I852c2eri9R+XaC+msZOARh1Huw7zCiPLwSNZkluomb1SxK9AnAvmc6wzKVzAmEyVtWkXlQG2Nbn8AYd+KjSDkDC7x0YdYAnudVVIO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160641; c=relaxed/simple;
	bh=flj3FR5YxBqKbHrDOID5f3M6eSfIG9jn0qkPq9fZGhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um4HUMnn+dArDmUyiMA8Ve+M6EFPk0u8bU7AOQs/rEb/LIa/5CVGcjC4j/IKcbzZu57HNEj6o0qZJnaqMEaV+eFtNdfUxN1lRcCU6AjIjWkxyUPKN4NdzxY4bhttSuFI4PZFeUqg0VOJ0G4nNnPb+MwIUYWNmFHUrDfMEE3NAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mUt5WZNL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mUt5WZNL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V536Xi144725;
	Mon, 31 Aug 2026 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HkRzNQNijP4OVa+Tr
	9SeyrKv6nPdtXl3dFx/07Vr6eA=; b=mUt5WZNL9ZrJc2wiam7JIONMQI0ozm/Uw
	PEem94vAckVUTgEZnmJl6dZPcPMSeug134F7QeyaI2tMmFit+ZU9/XZOo7SUrCq6
	vPSiQm87UIBc2mdIYKdLgNuqLw4wuE3XWg+87PCPZWstre3wvzICwR1OS8aZDvPS
	PN7BefjNaCNv8y89Zq+qVqrYyURAxXhsWB5LF3zc+rNTk4bA2RvcIbvs7M5cn3QM
	dlmzGL7CpL1cgXlD0df21MrzuOicGDiUHcK66XGjYLhvF6vm1FkorePaqnco+Otj
	pQfRT6Ch6S/fu/CPEv2sqsWdIY5ldPTst+Zu7sRzYRMRpcSGVyHTw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudfs41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BF2U008932;
	Mon, 31 Aug 2026 07:16:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg4c1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7Gtth36438326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE9320043;
	Mon, 31 Aug 2026 07:16:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2B220040;
	Mon, 31 Aug 2026 07:16:50 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:50 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 7/8] selftests/bpf: Enable verifier selftest for powerpc64
Date: Mon, 31 Aug 2026 12:46:04 +0530
Message-ID: <74497c6a5a1abe5cc37780fe91aac8d42e266e46.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nDsBhOlcHS0olCELRLiT7nTrAGjRl5A_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX3A5+Br2L+xnZ
 nhmxj9ezZar92OrxHoFIxIVmwlT0JljjrAlASTjAY/jXtTcYEQRIodrrYqCichZTq2I9VwQDfzf
 mg30LX0B7t63OOAAm5c5ZUODMWl27akhNORtANNQ/P0HfTkMEph+3B78NzLJQITAKSFIRr2NjKS
 gdx9x5Zzbg+SibApneyUvhwe/6Bq27jlw+Dh78H8dj8JEQluKN19FIFmDWsYwFMspEc9XO2J3k0
 WCWEXNG54MI+KS2W6b3UoyKDm8pGHFqRmj1Ctgsi+vgIdLn/WQun+/h7bAj5i4NG9XVgmy/dYSk
 /URpqY/s/V1+QyVeM6BlVfL0BglybSMu2+7LnduDE3G9n0mprFap8yrfQUXOrIJKCtANWd179Qm
 cB5PBbO8OQF1Os3uuRx9Q8DHDNeKUYMRiEzDH352OSl2wmS55ZulV1wmsLedDfvpBhHTCeHj72X
 mWEfWounmwz+DQ2ng8A==
X-Proofpoint-ORIG-GUID: nDsBhOlcHS0olCELRLiT7nTrAGjRl5A_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX68Zrc2pTGhaP
 qMy7CMhhQkK7IqzbgvQkcz8LTJ0cvV5GUXlM69YOqHm7WAKkcH6PCwdGmj6c6EYAenU69Q3nNMs
 /46KsrAhabDm9tiAUUuiwAX4gtQ8VQM=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a952a6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NDAN3li2bPRXDg1MUZ8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059

From: Abhishek Dubey <adubey@linux.ibm.com>

Enable "__arch_powerpc64" specifier in verifier selftest
for ppc64. Power 32-bit would require separate handling.
Changes tested for 64-bit only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index b0c441384f20..365008d1ed40 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -159,6 +159,7 @@
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
 #define __arch_loongarch	__arch("LOONGARCH")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3ce32d134e2c..01b1420097d2 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
 	ARCH_LOONGARCH	= 0x20,
+	ARCH_POWERPC64	= 0x40,
 };
 
 static int get_current_arch(void)
@@ -392,6 +393,8 @@ static int get_current_arch(void)
 	return ARCH_S390X;
 #elif defined(__loongarch__)
 	return ARCH_LOONGARCH;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_S390X;
 			} else if (strcmp(val, "LOONGARCH") == 0) {
 				arch = ARCH_LOONGARCH;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.55.0


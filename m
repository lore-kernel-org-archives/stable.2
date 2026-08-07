Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF14746CF;
	Fri,  7 Aug 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103029; cv=none; b=RjZv+7fR82gwDW0AhYQLy2ZmuVj5WAn6qjSaBTOOYKIwwbH7DZcSPlKykRfsvfwXrQJ5fCFMhn2funiACIbqs7aORDY9XSFegNCUYZTOOtlD+ZbkTOSdamOoLoX5aKKLAWwNIVRndNDd09bziogi1Nc1Pd8Ws8vOEgjA5CKjZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103029; c=relaxed/simple;
	bh=z9qqxDV7ImoqqcjGh2qkwBBLGoN/0Cr8ldyvCd3A+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJA0aktEuhY+6hZZ+qzzpzQNklYozBYZTDbPxZxTo+Qz6pPbifON6ArjEkTvbkEbNN+cgHI+KdvublgiSXRUA4FthyIL+8jyLArJ/5JMtknj70u4VKcbtV3ZiLnQqbcjqWcCAtOA6TX4mvrFZpjjWilNfe11JHX75D0+su4jjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j6JWB1pG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j6JWB1pG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hi2E4161684;
	Fri, 7 Aug 2026 11:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bawQDqfFUbZVrEOCe
	OQPp+yI9YFgz9OE6kKs9xAJGbA=; b=j6JWB1pGVMBywhCzoYiSnEnISQ/Vh1GYB
	c4+qmzw3fiNedEHVy09EBYtX/ORWI+6Memru53Xc3qWLNj0eDHP0mgwejr1ZMOuY
	LpLUKLRZmucbRoxZWMy7395NqyrwsNr+U/RMzNWYRvIXjOEjLVgB+Ds4tYYH5LsZ
	1KLcqVWZa+9wJvZS2MgRm9MiTcnx9OyYYBJeFZwnoCCv0jqR3dZiQHtptpZD5+MI
	3BYzNaL0Or92FqTUth/+yQ2XlOVQPksAS1nqolF/O4Alz2VC1EwQ7mXQ0Nj+AKe9
	0aRMJ5nyITuGv4B4yC1IEVjHzTlrfWQB50lJNTFYqzd26W7nm9M5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfQ1M018528;
	Fri, 7 Aug 2026 11:43:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwfkn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Bh6dv25494038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F034F20043;
	Fri,  7 Aug 2026 11:43:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3001020040;
	Fri,  7 Aug 2026 11:43:02 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:43:01 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 4/8] selftests/bpf: Enable verifier selftest for powerpc64
Date: Fri,  7 Aug 2026 17:12:39 +0530
Message-ID: <c5f1f543c2b98fe1ce30c42d97b4e56ca293ce02.1786099877.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=NDAN3li2bPRXDg1MUZ8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXw8X870tSE9PW
 u36bQPRd/kx3uFKwesRTnWRI+/OhLJHbYFNbAPgR2xx0ATGrVhtQxpSKymRZHCBynxCON8JbqWO
 cv3qQHxV/Pn6vV/k9rV4dsGZBfTtmoM=
X-Proofpoint-ORIG-GUID: fFAPs-47WntlCDF6aL3ulSmOPlhIVlJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX8p5xFW9olKpf
 Ti5J4Q2Lmccxtw8kdHpOXZrGVT7n7jEwpewsnhKryWRYYvQ2By2MLvAf7c1R1QBME7nkIHTf2d4
 HQEx6vSJeH9EWSn3aowJTnWEfbu73maSoJHyDBEEe3w76xiBUCAe60DnWeopP6P0YVqVfLA8ByM
 iYZbLOXIa+tYutlq9k3aOAM0SNfoDzJh8qF4L13NM/MpYyyVd1PzTc3KfiKxnsKPbc0t3QXdRSF
 npDf/tWxR+nOH9gkwMEgllXEUUDKLLF1DiecTKpzlebhO37N95v0gnjGVbRB79pH17XI2N9Kk1m
 8luqYA22W/Kk/mFIxPtuPNZLQIUIf4lD1nqSWhhRNNfdjELO43Rxe3AkO7R/byQspP6r4kWeYXt
 wss9jvRz19n+zpl+FOiaufb/WWn4yp6JVIJ+RDCeCalUVKRq2sbIDG58GKqQWmGYGPSbS7aPlmL
 vkQ+TyVk7nV4mv3GaGQ==
X-Proofpoint-GUID: fFAPs-47WntlCDF6aL3ulSmOPlhIVlJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

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
2.54.0


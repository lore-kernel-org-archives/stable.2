Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1B319848;
	Thu, 11 Jun 2026 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177994; cv=none; b=jhQLI+vzNAOx4wcsv+O1+yoFacrBFb/6om+6Dp5jp7Yi1BXCnsWHW0RbAfCLOI4p46+/q6JPLKVTL4oLrP0ZDZZcT4O4XykdUWZjSKpPr0irtTjhih616jB5KCYjCnkENSTw9joVUz8czKfDETPLZ/MejA055SGvFhsKX5uGLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177994; c=relaxed/simple;
	bh=A4H35fie0VvB/GeCzZsmatNMifRW26auYfYXyZExmww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLHr4zOoHV9LPm/X6bBSwjCgnAZHzqWnWMyZlg2ZNvpICfbsiSX6i4YwaPTIJmfypaIET6zNM+6JFcb2JI2brERxpewFvl2Z3KkjJhPs46uQvobwrd7Wz74E6HtYM4AmgbmHyl2aCzHrOOtLQYEXKjm1phF3M8PRFV26rilhRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NpKUsnT7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NpKUsnT7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3LU3872820;
	Thu, 11 Jun 2026 11:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TIct3NHUYaBH36Fj/
	LbbJuo0SwZOr7xZ34JrF6Ab3dM=; b=NpKUsnT7vHfen7dFBdAhPjc0LIAENZwwR
	K12XJkJPcupfJWvy64g4Ks39WSLFeG6mkFhszr4dYSd82XxCcH8RUyDr/iAXVJy6
	4KThZJ20sSyX4A1ln7PjN+3X+25/XG9MpXh+UV3Apelo0vazoeZ7s3fqXVHRQJkn
	Zotm5dwzD9kZyDKHuJJvNnGOW7ilmWVxueJfNWeKD8/LN49N0e6s10f/iq4SwFpt
	mq3SEoH9uboGsz+fa3p3oaAY1KNZR4IJem8qOUNk1qqv/wFCfyWO6HtGDgDrxoDD
	Bm3RZz7WQjBfpj9vAnw8pzk3jzp7Gca7y5lM+6I+ixhaxbOfjJe+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8eu5sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBYjH7020797;
	Thu, 11 Jun 2026 11:39:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08tybv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBdUtx51314976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:39:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7AF2004B;
	Thu, 11 Jun 2026 11:39:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA34420040;
	Thu, 11 Jun 2026 11:39:28 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:39:28 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v7 4/7] selftest/bpf: Enable verifier selftest for powerpc64
Date: Thu, 11 Jun 2026 11:38:23 -0400
Message-ID: <20260611153826.31187-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611153826.31187-1-adubey@linux.ibm.com>
References: <20260611153826.31187-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX6ZGCb37J+aDN
 L2r50aDyvszu2ZMokn3TsSHisN5MLlF6lLnxU2PLE/mVeu/0MN8JIb5+ILoTWPlBQhC1xDFP55w
 oo36bfpiilOf835huxOHkoWw8bBEsQ+SAq5FlM1tYFnIr3BU8lmUNO23TEbuycK1KH/HrrQHcKD
 5Mvm2TppMclV63Fq633Vpi5I5+jIPIUxpzCOQck1+6YNLKOlonxoCv7oCBvNKNMckL0q8RK/8/O
 hRB5GvcVxbX/r2QKKqTS8ifmX1HVdZod6eLLHE93FU+SYoML9ImXcnF6FUDw691DzI9vLVElVZ7
 3Az5ANZtMiw0KAujy43Gm0h+doXXH4+IW3iOT32KV55kgFaEkZ08UAkaagv+J6hfpjPK1H/IMaw
 +VnuUCwReCpMwiZPo3LRjfPKF7pmN3bIH9hoH0nySwFbV+fIq/+AJOhvjgACkS3gxGCdkex1Nua
 8MMEvAuqJoxOFN9m3vg==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a9e7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DRl-xmwt84w-93Xc4WMA:9
X-Proofpoint-ORIG-GUID: ljPeiaYy8boMQLu73YYNxrJgEsAe_Q0l
X-Proofpoint-GUID: ljPeiaYy8boMQLu73YYNxrJgEsAe_Q0l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX2UYALnhhI+6i
 nZyyu6iBzbXOFUjlneyPfx0LSiHW8tejUnQR1sDWHHqQcUB25dXc8dH6bnNu8gq06pzA41jO15t
 svYRRpNZdcXs3PP6dcsZnue//WDPeEc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for 64-bit only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 9eeb5b0b63d6..cdc2a3de3054 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -158,6 +158,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index abdb9e6e3713..d5589355ed9e 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -377,6 +377,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -389,6 +390,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.52.0


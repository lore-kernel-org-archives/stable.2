Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C553C3456;
	Wed,  5 Aug 2026 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910073; cv=none; b=DdRTRRwraBgQvZv7SIAEHX9YRZneQWy2A95rPPGtWxVHNH3LBcRAm8HYOpWmAUxaff4koS+QrOxuYAh8jwii+Igrte2iH+a1tNmaoXcVm+idKJLlamIl7AzvSYCMuOetGZhdw9+aiMj+MyELbXuP2utcY/qGE/VfyOPUysjrj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910073; c=relaxed/simple;
	bh=FxaHpxTAZ4FBrmHyx5ulY/dKpi15WoVCRMAp4MtugRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx9NlYG5OTBHXYmKRtIcAQqxvgI+AoAd07+MbCNxqis0jf+EmiZmCZ+uGcla1Hd0V8JL6Hh41g1v62wAWPpFFcPTjxHEt+eWvPMaDYoSjy8SHhuh4ClXEJGaHMrSoh1ANCl/v2Z+Kw/ba+L/chkuWy/li1sHPREbiAvMYOZIvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AOdF2Bph; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AOdF2Bph"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755lpTd2907982;
	Wed, 5 Aug 2026 06:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I+RA7KY5IOUgnMzNd
	ijQCfoybP1WmuJwKg1AdjWNKQg=; b=AOdF2BphAqNOOQanHcRyPMWx52f5uzyjq
	3JyIhqOXL+3/QTTUSWkz5yRUcgQuBII6Bf/yoMS3GSkV8Pxzy+2P8V2zpaMozE1f
	Zl/gZoKpgzxjqzhXl1bSQgQ+/OJ5XV2d62sOPfusIVF9cWIZPUU3d4OR51U96ZUr
	yXcIouysGToFMw8e1GkuTQlKFwgdtv4F8aSNVZShD9Aepb2fb6t0szQ9HocL9Ivn
	82s+xEFekxkMr6CyOKIi9pNowCxAERjm5J7Z5B5hS3yQNGtG1oCSF1pUzI7e1de+
	M771cQL5lmlLcJ15Eu7VtQz6yx6xGa2vRdJkTRknR/cGmSzxk35Tw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hsbdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6755v2VS016584;
	Wed, 5 Aug 2026 06:07:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhd674-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67567S9533423688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:07:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 189C520043;
	Wed,  5 Aug 2026 06:07:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140EB20040;
	Wed,  5 Aug 2026 06:07:24 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:07:23 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v10 4/8] selftest/bpf: Enable verifier selftest for powerpc64
Date: Wed,  5 Aug 2026 11:37:00 +0530
Message-ID: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX5IPISUaJtzQf
 8xruDyNOFL4l6Dgw99ugH42aSKNbvII3TD4TDj5R98fXRXD0C+QntrS9Vsu0j1pIywysglrqivL
 3BVQh4i2Z4LO4D8S7y2OMd0+aCIY6Hg=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72d324 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=oP-8I7BoiccQLkM8JKEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX6+8/Ct+0n1ka
 Ojv8MfOp/6ZUYwg+G0tEhAIsVvpRA2UbVHC+Kw0iv8GkfeGZu+9ud9ZNUNd+OTWZ5nc1S6mNSb5
 CQmozTtkSS4TZmRVJmgXIdH7hrwWzcUecousERRJGbdGJ0RZ6JEQtfep/lNNTwdHp61rzvTJT6K
 V09KMtCc6lxoRrHemBtp6IO0efS0GBLuc/M7GTduayB8GSxVHwMTwrq+IwlbNbedwCoTbJh6klN
 lDj7rPrcnKIex4RBM/8BsCWQqJ4qspW4ivXcLeCtgASl/AYS//t4lJXWDIvPVOT8zOn2c9zFClf
 tgVgITGA7oNE0sl6kfpC/6TFNce9n2fUODwIZDD42/f91+08N+fWQYsCQJkQYvIUhK2Eh2Az8lq
 Dr5MZIOtz7YKgP8Tf/u8GZ169vkRbT37g6Ljuy+VafTgqynLr7d+TUT5k0E0SYLoIknaLpPs3Ha
 Os8HVRgutRvQrCJx0Ng==
X-Proofpoint-ORIG-GUID: O_NStDTHLAEiDoud47NOcIaBovFXjTg8
X-Proofpoint-GUID: O_NStDTHLAEiDoud47NOcIaBovFXjTg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050042

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for 64-bit only.

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


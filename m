Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE23491E1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815165; cv=none; b=Ws1aURao2AgRwBsvZO8z3xqF6kYdVEVttIEg5C7Bqv0xXNvfDTn9OrTisbqwGSGbnMrIZLKd5sEN8bj41R9EgdyxOIthbg/6UvhqtWK5WEuC76XvfavoiwfbCIP27pfFtYOmjwzNVdNOklipwceQwqNfF7XP14Vyv2RyR9ru/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815165; c=relaxed/simple;
	bh=9rLYG1gJsinzpYSvBZuHOeFPMTgjam1YoY5VVfQFVGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H19H/DBhdrF8giNFFB8a2Vm4p1V3cCY2VGLrSWxoJBIjBJQuKDwNt3lQME1MIsWKiXRMpbZ+kp3rXaIRYM0VJAZc8o4AYKkND90mkz32umruo6IOMNVnRYxEVLuXQS11QgRw3H7nhLusmIDNaASsnhcVeM4DwOz+Xf41VE7kDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=C3fzPY4n; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="C3fzPY4n"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsgdU3939561;
	Thu, 18 Jun 2026 20:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ls9nTPmrQlx5Okf2YFflw7H2OCAams0lLg1U8EMSNTQ=; b=C3fz
	PY4nlMFxKsAQOUHi8fCxnkt5dR9LpXAPU0kzau2aRHOH/wk0tZjthszOCnPnbMNs
	uA4f2o5umKLMal6/6aEBVyPPBq/b07Q2M+sBriPx+Lc4P5xl8O7wX0wDAcxRyb3z
	3R/SvmUucYR/94OlI3U2y15jolC1HhFCX5QcxChisqwkIr57/Rxmh6+TegD5QpFd
	ZnYFIKC6l29Eh9HKRR6+plM/73zc0p/FVEkkheGh4rOfL1toWCTUSTrMeCiDfNK5
	OmjgtttLOdXdzoVa6Wwx8Zn2mpR8CJOw2yb4PAln0lL8SakXpBF3X2yQJ8z0siYq
	rvfjsUSG4atr3vhU3g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6v1ax-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:13 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:12 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 04/27] scripts/sorttable: Have the ORC code use the _r() functions to read
Date: Thu, 18 Jun 2026 16:38:42 -0400
Message-ID: <50048eb4cf1919493585ba6beb29fa8822c1b37f.1781814096.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a345772 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=wzDLvsUvY-im7TRT:21 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8
 a=pl6vuDidAAAA:8 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=GGcVmEvbB2xf_gawNiMA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: KW_bQPt1EqfVdZYm6PJ1x0FibWPR-0nR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX1dw7VQr1WJyt
 Pn9U+UHAPi+84RzwcF/ZCGEau4NUcUeynUFSyl8RxYLrT0Rq/oXT3OvSZE1y5WZtHzEU04Ug/2S
 hNUvXyr7pjPAtpVgBB3KC6fHlnCDWL6CPPV+RgNwafjPO/BxsYsu
X-Proofpoint-ORIG-GUID: KW_bQPt1EqfVdZYm6PJ1x0FibWPR-0nR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX6c9dZ3sQD1pL
 BEuVhvDqJdOJk/eeUO3Cx45na5pwn8T+UHE6UnrJ3nK9qKJi5xf7gffpFR7mKtzXIDd/jHqUVvq
 1eFLkx73Zn9E+DTuoJibSKo13S0HDwkNm15fKUMCyFMCJXr1u2a0naQEKBm830q/L77AghbAHpj
 wRu4KZG44AtCqmFl2wUlotQUxkK5hxekbrrrG7su2TnZ2hiY7mWj+e17n6WzJJcuNul3MTvX3hH
 Ki6oW2IB2VHceh2ccwU/7kNx1DCSNBvkoRVNLPL5brK9Rm56Yb0+qQT55OoTGvcUnXLEzaTwi1f
 Sf0yRPIX9w3jDCXcJwUrDvWPqBdguQyRKftWZYn3kesXAETwn1Z8F3BTda4LcVz9fkUTy2zEb5/
 DxHgrEdz2OwS6YsL4DOGf7OJXvs5Ge4VPM24+Xaol7a3Cyx+l+T45UucLmh1WFs+HekpdOfgmCO
 ypWZIo4QzeTulO7qA4g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 66990c003306c240d570b3ba274ec4f68cf18c91 ]

The ORC code reads the section information directly from the file. This
currently works because the default read function is for 64bit little
endian machines. But if for some reason that ever changes, this will
break. Instead of having a surprise breakage, use the _r() functions that
will read the values from the file properly.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/20250105162344.721480386@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 18d07fdb2..58f7ab5f5 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -299,14 +299,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = s->sh_size;
+			orc_ip_size = _r(&s->sh_size);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   s->sh_offset);
+						   _r(&s->sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = s->sh_size;
+			orc_size = _r(&s->sh_size);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     s->sh_offset);
+							     _r(&s->sh_offset));
 		}
 #endif
 	} /* for loop */
-- 
2.34.1


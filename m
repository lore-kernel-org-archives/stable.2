Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F0318ED6
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813786; cv=none; b=LKJs4OVknuado+r20LtLBUlhCTI3im4PSkNErwur6ZiRSK2jOsUKPGVWRmPAZjWExsd7XadnVVn0pCiEVlm0VS+XnrDqMrgYRj6EVnulLY1cXHmcSTZvjSZh4Qnq/xd8/pak+eIr8xBC3IyN2+WkwY4i9bX83g24YS9LB59VXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813786; c=relaxed/simple;
	bh=MiGzbL64EgQoGNFUhyM86lMW7AfbMvle4UjOtPs8lyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPSMdivCSCFetCpi2yw9LQqzw0ZRD8W631a9jdIQ7NSlPfLLysCmpxfu39iNWtjyiowbQUK3BP2UFPpqsK2AU4vLUf+2s7Cb6+ssPMNY2Gspmxdndt5Q5a22LxKFWZHLMhdsUCCaLASREDrBdrxHoS3giTCUktmcbpyjDLK1H1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=A6r3W/pr; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="A6r3W/pr"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIshUl3939656;
	Thu, 18 Jun 2026 20:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Aog/mQrojLa3qbNWmiKugv18PMDZ8EfUFOQhdA25gl0=; b=A6r3
	W/prOb3W7/g6dwCxp4O3sVebPhr220r6bW9lB0rxpTKnKjMhYU1s7tAq62jwBrtx
	3TN6tF9MKXWoyU2L/r/XDk7/vrhcJyiPA8Fb5of6GQ69ctM/aKgW/2rqxlUqCZX6
	aEqA6cBfB6ivcpyGdBnC4vu77+okabRgiUzKpVNM/P3FPvIknCc7fhPQq5KjGjxo
	xh/4K7b2+ndAOqDafi4VXmzi/eK1yUpQ/te78KBOro3vIbwN/0hO70NtlAAsN6xP
	bc/R6WsUWIOUurVg0tYN8DK5tFkoUCq8Llk6ZT96NVpo8zKOwAOKeeIxfj+gSc2D
	hw/tGCvf1eF+MoZAzQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6ux1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:18 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:16 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 24/27] ftrace: Check against is_kernel_text() instead of kaslr_offset()
Date: Thu, 18 Jun 2026 16:15:38 -0400
Message-ID: <0fb5f2bc351b85c4658cb247b9dc2f79b927d5ad.1781809982.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a345212 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=qNABUOcEAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=VTywKIyS1kG60bcvyasA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=Ytm653ucTKQjCvbzLygB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: vwnVwpz1blCJ2dwIjE1jXBcHnz-pkBxT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX1MWct0jkHkM1
 h7YMAysc51q2q1Wtu2qJSGxl+JD9tPbyLdOdkzxoHlN1bU8GIdNtHnJ/VfsiQyZT+CZx6ft8aJy
 FdQEcPwW+Eg8q2SL/1RRZ0oRhxov0p3vLrehV/QOY40lVyxgH1F/
X-Proofpoint-ORIG-GUID: vwnVwpz1blCJ2dwIjE1jXBcHnz-pkBxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX1wsAVMtbi5eh
 5Cxu1G/aDscumbXY6XluJpMGIryKujWiEWt7mLJz/S4KlqCFuYyXy2NFD+5UaWVP28AiJDMN41b
 HdR3WpBpu8FecLJPSeHrPAGVJbnhgunXkzgpMQe2zXaRkSn7U+g4/ZC0SWwwSNISA2o9z5aUyex
 drWgI4mIpTPMS1+rqtmjq83Ko3fpMDGlVXIx5wNBGfrwWlen0zPPg2E9XqRgVVL6o2ArQad2Vpq
 TYWUKCI0f5x/5hbA/9dQgvWiI2q8R92GYoeA1+hHURe07EkicXUEiu9hFHpS5k7nsmDxK85966F
 Jgub0TtNrueJnIgH0CLBCi5nsC4l+JSwRTJi72dB2p5d/ecAjkHlPVH8tQPzsDoirbsONUqaKBh
 ZeV1F1CxvDKaRfm+NhnzFTMOc9uepGMgXAjoBnIbsG68xDSR9vqyfYPX6UcEX6P4KH5e8340CAY
 uJ9TIb1v1sGlwdnwacw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit da0f622b344be769ed61e7c1caf95cd0cdb47964 ]

As kaslr_offset() is architecture dependent and also may not be defined by
all architectures, when zeroing out unused weak functions, do not check
against kaslr_offset(), but instead check if the address is within the
kernel text sections. If KASLR added a shift to the zeroed out function,
it would still not be located in the kernel text. This is a more robust
way to test if the text is valid or not.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Link: https://lore.kernel.org/20250225182054.471759017@goodmis.org
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250224180805.GA1536711@ax162/
Closes: https://lore.kernel.org/all/5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 842e57498..4a486f745 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7051,7 +7051,6 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
-	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
 	unsigned long pages;
 	int ret = -ENOMEM;
@@ -7101,9 +7100,6 @@ static int ftrace_process_locs(struct module *mod,
 		ftrace_pages->next = start_pg;
 	}
 
-	/* For zeroed locations that were shifted for core kernel */
-	kaslr = !mod ? kaslr_offset() : 0;
-
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -7117,7 +7113,18 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr || addr == kaslr) {
+		if (!addr) {
+			skipped++;
+			continue;
+		}
+
+		/*
+		 * If this is core kernel, make sure the address is in core
+		 * or inittext, as weak functions get zeroed and KASLR can
+		 * move them to something other than zero. It just will not
+		 * move it to an area where kernel text is.
+		 */
+		if (!mod && !(is_kernel_text(addr) || is_kernel_inittext(addr))) {
 			skipped++;
 			continue;
 		}
-- 
2.34.1


Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47A30E82C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815184; cv=none; b=GBeXbyxMJXomiOS2btrpufUauTjeAYnfL0rMq6+SwuOuQHLBugV/ElT9jCQm+SxsxR6sJPR28kPxguMytO6h7NH8fVMsqre8eZAg4pGou8AgWv+p2TfEbm8sBzf4Ckt+b87d92X5NeVxlu1DRWFGqYfv8u99T8OK2EuVMUQP5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815184; c=relaxed/simple;
	bh=elIj3RIUnSTQj9kfsJAAbgG8W0omgcZ2LffJpdNElCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAhOPt0iS5XAX9c2ql0Ep2Qo0+ILFG2aDEhP0sX64WYEOSy5JUgHdxQzl5hyuaiIiepQlhEZfqHduXR/Tbgbk8dnVLXHOqOEnTrY3ZYqRdGeGaApZg8kpwAtmini3cML6rArlxauKTz9Z8DohvWPP5Lh7stdirTBJsioZhYes9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=h/2Xv2q6; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="h/2Xv2q6"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiE454006057;
	Thu, 18 Jun 2026 20:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3z1My5duZQ88RrAhHdQac+7iPo99PFXt1Fa/Fh/glBU=; b=h/2X
	v2q65/x0UESoMckRh0uwPobdfv7lmjXGIBqpauUCWDDRObug5x5dHFqww0+gWVJb
	PqqI/I9kxeyRFESOMXcCKK0eicpFqKZ+Y/UiOmBw4+Nan7Vocv7goJRtD+nRYlal
	eN8QuHUj2VYo1X/MviVk+5bF4uJ3BbglEqeT0nJAEhttTBP+b2PfXc1YKJ0O/kqC
	zSvoYFXTl9/GR0fWRrETKdZf8u49/Uww05pBQKM6ExzmctTYcy38gM/jRO/WArC0
	wowNJ6ZVMfpe+pZu4EE4fDGcbmOp5sREmlwCtkJ/PlaYB9B3LR9DmX3YFD3oDiYn
	U6DG9pP9wAI8SzJ6DQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg806-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:38 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:37 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 24/27] ftrace: Check against is_kernel_text() instead of kaslr_offset()
Date: Thu, 18 Jun 2026 16:39:02 -0400
Message-ID: <de31f6ef301f7a995eb440efbb1c7f716b4e2aa6.1781814159.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX3DCGTaDGkk+b
 LRKc25SG/X95fObNFCIqJ7w7jw6Uh054WUGZYp8dnBETtCkyTNigohsD2GQtqzRLIqlHxlh/faX
 9IZXLuEceJ3llouizKV5Rh4Gcrm2+7o+lUkGb7+f7P/2RqQ5Fl8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX+lhR6ffRAFvQ
 j2QJoBQBhOmS5FhDsm0Z2YDrO9g3+O5BppqWcDfUCldvhY3u41meijU0OBDHGHg1f7sshv/DojP
 xQ0oLUS6gRltWbYsO5iLe7qLxmaIx3Iyu8Uq3hu8chfXDnX5A/3FI7URM4pNdaR3124fg+Wwqqx
 1nKNCEAOqsbGzGyrb6Kux3iaTbjO+OhlIXYNRZt5VDCVbKjJEtSHCB/JtAAsvIfVb7ykd5vtW6P
 ok2PzkDGQf0ckjNB1Fm5AmqqhOF8wYK24xB1vmKZh9DB76CJxEZ7af8dreWTXwtF0usL838f9MC
 2R5K5kbSmpIEUM8ZNHMSBug+LSBQyU84p9wQKbFIye7o5fVFe/bDMoEvFH7v3k1gZqj9DPtwh23
 SJLxq/mc3RQA0kriKrLXTQ0cbMKAvA0O0VSYwKSPwHlIEUJLwt15K7xCder19BIawcnfwxE8fW8
 s5vMoevTzm6wUGHhCQQ==
X-Proofpoint-ORIG-GUID: lTGkvxKx6tIH05UecROgsv_h15CAL14O
X-Proofpoint-GUID: lTGkvxKx6tIH05UecROgsv_h15CAL14O
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a34578a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=qNABUOcEAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=VTywKIyS1kG60bcvyasA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=Ytm653ucTKQjCvbzLygB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

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
index 6635455cd..07a4cbb7f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6528,7 +6528,6 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
-	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
 	unsigned long pages;
 	int ret = -ENOMEM;
@@ -6578,9 +6577,6 @@ static int ftrace_process_locs(struct module *mod,
 		ftrace_pages->next = start_pg;
 	}
 
-	/* For zeroed locations that were shifted for core kernel */
-	kaslr = !mod ? kaslr_offset() : 0;
-
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -6594,7 +6590,18 @@ static int ftrace_process_locs(struct module *mod,
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


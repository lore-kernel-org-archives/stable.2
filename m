Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA132FB969
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813780; cv=none; b=eeOPFxaVlqA5dQWN71HCWrD12TR/EmCydWcC3iYUp0qJWOQfJ9FD3b81Vh0kyDtHWVwVFCETZqs0Gs0bFLGNlZCBvAXgW4/hN/V8mXO02Op5ltkJOWh3u3ItPRV2mkpnFUaH8hl8taX6XLRLRS4wqppRIImmzFKxPeXFLZ1A6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813780; c=relaxed/simple;
	bh=UrKHqv4yhYwgJLywExwXhxhJuRuMLG+wPhqjQWmH9sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvVPilSlL09aUk7NNDx7Fqc54MbQ+QzRIuvuXJDwHFi+uRPXlzPLbT5N0OFWAngIMHZVzixg6I86aXW9Nhpit6aAX9oQ5ffP362XTK5o8xtwlSW1Zdn+GwI1vg6oz/6cHDGKLkag4CpanWn4WzjXM4ix+wnjDhwajse7IX8cFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=TOL6p/eJ; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="TOL6p/eJ"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsrKY3988528;
	Thu, 18 Jun 2026 20:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=qy+ssjGM97QFC2e5Vaxj3n4A5sPOPQZZx8xM91JBTpo=; b=TOL6
	p/eJL/WzLeSMOVo2CddkTMdhC373pMWInHuBQ6607yV2Y3AyoB5er8eXRndjoMh1
	mpptV25QxlIfbKwA8p1UttDGzpy2YDzUF4h24Dnu8EzaZ2rH7x27uP+3xYP5+pmW
	zkp7Bsq2JWBHZXAWHI551FfeWc0FU96hf8Wktdzjt8GRhkT2JvREpfFm+9sXuRNv
	ycLrE9238QJ6PcjfFR4FdLk7oJGtT6Ag+ypxHbOvH+Dl8SaNiQmZRkUeDe7a3yG0
	W0ONio6UkSnFHtApJWgEJXG4D7iAQoYGsSoP6e7CiQSoh2u99A/1Hfe6Ek3s6TMx
	6+9ltYPI2sOoiTrPoA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uyve-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:14 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:12 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 21/27] ftrace: Have ftrace pages output reflect freed pages
Date: Thu, 18 Jun 2026 16:15:35 -0400
Message-ID: <5773e8c00a533a29c89b42522a16f2742b97c3af.1781809974.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfXwkYVjUPRIbK3
 0PzrikBU29LcGF0C5JgYMiJL11kRYgtGjn+GgeVl18vRyZRb5yqGQIyj2pId4sG7OLRGvhs1btR
 PvTU1COrsY/xgUnxShSKBTM82IXfAVrSunE1OrLWT9UJbtf64wanFCRqQsMpdMJPy3TLyTeN/mK
 k9JfuSSlqjits2Qyu6/NNvpBgkYaMSsK/Zh4VKNikoDnJGDwpa+mYScLBBTUdJgINMyxAMrokxg
 UCbUqjPQlqq6QUbOfCldilX+CDBxBNddojigJUcpCJyVFfKQrztFoBI2wa8A547BfKkh4w8n6Yx
 BDQ4X4CBgWUvX7lAVnf48sATbK978OHCYQ8lcM68EZOX/VJ3iS0VGgqzrEPtAYRMhn6ppdqFR5D
 O0zp/y5KBg6fuj5oluGIf9ophI8a77EB4ysVPZIbfmdVKevCeMg+KvOXtM8vhdOvHUZSby77hHO
 /EyoUQLMB+2GniCA3lg==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a34520e cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=XgXTSPbbcnNvTgzPI4UA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: W0pxDoYHOO146XwtffY-qr0JSce9ESS5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX63X/SXsyS0y4
 z98ss28VJ76X6aTDumfQQvVMHOEGrZ8MhBx6A1CMqHPM9KmvK2f3a8rFS8Eo1GFuI41iCfwlkub
 jaP46V69lZQLAnrbSFAfQiQkgBseJuqhYnaO6wIVEbyiKhjwFd5d
X-Proofpoint-GUID: W0pxDoYHOO146XwtffY-qr0JSce9ESS5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 264143c4e54412095f4b615e65bf736fc3c60af0 ]

The amount of memory that ftrace uses to save the descriptors to manage
the functions it can trace is shown at output. But if there are a lot of
functions that are skipped because they were weak or the architecture
added holes into the tables, then the extra pages that were allocated are
freed. But these freed pages are not reflected in the numbers shown, and
they can even be inconsistent with what is reported:

 ftrace: allocating 57482 entries in 225 pages
 ftrace: allocated 224 pages with 3 groups

The above shows the number of original entries that are in the mcount_loc
section and the pages needed to save them (225), but the second output
reflects the number of pages that were actually used. The two should be
consistent as:

 ftrace: allocating 56739 entries in 224 pages
 ftrace: allocated 224 pages with 3 groups

The above also shows the accurate number of entires that were actually
stored and does not include the entries that were removed.

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
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200023.221100846@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f0d05e08..5aaa920bd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7050,6 +7050,7 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long addr;
 	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
+	unsigned long pages;
 	int ret = -ENOMEM;
 
 	count = end - start;
@@ -7057,6 +7058,8 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
+	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
 	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
@@ -7168,6 +7171,8 @@ static int ftrace_process_locs(struct module *mod,
 			for (pg = pg_unuse; pg; pg = pg->next)
 				remaining += 1 << pg->order;
 
+			pages -= remaining;
+
 			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
 
 			/*
@@ -7181,6 +7186,13 @@ static int ftrace_process_locs(struct module *mod,
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
+
+	if (!mod) {
+		count -= skipped;
+		pr_info("ftrace: allocating %ld entries in %ld pages\n",
+			count, pages);
+	}
+
 	return ret;
 }
 
@@ -7835,9 +7847,6 @@ void __init ftrace_init(void)
 		goto failed;
 	}
 
-	pr_info("ftrace: allocating %ld entries in %ld pages\n",
-		count, DIV_ROUND_UP(count, ENTRIES_PER_PAGE));
-
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
-- 
2.34.1


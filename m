Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD433491E1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815181; cv=none; b=thp9Shz/FxforRxCgsKZpoXjO6cZsLidma22UnBAFykQlYxZQ7L2sBuWVCUNpRkY0xegU94EG5+7Eu9sAXT1p2lcorP9FJHujAvnuLn1vC7GQdWJH2w0CBHmlNimNZoGYA1gGs6Rnq4FGl2pmiA8RGFITC+yJlBcXtygqDCyqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815181; c=relaxed/simple;
	bh=lEsbjC0J9dHL5n1EoS5T7TFFGziI+mS2bnITscXTQrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2q8yt+WUZMFwOaF3dOIsOL0trFLhjaIS1ph5e2qidN1a7BxtY8HPeGLi4XHbzklBD1F1hutZY5H9Gx9yPEwPconHjNLp1EMCgW65o9FV2QM67BjpTb8fLl3H/gXlrFx8Ra5NLkl/yHCqDVNJfl9rL3aCgbqDip8Bf3WyNiy0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=teaA/h/k; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="teaA/h/k"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsfnv3939470;
	Thu, 18 Jun 2026 20:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=S1b4JvSHFIWhsGkOHdal6dQzUUBjc9/aT8pJ7olnbPc=; b=teaA
	/h/ktMqjth7y9sT8fE/DJ2NylKL+hn6yo/0tgEvvpSWy3m2IB0YE+tOsT3F1Zhzj
	57558seliSVJqDu28lMKuCUPh+e0WwNJErP2iZdedYHcX+g6UFGDYgRZd0BS1uRg
	2kWoznkJvD1NfXZniOodDbA0KKDfUf9wjUX4YiF232fAtVsW2S97y3bJWGq0I0kf
	3mnE+MJ904TOmcaE5ZOL+tUobFaQNFhjHoSy6xRf/7B/+nRMOCIsxfKEAh/J30+D
	ZKAq4JjveNP+lATnJMr4mECX1QTjvLEiJqG4jDB2aD/qtOt5K7nS1dVciYfFNhKu
	kPy+BhOjgJXlSENYJw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6v1c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:34 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:33 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 21/27] ftrace: Have ftrace pages output reflect freed pages
Date: Thu, 18 Jun 2026 16:38:59 -0400
Message-ID: <05b8a27b8714dc88569d22f4b5faf538b1159b14.1781814151.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a345786 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=XgXTSPbbcnNvTgzPI4UA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: kMYxNbcGe8w3xELpx_EniDGZsiExwYHu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX12gFE+mg4NB/
 b4CvSB8J7fnGElmsARQhsJ3tLZPevWZqdLwskze/iwcaLITBQFMdqSWZvOiqclKCTFulY+uVvNs
 4oSF4GOZbD2U09ENHZEuk1LDBoF8UM3hiPkIBC2oK+sTCQ7JBXak
X-Proofpoint-ORIG-GUID: kMYxNbcGe8w3xELpx_EniDGZsiExwYHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX4L9V5jFNzWTq
 ok1pCNGHJjLiPUqfEoLAEZb9FQU4CY4AxmPmeuu1Wfqg70xS6dZr1pLAWWaYMHy74WRc21SXocE
 ZJtav71lgQwXtK/BILZjujSf6oYryhKJR4y2lJxV3CZ8/WQAqWn7GYEWQftvqgdyKO0+zSwsR6J
 NLiI6hJwohLC+TCey0hbKghf3lWWodNovtcfzWQB5Ma3uMCQlS9FwcxA+ZuTj7mfDpa7BpKv+cI
 nFXgfRwk99LNVnABAEu2lLEnDKBGZS6wBx0UIgTC65fr2Y8kavjapVufXg6C7O8k5wenhjoqo7t
 3OcI07Rq4nk9v/T+wMyAqgik22sOYEYZTaz4S1kfRDGvZiYm3qh1fhEq3/QH2h9L2pSXZArnYYW
 XoPJE3UQzMVPHEA7lnMxqEyrMjECxYzL9IOQ3XHpoxv21t4QWvYd/aw6OGCNakU6SrVlZA3SyFG
 77sWHoFyGpBguZfUBAA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

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
index ed045c296..477f7b848 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6527,6 +6527,7 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long addr;
 	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
+	unsigned long pages;
 	int ret = -ENOMEM;
 
 	count = end - start;
@@ -6534,6 +6535,8 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
+	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
 	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
@@ -6645,6 +6648,8 @@ static int ftrace_process_locs(struct module *mod,
 			for (pg = pg_unuse; pg; pg = pg->next)
 				remaining += 1 << pg->order;
 
+			pages -= remaining;
+
 			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
 
 			/*
@@ -6658,6 +6663,13 @@ static int ftrace_process_locs(struct module *mod,
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
 
@@ -7315,9 +7327,6 @@ void __init ftrace_init(void)
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


Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8733128B2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813780; cv=none; b=L2+tJUBwA6Y5Hwa6BuoxVlNEH9z/j0YAchNVvD8rWLAhACYWjNxLG43HYb4k2gPyDO0rr9ZOo0JYDONTnumQbAdn1suzgscK4YQAhqp7nDf4AqSAPha2jeOGvNA+EnoQZxczqwtuRML7IJs2c7GTqyCTBpuU19mEQbrdpQ5YYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813780; c=relaxed/simple;
	bh=3BJYXWx0x90ajusZc72bripIcniu6U+EyNszpXf5Aic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiGSR4dSRH/5tBl4Zd9Ob2j8hNxee599l8+Qisx5weOa9DAbMPWc/MQZgAfaSZ+x9+mE8sp6uoEEBu/F9S7JcVnxyhobpF92fQSYAIy2y7WvQxiHtFeHlnQ2blRaRCm1T+JnqTxudlue9JVFeIXB04lVQkbXSssQhP+MMbuLN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=hcpM+wqC; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="hcpM+wqC"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsrKX3988528;
	Thu, 18 Jun 2026 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=LdIzLtvT7EqTpbeVB/8mRlOmGIWJfFc+C6MKxe6Ru10=; b=hcpM
	+wqC0KizhjcuimR992gV6Dz3uzKcIC4E6GoLbn1qXmBR0BhmOm4lkCfVgGJMhceW
	ZA8R/6tBQNmpyRXVIghMZZVWluLV9RocuuYNeQbQ/yiptdh9T1SeXC1HAR5iBxFL
	ZkDdTuT/T/TKjNhOv0PgzJdDklH8F8BYhR/1lqkfVNOvjI6C6hJ6wUyRdbbC10T0
	zsi5EeWBcFkbfsX1+VRdiH8XMeXkVnDjNtmFPqVwgM/dKNAtWrrAswQDJgCUxyMd
	zKi3d3VHuBpoz9iZKnMIN9hW+cm24UM+a/sh0cfddPN8QeNOFlmh+QK8wLKAxhjN
	lAgZyAzwozP9TwGWkA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uyve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:13 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:11 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 20/27] ftrace: Update the mcount_loc check of skipped entries
Date: Thu, 18 Jun 2026 16:15:34 -0400
Message-ID: <60ec429dd94faa00507cc8f10127ee80a89bd2d9.1781809971.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX/td5KEz4yJBc
 KfCoj7E+0J1C/Tfl79A5BtrYyHIHU8Z4ZBt/X8jrmPeQ1KZF99cWOv68Q3LZYcOFjbSh2DCxXP+
 9fLXsl5/y3OLHcKgOjtDyCKhAdsJs8dvBjASF0gEicg8XFnJwDeHWaCwHT43cpoqpGAjT6240uu
 a28ejUB/fTWDe9XzjrmdO9XNeTWqLIc3TCI6LIwh5Vu6Q5JA3ZDGUN3Qu8jVQPwfM3IM48vM61N
 PuTLabh2FCIYOUut3xm8LDpkOv/Qswy4W6M/1gc02UnapWtQuj0MeM7l79I/rs5bfEcV3edcUHa
 ksB18y8Nkqdpr3saZZwj+0fJIETCBFs9vlSLr1D8ESByhWQk+MB86KzRAk1QuX/bKqPLNfFR4DU
 8S43O9vQoK4QYwmIJ/6CvtIUYViqUVsGxF53paNlK3ATUskcHLBqkxxJvgaal+hhYkfES2Dyjta
 BtiBj3IgKEteTPKsfjw==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a34520d cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=c2Yqh1CnMV39eQAqYPYA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: vE0cN0JgEmKqvpi1PhXOfjnXLvH9NQ-k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX6/4YKWYriP58
 uQYdrzc5ua4GV0cBwRFYTJGLz0yVAlnQZHyaFSVnatSmelgFN1/K21MBdHQWxClibECwhXC0ezY
 lBADalSKk25dUoCXNtJXFLy287IiFg+quTJ6fG2BDdD17/W5ozlP
X-Proofpoint-GUID: vE0cN0JgEmKqvpi1PhXOfjnXLvH9NQ-k
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4a3efc6baff931da9a85c6d2e42c87bd9a827399 ]

Now that weak functions turn into skipped entries, update the check to
make sure the amount that was allocated would fit both the entries that
were allocated as well as those that were skipped.

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
Link: https://lore.kernel.org/20250218200023.055162048@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 40620e3e7..4f0d05e08 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7155,7 +7155,28 @@ static int ftrace_process_locs(struct module *mod,
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
-		WARN_ON(!skipped);
+		unsigned long pg_remaining, remaining = 0;
+		unsigned long skip;
+
+		/* Count the number of entries unused and compare it to skipped. */
+		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+
+		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
+
+			skip = skipped - pg_remaining;
+
+			for (pg = pg_unuse; pg; pg = pg->next)
+				remaining += 1 << pg->order;
+
+			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
+
+			/*
+			 * Check to see if the number of pages remaining would
+			 * just fit the number of entries skipped.
+			 */
+			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			     remaining, skipped);
+		}
 		/* Need to synchronize with ftrace_location_range() */
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
-- 
2.34.1


Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FC25F988;
	Wed, 29 Jul 2026 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287480; cv=none; b=Jo/J6C9rc+SGZhlB/vjECyQ//KRkbEq9jlVHclWjZxHKAdq7fumEo+ehluEhw46xKtXxEzIwk9Qq1U/YF+4j2bmogXi53kBDem/HMlur7J4liluOtoOD3NJp9yMX+tt4CCzuEGxWX8c6KSIXu3wbWCO1WCn0uVZPpu9FVsVoZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287480; c=relaxed/simple;
	bh=/CClPBdfhww9145mKtQfKH+3l/l0+f9rdzAqjBkM41E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqh8z8KCXwTjGX6YlwCIp+phGgxnz+SUlsuLDbr7icBsQDR4OGnDAo1Y9xw2HOtxkMMfmFHvWHiGcmteJE7mstvQjvHL8cV17wbjWZCVHJfAZWjoLv3UrS+tQPQ0Qneg1N04rdA5/iYQCfMDb+iSaPVURiVHTR6dphZwEpcccEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Lvk3iqJS; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Lvk3iqJS"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SNBKbg3568894;
	Wed, 29 Jul 2026 01:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=/4tql4HEH8ZimZddOpZIHy2WGvzqr1l8FaoYtrQJmdo=; b=Lvk3
	iqJSxFpeEr01X8IezKKyryRwGrWY00tPXXwcOXOAc+cpwVKooQOE5RlB2lc3A3vl
	uBnxWTwNj2fJOtcIYHE4xhcE4cSYbpa/EQ3e9DOW3yPwC1uLlnDHR1u1agEK/tgT
	t8nwvd9bSqY13uHbx214j8MkX9iWE45wuuwBA4RVz38Y6fL+tq+uG8Qtvheo4Sq6
	Xb6IAk3MVHYUlwYhKAi7fyEqM3vzq1wInLC3NYtj+WM7OS8hBdr4uv2iPsbZbljC
	KsYFcGqSU2YhNX+DJkGO/l23Z2w1pmrMxoDZIsp5DFm8kYxMbM2P5sI6RlKahabp
	3uEXfkTaLs8GcSMSkQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq308s015-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 01:00:03 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 29 Jul 2026 01:00:01 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <song@kernel.org>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 1/3] bpf: mark trampoline ftrace_ops permanent
Date: Tue, 28 Jul 2026 20:59:57 -0400
Message-ID: <20260729005959.3853865-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX4OYY4X1lHVCS
 fmacQYSpcjD42GsJGcynmZYzDpKDgbb7pBXx4xAomRw7PevSBCu44gcfP8Ygz4dF8j9ldpi7Hd/
 qA4gp8bioDwo7WTEJYnU0Tl1kelcNpkBBM3tdj0PVAsOD5XidqSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX5qHoA7JED5RM
 GFylB+ahEBlt5jMT8kM1qHs72uPBsuv/3sngqQS9OTcKiDrbg7Y6scT531FcqbNBo3gdrqr86Ll
 fZdXl5xlq2aeIfOUkKzY2N0/3g/LklXqoGXJ+CADiUch4opBHNQRl+PgF2QwGgmqgWAEY2R1Pqu
 1WZiwVdYSsOwBGDQLhkxEiveSZUv6IqMOc+h05c4+o7j3ol/Zc81GJNdwC+bAS9Crj4axO+hOxl
 biVlWyXUuhpoFJZom2B31avcAgV+hjKkYOLKSns6Vf/+k0y4mk9a4arLnYKTGgl1Kl11jxSpv30
 a5NRzoTFwzZwqNYRkTHgwJpYbVETjo1hN1od9zyXSWcgJQ8vsPlGjAlIfP9/F6XG4O5gUNYcl1x
 XlBEY3k/ghuUE58LeNiTsDtJ/377aPC4WesbiiCeg1R9vlGWoyhhIctUcI2v9uJ9P9i8B3hYpuL
 yo7609FWwXQikVnmEwg==
X-Proofpoint-GUID: Gvxfg66ZLVUH_Gq_N_IohLFjS-PUF1GN
X-Authority-Analysis: v=2.4 cv=fOAJG5ae c=1 sm=1 tr=0 ts=6a695094 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=x9UjSuPfCr9JuOqytdIA:9
X-Proofpoint-ORIG-GUID: Gvxfg66ZLVUH_Gq_N_IohLFjS-PUF1GN
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290005

kernel.ftrace_enabled=0 silently kills BPF trampolines (fentry/fexit):
attach still succeeds, the hook stops firing with no error, and
re-enabling silently restores it with no indication anything happened.

This is a regression, not a new gap: BPF trampolines were already
protected against this the same way livepatch protects itself, via
FTRACE_OPS_FL_PERMANENT on the shared trampoline ftrace_ops. That
protection was silently dropped during a later refactoring and never
restored, so this has been broken for years.

Both the shared direct_ops (CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
arches) and the per-trampoline ops allocated on other arches (arm64,
s390) are BPF-trampoline-private, not shared with any unrelated
subsystem, so restoring the same unconditional flag is safe and needs
no kernel/trace/ftrace.c changes -- its existing generic sysctl gate
and attach-time refusal already scan the ops list and pick this up
for free.

Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/bpf/trampoline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 129d07db117e..3d5069091db7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -224,6 +224,8 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
  */
 struct ftrace_ops direct_ops = {
 	.ops_func = bpf_tramp_ftrace_ops_func,
+	/* Same protection livepatch gives its own ftrace_ops. */
+	.flags = FTRACE_OPS_FL_PERMANENT,
 };
 
 static int direct_ops_alloc(struct bpf_trampoline *tr)
@@ -303,6 +305,8 @@ static int direct_ops_alloc(struct bpf_trampoline *tr)
 		return -ENOMEM;
 	tr->fops->private = tr;
 	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+	/* See the direct_ops initializer above for why. */
+	tr->fops->flags |= FTRACE_OPS_FL_PERMANENT;
 	return 0;
 }
 
-- 
2.34.1


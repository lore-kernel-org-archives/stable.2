Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927159;
	b=5DPh5LtkVhgahsk7QqV9G5rEpmm8wRVz0ijeyO1arCZAHPi+qYFVCoTIUgCUU56RmoKY
	 jpKujpKxTMf1bKuNv/4pmKNPzfyVpq6SaMpsOpxjXmf8/1g/eUgMGG1xGIGQiFT0nsgfB
	 RPGpIPRspaGqIGJCW5jBJC8u/YZ4YBZ+mtOwpCFdW9GsVVb6kW1tC39PbM4avGH4Gn8EC
	 4LdhTt0OLle8n3uzhDftsy5CYhIHZudWiBnc3dw0ozo95iiKm4PUaBO1uK8rhxSUpz+F+
	 74xd5W01Br8JUqkkLGSgi95Zp0rcNaDR61hnzIM6S870j87sTG2aYDO51w9SxZLr5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=55OWxesVhYY8zbHYg/9AnSFECteftxOo4B8ECt6qVWQ=;
	b=jhabMXCVN6XauCHo2tCMXUwJeA94KrmZkKca48b/kYe+u7kf6iIuAq0C4Ihp6j69veMK
	 Fb0tynpbC5gUxVCOYfU2act6cod4NWY0jX74smFf3vbMW0n+8huFb+qFKGUtrpvxZeeaL
	 GOlo4T/NmxOJhyHoU8PEg7r5KGQMxko5PznBzzWSAXzq/8MiYhqBbsLGaovqAlbFfTx3V
	 kLB3Rl6ZPY3bewdFJ6jo/uZFTyP/MnVew2FtqbYCOA7y//o/p9xhy785jajuGajGnwTg3
	 P6NccYxsTpILT7GEpDKujlqnbRJyhPXGrmSwmrY7FwvaLt9gOIl+hTpyYaGqNQEUXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b="Subc/4fx";
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4C606A326;
	Fri,  6 Nov 2026 01:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E4C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Subc/4fx
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NhIhF2129198;
	Fri, 6 Nov 2026 01:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=55OWxesVhYY8zbHYg/9AnSFECteftxOo4B8ECt6qVWQ=; b=Subc
	/4fxRufKP1hAljrDJuAX2bsCSBwod1DfU7HO3gK9Q5LR6ufGzsEkqGx//0Ul27Pc
	Kp2BulY2qDHkRr79DP4bg4jq2459IvDGFJX8wPQJCLA0+pfuljAviAs4Bj5sjhtZ
	7HK9L4obaxfoRyc3nq7DGjNZLmi5I27Zxg7tl/PD9hx/vfbgl12EisA8MZPmFWF9
	2C3YQPAN4OcwTLdaXph1e1gCy4ZWknwiDXxpwM1alhF9Vym0CUz1OtotDfBmjNlV
	TrkEyrMtu6XtCv21K/phBOgbkLs59buv7lw7BlSU39U+03i2ntZxNsIf88/Zl37V
	RATyB48cDDJtMvkjTA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hs3qmg5nu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 01:05:39 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 6 Nov 2026 01:05:38 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <song@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 1/2] bpf: mark trampoline ftrace_ops permanent
Date: Thu, 5 Nov 2026 20:05:34 -0500
Message-ID: <20261106010535.2137162-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106010535.2137162-1-andrey.grodzovsky@crowdstrike.com>
References: <20261106010535.2137162-1-andrey.grodzovsky@crowdstrike.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH009.crowdstrike.sys (10.100.11.79) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfX43DqjI28y4KF
 +f/ZsPh0H9Is5/NQDg25+SKyLmBn8+KjQx3Dy/CiLbdRZJeFWOsD3S99s3dEeDGcZIp4GyFbZwE
 h5vB88ReWaY2aJNljSo8CsdjxPjL+lGwyG/F/z5BgY1fWEXFmu7SKlyaJiBttMVGr/wjFdo1DpW
 3WEIA861E0IcYcgYt/QURDCOTastAcJ8WpaHw7nWuMva57robWQEWR0Zv36nfX/Mk9I53rsQgF2
 4AiXceHjylpufJdl3XoqBmLeoL0sW2zqOAgIx1MIxI/mKmacT9fYEVnvlGx3S3bgdouLbdnfdMv
 F3MU0hjl2uJRMZRdzJINEk8PuoDyyPYfEzUgvii18xeLH/emN0uTMpp69uJlTSmMI7v4FBn4w/x
 Rh8SI1oGzOnSfj3RgSI+JSlu5wysKdYYWUbsQnc26T+zjKNA6quQjTKdt/Pr4gQVnHrqOaOGzyF
 g4GN1jCBJaoUeb/P/mA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfXzJq80X+quKNn
 749mJiGH3euYwAZaSEqDd1c4gO5GuxBkesMGLHz+9Poikwn6HxVcvpoCpTF1ZJWAtZ8mlpl1D7+
 3ZO8JU/txVGZqAch5mCX7qiLLOuqgmuTKhaS5oU7uJOGZOeCMylg
X-Authority-Analysis: v=2.4 cv=JuVkP84C c=1 sm=1 tr=0 ts=6aed27e3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8 a=wRpQxPF_At0yPaAqV3YA:9
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 3uAClJcRHjL7YEUzE5SzPlbtQylYlqv_
X-Proofpoint-GUID: 3uAClJcRHjL7YEUzE5SzPlbtQylYlqv_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060003

kernel.ftrace_enabled=0 silently disables BPF trampolines: the hook
stops firing, attach reports no error, and re-enabling restores it
without notice.

Trampolines used to be protected by FTRACE_OPS_FL_PERMANENT on the
shared direct_ops, the way livepatch is. The flag was lost when the
ops were split per trampoline. Restore it on both direct_ops and the
per-trampoline ops. Both are private to BPF trampolines, so no
ftrace.c changes are needed.

Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/bpf/trampoline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..82c91b1bf657 100644
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


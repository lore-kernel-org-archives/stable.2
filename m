Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927161;
	b=3tpGc8t4LFY0fTy8bX7nmoPKbppJ75rTH2j4AHuW7zJUvP/0PjFPKG9Oj2vXBaL9cb+/
	 Czzd152vV2yL/KjFttKMDeSs6or0K6mYcOFTA6lnZzGSl7KTrxAZw5fZDYPyqxT/9OW1n
	 VtbT4XppSgqnbkLsrhVdjfbV+tU4UyuFVCZ6cD67PDloZDw4MIIdH70E5BgbZCdLVq7ww
	 ivbreXLRH30sl1WmCJQec7fzohcwdU+XHzOdQi0FEbFtyFL2dkehP70WWa+75yBCBAFTc
	 EPccp44pE0D0RD43gABoW8rDKAnimVlBdyp24SCHOZuYNHSfzGwUkVhXdkThmZUpJrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927161;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=so5wjnbUEsC6TErUm3CNyP26HpFvBzf68B1lEIt6es0=;
	b=0LR/NzgLIj7MzOe5vFBWvqWKVXkEoDJwUg1RUgg5Hrq90s491d8ybf1aihmPN4FVLzWC
	 pYCJoOVzy5SL+XN0QkJ/qDUys3apRHdXsqO0/pA7gFDpphB1DnkEOg0Un1WAgrJFzqwOu
	 2S3iJUAmZUolzcONcLiYBDEPX4m0yowTxQmBPnTOsVWwaM1QjCi7j9zIEtf2AUI/K6fFd
	 /CIBcIiLtHSK7wmQh8UC6L9VaDxIWxqCEqrRf7+oyudIEnFrJzY8zh3fKDqnWpjqx485C
	 Jj39onoKbmvjFFZwn04xadalXPEq+CsvK4zlZNu3OpxwgEsPHj6DuMZwjeXHEme1HPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b="H/dDdGsz";
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78702606A336;
	Fri,  6 Nov 2026 01:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78702606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=H/dDdGsz
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NhU6T4097828;
	Fri, 6 Nov 2026 01:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=so5wjnbUEsC6TErUm3CNyP26HpFvBzf68B1lEIt6es0=; b=H/dD
	dGszMQvxOtBN2TB08PqbXiPt3LCE0m/MV8QXeBHngIXSM0JE2pxm/ci/kcYchZF0
	FF0zdCSBrP1GKwG76AbgRjyaojrAZzEfYcHyfbW8yJa1vSs6tN8OgIiInf6HBbvo
	bcVike4ZrWGYS7TEVhlA3IRyDXL98yP+5A4RF6OLarJmbYN1W7+AvL43wQIqEOAi
	+OWFnmYOKCqgmzUyI5GG5iDWptD7+mhDqAwRTf+BVer8Rl6EIhW8aImPNAqphzIS
	9N55h4Lgx9+bzmH53AEndoW5AL16lu6oHepOWKxQJXUAfXPUGt2cGbF0bCdBRBWZ
	kvM8xrKHtpRlGl8rVA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hs3qjr638-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 01:05:41 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 6 Nov 2026 01:05:39 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <song@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 2/2] kprobes: mark ftrace-based kprobe ops permanent
Date: Thu, 5 Nov 2026 20:05:35 -0500
Message-ID: <20261106010535.2137162-3-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: XKYK8PmSkaS7eqkbtkTTfyQauFevchoI
X-Authority-Analysis: v=2.4 cv=DvbDa2/+ c=1 sm=1 tr=0 ts=6aed27e5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8 a=e19StQ-nltG7q6LXw7YA:9
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: XKYK8PmSkaS7eqkbtkTTfyQauFevchoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfX7Mj3zV0VghtI
 pf0g9MT4Zp4BrLaI5PyMEyVe1WlakwyjLxT1SMFuzAtpBlYXrjwNTdiHX4CgisIH89PeFVTCj2S
 6cvdk0jToFSoUTDaQw/qEU0+sIZ1LaSa/fumNqRSx/b0fmkOAy6aJgwDWlNuWwAss8buNV5uVji
 inRxxSPg5xoHzi1cps7ua1yGqVPxj+nBeqQ0O4nyIU6FcKlXxiOd8VAvmzLRkIYvpuBLLGrZm57
 0LTcO2TMGljeEUSPHNxgVI8DMn+kxIBcrW66GMZpULDl9qcwquyGygqMbMtB2IzLlML6qMtbQhe
 kSMfimZ5+nF+YK+Y/yaByGiJgVfepSnlOTsekEG7UmG4oCPEOEXpRZS2QjMUDjgaikHOaJiTkwY
 jPQxlFVrmo/UYY+7Oh3pD2AFjDdCHqX/OTdOvCZpfMv/qgjNkbzSJ+Cnl5krkhmHVOlr6OH6xH8
 ThlxjRIkkHC6TKr1zhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfX9NPyfoTDRMX5
 3VkxwU+xDOUnkaPDjypAJCt72iYTFROS7fuE6y3p3iuq72UYD9UVAkVM/qbPhj2h6MEV3r8pk2M
 HMAlL41Dns++kx2wZMECn7cgzWZiUcHnRcfeXJb91reaLVSEfv+t
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060003

kernel.ftrace_enabled=0 silently disables ftrace-based
kprobes/kretprobes: arming succeeds, the probe stops firing, and
re-enabling restores it. Unlike trampolines, they never had this
protection.

kprobe_ftrace_ops and kprobe_ipmodify_ops are used only by
ftrace-based kprobes, so FTRACE_OPS_FL_PERMANENT, as livepatch uses,
is safe here.

kprobe.multi, kretprobe.multi and kprobe.session (fprobe-based) are
not covered: their return path shares the function-graph subops
manager with unrelated tracers.

Cc: stable@vger.kernel.org
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2441b9e39343..6e87c90b9835 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1365,14 +1365,15 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 #endif /* CONFIG_OPTPROBES */
 
 #ifdef CONFIG_KPROBES_ON_FTRACE
+/* Same protection livepatch gives its own ftrace_ops. */
 static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
 	.func = kprobe_ftrace_handler,
-	.flags = FTRACE_OPS_FL_SAVE_REGS,
+	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_PERMANENT,
 };
 
 static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 	.func = kprobe_ftrace_handler,
-	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
+	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_PERMANENT,
 };
 
 static int kprobe_ipmodify_enabled;
-- 
2.34.1


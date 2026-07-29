Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AB1A682A;
	Wed, 29 Jul 2026 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287873; cv=none; b=RijNCb2B9mUinuEv3ycY3hQ2mY7XrFb57DxaNixt52VgtC2PV6hHU0X5VMJHrluPogji6fIjajd9F+OxUU93Fw2tAxerhniCzT0HY7yMTQ6wRCgTxPpvCkAbvPDDISBymy7SCDbjvJyThRqwHO+wVtZjci873w4y35h2m9Q9fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287873; c=relaxed/simple;
	bh=qxZCXlcw9Meh7Nh7cAEy9AyrPvQnHTB1U6Iq2Km1DZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebuwwbjsdMICtVneJBWh8Uf1mgz/3dOFpMhuU1wRTB22MATURixCy5odniiTFl/ysbXFweW1iiZevwPVR9d8/LKrcm9XOl4AczocTvPRXRqSMB77kmP9NQN73ERVuZKon5cSmvaLwNhz8YLyVLE9Bx1etbkFSLJlB5MwVL8JYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=R+ScW4H3; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="R+ScW4H3"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SNOk9K3377823;
	Wed, 29 Jul 2026 01:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=zIoivWFSUt2cU6SJ8ZE/Eipvq4hr/aYrBkgtQW9bsw0=; b=R+Sc
	W4H3es6xAK3pelD0figFnwZ083XToEMbMFEzX5o4oc5aOCuaXnagp1bB4REp3rf8
	74fuMCqR/UZGahSUFR3nGipHxgvnvYa0dExNpoM2JikUdSpBdL+dgoeUvli8SSIT
	2TJLvBShUR/eVCnLwKcBIWSVIyQoEiXGY63RVzi6NkMVX4Q0VBvr3CvvB41dOL2K
	LAcGvN5NoazoASxJ3GDiifhWzlsnT8SQC5LBxuU4s/qIpUENEyDLuCJO+eeIbMkf
	gJJIisuPtbbsNRpjKJKZk6nnkbkDCbNXFpXtdqgoK7/WFoo6pGGKNQnJXuW+OEoJ
	E3NEwNNgpNC6iFU6Ag==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fq0cphtx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 01:00:05 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 29 Jul 2026 01:00:03 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <song@kernel.org>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 2/3] kprobes: mark ftrace-based kprobe ops permanent
Date: Tue, 28 Jul 2026 20:59:58 -0400
Message-ID: <20260729005959.3853865-3-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=P9oKQCAu c=1 sm=1 tr=0 ts=6a695095 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=BHGGdpKhdtX_Lqjkc3kA:9
X-Proofpoint-ORIG-GUID: -DLYUjWaY1wC67FktWIX7A2qBgkNtovY
X-Proofpoint-GUID: -DLYUjWaY1wC67FktWIX7A2qBgkNtovY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX9MeSA6oByfGB
 3MkKjQdVThJGcizRvA8oce07csnv5lSAevUqqpC5upRDTRscIStgrGKnjRUb8vVXYlGVPrX5ZFc
 CLEuxZtHtYIplY9y3r2c/y5QFJcMTc7GkeJ62v0BpkwIag+IVBpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX1BcUUq8B67bR
 c7mrXIeeUWmHmVREvdBM3KtiGjrLw+Xbi+pAR9BouCc/tYbXzMrWp5c2fcZC1yDarKOOBqFJ80w
 PvV+ydmH/ftJ6+SOLO1d6Jtm31mUkZcrdt2xaf7RtyPGJh8mctdSsISSbZMrNQ68500CyqdvN4I
 MRHHAhiIOfLQrKo8aqoy3Z9sybOs75tOOZEsrgo7JeGV1Nj+MpEiJqQB5Rc9vR1kdU1sIGRoYSe
 jJTcMIjgAzBU+Mngp/LqRVDn8cuGD5Bd8/GuQNieo27y5SqJRoDo/10dBpQ7bNSxa4uLvmBe2Fr
 /v9z60pD/x1vNPnATGE20wAhn9NKczndDb4RnQBYz+WYu2G13w2YhcPAQZLO3hZWNOb7ZiAkgaZ
 sRPoNPJCFYqF9LHdvmIqqnzbf2TjNHrWVjxGR6fj1btftZtjcM5GL7hdho1ebUPolRGA1ypX76E
 ZVZeYYNCnnUkf/VIRow==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290005

kernel.ftrace_enabled=0 silently kills ftrace-based kprobes/kretprobes
the same way it does BPF trampolines: arm succeeds, the probe stops
firing with no error, and re-enabling silently restores it. Unlike
trampolines this is not a regression -- ftrace-based kprobes have
never carried this protection, so the bug is long-standing.

kprobe_ftrace_ops/kprobe_ipmodify_ops are shared only among
ftrace-based kprobe attachers, not with any other tracer, so the same
unconditional FTRACE_OPS_FL_PERMANENT livepatch already uses applies
cleanly here too, with no kernel/trace/ftrace.c changes needed.

Known limitation: kprobe.multi/kretprobe.multi/kprobe.session
(fprobe-backed, kernel/trace/fprobe.c) are not covered. Entry-only
fprobes could take the same fix, but return-capturing fprobes route
through the function-graph tracer's shared subops manager, which is
also used by unrelated tracers (function_graph, irqsoff, wakeup
latency, function profiler) -- marking it permanent would block
ftrace_enabled=0 for those too. Left for a follow-up.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..5a54511eee79 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1122,14 +1122,15 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
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


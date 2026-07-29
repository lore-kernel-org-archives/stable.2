Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9D26F47C;
	Wed, 29 Jul 2026 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287477; cv=none; b=bOkVPuPBDL//vDJvKWAD3c+se5MeEDYpULJzyW+Ra1OCkhl2WKwkldKRK9b5IPtz9ZD8DoKCuGcyrs7XEINpo+SaZenxM5fqPcwv+CKCvHQpAYp75Z58RTpG5mGATTbu6ENKVpDU7+QRaLSJE616IB+/I76EDXOcDcIlFioepCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287477; c=relaxed/simple;
	bh=9oOMuIJ+d6N8pYm7ylqaiSOalGuNAnlDpfDS/8Zxs6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y78tNCpg4nMKKU9frEZzS8jH/1hwMtCNf/ZNwtlwbpARpg28LkTxiLgbYwpAKC2wb1fPMQCLK6XL4b8lZCTuRO+nWOPOs+pB6auLn8Q3ClVp0hgTudGuom71GvgvK29ewUlPeWQRPxffRifNg2oN1QtbDTArQK0fQNxVqwTgdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=g4cWis5Y; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="g4cWis5Y"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SNBKbf3568894;
	Wed, 29 Jul 2026 01:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=MLDpUT3Ig5dVy
	1KC0ADOUItrHAe2qJm3V5QInWkrGGQ=; b=g4cWis5YKmjBELVxkUNFr+U+O8j2h
	N7X+v2o51CjvpdyUXRwfMSUGr9QIeuYOqfonKP0pQwZa3glnDjzLejbMvHyN/p5s
	I7FRgwrpzL5J6JMxzBPw1wIoDf32eVP+6vkHmf++eh79MXvWZa9sXqmtuTmrunPY
	hAZZsqkK2riFcSg/IUmXL+18gM8RNVzjP/zpMUqfYRnLHXN53+ng4IDSaFM06Yky
	MsbEB4muu8r4ITeE0PytZ5bs4omRuVv3routWcFShiLsJBD13ujLsSpuj1F1rQ5r
	1F0wpF2jgvH+valHWQvUcBKbB66Mowaa7uOYgLvbi9iIAog/OLbpT8CrA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq308s015-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 01:00:02 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 29 Jul 2026 01:00:00 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <song@kernel.org>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark trampoline/kprobe ftrace_ops permanent
Date: Tue, 28 Jul 2026 20:59:56 -0400
Message-ID: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX0yxALDA0FYl8
 VzWtGYFDuc1Ux63fn4GMX2O188agIwvQPf1s3IBW/YYaLzSF0G0q003VqxUKcwZuSGXrwkHI735
 yoLydCFvcdLSZZLf5JAzb6Bx/OM27Orbqx1O1oy9claBDcTdd6uv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAwNSBTYWx0ZWRfX/4nOwqQWkz2C
 DbiNwaOUTniSP1Pz0HpC2DfazUPkIEby4SVtCiJECytDo2iwd+GZnPzPhTOZJhwhYIIyxH6wvAV
 gUGdE9bh0ywjrl/k1U1NkKV3pqepzNuAtpqHKJgy7lGfn7ghP6GlnMfA7Sbdu43tM+Pn99zuyfV
 d6g4kRf1Jfz2IqO1Gy8ub6g026qOmyv4hJbALE+5rzpnHzMJkr36qjW4juaIF3d4wYasAbh0bdH
 gnmgQiIAEPs5cW04+CWBslkdpFSy6gTB17lqcUoHPeBwC2vaRvkfMI0viD1SEQf9H5d/ka1N7Yf
 hD3U1f2IyeE5l8ihG0Ynatl0XQHCX/NSBEmnmcVFGiSdTNmzO6K8aoTbC5maNa8M9bKUC3+U9Y1
 IGD5h55XClmiuii+1tmXtz+zTYJjo8y0V7uKCTCli768KW/+3K5pbX8Twx1uGufxEI5BlAT4Y23
 53ajYoe6bjRS2fv31yQ==
X-Proofpoint-GUID: EcNe9mDSq8C8ID9iOLzODzQaMAaV2BlB
X-Authority-Analysis: v=2.4 cv=fOAJG5ae c=1 sm=1 tr=0 ts=6a695093 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=NEAV23lmAAAA:8 a=lO_3BM9siXdlfk_5vd8A:9
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: EcNe9mDSq8C8ID9iOLzODzQaMAaV2BlB
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290005

This fixes a long-standing issue: kernel.ftrace_enabled=0 silently
disables BPF trampolines (fentry/fexit) and ftrace-based
kprobes/kretprobes. The write succeeds, the hook stops firing with no
error, and re-enabling silently restores it. Livepatch already solved
this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
ftrace while a permanent ops is registered and refuses to register
one while ftrace is disabled[1].

For trampolines this restores a historical property: from 2019-2022
they shared one global direct_ops, marked permanent the same
way[2].It was later lost as a side effect of the 2022
per-trampoline-ops split (patch 1's Fixes tag) and never
restored.[3][4] Kprobes never carried this protection at all, so
for them that is long-standing issue rather than a regression.

Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
a selftest covering both directions for all four hook types.

P.S
I initially implemented a per-record opt-in flag[5], but dropped it
as over-engineering once I saw the original blanket restriction.

P.P.S
Open question: kprobe.multi/kretprobe.multi/kprobe.session
(fprobe-backed) aren't covered -- return-capturing fprobes share the
function-graph tracer's subops manager with unrelated tracers, so
marking it permanent needs a different, per-record approach. Perhaps
something along the lines of [5].

[1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T/#u
[2] - https://lore.kernel.org/all/20191108213450.032003836@goodmis.org/
[3] - https://lore.kernel.org/all/20220602193706.2607681-1-song@kernel.org/
[4] - https://lore.kernel.org/bpf/20251230145010.103439-1-jolsa@kernel.org/
[5] - https://github.com/kernel-patches/bpf/compare/bpf-next_base...andrey-grodzovsky:bpf:ftrace-permanent-per-record

Andrey Grodzovsky (3):
  bpf: mark trampoline ftrace_ops permanent
  kprobes: mark ftrace-based kprobe ops permanent
  selftests/bpf: add ftrace_permanent test

 kernel/bpf/trampoline.c                       |   4 +
 kernel/kprobes.c                              |   5 +-
 .../bpf/prog_tests/ftrace_permanent.c         | 144 ++++++++++++++++++
 .../selftests/bpf/progs/ftrace_permanent.c    |  43 ++++++
 4 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
 create mode 100644 tools/testing/selftests/bpf/progs/ftrace_permanent.c

-- 
2.34.1


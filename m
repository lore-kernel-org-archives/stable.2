Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40731A556;
	Thu,  6 Aug 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030236; cv=none; b=YkSJblKkBYrQTbCwY7pSdBTOXurfRonlp5HXC6uBNdCcD/h9D8a5W6EaBidCSknygeTq+R+3VuxWGOSTOSwxIJuahblXB1QTQ6kEiDNIyHhHb36/YfdyqByKeVsVL/nOLsWXxVoRoos+LC57hehwbegO5fBryBfHvrx4gSX397Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030236; c=relaxed/simple;
	bh=8bev+YFInPHJM28EK6pCwP8emS2ENb6t43Kja9tJDQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnzYLw8jqn2zRokzM5MIyo6TLVrJTREHGgP27e3SJeLttQXIqrlR6haLdyomsVfJTR17pUw654H2VzvCvqozKKXKSdhXO/aYYTooHFdJNqxZPvoIFHMJl2g43iQQAuDNwP6SjAYMh0LkUy2HDp9kl6Q8nZdBuRWOYB54C2LmBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=E1OlbU9Z; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="E1OlbU9Z"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676F84Gm1695370;
	Thu, 6 Aug 2026 15:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=qPoIDP8FQyb7e
	cjBkLdYibo8TIHZnzXGA/u6Da3qBB8=; b=E1OlbU9ZO0CJsnX332hsJxivsy5j6
	Hoc93Fp2zUxcPvy5zLiKryZODBEmvfU5zcS/f3GyAmjZwNZtIXB+4X33zSHPrPN6
	6OxBQ/W+XM/52K8GYtI91uOec9fhEmUISSdvT/6Z/AFYvDyf5npGWcteq7aC2nJD
	oxvUWF16vJA4t4M4Lmo5kKS4cnyjBb/TXbYZwhx7LFftfGpqJiyzCKdmzmckq+DX
	/pWA/JHggaBdzuIaHD2QuWXUuI1C89EOJSfhwCVwlOd2+9CS18FVN0rqrTGvPXqQ
	SOUz0VUnkGkubq3yKhHUkURI4r/JECSj1Mv0BTsg6ih5HlOfIjwEX4S5g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fvs8vs75y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 15:30:03 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 6 Aug 2026 15:30:01 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <rostedt@goodmis.org>,
        <mbenes@suse.cz>
CC: <jolsa@kernel.org>, <mhiramat@kernel.org>, <jpoimboe@kernel.org>,
        <joe.lawrence@redhat.com>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <stable@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v3 0/2] ftrace: deprecate the ftrace_enabled disable switch
Date: Thu, 6 Aug 2026 11:29:58 -0400
Message-ID: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: F9YrbgWRx7073Ye9ATigyFhk4pAnIYVI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX99qL7jvYIhp4
 hWZOsV/6K+UlMqSAnCCpKKqHN2QICw+XxYB3HgygbLSL6QXnLIUs13A3U9FkhusH8fnC/1e1iem
 OqXNK+1V00aIzIxjJ0fJZSFdVuRJwPzDSQgSivGyAijWLp2wnR9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX5WfaBRoTY9px
 6rewUGm2yOwrREHBl50k7Eg73XSU8036GC+tuCxW2SUICKlVxBtwKJkjIahdzzuIV515ArE+c96
 cBhmn7+uiGg9Pbcxe61w81/DjDiH7IZ5in1g61XwIER9wzasM3uvTBm+ruU8nc0HYPBugafOoPx
 IfzOA9567K1h6HCM3cio8fafMyWyfraBNbBUs9DS0UMHPjKzznU/Ik7UojokkYZ3aWnmHirO2wo
 7mM4f92eb3ZKnS0HAKR07ZftfRTaWmrJ8s8CJNgs3pw790WJ1JJIB9Stbcyg/KfZt2crL4M6PPF
 1gheV2EWZkKQg0hdGomk8ePpYYIqL7bDkDFldzA2XzC3AnqCIUQCY6lbP079BSNQ4xhmViRgFX5
 qzzf38EC9BE1lcbxjByrvb4WIbbu9A6Vbd0YDk65hjozfo8IMHj/b2Bj/3F7R9+o2rH40nq7tEZ
 iPvnap/pq3bWYQ59Whg==
X-Authority-Analysis: v=2.4 cv=VvsTxe2n c=1 sm=1 tr=0 ts=6a74a87b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=4N9FHRFzlcOBgbkxpeQA:9
X-Proofpoint-ORIG-GUID: F9YrbgWRx7073Ye9ATigyFhk4pAnIYVI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

This addresses a long-standing issue: kernel.ftrace_enabled=0 silently
disables BPF trampolines (fentry/fexit) and ftrace-based
kprobes/kretprobes. The write succeeds, the hook stops firing with no
error, and re-enabling silently restores it.

The solution chosen is to deny setting this knob to 0 from userspace,
thus preventing this case in the first place. Steven mentioned that the
switch became effectively useless and doesn't serve any meaningful
purpose anymore, and only creates problems for systems that rely on
ftrace, such as Livepatching and eBPF. Any attempt to set it to 0 will
fail with -EOPNOTSUPP. Reading and writing 1 remain unchanged.

Patch 1: the sysctl change plus a doc note.
Patch 2: updates the one selftest that relied on the old disable
behavior.

The original patch-set was a fix to commit 00963a2e75a8 ("bpf: Support
bpf_trampoline on functions with IPMODIFY (e.g. livepatch)"), and so we
would want to see this backported at least to LTS branches starting
with 6.1. But since this is effectively a new behavior and not a bug
fix, I am not sure what the policy is in this case.

Changes since v2:
  - Remove unused ftrace_shutdown_sysctl() and
    is_permanent_ops_registered() functions entirely instead of keeping
    them with __maybe_unused. (Steven)
  - Fix ftrace_disable_supported() to save and restore the original
    kernel.ftrace_enabled value instead of unconditionally forcing it to
    1. (Joe)

[1] https://lore.kernel.org/bpf/20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  ftrace: deprecate disabling via ftrace_enabled sysctl
  selftests/livepatch: update test-ftrace.sh for deprecated
    ftrace_enabled

 Documentation/trace/ftrace.rst                |  5 +++
 kernel/trace/ftrace.c                         | 43 +++---------------
 .../testing/selftests/livepatch/functions.sh  | 14 ++++++
 .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
 4 files changed, 53 insertions(+), 54 deletions(-)

-- 
2.34.1


Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B74457BA;
	Fri, 31 Jul 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520469; cv=none; b=sl14aHaZxiKmivKKAotP55swgJIP1FKTqQHGsy+w4hdpBzbYN3/LG4eTTRN9xfx97lr2ZCN+owmXpEjEgH99+628sgWFL7RGhdKk/xLy0D9NsECNgfPJggyP0vytDm7Pg+k8vi5+mAHutXBedb25NcpgowWA1r4YdglfjFEhTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520469; c=relaxed/simple;
	bh=ihgOB0j5WuxerRoW1WUpJT2lBVt0VkfNRLA9Nwfx6DM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uK8XOMvQ5o1d71Ru4vH/LZhdmcC/Ih0QxF76HpvMnLQpkJD7O4os4P0JlmZLu6k4CHUDkwUkKQ3gPjMP6+JSHCoW6F33ribUcdqKU0XBCi8XkLhNaOYOil+uGW1oKCwjIOPdP+UxqXlJwlHpgtN/G5zKz024eMOYyZxC5O3jq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=NozqxWbc; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="NozqxWbc"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VHoUZP4119240;
	Fri, 31 Jul 2026 17:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=sPvhhRgBGnKKT
	Bxj6o4/+Dgd38UYvXJsG0nbxiQPXBY=; b=NozqxWbcOLFIx7Qz/YbPcEIzHvgQN
	GIhw/njGwKdYNsWfRZL+EFO1Dl24+iOklswaAUKuDWLPN9nc1TaEpFHk/3xQuGdU
	OOoZfRU/6n6sfkDGu9LWEg2rVAfrT7zryj0tlRHJEjiv4e6FEVyJFnOgV68OkbKV
	dtTo+66RAiuLRtBhYyi3vqpjY1WdipDsML9NjrjNpyBfzvTvS8rnQVgBBUu/x9oX
	vWEdgtAQm4//0/RmD6M+WbbTWgBKS8+vYXJI9Px/TSqrCkBqh1yrlAi3757rCpT0
	WXIXo+/vdWxr1IQRDPNIsmK+bEa1O6RBlBvNDiImqq5jr08DJYBzFjLuw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4frqukt7e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 17:54:01 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 31 Jul 2026 17:53:59 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <rostedt@goodmis.org>, <mbenes@suse.cz>
CC: <corbet@lwn.net>, <jpoimboe@kernel.org>, <shuah@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 0/2] ftrace: deprecate the ftrace_enabled disable switch
Date: Fri, 31 Jul 2026 13:53:56 -0400
Message-ID: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: av0fH1e8HiUUbJQaElYledBsGsYOmI9g
X-Proofpoint-GUID: av0fH1e8HiUUbJQaElYledBsGsYOmI9g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfXy5wEHk88DG3B
 jYKuN+ZgiwayH8nokJ8bWfZ8n19I69fqp0UG5G/H1OVH9ifILFv3i6zRAd8cBxbDAS4Iy24ee3i
 k0ggiVkA3JycyIgILy0frNCJvdWsp4NDD4hqwWYFY1eRldNkidZU
X-Authority-Analysis: v=2.4 cv=LOFWhpW9 c=1 sm=1 tr=0 ts=6a6ce139 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=lvSoYojdLrk3AQUPsQMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfXzEp5XTx5tPbS
 y1Ty0qVMZdKYFpyyORGkFQjFevwnRZekwI5yIQ5WnOX4l/jFv7xtyg2iZpCV58nHW1//XeyMKrO
 JB/STksFi0FTlR04XeV5lZhsX30MQGlWpmtBCl6szL/dhbjK5YLoiDQuZZHkiucZNGT2KAcsiGL
 Z/ucI8NppBCC2dJ8ok8GhFwlYF5SRuR3QsmQghYXkKI1lT6IDzH8ZY3MdprQaVYfFTLkc8aQxoZ
 n4xciF7rporbY1CtWvcF7y2bwjocIvln/acZ+JqILDvskaI+npTi15Xy4BrI8YpwLlqIO5enyDA
 ufeLscJaIVt5wDi7SKqyjFTbGjiwx+6ajXiUSQqXkvluECBW3aJ2ELYD0SoPpZlj8wu6UMh1egW
 +o6c/ikuHZ7XByf8LZOxZ+hxu4gGRPxMU7C4DigXOCW+pud+xjY8PdKervYgrDG1J9c5Mu+gGEZ
 GRtIAPszNzhyA2V6pSw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11861
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310137

This adresses a long-standing issue: kernel.ftrace_enabled=0 silently
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


Changes since v1 :
  - test-ftrace.sh: keep the full original disable/reload scenario on
    kernels where kernel.ftrace_enabled=0 still works, and only fall
    back to the simple "write is refused" check on kernels that
    deprecate the knob.(Steven)

[1] https://lore.kernel.org/bpf/20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  ftrace: deprecate disabling via ftrace_enabled sysctl
  selftests/livepatch: update test-ftrace.sh for deprecated
    ftrace_enabled

 Documentation/trace/ftrace.rst                |  5 +++
 kernel/trace/ftrace.c                         | 19 ++++----
 .../testing/selftests/livepatch/functions.sh  | 13 ++++++
 .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
 4 files changed, 54 insertions(+), 28 deletions(-)

-- 
2.34.1


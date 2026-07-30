Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA0397AF2;
	Thu, 30 Jul 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429376; cv=none; b=YJX4l6Y72sxRBdcME3/svEDIc2zo0hgrH+S3nWEu8ZlNV6e5WxcimEMZlUW39KaBp0wTMo26xnGPKE2xIjJN0Jd2JsaG5jp3ngq0S4ICw8TwJAdLCOOTjKvLTK5rQ+I93TK+KDcHE1ppUd8d+1MTXUOqX09LLzWvGtjhU4nVcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429376; c=relaxed/simple;
	bh=R5Gg/B2zWC0zvzrstFa9AoI7A9SIQ+NsxqJ/rVw6SbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQTXf8sGSvOGJZH2B1v8QuVzCJuazaoMM1K/saeHJLyePWi5dlvaKYCTl7O5pwJIwmxrkRUk3ZPf7nuu5OzW4pfcRJ00PVKwYdMSROSCNub1uiBkfKiFjjVUqZZInmM42NE37GCWSxSivIf7goTl3jdZx2TkA8xPxOFc/M0ilC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=zDZfSZvu; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="zDZfSZvu"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEdZLh651796;
	Thu, 30 Jul 2026 16:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=zEYnLOiE4mTUG
	cYUJKmWjdA4FBayZtPYu9iaLAjCYZ8=; b=zDZfSZvuJAunxCRvHVioAtjw4556J
	A5W/mst1K+7YQbbXSLga0LniYd2/khX9KgQ3+XfCtXnIxW10lo3XWAmZI3pstb7C
	XqDw1t5G1ucNGLHSiVuhDfV+VT3/jQKMgN3DpPMRH+hCfPhQ1UTdgFC6Kn6wMUiU
	tkSdbdkhyS6katOINNQUmRgZdvC7O47Vip0WgzyiCk96+2MzSfAMeL2foFWLcqLE
	X8wWg1k17ksuPTMA9u7Tsdo3tucvbDzMOiDshqPBmcue4AHueOS3pyt9CQQBcCGV
	+ZNbZNzBAhK6Kij/zv6ASdK69zauPne+rwVD0wjm36MmR0NEQW6xX+jTg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fqmcsnchh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:35:47 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 16:35:45 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <rostedt@goodmis.org>, <corbet@lwn.net>, <jpoimboe@kernel.org>,
        <shuah@kernel.org>, <jolsa@kernel.org>, <mbenes@suse.cz>,
        <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 0/2] ftrace: deprecate the ftrace_enabled disable switch
Date: Thu, 30 Jul 2026 12:35:42 -0400
Message-ID: <20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-GUID: 5g7QQHVSpW-V1T0-IKgPto4ybWLpxyHX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX+DA3KiIq/Ito
 iJIXgN06fZDzpKKRJI5LEfOi5YsN1+62BNb4FB+V3KlVjA2uPHTu2QjL3kbd9cq8Gfzj6e+Ypgv
 zJMq2L3kCMhibZ6O4NeFTO3PrjqB0zKocmVFTSB8ZCF/mP8VOtfR
X-Authority-Analysis: v=2.4 cv=fYudDUQF c=1 sm=1 tr=0 ts=6a6b7d63 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=UoilYRtQRR5yYPxlszYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX6qn6PN1DXkYa
 ZViAwgMiON2KksUdD744TG08lj2wnOuNjftjcJX902GBJin1d6q/GNzOO02eq+GE69604fwThGI
 GMdlTKL7HqfpAx9mKSJp+cRQNomny17BzDeEsINqJC07kJFd0Bs22ZiQL/e0lYTX1j+7y8DzBnX
 qgKNzOgXzW/i/8GrI6s0djjzoNzcuveRZdW/vMC9ziSw4tc0UYjPVGT7YZFVvlt6kW7+fyld0/L
 iCe4m5Mrj9WRUb8LOLV9zLRGZFO/Gw4EfmzHhKF3ung5+H5YnjP58ZTqD5j8fzEg7hLzl9MEWUB
 FyDEPV67lCwNp0jujsJStqwu4G5M9stjxHGTW8h6+NfsShqXIAMeedEplGVaBYTWi3sm3i5lDH9
 OgWjXBiCVIuLIcyDA/oAQXFeQv/l6vY8oK7lwxw+48faPFk9nd7b2tEUb166XvCBz+lyjfMyjgT
 ePi9OjP2PAJS0pJfivg==
X-Proofpoint-ORIG-GUID: 5g7QQHVSpW-V1T0-IKgPto4ybWLpxyHX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11860
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300124

This fixes a long-standing issue: kernel.ftrace_enabled=0 silently
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

This replaces an earlier attempt[1] to restore FTRACE_OPS_FL_PERMANENT
on BPF trampolines and classic kprobes to work around the same issue.
Steven suggested this simpler approach instead: rather than
tracking down every caller that needs protecting, refuse to disable
ftrace via the sysctl unconditionally.

The original patch-set was a fix to commit 00963a2e75a8 ("bpf: Support
bpf_trampoline on functions with IPMODIFY (e.g. livepatch)"), and so we
would want to see this backported at least to LTS branches starting
with 6.1. But since this is effectively a new behavior and technically not a bug
fix, I am not sure what the policy is in this case.

[1] https://lore.kernel.org/bpf/20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  ftrace: deprecate disabling via ftrace_enabled sysctl
  selftests/livepatch: update test-ftrace.sh for deprecated
    ftrace_enabled

 Documentation/trace/ftrace.rst                |  5 ++
 kernel/trace/ftrace.c                         | 19 +++----
 .../selftests/livepatch/test-ftrace.sh        | 49 ++-----------------
 3 files changed, 16 insertions(+), 57 deletions(-)

-- 
2.34.1


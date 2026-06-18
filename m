Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93B221F20
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815157; cv=none; b=S6enzDCIoM29mrLwv20C+DZc85BzAp52yd56+EDPgVesK0UOHwTkAlOpqmDokqelrhq4zp9ZlH+P0yJZwpDotd3dR8QHzANQR7gwyoIo7Um5XWmlKO2lqNEZAsy1AS55FYE3HayXJdo+e24/YRHXguc5jrhkHEl4H9bsyaaa3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815157; c=relaxed/simple;
	bh=B8qLfBeHQl5m/hlU5mmqVF1htOyLZ+v6iS6OLq0WlIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2eIkz/tnk/dtHxizZ8rkhl8Hc++gvoxcpmvHIKlKQ/icbbXtiXdNGT+eD8xcf0z+pdTQeVwaHOxLxQ0oJMFUMPOoKk/QlB4bVUgMFemECKdtD6YneykBr0Mp6svAk2KyBquO8V02KjfetmQdwaLmQqMIFKKABecVo4H3I9GsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=WdSHSogs; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="WdSHSogs"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiHrD3007917;
	Thu, 18 Jun 2026 20:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=uPHcmU6nC4f7a
	RV22i+fYbAxpLp1qJKL2srgPIFcPCo=; b=WdSHSogsIj5+4oiQHAgsU+PObYiDn
	NtbsuxmKL4ea5JFSsMEBZOkr3ijvUhfosIP4nYrF+YKrO+0V/zrfBZkU/wi1FRl2
	WzjjPG/YHknHcuNnY5L5pQd86+xSfJCr0CyE8bqHMkyu1DMPB2ThUKKCAES+by0M
	h30KUIqTQIKkXq07B/1lEZw/V7V8ZI2J92c0YvMf6bqV+kqJVg02/qUXUR5uyoe9
	sxiq3i9o99FwFz/B84YpKzk6lUO8JXsHO9ybFyFwsOjHkSBxGwIQ7/HpAYKuUqyB
	hIPmJjRt3QVewNb2TStHo+v0LsEscN0pEayRaSM+KlAHnHgj/rDhQQ7JA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3k87v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:09 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:07 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 00/27] ftrace/sorttable: Fix ftrace symbol table corruption with CONFIG_X86_KERNEL_IBT=y
Date: Thu, 18 Jun 2026 16:38:38 -0400
Message-ID: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: D9gJysvupTnMsvg-pwK3KRG9xglDWjG0
X-Proofpoint-GUID: D9gJysvupTnMsvg-pwK3KRG9xglDWjG0
X-Authority-Analysis: v=2.4 cv=QrVuG1yd c=1 sm=1 tr=0 ts=6a34576d cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=p0WdMEafAAAA:8
 a=FKHNVGkEP0QFufyHOfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXwpk17iYp5T47
 gcWW/ELaP4bez37nEt1Dj6XwjUGry6Kk8e2pXcTr1Od2v6BBf+xzIVGux2GbU9ytlyQUY0Mw4Gk
 47t29bvM2QFx2a4vW5bkrc4KNNbhWUTW7z2EsuSQtaodslQtKijWmEC5+ZefUEjoeVqpcD/QJ9g
 j3Oo7hyYem58hQOVe3gZUCpR/jX3afF36ly+12VwJ4joM80M/6oxR8pHmuW3hXl0sskY6meAMYL
 AiKsNbHR0ShZG7iY+kxQQF8d4DQuDLWirmx+YjsHMsDWjjE6zRTvaruj/JZAYn8e1vLz3jBaG9v
 6ObrzCcdWnmQDui2sjRMIxOvE6g6PpTMQBPsA+kCAqXEjbLmzGQHdc7G5oTlz9cojMfzCEDQfii
 0aV9EgsKgmfP7Tt8JuyzXKD52uyCP1m3HqFi4HVQ4oH5fAPKSN7/7eDX3TcGWua3lUSaFADw9Bu
 nC05sEncgPFk5wCjIHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX8B8dAXprNdN1
 CEWBygnKDCqarLhrB8S/8/qYRP7MY22oZoz2XnoWi3Yaz1tIxH8xehM6uT0N3bQ9Gzg/hdYra/y
 fBUcBd/fHpVMJuY/BPTWsY+LDbwoUJUG+iVBcw2jqVt6qI3eJAPe
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

This series backports the upstream fix for ftrace symbol table
corruption on kernels with CONFIG_X86_KERNEL_IBT=y. Weak overridden
functions corrupt the ftrace symbol table at boot, causing
non-deterministic hook attachment failures across all ftrace consumers
— most visibly fentry/trampoline-based hooks, but affecting any code
that relies on ftrace symbol lookups.

The fix was merged to mainline in Linux 6.15 via:
  https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/

The original backport request and bug description sent to stable:
  https://lore.kernel.org/stable/CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com/

Red Hat independently backported this same set of patches to their
RHEL 10 kernel (6.12). Their work is at:
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2689

The 27 patches are organized in four groups:
  - Patches 01-14: sorttable.c rewrite (prereq, merged 6.14)
  - Patch  15:     function pointer struct cleanup (prereq, merged 6.14)
  - Patches 16-21: the core IBT fix series (merged 6.15)
  - Patches 22-27: post-merge correctness fixes for arm64 and s390

All patches applied cleanly to 6.6.y (at 6.6.142). Tested on x86_64
with CONFIG_X86_KERNEL_IBT=y:

  grep __ftrace_invalid_address___ \
    /sys/kernel/tracing/available_filter_functions | wc -l
  Before: 562   After: 0

Direct test (bpftrace kprobe vs fentry on put_task_struct_rcu_user):
  Unpatched: fentry=0, kprobe=46 (silent failure confirmed)
  Patched:   fentry=46, kprobe=46 (fixed)

ftrace kernel selftests (tools/testing/selftests/ftrace):
  119 passed, 0 regressions introduced (2 pre-existing failures
  unrelated to this series).

Guenter Roeck (1):
  ftrace: Do not over-allocate ftrace memory

Steven Rostedt (25):
  scripts/sorttable: Remove unused macro defines
  scripts/sorttable: Remove unused write functions
  scripts/sorttable: Remove unneeded Elf_Rel
  scripts/sorttable: Have the ORC code use the _r() functions to read
  scripts/sorttable: Make compare_extable() into two functions
  scripts/sorttable: Convert Elf_Ehdr to union
  scripts/sorttable: Replace Elf_Shdr Macro with a union
  scripts/sorttable: Convert Elf_Sym MACRO over to a union
  scripts/sorttable: Add helper functions for Elf_Ehdr
  scripts/sorttable: Add helper functions for Elf_Shdr
  scripts/sorttable: Add helper functions for Elf_Sym
  scripts/sorttable: Use uint64_t for mcount sorting
  scripts/sorttable: Move code from sorttable.h into sorttable.c
  scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
  scripts/sorttable: Use a structure of function pointers for elf
    helpers
  arm64: scripts/sorttable: Implement sorting mcount_loc at boot for
    arm64
  scripts/sorttable: Have mcount rela sort use direct values
  scripts/sorttable: Always use an array for the mcount_loc sorting
  scripts/sorttable: Zero out weak functions in mcount_loc table
  ftrace: Update the mcount_loc check of skipped entries
  ftrace: Have ftrace pages output reflect freed pages
  ftrace: Test mcount_loc addr before calling ftrace_call_addr()
  ftrace: Check against is_kernel_text() instead of kaslr_offset()
  scripts/sorttable: Use normal sort if theres no relocs in the mcount
    section
  scripts/sorttable: Allow matches to functions before function entry

Vasily Gorbik (1):
  scripts/sorttable: Fix endianness handling in build-time mcount sort

 arch/arm64/Kconfig      |    1 +
 kernel/trace/ftrace.c   |   68 ++-
 scripts/link-vmlinux.sh |    4 +-
 scripts/sorttable.c     | 1119 +++++++++++++++++++++++++++++++++++++--
 scripts/sorttable.h     |  500 -----------------
 5 files changed, 1133 insertions(+), 559 deletions(-)
 delete mode 100644 scripts/sorttable.h

-- 
2.34.1


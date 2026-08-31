Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599782FD69D;
	Mon, 31 Aug 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160600; cv=none; b=RkaWbaY5xrcF0P/g2KhlPm8gcLja6Obrvgbmv4O3gWWX9MrGppXNxKqXquAkH7aBqI3B3Odvfm7av6+mgbYe1MS/Tyh/j8V5pQU7lJmugByyzuLGuRt7u60Svpg8CIWZ7NI6rUV50NEqAPWh3eCTuIlB7ju1zsGV2wOhqy8GZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160600; c=relaxed/simple;
	bh=KOh0lxllReDrOTkKKuIQHBrUBmsk5nrbdp1rywaH7Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCexmUVA5X43QvoeKElYmZDH3j2mat5Al2w77oTrJpjTlr26DzGvX3l46VqN6Bqap0OJ/lqtqiN6XAqxyrDXOkpnt2YbhsOOF5fjaNUgHI7mZbvC1UFKhvvDHpe9/XCxyWPliuVvjnX6MolSmAA6nYC8frZIUk4BkF3eOsAXqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RyiwuFZp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyiwuFZp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V539Jh1330824;
	Mon, 31 Aug 2026 07:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LSmpLURchpGJdC227MU3V0YpZwIZINZ69ADxNgExy
	Os=; b=RyiwuFZpSrG3OJUMVL7yDFQ5T4Z0xw7Fwqqia/dK6Uf8uWnBscMoaKvJw
	4thCgYIyW4F9eqfI/3Mf2WNzOGo6KfDqcYI16yMj2vERo3LgMa0hQaxthb+GI+W1
	LpxTcpmraVl5kCiD1rpvpJL1VLD1JTOwBgFek9l3HSjCnTaq66AYu6ZxymKFWc81
	/lMhjpUkp1l1NSvvGkr2TcnwHzCyo2b3hlirifBLbEJd0yHhK/bYVxucWAZWieC2
	Eg97XihC2JvXC2EpTwfc5OCF6zUqXtaXpsLUqN9HOg1VmY43cauprwCKDPv+AYhb
	SeUlAjp32eBUxedJ2uNrhMSLtgYGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2sykb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BM2B012857;
	Mon, 31 Aug 2026 07:16:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjvj01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7GD4A36438274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56EBB2004D;
	Mon, 31 Aug 2026 07:16:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA3D20043;
	Mon, 31 Aug 2026 07:16:07 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:07 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 0/8] powerpc/bpf: address missing verifier selftest coverage
Date: Mon, 31 Aug 2026 12:45:57 +0530
Message-ID: <cover.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a952a42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=N7QzuYTHEryR9oxcy7gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX7ZUMcnSkbf7S
 42oqTKXx9KKNP5GoJjl4KM1UC9J0eo+WdPV9gL5mlh9mmrePbJsOJCpB7UHn5sh3+gVNHO2NNUY
 tPHWOchqRb3ChlNOXo7949WRZ2mBcrk=
X-Proofpoint-ORIG-GUID: c7Z3IvSwXlzskjOmfEyqiUxDy44E5omO
X-Proofpoint-GUID: c7Z3IvSwXlzskjOmfEyqiUxDy44E5omO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX9yD8+HQ8E5my
 0kSECixW3rljNiVHVu5zwYFkyHAy+2eTOh7RlxRqSqSJublSPOeypG9+awF7+1tplv7GuYT3c8a
 nLLjOdz6W7x+/0v87l7OuDRzuANcr5lwsk58Uqye+JCdNg+qDnYtrFSvU4h4dWK3BOnVW8zedQw
 NK6VU9PrdRkWpZ41aS+1Xd+ggmgjiifBvn8S860rfxhSN5+IOdq81lvWo3yN9Zqv5PyXuHYesXf
 aWYHtkgwf8aFkP2foo3NFAYefdPmFNNuHEqgJZ73NcJssJA74tUi8Xdt1FPRe5i93YLQDwnENK9
 DEY0qHV1EDxvi69OYeG21GXs32QvNbWNuXZnypA9dpLV5X7IQF16IgNQrHi4mV1QqlLmV4lek6z
 9k5jKAQissWmz+ptKkEfzxCuSQJ1rChHvgOaZrIBjvUkQDfaCu8QmyLjheA8fkcRWFVhsNO1VCT
 60cMFlQcKEcYv1tFgpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on powerpc64.

The first patch in series is fix patch, correcting memory alignment with
8-byte boundary for long branch address field. The subsequent patches
enables verifier selftests on powerpc. The fifth patch in the series fixes
incorrect comparator usage for comparing tailcall info with tailcall
threshold. The last two patches fix JIT buffer overflow for large BPF progs
and private stack memory leak (identified by bot during reviews).

Issue Details:
--------------

    The Long branch stub in the trampoline implementation[1] provides
    flexibility to handles short as well as long branch distance to
    actual trampoline. Whereas, the 8 bytes long dummy_tramp_addr field
    sitting before long branch stub leads to failure when enabling
    verifier based seltest for ppc64.
    
    The verifier selftests require disassembing the final jited image
    to get native instructions. Later the disassembled instruction
    sequence is matched against sequence of instructions provided in
    test-file under __jited() wrapper. The final jited image contains
    Out-of-line stub and Long branch stub as part of epilogue jitting
    for a bpf program. The 8 bytes space for dummy_tramp is sandwiched
    between both above mentioned stubs. These 8 bytes contain memory
    address of dummy trampoline during trampoline invocation which don't
    correspond to any powerpc instructions. So, disassembly fails
    resulting in failure of verifier selftests.
    
    The following code snippet shows the problem with current arrangement
    made for dummy_tramp_addr.
    
    /* Out-of-line stub */
    mflr    r0  
    [b|bl]  tramp
    mtlr    r0 //only with OOL 
    b       bpf_func + 4 
    /* Long branch stub */
    .long   <dummy_tramp_addr>  <---Invalid bytes sequence, disassembly fails
    mflr    r11 
    bcl     20,31,$+4
    mflr    r12 
    ld      r12, -8-SZL(r12)
    mtctr   r12 
    mtlr    r11 //retain ftrace ABI 
    bctr

    Consider test program binary of size 112 bytes:
    0:  00000060 10004de8 00002039 f8ff21f9 81ff21f8 7000e1fb 3000e13b
    28: 3000e13b 2a006038 f8ff7ff8 00000039 7000e1eb 80002138 7843037d
    56: 2000804e a602087c 00000060 a603087c bcffff4b c0341d00 000000c0
    84: a602687d 05009f42 a602887d f0ff8ce9 a603897d a603687d 2004804e

    Disassembly output of above binary for ppc64le:
    pc:0     left:112    00 00 00 60  :  nop
    pc:4     left:108    10 00 4d e8  :  ld 2, 16(13)
    pc:8     left:104    00 00 20 39  :  li 9, 0
    pc:12    left:100    f8 ff 21 f9  :  std 9, -8(1)
    pc:16    left:96     81 ff 21 f8  :  stdu 1, -128(1)
    pc:20    left:92     70 00 e1 fb  :  std 31, 112(1)
    pc:24    left:88     30 00 e1 3b  :  addi 31, 1, 48
    pc:28    left:84     30 00 e1 3b  :  addi 31, 1, 48
    pc:32    left:80     2a 00 60 38  :  li 3, 42
    pc:36    left:76     f8 ff 7f f8  :  std 3, -8(31)
    pc:40    left:72     00 00 00 39  :  li 8, 0
    pc:44    left:68     70 00 e1 eb  :  ld 31, 112(1)
    pc:48    left:64     80 00 21 38  :  addi 1, 1, 128
    pc:52    left:60     78 43 03 7d  :  mr    3, 8
    pc:56    left:56     20 00 80 4e  :  blr
    pc:60    left:52     a6 02 08 7c  :  mflr 0
    pc:64    left:48     00 00 00 60  :  nop
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     c0 34 1d 00  :
    ...

    Failure log:
    Can't disasm instruction at offset 76: c0 34 1d 00 00 00 00 c0 a6 02 68 7d 05 00 9f 42
    --------------------------------------

    Observation:
    Can't disasm instruction at offset 76 as this address has
    ".long <dummy_tramp_addr>" (0xc0341d00000000c0)
    But valid instructions follow at offset 84 onwards.

    Move the long branch address space to the bottom of the long
    branch stub. This allows uninterrupted disassembly until the
    last 8 bytes. Exclude these last bytes from the overall
    program length to prevent failure in assembly generation.

    Following is disassembler output for same test program with moved down
    dummy_tramp_addr field:
    .....
    .....
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     a6 02 68 7d  :  mflr 11
    pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
    pc:84    left:28     a6 02 88 7d  :  mflr 12
    pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
    pc:92    left:20     a6 03 89 7d  :  mtctr 12
    pc:96    left:16     a6 03 68 7d  :  mtlr 11
    pc:100   left:12     20 04 80 4e  :  bctr
    pc:104   left:8      c0 34 1d 00  :

    Failure log:
    Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
    ---------------------------------------
    Disassembly logic can truncate at 104, ignoring last 8 bytes.

    Update the dummy_tramp_addr field offset calculation from the end
    of the program to reflect its new location, for bpf_arch_text_poke()
    to update the actual trampoline's address in this field.

    [1] https://lore.kernel.org/all/20241030070850.1361304-18-hbathini@linux.ibm.com

v12->v13:
  Moved patch 4 and 5 before 1.
  Modified comments in code.

v11->v12:
  Fix build failure for ppc32
  Rearranged the order of patches as suggested by Hari

v10->v11:
  Moved function prototype change from patch 2 to patch 1
  Fixed commit message for patch 1 and patch 4
  Fixed extable entry generation condition
  Added reviewed and acked tags by Hari

v9->v10:
  Modified expected JIT instruction in selftest for
  CONFIG_PPC_KERNEL_PCREL incase of PPC_LI64 instruction.
  Fix for stale entries in exception table 
  Update ARCH_POWERPC64 enum value to 0x40 to resolve rebase
  conflict with ARCH_LOONGARCH (0x20).

v8->v9:
  Dynamic pass handling until code keeps shrinking
  Fix private stack memory leak

v7->v8:
  Fixed bot identified issues of alt_exit_addr and BPF_EXIT
  Fixed 32-bit ppc function signature mismatch

v6->v7:
  Fixed JIT buffer overflow in case of large BPF progs
  Addressed remaining bot comments

v5->v6:
  Changed alignment NOP emittion dependency on fimage layout
  Adjust tail truncate length for 32-bit ppc
  Addressed few minor bot comments

v4->v5:
  Handled alignment NOP emit logic and corresponding stub offsets
  Handled image buffer overflow problem in last pass
  Above changes took care of other bot reviews
  Included LLVMDisposeMessage() for graceful freeing
  Adjusted parameters in bpf_jit_build_fentry_stubs for ppc32
  Adjusted expected JIT inst. in tailcall test for
CONFIG_PPC_KERNEL_PCREL config
  Added fix patch at last for inaccurate use of cmplwi inst. 

v3->v4:
  Changed logic for emitting alignment NOP

v2->v3:
  Removed fixed NOP from bottom of long branch stub
  Rebased on top of bpf-next

v1->v2:
  Added fix-patch to correct memory alignment in-place
  Moved the optional alignmnet NOP before OOL stub

[v1]: https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260403004011.44417-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260411221413.44304-1-adubey@linux.ibm.com
[v4]: https://lore.kernel.org/bpf/20260517214043.12975-1-adubey@linux.ibm.com
[v5]: https://lore.kernel.org/bpf/20260519233812.18787-1-adubey@linux.ibm.com
[v6]: https://lore.kernel.org/bpf/20260529015855.364704-1-adubey@linux.ibm.com
[v7]: https://lore.kernel.org/bpf/20260611153826.31187-1-adubey@linux.ibm.com
[v8]: https://lore.kernel.org/bpf/20260616164741.32252-1-adubey@linux.ibm.com
[v9]: https://lore.kernel.org/bpf/20260623231411.6216-1-adubey@linux.ibm.com/
[v10]: https://lore.kernel.org/all/cover.1785871099.git.skb99@linux.ibm.com/
[v11]: https://lore.kernel.org/all/cover.1785871099.git.skb99@linux.ibm.com/#r
[v12]: https://lore.kernel.org/all/cover.1786611077.git.skb99@linux.ibm.com/

Abhishek Dubey (8):
  powerpc64/bpf: fix compare instruction emitted for tailcall
  powerpc64/bpf: fix percpu private stack leak on JIT failure
  powerpc/bpf: fix buffer overflow in JIT for large BPF programs
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftests/bpf: Fix powerpc JIT disassembly failure
  selftests/bpf: Enable verifier selftest for powerpc64
  selftests/bpf: Add tailcall verifier selftest for powerpc64

 arch/powerpc/net/bpf_jit.h                    |  20 +++-
 arch/powerpc/net/bpf_jit_comp.c               | 100 +++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c             |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  15 +--
 .../selftests/bpf/jit_disasm_helpers.c        |  25 ++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/verifier_tailcall_jit.c         |  78 ++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   5 +
 8 files changed, 211 insertions(+), 40 deletions(-)

-- 
2.55.0


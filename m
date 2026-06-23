Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224237C92B;
	Tue, 23 Jun 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242066; cv=none; b=P+1voZCdDaXWG7zDmydYLVq8uG2G/6Bh1W5xSPKJaDWeciRKTSPcOopaeqrkfnfa5Dy9gyFRdcYSSW3HKaTyGQtfLRP3KbWIM1VeGlpr4SA0385TXVz/eRW8vb+42XMxdnZq3C4Lxb4dvD6rSqeEM0xCgwvpOfd7mdD0Z0/5W6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242066; c=relaxed/simple;
	bh=9HNdpNEkqB+7GpoiT2Meh9mA6e4fla0OSdYSX5909gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gizra3RcXIPtPT5G95dPuSsLAPWM7I+6KKUA2ZKPGPlZ1tbSNrigR4cytAguce9jecqHRhSu5YDCSMT0eRn7Gb2HzM2o9qbW6u50IpOEB8wk58mesyTkCK6SP7nwPUThVxC3fZtSh51a6BOuWdAIcDkS3ZMjgb29UNQam6geOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lRo+UJR7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lRo+UJR7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmUnZ1914682;
	Tue, 23 Jun 2026 19:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ph0CDKzClSVSxwgMiAis65426kh2RYhkSUac2QL0Z
	ik=; b=lRo+UJR7tjmv3jqmC4Rv6use4DhmZDlZpR5hEye+/UjlWYAMlhy56wM1n
	TFKyDqdkTnf+5gghIgA76KVlDl+6xrHBHhbm5qaNRt4OvM30+ylqv8mFA6cv34Kh
	sFcGQqhrFKHRp+CRbgWxG35GKYeXEOMGHg0f0fNli2bkCD+4hvDt1Wf4NveNu517
	O2zmgu6WwHWPpLs1QVU2/i+E/q0X5KYbyUPLAZdU8aUxYWcik1eBzNpBWKJfUDhL
	/YznIhNGalkei79rp00I5dDjr7j0SS09HPiaACc9ok2xpYamX2fKgXFobr6W8eef
	9PXJAAI0gkhraC7utTlKtX0ORXYqg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4gedd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4dX1024854;
	Tue, 23 Jun 2026 19:14:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qd5xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJE0wW24838614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB79E20043;
	Tue, 23 Jun 2026 19:14:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F6620040;
	Tue, 23 Jun 2026 19:13:58 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:13:58 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH bpf v9 0/8] powerpc/bpf: address missing verifier selftest coverage
Date: Tue, 23 Jun 2026 19:14:03 -0400
Message-ID: <20260623231411.6216-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfXzjdop/C3PrTL
 xlKh4LZBK0f+pi2rr7yOsPpKsdC/op7wYa3GPN0WBLmJo2Yn2mdGikPyB+Dx6aOrG00a/IizHjR
 OHqb3jeSX7J5Mw9HnapV59Tk10q1aX4=
X-Proofpoint-ORIG-GUID: 2N2-pspHqwtRcMFxQMxO8xXUwb-tbkbN
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3adafd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fKsxTWJvHqBfRfrz3VUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX3/BbGV66GsHL
 2dJr17W04H1flcbSM9ocol8vfsVvojhskesqHGN1aapQkJ5sJrSp9zSTnw4ORV4nAtR9M2GjIJo
 ILMP4NlK5L/geiTRA4KNjpsNjDqhJMG+Go4KfUmNGQoTMsqvLRmiNHJJ+lnKtW3k65zet7S5wr5
 jDRMErRUWTjmu81/eKcNArdpBptNYjf1Kuym9lBFku6PM0femTa9g4wlcoTyVGUbM8sS+QK7bD3
 bSu41tR6fmSP87i0ZUkTuI4zTWrk+ggOeKF7qNICnQuxfBn0LG6F0lRijkW4ANW+72XRuSfHT7t
 H3fIiZYaS+95zQZsw1prFjis7rXr7te25KQK89kqWgSwa0W+kI7rdr7ygzRBTENOYr48MfbMbXa
 joubzSkToq3v92Zy1gP3+/4ZkcoaGMJTftQOpBS0bEa0wTYM+GmnkfTLZhvFzA3n49f+EzWqUOy
 /p0n+qWEYt+63O+JzpQ==
X-Proofpoint-GUID: 2N2-pspHqwtRcMFxQMxO8xXUwb-tbkbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155

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

Abhishek Dubey (8):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  powerpc64/bpf: fix compare instruction emitted for tailcall
  selftest/bpf: Add tailcall verifier selftest for powerpc64
  powerpc/bpf: fix buffer overflow in JIT for large BPF programs
  powerpc64/bpf: fix percpu private stack leak on JIT failure

 arch/powerpc/net/bpf_jit.h                    | 20 +++-
 arch/powerpc/net/bpf_jit_comp.c               | 99 ++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c             |  7 +-
 arch/powerpc/net/bpf_jit_comp64.c             | 15 +--
 .../selftests/bpf/jit_disasm_helpers.c        | 27 ++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 +
 8 files changed, 203 insertions(+), 40 deletions(-)

-- 
2.52.0


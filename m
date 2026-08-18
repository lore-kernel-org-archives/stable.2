Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FC32D0E3;
	Tue, 18 Aug 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028262; cv=none; b=cksJUEO7MxpcQAbhoxDR56Tn8ZgFhlGu0Q8JKCO3GAoH2N8gvsU1XeLSySoNvImbDZVRYpGl1M5vw8mnuIISbPcYDUO7NTsffyVot6pohO+P59AMjFP2ZFekB4Dt/dsy/PMAmERWx7desz91ck71pUmTZPlUaBTrVw2AZ3nRKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028262; c=relaxed/simple;
	bh=QYK2mBaAue2NDZlzNALa7J9KoJ/wsGhZAnYGruINCvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNq3j2Nf0/iep4ts/I7vQ7zoQ9HxPfRwwMf52rBmVxJFXMfhBMXCwEoY0ACcX71Vo5uJFuS/9fBq65ZNyNf+5iMIgQ7Hvz8mbuSCOouMx+MLh/VkQuao0ODe34knammoOsN0NNUvhF+ioi6G2VCB18vb3qNnDSoilh/gfSoCvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=akkR0pX1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="akkR0pX1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1edP2668957;
	Tue, 18 Aug 2026 04:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vtC8N5f8Dde162SF8V8JX3MZtdiR0XWU8AX+xDiOe
	Xw=; b=akkR0pX1kNzBrgU4kRBFyzppmkiGnIWKXO5+3fpuob6xWn+36phet1a1v
	B7m6kCMttHRdH1GW0xwXKykh4KHx6gPK46o1SzL1UuAIXeyGvz3LnsXjLTseQops
	zpLsnZrn0ZWV2zNH3GN3dYk+Y12ijQltUvclSMC2mjqPIBQfY35iFDj58V2o84qA
	9mTquoGu+ggaKvdjN0zhRdsXD3Ftn0zleMayu3SULnCmEczBas1Mvwu5w0bFAX2x
	fWxqs2OotkO8nzyXVG+bDS8/+Q2G/l25J1a4Ad4O1cnP4GCkzmYjNEqKGsz8yubo
	ODJkFtYXCzSDpel4oABLlKBwQH+PQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt5jkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:43:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4QN2p027098;
	Tue, 18 Aug 2026 04:43:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw1f74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:43:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4hs8k51970498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:43:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A97B2004B;
	Tue, 18 Aug 2026 04:43:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7419420049;
	Tue, 18 Aug 2026 04:43:44 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:43:43 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 0/8] powerpc/bpf: address missing verifier selftest coverage 
Date: Tue, 18 Aug 2026 10:13:33 +0530
Message-ID: <cover.1786611077.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a83e30f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=N7QzuYTHEryR9oxcy7gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXzWD/FETzZzKX
 zYVDigZqHLAd+voGHY9aAl1a+T5h/7ZVQ0U+ApYBvhHXiEwrrVwYmIuMpI6QWgNUngyoDJKkeeQ
 9V+UEJk0vYnfDZjowpjx/Ptzfh7A/V4=
X-Proofpoint-GUID: FZJOh7puFE4XL30i0grjPf_vGUbkGcQQ
X-Proofpoint-ORIG-GUID: FZJOh7puFE4XL30i0grjPf_vGUbkGcQQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXwIX2t9GpVxE9
 0ZTxDKkCzQGe4WRSgrMbyf+zj19hCu/2yF8eIpacjxbjO1uqpxFvLpSebFTNbc/k+gvcR+U3Fvh
 UqccIPxxPNWey1cluXVAV4xOC/VzTlR86ERXZT+H2CQhxOBKn6k0tIbRuYmko/UozZwarcQvrft
 yqz2RiuPOtB8e4kpEFJ/gUlagT9/CS+2AAp7JGakmFTFg918+sZ3oEOpc1iFgoStqUN6YbVoIpT
 cTmxnXVb/6pD+Zl+zR+5kv0n/yB6V7mIOBkacdPIpQfU4/THG22aRuXHtAT/AbxqqZQ71b4GHbh
 8Wb3fQiOtzfsSpLuS3VImQvoawjUheYZGX0YmTM7vMAwBE7U+O7HH7aga7nyV8tjnguOXHN9tsZ
 xjigCj66yxWWjL4sOryWuuzR4wVWCaqOIyoXqYiqV38RYDQTBqnSwBOOjwiA1W5mSe3BV+NIrF3
 ppTExje0aBA71Ub2WOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180031

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

Abhishek Dubey (8):
  powerpc/bpf: fix buffer overflow in JIT for large BPF programs
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  powerpc64/bpf: fix compare instruction emitted for tailcall
  powerpc64/bpf: fix percpu private stack leak on JIT failure
  selftests/bpf: Fixing powerpc JIT disassembly failure
  selftests/bpf: Enable verifier selftest for powerpc64
  selftests/bpf: Add tailcall verifier selftest for powerpc64

 arch/powerpc/net/bpf_jit.h                    |  20 +++-
 arch/powerpc/net/bpf_jit_comp.c               | 102 +++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c             |   7 +-
 arch/powerpc/net/bpf_jit_comp64.c             |  15 +--
 .../selftests/bpf/jit_disasm_helpers.c        |  25 ++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../bpf/progs/verifier_tailcall_jit.c         |  75 +++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   5 +
 8 files changed, 210 insertions(+), 40 deletions(-)

-- 
2.55.0


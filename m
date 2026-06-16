Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5973382DC;
	Tue, 16 Jun 2026 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614113; cv=none; b=HPkDLfDny15Sv3OJ0XBvt++JAspG/pWN/Y+9SrEqIw6RoTcVjYWocqF/HBy+OU1OLHwoFgK3BH90Fw+lHm/YWGcH+5bJh9oKDsts5u2mRAZyzi1wEIGQaRW4jG1brq6u5dXum+LUcf+bBMP+jp0UKYiWWfDH2RCyTlLcWMn62r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614113; c=relaxed/simple;
	bh=hVhWc268az8O4PtBUHVZMCEiBnAJT+yxM0hFZ11kP+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovClt7shQlmLiwGz+srFUI3VcjKRLVw6gUNvUOo6LI2nf9UjalrJR4pV9xBHsJFBk7j2qIdf0V8VklI09YuELC6hGdadurEllKlJtqrbwNXqX7GoOAPmRx+HVXVGwlgg+8Vd0kB+kywl0W+Q/r59gqzZ4rUAkVJyAXhL4nUP2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K08yR9Lr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K08yR9Lr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIkkg1135632;
	Tue, 16 Jun 2026 12:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JmZjVLyYt2Jdu0KiD3Xh8P5rAdhxowVUkLDvUuq0E
	X8=; b=K08yR9LrIdQmzmqPZFlrFeJQDp0pspi7w2fRtRNhqNvXLAsypvjYCoIro
	7W8mlg2DrJYjxw4MF8Fk1XeIePVrtBe7+IhtYyt2uY3NetaGJW7OfP9ueQ6z5uKw
	0EBUvGAMDhGJgw4FjV1yZt8W1i8WTPVU03YedC7id4fd4FD1TArSaXtqxZzoySLT
	AL+sWjJZpj58EZCPhhQq7YCEgTSOxROE6uywN7Lr8/IoZKR5uDfIwS63s4WJnSSx
	LnuLBDVRTMhquGaifPdx/owTmQ+fWT5o3l4iAphRW2eUFehCXDFbSBkH65aFshMw
	cHSul6SeXfY4V0iSyikrAw6Wtavxg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0n5k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYi4V022470;
	Tue, 16 Jun 2026 12:48:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y3438-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCm9ft49611198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:48:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE592004B;
	Tue, 16 Jun 2026 12:48:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBD620040;
	Tue, 16 Jun 2026 12:48:06 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:48:06 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [bpf v8 0/7] powerpc/bpf: address missing verifier selftest coverage
Date: Tue, 16 Jun 2026 12:47:34 -0400
Message-ID: <20260616164741.32252-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VuZiljQB4oj4qLq5Q97hRpmRhHKDyf6U
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a31460d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fKsxTWJvHqBfRfrz3VUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX+DHT9Sq8XXNC
 6LZNm0xfczrX2zbOE5er10f271yyJxK2LHsDdd3bbwvbKJfMPFQ+fzSYn9Ar5A0VzgXXlT+L3rp
 cKVS25M9ze5BM7dG1J1Ki4odXDDvY4K21j494pKO4imwD68ZTA0teJe93kBWfzsgu+hG+eO1ZQ9
 P4gkBvD6vsgZFWYPr9Oncvph2gY1yZ0rR+TLNx4PVJqkiSnF0NytkItH6uhNpng37WHyGxnBmxD
 Y9lY8OPs7zt8tFwGYbDWyPee31tIXBCWkdeGofb1ahweHurdeojevq7xa1SU//+8Toh2ywSi4RH
 SdoV6zUDWWjEzIMLwMQa/pqyWxzyfd1uXmjRrz5dJQbCk7Pzv/aN6x+v+QzU0dVTMPLWeHOjm9b
 3s3npZSBELMcJh7CKZUbTh3avbVKkEo62gu27HsuB4E5P9IIH0AJAZZoGkcABArbiBFXFVxUob4
 LwlFZ3FJgn0HkKV1wBw==
X-Proofpoint-ORIG-GUID: VuZiljQB4oj4qLq5Q97hRpmRhHKDyf6U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX2Kf0hzOieB+M
 zTmGQJFpll8yfixwDN2zjl/oa5/e6aGskb7zPDCnrQ8JBUSXcIe20CVkGGzaOH9lBM6h6F2ay04
 Fe8rhNoaGE9di6ZrQkO/sUVa0Vpir0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160130

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on powerpc64
in the final patch.

The first patch in series is fix patch, correcting memory alignment with
8-byte boundary for long branch address field. The subsequent patches
enables verifier selftests on powerpc. The fifth patch in the series fixes
incorrect comparator usage for comparing tailcall info with tailcall
threshold. The last patch fixes JIT buffer overflow for large BPF progs.

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

Abhishek Dubey (7):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  powerpc64/bpf: fix compare instruction emitted for tailcall
  selftest/bpf: Add tailcall verifier selftest for powerpc64
  powerpc/bpf: fix buffer overflow in JIT for large BPF programs

 arch/powerpc/net/bpf_jit.h                    | 13 +++-
 arch/powerpc/net/bpf_jit_comp.c               | 75 +++++++++++++------
 arch/powerpc/net/bpf_jit_comp32.c             |  7 +-
 arch/powerpc/net/bpf_jit_comp64.c             | 15 ++--
 .../selftests/bpf/jit_disasm_helpers.c        | 27 ++++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 ++
 8 files changed, 176 insertions(+), 36 deletions(-)

-- 
2.52.0


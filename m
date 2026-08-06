Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A388E68;
	Thu,  6 Aug 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037672; cv=none; b=MevOZ3uoRTddZ4w4+OsfHwilTeApaNmRdHsVovboSP+A+PuuDog72SBtFCjeptwX8r/3V4z45qX8PPkmfK6P5TwRVjaJhU36WxzeyGnkRtmQjfED99z4AC1T/LiIdcRX6kxlYAEql8+HANhhOwxdkBV1g7MRoSjZJv23tP7yRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037672; c=relaxed/simple;
	bh=eeQ7xa7mqcJ7qAXt9ifCLUwBS2z/j03L20M3pIaAycI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkRkCzUCvWRFbTZSY+DSJ6SfcmKhuliuXstGBBphCvN71v3//OqPFLGpSM69ZyRGBTINdYy+L4aOlW3qV9CfQIFuwzYiPLiUJBIzkOt3zXI2ixG456TkWd1FjZBC9QtX+GP1GdNEZmFIidJ13haeBPagMBl7/s23klxkyCfZ7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IzTtf4Ou; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IzTtf4Ou"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIUxx3193457;
	Thu, 6 Aug 2026 17:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sjBl51
	OhsjwvBiikzAG55czWxr/saqtgmsNJeaUQrp8=; b=IzTtf4Ou+mGHqFEsWo23c0
	DFWpZOmQNaiTdv5b6I/EaTHWtGPW3vjesNHWQBxjN0J7NkQY5PSgXt31bFW+xmeu
	+jUuAeCu22sltnFhKZ31I5SrAaU/hUZuhwP3ReD6mkiB1DhxciCALmGakU29DUSn
	a1z2RbBUChi2O8snhpChWn5zVhq2dNuIOakdNE5vACTXSO7ryCPsyA2/TVbldOox
	l8stO3OzdE8CA710A/n1wpEyS0kv0mL1XuYt8ifwQmCz7A9GelJ0eKXtVrMkjuqp
	JkS5K/MtNHMpDzUhBwPQ1go4HyCUpI/8rksfCbro2lNx5iNvO7Pi4rIuTvWzNPnQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gh2y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:34:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQfoL013801;
	Thu, 6 Aug 2026 17:34:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwcart-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:34:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HY9Mu33292744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:34:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0093420043;
	Thu,  6 Aug 2026 17:34:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08D420040;
	Thu,  6 Aug 2026 17:34:05 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:34:05 +0000 (GMT)
Message-ID: <7ffaff94-b1b1-4420-8c19-c88bf49139a6@linux.ibm.com>
Date: Thu, 6 Aug 2026 23:04:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] powerpc/bpf: address missing verifier selftest
 coverage
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785871099.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <cover.1785871099.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfXz0eNHxrKCAc2
 7cOhZVc+1Hu1K+QrowKkBPRJG6AYAfbPSM3pBCLVJyQ098ky35dTaQxfkN3cB25PbAwIqS+NSGu
 LeW2ByIzVBViSSPFOK4X1J1RBPaWgTaySYrXpuRcSx+2yJR8htNMuDN/PhL5NGyhHum2NINpxGq
 LzUeLNtIoKor/zwHWqk1HkwC4wcAkP0qRALHg6jYKc4q8bm4yF8u6OypxEr2Rer74xQYFco313O
 c+Gm9UZW5AnfTbjTYym3jxs4B96UPHaMXTk8RP+jL8lp+9OTMJxlZEC86pZhcfnvnkMruqQ7xoO
 B/h3aCYg0oEJZFO/CLzV8iuW4UH7+y+hRn7Y3jzaGTEm5sk1hvz0TFjXdABkAJT+05CFtPPKlL0
 q4LQZWxZGK43eAJRDOIvgsyFYQXR+Ncnw7mKzKQZGtpJJbnZZ2/Tw1gi3oa/g9XZ74cQSn/riiI
 8ddAGn0XkZwmjSRVTTg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74c595 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NMmoX83GTePcWBc1ta0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _Xtn6_qUWWmjqDQQUIo7Lke3hwJsnIl8
X-Proofpoint-ORIG-GUID: _Xtn6_qUWWmjqDQQUIo7Lke3hwJsnIl8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX99dOJ0yZek9n
 I5WiDTwTXmWWBtBXEBnwwIfdj8DzejCXgjF2f6oD4L/fuHW9sxrX9dVJtSwh5OkLmBDq61UUHfr
 i0Iskqd3b9NYRiuYz5lbeFGuDFDgUNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135



On 05/08/26 11:36 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The verifier selftest validates JITed instructions by matching expected
> disassembly output. The first two patches fix issues in powerpc instruction
> disassembly that were causing test flow failures. The fix is common for
> 64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
> architecture tag in the third patch, enabling proper test filtering in
> verifier test files. Introduce verifier testcases for tailcalls on powerpc64.
> 
> The first patch in series is fix patch, correcting memory alignment with
> 8-byte boundary for long branch address field. The subsequent patches
> enables verifier selftests on powerpc. The fifth patch in the series fixes
> incorrect comparator usage for comparing tailcall info with tailcall
> threshold. The last two patches fix JIT buffer overflow for large BPF progs
> and private stack memory leak (identified by bot during reviews).
> 
> Issue Details:
> --------------
> 
>      The Long branch stub in the trampoline implementation[1] provides
>      flexibility to handles short as well as long branch distance to
>      actual trampoline. Whereas, the 8 bytes long dummy_tramp_addr field
>      sitting before long branch stub leads to failure when enabling
>      verifier based seltest for ppc64.
>      
>      The verifier selftests require disassembing the final jited image
>      to get native instructions. Later the disassembled instruction
>      sequence is matched against sequence of instructions provided in
>      test-file under __jited() wrapper. The final jited image contains
>      Out-of-line stub and Long branch stub as part of epilogue jitting
>      for a bpf program. The 8 bytes space for dummy_tramp is sandwiched
>      between both above mentioned stubs. These 8 bytes contain memory
>      address of dummy trampoline during trampoline invocation which don't
>      correspond to any powerpc instructions. So, disassembly fails
>      resulting in failure of verifier selftests.
>      
>      The following code snippet shows the problem with current arrangement
>      made for dummy_tramp_addr.
>      
>      /* Out-of-line stub */
>      mflr    r0
>      [b|bl]  tramp
>      mtlr    r0 //only with OOL
>      b       bpf_func + 4
>      /* Long branch stub */
>      .long   <dummy_tramp_addr>  <---Invalid bytes sequence, disassembly fails
>      mflr    r11
>      bcl     20,31,$+4
>      mflr    r12
>      ld      r12, -8-SZL(r12)
>      mtctr   r12
>      mtlr    r11 //retain ftrace ABI
>      bctr
> 
>      Consider test program binary of size 112 bytes:
>      0:  00000060 10004de8 00002039 f8ff21f9 81ff21f8 7000e1fb 3000e13b
>      28: 3000e13b 2a006038 f8ff7ff8 00000039 7000e1eb 80002138 7843037d
>      56: 2000804e a602087c 00000060 a603087c bcffff4b c0341d00 000000c0
>      84: a602687d 05009f42 a602887d f0ff8ce9 a603897d a603687d 2004804e
> 
>      Disassembly output of above binary for ppc64le:
>      pc:0     left:112    00 00 00 60  :  nop
>      pc:4     left:108    10 00 4d e8  :  ld 2, 16(13)
>      pc:8     left:104    00 00 20 39  :  li 9, 0
>      pc:12    left:100    f8 ff 21 f9  :  std 9, -8(1)
>      pc:16    left:96     81 ff 21 f8  :  stdu 1, -128(1)
>      pc:20    left:92     70 00 e1 fb  :  std 31, 112(1)
>      pc:24    left:88     30 00 e1 3b  :  addi 31, 1, 48
>      pc:28    left:84     30 00 e1 3b  :  addi 31, 1, 48
>      pc:32    left:80     2a 00 60 38  :  li 3, 42
>      pc:36    left:76     f8 ff 7f f8  :  std 3, -8(31)
>      pc:40    left:72     00 00 00 39  :  li 8, 0
>      pc:44    left:68     70 00 e1 eb  :  ld 31, 112(1)
>      pc:48    left:64     80 00 21 38  :  addi 1, 1, 128
>      pc:52    left:60     78 43 03 7d  :  mr    3, 8
>      pc:56    left:56     20 00 80 4e  :  blr
>      pc:60    left:52     a6 02 08 7c  :  mflr 0
>      pc:64    left:48     00 00 00 60  :  nop
>      pc:68    left:44     a6 03 08 7c  :  mtlr 0
>      pc:72    left:40     bc ff ff 4b  :  b .-68
>      pc:76    left:36     c0 34 1d 00  :
>      ...
> 
>      Failure log:
>      Can't disasm instruction at offset 76: c0 34 1d 00 00 00 00 c0 a6 02 68 7d 05 00 9f 42
>      --------------------------------------
> 
>      Observation:
>      Can't disasm instruction at offset 76 as this address has
>      ".long <dummy_tramp_addr>" (0xc0341d00000000c0)
>      But valid instructions follow at offset 84 onwards.
> 
>      Move the long branch address space to the bottom of the long
>      branch stub. This allows uninterrupted disassembly until the
>      last 8 bytes. Exclude these last bytes from the overall
>      program length to prevent failure in assembly generation.
> 
>      Following is disassembler output for same test program with moved down
>      dummy_tramp_addr field:
>      .....
>      .....
>      pc:68    left:44     a6 03 08 7c  :  mtlr 0
>      pc:72    left:40     bc ff ff 4b  :  b .-68
>      pc:76    left:36     a6 02 68 7d  :  mflr 11
>      pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>      pc:84    left:28     a6 02 88 7d  :  mflr 12
>      pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>      pc:92    left:20     a6 03 89 7d  :  mtctr 12
>      pc:96    left:16     a6 03 68 7d  :  mtlr 11
>      pc:100   left:12     20 04 80 4e  :  bctr
>      pc:104   left:8      c0 34 1d 00  :
> 
>      Failure log:
>      Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>      ---------------------------------------
>      Disassembly logic can truncate at 104, ignoring last 8 bytes.
> 
>      Update the dummy_tramp_addr field offset calculation from the end
>      of the program to reflect its new location, for bpf_arch_text_poke()
>      to update the actual trampoline's address in this field.
> 
>      [1] https://lore.kernel.org/all/20241030070850.1361304-18-hbathini@linux.ibm.com
> 
> v9->v10:
>    Modified expected JIT instruction in selftest for
>    CONFIG_PPC_KERNEL_PCREL incase of PPC_LI64 instruction.
>    Fix for stale entries in exception table
>    Update ARCH_POWERPC64 enum value to 0x40 to resolve rebase
>    conflict with ARCH_LOONGARCH (0x20).
> 
> v8->v9:
>    Dynamic pass handling until code keeps shrinking
>    Fix private stack memory leak
> 
> v7->v8:
>    Fixed bot identified issues of alt_exit_addr and BPF_EXIT
>    Fixed 32-bit ppc function signature mismatch
> 
> v6->v7:
>    Fixed JIT buffer overflow in case of large BPF progs
>    Addressed remaining bot comments
> 
> v5->v6:
>    Changed alignment NOP emittion dependency on fimage layout
>    Adjust tail truncate length for 32-bit ppc
>    Addressed few minor bot comments
> 
> v4->v5:
>    Handled alignment NOP emit logic and corresponding stub offsets
>    Handled image buffer overflow problem in last pass
>    Above changes took care of other bot reviews
>    Included LLVMDisposeMessage() for graceful freeing
>    Adjusted parameters in bpf_jit_build_fentry_stubs for ppc32
>    Adjusted expected JIT inst. in tailcall test for
> CONFIG_PPC_KERNEL_PCREL config
>    Added fix patch at last for inaccurate use of cmplwi inst.
> 
> v3->v4:
>    Changed logic for emitting alignment NOP
> 
> v2->v3:
>    Removed fixed NOP from bottom of long branch stub
>    Rebased on top of bpf-next
> 
> v1->v2:
>    Added fix-patch to correct memory alignment in-place
>    Moved the optional alignmnet NOP before OOL stub
> 
> [v1]: https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com
> [v2]: https://lore.kernel.org/bpf/20260403004011.44417-1-adubey@linux.ibm.com
> [v3]: https://lore.kernel.org/bpf/20260411221413.44304-1-adubey@linux.ibm.com
> [v4]: https://lore.kernel.org/bpf/20260517214043.12975-1-adubey@linux.ibm.com
> [v5]: https://lore.kernel.org/bpf/20260519233812.18787-1-adubey@linux.ibm.com
> [v6]: https://lore.kernel.org/bpf/20260529015855.364704-1-adubey@linux.ibm.com
> [v7]: https://lore.kernel.org/bpf/20260611153826.31187-1-adubey@linux.ibm.com
> [v8]: https://lore.kernel.org/bpf/20260616164741.32252-1-adubey@linux.ibm.com
> [v9]: https://lore.kernel.org/bpf/20260623231411.6216-1-adubey@linux.ibm.com/
> 
> Abhishek Dubey (8):
>    powerpc/bpf: fix alignment of long branch trampoline addres to t
>    powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
>    selftest/bpf: Fixing powerpc JIT disassembly failure
>    selftest/bpf: Enable verifier selftest for powerpc64
>    powerpc64/bpf: fix compare instruction emitted for tailcall
>    selftest/bpf: Add tailcall verifier selftest for powerpc64
>    powerpc/bpf: fix buffer overflow in JIT for large BPF programs
>    powerpc64/bpf: fix percpu private stack leak on JIT failure
> 
>   arch/powerpc/net/bpf_jit.h                    |  20 +++-
>   arch/powerpc/net/bpf_jit_comp.c               | 102 +++++++++++++-----
>   arch/powerpc/net/bpf_jit_comp32.c             |   7 +-
>   arch/powerpc/net/bpf_jit_comp64.c             |  15 +--
>   .../selftests/bpf/jit_disasm_helpers.c        |  25 ++++-
>   tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
>   .../bpf/progs/verifier_tailcall_jit.c         |  74 +++++++++++++
>   tools/testing/selftests/bpf/test_loader.c     |   5 +
>   8 files changed, 209 insertions(+), 40 deletions(-)
> 

Alexei, Maddy,

Given this has changes in common code too, should this go via bpf tree?
If yes, @Saket can you post the next revision with bpf tag to make
it explicit...

- Hari

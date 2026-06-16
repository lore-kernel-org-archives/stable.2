Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983D3CF050
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587340; cv=none; b=HQM++WcXX9kvm8Tq77PvvO4MVsIDaIaKfBZ9SkOqIVRL97kXd/FAel9ABmX9EEQLe0vWFA2p0O5ZvepFP0VyB+SU/pBDw5Li69NUh4AGdgbPolW5EAks37XTEAdIt2JzXfFnrI40dV+VZy+RH3RqTa5PAApCueSTL5HBz3D0SmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587340; c=relaxed/simple;
	bh=dqoipzF6+ExSpX45zhDMk8Yes4fw664LmDW31qDISNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6pVwrm9/pGh4MD0b5naVa7mYzmcYcitp6miqlr+X/Ra+WcLnfjwEvcrttYz2vhpouAEBa7cYsxkMoPBkbXklAeR56VgRLEL1RFfPwJNXNBATjdgbAElNBtqOIcENYCe6zfO9CAASfL6p4mCcuRApwfLwvmJ84seQOWIcfNOQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ESRr4cRS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ESRr4cRS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso29278595e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781587337; x=1782192137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c67ojuRwymIv2WV684kE6WTrX7TOd/HRM9iLQb+9g+s=;
        b=ESRr4cRSqrhMOe1ev+f2EewUbL5d4jQx39lwxtotWVR8q6kQmxtaB27oJDhhlwOkmt
         DdJmY1F0Xh6zLzytJycF9FQgIhOc1A366IzbB5WyLkwhHZ9QgcY934UJw6m2zVeFwKkh
         nxasVpVxSETOdUVUMqNhQUN7E1muZg05DfrUt1jCNKhpEGdckSkGMQNc7RuCGE5oBmeE
         n1+19p2SC7MUzNKu1K1fM20VQyr0J+x7tTi14KmRNWrI7kprUqnu8Dz7bX7dNfKscgU0
         zhfKuOpjgvwnDfoTtvW2zY+AR/Ku2oiWouCOOZ347bNxUSn5llsW3qUvSdWN16K5Zrvl
         225Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781587337; x=1782192137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c67ojuRwymIv2WV684kE6WTrX7TOd/HRM9iLQb+9g+s=;
        b=gYcbRX2rmSKvsvMwO+li2MYS4pCcIc7geRVF/ZdYTUN2Lc3V2OJmsMEI9ifG1nuNDz
         QrC8RRGZumvWlRV4zlKXcFiRMt7qmiyZOOyt9paiJBmZJVahQOroDPivdYCo9vsPkq/h
         Viyl4KMtwykl2Gck8qUD0RO4yZ518gMkBOuFwT/pLw/vG4uW8qWCFDa4x3fump2UDP1M
         wk3WN9uNJvAFwR/z2zSwZ+MkVm7LfRGHjuRLCSvFLuDaMrznJdvNKELyoCgjvV/yIOTk
         szHmHnYjApazuBWWR4APuqmzDzqk5BzyU8SUllCAGTNjNG+eLejq3m1or5sJzptjqZkF
         CuIw==
X-Forwarded-Encrypted: i=1; AFNElJ8mxACyitTjXFEk/JL361wvRA8qCg5BwsuaAHbC0AheJAO8Cj9wKrtuM/5aVFqt4xqEshweD1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYCX3hiJu0YfkujHVS36MSMsV0kC2FauwgB+QUKyDdQjYQLoP
	w2asfZWPmMBpnrVdLzCcjHRjhisifIWyqFzqPSRKkwmxL3V6s9wcrk/tFjVPizwhPoo=
X-Gm-Gg: Acq92OFE3eif8N99bKF+dOrZlBep05KwWpa9mK9uY1DI1rt75X6usx+AoV2tLEvi2XY
	OzfsL0B8IjZbaNxUt73ejI62Kd/rGTzzMxw+7hGq+KVZq8hFCviDPQxrEfUjSLMg1J2SCqvjRvR
	8XEXsmFQ8L9O3G7Aa2tOvFf/5fDOv8bf50EY9SpxbvCizNf/ekJQ4a9SSg3L3zsB9J3pUxa1YQT
	UF7wZBCAPN9hrTxSLizQhbaE0pcK5RHAhtskFsfu3S0PdzE+XhIm2AKuhpfK1GbHU67wV7lLMxr
	C85km+0cNhwgTSjLFSh6g6gEvzKi6lf+nh8SeGLfhNOkDf+pxohN2mawXfvIDED4lEunz/mDMag
	BLlHfOgYIOeO/wuKyT7+Fy2iEHxeUQo1wYQcGuzUK5X0YIhNYuiXwEFGskKPbA3A0iPyoa1Cwxt
	NiIJmOF6HpE8aIjoyOZynJnDtZ2WN14iYXIwaGnEWmG9LtYI7wxYP+iPzV
X-Received: by 2002:a05:600c:8b81:b0:491:a220:6e48 with SMTP id 5b1f17b1804b1-4922ffbeca3mr25712055e9.32.1781587337243;
        Mon, 15 Jun 2026 22:22:17 -0700 (PDT)
Received: from u94a (39-12-139-247.adsl.fetnet.net. [39.12.139.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm17563707eec.5.2026.06.15.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:22:15 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:22:00 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Message-ID: <ajC3d44N4s0sdEBB@u94a>
References: <cover.1781194510.git.jt26wzz@gmail.com>
 <ajCB9jXBzPyaDNSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajCB9jXBzPyaDNSQ@mail.gmail.com>

On Tue, Jun 16, 2026 at 12:51:34AM +0200, Paul Chaignon wrote:
> On Mon, Jun 15, 2026 at 12:58:37AM +0800, Zhenzhong Wu wrote:
> > Hi,
> > 
> > This v3 targets 6.6.y and changes the backport strategy based on review
> > feedback on v2.
> 
> [...]
> 
> > Relevant QEMU selftest results on 6.6.y with this backport:
> > 
> >   verifier_scalar_ids passed all 18 subtests, including the newly
> >   backported linked-scalar precision tests and the related
> >   check_ids_in_regsafe tests.
> 
> The first patch in this backport series is actually breaking the
> "precise: test 1" selftest from test_verifier. You can see the full
> error at [1]. I haven't yet checked if it's the test or the backport
> that needs to be adjusted.

I had a quick look, and believe it was that test that needs to be
adjusted to include r9 into the precise register set.

So unless Sasha have other preference, I suggest Zhenzhong send a v4,
with changes to tools/testing/selftests/bpf/verifier/precise.c
(including "r9" the the expected verifier output) merged into "bpf:
Track equal scalars history on per-instruction level".

---

The program under test is:

  00: BPF_MOV64_IMM(BPF_REG_0, 1),
  01: BPF_LD_MAP_FD(BPF_REG_6, 0),
  03: BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
  04: BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
  05: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
  06: BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
  07: BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
  08: BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
  09: BPF_EXIT_INSN(),

  10: BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),

  11: BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
  12: BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
  13: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
  14: BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
  15: BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
  16: BPF_EXIT_INSN(),

  17: BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),

  18: BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -= map_value_ptr */
  19: BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
  20: BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
  21: BPF_EXIT_INSN(),

  22: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=scalar(umin=1, umax=8) */
  23: BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
  24: BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
  25: BPF_MOV64_IMM(BPF_REG_3, 0),
  26: BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
  27: BPF_EXIT_INSN(),

The test was expecting the following line in the verifier log that was
shown during the backtracking start at instruction 26 (call
bpf_probe_read_kernel#113) 

  mark_precise: frame0: regs=r2 stack= before 20: (a5) if r2 < 0x8 goto pc+1
  mark_precise: frame0: parent state regs=r2 stack=: ...
  mark_precise: frame0: last_idx 19 first_idx 10 ...

But after applying the patchset, we now got an additional register r9 in
the precise set:

  mark_precise: frame0: regs=r2 stack= before 20: (a5) if r2 < 0x8 goto pc+1
  mark_precise: frame0: parent state regs=r2,r9 stack=: ....
  mark_precise: frame0: last_idx 19 first_idx 10 ...

The additional r9 in the precise set seems actually correct, this is
because r2 and r9 share the same scalar ID at instruction 20 (before the
link got broken in instruction 21), and hence at that point, both
register should be marked as precise.

---

In upstream the test already has the expected verifier log to include
r9, and hence no failure, but it simply comes from the fact that r2 and
r9 maintain a link even after instruction 22 (r2 += 1).

  commit 98d7ca374ba4b39e7535613d40e159f09ca14da2
  Author: Alexei Starovoitov <ast@kernel.org>
  Date:   Wed Jun 12 18:38:13 2024 -0700
  
      bpf: Track delta between "linked" registers.
  ...
  --- a/tools/testing/selftests/bpf/verifier/precise.c
  +++ b/tools/testing/selftests/bpf/verifier/precise.c
  @@ -39,12 +39,12 @@
   	.result = VERBOSE_ACCEPT,
   	.errstr =
   	"mark_precise: frame0: last_idx 26 first_idx 20\
  -	mark_precise: frame0: regs=r2 stack= before 25\
  -	mark_precise: frame0: regs=r2 stack= before 24\
  -	mark_precise: frame0: regs=r2 stack= before 23\
  -	mark_precise: frame0: regs=r2 stack= before 22\
  -	mark_precise: frame0: regs=r2 stack= before 20\
  -	mark_precise: frame0: parent state regs=r2 stack=:\
  +	mark_precise: frame0: regs=r2,r9 stack= before 25\
  +	mark_precise: frame0: regs=r2,r9 stack= before 24\
  +	mark_precise: frame0: regs=r2,r9 stack= before 23\
  +	mark_precise: frame0: regs=r2,r9 stack= before 22\
  +	mark_precise: frame0: regs=r2,r9 stack= before 20\
  +	mark_precise: frame0: parent state regs=r2,r9 stack=:\
   	mark_precise: frame0: last_idx 19 first_idx 10\
   	mark_precise: frame0: regs=r2,r9 stack= before 19\
   	mark_precise: frame0: regs=r9 stack= before 18\
  ...

---

Full test log below

  #492/p precise: test 1 FAIL
  Unexpected verifier log!
  EXP: mark_precise: frame0: parent state regs=r2 stack=:
  RES:
  func#0 @0
  0: R1=ctx(off=0,imm=0) R10=fp0
  0: (b7) r0 = 1                        ; R0_w=1
  1: (18) r6 = 0xffff9eb644619000       ; R6_w=map_ptr(off=0,ks=4,vs=48,imm=0)
  3: (bf) r1 = r6                       ; R1_w=map_ptr(off=0,ks=4,vs=48,imm=0) R6_w=map_ptr(off=0,ks=4,vs=48,imm=0)
  4: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
  5: (07) r2 += -8                      ; R2_w=fp-8
  6: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000
  7: (85) call bpf_map_lookup_elem#1    ; R0_w=map_value_or_null(id=1,off=0,ks=4,vs=48,imm=0)
  8: (55) if r0 != 0x0 goto pc+1        ; R0_w=0
  9: (95) exit
  
  from 8 to 10: R0=map_value(off=0,ks=4,vs=48,imm=0) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R10=fp0 fp-8=0000mmmm
  10: R0=map_value(off=0,ks=4,vs=48,imm=0) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R10=fp0 fp-8=0000mmmm
  10: (bf) r9 = r0                      ; R0=map_value(off=0,ks=4,vs=48,imm=0) R9_w=map_value(off=0,ks=4,vs=48,imm=0)
  11: (bf) r1 = r6                      ; R1_w=map_ptr(off=0,ks=4,vs=48,imm=0) R6=map_ptr(off=0,ks=4,vs=48,imm=0)
  12: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
  13: (07) r2 += -8                     ; R2_w=fp-8
  14: (85) call bpf_map_lookup_elem#1   ; R0_w=map_value_or_null(id=2,off=0,ks=4,vs=48,imm=0)
  15: (55) if r0 != 0x0 goto pc+1       ; R0_w=0
  16: (95) exit
  
  from 15 to 17: R0_w=map_value(off=0,ks=4,vs=48,imm=0) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R9_w=map_value(off=0,ks=4,vs=48,imm=0) R10=fp0 fp-8=0000mmmm
  17: R0_w=map_value(off=0,ks=4,vs=48,imm=0) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R9_w=map_value(off=0,ks=4,vs=48,imm=0) R10=fp0 fp-8=0000mmmm
  17: (bf) r8 = r0                      ; R0_w=map_value(off=0,ks=4,vs=48,imm=0) R8_w=map_value(off=0,ks=4,vs=48,imm=0)
  18: (1f) r9 -= r8                     ; R8_w=map_value(off=0,ks=4,vs=48,imm=0) R9_w=scalar()
  19: (bf) r2 = r9                      ; R2=scalar(id=3) R9=scalar(id=3)
  20: (a5) if r2 < 0x8 goto pc+1        ; R2=scalar(id=3,umin=8)
  21: (95) exit
  
  from 20 to 22: R0=map_value(off=0,ks=4,vs=48,imm=0) R2=scalar(id=3,umax=7,var_off=(0x0; 0x7)) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R8=map_value(off=0,ks=4,vs=48,imm=0) R9=scalar(id=3,umax=7,var_off=(0x0; 0x7)) R10=fp0 fp-8=0000mmmm
  22: R0=map_value(off=0,ks=4,vs=48,imm=0) R2=scalar(id=3,umax=7,var_off=(0x0; 0x7)) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R8=map_value(off=0,ks=4,vs=48,imm=0) R9=scalar(id=3,umax=7,var_off=(0x0; 0x7)) R10=fp0 fp-8=0000mmmm
  22: (07) r2 += 1                      ; R2_w=scalar(umin=1,umax=8,var_off=(0x0; 0xf))
  23: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0
  24: (07) r1 += -8                     ; R1_w=fp-8
  25: (b7) r3 = 0                       ; R3_w=0
  26: (85) call bpf_probe_read_kernel#113
  mark_precise: frame0: last_idx 26 first_idx 20 subseq_idx -1
  mark_precise: frame0: regs=r2 stack= before 25: (b7) r3 = 0
  mark_precise: frame0: regs=r2 stack= before 24: (07) r1 += -8
  mark_precise: frame0: regs=r2 stack= before 23: (bf) r1 = r10
  mark_precise: frame0: regs=r2 stack= before 22: (07) r2 += 1
  mark_precise: frame0: regs=r2 stack= before 20: (a5) if r2 < 0x8 goto pc+1
  mark_precise: frame0: parent state regs=r2,r9 stack=:  R0_rw=map_value(off=0,ks=4,vs=48,imm=0) R2_rw=Pscalar(id=3) R6=map_ptr(off=0,ks=4,vs=48,imm=0) R8_w=map_value(off=0,ks=4,vs=48,imm=0) R9_w=Pscalar(id=3) R10=fp0 fp-8_r=0000mmmm
  mark_precise: frame0: last_idx 19 first_idx 10 subseq_idx 20
  mark_precise: frame0: regs=r2,r9 stack= before 19: (bf) r2 = r9
  mark_precise: frame0: regs=r9 stack= before 18: (1f) r9 -= r8
  mark_precise: frame0: regs=r8,r9 stack= before 17: (bf) r8 = r0
  mark_precise: frame0: regs=r0,r9 stack= before 15: (55) if r0 != 0x0 goto pc+1
  mark_precise: frame0: regs=r0,r9 stack= before 14: (85) call bpf_map_lookup_elem#1
  mark_precise: frame0: regs=r9 stack= before 13: (07) r2 += -8
  mark_precise: frame0: regs=r9 stack= before 12: (bf) r2 = r10
  mark_precise: frame0: regs=r9 stack= before 11: (bf) r1 = r6
  mark_precise: frame0: regs=r9 stack= before 10: (bf) r9 = r0
  mark_precise: frame0: parent state regs= stack=:  R0_rw=map_value(off=0,ks=4,vs=48,imm=0) R6_rw=map_ptr(off=0,ks=4,vs=48,imm=0) R10=fp0 fp-8_rw=0000mmmm
  27: R0_w=scalar()
  27: (95) exit
  processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1

[...]

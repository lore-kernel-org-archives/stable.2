Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C83E49EA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925635; cv=none; b=G/0vkvyTw2sa1hSILTZCP4NHkb/VU5/feVihSzA835q3WxIzg4qsAMGy/A9hmsDdod2EhsrWWiX0wuhJHcSMQ1dq154t4gXq6HQeqDiE3VvGYPL6+iqAEjYiXT8RYgnzHEvZsjiE4/aDSc4sU+9QGEAFGKGFgsu5ddj3rt1O/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925635; c=relaxed/simple;
	bh=T0Kcncmj3ckpj7woq3hkhXxYUnO7i7BRw2I7Zi91LjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l414RcpQHHxLJy5IHgFbgYFj9lWpQTlawdJbLmGEPbpUgzIPLd//NFmggzskPutzbbVkbVfQZg3My+LcEsIGNiKVOoSuVfY2XiFwqSnAy5xNhYOT4PVRzB1s7xvdcT/ZiPG+pfmAncIO1/cuAp4+Ck4t7HTVr6/TBc6fMhrsp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeIe8zLr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeIe8zLr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4956869750eso5648945e9.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785925632; x=1786530432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eEPOJPfCzbYAu6P+uFPjLGlw/pbOQO2EYuGFNA/Zhyo=;
        b=YeIe8zLrWkRSnlVZ0a0dtWrwNFNpKMOzWFz7H2WgX1mTPJKVufPrZB/0Z5rYTxEvgK
         Qp5/SJsbXH6UtziUCjYLtQiIY2SBcY5kyLenPx8hTNiEJ2jvy01Z+fEb6ssbfx/2EL3y
         a1W9gEFTowONkHwV/z8zskdKYJllxLQfNYl6H6lkOqZxaBi6cMaczePiZoNeugIBYPf9
         h53eWkBBmM7BN71ab7HIGUJjR1xQ14sxtyfwRXOJPPJdtLsqhSinq6+I3ntqeSugoDgj
         HW/7ATJ3JCCZmQ0zJZZoSYbo4AV473GUCT60JrJ7S2m8WudwRjidgu7racBFsRW1g/Da
         OC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925632; x=1786530432;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEPOJPfCzbYAu6P+uFPjLGlw/pbOQO2EYuGFNA/Zhyo=;
        b=sPugBIT9wSlge6GAAWpItluOxwGK5tlYPE3vjiqgHNTLmiA/tn6PKR80zw82dV1vKr
         yrHTih0nKzEL24MZp6Ock1s32faPkUuOX7O1bUu0U2QOgAnr1udYMHLXdMZsnDwW8uPb
         YOIKkZxKzGtBx6Bgh+xrnC6siFTLAjCamFN3rJIEby1xnH2BYhrfJzOGVmKI1wjPRBH0
         F0Ul84u48+1Y+SbsRG2m3K5jghnAiIz8Lnsz4EDdTUZGPBGTZgZOXo9CJ2vj4c0/Sqsg
         r/Na24+1gLIHTVWFG6JVs6B9Ny1MD3kSGf+u9UcgSxTp5twJnNlTLce43l/3mKpleYcT
         jCsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqibbuEaATDjiJ6NJDhg0obAjtZ6WhyYJ31EQJyo0h3K2bdSA2WL69wqG7hOhoFHWLPlsd11+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKgOiiDRzXkHzAN1Ahmht0a4q9e89g134zd9SdeTpEYhoH5Us
	3foAi9aG0n1jBbLnIt/5ZfQWR8hXe3UYf6ipYf4yuygfa9GDLxi9tZ9U
X-Gm-Gg: AR+sD10r8NCT/bSmSz3ahNVDxC4s0E2WJBCIIdoNi4Ny8KoILa/tktVDfo0aZtSZpyf
	BXs+YVPqALsxAaQI98MaOwhDAvksBM9N6d8aCHvg03+hTxP7LjufLIxeOpQVTQcFqKcT5YiyCy4
	M5j9JEyF59s2rCBDcGX/OG2gEcCvCkRDRDbvdzzFSPa3MRfNxfGWw9/O/3ODD1lpxdpHA1tdIo5
	oCsjW2UqL4H1JwnXC4DExEyXbLS2Xich3zwXJ5wGcjy5twvPcqKhcLhHLWNEikDalqvBy4+mpKX
	Tu4auUjUe2Qexews/FJSvaASJNAjzmXIZ4Uje+R/0wV/TZwOfPBM3IgTq3KH+IS6cw0cWcU2lOx
	1W8t2BkprjzMsRUIcEQI0sqoXSudlF9/3KVxifKdwTQ8g2AcgACkklCOzA+PyiL1vAACsKs5jKT
	8KCAC+W6b2sCBn+80fsG983dOwsnLHv3PAMkdH8Y6gbBhnxgc7NkKfKp4eGwwYWVEAgVVivYrTm
	LLXJgj3lz1DljQgccYjBcLhRg==
X-Received: by 2002:a7b:cd19:0:b0:495:4bf3:2150 with SMTP id 5b1f17b1804b1-4994e7af664mr51746725e9.8.1785925631522;
        Wed, 05 Aug 2026 03:27:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm91782465e9.15.2026.08.05.03.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:27:11 -0700 (PDT)
Date: Wed, 5 Aug 2026 11:27:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <20260805112707.0204f00e@pumpkin>
In-Reply-To: <anJm-EDndC8H6xMi@pedro-suse.lan>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-14-mark.rutland@arm.com>
	<anJm-EDndC8H6xMi@pedro-suse.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 23:45:56 +0100
Pedro Falcato <pfalcato@suse.de> wrote:

> On Tue, Aug 04, 2026 at 06:04:56PM +0100, Mark Rutland wrote:
> > Currently arm64's this_cpu_*() ops transiently disable preemption in
> > order to guarantee that the address generation and memory access(es)
> > occur on the same CPU.
> > 
> > Transiently disabling preemption can be  expensive. When re-enabling
> > preemption it is necessary to make a conditional function call to
> > preempt_schedule[_notrace]() in order to handle the rare case that the
> > task needs to be rescheduled. The potential function call has a number
> > of negative effects on code generation (e.g. due to the need to create a
> > stack frame and spill registers), and the conditionality can result in
> > poor code generation and/or poor branch prediction.
> > 
> > This patch adds infrastructure for a scheme where this_cpu_*() ops do
> > not need to transiently disable preemption, avoiding the negative
> > impacts described above. Individual operations will be converted in
> > subsequent patches.
> > 
> > Each operation registers a critical section during which the exception
> > return code will adjust the offset and addresses if preemption occurs
> > mid-sequence. The critical section is registered/unregistered with a
> > small prologue and epilogue which encodes three distinct GPRRs (<pcp>,
> > <off>, <addr>) into a new thread_info::pcp_gprs field:
> > 
> >          // Prologue. Enable fixups for <off> and <addr>.
> >          mrs	<tsk>, sp_el0
> >          mov	<tmp>, #__VAL_PCPU_GPRS(<pcp>, <off>, <addr>)
> >          strh	<tmp>, [<tsk>, #TSK_TI_PCPU_GPRS]
> > 
> >          // Generate cpu-specific address
> >          mrs	<off>, TPIDR_ELx
> >          add	<addr>, <pcp>, <off>
> > 
> >          // Perform access sequence
> >          ldr	<val>, [<addr>]
> > 
> >          // Epilogue. Disable fixups
> >          strh	wzr, [<tsk>, #TSK_TI_PCPU_GPRS]
> > 
> > If an exception is taken from within the critical section, the exception
> > return code will adjust <off> to be the current CPU's offset, and will
> > adjust <addr> to be (<pcp> + <off>). Distinct registers are used for
> > <pcp>, <off>, and <addr>, so that the fixup can be applied safely at any
> > point during the critical section.
> > 
> > To ensure that this_cpu_*() operations within exception handlers work
> > correctly and do not corrupt state, thread_info::pcpu_gprs is saved
> > into a new pt_regs::pcpu_gprs field upon exception entry, and restored
> > upon exception return.
> > 
> > Looking at a simple this_cpu_operation:
> > 
> > | void outline_this_cpu_add_u64(u64 __percpu *p, u64 v)
> > | {
> > | 	this_cpu_add(*p, v);
> > | }
...
> I think I had an Interesting Idea(tm) while reading the per-cpu discussion
> in linux-mm. In case the 3 instruction preamble is too expensive:
> 
> 1) Pass -ffixed-x18 (this natively conflicts with SHADOW_CALL_STACK.
> SHADOW_CALL_STACK is already not-optimal codegen wise, so maybe not a big deal).
> 2) arm64 kernel bits will use x18 as a cheap task flags register
> 3) #define TASK_KRSEQ     (1 << 0)
> 4) Switching into the krseq mode is just a matter of toggling the bit in x18, so
> 	orr x18, x18, #TASK_KRSEQ
> a single instruction.
> 5) Switching off is just a matter of clearing the bit in x18, so:
> 	and x18, x18, #~TASK_KRSEQ
> 6) On the preempt side we keep the krseq tables in memory, and do a sort of lookup
> (binary search sounds easiest?) on them. But _only_ if x18 TASK_KRSEQ is set.
> This penalises unlucky preempts but keeps fast paths maximally fast.
> 7) entry points of course get to clear it after saving it
> 
> The end result would look something like:
> | <outline_this_cpu_add_u64>:
> |	 orr x18, x18, #TASK_KRSEQ
> |        mrs     x4, tpidr_el1
> |        add     x3, x0, x4
> | 1:     ldxr    x6, [x3]
> |        add     x6, x6, x1
> |        stxr    w5, x6, [x3]
> |        cbnz    w5, 1b
> | 2:
> |	 and x18, x18, #~TASK_KRSEQ
> |        ret
> | .pushsection .data.krseq
> | .word 1b
> | .word 2b
> | .word whateverelse
> | .popsection
> 
> This of course precludes the use of x18 for the compiler, so it would
> require careful benchmarking in case it negatively affects codegen too much.
> But it avoids any sort of extraneous stores in the fast path.

The extra stores are independent of the main instruction flow.
On a multi-issue (and especially out-of-order) cpu they are pretty much
likely to be noise.
The biggest cost is likely to be in the I-cache and instruction decoders.
Put a memory read in the 'main' path and the few clocks needed for the
D-cache read are likely to dominate - so the writes to the pcp_gprs
are actually likely to be free.

OTOH stealing a gpr for some flags will cost everwhere.

	David
 
> 
> Other architectures could do similar as long as they have interesting ways of
> signaling this using solely the register set.
> 
> Anyway, just throwing it out there in case this can actually make a
> difference & rings some bells on people smarter than me :)
> 


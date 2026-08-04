Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682527B340
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883571; cv=none; b=eK1cN69pSqep/EIucv6QJAiMhlbJ5NtwD6YdxP9FvzekPv7prrhyJGSwwXtgkP7hYZ26ruVWElP/B1kagwn+hcTeFgJK4M0lO9g4ewHp3dvdWsw8UhMoZSeQ2C2cfVEdd1gFwqzFkO4AUQZ5+mGM/x+bkvkSrAPh/RYUsfrXzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883571; c=relaxed/simple;
	bh=34+0I7kt26muOiDfJi+sNMdkXPAHjEIa3+5SPre9+A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZyzG1HBYhmtAW8q8J0MPBE/bEajMPDkJs/UCNnsWtviKwmfiX+FLSyu65N8bbEUVF477xNa9QaYunPxuKhvv/xizgaZt1+M+hUOvjaG3bxbk+TPaEXpbFfRME6pNZztai0/Rgc7/wPybXd/og19ma+nYEDz3YRCH8uv5O45Ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x0AosRIK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gfOipscD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SzJl2brn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7UMEiAX6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x0AosRIK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gfOipscD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SzJl2brn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7UMEiAX6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E92987DA4F;
	Tue,  4 Aug 2026 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785883564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nckDj9uSVJQNTLpL7gMUG7fWxQkNwuDaAqk1qZvF4j4=;
	b=x0AosRIKSR9RQJ/0WQ8ntveBL1Mp+/B/0UoRn56gF2/BYDyddU3PG0aYZ5GbpHz8FfIsmw
	u5ZpsOIQOJCqi6b9ATauwZP6ZB4QuM+Noye5R6lNDN7OdW+cAZylwvFPyu8Wlzf831tJTk
	VfQx6h36EOQOpoxOe/cGwoJwsUMbLfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785883564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nckDj9uSVJQNTLpL7gMUG7fWxQkNwuDaAqk1qZvF4j4=;
	b=gfOipscDfoJOE7qgp6Ul1T7E44NulKU8Mijn1B+M0YL4iU76CzP9ikWD6Q7Ka3oyM9stF8
	aIQP/rRXZu36F2CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SzJl2brn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7UMEiAX6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785883560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nckDj9uSVJQNTLpL7gMUG7fWxQkNwuDaAqk1qZvF4j4=;
	b=SzJl2brnfYHL8nVC9+JgU5y+vut0ewd3a5y5YmW5xx35FyavHNG/zGpb6ZPo9dFbgxlrUA
	HzcE17ekovl1NeIpte6T5LvjbYP8EuuQ45kuivVQb2I+7c4xJ2m+aq/vKFcWudatw2gEoz
	2COdbdzrnbkUwHnmkSj0YrqiVp9YSeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785883560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nckDj9uSVJQNTLpL7gMUG7fWxQkNwuDaAqk1qZvF4j4=;
	b=7UMEiAX6oxmjch/6I2znAsZu/lx4lIOyU4WooZVlhDul1cz9dV/R+bo3bo6chwgtwR7vJI
	dCr4jJSEu9jbMIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF59779BB;
	Tue,  4 Aug 2026 22:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GhelJaZrcmrvJgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 04 Aug 2026 22:45:58 +0000
Date: Tue, 4 Aug 2026 23:45:56 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com, 
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org, 
	david.laight.linux@gmail.com, james.morse@arm.com, ljs@kernel.org, maz@kernel.org, 
	peterz@infradead.org, ruanjinjie@huawei.com, ryan.roberts@arm.com, 
	stable@vger.kernel.org, vladimir.murzin@arm.com, will@kernel.org, 
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <anJm-EDndC8H6xMi@pedro-suse.lan>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804170503.3513916-14-mark.rutland@arm.com>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,arm.com,kernel.org,gentwo.org,gmail.com,infradead.org,huawei.com,vger.kernel.org,os.amperecomputing.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E92987DA4F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue, Aug 04, 2026 at 06:04:56PM +0100, Mark Rutland wrote:
> Currently arm64's this_cpu_*() ops transiently disable preemption in
> order to guarantee that the address generation and memory access(es)
> occur on the same CPU.
> 
> Transiently disabling preemption can be  expensive. When re-enabling
> preemption it is necessary to make a conditional function call to
> preempt_schedule[_notrace]() in order to handle the rare case that the
> task needs to be rescheduled. The potential function call has a number
> of negative effects on code generation (e.g. due to the need to create a
> stack frame and spill registers), and the conditionality can result in
> poor code generation and/or poor branch prediction.
> 
> This patch adds infrastructure for a scheme where this_cpu_*() ops do
> not need to transiently disable preemption, avoiding the negative
> impacts described above. Individual operations will be converted in
> subsequent patches.
> 
> Each operation registers a critical section during which the exception
> return code will adjust the offset and addresses if preemption occurs
> mid-sequence. The critical section is registered/unregistered with a
> small prologue and epilogue which encodes three distinct GPRRs (<pcp>,
> <off>, <addr>) into a new thread_info::pcp_gprs field:
> 
>          // Prologue. Enable fixups for <off> and <addr>.
>          mrs	<tsk>, sp_el0
>          mov	<tmp>, #__VAL_PCPU_GPRS(<pcp>, <off>, <addr>)
>          strh	<tmp>, [<tsk>, #TSK_TI_PCPU_GPRS]
> 
>          // Generate cpu-specific address
>          mrs	<off>, TPIDR_ELx
>          add	<addr>, <pcp>, <off>
> 
>          // Perform access sequence
>          ldr	<val>, [<addr>]
> 
>          // Epilogue. Disable fixups
>          strh	wzr, [<tsk>, #TSK_TI_PCPU_GPRS]
> 
> If an exception is taken from within the critical section, the exception
> return code will adjust <off> to be the current CPU's offset, and will
> adjust <addr> to be (<pcp> + <off>). Distinct registers are used for
> <pcp>, <off>, and <addr>, so that the fixup can be applied safely at any
> point during the critical section.
> 
> To ensure that this_cpu_*() operations within exception handlers work
> correctly and do not corrupt state, thread_info::pcpu_gprs is saved
> into a new pt_regs::pcpu_gprs field upon exception entry, and restored
> upon exception return.
> 
> Looking at a simple this_cpu_operation:
> 
> | void outline_this_cpu_add_u64(u64 __percpu *p, u64 v)
> | {
> | 	this_cpu_add(*p, v);
> | }
> 
> Atop v7.2-rc4, with GCC 15.2.0 and defconfig, this is compiled as:
> 
> | <outline_this_cpu_add_u64>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x2, sp_el0
> |        mov     x29, sp
> |        ldr     w3, [x2, #8]
> |        add     w3, w3, #0x1
> |        str     w3, [x2, #8]
> |        mrs     x3, tpidr_el1
> |        add     x0, x0, x3
> | 1:     ldxr    x5, [x0]
> |        add     x5, x5, x1
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x2, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x2, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x2, #8]
> |        cbnz    x0, 3f
> | 2:     bl      preempt_schedule_notrace
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> With the scheme added in this patch, this can be compiled as:
> 
> | <outline_this_cpu_add_u64>:
> |        mrs     x2, sp_el0
> |        mov     x4, #0xc80     // __VAL_PCPU_GPRS(x0, x4, x3)
> |        strh    w4, [x2, #20]
> |        mrs     x4, tpidr_el1
> |        add     x3, x0, x4
> | 1:     ldxr    x6, [x3]
> |        add     x6, x6, x1
> |        stxr    w5, x6, [x3]
> |        cbnz    w5, 1b
> |        strh    wzr, [x2, #20]
> |        ret

I think I had an Interesting Idea(tm) while reading the per-cpu discussion
in linux-mm. In case the 3 instruction preamble is too expensive:

1) Pass -ffixed-x18 (this natively conflicts with SHADOW_CALL_STACK.
SHADOW_CALL_STACK is already not-optimal codegen wise, so maybe not a big deal).
2) arm64 kernel bits will use x18 as a cheap task flags register
3) #define TASK_KRSEQ     (1 << 0)
4) Switching into the krseq mode is just a matter of toggling the bit in x18, so
	orr x18, x18, #TASK_KRSEQ
a single instruction.
5) Switching off is just a matter of clearing the bit in x18, so:
	and x18, x18, #~TASK_KRSEQ
6) On the preempt side we keep the krseq tables in memory, and do a sort of lookup
(binary search sounds easiest?) on them. But _only_ if x18 TASK_KRSEQ is set.
This penalises unlucky preempts but keeps fast paths maximally fast.
7) entry points of course get to clear it after saving it

The end result would look something like:
| <outline_this_cpu_add_u64>:
|	 orr x18, x18, #TASK_KRSEQ
|        mrs     x4, tpidr_el1
|        add     x3, x0, x4
| 1:     ldxr    x6, [x3]
|        add     x6, x6, x1
|        stxr    w5, x6, [x3]
|        cbnz    w5, 1b
| 2:
|	 and x18, x18, #~TASK_KRSEQ
|        ret
| .pushsection .data.krseq
| .word 1b
| .word 2b
| .word whateverelse
| .popsection

This of course precludes the use of x18 for the compiler, so it would
require careful benchmarking in case it negatively affects codegen too much.
But it avoids any sort of extraneous stores in the fast path.

Other architectures could do similar as long as they have interesting ways of
signaling this using solely the register set.

Anyway, just throwing it out there in case this can actually make a
difference & rings some bells on people smarter than me :)

-- 
Pedro

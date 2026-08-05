Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1046D097
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934274; cv=none; b=hjrctWInnNU1R1uQaJK5W6jA8xM3FySIcqYxPkNA2cI3yLyoGTCRbkwQBRuT4sOE4tv43x/xhzd7ziEoZdIuAco8EAJjSgDO+o+fl6VntIeIugOuXQaO2DM/+3+dgPhEkM4UcjwtnWeTQEpNs/ztS3P793icxVKjIV3NXef/80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934274; c=relaxed/simple;
	bh=YgNvs+rAhK2zESKZ5RNZG/4/NjOJUPpAffBACXwrlh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2EEVc++Xln5ZVZSvb1Uc+Ovmrq/O0pOMD7ISZQfL1n3BO/K0fal942OUCI6J4sBMnc2XEvFo7yGQflM585nfK06DmqGdDy0Ori89dhnfW7FGEMgoym+UgMv4bfaHz39tC6Yxk/e0od/n89U9sdJuB1s9CttAqeAud1+SfmVNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3dn9G6z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v+qY4Xu8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D4yU49/E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zf18ZXQn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3dn9G6z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v+qY4Xu8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D4yU49/E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zf18ZXQn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD3057F640;
	Wed,  5 Aug 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785934265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFyU2l+HdxTtrqVozC5UDLC1/X+bymnsd3k4Qd8ETH8=;
	b=y3dn9G6z0eTn35pc+UorP5AANyzGEbEThQAmPe/Sk88LWQzXpxlT9VlCBhgEi5VfOQpR0y
	Mb3DGy8DGtnTVa0+mcmdBEjOqOr/A8kLqlktjLOzZx+wtxGZz6NsvPqkfTYv6J7pVmj6dy
	MGq0LJJ2joF20nlP/Zr4AHCuDk0aNRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785934265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFyU2l+HdxTtrqVozC5UDLC1/X+bymnsd3k4Qd8ETH8=;
	b=v+qY4Xu8OSrEjOTtL/WP+tuffc4Oy60zA3SPkFqt1xC1F/ofB/eWwm3N6tGW0bYdczZb5k
	3h+y/lxsvVk4DcAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="D4yU49/E";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zf18ZXQn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785934261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFyU2l+HdxTtrqVozC5UDLC1/X+bymnsd3k4Qd8ETH8=;
	b=D4yU49/Elkl7cCLY7wmTPB1Y46LnYvwmc1CCWjC8gZlhi2UUKPs0zOZJjCCwRDabI1XxZ9
	1TgLFlIlJx/UeQ46IFBom7m0j+SqBmG3T6NtATF7jY8kvPuhR/Q5o86rFh7QJahYlvxbqt
	OxlIR3CYdA3958aRgPA+WD/DKyBcVEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785934261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFyU2l+HdxTtrqVozC5UDLC1/X+bymnsd3k4Qd8ETH8=;
	b=zf18ZXQn7GhLsL9VKYqjHeG0+EPWMQt3dMwmpc+UkfP+o1gm7q71KpA8hDqmMuQR+LFpoK
	1jJ/3AiHNYK169BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93475779C2;
	Wed,  5 Aug 2026 12:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5m9rILQxc2ojCAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 05 Aug 2026 12:51:00 +0000
Date: Wed, 5 Aug 2026 13:50:58 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com, ardb@kernel.org, 
	catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org, james.morse@arm.com, 
	ljs@kernel.org, maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com, 
	ryan.roberts@arm.com, stable@vger.kernel.org, vladimir.murzin@arm.com, will@kernel.org, 
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <anMvQXi0We40Vok0@pedro-suse.lan>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
 <anJm-EDndC8H6xMi@pedro-suse.lan>
 <20260805112707.0204f00e@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805112707.0204f00e@pumpkin>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BD3057F640
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 05, 2026 at 11:27:07AM +0100, David Laight wrote:
> On Tue, 4 Aug 2026 23:45:56 +0100
> Pedro Falcato <pfalcato@suse.de> wrote:
> 
> > On Tue, Aug 04, 2026 at 06:04:56PM +0100, Mark Rutland wrote:
> > > Currently arm64's this_cpu_*() ops transiently disable preemption in
> > > order to guarantee that the address generation and memory access(es)
> > > occur on the same CPU.
> > > 
> > > Transiently disabling preemption can be  expensive. When re-enabling
> > > preemption it is necessary to make a conditional function call to
> > > preempt_schedule[_notrace]() in order to handle the rare case that the
> > > task needs to be rescheduled. The potential function call has a number
> > > of negative effects on code generation (e.g. due to the need to create a
> > > stack frame and spill registers), and the conditionality can result in
> > > poor code generation and/or poor branch prediction.
> > > 
> > > This patch adds infrastructure for a scheme where this_cpu_*() ops do
> > > not need to transiently disable preemption, avoiding the negative
> > > impacts described above. Individual operations will be converted in
> > > subsequent patches.
> > > 
> > > Each operation registers a critical section during which the exception
> > > return code will adjust the offset and addresses if preemption occurs
> > > mid-sequence. The critical section is registered/unregistered with a
> > > small prologue and epilogue which encodes three distinct GPRRs (<pcp>,
> > > <off>, <addr>) into a new thread_info::pcp_gprs field:
> > > 
> > >          // Prologue. Enable fixups for <off> and <addr>.
> > >          mrs	<tsk>, sp_el0
> > >          mov	<tmp>, #__VAL_PCPU_GPRS(<pcp>, <off>, <addr>)
> > >          strh	<tmp>, [<tsk>, #TSK_TI_PCPU_GPRS]
> > > 
> > >          // Generate cpu-specific address
> > >          mrs	<off>, TPIDR_ELx
> > >          add	<addr>, <pcp>, <off>
> > > 
> > >          // Perform access sequence
> > >          ldr	<val>, [<addr>]
> > > 
> > >          // Epilogue. Disable fixups
> > >          strh	wzr, [<tsk>, #TSK_TI_PCPU_GPRS]
> > > 
> > > If an exception is taken from within the critical section, the exception
> > > return code will adjust <off> to be the current CPU's offset, and will
> > > adjust <addr> to be (<pcp> + <off>). Distinct registers are used for
> > > <pcp>, <off>, and <addr>, so that the fixup can be applied safely at any
> > > point during the critical section.
> > > 
> > > To ensure that this_cpu_*() operations within exception handlers work
> > > correctly and do not corrupt state, thread_info::pcpu_gprs is saved
> > > into a new pt_regs::pcpu_gprs field upon exception entry, and restored
> > > upon exception return.
> > > 
> > > Looking at a simple this_cpu_operation:
> > > 
> > > | void outline_this_cpu_add_u64(u64 __percpu *p, u64 v)
> > > | {
> > > | 	this_cpu_add(*p, v);
> > > | }
> ...
> > I think I had an Interesting Idea(tm) while reading the per-cpu discussion
> > in linux-mm. In case the 3 instruction preamble is too expensive:
> > 
> > 1) Pass -ffixed-x18 (this natively conflicts with SHADOW_CALL_STACK.
> > SHADOW_CALL_STACK is already not-optimal codegen wise, so maybe not a big deal).
> > 2) arm64 kernel bits will use x18 as a cheap task flags register
> > 3) #define TASK_KRSEQ     (1 << 0)
> > 4) Switching into the krseq mode is just a matter of toggling the bit in x18, so
> > 	orr x18, x18, #TASK_KRSEQ
> > a single instruction.
> > 5) Switching off is just a matter of clearing the bit in x18, so:
> > 	and x18, x18, #~TASK_KRSEQ
> > 6) On the preempt side we keep the krseq tables in memory, and do a sort of lookup
> > (binary search sounds easiest?) on them. But _only_ if x18 TASK_KRSEQ is set.
> > This penalises unlucky preempts but keeps fast paths maximally fast.
> > 7) entry points of course get to clear it after saving it
> > 
> > The end result would look something like:
> > | <outline_this_cpu_add_u64>:
> > |	 orr x18, x18, #TASK_KRSEQ
> > |        mrs     x4, tpidr_el1
> > |        add     x3, x0, x4
> > | 1:     ldxr    x6, [x3]
> > |        add     x6, x6, x1
> > |        stxr    w5, x6, [x3]
> > |        cbnz    w5, 1b
> > | 2:
> > |	 and x18, x18, #~TASK_KRSEQ
> > |        ret
> > | .pushsection .data.krseq
> > | .word 1b
> > | .word 2b
> > | .word whateverelse
> > | .popsection

... Something I overlooked is that, since the solution shifted from
"literally kernel rseq" to "funky kernel rseq but pcpu-specific" you don't
probably don't need the table at all, as long as you dedicate a good few of
those x18 bits to stash the pcp_gprs value.

> > 
> > This of course precludes the use of x18 for the compiler, so it would
> > require careful benchmarking in case it negatively affects codegen too much.
> > But it avoids any sort of extraneous stores in the fast path.
> 
> The extra stores are independent of the main instruction flow.
> On a multi-issue (and especially out-of-order) cpu they are pretty much
> likely to be noise.

Oh, I agree, it is probably in the noise, modern uarchs are awesome :)

> The biggest cost is likely to be in the I-cache and instruction decoders.
> Put a memory read in the 'main' path and the few clocks needed for the
> D-cache read are likely to dominate - so the writes to the pcp_gprs
> are actually likely to be free.

While I do like theorycrafting, I think we need numbers to know (numbers
which I do not have, and seemingly no one seems to have for now).

> 
> OTOH stealing a gpr for some flags will cost everwhere.

Perhaps, but arm64 isn't exactly short on registers :) In any case,
I generally agree with your take that it quite possibly doesn't matter,
I was just throwing this out there in case it can help.

-- 
Pedro

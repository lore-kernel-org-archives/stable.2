Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C939F16B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405757; cv=none; b=CD1a0YUwyDGHXpJZgoTIX27mqM1J8gAS1PbuwLwvxojGUQ4vE3o6g+gq2ndxI29DXscTYmnfvwTPW+mNelM9gXYq5OwP0f4AUq99w6oPXZvp9sYTli6qQpXlALgDMa5mILySLUvc/Z0mHo4x1Eay0nbSs/xMnpQ/zJWiQ8hFfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405757; c=relaxed/simple;
	bh=NFkjmCLHwyG+B0Pl7rsoQW6FdVaAAGrryORwHIsxb0k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZP6T+bKLMqEG786et7hUfg+s8t5dzsLPuckk3NkHTnq/nq/QFTrPzcfjKmKbV5/KxZPY+jzFyLUKxcIl608QpLOrdWX5cnQBMQZc5yeaFs8qsG6E1J7ZkEMnR2e2jQ4znGFWhddXn4xXNxHx3TNkIZP1O+iftsSlZt6TsAaw4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilGCgENL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=05Q6Xt9w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tujvrapK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOqeV6yB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilGCgENL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="05Q6Xt9w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tujvrapK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOqeV6yB"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FF827D6D0;
	Thu, 30 Jul 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785405749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCKYcexeEqW/+AQcCaEVGAueHEUvyo6QxPKVayeZ8KI=;
	b=ilGCgENLvX/guoqW+qE2WyvurHISjY2W/TaSK2EVyLVw8N5gpi2COq4VoFBiZ8YrmGHK5X
	637Fmx3cBsZzTHoHgeumanxfNiDsdIaIZgkjH3852r20D3Q/3nY2aZGAl85dR69H+tvP46
	s8JdsMpVYphReRlCX0yCnCqPMf3TLUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785405749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCKYcexeEqW/+AQcCaEVGAueHEUvyo6QxPKVayeZ8KI=;
	b=05Q6Xt9wPWSvq1aBM8C8dJS1WTCu6PlM8VfBiAgdy2jKSeufccJtkIDBY2XPMGmgGo0Bnk
	yA7K6SmZ2kp01JBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785405744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCKYcexeEqW/+AQcCaEVGAueHEUvyo6QxPKVayeZ8KI=;
	b=tujvrapKWs5ip4A1ujcbNptVVI9pnUu0RTQge8/DEOjnSicAOmCrRpIZyNZFBXoZL1eqfw
	yo+UhFgOyIH+6LlBgDKz5swZlxhEkKfC5GMmzBuKxpdI3ZWslKejzsLMURQpDlUc8sBtGA
	fYsHneJfB9nVIqoibgwVR5iPaypYsOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785405744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCKYcexeEqW/+AQcCaEVGAueHEUvyo6QxPKVayeZ8KI=;
	b=tOqeV6yBhIcaAqNjkCPA+hNAPzQzBu7n4/HMi6wO8PsafSZFF32Q59FVK3mps1aJhNGaVe
	QSdZxzuaMlcDs2Bg==
Date: Thu, 30 Jul 2026 12:02:24 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
    jolsa@kernel.org, naveen@kernel.org, davem@davemloft.net, 
    mhiramat@kernel.org, stable@vger.kernel.org, 
    linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark trampoline/kprobe
 ftrace_ops permanent
In-Reply-To: <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2607301159420.14091@pobox.suse.cz>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com> <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-2146828000-882904578-1785405744=:14091"
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	CTYPE_MIXED_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[rostedt.goodmis.org:server fail]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2146828000-882904578-1785405744=:14091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 29 Jul 2026, Andrey Grodzovsky wrote:

> ,
> 
> On Wed, Jul 29, 2026 at 10:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 28 Jul 2026 20:59:56 -0400
> > Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > > This fixes a long-standing issue: kernel.ftrace_enabled=0 silently
> > > disables BPF trampolines (fentry/fexit) and ftrace-based
> > > kprobes/kretprobes. The write succeeds, the hook stops firing with no
> > > error, and re-enabling silently restores it. Livepatch already solved
> > > this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> > > ftrace while a permanent ops is registered and refuses to register
> > > one while ftrace is disabled[1].
> >
> > The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
> > back when ftrace was first added to the kernel. It's addition was namely
> > there because live runtime modification of kernel code was new and we were
> > worried about how stable it could be.
> >
> > Honestly, I would love to get rid of it as today ftrace has proven to be
> > rather stable. But as it is a user space ABI, I'm not sure what will break
> > if we do. I wonder if we just make it a nop, and print a message to dmesg
> > saying:
> >
> >   "ftrace_enabled no longer does anything. Please report if you need it to."
> >
> > ?
> 
> Thanks Steven, if you and/or other community members would approve such
> approach I would happily do this instead for a few reasons -
> 
> 1) Seems like the more correct course of action if idneed this switch
> effectively became obsolete in usage instead of piling extra logic to work
> around it.
> 
> 2) As I mentioned in the end of the cover letter, I believe for some cases
> such as fsessions/ksessions and multi opts retprobes, this patchset is
> not effective and the issue will persist, requiring a more complicated solution
> for them anyway if we want watertight resilience.
> 
> If you approve this - I can try what you suggested, this would include
> making the
> knob a NOP with a message, dropping the FTRACE_OPS_FL_PERMANENT
> flag and reverting/cleaning what's possible from the original livepatch patchset
> that dealt with this issue [1]
> 
> One question is what the correct set of tests to run in such a case
> would be to verify
> we didn't break anything. For this patchset I ran BPF and livepatch
> selftest suites, but
> I wonder what else would need to be run.
> 
> CC Miroslav for Livepatch.

Thanks. It would be nice to drop ftrace_enabled altogether because your 
patch set just proves that it is completely uses nowadays. Ack to it. At 
the same time I have doubts based on the experience with our SLES and how 
difficult it is to drop a single feature because there is always someone 
somewhere using even the obscure ones (and sometimes in a very weird way). 
Fingers crossed.

Miroslav
---2146828000-882904578-1785405744=:14091--

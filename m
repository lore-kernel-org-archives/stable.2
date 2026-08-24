Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D641A517;
	Mon, 24 Aug 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575285; cv=none; b=kqnV2MO9pXlZi08+6Bl1tOr2/GGPbHe4yI9GEuvRGLnY0x+n+0/ZUS/vL5hu8b22VC6h7tGSJ9bePXCPf0VVxbcV30Li9tlpWDDWp44Pve6zO7Fb+H+B2H/quXO3EmZ+kzuif8FkDHww+X/9uixVj9zikl043EUlYzkpmdb9EHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575285; c=relaxed/simple;
	bh=h2xysoDU2wsOWO/UwsGV+ZP0KAU8el7Jn0hXBLKGtBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QTAhZQfe/FEjvnBbeCG3VUP1oZtS50qn4jI2JOENh4/OH/fmxY9cUZMBUY3oiqijd+k15DFP/LTgq23h2PedwfW8KegF2sLpv/kcspG3zwaULwIJYnm9yQR2ZvKSGKVFaYkyeual4WzgfeuHNnXp04iYwlLPM6Vdm/3JELURpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FmwU5TO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4vU64sVi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDbDXTDQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MLS8qWvl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FmwU5TO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4vU64sVi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDbDXTDQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MLS8qWvl"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BB0E868C1;
	Mon, 24 Aug 2026 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787575275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8BmM3PDphVGAMVOAbsIY+lFVPl8D0EsHUi4vr3vsyc=;
	b=FmwU5TO7sw+f7xTaYHfEy9blehcgnJ1uVPHbvo/jtcrldF3LeeWo8OJOZkKHrbNA88EZZp
	ulNvqrAonkfkxzSzaUP84BkpcdIk+m/F3MIicREYSN5fDD1wIGbUK5iHVtduiWhRyWW+pJ
	mInj/9UoXkW83OpjdYnljUG/72bBiPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787575275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8BmM3PDphVGAMVOAbsIY+lFVPl8D0EsHUi4vr3vsyc=;
	b=4vU64sVi+KZ00QdUk3SlXX/YnjrpQyTK1gR9audE5Hj1/8/zOR6PSjmibBJ162HRQfgvkx
	2qBugm68pge3ivBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787575271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8BmM3PDphVGAMVOAbsIY+lFVPl8D0EsHUi4vr3vsyc=;
	b=NDbDXTDQAzi00K6RjxmKquwHIZwdOhNMbf+0+uvaDM8d4LNo16ng19y6cFpQu+1P1x1Q93
	wyjzwkp7heqn0EouLj2/zuF6a9l/sro26AF3U5sktOmAYmnlHrJmtrXxBODM87FbNW4cVl
	lP9owZNytXjhKZUv15qjeZw28yqg+1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787575271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8BmM3PDphVGAMVOAbsIY+lFVPl8D0EsHUi4vr3vsyc=;
	b=MLS8qWvlQ1EH1qkq+O7Y/6ud4TGkQ4UNJuTCsg9y7A3ujOrQdoYJpmU2RT3n1+Ow0UvNEm
	eftWjdj4i7v9tGAg==
Date: Mon, 24 Aug 2026 14:41:11 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Song Liu <song@kernel.org>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
    jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
    joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
    stable@vger.kernel.org, linux-open-source@crowdstrike.com, 
    pmladek@suse.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
In-Reply-To: <CAPhsuW5bW-xogJESb=ydUMH-ZjczoTP9JbuwPJZgbGZBzv-1CA@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2608241437380.17149@pobox.suse.cz>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com> <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com> <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com> <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
 <20260806205144.743c45e6@gandalf.local.home> <CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com> <20260807084257.56a5984e@gandalf.local.home> <CAPhsuW5bW-xogJESb=ydUMH-ZjczoTP9JbuwPJZgbGZBzv-1CA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

> > We do not deprecate features. tracefs code is user API. We do not break
> > user space. The ftrace_enabled is something that is being removed because
> > it is broken to begin with. In fact, if we find out that anything depends
> > on ftrace_enabled, we need to revert the change that disabled it.
> >
> > The removal of ftrace_enabled is the exception and not the rule.
> 
> Agreed that ftrace APIs need to be very stable, as there are many out
> of tree users. OTOH, I think livepatch can afford breaking some
> compatibility.

We discussed that a bit in the context of this patch set [1]. I think it 
is valuable to have the kselftests backward compatibility but there is of 
course some limit to it. We can talk about it at Plumbers during the
backward compatibility session as well [2].

Miroslav

[1] https://lore.kernel.org/all/20260413-lp-tests-old-fixes-v2-0-367c7cb5006f@suse.com/
[2] https://lpc.events/event/20/contributions/2530/

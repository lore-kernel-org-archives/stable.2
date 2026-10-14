Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADF2D5408
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980642; cv=none; b=QuAdwIKwaoFYzlBqVnl+7aeUyA3WJZua4H5CIqrSlUDqtgTrv1WBSiB+LGqeoi/JiZHq6bp3XOXxtyZkjsY5JRsHjG/j0RcU2njJu8CkneviwNCPLPyWiGsSOMA6UtSB5MmqBWhliy1NuDT4vOwI+eGBWqZSgJiGB3cWvNDWoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980642; c=relaxed/simple;
	bh=fWWWl9GFsKVb/WhJpZ1G8nhPsaAr1YtFHAJ1glTSLcc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o8bCnimRCHgptMyQ0afqClvS+iNqYuNX4F1LkVOVb2/s5phfUPYEqqA53xhnzo+ahWsdkNC4PBGIKVAltBcCCnc30QuTdDXJiZ6DaOQPdr7dyTplWSraW6/z3OuMPDHVdcxUxVQsSrhvKmvlmh9tfmkA+5aS9hSIdoW9SzD6f28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+pkQ7Yk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKvSmFgU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ROuytJdE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p69yRgF9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+pkQ7Yk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKvSmFgU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ROuytJdE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p69yRgF9"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB9C2204A;
	Wed, 14 Oct 2026 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791980631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JX3WUeuPvBjFgfcR029LBr9vD/jVzdyphvy8NIseFJc=;
	b=F+pkQ7Yk7E30VT0xzJM/HgzpyE6Lw7mIJYDI0cgtggefBb30Ho2d/5nhOqL43RCV10r7vg
	zLgHRd2+hUJnPRGf/5twJRS8rwCjRo99NJKbA5WTms3hL5JoXbpE3qYEXHzl355bf6x80E
	7Q+ebU6nNHHjJKPlIb2DxGfNrjpOCso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791980631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JX3WUeuPvBjFgfcR029LBr9vD/jVzdyphvy8NIseFJc=;
	b=GKvSmFgUnwTMbKW0WqARkWdt56oPISCDE+JBa2gVWetLOf9jVKpRF15BwI7gOc7IHwaIa+
	KBqE5WAsIjztYkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791980630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JX3WUeuPvBjFgfcR029LBr9vD/jVzdyphvy8NIseFJc=;
	b=ROuytJdEld7hyu6Ud7hrSeqX3+n+wjn9XgzfM2LAcrXWE9lOqBI97xUF4gspRfDv3e0vp+
	3I60Jc7GJvP0vMjGdVz/6K2J/OBubtGgOneC69E5s6HF2eOT0RdRvTW1JtzwPzOo5oGiyg
	WsgkAe8HJB/6J1ilQid7DEHoa3/8ggo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791980630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JX3WUeuPvBjFgfcR029LBr9vD/jVzdyphvy8NIseFJc=;
	b=p69yRgF9+HewfuOvee6IODsPWStzQB84EsWkle20i5iG+DY3q3ZOnQVVgoS3tSCaE4xL3X
	+EyGjnq8+eRhViCA==
Date: Wed, 14 Oct 2026 14:23:50 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Andrea Parri <parri.andrea@gmail.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Song Liu <song@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, petr.pavlu@suse.com
Subject: Re: [PATCH] livepatch: Fix races between stack check and module
 load/unload
In-Reply-To: <20261012140546.154730-1-parri.andrea@gmail.com>
Message-ID: <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz>
References: <20261012140546.154730-1-parri.andrea@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi Andrea,

Cc+ Petr Pavlu (you can find the whole thread at 
https://lore.kernel.org/live-patching/20261012150758.207983-1-parri.andrea@gmail.com/T/#t)

On Mon, 12 Oct 2026, Andrea Parri wrote:

> Unloading a patched module while a livepatch transition is in progress
> can crash the kernel in klp_find_ops(), called from the scheduler.
> KCSAN reports
> 
>   BUG: KCSAN: data-race in klp_find_ops / klp_unpatch_func
> 
>   write (marked) to 0xffff9094c09ece10 of 8 bytes by task 381 on cpu 2:
>    klp_unpatch_func+0x1bd/0x280
>    klp_unpatch_object+0x6a/0x90
>    klp_cleanup_module_patches_limited.cold+0x4a/0xd4
>    klp_module_going+0x54/0x80
>    __do_sys_delete_module+0x247/0x380
>    __x64_sys_delete_module+0x39/0x50
>    ...
> 
>   read to 0xffff9094c09ece10 of 8 bytes by task 146 on cpu 1:
>    klp_find_ops+0x55/0x90
>    klp_check_and_switch_task+0x228/0x320
>    klp_try_switch_task+0xb4/0xc0
>    __klp_sched_try_switch+0x9a/0xb0
>    __schedule+0x60a/0x1450
>    schedule+0x3b/0x100
>    schedule_timeout+0xc0/0x160
>    ra_target_a_loop+0x97/0xa0 [klp_race_target_a]
>    ...
> 
> followed by
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdead000000000110: 0000 [#2] SMP NOPTI
>   RIP: 0010:klp_find_ops+0x55/0x90
>    ...
>    klp_check_and_switch_task+0x228/0x320
>    klp_try_switch_task+0xb4/0xc0
>    __klp_sched_try_switch+0x9a/0xb0
>    __schedule+0x60a/0x1450

Interesting. So to sum it up... you load a live patch which contains a fix 
for a module and while the transition is on, you remove the module and it 
crashes (btw, I do not think that those traces are necessary here. More 
btw, it would be nice to have a human readable changelog instead of what 
looks like AI generated description of the patch itself).

How did you find the issue? Is it a real problem in production?

I wonder whether we could just decline delete_module() in this case and 
return -EBUSY. It should be a rare operation anyway. Alternatively we 
could increase refcounts of all patched modules during a transition and 
decrease them after. Petr P., what do you think?

I am not saying we should not do the RCU protection but it feels like a 
can of worms a bit so if there is an easier way...

Regards
Miroslav

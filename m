Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DEB377A83
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161074; cv=none; b=T4eOWAEBHKAXTdNkNsKVH2Iebdxz+48eh/tITwCxlN8MSgFS9q0FMLcW7ccmZkJ/yALwsOWoKHJiJE7k9QHWs/olFTK0nBP5T1ELUvxgduAeidcLm4CtIkF3W0xsvtA26iyYXs6Mwg1shldhSFU6eNmJRpdA1wIzF5F9sDrtOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161074; c=relaxed/simple;
	bh=qaSleZlW3nXuTXd0EhZkXj7WhOX+X9Tdrdi1jQx2VI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aSZI8DTUiaWKEz/hRqPR7kwJsOlebdP8Z77yFp1QDgXJUIJgMNU36ZGnRaJfXUk+5Kf8/Q9yAqlzdpliENqQn5sl7C7e8n4DQUDe7wBjQ17d3bUE60sdHDdkH7PQ2cPz0FxtGWbKon547GzlOvUu9+yVdIZ3O7ztf6zBGbbTKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lLzuDpcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVg6Omdw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VXAa8D/q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BueSwkbQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lLzuDpcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVg6Omdw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VXAa8D/q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BueSwkbQ"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A9D921C5E;
	Fri, 16 Oct 2026 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792161063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4f5jTznm1xS5lXeSHA4KQdVoMwMQCPBjS0e8+iN9CDg=;
	b=lLzuDpcqgmJk1OSFq14FxNqO1wkGrHF824kBJJP67UuQpzK1Ye+JoyaaJwnyOQK4J3Rwe/
	lnvsEHWMe3jQF4HL1aBBsMJlYBPEnSjNhXVBor0jxE57ERS5U8ecNbLF18Pesofpu+h7ik
	H6XwdLjEWCcN2Ya/Ji5SMHTCkHKKtfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792161063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4f5jTznm1xS5lXeSHA4KQdVoMwMQCPBjS0e8+iN9CDg=;
	b=YVg6OmdwHDXy+o5pKhH4yc8e4+CWwTbPleoPKRrBN37FXO7DIr6bq0+53ZxtSP1VeRcsG1
	RMFd8H8tTOzxSwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792161062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4f5jTznm1xS5lXeSHA4KQdVoMwMQCPBjS0e8+iN9CDg=;
	b=VXAa8D/q0D3apwvDFxN9m0hsWMxrBzvTj3U5c9kLlsy36JDBrM1cDH6jX+5Mv2JwaSXHxI
	EBtvpPl07exS6JFxu3wQox+fCHuiVbhXrPBx0yRxWXH++Qegn3XwKEmhj09Tam//kZqqkJ
	1BGFR7sQXqtKS22nyv4COg5XTNPB88Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792161062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4f5jTznm1xS5lXeSHA4KQdVoMwMQCPBjS0e8+iN9CDg=;
	b=BueSwkbQe1tF91gzhS4/KNhCRJzYMI9VT14XzBP8/Acw7BErSC6Iay4jLmM4hpgotsGqYK
	m8TGrms8Fo3JFMCA==
Date: Fri, 16 Oct 2026 16:31:02 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Andrea Parri <parri.andrea@gmail.com>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
    Song Liu <song@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, petr.pavlu@suse.com
Subject: Re: [PATCH] livepatch: Fix races between stack check and module
 load/unload
In-Reply-To: <20261014133553.102324-1-parri.andrea@gmail.com>
Message-ID: <alpine.LSU.2.21.2610161625430.16668@pobox.suse.cz>
References: <20261012140546.154730-1-parri.andrea@gmail.com> <alpine.LSU.2.21.2610141410370.16733@pobox.suse.cz> <20261014133553.102324-1-parri.andrea@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
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

> An LLM found it while auditing kernel/livepatch/.  It is not a
> production issue.  The reproducer was written by an LLM as well; it is
> below, apply it with "git apply -p0".  It keeps a transition stuck on
> a few kthreads and reloads a patched module in a loop.  On v7.3-rc7 it
> faults in klp_find_ops() within a few minutes with KCSAN_STRICT=y.

Ok, kthreads certainly make it easier.
 
> > I wonder whether we could just decline delete_module() in this case and
> > return -EBUSY. It should be a rare operation anyway. Alternatively we
> > could increase refcounts of all patched modules during a transition and
> > decrease them after.
> 
> I don't think either covers all the paths.  klp_module_going() is also
> called when a module's init fails, or when its load is aborted after
> klp_module_coming(), and neither -EBUSY nor a module reference prevents
> that.  Loading a patched module also adds to klp_ops under the walk.
> And klp_find_ops() walks the global klp_ops list, so it's the modules of
> all patches that matter, not just the transition patch.

Correct. You would need to check all and you would need to hook up to the 
module loader differently to the current state.

> > I am not saying we should not do the RCU protection but it feels like a
> > can of worms a bit so if there is an easier way...
> 
> I could split it: one patch RCU-protecting klp_ops, which fixes the
> crash, and a second one for the ordering on module reload, which was found
> by inspection and has not been reproduced.  Would that be easier to review?

Please. It should always be well structured (a logical change per a 
separate patch and such).

Let's explore Petr's proposal first though.

Miroslav

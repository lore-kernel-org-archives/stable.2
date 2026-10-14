Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673152F26D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993186; cv=none; b=NjY1c1+f1e69YH0TmAX7ckLWIkakZQBxc4ol2zfI0tlCtGCW9Q00pL0Ry32bNMVtQA65wC+0p5ZnHyxK4zASr06h+N2/Fr4AqI8dqVuqJkhllFihj32cwtUbRZ96Ep3/IpBxk50NYi7hj4ZK7usGUFRxAhZS9Q6pfjlJ7ZNFG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993186; c=relaxed/simple;
	bh=qUNCs/h/PnBunQxzlEw5HkMze8K6J1Agoe6ODkY1bv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lafYUCTYHbfckuNusTMVjd+6EcqcemvVFroklBxQuDYuIyy5CeICPuwc8KDt+4T0gNz2zXYJCnfedU++TNF+kY5asaAxkcNfG1kMxXm0/7kenFThYFu4/JCkIWf1JO/q8MuzzhDUfIJtg45fTTCQdWL0XH1piHMm1TrH0OlpORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oog3dITA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8yYzH3w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oog3dITA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8yYzH3w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oog3dITA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8yYzH3w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oog3dITA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8yYzH3w"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 175431F7D5;
	Wed, 14 Oct 2026 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791993183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czptinR0+qpHm2+DqArj4j7rjTfE20PU59BUkqAFUyU=;
	b=oog3dITA1Q+xNqbWg6Licu5XuXBfbEV9jBYYlduikYAlz/3YwpRJm0AdXNmo5TWcR9TtTl
	EBYSSF4wftcr3IvmezzufjRO3+Ws+xFaNdIFXpaptNPDEtw3H6xUYDS7k37Wf+x3Mt0rZI
	eW6s0wifWj1OF0088usYpwmgGrXs5Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791993183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czptinR0+qpHm2+DqArj4j7rjTfE20PU59BUkqAFUyU=;
	b=A8yYzH3wD2CzI4bOHdW5SVLIaZGK8rO/4jxjjbRA2FBGXn6kCXS95OtKkAC22mrWpPBgbQ
	cFj7EfUk1kehiXCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oog3dITA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A8yYzH3w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791993183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czptinR0+qpHm2+DqArj4j7rjTfE20PU59BUkqAFUyU=;
	b=oog3dITA1Q+xNqbWg6Licu5XuXBfbEV9jBYYlduikYAlz/3YwpRJm0AdXNmo5TWcR9TtTl
	EBYSSF4wftcr3IvmezzufjRO3+Ws+xFaNdIFXpaptNPDEtw3H6xUYDS7k37Wf+x3Mt0rZI
	eW6s0wifWj1OF0088usYpwmgGrXs5Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791993183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czptinR0+qpHm2+DqArj4j7rjTfE20PU59BUkqAFUyU=;
	b=A8yYzH3wD2CzI4bOHdW5SVLIaZGK8rO/4jxjjbRA2FBGXn6kCXS95OtKkAC22mrWpPBgbQ
	cFj7EfUk1kehiXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4371133F1;
	Wed, 14 Oct 2026 15:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M/ADJ12lz2pgYQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 14 Oct 2026 15:53:01 +0000
Date: Wed, 14 Oct 2026 16:52:59 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	stable@vger.kernel.org, Samarth Narang <samarth.colleges@gmail.com>, 
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH] mm/madvise: atomically clear the young bit on THP
 MADV_COLD
Message-ID: <as-iHm9Y4wxRTG5d@pedro-suse.tail5790ac.ts.net>
References: <20261013191719.95502-1-pfalcato@suse.de>
 <as-dr-S6c3FALwQb@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-dr-S6c3FALwQb@gremlin>
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,google.com,suse.com,cmpxchg.org,kvack.org,vger.kernel.org,gmail.com,gourry.net];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 175431F7D5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, Oct 14, 2026 at 04:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> +cc Gregory
> 
> On Tue, Oct 13, 2026 at 08:17:19PM +0100, Pedro Falcato wrote:
> > As-is, madvise_cold_or_pageout_pte_range() discards the hardware young
> 
> The function from hell... Gregory - PLEASE FIX THIS SOON :))

:))

> 
> > bit by invalidating the PMD, doing pmd_mkold() and subsequently writing
> > to the pmd again. However, it does so in a racy manner, looking at a
> > possibly-stale snapshot. It's entirely possible that a write elsewhere
> > set the hardware D bit, which this logic now loses.
> >
> > Fix it by using pmdp_test_and_clear_young(). This is an atomic
> > modification of the PMD entry, and thus safe against any possible racing
> > writes. As a (nice) side-effect, this elides one non-required TLB flush
> > in pmdp_invalidate().
> 
> Nice, I'm guessing the tlb_remove_pmd_tlb_entry() does what we need already? (as
> discussed off-list :)

Right, so the whole gist of it is that indeed for 99% of cases you don't
need to flush TLBs when clearing young. Out of all the ptep_clear_flush_young()
implementations out there:
 - arm64 does a light tlbi to help make sure the A bit will be cleared whenever.
(I remember reading about this, and it was due to some really weird hardware
that kinda wanted this)
 - ppc64 just clears it
 - parisc does a non-atomic get+clear with a tlb flush in #if CONFIG_FLUSH_PAGE_ACCESSED.
CONFIG_FLUSH_PAGE_ACCESSED is hardcoded 0.
 - riscv is just a clear
 - s390 is just a clear
 - x86 is just a clear
 - pgtable-generic does a TLB flush. Unclear if most/all users using it actually
require it, or if it's just nonsense.

For now, the tlb_remove_pmd_tlb_entry() (and corresponding tlb flush in the PTE code)
does the job.

Anyway, the point being that I kinda want to avoid these flushes, but it's
not particularly trivial ATM, with the tlb_gather API. I'll try to remember
and send some (hopefully tasteful) patches next cycle, on top of Gregory's
make-madvise-cold-not-hurt-my-eyes patches that will have surely landed
by then.

> 
> >
> > This bug can interact with the swapping system in complicated ways, leading
> > to data loss. For instance, if a folio is marked lazyfree, but was later
> > read from, and then MADV_COLD'd while racing a write to that same THP,
> > dropping the dirty bit may lead to data loss as reclaim/MADV_PAGEOUT drops
> > the "clean" anon folio:
> >
> > T0                                T1
> > ================================================================
> > MADV_FREE(thp)                  |
> >   folio marked lazyfree         |
> > read(thp)                       |
> >   PMD marked young by hardware  |
> >                                 | MADV_COLD(thp)
> > write(thp)                      |   if (pmd_young(pmd)) {
> >   PMD marked dirty by hardware  |     set(pmdp, pmd_mkold(pmd));
> > MADV_PAGEOUT/reclaim            |
> >   dirty bit may or may not be   |
> >   set                           |
> >     reclaim/pageout may drop    |
> >     the folio                   |
> >
> 
> Thanks, nice explanation (even if the >quoting ruins the indentation on my editor
> :P) [untabbed for my benefit]

Thanks for the review :) indeed the tabbing looks ugly when quoted.

-- 
Pedro

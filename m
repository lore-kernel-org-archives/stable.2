Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525485;
	b=Biz5jnfyzM9SnJUsPcbHCCu9JSn7vDGYRl1qDZ/ZuYX7zmlsIRGYQQnPs4iMRIJQmhk7
	 Lqaz5c9og53aQX9JC37NwlYOIwcYnpF5rXCzoaShCpsEqYOuo5p3y6wWvC0JMlw5xDstV
	 jYwTLW0LCxuwEcUjO06zAlyZUoKjrwHLk9hSVU+GQ9valGZDHWhb/g4b3n3lRQPxW/QC4
	 EfQHGbumRbKE+oSPXssCRVUGmCK020kKhAJ7RLgQ6peDyLnulQ41EGF87HbhYu9eYX9Pz
	 LhFzwQSlKLKKbgOYlp3YRCeck3O0Pc/mQdMvNWwo8JgzMPgUH8yEQZMci72vPp43Mfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525485;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=MGLlsaUUSwBgOFasvcC4m8G1HbbNWKywwDMCQ+xfhD8=;
	b=yY79upYOVKMnMr51RqJI+s9bB5q1JLFbCBPJ7eoMvcCug0VESh3Huktswz/L5QtjryRQ
	 /G3jG2C8aMrDsEbZiVWSHtByoQ3/eFjT4ce4ZoEyVZj1xDQCl15d8jVigrDj9o8HiebLB
	 RJdZBabqYwfRXqKpTecx8XV9ruF9/EifHMumYKINhhQO7Zst58vsBfHEJnH1jkAovy0uY
	 Q5yMWu0C6iB7GGiARTt8g30h0GyW0x9CZcLhGqJWeVim30kq+6aXL54NT5EY17U/g3kqM
	 Y157XkE0hxfAanPFpr/EjYCuMoy0zDJvdmf8awVKXq0K0eOMz/b6khErPQSpjIAzxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d6hKvlJg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o2pbox66;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d6hKvlJg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o2pbox66;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DDC606A326;
	Tue, 24 Nov 2026 13:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DDC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d6hKvlJg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o2pbox66;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d6hKvlJg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o2pbox66
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5391221D0;
	Tue, 24 Nov 2026 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795525482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGLlsaUUSwBgOFasvcC4m8G1HbbNWKywwDMCQ+xfhD8=;
	b=d6hKvlJgG4X7khE+jq9at3VtIrBK87hyEDrBYy47SpMqyBgQyCGtWYEJB2QxO4UP0dEynx
	HjMVntQ+5DCCgsmIa+ciX7ASPhoddYx8/NpY+DyRzyEOwxLhm6r1dhG2ZUHEju5VFoFd3z
	EogkhkBofC6765TNqpTrNAp6xukXKfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795525482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGLlsaUUSwBgOFasvcC4m8G1HbbNWKywwDMCQ+xfhD8=;
	b=o2pbox66290zEHTPTnLGRnEyF5M3kv9q1MZs1eYZssGtRnTpu9DoDG0/d4VS1CplMZajUS
	JEagk2uRr0Os3XDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d6hKvlJg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o2pbox66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795525482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGLlsaUUSwBgOFasvcC4m8G1HbbNWKywwDMCQ+xfhD8=;
	b=d6hKvlJgG4X7khE+jq9at3VtIrBK87hyEDrBYy47SpMqyBgQyCGtWYEJB2QxO4UP0dEynx
	HjMVntQ+5DCCgsmIa+ciX7ASPhoddYx8/NpY+DyRzyEOwxLhm6r1dhG2ZUHEju5VFoFd3z
	EogkhkBofC6765TNqpTrNAp6xukXKfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795525482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGLlsaUUSwBgOFasvcC4m8G1HbbNWKywwDMCQ+xfhD8=;
	b=o2pbox66290zEHTPTnLGRnEyF5M3kv9q1MZs1eYZssGtRnTpu9DoDG0/d4VS1CplMZajUS
	JEagk2uRr0Os3XDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DDE913505;
	Tue, 24 Nov 2026 13:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+wrM2iLBWuQKQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 24 Nov 2026 13:04:41 +0000
Date: Tue, 24 Nov 2026 13:04:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
X-Rspamd-Queue-Id: D5391221D0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxemws8ixnqptfze8914thf37)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.51

On Tue, Nov 24, 2026 at 12:26:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> per-VMA locks") open-codes a lock_next_vma() implementation that does
> roughly the same thing in bpf_iter_task_vma_find_next(), only without
> fallback to an mmap_lock.
> 
> This is because bpf_iter_task_vma_find_next() can be called from
> non-sleepable contexts.
> 
> However, lock_vma_under_rcu() gave no guarantee as to which contexts it is
> safe to be called from, and indeed it turns out this assumption is unsafe.
> 
> Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> vma->vm_refcnt got dropped"), this call chain is possible on x86:
> 
> lock_vma_under_rcu()
>   -> vma_start_read()
>     -> mmdrop()
>       -> __mmdrop()
>         -> mm_free_pgd()
>           -> pgd_free()
>             -> pgd_dtor()
>               -> spin_lock(&pgd_lock)
> 
> Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> called. Since bpf_iter_task_vma_find_next() can be called in softirq
> context, this can deadlock, for example:
> 
> pgd_alloc()
>   -> spin_lock(&pgd_lock)
>     <softirq>
>     bpf_iter_task_vma_next()
>       -> lock_vma_under_rcu()
>         ...
> 	  -> spin_lock(&pgd_lock) [ DEADLOCK ]
> 
> Alexei Starovoitov also pointed out that a BPF program attached to
> trace_contention_end() can similarly cause a deadlock:
> 
>   pgd_alloc()
>     spin_lock(&pgd_lock)
>       queued_spin_lock_slowpath()
>         trace_contention_end()          <- pgd_lock is held
>           tp_btf/contention_end prog
>             bpf_iter_task_vma_next()
>               lock_vma_under_rcu()
>                 vma_start_read()
>                   mmdrop(other_mm)      <- last put takes pgd_lock again
> 
> Resolve the issue by having vma_start_read() use mmdrop_async() instead of
> mmdrop() so the work is deferred to a work queue.
> 
> Make mmdrop_async() an internal mm function, defined in mm/internal.h, to
> avoid abuse elsewhere (kernel/fork.c includes this header, so still retains
> access).
> 
> Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> failure") accounted for the fact that the RCU lock had to be dropped for
> this operation, which is no longer applicable.
> 
> For the sake of a backported fix, retain this behaviour, however drop the
> RCU lock last and remove the now irrelevant comment.

Is there any particular reason for unlocking the RCU comment last? after the mmdrop_async().

> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

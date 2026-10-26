Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019876;
	b=zh/82SUCp1hcYUHtlLawXBglUU4at3hdHW8i/0qaG/JU6ZubqQVEx0KZ89TEXLJAjGBS
	 YKaKhUMHYdfhEOL+snAk8S+YyMyjzAic8/G2yf3s/AQTd0+zAbK7oBWEaJ/HFHhiBMh+3
	 +Q3oikaSqM7r1811wFCrwHOuf+NGnZGAxJvJG+4Z8oBsRbJismCbBqr+uQ41/PIunIzJg
	 NzXj2k7sc5rLZUz8fk6KVzJioRW8Q9kEwRABnyK2I/trgPP7trRH/6EMt/JXXDnAill3o
	 a1hc7Rxujoh1OoinJi6g+UavnBQNHaXL8XONAXuV0Ue0Y7+aHLcdvKgqxHn5Riyibzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019876;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=ZIswRzs/zvKVOfGAbelQflhj/nPlIN8fDFh4mSjv214=;
	b=NuuyFu/ieX6eXOrf66xqjvhYnKXk+8EtTqgy9TM6e604VbKH+ggKdd7rWT1sT1dlP4xJ
	 W7UDqur0Q2vE7iL29roB7caBA4FE4FMkHa8VlIJyxK1aoK979bE3isw5TWt+YmAhHb8dA
	 QZ22awfTeFxv9B9T8Tb2d/9XBUHeJaJ7dCjNF8ajWt9tWrXLPSb7RZLaOQtVx8sqNxAhw
	 cgVo6y4CYE6jVQX+yERQ5h6NEqxb7DYC37IXK4g99iRoVIgl93AL9Xe9ixq7HgdK0uYLS
	 0lSNkL33i5PS1+e7OTFzk3Sghk4Nu9zedru/YtO8fdIXCZPQRfbL5T4x4YBgryWr5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T4r7PFnC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5IbUzN8R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T4r7PFnC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5IbUzN8R;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F2606A31B;
	Mon, 26 Oct 2026 13:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 306F2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T4r7PFnC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5IbUzN8R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T4r7PFnC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5IbUzN8R
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 768DD22263;
	Mon, 26 Oct 2026 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793019874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIswRzs/zvKVOfGAbelQflhj/nPlIN8fDFh4mSjv214=;
	b=T4r7PFnC6a6bo3FLPh2pHPasrNYwkUu22QRucY9lkw/eYVB08z666uo9MYMhM4MecGsSR7
	JnnGHD8z6p8qxSFiuieAh2BuTTT9QpxL+nXlRtJvRmHXPNupBevDs0FybktYEgVeDwN4K6
	1t4fdUqCSuCJSq+8q5XXKUjy6awn6Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793019874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIswRzs/zvKVOfGAbelQflhj/nPlIN8fDFh4mSjv214=;
	b=5IbUzN8R69d3Kd/2Ai6i59hb6GA0hs9Z8aHyYBjmv9OOVRrbCjwPPslMWrH39P+ZmOAbZf
	x4irkTqMvz3LDHCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T4r7PFnC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5IbUzN8R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793019874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIswRzs/zvKVOfGAbelQflhj/nPlIN8fDFh4mSjv214=;
	b=T4r7PFnC6a6bo3FLPh2pHPasrNYwkUu22QRucY9lkw/eYVB08z666uo9MYMhM4MecGsSR7
	JnnGHD8z6p8qxSFiuieAh2BuTTT9QpxL+nXlRtJvRmHXPNupBevDs0FybktYEgVeDwN4K6
	1t4fdUqCSuCJSq+8q5XXKUjy6awn6Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793019874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIswRzs/zvKVOfGAbelQflhj/nPlIN8fDFh4mSjv214=;
	b=5IbUzN8R69d3Kd/2Ai6i59hb6GA0hs9Z8aHyYBjmv9OOVRrbCjwPPslMWrH39P+ZmOAbZf
	x4irkTqMvz3LDHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B83613408;
	Mon, 26 Oct 2026 13:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XqdMAeFP32rTXAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:04:33 +0000
Date: Mon, 26 Oct 2026 13:04:31 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
	Colin Cross <ccross@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing
 anonymous names
Message-ID: <at9ProKo5XiQ-CRW@pedro-suse.tail5790ac.ts.net>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org>
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
In-Reply-To: <20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 768DD22263

On Fri, Oct 23, 2026 at 02:47:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> When changing the anonymous VMA name, madvise_update_vma() calls
> vma_modify_name() to possibly merge with adjacent VMAs. We don't call
> vma_modify_flags() and consequently don't obtain the new VMA flags.
> 
> Later in the function we update the VMA flags to the stale new_vma_flags
> we obtained before. This can result in us losing the VMA_SOFTDIRTY_BIT
> flag set on a VMA we just merged with.
> 
> There is no need to update the VMA flags at all, so just exit early. This
> skips calling khugepaged_enter_vma(), but since the flags didn't change
> this is fine.
> 
> Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ ljs - Minor edit of commit message, rebased ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  mm/madvise.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b2e00efcaa54..e9fa4f71efea 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -177,6 +177,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
>  
>  	/* vm_flags is protected by the mmap_lock held in write mode. */
>  	vma_start_write(vma);
> +	if (set_new_anon_name)
> +		return replace_anon_vma_name(vma, anon_name);

This looks non-obvious and brittle, maybe have a comment here?
Or some more clever solution.

-- 
Pedro

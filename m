Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A494399ED;
	Mon, 28 Sep 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593214; cv=none; b=RzCgP+U5+Y5T4lmC8iMp25dmQ/HxwiqyDhhD9Tp5WIg+rPUAArjIpCsGNzgvrH4mtg99tF6y8SXmzKeR5NWkExSJO/shebS4GLc/fGHEnOw2l+6OWBIOdB52rpMLKhqGdN9/eK9ZDbn1L/kfcwzdK6Fbmn9GgmzNIVn89JpQRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593214; c=relaxed/simple;
	bh=1xpJY2tjDUrhZ87WAGGx/x+ygkynTFsfzSLGD8F8M9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAY31UtrDTtJbgkpC4HtZXwphZU5X+fxa+uQ8KKxeZfX3o/1uZ3VO7Is5UXAE9YieT9mtP5n9m9UcqjLZuXe4LxJApF3Tu7jiMup9RTQPQEwXNdsOTye/FAUJdeXpkU2g1wMfU6sdgFyjQQ4tzNHC63xTdI/hiIASCMKbHciu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UTg27kSp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9VkpnhhM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NrEvgq5j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIpXs8ht; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UTg27kSp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9VkpnhhM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NrEvgq5j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIpXs8ht"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 225EF1F44F;
	Mon, 28 Sep 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2S8+GdwVQT3oIDF7iUf4yAkw9CJO+ecLy3lo1BQi1k=;
	b=UTg27kSpSkCSNvIviojIfZQ7w+K14eltFeyqd3ci8DBUMCZuPqT2gROSTRGcWU+tIML74N
	IDvMpXMppmpIFpbYQO6M9iqTr3Ds+SbQuErq/yXzgJe894+18mqWw2Mb2XJMmo6WWAu145
	Mpu/0BBAPZ+T1Nwk8R8JwoW6ShkqJVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2S8+GdwVQT3oIDF7iUf4yAkw9CJO+ecLy3lo1BQi1k=;
	b=9VkpnhhMT9rMC2CT7BiNGr9nNIgmi5H9TJnyyzMZOKNHRGJr8c5YyzsT/jNuB748WiZrZp
	mm72vHAZhv5CInCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2S8+GdwVQT3oIDF7iUf4yAkw9CJO+ecLy3lo1BQi1k=;
	b=NrEvgq5jAqieiU4GgvnuDimNk0r8QlH/AZrRhUSVTG5qr/Nu1YEOhzMNpmUfpmiUYErCc2
	xSzp1PCjc6EgtDhWCDRaNSpTSt/27QlwafoHp7lX0nNvV6Ved6rvi1obYt0qd1iX4xcsix
	IQQV9Tr53VsQPdns+noLzGO5Z3/t+Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2S8+GdwVQT3oIDF7iUf4yAkw9CJO+ecLy3lo1BQi1k=;
	b=AIpXs8htZcGwyt4u7tUmwElrCeomOKxxR+aNCCiIk17haoB+VJ4mpVYHF72sPuhIUUKZBv
	XO+6hyDvCA6mTaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 268BF13418;
	Mon, 28 Sep 2026 11:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZvjgOLFIumpIIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 28 Sep 2026 11:00:02 +0000
Date: Mon, 28 Sep 2026 12:00:00 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP
 self-merge
Message-ID: <arpInHieR4dtSqPK@pedro-suse.tail5790ac.ts.net>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO

On Sun, Sep 20, 2026 at 03:13:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
> 
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
> 
> Fix another of these - self-merge.
> 
> Self-merge occurs when a VMA is moved in front of or behind itself and the
> attributes of the VMA permit such a merge.
> 
> Practically this can only happen for unfaulted anonymous VMAs due to the
> page offset equality requirement for merge:
> 
>                            |------------|
>                            |            |
>                            |            v
>         |...........||-----------||...........|
>         |           || unfaulted ||           |
>         |...........||-----------||...........|
>               ^            |
>               |            |
>               |------------|
> 
> This becomes problematic if the VMA is configured by the user to
> mlock-on-fault, i.e. the VMA_LOCKED_BIT, VMA_LOCKONFAULT_BIT VMA flags are
> set.
> 
> MREMAP_DONTUNMAP clears mlock flags for the source VMA and maintains them
> for the destination VMA.
> 
> Self-merge makes this impossible (there is only one VMA) and incorrectly
> clears the destination VMA's mlock flags.
> 
> This causes a leak in mm->locked_vm as clearing this flag does not
> decrement the counter and the VMA no longer has VMA_LOCKED_BIT set so it
> is not decremented on unmap.
> 
> Resolve this by simply disallowing a self-merge in this case - the source
> and destination VMAs are kept distinct and then are able to have distinct
> mlock() flags.
> 
> Update dontunmap_complete() to make the now-redundant self-merge check a
> VM_WARN_ON_ONCE() instead to guard against future regressions.
> 
> Also update the VMA userland tests to reflect the change.
> 
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro

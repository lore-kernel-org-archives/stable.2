Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0449DB9B;
	Mon, 28 Sep 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593723; cv=none; b=M0XfoLakbJnQIjb0vRfQHmhGahV9CKBeZde0WyoHfKCaaLWZOrcJMsqTQ8KKmZpkVpE1gMtvvQIi0Njs57U564NHX6dgrx5swK2O80llpRybeooepVS1deBg8mzHdPdhxFZ0XJ8FD61NqMOsGowR3hs9WkLDYEgft2KstYRgKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593723; c=relaxed/simple;
	bh=yl6osv4k7D3zQoj5wBIbU7ZcwQ1sCs95rhyIq1L/GrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrjSApgiNGrWne3+m2ukJ7rZmFF8b5V2BwbDYOMwHjF3xhOct/yrAS2bhPI+mTL6xYw/jyMttYuOM+Pd/rV9BoYAQDNZkwUa8ZxFvdR7xS2WIb7tShyzhFc+ptAZZBlY9/NUY90awIk6AFQrSDMqdM5ZdgwZ5mYvUe91PS39DD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jS6qZvYu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M9IUB5D0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H3MMkU2+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=11HPE9PE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jS6qZvYu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M9IUB5D0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H3MMkU2+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="11HPE9PE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1AE5226EE;
	Mon, 28 Sep 2026 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/xZeQ5cyTZWsRIm6/m0DTTQKyIaa+hduhVvGYFDMQ=;
	b=jS6qZvYuUdVoFCHgSQD3wfwWuVjA9pM7IBFXDniP5kK2hL2ZV7cZU7wjQ5jq7H80h+U5nz
	KVf8ICPoBUiTz3lS3dVAWNc0wFZCuQnoHwc5IWi9srDY99HUbUFcoZda6ebNexAutFL7Mz
	p0eeJsH4UTA0o7Ged9CmW14t8mUY3Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/xZeQ5cyTZWsRIm6/m0DTTQKyIaa+hduhVvGYFDMQ=;
	b=M9IUB5D0aR/HJvrf+SIjJJ1gwywQ/SEbpmuDNmR8r8JMAnlN3CussjXHb1nsd7+UNSB4ab
	UIE9Xwrl3azubIBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/xZeQ5cyTZWsRIm6/m0DTTQKyIaa+hduhVvGYFDMQ=;
	b=H3MMkU2+A3/+lLbBXPjkbi5Cn+IhbY1t86KvifnhoRJoLnfAyNvuZdUWQ2M1nCyeQqx7JY
	5zRyTWchzbHh957YCU/Z9VOksrh7v2aaMwOtznZ8xTt1MdyNSS+dTkYa+gBfycZ+qGBUCg
	ddQsVoZtJ+KATSQ8m6xYQI9PEdg95L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/xZeQ5cyTZWsRIm6/m0DTTQKyIaa+hduhVvGYFDMQ=;
	b=11HPE9PE8eprCrSLd3OCEMcP7Fx7Kjvy8inGLHzBoK/bavI0aVo0H8OTN08XspznyT74cN
	CKAcc4GqhTWoZsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B39133F1;
	Mon, 28 Sep 2026 11:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zG3UIa5KumqhKAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 28 Sep 2026 11:08:30 +0000
Date: Mon, 28 Sep 2026 12:08:28 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mremap: fix locked_vm leak by splitting VMA for
 MREMAP_DONTUNMAP
Message-ID: <arpJfa2ssGZYduRJ@pedro-suse.tail5790ac.ts.net>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-2-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-2-6ffb556f8f8b@kernel.org>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,pedro-suse.tail5790ac.ts.net:mid,suse.de:email]

On Sun, Sep 20, 2026 at 03:13:11PM +0100, Lorenzo Stoakes (ARM) wrote:
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
> 
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
> 
> Fix another of these - partial copies.
> 
> The long-standing mremap() partial VMA logic has the baked-in assumption
> that the originating VMA is unmapped and thus moved.
> 
> However MREMAP_DONTUNMAP defeats this by performing a partial copy
> instead since it keeps the source VMA around.
> 
> An mremap(..., MREMAP_DONTUNMAP) operation disallows resizing of the VMA,
> but the operation can be performed partially:
> 
>                            |-----------------|
>                            |                 |
>                            |                 v
>                         <------>          <------>
>                         .new_sz.           new_sz
>                      |--.------.--|       |------|
>                      |  .source.  |       | dest |
>                      |--.------.--|       |------|
>                      <------------>
>                          old_sz
> 
> The page tables in the specified range are moved, but the original VMA is
> kept intact.
> 
> This interacts poorly with mlock()'d VMAs, as the VMA_LOCKED_BIT flag is
> cleared for the entire source VMA and set for the entire destination VMA.
> 
> This results in an mm->locked_vm leak as the change is therefore not
> accounted correctly.
> 
> The clear solution here is to make the portion of the source VMA which is
> mremap()'d distinct from the rest of it, a.k.a. split it.
> 
> Therefore resolve this issue by splitting it ahead of the rest of the
> mremap() operation.
> 
> In order to make this change re-expose split_vma() in vma.h for
> CONFIG_MMU (nommu doesn't compile mremap.c and uses a static helper
> instead).
> 
> A quick search of how MREMAP_DONTUNMAP is used in the wild suggests that
> the partial case is either unused or rarely used, so this should not result
> in unreasonable VMA proliferation.
> 
> Since this makes every mremap() MREMAP_DONTUNMAP operation operate across
> an entire, distinct, VMA, also eliminate now-redundant code checking for
> this in dontunmap_complete().
> 
> Finally, update the sys_map_count check to account for this case.
> 
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

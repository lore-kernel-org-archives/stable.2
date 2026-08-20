Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D932F39B4;
	Thu, 20 Aug 2026 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264417; cv=none; b=lMjT13FanF/8ZGiKcVwV19SpZPsL2JBC1nJXWVh5U0IVxbt2vGzK6WPlPvtslsDlUXS2R6qIMlNxhWUVHBH/QPuPqz3CM+w5NaZbeVwYV/8DK9ikEm1X6ubStMGDbIC5BitHduta6ix14fqHF8GQYfKMPcFCnL0tEhjFQSa9BTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264417; c=relaxed/simple;
	bh=BOTYd7LqC9q1nx0v2p8he/uaKSv32k6sqE3w1RRnF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfKSVGIyGlhr9EYb+1EiBDHdWHYFNkJZl2tEkOBKsE93T8tZrdfpgHaxJv5/XO/EIUDNG/D79k1P1UT+K9q9ZR5i/Gvzy4Asg0XIzY/CxpRC9PO358g8kOOdnN2wW/d300IW2FsZRCmLUMp7HxwjkJ5nYgTo61yZAFfEl9lZAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0wOXg2ig; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BNzF3pqd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbnUn4D0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FB17yxxo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0wOXg2ig";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BNzF3pqd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbnUn4D0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FB17yxxo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F9F6836AD;
	Thu, 20 Aug 2026 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787264409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UYo1YUmYjiLsT0KlUjloBndh6L1gE7npqqcdG7O6gk=;
	b=0wOXg2igCLpLElcvbOXInsEu1wTk0thze9mBcB3HxlRJ9iw5pwDtWF7+ECgPFjRG/eE2NU
	mSDcPTyVHmmRI6oxs1kJAZTLp8tadsHEDXpjTc5uIHFN/uIZsIqHa4FAlyE3KN1gBBrvpY
	oKN9/v5Cp63otwX5tqixf79m+PjLuOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787264409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UYo1YUmYjiLsT0KlUjloBndh6L1gE7npqqcdG7O6gk=;
	b=BNzF3pqd0X8ULDWj1tbBA16qZ0M3F+T8XUUL+e6gxorjotnvdYoDCHCBfMXD5sC7qPo2GW
	AUKJTLALnn8gc/AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vbnUn4D0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FB17yxxo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787264405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UYo1YUmYjiLsT0KlUjloBndh6L1gE7npqqcdG7O6gk=;
	b=vbnUn4D0so/Dg4cjNTfXXym2RGI52o7ZHwOSAPxwcZIZcZobLK6HM1yDxXho0cEZSgnxt0
	ys9+mrQ9xHQLYCtfDnRX7H8QOrwl7V2eSI4lu/oqWK30xTKM2fy8oVsOQVa28PFEPgenFL
	NY741Jhz+6FRw4HoDANqJrRkNZVMDD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787264405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UYo1YUmYjiLsT0KlUjloBndh6L1gE7npqqcdG7O6gk=;
	b=FB17yxxo6SQVjG7FjqFd8dURhcYaOSRi0YYKWwJ2a+So1bh97XaU9EiEnYj6zs3A0qa6F7
	P2S8oAXKR3VA5dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95D3C27A8;
	Thu, 20 Aug 2026 22:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h0w9IZN9h2qQMAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 20 Aug 2026 22:20:03 +0000
Date: Thu, 20 Aug 2026 23:20:02 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: kas@kernel.org, usama.arif@linux.dev, hughd@google.com, 
	akpm@linux-foundation.org, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	david@kernel.org, dev.jain@arm.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	stable@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <aod88sqdJ6qrNBxc@pedro-suse.lan>
References: <aocFPRgqieScf_yo@pedro-suse.lan>
 <20260820165334.36401-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820165334.36401-1-lance.yang@linux.dev>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,google.com,linux-foundation.org,linux.alibaba.com,arm.com,infradead.org,vger.kernel.org,kvack.org,nvidia.com,gmail.com,cmpxchg.org,surriel.com,meta.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 1F9F6836AD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri, Aug 21, 2026 at 12:53:34AM +0800, Lance Yang wrote:
> 
> >For some context: we were discussing (off-list) the recent report that
> >systemd-journald had horrible write amplification, worsed quite a bit
> >by large folios. At the moment, there is quite a lot of write amplification,
> >but _only_ on mmap writes (if you look at the write(2) paths, you'll see
> >write_begin and write_end which tactically only dirty what you actually wrote
> >to, block-wise in the BHs or iomap IFS). This doesn't need to be true.
> >
> >What we conjured up was the following: since WP faults always happen on PTEs,
> >you can simply dirty the block(s) corresponding to that particular PTE (which
> >naturally points to a page inside the folio, whether it is large or not, doesn't
> >matter). That way, you can avoid fully dirtying the folio's blocks. This is
> >something that ATM isn't done by any filesystem, but it really should.
> >
> >Obviously this whole idea is thwarted if we keep writable shared file folios
> >PMD-mapped - you can't get meaningful write notifications apart from "someone
> >wrote to this folio", which isn't particularly useful once folios get 2M+ large.
> >So PMD-mapping on a shared-write fault is antithetical to getting useful,
> >granular write notifications to filesystems.
> 
> Just checking I got it right ... for a PMD-order file folio:
> 
> read-only mapping  -> PMD-mapped
> writable mapping   -> PTE-mapped
> 
> Then ->page_mkwrite() could dirty only blocks corresponding to faulting
> PTE, avoiding whole-folio write amplification.

Yes. To be clear, when I said "mapping" I meant "page table (PTE/PMD) entry".
So something like an mmap(PROT_WRITE, MAP_SHARED) could have PMD-mapped folios,
until you actually wrote to them (otherwise they're wp'd and huge-PMD-mapped).

-- 
Pedro

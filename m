Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705893;
	b=ZA0AZsq5NUzi+8eejbo7jjAcucQ/9HzTWMpuejBcFdxCnwgMbHBiOs+U0QrsDsXlGqco
	 rooJoOsJr81Su2IzhbK754oZMrvjNsTMWBYNntX0GolVhDdcvlb7cVUdyGpJyaskJ4KKd
	 wV6raF0KwVfPwagXncn5valV46eWpR6h8FyBK2WkSan3Q9mtYbyYbm76SmpEWrh8JK4wC
	 Jao2B4FSZYQQUN3IZr8+ld6ilr3IbwktJRsu+A0AyP8xPu5WswOomu0eZBhhvNx7S67Ig
	 JxhCjJ/v8ZA6n4B7MZNeCrDWbEcO6+GmvdA5Jae4EiCzvgug4lH8e9MVIHLQZmwm37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705893;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=pCnYm9/ITbnI5evM1y8CyeToRvjgbq+ddnA4xUblF4s=;
	b=TM4QiDt0MDkbP7bPVTLE7SM0cz54IPh7JVqd9AJVvXrjwUrJjutlvLfKTs55i18cJkgP
	 qtdyb7kfdg8/1SVMMVWbwNJCYjLcGhY2IW045xAUYmj/bS1eicEgcUbbGbsrCyZf5S34f
	 sS1i0SMg5ppD9g4b0taypSCiL7D3ZpC3pfSKhvFyDQOWxi3WpQqsHpq8rKjKioE58mcWq
	 qUwvVPbMk5YbNdlzHln1YNqJ7olY1G+sOAftMl38wDqqQtW+8pxXlJyqyMc5G38KUs+E1
	 /4BvLISo7/AtITIiyMFS1L83Xm20SKUFoPjxJdgdX9+NuovfRkFgrEoBgysoTErFBng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="d7+X/pS0";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ASgtdplE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="d7+X/pS0";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ASgtdplE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333616085084;
	Tue,  3 Nov 2026 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 333616085084
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=d7+X/pS0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ASgtdplE;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=d7+X/pS0;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ASgtdplE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F5C3228F4;
	Tue,  3 Nov 2026 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793705891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCnYm9/ITbnI5evM1y8CyeToRvjgbq+ddnA4xUblF4s=;
	b=d7+X/pS0CC9M+uSAVvmhRjU68AW0lbWddSwJL2mxwIdzVkHOuuMhONLRy1ZTqe2Xwjqz9a
	As2MreadASrACnGsRvr0TP4vjdXpjcwjHCrzKf2m27LlEXVatRjxvOCyujOFsDNa+dmP+s
	BVdfTmcGIjZfCjaVIK/JfT929mNoKVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793705891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCnYm9/ITbnI5evM1y8CyeToRvjgbq+ddnA4xUblF4s=;
	b=ASgtdplEe74VqtPmNh2CaiNyAur8jpniosj0dgN2wrjhFXtxd6hEtZd68jRvDNcPGL9peR
	sf1CZbbLpIIqcGDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793705891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCnYm9/ITbnI5evM1y8CyeToRvjgbq+ddnA4xUblF4s=;
	b=d7+X/pS0CC9M+uSAVvmhRjU68AW0lbWddSwJL2mxwIdzVkHOuuMhONLRy1ZTqe2Xwjqz9a
	As2MreadASrACnGsRvr0TP4vjdXpjcwjHCrzKf2m27LlEXVatRjxvOCyujOFsDNa+dmP+s
	BVdfTmcGIjZfCjaVIK/JfT929mNoKVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793705891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCnYm9/ITbnI5evM1y8CyeToRvjgbq+ddnA4xUblF4s=;
	b=ASgtdplEe74VqtPmNh2CaiNyAur8jpniosj0dgN2wrjhFXtxd6hEtZd68jRvDNcPGL9peR
	sf1CZbbLpIIqcGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E37E134B8;
	Tue,  3 Nov 2026 11:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVzeDKPH6Wp+TAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 11:38:11 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E7C47B233; Tue, 03 Nov 2026 12:38:06 +0100 (CET)
Date: Tue, 3 Nov 2026 12:38:06 +0100
From: Jan Kara <jack@suse.cz>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Hungyu Lin <dennylin0707@gmail.com>, 
	willy@infradead.org, hughd@google.com, baolin.wang@linux.alibaba.com, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
Message-ID: <vsuiiidzwh7x2ipjgurdygwebkib6yiisdbucjg5o5eb3wokqk@a2cjfenlo3nx>
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation>
 <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation>
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
In-Reply-To: <at-XtWBQg3jv3H8Z@thinkstation>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,infradead.org,google.com,linux.alibaba.com,linux-foundation.org,linux.intel.com,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 26-10-26 18:18:39, Kiryl Shutsemau wrote:
> On Mon, Oct 26, 2026 at 04:48:58PM +0100, Jan Kara wrote:
> > On Mon 26-10-26 15:34:08, Kiryl Shutsemau wrote:
> > > On Sun, Oct 25, 2026 at 04:46:19PM +0000, Hungyu Lin wrote:
> > > > shmem_write_end() advances i_size to pos + copied even when copied is
> > > > zero. A buffered write past EOF can therefore extend a tmpfs file
> > > > without writing any data.
> > > 
> > > + willy, jack, fsdevel.
> > > 
> > > This doesn't seem to be tmpfs-specific, right? I see the same with ext4.
> > > 
> > > simple_write_end() and generic_write_end() check pos + copied the same
> > > way, so filesystems that use them through generic_perform_write() are
> > > affected too.
> > > 
> > > It makes me think maybe generic_perform_write() is the right place to
> > > fix it. Hm?
> > 
> > Well, that would be nice. But how'd you like to do that? i_size update is
> > the responsibility of ->write_end and we have to call ->write_end if copied
> > == 0 so that is undoes what ->write_begin has prepared.
> 
> Hm.
> 
> A zero-length copy only moves i_size if the write starts beyond EOF.
> So we can bring the prefault back just for that case, before
> ->write_begin():
> 
>         if (unlikely(pos > i_size_read(mapping->host)) &&
>             fault_in_iov_iter_readable(i, bytes) == bytes) {
>                 status = -EFAULT;
>                 break;
>         }
> 
> Overwrites and appends keep skipping the prefault. It is racy against
> a concurrent munmap(), as it was before 665575cff098, but that is
> userspace racing with itself.
> 
> The per-filesystem alternative is a 'copied &&' in every ->write_end.
> 
> And generic_write_end() cannot take it as is: generic_cont_expand_simple()
> relies on a zero-length ->write_end() extending i_size. So we need some
> replacement.

Yeah, I actually like this. Good idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

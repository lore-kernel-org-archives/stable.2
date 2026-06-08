Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53634D3B9
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914133; cv=none; b=VVmJI5QuzBYVGsnYLXM6kSJl584m5LYPpHK6Q8WDKmePCOTY0Ix+yA9MMfTiGGS15Y079hfWsiIQf33vwZdk1FZnZ0m1pMzMKre2JrUJoD6wNpQUEq1Kzktw41G6/pb+jALjLMLGPB0DDpjXNgFhv/1wxfVSv95e0nP0CPGF/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914133; c=relaxed/simple;
	bh=W6OSEUBRa4vBKaxrxsf5ZA9G54yux7IGEJULOD2G/LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGsod7F9vBLfR3Ruq24/jyeRePAMmej9uBds+/4Dt7Gibxs2d02tKlJrwOhCiGu795zh+FpT+XQjTDeBLx5FKVygwaguKgF4/LhvQbDAoyiWTeuoRxaBQ5B8fTIJ95c4+D2yv2VsWMpSUFNahURgVwwvO7d+cfvqXfpVl/vOZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oLRNX+Gh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ocbJ2jvv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3KqMEol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7uPSINyj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oLRNX+Gh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ocbJ2jvv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3KqMEol";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7uPSINyj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A75A967645;
	Mon,  8 Jun 2026 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780914130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=oLRNX+GhiibyIthOpZtMczxn6oMFgJVsuw1aJzxVyyLuggOh5u4hDVs4IXac40mdp/+Dkb
	Mm5lCEi25pnpeI+SLwPmMoMIeg+XjSqOrrVXcH4wPgG7WjpSbELH1aCmeac1R7Nzaq+B43
	itkX7yKaEEJb0rFfQZ0QhCE9yQmW6Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780914130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=ocbJ2jvvbMmWg5r4rw8VmtKWB9xoE+Rb9pnlZCeoInX8phABYkhue+8vN2gEYQixWYgk6N
	tUEsTvb/LNWjZ2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r3KqMEol;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7uPSINyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780914128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=r3KqMEol5Xo6CPbuZ4EGVbA5rkXX8DPdVFgEyshvQ/z3m/MA7VUv7PB/CooolFE6kGKgyV
	W46UarxzksmPbte0udOVFyiY8BHqqXM4nG+W4B2KkSuijIH06fN2QWU7r8jorS8qkv5EVB
	rm+nrKccyAKmgFJAufRJZ1znoJj7umw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780914128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWDUv+68Hd6ObGOJCq79VE9pZhdRCS4O0EV/ATF4WKA=;
	b=7uPSINyj5sF1yyEZSPb0vtKpnWkfra2CW+SMyoKz1SrNjH5+U+EyggwlL+qz11+7WQp50y
	PJ7qqFuTQJHrh6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E95F779A7;
	Mon,  8 Jun 2026 10:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /K61JtCXJmpwPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 10:22:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 449E0A10CB; Mon, 08 Jun 2026 12:22:08 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:22:08 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <vcdwfq5pysuuvj3lnlmsndvwnt643liz22w33ayv2cf2jawetm@7re2y25e6lv7>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
 <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
 <20260602140751.GS2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140751.GS2636677@ZenIV>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,swemel.ru:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.org.uk:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A75A967645
X-Spam-Score: -4.01

On Tue 02-06-26 15:07:51, Al Viro wrote:
> On Tue, Jun 02, 2026 at 11:11:11AM +0200, Jan Kara wrote:
> > On Tue 02-06-26 03:04:44, Al Viro wrote:
> > > one should *not* be allowed to mount one of those, new API or not.
> > > 
> > > Reported-by: Denis Arefev <arefev@swemel.ru>
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Won't it make sense to actually check fc->sb_flags before we call
> > vfs_create_mount()? Otherwise it looks good to me.
> 
> Interpretation of fc->sb_flags is up to your ->get_tree().  What matters
> is ->s_flags in the resulting superblock; that's type-independent and
> that's what we ought to check...

Ah, right. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DC30FF1D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119351; cv=none; b=rRZbzRsUxauMjVU+xhFNryvMtQJFiwtPK8S0dJu4Z6/5nfdtBH5N9QHcGVg8a/51yXchvyePCJkn9CjGZ54D23XvyiWYdjqeUsFt2aPxtbJNBq6oCDH6o/GPejpb9tRwHjizGIdk5aKiD6cUWzNXK0jNRNdqeP+btkvjyj5J18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119351; c=relaxed/simple;
	bh=5ilCdKcqCwxjYRqo4FSYfH9Cm2vVzU9QtahGdbQcnhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFtoP0qwIQLS41V//aSW6KtVkvWMFbv3FAo1ZOWAMwl1bnuluhQ8fxZuGEz+G9TP4qQc73OFesgyCDy6hQubQ++OJqhB7G4PFRihN8oZg3Lr503nHJTCLbPQzbrZHgrSOMP6ou7eq7JF5EO3zbEyWu93jpN4YIaNMCqUSzL4Ms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIGNt+l8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZKVNvNPz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgEvyuQI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gifg9d9E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIGNt+l8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZKVNvNPz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgEvyuQI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gifg9d9E"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B28B321D2B;
	Fri, 11 Sep 2026 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789119334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE8iaWly/EkLPx8G/L2Hp0WSTnhziRsEW8T9oadhB7o=;
	b=xIGNt+l8jOYVNSIX7ujdNAJ1iW2XTiRGd9o0QOutyKQFtqYhlRk8Ln6Zj8M85EdjaqMVkM
	mxmUNjlFVY8/WrxpH1v+mdxlpH+I3xAf6zN5j0lQr5Yi0OGpLfwHTTji11TmtJG9bv0XYf
	Voqt5G5GoUCkxlvbZ2UwLBWZZM19URg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789119334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE8iaWly/EkLPx8G/L2Hp0WSTnhziRsEW8T9oadhB7o=;
	b=ZKVNvNPz5qWa4w8sVHqBKpx6WsNPpKs08O41aAs5ed0wVyPAo7RrDbUamJvJ0hv01si4ud
	JUF1OHVk4WrvXVCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qgEvyuQI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gifg9d9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789119330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE8iaWly/EkLPx8G/L2Hp0WSTnhziRsEW8T9oadhB7o=;
	b=qgEvyuQItOS7u/bdUozwj1bNWb7OG5ekxdo4V4NPGbk5ruGgWMhGs/5TAqICwjcs+lMFEb
	V2DxeCmtmFN3wCSzHFlVp1rgL3MPBsJ3O06awTZC/HWqRIXk776qRYc19f3Ydl574sfnbZ
	1duejhtKAT1YEj+V12QKZhFQL/7J/HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789119330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wE8iaWly/EkLPx8G/L2Hp0WSTnhziRsEW8T9oadhB7o=;
	b=gifg9d9Ea0zwtw+0PzXVfC8+1NX8ADLaPtx9Iss8SqiAbPxBOBdspM/7hXlho1yrmj+QI9
	skypO+UFmhJCd+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89305136ED;
	Fri, 11 Sep 2026 09:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jEl4IWLLo2pPSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 09:35:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A278A1342; Fri, 11 Sep 2026 11:35:30 +0200 (CEST)
Date: Fri, 11 Sep 2026 11:35:30 +0200
From: Jan Kara <jack@suse.cz>
To: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Tejun Heo <tj@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: bound cleanup_offline_cgwb() rescans by
 rotating b_attached
Message-ID: <5onojwm73shl2c3ddwboijarrefjw4gmkfcvnwdvow2wybhu5u@wu37jhkboemj>
References: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>
 <vciagp74qvys2zdbsfcr2brhbv4uyabvm67czm255ascytesjz@n6q775zxxwvb>
 <3ebd03824f0df04947ffca7f25c96c30.perf.patrick.lu@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebd03824f0df04947ffca7f25c96c30.perf.patrick.lu@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B28B321D2B
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Thu 10-09-26 23:47:44, Patrick Lu (Anthropic) wrote:
> On Thu, Sep 10, 2026 at 01:24:52PM +0200, Jan Kara wrote:
> > On Wed 09-09-26 18:50:27, Patrick Lu (Anthropic) wrote:
> > > Move every scanned inode to the tail of b_attached, so the next pass
> > > starts where the previous one stopped and the drain becomes linear.
> > > b_attached is unordered and isw_prepare_wbs_switch() is its only
> > > walker, so nobody else sees the reorder. b_dirty_time is ordered by
> > > expiry for move_expired_inodes() and keeps its current scan.
> >
> > OK, but isn't there the very same quadratic behavior problem with
> > b_dirty_time scan which you don't touch (and where your trick cannot work)?
> 
> Yes, the same thing happens there. We never saw it because none of our
> filesystems are mounted with lazytime, so b_dirty_time was always empty
> on the hosts we looked at.
> 
> We realized the rotation works for b_dirty_time too if the walk starts
> from the oldest end instead of the newest. sync takes the whole list no
> matter the order, and move_expired_inodes() picks from the oldest end,
> so walking with list_for_each_entry_safe_reverse() and moving scanned
> inodes to the newest end keeps the oldest unscanned inode right where
> the expiry looks. Prepared inodes leave the list as soon as the switch
> work runs and get a new dirtied_time_when on the new wb anyway
> (9a6ebbdbd412), so the only inodes left out of order are the ones that
> can never switch (DAX), and only on the dying wb.
> 
> I tried it in qemu with 100k lazytime inodes on a dying cgwb. With v1
> the b_dirty_time scan under list_lock still grows from 11 to 115 ms per
> pass across the drain, same as unpatched. Walking both lists from the
> oldest end keeps b_attached and b_dirty_time flat at ~0.6 ms per pass,
> with one loop and no flag. Does that make sense? Something like this,
> which I can send as v2:

Yes, I was also thinking that since we are going to clobber
dirtied_time_when anyway, we can as well do it a bit earlier to ease
iteration.

I can see in your patch you don't touch dirtied_time_when at all which will
make the b_dirtied_time list not ordered by the timestamps. That makes me a
bit uneasy but since we are going to move everything out from that list
eventually I think that is fine.

								Honza


> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e744f9f9d43f..ea3eb40bf828 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -727,19 +727,34 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
>  				   struct inode_switch_wbs_context *isw,
>  				   struct list_head *list, int *nr)
>  {
> -	struct inode *inode;
> +	struct inode *inode, *tmp;
> +	LIST_HEAD(scanned);
> +	bool full = false;
> +
> +	/*
> +	 * Walk from the oldest end and move scanned inodes to the newest
> +	 * end, so the next scan resumes at unscanned inodes instead of
> +	 * re-walking an ever-growing run of prepared and skipped ones.
> +	 * For b_dirty_time this keeps the oldest unscanned inode at the
> +	 * end move_expired_inodes() picks from; b_attached is unordered.
> +	 */
> +	list_for_each_entry_safe_reverse(inode, tmp, list, i_io_list) {
> +		list_move(&inode->i_io_list, &scanned);
>  
> -	list_for_each_entry(inode, list, i_io_list) {
>  		if (!inode_prepare_wbs_switch(inode, new_wb))
>  			continue;
>  
>  		isw->inodes[*nr] = inode;
>  		(*nr)++;
>  
> -		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
> -			return true;
> +		if (*nr >= WB_MAX_INODES_PER_ISW - 1) {
> +			full = true;
> +			break;
> +		}
>  	}
> -	return false;
> +	list_splice(&scanned, list);
> +
> +	return full;
>  }
>  
>  /**
> 
> Thanks,
> Patrick
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

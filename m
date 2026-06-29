Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCF38837E
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757852; cv=none; b=X7ivfNb55JfTgqzHOupqzqpA/GDMlrorLtVXN/ZGcdu2k3Q8Kvjy7Jr23975SRnFKQZrT5RBOf4QZv9t632ykiu66fiGqfMPQhhn7YjLj5e5QkacFhARmHSBs3TIPgAsW9BSZO2r6M2xTp0BBzzSzV+tiJOWQy5AxQ6VfKO1G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757852; c=relaxed/simple;
	bh=NSyl7BT1TjFj5gSTLMOULowrGNab8nMNFh4Un9s5lk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg5ewWbdxAYyW6o3t6ZSa26IZU2Y51C3AMrUBvZ61E0VMjuy983223qGMTt3wMw3ngFSdL34ZFSR/rHBAT8U08as3ZpmhjEHE8WtyKOBtqr1OKQMBIQ73nFcgPxNY10jdMvLUeJVs3Drx1slkhbraqCH9F1FVUE0OmuMWHgHjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZSKW5IWI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XiK/ozan; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Ip6Kwgp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EeYyMfbh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZSKW5IWI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XiK/ozan";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Ip6Kwgp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EeYyMfbh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5DC73213;
	Mon, 29 Jun 2026 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782757847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4unOw1kC7PDoCyOC3Zep6sOEjf/lsnW9nQUlS74aFs=;
	b=ZSKW5IWIhLmI75H5Ru137+UQ9cwp0wZYNWh0wLLIwO5UeUdvIAf2J7wD49hRckfFtQs5te
	KCzC0YssaeSjr9FGF/D0OVQ2YRkDRna7X85nfuOKVE/gp+B0yhLSpINVrqY3eRm3M7t9q+
	m/I00eAYwiTNDvSUCNHwMzn1k11kjAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782757847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4unOw1kC7PDoCyOC3Zep6sOEjf/lsnW9nQUlS74aFs=;
	b=XiK/ozan+2lMDL5Detpi57el9beS/jZlYoacw9yUkD5LGELLMmDbFuIPMzf6NDHVdguh8N
	ri9mJsShahj+JlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782757846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4unOw1kC7PDoCyOC3Zep6sOEjf/lsnW9nQUlS74aFs=;
	b=0Ip6KwgpFhy8F4Ou3+lH/mzi+xCwIOYpRGCQ3A3XNcrAfHKigDU/sszYi08H5tg4Xv6+1R
	xdZV1ik8foXtGbd1KHMUkOLd9PFKWatLgTqBU/lEqi7pgcAv4zo/Ll41gcTaMmwmOWKLxP
	wJEC8RthywEFKzfWtAYS9zFXCNRqa/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782757846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4unOw1kC7PDoCyOC3Zep6sOEjf/lsnW9nQUlS74aFs=;
	b=EeYyMfbhRr8oQQjM/Igb3SEFQJcXtgZp4ynHWIVDTLcZcStgOopApUqSajIw8RiD8N7NHY
	ZiPQqv8eCeLo1ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D138779A8;
	Mon, 29 Jun 2026 18:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIrYHtW5Qmr0dwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 29 Jun 2026 18:30:45 +0000
Date: Mon, 29 Jun 2026 19:30:43 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount idmap
Message-ID: <akK4CRgiv9G29UiM@pedro-suse.lan>
References: <20260625153853.913949-1-pfalcato@suse.de>
 <s6mr3j7gew2cgerzrvqzenjctctrtnhvlynmcccxb24uszcauz@5iapd6wnbfxg>
 <20260629-sektor-gaben-gepokert-58db0a3528a3@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-sektor-gaben-gepokert-58db0a3528a3@brauner>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, Jun 29, 2026 at 02:15:19PM +0200, Christian Brauner wrote:
> On 2026-06-26 16:19:18+02:00, Jan Kara wrote:
> > On Thu 25-06-26 16:38:53, Pedro Falcato wrote:
> > 
> > > Ever since idmapped mounts were introduced, inode ownership checks
> > > (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> > > done against the nop_mnt_idmap, which completely ignores the file's mount's
> > > idmap. This results in odd edgecases like:
> > > 
> > > 1) mount/bind-mount with an idmap userA:userB:1
> > > 2) userB runs an owner_or_capable() check on file that is owned by userA
> > > on-disk/in-memory, but owned by userB after idmap translation
> > > 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> > > 
> > > In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> > > file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> > > idmap internally, but it does not need to be the case on e.g a 0444 file
> > > where even the owner itself doesn't have permissions to write to it.
> > > 
> > > Since this is clearly not trivial to get right, introduce a
> > > file_owner_or_capable() that can carry the correct semantics, and switch
> > > the various users in mm to it.
> > > 
> > > The issue was found by manual code inspection & an off-list discussion with
> > > Jan Kara.
> > > 
> > > Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > 
> > This looks good to me. I'm a bit curious why Christian initially (in 2021)
> > used init_user_ns here instead of the file namespace... Anyway feel free to
> > add:
> 
> Back when this was added only the do_mincore() codepath existed and that
> was intentionally left unconverted because it exposes the cache
> residency status. So it was effectively a massive side-channel.

Hmm. I'm not sure what you mean by this. Wouldn't it be more correct to respect
the mount idmap (given that a mount-ns-capable user mounted it with an idmap for
someone else, or itself) for mincore? Am I missing something? Or maybe I'm
misunderstanding that paragraph.

> 
> Both fd3b1bc3c86e ("mm/madvise: fix madvise_pageout for private file mappings")
> and specifically cachestat() came way after all that.
> 
> I'm otherwise fine with the change.
> 
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org> 

Thanks!

-- 
Pedro

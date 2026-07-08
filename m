Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2140927B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528176; cv=none; b=YhXYwvdayFIHLpeFukMb/yqv/gYwTHLtU5XxiU+dTIfnFnZNazT0t7zf3Erbg5pd1rgQpe95uWM6RORKovV8csRpRRW1d4D6FQHWIHFAISnsqHb1FEYV16rcIpDz9V3Gl80mbGsSa5Ir/sfI81LbWvOQksOm5lAJuOdnNeo4nL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528176; c=relaxed/simple;
	bh=3lSdyCLeUGu19piqkuUHLgWw74UGkM3eShfZ48QoXxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ5I/vISHGuqS9dYR2fyNbKQnI78V3+zBlj9+WIO1W+wZOBQidJMIXqaLhlVJBEvdlIqPZQ7kuMv2tuQ6tXlUohVDbUiVCVEtI+7fnSPT4mmAmStDbRyNDRR5UqwYyVbFsg5LXhIizI2RWKuQYXCGiSoA2zIKVF/9YNJnSvHAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaOYvba+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMvQUPMc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaOYvba+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMvQUPMc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaOYvba+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YMvQUPMc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaOYvba+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YMvQUPMc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9207C75E8A;
	Wed,  8 Jul 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=EaOYvba+ARiTsxtWUrYDBPR91BTRtXJsdTCLw0wNxhImLHwujj3dJv3h6cCGHlzp977dwE
	dIFixPE0pstyi4E9xED3cWLPtkgkfPJlBRlLF7KoOoeIks09dRwL71VB5xwNHvOu19Ks7M
	f6YOoObWR6FseQ6/IWOt8xy1k9VtSCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=YMvQUPMc+wnAmpwZbJQ/e5jUHFTTPHF8iv6B8qO+/rMFuQCGHrdiC6JQ6JXIlbiMj+vuvf
	ZWYh9doHo6nNVsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=EaOYvba+ARiTsxtWUrYDBPR91BTRtXJsdTCLw0wNxhImLHwujj3dJv3h6cCGHlzp977dwE
	dIFixPE0pstyi4E9xED3cWLPtkgkfPJlBRlLF7KoOoeIks09dRwL71VB5xwNHvOu19Ks7M
	f6YOoObWR6FseQ6/IWOt8xy1k9VtSCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=YMvQUPMc+wnAmpwZbJQ/e5jUHFTTPHF8iv6B8qO+/rMFuQCGHrdiC6JQ6JXIlbiMj+vuvf
	ZWYh9doHo6nNVsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B315779AE;
	Wed,  8 Jul 2026 16:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r222Hux6TmpHdwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 16:29:32 +0000
Date: Wed, 8 Jul 2026 17:29:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios
 when collapsing
Message-ID: <ak56uatKoDR-TAIn@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de>
 <ak5tKPfX99kdkhIG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5tKPfX99kdkhIG@casper.infradead.org>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,pedro-suse.lan:mid,suse.cz:email,janestreet.com:email,nvidia.com:email,linux.dev:email,suse.de:email,linux.org.uk:email]
X-Spam-Level: 
X-Spam-Score: -4.30

On Wed, Jul 08, 2026 at 04:30:48PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 08, 2026 at 04:13:57PM +0100, Pedro Falcato wrote:
> > [There is no upstream commit, as this code was removed by upstream
> >  commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> > Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> > Tested-by: Zi Yan <ziy@nvidia.com>
> > Tested-by: Lance Yang <lance.yang@linux.dev>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

-- 
Pedro

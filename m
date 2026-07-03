Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE203B0ACC
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070399; cv=none; b=iFZqjfOVrXQlp3ASLIUr0fcuUI4/c6qWCvxqs1NBW2zn3I94ja0KJ0VJ3iUl9LKU5y83X5CaXsNStUoGfC5wu3y4yvuthuTYP1szS8fBoLXPNKPFGcvM0XxSku0FQzJOYEXiE/nb5aXSpRdwZmQ43csh2HhhQjUIr53EbxafvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070399; c=relaxed/simple;
	bh=sN0p0fVJ9sdmJILLH4DH6tZhh9cD37hVqESMMYX2k+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+g5REVmBrTC05rcYNxw5D8u6nkYkKhVVUDIxuQ+sRH5g8M6Dcc3hlXGd50WxwKQZgM5zmsMdJjlb/t5kHd9phPZq9ctYwn6/TEILX9gvGwEkqdIjGpNkhpbFQehyAA0R9jlPTvnF6Bmy978A07yOgwIR8C+VAB4vNtrS27/qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J6S8Rvou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rHkIOYoy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PLBvQUmM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RyJc3dXV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J6S8Rvou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rHkIOYoy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PLBvQUmM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RyJc3dXV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE60174832;
	Fri,  3 Jul 2026 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLNoIPFQAdzqlhhDjJljgWkTgIt0PBr/oUCSVxs3Zuo=;
	b=J6S8Rvoua0dSJHxLdFrxFJWZM8hR6dSknFKcAwZHXB2IzZyj3aKXaoeMiZImqHX0DLmZm+
	svYGrDovejHKJHqoHsqiatns8PXCi1T2wm9E6ZSQKQfKJJlcZDdQ+XVEykUQ9WTdrC3F4z
	2q5V3AlISPlFskR4kIAjwVNNHfiwRKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLNoIPFQAdzqlhhDjJljgWkTgIt0PBr/oUCSVxs3Zuo=;
	b=rHkIOYoy9oK2iBGSJenoueb7UarA4ICEW/qNf+dddBdOFfNk9eYrbA4mTgAai/ENT1rVJ8
	SSI+FU1bE8I7+xAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PLBvQUmM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RyJc3dXV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLNoIPFQAdzqlhhDjJljgWkTgIt0PBr/oUCSVxs3Zuo=;
	b=PLBvQUmMD5Np4IuyjLfdm9G8FzjBbaRQ3WyoW2tloAnkCBzSks74z10u+r7rmcaVwG/ju6
	qwO4dgFbp+5RVJRJzDIe+5JjswhzV58TNnYXy+ZT9ASqBrPqSV2Z1khQE5ottap5weozQ2
	dGhYPdi1qv0IkaJMgcj7870POHcX+CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLNoIPFQAdzqlhhDjJljgWkTgIt0PBr/oUCSVxs3Zuo=;
	b=RyJc3dXVK/dYw+3iTJXMb3qEaBCULjbrWuBFuwA4FABcfAsT/HSJlGN8Q4clstduNeiUBT
	eArI1L2wvWMx99AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA3EC779AA;
	Fri,  3 Jul 2026 09:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBbKNbh+R2qHaAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 03 Jul 2026 09:19:52 +0000
Date: Fri, 3 Jul 2026 10:19:51 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <akd-fJf7i8E9FuSA@pedro-suse.lan>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <2DA84662-F9E4-4ED3-A225-71054FEC3849@nvidia.com>
 <d38263c7-b1ea-4709-8d75-2f2355ca38a6@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38263c7-b1ea-4709-8d75-2f2355ca38a6@linux.dev>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,pedro-suse.lan:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.org.uk:email,infradead.org:email,janestreet.com:email,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EE60174832
X-Spam-Score: -4.51

On Fri, Jul 03, 2026 at 10:53:24AM +0800, Lance Yang wrote:
> 
> 
> On 2026/7/3 01:24, Zi Yan wrote:
> > On 2 Jul 2026, at 12:54, Pedro Falcato wrote:
> > 
> > > As-is, khugepaged and writable-file opening exclude each other. A file
> > > cannot be open writeable and have THPs (because the filesystem is not aware
> > > of them). khugepaged will never collapse file pages for files that are
> > > opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
> > > particular file is dropped. This is fine because nothing could've been
> > > dirtied.
> > > 
> > > However, there is an edge-case: collapse_file() might not be able to
> > > coexist with concurrent writers, but it can coexist with dirty folios
> > > (from previous writers). Therefore, the following can happen:
> > > 
> > > open(file, O_RDWR)
> > > write(file)
> > > close(file)
> > > madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
> > > open(file, O_RDWR)
> > >   nr_thps > 0
> > >    truncate_inode_pages()
> > >      /* THPs are cleared out, but so are the dirty folios */
> > > 
> > > When this edge-case happens, there is data loss, as the dirty folios are
> > > fully discarded.
> > > 
> > > Fix it by fully writing back the page cache (and waiting) when collapsing
> > > file THPs. Doing so provides the guarantee that no dirty folio will be
> > > observed while there are active THPs. To fully ensure this is safe, the
> > > invalidate_lock needs to be held while doing the writeout, so that
> > > do_dentry_open()'s page cache truncation excludes this write-and-wait.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > > Cc: Zi Yan <ziy@nvidia.com>
> > > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > > Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> > > Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> > > Tested-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > ---
> > > This patch is written against 7.1.0 (because the code no longer exists in mainline).
> > > 
> > > Zi, I kept your Tested-by, but I had to move some things around and
> > > use the invalidate lock. Please re-test if you can.
> > 
> > Tested it again on top of v6.12 (the patch applied cleanly) and the issue
> > is gone. My Tested-by still holds. :)

Awesome, thanks Zi!

> 
> Since READ_ONLY_THP_FOR_FS is gone from mainline, just to confirm: does this
> only affect stable kernels, right?

Correct, current mainline doesn't play any sort of fun games with
truncation and the code is fully gone from do_dentry_open().

-- 
Pedro

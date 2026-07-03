Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBC3ACEF4
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070328; cv=none; b=huZtMXhtW8KiLcIornzOmSSWQ8y4GbFgVFHnEpSjdGOpu2OSHBpErJFOFEvNn+nNVBreuxVUo71QA0pslsIJGxe01ZxYfp4ZltZ0wgJb1dVZZQXPEqPcJTWdlgmxDZqjOO5dpNqfjSoKMni/GNWjeFROUB6M/CjyrGI+71+AooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070328; c=relaxed/simple;
	bh=6CzEP/hNMyfP/gKnu27c93iiMue+zfU9UTtyAJFQSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Vt+X4r2e93ZOtFPfR1unqFKAiANjhBluQfEIDE1V5evgZhHsjx4IIGnKR4+muxu55jApsxZyWY0567aJM/dxjDZ+0vGJij1xRZ55qnn/o/HdXdBgWqS3lVZ6ZCIdTwm1tPOkgUYvxvmidnMKP98k73Q//2SmQ5omUgXx2pbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qb76ikLE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGa0EAed; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QWGAH9lR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QqUHHJtx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qb76ikLE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGa0EAed";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QWGAH9lR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QqUHHJtx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5DCB7625A;
	Fri,  3 Jul 2026 09:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzPJrNMcqTLpcp6mF9jhE1bhSF4vVcM/ftLefCKQ9eo=;
	b=qb76ikLEvqc3965sTpHJZO3sdpd4AyY57BYuqKXKXurFsKZPZK4Dg0j3BuASvlXlwJZLzn
	N9pLXv9zs0n5vXEriq+UaAidCqAOzf2ehEXy+n+a9Am3nVf+7Az5z3yCSqQvqdk8AkjF8T
	jgc3npNOGTNtUQI+lHy3fYFBb1y0FZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzPJrNMcqTLpcp6mF9jhE1bhSF4vVcM/ftLefCKQ9eo=;
	b=hGa0EAedPGAIzohKnJucRQILO3/u4YVpAowe0eHC9aoiir72jLtahShO6kwVk6rNFEE4qb
	f6FbUW4dolJISTAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzPJrNMcqTLpcp6mF9jhE1bhSF4vVcM/ftLefCKQ9eo=;
	b=QWGAH9lRHpPzkfOVW9AHuIhlVfRMqmNZReZBplENOQbkpzCJGlH35wi8Vsn0+LS3PG6Hpv
	Dq5/xhonRm40UXLpLnHo+XKUALa6VijGinSGk33f+E6dRV4ohuVnd4oWhZ5HDQP0W6Gx9L
	OzxVcyTflrDA/htL38dlqKUsea+8PZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzPJrNMcqTLpcp6mF9jhE1bhSF4vVcM/ftLefCKQ9eo=;
	b=QqUHHJtxaTqZTU0NxrvSRd6PeYBkXjJaeg68tt3kVvBxOAtBydcb25TZc7jC8MA659FXKi
	AtZ6w5hF4IUKjVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45171779AA;
	Fri,  3 Jul 2026 09:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p0aMDXJ+R2pBZwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 03 Jul 2026 09:18:42 +0000
Date: Fri, 3 Jul 2026 10:18:40 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, willy@infradead.org, 
	song@kernel.org, ehagberg@janestreet.com, ziy@nvidia.com, 
	gleventhal@janestreet.com
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <akd-WGXQbSQtgGCo@pedro-suse.lan>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <20260703051129.88453-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703051129.88453-1-lance.yang@linux.dev>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL8d8xedm6iu8o66torxsk6bwd)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,nvidia.com:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email,linux.org.uk:email,janestreet.com:email,suse.cz:email,suse.de:email,pedro-suse.lan:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

On Fri, Jul 03, 2026 at 01:11:29PM +0800, Lance Yang wrote:
> 
> On Thu, Jul 02, 2026 at 05:54:09PM +0100, Pedro Falcato wrote:
> >As-is, khugepaged and writable-file opening exclude each other. A file
> >cannot be open writeable and have THPs (because the filesystem is not aware
> >of them). khugepaged will never collapse file pages for files that are
> >opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
> >particular file is dropped. This is fine because nothing could've been
> >dirtied.
> >
> >However, there is an edge-case: collapse_file() might not be able to
> >coexist with concurrent writers, but it can coexist with dirty folios
> >(from previous writers). Therefore, the following can happen:
> >
> >open(file, O_RDWR)
> >write(file)
> >close(file)
> >madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
> >open(file, O_RDWR)
> > nr_thps > 0
> >  truncate_inode_pages()
> >    /* THPs are cleared out, but so are the dirty folios */
> >
> >When this edge-case happens, there is data loss, as the dirty folios are
> >fully discarded.
> 
> Well spotted, thanks!

Well, Gregg deserves a lot of the credit :)

> 
> >
> >Fix it by fully writing back the page cache (and waiting) when collapsing
> >file THPs. Doing so provides the guarantee that no dirty folio will be
> >observed while there are active THPs. To fully ensure this is safe, the
> >invalidate_lock needs to be held while doing the writeout, so that
> >do_dentry_open()'s page cache truncation excludes this write-and-wait.
> >
> >Cc: stable@vger.kernel.org
> >Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> >Cc: Christian Brauner <brauner@kernel.org>
> >Cc: Jan Kara <jack@suse.cz>
> >Cc: Matthew Wilcox <willy@infradead.org>
> >Cc: Song Liu <song@kernel.org>
> >Cc: Eric Hagberg <ehagberg@janestreet.com>
> >Cc: Zi Yan <ziy@nvidia.com>
> >Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> >Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> >Tested-by: Zi Yan <ziy@nvidia.com>
> >Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >---
> 
> Tested on v7.1.2. I no longer see the data loss with this patch applied.
> 
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks!

-- 
Pedro

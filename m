Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492068;
	b=3v5QZ3cKZlAbjQ2sF+pNBrNp0iQqa+E9Qe+7s0lia6IfYmHEh1NAHUKPW5NvanpHGnjr
	 NSc/MaBb3fNs+7j9pfgDc32/D2DWOVxgu6VGcVl1a/QXbZtQqscC56obN32avhh8GQxv7
	 r5infZ9oTbwg7XfXfXfATVMTdIXXpXmVHRyrLCArC1z0PICOTpvzLKN0pMxbflEohaO8C
	 6pYHZAqg0StQp2AMB49UjrI7Znu80b6OrmpLy0lkC3K7dhNMk4P0NXPCjSiFrtzE9bxFs
	 YqwYXJgkD/93BPoErwk47qV8g8GxThiiwGwfL5HFhMWjbLbLfT51kRMyQIXtlLAC7gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492068;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=WTNMIFQg7vEsr/bVsx6max9Hp2mlrFDIwp0Z0arBhBY=;
	b=yWMWibeJlnSaQE2XRNJxPo6/VNBPzKArSOEuqpACewRmP0lb8I8QKd4g5cpve1EiGO/p
	 awJoX/2HzitPhpeuLDUTwCRxpejVXWfXMvqVyeFgh/eJqwrLvxOY3Mp4hPhVszZBkP6lD
	 ZBF0vKIaoZt4bfqjatH7tfXK/KqbXF80x84feJtyuHagIZCLXsUQurbtBKSfx8yXyxDFR
	 SyrJynZ16gjABqu+Bacbkik7od61SLNplePF8Xn8P5mlu8HTXBbTlO80jNVdblIQ1iTL7
	 J4IWoP1Fv+7xjniVXbY7nNYjKGcmiM59JSmvGzwXH+oGpCM0qOj7mwWi9V4jKmCYVlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJlFM33D;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="LisWq/Fp";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJlFM33D;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="LisWq/Fp";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E8606C73C;
	Thu, 12 Nov 2026 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 876E8606C73C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJlFM33D;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LisWq/Fp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gJlFM33D;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LisWq/Fp
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF2C21E41;
	Thu, 12 Nov 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794492065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTNMIFQg7vEsr/bVsx6max9Hp2mlrFDIwp0Z0arBhBY=;
	b=gJlFM33DOlLsXo/fMz8rj/qpJNd1/LAfw06dbMqIfLoc4IuQh9/RzMXaHgeNvRN5r4o0B4
	DgqDCnXzADpLagRmMbfxO/HW+Bg9xItuDkWUO82GFfItmNejFrXZhBUW2oHpytiyUlvPP+
	TNvMTYoYQXGAiLUv3uBgb7s2eQv/WNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794492065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTNMIFQg7vEsr/bVsx6max9Hp2mlrFDIwp0Z0arBhBY=;
	b=LisWq/Fpj8SqT6u2xIBros+39GjGe1Tr75xCt4eKCv/fmjYu3CJDOJW1YNVOTyGrVDIuJq
	vZrJ+kiUtvHXFUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794492065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTNMIFQg7vEsr/bVsx6max9Hp2mlrFDIwp0Z0arBhBY=;
	b=gJlFM33DOlLsXo/fMz8rj/qpJNd1/LAfw06dbMqIfLoc4IuQh9/RzMXaHgeNvRN5r4o0B4
	DgqDCnXzADpLagRmMbfxO/HW+Bg9xItuDkWUO82GFfItmNejFrXZhBUW2oHpytiyUlvPP+
	TNvMTYoYQXGAiLUv3uBgb7s2eQv/WNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794492065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTNMIFQg7vEsr/bVsx6max9Hp2mlrFDIwp0Z0arBhBY=;
	b=LisWq/Fpj8SqT6u2xIBros+39GjGe1Tr75xCt4eKCv/fmjYu3CJDOJW1YNVOTyGrVDIuJq
	vZrJ+kiUtvHXFUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F9A4134A0;
	Thu, 12 Nov 2026 14:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M0T5C53G9WrPJQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 14:01:01 +0000
Date: Thu, 12 Nov 2026 14:00:59 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net>
 <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
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
In-Reply-To: <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,suse.cz,linux-foundation.org,nvidia.com,linux.alibaba.com,linux.dev,arm.com,intel.com,gmail.com,sk.com,gourry.net,redhat.com,cmpxchg.org,fb.com,surriel.com,szeredi.hu,zeniv.linux.org.uk,arndb.de,ziepe.ca,8bytes.org,oracle.com,toxicpanda.com,davemloft.net,kvack.org,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Nov 12, 2026 at 02:24:09PM +0100, David Hildenbrand (Arm) wrote:
> On 11/12/26 14:09, Pedro Falcato wrote:
> > On Tue, Nov 10, 2026 at 09:35:42PM +0100, David Hildenbrand (Arm) wrote:
> >> Similar to mapping pagecache folios into page tables, let's reject
> >> additional references when splicing folios into a pipe if the refcount
> >> is at its limit, similar to how we handle it during GUP.
> >>
> >> This will prevent more cases of possible folio refcount overflows with
> >> large pagecache folios.
> >>
> >> Introduce folio_get_checked() for checked reference acquisition when
> >> the caller already holds a reference. It warns and fails on a non-positive
> >> refcount and rejects additional references at the limit.
> >>
> >> Use folio_get_checked() in splice_folio_into_pipe() and
> >> fuse_ref_folio(), returning -EFAULT on failure, like we already do for
> >> pipe-buffer duplication. Similarly, make try_get_page() use it instead.
> >>
> >> Likely try_get_page() should be renamed (or removed) later, as it doesn't
> >> match the folio_try_get() semantics and is confusing.
> >>
> >> If we hit the limit after splicing some data, return the number of bytes
> >> already spliced. Teach the callers to handle errors, and stop
> >> filemap_splice_read() if we only spliced part of a folio, so we don't
> >> skip ahead to the next folio.
> >>
> >> The check in try_get_page() also covers pipe-buffer duplication by tee()
> >> and partial pipe-to-pipe splicing.
> >>
> >> Note that we deliberately will not fall back to the slow path of copying
> >> the folio, particularly as the folio might have an invalid refcount. If
> >> it is ever really required, we can revisit.
> >>
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> 
> [...]
> >> index 0f6d57432a7e5..e6e73e37f3ea4 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -3047,10 +3047,11 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >>  EXPORT_SYMBOL(generic_file_read_iter);
> >>  
> >>  /*
> >> - * Splice subpages from a folio into a pipe.
> >> + * Splice subpages from a folio into a pipe. Return the number of bytes spliced,
> >> + * or -EFAULT if we cannot splice from the folio.
> > 
> > -EFAULT is a weird error code to return from splice, et al.
> 
> We might be able to use ETOOMANYREFS (have to check if that could confuse
> callers), but IMHO EFAULT is good enough.
> 
> What would be your suggestion?

ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
or even a generic -EIO.

> 
> > 
> >>   */
> >> -size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
> >> -			      struct folio *folio, loff_t fpos, size_t size)
> >> +ssize_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
> >> +			       struct folio *folio, loff_t fpos, size_t size)
> >>  {
> >>  	struct page *page;
> >>  	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
> >> @@ -3063,13 +3064,15 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
> >>  		struct pipe_buffer *buf = pipe_head_buf(pipe);
> >>  		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
> >>  
> >> +		if (!folio_get_checked(folio))
> >> +			return spliced ? spliced : -EFAULT;
> > 			return spliced ?: -EFAULT;
> > 
> > I don't know if there's much kernel code out there doing this, but I like
> > the trick :)
> 
> There are a couple of thousands, but yes, one doesn't encounter it that often.
> 
> > 
> >> +
> >>  		*buf = (struct pipe_buffer) {
> >>  			.ops	= &page_cache_pipe_buf_ops,
> >>  			.page	= page,
> >>  			.offset	= offset,
> >>  			.len	= part,
> >>  		};
> >> -		folio_get(folio);
> >>  		pipe->head++;
> >>  		page++;
> >>  		spliced += part;
> >> @@ -3094,9 +3097,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
> >>   * Return: On success, the number of bytes read will be returned and *@ppos
> >>   * will be updated if appropriate; 0 will be returned if there is no more data
> >>   * to be read; -EAGAIN will be returned if the pipe had no space, and some
> >> - * other negative error code will be returned on error.  A short read may occur
> >> - * if the pipe has insufficient space, we reach the end of the data or we hit a
> >> - * hole.
> >> + * other negative error code will be returned on error; -EFAULT will be returned
> >> + * if acquiring a folio reference fails and no data has been spliced.
> >> + * A short read may occur if the pipe has insufficient space, we reach the
> >> + * end of the data, hit a hole or hit a folio refcount limit.
> >>   */
> >>  ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> >>  			    struct pipe_inode_info *pipe,
> >> @@ -3154,7 +3158,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> >>  
> >>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >>  			struct folio *folio = fbatch.folios[i];
> >> -			size_t n;
> >> +			ssize_t n;
> >>  
> >>  			if (folio_pos(folio) >= end_offset)
> >>  				goto out;
> >> @@ -3170,13 +3174,15 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> >>  
> >>  			n = min_t(loff_t, len, isize - *ppos);
> >>  			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
> >> -			if (!n)
> >> +			if (n <= 0) {
> >> +				error = n;
> >>  				goto out;
> >> +			}
> >>  			len -= n;
> >>  			total_spliced += n;
> >>  			*ppos += n;
> >>  			in->f_ra.prev_pos = *ppos;
> >> -			if (pipe_is_full(pipe))
> >> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
> > 
> > I'm confused. Why does this need to be done here?
> >  
> 
> I have above:
> 
> "stop filemap_splice_read() if we only spliced part of a folio, so we don't
> skip ahead to the next folio"

Yes, but is this a separate fix? A folio could be partially spliced previously
as well, no?

> 
> Thanks a lot for the review!

You're welcome! :)

FWIW, you can add my

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

to whatever comes out of these nits :)

-- 
Pedro

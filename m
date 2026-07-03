Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F33A0E8A
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070285; cv=none; b=KYfbrCefT7k62iHRX2INE9aZfuH8ACoE3h1BuezC07kFhG+cpBs31o4ikF7VTfszJhbT6gOT+7g06tUeZ2DbB616e9uoMoVsLTgo80Itb/orovLYYdlMdOXBB7JOD2t7aE+jiT7Vr0dQ2mdkDSqwv/pCq6X4mWg90ISsYZ+77Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070285; c=relaxed/simple;
	bh=VRvVNgAL6uKvDRkeMhDw8/Ap0P9fgc38KCkUMbiT3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjVt+aMJkE+1mrVQYlecpT4J5/WhfOCjppi2bsK3cCfl9Zae/kRFtZf0uFO5qc+g3XZq+CUt1Mm9a3SMgImdT4pitFUo7wN3F2jpo7ZrVe1NF6HF7Ssy+lcSRGbpPPw21BTKylxmlHdhw9Qm9eaDawaWYrDBXetWDMZFbuSiqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J+jWUKTq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s2psg9T1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iCXK6Nm4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E8/ghmHk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+jWUKTq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s2psg9T1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iCXK6Nm4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E8/ghmHk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB13674825;
	Fri,  3 Jul 2026 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhN9EMr2lHkL5BMvw29TtKP0AePa2dRLHiG8ECux59Y=;
	b=J+jWUKTqq5o285bOJdd0jxEhqO6vpnYVpX9gnCs0/CFbx1O8UaynYTrWDaU86U6j/g00Ot
	owQzwP1x7cyHpiMhWbTVthDsRPhHM0Fs/ndzb1xZ39msuQUr4haR8ktQiLMvWjiECXXNc/
	Gj5YWtayG7VPZiHhRYbEPcnl+d6Y3mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhN9EMr2lHkL5BMvw29TtKP0AePa2dRLHiG8ECux59Y=;
	b=s2psg9T1r/2hQkDSiO4PtzcwH/6mfj8+bjgLFZwymi5BgnG3YmnTdJsWKdt1SJjfKLwmCj
	fx63nnBGWQ+z8MAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783070280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhN9EMr2lHkL5BMvw29TtKP0AePa2dRLHiG8ECux59Y=;
	b=iCXK6Nm4/4D5p8LPMLzFK81dWPnUO7XwzclX66EtIofxy8KzWsan8gpSDhx2tPtzwqJ7A8
	dKMVE/boPVoTFmEDslBKzgDeK9kua//Whd3YLGvoCxOfQORJHYtTcfU1u29fZmqwAOSS+J
	d7wfrMoZtbApQ9qUvH1hP0qwM+82qfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783070280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhN9EMr2lHkL5BMvw29TtKP0AePa2dRLHiG8ECux59Y=;
	b=E8/ghmHkljwFP6n9e5ZRXEkHaLks7oMbJzsGUtma26Bg/uOEBvrhX4Stvb5MhXawttTNwc
	rtPqN6pycCRUR6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8BD779AA;
	Fri,  3 Jul 2026 09:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h3E+Gkd+R2p/ZgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 03 Jul 2026 09:17:59 +0000
Date: Fri, 3 Jul 2026 10:17:57 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Lorenzo Stoakes <ljs@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <akd95TCd3m8n74Xm@pedro-suse.lan>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <110e92b2-f7a6-487a-94a2-25ef1242afb7@linux.alibaba.com>
 <6a547571-e60e-4b36-9968-011e3d880588@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a547571-e60e-4b36-9968-011e3d880588@linux.dev>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,nvidia.com:email,janestreet.com:email,suse.de:email,infradead.org:email,linux.org.uk:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri, Jul 03, 2026 at 04:45:34PM +0800, Lance Yang wrote:
> 
> 
> On 2026/7/3 11:49, Baolin Wang wrote:
> > 
> > 
> > On 7/3/26 12:54 AM, Pedro Falcato wrote:
> > > As-is, khugepaged and writable-file opening exclude each other. A file
> > > cannot be open writeable and have THPs (because the filesystem is
> > > not aware
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
> > >   nr_thps > 0
> > >    truncate_inode_pages()
> > >      /* THPs are cleared out, but so are the dirty folios */
> > > 
> > > When this edge-case happens, there is data loss, as the dirty folios are
> > > fully discarded.
> > > 
> > > Fix it by fully writing back the page cache (and waiting) when collapsing
> > > file THPs. Doing so provides the guarantee that no dirty folio will be
> > > observed while there are active THPs. To fully ensure this is safe, the
> > > invalidate_lock needs to be held while doing the writeout, so that
> > > do_dentry_open()'s page cache truncation excludes this write-and-wait.
> > 
> > Thanks for explaining the race, and it looks reasonable to me. One nit
> > below.
> > 
> > > Cc: stable@vger.kernel.org
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > > Cc: Zi Yan <ziy@nvidia.com>
> > > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-
> > > shmem) FS")
> > > Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> > > Closes: https://lore.kernel.org/linux-mm/
> > > CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> > > Tested-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > ---
> > > This patch is written against 7.1.0 (because the code no longer
> > > exists in mainline).
> > > 
> > > Zi, I kept your Tested-by, but I had to move some things around and
> > > use the invalidate lock. Please re-test if you can.
> > > 
> > >   mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
> > >   1 file changed, 25 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index b8452dbdb043..0707d719a270 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct
> > > mm_struct *mm, unsigned long addr,
> > >           goto xa_unlocked;
> > >       }
> > > -    if (!is_shmem) {
> > > +xa_locked:
> > > +    xas_unlock_irq(&xas);
> > > +xa_unlocked:
> > > +
> > > +    /*
> > > +     * If collapse is successful, flush must be done now before copying.
> > > +     * If collapse is unsuccessful, does flush actually need to be done?
> > > +     * Do it anyway, to clear the state.
> > > +     */
> > > +    try_to_unmap_flush();
> > > +
> > > +    if (result == SCAN_SUCCEED && !is_shmem) {
> > 
> > Actually, the operations below only for those mappings that do not
> > support large folios. For mappings with large folio support,
> > filemap_nr_thps() always returns 0, so the race described in the commit
> > message won't happen. We can add mapping_large_folio_support() here to
> > filter them out.
> > 
> > if (result == SCAN_SUCCEED && !is_shmem && !
> > mapping_large_folio_support(mapping)) {
> > 
> 
> Right! nr_thps only gets updated when !mapping_large_folio_support(mapping).
> 
> For mappings that do support large folios, writable open won't see
> nr_thps > 0, so no truncate_inode_pages() for that case :)

Yep, thanks for the suggestions. Willy also suggested this, and I didn't get
why at the time, but looking closely at nr_thps_inc/dec, those helpers only
do something when !mapping_large_folio_support(). Fun...

I'll fix it up when sending to stable (or a possible v2).

-- 
Pedro

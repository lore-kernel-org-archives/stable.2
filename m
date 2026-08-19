Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758E48B368;
	Wed, 19 Aug 2026 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157356; cv=none; b=jqWrx8WlMoVsrUB0clVjSi5fUneOc3+0o7gSmaYJgE4oOdbMoCT/fG0+pf9K5jwJ8RqvmW8dp4c4UEp0Af94IjqiTNN6+/i42+LtJd0plJ17DSutdhaLMng7fHMJ9WSvMoRve/hpiqpKv+bYLELpxaVlAh5Yyvb2V8QpGd//O6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157356; c=relaxed/simple;
	bh=AdW+Fil92x/8hWUMdMCPjSI0gsgIpk/Lk65p+FVKiBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A97o/T3LcQNDlUV7GVQURXHkJtk/XGPMxUL4vpXeoxsZBChif2n1qYuFzMX3YuGA8CAB7oe2wacV5fNnZZziRPDrziZYpjQW+2f/HK1YhJwsjQ3WpuMOFkX/Rau7oVFXpNcl+VpHE2YYBv99s584LU4zGtKYVOlEl+V3CCnwhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c7N0m8t0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsaFVQoM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pHjX4rIe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JZhA/NsW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c7N0m8t0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsaFVQoM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pHjX4rIe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JZhA/NsW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 613433F02;
	Wed, 19 Aug 2026 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787157348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz2VOBZnDUX4tOf6vz3K3Pbv0gc4KxVhhgpUb8PRsnQ=;
	b=c7N0m8t0A/TVypGMIr9WfJPoTCnCYLI5foGgtL7CysId3PJtOQTDqGFE5/Umf18rduLFnp
	mzkg7wL2+rCaZM41qyVuN6BB4jU8mOs0B/n3dnzfsRe05yVzVD1v7xFiqSt5Ecq82GLb73
	hQLRk0zi44nLhA+dIWWuu48mlODxmFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787157348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz2VOBZnDUX4tOf6vz3K3Pbv0gc4KxVhhgpUb8PRsnQ=;
	b=wsaFVQoMkrvXaILgSQs/VsxYBJM/XD1pZyYSJ5BHe69V19DsW3SPyJHAY6WHuQ9GSoTiVj
	C6xTwWeeE28JTgBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pHjX4rIe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JZhA/NsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787157344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz2VOBZnDUX4tOf6vz3K3Pbv0gc4KxVhhgpUb8PRsnQ=;
	b=pHjX4rIeoqdIhD1189zAIBHsMy76AiyTWn0oQjEvMQNQzQXG00C0UMo4Cgj1kGzkoC+1oy
	mFspuBxjrnq8oCvQfLFt7PgEZnxET8D2qwq3CO8GYAlcTP5qRqTuz+mBz4EeDVAA/MxQGQ
	5QGklhAWrVAtaTCXIY5M0wkjp3e7bwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787157344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz2VOBZnDUX4tOf6vz3K3Pbv0gc4KxVhhgpUb8PRsnQ=;
	b=JZhA/NsWWEYDQIRQVH20BKkJlUTsBlhsgtFzGMT4xMFG8pbrc5BADdeMVD4A80AcePSTll
	ZrpjKg/kMNVnZ1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F16842F81;
	Wed, 19 Aug 2026 16:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XgCuN17bhWrkBgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 19 Aug 2026 16:35:42 +0000
Date: Wed, 19 Aug 2026 17:35:41 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	david@kernel.org, dev.jain@arm.com, lance.yang@linux.dev, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <aoXYh9EPF6QnlvIK@pedro-suse.lan>
References: <20260819101222.3732660-1-usama.arif@linux.dev>
 <aoWw_iKEDLjKL2jr@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoWw_iKEDLjKL2jr@thinkstation>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,linux-foundation.org,kernel.org,linux.alibaba.com,arm.com,infradead.org,vger.kernel.org,kvack.org,nvidia.com,gmail.com,cmpxchg.org,surriel.com,meta.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 613433F02
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, Aug 19, 2026 at 03:31:40PM +0100, Kiryl Shutsemau wrote:
> On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
> > zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> > file case, but not the dirty bit.  The pte path does propagate it, in
> > zap_present_folio_ptes() and so does the pmd split path, in
> > __split_huge_pmd_locked().
> > 
> > For most file mappings the omission is harmless, because writing to a
> > shared file mapping goes through page_mkwrite(), which dirties the
> > folio.  tmpfs is different: it has no page_mkwrite(), and
> > vma_wants_writenotify() is false for it, so a *read* fault on a
> > MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
> > do_read_fault() does not call fault_dirty_shared_page(), so subsequent
> > stores through that mapping set only the hardware dirty bit in the pmd
> > and never call folio_mark_dirty().
> >
> > A shmem folio allocated by a fault
> > is marked uptodate but not dirty (see the clear: block in
> > shmem_get_folio_gfp()), so PG_dirty is never set at all.
> > 
> > Unmapping such a folio - munmap(), or exit_mmap() when the process dies
> > - then loses the only record that it was written, because zap_huge_pmd()
> > drops the pmd without transferring the dirty bit.  Reclaim afterwards
> > sees a clean shmem folio: the whole swap-out block in
> > shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
> > pageout() is skipped and the folio falls into __remove_mapping().
> > There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
> > entry is created and __filemap_remove_folio(folio, NULL) simply empties
> > the i_pages slot.  The data is freed without ever being written to swap,
> > and the next fault on that index returns a freshly zeroed folio.
> > 
> > This is silent data loss for any process that keeps state in a
> > MAP_SHARED tmpfs segment across an unmap - for example a cache handed
> > from one process generation to the next through /dev/shm.  It requires
> > the folio to be PMD-mapped, so it only shows up once shmem THP is
> > enabled (which is what we did in Meta fleet and started noticing crashes);
> > with THP off the pte path transfers the dirty bit correctly.
> > It also only becomes visible when swap is enabled, because with no swap
> > device shmem folios (which are on the anon LRU) are not scanned by
> > reclaim at all, so the clean folio is never dropped.
> > 
> > Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
> > 2MB-backed region, write a known pattern through the resulting mapping,
> > munmap, force reclaim of the cgroup, then re-map and read back.  Without
> > this patch the region reads back as zeros and vmstat shows zswpout 0 -
> > the data was discarded rather than swapped.  With this patch the region
> > reads back correctly and the pages are swapped out as expected.  With
> > huge=never, or when the first touch is a write, the test passes either
> > way.
> 
> +Hugh.
> 
> Oopsie.
> 
> I'm confused why it took a decade to discover the bug...
> Maybe read ahead of write for shmem is too rare, I donno.
> 
> > 
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 
> This would be more precise: b5072380eb61 ("thp: support file pages in zap_huge_pmd()")
> 
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> >  mm/huge_memory.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index ced400f72d43a..afbb5974bd225 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
> >  		add_mm_counter(mm, mm_counter_file(folio),
> >  			       -HPAGE_PMD_NR);
> >  
> > +		if (is_present && pmd_dirty(pmdval))
> > +			folio_mark_dirty(folio);
> 
> Unrelated to your patch, but noticed while looking at it: we drop the rmap
> here under the pmd lock, while the TLB flush is deferred to
> tlb_finish_mmu(). The pte path handles this with
> tlb_delay_rmap()/force_flush (5df397dec7c4), but there's no pmd equivalent:
> tlb_flush_rmap_batch() only knows folio_remove_rmap_ptes(), and
> zap_huge_pmd() uses tlb_remove_page_size(), which takes no delay_rmap.
> 
> Doesn't matter for shmem, but xfs & friends do get PMD-order folios, and
> do_set_pmd() makes the pmd dirty+writable once page_mkwrite() has run. So
> folio_mkclean() can clean the folio while another CPU still stores through a
> stale TLB entry -- silently lost write, no PG_dirty left behind.

Where do you see page_mkwrite being called in the same path as do_set_pmd()?
Per my understanding of the code, this Should Not Happen, and it really Should
Not Happen for many, many reasons (write amplification being the main one).

Namely, see the comment in wp_huge_pmd():
	/* COW or write-notify handled on pte level: split pmd. */

if file huge pages get mapped writable, that's a bug.
 

-- 
Pedro

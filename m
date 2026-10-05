Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764646AA80;
	Mon,  5 Oct 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195903; cv=none; b=Yl8EuKxTK0LIxkcXk8YGWp3/hP29aFB2F1YfS1d7wLQ/Mow9+51v8DGR2SGF0fqmxYjtVexOhO5/X6t0Q+ODdKb0bZbLHd4lED2lRc3UT1lEJhGaQJL8HCN4Qb92cyfTu98RHV0jBzp6Fs+ryvlSNY+g5OVSRTJllhkyGX1Jy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195903; c=relaxed/simple;
	bh=Ufo1yWo3YliqzrbbK15dXSNgC1i3K628kdQ7a5VjK2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3v6cRlLRNUR1LxiiGnqfKhbQMW2IZM/YOeIBakzX1YQdVwGBR7nPoUCKvZXcGQElBokV7fwhF85W7GRbCqYH4DaGZMpDRoLrgL+Fk2zPN/l26u/Kl1WkcwnqeXTdQjNVBoPugjKLvnU9OKEoAnq0BaHrOWk4UCGp8dED9Psqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ikDzCcEp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=imk4MGAA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aki+slgp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzR80h+l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ikDzCcEp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="imk4MGAA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aki+slgp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzR80h+l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1177721C05;
	Mon,  5 Oct 2026 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791195895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZLgiG+4IlxeGD7HzroLABOVng6ksFHCgPf63OPIsQ=;
	b=ikDzCcEpGmruSsQFidAwp9wkCVax1gJ0Pv2ATGDvLWy03YdpR6dCYK2gB8XyOYeTVcUeeq
	f5SHU+sPvKCd9adBJn8PZ8yYrP59v7aZHRC53ZR9MscOs64jCNeO7Cyh8jBT3Q7JiaXG4Z
	e0WW02FyNpBpXroTiDYKc4JPGHoKAPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791195895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZLgiG+4IlxeGD7HzroLABOVng6ksFHCgPf63OPIsQ=;
	b=imk4MGAA27siQ7Wm3brQLl/xx6WXMa95OMHIlhcvzjR7gINYEK5qo/eTF3K5VTDqSCeNxB
	q2eH36l5FgbsMyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791195891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZLgiG+4IlxeGD7HzroLABOVng6ksFHCgPf63OPIsQ=;
	b=Aki+slgpTsmNNEwyAniczbuR1ttLN3oToyA2eo3vd9afv2kR8oLde1VoYLDH4JRcWyXv4C
	OOcf5d15kRYXS8KYok+fFklkabzDFcudjYtsc3txnNn2v24ZqxFf3puDeuERonyf4RFXep
	euC+wEF0YcP/jgOd/97BWOXRDFYL6uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791195891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZLgiG+4IlxeGD7HzroLABOVng6ksFHCgPf63OPIsQ=;
	b=PzR80h+l23n/FtRrjUo1OMeYZiUz9OAVyLs//nM87tk51pUm3lBc4cW9t/aW1mpex2kvD8
	V7NfQgyq5ps/b3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0BD8132D3;
	Mon,  5 Oct 2026 10:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HqCSGfJ6w2rFIgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 05 Oct 2026 10:24:50 +0000
Date: Mon, 5 Oct 2026 12:24:49 +0200
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	riel@surriel.com, linux-kernel@vger.kernel.org, qi.zheng@linux.dev, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, brendan.jackman@linux.dev, 
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org, toshi.kani@hpe.com, 
	david@kernel.org, mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Message-ID: <asN4wjUbDAIcrfA-@pedro-suse.tail5790ac.ts.net>
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,infradead.org,redhat.com,alien8.de,zytor.com,surriel.com,vger.kernel.org,linux.dev,gmail.com,amd.com,meta.com,kvack.org,linux-foundation.org,google.com,outlook.com,citrix.com,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, Oct 05, 2026 at 03:29:22PM +0800, Lance Yang wrote:
> 
> 
> On 2026/10/5 14:09, Pedro Falcato wrote:
> > On Mon, Oct 05, 2026 at 01:23:02PM +0800, Lance Yang wrote:
> > > pud_free_pmd_page() uses a single-address invalidation to flush the
> > > paging-structure caches before freeing the page tables. With AMD TCE
> > > enabled, this only invalidates upper-level entries associated with the
> > > target address. Cached PMD entries for other addresses in the PUD range can
> > > still reference the PTE pages being freed.
> > > 
> > > The AMD manual quoted in the commit enabling TCE says these instructions
> > > remove
> > > 
> > >    "only those upper-level entries that lead to the target PTE in the page
> > >    table hierarchy, leaving unrelated upper-level entries intact."
> > > 
> > > Even with all PTEs cleared, speculative page walks can cache present PMD
> > > entries after the earlier TLB purge.
> > > 
> > > Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
> > > the single-address invalidation otherwise.
> > > 
> > > Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > 
> > I'm not sure this is correct. The PUD is clear. We invalidate the TLB, which
> > invalidates the translation caches for that walk. invlpg will notice the PUD
> > isn't present. I don't see a case where it can ever not clear the rest
> > of the translation caches for all leaves. And, in fact, by that point the CPU
> > can (does?) probably formally treat the PUD as the leaf.
> 
> IIUC, clearing the PUD in memory doesn't invalidate cached PMD entries by
> itself. With TCE enabled, flushing one address only invalidates the entries
> associated with that address ...
> 
> (That's how I read the manual, but AMD folks, please correct me if I'm
> missing something.)
> 
> So couldn't other cached PMDs under the same PUD survive?

I don't read it as that. I read it as "flushing one address only invalidates
the entries on that path". So, if you flush one address, you'll flush the
whole translation cache for that range. And page table zapping agrees; if you
follow the code from zap_pte_range() -> pte_free_tlb(), it will do a single flush
for each PTE table (if the whole table is empty/non-present).
 
-- 
Pedro

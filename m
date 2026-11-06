Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973994;
	b=euzd0KKXIZvndW6xATzfyeFsJ3UoONcB0wSy/cScoKN4SHE6pChlSXcOE4jJrI0PnoBW
	 4rjvprWfYfcJRoXddhdx0y1f89zNxe9kg3Hyn8d3JkJN7WeA795+Cppa60dDbkLxqh1Nf
	 OUKYGsiMnqJcDi1LzhTYkKpx03A9PNpHuex2VaqFbAbI89WmDF8gMVQgSbBdyLwzxd511
	 ymr1SajAEItoZIpm4e653hRojxXhFoOestTsDw7t33Wk9UdEhHhryVHqq7CUVKGoKXNUg
	 J4pEcO33ZlnUm2sUgqDwHW/EC7E1Nu7NwfglzoyImYiiqBJt3/RiSwAgZ/9RFGApPvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973994;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=kkNYkeNE70WPtaAN9DA9oFQKwNzrr37+/VHeOjZamN0=;
	b=HwfnnseYPg8DJELdZRUWjDpkfkL3UPmRqO72EBXHhfrdECmA0C0LYFwHERgMH1gO2qxy
	 PCbjJ/e26cUjM3tk3pjiSnKFUK6wUEEuhnQXAHFRJjfcNPURGTlnZ563TsPu7iTeT8gZ0
	 95uoIkBQWEPFN4KPeF9bPCEw/pVZo/sxAJXd5N88kY4x2fb2LXI7BOIv/KhL0MdsiEwE1
	 0aCHf1o7AUh06cWPY3QvRwFFYsqQTpveSNl/gAUkGFZe97gcjoavckE/mFVYDl/ESlv54
	 9HDUww89aldxpQ+jtiBqCrH5myX30Y2q1jQLNukpE7NLb9YrNkJLyxlgNSenBiKkLkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HYCXuoie;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="k6n/Kfux";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HYCXuoie;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="k6n/Kfux";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D3606A326;
	Fri,  6 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HYCXuoie;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k6n/Kfux;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HYCXuoie;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k6n/Kfux
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5170C1F7F5;
	Fri,  6 Nov 2026 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793973991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkNYkeNE70WPtaAN9DA9oFQKwNzrr37+/VHeOjZamN0=;
	b=HYCXuoierL737OpwGTSBiFtCNZsGHglPQTMPO4xMGvCJEhpXHAfWCPkjEWr2Zt6zeucAuZ
	Aw4xlaalSlJRo6qbRgIiC3dhzTu20ZWsEdGWxzfIh2RaQfU3w05UqFuL8h3JeZirIKOt23
	I9wm5k70zac1ek2/yfQvV33IYc++MrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793973991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkNYkeNE70WPtaAN9DA9oFQKwNzrr37+/VHeOjZamN0=;
	b=k6n/KfuxZ+6UVLlCllYhPpTvopJG2L2NtK31AQ3FXc0D8tanjreTzupE1aEZBil9oXPmfu
	i75D+RtwwwZauaCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HYCXuoie;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="k6n/Kfux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793973991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkNYkeNE70WPtaAN9DA9oFQKwNzrr37+/VHeOjZamN0=;
	b=HYCXuoierL737OpwGTSBiFtCNZsGHglPQTMPO4xMGvCJEhpXHAfWCPkjEWr2Zt6zeucAuZ
	Aw4xlaalSlJRo6qbRgIiC3dhzTu20ZWsEdGWxzfIh2RaQfU3w05UqFuL8h3JeZirIKOt23
	I9wm5k70zac1ek2/yfQvV33IYc++MrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793973991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkNYkeNE70WPtaAN9DA9oFQKwNzrr37+/VHeOjZamN0=;
	b=k6n/KfuxZ+6UVLlCllYhPpTvopJG2L2NtK31AQ3FXc0D8tanjreTzupE1aEZBil9oXPmfu
	i75D+RtwwwZauaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14F53134E9;
	Fri,  6 Nov 2026 14:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JH6tL+Xe7WooXAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 06 Nov 2026 14:06:29 +0000
Date: Fri, 6 Nov 2026 14:06:28 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
Message-ID: <au3bJel0YnSeowCq@pedro-suse.lan>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
 <au3C8lNElGg4LnR1@thinkstation>
 <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>
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
In-Reply-To: <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>
X-Rspamd-Queue-Id: 5170C1F7F5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Fri, Nov 06, 2026 at 01:29:31PM +0100, David Hildenbrand (Arm) wrote:
> On 11/6/26 13:09, Kiryl Shutsemau wrote:
> > On Thu, Nov 05, 2026 at 07:16:44PM +0100, David Hildenbrand (Arm) wrote:
> >> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> >> uptodate. For example, shmem fallocate() can put such folios into the
> >> page cache.
> >>
> >> collapse_file() already refuses to proceed with folios that are not
> >> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> >> such folios, leaving handling to the page faults.
> >>
> >> Note that collapse_file() effectively clears shmem folios through
> >> shmem_get_folio(); let's keep this fix simple and simply let the page
> >> fault path deal with that.
> >>
> >> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> >> Reported-by: Chris Mason <mason@kernel.org>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > 
> > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > 
> > Separately from this fix: nothing on the mapping side catches this.
> > Every caller checks uptodate on its own (next_uptodate_folio(),
> > filemap_fault(), shmem_get_folio()), and khugepaged was the one that
> > went straight from filemap_lock_folio() to do_set_pmd().
> > 
> > Should do_set_pmd() and set_pte_range() assert it? Something like
> > 
> >         VM_WARN_ON_ONCE_FOLIO(folio->mapping && !folio_test_anon(folio) &&
> >                               !folio_test_uptodate(folio), folio);
> 
> I think so. But looking at these hard-to-trigger but in the end very nasty
> problems, should we actually reject the operation and do a pr_warn_once() or
> something?
> 

Yes. FWIW, this is something that's been going through my mind. Our page table
manipulation APIs (and usage) are way too fragile and allow you to do the
most insane things without ever realizing it (e.g you can clear a pte, set
over a PTE, get-and-clear and discard the result, and do all of the above with
no locks held, set a pte for a folio that's not uptodate, set a pte for a folio
for which you don't have the lock, etc).

Some basic assertions (even if there's no easy way to back down from those)
would be nice, or ideally yes a rejection.

I would just add that these very much should be VM_WARN_ON_ONCE instead of
pr_warn_once(). pr_warn_once() will (AIUI) not be caught by fuzzers, at least
not as easily.

Also, if they're inexpensive enough, we might want to upgrade them to full
WARN_ON_ONCE().

-- 
Pedro

Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E687393DF5;
	Mon, 14 Sep 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378385; cv=none; b=QxNf/AktTYprEKWN55kaX5heJNPzhu7AjA0/gyHygp2GOY2z6gf7o550rppnY6RtcavhXt3Y+mYmhumdW8IWZbPi8GLkIwMPWvhh5iTJQ3xzyaJRHe/f3kOI2ZVqup6pX3d2BBLgD0WiZYlDy/v0IfSAcDpWZgnnLDxyUXVtQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378385; c=relaxed/simple;
	bh=aSj33CN0T3dI/k14fPa6ofhjE1bRSsSF8+cMgeD4JMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPifpcGXlJpBMKaMQjXyYoX4RgnjEF6uwZKFJRv++jm+41PZZdVcvNevVqa/BniZMG92GXazMMBW2PTrkKntZLzXTdKj3wOPcoa4hh6e3I/yQNu8V8Dc8lS/DvPrYojhZutU8RkFNHZzqdd2VM7cBAvKtPP10nPZaCoD9wt8f0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LbIDoKjN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XRF123uR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMwfz1Sg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0sRxt1xJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LbIDoKjN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XRF123uR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMwfz1Sg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0sRxt1xJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C89EE1F45E;
	Mon, 14 Sep 2026 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789378377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsJ7pXjtqm+GzQ+2zmJwqm6kI3CiTcOpGOda6jqVgA=;
	b=LbIDoKjNeXoce6+Au8AUEmijy9fOusYZyTZUtJIZRWjyLl6mAxI2CHfcE8lxC3LfVyTq4V
	FOi0ZyXOpbwV+ceni0eQ35T1oqrF3DBiyZhaMLkTolyxBvJ+PtSTTIK4hGhiUHfQQ16kgW
	5zui2dRs127w1G0rbHsZbVJQIsF8k7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789378377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsJ7pXjtqm+GzQ+2zmJwqm6kI3CiTcOpGOda6jqVgA=;
	b=XRF123uRxImNUf9YrAcZypZwpkHHDigE22v1nuf4vasiaLeELcfsShNR6obW8JuOen/B0x
	nYkeSHJi7lPGkUBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789378372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsJ7pXjtqm+GzQ+2zmJwqm6kI3CiTcOpGOda6jqVgA=;
	b=nMwfz1Sgx3+zFjCPJptoAizAv9jEuAuj3+63p+1uS9zSZup/ZeZ/hQoT9DUjbphthhpMsG
	j+qzl/oag9dJnrDvMYEurA/JC1WJfOdA9N+Bi4v00ub9sQjRGyMiDYykzYHrn2q3uplxrW
	eGDw40MayqyWozqxSA3kepwx1PRV1zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789378372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlsJ7pXjtqm+GzQ+2zmJwqm6kI3CiTcOpGOda6jqVgA=;
	b=0sRxt1xJhYVpOLEuHiB88wnuBlg5CP/Qv0UxLrrVRNYKn9JO9RbVU8ZR04NSVQq7vvOG39
	nc4d7DOAVWLfnZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D4A91368C;
	Mon, 14 Sep 2026 09:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uTVgJkS/p2prXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 09:32:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E0A2A12E4; Mon, 14 Sep 2026 11:32:52 +0200 (CEST)
Date: Mon, 14 Sep 2026 11:32:52 +0200
From: Jan Kara <jack@suse.cz>
To: Barry Song <baohua@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Wenjie Qi <qwjhust@gmail.com>, 
	willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, axboe@kernel.dk, trond.myklebust@hammerspace.com, 
	jaegeuk@kernel.org, chao@kernel.org, qiwenjie@xiaomi.com
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
Message-ID: <hbki3yc23dr5fkre5phwx2ev6yjfn3ooodan37uo3at53y3gs2@kjyxyb34s5bi>
References: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
 <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
 <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu>
 <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
 <65a2c7df-0d2e-46de-9580-01e9c35a7e32@columbia.edu>
 <CAGsJ_4zS+UehT4wuTuTVjK3s3mhzp+dku8M-Of9cF=CN82aRow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zS+UehT4wuTuTVjK3s3mhzp+dku8M-Of9cF=CN82aRow@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[columbia.edu,gmail.com,infradead.org,suse.cz,linux-foundation.org,vger.kernel.org,kvack.org,kernel.dk,hammerspace.com,kernel.org,xiaomi.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,infradead.org:email,xiaomi.com:email]

On Mon 14-09-26 09:09:32, Barry Song wrote:
> On Mon, Sep 14, 2026 at 7:34 AM Tal Zussman <tz2294@columbia.edu> wrote:
> >
> > On 9/13/26 6:51 PM, Barry Song wrote:
> > > On Fri, Sep 4, 2026 at 6:36 AM Tal Zussman <tz2294@columbia.edu> wrote:
> > >>
> > >> On 9/4/26 12:28 AM, Barry Song wrote:
> > >> > On Sun, Aug 30, 2026 at 7:59 PM Tal Zussman <tz2294@columbia.edu> wrote:
> > >> >>
> > >> >> On 8/30/26 6:25 AM, Wenjie Qi wrote:
> > >> >> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> > >> >> >
> > >> >> > Fault-around can map ready dropbehind folios without going through the
> > >> >> > normal page-cache lookup that clears dropbehind. A mapping represents a
> > >> >> > competing cached user, but writeback completion can currently unmap that
> > >> >> > folio. A later mmap access must then fault it back in.
> > >> >> >
> > >> >> > Retain mapped folios instead. For a mapped folio,
> > >> >> > folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
> > >> >> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this path when
> > >> >> > folio_end_dropbehind() runs in non-preemptible task context.
> > >> >> >
> > >> >> > Unmapped dropbehind folios continue through the existing invalidation path.
> > >> >> >
> > >> >> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
> > >> >> > Cc: stable@vger.kernel.org
> > >> >> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > >> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > >> >> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> > >> >> > ---
> > >> >> > The mapped-plus-dropbehind state was reproduced in QEMU. The patched
> > >> >> > kernel retained the mapped folio and continued to evict the unmapped
> > >> >> > dontcache folio. I did not reproduce the sleeping-in-atomic warning and
> > >> >> > am not aware of an existing report.
> > >> >> >
> > >> >>
> > >> >> I was able to trigger the sleeping-while-atomic BUG on current mainline with
> > >> >> some help from Claude. The reproducer itself is straightforward enough, but the
> > >> >> configuration was a little finicky. The atomic context comes from using
> > >> >> threadirqs so that virtblk_done() completes requests from the irq thread under
> > >> >> local_bh_disable() and the vq spinlock with irqs off, so in_task() is true but
> > >> >> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so completion stays
> > >> >> in the irq thread rather than softirq) and ext4 -o dioread_lock (so end_io runs
> > >> >> inline instead of on a workqueue). With v4 applied the bug is gone, so:
> > >> >>
> > >> >
> > >> > Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
> > >> > patch, we are no longer going to sleep for dropbehind in `filemap.c`,
> > >> > do we still need all the complex logic in the block device and file
> > >> > system layers to move dropbehind to a workqueue task context?
> > >> >
> > >>
> > >> Hi Barry,
> > >>
> > >> Let me clarify. Wenjie's patch prevents sleeping in a very specific case.
> > >> The existing in_task() check covered most other cases, in that it just
> > >> doesn't do dropbehind invalidation if we're not executing in task context
> > >> (for example, block device writeback completing in interrupt context).
> > >>
> > >> However, dropping the invalidation defeats the point of dropbehind, as it
> > >> leaves the pages in the page cache. If we get rid of the task-context
> > >> deferral mechanism, we wouldn't sleep, but we also wouldn't invalidate.
> > >> Wenjie's change is largely unrelated to this.
> > >
> > > Hi Tal,
> > >
> > > Thanks for the clarification. However, I’m still not convinced.
> > >
> > > If `unmap_mapping_folio()` is the only place where we might
> > > sleep — where we might take `mapping->i_mmap_rwsem` through
> > > `i_mmap_lock_read()`, as Wenjian pointed out in [1] — we have now
> > > prevented that from happening with `if (!folio_mapped(folio))`.
> > >
> > > So no mapped folio should call `folio_unmap_invalidate()`:
> > >
> > > static void filemap_end_dropbehind(struct folio *folio)
> > > {
> > >          struct address_space *mapping = folio->mapping;
> > >
> > >          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > >
> > >          if (folio_test_writeback(folio) || folio_test_dirty(folio))
> > >                  return;
> > >          if (!folio_test_clear_dropbehind(folio))
> > >                  return;
> > >          if (mapping && !folio_mapped(folio))
> > >                  folio_unmap_invalidate(mapping, folio, 0);
> > > }
> > >
> > > Why do we still need the `in_task()` check in
> > > `folio_end_dropbehind()`?
> > >
> > > void folio_end_dropbehind(struct folio *folio)
> > > {
> > >          if (!folio_test_dropbehind(folio))
> > >                  return;
> > >
> > >          /*
> > >           * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> > >           * but can happen if normal writeback just happens to find dirty folios
> > >           * that were created as part of uncached writeback, and that writeback
> > >           * would otherwise not need non-IRQ handling. Just skip the
> > >           * invalidation in that case.
> > >           */
> > >          if (in_task() && folio_trylock(folio)) {
> > >                  filemap_end_dropbehind(folio);
> > >                  folio_unlock(folio);
> > >          }
> > > }
> > >
> > > Could any other operation in `folio_unmap_invalidate()` sleep for
> > > unmapped folios? Otherwise, it seems we don't need `in_task()` at
> > > all?

We do need it. folio_unmap_invalidate() calls filemap_release_folio() which
calls into ->release_folio() handler and generally filesystems are allowed
to sleep in this handler. Now usually they don't actually sleep there but
they definitely grab a lot of irq unsafe locks there as Tal writes below.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

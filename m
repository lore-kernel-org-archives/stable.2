Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020041;
	b=pSNEM2L0mxxtzXGAVNRLQZzjGqWbkLGGKWu6cnBQWvxwKhGzbCrIRUSjFbxmPIub0S1I
	 FfBe3muCEW87d0WT0pGewl8IbOyD+fhsxh07LsQO7noKXr62ETshpnuvQbNlNWcxy5/OZ
	 jE+Csjf/7d6FzRlJlnS21z9D8awQVC9SDfwiDhR8YtaTTnhcvKG5mB/MqXWgKLwaVkMXO
	 zgxdiHCDDIfbnHdvpQP32Th6vYPvSOu5yNDOKzjE8Tj1kYCsuskleSkYtBOkpQpzsD2Gk
	 kzwtUdq250MptHlSFEyZwS0qQ0ws1i2QtFi7b3k2EyCi/NQcPOE0eYXPsG8TcTEVPCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020041;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=p4aTtckkNIZTj3KdHwLDdVPDSaAWMqxSQJcGzbmfPd8=;
	b=FSPBPc9kiDyEMKvzenfQYw8MLhQg4Lg3q4RZDCnNCLaKc+oSSSdanybjxjIBuLHyE0w4
	 iT5FriqKZFu8lvY8++taNeyQVIHsRvnhEmHxDTKonIFA64B8zx2SAaryLbZTtDtyGLrT2
	 wJYEARO/vKx2X21AjZJrw5VgXAZf+8rKdJ8xJlgYRYCMTNi27J4wgxDItZcRVopC4uZWX
	 fm2ibuN0TNfj0saNYtRo811XStzvewNPEC5h3Ptk2CxjcJVaggN/tiBmwG1FoKliDjTsc
	 kZbUC2ZmsZo9kmADojQy4IATusQyq5MZ2ADx/Qu21fUHYRKDvksfI0MCJWUBIOO3/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kzXwZUgx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="sYZQ50X/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="tCXN4/UT";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=axaS3z55;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEE606A31B;
	Mon, 26 Oct 2026 13:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FEE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kzXwZUgx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sYZQ50X/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tCXN4/UT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=axaS3z55
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8A621E84;
	Mon, 26 Oct 2026 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793020038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4aTtckkNIZTj3KdHwLDdVPDSaAWMqxSQJcGzbmfPd8=;
	b=kzXwZUgxjb3dLMkfPC4/6iPI5q3nlBiWjKcS+LICVn1f7NgrpyijK9kPMkQXmpEQNDgKs0
	5wRC3t70dv3tfM4m9rjrGyi3sWZHHdagCD65ztwyGgV4bPaAnTCemVzDvw/Cml1vHSdZ6L
	9w6zrs9dgniLswGBLc6zRCnVi6YE6mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793020038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4aTtckkNIZTj3KdHwLDdVPDSaAWMqxSQJcGzbmfPd8=;
	b=sYZQ50X/hGcQnVBiApUx0JvHUaM1W8X7Q9/5/pqzMS0x6EMYYvXIdE98tb4CW8gwaS1dAM
	UrxsYNdfYBQqAWBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tCXN4/UT";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=axaS3z55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793020037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4aTtckkNIZTj3KdHwLDdVPDSaAWMqxSQJcGzbmfPd8=;
	b=tCXN4/UTrJkFRabug2fy7KFrUD8//yjdscptoZ2fnQL1W6IvqOP6GOi4p6C1Ow/a0llnl0
	qKyeiaQiX3zQaqck1GpvjD/4jaCL/ov3M88TtbQtB2KL4aXUxggySnv2p+RDFBmUPjHctf
	VcYapD8oNUn0plwwEc92uZQGyo/mgqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793020037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4aTtckkNIZTj3KdHwLDdVPDSaAWMqxSQJcGzbmfPd8=;
	b=axaS3z55G30XACXvwbOHlXmOTQjSeNrlUlKDROuoWn555U5+DlXxrsO8NgblQq/nIYYLA9
	wnP5qY1NcQLSPOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E6213408;
	Mon, 26 Oct 2026 13:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vpa6MoNQ32rGXwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:07:15 +0000
Date: Mon, 26 Oct 2026 13:07:14 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
	Colin Cross <ccross@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/vma: avoid losing atomic VMA flags when setting
 sticky VMA flags
Message-ID: <at9QWd9wst333TWx@pedro-suse.tail5790ac.ts.net>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-4-8ff4fae1fc85@kernel.org>
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
In-Reply-To: <20261023-fix-vma-atomic-v1-4-8ff4fae1fc85@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 4B8A621E84

On Fri, Oct 23, 2026 at 02:47:30PM +0100, Lorenzo Stoakes (ARM) wrote:
> vma_merge_existing_range() merges an existing VMA (middle) when its
> attributes have changed to match those of one or both adjacent VMAs.
> 
> Sticky flags are propagated if they are set in any of the merged VMAs. They
> are initialised from vmg->vma_flags, which is assumed to contain middle's
> sticky flags when the function is invoked.
> 
> However, the VMA write lock is not held for middle when they are first
> populated, so concurrent updates to atomic VMA flags may occur, which will
> be lost upon merge.
> 
> This can result in fork failing to propagate guard region markers and (if
> file-backed) THP collapse discarding them.
> 
> Resolve this by propagating the sticky flags after middle is locked.
> 
> Make life easier by factoring this into propagate_sticky_flags(), which
> treats vmg->vma_flags as its base (in case any sticky flags are set there),
> updating it as sticky flags are accumulated from merged VMAs.
> 
> Also update vma_expand() to use propagate_sticky_flags() so all merge paths
> utilise it.
> 
> propagate_sticky_flags() also asserts that the VMA write lock is held for
> the VMA whose sticky flags are being read, with a comment explaining why.
> 
> Another means by which atomic VMA flags can fail to be observed is when the
> merge is finalised in commit_merge().
> 
> rmap locks are dropped in vma_complete() before the sticky flags are
> written, meaning an rmap walker can observe the VMA without sticky flags
> set, which can also result in retract_page_tables() discarding guard
> markers.
> 
> Resolve this by assigning the sticky flags before dropping rmap locks,
> factored into commit_sticky_flags() with a write assert on the VMA being
> written to.
> 
> Also remove the vma_set_flags_mask() invocation at the end of
> vma_merge_existing_range() as this was introduced by commit
> 64212ba02e66 ("mm: implement sticky VMA flags") to propagate sticky flags,
> which is now redundant with the introduction of commit_sticky_flags().
> 
> The vma_set_flags_mask() invocation at the end of vma_expand() setting
> sticky flags only is also removed for the same reason.
> 
> Also update vma_merge_existing_range()'s comment to reflect the fact that
> vmg->vma_flags gets updated.
> 
> Finally, update the userland VMA tests to reflect a previously missed
> const-ification in vma_assert_write_locked() which would otherwise cause a
> warning when building them.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
> Fixes: 49e14dabed7a ("mm: set the VM_MAYBE_GUARD flag on guard region install")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro

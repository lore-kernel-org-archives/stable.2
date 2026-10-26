Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027671;
	b=x99wxkc+/5AjG/78KNln4P+BHgUeMDc9neP/xhM3TD6j2sy7LmLcH1YLe43S8/c+pheX
	 z7oNkYMMin3B6s3gjlUYftZAJOVS8ZK1MghMxSpdF/oLGbj0DYj3Vy+NiukeTci8vJtk4
	 2UU9pEcPCxd8KGu7p8lxqnAn+ufheld7tdYHMw6FIzkEAGCd93CTB96dh1j+m20/g+XK0
	 X8JBnOvoXsU9Xf72Sk9oKsYdGLR5QOTzB1p4JeMiFAylq1GJSQ9xbra4HY25kRhLH7hbm
	 97bVhcr4NcK3BgpcSuF1jMUTcbEf1MCnSFM8XPbgAuyooz4EeJDTBeYA37RoYSgggIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027671;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=A390b+RkOufGHgkEjGHNdu4x5HPryHev6YTwANlMKMQ=;
	b=hKk0TfSWo9ixnSzfm9vwZlSuCXZZALitNCsIOG2kEmiGTcBkt3qp5BNaiTw2tK3qkaI+
	 mBuQAOflnJaVk2e/6Qs+zl6W5fI1FNvSXPSxtCwGQqzGGAUT+U3bX1fZFcAN16iqHhNFb
	 OlRErl4Gwm8l75rCkJvA7ATjf2gAYVMce1ZgsBr86vGuhPAqG3LatkujsPQxj6J0kjoda
	 iF9RUeRAm0czdoofvySDmLWO8S8+YY1c/5b+k3UpwKuznrGbZokfALnC6XYgma5mVCLir
	 f2O7gQwb+2ImMfKWrdZw9yDFjdH4tzhvkGeSpCDveb9zGeHzNgP3Gy+az9HKUnJPFJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=okADKsBv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ookcr4Qy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NTS9H0Uy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SUx3dPdq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B9606A31A;
	Mon, 26 Oct 2026 15:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=okADKsBv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ookcr4Qy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NTS9H0Uy;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SUx3dPdq
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D120E2211D;
	Mon, 26 Oct 2026 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793027669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A390b+RkOufGHgkEjGHNdu4x5HPryHev6YTwANlMKMQ=;
	b=okADKsBviTfid89FMXFeDRM8EJUw2C1sWJJZsEVk7e0Vp6e06w6ck7+oj/pPwrvx4ReEZ3
	ksVnr5glsgNqQYJORiKjtUBTqLyKtllbDhqI6gb8wMbpF4uoOoTtROHFykZRvn6xy7Ii1+
	893dfVR+HmLQoRle1prQpmyfkIJnyuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793027669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A390b+RkOufGHgkEjGHNdu4x5HPryHev6YTwANlMKMQ=;
	b=ookcr4QykwNQ/NdHhJtHrMhKMqk8N8I3PNoeVCAkMeHDR1+iwHGIpvEveVWMzU7bpheFmh
	Tqd1TI8QhJZGaaAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NTS9H0Uy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SUx3dPdq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793027668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A390b+RkOufGHgkEjGHNdu4x5HPryHev6YTwANlMKMQ=;
	b=NTS9H0UySzS9ohriVwrte8GIrkpmqPVao+ls8fqbTdVt+2Cti+LmXhgtEvZkfiZ3FiOAXC
	hhUa2nQuTa4BnSb/Kt2ycb1UvqqLdmCwfYTnkDG3ylaRzi+n1kiApPUb0Kgl6aV7k2Qmsz
	UzGTb5EuLDysD4D5mYCeH4UuSIiVIDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793027668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A390b+RkOufGHgkEjGHNdu4x5HPryHev6YTwANlMKMQ=;
	b=SUx3dPdqUjrsTRC1YkBdtvGKZ00LIIvl+tZJjwjXt4yQ/6fIMG3MIODzRNmiojpszCZsqg
	QsFMQv9KynNVxuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B4613408;
	Mon, 26 Oct 2026 15:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qp7jI1Ju32oVZwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 15:14:26 +0000
Date: Mon, 26 Oct 2026 15:14:25 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
Message-ID: <at9hs0Unq0EOg2M2@pedro-suse.tail5790ac.ts.net>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gourry.net,nvidia.com,gmail.com,sk.com,linux.alibaba.com,cmpxchg.org,suse.com,google.com,redhat.com,kernel.org,suse.cz,chromium.org,linux.dev,suse.de,infradead.org,oracle.com,tencent.com,huawei.com,kvack.org,vger.kernel.org,toxicpanda.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLgmxzz5wwb987hpmihmge51fg)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D120E2211D

On Mon, Oct 26, 2026 at 10:40:39AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Once shmem_writeout() has moved the folio from the page cache to the
> swap cache, the folio lock no longer keeps the inode alive: truncation
> and eviction find a swap entry, free it and do not wait for anybody.
> That did not matter as long as swap_writeout() was the last thing the
> function did.  But since it puts the folio back when swap_writeout()
> returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
> afterwards:
> 
>   reclaim                               last close of an unlinked file
>   shmem_writeout()
>     shmem_delete_from_page_cache()
>     swap_writeout()
>       zswap_store() fails               shmem_evict_inode()
>       writeback is disabled               shmem_truncate_range()
>       return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
>                                         destroy_inode()
>                                         ... RCU grace period, freed
>     shmem_add_to_page_cache(mapping)
>       xas_lock_irq()            <- use after free
> 
> swap_writeout() behaves that way if zswap is enabled, cannot take the
> folio and the memcg or one of its ancestors has memory.zswap.writeback
> set to 0.
> 
> shmem_unuse() already added infrastructure to deal with that.
> Reuse info->stop_eviction to protect the inode during writeout. Increment
> it before removing the folio from the page cache, and decrement it after
> swap_writeout() and any attempted reinsertion and inode accounting.
> In shmem_evict_inode(), wait for the counter to reach zero even if
> swapoff has already removed the inode from the swap list. Add some helpers
> to make the code easier to digest.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() reactivates")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: code cleanups; improve description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

I've been looking at this for a while trying to get a smoother fix, but:

Acked-by: Pedro Falcato <pfalcato@suse.de>

Things I looked at:
1) Could we just drop this logic? No, it's fairly recent and seems to have
impact on zswap setups with no writeback.

2) Could we reorder swap_writeout with removing the folio from the page cache?
Perhaps, but it would be a larger change. I'm not sure if the logic all works out,
but you could possibly have a:

error = swap_writeout(...);
if (error != AOP_WRITEPAGE_ACTIVATE) {
	shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
} else {
	/* the other swap bookkeeping */
}

But I'm not familiar enough with the swap logic to reason about possible
races.

-- 
Pedro

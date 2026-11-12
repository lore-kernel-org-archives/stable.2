Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489050;
	b=BHgk0Jt7M8fA99dovybUDPl+Ar86i1FEBVYTmrrMGilEB3sTLI/8/XjuZCrsE6qqkzGE
	 veGHIyFmFJSmHBqZNuqbPjJlqNY8bgUgDiaJjo1JyGQdMAVoItkIoqfsJMBSD7qLOvgc8
	 1Roj9ITIq5yk72loLpN8OgKt6lXN18nvKNcUDKgsZQn9f0OWzAM/Zn/vjw4sFEak0xFsY
	 JQdGn3AZ9cR0JMshx7Grs2o1VaejDvGs/xQHB2Ie325FWZ2YRZCIqEBBIsW52QNvfWRmC
	 +xRhRPO9jlpSB8kLt18yqbFIgz403ODxQedY6eDfgrBMCwVYtxKRrzR1GuBLU6JQPdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489050;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=+8mRoBCnrHPzd0XMYMn4r/3hQsLQpAk4ZKwYYX5EH9U=;
	b=hydXvZJBCg7c4/pdYwHQvY00aQc5u6u649oguyKC5KdB7P42xdqi9MtqnJt2l18pJUvH
	 oW1zVELYvdhed8CuYeRlEFjpDYIZ3AmooSA88xo3qmL29TUuabXtfNU9hIuSWEgCzHrdx
	 MHgJrfc/VDjpdFZICu/HSyLCsyU0vhwqdl5W0m0Oft7HFq+hY+jepGbAJ70VyEFupEXNd
	 G2C01bcnx5mM96sePExIbQRCS7OVSpgkE6D8DGE47hw51MBVsaeYgGiyuEfJfrhoNovvu
	 rYCKc2NU3kmDIRKoHDsNHwZ13jQytzmVgOHo8rk8A62eUZ2ass+9YhopsOOCHq8imEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=khBws98a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mHH8HdDL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yudfpQVa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="7Cp2h/U/";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB296606A335;
	Thu, 12 Nov 2026 13:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB296606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=khBws98a;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mHH8HdDL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yudfpQVa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7Cp2h/U/
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F75C1F7BA;
	Thu, 12 Nov 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794489048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mRoBCnrHPzd0XMYMn4r/3hQsLQpAk4ZKwYYX5EH9U=;
	b=khBws98aZjch3SldFhWFgxIKHIoBpABBaU0SJRAUEqItnJsjesSSAI4wfIj2NbaxCEp1N7
	QKlSlgtZ5CR6TKfRKHtSh8AXrxsoc7/Yotf3B1Dj/rckCBE3u/mxRsAvVgo/OjkR+xfDA6
	AeXPIke5G4rWKyYc/F04/97pTtOxsIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794489048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mRoBCnrHPzd0XMYMn4r/3hQsLQpAk4ZKwYYX5EH9U=;
	b=mHH8HdDLqRNSqcMwIMyKygIYFS0GA5cFHrjAdNKHhRQDxU1Z7p2zWp30YXa+jvpkyL6jsp
	V/G2TP1NxsfjFiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794489047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mRoBCnrHPzd0XMYMn4r/3hQsLQpAk4ZKwYYX5EH9U=;
	b=yudfpQVaf+kxwOs+11zVQzCk5i4AUkcNOg3fl6b2qVYqM5R8F9AA+lK+1JJ1Zf/bybP7Uo
	29HyzcXedyLuhvYaIPNISzZMCr3g1bcEaGOKl1fRNcJSohuXxd1Jeue/sFqdWqMmSRFFf6
	3qdsSr2voULTS+/ciJuUBItmT5YQe/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794489047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8mRoBCnrHPzd0XMYMn4r/3hQsLQpAk4ZKwYYX5EH9U=;
	b=7Cp2h/U/VD0DipB87nndzauJZ/s+pnOBVrvC5P2Ve2lAhEszUWWwSC6LDlKKDMkRkDI9ld
	DiXEgaNGlc1cSaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E87D134A0;
	Thu, 12 Nov 2026 13:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gr4vB9O69WpOcAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 13:10:43 +0000
Date: Thu, 12 Nov 2026 13:10:41 +0000
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
	iommu@lists.linux.dev, netdev@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/9] mm/mmu_gather: flush pending references early
 before the folio limit
Message-ID: <avW6vTgrnBRn0Xnc@pedro-suse.tail5790ac.ts.net>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-3-318625d63a98@kernel.org>
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
In-Reply-To: <20261110-refcount_overflow_stable-v3-3-318625d63a98@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
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
	RCPT_COUNT_GT_50(0.00)[63];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80

On Tue, Nov 10, 2026 at 09:35:43PM +0100, David Hildenbrand (Arm) wrote:
> When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
> and defer dropping the folio references. In the meantime, page faults
> can refault pagecache folios, creating more references for the same
> folios. These deferred references can build up over multiple VMAs.
> 
> Let's just request a flush after enqueueing a pagecache folio whose
> refcount reached a certain threshold. Start flushing well before new
> references are refused, regardless of the caller's privileges.
> 
> When returning "true" from __tlb_remove_folio_pages_size(), PTE zapping
> will flush the TLB before dropping the PT lock, but drop the references
> afterwards. Refaults can still race with that, but flushing early reduces
> the risk of letting others hit the limit.
> 
> This is a temporary measure until we have something better.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro

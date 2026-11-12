Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486537;
	b=h1vO7ols53JtS06gSusi36bOyGK3hYCmZTLsgVLZdttOb4GBL3Anw20gsCLY6iH4RaOO
	 4i/s1PvH9C27X67n9fwMTLJ8zAxnrbclBqK3N18h0TjjmTeLF7+OdPfDi+zD1SDj07EDs
	 FiUTaDpOFRAPdwQKKsmWd9DmPYGko8xMcTHozhgq9WlFfUSpdOLuLeLNFjCi5lM/wzsez
	 ztGU8PvN97x9b65yHZmLC6PKfc3a1PKPo27tcj1CROKD4dlata3JM7Yga2TQgZJ+fENdA
	 6X+yLUAA7HwNqmk/1qkbxIbVQGE2p/RPEtiskKYjnvrnpYIkBKpbDiNh2fDYokX/2ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486537;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=qGWIy9jrwH5t2YwM/1gqH/yjp5nXKZYTPr3EnVErx6Q=;
	b=BqQpRhZrWmKfBY1CvFAjj0JVMlpKl6L8aXK+4BaUgO46do7nMYx5XCTOOkk++500C0uN
	 PnKjRZAVXvbWmsCvgQY/FNoAv3EDQBYwtDnBR54+AQB4o+voN0M7kGKuINzjFW9nyvGEm
	 Ya5o6rT2CXJmTb+7dOBXp6Ghec4Rgwd29KHUUI1lZLJVkpZXmF2Je/EpScG0E9ZUww5LF
	 2m0q5/sal/eg+y3uWOMmcmUvbplNVsnHalgK49EYVCbGM0aVFIew9xjj9mX/oMCAGpqNJ
	 pytZSrv3l0V8sHG5dxPey2waUJiTzuPHZN8Sunee/ww6rkfymQZYtAjD8iBICj9nQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cpLtdDDm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SDOOkIMu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cpLtdDDm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SDOOkIMu;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC8606A327;
	Thu, 12 Nov 2026 12:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CC8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cpLtdDDm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SDOOkIMu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cpLtdDDm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SDOOkIMu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDD531F388;
	Thu, 12 Nov 2026 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGWIy9jrwH5t2YwM/1gqH/yjp5nXKZYTPr3EnVErx6Q=;
	b=cpLtdDDmyE3zufzafwIxz2avs3IEH+P9VxuhjgmnooAzAhIFht1q11S8RNbPG+tWFkMs1X
	p0Yo8uTA5MjM0fcTXKw7hJYRXDHwxC8SZYUWXtZ/FGR9IUBlBe0eO0FIyNdU5n9bSJnB8e
	OMosXMbCLf0WBdQvC+SSCCoa7y9jJuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGWIy9jrwH5t2YwM/1gqH/yjp5nXKZYTPr3EnVErx6Q=;
	b=SDOOkIMuS+3Vq06vEb82CmSuINp9k+XDhDTnLMbqnXQzXgjOB+7GC+fw9pvWIgwKVdQwxq
	/vQYWUOBmpmHVABQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGWIy9jrwH5t2YwM/1gqH/yjp5nXKZYTPr3EnVErx6Q=;
	b=cpLtdDDmyE3zufzafwIxz2avs3IEH+P9VxuhjgmnooAzAhIFht1q11S8RNbPG+tWFkMs1X
	p0Yo8uTA5MjM0fcTXKw7hJYRXDHwxC8SZYUWXtZ/FGR9IUBlBe0eO0FIyNdU5n9bSJnB8e
	OMosXMbCLf0WBdQvC+SSCCoa7y9jJuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGWIy9jrwH5t2YwM/1gqH/yjp5nXKZYTPr3EnVErx6Q=;
	b=SDOOkIMuS+3Vq06vEb82CmSuINp9k+XDhDTnLMbqnXQzXgjOB+7GC+fw9pvWIgwKVdQwxq
	/vQYWUOBmpmHVABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AC1C13432;
	Thu, 12 Nov 2026 12:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lxSfOgOx9Wo5RAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 12:28:52 +0000
Date: Thu, 12 Nov 2026 12:28:50 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWw2I3Or0z1OmqE@pedro-suse.tail5790ac.ts.net>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>
 <avWtxdIHSJJ_uNwG@gremlin>
 <avWunRPQJQctsvYl@gremlin>
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
In-Reply-To: <avWunRPQJQctsvYl@gremlin>
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,linux.dev,linux-foundation.org,suse.cz,gmail.com,cmpxchg.org,nvidia.com,intel.com,sk.com,gourry.net,linux.alibaba.com,tencent.com,redhat.com,linux.intel.com,gentwo.org,nxp.com,fb.com,kvack.org,vger.kernel.org,alien8.de];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Nov 12, 2026 at 12:18:46PM +0000, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 12:17:21PM +0000, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Nov 12, 2026 at 11:21:38AM +0000, Pedro Falcato wrote:
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Thanks!
> >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 7618e72766a5..4cb18b217048 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
> > [ ... ]
> > > > +	if (mm_is_oom_victim(mm))
> > > > +		tlb_flush_mmu(&tlb);
> > >
> > > I see there's a different tlb_flush_mmu() call below (in the actual function).
> > > Is tlb_flush_mmu() idempotent?
> >
> > No, tlb_flush_mmu() is cromulent.

Naturally.

> 
> (kidding, yes it's idempotent :P)

Great! Thanks for the cromulent reply.

-- 
Pedro

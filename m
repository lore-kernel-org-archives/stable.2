Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118468;
	b=ycD/xe7/ShRYa8+jWlYHujHHpEmufh81/Qa+dBzU+U5k8roMa60kwXVxU5umAs5Nbz5W
	 fwJywk8aBjA02HzVJrIxP9a/d6IZBVennGYh1vRkDemsdQz9FXOwcVZZ1IAQUrYoPvAjn
	 +zHVJjIlpmoi7w/lhGWpfhU3XcL6jlxwYEw1yV3iOSFPYJ6w1fQYmA6CKh1nL1O2hoX/t
	 5JN2OW2PNYgda8oxrGMg7f9DwGHhnwkt67dEMNIwsLOjgZHVbR5kHz59PDCK7JgFx4hM+
	 mbGG1xNu9CJw2SmmfBNMg/jCmWcg4bgKHKUkOkn+wIVTVLtRX6/VNnq70EfOYUOOuOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118468;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=/itwoJPNV/PYjgH1tW8TC7VQ2qoANM6I5XSJVpUiq8M=;
	b=DudAcwAGfOV4cmAFqSdwslEEHeB8hANkgSGnBaCeR6v4QYVEr1IiIZdyxZdUUk2VxvDX
	 tyvi7C4BPzQqq6tep726z/SesGK1wV0089GfcYpR/IMe6FgEwnd0EuTFUIxMW0BBb/pv4
	 bSaKXwUcmR6KK1AcAFR93y7KSiu0yc5z9XA4ywkQFmJPbpg6bX3HpZa3ZrlCmqJoxSEIb
	 oIP1tTCDwAcFoS0GqjPHBzu3y5Ot2n0WPkO/RxKjbCPkVtJhWVOYi+iH5KIiHntvuK38p
	 SnzA2DmdcEYE0h/hv8mERHGJ+jsb2oCayb0VW3XABuCDhHqbKurJwr0IZO54eYnPQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Te/hFcTC";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hg+twqpr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Te/hFcTC";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hg+twqpr;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C18606A31E;
	Tue, 27 Oct 2026 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C18606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Te/hFcTC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hg+twqpr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Te/hFcTC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hg+twqpr
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B670A21F29;
	Tue, 27 Oct 2026 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793118465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/itwoJPNV/PYjgH1tW8TC7VQ2qoANM6I5XSJVpUiq8M=;
	b=Te/hFcTCOKkoMgRX5zaqYIVBggY9Fpr20ezr2tFqxNsXOnKsbQwUmmdTdAciG+uCQTDjth
	dVktrGDfybLq8FuT/n1SiYOTAsUYVXG9Sing0oS69R2+Iytv0Z/Y7lJYjwwMTzhsktO6j4
	fMoJAX/MIJCIH+SrJ4jkjDxdxSCgPWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793118465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/itwoJPNV/PYjgH1tW8TC7VQ2qoANM6I5XSJVpUiq8M=;
	b=Hg+twqprF0ocwkjIQM9VGipaZPJ1m+OpmAD+rhXe3by6Gq2PHVtPT9ufjbMIV82PfR4N4K
	l27dUCgkPKJmAnBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Te/hFcTC";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Hg+twqpr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793118465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/itwoJPNV/PYjgH1tW8TC7VQ2qoANM6I5XSJVpUiq8M=;
	b=Te/hFcTCOKkoMgRX5zaqYIVBggY9Fpr20ezr2tFqxNsXOnKsbQwUmmdTdAciG+uCQTDjth
	dVktrGDfybLq8FuT/n1SiYOTAsUYVXG9Sing0oS69R2+Iytv0Z/Y7lJYjwwMTzhsktO6j4
	fMoJAX/MIJCIH+SrJ4jkjDxdxSCgPWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793118465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/itwoJPNV/PYjgH1tW8TC7VQ2qoANM6I5XSJVpUiq8M=;
	b=Hg+twqprF0ocwkjIQM9VGipaZPJ1m+OpmAD+rhXe3by6Gq2PHVtPT9ufjbMIV82PfR4N4K
	l27dUCgkPKJmAnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1EA61321C;
	Tue, 27 Oct 2026 16:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BayYG/3Q4GpDBwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 27 Oct 2026 16:27:41 +0000
Date: Tue, 27 Oct 2026 16:27:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 35/46] mm: fix unmap_mapping_range() beyond 4 GiB on
 32-bit
Message-ID: <auDQ66Ux9eKN-Ha4@pedro-suse.lan>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-35-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-35-6f74bec9a5bb@kernel.org>
X-Rspamd-Queue-Id: B670A21F29
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[toxicpanda.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_GT_50(0.00)[65];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,toxicpanda.com:email]
X-Spam-Score: -12.01

On Tue, Oct 27, 2026 at 12:17:55AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
> made holebegin and holelen unsigned before they are shifted, by casting
> them to pgoff_t. That is an unsigned long: on a 32-bit kernel the cast
> cuts off the upper half of the two loff_t values, so a hole which begins
> at 4 GiB or beyond is taken for one in the first 4 GiB of the file.
> 
> truncate_pagecache() passes the new size of the file and asks for private
> COWed pages to be unmapped as well. If a file of 6 GiB is truncated to
> 5 GiB, everything from 1 GiB on is unmapped, and what a process has
> written to a private mapping of the range between 1 GiB and 5 GiB is
> lost: it reads the contents of the file again.
> 
> Where the range has an end, the wrong range is unmapped instead of the
> right one. The page cache copes with that, as it unmaps every folio that
> it removes. The callers which only have unmap_mapping_range() to get
> rid of user mappings do not, for example drm_vma_node_unmap(), whose fake
> offsets reach beyond 4 GiB on 32-bit, and revoke_iomem() with physical
> addresses of more than 32 bits.
> 
> Cast to u64 instead. Nothing changes for 64-bit kernels.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192713;
	b=aH1rbRzQukzBwX2Mre7XmoiDMqdb3qEXAJZoI3JM6TYAEl4riih0TjHt+eulSdc/uCci
	 nkztkU5tyIq3KlRaMbTsonn9jHBGrvUGl2AT1U4QsWRMfSeU7Er9SkUEBXwQHxfvcAd1W
	 UAUoPSVGr/s7jIUuqcJILhj6uvb/tqP7wYwePiAMdhjQfuM9yGTETqjC+KD3xF4IBKPCA
	 kMszdVFiB5lqCWIqc5UfGjNXGUcaPLnGdU98dhPm1Y4FWFMLfTCTTNB+tgbsw6fsQfpcE
	 80SY18nUZF4TMokI7lobkt7vli7284CjUx6vh4oEdExOgU42WovNwbInstr9okTHRew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192713;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=ZFm+LF82pi5PZQRWnWdZtQasBy7k0lWkzPhNGbo8lwQ=;
	b=ltfxMhAYhh/wfdmrv5030d9HbpC2XAh7Chh1eKekyCDqf22tDA5t1ccCl87JVDijhQhI
	 oJqCotneBuZCFr7+TMhJnoZsg3HHR5NjdRR2SA7CTBNHcPnSEsO8pnAgQ4b2vGGD+7I8D
	 JT2lU9zI3orMYWi/0irS0ZfhyNEQ0oZ0K7AZaX172cFnKTkKKvuVNd6WFaGPGbaiakSuH
	 L7xk2naxDndlDnPYtIQ7qmemxXw/NSM3RkQtnIeNHbqhkMFLUnMAbXpPsdliiuspnAGAJ
	 dIIUQGSSvMk+Pok8eXoO02QaJbK1NrRY8efTEnky/7EZOiiZf5o68BZpqEsAxwCQ93w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IkyIrlCN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h5eyniOO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="2FB/MODf";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4dic7x3T;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51431606A31A;
	Wed, 28 Oct 2026 13:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51431606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IkyIrlCN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h5eyniOO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2FB/MODf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4dic7x3T
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF5C2213E;
	Wed, 28 Oct 2026 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFm+LF82pi5PZQRWnWdZtQasBy7k0lWkzPhNGbo8lwQ=;
	b=IkyIrlCN7G+xZvqNgVghwMpBI8ng2bOlKjOdDzhEfMRQg6rt8YafWJYQp4jgsQ9w/lB33H
	9FBPHphhQPAOp/XOKHNr+fu5p9eYndRTrRcFNq/0Op99xtiVrbRQFMThClRVauNxgN6V6X
	wfczOgguTF4x3tTmDUcStTIG3Iah8x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFm+LF82pi5PZQRWnWdZtQasBy7k0lWkzPhNGbo8lwQ=;
	b=h5eyniOOwdXc2q7T7Pk7UL3no1bmGUgM+F/72NEfzo9ftuBZSX85MPbkgavJ2oP0IWltjD
	1iXG9iI4uKqlVkCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFm+LF82pi5PZQRWnWdZtQasBy7k0lWkzPhNGbo8lwQ=;
	b=2FB/MODfxpZ0ilwA5PHgCW7NNYtSrq/W5boCvDL1GRtYqDPKkanrGQkl2gpE9zCifdCSBB
	nXXGSTtLKo5Qg9iFAVvIlvlt2JPsj5aQlGkeHsfbUV/bRZhcWaORCRSTbSoRnb8rfrtgqf
	Zw/R3EHhTn49+ohBRC96Ycd2MjnI+KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFm+LF82pi5PZQRWnWdZtQasBy7k0lWkzPhNGbo8lwQ=;
	b=4dic7x3TPMbFvoBJ+if+DDgdTri1Ltf7/N9AT6Le0B5ucrxb0ojV3Z+Ip1NOCne3m0B14q
	S8AEDvM3JKZPQnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FA2E13419;
	Wed, 28 Oct 2026 13:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Zm8CQHz4WrpIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 13:05:05 +0000
Date: Wed, 28 Oct 2026 13:05:03 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/46] mm/huge_memory: properly handle refcounted PUD
 mappings on fork
Message-ID: <auHy17vcHxNIAlCF@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
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
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Oct 27, 2026 at 12:17:31AM +0100, David Hildenbrand (Arm) wrote:
> copy_huge_pud() copies device-DAX entries without taking a folio reference
> or updating mapcounts and the child's RSS.
> 
> For example, MADV_GUARD_INSTALL sets VM_MAYBE_GUARD on a device-DAX VMA,
> forcing copy_page_range() to traverse the whole VMA on fork. Any remaining
> huge PUDs are then copied without accounting for the new mappings.
> Unmapping them in the child decrements accounting that was never added.
> 
> Use vm_normal_page_pud() to identify refcounted mappings. Take a folio
> reference and add the child's PUD rmap and RSS accounting before installing
> the copied entry. Pass src and dst VMAs consistently instead of src and
> dst MM. Move the TODO.
> 
> Fixes: aed877c2b4257 ("device/dax: properly refcount device dax pages when mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

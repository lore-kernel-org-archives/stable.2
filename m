Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194021;
	b=lsPuKrg9tWh6dNLWnddSvvUbnunCIt7XfLv9KK8y2FfKZ1jDyPtHk8BwH23SllqH4Kn7
	 H5AgmLEmE/s18/oHr+qEBRls/9twT8eejjU8LHMPnZhd7smtGmtDhmO9mCVZgJWhKWJli
	 TiQDCZN7qu2KEcMOUMslCEc3XcjiLDk+74pwNw18G14q0w3zTtz3BosBKUHW8HzIcFZe7
	 0GtIoR5zM4VYxNIq3LDvCy9dWmosqGciSmq9lVBwFb3hGdjJk+eXNU1j+GMI+N4PhGwJQ
	 tsn2rTem6/wa26CpXmczfn5EpImj/qu0PSAScfMyVJ5uwGD17u5DTS/kOrOP9A81QvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194021;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=Gbg3rAkaJieZrLUAH3flPys0KLppPQxSh26pBiYtSeg=;
	b=FA5EEYZSvKsX+mEPs7XRJoYQMIF7R1on7X5SrrP83jdoBSFIDJQnYQwqBxBB6FEklhoR
	 Pt1NXZ98GhQLZy8AGuCzdabkq975RnUtClM5FCBUwL7JdQDRNivVvJbIo7C0PlvAx1Ap1
	 MeYvIQPSuDsIIoJ2lM7yPR29fiO91EtmUvkXRAOsTz0zE9whKg+s2fgPL48ykzE/hJDEu
	 zuw0dbmHQ+SUYZgqH9vceaHCmpsgwwrfaf3V5/ya6g0Zm+ywNCluMu3AnacSdGZ1H4Q39
	 OaxP4OcIkmO3GYm4c+JLRpIpcB9MIxKcNpr3tZ8uYd53vHQ3Wog/F2PUc++OufhkI8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s5toU3II;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6UsZQgGZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s9543PU+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QcUqJ5OS;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0B606A31C;
	Wed, 28 Oct 2026 13:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17A0B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s5toU3II;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6UsZQgGZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s9543PU+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QcUqJ5OS
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6C701F7B8;
	Wed, 28 Oct 2026 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793194019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbg3rAkaJieZrLUAH3flPys0KLppPQxSh26pBiYtSeg=;
	b=s5toU3IIDlHCPW+HgQHPginjt8csZCKinyyx1fKRGZ/uiwlPWB5XPE3nfYHV6X+hyj85hY
	wHZosPWDzohQPwvC6P1gQEnpsu0UZwWQHCFCaA4QT/drpsabPmbjxrYFH6nejt03TSShEz
	LO6gTlSruGI0JRlVm9ANkaatF/CRhTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793194019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbg3rAkaJieZrLUAH3flPys0KLppPQxSh26pBiYtSeg=;
	b=6UsZQgGZ9hEZZAWlOkKq75kVznhmh1sh15//5Z3I+gr8cWfD4mRqVEuTlIQyg5SwiV16WW
	EPD4qFb8zNGjeyDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s9543PU+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QcUqJ5OS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793194018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbg3rAkaJieZrLUAH3flPys0KLppPQxSh26pBiYtSeg=;
	b=s9543PU+5+yZIsAmIvMnVbYZDH9U5m5AlL0Tgdp+ajgDcFY95LzLkOxoC1JHbFPhRc+EUu
	Eue9APZJ8A3c/p/AiPnvaIoRMZRRAoIz4ptt1KGvUZgtz9ouvfTFIbX4T6iYDTkuPtrhQS
	AcmCsPO/PLg3GvdG+OoDIIfEZBXkgCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793194018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbg3rAkaJieZrLUAH3flPys0KLppPQxSh26pBiYtSeg=;
	b=QcUqJ5OS7+zDu+FcPbnwMHqPF7DtIH8TA00g54/gLqEJVUZaEccDQ85X5BHLnef5O6sAL9
	FUpYCRapszkkRfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B355213419;
	Wed, 28 Oct 2026 13:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kSoIIB744Wq5NwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 13:26:54 +0000
Date: Wed, 28 Oct 2026 13:26:52 +0000
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
Subject: Re: [PATCH 30/46] mm/mremap: recheck PUDs under the page table lock
Message-ID: <auH3yLClSjgVAIdW@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-30-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-30-6f74bec9a5bb@kernel.org>
X-Rspamd-Queue-Id: E6C701F7B8
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[64];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.01

On Tue, Oct 27, 2026 at 12:17:50AM +0100, David Hildenbrand (Arm) wrote:
> Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
> clear a leaf between the lookup and the move. Holding mmap_lock in write
> mode does not prevent this.
> 
> If the zap happens before move_page_tables() tests the entry, an empty
> PUD can reach move_normal_pud(), where pud_populate() turns it into a
> present page table entry. If it happens after the test, move_huge_pud()
> can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
> warnings on powerpc.
> 
> Recheck the source under the page table lock in both helpers. Treat an
> empty source in move_normal_pud() as a completed move, and use
> __pud_trans_huge_lock() in move_huge_pud().
> 
> In the future we should likely have the code lookup a PUD/PMD lockless
> once, instead of multiple times, because one of the problematic bits
> here is the:
> 
> 	pud_trans_huge(*old_pud)
> 
> Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

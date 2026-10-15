Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCC3B2D0D;
	Thu, 15 Oct 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086884; cv=none; b=HRBkTvswg15PtVZ4OiyGqTkF8es/Wx7ozxrYgX2IghdLXKBhMZSnJ/hoSrDevxh6c18QrdJcAdR3oqkGNs4fs9udjEz//hrXMURVNbp3QRWmjIv5Km4i7rGeJDcvNKDZJWGLds2DcWKD/J9s8w3spe5L9rvFYwIWggA7Hfwiht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086884; c=relaxed/simple;
	bh=ZjXSCzqksHcLTG5oc1+4fUUYcNegUbxI3yrjKqdg17I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1M7VnQjswa6mf5xieCm/7r//u6q4TJfxcI+IzzVByxVkchDNmTRP8dZfZyfjjKbscX2CNZJepH43rI7luav/cPsVHWgfTE5g6J3FCCVBLk9YuyH0MqSbQq905uT4gFgOAk8Pf3IHJpH71OBnNurnN/fBWCjdfNO/fAlEGa1gsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eXpwTksI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTxD0LdA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eXpwTksI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iTxD0LdA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eXpwTksI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTxD0LdA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eXpwTksI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTxD0LdA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02F50223AB;
	Thu, 15 Oct 2026 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792086876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUX/20c9gzfr6HYGt27BVt9vlp/ySlxzUbbSfr+xZUI=;
	b=eXpwTksIT9/Go1ofbOmdU0GZvbkw5AyX5pLHwi+2EKjRB6sOz9eGvgakUD8O5a7D5/19ut
	4nm4lk/n01AwoZscIQIgq0wHxQNi5kf0X7qhAhpzIZHgiY2Hw2yiLHg2d/EG4MV5CfmS46
	FvzsWCQrEs3nPP7g/iIOz1rWsSk8mo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792086876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUX/20c9gzfr6HYGt27BVt9vlp/ySlxzUbbSfr+xZUI=;
	b=iTxD0LdA1j7nQ1dEwmMrePAU7KHf4w37NgNPespccr/3SWDTWNo2jSNk71iguUOzjHCTXZ
	2jnCQ36Nk+Cbh1Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eXpwTksI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iTxD0LdA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792086876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUX/20c9gzfr6HYGt27BVt9vlp/ySlxzUbbSfr+xZUI=;
	b=eXpwTksIT9/Go1ofbOmdU0GZvbkw5AyX5pLHwi+2EKjRB6sOz9eGvgakUD8O5a7D5/19ut
	4nm4lk/n01AwoZscIQIgq0wHxQNi5kf0X7qhAhpzIZHgiY2Hw2yiLHg2d/EG4MV5CfmS46
	FvzsWCQrEs3nPP7g/iIOz1rWsSk8mo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792086876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUX/20c9gzfr6HYGt27BVt9vlp/ySlxzUbbSfr+xZUI=;
	b=iTxD0LdA1j7nQ1dEwmMrePAU7KHf4w37NgNPespccr/3SWDTWNo2jSNk71iguUOzjHCTXZ
	2jnCQ36Nk+Cbh1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F6413223;
	Thu, 15 Oct 2026 17:54:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p1Q4L1kT0WqZYQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 15 Oct 2026 17:54:33 +0000
Date: Thu, 15 Oct 2026 18:54:32 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Adam Litke <agl@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
	Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/vma: don't leak the commit charge on mmap
 failure
Message-ID: <atERwRzzAdCSXaPM@pedro-suse.lan>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,google.com,linux.dev,suse.de,huawei.com,gmail.com,us.ibm.com,csn.ul.ie,surriel.com,redhat.com,toxicpanda.com,kvack.org,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,toxicpanda.com:email]
X-Spam-Level: 
X-Rspamd-Queue-Id: 02F50223AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, Oct 15, 2026 at 06:07:07PM +0200, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When an accountable mapping replaces existing mappings (MAP_FIXED),
> __mmap_setup() only charges the difference between the size of the new
> mapping and the VM_ACCOUNT pages it replaces. It then zeroes
> vms->nr_accounted so that unmapping the old VMAs does not return their
> charge, which now backs the new mapping.
> 
> If the operation fails after that point, the error path returns
> map->charged, i.e. only the difference. By then vms_clean_up_area() has
> zapped the page tables and closed the old VMAs, so
> vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
> finishes the unmap with vms_complete_munmap_vmas(), which uncharges
> vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
> never created, and the charge of the old ones is never returned, not
> even when the process exits.
> 
> No privilege is needed to hit this, only a file whose mmap hook fails,
> for example a socket (sock_no_mmap() returns -ENODEV):
> 
> 	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
> 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
> 	     socket_fd, 0);
> 
> Every iteration adds len to Committed_AS for good. With
> vm.overcommit_memory=2 this lets any user make all further accountable
> allocations in the system fail with -ENOMEM.

I don't think is urgent nor does it have security implications. You can
already broadly screw up the system from any user when overcommit_memory=2.
This just goes around the single-process user_reserve_kbytes AFAICT.
Am I missing something?

Just looks like a good old bug to me.

> 
> Once the new mapping has taken over the charge of the mappings it
> replaces, it owns the charge for all of its pages. Record that in
> map->charged, so that the error path returns all of it.
> 
> A failure in __mmap_setup() itself is not affected: it happens before
> the charge is taken over and the old VMAs are reattached with their
> charge intact.
> 
> Original fix generated by an LLM and sent in private by Josef.
> 
> Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: call variable "uncharged" and make it const, adjust/simplify comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

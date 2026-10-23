Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775370;
	b=oekEQanjn1Ur7127QsvdP9IO5deqLYETIEJGXgT0+i7nTnB6iamqY9/1TeGKWpliguII
	 z2YNeX60UarWSVeWvhD7dP9k+dl4oILaNQAMjbyG6X56I8j/76XEPR70Yh807mGOw9Iie
	 JWls9Ap0qLIkioWp4AxAFNCzHzUJM9bXJ0U0aCUgJh7Q/0mNvMiiJmHONnA8zigRZ7UlJ
	 x5MyVhtZc+y3XGfDBE3lqsqbjx7/SyUcF2xJn5RHuAIzPU6NIkF17K9yL/2kLtL3ZRVI1
	 l48/swqfW7q5J7mzFYjAddSNw2B9nAMUyH90XWgxxoNmVmXOavE1OHjeEj8PWgbd9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775370;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=67SB6LSP3YZL4fyvJpHJjL1fYzDhmkmSaoMKutRzZoQ=;
	b=zDeHk3vLiPvIGTaC5/imGzCb4FpPo5o9iEik9Nj7iILJCU/3ssSr4RG/dQLdrd707g+q
	 GnWMcrcp7I1tNMuv5qMNt0C0ukrhJt7L3T/IkcBbbCpDSI3FLtLMCgM7xFmZxqTgnBpKc
	 cCJ1kjDZ/pDEJllyNYQmE3tcYgDO0GDz9mx2DTTLor9O2i5XR4yrwUuQOsdnkpaW0aQNt
	 0eGDeRCz6xwoFpze5BC7Ps5FNZc2RP3aqLkeZGAs9LiiL5cWqwfQx3+zh5ev9iScfdHm6
	 7//h7JfIPvonSNYa11Il414UyPHatGPUXF1s4L7Sjf9kL5s5tzgPA811oyguKwKLGWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWueAitF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73hMXDMw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=crw8ZLd1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrNmMXSe;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F1606A31D;
	Fri, 23 Oct 2026 17:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWueAitF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=73hMXDMw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=crw8ZLd1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrNmMXSe
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E866622166;
	Fri, 23 Oct 2026 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792775368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67SB6LSP3YZL4fyvJpHJjL1fYzDhmkmSaoMKutRzZoQ=;
	b=HWueAitFYISYzSNe5YnyHEb+shlX8K0h7k14BJhPzBH/7EB9lkaz+S2WIPLskS6loSJdvG
	aUR2ufGJE2HCFhRI/neX9GOF9E09SUh5tnsRlHnKP1mp+RBxUigYVFk6x5H30msdd6hprA
	ONLQlbOaGFyv52ucs7VwuxW57NFz6rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792775368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67SB6LSP3YZL4fyvJpHJjL1fYzDhmkmSaoMKutRzZoQ=;
	b=73hMXDMwt6yPnVFNBXW0a7ItPpJrVM58oXKVcgDoYb7sxilADmqvuSH+mahIreGVj6Jc9q
	DZxK56TCIadLHUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=crw8ZLd1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WrNmMXSe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792775367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67SB6LSP3YZL4fyvJpHJjL1fYzDhmkmSaoMKutRzZoQ=;
	b=crw8ZLd1JuBzD5b00IiO2YPRlqnKODD6XVDQYYxA0MbIaeiiuNmVOd33K2W5PuP2/KhWA0
	gxHjIOwJ8JSjW5xzj2TcHfbTtyMraZ7Zxxnr53lmvy6LxIdq65njQzO/gIPfcdBlyyHJoD
	o1owhOMYE6Es66BCTMUp+MNFTxzXdHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792775367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67SB6LSP3YZL4fyvJpHJjL1fYzDhmkmSaoMKutRzZoQ=;
	b=WrNmMXSe/Xxlt29YJzdzeNGaBcxolLMTBpi/xUZp2whYbFL/dMDg3iXMI8VskPLoPLwsIS
	LBorCiVjxe0EWxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F175C133F3;
	Fri, 23 Oct 2026 17:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0J9gI8aU22oYMwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 23 Oct 2026 17:09:26 +0000
Date: Fri, 23 Oct 2026 18:09:16 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: Re: [PATCH] mm/mremap: populate calculated fields in vrm state
 correctly
Message-ID: <atuUijJitqDu00ZS@pedro-suse.tail5790ac.ts.net>
References: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
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
In-Reply-To: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
X-Rspamd-Queue-Id: E866622166
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Mon, Oct 19, 2026 at 03:28:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> Commit d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
> introduced the vma_remap_struct helper to pass state sanely through
> mremap() logic.
> 
> Part of this state is vrm->delta - equal to the absolute difference between
> vrm->old_len and vrm->new_len (the old and new lengths of the VMA,
> respectively).
> 
> This value is used to correctly charge accounted VMAs.
> 
> When shrinking a VMA, mremap_to() sets vrm->old_len equal to vrm->new_len
> having performed the shrink of the VMA first, prior to any potential
> move (e.g. MREMAP_FIXED | MREMAP_MAYMOVE specified).
> 
> However it does not recalculate vrm->delta, which results in incorrectly
> overcharging the VMA.
> 
> The charge leaks to Committed_AS globally, meaning a mischievous user can
> cause allocations to fail across the system in strict overcommit mode.
> 
> Resolve the issue by abstracting the update of vrm->delta to
> vrm_populate_calculated() and invoking this from mremap_to() when
> vrm->old_len is changed.
> 
> Additionally, update vrm->remap_type whose value depends on
> vrm->delta. The field is not read again after the shrink, but it is the
> logically correct thing to do and protects against future changes which
> break this.
> 
> Fixes: d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
> Cc: stable@vger.kernel.org
> Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Closes: https://lore.kernel.org/all/20261017233527.797191-1-nickolai@csail.mit.edu/
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

As always, thank you for being so responsive in dealing with AI security
reports :))

-- 
Pedro

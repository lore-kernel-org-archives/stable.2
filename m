Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021330;
	b=v16Bq2INFhTKNfax/15ewHwFo7YCOzX4GVPTCeeTXfPstz+ip3mx3zpCDMxPkHEKu4zF
	 8/JxmB2NLzuW1PgCFkY+Hn7a+Er00/+Gyou5/T3DnbT4z6xf9RQjne8SQy99lHbW2BVMO
	 IYozM2/HYCn5wG/ryj3nGDyIRWyhuANbtfBnfH6gT+8qlgHMTI1MdQsGzJohRmWAq1RwK
	 CREfbpQhRexLQ0tkqmCBSWAZgep7bTluVIIwICBKpUKPBqOG56He9ox8M/j0I9mAU2Ytq
	 7bQ1/dGBsY5hW6RH5G6W1/h6DaOl0F8vgrdfOjsqjAOlhFhQLdQWhipHzz9VnZyLYig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021330;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=oty3F1v8cHRij6MsFcAkM4dOfnw3za3E009u5RN2KoY=;
	b=bY3Rpxe7eUAI0rED8Ch7dMosHgXAOHz8zEWwd0KqC8Of6olys93p1mQ8HozoMhsy5qze
	 SVVXKTt9jYX2O70WFoGs9ZijdfXPWO8vogRNJ/DAhDkCLIhv8g8afVQSJy/wf/ogmQfc1
	 UwDN4dNWZcEKP0QFCQ8pFCoUqPdv3D+zrLDMY0IntWm90Q8q0NtnRNl7oNW1vHg1hBNi2
	 knPAsF1b7++RWi8OnVKLUITsGk6A5wJ1bYfUkbL2IfbeIIhnAYLDc1+c/ixv4JOAy1Lth
	 H0xtKZwhrva1oHshK4mkkgaOofVYElOVCVjT3ZZ15Ic/E43TOdT6HIa+eD4fZ7XQjgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IrNCpGg3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evaYlFvL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IrNCpGg3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evaYlFvL;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3F606A31A;
	Mon, 26 Oct 2026 13:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IrNCpGg3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evaYlFvL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IrNCpGg3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evaYlFvL
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 144D91F43B;
	Mon, 26 Oct 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oty3F1v8cHRij6MsFcAkM4dOfnw3za3E009u5RN2KoY=;
	b=IrNCpGg3PmRU3tVVIsdu920TKWXWQhTySyyL3oNlqSBN/yPWpGeH+rCVlsGISw++vDmtKK
	KfDZkTFyGrDjqMcGOxfaU+DhRgk0cju6QATu6wElZ1cJap3WN/4F5MqjDnIndqQ/lF4AWp
	Nkn7vrFk1EPUDNhaYZnjU2MyN8yfeOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oty3F1v8cHRij6MsFcAkM4dOfnw3za3E009u5RN2KoY=;
	b=evaYlFvL3iFuuisfPphGwmzMbdy5aGQP9Hy+/2QZ42qhcYVNFO8uW+cgQaAGynniU1GyFh
	x2VCs6PXZhvIESDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oty3F1v8cHRij6MsFcAkM4dOfnw3za3E009u5RN2KoY=;
	b=IrNCpGg3PmRU3tVVIsdu920TKWXWQhTySyyL3oNlqSBN/yPWpGeH+rCVlsGISw++vDmtKK
	KfDZkTFyGrDjqMcGOxfaU+DhRgk0cju6QATu6wElZ1cJap3WN/4F5MqjDnIndqQ/lF4AWp
	Nkn7vrFk1EPUDNhaYZnjU2MyN8yfeOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oty3F1v8cHRij6MsFcAkM4dOfnw3za3E009u5RN2KoY=;
	b=evaYlFvL3iFuuisfPphGwmzMbdy5aGQP9Hy+/2QZ42qhcYVNFO8uW+cgQaAGynniU1GyFh
	x2VCs6PXZhvIESDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3850A13408;
	Mon, 26 Oct 2026 13:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KpbhAI9V32q2dgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:28:47 +0000
Date: Mon, 26 Oct 2026 13:28:45 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Luiz Capitulino <luizcap@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Message-ID: <at9VEGvlpDwiV1tx@pedro-suse.tail5790ac.ts.net>
References: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
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
In-Reply-To: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,google.com,gmail.com,kvack.org,vger.kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Oct 23, 2026 at 04:17:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
> merging with expansion of mremap()'d VMAs, however it also unintentionally
> disallowed the expansion of unmergeable VMAs.
> 
> Previously it was possible to expand a mixed mapping which mremap() had
> already ensured was a legal expansion.
> 
> This is clearly seen in the mremap() logic, as it checks
> vma_is_fixed_mapping() to determine legality of an expansion rather than
> vma_can_merge().
> 
> Additionally, copy_vma() allows for a failed merge to result in a new VMA
> being instantiated if MREMAP_MAYMOVE is specified.
> 
> However, this is not attempted, as a failure in vma_merge_extend() is
> assumed to be an -ENOMEM failure.
> 
> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
> and/or expansion, resolve the issue by invoking vma_expand() for
> unmergeable VMAs there.
> 
> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
> This provides double insurance against broken changes in future.
> 
> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
> redundant in this case, as a mixed mapping is not subject to khugepaged.
> 
> Also update the VMA userland tests to add a required predicate.
> 
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

As much as I think this is smelly and filesystems really shouldn't be
using MIXEDMAP:

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

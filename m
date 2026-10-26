Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019430;
	b=yePU38qN/vNUSN6T0XpyiNvRer6SGwEbe2yy/uojRiinElYwxGV3g3/sPXT2U4urUUkk
	 j70Ua1qmmjqBEUrSrPZ+dGXiIkpIO58R4Czp5q8X59VOMYS/0ybJFd9OMEnAsvC6r9kXP
	 T7+5DBy8X9cURfXXoc4sG0oO26OxzciqU6g/elI8NL1dgWpbJ/+jvZzTqklyGT30UElxI
	 xFDxi+vnQyf18+dcu+ll2rFhKGawsn7lDvo8D2HmpvOxD4K2RspS2WwBCBhpj+au8G9C9
	 hjaCvbPpBf+7gaDsacZ1VpqB0JZTtjIIIFlEyMQZE5132jlvVX5kXHC9bXPCCk9xawg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019430;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=rtIcRoPsuzvE303euSvkccl6Hv/dLG7a9Be0HhrqmYI=;
	b=dB45kFwQS4LP7KgXqIT3R97L8o1aI9NzgEuOF7ZP0xHcexF4T/Td0Kao3j5SkxUvP/t2
	 VIjrKsh1K5XsbIqYiZY70gzRElomQrp2iUhju700rKgsSbq8tvNbO0ObSio7sfJDwkiLa
	 6DC4d3/MxovNQgZvvbHPlbNsGaIPIWVqOKCsoePEQo4k7R28yZHuDz9YeO7MFm/OFT0/x
	 D5tOc+tm2Gd625euFNYW7limuH0GBXcsDQ12TVTeNHQTKWEyAQZlkOIAmyuf/OLp2aAy5
	 UZpbIBFot9wfpFVOMRnrEs7eAFv8LgAF+X16yBV/dVmzs+EMeAd5Il1IiJ5DUW1gEkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gC3U5SKs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FQwhEslu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gC3U5SKs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FQwhEslu;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376F606A31A;
	Mon, 26 Oct 2026 12:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B376F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gC3U5SKs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FQwhEslu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gC3U5SKs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FQwhEslu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8EB21F46E;
	Mon, 26 Oct 2026 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793019427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtIcRoPsuzvE303euSvkccl6Hv/dLG7a9Be0HhrqmYI=;
	b=gC3U5SKscHPXg8RjeWwr3oZamighRtqxYQRxVNIjY/Y6YK8s6TQqmhGyALsdAWqI8ejswA
	T+rG5lmAVGUtVhaN/yYAcLf4QrIQObD0vS4ju5KSjgp0or4xwNEXd04cxTcIUKXOcdGriZ
	ococ2Hfp6IrF3/SNKrEO3nZKgi8u8PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793019427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtIcRoPsuzvE303euSvkccl6Hv/dLG7a9Be0HhrqmYI=;
	b=FQwhEsluY/yj6aGnxk6vNIjdQg6JMSvTMi1YubrRCm6nbZKeGaLY7aLGkcZyAfsEiVUZ4Y
	oZhfSEg8RUKZwjDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793019427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtIcRoPsuzvE303euSvkccl6Hv/dLG7a9Be0HhrqmYI=;
	b=gC3U5SKscHPXg8RjeWwr3oZamighRtqxYQRxVNIjY/Y6YK8s6TQqmhGyALsdAWqI8ejswA
	T+rG5lmAVGUtVhaN/yYAcLf4QrIQObD0vS4ju5KSjgp0or4xwNEXd04cxTcIUKXOcdGriZ
	ococ2Hfp6IrF3/SNKrEO3nZKgi8u8PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793019427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtIcRoPsuzvE303euSvkccl6Hv/dLG7a9Be0HhrqmYI=;
	b=FQwhEsluY/yj6aGnxk6vNIjdQg6JMSvTMi1YubrRCm6nbZKeGaLY7aLGkcZyAfsEiVUZ4Y
	oZhfSEg8RUKZwjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15BE513408;
	Mon, 26 Oct 2026 12:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eyl2MyFO32rLVAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 12:57:06 +0000
Date: Mon, 26 Oct 2026 12:57:04 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
	Colin Cross <ccross@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/vma: write lock source VMA before duplicating it
 in __split_vma()
Message-ID: <at9NKAYk-W7PhlGu@pedro-suse.tail5790ac.ts.net>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
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
In-Reply-To: <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Oct 23, 2026 at 02:47:28PM +0100, Lorenzo Stoakes (ARM) wrote:
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> __split_vma() duplicates the source VMA before taking its VMA write lock,
> and until the VMA is write-locked, a concurrent thread might set
> VMA_MAYBE_GUARD_BIT, resulting in the duplication missing the flag.
> 
> If this happens, then fork may fail to duplicate guard markers and, if a
> file-backed mapping, THP collapse may also discard the markers.
> 
> Resolve this by taking the VMA write lock before vm_area_dup() and, since
> all callers of vm_area_dup() now hold the VMA write lock, assert that this
> is the case there, and add a comment to explain why it's needed.
> 
> Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ ljs - add VMA write assert in vm_area_dup(), commit message touchup ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro

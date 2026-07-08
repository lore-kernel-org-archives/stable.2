Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E70345725
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521615; cv=none; b=VRWFAAO3qpIBTbijhwHkc+1n+b/ain3mGGfE/JiKukM7hKkKz1DuSA1T6fMxDcq8leuZE8PLYBYhb4T/3yr3ltIbsPJWAVzraxc2w+x+LZks/91kwKDXfvKe0pEWhrWcvq0KT9sDrzgNtiZtYXCz1D8Ki8hCo5LUVNpOOIx9X0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521615; c=relaxed/simple;
	bh=yuUVo46TPY5851lOHKupGp3FOepxlvwfEUBm91MEh4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3LOdpUHp5MRqcFKh6Ol4K3Xlu6d/TUdh1EF34YgiN8cTGsukQ9tRYrFo2cSfJ9IMuIhUXYfxkcHumeXBTbzAjXZB0YbisBdxXvIw2cfXuiKfr+APjcVHfn5qdGRqrNpi1gMilBU5V3l2lxXfosYx8KQggolLcDg4gY93z7MnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6mCiXdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8N9SpLHj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6mCiXdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8N9SpLHj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x6mCiXdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8N9SpLHj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x6mCiXdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8N9SpLHj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A2157590D;
	Wed,  8 Jul 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783521612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=x6mCiXdNKicWFg2CWsB0PFahRQukGvEJqVl0pHyQO8vxsIq4rWrrJ0uTtGc3978stNW/tD
	QBGGLFNiFo+QM2KbLpRE2FjKeyWqKBIiXRa1qlnbqSDjGv7/YoP9m0ooYH8RZEu4nSIndW
	x6fDIgJoc+sEt7PKUCOrW1uQaZLASew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783521612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=8N9SpLHjhnDgpzT3KIggZCKa66Eeff4e1lNIH0LMvT/rVyhaaL6FBbW68MUOHw6ju+8Su6
	JMfdF9zbYgVyJeDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x6mCiXdN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8N9SpLHj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783521612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=x6mCiXdNKicWFg2CWsB0PFahRQukGvEJqVl0pHyQO8vxsIq4rWrrJ0uTtGc3978stNW/tD
	QBGGLFNiFo+QM2KbLpRE2FjKeyWqKBIiXRa1qlnbqSDjGv7/YoP9m0ooYH8RZEu4nSIndW
	x6fDIgJoc+sEt7PKUCOrW1uQaZLASew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783521612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=8N9SpLHjhnDgpzT3KIggZCKa66Eeff4e1lNIH0LMvT/rVyhaaL6FBbW68MUOHw6ju+8Su6
	JMfdF9zbYgVyJeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A099D779AE;
	Wed,  8 Jul 2026 14:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9OPdI0phTmqNDAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 14:40:10 +0000
Date: Wed, 8 Jul 2026 15:40:08 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <ak5g9h3FuVn3bZ1G@pedro-suse>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <akhYu66GmjyM8l6a@casper.infradead.org>
 <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A2157590D
X-Spam-Score: -4.01

On Wed, Jul 08, 2026 at 10:05:43AM -0400, Gregg Leventhal wrote:
> Hi there, just checking on the next steps here.
> 
> @Pedro Falcato Are you currently working on this patch (mentioned
> above, re: holding invalidate lock), or are we perhaps stalled on
> something?

I was waiting for some actual tags from people, but given the comments and
no tags, I'll respin a v2 before sending to Greg KH.

-- 
Pedro

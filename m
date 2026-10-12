Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D73C13E5;
	Mon, 12 Oct 2026 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831747; cv=none; b=sJMOlo3j96kzWvsvjl/tRyuNTy++BcestbNV6Ax/pjMxp+nPZxmJ41iPWOm249+rVpBr3veLMwvi55TOCF9NYS5kuPZ79AFInBR+n+lmta1IT5Ydiw1IMDAaAQLcUGYdtsjWXvBBO5dADYHqVZb6XTeHzHphY3HwX6vFvwAbHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831747; c=relaxed/simple;
	bh=//LpavBVXT8FVZoq1jGsPqVkYZpAs3i7a9LwVv33in4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDbD91YYLsKeNkI44TASA1YynWhK+Dk8PoXeN73/YNxvTLF86tb9/AANQbuJ7Doa/SXYNde4AWEN0pgDbaRJscvQstqzy4kNAUGwZlfSGiQ6336g8rw3nFTCKqz9lItfS6EAvQ+OYexEia5U364IKM5rDsto1Pmbs9Atu28CE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=masbJiR7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kr04+8By; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=masbJiR7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kr04+8By; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="masbJiR7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kr04+8By";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="masbJiR7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kr04+8By"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 424B721E04;
	Mon, 12 Oct 2026 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791831743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1MJcydieOLnLddhhlzv+LN7MrTTO0vD0Im1KjvgXII=;
	b=masbJiR7ZhTvYFKhFm1zl/0w/7elJwX8WwH6QoAFruwV6fHt5Qk5dx2YoaqGtAZXioJ1R4
	wM8arvdPToaDjIuNloFEXafoBOy38SePsA9GTSxUUTaL9crmqzBCCtsFLKN/h5YOuvM/UX
	q+L5sHnezzYhyz1SnzwWjUFHDS4HUeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791831743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1MJcydieOLnLddhhlzv+LN7MrTTO0vD0Im1KjvgXII=;
	b=Kr04+8ByiiE+Fka9M1EB4QURJv8iqJbcAuTn+0uiCL0tfYsKOfeSCRN9UqSOCshqpi9gDG
	cBrflbtMpfkhpyCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=masbJiR7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Kr04+8By
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791831743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1MJcydieOLnLddhhlzv+LN7MrTTO0vD0Im1KjvgXII=;
	b=masbJiR7ZhTvYFKhFm1zl/0w/7elJwX8WwH6QoAFruwV6fHt5Qk5dx2YoaqGtAZXioJ1R4
	wM8arvdPToaDjIuNloFEXafoBOy38SePsA9GTSxUUTaL9crmqzBCCtsFLKN/h5YOuvM/UX
	q+L5sHnezzYhyz1SnzwWjUFHDS4HUeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791831743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1MJcydieOLnLddhhlzv+LN7MrTTO0vD0Im1KjvgXII=;
	b=Kr04+8ByiiE+Fka9M1EB4QURJv8iqJbcAuTn+0uiCL0tfYsKOfeSCRN9UqSOCshqpi9gDG
	cBrflbtMpfkhpyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D07A13314;
	Mon, 12 Oct 2026 19:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m+QbCr4uzWq2XQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 12 Oct 2026 19:02:22 +0000
Date: Mon, 12 Oct 2026 20:02:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Message-ID: <as0uqGJ6zuCc--qL@pedro-suse.lan>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
 <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>
 <asyy7Nwik5yMTNbo@gremlin>
 <asy4c7zkkmSRln1H@gremlin>
 <D964ECBC-59B6-4A4B-83D5-935EA2D06D30@nvidia.com>
 <asz7YUXhdmlenXvh@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asz7YUXhdmlenXvh@gremlin>
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 424B721E04
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Mon, Oct 12, 2026 at 04:26:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> +cc Pedro
> 
> On Mon, Oct 12, 2026 at 11:17:57AM -0400, Zi Yan wrote:
> > On 12 Oct 2026, at 6:38, Lorenzo Stoakes (ARM) wrote:
> 
> > > [0]: https://lore.kernel.org/linux-mm/20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com
> >
> > No. Without lazyfree PMD level THP discard, the affect PMD will be split
> > into PTEs without dirty bit and the dirty folio is still discarded.
> 
> OK thanks for clarifying!
> 
> >
> > We will need Samarth’s fix for backport, then we can think carefully
> > about David’s per-arch solution for mainline.
> 
> It's AI slop, and we don't accept that in mm (also -cc slopper).
> 
> Somebody from the core team will take of this fix separately.
> 
> Pedro - you mentioned you were interested in this, will you send a patch?

I'll send something, tomorrow :)

-- 
Pedro

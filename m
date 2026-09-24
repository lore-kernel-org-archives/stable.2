Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC154788;
	Thu, 24 Sep 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240238; cv=none; b=ODb/xugGxIZfZxksoQHDXeeho465iGi5qLuf7laLSxb1t1ZmDU3AEAm8162MRqKkNIER5Cez6Po5itGxhT/ItOZkEW3uODbLQ5e3Aa9fqyQKKICsDGHI+wX8FAW5WBFNpmAFNnyMLp4LtIhSkEIJ1camKFZbIgTjTTpH/8hGjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240238; c=relaxed/simple;
	bh=QPBteaT2wrQdPY+ZLCakihBI9QeeWnZW3cDWJVTpzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQRkowo6enDAvaeQLp4LCEZFELPT13fLz7LMTBHDppwUBtRt4NC1wmxPxHb59zYSwgitgCXU2acYUuVVSHlHD4ivaH3uPVpaDzhGs46KxHwMYa00fErKtMEaJIjbx/IfSc9jjmins+kjlTB4UarohLr5+wsiH9fzZ8A1IJ3/i10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HlhClT23; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZKYLHW+p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FETLO7NL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JlLUxnWv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlhClT23";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZKYLHW+p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FETLO7NL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JlLUxnWv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B81321D08;
	Thu, 24 Sep 2026 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790240230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwqlBSJIrX1buXrXAy/VoI2OzAsvIjnMs2/fkp1HnME=;
	b=HlhClT23ZavCRLFWj7jjtBgc+z2Wech+ksQ6hAJbVkeL0wqY+uva/SFPT+smyDZCJD2psW
	c2ZFKU35XamxM5niO5Q9Yoe5b7pNgM//76UwRM6uPC/el2ErIK6p8F/4S+wkVVyog46ZgE
	btYdw+bY4K5zgSq94TnyUm2GIl3jJCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790240230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwqlBSJIrX1buXrXAy/VoI2OzAsvIjnMs2/fkp1HnME=;
	b=ZKYLHW+pOWPcCToahvJKPP9/ilvcCQGt5OAALUW+4meVPHxFaTBYQSb9EG/jTNROw5u6yR
	40qDbnr6nUWExSAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FETLO7NL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JlLUxnWv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790240226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwqlBSJIrX1buXrXAy/VoI2OzAsvIjnMs2/fkp1HnME=;
	b=FETLO7NL1G4FjFORzNv086gVvuv7CBmUbS2OWQkV/dZOmULSdSwZKybGRi1Lwp5VsEFk+B
	8pnkFrxXpgVAUsGo+zc260rMIAFJ9l+9wDsFNtSyoHWiI/1csE3YMSDmtm9LiwJj0fxZPh
	IzzPjHF8OXciPKoe1JDQHVQQOIUka5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790240226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwqlBSJIrX1buXrXAy/VoI2OzAsvIjnMs2/fkp1HnME=;
	b=JlLUxnWvL3KuPPZ854fEJamunTZ0e96FZoibRt6kQgOVZZxLbiRpczvSG31E3EoZzNk72o
	jBBFFYzITJ3YDFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B4313668;
	Thu, 24 Sep 2026 08:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cC7UE+HltGo7eQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 24 Sep 2026 08:57:05 +0000
Date: Thu, 24 Sep 2026 09:57:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Message-ID: <arTlHBgXSP64U7ky@pedro-suse.tail5790ac.ts.net>
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 7B81321D08
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.tail5790ac.ts.net:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Wed, Sep 23, 2026 at 06:45:41PM +0100, Lorenzo Stoakes (ARM) wrote:
> It only makes sense to manipulate VMA fields if a new VMA was allocated,
> rather than merged.
> 
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since it
> never touches an existing VMA.
> 
> Currently, these fields will get overwritten by whatever state is
> established in the mmap_prepare hook, and if the VMA was merged,
> vm_ops->mapped will not have been called, so this could destructively clear
> existing state without replacing it with anything valid.
> 
> There is an implicit requirement that vm_private_data and vm_ops are
> fungible across VMAs which means that losing the 'new' state is
> fine.

Hmm, can you explain how this is safe? I was wondering if _any_ kind of
mismatch should be a WARN_ON (sounds like something odd is happening if
they don't match). But if the new state is practically discardable, that
doesn't make sense.

-- 
Pedro

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812428;
	b=Ii3a39buYlYpdn6UfgEuOnNDd27NjXliPFRdmr0wlKa8fRtXy3dVAtUNGB59VHjzmwnr
	 rlJyrk38dZQTZW3Tj00I9l6JtKk+QcPTcieqCjQXqq78mVJdWOKdKEcn25T6v91MAsfZC
	 5vIehnJSH+/xS+xXYkQc2e6NPTkpW/tqeUjjgDsKh5IC9fLowdTt7U7tkmO5SVlXA80sU
	 NERV0pRnkyzzXLcQoqAEnJUecH4aNbzn9nwpYPIOYdEWRCNEPvgG0HG3mDS57ZO7sByEL
	 eBrTfG/DNDk8WhrxctdAID+3EtXLaQpemOLlwIabZK9qswYt/65DPN5TdC3IJfEtd7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812428;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:User-Agent:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=+L36k1Sd/+bCDhBzEwtHETSWJSrxy8Qp4k0ec6NLo/w=;
	b=InyZJCbercheZo3j7U0MBUlJZhP9hrcI1EMz0qdtI8+2l8/p6IbSayd6jfE2lO6UyZRB
	 JDcc+/9YEx8613sTG9LsxkIsQ1kPnYGRgLhl403/fX0ePI8tlS+GCwColFgMFsf1uBiIc
	 BCff4OQt7u1cBOsWtHWMcGncsX4bon75pH8KQVsal6Z1Kg6Dxb0VOZc1Q3gSGn1YtK4Oq
	 zYXiQbIlea8KLfsUEgR4YD+tQ4wZN6f61pOWHE3GUDinFzsjyhOsvwFlBdI1H2P9wQ4cV
	 xub1yJ8n6BqsJd2xwgQZdr3aODQkYprOzkzCJzeIGLA/Y7mqmVAJAo5iFrOKKqNfixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tFe9HUFj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZLFotOvn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tFe9HUFj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZLFotOvn;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF51606A33C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FF51606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tFe9HUFj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZLFotOvn;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tFe9HUFj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZLFotOvn
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD1C21E88;
	Wed,  4 Nov 2026 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793812419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L36k1Sd/+bCDhBzEwtHETSWJSrxy8Qp4k0ec6NLo/w=;
	b=tFe9HUFjymJjrtr56g84u75Z2rf2vyYVeSQCcCCFMT1xp6lgWLUqIz03qKw4lb//fGAbw6
	GXbEyoxK8IOW66wPu5Xy/NZdE5pLv/WH26O0Ax3bWh8xrLufIq3KeVRIuml/f7pAT7uY8d
	hGBDe3iCA0oZajxl9SfAf9Xja1timkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793812419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L36k1Sd/+bCDhBzEwtHETSWJSrxy8Qp4k0ec6NLo/w=;
	b=ZLFotOvnGiNcRHmWrifau+kdrY9e1k6ziQgdnqgg/Xz0CeuB6DALnRhqLhvQ1C1luS5fpr
	LN4YdwCY7RxM57Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793812419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L36k1Sd/+bCDhBzEwtHETSWJSrxy8Qp4k0ec6NLo/w=;
	b=tFe9HUFjymJjrtr56g84u75Z2rf2vyYVeSQCcCCFMT1xp6lgWLUqIz03qKw4lb//fGAbw6
	GXbEyoxK8IOW66wPu5Xy/NZdE5pLv/WH26O0Ax3bWh8xrLufIq3KeVRIuml/f7pAT7uY8d
	hGBDe3iCA0oZajxl9SfAf9Xja1timkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793812419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L36k1Sd/+bCDhBzEwtHETSWJSrxy8Qp4k0ec6NLo/w=;
	b=ZLFotOvnGiNcRHmWrifau+kdrY9e1k6ziQgdnqgg/Xz0CeuB6DALnRhqLhvQ1C1luS5fpr
	LN4YdwCY7RxM57Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28ACE134A5;
	Wed,  4 Nov 2026 17:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dhh3AcNn62qtGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Nov 2026 17:13:39 +0000
Date: Wed, 4 Nov 2026 18:13:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: dsterba@suse.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] affs: honor copied length in OFS write_end
Message-ID: <20261104171329.GA4186782@suse.cz>
Reply-To: dsterba@suse.cz
References: <20261104103702.79093-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261104103702.79093-1-dennylin0707@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-13.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -13.00
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Nov 04, 2026 at 10:37:02AM +0000, Hungyu Lin wrote:
> affs_write_end_ofs() uses the requested length instead of the number of
> bytes copied into the folio. It can therefore write data that was not
> copied and report more bytes than the source iterator consumed.
> 
> generic_perform_write() then advances the file position without making
> the corresponding progress through the source iterator. A one-byte
> pwrite() from an unreadable buffer at EOF can repeatedly grow the file
> instead of failing with EFAULT. Partial copies are overreported as well.
> 
> Limit the range written to the copied bytes. When nothing was copied,
> unlock and put the folio without modifying block metadata or reporting
> progress. Remove the obsolete comment: an uptodate destination folio does
> not guarantee that the copy from the source succeeded.
> 
> Fixes: f2b6a16eb8f5 ("fs: affs convert to new aops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks, added to queue.

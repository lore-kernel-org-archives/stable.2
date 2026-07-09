Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75A2877C3
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587645; cv=none; b=lIgEXfkwbL58gsU/yW3zNqYLwgYgGnc0VYQWVqrCUEMxoluDVNmCOIAZN/sxUMZTej/gDnoNVPnWOZDVLoXOsXUzitteo0pF7g5cBhZ4B5N4R+ABBydP3zb0Wlf7x0wzty9ZBuwL3TyKzXUKxrSK3JerxqAO67zlomvLLWgCKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587645; c=relaxed/simple;
	bh=Zh2ODTV1GBYlf+nNnwzS1qXQqZZgdHw16xwwqEfzPiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5GUH2AVXQBx4JhhQVKV+4vPECWuchNRKjBRG3Z0GfhqiBGCzQ66gYB7b/GCTAP79kCWPtll7csR1d3F/gTu5v21HKh3WeNepJ90MWiVGhpUWvvEzzi+6Pzbiwk0KdBekGl/IUZry7t/JIya2SLe1jRb728S5dx1UKvdgP1CTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VPT/Q03Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+1LxuDQL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VPT/Q03Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+1LxuDQL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VPT/Q03Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1LxuDQL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VPT/Q03Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1LxuDQL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2F475DBB;
	Thu,  9 Jul 2026 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783587636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMqAUkpkMB0zcq7EfUKr5JKV2cULMeskN1jU9swNwfU=;
	b=VPT/Q03QTMdyHo1eR62O1cWSXtz4a286keH716ZIccJgAnJMSUeZ7WUmcGsQW1yKoM1Rwu
	lhFODurFsSliYcZ+h5VmsagGhJxk3yUUcd9CkZa78qCzcNeF4mc03OdlsoDHPchMCuYO3K
	9MCOfV062eJiDSpyWw+wcpCLsQmssXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783587636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMqAUkpkMB0zcq7EfUKr5JKV2cULMeskN1jU9swNwfU=;
	b=+1LxuDQLiibD7APAmQn+44eCQhsrqG2CV0O47JtYVV77gG1ZdC2sJUVw4Ee3Dd/i+sW8A7
	sR7CesdAmb0qO4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783587636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMqAUkpkMB0zcq7EfUKr5JKV2cULMeskN1jU9swNwfU=;
	b=VPT/Q03QTMdyHo1eR62O1cWSXtz4a286keH716ZIccJgAnJMSUeZ7WUmcGsQW1yKoM1Rwu
	lhFODurFsSliYcZ+h5VmsagGhJxk3yUUcd9CkZa78qCzcNeF4mc03OdlsoDHPchMCuYO3K
	9MCOfV062eJiDSpyWw+wcpCLsQmssXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783587636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMqAUkpkMB0zcq7EfUKr5JKV2cULMeskN1jU9swNwfU=;
	b=+1LxuDQLiibD7APAmQn+44eCQhsrqG2CV0O47JtYVV77gG1ZdC2sJUVw4Ee3Dd/i+sW8A7
	sR7CesdAmb0qO4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0E6779AA;
	Thu,  9 Jul 2026 09:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7wC9LjNjT2pnJAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 09 Jul 2026 09:00:35 +0000
Date: Thu, 9 Jul 2026 10:00:34 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>, 
	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios
 when collapsing
Message-ID: <ak9hKFnS8uQj1Yqb@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de>
 <20260708194323.agent5-0003@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708194323.agent5-0003@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, Jul 08, 2026 at 09:04:47PM -0400, Sasha Levin wrote:
> > Fix it by fully writing back the page cache (and waiting) when collapsing
> > file THPs. Doing so provides the guarantee that no dirty folio will be
> > observed while there are active THPs. To fully ensure this is safe, the
> > invalidate_lock needs to be held while doing the writeout, so that
> > do_dentry_open()'s page cache truncation excludes this write-and-wait.
> 
> Queued for 7.1, 6.18, and 6.12 (with Willy's Reviewed-by and David's
> Acked-by from this thread), thanks.

Thanks Sasha! FTR this also needs to be queued to the rest of the LTS
branches (5.10, 5.15, 6.1 and 6.6).

(for 5.10 it looks like it might need some good massaging...)

-- 
Pedro

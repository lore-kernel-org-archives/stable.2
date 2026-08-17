Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DA3AFD16;
	Mon, 17 Aug 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962823; cv=none; b=ah/34Gbk2JTTRvmG+Fp3cITv+zqPIIZceUiTfFE+A2Yf16Av6A96PNQeuoDICFNQIeqhNnX/St9DBLgy0u8YbNb+d2eROINZMQPBj7ck6wtaMfNqd+6l5aRK12eNEYgEVQMzFl8yUJ3GoLmae2ojadk5S+wXERjB/xvgVJHqgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962823; c=relaxed/simple;
	bh=K8IS6DANIfNtzPThmPzirK3zPnAfkqNxELha7b58Gkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBXNTwJYLoEMRC8PHwroYJEF760bL+Ipt5B5sDBDsSBoGKlLQajlgApBWQDRicgUEGGSBwM9LTQRTr3sHVlbwUFXFJGlp0MK1NI4YJqmtmJAffoYRZX4ftEZJgH0Ixm1EhPWl2BwZizRt7j5zhKrFO/FB0btGkdDno4uAQoId00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MgvmT8Om; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ksJ0io6V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0f4P/KCw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+zMbHr8g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MgvmT8Om";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksJ0io6V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0f4P/KCw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+zMbHr8g"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C528F3E28;
	Mon, 17 Aug 2026 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786962815;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr6WPMeJ3TQITV2mFnUGRY7gFyLEMv4li7zpJTRRNHI=;
	b=MgvmT8OmYZ8qZdivOWWpiv8x+z0E+l5thXdkiAdT8bPPIppovxcgpOaFYrtp/gFp6rMLYw
	eIlVLDIJwNe6iva+JLwZa3kKxquBnID4gyKMQDpCE961glgULtb6GnxIP2NRYU0SydjqLS
	AxzXNigsXjYIIfBoQmOp5laW6l3HOcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786962815;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr6WPMeJ3TQITV2mFnUGRY7gFyLEMv4li7zpJTRRNHI=;
	b=ksJ0io6VRn94X4MGMuIkif/BELiM4MqRc7GqJVxdZzsfdnBaLrOn2c8TRxbxYnozIoEq+8
	TPbFf/HqvLTXXXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786962811;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr6WPMeJ3TQITV2mFnUGRY7gFyLEMv4li7zpJTRRNHI=;
	b=0f4P/KCwwg5Gjl01tqwwHzzkvWULzZTVrFf6bxnFMMWXR4Fq/C54V9hNzQTXxoJoZgdTQV
	PZfM5UYsL9U6r9e/zQxukvaYyX/3Q+VbXuh+Fa4sjbUl/T9infrlJL091LfqGMDqNLM2hO
	b/UidAun3T8PAh5JNyEzoat9iuky+zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786962811;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr6WPMeJ3TQITV2mFnUGRY7gFyLEMv4li7zpJTRRNHI=;
	b=+zMbHr8gLWNWw8dhc7RI21ikLLTCFu0rpg9la5fSzpsYMAdFIFxWXRSi5PQH3ID1M8qqN6
	aLif/xVDN5mFmsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B227279403;
	Mon, 17 Aug 2026 10:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o+1OK3vjgmrOBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Aug 2026 10:33:31 +0000
Date: Mon, 17 Aug 2026 12:33:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: move large data folios out of experimental
 features" has been added to the 7.1-stable tree
Message-ID: <20260817103330.GA54102@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260812000703.4150441-1-sashal@kernel.org>
 <b4749071-b0f9-475f-83e6-13153ab20b13@suse.com>
 <20260812112910.GA1148372@sashal-kernel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812112910.GA1148372@sashal-kernel>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Aug 12, 2026 at 07:44:44AM -0400, Sasha Levin wrote:
> On Wed, Aug 12, 2026 at 10:13:09AM +0930, Qu Wenruo wrote:
> > Please don't merge this new feature into any stable tree.
> >
> > This feature is not compatible with the COW fixup mechanism in old kernels.
> 
> Dropped from the 7.1 and 6.18 queues, thanks.

Can this be handled in a more generic way, the fixes to experimental
features? If you pass that through AI, it should be clear from the
context (changelog or code).

The config option has been added also for that purpose, it does not make
sense to backport that and assign CVE's eventually. Experimental
features are only for those following the most recent release.

Thanks.

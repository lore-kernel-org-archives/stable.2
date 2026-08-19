Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AB334C27;
	Wed, 19 Aug 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144410; cv=none; b=Q9OjQF8bZuPvrdem/xrjDsGM8Vog3LGHBEUiFDa2TbTLYSo01pdApF0NMJNAOYHUT1ltw2C9ZvygPlGam6BooI0Py8rjbuXlwvfa8rYvHuHHeVux7NsvqURNK66mfIH+cO4Ddv+bg2/yIswjtRthm767lfwCC2BzKYlaA822ovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144410; c=relaxed/simple;
	bh=EN8Gh8VfweWfPGEddL0wLrrliCVL7IyQqAfuidyTZw4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNUAc3hYGoE9C5yD/3AbbRT7HbYNrmAFt86yaUK3nrY/omnhyXs+2QNR8qS0OGiQayaHol3sg+6vOV0hl6zS7H1JqlUS7h8G4B4Whif1iSKpDKPutTEqwa6j9krBVFvsgALvsditU1Fys+pKGftae0uMweV4c384xajiAphciqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nEWjIADU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hsBbi3kO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkySRKmb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EJNhs4lY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nEWjIADU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hsBbi3kO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkySRKmb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EJNhs4lY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DE8884B39;
	Wed, 19 Aug 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787144402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDzbryDO1VZ0iYseZWI7ZF0JiUZaqWk/yCIhcRy0qNw=;
	b=nEWjIADUVy281gPTAw8BibeCqPug4B6/CkqdwYe8Io09wxmObMVmcYymJeA3C74PMZ+YqP
	yM6245mzzy9tzB8MuAjtJYwO5WcKBRcp+K0ouHSSOHGgHx1YX+jelLRfzVyiBufqFsAy9Q
	sl9r5VhaIv5ou9Jq/hh2I1CPNfhewsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787144402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDzbryDO1VZ0iYseZWI7ZF0JiUZaqWk/yCIhcRy0qNw=;
	b=hsBbi3kOBYBkUGjtOeAfNyULSkpxaOI2PvHC1PQjBkljOv3fZrRT/sqctw8ju8Dwkafn5c
	b6PllJIyGhLQrJBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IkySRKmb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EJNhs4lY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787144398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDzbryDO1VZ0iYseZWI7ZF0JiUZaqWk/yCIhcRy0qNw=;
	b=IkySRKmb4o6U51JQicRwJWuyQIqA7r9h0TXdl4XU2Q7xRHlarFf/3t6+5jDb+lqUYoEsWV
	zonu8AZNF4Fdxi1DP1ls8YSnnHWv+ftLv7yuwj24tfXAs2vyk6vvea5J5saU1lDwn0SJY+
	LSNF77F4A8DqDh8cU4TuepYM8kJrAW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787144398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDzbryDO1VZ0iYseZWI7ZF0JiUZaqWk/yCIhcRy0qNw=;
	b=EJNhs4lYNjpdNeep5jqo/9gSFKx8RGldCDSArwwCrnSrZV4nBjHR73sPg7X+BIfDGH2zZS
	0ueOk4C7UzcgKdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B8E62F81;
	Wed, 19 Aug 2026 12:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ea6jAc6ohWoxLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 19 Aug 2026 12:59:58 +0000
Date: Wed, 19 Aug 2026 14:59:57 +0200
Message-ID: <87ecfunu42.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] ALSA: pcxhr: initialize mutexes before requesting threaded IRQ
In-Reply-To: <20260818144717.2269918-1-runyu.xiao@seu.edu.cn>
References: <20260818144717.2269918-1-runyu.xiao@seu.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3DE8884B39
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue, 18 Aug 2026 16:47:17 +0200,
Runyu Xiao wrote:
> 
> pcxhr_probe() requests pcxhr_threaded_irq() before initializing
> mgr->lock, even though the threaded handler takes that mutex.
> 
> Initialize the manager locks before request_threaded_irq() so an
> early interrupt cannot run against uninitialized mutex state during
> probe.
> 
> Fixes: 9bef72bdb26e ("ALSA: pcxhr: Use nonatomic PCM ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied now.  Thanks.


Takashi

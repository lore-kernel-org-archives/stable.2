Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13636CDF2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721940; cv=none; b=rROJgczAuLQprJHVguSx25FhWqeTZ2PYXoz+H+Kv4zlAab7pkWMxRjXJ6kBSL+y+w+2SqWMWDyFJRZGrzzMn+oFZLymezii+OTBz6lNjF/6Q1uPDkeShIi38sq+TEruU23xALR0ITNVfMOlRVL+mK1SbCzF5UsvmujleRTIHeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721940; c=relaxed/simple;
	bh=5ga8iWH6X69BV6Yr7e0iCV3Uo3gvt9E9GtJdSIMn++A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOncIjY5G9xQ00Nxxd1QIOJelqRHkhofVDl+BGOKKAnXM6M6+91OSWumaLytmjcrn16euRuYwLYhp8lpriBmeEh4IuIYeYm8qg3YjnYUG+pTuJ8VTmhiHZvnB013Q24dEHfnuHSkRuU8K9THZEEx7S88FWoq028U28M+fFS1TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1xw8jzqu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7HtMHfbG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1xw8jzqu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7HtMHfbG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1xw8jzqu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7HtMHfbG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1xw8jzqu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7HtMHfbG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D90B56C26D;
	Wed, 17 Jun 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9H3rBRsjIb5KWdXoxyNRNBq8YTHLtH5ARZMf5xlOmMI=;
	b=1xw8jzqu4+bVnQ8K6GBXj/tg7qicXbrS8TFHQEI44q76nip6OGm7/dHRx+D5rnjjKLQkND
	7zmo5pRwprrtCZ20j089+BJZ4tSYVDeV5tF7gUXc6LH7dvCH1nWKmSJAV29HTmk14kDYyA
	yiMwgF3VzXw4IW1IlPq7kBw8SJ3GRaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9H3rBRsjIb5KWdXoxyNRNBq8YTHLtH5ARZMf5xlOmMI=;
	b=7HtMHfbGhU0GaKKpqVR/YmGmMr2eYKjjQAVXhPQky5r7RRfvpLOeHrC6IGnHOggintays5
	51rFA0RhWk9k+sBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9H3rBRsjIb5KWdXoxyNRNBq8YTHLtH5ARZMf5xlOmMI=;
	b=1xw8jzqu4+bVnQ8K6GBXj/tg7qicXbrS8TFHQEI44q76nip6OGm7/dHRx+D5rnjjKLQkND
	7zmo5pRwprrtCZ20j089+BJZ4tSYVDeV5tF7gUXc6LH7dvCH1nWKmSJAV29HTmk14kDYyA
	yiMwgF3VzXw4IW1IlPq7kBw8SJ3GRaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9H3rBRsjIb5KWdXoxyNRNBq8YTHLtH5ARZMf5xlOmMI=;
	b=7HtMHfbGhU0GaKKpqVR/YmGmMr2eYKjjQAVXhPQky5r7RRfvpLOeHrC6IGnHOggintays5
	51rFA0RhWk9k+sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89671779A8;
	Wed, 17 Jun 2026 18:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mlJLGlHrMmrAHwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 17 Jun 2026 18:45:37 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.18.y] io_uring/net: Avoid msghdr on
 op_connect/op_bind async data
In-Reply-To: <87zf0tdn7r.fsf@mailhost.krisman.be>
References: <20260617175102.2976716-1-krisman@suse.de>
 <2026061727-thirsty-sculptor-1e6f@gregkh>
 <87zf0tdn7r.fsf@mailhost.krisman.be>
Date: Wed, 17 Jun 2026 14:45:31 -0400
Message-ID: <87v7bhdn04.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Gabriel Krisman Bertazi <krisman@suse.de> writes:

> The backports are slightly different, so they were sent separately. The bug
> exists since 6.12.

6.12: https://lore.kernel.org/stable/20260617175158.2977825-1-krisman@suse.de/T/#u
7.1: https://lore.kernel.org/stable/20260617174947.2975419-1-krisman@suse.de/T/#u

Do you need 7.0 too?  I assumed 7.0 was EOL after the 7.1 release, if not LTS.

-- 
Gabriel Krisman Bertazi

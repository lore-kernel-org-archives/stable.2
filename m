Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6864A8A2E;
	Wed,  2 Sep 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363110; cv=none; b=n2IJMZHWJ1K7ZM5KTwhBxPk8IT+xh15vfkGyBnXZfUkGCoQWOhuG3DNS06J1SZlkHa0bgtu09UtWqgPBEJneVA3u+DjA9zfnJcPtoIS3J3HtlARzZ6Ed6FpgA3hArXAJxn7m7eHFdDm98VJ2dDOFaXocc88hlhwf4vBpUXdMoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363110; c=relaxed/simple;
	bh=wvkCCX0P/jm8lFZYEAkkwoRAX2zSnXkMkkerK9mAibY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQGWPy0FOHHAZWpiFvLUjLrHzHfJsfcGyrKliiQmDRq1cAqxUoSnDv6bPrB3oUvxo+pkWAF+oKVmY294QrP2Nc2TS7XTWDzg7Qo30Y6TU9voabIEX448gfRDQK3FGgah8/SrG1uu24yB2cx6y9uQpFf4oCFvk5LN55stSvljf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ruLpDakI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7XLXCzXU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jYw43weN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NRuN6F6P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ruLpDakI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7XLXCzXU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jYw43weN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRuN6F6P"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D17DF1F7B8;
	Wed,  2 Sep 2026 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788363102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aR8CEab6Gj95wvvMrF8hgdtG4PHOGbfwc7WMddrhtqs=;
	b=ruLpDakILCJkYYLG1eKEkRGj7QrG/K4u4hMgI0d4ffY2xHtK2JtAPW5stY4lkXKdZt0CBa
	5LDHFavvswAaqAI17mSYSN4FDVBf5a1GmyIjv2NZxjlBduETcIaHSHcMPuLEPbJiWsFd+i
	e/gCN8BovwU3ekCbVpn6EYc6jP2bAn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788363102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aR8CEab6Gj95wvvMrF8hgdtG4PHOGbfwc7WMddrhtqs=;
	b=7XLXCzXUKzdXoZ8fxVRyRChsUxjt/84vqqYILkZe9btqUfQ6NEess/0YHyISNTPG602oLO
	oyRw+/a6HBhWT3BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jYw43weN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NRuN6F6P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788363097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aR8CEab6Gj95wvvMrF8hgdtG4PHOGbfwc7WMddrhtqs=;
	b=jYw43weNa2iVKWe9Go5IkM8iu9ju4u6ArjWuQ4o0Km0CoqfpFrmT0XKOZJa/tSnqGMLRgS
	0jGPf4jkSr/a+vf52Pav73Th/lP7J+RLPhYXReExukT3FR5Nl6Ti9m3c3J3jbc+dSY8QI7
	G5QDXLZ7Cjb7+aetZHwmccJ2WmK/Tog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788363097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aR8CEab6Gj95wvvMrF8hgdtG4PHOGbfwc7WMddrhtqs=;
	b=NRuN6F6PNLFarNxPHP9NAe8SUaO9qaE5CxSy3IqIBfG8DqcWEttCY7RfOdOqPRu55H8VlI
	l71B7V+idFkXWjAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251EE13736;
	Wed,  2 Sep 2026 15:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IMbnMVhBmGqOVgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 02 Sep 2026 15:31:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Aohan Mei <ljp1205831794@gmail.com>, io-uring@vger.kernel.org
Cc: axboe@kernel.dk, Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI
 <corvus@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/net: commit all consumed buffers on bundle
 recv retry
In-Reply-To: <20260902022552.1890610-1-ljp1205831794@gmail.com>
Organization: SUSE
References: <20260902022552.1890610-1-ljp1205831794@gmail.com>
Date: Wed, 02 Sep 2026 12:31:34 -0300
Message-ID: <871pbb7jqh.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: D17DF1F7B8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Aohan Mei <ljp1205831794@gmail.com> writes:

> This leaves bl->head accounting for only the first partial round
> rather than all consumed buffers. Buffers that already hold
> received data stay visible in the ring and are handed out again
> to later requests, corrupting or dropping application data.

Hi, Aohan. Do you have a reproducer for this issue?

-- 
Gabriel Krisman Bertazi

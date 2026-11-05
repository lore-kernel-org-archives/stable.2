Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881158;
	b=I23GPrLprEOw8fxPflqhUKLfA4DoC4+rq7dPsIJHkmeSbdjUSz97EcXaHjs2fl73IVME
	 kyX+pEmBpt3tOaEGkgAidYPYwg4uBtf04smwwnkoPPRf5A4GgxTeagXXaVEqbfll53+/1
	 bLtPFt8dVsw4pzYiOH0/eEH8k2PKG2sOUxUTA5Xi5vmLQ+urPC05DU3at4ZAzhuCpc6b4
	 OuOjJt1SDtNfWWwB2wBFY34v38m+/oFgHoCH1wbFPg0JBI8Fnl7H0JC74ieijoNEMldxT
	 OKetn01jP7aL7eAWUDm4AQAA0uJd39rPm7vq3X3z158CrnUykBE1sqpFF08xCBUFufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881158;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=VqpWQ/H56gC40ALaqhyZMF3XlYC2+ROVooz7JGVgA9M=;
	b=mTs79ZIXL2eiE/ogg+w32Fdul0kQufbEJWJWNFKwrcWxbt1iQeZfdwv1X3FI0ZbQeY9d
	 zyi+dtiCxkPel39y9TX0O9V9HI2yiGxzXgrFkQAlM/iMNS1X5EXjZg9NR6794EAjBlvYs
	 /QxTalGtywrLobu5Cw4z6BZPMIdG1cZMn+bIEBvmQuz6hiA+U5cjiAfQc2+IiaEY2+sJQ
	 NvRItHSgQWTiC2y+lERT0DpG67/R9zN25pCBdNWrHYmcwjPwQXhrepV0ttjxeMCNPoiIR
	 cOP93uMqt4Vdt7RPXMwFyWPvRrhOFxJawhdoPNpINOj+OLVnUbnC+W5/yf/PRWGi5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gwOrADE0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hqy7mCyS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2QGf1cFd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2i2QQIsM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C4606A330;
	Thu,  5 Nov 2026 12:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB6C4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gwOrADE0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hqy7mCyS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2QGf1cFd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2i2QQIsM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E01831F458;
	Thu,  5 Nov 2026 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793881156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqpWQ/H56gC40ALaqhyZMF3XlYC2+ROVooz7JGVgA9M=;
	b=gwOrADE0Qod4PVwDfNsd6RKN3cB+sGE4cNvv4wbkyzZCV0V1foN+caBz5Hskcp4NF8tF26
	w1nbcHD5aFeef44QG95h9KpqD4JsxU4qHmCJqtxAwp9DS3oQ3LnpbJhU1tBBz2DqOsd9ZF
	uVZLQax3NHgAnPgrND7VAX4D1zeCtNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793881156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqpWQ/H56gC40ALaqhyZMF3XlYC2+ROVooz7JGVgA9M=;
	b=Hqy7mCySg0o+D767jvmxe6zGPvs4rTxKWmK+ZRuz1ctNWbsc51XXPoLH1HMo8nDf5H7/20
	Pz0DjigL/jYbgZBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2QGf1cFd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2i2QQIsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793881155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqpWQ/H56gC40ALaqhyZMF3XlYC2+ROVooz7JGVgA9M=;
	b=2QGf1cFd8g+b2CTSCS0uxz7GbK5LPqBWmMPKf4TvU5AQH5Dg1HRUE9HTNITO5QmYusd8Gv
	YsOgOMJWElI+5g4u6nec3o3Xm7Mzt5Wj6kZrNRmsVHewMKcUp+ANSWJTPATn3eydPsmqzk
	AMabRSzYjzezo1rQKBR1OSv5TTNBcug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793881155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqpWQ/H56gC40ALaqhyZMF3XlYC2+ROVooz7JGVgA9M=;
	b=2i2QQIsMAWELvaPa0IejbpFt4bdvx6dVBY2kuOnzugjipXn4e7MRfHQXH1YwSMYg5HDZIq
	/r8/1foBG6ruJUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19864133F6;
	Thu,  5 Nov 2026 12:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3z2mNUJ07GqdHgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Nov 2026 12:19:15 +0000
Date: Thu, 5 Nov 2026 12:19:13 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
 <20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
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
In-Reply-To: <20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E01831F458

On Wed, Nov 04, 2026 at 11:12:41PM +0000, Jose Fernandez (Anthropic) wrote:
> On Tue, Nov 03, 2026 at 12:12:58PM +0000, Pedro Falcato wrote:
> > I'm not sure I understand. xas_find() was fixed. Is there any other case where
> > this loop can step backwards?
> >
> > If not, I don't think this should be Cc: stable, and should probably be a WARN_ON().
> > As it's a hardening patch and not an actual bugfix.
> 
> Yes, there is at least one more case. It triggers when a read fault
> starts a lookup inside a large folio while a hole punch removes that
> folio and a write puts part of it back. A stress test I wrote for the

Thank you. So, if I'm not mistaken, this is the race:
First, you map/see this:
	[folio pgoff 4, length 4]
Then, at some point in time, someone punches the hole:
	[no folios here]
Then, at some point in time, someone faults another folio in the range:
	[folio pgoff 0, length 8]
so you step backwards. Is this correct? Or am I misunderstanding this?

If so, how can this happen while we hold the PTE lock? That itself should
block truncation.

Can you share the reproducer?

-- 
Pedro

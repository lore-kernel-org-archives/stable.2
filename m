Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707984;
	b=122XhjDvHyHjj3vascCRAt+LrmGGYGA7s59hy83FJOPaWnEiq/VTJ49c2uIi9x2bmDdC
	 Q/YC/rTtopyrQxnRxf7kSYuW9tFt2rartq1U3Ka2IJX7Sj/jrTGZ0S+kglj6qnpiyclEp
	 JNFbUoYGtwq1zXWV85CiVkg8hA/fSSepLGvyUAZKYRit5gBpb3mYCkcSDUMoKi9pGDiMD
	 B5yxq7kpWt4tOqOpquFo64Rwxzkfs+mxoutklHhnMvgvWX1lauzOibwXbsY6S7YuNwobx
	 ZonfpPtE6A8C54gCDSophR3FoFz71XhgoeLx3rDoJ7Ds1erZukE7KnYC0j7q95cODEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707984;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=9kwRa3DN63egfTMxuFyQnVb8zSbbi4+PrcwPMbluoIU=;
	b=llBc34efWyGN6DjMbV119lIeklyDbh+37KGlrMc/OWVdhoHy05Zf+SQTiPi7pNiccDNJ
	 vPKCqNX0FwYiRtF5SB8ayxIMYlcRNQm6JU2X0YMLAS61PAdmwo7gOHIwiGmzhbNE/X3RC
	 0MVylXwyeUwTD8xazwU+Q07riVBDIliAE9kFcCCjiEpGU/8/7M+aaCUUi8aNfa8O+HUsJ
	 7BDJrL0Z9K9qYP0bAXok+bUN+bpfLg9tznRCyfMg0vlmhl86pXZwScaLPn5rVlhVxgYby
	 GrnxQQS1R5o4xIrbs97dCNGZcmHUdvsFZykBoBHhF17Lz39WpO1tgX9npZUIVaptr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nFNAv8Zi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVfNg+91;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nFNAv8Zi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVfNg+91;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC8606A324;
	Tue,  3 Nov 2026 12:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71BC8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nFNAv8Zi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVfNg+91;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nFNAv8Zi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVfNg+91
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 078272203B;
	Tue,  3 Nov 2026 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793707981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kwRa3DN63egfTMxuFyQnVb8zSbbi4+PrcwPMbluoIU=;
	b=nFNAv8Zioud6qE1gAeujq9KkGc4xucpVaRDNIUIWWX9XTwq8jLzW6ZtKxLoWAcp9/FD3bl
	J8VeCiESZ1e1RlHdtITllfC+OqVoS+QeKj6qeGiWHSmy/lNc2HC7rBa8xG7cNF/x5ZPvrY
	d8pEs39zG8EesiVqirGy/RgZxYQUmPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793707981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kwRa3DN63egfTMxuFyQnVb8zSbbi4+PrcwPMbluoIU=;
	b=GVfNg+91FeXcI/1vlZg/XLq3Gf+f6kKU3xQjda4/0h70fEplH6m/p0hhHVo865U5PYlwG2
	phUnBMfzkA1vaIDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nFNAv8Zi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GVfNg+91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793707981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kwRa3DN63egfTMxuFyQnVb8zSbbi4+PrcwPMbluoIU=;
	b=nFNAv8Zioud6qE1gAeujq9KkGc4xucpVaRDNIUIWWX9XTwq8jLzW6ZtKxLoWAcp9/FD3bl
	J8VeCiESZ1e1RlHdtITllfC+OqVoS+QeKj6qeGiWHSmy/lNc2HC7rBa8xG7cNF/x5ZPvrY
	d8pEs39zG8EesiVqirGy/RgZxYQUmPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793707981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kwRa3DN63egfTMxuFyQnVb8zSbbi4+PrcwPMbluoIU=;
	b=GVfNg+91FeXcI/1vlZg/XLq3Gf+f6kKU3xQjda4/0h70fEplH6m/p0hhHVo865U5PYlwG2
	phUnBMfzkA1vaIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FD15134B8;
	Tue,  3 Nov 2026 12:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MgVXMsvP6WqucAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 03 Nov 2026 12:13:00 +0000
Date: Tue, 3 Nov 2026 12:12:58 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
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
In-Reply-To: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
X-Rspamd-Queue-Id: 078272203B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Sat, Oct 31, 2026 at 04:33:59AM +0000, Jose Fernandez (Anthropic) wrote:
> filemap_map_pages() can dereference a PTE pointer outside the page table
> it locked. KASAN has reported this as a use-after-free read [1]. The
> same path can also write out of bounds. When the stray entry reads as
> none, the fault-around loop maps a page there with set_pte_range().
> 
> Its fault-around loop walks the page cache and moves vmf->pte by the
> change in index. A lower index moves it back. xas_find() can step back
> to a lower index when a multi-index entry is split during the walk.
> 
> [1] fixes xas_find(), but the loop still relies on the walk never
> stepping back. Stop the fault-around when the walk steps back. ->fault()
> maps the faulting page if the loop did not.

I'm not sure I understand. xas_find() was fixed. Is there any other case where
this loop can step backwards?

If not, I don't think this should be Cc: stable, and should probably be a WARN_ON().
As it's a hardening patch and not an actual bugfix.


-- 
Pedro

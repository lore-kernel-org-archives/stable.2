Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898503C1974;
	Mon, 31 Aug 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163881; cv=none; b=lkhOwcSwkLh4YKZz2JA5NGNP9nRfkLoxKPx+vVb+EduqzGF5iNZ2lGpTmC1KGAnJF5cdE1t1XUnmB4ZKDFi9J00tYwt9qFzbXKvtv8A5NbbgNPTFpQNJRooFDYz5GuzQiah/eLoPTwH29x/LZ9LMWykIJHqwcLH6ZL+zjZ3xsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163881; c=relaxed/simple;
	bh=Bmyq0qDOT7DxHyaxetz1ss5JfOWjJd1G2k9FC0+7nCk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oanLJKi0e0KbsFJKCb1+xcCdZCSBmCUFFKvd76agPpFeObdXNar48PG5b2wX6dd4OwWolpWwrvXLmZTrOlXWK+rkVsub9hu1vj7Fh3Yb2oTgahjWgVuiiZGanUQvDY9bYREOxsdpuYBMPoRpwjg/iYIt1e2wzpsn/EUZKQI1zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I79Ymh0j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=knD3xvzi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HlUqUR8g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j1ArBW5W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I79Ymh0j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="knD3xvzi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlUqUR8g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j1ArBW5W"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41BE7224CB;
	Mon, 31 Aug 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788163873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX18xwSWw91y/0T4BOJt/V1QzJ0inCFeMn+lOvupHpU=;
	b=I79Ymh0j2B+LpmI+mX5nYJZHxda36UX5OnioDZn+1UyatkmClf9r0eeM3eS3hOP/TCr2+i
	yv6EOi8F1JYz895alWu6oXnzqMO+K/2To6q6tYF+5D3MUR6I9IUtI+bH66/EAncFupxPoA
	PIUw5IR6PFsLMSndMgX5HVypgXSxnCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788163873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX18xwSWw91y/0T4BOJt/V1QzJ0inCFeMn+lOvupHpU=;
	b=knD3xvzidfqhdTSblQar5MHDNQnWYvg4y3MbwWkXbBGTN8GvcnPrxV6LE/Hjdy3uZaD0MH
	5w5nYEMXtI9v8fCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HlUqUR8g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j1ArBW5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788163869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX18xwSWw91y/0T4BOJt/V1QzJ0inCFeMn+lOvupHpU=;
	b=HlUqUR8g9Ve/UhWSSSJDK5I9WHbSo1wdzfERngc8Bnzn5Gr8PpJ2UrdRUxKJxDX4HLX6hg
	BWQybm/u+4sb32tvfITN0J//d7JNZHAB2qGkGTax5xwl1OtrMshXpFZiP8GGK+frg9hnsq
	vGCxR8JsZHpvaK3FRzh58crdALH19Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788163869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EX18xwSWw91y/0T4BOJt/V1QzJ0inCFeMn+lOvupHpU=;
	b=j1ArBW5WJ/zjCWC7bQCo2y7bVOAaKXIMAywsYw0/eHyo8+SboXuEIPut2EMheAAj7RVRIg
	nZ9QRYIbogaCOIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED97A13515;
	Mon, 31 Aug 2026 08:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1mvKOBw3lWrxAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 31 Aug 2026 08:11:08 +0000
Date: Mon, 31 Aug 2026 10:11:08 +0200
Message-ID: <87a4q2so9v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: <tiwai@suse.com>,
	<perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"Kimi Security Team" <bug-report@moonshot.ai>
Subject: Re: [PATCH] ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
In-Reply-To: <20260831045506.889070-1-yilinzhang@moonshot.ai>
References: <20260831045506.889070-1-yilinzhang@moonshot.ai>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 41BE7224CB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Mon, 31 Aug 2026 06:55:06 +0200,
Yilin Zhang wrote:
> 
> snd_pcm_hw_params() and snd_pcm_hw_free() guard buffer reallocation
> with an mmap_count check performed under the PCM stream lock, but the
> lock is released long before the buffer is actually freed:
> snd_pcm_sync_stop(), constraint refinement and do_free_pages() all
> happen in between.  snd_pcm_mmap_data(), on the other hand, takes no
> lock at all: it validates against the old buffer's state and
> dma_bytes, remaps its pages into the VMA, and only then increments
> mmap_count.
> 
> A concurrent mmap() can therefore slip in between the check and the
> free.  remap_pfn_range() installs writable PTEs for the old buffer's
> pages without taking page references, and the subsequent
> do_free_pages() returns those pages to the page allocator while the
> VMA still maps them.  This leaves a stale, writable mapping of freed
> pages: a page-level use-after-free that can be leveraged for local
> privilege escalation.
> 
> Make snd_pcm_mmap_data() participate in the buffer-access scheme
> introduced for hw_params/hw_free: acquire runtime->buffer_accessing
> before validating and remapping, and release it afterwards.  Buffer
> reallocation already fails with -EBUSY while accessors are active,
> and the mmap side now fails with -EBUSY while a reallocation is in
> progress, so the validate/remap sequence and the check/free sequence
> can no longer interleave.
> 
> A reproducer that turns this race into a stale writable mapping of
> the freed DMA buffer pages is available on request.
> 
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Fixes: 92ee3c60ec9f ("ALSA: pcm: Fix races among concurrent hw_params and hw_free calls")
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>

Applied now.  Thanks.


Takashi

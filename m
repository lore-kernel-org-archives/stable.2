Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF13E51DE
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915387; cv=none; b=JAOEeWjq0rfj20wIpiUj/hjNOAtuE/1pzEkFeanlmD6Yw+wZQdnmm4oeUXJ+dglMyKHmWOj2UBhi3xHp7F6AqStpC6x28ySAwFl+mrGXGZSFYUimrI6bSaP+tTOBcTah0yKk2+7+bV+c1iIJnbw0rzLa52pkaHBLEVZ8UGDkaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915387; c=relaxed/simple;
	bh=Dgjph9YhDcCeWfi0eY7setu5oWJjRRQGMixLQsAuXeY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWxGnwskAnVJ7WXmIhTJKWrNSRyDxfugIP1B7Xo29GZboJIf7VjeQa2MFn67LXjWGKXTqyhgLjRelAea59pEvRmIuQ1d4qp1z4/8u4tX7tOWwnqeqiEBieM2o4s57c3sULt3n2d0ZYnXD+coaMH/FXuKUX176hkCpkEJBwuWEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=miozujtM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nqQN3x5o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sqCokUcR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gf3DuLen; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="miozujtM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nqQN3x5o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sqCokUcR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gf3DuLen"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 802157F82F;
	Wed,  5 Aug 2026 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cuSh9K7dWDQqQTA6Qi8VPAfMBTAykHAd/drcR362p5k=;
	b=miozujtM5M0/jwiOwLcwyFG7ck/zqg9T6x6hGJy23XizXHgm4/+PtuXlciHiifFuDtMkns
	9OS5e/PoynXw2M90UlQPtm69au2FUMTeWhtYClhHnR2lW2XU0h88CsIXHM5B9CLswl5z9R
	WqaSJwdNbOG48brT7dn9+KPT1aV2pi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cuSh9K7dWDQqQTA6Qi8VPAfMBTAykHAd/drcR362p5k=;
	b=nqQN3x5oFLfQC1D9+ruy8is3IDqKDbK0z6HgHQ3sMyY2pDXPAqwsvi+/G7G86tysq5mxds
	vw2cnlamdVsEOBAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sqCokUcR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gf3DuLen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cuSh9K7dWDQqQTA6Qi8VPAfMBTAykHAd/drcR362p5k=;
	b=sqCokUcRnLpn/8K6CVkLXg3V7l9vid4VruEU6V966XWoULOuEoTRQ++Qf4leLVwqcQ2DeD
	SDFgb0F5AJmeAOibWiZDv325zV+qLxj2KyGhXXn2XXQ5cYQfINYL8l4Ww6fQMp4cEINFvI
	7jJ6F13GFnDrZKh5TOD+598ipbVG3Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cuSh9K7dWDQqQTA6Qi8VPAfMBTAykHAd/drcR362p5k=;
	b=gf3DuLenWBtykdymZiHtt3CrFTtNcSVjG+f0LdhQDTPPy5Z09OLu4BB+jo8FVvpc/46aAX
	vqVU+Ct6TAvA2sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50F0B779B6;
	Wed,  5 Aug 2026 07:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xYKSEu7ncmooRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:36:14 +0000
Date: Wed, 05 Aug 2026 09:36:13 +0200
Message-ID: <87ik5pggsy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usx2y: bound the hwdep mmap fault offset
In-Reply-To: <20260805013445.38283-1-baul.lee@xbow.com>
References: <20260805013445.38283-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xbow.com:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 802157F82F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, 05 Aug 2026 03:34:45 +0200,
Baul Lee wrote:
> 
> snd_us428ctls_vm_fault() turns the faulting page offset into a kernel
> address with no bound of any kind:
> 
> 	offset = vmf->pgoff << PAGE_SHIFT;
> 	vaddr = (char *)(...)->us428ctls_sharedmem + offset;
> 	page = virt_to_page(vaddr);
> 	get_page(page);
> 	vmf->page = page;
> 
> 	return 0;
> 
> snd_us428ctls_mmap() checks only the length of the mapping, never the
> offset, and us428ctls_sharedmem is a single page from
> alloc_pages_exact().  For a character device file_mmap_size_max()
> returns ULONG_MAX, so the mm layer imposes no ceiling either.  Every page
> offset above zero resolves to a struct page outside the object, and the
> handler installs it into the caller's address space read-write; the vma
> is not marked read-only.
> 
> The caller picks the page frame with a single mmap() argument and gets
> read-write access to a page of kernel memory it does not own; an offset
> that lands in an unpopulated vmemmap region oopses instead.
> 
> A process that can open the hwdep node of an attached US-X2Y reaches
> this after loading the FPGA image through the same node; no capability
> check is involved.
> 
> On 7.2.0-rc5 (arm64), mmap() with a large offset:
> 
>   Unable to handle kernel paging request at virtual address fffffdffc45d5ac8
>   pc : snd_us428ctls_vm_fault+0x68/0x140 [snd_usb_usx2y]
>   Call trace:
>    snd_us428ctls_vm_fault+0x68/0x140 [snd_usb_usx2y]
>    __do_fault
>    __handle_mm_fault
>    handle_mm_fault
>    el0_da
> 
> Reject any offset outside the shared region.  The pcm hwdep handler in
> usx2yhwdeppcm.c computes its address the same way and needs the same
> bound.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi

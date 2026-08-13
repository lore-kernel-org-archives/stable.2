Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F73B9D84;
	Thu, 13 Aug 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605130; cv=none; b=lvm3DE8Ia+Jcq5p5XMPuLpBuOShXuvoLNwjWRFin/dJtBc1tA3iHXJvmcCu3pG8gumJLM/yC6xvhCfgGKhEwuqHYVqjtPdJAAiGn+tCwMBhBd7FohSqj6FOfE7XWSGVsDu92QzzPBKuY4Kzj4NGsXWdbH/XLME9F/nsdPek/0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605130; c=relaxed/simple;
	bh=U4FXu+X21OwMCdya/8jEl4PA0qOeYQsul87h54HTjYI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKOL73lYhM+ZdXNxWpuaTfMwEymZFrsyKjAvmsuv5f+Z78Hjiqi+LsATWkDc7DMu02UBmn2HPuNXwz8U0XpDl5jNdb6Y+KAJbQvnJF42jQboHdg/1b9aICPlTDJqHOqJRlN1jLMqo70KJrGZPtqswDYbz/4oCsmiPcvYipt7xXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bGkJ9xkH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sx9dQQkz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N6SJkXD6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0yahOQui; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bGkJ9xkH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sx9dQQkz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N6SJkXD6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0yahOQui"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8CF78281B;
	Thu, 13 Aug 2026 07:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786605122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqOt6IYpgHCjin8W3JBl2b5WX7ELyJvJKZdRlxMK1k=;
	b=bGkJ9xkHCeOGRYA/FzW6O1I9J2qLlAOCDJ+46Bgeuua6QeVgk+jJGpXTbqVN9uZ7cktaD+
	Mo/ge4CA992hFjlwqVUFno/KCbL25avul3yauHg51gCUAOl9/ZXTzP8CVjkJ1U9L3YDX2f
	vmJ7eDlWDvp2NelRe6Zhv86JXCRkk6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786605122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqOt6IYpgHCjin8W3JBl2b5WX7ELyJvJKZdRlxMK1k=;
	b=sx9dQQkz5XlmxPWEH+tH6uqYXebKg1s+By3+DbD6BSv6HUAbEBDAfAmGPVvATqDuAVbDzs
	MXqMp+5th9oFlUBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N6SJkXD6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0yahOQui
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786605118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqOt6IYpgHCjin8W3JBl2b5WX7ELyJvJKZdRlxMK1k=;
	b=N6SJkXD6RVRe/w1aVT3HMrXCPGeEeqlfDGqh3zAUhgnp9+bWymcQ4QLz8qjnLPtTOrQaV1
	Tz1ZcoplH61LbS8yDLywZDaMrDvNqK0LAbw3Nk6ZrQDficVfkHZUX7/yk9SYIGqrp0lTJs
	BPSs04C7cy3goaf5ycYcpMEm5vR+cSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786605118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqOt6IYpgHCjin8W3JBl2b5WX7ELyJvJKZdRlxMK1k=;
	b=0yahOQuii2BfSSa/o6d9QU7eVkVdoPvBW9Lb/KOBkaE1x/jGqkSmYMO4Y/APPzhTJ/CdID
	xOVqjFZuxu6pWLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FE3C77CBE;
	Thu, 13 Aug 2026 07:11:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bkn/HT5ufWrkOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Aug 2026 07:11:58 +0000
Date: Thu, 13 Aug 2026 09:11:58 +0200
Message-ID: <871pc2ze81.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: raoxu <raoxu@uniontech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset
In-Reply-To: <43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com>
References: <43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,uniontech.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: B8CF78281B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu, 13 Aug 2026 08:55:24 +0200,
raoxu wrote:
> 
> From: Xu Rao <raoxu@uniontech.com>
> 
> snd_hdac_ext_stream_reset() polls PPLCCTL for STRST by masking the
> register value with AZX_PPLCCTL_STRST:
> 
> 	val = readl(...) & AZX_PPLCCTL_STRST;
> 
> The same masked value is then used when clearing STRST. Since val
> contains no bits other than STRST, clearing STRST from it always
> produces zero. The subsequent writel() therefore writes zero to the
> entire PPLCCTL register instead of clearing only the reset bit.
> 
> PPLCCTL contains other stream control fields, including the stream tag
> in AZX_PPLCCTL_STRM_MASK. Those fields must not be modified as a side
> effect of clearing stream reset.
> 
> Use snd_hdac_updatel() to clear STRST, matching the existing set-reset
> path and preserving all unrelated PPLCCTL bits.
> 
> Fixes: df203a4e46f4 ("ALSA: hdac_ext: add extended stream capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied to for-next branch.  Thanks.


Takashi

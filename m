Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776153;
	b=qF71qDPCBBJdi9ukaA8ksXL6TwmutkcDG+u2TSFly0n/XWpwiT1miNHBrib00jBvxSMU
	 kSLqBXPVrnTykpYWuRghE9T3wmsyY8RjIw69N8MCgS2LSS7FtMFDZJEG/1rKNbAVPENML
	 76UpU4Zpb7V66SShyeyaaGKrejIw2fusN9S7xkJxYpbdDboVCNEgRgKRzvr64efxpkfu3
	 rRXsakSZ7OR/XXhrWYrGTe3ORIS1PclzgXylpVs31DmXqfgKwzM3TlKKcctLFR10jyk5M
	 JEwYtW6c5ydJn/XvCveqIC4oYOgj7pQMxWXezibKfk78W63s1bWlhVzn84KkU/wEFiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776153;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=emnBMYYtlelYYV2L6n2Io2FmE+4Pu+/TpD5NrJBlQnk=;
	b=hSSpM1Z437DemGRtJhuu/U9d3rJyIBKNboKHHiGb01HjY2ZmlOpwDqxPakEoL8vVA5y5
	 JsfxTCKcf6N2SLsNdtjRUPuT/Phyc8aRAJjWvm2QuYJ8GDm/HlpjVplazidpqedKbyH5v
	 4D9rIQHI044VuFcmH6svpXXzIJ/bOHWipGuKJKK3pYUaTk/nARHoTajiFzKWSZR1pPm09
	 VL9u7s2bGaiXVl0FbY7H/CzQMJkVUGS8BDaq3Y8zf5LDQEGgqjqGWpgMkgEyQtBzEabep
	 kdhffHX4tAfcAXGjeNjrrBFYlDYgJUG3DzEjGxoE7rTrdJXJTkKwiQO+5E8AIOotqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NqvtMp1w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2z5gkbP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NqvtMp1w;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2z5gkbP;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A5606A31B;
	Wed,  4 Nov 2026 07:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D1A5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NqvtMp1w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2z5gkbP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NqvtMp1w;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2z5gkbP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83C5821F99;
	Wed,  4 Nov 2026 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emnBMYYtlelYYV2L6n2Io2FmE+4Pu+/TpD5NrJBlQnk=;
	b=NqvtMp1wtygzwO2MiMnGRHr4qNurHVyURpcVOgMImoGRzvi3nO0lB8LFXv35+q4D+BmBiq
	1D3NYGvvMzPVX5Lobe+2TGpuF9qVvl3QjbgX+o5tFYo9+ZpOL+uxwiDLFk0tPg9YFgoGr1
	fsiIT6eiW+3IAMad2+rQGfAeI6tDqw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emnBMYYtlelYYV2L6n2Io2FmE+4Pu+/TpD5NrJBlQnk=;
	b=U2z5gkbP2Fcy3YRapafti7PUuZi1wT8gj0iFbbi7ySmfP4Y9SKpkXQK5uo4E36lgPHauQd
	NIl13uND1dh2M8Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emnBMYYtlelYYV2L6n2Io2FmE+4Pu+/TpD5NrJBlQnk=;
	b=NqvtMp1wtygzwO2MiMnGRHr4qNurHVyURpcVOgMImoGRzvi3nO0lB8LFXv35+q4D+BmBiq
	1D3NYGvvMzPVX5Lobe+2TGpuF9qVvl3QjbgX+o5tFYo9+ZpOL+uxwiDLFk0tPg9YFgoGr1
	fsiIT6eiW+3IAMad2+rQGfAeI6tDqw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emnBMYYtlelYYV2L6n2Io2FmE+4Pu+/TpD5NrJBlQnk=;
	b=U2z5gkbP2Fcy3YRapafti7PUuZi1wT8gj0iFbbi7ySmfP4Y9SKpkXQK5uo4E36lgPHauQd
	NIl13uND1dh2M8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ED35134A5;
	Wed,  4 Nov 2026 07:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eXeNNBXa6mqSJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:09:10 +0000
Date: Wed, 04 Nov 2026 08:09:09 +0100
Message-ID: <87zevpul7u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: songxiebing <songxiebing@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: info: Fix maxsize underflow in snd_info_entry_write()
In-Reply-To: <20261104061311.1345791-1-songxiebing@kylinos.cn>
References: <20261104061311.1345791-1-songxiebing@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, 04 Nov 2026 07:13:11 +0100,
songxiebing wrote:
> 
> From: Bob Song <songxiebing@kylinos.cn>
> 
> snd_info_entry_write() computes maxsize as entry->size - pos without
> first checking whether pos has already reached entry->size.  If a write
> is issued with an offset beyond the entry size, the subtraction
> underflows and count is left unclamped, so the write callback is called
> with an out-of-range offset and the original count.
> 
> The read path already handles this case by returning 0 when
> pos >= entry->size.  Add the same check to the write path.
> 
> Fixes: d97e1b78239c ("ALSA: info - Check file position validity in common layer")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bob Song <songxiebing@kylinos.cn>

This was already addressed in Christian's recent patchset.
https://lore.kernel.org/20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org

(... and he mentioned that return 0 would lead to endless stdio
retry, too.)


thanks,

Takashi

> ---
>  sound/core/info.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/core/info.c b/sound/core/info.c
> index 3b8ccda04e1a..676b06e0d463 100644
> --- a/sound/core/info.c
> +++ b/sound/core/info.c
> @@ -171,6 +171,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
>  	pos = *offset;
>  	if (!valid_pos(pos, count))
>  		return -EIO;
> +	if (pos >= entry->size)
> +		return 0;
>  	if (count > 0) {
>  		size_t maxsize = entry->size - pos;
>  		count = min(count, maxsize);
> -- 
> 2.25.1
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486098;
	b=ajGnh4D61mlPPr9pfXIcVLZ1wYlZoi6zwIHozx7YMUaCY3ZAKLaQ8S38SK1FzLcGPSRI
	 VcTaaDSg6zRl6fMDeKMHXBvLQWFe5ae8FgbFIcelM2JowPShrqhBqXhfUb4JLPpnJuEN9
	 Utq7Kly2EFjranGE5nYR0PLy+iWtoriEckMlM0+QwH4K1WjmVb89zqhQjHPqywhfusNwn
	 6Vq52ZiPhiQdEOBTn8JvM0RxuLOXFRpx+1SWus2Vn6cyipFiLpib/wkgFgjL4k7rRXqsr
	 2AUObTRZyUbvleRWaq4buG+rOJYNMDjdr0Qn+o8hBgzb6R4b3Rb8LK/PVMJeiwz4jMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486098;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Rspamd-Action:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=tdqZXrnncHak6JxlpGASXKoBmmuBruuiWa+YDUskAZo=;
	b=YJZIH3hpCyWLWgqOmd3RcAW5f4rbrV8KD69lv2mBBhwwM/xWzk/EX/NVDr2pysJjWaxf
	 UrzJm3/Ry7+4ApZeReOM3mrroAPJX2+NK6e74AuvyDZy4kh2T0qjmzZenAjWWUBYB6gHx
	 MDkyknoIEnfH4iok81uV9Jjf3Vd1LEwab0k/3YktYHp86EB0c+JXKUWij2nUeZuwnat9/
	 xqGDUKG+Nx0472JWQCnCITodi8GD9itSO2VjyoHilVJRABWlsYcOjoGN1vBGDbwFAnzw8
	 ROavMzwOezVXDMl80qlcYI/K7mpcEop45tNnO7qqrcgFZ64IX7gm3Y6nyPTFYkKXnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DROJXhbp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="giJfUN/t";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DROJXhbp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="giJfUN/t";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3860A2604;
	Tue, 20 Oct 2026 08:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B3860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DROJXhbp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=giJfUN/t;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DROJXhbp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=giJfUN/t
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CBA91F44E;
	Tue, 20 Oct 2026 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792486096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdqZXrnncHak6JxlpGASXKoBmmuBruuiWa+YDUskAZo=;
	b=DROJXhbpDrA8xV62Lkq9xKWj5p8hWjKLR3lwec+Qqxc4of7FHuoLbMCLVh6P4SSOiQvgJ3
	Tbd7cXPoGstqA93ym0fMIp6VEkA6AJ3HRT3p8xhpbmbLdFwES3Sxd7gB1CyAoIJxcIypQu
	aZhcPBIBAqH6juZzCT1cbDXDTcAOKKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792486096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdqZXrnncHak6JxlpGASXKoBmmuBruuiWa+YDUskAZo=;
	b=giJfUN/t72LOZv8foC/d+76VH3wkPqhEu10NSUFplKe5UMi5sFEplzGp+fPLizS6oWySfE
	dfXW43OYi44zIpBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DROJXhbp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="giJfUN/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792486096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdqZXrnncHak6JxlpGASXKoBmmuBruuiWa+YDUskAZo=;
	b=DROJXhbpDrA8xV62Lkq9xKWj5p8hWjKLR3lwec+Qqxc4of7FHuoLbMCLVh6P4SSOiQvgJ3
	Tbd7cXPoGstqA93ym0fMIp6VEkA6AJ3HRT3p8xhpbmbLdFwES3Sxd7gB1CyAoIJxcIypQu
	aZhcPBIBAqH6juZzCT1cbDXDTcAOKKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792486096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdqZXrnncHak6JxlpGASXKoBmmuBruuiWa+YDUskAZo=;
	b=giJfUN/t72LOZv8foC/d+76VH3wkPqhEu10NSUFplKe5UMi5sFEplzGp+fPLizS6oWySfE
	dfXW43OYi44zIpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E2B136CC;
	Tue, 20 Oct 2026 08:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uF26Kc8q12qWUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Oct 2026 08:48:15 +0000
Date: Tue, 20 Oct 2026 10:48:15 +0200
Message-ID: <87bj8oiwq8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ALSA: compress: fix buffer handling and state validation
In-Reply-To: <20261019144533.30665-1-peter.ujfalusi@linux.intel.com>
References: <20261019144533.30665-1-peter.ujfalusi@linux.intel.com>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2CBA91F44E
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Mon, 19 Oct 2026 16:45:29 +0200,
Peter Ujfalusi wrote:
> 
> Hi,
> 
> Changes since v1:
> - patch 1: do not free the old buffer in snd_compr_allocate_buffer().
>   SET_PARAMS can only be repeated in OPEN state after ops->set_params()
>   has failed, so release the framework-owned buffer on that error path
>   instead. The buffer is allocated once per successful SET_PARAMS and is
>   never replaced (Vinod, Takashi)
> - patch 2: reworded the commit message: the buffer is set up once and the
>   next_track path does not re-allocate it. The geometry check is kept
>   because ops->set_params() would otherwise receive buffer parameters
>   that do not match the buffer in use. tinycompress always passes the
>   open-time fragment_size/fragments on next_track, so existing users are
>   not affected (Vinod)
> - patches 3 and 4: added Acked-by from Vinod
> 
> The compress offload core has several edge cases in buffer management
> and state validation.
> 
> A SET_PARAMS that the driver rejects leaves the framework-owned buffer
> allocated while the stream stays in the OPEN state, so a following
> SET_PARAMS overwrites the pointer and leaks the buffer. During gapless
> playback, SET_PARAMS can also change the buffer geometry while the byte
> counters still refer to the current buffer. Separately, SET_METADATA can
> reach the driver before SET_PARAMS, and the origin_seqno task lookup can
> restart a task that is still ACTIVE.
> 
> Address these cases by:
> - releasing the framework-owned buffer when ops->set_params() fails, so
>   the buffer is allocated once per successful SET_PARAMS;
> - not re-allocating the buffer on the gapless next_track path and
>   rejecting a buffer geometry change there;
> - rejecting SET_METADATA while the stream is OPEN; and
> - allowing origin_seqno to reuse IDLE or FINISHED tasks, but not ACTIVE
>   ones.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (4):
>   ALSA: compress: fix buffer leak on failed SET_PARAMS
>   ALSA: compress: reject buffer geometry change on gapless next_track
>   ALSA: compress: add missing OPEN-state gate to SET_METADATA
>   ALSA: compress: reject restarting an ACTIVE task via origin_seqno

Applied all four patches now.  Thanks.


Takashi

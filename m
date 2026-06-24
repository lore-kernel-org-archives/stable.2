Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B52EEE94
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291834; cv=none; b=idWsSB8HpOog/4M+8cTlrSYfIdwhkLBIn9dc8P39gy9gs7VESCbf4S1fosjL/YxUJdeynIs/maInqxcIU20FdJdFU1t66+ngtYLcTt+Z073NK+Qb7fePJ0DGBXdvrpSgg5jpD0g/IPtjTof0zBfmqvHdC7JccO9JugQH6WZOi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291834; c=relaxed/simple;
	bh=UcSBwmcsZBPBDfORQOE84AIbuSrV+baxPj7jqtWS7M4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0yesGQP660QWmmirVLsZxTi1e3Kre1wDNG1oi1j5pJNTPqAFZAbJ0CjGL5D4hqsXhpnGysvlKe5rVsneOrTTeWTa9q37vTeFNi69egJ4S9bPVm9MHq9sNYYWq+/SPqCYwOBEkdoT9URhl9kq0Yg0pmuuBFatF7Cf1D4Qu/9+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1x42hlTl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R3IlegPj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cf2skJNV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z7IVdP38; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1x42hlTl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R3IlegPj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cf2skJNV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z7IVdP38"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9CBE713D7;
	Wed, 24 Jun 2026 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782291826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9d7DZdLslHNPZRGZFvdtDMf5wRXMC8cZhiVMfWkhSw=;
	b=1x42hlTlbAPQp3ao+Ih26eDBKGDx7R8aAxFYC7Eivx6/lxWL+8Suck49mfKIHqmIX29xHy
	YIShcdrCsDTsUGbd/9kg90hbjuLsuYkDZmUZosXtctBZ/0dO8J2uMNmQygL2E4lJ6nAQu1
	dNwJRNrxY50Nc8F/0wDHbpZeep+I87Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782291826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9d7DZdLslHNPZRGZFvdtDMf5wRXMC8cZhiVMfWkhSw=;
	b=R3IlegPjZTUNknN36W/DiY55Po4/SuzgU3qGkj7yA3lqqO0zqEbr28szomnYRcJbIoJJhD
	R585SYNGtdZpmIAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cf2skJNV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z7IVdP38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782291825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9d7DZdLslHNPZRGZFvdtDMf5wRXMC8cZhiVMfWkhSw=;
	b=cf2skJNV60mNLUuxRnpLovr/O7KcTHvtO7bPZBnVB0NzDbme0svj7RqQ++94BOa2gIe9EH
	sXv3o3/raFT1rzOq0op0EJU5EGBWJ8DLsYp4d906vzP8gBf5f8J5TifrrpUmoUhWxqSIax
	dCgq1XP6rAc1LVJ2fdOOR0jWgFUW5H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782291825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9d7DZdLslHNPZRGZFvdtDMf5wRXMC8cZhiVMfWkhSw=;
	b=Z7IVdP38ZbUZkU/H5AlfUJchJ+FWo/QrxJc9U5xHnxDgz61VkJqx8yCTwNtTHEnouhLPoR
	bNLZziGbOgB6CfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95166779AB;
	Wed, 24 Jun 2026 09:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFgMI3GdO2o/cgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jun 2026 09:03:45 +0000
Date: Wed, 24 Jun 2026 11:03:45 +0200
Message-ID: <874iiswbri.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq: Fix uninitialised heap leak in snd_seq_event_dup()
In-Reply-To: <20260623233841.853326-1-sammiee5311@gmail.com>
References: <20260623233841.853326-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E9CBE713D7
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 24 Jun 2026 01:38:40 +0200,
HyeongJun An wrote:
> 
> snd_seq_event_dup() copies an incoming event into a pool cell and, in
> the UMP-enabled build, clears the trailing cell->ump.raw.extra word that
> the memcpy() did not cover.  The guard deciding whether to clear it
> compares the copied size against sizeof(cell->event):
> 
> 	memcpy(&cell->ump, event, size);
> 	if (size < sizeof(cell->event))
> 		cell->ump.raw.extra = 0;
> 
> For a legacy (non-UMP) event, size == sizeof(struct snd_seq_event) ==
> sizeof(cell->event), so the condition is false and the extra word keeps
> stale data.  The cell pool is allocated with kvmalloc() (not zeroed) and
> cells are reused via a free list, so that word holds uninitialised heap
> or leftover event data.
> 
> When such a cell is delivered to a UMP client (client->midi_version > 0)
> that set SNDRV_SEQ_FILTER_NO_CONVERT -- so the legacy event reaches it
> unconverted -- snd_seq_read() reads it out as the larger struct
> snd_seq_ump_event and copies the stale word to user space, a 4-byte
> kernel heap infoleak to an unprivileged /dev/snd/seq client.
> 
> Compare against sizeof(cell->ump) instead, so the trailing word is zeroed
> for every event shorter than the UMP cell.
> 
> Fixes: 46397622a3fa ("ALSA: seq: Add UMP support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi

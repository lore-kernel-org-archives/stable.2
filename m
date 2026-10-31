Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462650;
	b=SNzRTXTBKmubGiWyYv9bPdDQOW7liHFSgAfKADPw+VwqmYNnoxwFRSr7b89mvoIkRNds
	 coQ/HbG0esg5TbNNx4Vz+M1yksHcxZT+HsKMfBSCK/bduveAHxqZ4M+P6FZsiJGma3HOD
	 Pn4FJYRus9k2sj+RcluL75FEiGBwcnQQWOpyLDW7tf0lrahjRe3tym9Mqv8AzsxKoFd7b
	 0Avbm7D0qi+kFPdFd8QJdSZY0SyQvb3WMWifj0ccIPj1Bs7KKpgRNQy1eyaDPT0B6klAW
	 b5PzOunnI1lfocyLCGmCCJVbIBugafHmQpQi03iF9Pg/Uf+iyhdknR0l8g8+deQm8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462650;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=GhICUSQoONTdSUYgL0xkqNA/ezy3sBmMRMZ+1SpcnSE=;
	b=4lq25hBxgTawpwQyndFH6fgZ4/IzqZ3QNJ+f/w/06o91IHKZY0xRuFdwv8bvHVOQioRW
	 uKCff85eZ9EOa4XnMxa+mbZE6J6hS7co2MzL+1usPzNSLQavPV7JPfb8PlJTDBXIukJEw
	 bJKHlVScYMwpT0+ptOnlyqNEUxN8xfy/eYqROYM4ZrSIt4T4EjUBMEMOdehlERnWOEtnV
	 UUvbEtb88D9bjiUOUqp/7oBvGxJBxv9nGy0i0h6FHHp7MJdMxnp+Giv02dQD6vX8jy1Pz
	 ZDAPQQfEKH+l/wWmYzhBOjsWqxwhISmwyaIQbaz7K77QsQ8rjniA57up1Hdo0Fr6Wxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="cqch9/8q";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAuePgF+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="cqch9/8q";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAuePgF+;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B5606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 16:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cqch9/8q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAuePgF+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cqch9/8q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAuePgF+
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46C571F397;
	Sat, 31 Oct 2026 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhICUSQoONTdSUYgL0xkqNA/ezy3sBmMRMZ+1SpcnSE=;
	b=cqch9/8qA1uBFiBE3ZzE4BEOw2S9Q9fnb5dYNXDi+T3u2Oe8AJQknL7cB6ORdM09PAo/my
	2QTiqX6XctrgDd9FoSONL0k8qmjXwfxcJ++F+6sQQN49U6SVdZAayKC6kaYZnTK9vtZwxb
	NcFOgprcYP2JEo/J/DCSb2BN3PTu0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhICUSQoONTdSUYgL0xkqNA/ezy3sBmMRMZ+1SpcnSE=;
	b=pAuePgF+dBn3t0nHRrDMSzvupDf0144GngRVa8Y/QnSHpaa2EZ/LDL5jFgg153zVwvZena
	PS95ud4fmiblt8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cqch9/8q";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pAuePgF+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhICUSQoONTdSUYgL0xkqNA/ezy3sBmMRMZ+1SpcnSE=;
	b=cqch9/8qA1uBFiBE3ZzE4BEOw2S9Q9fnb5dYNXDi+T3u2Oe8AJQknL7cB6ORdM09PAo/my
	2QTiqX6XctrgDd9FoSONL0k8qmjXwfxcJ++F+6sQQN49U6SVdZAayKC6kaYZnTK9vtZwxb
	NcFOgprcYP2JEo/J/DCSb2BN3PTu0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhICUSQoONTdSUYgL0xkqNA/ezy3sBmMRMZ+1SpcnSE=;
	b=pAuePgF+dBn3t0nHRrDMSzvupDf0144GngRVa8Y/QnSHpaa2EZ/LDL5jFgg153zVwvZena
	PS95ud4fmiblt8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE4E013432;
	Sat, 31 Oct 2026 16:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDTQMG4R5moZMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:03:58 +0000
Date: Sat, 31 Oct 2026 17:03:58 +0100
Message-ID: <87v76hrh5d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ump: Fix dropped data bytes at UMP System message conversion
In-Reply-To: <20261029130538.1985867-1-sammiee5311@gmail.com>
References: <20261029130538.1985867-1-sammiee5311@gmail.com>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 46C571F397

On Thu, 29 Oct 2026 14:05:37 +0100,
HyeongJun An wrote:
> 
> The cvt_ump_system_to_legacy() function switches on
> ump_message_status_code(), which returns only the upper 4 bits of the
> status. The case labels are the full 0xf1, 0xf2 and 0xf3 values, so they
> never match. MIDI Time Code, Song Position and Song Select are converted
> to the status byte alone, and their data bytes are lost.
> 
> Switch on the full status byte in buf[0] instead.
> 
> Both callers of snd_ump_convert_from_ump() pass the result on as is: the
> legacy rawmidi input of a UMP endpoint, and the MIDI 1.0 path of the
> f_midi2 USB gadget.
> 
> Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
> Cc: stable@vger.kernel.org
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi

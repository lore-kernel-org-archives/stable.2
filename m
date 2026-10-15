Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60B3C8732;
	Thu, 15 Oct 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048874; cv=none; b=Q3PaUtAExtVGB0Hh7UtQdwNZFquCC91Ch96z1gUdFyRmYgT/pdurFGXsltNe/qM+k6i6rgTamQ34HAhOP18kKIquiGdN/0hgLljJA56G7Lbod9/+L0i/wNgoUuoodcXSfcMliTyxVd4AYFiitUFZQeirdb6BO2p1EyWQryF0rP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048874; c=relaxed/simple;
	bh=fMalz7ChszegOU3gjTSzlZTKB2tNJesph5f9UjPVN5w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUvVnZVsJ6Hd6x56dCu291y75pWwm5+IO/sy4MtPSuWSoNPKtuZroxSRvXJk6DghO6gexIgeXFwWer4Hh/FgMnyuE1a3tl3VLQBrX0qsL2FCjLqzhyBpMRJ3j3u1PJIl7e36ryo+bCposk5O5LR2ruxZJv6EN2+pDZCvjr2TmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gq+qLOlJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N441EOUC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVkbU+Ze; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a8WJrScp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gq+qLOlJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N441EOUC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVkbU+Ze";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a8WJrScp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE87522345;
	Thu, 15 Oct 2026 07:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792048866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7s6Co7d6enAImPeSG85d5cbok3iCwzwiZUrJ7iqyV4=;
	b=gq+qLOlJceC4ghRtXbaZMWO2R7HN92sjoeQFhn+4fjYIRJvscpgrCa6TZ376QKgyZmWi3R
	R7KRTzPM0riKbrg8XdpzU/dmgl/VojakTxQH22wcCHul6YxbcGwVrKZfdSFMLCBvwJ7I7m
	+nZW8m7xRLm8anifoblB3u5yQ5gB+OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792048866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7s6Co7d6enAImPeSG85d5cbok3iCwzwiZUrJ7iqyV4=;
	b=N441EOUCC6uCmhCZGPeX36Vn+9Q5gn1HoP/bqLj9LIZUkf2msuIHZRyjpRsgueA4utzQcu
	m5T7m+3t5CV9Z/BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GVkbU+Ze;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a8WJrScp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792048865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7s6Co7d6enAImPeSG85d5cbok3iCwzwiZUrJ7iqyV4=;
	b=GVkbU+ZeawbEZ+KAMhJYTJGbMKGVF6gysPPari+6zvZmVC6AFgb85X1QCmDg6c1Vm45ymy
	zsO+NnrKlLfF7MhM3wVPoV23Nbq+qYbZq1w6rmprNn2BDn39jkEU7tAGnTacrCQCmXe0w/
	IOh979UIs4Z8jueC9eiQ0noNC8vZqRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792048865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7s6Co7d6enAImPeSG85d5cbok3iCwzwiZUrJ7iqyV4=;
	b=a8WJrScpU/Wn6xO1zAzet8BYoG3ofQyatXsDNbbrT2FvNxwGYZ271PAR6Kitr5xYsGaBRw
	G9QXBTvmXZTyKZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 533611373D;
	Thu, 15 Oct 2026 07:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id grT6AOF+0GqIOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Oct 2026 07:21:05 +0000
Date: Thu, 15 Oct 2026 09:21:04 +0200
Message-ID: <87o6cvmntr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix quirk for HP Laptop 15-fc0xxx
In-Reply-To: <20261015065640.377466-1-zhangheng@kylinos.cn>
References: <20261015065640.377466-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: BE87522345
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, 15 Oct 2026 08:56:40 +0200,
Zhang Heng wrote:
> 
> The HP Laptop 15-fc0xxx is based on an AMD platform where the digital
> microphone is provided by the snd-soc-acp6x-mach driver, not by the
> HDA codec. The ALC236_FIXUP_HP_DMIC quirk configures pin 0x12 as an
> internal DMIC, which is a misconfiguration for this machine: the pin
> is not wired to a codec DMIC and the setting has no effect on the
> actual microphone path (which works via ACP6x).
> 
> Replace ALC236_FIXUP_HP_DMIC with
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO, the standard quirk used by the
> closely related HP Laptop 15-fd0xxx and other ALC236 HP machines. This
> removes the misleading DMIC pin config and adds proper mute LED and
> micmute LED support that was missing from the original quirk.
> 
> Fixes: 720460722310 ("ALSA: hda/realtek: add quirk for HP Laptop 15-fc0xxx")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221233
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222044
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied to for-next branch.  Thanks.


Takashi

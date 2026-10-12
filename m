Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CB49504C;
	Mon, 12 Oct 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817507; cv=none; b=H9tBrf+4MR4a140Ygt32WCi+zowFtJidcRkLxpFEy3ut0oh7Ed7m6kOPyx+GUJq9m6wiE7Ly2ikfagc0gKCDj60fEBX+Rif5jnAopuiPAbKw93abCqPy4m3zbhimRN6sDS+Uex/CxtV+JihrVEhWSdBTKnp/vly0mnbKJhOnQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817507; c=relaxed/simple;
	bh=APoFoeCcyjjVob9cG3jtYYK/fAIAW2eerUQTI1xUOoU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdfGGo1mSnNBeuJwuEShCPdwDj5PJAOcWt1kY8CxJz1uBeAdqBvlIj2pqIxtzGdagHfbLNbBG0cA5MKAiE0RnD/ssmgJfB/K8bsaEEiZomgCe3uD9jAS6Wc2+IpQ84jXX1Vjjgy+/XkTnXokHDxj2kwKkgzqpALxFJVnbhmzIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YpSa3YKZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvAnx7cb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YpSa3YKZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvAnx7cb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YpSa3YKZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvAnx7cb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YpSa3YKZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvAnx7cb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F76321EAC;
	Mon, 12 Oct 2026 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791817504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0UFnOdmom+RLOd8YdaASPQ6IXqZv5F6V2UgU/8NwTc=;
	b=YpSa3YKZZTvzcNc9sNoRpIQGy0VQVcC75ssA6qc5y5cu12CZnynQk4D8tSyG6U5lGY2sOE
	e97t9+D+9B5yXoKlFfr5uEkeui+PRh4e0xN7t6QxprW+ctIsmZ3dQgoCvJ7rwO3HoSj1j8
	UjmIS8Lfi+gdQfZoeEiU5Ji/nRYyJm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791817504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0UFnOdmom+RLOd8YdaASPQ6IXqZv5F6V2UgU/8NwTc=;
	b=EvAnx7cbHLrDQqYGKeGhFPoEj/q2yvDgoD/QtthLshLkCT1BDEExhGozERx/d7aWOv8D9z
	58465fr31+sPryDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YpSa3YKZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EvAnx7cb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791817504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0UFnOdmom+RLOd8YdaASPQ6IXqZv5F6V2UgU/8NwTc=;
	b=YpSa3YKZZTvzcNc9sNoRpIQGy0VQVcC75ssA6qc5y5cu12CZnynQk4D8tSyG6U5lGY2sOE
	e97t9+D+9B5yXoKlFfr5uEkeui+PRh4e0xN7t6QxprW+ctIsmZ3dQgoCvJ7rwO3HoSj1j8
	UjmIS8Lfi+gdQfZoeEiU5Ji/nRYyJm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791817504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0UFnOdmom+RLOd8YdaASPQ6IXqZv5F6V2UgU/8NwTc=;
	b=EvAnx7cbHLrDQqYGKeGhFPoEj/q2yvDgoD/QtthLshLkCT1BDEExhGozERx/d7aWOv8D9z
	58465fr31+sPryDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1887A13408;
	Mon, 12 Oct 2026 15:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JK6BOh/3zGqvWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Oct 2026 15:05:04 +0000
Date: Mon, 12 Oct 2026 17:05:03 +0200
Message-ID: <87cxtfgdsw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ma Ke <make_ruc2021@163.com>
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
In-Reply-To: <20261012084152.3740340-1-make_ruc2021@163.com>
References: <20261012084152.3740340-1-make_ruc2021@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F76321EAC
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Mon, 12 Oct 2026 10:41:52 +0200,
Ma Ke wrote:
> 
> cs35l41_hda_probe() takes an acpi_device through
> cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. Only the
> failures that happen later reach the err: label, which is where that
> reference and cs35l41->acpi_subsystem_id are released, so the early
> return taken when cs35l41_hda_read_acpi() fails leaves both behind.
> 
> Keep the ownership in the caller instead of dropping the reference
> inside cs35l41_hda_read_acpi(). That removes the need to work out
> whether a given failure path has already released it, and with it the
> double put that cs35l41_hda_parse_acpi() would otherwise cause when it
> fails after having released the device itself.
> 
> cs35l41_hda_parse_acpi() and the !physdev path no longer put the
> reference, and the early failure enters the existing err: cleanup tail
> through a new err_acpi label.
> 
> The label sits between the reset of the codec and the gpio cleanup, so
> an early failure also releases the reset and chip-select descriptors
> that cs35l41_hda_parse_acpi() may already have taken, while still
> skipping cs35l41_safe_reset() on a codec that was never brought up.
> 
> cs35l41->dacpi comes from devm_kzalloc() and is only assigned once the
> ACPI device has been found, so the put is a no-op when the lookup
> itself failed.
> 
> Found by code review.
> 
> Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Applied to for-next branch now.  Thanks.


Takashi

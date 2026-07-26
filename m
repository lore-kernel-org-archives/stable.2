Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F953749F6
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049187; cv=none; b=A13Jef3XSsbo/BWfoYxjTez5aaU7lyuWaxmMk+kgGc6GuNKBXlzILNqDC3WUThFkPcj44tTYL+IiR7JgTQwLWujpMT+CNaTIUEUq5Ebuf8Y8nUDceQ2tF/81KBQE/y/lCuTBbp/hLB+IaFxk1NB/s5uDwGVg5ItSuxd9nzlAuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049187; c=relaxed/simple;
	bh=WYInhjwH9K/RPgMEYkErGVYYrtQPxb6JZiDTygYAAsM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GADazsHqmMxrWICsct7q+9wrQRokciFZlSDnnQIkUVUjpzCkzbeW0klsZc0ab/RFZa+kGtVfSl4F4OvXm3HdBPgU2vE7BDqWwAgTr1S2mnAWz8eMo9/+r8CB3owKqNTHQmlbPcE28Uj8E1LCEVvZkLIodvqsUpHztcIMQKMj3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rLsalXdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2gj6agj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rLsalXdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2gj6agj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rLsalXdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2gj6agj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rLsalXdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2gj6agj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3D23EFF;
	Sun, 26 Jul 2026 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8O3NFRDgFixiWISkeAp/9n4gADTbS6O2GPwe9cFC40=;
	b=rLsalXdlJHF7BO5j/ABur2J9lZu8bKAwGcZZMSMrp0WKEg2fEgp7hjJkHWJfCrmJwRCuPO
	p+MG6nfN513+AF2Y/cXx2tFDHnv3/YsdRaAtmdbu9CVR1CupL9OJXE4Mp83fNtRrXQ5ZWs
	OPqwCOU6iJ8w1TPfLMOQ9WvNYTWqmes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8O3NFRDgFixiWISkeAp/9n4gADTbS6O2GPwe9cFC40=;
	b=E2gj6agjOOTBsh6f2nYzhGugnQbUj86BNxkFTHYPqypGpj9X7AqDDj2DOYgkpbJsifojCK
	LBZCzoreqJHJE5Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rLsalXdl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E2gj6agj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8O3NFRDgFixiWISkeAp/9n4gADTbS6O2GPwe9cFC40=;
	b=rLsalXdlJHF7BO5j/ABur2J9lZu8bKAwGcZZMSMrp0WKEg2fEgp7hjJkHWJfCrmJwRCuPO
	p+MG6nfN513+AF2Y/cXx2tFDHnv3/YsdRaAtmdbu9CVR1CupL9OJXE4Mp83fNtRrXQ5ZWs
	OPqwCOU6iJ8w1TPfLMOQ9WvNYTWqmes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8O3NFRDgFixiWISkeAp/9n4gADTbS6O2GPwe9cFC40=;
	b=E2gj6agjOOTBsh6f2nYzhGugnQbUj86BNxkFTHYPqypGpj9X7AqDDj2DOYgkpbJsifojCK
	LBZCzoreqJHJE5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E36A779B9;
	Sun, 26 Jul 2026 06:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EB/gEWCwZWrbewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 06:59:44 +0000
Date: Sun, 26 Jul 2026 08:59:43 +0200
Message-ID: <87bjbub5i8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ump: fix double free of out_cvts on rawmidi error
In-Reply-To: <20260726051633.41206-1-baul.lee@xbow.com>
References: <20260726051633.41206-1-baul.lee@xbow.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,xbow.com:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7E3D23EFF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sun, 26 Jul 2026 07:16:33 +0200,
Baul Lee wrote:
> 
> snd_ump_attach_legacy_rawmidi() allocates the legacy conversion array
> ump->out_cvts and, on the snd_rawmidi_new() error path, frees it with
> kfree() but leaves ump->out_cvts pointing at the freed memory.  When the
> endpoint is later torn down, snd_ump_endpoint_free() frees ump->out_cvts
> a second time, resulting in a double free.
> 
> The host snd-usb-audio driver attaches the legacy rawmidi for any USB
> MIDI 2.0 (UMP) device, so a device that makes snd_rawmidi_new() fail
> reaches this path on enumeration.
> 
> Clear ump->out_cvts after freeing it on the error path so it is not
> freed again during teardown.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 33cd7630782d ("ALSA: ump: Export MIDI1 / UMP conversion helpers")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
